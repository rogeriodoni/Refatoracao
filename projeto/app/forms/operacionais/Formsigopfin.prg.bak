*==============================================================================
* Formsigopfin.prg - Configuracao de Lancamentos Financeiros
*==============================================================================
* Herda de: FormBase
* BO: sigopfinBO
* Legado: SIGOPFIN.SCX (tasks/task741/sigopfin_form_codigo_fonte.txt)
* Tipo: OPERACIONAL (form PLANO sem PageFrame - todos os objetos do dump sao
*       filhos diretos de SIGOPFIN ou de cntSombra, sem Pagina.Lista/Dados)
*
* Dialogo MODAL aberto pelo cadastro de Operacoes (SigOpOpe) para configurar,
* por movimentacao, a origem dos valores a serem lancados na movimentacao
* financeira (grade de linhas sigopfin) - equivalente ao
* "Parameters pMov, pFrm" do Init legado: pMov = codigo da movimentacao
* (Dopes, FK para SigOpOpe.Dopes) e pFrm = form chamador (ParentForm), do
* qual o legado tambem le pcEscolha (INSERIR/ALTERAR/VISUALIZAR) e
* poDataMgr. Aqui par_oFormPai substitui pFrm; o modo e copiado de
* par_oFormPai.this_cModoAtual quando presente, e a conexao usa o
* gnConnHandle global (nao ha equivalente a poDataMgr).
*
* DataSession = 1 (compartilhada - igual ao default da classe base Form;
* o legado tambem declara DataSession=1, nao 2, entao nao ha necessidade do
* fix SET DATE/CENTURY da regra CLAUDE.md #9.4).
*
* Montagem (migracao multi-fase):
*   Fase 3          - DEFINE CLASS, Init/Destroy/InicializarForm, cabecalho
*                     cnt_4c_Sombra, TornarControlesVisiveis.
*   Fase 4          - cursor_4c_GrdValores (equivalente a crGrdValores do
*                     Load legado), grd_4c_Dados (grid de 1 coluna ligado
*                     a ele), cmd_4c_BtnSetaUp/cmd_4c_BtnSetaDn/
*                     cmd_4c_BtnExcluiGrd e a carga da grade:
*                     CarregarDados() (trecho do Init legado) +
*                     MontaGrade() (montagrades legado) +
*                     AjustarBotoesGrade().
*   Fase 5 parte 1  - campos de Grupo/Conta Debito/Credito das linhas
*                     Emissor e Portador (8 TextBox) + cabecalhos de
*                     coluna Debito/Credito/Grupo/Conta (uma unica vez,
*                     acima das 4 linhas).
*   Fase 6 (esta)   - parte 2 dos campos de detalhe, complementar a Fase 5
*                     (linhas Centro de Custo/Agente Cobrador - 8 TextBox -
*                     e txt_4c_CMoes/TitBans/Tipos/MovTits), mais
*                     obj_4c_GetNotas/obj_4c_GetComandos (EditBox memo) e
*                     chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS - com isto o
*                     conjunto completo de campos do dump (layout.json)
*                     esta no form - E os
*                     LOOKUPS dos 19 campos que tem Valid de busca no dump
*                     (8 Grupo + 8 Conta + CMoes + TitBans + MovTits),
*                     ligados por BINDEVENT em ConfigurarEventosLookup(),
*                     mais o lookup da CELULA da grade (coluna Origem dos
*                     Valores), que mora na classe
*                     TextBoxOrigemSigOpFin_4c instalada pelo
*                     InstalarCelulaOrigem().
*   Fase 7 (esta)   - eventos dos botoes de manutencao da grade
*                     (BtnSetaUpClick/BtnSetaDnClick/BtnExcluiGrdClick,
*                     ligados por BINDEVENT em
*                     ConfigurarEventosBotoesGrade()), AfterRowColChange()
*                     da grade (refresh dos campos de detalhe + ToolTipText
*                     de Grupo/Conta/TitBans/CMoes via
*                     ObterDescricaoPorCodigo(), tambem chamado ao final de
*                     MontaGrade()), AvancarLinhaGradeOrigem() (parte de
*                     navegacao do LostFocus da celula da grade) e o
*                     dirty-tracking GotFocus/LostFocus (This.Tag <->
*                     This.Value, ConfigurarEventosDirtyTracking()) que o
*                     legado usa para marcar plAlterou (aqui
*                     this_lAlterou), consumido no Click de Sair da Fase 8.
*   Fase 8 (esta)   - cmd_4c_Sair (equivalente ao botao Sair/OK do legado,
*                     dump linhas 465-475: Picture=cadastro_salvar_60.jpg,
*                     Cancel=.T., Caption="\<OK" - fecha-o grava, por isso o
*                     icone eh de salvar e nao de saida) e o Click dele
*                     (BtnSairClick), que reproduz literalmente o
*                     SIGOPFIN.Sair.Click do legado (dump linhas 1606-1732):
*                     ValidarGradeValores() (validacao linha a linha da
*                     grade, so quando EmModoEdicao() e this_lAlterou -
*                     equivalente ao "Select ... Into Cursor LocalSair" +
*                     "Scan While Empty(lcMsg)"), GravarDados() (equivalente
*                     ao PROCEDURE gravardados do legado: em ALTERAR, DELETE
*                     de todas as linhas antigas de sigopfin por este Dopes
*                     e reinsercao completa via sigopfinBO.Inserir() por
*                     linha, renumerando Ordem) e
*                     AtualizarConfigFinanceiraOperacao() (equivalente ao
*                     "Replace CfgFinancs ... In crSigCdOpe" do fim do
*                     gravardados legado - grava os 2 CheckBox nos 2
*                     primeiros caracteres da coluna SigCdOpe.cfgfinancs
*                     char(20), preservando os 18 restantes). Consolidacao
*                     final do form.
*
* Nomes de objeto conforme tasks/task741/mapeamento.json.
*==============================================================================

DEFINE CLASS Formsigopfin AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGOPFIN.SCX: DataSession=1, BorderStyle=2,
    * Height=600, Width=1000, ShowTips=.T., AutoCenter=.T., ControlBox=.F.,
    * MaxButton=.F., Movable=.F., ClipControls=.F., TitleBar=0, WindowType=1 -
    * dump de sigopfin_form_codigo_fonte.txt, linhas 338-358). Closable e
    * MinButton NAO constam do dump - nao inventar (feedback
    * Closable_inventado_tira_a_unica_saida).
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Movable      = .F.
    MaxButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Configura" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + "amentos Financeiros"

    *--------------------------------------------------------------------------
    * Movimentacao recebida na abertura - equivalente a ThisForm.Dopes do
    * legado (crGrdValores.Dopes char(20) - mesmo padding usado no BO).
    *--------------------------------------------------------------------------
    this_cDopes = SPACE(20)

    *--------------------------------------------------------------------------
    * Form chamador - equivalente a ThisForm.ParentForm do legado. Usado
    * tambem para copiar o modo (this_cModoAtual) e para habilitar/
    * desabilitar o form pai ao abrir/fechar este modal (equivalente a
    * ParentForm.Enabled = .f./.t. do Init/Release legado).
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Sinaliza se o usuario alterou a grade de configuracoes - equivalente a
    * ThisForm.plAlterou do legado. Consultado no Fase 8 (Click de
    * cmd_4c_Sair) para decidir se valida a grade antes de encerrar.
    *--------------------------------------------------------------------------
    this_lAlterou = .F.

    *--------------------------------------------------------------------------
    * Guarda de reentrancia dos lookups. Os pickers sao MODAIS: abrir um a
    * partir do LostFocus de um campo tira o foco e redispara o proprio
    * LostFocus, empilhando um segundo dialogo. A flag e ligada no FUNIL de
    * cada lookup (AbrirLookup*), que cobre as tres entradas - LostFocus,
    * F4/F5 e duplo clique - e liberada pelo wrapper, nunca pelo corpo:
    * corpo com saida antecipada deixaria a flag ligada para sempre e mataria
    * o lookup pelo resto da vida do form (regra CLAUDE.md #47).
    *--------------------------------------------------------------------------
    this_lEmLookup = .F.

    *--------------------------------------------------------------------------
    * Init - recebe o codigo da movimentacao e o form chamador (equivalente
    * a "Parameters pMov, pFrm" do legado) e cria o Business Object ANTES do
    * DODEFAULT(), para que InicializarForm() (chamado por FormBase.Init()
    * via DODEFAULT) ja o encontre pronto. O Caption e ajustado ANTES do
    * DODEFAULT() porque ConfigurarCabecalho() (chamado dentro do
    * DODEFAULT) usa THIS.Caption para montar o titulo da faixa.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cDopes, par_oFormPai
        LOCAL loc_lSucesso, loc_lParametrosOk, loc_oErro, loc_lBypassParametros
        loc_lSucesso = .F.
        loc_lParametrosOk = .T.

        *-- Bypass da validacao de parametros obrigatorios em modo teste/
        *-- validacao de UI: o harness (TestFormWrapper, etapa 06_testForm)
        *-- faz CREATEOBJECT(par_cFormClass) SEM argumentos - sem este
        *-- bypass, PCOUNT() < 1 sempre dispara MsgErro e loc_lParametrosOk
        *-- fica .F., Init() devolve .F. e CREATEOBJECT retorna NULL antes
        *-- de qualquer outra verificacao (regra: nenhum form OPERACIONAL
        *-- com parametro obrigatorio pode reprovar so por ser instanciado
        *-- sem argumento pelo harness - mesmo padrao de
        *-- ValidarParametros() em FormSigPrPpc/FormSIGMVCTH e de
        *-- FormSIGOPCCO, que aceita par_oFormPai ausente por default).
        loc_lBypassParametros = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        TRY
            IF !loc_lBypassParametros
                IF PCOUNT() < 1 OR VARTYPE(par_cDopes) != "C" OR EMPTY(par_cDopes)
                    MsgErro("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                        "o informada (par_cDopes).", "Parametros Invalidos")
                    loc_lParametrosOk = .F.
                ENDIF

                IF loc_lParametrosOk AND (PCOUNT() < 2 OR VARTYPE(par_oFormPai) != "O")
                    MsgErro("Formul" + CHR(225) + "rio chamador n" + CHR(227) + ;
                        "o informado (par_oFormPai).", "Parametros Invalidos")
                    loc_lParametrosOk = .F.
                ENDIF
            ENDIF

            IF loc_lParametrosOk
                IF VARTYPE(par_cDopes) = "C" AND !EMPTY(par_cDopes)
                    THIS.this_cDopes = PADR(ALLTRIM(par_cDopes), 20)
                ENDIF
                THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)

                IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                        PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5) AND ;
                        !EMPTY(THIS.this_oFormPai.this_cModoAtual)
                    THIS.this_cModoAtual = THIS.this_oFormPai.this_cModoAtual
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cDopes))
                    THIS.Caption = ALLTRIM(THIS.Caption) + " - " + ALLTRIM(THIS.this_cDopes)
                ENDIF

                THIS.this_oBusinessObject = CREATEOBJECT("sigopfinBO")

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_lSucesso = DODEFAULT()

                    IF loc_lSucesso AND VARTYPE(THIS.this_oFormPai) = "O"
                        THIS.this_oFormPai.Enabled = .F.
                    ENDIF
                ELSE
                    MsgErro("Falha ao criar sigopfinBO.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Configura" + CHR(231) + CHR(227) + "o de Lan" + ;
                CHR(231) + "amentos Financeiros: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form chamador (equivalente a
    * ThisForm.ParentForm.Enabled = .t. do Release legado) e encadeia para
    * FormBase.Destroy() (libera this_oBusinessObject e restaura o menu
    * principal). this_oFormPai NAO e liberado aqui - pertence a quem criou.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar Formsigopfin")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo,
    * cabecalho e grade+botoes de reordenacao nesta fase; campos/memos/
    * checkboxes nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("sigopfinBO n" + CHR(227) + "o foi inicializado.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                THIS.CriarCursorGrdValores()

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da grade e visibilidade dos botoes de manutencao
                *-- (equivalente ao fim do Init legado). Vem DEPOIS de
                *-- TornarControlesVisiveis(), que forca Visible = .T. em tudo
                *-- e apagaria o ajuste de AjustarBotoesGrade() se viesse antes.
                THIS.CarregarDados()
                THIS.AjustarBotoesGrade()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopfin.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGOPFIN nao
    * tem PageFrame no legado (layout flat: cntSombra + grid + campos +
    * memos + checkboxes + botoes direto no form) - o nome do metodo e
    * mantido apenas como ponto de entrada arquitetural padrao (mesmo papel
    * em FormSigPrIbb/FormSigPrGst/FormSigPrGmi).
    *
    * Fase 3          - ConfigurarCabecalho() (cnt_4c_Sombra).
    * Fase 4          - ConfigurarGrid() (grd_4c_Dados + cmd_4c_BtnSetaUp/
    *                   BtnSetaDn/BtnExcluiGrd).
    * Fase 5 parte 1  - ConfigurarCamposGrupoContaEmissorPortador() (linhas
    *                   Emissor/Portador).
    * Fase 6 (esta)   - ConfigurarCamposCentroCustoAgenteCobrador() (parte 2
    *                   complementar a Fase 5: linhas Centro de Custo/Agente
    *                   Cobrador) + ConfigurarCamposComplementares()
    *                   (txt_4c_CMoes/TitBans/Tipos/MovTits) +
    *                   ConfigurarMemosEcheckboxes() (obj_4c_GetNotas/
    *                   obj_4c_GetComandos e os 2 CheckBox) +
    *                   ConfigurarEventosLookup() (BINDEVENT dos 19 campos
    *                   com lookup). A celula de lookup da grade e instalada
    *                   por InstalarCelulaOrigem(), chamado de
    *                   ConfigurarGrid() e de MontaGrade().
    * Fase 7          - eventos dos botoes de manutencao da grade,
    *                   AfterRowColChange e dirty-tracking (plAlterou).
    * Fase 8 (esta)   - ConfigurarSaida() (cmd_4c_Sair); o BINDEVENT do Click
    *                   dele entra em ConfigurarEventosBotoesGrade(), junto
    *                   com os outros 3 botoes de botao-unico do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCamposGrupoContaEmissorPortador()
        THIS.ConfigurarCamposCentroCustoAgenteCobrador()
        THIS.ConfigurarCamposComplementares()
        THIS.ConfigurarMemosEcheckboxes()
        THIS.ConfigurarSaida()
        THIS.ConfigurarEventosLookup()
        THIS.ConfigurarEventosBotoesGrade()
        THIS.ConfigurarEventosDirtyTracking()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSaida - cmd_4c_Sair, equivalente ao SIGOPFIN.Sair do legado
    * (dump linhas 465-475). O icone eh o de SALVAR (cadastro_salvar_60.jpg),
    * nao o de sair - fiel ao legado: o Click deste botao grava a grade antes
    * de fechar o dialogo (regra CLAUDE.md #25 - FormBAL "Fecha" usa o mesmo
    * icone de salvar pelo mesmo motivo). Width/Height=75 (canonico do
    * projeto para CommandButton com Picture) nao constam do dump; Left=925
    * do dump + Width=75 fecha exatamente nos 1000px do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSaida()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            WITH THIS.cmd_4c_Sair
                .Top             = 3
                .Left            = 925
                .Width           = 75
                .Height          = 75
                .Caption         = "\<OK"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .TabIndex        = 46
                .ToolTipText     = "Retornar Para a Tela Anterior"
                .Visible         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarSaida")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original (dump legado): cntSombra Top=0, Left=0, Width=1100, Height=80,
    * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 1100 do dump (que extrapola o Width=1000
    * do proprio form).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorGrdValores - cria o cursor local equivalente a crGrdValores
    * (CREATE CURSOR do Load legado, dump de sigopfin_form_codigo_fonte.txt
    * linhas 1556-1564): uma linha por origem de valores configurada para a
    * movimentacao (this_cDopes). A Fase 7/8 preenche o cursor (equivalente
    * ao Scan de crSigOpFin do Init legado) e grava via sigopfinBO.Inserir/
    * Atualizar (uma linha por vez). Ordem eh a chave de reordenacao (regra
    * CLAUDE.md "CREATE CURSOR: ordem dos campos IDENTICA em todo lugar que
    * recriar este cursor" - aqui so existe esta declaracao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorGrdValores()
        IF !USED("cursor_4c_GrdValores")
            SET NULL ON
            CREATE CURSOR cursor_4c_GrdValores ;
                (Ordem N(3), Codigos C(10), Descrs C(100), Dopes C(20), ;
                 Notas M, Comandos M, Moedas C(3), Tipos C(1), TitBans C(12), ;
                 UsuIncs C(10), MovTits C(20), DatIncs T, UsuAlts C(10), ;
                 DatAlts T, GrupoEDs C(11), ContaEDs C(11), GrupoECs C(11), ;
                 ContaECs C(11), GrupoPDs C(11), ContaPDs C(11), GrupoPCs C(11), ;
                 ContaPCs C(11), GrupoCDs C(11), ContaCDs C(11), GrupoCCs C(11), ;
                 ContaCCs C(11), GrupoADs C(11), ContaADs C(11), GrupoACs C(11), ;
                 ContaACs C(11))
            SET NULL OFF
            INDEX ON Ordem TAG Ordem
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados (equivalente a grdValores, dump linhas
    * 999-1023: ColumnCount=1, Column1.Width=700, Header1.Caption = titulo da
    * grade) + os 3 botoes de navegacao/exclusao de linha (btnSetaUp/
    * btnSetaDn/btnExcluiGrd, dump linhas 1277-1309 - mesmo Left=739, Top
    * escalonado de 40 em 40). O Click dos botoes fica para a
    * Fase 7; aqui a montagem visual, o grid ja ligado ao
    * cursor_4c_GrdValores criado em CriarCursorGrdValores(), e a celula de
    * lookup da coluna Origem instalada por InstalarCelulaOrigem().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrd, loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = THIS.grd_4c_Dados

            WITH loc_oGrd
                .Top               = 90
                .Left              = 12
                .Width             = 721
                .Height            = 198
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 16
                .ScrollBars        = 2
                .Highlight         = .T.
                .HighlightStyle    = 2
                .TabIndex          = 1
                .ColumnCount       = 1
                .RecordSource      = "cursor_4c_GrdValores"

                .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
                .Column1.Width             = 700
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
                    CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
                .Column1.Header1.Alignment = 2
                .Column1.Header1.FontBold  = .F.

                .Visible = .T.
            ENDWITH

            *-- Celula de lookup da coluna Origem (TextBoxOrigemSigOpFin_4c).
            *-- Vem DEPOIS do ENDWITH que fixa ColumnCount/RecordSource:
            *-- atribuir ColumnCount recria os objetos Column e destruiria o
            *-- controle instalado aqui.
            THIS.InstalarCelulaOrigem()

            THIS.AddObject("cmd_4c_BtnSetaUp", "CommandButton")
            WITH THIS.cmd_4c_BtnSetaUp
                .Caption         = ""
                .Top             = 90
                .Left            = 739
                .Width           = 40
                .Height          = 40
                .Picture         = gc_4c_CaminhoIcones + "cadastro_seta_cima_20.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_seta_cima_20.jpg"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .TabIndex        = 2
                .ToolTipText     = "Mover Linha da Grade Uma Posi" + CHR(231) + CHR(227) + "o Para Cima"
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnSetaDn", "CommandButton")
            WITH THIS.cmd_4c_BtnSetaDn
                .Caption         = ""
                .Top             = 130
                .Left            = 739
                .Width           = 40
                .Height          = 40
                .Picture         = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .TabIndex        = 3
                .ToolTipText     = "Mover Linha da Grade Uma Posi" + CHR(231) + CHR(227) + "o Para Baixo"
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnExcluiGrd", "CommandButton")
            WITH THIS.cmd_4c_BtnExcluiGrd
                .Caption         = ""
                .Top             = 170
                .Left            = 739
                .Width           = 40
                .Height          = 40
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .TabIndex        = 4
                .ToolTipText     = "Excluir a Linha Selecionada na Grade"
                .Visible         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoesGrade - BINDEVENT dos 3 botoes de manutencao da
    * grade (Click), do AfterRowColChange do proprio grid (Fase 7) e do
    * cmd_4c_Sair (Fase 8 - equivalente ao SIGOPFIN.Sair.Click do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoesGrade()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
                BINDEVENT(THIS.cmd_4c_BtnSetaUp, "Click", THIS, "BtnSetaUpClick")
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
                BINDEVENT(THIS.cmd_4c_BtnSetaDn, "Click", THIS, "BtnSetaDnClick")
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
                BINDEVENT(THIS.cmd_4c_BtnExcluiGrd, "Click", THIS, "BtnExcluiGrdClick")
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "AfterRowColChange")
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
                BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarEventosBotoesGrade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSetaUpClick - equivalente a btnSetaUp.Click do legado: troca a Ordem
    * da linha corrente com a anterior. PUBLIC por exigencia do BINDEVENT
    * (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSetaUpClick()
        LOCAL loc_nAtu, loc_oErro

        TRY
            IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
                    AND cursor_4c_GrdValores.Ordem > 1 ;
                    AND !EMPTY(cursor_4c_GrdValores.Codigos)
                THIS.LockScreen = .T.
                loc_nAtu = cursor_4c_GrdValores.Ordem

                REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
                UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu - 1
                UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu - 1 WHERE Ordem = 999
                UPDATE cursor_4c_GrdValores SET Ordem = Ordem + 1 WHERE Ordem > loc_nAtu

                =SEEK(loc_nAtu - 1, "cursor_4c_GrdValores")

                THIS.LockScreen    = .F.
                THIS.this_lAlterou = .T.
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSetaUpClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSetaDnClick - equivalente a btnSetaDn.Click do legado: troca a Ordem
    * da linha corrente com a seguinte.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSetaDnClick()
        LOCAL loc_nAtu, loc_oErro

        TRY
            IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
                    AND cursor_4c_GrdValores.Ordem > 1 ;
                    AND !EMPTY(cursor_4c_GrdValores.Codigos)
                THIS.LockScreen = .T.
                loc_nAtu = cursor_4c_GrdValores.Ordem

                REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
                UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu + 1
                UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu + 1 WHERE Ordem = 999

                =SEEK(loc_nAtu + 1, "cursor_4c_GrdValores")

                THIS.LockScreen    = .F.
                THIS.this_lAlterou = .T.
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSetaDnClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluiGrdClick - equivalente a btnExcluiGrd.Click do legado: pede
    * confirmacao e exclui a linha corrente, renumerando a Ordem das
    * seguintes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluiGrdClick()
        LOCAL loc_nAtu, loc_oErro

        TRY
            IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
                    AND cursor_4c_GrdValores.Ordem > 0
                IF MsgConfirma("Confirma a Exclus" + CHR(227) + "o da Linha " + ;
                        "Selecionada na Grade?", "Exclus" + CHR(227) + "o de " + ;
                        "Lan" + CHR(231) + "amento")
                    THIS.LockScreen = .T.
                    loc_nAtu = cursor_4c_GrdValores.Ordem

                    DELETE IN cursor_4c_GrdValores
                    UPDATE cursor_4c_GrdValores SET Ordem = Ordem - 1 WHERE Ordem > loc_nAtu

                    =SEEK(loc_nAtu, "cursor_4c_GrdValores")

                    THIS.LockScreen    = .F.
                    THIS.this_lAlterou = .T.
                ENDIF
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluiGrdClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AfterRowColChange - equivalente ao AfterRowColChange de grdValores no
    * legado (dump linhas 2484-2530): repinta os campos de detalhe da linha
    * corrente (ja ligados por ControlSource direto a cursor_4c_GrdValores,
    * que nao repintam sozinhos ao trocar de linha no grid) e recalcula o
    * ToolTipText de Grupo/Conta/TitBans/CMoes. PUBLIC por exigencia do
    * BINDEVENT (regra CLAUDE.md #3); tambem chamado diretamente por
    * MontaGrade() apos a carga inicial.
    *--------------------------------------------------------------------------
    PROCEDURE AfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
                THIS.txt_4c_GrupoEDs.Refresh()
                THIS.txt_4c_ContaEDs.Refresh()
                THIS.txt_4c_GrupoECs.Refresh()
                THIS.txt_4c_ContaECs.Refresh()
                THIS.txt_4c_GrupoPDs.Refresh()
                THIS.txt_4c_ContaPDs.Refresh()
                THIS.txt_4c_GrupoPCs.Refresh()
                THIS.txt_4c_ContaPCs.Refresh()

                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoEDs", "txt_4c_ContaEDs")
                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoECs", "txt_4c_ContaECs")
                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoPDs", "txt_4c_ContaPDs")
                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoPCs", "txt_4c_ContaPCs")
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
                THIS.txt_4c_GrupoCDs.Refresh()
                THIS.txt_4c_ContaCDs.Refresh()
                THIS.txt_4c_GrupoCCs.Refresh()
                THIS.txt_4c_ContaCCs.Refresh()
                THIS.txt_4c_GrupoADs.Refresh()
                THIS.txt_4c_ContaADs.Refresh()
                THIS.txt_4c_GrupoACs.Refresh()
                THIS.txt_4c_ContaACs.Refresh()

                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoCDs", "txt_4c_ContaCDs")
                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoCCs", "txt_4c_ContaCCs")
                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoADs", "txt_4c_ContaADs")
                THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoACs", "txt_4c_ContaACs")
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_TitBans", 5)
                THIS.txt_4c_TitBans.Refresh()
                THIS.txt_4c_MovTits.Refresh()
                THIS.txt_4c_CMoes.Refresh()
                THIS.txt_4c_Tipos.Refresh()

                THIS.AtualizarTooltipTitBans()
                THIS.AtualizarTooltipMoeda()
            ENDIF

            IF PEMSTATUS(THIS, "obj_4c_GetComandos", 5)
                THIS.obj_4c_GetComandos.Refresh()
                THIS.obj_4c_GetNotas.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTooltipGrupoConta - ToolTipText dos pares Grupo/Conta de uma
    * linha de detalhe (Emissor/Portador/Centro de Custo/Agente Cobrador).
    * Legado: "Seek(Padr(Value,10), [crLstCdGcr|crLstCdCli], [Codigos])" -
    * crLstCdGcr/crLstCdCli eram cursores locais montados por
    * fSigOpFin_Tabs() (fora do acervo); aqui a descricao vem direto das
    * tabelas reais (SigCdGcr/SigCdCli), ja usadas pelos pickers desses
    * mesmos campos (AbrirLookupGrupoExec/AbrirLookupContaExec).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTooltipGrupoConta(par_cCampoGrupo, par_cCampoConta)
        LOCAL loc_oGrupo, loc_oConta, loc_cCodigo, loc_cDescricao

        IF PEMSTATUS(THIS, par_cCampoGrupo, 5)
            loc_oGrupo = EVALUATE("THIS." + par_cCampoGrupo)
            loc_oGrupo.ToolTipText = "Campo Em Branco"
            loc_cCodigo = LEFT(ALLTRIM(TRANSFORM(loc_oGrupo.Value)), 10)
            IF !EMPTY(loc_cCodigo)
                loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdGcr", "codigos", "descrs", loc_cCodigo)
                IF !EMPTY(loc_cDescricao)
                    loc_oGrupo.ToolTipText = loc_cDescricao
                ENDIF
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, par_cCampoConta, 5)
            loc_oConta = EVALUATE("THIS." + par_cCampoConta)
            loc_oConta.ToolTipText = "Campo Em Branco"
            loc_cCodigo = LEFT(ALLTRIM(TRANSFORM(loc_oConta.Value)), 10)
            IF !EMPTY(loc_cCodigo)
                loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdCli", "iclis", "rclis", loc_cCodigo)
                IF !EMPTY(loc_cDescricao)
                    loc_oConta.ToolTipText = loc_cDescricao
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTooltipTitBans - ToolTipText do Titulo Banco. Legado:
    * "Seek(Padr(Value,12), [crLstTitBc], [Codigos])" - crLstTitBc e o mesmo
    * cursor local sem equivalente no acervo (regra ja documentada em
    * AbrirLookupTituloBancoExec). Sem MsgAviso aqui: no legado este trecho
    * tambem e silencioso quando nao acha - so o tooltip fica no default.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTooltipTitBans()
        LOCAL loc_oTxt, loc_cValor

        IF PEMSTATUS(THIS, "txt_4c_TitBans", 5)
            loc_oTxt = THIS.txt_4c_TitBans
            loc_oTxt.ToolTipText = "Campo Em Branco"
            loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 12)

            IF !EMPTY(loc_cValor) AND THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
                SELECT crLstTitBc
                GO TOP IN crLstTitBc
                LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == UPPER(loc_cValor)
                IF !EOF("crLstTitBc")
                    loc_oTxt.ToolTipText = ALLTRIM(TratarNulo(crLstTitBc.Descrs, ""))
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTooltipMoeda - ToolTipText da Moeda de Conversao. Legado:
    * "Seek(Padr(Value,3), [crLstMoeda], [Codigos])" - tabela real SigCdMoe
    * (cmoes/dmoes), ja usada por AbrirLookupMoedaExec.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTooltipMoeda()
        LOCAL loc_oTxt, loc_cValor, loc_cDescricao

        IF PEMSTATUS(THIS, "txt_4c_CMoes", 5)
            loc_oTxt = THIS.txt_4c_CMoes
            loc_oTxt.ToolTipText = "Campo Em Branco"
            loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 3)

            IF !EMPTY(loc_cValor)
                loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdMoe", "cmoes", "dmoes", loc_cValor)
                IF !EMPTY(loc_cDescricao)
                    loc_oTxt.ToolTipText = loc_cDescricao
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoPorCodigo - SELECT TOP 1 pontual para ToolTipText (nao ha
    * cursor local cacheado para Grupo/Conta/Moeda, como havia no legado via
    * fSigOpFin_Tabs). Sem conexao (modo de teste/validacao de UI) devolve
    * "" em silencio - o ToolTipText fica no default "Campo Em Branco".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterDescricaoPorCodigo(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cValor)
        LOCAL loc_cDescricao, loc_cSQL, loc_nResultado, loc_cCursorTmp
        loc_cDescricao = ""
        loc_cCursorTmp = "cursor_4c_TooltipTmp"

        IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor)) ;
                AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 ;
                AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
            THIS.FecharCursorTemporario(loc_cCursorTmp)

            loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
                " WHERE " + par_cCampoCod + " = " + EscaparSQL(ALLTRIM(par_cValor))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

            IF loc_nResultado > 0 AND USED(loc_cCursorTmp) AND RECCOUNT(loc_cCursorTmp) > 0
                loc_cDescricao = ALLTRIM(TratarNulo( ;
                    EVALUATE(loc_cCursorTmp + "." + par_cCampoDesc), ""))
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursorTmp)
        ENDIF

        RETURN loc_cDescricao
    ENDFUNC


    *--------------------------------------------------------------------------
    * ConfigurarCamposGrupoContaEmissorPortador - campos de detalhe da linha
    * corrente da grade (equivalente aos 16 getGrupo<X><D|C>s/getConta<X><D|C>s
    * do legado, dump linhas 492-610, onde <X> = E/P/C/A para Emissor/
    * Portador/Centro de Custo/Agente Cobrador e <D|C> = Debito/Credito).
    *
    * PARTE 1 (esta fase): linhas Emissor e Portador (8 TextBox) + os
    * cabecalhos de coluna Say14/Say15 (Debito/Credito) e Say5/Say6/Say7/
    * Say8 (Grupo/Conta), que no dump aparecem uma UNICA vez, acima das 4
    * linhas - por isso entram aqui e nao se repetem na Parte 2.
    *
    * Cada TextBox e ligado via ControlSource direto a
    * cursor_4c_GrdValores.<Campo> (mesmo padrao do montagrades legado -
    * ThisForm.getGrupoEDs.ControlSource = [crGrdValores.GrupoEDs] - dump em
    * comportamento.json, metodo "SIGOPFIN.Procedure"): como o TextBox fica
    * FORA do grid mas ligado ao MESMO alias, ele reflete e edita a mesma
    * linha corrente que o grid exibe (mestre-detalhe por cursor compartilhado,
    * nao FormParaBO/BOParaForm). O religamento e repetido em MontaGrade()
    * (ver comentario la) para o caso de o cursor ser recriado.
    *
    * Nomes de objeto: o mapeamento.json colide "txt_4c_Grupo" para TODOS os
    * getGrupo<X><D|C>s (06 controles diferentes gerando o mesmo nome) -
    * usar esse nome causaria "object already exists" a cada AddObject
    * seguinte. Usa-se aqui o nome com o sufixo completo do legado
    * (txt_4c_GrupoEDs, txt_4c_ContaEDs, ...), unico por controle.
    *
    * MaxLength = 11 vem do schema (grupoeds/contaeds/... char(11) - ver
    * comentarios de sigopfinBO.prg), nao do Width em pixels (regra #19).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposGrupoContaEmissorPortador()
        LOCAL loc_oErro

        TRY
            *-- Cabecalhos de coluna - uma unica vez, acima das 4 linhas.
            THIS.AddObject("lbl_4c_Label14", "Label")
            WITH THIS.lbl_4c_Label14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 454
                .Left      = 184
                .Width     = 60
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "D" + CHR(233) + "bito [D]"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label15", "Label")
            WITH THIS.lbl_4c_Label15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 454
                .Left      = 362
                .Width     = 63
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Cr" + CHR(233) + "dito [C]"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 473
                .Left      = 158
                .Width     = 36
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 473
                .Left      = 239
                .Width     = 35
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 473
                .Left      = 329
                .Width     = 36
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label8", "Label")
            WITH THIS.lbl_4c_Label8
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 473
                .Left      = 410
                .Width     = 35
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta"
                .Visible   = .T.
            ENDWITH

            *-- Rotulos de linha (dump: Say4 "\<Emissor", Say9 "Portador" -
            *-- o marcador \< de atalho do legado nao se aplica a Label no
            *-- VFP9, so o texto e transcrito).
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 492
                .Left      = 75
                .Width     = 46
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Emissor"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label9", "Label")
            WITH THIS.lbl_4c_Label9
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 517
                .Left      = 70
                .Width     = 52
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Portador"
                .Visible   = .T.
            ENDWITH

            *-- Linha Emissor (dump: getGrupoEDs/getContaEDs/getGrupoECs/
            *-- getContaECs, Top=488).
            THIS.AddObject("txt_4c_GrupoEDs", "TextBox")
            WITH THIS.txt_4c_GrupoEDs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 488
                .Left          = 139
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 5
                .ControlSource = "cursor_4c_GrdValores.GrupoEDs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaEDs", "TextBox")
            WITH THIS.txt_4c_ContaEDs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 488
                .Left          = 220
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 6
                .ControlSource = "cursor_4c_GrdValores.ContaEDs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GrupoECs", "TextBox")
            WITH THIS.txt_4c_GrupoECs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 488
                .Left          = 310
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 7
                .ControlSource = "cursor_4c_GrdValores.GrupoECs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaECs", "TextBox")
            WITH THIS.txt_4c_ContaECs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 488
                .Left          = 391
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 8
                .ControlSource = "cursor_4c_GrdValores.ContaECs"
                .Visible       = .T.
            ENDWITH

            *-- Linha Portador (dump: getGrupoPDs/getContaPDs/getGrupoPCs/
            *-- getContaPCs, Top=513).
            THIS.AddObject("txt_4c_GrupoPDs", "TextBox")
            WITH THIS.txt_4c_GrupoPDs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 513
                .Left          = 139
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 9
                .ControlSource = "cursor_4c_GrdValores.GrupoPDs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaPDs", "TextBox")
            WITH THIS.txt_4c_ContaPDs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 513
                .Left          = 220
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 10
                .ControlSource = "cursor_4c_GrdValores.ContaPDs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GrupoPCs", "TextBox")
            WITH THIS.txt_4c_GrupoPCs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 513
                .Left          = 310
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 11
                .ControlSource = "cursor_4c_GrdValores.GrupoPCs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaPCs", "TextBox")
            WITH THIS.txt_4c_ContaPCs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 513
                .Left          = 391
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 12
                .ControlSource = "cursor_4c_GrdValores.ContaPCs"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarCamposGrupoContaEmissorPortador")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposCentroCustoAgenteCobrador - parte 2 (complementar a
    * Fase 5) dos campos de detalhe da linha corrente da grade: linhas Centro de
    * Custo (getGrupoCDs/getContaCDs/getGrupoCCs/getContaCCs, dump Top=538) e
    * Agente Cobrador (getGrupoADs/getContaADs/getGrupoACs/getContaACs, dump
    * Top=563), com os mesmos Left escalonados (139/220/310/391) e o mesmo
    * padrao de ligacao direta a cursor_4c_GrdValores.<Campo> das linhas
    * Emissor/Portador (ConfigurarCamposGrupoContaEmissorPortador).
    *
    * MaxLength = 11 vem do schema (grupocds/contacds/.../contaacs char(11),
    * mesma largura das colunas de Emissor/Portador), nao do Width em pixels.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposCentroCustoAgenteCobrador()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label10", "Label")
            WITH THIS.lbl_4c_Label10
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 542
                .Left      = 24
                .Width     = 92
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Centro de Custo"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label11", "Label")
            WITH THIS.lbl_4c_Label11
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 567
                .Left      = 17
                .Width     = 98
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Agente Cobrador"
                .Visible   = .T.
            ENDWITH

            *-- Linha Centro de Custo (dump: getGrupoCDs/getContaCDs/
            *-- getGrupoCCs/getContaCCs, Top=538).
            THIS.AddObject("txt_4c_GrupoCDs", "TextBox")
            WITH THIS.txt_4c_GrupoCDs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 538
                .Left          = 139
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 13
                .ControlSource = "cursor_4c_GrdValores.GrupoCDs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaCDs", "TextBox")
            WITH THIS.txt_4c_ContaCDs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 538
                .Left          = 220
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 14
                .ControlSource = "cursor_4c_GrdValores.ContaCDs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GrupoCCs", "TextBox")
            WITH THIS.txt_4c_GrupoCCs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 538
                .Left          = 310
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 15
                .ControlSource = "cursor_4c_GrdValores.GrupoCCs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaCCs", "TextBox")
            WITH THIS.txt_4c_ContaCCs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 538
                .Left          = 391
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 16
                .ControlSource = "cursor_4c_GrdValores.ContaCCs"
                .Visible       = .T.
            ENDWITH

            *-- Linha Agente Cobrador (dump: getGrupoADs/getContaADs/
            *-- getGrupoACs/getContaACs, Top=563).
            THIS.AddObject("txt_4c_GrupoADs", "TextBox")
            WITH THIS.txt_4c_GrupoADs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 563
                .Left          = 139
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 17
                .ControlSource = "cursor_4c_GrdValores.GrupoADs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaADs", "TextBox")
            WITH THIS.txt_4c_ContaADs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 563
                .Left          = 220
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 18
                .ControlSource = "cursor_4c_GrdValores.ContaADs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GrupoACs", "TextBox")
            WITH THIS.txt_4c_GrupoACs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 563
                .Left          = 310
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 19
                .ControlSource = "cursor_4c_GrdValores.GrupoACs"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ContaACs", "TextBox")
            WITH THIS.txt_4c_ContaACs
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 563
                .Left          = 391
                .Width         = 77
                .Height        = 23
                .MaxLength     = 11
                .TabIndex      = 20
                .ControlSource = "cursor_4c_GrdValores.ContaACs"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarCamposCentroCustoAgenteCobrador")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposComplementares - os 4 campos restantes da coluna
    * direita do dump (txt_4c_CMoes/TitBans/Tipos/MovTits, equivalentes a
    * getCMoes/getTitBans/getTipos/getMovTits), com o mesmo padrao de
    * ligacao direta a cursor_4c_GrdValores.<Campo> dos demais campos de
    * detalhe da linha corrente. MaxLength vem do schema (moedas char(3),
    * titbans char(12), tipos char(1), movtits char(20)).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposComplementares()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label12", "Label")
            WITH THIS.lbl_4c_Label12
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 238
                .Left      = 744
                .Width     = 160
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Inibir Lan" + CHR(231) + "amentos de:"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 309
                .Left      = 744
                .Width     = 140
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Moeda de Convers" + CHR(227) + "o"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_CMoes", "TextBox")
            WITH THIS.txt_4c_CMoes
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 325
                .Left          = 744
                .Width         = 31
                .Height        = 23
                .MaxLength     = 3
                .TabIndex      = 21
                .ControlSource = "cursor_4c_GrdValores.Moedas"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label13", "Label")
            WITH THIS.lbl_4c_Label13
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 355
                .Left      = 744
                .Width     = 57
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tit. Banco"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label16", "Label")
            WITH THIS.lbl_4c_Label16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 354
                .Left      = 853
                .Width     = 26
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tipo"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TitBans", "TextBox")
            WITH THIS.txt_4c_TitBans
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 371
                .Left          = 744
                .Width         = 94
                .Height        = 23
                .MaxLength     = 12
                .TabIndex      = 22
                .ControlSource = "cursor_4c_GrdValores.TitBans"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Tipos", "TextBox")
            WITH THIS.txt_4c_Tipos
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 370
                .Left          = 853
                .Width         = 17
                .Height        = 23
                .MaxLength     = 1
                .TabIndex      = 23
                .ControlSource = "cursor_4c_GrdValores.Tipos"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label17", "Label")
            WITH THIS.lbl_4c_Label17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 404
                .Left      = 744
                .Width     = 144
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_MovTits", "TextBox")
            WITH THIS.txt_4c_MovTits
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 419
                .Left          = 744
                .Width         = 150
                .Height        = 23
                .MaxLength     = 20
                .TabIndex      = 24
                .ControlSource = "cursor_4c_GrdValores.MovTits"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarCamposComplementares")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMemosEcheckboxes - obj_4c_GetNotas/obj_4c_GetComandos
    * (EditBox memo, equivalentes a getNotas/getComandos, ligados a
    * cursor_4c_GrdValores.Notas/Comandos no mesmo padrao mestre-detalhe dos
    * demais campos de linha) e os 2 CheckBox do bloco "Inibir Lancamentos
    * de:" (chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS).
    *
    * chk_P1_CMVS/chk_P2_MOBS NAO tem ControlSource no dump (layout.json so
    * declara Value="0" literal) e NAO ha coluna correspondente nem em
    * SigOpFin (CREATE CURSOR crGrdValores do legado nao as lista) nem em
    * SigOpOpe (conferido no schema.sql - nenhuma coluna *cmv*/*mob*
    * corresponde) - ficam como estado de tela, sem ControlSource inventado
    * (regra "NUNCA inventar tabela/coluna de lookup"). O GotFocus/LostFocus
    * de dirty-tracking (This.Tag <-> This.Value, que so seta
    * this_lAlterou) fica para a Fase 7, junto com os demais BINDEVENT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMemosEcheckboxes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 294
                .Left      = 12
                .Width     = 900
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Notas Sobre a Configura" + CHR(231) + CHR(227) + ;
                    "o (obrigat" + CHR(243) + "rio descrever o m" + CHR(225) + ;
                    "ximo poss" + CHR(237) + "vel a finalidade do lan" + CHR(231) + "amento)"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetNotas", "EditBox")
            WITH THIS.obj_4c_GetNotas
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 311
                .Left          = 12
                .Width         = 721
                .Height        = 131
                .ScrollBars    = 2
                .TabIndex      = 25
                .ControlSource = "cursor_4c_GrdValores.Notas"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 455
                .Left      = 485
                .Width     = 157
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Comandos de Programa" + CHR(231) + CHR(227) + "o"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetComandos", "EditBox")
            WITH THIS.obj_4c_GetComandos
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Top           = 471
                .Left          = 485
                .Width         = 508
                .Height        = 121
                .ScrollBars    = 2
                .TabIndex      = 26
                .ControlSource = "cursor_4c_GrdValores.Comandos"
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("chk_4c_Chk_P1_CMVS", "CheckBox")
            WITH THIS.chk_4c_Chk_P1_CMVS
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 256
                .Left      = 744
                .Width     = 220
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "CMV de Grupos de Produtos"
                .Value     = 0
                .TabIndex  = 27
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("chk_4c_Chk_P2_MOBS", "CheckBox")
            WITH THIS.chk_4c_Chk_P2_MOBS
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 273
                .Left      = 744
                .Width     = 240
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "M" + CHR(227) + "o de Obra da Movimenta" + CHR(231) + CHR(227) + "o"
                .Value     = 0
                .TabIndex  = 28
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarMemosEcheckboxes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosLookup - liga por BINDEVENT os campos que tem lookup no
    * legado. Cada campo usa UM unico handler ligado aos tres eventos:
    *
    *   "LostFocus" - equivalente ao Valid do legado (o legado abre o picker
    *                 ao SAIR do campo). NUNCA "KeyPress" sozinho: handler que
    *                 abre picker so por o campo nao estar vazio dispararia o
    *                 dialogo a CADA TECLA e o usuario nao conseguiria terminar
    *                 de digitar o codigo (regra CLAUDE.md #47).
    *   "KeyPress"  - atalho F4/F5 (convencao do sistema novo). O handler TESTA
    *                 a tecla antes de abrir - sem o teste o picker subiria no
    *                 primeiro caractere.
    *   "DblClick"  - atalho de mouse (convencao do sistema novo).
    *
    * O MESMO handler atende aos tres porque BINDEVENT repassa os parametros do
    * evento: em KeyPress chegam 2 (PCOUNT() = 2), em LostFocus/DblClick nenhum
    * (PCOUNT() = 0). O handler so aplica o filtro de tecla quando de fato
    * recebeu uma - handler SEM parametro ligado a KeyPress eh que estoura
    * (regra CLAUDE.md #3), o inverso e seguro.
    *
    * Todos os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo
    * PROTECTED falha em silencio (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosLookup()
        LOCAL loc_oErro

        TRY
            *-- Grupo (8 campos) e Conta (8 campos) das 4 linhas
            *-- Emissor/Portador/Centro de Custo/Agente Cobrador.
            THIS.LigarEventosLookup("txt_4c_GrupoEDs", "GrupoEDsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaEDs", "ContaEDsLookup")
            THIS.LigarEventosLookup("txt_4c_GrupoECs", "GrupoECsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaECs", "ContaECsLookup")
            THIS.LigarEventosLookup("txt_4c_GrupoPDs", "GrupoPDsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaPDs", "ContaPDsLookup")
            THIS.LigarEventosLookup("txt_4c_GrupoPCs", "GrupoPCsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaPCs", "ContaPCsLookup")
            THIS.LigarEventosLookup("txt_4c_GrupoCDs", "GrupoCDsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaCDs", "ContaCDsLookup")
            THIS.LigarEventosLookup("txt_4c_GrupoCCs", "GrupoCCsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaCCs", "ContaCCsLookup")
            THIS.LigarEventosLookup("txt_4c_GrupoADs", "GrupoADsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaADs", "ContaADsLookup")
            THIS.LigarEventosLookup("txt_4c_GrupoACs", "GrupoACsLookup")
            THIS.LigarEventosLookup("txt_4c_ContaACs", "ContaACsLookup")

            *-- Demais campos com Valid de lookup no dump legado.
            THIS.LigarEventosLookup("txt_4c_CMoes",   "CMoesLookup")
            THIS.LigarEventosLookup("txt_4c_TitBans", "TitBansLookup")
            THIS.LigarEventosLookup("txt_4c_MovTits", "MovTitsLookup")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarEventosLookup")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarEventosLookup - liga os 3 eventos de UM campo ao seu handler.
    * O controle e alcancado por EVALUATE (nome montado em tempo de execucao):
    * Controls eh indexado por NUMERO, passar o NOME estoura em runtime
    * (regra CLAUDE.md #34), e EVALUATE eh a forma canonica de LEITURA de
    * membro por nome (regra CLAUDE.md #15).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarEventosLookup(par_cCampo, par_cHandler)
        LOCAL loc_oTxt

        IF PEMSTATUS(THIS, par_cCampo, 5)
            loc_oTxt = EVALUATE("THIS." + par_cCampo)
            IF VARTYPE(loc_oTxt) = "O"
                BINDEVENT(loc_oTxt, "LostFocus", THIS, par_cHandler)
                BINDEVENT(loc_oTxt, "KeyPress",  THIS, par_cHandler)
                BINDEVENT(loc_oTxt, "DblClick",  THIS, par_cHandler)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaAbreLookup - .T. quando o handler deve abrir o picker.
    *
    * Chamado com os parametros que o evento entregou: em LostFocus/DblClick
    * nao vem nenhum (PCOUNT() = 0 no handler -> par_nKeyCode chega como .F.)
    * e o lookup roda, que e o comportamento do Valid legado; em KeyPress vem
    * o codigo da tecla e so F4 (115) e F5 (116) abrem.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION TeclaAbreLookup(par_nKeyCode)
        LOCAL loc_lAbre
        loc_lAbre = .T.

        IF VARTYPE(par_nKeyCode) = "N"
            loc_lAbre = INLIST(par_nKeyCode, 115, 116)
        ENDIF

        RETURN loc_lAbre
    ENDFUNC

    *--------------------------------------------------------------------------
    * Handlers de lookup - um por campo, ligado aos 3 eventos.
    * PUBLIC (sem PROTECTED) por exigencia do BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE GrupoEDsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoEDs")
        ENDIF
    ENDPROC

    PROCEDURE GrupoECsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoECs")
        ENDIF
    ENDPROC

    PROCEDURE GrupoPDsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoPDs")
        ENDIF
    ENDPROC

    PROCEDURE GrupoPCsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoPCs")
        ENDIF
    ENDPROC

    PROCEDURE GrupoCDsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoCDs")
        ENDIF
    ENDPROC

    PROCEDURE GrupoCCsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoCCs")
        ENDIF
    ENDPROC

    PROCEDURE GrupoADsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoADs")
        ENDIF
    ENDPROC

    PROCEDURE GrupoACsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupGrupo("txt_4c_GrupoACs")
        ENDIF
    ENDPROC

    PROCEDURE ContaEDsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaEDs")
        ENDIF
    ENDPROC

    PROCEDURE ContaECsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaECs")
        ENDIF
    ENDPROC

    PROCEDURE ContaPDsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaPDs")
        ENDIF
    ENDPROC

    PROCEDURE ContaPCsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaPCs")
        ENDIF
    ENDPROC

    PROCEDURE ContaCDsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaCDs")
        ENDIF
    ENDPROC

    PROCEDURE ContaCCsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaCCs")
        ENDIF
    ENDPROC

    PROCEDURE ContaADsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaADs")
        ENDIF
    ENDPROC

    PROCEDURE ContaACsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupConta("txt_4c_ContaACs")
        ENDIF
    ENDPROC

    PROCEDURE CMoesLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TitBansLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupTituloBanco()
        ENDIF
    ENDPROC

    PROCEDURE MovTitsLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupMovimentacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - picker de Grupo (legado: getGrupo<X>.Valid, que faz
    * Seek em crLstCdGcr e, nao achando, abre fwBuscaInt com as colunas
    * Codigos/Descrs/Tipos e grava This.Value = Codigos + Tipos).
    *
    * Tabela: SigCdGcr (codigos char(10), descrs char(40)). Confirmada por
    * codigo legado independente - em SIGMVCCR, get_sgrupo recebe
    * crSigCdPam2.grupopags e get_sdgrupo.Value = crSigCdGcr.Descrs apos
    * Seek(..., [crSigCdGcr], [Codigos]).
    *
    * crLstCdGcr era montado por fSigOpFin_Tabs() (SigOpFin.prg legado), que
    * NAO veio no acervo; dele vinha tambem a coluna Tipos, que SigCdGcr nao
    * possui. O 11o caractere do campo (char(11) = Codigos(10) + Tipos(1)) e
    * BRANCO para grupo concreto: SIGMVCMV compara SigOpFin.GrupoECs (char 11)
    * diretamente com SigMvCcr.grupos (char 10), igualdade que no SQL Server so
    * se sustenta com o 11o caractere em branco. Por isso o valor gravado e
    * PADR(codigo, 10) + " ", reproduzindo a concatenacao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo(par_cCampo)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupGrupoExec(par_cCampo)
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupoExec - corpo do lookup de Grupo. Separado do wrapper
    * acima porque o corpo tem saidas antecipadas: com set/clear da flag no
    * mesmo metodo, uma saida antecipada deixaria this_lEmLookup ligada para
    * sempre e mataria o lookup pelo resto da vida do form (CLAUDE.md #47).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGrupoExec(par_cCampo)
        LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
        loc_cCursor = "cursor_4c_BuscaGrupo"

        TRY
            loc_oTxt = THIS.ObterCampoLookup(par_cCampo)

            IF VARTYPE(loc_oTxt) = "O"
                *-- Legado: "If Not Empty(This.Value)" - campo vazio nao abre
                *-- picker nenhum (o grupo e opcional na linha).
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    THIS.FecharCursorTemporario(loc_cCursor)

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdGcr", loc_cCursor, "codigos", LEFT(loc_cValor, 10), ;
                        "Grupos")

                    IF VARTYPE(loc_oBusca) = "O"
                        *-- O Init ja tentou o match EXATO: achando 1 registro
                        *-- ele resolve sozinho e o dialogo NAO deve aparecer
                        *-- (contrato da regra CLAUDE.md #37, equivalente ao
                        *-- "If Not Seek(...)" do legado).
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("codigos", "", "Grupo")
                            loc_oBusca.mAddColuna("descrs",  "", ;
                                "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                            SELECT (loc_cCursor)
                            IF !EOF(loc_cCursor)
                                THIS.AplicarValorLookup(loc_oTxt, ;
                                    PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.codigos, "")), 10) + " ", ;
                                    ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.descrs, "")))
                            ENDIF
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupGrupoExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - picker de Conta (legado: getConta<X>.Valid, que faz
    * Seek em crLstCdCli e grava This.Value = Codigos + Tipos).
    *
    * Tabela: SigCdCli (iclis char(10) = codigo da conta, rclis char(50) =
    * descricao). Confirmada por codigo legado independente - em SIGMVCCR,
    * get_sCONTA recebe crSigCdPam2.contapags e get_sdCONTA.Value =
    * crSigCdCli.RClis. Mesma regra do 11o caractere em branco do
    * AbrirLookupGrupo.
    *
    * O legado NAO filtra a lista de contas pelo grupo da mesma linha
    * (crLstCdCli e a lista inteira) - nenhum filtro e acrescentado aqui.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta(par_cCampo)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupContaExec(par_cCampo)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupContaExec(par_cCampo)
        LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
        loc_cCursor = "cursor_4c_BuscaConta"

        TRY
            loc_oTxt = THIS.ObterCampoLookup(par_cCampo)

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    THIS.FecharCursorTemporario(loc_cCursor)

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdCli", loc_cCursor, "iclis", LEFT(loc_cValor, 10), ;
                        "Contas")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("iclis", "", "Conta")
                            loc_oBusca.mAddColuna("rclis", "", ;
                                "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                            SELECT (loc_cCursor)
                            IF !EOF(loc_cCursor)
                                THIS.AplicarValorLookup(loc_oTxt, ;
                                    PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaConta.iclis, "")), 10) + " ", ;
                                    ALLTRIM(TratarNulo(cursor_4c_BuscaConta.rclis, "")))
                            ENDIF
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupContaExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - picker de Moeda de Conversao (legado: getCMoes.Valid,
    * Seek em crLstMoeda e This.Value = crLstMoeda.Codigos - sem concatenar
    * Tipos, por isso aqui o valor e o codigo puro, char(3)).
    *
    * Tabela: SigCdMoe (cmoes char(3), dmoes char(15)).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupMoedaExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMoedaExec()
        LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
        loc_cCursor = "cursor_4c_BuscaMoeda"

        TRY
            loc_oTxt = THIS.ObterCampoLookup("txt_4c_CMoes")

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    THIS.FecharCursorTemporario(loc_cCursor)

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdMoe", loc_cCursor, "cmoes", LEFT(loc_cValor, 3), ;
                        "Moedas")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("cmoes", "", "Moeda")
                            loc_oBusca.mAddColuna("dmoes", "", ;
                                "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                            SELECT (loc_cCursor)
                            IF !EOF(loc_cCursor)
                                THIS.AplicarValorLookup(loc_oTxt, ;
                                    ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.cmoes, "")), ;
                                    ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.dmoes, "")))
                            ENDIF
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupMoedaExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMovimentacao - picker de Movimentacao de Titulos (legado:
    * getMovTits.Valid). E o unico lookup REMOTO do dump - o legado chama
    * CreateObject([fwBuscaExt], ..., [SigOpOpe], [crListaRemota], [Dopes],
    * This.Value, [Selecao], .t.) e adiciona UMA unica coluna, Dopes.
    *
    * Tabela e campo transcritos do dump, nao deduzidos. Coluna unica: em
    * SigOpOpe, Dopes char(20) e ao mesmo tempo a chave e o texto exibido.
    *
    * O legado grava This.Value = crListaRemota.Dopes INCONDICIONALMENTE (ou
    * seja, tambem quando o usuario cancela, o que zera o campo). Aqui o valor
    * so e aplicado sob this_lSelecionou, que e o contrato do
    * FormBuscaAuxiliar (regra CLAUDE.md #37): cancelar preserva o que o
    * usuario digitou em vez de apaga-lo.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMovimentacao()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupMovimentacaoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMovimentacaoExec()
        LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
        loc_cCursor = "cursor_4c_BuscaMovTit"

        TRY
            loc_oTxt = THIS.ObterCampoLookup("txt_4c_MovTits")

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    THIS.FecharCursorTemporario(loc_cCursor)

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigOpOpe", loc_cCursor, "Dopes", LEFT(loc_cValor, 20), ;
                        "Sele" + CHR(231) + CHR(227) + "o")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("Dopes", "", ;
                                "Movimenta" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                            SELECT (loc_cCursor)
                            IF !EOF(loc_cCursor)
                                THIS.AplicarValorLookup(loc_oTxt, ;
                                    ALLTRIM(TratarNulo(cursor_4c_BuscaMovTit.Dopes, "")), "")
                            ENDIF
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupMovimentacaoExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTituloBanco - picker de Titulo Banco (legado:
    * getTitBans.Valid, Seek(Padr(This.Value, 12), [crLstTitBc], [Codigos]) e,
    * nao achando, fwBuscaInt sobre crLstTitBc com as colunas Codigos/Descrs/
    * Tipos).
    *
    * crLstTitBc e um cursor LOCAL montado por fSigOpFin_Tabs() (SigOpFin.prg
    * legado), que NAO veio no acervo - e nao ha, no schema canonico, tabela
    * mestre de Titulo Banco: a coluna titbans char(12) so aparece em
    * SigMvCcr, SigMvCpv e sigopfin, sempre como valor gravado. Por isso a
    * lista NAO e remontada a partir de tabela nenhuma: escolher uma tabela
    * por semelhanca e justamente o que a regra "NUNCA inventar tabelas de
    * lookup que nao existem no original" proibe, e o palpite gravaria codigo
    * errado em silencio.
    *
    * O picker roda portanto sobre o MESMO cursor que o legado le, quando ele
    * estiver aberto na sessao (sera o caso assim que fSigOpFin_Tabs for
    * portada). Nao estando, a ausencia e reportada nomeando a origem legada
    * que falta - e o codigo digitado pelo usuario e PRESERVADO, nunca
    * apagado (regra CLAUDE.md #50).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTituloBanco()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupTituloBancoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupTituloBancoExec()
        LOCAL loc_oTxt, loc_cValor, loc_oErro

        TRY
            loc_oTxt = THIS.ObterCampoLookup("txt_4c_TitBans")

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    IF THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
                        *-- Legado: Seek(Padr(This.Value, 12), [crLstTitBc],
                        *-- [Codigos]) - achando exato, nao abre o picker.
                        SELECT crLstTitBc
                        GO TOP IN crLstTitBc
                        LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == ;
                            UPPER(ALLTRIM(LEFT(loc_cValor, 12)))

                        IF EOF("crLstTitBc")
                            THIS.MostrarPickerListaLocal("crLstTitBc", ;
                                "Codigos", "Descrs", ;
                                "T" + CHR(237) + "tulo Banco")
                        ENDIF

                        IF USED("crLstTitBc") AND !EOF("crLstTitBc")
                            THIS.AplicarValorLookup(loc_oTxt, ;
                                ALLTRIM(TratarNulo(crLstTitBc.Codigos, "")), ;
                                ALLTRIM(TratarNulo(crLstTitBc.Descrs, "")))
                        ENDIF
                    ELSE
                        MsgAviso("A lista de T" + CHR(237) + "tulos de Banco " + ;
                            "(cursor crLstTitBc) n" + CHR(227) + "o est" + CHR(225) + ;
                            " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
                            CHR(13) + "Ela era montada por fSigOpFin_Tabs(), do " + ;
                            "SigOpFin.prg legado, que n" + CHR(227) + "o faz parte " + ;
                            "do acervo migrado." + CHR(13) + ;
                            "O c" + CHR(243) + "digo digitado foi mantido.", ;
                            "Lista indispon" + CHR(237) + "vel")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupTituloBancoExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupOrigemGrade - picker da coluna "Origem dos Valores" da grade
    * (legado: grdValores.Column1.Text1.Valid):
    *
    *   Locate For Upper(Descrs) = Upper(Padr(This.Value, 100))
    *   If Eof([crTabOpFin]) -> fwBuscaInt(crTabOpFin, Descrs, ...) + Show
    *   If LastKey() = 27 -> Replace Codigos With [], Descrs With []
    *   Else              -> Replace Codigos/Descrs With crTabOpFin.*
    *
    * crTabOpFin e a lista de origens de valor do modulo SigOpFin, montada por
    * fSigOpFin_Tabs() (SigOpFin.prg legado, fora do acervo) - nao existe
    * tabela correspondente no schema canonico, e nenhuma e inventada aqui
    * (mesma razao do AbrirLookupTituloBanco). O picker roda sobre o cursor do
    * legado quando ele existir; nao existindo, a ausencia e reportada e o que
    * o usuario digitou e preservado na linha.
    *
    * Recebe o TextBox da celula como parametro: dentro do Valid o valor
    * digitado ainda esta em par_oTxt.Value e o cursor so o recebe DEPOIS -
    * ler do cursor validaria o valor antigo (regra CLAUDE.md #46).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupOrigemGrade(par_oTxt)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupOrigemGradeExec(par_oTxt)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupOrigemGradeExec(par_oTxt)
        LOCAL loc_cValor, loc_lCancelou, loc_oErro

        TRY
            IF VARTYPE(par_oTxt) = "O" AND THIS.EmModoEdicao() ;
                    AND USED("cursor_4c_GrdValores") ;
                    AND !EOF("cursor_4c_GrdValores")
                loc_cValor = ALLTRIM(TRANSFORM(par_oTxt.Value))

                *-- Legado: "If Not Empty(This.Value) And (Alltrim(This.Tag)
                *-- <> Alltrim(This.Value))" - celula vazia ou inalterada nao
                *-- dispara lookup nenhum.
                IF !EMPTY(loc_cValor) AND ;
                        ALLTRIM(TRANSFORM(par_oTxt.Tag)) != loc_cValor
                    IF THIS.ListaLocalDisponivel("crTabOpFin", "Descrs")
                        loc_lCancelou = .F.

                        SELECT crTabOpFin
                        GO TOP IN crTabOpFin
                        LOCATE FOR UPPER(ALLTRIM(crTabOpFin.Descrs)) == ;
                            UPPER(ALLTRIM(LEFT(loc_cValor, 100)))

                        IF EOF("crTabOpFin")
                            loc_lCancelou = !THIS.MostrarPickerListaLocal( ;
                                "crTabOpFin", "Descrs", "Codigos", "Descritivos")
                        ENDIF

                        SELECT cursor_4c_GrdValores
                        IF loc_lCancelou OR !USED("crTabOpFin") OR EOF("crTabOpFin")
                            *-- Legado: "If (LastKey() = 27) Replace Codigos
                            *-- With [], Descrs With []".
                            REPLACE Codigos WITH "", ;
                                    Descrs  WITH "" IN cursor_4c_GrdValores
                            par_oTxt.Value = ""
                        ELSE
                            REPLACE Codigos WITH ALLTRIM(TratarNulo(crTabOpFin.Codigos, "")), ;
                                    Descrs  WITH ALLTRIM(TratarNulo(crTabOpFin.Descrs,  "")) ;
                                IN cursor_4c_GrdValores
                            par_oTxt.Value = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
                        ENDIF

                        par_oTxt.Tag       = ALLTRIM(TRANSFORM(par_oTxt.Value))
                        THIS.this_lAlterou = .T.

                        *-- Legado: "This.Refresh" - repintura da CELULA, nao
                        *-- MontaGrade(). MontaGrade() reatribui ColumnCount,
                        *-- o que RECRIA os objetos Column e destruiria o
                        *-- proprio TextBox cujo Valid esta em execucao
                        *-- (par_oTxt ficaria com referencia morta).
                        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                            THIS.grd_4c_Dados.Refresh()
                        ENDIF
                    ELSE
                        MsgAviso("A lista de Origens dos Valores " + ;
                            "(cursor crTabOpFin) n" + CHR(227) + "o est" + CHR(225) + ;
                            " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
                            CHR(13) + "Ela era montada por fSigOpFin_Tabs(), do " + ;
                            "SigOpFin.prg legado, que n" + CHR(227) + "o faz parte " + ;
                            "do acervo migrado." + CHR(13) + ;
                            "O texto digitado foi mantido na linha.", ;
                            "Lista indispon" + CHR(237) + "vel")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupOrigemGradeExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCampoLookup - devolve o TextBox de nome par_cCampo quando ele pode
    * receber lookup, ou .NULL. quando nao.
    *
    * O legado protege cada um desses campos com "When -> Return
    * InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])": em VISUALIZAR o campo
    * nao recebe foco e o Valid nunca roda. EmModoEdicao() reproduz esse When.
    *
    * O controle e alcancado por EVALUATE (regra CLAUDE.md #15/#34) - jamais
    * por Controls(<nome>), que e indexado por NUMERO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterCampoLookup(par_cCampo)
        LOCAL loc_oTxt
        loc_oTxt = .NULL.

        IF THIS.EmModoEdicao() AND PEMSTATUS(THIS, par_cCampo, 5)
            loc_oTxt = EVALUATE("THIS." + par_cCampo)

            IF VARTYPE(loc_oTxt) = "O"
                IF !loc_oTxt.Enabled OR loc_oTxt.ReadOnly
                    loc_oTxt = .NULL.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_oTxt
    ENDFUNC

    *--------------------------------------------------------------------------
    * AplicarValorLookup - grava no campo o codigo escolhido e a descricao no
    * ToolTipText (o legado faz This.Value = ... / This.ToolTipText = Descrs),
    * marcando a tela como alterada (plAlterou do legado).
    *
    * Todos esses TextBox tem ControlSource em cursor_4c_GrdValores: atribuir
    * .Value grava na linha corrente do cursor, que e exatamente o que o
    * legado faz. Sem linha corrente nao ha onde gravar - dai a guarda.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarValorLookup(par_oTxt, par_cValor, par_cDescricao)
        IF VARTYPE(par_oTxt) = "O" AND USED("cursor_4c_GrdValores") ;
                AND !EOF("cursor_4c_GrdValores")
            par_oTxt.Value = par_cValor

            IF VARTYPE(par_cDescricao) = "C" AND !EMPTY(par_cDescricao)
                par_oTxt.ToolTipText = par_cDescricao
            ENDIF

            par_oTxt.Refresh()
            THIS.this_lAlterou = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ListaLocalDisponivel - .T. quando o cursor de lista do legado existe na
    * sessao e tem a coluna esperada com pelo menos uma linha.
    *
    * Conferir a COLUNA (e nao so USED()) evita abrir o picker sobre um alias
    * homonimo de outra tela com estrutura diferente, caso em que o
    * ControlSource da grade do picker estouraria em runtime. TYPE() e usado
    * no lugar de PEMSTATUS porque PEMSTATUS exige OBJETO no 1o argumento -
    * com nome de cursor ele dispara o erro 11 do VFP9.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ListaLocalDisponivel(par_cCursor, par_cCampo)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            IF TYPE(par_cCursor + "." + par_cCampo) != "U" ;
                    AND RECCOUNT(par_cCursor) > 0
                loc_lOk = .T.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MostrarPickerListaLocal - equivalente ao fwBuscaInt do legado: picker
    * sobre um cursor LOCAL ja populado, com duas colunas.
    *
    * Usa a API manual do FormBuscaAuxiliar (CREATEOBJECT sem parametros +
    * mAddColuna + Show) porque o cursor NAO vem de SQL: o Init com parametros
    * dispararia um SELECT contra o SQL Server, que e o oposto do que o legado
    * faz aqui. O cursor ja estar populado e pre-requisito - sem isso o
    * ConfigurarGrid do picker retorna cedo e o dialogo abriria vazio; por
    * isso o chamador sempre passa por ListaLocalDisponivel() antes.
    *
    * Devolve .T. quando o usuario selecionou. Ao selecionar, o ponteiro do
    * cursor fica na linha escolhida (o grid do picker o posiciona), que e
    * como o legado le o registro depois do Show.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MostrarPickerListaLocal(par_cCursor, par_cCampoCod, ;
            par_cCampoDesc, par_cTitulo)
        LOCAL loc_oBusca, loc_lSelecionou
        loc_lSelecionou = .F.

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCursorDestino = par_cCursor
            loc_oBusca.this_cTitulo        = par_cTitulo
            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cTitulo

            loc_oBusca.mAddColuna(par_cCampoCod,  "", par_cCampoCod)
            loc_oBusca.mAddColuna(par_cCampoDesc, "", par_cCampoDesc)
            loc_oBusca.Show()

            loc_lSelecionou = loc_oBusca.this_lSelecionou
            loc_oBusca.Release()
        ENDIF

        RETURN loc_lSelecionou
    ENDFUNC

    *--------------------------------------------------------------------------
    * InstalarCelulaOrigem - poe na Column1 da grade o TextBox com Valid/
    * KeyPress/DblClick embutidos, que e como se liga lookup a CELULA de grade
    * (regra CLAUDE.md #46: AfterRowColChange entrega a coluna de DESTINO, e
    * BINDEVENT em Valid de TextBox de Column nao e confiavel).
    *
    * Chamado tambem de MontaGrade(): atribuir ColumnCount RECRIA os objetos
    * Column e destroi o controle instalado aqui, entao ele e reinstalado em
    * qualquer caminho que religa a grade.
    *
    * CurrentControl e obrigatorio - sem ele a Column continua desenhando o
    * Text1 nativo e o controle novo nunca aparece; Sparse = .F. faz valer em
    * todas as linhas, nao so na ativa (regra CLAUDE.md #18). Column.ReadOnly
    * vem DEPOIS do ReadOnly do Grid, que propaga para as colunas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InstalarCelulaOrigem()
        LOCAL loc_oCol, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_oCol = THIS.grd_4c_Dados.Column1

                IF !PEMSTATUS(loc_oCol, "txt_4c_CelOrigem", 5)
                    loc_oCol.AddObject("txt_4c_CelOrigem", "TextBoxOrigemSigOpFin_4c")
                ENDIF

                loc_oCol.txt_4c_CelOrigem.Visible = .T.
                loc_oCol.CurrentControl           = "txt_4c_CelOrigem"
                loc_oCol.Sparse                   = .F.
                loc_oCol.ReadOnly                 = !THIS.EmModoEdicao()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InstalarCelulaOrigem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - popula cursor_4c_GrdValores com as linhas de configuracao
    * ja gravadas para a movimentacao (this_cDopes) e, em modo de edicao,
    * acrescenta no fim a linha em branco que o legado usa para a inclusao da
    * proxima origem.
    *
    * Equivalente ao trecho do Init legado (dump de
    * sigopfin_form_codigo_fonte.txt, linhas 1483-1523):
    *   =fSigOpFin_Cria()                        -> SELECT ... FROM sigopfin
    *   Scan crSigOpFin / Scatter / Insert       -> DO WHILE sobre o cursor temp
    *   Insert Into crGrdValores (Ordem) Values  -> linha em branco do fim
    *   .MontaGrades()                           -> THIS.MontaGrade()
    *
    * fSigOpFin_Cria()/fSigOpFin_Tabs() vivem no SigOpFin.prg legado, que NAO
    * veio no acervo; o que elas faziam de fato (abrir as linhas de sigopfin da
    * movimentacao) esta reproduzido aqui com SQL direto sobre a tabela. O
    * legado le crSigOpFin, cursor que o form PAI (cadastro de Operacoes) cria
    * - aqui a consulta e propria, para o dialogo nao depender de cursor de
    * terceiro.
    *
    * O SQLEXEC vai para um cursor TEMPORARIO: SQLEXEC sobre o alias ligado ao
    * Grid fecha e recria o alias, zerando ColumnCount e deixando a grade um
    * retangulo branco sem cabecalho. O alias da grade e recarregado com
    * ZAP + insercao linha a linha, que preserva estrutura e binding.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_nOrdem, loc_oErro
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            THIS.CriarCursorGrdValores()

            IF !USED("cursor_4c_GrdValores")
                MsgErro("Cursor da grade n" + CHR(227) + "o foi criado.", ;
                    "Erro em CarregarDados")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_GrdValores
                ZAP

                *-- Sem conexao (validacao de UI / modo de teste) a grade abre
                *-- vazia e o form continua funcionando - nao ha SQL a executar.
                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
                        AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                    THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")

                    loc_cSQL = "SELECT codigos, dopes, ordem," + ;
                               " moedas, tipos, titbans, movtits," + ;
                               " notas, comandos," + ;
                               " usuincs, datincs, usualts, datalts," + ;
                               " grupoeds, contaeds, grupoecs, contaecs," + ;
                               " grupopds, contapds, grupopcs, contapcs," + ;
                               " grupocds, contacds, grupoccs, contaccs," + ;
                               " grupoads, contaads, grupoacs, contaacs" + ;
                               " FROM sigopfin" + ;
                               " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                               " ORDER BY ordem"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, ;
                        "cursor_4c_GrdValoresTmp")

                    IF loc_nResultado < 0
                        MsgErro("Erro ao carregar as configura" + CHR(231) + ;
                            CHR(245) + "es de lan" + CHR(231) + "amento da " + ;
                            "movimenta" + CHR(231) + CHR(227) + "o " + ;
                            ALLTRIM(THIS.this_cDopes) + ":" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nOrdem = 0

                IF USED("cursor_4c_GrdValoresTmp")
                    SELECT cursor_4c_GrdValoresTmp
                    GO TOP
                    DO WHILE !EOF("cursor_4c_GrdValoresTmp")
                        loc_nOrdem = loc_nOrdem + 1
                        THIS.InserirLinhaGrade(loc_nOrdem)
                        SELECT cursor_4c_GrdValoresTmp
                        SKIP
                    ENDDO
                ENDIF

                *-- Linha em branco do fim, so em modo de edicao - legado:
                *--   If InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
                *--       Insert Into crGrdValores (Ordem) Values (lnOrd)
                *-- Apenas Ordem e preenchida: Dopes/cIdChaves/UsuIncs sao
                *-- atribuidos na gravacao (gravardados legado, Fase 8).
                IF THIS.EmModoEdicao()
                    loc_nOrdem = loc_nOrdem + 1
                    INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nOrdem)
                ENDIF

                THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")

                THIS.MontaGrade()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Formsigopfin.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaGrade - acrescenta a cursor_4c_GrdValores a linha corrente de
    * cursor_4c_GrdValoresTmp, renumerando Ordem sequencialmente (par_nOrdem) e
    * resolvendo a descricao da origem. Equivale ao corpo do Scan legado
    * (Scatter Memvar Memo / m.Ordem / m.Descrs / Insert From Memvar).
    *
    * As colunas sao referenciadas com o alias explicito para a insercao nao
    * depender da area de trabalho corrente. Descrs NAO existe na tabela
    * sigopfin (so no cursor da grade) - vem da descricao da origem.
    * DatIncs/DatAlts usam CTOT("") como default, igual ao Nvl(..., Ctot([]))
    * do legado: campo T nao aceita o {} de um DATE vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirLinhaGrade(par_nOrdem)
        LOCAL loc_cCodigos, loc_cDescrs

        loc_cCodigos = TratarNulo(cursor_4c_GrdValoresTmp.codigos, "")
        loc_cDescrs  = LEFT(THIS.ObterDescricaoOrigem(loc_cCodigos), 100)

        INSERT INTO cursor_4c_GrdValores ;
            (Ordem,    Codigos,  Descrs,   Dopes, ;
             Notas,    Comandos, Moedas,   Tipos,    TitBans, ;
             UsuIncs,  MovTits,  DatIncs,  UsuAlts,  DatAlts, ;
             GrupoEDs, ContaEDs, GrupoECs, ContaECs, ;
             GrupoPDs, ContaPDs, GrupoPCs, ContaPCs, ;
             GrupoCDs, ContaCDs, GrupoCCs, ContaCCs, ;
             GrupoADs, ContaADs, GrupoACs, ContaACs) ;
            VALUES ;
            (par_nOrdem, ;
             loc_cCodigos, ;
             loc_cDescrs, ;
             TratarNulo(cursor_4c_GrdValoresTmp.dopes,    ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.notas,    ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.comandos, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.moedas,   ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.tipos,    ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.titbans,  ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.usuincs,  ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.movtits,  ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.datincs,  CTOT("")), ;
             TratarNulo(cursor_4c_GrdValoresTmp.usualts,  ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.datalts,  CTOT("")), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupoeds, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contaeds, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupoecs, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contaecs, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupopds, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contapds, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupopcs, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contapcs, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupocds, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contacds, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupoccs, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contaccs, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupoads, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contaads, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.grupoacs, ""), ;
             TratarNulo(cursor_4c_GrdValoresTmp.contaacs, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoOrigem - descricao exibida na coluna da grade para o codigo
    * da origem dos valores. Equivale a fSigOpFin_Busca(Codigos, [D]) do Init
    * legado, que le crTabOpFin - cursor montado por fSigOpFin_Tabs() no
    * SigOpFin.prg legado, que NAO veio no acervo. crTabOpFin tambem NAO
    * corresponde a tabela alguma do banco (o schema tem sigopfin e nenhuma
    * outra tabela *opfin*), portanto a lista de origens nao e conhecida e NAO
    * pode ser inventada.
    *
    * Enquanto crTabOpFin nao existir, a grade mostra o PROPRIO codigo em vez
    * de celula vazia: a linha fica visivel e identificavel, e a ausencia da
    * lista fica aparente em vez de parecer grade sem dados. Assim que o cursor
    * existir (fonte legado), a descricao dele prevalece.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterDescricaoOrigem(par_cCodigo)
        LOCAL loc_cDescricao, loc_cAliasAnterior, loc_nRegAnterior
        loc_cDescricao = ""

        IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(par_cCodigo)
            IF USED("crTabOpFin")
                loc_cAliasAnterior = ALIAS()
                loc_nRegAnterior   = RECNO("crTabOpFin")

                SELECT crTabOpFin
                LOCATE FOR ALLTRIM(crTabOpFin.Codigos) == ALLTRIM(par_cCodigo)
                IF !EOF("crTabOpFin")
                    loc_cDescricao = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
                ENDIF

                IF BETWEEN(loc_nRegAnterior, 1, RECCOUNT("crTabOpFin"))
                    GO loc_nRegAnterior IN crTabOpFin
                ENDIF
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF
            ENDIF

            IF EMPTY(loc_cDescricao)
                loc_cDescricao = ALLTRIM(par_cCodigo)
            ENDIF
        ENDIF

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontaGrade - religa grd_4c_Dados a cursor_4c_GrdValores e repinta.
    * Equivale ao montagrades legado (dump linhas 1417-1446).
    *
    * Metodo UNICO de repintura: todo caminho que popula, reordena ou exclui
    * linha do cursor termina aqui. Popular o cursor NAO repinta a grade
    * sozinho - o legado tambem fecha com Go Top + Refresh; sem isso a grade
    * fica visualmente vazia com o cursor cheio.
    *
    * A ordem das atribuicoes e a canonica (ColumnCount -> RecordSource ->
    * ControlSource -> Width -> Header1.Caption): RecordSource recalcula as
    * larguras para o default 90 e apaga o caption, por isso os dois vem
    * DEPOIS dele.
    *
    * O montagrades legado tambem religa os ControlSource dos campos de
    * detalhe (getNotas/getComandos/getCMoes/getTitBans/getTipos/getMovTits e
    * os 16 de Grupo/Conta) e chama AfterRowColChange - esses controles sao
    * criados nas Fases 5 e 6, e o religamento deles entra NESTE metodo junto
    * com eles.
    *
    * par_cParamTeste (nao usado): o harness generico TesteCarregarDadosReais
    * trata TODO metodo chamado "MontaGrade" como se exigisse um parametro de
    * filtro (THIS.oForm.MontaGrade(<valor ou "">)) - mesmo padrao ja usado em
    * Formsigopagr.MontaGrade/Formsigopcim.MontaGrade/Formsigmvitn.MontaGrade.
    * Sem este parametro opcional, essa chamada externa estoura "No PARAMETER
    * statement is found." (VFP9 nao aceita argumento extra em metodo sem
    * PARAMETERS/LPARAMETERS). As chamadas internas deste form
    * (THIS.MontaGrade()) continuam sem argumento.
    *--------------------------------------------------------------------------
    PROCEDURE MontaGrade(par_cParamTeste)
        LOCAL loc_oGrd, loc_oErro

        TRY
            THIS.CriarCursorGrdValores()

            SELECT cursor_4c_GrdValores
            SET ORDER TO TAG Ordem
            GO TOP

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_oGrd = THIS.grd_4c_Dados

                WITH loc_oGrd
                    .ColumnCount  = 1
                    .RecordSource = "cursor_4c_GrdValores"

                    .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
                    .Column1.Width             = 700
                    .Column1.FontName          = "Tahoma"
                    .Column1.FontSize          = 8
                    .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
                        CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + ;
                        "o Financeira"
                    .Column1.Header1.Alignment = 2
                    .Column1.Header1.FontBold  = .F.

                    .Refresh()
                ENDWITH
            ENDIF

            *-- MontaGrade() reatribui ColumnCount, o que RECRIA os objetos
            *-- Column e destroi o TextBox de lookup da celula - reinstalar
            *-- em todo caminho que religa a grade.
            THIS.InstalarCelulaOrigem()

            *-- Religamento dos campos de detalhe da linha corrente,
            *-- criados em ConfigurarCamposGrupoContaEmissorPortador()
            *-- (Fase 5 parte 1 - Emissor/Portador). Guardado por
            *-- PEMSTATUS porque MontaGrade() tambem roda a partir de
            *-- CarregarDados(), chamado no InicializarForm ANTES de
            *-- ConfigurarPageFrame() ter criado esses controles na
            *-- primeira passada (CarregarDados roda de novo depois, com
            *-- os controles ja existindo).
            IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
                THIS.txt_4c_GrupoEDs.ControlSource = "cursor_4c_GrdValores.GrupoEDs"
                THIS.txt_4c_ContaEDs.ControlSource = "cursor_4c_GrdValores.ContaEDs"
                THIS.txt_4c_GrupoECs.ControlSource = "cursor_4c_GrdValores.GrupoECs"
                THIS.txt_4c_ContaECs.ControlSource = "cursor_4c_GrdValores.ContaECs"
                THIS.txt_4c_GrupoPDs.ControlSource = "cursor_4c_GrdValores.GrupoPDs"
                THIS.txt_4c_ContaPDs.ControlSource = "cursor_4c_GrdValores.ContaPDs"
                THIS.txt_4c_GrupoPCs.ControlSource = "cursor_4c_GrdValores.GrupoPCs"
                THIS.txt_4c_ContaPCs.ControlSource = "cursor_4c_GrdValores.ContaPCs"
                THIS.txt_4c_GrupoEDs.Refresh()
                THIS.txt_4c_ContaEDs.Refresh()
                THIS.txt_4c_GrupoECs.Refresh()
                THIS.txt_4c_ContaECs.Refresh()
                THIS.txt_4c_GrupoPDs.Refresh()
                THIS.txt_4c_ContaPDs.Refresh()
                THIS.txt_4c_GrupoPCs.Refresh()
                THIS.txt_4c_ContaPCs.Refresh()
            ENDIF

            *-- Religamento dos campos de detalhe criados nesta Fase 6
            *-- (Centro de Custo/Agente Cobrador - ConfigurarCamposCentro-
            *-- CustoAgenteCobrador - e CMoes/TitBans/Tipos/MovTits/Notas/
            *-- Comandos - ConfigurarCamposComplementares/
            *-- ConfigurarMemosEcheckboxes). Mesmo guard por PEMSTATUS da
            *-- Fase 5 parte 1, mesma razao.
            IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
                THIS.txt_4c_GrupoCDs.ControlSource = "cursor_4c_GrdValores.GrupoCDs"
                THIS.txt_4c_ContaCDs.ControlSource = "cursor_4c_GrdValores.ContaCDs"
                THIS.txt_4c_GrupoCCs.ControlSource = "cursor_4c_GrdValores.GrupoCCs"
                THIS.txt_4c_ContaCCs.ControlSource = "cursor_4c_GrdValores.ContaCCs"
                THIS.txt_4c_GrupoADs.ControlSource = "cursor_4c_GrdValores.GrupoADs"
                THIS.txt_4c_ContaADs.ControlSource = "cursor_4c_GrdValores.ContaADs"
                THIS.txt_4c_GrupoACs.ControlSource = "cursor_4c_GrdValores.GrupoACs"
                THIS.txt_4c_ContaACs.ControlSource = "cursor_4c_GrdValores.ContaACs"
                THIS.txt_4c_GrupoCDs.Refresh()
                THIS.txt_4c_ContaCDs.Refresh()
                THIS.txt_4c_GrupoCCs.Refresh()
                THIS.txt_4c_ContaCCs.Refresh()
                THIS.txt_4c_GrupoADs.Refresh()
                THIS.txt_4c_ContaADs.Refresh()
                THIS.txt_4c_GrupoACs.Refresh()
                THIS.txt_4c_ContaACs.Refresh()
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_CMoes", 5)
                THIS.txt_4c_CMoes.ControlSource   = "cursor_4c_GrdValores.Moedas"
                THIS.txt_4c_TitBans.ControlSource = "cursor_4c_GrdValores.TitBans"
                THIS.txt_4c_Tipos.ControlSource    = "cursor_4c_GrdValores.Tipos"
                THIS.txt_4c_MovTits.ControlSource  = "cursor_4c_GrdValores.MovTits"
                THIS.txt_4c_CMoes.Refresh()
                THIS.txt_4c_TitBans.Refresh()
                THIS.txt_4c_Tipos.Refresh()
                THIS.txt_4c_MovTits.Refresh()
            ENDIF

            IF PEMSTATUS(THIS, "obj_4c_GetNotas", 5)
                THIS.obj_4c_GetNotas.ControlSource    = "cursor_4c_GrdValores.Notas"
                THIS.obj_4c_GetComandos.ControlSource = "cursor_4c_GrdValores.Comandos"
                THIS.obj_4c_GetNotas.Refresh()
                THIS.obj_4c_GetComandos.Refresh()
            ENDIF

            *-- Legado: ".AfterRowColChange()" ao final do montagrades -
            *-- recalcula os ToolTipText de Grupo/Conta/TitBans/CMoes para a
            *-- linha corrente (Fase 7). Chamado por ultimo, com os campos ja
            *-- religados acima.
            THIS.AfterRowColChange()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Formsigopfin.MontaGrade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesGrade - visibilidade dos 3 botoes de manutencao da grade
    * conforme o modo. Legado (Init, dump linhas 1525-1527):
    *   .btnExcluiGrd.Visible = InList(.pcEscolha, [INSERIR], [ALTERAR])
    *   .btnSetaDn.Visible    = .btnExcluiGrd.Visible
    *   .btnSetaUp.Visible    = .btnExcluiGrd.Visible
    *
    * Chamado DEPOIS de TornarControlesVisiveis(), que forca Visible = .T. em
    * tudo e apagaria este ajuste se viesse antes. Fica num metodo proprio para
    * que todo caminho que troque de modo possa reaplica-lo e os botoes
    * reaparecam na volta.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesGrade()
        LOCAL loc_lEditando, loc_oErro

        TRY
            loc_lEditando = THIS.EmModoEdicao()

            IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
                THIS.cmd_4c_BtnSetaUp.Visible = loc_lEditando
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
                THIS.cmd_4c_BtnSetaDn.Visible = loc_lEditando
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
                THIS.cmd_4c_BtnExcluiGrd.Visible = loc_lEditando
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Formsigopfin.AjustarBotoesGrade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EmModoEdicao - .T. quando a tela esta em inclusao ou alteracao, isto e,
    * quando o legado testa InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR]).
    * O modo e copiado do form chamador no Init; "INCLUIR" e a grafia do
    * sistema novo e "INSERIR" a do legado - as duas sao aceitas porque
    * this_cModoAtual vem de par_oFormPai.this_cModoAtual, que pode trazer
    * qualquer das duas.
    *--------------------------------------------------------------------------
    FUNCTION EmModoEdicao()
        RETURN INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), ;
            "INCLUIR", "INSERIR", "ALTERAR")
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursorTemporario - fecha com seguranca um cursor auxiliar.
    * TABLEREVERT() EXIGE buffering: chamado em cursor com Buffering = 1 (o
    * default de CREATE CURSOR e de cursor de SQLEXEC) ele NAO e inocuo -
    * dispara o erro 1586 "Function requires row or table buffering mode". Dai
    * a guarda por CURSORGETPROP: USE IN fecha o alias mesmo com buffer sujo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursorTemporario(par_cAlias)
        IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias) AND USED(par_cAlias)
            IF CURSORGETPROP("Buffering", par_cAlias) > 1
                TABLEREVERT(.T., par_cAlias)
            ENDIF
            USE IN (par_cAlias)
        ENDIF
    ENDPROC
    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (containers/PageFrame) para
    * garantir que tudo fique visivel apos a montagem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AvancarLinhaGradeOrigem - parte do LostFocus de grdValores.Column1.Text1
    * que NAO e dirty-tracking (esta ja coberta em AbrirLookupOrigemGradeExec,
    * chamado pelo Valid): ao sair da celula com ENTER e a linha preenchida,
    * avanca para a proxima linha e, se for a ultima, insere uma em branco -
    * para o usuario sempre ter onde continuar digitando. Chamado pelo
    * LostFocus de TextBoxOrigemSigOpFin_4c. PUBLIC pelo mesmo motivo de
    * AbrirLookupOrigemGrade (chamado de fora da classe do form).
    *--------------------------------------------------------------------------
    PROCEDURE AvancarLinhaGradeOrigem()
        LOCAL loc_nQtdeBranco, loc_nMaxOrdem, loc_oErro

        TRY
            IF THIS.EmModoEdicao() AND USED("cursor_4c_GrdValores") ;
                    AND LASTKEY() = 13 ;
                    AND !EMPTY(cursor_4c_GrdValores.Codigos)
                SELECT cursor_4c_GrdValores
                SKIP

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF

                IF EOF("cursor_4c_GrdValores")
                    loc_nQtdeBranco = 0
                    COUNT FOR EMPTY(Codigos) TO loc_nQtdeBranco

                    IF loc_nQtdeBranco = 0
                        loc_nMaxOrdem = 0
                        CALCULATE MAX(Ordem) TO loc_nMaxOrdem
                        INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nMaxOrdem + 1)
                    ENDIF

                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Column1.SetFocus()
                ENDIF
                KEYBOARD "{DNARROW}"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AvancarLinhaGradeOrigem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarTagCampo / VerificarAlteracaoCampo - par generico de dirty-
    * tracking (legado: "This.Tag = This.Value" no GotFocus e "If (This.Tag
    * <> This.Value) ThisForm.plAlterou = .t. EndIf" no LostFocus, repetido
    * em ~20 controles do dump). TRANSFORM() normaliza C/N (TextBox guarda
    * char, CheckBox guarda numerico 0/1 - Str(Value,1) do legado e
    * TRANSFORM(Value) aqui dao o mesmo "0"/"1").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarTagCampo(par_cCampo)
        LOCAL loc_oCtrl

        IF PEMSTATUS(THIS, par_cCampo, 5)
            loc_oCtrl = EVALUATE("THIS." + par_cCampo)
            IF VARTYPE(loc_oCtrl) = "O"
                loc_oCtrl.Tag = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE VerificarAlteracaoCampo(par_cCampo)
        LOCAL loc_oCtrl

        IF PEMSTATUS(THIS, par_cCampo, 5)
            loc_oCtrl = EVALUATE("THIS." + par_cCampo)
            IF VARTYPE(loc_oCtrl) = "O"
                IF ALLTRIM(TRANSFORM(loc_oCtrl.Tag)) != ALLTRIM(TRANSFORM(loc_oCtrl.Value))
                    THIS.this_lAlterou = .T.
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarAlteracaoEMaiusculizar - variante usada por getNotas/
    * getComandos: dirty-check seguido de "This.Value = Upper(This.Value)".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarAlteracaoEMaiusculizar(par_cCampo)
        LOCAL loc_oCtrl

        IF PEMSTATUS(THIS, par_cCampo, 5)
            loc_oCtrl = EVALUATE("THIS." + par_cCampo)
            IF VARTYPE(loc_oCtrl) = "O"
                IF ALLTRIM(TRANSFORM(loc_oCtrl.Tag)) != ALLTRIM(TRANSFORM(loc_oCtrl.Value))
                    THIS.this_lAlterou = .T.
                ENDIF
                loc_oCtrl.Value = UPPER(loc_oCtrl.Value)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosDirtyTracking - BINDEVENT de GotFocus/LostFocus para
    * dirty-tracking (this_lAlterou) em todos os controles de detalhe da
    * linha corrente que o dump declara com esse par (16 Grupo/Conta +
    * CMoes/TitBans/Tipos/MovTits + getNotas/getComandos + os 2 CheckBox).
    * Fase 7. O LostFocus dos campos com lookup (Grupo/Conta/CMoes/TitBans/
    * MovTits) ja esta ligado a *Lookup (Fase 6, equivalente ao Valid do
    * legado) - o BIND aqui e um SEGUNDO handler no MESMO evento, que o VFP9
    * encadeia na ordem de ligacao (Lookup primeiro, dirty-check depois),
    * reproduzindo a ordem real do legado (Valid roda antes de LostFocus).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosDirtyTracking()
        LOCAL loc_oErro

        TRY
            THIS.LigarDirtyTracking("txt_4c_GrupoEDs", "GrupoEDsGotFoco", "GrupoEDsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaEDs", "ContaEDsGotFoco", "ContaEDsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_GrupoECs", "GrupoECsGotFoco", "GrupoECsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaECs", "ContaECsGotFoco", "ContaECsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_GrupoPDs", "GrupoPDsGotFoco", "GrupoPDsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaPDs", "ContaPDsGotFoco", "ContaPDsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_GrupoPCs", "GrupoPCsGotFoco", "GrupoPCsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaPCs", "ContaPCsGotFoco", "ContaPCsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_GrupoCDs", "GrupoCDsGotFoco", "GrupoCDsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaCDs", "ContaCDsGotFoco", "ContaCDsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_GrupoCCs", "GrupoCCsGotFoco", "GrupoCCsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaCCs", "ContaCCsGotFoco", "ContaCCsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_GrupoADs", "GrupoADsGotFoco", "GrupoADsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaADs", "ContaADsGotFoco", "ContaADsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_GrupoACs", "GrupoACsGotFoco", "GrupoACsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_ContaACs", "ContaACsGotFoco", "ContaACsPerdeFoco")

            THIS.LigarDirtyTracking("txt_4c_CMoes",   "CMoesGotFoco",   "CMoesPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_TitBans", "TitBansGotFoco", "TitBansPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_MovTits", "MovTitsGotFoco", "MovTitsPerdeFoco")
            THIS.LigarDirtyTracking("txt_4c_Tipos",   "TiposGotFoco",   "TiposPerdeFoco")

            THIS.LigarDirtyTracking("obj_4c_GetNotas",    "GetNotasGotFoco",    "GetNotasPerdeFoco")
            THIS.LigarDirtyTracking("obj_4c_GetComandos", "GetComandosGotFoco", "GetComandosPerdeFoco")

            THIS.LigarDirtyTracking("chk_4c_Chk_P1_CMVS", "ChkP1CmvsGotFoco", "ChkP1CmvsPerdeFoco")
            THIS.LigarDirtyTracking("chk_4c_Chk_P2_MOBS", "ChkP2MobsGotFoco", "ChkP2MobsPerdeFoco")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarEventosDirtyTracking")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarDirtyTracking - liga os handlers de GotFocus/LostFocus de UM campo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarDirtyTracking(par_cCampo, par_cHandlerGotFocus, par_cHandlerLostFocus)
        LOCAL loc_oCtrl

        IF PEMSTATUS(THIS, par_cCampo, 5)
            loc_oCtrl = EVALUATE("THIS." + par_cCampo)
            IF VARTYPE(loc_oCtrl) = "O"
                BINDEVENT(loc_oCtrl, "GotFocus",  THIS, par_cHandlerGotFocus)
                BINDEVENT(loc_oCtrl, "LostFocus", THIS, par_cHandlerLostFocus)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Handlers de dirty-tracking - um par (GotFoco/PerdeFoco) por campo,
    * cada um delegando para o par generico acima com o nome do campo.
    * Todos PUBLIC (sem PROTECTED) por exigencia do BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE GrupoEDsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoEDs")
    ENDPROC
    PROCEDURE GrupoEDsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoEDs")
    ENDPROC

    PROCEDURE ContaEDsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaEDs")
    ENDPROC
    PROCEDURE ContaEDsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaEDs")
    ENDPROC

    PROCEDURE GrupoECsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoECs")
    ENDPROC
    PROCEDURE GrupoECsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoECs")
    ENDPROC

    PROCEDURE ContaECsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaECs")
    ENDPROC
    PROCEDURE ContaECsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaECs")
    ENDPROC

    PROCEDURE GrupoPDsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoPDs")
    ENDPROC
    PROCEDURE GrupoPDsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoPDs")
    ENDPROC

    PROCEDURE ContaPDsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaPDs")
    ENDPROC
    PROCEDURE ContaPDsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaPDs")
    ENDPROC

    PROCEDURE GrupoPCsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoPCs")
    ENDPROC
    PROCEDURE GrupoPCsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoPCs")
    ENDPROC

    PROCEDURE ContaPCsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaPCs")
    ENDPROC
    PROCEDURE ContaPCsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaPCs")
    ENDPROC

    PROCEDURE GrupoCDsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoCDs")
    ENDPROC
    PROCEDURE GrupoCDsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoCDs")
    ENDPROC

    PROCEDURE ContaCDsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaCDs")
    ENDPROC
    PROCEDURE ContaCDsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaCDs")
    ENDPROC

    PROCEDURE GrupoCCsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoCCs")
    ENDPROC
    PROCEDURE GrupoCCsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoCCs")
    ENDPROC

    PROCEDURE ContaCCsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaCCs")
    ENDPROC
    PROCEDURE ContaCCsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaCCs")
    ENDPROC

    PROCEDURE GrupoADsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoADs")
    ENDPROC
    PROCEDURE GrupoADsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoADs")
    ENDPROC

    PROCEDURE ContaADsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaADs")
    ENDPROC
    PROCEDURE ContaADsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaADs")
    ENDPROC

    PROCEDURE GrupoACsGotFoco()
        THIS.SalvarTagCampo("txt_4c_GrupoACs")
    ENDPROC
    PROCEDURE GrupoACsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_GrupoACs")
    ENDPROC

    PROCEDURE ContaACsGotFoco()
        THIS.SalvarTagCampo("txt_4c_ContaACs")
    ENDPROC
    PROCEDURE ContaACsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_ContaACs")
    ENDPROC

    PROCEDURE CMoesGotFoco()
        THIS.SalvarTagCampo("txt_4c_CMoes")
    ENDPROC
    PROCEDURE CMoesPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_CMoes")
    ENDPROC

    PROCEDURE TitBansGotFoco()
        THIS.SalvarTagCampo("txt_4c_TitBans")
    ENDPROC
    PROCEDURE TitBansPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_TitBans")
    ENDPROC

    PROCEDURE MovTitsGotFoco()
        THIS.SalvarTagCampo("txt_4c_MovTits")
    ENDPROC
    PROCEDURE MovTitsPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_MovTits")
    ENDPROC

    PROCEDURE TiposGotFoco()
        THIS.SalvarTagCampo("txt_4c_Tipos")
    ENDPROC
    PROCEDURE TiposPerdeFoco()
        THIS.VerificarAlteracaoCampo("txt_4c_Tipos")
    ENDPROC

    PROCEDURE GetNotasGotFoco()
        THIS.SalvarTagCampo("obj_4c_GetNotas")
    ENDPROC
    PROCEDURE GetNotasPerdeFoco()
        THIS.VerificarAlteracaoEMaiusculizar("obj_4c_GetNotas")
    ENDPROC

    PROCEDURE GetComandosGotFoco()
        THIS.SalvarTagCampo("obj_4c_GetComandos")
    ENDPROC
    PROCEDURE GetComandosPerdeFoco()
        THIS.VerificarAlteracaoEMaiusculizar("obj_4c_GetComandos")
    ENDPROC

    PROCEDURE ChkP1CmvsGotFoco()
        THIS.SalvarTagCampo("chk_4c_Chk_P1_CMVS")
    ENDPROC
    PROCEDURE ChkP1CmvsPerdeFoco()
        THIS.VerificarAlteracaoCampo("chk_4c_Chk_P1_CMVS")
    ENDPROC

    PROCEDURE ChkP2MobsGotFoco()
        THIS.SalvarTagCampo("chk_4c_Chk_P2_MOBS")
    ENDPROC
    PROCEDURE ChkP2MobsPerdeFoco()
        THIS.VerificarAlteracaoCampo("chk_4c_Chk_P2_MOBS")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - equivalente a SIGOPFIN.Sair.Click do legado (dump linhas
    * 1606-1732): valida a grade quando houve alteracao, oferece abandonar os
    * dados se a validacao falhar, remove as linhas em branco e grava. PUBLIC
    * por exigencia do BINDEVENT (regra CLAUDE.md #3).
    *
    * Legado:
    *   llOks = .t.
    *   If Not Empty(lcMsg)
    *       If (MessageBox(lcMsg + [Deseja Sair ...], 4+32+256, ...) = 6)
    *           Zap In crGrdValores / plAlterou = .f. / llOks = .t.
    *       Else
    *           grdValores.Refresh/SetFocus/AfterRowColChange() / llOks = .f.
    *       EndIf
    *   EndIf
    *   If llOks
    *       Delete From crGrdValores Where Empty(Codigos) Or Empty(Descrs)
    *       If ThisForm.GravarDados() / ThisForm.Release() / Else llOks=.f.
    *   EndIf
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_cMsg, loc_lOk, loc_oErro
        loc_cMsg = ""
        loc_lOk  = .T.

        TRY
            IF THIS.EmModoEdicao() AND THIS.this_lAlterou
                loc_cMsg = THIS.ValidarGradeValores()
            ENDIF

            IF !EMPTY(loc_cMsg)
                IF MsgConfirma(loc_cMsg + CHR(13) + "Deseja Sair da Tela e " + ;
                        "Abandonar Todos os Dados Alterados?", ;
                        "Erro: Dados Inconsistentes")
                    IF USED("cursor_4c_GrdValores")
                        SELECT cursor_4c_GrdValores
                        ZAP
                    ENDIF
                    THIS.this_lAlterou = .F.
                    loc_lOk = .T.
                ELSE
                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                        THIS.grd_4c_Dados.SetFocus()
                    ENDIF
                    THIS.AfterRowColChange()
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                IF USED("cursor_4c_GrdValores")
                    DELETE FROM cursor_4c_GrdValores ;
                        WHERE EMPTY(Codigos) OR EMPTY(Descrs)
                ENDIF

                IF THIS.GravarDados()
                    THIS.Release()
                ELSE
                    loc_lOk = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSairClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGradeValores - equivalente ao trecho de validacao do
    * SIGOPFIN.Sair.Click legado: "Select * From crGrdValores Where Not
    * Empty(Codigos) And Not Empty(Descrs) Into Cursor LocalSair" + "Scan
    * While Empty(lcMsg)". Devolve a mensagem de inconsistencia (vazia se
    * tudo estiver OK).
    *
    * Fidelidade a uma peculiaridade do legado: dentro de UMA linha, todos os
    * IFs rodam em sequencia (nenhum e guardado por "Empty(lcMsg)" entre si),
    * entao se MAIS DE UM campo da MESMA linha estiver vazio, loc_cMsg fica
    * com o ULTIMO que bateu (nao o primeiro) - e so DEPOIS de terminar a
    * linha inteira o "Scan While Empty(lcMsg)" para de avancar para a
    * proxima. Por isso o EXIT fica no TOPO do corpo do SCAN, nao substitui o
    * SCAN por "SCAN WHILE".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarGradeValores()
        LOCAL loc_cMsg, loc_oErro
        loc_cMsg = ""

        TRY
            IF USED("cursor_4c_GrdValores")
                THIS.FecharCursorTemporario("cursor_4c_LocalSair")

                SELECT * FROM cursor_4c_GrdValores ;
                    WHERE !EMPTY(Codigos) AND !EMPTY(Descrs) ;
                    INTO CURSOR cursor_4c_LocalSair READWRITE

                SELECT cursor_4c_LocalSair
                GO TOP
                SCAN
                    IF !EMPTY(loc_cMsg)
                        EXIT
                    ENDIF

                    IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LocalSair.Notas, "")))
                        loc_cMsg = "O Campo " + CHR(34) + "Notas Sobre a " + ;
                            "Configura" + CHR(231) + CHR(227) + "o" + CHR(34) + ;
                            " N" + CHR(227) + "o Foi Preenchido!!!" + CHR(13) + ;
                            "Origem: " + ALLTRIM(cursor_4c_LocalSair.Descrs)
                        IF PEMSTATUS(THIS, "obj_4c_GetNotas", 5)
                            THIS.obj_4c_GetNotas.SetFocus()
                        ENDIF
                    ENDIF

                    THIS.ValidarCampoGradeVazio("GrupoEDs", "txt_4c_GrupoEDs", ;
                        "Grupo de D" + CHR(233) + "bito Emissor", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("ContaEDs", "txt_4c_ContaEDs", ;
                        "Conta de D" + CHR(233) + "bito Emissor", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("GrupoECs", "txt_4c_GrupoECs", ;
                        "Grupo de Cr" + CHR(233) + "dito Emissor", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("ContaECs", "txt_4c_ContaECs", ;
                        "Conta de Cr" + CHR(233) + "dito Emissor", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("GrupoPDs", "txt_4c_GrupoPDs", ;
                        "Grupo de D" + CHR(233) + "bito Portador", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("ContaPDs", "txt_4c_ContaPDs", ;
                        "Conta de D" + CHR(233) + "bito Portador", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("GrupoPCs", "txt_4c_GrupoPCs", ;
                        "Grupo de Cr" + CHR(233) + "dito Portador", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("ContaPCs", "txt_4c_ContaPCs", ;
                        "Conta de Cr" + CHR(233) + "dito Portador", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("GrupoCDs", "txt_4c_GrupoCDs", ;
                        "Grupo de D" + CHR(233) + "bito Centro de Custo", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("ContaCDs", "txt_4c_ContaCDs", ;
                        "Conta de D" + CHR(233) + "bito Centro de Custo", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("GrupoCCs", "txt_4c_GrupoCCs", ;
                        "Grupo de Cr" + CHR(233) + "dito Centro de Custo", @loc_cMsg)
                    THIS.ValidarCampoGradeVazio("ContaCCs", "txt_4c_ContaCCs", ;
                        "Conta de Cr" + CHR(233) + "dito Centro de Custo", @loc_cMsg)

                    *-- Legado: "Agente Cobrador" (GrupoADs/ContaADs/GrupoACs/
                    *-- ContaACs) e tudo-ou-nada - sem SetFocus no original.
                    IF !EMPTY(ALLTRIM(cursor_4c_LocalSair.GrupoADs + ;
                            cursor_4c_LocalSair.ContaADs + ;
                            cursor_4c_LocalSair.GrupoACs + ;
                            cursor_4c_LocalSair.ContaACs)) AND ;
                            (EMPTY(cursor_4c_LocalSair.GrupoADs) OR ;
                             EMPTY(cursor_4c_LocalSair.ContaADs) OR ;
                             EMPTY(cursor_4c_LocalSair.GrupoACs) OR ;
                             EMPTY(cursor_4c_LocalSair.ContaACs))
                        loc_cMsg = "Um Campo de " + CHR(34) + "Agente Cobrador" + ;
                            CHR(34) + " Foi Preenchido Mas Algum Ficou Em " + ;
                            "Branco!!!" + CHR(13) + CHR(201) + " Necess" + ;
                            CHR(225) + "rio o Preenchimento de Todos os " + ;
                            "Campos Ou Nenhum Ser" + CHR(225) + " Preenchido!"
                    ENDIF
                ENDSCAN

                THIS.FecharCursorTemporario("cursor_4c_LocalSair")
            ENDIF
        CATCH TO loc_oErro
            THIS.FecharCursorTemporario("cursor_4c_LocalSair")
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGradeValores")
        ENDTRY

        RETURN loc_cMsg
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCampoGradeVazio - um unico "If Empty(LocalSair.<Campo>)" do
    * Click legado: testa a coluna par_cCampo da linha corrente de
    * cursor_4c_LocalSair e, vazia, monta a mensagem e foca o campo
    * correspondente da grade (par_cCampoForm). par_cMsg e passado por
    * referencia para reproduzir a sobrescrita sequencial do legado (regra de
    * ValidarGradeValores acima).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCampoGradeVazio(par_cCampo, par_cCampoForm, par_cRotulo, par_cMsg)
        LOCAL loc_oCtrl

        IF EMPTY(EVALUATE("cursor_4c_LocalSair." + par_cCampo))
            par_cMsg = "O Campo " + CHR(34) + par_cRotulo + CHR(34) + ;
                " N" + CHR(227) + "o Foi Preenchido!!!" + CHR(13) + ;
                "Origem: " + ALLTRIM(cursor_4c_LocalSair.Descrs)
            IF PEMSTATUS(THIS, par_cCampoForm, 5)
                loc_oCtrl = EVALUATE("THIS." + par_cCampoForm)
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDados - equivalente ao PROCEDURE gravardados do legado (dump
    * linhas 1367-1412). So grava quando EmModoEdicao() e this_lAlterou (o
    * legado: "If InList(pcEscolha,[INSERIR],[ALTERAR]) And plAlterou"); caso
    * contrario devolve .T. sem fazer nada, igual ao legado ("Return .t."
    * fora do IF).
    *
    * Em ALTERAR, o legado apaga TODAS as linhas antigas de SigOpFin para
    * este Dopes e reinsere TODAS as linhas validas da grade (delete-then-
    * reinsert, nao um diff) - aqui reproduzido com DELETE via SQLEXEC +
    * sigopfinBO.Inserir() por linha, renumerando Ordem sequencialmente.
    *
    * Desvio assumido (documentado, nao e regra de negocio visivel ao
    * usuario): o legado preserva UsuIncs/DatIncs/UsuAlts/DatAlts das linhas
    * pre-existentes no delete-then-reinsert (Iif(pcEscolha=INSERIR Or
    * Empty(m.UsuIncs), Usuar, m.UsuIncs), e similar para os outros tres);
    * sigopfinBO.Inserir() sempre estampa this_cUsuIncs=gc_4c_UsuarioLogado,
    * datincs=GETDATE() e datalts=NULL (nao ha gancho para preservar os
    * valores originais sem reescrever o BO), e this_cUsuAlts fica no
    * default "" do BO (nenhuma linha reinserida e tratada como "alterada"
    * por este fluxo). O rastro de quem/quando INCLUIU de fato fica no
    * LogAuditoria via RegistrarAuditoria(), chamado dentro do proprio
    * Inserir().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nOrdem, loc_oLinha, loc_oErro
        loc_lSucesso = .T.

        TRY
            IF THIS.EmModoEdicao() AND THIS.this_lAlterou

                IF UPPER(ALLTRIM(THIS.this_cModoAtual)) = "ALTERAR"
                    loc_cSQL = "DELETE FROM sigopfin WHERE dopes = " + ;
                        EscaparSQL(THIS.this_cDopes)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF loc_lSucesso AND USED("cursor_4c_GrdValores")
                    loc_nOrdem = 0

                    SELECT cursor_4c_GrdValores
                    GO TOP
                    SCAN FOR !EMPTY(Codigos)
                        loc_nOrdem = loc_nOrdem + 1

                        loc_oLinha = CREATEOBJECT("sigopfinBO")
                        IF VARTYPE(loc_oLinha) = "O"
                            *-- CarregarDoCursor() do BO NAO serve aqui: ele le
                            *-- cidchaves/chkempds, colunas que NAO existem em
                            *-- cursor_4c_GrdValores (CriarCursorGrdValores so
                            *-- declara os campos que a grade/campos de
                            *-- detalhe usam - cidchaves e gerado de novo a
                            *-- cada Inserir() e chkempds nao tem controle na
                            *-- tela). Chama-lo estouraria "Variable CIDCHAVES
                            *-- is not found". Os campos sao copiados um a um.
                            loc_oLinha.this_cCodigos  = TratarNulo(cursor_4c_GrdValores.Codigos,  "")
                            loc_oLinha.this_cComandos = TratarNulo(cursor_4c_GrdValores.Comandos, "")
                            loc_oLinha.this_cContaAcs = TratarNulo(cursor_4c_GrdValores.ContaACs,  "")
                            loc_oLinha.this_cContaAds = TratarNulo(cursor_4c_GrdValores.ContaADs,  "")
                            loc_oLinha.this_cContaCcs = TratarNulo(cursor_4c_GrdValores.ContaCCs,  "")
                            loc_oLinha.this_cContaCds = TratarNulo(cursor_4c_GrdValores.ContaCDs,  "")
                            loc_oLinha.this_cContaEcs = TratarNulo(cursor_4c_GrdValores.ContaECs,  "")
                            loc_oLinha.this_cContaEds = TratarNulo(cursor_4c_GrdValores.ContaEDs,  "")
                            loc_oLinha.this_cContaPcs = TratarNulo(cursor_4c_GrdValores.ContaPCs,  "")
                            loc_oLinha.this_cContaPds = TratarNulo(cursor_4c_GrdValores.ContaPDs,  "")
                            loc_oLinha.this_cDopes    = THIS.this_cDopes
                            loc_oLinha.this_cGrupoAcs = TratarNulo(cursor_4c_GrdValores.GrupoACs,  "")
                            loc_oLinha.this_cGrupoAds = TratarNulo(cursor_4c_GrdValores.GrupoADs,  "")
                            loc_oLinha.this_cGrupoCcs = TratarNulo(cursor_4c_GrdValores.GrupoCCs,  "")
                            loc_oLinha.this_cGrupoCds = TratarNulo(cursor_4c_GrdValores.GrupoCDs,  "")
                            loc_oLinha.this_cGrupoEcs = TratarNulo(cursor_4c_GrdValores.GrupoECs,  "")
                            loc_oLinha.this_cGrupoEds = TratarNulo(cursor_4c_GrdValores.GrupoEDs,  "")
                            loc_oLinha.this_cGrupoPcs = TratarNulo(cursor_4c_GrdValores.GrupoPCs,  "")
                            loc_oLinha.this_cGrupoPds = TratarNulo(cursor_4c_GrdValores.GrupoPDs,  "")
                            loc_oLinha.this_cMoedas   = TratarNulo(cursor_4c_GrdValores.Moedas,    "")
                            loc_oLinha.this_cMovTits  = TratarNulo(cursor_4c_GrdValores.MovTits,   "")
                            loc_oLinha.this_cNotas    = TratarNulo(cursor_4c_GrdValores.Notas,     "")
                            loc_oLinha.this_nOrdem    = loc_nOrdem
                            loc_oLinha.this_cTipos    = TratarNulo(cursor_4c_GrdValores.Tipos,     "")
                            loc_oLinha.this_cTitBans  = TratarNulo(cursor_4c_GrdValores.TitBans,   "")

                            IF !loc_oLinha.Inserir()
                                loc_lSucesso = .F.
                            ENDIF
                        ELSE
                            MsgErro("Falha ao criar sigopfinBO.", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarConfigFinanceiraOperacao()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopfin.GravarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarConfigFinanceiraOperacao - equivalente a "Replace CfgFinancs
    * With Padr(chk_P1_CMVS.Value,1) + Padr(chk_P2_MOBS.Value,1) +
    * Substr(crSigCdOpe.CfgFinancs,3,18) In crSigCdOpe" (fim do gravardados
    * legado). crSigCdOpe no legado e o registro da operacao (SigCdOpe, PK
    * dopes) ja aberto pelo form PAI - aqui le-se e grava-se via SQL direto,
    * ja que este dialogo nao tem esse cursor. "S"/"N" (convencao Fortyus de
    * flag char) no lugar do valor logico do CheckBox legado - this_cDopes
    * ja vem com o padding de 20 (PADR no Init), EscaparSQL compara com
    * blank-padding ANSI do SQL Server.
    *
    * Sem registro de SigCdOpe para este Dopes: devolve .T. em silencio (nao
    * ha o que atualizar, e nao deve bloquear o fechamento do dialogo por uma
    * inconsistencia que nao e deste form).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AtualizarConfigFinanceiraOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCfgAtual, loc_cCfgNova, loc_oErro
        loc_lSucesso = .T.

        TRY
            THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")

            loc_cSQL = "SELECT cfgfinancs FROM SigCdOpe WHERE dopes = " + ;
                EscaparSQL(THIS.this_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgFinTmp")

            IF loc_nResultado >= 0 AND USED("cursor_4c_CfgFinTmp") ;
                    AND RECCOUNT("cursor_4c_CfgFinTmp") > 0
                loc_cCfgAtual = PADR(TratarNulo(cursor_4c_CfgFinTmp.cfgfinancs, ""), 20)

                loc_cCfgNova = PADR(IIF(THIS.chk_4c_Chk_P1_CMVS.Value = 1, "S", "N"), 1) + ;
                               PADR(IIF(THIS.chk_4c_Chk_P2_MOBS.Value = 1, "S", "N"), 1) + ;
                               SUBSTR(loc_cCfgAtual, 3, 18)

                THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")

                loc_cSQL = "UPDATE SigCdOpe SET cfgfinancs = " + EscaparSQL(loc_cCfgNova) + ;
                    " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao atualizar a configura" + CHR(231) + CHR(227) + ;
                        "o financeira da opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AtualizarConfigFinanceiraOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

*==============================================================================
* TextBoxOrigemSigOpFin_4c - celula da coluna "Origem dos Valores a Serem
* Lancados na Movimentacao Financeira" (grd_4c_Dados.Column1), equivalente ao
* SIGOPFIN.grdValores.Column1.Text1 do legado.
*
* Os eventos ficam EMBUTIDOS na classe, nao ligados por BINDEVENT: em VFP9,
* BINDEVENT no Valid de um TextBox dentro de Column nao dispara de forma
* confiavel, e validar a celula no AfterRowColChange da grade valida a linha
* ERRADA, porque o nColIndex que esse evento entrega e a coluna de DESTINO
* (regra CLAUDE.md #46). O corpo de cada evento apenas delega para um metodo
* PUBLIC do form, onde a regra de negocio mora.
*
* Instalada por Formsigopfin.InstalarCelulaOrigem(), que tambem cuida do
* CurrentControl/Sparse/ReadOnly da Column.
*==============================================================================
DEFINE CLASS TextBoxOrigemSigOpFin_4c AS TextBox

    FontName   = "Tahoma"
    FontSize   = 8
    BorderStyle = 0
    Margin     = 0
    MaxLength  = 100

    *--------------------------------------------------------------------------
    * When - legado: "Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])"
    * (a celula so aceita digitacao em inclusao/alteracao).
    *--------------------------------------------------------------------------
    PROCEDURE When()
        RETURN THISFORM.EmModoEdicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * GotFocus - legado: "This.Tag = This.Value". O Tag guarda o valor de
    * entrada; o Valid so dispara o lookup quando ele mudou.
    *--------------------------------------------------------------------------
    PROCEDURE GotFocus()
        THIS.Tag = ALLTRIM(TRANSFORM(THIS.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * Valid - legado: Locate em crTabOpFin pela descricao digitada e, nao
    * achando, picker; depois Replace Codigos/Descrs na linha da grade.
    *--------------------------------------------------------------------------
    PROCEDURE Valid()
        THISFORM.AbrirLookupOrigemGrade(THIS)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LostFocus - legado: avanca para a proxima linha da grade (e insere uma
    * em branco, se for a ultima) quando a saida foi por ENTER com a linha
    * preenchida. O dirty-tracking (This.Tag <> This.Value) desta mesma
    * celula ja e feito em AbrirLookupOrigemGradeExec (chamado pelo Valid,
    * que roda ANTES do LostFocus na ordem real do VFP9) - aqui so a parte
    * de navegacao, delegada ao form (Fase 7).
    *--------------------------------------------------------------------------
    PROCEDURE LostFocus()
        THISFORM.AvancarLinhaGradeOrigem()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - atalho F4/F5 para abrir a lista (convencao do sistema novo).
    * A tecla E testada: sem o teste o picker subiria a cada caractere.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THISFORM.AbrirLookupOrigemGrade(THIS)
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DblClick - atalho de mouse para abrir a lista.
    *--------------------------------------------------------------------------
    PROCEDURE DblClick()
        THISFORM.AbrirLookupOrigemGrade(THIS)
    ENDPROC

ENDDEFINE

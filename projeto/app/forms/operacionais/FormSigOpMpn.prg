*==============================================================================
* FormSigOpMpn.prg - Movimentacoes de Subnivel em Aberto (SigCdNec)
* Origem: tasks/task769/SigOpMpn.SCX (SIGOPMPN)
* Herda de: FormBase
*
* Tipo: OPERACIONAL (dialogo filho, mesma familia de FormSigOpMpd.prg -
* aberto por um form pai que esta montando uma operacao, para o usuario
* marcar/desmarcar quais pendencias de subnivel de uma "necessidade"
* (SigCdNec) entram na operacao). NAO segue o padrao Page1=Lista/
* Page2=Dados do CRUD: layout FLAT, filhos DIRETOS do form (cabecalho +
* grade de selecao TmpPends + grades de itens/total + botoes), igual ao
* SCX legado (sem PageFrame nenhum) - mesma decisao de FormSigOpMpd.prg.
*
* DataSession=1 (compartilhada) - DESVIO DELIBERADO do SCX legado, que
* declara DataSession=2 (privada) mas, logo no inicio do Init, executa
* "Set DataSession To DatSes" para trocar para a sessao do form PAI ANTES
* de criar TmpPends/xPNensi/xPNensiT - ou seja, na pratica o legado
* tambem roda na sessao do chamador, nao na propria. Aqui isso e
* replicado deixando o form inteiro na sessao compartilhada (1), mesmo
* padrao de FormSigOpMpd.prg/FormSigOpLrC.prg/Formsigopagr.prg: assim
* TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi, mantidos abertos pelo form
* pai, ficam visiveis aqui pelo NOME, sem precisar emular "Set
* DataSession To <numero>" (sem equivalente nesta arquitetura).
*
* Aberto com: CREATEOBJECT("FormSigOpMpn", oFormPai)
*
* Parametros de Init (equivalentes ao legado "LParameters pForm, DatSes,
* Operacao"):
*   par_oFormPai - pForm: form chamador. Guardado em this_oFormPai; o
*                  legado tambem copia This.pEmps/This.pcEscolha dele no
*                  Init (aqui: this_oBusinessObject.this_cEmpresa e
*                  this_cModoAtual) e o reabilita no fechamento
*                  (ThisForm.ParentForm.Enabled = .t., replicado em
*                  Destroy() - mesmo padrao de FormSigOpMpd.prg).
*   par_nDataSession - DatSes (DataSessionId do pai): sem equivalente
*                  nesta arquitetura (DataSession=1 compartilhada
*                  substitui, ver nota acima). Recebido so por fidelidade
*                  de assinatura - nunca lido.
*   par_cOperacao - Operacao: recebido pelo LParameters legado mas NUNCA
*                  referenciado no corpo do Init (confirmado por grep no
*                  dump inteiro - unico ponto onde o nome aparece e a
*                  propria declaracao do parametro). Parametro morto no
*                  legado - recebido aqui so por fidelidade de assinatura.
*
* Historico de fases:
*   Fase 1/2: SigOpMpnBO.prg (propriedades, Init, ObterChavePrimaria,
*             CarregarDoCursor, Atualizar).
*   Fase 3:   FormSigOpMpn.prg - estrutura base (Init, InicializarForm,
*             ConfigurarCabecalho, Destroy).
*   Fase 4:   grd_4c_Grade (TmpPends, selecao), grd_4c_Itens/grd_4c_Total
*             (xPNensi/xPNensiT, detalhe) e os botoes de acao (cmd_4c_Ok/
*             cmd_4c_SelTudo/cmd_4c_Apaga/cmd_4c_Totaliza), MAIS a carga e
*             o vinculo das tres grades (CarregarGrade/CarregarLista +
*             SigOpMpnBO.CarregarPendencias, que cria os tres cursores e
*             popula TmpPends/xPNensi/xPNensiT). A montagem visual
*             (Configurar*) e o bind (Carregar*) ficam SEPARADOS por causa
*             da regra #41 - Column.ControlSource de cursor que ainda nao
*             existe derruba o Init -, mas rodam na MESMA ordem do Init
*             legado: monta, cria cursor, liga.
*
*   Fase 5:   lbl_4c_Label1 + txt_4c_OpSubNivel (Nivels do nivel para o
*             qual a movimentacao de subnivel esta indo - legado:
*             "ThisForm.OpSubNivel.Value = crSigCdOpd.Nivels", calculado
*             em CarregarGrade() a partir de TmpNens.Dopps/crSigCdOpd -
*             cursor do form pai e cursor global, ambos visiveis aqui
*             pelo nome por causa da DataSession=1 compartilhada).
*   Fase 6:   lbl_4c__Procura/txt_4c_Procura (busca incremental por Numps
*             na grade de selecao - legado: Say_Procura/Get_Procura.Valid/
*             LostFocus, transcritos em ValidarProcuraNumero/
*             TxtProcuraKeyPress/TxtProcuraLostFocus porque BINDEVENT
*             "Valid" nao funciona em TextBox, regra do projeto - KeyPress
*             com ENTER/TAB simula o Valid) e obj_4c_Mm_obs (EditBox
*             read-only, legado: ControlSource = TmpPends.Obss, ligado em
*             CarregarGrade() pelo mesmo motivo de regra #41 das grades -
*             TmpPends ainda nao existe no momento do AddObject).
*   Fase 7:   GarantirCheckBoxSelecionar() + ChkSelecionarInteractiveChange
*             (toggle da coluna de selecao - legado: fwcheckbox1.
*             InteractiveChange -> ThisForm.Marca()/Desmarca), CmdSelTudoClick/
*             CmdApagaClick (Marca/Desmarca em lote - legado: SelTudo.Click/
*             apaga.Click), CmdTotalizaClick (alterna grd_4c_Itens com
*             grd_4c_Total via this_nContador - legado: Totaliza.Click) e
*             GradeAfterRowColChange (reaplica o "Set Key To" das duas
*             grades de detalhe quando o usuario troca de pendencia -
*             regra #46: sem filtro de coluna, porque recarrega o DETALHE
*             da linha corrente). ConfigurarEventosGrade liga tambem o
*             GotFocus das colunas de exibicao (Usuario/data/Grupo/Conta/
*             Peso) a FocarColunaSelecao, que redireciona sempre para o
*             CheckBox (legado: "ThisForm.Grade.Seleciona.fwcheckbox1.
*             SetFocus" incondicional - mesmo padrao de FormSigOpMpd.prg).
*   Fase 8:   CmdOkClick (o "ok" legado - grava via SigOpMpnBO.
*             ConfirmarMovimentacoes, que povoa xMFas/xOpi/xNensi do form
*             pai e atualiza SigCdNec.ChkSubn, e so fecha o dialogo em
*             caso de sucesso), FecharDialogo/BtnEncerrarClick/
*             BtnCancelarClick (os tres nomes canonicos do projeto
*             convergindo no MESMO funil - o legado nao oferece saida sem
*             gravar: ControlBox=.F., Closable=.F., sem ESC) e Destroy
*             (reabilita o form pai, libera o BO, fecha os cursores
*             PROPRIOS desta tela - TmpPends/xPNensi/xPNensiT - e chama
*             DODEFAULT() por ultimo, regra do projeto sobre os popups do
*             menu principal).
*==============================================================================

DEFINE CLASS FormSigOpMpn AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPMPN;
    *-- WindowState nao tem equivalente direto de uso no projeto e fica
    *-- no default do VFP, igual aos demais dialogos desta familia)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    AlwaysOnTop  = .F.
    ShowTips     = .T.
    DataSession  = 1
    Caption      = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Form chamador (equivalente a pForm/ParentForm do Init legado)
    this_oFormPai = .NULL.

    *-- Modo de operacao do dialogo: COPIA do modo do form pai tirada no
    *-- Init (legado: This.pcEscolha = ThisForm.ParentForm.pcEscolha).
    *-- Valores do projeto ("INCLUIR"/"ALTERAR"/"VISUALIZAR"/"LISTA") no
    *-- lugar dos termos Fortyus 'INSERIR'/'ALTERAR'/'PROCURAR' - usado
    *-- pelas fases seguintes para o When/Visible de SelTudo/Apaga/
    *-- Totaliza e pelo ReadOnly da coluna de selecao da grade (mesmo
    *-- padrao de FormSigOpMpd.prg.this_cModoAtual).
    this_cModoAtual = ""

    *-- Contador auxiliar (equivalente a ThisForm.contador do Init
    *-- legado, 0 na abertura): alterna, no botao Totaliza (fase
    *-- seguinte), qual das duas grades - itens (Gradeitem) ou total
    *-- (GradeTotal) - esta visivel.
    this_nContador = 0

    *--------------------------------------------------------------------------
    * Init - recebe o form chamador (e os dois parametros legados sem
    * equivalente nesta arquitetura - ver nota no cabecalho), copia
    * Empresa/Modo do pai, cria o Business Object e delega a
    * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_nDataSession, par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
                IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
                    THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
                ENDIF
            ENDIF

            THIS.this_nContador = 0

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpMpnBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpMpnBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpMpn.Init")
            ELSE
                *-- Legado: ThisForm.pEmps = ThisForm.ParentForm.pEmps -
                *-- copia simples da empresa do form pai, guardada no BO
                *-- (this_cEmpresa ja existe la - ver cabecalho de
                *-- SigOpMpnBO.prg)
                IF VARTYPE(par_oFormPai) = "O" AND PEMSTATUS(par_oFormPai, "this_cEmpresa", 5)
                    THIS.this_oBusinessObject.this_cEmpresa = par_oFormPai.this_cEmpresa
                ENDIF

                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - fundo do form + cabecalho (SIGOPMPN.cntSombra do
    * dump). Grade de selecao, grades de itens/total e botoes de acao sao
    * das fases seguintes (regra #41 - Column.ControlSource de cursor que
    * ainda nao existe derruba o Init; esses cursores so nascem quando o
    * metodo de carga da Fase 4 roda). Chamado automaticamente por
    * FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen = .T.

            *-- Fundo do form (imagem do Framework Fortyus legado:
            *-- "..\framework\imagens\new_background.jpg" no SCX)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Ordem identica ao dump legado (SECAO 1 - arvore de
            *-- objetos): cntSombra e o primeiro objeto da arvore
            THIS.ConfigurarCabecalho()

            *-- Grade de selecao (TmpPends) + grades de detalhe (xPNensi/
            *-- xPNensiT) + botoes de acao (ok/SelTudo/Apaga/Totaliza) -
            *-- so a ESTRUTURA visual, SEM RecordSource/ControlSource
            *-- (regra #41: Column.ControlSource de cursor que ainda nao
            *-- existe derruba o Init e a tela nao abre). Mesma divisao de
            *-- FormSigOpMpd.prg.
            THIS.ConfigurarGrade()
            THIS.ConfigurarGradesDetalhe()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarEventosBotoes()
            THIS.ConfigurarEventosGrade()

            *-- Label1 + OpSubNivel (SIGOPMPN.Label1/OpSubNivel do dump) -
            *-- so ESTRUTURA visual aqui; o valor de txt_4c_OpSubNivel eh
            *-- preenchido em CarregarGrade() (depende de TmpNens, que e'
            *-- do form pai - mesma razao de ConfigurarGrade/CarregarGrade
            *-- estarem separados, regra #41)
            THIS.ConfigurarCamposComplementares()

            *-- E so DEPOIS a carga, que cria os tres cursores e liga as
            *-- grades (legado: tudo isso acontece dentro do MESMO Init,
            *-- nesta ordem - montagem, Create Cursor, bind). CarregarGrade
            *-- ja chama AjustarBotoesPorModo no fim, porque a visibilidade
            *-- de SelTudo/Apaga/Totaliza depende do SepPedras do nivel,
            *-- que so eh conhecido depois de consultar crSigCdOpd.
            THIS.CarregarGrade()

            THIS.LockScreen = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa escura de titulo (SIGOPMPN.cntSombra do
    * dump), com os dois labels sobrepostos (lblSombra = sombra preta,
    * lblTitulo = titulo branco por cima - mesmo padrao de
    * FormSigOpMpd.prg/FormSigOpLrC.prg/Formsigopagr.prg). Caption dos
    * dois labels recebe a propriedade Caption do form - legado:
    * ThisForm.cntSombra.lblSombra e lblTitulo.Caption = ThisForm.Caption,
    * feito no inicio do Init. Largura em THIS.Width (nao o literal 1100
    * do dump, maior que o Form.Width=1000 do proprio SCX) - regra do
    * projeto sobre container de cabecalho (CLAUDE.md regra #11/#30).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = loc_oCab.Width - 20
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = loc_oCab.Width - 20
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .WordWrap    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grade de selecao (SIGOPMPN.Grade do dump, 7
    * colunas: seleciona/Usuario/codigo/data/Grupo/Conta/Peso). So a
    * ESTRUTURA visual: RecordSource/ControlSource de TmpPends ficam no
    * metodo de carga de dados (fase posterior - TmpPends nao existe
    * ainda, regra #41). ColumnOrder reproduz a ordem VISUAL do dump
    * (diferente da ordem de declaracao das Columns).
    *
    * Column1 "seleciona" embute um CheckBox no legado (fwcheckbox1,
    * ControlSource = TmpPends.Flag - Logico). O AddObject do CheckBox
    * fica para quando Column1.ControlSource apontar para uma coluna
    * Logica de verdade (regra #18 + nota de GarantirCheckBoxSelecionar
    * em FormSigOpMpd.prg, mesma familia de tela) - aqui so o
    * .ReadOnly de nascimento, espelhando o When do legado (fwcheckbox1.
    * When: Return (pcEscolha = 'INSERIR')).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Grade", "Grid")

        WITH THIS.grd_4c_Grade
            .Top               = 118
            .Left              = 12
            .Width             = 668
            .Height            = 260
            .ColumnCount       = 7
            .FontName          = "Courier New"
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
            *-- delas (regra do projeto)
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        *-- Column1 "seleciona" - ColumnOrder=1 (default)
        WITH THIS.grd_4c_Grade.Column1
            .Width     = 15
            .FontName  = "Courier New"
            .FontSize  = 9
            .Movable   = .F.
            .Resizable = .F.
            *-- valor de NASCIMENTO (legado: fwcheckbox1.When). A caixa
            *-- embutida (regra #18) so nasce quando TmpPends existir.
            .ReadOnly  = (THIS.this_cModoAtual != "INCLUIR")
        ENDWITH
        WITH THIS.grd_4c_Grade.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = ""
        ENDWITH

        *-- Column2 "Usuario" - ColumnOrder=7 (ultima coluna visivel)
        WITH THIS.grd_4c_Grade.Column2
            .Width       = 100
            .ColumnOrder = 7
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Usu" + CHR(225) + "rio"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 "codigo" - ColumnOrder=2 (foco inicial do dialogo).
        *-- Legado: CurrentControl = "Ingrid1" (busca incremental por
        *-- Numps, classe propria de framework.vcx, sem porte nesta
        *-- arquitetura) - mantido como Text1 padrao da Column.
        WITH THIS.grd_4c_Grade.Column3
            .Width       = 80
            .ColumnOrder = 2
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "C" + CHR(243) + "digo"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 "data" - ColumnOrder=3
        WITH THIS.grd_4c_Grade.Column4
            .Width       = 75
            .ColumnOrder = 3
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Data"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .Alignment   = 3
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "Grupo" (Grupo de Origem) - ColumnOrder=4
        WITH THIS.grd_4c_Grade.Column5
            .Width       = 130
            .ColumnOrder = 4
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Grupo de Origem"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 "Conta" (Conta de Origem) - ColumnOrder=5
        WITH THIS.grd_4c_Grade.Column6
            .Width       = 130
            .ColumnOrder = 5
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Conta de Origem"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Peso" (Total de Peso) - ColumnOrder=6, SEMPRE
        *-- ReadOnly (legado: Column.Peso.ReadOnly = .T.)
        WITH THIS.grd_4c_Grade.Column7
            .Width       = 100
            .ColumnOrder = 6
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Total de Peso"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradesDetalhe - grd_4c_Itens (SIGOPMPN.Gradeitem) e
    * grd_4c_Total (SIGOPMPN.GradeTotal), ambas com 9 colunas IDENTICAS
    * (mesmas ControlSource no legado: Nops/CMats/CGrus/CUnis/TpOps/Qtds/
    * Pesos/Cats/NEnvs - mesma ordem). So a ESTRUTURA visual aqui -
    * RecordSource/ControlSource ficam no metodo de carga (xPNensi/
    * xPNensiT nao existem ainda, regra #41).
    *
    * grd_4c_Total nasce Visible=.F. (legado, fim do Init:
    * "ThisForm.GradeTotal.Visible = .f."); o botao Totaliza alterna as
    * duas (fase de handlers - THIS.ok.Click do legado so chama Visible
    * em cascata, fica para CmdTotalizaClick em fase posterior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradesDetalhe()
        *-- grd_4c_Itens (Gradeitem) ----------------------------------------
        THIS.AddObject("grd_4c_Itens", "Grid")

        WITH THIS.grd_4c_Itens
            .Top               = 383
            .Left              = 12
            .Width             = 668
            .Height            = 206
            .ColumnCount       = 9
            .FontSize          = 8
            .HeaderHeight      = 16
            .RowHeight         = 16
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        WITH THIS.grd_4c_Itens.Column1
            .Width     = 80
            .FontName  = "Courier New"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Format    = "L"
            .InputMask = "9999999999"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Ordem Produ" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column1.Text1
            .FontName    = "Courier New"
            .FontSize    = 8
            .BorderStyle = 0
            .Format      = "L"
            .InputMask   = "9999999999"
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column2
            .Width     = 108
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Componente"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column2.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column3
            .Width       = 35
            .ColumnOrder = 4
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Grupo"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column3.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column4
            .Width       = 31
            .ColumnOrder = 7
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Unid."
        ENDWITH
        WITH THIS.grd_4c_Itens.Column4.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "Tipo de Material" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Itens.Column5
            .Width       = 90
            .ColumnOrder = 5
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Tipo de Material"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column5.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column6
            .Width       = 60
            .ColumnOrder = 6
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Qtde."
        ENDWITH
        WITH THIS.grd_4c_Itens.Column6.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Peso Atual" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Itens.Column7
            .Width       = 80
            .ColumnOrder = 8
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Peso Atual"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column7.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column8
            .Width       = 31
            .ColumnOrder = 3
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column8.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Cat."
        ENDWITH
        WITH THIS.grd_4c_Itens.Column8.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column9
            .Width     = 69
            .FontSize  = 8
            .Movable   = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column9.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Envelope"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column9.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- grd_4c_Total (GradeTotal) - mesma estrutura, Visible=.F. ------
        THIS.AddObject("grd_4c_Total", "Grid")

        WITH THIS.grd_4c_Total
            .Top               = 383
            .Left              = 12
            .Width             = 688
            .Height            = 206
            .ColumnCount       = 9
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .Visible           = .F.
        ENDWITH

        WITH THIS.grd_4c_Total.Column1
            .Width     = 107
            .FontName  = "Courier New"
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Visible   = .T.
            .Format    = "L"
            .InputMask = "9999999999"
        ENDWITH
        WITH THIS.grd_4c_Total.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Ordem Fabrica" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH THIS.grd_4c_Total.Column1.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Format      = "L"
            .InputMask   = "9999999999"
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column2
            .Width     = 108
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Componente"
        ENDWITH
        WITH THIS.grd_4c_Total.Column2.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column3
            .Width       = 35
            .ColumnOrder = 4
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Grupo"
        ENDWITH
        WITH THIS.grd_4c_Total.Column3.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column4
            .Width       = 31
            .ColumnOrder = 7
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Uni"
        ENDWITH
        WITH THIS.grd_4c_Total.Column4.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "Tipo de Material" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Total.Column5
            .Width       = 97
            .ColumnOrder = 5
            .Movable     = .F.
            .Resizable   = .F.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Tipo de Material"
        ENDWITH
        WITH THIS.grd_4c_Total.Column5.Text1
            .BorderStyle = 0
            .Margin      = 0
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column6
            .Width       = 68
            .ColumnOrder = 6
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Qtde"
        ENDWITH
        WITH THIS.grd_4c_Total.Column6.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Peso Atual" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Total.Column7
            .Width       = 80
            .ColumnOrder = 8
            .Movable     = .F.
            .Resizable   = .F.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Peso Atual"
        ENDWITH
        WITH THIS.grd_4c_Total.Column7.Text1
            .BorderStyle = 0
            .Margin      = 0
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column8
            .Width       = 52
            .ColumnOrder = 3
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column8.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Cat."
        ENDWITH
        WITH THIS.grd_4c_Total.Column8.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column9
            .Width    = 71
            .Movable  = .F.
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column9.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Envelope"
        ENDWITH
        WITH THIS.grd_4c_Total.Column9.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Shape1 (moldura decorativa, legado:
    * BackStyle=0 + BorderStyle=0, sem efeito visual - transcrito fiel)
    * + ok/SelTudo/apaga/Totaliza. Ordem identica ao dump (SECAO 1):
    * Shape1, SelTudo, apaga, ok, Totaliza - todos filhos diretos do
    * form, criados DEPOIS das grades.
    *
    * Tamanhos canonicos (fwbtnp=36x36 para icone 26px, fwbtng=75x75
    * para icone 60px - SCX nao declara Width/Height, propriedade da
    * classe de framework.vcx; mesmos valores de FormSigOpMpd.prg,
    * mesma familia de tela).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 818
            .Width       = 171
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- SelTudo (legado: fwbtnp) - marca todas as linhas de TmpPends
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top          = 145
            .Left         = 690
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .MousePointer = 15
            .ToolTipText  = "Seleciona Tudo"
            .Picture      = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
        ENDWITH

        *-- apaga (legado: fwbtnp) - desmarca todas as linhas de TmpPends
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top          = 145
            .Left         = 731
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .MousePointer = 15
            .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
        ENDWITH

        *-- ok (legado: fwbtng) - grava a movimentacao
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- Totaliza (legado: fwbtng) - alterna grd_4c_Itens/grd_4c_Total
        THIS.AddObject("cmd_4c_Totaliza", "CommandButton")
        WITH THIS.cmd_4c_Totaliza
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Total"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Total"
            .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- legado (fim do Init): ThisForm.SelTudo.Visible / Apaga.
        *-- Visible / Totaliza.Visible atribuidos DEPOIS de os botoes
        *-- existirem
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes - BINDEVENT dos quatro botoes de acao
    * (ok/SelTudo/apaga/Totaliza). Handlers alvo sao PUBLIC de proposito -
    * BINDEVENT falha em silencio com metodo PROTECTED (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
        BINDEVENT(THIS.cmd_4c_Totaliza, "Click", THIS, "CmdTotalizaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosGrade - BINDEVENT do AfterRowColChange da grade de
    * selecao e do redirecionamento de foco das colunas de EXIBICAO
    * (Usuario/data/Grupo/Conta/Peso) para o CheckBox embutido na Column1 -
    * legado: GotFocus de cada uma chama "ThisForm.Grade.Seleciona.
    * fwcheckbox1.SetFocus" incondicionalmente. Column3 "codigo" NAO entra
    * aqui: eh o foco inicial natural do dialogo (Ingrid1/busca incremental
    * no legado), igual ao padrao de FormSigOpMpd.prg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosGrade()
        BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column5.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column6.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column7.Text1, "GotFocus", THIS, "FocarColunaSelecao")
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Visible de SelTudo/Apaga/Totaliza (regra
    * #40: quem desabilita no funil, reabilita no funil - chamado de
    * novo pela fase que recarrega a grade, ja que RecordSource reseta
    * estado da Column mas nao destes botoes).
    *
    * Legado (fim do Init):
    *   ThisForm.SelTudo.Visible   = (pcEscolha = 'INSERIR')
    *   ThisForm.Apaga.Visible     = (pcEscolha = 'INSERIR')
    *   ThisForm.Totaliza.Visible  = (pcEscolha = 'INSERIR' And
    *                                 CrSigCdOpd.SepPedras = 4)
    *
    * CrSigCdOpd so fica POSICIONADO no "nivel" certo depois que o
    * metodo de carga da necessidade corrente roda (Seek(TmpPends.Dopps,
    * 'crSigCdOpd', 'Dopps') - mesmo Dopps que THIS.this_oBusinessObject.
    * this_cDopps guarda, da linha corrente de TmpPends via
    * CarregarDoCursor). Antes disso (TmpPends ainda vazio - esta fase),
    * this_cDopps esta vazio e Totaliza fica oculto - correto, nao eh
    * stub: o calculo e' real e so avalia .T. quando ha dado para
    * avaliar.
    *--------------------------------------------------------------------------
    *-- PUBLIC (regra #3): o harness de teste chama AjustarBotoesPorModo()
    *-- direto de fora da classe, e PEMSTATUS(oForm, <metodo>, 5) devolve .T.
    *-- mesmo para metodo PROTECTED (so testa existencia, nao escopo) - o
    *-- teste entraria no branch e a chamada falharia em runtime.
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoIncluir, loc_lSeparaPedras, loc_cAliasAnterior

        loc_lModoIncluir  = (THIS.this_cModoAtual == "INCLUIR")
        loc_lSeparaPedras = .F.

        *-- SepPedras vem do registro do NIVEL em SigCdOpd. Depois da carga
        *-- quem tem o valor autoritativo eh o BO (SigOpMpnBO.CarregarNivel
        *-- grava this_nSepPedras na SEGUNDA consulta, que eh justamente a
        *-- do nivel) - ler a property evita depender do ponteiro de um
        *-- cursor global estar parado no registro certo.
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                PEMSTATUS(THIS.this_oBusinessObject, "this_nSepPedras", 5)
            loc_lSeparaPedras = (THIS.this_oBusinessObject.this_nSepPedras = 4)
        ENDIF

        *-- Fallback para antes da carga (property ainda em 0): le o cursor
        *-- global, como o legado faz
        IF !loc_lSeparaPedras AND USED("crSigCdOpd") AND ;
                VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                !EMPTY(THIS.this_oBusinessObject.this_cDopps)
            loc_cAliasAnterior = ALIAS()

            IF SEEK(THIS.this_oBusinessObject.this_cDopps, "crSigCdOpd", "Dopps")
                loc_lSeparaPedras = (crSigCdOpd.SepPedras = 4)
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Visible = loc_lModoIncluir
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Visible = loc_lModoIncluir
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Totaliza", 5)
            THIS.cmd_4c_Totaliza.Visible = (loc_lModoIncluir AND loc_lSeparaPedras)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposComplementares - Label1 + OpSubNivel (dump: filhos
    * DIRETOS do form, Top=89..93, Left=12..324 - a esquerda da grade de
    * selecao). txt_4c_OpSubNivel exibe o "Nivels" do nivel de DESTINO da
    * movimentacao de subnivel; o legado bloqueia o foco com "PROCEDURE
    * When / Return .f." (nunca editavel por teclado) - aqui reproduzido
    * com .ReadOnly = .T., que preserva a aparencia normal do TextBox (o
    * legado nao usa DisabledBackColor nem Enabled = .F. para este campo).
    *
    * So a ESTRUTURA visual: o Value de txt_4c_OpSubNivel e' calculado em
    * CarregarGrade() porque depende de TmpNens (cursor do form PAI,
    * visivel aqui por nome - DataSession=1 compartilhada) e crSigCdOpd
    * (cursor global), nenhum dos dois garantido no momento do Init.
    *
    * lbl_4c__Procura/txt_4c_Procura (SIGOPMPN.Say_Procura/Get_Procura do
    * dump) sao a busca incremental por Numps na grade de selecao - so a
    * ESTRUTURA aqui; o Valid/LostFocus legado vira ValidarProcuraNumero/
    * TxtProcuraKeyPress/TxtProcuraLostFocus (ver nota la). Os BINDEVENT
    * ficam AQUI (e nao em CarregarGrade) porque os handlers nao dependem
    * de TmpPends existir - so o CORPO deles consulta o cursor, com guarda
    * USED() (mesmo padrao do resto do form).
    *
    * obj_4c_Mm_obs (SIGOPMPN.mm_obs do dump) e' o EditBox de observacao -
    * SEMPRE ReadOnly = .T. no legado (simples exibicao, nunca editavel).
    * So a ESTRUTURA aqui: o ControlSource ("TmpPends.Obss") fica em
    * CarregarGrade() pela MESMA razao das colunas das grades (regra #41 -
    * TmpPends ainda nao existe neste ponto do Init).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposComplementares()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 93
            .Left      = 12
            .Width     = 136
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Subn" + CHR(237) + "vel :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_OpSubNivel", "TextBox")
        WITH THIS.txt_4c_OpSubNivel
            .Top       = 89
            .Left      = 150
            .Width     = 174
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Format    = "K"
            .Value     = ""
            *-- legado: Procedure When / Return .f. - nunca recebe foco
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c__Procura (Say_Procura) - AutoSize do dump eh NO-OP em
        *-- Label criado por AddObject (regra #23): Width explicita =
        *-- Width do dump, Alignment = 0 (classe say, sem Alignment
        *-- declarado no dump)
        THIS.AddObject("lbl_4c__Procura", "Label")
        WITH THIS.lbl_4c__Procura
            .AutoSize  = .F.
            .Top       = 93
            .Left      = 524
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Busca de  C" + CHR(243) + "digos :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Procura (Get_Procura) - numerico (Value=0 no dump),
        *-- MaxLength=6 transcrito literal; sem InputMask no dump (o
        *-- Value numerico ja restringe a digitos/sinal)
        THIS.AddObject("txt_4c_Procura", "TextBox")
        WITH THIS.txt_4c_Procura
            .Top         = 89
            .Left        = 622
            .Width       = 58
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
            .Format      = "K"
            .MaxLength   = 6
            .Value       = 0
            .ToolTipText = "Busca de C" + CHR(243) + "digos"
            .Visible     = .T.
        ENDWITH

        *-- KeyPress/LostFocus substituem Valid/LostFocus (BINDEVENT
        *-- "Valid" nao funciona em TextBox - regra do projeto)
        BINDEVENT(THIS.txt_4c_Procura, "KeyPress", THIS, "TxtProcuraKeyPress")
        BINDEVENT(THIS.txt_4c_Procura, "LostFocus", THIS, "TxtProcuraLostFocus")

        *-- obj_4c_Mm_obs (mm_obs) - ReadOnly = .T. de nascimento (igual ao
        *-- dump); ControlSource fica para CarregarGrade() (regra #41)
        THIS.AddObject("obj_4c_Mm_obs", "EditBox")
        WITH THIS.obj_4c_Mm_obs
            .Top               = 192
            .Left              = 690
            .Width             = 301
            .Height            = 184
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ReadOnly          = .T.
            .DisabledBackColor = RGB(255, 255, 220)
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProcuraNumero - equivalente ao Valid legado de Get_Procura:
    *
    *   If Not Empty(This.Value)
    *       Select TmpPends / Set Order To Numps / Set Near On
    *       Seek This.Value / Set Near Off
    *       ThisForm.Refresh
    *       If (This.Value = TmpPends.Numps)
    *           This.Value = 0
    *       Else
    *           Return 0
    *       EndIf
    *   EndIf
    *
    * "Return 0" do Valid legado mantem o foco no campo (SET NEAR so achou
    * um vizinho, nao o Numps exato digitado) - aqui devolve .F. para o
    * KeyPress decidir com NODEFAULT (ver TxtProcuraKeyPress). THIS.Refresh()
    * repinta a grade de selecao (posicionada pelo SEEK) e obj_4c_Mm_obs
    * (ControlSource = TmpPends.Obss, muda com o registro corrente).
    *
    * PROTECTED: so chamado de dentro da classe (regra #51 - nao eh metodo
    * que precise ser alcancado de fora, diferente dos handlers de evento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarProcuraNumero()
        LOCAL loc_lPodeSair, loc_cAliasPends, loc_cAliasAnterior, loc_nValor

        loc_lPodeSair   = .T.
        loc_cAliasPends = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
        ENDIF

        IF !EMPTY(THIS.txt_4c_Procura.Value) AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
            loc_nValor         = THIS.txt_4c_Procura.Value
            loc_cAliasAnterior = ALIAS()

            SELECT (loc_cAliasPends)
            SET ORDER TO Numps
            SET NEAR ON
            SEEK loc_nValor
            SET NEAR OFF

            THIS.Refresh()

            IF loc_nValor = EVALUATE(loc_cAliasPends + ".Numps")
                THIS.txt_4c_Procura.Value = 0
            ELSE
                loc_lPodeSair = .F.
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        RETURN loc_lPodeSair
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtProcuraKeyPress - PUBLIC (regra #3: alvo de BINDEVENT). Testa
    * ENTER(13)/TAB(9) para simular o Valid legado (BINDEVENT "Valid" nao
    * funciona em TextBox).
    *
    * TAB: quando ValidarProcuraNumero() devolve .F. (entrada invalida), o
    * NODEFAULT suprime a navegacao padrao do Tab - o campo continua com o
    * foco, igual ao "Return 0" do Valid legado.
    *
    * ENTER: diferente do Tab, Enter NAO move o foco por padrao no VFP9 -
    * sem este bloco extra o legado jamais chegaria a perder o foco so por
    * Enter, e TxtProcuraLostFocus (equivalente ao LostFocus legado) nunca
    * dispararia. Forcar o foco para a coluna de selecao aqui reproduz o
    * MESMO destino do LostFocus legado, so que pela via do Enter.
    *--------------------------------------------------------------------------
    PROCEDURE TxtProcuraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF !THIS.ValidarProcuraNumero()
                NODEFAULT
            ELSE
                IF par_nKeyCode = 13
                    NODEFAULT
                    THIS.FocarColunaSelecao()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtProcuraLostFocus - PUBLIC (regra #3: alvo de BINDEVENT). Equivalente
    * ao LostFocus legado de Get_Procura:
    *
    *   If (TmpPends.Numps = This.Value) Or (This.Value = 0)
    *       ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus
    *   EndIf
    *
    * Dispara sempre que o campo perde o foco DE VERDADE (Tab, clique, ou o
    * SetFocus programatico que o proprio TxtProcuraKeyPress dispara no
    * caso do Enter) - complementa o Enter (que o KeyPress ja resolve
    * direto) cobrindo Tab/clique, que o legado tambem atende.
    *--------------------------------------------------------------------------
    PROCEDURE TxtProcuraLostFocus()
        LOCAL loc_cAliasPends, loc_lPodeFocar

        loc_cAliasPends = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
        ENDIF

        loc_lPodeFocar = (THIS.txt_4c_Procura.Value = 0)

        IF !loc_lPodeFocar AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
            loc_lPodeFocar = (EVALUATE(loc_cAliasPends + ".Numps") = THIS.txt_4c_Procura.Value)
        ENDIF

        IF loc_lPodeFocar
            THIS.FocarColunaSelecao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarColunaSelecao - PUBLIC (mesmo nome/padrao de FormSigOpMpd.prg,
    * mesma familia de tela - reutilizavel pelos GotFocus das colunas de
    * exibicao da grade, fase posterior). Redireciona o foco para o
    * CheckBox embutido na coluna de selecao, quando ele ja existe (so
    * nasce em GarantirCheckBoxSelecionar, chamado por CarregarGrade -
    * regra #18).
    *--------------------------------------------------------------------------
    PROCEDURE FocarColunaSelecao()
        IF PEMSTATUS(THIS, "grd_4c_Grade", 5) AND ;
                PEMSTATUS(THIS.grd_4c_Grade.Column1, "chk_4c_Selecionar", 5)
            THIS.grd_4c_Grade.Column1.chk_4c_Selecionar.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCheckBoxSelecionar - embute o CheckBox na coluna de selecao da
    * grade (legado: SIGOPMPN.Grade.seleciona.fwcheckbox1, ControlSource =
    * TmpPends.Flag).
    *
    * Vive separado de ConfigurarGrade porque so pode rodar DEPOIS de
    * Column1.ControlSource apontar para TmpPends.Flag, que eh Logico - e
    * TmpPends nasce na carga, nao na montagem da tela (regra #41). Alem
    * disso RecordSource RECRIA os objetos Column, entao a caixa tem de ser
    * reinstalada a CADA rebind: por isso o PEMSTATUS, que torna o metodo
    * idempotente.
    *
    * Os tres comandos sao inseparaveis (regra #18): AddObject so CRIA o
    * objeto - sem CurrentControl a coluna continua desenhando o Text1 dela,
    * e sem Sparse = .F. o CheckBox aparece apenas na linha ativa.
    *
    * O TOGGLE (Click/MouseDown/MouseUp/KeyPress com NODEFAULT, que eh como
    * o legado alterna o valor - ele SUPRIME o toggle nativo e faz o Replace
    * por codigo, ver SIGOPMPN.Grade.seleciona.fwcheckbox1.InteractiveChange
    * -> ThisForm.Marca/Desmarca) eh da fase de EVENTOS. Aqui NAO se chama
    * BINDEVENT: apontar para um handler que ainda nao existe estoura no
    * proprio bind.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCheckBoxSelecionar()
        LOCAL loc_oColuna
        loc_oColuna = THIS.grd_4c_Grade.Column1

        IF !PEMSTATUS(loc_oColuna, "chk_4c_Selecionar", 5)
            loc_oColuna.AddObject("chk_4c_Selecionar", "CheckBox")

            WITH loc_oColuna.chk_4c_Selecionar
                .Caption   = ""
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- legado: fwcheckbox1.InteractiveChange (=DoDefault() + If Not
            *-- This.Value / ThisForm.Desmarca / Else / This.Value =
            *-- ThisForm.Marca() / EndIf) - BINDEVENT dentro do MESMO IF: o
            *-- objeto so eh recriado quando RecordSource derruba a Column,
            *-- e um bind duplicado sobre o MESMO objeto empilharia o
            *-- handler
            BINDEVENT(loc_oColuna.chk_4c_Selecionar, "InteractiveChange", ;
                THIS, "ChkSelecionarInteractiveChange")
        ENDIF

        loc_oColuna.CurrentControl = "chk_4c_Selecionar"
        loc_oColuna.Sparse         = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - funil UNICO de carga e vinculo das TRES grades.
    * Transcricao do trecho final do Init legado: depois de montar TmpPends/
    * xPNensi/xPNensiT, ele faz o "With Thisform.Grade / .RecordSource = ...
    * / .<coluna>.ControlSource = ..." para Grade, Gradeitem e GradeTotal.
    *
    * PUBLIC (regra #3/#51): o harness de teste chama CarregarLista/
    * CarregarGrade de FORA da classe, e PEMSTATUS(...,5) devolve .T. para
    * metodo PROTECTED, entao o teste entraria no branch e a chamada
    * falharia em runtime.
    *
    * SigOpMpnBO.CarregarPendencias() recria os tres cursores do zero (mesma
    * semantica do "Create Cursor" do Init legado) e so DEPOIS as grades sao
    * ligadas - regra #41: Column.ControlSource de cursor que ainda nao
    * existe derruba o Init e a tela nao abre.
    *
    * Ordem obrigatoria por grade: RecordSource -> ControlSource -> (Column1:
    * AddObject do CheckBox) -> Width -> Header1.Caption -> ReadOnly. Mexer
    * em RecordSource RECALCULA as larguras para o default 90 e reseta
    * Header1.Caption, Sparse, CurrentControl e o ReadOnly das colunas (que
    * volta a herdar o do Grid) - por isso tudo isso eh reaplicado AQUI, e
    * nao so em ConfigurarGrade/ConfigurarGradesDetalhe (Problema 48 do
    * FormCor; o ReadOnly da coluna sempre DEPOIS do ReadOnly do Grid).
    *
    * Bypass de SQL em modo teste/ValidarUIFidelity: TmpNens/TmpOperacao sao
    * cursores do form PAI e nao existem em instanciacao headless - as
    * grades ficam com a estrutura montada e sem dado, o que basta para a
    * validacao de UI.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_lBypassTeste, loc_oErro
        LOCAL loc_cPends, loc_cPNensi, loc_cPNensiT, loc_cChaveDetalhe
        LOCAL loc_cNivelDestino, loc_cAliasNivelAnt

        loc_lSucesso = .F.

        TRY
            loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

            *-- Legado (Init, antes do "Create Cursor TmpPends"):
            *-- "=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _DoppsNivel =
            *-- crSigCdOpd.Nivels / ThisForm.OpSubNivel.Value = _DoppsNivel"
            *-- - descricao do NIVEL de destino, lida do cursor global
            *-- crSigCdOpd pela chave do nivel corrente do form pai
            *-- (TmpNens.Dopps). TmpNens nao existe em modo teste/
            *-- ValidarUIFidelity headless (cursor do form pai) - o guard
            *-- USED() deixa o campo vazio nesse caso, igual ao resto da
            *-- tela.
            IF PEMSTATUS(THIS, "txt_4c_OpSubNivel", 5)
                loc_cNivelDestino = ""
                IF USED("TmpNens") AND USED("crSigCdOpd")
                    loc_cAliasNivelAnt = ALIAS()
                    IF SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
                        loc_cNivelDestino = crSigCdOpd.Nivels
                    ENDIF
                    IF !EMPTY(loc_cAliasNivelAnt) AND USED(loc_cAliasNivelAnt)
                        SELECT (loc_cAliasNivelAnt)
                    ENDIF
                ENDIF
                THIS.txt_4c_OpSubNivel.Value = loc_cNivelDestino
            ENDIF

            loc_cPends   = THIS.this_oBusinessObject.this_cCursorPends
            loc_cPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
            loc_cPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT

            IF !loc_lBypassTeste
                THIS.this_oBusinessObject.CarregarPendencias()
            ENDIF

            *-- Grade de selecao (legado: With Thisform.Grade) -------------
            IF USED(loc_cPends)
                *-- RecordSource FORA do WITH (regra do projeto): mexer em
                *-- RecordSource recria as Column, e acessa-las dentro do
                *-- MESMO WITH que acabou de atribuir RecordSource estoura
                *-- 'Unknown member COLUMN1'
                THIS.grd_4c_Grade.RecordSource = loc_cPends

                *-- Mapeamento coluna -> campo transcrito do legado, que
                *-- liga as colunas pelo NOME (.Seleciona/.Usuario/
                *-- .Codigo/.Data/.Grupo/.Conta/.Peso); aqui pelo numero
                *-- da Column correspondente (ver ConfigurarGrade)
                WITH THIS.grd_4c_Grade
                    .Column1.ControlSource = loc_cPends + ".Flag"
                    .Column2.ControlSource = loc_cPends + ".Usuars"
                    .Column3.ControlSource = loc_cPends + ".Numps"
                    .Column4.ControlSource = loc_cPends + ".Datas"
                    .Column5.ControlSource = loc_cPends + ".Grupo"
                    .Column6.ControlSource = loc_cPends + ".Conta"
                    .Column7.ControlSource = loc_cPends + ".TPesos"
                ENDWITH

                *-- SO AGORA Column1 aponta para Flag (Logico): eh seguro
                *-- embutir o CheckBox (regra #18)
                THIS.GarantirCheckBoxSelecionar()

                WITH THIS.grd_4c_Grade
                    .Column1.Width = 15
                    .Column2.Width = 100
                    .Column3.Width = 80
                    .Column4.Width = 75
                    .Column5.Width = 130
                    .Column6.Width = 130
                    .Column7.Width = 100

                    .Column1.Header1.Caption = ""
                    .Column2.Header1.Caption = "Usu" + CHR(225) + "rio"
                    .Column3.Header1.Caption = "C" + CHR(243) + "digo"
                    .Column4.Header1.Caption = "Data"
                    .Column5.Header1.Caption = "Grupo de Origem"
                    .Column6.Header1.Caption = "Conta de Origem"
                    .Column7.Header1.Caption = "Total de Peso"

                    *-- Reafirma, DEPOIS do RecordSource, as duas unicas
                    *-- regras de edicao do legado: o When do fwcheckbox1
                    *-- (Return (pcEscolha = 'INSERIR')) na coluna de
                    *-- selecao e o Peso sempre somente-leitura
                    .Column1.ReadOnly = (THIS.this_cModoAtual != "INCLUIR")
                    .Column7.ReadOnly = .T.
                ENDWITH

                *-- obj_4c_Mm_obs (mm_obs) - mesma razao de regra #41 das
                *-- colunas da grade: TmpPends nao existia no momento do
                *-- AddObject (ConfigurarCamposComplementares), so agora o
                *-- ControlSource pode apontar para ele
                IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
                    THIS.obj_4c_Mm_obs.ControlSource = loc_cPends + ".Obss"
                ENDIF

                *-- Legado, ANTES de qualquer bind de detalhe: "Select
                *-- TmpPends / Go Bottom". A linha CORRENTE passa a ser a
                *-- ULTIMA, e eh dela que sai a chave mestre-detalhe logo
                *-- abaixo - por isso o Go Bottom vem AQUI e nao no fim do
                *-- metodo: posicionar depois deixaria a grade destacando a
                *-- ultima pendencia com as grades de baixo mostrando os
                *-- itens da PRIMEIRA.
                SELECT (loc_cPends)
                GO BOTTOM
                THIS.grd_4c_Grade.Refresh()
            ENDIF

            *-- Chave mestre-detalhe: as duas grades de baixo mostram so os
            *-- itens da pendencia CORRENTE. Legado: "Set Key To
            *-- TmpPends.Emps + TmpPends.Dopps + STr(TmpPends.Numps, 10)",
            *-- avaliado com TmpPends na linha em que o Go Bottom o deixou.
            *-- Chave POSICIONAL char(33) - PADR explicito em cada parte,
            *-- NUNCA ALLTRIM (regra #42). Com TmpPends vazio/ausente a
            *-- chave fica vazia e as grades de detalhe nao filtram nada,
            *-- que eh o estado correto de tela sem pendencia selecionada.
            loc_cChaveDetalhe = ""
            IF USED(loc_cPends) AND !EOF(loc_cPends)
                loc_cChaveDetalhe = PADR(EVALUATE(loc_cPends + ".Emps"), 3) + ;
                    PADR(EVALUATE(loc_cPends + ".Dopps"), 20) + ;
                    STR(EVALUATE(loc_cPends + ".Numps"), 10)
            ENDIF

            *-- Grade de itens (legado: With Thisform.Gradeitem) -----------
            IF USED(loc_cPNensi)
                THIS.VincularGradeDetalhe(THIS.grd_4c_Itens, loc_cPNensi, loc_cChaveDetalhe)

                *-- Larguras/titulos proprios da grade de ITENS
                WITH THIS.grd_4c_Itens
                    .Column1.Width = 80
                    .Column2.Width = 108
                    .Column3.Width = 35
                    .Column4.Width = 31
                    .Column5.Width = 90
                    .Column6.Width = 60
                    .Column7.Width = 80
                    .Column8.Width = 31
                    .Column9.Width = 69

                    .Column1.Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
                    .Column2.Header1.Caption = "Componente"
                    .Column3.Header1.Caption = "Grupo"
                    .Column4.Header1.Caption = "Unid."
                    .Column5.Header1.Caption = "Tipo de Material"
                    .Column6.Header1.Caption = "Qtde."
                    .Column7.Header1.Caption = "Peso Atual"
                    .Column8.Header1.Caption = "Cat."
                    .Column9.Header1.Caption = "Envelope"
                ENDWITH
            ENDIF

            *-- Grade de total (legado: With Thisform.GradeTotal) ----------
            IF USED(loc_cPNensiT)
                THIS.VincularGradeDetalhe(THIS.grd_4c_Total, loc_cPNensiT, loc_cChaveDetalhe)

                *-- Larguras/titulos proprios da grade de TOTAL
                WITH THIS.grd_4c_Total
                    .Column1.Width = 107
                    .Column2.Width = 108
                    .Column3.Width = 35
                    .Column4.Width = 31
                    .Column5.Width = 97
                    .Column6.Width = 68
                    .Column7.Width = 80
                    .Column8.Width = 52
                    .Column9.Width = 71

                    .Column1.Header1.Caption = "Ordem Fabrica" + CHR(231) + CHR(227) + "o"
                    .Column2.Header1.Caption = "Componente"
                    .Column3.Header1.Caption = "Grupo"
                    .Column4.Header1.Caption = "Uni"
                    .Column5.Header1.Caption = "Tipo de Material"
                    .Column6.Header1.Caption = "Qtde"
                    .Column7.Header1.Caption = "Peso Atual"
                    .Column8.Header1.Caption = "Cat."
                    .Column9.Header1.Caption = "Envelope"
                ENDWITH
            ENDIF

            *-- Devolve a area de trabalho corrente a TmpPends: as duas
            *-- chamadas a VincularGradeDetalhe deixam o alias em xPNensi/
            *-- xPNensiT, e o resto da tela (grade de selecao, EditBox de
            *-- observacao, handlers) trabalha sobre TmpPends. O ponteiro
            *-- segue na ULTIMA linha, onde o Go Bottom acima o deixou -
            *-- sem reposicionar de novo, para nao desalinhar da chave
            *-- mestre-detalhe que as grades de baixo ja estao usando.
            IF USED(loc_cPends)
                SELECT (loc_cPends)
                THIS.grd_4c_Grade.Refresh()
            ENDIF

            *-- Visibilidade de SelTudo/Apaga/Totaliza depende de
            *-- SepPedras, que so eh conhecido depois da carga
            THIS.AjustarBotoesPorModo()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeDetalhe - liga UMA das duas grades de detalhe ao seu
    * cursor. As duas tem as MESMAS 9 colunas, nas MESMAS ControlSource do
    * legado (Nops/CMats/CGrus/CUnis/TpOps/Qtds/Pesos/Cats/NEnvs, nessa
    * ordem), por isso o bind eh um metodo unico - so largura e titulo
    * diferem, e ficam no chamador.
    *
    * SET ORDER TO EmpDopNum + SET KEY TO reproduzem o filtro mestre-detalhe
    * do legado ("Select xPnensiT / Set Order to EmpDopNum / Go Top / Set
    * Key To <chave de TmpPends>"). Em xPNensi o legado conta com o indice
    * EmpDopNum estar ativo por ser o ULTIMO criado - aqui a ordem eh
    * explicita, que eh o mesmo efeito sem depender dessa ordem.
    *
    * Todas as 9 colunas voltam a ReadOnly = .T. DEPOIS do RecordSource: as
    * duas grades sao de exibicao (no legado cada Text1 delas tem
    * "When: Return .f.") e o RecordSource faz a coluna herdar de novo o
    * ReadOnly = .F. do Grid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeDetalhe(par_oGrade, par_cCursor, par_cChave)
        LOCAL loc_nI

        SELECT (par_cCursor)
        SET ORDER TO EmpDopNum
        GO TOP
        IF EMPTY(par_cChave)
            SET KEY TO
        ELSE
            SET KEY TO par_cChave
        ENDIF

        *-- RecordSource FORA do WITH (regra do projeto): mexer em
        *-- RecordSource recria as Column, e acessa-las dentro do MESMO
        *-- WITH que acabou de atribuir RecordSource estoura 'Unknown
        *-- member COLUMN1'
        par_oGrade.RecordSource = par_cCursor

        WITH par_oGrade
            .Column1.ControlSource = par_cCursor + ".Nops"
            .Column2.ControlSource = par_cCursor + ".CMats"
            .Column3.ControlSource = par_cCursor + ".CGrus"
            .Column4.ControlSource = par_cCursor + ".CUnis"
            .Column5.ControlSource = par_cCursor + ".TpOps"
            .Column6.ControlSource = par_cCursor + ".Qtds"
            .Column7.ControlSource = par_cCursor + ".Pesos"
            .Column8.ControlSource = par_cCursor + ".Cats"
            .Column9.ControlSource = par_cCursor + ".NEnvs"
        ENDWITH

        *-- Column.ReadOnly SEMPRE depois do Grid.ReadOnly (o do Grid
        *-- propaga e sobrescreve) - regra #18/#46
        FOR loc_nI = 1 TO par_oGrade.ColumnCount
            par_oGrade.Columns(loc_nI).ReadOnly = .T.
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        par_oGrade.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - nome canonico de carga do projeto; funil unico para
    * CarregarGrade(). PUBLIC pelo mesmo motivo (o harness chama de fora -
    * regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkSelecionarInteractiveChange - legado: SIGOPMPN.Grade.seleciona.
    * fwcheckbox1.InteractiveChange:
    *     =DoDefault()
    *     If Not This.Value
    *         ThisForm.Desmarca
    *     Else
    *         This.Value = ThisForm.Marca()
    *     EndIf
    *
    * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
    * handler disparar. THIS.this_oBusinessObject.CarregarDoCursor() le a
    * linha CORRENTE (this_cEmps/this_cDopps/this_nNumps/this_dDatas), que
    * Marcar()/Desmarcar() usam. Em .T. (marcando), Marcar() pode recusar
    * (duplicidade/numeracao-automatica/data) - nesse caso desfaz o Flag,
    * equivalente a "This.Value = ThisForm.Marca()" quando o retorno eh
    * .F. Quando Marcar() sinaliza this_lFecharAposMarcar (legado:
    * "This.ok.click" dentro do proprio marca, ramo _NumeroAnt), o RETURN
    * fica FORA do TRY (regra #1) e so entao fecha via CmdOkClick.
    *
    * PUBLIC (regra #3: alvo de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE ChkSelecionarInteractiveChange()
        LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_lFechar, loc_oErro

        loc_lFechar = .F.

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                loc_lNovoValor = ConverterParaLogico(Flag)

                THIS.this_oBusinessObject.CarregarDoCursor()

                IF loc_lNovoValor
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)

                    IF !loc_lResultado
                        SELECT (loc_cAlias)
                        REPLACE Flag WITH .F.
                    ELSE
                        loc_lFechar = THIS.this_oBusinessObject.this_lFecharAposMarcar
                    ENDIF
                ELSE
                    THIS.this_oBusinessObject.Desmarcar()
                ENDIF

                IF !loc_lFechar
                    SELECT (loc_cAlias)
                    THIS.grd_4c_Grade.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.ChkSelecionarInteractiveChange")
        ENDTRY

        IF loc_lFechar
            THIS.CmdOkClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - legado: SIGOPMPN.SelTudo.Click
    *     Select TmpPends
    *     Scan For Not Flag
    *         Replace Flag With ThisForm.Marca(.t.)
    *     EndScan
    *     ThisForm.Grade.Refresh
    *
    * Interrompe o Scan (EXIT) e fecha o dialogo (CmdOkClick) assim que
    * Marcar() sinalizar this_lFecharAposMarcar - mesma semantica do
    * legado, onde "This.ok.click" dentro de marca() libera (Release) o
    * form NO MEIO do Scan.
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        LOCAL loc_cAlias, loc_lResultado, loc_lFecharApos, loc_oErro

        loc_lFecharApos = .F.

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR !Flag
                    THIS.this_oBusinessObject.CarregarDoCursor()
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)

                    SELECT (loc_cAlias)
                    REPLACE Flag WITH loc_lResultado

                    IF loc_lResultado AND THIS.this_oBusinessObject.this_lFecharAposMarcar
                        loc_lFecharApos = .T.
                        EXIT
                    ENDIF

                    SELECT (loc_cAlias)
                ENDSCAN

                IF !loc_lFecharApos
                    THIS.grd_4c_Grade.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdSelTudoClick")
        ENDTRY

        IF loc_lFecharApos
            THIS.CmdOkClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - legado: SIGOPMPN.apaga.Click
    *     Select TmpPends
    *     Scan For Flag
    *         Replace Flag With ThisForm.DesMarca()
    *     EndScan
    *     ThisForm.Grade.Refresh
    *
    * DESVIO DOCUMENTADO: "DesMarca()" no legado so tem "Return 0" no
    * caminho de ERRO (falha de SqlExecute); sem RETURN explicito no
    * caminho normal, VFP devolve .T. implicito - logo "Replace Flag With
    * ThisForm.DesMarca()" tende a GRAVAR Flag = .T. de volta (reversao
    * acidental do proprio "apagar"), e no caminho de erro tentaria gravar
    * o NUMERO 0 num campo Logico (type mismatch). Mesmo padrao ja adotado
    * em FormSigOpMpd.CmdApagaClick (mesma familia de tela): zera Flag
    * ANTES de chamar Desmarcar(), sem depender do retorno.
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR Flag
                    SELECT (loc_cAlias)
                    REPLACE Flag WITH .F.
                    THIS.this_oBusinessObject.CarregarDoCursor()
                    THIS.this_oBusinessObject.Desmarcar()
                    SELECT (loc_cAlias)
                ENDSCAN

                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdApagaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdTotalizaClick - legado: SIGOPMPN.Totaliza.Click. Alterna grd_4c_
    * Itens (Gradeitem) com grd_4c_Total (GradeTotal) via this_nContador
    * (legado: ThisForm.contador/ContaDor).
    *--------------------------------------------------------------------------
    PROCEDURE CmdTotalizaClick()
        IF THIS.this_nContador = 0
            THIS.grd_4c_Itens.Visible = .F.
            THIS.grd_4c_Total.Visible = .T.
            THIS.grd_4c_Total.Refresh()
            THIS.this_nContador       = 1
            THIS.cmd_4c_Totaliza.Caption = "Itens"
        ELSE
            THIS.grd_4c_Itens.Visible = .T.
            THIS.grd_4c_Total.Visible = .F.
            THIS.grd_4c_Itens.Refresh()
            THIS.this_nContador       = 0
            THIS.cmd_4c_Totaliza.Caption = "Totaliza"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - legado: SIGOPMPN.Grade.AfterRowColChange.
    * Reaplica o "Set Key To" das duas grades de detalhe (itens/total) com
    * a chave da linha NOVA de TmpPends (regra #46: SEM filtro de coluna -
    * este handler recarrega o DETALHE da linha corrente, nao valida
    * celula).
    *
    * PUBLIC (regra #3: alvo de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cAliasPends, loc_cAliasPNensi, loc_cAliasPNensiT, loc_cChave

        loc_cAliasPends   = THIS.this_oBusinessObject.this_cCursorPends
        loc_cAliasPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
        loc_cAliasPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT

        IF !USED(loc_cAliasPends) OR EOF(loc_cAliasPends)
            RETURN
        ENDIF

        *-- Chave POSICIONAL char(33) (regra #42): Emps/Dopps sao colunas
        *-- CHAR fixas de TmpPends, lidas direto (sem ALLTRIM)
        loc_cChave = EVALUATE(loc_cAliasPends + ".Emps") + EVALUATE(loc_cAliasPends + ".Dopps") + ;
            STR(EVALUATE(loc_cAliasPends + ".Numps"), 10)

        IF USED(loc_cAliasPNensiT)
            SELECT (loc_cAliasPNensiT)
            SET KEY TO loc_cChave
            GO TOP
        ENDIF

        IF USED(loc_cAliasPNensi)
            SELECT (loc_cAliasPNensi)
            SET KEY TO loc_cChave
            GO TOP
        ENDIF

        THIS.grd_4c_Itens.Refresh()
        THIS.obj_4c_Mm_obs.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - legado: SIGOPMPN.ok.Click. Grava (SigOpMpnBO.
    * ConfirmarMovimentacoes - xMFas/xOpi/xNensi/SigCdNec) e so fecha o
    * dialogo se a gravacao for bem-sucedida: no legado, qualquer "Return
    * 0" dentro do Click aborta ANTES das duas ultimas linhas
    * (ParentForm.Enabled = .t. / ThisForm.Release), ou seja, erro mantem
    * a tela aberta (o MsgErro ja foi mostrado dentro do BO).
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        IF THIS.this_oBusinessObject.ConfirmarMovimentacoes()
            THIS.FecharDialogo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - saida UNICA da tela. O dialogo tem ControlBox = .F.
    * e Closable = .F. (valores do SCX legado), portanto nao ha X nem ESC:
    * o botao OK (apos gravar) eh o unico caminho que o legado oferece, e
    * todos os nomes canonicos de saida do projeto apontam para aqui.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - nome canonico do projeto para o botao de saida.
    * Aqui o botao de saida eh o OK do legado (SIGOPMPN.ok), por isso
    * delega ao mesmo funil (que grava antes de fechar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdOkClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - nome canonico do projeto para "sair sem gravar".
    * O legado nao oferece esse caminho (ControlBox = .F., sem ESC) - o
    * UNICO jeito de sair eh o OK, que ja grava. Delega ao mesmo funil em
    * vez de dar ao usuario a impressao falsa de que ha algo a descartar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.CmdOkClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form pai (legado: ThisForm.ParentForm.Enabled
    * nao aparece explicito no dump de SIGOPMPN, mas reforcar aqui segue o
    * mesmo padrao de seguranca de FormSigOpMpd.prg - cobre fechamento por
    * qualquer caminho) e libera o Business Object. Fecha tambem TmpPends
    * (cursor proprio desta tela, criado nas fases seguintes - guard
    * USED() o torna seguro mesmo antes de existir). DODEFAULT() por
    * ULTIMO (regra do projeto: sem ela os popups do menu principal
    * encolhem visualmente apos o form fechar).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- Cursores PROPRIOS desta tela (criados por
        *-- SigOpMpnBO.CriarCursoresGrades). Os cursores do form PAI
        *-- (TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi) NAO sao fechados
        *-- aqui: pertencem a ele e continuam em uso depois que o dialogo
        *-- fecha.
        IF USED("TmpPends")
            USE IN TmpPends
        ENDIF
        IF USED("xPNensi")
            USE IN xPNensi
        ENDIF
        IF USED("xPNensiT")
            USE IN xPNensiT
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

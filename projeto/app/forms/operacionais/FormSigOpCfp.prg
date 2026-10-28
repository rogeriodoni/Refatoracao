*==============================================================================
* FormSigOpCfp.prg
*
* Dialogo OPERACIONAL "Cfop's Permitidas para Operacao" (legado SIGOPCFP.scx).
* Filho MODAL do Cadastro de Operacoes (SigCdOpe): mantem a grade de CFOPs
* permitidos para a Operacao corrente, com os limites de Observacao (Padrao/
* Inicial/Final) de cada CFOP - um registro de SigCdOop por linha da grade.
*
* Legado (Init): Lparameters poForm, pnDataSes, pcEscolha
*   poForm    - form pai (SigCdOpe), usado so para 3 coisas: Enabled=.F./.T.
*               enquanto o dialogo esta aberto, posicionar o dialogo perto da
*               grade da Lista do pai, e ler crSigCdOpe.Dopes (cursor da
*               datasession COMPARTILHADA do pai).
*   pnDataSes - DataSession do form pai, repassada via "Set DataSession to"
*               para enxergar o cursor crSigCdOpe do pai na mesma sessao.
*   pcEscolha - modo (INSERIR/ALTERAR/...) que define se Inserir/Excluir ficam
*               habilitados (grade so-leitura em VISUALIZAR).
*
* Diferente do legado, que precisa da DataSession compartilhada so para
* alcancar "crSigCdOpe.Dopes", o form migrado recebe o codigo da Operacao
* (Dopes) diretamente como parametro escalar - SigOpCfpBO acessa o banco via
* SQLEXEC proprio (gnConnHandle), sem cursor global nem DataSession
* compartilhada com o pai (memorias feedback_cursores_globais_fortyus e
* feedback_datasession_1_eh_sessao_corrente). this_oParentForm continua
* guardado (objeto, nao mais so o nome) para as duas outras finalidades do
* legado: habilitar/desabilitar o pai enquanto o dialogo esta aberto
* (AjustarBotoesFormPai - legado "mCtrlBotoes") e posicionar o dialogo perto
* da grade da Lista do pai (PosicionarJuntoAoFormPai).
*
* Nao segue o padrao PageFrame Page1=Lista/Page2=Dados do CRUD: e um dialogo
* OPERACIONAL com layout FLAT (cabecalho + grade + botoes soltos direto no
* form), igual ao legado - analise.json confirma formType=OPERACIONAL e o
* dump (SECAO 1) nao declara PageFrame nenhum (raiz "Class: form" generico).
*
* Fase 3/8 - Estrutura base: DEFINE CLASS, propriedades, Init() (recebe
* par_oFormPai/par_cDopes/par_cEscolha), InicializarForm() (cria o Business
* Object, aparencia do form, faixa do cabecalho, posicionamento junto ao pai
* e desabilita o pai enquanto o dialogo estiver aberto) e
* TornarControlesVisiveis (AddObject cria com Visible=.F. por padrao).
*
* Fase 4/8 - Grade e botoes: ConfigurarGrade() monta a grade (GradeSubN ->
* grd_4c_Dados, 4 colunas CFOP/Obs/De/Ate) e ConfigurarBotoes() monta os
* tres botoes (cmdSair/cmdInserir/cmdExcluir -> cmd_4c_CmdSair/
* cmd_4c_CmdInserir/cmd_4c_CmdExcluir), com Inserir/Excluir Visible/Enabled
* conforme this_cEscolha (legado). CarregarGrade() popula o cursor de
* trabalho do Business Object (equivalente a TmpCfoOp) e vincula o grid a
* ele - chamado em InicializarForm, guardado por gb_4c_ValidandoUI.
*
* Fase 5/8 - Lookup da coluna CFOP: TextBoxCfopGridCfp_4c (classes\
* TextBoxGridLookup.prg), instalada em Column1 via AddObject + CurrentControl
* + Sparse = .F. (regra #18) - BINDEVENT em evento de celula de Grid NAO eh
* confiavel (regra #46). Valid/KeyPress(F4/F5) delegam para
* ValidarCfopGridExec()/AbrirLookupCfopGrade() (metodos PUBLIC deste form,
* chamados de fora da classe pela celula - mesma exigencia de BINDEVENT da
* regra #3), que reproduzem o fwBuscaExt do legado contra SigCdCfo.
*
* Fase 6/8 - Lookup das colunas de Observacao (Padrao/Inicial/Final):
* TextBoxObsGridCfp_4c (classes\TextBoxGridLookup.prg), instalada em
* Column2/Column3/Column4 com o mesmo padrao AddObject + CurrentControl +
* Sparse = .F. da Column1. Valid/KeyPress(F4/F5) delegam para
* ValidarObsGridExec()/AbrirLookupObsGrade() (metodos PUBLIC deste form),
* que reproduzem o fwBuscaExt do legado contra SigCdObs E a validacao
* cruzada entre as tres colunas da mesma linha (ObsInis <= ObsPads <=
* ObsFins). Este dialogo nao tem pagina de Dados/Salvar separada - toda a
* edicao acontece nas celulas da grade (Column1..4), por isso nao ha
* container de botoes Salvar/Cancelar equivalente ao CRUD Page2 (o
* "cnt_4c_BotoesAcao" do template generico de fase 6 nao se aplica a este
* form OPERACIONAL).
*
* Fase 7/8 - Eventos principais: este dialogo NAO segue o padrao CRUD
* Incluir/Alterar/Visualizar/Excluir (o legado SIGOPCFP so tem cmdInserir/
* cmdExcluir/cmdSair - nenhum Alterar nem Visualizar, a edicao eh direto
* nas celulas da grade). BtnInserirClick/BtnExcluirClick/BtnSairClick
* (BINDEVENT no Click dos 3 CommandButton de ConfigurarBotoes) transcrevem
* cmdInserir/cmdExcluir/cmdSair do legado; SigOpCfpBO.SalvarGrade() (nova)
* persiste as alteracoes linha a linha (Inserir/Atualizar/ExecutarExclusao
* ja existentes) com o MESMO resultado final do bulk Delete+Append do
* legado (PILAR 3 - arquitetura obrigatoriamente diferente). O When de
* cada coluna de Observacao (habilita so depois do CFOP preenchido) vai
* em CelulaObsGradeEditavel(), chamado por TextBoxObsGridCfp_4c.When().
*
* Fase 8/8 - Consolidacao final: Destroy() acrescenta a rede de seguranca
* que reabilita this_oParentForm/AjustarBotoesFormPai mesmo fora do caminho
* de sucesso de BtnSairClick, e fecha os cursores de trabalho deste dialogo
* (cursor_4c_Dados/this_cCursorGrade e cursor_4c_OopOriginais) antes de
* DODEFAULT() (CorretorAutomatico Pattern #145). Os metodos auxiliares do
* template generico de form CRUD (FormParaBO/BOParaForm, HabilitarCampos/
* LimparCampos, CarregarLista, AjustarBotoesPorModo, BtnSalvarClick/
* BtnCancelarClick/BtnBuscarClick/BtnEncerrarClick) NAO se aplicam a este
* form OPERACIONAL: nao ha Page1/Page2, a edicao eh direto nas celulas da
* grade (CarregarGrade/BtnInserirClick/BtnExcluirClick da fase 4/7 cobrem o
* equivalente de CarregarLista/Incluir/Excluir) e o "salvar" eh
* SalvarGrade(), chamado por BtnSairClick (fase 7) - o proprio botao
* "Encerrar" do legado (cmdSair). THIS.Release() em BtnSairClick eh seguro
* aqui (diferente de dialogo tipo FormBuscaAuxiliar/FormSigOpCbx): este
* dialogo nao devolve nenhum valor por property para o chamador ler depois
* do Show() - toda a persistencia ja aconteceu via SalvarGrade() antes do
* Release(), e o legado tambem nao expõe nenhum "Retorno" no Unload do
* SIGOPCFP original.
*
* Nota de integracao: diferente de form OPERACIONAL autonomo (menu ->
* AbrirForm<X>), este dialogo e filho MODAL do Cadastro de Operacoes
* (SigCdOpe) e exige par_oFormPai/par_cDopes/par_cEscolha na abertura -
* nao ha como abri-lo isolado pelo menu. A chamada
* CREATEOBJECT("FormSigOpCfp", ThisForm, <Dopes>, <pcEscolha>).Show() fica
* a cargo da migracao do form de Operacoes (SigCdOpe/FormOPE); confirmado
* por grep em 2026-10-23 que aquele form ainda esta por migrar - sem
* SET PROCEDURE nem item de menu proprios aqui, portanto.
*==============================================================================

DEFINE CLASS FormSigOpCfp AS FormBase

    *-- Propriedades visuais (legado SIGOPCFP.scx)
    Width        = 800
    Height       = 400
    BorderStyle  = 2
    ControlBox   = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow   = 1

    *-- Parametros recebidos na abertura (legado: Lparameters poForm,
    *-- pnDataSes, pcEscolha - pnDataSes deixou de ser necessario, ver nota
    *-- no cabecalho do arquivo)
    this_oParentForm = .NULL.
    this_cDopes      = ""   && codigo da Operacao (legado "crSigCdOpe.Dopes")
    this_cEscolha    = ""   && legado "pcEscolha" - habilita Inserir/Excluir

    *--------------------------------------------------------------------------
    * Init - Recebe o form pai, o codigo da Operacao (Dopes) e o modo de
    * edicao, monta o Caption dinamico (legado: "Cfop's p/: " +
    * AllTrim(Proper(crSigCdOpe.Dopes))) e encaminha para
    * FormBase.Init()/InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cDopes, par_cEscolha)
        THIS.this_oParentForm = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cDopes      = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        THIS.this_cEscolha    = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")

        THIS.Caption = "Cfop's p/: " + ALLTRIM(PROPER(THIS.this_cDopes))

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Instancia o Business Object (repassando o codigo da
    * Operacao recebido no Init), monta a aparencia do form e a faixa do
    * cabecalho, posiciona o dialogo perto da grade da Lista do pai e
    * desabilita o pai enquanto o dialogo estiver aberto (legado: Init faz
    * "Thisform.ParentForm.Enabled = .F." + "Thisform.mCtrlBotoes(.F.)").
    * Monta a grade e os botoes (ConfigurarGrade/ConfigurarBotoes) e, fora do
    * modo de validacao de UI, carrega os Cfops ja permitidos (CarregarGrade).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCfpBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

                THIS.ConfigurarAparencia()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarGrade()
                THIS.ConfigurarBotoes()
                THIS.PosicionarJuntoAoFormPai()

                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .F.
                ENDIF
                THIS.AjustarBotoesFormPai(.F.)

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarGrade()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object de Cfop's Permitidas " + ;
                    "para Opera" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpCfp")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAparencia - Fundo padrao do dialogo (legado: form.Picture =
    * ..\framework\imagens\new_background.jpg) e fonte base (Tahoma 8, igual
    * aos demais controles do dump).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAparencia()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (legado: cntSombra), com os
    * dois labels de titulo sombra/frente (CLAUDE.md regra #11/#23). O legado
    * declara cntSombra.Width=800/labels.Width=769 (boilerplate do template
    * generico de frmcadastro, igual a FormSigOpCbx - mesmo dump, mesmos
    * valores) - cnt_4c_Sombra usa THIS.Width (regra #11, canonico); os
    * labels mantem a largura literal do dump (769 < 800, cabe inteiro na
    * area visivel, nao ha clipping).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarJuntoAoFormPai - Reproduz o calculo de Top/Left do Init
    * legado, que ancora o dialogo perto da grade da Lista do form pai:
    *   .Top  = ParentForm.Top + Grade.Top + 50
    *   .Left = ParentForm.Left + Grade.Left + Grade.Columns(1).Width + ;
    *           Grade.Columns(3).Width + 16
    *
    * No sistema novo a grade da Lista do pai (form CRUD canonico) fica em
    * pgf_4c_Paginas.Page1.grd_4c_Lista (ver docs\framework_frmcadastro_layout.md
    * e FormCor.prg) - cada nivel e checado com PEMSTATUS antes de usar, para
    * nao estourar quando o form pai ainda nao segue essa estrutura (ou em
    * instanciacao standalone/teste, sem form pai). Falhando qualquer
    * checagem, o dialogo mantem o AutoCenter padrao herdado de FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
        LOCAL loc_oGrade

        IF VARTYPE(THIS.this_oParentForm) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas, "Page1", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
            RETURN
        ENDIF

        loc_oGrade = THIS.this_oParentForm.pgf_4c_Paginas.Page1.grd_4c_Lista

        IF !PEMSTATUS(loc_oGrade, "Column1", 5) OR !PEMSTATUS(loc_oGrade, "Column3", 5)
            RETURN
        ENDIF

        THIS.AutoCenter = .F.
        THIS.Top  = THIS.this_oParentForm.Top + loc_oGrade.Top + 50
        THIS.Left = THIS.this_oParentForm.Left + loc_oGrade.Left + ;
            loc_oGrade.Column1.Width + loc_oGrade.Column3.Width + 16
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesFormPai - Legado "mCtrlBotoes(plHabilita)": percorre os
    * botoes CRUD do form pai e o botao de saida, habilitando/desabilitando
    * conforme par_lHabilita. No pai (form CRUD canonico) os botoes CRUD ficam
    * em pgf_4c_Paginas.Page1.cnt_4c_Botoes e o de saida em
    * pgf_4c_Paginas.Page1.cnt_4c_Saida (docs\framework_frmcadastro_layout.md) -
    * equivalente a Grupo_Op/Grupo_Saida.Sair do legado. Cada nivel e checado
    * com PEMSTATUS; sem a estrutura esperada (form pai ausente ou standalone/
    * teste), o metodo e no-op.
    *
    * Chamado com .F. no InicializarForm (legado: Init); com .T. no
    * BtnSairClick (legado: cmdSair.Click), nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesFormPai(par_lHabilita)
        LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_nI, loc_oCtrl

        IF VARTYPE(THIS.this_oParentForm) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas, "Page1", 5)
            RETURN
        ENDIF

        loc_oPagina = THIS.this_oParentForm.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
            loc_oBotoes = loc_oPagina.cnt_4c_Botoes
            FOR loc_nI = 1 TO loc_oBotoes.ControlCount
                loc_oCtrl = loc_oBotoes.Controls(loc_nI)
                IF UPPER(loc_oCtrl.BaseClass) = "COMMANDBUTTON" AND loc_oCtrl.Visible
                    loc_oCtrl.Enabled = par_lHabilita
                ENDIF
            ENDFOR
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cnt_4c_Saida", 5)
            loc_oSaida = loc_oPagina.cnt_4c_Saida
            FOR loc_nI = 1 TO loc_oSaida.ControlCount
                loc_oCtrl = loc_oSaida.Controls(loc_nI)
                IF UPPER(loc_oCtrl.BaseClass) = "COMMANDBUTTON"
                    loc_oCtrl.Enabled = par_lHabilita
                ENDIF
            ENDFOR
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Monta a grade de Cfops permitidos (legado GradeSubN,
    * 4 colunas: CFOP/Obs/De/Ate - equivalentes a Cfops/ObsPads/ObsInis/
    * ObsFins de SigCdOop). Aqui so a ESTRUTURA visual (Width/Header/estilo
    * de cada coluna) - RecordSource/ControlSource ficam em CarregarGrade(),
    * DEPOIS do Business Object (re)criar o cursor de trabalho, porque
    * vincular antes seria descartado quando o cursor for recriado (mesmo
    * padrao de FormFpN.ConfigurarPaginaLista/CarregarDados). As colunas 1
    * (lookup de CFOP) e 2/3/4 (lookup de Observacao) recebem BINDEVENT nas
    * fases 5/6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top           = 120
            .Left          = 281
            .Width         = 237
            .Height        = 221
            .ColumnCount   = 4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 1
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "CFOP"
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Lookup de CFOP (legado: fwBuscaExt contra SigCdCfo) - celula
            *-- com Valid/LostFocus/KeyPress embutidos (regra #18/#46), nunca
            *-- AfterRowColChange. Instalada POR CIMA do Text1 (CurrentControl).
            .AddObject("txt_4c_Cfop", "TextBoxCfopGridCfp_4c")
            .CurrentControl = "txt_4c_Cfop"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .Width     = 35
            .ReadOnly  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Obs"
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .F.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Lookup de Observacao PADRAO (legado: fwBuscaExt contra
            *-- SigCdObs + validacao cruzada contra ObsInis/ObsFins da
            *-- mesma linha - regra #18/#46).
            .AddObject("txt_4c_ObsPad", "TextBoxObsGridCfp_4c")
            .txt_4c_ObsPad.this_cCampoObs = "OBSPADS"
            .CurrentControl = "txt_4c_ObsPad"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .Width     = 35
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "De"
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .F.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Lookup de Observacao INICIAL (legado: fwBuscaExt contra
            *-- SigCdObs + validacao cruzada contra ObsPads da mesma linha).
            .AddObject("txt_4c_ObsIni", "TextBoxObsGridCfp_4c")
            .txt_4c_ObsIni.this_cCampoObs = "OBSINIS"
            .CurrentControl = "txt_4c_ObsIni"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4
            .Width     = 35
            .Sparse    = .T.
            .ReadOnly  = .F.
            .BackColor = RGB(255, 255, 255)
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "At" + CHR(233)
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Margin    = 0
                .Top       = 21
                .Left      = 13
                .Width     = 100
                .Height    = 23
            ENDWITH

            *-- Lookup de Observacao FINAL (legado: fwBuscaExt contra
            *-- SigCdObs + validacao cruzada contra ObsPads da mesma linha).
            .AddObject("txt_4c_ObsFim", "TextBoxObsGridCfp_4c")
            .txt_4c_ObsFim.this_cCampoObs = "OBSFINS"
            .CurrentControl = "txt_4c_ObsFim"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        THIS.grd_4c_Dados.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Monta os 3 botoes do dialogo (legado cmdInserir/
    * cmdExcluir/cmdSair - fwbtng/framework.vcx, ambos CommandButton
    * standalone). Inserir/Excluir ficam Visible/Enabled conforme
    * this_cEscolha (legado Init: "Iif(Type('Thisform.PcEscolha')#'C', .T.,
    * InList(Thisform.PcEscolha,'INSERIR','ALTERAR'))") - grade fica
    * so-leitura fora de INSERIR/ALTERAR (ex.: VISUALIZAR). cmdSair fica
    * sempre disponivel, com Cancel=.T. (ESC aciona, igual ao legado). O
    * Click de cada botao fica para a fase 7/8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_lHabilitaEdicao

        loc_lHabilitaEdicao = IIF(EMPTY(THIS.this_cEscolha), .T., ;
            INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR"))

        THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH THIS.cmd_4c_CmdInserir
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = loc_lHabilitaEdicao
            .Enabled         = loc_lHabilitaEdicao
        ENDWITH

        THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH THIS.cmd_4c_CmdExcluir
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = loc_lHabilitaEdicao
            .Enabled         = loc_lHabilitaEdicao
        ENDWITH

        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
            .Enabled         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirClick")
        BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Inclui linha em branco na grade (legado:
    * cmdInserir.Click: "Locate for Cfops = Space(10) / If Eof() / Insert
    * Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes,
    * fUniqueIds()) / Endif", reaproveitando a linha vazia se ja existir
    * uma - nunca abre uma segunda). this_oBusinessObject.NovoRegistro()
    * gera a chave (InicializarValoresPadrao -> fUniqueIds(), regra #22 -
    * PK Fortyus nunca pode nascer vazia) e zera as demais propriedades
    * (LimparDados tambem zera this_cDopes - reposto abaixo, igual ao
    * padrao de SigOpCflBO.this_cNums).
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        LOCATE FOR EMPTY(ALLTRIM(NVL(cfops, "")))

        IF EOF()
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

            SELECT (loc_cCursor)
            APPEND BLANK
            REPLACE dopes     WITH THIS.this_oBusinessObject.this_cDopes, ;
                    cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves, ;
                    cfops     WITH "", ;
                    cgrus     WITH "", ;
                    obspads   WITH 0, ;
                    obsinis   WITH 0, ;
                    obsfins   WITH 0
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove a linha corrente da grade (legado:
    * cmdExcluir.Click: "If Not Eof() / Delete / Skip / Skip - 1 / Endif").
    * So marca a linha como deletada no cursor de trabalho - a exclusao
    * efetiva em SigCdOop (quando a linha ja existia la) acontece em
    * SalvarGrade(), no BtnSairClick, igual ao legado (que so regrava
    * SigCdOop ao sair do dialogo, nunca a cada clique em Excluir).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        IF !EOF()
            DELETE
            SKIP
            SKIP -1
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o dialogo (legado: cmdSair.Click). So tenta
    * gravar quando o dialogo estava em modo editavel (legado: "If
    * Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible") - em
    * VISUALIZAR (Inserir/Excluir ocultos pelo this_cEscolha) fecha direto,
    * sem tocar no banco. Falhando a gravacao (Cfop duplicado ou erro de
    * SQL - SigOpCfpBO.SalvarGrade ja exibiu o aviso/erro), o dialogo
    * PERMANECE aberto para o usuario corrigir, igual ao "Return .f." do
    * legado no meio do Click (nao reabilita o pai, nao libera o form).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_lPodeEditar, loc_lSucesso

        loc_lPodeEditar = THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible
        loc_lSucesso    = .T.

        IF loc_lPodeEditar AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.SalvarGrade()
        ENDIF

        IF loc_lSucesso
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.AjustarBotoesFormPai(.T.)
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Popula o cursor de trabalho do Business Object com os
    * Cfops ja permitidos para a Operacao corrente (legado Init: "Select *
    * From SigCdOop where Dopes=...") e vincula o grid a ele. RecordSource/
    * ControlSource ficam aqui (nao em ConfigurarGrade) porque o Business
    * Object RECRIA o cursor a cada chamada - vincular antes seria
    * descartado (mesmo padrao de FormFpN.CarregarDados). Reaplica
    * Header1.Caption depois do ControlSource, porque RecordSource reseta
    * os cabecalhos das colunas.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_oGrid, loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarCfopsPermitidos()
            RETURN .F.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
        loc_oGrid   = THIS.grd_4c_Dados

        loc_oGrid.ColumnCount  = 4
        loc_oGrid.RecordSource = loc_cCursor

        loc_oGrid.Column1.ControlSource = loc_cCursor + ".cfops"
        loc_oGrid.Column2.ControlSource = loc_cCursor + ".obspads"
        loc_oGrid.Column3.ControlSource = loc_cCursor + ".obsinis"
        loc_oGrid.Column4.ControlSource = loc_cCursor + ".obsfins"

        loc_oGrid.Column1.Header1.Caption = "CFOP"
        loc_oGrid.Column2.Header1.Caption = "Obs"
        loc_oGrid.Column3.Header1.Caption = "De"
        loc_oGrid.Column4.Header1.Caption = "At" + CHR(233)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
        ENDIF

        loc_oGrid.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCfopGridExec - Corpo do Valid da celula CFOP da grade (legado
    * SIGOPCFP.GradeSubN.Column1.Text1.Valid: "If Lastkey() == 27 / Return"
    * antes de qualquer coisa - ESC na celula aborta o Valid sem tentar o
    * lookup, preservando o valor atual). PUBLIC: chamado de FORA da classe
    * do form pela celula TextBoxCfopGridCfp_4c (THISFORM.<metodo>, mesma
    * exigencia de BINDEVENT da regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCfopGridExec(par_oTxt)
        IF LASTKEY() = 27
            RETURN .T.
        ENDIF

        RETURN THIS.AbrirLookupCfopGrade(par_oTxt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCfopGrade - Lookup de CFOP (legado: "xBrox = CreateObject(
    * 'fwBuscaExt',...,'SigCdCfo','crSigCdCfo','Codigos',This.Value,
    * 'Selecao',.t.,'Codigos')" + mAddColuna Codigos/Descricaos/Operacaos).
    * FormBuscaAuxiliar.Init ja tenta o match exato sozinho (regra #37) -
    * so abre o Show() quando nao resolveu. Atribuicao do valor escolhido
    * SOMENTE sob a guarda this_lSelecionou (regra #37); fora dela, o
    * legado faz "Else This.Value = ''" (ESC no picker limpa o codigo) -
    * reproduzido aqui, nao eh o defeito da regra #50 (ali nao havia
    * picker nenhum para servir de feedback).
    *
    * Chamado pelo Valid da celula (par_oTxt.Value ainda NAO chegou ao
    * cursor da grade - regra #46) e pelo F4/F5 da celula (afordancia do
    * sistema novo). PUBLIC pelo mesmo motivo de ValidarCfopGridExec.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCfopGrade(par_oTxt)
        LOCAL loc_oBusca, loc_cValor

        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCfo", ;
            "cursor_4c_BuscaCfop", "codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfop")
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaCfop.codigos)
            ELSE
                par_oTxt.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCfop")
            USE IN cursor_4c_BuscaCfop
        ENDIF

        par_oTxt.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarObsGridExec - Corpo do Valid das celulas de Observacao da grade
    * (legado SIGOPCFP.GradeSubN.Column2/3/4.Text1.Valid - as 3 colunas
    * repetem o mesmo padrao): abre o lookup quando a celula nao esta vazia
    * e, em seguida, valida CRUZADO contra as outras duas colunas da MESMA
    * linha (Padrao/Inicial/Final) - "Return 0" do legado mantem o foco na
    * celula quando a cruzada falha. par_cCampoObs ("OBSPADS"/"OBSINIS"/
    * "OBSFINS") vem de TextBoxObsGridCfp_4c.this_cCampoObs e diz qual das
    * tres regras aplicar. PUBLIC: chamado de FORA da classe do form pela
    * celula (mesma exigencia de BINDEVENT da regra #3).
    *
    * O valor em validacao ainda esta em par_oTxt.Value (o cursor so recebe
    * DEPOIS - regra #46); os outros dois lados da comparacao vem do cursor
    * da grade, que ja reflete o que foi digitado nas celulas anteriores da
    * mesma linha.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarObsGridExec(par_oTxt, par_cCampoObs)
        LOCAL loc_lResultado, loc_cCursor, loc_nObsPad, loc_nObsIni, loc_nObsFin

        IF LASTKEY() = 27
            RETURN .T.
        ENDIF

        loc_lResultado = .T.

        IF !EMPTY(par_oTxt.Value)
            THIS.AbrirLookupObsGrade(par_oTxt)
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF USED(loc_cCursor)
            loc_nObsPad = EVALUATE(loc_cCursor + ".obspads")
            loc_nObsIni = EVALUATE(loc_cCursor + ".obsinis")
            loc_nObsFin = EVALUATE(loc_cCursor + ".obsfins")

            DO CASE
            CASE par_cCampoObs = "OBSPADS"
                loc_nObsPad = par_oTxt.Value
                IF !EMPTY(loc_nObsPad) AND !EMPTY(loc_nObsIni) AND (loc_nObsIni > loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Inicial N" + CHR(227) + ;
                        "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
                IF loc_lResultado AND !EMPTY(loc_nObsPad) AND !EMPTY(loc_nObsFin) AND (loc_nObsFin < loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Final N" + CHR(227) + ;
                        "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            CASE par_cCampoObs = "OBSINIS"
                loc_nObsIni = par_oTxt.Value
                IF !EMPTY(loc_nObsIni) AND !EMPTY(loc_nObsPad) AND (loc_nObsIni > loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Inicial N" + CHR(227) + ;
                        "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            CASE par_cCampoObs = "OBSFINS"
                loc_nObsFin = par_oTxt.Value
                IF !EMPTY(loc_nObsFin) AND !EMPTY(loc_nObsPad) AND (loc_nObsFin < loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Final N" + CHR(227) + ;
                        "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDCASE
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupObsGrade - Lookup de Observacao (legado: "xBrox =
    * CreateObject('fwBuscaExt',...,'SigCdObs','crSigCdObs','Codigos',
    * This.Value,'Cadastro de Observacoes',.t.,'Codigos')" + mAddColuna
    * Codigos/Observas). FormBuscaAuxiliar.Init ja tenta o match exato
    * sozinho (regra #37) - equivalente ao ChkRegister do legado, que so
    * abre o picker quando o codigo digitado NAO existe. Coluna numeric(3,0)
    * (SigCdObs.codigos/SigCdOop.obspads-obsinis-obsfins): o valor digitado
    * eh convertido para string so para a busca (par_cValor de
    * FormBuscaAuxiliar eh sempre Character); de volta, o Codigos escolhido
    * retorna NUMERICO para a celula. ESC no picker zera a celula (legado:
    * "This.Value = Iif(Lastkey()==27, 0, crSigCdObs.Codigos)") - NAO bloqueia
    * a saida da celula (a cruzada de ValidarObsGridExec trata Empty(0) como
    * "sem restricao", igual ao legado).
    *
    * Chamado pelo Valid da celula (par_oTxt.Value ainda NAO chegou ao
    * cursor da grade - regra #46) e pelo F4/F5 da celula (afordancia do
    * sistema novo). PUBLIC pelo mesmo motivo de ValidarObsGridExec.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupObsGrade(par_oTxt)
        LOCAL loc_oBusca, loc_cValor

        loc_cValor = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, 0)))

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdObs", ;
            "cursor_4c_BuscaObs", "codigos", loc_cValor, ;
            "Cadastro de Observa" + CHR(231) + CHR(245) + "es", .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("observas", "", "Observa" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
                par_oTxt.Value = NVL(cursor_4c_BuscaObs.codigos, 0)
            ELSE
                par_oTxt.Value = 0
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaObs")
            USE IN cursor_4c_BuscaObs
        ENDIF

        par_oTxt.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaObsGradeEditavel - Legado (GradeSubN.Column2/3/4.Text1.When):
    * "Return (not Empty(TmpCfoOp.Cfops))" - as celulas de Observacao
    * (Padrao/Inicial/Final) so ficam editaveis depois do CFOP da MESMA
    * linha estar preenchido. Chamado pelo When de TextBoxObsGridCfp_4c
    * (classes\TextBoxGridLookup.prg) - PUBLIC pelo mesmo motivo das
    * demais delegacoes de celula de grade (regra #3/#46).
    *--------------------------------------------------------------------------
    PROCEDURE CelulaObsGradeEditavel()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .T.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        RETURN !EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".cfops"), "")))
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Consolidacao final (fase 8/8): rede de seguranca para o pai e
    * limpeza dos cursores de trabalho deste dialogo.
    *
    * BtnSairClick (fase 7/8) ja reabilita THIS.this_oParentForm e chama
    * AjustarBotoesFormPai(.T.) no caminho de SUCESSO antes de THIS.Release().
    * Mas o legado garantia a reabilitacao do pai so por viver na MESMA
    * DataSession/Release Windows unico - aqui, se o dialogo for destruido por
    * qualquer caminho que nao passe por ali (erro nao tratado em algum ponto
    * fora de TRY, RELEASE externo), o pai NAO pode ficar desabilitado para
    * sempre. Repetir aqui eh idempotente (reabilitar duas vezes nao tem
    * efeito colateral).
    *
    * Fecha tambem cursor_4c_Dados (grade de trabalho, this_cCursorGrade do
    * BO) e cursor_4c_OopOriginais (snapshot usado por SalvarGrade) - os
    * demais cursores temporarios (cursor_4c_BuscaCfop/Obs,
    * cursor_4c_OopTemp/Duplic/Removidas) ja se fecham inline nos proprios
    * metodos. O nome do cursor de grade e lido ANTES do DODEFAULT() (abaixo)
    * porque FormBase.Destroy() anula THIS.this_oBusinessObject.
    *
    * DODEFAULT() por ULTIMO (CorretorAutomatico Pattern #145) - sem isso
    * FormBase.Destroy() nao roda e o menu principal fica com popups
    * encolhidos apos este dialogo fechar.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_cCursorGrade

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
        ELSE
            loc_cCursorGrade = "cursor_4c_Dados"
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.AjustarBotoesFormPai(.T.)

        IF !EMPTY(loc_cCursorGrade) AND USED(loc_cCursorGrade)
            USE IN (loc_cCursorGrade)
        ENDIF

        IF USED("cursor_4c_OopOriginais")
            USE IN cursor_4c_OopOriginais
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
    * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
    * metodo fica generico para reaproveitar nas fases seguintes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_nP = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE

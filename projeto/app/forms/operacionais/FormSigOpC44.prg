*==============================================================================
* FormSigOpC44.prg - Geracao do arquivo da CAT 44/2008 (Substituicao
* Tributaria de Estoque), layout posicional de texto com 3 tipos de registro.
* Form OPERACIONAL FLAT (sem PageFrame) - dialogo modal de entrada unica.
* Chamada: CREATEOBJECT("FormSigOpC44")
* Herda de: FormBase
*
* Legado (SigOpC44.SCX): BaseClass = form (generico), DataSession=1,
* BorderStyle=2, AutoCenter=.T., Caption="Geracao do Arquivo da CAT 44/2008",
* ControlBox=.F., TitleBar=0, WindowType=1 (modal), Width=503, Height=247 -
* popup pequeno, sem PageFrame, sem Grid. Controles (txtdest, getDtEst,
* getFinal, getNumParc, CmdGera, CmdSair, ShpSair, Shape2) sao todos filhos
* DIRETOS do form - mesma familia FLAT do SIGOPBIN/FormSIGOPBIN.
*
* Historico de fases:
*   Fase 1/2: SigOpC44BO.prg (propriedades + CarregarParametros +
*             InicializarCursoresLocais + GerarRegistro1/2/3)
*   Fase 3:   FormSigOpC44.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
*             lbl_4c_LblTitulo). Form FLAT: o legado nao tem PageFrame nem
*             Page nenhuma - nenhum pgf_4c_* eh criado neste form.
*   Fase 4:   FormSigOpC44.prg - ConfigurarBotoesAcao() com os DOIS shapes
*             decorativos do legado (shp_4c_Shape2/shp_4c_ShpSair) e os
*             DOIS CommandButtons de acao (cmd_4c_CmdGera/cmd_4c_CmdSair).
*             O legado NAO tem Grid nem lista (layout CAPTURA - dialogo que
*             so coleta os parametros de geracao do arquivo): nao ha
*             grd_4c_* nem botoes CRUD para criar aqui - os dois botoes
*             deste form SAO os botoes de acao (Gerar/Sair). Apenas
*             AddObject + propriedades visuais (Click fica para a Fase 7).
*             Campos de dados (txtdest/getDtEst/getFinal/getNumParc) e seus
*             Labels ficam para a Fase 5.
*   Fase 5:   FormSigOpC44.prg - ConfigurarCamposDados() com a 1a metade dos
*             campos: txt_4c_Txtdest (+ lbl_4c_Label2) e txt_4c_DtEst (+
*             lbl_4c_Label3). 2a metade (getFinal/getNumParc) na Fase 6.
*   Fase 6:   FormSigOpC44.prg - ConfigurarCamposDados2() com a 2a metade dos
*             campos: cbo_4c_GetFinal (+ lbl_4c_Label1) e txt_4c_NumParc
*             (+ lbl_4c_Label4); mais a camada de comportamento dos QUATRO
*             campos: AplicarValoresPadrao() (defaults "C:\"/Date()/1 do Init
*             legado), FormParaBO()/BOParaForm() (espelho tela<->BO),
*             ValidarParametros() (os TRES guards que o legado escreveu no
*             inicio do CmdGera.Click) e os BINDEVENT de KeyPress dos dois
*             TextBox digitaveis + InteractiveChange da combo.
*             SEM LOOKUP: o legado (SIGOPC44) nao tem UMA chamada de busca -
*             grep de fwbusca/mAddColuna/sigacess/Acesso*() no dump devolve
*             zero, e a unica CreateObject eh fSqlConector (conexao de dados,
*             nao picker de UI). Inventar lookup aqui violaria o PILAR 1 e a
*             regra "NUNCA inventar tabelas de lookup que nao existem no
*             original". Tambem nao ha Valid/When/LostFocus em campo algum do
*             SCX: a regra dos campos mora no Click do botao, e por governar
*             os campos DESTA fase ela nasce aqui - o Click (Fase 7) so
*             chama. Os Click em si (confirmacao + GerarRegistro1/2/3 do BO +
*             FCREATE/FWRITE do arquivo CAT44) ficam para a Fase 7.
*   Fase 7:   FormSigOpC44.prg - CmdGeraClick()/CmdSairClick() (os UNICOS
*             eventos principais deste dialogo - NAO ha Incluir/Alterar/
*             Visualizar/Excluir: o legado nao tem Grid nem lista, layout
*             CAPTURA de parametro unico, e os dois CommandButton do form SAO
*             os botoes de acao). CmdGeraClick transcreve SIGOPC44.CmdGera.
*             Click: ValidarParametros() (Fase 6) -> confirmacao (MsgConfirma)
*             -> Set Point To "," (decimal com virgula no arquivo-texto,
*             restaurado no fim) -> GerarRegistro1/2/3 do BO -> grava o
*             arquivo posicional (FCREATE/FWRITE linha a linha via
*             MontarLinhaRegistro() + FCLOSE) -> FileToStr/StrToFile(...,4)
*             (ida-e-volta do legado, mantida literal) -> MsgInfo com o
*             caminho gerado -> foco no Sair. CmdSairClick transcreve
*             SIGOPC44.CmdSair.Click (THIS.Release(), nada mais). BINDEVENT
*             em "Click" dos dois cmd_4c_* (criados na Fase 4) - os handlers
*             sao PUBLIC (regra #3: BINDEVENT exige metodo nao-PROTECTED).
*   Fase 8:   FormSigOpC44.prg - consolidacao final. Este form NAO eh CRUD
*             (sem Grid/Page1-Lista/Page2-Dados): o template generico de
*             Fase 8 (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
*             BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
*             AjustarBotoesPorModo) NAO se aplica a um dialogo FLAT de
*             parametro unico - CmdGeraClick/CmdSairClick (Fase 7) JA SAO os
*             unicos eventos principais, e FormParaBO/BOParaForm (Fase 6) JA
*             cobrem os 4 campos. O que faltava para o form ficar FUNCIONAL:
*             (a) InicializarForm() nunca chamava
*             SigOpC44BO.CarregarParametros() - os 4 campos apareciam com os
*             defaults do legado (Date()/1/"C:\"), mas CNPJ/IE/Razao
*             Social/Regime Tributario da empresa (usados por
*             GerarRegistro1/GerarRegistro2) ficavam SEMPRE vazios, porque
*             nenhum metodo lia SigCdEmp. Chamada adicionada ANTES de
*             ConfigurarCamposDados2() (que depende de this_cDestino via
*             AplicarValoresPadrao), guardada por gb_4c_ValidandoUI (mesmo
*             padrao de FormFAPF/FormSIGMDETQ) para o ValidarUIFidelity
*             instanciar sem gnConnHandle; (b) menu.prg nao tinha entrada
*             nenhuma para este form - adicionada em popMovimentos (BAR 153)
*             + PROCEDURE AbrirFormSigOpC44() no padrao canonico (VARTYPE,
*             Show() FORA do TRY - regra #29).
*==============================================================================
DEFINE CLASS FormSigOpC44 AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SigOpC44)
    Width       = 503
    Height      = 247
    DataSession = 1
    ShowWindow = 1
    BorderStyle = 2
    AutoCenter  = .T.
    Caption     = "Gera" + CHR(231) + CHR(227) + "o do Arquivo da CAT 44/2008"
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1

    *--------------------------------------------------------------------------
    * Init - Cria o Business Object antes de inicializar a parte visual
    * (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpC44BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigOpC44BO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpC44.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- CarregarParametros (equivalente ao SIGOPC44.Init legado: Seek
            *-- crSigCdEmp + CursorQuery SigCdPac) - cria os cursores locais de
            *-- saida (Load legado) e le CNPJ/IE/Razao Social/Regime Tributario
            *-- da empresa + o diretorio padrao de destino. Pulado em modo
            *-- gb_4c_ValidandoUI (sem conexao SQL - mesmo padrao de FormFAPF/
            *-- FormSIGMDETQ) para o ValidarUIFidelity conseguir instanciar o
            *-- form sem gnConnHandle.
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF !THIS.this_oBusinessObject.CarregarParametros()
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "FormSigOpC44")
                ENDIF
            ELSE
                THIS.this_oBusinessObject.InicializarCursoresLocais()
            ENDIF

            *-- Monta o cabecalho (unico elemento estrutural deste form FLAT)
            THIS.ConfigurarPageFrame()

            *-- Shapes decorativos + botoes de acao (Gerar Arquivo / Sair)
            THIS.ConfigurarBotoesAcao()

            *-- Campos de dados (metade 1/2: destino do arquivo + data do estoque)
            THIS.ConfigurarCamposDados()

            *-- Campos de dados (metade 2/2: finalidade do arquivo + parcelas ICMS)
            *-- AplicarValoresPadrao (chamado dentro deste metodo) le
            *-- this_oBusinessObject.this_cDestino, por isso CarregarParametros
            *-- tem de rodar ANTES.
            THIS.ConfigurarCamposDados2()

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
    *   Form OPERACIONAL FLAT: o legado (SigOpC44.SCX) nao tem PageFrame nem
    *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
    *   metodo mantido por convencao do orquestrador de migracao, mas este
    *   form NAO cria nenhum PageFrame: nao existe aqui (nem em metodo algum
    *   deste arquivo) um AddObject de objeto com o prefixo de PageFrame.
    *   Demais controles do legado (txtdest, getDtEst, getFinal, getNumParc,
    *   CmdGera, CmdSair, ShpSair, Shape2) entram em fases posteriores.
    *
    *   Mapeamento (tasks\task650\mapeamento.json):
    *     SIGOPC44.cntSombra       -> cnt_4c_Sombra
    *     SIGOPC44.cntSombra.lblSombra -> lbl_4c_LblSombra
    *     SIGOPC44.cntSombra.lblTitulo -> lbl_4c_LblTitulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro
        TRY
            *-- cntSombra original: Top=0, Left=0, Width=800 (-> THIS.Width), Height=80
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels adicionados FORA do WITH do container (WITH aninhado com
            *-- AddObject ignora propriedades silenciosamente - regra conhecida)
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = THIS.Caption
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Shapes decorativos + botoes de acao do legado
    *   (filhos DIRETOS do form, igual ao SCX - SIGOPC44 nao tem PageFrame).
    *   Layout CAPTURA: o legado nao tem Grid/lista, entao este form nao tem
    *   botoes CRUD (Incluir/Alterar/Excluir/...) - CmdGera/CmdSair SAO os
    *   botoes de acao da tela. Somente estrutura + visual aqui; os Click
    *   (GerarRegistro1/2/3 do BO + fechamento do form) entram na Fase 7.
    *
    *   Mapeamento (tasks\task650\mapeamento.json):
    *     SIGOPC44.ShpSair -> shp_4c_ShpSair
    *     SIGOPC44.Shape2  -> shp_4c_Shape2
    *     SIGOPC44.CmdGera -> cmd_4c_CmdGera
    *     SIGOPC44.CmdSair -> cmd_4c_CmdSair
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro
        TRY
            *-- Shape2 original: Top=82, Left=3, Width=265, Height=161 -
            *-- moldura decorativa em torno do bloco "destino do arquivo"
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 82
                .Left          = 3
                .Width         = 265
                .Height        = 161
                .SpecialEffect = 0
            ENDWITH

            *-- ShpSair original: Top=204, Left=288, Width=144, Height=56 -
            *-- moldura decorativa (transparente) em torno dos botoes
            THIS.AddObject("shp_4c_ShpSair", "Shape")
            WITH THIS.shp_4c_ShpSair
                .Top           = 204
                .Left          = 288
                .Width         = 144
                .Height        = 56
                .BackStyle     = 0
                .BorderStyle   = 0
                .BorderWidth   = 0
                .SpecialEffect = 0
            ENDWITH

            *-- CmdGera original: Top=3, Left=352, Width=75, Height=75
            THIS.AddObject("cmd_4c_CmdGera", "CommandButton")
            WITH THIS.cmd_4c_CmdGera
                .Top        = 3
                .Left       = 352
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
                .Caption    = "\<Gera Arquivo"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
            ENDWITH

            *-- CmdSair original: Top=3, Left=427, Width=75, Height=75
            THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
            WITH THIS.cmd_4c_CmdSair
                .Top        = 3
                .Left       = 427
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "<ESC> Sair"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
            ENDWITH

            *-- Eventos dos botoes de acao (Fase 7). PUBLIC (nao PROTECTED) -
            *-- BINDEVENT exige metodo nao-PROTECTED (regra #3).
            BINDEVENT(THIS.cmd_4c_CmdGera, "Click", THIS, "CmdGeraClick")
            BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "CmdSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposDados - Campos de dados do dialogo (filhos DIRETOS do
    *   form, igual ao SCX - SIGOPC44 nao tem PageFrame nem Page).
    *   FASE 5/8 (1a metade): destino do arquivo (txtdest) e data do estoque
    *   (getDtEst), com seus labels. A 2a metade (getFinal/getNumParc) entra
    *   na Fase 6. Os valores padrao (TxtDest = caminho de SigCdPac.DirCat44,
    *   GetDtEst = Date()) vem do Init legado e serao aplicados via BO em
    *   fase posterior - aqui soh a estrutura visual (PILAR 3: estrutura
    *   primeiro, dado depois).
    *
    *   Mapeamento (tasks\task650\mapeamento.json):
    *     SIGOPC44.txtdest -> txt_4c_Txtdest
    *     SIGOPC44.Label2  -> lbl_4c_Label2
    *     SIGOPC44.getDtEst -> txt_4c_DtEst
    *     SIGOPC44.Label3   -> lbl_4c_Label3
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposDados()
        LOCAL loc_oErro
        TRY
            *-- Label2 original: Top=119, Left=12, Width=173, Height=17
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .BackStyle  = 0
                .Caption    = "O arquivo ser" + CHR(225) + " gerado em :"
                .Height     = 17
                .Left       = 12
                .Top        = 119
                .Width      = 173
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *-- txtdest original: Top=134, Left=8, Width=253, Height=23 -
            *-- ReadOnly/TabStop=.F. no legado (so exibe o caminho, nao edita)
            THIS.AddObject("txt_4c_Txtdest", "TextBox")
            WITH THIS.txt_4c_Txtdest
                .Top               = 134
                .Left              = 8
                .Width             = 253
                .Height            = 23
                .FontName          = "Tahoma"
                .ReadOnly          = .T.
                .TabStop           = .F.
                .TabIndex          = 4
                .Value             = ""
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(128, 128, 128)
            ENDWITH

            *-- Label3 original: AutoSize=.T. (no-op em AddObject - regra #23),
            *-- Width=113/Height=16 ja sao os valores calculados pelo Form
            *-- Designer - transcrever explicito com AutoSize=.F.
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .BackStyle  = 0
                .Caption    = "Data do Estoque :"
                .Height     = 16
                .Left       = 13
                .Top        = 92
                .Width      = 113
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *-- getDtEst original: Top=89, Left=128, Width=80, Height=23,
            *-- Format="!K" (maiuscula + seleciona ao entrar), MaxLength=10
            THIS.AddObject("txt_4c_DtEst", "TextBox")
            WITH THIS.txt_4c_DtEst
                .Top               = 89
                .Left              = 128
                .Width             = 80
                .Height            = 23
                .FontBold          = .F.
                .FontItalic        = .F.
                .FontName          = "Tahoma"
                .FontSize          = 9
                .FontUnderline     = .F.
                .Alignment         = 0
                .BackStyle         = 1
                .BorderStyle       = 1
                .SpecialEffect     = 0
                .Format            = "!K"
                .MaxLength         = 10
                .TabIndex          = 1
                .Value             = {}
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarCamposDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposDados2 - Campos de dados do dialogo (filhos DIRETOS do
    *   form, igual ao SCX - SIGOPC44 nao tem PageFrame nem Page).
    *   FASE 6/8 (2a metade): finalidade do arquivo (getFinal - combobox com
    *   as 2 opcoes literais do legado) e numero de parcelas para pagamento
    *   do ICMS (getNumParc), com seus labels. Sem lookups: o legado nao tem
    *   nenhuma chamada fwbuscaext/fwBuscaSel/sigacess no dump de origem.
    *
    *   Mapeamento (tasks\task650\mapeamento.json):
    *     SIGOPC44.getFinal   -> cbo_4c_GetFinal
    *     SIGOPC44.Label1     -> lbl_4c_Label1
    *     SIGOPC44.getNumParc -> txt_4c_NumParc
    *     SIGOPC44.Label4     -> lbl_4c_Label4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposDados2()
        LOCAL loc_oErro
        TRY
            *-- Label1 original: Top=167, Left=12, Width=173, Height=17
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .BackStyle  = 0
                .Caption    = "Finalidade do Arquivo"
                .Height     = 17
                .Left       = 12
                .Top        = 167
                .Width      = 173
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *-- getFinal original: Top=183, Left=8, Width=254, Height=22,
            *-- Style=2 (dropdown list), RowSourceType=1 (Value), RowSource
            *-- com as 2 opcoes literais do legado - ListIndex (1/2) eh o
            *-- que GeraReg1 grava em CodFinal (this_nFinalidade no BO)
            THIS.AddObject("cbo_4c_GetFinal", "ComboBox")
            WITH THIS.cbo_4c_GetFinal
                .Top           = 183
                .Left          = 8
                .Width         = 254
                .Height        = 22
                .FontName      = "Tahoma"
                .SpecialEffect = 0
                .Style         = 2
                .RowSourceType = 1
                .RowSource     = "1 - Normal,2 - Substitutivo Total"
                .TabIndex      = 6
            ENDWITH

            *-- Label4 original: AutoSize=.T. (no-op em AddObject - regra #23),
            *-- Width=202/Height=16 ja sao os valores calculados pelo Form
            *-- Designer - transcrever explicito com AutoSize=.F.
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .BackStyle  = 0
                .Caption    = "N" + CHR(186) + " Parcelas p/ Pagamento ICMS:"
                .Height     = 16
                .Left       = 10
                .Top        = 217
                .Width      = 202
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *-- getNumParc original: Top=213, Left=216, Width=40, Height=23,
            *-- Format="!K", MaxLength=3 - Value NUMERICO (Init legado faz
            *-- .GetNumParc.Value = 1; GeraReg3 le ThisForm.getNumParc.Value
            *-- direto em expressao aritmetica/STR, nunca ALLTRIM/char)
            THIS.AddObject("txt_4c_NumParc", "TextBox")
            WITH THIS.txt_4c_NumParc
                .Top               = 213
                .Left              = 216
                .Width             = 40
                .Height            = 23
                .FontBold          = .F.
                .FontItalic        = .F.
                .FontName          = "Tahoma"
                .FontSize          = 9
                .FontUnderline     = .F.
                .Alignment         = 0
                .BackStyle         = 1
                .BorderStyle       = 1
                .SpecialEffect     = 0
                .Format            = "!K"
                .MaxLength         = 3
                .TabIndex          = 7
                .Value             = 0
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
            ENDWITH

            *-- Com os QUATRO campos ja criados, aplica os defaults que o
            *-- Init legado escreve direto nos controles (Date() / 1 / "C:\")
            THIS.AplicarValoresPadrao()

            *-- Eventos dos campos de entrada. BINDEVENT em "KeyPress" nos
            *-- dois TextBox digitaveis - nunca "Valid", que nao dispara de
            *-- forma confiavel em TextBox, nem "LostFocus", que dispara
            *-- tambem quando outro controle recebe o foco. Na combo (Style=2,
            *-- dropdown list) o evento eh "InteractiveChange". txt_4c_Txtdest
            *-- NAO recebe handler: eh ReadOnly/TabStop=.F. no legado, o
            *-- usuario nao digita nele (o valor vem de SigCdPac.dircat44).
            BINDEVENT(THIS.txt_4c_DtEst, "KeyPress", THIS, "DtEstKeyPress")
            BINDEVENT(THIS.txt_4c_NumParc, "KeyPress", THIS, "NumParcKeyPress")
            BINDEVENT(THIS.cbo_4c_GetFinal, "InteractiveChange", THIS, ;
                "FinalidadeInteractiveChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarCamposDados2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarValoresPadrao - TRANSCRICAO dos defaults que o Init legado
    *   escreve DIRETO nos controles (SigOpC44_form_codigo_fonte.txt,
    *   PROCEDURE Init de SIGOPC44):
    *
    *       .TxtDest.Value = [C:\]
    *       If Not Empty(crSigCdPac.DirCat44)
    *           .TxtDest.Value = crSigCdPac.DirCat44
    *       EndIf
    *       .GetDtEst.Value   = Date()
    *       .GetNumParc.Value = 1
    *
    *   O legado NAO atribui getFinal.ListIndex - a combo nasce sem item
    *   selecionado (ListIndex = 0) de proposito, e eh justamente isso que o
    *   3o guard do CmdGera.Click ("Finalidade do arquivo nao informada!")
    *   testa. Nao assinar ListIndex aqui eh fidelidade, nao omissao.
    *
    *   O destino sai do BO (SigOpC44BO.CarregarParametros le SigCdPac.
    *   dircat44 e cai em "C:\" quando a coluna esta vazia); enquanto o BO
    *   ainda nao carregou, vale o literal "C:\" do legado. No fim espelha
    *   tela -> BO, para que GerarRegistro1/2/3 leiam os MESMOS valores que o
    *   usuario ve (o legado le ThisForm.<campo>.Value direto nos tres).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarValoresPadrao()
        LOCAL loc_cDestino, loc_oErro

        TRY
            loc_cDestino = "C:\"
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF !EMPTY(THIS.this_oBusinessObject.this_cDestino)
                    loc_cDestino = ALLTRIM(THIS.this_oBusinessObject.this_cDestino)
                ENDIF
            ENDIF

            THIS.txt_4c_Txtdest.Value = loc_cDestino
            THIS.txt_4c_DtEst.Value   = DATE()
            THIS.txt_4c_NumParc.Value = 1

            *-- Tela -> BO: o TextBox eh a fonte do valor, igual ao legado
            THIS.FormParaBO()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.AplicarValoresPadrao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DtEstKeyPress / NumParcKeyPress / FinalidadeInteractiveChange - eventos
    *   dos campos de entrada, ligados por BINDEVENT (logo PUBLIC - metodo
    *   PROTECTED falha em SILENCIO neste uso, CLAUDE.md regra #3).
    *   LPARAMETERS/assinatura obrigatoria nos de KeyPress: sem os parametros
    *   o VFP9 estoura "No PARAMETER statement is found" na 1a tecla digitada.
    *
    *   NAO validam nem exibem mensagem: no SCX legado NENHUM campo tem
    *   Valid/When/LostFocus (o dump tem apenas gerareg1/gerareg2/gerareg3/
    *   Init/Load e os dois Click). As tres regras dos campos rodam DE UMA VEZ
    *   em THIS.ValidarParametros(), que o Click do botao Gerar Arquivo chama,
    *   igual ao legado. Antecipar a mensagem aqui divergiria do PILAR 1: ao
    *   sair da Data do Estoque com a Finalidade ainda nao escolhida o usuario
    *   receberia "Finalidade do arquivo nao informada!", que o legado nunca
    *   exibe nesse momento.
    *
    *   Ao confirmar o campo (ENTER/TAB) so espelham o valor nas properties do
    *   BO. Na combo o evento eh InteractiveChange (Style = 2, dropdown list:
    *   o usuario escolhe com mouse/setas, nunca digita) e ela nao recebe
    *   parametro nenhum.
    *--------------------------------------------------------------------------
    PROCEDURE DtEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    PROCEDURE NumParcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    PROCEDURE FinalidadeInteractiveChange()
        THIS.FormParaBO()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transporta os parametros de geracao da TELA para as
    *   properties do BO. Este form tem exatamente QUATRO campos (destino,
    *   data do estoque, finalidade e numero de parcelas), logo o FormParaBO
    *   cobre os quatro e nada mais.
    *
    *   ConverterParaData() em vez de TTOD(): o .Value nasce DATE (DATE() em
    *   AplicarValoresPadrao) mas pode chegar como DATETIME ou CHAR conforme o
    *   caminho - TTOD() com DATE dispara erro 11 em RUNTIME (regra #16). O
    *   numero de parcelas tolera Caractere pelo mesmo motivo: o .Value de um
    *   TextBox com Format pode voltar como string.
    *
    *   this_nFinalidade recebe o LISTINDEX (1 = Normal, 2 = Substitutivo
    *   Total), nao o Value: eh o indice que o GeraReg1 legado grava em
    *   CodFinal (Str(ThisForm.GetFinal.ListIndex, 1)).
    *
    *   PROTECTED explicito: FormBase declara "PROTECTED PROCEDURE
    *   FormParaBO()" / "PROTECTED PROCEDURE BOParaForm()", e em VFP9
    *   redeclarar na subclasse SEM o modificador NAO alarga o escopo herdado
    *   (regra #51). Nao ha perda: os dois sao chamados so de dentro da classe
    *   (AplicarValoresPadrao, os handlers de evento e ValidarParametros).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_uParcelas

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_uParcelas = THIS.txt_4c_NumParc.Value

            WITH THIS.this_oBusinessObject
                .this_cDestino     = ALLTRIM(THIS.txt_4c_Txtdest.Value)
                .this_dDataEstoque = ConverterParaData(THIS.txt_4c_DtEst.Value)
                .this_nFinalidade  = THIS.cbo_4c_GetFinal.ListIndex
                .this_nNumParcelas = IIF(VARTYPE(loc_uParcelas) = "N", ;
                    loc_uParcelas, VAL(TRANSFORM(loc_uParcelas)))
            ENDWITH

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso: joga os parametros do BO nos quatro
    *   campos. Usado depois de SigOpC44BO.CarregarParametros(), que eh quem
    *   le SigCdPac.dircat44 e preenche this_cDestino (equivalente ao
    *   "If Not Empty(crSigCdPac.DirCat44)" do Init legado). O Form NAO
    *   recalcula nada - le do BO (PILAR 3: fonte unica).
    *
    *   PROTECTED pelo mesmo motivo do FormParaBO acima.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_nFinalidade

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_Txtdest.Value = IIF(EMPTY(.this_cDestino), "C:\", ;
                    ALLTRIM(.this_cDestino))
                THIS.txt_4c_DtEst.Value   = ConverterParaData(.this_dDataEstoque)
                THIS.txt_4c_NumParc.Value = .this_nNumParcelas
                loc_nFinalidade           = .this_nFinalidade
            ENDWITH

            *-- ListIndex eh 1-based: so atribui indice que existe na lista
            *-- (RowSource tem 2 itens). Zero significa "nada escolhido", que
            *-- eh o estado em que o legado deixa a combo.
            IF BETWEEN(loc_nFinalidade, 1, 2)
                THIS.cbo_4c_GetFinal.ListIndex = loc_nFinalidade
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - TRANSCRICAO dos tres guards que o legado escreveu no
    *   inicio do Click do CmdGera (SigOpC44_form_codigo_fonte.txt, OBJETO:
    *   SIGOPC44.CmdGera, PROCEDURE Click):
    *
    *       If Empty(ThisForm.Txtdest.Value)
    *           =MessageBox('Destino de Arquivo Invalido!!!' + Chr(13) + ;
    *                       'Verifique a Configuracao da Empresa.', 48, 'Destino Invalido...')
    *           ThisForm.CmdSair.SetFocus
    *           Return .f.
    *       EndIf
    *       If Empty(ThisForm.getDtEst.Value)
    *           =MessageBox('Data do Estoque nao informada!',48,'Data do Estoque invalida...')
    *           ThisForm.getDtEst.SetFocus
    *           Return(.F.)
    *       Endif
    *       If ThisForm.getFinal.ListIndex <= 0
    *           =MessageBox('Finalidade do arquivo nao informada!',48,'Finalidade invalida...')
    *           ThisForm.getFinal.SetFocus
    *           Return(.F.)
    *       Endif
    *
    *   A regra governa os campos que ESTA fase entrega, por isso nasce aqui;
    *   o Click do botao Gerar Arquivo so CHAMA
    *   (IF !THIS.ValidarParametros() / RETURN). Icone 48 do MessageBox =
    *   validacao de UI, logo MsgAviso - MsgErro (dialogo vermelho com
    *   "Fechar Aplicacao") assustaria o usuario sem motivo. Ordem, mensagens,
    *   titulos e destino do SetFocus sao os do legado, caractere a caractere
    *   (acentos via CHR(), regra #4).
    *
    *   PUBLIC porque o handler do botao chama de fora deste bloco e o
    *   TesteAutomatico.prg pode invocar direto (regras #3 e #51).
    *
    *   FormParaBO() ANTES dos guards: o TEXTBOX eh a fonte do valor (o legado
    *   le ThisForm.<campo>.Value), e sem o espelho o BO geraria o arquivo com
    *   o parametro ANTIGO.
    *
    *   RETURN unico, DEPOIS do ENDTRY (regra #1 - RETURN dentro de TRY/CATCH
    *   eh proibido, inclusive o bare).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido, loc_oErro

        loc_lValido = .F.

        TRY
            *-- Tela -> BO antes de qualquer guard (fonte unica = o controle)
            THIS.FormParaBO()

            DO CASE
                CASE EMPTY(THIS.txt_4c_Txtdest.Value)
                    MsgAviso("Destino de Arquivo Inv" + CHR(225) + "lido!!!" + CHR(13) + ;
                        "Verifique a Configura" + CHR(231) + CHR(227) + "o da Empresa.", ;
                        "Destino Inv" + CHR(225) + "lido...")
                    THIS.cmd_4c_CmdSair.SetFocus()

                CASE EMPTY(THIS.txt_4c_DtEst.Value)
                    MsgAviso("Data do Estoque n" + CHR(227) + "o informada!", ;
                        "Data do Estoque inv" + CHR(225) + "lida...")
                    THIS.txt_4c_DtEst.SetFocus()

                CASE THIS.cbo_4c_GetFinal.ListIndex <= 0
                    MsgAviso("Finalidade do arquivo n" + CHR(227) + "o informada!", ;
                        "Finalidade inv" + CHR(225) + "lida...")
                    THIS.cbo_4c_GetFinal.SetFocus()

                OTHERWISE
                    loc_lValido = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ValidarParametros")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGeraClick - TRANSCRICAO do SIGOPC44.CmdGera.Click (os tres guards
    *   ja migraram para ValidarParametros na Fase 6 - aqui so chama):
    *
    *       If MessageBox('Confirma a Geracao do Arquivo ?', 4+32+256, ;
    *               'Confirmacao de Geracao' ) <> 6
    *           =MessageBox('Operacao Cancelada Pelo Usuario!!!', 64, '')
    *           Return
    *       EndIf
    *       lcPoint = Set('Point')
    *       Set Point To [,]
    *       ThisForm.GeraReg1() / GeraReg2() / GeraReg3()
    *       lcNomFile = [CAT44]+Strtran(Dtoc(ThisForm.GetDtEst.Value),[/],[])+[.TXT]
    *       xNmArq = ADDBS(ThisForm.TxtDest.Value) + lcNomFile
    *       nHandle = Fcreate(xNmArq)
    *       <grava crReg1 (1 linha) + crReg2 (1 linha por produto, SCAN) +
    *        crReg3 (1 linha), cada linha pipe-delimitada com Alltrim de cada
    *        campo, Chr(13)+Chr(10) no fim - ver MontarLinhaRegistro>
    *       Fclose(nHandle)
    *       lcFileStr = FileToStr(xNmArq) / StrToFile(lcFileStr,xNmArq,4)
    *       =MessageBox('Arquivo Gerado : ' + xNmArq, 0+64, 'Processamento
    *           Concluido!!!')
    *       Set Point To lcPoint
    *       Wait Clear
    *       ThisForm.CmdSair.SetFocus
    *
    *   MessageBox(...,4+32+256,...) <> 6 (Sim/Nao, icone pergunta, botao
    *   padrao 3) vira MsgConfirma() - regra #7 (MsgConfirma retorna LOGICAL).
    *   "Set Point To [,]" troca o separador decimal para virgula enquanto os
    *   REPLACE ... WITH STR(...) do BO (GerarRegistro1/2/3) formatam os
    *   campos numericos dos registros - por isso o Set Point precisa cercar
    *   exatamente essas tres chamadas, igual ao legado, e ser restaurado
    *   antes do MsgInfo final (aqui restaurado um pouco antes, sem efeito
    *   pratico: a formatacao ja aconteceu, e nada mais formata numero depois).
    *   "Wait Clear" do legado fecha um WAIT WINDOW NOWAIT que nunca foi
    *   aberto por este Click (nenhum MsgProcessando/WAIT WINDOW precede) -
    *   no-op vestigial, nao transcrito (nao ha WAIT WINDOW para limpar).
    *
    *   RETURN unico fora do TRY (regra #1) via flag loc_lProsseguir - os
    *   dois "Return"/"Return .f." do legado (guard falhou / usuario cancelou)
    *   viram "nao entra no bloco seguinte", nunca RETURN dentro do TRY.
    *
    *   PUBLIC: ligado via BINDEVENT em ConfigurarBotoesAcao (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdGeraClick()
        LOCAL loc_lProsseguir, loc_cPointAnterior, loc_cNomeArquivo, ;
            loc_cCaminhoArquivo, loc_nHandle, loc_cConteudoArquivo, loc_oErro

        loc_lProsseguir = .F.

        TRY
            IF THIS.ValidarParametros()
                IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo ?", ;
                        "Confirma" + CHR(231) + CHR(227) + "o de Gera" + CHR(231) + CHR(227) + "o")
                    loc_lProsseguir = .T.
                ELSE
                    MsgInfo("Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usu" + CHR(225) + "rio!!!", "")
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cPointAnterior = SET("POINT")
                SET POINT TO ","

                THIS.this_oBusinessObject.GerarRegistro1()
                THIS.this_oBusinessObject.GerarRegistro2()
                THIS.this_oBusinessObject.GerarRegistro3()

                loc_cNomeArquivo = "CAT44" + STRTRAN(DTOC(THIS.txt_4c_DtEst.Value), "/", "") + ".TXT"
                loc_cCaminhoArquivo = ADDBS(ALLTRIM(THIS.txt_4c_Txtdest.Value)) + loc_cNomeArquivo

                loc_nHandle = FCREATE(loc_cCaminhoArquivo)

                SELECT (THIS.this_oBusinessObject.this_cCursorReg1)
                GO TOP
                =FWRITE(loc_nHandle, THIS.MontarLinhaRegistro(THIS.this_oBusinessObject.this_cCursorReg1))

                SELECT (THIS.this_oBusinessObject.this_cCursorReg2)
                SCAN
                    =FWRITE(loc_nHandle, THIS.MontarLinhaRegistro(THIS.this_oBusinessObject.this_cCursorReg2))
                ENDSCAN

                SELECT (THIS.this_oBusinessObject.this_cCursorReg3)
                GO TOP
                =FWRITE(loc_nHandle, THIS.MontarLinhaRegistro(THIS.this_oBusinessObject.this_cCursorReg3))

                =FCLOSE(loc_nHandle)

                SET POINT TO (loc_cPointAnterior)

                *-- Ida-e-volta FileToStr/StrToFile(...,4) do legado - mantida
                *-- literal (regra #17: transcrever, nao reinterpretar).
                loc_cConteudoArquivo = FILETOSTR(loc_cCaminhoArquivo)
                =STRTOFILE(loc_cConteudoArquivo, loc_cCaminhoArquivo, 4)

                MsgInfo("Arquivo Gerado : " + loc_cCaminhoArquivo, ;
                    "Processamento Conclu" + CHR(237) + "do!!!")

                THIS.cmd_4c_CmdSair.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.CmdGeraClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarLinhaRegistro - monta uma linha pipe-delimitada com ALLTRIM() de
    *   cada campo do registro CORRENTE do cursor par_cAlias, terminada em
    *   Chr(13)+Chr(10). TRANSCRICAO do laco generico do legado:
    *
    *       m.lcLinha = []
    *       For i = 1 To lnQtCampos
    *           lcCampo = Fields(i)
    *           m.lcLinha = m.lcLinha + Iif(not Empty(m.lcLinha),[|],[]) + Alltrim(&lcCampo)
    *       Next i
    *       m.lcLinha = m.lcLinha + Chr(13) + Chr(10)
    *
    *   FIELD(nFieldNo, cAlias) no lugar de FIELDS(i) (nome antigo da mesma
    *   funcao) e EVALUATE() no lugar de "&lcCampo" (macro) - EVALUATE eh
    *   leitura, regra #15 permite. O guard "Iif(not Empty(m.lcLinha),...)"
    *   eh transcrito tal qual: se um campo intermediario vier vazio depois
    *   do ALLTRIM, o pipe daquela posicao nao entra - comportamento do
    *   legado, nao bug deste metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarLinhaRegistro(par_cAlias)
        LOCAL loc_nTotalCampos, loc_nI, loc_cCampo, loc_cLinha

        loc_cLinha = ""
        loc_nTotalCampos = FCOUNT(par_cAlias)

        FOR loc_nI = 1 TO loc_nTotalCampos
            loc_cCampo = FIELD(loc_nI, par_cAlias)
            loc_cLinha = loc_cLinha + IIF(!EMPTY(loc_cLinha), "|", "") + ;
                ALLTRIM(EVALUATE(par_cAlias + "." + loc_cCampo))
        ENDFOR

        RETURN loc_cLinha + CHR(13) + CHR(10)
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - TRANSCRICAO do SIGOPC44.CmdSair.Click ("ThisForm.Release",
    *   nada mais). PUBLIC: ligado via BINDEVENT em ConfigurarBotoesAcao.
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object e restaura o menu principal
    * (fix sistemico mora em FormBase.Destroy - DODEFAULT() eh OBRIGATORIO)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

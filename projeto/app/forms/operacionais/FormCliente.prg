*==============================================================================
* FormCliente.prg
* Form Cadastro de Cliente (OPERACIONAL - wrapper clsconta / ClassResp.vcx)
* Migrado de SIGCDCLI.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (852x600)
*   BD   -> SIGCDCLI via clsconta.mGravaDados/mValidaObj
*   CODE -> arquitetura em camadas (FormBase / ClienteBO)
*
* Parametros Init: pCpf, pGrupo, pCep, pVal, pCli, pcTpBloqCar, pcMudaCpfCgc
* Retorno (Unload): RetCodCliente (IClis ou CPF/CNPJ gravado)
*==============================================================================

DEFINE CLASS FormCliente AS FormBase

    *-- Propriedades visuais (copiadas do original)
    Height       = 600
    Width        = 852
    AutoCenter   = .T.
    Caption      = "Cadastro de Cliente"
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 1
    DataSession  = 2
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades customizadas (conforme RESERVED3/ClassInfo do original)
    this_cMensagemErro = ""
    mudavend           = .F.
    plaltcd            = .F.
    RetCodCliente      = " "
    pcEscolha          = ""

    *-- Integracao com BusinessObject (cliBO)
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *-- Parametros recebidos em Init (armazenados para uso em InicializarForm)
    this_cCpf         = ""
    this_cGrupo       = ""
    this_nCep         = 0
    this_lVal         = .F.
    this_cCli         = ""
    this_cTpBloqCar   = "0"
    this_cMudaCpfCgc  = "0"

    *============================================================
    PROCEDURE Init
    *============================================================
        LPARAMETERS par_cCpf, par_cGrupo, par_nCep, par_lVal, par_cCli, par_cTpBloqCar, par_cMudaCpfCgc

        *-- Normalizar e armazenar parametros antes de DODEFAULT (que chama InicializarForm)
        THIS.this_cCpf        = IIF(TYPE("par_cCpf")        = "C", PADR(par_cCpf, 20),        SPACE(20))
        THIS.this_cGrupo      = IIF(TYPE("par_cGrupo")      = "C", PADR(par_cGrupo, 10),      SPACE(10))
        THIS.this_nCep        = IIF(TYPE("par_nCep")        = "N", par_nCep,                  0)
        THIS.this_lVal        = IIF(TYPE("par_lVal")        = "L", par_lVal,                  .F.)
        THIS.this_cCli        = IIF(TYPE("par_cCli")        = "C", PADR(par_cCli, 10),        SPACE(10))
        THIS.this_cTpBloqCar  = IIF(TYPE("par_cTpBloqCar")  = "C", par_cTpBloqCar,            "0")
        THIS.this_cMudaCpfCgc = IIF(TYPE("par_cMudaCpfCgc") = "C", par_cMudaCpfCgc,           "0")

        RETURN DODEFAULT()
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE InicializarForm
    *============================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cCpf, loc_cGrupo, loc_lRetLeDados
        loc_lSucesso = .F.

        TRY
            *-- Instanciar Business Object (cliBO)
            THIS.this_oBusinessObject = CREATEOBJECT("cliBO")

            *-- Fundo de tela (imagem legado Fortyus em Framework\imagens\)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Normalizar CPF (remover pontuacao para verificacao)
            loc_cCpf = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(THIS.this_cCpf), ".", ""), "-", ""), "/", "")

            *-- Determinar grupo padrao se nao informado
            loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
            IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                LOCATE
                IF !EOF("crSigCdPam")
                    loc_cGrupo = PADR(crSigCdPam.GrPadClis, 10)
                    THIS.this_cGrupo = loc_cGrupo
                ENDIF
            ENDIF

            *-- Verificar grupo configurado
            IF EMPTY(ALLTRIM(THIS.this_cGrupo))
                MsgAviso("Grupo Padr" + CHR(227) + "o N" + CHR(227) + "o Configurado.")
                loc_lSucesso = .T.
            ELSE
                *-- Definir modo (INSERIR / ALTERAR)
                THIS.mudavend = .T.
                IF EMPTY(ALLTRIM(THIS.this_cCli))
                    THIS.pcEscolha       = "INSERIR"
                    THIS.this_cModoAtual = "INCLUIR"
                    THIS.plaltcd         = .F.
                ELSE
                    THIS.plaltcd         = .T.
                    THIS.pcEscolha       = "ALTERAR"
                    THIS.this_cModoAtual = "ALTERAR"
                ENDIF

                *-- Criar componentes visuais
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarContaCls()
                THIS.ConfigurarBotoesSair()
                THIS.TornarControlesVisiveis()

                *-- Inicializar clsconta
                THIS.cnt_4c_Conta.mIniConta()
                THIS.cnt_4c_Conta.pgframeDados.Top = 0
                THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.ToolTipText = "F5 - Dados Pessoais/Comerciais"

                *-- Ajustar navegacao inicial do PageFrame interno (pgframeDados)
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaDados2()

                *-- Carregar dados do cliente
                loc_lRetLeDados = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)

                IF loc_lRetLeDados
                    THIS.cnt_4c_Conta.cmdgftec.Visible = .F.

                    IF THIS.pcEscolha = "INSERIR" AND !EMPTY(loc_cCpf)
                        WITH THIS.cnt_4c_Conta.pgframeDados.pgframeDados1
                            .OpcaoCPFCGC.Value = IIF(LEN(loc_cCpf) <> 14, 1, 2)
                            .GetCPFCGC.Value   = THIS.this_cCpf
                        ENDWITH
                        THIS.cnt_4c_Conta.mAtuGetCpf()
                    ENDIF

                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro Na Leitura dos Dados", "Erro")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *============================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = -1
            .Left       = -1
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth = 0
            .BackColor  = RGB(100,100,100)
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de Cliente"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Caption    = "Cadastro de Cliente"
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = 769
            .ForeColor  = RGB(255,255,255)
            .Visible    = .T.
        ENDWITH
        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarContaCls
    *============================================================
        LOCAL loc_oErro, loc_cVcx1, loc_cVcx2, loc_cVcx3
        *-- gc_4c_CaminhoFramework aponta para C:\4c\Framework\ (config.prg:67)
        *-- Path anterior (gc_4c_CaminhoBase + "Framework\...") resolvia incorretamente
        *-- para C:\4c\projeto\app\start\Framework\ (inexistente).
        loc_cVcx1 = gc_4c_CaminhoFramework + "framework.vcx"
        loc_cVcx2 = gc_4c_CaminhoFramework + "classobj.vcx"
        loc_cVcx3 = gc_4c_CaminhoFramework + "classresp.vcx"

        TRY
            IF FILE(loc_cVcx1)
                SET CLASSLIB TO (loc_cVcx1) ADDITIVE
            ENDIF
            IF FILE(loc_cVcx2)
                SET CLASSLIB TO (loc_cVcx2) ADDITIVE
            ENDIF
            IF FILE(loc_cVcx3)
                SET CLASSLIB TO (loc_cVcx3) ADDITIVE
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar biblioteca de classes: " + loc_oErro.Message, "Erro")
        ENDTRY

        THIS.AddObject("cnt_4c_Conta", "clsconta")
        WITH THIS.cnt_4c_Conta
            .Top    = 132
            .Left   = 12
            .Width  = 768
            .Height = 450
            .Visible     = .T.
        ENDWITH
        *-- cnt_4c_Conta permanece oculto ate mLeDados retornar .T. em InicializarForm
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarBotoesSair
    *============================================================
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Sair", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Sair
        WITH loc_oCmg
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 85
            .Left          = 688
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 161
        ENDWITH
        WITH loc_oCmg.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption    = "\<Ok"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH loc_oCmg.Buttons(2)
            .Top        = 5
            .Left       = 81
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "\<Cancelar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        THIS.cmg_4c_Sair.Visible = .T.

        *-- Bind eventos dos botoes (metodos PUBLIC por padrao VFP9)
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "BtnOkClick")
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *============================================================
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls[loc_i]
            *-- cnt_4c_Conta permanece oculto ate mLeDados ter sucesso
            IF UPPER(loc_oCtrl.Name) = "CNT_4C_CONTA"
                LOOP
            ENDIF
            loc_oCtrl.Visible = .T.
        ENDFOR
    ENDPROC

    *============================================================
    * Botao Ok / Gravar
    *============================================================
    PROCEDURE BtnOkClick
        LOCAL loc_nRetorno, loc_cCpfCgc

        loc_nRetorno = THIS.cnt_4c_Conta.mValidaObj()

        IF loc_nRetorno >= 0
            IF loc_nRetorno > 0
                IF THIS.cnt_4c_Conta.mGravaDados() > 0
                    loc_cCpfCgc = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
                        THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value, ;
                        ".", ""), "-", ""), "/", ""))

                    IF EMPTY(loc_cCpfCgc)
                        THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value
                    ELSE
                        THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value
                    ENDIF
                    THIS.Release()
                ELSE
                    MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados, " + ;
                        "Favor Clicar no Bot" + CHR(227) + "o [OK] Novamente.", "Erro")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *============================================================
    * Botao Cancelar
    *============================================================
    PROCEDURE BtnCancelarClick
        LOCAL loc_nCodigo, loc_nIdConta, loc_oErro

        *-- Liberar sequencial automatico se estava inserindo
        IF THIS.pcEscolha = "INSERIR"
            TRY
                IF USED("crSigCdCli")
                    SELECT crSigCdCli
                    loc_nCodigo  = crSigCdCli.NClis
                    loc_nIdConta = crSigCdCli.IdConta
                ELSE
                    loc_nCodigo  = 0
                    loc_nIdConta = 0
                ENDIF

                IF USED("crSigCdGcr")
                    SELECT crSigCdGcr
                    IF crSigCdGcr.TpCods = 1
                        IF crSigCdGcr.TpEmps = 1
                            = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos) + go_4c_Sistema.cCodEmpresa)
                        ELSE
                            = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos))
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                *-- fCanUniqueKey pode nao estar portada; nao bloquear o cancelamento
            ENDTRY
        ENDIF

        THIS.RetCodCliente = " "
        THIS.Release()
    ENDPROC

    *============================================================
    * ConfigurarPaginaLista - configura o estado inicial da pagina
    * principal (pgframeDados1) do PageFrame interno de clsconta.
    *
    * Forms OPERACIONAIS deste tipo (wrapper de clsconta) NAO usam
    * o padrao CRUD Page1=Lista/Page2=Dados. A "pagina de listagem"
    * corresponde a pgframeDados1 (Cadastro principal) do clsconta,
    * que exibe os campos primarios do cliente. O paginado interno
    * eh alternado via cmdgPessoal (F5) ou via THIS.AlternarPagina().
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        LOCAL loc_oPgf

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        loc_oPgf.Top        = 0
        loc_oPgf.ActivePage = 1
        loc_oPgf.Visible    = .T.

        *-- Realcar botao da pagina ativa (cmdgCadastro se existir)
        IF PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
            THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.SetFocus()
        ENDIF
    ENDPROC

    *============================================================
    * AlternarPagina - alterna entre as paginas do pgframeDados
    * interno de clsconta (1 = Cadastro, 2 = Dados Pessoais/Comerciais).
    *
    * Chamada por KeyPress (F5) ou por logica interna do form.
    * par_nPagina: se informada e valida (1..PageCount), navega
    * diretamente; caso contrario, alterna entre 1 e 2.
    *============================================================
    PROCEDURE AlternarPagina
        LPARAMETERS par_nPagina
        LOCAL loc_oPgf, loc_nDestino

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        IF TYPE("par_nPagina") = "N" AND par_nPagina >= 1 AND par_nPagina <= loc_oPgf.PageCount
            loc_nDestino = par_nPagina
        ELSE
            loc_nDestino = IIF(loc_oPgf.ActivePage = 1, 2, 1)
        ENDIF

        loc_oPgf.ActivePage = loc_nDestino

        *-- Delegar ao botao de comando correspondente do clsconta
        *-- para preservar comportamento original (highlight, refresh, etc.)
        DO CASE
        CASE loc_nDestino = 2 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgPessoal", 5) ;
             AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgPessoal, "cmdPessoal", 5)
            THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.Click()
        CASE loc_nDestino = 1 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) ;
             AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
            THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.Click()
        ENDCASE
    ENDPROC

    *============================================================
    PROCEDURE KeyPress
    *============================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = -4  && F5 = Aba Dados Pessoais/Comerciais
            NODEFAULT
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *============================================================
    PROCEDURE Unload
    *============================================================
        RETURN THIS.RetCodCliente
    ENDPROC

    *============================================================
    * ConfigurarPaginaDados - Aplica overrides visuais do SCX
    * legado nos controles internos de cnt_4c_Conta.pgframeDados1
    * (primeira metade: Shapes + primeiros Labels e TextBoxes).
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        LOCAL loc_oPgf, loc_oPg1, loc_oErro, loc_cNomeEndCtrl, loc_oEndCtrl, loc_cNomeRazCtrl, loc_oRazCtrl, loc_lContinuar

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        loc_lContinuar = .T.
        TRY
            IF PEMSTATUS(loc_oPgf, "ErasePage", 5)
                loc_oPgf.ErasePage = .T.
            ENDIF

            IF !PEMSTATUS(loc_oPgf, "pgframeDados1", 5)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
            loc_oPg1 = loc_oPgf.pgframeDados1

            *-- Propriedades da pagina
            IF PEMSTATUS(loc_oPg1, "FontName", 5)
                loc_oPg1.FontName = "Tahoma"
            ENDIF
            IF PEMSTATUS(loc_oPg1, "BackColor", 5)
                loc_oPg1.BackColor = RGB(255,255,255)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "ForeColor", 5)
                loc_oPg1.ForeColor = RGB(90,90,90)
            ENDIF

            *-- Shape1 (borda secao principal)
            IF PEMSTATUS(loc_oPg1, "Shape1", 5)
                WITH loc_oPg1.Shape1
                    .Top           = 2
                    .Left          = 6
                    .Height        = 195
                    .Width         = 751
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape2 (borda secao dados pessoais)
            IF PEMSTATUS(loc_oPg1, "Shape2", 5)
                WITH loc_oPg1.Shape2
                    .Top           = 196
                    .Left          = 6
                    .Width         = 751
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape4 (borda secao observacoes)
            IF PEMSTATUS(loc_oPg1, "Shape4", 5)
                WITH loc_oPg1.Shape4
                    .Top           = 344
                    .Left          = 6
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape3 (area foto)
            IF PEMSTATUS(loc_oPg1, "Shape3", 5)
                WITH loc_oPg1.Shape3
                    .Top    = 71
                    .Left   = 573
                    .Height = 77
                    .Width  = 182
                ENDWITH
            ENDIF

            *-- Shape5 (borda cabecalho foto)
            IF PEMSTATUS(loc_oPg1, "Shape5", 5)
                WITH loc_oPg1.Shape5
                    .Top         = 8
                    .Left        = 573
                    .Width       = 182
                    .BorderColor = RGB(100,100,100)
                ENDWITH
            ENDIF

            *-- Say2 (label nome/razao)
            IF PEMSTATUS(loc_oPg1, "Say2", 5)
                WITH loc_oPg1.Say2
                    .FontName  = "Tahoma"
                    .Left      = 31
                    .Top       = 58
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say12 (label empresa)
            IF PEMSTATUS(loc_oPg1, "Say12", 5)
                WITH loc_oPg1.Say12
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .Left      = 17
                    .Top       = 81
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say16 (label codigo)
            IF PEMSTATUS(loc_oPg1, "Say16", 5)
                WITH loc_oPg1.Say16
                    .FontName  = "Tahoma"
                    .Left      = 67
                    .Top       = 15
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say22 (label inscr. estadual)
            IF PEMSTATUS(loc_oPg1, "Say22", 5)
                WITH loc_oPg1.Say22
                    .FontName  = "Tahoma"
                    .Left      = 17
                    .Top       = 104
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayConjuges (label conjuge)
            IF PEMSTATUS(loc_oPg1, "sayConjuges", 5)
                WITH loc_oPg1.sayConjuges
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .Left      = 19
                    .Top       = 150
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtncons (label aniversario)
            IF PEMSTATUS(loc_oPg1, "sayDtncons", 5)
                WITH loc_oPg1.sayDtncons
                    .FontName  = "Tahoma"
                    .Caption   = "Aniv : "
                    .Left      = 362
                    .Top       = 150
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtcasas (label data casamento)
            IF PEMSTATUS(loc_oPg1, "sayDtcasas", 5)
                WITH loc_oPg1.sayDtcasas
                    .FontName  = "Tahoma"
                    .Left      = 330
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say29 (label usuario alt.)
            IF PEMSTATUS(loc_oPg1, "Say29", 5)
                WITH loc_oPg1.Say29
                    .FontName  = "Tahoma"
                    .Left      = 575
                    .Top       = 45
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say30 (label usuario cadastro)
            IF PEMSTATUS(loc_oPg1, "Say30", 5)
                WITH loc_oPg1.Say30
                    .FontName  = "Tahoma"
                    .Left      = 578
                    .Top       = 17
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say3 (label)
            IF PEMSTATUS(loc_oPg1, "Say3", 5)
                WITH loc_oPg1.Say3
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayIm (label inscr. municipal)
            IF PEMSTATUS(loc_oPg1, "SayIm", 5)
                WITH loc_oPg1.SayIm
                    .FontName  = "Tahoma"
                    .Left      = 390
                    .Top       = 105
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblCpf2 (label CPF/CNPJ socio)
            IF PEMSTATUS(loc_oPg1, "lblCpf2", 5)
                WITH loc_oPg1.lblCpf2
                    .FontName  = "Tahoma"
                    .Left      = 39
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say31 (label foto)
            IF PEMSTATUS(loc_oPg1, "Say31", 5)
                WITH loc_oPg1.Say31
                    .FontName  = "Tahoma"
                    .Left      = 619
                    .Top       = 77
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblRg2 (label RG socio)
            IF PEMSTATUS(loc_oPg1, "lblRg2", 5)
                WITH loc_oPg1.lblRg2
                    .FontName  = "Tahoma"
                    .Left      = 181
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayRgIe (label RG/IE)
            IF PEMSTATUS(loc_oPg1, "SayRgIe", 5)
                WITH loc_oPg1.SayRgIe
                    .FontName  = "Tahoma"
                    .Left      = 263
                    .Top       = 35
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDatNas (label data nascimento)
            IF PEMSTATUS(loc_oPg1, "sayDatNas", 5)
                WITH loc_oPg1.sayDatNas
                    .FontName  = "Tahoma"
                    .Left      = 444
                    .Top       = 58
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayResp (label responsavel)
            IF PEMSTATUS(loc_oPg1, "SayResp", 5)
                WITH loc_oPg1.SayResp
                    .FontName  = "Tahoma"
                    .Left      = 29
                    .Top       = 128
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say1 (label)
            IF PEMSTATUS(loc_oPg1, "Say1", 5)
                WITH loc_oPg1.Say1
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SaySexo (label sexo)
            IF PEMSTATUS(loc_oPg1, "SaySexo", 5)
                WITH loc_oPg1.SaySexo
                    .FontName  = "Tahoma"
                    .Left      = 443
                    .Top       = 35
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say21 (label)
            IF PEMSTATUS(loc_oPg1, "Say21", 5)
                WITH loc_oPg1.Say21
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say25 (label)
            IF PEMSTATUS(loc_oPg1, "Say25", 5)
                WITH loc_oPg1.Say25
                    .FontName  = "Tahoma"
                    .Left      = 581
                    .Top       = 139
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say32 (label)
            IF PEMSTATUS(loc_oPg1, "Say32", 5)
                WITH loc_oPg1.Say32
                    .FontName  = "Tahoma"
                    .Left      = 244
                    .Top       = 10
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say23 (label)
            IF PEMSTATUS(loc_oPg1, "Say23", 5)
                WITH loc_oPg1.Say23
                    .FontName  = "Tahoma"
                    .Left      = 600
                    .Top       = 123
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say33 (label)
            IF PEMSTATUS(loc_oPg1, "Say33", 5)
                WITH loc_oPg1.Say33
                    .FontName  = "Tahoma"
                    .Left      = 594
                    .Top       = 100
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblEstCivil (label estado civil)
            IF PEMSTATUS(loc_oPg1, "lblEstCivil", 5)
                WITH loc_oPg1.lblEstCivil
                    .FontName  = "Tahoma"
                    .Left      = 503
                    .Top       = 174
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Get_usualt (TextBox usuario alteracao)
            IF PEMSTATUS(loc_oPg1, "Get_usualt", 5)
                WITH loc_oPg1.Get_usualt
                    .Left      = 590
                    .Top       = 42
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Get_usuar (TextBox usuario cadastro)
            IF PEMSTATUS(loc_oPg1, "Get_usuar", 5)
                WITH loc_oPg1.Get_usuar
                    .Left      = 590
                    .Top       = 14
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Data_ent (TextBox data entrada)
            IF PEMSTATUS(loc_oPg1, "Data_ent", 5)
                WITH loc_oPg1.Data_ent
                    .Left      = 670
                    .Top       = 14
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Data_alt (TextBox data alteracao)
            IF PEMSTATUS(loc_oPg1, "Data_alt", 5)
                WITH loc_oPg1.Data_alt
                    .Left      = 670
                    .Top       = 42
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- GetCodigo (TextBox codigo)
            IF PEMSTATUS(loc_oPg1, "GetCodigo", 5)
                WITH loc_oPg1.GetCodigo
                    .Left = 290
                    .Top  = 8
                ENDWITH
            ENDIF

            *-- Get_Grupo (TextBox grupo)
            IF PEMSTATUS(loc_oPg1, "Get_Grupo", 5)
                WITH loc_oPg1.Get_Grupo
                    .Left = 108
                    .Top  = 8
                ENDWITH
            ENDIF

            *-- GetNome (TextBox nome)
            IF PEMSTATUS(loc_oPg1, "GetNome", 5)
                WITH loc_oPg1.GetNome
                    .Left = 70
                    .Top  = 55
                ENDWITH
            ENDIF

            *-- GetCPFCGC (TextBox CPF/CNPJ)
            IF PEMSTATUS(loc_oPg1, "GetCPFCGC", 5)
                WITH loc_oPg1.GetCPFCGC
                    .Left = 108
                    .Top  = 32
                ENDWITH
            ENDIF

            *-- GetRG (TextBox RG/IE)
            IF PEMSTATUS(loc_oPg1, "GetRG", 5)
                WITH loc_oPg1.GetRG
                    .Height = 23
                    .Left   = 290
                    .Top    = 32
                    .Width  = 149
                ENDWITH
            ENDIF

            *-- getSexo (ComboBox sexo)
            IF PEMSTATUS(loc_oPg1, "getSexo", 5)
                WITH loc_oPg1.getSexo
                    .Left = 483
                    .Top  = 32
                ENDWITH
            ENDIF

            *-- GetDatNas (TextBox data nascimento)
            IF PEMSTATUS(loc_oPg1, "GetDatNas", 5)
                WITH loc_oPg1.GetDatNas
                    .Left = 483
                    .Top  = 55
                ENDWITH
            ENDIF

            *-- getResp (TextBox codigo responsavel)
            IF PEMSTATUS(loc_oPg1, "getResp", 5)
                WITH loc_oPg1.getResp
                    .Left = 151
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- Get_grupoven (TextBox grupo de vendas)
            IF PEMSTATUS(loc_oPg1, "Get_grupoven", 5)
                WITH loc_oPg1.Get_grupoven
                    .Left = 70
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- getNresp (TextBox numero do responsavel)
            IF PEMSTATUS(loc_oPg1, "getNresp", 5)
                WITH loc_oPg1.getNresp
                    .Left = 232
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- Get_Emps (TextBox codigo empresa)
            IF PEMSTATUS(loc_oPg1, "Get_Emps", 5)
                WITH loc_oPg1.Get_Emps
                    .Left = 70
                    .Top  = 101
                ENDWITH
            ENDIF

            *-- Get_DEmps (TextBox descricao empresa)
            IF PEMSTATUS(loc_oPg1, "Get_DEmps", 5)
                WITH loc_oPg1.Get_DEmps
                    .Left = 100
                    .Top  = 101
                ENDWITH
            ENDIF

            *-- Get_InsMuns (TextBox inscricao municipal)
            IF PEMSTATUS(loc_oPg1, "Get_InsMuns", 5)
                WITH loc_oPg1.Get_InsMuns
                    .Height = 23
                    .Left   = 431
                    .Top    = 101
                    .Width  = 141
                ENDWITH
            ENDIF

            *-- Get_Situa (TextBox situacao do cliente)
            IF PEMSTATUS(loc_oPg1, "Get_Situa", 5)
                WITH loc_oPg1.Get_Situa
                    .Left = 673
                    .Top  = 74
                ENDWITH
            ENDIF

            *-- getTelem (TextBox telefone celular)
            IF PEMSTATUS(loc_oPg1, "getTelem", 5)
                WITH loc_oPg1.getTelem
                    .Left = 673
                    .Top  = 97
                ENDWITH
            ENDIF

            *-- getClacod (TextBox classe do codigo)
            IF PEMSTATUS(loc_oPg1, "getClacod", 5)
                WITH loc_oPg1.getClacod
                    .Left = 673
                    .Top  = 120
                ENDWITH
            ENDIF

            *-- getConjuges (TextBox conjuge)
            IF PEMSTATUS(loc_oPg1, "getConjuges", 5)
                WITH loc_oPg1.getConjuges
                    .Left = 70
                    .Top  = 147
                ENDWITH
            ENDIF

            *-- getDtncons (TextBox aniversario conjuge)
            IF PEMSTATUS(loc_oPg1, "getDtncons", 5)
                WITH loc_oPg1.getDtncons
                    .Left = 396
                    .Top  = 147
                ENDWITH
            ENDIF

            *-- getDtcasas (TextBox data casamento)
            IF PEMSTATUS(loc_oPg1, "getDtcasas", 5)
                WITH loc_oPg1.getDtcasas
                    .Left = 396
                    .Top  = 170
                ENDWITH
            ENDIF

            IF PEMSTATUS(loc_oPg1, "getCpf2", 5)
                WITH loc_oPg1.getCpf2
                    .Left = 70
                    .Top  = 170
                ENDWITH
            ENDIF

            IF PEMSTATUS(loc_oPg1, "getRG2", 5)
                WITH loc_oPg1.getRG2
                    .Left = 211
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- cmbEstcivils (ComboBox estado civil)
            IF PEMSTATUS(loc_oPg1, "cmbEstcivils", 5)
                WITH loc_oPg1.cmbEstcivils
                    .Left = 572
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- chkInativa (CheckBox cliente inativado)
            IF PEMSTATUS(loc_oPg1, "chkInativa", 5)
                WITH loc_oPg1.chkInativa
                    .FontName  = "Tahoma"
                    .Alignment = 0
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- OpcaoCPFCGC (OptionGroup tipo documento - posicao)
            IF PEMSTATUS(loc_oPg1, "OpcaoCPFCGC", 5)
                WITH loc_oPg1.OpcaoCPFCGC
                    .Left = 14
                    .Top  = 33
                ENDWITH
            ENDIF

            *-- GetCEP (TextBox CEP)
            IF PEMSTATUS(loc_oPg1, "GetCEP", 5)
                WITH loc_oPg1.GetCEP
                    .Left = 102
                    .Top  = 200
                ENDWITH
            ENDIF

            *-- GetPais (TextBox pais)
            IF PEMSTATUS(loc_oPg1, "GetPais", 5)
                WITH loc_oPg1.GetPais
                    .Left = 230
                    .Top  = 200
                ENDWITH
            ENDIF

            *-- GetEndere?o (TextBox endereco - nome com cedilha CHR(231))
            loc_cNomeEndCtrl = "GetEndere" + CHR(231) + "o"
            IF PEMSTATUS(loc_oPg1, loc_cNomeEndCtrl, 5)
                loc_oEndCtrl = EVALUATE("loc_oPg1." + loc_cNomeEndCtrl)
                WITH loc_oEndCtrl
                    .Left = 102
                    .Top  = 223
                ENDWITH
                loc_oEndCtrl = .NULL.
            ENDIF

            *-- Get_num (TextBox numero do endereco)
            IF PEMSTATUS(loc_oPg1, "Get_num", 5)
                WITH loc_oPg1.Get_num
                    .Left = 561
                    .Top  = 223
                ENDWITH
            ENDIF

            *-- Get_comp (TextBox complemento)
            IF PEMSTATUS(loc_oPg1, "Get_comp", 5)
                WITH loc_oPg1.Get_comp
                    .Left = 102
                    .Top  = 246
                ENDWITH
            ENDIF

            *-- GetBairro (TextBox bairro)
            IF PEMSTATUS(loc_oPg1, "GetBairro", 5)
                WITH loc_oPg1.GetBairro
                    .Left = 334
                    .Top  = 246
                ENDWITH
            ENDIF

            *-- GetCidade (TextBox cidade)
            IF PEMSTATUS(loc_oPg1, "GetCidade", 5)
                WITH loc_oPg1.GetCidade
                    .Height = 23
                    .Left   = 102
                    .Top    = 269
                    .Width  = 230
                ENDWITH
            ENDIF

            *-- getCidasIBGE (TextBox codigo IBGE da cidade)
            IF PEMSTATUS(loc_oPg1, "getCidasIBGE", 5)
                WITH loc_oPg1.getCidasIBGE
                    .Left = 334
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- GetEstado (TextBox UF/Estado)
            IF PEMSTATUS(loc_oPg1, "GetEstado", 5)
                WITH loc_oPg1.GetEstado
                    .Left = 483
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- getUFIBGE (TextBox codigo IBGE da UF)
            IF PEMSTATUS(loc_oPg1, "getUFIBGE", 5)
                WITH loc_oPg1.getUFIBGE
                    .Left = 508
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- Get_Regiao (TextBox regiao)
            IF PEMSTATUS(loc_oPg1, "Get_Regiao", 5)
                WITH loc_oPg1.Get_Regiao
                    .Left = 596
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- getDdds (TextBox DDD)
            IF PEMSTATUS(loc_oPg1, "getDdds", 5)
                WITH loc_oPg1.getDdds
                    .Left = 102
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetTel1 (TextBox telefone 1)
            IF PEMSTATUS(loc_oPg1, "GetTel1", 5)
                WITH loc_oPg1.GetTel1
                    .Left = 179
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetTel2 (TextBox telefone 2)
            IF PEMSTATUS(loc_oPg1, "GetTel2", 5)
                WITH loc_oPg1.GetTel2
                    .Left = 385
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetFax (TextBox fax)
            IF PEMSTATUS(loc_oPg1, "GetFax", 5)
                WITH loc_oPg1.GetFax
                    .Left = 596
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- Say13 (label secao dados comerciais/endereco)
            IF PEMSTATUS(loc_oPg1, "Say13", 5)
                WITH loc_oPg1.Say13
                    .Left = 61
                    .Top  = 295
                ENDWITH
            ENDIF

            *-- GetEmail (TextBox e-mail)
            IF PEMSTATUS(loc_oPg1, "GetEmail", 5)
                WITH loc_oPg1.GetEmail
                    .Left = 102
                    .Top  = 315
                ENDWITH
            ENDIF

            *-- Say19 (label e-mail)
            IF PEMSTATUS(loc_oPg1, "Say19", 5)
                WITH loc_oPg1.Say19
                    .Left = 55
                    .Top  = 318
                ENDWITH
            ENDIF

            *-- GetCodFun (TextBox codigo funcao)
            IF PEMSTATUS(loc_oPg1, "GetCodFun", 5)
                WITH loc_oPg1.GetCodFun
                    .Left = 97
                    .Top  = 349
                ENDWITH
            ENDIF

            *-- GetDesFun (TextBox descricao funcao)
            IF PEMSTATUS(loc_oPg1, "GetDesFun", 5)
                WITH loc_oPg1.GetDesFun
                    .Left = 130
                    .Top  = 349
                ENDWITH
            ENDIF

            *-- Say17 (label funcao/cargo do cliente)
            IF PEMSTATUS(loc_oPg1, "Say17", 5)
                WITH loc_oPg1.Say17
                    .Left = 13
                    .Top  = 352
                ENDWITH
            ENDIF

            *-- cmdEnderecos (CommandGroup multiplos enderecos)
            IF PEMSTATUS(loc_oPg1, "cmdEnderecos", 5)
                WITH loc_oPg1.cmdEnderecos
                    .Left = 444
                    .Top  = 360
                ENDWITH
            ENDIF

            *-- lblObs (label area de observacoes)
            IF PEMSTATUS(loc_oPg1, "lblObs", 5)
                WITH loc_oPg1.lblObs
                    .Left = 62
                    .Top  = 371
                ENDWITH
            ENDIF

            *-- chkObservas (CheckBox filtrar por observacao)
            IF PEMSTATUS(loc_oPg1, "chkObservas", 5)
                WITH loc_oPg1.chkObservas
                    .Top       = 387
                    .Left      = 59
                    .Alignment = 0
                ENDWITH
            ENDIF

            *-- MemoFun (EditBox observacoes/memo)
            IF PEMSTATUS(loc_oPg1, "MemoFun", 5)
                WITH loc_oPg1.MemoFun
                    .Left = 97
                    .Top  = 373
                ENDWITH
            ENDIF

            *-- GetRaz?o (TextBox razao social - nome com til CHR(227))
            loc_cNomeRazCtrl = "GetRaz" + CHR(227) + "o"
            IF PEMSTATUS(loc_oPg1, loc_cNomeRazCtrl, 5)
                loc_oRazCtrl = EVALUATE("loc_oPg1." + loc_cNomeRazCtrl)
                WITH loc_oRazCtrl
                    .Left = 70
                    .Top  = 78
                ENDWITH
                loc_oRazCtrl = .NULL.
            ENDIF

            *-- Say9 (label)
            IF PEMSTATUS(loc_oPg1, "Say9", 5)
                WITH loc_oPg1.Say9
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say14 (label)
            IF PEMSTATUS(loc_oPg1, "Say14", 5)
                WITH loc_oPg1.Say14
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say24 (label)
            IF PEMSTATUS(loc_oPg1, "Say24", 5)
                WITH loc_oPg1.Say24
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *============================================================
    * checaibge - Validacao de codigo IBGE de municipio/UF.
    * Metodo PUBLIC chamado internamente pelo clsconta via
    * ThisForm.checaibge(pMun, pUFs, obCidade, obUF).
    *============================================================
    PROCEDURE checaibge
        LPARAMETERS par_cMun, par_cUFs, par_oObC, par_oObU
        LOCAL loc_nRtC, loc_nRtU, loc_cQuery, loc_oErro

        loc_nRtC = 9999999
        loc_nRtU = 99

        TRY
            *-- Buscar codigo IBGE do municipio
            loc_cQuery = "SELECT a.Codigos " + ;
                        "FROM SigCdMun a, SigCdUfs b " + ;
                        "WHERE RTRIM(a.Descs) = '" + ;
                            PADR(UPPER(ALLTRIM(par_cMun)), 40) + "'" + ;
                        " AND a.UFIBGEs = b.UFIBGEs" + ;
                        " AND b.Estados = '" + PADR(par_cUFs, 2) + "'"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalMunic") > 0
                IF USED("cursor_4c_LocalMunic")
                    SELECT cursor_4c_LocalMunic
                    GO TOP IN cursor_4c_LocalMunic
                    IF !EOF("cursor_4c_LocalMunic")
                        loc_nRtC = INT(VAL(ALLTRIM(TRANSFORM(cursor_4c_LocalMunic.Codigos))))
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_LocalMunic")
                USE IN cursor_4c_LocalMunic
            ENDIF

            par_oObC.Value    = loc_nRtC
            par_oObC.Refresh()
            par_oObC.ForeColor = IIF(loc_nRtC = 9999999, RGB(255,0,0), RGB(0,0,0))

            *-- Buscar codigo IBGE da UF
            loc_cQuery = "SELECT UFIBGEs FROM SigCdUfs " + ;
                        "WHERE Estados = '" + PADR(par_cUFs, 2) + "'"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalUF") > 0
                IF USED("cursor_4c_LocalUF")
                    SELECT cursor_4c_LocalUF
                    GO TOP IN cursor_4c_LocalUF
                    IF !EOF("cursor_4c_LocalUF")
                        loc_nRtU = cursor_4c_LocalUF.UFIBGEs
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_LocalUF")
                USE IN cursor_4c_LocalUF
            ENDIF

            par_oObU.Value    = loc_nRtU
            par_oObU.Refresh()
            par_oObU.ForeColor = IIF(loc_nRtU = 99, RGB(255,0,0), RGB(0,0,0))

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em checaibge")
        ENDTRY
    ENDPROC

    *============================================================
    * ConfigurarPaginaDados2 - Aplica overrides visuais do SCX
    * legado nos controles internos de cnt_4c_Conta.pgframeDados2
    * (aba de Dados Pessoais/Comerciais do cliente).
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados2
        LOCAL loc_oPgf, loc_oPg2, loc_oErro

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        IF !PEMSTATUS(loc_oPgf, "pgframeDados2", 5)
            RETURN
        ENDIF
        loc_oPg2 = loc_oPgf.pgframeDados2

        TRY
            IF PEMSTATUS(loc_oPg2, "FontName", 5)
                loc_oPg2.FontName = "Tahoma"
            ENDIF
            IF PEMSTATUS(loc_oPg2, "ForeColor", 5)
                loc_oPg2.ForeColor = RGB(90,90,90)
            ENDIF

            *-- Say4 (label)
            IF PEMSTATUS(loc_oPg2, "Say4", 5)
                WITH loc_oPg2.Say4
                    .FontName  = "Tahoma"
                    .Left      = 72
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say5 (label)
            IF PEMSTATUS(loc_oPg2, "Say5", 5)
                WITH loc_oPg2.Say5
                    .FontName  = "Tahoma"
                    .Left      = 76
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtcasas (label data casamento - pg2)
            IF PEMSTATUS(loc_oPg2, "sayDtcasas", 5)
                WITH loc_oPg2.sayDtcasas
                    .FontName  = "Tahoma"
                    .Left      = 296
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say6 (label)
            IF PEMSTATUS(loc_oPg2, "Say6", 5)
                WITH loc_oPg2.Say6
                    .FontName  = "Tahoma"
                    .Left      = 316
                    .Top       = 231
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say7 (label)
            IF PEMSTATUS(loc_oPg2, "Say7", 5)
                WITH loc_oPg2.Say7
                    .FontName  = "Tahoma"
                    .Left      = 52
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say8 (label)
            IF PEMSTATUS(loc_oPg2, "Say8", 5)
                WITH loc_oPg2.Say8
                    .FontName  = "Tahoma"
                    .Left      = 98
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say9 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say9", 5)
                WITH loc_oPg2.Say9
                    .FontName  = "Tahoma"
                    .Left      = 84
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say10 (label)
            IF PEMSTATUS(loc_oPg2, "Say10", 5)
                WITH loc_oPg2.Say10
                    .FontName  = "Tahoma"
                    .Left      = 537
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say11 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say11", 5)
                WITH loc_oPg2.Say11
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say12 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say12", 5)
                WITH loc_oPg2.Say12
                    .FontName  = "Tahoma"
                    .Left      = 92
                    .Top       = 279
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say14 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say14", 5)
                WITH loc_oPg2.Say14
                    .FontName  = "Tahoma"
                    .Left      = 47
                    .Top       = 302
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say15 (label)
            IF PEMSTATUS(loc_oPg2, "Say15", 5)
                WITH loc_oPg2.Say15
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say16 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say16", 5)
                WITH loc_oPg2.Say16
                    .FontName  = "Tahoma"
                    .Left      = 25
                    .Top       = 333
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say17 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say17", 5)
                WITH loc_oPg2.Say17
                    .FontName  = "Tahoma"
                    .Left      = 504
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say18 (label)
            IF PEMSTATUS(loc_oPg2, "Say18", 5)
                WITH loc_oPg2.Say18
                    .FontName  = "Tahoma"
                    .Left      = 294
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say19 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say19", 5)
                WITH loc_oPg2.Say19
                    .FontName  = "Tahoma"
                    .Left      = 536
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say20 (label)
            IF PEMSTATUS(loc_oPg2, "Say20", 5)
                WITH loc_oPg2.Say20
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say21 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say21", 5)
                WITH loc_oPg2.Say21
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say22 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say22", 5)
                WITH loc_oPg2.Say22
                    .FontName  = "Tahoma"
                    .Left      = 85
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say23 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say23", 5)
                WITH loc_oPg2.Say23
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say24 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say24", 5)
                WITH loc_oPg2.Say24
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say25 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say25", 5)
                WITH loc_oPg2.Say25
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say3 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say3", 5)
                WITH loc_oPg2.Say3
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayTel1 (label telefone comercial)
            IF PEMSTATUS(loc_oPg2, "SayTel1", 5)
                WITH loc_oPg2.SayTel1
                    .FontName  = "Tahoma"
                    .Left      = 91
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- say_Limite (label limite de credito)
            IF PEMSTATUS(loc_oPg2, "say_Limite", 5)
                WITH loc_oPg2.say_Limite
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- getGrauParens (TextBox grau de parentesco)
            IF PEMSTATUS(loc_oPg2, "getGrauParens", 5)
                WITH loc_oPg2.getGrauParens
                    .Left = 376
                    .Top  = 299
                ENDWITH
            ENDIF

            *-- Cnt_Limite.Say1 (label dentro do container de limite)
            IF PEMSTATUS(loc_oPg2, "Cnt_Limite", 5)
                IF PEMSTATUS(loc_oPg2.Cnt_Limite, "Say1", 5)
                    WITH loc_oPg2.Cnt_Limite.Say1
                        .FontName  = "Tahoma"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaDados2")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnIncluirClick - Limpar clsconta para inclusao de novo cliente
    *============================================================
    PROCEDURE BtnIncluirClick
        LOCAL loc_lRet, loc_oErro
        TRY
            THIS.pcEscolha       = "INSERIR"
            THIS.this_cModoAtual = "INCLUIR"
            THIS.plaltcd         = .F.
            THIS.this_cCli       = SPACE(10)
            THIS.RetCodCliente   = " "
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, SPACE(10), "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                    IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                        THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inicializar formul" + CHR(225) + "rio para inclus" + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnAlterarClick - Recarregar cliente em modo de alteracao
    *============================================================
    PROCEDURE BtnAlterarClick
        LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
        TRY
            *-- Obter codigo do cliente atual do controle interno do clsconta
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para altera" + CHR(231) + CHR(227) + "o.")
                RETURN
            ENDIF

            THIS.pcEscolha       = "ALTERAR"
            THIS.this_cModoAtual = "ALTERAR"
            THIS.plaltcd         = .T.
            THIS.this_cCli       = PADR(loc_cCodigoCli, 10)

            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                    IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                        THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar dados para altera" + CHR(231) + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnVisualizarClick - Modo somente leitura (desabilita gravacao)
    *============================================================
    PROCEDURE BtnVisualizarClick
        LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
        TRY
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para visualiza" + CHR(231) + CHR(227) + "o.")
                RETURN
            ENDIF

            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.pcEscolha       = "VISUALIZAR"

            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, PADR(loc_cCodigoCli, 10), "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                ENDIF
            ENDIF

            *-- Desabilitar botao OK em modo de visualizacao (impede gravacao acidental)
            IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                THIS.cmg_4c_Sair.Buttons(1).Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnExcluirClick - Confirmar e excluir cliente atual
    *============================================================
    PROCEDURE BtnExcluirClick
        LOCAL loc_cCodigoCli, loc_lConfirma, loc_lSucesso, loc_cSQL, loc_oErro
        TRY
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para exclus" + CHR(227) + "o.")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do cliente " + ;
                loc_cCodigoCli + "?" + CHR(13) + ;
                "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
                "Exclus" + CHR(227) + "o de Cliente")

            IF !loc_lConfirma
                RETURN
            ENDIF

            *-- Executar exclusao via BO
            THIS.this_oBusinessObject.this_cIclis = loc_cCodigoCli
            loc_lSucesso = THIS.this_oBusinessObject.Excluir()

            IF loc_lSucesso
                THIS.RetCodCliente = " "
                THIS.Release()
            ELSE
                MsgErro("Erro ao excluir o cliente." + CHR(13) + ;
                    THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro na Exclus" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *============================================================
    * CarregarLista - Recarregar dados do cliente atual via clsconta.mLeDados
    * (este form nao possui grade de listagem - "lista" = estado atual do cliente)
    *============================================================
    PROCEDURE CarregarLista
        LOCAL loc_lRet, loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                ELSE
                    MsgErro("Erro ao recarregar dados do cliente.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *============================================================
    * AjustarBotoesPorModo - Habilitar/desabilitar botoes conforme modo
    *============================================================
    PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lHabilitaOk
        loc_lHabilitaOk = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
        IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
            THIS.cmg_4c_Sair.Buttons(1).Enabled = loc_lHabilitaOk
        ENDIF
    ENDPROC

    *============================================================
    * HabilitarCampos - Habilitar ou desabilitar campos conforme modo
    * O clsconta gerencia seus campos internamente; aqui so se controla
    * o botao de confirmacao.
    *============================================================
    PROCEDURE HabilitarCampos
        LPARAMETERS par_lHabilitar
        IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
            THIS.cmg_4c_Sair.Buttons(1).Enabled = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
        ENDIF
    ENDPROC

    *============================================================
    * LimparCampos - Limpar e reinicializar para novo cliente
    *============================================================
    PROCEDURE LimparCampos
        THIS.this_cCli       = SPACE(10)
        THIS.RetCodCliente   = " "
        THIS.pcEscolha       = "INSERIR"
        THIS.this_cModoAtual = "INCLUIR"
        THIS.plaltcd         = .F.
        THIS.CarregarLista()
    ENDPROC

    *============================================================
    * FormParaBO - Transferencia form -> BO
    * O clsconta (mGravaDados) gerencia transferencia internamente.
    *============================================================
    PROCEDURE FormParaBO
        RETURN .T.
    ENDPROC

    *============================================================
    * BOParaForm - Transferencia BO -> form
    * O clsconta (mLeDados) gerencia transferencia internamente.
    *============================================================
    PROCEDURE BOParaForm
        RETURN .T.
    ENDPROC

    *============================================================
    * BtnSalvarClick - Alias de BtnOkClick (validar e gravar)
    *============================================================
    PROCEDURE BtnSalvarClick
        THIS.BtnOkClick()
    ENDPROC

    *============================================================
    * BtnEncerrarClick - Fechar sem gravar (alias de BtnCancelarClick)
    *============================================================
    PROCEDURE BtnEncerrarClick
        THIS.BtnCancelarClick()
    ENDPROC

    *============================================================
    * BtnBuscarClick - Abrir busca de cliente para carregar em edicao
    *============================================================
    PROCEDURE BtnBuscarClick
        LOCAL loc_oBusca, loc_cCodigoCli, loc_lSelecionou, loc_oErro
        TRY
            loc_cCodigoCli = ""
            loc_lSelecionou = .F.

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "IClis", "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Cliente", .T., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "",           "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    SELECT cursor_4c_BuscaCli
                    GO TOP IN cursor_4c_BuscaCli
                    IF !EOF("cursor_4c_BuscaCli")
                        loc_cCodigoCli = ALLTRIM(cursor_4c_BuscaCli.IClis)
                    ENDIF
                    USE IN cursor_4c_BuscaCli
                    loc_lSelecionou = !EMPTY(loc_cCodigoCli)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF loc_lSelecionou
                THIS.this_cCli       = PADR(loc_cCodigoCli, 10)
                THIS.pcEscolha       = "ALTERAR"
                THIS.this_cModoAtual = "ALTERAR"
                THIS.plaltcd         = .T.
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnBuscarClick")
        ENDTRY
    ENDPROC

    *============================================================
    PROCEDURE Destroy
    *============================================================
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

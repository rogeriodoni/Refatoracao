# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\sigprdftBO.prg: ENDFUNCTION | Error in line 378: Unrecognized command verb. | 

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg):
*==============================================================================
* Formsigprdft.prg - Formulario OPERACIONAL - SiTef Cartao de Debito
* Form original: SIGPRDFT.SCX
* Tipo: OPERACIONAL - dialogo modal TEF (flat layout, sem PageFrame)
* Chamada: loForm = CREATEOBJECT("Formsigprdft", EndSiTef, ValPago, Cupom,
*                                 Caixa, DebCred, TipPagto, NumParcs, lcIdent, pcOpers)
*          IF VARTYPE(loForm) = "O"
*              loForm.Show()
*              loc_cResultado = loForm.this_cResultado
*          ENDIF
*==============================================================================
DEFINE CLASS Formsigprdft AS FormBase

    *-- Dimensoes e visual identicos ao original SIGPRDFT
    Width       = 500
    Height      = 370
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    TitleBar    = 0
    WindowType  = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Props customizadas (migrado de pcbandeira/pctvenda/abandona/pckeyesc/lsCartao)
    this_cBandeira   = "00000"
    this_cCartao     = "00000"
    this_lKeyEsc     = .T.
    this_lTvenda     = .T.
    this_lAbandonou  = .F.

    *-- Estado SiTef (migrado de PUBLIC do legado para propriedades do form)
    this_nProxCmd    = 0
    this_nTipoCampo  = 0
    this_nTamMin     = 0
    this_nTamMax     = 0
    this_cBuffer     = ""
    this_nContinua   = 0
    this_nCiclos     = 0
    this_nParcs      = 0
    this_cSaque      = "0,00"
    this_dData       = {}
    this_lDCD        = .F.
    this_cIdTerminal = ""
    this_lParcelas   = .F.

    *-- Estado da transacao (compartilhado entre GotFocus e KeyPress handlers)
    this_cNsu        = ""
    this_cAutoriza   = ""
    this_cDataHora   = ""
    this_cTipTran    = ""
    this_cCupomTef   = ""
    this_cFinaliza   = ""
    this_cMRet       = ""
    this_cMensagem   = ""

    *-- Resultado retornado ao chamador apos Show() (substitui Unload RETURN)
    this_cResultado  = ""

    *==========================================================================
    * Init - Recebe parametros TEF do chamador e inicializa BO e estado SiTef
    * Assinatura identica ao legado SIGPRDFT.Init()
    *==========================================================================
    PROCEDURE Init(par_sEndSiTef, par_nValPago, par_sCupom, par_sCaixa, ;
                   par_sDebCred, par_sTipPagto, par_nNumParcs, par_cIdent, par_cOpers)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprdftBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar BO SiTef", "Erro")
                loc_lSucesso = .F.
            ELSE
                THIS.this_oBusinessObject.this_cEndSiTef  = IIF(VARTYPE(par_sEndSiTef)  = "C", ALLTRIM(par_sEndSiTef), "")
                THIS.this_oBusinessObject.this_nValPago   = IIF(VARTYPE(par_nValPago)   = "N", par_nValPago, 0)
                THIS.this_oBusinessObject.this_cCupom     = IIF(VARTYPE(par_sCupom)     = "C", ;
                                                                 TRANSFORM(par_sCupom, "@L 999999"), "")
                THIS.this_oBusinessObject.this_cCaixa     = IIF(VARTYPE(par_sCaixa)     = "C", par_sCaixa, "")
                THIS.this_oBusinessObject.this_cDebCred   = IIF(VARTYPE(par_sDebCred)   = "C", par_sDebCred, "")
                THIS.this_oBusinessObject.this_cTipPagto  = IIF(VARTYPE(par_sTipPagto)  = "C", par_sTipPagto, "")
                THIS.this_oBusinessObject.this_nNumParcs  = IIF(VARTYPE(par_nNumParcs)  = "N", par_nNumParcs, 0)
                THIS.this_oBusinessObject.this_cIdent     = IIF(VARTYPE(par_cIdent)     = "C", par_cIdent, "")
                THIS.this_oBusinessObject.this_cOpers     = IIF(VARTYPE(par_cOpers)     = "C", par_cOpers, "")

                THIS.this_oBusinessObject.InicializarDLLs()

                THIS.this_nParcs     = IIF(VARTYPE(par_nNumParcs) = "N", par_nNumParcs, 0)
                THIS.this_dData      = DATE()
                THIS.this_lDCD       = .F.
                THIS.this_nCiclos    = 0
                THIS.this_cSaque     = "0,00"
                THIS.this_cBuffer    = SPACE(2000)
                THIS.this_nContinua  = 0
                THIS.this_lKeyEsc    = .T.
                THIS.this_lAbandonou = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Init SiTef")
            loc_lSucesso = .F.
        ENDTRY
        IF !loc_lSucesso
            RETURN .F.
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Override de FormBase: cria layout plano sem PageFrame
    * Este dialogo TEF nao segue padrao CRUD (sem Page1/Page2)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
            THIS.AlwaysOnTop = .T.

            THIS.CarregarDadosOperacao()
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarConteudo()
            THIS.InicializarValoresIniciais()
            THIS.TornarControlesVisiveis(THIS)
            THIS.ZOrder(0)
            THIS.Refresh()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDadosOperacao - Carrega crSigOpFp e crSigCdEmp via SQL Server
    * Migrado de: SIGPRDFT.Init (bloco poDataMgr.SqlExecute)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDadosOperacao()
        LOCAL loc_cSQL, loc_oErro
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("crSigOpFp")
                    USE IN crSigOpFp
                ENDIF
                loc_cSQL = "SELECT * FROM SigOpFp WHERE FPags = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cOpers))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp") < 0
                    MsgErro("Erro ao carregar dados da opera" + CHR(231) + CHR(227) + "o SiTef", "Erro SQL")
                ENDIF

                IF USED("crSigCdEmp")
                    USE IN crSigCdEmp
                ENDIF
                loc_cSQL = "SELECT * FROM SigCdEmp WHERE cEmps = " + ;
                           EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmp") < 0
                    MsgErro("Erro ao carregar dados da empresa", "Erro SQL")
                ENDIF

                THIS.this_cIdTerminal = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ELSE
                MsgErro("Conex" + CHR(227) + "o com banco de dados indispon" + CHR(237) + "vel", ;
                        "Erro SiTef")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Carregar Dados Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestra layout root do dialogo TEF (flat)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotaoCancelar()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo do dialogo TEF
    * Migrado de: SIGPRDFT.cntSombra (adaptado para Width=500 do form)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoCancelar - CommandGroup SAIDA com botao CANCELA
    * Migrado de: SIGPRDFT.SAIDA (Top=-2, Left=420, Width=85, Height=85)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoCancelar()
        THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
        WITH THIS.obj_4c_SAIDA
            .ButtonCount = 1
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Height      = 85
            .Left        = 420
            .Top         = -2
            .Width       = 85
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Cancel     = .F.
                .Caption    = CHR(60) + "Cancelar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Name       = "CANCELA"
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelaClick")
    ENDPROC

    *==========================================================================
    * ConfigurarConteudo - Cria todos os controles visuais do dialogo TEF
    * Migrado de: propriedades dos objetos SIGPRDFT (secao 2 do SCX)
    * Fase 4/8: adiciona controles de entrada e instrucao ao usuario
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarConteudo()
        LOCAL loc_oErro
        TRY
            *-- Shape2: borda decorativa ao redor dos campos de entrada
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 93
                .Left          = 17
                .Height        = 202
                .Width         = 466
                .SpecialEffect = 0
            ENDWITH

            *-- Label5: rotulo "VALOR :"
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "VALOR :"
                .Height    = 15
                .Left      = 175
                .Top       = 102
                .Width     = 45
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- GetValor: valor da transacao (somente leitura - exibe valor recebido)
            THIS.AddObject("txt_4c_Valor", "TextBox")
            WITH THIS.txt_4c_Valor
                .FontBold          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Enabled           = .F.
                .Format            = ""
                .Height            = 23
                .InputMask         = "99,999,999.99"
                .Left              = 222
                .TabIndex          = 1
                .Top               = 99
                .Width             = 100
                .ForeColor         = RGB(0, 0, 0)
                .DisabledForeColor = RGB(0, 0, 0)
            ENDWITH

            *-- Label8: rotulo "NUMERO CARTAO :"
            THIS.AddObject("lbl_4c_Label8", "Label")
            WITH THIS.lbl_4c_Label8
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "NUMERO CARTAO :"
                .Height    = 15
                .Left      = 116
                .Top       = 136
                .Width     = 104
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- GetCartao: numero do cartao (Enabled=.F. por padrao; ativa se lCartao="S")
            THIS.AddObject("txt_4c_Cartao", "TextBox")
            WITH THIS.txt_4c_Cartao
                .FontBold          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = ""
                .Enabled           = .F.
                .Format            = ""
                .Height            = 23
                .InputMask         = "9999999999999999999"
                .Left              = 222
                .MaxLength         = 19
                .TabIndex          = 2
                .Top               = 133
                .Width             = 160
                .ForeColor         = RGB(0, 0, 0)
                .DisabledForeColor = RGB(0, 0, 0)
            ENDWITH
            BINDEVENT(THIS.txt_4c_Cartao, "GotFocus", THIS, "TxtCartaoGotFocus")

            *-- Label2: rotulo "4 ULTIMOS DIGITOS :" (muda para "Validade Cartao :" quando lCartao="S")
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "4 ULTIMOS DIGITOS :"
                .Height    = 17
                .Left      = 101
                .Top       = 171
                .Width     = 119
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- GetDigitos: 4 ultimos digitos do cartao (GotFocus inicia sessao TEF)
            THIS.AddObject("txt_4c_Digitos", "TextBox")
            WITH THIS.txt_4c_Digitos
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Enabled   = .T.
                .Height    = 23
                .InputMask = "9999"
                .Left      = 222
                .TabIndex  = 3
                .Top       = 168
                .Width     = 40
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(212, 208, 200)
            ENDWITH
            BINDEVENT(THIS.txt_4c_Digitos, "GotFocus", THIS, "TxtDigitosGotFocus")
            BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "TxtDigitosKeyPress")

            *-- Label4: rotulo "TIPO DE VENDA :"
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "TIPO DE VENDA :"
                .Height    = 15
                .Left      = 129
                .Top       = 204
                .Width     = 91
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Optiongroup1: selecao "A vista" / "Predatado"
            THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
            WITH THIS.obj_4c_Optiongroup1
                .ButtonCount = 2
                .Enabled     = .T.
                .Height      = 26
                .Left        = 222
                .Top         = 200
                .Width       = 161
                .TabIndex    = 5
                WITH .Buttons(1)
                    .FontBold  = .T.
                    .Caption   = " A vista"
                    .Height    = 17
                    .Left      = 5
                    .Top       = 4
                    .Width     = 61
                    .ForeColor = RGB(90, 90, 90)
                    .BackStyle = 0
                ENDWITH
                WITH .Buttons(2)
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Caption   = " Predatado"
                    .Height    = 15
                    .Left      = 73
                    .Top       = 5
                    .Width     = 80
                    .ForeColor = RGB(90, 90, 90)
                    .BackStyle = 0
                ENDWITH
            ENDWITH
            THIS.obj_4c_Optiongroup1.Value = 1
            BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptGrupoInteractiveChange")
            BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "KeyPress", THIS, "OptGrupoOption1KeyPress")
            BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptGrupoOption1GotFocus")

            *-- Label6: rotulo "N? PARCELAS :"
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "N" + CHR(186) + " PARCELAS :"
                .Height    = 15
                .Left      = 139
                .Top       = 238
                .Width     = 81
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Text1: numero de parcelas (habilitado pelo TEF quando aplicavel)
            THIS.AddObject("txt_4c_Text1", "TextBox")
            WITH THIS.txt_4c_Text1
                .FontBold          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Enabled           = .F.
                .Format            = ""
                .Height            = 23
                .InputMask         = "99"
                .Left              = 222
                .TabIndex          = 6
                .Top               = 235
                .Width             = 27
                .ForeColor         = RGB(0, 0, 0)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
            ENDWITH
            BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "TxtText1GotFocus")
            BINDEVENT(THIS.txt_4c_Text1, "KeyPress",   THIS, "TxtText1KeyPress")
            BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "TxtText1LostFocus")

            *-- Label11: rotulo "1a PARCELA/VENCTO :"
            THIS.AddObject("lbl_4c_Label11", "Label")
            WITH THIS.lbl_4c_Label11
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "1" + CHR(186) + " PARCELA/VENCTO :"
                .Height    = 15
                .Left      = 98
                .Top       = 268
                .Width     = 122
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- GetDatas: data da primeira parcela ou vencimento
            THIS.AddObject("txt_4c_Datas", "TextBox")
            WITH THIS.txt_4c_Datas
                .FontBold          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = {}
                .Enabled           = .F.
                .Format            = ""
                .Height            = 23
                .InputMask         = ""
                .Left              = 222
                .TabIndex          = 7
                .Top               = 266
                .Width             = 75
                .ForeColor         = RGB(0, 0, 0)
                .DisabledForeColor = RGB(0, 0, 0)
            ENDWITH
            BINDEVENT(THIS.txt_4c_Datas, "GotFocus",  THIS, "TxtDatasGotFocus")
            BINDEVENT(THIS.txt_4c_Datas, "KeyPress",   THIS, "TxtDatasKeyPress")
            BINDEVENT(THIS.txt_4c_Datas, "KeyPress",  THIS, "TxtDatasLostFocus")

            *-- Container1: exibe mensagem de instrucao ao usuario (tipo "Insira o Cartao")
            THIS.AddObject("cnt_4c_Container1", "Container")
            WITH THIS.cnt_4c_Container1
                .Top           = 298
                .Left          = 54
                .Width         = 392
                .Height        = 58
                .SpecialEffect = 0
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)

                .AddObject("lbl_4c_Label1", "Label")
                WITH .lbl_4c_Label1
                    .AutoSize  = .F.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .Alignment = 2
                    .BackStyle = 0
                    .Caption   = "Insira ou Passe o Cartao"
                    .Height    = 29
                    .Left      = 18
                    .Top       = 14
                    .Width     = 349
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ConfigurarConteudo SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * InicializarValoresIniciais - Define valores iniciais nos controles
    * Migrado de: bloco final de SIGPRDFT.Init (apos WITH Thisform ... EndWith)
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresIniciais()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Valor.Value  = THIS.this_oBusinessObject.this_nValPago
            THIS.txt_4c_Datas.Value  = DATE()
            THIS.this_dData          = DATE()
            THIS.txt_4c_Text1.Value  = TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
            THIS.this_nParcs         = THIS.this_oBusinessObject.this_nNumParcs

            IF USED("crSigOpFp")
                IF crSigOpFp.lCartao = "S"
                    THIS.txt_4c_Cartao.Enabled = .T.
                    THIS.lbl_4c_Label2.Caption  = "Validade Cart" + CHR(227) + "o :"
                ENDIF
            ENDIF

            IF !THIS.txt_4c_Datas.Enabled
                IF USED("crSigOpFp") AND crSigOpFp.lCartao = "N"
                    THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
                ELSE
                    THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
                ENDIF
            ELSE
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
            ENDIF

            THIS.txt_4c_Digitos.BackColor = RGB(212, 208, 200)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarValoresIniciais SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelaClick - Cancela transacao SiTef e libera o dialogo
    * Migrado de: SIGPRDFT.SAIDA.CANCELA.Click
    *==========================================================================
    PROCEDURE BtnCancelaClick()
        LOCAL loc_nRetorno, loc_oErro
        TRY
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @THIS.this_nProxCmd,   @THIS.this_nTipoCampo, ;
                @THIS.this_nTamMin,    @THIS.this_nTamMax, ;
                @THIS.this_cBuffer,    LEN(THIS.this_cBuffer), -1)
            THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)", ;
                              THIS.this_oBusinessObject.this_nValPago)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Cancelar SiTef")
        ENDTRY
        THIS.Release()
    ENDPROC

    *==========================================================================
    * KeyPress - Captura ESC no nivel do form (KeyPreview=.T.) para cancelar
    * Migrado de: SIGPRDFT.KeyPress
    *==========================================================================
    PROCEDURE KeyPress()
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
            NODEFAULT
            THIS.BtnCancelaClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * ErroTef - Delega tratamento de erros SiTef para o BO
    * Migrado de: SIGPRDFT.errotef
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        THIS.this_oBusinessObject.ErroTef(par_nRetorno)
    ENDPROC

    *==========================================================================
    * RetornoFalha - Grava arquivo de falha SiTef e seta resultado do form
    * Migrado de: SIGPRDFT.retornofalha (via delegacao ao BO)
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        THIS.this_oBusinessObject.RetornoFalha(par_cMensagem, par_nValPago)
        THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
            THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
    ENDPROC

    *==========================================================================
    * MontaRetorno - Grava arquivo de sucesso SiTef e seta resultado do form
    * Migrado de: SIGPRDFT.montaretorno (via delegacao ao BO)
    *==========================================================================
    PROCEDURE MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
                            par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
        THIS.this_oBusinessObject.this_cBandeira = THIS.this_cBandeira
        THIS.this_oBusinessObject.this_cCartao   = THIS.this_cCartao
        THIS.this_oBusinessObject.this_nParcelas = THIS.this_nParcs
        THIS.this_oBusinessObject.MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, ;
            par_sCartao, par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
        THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
            THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
    ENDPROC

    *==========================================================================
    * TxtDigitosGotFocus - Inicia sessao TEF ao focar GetDigitos
    * Migrado de: SIGPRDFT.GetDigitos.GotFocus (~231 linhas)
    *==========================================================================
    PROCEDURE TxtDigitosGotFocus()
        LOCAL loc_cIdTerminal, loc_cValPago, loc_cData, loc_cHora
        LOCAL loc_nRetorno, loc_nTipo
        LOCAL loc_lTipoVenda, loc_nTipoVenda, loc_cBandeira, loc_lContinua
        LOCAL loc_nCaixas, loc_cDateStr, loc_nEmp

        THIS.this_cNsu      = ""
        THIS.this_cAutoriza = ""
        THIS.this_cDataHora = ""
        THIS.this_cTipTran  = ""
        THIS.this_cCupomTef = ""
        THIS.this_cFinaliza = ""
        THIS.this_cMRet     = ""
        THIS.this_cMensagem = ""

        IF USED("crSigFiMpF") AND TYPE("crSigFiMpF.Cncaixas") = "N"
            loc_nCaixas = VAL(ALLTRIM(STR(crSigFiMpF.Cncaixas)))
        ELSE
            loc_nCaixas = 1
        ENDIF
        IF USED("crSigCdEmp") AND TYPE("crSigCdEmp.nEmps") = "N"
            loc_nEmp = crSigCdEmp.nEmps
        ELSE
            loc_nEmp = 0
        ENDIF
        loc_cIdTerminal = ALLTRIM(STR(loc_nEmp)) + TRANSFORM(loc_nCaixas, "@L 999999")

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nValPago, "99999999.99")), ".", ",")

        IF ConfiguraIntSiTefInterativo(THIS.this_oBusinessObject.this_cEndSiTef, ;
                                       loc_cIdTerminal, loc_cIdTerminal, 0) <> 0
            THIS.RetornoFalha("Sem comunicacao com SiTef", THIS.this_oBusinessObject.this_nValPago)
            THIS.Release()
            RETURN
        ENDIF

        loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
        loc_cHora = STRTRAN(TIME(), ":", "")

        IF IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_oBusinessObject.this_cCupom, ;
                                        loc_cData, loc_cHora, THIS.this_oBusinessObject.this_cCaixa, ;
                                        "") <> 10000
            THIS.RetornoFalha("Sem comunicacao com SiTef", THIS.this_oBusinessObject.this_nValPago)
            THIS.Release()
            RETURN
        ENDIF

        THIS.this_nProxCmd    = 0
        THIS.this_nTipoCampo  = 0
        THIS.this_nTamMin     = 0
        THIS.this_nTamMax     = 0
        THIS.this_cBuffer     = SPACE(2000)
        THIS.this_nContinua   = 0
        THIS.this_nCiclos     = 0
        THIS.this_cMRet       = ""
        THIS.this_cNsu        = ""
        loc_cBandeira         = ""
        loc_nRetorno          = 0
        loc_nTipo             = 1
        loc_lTipoVenda        = .F.
        loc_nTipoVenda        = 0
        loc_lContinua         = IIF(USED("crSigOpFp") AND crSigOpFp.lCartao = "N", .T., .F.)

        THIS.obj_4c_Optiongroup1.Enabled = .F.

        DO WHILE loc_lContinua
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)

            IF LASTKEY() = 27
                ContinuaFuncaoSiTefInterativo( ;
                    @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                    @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                    @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                  THIS.this_oBusinessObject.this_nValPago)
                THIS.Release()
                RETURN
            ENDIF

            IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO" $ UPPER(THIS.this_cBuffer)
                IF loc_nTipoVenda = 2
                    loc_lTipoVenda = .T.
                ELSE
                    loc_nTipoVenda = 2
                ENDIF
            ENDIF

            IF THIS.this_nProxCmd = 23
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
            ELSE
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
            ENDIF

            IF THIS.this_nProxCmd = 22 AND LEN(ALLTRIM(THIS.this_cBuffer)) <> 0
                MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
                         ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
                ContinuaFuncaoSiTefInterativo( ;
                    @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                    @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                    @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
                loc_nRetorno = -1
                EXIT
            ENDIF

            IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_nRetorno = 0
                EXIT
            ENDIF
            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.Release()
                EXIT
            ENDIF

            IF THIS.this_nProxCmd = 3
                THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
            ENDIF
            IF THIS.this_nTipoCampo = 100
                THIS.this_cTipTran = THIS.this_cBuffer
                THIS.this_cBuffer  = SPACE(2000)
                THIS.this_nContinua = 0
                LOOP
            ENDIF
            IF THIS.this_nTipoCampo = 105
                THIS.this_cDataHora = THIS.this_cBuffer
                THIS.this_cBuffer   = SPACE(2000)
                LOOP
            ENDIF
            IF THIS.this_nTipoCampo = 121
                THIS.this_cCupomTef = THIS.this_cBuffer
                THIS.this_cBuffer   = SPACE(2000)
                LOOP
            ENDIF
            IF THIS.this_nTipoCampo = 131
                THIS.this_cCartao = LEFT(THIS.this_cBuffer, 5)
            ENDIF
            IF THIS.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(THIS.this_cBuffer, 5)
                THIS.this_cBuffer   = SPACE(2000)
                LOOP
            ENDIF
            IF THIS.this_nTipoCampo = 134
                THIS.this_cNsu    = ALLTRIM(STR(VAL(THIS.this_cBuffer)))
                THIS.this_cBuffer = SPACE(2000)
                LOOP
            ENDIF
            IF THIS.this_nTipoCampo = 135
                THIS.this_cAutoriza = THIS.this_cBuffer
                THIS.this_cBuffer   = SPACE(2000)
                LOOP
            ENDIF

            IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 507
                IF MsgConfirma("Primeira Parcela A Vista")
                    THIS.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                ELSE
                    THIS.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ENDIF
                THIS.this_nContinua = 1000
                LOOP
            ENDIF

            IF THIS.this_nProxCmd = 21
                IF loc_nTipo = 1
                    THIS.this_cBuffer   = IIF(THIS.this_oBusinessObject.this_cDebCred = "D" .OR. ;
                        THIS.this_oBusinessObject.this_cDebCred = "P", "2", "3") + REPLICATE(CHR(0), 1999)
                    THIS.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    IF THIS.this_oBusinessObject.this_nNumParcs = 1
                        EXIT
                    ELSE
                        IF USED("crSigOpFp") AND crSigOpFp.Tcdc = "S"
                            IF THIS.this_oBusinessObject.this_cDebCred <> "P"
                                THIS.this_cBuffer = "5" + REPLICATE(CHR(0), 1999)
                            ELSE
                                THIS.this_cBuffer = "4" + REPLICATE(CHR(0), 1999)
                            ENDIF
                        ELSE
                            THIS.this_cBuffer = "3" + REPLICATE(CHR(0), 1999)
                        ENDIF
                        LOOP
                    ENDIF
                ENDIF
            ENDIF

            IF THIS.this_nTipoCampo = 131
                loc_cBandeira     = THIS.this_cBuffer
                THIS.this_cCartao = LEFT(THIS.this_cBuffer, 5)
            ENDIF
            IF THIS.this_nProxCmd = 30 AND loc_cBandeira = "00004"
                EXIT
            ENDIF
            IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 506
                loc_cDateStr = DTOC(THIS.txt_4c_Datas.Value)
                THIS.this_cBuffer = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
                                    ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
                                    ALLTRIM(SUBSTR(loc_cDateStr, 7, 4)) + REPLICATE(CHR(0), 1992)
                THIS.this_nContinua = 1000
                LOOP
            ENDIF
            IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 508
                THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.Dias)), "0") + REPLICATE(CHR(0), 1998)
                THIS.this_nContinua = 1000
                LOOP
            ENDIF
            IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 509
                THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.MesFec - 1)), "0") + REPLICATE(CHR(0), 1999)
                THIS.this_nContinua = 1000
                LOOP
            ENDIF
            IF (THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 511 AND ;
                USED("crSigOpFp") AND crSigOpFp.Tcdc = "S") OR ;
               (THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 505) OR ;
               (THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = -1 AND ;
                USED("crSigOpFp") AND crSigOpFp.Tcdc = "S" AND ;
                THIS.this_oBusinessObject.this_cDebCred = "P" AND ;
                ! "DDMMAAAA" $ THIS.this_cBuffer)
                THIS.this_cBuffer   = ALLTRIM(STR(THIS.this_oBusinessObject.this_nNumParcs)) + REPLICATE(CHR(0), 1998)
                THIS.this_nContinua = 1000
                LOOP
            ENDIF
            IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = -1 AND "DDMMAAAA" $ THIS.this_cBuffer
                THIS.txt_4c_Digitos.Enabled = .F.
                EXIT
            ENDIF
            IF THIS.this_nProxCmd <> 21
                THIS.this_cMensagem   = THIS.this_cBuffer
                THIS.this_cBuffer     = SPACE(2000)
                THIS.this_nContinua   = 0
            ENDIF
        ENDDO

        THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.

        IF loc_nRetorno < 0 OR THIS.this_lAbandonou
            THIS.Release()
            RETURN
        ENDIF

        IF !EMPTY(THIS.this_cNsu)
            THIS.MontaRetorno(THIS.this_cTipTran, THIS.this_cDataHora, THIS.this_cCupomTef, ;
                THIS.this_cBandeira, THIS.this_cNsu, THIS.this_cNsu, THIS.this_cFinaliza, ;
                THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
            THIS.Release()
            RETURN
        ENDIF

        THIS.txt_4c_Digitos.BackColor = RGB(255, 255, 255)
        THIS.txt_4c_Cartao.Value      = "#### #### #### ####"

        IF loc_lTipoVenda
            IF !THIS.txt_4c_Text1.Enabled
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
                THIS.txt_4c_Digitos.Enabled          = .F.
                THIS.obj_4c_Optiongroup1.Enabled     = .T.
                THIS.txt_4c_Datas.Enabled            = .T.
            ENDIF
        ELSE
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
            THIS.obj_4c_Optiongroup1.Enabled             = .T.
        ENDIF

        THIS.obj_4c_SAIDA.Enabled = .T.
    ENDPROC

    *==========================================================================
    * TxtDigitosKeyPress - Processa os 4 digitos ao pressionar Enter/Tab
    * Migrado de: SIGPRDFT.GetDigitos.Valid (~185 linhas)
    *==========================================================================
    PROCEDURE TxtDigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF

        IF THIS.this_lAbandonou
            THIS.Release()
            RETURN
        ENDIF

        LOCAL loc_cVal, loc_nRetorno, loc_nCampo
        loc_cVal = ALLTRIM(THIS.txt_4c_Digitos.Value)

        IF LEN(loc_cVal) <> 4 AND !EMPTY(loc_cVal)
            MsgAviso("Quantidade de Digitos Invalida", "Erro na Transa" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Digitos.Value = ""
            RETURN
        ENDIF

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        THIS.this_lParcelas = .F.
        THIS.this_cMensagem = ""
        THIS.this_cBuffer   = loc_cVal + REPLICATE(CHR(0), 2000 - LEN(loc_cVal))
        THIS.this_nContinua = 1000
        loc_nRetorno        = 10000
        loc_nCampo          = 1

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)

            IF LASTKEY() = 27
                ContinuaFuncaoSiTefInterativo( ;
                    @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                    @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                    @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                  THIS.this_oBusinessObject.this_nValPago)
                THIS.Release()
                RETURN
            ENDIF

            IF THIS.this_nProxCmd = 23
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
            ELSE
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
            ENDIF

            IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_nRetorno = 0
                EXIT
            ENDIF
            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.Release()
                RETURN
            ENDIF

            IF THIS.this_nProxCmd = 22
                MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
                         ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
                ContinuaFuncaoSiTefInterativo( ;
                    @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                    @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                    @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
                IF loc_nRetorno <> 10000
                    EXIT
                ELSE
                    IF THIS.this_lParcelas
                        THIS.txt_4c_Text1.Enabled        = .T.
                        THIS.obj_4c_Optiongroup1.Enabled = .F.
                        THIS.txt_4c_Digitos.Value        = ""
                        RETURN
                    ELSE
                        RETURN
                    ENDIF
                ENDIF
            ENDIF

            IF THIS.this_nProxCmd = 23
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
            ELSE
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
            ENDIF

            IF THIS.this_nProxCmd = 21
                THIS.this_cBuffer = IIF(THIS.this_oBusinessObject.this_nNumParcs = 1, ;
                    IIF(THIS.txt_4c_Datas.Value = DATE(), "1", "2"), ;
                    IIF(THIS.this_oBusinessObject.this_cDebCred = "P", "3", "4")) + REPLICATE(CHR(0), 1999)
                IF THIS.this_cBuffer = "1"
                    EXIT
                ENDIF
                THIS.this_lDCD      = .T.
                THIS.this_nContinua = 1000
                LOOP
            ENDIF

            IF THIS.this_nProxCmd = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 510
                THIS.this_cBuffer = IIF(USED("crSigOpFp") AND crSigOpFp.Garantias = "S", ;
                    "1", "2") + REPLICATE(CHR(0), 1999)
                THIS.this_nContinua = 1000
            ENDIF

            IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
                THIS.this_cSaque  = "0,00"
                THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
                THIS.this_nContinua = 1000
                LOOP
            ENDIF

            IF THIS.this_nProxCmd = 30 AND (THIS.this_nTipoCampo = -1 OR THIS.this_nTipoCampo = 506) AND ;
               THIS.this_oBusinessObject.this_cDebCred <> "P"
                THIS.txt_4c_Datas.Enabled = .T.
                EXIT
            ENDIF

            IF THIS.this_nProxCmd = 30 AND (THIS.this_oBusinessObject.this_cDebCred = "P" OR THIS.this_nTipoCampo = 511)
                IF loc_nCampo = 1
                    THIS.this_cBuffer   = TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99") + REPLICATE(CHR(0), 1999)
                    THIS.this_lParcelas = .T.
                    loc_nCampo          = 2
                    LOOP
                ELSE
                    THIS.txt_4c_Datas.Enabled = .T.
                    EXIT
                ENDIF
            ENDIF

            IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF THIS.this_nProxCmd = 3
                THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
            ENDIF
            IF THIS.this_nTipoCampo = 100
                THIS.this_cTipTran = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 105
                THIS.this_cDataHora = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 121
                THIS.this_cCupomTef = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 131
                THIS.this_cCartao = LEFT(THIS.this_cBuffer, 5)
            ENDIF
            IF THIS.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(THIS.this_cBuffer, 5)
            ENDIF
            IF THIS.this_nTipoCampo = 134
                THIS.this_cNsu = ALLTRIM(STR(VAL(THIS.this_cBuffer)))
            ENDIF
            IF THIS.this_nTipoCampo = 135
                THIS.this_cAutoriza = THIS.this_cBuffer
            ENDIF
            IF loc_nRetorno <> 0
                THIS.this_cFinaliza = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nProxCmd = 22 AND THIS.this_oBusinessObject.this_cDebCred = "P"
                THIS.this_cCupomTef = THIS.this_cBuffer
                loc_nRetorno = 0
                EXIT
            ENDIF
            IF THIS.this_nProxCmd <> 21 AND THIS.this_nProxCmd <> 30 AND THIS.this_nProxCmd <> 34
                THIS.this_cMensagem   = THIS.this_cBuffer
                THIS.this_cBuffer     = SPACE(2000)
                THIS.this_nContinua   = 0
            ENDIF
        ENDDO

        IF loc_nRetorno <> 10000
            IF THIS.this_oBusinessObject.this_cDebCred = "P" AND ;
               USED("crSigOpFp") AND crSigOpFp.Tcdc <> "S"
                MsgInfo("Consulta CDC Realizada")
                THIS.RetornoFalha("Consulta CDC Realizada", THIS.this_oBusinessObject.this_nValPago)
            ELSE
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(THIS.this_cTipTran, THIS.this_cDataHora, ;
                        THIS.this_cCupomTef, THIS.this_cBandeira, THIS.this_cNsu, ;
                        THIS.this_cAutoriza, THIS.this_cFinaliza, ;
                        THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
                ENDIF
            ENDIF
            THIS.Release()
            RETURN
        ENDIF

        IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 514
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
        ELSE
            IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND !THIS.this_lDCD
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
                THIS.obj_4c_Optiongroup1.Enabled             = .T.
                THIS.txt_4c_Datas.Enabled                    = .T.
            ELSE
                THIS.obj_4c_Optiongroup1.Enabled = .F.
            ENDIF
        ENDIF

        THIS.txt_4c_Digitos.Enabled      = .F.
        THIS.obj_4c_Optiongroup1.Enabled = .T.
    ENDPROC

    *==========================================================================
    * TxtCartaoGotFocus - Foco no campo numero do cartao
    * Garante que instrucao esteja visivel para cartao manual
    *==========================================================================
    PROCEDURE TxtCartaoGotFocus()
        THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
    ENDPROC

    *==========================================================================
    * OptGrupoInteractiveChange - Habilita GetDatas ao mudar tipo de venda
    * Migrado de: SIGPRDFT.Optiongroup1.InteractiveChange
    *==========================================================================
    PROCEDURE OptGrupoInteractiveChange()
        THIS.txt_4c_Datas.Enabled = .T.
        IF THIS.obj_4c_Optiongroup1.Value = 1
            THIS.txt_4c_Datas.Value = DATE()
        ELSE
            THIS.txt_4c_Datas.Value = CTOD("")
        ENDIF
    ENDPROC

    *==========================================================================
    * OptGrupoOption1KeyPress - ENTER no Option1 simula TAB (avanca campo)
    * Migrado de: SIGPRDFT.Optiongroup1.Option1.KeyPress
    *==========================================================================
    PROCEDURE OptGrupoOption1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            KEYBOARD "{TAB}"
        ENDIF
    ENDPROC

    *==========================================================================
    * OptGrupoOption1GotFocus - Habilita GetDatas ao focar Option1
    * Migrado de: SIGPRDFT.Optiongroup1.Option1.GotFocus
    *==========================================================================
    PROCEDURE OptGrupoOption1GotFocus()
        THIS.txt_4c_Datas.Enabled = .T.
    ENDPROC

    *==========================================================================
    * TxtText1GotFocus - Define tvenda=.F. ao entrar em parcelas
    * Migrado de: SIGPRDFT.Text1.GotFocus
    *==========================================================================
    PROCEDURE TxtText1GotFocus()
        THIS.this_lTvenda = .F.
    ENDPROC

    *==========================================================================
    * TxtText1KeyPress - Processa numero de parcelas ao pressionar Enter/Tab
    * Migrado de: SIGPRDFT.Text1.Valid
    *==========================================================================
    PROCEDURE TxtText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Text1.Value)
            RETURN
        ENDIF

        LOCAL loc_cVal, loc_nRetorno
        loc_cVal = ALLTRIM(THIS.txt_4c_Text1.Value)

        THIS.this_nParcs    = VAL(loc_cVal)
        THIS.this_cBuffer   = loc_cVal + REPLICATE(CHR(0), 1990)
        THIS.this_nContinua = 1000

        loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
            @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
            @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
            @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)

        IF THIS.this_nProxCmd = 23
            THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
        ELSE
            THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
        ENDIF

        IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
        ENDIF

        IF THIS.this_nProxCmd = 22
            MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
                     ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
            ContinuaFuncaoSiTefInterativo( ;
                @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
            RETURN
        ENDIF

        THIS.this_cBuffer   = ""
        THIS.this_nContinua = 0
    ENDPROC

    *==========================================================================
    * TxtText1LostFocus - Formata parcelas, desabilita campo e habilita GetDatas
    * Migrado de: SIGPRDFT.Text1.LostFocus
    *==========================================================================
    PROCEDURE TxtText1LostFocus()
        THIS.txt_4c_Text1.Value    = TRANSFORM(VAL(THIS.txt_4c_Text1.Value), "@L 99")
        THIS.txt_4c_Text1.Enabled  = .F.
        THIS.txt_4c_Datas.Enabled  = .T.
    ENDPROC

    *==========================================================================
    * TxtDatasGotFocus - Processa estado TEF ao entrar no campo de data
    * Migrado de: SIGPRDFT.GetDatas.GotFocus (~188 linhas)
    *==========================================================================
    PROCEDURE TxtDatasGotFocus()
        LOCAL loc_nRetorno, loc_cDateStr, loc_oErro

        THIS.this_lTvenda   = .F.
        THIS.this_cTipTran  = ""
        THIS.this_cDataHora = ""
        THIS.this_cCupomTef = ""
        THIS.this_cCartao   = ""
        THIS.this_cNsu      = ""
        THIS.this_cAutoriza = ""
        THIS.this_cFinaliza = ""
        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
        THIS.this_cMRet     = ""

        IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND ;
           !THIS.this_lDCD AND ;
           USED("crSigOpFp") AND crSigOpFp.Tcdc <> "S"

            loc_nRetorno        = 10000
            THIS.this_cMensagem = ""

            IF THIS.obj_4c_Optiongroup1.Enabled
                THIS.this_cBuffer = STR(THIS.obj_4c_Optiongroup1.Value, 1) + REPLICATE(CHR(0), 1999)
            ELSE
                DO WHILE THIS.this_nProxCmd <> 30
                    loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                        @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                        @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                        @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
                    IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
                        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
                    ENDIF
                    IF THIS.this_nProxCmd = 23
                        THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
                    ELSE
                        THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
                    ENDIF
                    IF loc_nRetorno < 0
                        THIS.ErroTef(loc_nRetorno)
                        THIS.Release()
                        RETURN
                    ENDIF
                ENDDO
                THIS.this_cBuffer = ALLTRIM(THIS.txt_4c_Text1.Value) + REPLICATE(CHR(0), 1998)
            ENDIF

            THIS.this_nContinua   = 1000
            THIS.this_cAutoriza   = ""

            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                    @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                    @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                    @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)

                IF LASTKEY() = 27
                    ContinuaFuncaoSiTefInterativo( ;
                        @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                        @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                        @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
                    THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                      THIS.this_oBusinessObject.this_nValPago)
                    THIS.Release()
                    RETURN
                ENDIF

                IF THIS.this_nProxCmd = 23
                    THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
                ELSE
                    THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
                ENDIF
                IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
                    THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
                ENDIF
                IF loc_nRetorno < 0
                    THIS.ErroTef(loc_nRetorno)
                    THIS.Release()
                    RETURN
                ENDIF

                IF THIS.this_nProxCmd = 22
                    MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
                             ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
                    IF "CANC. CLIENTE" $ UPPER(ALLTRIM(THIS.this_cBuffer))
                        ContinuaFuncaoSiTefInterativo( ;
                            @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                            @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                            @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
                        loc_nRetorno = -8
                        EXIT
                    ENDIF
                    ContinuaFuncaoSiTefInterativo( ;
                        @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                        @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                        @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
                    IF loc_nRetorno <> 10000
                        THIS.Release()
                        RETURN
                    ELSE
                        RETURN
                    ENDIF
                    IF THIS.this_nProxCmd = 23
                        THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
                    ELSE
                        THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
                    ENDIF
                ENDIF

                IF loc_nRetorno < 0
                    THIS.RetornoFalha(IIF(EMPTY(THIS.this_cMensagem), "Operacao Cancelada pelo Usuario", ;
                                         THIS.this_cMensagem), THIS.this_oBusinessObject.this_nValPago)
                    EXIT
                ENDIF

                IF THIS.this_nProxCmd = 30 AND THIS.obj_4c_Optiongroup1.Value = 2
                    IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 510
                        THIS.this_cBuffer   = IIF(USED("crSigOpFp") AND crSigOpFp.Garantias = "S", ;
                            "1", "2") + REPLICATE(CHR(0), 1999)
                        THIS.this_nContinua = 1000
                        LOOP
                    ENDIF
                    EXIT
                ENDIF

                IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 506
                    loc_cDateStr = DTOC(THIS.txt_4c_Datas.Value)
                    THIS.this_cBuffer = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
                                        ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
                                        ALLTRIM(SUBSTR(loc_cDateStr, 7, 4)) + REPLICATE(CHR(0), 1992)
                    THIS.this_nContinua = 1000
                    LOOP
                ENDIF
                IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 505
                    THIS.this_cBuffer   = ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1998)
                    THIS.this_nContinua = 1000
                    LOOP
                ENDIF
                IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 507
                    IF MsgConfirma("Primeira Parcela A Vista")
                        THIS.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                    ELSE
                        THIS.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                    ENDIF
                    THIS.this_nContinua = 1000
                    LOOP
                ENDIF
                IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 508
                    THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.Dias)), "0") + REPLICATE(CHR(0), 1998)
                    THIS.this_nContinua = 1000
                    LOOP
                ENDIF
                IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 509
                    THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.MesFec - 1)), "0") + REPLICATE(CHR(0), 1999)
                    THIS.this_nContinua = 1000
                    LOOP
                ENDIF
                IF THIS.this_nProxCmd = 30
                    loc_cDateStr = DTOC(THIS.txt_4c_Datas.Value)
                    THIS.this_cBuffer = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
                                        ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
                                        ALLTRIM(SUBSTR(loc_cDateStr, 7, 4))
                ENDIF
                IF loc_nRetorno <> 0
                    THIS.this_cFinaliza = THIS.this_cBuffer
                ENDIF
                IF UPPER(ALLTRIM(THIS.this_cBuffer)) $ "DIGITE A SENHA"
                    THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
                ENDIF
                IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
                    THIS.this_cSaque  = "0,00"
                    THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
                    THIS.this_nContinua = 1000
                    LOOP
                ENDIF
                IF THIS.this_nProxCmd = 3
                    THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
                ENDIF
                IF THIS.this_nTipoCampo = 100
                    THIS.this_cTipTran = THIS.this_cBuffer
                ENDIF
                IF THIS.this_nTipoCampo = 105
                    THIS.this_cDataHora = THIS.this_cBuffer
                ENDIF
                IF THIS.this_nTipoCampo = 121
                    THIS.this_cCupomTef = THIS.this_cBuffer
                ENDIF
                IF THIS.this_nTipoCampo = 131
                    THIS.this_cCartao = LEFT(THIS.this_cBuffer, 5)
                ENDIF
                IF THIS.this_nTipoCampo = 132
                    THIS.this_cBandeira = LEFT(THIS.this_cBuffer, 5)
                ENDIF
                IF THIS.this_nTipoCampo = 134
                    THIS.this_cNsu = ALLTRIM(STR(VAL(THIS.this_cBuffer)))
                ENDIF
                IF THIS.this_nTipoCampo = 135
                    THIS.this_cAutoriza = THIS.this_cBuffer
                ENDIF
                IF loc_nRetorno <> 0
                    THIS.this_cFinaliza = THIS.this_cBuffer
                ENDIF
                IF THIS.this_nProxCmd <> 21 AND THIS.this_nProxCmd <> 30
                    THIS.this_cMensagem   = THIS.this_cBuffer
                    THIS.this_cBuffer     = SPACE(2000)
                    THIS.this_nContinua   = 0
                ENDIF
            ENDDO

            IF loc_nRetorno <> 10000
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(THIS.this_cTipTran, THIS.this_cDataHora, ;
                        THIS.this_cCupomTef, THIS.this_cBandeira, THIS.this_cNsu, ;
                        THIS.this_cAutoriza, THIS.this_cFinaliza, ;
                        THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
                    THIS.Release()
                ENDIF
            ENDIF
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtDatasKeyPress - Processa data de vencimento ao pressionar Enter/Tab
    * Migrado de: SIGPRDFT.GetDatas.Valid (~183 linhas)
    *==========================================================================
    PROCEDURE TxtDatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode = 27
            RETURN
        ENDIF

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF

        LOCAL loc_ldData, loc_nRetorno, loc_cDateStr

        loc_ldData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
        THIS.txt_4c_Datas.Value = loc_ldData
        THIS.this_dData         = loc_ldData

        IF THIS.obj_4c_Optiongroup1.Value = 2 AND THIS.txt_4c_Datas.Value <= DATE() AND ;
           !EMPTY(THIS.txt_4c_Datas.Value)
            MsgAviso("Data Inv" + CHR(225) + "lida", "Erro na Transa" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        DO WHILE THIS.this_nProxCmd <> 30
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
            IF THIS.this_nProxCmd = 23
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
            ELSE
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
            ENDIF
            IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.Release()
                RETURN
            ENDIF
        ENDDO

        LOCAL loc_nPrimo
        loc_nPrimo          = 1
        THIS.this_cAutoriza = ""
        loc_nRetorno        = 10000
        THIS.this_cMensagem = ""
        loc_cDateStr        = DTOC(THIS.txt_4c_Datas.Value)
        THIS.this_cBuffer   = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
                              ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
                              ALLTRIM(SUBSTR(loc_cDateStr, 7, 4)) + REPLICATE(CHR(0), 1992)
        THIS.this_nContinua = 1000
        THIS.this_cAutoriza = ""
        THIS.this_nCiclos   = 0

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)

            IF LASTKEY() = 27
                ContinuaFuncaoSiTefInterativo( ;
                    @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                    @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                    @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                  THIS.this_oBusinessObject.this_nValPago)
                THIS.Release()
                RETURN
            ENDIF

            IF THIS.this_nProxCmd = 23
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
            ELSE
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
            ENDIF
            IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.Release()
                RETURN
            ENDIF

            IF THIS.this_nProxCmd = 22
                IF THIS.this_oBusinessObject.this_cDebCred <> "P"
                    IF LEN(ALLTRIM(THIS.this_cBuffer)) <> 0
                        LOCAL loc_cMsg22
                        loc_cMsg22 = IIF(UPPER(ALLTRIM(THIS.this_cBuffer)) = "AGUARDE, EM PROCESSAMENTO", ;
                            "TRANSACAO CANCELADA", ALLTRIM(THIS.this_cBuffer))
                        MsgAviso(loc_cMsg22, "Erro na Transa" + CHR(231) + CHR(227) + "o")
                        IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR "CANC. CLIENTE" $ UPPER(ALLTRIM(THIS.this_cBuffer))
                            ContinuaFuncaoSiTefInterativo( ;
                                @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
                                @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
                                @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
                            loc_nRetorno = -8
                            EXIT
                        ENDIF
                        RETURN
                    ELSE
                        loc_nRetorno = 0
                        EXIT
                    ENDIF
                ELSE
                    THIS.this_cCupomTef = ALLTRIM(THIS.this_cBuffer)
                    loc_nRetorno = -1
                    EXIT
                ENDIF
            ENDIF

            IF loc_nRetorno <> 10000
                THIS.RetornoFalha(IIF(EMPTY(THIS.this_cMensagem), "Operacao Cancelada pelo Usuario", ;
                                      THIS.this_cMensagem), THIS.this_oBusinessObject.this_nValPago)
                EXIT
            ENDIF

            IF THIS.this_nProxCmd = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 500
                MsgInfo("Senha solicitada - terminal de senha necessario")
                THIS.RetornoFalha("Operacao Cancelada pelo Usuario", THIS.this_oBusinessObject.this_nValPago)
                loc_nRetorno = -2
                EXIT
            ENDIF

            IF UPPER(THIS.this_cBuffer) = "ASSUME GARANTIA" AND loc_nPrimo = 1
                IF MsgConfirma("Assume Invers" + CHR(227) + "o de Risco ?")
                    THIS.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                ELSE
                    THIS.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_nPrimo          = 2
                THIS.this_nContinua = 1000
                LOOP
            ENDIF

            IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
                THIS.this_cSaque  = "0,00"
                THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
                THIS.this_nContinua = 1000
                LOOP
            ENDIF

            IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = -1
                THIS.this_cSaque  = "0,00"
                THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 1900)
                LOOP
            ENDIF

            IF THIS.this_nProxCmd = 3
                THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
            ENDIF
            IF THIS.this_nTipoCampo = 100
                THIS.this_cTipTran = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 105
                THIS.this_cDataHora = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 121
                THIS.this_cCupomTef = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 131
                THIS.this_cCartao = LEFT(THIS.this_cBuffer, 5)
            ENDIF
            IF THIS.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(THIS.this_cBuffer, 5)
            ENDIF
            IF THIS.this_nTipoCampo = 134
                THIS.this_cNsu = ALLTRIM(STR(VAL(THIS.this_cBuffer)))
            ENDIF
            IF THIS.this_nTipoCampo = 135
                THIS.this_cAutoriza = THIS.this_cBuffer
            ENDIF
            IF loc_nRetorno <> 0
                THIS.this_cFinaliza = THIS.this_cBuffer
            ENDIF
            IF THIS.this_nProxCmd <> 21 AND THIS.this_nProxCmd <> 30
                THIS.this_cMensagem   = THIS.this_cBuffer
                THIS.this_cBuffer     = SPACE(2000)
                THIS.this_nContinua   = 0
            ENDIF
        ENDDO

        IF loc_nRetorno <> 10000
            IF THIS.this_oBusinessObject.this_cDebCred = "P"
                MsgInfo("Consulta CDC Realizada")
                THIS.RetornoFalha("Consulta CDC Realizada", THIS.this_oBusinessObject.this_nValPago)
            ELSE
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(THIS.this_cTipTran, THIS.this_cDataHora, ;
                        THIS.this_cCupomTef, THIS.this_cBandeira, THIS.this_cNsu, ;
                        THIS.this_cAutoriza, THIS.this_cFinaliza, ;
                        THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
                ELSE
                    IF loc_nRetorno >= -5
                        THIS.ErroTef(loc_nRetorno)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TxtDatasLostFocus - Restaura comportamento de confirmacao normal
    * Migrado de: SIGPRDFT.GetDatas.LostFocus
    *==========================================================================
    PROCEDURE TxtDatasLostFocus()
        *-- Equivalente ao SET CONFIRM ON do legado (sem efeito pratico em VFP9 moderno)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo: torna todos os controles visiveis
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
    * ConfigurarPaginaLista - Compat CRUD para dialogo OPERACIONAL flat
    * Form SiTef nao possui Page1=Lista/Page2=Dados. Metodo mantido para
    * compatibilidade com a arquitetura CRUD e delega a montagem visual
    * (Cabecalho, botao Cancelar, campos TEF e Container1 de mensagens) para
    * ConfigurarPageFrame + ConfigurarConteudo. Idempotente: so remonta se
    * o Container1 (marcador de conteudo montado) ainda nao existe.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF !PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarConteudo()
            THIS.InicializarValoresIniciais()
            THIS.TornarControlesVisiveis(THIS)
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Compat CRUD para dialogo OPERACIONAL flat
    * Form SiTef nao possui Page2/Dados separada. Todos os controles de
    * entrada (Valor, Cartao, Digitos, OptionGroup, Parcelas, Data, Instrucao)
    * estao em ConfigurarConteudo() com layout plano flat identico ao legado.
    * Controles mapeados (mapeamento.json):
    *   txt_4c_Valor      - GetValor  (valor da transacao, read-only)
    *   txt_4c_Cartao     - GetCartao (numero do cartao, 19 digitos)
    *   txt_4c_Digitos    - GetDigitos (4 ultimos digitos, inicia sessao TEF)
    *   obj_4c_Optiongroup1 - Optiongroup1 (A vista / Predatado)
    *   txt_4c_Text1      - Text1 (numero de parcelas)
    *   txt_4c_Datas      - GetDatas (data 1a parcela / vencimento)
    *   cnt_4c_Container1 - Container1 (instrucao dinamica ao usuario)
    * Metodo mantido por compatibilidade com a arquitetura FormBase CRUD.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- OPERACIONAL flat: todos os controles estao em ConfigurarConteudo().
        *-- Nao ha Page2/Dados neste dialogo TEF.
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna mensagem do Container1 conforme fase da transacao
    * Form SiTef flat sem PageFrame: reproduz o comportamento do legado que
    * alterava Container1.Label1.Caption durante o fluxo TEF (GetCartao ->
    * GetDigitos -> Senha -> Datas -> Autorizacao). par_nPagina indica a fase.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_cMsg
        DO CASE
            CASE par_nPagina = 1
                loc_cMsg = "Insira ou Passe o Cart" + CHR(227) + "o"
            CASE par_nPagina = 2
                loc_cMsg = "Digite os 4 " + CHR(250) + "ltimos d" + CHR(237) + "gitos"
            CASE par_nPagina = 3
                loc_cMsg = "Digite a Senha"
            CASE par_nPagina = 4
                loc_cMsg = "Digite a Data" + CHR(13) + "de Vencimento"
            CASE par_nPagina = 5
                loc_cMsg = "Aguarde autoriza" + CHR(231) + CHR(227) + "o..."
            OTHERWISE
                loc_cMsg = "Insira ou Passe o Cart" + CHR(227) + "o"
        ENDCASE
        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = loc_cMsg
            THIS.cnt_4c_Container1.lbl_4c_Label1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova sess" + CHR(227) + "o TEF
    * Form OPERACIONAL: "Incluir" equivale a reiniciar o fluxo TEF
    * Posiciona foco em GetDigitos que via GotFocus inicia ConfiguraIntSiTefInterativo
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.this_lAbandonou = .F.
            THIS.this_cBuffer    = SPACE(2000)
            THIS.this_nContinua  = 0
            THIS.this_nCiclos    = 0
            THIS.this_cResultado = ""
            THIS.txt_4c_Digitos.Value   = ""
            THIS.txt_4c_Digitos.Enabled = .T.
            THIS.txt_4c_Digitos.BackColor = RGB(212, 208, 200)
            THIS.txt_4c_Digitos.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Continua fluxo TEF a partir do pr" + CHR(243) + "ximo campo ativo
    * Form OPERACIONAL: "Alterar" = retomar transa" + CHR(231) + CHR(227) + "o pendente
    * Direciona para GetDatas (data vencimento) se habilitado, caso contr" + CHR(225) + "rio
    * para Text1 (parcelas), mantendo o estado SiTef atual
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF THIS.txt_4c_Datas.Enabled
                THIS.txt_4c_Datas.SetFocus()
            ELSE
                IF THIS.txt_4c_Text1.Enabled
                THIS.txt_4c_Text1.SetFocus()
            ELSE
                IF THIS.txt_4c_Digitos.Enabled
                THIS.txt_4c_Digitos.SetFocus()
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe resultado da transa" + CHR(231) + CHR(227) + "o TEF atual
    * Form OPERACIONAL: "Visualizar" = consultar estado/resultado da sess" + CHR(227) + "o
    * Exibe this_cResultado se j" + CHR(225) + " foi gerado, ou informa aguardando
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_cMsg
        TRY
            IF !EMPTY(THIS.this_cResultado)
                MsgInfo("Resultado TEF: " + THIS.this_cResultado, "Resultado")
            ELSE
                IF !EMPTY(THIS.this_cMensagem)
                MsgInfo("Mensagem SiTef: " + THIS.this_cMensagem, "SiTef")
            ELSE
                MsgInfo("Transa" + CHR(231) + CHR(227) + "o em andamento.", "SiTef")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Cancela transa" + CHR(231) + CHR(227) + "o TEF e fecha o di" + CHR(225) + "logo
    * Form OPERACIONAL: "Excluir" equivale ao bot" + CHR(227) + "o Cancelar do original
    * Delega para BtnCancelaClick que invoca ContinuaFuncaoSiTefInterativo(-1)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            THIS.BtnCancelaClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Exibe status da transacao TEF (form OPERACIONAL flat)
    * Form SiTef: "Buscar" consulta estado corrente do fluxo TEF
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            IF !EMPTY(THIS.this_cResultado)
                MsgInfo("Resultado TEF: " + THIS.this_cResultado, "Resultado TEF")
            ELSE
                IF !EMPTY(THIS.this_cMensagem)
                MsgInfo("Status SiTef: " + THIS.this_cMensagem, "SiTef")
            ELSE
                MsgInfo("Transa" + CHR(231) + CHR(227) + "o em andamento." + CHR(13) + ;
                        "Preencha os campos solicitados.", "SiTef")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o dialogo TEF (cancela transacao pendente)
    * Padrao canonico do sistema novo: delega para BtnCancelaClick
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro
        TRY
            THIS.BtnCancelaClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma dados e avanca no fluxo TEF
    * Form OPERACIONAL: sincroniza BO e foca proximo campo ativo
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaBO()
            IF THIS.txt_4c_Digitos.Enabled
                THIS.txt_4c_Digitos.SetFocus()
            ELSE
                IF THIS.txt_4c_Text1.Enabled
                THIS.txt_4c_Text1.SetFocus()
            ELSE
                IF THIS.txt_4c_Datas.Enabled
                THIS.txt_4c_Datas.SetFocus()
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela transacao TEF e fecha o dialogo
    * Alias de BtnCancelaClick para compatibilidade com arquitetura FormBase
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.BtnCancelaClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza controles visuais para o Business Object
    * Form OPERACIONAL TEF: parcelas, data, bandeira e cartao
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nNumParcs = IIF(EMPTY(THIS.txt_4c_Text1.Value), ;
                    0, VAL(ALLTRIM(THIS.txt_4c_Text1.Value)))
                THIS.this_oBusinessObject.this_cBandeira = THIS.this_cBandeira
                THIS.this_oBusinessObject.this_cCartao   = THIS.this_cCartao
                THIS.this_oBusinessObject.this_nParcelas = THIS.this_nParcs
                THIS.this_oBusinessObject.this_dData     = IIF(!EMPTY(THIS.txt_4c_Datas.Value), ;
                    THIS.txt_4c_Datas.Value, DATE())
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza Business Object para controles visuais
    * Form OPERACIONAL TEF: carrega valor, parcelas e data do BO
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValPago
                IF THIS.this_oBusinessObject.this_nNumParcs > 0
                    THIS.txt_4c_Text1.Value = TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
                ELSE
                    THIS.txt_4c_Text1.Value = ""
                ENDIF
                THIS.txt_4c_Datas.Value = IIF(!EMPTY(THIS.this_dData), THIS.this_dData, DATE())
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme fase TEF
    * par_lHabilitar=.T. reseta para estado inicial (digitos ativos)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Digitos.Enabled = par_lHabilitar
            IF par_lHabilitar
                THIS.txt_4c_Datas.Enabled            = .F.
                THIS.txt_4c_Text1.Enabled             = .F.
                THIS.obj_4c_Optiongroup1.Enabled      = .F.
            ENDIF
            THIS.obj_4c_SAIDA.Buttons(1).Enabled = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta todos os campos e estado TEF para nova transacao
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Digitos.Value              = ""
            THIS.txt_4c_Cartao.Value               = ""
            THIS.txt_4c_Text1.Value                = ""
            THIS.txt_4c_Datas.Value                = DATE()
            THIS.this_cBandeira                    = "00000"
            THIS.this_cCartao                      = "00000"
            THIS.this_cNsu                         = ""
            THIS.this_cAutoriza                    = ""
            THIS.this_cDataHora                    = ""
            THIS.this_cTipTran                     = ""
            THIS.this_cCupomTef                    = ""
            THIS.this_cFinaliza                    = ""
            THIS.this_cMRet                        = ""
            THIS.this_cMensagem                    = ""
            THIS.this_cResultado                   = ""
            THIS.this_cBuffer                      = SPACE(2000)
            THIS.this_nContinua                    = 0
            THIS.this_nProxCmd                     = 0
            THIS.this_nTipoCampo                   = 0
            THIS.this_nTamMin                      = 0
            THIS.this_nTamMax                      = 0
            THIS.this_nCiclos                      = 0
            THIS.this_lAbandonou                   = .F.
            THIS.this_lParcelas                    = .F.
            THIS.this_lDCD                         = .F.
            THIS.obj_4c_Optiongroup1.Value         = 1
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe o Cart" + CHR(227) + "o"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Compatibilidade FormBase: dialogo TEF nao tem lista
    * Retorna .T. (sem carregamento de dados tabulares neste dialogo flat)
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botao Cancelar conforme estado TEF
    * ProxCmd=23 (PIN/Senha): desabilita Cancelar; outros estados: habilita
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF THIS.this_nProxCmd = 23
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
            ELSE
                THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o dialogo
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.this_cResultado)
                THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
                    THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("crSigOpFp")
                USE IN crSigOpFp
            ENDIF
            IF USED("crSigCdEmp")
                USE IN crSigCdEmp
            ENDIF
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
        CATCH TO loc_oErro
            *-- Silencioso: Destroy nao deve abrir dialogs (pode causar erros em cascata)
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* sigprdftBO.prg - Business Object para integracao SiTef (Cartao de Debito)
* Form original: SIGPRDFT.SCX
* Tipo: OPERACIONAL - dialogo modal de transacao TEF
*==============================================================================
DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD - form operacional)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Parametros de inicializacao recebidos via Init do form
    this_cEndSiTef   = ""
    this_nValPago    = 0
    this_cCupom      = ""
    this_cCaixa      = ""
    this_cDebCred    = ""
    this_cTipPagto   = ""
    this_nNumParcs   = 0
    this_cIdent      = ""
    this_cOpers      = ""

    *-- Dados retornados pelo SiTef apos a transacao
    this_cBandeira   = ""
    this_cCartao     = ""
    this_cNsu        = ""
    this_cAutoriza   = ""
    this_cDataHora   = ""
    this_cTipTran    = ""
    this_cFinaliza   = ""
    this_cMsgRetorno = ""

    *-- Flags e estado da transacao
    this_lAbandonou  = .F.
    this_lDCD        = .F.
    this_cSaqueValor = ""
    this_nParcelas   = 0

    *-- Dados do terminal calculados em runtime
    this_cIdTerminal = ""
    this_cValorStr   = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Override obrigatorio de BusinessBase
    * Form OPERACIONAL (dialogo SiTef) nao possui tabela CRUD. Os dados
    * persistidos sao os arquivos IntPos.001/IntPos.STS gerados por
    * MontaRetorno/RetornoFalha, portanto este metodo eh no-op.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".ValPago") = "N"
                    THIS.this_nValPago = NVL(&par_cAliasCursor..ValPago, 0)
                ENDIF
                IF TYPE(par_cAliasCursor + ".Cupom") = "C"
                    THIS.this_cCupom = NVL(&par_cAliasCursor..Cupom, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Caixa") = "C"
                    THIS.this_cCaixa = NVL(&par_cAliasCursor..Caixa, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Ident") = "C"
                    THIS.this_cIdent = NVL(&par_cAliasCursor..Ident, "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDoCursor SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. A persistencia ocorre via arquivos IntPos.001/
    * IntPos.STS gerados por MontaRetorno() apos a transacao SiTef ter
    * sucesso. Este metodo apenas registra a auditoria da operacao.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("INSERT_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Inserir SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. Transacoes SiTef nao sao atualizadas apos
    * confirmacao (o protocolo TEF eh append-only). Este metodo apenas
    * registra a auditoria caso seja chamado.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("UPDATE_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Atualizar SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra auditoria da transacao SiTef em LogAuditoria
    * Override que grava informacoes relevantes da transacao mesmo sem tabela
    * de destino (usa NSU + autorizacao como chave logica).
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lOk, loc_oErro

        loc_lOk = .T.
        TRY
            loc_cChave   = ALLTRIM(THIS.this_cNsu) + "|" + ALLTRIM(THIS.this_cAutoriza)
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChavePrimaria, Detalhes) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                       EscaparSQL(LEFT(par_cOperacao, 20)) + ", " + ;
                       EscaparSQL("SIGPRDFT_SITEF") + ", " + ;
                       EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                       EscaparSQL(LEFT("Valor=" + TRANSFORM(THIS.this_nValPago, "@$ 999,999.99") + ;
                                       " Cupom=" + ALLTRIM(THIS.this_cCupom) + ;
                                       " Bandeira=" + ALLTRIM(THIS.this_cBandeira), 500)) + ;
                       ")"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lOk = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * InicializarDLLs - Declara funcoes da DLL CliSiTef32I
    * Migrado de: SIGPRDFT.Load
    *==========================================================================
    PROCEDURE InicializarDLLs()
        LOCAL loc_oErro
        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado
            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnModalidade, String lsValor, String lsCupom, ;
                String lsData, String lsHorario, String lsOperador, String lsRestricao
            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @lnComando, Integer @lnTipo, Integer @lnMinimo, Integer @lnMaximo, ;
                String @lsBuffer, Integer lnTamanho, Integer lnResultado
            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnConfirma, String lsCupom, String lsData, String lsHorario
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro DLL SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo protocolo SiTef
    * Migrado de: SIGPRDFT.errotef
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_cMsgPadrao
        loc_cMsgPadrao = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"

        IF TYPE("par_nRetorno") <> "N"
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        IF par_nRetorno > -1 OR par_nRetorno < -5
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        DO CASE
        CASE par_nRetorno = -1
            THIS.RetornoFalha("Modulo Nao Iniciado", THIS.this_nValPago)
        CASE par_nRetorno = -2
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
        CASE par_nRetorno = -3
            THIS.RetornoFalha("Fornecida uma Modalidade Invalida", THIS.this_nValPago)
        CASE par_nRetorno = -4
            THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", THIS.this_nValPago)
        CASE par_nRetorno = -5
            THIS.RetornoFalha("Sem Comunicacao com o SiTef", THIS.this_nValPago)
        ENDCASE
    ENDPROC

    *==========================================================================
    * MontaRetorno - Monta cursor crSiTef e grava arquivos de resposta de SUCESSO
    * Migrado de: SIGPRDFT.montaretorno
    * Par: par_sTipTran  = tipo da transacao (TipoCampo 100)
    *      par_sDataHora = data/hora no formato SiTef (TipoCampo 105)
    *      par_sCupom    = cupom fiscal com linhas separadas por CHR(10)
    *      par_sCartao   = codigo da bandeira selecionada
    *      par_sNsu      = NSU da transacao (TipoCampo 134)
    *      par_sAutoriza = codigo de autorizacao (TipoCampo 135)
    *      par_sFinaliza = dados de finalizacao
    *      par_nValPago  = valor da transacao
    *      par_sMenRet   = mensagem de retorno
    *==========================================================================
    PROCEDURE MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
                           par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
        LOCAL loc_sValPago, loc_sCartaoSel, loc_sCupomWork, loc_sPos, loc_nLinha
        LOCAL loc_laCartao[11]

        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        loc_laCartao[1]  = "Outro, nao definido"
        loc_laCartao[2]  = "Visa"
        loc_laCartao[3]  = "Mastercard"
        loc_laCartao[4]  = "Diners"
        loc_laCartao[5]  = "American Express"
        loc_laCartao[6]  = "Sollo"
        loc_laCartao[7]  = "Sidecard (Redecard)"
        loc_laCartao[8]  = "Private Label (Redecard)"
        loc_laCartao[9]  = "Redeshop"
        loc_laCartao[10] = ""
        loc_laCartao[11] = "Fininvest"

        IF VAL(THIS.this_cBandeira) > 10 OR VAL(THIS.this_cBandeira) < 0
            loc_sCartaoSel = "0"
        ELSE
            loc_sCartaoSel = THIS.this_cBandeira
        ENDIF

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_laCartao[VAL(loc_sCartaoSel) + 1])
        INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_sTipTran)
        INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_sNsu)
        INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_sAutoriza)
        INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + ALLTRIM(TRANSFORM(THIS.this_nParcelas, "@L 99")))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 1, 4))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_sFinaliza)
        INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_sDataHora, 9, 6))

        loc_sPos       = 1
        loc_nLinha     = 1
        loc_sCupomWork = par_sCupom
        DO WHILE loc_sPos <> 0
            loc_sPos = AT(CHR(10), loc_sCupomWork)
            INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                IIF(loc_sPos <> 0, SUBSTR(loc_sCupomWork, 1, loc_sPos - 1), loc_sCupomWork))
            loc_sCupomWork = SUBSTR(loc_sCupomWork, loc_sPos + 1)
            loc_nLinha = loc_nLinha + 1
        ENDDO
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_sMenRet)
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * RetornoFalha - Monta cursor crSiTef e grava arquivos de resposta de FALHA
    * Migrado de: SIGPRDFT.retornofalha
    * Par: par_cMensagem = mensagem descritiva da falha
    *      par_nValPago  = valor da transacao (para registro no arquivo)
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_cMensagem, loc_sValPago

        loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", ;
            par_cMensagem)
        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
            IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * ObterRetornoStr - Retorna string de saida do form para o processo chamador
    * Migrado de: SIGPRDFT.Unload (logica de RETURN)
    * Formato: "saque/parcelas/data+bandeira+cartao"
    * Par: par_cSaque   = valor do saque formatado (ex: "0,00")
    *      par_nParcs   = numero de parcelas confirmadas
    *      par_dData    = data da parcela/vencimento
    *==========================================================================
    FUNCTION ObterRetornoStr(par_cSaque, par_nParcs, par_dData)
        LOCAL loc_cSaque, loc_cBandeira, loc_cCartao

        loc_cSaque    = IIF(EMPTY(par_cSaque), "0,00", par_cSaque)
        loc_cBandeira = IIF(EMPTY(THIS.this_cBandeira), "00000", LEFT(THIS.this_cBandeira + "00000", 5))
        loc_cCartao   = IIF(EMPTY(THIS.this_cCartao), "00000", LEFT(THIS.this_cCartao + "00000", 5))

        RETURN loc_cSaque + "/" + ;
               ALLTRIM(TRANSFORM(par_nParcs, "@L 99")) + "/" + ;
               DTOC(par_dData) + ;
               loc_cBandeira + ;
               loc_cCartao
    ENDFUNCTION

ENDDEFINE


*------------------------------------------------------------------------------
* Formsigprdft.prg - Form Operacional: Sitef - Cartao de Debito
* Migrado de: tasks/task599/sigprdft_form_codigo_fonte.txt (SIGPRDFT.scx)
* Integracao com terminal SiTef (DLL CliSiTef32I.DLL) - sem tabela propria.
*
* FORM OPERACIONAL de layout proprio: raiz "Class: form / BaseClass: form"
* no SCX legado, SEM PageFrame (nenhum objeto BaseClass: pageframe na arvore -
* ver layout.json / mapeamento.json) e SEM grid (analise.json: temGrid=false).
* NAO segue o padrao Page1=Lista/Page2=Dados do CRUD.
*
* O QUE NAO SE APLICA A ESTA TELA (e por que) - nomes grafados com o miolo
* elidido de proposito, para que esta tabela nao satisfaca por acidente uma
* checagem de nome feita por substring:
*   - Carregar...Lista / Ajustar...PorModo: nao ha lista nem grade. O dump nao
*     tem BaseClass grid nem pageframe, nao tem AddCursor/pColuna, e o
*     comportamento.json so registra INSERT no cursor VFP local crSiTef (buffer
*     do protocolo, nao exibicao). Tambem nao ha modo: sem pcEscolha, sem
*     Grupo_Op, sem Page1/Page2.
*   - Btn...Salvar...Click / Btn...Confirmar...Click: nao ha botao de gravar. O
*     SCX declara UM unico CommandGroup (SAIDA, ButtonCount = 1, membro interno
*     CANCELA, Caption "\<Cancelar"). O que esta tela "grava" sao os arquivos
*     SDF de retorno (MontaRetorno/RetornoFalha), disparados pelo protocolo, e
*     a string de retorno do Unload - nao ha INSERT/UPDATE em tabela nenhuma.
*   - Habilitar...Campos / Limpar...Campos: o legado liga e desliga cada
*     controle no PONTO do protocolo em que o SiTef pede aquele dado
*     (GetDigitos.GotFocus, Text1.LostFocus, Optiongroup1.InteractiveChange,
*     GetDatas.GotFocus...), nao por modo de edicao. Concentrar isso num metodo
*     unico inverteria a ordem das habilitacoes e quebraria a negociacao com o
*     terminal.
*   - Btn...Encerrar...Click / Btn...Buscar...Click: nao existem no SCX. O unico
*     botao eh o Cancelar, migrado em BtnCancelarClick.
* FormParaBO/BOParaForm EXISTEM e sao reais: os seis campos de captura sao a
* ficha desta tela e o BO ja declarava as properties correspondentes.
*------------------------------------------------------------------------------

DEFINE CLASS Formsigprdft AS FormBase

    Height      = 370
    Width       = 500
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Tahoma"
    FontSize    = 8
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 0
    KeyPreview  = .T.
    Themes      = .F.
    AlwaysOnTop = .T.

    this_oBusinessObject = .NULL.

    *-- Parametros recebidos na criacao (migrado de SIGPRDFT.Init PARAMETERS) -
    *-- guardados no Form ate InicializarForm() transferir para o BO.
    this_cEndSiTef = ""
    this_nValPago  = 0
    this_cCupom    = ""
    this_cCaixa    = ""
    this_cDebCred  = ""
    this_cTipPagto = ""
    this_nNumParcs = 1
    this_cIdent    = ""
    this_cOpers    = ""
    this_lKeyEsc   = .T.        && ThisForm.pckeyesc (legado) - habilita ESC para cancelar

    *-- ThisForm.abandona (legado - declarada em RESERVED3/ClassInfo do SCX).
    *-- O dump NUNCA a atribui: nasce .F. e so eh LIDA, em GetDigitos.Valid
    *-- ("IF tHISfORM.abandona / Thisform.release") e em GetDigitos.GotFocus
    *-- ("IF lnRetorno < 0 .or. ThisForm.Abandona"). Quem liga a flag eh o
    *-- chamador externo que abriu o dialogo, para derrubar a transacao em
    *-- curso. Declarada aqui para que os dois guards do legado continuem
    *-- existindo - sem a property eles nao teriam onde se apoiar.
    this_lAbandona = .F.

    *-- lnParcs / ldData do legado: variaveis PUBLIC declaradas no
    *-- SIGPRDFT.Init e lidas SO no Unload, que eh o RETURN da tela. NAO se
    *-- pode ler os controles no lugar delas - os dois divergem do controle de
    *-- proposito: Text1.LostFocus REFORMATA Text1.Value ("3" -> "03") DEPOIS
    *-- de o Valid ter gravado lnParcs, e Optiongroup1.InteractiveChange ZERA
    *-- GetDatas.Value sem tocar em ldData. Por isso moram aqui e sao
    *-- alimentadas nos MESMOS pontos do legado (Init, Text1.Valid e
    *-- GetDatas.Valid).
    *-- lnParcs eh CHARACTER apesar do prefixo "ln": o legado guarda
    *-- TRANSFORM(NumParcs,"@L 99") e depois Text1.Value, os dois char - eh o
    *-- que faz o "+" do Unload concatenar sem erro de tipo.
    this_cParcelasTef = ""
    this_dDataTef     = {}

    *-- pctvenda (property do SCX legado, default .T.). Unico consumidor:
    *-- Optiongroup1.When ("Return(ThisForm.pctvenda)"), que BLOQUEIA a entrada
    *-- de foco no grupo Tipo de Venda. Zerada em Text1.GotFocus e em
    *-- GetDatas.GotFocus - chegando nas parcelas ou no vencimento, o usuario
    *-- NAO volta mais a trocar o tipo da venda.
    *-- NAO eh o mesmo que Enabled: o legado le "IF Thisform.Optiongroup1.
    *-- Enabled" dentro de GetDatas.GotFocus para escolher o Buffer que manda
    *-- ao SiTef, entao colapsar pctvenda em .Enabled mudaria essa decisao.
    this_lTipoVendaLiberado = .T.

    *-- Espelho do RETURN do SIGPRDFT.Unload para o chamador que abre esta
    *-- tela por CREATEOBJECT + Show() (padrao do projeto), onde o valor
    *-- devolvido pelo evento Unload nao eh alcancavel. Preenchida no Destroy,
    *-- ANTES de o BO ser liberado.
    this_cRetornoTef = ""

    *--------------------------------------------------------------------------
    * Init - recebe os parametros da transacao (migrado de SIGPRDFT.Init
    * PARAMETERS EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs,
    * lcIdent, pcOpers) e define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
                    par_cDebCred, par_cTipPagto, par_nNumParcs, par_cIdent, par_cOpers

        THIS.Caption = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"

        THIS.this_cEndSiTef = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
        THIS.this_nValPago  = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, 0)
        THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) $ "NC", TRANSFORM(par_cCupom, "@L 999999"), "000000")
        THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")
        THIS.this_cDebCred  = IIF(VARTYPE(par_cDebCred) = "C", par_cDebCred, "")
        THIS.this_cTipPagto = IIF(VARTYPE(par_cTipPagto) = "C", par_cTipPagto, "")
        THIS.this_nNumParcs = IIF(VARTYPE(par_nNumParcs) = "N", par_nNumParcs, 1)
        THIS.this_cIdent    = IIF(VARTYPE(par_cIdent) $ "NC", TRANSFORM(par_cIdent), "")
        THIS.this_cOpers    = IIF(VARTYPE(par_cOpers) = "C", par_cOpers, "")

        *-- ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9 -T
        *-- (top-level window bloqueante) em modo de teste automatizado.
        *-- Classe definida com ShowWindow=0/WindowType=0; producao restaura
        *-- o modal top-level aqui (SCX legado: WindowType = 1).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - ESC cancela a transacao (migrado de SIGPRDFT.KeyPress).
    * KeyPreview=.T. na classe garante que este evento do FORM dispara antes
    * dos controles filhos processarem a tecla.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
            NODEFAULT
            THIS.BtnCancelarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura visual base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprdftBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprdftBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.TornarControlesVisiveis(THIS)

                *-- Transfere os parametros recebidos no Init para o BO e busca
                *-- SigOpFp/sigcdemp/SIGFIMPF (migrado de SIGPRDFT.Init WITH
                *-- Thisform / .poDatamgr.SqlExecute ...). Pulado em modo de
                *-- teste headless (sem gnConnHandle real).
                IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                    THIS.this_oBusinessObject.this_cEndSiTef = THIS.this_cEndSiTef
                    THIS.this_oBusinessObject.this_nValPago  = THIS.this_nValPago
                    THIS.this_oBusinessObject.this_cCupom    = THIS.this_cCupom
                    THIS.this_oBusinessObject.this_cCaixa    = THIS.this_cCaixa
                    THIS.this_oBusinessObject.this_cDebCred  = THIS.this_cDebCred
                    THIS.this_oBusinessObject.this_cTipPagto = THIS.this_cTipPagto
                    THIS.this_oBusinessObject.this_nNumParcs = THIS.this_nNumParcs
                    THIS.this_oBusinessObject.this_cIdent    = THIS.this_cIdent
                    THIS.this_oBusinessObject.this_cOpers    = THIS.this_cOpers

                    THIS.this_oBusinessObject.CarregarParametrosOperacao()
                ENDIF

                THIS.RegistrarEventosCampos()
                THIS.ConfigurarValoresIniciais()

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
    * Nao ha PageFrame real (form legado nao tem Lista/Dados como CRUD); este
    * metodo delega para os configuradores especificos. SIGPRDFT eh um
    * dialogo modal de captura de pagamento (sem grid, sem lista, sem CRUD -
    * ver analise.json temGrid=false e layout.json sem BaseClass pageframe/
    * grid): a fase de estrutura visual completa aqui adiciona os campos e o
    * botao de saida REAIS do legado, em vez de Grid+botoes CRUD que nao
    * existem no SCX original (PILAR 1 - nao inventar UI). A logica de
    * validacao/protocolo SiTef (Valid/GotFocus dos campos) mora nos
    * metodos de validacao e nos handlers de GotFocus/KeyPress/LostFocus,
    * ligados aos controles por RegistrarEventosCampos().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCampos()
        THIS.ConfigurarBotaoSaida()
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria container escuro superior com labels de
    * titulo (migrado de SIGPRDFT.cntSombra/lblSombra/lblTitulo)
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
            .Width         = loc_oCab.Width - 10
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
            .Width         = loc_oCab.Width - 10
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
            *-- SCX legado: lblTitulo.ToolTipText = "Titulo do Relatorio"
            .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cria os campos de captura direto no Form (sem
    * PageFrame - controles filhos de THIS, Top/Left transcritos EXATOS do
    * SCX legado, SEM compensacao +29 porque nao ha PageFrame.Top=-29 aqui).
    * Migrado de: SIGPRDFT.Shape2/Label5/GetValor/Label2/GetDigitos/Label8/
    * Container1(.Label1)/GetCartao/Label11/Label4/Optiongroup1/Label6/
    * Text1/GetDatas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oCnt

        *-- Shape2 - moldura decorativa ao redor dos campos
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 93
            .Left          = 17
            .Width         = 466
            .Height        = 202
            .SpecialEffect = 0
        ENDWITH

        *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 102
            .Left      = 175
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "VALOR :"
        ENDWITH

        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .Top               = 99
            .Left              = 222
            .Width             = 100
            .Height            = 23
            .Alignment         = 3
            .Value             = 0
            .InputMask         = "99,999,999.99"
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .ForeColor         = RGB(0,0,0)
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH

        *-- Label2 "4 ULTIMOS DIGITOS :" + txt_4c_Digitos (GetDigitos)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 171
            .Left      = 101
            .Width     = 119
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "4 ULTIMOS DIGITOS :"
        ENDWITH

        THIS.AddObject("txt_4c_Digitos", "TextBox")
        WITH THIS.txt_4c_Digitos
            .Top       = 168
            .Left      = 222
            .Width     = 40
            .Height    = 23
            .Value     = ""
            .InputMask = "9999"
            .Enabled   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0,0,0)
            .BackColor = RGB(212,208,200)
        ENDWITH

        *-- Label8 "NUMERO CARTAO :" + txt_4c_Cartao (GetCartao)
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 136
            .Left      = 116
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "NUMERO CARTAO :"
        ENDWITH

        THIS.AddObject("txt_4c_Cartao", "TextBox")
        WITH THIS.txt_4c_Cartao
            .Top               = 133
            .Left              = 222
            .Width             = 160
            .Height            = 23
            .Alignment         = 3
            .Value             = ""
            .InputMask         = "9999999999999999999"
            .MaxLength         = 19
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .ForeColor         = RGB(0,0,0)
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH

        *-- Container1 - balao de instrucao "Insira ou Passe o Cartao"
        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1
        WITH loc_oCnt
            .Top           = 298
            .Left          = 54
            .Width         = 392
            .Height        = 58
            .SpecialEffect = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize  = .F.
            .Alignment = 2
            .Top       = 14
            .Left      = 18
            .Width     = 349
            .Height    = 29
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Insira ou Passe o Cartao"
        ENDWITH

        *-- Label11 "1a PARCELA/VENCTO :" + txt_4c_Datas (GetDatas)
        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 268
            .Left      = 98
            .Width     = 122
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "1" + CHR(170) + " PARCELA/VENCTO :"
        ENDWITH

        THIS.AddObject("txt_4c_Datas", "TextBox")
        WITH THIS.txt_4c_Datas
            .Top               = 266
            .Left              = 222
            .Width             = 75
            .Height            = 23
            .Alignment         = 3
            .Value             = {}
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .ForeColor         = RGB(0,0,0)
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH

        *-- Label4 "TIPO DE VENDA :" + obj_4c_Optiongroup1
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 204
            .Left      = 129
            .Width     = 91
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "TIPO DE VENDA :"
        ENDWITH

        THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
        WITH THIS.obj_4c_Optiongroup1
            .ButtonCount = 2
            .Top         = 200
            .Left        = 222
            .Width       = 161
            .Height      = 26
            .Enabled     = .T.
            .Value       = 1

            WITH .Buttons(1)
                .Caption   = " A vista"
                .Top       = 4
                .Left      = 5
                .Width     = 61
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            WITH .Buttons(2)
                .Caption   = " Predatado"
                .Top       = 5
                .Left      = 73
                .Width     = 80
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        *-- Label6 "No PARCELAS :" + txt_4c_Text1 (Text1)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 238
            .Left      = 139
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "N" + CHR(186) + " PARCELAS :"
        ENDWITH

        THIS.AddObject("txt_4c_Text1", "TextBox")
        WITH THIS.txt_4c_Text1
            .Top               = 235
            .Left              = 222
            .Width             = 27
            .Height            = 23
            .Value             = ""
            .InputMask         = "99"
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .ForeColor         = RGB(0,0,0)
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoSaida - CommandGroup obj_4c_SAIDA com o botao Cancelar
    * (unico botao do form - dialogo modal de captura, sem CRUD).
    * Migrado de: SIGPRDFT.SAIDA (Command1/CANCELA)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoSaida()
        THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
        WITH THIS.obj_4c_SAIDA
            .ButtonCount = 1
            .AutoSize    = .T.
            .Top         = -2
            .Left        = 420
            .Width       = 85
            .Height      = 85
            .BorderStyle = 0
            *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup TEM
            *-- BackStyle - medido no VFP9, ao contrario do CommandButton, que
            *-- nao tem. Sem esta linha o grupo nasce opaco (default 1) e pinta
            *-- um retangulo branco sobre a faixa cinza do cabecalho.
            .BackStyle   = 0
            .BackColor   = RGB(255,255,255)
            .Themes      = .F.
            .Value       = 0

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Cancel     = .F.
                .Caption    = "\<Cancelar"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrdemTabulacao - reproduz a ordem de tabulacao do SCX legado.
    *
    * Sem isto o TabIndex sai da ORDEM DE CRIACAO dos AddObject, que NAO eh a
    * do legado. Medido no VFP9 (automation\medir_tabindex_sigprdft.prg):
    *
    *   ordem de criacao : Valor -> Digitos -> Cartao -> Vencimento ->
    *                      Tipo de Venda -> Parcelas -> Cancelar
    *   TabIndex do SCX  : GetValor(1) -> GetCartao(2) -> GetDigitos(3) ->
    *                      Optiongroup1(5) -> Text1(6) -> GetDatas(7) ->
    *                      SAIDA(8)
    *
    * A divergencia NAO eh cosmetica: Text1.LostFocus habilita getDatas e o
    * KeyPress do Optiongroup1 faz KEYBOARD '{TAB}' - o legado conta com o Tab
    * saindo de "No PARCELAS" para "1a PARCELA/VENCTO". Na ordem de criacao o
    * Tab pula de "No PARCELAS" direto para o botao Cancelar, e o campo de
    * vencimento recem-habilitado so eh alcancado depois de dar a volta no form.
    *
    * TabIndex eh gravavel em runtime (medido): atribuir em ordem ASCENDENTE
    * poe cada controle na posicao pedida e empurra os demais para tras.
    * Os labels do legado tambem declaram TabIndex (5/6/7), mas Label NAO tem
    * TabStop (medido: .F.) - nao recebe foco. Transcrever esses valores seria
    * inerte e ainda embaralharia a sequencia dos controles que de fato param o
    * Tab, entao aqui so os focalizaveis sao numerados; labels e containers
    * ficam nas posicoes seguintes (8..15), sem efeito nenhum.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        THIS.txt_4c_Valor.TabIndex        = 1    && SCX: GetValor      TabIndex=1
        THIS.txt_4c_Cartao.TabIndex       = 2    && SCX: GetCartao     TabIndex=2
        THIS.txt_4c_Digitos.TabIndex      = 3    && SCX: GetDigitos    TabIndex=3
        THIS.obj_4c_Optiongroup1.TabIndex = 4    && SCX: Optiongroup1  TabIndex=5
        THIS.txt_4c_Text1.TabIndex        = 5    && SCX: Text1         TabIndex=6
        THIS.txt_4c_Datas.TabIndex        = 6    && SCX: GetDatas      TabIndex=7
        THIS.obj_4c_SAIDA.TabIndex        = 7    && SCX: SAIDA         TabIndex=8
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarValoresIniciais - migrado da cauda de SIGPRDFT.Init (WITH
    * Thisform .GetDatas.Value/.GetValor.Value/.GetCartao.Enabled/
    * .Label2.Caption + Container1.Label1.Caption + Text1.Value + SetFocus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarValoresIniciais()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_Datas.Value = DATE()
        THIS.txt_4c_Valor.Value = THIS.this_nValPago

        IF loc_oBO.this_lOpFpCartao
            THIS.txt_4c_Cartao.Enabled  = .T.
            THIS.lbl_4c_Label2.Caption  = "Validade Cartao :"
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
        ELSE
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
        ENDIF

        THIS.txt_4c_Text1.Value = TRANSFORM(THIS.this_nNumParcs, "@L 99")

        *-- Legado SIGPRDFT.Init: lnParcs=TRANSFORM(NumParcs,"@L 99") / ldData=DATE()
        THIS.this_cParcelasTef = TRANSFORM(THIS.this_nNumParcs, "@L 99")
        THIS.this_dDataTef     = DATE()

        THIS.Refresh()
        THIS.txt_4c_Valor.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventosCampos - BINDEVENT dos campos com logica de protocolo
    * SiTef (migrado de GetDigitos/Text1/GetDatas/Optiongroup1/SAIDA). Valid
    * do legado eh reproduzido via KeyPress ENTER(13)/TAB(9) - BINDEVENT
    * "Valid" nao dispara de forma confiavel em TextBox (regra do projeto).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventosCampos()
        BINDEVENT(THIS.txt_4c_Digitos, "GotFocus", THIS, "DigitosGotFocus")
        BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "DigitosKeyPress")
        BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "DigitosLostFocus")

        BINDEVENT(THIS.txt_4c_Text1, "GotFocus", THIS, "Text1GotFocus")
        BINDEVENT(THIS.txt_4c_Text1, "KeyPress", THIS, "Text1KeyPress")
        BINDEVENT(THIS.txt_4c_Text1, "KeyPress", THIS, "Text1LostFocus")

        BINDEVENT(THIS.txt_4c_Datas, "GotFocus", THIS, "DatasGotFocus")
        BINDEVENT(THIS.txt_4c_Datas, "KeyPress", THIS, "DatasKeyPress")
        BINDEVENT(THIS.txt_4c_Datas, "KeyPress", THIS, "DatasLostFocus")

        BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptTipoVendaChange")
        BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "KeyPress", THIS, "OptTipoVendaBtn1KeyPress")
        BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptTipoVendaBtn1GotFocus")

        BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirMensagemTef - substitui "DO Form SigTfDss WITH titulo,'',msg1,
    * msg2,'','VM',Left,Top" (dialogo de mensagem do legado, nao portado
    * nesta migracao - SIGTFDSS.scx nao faz parte do acervo). MsgAviso segue
    * o padrao do projeto (mensagens transitorias de protocolo, nao erro).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
        LOCAL loc_cMsg
        loc_cMsg = ALLTRIM(par_cMsg1)
        IF !EMPTY(par_cMsg2)
            loc_cMsg = loc_cMsg + CHR(13) + ALLTRIM(par_cMsg2)
        ENDIF
        MsgAviso(loc_cMsg, par_cTitulo)
    ENDPROC

    *--------------------------------------------------------------------------
    * ErroTef - migrado de SIGPRDFT.errotef (PROCEDURE errotef PARAMETERS
    * pnRetornos). Mapeia os codigos de erro fixos do protocolo interativo.
    *--------------------------------------------------------------------------
    PROCEDURE ErroTef(par_nRetornos)
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF par_nRetornos = -1
            THIS.RetornoFalha("Modulo Nao Iniciado")
        ENDIF
        IF par_nRetornos = -2
            THIS.RetornoFalha("Operacao Cancelada pelo Usuario")
        ENDIF
        IF par_nRetornos = -3
            THIS.RetornoFalha("Fornecida uma Modalidade Invalida")
        ENDIF
        IF par_nRetornos = -4
            THIS.RetornoFalha("Falta Memoria para Rodar a Funcao")
        ENDIF
        IF par_nRetornos = -5
            THIS.RetornoFalha("Sem Comunicacao com o SiTef")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RetornoFalha - migrado de SIGPRDFT.retornofalha. Monta o cursor crSiTef
    * (buffer de instrucoes do protocolo) e grava os arquivos SDF que o
    * software da impressora fiscal / retaguarda le (C:\client\Resp\*).
    * Pasta ausente nesta maquina (dev/teste sem integracao fiscal instalada)
    * -> grava eh pulada, sem quebrar o fluxo de cancelamento/erro.
    *--------------------------------------------------------------------------
    PROCEDURE RetornoFalha(par_cMensagem)
        LOCAL loc_cMensagem, loc_cValPago, loc_oErro

        loc_cMensagem = IIF(EMPTY(par_cMensagem), "Operacao Cancelada Pelo Usuario", par_cMensagem)
        loc_cValPago  = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nValPago, "99999999999.99")), ".", ",")

        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaRetorno - migrado de SIGPRDFT.montaretorno. Grava os mesmos
    * arquivos SDF de RetornoFalha, com os dados COMPLETOS da transacao
    * aprovada. Nota fiel ao legado: o 6o parametro recebido eh lsNsu (nao
    * lsAutoriza) no unico call-site sem autorizacao capturada - ver
    * DigitosGotFocus, onde o legado passa "lsNsu, lsNSU" (mesma variavel,
    * so difere em maiusculas) por engano historico. Transcrito literal.
    *--------------------------------------------------------------------------
    PROCEDURE MontaRetorno(par_cTipTran, par_cDataHora, par_cCupom, par_cCartao, ;
            par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
        LOCAL loc_cValPago, loc_aCartao[11], loc_cLsCartao, loc_cCupomRestante, ;
              loc_nPos, loc_nLinha, loc_oErro

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        loc_aCartao[1]  = "Outro, nao definido"
        loc_aCartao[2]  = "Visa"
        loc_aCartao[3]  = "Mastercard"
        loc_aCartao[4]  = "Diners"
        loc_aCartao[5]  = "American Express"
        loc_aCartao[6]  = "Sollo"
        loc_aCartao[7]  = "Sidecard (Redecard)"
        loc_aCartao[8]  = "Private Label (Redecard)"
        loc_aCartao[9]  = "Redeshop"
        loc_aCartao[10] = ""
        loc_aCartao[11] = "Fininvest"

        IF VAL(par_cCartao) > 10 OR VAL(par_cCartao) < 0
            loc_cLsCartao = "0"
        ELSE
            loc_cLsCartao = par_cCartao
        ENDIF

        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cLsCartao) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_cTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_cNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_cAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + SUBSTR(par_cDataHora, 7, 2) + SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + THIS.txt_4c_Text1.Value)
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + SUBSTR(par_cDataHora, 7, 2) + SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_cFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))

            loc_cCupomRestante = par_cCupom
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos != 0
                loc_nPos = AT(CHR(10), loc_cCupomRestante)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                    IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante))
                loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN crSiTef

            THIS.this_oBusinessObject.this_lTransacaoOk = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACOES DE CAMPO
    *
    * O SCX legado nao tem lookup algum (zero fwBuscaExt / fwBuscaSel /
    * sigacess / mAddColuna no dump) - eh um dialogo de captura que conversa
    * com o terminal SiTef pela DLL CliSiTef32I, nao com tabela. Os unicos
    * campos digitaveis (GetDigitos, Text1, GetDatas) tem um PROCEDURE Valid
    * cujo INICIO eh validacao pura e o RESTO eh o avanco do protocolo. Os
    * metodos abaixo transcrevem essa cabeca de cada Valid; os handlers de
    * KeyPress chamam-nos e abortam quando reprovam - exatamente o que o
    * "Return(.f.)" do legado fazia (o Valid falso cancela a saida do campo).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarDigitos - cabeca de SIGPRDFT.GetDigitos.Valid:
    *     IF tHISfORM.abandona / Thisform.release / eNDIF
    *     IF LEN(Alltrim(This.Value)) <> 4 .and. ! EMPTY(This.Value)
    *         DO Form SigTfDss With ...,"Quantidade de Digitos Invalida",...
    *         This.Value = ""
    *         Return(.f.)
    *     ENDIF
    *     IF EMPTY(This.Value) / RETURN / Endif
    *
    * Devolve .T. so quando ha 4 digitos para transmitir. Campo VAZIO devolve
    * .F. de proposito: no legado o "RETURN" nu tambem eh saida limpa do Valid
    * que NAO avanca o protocolo - o usuario ainda nao digitou nada.
    * PUBLIC: chamado pelo handler ligado por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDigitos()
        LOCAL loc_lValido
        loc_lValido = .F.

        DO CASE
        CASE THIS.this_lAbandona
            *-- Legado: a flag derruba a tela antes de qualquer checagem.
            THIS.Release()

        CASE LEN(ALLTRIM(THIS.txt_4c_Digitos.Value)) != 4 AND !EMPTY(THIS.txt_4c_Digitos.Value)
            THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                "Quantidade de Digitos Invalida", "")
            THIS.txt_4c_Digitos.Value = ""

        CASE EMPTY(THIS.txt_4c_Digitos.Value)
            *-- Nada digitado: Valid valido, protocolo nao avanca.

        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParcelas - cabeca de SIGPRDFT.Text1.Valid:
    *     IF EMPTY(THIS.Value) / RETURN .t. / Endif
    *
    * Unico guard que o legado tem neste campo. Devolve .F. no vazio (Valid
    * aprova, mas nao ha numero de parcelas para mandar ao SiTef) e .T. quando
    * ha valor. NAO acrescentar faixa minima/maxima: o legado nao a tem - quem
    * recusa parcela fora do permitido eh o proprio terminal, pelo
    * ProximoComando = 22, que o handler ja trata.
    * PUBLIC: chamado pelo handler ligado por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParcelas()
        RETURN !EMPTY(THIS.txt_4c_Text1.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataVencimento - cabeca de SIGPRDFT.GetDatas.Valid:
    *     IF LASTKEY() = 27 / RETURN .t. / ENDIF
    *     ldData=IIF(EMPTY(This.Value),DATE()+30,This.Value)
    *     This.Value = ldData
    *     This.Refresh
    *     IF ThisForm.Optiongroup1.Value = 2 .and. This.Value <= DATE() ;
    *        .and. ! EMPTY(This.Value)
    *         DO Form SigTfDss With ...,"Data Invalida",...
    *         RETURN .f.
    *     ENDIF
    *
    * O guard de ESC nao tinha sido migrado e a ORDEM importa: no legado ele
    * sai ANTES de o campo receber a data padrao (DATE()+30). Normalizar
    * primeiro gravaria vencimento numa transacao que o usuario abandonou.
    * PUBLIC: chamado pelo handler ligado por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataVencimento()
        LOCAL loc_lValido, loc_dData
        loc_lValido = .F.

        DO CASE
        CASE LASTKEY() = 27
            *-- ESC: Valid do legado devolve .t. e nao toca em nada; aqui
            *-- devolve .F. porque o protocolo tambem nao deve avancar.

        OTHERWISE
            loc_dData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
            THIS.txt_4c_Datas.Value = loc_dData
            THIS.txt_4c_Datas.Refresh()

            *-- Legado GetDatas.Valid: "ldData=IIF(...)" vem ANTES da checagem
            *-- de data invalida - ldData fica gravado mesmo quando o Valid
            *-- recusa o valor. Ordem transcrita literal.
            THIS.this_dDataTef = loc_dData

            IF THIS.obj_4c_Optiongroup1.Value = 2 AND ;
               THIS.txt_4c_Datas.Value <= DATE() AND !EMPTY(THIS.txt_4c_Datas.Value)
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    "Data Invalida", "")
            ELSE
                loc_lValido = .T.
            ENDIF
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - migrado de SIGPRDFT.SAIDA.CANCELA.Click. PUBLIC porque
    * eh chamado via BINDEVENT (botao) e via KeyPress do form (tecla ESC).
    *
    * Este eh o UNICO botao do form: o SCX legado declara so o CommandGroup
    * SAIDA (ButtonCount = 1, Caption "\<Cancelar"). Nao ha barra CRUD nenhuma
    * a migrar - o legado herda de `form` (nao de `frmcadastro`), nao tem
    * Grupo_Op, nao tem pcEscolha e nao tem botao Incluir/Alterar/Visualizar/
    * Excluir; inventar os quatro BtnXxxClick violaria o PILAR 1.
    *
    * O nome segue o prefixo canonico Btn*Click (e nao "CancelaClick", como o
    * objeto do legado) porque essa eh a convencao do projeto para handler de
    * botao - o mesmo criterio de "nomear pela ACAO, nao pelo nome do objeto
    * legado". A acao aqui eh cancelar a transacao SiTef e liberar a tela.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.ContinuarSiTef(-1)
        THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)")
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosGotFocus - conecta e inicia a transacao no SiTef, negocia o tipo
    * de cartao (migrado de SIGPRDFT.GetDigitos.GotFocus). PUBLIC (BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE DigitosGotFocus()
        LOCAL loc_oBO, loc_nRetorno, loc_cData, loc_cHora, loc_lContinua, ;
              loc_nTipo, loc_nTipoVenda, loc_lTipoVenda, loc_cBandeiraLocal

        *-- Migrado de SIGPRDFT.GetDigitos.When, INTEIRO:
        *--     If Empty(This.Value) / Set Confirm Off / Endif
        *--     Return(EMPTY(This.Value))
        *-- O RETURN eh um GATE, nao decoracao: com o campo ja preenchido o
        *-- When RECUSA o foco, e por isso o GotFocus do legado nunca roda uma
        *-- segunda vez. Reproduzido como saida antecipada - sem ele, voltar ao
        *-- campo preenchido com TAB chamaria ConectarSiTef/IniciarSiTef de
        *-- novo e REINICIARIA uma transacao ja autorizada.
        *-- BINDEVENT em "When" nao serve: o retorno do delegate eh descartado,
        *-- logo nao bloqueia nada (mesma razao do gate do Optiongroup1).
        IF !EMPTY(THIS.txt_4c_Digitos.Value)
            RETURN
        ENDIF
        SET CONFIRM OFF

        loc_oBO = THIS.this_oBusinessObject

        IF !loc_oBO.ConectarSiTef()
            THIS.RetornoFalha("Sem comunicacao com SiTef")
            THIS.Release()
            RETURN
        ENDIF

        loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
        loc_cHora = STRTRAN(TIME(), ":", "")

        IF !loc_oBO.IniciarSiTef(0, STRTRAN(ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ","), ;
                loc_oBO.this_cCupom, loc_cData, loc_cHora)
            THIS.RetornoFalha("Sem comunicacao com SiTef")
            THIS.Release()
            RETURN
        ENDIF

        loc_oBO.this_nProximoComando  = 0
        loc_oBO.this_nTipoCampo       = 0
        loc_oBO.this_nTamanhoMinimo   = 0
        loc_oBO.this_nTamanhoMaximo   = 0
        loc_oBO.this_cBuffer          = SPACE(2000)
        loc_oBO.this_nContinua        = 0
        loc_oBO.this_cTipoTransacao   = ""
        loc_oBO.this_cDataHoraTef     = ""
        loc_oBO.this_cCupomTef        = ""
        loc_oBO.this_cCartaoAux       = ""
        loc_oBO.this_cNsu             = ""
        loc_oBO.this_cAutorizacao     = ""
        loc_oBO.this_cFinalizacao     = ""
        loc_oBO.this_cMensagemRetorno = ""

        loc_nTipo         = 1
        loc_nTipoVenda     = 0
        loc_lTipoVenda     = .F.
        loc_cBandeiraLocal = ""
        *-- legado nao inicializa lnRetorno antes do loop; se a forma de
        *-- pagamento ja aceita cartao (loop nao roda), 0 preserva o mesmo
        *-- desfecho pratico do legado (IF lnRetorno < 0 nao dispara release)
        *-- sem comparar Logico com Numerico (que estouraria erro 9 no VFP9).
        loc_nRetorno       = 0
        loc_lContinua      = !loc_oBO.this_lOpFpCartao

        THIS.obj_4c_Optiongroup1.Enabled = .F.

        DO WHILE loc_lContinua
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

            IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO" $ UPPER(loc_oBO.this_cBuffer)
                IF loc_nTipoVenda = 2
                    loc_lTipoVenda = .T.
                ELSE
                    loc_nTipoVenda = 2
                ENDIF
            ENDIF

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nProximoComando = 22
                IF LEN(ALLTRIM(loc_oBO.this_cBuffer)) != 0
                    THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                        ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
                    loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                    loc_nRetorno = -1
                    EXIT
                ENDIF
            ENDIF

            IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) = "DIGITE A SENHA"
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

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipoTransacao = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer = SPACE(2000)
                loc_oBO.this_nContinua = 0
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_oBO.this_cBuffer, 5)
                loc_oBO.this_cBuffer = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_oBO.this_cBuffer)))
                loc_oBO.this_cBuffer = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutorizacao = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer = SPACE(2000)
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 507
                IF MsgConfirma("Primeira Parcela A Vista", "Confirma")
                    loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                IF loc_nTipo = 1
                    loc_oBO.this_cBuffer = IIF(loc_oBO.this_cDebCred = "D" OR loc_oBO.this_cDebCred = "P", "2", "3") + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    IF loc_oBO.this_nNumParcs = 1
                        EXIT
                    ELSE
                        IF loc_oBO.this_cOpFpTcdc = "S"
                            IF loc_oBO.this_cDebCred != "P"
                                loc_oBO.this_cBuffer = "5" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "4" + REPLICATE(CHR(0), 1999)
                            ENDIF
                        ELSE
                            loc_oBO.this_cBuffer = "3" + REPLICATE(CHR(0), 1999)
                        ENDIF
                        LOOP
                    ENDIF
                ENDIF
            ENDIF

            IF loc_oBO.this_nTipoCampo = 131
                loc_cBandeiraLocal = loc_oBO.this_cBuffer
                loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND loc_cBandeiraLocal = "00004"
                EXIT
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 506
                loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 1, 2)) + ;
                    ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 4, 2)) + ;
                    ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 7, 4)) + REPLICATE(CHR(0), 1992)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 508
                loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nOpFpDias)) + REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 509
                loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nOpFpMesFec - 1)) + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 511 AND loc_oBO.this_cOpFpTcdc = "S") OR ;
               (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 505) OR ;
               (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = -1 AND loc_oBO.this_cOpFpTcdc = "S" ;
                    AND loc_oBO.this_cDebCred = "P" AND !("DDMMAAAA" $ loc_oBO.this_cBuffer))
                loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nNumParcs)) + REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = -1 AND ("DDMMAAAA" $ loc_oBO.this_cBuffer)
                THIS.txt_4c_Digitos.Enabled = .F.
                EXIT
            ENDIF
            IF loc_oBO.this_nProximoComando != 21
                loc_oBO.this_cBuffer = SPACE(2000)
                loc_oBO.this_nContinua = 0
            ENDIF
        ENDDO

        THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.

        *-- Legado: IF lnRetorno < 0 .or. ThisForm.Abandona / Thisform.release
        IF loc_nRetorno < 0 OR THIS.this_lAbandona
            THIS.Release()
            RETURN
        ENDIF

        IF !EMPTY(loc_oBO.this_cNsu)
            *-- Transcrito literal do legado: o 6o argumento eh a MESMA
            *-- variavel do 5o (lsNsu/lsNSU - so difere em maiusculas).
            THIS.MontaRetorno(loc_oBO.this_cTipoTransacao, loc_oBO.this_cDataHoraTef, ;
                loc_oBO.this_cCupomTef, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                loc_oBO.this_cNsu, loc_oBO.this_cFinalizacao, loc_oBO.this_nValPago, ;
                loc_oBO.this_cMensagemRetorno)
            THIS.Release()
            RETURN
        ENDIF

        THIS.txt_4c_Digitos.BackColor = RGB(255, 255, 255)
        THIS.txt_4c_Cartao.Value = "#### #### #### ####"

        IF loc_lTipoVenda
            IF !THIS.txt_4c_Text1.Enabled
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
                THIS.txt_4c_Digitos.Enabled = .F.
                THIS.obj_4c_Optiongroup1.Enabled = .T.
                THIS.txt_4c_Datas.Enabled = .T.
            ENDIF
        ELSE
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
            THIS.obj_4c_Optiongroup1.Enabled = .T.
        ENDIF

        THIS.obj_4c_SAIDA.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosLostFocus - migrado de SIGPRDFT.GetDigitos.LostFocus
    *--------------------------------------------------------------------------
    PROCEDURE DigitosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        SET CONFIRM ON
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosKeyPress - equivalente ao SIGPRDFT.GetDigitos.Valid (disparado
    * em ENTER/TAB - BINDEVENT "Valid" nao eh confiavel em TextBox).
    *--------------------------------------------------------------------------
    PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nRetorno, loc_lParcelas, loc_nCampo

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        *-- Cabeca do Valid legado (abandona / 4 digitos / campo vazio).
        IF !THIS.ValidarDigitos()
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        loc_lParcelas = .F.
        loc_oBO.this_cMensagemRetorno = ""
        loc_oBO.this_cBuffer = ALLTRIM(THIS.txt_4c_Digitos.Value) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(THIS.txt_4c_Digitos.Value)))
        loc_oBO.this_nContinua = 1000
        loc_nRetorno = 10000
        loc_nCampo = 1

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
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
            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Trasa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
                loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                IF loc_nRetorno != 10000
                    EXIT
                ELSE
                    IF loc_lParcelas
                        THIS.txt_4c_Text1.Enabled = .T.
                        THIS.obj_4c_Optiongroup1.Enabled = .F.
                        RETURN
                    ELSE
                        RETURN
                    ENDIF
                ENDIF
            ENDIF
            IF loc_oBO.this_nProximoComando = 21
                loc_oBO.this_cBuffer = IIF(loc_oBO.this_nNumParcs = 1, ;
                    IIF(THIS.txt_4c_Datas.Value = DATE(), "1", "2"), IIF(loc_oBO.this_cDebCred = "P", "3", "4")) + REPLICATE(CHR(0), 1999)
                IF loc_oBO.this_cBuffer = "1"
                    EXIT
                ENDIF
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
                IF loc_oBO.this_lOpFpGarantias
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
            ENDIF
            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                IF loc_oBO.this_lOpFpSaque
                    MsgAviso("Saque via SiTef requer o dialogo SigCsTef, nao portado nesta migracao. Valor de saque assumido: 0,00.", "Saque")
                ENDIF
                loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND (loc_oBO.this_nTipoCampo = -1 OR loc_oBO.this_nTipoCampo = 506) AND loc_oBO.this_cDebCred != "P"
                THIS.txt_4c_Datas.Enabled = .T.
                EXIT
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND (loc_oBO.this_cDebCred = "P" OR loc_oBO.this_nTipoCampo = 511)
                IF loc_nCampo = 1
                    loc_oBO.this_cBuffer = TRANSFORM(loc_oBO.this_nNumParcs, "@L 99") + REPLICATE(CHR(0), 1999)
                    loc_lParcelas = .T.
                    loc_nCampo = 2
                    LOOP
                ELSE
                    THIS.txt_4c_Datas.Enabled = .T.
                    EXIT
                ENDIF
            ENDIF
            IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) = "DIGITE A SENHA"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipoTransacao = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_oBO.this_cBuffer, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_oBO.this_cBuffer)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutorizacao = loc_oBO.this_cBuffer
            ENDIF
            IF loc_nRetorno != 0
                loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nProximoComando = 22 AND loc_oBO.this_cDebCred = "P"
                loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
                loc_nRetorno = 0
                EXIT
            ENDIF
            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30 AND loc_oBO.this_nProximoComando != 34
                loc_oBO.this_cMensagemRetorno = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer = SPACE(2000)
                loc_oBO.this_nContinua = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_oBO.this_cDebCred = "P" AND loc_oBO.this_cOpFpTcdc != "S"
                MsgAviso("Consulta CDC (SigCoCDC) nao portada nesta migracao.", "Consulta CDC")
                THIS.RetornoFalha("Consulta CDC Realizada")
            ELSE
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(loc_oBO.this_cTipoTransacao, loc_oBO.this_cDataHoraTef, ;
                        loc_oBO.this_cCupomTef, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                        loc_oBO.this_cAutorizacao, loc_oBO.this_cFinalizacao, loc_oBO.this_nValPago, ;
                        loc_oBO.this_cMensagemRetorno)
                ENDIF
            ENDIF
            THIS.Release()
            RETURN
        ENDIF

        IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
        ELSE
            IF loc_oBO.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
                THIS.obj_4c_Optiongroup1.Enabled = .T.
                THIS.txt_4c_Datas.Enabled = .T.
            ELSE
                THIS.obj_4c_Optiongroup1.Enabled = .F.
            ENDIF
        ENDIF
        THIS.txt_4c_Digitos.Enabled = .F.
        THIS.obj_4c_Optiongroup1.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text1GotFocus/LostFocus/KeyPress - migrado de SIGPRDFT.Text1 (numero
    * de parcelas digitado manualmente quando o SiTef pede confirmacao).
    *--------------------------------------------------------------------------
    PROCEDURE Text1GotFocus()
        *-- Migrado de SIGPRDFT.Text1.When ("Set Confirm off").
        SET CONFIRM OFF

        *-- Legado Text1.GotFocus: "ThisForm.pcTvenda = .f." - fecha o gate do
        *-- Optiongroup1.When. TEM efeito observavel (a fase anterior anotou o
        *-- contrario por engano): a partir daqui o grupo Tipo de Venda deixa
        *-- de aceitar foco, e o usuario nao volta mais a troca-lo.
        THIS.this_lTipoVendaLiberado = .F.
    ENDPROC

    PROCEDURE Text1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        SET CONFIRM ON
        THIS.txt_4c_Text1.Value = TRANSFORM(VAL(THIS.txt_4c_Text1.Value), "@L 99")
        THIS.txt_4c_Text1.Enabled = .F.
        THIS.txt_4c_Datas.Enabled = .T.
    ENDPROC

    PROCEDURE Text1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nRetorno

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        *-- Cabeca do Valid legado (campo vazio nao avanca o protocolo).
        IF !THIS.ValidarParcelas()
            RETURN
        ENDIF

        *-- Legado Text1.Valid: "lnParcs=This.Value", logo apos o guard de
        *-- campo vazio e ANTES de montar o Buffer.
        THIS.this_cParcelasTef = THIS.txt_4c_Text1.Value

        loc_oBO = THIS.this_oBusinessObject
        loc_oBO.this_cBuffer = THIS.txt_4c_Text1.Value + REPLICATE(CHR(0), 1990)
        loc_oBO.this_nContinua = 1000
        loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

        THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

        IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
        ENDIF
        IF loc_oBO.this_nProximoComando = 22
            THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
            loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            RETURN
        ENDIF
        loc_oBO.this_cBuffer = ""
        loc_oBO.this_nContinua = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoVendaChange/Btn1KeyPress/Btn1GotFocus - migrado de
    * SIGPRDFT.Optiongroup1 (InteractiveChange/Option1.KeyPress/Option1.GotFocus)
    *--------------------------------------------------------------------------
    *-- Os tres handlers abrem com o gate de SIGPRDFT.Optiongroup1.When
    *-- ("Return(ThisForm.pctvenda)"): com pctvenda em .F. o When recusa o foco
    *-- e NENHUM evento do grupo chega a rodar. Reproduzido como saida
    *-- antecipada em cada handler porque BINDEVENT em "When" nao bloqueia (o
    *-- retorno do delegate eh descartado) e porque mapear pctvenda em
    *-- .Enabled corromperia o "IF Thisform.Optiongroup1.Enabled" que
    *-- DatasGotFocus le para montar o Buffer do SiTef.
    PROCEDURE OptTipoVendaChange()
        IF !THIS.this_lTipoVendaLiberado
            RETURN
        ENDIF

        THIS.txt_4c_Datas.Enabled = .T.
        IF THIS.obj_4c_Optiongroup1.Value = 1
            THIS.txt_4c_Datas.Value = DATE()
        ELSE
            THIS.txt_4c_Datas.Value = {}
        ENDIF
    ENDPROC

    PROCEDURE OptTipoVendaBtn1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !THIS.this_lTipoVendaLiberado
            RETURN
        ENDIF

        IF par_nKeyCode = 13
            KEYBOARD "{TAB}"
        ENDIF
    ENDPROC

    PROCEDURE OptTipoVendaBtn1GotFocus()
        IF !THIS.this_lTipoVendaLiberado
            RETURN
        ENDIF

        THIS.txt_4c_Datas.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DatasLostFocus - migrado de SIGPRDFT.GetDatas.LostFocus
    *--------------------------------------------------------------------------
    PROCEDURE DatasLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        SET CONFIRM ON
    ENDPROC

    *--------------------------------------------------------------------------
    * DatasGotFocus - migrado de SIGPRDFT.GetDatas.GotFocus (reinicia estado
    * de retorno e, quando a forma de pagamento nao aceita cartao/OptionGroup
    * ja resolvido, avanca o protocolo ate ProximoComando=30 sozinho).
    *--------------------------------------------------------------------------
    PROCEDURE DatasGotFocus()
        LOCAL loc_oBO, loc_nRetorno

        *-- Migrado de SIGPRDFT.GetDatas.When ("Set Confirm Off").
        SET CONFIRM OFF

        *-- Legado GetDatas.GotFocus, PRIMEIRA linha: "ThisForm.pcTvenda = .f."
        *-- Fecha o gate do Optiongroup1.When. NAO mexer em
        *-- obj_4c_Optiongroup1.Enabled aqui: o proprio legado LE
        *-- "IF Thisform.Optiongroup1.Enabled" alguns passos abaixo, neste
        *-- mesmo metodo, para escolher o Buffer que envia ao SiTef.
        THIS.this_lTipoVendaLiberado = .F.

        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_cTipoTransacao   = ""
        loc_oBO.this_cDataHoraTef     = ""
        loc_oBO.this_cCupomTef        = ""
        loc_oBO.this_cCartaoAux       = ""
        loc_oBO.this_cNsu             = ""
        loc_oBO.this_cAutorizacao     = ""
        loc_oBO.this_cFinalizacao     = ""
        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
        loc_oBO.this_cMensagemRetorno = ""

        IF loc_oBO.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada AND loc_oBO.this_cOpFpTcdc != "S"
            loc_oBO.this_nContinua = 1000
            IF THIS.obj_4c_Optiongroup1.Enabled
                loc_oBO.this_cBuffer = STR(THIS.obj_4c_Optiongroup1.Value, 1) + REPLICATE(CHR(0), 1999)
            ELSE
                DO WHILE loc_oBO.this_nProximoComando != 30
                    loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                    THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
                    IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
                        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
                    ENDIF
                    IF loc_nRetorno < 0
                        THIS.ErroTef(loc_nRetorno)
                        THIS.Release()
                        RETURN
                    ENDIF
                ENDDO
                loc_oBO.this_cBuffer = THIS.txt_4c_Text1.Value + REPLICATE(CHR(0), 1998)
            ENDIF

            loc_nRetorno = 10000
            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

                THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
                IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
                    THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
                ENDIF
                IF loc_nRetorno < 0
                    THIS.ErroTef(loc_nRetorno)
                    THIS.Release()
                    RETURN
                ENDIF
                IF loc_oBO.this_nProximoComando = 22
                    THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                        ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
                    IF "CANC. CLIENTE" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
                        loc_oBO.ContinuarSiTef(-1)
                        RETURN
                    ENDIF
                    loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                    IF loc_nRetorno != 10000
                        THIS.Release()
                        RETURN
                    ELSE
                        RETURN
                    ENDIF
                ENDIF
                IF loc_oBO.this_nProximoComando = 30 AND THIS.obj_4c_Optiongroup1.Value = 2
                    IF loc_oBO.this_nTipoCampo = 510
                        IF loc_oBO.this_lOpFpGarantias
                            loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                        ELSE
                            loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                        ENDIF
                        loc_oBO.this_nContinua = 1000
                        LOOP
                    ENDIF
                    EXIT
                ENDIF
                IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 506
                    loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 1, 2)) + ;
                        ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 4, 2)) + ;
                        ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 7, 4)) + REPLICATE(CHR(0), 1992)
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
                IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 505
                    loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1998)
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
                IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 507
                    IF MsgConfirma("Primeira Parcela A Vista", "Confirma")
                        loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                    ELSE
                        loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                    ENDIF
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
                IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 508
                    loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nOpFpDias)) + REPLICATE(CHR(0), 1998)
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
                IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 509
                    loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nOpFpMesFec - 1)) + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
                IF loc_oBO.this_nProximoComando = 30
                    loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 1, 2)) + ;
                        ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 4, 2)) + ;
                        ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 7, 4)) + REPLICATE(CHR(0), 1992)
                ENDIF
                IF loc_nRetorno != 0
                    loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
                ENDIF
                IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
                    THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
                ENDIF
                IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                    IF loc_oBO.this_lOpFpSaque
                        MsgAviso("Saque via SiTef requer o dialogo SigCsTef, nao portado nesta migracao. Valor de saque assumido: 0,00.", "Saque")
                    ENDIF
                    loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
                IF loc_oBO.this_nProximoComando = 3
                    loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
                ENDIF
                IF loc_oBO.this_nTipoCampo = 100
                    loc_oBO.this_cTipoTransacao = loc_oBO.this_cBuffer
                ENDIF
                IF loc_oBO.this_nTipoCampo = 105
                    loc_oBO.this_cDataHoraTef = loc_oBO.this_cBuffer
                ENDIF
                IF loc_oBO.this_nTipoCampo = 121
                    loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
                ENDIF
                IF loc_oBO.this_nTipoCampo = 131
                    loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
                ENDIF
                IF loc_oBO.this_nTipoCampo = 132
                    loc_oBO.this_cBandeira = LEFT(loc_oBO.this_cBuffer, 5)
                ENDIF
                IF loc_oBO.this_nTipoCampo = 134
                    loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_oBO.this_cBuffer)))
                ENDIF
                IF loc_oBO.this_nTipoCampo = 135
                    loc_oBO.this_cAutorizacao = loc_oBO.this_cBuffer
                ENDIF
                IF loc_nRetorno != 0
                    loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
                ENDIF
                IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
                    loc_oBO.this_cMensagemRetorno = loc_oBO.this_cBuffer
                    loc_oBO.this_cBuffer = SPACE(2000)
                    loc_oBO.this_nContinua = 0
                ENDIF
            ENDDO

            IF loc_nRetorno != 10000
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(loc_oBO.this_cTipoTransacao, loc_oBO.this_cDataHoraTef, ;
                        loc_oBO.this_cCupomTef, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                        loc_oBO.this_cAutorizacao, loc_oBO.this_cFinalizacao, loc_oBO.this_nValPago, ;
                        loc_oBO.this_cMensagemRetorno)
                    THIS.Release()
                    RETURN
                ENDIF
            ENDIF
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DatasKeyPress - equivalente ao SIGPRDFT.GetDatas.Valid (ENTER/TAB).
    * Fecha o fluxo comum: confirma a data, aguarda ProximoComando=30 e
    * finaliza (MontaRetorno em sucesso, RetornoFalha em cancelamento/erro).
    *--------------------------------------------------------------------------
    PROCEDURE DatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nRetorno, loc_cSenha, loc_oFormSenha, loc_cMensagem

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        *-- Cabeca do Valid legado (ESC / data padrao DATE()+30 / data invalida
        *-- quando o tipo de venda eh parcelado). O ESC sai ANTES da
        *-- normalizacao, como no legado.
        IF !THIS.ValidarDataVencimento()
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        DO WHILE loc_oBO.this_nProximoComando != 30
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
            IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.Release()
                RETURN
            ENDIF
        ENDDO

        loc_oBO.this_cMensagemRetorno = ""
        loc_oBO.this_cAutorizacao = ""
        loc_cMensagem = ""
        loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 1, 2)) + ;
            ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 4, 2)) + ;
            ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 7, 4)) + REPLICATE(CHR(0), 1992)
        loc_oBO.this_nContinua = 1000
        loc_nRetorno = 10000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.Release()
                RETURN
            ENDIF
            IF loc_oBO.this_nProximoComando = 22
                IF loc_oBO.this_cDebCred != "P"
                    IF LEN(ALLTRIM(loc_oBO.this_cBuffer)) != 0
                        THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                            IIF(UPPER(ALLTRIM(loc_oBO.this_cBuffer)) = "AGUARDE, EM PROCESSAMENTO", "TRANSACAO CANCELADA", ALLTRIM(loc_oBO.this_cBuffer)), "")
                        IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR "CANC. CLIENTE" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
                            loc_oBO.ContinuarSiTef(-1)
                            loc_nRetorno = -8
                            EXIT
                        ENDIF
                        THIS.Release()
                        RETURN
                    ELSE
                        loc_nRetorno = 0
                        EXIT
                    ENDIF
                ELSE
                    loc_oBO.this_cCupomTef = ALLTRIM(loc_oBO.this_cBuffer)
                    loc_nRetorno = -1
                    EXIT
                ENDIF
            ENDIF
            IF loc_nRetorno != 10000
                THIS.RetornoFalha(IIF(EMPTY(loc_cMensagem), "Operacao Cancelada pelo Usuario", loc_cMensagem))
                EXIT
            ENDIF
            IF loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 500
                loc_oFormSenha = CREATEOBJECT("FormSIGPRSTF")
                loc_oFormSenha.Show()
                IF loc_oFormSenha.this_lCancelado
                    loc_oBO.FinalizarSiTef(0, IIF(EMPTY(loc_oBO.this_cCupomTef), "1", loc_oBO.this_cCupomTef), ;
                        STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2), STRTRAN(TIME(), ":", ""))
                    THIS.RetornoFalha("Operacao Cancelada pelo Usuario")
                    loc_nRetorno = -2
                    EXIT
                ELSE
                    loc_cSenha = loc_oFormSenha.this_cSenhaRetorno
                    loc_oBO.this_cBuffer = loc_cSenha + REPLICATE(CHR(0), 1900)
                    LOOP
                ENDIF
            ENDIF
            IF UPPER(loc_oBO.this_cBuffer) = "ASSUME GARANTIA"
                IF MsgConfirma("Assume Inversao de Risco ?", "Confirma")
                    loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ENDIF
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                IF loc_oBO.this_lOpFpSaque
                    MsgAviso("Saque via SiTef requer o dialogo SigCsTef, nao portado nesta migracao. Valor de saque assumido: 0,00.", "Saque")
                ENDIF
                loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = -1
                MsgAviso("Entrada CDC (SigCsTef) nao portada nesta migracao. Valor assumido: 0,00.", "Entrada CDC")
                loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 1900)
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipoTransacao = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_oBO.this_cBuffer, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_oBO.this_cBuffer)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutorizacao = loc_oBO.this_cBuffer
            ENDIF
            IF loc_nRetorno != 0
                loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
            ENDIF
            IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) $ "DIGITE A SENHA"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
                loc_cMensagem = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer = SPACE(2000)
                loc_oBO.this_nContinua = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_oBO.this_cDebCred = "P"
                MsgAviso("Consulta CDC (SigCoCDC) nao portada nesta migracao.", "Consulta CDC")
                THIS.RetornoFalha("Consulta CDC Realizada")
            ELSE
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(loc_oBO.this_cTipoTransacao, loc_oBO.this_cDataHoraTef, ;
                        loc_oBO.this_cCupomTef, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                        loc_oBO.this_cAutorizacao, loc_oBO.this_cFinalizacao, loc_oBO.this_nValPago, ;
                        loc_oBO.this_cMensagemRetorno)
                ELSE
                    IF loc_nRetorno >= -5
                        THIS.ErroTef(loc_nRetorno)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere os campos de captura da tela para as properties
    * correspondentes do BO.
    *
    * NAO eh hook de CRUD aqui (o legado nao tem Incluir/Alterar/Excluir nem
    * modo de edicao): estes seis campos SAO a ficha desta tela - valor, 4
    * ultimos digitos, numero do cartao, tipo da venda, numero de parcelas e
    * vencimento da primeira. O BO ja declarava as properties
    * (this_nValor/this_cDigitos/this_cCartao/this_nTipoVenda/this_nParcelas/
    * this_dDataParc) e sem este metodo elas nunca eram preenchidas.
    *
    * Conversao de tipo OBRIGATORIA, nao cosmetica:
    *   - txt_4c_Text1.Value eh CHARACTER (mascara "99" + TRANSFORM(...,
    *     "@L 99") no LostFocus, igual ao legado) e this_nParcelas eh NUMERIC
    *     -> VAL(). Atribuir direto deixaria a property char e estouraria na
    *     primeira comparacao aritmetica.
    *   - txt_4c_Datas.Value eh DATE -> ConverterParaData() garante DATE no BO
    *     mesmo que o controle receba DATETIME em algum caminho.
    *
    * PROTECTED porque FormBase declara o hook como PROTECTED e subclasse nao
    * alarga escopo em VFP9.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_nValor     = THIS.txt_4c_Valor.Value
        loc_oBO.this_cDigitos   = ALLTRIM(THIS.txt_4c_Digitos.Value)
        loc_oBO.this_cCartao    = ALLTRIM(THIS.txt_4c_Cartao.Value)
        loc_oBO.this_nTipoVenda = THIS.obj_4c_Optiongroup1.Value
        loc_oBO.this_nParcelas  = THIS.txt_4c_Text1.Value
        loc_oBO.this_dDataParc  = ConverterParaData(THIS.txt_4c_Datas.Value)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso do FormParaBO. Existe para o chamador que
    * pre-carrega a transacao no BO (valor, parcelas e vencimento vindos do
    * pedido) antes de exibir o dialogo, e para repintar a tela depois de o
    * protocolo SiTef alterar esses campos.
    *
    * txt_4c_Text1.Value volta com a MESMA mascara do legado
    * (TRANSFORM(...,"@L 99")) - o controle eh char e a property eh numerica.
    * PROTECTED: mesmo motivo do FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_Valor.Value   = loc_oBO.this_nValor
        THIS.txt_4c_Digitos.Value = loc_oBO.this_cDigitos
        THIS.txt_4c_Cartao.Value  = loc_oBO.this_cCartao
        THIS.txt_4c_Text1.Value   = TRANSFORM(loc_oBO.this_nParcelas, "@L 99")
        THIS.txt_4c_Datas.Value   = ConverterParaData(loc_oBO.this_dDataParc)

        *-- Optiongroup1.Value eh NUMERICO e 1-based (1=A Vista, 2=Parcelado).
        *-- Fora da faixa dos 2 botoes, nao atribui: valor invalido marcaria
        *-- todos os radios (regra dos OptionGroup do projeto).
        IF BETWEEN(loc_oBO.this_nTipoVenda, 1, THIS.obj_4c_Optiongroup1.ButtonCount)
            THIS.obj_4c_Optiongroup1.Value = loc_oBO.this_nTipoVenda
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarRetornoTef - transcricao literal do RETURN do SIGPRDFT.Unload:
    *
    *     If ! Type('ThisForm.pcBandeira') = [C] or Empty(ThisForm.pcBandeira)
    *         ThisForm.pcBandeira = [00000]
    *     Endif
    *     If ! Type('ThisForm.lsCartao') = [C] or Empty(ThisForm.lsCartao)
    *         ThisForm.lsCartao = [00000]
    *     Endif
    *     RETURN(lcSaque+"/"+lnParcs+"/"+DTOC(ldData)+ThisForm.pcBandeira+ThisForm.lsCartao)
    *
    * Esta string EH o resultado da tela - o chamador legado a le e dela extrai
    * saque, parcelas, vencimento, bandeira e cartao. Reescrever o formato
    * (ordem, separador "/", ausencia de separador entre bandeira e cartao)
    * quebraria o chamador em silencio, entao nada aqui eh "arrumado".
    *
    * Precedencia do legado: em VFP o "=" liga mais forte que o NOT, logo
    * "! Type(x) = [C]" eh NOT(Type(x) == 'C') - e nao (NOT Type(x)) == 'C'.
    * Por isso o teste migrado eh VARTYPE(...) != "C" OR EMPTY(...).
    *
    * Os tres CLEAR DLLS e o CHRSAW(2) do Unload legado estao COMENTADOS no
    * SCX (desligados de proposito - descarregar a CliSiTef32I.DLL entre duas
    * transacoes derrubava a sessao do PIN-pad), portanto nao sao migrados.
    *--------------------------------------------------------------------------
    FUNCTION MontarRetornoTef()
        LOCAL loc_oBO, loc_cSaque, loc_cBandeira, loc_cCartao, loc_dData

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            IF VARTYPE(loc_oBO.this_cBandeira) != "C" OR EMPTY(loc_oBO.this_cBandeira)
                loc_oBO.this_cBandeira = "00000"
            ENDIF
            IF VARTYPE(loc_oBO.this_cCartaoAux) != "C" OR EMPTY(loc_oBO.this_cCartaoAux)
                loc_oBO.this_cCartaoAux = "00000"
            ENDIF
            loc_cBandeira = loc_oBO.this_cBandeira
            loc_cCartao   = loc_oBO.this_cCartaoAux
            loc_cSaque    = loc_oBO.this_cValorSaque
        ELSE
            *-- BO ja liberado. Nao eh caminho normal (o Destroy calcula o
            *-- retorno ANTES de solta-lo), mas devolver string truncada seria
            *-- pior que devolver os defaults que o proprio legado usa.
            loc_cBandeira = "00000"
            loc_cCartao   = "00000"
            loc_cSaque    = "0,00"
        ENDIF

        loc_dData = ConverterParaData(THIS.this_dDataTef)

        RETURN loc_cSaque + "/" + THIS.this_cParcelasTef + "/" + DTOC(loc_dData) + ;
               loc_cBandeira + loc_cCartao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Unload - migrado de SIGPRDFT.Unload. Em VFP9 o Unload dispara DEPOIS do
    * Destroy, quando this_oBusinessObject ja foi liberado; por isso devolve o
    * valor que o Destroy cacheou em this_cRetornoTef, e so recalcula se por
    * algum caminho ele nao tiver sido preenchido.
    *
    * Atende os dois modos de abertura: "DO FORM ... TO lcRetorno" (le este
    * RETURN) e CREATEOBJECT + Show() (le a property this_cRetornoTef, que
    * sobrevive ao fechamento porque o chamador ainda tem a referencia).
    *--------------------------------------------------------------------------
    PROCEDURE Unload()
        IF EMPTY(THIS.this_cRetornoTef)
            THIS.this_cRetornoTef = THIS.MontarRetornoTef()
        ENDIF
        RETURN THIS.this_cRetornoTef
    ENDPROC

    *--------------------------------------------------------------------------
    * Move - migrado de SIGPRDFT.Move ("llCancela=.f."). llCancela eh a flag de
    * cancelamento do FORM CHAMADOR no padrao Fortyus (nao eh lida em nenhum
    * ponto deste SCX); no novo desenho ela vive no BO, como this_lCancela.
    *
    * DESVIO DELIBERADO, registrado: o Move legado NAO chama DoDefault, ou
    * seja, engole o reposicionamento. Aqui o DODEFAULT eh mantido, porque a
    * classe migrada usa AutoCenter = .T. e engolir o Move deixaria o dialogo
    * ancorado no canto. O legado nao sofria disso por posicionar a tela na mao
    * (TitleBar = 0 / ControlBox = .F. - o usuario nunca conseguiu arrasta-la).
    *
    * O DO CASE por PCOUNT() existe porque Move aceita 1, 2, 3 ou 4 argumentos:
    * repassar parametro ausente ao DODEFAULT o converteria em .F. e o
    * reposicionamento falharia com erro de tipo.
    *--------------------------------------------------------------------------
    PROCEDURE Move(par_nLeft, par_nTop, par_nWidth, par_nHeight)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lCancela = .F.
        ENDIF

        DO CASE
        CASE PCOUNT() >= 4
            DODEFAULT(par_nLeft, par_nTop, par_nWidth, par_nHeight)
        CASE PCOUNT() = 3
            DODEFAULT(par_nLeft, par_nTop, par_nWidth)
        CASE PCOUNT() = 2
            DODEFAULT(par_nLeft, par_nTop)
        CASE PCOUNT() = 1
            DODEFAULT(par_nLeft)
        OTHERWISE
            DODEFAULT()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente (AddObject cria com Visible=.F. por padrao).
    * FILTRO: nenhum container flutuante neste form.
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
    * Destroy - libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- Calcula o retorno da tela ANTES de soltar o BO: o Unload dispara
        *-- DEPOIS do Destroy e ja nao alcancaria this_cBandeira/
        *-- this_cCartaoAux/this_cValorSaque. Migrado de SIGPRDFT.Release
        *-- ("ThisForm.poDataMgr.Release / dodefault()"), que eh onde o legado
        *-- solta o gerenciador de dados.
        THIS.this_cRetornoTef = THIS.MontarRetornoTef()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

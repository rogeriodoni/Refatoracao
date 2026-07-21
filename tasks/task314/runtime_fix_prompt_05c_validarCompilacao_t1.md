# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\sigprnfeBO.prg: loc_cXmlPed = "<?xml version=""1.0"" encoding=""UTF-8""?>" + THIS.this_cChr +  "<consSitNFe versao=""4.00"">" + THIS.this_cChr +  "<tpAmb>" + loc_cAmb + "</tpAmb>" + THIS.this_cChr +  "<xServ>CONSULTAR</xServ>" + THIS.this_cChr +  "<chNFe>" + THIS.this_cId + "</chNFe>" + THIS.this_cChr +  "</consSitNFe>" | Error in line 943: Syntax error. | loc_cXmlCan = "<?xml version=""1.0"" encoding=""UTF-8""?>" + THIS.this_cChr +  "<cancNFe versao=""4.00"">" + THIS.this_cChr +  "<infCanc>" + THIS.this_cChr +  "<tpAmb>" + loc_cAmb + "</tpAmb>" + THIS.this_cChr +  "<xServ>CANCELAR</xServ>" + THIS.this_cChr +  "<chNFe>" + THIS.this_cId + "</chNFe>" + THIS.this_cChr +  "<nProt>" + THIS.this_cProt + "</nProt>" + THIS.this_cChr +  "<xJust>" + loc_cJust + "</xJust>" + THIS.this_cChr +  "</infCanc>" + THIS.this_cChr +  "</cancNFe>" | Error in line 1004: Syntax error. | loc_cXmlInu = "<?xml version=""1.0"" encoding=""UTF-8""?>" + THIS.this_cChr +  "<inutNFe versao=""4.00"" xmlns=""http://www.portalfiscal.inf.br/nfe"">" + THIS.this_cChr +  "<infInut Id=""ID" + loc_cId + """>" + THIS.this_cChr +  "<tpAmb>" + loc_cAmb + "</tpAmb>" + THIS.this_cChr +  "<xServ>INUTILIZAR</xServ>" + THIS.this_cChr +  "<cUF>" + loc_cUf + "</cUF>" + THIS.this_cChr +  "<ano>" + loc_cAno + "</ano>" + THIS.this_cChr +  "<CNPJ>" + ALLTRIM(par_cCnpj) + "</CNPJ>" + THIS.this_cChr +  "<mod>" + loc_cMod + "</mod>" + THIS.this_cChr +  "<serie>" + loc_cSer + "</serie>" + THIS.this_cChr +  "<nNFIni>" + loc_cNIni + "</nNFIni>" + THIS.this_cChr +  "<nNFFin>" + loc_cNFim + "</nNFFin>" + THIS.this_cChr +  "<xJust>Ocorreu uma falha no sistema que pulou a sequencia de numeracao</xJust>" + THIS.this_cChr +  "</infInut>" + THIS.this_cChr +  "</inutNFe>" | Error in line 1463: Syntax error. | 

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg):
*==============================================================================
* Formsigprnfe.prg - Processamento de NF-e
* Herda de: FormBase
* Tipo: OPERACIONAL (layout flat customizado, sem PageFrame)
* BO: sigprnfeBO
* Migrado de: SIGPRNFE.SCX (Framework Fortyus)
*==============================================================================
DEFINE CLASS Formsigprnfe AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    WindowType   = 1
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    DataSession  = 2
    KeyPreview   = .T.

    pMovimentacao      = ""
    pSerie             = ""
    this_cMensagemErro = ""

    *==========================================================================
    PROCEDURE Init(par_cMovimentacao, par_cSerie, par_cOperas)
    *==========================================================================
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprnfeBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigprnfeBO.", ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF VARTYPE(par_cMovimentacao) = "C"
                    THIS.pMovimentacao = ALLTRIM(par_cMovimentacao)
                ENDIF
                IF VARTYPE(par_cSerie) = "C"
                    THIS.pSerie = ALLTRIM(par_cSerie)
                ENDIF
                loc_lResultado = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.Caption = "Processamento de NF-e"
        TRY
            SET NULL ON
            IF USED("csOperacoes")
                USE IN csOperacoes
            ENDIF
            CREATE CURSOR csOperacoes (SelImp l(1), Emps c(3), Dopes c(20), ;
                Numes n(6,0), Datas d(8), Valos n(12,2), Notas c(10), Series c(3), ;
                NFMemo m(4), Erros m(4), Tipos n(1), stats c(3), ids c(47), ;
                lotes c(15), recibos c(15), prots c(15), statts c(1))
            INDEX ON Notas+Emps+Dopes+STR(Numes,6) TAG Notas
            SET NULL OFF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarOperacoes()
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoesForm()
            THIS.ConfigurarBotoesGrade()
            THIS.ConfigurarCntInu()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarBINDEVENTs()

            IF !EMPTY(THIS.pMovimentacao)
                THIS.BtnSelecionarClick(.T.)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar form")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_cCaption, loc_oCnt
        loc_cCaption = "Processamento de NF-e"
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1004
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = loc_cCaption
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = THIS.Width
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = loc_cCaption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = THIS.Width
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOperacoes()
    *==========================================================================
        LOCAL loc_oCnt, loc_oOpt

        THIS.AddObject("cnt_4c_Operacoes", "Container")
        loc_oCnt = THIS.cnt_4c_Operacoes
        WITH loc_oCnt
            .Top         = 83
            .Left        = 4
            .Width       = 824
            .Height      = 161
            .BorderWidth = 1
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
        ENDWITH

        *-- Labels descritivos
        loc_oCnt.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oCnt.lbl_4c_LblEmpresa
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 35
            .Top       = 6
            .Width     = 55
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSerie", "Label")
        WITH loc_oCnt.lbl_4c_LblSerie
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "S" + CHR(233) + "rie :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 135
            .Top       = 6
            .Width     = 40
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDtEmis", "Label")
        WITH loc_oCnt.lbl_4c_LblDtEmis
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Data de Emiss" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 223
            .Top       = 6
            .Width     = 105
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblAte", "Label")
        WITH loc_oCnt.lbl_4c_LblAte
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 416
            .Top       = 6
            .Width     = 10
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblNotas", "Label")
        WITH loc_oCnt.lbl_4c_LblNotas
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Notas Fiscais :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 14
            .Top       = 33
            .Width     = 75
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblMovimento", "Label")
        WITH loc_oCnt.lbl_4c_LblMovimento
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Movimento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 517
            .Top       = 6
            .Width     = 61
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblAmbiente", "Label")
        WITH loc_oCnt.lbl_4c_LblAmbiente
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Ambiente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 31
            .Top       = 59
            .Width     = 54
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblVersao", "Label")
        WITH loc_oCnt.lbl_4c_LblVersao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Vers" + CHR(227) + "o: 2.0.4"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 283
            .Top       = 61
            .Width     = 100
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblImpressao", "Label")
        WITH loc_oCnt.lbl_4c_LblImpressao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 499
            .Top       = 59
            .Width     = 65
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSituacao", "Label")
        WITH loc_oCnt.lbl_4c_LblSituacao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 35
            .Top       = 83
            .Width     = 50
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblRegime", "Label")
        WITH loc_oCnt.lbl_4c_LblRegime
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Regime Tribut" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 465
            .Top       = 83
            .Width     = 93
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblAcao", "Label")
        WITH loc_oCnt.lbl_4c_LblAcao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "A" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 52
            .Top       = 107
            .Width     = 33
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblInuDe", "Label")
        WITH loc_oCnt.lbl_4c_LblInuDe
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Inutilizar de :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 493
            .Top       = 108
            .Width     = 75
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblInuAte", "Label")
        WITH loc_oCnt.lbl_4c_LblInuAte
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 672
            .Top       = 108
            .Width     = 10
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblConting", "Label")
        WITH loc_oCnt.lbl_4c_LblConting
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Conting" + CHR(234) + "ncia :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 14
            .Top       = 146
            .Width     = 75
        ENDWITH

        *-- TextBoxes de filtro
        loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oCnt.txt_4c_Emps
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 93
            .Top           = 2
            .Width         = 34
            .MaxLength     = 3
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Series", "TextBox")
        WITH loc_oCnt.txt_4c_Series
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 178
            .Top           = 2
            .Width         = 34
            .MaxLength     = 3
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oCnt.txt_4c_DtIni
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 331
            .Top           = 2
            .Width         = 82
            .Value         = {}
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DtFin", "TextBox")
        WITH loc_oCnt.txt_4c_DtFin
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 428
            .Top           = 2
            .Width         = 82
            .Value         = {}
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Arquivos", "TextBox")
        WITH loc_oCnt.txt_4c_Arquivos
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 93
            .Top           = 29
            .Width         = 636
            .ReadOnly      = .T.
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_InuIni", "TextBox")
        WITH loc_oCnt.txt_4c_InuIni
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 572
            .Top           = 104
            .Width         = 91
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_InuFim", "TextBox")
        WITH loc_oCnt.txt_4c_InuFim
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 687
            .Top           = 104
            .Width         = 91
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_IniContin", "TextBox")
        WITH loc_oCnt.txt_4c_IniContin
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 20
            .Left          = 361
            .Top           = 141
            .Width         = 80
            .Value         = {}
            .SpecialEffect = 1
        ENDWITH

        *-- ComboBox Regime Tributario
        loc_oCnt.AddObject("cmb_4c_Regime", "ComboBox")
        WITH loc_oCnt.cmb_4c_Regime
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 22
            .Left          = 572
            .Top           = 79
            .Width         = 206
            .RowSourceType = 1
            .RowSource     = "Simples Nacional,Lucro Presumido,Lucro Real,Lucro Arbitrado"
            .Style         = 2
        ENDWITH

        *-- CheckBoxes
        loc_oCnt.AddObject("chk_4c_OptArq", "CheckBox")
        WITH loc_oCnt.chk_4c_OptArq
            .Caption   = "Usar TXT-ALT"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 17
            .Left      = 566
            .Top       = 129
            .Width     = 103
            .Value     = 0
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("chk_4c_HVerao", "CheckBox")
        WITH loc_oCnt.chk_4c_HVerao
            .Caption   = "Hor" + CHR(225) + "rio de Ver" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 17
            .Left      = 682
            .Top       = 128
            .Width     = 121
            .Value     = 0
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Venc", "CheckBox")
        WITH loc_oCnt.chk_4c_Venc
            .Caption   = "Venc Futuros"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 17
            .Left      = 726
            .Top       = 58
            .Width     = 121
            .Value     = 0
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("chk_4c_OptSub", "CheckBox")
        WITH loc_oCnt.chk_4c_OptSub
            .Caption   = "Subst. C" + CHR(243) + "digo do Produto por Refer" + CHR(234) + "ncia"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 566
            .Top       = 145
            .Width     = 215
            .Value     = 0
            .BackStyle = 0
        ENDWITH

        *-- Botao "..." inutilizacao (oculto por padrao)
        loc_oCnt.AddObject("cmd_4c_Inu", "CommandButton")
        WITH loc_oCnt.cmd_4c_Inu
            .Caption = "..."
            .Height  = 22
            .Left    = 779
            .Top     = 105
            .Width   = 29
            .Visible = .F.
        ENDWITH

        *-- OptionGroups com WITH ANINHADO
        loc_oCnt.AddObject("opt_4c_Processados", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Processados
        WITH loc_oOpt
            .ButtonCount = 2
            .Top         = 83
            .Left        = 89
            .Width       = 235
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "N" + CHR(227) + "o Processados"
                .Width     = 115
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "J" + CHR(225) + " Processados"
                .Width     = 115
                .Left      = 118
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Tipos", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Tipos
        WITH loc_oOpt
            .ButtonCount = 2
            .Top         = 6
            .Left        = 590
            .Width       = 142
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Sa" + CHR(237) + "da"
                .Width     = 65
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Entrada"
                .Width     = 65
                .Left      = 68
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Ambiente", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Ambiente
        WITH loc_oOpt
            .ButtonCount = 2
            .Top         = 54
            .Left        = 89
            .Width       = 173
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Produ" + CHR(231) + CHR(227) + "o"
                .Width     = 85
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Homologa" + CHR(231) + CHR(227) + "o"
                .Width     = 85
                .Left      = 88
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Impressao", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Impressao
        WITH loc_oOpt
            .ButtonCount = 3
            .Top         = 59
            .Left        = 569
            .Width       = 151
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Retrato"
                .Width     = 48
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Paisagem"
                .Width     = 55
                .Left      = 50
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Sem"
                .Width     = 44
                .Left      = 107
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Acao", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Acao
        WITH loc_oOpt
            .ButtonCount = 7
            .Top         = 101
            .Left        = 92
            .Width       = 397
            .Height      = 38
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Enviar"
                .Width     = 55
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Consultar"
                .Width     = 60
                .Left      = 57
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Cancelar"
                .Width     = 58
                .Left      = 119
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Inutilizar"
                .Width     = 60
                .Left      = 179
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "PDF"
                .Width     = 36
                .Left      = 241
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "E-mail"
                .Width     = 48
                .Left      = 279
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(7)
                .Caption   = "Status"
                .Width     = 48
                .Left      = 329
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Contin", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Contin
        WITH loc_oOpt
            .ButtonCount = 3
            .Top         = 140
            .Left        = 92
            .Width       = 258
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Nenhuma"
                .Width     = 75
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "EPEC"
                .Width     = 52
                .Left      = 77
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "SCAN/SVC"
                .Width     = 75
                .Left      = 131
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        LOCAL loc_oCnt, loc_oGrd

        THIS.AddObject("cnt_4c_Grade", "Container")
        loc_oCnt = THIS.cnt_4c_Grade
        WITH loc_oCnt
            .Top         = 247
            .Left        = 50
            .Width       = 820
            .Height      = 344
            .BorderWidth = 1
            .BackStyle   = 1
            .BackColor   = RGB(220, 220, 220)
        ENDWITH

        loc_oCnt.AddObject("grd_4c_Operacoes", "Grid")
        loc_oGrd = loc_oCnt.grd_4c_Operacoes
        WITH loc_oGrd
            .Top           = 1
            .Left          = 3
            .Width         = 813
            .Height        = 340
            .ColumnCount   = 9
            .RecordSource  = "csOperacoes"
            .ReadOnly      = .T.
            .GridLines     = 1
            .GridLineWidth = 1
            .HeaderHeight  = 22
            .RowHeight     = 20
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- Column1: selecao (CheckBox com Sparse=.F.)
        WITH loc_oGrd.Column1
            .Width         = 25
            .ReadOnly      = .F.
            .ControlSource = "csOperacoes.SelImp"
        ENDWITH
        WITH loc_oGrd.Column1.Header1
            .Caption = ""
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_SelImp
            .Caption   = ""
            .Width     = 22
            .Height    = 17
            .BackStyle = 0
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
        loc_oGrd.Column1.Sparse         = .F.

        *-- Column2: Codigo (Dopes)
        WITH loc_oGrd.Column2
            .Width         = 185
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Dopes"
        ENDWITH
        WITH loc_oGrd.Column2.Header1
            .Caption = "C" + CHR(243) + "digo"
        ENDWITH

        *-- Column3: Emissao (Datas)
        WITH loc_oGrd.Column3
            .Width         = 80
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Datas"
        ENDWITH
        WITH loc_oGrd.Column3.Header1
            .Caption = "Emiss" + CHR(227) + "o"
        ENDWITH

        *-- Column4: Valor (Valos)
        WITH loc_oGrd.Column4
            .Width         = 100
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Valos"
        ENDWITH
        WITH loc_oGrd.Column4.Header1
            .Caption = "Valor"
        ENDWITH

        *-- Column5: Nota Fiscal (Notas)
        WITH loc_oGrd.Column5
            .Width         = 80
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Notas"
        ENDWITH
        WITH loc_oGrd.Column5.Header1
            .Caption = "Nota Fiscal"
        ENDWITH

        *-- Column6: Serie (Series)
        WITH loc_oGrd.Column6
            .Width         = 50
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Series"
        ENDWITH
        WITH loc_oGrd.Column6.Header1
            .Caption = "S" + CHR(233) + "rie"
        ENDWITH

        *-- Column7: Movimentacao (Tipos)
        WITH loc_oGrd.Column7
            .Width         = 95
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Tipos"
        ENDWITH
        WITH loc_oGrd.Column7.Header1
            .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Column8: Empresa (Emps)
        WITH loc_oGrd.Column8
            .Width         = 50
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Emps"
        ENDWITH
        WITH loc_oGrd.Column8.Header1
            .Caption = "Emp"
        ENDWITH

        *-- Column9: Status (stats)
        WITH loc_oGrd.Column9
            .Width         = 148
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.stats"
        ENDWITH
        WITH loc_oGrd.Column9.Header1
            .Caption = "Stat"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesForm()
    *==========================================================================
        *-- Botao Selecionar
        THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
        WITH THIS.cmd_4c_Selecionar
            .Top             = 83
            .Left            = 843
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Selecionar"
            .Picture         = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Botao Limpar (desabilitado ate selecionar)
        THIS.AddObject("cmd_4c_BtnLimpar", "CommandButton")
        WITH THIS.cmd_4c_BtnLimpar
            .Top             = 162
            .Left            = 843
            .Width           = 75
            .Height          = 37
            .Caption         = "Limpar"
            .Picture         = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        *-- Botao Processar (desabilitado ate selecionar)
        THIS.AddObject("cmd_4c_BtnCopiar", "CommandButton")
        WITH THIS.cmd_4c_BtnCopiar
            .Top             = 202
            .Left            = 843
            .Width           = 75
            .Height          = 37
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        *-- Botao Encerrar
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 499
            .Left            = 917
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesGrade()
    *==========================================================================
        THIS.AddObject("cmd_4c_MarcaTudo", "CommandButton")
        WITH THIS.cmd_4c_MarcaTudo
            .Top             = 264
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Marca Tudo"
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH THIS.cmd_4c_Desmarcar
            .Top             = 322
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Desmarcar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Documentos", "CommandButton")
        WITH THIS.cmd_4c_Documentos
            .Top             = 380
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Documentos"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_consultar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_consultar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_ImpDSimpl", "CommandButton")
        WITH THIS.cmd_4c_ImpDSimpl
            .Top             = 438
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Imp. Simpl."
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntInu()
    *==========================================================================
        LOCAL loc_oCnt, loc_oGrd

        THIS.AddObject("cnt_4c_Inu", "Container")
        loc_oCnt = THIS.cnt_4c_Inu
        WITH loc_oCnt
            .Top         = 156
            .Left        = 203
            .Width       = 504
            .Height      = 392
            .Visible     = .F.
            .BorderWidth = 2
            .BackStyle   = 1
            .BackColor   = RGB(245, 245, 245)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TituloInu", "Label")
        WITH loc_oCnt.lbl_4c_TituloInu
            .AutoSize  = .F.
            .Caption   = "Notas Fiscais para Inutilizar"
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .BackStyle = 0
            .Height    = 20
            .Left      = 10
            .Top       = 5
            .Width     = 380
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnCancelaInu", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnCancelaInu
            .Top             = 28
            .Left            = 408
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnProcInu", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnProcInu
            .Top             = 105
            .Left            = 408
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("grd_4c_Inu", "Grid")
        loc_oGrd = loc_oCnt.grd_4c_Inu
        WITH loc_oGrd
            .Top           = 28
            .Left          = 17
            .Width         = 382
            .Height        = 355
            .ColumnCount   = 6
            .ReadOnly      = .F.
            .GridLines     = 1
            .GridLineWidth = 1
            .HeaderHeight  = 22
            .RowHeight     = 20
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        WITH loc_oGrd.Column1
            .Width = 35
        ENDWITH
        WITH loc_oGrd.Column1.Header1
            .Caption = "Emp"
        ENDWITH
        WITH loc_oGrd.Column2
            .Width = 40
        ENDWITH
        WITH loc_oGrd.Column2.Header1
            .Caption = "S" + CHR(233) + "rie"
        ENDWITH
        WITH loc_oGrd.Column3
            .Width = 70
        ENDWITH
        WITH loc_oGrd.Column3.Header1
            .Caption = "Nota Inicial"
        ENDWITH
        WITH loc_oGrd.Column4
            .Width = 70
        ENDWITH
        WITH loc_oGrd.Column4.Header1
            .Caption = "Nota Final"
        ENDWITH
        WITH loc_oGrd.Column5
            .Width = 105
        ENDWITH
        WITH loc_oGrd.Column5.Header1
            .Caption = "CPF/CNPJ"
        ENDWITH
        WITH loc_oGrd.Column6
            .Width = 62
        ENDWITH
        WITH loc_oGrd.Column6.Header1
            .Caption = ""
        ENDWITH
        loc_oGrd.Column6.AddObject("chk_4c_SelInu", "CheckBox")
        WITH loc_oGrd.Column6.chk_4c_SelInu
            .Caption   = ""
            .Width     = 60
            .Height    = 17
            .BackStyle = 0
        ENDWITH
        loc_oGrd.Column6.CurrentControl = "chk_4c_SelInu"
        loc_oGrd.Column6.Sparse         = .F.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis: oculta cnt_4c_Inu e cmd_4c_Inu apos DODEFAULT
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oErro
        TRY
            DODEFAULT()
            IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
                THIS.cnt_4c_Inu.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
                IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
                    THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Restaura visao principal do form OPERACIONAL
    * (grade + botoes de acao + filtros) escondendo o painel flutuante de
    * inutilizacao. Equivalente ao Page1=LISTA dos forms CRUD; chamado por
    * AlternarPagina(1) e apos cada processamento para reset visual.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
                THIS.cnt_4c_Inu.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
                THIS.cnt_4c_Operacoes.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
                THIS.cnt_4c_Grade.Visible = .T.
                IF PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Operacoes", 5)
                    THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
                THIS.cmd_4c_Selecionar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Exibe painel flutuante de inutilizacao (overlay)
    * Form OPERACIONAL nao possui PageFrame; cnt_4c_Inu atua como "Page2=Dados"
    * para captura da grade de inutilizacao. Chamado por AlternarPagina(2) e
    * CmdInuClick apos SelecionarInutilizadas popular csInutil. Refresh() garante
    * repaint do grid apos GO TOP e cursor recem-carregado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
                THIS.cnt_4c_Inu.Visible = .T.
                IF PEMSTATUS(THIS.cnt_4c_Inu, "grd_4c_Inu", 5)
                    IF USED("csInutil")
                        THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
                    ENDIF
                    THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Inu, "cmd_4c_BtnProcInu", 5)
                    THIS.cnt_4c_Inu.cmd_4c_BtnProcInu.Enabled = ;
                        (USED("csInutil") AND RECCOUNT("csInutil") > 0)
                ENDIF
                THIS.cnt_4c_Inu.ZOrder(0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre visao principal (1) e overlay Inutilizar (2)
    * Form OPERACIONAL nao possui PageFrame; usa cnt_4c_Inu como painel flutuante
    * que funciona logicamente como uma "segunda pagina" para captura de dados
    * de inutilizacao. par_nPagina = 1 restaura visao principal; = 2 abre overlay.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag, loc_oErro
        loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
        TRY
            DO CASE
                CASE loc_nPag = 2
                    THIS.ConfigurarPaginaDados()
                OTHERWISE
                    THIS.ConfigurarPaginaLista()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
    *==========================================================================
        LOCAL loc_oGrd
        BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
        BINDEVENT(THIS.cmd_4c_BtnLimpar,  "Click", THIS, "BtnLimparClick")
        BINDEVENT(THIS.cmd_4c_BtnCopiar,  "Click", THIS, "BtnCopiarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.cmd_4c_MarcaTudo,  "Click", THIS, "BtnMarcaTudoClick")
        BINDEVENT(THIS.cmd_4c_Desmarcar,  "Click", THIS, "BtnDesmarcarClick")
        BINDEVENT(THIS.cmd_4c_Documentos, "Click", THIS, "BtnDocumentosClick")
        BINDEVENT(THIS.cmd_4c_ImpDSimpl,  "Click", THIS, "BtnImpDSimplClick")
        BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnCancelaInu, "Click", THIS, "BtnCancelaInuClick")
        BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnProcInu,    "Click", THIS, "BtnProcInuClick")
        BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Emps,    "KeyPress", THIS, "EmpsLostFocus")
        BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Series,  "KeyPress", THIS, "SeriesLostFocus")
        BINDEVENT(THIS.cnt_4c_Operacoes.opt_4c_Acao, "InteractiveChange", THIS, "AcaoInteractiveChange")
        BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_Inu,  "Click", THIS, "CmdInuClick")
        loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Operacoes
        BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "MouseUp",  THIS, "GridChkMouseUp")
        BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "KeyPress", THIS, "GridChkKeyPress")
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS
    *==========================================================================

    PROCEDURE BtnSelecionarClick
        LPARAMETERS par_lForcado
        LOCAL loc_cEmps, loc_cSeries, loc_dDtIni, loc_dDtFin
        LOCAL loc_nProcessados, loc_nTipos, loc_nAcao
        LOCAL loc_cInuIni, loc_cInuFim, loc_oBO, loc_oErro, loc_lSelOk

        loc_oBO = THIS.this_oBusinessObject

        loc_cEmps        = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        loc_cSeries      = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
        loc_dDtIni       = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
        loc_dDtFin       = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
        loc_nProcessados = THIS.cnt_4c_Operacoes.opt_4c_Processados.Value
        loc_nTipos       = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
        loc_nAcao        = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
        loc_cInuIni      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
        loc_cInuFim      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)

        IF VARTYPE(par_lForcado) != "L" OR !par_lForcado
            IF loc_nProcessados = 2
                IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
                                CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?")
                    THIS.cnt_4c_Operacoes.opt_4c_Processados.Value = 1
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        IF EMPTY(ALLTRIM(loc_cEmps))
            MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
            THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_dDtIni)
            MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!")
            THIS.cnt_4c_Operacoes.txt_4c_DtIni.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_dDtFin)
            MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!")
            THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
            RETURN
        ENDIF
        IF loc_dDtFin < loc_dDtIni
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
            THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
            RETURN
        ENDIF
        IF INLIST(loc_nAcao, 4, 7)
            IF (loc_cInuFim < loc_cInuIni) OR EMPTY(loc_cInuFim) OR EMPTY(loc_cInuIni)
                MsgAviso("A Numera" + CHR(231) + CHR(227) + "o informada est" + CHR(225) + " inconsistente!!!")
                THIS.cnt_4c_Operacoes.txt_4c_InuFim.SetFocus()
                RETURN
            ENDIF
        ENDIF

        loc_oBO.this_cEmps        = loc_cEmps
        loc_oBO.this_cSeries      = loc_cSeries
        loc_oBO.this_dDtIni       = loc_dDtIni
        loc_oBO.this_dDtFin       = loc_dDtFin
        loc_oBO.this_nProcessados = loc_nProcessados
        loc_oBO.this_nTipos       = loc_nTipos
        loc_oBO.this_nAcao        = loc_nAcao
        loc_oBO.this_cInuIni      = loc_cInuIni
        loc_oBO.this_cInuFim      = loc_cInuFim

        loc_lSelOk = .T.
        TRY
            loc_oBO.Selecionar("csOperacoes")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Selecionar")
            loc_lSelOk = .F.
        ENDTRY
        IF !loc_lSelOk
            RETURN
        ENDIF

        THIS.HabilitarControles(.F.)

        SELECT csOperacoes
        SET ORDER TO Notas
        GO TOP IN csOperacoes
        IF EOF("csOperacoes")
            IF INLIST(loc_nAcao, 1, 2, 3, 5)
                MsgAviso("Nenhuma Nota Foi Encontrada Para Processamento!!!")
                THIS.LimpaSelecao()
                THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
            ENDIF
        ELSE
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnLimparClick()
        THIS.LimpaSelecao()
    ENDPROC

    PROCEDURE BtnCopiarClick()
        LOCAL loc_nAcao, loc_nSel, loc_oBO, loc_oErro
        loc_nAcao = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
        IF INLIST(loc_nAcao, 1, 2, 3, 5, 6)
            IF USED("cursor_4c_SelChk")
                USE IN cursor_4c_SelChk
            ENDIF
            SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelChk
            loc_nSel = cursor_4c_SelChk.nSel
            USE IN cursor_4c_SelChk
            IF loc_nSel < 1
                MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado para Processamento!!!")
                THIS.cnt_4c_Grade.grd_4c_Operacoes.SetFocus()
                RETURN
            ENDIF
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        loc_oBO.this_nAcao      = loc_nAcao
        loc_oBO.this_nAmbiente  = THIS.cnt_4c_Operacoes.opt_4c_Ambiente.Value
        loc_oBO.this_nTipos     = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
        loc_oBO.this_nImpressao = THIS.cnt_4c_Operacoes.opt_4c_Impressao.Value
        loc_oBO.this_nContin    = THIS.cnt_4c_Operacoes.opt_4c_Contin.Value
        loc_oBO.this_cArquivos  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value)
        loc_oBO.this_lHVerao    = (THIS.cnt_4c_Operacoes.chk_4c_HVerao.Value = 1)
        loc_oBO.this_lVenc      = (THIS.cnt_4c_Operacoes.chk_4c_Venc.Value = 1)
        loc_oBO.this_lOptSub    = (THIS.cnt_4c_Operacoes.chk_4c_OptSub.Value = 1)
        loc_oBO.this_lOptArq    = (THIS.cnt_4c_Operacoes.chk_4c_OptArq.Value = 1)
        TRY
            loc_oBO.Processamento( ;
                PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3), ;
                PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3))
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Processar")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnMarcaTudoClick()
        IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
            SELECT csOperacoes
            REPLACE ALL SelImp WITH .T.
            GO TOP IN csOperacoes
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarClick()
        IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
            SELECT csOperacoes
            REPLACE ALL SelImp WITH .F.
            GO TOP IN csOperacoes
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDocumentosClick()
        LOCAL loc_cDopes, loc_nNumes, loc_cEmps, loc_oForm, loc_oErro
        IF !USED("csOperacoes") OR EOF("csOperacoes")
            MsgAviso("Posicione o cursor em um registro.")
            RETURN
        ENDIF
        SELECT csOperacoes
        loc_cDopes = ALLTRIM(csOperacoes.Dopes)
        loc_nNumes = csOperacoes.Numes
        loc_cEmps  = ALLTRIM(csOperacoes.Emps)
        TRY
            loc_oForm = CREATEOBJECT("Formsigmvexp", loc_cDopes, "C", loc_nNumes, loc_cEmps)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgErro("Erro ao criar Formsigmvexp. VARTYPE retornou: " + ;
                        VARTYPE(loc_oForm), "Documentos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir Documentos")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImpDSimplClick()
        LOCAL loc_oBO, loc_oErro
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("Nenhuma nota encontrada para impress" + CHR(227) + "o.")
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        TRY
            loc_oBO.ImprimirSimplificado("csOperacoes")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Impress" + CHR(227) + "o")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelaInuClick()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE BtnProcInuClick()
        LOCAL loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim, loc_oBO, loc_oErro
        IF !INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
            MsgAviso("Selecione a a" + CHR(231) + CHR(227) + "o Inutilizar ou Status.")
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value))
            MsgAviso("Empresa n" + CHR(227) + "o informada.")
            RETURN
        ENDIF
        IF !USED("csInutil") OR RECCOUNT("csInutil") = 0
            MsgAviso("Nenhuma nota fiscal para inutilizar.")
            RETURN
        ENDIF
        loc_cEmps   = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        loc_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
        loc_cNIni   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
        loc_cNFim   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
        SELECT csInutil
        GO TOP IN csInutil
        loc_cCnpj = ALLTRIM(csInutil.cnpj)
        loc_oBO = THIS.this_oBusinessObject
        TRY
            loc_oBO.ProcessaInutilizadas(loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Inutilizar")
        ENDTRY
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE AcaoInteractiveChange()
        IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
            THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;
                INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
        ENDIF
    ENDPROC

    PROCEDURE CmdInuClick()
        LOCAL loc_cEmps, loc_oBO, loc_oErro
        loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        IF EMPTY(ALLTRIM(loc_cEmps))
            MsgAviso("Informe a empresa antes de consultar inutiliza" + CHR(231) + CHR(245) + "es.")
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        TRY
            *-- Carrega nfAinu com gap analysis via BO
            loc_oBO.SelecionarInutilizadas(loc_cEmps)
            IF USED("nfAinu")
                SELECT 1 AS nMarca, emps, series, notai, notaf, cnpj ;
                    FROM nfAinu ;
                    WHERE RTRIM(emps) = RTRIM(loc_cEmps) ;
                    INTO CURSOR csInutil READWRITE
                IF USED("csInutil") AND RECCOUNT("csInutil") > 0
                    GO TOP IN csInutil
                    WITH THIS.cnt_4c_Inu.grd_4c_Inu
                        .RecordSource          = "csInutil"
                        .Column1.ControlSource = "csInutil.emps"
                        .Column2.ControlSource = "csInutil.series"
                        .Column3.ControlSource = "csInutil.notai"
                        .Column4.ControlSource = "csInutil.notaf"
                        .Column5.ControlSource = "csInutil.cnpj"
                        .Column6.ControlSource = "csInutil.nMarca"
                        .Refresh()
                    ENDWITH
                    THIS.AlternarPagina(2)
                ELSE
                    MsgAviso("Nenhuma nota para inutilizar encontrada para esta empresa.")
                ENDIF
            ELSE
                MsgAviso("Nenhuma nota para inutilizar encontrada.")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CmdInu")
        ENDTRY
    ENDPROC

    PROCEDURE EmpsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 115  && F4 - abrir picker direto
            THIS.AbrirBuscaEmps()
            RETURN
        ENDIF
        LOCAL loc_cEmps, loc_oBO, loc_oErro
        loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        IF EMPTY(ALLTRIM(loc_cEmps))
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        TRY
            IF loc_oBO.CarregarEmpresa(ALLTRIM(loc_cEmps))
                THIS.PreencherRegimeEmpresa(loc_oBO)
            ELSE
                THIS.AbrirBuscaEmps()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar empresa")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE PreencherRegimeEmpresa(par_oBO)
        DO CASE
            CASE par_oBO.this_nRegimeEmp = 1
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Simples Nacional"
            CASE par_oBO.this_nRegimeEmp = 2
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Presumido"
            CASE par_oBO.this_nRegimeEmp = 3
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Real"
            CASE par_oBO.this_nRegimeEmp = 4
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Arbitrado"
        ENDCASE
        IF !EMPTY(par_oBO.this_cArquivos)
            THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value = par_oBO.this_cArquivos
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmps()
        LOCAL loc_oBusca, loc_cCemps, loc_oBO, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "Cemps", ;
                ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
                .T., .T., "Ativas <> 2")
            loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                THIS.cnt_4c_Operacoes.txt_4c_Emps.Value = loc_cCemps
                loc_oBO = THIS.this_oBusinessObject
                IF loc_oBO.CarregarEmpresa(loc_cCemps)
                    THIS.PreencherRegimeEmpresa(loc_oBO)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmps")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    PROCEDURE SeriesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 115  && F4 - abrir picker direto
            THIS.AbrirBuscaSeries()
            RETURN
        ENDIF
        LOCAL loc_cSeries, loc_nResult, loc_oErro
        loc_cSeries = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value)
        IF EMPTY(loc_cSeries)
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Cods FROM SigCdSer WHERE ImpNfs = 3 AND LTRIM(RTRIM(Cods)) = " + ;
                EscaparSQL(loc_cSeries), "cursor_4c_SerValid")
            IF loc_nResult > 0 AND USED("cursor_4c_SerValid") AND !EOF("cursor_4c_SerValid")
                THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_SerValid.Cods)
            ELSE
                THIS.AbrirBuscaSeries()
            ENDIF
            IF USED("cursor_4c_SerValid")
                USE IN cursor_4c_SerValid
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaSeries()
        LOCAL loc_oBusca, loc_cCods, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdSer", ;
                "cursor_4c_BuscaSeries", ;
                "Cods", ;
                ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o de S" + CHR(233) + "rie", ;
                .T., .T., "ImpNfs = 3")
            loc_oBusca.mAddColuna("Cods", "", "S" + CHR(233) + "rie")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSeries")
                loc_cCods = ALLTRIM(cursor_4c_BuscaSeries.Cods)
                THIS.cnt_4c_Operacoes.txt_4c_Series.Value = loc_cCods
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaSeries")
        ENDTRY
        IF USED("cursor_4c_BuscaSeries")
            USE IN cursor_4c_BuscaSeries
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *-- MouseUp no CheckBox de selecao: toggle SelImp do registro corrente
    PROCEDURE GridChkMouseUp
        LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
        IF USED("csOperacoes") AND !EOF("csOperacoes")
            m.SelImp = (NOT csOperacoes.SelImp)
            SELECT csOperacoes
            GATHER MEMVAR FIELDS SelImp
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
        NODEFAULT
    ENDPROC

    *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
    PROCEDURE GridChkKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
            m.SelImp = (NOT csOperacoes.SelImp)
            SELECT csOperacoes
            GATHER MEMVAR FIELDS SelImp
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE LimpaSelecao()
        IF USED("csOperacoes")
            ZAP IN csOperacoes
        ENDIF
        THIS.HabilitarControles(.T.)
        THIS.cmd_4c_ImpDSimpl.Enabled = .F.
        THIS.Refresh()
    ENDPROC

    PROCEDURE HabilitarControles(par_lHabilitar)
        WITH THIS.cnt_4c_Operacoes
            .txt_4c_Emps.Enabled                   = par_lHabilitar
            .txt_4c_Series.Enabled                 = par_lHabilitar
            .txt_4c_DtIni.Enabled                  = par_lHabilitar
            .txt_4c_DtFin.Enabled                  = par_lHabilitar
            .txt_4c_InuIni.Enabled                 = par_lHabilitar
            .txt_4c_InuFim.Enabled                 = par_lHabilitar
            .cmb_4c_Regime.Enabled                 = par_lHabilitar
            .opt_4c_Processados.Buttons(1).Enabled = par_lHabilitar
            .opt_4c_Processados.Buttons(2).Enabled = par_lHabilitar
            .Visible     = .T.
        ENDWITH
        THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
        THIS.cmd_4c_BtnLimpar.Enabled  = !par_lHabilitar
        THIS.cmd_4c_BtnCopiar.Enabled  = !par_lHabilitar
        THIS.cmd_4c_MarcaTudo.Enabled  = !par_lHabilitar
        THIS.cmd_4c_Desmarcar.Enabled  = !par_lHabilitar
        THIS.cmd_4c_Documentos.Enabled = !par_lHabilitar
        THIS.cmd_4c_ImpDSimpl.Enabled  = !par_lHabilitar
    ENDPROC

    *==========================================================================
    * Eventos CRUD adaptados ao contexto OPERACIONAL de processamento de NFe.
    * Em forms de processamento fiscal, as semanticas CRUD tradicionais mapeiam
    * para operacoes especificas do fluxo de trabalho de NFe.
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        * Incluir notas fiscais na fila de processamento.
        * No contexto NFe, "Incluir" equivale a Selecionar registros do banco
        * (SigMvNfi) para o cursor csOperacoes segundo os filtros informados.
        LOCAL loc_cEmps
        loc_cEmps = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
        IF EMPTY(loc_cEmps)
            MsgAviso("Informe a Empresa antes de incluir notas na fila.")
            THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF
        THIS.BtnSelecionarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        * Alterar dados fiscais da nota corrente. Abre Formsigmvexp
        * (mesma janela usada pelo botao "Documentos" do grid) para
        * edicao dos dados fiscais da NF apontada em csOperacoes.
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize Incluir primeiro.")
            RETURN
        ENDIF
        SELECT csOperacoes
        IF EOF("csOperacoes")
            GO TOP IN csOperacoes
        ENDIF
        IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
            MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
            RETURN
        ENDIF
        THIS.BtnDocumentosClick()
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        * Visualizar detalhes tecnicos (chave, protocolo, status)
        * da nota fiscal apontada. Consulta SigMvNfi diretamente
        * para exibir dados que nao aparecem no grid principal.
        LOCAL loc_cChave, loc_cSQL, loc_oErro, loc_cMsg
        LOCAL loc_cChv, loc_cProt, loc_cStat, loc_cXml
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
            RETURN
        ENDIF
        SELECT csOperacoes
        IF EOF("csOperacoes")
            GO TOP IN csOperacoes
        ENDIF
        loc_cChave = ALLTRIM(csOperacoes.Emps) + ALLTRIM(csOperacoes.Dopes) + ;
                     PADL(ALLTRIM(TRANSFORM(csOperacoes.Numes)), 6, "0")
        loc_cSQL = "SELECT TOP 1 nfechv, nfexml, prots, stats FROM SigMvNfi WHERE empdopnums = " + ;
                   EscaparSQL(loc_cChave)
        TRY
            IF USED("cursor_4c_VisNfe")
                USE IN cursor_4c_VisNfe
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisNfe") < 1
                MsgErro("Falha ao consultar SigMvNfi para a nota selecionada.", "Visualizar")
                RETURN
            ENDIF
            IF RECCOUNT("cursor_4c_VisNfe") = 0
                MsgAviso("Nota fiscal ainda n" + CHR(227) + "o transmitida (sem registro em SigMvNfi).")
            ELSE
                loc_cChv  = ALLTRIM(NVL(cursor_4c_VisNfe.nfechv, "N/D"))
                loc_cProt = ALLTRIM(NVL(cursor_4c_VisNfe.prots, "N/D"))
                loc_cStat = ALLTRIM(NVL(cursor_4c_VisNfe.stats, "N/D"))
                loc_cXml  = IIF(EMPTY(NVL(cursor_4c_VisNfe.nfexml, "")), "N" + CHR(227) + "o", "Sim")
                loc_cMsg = "Nota: " + ALLTRIM(csOperacoes.Notas) + CHR(13) + ;
                           "S" + CHR(233) + "rie: " + ALLTRIM(csOperacoes.Series) + CHR(13) + ;
                           "Chave: " + loc_cChv + CHR(13) + ;
                           "Protocolo: " + loc_cProt + CHR(13) + ;
                           "Status: " + loc_cStat + CHR(13) + ;
                           "XML dispon" + CHR(237) + "vel: " + loc_cXml
                MsgInfo(loc_cMsg)
            ENDIF
            IF USED("cursor_4c_VisNfe")
                USE IN cursor_4c_VisNfe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Visualizar")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick()
        * Excluir (limpar) a fila de processamento.
        * NAO remove NFe do banco - apenas limpa csOperacoes e reabilita
        * os filtros para nova selecao. Confirmacao obrigatoria.
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("A fila de processamento j" + CHR(225) + " est" + CHR(225) + " vazia.")
            RETURN
        ENDIF
        IF MsgConfirma("Confirma a limpeza da fila de processamento de NFe?" + CHR(13) + ;
                       "Os registros n" + CHR(227) + "o ser" + CHR(227) + "o removidos do banco de dados.")
            THIS.LimpaSelecao()
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 8 - FormParaBO / BOParaForm / HabilitarCampos / LimparCampos
    * CarregarLista / AjustarBotoesPorModo / BtnSalvar / BtnCancelar / BtnBuscar
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Copia TODOS os valores da UI para o Business Object.
    * Cobre os 3 blocos de propriedades: parametros de sele" + CHR(231) + CHR(227) + "o
    * (empresa/serie/datas/acao), flags/checkboxes e o registro corrente
    * de csOperacoes (linha selecionada no grid).
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oCnt
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF
        loc_oCnt = THIS.cnt_4c_Operacoes

        *-- Bloco 1: parametros de selecao/processamento
        loc_oBO.this_cEmps        = PADR(ALLTRIM(loc_oCnt.txt_4c_Emps.Value), 3)
        loc_oBO.this_cSeries      = PADR(ALLTRIM(loc_oCnt.txt_4c_Series.Value), 3)
        loc_oBO.this_dDtIni       = loc_oCnt.txt_4c_DtIni.Value
        loc_oBO.this_dDtFin       = loc_oCnt.txt_4c_DtFin.Value
        loc_oBO.this_nProcessados = loc_oCnt.opt_4c_Processados.Value
        loc_oBO.this_nTipos       = loc_oCnt.opt_4c_Tipos.Value
        loc_oBO.this_nAmbiente    = loc_oCnt.opt_4c_Ambiente.Value
        loc_oBO.this_nAcao        = loc_oCnt.opt_4c_Acao.Value
        loc_oBO.this_nImpressao   = loc_oCnt.opt_4c_Impressao.Value
        loc_oBO.this_nContin      = loc_oCnt.opt_4c_Contin.Value
        loc_oBO.this_cInuIni      = ALLTRIM(loc_oCnt.txt_4c_InuIni.Value)
        loc_oBO.this_cInuFim      = ALLTRIM(loc_oCnt.txt_4c_InuFim.Value)
        loc_oBO.this_cRegime      = ALLTRIM(loc_oCnt.cmb_4c_Regime.Value)
        loc_oBO.this_cArquivos    = ALLTRIM(loc_oCnt.txt_4c_Arquivos.Value)
        IF EMPTY(loc_oCnt.txt_4c_IniContin.Value)
            loc_oBO.this_dIniContin = {}
        ELSE
            IF VARTYPE(loc_oCnt.txt_4c_IniContin.Value) = "D"
                loc_oBO.this_dIniContin = loc_oCnt.txt_4c_IniContin.Value
            ELSE
                loc_oBO.this_dIniContin = CTOD(TRANSFORM(loc_oCnt.txt_4c_IniContin.Value))
            ENDIF
        ENDIF

        *-- Bloco 2: flags/checkboxes (Value NUMERICO 0/1 -> LOGICAL no BO)
        loc_oBO.this_lHVerao  = (loc_oCnt.chk_4c_HVerao.Value = 1)
        loc_oBO.this_lVenc    = (loc_oCnt.chk_4c_Venc.Value = 1)
        loc_oBO.this_lOptSub  = (loc_oCnt.chk_4c_OptSub.Value = 1)
        loc_oBO.this_lOptArq  = (loc_oCnt.chk_4c_OptArq.Value = 1)

        *-- Bloco 3: registro corrente do grid csOperacoes
        IF USED("csOperacoes") AND !EOF("csOperacoes") AND !BOF("csOperacoes")
            loc_oBO.this_lSelImp     = NVL(csOperacoes.SelImp, .F.)
            loc_oBO.this_cDopes      = NVL(csOperacoes.Dopes, "")
            loc_oBO.this_nNumes      = NVL(csOperacoes.Numes, 0)
            loc_oBO.this_dDatas      = NVL(csOperacoes.Datas, {})
            loc_oBO.this_nValos      = NVL(csOperacoes.Valos, 0)
            loc_oBO.this_cNotas      = NVL(csOperacoes.Notas, "")
            loc_oBO.this_cNFMemo     = NVL(csOperacoes.NFMemo, "")
            loc_oBO.this_cErros      = NVL(csOperacoes.Erros, "")
            loc_oBO.this_cStats      = NVL(csOperacoes.stats, "")
            loc_oBO.this_cStatts     = NVL(csOperacoes.statts, "")
            loc_oBO.this_cId         = NVL(csOperacoes.ids, "")
            loc_oBO.this_cLote       = NVL(csOperacoes.lotes, "")
            loc_oBO.this_cRecibo     = NVL(csOperacoes.recibos, "")
            loc_oBO.this_cProt       = NVL(csOperacoes.prots, "")
            loc_oBO.this_cEmpDopNums = ALLTRIM(NVL(csOperacoes.Emps, "")) + ;
                                      ALLTRIM(NVL(csOperacoes.Dopes, "")) + ;
                                      PADL(ALLTRIM(TRANSFORM(NVL(csOperacoes.Numes, 0))), 6, "0")
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia TODOS os valores do Business Object para a UI.
    * Espelho de FormParaBO, cobrindo os 3 blocos (parametros, flags e
    * registro corrente do grid).
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oCnt
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF
        loc_oCnt = THIS.cnt_4c_Operacoes

        *-- Bloco 1: parametros de selecao/processamento
        loc_oCnt.txt_4c_Emps.Value       = loc_oBO.this_cEmps
        loc_oCnt.txt_4c_Series.Value     = loc_oBO.this_cSeries
        loc_oCnt.txt_4c_DtIni.Value      = loc_oBO.this_dDtIni
        loc_oCnt.txt_4c_DtFin.Value      = loc_oBO.this_dDtFin
        IF loc_oBO.this_nProcessados > 0
            loc_oCnt.opt_4c_Processados.Value = loc_oBO.this_nProcessados
        ENDIF
        IF loc_oBO.this_nTipos > 0
            loc_oCnt.opt_4c_Tipos.Value = loc_oBO.this_nTipos
        ENDIF
        IF loc_oBO.this_nAmbiente > 0
            loc_oCnt.opt_4c_Ambiente.Value = loc_oBO.this_nAmbiente
        ENDIF
        IF loc_oBO.this_nAcao > 0
            loc_oCnt.opt_4c_Acao.Value = loc_oBO.this_nAcao
        ENDIF
        IF loc_oBO.this_nImpressao > 0
            loc_oCnt.opt_4c_Impressao.Value = loc_oBO.this_nImpressao
        ENDIF
        IF loc_oBO.this_nContin > 0
            loc_oCnt.opt_4c_Contin.Value = loc_oBO.this_nContin
        ENDIF
        loc_oCnt.txt_4c_InuIni.Value   = loc_oBO.this_cInuIni
        loc_oCnt.txt_4c_InuFim.Value   = loc_oBO.this_cInuFim
        loc_oCnt.cmb_4c_Regime.Value   = loc_oBO.this_cRegime
        loc_oCnt.txt_4c_Arquivos.Value = loc_oBO.this_cArquivos
        loc_oCnt.txt_4c_IniContin.Value = loc_oBO.this_dIniContin

        *-- Bloco 2: flags/checkboxes (LOGICAL BO -> NUMERICO 0/1 CheckBox)
        loc_oCnt.chk_4c_HVerao.Value = IIF(loc_oBO.this_lHVerao, 1, 0)
        loc_oCnt.chk_4c_Venc.Value   = IIF(loc_oBO.this_lVenc, 1, 0)
        loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)
        loc_oCnt.chk_4c_OptArq.Value = IIF(loc_oBO.this_lOptArq, 1, 0)

        *-- Bloco 3: registro corrente reflete csOperacoes via ControlSource do
        *-- grid. Refresh forca releitura dos ControlSource apos alteracao no BO.
        THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Interface CRUD-padrao. Delega para HabilitarControles
    * (nome nativo deste form OPERACIONAL) que implementa a logica real de
    * bloquear filtros durante processamento.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        THIS.HabilitarControles(loc_lHab)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Interface CRUD-padrao. Reseta filtros para valores default
    * e limpa a fila de csOperacoes chamando LimpaSelecao.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Operacoes
        loc_oCnt.txt_4c_Emps.Value        = ""
        loc_oCnt.txt_4c_Series.Value      = ""
        loc_oCnt.txt_4c_DtIni.Value       = {}
        loc_oCnt.txt_4c_DtFin.Value       = {}
        loc_oCnt.txt_4c_InuIni.Value      = ""
        loc_oCnt.txt_4c_InuFim.Value      = ""
        loc_oCnt.txt_4c_Arquivos.Value    = ""
        loc_oCnt.opt_4c_Processados.Value = 1
        loc_oCnt.opt_4c_Tipos.Value       = 1
        loc_oCnt.opt_4c_Ambiente.Value    = 1
        loc_oCnt.opt_4c_Acao.Value        = 1
        loc_oCnt.opt_4c_Impressao.Value   = 1
        loc_oCnt.opt_4c_Contin.Value      = 1
        loc_oCnt.chk_4c_HVerao.Value      = 0
        loc_oCnt.chk_4c_Venc.Value        = 0
        loc_oCnt.chk_4c_OptSub.Value      = 0
        loc_oCnt.chk_4c_OptArq.Value      = 0
        THIS.LimpaSelecao()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Interface CRUD-padrao. Executa a selecao inicial das
    * notas fiscais no banco (SigMvNfi) para o cursor csOperacoes que popula
    * o grid principal. Delega para BtnSelecionarClick que reproduz o Selecionar
    * do form legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_cEmps, loc_dDtIni, loc_dDtFin
        loc_cEmps  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
        loc_dDtIni = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
        loc_dDtFin = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
        IF EMPTY(loc_cEmps) OR EMPTY(loc_dDtIni) OR EMPTY(loc_dDtFin)
            RETURN .F.
        ENDIF
        THIS.BtnSelecionarClick(.T.)
        RETURN USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Interface CRUD-padrao. Neste form OPERACIONAL
    * ha 2 modos logicos:
    *   MODO=1 (LIVRE):     filtros habilitados, botoes de acao em grid off.
    *   MODO=2 (SELECAO):   filtros bloqueados, botoes de acao em grid on.
    * A rotina espelha o comportamento de HabilitarControles com semantica
    * de "modo" para compatibilidade com o pipeline CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_nModo)
        LOCAL loc_nModo
        loc_nModo = IIF(VARTYPE(par_nModo) = "N", par_nModo, 1)
        IF loc_nModo = 1
            THIS.HabilitarControles(.T.)
        ELSE
            THIS.HabilitarControles(.F.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Interface CRUD-padrao. Em contexto NFe "Salvar" equivale
    * a processar (transmitir SEFAZ / gerar TXT / imprimir DANFE) as notas
    * marcadas no grid. Delega para BtnCopiarClick que aciona o
    * BO.Processar/Processamento conforme opt_4c_Acao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_nSel
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("A fila de processamento est" + CHR(225) + " vazia. Use Buscar/Selecionar antes.")
            RETURN
        ENDIF
        SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelSalv
        loc_nSel = cursor_4c_SelSalv.nSel
        USE IN cursor_4c_SelSalv
        IF loc_nSel < 1
            MsgAviso("Nenhuma nota est" + CHR(225) + " marcada para processamento.")
            RETURN
        ENDIF
        THIS.FormParaBO()
        THIS.BtnCopiarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Interface CRUD-padrao. Cancela a selecao atual e
    * reabilita os filtros de busca (equivale ao Limpar do form legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
            IF !MsgConfirma("Confirma o cancelamento da sele" + CHR(231) + CHR(227) + ;
                            "o? A fila ser" + CHR(225) + " limpa.")
                RETURN
            ENDIF
        ENDIF
        THIS.BtnLimparClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Interface CRUD-padrao. Aciona a selecao no banco
    * segundo os filtros informados. Delega para BtnSelecionarClick que
    * reproduz o Selecionar do form legado (grupo de botoes cmdSelecionar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnSelecionarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF USED("csOperacoes")
            USE IN csOperacoes
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprnfeBO.prg):
*******************************************************************************
* sigprnfeBO.prg - Business Object - Processamento de NF-e
* Herda de BusinessBase
* Migrado de: SIGPRNFE.SCX (Framework Fortyus)
*******************************************************************************
DEFINE CLASS sigprnfeBO AS BusinessBase

    *-- Filtros do formulario (controles de cntOperacoes)
    this_cEmps             = ""   && Empresa (SigCdEmp.Cemps char(3))
    this_cSeries           = ""   && Serie NF-e (SigCdSer.Cods char(3))
    this_dDtIni            = {}   && Data inicial de emissao
    this_dDtFin            = {}   && Data final de emissao
    this_nProcessados      = 0    && 1=Nao Processados, 2=Ja Processados
    this_nTipos            = 0    && 1=Saida, 2=Entrada
    this_nAmbiente         = 0    && 1=Producao, 2=Homologacao
    this_nAcao             = 0    && 1=Enviar, 2=Consultar, 3=Cancelar, 4=Inutilizar, 5=PDF, 6=Email, 7=Status
    this_nImpressao        = 0    && Tipo de impressao DANFE
    this_nContin           = 0    && Contingencia (1=Nenhuma, 2=EPEC, 3=SCAN/SVC)
    this_cInuIni           = ""   && Numero inicial para inutilizacao
    this_cInuFim           = ""   && Numero final para inutilizacao
    this_cRegime           = ""   && Regime tributario (descricao combo)
    this_cArquivos         = ""   && Caminho base arquivos NF-e
    this_dIniContin        = {}   && Data inicio contingencia
    this_lHVerao           = .F.  && Horario de verao
    this_lVenc             = .F.  && Vencimentos futuros
    this_lOptSub           = .F.  && Substituir codigo produto por referencia
    this_lOptArq           = .F.  && Usar TXT-ALT
    this_cVersao           = ""   && Versao schema NF-e (ex: 2.0.4)
    this_lValidaIE         = .F.  && Validar Inscricao Estadual via DLL

    *-- Dados NF-e em processamento (equivalente as vars PUBLIC do legado)
    this_cId               = ""   && Chave de acesso NF-e 44 chars (SigMvNfi.nfechv)
    this_cCnpj             = ""   && CNPJ empresa emitente
    this_cDEmis            = ""   && Data emissao formato NF-e
    this_cEmail            = ""   && Email NF-e empresa
    this_cConteudoTXT      = ""   && Conteudo arquivo TXT
    this_cConteudoXML      = ""   && Conteudo arquivo XML
    this_cConteudoPDF      = ""   && Conteudo arquivo PDF
    this_cPathUni          = ""   && Caminho unificado NF-e
    this_cLote             = ""   && Numero do lote de envio
    this_cRecibo           = ""   && Recibo do lote SEFAZ
    this_cProt             = ""   && Protocolo de autorizacao

    *-- Caminhos de pastas NF-e (equiv lcP* PUBLIC do legado)
    this_cPathNFe          = ""   && Caminho raiz arquivos NF-e
    this_cDanfe            = ""   && Arquivo DANFE
    this_cUniNFe           = ""   && Arquivo unificado NF-e
    this_cLog              = ""   && Arquivo de log
    this_cBKP              = ""   && Caminho de backup
    this_cPEnvio           = ""   && Pasta: a enviar
    this_cPEnviado         = ""   && Pasta: enviados
    this_cPEnvioEmLote     = ""   && Pasta: envio em lote
    this_cPErro            = ""   && Pasta: erros
    this_cPRetorno         = ""   && Pasta: retorno SEFAZ
    this_cPValidar         = ""   && Pasta: a validar
    this_cPBKenviados      = ""   && Pasta: backup enviados
    this_cPEmProc          = ""   && Pasta: em processamento
    this_cPAssinado        = ""   && Pasta: assinados
    this_cPValidado        = ""   && Pasta: validados
    this_cPAutorizados     = ""   && Pasta: autorizados
    this_cPPdf             = ""   && Pasta: PDFs DANFE
    this_cPBkp             = ""   && Pasta: backup geral
    this_cPTxt             = ""   && Prefixo tipo arquivo (ex: "nfe-")
    this_cChr              = ""   && Caractere codificacao XML
    this_cTpImp            = ""   && Tipo impressao DANFE (RETRATO/PAISAGEM)

    *-- Dados da empresa emitente (de SigCdEmp)
    this_cCemps            = ""   && Codigo empresa (SigCdEmp.Cemps char(3))
    this_cRazas            = ""   && Razao social (SigCdEmp.Razas)
    this_cEstas            = ""   && UF da empresa
    this_nRegimeEmp        = 0    && Regime (1=Simples, 2=Presumido, 3=Real, 4=Arbitrado)
    this_cTextoNFe         = ""   && Texto padrao corpo email NF-e
    this_cEmailNFe         = ""   && Email remetente/copia NF-e
    this_cServs            = ""   && Servidor SMTP
    this_cSenhas           = ""   && Senha SMTP
    this_nPortas           = 0    && Porta SMTP

    *-- Responsavel tecnico NF-e 4.0 (de SigCdParac)
    this_cRTcnpj           = ""   && CNPJ responsavel tecnico (sem mascara)
    this_cRTcont           = ""   && Contato responsavel tecnico
    this_cRTemai           = ""   && Email responsavel tecnico
    this_cRTtel            = ""   && Telefone responsavel tecnico (sem mascara)

    *-- Controle de processamento em lote
    this_lEmProcessamento  = .F.  && Flag: processamento ativo
    this_cMensagemErro     = ""   && Ultima mensagem de erro no processamento
    this_nTotalProcessados = 0    && Total de NFs processadas com sucesso
    this_nTotalErros       = 0    && Total de NFs com erro no lote

    *-- Dados do registro NF-e corrente (mapeado de csOperacoes)
    this_lSelImp           = .F.  && Flag selecao para processamento
    this_cDopes            = ""   && Operacao (SigMvNfi.dopes char(20))
    this_nNumes            = 0    && Numero NF (SigMvNfi.numes numeric(6,0))
    this_dDatas            = {}   && Data emissao do registro corrente
    this_nValos            = 0    && Valor NF (SigMvNfi.TotNotas numeric(14,2))
    this_cNotas            = ""   && Numero NF string (SigMvNfi.NFis char(6))
    this_cNFMemo           = ""   && Memo da NF
    this_cErros            = ""   && Erros de processamento
    this_cStats            = ""   && Status NF-e (sigprnfe.stats char(3))
    this_cStatts           = ""   && Sub-status NF-e (sigprnfe.statts char(1))
    this_cEmpDopNums       = ""   && Chave composta emps+dopes+numes (char(29))

    *-- Conteudo NF-e para UPDATE SigMvNfi
    this_cNfeTxt           = ""   && Conteudo arquivo TXT NF-e (nfetxt text)
    this_cNfeXml           = ""   && Conteudo arquivo XML NF-e (nfexml text)
    this_cNfePdf           = ""   && Conteudo arquivo PDF NF-e (nfepdf text)
    this_nImpress          = 0    && Flag nota impressa (SigMvNfi.impress numeric(6,0))
    this_cNfePrt           = ""   && Protocolo autorizacao (SigMvNfi.nfeprt char(15))
    this_cCidChaves        = ""   && PK de SigMvNfi para UPDATE (cidchaves char(20))

    *-- Dados para INSERT em sigprnfe
    this_cArquivoNFe       = ""   && Caminho arquivo TXT gerado (sigprnfe.arquivos char(250))
    this_cPkSigPrNfe       = ""   && PK de sigprnfe (cidchaves char(20)) gerado em Inserir
    this_cNumeronota       = ""   && Numero estendido da nota (sigprnfe.numeronota char(10))

    *==========================================================================
    * Init - Inicializa BO configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvNfi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODOS os campos de csOperacoes para this_*
    * par_cAliasCursor: alias do cursor de trabalho (normalmente "csOperacoes")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_lSelImp     = NVL(SelImp, .F.)
                THIS.this_cEmps       = ALLTRIM(NVL(Emps, ""))
                THIS.this_cDopes      = ALLTRIM(NVL(Dopes, ""))
                THIS.this_nNumes      = NVL(Numes, 0)
                THIS.this_dDatas      = NVL(Datas, {})
                THIS.this_nValos      = NVL(Valos, 0)
                THIS.this_cNotas      = ALLTRIM(NVL(Notas, ""))
                THIS.this_cSeries     = ALLTRIM(NVL(Series, ""))
                THIS.this_cNFMemo     = NVL(NFMemo, "")
                THIS.this_cErros      = NVL(Erros, "")
                THIS.this_nTipos      = NVL(Tipos, 0)
                THIS.this_cStats      = ALLTRIM(NVL(stats, ""))
                THIS.this_cId         = ALLTRIM(NVL(ids, ""))
                THIS.this_cLote       = ALLTRIM(NVL(lotes, ""))
                THIS.this_cRecibo     = ALLTRIM(NVL(recibos, ""))
                THIS.this_cProt       = ALLTRIM(NVL(prots, ""))
                THIS.this_cStatts     = ALLTRIM(NVL(statts, ""))
                THIS.this_cEmpDopNums = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        ALLTRIM(THIS.this_cDopes) + ;
                                        PADL(ALLTRIM(STR(THIS.this_nNumes, 6)), 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarDoCursor")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Selecionar - Carrega registros NF-e da base conforme filtros em this_*
    * par_cCursorDestino: cursor de destino (default: "csOperacoes")
    * Retorna .T. se encontrou registros, .F. se vazio ou erro
    *==========================================================================
    PROCEDURE Selecionar(par_cCursorDestino)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_cSQL2, loc_cSQL3
        LOCAL loc_cEmp, loc_cSer, loc_cOper, loc_nOper
        LOCAL loc_cDtI, loc_cDtF, loc_cCheOpe
        LOCAL loc_cCursor, loc_nRet

        loc_lResultado = .F.
        loc_cCursor = IIF(PCOUNT() >= 1 .AND. !EMPTY(par_cCursorDestino), ;
                          par_cCursorDestino, "csOperacoes")

        *-- Validacoes (fora do TRY para RETURN seguro)
        IF EMPTY(THIS.this_cEmps)
            MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtIni)
            MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFin)
            MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFin < THIS.this_dDtIni
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF INLIST(THIS.this_nAcao, 4, 7)
            IF EMPTY(THIS.this_cInuIni) OR EMPTY(THIS.this_cInuFim) ;
               OR THIS.this_cInuFim < THIS.this_cInuIni
                MsgAviso("A Numera" + CHR(231) + CHR(227) + "o informada est" + ;
                         CHR(225) + " inconsistente!", "Sele" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF
        IF THIS.this_nProcessados = 2
            IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
                            CHR(231) + CHR(245) + "es J" + CHR(225) + ;
                            " Processadas Anteriormente?")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            *-- Monta variaveis
            loc_cEmp  = PADR(ALLTRIM(THIS.this_cEmps), 3)
            loc_cSer  = PADR(ALLTRIM(THIS.this_cSeries), 3)
            loc_cOper = IIF(THIS.this_nTipos = 1, "S", "E")
            loc_nOper = IIF(THIS.this_nTipos = 1, 2, 1)
            loc_cDtI  = FormatarDataSQL(THIS.this_dDtIni)
            loc_cDtF  = FormatarDataSQL(THIS.this_dDtFin)

            *-- Query 1: busca NF-e em SigMvNfi
            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Emis AS Datas, " + ;
                       "a.TotNotas AS Valos, a.NFis AS Notas, a.Series, " + ;
                       "a.EmpDopNums, o2.PalmEsts " + ;
                       "FROM SigMvNfi a, SigCdOpe o, SigOpCdd o2, SigMvCab e " + ;
                       "WHERE a.Emis BETWEEN " + loc_cDtI + ;
                       " AND DATEADD(second, 86399, " + loc_cDtF + ") " + ;
                       "AND a.Emps = " + EscaparSQL(loc_cEmp) + " " + ;
                       IIF(EMPTY(ALLTRIM(loc_cSer)), "", ;
                           "AND a.Series = " + EscaparSQL(loc_cSer) + " ") + ;
                       "AND a.Operas = " + EscaparSQL(loc_cOper) + " " + ;
                       "AND a.Dopes = o.Dopes " + ;
                       "AND o.Dopes = o2.Dopes " + ;
                       "AND o.Opers = " + TRANSFORM(loc_nOper) + " " + ;
                       "AND a.EmpDopNums = e.EmpDopNums " + ;
                       "AND e.LCancelas = 0 " + ;
                       IIF(THIS.this_nProcessados = 1, ;
                           "AND a.EmpDopNums NOT IN (SELECT b.EmpDopNums FROM sigprnfe b) ", ;
                           IIF(THIS.this_nProcessados = 2, ;
                               "AND a.EmpDopNums IN (SELECT b.EmpDopNums FROM sigprnfe b) ", "")) + ;
                       "ORDER BY a.Emps, a.Dopes, a.Numes"

            IF USED("cursor_4c_SigDados")
                USE IN cursor_4c_SigDados
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigDados")
            IF loc_nRet < 1
                MsgErro("Falha na consulta de NF-e (SigMvNfi). Verifique a conex" + ;
                        CHR(227) + "o.", "Sele" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE

            *-- Monta lista de EmpDopNums para query sigprnfe
            SELECT cursor_4c_SigDados
            GO TOP
            loc_cCheOpe = ""
            SCAN
                loc_cCheOpe = loc_cCheOpe + ;
                    IIF(EMPTY(loc_cCheOpe), "", ",") + ;
                    "'" + ALLTRIM(cursor_4c_SigDados.EmpDopNums) + "'"
            ENDSCAN

            IF EMPTY(loc_cCheOpe)
                loc_cCheOpe = "'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'"
            ENDIF

            *-- Query 2: busca registros sigprnfe (controle de processamento)
            loc_cSQL2 = "SELECT a.* FROM sigprnfe a " + ;
                        "WHERE a.EmpDopNums IN (" + loc_cCheOpe + ")"

            IF USED("cursor_4c_NfeSel1")
                USE IN cursor_4c_NfeSel1
            ENDIF
            IF USED("cursor_4c_NfeSel")
                USE IN cursor_4c_NfeSel
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_NfeSel1")
            IF loc_nRet < 1
                MsgErro("Falha na consulta sigprnfe. Verifique a conex" + ;
                        CHR(227) + "o.", "Sele" + CHR(231) + CHR(227) + "o")
                IF USED("cursor_4c_SigDados")
                    USE IN cursor_4c_SigDados
                ENDIF
                loc_lResultado = .F.
            ELSE

            *-- Filtra sigprnfe pelos EmpDopNums encontrados + ordena por data desc
            SELECT a.* FROM cursor_4c_NfeSel1 a ;
                WHERE a.EmpDopNums IN ;
                    (SELECT b.EmpDopNums FROM cursor_4c_SigDados b) ;
                ORDER BY a.EmpDopNums, a.datas DESC ;
                INTO CURSOR cursor_4c_NfeSel READWRITE

            *-- Query 3: busca series NF-e eletronica (ImpNfs = 3)
            loc_cSQL3 = "SELECT a.Emps, a.Cods AS Series, a.ImpNfs " + ;
                        "FROM SigCdSer a " + ;
                        "WHERE a.ImpNfs = 3 " + ;
                        "ORDER BY a.Emps, a.Cods, a.ImpNfs"

            IF USED("cursor_4c_SeriesNFe")
                USE IN cursor_4c_SeriesNFe
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL3, "cursor_4c_SeriesNFe")

            *-- Recria cursor destino com estrutura csOperacoes
            IF USED(loc_cCursor)
                ZAP IN (loc_cCursor)
            ELSE
                SET NULL ON
                CREATE CURSOR (loc_cCursor) ( ;
                    SelImp  L(1) NULL, ;
                    Emps    C(3) NULL, ;
                    Dopes   C(20) NULL, ;
                    Numes   N(6,0) NULL, ;
                    Datas   D(8) NULL, ;
                    Valos   N(12,2) NULL, ;
                    Notas   C(10) NULL, ;
                    Series  C(3) NULL, ;
                    NFMemo  M(4) NULL, ;
                    Erros   M(4) NULL, ;
                    Tipos   N(1,0) NULL, ;
                    stats   C(3) NULL, ;
                    ids     C(47) NULL, ;
                    lotes   C(15) NULL, ;
                    recibos C(15) NULL, ;
                    prots   C(15) NULL, ;
                    statts  C(1) NULL ;
                )
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6) TAG Notas
                SET NULL OFF
            ENDIF

            *-- Popula cursor destino
            SELECT cursor_4c_SigDados
            GO TOP
            SCAN
                *-- Verifica se a serie eh NF-e (ImpNfs=3)
                SELECT cursor_4c_SeriesNFe
                GO TOP
                LOCATE FOR ALLTRIM(Emps) = ALLTRIM(cursor_4c_SigDados.Emps) ;
                    AND ALLTRIM(Series) = PADR(ALLTRIM(cursor_4c_SigDados.Series), 3)
                IF EOF("cursor_4c_SeriesNFe")
                    GO TOP IN cursor_4c_SeriesNFe
                    LOCATE FOR EMPTY(ALLTRIM(Emps)) ;
                        AND ALLTRIM(Series) = PADR(ALLTRIM(cursor_4c_SigDados.Series), 3)
                ENDIF

                *-- Busca registro em sigprnfe correspondente
                SELECT cursor_4c_NfeSel
                GO TOP
                LOCATE FOR ALLTRIM(EmpDopNums) = ALLTRIM(cursor_4c_SigDados.EmpDopNums)

                IF !EOF("cursor_4c_SeriesNFe")
                    INSERT INTO (loc_cCursor) ;
                        (SelImp, Emps, Dopes, Numes, Datas, Valos, ;
                         Notas, Series, Tipos, stats, ids, lotes, recibos, prots, statts) ;
                        VALUES (.F., ;
                                cursor_4c_SigDados.Emps, ;
                                cursor_4c_SigDados.Dopes, ;
                                cursor_4c_SigDados.Numes, ;
                                cursor_4c_SigDados.Datas, ;
                                cursor_4c_SigDados.Valos, ;
                                cursor_4c_SigDados.Notas, ;
                                cursor_4c_SigDados.Series, ;
                                MAX(cursor_4c_SigDados.PalmEsts, 1), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.stats), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.ids), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.lotes), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.recibos), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.prots), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.statts), ""))
                ENDIF
                SELECT cursor_4c_SigDados
            ENDSCAN

            *-- Fecha cursores temporarios
            IF USED("cursor_4c_SigDados")
                USE IN cursor_4c_SigDados
            ENDIF
            IF USED("cursor_4c_NfeSel1")
                USE IN cursor_4c_NfeSel1
            ENDIF
            IF USED("cursor_4c_NfeSel")
                USE IN cursor_4c_NfeSel
            ENDIF
            IF USED("cursor_4c_SeriesNFe")
                USE IN cursor_4c_SeriesNFe
            ENDIF

            *-- Posiciona no inicio do cursor destino
            SELECT (loc_cCursor)
            SET ORDER TO TAG Notas
            GO TOP

            loc_lResultado = !EOF(loc_cCursor)

            ENDIF  && query2 ok
            ENDIF  && query1 ok

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Selecionar")
            IF USED("cursor_4c_SigDados")
                USE IN cursor_4c_SigDados
            ENDIF
            IF USED("cursor_4c_NfeSel1")
                USE IN cursor_4c_NfeSel1
            ENDIF
            IF USED("cursor_4c_NfeSel")
                USE IN cursor_4c_NfeSel
            ENDIF
            IF USED("cursor_4c_SeriesNFe")
                USE IN cursor_4c_SeriesNFe
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarEmpresa - Carrega dados da empresa de SigCdEmp para this_*
    * par_cCemps: codigo empresa (char(3))
    * Retorna .T. se encontrou, .F. se nao encontrou ou erro
    *==========================================================================
    PROCEDURE CarregarEmpresa(par_cCemps)
        LOCAL loc_lResultado, loc_oErro, loc_nRet, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdEmp WHERE NOT Ativas = 2"

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar dados de empresa.", "Erro")
                loc_lResultado = .F.
            ELSE

            SELECT cursor_4c_Empresa
            GO TOP
            LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(par_cCemps)

            IF !EOF("cursor_4c_Empresa")
                THIS.this_cCemps      = ALLTRIM(NVL(Cemps, ""))
                THIS.this_cRazas      = ALLTRIM(NVL(Razas, ""))
                THIS.this_cEstas      = ALLTRIM(NVL(estas, ""))
                THIS.this_nRegimeEmp  = NVL(Regimes, 0)
                THIS.this_cTextoNFe   = ALLTRIM(NVL(textonfe, ""))
                THIS.this_cEmailNFe   = ALLTRIM(NVL(emailnfe, ""))
                THIS.this_cServs      = ALLTRIM(NVL(servs, ""))
                THIS.this_cSenhas     = ALLTRIM(NVL(senhas, ""))
                THIS.this_nPortas     = NVL(portas, 0)
                THIS.this_cArquivos   = ALLTRIM(NVL(pastas, ""))
                THIS.this_cCnpj       = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(NVL(cgcs,""),".",""),"-",""),"/",""))

                DO CASE
                    CASE THIS.this_nRegimeEmp = 1
                        THIS.this_cRegime = "Simples Nacional"
                    CASE THIS.this_nRegimeEmp = 2
                        THIS.this_cRegime = "Lucro Presumido"
                    CASE THIS.this_nRegimeEmp = 3
                        THIS.this_cRegime = "Lucro Real"
                    CASE THIS.this_nRegimeEmp = 4
                        THIS.this_cRegime = "Lucro Arbitrado"
                    OTHERWISE
                        THIS.this_cRegime = ""
                ENDCASE

                loc_lResultado = .T.
            ELSE
                MsgAviso("Empresa " + ALLTRIM(par_cCemps) + " n" + CHR(227) + ;
                         "o encontrada ou inativa.", "Empresa")
            ENDIF

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            ENDIF  && sqlexec ok

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarEmpresa")
            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Registra NF-e processada em sigprnfe
    * Popula THIS.this_cPkSigPrNfe com cidchaves gerado
    * Retorna .T. se inseriu com sucesso
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cEmpDopNums
        loc_lResultado = .F.
        TRY
            loc_cCidChaves  = LEFT(fUniqueIds(), 20)
            loc_cEmpDopNums = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                              ALLTRIM(THIS.this_cDopes) + ;
                              PADL(ALLTRIM(STR(THIS.this_nNumes, 6)), 6)

            loc_cSQL = "INSERT INTO sigprnfe " + ;
                       "(cidchaves, empdopnums, emps, dopes, numes, datas, usuars, " + ;
                       " arquivos, notas, ids, lotes, recibos, prots, stats, statts, numeronota) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cCidChaves) + ", " + ;
                       EscaparSQL(LEFT(loc_cEmpDopNums, 29)) + ", " + ;
                       EscaparSQL(LEFT(PADR(ALLTRIM(THIS.this_cEmps), 3), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cArquivoNFe), 250)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNotas), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cId), 47)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cLote), 15)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cRecibo), 15)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cProt), 15)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cStats), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cStatts), 1)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumeronota), 10)) + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao registrar NF-e em sigprnfe.", "Erro Inserir")
            ELSE
                THIS.this_cPkSigPrNfe = loc_cCidChaves
                THIS.RegistrarAuditoria("I")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Inserir")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza SigMvNfi com conteudo NF-e apos processamento SEFAZ
    * Atualiza: nfetxt, nfexml, nfepdf, nfechv, nfeprt, impress
    * Usa this_cCidChaves como PK para identificar o registro
    * Retorna .T. se atualizou com sucesso
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        LOCAL loc_mNfeTxt, loc_mNfeXml, loc_mNfePdf
        loc_lResultado = .F.
        TRY
            *-- Usa this_cCidChaves (PK) ou busca por EmpDopNums se nao definido
            IF EMPTY(THIS.this_cCidChaves)
                LOCAL loc_cSQLBusca, loc_nRetBusca
                loc_cSQLBusca = "SELECT TOP 1 cidchaves FROM SigMvNfi " + ;
                                "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))
                IF USED("cursor_4c_ChaveMvNfi")
                    USE IN cursor_4c_ChaveMvNfi
                ENDIF
                loc_nRetBusca = SQLEXEC(gnConnHandle, loc_cSQLBusca, "cursor_4c_ChaveMvNfi")
                IF loc_nRetBusca >= 1 .AND. RECCOUNT("cursor_4c_ChaveMvNfi") > 0
                    SELECT cursor_4c_ChaveMvNfi
                    GO TOP
                    THIS.this_cCidChaves = ALLTRIM(NVL(cidchaves, ""))
                ENDIF
                IF USED("cursor_4c_ChaveMvNfi")
                    USE IN cursor_4c_ChaveMvNfi
                ENDIF
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel identificar o registro em SigMvNfi.", ;
                        "Erro Atualizar")
                loc_lResultado = .F.
            ELSE

            *-- Prepara memo vars para parametrizacao (TEXT columns)
            loc_mNfeTxt = THIS.this_cNfeTxt
            loc_mNfeXml = THIS.this_cNfeXml
            loc_mNfePdf = THIS.this_cNfePdf

            loc_cSQL = "UPDATE SigMvNfi SET " + ;
                       "nfetxt = ?loc_mNfeTxt, " + ;
                       "nfexml = ?loc_mNfeXml, " + ;
                       "nfepdf = ?loc_mNfePdf, " + ;
                       "nfechv = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cId), 44)) + ", " + ;
                       "nfeprt = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNfePrt), 15)) + ", " + ;
                       "impress = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar SigMvNfi com conte" + CHR(250) + ;
                        "do NF-e.", "Erro Atualizar")
            ELSE
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

            ENDIF  && cidchaves ok

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Atualizar")
            IF USED("cursor_4c_ChaveMvNfi")
                USE IN cursor_4c_ChaveMvNfi
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave do registro NF-e atual
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cId
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    * par_cOperacao: "I"=Inserir, "A"=Atualizar, "E"=Excluir
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro, loc_cSQL, loc_nRet
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("sigprnfe") + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(par_cOperacao), 1)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 50)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChecarDirs - Configura caminhos das pastas NF-e a partir de this_cArquivos
    * Carrega tambem dados do responsavel tecnico (SigCdParac)
    *==========================================================================
    PROCEDURE ChecarDirs()
        LOCAL loc_cBase, loc_oErro, loc_nRet
        TRY
            IF USED("cursor_4c_Parac")
                USE IN cursor_4c_Parac
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, "SELECT TOP 1 * FROM SigCdParac", "cursor_4c_Parac")
            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_Parac") > 0
                SELECT cursor_4c_Parac
                GO TOP
                THIS.this_cRTcnpj = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(NVL(cifcnpjs,""),".",""),"-",""),"/",""))
                THIS.this_cRTcont = ALLTRIM(NVL(cifconts,""))
                THIS.this_cRTemai = ALLTRIM(NVL(cifendes,""))
                THIS.this_cRTtel  = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(NVL(ciftels,""),"(",""),"-",""),")",""))
            ENDIF
            IF USED("cursor_4c_Parac")
                USE IN cursor_4c_Parac
            ENDIF

            loc_cBase = ALLTRIM(THIS.this_cArquivos)
            IF EMPTY(loc_cBase)
                RETURN
            ENDIF
            IF RIGHT(loc_cBase, 1) # "\"
                loc_cBase = loc_cBase + "\"
            ENDIF
            THIS.this_cPathNFe      = loc_cBase
            THIS.this_cPEnvio       = loc_cBase + "envio\"
            THIS.this_cPEnviado     = loc_cBase + "enviados\"
            THIS.this_cPEnvioEmLote = loc_cBase + "emLote\"
            THIS.this_cPErro        = loc_cBase + "erros\"
            THIS.this_cPRetorno     = loc_cBase + "retorno\"
            THIS.this_cPValidar     = loc_cBase + "avalidar\"
            THIS.this_cPBKenviados  = loc_cBase + "bkp_enviados\"
            THIS.this_cPEmProc      = loc_cBase + "emprocessamento\"
            THIS.this_cPAssinado    = loc_cBase + "assinados\"
            THIS.this_cPValidado    = loc_cBase + "validados\"
            THIS.this_cPAutorizados = loc_cBase + "autorizados\"
            THIS.this_cPPdf         = loc_cBase + "pdfs\"
            THIS.this_cPBkp         = loc_cBase + "backup\"
            THIS.this_cPTxt         = IIF(THIS.this_nTipos = 1, "nfe-", "nfe-e-")
            THIS.this_cChr          = CHR(13) + CHR(10)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ChecarDirs")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GerarNomeArquivo - Gera nome unico de arquivo para NF-e na pasta indicada
    * par_cPasta: pasta destino (ex: this_cPEnvio)
    * par_cPref: prefixo (ex: "nfe-")
    * par_cExt: extensao sem ponto (ex: "txt")
    *==========================================================================
    PROTECTED PROCEDURE GerarNomeArquivo(par_cPasta, par_cPref, par_cExt)
        LOCAL loc_cBase, loc_cNom, loc_nIdx
        loc_cBase = ALLTRIM(par_cPasta)
        IF RIGHT(loc_cBase, 1) # "\"
            loc_cBase = loc_cBase + "\"
        ENDIF
        loc_nIdx = 0
        loc_cNom = ""
        DO WHILE .T.
            loc_cNom = loc_cBase + ALLTRIM(par_cPref) + "-" + ;
                       LEFT(DTOS(DATE()), 4) + "-" + SUBSTR(DTOS(DATE()), 5, 2) + ;
                       "-" + RIGHT(DTOS(DATE()), 2) + "-" + ;
                       IIF(THIS.this_nTipos = 1, "S", "E") + ;
                       PADL(TRANSFORM(loc_nIdx), 2, "0") + "." + ALLTRIM(par_cExt)
            IF !FILE(loc_cNom)
                STRTOFILE("", loc_cNom)
                EXIT
            ENDIF
            loc_nIdx = loc_nIdx + 1
        ENDDO
        RETURN loc_cNom
    ENDPROC

    *==========================================================================
    * Processamento - Loop principal: processa NF-es selecionadas em csOperacoes
    * par_cEmps: codigo empresa (char 3)
    * par_cSeries: serie NF-e (char 3)
    *==========================================================================
    PROCEDURE Processamento(par_cEmps, par_cSeries)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_oProgress, loc_nTotal, loc_nProc, loc_nErro, loc_lOkReg
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ContSel")
                USE IN cursor_4c_ContSel
            ENDIF
            SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_ContSel
            loc_nTotal = cursor_4c_ContSel.nSel
            USE IN cursor_4c_ContSel

            IF loc_nTotal = 0
                MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado para processamento.")
                loc_lResultado = .F.
            ENDIF

            THIS.ChecarDirs()
            THIS.this_nTotalProcessados = 0
            THIS.this_nTotalErros       = 0
            loc_nProc = 0
            loc_nErro = 0

            loc_oProgress = CREATEOBJECT("fwprogressbar", "Processamento NF-e", loc_nTotal)
            IF VARTYPE(loc_oProgress) = "O"
                loc_oProgress.Show()
            ENDIF

            SELECT csOperacoes
            GO TOP
            SCAN FOR SelImp
                THIS.CarregarDoCursor("csOperacoes")

                DO CASE
                    CASE THIS.this_nAcao = 1
                        loc_lOkReg = THIS.ProcessarEnvio()
                    CASE THIS.this_nAcao = 2
                        loc_lOkReg = THIS.ProcessarConsulta()
                    CASE THIS.this_nAcao = 3
                        loc_lOkReg = THIS.ProcessarCancelamento()
                    CASE THIS.this_nAcao = 5
                        loc_lOkReg = THIS.GerarPDF()
                    CASE THIS.this_nAcao = 6
                        loc_lOkReg = THIS.EnviarEmail()
                    CASE THIS.this_nAcao = 7
                        loc_lOkReg = THIS.ConsultarStatus()
                    OTHERWISE
                        loc_lOkReg = .T.
                ENDCASE

                IF loc_lOkReg
                    loc_nProc = loc_nProc + 1
                ELSE
                    loc_nErro = loc_nErro + 1
                ENDIF

                IF VARTYPE(loc_oProgress) = "O"
                    loc_oProgress.SubTitulo.Caption = ;
                        TRANSFORM(loc_nProc + loc_nErro) + " de " + TRANSFORM(loc_nTotal)
                    loc_oProgress.Update(.T.)
                ENDIF

                SELECT csOperacoes
            ENDSCAN

            THIS.this_nTotalProcessados = loc_nProc
            THIS.this_nTotalErros       = loc_nErro

            IF VARTYPE(loc_oProgress) = "O"
                loc_oProgress.Complete(.T.)
                loc_oProgress = .NULL.
            ENDIF

            IF loc_nErro = 0
                MsgInfo("Processamento conclu" + CHR(237) + "do." + CHR(13) + ;
                        TRANSFORM(loc_nProc) + " NF(s) processada(s) com sucesso.")
            ELSE
                MsgAviso("Processamento conclu" + CHR(237) + "do." + CHR(13) + ;
                         "Processados: " + TRANSFORM(loc_nProc) + CHR(13) + ;
                         "Com erro: " + TRANSFORM(loc_nErro))
            ENDIF

            loc_lResultado = (loc_nProc > 0)
        CATCH TO loc_oErro
            IF VARTYPE(loc_oProgress) = "O"
                loc_oProgress = .NULL.
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Processamento")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarEnvio - Grava TXT NF-e na pasta de envio e aguarda retorno SEFAZ
    * O servico transmissor externo (Fortyus/NFeio) assina e envia; retorna
    * o protocolo na pasta de retorno. Retorna .T. se autorizada.
    *==========================================================================
    PROTECTED PROCEDURE ProcessarEnvio()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nRet, loc_cArqTxt, loc_cArqRet
        LOCAL loc_cResposta, loc_nWait
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPathNFe))
                MsgErro("Pasta NF-e n" + CHR(227) + "o configurada." + CHR(13) + ;
                        "Informe o caminho no campo Arquivos.", "Envio NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT TOP 1 nfetxt, nfechv FROM SigMvNfi " + ;
                       "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))
            IF USED("cursor_4c_NfeTxt")
                USE IN cursor_4c_NfeTxt
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeTxt")
            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeTxt") > 0
                SELECT cursor_4c_NfeTxt
                GO TOP
                THIS.this_cConteudoTXT = NVL(nfetxt, "")
                THIS.this_cId          = ALLTRIM(NVL(nfechv, ""))
            ENDIF
            IF USED("cursor_4c_NfeTxt")
                USE IN cursor_4c_NfeTxt
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cConteudoTXT))
                MsgErro("Conte" + CHR(250) + "do TXT da NF " + ;
                        ALLTRIM(THIS.this_cNotas) + " n" + CHR(227) + "o encontrado.", "Envio NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cArqTxt = THIS.GerarNomeArquivo(THIS.this_cPEnvio, THIS.this_cPTxt, "txt")
            THIS.this_cArquivoNFe = loc_cArqTxt
            STRTOFILE(ALLTRIM(THIS.this_cConteudoTXT), loc_cArqTxt)

            loc_cArqRet = STRTRAN(loc_cArqTxt, THIS.this_cPEnvio, THIS.this_cPRetorno)
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 60
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqRet)
                loc_cResposta = FILETOSTR(loc_cArqRet)
                THIS.this_cProt   = ALLTRIM(STREXTRACT(loc_cResposta, "<nProt>", "</nProt>", 1))
                THIS.this_cRecibo = ALLTRIM(STREXTRACT(loc_cResposta, "<nRec>",  "</nRec>",  1))
                THIS.this_cStats  = IIF(!EMPTY(ALLTRIM(THIS.this_cProt)), "100", "900")
                THIS.this_cNfePrt = THIS.this_cProt
                THIS.Atualizar()
                THIS.Inserir()
                SELECT csOperacoes
                REPLACE stats   WITH THIS.this_cStats, ;
                        prots   WITH THIS.this_cProt, ;
                        recibos WITH THIS.this_cRecibo, ;
                        ids     WITH THIS.this_cId
                loc_lResultado = (THIS.this_cStats = "100")
            ELSE
                MsgErro("Tempo esgotado aguardando SEFAZ para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "Envio NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Envio")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarConsulta - Consulta situacao da NF-e na SEFAZ via arquivo XML
    *==========================================================================
    PROTECTED PROCEDURE ProcessarConsulta()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nRet, loc_cArqXml, loc_cArqRet
        LOCAL loc_cResposta, loc_nWait, loc_cAmb
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_NfeSit")
                USE IN cursor_4c_NfeSit
            ENDIF
            loc_cSQL = "SELECT TOP 1 ids, stats, prots FROM sigprnfe " + ;
                       "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ;
                       " ORDER BY datas DESC"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeSit")
            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeSit") > 0
                SELECT cursor_4c_NfeSit
                GO TOP
                THIS.this_cId    = ALLTRIM(NVL(ids, ""))
                THIS.this_cStats = ALLTRIM(NVL(stats, ""))
                THIS.this_cProt  = ALLTRIM(NVL(prots, ""))
            ENDIF
            IF USED("cursor_4c_NfeSit")
                USE IN cursor_4c_NfeSit
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada.", "Consulta NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cAmb    = IIF(THIS.this_nAmbiente = 2, "2", "1")
            LOCAL loc_cXmlPed
            loc_cXmlPed = "<?xml version=""1.0"" encoding=""UTF-8""?>" + THIS.this_cChr + ;
                          "<consSitNFe versao=""4.00"">" + THIS.this_cChr + ;
                          "<tpAmb>" + loc_cAmb + "</tpAmb>" + THIS.this_cChr + ;
                          "<xServ>CONSULTAR</xServ>" + THIS.this_cChr + ;
                          "<chNFe>" + THIS.this_cId + "</chNFe>" + THIS.this_cChr + ;
                          "</consSitNFe>"

            loc_cArqXml = THIS.GerarNomeArquivo(THIS.this_cPEnvio, THIS.this_cPTxt + "ped-sit", "xml")
            STRTOFILE(loc_cXmlPed, loc_cArqXml)

            loc_cArqRet = STRTRAN(loc_cArqXml, THIS.this_cPEnvio, THIS.this_cPRetorno)
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 60
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqRet)
                loc_cResposta    = FILETOSTR(loc_cArqRet)
                THIS.this_cProt  = ALLTRIM(STREXTRACT(loc_cResposta, "<nProt>", "</nProt>", 1))
                THIS.this_cStats = IIF(!EMPTY(ALLTRIM(THIS.this_cProt)), "100", "900")
                SELECT csOperacoes
                REPLACE stats WITH THIS.this_cStats, prots WITH THIS.this_cProt
                loc_lResultado = .T.
            ELSE
                MsgErro("Tempo esgotado aguardando consulta para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "Consulta NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Consulta")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarCancelamento - Cancela NF-e autorizada via arquivo XML
    *==========================================================================
    PROTECTED PROCEDURE ProcessarCancelamento()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArqXml, loc_cArqRet, loc_cResposta, loc_nWait
        LOCAL loc_cAmb, loc_cJust, loc_cXmlCan, loc_cCodStat
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada para cancelamento.", "Cancelamento NF-e")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cProt))
                MsgErro("Protocolo n" + CHR(227) + "o encontrado." + CHR(13) + ;
                        "A NF-e deve estar autorizada para ser cancelada.", "Cancelamento NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cAmb  = IIF(THIS.this_nAmbiente = 2, "2", "1")
            loc_cJust = "Cancelamento da NF-e conforme solicitado pelo emitente"

            loc_cXmlCan = "<?xml version=""1.0"" encoding=""UTF-8""?>" + THIS.this_cChr + ;
                          "<cancNFe versao=""4.00"">" + THIS.this_cChr + ;
                          "<infCanc>" + THIS.this_cChr + ;
                          "<tpAmb>" + loc_cAmb + "</tpAmb>" + THIS.this_cChr + ;
                          "<xServ>CANCELAR</xServ>" + THIS.this_cChr + ;
                          "<chNFe>" + THIS.this_cId + "</chNFe>" + THIS.this_cChr + ;
                          "<nProt>" + THIS.this_cProt + "</nProt>" + THIS.this_cChr + ;
                          "<xJust>" + loc_cJust + "</xJust>" + THIS.this_cChr + ;
                          "</infCanc>" + THIS.this_cChr + ;
                          "</cancNFe>"

            loc_cArqXml = THIS.GerarNomeArquivo(THIS.this_cPEnvio, THIS.this_cPTxt + "ped-can", "xml")
            STRTOFILE(loc_cXmlCan, loc_cArqXml)

            loc_cArqRet = STRTRAN(loc_cArqXml, THIS.this_cPEnvio, THIS.this_cPRetorno)
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 60
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqRet)
                loc_cResposta = FILETOSTR(loc_cArqRet)
                loc_cCodStat  = ALLTRIM(STREXTRACT(loc_cResposta, "<cStat>", "</cStat>", 1))
                THIS.this_cStats = IIF(INLIST(loc_cCodStat, "101", "135"), "CAN", "900")
                SELECT csOperacoes
                REPLACE stats WITH THIS.this_cStats
                loc_lResultado = (THIS.this_cStats = "CAN")
            ELSE
                MsgErro("Tempo esgotado aguardando cancelamento para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "Cancelamento NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Cancelamento")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GerarPDF - Verifica/solicita PDF DANFE da NF-e via pasta de PDFs
    *==========================================================================
    PROTECTED PROCEDURE GerarPDF()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nRet, loc_cArqPdf, loc_cArqXml, loc_nWait
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada para gerar PDF.", "PDF NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cArqPdf = THIS.this_cPPdf + THIS.this_cId + "-nfe.pdf"
            IF FILE(loc_cArqPdf)
                THIS.this_cDanfe      = loc_cArqPdf
                THIS.this_cConteudoPDF = FILETOSTR(loc_cArqPdf)
                loc_lResultado = .T.
            ENDIF

            *-- Precisa gerar: busca XML de SigMvNfi e solicita via pasta
            IF EMPTY(ALLTRIM(THIS.this_cConteudoXML))
                loc_cSQL = "SELECT TOP 1 nfexml FROM SigMvNfi WHERE empdopnums = " + ;
                           EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))
                IF USED("cursor_4c_NfeXml")
                    USE IN cursor_4c_NfeXml
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeXml")
                IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeXml") > 0
                    SELECT cursor_4c_NfeXml
                    GO TOP
                    THIS.this_cConteudoXML = NVL(nfexml, "")
                ENDIF
                IF USED("cursor_4c_NfeXml")
                    USE IN cursor_4c_NfeXml
                ENDIF
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cConteudoXML))
                MsgErro("XML da NF " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrado para gerar PDF.", "PDF NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cArqXml = THIS.this_cPPdf + THIS.this_cId + "-nfe.xml"
            STRTOFILE(ALLTRIM(THIS.this_cConteudoXML), loc_cArqXml)

            loc_nWait = 0
            DO WHILE !FILE(loc_cArqPdf) AND loc_nWait < 30
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqPdf)
                THIS.this_cDanfe       = loc_cArqPdf
                THIS.this_cConteudoPDF = FILETOSTR(loc_cArqPdf)
                loc_lResultado = .T.
            ELSE
                MsgErro("PDF n" + CHR(227) + "o gerado para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "PDF NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GerarPDF")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * EnviarEmail - Prepara e envia NF-e por email usando config SMTP de SigCdEmp
    *==========================================================================
    PROTECTED PROCEDURE EnviarEmail()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cXmlFile, loc_cPdfFile, loc_cAssunto
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmailNFe))
                MsgErro("Email NF-e n" + CHR(227) + "o configurado em SigCdEmp." + CHR(13) + ;
                        "Preencha o campo emailnfe.", "Email NF-e")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada.", "Email NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cXmlFile = THIS.this_cPAutorizados + THIS.this_cId + "-nfe.xml"
            loc_cPdfFile = THIS.this_cPPdf + THIS.this_cId + "-nfe.pdf"

            IF !FILE(loc_cXmlFile)
                MsgErro("Arquivo XML n" + CHR(227) + "o encontrado: " + CHR(13) + ;
                        loc_cXmlFile, "Email NF-e")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cServs)) OR THIS.this_nPortas = 0
                MsgErro("Configura" + CHR(231) + CHR(227) + "o SMTP incompleta em SigCdEmp." + CHR(13) + ;
                        "Preencha servs e portas.", "Email NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cAssunto = "NF-e " + ALLTRIM(THIS.this_cNotas) + " - " + ALLTRIM(THIS.this_cRazas)

            *-- Parametros SMTP para envio via servico externo (pasta emLote)
            PRIVATE cTo, cAssunto, cAnexo, cCorpo, cFrom, cCC, cServer, cSenha, nPorta
            m.cTo      = ALLTRIM(THIS.this_cEmailNFe)
            m.cAssunto = loc_cAssunto
            m.cAnexo   = loc_cXmlFile + IIF(FILE(loc_cPdfFile), ";" + loc_cPdfFile, "")
            m.cCorpo   = IIF(EMPTY(ALLTRIM(THIS.this_cTextoNFe)), ;
                             "Segue em anexo a NF-e " + ALLTRIM(THIS.this_cNotas) + ".", ;
                             ALLTRIM(THIS.this_cTextoNFe))
            m.cFrom    = ALLTRIM(THIS.this_cEmailNFe)
            m.cCC      = ALLTRIM(THIS.this_cEmailNFe)
            m.cServer  = ALLTRIM(THIS.this_cServs)
            m.cSenha   = ALLTRIM(THIS.this_cSenhas)
            m.nPorta   = THIS.this_nPortas

            *-- Grava arquivo de controle na pasta emLote para o servico transmissor
            LOCAL loc_cArqEmail
            loc_cArqEmail = THIS.this_cPEnvioEmLote + THIS.this_cId + "-email.txt"
            STRTOFILE(m.cTo + "|" + m.cAssunto + "|" + m.cAnexo + "|" + m.cFrom, loc_cArqEmail)

            SELECT csOperacoes
            REPLACE statts WITH "E"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Email")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConsultarStatus - Le status atual da NF-e em sigprnfe e atualiza csOperacoes
    *==========================================================================
    PROTECTED PROCEDURE ConsultarStatus()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_NfeStatus")
                USE IN cursor_4c_NfeStatus
            ENDIF
            loc_cSQL = "SELECT TOP 1 ids, stats, prots, lotes, recibos FROM sigprnfe " + ;
                       "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ;
                       " ORDER BY datas DESC"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeStatus")
            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeStatus") > 0
                SELECT cursor_4c_NfeStatus
                GO TOP
                THIS.this_cId     = ALLTRIM(NVL(ids,     ""))
                THIS.this_cStats  = ALLTRIM(NVL(stats,   ""))
                THIS.this_cProt   = ALLTRIM(NVL(prots,   ""))
                THIS.this_cLote   = ALLTRIM(NVL(lotes,   ""))
                THIS.this_cRecibo = ALLTRIM(NVL(recibos, ""))
                SELECT csOperacoes
                REPLACE stats   WITH THIS.this_cStats, ;
                        prots   WITH THIS.this_cProt, ;
                        lotes   WITH THIS.this_cLote, ;
                        recibos WITH THIS.this_cRecibo, ;
                        ids     WITH THIS.this_cId
                loc_lResultado = .T.
            ELSE
                MsgAviso("NF " + ALLTRIM(THIS.this_cNotas) + ;
                         " n" + CHR(227) + "o encontrada em sigprnfe.")
            ENDIF
            IF USED("cursor_4c_NfeStatus")
                USE IN cursor_4c_NfeStatus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ConsultarStatus")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ImprimirSimplificado - Imprime relatorio listagem NF-es em csOperacoes
    * par_cCursorDados: cursor com os registros (default: "csOperacoes")
    *==========================================================================
    PROCEDURE ImprimirSimplificado(par_cCursorDados)
        LOCAL loc_lResultado, loc_oErro, loc_cCursor, loc_cFrx
        LOCAL loc_cPointAnt, loc_cSepAnt, loc_nBehavAnt
        loc_lResultado = .F.
        TRY
            loc_cCursor = IIF(PCOUNT() >= 1 AND !EMPTY(par_cCursorDados), ;
                              par_cCursorDados, "csOperacoes")
            loc_cFrx = gc_4c_CaminhoReports + "sigprnfe.frx"

            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum registro para impress" + CHR(227) + "o.")
                loc_lResultado = .F.
            ENDIF
            IF !FILE(loc_cFrx)
                MsgErro("Relat" + CHR(243) + "rio sigprnfe.frx n" + CHR(227) + ;
                        "o encontrado em:" + CHR(13) + gc_4c_CaminhoReports, ;
                        "Impress" + CHR(227) + "o Simplificada")
                loc_lResultado = .F.
            ENDIF

            loc_cPointAnt = SET("POINT")
            loc_cSepAnt   = SET("SEPARATOR")
            loc_nBehavAnt = SET("REPORTBEHAVIOR")
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            TRY
                SELECT (loc_cCursor)
                GO TOP
                REPORT FORM (loc_cFrx) PREVIEW
                loc_lResultado = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao imprimir")
            ENDTRY

            SET POINT TO (loc_cPointAnt)
            SET SEPARATOR TO (loc_cSepAnt)
            SET REPORTBEHAVIOR (loc_nBehavAnt)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ImprimirSimplificado")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CodIBGEUF - Retorna codigo IBGE da UF a partir de SigCdUfs
    * par_cEstas: sigla UF (char 2, ex: "BA")
    * Retorna: codigo IBGE numerico, 0 em caso de erro
    *==========================================================================
    PROCEDURE CodIBGEUF(par_cEstas)
        LOCAL loc_nRet, loc_nSql, loc_oErro
        loc_nRet = 0
        TRY
            IF USED("cursor_4c_LocalUF")
                USE IN cursor_4c_LocalUF
            ENDIF
            loc_nSql = SQLEXEC(gnConnHandle, ;
                "SELECT UFIBGEs FROM SigCdUfs WHERE Estados = '" + ;
                PADR(ALLTRIM(par_cEstas), 2) + "'", "cursor_4c_LocalUF")
            IF loc_nSql >= 1 AND USED("cursor_4c_LocalUF")
                SELECT cursor_4c_LocalUF
                GO TOP
                IF !EOF()
                    loc_nRet = cursor_4c_LocalUF.UFIBGEs
                ENDIF
            ENDIF
            IF USED("cursor_4c_LocalUF")
                USE IN cursor_4c_LocalUF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CodIBGEUF")
        ENDTRY
        RETURN loc_nRet
    ENDPROC

    *==========================================================================
    * SelecionarInutilizadas - Popula cursor nfAinu com candidatos a inutilizacao
    * Identifica gaps na numeracao NF-e (entre notas EMI e INU em sigprnfe)
    * par_cEmps: empresa filtro (char 3) - para contexto de log
    * Retorna .T. se cursor nfAinu criado com sucesso (pode estar vazio)
    *==========================================================================
    PROCEDURE SelecionarInutilizadas(par_cEmps)
        LOCAL loc_lResultado, loc_oErro, loc_nRet
        LOCAL loc_lcCnpj, loc_lcSeries, loc_lnNotaInu
        loc_lResultado = .F.
        TRY
            *-- Cria cursor nfAinu com schema correto (WHERE impossivel = cursor vazio)
            IF USED("nfAinu")
                USE IN nfAinu
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT DISTINCT emps, SUBSTRING(ids,7,14) AS cnpj, " + ;
                "SUBSTRING(ids,23,3) AS series, " + ;
                "SUBSTRING(ids,26,9) AS notai, SUBSTRING(ids,26,9) AS notaf " + ;
                "FROM sigprnfe WHERE stats = 'xxx'", "nfAinu")
            IF loc_nRet < 1
                MsgErro("Falha ao inicializar cursor de inutiliza" + CHR(231) + ;
                        CHR(227) + "o.", "SelecionarInutilizadas")
            ELSE
                *-- Carrega notas usadas (EMI e INU) para analise de gaps
                IF USED("cursor_4c_NfUsadas")
                    USE IN cursor_4c_NfUsadas
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT emps, SUBSTRING(ids,7,14) AS cnpj, " + ;
                    "SUBSTRING(ids,23,3) AS series, " + ;
                    "SUBSTRING(ids,26,9) AS notai, SUBSTRING(ids,26,9) AS notaf " + ;
                    "FROM sigprnfe WHERE stats = 'EMI' AND SUBSTRING(ids,26,9) <> '' " + ;
                    "UNION " + ;
                    "SELECT DISTINCT emps, SUBSTRING(ids,5,14) AS cnpj, " + ;
                    "SUBSTRING(ids,21,3) AS series, " + ;
                    "SUBSTRING(ids,24,9) AS notai, SUBSTRING(ids,33,9) AS notaf " + ;
                    "FROM sigprnfe WHERE stats = 'INU' AND SUBSTRING(ids,24,9) <> '' " + ;
                    "ORDER BY 1,2,4,5", "cursor_4c_NfUsadas")

                IF loc_nRet >= 1 AND USED("cursor_4c_NfUsadas")
                    *-- Filtra CNPJs validos e ordena
                    IF USED("cursor_4c_NfUsadas1")
                        USE IN cursor_4c_NfUsadas1
                    ENDIF
                    SELECT * FROM cursor_4c_NfUsadas ;
                        WHERE RTRIM(cnpj) != '' ;
                        ORDER BY cnpj, series, notai ;
                        INTO CURSOR cursor_4c_NfUsadas1

                    *-- Gap analysis: identifica numeros nao usados entre notas emitidas
                    loc_lnNotaInu = 1
                    SELECT cursor_4c_NfUsadas1
                    GO TOP
                    IF !EOF()
                        loc_lcCnpj   = ALLTRIM(cursor_4c_NfUsadas1.cnpj)
                        loc_lcSeries = ALLTRIM(cursor_4c_NfUsadas1.series)
                        DO WHILE !EOF("cursor_4c_NfUsadas1")
                            DO WHILE !EOF("cursor_4c_NfUsadas1") .AND. ;
                                     ALLTRIM(cursor_4c_NfUsadas1.cnpj)   = loc_lcCnpj .AND. ;
                                     ALLTRIM(cursor_4c_NfUsadas1.series) = loc_lcSeries
                                IF loc_lnNotaInu < VAL(ALLTRIM(cursor_4c_NfUsadas1.notai))
                                    SELECT nfAinu
                                    APPEND BLANK
                                    REPLACE notai WITH PADL(ALLTRIM(STR(loc_lnNotaInu)), 8, "0")
                                    DO WHILE loc_lnNotaInu < VAL(ALLTRIM(cursor_4c_NfUsadas1.notai))
                                        REPLACE emps   WITH cursor_4c_NfUsadas1.emps, ;
                                                cnpj   WITH cursor_4c_NfUsadas1.cnpj, ;
                                                series WITH cursor_4c_NfUsadas1.series, ;
                                                notaf  WITH PADL(ALLTRIM(STR(loc_lnNotaInu)), 8, "0")
                                        loc_lnNotaInu = loc_lnNotaInu + 1
                                    ENDDO
                                    SELECT cursor_4c_NfUsadas1
                                ENDIF
                                loc_lnNotaInu = VAL(ALLTRIM(cursor_4c_NfUsadas1.notaf)) + 1
                                EXIT
                            ENDDO
                            IF !EOF("cursor_4c_NfUsadas1") .AND. ;
                               (ALLTRIM(cursor_4c_NfUsadas1.cnpj)   != loc_lcCnpj .OR. ;
                                ALLTRIM(cursor_4c_NfUsadas1.series) != loc_lcSeries)
                                loc_lcCnpj   = ALLTRIM(cursor_4c_NfUsadas1.cnpj)
                                loc_lcSeries = ALLTRIM(cursor_4c_NfUsadas1.series)
                                loc_lnNotaInu = 1
                                LOOP
                            ENDIF
                            SELECT cursor_4c_NfUsadas1
                            IF !EOF()
                                SKIP
                            ENDIF
                        ENDDO
                    ENDIF
                    IF USED("cursor_4c_NfUsadas1")
                        USE IN cursor_4c_NfUsadas1
                    ENDIF
                ENDIF
                IF USED("cursor_4c_NfUsadas")
                    USE IN cursor_4c_NfUsadas
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SelecionarInutilizadas")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessaInutilizadas - Executa inutilizacao de numeracao NF-e/NFC-e
    * par_cEmps  : codigo empresa (char 3)
    * par_cSeries: serie (char 3 - ex: "001")
    * par_cCnpj  : CNPJ sem mascara (14 chars)
    * par_cNIni  : numero inicial (ex: "00000001")
    * par_cNFim  : numero final   (ex: "00000005")
    * Retorna .T. se inutilizacao aprovada pela SEFAZ (cStat = 102)
    *==========================================================================
    PROCEDURE ProcessaInutilizadas(par_cEmps, par_cSeries, par_cCnpj, par_cNIni, par_cNFim)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cAmb, loc_cMod, loc_cUf, loc_cAno, loc_cData
        LOCAL loc_cSer, loc_cNIni, loc_cNFim, loc_cId, loc_cXmlInu
        LOCAL loc_cArqXml, loc_cArqRet, loc_cResposta, loc_nWait
        LOCAL loc_cCodStat, loc_cCampo, loc_cProt, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            *-- Carrega dados da empresa e configura caminhos NF-e
            IF !THIS.CarregarEmpresa(ALLTRIM(par_cEmps))
                loc_lResultado = .F.
            ENDIF
            THIS.ChecarDirs()

            IF EMPTY(ALLTRIM(THIS.this_cPEnvio))
                MsgErro("Pasta NF-e n" + CHR(227) + "o configurada para empresa " + ;
                        ALLTRIM(par_cEmps) + ". Configure o campo Pastas em SigCdEmp.", ;
                        "Inutilizar NF-e")
                loc_lResultado = .F.
            ENDIF

            IF EMPTY(ALLTRIM(par_cCnpj))
                MsgErro("CNPJ n" + CHR(227) + "o informado para inutiliza" + ;
                        CHR(231) + CHR(227) + "o.", "Inutilizar NF-e")
                loc_lResultado = .F.
            ENDIF

            *-- Parametros basicos do XML
            loc_cAmb  = IIF(THIS.this_nAmbiente = 2, "2", "1")
            loc_cMod  = IIF(THIS.this_nAcao = 7, "65", "55")  && NFC-e=65, NF-e=55
            loc_cUf   = ALLTRIM(STR(THIS.CodIBGEUF(THIS.this_cEstas)))
            loc_cAno  = SUBSTR(DTOS(DATE()), 3, 2)
            loc_cData = DTOS(DATE())

            *-- Formata serie e numeros no padrao XML NF-e
            loc_cSer  = ALLTRIM(TRANSFORM(VAL(ALLTRIM(par_cSeries)), "@R 999"))
            loc_cNIni = ALLTRIM(TRANSFORM(VAL(ALLTRIM(par_cNIni)), "@R 999999999"))
            loc_cNFim = ALLTRIM(TRANSFORM(VAL(ALLTRIM(par_cNFim)), "@R 999999999"))

            *-- Chave de identificacao: cUF+AA+CNPJ+mod+serie+nIni+nFim
            loc_cId = loc_cUf + loc_cAno + ALLTRIM(par_cCnpj) + loc_cMod + ;
                      PADR(ALLTRIM(par_cSeries), 3) + ;
                      PADL(ALLTRIM(par_cNIni), 9, "0") + ;
                      PADL(ALLTRIM(par_cNFim), 9, "0")

            *-- Monta XML de inutilizacao conforme layout NF-e 4.00
            loc_cXmlInu = "<?xml version=""1.0"" encoding=""UTF-8""?>" + THIS.this_cChr + ;
                "<inutNFe versao=""4.00"" xmlns=""http://www.portalfiscal.inf.br/nfe"">" + THIS.this_cChr + ;
                "<infInut Id=""ID" + loc_cId + """>" + THIS.this_cChr + ;
                "<tpAmb>" + loc_cAmb + "</tpAmb>" + THIS.this_cChr + ;
                "<xServ>INUTILIZAR</xServ>" + THIS.this_cChr + ;
                "<cUF>" + loc_cUf + "</cUF>" + THIS.this_cChr + ;
                "<ano>" + loc_cAno + "</ano>" + THIS.this_cChr + ;
                "<CNPJ>" + ALLTRIM(par_cCnpj) + "</CNPJ>" + THIS.this_cChr + ;
                "<mod>" + loc_cMod + "</mod>" + THIS.this_cChr + ;
                "<serie>" + loc_cSer + "</serie>" + THIS.this_cChr + ;
                "<nNFIni>" + loc_cNIni + "</nNFIni>" + THIS.this_cChr + ;
                "<nNFFin>" + loc_cNFim + "</nNFFin>" + THIS.this_cChr + ;
                "<xJust>Ocorreu uma falha no sistema que pulou a sequencia de numeracao</xJust>" + THIS.this_cChr + ;
                "</infInut>" + THIS.this_cChr + ;
                "</inutNFe>"

            *-- Grava XML na pasta envio/ para o UniNFe assinar e transmitir
            loc_cArqXml = THIS.this_cPEnvio + loc_cId + "-ped-inu.XML"
            IF FILE(loc_cArqXml)
                DELETE FILE (loc_cArqXml)
            ENDIF
            STRTOFILE(loc_cXmlInu, loc_cArqXml)

            *-- Aguarda retorno SEFAZ na pasta retorno/ (timeout 180s)
            loc_cArqRet = THIS.this_cPRetorno + loc_cId + "-inu.XML"
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 180
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF !FILE(loc_cArqRet)
                MsgErro("Tempo esgotado aguardando retorno SEFAZ." + CHR(13) + ;
                        "Verifique se o UniNFe est" + CHR(225) + " ativo.", "Inutilizar NF-e")
                loc_lResultado = .F.
            ENDIF

            *-- Processa XML de retorno
            loc_cResposta = FILETOSTR(loc_cArqRet)
            loc_cCodStat  = ALLTRIM(STREXTRACT(loc_cResposta, "<cStat>", "</cStat>", 1))
            loc_cCampo    = ALLTRIM(STREXTRACT(loc_cResposta, "<xMotivo>", "</xMotivo>", 1))
            loc_cProt     = ALLTRIM(STREXTRACT(loc_cResposta, "<nProt>", "</nProt>", 1))
            DELETE FILE (loc_cArqRet)

            IF "102" $ loc_cCodStat
                *-- Aprovada: registra inutilizacao em sigprnfe
                loc_cSQL = "INSERT INTO sigprnfe " + ;
                           "(cidchaves, empdopnums, emps, dopes, numes, datas, usuars, " + ;
                           " ids, lotes, recibos, prots, stats) " + ;
                           "VALUES (" + ;
                           EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
                           EscaparSQL(LEFT(PADR(ALLTRIM(par_cEmps),3) + ;
                               "INUTILIZACAO" + PADL(ALLTRIM(par_cNIni), 6), 29)) + ", " + ;
                           EscaparSQL(LEFT(PADR(ALLTRIM(par_cEmps), 3), 3)) + ", " + ;
                           "'INUTILIZACAO', " + ;
                           FormatarNumeroSQL(VAL(ALLTRIM(par_cNIni)), 0) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(loc_cId), 47)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cNIni), 15)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cNFim), 15)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(loc_cProt), 15)) + ", " + ;
                           "'INU'" + ;
                           ")"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet >= 1
                    SQLEXEC(gnConnHandle, "COMMIT")
                    MsgInfo("Inutiliza" + CHR(231) + CHR(227) + "o aprovada." + CHR(13) + ;
                            STRCONV(loc_cCampo, 11))
                    loc_lResultado = .T.
                ELSE
                    MsgErro("SEFAZ aprovou mas falha ao registrar em sigprnfe.", "Inutilizar NF-e")
                ENDIF
            ELSE
                MsgErro("Inutiliza" + CHR(231) + CHR(227) + "o rejeitada." + CHR(13) + ;
                        "C" + CHR(243) + "d.: " + loc_cCodStat + CHR(13) + ;
                        STRCONV(loc_cCampo, 11), "Inutilizar NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ProcessaInutilizadas")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


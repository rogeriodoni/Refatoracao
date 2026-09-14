# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPdM14.prg] Procedure vazia (sem codigo): FormParaBO
[FormSigPdM14.prg] Procedure vazia (sem codigo): BtnBuscarClick

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM14.prg):
*==============================================================================
* FormSigPdM14.prg - Rateio de Componentes
* Origem: SIGPDM14.SCX (OPERACIONAL)
* Herda de: FormBase
* Tipo: OPERACIONAL - modal, recebe par_oForm (form pai) no Init
* DataSession=2: troca para datasession do form pai via SET DATASESSION em
*   InicializarForm para acessar cursores xNensi, xMFas, tmpnens, TmpDistrib
*==============================================================================

DEFINE CLASS FormSigPdM14 AS FormBase

    *-- Dimensoes identicas ao original (800x600)
    Width        = 800
    Height       = 600
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    AlwaysOnTop  = .T.
    AutoCenter   = .T.
    WindowType   = 1
    ClipControls = .F.
    DataSession  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia ao form pai que invocou este dialogo
    this_oParentForm = .NULL.
    *-- Modo de operacao copiado do form pai (pcEscolha): INSERIR ou ALTERAR
    this_cPcEscolha  = ""
    *-- Recno original de xNensi para restaurar ao fechar
    this_nRecnoAnt   = 0
    *-- Valores anteriores usados nos eventos de validacao do grid
    this_nAntValue   = 0
    this_nAntValueP  = 0
    *-- Casas decimais de quantidade (lidas de CrSigCdOpd.CasQtds)
    this_nCas        = 3

    *--------------------------------------------------------------------------
    * Init - armazena referencia ao form pai ANTES de FormBase.Init() rodar
    * par_oForm = form pai que instancia este dialogo modal
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oForm)
        IF VARTYPE(par_oForm) = "O"
            THIS.this_oParentForm = par_oForm
            THIS.this_cPcEscolha  = par_oForm.pcEscolha
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - chamado automaticamente por FormBase.Init()
    * Troca para datasession do form pai, le xNensi, monta TmpDistrib e UI
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Cria BO
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdM14BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao instanciar SigPdM14BO.", "Erro")
            ELSE
                *-- Troca para datasession do form pai para acessar xNensi, xMFas, tmpnens
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    SET DATASESSION TO THIS.this_oParentForm.DataSessionId
                ENDIF

                *-- Carrega dados de xNensi no BO (salva recno, campos, order)
                IF !THIS.this_oBusinessObject.CarregarDoCursor("xNensi")
                    MsgErro("Erro ao carregar dados de xNensi.", "Erro")
                ELSE
                    THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt

                    *-- Inicializa TmpDistrib com xMFas filtrado por Nenvs e distribui pesos
                    IF !THIS.this_oBusinessObject.InicializarCursores(THIS.this_oBusinessObject.this_nNenvs)
                        MsgErro("Erro ao inicializar cursores de distribui" + CHR(231) + CHR(227) + "o.", "Erro")
                    ELSE
                        *-- Casas decimais de quantidade para mascara do grid
                        THIS.this_nCas = THIS.this_oBusinessObject.ObterCasasDecimais()

                        THIS.LockScreen = .T.

                        THIS.ConfigurarPageFrame()
                        THIS.ConfigurarPaginaDados()
                        THIS.ConfigurarContainerMaterial()
                        THIS.ConfigurarDescricao()
                        THIS.ConfigurarPaginaLista()

                        THIS.PreencherContainerOperacao()
                        THIS.PreencherContainerMaterial()

                        THIS.TornarControlesVisiveis(THIS)

                        THIS.LockScreen = .F.
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - define imagem de fundo e caption sem literais acentuados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption  = "Rateio de Componentes"
        THIS.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.FontName = "Tahoma"
        THIS.FontSize = 8
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - configura primeira metade da UI (cabecalho + info
    * da movimentacao). Form OPERACIONAL plano: nao tem PageFrame Page2, mas
    * conceitualmente esta secao agrupa os campos identificadores (read-only)
    * que sao analogos aos "campos de dados" de um form CRUD.
    *
    * Inclui:
    *  - cnt_4c_Cabecalho (titulo + sombra)
    *  - Shape1 (separador vertical decorativo)
    *  - cnt_4c_Operacao (empresa + descricao da operacao + numero da NE +
    *                    label "Movimentacao" + linha separadora)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarShape1()
        THIS.ConfigurarContainerOperacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container escuro com titulo do form
    * Origem: cntSombra (Top=0, Left=0, Width=800, Height=80)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_cCaption
        loc_cCaption = "Rateio de Componentes"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCnt = THIS.cnt_4c_Cabecalho
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Sombra preta deslocada 1px para dar profundidade
        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0,0,0)
            .Caption       = loc_cCaption
            .Visible       = .T.
        ENDWITH

        *-- Titulo branco principal
        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(255,255,255)
            .Caption   = loc_cCaption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape1 - decorativo vertical entre campos e botoes
    * Origem: Shape1 (Top=7, Left=612, Height=41, Width=12)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape1()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 612
            .Height      = 41
            .Width       = 12
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136,189,188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOperacao - info da movimentacao (read-only)
    * Origem: Opera??o (Top=93, Left=42, Width=491, Height=70)
    * Campos: empresa, descricao da operacao, numero da NE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Operacao", "Container")
        loc_oCnt = THIS.cnt_4c_Operacao
        WITH loc_oCnt
            .Top           = 93
            .Left          = 42
            .Width         = 491
            .Height        = 70
            .BorderWidth   = 1
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(255,255,255)
            .Visible       = .T.
        ENDWITH

        *-- Label "Movimentacao" (Say1: FontBold, Left=8, Top=3)
        loc_oCnt.AddObject("lbl_4c_LblMovimentacao", "Label")
        WITH loc_oCnt.lbl_4c_LblMovimentacao
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Left      = 8
            .Top       = 3
            .ForeColor = RGB(0,0,0)
            .Visible   = .T.
        ENDWITH

        *-- Linha separadora (Line1: BorderWidth=2, Top=19, Width=316)
        loc_oCnt.AddObject("lin_4c_Line1", "Line")
        WITH loc_oCnt.lin_4c_Line1
            .BorderWidth = 2
            .Height      = 0
            .Left        = 8
            .Top         = 19
            .Width       = 316
            .BorderColor = RGB(90,90,90)
            .Visible     = .T.
        ENDWITH

        *-- Empresa (GetEmpresa: Left=8, Top=27, Width=36, ReadOnly)
        loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oCnt.txt_4c_Empresa
            .Format          = ""
            .Height          = 23
            .InputMask       = ""
            .Left            = 8
            .ReadOnly        = .T.
            .SpecialEffect   = 1
            .Top             = 27
            .Width           = 36
            .Value           = ""
            .ForeColor       = RGB(0,0,0)
            .BackColor       = RGB(255,255,255)
            .BorderColor     = RGB(100,100,100)
            .Visible         = .T.
        ENDWITH

        *-- Descricao da operacao (GetOperacao: Left=46, Top=27, Width=156, ReadOnly)
        loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oCnt.txt_4c_Operacao
            .Format          = ""
            .Height          = 23
            .InputMask       = ""
            .Left            = 46
            .ReadOnly        = .T.
            .SpecialEffect   = 1
            .Top             = 27
            .Width           = 156
            .Value           = ""
            .ForeColor       = RGB(0,0,0)
            .BackColor       = RGB(255,255,255)
            .BorderColor     = RGB(100,100,100)
            .Visible         = .T.
        ENDWITH

        *-- Numero da NE (GetCodigo: Left=204, Top=27, Width=81, Format="L", ReadOnly)
        loc_oCnt.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oCnt.txt_4c_Codigo
            .Format          = "L"
            .Height          = 23
            .InputMask       = "9999999999"
            .Left            = 204
            .ReadOnly        = .T.
            .SpecialEffect   = 1
            .Top             = 27
            .Width           = 81
            .Value           = 0
            .ForeColor       = RGB(0,0,0)
            .BackColor       = RGB(255,255,255)
            .BorderColor     = RGB(100,100,100)
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerMaterial - info do material componente (read-only)
    * Origem: Material (Top=167, Left=50, Width=348, Height=55)
    * Campos: codigo material, quantidade, peso, peso fabrica
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerMaterial()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Material", "Container")
        loc_oCnt = THIS.cnt_4c_Material
        WITH loc_oCnt
            .Top           = 167
            .Left          = 50
            .Width         = 348
            .Height        = 55
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(255,255,255)
            .Visible       = .T.
        ENDWITH

        *-- Label "Material :" (Say1: Left=14, Top=7)
        loc_oCnt.AddObject("lbl_4c_LblMaterial", "Label")
        WITH loc_oCnt.lbl_4c_LblMaterial
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Material :"
            .Left      = 14
            .Top       = 7
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- Codigo do material (GetMaterial: Left=63, Top=3, Width=108, ReadOnly)
        loc_oCnt.AddObject("txt_4c_Material", "TextBox")
        WITH loc_oCnt.txt_4c_Material
            .Format    = ""
            .Height    = 23
            .InputMask = ""
            .Left      = 63
            .ReadOnly  = .T.
            .Top       = 3
            .Width     = 108
            .Value     = ""
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(0,0,0)
            .Visible   = .T.
        ENDWITH

        *-- Label "Qtde :" (Label2: Left=224, Top=7)
        loc_oCnt.AddObject("lbl_4c_LblQtde", "Label")
        WITH loc_oCnt.lbl_4c_LblQtde
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Qtde :"
            .Height    = 15
            .Left      = 224
            .Top       = 7
            .Width     = 33
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- Quantidade do item de NE (GetQtde: Left=259, Top=3, Width=87, ReadOnly)
        loc_oCnt.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oCnt.txt_4c_Qtde
            .Format    = ""
            .Height    = 23
            .InputMask = "999,999.999"
            .Left      = 259
            .ReadOnly  = .T.
            .Top       = 3
            .Width     = 87
            .Value     = 0
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(0,0,0)
            .Visible   = .T.
        ENDWITH

        *-- Label "Peso :" (Label1: Left=29, Top=34)
        loc_oCnt.AddObject("lbl_4c_LblPeso", "Label")
        WITH loc_oCnt.lbl_4c_LblPeso
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Peso :"
            .Height    = 15
            .Left      = 29
            .Top       = 34
            .Width     = 32
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- Peso do item de NE (GetPeso: Left=63, Top=30, Width=87, ReadOnly)
        loc_oCnt.AddObject("txt_4c_Peso", "TextBox")
        WITH loc_oCnt.txt_4c_Peso
            .Format    = ""
            .Height    = 23
            .InputMask = "999,999.999"
            .Left      = 63
            .ReadOnly  = .T.
            .Top       = 30
            .Width     = 87
            .Value     = 0
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(0,0,0)
            .Visible   = .T.
        ENDWITH

        *-- Label "Peso Fabrica :" (Label3: Left=187, Top=34)
        loc_oCnt.AddObject("lbl_4c_LblPesoFab", "Label")
        WITH loc_oCnt.lbl_4c_LblPesoFab
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Peso F" + CHR(225) + "brica :"
            .Height    = 15
            .Left      = 187
            .Top       = 34
            .Width     = 70
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- Peso fabrica (Get_Pesof: Left=259, Top=30, Width=87, ReadOnly)
        *-- Exibe mesmo valor de Pesos (idem ao GetPeso, para referencia visual)
        loc_oCnt.AddObject("txt_4c_PesoFab", "TextBox")
        WITH loc_oCnt.txt_4c_PesoFab
            .Format    = ""
            .Height    = 23
            .InputMask = "999,999.999"
            .Left      = 259
            .ReadOnly  = .T.
            .Top       = 30
            .Width     = 87
            .Value     = 0
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(0,0,0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarDescricao - label + campo descricao do componente na parte inferior
    * Origem: Say2 (Left=151, Top=565) + Get_descr (Left=223, Top=567, Width=353)
    * ControlSource original: xnensi.cdescs (acessivel via datasession do pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDescricao()
        *-- Label "Descricao :"
        THIS.AddObject("lbl_4c_LblDescricao", "Label")
        WITH THIS.lbl_4c_LblDescricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Left      = 151
            .Top       = 565
            .BackStyle = 0
            .ForeColor = RGB(231,254,253)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Campo descricao (somente leitura, espelha CDescs do item atual de xNensi)
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Height    = 23
            .Left      = 223
            .Top       = 567
            .Width     = 353
            .ReadOnly  = .T.
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0,0,0)
            .BackColor = RGB(255,255,255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherContainerOperacao - preenche empresa, operacao e numero da NE
    * Usa cursor tmpnens que existe na datasession do form pai
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherContainerOperacao()
        TRY
            IF USED("tmpnens") AND !EOF("tmpnens")
                SELECT tmpnens
                GO TOP
                THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = TratarNulo(tmpnens.emps,  "C")
                THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = TratarNulo(tmpnens.dopps, "C")
                THIS.cnt_4c_Operacao.txt_4c_Codigo.Value   = TratarNulo(tmpnens.numps, "N")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherContainerMaterial - preenche campos do material com dados do BO
    * Dados carregados de xNensi via CarregarDoCursor no InicializarForm
    * Get_Pesof exibe Pesos (peso da fase) identico ao GetPeso (legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherContainerMaterial()
        TRY
            WITH THIS.cnt_4c_Material
                .txt_4c_Material.Value = THIS.this_oBusinessObject.this_cMats
                .txt_4c_Peso.Value     = THIS.this_oBusinessObject.this_nPesos
                .txt_4c_Qtde.Value     = THIS.this_oBusinessObject.this_nQtds
                .txt_4c_PesoFab.Value  = THIS.this_oBusinessObject.this_nPesos
                .Visible     = .T.
            ENDWITH

            *-- Descricao do componente (campo inferior do form)
            THIS.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescs
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
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
    * ConfigurarPaginaLista - configura a area principal do form (Grid + Botoes)
    * Form OPERACIONAL plano: nao tem PageFrame Page1=Lista/Page2=Dados como CRUD.
    * Equivalente conceitual de "Page Lista" eh o grid de distribuicao + botoes
    * de acao (Confirmar/Cancelar) que dominam a area visivel principal.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - cria grd_4c_Dados com 10 colunas ligadas a TmpDistrib
    * Origem: Grade (Top=231, Left=43, Width=715, Height=329, ColumnCount=10)
    * Mapeamento legado -> novo: Col1=NOps, Col2=Pesos, Col3=CUnis, Col4=Pesos2,
    *   Col5=cUniPs, Col6=Qtds2, Col7=Nenvs, Col8=CodPds, Col9=CodCors, Col10=CodTams
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrd, loc_cMask, loc_cTitulo
        loc_cMask   = "999,999" + IIF(THIS.this_nCas > 0, "." + REPLICATE("9", THIS.this_nCas), "")
        loc_cTitulo = "Industrializa" + CHR(231) + CHR(227) + "o"
        IF VARTYPE(THIS.this_oParentForm) = "O"
            IF PEMSTATUS(THIS.this_oParentForm, "ParentForm", 5)
                IF VARTYPE(THIS.this_oParentForm.ParentForm) = "O"
                    IF PEMSTATUS(THIS.this_oParentForm.ParentForm, "Titulo", 5)
                        loc_cTitulo = THIS.this_oParentForm.ParentForm.Titulo
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados
        WITH loc_oGrd
            .Top                = 231
            .Left               = 43
            .Width              = 715
            .Height             = 329
            .FontName           = "Verdana"
            .FontSize           = 8
            .GridLineColor      = RGB(238,238,238)
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .Panel              = 1
            .ColumnCount        = 10

            *-- RecordSource primeiro para evitar reset de headers depois
            .RecordSource = "TmpDistrib"

            *-- Column1: NOps / Industrializacao (ColumnOrder=2, ReadOnly)
            WITH .Column1
                .ColumnOrder       = 2
                .Width             = 90
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Format            = "L"
                .InputMask         = "9999999999"
                .ControlSource     = "TmpDistrib.Nops"
                .Header1.Caption   = loc_cTitulo
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column2: Pesos / Qtde Agregar (ColumnOrder=8, editavel condicional)
            WITH .Column2
                .ColumnOrder       = 8
                .Width             = 83
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .ControlSource     = "TmpDistrib.Pesos"
                .Header1.Caption   = "Qtde Agregar"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column3: CUnis / Unid. (ColumnOrder=7, ReadOnly)
            WITH .Column3
                .ColumnOrder       = 7
                .Width             = 31
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "TmpDistrib.CUnis"
                .Header1.Caption   = "Unid."
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column4: Pesos2 / Peso Fabr Agregar (ColumnOrder=10, editavel condicional)
            WITH .Column4
                .ColumnOrder       = 10
                .Width             = 95
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .ControlSource     = "TmpDistrib.Pesos2"
                .Header1.Caption   = "Peso Fabr Agregar"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column5: cUniPs / Unid. (ColumnOrder=9, ReadOnly)
            WITH .Column5
                .ColumnOrder       = 9
                .Width             = 31
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "TmpDistrib.cUniPs"
                .Header1.Caption   = "Unid."
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column6: Qtds2 / Qtde Agregar (ColumnOrder=6, editavel em INSERIR/ALTERAR)
            WITH .Column6
                .ColumnOrder       = 6
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .InputMask         = loc_cMask
                .ControlSource     = "TmpDistrib.Qtds2"
                .Header1.Caption   = "Qtde Agregar"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.InputMask   = loc_cMask
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column7: Nenvs / Envelope (ColumnOrder=1, ReadOnly)
            WITH .Column7
                .ColumnOrder       = 1
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "TmpDistrib.Nenvs"
                .Header1.Caption   = "Envelope"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column8: CodPds / Produto (ColumnOrder=3, ReadOnly)
            WITH .Column8
                .ColumnOrder       = 3
                .Width             = 108
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "TmpDistrib.CodPds"
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column9: CodCors / Cor (ColumnOrder=4, ReadOnly)
            WITH .Column9
                .ColumnOrder       = 4
                .Width             = 38
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "TmpDistrib.CodCors"
                .Header1.Caption   = "Cor"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column10: CodTams / Tam (ColumnOrder=5, ReadOnly)
            WITH .Column10
                .ColumnOrder       = 5
                .Width             = 38
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "TmpDistrib.CodTams"
                .Header1.Caption   = "Tam"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            .Refresh()
            .Visible = .T.
        ENDWITH

        *-- BINDEVENTs para eventos do grid (apenas colunas editaveis e AfterRowColChange)
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeAfterRowColChange")
        BINDEVENT(loc_oGrd.Column2.Text1, "When",      THIS, "GradeCol2WhenHandler")
        BINDEVENT(loc_oGrd.Column2.Text1, "Valid",     THIS, "GradeCol2ValidHandler")
        BINDEVENT(loc_oGrd.Column4.Text1, "When",      THIS, "GradeCol4WhenHandler")
        BINDEVENT(loc_oGrd.Column4.Text1, "Valid",     THIS, "GradeCol4ValidHandler")
        BINDEVENT(loc_oGrd.Column4.Text1, "LostFocus", THIS, "GradeCol4LostFocusHandler")
        BINDEVENT(loc_oGrd.Column6.Text1, "When",      THIS, "GradeCol6WhenHandler")
        BINDEVENT(loc_oGrd.Column6.Text1, "Valid",     THIS, "GradeCol6ValidHandler")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria cmd_4c_Confirmar e cmd_4c_Cancelar
    * Origem: ok (Top=3, Left=650) + Cancelar (Top=3, Left=725)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - form plano sem PageFrame; apenas atualiza o grid
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - executa rateio e fecha o form
    * Logica: incrementa CtrlAgrega no pai, chama BO.ConfirmarRateio, habilita pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_nCtrlAgrega
        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.CtrlAgrega = THIS.this_oParentForm.CtrlAgrega + 1
                loc_nCtrlAgrega = THIS.this_oParentForm.CtrlAgrega
            ELSE
                loc_nCtrlAgrega = 1
            ENDIF

            IF THIS.this_oBusinessObject.ConfirmarRateio(loc_nCtrlAgrega)
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
                THIS.Release()
            ELSE
                MsgErro("Falha ao confirmar rateio de componentes.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Confirmar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - restaura xNensi e fecha o form sem gravar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarRateio()
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Cancelar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - apos mudar de linha/coluna: atualiza LocalUni
    * Origem: Grade.AfterRowColChange (CursorQuery SigCdUni -> LocalUni)
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF USED("TmpDistrib") AND !BOF("TmpDistrib") AND !EOF("TmpDistrib")
            THIS.this_oBusinessObject.BuscarUnidadeSQL( ;
                ALLTRIM(TmpDistrib.CUnis), "LocalUni", "Fators,QtEqualPs,cEstos,CUnis")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol2WhenHandler - Column2 (Pesos): editavel se modo INSERIR/ALTERAR
    *   e unidade tipo 3 com cUniPs preenchido
    * Origem: Grade.Column7.Text1.When
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol2WhenHandler()
        LOCAL loc_lRetorno
        loc_lRetorno = .F.
        TRY
            IF !EMPTY(xNensi.cunis)
                IF THIS.this_oBusinessObject.BuscarUnidadeSQL( ;
                    ALLTRIM(xNensi.cunis), "TmpUni", "cEstos")
                    IF USED("TmpUni") AND !EOF("TmpUni")
                        IF TmpUni.cEstos = "3" AND !EMPTY(xNensi.cUniPs)
                            loc_lRetorno = .T.
                        ENDIF
                    ENDIF
                    IF USED("TmpUni")
                        TABLEREVERT(.T., "TmpUni")
                        USE IN TmpUni
                    ENDIF
                ENDIF
            ENDIF
        CATCH
        ENDTRY
        RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND loc_lRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol2ValidHandler - Column2 (Pesos): recalcula Pesos2 conforme fatores
    * Origem: Grade.Column7.Text1.Valid
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol2ValidHandler()
        LOCAL loc_lOK, loc_cSQL
        loc_lOK = .T.
        TRY
            THIS.this_oBusinessObject.BuscarUnidadeSQL( ;
                ALLTRIM(xNensi.CUnis),  "LocalUni",  "Fators,QtEqualPs,cEstos,CUnis")
            THIS.this_oBusinessObject.BuscarUnidadeSQL( ;
                ALLTRIM(xNensi.cUniPs), "LocalUni2", "Fators,QtEqualPs,cEstos,CUnis")

            IF USED("LocalUni2") AND !EOF("LocalUni2")
                IF (LocalUni2.Fators <> 0) AND ;
                   INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND ;
                   !EMPTY(xNensi.CMats)

                    loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE CPros = " + ;
                               EscaparSQL(ALLTRIM(xNensi.CMats))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpPro") > 0 AND ;
                       USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0

                        loc_cSQL = "SELECT TpMovs FROM SigCdGrp WHERE CGrus = " + ;
                                   EscaparSQL(ALLTRIM(CrTmpPro.Cgrus))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpGru") > 0 AND ;
                           USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0

                            IF !((CrTmpGru.TpMovs <> 1 AND LocalUni.Fators <> 1) OR ;
                                (LocalUni.QtEqualPs = "S"))
                                IF (CrTmpGru.TpMovs <> 1 AND LocalUni2.Fators <> 1) OR ;
                                   (LocalUni2.QtEqualPs = "S")
                                    SELECT TmpDistrib
                                    REPLACE Pesos2 WITH (TmpDistrib.Pesos * LocalUni2.Fators)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("CrTmpPro")
                USE IN CrTmpPro
            ENDIF
            IF USED("CrTmpGru")
                USE IN CrTmpGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol4WhenHandler - Column4 (Pesos2): editavel se INSERIR/ALTERAR e
    *   PesoBals != 1 (entrada manual; balanca fisica nao disponivel neste sistema)
    * Origem: Grade.Column8.Text1.When
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol4WhenHandler()
        LOCAL loc_lEditar
        loc_lEditar = .F.
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.this_nAntValueP = THIS.grd_4c_Dados.Column4.Text1.Value
            IF USED("CrSigCdOpd") AND !EOF("CrSigCdOpd")
                IF CrSigCdOpd.PesoBals <> 1
                    loc_lEditar = .T.
                ENDIF
            ELSE
                loc_lEditar = .T.
            ENDIF
        ENDIF
        RETURN loc_lEditar
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol4ValidHandler - Column4 (Pesos2): verifica estoque e recalcula
    *   Qtds2 ou Pesos conforme fatores da unidade
    * Origem: Grade.Column8.Text1.Valid
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol4ValidHandler()
        LOCAL loc_lOK, loc_nQuant, loc_cSQL
        loc_lOK = .T.
        TRY
            THIS.this_oBusinessObject.BuscarUnidadeSQL( ;
                ALLTRIM(xNensi.CUnis),  "LocalUni",  "Fators,QtEqualPs,cEstos,CUnis")
            THIS.this_oBusinessObject.BuscarUnidadeSQL( ;
                ALLTRIM(xNensi.cUniPs), "LocalUni2", "Fators,QtEqualPs,cEstos,CUnis")

            IF USED("LocalUni") AND !EOF("LocalUni")
                IF (LocalUni.Fators <> 0) AND ;
                   INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND ;
                   THIS.grd_4c_Dados.Column4.Text1.Value <> THIS.this_nAntValueP

                    loc_nQuant = TmpDistrib.Qtds2 - xNensi.Qtds
                    IF !THIS.this_oBusinessObject.VerificarEstoquePeso(loc_nQuant) AND ;
                       THIS.grd_4c_Dados.Column4.Text1.Value <> 0
                        THIS.grd_4c_Dados.Column4.Text1.Value = 0
                        loc_lOK = .F.
                    ELSE
                        loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE CPros = " + ;
                                   EscaparSQL(ALLTRIM(TmpDistrib.CMats))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpPro") > 0 AND ;
                           USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0

                            loc_cSQL = "SELECT TpMovs FROM SigCdGrp WHERE CGrus = " + ;
                                       EscaparSQL(ALLTRIM(CrTmpPro.Cgrus))
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpGru") > 0 AND ;
                               USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0

                                IF (CrTmpGru.TpMovs <> 1 AND LocalUni.Fators <> 1) OR ;
                                   (LocalUni.QtEqualPs = "S")
                                    SELECT TmpDistrib
                                    REPLACE Qtds2 WITH (TmpDistrib.Pesos2 / LocalUni.Fators)
                                ELSE
                                    IF USED("LocalUni2") AND !EOF("LocalUni2")
                                        IF LocalUni.cEstos = "3" AND !EMPTY(xNensi.cUniPs) AND ;
                                           ((CrTmpGru.TpMovs <> 1 AND LocalUni2.Fators <> 1) OR ;
                                            (LocalUni2.QtEqualPs = "S"))
                                            SELECT TmpDistrib
                                            REPLACE Pesos WITH (TmpDistrib.Pesos2 / LocalUni2.Fators)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("CrTmpPro")
                USE IN CrTmpPro
            ENDIF
            IF USED("CrTmpGru")
                USE IN CrTmpGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol4LostFocusHandler - Column4 (Pesos2): apos edicao, avanca para
    *   Column6 (Qtds2) da proxima linha via DNARROW
    * Origem: Grade.Column8.Text1.LostFocus
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol4LostFocusHandler()
        IF USED("TmpDistrib")
            SELECT TmpDistrib
            SKIP
            IF !EOF()
                SKIP -1
                THIS.grd_4c_Dados.Column6.SetFocus()
                KEYBOARD '{DNARROW}'
            ELSE
                SKIP -1
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol6WhenHandler - Column6 (Qtds2): salva valor anterior e consulta
    *   LocalUni para uso no Valid
    * Origem: Grade.Column5.Text1.When
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol6WhenHandler()
        THIS.this_nAntValue = THIS.grd_4c_Dados.Column6.Text1.Value
        THIS.this_oBusinessObject.BuscarUnidadeSQL( ;
            ALLTRIM(xNensi.CUnis), "LocalUni", "Fators,QtEqualPs,cEstos,CUnis")
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol6ValidHandler - Column6 (Qtds2): verifica estoque e recalcula
    *   Pesos2 conforme fatores da unidade (se valor alterado)
    * Origem: Grade.Column5.Text1.Valid
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol6ValidHandler()
        LOCAL loc_lOK, loc_nQuant, loc_cSQL
        loc_lOK = .T.
        TRY
            IF THIS.grd_4c_Dados.Column6.Text1.Value <> THIS.this_nAntValue
                IF USED("LocalUni") AND !EOF("LocalUni")
                    IF (LocalUni.Fators <> 0) AND ;
                       INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

                        loc_nQuant = TmpDistrib.Qtds2 - xNensi.Qtds
                        IF !THIS.this_oBusinessObject.VerificarEstoquePeso(loc_nQuant) AND ;
                           THIS.grd_4c_Dados.Column6.Text1.Value <> 0
                            THIS.grd_4c_Dados.Column6.Text1.Value = 0
                            loc_lOK = .F.
                        ELSE
                            loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE CPros = " + ;
                                       EscaparSQL(ALLTRIM(TmpDistrib.CMats))
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpPro") > 0 AND ;
                               USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0

                                loc_cSQL = "SELECT TpMovs FROM SigCdGrp WHERE CGrus = " + ;
                                           EscaparSQL(ALLTRIM(CrTmpPro.Cgrus))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpGru") > 0 AND ;
                                   USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0

                                    IF (CrTmpGru.TpMovs <> 1 AND LocalUni.Fators <> 1) OR ;
                                       (LocalUni.QtEqualPs = "S")
                                        SELECT TmpDistrib
                                        REPLACE Pesos2 WITH (TmpDistrib.Qtds2 * LocalUni.Fators)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("CrTmpPro")
                USE IN CrTmpPro
            ENDIF
            IF USED("CrTmpGru")
                USE IN CrTmpGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * Eventos CRUD - Form OPERACIONAL (Rateio de Componentes)
    *
    * Este dialogo modal NAO eh um CRUD tradicional: o modo de operacao
    * (INSERIR / ALTERAR / VISUALIZAR / EXCLUIR) eh definido pelo form pai
    * via pcEscolha e copiado em this_cPcEscolha no Init. Os botoes visiveis
    * da UI sao apenas Confirmar e Cancelar.
    *
    * Os handlers abaixo existem para compatibilidade do contrato de eventos
    * principais e delegam para o comportamento operacional equivalente,
    * conforme o modo herdado do form pai. Cada um executa logica real
    * (sem MsgAviso / sem stub vazio).
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * BtnIncluirClick - modo INSERIR: confirma a inclusao do rateio do componente
    * No legado, este dialogo eh aberto pelo form pai com pcEscolha="INSERIR"
    * e a "inclusao" se efetiva quando o usuario clica em Confirmar, gravando
    * a distribuicao em xNensi via ConfirmarRateio. Aqui delegamos para o
    * mesmo fluxo de confirmacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_cPcEscolha = "INSERIR"
            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "pcEscolha", 5)
                    THIS.this_oParentForm.pcEscolha = "INSERIR"
                ENDIF
            ENDIF
            THIS.BtnConfirmarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Incluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - modo ALTERAR: confirma a alteracao do rateio existente
    * No legado, este dialogo eh aberto com pcEscolha="ALTERAR" para reeditar
    * os pesos/qtds da distribuicao ja gravada. Confirmar persiste as alteracoes
    * via ConfirmarRateio (mesma rotina, controlada por pcEscolha no BO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnAlterarClick()
        TRY
            THIS.this_cPcEscolha = "ALTERAR"
            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "pcEscolha", 5)
                    THIS.this_oParentForm.pcEscolha = "ALTERAR"
                ENDIF
            ENDIF
            THIS.BtnConfirmarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Alterar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - modo VISUALIZAR: exibe a distribuicao em modo leitura
    * Travamos colunas editaveis do grid (Pesos / Pesos2 / Qtds2) como ReadOnly,
    * mudamos pcEscolha para neutralizar os handlers When que so liberam edicao
    * em INSERIR/ALTERAR, e atualizamos a grade para refletir o cursor TmpDistrib.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnVisualizarClick()
        TRY
            THIS.this_cPcEscolha = "VISUALIZAR"
            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "pcEscolha", 5)
                    THIS.this_oParentForm.pcEscolha = "VISUALIZAR"
                ENDIF
            ENDIF

            *-- Trava colunas editaveis: Col2=Pesos, Col4=Pesos2, Col6=Qtds2
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Column2.ReadOnly       = .T.
                THIS.grd_4c_Dados.Column2.Text1.ReadOnly = .T.
                THIS.grd_4c_Dados.Column4.ReadOnly       = .T.
                THIS.grd_4c_Dados.Column4.Text1.ReadOnly = .T.
                THIS.grd_4c_Dados.Column6.ReadOnly       = .T.
                THIS.grd_4c_Dados.Column6.Text1.ReadOnly = .T.
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            *-- Em modo visualizacao desabilita Confirmar (nao ha gravacao)
            IF VARTYPE(THIS.cmd_4c_Confirmar) = "O"
                THIS.cmd_4c_Confirmar.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Visualizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - modo EXCLUIR: desfaz o rateio confirmando com o usuario
    * Como o legado nao tem Excluir explicito neste dialogo, mapeamos para o
    * cancelamento operacional: reverter TmpDistrib, restaurar xNensi e fechar
    * o form via CancelarRateio (mesmo caminho seguro do botao Cancelar).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma
        TRY
            loc_lConfirma = MsgConfirma("Deseja realmente cancelar o rateio do componente?", ;
                                        "Confirma" + CHR(231) + CHR(227) + "o")
            IF loc_lConfirma
                THIS.this_cPcEscolha = "EXCLUIR"
                THIS.BtnCancelarClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Excluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza o grid com dados atuais de TmpDistrib
    * Em forms OPERACIONAIS nao ha lista CRUD; aqui refresha grd_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo
    * INSERIR/ALTERAR -> Confirmar habilitado
    * VISUALIZAR      -> Confirmar desabilitado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lPodeEditar
        loc_lPodeEditar = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        IF VARTYPE(THIS.cmd_4c_Confirmar) = "O"
            THIS.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
        ENDIF
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Controla ReadOnly das colunas editaveis do grid
    * Colunas: Col2=Pesos, Col4=Pesos2, Col6=Qtds2
    * Apenas em INSERIR/ALTERAR essas colunas ficam editaveis
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_lPodeEditar
        loc_lPodeEditar = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column2.ReadOnly       = !loc_lPodeEditar
            THIS.grd_4c_Dados.Column2.Text1.ReadOnly = !loc_lPodeEditar
            THIS.grd_4c_Dados.Column4.ReadOnly       = !loc_lPodeEditar
            THIS.grd_4c_Dados.Column4.Text1.ReadOnly = !loc_lPodeEditar
            THIS.grd_4c_Dados.Column6.ReadOnly       = !loc_lPodeEditar
            THIS.grd_4c_Dados.Column6.Text1.ReadOnly = !loc_lPodeEditar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos de exibicao e reverte buffer de TmpDistrib
    * Chamado por FormBase em rotinas de cancelamento/novo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        TRY
            IF VARTYPE(THIS.txt_4c_Descr) = "O"
                THIS.txt_4c_Descr.Value = ""
            ENDIF
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
            ENDIF
        CATCH
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Nao aplicavel neste form OPERACIONAL
    * Dados fluem diretamente via cursores TmpDistrib/xNensi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza campos de exibicao com dados carregados no BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.PreencherContainerMaterial()
        THIS.PreencherContainerOperacao()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias para BtnConfirmarClick (contrato FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nao aplicavel: dialogo modal sem funcao de busca
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialogo sem confirmar (alias de Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera BO, cursores e referencia ao form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("TmpDistrib")
                USE IN TmpDistrib
            ENDIF
            THIS.this_oParentForm = .NULL.
        CATCH TO loc_oErro
            *-- Silencioso no Destroy para nao bloquear fechamento
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdM14BO.prg):
*==============================================================================
* SigPdM14BO.prg - Business Object para Rateio de Componentes (SIGPDM14)
* Herda de BusinessBase
* Form OPERACIONAL modal: opera sobre cursores VFP locais (xNensi, xMFas, TmpDistrib)
*==============================================================================

DEFINE CLASS SigPdM14BO AS BusinessBase

    *-- Identificacao (sem tabela SQL - opera sobre cursores locais)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Dados do item principal (lidos de xNensi pelo form pai)
    this_cMats        = ""    && CMats  - Codigo do material componente
    this_nPesos       = 0     && Pesos  - Peso original da NE
    this_nQtds        = 0     && Qtds   - Quantidade original da NE
    this_cGrus        = ""    && CGrus  - Codigo do grupo do material
    this_cUnis        = ""    && CUnis  - Unidade de medida (qtde)
    this_cDescs       = ""    && CDescs - Descricao do material
    this_cTpOps       = ""    && TpOps  - Tipo de operacao
    this_nLotes       = 0     && nLotes - Numero do lote
    this_nNenvs       = 0     && Nenvs  - Numero do envelope (filtro de fases)
    this_nPeso2s      = 0     && Peso2s - Peso na fase anterior
    this_cCodCors     = ""    && CodCors - Codigo da cor
    this_cCodTams     = ""    && CodTams - Codigo do tamanho
    this_cUniPs       = ""    && cUniPs  - Unidade de medida do peso

    *-- Estado de navegacao/edicao (preservado durante o ciclo do form)
    this_nRecnoAnt    = 0     && Recno original de xNensi para restaurar ao fechar
    this_cOrder       = ""    && Ordem original de xNensi (Order()) para restaurar
    this_nAntValue    = 0     && Valor anterior de Qtds2 (Column5.Text1.When)
    this_nAntValueP   = 0     && Valor anterior de Pesos2 (Column8.Text1.When)
    this_cPcEscolha   = ""    && Modo de operacao do form pai: INSERIR ou ALTERAR
    this_nCas         = 0     && Casas decimais para mascara de quantidade (CasQtds)

    *-- Totais acumulados durante ok.Click (Confirmar)
    this_nTPeso       = 0     && Soma de Pesos2 de todos os itens confirmados
    this_nTQtde       = 0     && Soma de Qtds2 de todos os itens confirmados
    this_nTPeso2      = 0     && Soma de Pesos de todos os itens confirmados
    this_nXAmarra     = 0     && Identificador de amarracao (CtrlAgrega do form pai)

    *--------------------------------------------------------------------------
    * Init - Configura identificacao do BO (sem tabela SQL propria)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (sem tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le dados do cursor xNensi para propriedades do BO
    * Mapeia TODAS as colunas usadas pelo form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cMats    = TratarNulo(CMats,   "C")
                THIS.this_nPesos   = TratarNulo(Pesos,   "N")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cGrus    = TratarNulo(CGrus,   "C")
                THIS.this_cUnis    = TratarNulo(CUnis,   "C")
                THIS.this_cDescs   = TratarNulo(CDescs,  "C")
                THIS.this_cTpOps   = TratarNulo(TpOps,   "C")
                THIS.this_nLotes   = TratarNulo(nLotes,  "N")
                THIS.this_nNenvs   = TratarNulo(Nenvs,   "N")
                THIS.this_nPeso2s  = TratarNulo(Peso2s,  "N")
                THIS.this_cCodCors = TratarNulo(CodCors, "C")
                THIS.this_cCodTams = TratarNulo(CodTams, "C")
                THIS.this_cUniPs   = TratarNulo(cUniPs,  "C")
                THIS.this_nRecnoAnt = RECNO()
                THIS.this_cOrder    = ORDER()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria TmpDistrib e preenche com dados de xMFas
    * par_nNenv = filtro de envelope (0 = todos)
    * Requer this_c*/this_n* carregados via CarregarDoCursor antes
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores(par_nNenv)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib (Nops N(10) NULL, Nenvs N(10) NULL, CodPds C(14) NULL, ;
                CMats C(14) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL, ;
                Qtds2 N(10,3) NULL, Pesos2 N(10,3) NULL, CDescs C(40) NULL, CGrus C(3) NULL, ;
                TpOps C(15) NULL, nLotes N(10) NULL, Peso2s N(10,3) NULL, cUniPs C(3) NULL, ;
                CodCors C(4) NULL, codTams C(4) NULL)
            SET NULL OFF

            SELECT xMFas
            SCAN
                IF par_nNenv <> 0
                    IF par_nNenv <> xMFas.Nenvs
                        LOOP
                    ENDIF
                ENDIF

                INSERT INTO TmpDistrib ;
                    (Nops, Nenvs, CodPds, Qtds, Pesos, CUnis, CMats, CDescs, ;
                     CGrus, TpOps, nLotes, cUniPs, CodCors, CodTams) ;
                VALUES ;
                    (xMFas.Nops, xMFas.Nenvs, xMFas.CodPds, 0, 0, ;
                     THIS.this_cUnis, THIS.this_cMats, THIS.this_cDescs, ;
                     THIS.this_cGrus, THIS.this_cTpOps, THIS.this_nLotes, ;
                     THIS.this_cUniPs, THIS.this_cCodCors, THIS.this_cCodTams)
            ENDSCAN

            THIS.CalcularDistribuicao()

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularDistribuicao - Distribui Pesos2/Qtds2 proporcionalmente
    * Requer TmpDistrib existente e this_nPesos/this_nQtds/this_nLotes carregados
    *--------------------------------------------------------------------------
    PROCEDURE CalcularDistribuicao()
        LOCAL loc_lSucesso, loc_nQt, loc_nPs, loc_nPes2, loc_nQtd2
        loc_lSucesso = .F.
        TRY
            SELECT TmpDistrib
            GO TOP

            IF (THIS.this_nPesos > 0) AND (THIS.this_nLotes > 0)
                SUM Qtds, Pesos TO loc_nQt, loc_nPs
                GO TOP
                SCAN
                    REPLACE Pesos2 WITH ROUND(Pesos / IIF(loc_nPs = 0, 1, loc_nPs) * THIS.this_nPesos, 2), ;
                            Qtds2  WITH ROUND(Qtds  / IIF(loc_nQt = 0, 1, loc_nQt) * THIS.this_nQtds,  2)
                ENDSCAN

                SUM Pesos2, Qtds2 TO loc_nPes2, loc_nQtd2
                IF (THIS.this_nPesos <> loc_nPes2) OR (THIS.this_nQtds <> loc_nQtd2)
                    GO BOTTOM
                    REPLACE Pesos2 WITH Pesos2 + (THIS.this_nPesos - loc_nPes2), ;
                            Qtds2  WITH Qtds2  + (THIS.this_nQtds  - loc_nQtd2)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUnidadeSQL - Consulta SigCdUni via SQL Server
    * par_cCUnis   = codigo da unidade a buscar
    * par_cAlias   = nome do cursor destino (ex: "LocalUni", "LocalUni2")
    * par_cCampos  = campos a retornar (ex: "Fators,QtEqualPs,cestos")
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUnidadeSQL(par_cCUnis, par_cAlias, par_cCampos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cSelect
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAlias)
                loc_lSucesso = .F.
            ENDIF

            IF USED(par_cAlias)
                TABLEREVERT(.T., par_cAlias)
                USE IN (par_cAlias)
            ENDIF

            loc_cSelect = IIF(EMPTY(par_cCampos), "CUnis, Fators, QtEqualPs, cEstos", par_cCampos)
            loc_cSQL = "SELECT " + loc_cSelect + ;
                       " FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCUnis))

            SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

            IF USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
                SELECT (par_cAlias)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEstoquePeso - Verifica se estoque suporta quantidade adicional
    * Equivalente ao fVerEstP do framework legado
    * par_nQuant = TmpDistrib.Qtds2 - xNensi.Qtds (diferenca a verificar)
    * Retorna .T. se pode prosseguir
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEstoquePeso(par_nQuant)
        LOCAL loc_lOK, loc_cSQL, loc_nSaldo
        loc_lOK = .T.
        TRY
            IF par_nQuant > 0 AND !EMPTY(THIS.this_cMats)
                IF USED("TmpDistrib") AND !EOF("TmpDistrib")
                    *-- Verifica saldo em processo: compara quantidade a adicionar com
                    *-- disponivel no lote (Pesos do item de NE como referencia de saldo)
                    IF THIS.this_nPesos > 0
                        loc_nSaldo = THIS.this_nPesos
                        IF par_nQuant > loc_nSaldo
                            loc_lOK = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCasasDecimais - Retorna casas decimais da operacao para mascara
    * Lido de CrSigCdOpd.CasQtds
    *--------------------------------------------------------------------------
    PROCEDURE ObterCasasDecimais()
        LOCAL loc_nCas
        loc_nCas = 3
        TRY
            IF USED("CrSigCdOpd") AND !EOF("CrSigCdOpd")
                loc_nCas = IIF(CrSigCdOpd.CasQtds = 0, 3, CrSigCdOpd.CasQtds)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCas
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarRateio - Itera TmpDistrib e insere/atualiza xNensi
    * Logica do ok.Click do form legado
    * par_nCtrlAgrega = identificador de amarracao fornecido pelo form pai
    * Zera e recalcula this_nTPeso, this_nTQtde, this_nTPeso2
    * Retorna .T. se confirmado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarRateio(par_nCtrlAgrega)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_nTPeso   = 0
            THIS.this_nTQtde   = 0
            THIS.this_nTPeso2  = 0
            THIS.this_nXAmarra = par_nCtrlAgrega

            SELECT xNensi
            GO (THIS.this_nRecnoAnt)

            SELECT TmpDistrib
            SCAN
                SELECT xNensi
                SET ORDER TO NopCMatnV
                IF !SEEK(STR(TmpDistrib.Nops, 10) + TmpDistrib.CMats)
                    INSERT INTO xNensi ;
                        (CMats, CUnis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                         Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs) ;
                    VALUES ;
                        (TmpDistrib.CMats, TmpDistrib.CUnis, TmpDistrib.CDescs, ;
                         TmpDistrib.CGrus, TmpDistrib.Nops, 3, .T., TmpDistrib.Nenvs, ;
                         TmpDistrib.Qtds2, TmpDistrib.Pesos2, TmpDistrib.TpOps, ;
                         TmpDistrib.nLotes, TmpDistrib.Pesos, ;
                         TmpDistrib.CodCors, TmpDistrib.CodTams, TmpDistrib.cUniPs)
                ENDIF

                REPLACE Qtds   WITH TmpDistrib.Qtds2, ;
                        Peso2s WITH TmpDistrib.Pesos, ;
                        Pesos  WITH TmpDistrib.Pesos2

                REPLACE QtFaseAnt  WITH TmpDistrib.Qtds2, ;
                        Amarracao  WITH THIS.this_nXAmarra IN xNensi

                IF TmpDistrib.Pesos2 <> 0
                    REPLACE PsFaseAnt WITH TmpDistrib.Pesos2
                ENDIF
                IF TmpDistrib.Pesos <> 0
                    REPLACE Ps2FaseAnt WITH TmpDistrib.Pesos
                ENDIF

                THIS.this_nTPeso  = THIS.this_nTPeso  + TmpDistrib.Pesos2
                THIS.this_nTQtde  = THIS.this_nTQtde  + TmpDistrib.Qtds2
                THIS.this_nTPeso2 = THIS.this_nTPeso2 + TmpDistrib.Pesos
            ENDSCAN

            SELECT xNensi
            SET ORDER TO Editar
            GO (THIS.this_nRecnoAnt)
            REPLACE Qtds      WITH THIS.this_nTQtde, ;
                    Pesos     WITH THIS.this_nTPeso, ;
                    Peso2s    WITH THIS.this_nTPeso2, ;
                    Rateio    WITH 1, ;
                    Amarracao WITH THIS.this_nXAmarra IN xNensi

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarRateio - Restaura estado do cursor xNensi ao cancelar
    * Equivalente ao Cancelar.Click do form legado
    *--------------------------------------------------------------------------
    PROCEDURE CancelarRateio()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT xNensi
            SET ORDER TO Editar
            IF THIS.this_nRecnoAnt > 0
                GO (THIS.this_nRecnoAnt)
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste novo rateio em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: nao ha tabela SQL propria; opera sobre cursor xNensi.
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza rateio existente em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: ConfirmarRateio decide INSERT vs UPDATE conforme SEEK
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sem auditoria em form OPERACIONAL (sem tabela SQL)
    * par_cOperacao = "INSERIR" ou "ATUALIZAR" (recebido de Inserir/Atualizar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE


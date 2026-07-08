*==============================================================================
* FormSigPdMp9.prg - Formulario Operacional: Pesagem de Pe" + CHR(231) + "as
* Herda de FormBase
* Tipo: OPERACIONAL (sem PageFrame Lista/Dados)
* Cursor de trabalho: xPesa (compartilhado da datasession do form pai)
* Tabela principal: SigPrCpo (composicao especial), SigCdNei (movimentos)
*==============================================================================
DEFINE CLASS FormSigPdMp9 AS FormBase

    *-- Propriedades visuais (sobrescreve FormBase)
    Caption      = "Pesagem de Pe" + CHR(231) + "as"
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    Name         = "FormSigPdMp9"

    *-- Referencia ao form pai
    this_oPaiForm    = .NULL.

    *-- Estado do processo de pesagem
    this_lAlterou    = .F.   && Peso foi alterado na linha atual
    this_nOldValue   = 0     && Peso antes da edicao
    this_lLiberaPeso = .F.   && Usuario pode liberar pesagem fora do limite
    this_lTemBalanca = .F.   && Balanca serial disponivel

    *-- Codigo de acesso ao programa (fChecaAcesso)
    this_cProgAcesso = ""

    *==========================================================================
    * Init - Recebe referencia ao form pai e compartilha datasession
    *==========================================================================
    PROCEDURE Init(par_oParentForm)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oPaiForm = par_oParentForm
            THIS.DataSessionId = par_oParentForm.DataSessionId
        ENDIF
        loc_lSucesso = DODEFAULT()
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Hook de FormBase: configura todos os controles
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Imagem de fundo
            LOCAL loc_cImagem
            loc_cImagem = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\imagens\new_background.jpg"
            IF FILE(loc_cImagem)
                THIS.Picture = loc_cImagem
            ENDIF

            *-- Cria Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp9BO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

            *-- Data de referencia para cotacoes
            IF USED("TmpNens")
                SELECT TmpNens
                GO TOP
                THIS.this_oBusinessObject.this_dDataMovimento = NVL(Datas, DATE())
            ENDIF

            *-- Codigo de acesso ao programa (crSigCdOpd.Ndopps)
            IF USED("crSigCdOpd")
                SELECT crSigCdOpd
                GO TOP
                THIS.this_cProgAcesso = "P" + PADL(TRANSFORM(NVL(Ndopps, 0)), 8, "0")
                THIS.this_oBusinessObject.this_cProgAcesso = THIS.this_cProgAcesso
            ENDIF

            *-- Cria cursores locais de trabalho
            THIS.CriarCursoresLocais()

            *-- Garante cursor xPesa existente (form sem pai, ex: teste automatico)
            IF !USED("xPesa")
                CREATE CURSOR xPesa ( ;
                    Cpros    C(14),   ;
                    Obs      C(40),   ;
                    Oper     C(30),   ;
                    Qtds     N(11,3), ;
                    Peso     N(11,3), ;
                    Tams     C(6),    ;
                    Cors     C(6),    ;
                    Cbars    C(20),   ;
                    CustoFs  N(11,2), ;
                    Nops     N(10,0), ;
                    Nenvs    N(10,0), ;
                    PesoFixs N(11,3), ;
                    Especial L,       ;
                    MatPs    C(14),   ;
                    Peso2s   N(11,3), ;
                    UsuLibs  C(10),   ;
                    Amarra   N(10,0)  ;
                )
                INDEX ON NVL(Amarra, 0) TAG Amarra
            ENDIF

            *-- Aparencia base do form (OPERACIONAL sem PageFrame Page1/Page2)
            THIS.ConfigurarPageFrame()

            *-- Interface
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarBalanca()

            *-- Verifica permissao de liberar peso
            THIS.this_lLiberaPeso = THIS.this_oBusinessObject.BuscarPermissaoLiberaPeso()

            *-- Inicializa PesoFixs a partir de xNensI
            THIS.InicializarPesoFixs()

            *-- Posiciona xPesa no inicio
            IF USED("xPesa")
                SELECT xPesa
                SET ORDER TO Amarra
                GO TOP
            ENDIF

            THIS.Refresh()
            loc_lSucesso = .T.
        ELSE
            MsgErro("Falha ao criar SigPdMp9BO.", "Erro")
        ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar FormSigPdMp9")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursoresLocais - Cria CrSigCdNei e xNensiE na datasession compartilhada
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresLocais()
        LOCAL loc_oErro
        TRY
            SET NULL OFF

            *-- CrSigCdNei: buffer local de movimentos antes de gravar no SQL Server
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ELSE
                CREATE CURSOR CrSigCdNei ( ;
                    Emps      C(3),    ;
                    Dopps     C(10),   ;
                    Numps     N(10,0), ;
                    Nops      N(10,0), ;
                    Nenvs     N(10,0), ;
                    CMats     C(14),   ;
                    CDescs    C(40),   ;
                    CUnis     C(3),    ;
                    Tpops     C(3),    ;
                    Cats      C(6),    ;
                    Obss      C(40),   ;
                    AQtds     N(11,3), ;
                    Qtds      N(11,3), ;
                    Pesos     N(11,3), ;
                    FlagIncs  L,       ;
                    Fators    N(11,3), ;
                    Moedas    C(3),    ;
                    Servicos  L,       ;
                    GrupoFins C(10),   ;
                    nLotes    N(8,3),  ;
                    PesoFixs  N(3,0),  ;
                    cIdChaves C(20),   ;
                    EmpDNPs   C(23),   ;
                    Peso2s    N(11,3), ;
                    CustoFs   N(11,2), ;
                    MoeCusFs  C(3)     ;
                )
            ENDIF

            *-- xNensiE: cursor auxiliar para rateio de peso por envelope
            IF USED("xNensI")
                IF USED("xNensiE")
                    SELECT xNensiE
                    ZAP
                ELSE
                    SELECT * FROM xNensI WHERE .F. INTO CURSOR xNensiE READWRITE
                    SELECT xNensiE
                    IF TYPE("Rateio") <> "U"
                        INDEX ON NVL(Rateio, 0)          TAG Rateio
                    ENDIF
                    IF TYPE("Nenvs") <> "U"
                        INDEX ON NVL(Nenvs, 0)           TAG Nenvs
                    ENDIF
                    IF TYPE("Gravar") <> "U"
                        INDEX ON ALLTRIM(NVL(Gravar, "")) TAG Gravar
                    ENDIF
                    IF TYPE("PsFaseAnt") <> "U"
                        INDEX ON NVL(PsFaseAnt, 0)       TAG PsFaseAnt
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao criar cursores locais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
    * Este metodo define propriedades visuais globais do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * Destroy - Libera objetos e cursores
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        IF USED("CrSigCdNei")
            USE IN CrSigCdNei
        ENDIF
        IF USED("xNensiE")
            USE IN xNensiE
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container de titulo com efeito sombra
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cTitulo
        loc_cTitulo = "Pesagem de Pe" + CHR(231) + "as"
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cTitulo
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width
                .ForeColor  = RGB(0, 0, 0)
                .Visible    = .T.
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cTitulo
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura a "pagina" principal do form OPERACIONAL
    * Em forms OPERACIONAIS nao ha PageFrame Page1/Page2 como nos CRUD.
    * Esta procedure agrupa Grid (lista de pecas) e Rodape (botoes de acao):
    *   - cmd_4c_Resumo    - Abre janela de resumo (SigPdM10)
    *   - cmd_4c_CustoP    - Visualiza custos do produto (apenas com permissao)
    *   - cmd_4c_Processar - Confirma pesagem e segue para SigPdM11
    *   - cmd_4c_Cancelar  - Cancela e fecha o form
    * O legado nao usa botoes CRUD (Incluir/Alterar/Excluir/Buscar) porque
    * a pesagem ja recebe a lista de pecas pronta do form pai.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrid()
        THIS.ConfigurarRodape()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grid GradeItens com 9 colunas ligadas a xPesa
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_lAcesso, loc_lLibObss, loc_lTrfPesas
        loc_lAcesso  = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
        loc_lLibObss = .F.
        loc_lTrfPesas = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            IF VARTYPE(crSigCdPam.LibObss) = "L"
                loc_lLibObss = crSigCdPam.LibObss
            ELSE
                IF VARTYPE(crSigCdPam.LibObss) = "L"
                    loc_lLibObss = crSigCdPam.LibObss
                ELSE
                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                        loc_lLibObss = crSigCdPam.LibObss
                    ELSE
                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                            loc_lLibObss = crSigCdPam.LibObss
                        ELSE
                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                loc_lLibObss = crSigCdPam.LibObss
                            ELSE
                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                    loc_lLibObss = crSigCdPam.LibObss
                                ELSE
                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                        loc_lLibObss = crSigCdPam.LibObss
                                    ELSE
                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                            loc_lLibObss = crSigCdPam.LibObss
                                        ELSE
                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                loc_lLibObss = crSigCdPam.LibObss
                                            ELSE
                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                    loc_lLibObss = crSigCdPam.LibObss
                                                ELSE
                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                        loc_lLibObss = crSigCdPam.LibObss
                                                    ELSE
                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                            loc_lLibObss = crSigCdPam.LibObss
                                                        ELSE
                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                loc_lLibObss = crSigCdPam.LibObss
                                                            ELSE
                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                ELSE
                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                    ELSE
                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                        ELSE
                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                            ELSE
                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                ELSE
                                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                                    ELSE
                                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                                        ELSE
                                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                                            ELSE
                                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                                ELSE
                                                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                                                    ELSE
                                                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                                                        ELSE
                                                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                                                            ELSE
                                                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                                                ELSE
                                                                                                                    loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF USED("crSigCdOpd")
            SELECT crSigCdOpd
            GO TOP
            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                loc_lTrfPesas = crSigCdOpd.TrfPesas
            ELSE
                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                ELSE
                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                    ELSE
                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                        ELSE
                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                            ELSE
                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                ELSE
                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                    ELSE
                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                        ELSE
                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                            ELSE
                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                ELSE
                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                    ELSE
                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                        ELSE
                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                            ELSE
                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                ELSE
                                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                    ELSE
                                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                        ELSE
                                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                            ELSE
                                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                ELSE
                                                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                    ELSE
                                                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                        ELSE
                                                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                            ELSE
                                                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                ELSE
                                                                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                    ELSE
                                                                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                        ELSE
                                                                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                            ELSE
                                                                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                                ELSE
                                                                                                                    loc_lTrfPesas = (NVL(crSigCdOpd.TrfPesas, 0) = 1)
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        THIS.AddObject("grd_4c_Itens", "Grid")
        THIS.grd_4c_Itens.RecordSource = "xPesa"
        THIS.grd_4c_Itens.ColumnCount  = 9
        WITH THIS.grd_4c_Itens
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .Height            = 463
            .Left              = 10
            .Panel             = 1
            .RowHeight         = 17
            .ScrollBars        = 2
            .TabIndex          = 1
            .Top               = 111
            .Width             = 980
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = loc_lTrfPesas

            *-- Column1: Produto (Cpros) - ReadOnly
            WITH .Column1
                .ControlSource     = "xPesa.Cpros"
                .ColumnOrder       = 3
                .Width             = 120
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Produto"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "When", THIS, "GradeCol1TextWhen")

            *-- Column2: Observacao (Obs) - editavel com LibObss=1 e INSERIR
            WITH .Column2
                .ControlSource     = "xPesa.Obs"
                .ColumnOrder       = 6
                .Width             = 100
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = !loc_lLibObss
                .FontSize          = 8
                .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "When", THIS, "GradeCol2TextWhen")

            *-- Column3: Movimentacao (Oper) - ReadOnly
            WITH .Column3
                .ControlSource     = "xPesa.Oper"
                .ColumnOrder       = 4
                .Width             = 221
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "When", THIS, "GradeCol3TextWhen")

            *-- Column4: Tamanho (Tams) - lookup SigCdTam, editavel com LibObss=1
            WITH .Column4
                .ControlSource     = "xPesa.Tams"
                .ColumnOrder       = 8
                .Width             = 40
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .FontSize          = 8
                .Header1.Caption   = "Tam"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "When",     THIS, "GradeCol4TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "KeyPress", THIS, "GradeCol4TextKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "DblClick", THIS, "GradeCol4TextDblClick")

            *-- Column5: Quantidade (Qtds) - ReadOnly (editavel se LibObss<>1)
            WITH .Column5
                .ControlSource     = "xPesa.Qtds"
                .ColumnOrder       = 5
                .Width             = 100
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontBold          = .T.
                .FontSize          = 8
                .Format            = "K"
                .Header1.Caption   = "Quantidade"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontBold    = .T.
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column5.Text1, "When", THIS, "GradeCol5TextWhen")

            *-- Column6: Peso (Peso) - campo editavel principal com logica de balanca
            WITH .Column6
                .ControlSource     = "xPesa.Peso"
                .ColumnOrder       = 9
                .Width             = 100
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .FontBold          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Peso"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontBold    = .T.
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "When",      THIS, "GradeCol6TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "Valid",     THIS, "GradeCol6TextValid")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress", THIS, "GradeCol6TextLostFocus")

            *-- Column7: Cor (Cors) - lookup SigCdCor, editavel com LibObss=1
            WITH .Column7
                .ControlSource     = "xPesa.Cors"
                .ColumnOrder       = 7
                .Width             = 40
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .FontSize          = 8
                .Header1.Caption   = "Cor"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "When",     THIS, "GradeCol7TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "KeyPress", THIS, "GradeCol7TextKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "DblClick", THIS, "GradeCol7TextDblClick")

            *-- Column8: Barras (Cbars) - ReadOnly
            WITH .Column8
                .ControlSource     = "xPesa.Cbars"
                .ColumnOrder       = 2
                .Width             = 110
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Barras"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "When", THIS, "GradeCol8TextWhen")

            *-- Column9: Custo (CustoFs) - ReadOnly, visivel apenas com permissao CUSTOP
            WITH .Column9
                .ControlSource     = "xPesa.CustoFs"
                .ColumnOrder       = 1
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Custo"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "When",     THIS, "GradeCol9TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "DblClick", THIS, "GradeCol9TextDblClick")

            *-- Cor dinamica: peca especial em vermelho
            .SetAll("DynamicForeColor", ;
                    "IIF(xPesa.Especial,RGB(255,0,0),RGB(0,0,0))", "Column")

            *-- Ajuste de largura Column9 por permissao de acesso
            IF loc_lAcesso
                .Column9.Width = 72
            ELSE
                .Column9.Width  = 1
                .Column3.Width  = .Column3.Width + 71
            ENDIF

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarRodape - Botoes de acao, peso medio e indicador de peca especial
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRodape()
        LOCAL loc_cIconPath, loc_lAcesso
        loc_cIconPath = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\imagens\"
        loc_lAcesso   = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")

        *-- Label "Peso medio :"
        THIS.AddObject("lbl_4c_PesoMedio", "Label")
        WITH THIS.lbl_4c_PesoMedio
            .FontSize  = 8
            .Caption   = "Peso m" + CHR(233) + "dio :"
            .Left      = 49
            .Top       = 88
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Peso Medio (equivalente a get_pesom do legado)
        THIS.AddObject("txt_4c_PesoMedio", "TextBox")
        WITH THIS.txt_4c_PesoMedio
            .FontUnderline = .T.
            .Alignment     = 3
            .Value         = 0
            .Height        = 23
            .InputMask     = "999.999"
            .Left          = 114
            .TabIndex      = 6
            .Top           = 84
            .Width         = 72
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_PesoMedio, "LostFocus", THIS, "TxtPesoMedioValid")

        *-- Indicador de peca especial (caixa vermelha decorativa - Botao1 do legado)
        THIS.AddObject("txt_4c_Especial", "TextBox")
        WITH THIS.txt_4c_Especial
            .Height        = 20
            .Left          = 12
            .SpecialEffect = 1
            .ToolTipText   = "Pe" + CHR(231) + "a Especial"
            .Top           = 86
            .Width         = 27
            .BackColor     = RGB(255, 0, 0)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Especial, "When", THIS, "TxtEspecialWhen")

        *-- Botao Resumo
        THIS.AddObject("cmd_4c_Resumo", "CommandButton")
        WITH THIS.cmd_4c_Resumo
            .Top       = 3
            .Left      = 700
            .Height    = 75
            .Width     = 75
            .Caption   = "\<Resumo"
            .Themes           = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "geral_documento_60.jpg")
                .Picture = loc_cIconPath + "geral_documento_60.jpg"
            ENDIF
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Resumo, "Click", THIS, "BtnResumoClick")

        *-- Botao CustoP (visivel apenas com permissao CUSTOP)
        THIS.AddObject("cmd_4c_CustoP", "CommandButton")
        WITH THIS.cmd_4c_CustoP
            .Top         = 3
            .Left        = 775
            .Height      = 75
            .Width       = 75
            .Caption     = "Cus\<tos"
            .ToolTipText = "Custo Produ" + CHR(231) + CHR(227) + "o"
            .Themes           = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "geral_calculadora_60.jpg")
                .Picture = loc_cIconPath + "geral_calculadora_60.jpg"
            ENDIF
            .Visible     = loc_lAcesso
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CustoP, "Click", THIS, "BtnCustoPClick")

        *-- Botao Processar (Confirmar)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top       = 3
            .Left      = 850
            .Height    = 75
            .Width     = 75
            .Caption   = "\<Confirmar"
            .Themes           = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "cadastro_salvar_60.jpg")
                .Picture = loc_cIconPath + "cadastro_salvar_60.jpg"
            ENDIF
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Cancelar
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top       = 3
            .Left      = 925
            .Height    = 75
            .Width     = 75
            .Cancel    = .T.
            .Caption   = "Encerrar"
            .Themes           = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "cadastro_cancelar_60.jpg")
                .Picture = loc_cIconPath + "cadastro_cancelar_60.jpg"
            ENDIF
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Elementos visuais decorativos do form OPERACIONAL
    * Forms OPERACIONAIS nao tem Page2/PaginaDados como nos CRUD.
    * Este metodo adiciona as shapes visuais do legado (Shape2 e Shape1)
    * que flanqueiam a area de cabecalho e botoes respectivamente.
    * Shape2: moldura esquerda (area de identificacao do form)
    * Shape1: moldura direita (area de botoes de acao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            *-- Shape2: moldura decorativa lado esquerdo (area de titulo)
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 11
                .Left        = 10
                .Height      = 110
                .Width       = 172
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Shape1: moldura decorativa lado direito (area dos botoes de acao)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 11
                .Left        = 817
                .Height      = 110
                .Width       = 172
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(0, 0, 0)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar elementos visuais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBalanca - Conecta controle de balanca serial do framework
    * Configurado a partir de crSigCdPam (Porta, Velocidade, Paridade, etc.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBalanca()
        LOCAL loc_oErro
        THIS.this_lTemBalanca = .F.
        TRY
            IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            LOCAL loc_cVcx
            loc_cVcx = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\framework.vcx"
            IF FILE(loc_cVcx)
            SET CLASSLIB TO (loc_cVcx) ADDITIVE
            THIS.AddObject("bal_4c_Balanca", "balan" + CHR(231) + "a")
            WITH THIS.bal_4c_Balanca
                .Top          = 84
                .Left         = 924
                .Height       = 36
                .Width        = 24
                .Porta        = NVL(crSigCdPam.BalPortas, 0)
                .Velocidade   = NVL(crSigCdPam.BalVelocs, 0)
                .TipoParidade = NVL(crSigCdPam.BalTppars, 0)
                .Bits         = NVL(crSigCdPam.BalBits,   0)
                .Paridade     = NVL(crSigCdPam.BalParids, 0)
                IF NVL(crSigCdPam.BalPortas, 0) = 0
                    .Leitura = "T"
                ENDIF
                .Visible      = .T.
            ENDWITH
            THIS.this_lTemBalanca = .T.
            ENDIF && FILE(loc_cVcx)
            ENDIF && USED("crSigCdPam")
        CATCH TO loc_oErro
            *-- Balanca nao disponivel - pesagem manual
        ENDTRY
    ENDPROC

    *==========================================================================
    * InicializarPesoFixs - Calcula PesoFixs para cada peca em xPesa
    * a partir dos pesos fixos acumulados em xNensi (Rateio=3, !Visivel)
    * Replica logica de Select/Index/Scan no Init do legado
    *==========================================================================
    PROTECTED PROCEDURE InicializarPesoFixs()
        LOCAL loc_oErro, loc_lPesMatPs
        loc_lPesMatPs = .F.
        TRY
            IF USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
            SELECT crSigCdOpd
            GO TOP
            loc_lPesMatPs = (NVL(crSigCdOpd.pesMatPs, 0) <> 0)
            IF loc_lPesMatPs

            *-- Total de pecas por envelope
            IF USED("tPesa_4c")
                USE IN tPesa_4c
            ENDIF
            SELECT Nenvs, SUM(Qtds) AS Qtds ;
              FROM xPesa ;
             GROUP BY Nenvs ;
              INTO CURSOR tPesa_4c

            *-- Peso fixo (Rateio=3, !Visivel) por envelope
            IF USED("xRateio_4c")
                USE IN xRateio_4c
            ENDIF
            SELECT a.Nenvs, SUM(a.Pesos) AS Pesos, b.Qtds ;
              FROM xNensI a, tPesa_4c b ;
             WHERE !IIF(VARTYPE(a.Visivel)="L", a.Visivel, NVL(a.Visivel,0)=1) ;
               AND NVL(a.Rateio, 0) = 3 ;
               AND a.Nenvs = b.Nenvs ;
             GROUP BY a.Nenvs, b.Qtds ;
              INTO CURSOR xRateio_4c

            IF RECCOUNT("xRateio_4c") > 0
                SELECT xRateio_4c
                INDEX ON NVL(Nenvs, 0) TAG Nenvs

                SELECT xPesa
                SCAN
                    LOCAL loc_nNenv, loc_nQtds, loc_nPesoFixs
                    loc_nNenv    = NVL(xPesa.Nenvs, 0)
                    loc_nQtds    = NVL(xPesa.Qtds, 0)
                    loc_nPesoFixs = 0
                    SELECT xRateio_4c
                    IF SEEK(loc_nNenv) AND NVL(xRateio_4c.Pesos, 0) <> 0 AND xRateio_4c.Qtds <> 0
                        loc_nPesoFixs = (xRateio_4c.Pesos / xRateio_4c.Qtds) * loc_nQtds
                        SELECT xPesa
                        REPLACE xPesa.PesoFixs WITH loc_nPesoFixs
                    ENDIF
                    SELECT xPesa
                ENDSCAN
            ENDIF

            IF USED("xRateio_4c")
                USE IN xRateio_4c
            ENDIF
            IF USED("tPesa_4c")
                USE IN tPesa_4c
            ENDIF
            ENDIF && loc_lPesMatPs
            ENDIF && USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar PesoFixs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HANDLERS DE GRID - Eventos do Grid grd_4c_Itens (PUBLIC para BINDEVENT)
    *--------------------------------------------------------------------------

    *==========================================================================
    * GradeCol1TextWhen - Produto (sempre ReadOnly)
    *==========================================================================
    FUNCTION GradeCol1TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol2TextWhen - Observacao: editavel apenas com LibObss=1 e modo INSERIR
    *==========================================================================
    FUNCTION GradeCol2TextWhen()
        LOCAL loc_lLibObss, loc_lModoInserir
        loc_lLibObss = .F.
        loc_lModoInserir = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            IF VARTYPE(crSigCdPam.LibObss) = "L"
                loc_lLibObss = crSigCdPam.LibObss
            ELSE
                IF VARTYPE(crSigCdPam.LibObss) = "L"
                    loc_lLibObss = crSigCdPam.LibObss
                ELSE
                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                        loc_lLibObss = crSigCdPam.LibObss
                    ELSE
                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                            loc_lLibObss = crSigCdPam.LibObss
                        ELSE
                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                loc_lLibObss = crSigCdPam.LibObss
                            ELSE
                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                    loc_lLibObss = crSigCdPam.LibObss
                                ELSE
                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                        loc_lLibObss = crSigCdPam.LibObss
                                    ELSE
                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                            loc_lLibObss = crSigCdPam.LibObss
                                        ELSE
                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                loc_lLibObss = crSigCdPam.LibObss
                                            ELSE
                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                    loc_lLibObss = crSigCdPam.LibObss
                                                ELSE
                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                        loc_lLibObss = crSigCdPam.LibObss
                                                    ELSE
                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                            loc_lLibObss = crSigCdPam.LibObss
                                                        ELSE
                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                loc_lLibObss = crSigCdPam.LibObss
                                                            ELSE
                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                ELSE
                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                    ELSE
                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                        ELSE
                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                            ELSE
                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                ELSE
                                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                                    ELSE
                                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                                        ELSE
                                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                                            ELSE
                                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                                ELSE
                                                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                                                    ELSE
                                                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                                                        ELSE
                                                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                                                            ELSE
                                                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                                                ELSE
                                                                                                                    loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            loc_lModoInserir = (ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR")
        ENDIF
        RETURN loc_lLibObss AND loc_lModoInserir
    ENDFUNC

    *==========================================================================
    * GradeCol3TextWhen - Movimentacao (ReadOnly)
    *==========================================================================
    FUNCTION GradeCol3TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol4TextWhen - Tamanho: editavel apenas com LibObss=1
    *==========================================================================
    FUNCTION GradeCol4TextWhen()
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            RETURN NVL(crSigCdPam.LibObss, 0) = 1
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol4TextKeyPress - Tamanho: F4/F5 abre lookup SigCdTam
    *==========================================================================
    FUNCTION GradeCol4TextKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116  && F4 ou F5
            THIS.AbrirLookupTamanho()
            RETURN .F.
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol4TextDblClick - Tamanho: duplo clique abre lookup SigCdTam
    *==========================================================================
    FUNCTION GradeCol4TextDblClick()
        THIS.AbrirLookupTamanho()
    ENDFUNC

    *==========================================================================
    * AbrirLookupTamanho - Abre FormBuscaAuxiliar em SigCdTam
    *==========================================================================
    FUNCTION AbrirLookupTamanho()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_cValor = ""
            IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column4) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column4.Text1) = "O"
                loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column4.Text1.Value, ""))
            ENDIF
            IF EMPTY(loc_cValor) AND USED("xPesa")
                SELECT xPesa
                loc_cValor = ALLTRIM(NVL(Tams, ""))
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_TamBusca", "Cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TamBusca")
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Tams WITH ALLTRIM(cursor_4c_TamBusca.Cods)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_TamBusca")
                USE IN cursor_4c_TamBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
        ENDTRY
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol5TextWhen - Quantidade: editavel apenas se LibObss <> 1
    *==========================================================================
    FUNCTION GradeCol5TextWhen()
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            RETURN NVL(crSigCdPam.LibObss, 0) <> 1
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol6TextWhen - Peso: salva OldValue, ativa balanca, controla edicao
    * Replica Column6.Text1.When do legado
    *==========================================================================
    FUNCTION GradeCol6TextWhen()
        LOCAL loc_lModoInserir, loc_lPesoBals, loc_lTrfPesas
        THIS.this_lAlterou = .F.
        IF USED("xPesa")
            SELECT xPesa
            THIS.this_nOldValue = NVL(Peso, 0)
        ENDIF
        loc_lModoInserir = .F.
        loc_lPesoBals    = .F.
        loc_lTrfPesas    = .F.
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            loc_lModoInserir = (ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR")
        ENDIF
        IF USED("crSigCdOpd")
            SELECT crSigCdOpd
            GO TOP
            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                loc_lPesoBals = crSigCdOpd.PesoBals
            ELSE
                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                    loc_lPesoBals = crSigCdOpd.PesoBals
                ELSE
                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                        loc_lPesoBals = crSigCdOpd.PesoBals
                    ELSE
                        IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                            loc_lPesoBals = crSigCdOpd.PesoBals
                        ELSE
                            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                loc_lPesoBals = crSigCdOpd.PesoBals
                            ELSE
                                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                    loc_lPesoBals = crSigCdOpd.PesoBals
                                ELSE
                                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                        loc_lPesoBals = crSigCdOpd.PesoBals
                                    ELSE
                                        IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                            loc_lPesoBals = crSigCdOpd.PesoBals
                                        ELSE
                                            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                loc_lPesoBals = crSigCdOpd.PesoBals
                                            ELSE
                                                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                    loc_lPesoBals = crSigCdOpd.PesoBals
                                                ELSE
                                                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                        loc_lPesoBals = crSigCdOpd.PesoBals
                                                    ELSE
                                                        IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                            loc_lPesoBals = crSigCdOpd.PesoBals
                                                        ELSE
                                                            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                loc_lPesoBals = crSigCdOpd.PesoBals
                                                            ELSE
                                                                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                    loc_lPesoBals = crSigCdOpd.PesoBals
                                                                ELSE
                                                                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                        loc_lPesoBals = crSigCdOpd.PesoBals
                                                                    ELSE
                                                                        IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                            loc_lPesoBals = crSigCdOpd.PesoBals
                                                                        ELSE
                                                                            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                loc_lPesoBals = crSigCdOpd.PesoBals
                                                                            ELSE
                                                                                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                    loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                ELSE
                                                                                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                        loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                    ELSE
                                                                                        IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                            loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                        ELSE
                                                                                            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                                loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                            ELSE
                                                                                                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                                    loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                                ELSE
                                                                                                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                                        loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                                    ELSE
                                                                                                        IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                                            loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                                        ELSE
                                                                                                            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                                                loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                                            ELSE
                                                                                                                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                                                                                                    loc_lPesoBals = crSigCdOpd.PesoBals
                                                                                                                ELSE
                                                                                                                    loc_lPesoBals = (NVL(crSigCdOpd.PesoBals, 0) = 1)
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                loc_lTrfPesas = crSigCdOpd.TrfPesas
            ELSE
                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                ELSE
                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                    ELSE
                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                        ELSE
                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                            ELSE
                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                ELSE
                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                    ELSE
                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                        ELSE
                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                            ELSE
                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                ELSE
                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                    ELSE
                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                        ELSE
                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                            ELSE
                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                ELSE
                                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                    ELSE
                                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                        ELSE
                                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                            ELSE
                                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                ELSE
                                                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                    ELSE
                                                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                        ELSE
                                                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                            ELSE
                                                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                ELSE
                                                                                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                    ELSE
                                                                                                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                        ELSE
                                                                                                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                            ELSE
                                                                                                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                                                                                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                                                                                                ELSE
                                                                                                                    loc_lTrfPesas = (NVL(crSigCdOpd.TrfPesas, 0) = 1)
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        *-- Ativa balanca serial quando no modo INSERIR e nao transferencia
        IF loc_lModoInserir AND !loc_lTrfPesas AND THIS.this_lTemBalanca
            LOCAL loc_oErro
            TRY
                LOCAL loc_oTxt
                loc_oTxt = THIS.grd_4c_Itens.Column6.Text1
                THIS.bal_4c_Balanca.Ativa(loc_oTxt)
                *-- Se balanca preencheu peso e usuario nao cancelou: avanca linha
                IF NVL(loc_oTxt.Value, 0) <> 0 AND LASTKEY() <> 27 AND ;
                   !THIS.bal_4c_Balanca.TempoEsgotado
                    IF USED("xPesa")
                        SELECT xPesa
                        SKIP
                        IF !EOF()
                            IF USED("crSigCdPam") AND NVL(crSigCdPam.LibObss, 0) = 1
                                THIS.grd_4c_Itens.Column2.SetFocus()
                            ELSE
                                THIS.grd_4c_Itens.Column5.SetFocus()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                *-- Balanca falhou durante ativacao - continuar com peso manual
            ENDTRY
        ENDIF
        RETURN loc_lModoInserir AND !loc_lPesoBals
    ENDFUNC

    *==========================================================================
    * GradeCol6TextValid - Peso: valida negativo e diferenca de tolerancia
    * Replica Column6.Text1.Valid do legado
    *==========================================================================
    FUNCTION GradeCol6TextValid()
        LOCAL loc_lValido, loc_nValorAtual, loc_oErro
        LOCAL loc_nQtds, loc_nPesoFixs, loc_nPesagem, loc_nXDif, loc_nDifPesags
        loc_lValido     = .T.
        loc_nValorAtual = 0
        TRY
            IF USED("xPesa")
                SELECT xPesa
                loc_nValorAtual = NVL(Peso, 0)
                loc_nQtds       = NVL(Qtds, 0)
                loc_nPesoFixs   = NVL(PesoFixs, 0)
            ENDIF

            *-- Sem alteracao ou zero: sem validacao
            IF loc_nValorAtual <> 0 AND loc_nValorAtual <> THIS.this_nOldValue
                *-- Valor negativo: nao permitido
                IF loc_nValorAtual < 0
                    MsgAviso("O Peso N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Peso WITH THIS.this_nOldValue
                    ENDIF
                    loc_lValido = .F.
                ELSE
                    THIS.this_lAlterou = .T.

            *-- Verifica tolerancia de diferenca de peso
            IF !THIS.this_oBusinessObject.VerificarDiferencaPeso(loc_nValorAtual)
                *-- Fora do limite - calcula valores para mensagem
                loc_nPesagem  = 0
                loc_nDifPesags = 0
                IF USED("crSigCdPam")
                    SELECT crSigCdPam
                    GO TOP
                    loc_nDifPesags = NVL(crSigCdPam.DifPesags, 0)
                ENDIF
                IF loc_nQtds <> 0
                    loc_nPesagem = (loc_nValorAtual / loc_nQtds) - loc_nPesoFixs
                ENDIF

                MsgAviso("Peso Diferente do Peso da Tabela e fora do Limite de " + ;
                    TRANSFORM(loc_nDifPesags, "@Z 999.99%") + CHR(13) + ;
                    "Real: " + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z 9999.999")), "")

                IF THIS.this_lLiberaPeso
                    *-- Solicita senha de autorizacao (SigOpSen)
                    LOCAL loc_cRetorno, loc_lOk, loc_cInfo
                    loc_cRetorno = ""
                    loc_cInfo    = "Libera Pesagem R:" + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z999.999"))
                    DO FORM SigOpSen WITH "LIBPESO", loc_cInfo, "" TO loc_cRetorno
                    CLEAR TYPEAHEAD
                    loc_lOk = (LEFT(ALLTRIM(loc_cRetorno), 1) = "*")
                    IF !loc_lOk
                        MsgAviso("Pesagem n" + CHR(227) + "o autorizada!!!", "")
                        IF USED("xPesa")
                            SELECT xPesa
                            REPLACE Peso WITH 0
                        ENDIF
                        loc_lValido = .F.
                    ELSE
                        IF USED("xPesa")
                            SELECT xPesa
                            REPLACE UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10)
                        ENDIF
                    ENDIF
                ELSE
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Peso WITH THIS.this_nOldValue
                    ENDIF
                    loc_lValido = .F.
                ENDIF
            ENDIF && !VerificarDiferencaPeso
                ENDIF && loc_nValorAtual >= 0
            ENDIF && loc_nValorAtual <> 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na valida" + CHR(231) + CHR(227) + "o do peso")
            loc_lValido = .T.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * GradeCol6TextLostFocus - Apos saida do campo Peso: rateio, custo, especial
    * Replica Column6.Text1.LostFocus do legado
    *==========================================================================
    PROCEDURE GradeCol6TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nValorAtual, loc_nRecno, loc_nNenv, loc_oErro
        LOCAL loc_lEspecial, loc_nNops, loc_cCpros, loc_nCusto
        TRY
            IF USED("xPesa")
                SELECT xPesa
                loc_nValorAtual = NVL(Peso, 0)
            ENDIF
            IF loc_nValorAtual <> 0 AND THIS.this_lAlterou
                SELECT xPesa
                loc_nRecno    = RECNO()
                loc_nNenv     = NVL(Nenvs, 0)
                loc_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
                loc_nNops     = NVL(Nops, 0)
                loc_cCpros    = ALLTRIM(NVL(Cpros, ""))

            *-- Distribui rateio de peso entre materiais do envelope
            THIS.this_oBusinessObject.DistribuirRateio(loc_nRecno)

            *-- Calcula custo de producao e atualiza xPesa.CustoFs
            loc_nCusto = THIS.this_oBusinessObject.CalcularCustoProducao(loc_nNops, loc_cCpros)
            IF USED("xPesa")
                SELECT xPesa
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
                REPLACE CustoFs WITH loc_nCusto
            ENDIF

            *-- Peca especial: processa composicao SigPrCpo
            IF loc_lEspecial
                THIS.ProcessarPesoEspecial(loc_nNenv, loc_nNops, loc_cCpros, loc_nRecno)
            ENDIF

            *-- Navegacao: avanca para proxima peca
            IF USED("xPesa")
                SELECT xPesa
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
                SKIP
                KEYBOARD "{DOWNARROW}"
                IF EOF("xPesa")
                    IF VARTYPE(THIS.cmd_4c_Resumo) = "O"
                        THIS.cmd_4c_Resumo.SetFocus()
                    ENDIF
                ELSE
                    IF USED("crSigCdPam") AND NVL(crSigCdPam.LibObss, 0) = 1
                        THIS.grd_4c_Itens.Column2.SetFocus()
                    ELSE
                        THIS.grd_4c_Itens.Column5.SetFocus()
                        KEYBOARD "{LEFTARROW}"
                    ENDIF
                ENDIF
            ENDIF
            ENDIF && loc_nValorAtual <> 0 AND this_lAlterou
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar LostFocus do Peso")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeCol7TextWhen - Cor: editavel apenas com LibObss=1
    *==========================================================================
    FUNCTION GradeCol7TextWhen()
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            RETURN NVL(crSigCdPam.LibObss, 0) = 1
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol7TextKeyPress - Cor: F4/F5 abre lookup SigCdCor
    *==========================================================================
    FUNCTION GradeCol7TextKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116  && F4 ou F5
            THIS.AbrirLookupCor()
            RETURN .F.
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol7TextDblClick - Cor: duplo clique abre lookup SigCdCor
    *==========================================================================
    FUNCTION GradeCol7TextDblClick()
        THIS.AbrirLookupCor()
    ENDFUNC

    *==========================================================================
    * AbrirLookupCor - Abre FormBuscaAuxiliar em SigCdCor
    *==========================================================================
    FUNCTION AbrirLookupCor()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_cValor = ""
            IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column7) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column7.Text1) = "O"
                loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column7.Text1.Value, ""))
            ENDIF
            IF EMPTY(loc_cValor) AND USED("xPesa")
                SELECT xPesa
                loc_cValor = ALLTRIM(NVL(Cors, ""))
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_CorBusca", "Cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Cor", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CorBusca")
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Cors WITH ALLTRIM(cursor_4c_CorBusca.Cods)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_CorBusca")
                USE IN cursor_4c_CorBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cor")
        ENDTRY
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol8TextWhen - Barras (ReadOnly)
    *==========================================================================
    FUNCTION GradeCol8TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol9TextWhen - Custo (ReadOnly)
    *==========================================================================
    FUNCTION GradeCol9TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol9TextDblClick - Custo: abre SigCdPro se tiver permissao CUSTOP
    *==========================================================================
    PROCEDURE GradeCol9TextDblClick()
        LOCAL loc_nRecno, loc_oErro
        TRY
            IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND USED("xPesa")
                SELECT xPesa
                loc_nRecno = RECNO()
                DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
                SELECT xPesa
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtEspecialWhen - Indicador visual de peca especial (ReadOnly decorativo)
    *==========================================================================
    FUNCTION TxtEspecialWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * TxtPesoMedioValid - Distribui peso medio por todas as pecas do cursor xPesa
    * Replica get_pesom.Valid do legado
    *==========================================================================
    FUNCTION TxtPesoMedioValid()
        LOCAL loc_nPesoMedio, loc_oErro
        TRY
            loc_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
            IF !EMPTY(loc_nPesoMedio) AND loc_nPesoMedio <> 0
                THIS.this_oBusinessObject.AtualizarPesoMedio(loc_nPesoMedio)
                IF VARTYPE(THIS.grd_4c_Itens) = "O"
                    THIS.grd_4c_Itens.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao distribuir peso m" + CHR(233) + "dio")
        ENDTRY
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * HANDLERS DE BOTOES
    *--------------------------------------------------------------------------

    *==========================================================================
    * BtnIncluirClick - Adiciona nova pe" + CHR(231) + "a na grade de pesagem
    * Form OPERACIONAL: Incluir adiciona linha em xPesa para nova pesagem
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
               !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Inclus" + CHR(227) + "o de pe" + CHR(231) + "a permitida apenas em modo Inserir/Alterar.", "Aviso")
                RETURN
            ENDIF
            IF !USED("xPesa")
                MsgAviso("Cursor de pesagem n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            APPEND BLANK
            REPLACE Peso WITH 0, Qtds WITH 1
            THIS.this_lAlterou = .T.
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
                THIS.grd_4c_Itens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao incluir pe" + CHR(231) + "a")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Foca grade na pe" + CHR(231) + "a corrente para editar peso
    * Form OPERACIONAL: Alterar = editar peso da pe" + CHR(231) + "a corrente
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
               !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Altera" + CHR(231) + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
                RETURN
            ENDIF
            IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "as para alterar.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            IF EOF() OR BOF()
                GO TOP
            ENDIF
            THIS.this_lAlterou = .T.
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.SetFocus()
                IF PEMSTATUS(THIS.grd_4c_Itens, "Column6", 5)
                    THIS.grd_4c_Itens.Column6.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar pe" + CHR(231) + "a")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe custo/composi" + CHR(231) + CHR(227) + "o da pe" + CHR(231) + "a corrente
    * Form OPERACIONAL: Visualizar abre SigCdPro com produto corrente
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_nRecno, loc_cCpros
        TRY
            IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para visualizar.", "Aviso")
                RETURN
            ENDIF
            IF !fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
                MsgAviso("Sem permiss" + CHR(227) + "o para visualizar custo.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            loc_nRecno = RECNO()
            loc_cCpros = ALLTRIM(NVL(Cpros, ""))
            IF EMPTY(loc_cCpros)
                MsgAviso("Pe" + CHR(231) + "a sem produto associado.", "Aviso")
                RETURN
            ENDIF
            DO FORM SigCdPro WITH "PESAGEM", loc_cCpros
            SELECT xPesa
            IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                GO loc_nRecno
            ENDIF
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar pe" + CHR(231) + "a")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Zera peso da pe" + CHR(231) + "a corrente (desfaz pesagem)
    * Form OPERACIONAL: Excluir zera Peso e PesoFixs da linha corrente
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_lConfirma
        TRY
            IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
               !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Exclus" + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
                RETURN
            ENDIF
            IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para excluir.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            IF EOF() OR BOF()
                GO TOP
            ENDIF
            loc_lConfirma = MsgConfirma("Confirma desfazer a pesagem desta pe" + CHR(231) + "a?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF !loc_lConfirma
                RETURN
            ENDIF
            SELECT xPesa
            REPLACE Peso WITH 0
            IF TYPE("xPesa.PesoFixs") <> "U"
                REPLACE PesoFixs WITH 0
            ENDIF
            THIS.this_lAlterou = .T.
            THIS.this_nOldValue = 0
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
                THIS.grd_4c_Itens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir pesagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnResumoClick - Abre form de resumo SigPdM10 com referencia ao form pai
    *==========================================================================
    PROCEDURE BtnResumoClick()
        DO FORM SigPdM10 WITH THIS.this_oPaiForm
    ENDPROC

    *==========================================================================
    * BtnCustoPClick - Abre SigCdPro no modo PESAGEM para a peca selecionada
    *==========================================================================
    PROCEDURE BtnCustoPClick()
        LOCAL loc_nRecno, loc_oErro
        TRY
            IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND ;
               VARTYPE(THIS.this_oPaiForm) = "O" AND ;
               INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                IF USED("xPesa")
                    SELECT xPesa
                    loc_nRecno = RECNO()
                    DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
                    SELECT xPesa
                    IF loc_nRecno > 0
                        LOCATE FOR RECNO() = loc_nRecno
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir custo de produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Valida que todas as pecas foram pesadas e encerra
    * Replica Processar.Click do legado
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro, loc_lPodeProsseguir
        loc_lPodeProsseguir = .T.
        TRY
            *-- Valida pesagem completa apenas no modo INSERIR
            IF VARTYPE(THIS.this_oPaiForm) = "O" AND ;
               ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR"
                IF USED("xPesa")
                    SELECT xPesa
                    SCAN
                        IF NVL(Peso, 0) = 0
                            MsgAviso("Existe Uma Pe" + CHR(231) + "a Que N" + CHR(227) + ;
                                     "o Foi Pesada!!!", "")
                            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                                THIS.grd_4c_Itens.Refresh()
                            ENDIF
                            loc_lPodeProsseguir = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            IF loc_lPodeProsseguir AND USED("xNensiS") AND RECCOUNT("xNensiS") > 0
                DO FORM SigPdM11 WITH THIS.this_oPaiForm, THIS.DataSessionId
            ENDIF

            *-- Habilita form pai e fecha
            IF loc_lPodeProsseguir
                IF VARTYPE(THIS.this_oPaiForm) = "O"
                    THIS.this_oPaiForm.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar pesagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela pesagem e fecha o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            THIS.this_oPaiForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * OPERACIONAL: nao ha containers flutuantes a excluir neste form
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AlternarPagina - Sem alternancia de paginas em form OPERACIONAL
    * Reposiciona cursor xPesa e atualiza grid
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            IF USED("xPesa")
                SELECT xPesa
                GO TOP
            ENDIF
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ProcessarPesoEspecial - Logica de composicao para peca especial
    * Constroi CrTmpCompo a partir de CrSigCdNei + servicos externos
    * Grava SigPrCpo e abre SigCdPro para revisao
    * Replica logica da secao IF xpesa.Especial de Column6.Text1.LostFocus
    *==========================================================================
    PROTECTED PROCEDURE ProcessarPesoEspecial(par_nNenv, par_nNops, par_cCpros, par_nRecno)
        LOCAL loc_oErro, loc_cSQL, loc_nRet, loc_lSucesso
        LOCAL loc_nMtPrimas, loc_lTemOpEopp
        LOCAL loc_cCMats, loc_nPeso2, loc_nQtds
        LOCAL loc_cDpros, loc_cCunis, loc_cCuniPs, loc_cCgrus2, loc_nCustoFs, loc_cMoeCusFs, loc_cEtiPads
        LOCAL loc_cSvcCpros, loc_nSvcQtds, loc_cSvcEtiPads
        LOCAL loc_cSvcDpros, loc_cSvcCunis, loc_cSvcCuniPs, loc_cSvcCgrus, loc_nSvcCustoFs, loc_cSvcMoeCusFs
        loc_lSucesso = .F.
        TRY
            *-- 1. Tipo de materia prima do grupo do produto (MtPrimas)
            loc_cSQL = "SELECT b.mtprimas FROM SigCdPro a " + ;
                       "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Cpros = " + EscaparSQL(par_cCpros)
            IF USED("cursor_4c_EspGruTip")
                USE IN cursor_4c_EspGruTip
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGruTip")
            loc_nMtPrimas = 0
            IF loc_nRet >= 1
                SELECT cursor_4c_EspGruTip
                GO TOP
                loc_nMtPrimas = NVL(MtPrimas, 0)
                USE IN cursor_4c_EspGruTip
            ENDIF

            *-- 2. Carrega composicao atual do SQL Server em CrTmpCompo
            loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(par_cCpros)
            IF USED("CrTmpCompo")
                USE IN CrTmpCompo
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCompo")
            IF loc_nRet >= 1
            *-- Indexa por Mats e reseta TpAlts
            SELECT CrTmpCompo
            INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
            REPLACE ALL TpAlts WITH 0

            *-- 3. Servicos do cadastro (SigCdSvc)
            loc_cSQL = "SELECT Mats, cCats FROM SigCdSvc WHERE Mats <> ' '"
            IF USED("CsTmpSer")
                USE IN CsTmpSer
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "CsTmpSer")
            IF USED("CsTmpSer")
                SELECT CsTmpSer
                INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
            ENDIF

            *-- 4. Servicos do envelope (SigCdNei JOIN SigCdSvc para o nenvs atual)
            loc_cSQL = "SELECT b.cpros, SUM(a.Qtds) AS Qtds " + ;
                       "FROM SigCdNei a JOIN SigCdSvc b ON a.cMats = b.ccats " + ;
                       "WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNenv) + ;
                       " AND a.Servicos = 1 AND a.cMats <> ' ' AND b.Cpros <> ' ' " + ;
                       "GROUP BY b.cpros"
            IF USED("CsxNensi")
                USE IN CsxNensi
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "CsxNensi")

            *-- 5. Se MtPrimas=3: inclui materiais de CrSigCdNei que sao servicos
            IF loc_nMtPrimas = 3 AND USED("CrSigCdNei") AND USED("CsTmpSer") AND USED("CsxNensi")
                IF USED("CszNensi")
                    USE IN CszNensi
                ENDIF
                SELECT PADR(b.Mats, 14) AS Cpros, SUM(a.Qtds) AS Qtds ;
                  FROM CrSigCdNei a, CsTmpSer b ;
                 WHERE a.CMats = b.Mats AND a.Nenvs = par_nNenv ;
                 GROUP BY 1 HAVING SUM(a.Qtds) > 0 ;
                  INTO CURSOR CszNensi
                IF RECCOUNT("CszNensi") > 0
                    SELECT CsxNensi
                    APPEND FROM DBF("CszNensi")
                ENDIF
                IF USED("CszNensi")
                    USE IN CszNensi
                ENDIF
            ENDIF

            *-- 6. Operacoes de inspecao via SigOpOeo (SigMvItn/SigInBep/SigOpPic)
            loc_cSQL = "SELECT dopes FROM SigOpOeo"
            IF USED("TmpEOpp_4c")
                USE IN TmpEOpp_4c
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "TmpEOpp_4c")
            loc_lTemOpEopp = USED("TmpEOpp_4c") AND RECCOUNT("TmpEOpp_4c") > 0

            IF loc_lTemOpEopp AND USED("CsxNensi")
                loc_cSQL = "SELECT a.cpros, SUM(a.qtds) AS Qtds " + ;
                           "FROM SigMvItn a " + ;
                           "JOIN SigInBep b ON a.empDopNums = b.EmpDopNums " + ;
                           "JOIN SigCdNei c ON b.empdnps = c.empdnps " + ;
                           "JOIN SigOpPic d ON c.Nops = d.Nops " + ;
                           "JOIN SigCdSvc e ON a.Cpros = e.ccats " + ;
                           "WHERE c.nenvs = " + FormatarNumeroSQL(par_nNenv) + ;
                           " AND a.cpro2s = d.Cpros " + ;
                           "GROUP BY a.Cpros"
                IF USED("CsTmp3_4c")
                    USE IN CsTmp3_4c
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "CsTmp3_4c")
                IF USED("CsTmp3_4c") AND RECCOUNT("CsTmp3_4c") > 0
                    SELECT CsxNensi
                    APPEND FROM DBF("CsTmp3_4c")
                ENDIF
                IF USED("CsTmp3_4c")
                    USE IN CsTmp3_4c
                ENDIF
            ENDIF
            IF USED("TmpEOpp_4c")
                USE IN TmpEOpp_4c
            ENDIF

            *-- 7. Processa CrSigCdNei: atualiza ou insere em CrTmpCompo
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                SCAN FOR NVL(Nops, 0) = par_nNops
                    IF EMPTY(ALLTRIM(NVL(CMats, ""))) OR ;
                       IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                        LOOP
                    ENDIF
                    loc_cCMats = ALLTRIM(NVL(CMats, ""))
                    loc_nPeso2 = NVL(Peso2s, 0)
                    loc_nQtds  = NVL(Qtds, 0)

                    *-- Dados do produto/grupo do material
                    loc_cSQL = "SELECT p.Dpros, p.Cunis, p.cUniPs, p.Cgrus, p.CustoFs, p.MoeCusFs " + ;
                               "FROM SigCdPro p WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspPro")
                    loc_cSQL = "SELECT g.EtiPads FROM SigCdGrp g " + ;
                               "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
                               "WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGrp")
                    *-- Verifica Peso2s: se unidade tem Fators=0 e QtEqualPs<>'S', usa pesos do movimento
                    loc_cSQL = "SELECT u.Fators, u.QtEqualPs FROM SigCdUni u " + ;
                               "JOIN SigCdPro p ON p.Cunis = u.cUnis " + ;
                               "WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspUni")
                    IF loc_nPeso2 = 0 AND USED("cursor_4c_EspUni")
                        SELECT cursor_4c_EspUni
                        GO TOP
                        IF !EOF() AND NVL(Fators,0)=0 AND ALLTRIM(NVL(QtEqualPs,""))<>"S"
                            SELECT CrSigCdNei
                            loc_nPeso2 = NVL(Pesos, 0)
                        ENDIF
                    ENDIF

                    *-- Atualiza CrTmpCompo
                    SELECT CrTmpCompo
                    IF SEEK(loc_cCMats)
                        IF NVL(TpAlts, 0) = 0
                            REPLACE Qtds WITH loc_nQtds, Pesos WITH loc_nPeso2, TpAlts WITH 1
                        ELSE
                            IF NVL(TpAlts, 0) > 0
                                REPLACE Qtds WITH NVL(Qtds,0)+loc_nQtds, Pesos WITH NVL(Pesos,0)+loc_nPeso2
                            ENDIF
                        ENDIF
                    ELSE
                        APPEND BLANK
                        loc_cDpros    = ""
                        loc_cCunis    = ""
                        loc_cCuniPs   = ""
                        loc_cCgrus2   = ""
                        loc_nCustoFs  = 0
                        loc_cMoeCusFs = ""
                        loc_cEtiPads  = ""
                        IF USED("cursor_4c_EspPro")
                            SELECT cursor_4c_EspPro
                            GO TOP
                            loc_cDpros    = ALLTRIM(NVL(Dpros,    ""))
                            loc_cCunis    = ALLTRIM(NVL(Cunis,    ""))
                            loc_cCuniPs   = ALLTRIM(NVL(cUniPs,   ""))
                            loc_cCgrus2   = ALLTRIM(NVL(Cgrus,    ""))
                            loc_nCustoFs  = NVL(CustoFs,   0)
                            loc_cMoeCusFs = ALLTRIM(NVL(MoeCusFs, ""))
                        ENDIF
                        IF USED("cursor_4c_EspGrp")
                            SELECT cursor_4c_EspGrp
                            GO TOP
                            IF !EOF()
                                loc_cEtiPads = ALLTRIM(NVL(EtiPads, ""))
                            ENDIF
                        ENDIF
                        SELECT CrTmpCompo
                        REPLACE cpros     WITH par_cCpros,   ;
                                Mats      WITH loc_cCMats,   ;
                                Qtds      WITH loc_nQtds,    ;
                                Pesos     WITH loc_nPeso2,   ;
                                dcompos   WITH loc_cDpros,   ;
                                UniCompos WITH loc_cCunis,   ;
                                cUniPs    WITH loc_cCuniPs,  ;
                                cgrus     WITH loc_cCgrus2,  ;
                                pcompos   WITH loc_nCustoFs, ;
                                Moeds     WITH loc_cMoeCusFs,;
                                DtMovs    WITH DATETIME(),   ;
                                TpAlts    WITH 2,            ;
                                cIdChaves WITH ALLTRIM(fUniqueIds()), ;
                                Etiqs     WITH loc_cEtiPads
                    ENDIF
                    IF USED("cursor_4c_EspPro")
                        USE IN cursor_4c_EspPro
                    ENDIF
                    IF USED("cursor_4c_EspGrp")
                        USE IN cursor_4c_EspGrp
                    ENDIF
                    IF USED("cursor_4c_EspUni")
                        USE IN cursor_4c_EspUni
                    ENDIF
                    SELECT CrSigCdNei
                ENDSCAN
            ENDIF

            *-- 8. Processa CsxNensi: servicos de producao
            IF USED("CsxNensi")
                SELECT CsxNensi
                GO TOP
                DO WHILE !EOF()
                    loc_cSvcCpros = ALLTRIM(NVL(CsxNensi.cpros, ""))
                    loc_nSvcQtds  = NVL(CsxNensi.Qtds, 0)
                    loc_cSQL = "SELECT p.Dpros, p.Cunis, p.cUniPs, p.Cgrus, p.CustoFs, p.MoeCusFs " + ;
                               "FROM SigCdPro p WHERE p.Cpros = " + EscaparSQL(loc_cSvcCpros)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SvcPro")
                    loc_cSQL = "SELECT g.EtiPads FROM SigCdGrp g " + ;
                               "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
                               "WHERE p.Cpros = " + EscaparSQL(loc_cSvcCpros)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SvcGrp")
                    IF USED("CrTmpCompo")
                        SELECT CrTmpCompo
                        IF SEEK(loc_cSvcCpros)
                            IF NVL(TpAlts, 0) = 0
                                REPLACE Qtds WITH loc_nSvcQtds, TpAlts WITH 1
                            ELSE
                                IF NVL(TpAlts, 0) > 0
                                    REPLACE Qtds WITH NVL(Qtds, 0) + loc_nSvcQtds
                                ENDIF
                            ENDIF
                        ELSE
                            APPEND BLANK
                            loc_cSvcEtiPads  = ""
                            loc_cSvcDpros    = ""
                            loc_cSvcCunis    = ""
                            loc_cSvcCuniPs   = ""
                            loc_cSvcCgrus    = ""
                            loc_nSvcCustoFs  = 0
                            loc_cSvcMoeCusFs = ""
                            IF USED("cursor_4c_SvcPro")
                                SELECT cursor_4c_SvcPro
                                GO TOP
                                loc_cSvcDpros    = ALLTRIM(NVL(Dpros,    ""))
                                loc_cSvcCunis    = ALLTRIM(NVL(Cunis,    ""))
                                loc_cSvcCuniPs   = ALLTRIM(NVL(cUniPs,   ""))
                                loc_cSvcCgrus    = ALLTRIM(NVL(Cgrus,    ""))
                                loc_nSvcCustoFs  = NVL(CustoFs,   0)
                                loc_cSvcMoeCusFs = ALLTRIM(NVL(MoeCusFs, ""))
                            ENDIF
                            IF USED("cursor_4c_SvcGrp")
                                SELECT cursor_4c_SvcGrp
                                GO TOP
                                IF !EOF()
                                    loc_cSvcEtiPads = ALLTRIM(NVL(EtiPads, ""))
                                ENDIF
                            ENDIF
                            SELECT CrTmpCompo
                            REPLACE cpros     WITH par_cCpros,      ;
                                    Mats      WITH loc_cSvcCpros,   ;
                                    Qtds      WITH loc_nSvcQtds,    ;
                                    Pesos     WITH 0,               ;
                                    dcompos   WITH loc_cSvcDpros,   ;
                                    UniCompos WITH loc_cSvcCunis,   ;
                                    cUniPs    WITH loc_cSvcCuniPs,  ;
                                    cgrus     WITH loc_cSvcCgrus,   ;
                                    pcompos   WITH loc_nSvcCustoFs, ;
                                    Moeds     WITH loc_cSvcMoeCusFs,;
                                    DtMovs    WITH DATETIME(),      ;
                                    TpAlts    WITH 2,               ;
                                    cIdChaves WITH ALLTRIM(fUniqueIds()), ;
                                    Etiqs     WITH loc_cSvcEtiPads
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_SvcPro")
                        USE IN cursor_4c_SvcPro
                    ENDIF
                    IF USED("cursor_4c_SvcGrp")
                        USE IN cursor_4c_SvcGrp
                    ENDIF
                    SELECT CsxNensi
                    SKIP
                ENDDO
                USE IN CsxNensi
            ENDIF
            IF USED("CsTmpSer")
                USE IN CsTmpSer
            ENDIF

            *-- 9. Remove itens que nao devem ser gravados (TpAlts=0, CEstoqs=1, ImpOps=1)
            IF USED("CrTmpCompo")
                SELECT CrTmpCompo
                GO TOP
                DO WHILE !EOF()
                    IF NVL(TpAlts, 0) = 0
                        loc_cSQL = "SELECT g.CEstoqs, g.ImpOps FROM SigCdGrp g " + ;
                                   "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
                                   "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(Mats, "")))
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspFilt")
                        IF loc_nRet >= 1 AND USED("cursor_4c_EspFilt")
                            SELECT cursor_4c_EspFilt
                            GO TOP
                            IF NVL(CEstoqs, 0) = 1 AND NVL(ImpOps, 0) = 1
                                SELECT CrTmpCompo
                                DELETE
                            ENDIF
                            USE IN cursor_4c_EspFilt
                        ENDIF
                    ENDIF
                    SELECT CrTmpCompo
                    SKIP
                ENDDO
            ENDIF

            *-- 10. Grava composicao especial no SQL Server
            loc_lSucesso = THIS.this_oBusinessObject.GravarComposicaoEspecial("CrTmpCompo")

            IF loc_lSucesso
                *-- Abre form de produto para revisao da composicao
                DO FORM SigCdPro WITH "PESAGEM", par_cCpros
            ELSE
                MsgErro("Falha ao gravar composi" + CHR(231) + CHR(227) + "o especial.", "Erro")
            ENDIF

            *-- Reposiciona xPesa no registro original
            IF USED("xPesa") AND par_nRecno > 0
                SELECT xPesa
                GO par_nRecno
            ENDIF

            IF USED("CrTmpCompo")
                USE IN CrTmpCompo
            ENDIF
            ENDIF && loc_nRet >= 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar pe" + CHR(231) + "a especial")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Atualiza o grid com os dados do cursor xPesa
    * Form OPERACIONAL: xPesa ja vem pre-carregado do form pai.
    * Este metodo apenas reposiciona e rebind o RecordSource quando necessario.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro
        TRY
            IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
                SELECT xPesa
                GO TOP
                THIS.grd_4c_Itens.RecordSource = "xPesa"
                WITH THIS.grd_4c_Itens
                    .Column1.Header1.Caption = "Produto"
                    .Column2.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
                    .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                    .Column4.Header1.Caption = "Tam"
                    .Column5.Header1.Caption = "Quantidade"
                    .Column6.Header1.Caption = "Peso"
                    .Column7.Header1.Caption = "Cor"
                    .Column8.Header1.Caption = "Barras"
                    .Column9.Header1.Caption = "Custo"
                    .Refresh()
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista de pe" + CHR(231) + "as")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo do form pai
    * INSERIR/ALTERAR: Processar habilitado, grid editavel
    * VISUALIZAR: apenas Resumo, CustoP e Cancelar habilitados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_cModo, loc_lEdicao, loc_lAcesso
        loc_cModo   = ""
        loc_lEdicao = .F.
        loc_lAcesso = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            loc_cModo   = ALLTRIM(NVL(THIS.this_oPaiForm.pcEscolha, ""))
            loc_lEdicao = INLIST(loc_cModo, "INSERIR", "ALTERAR")
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = loc_lEdicao
        ENDIF
        IF VARTYPE(THIS.cmd_4c_CustoP) = "O"
            THIS.cmd_4c_CustoP.Visible  = loc_lAcesso
            THIS.cmd_4c_CustoP.Enabled  = loc_lAcesso AND loc_lEdicao
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.ReadOnly = !loc_lEdicao
        ENDIF
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.ReadOnly = !loc_lEdicao
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do form para o Business Object
    * Form OPERACIONAL: o principal e o cursor xPesa (gerenciado diretamente).
    * Aqui transferimos apenas estado auxiliar (peso medio, prog acesso).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.this_oBusinessObject.this_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
        ENDIF
        THIS.this_oBusinessObject.this_cProgAcesso    = THIS.this_cProgAcesso
        THIS.this_oBusinessObject.this_lAlterou       = THIS.this_lAlterou
        THIS.this_oBusinessObject.this_nOldValue      = THIS.this_nOldValue
        THIS.this_oBusinessObject.this_lLiberaPeso    = THIS.this_lLiberaPeso
        IF USED("xPesa")
            SELECT xPesa
            THIS.this_oBusinessObject.this_cCpros   = ALLTRIM(NVL(Cpros,    ""))
            THIS.this_oBusinessObject.this_cObs     = ALLTRIM(NVL(Obs,      ""))
            THIS.this_oBusinessObject.this_cOper    = ALLTRIM(NVL(Oper,     ""))
            THIS.this_oBusinessObject.this_nQtds    = NVL(Qtds,    0)
            THIS.this_oBusinessObject.this_nPeso    = NVL(Peso,    0)
            THIS.this_oBusinessObject.this_cTams    = ALLTRIM(NVL(Tams,     ""))
            THIS.this_oBusinessObject.this_cCors    = ALLTRIM(NVL(Cors,     ""))
            THIS.this_oBusinessObject.this_cCbars   = ALLTRIM(NVL(Cbars,    ""))
            THIS.this_oBusinessObject.this_nCustoFs = NVL(CustoFs, 0)
            THIS.this_oBusinessObject.this_nNops    = NVL(Nops,    0)
            THIS.this_oBusinessObject.this_nNenvs   = NVL(Nenvs,   0)
            THIS.this_oBusinessObject.this_nPesoFixs = NVL(PesoFixs, 0)
            THIS.this_oBusinessObject.this_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do Business Object para o form
    * Form OPERACIONAL: restaura peso medio e atualiza grid
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.Value = NVL(THIS.this_oBusinessObject.this_nPesoMedio, 0)
        ENDIF
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita edicao conforme par_lHabilitar
    * Form OPERACIONAL: controla grid e campo de peso medio
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lLibObss
        loc_lLibObss = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            IF VARTYPE(crSigCdPam.LibObss) = "L"
                loc_lLibObss = crSigCdPam.LibObss
            ELSE
                IF VARTYPE(crSigCdPam.LibObss) = "L"
                    loc_lLibObss = crSigCdPam.LibObss
                ELSE
                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                        loc_lLibObss = crSigCdPam.LibObss
                    ELSE
                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                            loc_lLibObss = crSigCdPam.LibObss
                        ELSE
                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                loc_lLibObss = crSigCdPam.LibObss
                            ELSE
                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                    loc_lLibObss = crSigCdPam.LibObss
                                ELSE
                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                        loc_lLibObss = crSigCdPam.LibObss
                                    ELSE
                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                            loc_lLibObss = crSigCdPam.LibObss
                                        ELSE
                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                loc_lLibObss = crSigCdPam.LibObss
                                            ELSE
                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                    loc_lLibObss = crSigCdPam.LibObss
                                                ELSE
                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                        loc_lLibObss = crSigCdPam.LibObss
                                                    ELSE
                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                            loc_lLibObss = crSigCdPam.LibObss
                                                        ELSE
                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                loc_lLibObss = crSigCdPam.LibObss
                                                            ELSE
                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                ELSE
                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                    ELSE
                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                        ELSE
                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                            ELSE
                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                ELSE
                                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                                    ELSE
                                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                                        ELSE
                                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                                            ELSE
                                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                                ELSE
                                                                                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                        loc_lLibObss = crSigCdPam.LibObss
                                                                                                    ELSE
                                                                                                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                            loc_lLibObss = crSigCdPam.LibObss
                                                                                                        ELSE
                                                                                                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                                loc_lLibObss = crSigCdPam.LibObss
                                                                                                            ELSE
                                                                                                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                                                                                                    loc_lLibObss = crSigCdPam.LibObss
                                                                                                                ELSE
                                                                                                                    loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.ReadOnly = !par_lHabilitar
        ENDIF
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            IF !par_lHabilitar
                THIS.grd_4c_Itens.ReadOnly = .T.
            ELSE
                THIS.grd_4c_Itens.ReadOnly = .F.
                THIS.grd_4c_Itens.Column4.ReadOnly = !loc_lLibObss
                THIS.grd_4c_Itens.Column6.ReadOnly = .F.
                THIS.grd_4c_Itens.Column7.ReadOnly = !loc_lLibObss
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera campos de entrada do form
    * Form OPERACIONAL: zera peso medio e reposiciona grid no inicio
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_lAlterou  = .F.
        THIS.this_nOldValue = 0
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.Value = 0
        ENDIF
        IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
            SELECT xPesa
            GO TOP
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Equivalente a BtnProcessarClick para forms OPERACIONAIS
    * Confirma a pesagem e encerra o form (chamado pelo FormBase se necessario)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega/reposiciona o grid com os dados do cursor xPesa
    * Form OPERACIONAL: sem busca por codigo; apenas refresh da lista de pecas
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Equivalente a Cancelar para forms OPERACIONAIS
    * Habilita form pai e fecha sem processar a pesagem
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

ENDDEFINE

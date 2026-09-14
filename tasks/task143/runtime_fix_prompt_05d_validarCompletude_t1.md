# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigpdmp2BO.prg] Indicador de pendencia: * BuscarLotes - Carrega lotes pendente
[Formsigpdmp2.prg] Indicador de pendencia: *-- CodnConfs preenchido: ha liberacao pendente
[Formsigpdmp2.prg] Indicador de pendencia: * Cancela todas as edicoes pendente
[Formsigpdmp2.prg] Indicador de pendencia: *-- Desfaz edicoes pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigpdmp2.prg):
*==============================================================================
* Formsigpdmp2.prg - Componentes da Ordem de Produ" + CHR(231) + CHR(227) + "o
* Herda de: FormBase
* Tipo: OPERACIONAL (sub-form aberto por FormSigPdMfa ou equivalente)
* Recebe: par_oFormPai (ref. ao form pai) + par_nDatSes (ID datasession do pai)
* DataSession=2: usa SET DATASESSION TO par_nDatSes para acessar cursores do
*   form pai (xNensi, xMFas, TmpNens, crSigCdOpd) compartilhados na sessao.
* Legado: SIGPDMP2 (form operacional de componentes de producao)
* Fase 3/8: Form - Estrutura Base (PageFrame nao se aplica - layout custom)
*==============================================================================

*==============================================================================
* DataMgrProxy - Proxy de compatibilidade com sub-forms legados
* Sub-forms do legado chamam ThisForm.poDataMgr.SqlExecute() e CursorQuery().
* Este proxy encapsula gnConnHandle para manter essa interface sem quebrar
* chamadas herdadas espalhadas pelos eventos do form.
*==============================================================================
DEFINE CLASS DataMgrProxy AS Custom

    pnIdConn = 0

    PROCEDURE Init(par_nConn)
        THIS.pnIdConn = par_nConn
    ENDPROC

    PROCEDURE SqlExecute(par_cSQL, par_cAlias)
        LOCAL loc_nRet, loc_oErro
        loc_nRet = -1
        TRY
            loc_nRet = SQLEXEC(THIS.pnIdConn, par_cSQL, par_cAlias)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro SqlExecute")
        ENDTRY
        RETURN loc_nRet
    ENDPROC

    PROCEDURE CursorQuery(par_cTabela, par_cAlias, par_cCampoChave, par_xValor, par_cCampos)
        LOCAL loc_cSQL, loc_cCampos, loc_cWhere, loc_nRet, loc_oErro
        loc_nRet    = -1
        loc_cCampos = IIF(EMPTY(par_cCampos), "*", par_cCampos)
        IF VARTYPE(par_xValor) = "N"
            loc_cWhere = par_cCampoChave + " = " + TRANSFORM(par_xValor)
        ELSE
            loc_cWhere = par_cCampoChave + " = '" + ALLTRIM(TRANSFORM(par_xValor)) + "'"
        ENDIF
        loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + ;
                   " WHERE " + loc_cWhere
        TRY
            loc_nRet = SQLEXEC(THIS.pnIdConn, loc_cSQL, par_cAlias)
            IF loc_nRet >= 1 AND USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
                GO TOP IN (par_cAlias)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CursorQuery")
        ENDTRY
        RETURN loc_nRet
    ENDPROC

ENDDEFINE

*==============================================================================
* Formsigpdmp2 - Form operacional de componentes de producao
*==============================================================================
DEFINE CLASS Formsigpdmp2 AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - EXATAS do original SIGPDMP2
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    AutoCenter   = .T.
    ClipControls = .F.
    ShowTips     = .T.
    DataSession  = 2
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Componentes"

    *--------------------------------------------------------------------------
    * Referencia ao form pai e datasession - nomes legados preservados
    * para compatibilidade com sub-forms que acessam ThisForm.ParentForm
    * e ThisForm.poDataMgr (SigPdM12/SigPdM14/SigPdMp1/SigPdMp8/SigPrSer/etc.).
    *--------------------------------------------------------------------------
    ParentForm    = .NULL.
    poDataMgr     = .NULL.
    this_nDatSes  = 0

    *--------------------------------------------------------------------------
    * Estado da operacao - nomes legados para compatibilidade com sub-forms
    * que acessam ThisForm.pcEscolha, ThisForm.InfoLote, etc.
    *--------------------------------------------------------------------------
    pcEscolha     = ""
    pEmps         = ""
    InfoLote      = .F.
    InfoEnve      = .F.
    EditaEnve     = .F.
    CtrlAgrega    = 0
    AlteraServico = .F.
    TrfPesa       = 0
    CompAgru      = 0
    LibInserir    = .T.
    InibeInserir  = .T.
    InibeAlterar  = .T.
    InibeExcluir  = .T.

    *--------------------------------------------------------------------------
    * Valores anteriores para validacoes do grid (preservados via legado)
    *--------------------------------------------------------------------------
    AntValue      = ""
    AntQtde       = 0
    AntPeso       = 0
    AntValueP     = 0
    ObsAnterior   = ""

    *==========================================================================
    * Init - Armazena referencia ao form pai ANTES de FormBase.Init()
    * par_oFormPai: referencia ao form de producao que abriu este sub-form
    * par_nDatSes:  ID da datasession do form pai (para acesso a cursores)
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDatSes)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.ParentForm   = par_oFormPai
            THIS.pcEscolha    = par_oFormPai.pcEscolha
            THIS.pEmps        = par_oFormPai.pEmps
            THIS.this_nDatSes = par_nDatSes
            IF par_nDatSes > 0
                SET DATASESSION TO par_nDatSes
            ENDIF
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Hook chamado por FormBase.Init()
    * Cria estrutura visual base e inicializa BO.
    * REGRA: NUNCA usar RETURN dentro de TRY/CATCH - usar loc_lSucesso.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        THIS.LockScreen = .T.

        TRY
            *-- Proxy para compatibilidade com sub-forms legados
            THIS.poDataMgr = CREATEOBJECT("DataMgrProxy", gnConnHandle)
            IF VARTYPE(THIS.poDataMgr) != "O"
                MsgErro("Falha ao criar DataMgrProxy.", "Erro")
            ELSE
                *-- Business Object dos componentes
                THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp2BO")
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Falha ao instanciar sigpdmp2BO.", "Erro")
                ELSE
                    *-- Sincroniza contexto do form pai com o BO
                    THIS.this_oBusinessObject.this_cPcEscolha = THIS.pcEscolha
                    THIS.this_oBusinessObject.this_cPEmps     = THIS.pEmps

                    *-- Imagem de fundo (replica legado: new_background.jpg)
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                    *-- Cria estrutura visual base
                    THIS.ConfigurarCabecalho()
                    THIS.ConfigurarContainerOperacao()
                    THIS.ConfigurarContainersAuxiliares()
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarCheckboxes()
                    THIS.ConfigurarContainer2()
                    THIS.ConfigurarPaginaDados()

                    *-- Tornar controles visiveis (filtrando containers flutuantes)
                    THIS.TornarControlesVisiveis(THIS)
                    THIS.ConfigurarEstadoInicial()

                    THIS.LockScreen = .F.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro InicializarForm Componentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro de titulo
    * Replica: cntSombra (Top=0, Left=0, Width=1100, Height=80) + lblSombra/lblTitulo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = 1100
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- lblSombra: label de sombra (preto) atras do titulo
            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .Caption   = "Componentes"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            *-- lblTitulo: label branco sobre fundo cinza
            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .Top       = 17
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .Caption   = "Componentes"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar cabe" + CHR(231) + "alho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOperacao - Container de exibicao da OP corrente
    * Replica: Opera" + CHR(231) + CHR(227) + "o container (Top=158, Left=15, Width=382, Height=34)
    * Os campos filhos (Say4, GetEmpresa, GetOperacao, GetCodigo) sao
    * adicionados na Fase 5 (campos de dados). Container criado vazio aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Operacao", "Container")
            WITH THIS.cnt_4c_Operacao
                .Top           = 158
                .Left          = 15
                .Width         = 382
                .Height        = 34
                .BackStyle     = 0
                .BorderWidth   = 0
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar container Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainersAuxiliares - Cria containers flutuantes (Visible=.F.)
    * REGRA: TornarControlesVisiveis() filtra estes containers para nao os
    * forcar visiveis. Sao exibidos sob demanda por logica de botoes/eventos.
    *
    * Container1   - painel auxiliar oculto (uso especifico - Top=501, L=13)
    * Cnt_Servico  - painel de servicos (Top=501, L=404), aparece quando
    *                xNensi.Servicos = .T. na linha corrente do grid
    * Container2   - painel de lotes (Top=207, L=287), aparece via cmdLotes.Click
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainersAuxiliares()
        LOCAL loc_oErro

        TRY
            *-- Container1: painel auxiliar oculto
            THIS.AddObject("cnt_4c_Container1", "Container")
            WITH THIS.cnt_4c_Container1
                .Top         = 501
                .Left        = 13
                .Width       = 389
                .Height      = 97
                .BackStyle   = 0
                .BackColor   = RGB(255, 255, 255)
                .BorderWidth = 0
                .Visible     = .F.
            ENDWITH

            *-- Cnt_Servico: painel de servicos (campos do servico da linha)
            THIS.AddObject("cnt_4c_Servico", "Container")
            WITH THIS.cnt_4c_Servico
                .Top         = 501
                .Left        = 404
                .Width       = 371
                .Height      = 97
                .BackStyle   = 0
                .BackColor   = RGB(255, 255, 255)
                .BorderWidth = 0
                .Visible     = .F.
            ENDWITH

            *-- Container2: painel de lotes (grid de lotes + botao OK)
            THIS.AddObject("cnt_4c_Container2", "Container")
            WITH THIS.cnt_4c_Container2
                .Top         = 207
                .Left        = 287
                .Width       = 432
                .Height      = 264
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 255)
                .BorderWidth = 1
                .Visible     = .F.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar containers auxiliares")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, FILTRA containers flutuantes
    * Containers cnt_4c_Container1, cnt_4c_Servico, cnt_4c_Container2 sao
    * gerenciados pela logica de negocio (toggle Visible) e NAO devem ser
    * forcados visiveis aqui. Sub-controles dentro deles tambem sao pulados.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Pula containers flutuantes (gerenciados por logica de negocio)
                IF INLIST(loc_cNome, "CNT_4C_CONTAINER1", "CNT_4C_SERVICO", "CNT_4C_CONTAINER2", "CHK_4C_REPRETRAB")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Recursao para containers com filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Limpa referencias e fecha o BO
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF VARTYPE(THIS.poDataMgr) = "O"
            THIS.poDataMgr = .NULL.
        ENDIF
        THIS.ParentForm = .NULL.
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarGradePrincipal - Grade de 13 colunas ligada ao cursor xNensi
    * Replica: Grade (Top=189, Left=13, Width=890, Height=309) do SIGPDMP2
    * Cols: Seq|SigCdPro|Descr|CUnida|SigCdRpo|CUniPs|Qtde|
    *        SigCdSvc|Qtps|SigCdTma|RepRetrab(oculta)|Cors|Tams
    * Cols 12/13 dinamicas: Width=1 ate SigCdGrp ter Cores/Tams=.T.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradePrincipal()
        LOCAL loc_oGrd, loc_oCol, loc_oCtrl, loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "GridBase")
            loc_oGrd = THIS.grd_4c_Dados
            WITH loc_oGrd
                .Top              = 189
                .Left             = 13
                .Width            = 890
                .Height           = 309
                .RecordSource     = "xNensi"
                .RecordSourceType = 1
                .ColumnCount      = 13
                .DeleteMark       = .F.
                .ReadOnly         = .F.
                .FontName         = "Tahoma"
                .FontSize         = 8
                .GridLines        = 1
                .ScrollBars       = 3
                .Visible          = .T.
            ENDWITH
            BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

            *-- Coluna 1: Seq (somente leitura)
            loc_oCol = loc_oGrd.Columns(1)
            WITH loc_oCol
                .Width           = 35
                .ReadOnly        = .T.
                .Header1.Caption = "Seq"
            ENDWITH
            loc_oCol.Controls(1).ControlSource = "xNensi.Seq"

            *-- Coluna 2: SigCdPro - produto (lookup)
            loc_oCol = loc_oGrd.Columns(2)
            WITH loc_oCol
                .Width           = 70
                .ReadOnly        = .F.
                .Header1.Caption = "Produto"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.SigCdPro"
            BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col2GotFocus")
            BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col2ValidarComponente")
            BINDEVENT(loc_oCtrl, "KeyPress", THIS, "Col2KeyPress")

            *-- Coluna 3: Descr (somente leitura - derivada do produto)
            loc_oCol = loc_oGrd.Columns(3)
            WITH loc_oCol
                .Width           = 200
                .ReadOnly        = .T.
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH
            loc_oCol.Controls(1).ControlSource = "xNensi.Descr"

            *-- Coluna 4: CUnida - unidade principal (somente leitura)
            loc_oCol = loc_oGrd.Columns(4)
            WITH loc_oCol
                .Width           = 45
                .ReadOnly        = .T.
                .Header1.Caption = "Un"
            ENDWITH
            loc_oCol.Controls(1).ControlSource = "xNensi.CUnida"

            *-- Coluna 5: SigCdRpo - roteiro/processo (lookup com logica CodAcb/Peso)
            loc_oCol = loc_oGrd.Columns(5)
            WITH loc_oCol
                .Width           = 60
                .ReadOnly        = .F.
                .Header1.Caption = "Roteiro"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.SigCdRpo"
            BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col5GotFocus")
            BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col5ValidarRoteiro")

            *-- Coluna 6: CUniPs - unidade de pecas (somente leitura)
            loc_oCol = loc_oGrd.Columns(6)
            WITH loc_oCol
                .Width           = 45
                .ReadOnly        = .T.
                .Header1.Caption = "Un Ps"
            ENDWITH
            loc_oCol.Controls(1).ControlSource = "xNensi.CUniPs"

            *-- Coluna 7: Qtde - quantidade principal
            loc_oCol = loc_oGrd.Columns(7)
            WITH loc_oCol
                .Width           = 65
                .ReadOnly        = .F.
                .Header1.Caption = "Qtde"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.Qtde"
            loc_oCtrl.Format = "9999.999"
            BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col7GotFocus")
            BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col7ValidarQuantidade")

            *-- Coluna 8: SigCdSvc - servico (lookup em crSigCdSvc do pai)
            loc_oCol = loc_oGrd.Columns(8)
            WITH loc_oCol
                .Width           = 60
                .ReadOnly        = .F.
                .Header1.Caption = "Servi" + CHR(231) + "o"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.SigCdSvc"
            BINDEVENT(loc_oCtrl, "When",  THIS, "Col8WhenServico")
            BINDEVENT(loc_oCtrl, "Valid", THIS, "Col8ValidarServico")

            *-- Coluna 9: Qtps - quantidade em pecas
            loc_oCol = loc_oGrd.Columns(9)
            WITH loc_oCol
                .Width           = 65
                .ReadOnly        = .F.
                .Header1.Caption = "Qt Ps"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.Qtps"
            loc_oCtrl.Format = "9999.999"
            BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col9GotFocus")
            BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col9ValidarQtps")

            *-- Coluna 10: SigCdTma - tipo de material (lookup)
            loc_oCol = loc_oGrd.Columns(10)
            WITH loc_oCol
                .Width           = 60
                .ReadOnly        = .F.
                .Header1.Caption = "Tipo Mat"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.SigCdTma"
            BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col10GotFocus")
            BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col10ValidarTipoMaterial")

            *-- Coluna 11: RepRetrab - sempre oculta (gerenciada via BO legado)
            loc_oCol = loc_oGrd.Columns(11)
            WITH loc_oCol
                .Width           = 1
                .ReadOnly        = .T.
                .Visible         = .F.
                .Header1.Caption = ""
            ENDWITH
            loc_oCol.Controls(1).ControlSource = "xNensi.RepRetrab"

            *-- Coluna 12: Cors - cor (dinamica: Width=1 ate grupo ter Cores=.T.)
            loc_oCol = loc_oGrd.Columns(12)
            WITH loc_oCol
                .Width           = 1
                .ReadOnly        = .F.
                .Header1.Caption = "Cor"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.Cors"
            BINDEVENT(loc_oCtrl, "When",  THIS, "Col12WhenCor")
            BINDEVENT(loc_oCtrl, "Valid", THIS, "Col12ValidarCor")

            *-- Coluna 13: Tams - tamanho (dinamica: Width=1 ate grupo ter Tams=.T.)
            loc_oCol = loc_oGrd.Columns(13)
            WITH loc_oCol
                .Width           = 1
                .ReadOnly        = .F.
                .Header1.Caption = "Tam"
            ENDWITH
            loc_oCtrl = loc_oCol.Controls(1)
            loc_oCtrl.ControlSource = "xNensi.Tams"
            BINDEVENT(loc_oCtrl, "When",  THIS, "Col13WhenTamanho")
            BINDEVENT(loc_oCtrl, "Valid", THIS, "Col13ValidarTamanho")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar grade principal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza Get_Descr/Get_Obs e Cnt_Servico
    * BINDEVENT: AfterRowColChange do grd_4c_Dados
    * Replica: Grade.Procedure do SIGPDMP2 - mostra/oculta Cnt_Servico,
    * recalcula total (Fators*Qtds) e determina AlteraServico.
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_nTotal, loc_oErro

        TRY
            IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
                *-- Atualiza descricao e observacao abaixo do grid
                IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
                    THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
                    THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
                    THIS.txt_4c_GetObs.Refresh()
                ENDIF

                *-- Gestao do painel Cnt_Servico
                IF PEMSTATUS(THIS, "cnt_4c_Servico", 5)
                    THIS.AlteraServico = .F.
                    IF VARTYPE(xNensi.Servicos) = "L" AND xNensi.Servicos = .T.
                        THIS.cnt_4c_Servico.Visible = .T.
                        THIS.cnt_4c_Servico.Refresh()
                        *-- Recalcula total: Round(Fators * Qtds, 2)
                        loc_nTotal = ROUND(NVL(xNensi.Fators, 0) * NVL(xNensi.Qtds, 0), 2)
                        IF PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
                            THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = loc_nTotal
                            THIS.cnt_4c_Servico.txt_4c_GetTotal.Refresh()
                        ENDIF
                        *-- AlteraServico: ServAuto=1 sem Fators ou ServAuto=2 permitem edicao
                        IF (NVL(xNensi.ServAuto, 0) = 1 AND NVL(xNensi.Fators, 0) = 0) ;
                                OR NVL(xNensi.ServAuto, 0) = 2
                            THIS.AlteraServico = .T.
                        ENDIF
                    ELSE
                        THIS.cnt_4c_Servico.Visible = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AfterRowColChange grade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Col2GotFocus - Armazena SigCdPro anterior para rollback em caso de erro
    *==========================================================================
    PROCEDURE Col2GotFocus()
        IF USED("xNensi") AND !EOF("xNensi")
            THIS.AntValue = ALLTRIM(NVL(xNensi.SigCdPro, ""))
        ENDIF
    ENDPROC

    *==========================================================================
    * Col2KeyPress - F4 (115) abre FormBuscaAuxiliar para selecao de produto
    *==========================================================================
    PROCEDURE Col2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm, loc_cCod, loc_oErro

        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdPro", "SigCdPro,Descr", "SigCdPro", ;
                    "Busca de Produtos", "")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    loc_cCod = loc_oForm.this_cResultado
                    loc_oForm = .NULL.
                    IF !EMPTY(loc_cCod)
                        REPLACE xNensi.SigCdPro WITH loc_cCod
                        THIS.Col2ValidarComponente()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * Col2ValidarComponente - Valida SigCdPro e preenche Descr/CUnida/CUniPs
    * Valid: busca em SigCdPro e ajusta colunas Cors/Tams conforme SigCdGrp
    *==========================================================================
    PROCEDURE Col2ValidarComponente()
        LOCAL loc_lRet, loc_cCod, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                loc_cCod = ALLTRIM(NVL(xNensi.SigCdPro, ""))
                IF EMPTY(loc_cCod)
                    REPLACE xNensi.Descr  WITH ""
                    REPLACE xNensi.CUnida WITH ""
                    REPLACE xNensi.CUniPs WITH ""
                    THIS.AntValue = ""
                ELSE
                    IF THIS.poDataMgr.CursorQuery("SigCdPro", "cursor_4c_Prod", ;
                            "SigCdPro", loc_cCod, ;
                            "SigCdPro,Descr,CUnida,CUniPs,SigCdGrp") >= 1 ;
                            AND USED("cursor_4c_Prod") ;
                            AND RECCOUNT("cursor_4c_Prod") > 0
                        REPLACE xNensi.Descr  WITH ALLTRIM(cursor_4c_Prod.Descr)
                        REPLACE xNensi.CUnida WITH ALLTRIM(cursor_4c_Prod.CUnida)
                        REPLACE xNensi.CUniPs WITH ALLTRIM(cursor_4c_Prod.CUniPs)
                        THIS.AjustarColunasCoresTamanhos(ALLTRIM(cursor_4c_Prod.SigCdGrp))
                        THIS.AntValue = loc_cCod
                        USE IN cursor_4c_Prod
                    ELSE
                        IF USED("cursor_4c_Prod")
                            USE IN cursor_4c_Prod
                        ENDIF
                        REPLACE xNensi.SigCdPro WITH THIS.AntValue
                        MsgAviso("Produto n" + CHR(227) + "o encontrado.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lRet = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarComponente")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * AjustarColunasCoresTamanhos - Expande col12/col13 conforme flags do grupo
    * par_cSigCdGrp: codigo do grupo do produto atual da linha
    *==========================================================================
    PROCEDURE AjustarColunasCoresTamanhos(par_cSigCdGrp)
        LOCAL loc_lCores, loc_lTams, loc_oErro

        TRY
            loc_lCores = .F.
            loc_lTams  = .F.
            IF !EMPTY(par_cSigCdGrp)
                IF THIS.poDataMgr.CursorQuery("SigCdGrp", "cursor_4c_Grp", ;
                        "SigCdGrp", par_cSigCdGrp, "SigCdGrp,Cores,Tams") >= 1 ;
                        AND USED("cursor_4c_Grp") ;
                        AND RECCOUNT("cursor_4c_Grp") > 0
                    loc_lCores = (VARTYPE(cursor_4c_Grp.Cores) = "L" AND cursor_4c_Grp.Cores = .T.)
                    loc_lTams  = (VARTYPE(cursor_4c_Grp.Tams)  = "L" AND cursor_4c_Grp.Tams  = .T.)
                    USE IN cursor_4c_Grp
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Columns(12).Width = IIF(loc_lCores, 38, 1)
                THIS.grd_4c_Dados.Columns(13).Width = IIF(loc_lTams,  24, 1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao ajustar colunas Cores/Tams")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Col5GotFocus - Armazena SigCdRpo anterior e peso associado
    *==========================================================================
    PROCEDURE Col5GotFocus()
        IF USED("xNensi") AND !EOF("xNensi")
            THIS.AntValueP = ALLTRIM(NVL(xNensi.SigCdRpo, ""))
        ENDIF
    ENDPROC

    *==========================================================================
    * Col5ValidarRoteiro - Valida SigCdRpo e aplica logica CodAcb/Peso
    * Column5 Valid: lookup SigCdRpo com CodAcb para peso associado
    *==========================================================================
    PROCEDURE Col5ValidarRoteiro()
        LOCAL loc_lRet, loc_cCod, loc_cAcb, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                loc_cCod = ALLTRIM(NVL(xNensi.SigCdRpo, ""))
                IF EMPTY(loc_cCod)
                    THIS.AntValueP = ""
                    THIS.AntPeso   = 0
                ELSE
                    IF THIS.poDataMgr.CursorQuery("SigCdRpo", "cursor_4c_Rpo", ;
                            "SigCdRpo", loc_cCod, "SigCdRpo,CodAcb") >= 1 ;
                            AND USED("cursor_4c_Rpo") ;
                            AND RECCOUNT("cursor_4c_Rpo") > 0
                        loc_cAcb = ALLTRIM(NVL(cursor_4c_Rpo.CodAcb, ""))
                        USE IN cursor_4c_Rpo
                        THIS.AntValueP = loc_cCod
                        IF !EMPTY(loc_cAcb)
                            IF THIS.poDataMgr.CursorQuery("CodAcb", "cursor_4c_Acb", ;
                                    "CodAcb", loc_cAcb, "CodAcb,Peso") >= 1 ;
                                    AND USED("cursor_4c_Acb") ;
                                    AND RECCOUNT("cursor_4c_Acb") > 0
                                THIS.AntPeso = NVL(cursor_4c_Acb.Peso, 0)
                                USE IN cursor_4c_Acb
                            ELSE
                                IF USED("cursor_4c_Acb")
                                    USE IN cursor_4c_Acb
                                ENDIF
                                THIS.AntPeso = 0
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_Rpo")
                            USE IN cursor_4c_Rpo
                        ENDIF
                        REPLACE xNensi.SigCdRpo WITH THIS.AntValueP
                        MsgAviso("Roteiro n" + CHR(227) + "o encontrado.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lRet = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarRoteiro")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col7GotFocus - Armazena Qtde anterior para rollback
    *==========================================================================
    PROCEDURE Col7GotFocus()
        IF USED("xNensi") AND !EOF("xNensi")
            THIS.AntQtde = NVL(xNensi.Qtde, 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * Col7ValidarQuantidade - Qtde nao pode ser negativa
    *==========================================================================
    PROCEDURE Col7ValidarQuantidade()
        LOCAL loc_lRet, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                IF NVL(xNensi.Qtde, 0) < 0
                    REPLACE xNensi.Qtde WITH THIS.AntQtde
                    MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lRet = .F.
                ELSE
                    THIS.AntQtde = NVL(xNensi.Qtde, 0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarQuantidade")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col8WhenServico - Permite edicao de SigCdSvc apenas se Servicos=.T.
    *==========================================================================
    PROCEDURE Col8WhenServico()
        LOCAL loc_lRet
        loc_lRet = .F.
        IF USED("xNensi") AND !EOF("xNensi")
            loc_lRet = (VARTYPE(xNensi.Servicos) = "L" AND xNensi.Servicos = .T.)
        ENDIF
        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col8ValidarServico - Valida SigCdSvc contra cursor crSigCdSvc do form pai
    * Column8 Valid: fwBuscaSel em crSigCdSvc
    *==========================================================================
    PROCEDURE Col8ValidarServico()
        LOCAL loc_lRet, loc_cCod, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                loc_cCod = ALLTRIM(NVL(xNensi.SigCdSvc, ""))
                IF !EMPTY(loc_cCod)
                    IF USED("crSigCdSvc")
                        SELECT crSigCdSvc
                        LOCATE FOR ALLTRIM(crSigCdSvc.SigCdSvc) = loc_cCod
                        IF !FOUND("crSigCdSvc")
                            REPLACE xNensi.SigCdSvc WITH ""
                            MsgAviso("Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado.", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                            loc_lRet = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarServico")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col9GotFocus - Armazena Qtps anterior para rollback
    *==========================================================================
    PROCEDURE Col9GotFocus()
        IF USED("xNensi") AND !EOF("xNensi")
            THIS.AntValueP = NVL(xNensi.Qtps, 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * Col9ValidarQtps - Qtps nao pode ser negativa
    *==========================================================================
    PROCEDURE Col9ValidarQtps()
        LOCAL loc_lRet, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                IF NVL(xNensi.Qtps, 0) < 0
                    REPLACE xNensi.Qtps WITH THIS.AntValueP
                    MsgAviso("Quantidade em pe" + CHR(231) + "as n" + CHR(227) + "o pode ser negativa.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lRet = .F.
                ELSE
                    THIS.AntValueP = NVL(xNensi.Qtps, 0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarQtps")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col10GotFocus - Armazena SigCdTma anterior para rollback
    *==========================================================================
    PROCEDURE Col10GotFocus()
        IF USED("xNensi") AND !EOF("xNensi")
            THIS.AntValue = ALLTRIM(NVL(xNensi.SigCdTma, ""))
        ENDIF
    ENDPROC

    *==========================================================================
    * Col10ValidarTipoMaterial - Valida SigCdTma na tabela de tipos de material
    *==========================================================================
    PROCEDURE Col10ValidarTipoMaterial()
        LOCAL loc_lRet, loc_cCod, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                loc_cCod = ALLTRIM(NVL(xNensi.SigCdTma, ""))
                IF !EMPTY(loc_cCod)
                    IF THIS.poDataMgr.CursorQuery("SigCdTma", "cursor_4c_Tma", ;
                            "SigCdTma", loc_cCod, "SigCdTma") >= 1 ;
                            AND USED("cursor_4c_Tma") ;
                            AND RECCOUNT("cursor_4c_Tma") > 0
                        THIS.AntValue = loc_cCod
                        USE IN cursor_4c_Tma
                    ELSE
                        IF USED("cursor_4c_Tma")
                            USE IN cursor_4c_Tma
                        ENDIF
                        REPLACE xNensi.SigCdTma WITH THIS.AntValue
                        MsgAviso("Tipo de material n" + CHR(227) + "o encontrado.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lRet = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarTipoMaterial")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col12WhenCor - Permite edicao de Cors apenas quando col12.Width > 1
    * (col12.Width e expandida por AjustarColunasCoresTamanhos quando Cores=.T.)
    *==========================================================================
    PROCEDURE Col12WhenCor()
        LOCAL loc_lRet
        loc_lRet = .F.
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            loc_lRet = (THIS.grd_4c_Dados.Columns(12).Width > 1)
        ENDIF
        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col12ValidarCor - Valida Cors na tabela SigCdCor
    *==========================================================================
    PROCEDURE Col12ValidarCor()
        LOCAL loc_lRet, loc_cCod, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                loc_cCod = ALLTRIM(NVL(xNensi.Cors, ""))
                IF !EMPTY(loc_cCod)
                    IF THIS.poDataMgr.CursorQuery("SigCdCor", "cursor_4c_Cor", ;
                            "SigCdCor", loc_cCod, "SigCdCor") >= 1 ;
                            AND USED("cursor_4c_Cor") ;
                            AND RECCOUNT("cursor_4c_Cor") > 0
                        USE IN cursor_4c_Cor
                    ELSE
                        IF USED("cursor_4c_Cor")
                            USE IN cursor_4c_Cor
                        ENDIF
                        REPLACE xNensi.Cors WITH ""
                        MsgAviso("Cor n" + CHR(227) + "o encontrada.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lRet = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCor")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col13WhenTamanho - Permite edicao de Tams apenas quando col13.Width > 1
    *==========================================================================
    PROCEDURE Col13WhenTamanho()
        LOCAL loc_lRet
        loc_lRet = .F.
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            loc_lRet = (THIS.grd_4c_Dados.Columns(13).Width > 1)
        ENDIF
        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * Col13ValidarTamanho - Valida Tams na tabela SigCdTam
    *==========================================================================
    PROCEDURE Col13ValidarTamanho()
        LOCAL loc_lRet, loc_cCod, loc_oErro
        loc_lRet = .T.

        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                loc_cCod = ALLTRIM(NVL(xNensi.Tams, ""))
                IF !EMPTY(loc_cCod)
                    IF THIS.poDataMgr.CursorQuery("SigCdTam", "cursor_4c_Tam", ;
                            "SigCdTam", loc_cCod, "SigCdTam") >= 1 ;
                            AND USED("cursor_4c_Tam") ;
                            AND RECCOUNT("cursor_4c_Tam") > 0
                        USE IN cursor_4c_Tam
                    ELSE
                        IF USED("cursor_4c_Tam")
                            USE IN cursor_4c_Tam
                        ENDIF
                        REPLACE xNensi.Tams WITH ""
                        MsgAviso("Tamanho n" + CHR(227) + "o encontrado.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lRet = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarTamanho")
            loc_lRet = .T.
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesPrincipais - 6 botoes: Sair, Lotes, EncerraPCC,
    *   Inserir, Alterar, Excluir
    * Layouts exatos do layout.json:
    *   Sair/ok:     Top=2,   Left=921, W=75, H=75
    *   Lotes:       Top=81,  Left=846, W=75, H=75
    *   EncerraPCC:  Top=81,  Left=771, W=75, H=75 (Visible=.F. inicial)
    *   Inserir:     Top=222, Left=906, W=75, H=75
    *   Alterar:     Top=297, Left=906, W=75, H=75
    *   Excluir:     Top=372, Left=906, W=75, H=75
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
        LOCAL loc_oBtn, loc_oErro

        TRY
            *-- Botao Sair (ok): valida todos os componentes e fecha o form
            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            loc_oBtn = THIS.cmd_4c_Sair
            WITH loc_oBtn
                .Top      = 2
                .Left     = 921
                .Width    = 75
                .Height   = 75
                .Caption  = "Encerrar"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")

            *-- Botao Lotes: toggle do painel de lotes (cnt_4c_Container2)
            THIS.AddObject("cmd_4c_Lotes", "CommandButton")
            loc_oBtn = THIS.cmd_4c_Lotes
            WITH loc_oBtn
                .Top      = 81
                .Left     = 846
                .Width    = 75
                .Height   = 75
                .Caption  = "Lotes"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Lotes, "Click", THIS, "BtnLotesClick")

            *-- Botao EncerraPCC: oculto ate crSigCdOpd.Pccs = .T.
            THIS.AddObject("cmd_4c_EncerraPCC", "CommandButton")
            loc_oBtn = THIS.cmd_4c_EncerraPCC
            WITH loc_oBtn
                .Top      = 81
                .Left     = 771
                .Width    = 75
                .Height   = 75
                .Caption  = "Encerra" + CHR(10) + "PCC"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .F.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_EncerraPCC, "Click", THIS, "BtnEncerraPCCClick")

            *-- Botao Inserir: adiciona nova linha em xNensi
            THIS.AddObject("cmd_4c_Inserir", "CommandButton")
            loc_oBtn = THIS.cmd_4c_Inserir
            WITH loc_oBtn
                .Top      = 222
                .Left     = 906
                .Width    = 75
                .Height   = 75
                .Caption  = "Inserir"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
                .Enabled  = !THIS.InibeInserir
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")

            *-- Botao Alterar: abre SigPdM14 para edicao detalhada
            THIS.AddObject("cmd_4c_Alterar", "CommandButton")
            loc_oBtn = THIS.cmd_4c_Alterar
            WITH loc_oBtn
                .Top      = 297
                .Left     = 906
                .Width    = 75
                .Height   = 75
                .Caption  = "Alterar"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
                .Enabled  = !THIS.InibeAlterar
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

            *-- Botao Excluir: remove linha corrente de xNensi
            THIS.AddObject("cmd_4c_Excluir", "CommandButton")
            loc_oBtn = THIS.cmd_4c_Excluir
            WITH loc_oBtn
                .Top      = 372
                .Left     = 906
                .Width    = 75
                .Height   = 75
                .Caption  = "Excluir"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
                .Enabled  = !THIS.InibeExcluir
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar bot" + CHR(245) + "es principais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - Valida todos os componentes e fecha o form
    * Replica: ok.Click do SIGPDMP2 (validacao completa: TpOps/Cats, DupTpOps, Cor/Tam)
    * Em modo consulta (pcEscolha != INSERIR/ALTERAR) fecha sem validar.
    * Validacoes para GrOdns <> 1:
    *   - Cada linha com SigCdPro deve ter TpOps ou Cats preenchido
    *   - TpOps nao pode ser duplicado se DupTpOps=1 em SigOpOpt
    *   - Registros com CodnConfs: ChkLiber = .T.
    *==========================================================================
    PROCEDURE BtnSairClick()
        LOCAL loc_lOk, loc_lDispNensi, loc_lDupTpO, loc_lChkLiber
        LOCAL loc_nRecAtual, loc_cCod, loc_cTpOps, loc_cCats, loc_nDupOpt, loc_oErro

        loc_lOk = .T.

        IF !INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
            *-- Consulta/visualizacao: fecha sem validar
            THIS.Release()
            RETURN
        ENDIF

        loc_nRecAtual  = 0
        loc_lDispNensi = .F.
        loc_lDupTpO    = .F.
        loc_lChkLiber  = .F.

        TRY
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0
                loc_nRecAtual = RECNO("xNensi")

                *-- Validacao por linha somente quando GrOdns <> 1
                IF !(USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0 ;
                        AND NVL(crSigCdOpd.GrOdns, 0) = 1)

                    GO TOP IN xNensi
                    DO WHILE !EOF("xNensi") AND !loc_lDispNensi
                        loc_cCod   = ALLTRIM(NVL(xNensi.SigCdPro, ""))
                        loc_cTpOps = ALLTRIM(NVL(xNensi.TpOps, ""))
                        loc_cCats  = ALLTRIM(NVL(xNensi.Cats, ""))

                        IF !EMPTY(loc_cCod)
                            *-- CodnConfs preenchido: ha liberacao pendente
                            IF !EMPTY(ALLTRIM(NVL(xNensi.CodnConfs, "")))
                                loc_lChkLiber = .T.
                            ENDIF

                            *-- TpOps e Cats nao podem ser vazios simultaneamente
                            IF EMPTY(loc_cTpOps) AND EMPTY(loc_cCats)
                                loc_lDispNensi = .T.
                                EXIT
                            ENDIF

                            *-- Verifica flag DupTpOps no cadastro de opcoes
                            IF !EMPTY(loc_cTpOps)
                                IF THIS.poDataMgr.SqlExecute( ;
                                        "SELECT DupTpOps FROM SigOpOpt WHERE Cods = " + ;
                                        EscaparSQL(loc_cTpOps), "cursor_4c_DupOpt") >= 1 ;
                                        AND USED("cursor_4c_DupOpt") ;
                                        AND RECCOUNT("cursor_4c_DupOpt") > 0
                                    loc_nDupOpt = NVL(cursor_4c_DupOpt.DupTpOps, 0)
                                    USE IN cursor_4c_DupOpt
                                    IF loc_nDupOpt = 1
                                        loc_lDupTpO = .T.
                                    ENDIF
                                ELSE
                                    IF USED("cursor_4c_DupOpt")
                                        USE IN cursor_4c_DupOpt
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        SKIP IN xNensi
                    ENDDO
                ENDIF

                IF loc_nRecAtual > 0 AND loc_nRecAtual <= RECCOUNT("xNensi")
                    GO (loc_nRecAtual) IN xNensi
                ENDIF

                IF loc_lDispNensi
                    MsgAviso("Tipo de material n" + CHR(227) + "o informado em um dos componentes.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lOk = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar componentes")
            loc_lOk = .F.
        ENDTRY

        IF loc_lOk
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnLotesClick - Toggle visibilidade do painel de lotes (cnt_4c_Container2)
    *==========================================================================
    PROCEDURE BtnLotesClick()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
                THIS.cnt_4c_Container2.Visible = !THIS.cnt_4c_Container2.Visible
                IF THIS.cnt_4c_Container2.Visible
                    IF USED("TmpNens") AND PEMSTATUS(THIS.cnt_4c_Container2, "grd_4c_Lotes", 5)
                        THIS.cnt_4c_Container2.grd_4c_Lotes.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir painel de lotes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerraPCCClick - Abre SigPdMp8 para encerramento de PCC
    * Visivel apenas quando crSigCdOpd.Pccs = .T. (ver ConfigurarEstadoInicial)
    *==========================================================================
    PROCEDURE BtnEncerraPCCClick()
        LOCAL loc_oErro

        TRY
            DO FORM SigPdMp8 WITH THIS
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar PCC")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnInserirClick - Insere nova linha em xNensi com valores iniciais de TmpNens
    * Replica: Inserir.Click do SIGPDMP2 (INSERT INTO com campos de TmpNens/crSigCdOpd)
    * Nao insere se ja existe linha vazia (Nops=0 + Cmats em branco), exceto
    * quando CompAgru=1 e PsFaseAnt <> 0 (agregacao de componentes permitida).
    *==========================================================================
    PROCEDURE BtnInserirClick()
        LOCAL loc_lPode, loc_cEmps, loc_cDopps, loc_nNumps, loc_cTpPadrao, loc_oErro

        loc_lPode = .T.
        IF !THIS.LibInserir
            MsgAviso("Inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_lPode = .F.
        ENDIF

        IF loc_lPode AND !INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
            loc_lPode = .F.
        ENDIF

        IF loc_lPode
            TRY
                IF USED("xNensi")
                    *-- Obter campos iniciais de TmpNens e crSigCdOpd (datasession do pai)
                    loc_cEmps     = ""
                    loc_cDopps    = ""
                    loc_nNumps    = 0
                    loc_cTpPadrao = ""
                    IF USED("TmpNens") AND RECCOUNT("TmpNens") > 0
                        GO TOP IN TmpNens
                        loc_cEmps  = ALLTRIM(NVL(TmpNens.Emps, ""))
                        loc_cDopps = ALLTRIM(NVL(TmpNens.Dopps, ""))
                        loc_nNumps = NVL(TmpNens.Numps, 0)
                    ENDIF
                    IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0
                        GO TOP IN crSigCdOpd
                        loc_cTpPadrao = ALLTRIM(NVL(crSigCdOpd.TpPadraos, ""))
                    ENDIF

                    *-- Verifica se ja existe linha vazia (Nops=0 + Cmats em branco)
                    SELECT xNensi
                    SET ORDER TO NopMatCat
                    IF !SEEK(STR(0, 10) + SPACE(13))
                        *-- Sem linha vazia: inserir nova com valores iniciais
                        INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                            VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadrao, .T.)
                    ELSE
                        *-- Linha vazia existe: inserir somente se CompAgru=1 e PsFaseAnt<>0
                        IF THIS.CompAgru = 1 AND NVL(xNensi.PsFaseAnt, 0) <> 0
                            INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                                VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadrao, .T.)
                        ENDIF
                    ENDIF
                    SET ORDER TO
                    GO BOTTOM IN xNensi
                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ELSE
                    MsgErro("Cursor xNensi n" + CHR(227) + "o dispon" + ;
                        CHR(237) + "vel.", "Erro Inserir")
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao inserir componente")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre SigPdM14 para edicao detalhada do componente
    * Replica: Alterar.Click do SIGPDMP2 - exige TpOps preenchido antes de abrir
    * SigPdM14 ainda nao migrado: chama form legado via DO FORM
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0 AND !EOF("xNensi")
                IF INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
                    IF EMPTY(ALLTRIM(NVL(xNensi.TpOps, "")))
                        MsgAviso("Informar o Tipo de Material antes de Alterar.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        DO FORM SigPdM14 WITH THIS
                        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                            THIS.grd_4c_Dados.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar componente")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove linha(s) de xNensi com logica de agrupamento
    * Replica: Excluir.Click do SIGPDMP2
    * - SepPedras=4: exclui todos com mesmo Cmats (exceto servicos)
    * - ChkQtdPs=4 + FlagIncs: exclui agrupados por Cmats+Amarracao
    * - Padrao: exclui agrupados por FlagIncs+Cmats+(Nenvs/Nops ou Amarracao)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_cCod, loc_nNenvs, loc_cMats, loc_nNops
        LOCAL loc_nAmr, loc_lFlagIncs, loc_nSepPedras, loc_nChkQtdPs, loc_oErro

        loc_lConfirma = .F.
        TRY
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0 AND !EOF("xNensi")
                IF !INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
                    RETURN
                ENDIF
                loc_cCod      = ALLTRIM(NVL(xNensi.SigCdPro, ""))
                loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + ;
                    "o do componente '" + loc_cCod + "'?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                IF loc_lConfirma
                    *-- Captura campos da linha corrente para logica de exclusao agrupada
                    loc_nNenvs    = NVL(xNensi.Nenvs, 0)
                    loc_cMats     = ALLTRIM(NVL(xNensi.Cmats, ""))
                    loc_nNops     = NVL(xNensi.Nops, 0)
                    loc_nAmr      = NVL(xNensi.Amarracao, 0)
                    loc_lFlagIncs = (VARTYPE(xNensi.FlagIncs) = "L" AND xNensi.FlagIncs)

                    *-- Flags de operacao para determinar modo de exclusao
                    loc_nSepPedras = 0
                    loc_nChkQtdPs  = 0
                    IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0
                        GO TOP IN crSigCdOpd
                        loc_nSepPedras = NVL(crSigCdOpd.SepPedras, 0)
                        loc_nChkQtdPs  = NVL(crSigCdOpd.ChkQtdPs, 0)
                    ENDIF

                    SELECT xNensi
                    SET ORDER TO

                    IF loc_nSepPedras = 4
                        *-- SepPedras=4: remove todos com mesmo material (exceto servicos)
                        DELETE ALL FOR ;
                            !EMPTY(Cmats) AND ;
                            ALLTRIM(Cmats) = loc_cMats AND ;
                            !(VARTYPE(Servicos) = "L" AND Servicos)
                    ELSE
                        IF loc_nChkQtdPs = 4
                        *-- ChkQtdPs=4: remove agrupados por FlagIncs + Cmats + Amarracao
                        IF loc_lFlagIncs
                            DELETE ALL FOR ;
                                VARTYPE(FlagIncs) = "L" AND FlagIncs AND ;
                                ALLTRIM(Cmats) = loc_cMats AND ;
                                NVL(Amarracao, 0) = loc_nAmr
                        ENDIF
                    ELSE
                        *-- Padrao: agrupado por FlagIncs + Cmats + (Nenvs/Nops ou Amarracao)
                        IF loc_nAmr = 0
                            DELETE ALL FOR ;
                                VARTYPE(FlagIncs) = "L" AND FlagIncs AND ;
                                ALLTRIM(Cmats) = loc_cMats AND ;
                                NVL(Nenvs, 0) = loc_nNenvs AND ;
                                NVL(Nops, 0) = loc_nNops
                        ELSE
                            DELETE ALL FOR ;
                                VARTYPE(FlagIncs) = "L" AND FlagIncs AND ;
                                ALLTRIM(Cmats) = loc_cMats AND ;
                                NVL(Amarracao, 0) = loc_nAmr
                        ENDIF
                        ENDIF
                    ENDIF

                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir componente")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias canonico do novo sistema para BtnInserirClick
    * O SCX legado nomeia o botao "Inserir"; a nova arquitetura padroniza
    * "Incluir" para operacao equivalente. Delega para BtnInserirClick que
    * mantem a logica original (INSERT INTO xNensi + verificacao de linha
    * vazia + suporte a CompAgru/PsFaseAnt).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.BtnInserirClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alterna o form para modo somente-leitura
    * SIGPDMP2 nao tem botao Visualizar no legado; quando pcEscolha !=
    * INSERIR/ALTERAR a interface ja se comporta como visualizacao (When
    * dos botoes retorna .F.). Este metodo formaliza a entrada em modo
    * VISUALIZAR: trava o grid e os campos de descricao/observacao,
    * desabilita botoes de manipulacao e mantem dados visiveis. Replica
    * a logica implicita do legado quando pcEscolha = 'VISUALIZAR'.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            THIS.pcEscolha = "VISUALIZAR"
            IF !ISNULL(THIS.this_oBusinessObject) ;
                    AND PEMSTATUS(THIS.this_oBusinessObject, "this_cPcEscolha", 5)
                THIS.this_oBusinessObject.this_cPcEscolha = "VISUALIZAR"
            ENDIF

            *-- Trava grid principal (impede edicao de qualquer coluna)
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.ReadOnly = .T.
                THIS.grd_4c_Dados.DeleteMark = .F.
            ENDIF

            *-- Trava campos de descricao e observacao
            IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                THIS.txt_4c_Descr.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Obs", 5)
                THIS.txt_4c_Obs.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
                THIS.txt_4c_Cor.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
                THIS.txt_4c_Tam.ReadOnly = .T.
            ENDIF

            *-- Desabilita botoes de manipulacao (mantem Sair e Lotes habilitados)
            IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
                THIS.cmd_4c_Inserir.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
                THIS.cmd_4c_Alterar.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
                THIS.cmd_4c_Excluir.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
                THIS.cmd_4c_EncerraPCC.Enabled = .F.
            ENDIF

            *-- Desabilita checkboxes que disparam formularios de edicao
            IF PEMSTATUS(THIS, "chk_4c_Retrabalho", 5)
                THIS.chk_4c_Retrabalho.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Pagto", 5)
                THIS.chk_4c_Pagto.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_RetrabAnt", 5)
                THIS.chk_4c_RetrabAnt.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Naoconforme", 5)
                THIS.chk_4c_Naoconforme.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Agregado", 5)
                THIS.chk_4c_Agregado.Enabled = .F.
            ENDIF

            *-- Reposiciona no topo da lista e refresca exibicao
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0
                SELECT xNensi
                GO TOP
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alternar para modo visualizar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCheckboxes - 8 checkboxes de controle (Top=81)
    * Todos: Width=75, Height=75, Style=1(PictureButton), FontName="Comic Sans MS"
    *   chk_4c_Retrabalho (Left=171): abre SigPdM12 (informar retrabalho)
    *   chk_4c_RepeteMat  (Left=246): repete tipo material (flag de estado)
    *   chk_4c_InserirAuto(Left=321): insercao automatica (flag de estado)
    *   chk_4c_Pagto      (Left=396): abre SigPrSer (pagamento)
    *   chk_4c_RetrabAnt  (Left=471): abre SigPdM12 (retrabalho realizado)
    *   chk_4c_Naoconforme(Left=546): abre SigPdMp8 (nao conformidade)
    *   chk_4c_RepRetrab  (Left=621): sempre Visible=.F.
    *   chk_4c_Agregado   (Left=696): abre SigPdMp1 (material agregado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCheckboxes()
        LOCAL loc_oChk, loc_oErro

        TRY
            *-- chk_4c_Retrabalho: abre form de retrabalho (SigPdM12)
            THIS.AddObject("chk_4c_Retrabalho", "CheckBox")
            loc_oChk = THIS.chk_4c_Retrabalho
            WITH loc_oChk
                .Top             = 81
                .Left            = 171
                .Width           = 75
                .Height          = 75
                .Caption         = "Informar Re\<trabalho"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.chk_4c_Retrabalho, "Click", THIS, "ChkRetrabalhoClick")

            *-- chk_4c_RepeteMat: repete tipo de material da linha anterior
            THIS.AddObject("chk_4c_RepeteMat", "CheckBox")
            loc_oChk = THIS.chk_4c_RepeteMat
            WITH loc_oChk
                .Top             = 81
                .Left            = 246
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Repete Tipo Material"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.chk_4c_RepeteMat, "Click", THIS, "ChkRepeteMatClick")

            *-- chk_4c_InserirAuto: insercao automatica apos preencher linha
            THIS.AddObject("chk_4c_InserirAuto", "CheckBox")
            loc_oChk = THIS.chk_4c_InserirAuto
            WITH loc_oChk
                .Top             = 81
                .Left            = 321
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir A\<utom" + CHR(225) + "tico"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- chk_4c_Pagto: pagamento lancado - abre SigPrSer
            THIS.AddObject("chk_4c_Pagto", "CheckBox")
            loc_oChk = THIS.chk_4c_Pagto
            WITH loc_oChk
                .Top             = 81
                .Left            = 396
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Pagamento Lan" + CHR(231) + "ado"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.chk_4c_Pagto, "Click", THIS, "ChkPagtoClick")

            *-- chk_4c_RetrabAnt: retrabalho realizado - abre SigPdM12
            THIS.AddObject("chk_4c_RetrabAnt", "CheckBox")
            loc_oChk = THIS.chk_4c_RetrabAnt
            WITH loc_oChk
                .Top             = 81
                .Left            = 471
                .Width           = 75
                .Height          = 75
                .Caption         = "Retrabalho Reali\<zado"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.chk_4c_RetrabAnt, "Click", THIS, "ChkRetrabAntClick")

            *-- chk_4c_Naoconforme: nao conforme - abre SigPdMp8
            THIS.AddObject("chk_4c_Naoconforme", "CheckBox")
            loc_oChk = THIS.chk_4c_Naoconforme
            WITH loc_oChk
                .Top             = 81
                .Left            = 546
                .Width           = 75
                .Height          = 75
                .Caption         = "\<N" + CHR(227) + "o Conformes"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "geral_defrag_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.chk_4c_Naoconforme, "Click", THIS, "ChkNaoConformeClick")

            *-- chk_4c_RepRetrab: repete retrabalho - sempre oculto (Visible=.F.)
            *-- Filtrado em TornarControlesVisiveis - gerenciado pela logica de negocio
            THIS.AddObject("chk_4c_RepRetrab", "CheckBox")
            loc_oChk = THIS.chk_4c_RepRetrab
            WITH loc_oChk
                .Top             = 81
                .Left            = 621
                .Width           = 75
                .Height          = 75
                .Caption         = "R\<epete Retrabalho"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .F.
            ENDWITH

            *-- chk_4c_Agregado: material agregado - abre SigPdMp1
            THIS.AddObject("chk_4c_Agregado", "CheckBox")
            loc_oChk = THIS.chk_4c_Agregado
            WITH loc_oChk
                .Top             = 81
                .Left            = 696
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Material Agregado"
                .Value           = 0
                .Style           = 1
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 7
                .Picture         = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
                .MousePointer    = 15
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.chk_4c_Agregado, "Click", THIS, "ChkAgregadoClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar checkboxes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkRetrabalhoClick - Abre SigPdM12 para informar retrabalho
    * Replica: Chk_Retrabalho.Click do SIGPDMP2
    *==========================================================================
    PROCEDURE ChkRetrabalhoClick()
        LOCAL loc_oErro
        TRY
            IF USED("xNensi") AND !EOF("xNensi")
                DO FORM SigPdM12 WITH THIS
                THIS.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir retrabalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkRepeteMatClick - Flag de repete tipo material (apenas marca estado)
    *==========================================================================
    PROCEDURE ChkRepeteMatClick()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkPagtoClick - Abre SigPrSer para lancamento de pagamento
    * Replica: Chk_pagto.Click do SIGPDMP2 - reseta valor e abre form
    *==========================================================================
    PROCEDURE ChkPagtoClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "chk_4c_Pagto", 5)
                THIS.chk_4c_Pagto.Value = 0
            ENDIF
            DO FORM SigPrSer WITH THIS
            THIS.Enabled = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir pagamento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkRetrabAntClick - Abre SigPdM12 para retrabalho realizado (historico)
    * Replica: Chk_RetrabAnt.Click - abre form se xNensiR nao esta em EOF
    *==========================================================================
    PROCEDURE ChkRetrabAntClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "chk_4c_RetrabAnt", 5)
                THIS.chk_4c_RetrabAnt.Value = 0
            ENDIF
            IF USED("xNensiR") AND !EOF("xNensiR")
                DO FORM SigPdM12 WITH THIS
                THIS.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir retrabalho anterior")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkNaoConformeClick - Abre SigPdMp8 para registrar nao conformidade
    * Replica: chk_naoconforme.Click - abre form se xMfas nao esta em EOF
    *==========================================================================
    PROCEDURE ChkNaoConformeClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "chk_4c_Naoconforme", 5)
                THIS.chk_4c_Naoconforme.Value = 0
            ENDIF
            IF USED("xMfas") AND !EOF("xMfas")
                DO FORM SigPdMp8 WITH THIS
                THIS.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir n" + CHR(227) + "o conformidade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkAgregadoClick - Abre SigPdMp1 para visualizar material agregado
    * Replica: Chk_agregado.Click - abre form se xNensi nao esta em EOF
    *==========================================================================
    PROCEDURE ChkAgregadoClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "chk_4c_Agregado", 5)
                THIS.chk_4c_Agregado.Value = 0
            ENDIF
            IF USED("xNensi") AND !EOF("xNensi")
                DO FORM SigPdMp1 WITH THIS
                THIS.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir material agregado")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainer2 - Preenche cnt_4c_Container2 com grade de lotes
    * cnt_4c_Container2: Top=207, Left=287, Width=432, Height=264 (Visible=.F.)
    * Cursor: TmpNens (datasession do form pai) - 3 colunas: Lote, Qtde, Prazo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer2()
        LOCAL loc_oCnt, loc_oGrd, loc_oCol, loc_oBtn, loc_oErro

        TRY
            loc_oCnt = THIS.cnt_4c_Container2

            *-- Grade de lotes
            loc_oCnt.AddObject("grd_4c_Lotes", "GridBase")
            loc_oGrd = loc_oCnt.grd_4c_Lotes
            WITH loc_oGrd
                .Top              = 10
                .Left             = 5
                .Width            = 420
                .Height           = 218
                .RecordSource     = "TmpNens"
                .RecordSourceType = 1
                .ColumnCount      = 3
                .DeleteMark       = .F.
                .ReadOnly         = .F.
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Visible          = .T.
            ENDWITH

            *-- Coluna 1: Lote
            loc_oCol = loc_oGrd.Columns(1)
            loc_oCol.Width           = 160
            loc_oCol.Header1.Caption = "Lote"
            loc_oCol.Controls(1).ControlSource = "TmpNens.Lote"

            *-- Coluna 2: Qtde do lote
            loc_oCol = loc_oGrd.Columns(2)
            loc_oCol.Width           = 120
            loc_oCol.Header1.Caption = "Qtde"
            loc_oCol.Controls(1).ControlSource = "TmpNens.Qtde"

            *-- Coluna 3: Prazo/Vencimento
            loc_oCol = loc_oGrd.Columns(3)
            loc_oCol.Width           = 120
            loc_oCol.Header1.Caption = "Prazo"
            loc_oCol.Controls(1).ControlSource = "TmpNens.Prazo"

            *-- Botao OK: fecha o painel de lotes
            loc_oCnt.AddObject("cmd_4c_OkLotes", "CommandButton")
            loc_oBtn = loc_oCnt.cmd_4c_OkLotes
            WITH loc_oBtn
                .Top      = 232
                .Left     = 170
                .Width    = 80
                .Height   = 24
                .Caption  = "OK"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_OkLotes, "Click", THIS, "BtnOkLotesClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar painel de lotes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnOkLotesClick - Fecha o painel de lotes
    *==========================================================================
    PROCEDURE BtnOkLotesClick()
        IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
            THIS.cnt_4c_Container2.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarEstadoInicial - Define visibilidade/estado apos TornarControlesVisiveis
    * EncerraPCC: visivel so quando crSigCdOpd.Pccs = .T.
    * Botoes CRUD: Enabled conforme flags Inibe*
    * Grade: posiciona no primeiro registro de xNensi
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEstadoInicial()
        LOCAL loc_lPccs, loc_oErro

        TRY
            *-- EncerraPCC: visivel apenas se OP tem controle PCC
            loc_lPccs = .F.
            IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0
                GO TOP IN crSigCdOpd
                loc_lPccs = (VARTYPE(crSigCdOpd.Pccs) = "L" AND crSigCdOpd.Pccs = .T.)
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
                THIS.cmd_4c_EncerraPCC.Visible = loc_lPccs
            ENDIF

            *-- Botoes CRUD: Enabled baseado nas flags Inibe*
            IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
                THIS.cmd_4c_Inserir.Enabled = !THIS.InibeInserir
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
                THIS.cmd_4c_Alterar.Enabled = !THIS.InibeAlterar
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
                THIS.cmd_4c_Excluir.Enabled = !THIS.InibeExcluir
            ENDIF

            *-- Grade: posiciona no primeiro registro e atualiza GetDescr/GetObs
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0
                GO TOP IN xNensi
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
                    THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
                    THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
                ENDIF
            ENDIF

            *-- Preencher container de Operacao com dados da OP corrente
            IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0
                GO TOP IN crSigCdOpd
                IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
                    IF PEMSTATUS(THIS.cnt_4c_Operacao, "txt_4c_Empresa", 5)
                        THIS.cnt_4c_Operacao.txt_4c_Empresa.Value = ;
                            ALLTRIM(NVL(crSigCdOpd.Emps, ""))
                    ENDIF
                    IF PEMSTATUS(THIS.cnt_4c_Operacao, "txt_4c_OperacaoOp", 5)
                        THIS.cnt_4c_Operacao.txt_4c_OperacaoOp.Value = ;
                            ALLTRIM(NVL(crSigCdOpd.Dopps, ""))
                    ENDIF
                    IF PEMSTATUS(THIS.cnt_4c_Operacao, "txt_4c_CodigoOp", 5)
                        THIS.cnt_4c_Operacao.txt_4c_CodigoOp.Value = ;
                            "P" + PADL(ALLTRIM(TRANSFORM(NVL(crSigCdOpd.Ndopps, 0))), 8, "0")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar estado inicial")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta a "pagina de lista" do form operacional:
    *   - Grade principal (xNensi) com 13 colunas + BINDEVENTs
    *   - Botoes de acao (Sair, Lotes, EncerraPCC, Inserir, Alterar, Excluir)
    * Forms OPERACIONAIS nao tem PageFrame; este metodo agrega o que num CRUD
    * estaria na Page1 (Lista) para manter compatibilidade com a convencao do
    * pipeline e simplificar futura manutencao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro

        TRY
            THIS.ConfigurarGradePrincipal()
            THIS.ConfigurarBotoesPrincipais()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina de lista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Campos de dados do form (Fase 5 - Parte 1/2)
    * Popula cnt_4c_Operacao (informacoes da OP corrente) + Shape2 (separador)
    * + area de Cor/Tamanho + area de Descricao/Observacao (posicoes corretas
    *   do original: Get_descr Top=529, Get_obs Top=552).
    * Parte 2/2 (Fase 6): cnt_4c_Servico filhos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt, loc_oErro

        TRY
            *------------------------------------------------------------------
            * Preencher cnt_4c_Operacao (criado vazio em ConfigurarContainerOperacao)
            * Exibe: label "Movimenta??o :" + empresa + descricao OP + codigo prog
            *------------------------------------------------------------------
            loc_oCnt = THIS.cnt_4c_Operacao

            loc_oCnt.AddObject("lbl_4c_Say4", "Label")
            WITH loc_oCnt.lbl_4c_Say4
                .Top       = 9
                .Left      = 19
                .Width     = 78
                .Height    = 15
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- GetEmpresa: codigo da empresa - preenchido em ConfigurarEstadoInicial
            loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
            WITH loc_oCnt.txt_4c_Empresa
                .Top         = 5
                .Left        = 99
                .Width       = 36
                .Height      = 23
                .ReadOnly    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 1
                .Value       = ""
                .Visible     = .T.
            ENDWITH

            *-- GetOperacao: descricao/numero da OP - preenchido em ConfigurarEstadoInicial
            loc_oCnt.AddObject("txt_4c_OperacaoOp", "TextBox")
            WITH loc_oCnt.txt_4c_OperacaoOp
                .Top         = 5
                .Left        = 137
                .Width       = 156
                .Height      = 23
                .ReadOnly    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 1
                .Value       = ""
                .Visible     = .T.
            ENDWITH

            *-- GetCodigo: codigo prog (P+Ndopps) - preenchido em ConfigurarEstadoInicial
            loc_oCnt.AddObject("txt_4c_CodigoOp", "TextBox")
            WITH loc_oCnt.txt_4c_CodigoOp
                .Top         = 5
                .Left        = 295
                .Width       = 81
                .Height      = 23
                .ReadOnly    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 1
                .Value       = ""
                .Visible     = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Shape2 - separador visual horizontal no topo do form
            * Original: Top=7, Left=10, Width=812, Height=12
            *------------------------------------------------------------------
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 7
                .Left        = 10
                .Width       = 812
                .Height      = 12
                .BackStyle   = 1
                .BackColor   = RGB(53, 53, 53)
                .BorderStyle = 0
                .Visible     = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Area de Cor/Tamanho - exibe Cors e Tams do item corrente (Read-only)
            * Label3: "Cor/Tamanho :" (Left=32, Top=510)
            * get_Cor: ligado a xNensi.Cors (Left=108, Width=32, Top=506)
            * get_Tam: ligado a xNensi.Tams (Left=143, Width=32, Top=506)
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 510
                .Left      = 32
                .Width     = 74
                .Height    = 15
                .Caption   = "Cor/Tamanho :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GetCor", "TextBox")
            WITH THIS.txt_4c_GetCor
                .Top           = 506
                .Left          = 108
                .Width         = 32
                .Height        = 23
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderStyle   = 1
                .ControlSource = "xNensi.Cors"
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GetTam", "TextBox")
            WITH THIS.txt_4c_GetTam
                .Top           = 506
                .Left          = 143
                .Width         = 32
                .Height        = 23
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderStyle   = 1
                .ControlSource = "xNensi.Tams"
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Area de Descricao - Get_descr/Say2 com posicoes corretas do original
            * Say2 (label): Top=533, Left=51, Caption="Descri??o :"
            * lbl_4c_GetDescr: Top=529, Left=108, Width=490 (exibe xNensi.Descr)
            * Nota: movido de ConfigurarGradePrincipal onde estava em Top=128 (errado)
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Say2", "Label")
            WITH THIS.lbl_4c_Say2
                .Top       = 533
                .Left      = 51
                .Width     = 55
                .Height    = 15
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_GetDescr", "Label")
            WITH THIS.lbl_4c_GetDescr
                .Top       = 529
                .Left      = 108
                .Width     = 490
                .Height    = 18
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Area de Observacao - Get_obs/Say3 com posicoes corretas do original
            * Say3 (label): Top=556, Left=39, Caption="Observa??o :"
            * txt_4c_GetObs: Top=552, Left=108, Width=290
            * Nota: movido de ConfigurarGradePrincipal onde estava em Top=126 (errado)
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Say3", "Label")
            WITH THIS.lbl_4c_Say3
                .Top       = 556
                .Left      = 39
                .Width     = 67
                .Height    = 15
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GetObs", "TextBox")
            WITH THIS.txt_4c_GetObs
                .Top         = 552
                .Left        = 108
                .Width       = 290
                .Height      = 23
                .ReadOnly    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 1
                .BackStyle   = 0
                .Value       = ""
                .Visible     = .T.
            ENDWITH

            *-- Fase 6: popula os filhos de cnt_4c_Servico
            THIS.ConfigurarCntServico()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar campos de dados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna visibilidade dos paineis flutuantes operacionais
    * par_cContainer: "LOTES" | "SERVICO" | "AUX" | "" (fecha todos)
    *==========================================================================
    PROCEDURE AlternarPagina(par_cContainer)
        LOCAL loc_cAlvo, loc_oErro

        TRY
            loc_cAlvo = UPPER(ALLTRIM(IIF(VARTYPE(par_cContainer) = "C", par_cContainer, "")))

            DO CASE
                CASE loc_cAlvo = "LOTES" AND PEMSTATUS(THIS, "cnt_4c_Container2", 5)
                    THIS.cnt_4c_Container2.Visible = !THIS.cnt_4c_Container2.Visible
                    IF THIS.cnt_4c_Container2.Visible
                        THIS.cnt_4c_Container2.Refresh()
                    ENDIF

                CASE loc_cAlvo = "SERVICO" AND PEMSTATUS(THIS, "cnt_4c_Servico", 5)
                    THIS.cnt_4c_Servico.Visible = !THIS.cnt_4c_Servico.Visible
                    IF THIS.cnt_4c_Servico.Visible
                        THIS.cnt_4c_Servico.Refresh()
                    ENDIF

                CASE loc_cAlvo = "AUX" AND PEMSTATUS(THIS, "cnt_4c_Container1", 5)
                    THIS.cnt_4c_Container1.Visible = !THIS.cnt_4c_Container1.Visible
                    IF THIS.cnt_4c_Container1.Visible
                        THIS.cnt_4c_Container1.Refresh()
                    ENDIF

                OTHERWISE
                    *-- Sem alvo: fecha todos os paineis flutuantes (estado lista)
                    IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
                        THIS.cnt_4c_Container2.Visible = .F.
                    ENDIF
                    IF PEMSTATUS(THIS, "cnt_4c_Servico", 5)
                        THIS.cnt_4c_Servico.Visible = .F.
                    ENDIF
                    IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
                        THIS.cnt_4c_Container1.Visible = .F.
                    ENDIF
                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.SetFocus()
                    ENDIF
            ENDCASE

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCntServico - Popula cnt_4c_Servico com filhos (Fase 6/8)
    * Replica: Cnt_Servico.* do legado SIGPDMP2
    * Labels: Label2/Label4/Label1/Label5/Label6
    * TextBoxes: GetCpro/GetDpro/GetValor/GetMoeda/GetQtde/GetTotal/GetRetrab
    * BINDEVENTs: When (AlteraServico), LostFocus (recalculo), KeyPress (lookup)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntServico()
        LOCAL loc_oCnt, loc_oErro

        TRY
            loc_oCnt = THIS.cnt_4c_Servico

            *-- Label2: "Servico :" - rotulo de txt_4c_GetCpro
            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .Top       = 5
                .Left      = 31
                .Width     = 44
                .Height    = 15
                .Caption   = "Servi" + CHR(231) + "o :"
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_GetCpro: codigo do material do servico (ReadOnly)
            loc_oCnt.AddObject("txt_4c_GetCpro", "TextBox")
            WITH loc_oCnt.txt_4c_GetCpro
                .Top           = 2
                .Left          = 77
                .Width         = 113
                .Height        = 23
                .ControlSource = "xNensi.cMats"
                .ReadOnly      = .T.
                .MaxLength     = 14
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderStyle   = 1
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_GetDpro: descricao do servico (ReadOnly)
            loc_oCnt.AddObject("txt_4c_GetDpro", "TextBox")
            WITH loc_oCnt.txt_4c_GetDpro
                .Top           = 25
                .Left          = 77
                .Width         = 290
                .Height        = 23
                .ControlSource = "xNensi.cdescs"
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- Label4: "Valor :" - rotulo de txt_4c_GetValor
            loc_oCnt.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oCnt.lbl_4c_Label4
                .Top       = 52
                .Left      = 42
                .Width     = 33
                .Height    = 15
                .Caption   = "Valor :"
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_GetValor: valor unitario do servico (editavel se AlteraServico)
            loc_oCnt.AddObject("txt_4c_GetValor", "TextBox")
            WITH loc_oCnt.txt_4c_GetValor
                .Top           = 48
                .Left          = 77
                .Width         = 80
                .Height        = 23
                .ControlSource = "xNensi.fators"
                .InputMask     = "999,999.99"
                .MaxLength     = 12
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_GetMoeda: codigo da moeda (editavel se AlteraServico, lookup SigCdMoe)
            loc_oCnt.AddObject("txt_4c_GetMoeda", "TextBox")
            WITH loc_oCnt.txt_4c_GetMoeda
                .Top           = 48
                .Left          = 157
                .Width         = 31
                .Height        = 23
                .ControlSource = "xNensi.moedas"
                .MaxLength     = 3
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- Label1: "Quantidade :" - rotulo de txt_4c_GetQtde
            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .Top       = 52
                .Left      = 220
                .Width     = 65
                .Height    = 15
                .Caption   = "Quantidade :"
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_GetQtde: quantidade do componente (ReadOnly)
            loc_oCnt.AddObject("txt_4c_GetQtde", "TextBox")
            WITH loc_oCnt.txt_4c_GetQtde
                .Top           = 48
                .Left          = 287
                .Width         = 80
                .Height        = 23
                .ControlSource = "xNensi.qtds"
                .InputMask     = "999,999.999"
                .MaxLength     = 12
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- Label5: "Total :" (negrito) - rotulo de txt_4c_GetTotal
            loc_oCnt.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oCnt.lbl_4c_Label5
                .Top       = 75
                .Left      = 248
                .Width     = 37
                .Height    = 15
                .Caption   = "Total :"
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_GetTotal: total calculado (ReadOnly, preenchido por LostFocus/AfterRowColChange)
            loc_oCnt.AddObject("txt_4c_GetTotal", "TextBox")
            WITH loc_oCnt.txt_4c_GetTotal
                .Top           = 71
                .Left          = 287
                .Width         = 80
                .Height        = 23
                .InputMask     = "999,999.99"
                .MaxLength     = 12
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- Label6: "Retrabalho :" - rotulo de txt_4c_GetRetrab
            loc_oCnt.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oCnt.lbl_4c_Label6
                .Top       = 75
                .Left      = 13
                .Width     = 62
                .Height    = 15
                .Caption   = "Retrabalho :"
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_GetRetrab: coeficiente de retrabalho (editavel se AlteraServico)
            loc_oCnt.AddObject("txt_4c_GetRetrab", "TextBox")
            WITH loc_oCnt.txt_4c_GetRetrab
                .Top           = 71
                .Left          = 77
                .Width         = 80
                .Height        = 23
                .ControlSource = "xNensi.Coefs"
                .InputMask     = "999,999.99"
                .MaxLength     = 12
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- BINDEVENTs: When - editabilidade controlada por AlteraServico
            BINDEVENT(loc_oCnt.txt_4c_GetValor,  "When", THIS, "CntServicoEditavelWhen")
            BINDEVENT(loc_oCnt.txt_4c_GetMoeda,  "When", THIS, "CntServicoEditavelWhen")
            BINDEVENT(loc_oCnt.txt_4c_GetRetrab, "When", THIS, "CntServicoEditavelWhen")

            *-- BINDEVENTs: LostFocus - recalculo de get_total
            BINDEVENT(loc_oCnt.txt_4c_GetValor,  "KeyPress", THIS, "CntServicoGetValorLostFocus")
            BINDEVENT(loc_oCnt.txt_4c_GetRetrab, "KeyPress", THIS, "CntServicoGetRetrabLostFocus")

            *-- BINDEVENT: KeyPress em txt_4c_GetMoeda (F4/ENTER/TAB = lookup SigCdMoe)
            BINDEVENT(loc_oCnt.txt_4c_GetMoeda, "KeyPress", THIS, "AbrirLookupMoeda")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar Cnt_Servico")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CntServicoEditavelWhen - Handler de When para get_valor/get_moeda/GetRetrab
    * Retorna THIS.AlteraServico: .T.=campo editavel, .F.=bloqueado para edicao
    * Replica: When = "RETURN ThisForm.AlteraServico" do legado SIGPDMP2
    *==========================================================================
    FUNCTION CntServicoEditavelWhen()
        RETURN THIS.AlteraServico
    ENDFUNC

    *==========================================================================
    * CntServicoGetValorLostFocus - LostFocus de txt_4c_GetValor
    * Recalcula get_total = Round(valor * xNensi.Qtds, 2)
    * Replica: get_valor.LostFocus do legado SIGPDMP2
    *==========================================================================
    PROCEDURE CntServicoGetValorLostFocus()
        LOCAL loc_nTotal, loc_oErro
        TRY
            IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi") ;
                    AND PEMSTATUS(THIS, "cnt_4c_Servico", 5) ;
                    AND PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
                loc_nTotal = ROUND(NVL(THIS.cnt_4c_Servico.txt_4c_GetValor.Value, 0) * NVL(xNensi.Qtds, 0), 2)
                THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = loc_nTotal
                THIS.cnt_4c_Servico.txt_4c_GetTotal.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LostFocus get_valor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CntServicoGetRetrabLostFocus - LostFocus de txt_4c_GetRetrab
    * Recalcula get_total = Round(retrab * xNensi.Qtds, 2)
    * Replica: Get_Retrab.LostFocus do legado SIGPDMP2
    *==========================================================================
    PROCEDURE CntServicoGetRetrabLostFocus()
        LOCAL loc_nTotal, loc_oErro
        TRY
            IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi") ;
                    AND PEMSTATUS(THIS, "cnt_4c_Servico", 5) ;
                    AND PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
                loc_nTotal = ROUND(NVL(THIS.cnt_4c_Servico.txt_4c_GetRetrab.Value, 0) * NVL(xNensi.Qtds, 0), 2)
                THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = loc_nTotal
                THIS.cnt_4c_Servico.txt_4c_GetTotal.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LostFocus Get_Retrab")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupMoeda - KeyPress em txt_4c_GetMoeda (F4=115 / ENTER=13 / TAB=9)
    * Lookup SigCdMoe via FormBuscaAuxiliar -> cursor crListaRemota (CMOES, DMOES)
    * Replica: get_moeda.Valid do legado (fwBuscaExt -> SigCdMoe)
    *==========================================================================
    PROCEDURE AbrirLookupMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm, loc_cValor, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
                IF !PEMSTATUS(THIS, "cnt_4c_Servico", 5)
                    RETURN
                ENDIF
                loc_cValor = ALLTRIM(NVL(THIS.cnt_4c_Servico.txt_4c_GetMoeda.Value, ""))
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "crListaRemota", "CMOES", loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o")
                IF ISNULL(loc_oForm)
                    RETURN
                ENDIF
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    THIS.cnt_4c_Servico.txt_4c_GetMoeda.Value = ALLTRIM(crListaRemota.CMOES)
                    THIS.cnt_4c_Servico.txt_4c_GetMoeda.Refresh()
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("CMOES", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("DMOES", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou ;
                            AND PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetMoeda", 5)
                        THIS.cnt_4c_Servico.txt_4c_GetMoeda.Value = ALLTRIM(crListaRemota.CMOES)
                        THIS.cnt_4c_Servico.txt_4c_GetMoeda.Refresh()
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("crListaRemota")
                    USE IN crListaRemota
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro lookup Moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Vincula grd_4c_Dados ao cursor xNensi e refresca
    * Em forms OPERACIONAIS substitui o CarregarLista CRUD: nao busca SQL,
    * apenas rebinda o grid ao cursor compartilhado do form pai e reposiciona.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                MsgErro("Cursor xNensi n" + CHR(227) + "o dispon" + ;
                    CHR(237) + "vel.", "Erro CarregarLista")
            ELSE
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.RecordSource = "xNensi"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                IF RECCOUNT("xNensi") > 0
                    GO TOP IN xNensi
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista de componentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza estado do form com o Business Object
    * Para forms OPERACIONAIS que operam sobre cursor VFP compartilhado,
    * os "campos" sao as propriedades de estado: pcEscolha, valores anteriores,
    * flags de controle. Mantem BO em sincronia com o estado corrente.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                loc_lResultado = .F.
            ENDIF

            *-- Modo de operacao
            loc_oBO.this_cPcEscolha     = THIS.pcEscolha
            loc_oBO.this_cPEmps         = THIS.pEmps

            *-- Estado operacional
            loc_oBO.this_lInfoLote      = THIS.InfoLote
            loc_oBO.this_lInfoEnve      = THIS.InfoEnve
            loc_oBO.this_lEditaEnve     = THIS.EditaEnve
            loc_oBO.this_nCtrlAgrega    = THIS.CtrlAgrega
            loc_oBO.this_lAlteraServico = THIS.AlteraServico
            loc_oBO.this_nCompAgru      = THIS.CompAgru
            loc_oBO.this_lLibInserir    = THIS.LibInserir
            loc_oBO.this_lInibeInserir  = THIS.InibeInserir
            loc_oBO.this_lInibeAlterar  = THIS.InibeAlterar
            loc_oBO.this_lInibeExcluir  = THIS.InibeExcluir

            *-- Valores anteriores (usados nas validacoes do grid)
            loc_oBO.this_cAntValue      = THIS.AntValue
            loc_oBO.this_nAntQtde       = THIS.AntQtde
            loc_oBO.this_nAntPeso       = THIS.AntPeso
            loc_oBO.this_nAntValueP     = THIS.AntValueP
            loc_oBO.this_cObsAnterior   = THIS.ObsAnterior

            *-- Linha corrente de xNensi (se disponivel)
            IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
                loc_oBO.this_cCMats     = ALLTRIM(NVL(xNensi.Cmats, ""))
                loc_oBO.this_nNops      = NVL(xNensi.Nops, 0)
                loc_oBO.this_nNenvs     = NVL(xNensi.Nenvs, 0)
                loc_oBO.this_cTpOps     = ALLTRIM(NVL(xNensi.TpOps, ""))
                loc_oBO.this_nQtds      = NVL(xNensi.Qtds, 0)
                loc_oBO.this_nPesos     = NVL(xNensi.Pesos, 0)
                loc_oBO.this_cCats      = ALLTRIM(NVL(xNensi.Cats, ""))
                loc_oBO.this_nNLotes    = NVL(xNensi.nLotes, 0)
                loc_oBO.this_cCodCors   = ALLTRIM(NVL(xNensi.Cors, ""))
                loc_oBO.this_cCodTams   = ALLTRIM(NVL(xNensi.Tams, ""))
                loc_oBO.this_lFlagIncs  = (VARTYPE(xNensi.FlagIncs) = "L" AND xNensi.FlagIncs)
                loc_oBO.this_nRateio    = NVL(xNensi.Rateio, 0)
                loc_oBO.this_nAmarracao = NVL(xNensi.Amarracao, 0)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO Componentes")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza estado do Business Object com o form
    * Atualiza campos de exibicao a partir do BO (descricoes de lookup,
    * flags de controle, estado dos botoes).
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                loc_lResultado = .F.
            ENDIF

            *-- Modo de operacao (pode ter sido alterado pelo sub-form)
            THIS.pcEscolha     = loc_oBO.this_cPcEscolha
            THIS.AlteraServico = loc_oBO.this_lAlteraServico
            THIS.CtrlAgrega    = loc_oBO.this_nCtrlAgrega

            *-- Valores anteriores (restaura apos retorno de sub-forms)
            THIS.AntValue    = loc_oBO.this_cAntValue
            THIS.AntQtde     = loc_oBO.this_nAntQtde
            THIS.AntPeso     = loc_oBO.this_nAntPeso
            THIS.AntValueP   = loc_oBO.this_nAntValueP
            THIS.ObsAnterior = loc_oBO.this_cObsAnterior

            *-- Atualiza campos de exibicao da linha corrente
            IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
                IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
                    THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
                    THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
                    THIS.txt_4c_Cor.Value = ALLTRIM(NVL(xNensi.Cors, ""))
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
                    THIS.txt_4c_Tam.Value = ALLTRIM(NVL(xNensi.Tams, ""))
                ENDIF
            ENDIF

            *-- Atualiza estado dos botoes de acordo com modo atual
            THIS.AjustarBotoesPorModo()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm Componentes")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Define ReadOnly/Enabled dos controles conforme pcEscolha
    * INSERIR/ALTERAR: grid editavel, campos de filtro habilitados
    * VISUALIZAR/demais: grid ReadOnly, campos bloqueados
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_lEdita, loc_oErro

        TRY
            loc_lEdita = INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")

            *-- Grade principal: modo de edicao
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.ReadOnly    = !loc_lEdita
            ENDIF

            *-- Campo de observacao (sempre ReadOnly - exibicao apenas)
            IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
                THIS.txt_4c_GetObs.ReadOnly = .T.
            ENDIF

            *-- Campos de cor e tamanho (sempre ReadOnly - preenchidos via grid)
            IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
                THIS.txt_4c_Cor.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
                THIS.txt_4c_Tam.ReadOnly = .T.
            ENDIF

            *-- Botoes de manipulacao
            THIS.AjustarBotoesPorModo()

            *-- Checkboxes que abrem forms de edicao
            IF PEMSTATUS(THIS, "chk_4c_Retrabalho", 5)
                THIS.chk_4c_Retrabalho.Enabled = loc_lEdita
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Pagto", 5)
                THIS.chk_4c_Pagto.Enabled = loc_lEdita
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_RetrabAnt", 5)
                THIS.chk_4c_RetrabAnt.Enabled = loc_lEdita
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Naoconforme", 5)
                THIS.chk_4c_Naoconforme.Enabled = loc_lEdita
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Agregado", 5)
                THIS.chk_4c_Agregado.Enabled = loc_lEdita
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao habilitar campos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos de exibicao (descricao, observacao, cor, tam)
    * Usado ao entrar em modo INCLUIR ou para resetar visualizacao.
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
                THIS.lbl_4c_GetDescr.Caption = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
                THIS.txt_4c_GetObs.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
                THIS.txt_4c_Cor.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
                THIS.txt_4c_Tam.Value = ""
            ENDIF

            *-- Limpa painel de servico
            IF PEMSTATUS(THIS, "cnt_4c_Servico", 5)
                IF PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
                    THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = 0
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar campos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme pcEscolha e flags
    * INSERIR/ALTERAR + !Inibe*: botoes habilitados
    * VISUALIZAR/demais: todos os botoes de manipulacao desabilitados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEdita, loc_oErro

        TRY
            loc_lEdita = INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")

            IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
                THIS.cmd_4c_Inserir.Enabled = loc_lEdita AND !THIS.InibeInserir
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
                THIS.cmd_4c_Alterar.Enabled = loc_lEdita AND !THIS.InibeAlterar
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
                THIS.cmd_4c_Excluir.Enabled = loc_lEdita AND !THIS.InibeExcluir
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
                THIS.cmd_4c_EncerraPCC.Enabled = loc_lEdita
            ENDIF

            *-- Sair e Lotes: sempre habilitados
            IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
                THIS.cmd_4c_Sair.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Lotes", 5)
                THIS.cmd_4c_Lotes.Enabled = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es por modo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Alias canonico de saida para forms OPERACIONAIS
    * Delega para BtnSairClick que executa a validacao completa (ok.Click legado)
    * antes de fechar o form.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Aceita o estado corrente dos componentes e fecha
    * Em forms OPERACIONAIS o "salvar" significa aceitar as alteracoes no
    * cursor xNensi e retornar ao form pai (que gerencia o commit para o banco).
    * Replica a logica do ok.Click do legado: valida e fecha.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnSairClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Reverte alteracoes no cursor xNensi e fecha o form
    * Cancela todas as edicoes pendentes: TABLEREVERT .T. desfaz todos os
    * registros alterados/adicionados desde o ultimo TABLEUPDATE.
    * O form pai (SigPdMfa) continua com xNensi no estado anterior a abertura.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            IF USED("xNensi")
                *-- Desfaz edicoes pendentes no buffer da tabela
                TABLEREVERT(.T., "xNensi")
            ENDIF
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao cancelar componentes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Refresca o grid de componentes (reposiciona no topo)
    * Em forms OPERACIONAIS sem campo de filtro, "buscar" equivale a recarregar
    * a lista a partir do cursor xNensi e posicionar no primeiro registro.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            IF USED("xNensi")
                SELECT xNensi
                SET ORDER TO
                GO TOP
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                *-- Atualiza campos de exibicao da linha corrente
                IF !EOF("xNensi")
                    IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
                        THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
                    ENDIF
                    IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
                        THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar componentes")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpdmp2BO.prg):
*==============================================================================
* sigpdmp2BO.prg - Business Object para Componentes de Producao (SIGPDMP2)
* Herda de: BusinessBase
* Form OPERACIONAL: Sub-form de edicao de componentes por fase de producao.
* Opera sobre cursor VFP xNensi (componentes da OP) passado pelo form pai.
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigpdmp2BO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao - sem tabela SQL direta (opera em cursor VFP xNensi)
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Contexto do form pai (recebidos no Init do form via parametros)
    *--------------------------------------------------------------------------
    this_cPcEscolha     = ""    && "INSERIR" / "ALTERAR" / "VISUALIZAR" / "EXCLUIR"
    this_cPEmps         = ""    && Empresa do form pai (pEmps)
    this_cPDopps        = ""    && Dopps da OP aberta pelo form pai

    *--------------------------------------------------------------------------
    * Propriedades da linha corrente do cursor xNensi (grid de componentes)
    *--------------------------------------------------------------------------
    this_cEmps          = ""    && Empresa (Emps C3)
    this_cDopps         = ""    && Codigo da OP de origem (Dopps)
    this_nNumps         = 0     && Numero da producao (Numps)
    this_nNops          = 0     && Numero da Ordem de Producao (Nops)
    this_nNenvs         = 0     && Numero do envelope / lote (Nenvs)
    this_cCMats         = ""    && Codigo do material / componente (CMats C14)
    this_cCDescs        = ""    && Descricao do componente (CDescs)
    this_cCGrus         = ""    && Codigo do grupo do produto (CGrus)
    this_cCUnis         = ""    && Unidade de medida da quantidade (Cunis)
    this_cCUniPs        = ""    && Unidade de medida do peso (CUniPs)
    this_cTpOps         = ""    && Tipo de material / operacao (TpOps)
    this_nQtds          = 0     && Quantidade (Qtds N12,3)
    this_nPesos         = 0     && Peso fabricacao (Pesos N12,3)
    this_nPeso2s        = 0     && Peso da unidade (Peso2s N12,3)
    this_nPsFaseAnt     = 0     && Peso da fase anterior (PsFaseAnt N12,3)
    this_nQtFaseAnt     = 0     && Quantidade da fase anterior (QtFaseAnt N12,3)
    this_nPs2FaseAnt    = 0     && Peso secundario da fase anterior (Ps2FaseAnt N12,3)
    this_cCodCors       = ""    && Codigo da cor (CodCors C4)
    this_cCodTams       = ""    && Codigo do tamanho (CodTams C4)
    this_nNLotes        = 0     && Numero do lote (nLotes)
    this_nAmarracao     = 0     && Codigo de amarracao/agregacao (Amarracao)
    this_cCats          = ""    && Categoria do servico (Cats C6)
    this_nFators        = 0     && Fator / valor do servico (Fators N12,2)
    this_nCoefs         = 0     && Coeficiente de retrabalho (Coefs N12,2)
    this_cMoedas        = ""    && Codigo da moeda do servico (Moedas C3)
    this_lServicos      = .F.   && Linha e um servico? (Servicos BIT->LOGICAL)
    this_nServAuto      = 0     && Tipo de servico automatico: 1=auto 2=valor (ServAuto N1)
    this_cGrupoFins     = ""    && Grupo financeiro do servico (GrupoFins)
    this_cGrupoFs       = ""    && Grupo financeiro do funcionario (GrupoFs)
    this_cContaFs       = ""    && Conta do funcionario (ContaFs)
    this_cLibProds      = ""    && Codigo de liberacao do produto (LibProds)
    this_lCarCompos     = .F.   && Linha carrega composicao? (CarCompos BIT->LOGICAL)
    this_cMatPrincs     = ""    && Material principal do semiacabado (MatPrincs C14)
    this_lRetrabs       = .F.   && Linha tem retrabalho? (Retrabs BIT->LOGICAL)
    this_cCodnConfs     = ""    && Codigo de nao-conformidade (CodnConfs)
    this_cObss          = ""    && Observacao da linha (Obss)
    this_lFlagIncs      = .F.   && Flag de inclusao manual (FlagIncs BIT->LOGICAL)
    this_nRateio        = 0     && Tipo de rateio: 1=composto 2=agg_inv 3=agg 5=direto (Rateio N1)
    this_lVisivel       = .F.   && Linha visivel no grid? (Visivel BIT->LOGICAL)
    this_lNChkSep       = .F.   && Checar separacao? (NChkSep BIT->LOGICAL)

    *--------------------------------------------------------------------------
    * Descricoes de lookup (nao persistidas, preenchidas via query de apoio)
    *--------------------------------------------------------------------------
    this_cDsCMats       = ""    && Descricao do produto (DPros de SigCdPro)
    this_cDsCGrus       = ""    && Descricao do grupo (DGrus de SigCdGrp)
    this_cDsMoedas      = ""    && Descricao da moeda (DMoes de SigCdMoe)
    this_cDsCodCors     = ""    && Descricao da cor (Descs de SigCdCor)
    this_cDsCodTams     = ""    && Descricao do tamanho (Descs de SigCdTam)
    this_cDsTpOps       = ""    && Descricao do tipo de material (de SigCdRpo / SigOpOpt)
    this_cDsCats        = ""    && Descricao da categoria de servico (de crSigCdSvc)

    *--------------------------------------------------------------------------
    * Estado operacional do form (sincronizados com propriedades do Form)
    *--------------------------------------------------------------------------
    this_lInfoLote      = .F.   && OP usa controle de lote? (InfoLote do form)
    this_lInfoEnve      = .F.   && Envelope obrigatorio? (InfoEnve: EnvObrigs=1)
    this_lEditaEnve     = .F.   && Editar envelope? (EditaEnve: EnvObrigs=3)
    this_nCtrlAgrega    = 0     && Contador de grupos de agregacao (CtrlAgrega)
    this_lAlteraServico = .F.   && Usuario pode alterar valor do servico? (AlteraServico)
    this_nTrfPesa       = 0     && Tipo de transferencia de peso (TrfPesa de crSigCdOpd)
    this_nCompAgru      = 0     && Tipo de composicao agregada (CompAgru de crSigCdOpd)
    this_lLibInserir    = .T.   && Botao Inserir liberado? (LibInserir)
    this_lInibeInserir  = .T.   && Permissao inserir? (InibeInserir via fChecaAcesso)
    this_lInibeAlterar  = .T.   && Permissao alterar? (InibeAlterar via fChecaAcesso)
    this_lInibeExcluir  = .T.   && Permissao excluir? (InibeExcluir via fChecaAcesso)

    *--------------------------------------------------------------------------
    * Valores anteriores usados nas validacoes de campo do grid
    *--------------------------------------------------------------------------
    this_cAntValue      = ""    && Valor anterior do campo Componente (14 chars)
    this_nAntQtde       = 0     && Quantidade antes da edicao (AntQtde)
    this_nAntPeso       = 0     && Peso antes da edicao (AntPeso / Antpeso)
    this_nAntValueP     = 0     && Valor do campo Peso2s antes da edicao (AntValueP)
    this_cObsAnterior   = ""    && TpOps da linha anterior (ObsAnterior, Repete Tipo Material)

    *--------------------------------------------------------------------------
    * Configuracao da balanca serial (de crSigCdPam)
    *--------------------------------------------------------------------------
    this_nBalPorta      = 0     && Porta COM da balanca (BalPortas)
    this_nBalVelocidade = 0     && Velocidade serial (BalVelocs)
    this_nBalTpParidade = 0     && Tipo de paridade (BalTppars)
    this_nBalBits       = 0     && Bits da balanca (BalBits)
    this_nBalParidade   = 0     && Paridade da balanca (BalParids)

    *--------------------------------------------------------------------------
    * Configuracao da OP corrente (cache de crSigCdOpd para validacoes)
    *--------------------------------------------------------------------------
    this_nGrOdns        = 0     && Grupo de ordem (GrOdns): 1=por grupo
    this_nSepPedras     = 0     && Separacao de pedras (SepPedras)
    this_nChkQtdPs      = 0     && Checagem quantidade/peso (ChkQtdPs)
    this_nPesoFixs      = 0     && Peso fixo (PesoFixs): 2=proporcional ao mat principal
    this_nPesoBals      = 0     && Peso via balanca (PesoBals): 1=balanca obrigatoria
    this_nPagServs      = 0     && Pagamento de servicos (PagServs)
    this_lPccs          = .F.   && Usa PCC? (Pccs BIT->LOGICAL)
    this_nBtnRets       = 0     && Visibilidade do botao Retrabalho (BtnRets)
    this_nBtnIncs       = 0     && Visibilidade do botao Nao-Conforme (BtnIncs)
    this_nBtnPags       = 0     && Visibilidade do botao Pagamento (BtnPags)
    this_nInibAlts      = 0     && Inibe alteracoes? (InibAlts)
    this_nMensagens     = 0     && Exibe mensagens de produto? (Mensagens)
    this_nQtdNegs       = 0     && Aceita quantidade negativa? (QtdNegs)
    this_cMatPads       = ""    && Material padrao da OP (MatPads C14)
    this_cChkMtPrs      = 0     && Checa material principal? (ChkMtPrs)
    this_cTpPadraos     = ""    && Tipo padrao de material da OP (TpPadraos)
    this_nCasQtds       = 0     && Casas decimais da quantidade (CasQtds)
    this_cDopps_Op      = ""    && Dopps da operacao de configuracao (crSigCdOpd.Dopps)
    this_nNdopps        = 0     && Ndopps da operacao (crSigCdOpd.Ndopps)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN TRANSFORM(THIS.this_nNops) + "|" + ;
               TRANSFORM(THIS.this_nNenvs) + "|" + ;
               ALLTRIM(THIS.this_cCMats)
    ENDPROC

    *==========================================================================
    * Inserir - Insere linha corrente (this_*) no cursor xNensi
    * Sobrescreve BusinessBase.Inserir(). O form OPERACIONAL persiste em cursor
    * VFP (xNensi); a gravacao SQL definitiva e feita pelo form pai apos ok.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                THIS.this_cMensagemErro = "Cursor xNensi n" + CHR(227) + "o aberto"
                loc_lSucesso = loc_lSucesso
            ENDIF

            INSERT INTO xNensi ( ;
                Emps, Dopps, Numps, Nops, Nenvs, ;
                CMats, CDescs, CGrus, Cunis, CUniPs, TpOps, ;
                Qtds, Pesos, Peso2s, ;
                PsFaseAnt, QtFaseAnt, Ps2FaseAnt, ;
                CodCors, CodTams, nLotes, Amarracao, ;
                Cats, Fators, Coefs, Moedas, ;
                Servicos, ServAuto, LibProds, CarCompos, MatPrincs, ;
                Retrabs, CodnConfs, Obss, FlagIncs, Rateio, ;
                Visivel, NChkSep) ;
                VALUES ( ;
                THIS.this_cEmps, THIS.this_cDopps, THIS.this_nNumps, ;
                THIS.this_nNops, THIS.this_nNenvs, ;
                THIS.this_cCMats, THIS.this_cCDescs, THIS.this_cCGrus, ;
                THIS.this_cCUnis, THIS.this_cCUniPs, THIS.this_cTpOps, ;
                THIS.this_nQtds, THIS.this_nPesos, THIS.this_nPeso2s, ;
                THIS.this_nPsFaseAnt, THIS.this_nQtFaseAnt, THIS.this_nPs2FaseAnt, ;
                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_nNLotes, THIS.this_nAmarracao, ;
                THIS.this_cCats, THIS.this_nFators, THIS.this_nCoefs, THIS.this_cMoedas, ;
                THIS.this_lServicos, THIS.this_nServAuto, THIS.this_cLibProds, ;
                THIS.this_lCarCompos, THIS.this_cMatPrincs, ;
                THIS.this_lRetrabs, THIS.this_cCodnConfs, THIS.this_cObss, ;
                THIS.this_lFlagIncs, THIS.this_nRateio, ;
                THIS.this_lVisivel, THIS.this_lNChkSep)

            THIS.RegistrarAuditoria("INSERT")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza linha corrente do cursor xNensi com this_*
    * Sobrescreve BusinessBase.Atualizar(). Opera sobre a linha posicionada
    * no cursor xNensi (chave Nops + Nenvs + CMats via ObterChavePrimaria).
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cOrdemAnterior
        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                THIS.this_cMensagemErro = "Cursor xNensi n" + CHR(227) + "o aberto"
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT xNensi
            loc_cOrdemAnterior = ORDER()
            SET ORDER TO NopMatCat

            IF !SEEK(STR(THIS.this_nNops, 10) + THIS.this_cCMats)
                IF !EMPTY(loc_cOrdemAnterior)
                    SET ORDER TO (loc_cOrdemAnterior)
                ELSE
                    SET ORDER TO Editar
                ENDIF
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado em xNensi"
                loc_lSucesso = loc_lSucesso
            ENDIF

            REPLACE ;
                Emps        WITH THIS.this_cEmps, ;
                Dopps       WITH THIS.this_cDopps, ;
                Numps       WITH THIS.this_nNumps, ;
                Nenvs       WITH THIS.this_nNenvs, ;
                CDescs      WITH THIS.this_cCDescs, ;
                CGrus       WITH THIS.this_cCGrus, ;
                Cunis       WITH THIS.this_cCUnis, ;
                CUniPs      WITH THIS.this_cCUniPs, ;
                TpOps       WITH THIS.this_cTpOps, ;
                Qtds        WITH THIS.this_nQtds, ;
                Pesos       WITH THIS.this_nPesos, ;
                Peso2s      WITH THIS.this_nPeso2s, ;
                PsFaseAnt   WITH THIS.this_nPsFaseAnt, ;
                QtFaseAnt   WITH THIS.this_nQtFaseAnt, ;
                Ps2FaseAnt  WITH THIS.this_nPs2FaseAnt, ;
                CodCors     WITH THIS.this_cCodCors, ;
                CodTams     WITH THIS.this_cCodTams, ;
                nLotes      WITH THIS.this_nNLotes, ;
                Amarracao   WITH THIS.this_nAmarracao, ;
                Cats        WITH THIS.this_cCats, ;
                Fators      WITH THIS.this_nFators, ;
                Coefs       WITH THIS.this_nCoefs, ;
                Moedas      WITH THIS.this_cMoedas, ;
                Servicos    WITH THIS.this_lServicos, ;
                ServAuto    WITH THIS.this_nServAuto, ;
                LibProds    WITH THIS.this_cLibProds, ;
                CarCompos   WITH THIS.this_lCarCompos, ;
                MatPrincs   WITH THIS.this_cMatPrincs, ;
                Retrabs     WITH THIS.this_lRetrabs, ;
                CodnConfs   WITH THIS.this_cCodnConfs, ;
                Obss        WITH THIS.this_cObss, ;
                FlagIncs    WITH THIS.this_lFlagIncs, ;
                Rateio      WITH THIS.this_nRateio, ;
                Visivel     WITH THIS.this_lVisivel, ;
                NChkSep     WITH THIS.this_lNChkSep ;
                IN xNensi

            IF !EMPTY(loc_cOrdemAnterior)
                SET ORDER TO (loc_cOrdemAnterior)
            ELSE
                SET ORDER TO Editar
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Marca a linha corrente do cursor xNensi como deletada
    * Sobrescreve BusinessBase.ExecutarExclusao(). A persistencia SQL e feita
    * pelo form pai ao confirmar a sub-tela.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                THIS.this_cMensagemErro = "Cursor xNensi n" + CHR(227) + "o aberto"
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT xNensi
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Nenhuma linha posicionada para excluir"
                loc_lSucesso = loc_lSucesso
            ENDIF

            DELETE IN xNensi
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro Excluir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Loga operacao em LogAuditoria
    * par_cOperacao: "INSERT" | "UPDATE" | "DELETE"
    * Tabela logica: "xNensi" (cursor operacional do form SIGPDMP2)
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cTabelaLog

        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF EMPTY(loc_cChave)
                loc_lResultado = .F.
            ENDIF

            loc_cTabelaLog = "xNensi"
            loc_cUsuario   = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + EscaparSQL(loc_cTabelaLog) + ", " + ;
                                    EscaparSQL(par_cOperacao) + ", " + ;
                                    EscaparSQL(loc_cChave) + ", " + ;
                                    EscaparSQL(loc_cUsuario) + ", GETDATE())"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            * Falha em auditoria nao deve interromper operacao do form operacional
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir do registro corrente
    * par_cAliasCursor: alias do cursor de origem (normalmente "xNensi")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasCursor)
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT (par_cAliasCursor)

            THIS.this_cEmps       = NVL(Emps,       "")
            THIS.this_cDopps      = NVL(Dopps,      "")
            THIS.this_nNumps      = NVL(Numps,       0)
            THIS.this_nNops       = NVL(Nops,         0)
            THIS.this_nNenvs      = NVL(Nenvs,        0)
            THIS.this_cCMats      = NVL(CMats,       "")
            THIS.this_cCDescs     = NVL(CDescs,      "")
            THIS.this_cCGrus      = NVL(CGrus,       "")
            THIS.this_cCUnis      = NVL(Cunis,       "")
            THIS.this_cCUniPs     = NVL(CUniPs,      "")
            THIS.this_cTpOps      = NVL(TpOps,       "")
            THIS.this_nQtds       = NVL(Qtds,         0)
            THIS.this_nPesos      = NVL(Pesos,        0)
            THIS.this_nPeso2s     = NVL(Peso2s,       0)
            THIS.this_nPsFaseAnt  = NVL(PsFaseAnt,    0)
            THIS.this_nQtFaseAnt  = NVL(QtFaseAnt,    0)
            THIS.this_nPs2FaseAnt = NVL(Ps2FaseAnt,   0)
            THIS.this_cCodCors    = NVL(CodCors,     "")
            THIS.this_cCodTams    = NVL(CodTams,     "")
            THIS.this_nNLotes     = NVL(nLotes,       0)
            THIS.this_nAmarracao  = NVL(Amarracao,    0)
            THIS.this_cCats       = NVL(Cats,        "")
            THIS.this_nFators     = NVL(Fators,       0)
            THIS.this_nCoefs      = NVL(Coefs,        0)
            THIS.this_cMoedas     = NVL(Moedas,      "")
            THIS.this_nServAuto   = NVL(ServAuto,     0)
            THIS.this_cLibProds   = NVL(LibProds,    "")
            THIS.this_cMatPrincs  = NVL(MatPrincs,   "")
            THIS.this_cCodnConfs  = NVL(CodnConfs,   "")
            THIS.this_cObss       = NVL(Obss,        "")
            THIS.this_nRateio     = NVL(Rateio,       0)

            *-- Campos BIT do SQL Server chegam como LOGICAL no VFP9
            IF VARTYPE(Servicos) = "L"
                THIS.this_lServicos = Servicos
            ELSE
                THIS.this_lServicos = IIF(NVL(Servicos, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(CarCompos) = "L"
                THIS.this_lCarCompos = CarCompos
            ELSE
                THIS.this_lCarCompos = IIF(NVL(CarCompos, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(Retrabs) = "L"
                THIS.this_lRetrabs = Retrabs
            ELSE
                THIS.this_lRetrabs = IIF(NVL(Retrabs, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(FlagIncs) = "L"
                THIS.this_lFlagIncs = FlagIncs
            ELSE
                THIS.this_lFlagIncs = IIF(NVL(FlagIncs, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(Visivel) = "L"
                THIS.this_lVisivel = Visivel
            ELSE
                THIS.this_lVisivel = IIF(NVL(Visivel, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(NChkSep) = "L"
                THIS.this_lNChkSep = NChkSep
            ELSE
                THIS.this_lNChkSep = IIF(NVL(NChkSep, .F.), .T., .F.)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirNaGrade - Insere nova linha vazia no cursor xNensi
    * Replica logica do Inserir.Click do legado (SIGPDMP2)
    * par_cAliasTmpNens: alias do cursor TmpNens (dados da producao)
    * par_cAliasOpd:     alias do crSigCdOpd (configuracao da OP)
    * par_nCompAgru:     CompAgru do form (tipo de composicao agregada)
    * Retorna .T. se inseriu / posicionou com sucesso
    *==========================================================================
    PROCEDURE InserirNaGrade(par_cAliasTmpNens, par_cAliasOpd, par_nCompAgru)
        LOCAL loc_lSucesso
        LOCAL loc_cEmps, loc_cDopps, loc_nNumps, loc_cTpPadraos, loc_nPsFaseAnt

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi") OR !USED(par_cAliasTmpNens) OR !USED(par_cAliasOpd)
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT (par_cAliasTmpNens)
            loc_cEmps  = Emps
            loc_cDopps = Dopps
            loc_nNumps = Numps

            SELECT (par_cAliasOpd)
            loc_cTpPadraos = TpPadraos

            SELECT xNensi
            SET ORDER TO NopMatCat

            IF !SEEK(STR(0, 10) + SPACE(13))
                *-- Nenhuma linha vazia: insere nova linha em branco
                INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                             VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadraos, .T.)
                loc_lSucesso = .T.
            ELSE
                *-- Ja existe linha vazia; se CompAgru=1 com peso anterior, insere outra
                loc_nPsFaseAnt = xNensi.PsFaseAnt
                IF (par_nCompAgru = 1) AND (loc_nPsFaseAnt <> 0)
                    INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                                 VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadraos, .T.)
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            SET ORDER TO Editar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir na grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirDaGrade - Remove linha(s) do cursor xNensi conforme config da OP
    * Replica logica do Excluir.Click do legado (SIGPDMP2)
    * par_nSepPedras: CrSigCdOpd.SepPedras
    * par_nChkQtdPs:  CrSigCdOpd.CHKQTDPS
    * Retorna .T. se excluiu com sucesso
    *==========================================================================
    PROCEDURE ExcluirDaGrade(par_nSepPedras, par_nChkQtdPs)
        LOCAL loc_lSucesso
        LOCAL loc_cCMats, loc_nNenvs, loc_nNops, loc_nAmarracao, loc_lFlagIncs

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT xNensi
            IF EOF() OR BOF()
                loc_lSucesso = loc_lSucesso
            ENDIF

            loc_cCMats     = xNensi.CMats
            loc_nNenvs     = xNensi.Nenvs
            loc_nNops      = xNensi.Nops
            loc_nAmarracao = xNensi.Amarracao
            loc_lFlagIncs  = IIF(VARTYPE(xNensi.FlagIncs) = "L", xNensi.FlagIncs, ;
                                 IIF(NVL(xNensi.FlagIncs, .F.), .T., .F.))

            SET ORDER TO

            IF par_nSepPedras = 4
                *-- Separacao de pedras: deleta pelo CMats (exceto linhas de servico)
                DELETE ALL FOR loc_cCMats = CMats AND !Servicos

            ELSE
                IF par_nChkQtdPs = 4
                    *-- ChkQtdPs=4: deleta somente agregados da mesma amarracao se FlagIncs
                    IF loc_lFlagIncs
                        DELETE ALL FOR FlagIncs AND loc_cCMats = CMats AND Amarracao = loc_nAmarracao
                    ENDIF

                ELSE
                    *-- Padrao: deleta por Nenvs+Nops ou por amarracao
                    IF loc_nAmarracao = 0
                        DELETE ALL FOR FlagIncs AND loc_cCMats = CMats AND ;
                                        loc_nNenvs = Nenvs AND loc_nNops = Nops
                    ELSE
                        DELETE ALL FOR FlagIncs AND ;
                                        IIF(!EMPTY(loc_nAmarracao), Amarracao = loc_nAmarracao, CMats = loc_cCMats)
                    ENDIF
                ENDIF
            ENDIF

            SET ORDER TO Editar
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir da grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGradeAntesFechar - Valida todos os lancamentos antes de fechar
    * Replica logica do ok.Click do legado (SIGPDMP2)
    * par_cPcEscolha:    modo ("INSERIR" / "ALTERAR" / "VISUALIZAR")
    * par_cAliasTmpNens: alias do cursor TmpNens
    * par_cAliasOpd:     alias do cursor crSigCdOpd
    * Retorna "" se valido; mensagem de aviso se invalido
    *==========================================================================
    PROCEDURE ValidarGradeAntesFechar(par_cPcEscolha, par_cAliasTmpNens, par_cAliasOpd)
        LOCAL loc_cMensagem, loc_nResult, loc_cSQL
        LOCAL loc_lDispNensi, loc_lChkCor, loc_lChkTam, loc_lDupTpO
        LOCAL loc_nGrOdns, loc_nQtdNegs
        LOCAL loc_cGrupoOs, loc_cEmps, loc_cDopps, loc_nNumps

        loc_cMensagem  = ""
        loc_lDispNensi = .F.
        loc_lChkCor    = .F.
        loc_lChkTam    = .F.
        loc_lDupTpO    = .F.

        TRY
            IF !INLIST(par_cPcEscolha, "INSERIR", "ALTERAR")
                loc_lResultado = loc_cMensagem
            ENDIF

            IF !USED("xNensi") OR !USED(par_cAliasOpd) OR !USED(par_cAliasTmpNens)
                loc_lResultado = loc_cMensagem
            ENDIF

            SELECT (par_cAliasOpd)
            loc_nGrOdns  = GrOdns
            loc_nQtdNegs = QtdNegs

            IF loc_nGrOdns = 1
                loc_lResultado = loc_cMensagem
            ENDIF

            SELECT (par_cAliasTmpNens)
            loc_cGrupoOs = GrupoOs
            loc_cEmps    = Emps
            loc_cDopps   = Dopps
            loc_nNumps   = Numps

            SELECT xNensi
            SCAN
                IF EMPTY(TpOps) AND EMPTY(Cats)
                    loc_lDispNensi = .T.
                    EXIT
                ENDIF

                *-- Checa duplicidade de TpOps por envelope
                loc_cSQL = "SELECT DupTpOps FROM SigOpOpt WHERE cods = '" + ALLTRIM(TpOps) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpt")

                IF loc_nResult > 0 AND !EOF("cursor_4c_LocalOpt")
                    IF cursor_4c_LocalOpt.DupTpOps = 1 AND Nenvs <> 0
                        LOCAL loc_cKeyEmpDn
                        loc_cKeyEmpDn = ALLTRIM(loc_cEmps) + ALLTRIM(loc_cDopps) + STR(loc_nNumps, 10)

                        loc_cSQL = "SELECT a.Nenvs, a.TpOps FROM SigCdNei a, SigCdNec b " + ;
                                   "WHERE a.Nenvs = " + TRANSFORM(Nenvs) + " " + ;
                                   "AND a.TpOps = '" + ALLTRIM(TpOps) + "' " + ;
                                   "AND a.EmpDnPs = b.EmpDnPs " + ;
                                   "AND b.GrupoOs = '" + ALLTRIM(loc_cGrupoOs) + "' " + ;
                                   "AND a.EmpDnPs <> '" + loc_cKeyEmpDn + "'"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupNensi")
                        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_DupNensi") > 0
                            loc_lDupTpO = .T.
                            IF USED("cursor_4c_DupNensi")
                                USE IN cursor_4c_DupNensi
                            ENDIF
                            IF USED("cursor_4c_LocalOpt")
                                USE IN cursor_4c_LocalOpt
                            ENDIF
                            SELECT xNensi
                            EXIT
                        ENDIF
                        IF USED("cursor_4c_DupNensi")
                            USE IN cursor_4c_DupNensi
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalOpt")
                    USE IN cursor_4c_LocalOpt
                ENDIF

                SELECT xNensi

                *-- Checa Cor e Tamanho obrigatorios
                IF !EMPTY(Cmats)
                    loc_cSQL = "SELECT b.Cores, b.Tams FROM SigCdPro a, SigCdGrp b " + ;
                               "WHERE a.Cpros = '" + ALLTRIM(Cmats) + "' AND a.Cgrus = b.Cgrus"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrTmpGru")

                    IF loc_nResult > 0 AND !EOF("cursor_4c_CrTmpGru")
                        IF cursor_4c_CrTmpGru.Cores = 1 AND EMPTY(CodCors)
                            loc_lChkCor = .T.
                            IF USED("cursor_4c_CrTmpGru")
                                USE IN cursor_4c_CrTmpGru
                            ENDIF
                            SELECT xNensi
                            EXIT
                        ENDIF
                        IF cursor_4c_CrTmpGru.Tams = 1 AND EMPTY(CodTams)
                            loc_lChkTam = .T.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_CrTmpGru")
                        USE IN cursor_4c_CrTmpGru
                    ENDIF
                ENDIF

                SELECT xNensi

                *-- Checa quantidade quando QtdNegs=3
                IF !EMPTY(CMats) AND (Qtds <= 0) AND (loc_nQtdNegs = 3)
                    loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Quantidade e Essa" + CHR(13) + ;
                                    "Movimenta" + CHR(231) + CHR(227) + "o Necessita Que Seja Informada!"
                    EXIT
                ENDIF
            ENDSCAN

            IF EMPTY(loc_cMensagem)
                DO CASE
                    CASE loc_lDispNensi
                        loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Tipo de Material!!!"
                    CASE loc_lChkCor
                        loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Cor!!!"
                    CASE loc_lChkTam
                        loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Tamanho!!!"
                    CASE loc_lDupTpO
                        loc_cMensagem = "Tipo de Material j" + CHR(225) + " Lan" + CHR(231) + "ado para este Envelope!!!"
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar grade")
        ENDTRY

        RETURN loc_cMensagem
    ENDPROC

    *==========================================================================
    * ValidarInfoEnve - Verifica lancamentos sem envelope obrigatorio
    * par_cAliasOpd:  alias do cursor crSigCdOpd
    * par_lInfoEnve:  flag se OP usa envelope obrigatorio
    * Retorna .T. se ha lancamento sem envelope (erro)
    *==========================================================================
    PROCEDURE ValidarInfoEnve(par_cAliasOpd, par_lInfoEnve)
        LOCAL loc_lDispEnve, loc_nSepPedras

        loc_lDispEnve = .F.

        TRY
            IF par_lInfoEnve AND USED("xNensi") AND USED(par_cAliasOpd)
                SELECT (par_cAliasOpd)
                loc_nSepPedras = SepPedras

                SELECT xNensi
                SCAN
                    IF EMPTY(Nenvs) AND (Rateio = 5 OR (Rateio = 1 AND FlagIncs)) AND loc_nSepPedras <> 4
                        loc_lDispEnve = .T.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar envelope")
        ENDTRY

        RETURN loc_lDispEnve
    ENDPROC

    *==========================================================================
    * DesmembraComposicao - Desmembra produto semiacabado em componentes
    * Replica logica do PROCEDURE desmembrac do legado (SIGPDMP2)
    * par_cAliasOpd:   alias do cursor crSigCdOpd
    * par_nCtrlAgrega: valor corrente de CtrlAgrega no form
    * Retorna novo valor de CtrlAgrega se sucesso, ou -1 se erro
    *==========================================================================
    PROCEDURE DesmembraComposicao(par_cAliasOpd, par_nCtrlAgrega)
        LOCAL loc_nNovoCtrlAgrega, loc_nResult, loc_cSQL
        LOCAL loc_cMat, loc_nOp, loc_cTpOp, loc_nLote
        LOCAL loc_nQtdAnt, loc_nPesoAnt, loc_nAmarraAnt, loc_nReg
        LOCAL loc_nAmarraX, loc_nPesoTot, loc_nQtde

        loc_nNovoCtrlAgrega = -1

        TRY
            IF !USED("xNensi") OR !USED("xMFas")
                loc_lResultado = loc_nNovoCtrlAgrega
            ENDIF

            SELECT xNensi
            loc_nReg       = RECNO()
            loc_cMat       = ALLTRIM(xNensi.CMats)
            loc_nOp        = xNensi.Nenvs
            loc_cTpOp      = ALLTRIM(xNensi.TpOPs)
            loc_nLote      = xNensi.nLotes
            loc_nQtdAnt    = xNensi.Qtds
            loc_nPesoAnt   = xNensi.Pesos
            loc_nAmarraAnt = xNensi.Amarracao

            *-- Remove agregados anteriores se havia amarracao
            IF loc_nAmarraAnt <> 0
                SET ORDER TO
                GO TOP
                DELETE ALL FOR FlagIncs AND Amarracao = loc_nAmarraAnt AND CMats <> loc_cMat
                SET ORDER TO Editar
                GO loc_nReg
            ENDIF

            *-- Busca quantidade de pecas na OP em xMFas
            SELECT xMFas
            GO TOP
            LOCATE FOR Nops = loc_nOp
            IF EOF()
                loc_lResultado = loc_nNovoCtrlAgrega
            ENDIF
            loc_nQtde = xMFas.Qtds

            *-- Incrementa amarracao
            loc_nNovoCtrlAgrega = par_nCtrlAgrega + 1
            loc_nAmarraX        = loc_nNovoCtrlAgrega

            *-- Carrega composicao do material semiacabado via SQL
            loc_cSQL = "SELECT a.Mats, a.DCompos, a.Qtds, a.UniCompos, a.Pesos, a.CuniPs, " + ;
                       "b.Cgrus, b.Varias, c.TpMovs, a.Pesos AS Peso2s " + ;
                       "FROM SigPrCpo a " + ;
                       "INNER JOIN SigCdPro b ON a.Mats = b.Cpros " + ;
                       "INNER JOIN SigCdGrp c ON a.Cgrus = c.Cgrus " + ;
                       "WHERE a.Cpros = '" + loc_cMat + "'"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPrCpo")
            IF loc_nResult < 1
                MsgErro("Falha na Conex" + CHR(227) + "o (crTmpPrCpo)", "Erro")
                loc_nNovoCtrlAgrega = -1
                loc_lResultado = loc_nNovoCtrlAgrega
            ENDIF

            *-- Calcula pesos totais dos componentes de peso fixo
            loc_nPesoTot = 0

            SELECT cursor_4c_TmpPrCpo
            SCAN
                LOCAL loc_nFator1, loc_nFator2, loc_nQtdCmp, loc_nPesoCmp

                loc_nFator1 = 1
                loc_nFator2 = 1

                IF !EMPTY(ALLTRIM(UniCompoS))
                    loc_cSQL = "SELECT Fators FROM SigCdUni WHERE CUnis = '" + ALLTRIM(UniCompoS) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LUni") > 0 AND !EOF("cursor_4c_LUni")
                        loc_nFator1 = NVL(cursor_4c_LUni.Fators, 1)
                    ENDIF
                    IF USED("cursor_4c_LUni")
                        USE IN cursor_4c_LUni
                    ENDIF
                ENDIF

                IF !EMPTY(ALLTRIM(CUniPs))
                    loc_cSQL = "SELECT Fators FROM SigCdUni WHERE CUnis = '" + ALLTRIM(CUniPs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LUni2") > 0 AND !EOF("cursor_4c_LUni2")
                        loc_nFator2 = NVL(cursor_4c_LUni2.Fators, 1)
                    ENDIF
                    IF USED("cursor_4c_LUni2")
                        USE IN cursor_4c_LUni2
                    ENDIF
                ENDIF

                SELECT cursor_4c_TmpPrCpo

                IF Varias <> 1
                    loc_nQtdCmp  = loc_nQtde * Qtds
                    loc_nPesoCmp = loc_nQtde * Pesos

                    REPLACE Qtds WITH loc_nQtdCmp, Peso2s WITH loc_nPesoCmp IN cursor_4c_TmpPrCpo

                    IF TpMovs <> 1
                        IF loc_nFator1 <> 1
                            LOCAL loc_nPesoCalc
                            loc_nPesoCalc = loc_nQtdCmp * loc_nFator1
                            REPLACE Pesos WITH loc_nPesoCalc IN cursor_4c_TmpPrCpo
                            loc_nPesoTot  = loc_nPesoTot + loc_nPesoCalc
                        ELSE
                            IF loc_nFator2 <> 1 AND !EMPTY(ALLTRIM(CUniPs))
                                LOCAL loc_nPesoCalc2
                                loc_nPesoCalc2 = loc_nPesoCmp * loc_nFator2
                                REPLACE Pesos WITH loc_nPesoCalc2 IN cursor_4c_TmpPrCpo
                                loc_nPesoTot   = loc_nPesoTot + loc_nPesoCalc2
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Lanca componentes de peso fixo na grade
            SELECT cursor_4c_TmpPrCpo
            SCAN
                IF Varias <> 1
                    *-- Grade principal (Rateio=1, Visivel=.T.)
                    INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                        Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs, ;
                                        QtFaseAnt, Ps2FaseAnt, PsFaseAnt, Amarracao, Visivel, NChkSep, CarCompos) ;
                                VALUES (Mats, UniCompos, DCompos, CGrus, loc_nOp, 1, .T., loc_nOp, ;
                                        Qtds, Pesos, loc_cTpOp, loc_nLote, Peso2s, [], [], CUniPs, ;
                                        Qtds, Peso2s, Pesos, loc_nAmarraX, .T., .T., .T.)

                    *-- Grade de material agregado (Rateio=3, Visivel=.F.)
                    INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                        Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs, ;
                                        QtFaseAnt, Ps2FaseAnt, PsFaseAnt, Amarracao, Visivel) ;
                                VALUES (Mats, UniCompos, DCompos, CGrus, loc_nOp, 3, .T., loc_nOp, ;
                                        Qtds, Pesos, loc_cTpOp, loc_nLote, Peso2s, [], [], CUniPs, ;
                                        Qtds, Peso2s, Pesos, loc_nAmarraX, .F.)
                ENDIF
            ENDSCAN

            IF USED("cursor_4c_TmpPrCpo")
                USE IN cursor_4c_TmpPrCpo
            ENDIF

            *-- Busca e lanca o material principal do semiacabado na grade
            loc_cSQL = "SELECT b.Cpros, b.DPros, b.Cgrus, b.Cunis, b.CuniPs " + ;
                       "FROM SigCdPro a " + ;
                       "INNER JOIN SigCdPro b ON a.MatPrincs = b.Cpros " + ;
                       "WHERE a.Cpros = '" + loc_cMat + "'"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")

            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpPro")
                INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                    Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs, ;
                                    QtFaseAnt, Ps2FaseAnt, PsFaseAnt, Amarracao, Visivel, NChkSep, CarCompos) ;
                             VALUES (cursor_4c_TmpPro.Cpros, cursor_4c_TmpPro.Cunis, ;
                                     cursor_4c_TmpPro.DPros, cursor_4c_TmpPro.Cgrus, ;
                                     loc_nOp, 1, .T., loc_nOp, ;
                                     loc_nQtdAnt - loc_nPesoTot, loc_nPesoAnt - loc_nPesoTot, ;
                                     loc_cTpOp, loc_nLote, 0, [], [], cursor_4c_TmpPro.CuniPs, ;
                                     loc_nQtdAnt - loc_nPesoTot, 0, loc_nPesoAnt - loc_nPesoTot, ;
                                     loc_nAmarraX, .T., .T., .T.)

                *-- Copia para grade de agregados (Rateio=3, Visivel=.F.)
                SELECT xNensi
                GO BOTTOM
                SCATTER MEMO MEMVAR
                m.Visivel  = .F.
                m.NChkSep  = .F.
                m.Rateio   = 3
                INSERT INTO xNensi FROM MEMVAR
            ENDIF

            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF

            *-- Amarra o semiacabado original com os componentes
            SELECT xNensi
            GO loc_nReg
            REPLACE Amarracao WITH loc_nAmarraX, CarCompos WITH .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao desmembrar composi" + CHR(231) + CHR(227) + "o")
            loc_nNovoCtrlAgrega = -1
        ENDTRY

        RETURN loc_nNovoCtrlAgrega
    ENDPROC

    *==========================================================================
    * ProcessarPerdaPeso - Gerencia navegacao e insercao apos edicao de peso
    * Replica logica do PROCEDURE lostpeso do legado (SIGPDMP2)
    * par_cAliasTmpNens: alias do cursor TmpNens
    * par_cAliasOpd:     alias do cursor crSigCdOpd
    * par_lInfoLote:     flag se OP usa controle de lote
    * par_lInserirAuto:  valor do Chk_InserirAuto
    * par_lRepeteMat:    valor do Chk_RepeteMat
    * par_cObsAnterior:  TpOps da linha anterior (ObsAnterior)
    * Retorna .T. se processou com sucesso
    *==========================================================================
    PROCEDURE ProcessarPerdaPeso(par_cAliasTmpNens, par_cAliasOpd, par_lInfoLote, ;
                                  par_lInserirAuto, par_lRepeteMat, par_cObsAnterior)
        LOCAL loc_lSucesso, loc_cSQL
        LOCAL loc_cMats, loc_cTpOps, loc_nNops, loc_nNenv, loc_nRecno

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi") OR !USED(par_cAliasTmpNens) OR !USED(par_cAliasOpd)
                loc_lSucesso = loc_lSucesso
            ENDIF

            IF par_lInfoLote
                loc_lSucesso = .T.
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT (par_cAliasOpd)
            LOCAL loc_nPesoFixs, loc_cMatPads
            loc_nPesoFixs = PesoFixs
            loc_cMatPads  = MatPads

            SELECT xNensi

            *-- Se PesoFixs=2 e material principal definido, insere linha do mat principal
            IF (loc_nPesoFixs = 2) AND !FlagIncs AND !EMPTY(ALLTRIM(MatPrincs))
                loc_cMats  = ALLTRIM(MatPrincs)
                loc_cTpOps = ALLTRIM(TpOps)
                loc_nNops  = Nops
                loc_nNenv  = Nenvs
                loc_nRecno = RECNO()

                loc_cSQL = "SELECT CUnis, DPros, CGrus FROM SigCdPro WHERE Cpros = '" + loc_cMats + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0 AND !EOF("cursor_4c_LocalPro")
                    SELECT xNensi
                    SET ORDER TO NopCMat
                    IF !SEEK(STR(loc_nNops, 10) + loc_cMats)
                        INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                            Qtds, Pesos, TpOps) ;
                                     VALUES (loc_cMats, cursor_4c_LocalPro.Cunis, ;
                                             cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CGrus, ;
                                             loc_nNops, 2, .F., loc_nNenv, 0, 0, loc_cTpOps)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF

                SELECT xNensi
                SET ORDER TO Editar
                GO loc_nRecno
            ENDIF

            *-- Avanca para proxima linha; se EOF e InserirAuto, insere nova
            SELECT xNensi
            IF !EOF()
                SKIP
            ENDIF

            IF EOF()
                IF par_lInserirAuto
                    SELECT (par_cAliasTmpNens)
                    LOCAL loc_cEmpsAI, loc_cDoppsAI, loc_nNumpsAI
                    loc_cEmpsAI  = Emps
                    loc_cDoppsAI = Dopps
                    loc_nNumpsAI = Numps

                    SELECT (par_cAliasOpd)
                    LOCAL loc_cTpPadraosAI
                    loc_cTpPadraosAI = TpPadraos

                    SELECT xNensi
                    INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                                 VALUES (loc_cEmpsAI, loc_cDoppsAI, loc_nNumpsAI, .T., 5, .T., ;
                                         loc_cTpPadraosAI, .T.)
                    SET ORDER TO Editar
                    GO BOTTOM

                    *-- Preenche CMats com material padrao se linha em branco
                    IF EMPTY(ALLTRIM(CMats)) AND EMPTY(ALLTRIM(NVL(TRANSFORM(Nops), "")))
                        LOCAL loc_cMatPad
                        loc_cMatPad = IIF(EMPTY(ALLTRIM(loc_cMatPads)), "", ALLTRIM(loc_cMatPads))
                        IF !EMPTY(loc_cMatPad)
                            REPLACE CMats WITH loc_cMatPad
                        ENDIF
                    ENDIF

                    IF par_lRepeteMat AND !EMPTY(ALLTRIM(par_cObsAnterior))
                        REPLACE TpOps WITH par_cObsAnterior
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar perda de peso")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarLotes - Carrega lotes pendentes do funcionario (cmdLotes.Click)
    * par_cGrupoOs: GrupoOs do TmpNens
    * par_cContaOs: ContaOs do TmpNens
    * Cursor resultado: cursor_4c_Lotes (nLotes N, CMats C, Saldo N)
    * Retorna .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE BuscarLotes(par_cGrupoOs, par_cContaOs)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_nLote

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Lotes")
                USE IN cursor_4c_Lotes
            ENDIF

            *-- Busca lotes nao encerrados (chksubn = 0/false)
            loc_cSQL = "SELECT nLotes FROM SigPdNlt " + ;
                       "WHERE chksubn = 0 " + ;
                       "AND Grupos = '" + ALLTRIM(par_cGrupoOs) + "' " + ;
                       "AND Contas = '" + ALLTRIM(par_cContaOs) + "' " + ;
                       "ORDER BY nlotes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNlt")
            IF loc_nResult < 1
                MsgErro("Falha na Conex" + CHR(227) + "o (Localnlt)", "Erro")
                loc_lSucesso = loc_lSucesso
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Lotes (nLotes N(10,0) NULL, CMats C(14) NULL, Saldo N(12,3) NULL)
            SET NULL OFF

            SELECT cursor_4c_LocalNlt
            SCAN
                loc_nLote = cursor_4c_LocalNlt.nLotes

                *-- Para cada lote, calcula saldo via movimentacao
                loc_cSQL = "SELECT a.CMats, " + ;
                           "SUM(CASE WHEN a.EntSais = 'E' THEN a.Qtds ELSE -a.Qtds END) AS Saldo " + ;
                           "FROM SigPdNlm a " + ;
                           "WHERE a.nLotes = " + TRANSFORM(loc_nLote) + " " + ;
                           "GROUP BY a.CMats " + ;
                           "HAVING SUM(CASE WHEN a.EntSais = 'E' THEN a.Qtds ELSE -a.Qtds END) > 0"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpLote") > 0
                    SELECT cursor_4c_TmpLote
                    SCAN
                        SELECT cursor_4c_Lotes
                        INSERT INTO cursor_4c_Lotes (nLotes, CMats, Saldo) ;
                                             VALUES (loc_nLote, cursor_4c_TmpLote.CMats, ;
                                                     cursor_4c_TmpLote.Saldo)
                        SELECT cursor_4c_TmpLote
                    ENDSCAN
                    IF USED("cursor_4c_TmpLote")
                        USE IN cursor_4c_TmpLote
                    ENDIF
                ENDIF
            ENDSCAN

            IF USED("cursor_4c_LocalNlt")
                USE IN cursor_4c_LocalNlt
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar lotes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EncerraPCC - Processa encerramento PCC: agrega materiais com variacao
    * Replica logica do EncerraPCC.Click do legado (SIGPDMP2)
    * par_cAliasOpd: alias do cursor crSigCdOpd
    * par_cOuros:    codigo do material "ouro" / material padrao a excluir
    * Retorna .T. se processou com sucesso
    *==========================================================================
    PROCEDURE EncerraPCC(par_cAliasOpd, par_cOuros)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cMatAtual

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                loc_lSucesso = loc_lSucesso
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpX (CMats C(14) NULL, Qtds N(12,3) NULL, Pesos N(12,3) NULL)
            SET NULL OFF

            INDEX ON CMats TAG CMats

            *-- Acumula totais por material com variacao
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF EMPTY(ALLTRIM(CMats)) OR ALLTRIM(CMats) = ALLTRIM(par_cOuros)
                    LOOP
                ENDIF

                loc_cSQL = "SELECT Varias FROM SigCdPro WHERE Cpros = '" + ALLTRIM(CMats) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalProPCC")

                IF loc_nResult > 0 AND !EOF("cursor_4c_LocalProPCC")
                    IF cursor_4c_LocalProPCC.Varias <> 1
                        IF USED("cursor_4c_LocalProPCC")
                            USE IN cursor_4c_LocalProPCC
                        ENDIF
                        LOOP
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalProPCC")
                    USE IN cursor_4c_LocalProPCC
                ENDIF

                SELECT xNensi
                loc_cMatAtual = ALLTRIM(CMats)

                SELECT cursor_4c_TmpX
                IF !SEEK(loc_cMatAtual)
                    INSERT INTO cursor_4c_TmpX (CMats, Qtds, Pesos) VALUES (loc_cMatAtual, 0, 0)
                    SEEK loc_cMatAtual
                ENDIF
                REPLACE Qtds  WITH NVL(Qtds,  0) + xNensi.QtFaseAnt, ;
                        Pesos WITH NVL(Pesos, 0) + xNensi.PsFaseAnt
                SELECT xNensi
            ENDSCAN

            *-- Insere linhas para cada material com saldo > 0
            SELECT cursor_4c_TmpX
            SCAN
                IF NVL(Qtds, 0) = 0
                    LOOP
                ENDIF

                LOCAL loc_nQtdX, loc_nPesoX
                loc_cMatAtual = ALLTRIM(CMats)
                loc_nQtdX     = NVL(Qtds, 0)
                loc_nPesoX    = NVL(Pesos, 0)

                loc_cSQL = "SELECT Cpros, DPros, Cgrus, Cunis, CuniPs FROM SigCdPro " + ;
                           "WHERE Cpros = '" + loc_cMatAtual + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProPCC")

                IF loc_nResult > 0 AND !EOF("cursor_4c_ProPCC")
                    INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                        Qtds, Pesos, TpOps, nLotes, Visivel, NChkSep) ;
                                 VALUES (cursor_4c_ProPCC.Cpros, cursor_4c_ProPCC.Cunis, ;
                                         cursor_4c_ProPCC.DPros,  cursor_4c_ProPCC.Cgrus, ;
                                         0, 5, .T., 0, loc_nQtdX, loc_nPesoX, ;
                                         SPACE(4), 0, .T., .T.)
                ENDIF
                IF USED("cursor_4c_ProPCC")
                    USE IN cursor_4c_ProPCC
                ENDIF
            ENDSCAN

            IF USED("cursor_4c_TmpX")
                USE IN cursor_4c_TmpX
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar PCC")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


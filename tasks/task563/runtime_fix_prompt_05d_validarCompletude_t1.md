# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGMVCMV.prg] Indicador de pendencia: *   - grade vazia (nenhuma operacao financeira pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCMV.prg):
*==============================================================================
* FormSIGMVCMV.prg - Processamento para Lancamentos de Centro de Custos
*                     nao lancados
* Origem: SIGMVCMV.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL (form de processamento em lote, SEM PageFrame Lista/Dados -
*       layout customizado: cabecalho + filtros de periodo/moeda/empresa +
*       grade de selecao de operacoes + botao Processar/Encerrar)
*
* FASE 4/8 - Grid de selecao de operacoes (grd_4c_Dados, espelha grdOperacaos
* + cursor csOperacaos do legado) e botoes Processar/Encerrar/Marcar-Desmarcar.
* Campos de filtro (Fases 5-6) e a logica pesada de processamento/validacao
* (Fases 7-8) sao adicionados nas fases seguintes - THIS.Processamento() e
* THIS.LimparTela() (equivalentes a ThisForm.Processamento/Limpatela do
* legado) sao chamados a partir daqui mas implementados so na Fase 7/8.
*
* FASE 5/8 - Primeira metade dos campos de filtro (grupo Periodo: getDtInicial/
* getDtFinal/Say1/Say6 + grupo Moeda: get_cd_moeda/lbl_moeda/get_ds_moeda),
* espelhando as posicoes exatas do SIGMVCMV.SCX original (form OPERACIONAL sem
* PageFrame - controles direto no form, sem compensacao de +29). Os handlers
* Valid com lookup (fwBuscaExt de moeda) e fAcessoEmpresa ficam para a Fase
* 7/8, junto com Processamento()/LimparTela() - nesta fase os campos apenas
* existem e aceitam digitacao livre.
*
* FASE 7/8 - LimparTela() (transcricao direta do PROCEDURE limpatela legado)
* e Processamento() (delega ao motor SIGMVCMVBO.ProcessarLancamentos, que
* implementa o PROCEDURE processamento + fazcontra legado - geracao dos
* pares de lancamento D/C em SigMvCcr a partir do custo das operacoes
* financeiras marcadas, com conversao de moeda). O BO ja reporta sucesso/
* erro/aviso em cada caminho (regra #20 CLAUDE.md); o form so trata o aviso
* das operacoes que pedem visualizacao de titulos (VisTit = 1; a tela
* SigMvTi2 do legado esta fora do acervo desta migracao).
*==============================================================================

DEFINE CLASS FormSIGMVCMV AS FormBase

    *-- Propriedades visuais (copiadas EXATAS do original SIGMVCMV.SCX)
    Height       = 323
    Width        = 800
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Processamento para o Lan" + CHR(231) + "amentos de Centro de Custos n" + CHR(227) + "o lan" + CHR(231) + "ados"

    *==========================================================================
    * Init - apenas DODEFAULT (FormBase.Init ja chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - cria o Business Object, valida a conexao e monta a
    * estrutura visual base (cabecalho). Grid, botoes e campos de filtro sao
    * adicionados nas fases seguintes.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso = .F.
        loc_lProsseguir = .T.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SIGMVCMVBO")

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                        "o com Servidor de Banco de Dados.", ;
                        "Conex" + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CriarCursorOperacoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarCamposPeriodoMoeda()
                THIS.ConfigurarCamposEmpresaOperacao()
                THIS.ConfigurarBotoesGrade()
                THIS.ConfigurarGrid()
                THIS.CarregarLista()
                THIS.TornarControlesVisiveis()
                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Monta o cabecalho cinza (cntSombra do legado).
    * Form OPERACIONAL sem PageFrame Lista/Dados: o cabecalho e um container
    * direto no form, equivalente ao SIGMVCMV.cntSombra original.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .WordWrap  = .T.
                    .Alignment = 0
                    .BackStyle = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = THIS.Caption
                ENDWITH

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .Top       = 17
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .WordWrap  = .T.
                    .Alignment = 0
                    .BackStyle = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = THIS.Caption
                ENDWITH

                .Visible = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (que nascem com Visible = .F. por padrao)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oErro

        TRY
            THIS.TornarVisivelRecursivo(THIS)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarVisivelRecursivo - Percorre o container recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
        LOCAL loc_nI, loc_oCtrl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarVisivelRecursivo(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CriarCursorOperacoes - Cria o cursor de trabalho da grade de selecao de
    * operacoes (espelha "Create Cursor csOperacaos (Marcas l(1), Operacaos
    * c(20), VisTit n(1))" + "Index on Operacaos Tag Operacaos" do PROCEDURE
    * Load do legado). Estrutura fixa, reaproveitada em todas as fases
    * seguintes que popularem o cursor - a ORDEM dos campos NUNCA muda.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorOperacoes()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        CREATE CURSOR (loc_cCursor) (Marcas L(1), Operacaos C(20), VisTit N(1))
        SELECT (loc_cCursor)
        INDEX ON Operacaos TAG Operacaos
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Shape decorativo + botoes Processar/Encerrar,
    * posicionados diretamente no form (fora de container), EXATAMENTE como
    * no SIGMVCMV.SCX original (Shape1/Processa/Cancela).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = -2
            .Left          = 644
            .Height        = 37
            .Width         = 52
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top             = 3
            .Left            = 649
            .Height          = 75
            .Width           = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "\<Processar"
            .FontName        = "Comic Sans MS"
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
            .TabIndex        = 14
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 724
            .Height          = 75
            .Width           = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .FontName        = "Comic Sans MS"
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
            .TabIndex        = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPeriodoMoeda - Primeira metade dos campos de filtro
    * (Fase 5/8): grupo Periodo (getDtInicial/getDtFinal/Say1/Say6) e grupo
    * Moeda para Conversao (get_cd_moeda/lbl_moeda/get_ds_moeda). Controles
    * direto no form (sem container/PageFrame), posicoes EXATAS do SCX
    * original - form OPERACIONAL nao usa a compensacao de +29 do PageFrame
    * de forms CRUD. Handlers de Valid/lookup (fwBuscaExt de moeda) sao
    * implementados na Fase 7/8, junto com Processamento()/LimparTela().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPeriodoMoeda()
        *-- Say1 "Periodo :"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 92
            .Left      = 99
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "odo :"
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- getDtInicial
        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Top           = 88
            .Left          = 154
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Value         = {}
            .TabIndex      = 2
            .Visible       = .T.
        ENDWITH

        *-- Say6 "ate"
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 92
            .Left      = 242
            .Width     = 25
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "at" + CHR(233)
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        *-- getDtFinal
        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top           = 88
            .Left          = 268
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Value         = {}
            .TabIndex      = 4
            .Visible       = .T.
        ENDWITH

        *-- lbl_moeda "Moeda para Conversao:"
        THIS.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH THIS.lbl_4c_Lbl_moeda
            .Top       = 142
            .Left      = 26
            .Width     = 155
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda para Convers" + CHR(227) + "o:"
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH

        *-- get_cd_moeda (codigo da moeda de conversao, lookup F4 na Fase 7/8)
        THIS.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH THIS.txt_4c__cd_moeda
            .Top           = 138
            .Left          = 154
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Value         = ""
            .TabIndex      = 9
            .Visible       = .T.
        ENDWITH

        *-- get_ds_moeda (descricao da moeda, preenchida pelo lookup na Fase 7/8)
        THIS.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH THIS.txt_4c__ds_moeda
            .Top           = 138
            .Left          = 187
            .Width         = 115
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Value         = ""
            .TabIndex      = 10
            .Visible       = .T.
        ENDWITH

        *-- Lookup de moeda (F4/Enter/Tab) - espelha o Valid original de
        *-- get_cd_moeda/get_ds_moeda (fwBuscaExt por CMOES/DMOES em SigCdMoe)
        BINDEVENT(THIS.txt_4c__cd_moeda, "KeyPress", THIS, "ValidarMoeda")
        BINDEVENT(THIS.txt_4c__ds_moeda, "KeyPress", THIS, "ValidarMoedaDesc")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposEmpresaOperacao - Segunda metade dos campos de filtro
    * (Fase 6/8): grupo Empresa (lbl_empresa/getEmpresa/getDEmpresa) e o
    * label lbl_operacao ("Operacao :") que antecede a grade de selecao.
    * Posicoes EXATAS do SIGMVCMV.SCX original. O legado usa fAcessoEmpresa()
    * (funcao global Fortyus NAO portada) para os Valid de getEmpresa/
    * getDEmpresa - substituido pelo lookup canonico em SigCdEmp (cemps/
    * razas), implementado em ValidarEmpresa/ValidarDEmpresa/AbrirBuscaEmpresa.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposEmpresaOperacao()
        *-- lbl_empresa "Empresa :"
        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Top       = 118
            .Left      = 94
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Empresa :"
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        *-- getEmpresa (codigo da empresa, lookup em SigCdEmp.cemps)
        THIS.AddObject("txt_4c_Empresa", "TextBox")
        WITH THIS.txt_4c_Empresa
            .Top           = 113
            .Left          = 154
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Value         = ""
            .TabIndex      = 6
            .Visible       = .T.
        ENDWITH

        *-- getDEmpresa (razao social da empresa, preenchida pelo lookup)
        THIS.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH THIS.txt_4c_DEmpresa
            .Top           = 113
            .Left          = 187
            .Width         = 339
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Value         = ""
            .TabIndex      = 7
            .Visible       = .T.
        ENDWITH

        BINDEVENT(THIS.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")
        BINDEVENT(THIS.txt_4c_DEmpresa, "KeyPress", THIS, "ValidarDEmpresa")

        *-- lbl_operacao "Operacao :" (antecede a grade de selecao)
        THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
        WITH THIS.lbl_4c_Lbl_operacao
            .Top       = 167
            .Left      = 88
            .Width     = 56
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .TabIndex  = 11
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesGrade - CommandGroup "Selecionar/Desmarcar" ao lado da
    * grade (espelha cmdBtnGrade.Command1=btnMarcaTudo / Command2=btnDesmarcar
    * do legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesGrade()
        THIS.AddObject("obj_4c_CmdBtnGrade", "CommandGroup")
        WITH THIS.obj_4c_CmdBtnGrade
            .Top         = 193
            .Left        = 406
            .Width       = 43
            .Height      = 91
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 1
            .TabIndex    = 13

            WITH .Buttons(1)
                .Top         = -1
                .Left        = -1
                .Height      = 45
                .Width       = 45
                .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Caption     = ""
                .ToolTipText = "Selecionar"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .TabIndex    = 1
            ENDWITH

            WITH .Buttons(2)
                .Top         = 45
                .Left        = -1
                .Height      = 45
                .Width       = 45
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption     = ""
                .ToolTipText = "Desmarcar"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .TabIndex    = 2
            ENDWITH

            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.obj_4c_CmdBtnGrade, "Click", THIS, "CmdBtnGradeClick")
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grade de selecao de operacoes (espelha o With
    * Thisform.grdOperacaos do PROCEDURE Init original). ColumnCount=3 e
    * RecordSource sao setados ANTES das propriedades de Column1/Column2,
    * exatamente na ordem do legado - evita o reset de Width/CurrentControl
    * que uma reatribuicao POSTERIOR de RecordSource causaria.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount       = 3
            .RecordSource      = loc_cCursor
            .HeaderHeight      = 0
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .Top               = 165
            .Left              = 154
            .Width             = 247
            .Height            = 148
            .FontName          = "Tahoma"
            .FontSize          = 8
            .RowHeight         = 18
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .TabIndex          = 12

            .Column1.Width        = 15
            .Column1.ControlSource = loc_cCursor + ".Marcas"
            .Column1.FontName     = "Courier New"
            .Column1.Movable      = .F.
            .Column1.Resizable    = .F.

            .Column1.AddObject("chk_4c_Check1", "CheckBox")
            WITH .Column1.chk_4c_Check1
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
                .FontName  = "Tahoma"
                .Alignment = 0
                .Caption   = ""
                .Visible   = .T.
                .AutoSize  = .T.
            ENDWITH
            .Column1.CurrentControl = "chk_4c_Check1"
            .Column1.Sparse         = .F.
            .Column1.ReadOnly       = .F.

            .Column2.Width         = 210
            .Column2.ControlSource = loc_cCursor + ".Operacaos"
            .Column2.FontName      = "Courier New"
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.ReadOnly      = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BorderStyle = 1
            .Column2.Text1.Margin      = 0

            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click", THIS, "ChkMarcasClick")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress", THIS, "ChkMarcasKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseUp", THIS, "ChkMarcasMouseUp")
    ENDPROC

    *==========================================================================
    * CarregarLista - PUBLIC (o harness de teste chama direto no oForm, e o
    * metodo tambem e' acionado pela propria tela). Popula a grade de selecao de
    * operacoes, espelhando o bloco do PROCEDURE Init legado:
    *
    *   Select crSigOpFin
    *   Scan
    *       Insert Into csOperacaos (Marcas, Operacaos, VisTit) ;
    *           Values (.T., crSigOpFin.Dopes, crSigOpFin.VisTit)
    *   Endscan
    *   Select csOperacaos
    *   Go Top
    *
    * Todas as linhas nascem MARCADAS (.T.), exatamente como no legado - o
    * usuario desmarca o que nao quer processar. O cursor da grade e' ZAPado
    * (nunca fechado/recriado): fechar quebraria o RecordSource do grid e
    * resetaria Column.Width/CurrentControl/Sparse ja configurados.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cCursor, loc_cOrigem, loc_nArea, loc_cDopes, loc_nVisTit, loc_oErro

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
            loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
            loc_nArea   = SELECT()

            IF !USED(loc_cCursor)
                THIS.CriarCursorOperacoes()
            ENDIF

            SELECT (loc_cCursor)
            ZAP

            *-- Sem conexao (modo de validacao de UI) a grade fica vazia, mas
            *-- o form abre normalmente - nao ha SQL para executar
            IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
                    AND THIS.this_oBusinessObject.CarregarOperacoes() ;
                    AND USED(loc_cOrigem)

                SELECT (loc_cOrigem)
                GO TOP
                DO WHILE !EOF(loc_cOrigem)
                    loc_cDopes  = EVALUATE(loc_cOrigem + ".Dopes")
                    loc_nVisTit = NVL(EVALUATE(loc_cOrigem + ".VisTit"), 0)

                    INSERT INTO (loc_cCursor) (Marcas, Operacaos, VisTit) ;
                        VALUES (.T., loc_cDopes, loc_nVisTit)

                    SELECT (loc_cOrigem)
                    SKIP
                ENDDO
            ENDIF

            *-- Popular o cursor NAO repinta a grade: o legado sempre fecha com
            *-- "Select csOperacaos / Go Top" + Refresh (regra #21 CLAUDE.md)
            SELECT (loc_cCursor)
            GO TOP
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            IF loc_nArea > 0
                SELECT (loc_nArea)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkMarcasClick / ChkMarcasKeyPress / ChkMarcasMouseDown / ChkMarcasMouseUp
    * PUBLIC (BINDEVENT exige metodo publico - regra #3 CLAUDE.md). Espelham
    * SIGMVCMV.grdOperacaos.Column1.Check1 do legado: o toggle acontece no
    * KeyPress (Enter/Espaco) e no MouseDown; Click e MouseUp apenas suprimem
    * o comportamento nativo (NoDefault) para nao alternar em duplicidade.
    * NAO transcrito: o ramo "If nKeyCode = 9 -> ThisForm.opt_nr_tipo.Option1.
    * SetFocus" do KeyPress legado - opt_nr_tipo nao existe neste form (nao
    * consta na arvore de objetos do SIGMVCMV.SCX), e' codigo morto herdado
    * de copy-paste de outro form; reproduzi-lo quebraria com "Property
    * OPT_NR_TIPO is not found" ao pressionar Tab.
    *==========================================================================
    PROCEDURE ChkMarcasClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor, loc_nAreaAnterior

        IF INLIST(par_nKeyCode, 13, 32)
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
            IF USED(loc_cCursor)
                loc_nAreaAnterior = SELECT()
                SELECT (loc_cCursor)
                IF !EOF()
                    REPLACE Marcas WITH !Marcas
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                SELECT (loc_nAreaAnterior)
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        LOCAL loc_cCursor, loc_nAreaAnterior

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
        IF USED(loc_cCursor)
            loc_nAreaAnterior = SELECT()
            SELECT (loc_cCursor)
            IF !EOF()
                REPLACE Marcas WITH !Marcas
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            SELECT (loc_nAreaAnterior)
        ENDIF
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * CmdBtnGradeClick - PUBLIC (BINDEVENT). Marca/desmarca TODAS as linhas
    * da grade (espelha SIGMVCMV.cmdBtnGrade.Click: Value=1 -> btnMarcaTudo,
    * Value=2 -> btnDesmarcar).
    *==========================================================================
    PROCEDURE CmdBtnGradeClick()
        LOCAL loc_cCursor, loc_nAreaAnterior

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_nAreaAnterior = SELECT()
        SELECT (loc_cCursor)

        DO CASE
            CASE THIS.obj_4c_CmdBtnGrade.Value = 1
                REPLACE ALL Marcas WITH .T.
                GO TOP
                THIS.grd_4c_Dados.Refresh()
            CASE THIS.obj_4c_CmdBtnGrade.Value = 2
                REPLACE ALL Marcas WITH .F.
                GO TOP
                THIS.grd_4c_Dados.Refresh()
        ENDCASE

        SELECT (loc_nAreaAnterior)
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Cancela.Click
    * ("Thisform.Release").
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnProcessaClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Processa.Click:
    * valida periodo informado + pelo menos uma operacao marcada + confirma,
    * depois delega para THIS.Processamento() e limpa a tela com
    * THIS.LimparTela(), na MESMA ordem do legado ("=ThisForm.Processamento()"
    * seguido de "=ThisForm.Limpatela()").
    *
    * FASE 8/8: a tela e' TRAVADA (HabilitarCampos(.F.)) durante o lote e
    * destravada logo apos - o processamento percorre todas as operacoes
    * marcadas gravando pares D/C em SigMvCcr e, sem o travamento, o usuario
    * consegue acionar Processar/marcar a grade no meio da gravacao. O
    * destravamento nao depende do resultado: Processamento() trata o proprio
    * erro no CATCH e nunca propaga, entao a linha seguinte sempre executa.
    *==========================================================================
    PROCEDURE BtnProcessaClick()
        LOCAL loc_cCursor, loc_lConfirmou

        IF EMPTY(THIS.txt_4c_DtInicial.Value) OR EMPTY(THIS.txt_4c_DtFinal.Value)
            MsgAviso("Favor Informar o Per" + CHR(237) + "odo.", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_DtInicial.SetFocus()
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        LOCATE FOR Marcas = .T.
        IF !FOUND()
            MsgAviso("Selecione uma Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.grd_4c_Dados.Column1.SetFocus()
            RETURN
        ENDIF

        loc_lConfirmou = MsgConfirma("Confirma o Processamento?", "Aten" + CHR(231) + CHR(227) + "o")
        IF !loc_lConfirmou
            RETURN
        ENDIF

        THIS.HabilitarCampos(.F.)
        THIS.Processamento()
        THIS.HabilitarCampos(.T.)

        THIS.LimparTela()

        *-- HabilitarCampos(.T.) reabilita tudo sem olhar a grade; este
        *-- AjustarBotoesPorModo devolve o estado REAL (grade vazia volta a
        *-- desabilitar Processar/Marcar). A grade NAO e' recarregada: no
        *-- legado csOperacaos e' montado UMA vez no Init (lista de operacoes
        *-- financeiras do cadastro, que o processamento nao altera), e
        *-- recarregar aqui remarcaria tudo com .T., jogando fora a selecao
        *-- que o usuario acabou de fazer.
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * LimparTela - PUBLIC (chamado por BtnProcessaClick e pelo harness de
    * teste). Espelha o PROCEDURE limpatela do legado: limpa os campos de
    * filtro (periodo, moeda, empresa) apos o processamento.
    *==========================================================================
    PROCEDURE LimparTela()
        LOCAL loc_oBO

        *-- Os seis filtros vivem no BO (fonte unica): zerar la' e deixar
        *-- BOParaForm escrever na tela reproduz exatamente o legado, que
        *-- atribui "" / Ctod('') aos seis campos e chama Refresh em cada um.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject
            loc_oBO.this_dDataInicial = {}
            loc_oBO.this_dDataFinal   = {}
            loc_oBO.this_cCdMoeda     = ""
            loc_oBO.this_cDsMoeda     = ""
            loc_oBO.this_cCdEmpresa   = ""
            loc_oBO.this_cDsEmpresa   = ""
        ENDIF

        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * Processamento - PUBLIC (chamado por BtnProcessaClick e pelo harness de
    * teste). Delega a geracao dos lancamentos D/C ao BO
    * (SIGMVCMVBO.ProcessarLancamentos) - que ja exibe MsgInfo/MsgErro/
    * MsgAviso em cada caminho de sucesso/falha (regra #20 CLAUDE.md: BO ja
    * reporta, o form nao precisa de ELSE duplicando a mensagem). So resta
    * ao form avisar sobre as operacoes que pedem visualizacao de titulos
    * (VisTit = 1): a tela SigMvTi2 do legado esta fora do acervo desta
    * migracao (ver SIGMVCMVBO.ContarOperacoesVisTit).
    *==========================================================================
    PROCEDURE Processamento()
        LOCAL loc_lSucesso, loc_oErro

        TRY
            *-- FormParaBO transfere os seis filtros da tela para o BO e
            *-- valida o periodo; sem ele o lote rodaria com os valores da
            *-- execucao anterior (o form OPERACIONAL nao fecha entre um
            *-- processamento e outro).
            IF THIS.FormParaBO()
                loc_lSucesso = THIS.this_oBusinessObject.ProcessarLancamentos( ;
                    THIS.this_oBusinessObject.this_dDataInicial, ;
                    THIS.this_oBusinessObject.this_dDataFinal, ;
                    THIS.this_oBusinessObject.this_cCdEmpresa, ;
                    THIS.this_oBusinessObject.this_cCdMoeda)
            ENDIF

            IF loc_lSucesso AND THIS.this_oBusinessObject.this_nQtdVisTit > 0
                MsgAviso("Existem " + ALLTRIM(STR(THIS.this_oBusinessObject.this_nQtdVisTit)) + ;
                    " opera" + CHR(231) + CHR(245) + "o(" + CHR(245) + "es) marcada(s) que exige(m) " + ;
                    "visualiza" + CHR(231) + CHR(227) + "o de t" + CHR(237) + "tulos - tela ainda " + ;
                    "n" + CHR(227) + "o migrada (SigMvTi2). Consulte os t" + CHR(237) + "tulos " + ;
                    "diretamente no m" + CHR(243) + "dulo financeiro.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Processamento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarMoeda - PUBLIC (BINDEVENT KeyPress em txt_4c__cd_moeda). Espelha
    * o Valid original de get_cd_moeda: campo vazio limpa a descricao; digitado
    * tenta match exato em SigCdMoe.cmoes e, sem achar, delega para
    * AbrirBuscaMoeda (fwBuscaExt do legado ja mostrava o picker sempre que
    * nao achava registro exato).
    *==========================================================================
    PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__cd_moeda.Value))

        IF EMPTY(loc_cValor)
            THIS.txt_4c__ds_moeda.Value = ""
            THIS.txt_4c__ds_moeda.Refresh()
            RETURN
        ENDIF

        IF USED("cursor_4c_LkpMoeda")
            USE IN cursor_4c_LkpMoeda
        ENDIF

        loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")

        IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
                RECCOUNT("cursor_4c_LkpMoeda") > 0
            THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
            THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
            USE IN cursor_4c_LkpMoeda
        ELSE
            IF USED("cursor_4c_LkpMoeda")
                USE IN cursor_4c_LkpMoeda
            ENDIF
            THIS.AbrirBuscaMoeda(loc_cValor)
        ENDIF

        THIS.txt_4c__cd_moeda.Refresh()
        THIS.txt_4c__ds_moeda.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarMoedaDesc - PUBLIC (BINDEVENT KeyPress em txt_4c__ds_moeda).
    * Espelha o Valid original de get_ds_moeda: campo vazio limpa o codigo;
    * digitado tenta match exato em SigCdMoe.dmoes e, sem achar, delega para
    * AbrirBuscaMoeda.
    *==========================================================================
    PROCEDURE ValidarMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__ds_moeda.Value))

        IF EMPTY(loc_cValor)
            THIS.txt_4c__cd_moeda.Value = ""
            THIS.txt_4c__cd_moeda.Refresh()
            RETURN
        ENDIF

        IF USED("cursor_4c_LkpMoeda")
            USE IN cursor_4c_LkpMoeda
        ENDIF

        loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE dmoes = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")

        IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
                RECCOUNT("cursor_4c_LkpMoeda") > 0
            THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
            THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
            USE IN cursor_4c_LkpMoeda
        ELSE
            IF USED("cursor_4c_LkpMoeda")
                USE IN cursor_4c_LkpMoeda
            ENDIF
            THIS.AbrirBuscaMoeda(loc_cValor)
        ENDIF

        THIS.txt_4c__cd_moeda.Refresh()
        THIS.txt_4c__ds_moeda.Refresh()
    ENDPROC

    *==========================================================================
    * AbrirBuscaMoeda - PROTECTED. Abre o picker canonico (FormBase.
    * AbrirLookupCanonico) filtrado pelo valor digitado (codigo OU
    * descricao). Sem selecao (ESC), limpa os dois campos - espelha o ramo
    * "If Lastkey() = 27" do Valid original.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValorDigitado)
        LOCAL loc_lSelecionou

        loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValorDigitado, ;
            THIS.txt_4c__cd_moeda, THIS.txt_4c__ds_moeda)

        IF !loc_lSelecionou
            THIS.txt_4c__cd_moeda.Value = ""
            THIS.txt_4c__ds_moeda.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - PUBLIC (BINDEVENT KeyPress em txt_4c_Empresa). O
    * legado usa fAcessoEmpresa(Usuar, "C", This.Value, GetEmpresa, GetDEmpresa)
    * - funcao global Fortyus NAO portada para a nova arquitetura (ver
    * CLAUDE.md/skill vfp9-migration). Substituido pelo lookup canonico em
    * SigCdEmp.cemps: campo vazio limpa a razao social; digitado tenta match
    * exato e, sem achar, delega para AbrirBuscaEmpresa.
    *==========================================================================
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(UPPER(THIS.txt_4c_Empresa.Value))

        IF EMPTY(loc_cValor)
            THIS.txt_4c_DEmpresa.Value = ""
            THIS.txt_4c_DEmpresa.Refresh()
            RETURN
        ENDIF

        IF USED("cursor_4c_LkpEmpresa")
            USE IN cursor_4c_LkpEmpresa
        ENDIF

        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")

        IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
                RECCOUNT("cursor_4c_LkpEmpresa") > 0
            THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
            THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
            USE IN cursor_4c_LkpEmpresa
        ELSE
            IF USED("cursor_4c_LkpEmpresa")
                USE IN cursor_4c_LkpEmpresa
            ENDIF
            THIS.AbrirBuscaEmpresa(loc_cValor)
        ENDIF

        THIS.txt_4c_Empresa.Refresh()
        THIS.txt_4c_DEmpresa.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarDEmpresa - PUBLIC (BINDEVENT KeyPress em txt_4c_DEmpresa).
    * Espelha o When original ("Return Empty(ThisForm.getEmpresa.Value)") -
    * so processa a digitacao quando o codigo da empresa esta vazio; caso
    * contrario o campo Descricao fica so como espelho do lookup por codigo.
    *==========================================================================
    PROCEDURE ValidarDEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_Empresa.Value))
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(UPPER(THIS.txt_4c_DEmpresa.Value))

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Empresa.Value = ""
            THIS.txt_4c_Empresa.Refresh()
            RETURN
        ENDIF

        IF USED("cursor_4c_LkpEmpresa")
            USE IN cursor_4c_LkpEmpresa
        ENDIF

        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE razas = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")

        IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
                RECCOUNT("cursor_4c_LkpEmpresa") > 0
            THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
            THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
            USE IN cursor_4c_LkpEmpresa
        ELSE
            IF USED("cursor_4c_LkpEmpresa")
                USE IN cursor_4c_LkpEmpresa
            ENDIF
            THIS.AbrirBuscaEmpresa(loc_cValor)
        ENDIF

        THIS.txt_4c_Empresa.Refresh()
        THIS.txt_4c_DEmpresa.Refresh()
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - PROTECTED. Abre o picker canonico (FormBase.
    * AbrirLookupCanonico) em SigCdEmp filtrado pelo valor digitado (codigo
    * OU razao social). Sem selecao, limpa os dois campos.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaEmpresa(par_cValorDigitado)
        LOCAL loc_lSelecionou

        loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdEmp", "cemps", "razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValorDigitado, ;
            THIS.txt_4c_Empresa, THIS.txt_4c_DEmpresa)

        IF !loc_lSelecionou
            THIS.txt_4c_Empresa.Value  = ""
            THIS.txt_4c_DEmpresa.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - PROTECTED (escopo HERDADO de FormBase, que declara
    * "PROTECTED PROCEDURE FormParaBO"; em VFP9 o override de metodo
    * PROTECTED continua PROTECTED, e chamar de fora estoura "Property
    * FORMPARABO is not found" mesmo com PEMSTATUS devolvendo .T. - regra #3
    * CLAUDE.md). So e' chamado por THIS.Processamento(), que esta' dentro da
    * classe, entao o escopo herdado e' o correto aqui.
    *
    * Transfere os SEIS filtros da tela para o Business Object e valida o
    * periodo. Retorna .T. quando o BO ficou apto a processar, .F. quando
    * falta dado obrigatorio (ja exibindo o aviso e devolvendo o foco ao
    * campo, como o Processa.Click legado).
    *
    * As datas passam por ConverterParaData(): o TextBox nasce com .Value = {}
    * (DATE) mas o mesmo campo recebe DATETIME quando vem de coluna do SQL
    * Server - ProcessarLancamentos monta DATETIME(YEAR(..),MONTH(..),DAY(..))
    * e quebraria com o tipo errado (regra #16 CLAUDE.md).
    *
    * O periodo INVERTIDO (inicial > final) tambem e' barrado aqui: o legado
    * nunca chega a esse caso porque o usuario preenche em ordem, mas o
    * Between do processamento devolveria silenciosamente ZERO lancamentos e
    * a tela anunciaria "processado" sem gravar nada.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lValido, loc_dIni, loc_dFim, loc_oBO

        loc_lValido = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o inicializado.", "FormParaBO")
        ELSE
            loc_oBO  = THIS.this_oBusinessObject
            loc_dIni = ConverterParaData(THIS.txt_4c_DtInicial.Value)
            loc_dFim = ConverterParaData(THIS.txt_4c_DtFinal.Value)

            DO CASE
                CASE EMPTY(loc_dIni) OR EMPTY(loc_dFim)
                    MsgAviso("Favor Informar o Per" + CHR(237) + "odo.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.txt_4c_DtInicial.SetFocus()

                CASE loc_dIni > loc_dFim
                    MsgAviso("Data inicial maior que a data final.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.txt_4c_DtInicial.SetFocus()

                OTHERWISE
                    loc_oBO.this_dDataInicial = loc_dIni
                    loc_oBO.this_dDataFinal   = loc_dFim
                    loc_oBO.this_cCdMoeda     = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
                    loc_oBO.this_cDsMoeda     = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
                    loc_oBO.this_cCdEmpresa   = ALLTRIM(THIS.txt_4c_Empresa.Value)
                    loc_oBO.this_cDsEmpresa   = ALLTRIM(THIS.txt_4c_DEmpresa.Value)
                    loc_lValido = .T.
            ENDCASE
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * BOParaForm - PROTECTED (escopo HERDADO de FormBase, igual ao FormParaBO
    * acima). Chamado por THIS.LimparTela(), de dentro da classe.
    *
    * Caminho inverso do FormParaBO: escreve os seis filtros guardados no BO
    * de volta nos TextBox e da' Refresh em cada um, reproduzindo o bloco de
    * Refresh do PROCEDURE limpatela legado.
    *
    * E' o UNICO ponto do form que escreve nesses seis campos a partir do
    * estado do BO - LimparTela zera as propriedades e chama este metodo, em
    * vez de repetir doze atribuicoes. Com o BO ausente (falha de conexao no
    * InicializarForm) os campos sao apenas esvaziados, sem estourar.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject
            THIS.txt_4c_DtInicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
            THIS.txt_4c_DtFinal.Value   = ConverterParaData(loc_oBO.this_dDataFinal)
            THIS.txt_4c__cd_moeda.Value = loc_oBO.this_cCdMoeda
            THIS.txt_4c__ds_moeda.Value = loc_oBO.this_cDsMoeda
            THIS.txt_4c_Empresa.Value   = loc_oBO.this_cCdEmpresa
            THIS.txt_4c_DEmpresa.Value  = loc_oBO.this_cDsEmpresa
        ELSE
            THIS.txt_4c_DtInicial.Value = {}
            THIS.txt_4c_DtFinal.Value   = {}
            THIS.txt_4c__cd_moeda.Value = ""
            THIS.txt_4c__ds_moeda.Value = ""
            THIS.txt_4c_Empresa.Value   = ""
            THIS.txt_4c_DEmpresa.Value  = ""
        ENDIF

        THIS.txt_4c_DtInicial.Refresh()
        THIS.txt_4c_DtFinal.Refresh()
        THIS.txt_4c__cd_moeda.Refresh()
        THIS.txt_4c__ds_moeda.Refresh()
        THIS.txt_4c_Empresa.Refresh()
        THIS.txt_4c_DEmpresa.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - PUBLIC. Trava (.F.) / destrava (.T.) os controles de
    * entrada durante o processamento em lote. O form OPERACIONAL nao tem
    * modo INCLUIR/ALTERAR: o unico estado em que a tela fica somente-leitura
    * e' o intervalo em que ProcessarLancamentos percorre as operacoes
    * marcadas gravando os pares D/C em SigMvCcr.
    *
    * "Encerrar" NUNCA e' desabilitado - o legado deixa o Cancela sempre
    * acionavel, e desabilitar um CommandButton com icone faz o icone sumir
    * na tela (botao vira retangulo cinza).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab

        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.txt_4c_DtInicial.Enabled = loc_lHab
        THIS.txt_4c_DtFinal.Enabled   = loc_lHab
        THIS.txt_4c__cd_moeda.Enabled = loc_lHab
        THIS.txt_4c__ds_moeda.Enabled = loc_lHab
        THIS.txt_4c_Empresa.Enabled   = loc_lHab
        THIS.txt_4c_DEmpresa.Enabled  = loc_lHab

        THIS.grd_4c_Dados.Enabled          = loc_lHab
        THIS.obj_4c_CmdBtnGrade.Enabled    = loc_lHab
        THIS.cmd_4c_Processa.Enabled       = loc_lHab

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - PUBLIC (o harness de teste chama direto no oForm,
    * de FORA da classe - por isso NAO pode ser PROTECTED, regra #3
    * CLAUDE.md). Reavalia os botoes conforme o estado REAL da grade:
    *
    *   - grade vazia (nenhuma operacao financeira pendente no periodo):
    *     Processar e Marcar/Desmarcar ficam desabilitados, porque nao ha o
    *     que marcar nem o que processar;
    *   - grade com linhas: os dois habilitados.
    *
    * "Encerrar" permanece sempre habilitado (unica saida da tela, que e'
    * modal com ControlBox = .F. - desabilitar prenderia o usuario).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_cCursor, loc_lTemLinhas

        loc_lTemLinhas = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                loc_lTemLinhas = (RECCOUNT(loc_cCursor) > 0)
            ENDIF
        ENDIF

        THIS.cmd_4c_Processa.Enabled    = loc_lTemLinhas
        THIS.obj_4c_CmdBtnGrade.Enabled = loc_lTemLinhas
        THIS.grd_4c_Dados.Enabled       = loc_lTemLinhas

        THIS.cmd_4c_Cancela.Enabled = .T.
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_cCursor, loc_cOrigem

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
            IF !EMPTY(loc_cOrigem) AND USED(loc_cOrigem)
                USE IN (loc_cOrigem)
            ENDIF

            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGMVCMVBO.prg):
*==============================================================================
* SIGMVCMVBO.PRG
* Business Object - Processamento de Lancamentos de Centro de Custos
* nao lancados (SigMvCcr)
* Origem: tasks\task563\SIGMVCMV_form_codigo_fonte.txt
*==============================================================================

DEFINE CLASS SIGMVCMVBO AS BusinessBase

    *-- Filtros de processamento (espelham os campos do form)
    this_dDataInicial = {}      && getDtInicial - inicio do periodo
    this_dDataFinal = {}        && getDtFinal - fim do periodo
    this_cCdMoeda = ""          && get_cd_moeda - moeda para conversao
    this_cDsMoeda = ""          && get_ds_moeda - descricao da moeda
    this_cCdEmpresa = ""        && getEmpresa - codigo da empresa
    this_cDsEmpresa = ""        && getDEmpresa - descricao da empresa

    *-- Chave de sessao usada na composicao de cidchaves (Sigkey no legado)
    this_cChaveSessao = ""

    *-- Resultado do ultimo Processamento() (consumido pelo Form)
    this_nQtdProcessada = 0    && quantidade de pares D/C gravados
    this_nQtdVisTit = 0        && operacoes marcadas que pedem visualizacao de titulos (SigMvTi2 - nao migrado)

    *-- Nomes dos cursores de trabalho (multiplos cursores, form OPERACIONAL)
    this_cCursorOperacoes = "cursor_4c_Operacoes"   && espelha csOperacaos (grade de operacoes)
    this_cCursorAltCc = "cursor_4c_AltCc"           && espelha CrAltcc (mirror de SigMvCcr)
    this_cCursorMovimento = "cursor_4c_Movimento"   && espelha csMovimento (agregacao de custos)
    this_cCursorSigOpFin = "cursor_4c_SigOpFin"     && espelha crSigOpFin (operacoes financeiras validas)
    this_cCursorSigCdCot = "cursor_4c_SigCdCot"     && espelha crSigCdCot (cotacoes de moeda)
    this_cCursorSigCdMoe = "cursor_4c_SigCdMoe"     && espelha crSigCdMoe (moedas cadastradas)

    *-- Propriedades da entidade (mapeamento para tabela SigMvCcr - registro
    *-- de lancamento de conta corrente que o processamento insere/atualiza)
    this_cCidchaves    = ""    && cidchaves   char(20)   - PK
    this_lAutos        = .F.   && autos       bit
    this_lConcs        = .F.   && concs       bit
    this_cContages     = ""    && contages    char(10)
    this_cContas       = ""    && contas      char(10)
    this_cContems      = ""    && contems     char(10)
    this_nCotacaos     = 0     && cotacaos    numeric(15,7)
    this_dDatalts      = {}    && datalts     datetime
    this_dDatas        = {}    && datas       datetime
    this_dDataconcs    = {}    && dataconcs   datetime
    this_dDatatrans    = {}    && datatrans   datetime
    this_dDatexcs      = {}    && datexcs     datetime
    this_cDocus        = ""    && docus       char(10)
    this_cDopes        = ""    && dopes       char(20)
    this_dDtemis       = {}    && dtemis      datetime
    this_cEmps         = ""    && emps        char(3)
    this_cGrupages     = ""    && grupages    char(10)
    this_cGrupems      = ""    && grupems     char(10)
    this_cGrupos       = ""    && grupos      char(10)
    this_cHists        = ""    && hists       char(60)
    this_cLocals       = ""    && locals      char(10)
    this_cMoedas       = ""    && moedas      char(3)
    this_cNfs          = ""    && nfs         char(10)
    this_nNlancs       = 0     && nlancs      numeric(6,0)
    this_nNopers       = 0     && nopers      numeric(7,0)
    this_nNtrans       = 0     && ntrans      numeric(6,0)
    this_nNumes        = 0     && numes       numeric(6,0)
    this_cOpers        = ""    && opers       char(1) - D/C
    this_nSaldocs      = 0     && saldocs     numeric(15,2)
    this_nSaldons      = 0     && saldons     numeric(15,2)
    this_nSaldos       = 0     && saldos      numeric(15,2)
    this_cScontas      = ""    && scontas     char(10)
    this_nScotacaos    = 0     && scotacaos   numeric(15,7)
    this_cSgrupos      = ""    && sgrupos     char(10)
    this_cShists       = ""    && shists      char(40)
    this_cSmoedas      = ""    && smoedas     char(3)
    this_cSopers       = ""    && sopers      char(1) - D/C
    this_nSvalors      = 0     && svalors     numeric(11,2)
    this_cTipos        = ""    && tipos       char(1)
    this_cTitbans      = ""    && titbans     char(12)
    this_cTitulos      = ""    && titulos     char(10)
    this_cUsualts      = ""    && usualts     char(10)
    this_cUsuexcs      = ""    && usuexcs     char(10)
    this_nValliqs      = 0     && valliqs     numeric(11,2)
    this_nValocurs     = 0     && valocurs    numeric(11,2)
    this_nValors       = 0     && valors      numeric(11,2)
    this_nValpags      = 0     && valpags     numeric(11,2)
    this_dVencs        = {}    && vencs       datetime
    this_cVlancs       = ""    && vlancs      char(10)
    this_cVopers       = ""    && vopers      char(13)
    this_nContapgs     = 0     && contapgs    numeric(1,0)
    this_cDopcs        = ""    && dopcs       char(20)
    this_nNumcs        = 0     && numcs       numeric(6,0)
    this_cCotusus      = ""    && cotusus     char(10)
    this_cBcontas      = ""    && bcontas     char(10)
    this_cBgrupos      = ""    && bgrupos     char(10)
    this_nBorderos     = 0     && borderos    numeric(6,0)
    this_cHist2s       = ""    && hist2s      char(80)
    this_nIntconts     = 0     && intconts    numeric(6,0)
    this_cUsuconcs     = ""    && usuconcs    char(10)
    this_cAuditors     = ""    && auditors    char(10)
    this_dDtaudits     = {}    && dtaudits    datetime
    this_nValprev      = 0     && valprev     numeric(11,2)
    this_cEmpdopncs    = ""    && empdopncs   char(29)
    this_cEmpdopnums   = ""    && empdopnums  char(29)
    this_cGruconmoes   = ""    && gruconmoes  char(23)
    this_cPagos        = ""    && pagos       char(1)
    this_cDopotps      = ""    && dopotps     char(23)
    this_cUsupagos     = ""    && usupagos    char(10)
    this_nTitcancs     = 0     && titcancs    numeric(1,0)
    this_dDtconfs      = {}    && dtconfs     datetime
    this_cUsuconfs     = ""    && usuconfs    char(10)
    this_nNopercancs   = 0     && nopercancs  numeric(7,0)
    this_cEspecienfs   = ""    && especienfs  char(6)
    this_cJobs         = ""    && jobs        char(10)
    this_nImpostos     = 0     && impostos    numeric(11,2)
    this_nTpimpostos   = 0     && tpimpostos  numeric(2,0)
    this_cTitpais      = ""    && titpais     char(10)
    this_cEmpccs       = ""    && empccs      char(3)
    this_nRecor        = 0     && recor       numeric(1,0)
    this_cCompet       = ""    && compet      char(7)
    this_cEmpos        = ""    && empos       char(3)
    this_cOridopnums   = ""    && oridopnums  char(29)
    this_cPastas       = ""    && pastas      text
    this_cRcontas      = ""    && rcontas     char(10)
    this_cTpdocnf      = ""    && tpdocnf     char(2)

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_cChaveSessao = ""
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGMVCMVBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL/cursor de
    * trabalho (CrAltcc/cursor_4c_AltCc) para as propriedades do BO.
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar os campos
    * (regra #8 CLAUDE.md - nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "C")
                THIS.this_cContas = TratarNulo(contas, "C")
                THIS.this_cContems = TratarNulo(contems, "C")
                THIS.this_nCotacaos = TratarNulo(cotacaos, "N")
                THIS.this_dDatalts = TratarNulo(datalts, "D")
                THIS.this_dDatas = TratarNulo(datas, "D")
                THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_dDatexcs = TratarNulo(datexcs, "D")
                THIS.this_cDocus = TratarNulo(docus, "C")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_dDtemis = TratarNulo(dtemis, "D")
                THIS.this_cEmps = TratarNulo(emps, "C")
                THIS.this_cGrupages = TratarNulo(grupages, "C")
                THIS.this_cGrupems = TratarNulo(grupems, "C")
                THIS.this_cGrupos = TratarNulo(grupos, "C")
                THIS.this_cHists = TratarNulo(hists, "C")
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_cMoedas = TratarNulo(moedas, "C")
                THIS.this_cNfs = TratarNulo(nfs, "C")
                THIS.this_nNlancs = TratarNulo(nlancs, "N")
                THIS.this_nNopers = TratarNulo(nopers, "N")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_nSaldocs = TratarNulo(saldocs, "N")
                THIS.this_nSaldons = TratarNulo(saldons, "N")
                THIS.this_nSaldos = TratarNulo(saldos, "N")
                THIS.this_cScontas = TratarNulo(scontas, "C")
                THIS.this_nScotacaos = TratarNulo(scotacaos, "N")
                THIS.this_cSgrupos = TratarNulo(sgrupos, "C")
                THIS.this_cShists = TratarNulo(shists, "C")
                THIS.this_cSmoedas = TratarNulo(smoedas, "C")
                THIS.this_cSopers = TratarNulo(sopers, "C")
                THIS.this_nSvalors = TratarNulo(svalors, "N")
                THIS.this_cTipos = TratarNulo(tipos, "C")
                THIS.this_cTitbans = TratarNulo(titbans, "C")
                THIS.this_cTitulos = TratarNulo(titulos, "C")
                THIS.this_cUsualts = TratarNulo(usualts, "C")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "C")
                THIS.this_nValliqs = TratarNulo(valliqs, "N")
                THIS.this_nValocurs = TratarNulo(valocurs, "N")
                THIS.this_nValors = TratarNulo(valors, "N")
                THIS.this_nValpags = TratarNulo(valpags, "N")
                THIS.this_dVencs = TratarNulo(vencs, "D")
                THIS.this_cVlancs = TratarNulo(vlancs, "C")
                THIS.this_cVopers = TratarNulo(vopers, "C")
                THIS.this_nContapgs = TratarNulo(contapgs, "N")
                THIS.this_cDopcs = TratarNulo(dopcs, "C")
                THIS.this_nNumcs = TratarNulo(numcs, "N")
                THIS.this_cCotusus = TratarNulo(cotusus, "C")
                THIS.this_cBcontas = TratarNulo(bcontas, "C")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "C")
                THIS.this_nBorderos = TratarNulo(borderos, "N")
                THIS.this_cHist2s = TratarNulo(hist2s, "C")
                THIS.this_nIntconts = TratarNulo(intconts, "N")
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "C")
                THIS.this_cAuditors = TratarNulo(auditors, "C")
                THIS.this_dDtaudits = TratarNulo(dtaudits, "D")
                THIS.this_nValprev = TratarNulo(valprev, "N")
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                THIS.this_cPagos = TratarNulo(pagos, "C")
                THIS.this_cDopotps = TratarNulo(dopotps, "C")
                THIS.this_cUsupagos = TratarNulo(usupagos, "C")
                THIS.this_nTitcancs = TratarNulo(titcancs, "N")
                THIS.this_dDtconfs = TratarNulo(dtconfs, "D")
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "C")
                THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                THIS.this_cJobs = TratarNulo(jobs, "C")
                THIS.this_nImpostos = TratarNulo(impostos, "N")
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                THIS.this_cTitpais = TratarNulo(titpais, "C")
                THIS.this_cEmpccs = TratarNulo(empccs, "C")
                THIS.this_nRecor = TratarNulo(recor, "N")
                THIS.this_cCompet = TratarNulo(compet, "C")
                THIS.this_cEmpos = TratarNulo(empos, "C")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                THIS.this_cPastas = TratarNulo(pastas, "C")
                THIS.this_cRcontas = TratarNulo(rcontas, "C")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SIGMVCMVBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo lancamento em SigMvCcr (registro D/C gerado pelo
    * processamento em lote - fazcontra/processamento do legado). A PK
    * (cidchaves) segue a formula do legado (Dtos(Datas) + chave unica + Sigkey
    * de sessao); se o chamador nao a tiver montado ainda, cai no fallback
    * generico fUniqueIds() para nao gravar com PK vazia.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao inserir lan" + CHR(231) + "amento de centro de custos:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em SIGMVCMVBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza lancamento existente em SigMvCcr (por cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Data de alteracao
            THIS.this_dDatalts = DATETIME()

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao atualizar lan" + CHR(231) + "amento de centro de custos:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em SIGMVCMVBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula o cursor de operacoes financeiras validas
    * (espelha o bloco do PROCEDURE Init legado:
    *
    *   lcQuery = [select distinct SigOpFin.Dopes,
    *              convert(int,(substring(lbltxidCs,24,1))) as VisTit ] + ...
    *   Thisform.poDatamgr.SqlExecute(lcQuery,'crSigOpFin')
    *   Select crSigOpFin / Index On Dopes Tag Dopes / Go Top
    *
    * A query, os JOINs e os filtros (opeinatvs = 0 / contaeds <> space(11))
    * sao TRANSCRITOS do legado - sao regra de negocio (definem QUAIS operacoes
    * podem ser processadas), nao se reescrevem. A coluna VisTit sai do 24o
    * caractere de SigOpCdi.lbltxidcs, exatamente como no original.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResult, loc_cCursor, loc_cTmp, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorSigOpFin
        loc_cTmp     = loc_cCursor + "Tmp"

        TRY
            loc_cSQL = "select distinct SigOpFin.Dopes, "
            loc_cSQL = loc_cSQL + "convert(int,(substring(lbltxidCs,24,1))) as VisTit "
            loc_cSQL = loc_cSQL + "from SigOpFin "
            loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes "
            loc_cSQL = loc_cSQL + "join SigOpCdi on SigOpCdi.dopes = SigOpFin.dopes "
            loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
            loc_cSQL = loc_cSQL + "where contaeds <> space(11) "
            loc_cSQL = loc_cSQL + "order by 1"

            IF USED(loc_cTmp)
                USE IN (loc_cTmp)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar as opera" + CHR(231) + CHR(245) + ;
                    "es financeiras:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                *-- Cursor de SQLEXEC nasce SOMENTE-LEITURA; o INDEX ON e o SCAN
                *-- de carga da grade precisam de cursor READWRITE proprio
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
                SELECT * FROM (loc_cTmp) INTO CURSOR (loc_cCursor) READWRITE
                IF USED(loc_cTmp)
                    USE IN (loc_cTmp)
                ENDIF

                SELECT (loc_cCursor)
                INDEX ON Dopes TAG Dopes
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorAltCc - Cria cursor_4c_AltCc (mirror de SigMvCcr), equivalente
    * ao AddCursor('SigMvCcr','CidChaves','CrAltcc','','',[Select * From
    * SigMvCcr]) do Init legado - so a ESTRUTURA (zero linhas), READWRITE
    * para o processamento poder popular localmente antes de gravar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorAltCc()
        LOCAL loc_cTmp, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cTmp = THIS.this_cCursorAltCc + "Tmp"

        TRY
            IF USED(loc_cTmp)
                USE IN (loc_cTmp)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigMvCcr WHERE 1 = 0", loc_cTmp)

            IF loc_nResult >= 0 AND USED(loc_cTmp)
                IF USED(THIS.this_cCursorAltCc)
                    USE IN (THIS.this_cCursorAltCc)
                ENDIF
                SELECT * FROM (loc_cTmp) INTO CURSOR (THIS.this_cCursorAltCc) READWRITE
                USE IN (loc_cTmp)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.CriarCursorAltCc")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacoesEMoedas - Popula cursor_4c_SigCdCot/cursor_4c_SigCdMoe,
    * equivalente aos dois CursorQuery('SigCdCot'...)/CursorQuery('SigCdMoe'...)
    * do Init legado - fonte para CarregarCambio() (fCarregarCambio nao
    * portada - ver CLAUDE.md regra #27/skill vfp9-migration).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCotacoesEMoedas()
        LOCAL loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorSigCdCot)
                USE IN (THIS.this_cCursorSigCdCot)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", THIS.this_cCursorSigCdCot)
            IF loc_nResult >= 0 AND USED(THIS.this_cCursorSigCdCot)
                SELECT (THIS.this_cCursorSigCdCot)
                INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                SET ORDER TO CMoeData DESCENDING
            ENDIF

            IF USED(THIS.this_cCursorSigCdMoe)
                USE IN (THIS.this_cCursorSigCdMoe)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Cotas FROM SigCdMoe", THIS.this_cCursorSigCdMoe)
            IF loc_nResult >= 0 AND USED(THIS.this_cCursorSigCdMoe)
                SELECT (THIS.this_cCursorSigCdMoe)
                INDEX ON CMoes TAG CMoes
            ENDIF

            loc_lSucesso = USED(THIS.this_cCursorSigCdCot) AND USED(THIS.this_cCursorSigCdMoe)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.CarregarCotacoesEMoedas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna a cotacao da moeda na data informada.
    * Equivalente a fCarregarCambio() do sistema legado (NAO portada - ver
    * CLAUDE.md regra #27). Usa cursor_4c_SigCdMoe + cursor_4c_SigCdCot
    * carregados por CarregarCotacoesEMoedas(). Template canonico: ver
    * SigReAtmBO.CarregarCambio.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro, loc_cCot, loc_cMoe
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(NVL(par_cMoeda, ""))
        loc_dData    = IIF(EMPTY(par_dData), DATE(), par_dData)
        loc_cCot     = THIS.this_cCursorSigCdCot
        loc_cMoe     = THIS.this_cCursorSigCdMoe

        IF !EMPTY(loc_cMoeda)
            TRY
                IF USED(loc_cMoe)
                    SELECT (loc_cMoe)
                    SET ORDER TO CMoes
                    IF SEEK(loc_cMoeda) AND NVL(Cotas, 0) <> 0
                        IF USED(loc_cCot)
                            SELECT (loc_cCot)
                            SET ORDER TO CMoeData DESCENDING
                            SET NEAR ON
                            SEEK loc_cMoeda + DTOS(loc_dData)
                            SET NEAR OFF
                            IF !EOF(loc_cCot) AND ALLTRIM(CMoes) = loc_cMoeda
                                loc_nCotacao = Valos
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                SET NEAR OFF
            ENDTRY
        ENDIF

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * RecalcularSaldos - Recalcula o saldo corrente (rollforward de razao
    * contabil) de SigMvCcr para o Grupo+Conta+Moeda informados.
    *
    * fRecalculaS() do legado e uma funcao EXTERNA, fora do dump do form/VCX
    * (nao esta no acervo) - nao ha formula para TRANSCREVER (a regra "nunca
    * reescrever formula do legado" pressupoe a formula disponivel; aqui nao
    * esta). Grava numero errado em silencio seria pior que a ausencia (regra
    * CLAUDE.md #27, categoria "deixar ausente" para funcao de CALCULO) -
    * por isso esta implementacao fica restrita ao UNICO comportamento
    * evidenciado no proprio dump: cada lancamento marca opers='D' (soma) ou
    * 'C' (subtrai) e a contrapartida sempre inverte D/C - convencao padrao
    * de razao contabil de dupla entrada, nao formula proprietaria (imposto/
    * tarifa). Recalcula so a coluna 'saldos' (saldo corrente); 'saldocs' e
    * 'saldons' (saldo em conta corrente / saldo nominal) nao tem fonte para
    * derivar e ficam com o valor gravado pelo INSERT (0) - preservados
    * assim em vez de adivinhados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularSaldos(par_cGrupo, par_cConta, par_cMoeda)
        LOCAL loc_cSQL, loc_nResult, loc_nSaldo, loc_cCursor, loc_oErro, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_RecalcSaldo"

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT cidchaves, opers, valors FROM SigMvCcr" + ;
                " WHERE grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                " AND contas = " + EscaparSQL(ALLTRIM(par_cConta)) + ;
                " AND moedas = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                " ORDER BY datas, nopers"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResult >= 0 AND USED(loc_cCursor)
                loc_nSaldo = 0
                SELECT (loc_cCursor)
                SCAN
                    IF UPPER(ALLTRIM(NVL(opers, ""))) = "D"
                        loc_nSaldo = loc_nSaldo + NVL(valors, 0)
                    ELSE
                        loc_nSaldo = loc_nSaldo - NVL(valors, 0)
                    ENDIF

                    SQLEXEC(gnConnHandle, "UPDATE SigMvCcr SET saldos = " + ;
                        FormatarNumeroSQL(loc_nSaldo, 2) + " WHERE cidchaves = " + ;
                        EscaparSQL(cidchaves))
                ENDSCAN
                USE IN (loc_cCursor)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.RecalcularSaldos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCamposLancamento - Zera todas as propriedades de dados do BO
    * antes de montar um novo lancamento (entrada D ou contrapartida C) -
    * evita que valor de um lancamento anterior vaze para o proximo via
    * THIS.Inserir().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCamposLancamento()
        THIS.this_cCidchaves    = ""
        THIS.this_lAutos        = .F.
        THIS.this_lConcs        = .F.
        THIS.this_cContages     = ""
        THIS.this_cContas       = ""
        THIS.this_cContems      = ""
        THIS.this_nCotacaos     = 0
        THIS.this_dDatalts      = {}
        THIS.this_dDatas        = {}
        THIS.this_dDataconcs    = {}
        THIS.this_dDatatrans    = {}
        THIS.this_dDatexcs      = {}
        THIS.this_cDocus        = ""
        THIS.this_cDopes        = ""
        THIS.this_dDtemis       = {}
        THIS.this_cEmps         = ""
        THIS.this_cGrupages     = ""
        THIS.this_cGrupems      = ""
        THIS.this_cGrupos       = ""
        THIS.this_cHists        = ""
        THIS.this_cLocals       = ""
        THIS.this_cMoedas       = ""
        THIS.this_cNfs          = ""
        THIS.this_nNlancs       = 0
        THIS.this_nNopers       = 0
        THIS.this_nNtrans       = 0
        THIS.this_nNumes        = 0
        THIS.this_cOpers        = ""
        THIS.this_nSaldocs      = 0
        THIS.this_nSaldons      = 0
        THIS.this_nSaldos       = 0
        THIS.this_cScontas      = ""
        THIS.this_nScotacaos    = 0
        THIS.this_cSgrupos      = ""
        THIS.this_cShists       = ""
        THIS.this_cSmoedas      = ""
        THIS.this_cSopers       = ""
        THIS.this_nSvalors      = 0
        THIS.this_cTipos        = ""
        THIS.this_cTitbans      = ""
        THIS.this_cTitulos      = ""
        THIS.this_cUsualts      = ""
        THIS.this_cUsuexcs      = ""
        THIS.this_nValliqs      = 0
        THIS.this_nValocurs     = 0
        THIS.this_nValors       = 0
        THIS.this_nValpags      = 0
        THIS.this_dVencs        = {}
        THIS.this_cVlancs       = ""
        THIS.this_cVopers       = ""
        THIS.this_nContapgs     = 0
        THIS.this_cDopcs        = ""
        THIS.this_nNumcs        = 0
        THIS.this_cCotusus      = ""
        THIS.this_cBcontas      = ""
        THIS.this_cBgrupos      = ""
        THIS.this_nBorderos     = 0
        THIS.this_cHist2s       = ""
        THIS.this_nIntconts     = 0
        THIS.this_cUsuconcs     = ""
        THIS.this_cAuditors     = ""
        THIS.this_dDtaudits     = {}
        THIS.this_nValprev      = 0
        THIS.this_cEmpdopncs    = ""
        THIS.this_cEmpdopnums   = ""
        THIS.this_cGruconmoes   = ""
        THIS.this_cPagos        = ""
        THIS.this_cDopotps      = ""
        THIS.this_cUsupagos     = ""
        THIS.this_nTitcancs     = 0
        THIS.this_dDtconfs      = {}
        THIS.this_cUsuconfs     = ""
        THIS.this_nNopercancs   = 0
        THIS.this_cEspecienfs   = ""
        THIS.this_cJobs         = ""
        THIS.this_nImpostos     = 0
        THIS.this_nTpimpostos   = 0
        THIS.this_cTitpais      = ""
        THIS.this_cEmpccs       = ""
        THIS.this_nRecor        = 0
        THIS.this_cCompet       = ""
        THIS.this_cEmpos        = ""
        THIS.this_cOridopnums   = ""
        THIS.this_cPastas       = ""
        THIS.this_cRcontas      = ""
        THIS.this_cTpdocnf      = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarLancamentos - Motor do processamento em lote (equivalente ao
    * PROCEDURE processamento do form legado). Gera pares de lancamento D/C
    * (debito na conta de destino, credito na conta de origem) em SigMvCcr a
    * partir do custo das operacoes financeiras marcadas na grade
    * (cursor_4c_Operacoes), convertendo moeda via CarregarCambio() quando a
    * moeda de conversao (filtro do form) estiver preenchida.
    *
    * Adaptacao de arquitetura (nao muda o RESULTADO, so a MECANICA de
    * persistencia): o legado acumula tudo num cursor bufferizado (CrAltcc)
    * e faz UM TableUpdate('Craltcc') no final; aqui cada linha e gravada via
    * THIS.Inserir() dentro de UMA unica transacao manual (a conexao deste
    * ambiente nasce com Transactions=2 - SQLCOMMIT/SQLROLLBACK explicitos em
    * GravarLancamentos), preservando a atomicidade "tudo ou nada" do
    * Update/Rollback original. A recalculo GLOBAL fRecalculaS(.T., datamgr)
    * do final do legado (varredura de escopo desconhecido) fica FORA deste
    * metodo - ver nota em RecalcularSaldos.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarLancamentos(par_dDataIni, par_dDataFim, par_cEmpresa, par_cMoedaConversao)
        LOCAL loc_cPDtI, loc_cPDtF, loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        LOCAL loc_cTmp, loc_lProsseguir
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro  = ""
        THIS.this_nQtdVisTit     = 0
        THIS.this_nQtdProcessada = 0
        loc_cTmp = "cursor_4c_TmpMov"

        TRY
            THIS.CarregarCotacoesEMoedas()

            IF !USED(THIS.this_cCursorAltCc)
                THIS.CriarCursorAltCc()
            ENDIF
            IF !USED(THIS.this_cCursorAltCc)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar a estrutura de lan" + CHR(231) + "amentos (SigMvCcr)."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT (THIS.this_cCursorAltCc)
                ZAP

                IF USED(THIS.this_cCursorMovimento)
                    USE IN (THIS.this_cCursorMovimento)
                ENDIF
                CREATE CURSOR (THIS.this_cCursorMovimento) (Emps C(3), Dopes C(20), DataS T, ;
                    custofs N(12,3), pcuss N(12,5), moecusfs C(3), moedas C(3), qtds N(10,3), ;
                    GrupoEDs C(11), ContaEDs C(11), GrupoECs C(11), ContaECs C(11), MoeOpFin C(3), ;
                    Cotacaos N(16,7), Numes N(6), EmpDopNums C(29))
                SELECT (THIS.this_cCursorMovimento)
                INDEX ON Emps + Dopes + TTOC(DataS) TAG EDD

                loc_cPDtI = FormatarDataSQL(par_dDataIni)
                loc_cPDtF = FormatarDataSQL(DATETIME(YEAR(par_dDataFim), MONTH(par_dDataFim), ;
                    DAY(par_dDataFim), 23, 59, 59))

                *-- Operacoes financeiras que ainda NAO foram lancadas (nao
                *-- gravadas em SigMvCcr) no periodo/empresa informados -
                *-- JOINs e filtros TRANSCRITOS do legado (regra de negocio).
                loc_cSQL = "select sigmvcab.valos, sigmvcab.Datas, sigmvcab.Emps, sigmvcab.dopes, sigmvcab.Numes, sigmvcab.empdopnums "
                loc_cSQL = loc_cSQL + "from sigmvcab "
                loc_cSQL = loc_cSQL + "join sigcdope on sigcdope.dopes = sigmvcab.Dopes "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = sigcdope.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "where sigcdope.vendas=1 and sigcdope.copers in(1,2) and sigcdope.caixas=1 "
                loc_cSQL = loc_cSQL + "And empdopnums not in ( Select distinct a.empdopnums from sigmvccr a "
                loc_cSQL = loc_cSQL + "join sigcdope on sigcdope.dopes = a.Dopes "
                loc_cSQL = loc_cSQL + "and sigcdope.vendas=1 and sigcdope.copers=1 and sigcdope.caixas=1 "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = sigcdope.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "join (select GrupoEDs, ContaEDs, GrupoECs, ContaECs, SigOpFin.Dopes, SigOpFin.Moedas "
                loc_cSQL = loc_cSQL + "from SigOpFin "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "where contaeds <> space(11)) b on a.dopes = b.dopes "
                loc_cSQL = loc_cSQL + "and a.contas = b.contaecs and a.scontas = b.ContaEDs "
                loc_cSQL = loc_cSQL + "and a.grupos = b.GrupoECs and a.sgrupos = b.GrupoEDs) "
                loc_cSQL = loc_cSQL + "And sigmvcab.Datas Between " + loc_cPDtI + " and " + loc_cPDtF + " "
                IF !EMPTY(ALLTRIM(NVL(par_cEmpresa, "")))
                    loc_cSQL = loc_cSQL + "And sigmvcab.Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa))
                ENDIF

                IF USED(loc_cTmp)
                    USE IN (loc_cTmp)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Favor Reiniciar o Processo!!!" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Filtra so as operacoes MARCADAS na grade (equivalente ao
                *-- "Select crTmpMov.* From crTmpMov, csOperacaos Where
                *-- csOperacaos.Operacaos = crTmpMov.Dopes And csOperacaos.
                *-- Marcas = .T."). this_cCursorOperacoes e uma constante
                *-- fixa da classe ("cursor_4c_Operacoes") - usada aqui como
                *-- literal para permitir o JOIN local por nome.
                IF USED("cursor_4c_Mov")
                    USE IN cursor_4c_Mov
                ENDIF

                SELECT cursor_4c_TmpMov.* ;
                    FROM cursor_4c_TmpMov, cursor_4c_Operacoes ;
                    WHERE cursor_4c_Operacoes.Operacaos = cursor_4c_TmpMov.Dopes ;
                    AND cursor_4c_Operacoes.Marcas = .T. ;
                    INTO CURSOR cursor_4c_Mov READWRITE

                IF USED(loc_cTmp)
                    USE IN (loc_cTmp)
                ENDIF

                IF !USED("cursor_4c_Mov") OR RECCOUNT("cursor_4c_Mov") = 0
                    THIS.this_cMensagemErro = "Nenhum registro foi selecionado."
                    MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    loc_lProsseguir = .F.
                ELSE
                    SELECT cursor_4c_Mov
                    INDEX ON Dopes TAG Dopes
                    GO TOP
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lProsseguir = THIS.GerarMovimentosECustos(par_cMoedaConversao)
            ENDIF

            IF loc_lProsseguir
                loc_lSucesso = THIS.GravarLancamentos()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.ProcessarLancamentos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarMovimentosECustos - Para cada operacao marcada (cursor_4c_Mov),
    * agrega o custo/quantidade de SigMvItn+SigCdPro (join com SigOpFin para
    * achar Grupo/Conta origem-destino) e acumula em cursor_4c_Movimento,
    * convertendo moeda via CarregarCambio quando a moeda de conversao
    * (filtro do form) estiver preenchida. Consulta e regra de conversao
    * TRANSCRITAS do PROCEDURE processamento legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarMovimentosECustos(par_cMoedaConversao)
        LOCAL loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro
        LOCAL loc_cMoeCf, loc_cMoeda, loc_nCotacao, loc_nCotaMoe, loc_nCustofs, loc_nPcuss
        loc_lProsseguir = .T.

        SELECT cursor_4c_Mov
        GO TOP
        DO WHILE loc_lProsseguir AND !EOF("cursor_4c_Mov")
            TRY
                loc_cSQL = "Select distinct a.Emps, a.dopes, a.numes, a.EmpDopnums, a.datas, sum(c.custofs) as custofs, "
                loc_cSQL = loc_cSQL + "Sum(c.pcuss) as pcuss, c.moecusfs, b.moedas, SUM(b.qtds) as qtds, "
                loc_cSQL = loc_cSQL + "d.GrupoEDs, d.ContaEDs, d.GrupoECs, d.ContaECs, d.Moedas as MoeOpFin "
                loc_cSQL = loc_cSQL + "From sigmvcab a "
                loc_cSQL = loc_cSQL + "join SigMvItn b on b.empdopnums = a.empdopnums "
                loc_cSQL = loc_cSQL + "join SigCdPro c on c.Cpros = b.Cpros "
                loc_cSQL = loc_cSQL + "join (select GrupoEDs, ContaEDs, GrupoECs, ContaECs, SigOpFin.Dopes, SigOpFin.Moedas "
                loc_cSQL = loc_cSQL + "from SigOpFin "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "where contaeds <> space(11)) d on d.dopes = a.dopes "
                loc_cSQL = loc_cSQL + "Where c.pcuss >0 "
                loc_cSQL = loc_cSQL + "And a.empdopnums = " + EscaparSQL(cursor_4c_Mov.empdopnums) + " "
                loc_cSQL = loc_cSQL + "group by a.Emps, a.dopes, c.moecusfs, b.moedas, a.datas, "
                loc_cSQL = loc_cSQL + "d.GrupoEDs, d.ContaEDs, d.GrupoECs, d.ContaECs, d.Moedas, a.numes, a.EmpDopnums"

                IF USED("cursor_4c_MovIt")
                    USE IN cursor_4c_MovIt
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovIt")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Favor Reiniciar o Processo!!!" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ELSE
                    SELECT cursor_4c_MovIt
                    SCAN
                        loc_nCustofs = NVL(custofs, 0)
                        loc_nPcuss   = NVL(pcuss, 0)
                        loc_cMoeCf   = IIF(EMPTY(moecusfs), moedas, moecusfs)
                        loc_cMoeda   = IIF(!EMPTY(ALLTRIM(NVL(par_cMoedaConversao, ""))), ;
                            ALLTRIM(par_cMoedaConversao), IIF(EMPTY(MoeOpFin), loc_cMoeCf, MoeOpFin))

                        loc_nCotacao = THIS.CarregarCambio(loc_cMoeCf, ConverterParaData(DataS))
                        loc_nCotaMoe = THIS.CarregarCambio(loc_cMoeda, ConverterParaData(DataS))

                        loc_nCustofs = ROUND(loc_nCustofs * loc_nCotacao / loc_nCotaMoe, 2)
                        loc_nPcuss   = ROUND(loc_nPcuss * loc_nCotacao / loc_nCotaMoe, 2)

                        INSERT INTO (THIS.this_cCursorMovimento) (Emps, Dopes, Numes, EmpDopNums, DataS, ;
                            moecusfs, moedas, GrupoEDs, ContaEDs, GrupoECs, ContaECs, MoeOpFin, Cotacaos, ;
                            custofs, pcuss, qtds) ;
                            VALUES (cursor_4c_MovIt.Emps, cursor_4c_MovIt.Dopes, cursor_4c_MovIt.Numes, ;
                            cursor_4c_MovIt.EmpDopNums, cursor_4c_MovIt.DataS, cursor_4c_MovIt.moecusfs, ;
                            cursor_4c_MovIt.moedas, cursor_4c_MovIt.GrupoEDs, cursor_4c_MovIt.ContaEDs, ;
                            cursor_4c_MovIt.GrupoECs, cursor_4c_MovIt.ContaECs, loc_cMoeda, loc_nCotaMoe, ;
                            loc_nCustofs, loc_nPcuss, cursor_4c_MovIt.qtds)
                    ENDSCAN
                    IF USED("cursor_4c_MovIt")
                        USE IN cursor_4c_MovIt
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SIGMVCMVBO.GerarMovimentosECustos")
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir
                SKIP IN cursor_4c_Mov
            ENDIF
        ENDDO

        RETURN loc_lProsseguir
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLancamentos - Agrupa cursor_4c_Movimento (equivalente ao "Select
    * ... From csMovimento Group By ... Into Cursor CrMvCCr") e grava o par
    * de lancamentos D/C para cada grupo, numa UNICA transacao manual
    * (Transactions=2 - regra do ambiente): tudo confirmado (SQLCOMMIT) so
    * se TODAS as linhas gravarem; qualquer falha reverte tudo (SQLROLLBACK),
    * equivalente ao Rollback do TableUpdate legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarLancamentos()
        LOCAL loc_lManual, loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_lManual     = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            IF USED("cursor_4c_MvCCr")
                USE IN cursor_4c_MvCCr
            ENDIF

            SELECT Emps, Dopes, DataS, SUM(custofs) AS custofs, SUM(pcuss) AS pcuss, moecusfs, moedas, ;
                SUM(qtds) AS qtds, GrupoEDs, ContaEDs, GrupoECs, ContaECs, MoeOpFin, Cotacaos, Numes, EmpDopNums ;
                FROM (THIS.this_cCursorMovimento) ;
                GROUP BY Emps, Dopes, DataS, moecusfs, moedas, GrupoEDs, ContaEDs, GrupoECs, ContaECs, ;
                MoeOpFin, Cotacaos, Numes, EmpDopNums ;
                INTO CURSOR cursor_4c_MvCCr READWRITE

            IF !USED("cursor_4c_MvCCr") OR RECCOUNT("cursor_4c_MvCCr") = 0
                THIS.this_cMensagemErro = "Nenhum registro foi selecionado."
                loc_lProsseguir = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.GravarLancamentos")
            loc_lProsseguir = .F.
        ENDTRY

        IF loc_lProsseguir
            SELECT cursor_4c_MvCCr
            GO TOP
            DO WHILE loc_lProsseguir AND !EOF("cursor_4c_MvCCr")
                loc_lProsseguir = THIS.GerarParDC()
                IF loc_lProsseguir
                    SKIP IN cursor_4c_MvCCr
                ENDIF
            ENDDO
        ENDIF

        IF loc_lProsseguir
            IF loc_lManual
                = SQLCOMMIT(gnConnHandle)
            ENDIF
            loc_lSucesso = .T.
            THIS.ContarOperacoesVisTit()
            MsgInfo("Processamento realizado com sucesso!!!", "Confirmar")
        ELSE
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = "Favor reinicializar o processo."
            ENDIF
            MsgErro(THIS.this_cMensagemErro, "Falha no Processamento")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarParDC - Gera o par de lancamentos Debito/Credito para o grupo de
    * custo corrente de cursor_4c_MvCCr (equivalente ao Scatter+FazContra do
    * legado): entrada "D" na conta de destino (GrupoECs/ContaECs) e a
    * contrapartida "C" na conta de origem (GrupoEDs/ContaEDs), mesmo valor,
    * mesmo Nopers/Vopers (numero/identificador da transacao).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarParDC()
        LOCAL loc_lSucesso, loc_oErro, loc_nNopers, loc_cHist, loc_cHist2, loc_cVopers
        LOCAL loc_cEmps, loc_cDopes, loc_dDataS, loc_nNumes, loc_cEmpDopNums
        LOCAL loc_cGrupoEDs, loc_cContaEDs, loc_cGrupoECs, loc_cContaECs
        LOCAL loc_cMoeOpFin, loc_nCotacaos, loc_nValor, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cEmps       = cursor_4c_MvCCr.Emps
            loc_cDopes      = cursor_4c_MvCCr.Dopes
            loc_dDataS      = ConverterParaData(cursor_4c_MvCCr.DataS)
            loc_nNumes      = NVL(cursor_4c_MvCCr.Numes, 0)
            loc_cEmpDopNums = cursor_4c_MvCCr.EmpDopNums
            loc_cGrupoEDs   = cursor_4c_MvCCr.GrupoEDs
            loc_cContaEDs   = cursor_4c_MvCCr.ContaEDs
            loc_cGrupoECs   = cursor_4c_MvCCr.GrupoECs
            loc_cContaECs   = cursor_4c_MvCCr.ContaECs
            loc_cMoeOpFin   = cursor_4c_MvCCr.MoeOpFin
            loc_nCotacaos   = NVL(cursor_4c_MvCCr.Cotacaos, 0)
            loc_nValor      = NVL(cursor_4c_MvCCr.pcuss, 0)

            *-- Historico (hists/hist2s) do SigCdOpe.Dopes, equivalente ao
            *-- CursorQuery('SigCdOpe','crSigCdOpe','Dopes',m.Dopes,'hists, hist2s')
            IF USED("cursor_4c_SigCdOpeTmp")
                USE IN cursor_4c_SigCdOpeTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT hists, hist2s FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                "cursor_4c_SigCdOpeTmp")

            loc_cHist  = ALLTRIM(loc_cEmpDopNums)
            loc_cHist2 = ""
            IF loc_nResult > 0 AND USED("cursor_4c_SigCdOpeTmp") AND RECCOUNT("cursor_4c_SigCdOpeTmp") > 0
                SELECT cursor_4c_SigCdOpeTmp
                IF !EMPTY(NVL(hists, ""))
                    loc_cHist = ALLTRIM(hists)
                ENDIF
                IF !EMPTY(NVL(hist2s, ""))
                    loc_cHist2 = ALLTRIM(hist2s)
                ENDIF
            ENDIF
            IF USED("cursor_4c_SigCdOpeTmp")
                USE IN cursor_4c_SigCdOpeTmp
            ENDIF

            loc_nNopers = fGerUniqueKey("SigMvCcr")
            loc_cVopers = ALLTRIM(loc_cEmps) + ALLTRIM(STR(loc_nNopers, 9))

            *-- Entrada D (destino) - REPLACE do legado, transcrito literalmente
            THIS.LimparCamposLancamento()
            THIS.this_cGrupos      = loc_cGrupoECs
            THIS.this_cContas      = loc_cContaECs
            THIS.this_cSgrupos     = loc_cGrupoEDs
            THIS.this_cScontas     = loc_cContaEDs
            THIS.this_cMoedas      = loc_cMoeOpFin
            THIS.this_cSmoedas     = loc_cMoeOpFin
            THIS.this_nCotacaos    = loc_nCotacaos
            THIS.this_nScotacaos   = loc_nCotacaos
            THIS.this_dVencs       = loc_dDataS
            THIS.this_dDtemis      = loc_dDataS
            THIS.this_cOpers       = "D"
            THIS.this_cSopers      = "C"
            THIS.this_cHists       = loc_cHist
            THIS.this_cHist2s      = loc_cHist2
            THIS.this_dDatas       = loc_dDataS
            THIS.this_nNopers      = loc_nNopers
            THIS.this_cVopers      = loc_cVopers
            THIS.this_cEmps        = loc_cEmps
            THIS.this_nSvalors     = loc_nValor
            THIS.this_nValors      = loc_nValor
            THIS.this_nContapgs    = 2
            THIS.this_lAutos       = .T.
            THIS.this_cPagos       = "1"
            THIS.this_nValpags     = 0
            THIS.this_cUsualts     = gc_4c_UsuarioLogado
            THIS.this_cDopes       = loc_cDopes
            THIS.this_nNumes       = loc_nNumes
            THIS.this_cEmpdopnums  = loc_cEmpDopNums
            THIS.this_cCidchaves   = LEFT(DTOS(loc_dDataS) + ;
                TRANSFORM(fGerUniqueKey(DTOS(loc_dDataS)), "@L 999999") + THIS.this_cChaveSessao, 20)

            loc_lSucesso = THIS.Inserir()

            IF loc_lSucesso
                THIS.RecalcularSaldos(THIS.this_cGrupos, THIS.this_cContas, THIS.this_cMoedas)

                *-- Contrapartida C (origem) - mesma transacao (Nopers/Vopers),
                *-- grupo/conta principal e secundario invertidos, opers/sopers trocados
                THIS.LimparCamposLancamento()
                THIS.this_cGrupos      = loc_cGrupoEDs
                THIS.this_cContas      = loc_cContaEDs
                THIS.this_cSgrupos     = loc_cGrupoECs
                THIS.this_cScontas     = loc_cContaECs
                THIS.this_cMoedas      = loc_cMoeOpFin
                THIS.this_cSmoedas     = loc_cMoeOpFin
                THIS.this_nCotacaos    = loc_nCotacaos
                THIS.this_nScotacaos   = loc_nCotacaos
                THIS.this_dVencs       = loc_dDataS
                THIS.this_dDtemis      = loc_dDataS
                THIS.this_cOpers       = "C"
                THIS.this_cSopers      = "D"
                THIS.this_cHists       = loc_cHist
                THIS.this_cHist2s      = loc_cHist2
                THIS.this_dDatas       = loc_dDataS
                THIS.this_nNopers      = loc_nNopers
                THIS.this_cVopers      = loc_cVopers
                THIS.this_cEmps        = loc_cEmps
                THIS.this_nSvalors     = loc_nValor
                THIS.this_nValors      = loc_nValor
                THIS.this_nContapgs    = 2
                THIS.this_lAutos       = .T.
                THIS.this_cPagos       = "1"
                THIS.this_nValpags     = 0
                THIS.this_cUsualts     = gc_4c_UsuarioLogado
                THIS.this_cDopes       = loc_cDopes
                THIS.this_nNumes       = loc_nNumes
                THIS.this_cEmpdopnums  = loc_cEmpDopNums
                THIS.this_cCidchaves   = LEFT(DTOS(loc_dDataS) + ;
                    TRANSFORM(fGerUniqueKey(DTOS(loc_dDataS)), "@L 999999") + THIS.this_cChaveSessao, 20)

                loc_lSucesso = THIS.Inserir()

                IF loc_lSucesso
                    THIS.RecalcularSaldos(THIS.this_cGrupos, THIS.this_cContas, THIS.this_cMoedas)
                    THIS.this_nQtdProcessada = THIS.this_nQtdProcessada + 1
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.GerarParDC")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ContarOperacoesVisTit - Conta quantas operacoes marcadas pedem
    * visualizacao de titulos (VisTit = 1), equivalente ao filtro final do
    * legado que abria "Do Form SigMvTi2". Esse form NAO faz parte desta
    * migracao (fora do acervo/tasks atuais) - o resultado fica em
    * this_nQtdVisTit para o Form avisar o usuario, em vez de tentar abrir
    * uma tela inexistente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ContarOperacoesVisTit()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_VisTit")
                USE IN cursor_4c_VisTit
            ENDIF

            SELECT Dopes, VisTit FROM (THIS.this_cCursorOperacoes) ;
                WHERE Marcas = .T. AND VisTit = 1 ;
                INTO CURSOR cursor_4c_VisTit READWRITE

            IF USED("cursor_4c_VisTit")
                THIS.this_nQtdVisTit = RECCOUNT("cursor_4c_VisTit")
                USE IN cursor_4c_VisTit
            ENDIF
        CATCH TO loc_oErro
            THIS.this_nQtdVisTit = 0
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.ContarOperacoesVisTit")
        ENDTRY
    ENDPROC

ENDDEFINE

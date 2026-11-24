*------------------------------------------------------------------------------
* FormSigOpVdi.prg - Form Operacional: Pesquisa Detalhada (vendas x cadastro)
* Herda de FormBase
* Migrado de SIGOPVDI.SCX
*
* Form OPERACIONAL com PageFrame interno de 2 paginas (pgfPrincipal no
* legado -> pgf_4c_Paginas): Page1 = pgFiltros (filtros de periodo/moeda/
* grupo de venda/subgrupo + grades de marcacao de empresas/tipos de
* operacao/grande grupo/grupo/operacoes) e Page2 = pgDados (resultado -
* PageFrame interno pgResults com 3 abas: Detalhamento/Totais por Empresa/
* Totais por Vendedora). Tabs=.F. nas duas - a navegacao entre Page1/Page2
* e feita pelos botoes cmgFiltros.btnConsultar / pgDados.cmgRetornar, nao
* por clique nas abas.
*
* pgf_4c_Paginas.Top=-1 (NAO eh o deslocamento -29 do padrao CRUD - regra
* #11 e o PageFrame.Top=-29 nao se aplicam aqui: este form nao eh
* frmcadastro, e o legado so usa -1 para cobrir 1px de borda).
*
* FASE 3/8 - ESTRUTURA BASE: casca do form (propriedades visuais EXATAS do
* SCX - DataSession=2, Height=700, Width=1300, BorderStyle=2, ControlBox=.F.,
* Closable=.F., TitleBar=0) + pgf_4c_Paginas (2 paginas, geometria exata do
* dump) + o cabecalho cinza superior (cnt_4c_Sombra + lbl_4c_LblSombra +
* lbl_4c_LblTitulo), que no dump legado existe SO dentro de pgFiltros (Page1)
* - diferente do padrao CRUD que replica a faixa nas duas paginas (regra
* #11, decisao exclusiva de forms frmcadastro) - e o PageFrame interno
* pgf_4c_Resultados (3 paginas, so a casca, sem grades ainda).
*
* FASES CONCLUIDAS:
*   Fase 4: grades de marcacao (empresas/tipos/grande grupo/grupo/operacoes)
*           e o grupo de botoes de filtro (cmgFiltros -> cmg_4c_Filtros)
*   Fase 5 - PARTE 1/2: campos de Periodo (getDcI/getDcF) e Moeda de
*           Conversao (getCMoes/getDMoes), com BOParaFormFiltros() +
*           sincronizacao por LostFocus.
*   Fase 6 (ESTA FASE): campos de Grupo de Venda (getCdGrVda/getDsGrVda ->
*           txt_4c_CdGrVda/txt_4c_DsGrVda) e Subgrupo (get_cd_sgrupo/
*           get_ds_sgrupo -> txt_4c__cd_sgrupo/txt_4c__ds_sgrupo) + os 3
*           lookups fwbuscaext (Moeda/SigCdMoe, Grupo de Venda/SigCdCol,
*           Subgrupo/SigCdPsg) via FormBuscaAuxiliar, instalados no
*           LostFocus de cada campo de codigo/descricao (regra #47).
*
* FASES SEGUINTES:
*   Fase 7: grades de resultado (pgRes01/02/03 -> grd_4c_Dados1/2/3) +
*           botoes de navegacao/exportacao + eventos
*   Fase 8: consolidacao (Processamento() do legado -> THIS.this_oBusinessObject.
*           Processar(), FormParaBO completo dos filtros)
*------------------------------------------------------------------------------
DEFINE CLASS FormSigOpVdi AS FormBase

    *-- Propriedades visuais (SIGOPVDI.SCX, SECAO 2 "PROPRIEDADES DE: SIGOPVDI")
    this_cMensagemErro = ""
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    Height       = 700
    Width        = 1300
    BorderStyle  = 2
    AutoCenter   = .T.
    Caption      = "Pesquisa Detalhada"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    SizeBox      = .F.
    ZoomBox      = .F.
    Themes       = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia (regra #37/#47): o picker FormBuscaAuxiliar eh
    *-- MODAL e tira o foco do campo que o chamou, o que redispara o proprio
    *-- LostFocus. Compartilhada pelos 3 lookups da Pagina 1 (Moeda/Grupo de
    *-- Venda/Subgrupo) porque so um pode estar com foco por vez.
    this_lEmLookupFiltro = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpVdiBO")

            THIS.ConfigurarPageFrame()

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oBusinessObject.CarregarFiltrosIniciais()
                THIS.CarregarDados()
            ENDIF

            THIS.BOParaFormFiltros()

            THIS.ConfigurarBindEventsFiltros()

            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - pgfPrincipal do legado -> pgf_4c_Paginas (2
    * paginas: Page1=Filtros, Page2=Dados). Geometria EXATA do dump
    * (SECAO 2 "PROPRIEDADES DE: SIGOPVDI.pgfPrincipal").
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top         = -1
            .Left        = 0
            .Width       = 1301
            .Height      = 705
            .PageCount   = 2
            .Tabs        = .F.
            .BorderWidth = 0
            *-- O dump legado tambem declara TabStyle = 0, que NAO pode ser
            *-- transcrito: medido no VFP9 neste proprio PageFrame,
            *-- .TabStyle estoura "Property TABSTYLE is read-only" em
            *-- runtime, o erro cai no TRY do InicializarForm, CREATEOBJECT
            *-- devolve .F. e a tela NAO abre. Sem perda de fidelidade: 0 ja
            *-- e o default e, com Tabs = .F., nenhuma aba e desenhada.
            *-- BorderWidth, ao contrario, E gravavel (medido: default 1,
            *-- legado 0) - por isso continua transcrita acima.
        ENDWITH

        THIS.ConfigurarPaginaFiltros()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaFiltros - Page1 (pgFiltros no legado). Nesta fase: so
    * o fundo padrao e o cabecalho cinza (cntSombra -> cnt_4c_Sombra), que no
    * dump legado existe SOMENTE nesta pagina (NAO replicar em pgDados -
    * diferente do padrao CRUD da regra #11, que nao se aplica a este form).
    *
    * As grades de marcacao, os campos de filtro e o grupo de botoes
    * cmgFiltros entram nas Fases 4/5/6 - nenhum deles e criado aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            loc_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        *-- cntSombra: Top=1 Left=0 Width=1308 Height=80 BackColor=100,100,100
        loc_oPag.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPag.cnt_4c_Sombra
            .Top         = 1
            .Left        = 0
            .Width       = 1308
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            *-- lblSombra: Top=25 Left=10 Width=769 Height=40 Tahoma 18 Bold
            *-- ForeColor=0,0,0 (fundo da sombra do titulo)
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top       = 25
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(0, 0, 0)
                *-- Caption vem de THIS.Caption, nao do texto estatico
                *-- ("Cadastro de Testes") que sobrou no dump do SCX.
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            *-- lblTitulo: Top=24 Left=10 Width=769 Height=46 Tahoma 18 Bold
            *-- ForeColor=255,255,255 (texto branco por cima da sombra)
            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        THIS.ConfigurarGradesMarcacao(loc_oPag)
        THIS.ConfigurarCamposFiltro(loc_oPag)

        *-- txt_4c_CfgGrade (getCfgGrade no legado): Top=673, FORA da area
        *-- normalmente visitada do formulario - guarda em memoria a string
        *-- de largura/visibilidade das colunas de grd_4c_Dados1 (regra de
        *-- AcertaColunas, Fase 7). Nao tem uso direto pelo usuario comum.
        loc_oPag.AddObject("txt_4c_CfgGrade", "TextBox")
        WITH loc_oPag.txt_4c_CfgGrade
            .Top     = 673
            .Left    = 9
            .Width   = 1297
            .Height  = 23
            .Value   = ""
            *-- getCfgGrade.When do legado e "Return .f.": o campo nunca
            *-- recebe foco nem aceita digitacao - e area de armazenamento
            *-- de AcertaColunas, e texto digitado ali corromperia a
            *-- largura/visibilidade das 35 colunas de grd_4c_Dados1.
            *-- ReadOnly (convencao do projeto para When -> .f.) + TabStop
            *-- = .F. para o Tab nao parar nele.
            .ReadOnly = .T.
            .TabStop  = .F.
            .Visible = .T.
        ENDWITH

        *-- Page NAO tem a propriedade Visible (a Page e exibida pelo
        *-- ActivePage do PageFrame). Atribuir estoura "Property VISIBLE
        *-- is not found" dentro do InicializarForm e a tela nao abre.
    ENDPROC

    *==========================================================================
    * ConfigurarCamposFiltro - Campos de filtro da Pagina 1. Periodo
    * (getDcI/getDcF -> txt_4c_DataIni/txt_4c_DataFim) e Moeda de Conversao
    * (getCMoes/getDMoes -> txt_4c_CodMoeda/txt_4c_DescMoeda) vieram na
    * Fase 5 - Parte 1. Grupo de Venda (getCdGrVda/getDsGrVda ->
    * txt_4c_CdGrVda/txt_4c_DsGrVda) e Subgrupo (get_cd_sgrupo/get_ds_sgrupo
    * -> txt_4c__cd_sgrupo/txt_4c__ds_sgrupo) sao desta fase (Fase 6 -
    * Parte 2/2): os 3 campos de codigo (Moeda/Grupo de Venda/Subgrupo) tem
    * lookup fwbuscaext no legado (SigCdMoe/SigCdCol/SigCdPsg), instalado
    * via FormBuscaAuxiliar nos handlers de LostFocus logo abaixo deste
    * metodo (regra #47 - lookup em LostFocus, nunca em KeyPress sem testar
    * a tecla).
    *
    * Nenhum destes campos leva compensacao de +29 no Top (regra #11 nao se
    * aplica a este form - ver nota em pgf_4c_Paginas.Top no cabecalho):
    * Top/Left sao transcritos EXATOS do dump (layout.json).
    *
    * Say1/Say3/Say11/Say14 (classe "say" do legado, sem Width/Alignment no
    * dump de Say1/Say3) seguem a regra #23: .Alignment = 0 + .AutoSize =
    * .F. + Width calculada para caber o texto. Say11/Say14 JA declaram
    * Width no dump (AutoSize = .T. no SCX, mas regra #23 - AutoSize eh
    * no-op em Label criado por AddObject) - Width transcrita literal.
    * Label2 ("at?") ja declara Width/Height no dump - transcrito literal.
    *
    * Format/InputMask (regra #49) transcritos do dump: getCMoes/getDMoes =
    * "!" (forca maiuscula); getCdGrVda/getDsGrVda = "K" (seleciona ao
    * entrar); get_cd_sgrupo/get_ds_sgrupo = "K!" (seleciona + maiuscula).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro(par_oPag)

        *-- lbl_4c_Periodo (Say1): "Periodo :" - Left=457, campo em 506 (49px de vao)
        par_oPag.AddObject("lbl_4c_Periodo", "Label")
        WITH par_oPag.lbl_4c_Periodo
            .Top       = 111
            .Left      = 457
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "odo :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DataIni (getDcI): data inicial do periodo
        par_oPag.AddObject("txt_4c_DataIni", "TextBox")
        WITH par_oPag.txt_4c_DataIni
            .Top     = 107
            .Left    = 506
            .Width   = 70
            .Height  = 23
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- lbl_4c_At (Label2): "at?" - Left/Width/Height EXATOS do dump
        par_oPag.AddObject("lbl_4c_At", "Label")
        WITH par_oPag.lbl_4c_At
            .Top       = 111
            .Left      = 592
            .Width     = 18
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "at" + CHR(233)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DataFim (getDcF): data final do periodo
        par_oPag.AddObject("txt_4c_DataFim", "TextBox")
        WITH par_oPag.txt_4c_DataFim
            .Top     = 107
            .Left    = 617
            .Width   = 70
            .Height  = 23
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- lbl_4c_MoedaConversao (Say3): "Moeda Conversao :" - Left=406, campo em 506
        par_oPag.AddObject("lbl_4c_MoedaConversao", "Label")
        WITH par_oPag.lbl_4c_MoedaConversao
            .Top       = 137
            .Left      = 406
            .Width     = 96
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda Convers" + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CodMoeda (getCMoes): codigo da moeda de conversao
        *-- (CMoes char(3)). Lookup fwbuscaext (SigCdMoe) instalado no
        *-- LostFocus (THIS.AbrirLookupMoeda, logo abaixo).
        par_oPag.AddObject("txt_4c_CodMoeda", "TextBox")
        WITH par_oPag.txt_4c_CodMoeda
            .Top       = 133
            .Left      = 506
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Format    = "!"
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DescMoeda (getDMoes): descricao da moeda - o legado
        *-- tambem faz lookup por aqui digitando a descricao (getDMoes.Valid
        *-- com busca por DMoes), por isso NAO e ReadOnly.
        par_oPag.AddObject("txt_4c_DescMoeda", "TextBox")
        WITH par_oPag.txt_4c_DescMoeda
            .Top       = 133
            .Left      = 540
            .Width     = 385
            .Height    = 23
            .MaxLength = 15
            .Format    = "!"
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_GrupoVenda (Say14): "Grupo de Venda :" - Left=416, campo em 506
        par_oPag.AddObject("lbl_4c_GrupoVenda", "Label")
        WITH par_oPag.lbl_4c_GrupoVenda
            .Top       = 190
            .Left      = 416
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo de Venda :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CdGrVda (getCdGrVda): codigo do Grupo de Venda (SigCdCol.Colecoes char(10))
        par_oPag.AddObject("txt_4c_CdGrVda", "TextBox")
        WITH par_oPag.txt_4c_CdGrVda
            .Top       = 186
            .Left      = 506
            .Width     = 82
            .Height    = 23
            .MaxLength = 10
            .Format    = "K"
            .Alignment = 0
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DsGrVda (getDsGrVda): descricao do Grupo de Venda (SigCdCol.Descs char(40))
        par_oPag.AddObject("txt_4c_DsGrVda", "TextBox")
        WITH par_oPag.txt_4c_DsGrVda
            .Top       = 186
            .Left      = 591
            .Width     = 334
            .Height    = 23
            .MaxLength = 40
            .Format    = "K"
            .Alignment = 3
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Subgrupo (Say11): "Subgrupo :" - Left=447, campo em 506
        par_oPag.AddObject("lbl_4c_Subgrupo", "Label")
        WITH par_oPag.lbl_4c_Subgrupo
            .Top       = 163
            .Left      = 447
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Subgrupo :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c__cd_sgrupo (get_cd_sgrupo): codigo do Subgrupo (SigCdPsg.codigos char(6))
        par_oPag.AddObject("txt_4c__cd_sgrupo", "TextBox")
        WITH par_oPag.txt_4c__cd_sgrupo
            .Top       = 159
            .Left      = 506
            .Width     = 52
            .Height    = 23
            .MaxLength = 6
            .Format    = "K!"
            .Alignment = 0
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- txt_4c__ds_sgrupo (get_ds_sgrupo): descricao do Subgrupo (SigCdPsg.descricaos char(20))
        par_oPag.AddObject("txt_4c__ds_sgrupo", "TextBox")
        WITH par_oPag.txt_4c__ds_sgrupo
            .Top       = 159
            .Left      = 561
            .Width     = 364
            .Height    = 23
            .MaxLength = 20
            .Format    = "K!"
            .Value     = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaFormFiltros - copia os filtros de Periodo/Moeda do BO para os
    * campos da Pagina 1. Chamado no InicializarForm (apos
    * CarregarFiltrosIniciais, que resolve a moeda padrao via SQL) e tambem
    * disponivel para re-sincronizar apos qualquer troca feita por codigo.
    *
    * PUBLIC (regra #51): pode ser chamado de fora pelo harness de teste.
    *==========================================================================
    PROCEDURE BOParaFormFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DataIni.Value   = THIS.this_oBusinessObject.this_dDataIni
        loc_oPag.txt_4c_DataFim.Value   = THIS.this_oBusinessObject.this_dDataFim
        loc_oPag.txt_4c_CodMoeda.Value  = THIS.this_oBusinessObject.this_cMoeda
        loc_oPag.txt_4c_DescMoeda.Value = THIS.this_oBusinessObject.this_cDescMoeda
        loc_oPag.txt_4c_CdGrVda.Value   = THIS.this_oBusinessObject.this_cGrupoVenda
        loc_oPag.txt_4c_DsGrVda.Value   = THIS.this_oBusinessObject.this_cDescGrupoVenda
        loc_oPag.txt_4c__cd_sgrupo.Value = THIS.this_oBusinessObject.this_cSubGrupo
        loc_oPag.txt_4c__ds_sgrupo.Value = THIS.this_oBusinessObject.this_cDescSubGrupo
    ENDPROC

    *==========================================================================
    * LostFocus dos campos de Periodo/Moeda - sincronizam o valor digitado de
    * volta para as properties do BO, que sao a fonte lida por
    * BtnConsultarClick (THIS.this_oBusinessObject.this_dDataIni/this_dDataFim/
    * this_cMoeda). ConverterParaData normaliza DATE/DATETIME/CHAR (regra #16
    * - TTOD so aceita DATETIME e o .Value de TextBox nasce DATE).
    *==========================================================================
    PROCEDURE TxtDataIniLostFocus()
        THIS.this_oBusinessObject.this_dDataIni = ConverterParaData(THIS.pgf_4c_Paginas.Page1.txt_4c_DataIni.Value)
    ENDPROC

    PROCEDURE TxtDataFimLostFocus()
        THIS.this_oBusinessObject.this_dDataFim = ConverterParaData(THIS.pgf_4c_Paginas.Page1.txt_4c_DataFim.Value)
    ENDPROC

    *==========================================================================
    * TxtCodMoedaLostFocus / TxtDescMoedaLostFocus - sincronizam o codigo/
    * descricao digitados com o BO e resolvem via lookup fwbuscaext
    * (SigCdMoe no legado -> FormBuscaAuxiliar, THIS.AbrirLookupMoeda).
    *
    * Guarda de reentrancia (regra #37/#47, this_lEmLookupFiltro): o picker
    * e MODAL e tira o foco do campo, o que redispara o proprio LostFocus.
    * O corpo mora no metodo *Exec para a flag ser SEMPRE liberada, mesmo
    * nos RETURN antecipados de dentro dele.
    *==========================================================================
    PROCEDURE TxtCodMoedaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtCodMoedaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtCodMoedaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_CodMoeda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_CodMoeda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_CodMoeda.Value)
            loc_oPag.txt_4c_DescMoeda.Value = ""
            THIS.this_oBusinessObject.this_cMoeda     = ""
            THIS.this_oBusinessObject.this_cDescMoeda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupMoeda("CMoes", loc_oPag.txt_4c_CodMoeda.Value)
    ENDPROC

    PROCEDURE TxtDescMoedaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtDescMoedaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtDescMoedaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DescMoeda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_DescMoeda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_DescMoeda.Value)
            loc_oPag.txt_4c_CodMoeda.Value = ""
            THIS.this_oBusinessObject.this_cMoeda     = ""
            THIS.this_oBusinessObject.this_cDescMoeda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupMoeda("DMoes", loc_oPag.txt_4c_DescMoeda.Value)
    ENDPROC

    *==========================================================================
    * AbrirLookupMoeda - fwbuscaext(SigCdMoe) do legado -> FormBuscaAuxiliar.
    * par_cCampoBusca - "CMoes" (busca por codigo) ou "DMoes" (busca por
    * descricao), conforme o campo que disparou o LostFocus.
    *
    * O Init de FormBuscaAuxiliar JA tenta o match EXATO (regra #37):
    * achando 1 registro, resolve sozinho (this_lAchouRegistro +
    * this_lSelecionou) sem exibir dialogo - por isso NAO ha SQLEXEC proprio
    * de pre-checagem aqui (regra #37 - duplicar a checagem so cria caminho
    * para divergir). Universo vazio NUNCA avisa nem apaga o digitado
    * (regra #50) - so abre o picker, que ja mostra a lista completa.
    *==========================================================================
    PROCEDURE AbrirLookupMoeda(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oPag, loc_oBusca, loc_oErro
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", par_cCampoBusca, par_cValorBusca, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    loc_oPag.txt_4c_CodMoeda.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                    loc_oPag.txt_4c_DescMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
                    THIS.this_oBusinessObject.this_cMoeda     = loc_oPag.txt_4c_CodMoeda.Value
                    THIS.this_oBusinessObject.this_cDescMoeda = loc_oPag.txt_4c_DescMoeda.Value
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupMoeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCdGrVdaLostFocus / TxtDsGrVdaLostFocus - sincronizam o Grupo de
    * Venda digitado com o BO e resolvem via lookup fwbuscaext (SigCdCol no
    * legado -> FormBuscaAuxiliar, THIS.AbrirLookupGrupoVenda). Mesma guarda
    * de reentrancia de TxtCodMoedaLostFocus (this_lEmLookupFiltro).
    *==========================================================================
    PROCEDURE TxtCdGrVdaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtCdGrVdaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtCdGrVdaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_CdGrVda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_CdGrVda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_CdGrVda.Value)
            loc_oPag.txt_4c_DsGrVda.Value = ""
            THIS.this_oBusinessObject.this_cGrupoVenda     = ""
            THIS.this_oBusinessObject.this_cDescGrupoVenda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupGrupoVenda("Colecoes", loc_oPag.txt_4c_CdGrVda.Value)
    ENDPROC

    PROCEDURE TxtDsGrVdaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtDsGrVdaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtDsGrVdaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DsGrVda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_DsGrVda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_DsGrVda.Value)
            loc_oPag.txt_4c_CdGrVda.Value = ""
            THIS.this_oBusinessObject.this_cGrupoVenda     = ""
            THIS.this_oBusinessObject.this_cDescGrupoVenda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupGrupoVenda("Descs", loc_oPag.txt_4c_DsGrVda.Value)
    ENDPROC

    *==========================================================================
    * TxtDsGrVdaGotFocus - equivalente ao When do legado em getDsGrVda
    * (Return Empty(This.Parent.getCdGrVda.Value)): a descricao so e
    * editavel enquanto o codigo estiver vazio - com codigo preenchido, o
    * campo serve so para EXIBIR o que o lookup do codigo resolveu, e o
    * foco volta para o campo de codigo.
    *==========================================================================
    PROCEDURE TxtDsGrVdaGotFocus()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(loc_oPag.txt_4c_CdGrVda.Value)
            loc_oPag.txt_4c_CdGrVda.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoVenda - fwbuscaext(SigCdCol) do legado ->
    * FormBuscaAuxiliar. par_cCampoBusca - "Colecoes" (busca por codigo) ou
    * "Descs" (busca por descricao). Mesmo contrato de AbrirLookupMoeda
    * (regra #37/#50).
    *==========================================================================
    PROCEDURE AbrirLookupGrupoVenda(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oPag, loc_oBusca, loc_oErro
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaGrVda", par_cCampoBusca, par_cValorBusca, ;
                "Grupo de Venda", .F., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrVda")
                    loc_oPag.txt_4c_CdGrVda.Value = ALLTRIM(cursor_4c_BuscaGrVda.Colecoes)
                    loc_oPag.txt_4c_DsGrVda.Value = ALLTRIM(cursor_4c_BuscaGrVda.Descs)
                    THIS.this_oBusinessObject.this_cGrupoVenda     = loc_oPag.txt_4c_CdGrVda.Value
                    THIS.this_oBusinessObject.this_cDescGrupoVenda = loc_oPag.txt_4c_DsGrVda.Value
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrVda")
                USE IN cursor_4c_BuscaGrVda
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupoVenda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCdSgrupoLostFocus / TxtDsSgrupoLostFocus - sincronizam o Subgrupo
    * digitado com o BO e resolvem via lookup fwbuscaext (SigCdPsg no
    * legado -> FormBuscaAuxiliar, THIS.AbrirLookupSubgrupo). O legado nao
    * passa filtro de Grupo (lcCgru = [] no Valid original) - a busca e
    * SEMPRE pelo universo inteiro de SigCdPsg, igual ao legado.
    *==========================================================================
    PROCEDURE TxtCdSgrupoLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtCdSgrupoLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtCdSgrupoLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c__cd_sgrupo.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c__cd_sgrupo.Value, "")))

        IF EMPTY(loc_oPag.txt_4c__cd_sgrupo.Value)
            loc_oPag.txt_4c__ds_sgrupo.Value = ""
            THIS.this_oBusinessObject.this_cSubGrupo     = ""
            THIS.this_oBusinessObject.this_cDescSubGrupo = ""
            RETURN
        ENDIF

        THIS.AbrirLookupSubgrupo("Codigos", loc_oPag.txt_4c__cd_sgrupo.Value)
    ENDPROC

    PROCEDURE TxtDsSgrupoLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtDsSgrupoLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtDsSgrupoLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c__ds_sgrupo.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c__ds_sgrupo.Value, "")))

        IF EMPTY(loc_oPag.txt_4c__ds_sgrupo.Value)
            loc_oPag.txt_4c__cd_sgrupo.Value = ""
            THIS.this_oBusinessObject.this_cSubGrupo     = ""
            THIS.this_oBusinessObject.this_cDescSubGrupo = ""
            RETURN
        ENDIF

        THIS.AbrirLookupSubgrupo("Descricaos", loc_oPag.txt_4c__ds_sgrupo.Value)
    ENDPROC

    *==========================================================================
    * AbrirLookupSubgrupo - fwbuscaext(SigCdPsg) do legado ->
    * FormBuscaAuxiliar. par_cCampoBusca - "Codigos" (busca por codigo) ou
    * "Descricaos" (busca por descricao). Mesmo contrato de
    * AbrirLookupMoeda/AbrirLookupGrupoVenda (regra #37/#50).
    *==========================================================================
    PROCEDURE AbrirLookupSubgrupo(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oPag, loc_oBusca, loc_oErro
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaSubgrupo", par_cCampoBusca, par_cValorBusca, ;
                "Sub-Grupos", .F., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "Sub-Grupo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSubgrupo")
                    loc_oPag.txt_4c__cd_sgrupo.Value = ALLTRIM(cursor_4c_BuscaSubgrupo.Codigos)
                    loc_oPag.txt_4c__ds_sgrupo.Value = ALLTRIM(cursor_4c_BuscaSubgrupo.Descricaos)
                    THIS.this_oBusinessObject.this_cSubGrupo     = loc_oPag.txt_4c__cd_sgrupo.Value
                    THIS.this_oBusinessObject.this_cDescSubGrupo = loc_oPag.txt_4c__ds_sgrupo.Value
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaSubgrupo")
                USE IN cursor_4c_BuscaSubgrupo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupSubgrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGradesMarcacao - Grades de marcacao da Pagina 1 (empresas,
    * tipos de operacao, grande grupo, grupo de produtos, operacoes) + os
    * botoes que marcam/desmarcam em lote + o grupo Consultar/Sair
    * (cmgFiltros no legado). Cria so a CASCA dos grids (sem RecordSource -
    * os cursores ainda nao existem aqui): THIS.CarregarDados() liga
    * o RecordSource depois que this_oBusinessObject.CarregarFiltrosIniciais()
    * roda (regra #41 - ControlSource antes do cursor existir derruba o Init).
    *
    * Nomes dos grids NAO seguem mapeamento.json (que colide os 5 grids em
    * "grd_4c_Dados" - mapeamento gerado automaticamente por classe-base,
    * sem distinguir irmaos): usar os nomes conceituais, os mesmos dos
    * cursores do BO (cursor_4c_Empresas/TiposOperacao/GrandeGrupo/
    * GrupoProduto/Operacoes).
    *==========================================================================
    * O CheckBox de LINHA de cada grade NAO nasce aqui: criar
    * Column1.AddObject("Check1","CheckBox") neste ponto estoura
    * "Error with CHECK1 - Value : Data type mismatch" e a tela nao abre,
    * porque o Grid sem RecordSource se auto-liga ao alias CORRENTE quando o
    * ColumnCount e definido. O CheckBox e instalado no funil CarregarDados,
    * depois do bind - ver o comentario la.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradesMarcacao(par_oPag)

        *-- grd_4c_Empresas (grdEmps no legado): marcacao (Imps) + Cod (cemps)
        *-- + Empresa (razas). O CheckBox desta grade NAO leva BINDEVENT - no
        *-- legado os 4 handlers de grdEmps.Column1.Check1 estao COMENTADOS
        *-- no SCX, ou seja o toggle individual da celula e NATIVO
        *-- (Column1.ReadOnly = .F.) e a marcacao em lote vem de
        *-- cmg_4c_Empresas e chk_4c_Ck_MarcaEmp.
        par_oPag.AddObject("grd_4c_Empresas", "Grid")
        WITH par_oPag.grd_4c_Empresas
            .Top               = 238
            .Left              = 71
            .Width             = 318
            .Height            = 410
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .ForeColor         = RGB(0, 0, 0)
            .GridLineColor     = RGB(238, 238, 238)
            *-- Grid.ReadOnly ANTES dos Column.ReadOnly (regra #18): o do grid
            *-- propaga para as colunas e sobrescreveria o que vem depois.
            *-- .F. transcrito do montagrades legado (grdEmps e a UNICA das 5
            *-- grades cuja Column1 e editavel nativamente - as outras 4
            *-- travam Column1 e alternam so pelos handlers com NODEFAULT).
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH
        WITH par_oPag.grd_4c_Empresas.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        par_oPag.grd_4c_Empresas.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_Empresas.Column1.Header1.ForeColor = RGB(90, 90, 90)
        *-- Column2/Column3: "For I=2 To .ColumnCount" do montagrades legado
        WITH par_oPag.grd_4c_Empresas.Column2
            .Width     = 33
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        par_oPag.grd_4c_Empresas.Column2.Header1.Caption   = "Cod."
        par_oPag.grd_4c_Empresas.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_Empresas.Column2.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_Empresas.Column3
            .Width     = 247
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        par_oPag.grd_4c_Empresas.Column3.Header1.Caption   = "Empresa"
        par_oPag.grd_4c_Empresas.Column3.Header1.Alignment = 2
        par_oPag.grd_4c_Empresas.Column3.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmg_4c_Empresas (cmdEmps no legado): Marcar/Desmarcar Tudo de Empresas
        par_oPag.AddObject("cmg_4c_Empresas", "CommandGroup")
        WITH par_oPag.cmg_4c_Empresas
            .Top         = 382
            .Left        = 388
            .Width       = 50
            .Height      = 91
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            WITH .Buttons(1)
                .Top         = 1
                .Left        = 4
                .Width       = 45
                .Height      = 45
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .Caption     = ""
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .ToolTipText = "Marcar Todas as Empresas"
                .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            ENDWITH
            WITH .Buttons(2)
                .Top         = 46
                .Left        = 4
                .Width       = 45
                .Height      = 45
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .Caption     = ""
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .ToolTipText = "Desmarcar Todas as Empresas"
                .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- chk_4c_Ck_MarcaEmp (ck_MarcaEmp no legado) - Top/Left EXATOS do
        *-- SCX (Left = -2, quase fora da pagina - transcrito fielmente,
        *-- regra #28/PILAR 1: nao inventar posicao nova)
        par_oPag.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
        WITH par_oPag.chk_4c_Ck_MarcaEmp
            .Top       = 314
            .Left      = -2
            .Width     = 13
            .Height    = 16
            .Alignment = 0
            .Caption   = ""
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        *-- grd_4c_Tipos (grdTipo no legado): marcacao (nMarcas) + Tipo de Operacao
        par_oPag.AddObject("grd_4c_Tipos", "Grid")
        WITH par_oPag.grd_4c_Tipos
            .Top            = 238
            .Left           = 469
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .BackColor      = RGB(255, 255, 244)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_Tipos.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Tipos.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_Tipos.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_Tipos.Column2
            .Width     = 282
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Tipos.Column2.Header1.Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
        par_oPag.grd_4c_Tipos.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_Tipos.Column2.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmd_4c_BtnMarca / cmd_4c_BtnDesmarca: marca/desmarca TODOS os
        *-- Tipos de Operacao e TODAS as Operacoes (btnMarca/btnDesmarca no
        *-- legado - coluna de botoes a direita de grd_4c_Tipos)
        par_oPag.AddObject("cmd_4c_BtnMarca", "CommandButton")
        WITH par_oPag.cmd_4c_BtnMarca
            .Top         = 286
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar Tudo"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_BtnDesmarca", "CommandButton")
        WITH par_oPag.cmd_4c_BtnDesmarca
            .Top         = 331
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar Tudo"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- cmd_4c_Command1 / cmd_4c_Command2: marca/desmarca so as
        *-- Operacoes do Tipo de Operacao CORRENTE em grd_4c_Tipos
        *-- (Command1/Command2 no legado, mesma coluna, mais abaixo)
        par_oPag.AddObject("cmd_4c_Command1", "CommandButton")
        WITH par_oPag.cmd_4c_Command1
            .Top         = 489
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar Tudo"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_Command2", "CommandButton")
        WITH par_oPag.cmd_4c_Command2
            .Top         = 534
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar Tudo"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- grd_4c_GrandeGrupo (grdMercs no legado): marcacao (nMarcas) + Grande Grupo
        par_oPag.AddObject("grd_4c_GrandeGrupo", "Grid")
        WITH par_oPag.grd_4c_GrandeGrupo
            .Top            = 238
            .Left           = 880
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_GrandeGrupo.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrandeGrupo.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_GrandeGrupo.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_GrandeGrupo.Column2
            .Width     = 283
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrandeGrupo.Column2.Header1.Caption   = "Grande Grupo"
        par_oPag.grd_4c_GrandeGrupo.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_GrandeGrupo.Column2.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmd_4c_BtnMarGde / cmd_4c_BtnDesGde: marca/desmarca TODO o
        *-- Grande Grupo (e em cascata o Grupo de Produto - BtnMarGdeClick/
        *-- BtnDesGdeClick)
        par_oPag.AddObject("cmd_4c_BtnMarGde", "CommandButton")
        WITH par_oPag.cmd_4c_BtnMarGde
            .Top         = 286
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_BtnDesGde", "CommandButton")
        WITH par_oPag.cmd_4c_BtnDesGde
            .Top         = 331
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- grd_4c_GrupoProduto (grdCGrus no legado): marcacao (nMarcas) + Gde + Grupo de Produto
        par_oPag.AddObject("grd_4c_GrupoProduto", "Grid")
        WITH par_oPag.grd_4c_GrupoProduto
            .Top            = 446
            .Left           = 880
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 3
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_GrupoProduto.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrupoProduto.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_GrupoProduto.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_GrupoProduto.Column2
            .Width     = 30
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrupoProduto.Column2.Header1.Caption   = "Gde"
        par_oPag.grd_4c_GrupoProduto.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_GrupoProduto.Column2.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_GrupoProduto.Column3
            .Width     = 252
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        par_oPag.grd_4c_GrupoProduto.Column3.Header1.Caption   = "Grupo de Produto"
        par_oPag.grd_4c_GrupoProduto.Column3.Header1.Alignment = 2
        par_oPag.grd_4c_GrupoProduto.Column3.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmd_4c_BtnMarGrp / cmd_4c_BtnDesGrp: marca/desmarca o Grupo de
        *-- Produto (btnMarGrp so marca onde o Grande Grupo pai ja esta
        *-- marcado - igual ao legado)
        par_oPag.AddObject("cmd_4c_BtnMarGrp", "CommandButton")
        WITH par_oPag.cmd_4c_BtnMarGrp
            .Top         = 489
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_BtnDesGrp", "CommandButton")
        WITH par_oPag.cmd_4c_BtnDesGrp
            .Top         = 534
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- grd_4c_Operacoes (GrdOpera no legado): marcacao (nMarcas) + Operacoes (Dopes)
        par_oPag.AddObject("grd_4c_Operacoes", "Grid")
        WITH par_oPag.grd_4c_Operacoes
            .Top            = 446
            .Left           = 470
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .BackColor      = RGB(255, 255, 244)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_Operacoes.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Operacoes.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_Operacoes.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_Operacoes.Column2
            .Width     = 282
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Operacoes.Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
        par_oPag.grd_4c_Operacoes.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_Operacoes.Column2.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmg_4c_Filtros (cmgFiltros no legado): Consultar / Sair
        par_oPag.AddObject("cmg_4c_Filtros", "CommandGroup")
        WITH par_oPag.cmg_4c_Filtros
            .Top         = -1
            .Left        = 1135
            .Width       = 173
            .Height      = 110
            .ButtonCount = 2
            .Value       = 0
            WITH .Buttons(1)
                .Top         = 5
                .Left        = 11
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Caption     = "\<Consultar"
                .ToolTipText = "Consultar Usando os Filtros Informados"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            ENDWITH
            WITH .Buttons(2)
                .Top         = 5
                .Left        = 87
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Cancel      = .T.
                .Caption     = "\<Sair"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL unico de bind + repintura das 5 grades de
    * marcacao. Equivalente ao montagrades() do legado, que faz exatamente
    * este bind para grdTipo/grdOpera/grdMercs/grdCGrus/grdEmps.
    *
    * A ORDEM abaixo e OBRIGATORIA e foi medida no VFP9:
    *   ColumnCount -> RecordSource -> ControlSource de TODAS as colunas ->
    *   AddObject do CheckBox (+ .Value = 0) -> Sparse + CurrentControl ->
    *   Grid.ReadOnly -> Column.ReadOnly -> Width -> Header1.Caption
    *
    * Por que o CheckBox NAO pode nascer em ConfigurarGradesMarcacao: Grid
    * sem RecordSource atribuida se liga sozinho ao alias CORRENTE no momento
    * em que o ColumnCount e definido. Com isso a Column1 herda o
    * ControlSource de uma coluna qualquer desse alias; se ela for CHARACTER,
    * o Column1.AddObject("Check1","CheckBox") estoura no PROPRIO AddObject
    * com "Error with CHECK1 - Value : Data type mismatch", o erro cai no TRY
    * do InicializarForm, CREATEOBJECT devolve .F. e a TELA NAO ABRE - sem
    * erro visivel e compilando limpo (medido no probe desta fase).
    *
    * E por que o funil, e nao o ConfigurarGrid: fechar/recriar o alias que e
    * RecordSource do Grid DESTROI o objeto posto por Column.AddObject (a
    * Column volta a desenhar o Text1 e o usuario ve 0/1 cru, sem como
    * marcar). Por isso a instalacao do CheckBox e IDEMPOTENTE
    * (GarantirCheckBoxColuna) e os BINDEVENT vao JUNTO com ela - objeto
    * recriado e outro objeto, e as ligacoes do anterior morreram com ele.
    *
    * Fecha cada grade com GO TOP + Refresh: popular o cursor NAO repinta a
    * grade sozinho.
    *
    * As grades de RESULTADO (pgRes01/02/03 -> grd_4c_Dados1/2/3), que no
    * legado sao ligadas pelo MESMO montagrades, entram na Fase 7 - e o bind
    * delas vem para este mesmo funil.
    *==========================================================================
    *-- PUBLIC (nao PROTECTED): e o funil de repintura, chamado de fora pelo
    *-- harness de teste e pelos caminhos de recarga.
    PROCEDURE CarregarDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Empresas: a UNICA das 5 cuja Column1 e editavel nativamente
        *-- (montagrades legado: grdEmps.Column1.ReadOnly = .F.)
        IF USED("cursor_4c_Empresas")
            WITH loc_oPag.grd_4c_Empresas
                .ColumnCount             = 3
                .RecordSource            = "cursor_4c_Empresas"
                .Column1.ControlSource   = "cursor_4c_Empresas.Imps"
                .Column2.ControlSource   = "cursor_4c_Empresas.cemps"
                .Column3.ControlSource   = "cursor_4c_Empresas.razas"
            ENDWITH
            *-- sem prefixo de handler: no SCX legado os 4 handlers de
            *-- grdEmps.Column1.Check1 estao COMENTADOS, ou seja o toggle
            *-- individual e nativo (Column1.ReadOnly = .F.) e a marcacao em
            *-- lote vem de cmg_4c_Empresas / chk_4c_Ck_MarcaEmp.
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Empresas.Column1, "", .F., .F.)
            WITH loc_oPag.grd_4c_Empresas
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .ReadOnly                 = .F.
                .Column1.ReadOnly         = .F.
                .Column2.ReadOnly         = .T.
                .Column3.ReadOnly         = .T.
                .Column1.Width            = 15
                .Column2.Width            = 33
                .Column3.Width            = 247
                .Column2.Header1.Caption  = "Cod."
                .Column3.Header1.Caption  = "Empresa"
            ENDWITH
            GO TOP IN cursor_4c_Empresas
            loc_oPag.grd_4c_Empresas.Refresh()
        ENDIF

        *-- Tipos de Operacao
        IF USED("cursor_4c_TiposOperacao")
            WITH loc_oPag.grd_4c_Tipos
                .ColumnCount             = 2
                .RecordSource            = "cursor_4c_TiposOperacao"
                .Column1.ControlSource   = "cursor_4c_TiposOperacao.nMarcas"
                .Column2.ControlSource   = "cursor_4c_TiposOperacao.CDescricaos"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Tipos.Column1, "ChkTipo", .T., .T.)
            WITH loc_oPag.grd_4c_Tipos
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 282
                .Column2.Header1.Caption  = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH
            GO TOP IN cursor_4c_TiposOperacao
            loc_oPag.grd_4c_Tipos.Refresh()
        ENDIF

        *-- Grande Grupo
        IF USED("cursor_4c_GrandeGrupo")
            WITH loc_oPag.grd_4c_GrandeGrupo
                .ColumnCount             = 2
                .RecordSource            = "cursor_4c_GrandeGrupo"
                .Column1.ControlSource   = "cursor_4c_GrandeGrupo.nMarcas"
                .Column2.ControlSource   = "cursor_4c_GrandeGrupo.CDescricaos"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrandeGrupo.Column1, "ChkGrandeGrupo", .T., .F.)
            WITH loc_oPag.grd_4c_GrandeGrupo
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 283
                .Column2.Header1.Caption  = "Grande Grupo"
            ENDWITH
            GO TOP IN cursor_4c_GrandeGrupo
            loc_oPag.grd_4c_GrandeGrupo.Refresh()
        ENDIF

        *-- Grupo de Produto
        IF USED("cursor_4c_GrupoProduto")
            WITH loc_oPag.grd_4c_GrupoProduto
                .ColumnCount             = 3
                .RecordSource            = "cursor_4c_GrupoProduto"
                .Column1.ControlSource   = "cursor_4c_GrupoProduto.nMarcas"
                .Column2.ControlSource   = "cursor_4c_GrupoProduto.Mercs"
                .Column3.ControlSource   = "cursor_4c_GrupoProduto.CDescricaos"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrupoProduto.Column1, "ChkGrupoProduto", .T., .F.)
            WITH loc_oPag.grd_4c_GrupoProduto
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column3.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 30
                .Column3.Width            = 252
                .Column2.Header1.Caption  = "Gde"
                .Column3.Header1.Caption  = "Grupo de Produto"
            ENDWITH
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF

        *-- Operacoes
        IF USED("cursor_4c_Operacoes")
            WITH loc_oPag.grd_4c_Operacoes
                .ColumnCount             = 2
                .RecordSource            = "cursor_4c_Operacoes"
                .Column1.ControlSource   = "cursor_4c_Operacoes.nMarcas"
                .Column2.ControlSource   = "cursor_4c_Operacoes.Dopes"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Operacoes.Column1, "ChkOperacao", .T., .T.)
            WITH loc_oPag.grd_4c_Operacoes
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 282
                .Column2.Header1.Caption  = "Opera" + CHR(231) + CHR(245) + "es"
            ENDWITH
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GarantirCheckBoxColuna - instalador IDEMPOTENTE do CheckBox de marcacao
    * de uma Column de Grid. Chamado SO depois de RecordSource/ControlSource
    * estarem ligados (ver comentario de CarregarDados).
    *
    *   par_oColuna    - a Column que recebe o controle
    *   par_cPrefixo   - prefixo dos handlers de alternancia ("ChkTipo", ...);
    *                    vazio = coluna com toggle NATIVO, sem BINDEVENT
    *   par_lGeometria - transcreve Top/Left/Width/Height/Alignment do SCX
    *   par_lBackColor - transcreve BackColor branco do SCX
    *
    * Sai sem fazer nada se o controle ainda existe: AddObject repetido com o
    * mesmo nome estoura "Object CHECK1 is already defined". Os BINDEVENT vao
    * JUNTO porque um objeto recriado e outro objeto - sem religar, os quatro
    * handlers de alternancia ficam MUDOS (o CheckBox aparece e nao alterna).
    *==========================================================================
    PROTECTED PROCEDURE GarantirCheckBoxColuna(par_oColuna, par_cPrefixo, par_lGeometria, par_lBackColor)
        IF PEMSTATUS(par_oColuna, "Check1", 5)
            RETURN
        ENDIF

        par_oColuna.AddObject("Check1", "CheckBox")

        WITH par_oColuna.Check1
            .Caption   = ""
            *-- .Value NUMERICO (nunca .F.): a Column esta ligada a coluna
            *-- numerica de marcacao e CheckBox logico daria type mismatch.
            .Value     = 0
            .ForeColor = RGB(0, 0, 0)
            IF par_lGeometria
                .Top       = 23
                .Left      = 35
                .Width     = 60
                .Height    = 17
                .Alignment = 0
            ENDIF
            IF par_lBackColor
                .BackColor = RGB(255, 255, 255)
            ENDIF
            .Visible   = .T.
        ENDWITH

        IF !EMPTY(par_cPrefixo)
            *-- Os 4 handlers do legado: Click/MouseDown so SUPRIMEM o toggle
            *-- nativo (NODEFAULT) e MouseUp delega ao KeyPress, que e quem
            *-- faz o REPLACE e o Refresh.
            BINDEVENT(par_oColuna.Check1, "KeyPress",  THIS, par_cPrefixo + "KeyPress")
            BINDEVENT(par_oColuna.Check1, "MouseUp",   THIS, par_cPrefixo + "MouseUp")
            BINDEVENT(par_oColuna.Check1, "MouseDown", THIS, par_cPrefixo + "MouseDown")
            BINDEVENT(par_oColuna.Check1, "Click",     THIS, par_cPrefixo + "Click")
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsFiltros - BINDEVENTs dos botoes e grupos de
    * marcar/desmarcar/consultar/sair da pagina de filtros.
    *
    * Os BINDEVENT dos CheckBox de LINHA das grades NAO moram aqui: eles vao
    * dentro de GarantirCheckBoxColuna, junto com o AddObject que cria o
    * controle. Motivo: o controle de Column pode ser destruido quando o
    * alias do RecordSource e fechado/recriado, e o objeto reinstalado e
    * OUTRO objeto - religar fora do instalador deixaria os handlers mudos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Botoes em lote
        BINDEVENT(loc_oPag.cmd_4c_BtnMarca,    "Click", THIS, "BtnMarcaClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesmarca, "Click", THIS, "BtnDesmarcaClick")
        BINDEVENT(loc_oPag.cmd_4c_Command1,    "Click", THIS, "Command1Click")
        BINDEVENT(loc_oPag.cmd_4c_Command2,    "Click", THIS, "Command2Click")
        BINDEVENT(loc_oPag.cmd_4c_BtnMarGde,   "Click", THIS, "BtnMarGdeClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesGde,   "Click", THIS, "BtnDesGdeClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnMarGrp,   "Click", THIS, "BtnMarGrpClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesGrp,   "Click", THIS, "BtnDesGrpClick")

        *-- Empresas (marcar/desmarcar tudo)
        BINDEVENT(loc_oPag.cmg_4c_Empresas,     "Click", THIS, "CmdEmpsClick")
        BINDEVENT(loc_oPag.chk_4c_Ck_MarcaEmp, "Click", THIS, "CkMarcaEmpClick")

        *-- Consultar / Sair
        BINDEVENT(loc_oPag.cmg_4c_Filtros, "Click", THIS, "CmgFiltrosClick")

        *-- Periodo (Fase 5 - Parte 1)
        BINDEVENT(loc_oPag.txt_4c_DataIni,  "LostFocus", THIS, "TxtDataIniLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DataFim,  "LostFocus", THIS, "TxtDataFimLostFocus")

        *-- Moeda de Conversao - lookup fwbuscaext(SigCdMoe) (Fase 6)
        BINDEVENT(loc_oPag.txt_4c_CodMoeda,  "LostFocus", THIS, "TxtCodMoedaLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DescMoeda, "LostFocus", THIS, "TxtDescMoedaLostFocus")

        *-- Grupo de Venda - lookup fwbuscaext(SigCdCol) (Fase 6)
        BINDEVENT(loc_oPag.txt_4c_CdGrVda, "LostFocus", THIS, "TxtCdGrVdaLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DsGrVda, "LostFocus", THIS, "TxtDsGrVdaLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DsGrVda, "GotFocus",  THIS, "TxtDsGrVdaGotFocus")

        *-- Subgrupo - lookup fwbuscaext(SigCdPsg) (Fase 6)
        BINDEVENT(loc_oPag.txt_4c__cd_sgrupo, "LostFocus", THIS, "TxtCdSgrupoLostFocus")
        BINDEVENT(loc_oPag.txt_4c__ds_sgrupo, "LostFocus", THIS, "TxtDsSgrupoLostFocus")

        *-- Tipo de Operacao corrente FILTRA a grade de Operacoes
        *-- (grdTipo.AfterRowColChange no legado)
        BINDEVENT(loc_oPag.grd_4c_Tipos, "AfterRowColChange", THIS, "GrdTiposAfterRowColChange")
    ENDPROC

    *==========================================================================
    * GrdTiposAfterRowColChange - grdTipo.AfterRowColChange no legado:
    *
    *   Select CrOpera
    *   Set Key To crTpOpe.Codigos
    *   Go Top
    *   This.parent.GrdOpera.Refresh
    *   Select crTpOpe
    *
    * Ao trocar de linha na grade de TIPOS, a grade de OPERACOES passa a
    * mostrar SOMENTE as operacoes daquele tipo. O SET KEY depende da TAG
    * IdxTipoOps (criada em BO.CarregarFiltrosIniciais, igual ao Init
    * legado); o SET ORDER explicito abaixo NAO esta no legado - la o tag
    * recem-criado ainda e o controlador - mas aqui garante o resultado
    * mesmo que algum outro ponto troque a ordem do cursor.
    *
    * Chave de UM campo NUMERICO inteiro (SigCdOpe.tipoops numeric(2,0) x
    * SigCdTom.codigos numeric(2,0)): e match EXATO de chave COMPLETA,
    * portanto imune ao SET EXACT ON global do config.prg (a armadilha
    * medida vale para SET KEY com valor PARCIAL de chave composta).
    *
    * Os filtros do Consultar continuam enxergando o cursor INTEIRO: o
    * BO monta a lista de operacoes marcadas com SQL SELECT, e SELECT do
    * VFP9 ignora SET KEY/SET FILTER (medido) - mesma razao pela qual o
    * legado podia conviver com este SET KEY permanente.
    *
    * PUBLIC (sem PROTECTED) por ser alvo de BINDEVENT - regra #3. A
    * assinatura declara o parametro que AfterRowColChange passa.
    *==========================================================================
    PROCEDURE GrdTiposAfterRowColChange(par_nColIndex)
        LOCAL loc_oPag, loc_oErro

        IF !USED("cursor_4c_Operacoes") OR !USED("cursor_4c_TiposOperacao")
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- TRY sem RETURN dentro (regra #1): o handler roda a CADA troca de
        *-- linha e fora de qualquer TRY do chamador - sem isto, cursor sem
        *-- a TAG IdxTipoOps viraria Program Error cru a cada clique.
        TRY
            SELECT cursor_4c_Operacoes
            SET ORDER TO TAG IdxTipoOps
            SET KEY TO cursor_4c_TiposOperacao.Codigos
            GO TOP

            loc_oPag.grd_4c_Operacoes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao filtrar Opera" + CHR(231) + CHR(245) + "es")
        ENDTRY

        SELECT cursor_4c_TiposOperacao
    ENDPROC

    *==========================================================================
    * GRADE TIPOS DE OPERACAO - checkbox Column1 (grdTipo.Column1.Check1 no
    * legado). Ao marcar/desmarcar um Tipo, cascateia para as Operacoes
    * (cursor_4c_Operacoes.nMarcas) daquele Tipo - igual ao legado.
    *==========================================================================
    PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_TiposOperacao")
                REPLACE cursor_4c_TiposOperacao.nMarcas WITH IIF(cursor_4c_TiposOperacao.nMarcas = 0, 1, 0)
                loc_oPag.grd_4c_Tipos.Refresh()
                IF USED("cursor_4c_Operacoes")
                    UPDATE cursor_4c_Operacoes SET nMarcas = cursor_4c_TiposOperacao.nMarcas ;
                        WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
                    loc_oPag.grd_4c_Operacoes.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkTipoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkTipoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRADE GRANDE GRUPO - checkbox Column1 (grdMercs.Column1.Check1 no
    * legado). Ao marcar/desmarcar um Grande Grupo, cascateia para o Grupo
    * de Produto filho (cursor_4c_GrupoProduto.nMarcas) - igual ao legado.
    *==========================================================================
    PROCEDURE ChkGrandeGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_GrandeGrupo")
                REPLACE cursor_4c_GrandeGrupo.nMarcas WITH IIF(cursor_4c_GrandeGrupo.nMarcas = 0, 1, 0)
                loc_oPag.grd_4c_GrandeGrupo.Refresh()
                IF USED("cursor_4c_GrupoProduto")
                    UPDATE cursor_4c_GrupoProduto SET nMarcas = cursor_4c_GrandeGrupo.nMarcas ;
                        WHERE Mercs = cursor_4c_GrandeGrupo.Codigos
                    loc_oPag.grd_4c_GrupoProduto.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkGrandeGrupoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkGrandeGrupoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrandeGrupoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrandeGrupoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRADE GRUPO DE PRODUTO - checkbox Column1 (grdCGrus.Column1.Check1 no
    * legado). Ao MARCAR um Grupo de Produto, exige que o Grande Grupo pai
    * (cursor_4c_GrandeGrupo) ja esteja marcado - senao desfaz e avisa,
    * igual ao legado.
    *==========================================================================
    PROCEDURE ChkGrupoProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cMercsPai
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_GrupoProduto")
                REPLACE cursor_4c_GrupoProduto.nMarcas WITH IIF(cursor_4c_GrupoProduto.nMarcas = 0, 1, 0)

                IF cursor_4c_GrupoProduto.nMarcas = 1 AND USED("cursor_4c_GrandeGrupo")
                    loc_cMercsPai = cursor_4c_GrupoProduto.Mercs
                    SELECT cursor_4c_GrandeGrupo
                    LOCATE FOR Codigos = loc_cMercsPai
                    IF !FOUND() OR cursor_4c_GrandeGrupo.nMarcas = 0
                        SELECT cursor_4c_GrupoProduto
                        REPLACE nMarcas WITH 0
                        MsgAviso("O Grande Grupo " + CHR(34) + ALLTRIM(loc_cMercsPai) + CHR(34) + " N" + CHR(227) + "o Foi Selecionado." + CHR(13) + ;
                            "Para Selecionar Esse Grupo, Ajuste o Grande Grupo!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                    ENDIF
                ENDIF

                SELECT cursor_4c_GrupoProduto
                loc_oPag.grd_4c_GrupoProduto.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkGrupoProdutoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkGrupoProdutoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrupoProdutoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrupoProdutoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRADE OPERACOES - checkbox Column1 (GrdOpera.Column1.Check1 no legado)
    *==========================================================================
    PROCEDURE ChkOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_Operacoes")
                REPLACE cursor_4c_Operacoes.nMarcas WITH IIF(cursor_4c_Operacoes.nMarcas = 0, 1, 0)
                loc_oPag.grd_4c_Operacoes.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkOperacaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkOperacaoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkOperacaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkOperacaoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * Command1Click / Command2Click - marcam/desmarcam so as Operacoes do
    * Tipo de Operacao CORRENTE em grd_4c_Tipos (Command1/Command2 no legado)
    *==========================================================================
    PROCEDURE Command1Click()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_Operacoes SET nMarcas = 1 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Command2Click()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_Operacoes SET nMarcas = 0 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMarcaClick / BtnDesmarcaClick - marcam/desmarcam TODOS os Tipos de
    * Operacao e TODAS as Operacoes (btnMarca/btnDesmarca no legado)
    *==========================================================================
    PROCEDURE BtnMarcaClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_TiposOperacao SET nMarcas = 1
            GO TOP IN cursor_4c_TiposOperacao
            loc_oPag.grd_4c_Tipos.Refresh()
        ENDIF
        IF USED("cursor_4c_Operacoes")
            UPDATE cursor_4c_Operacoes SET nMarcas = 1
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcaClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_TiposOperacao SET nMarcas = 0
            GO TOP IN cursor_4c_TiposOperacao
            loc_oPag.grd_4c_Tipos.Refresh()
        ENDIF
        IF USED("cursor_4c_Operacoes")
            UPDATE cursor_4c_Operacoes SET nMarcas = 0
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMarGdeClick / BtnDesGdeClick - marcam/desmarcam TODO o Grande Grupo
    * e TODO o Grupo de Produto (btnMarGde/btnDesGde no legado)
    *==========================================================================
    PROCEDURE BtnMarGdeClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrandeGrupo")
            UPDATE cursor_4c_GrandeGrupo SET nMarcas = 1
            GO TOP IN cursor_4c_GrandeGrupo
            loc_oPag.grd_4c_GrandeGrupo.Refresh()
        ENDIF
        IF USED("cursor_4c_GrupoProduto")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 1
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesGdeClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrandeGrupo")
            UPDATE cursor_4c_GrandeGrupo SET nMarcas = 0
            GO TOP IN cursor_4c_GrandeGrupo
            loc_oPag.grd_4c_GrandeGrupo.Refresh()
        ENDIF
        IF USED("cursor_4c_GrupoProduto")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMarGrpClick / BtnDesGrpClick - marcam/desmarcam o Grupo de Produto
    * (btnMarGrp/btnDesGrp no legado). Marcar so afeta linhas cujo Grande
    * Grupo pai JA ESTA marcado (igual ao legado).
    *==========================================================================
    PROCEDURE BtnMarGrpClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrupoProduto") AND USED("cursor_4c_GrandeGrupo")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 1 ;
                WHERE Mercs IN (SELECT Codigos FROM cursor_4c_GrandeGrupo WHERE nMarcas = 1)
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesGrpClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrupoProduto")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEmpsClick - cmg_4c_Empresas (cmdEmps no legado): Buttons(1) marca
    * Imps = 1 em todas as Empresas, Buttons(2) desmarca (Imps = 0).
    * O legado escreve "Set Imps = (This.Value = 1)" porque la a coluna eh
    * bit/logica; aqui Imps eh NUMERICA (CheckBox.Value eh numerico), por
    * isso o IIF explicito - atribuir o Logico direto estoura type mismatch.
    *==========================================================================
    PROCEDURE CmdEmpsClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Empresas")
            UPDATE cursor_4c_Empresas SET Imps = IIF(loc_oPag.cmg_4c_Empresas.Value = 1, 1, 0)
            GO TOP IN cursor_4c_Empresas
            loc_oPag.grd_4c_Empresas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CkMarcaEmpClick - chk_4c_Ck_MarcaEmp (ck_MarcaEmp no legado): marca/
    * desmarca TODAS as Empresas de uma vez
    *==========================================================================
    PROCEDURE CkMarcaEmpClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Empresas")
            *-- Imps eh NUMERICA (CheckBox.Value eh numerico): 1/0, nao .T./.F.
            IF loc_oPag.chk_4c_Ck_MarcaEmp.Value = 1
                REPLACE ALL Imps WITH 1 IN cursor_4c_Empresas
            ELSE
                REPLACE ALL Imps WITH 0 IN cursor_4c_Empresas
            ENDIF
            GO TOP IN cursor_4c_Empresas
            loc_oPag.grd_4c_Empresas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmgFiltrosClick - cmg_4c_Filtros (cmgFiltros no legado): Buttons(1)
    * "Consultar" valida o periodo e dispara a consulta; Buttons(2) "Sair"
    * encerra o form.
    *==========================================================================
    PROCEDURE CmgFiltrosClick()
        DO CASE
            CASE THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros.Value = 1
                THIS.BtnConsultarClick()
            CASE THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros.Value = 2
                THIS.BtnSairClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnConsultarClick - Buttons(1) "Consultar" (btnConsultar no legado).
    * Valida periodo/moeda/Tipo de Operacao marcado/Grande Grupo marcado
    * (mesmas guardas do btnConsultar.Click legado) e dispara a consulta
    * (Processamento() do legado -> THIS.this_oBusinessObject.Processar()).
    *
    * Apos o sucesso, reproduz o fim de Processamento(): optValor1.Value=3
    * ("Sem Filtro"), THIS.Filtros(1,3) (ordem/refresh de grd_4c_Dados1),
    * ActivePage=2 (Pagina de Dados), pgf_4c_Resultados.ActivePage=1
    * (Detalhamento) e a atualizacao do painel lateral (equivalente ao
    * grdDados1.AfterRowColChange() chamado a mao no fim do legado).
    *==========================================================================
    PROCEDURE BtnConsultarClick()
        LOCAL loc_oPag, loc_dIni, loc_dFim, loc_lSucesso

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_dIni = THIS.this_oBusinessObject.this_dDataIni
        loc_dFim = THIS.this_oBusinessObject.this_dDataFim

        IF EMPTY(loc_dIni)
            MsgAviso("A Data Inicial N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF EMPTY(loc_dFim)
            MsgAviso("A Data Final N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF loc_dIni > loc_dFim
            MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_oBusinessObject.this_cMoeda)
            MsgAviso("A Moeda Para Convers" + CHR(227) + "o Precisa Ser Informada!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_TiposOperacao")
            SELECT CCodigos FROM cursor_4c_TiposOperacao WHERE nMarcas = 1 INTO CURSOR cursor_4c_VerificaTipos
            IF RECCOUNT("cursor_4c_VerificaTipos") = 0
                USE IN cursor_4c_VerificaTipos
                MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
                RETURN .F.
            ENDIF
            USE IN cursor_4c_VerificaTipos
        ENDIF

        IF USED("cursor_4c_GrandeGrupo")
            SELECT Codigos FROM cursor_4c_GrandeGrupo WHERE nMarcas = 1 INTO CURSOR cursor_4c_VerificaGde
            IF RECCOUNT("cursor_4c_VerificaGde") = 0
                USE IN cursor_4c_VerificaGde
                MsgAviso("Nenhum Grande Grupo Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
                RETURN .F.
            ENDIF
            USE IN cursor_4c_VerificaGde
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dIni, loc_dFim, ;
            THIS.this_oBusinessObject.this_cMoeda, THIS.this_oBusinessObject.this_cGrupoVenda, ;
            THIS.this_oBusinessObject.this_cSubGrupo)

        IF loc_lSucesso
            THIS.this_oBusinessObject.this_nTipoValor = 3
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.optValor1.Value = 3
            THIS.Filtros(1, 3)

            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.ActivePage = 1

            THIS.AtualizarPainelDetalheRegistro()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnSairClick - Buttons(2) "Sair" (btnSair no legado, Cancel=.T. ->
    * ESC). Persiste a configuracao de colunas de grd_4c_Dados1
    * (AcertaColunas('GRAVAR')) antes de fechar, igual ao legado.
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.AcertaColunas("GRAVAR")
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 (pgDados no legado). PageFrame interno
    * pgResults -> pgf_4c_Resultados (3 paginas: Detalhamento/Totais por
    * Empresa/Totais por Vendedora) + os botoes de navegacao/exportacao
    * (cmgRetornar/btnExportar/btnExcel), que no legado ficam direto em
    * pgDados, FORA do PageFrame interno (por isso aparecem nas 3 abas).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page2

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            loc_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        *-- pgResults: Top=2 Left=-1 Width=1304 Height=600 PageCount=3
        loc_oPag.AddObject("pgf_4c_Resultados", "PageFrame")
        WITH loc_oPag.pgf_4c_Resultados
            .Top       = 2
            .Left      = -1
            .Width     = 1304
            .Height    = 600
            .PageCount = 3
            .Visible   = .T.
        ENDWITH

        THIS.ConfigurarAbaDetalhamento(loc_oPag.pgf_4c_Resultados.Page1)
        THIS.ConfigurarAbaTotalEmpresa(loc_oPag.pgf_4c_Resultados.Page2)
        THIS.ConfigurarAbaTotalVendedora(loc_oPag.pgf_4c_Resultados.Page3)

        *-- cmgRetornar (cmgRetornar no legado): volta para a Pagina 1
        *-- (Filtros)
        loc_oPag.AddObject("cmg_4c_Retornar", "CommandGroup")
        WITH loc_oPag.cmg_4c_Retornar
            .Top         = 62
            .Left        = 1193
            .Width       = 80
            .Height      = 80
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            WITH .Buttons(1)
                .Top         = 0
                .Left        = 0
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Cancel      = .T.
                .Caption     = "Retornar"
                .ToolTipText = "Retornar aos Filtros"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- btnExportar / btnExcel (fwbtng no legado): exportam o resultado
        *-- da ABA CORRENTE de pgf_4c_Resultados para TXT/XLS
        loc_oPag.AddObject("cmd_4c_Exportar", "CommandButton")
        WITH loc_oPag.cmd_4c_Exportar
            .Top         = 62
            .Left        = 1116
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Exporta TXT"
            .ToolTipText = "Gerar TXT Tabulado Para Importa" + CHR(231) + CHR(227) + "o em Excel"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        loc_oPag.AddObject("cmd_4c_Excel", "CommandButton")
        WITH loc_oPag.cmd_4c_Excel
            .Top         = 62
            .Left        = 1040
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Exporta XLS"
            .ToolTipText = "Gerar Planilha XLS"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarBindEventsResultados()

        *-- Page NAO tem a propriedade Visible (a Page e exibida pelo
        *-- ActivePage do PageFrame). Atribuir estoura "Property VISIBLE
        *-- is not found" dentro do InicializarForm e a tela nao abre.
    ENDPROC

    *==========================================================================
    * ConfigurarAbaDetalhamento - pgRes01 (Detalhamento dos Produtos):
    * grd_4c_Dados1 (35 colunas, ControlSource/Width/Alignment EXATOS do
    * dump - SECAO 2, nao do runtime GradePadrao(), que esta desatualizado
    * em relacao ao SCX - ver GradePadrao() mais abaixo) + o painel lateral
    * (imagem, observacao, preco atual, desconto/acrescimo, busca por
    * codigo, filtro positivas/negativas/sem-filtro) + os botoes de acao
    * (Restaurar Grade, Cadastro do Produto, Movimento, Subniveis, Conta,
    * Visualizar, Imprimir).
    *
    * Cursor_4c_Detalhe (crPgRes01) JA EXISTE neste ponto - criado pelo
    * Init() do BO (CriarCursoresResultado), chamado ANTES de
    * ConfigurarPageFrame em InicializarForm. Por isso o bind
    * (RecordSource/ControlSource) pode ser feito aqui, direto, sem o funil
    * deferido que as grades de filtro da Pagina 1 precisam (regra #41) -
    * BtnConsultarClick so faz ZAP+INSERT no MESMO cursor (nunca fecha/
    * reabre o alias), entao o RecordSource nunca se perde.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaDetalhamento(par_oPag)
        LOCAL loc_nCol
        DIMENSION loc_aLargura(35)
        DIMENSION loc_aCaption(35)

        loc_aCaption( 1) = "Emp"
        loc_aLargura( 1) =  31
        loc_aCaption( 2) = "Movimenta" + CHR(231) + CHR(227) + "o"
        loc_aLargura( 2) = 150
        loc_aCaption( 3) = "C" + CHR(243) + "digo"
        loc_aLargura( 3) =  55
        loc_aCaption( 4) = "Data"
        loc_aLargura( 4) =  71
        loc_aCaption( 5) = "Vendedora"
        loc_aLargura( 5) =  80
        loc_aCaption( 6) = "Barra"
        loc_aLargura( 6) = 100
        loc_aCaption( 7) = "Produto"
        loc_aLargura( 7) = 110
        loc_aCaption( 8) = "Descri" + CHR(231) + CHR(227) + "o do Produto"
        loc_aLargura( 8) = 296
        loc_aCaption( 9) = "Cor"
        loc_aLargura( 9) =  35
        loc_aCaption(10) = "Tam"
        loc_aLargura(10) =  35
        loc_aCaption(11) = "Valor da Diferen" + CHR(231) + "a"
        loc_aLargura(11) = 100
        loc_aCaption(12) = "% Dif."
        loc_aLargura(12) =  70
        loc_aCaption(13) = "Valor do Cadastro"
        loc_aLargura(13) =  95
        loc_aCaption(14) = "Venda Unit" + CHR(225) + "rio"
        loc_aLargura(14) =  95
        loc_aCaption(15) = "Quantidade"
        loc_aLargura(15) = 100
        loc_aCaption(16) = "Total"
        loc_aLargura(16) =  95
        loc_aCaption(17) = "Custo do Cadastro"
        loc_aLargura(17) = 100
        loc_aCaption(18) = "Fornecedor"
        loc_aLargura(18) =  90
        loc_aCaption(19) = "Nome do Fornecedor"
        loc_aLargura(19) = 290
        loc_aCaption(20) = "Refer" + CHR(234) + "ncia"
        loc_aLargura(20) = 150
        loc_aCaption(21) = "Gde"
        loc_aLargura(21) =  30
        loc_aCaption(22) = "Grp"
        loc_aLargura(22) =  30
        loc_aCaption(23) = "Subgrupo"
        loc_aLargura(23) = 220
        loc_aCaption(24) = "Ope"
        loc_aLargura(24) =  30
        loc_aCaption(25) = "Cliente"
        loc_aLargura(25) =  80
        loc_aCaption(26) = "Nome do Cliente"
        loc_aLargura(26) = 290
        loc_aCaption(27) = "Parcelas"
        loc_aLargura(27) =  50
        loc_aCaption(28) = "Condi" + CHR(231) + CHR(245) + "es de Pagamento"
        loc_aLargura(28) = 200
        loc_aCaption(29) = "Margem"
        loc_aLargura(29) = 100
        loc_aCaption(30) = "Total Movimenta" + CHR(231) + CHR(227) + "o"
        loc_aLargura(30) = 110
        loc_aCaption(31) = "Local"
        loc_aLargura(31) =  80
        loc_aCaption(32) = "Equivalente"
        loc_aLargura(32) = 110
        loc_aCaption(33) = "Categoria"
        loc_aLargura(33) =  60
        loc_aCaption(34) = "Nome Vendedora"
        loc_aLargura(34) = 204
        loc_aCaption(35) = "Desc. Categoria"
        loc_aLargura(35) = 140

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        par_oPag.AddObject("grd_4c_Dados1", "Grid")
        WITH par_oPag.grd_4c_Dados1
            .Top               = 320
            .Left              = 4
            .Width             = 1292
            .Height            = 251
            .ColumnCount       = 35
            .FontName          = "Tahoma"
            .FontSize          = 7
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 21
            .RowHeight         = 15
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            *-- RecordSource ANTES do ControlSource (regra #41) - o cursor
            *-- ja existe (CriarCursoresResultado roda no Init do BO).
            .RecordSource      = "cursor_4c_Detalhe"
            .Column1.ControlSource  = "cursor_4c_Detalhe.Empresa"
            .Column2.ControlSource  = "cursor_4c_Detalhe.Movimentacao"
            .Column3.ControlSource  = "cursor_4c_Detalhe.Numero"
            .Column4.ControlSource  = "IIF(EMPTY(cursor_4c_Detalhe.Data_Venda), SPACE(10), DTOC(cursor_4c_Detalhe.Data_Venda))"
            .Column5.ControlSource  = "cursor_4c_Detalhe.Codigo_Vendedora"
            .Column6.ControlSource  = "cursor_4c_Detalhe.Barras"
            .Column7.ControlSource  = "cursor_4c_Detalhe.Codigo_Item"
            .Column8.ControlSource  = "cursor_4c_Detalhe.Desc_Item"
            .Column9.ControlSource  = "cursor_4c_Detalhe.Cor"
            .Column10.ControlSource = "cursor_4c_Detalhe.Tamanho"
            .Column11.ControlSource = "cursor_4c_Detalhe.Valor_Diferenca"
            .Column12.ControlSource = "ALLTRIM(cursor_4c_Detalhe.Pct_Dif_Chr)"
            .Column13.ControlSource = "cursor_4c_Detalhe.Venda_Cadastro"
            .Column14.ControlSource = "cursor_4c_Detalhe.Val_Unitario"
            .Column15.ControlSource = "cursor_4c_Detalhe.Quantidade"
            .Column16.ControlSource = "cursor_4c_Detalhe.Total"
            .Column17.ControlSource = "cursor_4c_Detalhe.Custo_Cadastro"
            .Column18.ControlSource = "cursor_4c_Detalhe.Cod_Fornecedor"
            .Column19.ControlSource = "cursor_4c_Detalhe.Nome_Fornecedor"
            .Column20.ControlSource = "cursor_4c_Detalhe.Ref_Fornecedor"
            .Column21.ControlSource = "cursor_4c_Detalhe.Gde_Grupo"
            .Column22.ControlSource = "cursor_4c_Detalhe.Grupo"
            .Column23.ControlSource = "cursor_4c_Detalhe.SubGrupo"
            .Column24.ControlSource = "cursor_4c_Detalhe.Operacao"
            .Column25.ControlSource = "cursor_4c_Detalhe.Cod_Cliente"
            .Column26.ControlSource = "cursor_4c_Detalhe.Nome_Cliente"
            .Column27.ControlSource = "cursor_4c_Detalhe.Parcelas"
            .Column28.ControlSource = "cursor_4c_Detalhe.Cond_Pagto"
            .Column29.ControlSource = "cursor_4c_Detalhe.Markup"
            .Column30.ControlSource = "cursor_4c_Detalhe.Total_Geral"
            .Column31.ControlSource = "cursor_4c_Detalhe.Local_Itn"
            .Column32.ControlSource = "cursor_4c_Detalhe.Equivalente"
            .Column33.ControlSource = "cursor_4c_Detalhe.Categoria"
            .Column34.ControlSource = "cursor_4c_Detalhe.Nome_Vendedora"
            .Column35.ControlSource = "cursor_4c_Detalhe.Desc_Categoria"

            .Column4.Alignment  = 2
            .Column12.Alignment = 1
            .Column24.Alignment = 2
            .Column27.Alignment = 1

            *-- Codigo_Item (7) e Equivalente (32): estilo "link" do legado
            *-- (FontBold+Underline+azul). O clique e de verdade: o DblClick
            *-- do Text1 das duas colunas abre a Pesquisa Global de Produtos
            *-- filtrada pelo codigo da celula (ver
            *-- ConfigurarBindEventsResultados / AbrirPesquisaGlobalProduto),
            *-- igual ao legado.
            .Column7.FontBold       = .T.
            .Column7.FontUnderline  = .T.
            .Column7.ForeColor      = RGB(0, 0, 255)
            .Column32.FontBold      = .T.
            .Column32.FontUnderline = .T.
            .Column32.ForeColor     = RGB(0, 0, 255)

            FOR loc_nCol = 1 TO 35
                THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados1, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), ;
                    INLIST(loc_nCol, 11, 13, 14, 15, 16, 17, 29, 30))
            ENDFOR

            *-- Linhas de TOTAL (Ordem <> 'A') em amarelo+negrito; Valor da
            *-- Diferenca/% Dif. (11/12) ficam SEMPRE amarelos, mesmo nas
            *-- linhas normais
            .SetAll("DynamicBackColor", "IIF(cursor_4c_Detalhe.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
            .SetAll("DynamicFontBold",  "cursor_4c_Detalhe.Ordem <> 'A'", "Column")
            .Column11.DynamicBackColor = "RGB(255,255,240)"
            .Column12.DynamicBackColor = "RGB(255,255,240)"

            .Visible = .T.
        ENDWITH

        *-- Restaura largura/visibilidade salvas em txt_4c_CfgGrade (se
        *-- houver) - equivalente a ThisForm.AcertaColunas([LER]) no fim de
        *-- montagrades() legado
        THIS.AcertaColunas("LER")

        *-- getObsItn (observacao do item - EditBox memo, so exibicao)
        par_oPag.AddObject("obj_4c_ObsItem", "EditBox")
        WITH par_oPag.obj_4c_ObsItem
            .Top       = 20
            .Left      = 5
            .Width     = 312
            .Height    = 172
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say3 "Observacao do Item"
        par_oPag.AddObject("lbl_4c_ObsItem", "Label")
        WITH par_oPag.lbl_4c_ObsItem
            .Top       = 4
            .Left      = 6
            .Width     = 100
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do " + CHR(205) + "tem"
            .Visible   = .T.
        ENDWITH

        *-- Say1 "Preco Atual do Item" + getVdaCadastro (so exibicao)
        par_oPag.AddObject("lbl_4c_PrecoAtual", "Label")
        WITH par_oPag.lbl_4c_PrecoAtual
            .Top       = 200
            .Left      = 5
            .Width     = 97
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pre" + CHR(231) + "o Atual do Item"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_VdaCadastro", "TextBox")
        WITH par_oPag.txt_4c_VdaCadastro
            .Top       = 216
            .Left      = 5
            .Width     = 128
            .Height    = 23
            .ReadOnly  = .T.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say4 "Desconto/Acrescimo" + getDesc_Acres (so exibicao)
        par_oPag.AddObject("lbl_4c_DescAcres", "Label")
        WITH par_oPag.lbl_4c_DescAcres
            .Top       = 245
            .Left      = 5
            .Width     = 99
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Desconto/Acr" + CHR(233) + "scimo"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DescAcres", "TextBox")
        WITH par_oPag.txt_4c_DescAcres
            .Top       = 261
            .Left      = 5
            .Width     = 128
            .Height    = 23
            .ReadOnly  = .T.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say2 "Buscar Codigo" + getBusca (busca Numero da venda na grade)
        par_oPag.AddObject("lbl_4c_Busca", "Label")
        WITH par_oPag.lbl_4c_Busca
            .Top       = 245
            .Left      = 164
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Buscar C" + CHR(243) + "digo"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Busca", "TextBox")
        WITH par_oPag.txt_4c_Busca
            .Top       = 261
            .Left      = 164
            .Width     = 82
            .Height    = 23
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- lblDespDRE "Diferencas :" + optValor1 (Positivas/Negativas/Sem Filtro)
        par_oPag.AddObject("lbl_4c_Diferencas", "Label")
        WITH par_oPag.lbl_4c_Diferencas
            .Top       = 297
            .Left      = 17
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Diferen" + CHR(231) + "as :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("obj_4c_OptValor1", "OptionGroup")
        WITH par_oPag.obj_4c_OptValor1
            .Top         = 292
            .Left        = 76
            .Width        = 226
            .Height      = 25
            .ButtonCount = 3
            .Value       = 3
            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Positivas"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top       = 5
                .Left      = 77
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Negativas"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top       = 5
                .Left      = 156
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sem Filtro"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- ImgFigJpg - imagem do produto da linha corrente (DblClick = zoom)
        par_oPag.AddObject("img_4c_Figura", "Image")
        WITH par_oPag.img_4c_Figura
            .Top         = 2
            .Left        = 327
            .Width       = 621
            .Height      = 318
            .Stretch     = 1
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
            .Visible     = .F.
        ENDWITH

        *-- btnRestaurar - restaura largura/visibilidade padrao da grade
        par_oPag.AddObject("cmd_4c_Restaurar", "CommandButton")
        WITH par_oPag.cmd_4c_Restaurar
            .Top         = 113
            .Left        = 1040
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = "Restaurar Grade"
            .ToolTipText = "Restaura as Colunas da Grade Para o Padr" + CHR(227) + "o Original"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- btnProduto - abre o cadastro do produto
        par_oPag.AddObject("cmd_4c_Produto", "CommandButton")
        WITH par_oPag.cmd_4c_Produto
            .Top         = 113
            .Left        = 1116
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Cadastro"
            .ToolTipText = "Cadastro do Produto"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- cmdOperacao/btnOperacao - abre a tela de movimentacao da venda
        par_oPag.AddObject("cmg_4c_Operacao", "CommandGroup")
        WITH par_oPag.cmg_4c_Operacao
            .Top         = 113
            .Left        = 1193
            .Width       = 80
            .Height      = 100
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            WITH .Buttons(1)
                .Top         = 0
                .Left        = 0
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Caption     = "Movimento"
                .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture     = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- SubNiveis - abre a tela de subniveis da venda
        par_oPag.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH par_oPag.cmd_4c_SubNiveis
            .Top         = 190
            .Left        = 1192
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = "\<Subn" + CHR(237) + "veis"
            .ToolTipText = "Subn" + CHR(237) + "veis"
            .PicturePosition = 13
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- CmdConta - abre o cadastro da conta/cliente
        par_oPag.AddObject("cmd_4c_Conta", "CommandButton")
        WITH par_oPag.cmd_4c_Conta
            .Top         = 190
            .Left        = 1116
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Conta"
            .ToolTipText = "Cadastro do Produto"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- btnVisualizar / BtnImprimir - preview/impressao do relatorio de
        *-- embalagem (SigOpPck). O form legado monta a consulta a partir do
        *-- cursor_4c_Detalhe JA filtrado em tela; o form novo FormSigOpPck
        *-- (ja migrado, OPERACIONAL) tem filtros proprios independentes -
        *-- nao ha API publica para injetar o recorte atual nele. Por isso
        *-- estes botoes abrem o FormSigOpPck para o usuario refazer o
        *-- filtro la, em vez de reproduzir o INDEX ON/REPORT FORM direto
        *-- sobre cursor_4c_Detalhe (seria preciso duplicar o FRX e a
        *-- logica de filtro, que ja pertencem aquele form).
        par_oPag.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH par_oPag.cmd_4c_Visualizar
            .Top         = 190
            .Left        = 1040
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Visualizar"
            .ToolTipText = "Visualizar Etiquetas de Embalagem"
            .PicturePosition = 13
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_video_60.jpg"
            .Visible     = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH par_oPag.cmd_4c_Imprimir
            .Top         = 190
            .Left        = 964
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Imprimir"
            .ToolTipText = "Imprimir Etiquetas de Embalagem"
            .PicturePosition = 13
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarColunaResultado - Aplica no indice loc_nCol da grade de
    * resultado a largura/caption padrao + a mascara numerica (999,999,999.99)
    * nas colunas que o legado marca como numericas. Compartilhado por
    * grd_4c_Dados1/2/3 (par_oGrid identifica a grade).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarColunaResultado(par_oGrid, par_nIndice, par_cCaption, par_nLargura, par_lNumerica)
        LOCAL loc_cCol, loc_oColuna
        loc_cCol    = TRANSFORM(par_nIndice)
        loc_oColuna = EVALUATE("par_oGrid.Column" + loc_cCol)

        loc_oColuna.ReadOnly          = .T.
        loc_oColuna.Width             = par_nLargura
        loc_oColuna.Header1.Caption   = par_cCaption
        loc_oColuna.Header1.FontBold  = .T.
        loc_oColuna.Header1.Alignment = 2
        loc_oColuna.Header1.ForeColor = RGB(90, 90, 90)

        IF PCOUNT() >= 5 AND par_lNumerica
            loc_oColuna.InputMask = "999,999,999.99"
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarAbaTotalEmpresa - pgRes02 (Totais por Empresa): grd_4c_Dados2
    * (10 colunas, cursor_4c_TotalEmpresa). O legado NAO define Width por
    * coluna aqui (soh ControlSource/ReadOnly/InputMask em montagrades) -
    * os valores abaixo vem do design-time do SCX (SECAO 2).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaTotalEmpresa(par_oPag)
        LOCAL loc_nCol
        DIMENSION loc_aLargura(10)
        DIMENSION loc_aCaption(10)

        loc_aCaption( 1) = "Emp"
        loc_aLargura( 1) =  31
        loc_aCaption( 2) = "Descritivo"
        loc_aLargura( 2) = 150
        loc_aCaption( 3) = "Valor da Diferen" + CHR(231) + "a"
        loc_aLargura( 3) = 100
        loc_aCaption( 4) = "% Dif."
        loc_aLargura( 4) =  45
        loc_aCaption( 5) = "Valor do Cadastro"
        loc_aLargura( 5) = 100
        loc_aCaption( 6) = "Quantidade"
        loc_aLargura( 6) = 100
        loc_aCaption( 7) = "Total de Vendas"
        loc_aLargura( 7) = 100
        loc_aCaption( 8) = "Custo do Cadastro"
        loc_aLargura( 8) = 100
        loc_aCaption( 9) = "Ticket M" + CHR(233) + "dio"
        loc_aLargura( 9) = 100
        loc_aCaption(10) = "Margem"
        loc_aLargura(10) = 100

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        par_oPag.AddObject("grd_4c_Dados2", "Grid")
        WITH par_oPag.grd_4c_Dados2
            .Top               = 137
            .Left              = 4
            .Width             = 1292
            .Height            = 431
            .ColumnCount       = 10
            .FontName          = "Tahoma"
            .FontSize          = 7
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 21
            .RowHeight         = 15
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            .RecordSource      = "cursor_4c_TotalEmpresa"
            .Column1.ControlSource  = "cursor_4c_TotalEmpresa.Empresa"
            .Column2.ControlSource  = "cursor_4c_TotalEmpresa.Movimentacao"
            .Column3.ControlSource  = "cursor_4c_TotalEmpresa.Valor_Diferenca"
            .Column4.ControlSource  = "cursor_4c_TotalEmpresa.Perc_Diferenca"
            .Column5.ControlSource  = "cursor_4c_TotalEmpresa.Venda_Cadastro"
            .Column6.ControlSource  = "cursor_4c_TotalEmpresa.Quantidade"
            .Column7.ControlSource  = "cursor_4c_TotalEmpresa.Total"
            .Column8.ControlSource  = "cursor_4c_TotalEmpresa.Custo_Cadastro"
            .Column9.ControlSource  = "cursor_4c_TotalEmpresa.Tkt_Medio"
            .Column10.ControlSource = "cursor_4c_TotalEmpresa.Markup"

            FOR loc_nCol = 1 TO 10
                THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados2, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
            ENDFOR

            .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalEmpresa.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
            .SetAll("DynamicFontBold",  "cursor_4c_TotalEmpresa.Ordem <> 'A'", "Column")
            .Column3.DynamicBackColor = "RGB(255,255,240)"
            .Column4.DynamicBackColor = "RGB(255,255,240)"

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaTotalVendedora - pgRes03 (Totais por Vendedora):
    * grd_4c_Dados3 (10 colunas, cursor_4c_TotalVendedora)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaTotalVendedora(par_oPag)
        LOCAL loc_nCol
        DIMENSION loc_aLargura(10)
        DIMENSION loc_aCaption(10)

        loc_aCaption( 1) = "Emp"
        loc_aLargura( 1) =  31
        loc_aCaption( 2) = "Vendedora"
        loc_aLargura( 2) = 100
        loc_aCaption( 3) = "Valor da Diferen" + CHR(231) + "a"
        loc_aLargura( 3) = 100
        loc_aCaption( 4) = "% Dif."
        loc_aLargura( 4) =  45
        loc_aCaption( 5) = "Valor do Cadastro"
        loc_aLargura( 5) = 100
        loc_aCaption( 6) = "Quantidade"
        loc_aLargura( 6) = 100
        loc_aCaption( 7) = "Total de Vendas"
        loc_aLargura( 7) = 100
        loc_aCaption( 8) = "Custo do Cadastro"
        loc_aLargura( 8) = 100
        loc_aCaption( 9) = "Ticket M" + CHR(233) + "dio"
        loc_aLargura( 9) = 100
        loc_aCaption(10) = "Margem"
        loc_aLargura(10) = 100

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        par_oPag.AddObject("grd_4c_Dados3", "Grid")
        WITH par_oPag.grd_4c_Dados3
            .Top               = 137
            .Left              = 4
            .Width             = 1292
            .Height            = 431
            .ColumnCount       = 10
            .FontName          = "Tahoma"
            .FontSize          = 7
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 21
            .RowHeight         = 15
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            .RecordSource      = "cursor_4c_TotalVendedora"
            .Column1.ControlSource  = "cursor_4c_TotalVendedora.Empresa"
            .Column2.ControlSource  = "cursor_4c_TotalVendedora.Codigo_Vendedora"
            .Column3.ControlSource  = "cursor_4c_TotalVendedora.Valor_Diferenca"
            .Column4.ControlSource  = "cursor_4c_TotalVendedora.Perc_Diferenca"
            .Column5.ControlSource  = "cursor_4c_TotalVendedora.Venda_Cadastro"
            .Column6.ControlSource  = "cursor_4c_TotalVendedora.Quantidade"
            .Column7.ControlSource  = "cursor_4c_TotalVendedora.Total"
            .Column8.ControlSource  = "cursor_4c_TotalVendedora.Custo_Cadastro"
            .Column9.ControlSource  = "cursor_4c_TotalVendedora.Tkt_Medio"
            .Column10.ControlSource = "cursor_4c_TotalVendedora.Markup"

            FOR loc_nCol = 1 TO 10
                THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados3, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
            ENDFOR

            .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalVendedora.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
            .SetAll("DynamicFontBold",  "cursor_4c_TotalVendedora.Ordem <> 'A'", "Column")
            .Column3.DynamicBackColor = "RGB(255,255,240)"
            .Column4.DynamicBackColor = "RGB(255,255,240)"

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsResultados - BINDEVENTs da Pagina de Dados
    * (grades de resultado + painel lateral + botoes de acao/navegacao/
    * exportacao).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsResultados()
        LOCAL loc_oPagDados, loc_oPagRes01, loc_oPagRes02, loc_oPagRes03, loc_nCol
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        loc_oPagRes01 = loc_oPagDados.pgf_4c_Resultados.Page1
        loc_oPagRes02 = loc_oPagDados.pgf_4c_Resultados.Page2
        loc_oPagRes03 = loc_oPagDados.pgf_4c_Resultados.Page3

        BINDEVENT(loc_oPagRes01.grd_4c_Dados1, "AfterRowColChange", THIS, "Grd1AfterRowColChange")
        BINDEVENT(loc_oPagRes01.img_4c_Figura, "DblClick", THIS, "ImgFiguraDblClick")

        *-- grdDados2.AfterRowColChange / grdDados3.AfterRowColChange no
        *-- legado: os dois repintam o painel lateral da pgRes01 (imagem +
        *-- Observacao do Item) a partir de crPgRes01 - exatamente o que
        *-- AtualizarPainelDetalheRegistro faz sobre cursor_4c_Detalhe.
        BINDEVENT(loc_oPagRes02.grd_4c_Dados2, "AfterRowColChange", THIS, "Grd2AfterRowColChange")
        BINDEVENT(loc_oPagRes03.grd_4c_Dados3, "AfterRowColChange", THIS, "Grd3AfterRowColChange")

        *-- grdDados1.Column<N>.Resize no legado (Columns 1 a 30 e 32 - as
        *-- colunas 31, 33, 34 e 35 NAO tem o evento no SCX, e esta lista
        *-- reproduz isso): arrastar a borda ate largura zero pergunta se o
        *-- usuario quer OCULTAR a coluna.
        FOR loc_nCol = 1 TO 32
            IF loc_nCol <= 30 OR loc_nCol = 32
                BINDEVENT(EVALUATE("loc_oPagRes01.grd_4c_Dados1.Column" + TRANSFORM(loc_nCol)), ;
                    "Resize", THIS, "Grd1ColunaResize")
            ENDIF
        ENDFOR

        *-- grdDados1.Column7.Text1.DblClick / Column32.Text1.DblClick no
        *-- legado: abre a Pesquisa Global de Produtos filtrada pelo codigo
        *-- da celula (Produto na 7, Equivalente na 32).
        BINDEVENT(loc_oPagRes01.grd_4c_Dados1.Column7.Text1,  "DblClick", THIS, "Grd1Coluna7DblClick")
        BINDEVENT(loc_oPagRes01.grd_4c_Dados1.Column32.Text1, "DblClick", THIS, "Grd1Coluna32DblClick")

        BINDEVENT(loc_oPagRes01.txt_4c_Busca, "GotFocus",  THIS, "TxtBuscaGotFocus")
        BINDEVENT(loc_oPagRes01.txt_4c_Busca, "LostFocus", THIS, "TxtBuscaLostFocus")

        BINDEVENT(loc_oPagRes01.obj_4c_OptValor1, "InteractiveChange", THIS, "OptValor1InteractiveChange")

        BINDEVENT(loc_oPagRes01.cmd_4c_Restaurar,  "Click", THIS, "BtnRestaurarClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Produto,    "Click", THIS, "BtnProdutoClick")
        BINDEVENT(loc_oPagRes01.cmg_4c_Operacao,   "Click", THIS, "CmgOperacaoClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_SubNiveis,  "Click", THIS, "BtnSubNiveisClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Conta,      "Click", THIS, "BtnContaClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")

        BINDEVENT(loc_oPagDados.cmg_4c_Retornar, "Click", THIS, "BtnRetornarClick")
        BINDEVENT(loc_oPagDados.cmd_4c_Exportar, "Click", THIS, "BtnExportarClick")
        BINDEVENT(loc_oPagDados.cmd_4c_Excel,    "Click", THIS, "BtnExcelClick")
    ENDPROC

    *==========================================================================
    * Grd1AfterRowColChange / AtualizarPainelDetalheRegistro - troca de
    * linha/coluna em grd_4c_Dados1 (grdDados1.AfterRowColChange no legado):
    * atualiza a imagem do produto + o painel lateral (Observacao,
    * Desconto/Acrescimo, Preco Atual) a partir da linha corrente. Toda a
    * leitura do cursor passa por BO.CarregarDoCursor (regra: CarregarDoCursor
    * eh a FONTE UNICA) - os botoes de acao abaixo (Movimento/Subniveis/
    * Conta/Produto) leem as properties this_cReg*/this_nReg* resultantes,
    * nunca o cursor direto.
    *==========================================================================
    PROCEDURE Grd1AfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelDetalheRegistro()
    ENDPROC

    *==========================================================================
    * Grd2AfterRowColChange / Grd3AfterRowColChange - grdDados2 e grdDados3
    * no legado tem o MESMO corpo de grdDados1.AfterRowColChange: as duas
    * grades de TOTAIS repintam o painel lateral da aba de Detalhamento
    * (imagem do produto + Observacao do Item) lendo crPgRes01, nao o
    * proprio cursor de totais. Transcricao fiel: delegam ao mesmo metodo.
    * PUBLIC por serem alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE Grd2AfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelDetalheRegistro()
    ENDPROC

    PROCEDURE Grd3AfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelDetalheRegistro()
    ENDPROC

    *==========================================================================
    * Grd1ColunaResize - grdDados1.Column<N>.Resize no legado:
    *
    *   lcHea = Alltrim(This.Header1.Caption)
    *   If (This.Width = 0) And (MessageBox([Deseja Ocultar a Coluna "] + ;
    *       lcHea + [" da Grade?], 4+32+256, [Ocultar Colunas]) = 6)
    *       This.Visible = .f.
    *   EndIf
    *
    * O legado repete esse corpo em 31 Column.Resize identicos; aqui um
    * UNICO delegate atende todos os BINDEVENT. Como o corpo so age quando
    * This.Width = 0, identificar a coluna pela LARGURA ZERO e equivalente
    * a identifica-la pelo "This" do legado - e dispensa AEVENTS (cuja
    * consulta por objeto de origem nao resolve o emissor do evento
    * corrente). O laco cobre as MESMAS colunas que o SCX vincula (1 a 30
    * e 32); 31, 33, 34 e 35 ficam de fora, como no legado.
    *
    * MsgConfirma devolve LOGICO (regra #7) - nunca comparar com 6.
    *==========================================================================
    PROCEDURE Grd1ColunaResize()
        LOCAL loc_oGrid, loc_nCol, loc_oColuna, loc_cHeader

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1

        FOR loc_nCol = 1 TO 32
            IF loc_nCol <= 30 OR loc_nCol = 32
                loc_oColuna = EVALUATE("loc_oGrid.Column" + TRANSFORM(loc_nCol))

                IF loc_oColuna.Visible AND loc_oColuna.Width = 0
                    loc_cHeader = ALLTRIM(loc_oColuna.Header1.Caption)
                    IF MsgConfirma("Deseja Ocultar a Coluna " + CHR(34) + loc_cHeader + CHR(34) + ;
                            " da Grade?", "Ocultar Colunas")
                        loc_oColuna.Visible = .F.
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Grd1Coluna7DblClick / Grd1Coluna32DblClick - DblClick de
    * grdDados1.Column7.Text1 (Produto) e .Column32.Text1 (Equivalente) no
    * legado. Os dois tem o MESMO corpo: abrem a Pesquisa Global de
    * Produtos ja filtrada pelo codigo da celula.
    *
    * O codigo vem das properties this_cReg* do BO (alimentadas por
    * CarregarDoCursor no AfterRowColChange da propria grade), e nao de
    * Text1.Value: dentro da Column o Text1 so carrega o valor da celula
    * ATIVA, e o DblClick pode chegar antes do foco assentar na celula.
    * PUBLIC por serem alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE Grd1Coluna7DblClick()
        THIS.AbrirPesquisaGlobalProduto(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cRegCodigoItem, "")))
    ENDPROC

    PROCEDURE Grd1Coluna32DblClick()
        THIS.AbrirPesquisaGlobalProduto(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cRegEquivalente, "")))
    ENDPROC

    *==========================================================================
    * AbrirPesquisaGlobalProduto - corpo comum dos dois DblClick acima.
    * Legado (dump, Column7.Text1.DblClick):
    *
    *   Do Form SigOpCgp.Scx Name ThisForm.poObjExt1 Linked With [SigOpCgp] NoShow
    *   .fld_principal.Pag_Consulta.Commandgroup1.Command1.Click()          (Limpar Filtros)
    *   .fld_principal.Pag_Consulta.Filtro.Principal.get_produto_inicial.Value = Padr(This.Value, 14)
    *   .fld_principal.Pag_Consulta.Filtro.Principal.get_produto_final.Value   = Padr(This.Value, 14)
    *   .fld_principal.Pag_Consulta.grp_operacao.cmd_consulta.Click()       (Consultar)
    *
    * Formsigopcgp (ja migrado) expoe o mesmo fluxo por metodos PUBLIC -
    * GrpLimparFiltrosClick()/BtnConsultarClick() -, usados aqui no lugar
    * de simular clique em CommandGroup/Buttons; mesmo padrao canonico de
    * Formsigprite.GrdItensColumn2DblClick.
    *
    * A guarda goSistema.ConsultaAberta do legado (instancia unica da
    * pesquisa, guardada em poObjExt1 entre chamadas) nao tem contrapartida
    * no sistema novo: Formsigopcgp e MODAL (WindowType = 1), entao o
    * proprio Show() ja impede abrir uma segunda - a mesma leitura ja
    * registrada em FormSigOpPck.
    *
    * PADR(..., 14) e o tamanho do legado (SigCdPro.cpros char(14)).
    *==========================================================================
    PROTECTED PROCEDURE AbrirPesquisaGlobalProduto(par_cCodigoProduto)
        LOCAL loc_oForm, loc_oPag, loc_oException
        loc_oForm = .NULL.

        IF EMPTY(par_cCodigoProduto)
            RETURN
        ENDIF

        TRY
            GarantirClasse("Formsigopcgp")
            loc_oForm = CREATEOBJECT("Formsigopcgp")
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro ao abrir Pesquisa Global de Produtos")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.GrpLimparFiltrosClick()

            loc_oPag = loc_oForm.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
            loc_oPag.txt_4c_ProdutoI.Value = PADR(par_cCodigoProduto, 14)
            loc_oPag.txt_4c_ProdutoF.Value = PADR(par_cCodigoProduto, 14)

            loc_oForm.BtnConsultarClick()
            loc_oForm.Show()
        ENDIF
    ENDPROC

    PROCEDURE AtualizarPainelDetalheRegistro()
        LOCAL loc_oPagRes01, loc_cArquivoImagem

        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Detalhe")

        loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1

        loc_cArquivoImagem = THIS.this_oBusinessObject.ExtrairImagemRegistro()
        IF !EMPTY(loc_cArquivoImagem)
            loc_oPagRes01.img_4c_Figura.Picture = loc_cArquivoImagem
            loc_oPagRes01.img_4c_Figura.Visible = .T.
        ELSE
            loc_oPagRes01.img_4c_Figura.Picture = ""
            loc_oPagRes01.img_4c_Figura.Visible = .F.
        ENDIF

        loc_oPagRes01.obj_4c_ObsItem.Value     = THIS.this_oBusinessObject.this_cRegObsItem
        loc_oPagRes01.txt_4c_DescAcres.Value    = THIS.this_oBusinessObject.this_nRegDescAcres
        loc_oPagRes01.txt_4c_VdaCadastro.Value  = THIS.this_oBusinessObject.this_nRegVendaCadastroR
    ENDPROC

    *==========================================================================
    * ImgFiguraDblClick - ImgFigJpg.DblClick no legado abre o form
    * SigOpZom (zoom da imagem), que AINDA NAO EXISTE no acervo migrado -
    * dependencia fora do escopo desta task (mesmo padrao ja registrado em
    * FormSigMvExp.prg para FormSigMvCab: nao-port AUDITAVEL, nao
    * silencioso). Em vez de um zoom mudo, abrimos o JPG temporario no
    * visualizador padrao do Windows (RUN nativo, sem DECLARE DLL) - a
    * mesma imagem, em tamanho de tela inteira.
    *==========================================================================
    PROCEDURE ImgFiguraDblClick()
        LOCAL loc_cArquivo, loc_cComando

        loc_cArquivo = THIS.this_oBusinessObject.ExtrairImagemRegistro()

        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            loc_cComando = 'cmd /c start "" "' + loc_cArquivo + '"'
            RUN /N7 (loc_cComando)
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtBuscaGotFocus / TxtBuscaLostFocus - getBusca no legado (busca o
    * Numero da venda digitado dentro de grd_4c_Dados1). O legado usa
    * GotFocus para guardar o valor anterior (This.Tag) e Valid para
    * comparar e fazer o LOCATE - como Valid de TextBox nao eh confiavel no
    * projeto, as duas acoes ficam no LostFocus (ao sair do campo).
    *==========================================================================
    PROCEDURE TxtBuscaGotFocus()
        LOCAL loc_oPagRes01
        loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
        loc_oPagRes01.txt_4c_Busca.Tag = PADR(ALLTRIM(NVL(loc_oPagRes01.txt_4c_Busca.Value, "")), 10)
    ENDPROC

    PROCEDURE TxtBuscaLostFocus()
        LOCAL loc_oPagRes01, loc_cValor

        loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
        loc_cValor    = ALLTRIM(NVL(loc_oPagRes01.txt_4c_Busca.Value, ""))

        IF !EMPTY(loc_cValor)
            IF PADR(loc_oPagRes01.txt_4c_Busca.Tag, 10) != PADR(loc_cValor, 10) AND USED("cursor_4c_Detalhe")
                SELECT cursor_4c_Detalhe
                GO TOP
                LOCATE FOR Numero = VAL(loc_cValor)
            ENDIF
            loc_oPagRes01.grd_4c_Dados1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * OptValor1InteractiveChange - optValor1 (Positivas/Negativas/Sem
    * Filtro) no legado chama Filtros(1, This.Value) a cada troca.
    *==========================================================================
    PROCEDURE OptValor1InteractiveChange()
        LOCAL loc_nValor
        loc_nValor = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.obj_4c_OptValor1.Value
        THIS.this_oBusinessObject.this_nTipoValor = loc_nValor
        THIS.Filtros(1, loc_nValor)
    ENDPROC

    *==========================================================================
    * Filtros - filtros(pPag,pOrd) no legado: troca a ordenacao de
    * cursor_4c_Detalhe para a TAG Ordem<N> correspondente (Ordem1 =
    * Positivas, Ordem2 = Negativas, Ordem3 = Sem Filtro - criadas em
    * BO.CriarCursoresResultado) e repinta grd_4c_Dados1.
    *==========================================================================
    PROCEDURE Filtros(par_nPagina, par_nOrdem)
        LOCAL loc_oPagRes01

        IF par_nPagina = 1
            IF USED("cursor_4c_Detalhe")
                SELECT cursor_4c_Detalhe
                SET ORDER TO ("Ordem" + TRANSFORM(par_nOrdem))
                GO TOP
            ENDIF
            loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
            loc_oPagRes01.grd_4c_Dados1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRestaurarClick - btnRestaurar.Click no legado: confirma, restaura
    * a largura/visibilidade padrao (GradePadrao) e persiste
    * (AcertaColunas('GRAVAR')).
    *==========================================================================
    PROCEDURE BtnRestaurarClick()
        IF MsgConfirma("Deseja Restaurar as Colunas da Grade (Ocultas e Larguras)?", "Restaurar Grade")
            THIS.GradePadrao()
            THIS.AcertaColunas("GRAVAR")
        ENDIF
    ENDPROC

    *==========================================================================
    * GradePadrao - gradepadrao() no legado: largura/visibilidade padrao de
    * grd_4c_Dados1. O array hardcoded do legado (laGrd) so cobre as
    * colunas 1 a 30 - as colunas 31 a 35 (Local/Equivalente/Categoria/
    * Nome Vendedora/Desc. Categoria) foram acrescentadas ao SCX DEPOIS
    * deste metodo ter sido escrito e o array NUNCA foi atualizado (regra
    * #14 - SCX mais novo que o codigo que o acompanha). Para essas 5,
    * mantemos a largura atual (a do design-time) em vez de reproduzir a
    * leitura de um elemento do array nunca inicializado pelo legado.
    *==========================================================================
    PROCEDURE GradePadrao()
        LOCAL loc_oGrid, loc_nCnt, loc_cCol
        DIMENSION loc_aLargura(30)
        loc_aLargura( 1) =  31
        loc_aLargura( 2) = 150
        loc_aLargura( 3) =  55
        loc_aLargura( 4) =  71
        loc_aLargura( 5) =  80
        loc_aLargura( 6) =  80
        loc_aLargura( 7) = 110
        loc_aLargura( 8) = 296
        loc_aLargura( 9) =  35
        loc_aLargura(10) =  35
        loc_aLargura(11) = 100
        loc_aLargura(12) =  70
        loc_aLargura(13) =  95
        loc_aLargura(14) =  95
        loc_aLargura(15) = 100
        loc_aLargura(16) =  95
        loc_aLargura(17) = 100
        loc_aLargura(18) =  90
        loc_aLargura(19) = 290
        loc_aLargura(20) = 150
        loc_aLargura(21) =  30
        loc_aLargura(22) =  30
        loc_aLargura(23) = 220
        loc_aLargura(24) =  30
        loc_aLargura(25) =  80
        loc_aLargura(26) = 290
        loc_aLargura(27) =  50
        loc_aLargura(28) = 200
        loc_aLargura(29) = 100
        loc_aLargura(30) = 110

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1

        FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
            loc_cCol = TRANSFORM(loc_nCnt)
            IF loc_nCnt <= 30
                STORE loc_aLargura(loc_nCnt) TO ("loc_oGrid.Column" + loc_cCol + ".Width")
            ENDIF
            STORE .T. TO ("loc_oGrid.Column" + loc_cCol + ".Visible")
        ENDFOR

        loc_oGrid.Refresh()
    ENDPROC

    *==========================================================================
    * AcertaColunas - acertacolunas(pTip) no legado: persiste (GRAVAR) ou
    * restaura (LER) a largura/visibilidade de cada coluna de
    * grd_4c_Dados1 num bloco de 5 caracteres por coluna (3 = largura, 1 =
    * visivel, 1 = reservado), guardado em txt_4c_CfgGrade.Value - string
    * em memoria, nunca persistida em banco (igual ao legado: getCfgGrade
    * eh so um TextBox do form).
    *==========================================================================
    PROCEDURE AcertaColunas(par_cTipo)
        LOCAL loc_oGrid, loc_oTxtCfg, loc_cStr, loc_nCnt, loc_cCol, loc_cBlo, loc_nWid, loc_lVis, loc_nPos

        loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1
        loc_oTxtCfg = THIS.pgf_4c_Paginas.Page1.txt_4c_CfgGrade

        IF UPPER(ALLTRIM(NVL(par_cTipo, ""))) == "LER"
            loc_cStr = loc_oTxtCfg.Value

            IF EMPTY(loc_cStr)
                RETURN
            ENDIF

            loc_nPos = 1
            FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
                loc_cBlo = SUBSTR(loc_cStr, loc_nPos, 5)
                loc_nWid = INT(VAL(SUBSTR(loc_cBlo, 1, 3)))
                loc_lVis = !(SUBSTR(loc_cBlo, 4, 1) == "0")
                loc_cCol = TRANSFORM(loc_nCnt)

                IF loc_nWid > 0
                    STORE loc_nWid TO ("loc_oGrid.Column" + loc_cCol + ".Width")
                ENDIF
                STORE loc_lVis TO ("loc_oGrid.Column" + loc_cCol + ".Visible")

                loc_nPos = loc_nPos + 5
            ENDFOR
        ELSE
            loc_cStr = ""
            FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
                loc_cCol = TRANSFORM(loc_nCnt)
                loc_cStr = loc_cStr + PADL(TRANSFORM(EVALUATE("loc_oGrid.Column" + loc_cCol + ".Width")), 3, "0") + ;
                    IIF(EVALUATE("loc_oGrid.Column" + loc_cCol + ".Visible"), "1", "0") + " "
            ENDFOR
            loc_oTxtCfg.Value = loc_cStr
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProdutoClick - btnProduto.Click no legado: abre o cadastro do
    * produto da linha corrente. FormProduto (ja migrado) e' standalone -
    * nao tem API publica para abrir direto num codigo especifico (o
    * legado usava Do Form ... Linked With, que nao existe mais - PILAR 3).
    * Abrimos o cadastro completo; o usuario busca o codigo (ja' visivel
    * no painel/grade) manualmente.
    *==========================================================================
    PROCEDURE BtnProdutoClick()
        LOCAL loc_oForm, loc_oException

        IF EMPTY(THIS.this_oBusinessObject.this_cRegCodigoItem)
            RETURN
        ENDIF

        TRY
            GarantirClasse("FormProduto")
            loc_oForm = CREATEOBJECT("FormProduto")

            IF VARTYPE(loc_oForm) != "O"
                MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Produtos" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em BtnProdutoClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmgOperacaoClick - cmdOperacao.btnOperacao.Valid no legado: identifica
    * se a Movimentacao da linha corrente e' uma Operacao (SigCdOpe, abre
    * FormSigMvExp) ou um Pedido (SigCdOpd, abre FormSigMvPdt). A decisao +
    * a mensagem de guarda (registro invalido) ficam no BO
    * (ObterFormularioOperacaoRegistro, que o Form chama por valor-BYREF -
    * regra "@" obrigatoria, VFP9 passa por valor por default).
    *==========================================================================
    PROCEDURE CmgOperacaoClick()
        LOCAL loc_cFormulario, loc_cMensagem, loc_oForm, loc_oException

        loc_cMensagem   = ""
        loc_cFormulario = THIS.this_oBusinessObject.ObterFormularioOperacaoRegistro(@loc_cMensagem)

        IF !EMPTY(loc_cMensagem)
            MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1.SetFocus()
        ENDIF

        IF EMPTY(loc_cFormulario)
            RETURN
        ENDIF

        TRY
            DO CASE
                CASE loc_cFormulario == "SigMvExp"
                    GarantirClasse("FormSigMvExp")
                    loc_oForm = CREATEOBJECT("FormSigMvExp", THIS.this_oBusinessObject.this_cRegMovimentacao, ;
                        "C", THIS.this_oBusinessObject.this_nRegNumero, THIS.this_oBusinessObject.this_cRegEmpresa, .T.)
                CASE loc_cFormulario == "SigMvPdt"
                    GarantirClasse("FormSigMvPdt")
                    loc_oForm = CREATEOBJECT("FormSigMvPdt", THIS.this_oBusinessObject.this_cRegMovimentacao, ;
                        "C", THIS.this_oBusinessObject.this_nRegNumero, THIS.this_oBusinessObject.this_cRegEmpresa, .T.)
            ENDCASE
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em CmgOperacaoClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSubNiveisClick - SubNiveis.Click no legado: abre a tela de
    * subniveis da venda corrente.
    *==========================================================================
    PROCEDURE BtnSubNiveisClick()
        LOCAL loc_oForm, loc_oException

        TRY
            GarantirClasse("FormSigMvSbn")
            loc_oForm = CREATEOBJECT("FormSigMvSbn", THIS, ;
                THIS.this_oBusinessObject.this_cRegEmpresa, ;
                THIS.this_oBusinessObject.this_cRegMovimentacao, ;
                THIS.this_oBusinessObject.this_nRegNumero)
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em BtnSubNiveisClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnContaClick - CmdConta.Click no legado: abre o cadastro da conta/
    * cliente da venda. FormCTA (ja migrado, equivalente de SIGCDCTA) e'
    * standalone - mesma limitacao de BtnProdutoClick (sem API para abrir
    * direto num codigo).
    *==========================================================================
    PROCEDURE BtnContaClick()
        LOCAL loc_oForm, loc_oException

        IF EMPTY(THIS.this_oBusinessObject.this_cRegCodCliente)
            MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta!!!", "Dados Incompletos")
            RETURN
        ENDIF

        TRY
            GarantirClasse("FormCTA")
            loc_oForm = CREATEOBJECT("FormCTA")

            IF VARTYPE(loc_oForm) != "O"
                MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Contas" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em BtnContaClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick / BtnImprimirClick - btnVisualizar.Click /
    * BtnImprimir.Click no legado: preview/impressao do relatorio de
    * embalagem (Report Form SigOpPck sobre um recorte INDEXADO/FILTRADO
    * de crPgRes01). O form novo equivalente (FormSigOpPck, OPERACIONAL, ja
    * migrado) tem FILTROS PROPRIOS e independentes - nao ha API publica
    * para injetar o recorte atual de cursor_4c_Detalhe nele (duplicar o
    * FRX e a logica de filtro aqui recriaria, fora de contexto, o que
    * aquele form ja faz). Por isso estes botoes abrem o FormSigOpPck para
    * o usuario refazer o filtro la.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.AbrirFormSigOpPck()
    ENDPROC

    PROCEDURE BtnImprimirClick()
        THIS.AbrirFormSigOpPck()
    ENDPROC

    PROTECTED PROCEDURE AbrirFormSigOpPck()
        LOCAL loc_oForm, loc_oException

        TRY
            GarantirClasse("FormSigOpPck")
            loc_oForm = CREATEOBJECT("FormSigOpPck")

            IF VARTYPE(loc_oForm) != "O"
                MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Etiquetas de Embalagem" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em AbrirFormSigOpPck")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRetornarClick - btnRetornar.Click no legado (cmgRetornar): volta
    * para a Pagina 1 (Filtros).
    *==========================================================================
    PROCEDURE BtnRetornarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *==========================================================================
    * BtnExportarClick / BtnExcelClick - btnExportar.Click / btnExcel.Click
    * no legado.
    *==========================================================================
    PROCEDURE BtnExportarClick()
        THIS.GerarTXT()
    ENDPROC

    PROCEDURE BtnExcelClick()
        THIS.GerarXLS()
    ENDPROC

    *==========================================================================
    * FLimpa - flimpa(pVal,pTip) no legado: formata um valor para linha de
    * TXT tabulado (C = remove TAB/LF/CR; N = formata com separador de
    * milhar), sempre terminando com CHR(9) (tabulacao, separador de
    * coluna).
    *==========================================================================
    PROCEDURE FLimpa(par_uValor, par_cTipo)
        LOCAL loc_cTipo, loc_cRetorno
        loc_cTipo = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "N")

        DO CASE
            CASE loc_cTipo = "C"
                loc_cRetorno = STRTRAN(STRTRAN(STRTRAN(TratarNulo(par_uValor, ""), CHR(9), ""), CHR(10), ""), CHR(13), "")
            CASE loc_cTipo = "N"
                loc_cRetorno = ALLTRIM(TRANSFORM(TratarNulo(par_uValor, 0), "999,999,999,999.99"))
            OTHERWISE
                loc_cRetorno = ""
        ENDCASE

        RETURN loc_cRetorno + CHR(9)
    ENDPROC

    *==========================================================================
    * GerarTXT - gerartxt() no legado: exporta a aba CORRENTE de
    * pgf_4c_Resultados (Detalhamento/Totais por Empresa/Totais por
    * Vendedora) para TXT tabulado, com cabecalho de colunas.
    *==========================================================================
    PROCEDURE GerarTXT()
        LOCAL loc_cArquivo, loc_nPagina, loc_cStr

        loc_cArquivo = GETFILE("TXT", "Nome do Arquivo", "OK", 0, "Gerar Arquivo Separado Por Tabula" + CHR(231) + CHR(245) + "es")

        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF

        STRTOFILE("", loc_cArquivo)

        loc_nPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.ActivePage

        IF !INLIST(loc_nPagina, 1, 2, 3)
            RETURN
        ENDIF

        DO CASE
            CASE loc_nPagina = 1
                loc_cStr = "Empresa" + CHR(9) + "C" + CHR(243) + "digo" + CHR(9) + "Data" + CHR(9) + "Vendedora" + CHR(9) + ;
                    "Barra" + CHR(9) + "Produto" + CHR(9) + "Descri" + CHR(231) + CHR(227) + "o do Produto" + CHR(9) + ;
                    "Cor" + CHR(9) + "Tamanho" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Venda Unit" + CHR(225) + "rio" + CHR(9) + ;
                    "Margem" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + "% Diferen" + CHR(231) + "a" + CHR(9) + ;
                    "Valor do Cadastro" + CHR(9) + "Total" + CHR(9) + "Parcelas" + CHR(9) + "Condi" + CHR(231) + CHR(245) + "es de Pagamento" + CHR(9) + ;
                    "Cliente" + CHR(9) + "Nome do Cliente" + CHR(9) + "Fornecedor" + CHR(9) + "Nome do Fornecedor" + CHR(9) + ;
                    "Subgrupo" + CHR(9) + "Refer" + CHR(234) + "ncia" + CHR(9) + "Gde Grupo" + CHR(9) + "Grupo" + CHR(9) + ;
                    "Quantidade" + CHR(9) + "Movimenta" + CHR(231) + CHR(227) + "o" + CHR(9) + "Opera" + CHR(231) + CHR(227) + "o" + CHR(9)
                SELECT cursor_4c_Detalhe
            CASE loc_nPagina = 2
                loc_cStr = "Empresa" + CHR(9) + "Descritivo" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
                    "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
                    "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
                SELECT cursor_4c_TotalEmpresa
            CASE loc_nPagina = 3
                loc_cStr = "Empresa" + CHR(9) + "Vendedora" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
                    "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
                    "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
                SELECT cursor_4c_TotalVendedora
        ENDCASE

        loc_cStr = loc_cStr + CHR(13)
        STRTOFILE(loc_cStr, loc_cArquivo, 1)

        SCAN
            loc_cStr = ""
            DO CASE
                CASE loc_nPagina = 1
                    loc_cStr = loc_cStr + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Empresa, "C") + ;
                        THIS.FLimpa(STR(cursor_4c_Detalhe.Numero, 10), "C") + ;
                        THIS.FLimpa(DTOC(cursor_4c_Detalhe.Data_Venda), "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Codigo_Vendedora, "C") + ;
                        THIS.FLimpa(STR(cursor_4c_Detalhe.Barras, 14), "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Codigo_Item, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Equivalente, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Desc_Item, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Tamanho, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Custo_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Val_Unitario, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Markup, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Valor_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Perc_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Venda_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Total, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Parcelas, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cond_Pagto, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cod_Cliente, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Nome_Cliente, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cod_Fornecedor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Nome_Fornecedor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.SubGrupo, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Ref_Fornecedor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Gde_Grupo, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Grupo, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Quantidade, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Movimentacao, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Operacao, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Local_Itn, "C")
                CASE loc_nPagina = 2
                    loc_cStr = loc_cStr + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Empresa, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Movimentacao, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Valor_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Perc_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Venda_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Quantidade, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Total, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Custo_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Tkt_Medio, "N")
                CASE loc_nPagina = 3
                    loc_cStr = loc_cStr + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Empresa, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Codigo_Vendedora, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Valor_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Perc_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Venda_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Quantidade, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Total, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Custo_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Tkt_Medio, "N")
            ENDCASE

            loc_cStr = loc_cStr + CHR(13)
            STRTOFILE(loc_cStr, loc_cArquivo, 1)
        ENDSCAN

        MsgInfo("O Arquivo " + CHR(34) + ALLTRIM(loc_cArquivo) + CHR(34) + " Foi Gerado!!!", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
    ENDPROC

    *==========================================================================
    * GerarXLS - gerarxls() no legado: exporta a aba CORRENTE de
    * pgf_4c_Resultados para XLS (COPY TO ... TYPE XL5).
    *==========================================================================
    PROCEDURE GerarXLS()
        LOCAL loc_cArquivo, loc_nPagina

        loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS")

        IF EMPTY(loc_cArquivo) OR !fVerificaPasta(loc_cArquivo, 2)
            RETURN
        ENDIF

        loc_nPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.ActivePage

        IF USED("cursor_4c_Excel")
            USE IN cursor_4c_Excel
        ENDIF

        DO CASE
            CASE loc_nPagina = 1
                *-- Local_Itn nao faz parte do SELECT do legado (ver
                *-- gerarxls() - Tam_De/Tam_Para sim) - transcrito literal.
                *-- Nomes de Movimentacao de TOTAL conforme gravados pelo
                *-- proprio BO (MontarResultadoDetalhe: "TOTAL DE ENTRADAS"/
                *-- "TOTAL DE SAIDAS", sem acento - regra de comparacao
                *-- exact-safe via ALLTRIM em vez do literal com padding
                *-- fixo do dump legado).
                SELECT Empresa, Numero, Data_Venda, Codigo_Vendedora, Barras, ;
                       Tipo, Codigo_Item, Desc_Item, Equivalente, Cor, Tamanho, ;
                       Tam_De, Tam_Para, Custo_Cadastro, ;
                       Val_Unitario, Markup, Valor_Diferenca, Perc_Diferenca, ;
                       Venda_Cadastro, Total, Parcelas, Cond_Pagto, Cod_Cliente, ;
                       Nome_Cliente, Cod_Fornecedor, Nome_Fornecedor, SubGrupo, ;
                       Ref_Fornecedor, Gde_Grupo, Grupo, Quantidade, Movimentacao ;
                  FROM cursor_4c_Detalhe ;
                 WHERE !INLIST(ALLTRIM(Movimentacao), "TOTAL DE ENTRADAS", "TOTAL DE SAIDAS") ;
                 ORDER BY Empresa, Ordem, Data_Venda, Movimentacao, Numero, Item ;
                  INTO CURSOR cursor_4c_Excel
            CASE loc_nPagina = 2
                SELECT Empresa, Movimentacao, Valor_Diferenca, Perc_Diferenca, ;
                       Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
                  FROM cursor_4c_TotalEmpresa ;
                 ORDER BY Empresa, Ordem, Movimentacao ;
                  INTO CURSOR cursor_4c_Excel
            CASE loc_nPagina = 3
                SELECT Empresa, Codigo_Vendedora, Valor_Diferenca, Perc_Diferenca, ;
                       Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
                  FROM cursor_4c_TotalVendedora ;
                 ORDER BY Empresa, Ordem, Codigo_Vendedora ;
                  INTO CURSOR cursor_4c_Excel
            OTHERWISE
                RETURN
        ENDCASE

        SELECT cursor_4c_Excel
        COPY TO (loc_cArquivo) TYPE XL5
        USE IN cursor_4c_Excel

        MsgInfo("O Arquivo " + CHR(34) + ALLTRIM(loc_cArquivo) + CHR(34) + " Foi Gerado!!!", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
    ENDPROC

    *==========================================================================
    * DESTROY - Destrutor. FormBase.Destroy ja cuida da liberacao do BO e do
    * fix de menu-shrinks (Erro58) - esta subclasse so precisa encadear.
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE

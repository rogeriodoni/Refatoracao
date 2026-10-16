*------------------------------------------------------------------------------
* Formsigprmdp.prg - Form Operacional: Substituicao de Referencias de Produtos
* Migrado de: tasks/task636/sigprmdp.SCX
* Tabela principal (fila de recalculo de custo): SigOpClC
*
* FASE 8/8 (FINAL) - liga e implementa os 3 botoes de acao principal via
* BINDEVENT em RegistrarEventos(): cmd_4c_BtnProcessar -> BtnProcessarClick
* (motor de substituicao, delega o SQL para sigprmdpBO.ProcessarPar/
* ValidarParSubstituicao), cmd_4c_Exporta -> ExportaClick (importacao de
* pares via planilha XLS) e cmd_4c_BtnSair -> BtnEncerrarClick (Release).
* O SCX legado NAO tem botao Salvar/Cancelar/Buscar/Alterar/Visualizar
* (form OPERACIONAL, sem modos CRUD) - esses handlers permanecem no-op,
* documentados individualmente. FormParaBO/BOParaForm ganham sentido real
* aqui: copiam o par da linha corrente de cursor_4c_Dados <-> as properties
* this_cProsAnt/this_cProsNov/this_nBarraAnt/this_lFlag do BO.
*
* Fases anteriores: ConfigurarCampos() completa o container cnt_4c_Result
* (cntResult do legado) com o painel de progresso (lbl_4c_Label1
* "Progresso :" + cnt_4c_Barra/shp_4c_ShpBarra/lbl_4c_LblPorcento) e o
* bloco Produto/Arquivo (Fase 5). ConfigurarGrid() tem o UNICO lookup deste
* form (legado: SIGPRMDP.Grade.Column1.Text1.Valid, fwBuscaExt contra
* SigCdPro), instalado via Column.AddObject("txt_4c_CelCprosAnt",
* "TextBoxProdutoAntMdp_4c") + CurrentControl + Sparse (regra #18), com o
* corpo em ValidarCProsAntGridExec (regra #46: Valid do TextBox da coluna,
* nunca AfterRowColChange).
*
* GAP DOCUMENTADO (regra #27): o motor de substituicao do legado varria
* QUALQUER tabela/coluna catalogada no arquivo LOCAL ArqDBF.DBF (FoxPro,
* Sys(5)+Sys(2003)+'\ArqDBF.dbf') e descobria a chave primaria via a view
* vindsql - nenhum dos dois existe no SQL Server (confirmado contra
* docs/schema.sql). sigprmdpBO.MapearTabelasAlvo() reproduz o MESMO filtro
* (mesma lista de 14 nomes de coluna, mesmo limite de tamanho 10/14,
* mesmas exclusoes) via INFORMATION_SCHEMA.COLUMNS, lido do schema REAL e
* atual em vez de um catalogo local que podia estar desatualizado. As
* funcoes globais fRecalculaP()/fRecalculaC() (recalculo de custo/estoque)
* tambem nao vieram no acervo - ProcessarPar() enfileira em SigOpClC para
* recalculo externo em vez de tentar reproduzir o calculo, e NUNCA
* exclui linhas de SigMvEst (a exclusao no legado so era segura porque
* fRecalculaP recriava o saldo sob o codigo novo) - o Form avisa o usuario
* quando ha saldo de SigMvEst aguardando revisao manual.
*------------------------------------------------------------------------------

DEFINE CLASS Formsigprmdp AS FormBase

    Height      = 270
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    KeyPreview  = .T.
    Themes      = .F.
    DataSession = 2

    *-- Flags espelhando as propriedades customizadas do SCX legado
    *-- (ThisForm.Checkcadpro / Manterbarra / Calculacusto). Checkcadpro e
    *-- NomeForm chegam por parametro do Init; Calculacusto e lido do banco
    *-- (SigCdPaC.CalcCustos) na Fase 4, junto com o restante do Load legado.
    this_lCheckCadPro  = .F.
    this_lManterBarra  = .F.
    this_lCalculaCusto = .T.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() e replica os parametros do Init legado
    * (Lparameters pCheckCad, lcNomeFrm1) antes de delegar ao FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lCheckCadPro, par_cNomeForm)
        LOCAL loc_cNomeForm

        THIS.Caption = "Substitui" + CHR(231) + CHR(227) + "o de Refer" + CHR(234) + "ncias de Produtos"

        THIS.this_lCheckCadPro = (VARTYPE(par_lCheckCadPro) = "L" AND par_lCheckCadPro)

        *-- Legado: lcNomeFrm1 = Upper(Iif(Type('lcNomeFrm1')=='C' And Not Empty(lcNomeFrm1),lcNomeFrm1,ThisForm.Name))
        *-- ThisForm.Manterbarra = (lcNomeFrm1 = 'SIGPRMDPB'). Nao renomeamos
        *-- THIS.Name (renomear Form em runtime nao faz parte da arquitetura
        *-- nova) - so a flag de comportamento e preservada.
        loc_cNomeForm = UPPER(IIF(VARTYPE(par_cNomeForm) = "C" AND !EMPTY(par_cNomeForm), par_cNomeForm, THIS.Name))
        THIS.this_lManterBarra = (loc_cNomeForm == "SIGPRMDPB")

        *-- ShowWindow=0 na classe evitaria travar em VFP9 -T (top-level window
        *-- bloqueante) durante testes automatizados; producao restaura modal aqui.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprmdpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprmdpBO.", ;
                        "Erro em InicializarForm")
            ELSE
                *-- Propaga as flags resolvidas no Init() (par_lCheckCadPro/
                *-- nome do form) para o BO - ValidarParSubstituicao/
                *-- ProcessarPar leem a COPIA do BO, nao a do Form.
                THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
                THIS.this_oBusinessObject.this_lManterBarra = THIS.this_lManterBarra

                *-- Legado (Load): "lcQuery = Select CalcCustos From SigCdPaC
                *-- Order By CalcCustos" + "Thisform.CalculaCusto =
                *-- (CrSigCdPac.CalcCustos <> 3)".
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF USED("cursor_4c_Pac")
                        USE IN cursor_4c_Pac
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos", "cursor_4c_Pac") > 0 ;
                       AND USED("cursor_4c_Pac") AND RECCOUNT("cursor_4c_Pac") > 0
                        THIS.this_lCalculaCusto = (TratarNulo(cursor_4c_Pac.CalcCustos, 0) != 3)
                    ENDIF
                    IF USED("cursor_4c_Pac")
                        USE IN cursor_4c_Pac
                    ENDIF
                ENDIF
                THIS.this_oBusinessObject.this_lCalculaCusto = THIS.this_lCalculaCusto

                *-- Cursor local da grade de edicao (equivalente a csContas do
                *-- Load legado) - tem de existir ANTES de ConfigurarPageFrame
                *-- montar o Grid (regra #41: ControlSource de cursor
                *-- inexistente derruba o Init).
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
                INDEX ON CprosAnt + CprosNov TAG Duplica
                INDEX ON CprosAnt TAG CprosAnt
                INDEX ON CprosNov TAG CprosNov
                SET ORDER TO
                INSERT INTO cursor_4c_Dados (CprosAnt, CprosNov) VALUES ("", "")

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)
                THIS.RegistrarEventos()

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
    * ConfigurarPageFrame - orquestra montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (legado herda de "form" generico, sem
    * frmcadastro/Page1=Lista/Page2=Dados); o metodo so encadeia os
    * configuradores especificos, na ordem em que o SCX desenha os controles.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria o container escuro superior (cntSombra do
    * legado) com os dois labels de titulo (sombra preta + titulo branco).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
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
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255,255,255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Shape1 (decorativo, BackStyle=0 + BorderStyle=0 no
    * legado = sem renderizacao, transcrito fielmente) e os 5 botoes de
    * acao do form, todos filhos DIRETOS de THIS (o SCX legado nao os
    * agrupa em CommandGroup/Container). Ordem de criacao segue a arvore do
    * SCX: Shape1, btnSair, btnProcessar, btnExcluir, btnIncluir, Exporta -
    * TODOS depois de ConfigurarCabecalho(), porque Top=3..78 cai DENTRO da
    * faixa do cabecalho (Top=0..80) e precisa desenhar por cima dela
    * (regra #11/#29). Handlers de Click sao ligados nas Fases 7-8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 502
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top        = 3
            .Left       = 725
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
        WITH THIS.cmd_4c_BtnProcessar
            .Top        = 3
            .Left       = 650
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption    = "\<Processar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH THIS.cmd_4c_BtnExcluir
            .Top        = 3
            .Left       = 500
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .Caption    = "\<Excluir"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
        WITH THIS.cmd_4c_BtnIncluir
            .Top        = 3
            .Left       = 425
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .Caption    = "\<Incluir"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Exporta", "CommandButton")
        WITH THIS.cmd_4c_Exporta
            .Top        = 3
            .Left       = 575
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "importar_72.png"
            .Caption    = "\<Importar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados (Grade do legado): grid de edicao local
    * dos pares Codigo Original/Novo Codigo, ligado a cursor_4c_Dados
    * (criado em InicializarForm, antes de ConfigurarPageFrame). Colunas
    * simples, sem AddObject de controle customizado (Text1/Header1 nativos,
    * igual ao legado). RecordSource por ultimo, depois de Width/Header -
    * aqui nao ha CarregarLista que rebinde depois (grade de edicao local,
    * nao consulta SQL), entao a ordem nao sofre o reset da regra #41/
    * Problema 48.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        *-- RecordSource/ColumnCount ANTES da configuracao das colunas (regra
        *-- #41/Problema 48): mexer neles DEPOIS reseta Width/Header/
        *-- CurrentControl das colunas ja configuradas.
        loc_oGrid.ColumnCount = 3
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        loc_oGrid.ColumnCount  = 2

        WITH loc_oGrid
            .Top               = 101
            .Left              = 147
            .Width             = 269
            .Height            = 148
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 18
            .RowHeight         = 18
            .ScrollBars        = 2
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width             = 118
            .ReadOnly          = .F.
            .Header1.Caption   = "C" + CHR(243) + "digo Original"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Dados.CprosAnt"
        ENDWITH

        *-- Lookup de produto (legado: Column1.Text1.Valid, com Checkcadpro=.F.
        *-- chama fwBuscaExt contra SigCdPro). Column.AddObject sozinho NAO
        *-- exibe o controle - precisa de CurrentControl + Sparse (regra #18);
        *-- a validacao mora no Valid do TextBox da coluna (regra #46), NUNCA
        *-- em AfterRowColChange.
        loc_oGrid.Column1.AddObject("txt_4c_CelCprosAnt", "TextBoxProdutoAntMdp_4c")
        loc_oGrid.Column1.CurrentControl = "txt_4c_CelCprosAnt"
        loc_oGrid.Column1.Sparse         = .F.

        WITH loc_oGrid.Column2
            .Width             = 118
            .ReadOnly          = .F.
            .Header1.Caption   = "Novo C" + CHR(243) + "digo"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Dados.CprosNov"
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
            WITH loc_oGrid.Column2.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cnt_4c_Result (cntResult do legado): painel que
    * exibe o produto/arquivo em processamento durante btnProcessar.Click.
    * Fica OCULTO por padrao (replica ThisForm.cntResult.Visible = .f. do
    * Init legado - por isso TornarControlesVisiveis filtra este container,
    * ver PROCEDURE TornarControlesVisiveis) e so e exibido explicitamente
    * no inicio do processamento (Fase 7-8).
    *
    * Produto (lbl_4c_Label2 + txt_4c_Cpros), Arquivo/Campo (lbl_4c_Label5 +
    * txt_4c_Arquivo) e, desde a Fase 6, o painel de progresso (lbl_4c_Label1
    * "Progresso :" + cnt_4c_Barra com shp_4c_ShpBarra/lbl_4c_LblPorcento).
    * Ambos os TextBoxes sao ReadOnly: o legado so os preenche por codigo
    * durante o loop de processamento (ThisForm.Grade / controlesReferenciados
    * "Get_Cpros" em btnProcessar.Click) - nao ha Valid/evento de digitacao
    * para eles em comportamento.json.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oResult

        THIS.AddObject("cnt_4c_Result", "Container")
        loc_oResult = THIS.cnt_4c_Result
        WITH loc_oResult
            .Top         = 101
            .Left        = 440
            .Width       = 213
            .Height      = 146
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 1
            .Visible     = .F.
        ENDWITH

        loc_oResult.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oResult.lbl_4c_Label2
            .Top       = 2
            .Left      = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Produto : "
        ENDWITH

        loc_oResult.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oResult.txt_4c_Cpros
            .Top      = 19
            .Left     = 5
            .Width    = 108
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        loc_oResult.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oResult.lbl_4c_Label5
            .Top       = 45
            .Left      = 7
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Arquivo/Campo :"
        ENDWITH

        loc_oResult.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oResult.txt_4c_Arquivo
            .Top      = 62
            .Left     = 4
            .Width    = 204
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        *-- Painel de progresso (Say1 "Progresso :" + cntBarra/shpBarra/
        *-- lblPorcento do legado) - atualizado pelo loop de processamento
        *-- (btnProcessar.Click, Fase 7-8) via
        *-- this_oBusinessObject.this_nProgresso/this_cProdutoAtual/
        *-- this_cArquivoAtual.
        loc_oResult.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oResult.lbl_4c_Label1
            .Top       = 100
            .Left      = 7
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Progresso :"
        ENDWITH

        loc_oResult.AddObject("cnt_4c_Barra", "Container")
        WITH loc_oResult.cnt_4c_Barra
            .Top         = 116
            .Left        = 5
            .Width       = 202
            .Height      = 21
            .BorderColor = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oResult.cnt_4c_Barra.AddObject("shp_4c_ShpBarra", "Shape")
        WITH loc_oResult.cnt_4c_Barra.shp_4c_ShpBarra
            .Top         = 1
            .Left        = 1
            .Height      = 19
            .Width       = 200
            .BackColor   = RGB(0, 128, 0)
            .BorderColor = RGB(100, 100, 100)
        ENDWITH

        loc_oResult.cnt_4c_Barra.AddObject("lbl_4c_LblPorcento", "Label")
        WITH loc_oResult.cnt_4c_Barra.lbl_4c_LblPorcento
            .Top       = 4
            .Left      = 93
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .Caption   = "0 %"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCProsAntGridExec - Valid da celula "Codigo Original" (Column1)
    * da grade de pares (legado: SIGPRMDP.Grade.Column1.Text1.Valid).
    * par_oTxt eh o TextBox da coluna: dentro do Valid o valor digitado esta
    * em par_oTxt.Value e AINDA NAO chegou ao cursor (regra #46).
    *
    * Legado: "If Not ThisForm.Checkcadpro" - com this_lCheckCadPro = .T.
    * (modo que aceita codigo de produto ainda nao cadastrado em SigCdPro),
    * a validacao eh pulada e o codigo digitado fica como esta.
    *--------------------------------------------------------------------------
    FUNCTION ValidarCProsAntGridExec(par_oTxt)
        LOCAL loc_oBusca, loc_cCpros, loc_oErro

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN .T.
        ENDIF

        IF THIS.this_lCheckCadPro
            RETURN .T.
        ENDIF

        loc_cCpros = ALLTRIM(IIF(VARTYPE(par_oTxt) = "O", par_oTxt.Value, cursor_4c_Dados.CprosAnt))

        *-- Legado: "Else / This.Value = ''" - campo vazio nao abre lookup.
        IF EMPTY(loc_cCpros)
            IF VARTYPE(par_oTxt) = "O"
                par_oTxt.Value = ""
            ENDIF
            SELECT cursor_4c_Dados
            REPLACE CprosAnt WITH "" IN cursor_4c_Dados
            RETURN .T.
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProdMdp", "Cpros", loc_cCpros, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init ja resolveu o match exato; so abre o picker se nao achou
                *-- (regra #37) - sem MsgAviso nem clear do digitado (regra #50)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdMdp")
                    IF RECCOUNT("cursor_4c_BuscaProdMdp") > 0
                        SELECT cursor_4c_BuscaProdMdp
                        loc_cCpros = ALLTRIM(cursor_4c_BuscaProdMdp.Cpros)
                        SELECT cursor_4c_Dados
                        REPLACE CprosAnt WITH loc_cCpros IN cursor_4c_Dados
                        *-- O codigo escolhido tem de voltar para a CELULA tambem,
                        *-- senao o texto digitado sobrescreve o cursor (regra #46)
                        IF VARTYPE(par_oTxt) = "O"
                            par_oTxt.Value = loc_cCpros
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigprmdp.ValidarCProsAntGridExec")
        ENDTRY

        IF USED("cursor_4c_BuscaProdMdp")
            USE IN cursor_4c_BuscaProdMdp
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarEventos - vincula eventos dos controles via BINDEVENT.
    * Liga os 2 botoes de manutencao da grade local (cmd_4c_BtnIncluir/
    * cmd_4c_BtnExcluir) e, desde a Fase 8, os 3 botoes de acao principal:
    * cmd_4c_BtnProcessar (btnProcessar.Click legado), cmd_4c_Exporta
    * (Exporta.Click legado - o nome do objeto e "Exporta" mas a Caption e o
    * comportamento sao de IMPORTACAO, mantidos fieis ao legado) e
    * cmd_4c_BtnSair (btnSair.Click legado -> ThisForm.Release). Nao ha
    * botoes Alterar/Visualizar no SCX legado (form OPERACIONAL, sem modos
    * CRUD). TesteAutomatico.prg tambem chama BtnIncluirClick()/
    * BtnExcluirClick() direto no form, sem depender deste BINDEVENT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventos()
        BINDEVENT(THIS.cmd_4c_BtnIncluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(THIS.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Exporta, "Click", THIS, "ExportaClick")
        BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente. FILTRO: cnt_4c_Result (painel de progresso, criado na
    * Fase 5) replica o "ThisForm.cntResult.Visible = .f." do Init legado -
    * fica oculto por padrao e so aparece durante o processamento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF UPPER(loc_oControl.Name) = "CNT_4C_RESULT"
                    LOOP
                ENDIF
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
    * ConfigurarPaginaLista - form OPERACIONAL sem Page1=Lista; o grid de
    * pares de substituicao (grd_4c_Dados/cursor_4c_Dados) e criado direto
    * no form em ConfigurarGrid() (Fase 4). Metodo mantido apenas por
    * conformidade de contrato com o pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - form OPERACIONAL sem Page2=Dados separada.
    * Metodo mantido apenas por conformidade de contrato com o pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - form OPERACIONAL sem PageFrame; nao ha alternancia
    * entre paginas. par_nPagina eh ignorado.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - form OPERACIONAL sem grid de registros do banco.
    * cursor_4c_Dados eh grade de EDICAO local (pares a trocar), populada
    * por BtnIncluirClick/Exporta, nao por uma consulta de listagem.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - form OPERACIONAL sem modos CRUD
    * (LISTA/INCLUIR/ALTERAR/VISUALIZAR). Metodo mantido por conformidade.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Append Blank em cursor_4c_Dados (legado: btnIncluir.
    * Click), so quando a ultima linha ja tem os dois codigos preenchidos -
    * evita acumular linhas vazias ao clicar repetidamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF !EMPTY(CprosAnt) AND !EMPTY(CprosNov)
            APPEND BLANK
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - nao ha botao Alterar no layout do SCX legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - nao ha botao Visualizar no layout do SCX legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Delete na linha corrente de cursor_4c_Dados (legado:
    * btnExcluir.Click). Sem confirmacao e sem PACK, igual ao legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        DELETE

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - nao ha botao Buscar no layout do SCX legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - nao ha botao "Salvar" no SCX legado; a acao principal
    * deste form e "Processar" (btnProcessar.Click -> BtnProcessarClick(),
    * ligado em RegistrarEventos a cmd_4c_BtnProcessar). Mantido no-op por
    * conformidade de contrato com o pipeline (padrao CRUD).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - nao ha botao "Cancelar" no SCX legado; fechar a
    * tela e feito por btnSair.Click -> BtnEncerrarClick() (cmd_4c_BtnSair).
    * Mantido no-op por conformidade de contrato com o pipeline (padrao CRUD).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - legado: SIGPRMDP.btnSair.Click = "ThisForm.Release".
    * Ligado a cmd_4c_BtnSair em RegistrarEventos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - legado: SIGPRMDP.btnProcessar.Click. Valida TODOS
    * os pares da grade (mesma ordem de checagens do Scan csContas legado),
    * pede confirmacao e so entao processa par a par via
    * this_oBusinessObject.ProcessarPar() (motor de substituicao multi-
    * tabela, BO), atualizando o painel de progresso (cnt_4c_Result) a cada
    * par concluido. Para no primeiro par que falhar, igual ao legado
    * (Exit do Scan quando lnErro < 1).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_nErro, loc_nTotal, loc_nFeito, loc_lTudoOk, ;
              loc_cProsAnt, loc_cProsNov, loc_nI
        LOCAL ARRAY loc_aPendAnt[1], loc_aPendNov[1]

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        GO TOP
        IF EOF()
            MsgAviso("N" + CHR(227) + "o Existem Contas a Serem Processadas!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
            RETURN
        ENDIF

        *-- Validacao de TODOS os pares antes de perguntar confirmacao
        *-- (legado: primeiro Scan do btnProcessar.Click so valida e sai com
        *-- Return no primeiro erro, sem perguntar nada ainda).
        SELECT cursor_4c_Dados
        SCAN
            loc_nErro = THIS.this_oBusinessObject.ValidarParSubstituicao( ;
                cursor_4c_Dados.CprosAnt, cursor_4c_Dados.CprosNov)

            DO CASE
            CASE loc_nErro = 1
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga Inv" + CHR(225) + "lida!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
                RETURN
            CASE loc_nErro = 2
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antigo Sem Barra !!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.SetFocus()
                RETURN
            CASE loc_nErro = 3
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Nova Inv" + CHR(225) + "lida!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.SetFocus()
                RETURN
            CASE loc_nErro = 4
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga e Uma Refer" + CHR(234) + ;
                    "ncia Nova Com o Mesmo C" + CHR(243) + "digo!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
                RETURN
            CASE loc_nErro = 5
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga e Uma Refer" + CHR(234) + ;
                    "ncia Nova com Controle de Estoque diferente!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
                RETURN
            ENDCASE

            *-- BarraAnt resolvido pela validacao (regra BOParaForm: a
            *-- property do BO e a FONTE, a linha do grid so espelha)
            THIS.BOParaForm()
        ENDSCAN

        IF !MsgConfirma("Confirma a Troca das Refer" + CHR(234) + "ncias ?", ;
            "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
            THIS.cmd_4c_BtnSair.SetFocus()
            RETURN
        ENDIF

        THIS.HabilitarCampos(.F.)
        THIS.cnt_4c_Result.Visible = .T.
        THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = 0
        THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"

        SELECT cursor_4c_Dados
        GO TOP
        loc_nTotal  = RECCOUNT()
        loc_nFeito  = 0
        loc_lTudoOk = .T.

        SCAN
            loc_cProsAnt = cursor_4c_Dados.CprosAnt
            loc_cProsNov = cursor_4c_Dados.CprosNov

            THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(loc_cProsAnt)
            THIS.cnt_4c_Result.Refresh()

            IF THIS.this_oBusinessObject.ProcessarPar(loc_cProsAnt, loc_cProsNov)
                REPLACE Flag WITH .T. IN cursor_4c_Dados
                =fGravarLog("C", THIS.Name, "INSERIR", ;
                    "DE:" + ALLTRIM(loc_cProsAnt) + " PARA:" + ALLTRIM(loc_cProsNov), ;
                    TratarNulo(gc_4c_UsuarioLogado, ""))
            ELSE
                loc_lTudoOk = .F.
            ENDIF

            loc_nFeito = loc_nFeito + 1
            THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = INT((loc_nFeito * 100) / loc_nTotal) * 2
            THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
                ALLTRIM(STR(INT((loc_nFeito * 100) / loc_nTotal))) + " %"
            THIS.cnt_4c_Result.cnt_4c_Barra.Refresh()

            IF !loc_lTudoOk
                EXIT
            ENDIF
        ENDSCAN

        THIS.cnt_4c_Result.Visible = .F.
        THIS.HabilitarCampos(.T.)

        IF loc_lTudoOk
            THIS.LimparCampos()
            MsgInfo("Todos Os Produtos Foram Alterados!!!", "Processamento Encerrado!!!")
        ELSE
            *-- legado: "Delete For flag" (remove so as linhas JA processadas,
            *-- mantendo as ainda nao processadas para reprocessar). Reconstrucao via
            *-- array em vez de DELETE+SET DELETED (DataSession=2 nasce com
            *-- SET DELETED OFF e nao herda o SET global - regra #9.4).
            loc_nI = 0
            SELECT cursor_4c_Dados
            SCAN FOR !Flag
                loc_nI = loc_nI + 1
                DIMENSION loc_aPendAnt[loc_nI], loc_aPendNov[loc_nI]
                loc_aPendAnt[loc_nI] = cursor_4c_Dados.CprosAnt
                loc_aPendNov[loc_nI] = cursor_4c_Dados.CprosNov
            ENDSCAN

            SELECT cursor_4c_Dados
            ZAP
            IF loc_nI = 0
                APPEND BLANK
            ELSE
                FOR loc_nI = 1 TO ALEN(loc_aPendAnt, 1)
                    APPEND BLANK
                    REPLACE CprosAnt WITH loc_aPendAnt[loc_nI], ;
                            CprosNov WITH loc_aPendNov[loc_nI] IN cursor_4c_Dados
                ENDFOR
            ENDIF
            GO TOP

            MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", "Reprocessar!!!")
        ENDIF

        IF THIS.this_oBusinessObject.this_lSigMvEstPendente
            MsgAviso("Saldos de estoque (SigMvEst) ligados a este par precisam de revis" + ;
                CHR(227) + "o manual - o recalculo autom" + CHR(225) + "tico dessa tabela n" + ;
                CHR(227) + "o foi portado.", "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportaClick - legado: SIGPRMDP.Exporta.Click (nome do objeto e
    * "Exporta", mas Caption/comportamento sao de IMPORTACAO de planilha XLS
    * com pares Codigo Original/Novo Codigo - mantido fiel ao legado, so o
    * nome do objeto migrado e que segue o PILAR 3). Ligado a cmd_4c_Exporta
    * em RegistrarEventos.
    *--------------------------------------------------------------------------
    PROCEDURE ExportaClick()
        LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_cProsAnt, loc_cProsNov, ;
              loc_nTotal, loc_nFeito

        loc_cArquivo = GETFILE("XLS")
        IF EMPTY(loc_cArquivo)
            MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !FILE(loc_cArquivo)
            MsgAviso("O arquivo [" + ALLTRIM(loc_cArquivo) + "]" + CHR(13) + ;
                "n" + CHR(227) + "o foi encontrado ou o acesso foi negado!!! Verifique!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF USED("cursor_4c_Importa")
            USE IN cursor_4c_Importa
        ENDIF
        CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
        INDEX ON CprosAnt TAG CprosAnt

        SELECT cursor_4c_Importa
        APPEND FROM (loc_cArquivo) TYPE XLS

        loc_nTotal = RECCOUNT("cursor_4c_Importa")
        loc_nFeito = 0

        SELECT cursor_4c_Importa
        SCAN
            loc_nFeito = loc_nFeito + 1
            WAIT WINDOW "Aguarde Importando Produtos !" + STR(loc_nTotal - loc_nFeito) NOWAIT

            loc_cProsAnt = TratarNulo(cursor_4c_Importa.CprosAnt, "")
            loc_cProsNov = TratarNulo(cursor_4c_Importa.CprosNov, "")

            IF EMPTY(loc_cProsAnt) OR EMPTY(loc_cProsNov) OR ;
               UPPER(ALLTRIM(loc_cProsAnt)) == UPPER(ALLTRIM(loc_cProsNov))
                LOOP
            ENDIF

            IF !THIS.this_lCheckCadPro
                loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                    EscaparSQL(LEFT(ALLTRIM(loc_cProsAnt), 14))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTmpPro")
                IF loc_nResultado < 1 OR !USED("cursor_4c_ImpTmpPro") OR RECCOUNT("cursor_4c_ImpTmpPro") = 0
                    IF USED("cursor_4c_ImpTmpPro")
                        USE IN cursor_4c_ImpTmpPro
                    ENDIF
                    LOOP
                ENDIF
                USE IN cursor_4c_ImpTmpPro
            ENDIF

            *-- Duplicata eh checada pela chave POSICIONAL (CprosAnt+CprosNov,
            *-- os dois C(14)) - NUNCA ALLTRIM aqui, senao o SEEK nunca casa
            *-- (regra #42).
            IF !SEEK(loc_cProsAnt + loc_cProsNov, "cursor_4c_Dados", "Duplica")
                SELECT cursor_4c_Dados
                APPEND BLANK
                REPLACE CprosAnt WITH loc_cProsAnt, CprosNov WITH loc_cProsNov IN cursor_4c_Dados
            ENDIF
        ENDSCAN

        SELECT cursor_4c_Dados
        GO BOTTOM
        THIS.grd_4c_Dados.Refresh()
        WAIT CLEAR

        USE IN cursor_4c_Importa
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - copia o par da linha CORRENTE de cursor_4c_Dados para
    * this_oBusinessObject (usado antes de validar/processar o par).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cProsAnt  = cursor_4c_Dados.CprosAnt
        THIS.this_oBusinessObject.this_cProsNov  = cursor_4c_Dados.CprosNov
        THIS.this_oBusinessObject.this_lFlag     = cursor_4c_Dados.Flag
        THIS.this_oBusinessObject.this_nBarraAnt = cursor_4c_Dados.BarraAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - grava de volta na linha CORRENTE de cursor_4c_Dados o que
    * this_oBusinessObject resolveu (BarraAnt/Flag) - usado apos
    * ValidarParSubstituicao() (legado: "Replace BarraAnt With CrTmpPro.Cbars
    * in CsContas").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        REPLACE BarraAnt WITH THIS.this_oBusinessObject.this_nBarraAnt, ;
                Flag      WITH THIS.this_oBusinessObject.this_lFlag IN cursor_4c_Dados
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - trava a grade e os 5 botoes de acao durante o
    * processamento (BtnProcessarClick), para o usuario nao reentrar no meio
    * do lote. cmd_4c_BtnSair fica de fora de proposito (permanece
    * acionavel). Nao ha equivalente disso no legado (a modal do
    * MessageBox bloqueava a interacao) - e so uma salvaguarda de UX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = (VARTYPE(par_lHabilitar) != "L" OR par_lHabilitar)

        THIS.grd_4c_Dados.Enabled        = loc_lHabilitar
        THIS.cmd_4c_BtnIncluir.Enabled   = loc_lHabilitar
        THIS.cmd_4c_BtnExcluir.Enabled   = loc_lHabilitar
        THIS.cmd_4c_BtnProcessar.Enabled = loc_lHabilitar
        THIS.cmd_4c_Exporta.Enabled      = loc_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - reseta a grade de pares para 1 linha vazia (legado, no
    * sucesso do btnProcessar.Click: "Set Order To / Zap / Append Blank").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        ZAP
        APPEND BLANK
        GO TOP
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos ao fechar o form. cursor_4c_Dados eh a grade
    * de edicao (vive por toda a sessao do form); cursor_4c_Importa eh
    * aberto/fechado dentro de ExportaClick() e cursor_4c_Campos dentro de
    * sigprmdpBO.ProcessarPar() - os guards aqui so cobrem o caso de o form
    * ser fechado no meio de uma dessas operacoes (TRY/CATCH quebrado a
    * meio-caminho).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Importa")
            USE IN cursor_4c_Importa
        ENDIF
        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

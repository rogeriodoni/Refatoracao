*==============================================================================
* FormSigPrFem.prg - Form OPERACIONAL: Analise de Producao
* Migrado de: SIGPRFEM.SCX
* Herda de: FormBase
*
* Pilares:
*   UX   -> layout identico ao legado (1000x600, sem TitleBar/ControlBox,
*           cabecalho cinza com titulo duplicado sombra/branco)
*   BD   -> SigCdPam (parametros)/SigCdOpe/SigCdCli/SigCdEmp/SigMvEst/SigPrDmo
*           via SigPrFemBO, processamento somente-leitura (sem CRUD)
*   CODE -> FormBase + SigPrFemBO (flat OPERACIONAL, sem PageFrame CRUD)
*
* Estrutura original (SIGPRFEM.SCX): cntSombra (cabecalho) + filtros
* (Get_Datai/Get_Dataf/Get_Demonstrativo) + botoes (Processar/Visualizar/
* Imprimir/Sair) + container Resultado (Visible=.F. ate Processar rodar)
* com 5 sub-containers (Detalhe/detalhe2/detalhe3/detalhe4/detalhe5), cada
* um com um Grid de 3 colunas, e o container Resumo com os totalizadores.
*
* Fase 3/8 entregou so a "casca": Init/InicializarForm + cabecalho.
*
* Fase 4/8 acrescenta:
*   - os grids/containers de resultado (cnt_4c_Resultado com os 5
*     sub-containers de detalhe e o container Resumo com os totalizadores)
*     - todos Visible=.F. ate o botao Processar rodar, exceto o Resumo,
*     que acompanha o Resultado;
*   - a barra de acao do topo direito (shp_4c_Shape2/shp_4c_Shape1 +
*     cmd_4c_Visualizar/cmd_4c_Imprimir/cmd_4c_Processar/cmd_4c_Sair),
*     criada DEPOIS do cabecalho porque fica sobre a faixa cinza;
*   - os cursores da area de Resultado (CriarCursoresResultado, equivalente
*     ao PROCEDURE Load do legado) e o bind das 5 grades + o espelho dos
*     totalizadores (CarregarDados/LigarGradeDetalhe/AtualizarResumo),
*     transcritos do trecho final de Processar.Click.
*
* Fase 5/8 acrescentou a metade dos campos de filtro do topo: a faixa do
* Periodo (lbl_4c_Label3 "Periodo :" + txt_4c_Datai + lbl_4c_Label1 "a" +
* txt_4c_Dataf), via ConfigurarFiltros().
*
* Fase 6/8 completa ConfigurarFiltros() com o campo restante - lbl_4c_Label4
* ("Tipo Analise :", SIGPRFEM.Say4) + txt_4c_Demonstrativo
* (SIGPRFEM.Get_Demonstrativo) - e implementa o lookup completo (PUBLIC,
* por causa do BINDEVENT): TeclaDemonstrativo (KeyPress F4/Enter/Tab) +
* ValidarDemonstrativo (match exato em SigPrDmo.Nome) + AbrirBuscaDemonstrativo
* (FormBuscaAuxiliar, tabela single-column - substitui o fwBuscaExt legado).
*
* Fase 7/8 acrescenta os eventos dos QUATRO botoes de acao, ligados por
* BINDEVENT em ConfigurarBotoesAcao e PUBLIC (BINDEVENT falha em silencio com
* metodo PROTECTED):
*   - BtnProcessarClick  (SIGPRFEM.Processar.Click) - as 3 validacoes com
*     SetFocus + delegacao do calculo ao SigPrFemBO.Processar + CarregarDados
*     + montagem dos cursores de impressao;
*   - BtnVisualizarClick (SIGPRFEM.Visualizar.Click) - REPORT FORM PREVIEW;
*   - BtnImprimirClick   (SIGPRFEM.Imprimir.Click)   - REPORT FORM TO PRINTER
*     PROMPT;
*   - BtnSairClick       (SIGPRFEM.Sair.Click)       - ThisForm.Release.
* Mais os auxiliares de suporte: ResultadoDisponivel (gate comum de Video/
* Impressora), MontarCursoresImpressao / MontarCabecalhoImpressao (bloco
* "Criando a Impressao" do fim do Click legado) e ExecutarReportForm (helper
* canonico: guard de FRX, guard de cursor vazio, isolamento de locale e
* restauracao do menu).
*
* Fase 8/8 fecha os eventos auxiliares que faltavam do dump e consolida o
* estado da tela:
*   - o "PROCEDURE When / Return .F." dos DEZ totalizadores de cnt_4c_Resumo,
*     transcrito como .TabStop = .F. em AdicionarTotalizador (BINDEVENT nao
*     serve para When - descarta o retorno do delegate);
*   - LimparResultado() - devolve a area de Resultado ao estado inicial
*     (container e os 5 detalhes escondidos, os 10 totais zerados), no ponto
*     em que o legado faz "ThisForm.Resultado.Visible = .f.";
*   - HabilitarCampos(par_lHabilitar) + a property this_lProcessando -
*     guard de reentrancia do botao Processar, reposto nos DOIS caminhos de
*     volta (sucesso e CATCH).
*
* O SCX legado NAO tem botao CRUD (Incluir/Alterar/Visualizar-registro/
* Excluir), nem Salvar/Cancelar, nem pagina de Lista: SIGPRFEM eh tela de
* processamento/analise, e os quatro botoes acima sao os unicos CommandButton
* do dump. Por isso este form nao tem BtnSalvarClick/BtnCancelarClick/
* BtnBuscarClick/CarregarLista/AjustarBotoesPorModo nem o par FormParaBO/
* BOParaForm: nao ha registro para gravar nem lista para navegar. O
* equivalente de FormParaBO aqui eh a leitura dos tres filtros no inicio de
* BtnProcessarClick (repassados a SigPrFemBO.Processar), e o equivalente de
* BOParaForm eh AtualizarResumo(), que espelha as properties this_n* do BO
* nos dez totalizadores. Inventar os handlers CRUD violaria o PILAR 1 e a
* regra "NUNCA inventar".
*
* Os DEZ PROCEDURE do dump legado e onde cada um foi parar:
*   posbalanco  -> SigPrFemBO.PosBalanco()          (Fase 2)
*   Load        -> CriarCursoresResultado()          (Fase 4)
*   Init        -> SigPrFemBO.Init() (os CursorQuery) + Init/InicializarForm
*   Release     -> Destroy()                         (libera o BO/cursores)
*   When x10    -> .TabStop = .F. em AdicionarTotalizador
*   Processar   -> BtnProcessarClick + SigPrFemBO.Processar()
*   Valid (Get_Demonstrativo) -> ValidarDemonstrativo/AbrirBuscaDemonstrativo
*   Visualizar  -> BtnVisualizarClick        Imprimir -> BtnImprimirClick
*   Sair        -> BtnSairClick
* O =fConfigGeral() do Load NAO eh chamado: o wrapper projeto\app\utils\
* fconfiggeral.prg eh no-op e existe so para o p-code dos VCX legado (regra
* #27); em codigo nosso a configuracao global ja veio do config.prg/main.prg.
*==============================================================================
DEFINE CLASS FormSigPrFem AS FormBase

    *-- Layout legado: 1000x600, sem TitleBar/ControlBox/MaxButton/MinButton
    Width        = 1000
    Height       = 600
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
    DataSession  = 2

    *-- .T. quando Processar terminou E os cursores de impressao (TmpImp/
    *-- Cabecalho) foram montados. Eh o gate dos botoes Video/Impressora -
    *-- equivale ao "If thisform.resultado.Visible" do legado, so que sem
    *-- depender apenas da visibilidade do container.
    this_lResultadoPronto = .F.

    *-- Guard de reentrancia do botao Processar. O calculo do SigPrFemBO exibe
    *-- barra de progresso (fwprogressbar), e cada .Refresh() dela devolve a
    *-- vez ao VFP: sem este guard um segundo clique em Processar entraria em
    *-- BtnProcessarClick com o primeiro ainda rodando, e as duas execucoes
    *-- disputariam os MESMOS cursores (ZAP/SCAN/REPLACE simultaneos sobre
    *-- cursor_4c_Entradas/Saidas/Saldos/SaldoAnt/Falhas/Resumo).
    this_lProcessando = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        THIS.this_cTituloForm = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrFemBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrFemBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em FormSigPrFem.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_oFormUI = THIS

                *-- Cursores da area de Resultado (equivale ao PROCEDURE Load
                *-- do legado, que roda ANTES do Init)
                THIS.CriarCursoresResultado()

                *-- Compor layout (flat OPERACIONAL, sem PageFrame CRUD)
                THIS.ConfigurarPageFrame()

                *-- Ecoar Caption nas labels do cabecalho (apos ConfigurarPageFrame)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
    * OPERACIONAL flat - o legado SIGPRFEM nao usa PageFrame; os controles
    * (filtros, botoes, container Resultado) ficam diretamente sobre o Form.
    * Este metodo orquestra a composicao das regioes do form: cabecalho
    * (cntSombra) + container Resultado (5 grids de detalhe + Resumo) + barra
    * de acao do topo direito (Shapes + Video/Impressora/Processar/Encerrar).
    * As Fases 5-6 acrescentam os filtros/labels do topo e a Fase 7-8 os
    * eventos dos botoes de acao. Nome preservado por compatibilidade com o
    * pipeline de migracao.
    *
    * A barra de acao eh a ULTIMA: os botoes ficam em Top = 3, dentro da area
    * da faixa cinza do cabecalho, e so aparecem se criados depois dela.
    *==========================================================================
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarResultado()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
    * Cria cnt_4c_Sombra com lbl_4c_LblSombra (sombra preta) e lbl_4c_LblTitulo
    * (texto branco) - replica cntSombra/lblSombra/lblTitulo do legado
    * (SIGPRFEM.SCX), com o titulo definido em runtime a partir de THIS.Caption
    * (mesmo padrao do legado: ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
    *==========================================================================
        LOCAL loc_oCab, loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = loc_oCab.Width - 20
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = ""
                .Visible   = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .AutoSize    = .F.
                .Top         = 17
                .Left        = 10
                .Width       = loc_oCab.Width - 20
                .Height      = 46
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .ForeColor   = RGB(255, 255, 255)
                .Caption     = ""
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
    *==========================================================================
    * Campos de filtro diretamente sobre o Form (SIGPRFEM nao tem PageFrame -
    * regra OPERACIONAL flat). Fase 5/8 acrescentou a faixa do Per?odo
    * (Label3 "Per?odo :" + Get_Datai + Label1 "a" + Get_Dataf), transcrita
    * do dump (SIGPRFEM.Label3/Get_Datai/Label1/Get_Dataf).
    *
    * Fase 6/8 acrescenta o label Say4 ("Tipo An" + CHR(225) + "lise :") e o
    * campo Get_Demonstrativo (txt_4c_Demonstrativo), com o lookup fwBuscaExt
    * do legado migrado para FormBuscaAuxiliar (SigPrDmo.Nome, tabela
    * single-column). BINDEVENT + handlers (TeclaDemonstrativo/
    * ValidarDemonstrativo/AbrirBuscaDemonstrativo) ficam logo apos este
    * metodo, PUBLIC (regra do BINDEVENT - metodos PROTECTED falham em
    * silencio).
    *
    * Get_Datai/Get_Dataf sao TextBox de DATA (.Value = {}, nao string vazia -
    * o legado tem Format = "K" + Value = {}), preenchidos pelo usuario ou
    * validados no Click de Processar (Fases 7-8). Label1 (CHR(224), "a-grave")
    * eh o separador entre as duas datas - AutoSize=.T. no dump, mas AddObject
    * ignora AutoSize (regra #23): usar AutoSize=.F. + Width/Height do dump.
    *==========================================================================
        LOCAL loc_oErro
        TRY
            *-- "Per?odo :" (SIGPRFEM.Label3)
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Per" + CHR(237) + "odo :"
                .Left      = 398
                .Top       = 90
                .Width     = 45
                .Height    = 15
                .Visible   = .T.
            ENDWITH

            *-- Data inicial (SIGPRFEM.Get_Datai)
            THIS.AddObject("txt_4c_Datai", "TextBox")
            WITH THIS.txt_4c_Datai
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .Value         = {}
                .Format        = "K"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Left          = 445
                .Top           = 86
                .Width         = 80
                .Height        = 25
                .Visible       = .T.
            ENDWITH

            *-- Separador "a-grave" (CHR(224)) entre as duas datas (SIGPRFEM.Label1)
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = CHR(224)
                .Left      = 530
                .Top       = 90
                .Width     = 8
                .Height    = 15
                .Visible   = .T.
            ENDWITH

            *-- Data final (SIGPRFEM.Get_Dataf)
            THIS.AddObject("txt_4c_Dataf", "TextBox")
            WITH THIS.txt_4c_Dataf
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .Value         = {}
                .Format        = "K"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Left          = 542
                .Top           = 86
                .Width         = 80
                .Height        = 25
                .Visible       = .T.
            ENDWITH

            *-- "Tipo An" + CHR(225) + "lise :" (SIGPRFEM.Say4) - classe say pura
            *-- (sem Width/Alignment no dump - regra #23): Width explicita
            *-- generosa para nao cortar a legenda; o label eh criado ANTES do
            *-- TextBox, entao a sobra transparente (BackStyle=0) fica inofensiva.
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tipo An" + CHR(225) + "lise :"
                .Left      = 377
                .Top       = 118
                .Width     = 70
                .Height    = 15
                .Visible   = .T.
            ENDWITH

            *-- Demonstrativo/config. de Grupos-Contas (SIGPRFEM.Get_Demonstrativo)
            *-- Lookup em SigPrDmo.Nome (tabela single-column: codigo e
            *-- descricao sao o MESMO campo Nome - regra do SigCdOpe/SigPrDmo,
            *-- NUNCA inventar uma 2a coluna). Format = "K" no dump (upper,
            *-- sem ser multiple-choice - regra #24 nao se aplica aqui).
            THIS.AddObject("txt_4c_Demonstrativo", "TextBox")
            WITH THIS.txt_4c_Demonstrativo
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .Value         = ""
                .Format        = "K"
                .MaxLength     = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Left          = 445
                .Top           = 113
                .Width         = 154
                .Height        = 25
                .Visible       = .T.
            ENDWITH

            *-- BINDEVENT: F4/DblClick abrem o picker direto; Enter/Tab
            *-- disparam a validacao (equivalente ao PROCEDURE Valid do legado)
            BINDEVENT(THIS.txt_4c_Demonstrativo, "DblClick", THIS, "AbrirBuscaDemonstrativo")
            BINDEVENT(THIS.txt_4c_Demonstrativo, "KeyPress", THIS, "TeclaDemonstrativo")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.ConfigurarFiltros")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE TeclaDemonstrativo(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
    * Handler de KeyPress de txt_4c_Demonstrativo (BINDEVENT exige PUBLIC -
    * regra #3). F4(115) abre o picker direto; Enter(13)/Tab(9) disparam a
    * validacao - equivalente ao PROCEDURE Valid do legado (Get_Demonstrativo),
    * que roda ao sair do campo.
    *==========================================================================
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDemonstrativo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDemonstrativo()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarDemonstrativo()
    *==========================================================================
    * Transcricao do PROCEDURE Valid de SIGPRFEM.Get_Demonstrativo: campo
    * vazio limpa (legado: This.Value = ''); campo preenchido tenta match
    * exato em SigPrDmo.Nome e, sem match, abre o picker (o legado sempre
    * chama fwBuscaExt, que ja faz o match exato sozinho - aqui a checagem
    * exata fica explicita para nao depender de reabrir o FormBuscaAuxiliar
    * so para confirmar um valor ja digitado corretamente).
    *==========================================================================
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro

        IF VARTYPE(THIS.txt_4c_Demonstrativo) != "O"
            RETURN
        ENDIF

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
            IF EMPTY(loc_cValor)
                THIS.txt_4c_Demonstrativo.Value = ""
            ELSE
                loc_cSQL = "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + ;
                           EscaparSQL(loc_cValor)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FemDmoVal")
                IF loc_nResultado > 0 AND !EOF("cursor_4c_FemDmoVal")
                    SELECT cursor_4c_FemDmoVal
                    THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoVal.Nome)
                ELSE
                    THIS.AbrirBuscaDemonstrativo()
                ENDIF
                IF USED("cursor_4c_FemDmoVal")
                    USE IN cursor_4c_FemDmoVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.ValidarDemonstrativo")
        ENDTRY

        THIS.txt_4c_Demonstrativo.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE AbrirBuscaDemonstrativo()
    *==========================================================================
    * Lookup de SIGPRFEM.Get_Demonstrativo via FormBuscaAuxiliar (substitui o
    * fwBuscaExt legado, que buscava em SigPrDmo/crListaRemota pelo campo
    * Nome). Tabela single-column: codigo e descricao sao o MESMO campo
    * Nome, entao ha uma UNICA mAddColuna (regra do SigCdOpe/SigPrDmo -
    * nunca inventar uma 2a coluna). Contrato do FormBuscaAuxiliar (regra
    * #37): o Init ja tenta o match exato sozinho - so mostra o picker
    * quando this_lAchouRegistro = .F., e so atribui o valor quando
    * this_lSelecionou = .T., para nao zerar o campo se o usuario cancelar.
    *==========================================================================
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        IF VARTYPE(THIS.txt_4c_Demonstrativo) != "O"
            RETURN
        ENDIF

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrDmo", "cursor_4c_FemDmoBusca", "Nome", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Nome", "", "Nome")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FemDmoBusca")
                    SELECT cursor_4c_FemDmoBusca
                    THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoBusca.Nome)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.AbrirBuscaDemonstrativo")
        ENDTRY

        IF USED("cursor_4c_FemDmoBusca")
            USE IN cursor_4c_FemDmoBusca
        ENDIF
        THIS.txt_4c_Demonstrativo.Refresh()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarResultado()
    *==========================================================================
    * Cria cnt_4c_Resultado (equivalente a SIGPRFEM.Resultado, Visible=.F.
    * ate o botao Processar exibi-lo) com os 5 sub-containers de detalhe
    * (Detalhe/detalhe2/detalhe3/detalhe4/detalhe5 do legado, cada um com
    * label Titulo + Grid de 3 colunas) e o container Resumo com os
    * totalizadores. Geometria e propriedades transcritas do dump
    * SigPrFem_form_codigo_fonte.txt (secoes SIGPRFEM.Resultado.*).
    *==========================================================================
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Resultado", "Container")
            WITH THIS.cnt_4c_Resultado
                .Top       = 144
                .Left      = 9
                .Width     = 981
                .Height    = 453
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe", 5, 336, ;
                "Saldo com funcion" + CHR(225) + "rios antes do per" + CHR(237) + "odo", 230)
            THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe2", 4, 15, ;
                "Entradas no per" + CHR(237) + "odo", 115)
            THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe3", 184, 15, ;
                "Sa" + CHR(237) + "das no per" + CHR(237) + "odo", 102)
            THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe4", 184, 336, ;
                "Saldo final com funcion" + CHR(225) + "rios", 159)
            THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe5", 5, 659, ;
                "Falhas dos funcion" + CHR(225) + "rios no per" + CHR(237) + "odo", 196)

            THIS.ConfigurarResumo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.ConfigurarResultado")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeDetalhe(par_cNome, par_nTop, par_nLeft, par_cTitulo, par_nLarguraTitulo)
    *==========================================================================
    * Monta um dos 5 sub-containers de detalhe (par_cNome) dentro de
    * cnt_4c_Resultado: label lbl_4c_Titulo + grid grd_4c_Dados (3 colunas,
    * ReadOnly, sem RecordMark/DeleteMark - regra OPERACIONAL). O
    * RecordSource/ControlSource do grid NAO eh definido aqui: o cursor de
    * dados ainda nao existe (soh eh criado quando o botao Processar roda,
    * nas fases seguintes) - regra #41 (ControlSource antes do cursor
    * existir derruba o Init). Quem popular o grid mais adiante DEVE
    * reaplicar Column.Width/Header1.Caption depois de setar RecordSource
    * (RecordSource reseta ambos - Problema 48/regra #35c).
    *==========================================================================
        LOCAL loc_oDet

        THIS.cnt_4c_Resultado.AddObject(par_cNome, "Container")
        loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cNome)
        WITH loc_oDet
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = 294
            .Height    = 172
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        loc_oDet.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oDet.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = par_cTitulo
            .Left      = 9
            .Top       = 4
            .Width     = par_nLarguraTitulo
            .Height    = 15
            .Visible   = .T.
        ENDWITH

        loc_oDet.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oDet.grd_4c_Dados
            .Top               = 24
            .Left              = 3
            .Width             = 288
            .Height            = 139
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH

        WITH loc_oDet.grd_4c_Dados.Column1
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 110
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Header1"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oDet.grd_4c_Dados.Column2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Header1"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oDet.grd_4c_Dados.Column3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 40
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Emp"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarResumo()
    *==========================================================================
    * Monta cnt_4c_Resumo (SIGPRFEM.Resultado.Resumo) dentro de
    * cnt_4c_Resultado, com os 10 TextBox ReadOnly de totalizadores
    * (mapeados para this_n* de SigPrFemBO - o preenchimento eh feito por
    * AtualizarResumo(), chamado por CarregarDados() a partir de
    * BtnProcessarClick)
    * e os 11 labels correspondentes. Geometria/propriedades transcritas do
    * dump (secoes SIGPRFEM.Resultado.Resumo.*).
    *==========================================================================
        LOCAL loc_oRes

        THIS.cnt_4c_Resultado.AddObject("cnt_4c_Resumo", "Container")
        loc_oRes = THIS.cnt_4c_Resultado.cnt_4c_Resumo
        WITH loc_oRes
            .Top       = 184
            .Left      = 659
            .Width     = 294
            .Height    = 264
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label13", "Totalizadores", 7, 4, 79, .T.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label5", "Saldo Inicial :", 136, 27, 65, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Saldoi", 203, 25, .F.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label4", ;
            "Saldo funcion" + CHR(225) + "rios ant./ per" + CHR(237) + "odo :", 39, 50, 162, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_SaldoAnt", 203, 48, .F.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label6", ;
            "Entradas no per" + CHR(237) + "odo :", 95, 73, 106, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Entradas", 203, 71, .F.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label7", "Sub-Total entradas :", 100, 96, 101, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_TEntradas", 203, 94, .F.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label8", ;
            "Sa" + CHR(237) + "das no per" + CHR(237) + "odo :", 107, 119, 94, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Saidas", 203, 117, .F.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label1", "Saldo :", 162, 142, 39, .T.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Saldo", 203, 140, .T.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label2", ;
            "Saldo final com funcion" + CHR(225) + "rios :", 60, 165, 141, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_SaldoFunc", 203, 163, .F.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label9", ;
            "Pesagem f" + CHR(237) + "sica :", 122, 188, 79, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Pesagem", 203, 186, .F.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label3", "Total :", 164, 211, 37, .T.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_SaldoT", 203, 209, .T.)

        THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label12", ;
            "Falha funcion" + CHR(225) + "rios no per" + CHR(237) + "odo :", 51, 234, 150, .F.)
        THIS.AdicionarTotalizador(loc_oRes, "txt_4c_FalhaFunc", 203, 232, .F.)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AdicionarLabelResumo(par_oPai, par_cNome, par_cCaption, par_nLeft, par_nTop, par_nWidth, par_lNegrito)
    *==========================================================================
    * Helper para os labels de cnt_4c_Resumo - classe "say" do legado
    * (AutoSize=.T. no dump), mas AddObject nao respeita AutoSize (regra
    * #23): usar AutoSize=.F. + Width/Height transcritos do dump.
    *==========================================================================
        par_oPai.AddObject(par_cNome, "Label")
        WITH EVALUATE("par_oPai." + par_cNome)
            .AutoSize  = .F.
            .FontBold  = par_lNegrito
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = par_cCaption
            .Left      = par_nLeft
            .Top       = par_nTop
            .Width     = par_nWidth
            .Height    = 15
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AdicionarTotalizador(par_oPai, par_cNome, par_nLeft, par_nTop, par_lNegrito)
    *==========================================================================
    * Helper para os TextBox ReadOnly de totalizadores de cnt_4c_Resumo -
    * mesmo padrao (Alignment/InputMask/SpecialEffect/cores) nos 10 campos
    * do dump (Get_Saldoi/Get_SaldoAnt/Get_Entradas/Get_TEntradas/
    * Get_Saidas/Get_Saldo/Get_SaldoFunc/Get_Pesagem/Get_SaldoT/Get_FalhaFunc).
    *
    * .TabStop = .F. eh a transcricao do "PROCEDURE When / Return .F." que os
    * DEZ totalizadores tem no dump: o When devolvendo .F. impede o campo de
    * receber foco, tirando-o da ordem de tabulacao. Nao da para migrar isso
    * com BINDEVENT(.., "When", ..) - o BINDEVENT DESCARTA o retorno do
    * delegate, entao um When ligado assim nunca bloqueia nada (mesma
    * armadilha da regra #3). Com .TabStop = .F. o Tab pula os 10 campos, e o
    * .ReadOnly = .T. ja existente cobre o caso do clique com o mouse.
    *==========================================================================
        par_oPai.AddObject(par_cNome, "TextBox")
        WITH EVALUATE("par_oPai." + par_cNome)
            .FontBold          = par_lNegrito
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = 0
            .InputMask         = "999,999.999"
            .Margin            = 1
            .ReadOnly          = .T.
            .TabStop           = .F.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(100, 100, 100)
            .Left              = par_nLeft
            .Top               = par_nTop
            .Width             = 86
            .Height            = 21
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
    *==========================================================================
    * Barra de acao do topo direito - transcrita do dump do legado
    * (SIGPRFEM.Shape2 / Shape1 / Visualizar / Imprimir / Processar / Sair).
    *
    * A ORDEM DE CRIACAO IMPORTA por dois motivos:
    *   1) os botoes ficam em Top = 3, DENTRO da area da faixa cinza do
    *      cabecalho (cnt_4c_Sombra: Top 0, Height 80) - por isso este metodo
    *      roda DEPOIS de ConfigurarCabecalho, senao a faixa cobre os botoes;
    *   2) os dois Shapes sao as molduras que ficam ATRAS dos botoes
    *      (Shape2 emoldura Video/Impressora, Shape1 emoldura Processar/
    *      Encerrar) - criados antes, os CommandButton desenham por cima.
    * AddObject empilha no z-order: o ultimo objeto criado fica na frente.
    *
    * O ZOrderSet do dump NAO eh transcrito - eh bookkeeping do Form Designer
    * e nao existe como propriedade em runtime (regra #33); o equivalente eh
    * exatamente esta ordem de criacao.
    *
    * Os CommandButton sao STANDALONE (nao estao em CommandGroup) e tem
    * .Picture, entao levam .Themes = .T. + .DisabledPicture com a MESMA
    * imagem: com Themes = .F. o icone deixa de renderizar quando o botao
    * fica Enabled = .F. (o dump legado traz Themes = .F. - aqui eh desvio
    * deliberado, para o icone nao desaparecer).
    *==========================================================================
        LOCAL loc_oErro
        TRY
            *-- Moldura de Video/Impressora (SIGPRFEM.Shape2)
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 7
                .Left          = 667
                .Width         = 146
                .Height        = 75
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .T.
            ENDWITH

            *-- Moldura de Processar/Encerrar (SIGPRFEM.Shape1)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 8
                .Left        = 816
                .Width       = 173
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Visualizar em tela (SIGPRFEM.Visualizar)
            THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
            THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Visualizar, 700, ;
                "   \<V" + CHR(237) + "deo            ", ;
                "relatorio_video_26.jpg", "Visualizar", .F.)

            *-- Imprimir (SIGPRFEM.Imprimir)
            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Imprimir, 775, ;
                " \<Impressora    ", ;
                "relatorio_impressora_26.jpg", "Imprimir", .F.)

            *-- Processar a analise (SIGPRFEM.Processar)
            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Processar, 850, ;
                "Processar", "geral_processar_60.jpg", "", .F.)

            *-- Encerrar (SIGPRFEM.Sair - Cancel = .T. no dump: responde ao ESC)
            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Sair, 925, ;
                "Encerrar", "cadastro_sair_60.jpg", "", .T.)

            *-- Eventos dos 4 botoes (Fase 7). Os handlers sao PUBLIC de
            *-- proposito: BINDEVENT falha EM SILENCIO com metodo PROTECTED.
            BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmd_4c_Processar,  "Click", THIS, "BtnProcessarClick")
            BINDEVENT(THIS.cmd_4c_Sair,       "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoAcao(par_oBotao, par_nLeft, par_cCaption, par_cIcone, par_cToolTip, par_lCancel)
    *==========================================================================
    * Aplica a um dos 4 CommandButton da barra de acao (JA criado pelo
    * AddObject do chamador) as propriedades que os quatro compartilham no
    * dump: Top = 3, 75x75, Comic Sans MS 8 bold italic, ForeColor 90,90,90
    * sobre BackColor branco, PicturePosition = 13 (icone acima do texto).
    * Mudam apenas Left, Caption, Picture, ToolTipText e o Cancel do Encerrar.
    *
    * O AddObject fica no chamador, com o nome LITERAL, de proposito: assim o
    * nome de cada botao eh visivel no fonte (e nao escondido atras de um
    * parametro) para quem le o form e para as auditorias do pipeline.
    *==========================================================================
        WITH par_oBotao
            .Top               = 3
            .Left              = par_nLeft
            .Width             = 75
            .Height            = 75
            .FontBold          = .T.
            .FontItalic        = .T.
            .FontName          = "Comic Sans MS"
            .FontSize          = 8
            .WordWrap          = .T.
            .AutoSize          = .F.
            .Caption           = par_cCaption
            .Picture           = gc_4c_CaminhoIcones + par_cIcone
            .DisabledPicture   = gc_4c_CaminhoIcones + par_cIcone
            .PicturePosition   = 13
            .ToolTipText       = par_cToolTip
            .Cancel            = par_lCancel
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .SpecialEffect     = 0
            .MousePointer      = 15
            .Themes            = .T.
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresResultado()
    *==========================================================================
    * Equivalente ao PROCEDURE Load do legado: cria os cursores que alimentam
    * os 5 grids da area de Resultado, mais o cursor de trabalho do resumo,
    * com a MESMA estrutura, a MESMA ORDEM DE CAMPOS e os MESMOS indices do
    * dump (regra dos forms OPERACIONAIS: cursor recriado em outro ponto tem
    * de repetir a ordem dos campos, senao o APPEND/REPLACE vai para a coluna
    * errada).
    *
    * Roda ANTES de compor o layout, como no legado (Load executa antes do
    * Init): assim os cursores ja existem quando CarregarDados() liga os
    * grids. Os AddObject dos grids NAO definem RecordSource/ControlSource
    * (regra #41 - ControlSource de cursor inexistente derruba o Init); todo
    * o bind vive em CarregarDados().
    *
    * DataSession = 2 (private): estes cursores pertencem a esta instancia do
    * form e morrem com ela.
    *==========================================================================
        LOCAL loc_oErro
        TRY
            *-- Entradas no periodo (legado: Entradas)
            IF USED("cursor_4c_Entradas")
                USE IN cursor_4c_Entradas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Entradas (Emps C(3), TpOps C(15), Qtde N(12,3))
            SET NULL OFF
            INDEX ON Emps + TpOps TAG TpOps

            *-- Saidas no periodo (legado: Saidas)
            IF USED("cursor_4c_Saidas")
                USE IN cursor_4c_Saidas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Saidas (Emps C(3), TpOps C(15), Qtde N(12,3))
            SET NULL OFF
            INDEX ON Emps + TpOps TAG TpOps

            *-- Saldo atual com funcionarios (legado: Saldos)
            IF USED("cursor_4c_Saldos")
                USE IN cursor_4c_Saldos
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Saldos (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
            SET NULL OFF
            INDEX ON Grupos + Contas TAG GruConta

            *-- Saldo com funcionarios antes do periodo (legado: SaldoAnt)
            IF USED("cursor_4c_SaldoAnt")
                USE IN cursor_4c_SaldoAnt
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_SaldoAnt (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
            SET NULL OFF
            INDEX ON Grupos + Contas TAG GruConta

            *-- Falhas dos funcionarios no periodo (legado: Falhas)
            IF USED("cursor_4c_Falhas")
                USE IN cursor_4c_Falhas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Falhas (Grupos C(10), Contas C(10), Qtde N(12,3), ;
                                            Entra N(12,3), Saida N(12,3), Emps C(3))
            SET NULL OFF
            INDEX ON Grupos + Contas TAG GruConta

            *-- Cursor de trabalho do resumo por Grupo/Conta/Produto (legado: TmpResumo)
            IF USED("cursor_4c_Resumo")
                USE IN cursor_4c_Resumo
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Resumo (Flag L, Flag2 L, Grupo C(10), Conta C(10), ;
                CMats C(14), CUnis C(3), PesoEnts N(12,3), QtdeEnts N(12,3), ;
                PesoSais N(12,3), QtdeSais N(12,3), Saldoi N(12,3), Pesagem N(12,3), ;
                FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), PesoPEnts N(12,3), ;
                PesoPSais N(12,3), PfTrabs N(9,2), Flag3 L, Varias N(1), ;
                PesoFabre N(12,3), PesoFabrs N(12,3), cUniPs C(3), CodCors C(4), ;
                CodTams C(4), Visivel L, Agregas N(1))
            SET NULL OFF
            INDEX ON CMats + CodCors + CodTams TAG cpros
            INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel
        CATCH TO loc_oErro
            *-- Se o erro estourou entre um SET NULL ON e o OFF correspondente,
            *-- repor aqui - senao SET NULL fica ligado para o resto da sessao.
            SET NULL OFF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.CriarCursoresResultado")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDados()
    *==========================================================================
    * Liga os 5 grids da area de Resultado aos cursores ja populados e exibe
    * o bloco inteiro - transcricao do trecho final de Processar.Click do
    * legado (os cinco blocos "With ThisForm.Resultado.Detalhe<N>" seguidos de
    * "ThisForm.Resultado.Visible = .t."). Devolve .T. quando o Resultado foi
    * exibido.
    *
    * Nomes de coluna e captions transcritos um a um do legado:
    *   SaldoAnt -> Fase / Qtde / Emp        Entradas -> Operacao / Qtde / Emp
    *   Saidas   -> Operacao / Qtde / Emp    Saldos   -> Fase / Qtde / Emp
    *   Falhas   -> Fase / Falha / Emp
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Saldo anterior (legado: Detalhe <- SaldoAnt)
            THIS.LigarGradeDetalhe("cnt_4c_Detalhe", "cursor_4c_SaldoAnt", ;
                "Grupos", "Fase", "Qtde", "Qtde")

            *-- Entradas no periodo (legado: detalhe2 <- Entradas)
            THIS.LigarGradeDetalhe("cnt_4c_Detalhe2", "cursor_4c_Entradas", ;
                "TpOps", "Opera" + CHR(231) + CHR(227) + "o", "Qtde", "Qtde")

            *-- Saidas no periodo (legado: detalhe3 <- Saidas)
            THIS.LigarGradeDetalhe("cnt_4c_Detalhe3", "cursor_4c_Saidas", ;
                "TpOps", "Opera" + CHR(231) + CHR(227) + "o", "Qtde", "Qtde")

            *-- Saldo atual com funcionario (legado: detalhe4 <- Saldos)
            THIS.LigarGradeDetalhe("cnt_4c_Detalhe4", "cursor_4c_Saldos", ;
                "Grupos", "Fase", "Qtde", "Qtde")

            *-- Falhas dos funcionarios (legado: detalhe5 <- Falhas)
            THIS.LigarGradeDetalhe("cnt_4c_Detalhe5", "cursor_4c_Falhas", ;
                "Grupos", "Fase", "Qtde", "Falha")

            *-- Totalizadores do bloco Resumo
            THIS.AtualizarResumo()

            *-- Exibe o bloco de resultado (legado: ThisForm.Resultado.Visible = .t.)
            THIS.cnt_4c_Resultado.Visible = .T.
            THIS.Refresh()

            *-- O legado chama .SetFocus em cada uma das 5 grades; o efeito
            *-- observavel eh o foco terminar na ultima (detalhe5).
            IF THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.Visible AND ;
               THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.grd_4c_Dados.Visible
                THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.grd_4c_Dados.SetFocus()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LigarGradeDetalhe(par_cContainer, par_cCursor, par_cCampo1, par_cCaption1, par_cCampo2, par_cCaption2)
    *==========================================================================
    * Aplica a UM dos 5 sub-containers de detalhe o bind que o legado faz em
    * bloco: torna o container e a grade visiveis, posiciona o cursor no topo,
    * define RecordSource + ControlSource das 3 colunas, os captions e - por
    * ULTIMO - as larguras do dump. A 3a coluna eh sempre Emps/"Emp" nos
    * cinco grids do legado.
    *
    * Por que a largura vem DEPOIS do RecordSource: atribuir RecordSource/
    * ControlSource faz o VFP recalcular as larguras para o default 90 e
    * resetar os Header1.Caption (Problema 48 / regra #35c) - definir antes
    * seria descartado.
    *
    * Sem o GO TOP + Refresh a grade nao repinta as linhas inseridas depois
    * de o cursor ter nascido vazio: o cursor fica cheio e a tela parece sem
    * dados (o legado fecha cada bloco com Select <cursor> / Go Top / .Refresh
    * pelo mesmo motivo).
    *==========================================================================
        LOCAL loc_oDet, loc_oGrid

        IF !USED(par_cCursor)
            RETURN
        ENDIF

        *-- Os 5 sub-containers de detalhe sao filhos de cnt_4c_Resultado, nao
        *-- do Form (Left/Top no dump sao relativos ao container Resultado).
        loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cContainer)
        loc_oDet.Visible = .T.

        loc_oGrid = loc_oDet.grd_4c_Dados
        loc_oGrid.Visible = .T.

        SELECT (par_cCursor)
        GO TOP

        *-- ColumnCount/RecordSource ficam FORA do WITH: acessar .Column dentro
        *-- do mesmo WITH que ainda esta definindo o RecordSource estoura
        *-- 'Unknown member COLUMN1' porque as colunas nao existem no momento
        *-- em que o WITH eh aberto.
        loc_oGrid.ColumnCount  = 3
        loc_oGrid.RecordSource = par_cCursor

        WITH loc_oGrid
            .Column1.ControlSource   = par_cCursor + "." + par_cCampo1
            .Column1.Header1.Caption = par_cCaption1
            .Column2.ControlSource   = par_cCursor + "." + par_cCampo2
            .Column2.Header1.Caption = par_cCaption2
            .Column3.ControlSource   = par_cCursor + ".Emps"
            .Column3.Header1.Caption = "Emp"

            *-- Larguras do dump, reaplicadas DEPOIS do RecordSource
            .Column1.Width = 110
            .Column2.Width = 80
            .Column3.Width = 40

            .Refresh()
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AtualizarResumo()
    *==========================================================================
    * Espelha nos 10 TextBox ReadOnly de cnt_4c_Resumo os totais calculados
    * pelo BO - transcricao do bloco "With ThisForm.Resultado.Resumo" do
    * legado. FONTE UNICA: quem calcula eh o SigPrFemBO (this_n*), o form
    * apenas exibe - as somas do legado (lnSaldoIni + lnTotalEntra +
    * lnSaldoaFun para o sub-total, lnPesagem + lnSaldoFunc para o total)
    * NAO sao repetidas aqui, para o mesmo numero nao ser calculado em dois
    * lugares (regra #17).
    *==========================================================================
        LOCAL loc_oRes, loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_oBO  = THIS.this_oBusinessObject
        loc_oRes = THIS.cnt_4c_Resultado.cnt_4c_Resumo

        WITH loc_oRes
            .txt_4c_Saldoi.Value    = loc_oBO.this_nSaldoInicial
            .txt_4c_SaldoAnt.Value  = loc_oBO.this_nSaldoAnterior
            .txt_4c_Entradas.Value  = loc_oBO.this_nEntradas
            .txt_4c_TEntradas.Value = loc_oBO.this_nTotalEntradas
            .txt_4c_Saidas.Value    = loc_oBO.this_nSaidas
            .txt_4c_Pesagem.Value   = loc_oBO.this_nPesagem
            .txt_4c_Saldo.Value     = loc_oBO.this_nSaldo
            .txt_4c_SaldoFunc.Value = loc_oBO.this_nSaldoFuncionarios
            .txt_4c_FalhaFunc.Value = loc_oBO.this_nFalhaFuncionarios
            .txt_4c_SaldoT.Value    = loc_oBO.this_nSaldoTotal
            .Refresh()
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE LimparResultado()
    *==========================================================================
    * PUBLIC de proposito (sem PROTECTED): os harness de teste do pipeline
    * chamam esta familia de metodos de FORA da classe, e PEMSTATUS(oForm,
    * "LimparResultado", 5) devolve .T. mesmo com o metodo PROTECTED - so
    * verifica existencia, nao escopo. O teste entraria no branch e a chamada
    * real estouraria "Property LIMPARRESULTADO is not found" (regra #3).
    *
    * Devolve a area de Resultado ao estado de tela recem-aberta: esconde o
    * container (equivale ao "ThisForm.Resultado.Visible = .f." que abre o
    * Processar.Click legado), esconde os cinco sub-containers de detalhe e
    * zera os dez totalizadores.
    *
    * Por que os sub-containers e os totalizadores tambem: no legado os cinco
    * "With ThisForm.Resultado.Detalhe<N> / .Visible = .t." so rodam no FIM de
    * um processamento bem-sucedido, entao um processamento que aborta no meio
    * deixa o bloco inteiro escondido e ninguem ve numero velho. Aqui, sem
    * esta limpeza, os dez TextBox continuariam com os valores da rodada
    * ANTERIOR e os cinco containers continuariam Visible = .T. por baixo do
    * container escondido - e bastaria uma rodada seguinte parar antes de
    * CarregarDados() para o usuario ver, lado a lado, grades da rodada nova e
    * totais da rodada velha, sem nenhum aviso de que sao de periodos
    * diferentes.
    *
    * Os totalizadores sao zerados DIRETO (e nao por AtualizarResumo) porque
    * aqui a intencao eh justamente NAO espelhar o BO: as properties this_n*
    * dele ainda carregam o resultado antigo neste ponto.
    *==========================================================================
        LOCAL loc_nI, loc_cCnt, loc_oRes

        THIS.this_lResultadoPronto    = .F.
        THIS.cnt_4c_Resultado.Visible = .F.

        *-- Os cinco sub-containers do dump: Detalhe, detalhe2..detalhe5.
        *-- Acesso por nome montado vai de STORE ... TO (expr), nunca de
        *-- Controls("<nome>") - Controls eh indexado por NUMERO (regra #34).
        FOR loc_nI = 1 TO 5
            loc_cCnt = "cnt_4c_Detalhe" + IIF(loc_nI = 1, "", TRANSFORM(loc_nI))
            IF PEMSTATUS(THIS.cnt_4c_Resultado, loc_cCnt, 5)
                STORE .F. TO ("THIS.cnt_4c_Resultado." + loc_cCnt + ".Visible")
            ENDIF
        ENDFOR

        loc_oRes = THIS.cnt_4c_Resultado.cnt_4c_Resumo
        WITH loc_oRes
            .txt_4c_Saldoi.Value    = 0
            .txt_4c_SaldoAnt.Value  = 0
            .txt_4c_Entradas.Value  = 0
            .txt_4c_TEntradas.Value = 0
            .txt_4c_Saidas.Value    = 0
            .txt_4c_Pesagem.Value   = 0
            .txt_4c_Saldo.Value     = 0
            .txt_4c_SaldoFunc.Value = 0
            .txt_4c_FalhaFunc.Value = 0
            .txt_4c_SaldoT.Value    = 0
        ENDWITH

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
    * PUBLIC pelo mesmo motivo de LimparResultado (regra #3): os harness do
    * pipeline chamam oForm.HabilitarCampos(.F./.T.) de fora da classe.
    *
    * Liga/desliga os tres filtros do topo e os quatro botoes de acao. Eh a
    * metade VISIVEL do guard this_lProcessando: enquanto o SigPrFemBO calcula,
    * o botao Processar fica Enabled = .F. e nem chega a disparar o Click, em
    * vez de depender so da flag para recusar a reentrada.
    *
    * Desligar tambem cmd_4c_Sair eh proposital: ele tem Cancel = .T. (responde
    * ao ESC), e fechar a tela no meio do processamento destruiria os cursores
    * que o BO ainda esta percorrendo.
    *
    * Os quatro botoes sobrevivem ao Enabled = .F. sem perder o icone porque
    * ConfigurarBotaoAcao ja os cria com .Themes = .T. + .DisabledPicture
    * apontando para a MESMA imagem (regra do CommandButton standalone com
    * Picture).
    *
    * REABILITAR EH OBRIGACAO DO FUNIL, NAO DO CHAMADOR (licao do Erro176):
    * quem chama HabilitarCampos(.F.) eh so BtnProcessarClick, e ele repoe
    * HabilitarCampos(.T.) nos DOIS caminhos de volta - o de sucesso e o do
    * CATCH. Sem a reposicao no CATCH, um erro no meio do calculo deixaria a
    * tela inteira cinza e inutilizavel ate ser fechada e reaberta.
    *==========================================================================
        LOCAL loc_lLiga

        loc_lLiga = .T.
        IF VARTYPE(par_lHabilitar) = "L"
            loc_lLiga = par_lHabilitar
        ENDIF

        THIS.txt_4c_Datai.Enabled         = loc_lLiga
        THIS.txt_4c_Dataf.Enabled         = loc_lLiga
        THIS.txt_4c_Demonstrativo.Enabled = loc_lLiga

        THIS.cmd_4c_Processar.Enabled  = loc_lLiga
        THIS.cmd_4c_Visualizar.Enabled = loc_lLiga
        THIS.cmd_4c_Imprimir.Enabled   = loc_lLiga
        THIS.cmd_4c_Sair.Enabled       = loc_lLiga
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
    * Torna visiveis todos os controles recursivamente (AddObject cria com
    * Visible = .F.). FILTRO OBRIGATORIO: o container Resultado (Fase 4) e
    * os cinco sub-containers de detalhe (Detalhe/detalhe2/detalhe3/detalhe4/
    * detalhe5) sao flutuantes com Visible=.F. no legado ate o usuario clicar
    * Processar - NAO tornar visiveis aqui, mas recursar dentro deles para
    * que os filhos (Grid/Titulo) fiquem prontos quando o botao Processar
    * exibir o container.
    *==========================================================================
        LOCAL loc_nI, loc_oControl, loc_nP
        IF VARTYPE(par_oContainer) != "O"
            par_oContainer = THIS
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_RESULTADO", ;
                          "CNT_4C_DETALHE", "CNT_4C_DETALHE2", "CNT_4C_DETALHE3", ;
                          "CNT_4C_DETALHE4", "CNT_4C_DETALHE5")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC


    *==========================================================================
    * BtnProcessarClick - evento do botao Processar (SIGPRFEM.Processar.Click)
    *
    * Transcricao da PARTE DE TELA do Click legado: le os tres filtros, aplica
    * as tres validacoes com SetFocus, esconde o bloco de Resultado, delega o
    * calculo ao BO e volta a exibir o Resultado com as grades ligadas.
    *
    * As tres validacoes ficam AQUI (e nao no BO) porque cada uma devolve o
    * foco a um controle - e os controles sao do form. Os RETURN delas vem
    * ANTES do TRY (regra #1: RETURN nao pode existir dentro de TRY/CATCH).
    *
    * Ordem e mensagens EXATAS do legado:
    *   1. Empty(ldDataf)      -> "A Data Final Deve Ser Informada!!!"      -> Get_Dataf
    *   2. ldDatai > ldDataf   -> "A Data Final Deve Ser Maior Que a Data Inicial!!!" -> Get_Datai
    *   3. Empty(lcConfig)     -> "A Configuracao Deve Ser Informada!!!"    -> Get_Demonstrativo
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_dDataI, loc_dDataF, loc_cConfig, loc_oErro

        *-- Guard de reentrancia: a barra de progresso do BO devolve a vez ao
        *-- VFP a cada Refresh, entao um segundo clique cairia aqui com o
        *-- primeiro processamento ainda percorrendo os cursores. RETURN ANTES
        *-- do TRY (regra #1).
        IF THIS.this_lProcessando
            RETURN
        ENDIF

        *-- SIGPRFEM eh OPERACIONAL FLAT: os filtros sao filhos DIRETOS do Form
        *-- (nao ha PageFrame nem container de filtros), como em ConfigurarFiltros
        loc_dDataI  = ConverterParaData(THIS.txt_4c_Datai.Value)
        loc_dDataF  = ConverterParaData(THIS.txt_4c_Dataf.Value)
        loc_cConfig = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)

        IF EMPTY(loc_dDataF)
            MsgAviso("A Data Final Deve Ser Informada!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Dataf.SetFocus()
            RETURN
        ENDIF

        IF loc_dDataI > loc_dDataF
            MsgAviso("A Data Final Deve Ser Maior Que a Data Inicial!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Datai.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cConfig)
            MsgAviso("A Configura" + CHR(231) + CHR(227) + "o Deve Ser Informada!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Demonstrativo.SetFocus()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
                    CHR(237) + "vel.", "Erro em FormSigPrFem.BtnProcessarClick")
            RETURN
        ENDIF

        TRY
            THIS.this_lProcessando = .T.
            THIS.HabilitarCampos(.F.)

            *-- Legado: ThisForm.Resultado.Visible = .f. / ThisForm.Refresh
            *-- (aqui tambem escondendo os 5 detalhes e zerando os totais,
            *-- para nao sobrar numero da rodada anterior se esta abortar)
            THIS.LimparResultado()

            THIS.MousePointer = 11

            IF THIS.this_oBusinessObject.Processar(loc_dDataI, loc_dDataF, loc_cConfig)
                *-- Liga as 5 grades + espelha os totalizadores + exibe o bloco
                IF THIS.CarregarDados()
                    *-- "Criando a Impressao" do fim do Click legado: monta os
                    *-- cursores que o SigPrFem.frx consome (TmpImp/cabecalho)
                    THIS.this_lResultadoPronto = THIS.MontarCursoresImpressao()
                ENDIF
            ENDIF

            THIS.MousePointer = 0
            THIS.HabilitarCampos(.T.)
            THIS.this_lProcessando = .F.
        CATCH TO loc_oErro
            *-- Caminho de volta do ERRO: repor o estado da tela AQUI tambem,
            *-- senao um erro no meio do calculo deixa os filtros e os quatro
            *-- botoes cinza para sempre (licao do Erro176)
            THIS.MousePointer = 0
            THIS.HabilitarCampos(.T.)
            THIS.this_lProcessando = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - evento do botao Video (SIGPRFEM.Visualizar.Click)
    *
    * Legado:
    *   If thisform.resultado.Visible / Select TmpImp / Go Top / If !Eof()
    *       Report Form SIGPRFEM Preview NoConsole
    *
    * O "resultado.Visible" do legado eh o gate: sem ter processado, o botao
    * nao faz nada. Aqui o gate eh o mesmo container (cnt_4c_Resultado) mais a
    * flag this_lResultadoPronto, que so fica .T. quando os cursores de
    * impressao foram montados - assim o clique antes de processar avisa em vez
    * de abrir um preview vazio.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        IF !THIS.ResultadoDisponivel()
            RETURN
        ENDIF

        TRY
            = THIS.ExecutarReportForm("SigPrFem", "PREVIEW", "TmpImp")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - evento do botao Impressora (SIGPRFEM.Imprimir.Click)
    *
    * Legado: identico ao Visualizar, trocando "Preview" por "To Print Prompt".
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro

        IF !THIS.ResultadoDisponivel()
            RETURN
        ENDIF

        TRY
            = THIS.ExecutarReportForm("SigPrFem", "PRINTER_PROMPT", "TmpImp")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - evento do botao Encerrar (SIGPRFEM.Sair.Click)
    * Legado: ThisForm.Release
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ResultadoDisponivel - gate comum de Video/Impressora
    *
    * Reproduz o "If thisform.resultado.Visible ... If !Eof()" que envolve os
    * dois Click de relatorio do legado. Devolve .T. so quando ha o que
    * imprimir; quando nao ha, avisa (o legado fica MUDO, o que faz o usuario
    * clicar varias vezes achando que o botao esta quebrado - desvio
    * deliberado, e o unico do bloco).
    *==========================================================================
    PROTECTED FUNCTION ResultadoDisponivel()
        LOCAL loc_lPronto
        loc_lPronto = .F.

        IF THIS.cnt_4c_Resultado.Visible AND THIS.this_lResultadoPronto AND ;
           USED("TmpImp")
            SELECT TmpImp
            GO TOP
            loc_lPronto = !EOF("TmpImp")
        ENDIF

        IF !loc_lPronto
            MsgAviso("Processe a an" + CHR(225) + "lise antes de emitir o relat" + ;
                     CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF

        RETURN loc_lPronto
    ENDFUNC

    *==========================================================================
    * MontarCursoresImpressao - bloco "Criando a Impressao" do fim de
    * Processar.Click legado.
    *
    * Monta TmpImprime (coluna da esquerda: totais e falhas por fase),
    * TmpImprime2 (coluna da direita: resumo de entradas/saidas/saldos), faz o
    * FULL JOIN das duas em TmpImp e cria o cursor Cabecalho.
    *
    * Os nomes TmpImp/Cabecalho e os nomes de campo (Linha/Cabec/Titulo/Valor/
    * Traco/Entrada/Saida/Falha/Linha2/Cabec2/Titulo2/Valor2/Traco2/Emps) NAO
    * levam o prefixo cursor_4c_ nem sufixo _4c_: sao contrato do SigPrFem.frx,
    * que veio do legado sem alteracao (PILAR 1/2). Renomear aqui quebraria
    * todas as expressoes do FRX.
    *
    * As somas usadas nas linhas do relatorio vem das properties this_n* do BO
    * (FONTE UNICA - regra #17): o total nao eh recalculado aqui.
    *==========================================================================
    PROTECTED FUNCTION MontarCursoresImpressao()
        LOCAL loc_lSucesso, loc_oErro, loc_oBO
        LOCAL loc_nLinha, loc_nLinha2, loc_nPerc
        LOCAL loc_nQEnt, loc_nQSai, loc_nQFalha, loc_cOrdem

        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF USED("TmpImprime2")
                USE IN TmpImprime2
            ENDIF
            CREATE CURSOR TmpImprime2 (Linha2 N(3), Cabec2 L, Titulo2 C(40), ;
                                       Valor2 N(12,3), Traco2 L, Emps C(3))

            IF USED("TmpImprime")
                USE IN TmpImprime
            ENDIF
            CREATE CURSOR TmpImprime (Linha N(3), Cabec L, Titulo C(80), Valor N(12,3), ;
                                      Valor1 N(11,3), Traco L, Entrada N(12,3), ;
                                      Saida N(12,3), Falha L)

            *-- Coluna da esquerda: os 11 totalizadores, na ordem do legado
            loc_nLinha = 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Saldo Inicial : ", loc_oBO.this_nSaldoInicial)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Saldo Ant c/Funcion" + CHR(225) + "rio : ", ;
                         loc_oBO.this_nSaldoAnterior)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Entradas : ", loc_oBO.this_nEntradas)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Total de Entradas : ", loc_oBO.this_nTotalEntradas)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Sa" + CHR(237) + "das : ", loc_oBO.this_nSaidas)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Saldo : ", loc_oBO.this_nSaldo)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Saldo com Funcion" + CHR(225) + "rios : ", ;
                         loc_oBO.this_nSaldoFuncionarios)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Pesagem : ", loc_oBO.this_nPesagem)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
                 VALUES (loc_nLinha, .F., "Total : ", loc_oBO.this_nSaldoTotal)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
                 VALUES (loc_nLinha, .F., "Falha dos Funcion" + CHR(225) + "rios : ", ;
                         loc_oBO.this_nFalhaFuncionarios, .T.)
            loc_nLinha = loc_nLinha + 1
            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
                 VALUES (loc_nLinha, .F., "Diferenca : ", ;
                         loc_oBO.this_nSaldo - loc_oBO.this_nPesagem - ;
                         loc_oBO.this_nSaldoFuncionarios - loc_oBO.this_nFalhaFuncionarios, .T.)

            *-- Coluna da direita: resumo de entradas / saidas / saldos das fases
            loc_nLinha2 = 0

            SELECT cursor_4c_Entradas
            GO TOP
            IF !EOF()
                loc_nLinha2 = loc_nLinha2 + 1
                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
                     VALUES (loc_nLinha2, .T., "Resumo de Entradas")

                SELECT cursor_4c_Entradas
                SCAN
                    loc_nLinha2 = loc_nLinha2 + 1
                    INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
                         VALUES (loc_nLinha2, .F., cursor_4c_Entradas.TpOps, ;
                                 cursor_4c_Entradas.Qtde, cursor_4c_Entradas.Emps)
                    SELECT cursor_4c_Entradas
                ENDSCAN
                REPLACE Traco2 WITH .T. IN TmpImprime2
            ENDIF

            loc_nLinha2 = loc_nLinha2 + 1
            INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
                 VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nEntradas)

            SELECT cursor_4c_Saidas
            GO TOP
            IF !EOF()
                loc_nLinha2 = loc_nLinha2 + 1
                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
                     VALUES (loc_nLinha2, .T., "Resumo de Saidas")

                SELECT cursor_4c_Saidas
                SCAN
                    loc_nLinha2 = loc_nLinha2 + 1
                    INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
                         VALUES (loc_nLinha2, .F., ;
                                 IIF(EMPTY(cursor_4c_Saidas.TpOps), "PRODUZIDO", cursor_4c_Saidas.TpOps), ;
                                 cursor_4c_Saidas.Qtde, cursor_4c_Saidas.Emps)
                    SELECT cursor_4c_Saidas
                ENDSCAN
                REPLACE Traco2 WITH .T. IN TmpImprime2
            ENDIF

            loc_nLinha2 = loc_nLinha2 + 1
            INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
                 VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaidas)

            SELECT cursor_4c_Saldos
            GO TOP
            IF !EOF()
                loc_nLinha2 = loc_nLinha2 + 1
                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
                     VALUES (loc_nLinha2, .T., " ")
                loc_nLinha2 = loc_nLinha2 + 1
                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
                     VALUES (loc_nLinha2, .T., "Saldos das Fases")

                SELECT cursor_4c_Saldos
                SCAN
                    loc_nLinha2 = loc_nLinha2 + 1
                    INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
                         VALUES (loc_nLinha2, .F., cursor_4c_Saldos.Grupos, cursor_4c_Saldos.Qtde)
                    SELECT cursor_4c_Saldos
                ENDSCAN
                REPLACE Traco2 WITH .T. IN TmpImprime2
            ENDIF

            loc_nLinha2 = loc_nLinha2 + 1
            INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
                 VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaldoFuncionarios)

            *-- Falhas por fase - a coluna "%" eh Falha/Saida*100 (regra do legado:
            *-- percentual sobre a SAIDA, nao sobre a entrada).
            *-- O guard de Saida = 0 eh o UNICO desvio: o legado divide direto e
            *-- estoura "Divisao por zero" numa fase sem saida no periodo,
            *-- derrubando a montagem do relatorio inteiro.
            SELECT cursor_4c_Falhas
            GO TOP
            IF !EOF()
                loc_nLinha = loc_nLinha + 1
                INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
                     VALUES (loc_nLinha, .T., PADC("Falhas das Fases", 70))
                loc_nLinha = loc_nLinha + 1
                INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
                     VALUES (loc_nLinha, .T., ;
                             "Setor           Entrada      Saida      Falha Gr         %")

                SELECT cursor_4c_Falhas
                SCAN
                    loc_nLinha = loc_nLinha + 1
                    loc_nPerc  = IIF(cursor_4c_Falhas.Saida = 0, 0, ;
                                     cursor_4c_Falhas.Qtde / cursor_4c_Falhas.Saida * 100)
                    INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
                                            Entrada, Saida, Falha) ;
                         VALUES (loc_nLinha, .F., cursor_4c_Falhas.Grupos, ;
                                 cursor_4c_Falhas.Qtde, loc_nPerc, cursor_4c_Falhas.Entra, ;
                                 cursor_4c_Falhas.Saida, .T.)
                    SELECT cursor_4c_Falhas
                ENDSCAN

                SELECT cursor_4c_Falhas
                SUM Entra, Saida, Qtde TO loc_nQEnt, loc_nQSai, loc_nQFalha
                loc_nPerc = IIF(loc_nQSai = 0, 0, loc_nQFalha / loc_nQSai * 100)

                REPLACE Traco WITH .T. IN TmpImprime
                loc_nLinha = loc_nLinha + 1
                INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
                                        Entrada, Saida, Falha) ;
                     VALUES (loc_nLinha, .F., " ", loc_nQFalha, loc_nPerc, ;
                             loc_nQEnt, loc_nQSai, .T.)
            ENDIF

            *-- FULL JOIN das duas colunas, ordenado pela mais longa
            loc_cOrdem = "T1.Linha"
            IF loc_nLinha2 > loc_nLinha
                loc_cOrdem = "T2.Linha2"
            ENDIF

            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            SELECT T1.*, T2.* ;
              FROM TmpImprime T1 ;
              FULL JOIN TmpImprime2 T2 ;
                ON T1.Linha = T2.Linha2 ;
              INTO CURSOR TmpImp ;
             ORDER BY &loc_cOrdem.

            *-- Cabecalho do FRX (razao social da empresa + titulo + periodo)
            IF !THIS.MontarCabecalhoImpressao()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel montar o cabe" + ;
                         CHR(231) + "alho do relat" + CHR(243) + "rio.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            loc_lSucesso = USED("TmpImp")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.MontarCursoresImpressao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * MontarCabecalhoImpressao - cursor "Cabecalho" consumido pelo SigPrFem.frx
    *
    * Legado:
    *   CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr, 'Razas')
    *   Create Cursor Cabecalho(pNomeEmpresa c(60), pRelTitulo c(60), pPeriodo c(60))
    *   Insert ... Values (crSigCdEmp.Razas, 'Analise de Producao',
    *                      'Periodo : ' + Dtoc(ldDatai) + ' ate ' + Dtoc(ldDataf))
    *
    * SigCdEmp usa Cemps/Razas (nao Cemps/Razas) - conferido em docs/schema.sql.
    *==========================================================================
    PROTECTED FUNCTION MontarCabecalhoImpressao()
        LOCAL loc_cRazao, loc_nRet, loc_cSQL, loc_oBO

        loc_oBO   = THIS.this_oBusinessObject
        loc_cRazao = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_CdEmp")
                USE IN cursor_4c_CdEmp
            ENDIF
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdEmp")
            IF loc_nRet >= 1 AND USED("cursor_4c_CdEmp") AND !EOF("cursor_4c_CdEmp")
                loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_CdEmp.Razas, ""))
            ENDIF
        ENDIF

        IF EMPTY(loc_cRazao)
            loc_cRazao = ALLTRIM(go_4c_Sistema.cEmpresa)
        ENDIF

        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        CREATE CURSOR Cabecalho (pNomeEmpresa C(60), pRelTitulo C(60), pPeriodo C(60))
        INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
             VALUES (loc_cRazao, ;
                     "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o", ;
                     "Per" + CHR(237) + "odo : " + DTOC(loc_oBO.this_dDataInicial) + ;
                     " at" + CHR(233) + " " + DTOC(loc_oBO.this_dDataFinal))

        RETURN USED("Cabecalho")
    ENDFUNC

    *==========================================================================
    * ExecutarReportForm - helper canonico de REPORT FORM
    *
    * Combina o que o REPORT FORM cru do legado nao tem e sem o que o relatorio
    * sai errado ou nao sai:
    *   1. guard de EXISTENCIA do FRX (o legado usa "Report Form SIGPRFEM"
    *      BARE, e o VFP9 procuraria o arquivo no diretorio corrente);
    *   2. guard de cursor VAZIO (preview em branco nao diz nada ao usuario);
    *   3. isolamento de locale - SET POINT "." / SEPARATOR "," /
    *      REPORTBEHAVIOR 80: os FRX Fortyus tem PICTURE no padrao americano e,
    *      com o locale BR do sistema, os campos numericos saem como *******;
    *   4. restauracao do menu - o preview abre toolbar propria que corrompe o
    *      cache visual do _MSYSMENU e deixa os popups encolhidos.
    *==========================================================================
    PROTECTED FUNCTION ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                    CHR(13) + loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
            SELECT (par_cCursorDados)
            GO TOP
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                          popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora de escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDFUNC
    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            *-- Cursores de impressao do FRX (nomes ditados pelo SigPrFem.frx)
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            IF USED("TmpImprime")
                USE IN TmpImprime
            ENDIF
            IF USED("TmpImprime2")
                USE IN TmpImprime2
            ENDIF
            IF USED("Cabecalho")
                USE IN Cabecalho
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrFem.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

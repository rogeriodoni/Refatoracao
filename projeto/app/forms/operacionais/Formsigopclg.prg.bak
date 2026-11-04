*==============================================================================
* Formsigopclg.prg - Form Operacional: Consulta do Log
* Migrado de SIGOPCLG.SCX
* Herda de FormBase
* Business Object: sigopclgBO
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> Schema IDENTICO (SigOpLog - ver sigopclgBO.prg)
*   CODE -> arquitetura em camadas (FormBase / sigopclgBO)
*
* Form OPERACIONAL: NAO segue o padrao Page1=Lista/Page2=Dados de cadastro
* CRUD (ver CLAUDE.md "Form OPERACIONAL"). No legado (pgfPagina):
*   Pagina 1 = PgDados     -> filtros de pesquisa (Usuario de Rede,
*              Periodo, Horario de Acesso, Programa, Operacao, Usuario do
*              Sistema, Parametros, Transacao) + CommandGroup cmdProcessar
*              (2 botoes: Processar dispara sigopclgBO.BuscarLog() /
*              Encerrar fecha a tela - ThisForm.Release).
*   Pagina 2 = pgResultado -> grade com o resultado da pesquisa (GrdLog,
*              7 colunas) + fwget1 (Transacao do registro corrente) +
*              CommandGroup cmdBotoes (1 botao, legenda "Encerrar" com
*              icone de sair, mas o Click real e "ThisForm.PgfPagina.
*              PgResultado.Enabled=.f. / ActivePage=1" - volta para a
*              pagina de filtros, nao fecha a tela).
*
* Os metodos de configuracao de pagina mantem os nomes canonicos do
* pipeline (ConfigurarPaginaLista/ConfigurarPaginaDados) mesmo as paginas
* nao sendo Lista/Dados de CRUD - mesma convencao de FormSigOpCgr.prg/
* Formsigopcgc.prg (familia de dialogos de pesquisa/consulta OPERACIONAL).
*
* FASE 3/8: Estrutura base do Form - DEFINE CLASS, Init/InicializarForm,
* ConfigurarPageFrame com as 2 paginas (Dados/Resultado) e os containers
* principais vazios: cnt_4c_Cabecalho (faixa do titulo, nas DUAS paginas -
* regra CLAUDE.md #11, que prevalece sobre o legado, cujo dump so tem
* cntSombra em PgDados), cnt_4c_Botoes (Page1) e cnt_4c_BotoesAcao (Page2).
*
* Largura do form escalada para o canonico 1000x600 (legado: 800x600),
* mesma convencao de FormSigOpCgr.prg. Os botoes sao transcritos com o
* tamanho fisico do dump (75x75/85x85); so a largura do form e a posicao
* horizontal dos containers mudam.
*
* FASE 4/8: CommandGroup cmg_4c_Acoes dentro de cnt_4c_Botoes (Page1 -
* 2 botoes: Processar/btnProcessar e Encerrar/btnSair, transcritos do
* cmdProcessar legado - ButtonCount=2, mesmo Width/Height do container) e
* CommandGroup cmg_4c_Voltar dentro de cnt_4c_BotoesAcao (Page2 - 1 botao,
* transcrito do cmdBotoes legado: Caption/Picture de sair ("Encerrar" +
* cadastro_sair_60.jpg), mas o Click real (Fase 7/8) volta para a pagina
* de filtros - por isso o handler se chamara BtnVoltarClick e nao
* BtnEncerrarClick, nome pela ACAO real e nao pela legenda do botao).
* Grade grd_4c_Dados (Page2), ligada a this_oBusinessObject.this_cCursorLog
* via VincularGradeLog() - FONTE UNICA do bind (regra CLAUDE.md #41/#48),
* com cursor placeholder criado por InicializarCursorLog() ANTES do Grid
* ser configurado (regra #41 - Column.ControlSource de cursor inexistente
* derruba o Init). ControlSource/Width/Header1.Caption das 7 colunas
* transcritos do PROCEDURE processamento legado (que SOBRESCREVE os
* headers do dump estatico do SCX - regra "a pagina segue o Init/metodo
* legado, nao o dump"): Usuario Rede/Data/Hora/Programa/Operacao (ligada a
* cOpers, a descricao calculada, nao a Opers crua)/Usuario Sistema/
* Parametro. Geometria do Grid (Top=197/Left=63/Width=656/Height=307) =
* valores do dump + compensacao +29 do PageFrame.Top=-29 (regra #1/#11) -
* sem rescala horizontal, pois a faixa de botoes Left=917 nao alcanca essa
* altura (Top>=197). AlternarPagina(par_nPagina) tambem entra nesta fase,
* com o guard que o legado tem no proprio fluxo (Processamento so chega em
* "ActivePage = 2" quando a consulta devolve linha - "If Eof() Then
* Return" - aqui expresso contra this_oBusinessObject.this_nQtdeLog, que
* ja existe desde a Fase 1/2) e o toggle de Page2.Enabled (btnDados.Click
* legado faz Enabled=.f. antes de voltar para a Pagina 1).
*
* O BINDEVENT dos botoes e da grade (Click/AfterRowColChange) ficou para a
* Fase 7/8 de proposito: o delegate de BINDEVENT tem de EXISTIR no momento
* do bind (regra CLAUDE.md sobre BINDEVENT com delegate inexistente
* estourando no bind, nao no clique) e BtnProcessarClick depende dos
* campos de filtro das Fases 5/6 (na Fase 4 FormParaBO ainda nao existia).
*
* FASE 5/8 (PARTE 1/2): primeira metade dos campos de filtro da Page1 -
* txt_4c_UserRede (Usuario de Rede), txt_4c_DtIni/txt_4c_DtFin (Periodo) e
* txt_4c_HrIni/txt_4c_HrFin (Horario de Acesso, Format "R" + InputMask
* "99:99" transcritos do dump) e txt_4c_Prg (Programa) + os labels
* correspondentes (Say1/Say2/Say3/Say4/Say5/Say6 do legado). Todos filhos
* DIRETOS da Page1 (sem container de agrupamento no dump), Top = dump + 29
* (compensacao PageFrame.Top=-29), Left mantido igual ao dump (so os
* containers de botao usam posicao canonica rescalada - Fase 3/4).
* Caracteres acentuados via CHR() (regra CLAUDE.md #4): CHR(225)=a-acute,
* CHR(237)=i-acute, CHR(224)=a-grave (confirmado no .scx - byte 0xE0 -
* usado entre as duas datas/horarios do periodo, ex. "01/01 " + CHR(224) +
* " 31/01"). O lookup de Programa (SigCdPrg.Programas) entrou na Fase 6/8,
* abaixo.
*
* FASE 6/8 (PARTE 2/2): segunda metade dos campos - cbo_4c_GetOperacao
* (ComboBox de Operacao, RowSourceType=1 + Style=2 com a lista
* "Liberacao,Entrada,Saida,Transacao, " transcrita LITERALMENTE do dump,
* item em branco final incluido), txt_4c_UserSis (Usuario do Sistema),
* txt_4c_Param (Parametros) e txt_4c_Trans (Transacao) + os labels
* Say7/Say8/Say9/Say10 do legado; na Page2, txt_4c_Fwget1 (Transacao do
* registro corrente, Enabled=.F. no dump) + o Say10 homonimo dela
* (FontBold=.T.), com o ControlSource ligado dentro de VincularGradeLog()
* para acompanhar a grade - igual ao bloco final do PROCEDURE
* processamento legado, que liga grade e fwget1 juntos.
*
* Lookups COMPLETOS nesta fase, cada um com a API que corresponde ao
* browse do legado:
*   - Programa (GetPrg.Valid -> fwBuscaInt, browse sobre cursor LOCAL):
*     sigopclgBO.BuscarProgramas() popula cursor_4c_Programas, LOCATE
*     tenta o match e, falhando, FormBuscaAuxiliar recebe o cursor ja
*     populado via DefinirCursor() - reduzido a UMA coluna, porque
*     SigCdPrg.Programas eh codigo E descricao (familia de SigCdOpe).
*   - Usuario do Sistema (GetUserSis.Valid -> fwBuscaExt, consulta o SQL
*     Server): FormBuscaAuxiliar com Init por parametros (1o argumento =
*     gnConnHandle, regra CLAUDE.md #36) + guarda this_lAchouRegistro
*     antes do Show e this_lSelecionou antes de atribuir (regra #37).
* Os dois vao em "LostFocus" (o legado valida no Valid, ao SAIR do campo),
* com guarda de reentrancia this_lEmLookup, mais F4/DblClick como entradas
* diretas - os handlers de KeyPress TESTAM a tecla (regra #47).
*
* FASE 7/8: eventos dos botoes e o fluxo de pesquisa que eles disparam,
* mais os BINDEVENT correspondentes (que so podiam entrar agora - o
* delegate de BINDEVENT tem de EXISTIR no momento do bind).
*
* O legado NAO tem barra CRUD: SIGOPCLG herda de "form" PURO (nao de
* frmcadastro), nao tem Grupo_Op nem pcEscolha, e nenhum dos seus 3 botoes
* eh Incluir/Alterar/Visualizar/Excluir. Por isso NAO existem
* BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick: os
* "eventos principais dos botoes" desta tela sao os 3 Click que o dump
* PROVA existirem, um handler por BOTAO (como no legado, onde cada botao
* tem o seu proprio .Click - nao ha despachante por .Value a transcrever):
*   - cmg_4c_Acoes.Buttons(1) -> BtnProcessarClick  (Command1.Click:
*     MessageBox de confirmacao + ThisForm.Processamento)
*   - cmg_4c_Acoes.Buttons(2) -> BtnEncerrarClick   (btnSair.Click:
*     ThisForm.Release)
*   - cmg_4c_Voltar.Buttons(1) -> BtnVoltarClick    (btnDados.Click:
*     PgResultado.Enabled=.f. + ActivePage=1 - volta para os filtros, NAO
*     fecha a tela; o nome segue a ACAO e nao a legenda "Encerrar")
*
* O PROCEDURE processamento legado fica repartido entre o form e o BO,
* cada parte do lado de quem ela pertence:
*   - form: confirmacao, leitura dos 10 filtros (FormParaBO), exibicao das
*     mensagens com o ICONE do legado (16 = MsgErro para "Nenhum Parametro
*     de Selecao foi Preenchido"; 64 = MsgInfo para "Nenhum Registro
*     Encontrado para Selecao"), o bind/unbind da grade e a troca de pagina.
*   - BO (Fase 1/2): a validacao de "nenhum filtro", o WHERE dinamico e o
*     SQLEXEC em cursor_4c_Log (sigopclgBO.BuscarLog()).
* DesvincularGradeLog transcreve a 1a linha do processamento legado
* ("GrdLog.RecordSource = ''") e nao eh cosmetica: BuscarLog() faz USE IN +
* SQLEXEC sobre o MESMO alias, e SQLEXEC sobre alias ligado a Grid ZERA o
* ColumnCount. A ordem do caminho de sucesso eh desvincular -> consultar ->
* VincularGradeLog -> AlternarPagina(2) -> RepintarGradeLog, porque Refresh
* em pagina OCULTA nao pinta (regra CLAUDE.md #21).
* Nesta fase tambem entra o AfterRowColChange da grade
* (GrdDadosAfterRowColChange = "fwget1.Refresh" do legado + sincronizacao
* do registro corrente do BO via CarregarDoCursor), porque a grade e o
* campo txt_4c_Fwget1 ja existem e sem ele a Transacao exibida ficaria
* presa na primeira linha; e o "PgResultado.Enabled=.f." do Init legado,
* que eh o estado inicial do toggle que BtnVoltarClick/AlternarPagina usam.
*
* FASE 8/8: CarregarLista, BOParaForm e LimparCampos.
*
* CarregarLista eh o FUNIL unico de carga da grade - o corpo do "PROCEDURE
* processamento" legado, que na Fase 7 estava inline no BtnProcessarClick.
* O Click do botao ficou com o que o Click legado de fato tem (a
* confirmacao) e delega o resto, para que qualquer caminho que precise
* repopular a grade use o MESMO metodo: popular cursor NAO repinta a grade
* sozinho e a repintura tem de vir DEPOIS de a pagina estar visivel
* (regra CLAUDE.md #21/#46), e duplicar essa sequencia eh o que faz uma das
* copias esquecer o Refresh e a grade aparecer vazia com o cursor cheio.
*
* O nome segue o canonico do pipeline (e nao um nome livre como
* "CarregarLog"): e' a mesma convencao de FormSigOpCgr.prg/Formsigopcgc.prg
* (citados no topo deste arquivo) - os dois sao dialogos de pesquisa
* OPERACIONAL do MESMO jeito que este, com grade de RESULTADO e nao de
* LISTA de cadastro, e os dois usam CarregarLista para o funil equivalente.
* Alem da consistencia com os forms-irmaos, TesteAutomatico.prg (harness da
* etapa 06b) so reconhece um conjunto fixo de nomes de metodo de carga para
* forms OPERACIONAL (MontaGrade/CarregarSaldos/CarregarDados/
* CarregarHistorico/CarregarGrade/CarregarLista/Buscar/Consultar); um nome
* fora dessa lista faz o teste "CarregarDadosReais" cair no fallback
* generico, que tenta um SQLEXEC direto contra gnConnHandle - sempre 0
* durante o teste automatizado (regra CLAUDE.md - harness nao tenta conexao
* real), reprovando o teste mesmo com o form correto.
*
* BOParaForm eh o sentido inverso de FormParaBO - escreve os 10 filtros das
* propriedades do BO de volta nos controles da Page1. LimparCampos reseta
* sigopclgBO.LimparDados() + BOParaForm + o ".GetUserRede.SetFocus" do Init
* legado (mesmo padrao de FormSigOpCgr.prg).
* O legado nao tem botao de "Limpar" - os campos ja nascem vazios no
* AddObject - mas LimparCampos centraliza o estado inicial (chamado no fim
* de InicializarForm, substituindo a atribuicao solta de ActivePage) e
* completa o par FormParaBO/BOParaForm que o pipeline exige em todo form.
* O SetFocus fica guardado por THIS.Visible: na chamada feita dentro de
* InicializarForm o form ainda nao foi exibido (SetFocus em controle
* invisivel estoura), igual ao Init legado, que roda antes do Show().
*
* AUSENCIAS LEGITIMAS (nao sao omissao - o legado nao tem o que migrar):
*   - BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick:
*     tela de CONSULTA somente-leitura, sem CRUD no legado (ver acima).
*   - Inserir/Atualizar/ExecutarExclusao no BO: o comportamento padrao
*     herdado de BusinessBase ja eh o correto para consulta.
*   - BtnCancelarClick: eh o "Cancelar" da Page2 de Dados do frmcadastro,
*     que pressupoe um modo de EDICAO cancelavel. Esta tela nao edita nada;
*     o botao que o legado tem na pgResultado nao cancela, ele VOLTA para os
*     filtros (PgResultado.Enabled=.f. + ActivePage=1) e esta migrado como
*     BtnVoltarClick, com o nome seguindo a ACAO e nao a legenda.
*==============================================================================

DEFINE CLASS Formsigopclg AS FormBase

    *-- Dimensoes e propriedades visuais (padrao canonico de form
    *-- OPERACIONAL - framework_frmcadastro_layout.md / FormSigOpCgr.prg).
    *-- Legado: Width=800/Height=600 (SIGOPCLG.SCX); escalado para o
    *-- canonico 1000x600.
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Consulta do Log"
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    Themes      = .F.

    *-- Guarda de reentrancia dos lookups (Programa / Usuario do Sistema).
    *-- O picker (FormBuscaAuxiliar) eh MODAL: ao fechar, o foco volta para
    *-- o TextBox e o proprio LostFocus que o abriu pode disparar de novo,
    *-- empilhando um segundo dialogo (regra CLAUDE.md #37/#47).
    this_lEmLookup = .F.

    *==========================================================================
    * Init() - o legado nao recebe parametros ("PROCEDURE Init" sem
    * LPARAMETERS) - DODEFAULT() ja chama InicializarForm via FormBase.Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - guarda de conexao do Init legado (CreateObject de
    * poDataMgr e checagem .pnIdconn > 0), com bypass para os modos sem
    * usuario (teste automatizado / validacao de UI).
    *
    * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
    * FORA da classe, e metodo PROTECTED falha em runtime mesmo com
    * PEMSTATUS devolvendo .T. (regra CLAUDE.md #1/TesteAutomatico).
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L"
            IF gb_4c_ModoTeste
                RETURN .T.
            ENDIF
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L"
            IF gb_4c_ValidandoUI
                RETURN .T.
            ENDIF
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- A guarda de conexao fica FORA do TRY (mesmo padrao de
        *-- FormSigOpCgr.prg): o harness de teste automatizado define
        *-- gnConnHandle = 0 de proposito, e a guarda precisa devolver
        *-- antes de qualquer SQLEXEC/CREATEOBJECT que dependa de conexao.
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopclgBO")

            *-- Cursor placeholder de cursor_4c_Log ANTES do PageFrame: a
            *-- Page2 liga Grid.RecordSource a este alias na mesma fase
            *-- (regra CLAUDE.md #41 - Column.ControlSource de cursor
            *-- inexistente derruba o Init).
            THIS.InicializarCursorLog()

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.TornarControlesVisiveis(THIS)

            THIS.pgf_4c_Paginas.Visible    = .T.

            *-- ".PgfPagina.PgResultado.Enabled=.f." do Init legado: a pagina
            *-- de resultado nasce DESLIGADA e so eh habilitada quando a
            *-- consulta devolve linha (BtnProcessarClick -> AlternarPagina(2),
            *-- Fase 7/8). Sem este estado inicial o toggle de AlternarPagina
            *-- comecaria invertido - BtnVoltarClick desliga a Page2, logo
            *-- alguem tem de deixa-la desligada na abertura.
            THIS.pgf_4c_Paginas.Page2.Enabled = .F.

            THIS.pgf_4c_Paginas.ActivePage = 1

            *-- Estado inicial do Init legado (filtros vazios) + o
            *-- ".GetUserRede.SetFocus" final (Fase 8/8) - consolidado em
            *-- LimparCampos, mesmo padrao de FormSigOpCgr.prg.
            THIS.LimparCampos()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Inicializar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursorLog - Cria o cursor placeholder do resultado da
    * pesquisa (equivalente a estrutura do "Select '          ' As cOpers,
    * a.* From SigOpLog a" do PROCEDURE processamento legado). Mesma
    * estrutura que THIS.this_oBusinessObject.BuscarLog() popula via
    * SQLEXEC - existe so para o Grid poder ser configurado
    * (RecordSource/ControlSource) nesta fase sem a tela quebrar; o
    * SQLEXEC de BuscarLog() fecha e recria este alias do zero (Fase 7/8).
    *==========================================================================
    PROTECTED PROCEDURE InicializarCursorLog()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLog

        IF !USED(loc_cCursor)
            SET NULL ON
            CREATE CURSOR (loc_cCursor) ;
                (cOpers C(10), UsuaRedes C(20), Datars T, Horas C(8), ;
                 Progs C(20), Opers C(1), Usuasis C(20), Parametros C(10), ;
                 Transacaos C(100), CVersaos C(70), cidchaves C(20), Copias C(1))
            SET NULL OFF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
    * (Dados/Resultado, espelhando PgDados/pgResultado do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height + 29
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Dados"
        loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Page2.Caption = "Resultado"
        loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Estrutura da Page1 (Dados/filtros): faixa do
    * cabecalho + CommandGroup cmg_4c_Acoes (Processar/Encerrar) + 1a
    * metade dos campos de filtro (Usuario de Rede, Periodo, Horario,
    * Programa - Fase 5/8). 2a metade (Operacao, Usuario do Sistema,
    * Parametros, Transacao) vem na Fase 6/8.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oCab

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra
        *-- CLAUDE.md #11/#39): os containers de botao ficam em Top=29..33
        *-- (dentro da area da faixa) e tem de ser criados DEPOIS para
        *-- desenhar por cima.
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH

        *-- Container com o botao Processar + Encerrar (cmdProcessar do
        *-- legado - CommandGroup com 2 botoes: Command1/btnProcessar
        *-- dispara sigopclgBO.BuscarLog() [Fase 7/8], Command2/btnSair
        *-- fecha a tela com ThisForm.Release [Fase 7/8]). Width/Height do
        *-- container = Width/Height do cmdProcessar legado (160x85).
        loc_oPag.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmg_4c_Acoes", "CommandGroup")
            WITH .cmg_4c_Acoes
                .Top         = 0
                .Left        = 0
                .Width       = 160
                .Height      = 85
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
            ENDWITH

            *-- Command1/btnProcessar do legado
            WITH .cmg_4c_Acoes.Buttons(1)
                .Top         = 5
                .Left        = 5
                .Width       = 75
                .Height      = 75
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .WordWrap    = .T.
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption     = "\<Processar"
                .ToolTipText = "Processar"
            ENDWITH

            *-- Command2/btnSair do legado
            WITH .cmg_4c_Acoes.Buttons(2)
                .Top         = 5
                .Left        = 80
                .Width       = 75
                .Height      = 75
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .WordWrap    = .T.
                .Cancel      = .T.
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption     = "Encerrar"
                .ToolTipText = "[ESC] Sair"
            ENDWITH
        ENDWITH

        *-- FASE 5/8 (PARTE 1/2): primeira metade dos campos de filtro -
        *-- Usuario de Rede, Periodo (Data Inicial/Final), Horario de
        *-- Acesso (Inicial/Final) e Programa. Sao filhos DIRETOS da
        *-- pagina no legado (sem container de agrupamento no dump), por
        *-- isso ficam direto em loc_oPag, sem rescala horizontal (so os
        *-- containers de botao usam a posicao canonica - Fase 3/4/8); Top
        *-- de cada controle = Top do dump + 29 (compensacao
        *-- PageFrame.Top=-29, regra CLAUDE.md #1/#11).
        *--
        *-- Parte 2 (Fase 6/8, abaixo): Operacao (ComboBox), Usuario do
        *-- Sistema, Parametros, Transacao + os BINDEVENT dos lookups de
        *-- Programa (SigCdPrg) e Usuario do Sistema (SigCdUsu).

        *-- Say4 "Usuario da Rede :" (Left=98/Top=197 no dump)
        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .Top       = 226
            .Left      = 98
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Usu" + CHR(225) + "rio da Rede :"
        ENDWITH

        *-- GetUserRede do legado - Usuario de Rede (this_cUserRede no BO)
        loc_oPag.AddObject("txt_4c_UserRede", "TextBox")
        WITH loc_oPag.txt_4c_UserRede
            .Top       = 223
            .Left      = 189
            .Width     = 152
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .Value     = ""
            .TabIndex  = 1
        ENDWITH

        *-- Say2 "Periodo :" (Left=141/Top=224 no dump)
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 253
            .Left      = 141
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "odo :"
        ENDWITH

        *-- getDtIni do legado - Periodo: data inicial (this_dDtIni no BO)
        loc_oPag.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPag.txt_4c_DtIni
            .Top       = 250
            .Left      = 189
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Value     = {}
            .TabIndex  = 2
        ENDWITH

        *-- Say3 "a" (CHR(224)) entre as duas datas do periodo
        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 254
            .Left      = 276
            .Width     = 12
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = CHR(224)
        ENDWITH

        *-- getDtFin do legado - Periodo: data final (this_dDtFin no BO)
        loc_oPag.AddObject("txt_4c_DtFin", "TextBox")
        WITH loc_oPag.txt_4c_DtFin
            .Top       = 250
            .Left      = 290
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Value     = {}
            .TabIndex  = 3
        ENDWITH

        *-- Say1 "Horario de Acesso :" (Left=90/Top=253 no dump)
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 282
            .Left      = 90
            .Width     = 95
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Hor" + CHR(225) + "rio de Acesso :"
        ENDWITH

        *-- GetHrIni do legado - Horario inicial, HH:MM (this_cHrIni no BO -
        *-- Format "R" + InputMask "99:99" fazem do .Value um HHMM sem
        *-- separador, regra CLAUDE.md #24/#49: transcrever o par literal)
        loc_oPag.AddObject("txt_4c_HrIni", "TextBox")
        WITH loc_oPag.txt_4c_HrIni
            .Top       = 278
            .Left      = 189
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Format    = "R"
            .InputMask = "99:99"
            .Value     = ""
            .TabIndex  = 4
        ENDWITH

        *-- Say5 "a" (CHR(224)) entre os dois horarios
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Top       = 282
            .Left      = 245
            .Width     = 13
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = CHR(224)
        ENDWITH

        *-- GetHrFin do legado - Horario final, HH:MM (this_cHrFin no BO)
        loc_oPag.AddObject("txt_4c_HrFin", "TextBox")
        WITH loc_oPag.txt_4c_HrFin
            .Top       = 278
            .Left      = 260
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Format    = "R"
            .InputMask = "99:99"
            .Value     = ""
            .TabIndex  = 5
        ENDWITH

        *-- Say6 "Programa :" (Left=131/Top=278 no dump)
        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Top       = 307
            .Left      = 131
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Programa :"
        ENDWITH

        *-- GetPrg do legado - Programa (this_cPrg no BO; lookup contra
        *-- SigCdPrg.Programas em ValidarPrgLostFocus, Fase 6/8 - BINDEVENT
        *-- no fim deste metodo). Format/InputMask do dump sao override
        *-- VAZIO do Form Designer - nao transcritos (regra CLAUDE.md #49).
        loc_oPag.AddObject("txt_4c_Prg", "TextBox")
        WITH loc_oPag.txt_4c_Prg
            .Top       = 305
            .Left      = 189
            .Width     = 152
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .MaxLength = 20
            .Value     = ""
            .TabIndex  = 6
        ENDWITH

        *-- Say8 "Operacao :" (Left=130/Top=306 no dump)
        loc_oPag.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag.lbl_4c_Label8
            .Top       = 335
            .Left      = 130
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        *-- GetOperacao do legado - ComboBox de Operacao (this_cOperacao no
        *-- BO). RowSourceType = 1 (lista literal) + Style = 2 (DropDownList):
        *-- o .Value eh o TEXTO da opcao escolhida, e eh esse texto que
        *-- sigopclgBO.BuscarLog() mapeia para o codigo de SigOpLog.Opers
        *-- (Entrada=E, Saida=S, Liberacao=L, qualquer outra = os tres <>).
        *--
        *-- A lista eh REGRA DE NEGOCIO - transcrita LITERALMENTE do dump
        *-- ("Libera??o,Entrada,Saida,Transa??o, "), inclusive o ultimo item
        *-- EM BRANCO (o ", " final), que eh como o usuario zera o filtro.
        loc_oPag.AddObject("cbo_4c_GetOperacao", "ComboBox")
        WITH loc_oPag.cbo_4c_GetOperacao
            .Top           = 331
            .Left          = 189
            .Width         = 152
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "Libera" + CHR(231) + CHR(227) + "o,Entrada,Saida," + ;
                             "Transa" + CHR(231) + CHR(227) + "o, "
            .Value         = ""
            .TabIndex      = 7
        ENDWITH

        *-- Say7 "Usuario do Sistema :" (Left=86/Top=333 no dump)
        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .Top       = 362
            .Left      = 86
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Usuario do Sistema :"
        ENDWITH

        *-- GetUserSis do legado - Usuario do Sistema (this_cUserSis no BO;
        *-- lookup contra SigCdUsu.Usuarios - ver ValidarUserSisLostFocus).
        *-- MaxLength = 20 = largura de SigOpLog.usuasis char(20), que eh a
        *-- coluna filtrada (SigCdUsu.usuarios eh char(10) - o legado tem a
        *-- mesma folga).
        loc_oPag.AddObject("txt_4c_UserSis", "TextBox")
        WITH loc_oPag.txt_4c_UserSis
            .Top       = 359
            .Left      = 189
            .Width     = 152
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .MaxLength = 20
            .Value     = ""
            .TabIndex  = 8
        ENDWITH

        *-- Say9 "Parametros :" (Left=122/Top=360 no dump)
        loc_oPag.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag.lbl_4c_Label9
            .Top       = 389
            .Left      = 122
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Parametros :"
        ENDWITH

        *-- GetParam do legado - Parametros (this_cParam no BO; filtro
        *-- "Parametros Like 'valor%'"). MaxLength = 10 = SigOpLog.parametros
        *-- char(10) (regra CLAUDE.md #19 - MaxLength vem da COLUNA, nunca do
        *-- Width em pixels, que aqui eh 82).
        loc_oPag.AddObject("txt_4c_Param", "TextBox")
        WITH loc_oPag.txt_4c_Param
            .Top       = 386
            .Left      = 189
            .Width     = 82
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .MaxLength = 10
            .Value     = ""
            .TabIndex  = 9
        ENDWITH

        *-- Say10 "Transacao :" (Left=127/Top=387 no dump)
        loc_oPag.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPag.lbl_4c_Label10
            .Top       = 416
            .Left      = 127
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Transa" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        *-- GetTrans do legado - Transacao (this_cTrans no BO; filtro
        *-- "Transacaos Like 'valor%'"). MaxLength = 150 transcrito do dump:
        *-- a coluna filtrada eh SigOpLog.transacaos char(100), mas aqui o
        *-- campo eh FILTRO (nenhum INSERT passa por ele), entao a folga do
        *-- legado nao trunca gravacao nenhuma - mexer nela mudaria UX
        *-- (PILAR 1) sem corrigir defeito.
        loc_oPag.AddObject("txt_4c_Trans", "TextBox")
        WITH loc_oPag.txt_4c_Trans
            .Top       = 413
            .Left      = 189
            .Width     = 527
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .MaxLength = 150
            .Value     = ""
            .TabIndex  = 10
        ENDWITH

        *----------------------------------------------------------------------
        * Lookups (PROCEDURE Valid de GetPrg e GetUserSis no legado)
        *
        * O picker vai em "LostFocus" e NAO em "KeyPress" (regra CLAUDE.md
        * #47): o legado valida no Valid, isto eh ao SAIR do campo; ligado a
        * "KeyPress" sem teste de tecla o dialogo subiria a CADA caractere
        * digitado e o usuario nao conseguiria terminar de digitar o codigo.
        *
        * Os handlers de "KeyPress" existem so para o atalho F4 (115) - eles
        * TESTAM a tecla e delegam ao funil AbrirLookup<X>, por isso declaram
        * (par_nKeyCode, par_nShiftAltCtrl) (regra CLAUDE.md #3: handler de
        * KeyPress sem os parametros estoura a cada tecla).
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPag.txt_4c_Prg,     "LostFocus", THIS, "ValidarPrgLostFocus")
        BINDEVENT(loc_oPag.txt_4c_Prg,     "KeyPress",  THIS, "PrgKeyPress")
        BINDEVENT(loc_oPag.txt_4c_Prg,     "DblClick",  THIS, "PrgDblClick")

        BINDEVENT(loc_oPag.txt_4c_UserSis, "LostFocus", THIS, "ValidarUserSisLostFocus")
        BINDEVENT(loc_oPag.txt_4c_UserSis, "KeyPress",  THIS, "UserSisKeyPress")
        BINDEVENT(loc_oPag.txt_4c_UserSis, "DblClick",  THIS, "UserSisDblClick")

        *----------------------------------------------------------------------
        * FASE 7/8 - BINDEVENT dos botoes de acao do cmg_4c_Acoes.
        *
        * UM handler por BOTAO (bind em Buttons(N), nao no grupo), porque no
        * legado cada botao tem o SEU proprio .Click: "Command1.Click" chama
        * ThisForm.Processamento e "btnSair.Click" faz ThisForm.Release - nao
        * ha despachante por .Value do CommandGroup para transcrever.
        *
        * O bind fica aqui (e nao na Fase 4, com o AddObject dos botoes) de
        * proposito: o delegate de BINDEVENT tem de EXISTIR no momento do
        * bind, senao estoura no BIND e nao no clique - e BtnProcessarClick
        * depende de FormParaBO, que consome os campos de filtro das Fases
        * 5/6.
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Acoes.Buttons(1), "Click", ;
                  THIS, "BtnProcessarClick")
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Acoes.Buttons(2), "Click", ;
                  THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Estrutura da Page2 (Resultado): faixa do
    * cabecalho + CommandGroup cmg_4c_Voltar (botao de retorno) + grade
    * grd_4c_Dados (resultado da pesquisa) + o campo txt_4c_Fwget1
    * (Transacao do registro corrente, Fase 6/8) + os BINDEVENT de Click do
    * botao de retorno e do AfterRowColChange da grade, que mantem esse
    * campo sincronizado com a linha corrente (Fase 7/8).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oCab

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        *-- Faixa do cabecalho tambem na pagina Resultado (regra CLAUDE.md
        *-- #11 - decisao do time, prevalece sobre o legado, cujo dump so
        *-- tem cntSombra em PgDados).
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH

        *-- Container com o botao de retorno (cmdBotoes do legado -
        *-- CommandGroup com 1 botao, legenda "Encerrar" + icone
        *-- cadastro_sair_60.jpg, mas o Click real [Fase 7/8] volta para a
        *-- pagina de filtros - "ThisForm.PgfPagina.PgResultado.Enabled=.f.
        *-- / ActivePage=1" - por isso o handler se chamara BtnVoltarClick:
        *-- o nome segue a ACAO real do legado, nao a legenda do botao).
        *-- Left/Width = padrao canonico de saida (CLAUDE.md regra #10).
        loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag.cnt_4c_BotoesAcao
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmg_4c_Voltar", "CommandGroup")
            WITH .cmg_4c_Voltar
                .Top         = 0
                .Left        = 0
                .Width       = 90
                .Height      = 85
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
            ENDWITH

            *-- Command1/btnDados do legado
            WITH .cmg_4c_Voltar.Buttons(1)
                .Top         = 5
                .Left        = 5
                .Width       = 75
                .Height      = 75
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .WordWrap    = .T.
                .Cancel      = .T.
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption     = "Encerrar"
                .ToolTipText = "[ESC] Sair"
            ENDWITH
        ENDWITH

        *-- GrdLog do legado - grade de resultado. Geometria = dump + 29
        *-- (compensacao PageFrame.Top=-29, regra CLAUDE.md #1/#11); sem
        *-- rescala horizontal (a barra de botoes Left=917 nao alcanca
        *-- Top=197+). ControlSource/Header1.Caption/Width ficam em
        *-- VincularGradeLog (Fase 8 do dialogo) - FONTE UNICA do bind,
        *-- compartilhada com a repintura apos a consulta (Fase 7/8).
        loc_oPag.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPag.grd_4c_Dados
            .Top           = 197
            .Left          = 63
            .Width         = 656
            .Height        = 307
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 17
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        *-- Say10 da pgResultado - "Transacao :" (Left=62/Top=482 no dump;
        *-- FontBold = .T. aqui, ao contrario do Say10 homonimo da pagina de
        *-- filtros). Criado ANTES do campo para o TextBox desenhar por cima
        *-- (regra CLAUDE.md #23).
        loc_oPag.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPag.lbl_4c_Label10
            .Top       = 511
            .Left      = 62
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Transa" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        *-- fwget1 do legado - Transacao do registro corrente da grade.
        *-- Enabled = .F. no dump: o campo eh somente EXIBICAO (o conteudo
        *-- vem do cursor via ControlSource, ligado em VincularGradeLog -
        *-- FONTE UNICA do bind, igual ao bloco final do PROCEDURE
        *-- processamento legado, que liga a grade e o fwget1 juntos).
        *-- DisabledBackColor transcrito do dump para o texto desabilitado
        *-- continuar legivel sobre branco.
        loc_oPag.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oPag.txt_4c_Fwget1
            .Top               = 508
            .Left              = 140
            .Width             = 578
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .MaxLength         = 150
            .Value             = ""
            .Enabled           = .F.
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .TabIndex          = 4
        ENDWITH

        THIS.VincularGradeLog()

        *----------------------------------------------------------------------
        * FASE 7/8 - BINDEVENT do botao de retorno e da grade.
        *
        * cmg_4c_Voltar.Buttons(1) -> BtnVoltarClick: o "btnDados.Click" do
        * cmdBotoes legado NAO fecha a tela (apesar da legenda "Encerrar" e do
        * icone de sair) - ele desliga a pgResultado e volta para a pagina de
        * filtros; o nome do handler segue a ACAO real.
        *
        * grd_4c_Dados "AfterRowColChange" -> GrdDadosAfterRowColChange, que
        * transcreve o "fwget1.Refresh" do GrdLog legado. O handler declara o
        * par_nColIndex do evento (regra CLAUDE.md #3) e NAO filtra coluna:
        * aqui o objetivo eh acompanhar a linha CORRENTE (regra #46).
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Voltar.Buttons(1), "Click", ;
                  THIS, "BtnVoltarClick")

        BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", ;
                  THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *==========================================================================
    * VincularGradeLog - Liga grd_4c_Dados ao cursor de resultado
    * (this_oBusinessObject.this_cCursorLog). Transcrito do bloco final do
    * PROCEDURE processamento legado, que SOBRESCREVE em runtime os headers
    * estaticos do dump do SCX (Column5 e' "Opera??o" ligada a cOpers - a
    * descricao calculada - e nao a Opers crua).
    *
    * ORDEM OBRIGATORIA (regra CLAUDE.md #41/#48): ColumnCount ->
    * RecordSource -> ControlSource -> Width -> Header1.Caption, porque
    * atribuir RecordSource RECALCULA as larguras para o default 90 e
    * zera os captions - vale em TODO site que re-vincula a grade (a
    * repintura da Fase 7/8 chama este MESMO metodo, nao duplica o bind).
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
    * chama metodos do form de FORA da classe).
    *==========================================================================
    PROCEDURE VincularGradeLog()
        LOCAL loc_oGrid, loc_cCursor, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_oBusinessObject.this_cCursorLog

        *-- Column.ControlSource de cursor INEXISTENTE derruba o Init
        *-- (regra CLAUDE.md #41) - o placeholder tem de existir antes.
        IF !USED(loc_cCursor)
            THIS.InicializarCursorLog()
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        TRY
            *-- ColumnCount so eh reatribuido quando DIVERGE de 7: qualquer
            *-- atribuicao recria os objetos Column (regra CLAUDE.md #144).
            IF loc_oGrid.ColumnCount != 7
                loc_oGrid.ColumnCount = 7
            ENDIF

            loc_oGrid.RecordSource = loc_cCursor

            loc_oGrid.Column1.ControlSource = loc_cCursor + ".UsuaRedes"
            loc_oGrid.Column2.ControlSource = loc_cCursor + ".Datars"
            loc_oGrid.Column3.ControlSource = loc_cCursor + ".Horas"
            loc_oGrid.Column4.ControlSource = loc_cCursor + ".Progs"
            loc_oGrid.Column5.ControlSource = loc_cCursor + ".cOpers"
            loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuasis"
            loc_oGrid.Column7.ControlSource = loc_cCursor + ".Parametros"

            *-- Width e Header1.Caption DEPOIS do RecordSource/ControlSource
            WITH loc_oGrid.Column1
                .Width             = 130
                .Movable           = .F.
                .Resizable         = .F.
                .Header1.Caption   = "Usuario Rede"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH loc_oGrid.Column2
                .Width             = 65
                .Movable           = .F.
                .Resizable         = .F.
                .Header1.Caption   = "Data"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH loc_oGrid.Column3
                .Width             = 50
                .Movable           = .F.
                .Resizable         = .F.
                .Header1.Caption   = "Hora"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH loc_oGrid.Column4
                .Width             = 65
                .Movable           = .F.
                .Resizable         = .F.
                .Header1.Caption   = "Programa"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH loc_oGrid.Column5
                .Width             = 95
                .Movable           = .F.
                .Resizable         = .F.
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH loc_oGrid.Column6
                .Width             = 130
                .Movable           = .F.
                .Resizable         = .F.
                .Header1.Caption   = "Usu" + CHR(225) + "rio Sistema"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH loc_oGrid.Column7
                .Width             = 85
                .Movable           = .T.
                .Resizable         = .F.
                .Header1.Caption   = "Parametro"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH

            *-- fwget1 - Transacao do registro corrente. O legado liga este
            *-- campo no MESMO bloco da grade ("ThisForm.PgfPagina.
            *-- PgResultado.fwget1.ControlSource = 'crSigOpLog.Transacaos'"),
            *-- e por isso ele entra aqui: o SQLEXEC de BuscarLog() fecha e
            *-- recria o alias, derrubando TODO bind que aponte para ele.
            *-- PEMSTATUS porque VincularGradeLog tambem roda durante o
            *-- ConfigurarPaginaDados, que cria o campo logo antes.
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Fwget1", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Fwget1.ControlSource = ;
                    loc_cCursor + ".Transacaos"
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Vincular a Grade do Log")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - troca a pagina ativa do PageFrame (equivalente a
    * ThisForm.PgfPagina.ActivePage = N no legado). A ida para a Pagina 2
    * (Resultado) so acontece se a consulta ja tiver devolvido linha
    * (equivalente ao "If Eof() Then Return" do PROCEDURE processamento
    * legado - sem isso o legado nunca chega a mudar de pagina); o toggle
    * de Page2.Enabled transcreve o Enabled=.t./.f. que o legado liga/
    * desliga ao entrar/sair da pagina de resultado (processamento liga,
    * btnDados.Click desliga).
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/TesteAutomatico - o harness
    * chama metodos do form direto de fora da classe).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        DO CASE
            CASE par_nPagina = 2
                IF THIS.this_oBusinessObject.this_nQtdeLog = 0
                    RETURN
                ENDIF
                THIS.pgf_4c_Paginas.Page2.Enabled = .T.
                THIS.pgf_4c_Paginas.ActivePage    = 2
            OTHERWISE
                THIS.pgf_4c_Paginas.Page2.Enabled = .F.
                THIS.pgf_4c_Paginas.ActivePage    = par_nPagina
        ENDCASE
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere os 10 filtros da Page1 para as propriedades de
    * filtro de sigopclgBO, na MESMA ordem do bloco "With ThisForm.PgfPagina.
    * PgDados / lcUserRede = .GetUserRede.Value / ..." do PROCEDURE
    * processamento legado.
    *
    * PROTECTED EXPLICITO: FormBase declara este hook como PROTECTED e o VFP9
    * NAO deixa a subclasse ALARGAR o escopo - omitir o modificador nao
    * tornaria o metodo publico, so esconderia o fato (regra CLAUDE.md #51).
    * Chamado sempre por THIS. (regra #8).
    *
    * As datas passam por ConverterParaData(): o TextBox nasce com .Value = {}
    * (DATE) e as propriedades this_dDtIni/this_dDtFin do BO sao DATE, mas o
    * helper normaliza DATE/DATETIME/CHAR e nunca estoura o erro 11 que
    * TTOD() dispararia com um DATE (regra CLAUDE.md #16).
    *
    * As horas vao CRUAS (HHMM, 4 digitos, como o Format "R" + InputMask
    * "99:99" do dump produzem) - eh BuscarLog() que monta o "HH:MM:00" do
    * legado, igual ao Substr(lcHrIni,1,2)+":"+Substr(lcHrIni,3,2)+":00".
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag, loc_oBO

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oBO  = THIS.this_oBusinessObject

        loc_oBO.this_cUserRede = ALLTRIM(loc_oPag.txt_4c_UserRede.Value)
        loc_oBO.this_dDtIni    = ConverterParaData(loc_oPag.txt_4c_DtIni.Value)
        loc_oBO.this_dDtFin    = ConverterParaData(loc_oPag.txt_4c_DtFin.Value)
        loc_oBO.this_cHrIni    = ALLTRIM(loc_oPag.txt_4c_HrIni.Value)
        loc_oBO.this_cHrFin    = ALLTRIM(loc_oPag.txt_4c_HrFin.Value)
        loc_oBO.this_cPrg      = ALLTRIM(loc_oPag.txt_4c_Prg.Value)
        loc_oBO.this_cOperacao = ALLTRIM(loc_oPag.cbo_4c_GetOperacao.Value)
        loc_oBO.this_cUserSis  = ALLTRIM(loc_oPag.txt_4c_UserSis.Value)
        loc_oBO.this_cParam    = ALLTRIM(loc_oPag.txt_4c_Param.Value)
        loc_oBO.this_cTrans    = ALLTRIM(loc_oPag.txt_4c_Trans.Value)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Sentido inverso de FormParaBO: escreve os 10 filtros das
    * propriedades de sigopclgBO de volta nos controles da Page1.
    *
    * O legado nao tem fluxo que precise disso sozinho (nao ha botao
    * "Limpar" nem reabertura com filtro pre-preenchido) - este metodo
    * existe para completar o par FormParaBO/BOParaForm (convencao do
    * pipeline, presente em todo form) e para LimparCampos, que zera
    * sigopclgBO.this_c*/this_d* e usa este metodo para refletir o estado
    * limpo na tela - mesma convencao de FormSigOpCgr.prg.
    *
    * PROTECTED EXPLICITO: o escopo vem da HERANCA (FormBase declara
    * PROTECTED PROCEDURE BOParaForm) e nao da ausencia do modificador aqui
    * (regra CLAUDE.md #51).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oBO, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oBO  = THIS.this_oBusinessObject

            loc_oPag.txt_4c_UserRede.Value    = loc_oBO.this_cUserRede
            loc_oPag.txt_4c_DtIni.Value       = loc_oBO.this_dDtIni
            loc_oPag.txt_4c_DtFin.Value       = loc_oBO.this_dDtFin
            loc_oPag.txt_4c_HrIni.Value       = loc_oBO.this_cHrIni
            loc_oPag.txt_4c_HrFin.Value       = loc_oBO.this_cHrFin
            loc_oPag.txt_4c_Prg.Value         = loc_oBO.this_cPrg
            loc_oPag.cbo_4c_GetOperacao.Value = loc_oBO.this_cOperacao
            loc_oPag.txt_4c_UserSis.Value     = loc_oBO.this_cUserSis
            loc_oPag.txt_4c_Param.Value       = loc_oBO.this_cParam
            loc_oPag.txt_4c_Trans.Value       = loc_oBO.this_cTrans

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Exibir os Filtros na Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - Estado inicial da tela (filtros vazios, sem resultado
    * de pesquisa), chamado no fim de InicializarForm.
    *
    * O legado nao tem botao de "Limpar" - os campos ja nascem vazios no
    * AddObject - mas centralizar o reset em UM metodo (BO.LimparDados() +
    * BOParaForm) segue a mesma convencao de FormSigOpCgr.prg e deixa um
    * unico lugar preparado caso outro fluxo precise zerar a tela no futuro.
    *
    * Fecha reproduzindo ".GetUserRede.SetFocus" do Init legado - guardado
    * por THIS.Visible porque, na chamada feita de dentro de
    * InicializarForm, o form ainda nao foi exibido (SetFocus em controle
    * invisivel estoura), exatamente como no Init legado, que roda antes do
    * Show().
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO/BOParaForm (regra
    * CLAUDE.md #51).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag

        THIS.this_oBusinessObject.LimparDados()
        THIS.BOParaForm()

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF THIS.Visible AND THIS.pgf_4c_Paginas.ActivePage = 1 AND ;
           PEMSTATUS(loc_oPag, "txt_4c_UserRede", 5) AND ;
           loc_oPag.txt_4c_UserRede.Enabled
            loc_oPag.txt_4c_UserRede.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * DesvincularGradeLog - Solta grd_4c_Dados e txt_4c_Fwget1 do cursor de
    * resultado ANTES da consulta. Transcricao da PRIMEIRA linha do PROCEDURE
    * processamento legado ("GrdLog.RecordSource = ''").
    *
    * Nao eh cosmetico: BuscarLog() faz USE IN + SQLEXEC sobre o MESMO alias,
    * e SQLEXEC sobre o alias ligado a um Grid ZERA o ColumnCount - a grade
    * vira um retangulo branco sem cabecalho e sem coluna, sem erro e sem log.
    * Soltando antes e re-vinculando depois (VincularGradeLog), a grade
    * sobrevive a troca de cursor.
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
    * chama metodos do form de FORA da classe).
    *==========================================================================
    PROCEDURE DesvincularGradeLog()
        LOCAL loc_oPag, loc_oGrid, loc_nCol

        loc_oPag  = THIS.pgf_4c_Paginas.Page2
        loc_oGrid = loc_oPag.grd_4c_Dados

        *-- O fwget1 sai primeiro: ControlSource apontando para alias fechado
        *-- nao sobrevive ao USE IN que BuscarLog() faz em seguida.
        IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
            loc_oPag.txt_4c_Fwget1.ControlSource = ""
            loc_oPag.txt_4c_Fwget1.Value         = ""
        ENDIF

        FOR loc_nCol = 1 TO loc_oGrid.ColumnCount
            loc_oGrid.Columns(loc_nCol).ControlSource = ""
        ENDFOR

        loc_oGrid.RecordSource = ""
    ENDPROC

    *==========================================================================
    * RepintarGradeLog - Posiciona no inicio do cursor e repinta a grade.
    *
    * Popular o cursor NAO repinta a grade sozinho, e Refresh em pagina
    * OCULTA nao pinta (regra CLAUDE.md #21): por isso este metodo eh
    * chamado DEPOIS de AlternarPagina(2), ou seja depois de a Page2 ja
    * estar ativa, e eh o unico lugar que faz GO TOP + Refresh - FONTE
    * UNICA da repintura, igual VincularGradeLog eh a do bind.
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/#51).
    *==========================================================================
    PROCEDURE RepintarGradeLog()
        LOCAL loc_cCursor, loc_oPag

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLog
        loc_oPag    = THIS.pgf_4c_Paginas.Page2

        IF USED(loc_cCursor)
            IF RECCOUNT(loc_cCursor) > 0
                GO TOP IN (loc_cCursor)
            ENDIF
        ENDIF

        loc_oPag.grd_4c_Dados.Refresh()

        *-- O fwget1 acompanha a linha corrente da grade (ControlSource no
        *-- cursor): depois de reposicionar, ele tambem precisa repintar.
        IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
            loc_oPag.txt_4c_Fwget1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Botao "Processar" (Buttons(1) do cmg_4c_Acoes,
    * Command1/btnProcessar do cmdProcessar legado).
    *
    * Transcricao do Click legado, que eh SO a confirmacao mais a chamada do
    * PROCEDURE processamento:
    *
    *   If (MessageBox('Confirma o Processamento?', 4+32+256, ...) = 6)
    *       ThisForm.Processamento      && -> THIS.CarregarLista()
    *   EndIf
    *
    * O 4+32+256 do legado eh Sim/Nao + icone de interrogacao + 2o botao
    * como default, ou seja o MsgConfirma() do projeto (que devolve LOGICO -
    * regra CLAUDE.md #7, NUNCA comparar com 6). Recusando a confirmacao, o
    * legado nao chama Processamento e a tela CONTINUA como estava.
    *
    * O corpo do processamento legado mora em CarregarLista(), que eh o FUNIL
    * unico de carga da grade (regra CLAUDE.md #21/#46): o Click eh so o
    * gatilho, para que qualquer outro caminho que precise repopular a grade
    * use o MESMO metodo e nao uma segunda copia da sequencia.
    *
    * PUBLIC de proposito: eh delegate de BINDEVENT (regra CLAUDE.md #3) e
    * tambem alvo do harness da etapa 06b.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF MsgConfirma("Confirma o Processamento?", ;
                       "Confirma" + CHR(231) + CHR(227) + "o!!!")
            loc_lResultado = THIS.CarregarLista()
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL unico de carga da grade de resultado. Transcricao do
    * "PROCEDURE processamento" legado, da 1a a ultima linha.
    *
    * Metodo UNICO de proposito (regra CLAUDE.md #21/#46): popular cursor NAO
    * repinta a grade sozinho, e a repintura tem de acontecer DEPOIS de a
    * pagina de resultado estar visivel. Deixar essa sequencia inline no
    * handler do botao obrigaria a duplica-la em todo caminho futuro que
    * precise recarregar - e e' exatamente a duplicacao que faz uma das copias
    * esquecer o Refresh e a grade aparecer vazia com o cursor cheio.
    *
    * As duas recusas do processamento legado ficam no BO, que devolve a
    * mensagem pronta em this_cMensagemErro, e cada uma mantem o ICONE do
    * legado:
    *   - nenhum filtro preenchido -> MessageBox(...,16,...) = MsgErro
    *     (BuscarLog devolve .F.)
    *   - consulta sem linha        -> MessageBox(...,64,...) = MsgInfo
    *     (BuscarLog devolve .T. com this_nQtdeLog = 0; o legado faz
    *      "If Eof() / MessageBox / Return" e NAO muda de pagina)
    *
    * Ordem obrigatoria no caminho de sucesso: desvincular -> consultar ->
    * re-vincular (o SQLEXEC recriou o alias) -> trocar de pagina ->
    * repintar (Refresh em pagina oculta nao pinta - regra #21).
    *
    * NUNCA ha RETURN dentro do TRY/CATCH (regra CLAUDE.md #1): o early-exit
    * eh a flag loc_lProsseguir e o RETURN unico fica DEPOIS do ENDTRY.
    *
    * PUBLIC de proposito: alvo do harness da etapa 06b, que chama os metodos
    * de carga de FORA da classe (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lProsseguir, loc_oBO, loc_oErro

        loc_lProsseguir = .T.
        loc_oBO         = THIS.this_oBusinessObject

        TRY
            *-- "GrdLog.RecordSource = ''" - 1a linha do processamento legado
            THIS.DesvincularGradeLog()

            THIS.FormParaBO()

            IF !loc_oBO.BuscarLog()
                *-- Nenhum filtro preenchido ou falha de SQL (icone 16 no legado)
                IF !EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro))
                    MsgErro(loc_oBO.this_cMensagemErro, "Consulta do Log")
                ENDIF
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF loc_oBO.this_nQtdeLog = 0
                    *-- "If Eof() / MessageBox(...,64,...) / Return" do legado
                    MsgInfo(IIF(EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro)), ;
                            "Nenhum Registro Encontrado para Sele" + CHR(231) + ;
                            CHR(227) + "o", loc_oBO.this_cMensagemErro), ;
                            "Consulta do Log")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Bloco final do processamento legado: re-liga a grade e o
                *-- fwget1 ao cursor novo, habilita a pgResultado e vai para
                *-- ela (AlternarPagina) - e so depois repinta.
                THIS.VincularGradeLog()
                THIS.AlternarPagina(2)
                THIS.RepintarGradeLog()
            ELSE
                *-- Recusado: o legado deixa a grade solta (o "RecordSource =
                *-- ''" seguido de Return). Re-vincular ao cursor evita grade
                *-- orfa se o usuario voltar para a pagina de resultado.
                THIS.VincularGradeLog()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Processar a Consulta do Log")
            loc_lProsseguir = .F.
        ENDTRY

        RETURN loc_lProsseguir
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Botao "Encerrar" (Buttons(2) do cmg_4c_Acoes,
    * Command2/btnSair do cmdProcessar legado).
    *
    * Transcricao literal do "PROCEDURE btnSair.Click / ThisForm.Release".
    * A liberacao do poDataMgr que o PROCEDURE Release legado faz nao tem
    * equivalente aqui: a conexao eh a global gnConnHandle, do config.prg, e
    * nao um objeto por tela - o Destroy() do form fecha os cursores proprios
    * e delega o resto a FormBase via DODEFAULT().
    *
    * PUBLIC de proposito: delegate de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnVoltarClick - Unico botao do cmg_4c_Voltar (Command1/btnDados do
    * cmdBotoes legado, na pgResultado).
    *
    * O nome segue a ACAO e nao a legenda: o botao tem Caption "Encerrar" e
    * icone de sair, mas o Click legado NAO fecha a tela -
    *
    *   ThisForm.PgfPagina.PgResultado.Enabled = .f.
    *   ThisForm.PgfPagina.ActivePage = 1
    *
    * - ele volta para a pagina de filtros. As duas linhas sao exatamente o
    * ramo OTHERWISE de AlternarPagina(), que eh o FUNIL dessa troca.
    *
    * PUBLIC de proposito: delegate de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnVoltarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - AfterRowColChange do GrdLog legado:
    *
    *   LPARAMETERS nColIndex
    *   ThisForm.PgfPagina.PgResultado.fwget1.Refresh
    *
    * O par_nColIndex EH declarado mesmo sem ser usado: handler de
    * AfterRowColChange ligado por BINDEVENT tem de declarar o parametro do
    * evento (regra CLAUDE.md #3).
    *
    * SEM filtro de coluna, de proposito: este eh justamente o uso CERTO de
    * AfterRowColChange - acompanhar a linha CORRENTE (regra CLAUDE.md #46;
    * validacao de celula iria no Valid do TextBox da Column, e esta grade
    * eh ReadOnly). Alem do Refresh do legado, sincroniza o registro
    * corrente do BO com a linha da grade, que eh o que CarregarDoCursor()
    * existe para fazer.
    *
    * PUBLIC de proposito: delegate de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursor, loc_oPag

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLog
        loc_oPag    = THIS.pgf_4c_Paginas.Page2

        IF USED(loc_cCursor)
            IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
                THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
            ENDIF
        ENDIF

        *-- "fwget1.Refresh" do legado - a Transacao da linha corrente
        IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
            loc_oPag.txt_4c_Fwget1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarPrgLostFocus - funil do lookup de Programa.
    *
    * Transcricao do PROCEDURE Valid do GetPrg legado:
    *   IF not IsEmpty(This.value)
    *       ThisForm.PoDatamgr.SqlExecute([Select Distinct Programas
    *                   From SigCdPrg Order By Programas],"crSigCdPrg")
    *       SELECT crSigCdPrg / LOCATE FOR Programas = This.Value
    *       If EOF()
    *           xBrow = CreateObject('fwBuscaInt','crSigCdPrg','Programas',
    *                                This.Value,'Progamas',.t.)
    *           xBrow.mAddColuna('Programas','','Programa',.t.) / xBrow.Show
    *       ENDIF
    *       IF LASTKEY()<>27 / This.value = crSigCdPrg.Programas / ENDIF
    *   ENDIF
    *
    * fwBuscaInt = browse sobre cursor LOCAL (ja populado), diferente do
    * fwBuscaExt do GetUserSis, que consulta o SQL Server - por isso aqui o
    * cursor eh populado ANTES (sigopclgBO.BuscarProgramas) e entregue ao
    * FormBuscaAuxiliar pela API DefinirCursor, nao pelo Init com parametros.
    *
    * Wrapper fino com a guarda de reentrancia; o corpo fica no *Exec para
    * a flag ser liberada mesmo nos RETURN antecipados dele (regra CLAUDE.md
    * #47 - set/clear no wrapper, nunca em volta de corpo com RETURN).
    *
    * PUBLIC (sem modificador) porque eh delegate de BINDEVENT: metodo
    * PROTECTED falha em silencio no bind (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarPrgLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.ValidarPrgLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * ValidarPrgLostFocusExec - corpo do lookup de Programa
    *==========================================================================
    PROTECTED PROCEDURE ValidarPrgLostFocusExec()
        LOCAL loc_oPag, loc_cValor, loc_cCursor

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Prg.Value)

        *-- "If not IsEmpty(This.value)" do legado: campo vazio nao valida
        *-- nada e nao abre dialogo nenhum.
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgramas

        IF !THIS.this_oBusinessObject.BuscarProgramas(loc_cCursor)
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Programas")
            ENDIF
            RETURN
        ENDIF

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        *-- "SELECT crSigCdPrg / LOCATE FOR Programas = This.Value" do
        *-- legado. Comparacao com == sobre ALLTRIM/UPPER: o SET EXACT ON
        *-- global (config.prg) faz o "=" exigir a chave inteira com o
        *-- padding do char(15), e ai o LOCATE nunca casaria.
        SELECT (loc_cCursor)
        LOCATE FOR UPPER(ALLTRIM(Programas)) == UPPER(loc_cValor)

        IF FOUND()
            *-- "This.value = crSigCdPrg.Programas" do legado
            loc_oPag.txt_4c_Prg.Value = ALLTRIM(EVALUATE(loc_cCursor + ".Programas"))
        ELSE
            *-- "If EOF() ... xBrow.Show" do legado
            THIS.ExibirPickerPrg()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExibirPickerPrg - browse de Programas sobre o cursor LOCAL ja populado
    * (fwBuscaInt do legado). NAO exibe aviso e NAO apaga o codigo digitado
    * quando o universo esta vazio: universo vazio nao eh erro, e apagar o
    * campo impediria o usuario de preencher (regra CLAUDE.md #50).
    *==========================================================================
    PROTECTED PROCEDURE ExibirPickerPrg()
        LOCAL loc_oPag, loc_cCursor, loc_oBusca, loc_cCodigo

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgramas

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        IF RECCOUNT(loc_cCursor) = 0
            RETURN
        ENDIF

        *-- O LOCATE que falhou deixou o ponteiro em EOF - o browse tem de
        *-- comecar da primeira linha.
        SELECT (loc_cCursor)
        GO TOP

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        *-- Titulo "Progamas" transcrito LITERALMENTE do legado (o 5o
        *-- argumento do CreateObject('fwBuscaInt',...) tem essa grafia no
        *-- dump) - PILAR 1: o usuario nao deve perceber diferenca.
        loc_oBusca.DefinirCursor(loc_cCursor, "Programas", "Programas", "Progamas")

        *-- SigCdPrg.Programas eh coluna UNICA - eh ao mesmo tempo codigo e
        *-- descricao (mesma familia de SigCdOpe.Dopes). DefinirCursor sempre
        *-- adiciona o PAR codigo+descricao, o que aqui exibiria a mesma
        *-- coluna duas vezes; zerar o contador e re-adicionar deixa UMA
        *-- coluna, com o header do legado ("Programa", singular).
        loc_oBusca.this_nColunas = 0
        loc_oBusca.mAddColuna("Programas", "", "Programa")

        *-- Mostrar() devolve .T. so quando houve selecao de fato; em ESC/
        *-- Cancelar o codigo digitado pelo usuario eh PRESERVADO, igual ao
        *-- "If LastKey() <> 27" do legado.
        IF loc_oBusca.Mostrar()
            loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
            IF !EMPTY(loc_cCodigo)
                loc_oPag.txt_4c_Prg.Value = loc_cCodigo
            ENDIF
        ENDIF

        loc_oBusca.Release()
    ENDPROC

    *==========================================================================
    * PrgKeyPress - atalho F4 (115) do campo Programa. TESTA a tecla antes de
    * abrir qualquer dialogo (regra CLAUDE.md #47) e declara os dois
    * parametros do evento (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE PrgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupPrg()
        ENDIF
    ENDPROC

    *==========================================================================
    * PrgDblClick - duplo clique no campo Programa abre o browse
    *==========================================================================
    PROCEDURE PrgDblClick()
        THIS.AbrirLookupPrg()
    ENDPROC

    *==========================================================================
    * AbrirLookupPrg - entrada direta no browse de Programas (F4/DblClick):
    * abre a lista independente do que esta digitado, sem o LOCATE do
    * LostFocus.
    *
    * Guarda SAVE/RESTORE em vez de set/clear (regra CLAUDE.md #47): este
    * metodo tambem pode ser alcancado com o funil do LostFocus ja em curso,
    * e um clear simples liberaria a flag cedo demais.
    *==========================================================================
    PROCEDURE AbrirLookupPrg()
        LOCAL loc_lEmLookupAnt

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupPrgExec()
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *==========================================================================
    * AbrirLookupPrgExec - corpo de AbrirLookupPrg
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupPrgExec()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgramas

        IF !THIS.this_oBusinessObject.BuscarProgramas(loc_cCursor)
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Programas")
            ENDIF
            RETURN
        ENDIF

        THIS.ExibirPickerPrg()
    ENDPROC

    *==========================================================================
    * ValidarUserSisLostFocus - funil do lookup de Usuario do Sistema.
    *
    * Transcricao do PROCEDURE Valid do GetUserSis legado:
    *   If not IsEmpty(This.value)
    *       xBrox = CreateObject('fwBuscaExt',Thisform.poDatamgr.pnIdconn,
    *                            'SigCdUsu','crSigCdUsu','Usuarios',
    *                            This.Value,'Sele??o',.t.,'Usuarios')
    *       If Not xBrox.plAchouRegistro
    *           xBrox.mAddColuna('Usuarios','','Usu?rios',.t.) / xBrox.Show()
    *       EndIf
    *       If lastkey()<>27
    *           This.value = evaluate("crSigCdUsu.Usuarios") / This.Refresh
    *       endif
    *   endif
    *
    * fwBuscaExt consulta o SQL Server por conta propria, exatamente como o
    * Init com parametros do FormBuscaAuxiliar - por isso aqui NAO ha
    * SQLEXEC nem LOCATE no form (duplicar a checagem de existencia so cria
    * um caminho para divergir - regra CLAUDE.md #37).
    *
    * PUBLIC: delegate de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarUserSisLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.ValidarUserSisLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * ValidarUserSisLostFocusExec - corpo do lookup de Usuario do Sistema
    *==========================================================================
    PROTECTED PROCEDURE ValidarUserSisLostFocusExec()
        LOCAL loc_oPag, loc_cValor

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_UserSis.Value)

        *-- "If not IsEmpty(This.value)" do legado
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        THIS.ExibirPickerUserSis(loc_cValor)
    ENDPROC

    *==========================================================================
    * ExibirPickerUserSis - lookup de SigCdUsu.Usuarios (fwBuscaExt legado)
    *==========================================================================
    PROTECTED PROCEDURE ExibirPickerUserSis(par_cValor)
        LOCAL loc_oPag, loc_cCursor, loc_cValor, loc_oBusca, loc_cCodigo

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = "cursor_4c_BuscaUsuario"
        loc_cValor  = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")

        *-- 1o argumento = HANDLE da conexao (regra CLAUDE.md #36): passar a
        *-- tabela ali desloca TODOS os argumentos e o picker abre vazio sem
        *-- erro nenhum. O 9o argumento do fwBuscaExt legado ('Usuarios') NAO
        *-- eh transcrito: no FormBuscaAuxiliar aquela posicao eh um filtro
        *-- WHERE adicional, e "Usuarios" ali geraria SQL invalido.
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", loc_cCursor, "Usuarios", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        *-- Contrato do FormBuscaAuxiliar (regra CLAUDE.md #37): o Init ja
        *-- tentou o match EXATO; achando 1 registro, o valor esta resolvido
        *-- e o dialogo NAO deve aparecer - equivale ao
        *-- "If Not xBrox.plAchouRegistro" do legado.
        IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rios")
            loc_oBusca.Show()
        ENDIF

        *-- "If lastkey()<>27 / This.value = evaluate('crSigCdUsu.Usuarios')"
        *-- do legado: atribui SO sob a guarda de selecao. Atribuir fora dela
        *-- ZERARIA o codigo que o usuario digitou (regra CLAUDE.md #37/#50).
        IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            loc_cCodigo = ALLTRIM(EVALUATE(loc_cCursor + ".Usuarios"))
            IF !EMPTY(loc_cCodigo)
                loc_oPag.txt_4c_UserSis.Value = loc_cCodigo
            ENDIF
        ENDIF

        loc_oBusca.Release()

        *-- Cursor do lookup eh descartavel: fechado aqui para a proxima
        *-- consulta nascer limpa (o alias nao alimenta grade nenhuma).
        IF USED(loc_cCursor)
            IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                TABLEREVERT(.T., loc_cCursor)
            ENDIF
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    * UserSisKeyPress - atalho F4 (115) do campo Usuario do Sistema
    *==========================================================================
    PROCEDURE UserSisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupUserSis()
        ENDIF
    ENDPROC

    *==========================================================================
    * UserSisDblClick - duplo clique no campo Usuario do Sistema
    *==========================================================================
    PROCEDURE UserSisDblClick()
        THIS.AbrirLookupUserSis()
    ENDPROC

    *==========================================================================
    * AbrirLookupUserSis - entrada direta no lookup de Usuario do Sistema
    * (F4/DblClick). Guarda SAVE/RESTORE (regra CLAUDE.md #47).
    *==========================================================================
    PROCEDURE AbrirLookupUserSis()
        LOCAL loc_lEmLookupAnt

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupUserSisExec()
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *==========================================================================
    * AbrirLookupUserSisExec - corpo de AbrirLookupUserSis
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupUserSisExec()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        THIS.ExibirPickerUserSis(ALLTRIM(loc_oPag.txt_4c_UserSis.Value))
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F.
    * por padrao; percorre Pages (PageFrame) e Controls (Container)
    * recursivamente tornando tudo visivel apos a montagem.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF

            IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                FOR loc_nP = 1 TO loc_oObjeto.PageCount
                    THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oObjeto)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - cursor_4c_Log (Fase 4), cursor_4c_Programas e
    * cursor_4c_BuscaUsuario (Fase 6, lookups de Programa e de Usuario do
    * Sistema) nao precisam de USE IN explicito: DataSession=2
    * eh sessao de dados PRIVADA do form, e o VFP9 fecha todos os cursores
    * dela junto com a sessao, ao destruir o form. FormBase.Destroy() ja
    * zera this_oBusinessObject e restaura o menu principal.
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

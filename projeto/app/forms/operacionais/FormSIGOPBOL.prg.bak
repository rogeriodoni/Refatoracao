*==============================================================================
* FormSIGOPBOL.prg - Selecao da impressora de boleto (dialogo modal)
* Form OPERACIONAL FLAT (sem PageFrame) - dialogo parametrizado que recebe
* dados do form chamador, exibe a lista de impressoras de boleto configuradas
* na estacao e repassa tudo para a rotina legada de impressao (SigBlBol).
* Herda de: FormBase
*
* Legado (SIGOPBOL.SCX): BaseClass = form (generico), DataSession = 2,
* WindowType = 1 (modal), ControlBox = .F., TitleBar = 0, 800x197. O Init
* legado recebe LParameters poForm, pnTpBol, pCursor - poForm eh a referencia
* ao form chamador, usada SO para "Set DataSession to poForm.DataSessionId"
* (compartilhar a datasession do chamador). As demais propriedades do dialogo
* (vcTitEnvelope/vcEmp/vcDope/vnNum/vnDev/vnVias/vnQBols) NAO chegam via
* LPARAMETERS - nascem com default .F. no SCX e sao atribuidas pelo form
* chamador DIRETO (ThisForm.vcEmp = ..., etc.) depois do CREATEOBJECT e antes
* do Show(), padrao classico de "dialogo com propriedades publicas".
*
* Nesta migracao, poForm NAO eh reproduzido: seu unico uso no legado era
* herdar a DataSession do chamador para dar ao Cmd_Imprimir.Click acesso ao
* cursor pCursor por alias compartilhado (uso que, alias, esta COMENTADO no
* proprio Click legado - *!* Select (lcCursor) / *!* Replace cImps With
* lcImp - o codigo ATIVO so LE as propriedades e repassa para SigBlBol). O
* nome do cursor/tabela a imprimir (pCursor) continua chegando como STRING,
* exatamente como no legado - no eh preciso herdar DataSession para isso.
*
* Historico de fases:
*   Fase 1/2: SIGOPBOLBO.prg (propriedades + metodos de negocio:
*             DefinirTipoBoleto, ObterTituloPorTipoBoleto,
*             CarregarImpressorasConfiguradas, ObterImpressorasDisponiveis,
*             ExecutarImpressao). BO somente-leitura (nao sobrescreve
*             Inserir/Atualizar/ExecutarExclusao - nao ha tabela propria).
*   Fase 3:   FormSIGOPBOL.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
*             lbl_4c_LblTitulo, Destroy). Form FLAT: o legado nao tem
*             PageFrame nem Page nenhuma - nenhum pgf_4c_* eh criado neste
*             form. Opt_Impressora/Lbl_Impressora/Lbl_Erro/btnReport ficam
*             para as proximas fases (sao campos/eventos, nao estrutura).
*   Fase 4:   ConfigurarControles() (Opt_Impressora/Lbl_Impressora/Lbl_Erro/
*             btnReport), AplicarVisibilidadeImpressoras(), AjustarAlturaForm()
*             e CmdImprimirClick(). ATENCAO: o template generico de Fase 4
*             do orquestrador ("Grid e botoes CRUD na Page1") NAO se aplica
*             a este form - SIGOPBOL eh um dialogo FLAT de selecao de
*             impressora (ver SIGOPBOL_form_codigo_fonte.txt): nao ha Page1,
*             nao ha grid, nao ha Incluir/Alterar/Excluir/Buscar no legado.
*             Fabricar esses botoes violaria o PILAR 1 (inventar UX que o
*             legado nao tem). Esta fase, em vez disso, completa os
*             controles REAIS que faltavam (Opt_Impressora/Lbl_Erro/
*             btnReport) e a logica de negocio do PROCEDURE Init/
*             Cmd_Imprimir.Click legados, usando os metodos do BO criados
*             nas Fases 1/2 (CarregarImpressorasConfiguradas,
*             ObterImpressorasDisponiveis, ExecutarImpressao).
*   Fase 5:   NAO ha "Page2 - campos" a adicionar neste form. O inventario do
*             SCX legado tem 8 objetos (SIGOPBOL, Opt_Impressora,
*             Lbl_Impressora, Lbl_Erro, cntSombra, lblSombra, lblTitulo,
*             btnReport) e os 8 ja existem - o form eh FLAT, sem PageFrame,
*             sem Page2 e sem nenhum campo de dados a migrar. Fabricar um
*             ConfigurarPaginaDados()/Page2 violaria o PILAR 1 (inventar UX
*             que o legado nao tem). Esta fase, em vez disso, AUDITOU o que
*             as fases anteriores perderam ou inventaram, propriedade a
*             propriedade, contra o dump do SCX:
*               (a) TabIndex NUNCA transcrito. O SCX declara Lbl_Impressora=1,
*                   Opt_Impressora=2, Option1=1, Lbl_Erro=1, btnReport=4.
*                   Transcritos SO onde o valor gruda e significa algo: os
*                   dois controles FOCALIZAVEIS (Opt_Impressora=2,
*                   obj_4c_BtnReport=4) e Option1=1 dentro do grupo.
*                   HONESTIDADE SOBRE O GANHO: isto eh fidelidade ao dump, NAO
*                   conserto de comportamento. Medido no VFP9 (2026-10-17), a
*                   navegacao por Tab eh IDENTICA com e sem a transcricao,
*                   porque os unicos dois tab-stops do form sao Opt_Impressora
*                   e btnReport e em ambos os casos Opt vem antes (2<4 na
*                   transcricao, 4<5 na ordem de criacao da fase 4).
*               (b) Option1.Style = 0 nao transcrito.
*               (c) Closable/MaxButton/MinButton = .F. INVENTADOS pela fase
*                   anterior (o SCX nao os declara) - removidos, ver o bloco
*                   de propriedades visuais. Medido no VFP9.
*               (d) lblSombra/lblTitulo com o Caption literal "Cadastro de
*                   Testes" -> THIS.Caption (regra #11).
*             Conferido e CORRETO (nao mexer): Load legado (=fConfigGeral())
*             nao portado de proposito - utils/fconfiggeral.prg eh um no-op
*             documentado que existe SO para o p-code dos VCX legado, e o
*             proprio arquivo determina que codigo NOSSO nunca o chame (o que
*             fConfigGeral fazia ja acontece em config.prg/main.prg);
*             Lbl_Erro tem WordWrap = .T. e NAO tem AutoSize, que eh
*             exatamente o exigido pela regra #23; .Picture dos dois sites
*             aponta para arquivo existente (regra #25).
*   Fase 6:   NAO ha "campos restantes" nem "lookups" a acrescentar neste
*             form. Os 8 objetos do inventario do SCX legado (SIGOPBOL,
*             Opt_Impressora, Lbl_Impressora, Lbl_Erro, cntSombra,
*             lblSombra, lblTitulo, btnReport) ja foram TODOS migrados nas
*             Fases 3/4/5 (ConfigurarPageFrame + ConfigurarControles), com
*             BINDEVENT do unico botao (CmdImprimirClick) ja ligado. Nao ha
*             campo de dados a migrar (o form nao tem Page2/area de dados -
*             eh um dialogo FLAT) e nao ha NENHUM lookup no legado: a busca
*             em SIGOPBOL_form_codigo_fonte.txt por "fwbuscaext", "fwBuscaSel",
*             "sigacess(" e "CreateObject(" nao retorna NENHUMA ocorrencia
*             (confirmado em 2026-10-17) - o unico CreateObject do form eh o
*             que o PROPRIO form chamador faz para instanciar este dialogo
*             (CREATEOBJECT("FormSIGOPBOL", ...)), nao um lookup interno.
*             Fabricar um campo ou lookup aqui violaria o PILAR 1 (inventar
*             UX que o legado nao tem) e a regra de nao criar stub
*             disfarcado. Mesma familia do Erro178 (form OPERACIONAL cujo
*             legado nao tem "campos soltos" nem lookup para a Fase 6).
*   Fase 7:   NAO ha BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*             BtnExcluirClick a adicionar neste form. O template generico da
*             Fase 7 ("eventos principais dos botoes CRUD") pressupoe um
*             frmcadastro com barra Incluir/Alterar/Visualizar/Excluir, que
*             este legado NAO tem (ver Fase 4): SIGOPBOL eh um dialogo de
*             selecao de impressora com UM UNICO botao
*             (btnReport/Cmd_Imprimir, CommandGroup com ButtonCount=1 no
*             dump - layout.json), ja migrado como CmdImprimirClick() na
*             Fase 4 (linha ~560), com o codigo ativo do Cmd_Imprimir.Click
*             legado transcrito (grava this_cImpressoraSelecionada +
*             propriedades publicas no BO + ExecutarImpressao() + Release).
*             Inventar os 4 nomes CRUD fabricaria UX que o legado nao tem
*             (PILAR 1) e, pior, criaria metodo SEM contrapartida no SCX -
*             stub disfarcado proibido. A superficie de botao que o dump
*             PROVA existir (1 CommandGroup com ButtonCount=1; o
*             Opt_Impressora eh OptionGroup/radio, nao conta como botao de
*             acao) ja tem handler correspondente nomeado pelo prefixo
*             canonico Cmd*Click - mesma familia do Erro178/SIGMVCTH
*             (visualizador de um botao so) e de Formsigprdft (handler
*             renomeado para o prefixo Cmd/Btn, nao para o nome do objeto
*             legado).
*   Fase 8:   NAO ha BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
*             BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
*             LimparCampos/CarregarLista/AjustarBotoesPorModo a adicionar
*             neste form. O template generico de Fase 8 ("consolidacao final
*             de form CRUD") pressupoe Page1=Lista/Page2=Dados com registro
*             proprio para salvar/cancelar/buscar - este dialogo FLAT (ver
*             Fases 3/4/6/7) nao tem nenhum dos dois, nao edita registro
*             algum (BO somente-leitura, sem tabela propria - ver cabecalho
*             de SIGOPBOLBO.prg) e o UNICO botao (Encerrar/Cmd_Imprimir) ja
*             foi migrado como CmdImprimirClick() na Fase 4: ele sozinho le
*             Opt_Impressora.Value, sincroniza as 7 propriedades publicas no
*             BO, chama ExecutarImpressao() e da Release() - exatamente o
*             PROCEDURE Cmd_Imprimir.Click legado (codigo ATIVO, nao o bloco
*             comentado). Fabricar os 9 metodos do template criaria 9 stubs
*             SEM contrapartida no SCX (proibido) e violaria o PILAR 1.
*             INTEGRACAO (a parte real desta fase): o form chega completo
*             desde a Fase 7, mas FICOU SEM NENHUM CALLER ate agora. O
*             legado SIGOPBOL nunca tem entrada de menu propria - e' um
*             dialogo invocado SO programaticamente por quem imprime boleto
*             (confirmado: nenhuma ocorrencia de "SIGOPBOL" em origem/*.SCX/
*             *.SCT fora de origem/SigPrSdd.SCT). Fabricar um item em
*             popMovimentos (o padrao generico "Adicionar item no menu")
*             inventaria UX que o legado nao tem E abriria o dialogo com
*             this_nTpBol=0/this_cCursor="" (titulo errado, cursor nenhum) -
*             pior que nao ter entrada nenhuma. O UNICO caller no codigo
*             migrado inteiro, FormSigPrSdd.BtnBoletoClick (botao "Boleto"),
*             estava com o bug inverso: CREATEOBJECT("FormSigOpBol") SEM
*             nenhum parametro, quando o legado (Fwbtng1.Click, SIGPRSDD.SCX,
*             PROCEDURE inteira numa linha) faz "Do Form SigOpBol With
*             ThisForm,15" - o 15 (pnTpBol) e' obrigatorio e estava sendo
*             descartado silenciosamente (IIF do Init absorve a ausencia sem
*             erro, mas o Caption sai errado). Corrigido para
*             CREATEOBJECT("FormSIGOPBOL", 15) em FormSigPrSdd.prg.
*==============================================================================
DEFINE CLASS FormSIGOPBOL AS FormBase

    *-- Parametros de entrada recebidos no Init (equivalem a pnTpBol/pCursor
    *-- do PROCEDURE Init legado: LParameters poForm, pnTpBol, pCursor)
    this_nTpBol = 0
    this_cCursor = ""

    *-- Propriedades publicas, setadas pelo FORM CHAMADOR apos o
    *-- CREATEOBJECT e antes do Show() - mirror exato das custom properties
    *-- do legado (vcTitEnvelope/vcEmp/vcDope/vnNum/vnDev/vnVias/vnQBols),
    *-- que no SCX nascem com default .F. e sao atribuidas em runtime pelo
    *-- chamador (nao chegam via LPARAMETERS do Init).
    this_cTitEnvelope = ""
    this_cEmp = ""
    this_cDope = ""
    this_nNum = 0
    this_nDev = 0
    this_nVias = 0
    this_nQBols = 0

    *-- Resultado da resolucao de impressoras (ObterImpressorasDisponiveis),
    *-- guardado para uso em AplicarVisibilidadeImpressoras() - que roda
    *-- DEPOIS de TornarControlesVisiveis() e por isso nao pode recalcular
    *-- nada que dependa de Visible ter sido forcado para .T. nesse meio tempo
    this_cErroImpressoras = ""
    this_nImpressorasDisponiveis = 0

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPBOL)
    Width        = 800
    Height       = 197
    DataSession  = 2
    ShowWindow = 1
    BorderStyle  = 2
    AutoCenter   = .T.
    Caption      = ""
    ControlBox   = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    *-- Closable/MaxButton/MinButton NAO sao declarados: o SCX legado tambem
    *-- nao os declara, e medido no VFP9 (2026-10-17) TitleBar = 0 +
    *-- ControlBox = .F. NAO os forca para .F. - os tres continuam .T. Fixa-los
    *-- em .F. (como a fase anterior fazia) TIRA o Alt+F4, que no legado eh a
    *-- UNICA forma de abortar: o unico botao do dialogo (Cmd_Imprimir/
    *-- "Encerrar") sempre IMPRIME antes de dar Release, nao ha Cancelar.

    *--------------------------------------------------------------------------
    * Init - Recebe o tipo de boleto e o cursor/tabela a imprimir (equivale
    * ao LPARAMETERS pnTpBol, pCursor do PROCEDURE Init legado - poForm nao
    * eh reproduzido, ver cabecalho). Cria o Business Object, resolve o
    * titulo da janela (Do Case legado) e so depois inicializa a parte
    * visual (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nTpBol, par_cCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Iif(Type('pnTpBol') = 'N', pnTpBol, 0) - mesma guarda do legado
            THIS.this_nTpBol = IIF(VARTYPE(par_nTpBol) = "N", par_nTpBol, 0)
            THIS.this_cCursor = IIF(VARTYPE(par_cCursor) = "C", par_cCursor, "")

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPBOLBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SIGOPBOLBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSIGOPBOL.Init")
            ELSE
                THIS.this_oBusinessObject.DefinirTipoBoleto(THIS.this_nTpBol)
                THIS.this_oBusinessObject.this_cCursor = THIS.this_cCursor

                *-- Do Case legado que define o Caption conforme o tipo de boleto
                THIS.Caption = THIS.this_oBusinessObject.ObterTituloPorTipoBoleto(THIS.this_nTpBol)

                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Monta o cabecalho (cnt_4c_Sombra - Fase 3)
            THIS.ConfigurarPageFrame()

            *-- Monta Opt_Impressora/Lbl_Impressora/Lbl_Erro/btnReport e resolve
            *-- a lista de impressoras disponiveis (Fase 4)
            THIS.ConfigurarControles()

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            *-- Troca final (lista de impressoras OU mensagem de erro) tem que
            *-- vir DEPOIS de TornarControlesVisiveis - ele forca .Visible=.T.
            *-- em toda a arvore e desfaria a escolha feita em ConfigurarControles
            THIS.AplicarVisibilidadeImpressoras()

            *-- Replica o bloco final do Init legado que alinha Opt_Impressora/
            *-- btnReport verticalmente e redimensiona o form
            THIS.AjustarAlturaForm()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
    *   Form OPERACIONAL FLAT: o legado (SIGOPBOL.SCX) nao tem PageFrame nem
    *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
    *   metodo mantido por convencao do orquestrador de migracao (nenhum
    *   AddObject("pgf_4c_...") eh feito aqui).
    *   Demais controles do legado (Opt_Impressora, Lbl_Impressora, Lbl_Erro,
    *   btnReport) entram em fase posterior (campos/eventos de dados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro
        TRY
            *-- cntSombra original: Top=0, Left=0, Width=800 (-> THIS.Width), Height=80
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels adicionados FORA do WITH do container (WITH aninhado com
            *-- AddObject ignora propriedades silenciosamente - regra conhecida)
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                *-- Regra #11: o rotulo da faixa espelha THIS.Caption (ja resolvido
                *-- pelo Do Case legado no Init, ANTES do DODEFAULT que chega aqui).
                *-- O SCX trazia o literal "Cadastro de Testes" - placeholder do
                *-- frmcadastro que o Init legado nunca atualiza, ou seja no legado a
                *-- faixa de um dialogo de boleto exibe "Cadastro de Testes".
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = THIS.Caption   && regra #11 (ver lbl_4c_LblSombra)
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Monta Opt_Impressora, Lbl_Impressora, Lbl_Erro e
    * btnReport (equivalem aos mesmos objetos do SCX legado, todos filhos
    * DIRETOS do form - nao ha PageFrame/Page neste form FLAT) e resolve a
    * lista de impressoras de boleto disponiveis, reproduzindo o PROCEDURE
    * Init legado: CarregarImpressorasConfiguradas() (consulta SigSyImp/
    * SigCdAcG/SigCdmp) + ObterImpressorasDisponiveis() (cruza com APRINTERS()).
    * A decisao final de qual controle fica visivel (Opt_Impressora OU
    * Lbl_Erro) NAO eh aplicada aqui - fica guardada em
    * this_cErroImpressoras/this_nImpressorasDisponiveis e so eh aplicada em
    * AplicarVisibilidadeImpressoras(), chamado DEPOIS de
    * TornarControlesVisiveis() (ver InicializarForm).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_oErro, loc_nImpres, loc_nI, loc_nTop

        TRY
            *-- Lbl_Impressora (SIGOPBOL.Lbl_Impressora)
            THIS.AddObject("lbl_4c_Lbl_Impressora", "Label")
            WITH THIS.lbl_4c_Lbl_Impressora
                .AutoSize = .T.
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Impressora"
                .Height = 15
                .Left = 173
                .Top = 88
                .Width = 68
                *-- O SCX declara Lbl_Impressora.TabIndex = 1 e Lbl_Erro.TabIndex = 1,
                *-- mas TabIndex NAO eh transcrito nos dois Labels: medido no VFP9
                *-- (2026-10-17) o valor nao gruda - VFP exige TabIndex unico por
                *-- container e renumera o duplicado (1 -> 3). E Label nunca eh
                *-- tab-stop (nao recebe foco), entao o numero nao afeta navegacao.
                *-- Transcrever daria uma linha que mente sobre o valor efetivo.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Lbl_Erro (SIGOPBOL.Lbl_Erro) - nasce oculto no SCX; o
            *-- AplicarVisibilidadeImpressoras() decide se aparece
            THIS.AddObject("lbl_4c_Lbl_Erro", "Label")
            WITH THIS.lbl_4c_Lbl_Erro
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .WordWrap = .T.
                .Alignment = 2
                .BackStyle = 0
                .Caption = "N" + CHR(227) + "o Existe Impressora de Boleto Configurada no Seu Computador. Contate o Suporte T" + CHR(233) + "cnico."
                .Height = 40
                .Left = 180
                .Top = 142
                .Width = 210
                *-- TabIndex nao transcrito (ver lbl_4c_Lbl_Impressora)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Opt_Impressora (SIGOPBOL.Opt_Impressora) - ButtonCount definitivo
            *-- so eh conhecido depois da consulta; cria com o default do SCX
            *-- (1 botao) e reconfigura abaixo quando houver impressoras reais
            THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
            WITH THIS.obj_4c_Opt_Impressora
                .BackStyle = 0
                .ButtonCount = 1
                .Height = 74
                .Left = 168
                .SpecialEffect = 1
                .Top = 103
                .Width = 230
                *-- TabIndex do SCX. Medido: nos dois controles FOCALIZAVEIS do form
                *-- (OptionGroup/CommandGroup) o valor gruda exato - Opt=2, btnReport=4.
                .TabIndex = 2
                .BorderColor = RGB(136, 189, 188)
            ENDWITH
            WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Gen" + CHR(233) + "rico/Somente Texto"
                .Height = 15
                .Left = 9
                .Top = 15
                .Width = 137
                .Style = 0
                .TabIndex = 1
                *-- AutoSize = .T. transcrito do SCX (Option1.AutoSize). Medido no
                *-- VFP9 (2026-10-17) com Tahoma 8: da exatamente os 137x15 que o
                *-- SCX declara, identico a AutoSize = .F. - nao eh o caso da regra #23
                *-- (la o estrago vem de WordWrap = .T., que este botao nao tem).
                .AutoSize = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- btnReport (SIGOPBOL.btnReport) - CommandGroup com o unico
            *-- botao Cmd_Imprimir ("Encerrar"), que dispara a impressao e
            *-- fecha o dialogo (Cmd_Imprimir.Click legado)
            THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
            WITH THIS.obj_4c_BtnReport
                .BackStyle = 0
                .BorderStyle = 0
                .ButtonCount = 1
                .Height = 94
                .Left = 718
                .SpecialEffect = 1
                .Top = 2
                .Width = 81
                .TabIndex = 4
                .BorderColor = RGB(100, 100, 100)
            ENDWITH
            WITH THIS.obj_4c_BtnReport.Buttons(1)
                .Top = 1
                .Left = 6
                .Height = 75
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .WordWrap = .T.
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption = "Encerrar"
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH
            BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "CmdImprimirClick")

            *-- Reproduz a resolucao de impressoras do Init legado:
            *-- CarregarImpressorasConfiguradas (SigSyImp/SigCdAcG/SigCdmp) +
            *-- ObterImpressorasDisponiveis (cruza com APRINTERS()).
            loc_nImpres = 0
            IF !THIS.this_oBusinessObject.CarregarImpressorasConfiguradas(gc_4c_UsuarioLogado)
                THIS.this_cErroImpressoras = THIS.this_oBusinessObject.this_cMensagemErro
            ELSE
                loc_nImpres = THIS.this_oBusinessObject.ObterImpressorasDisponiveis()
                IF THIS.this_oBusinessObject.this_nQtdImp = 0
                    *-- "lnCImp = 0" no legado - cobre TANTO o computador sem
                    *-- nenhuma impressora instalada QUANTO nenhuma linha de
                    *-- SigCdmp batendo o filtro; no legado a 1a mensagem
                    *-- ('Seu Computador Nao Apresenta Impressora Configurada')
                    *-- fica sempre sobrescrita por esta, porque lnCImp so
                    *-- incrementa dentro do mesmo SCAN que depende de haver
                    *-- impressora instalada - e' codigo morto, nao reproduzir
                    THIS.this_cErroImpressoras = "Sistema N" + CHR(227) + "o Apresenta Impressora(s) de Boleto Configurada(s). Contate o Suporte T" + CHR(233) + "cnico."
                ENDIF
            ENDIF
            THIS.this_nImpressorasDisponiveis = loc_nImpres

            IF EMPTY(THIS.this_cErroImpressoras) AND loc_nImpres != 0
                *-- Reconfigura Opt_Impressora com 1 botao por impressora
                *-- disponivel (cursor_4c_SigOpBol_Opcoes, Ordem/NomeExibicao/NomeReal)
                THIS.obj_4c_Opt_Impressora.ButtonCount = loc_nImpres

                loc_nTop = 10
                SELECT cursor_4c_SigOpBol_Opcoes
                GO TOP
                FOR loc_nI = 1 TO loc_nImpres
                    *-- Caption/Tag vem do NOME DA IMPRESSORA NO SO (laImpOk no
                    *-- legado - NomeReal aqui), NUNCA do nome gravado em
                    *-- SigCdmp.Impres (NomeExibicao, usado so para o MATCH)
                    WITH THIS.obj_4c_Opt_Impressora.Buttons(loc_nI)
                        .AutoSize = .F.
                        .Caption  = " \<" + ALLTRIM(STR(loc_nI)) + ". " + ALLTRIM(cursor_4c_SigOpBol_Opcoes.NomeReal)
                        .FontSize = 8
                        .Tag      = UPPER(ALLTRIM(cursor_4c_SigOpBol_Opcoes.NomeReal))
                        .Top      = loc_nTop
                        .Width    = 184
                    ENDWITH
                    loc_nTop = loc_nTop + 20
                    SELECT cursor_4c_SigOpBol_Opcoes
                    SKIP
                ENDFOR
                *-- lnHeight legado comeca em 15 (ANTES do loop) e acumula
                *-- +20 por botao - NAO comeca em 10 (esse eh o lnTop, variavel
                *-- distinta): Height final = 15 + 20*lnImpres
                THIS.obj_4c_Opt_Impressora.Height  = 15 + (loc_nImpres * 20)
                THIS.obj_4c_Opt_Impressora.Enabled = (loc_nImpres > 1)
                THIS.obj_4c_Opt_Impressora.Value   = 1
            ELSE
                IF EMPTY(THIS.this_cErroImpressoras)
                    *-- Impressoras configuradas existem (this_nQtdImp > 0) mas
                    *-- nenhuma bate com impressora instalada na estacao
                    THIS.this_cErroImpressoras = "N" + CHR(227) + "o Existe Impressora de Boleto Configurada Nesse Computador. Contate o Suporte T" + CHR(233) + "cnico."
                ENDIF
                THIS.lbl_4c_Lbl_Erro.Caption = THIS.this_cErroImpressoras
                THIS.lbl_4c_Lbl_Erro.Top     = THIS.obj_4c_Opt_Impressora.Top
                THIS.lbl_4c_Lbl_Erro.Height  = THIS.obj_4c_Opt_Impressora.Height
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.ConfigurarControles")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarVisibilidadeImpressoras - Decide qual bloco fica visivel
    * (Opt_Impressora + Lbl_Impressora OU Lbl_Erro), com base no resultado
    * guardado por ConfigurarControles(). Chamado DEPOIS de
    * TornarControlesVisiveis() porque esse metodo forca .Visible = .T. em
    * toda a arvore e desfaria esta escolha se rodasse antes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarVisibilidadeImpressoras()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.this_cErroImpressoras) AND THIS.this_nImpressorasDisponiveis != 0
                THIS.lbl_4c_Lbl_Erro.Visible = .F.
            ELSE
                THIS.obj_4c_Opt_Impressora.Visible   = .F.
                THIS.lbl_4c_Lbl_Impressora.Visible   = .F.
                THIS.lbl_4c_Lbl_Erro.Visible         = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.AplicarVisibilidadeImpressoras")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarAlturaForm - Replica o bloco final do Init legado: alinha
    * Opt_Impressora/btnReport verticalmente (quando Opt_Impressora termina
    * mais abaixo que btnReport, desloca btnReport para o meio) e
    * redimensiona THIS.Height para caber o conteudo, igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarAlturaForm()
        LOCAL loc_nBottom1, loc_nBottom2, loc_oErro
        TRY
            loc_nBottom1 = THIS.obj_4c_Opt_Impressora.Top + THIS.obj_4c_Opt_Impressora.Height
            loc_nBottom2 = THIS.obj_4c_BtnReport.Top + THIS.obj_4c_BtnReport.Height

            IF loc_nBottom1 > loc_nBottom2
                THIS.obj_4c_BtnReport.Top = THIS.obj_4c_BtnReport.Top + INT((loc_nBottom1 - loc_nBottom2) / 2)
                THIS.Height = THIS.obj_4c_Opt_Impressora.Top + THIS.obj_4c_Opt_Impressora.Height + 20
            ELSE
                THIS.Height = THIS.obj_4c_BtnReport.Top + THIS.obj_4c_BtnReport.Height + 20
            ENDIF

            THIS.obj_4c_BtnReport.Buttons(1).SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.AjustarAlturaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdImprimirClick - Equivale ao PROCEDURE Cmd_Imprimir.Click legado
    * (codigo ATIVO, nao o bloco comentado *!* no topo): sincroniza as
    * propriedades publicas do dialogo (setadas pelo form chamador) no BO,
    * le a impressora escolhida em Opt_Impressora e chama
    * ExecutarImpressao() (Do SigBlBol With ...). PUBLIC porque eh chamado
    * via BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdImprimirClick()
        LOCAL loc_nIdx, loc_oErro

        TRY
            *-- Opt_Impressora.Value / ButtonsTag sao lidos SEMPRE no
            *-- legado (o bloco que so lia quando VnQtdimp > 0 esta comentado
            *-- - *!* - e nao eh o codigo ativo)
            loc_nIdx = THIS.obj_4c_Opt_Impressora.Value
            THIS.this_oBusinessObject.this_cImpressoraSelecionada = ;
                THIS.obj_4c_Opt_Impressora.Buttons(loc_nIdx).Tag

            *-- Propriedades publicas atribuidas pelo form chamador
            *-- (this_cTitEnvelope/this_cEmp/this_cDope/this_nNum/this_nDev/
            *-- this_nVias/this_nQBols) - this_nTpBol e this_cCursor ja foram
            *-- sincronizados no Init
            WITH THIS.this_oBusinessObject
                .this_cTitEnvelope = THIS.this_cTitEnvelope
                .this_cEmp         = THIS.this_cEmp
                .this_cDope        = THIS.this_cDope
                .this_nNum         = THIS.this_nNum
                .this_nDev         = THIS.this_nDev
                .this_nVias        = THIS.this_nVias
                .this_nQBols       = THIS.this_nQBols
            ENDWITH

            THIS.this_oBusinessObject.ExecutarImpressao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.CmdImprimirClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores temporarios abertos pelo Business Object
    * (cursor_4c_SigCdmp / cursor_4c_SigOpBol_Opcoes - CarregarImpressorasConfiguradas
    * e ObterImpressorasDisponiveis, usados em fase posterior) antes de
    * repassar para FormBase.Destroy() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdmp")
            USE IN cursor_4c_SigCdmp
        ENDIF
        IF USED("cursor_4c_SigOpBol_Opcoes")
            USE IN cursor_4c_SigOpBol_Opcoes
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

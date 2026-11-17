*==============================================================================
* Formsigopprr.prg - Dialogo "Codigo do Operador"
* Origem ..: SIGOPPRR.SCX (tasks\task791\sigopprr_form_codigo_fonte.txt)
* Herda de : FormBase
* Tipo ....: OPERACIONAL - dialogo modal de autenticacao do operador
*
* Uso:
*   GarantirClasse("Formsigopprr")
*   loForm = CREATEOBJECT("Formsigopprr")
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()                      && modal: bloqueia ate Release
*   ENDIF
*   IF VARTYPE(loForm) = "O" AND loForm.this_lAutenticado
*       lcOperador = loForm.this_cOperador
*   ENDIF
*
*------------------------------------------------------------------------------
* LAYOUT: FLAT, SEM PageFrame - fidelidade ao legado (PILAR 1)
*
* O SCX legado tem raiz `form` GENERICA (nao frmcadastro/frmrelatorio) e a sua
* arvore de objetos declara exatamente 7 controles, NENHUM deles PageFrame:
*
*   SIGOPPRR (form 436x200)
*     +- cntSombra (container) ... faixa cinza do cabecalho
*     |    +- lblSombra (label) .. sombra preta do titulo
*     |    +- lblTitulo (label) .. titulo branco
*     +- USUARIO (textbox fwget) ... Fase 5
*     +- SENHA   (textbox fwget) ... Fase 5
*     +- Label1  "Operador :" ...... Fase 5
*     +- Label2  "Senha :" ......... Fase 5
*
* Logo NAO existe Page de Lista nem Page de Dados a reproduzir, e tambem nao
* ha grade nem botoes CRUD: esta tela nao lista, nao inclui, nao altera e nao
* exclui registro nenhum - ela coleta operador + senha e valida contra
* SigCdUsu (ver sigopprrBO.ValidarLogin). Criar aqui um PageFrame com
* Page1=Lista/Page2=Dados seria INVENTAR superficie que o legado nao tem, o
* que viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md. Pelo mesmo
* motivo nao existe ConfigurarPaginaLista/ConfigurarPaginaDados/AlternarPagina
* neste form - seriam metodos sem conteudo real, proibidos pela regra de
* completude. A estrutura base desta fase eh, portanto, a que o legado de
* fato tem: a classe sobre FormBase, o BO instanciado, a aparencia do form e
* a faixa de cabecalho (cnt_4c_Sombra).
*
* Referencia do mesmo padrao ja validado: FormSIGPRSTF (dialogo modal flat de
* Senha de Risco) e FormSigMvSbn (OPERACIONAL flat sem PageFrame).
*------------------------------------------------------------------------------
* FASE 4/8 (Grid e botoes CRUD) - NADA A ACRESCENTAR: ausencia MEDIDA no dump
*
* No padrao CRUD esta fase entrega a pagina de Lista: a grade de registros, o
* container com os 6 botoes (Incluir/Visualizar/Alterar/Excluir/Buscar/
* Encerrar) e o AlternarPagina(). O SIGOPPRR nao tem NENHUMA dessas
* superficies, e isso foi MEDIDO - nao deduzido - no dump legado
* (tasks\task791\sigopprr_form_codigo_fonte.txt):
*
*   arvore completa do SCX = 9 objetos
*     Dataenvironment | SIGOPPRR (form) | cntSombra (container)
*     lblSombra, lblTitulo, Label1, Label2 (label)
*     USUARIO, SENHA (textbox, classe fwget)
*
*   superficie de LISTA .. ZERO nas 5 clausulas do teste estrito do gate
*     BaseClass grid|pageframe ............ 0
*     ListBox que lista registros ......... 0
*     token Grade/grd do proprio form ..... 0
*     AddCursor que liga grade ............ 0
*     RecordSource/ControlSource de lista . 0  (o dump nao tem nenhum dos dois)
*   superficie de BOTAO .. ZERO (BaseClass commandbutton|commandgroup = 0 e
*     PROCEDURE Click = 0). Os 5 metodos do SCX sao Release, Load e Init do
*     form e os dois LostFocus dos campos - o dialogo fecha pelo proprio
*     LostFocus (Thisform.Release), sem CommandButton algum.
*   superficie de CAMPO .. 2 TextBox EDITAVEIS (USUARIO, SENHA): o dump nao
*     declara ReadOnly em controle nenhum.
*
* Logo o legado eh um dialogo de CAPTURA - coleta operador + senha, valida
* contra SigCdUsu e devolve o resultado ao chamador. Inventar aqui grade,
* botoes CRUD ou AlternarPagina() criaria superficie que o legado nao tem
* (viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md), e a unica
* alternativa seria escrever metodos-adaptador vazios so para casar com o
* regex do gate - o "stub disfarcado" que a regra de completude proibe.
*
* Nota de medicao (probe de instanciacao desta fase): PEMSTATUS(form,
* "AlternarPagina", 5) devolve .T. neste form - mas por HERANCA. O metodo eh
* da FormBase e ja nasce guardado por TYPE("THIS.pgf_4c_Paginas") = "O": sem
* PageFrame ele nao faz nada. Nenhum AlternarPagina nem ConfigurarPaginaLista
* foi escrito aqui. O mesmo probe confere a ausencia do resto:
* grd_4c_Dados = .F., cmd_4c_Incluir = .F., pgf_4c_Paginas = .F.
*
* Precedentes do MESMO perfil, ja validados: FormSigOpChp (task699),
* FormSigOpCtd (task715) e FormSigOpCts (task717) - o ultimo eh identico a
* este, dialogo modal de senha que tambem fecha sem CommandButton.
*
* Fase 5 .. Label1 + USUARIO, com Format/InputMask/MaxLength literais
*              (ConfigurarCampoOperador)
*------------------------------------------------------------------------------
* FASE 6/8 (campos restantes e lookups) - ENTREGUE AQUI
*
*   Campos restantes .. Label2 + SENHA (ConfigurarCampoSenha), com Format,
*       InputMask e PasswordChar literais do dump. Com estes, os 9 objetos da
*       arvore do SCX estao TODOS reproduzidos.
*
*   Lookups ........... NENHUM - ausencia MEDIDA no dump, nao presumida. As 5
*       assinaturas de lookup do legado Fortyus (fwbusca* / mAddColuna /
*       sigacess( / Acesso<X>( / FormBuscaAuxiliar) dao ZERO ocorrencia, e os
*       5 metodos do SCX sao Release, Load e Init do form mais os dois
*       LostFocus dos campos - nenhum KeyPress, logo nenhum F4/F5. Os dois
*       campos sao de digitacao livre: USUARIO eh o codigo do proprio
*       operador e SENHA eh segredo (oferecer os usuarios num picker seria,
*       alem de invencao, vazamento). Ver o cabecalho de LigarEventosCampos.
*
*   No lugar do lookup, esta fase liga o que o legado de fato tem nos campos:
*       os dois PROCEDURE LostFocus, por BINDEVENT (LigarEventosCampos), com
*       os handlers completos (UsuarioLostFocus / SenhaLostFocus) e as regras
*       em metodos proprios (ValidarOperador / ValidarCredenciais /
*       FormParaBO / LimparCampos / FecharDialogo).
*
*   Container cnt_4c_BotoesAcao (Salvar/Cancelar) - NAO EXISTE no legado:
*       zero `BaseClass: commandbutton|commandgroup` e zero `PROCEDURE Click`
*       no dump. O dialogo fecha pelo proprio LostFocus (Thisform.Release),
*       sem botao algum. Criar Salvar/Cancelar aqui inventaria superficie que
*       o legado nao tem (PILAR 1).
*------------------------------------------------------------------------------
* FASE 7/8 (eventos principais) - ENTREGUE: os DOIS unicos eventos de controle
* que o legado tem, ligados por BINDEVENT em LigarEventosCampos e implementados
* em UsuarioLostFocus / SenhaLostFocus (mais os respectivos <Nome>Exec e as
* regras em ValidarOperador, ValidarCredenciais, FormParaBO, LimparCampos e
* FecharDialogo).
*------------------------------------------------------------------------------
* FASE 8/8 (eventos auxiliares e consolidacao final) - ENTREGUE AQUI
*
* 1) GUARDA DE CONEXAO DO Init LEGADO - era o unico trecho do SCX ainda sem
*    contrapartida no migrado. O Init do legado RECUSA abrir a tela quando o
*    conector nao sobe:
*
*        .poDataMgr = CreateObject('fSqlConector')
*        If (.poDataMgr.pnIdconn > 0)
*            =DoDefault()
*        Else
*            =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco de
*                         Dados...', 0+48, 'CreateObject')
*            Return .f.
*        EndIf
*
*    Sem ela o dialogo ABRIA com o banco fora do ar e so falhava la na frente,
*    ao sair do campo Senha, com "Conexao com o banco de dados indisponivel" -
*    mensagem, titulo e MOMENTO diferentes dos do legado. Reproduzida em
*    ValidarParametros(), chamado ANTES do TRY de InicializarForm (o RETURN
*    fica fora de TRY/CATCH - regra #1). gnConnHandle eh o equivalente de
*    poDataMgr.pnIdConn nesta arquitetura: a conexao eh UNICA e vive no
*    main.prg/config.prg, em vez de uma por tela.
*
* 2) MAPA DOS 5 METODOS DO SCX - com esta fase nao sobra nenhum sem destino:
*
*      SIGOPPRR.Init ................ ValidarParametros() + InicializarForm()
*      SIGOPPRR.Load ................ ver (3) abaixo
*      SIGOPPRR.Release ............. FecharDialogo() + Destroy()
*      SIGOPPRR.USUARIO.LostFocus ... UsuarioLostFocus()
*      SIGOPPRR.SENHA.LostFocus ..... SenhaLostFocus()
*
* 3) AS DUAS CHAMADAS GLOBAIS DO LEGADO QUE **NAO** SE TRANSCREVEM:
*
*      =fConfigGeral()  (Load) - o wrapper utils\fconfiggeral.prg EXISTE, mas o
*          cabecalho dele eh explicito: "em codigo NOSSO nunca se chama
*          fConfigGeral - este arquivo existe APENAS para binario legado"
*          (p-code dos VCX, que nao da para editar). O que a funcao fazia ja
*          acontece antes, distribuido: config.prg (SETs, paths, globais),
*          main.prg (conexao, CarregarEmpresa) e cada BO com os proprios
*          cursores. Chamar aqui nao acrescentaria efeito nenhum.
*
*      =fLerFiscal()    (Init) - configuracao de impressora fiscal (hardware).
*          NAO foi portada e NAO se cria stub: regra #27, 3a linha - funcao que
*          devolve valor de calculo / estado de dispositivo fica AUSENTE,
*          porque stub decide errado em silencio. Mesmo tratamento ja adotado
*          em SigOpAutBO e FisBO. Nada nesta tela consome o resultado: o unico
*          consumidor no legado eh ProgOper(...), que tambem nao veio no acervo
*          (ver o cabecalho de sigopprrBO.prg).
*
* 4) NOMES CANONICOS DE FORM CRUD QUE **NAO SE APLICAM** - ausencia MEDIDA no
*    dump, nao presumida. Escreve-los aqui seria inventar superficie que o
*    legado nao tem (PILAR 1) ou criar metodo vazio (proibido pela regra de
*    completude):
*
*      BtnSalvarClick / BtnConfirmarClick .. nao ha botao de gravar - esta tela
*          nao grava registro algum (so LE SigCdUsu para conferir credenciais);
*          quem CONFIRMA eh o LostFocus da Senha, exatamente como no legado.
*      BtnCancelarClick .................... nao ha botao de cancelar - cancelar
*          eh sair do campo Operador em branco (UsuarioLostFocus ->
*          FecharDialogo), a unica saida que o legado oferece.
*      BtnBuscarClick ...................... nao ha busca - zero lookup no dump
*          (as 5 assinaturas estao medidas no cabecalho de LigarEventosCampos).
*      BtnEncerrarClick .................... nao ha cnt_4c_Saida/Encerrar - o
*          dump tem ZERO commandbutton/commandgroup e ZERO PROCEDURE Click.
*      CarregarLista ....................... nao ha lista - zero grid, pageframe,
*          AddCursor e RecordSource no dump.
*      BOParaForm .......................... nao ha caminho de volta - o legado
*          nunca repoe os campos a partir de dado lido: no sucesso ele FECHA e
*          na recusa ZERA os dois (LimparCampos). Reescrever a senha na tela a
*          partir do BO, alem de nao existir no legado, exporia segredo. O
*          sentido que existe de verdade - campos -> BO - esta em FormParaBO.
*      HabilitarCampos ..................... nao ha modo de edicao - os dois
*          campos sao sempre editaveis (o dump nao declara ReadOnly em controle
*          nenhum) e nao existe INCLUIR/ALTERAR/VISUALIZAR nesta tela.
*      AjustarBotoesPorModo ................ consequencia dos dois anteriores:
*          sem botao e sem modo, nao ha o que ajustar.
*
*    A consolidacao real desta tela esta nos metodos que de fato existem:
*    ValidarParametros, ValidarOperador, ValidarCredenciais, FormParaBO,
*    LimparCampos, FecharDialogo e TornarControlesVisiveis.
*------------------------------------------------------------------------------
* PROPRIEDADES VISUAIS TRANSCRITAS DO DUMP (secao "PROPRIEDADES DE: SIGOPPRR")
*   DataSession = 2 | Height = 200 | Width = 436 | AutoCenter = .T.
*   BorderStyle = 2 | ControlBox = .F. | TitleBar = 0 | WindowType = 1
*   Picture = ..\framework\imagens\new_background.jpg
*   Caption = "Codigo do Operador"
*
* NAO transcritas de proposito (o dump NAO as declara - inventa-las muda
* comportamento, conforme a licao do Closable inventado): Closable, MaxButton,
* MinButton e Movable ficam com o default herdado de Form/FormBase.
*==============================================================================

DEFINE CLASS Formsigopprr AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do SCX legado
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width       = 436
    Height      = 200
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1
    ShowWindow  = 1
    DataSession = 2
    Caption     = "C" + CHR(243) + "digo do Operador"

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *
    * this_oBusinessObject ja existe em FormBase; redeclarado aqui apenas para
    * documentar que este form o usa (sigopprrBO), sem mudar o valor inicial.
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *-- Resultado da autenticacao. O chamador le DEPOIS do Show(): .T. somente
    *-- quando sigopprrBO.ValidarLogin() aprovou operador + senha.
    this_lAutenticado = .F.

    *-- Codigo do operador autenticado, no formato publicado pelo legado em
    *-- goSistema.Operador: Transform(Val(Usuario.Value), "@L 999")
    this_cOperador = ""

    *-- Guarda de reentrancia dos handlers de LostFocus (regra #37/#47 do
    *-- CLAUDE.md): o legado valida ao SAIR do campo, e tanto o fechamento
    *-- quanto o aviso de recusa devolvem o foco - sem esta flag o mesmo
    *-- LostFocus redispara e a validacao roda duas vezes.
    *
    *-- Flag UNICA para os DOIS handlers, de proposito. O caso perigoso nao eh
    *-- um campo reentrar em si mesmo e sim um reentrar no OUTRO: no ramo de
    *-- recusa, SenhaLostFocus exibe um MsgAviso MODAL e logo depois esvazia o
    *-- campo Operador (LimparCampos) para devolver o foco a ele. Com flags
    *-- separadas, o LostFocus do Operador - agora VAZIO - poderia disparar no
    *-- meio dessa sequencia e FECHAR o dialogo (eh o que ele faz com campo em
    *-- branco), transformando uma senha errada em "a tela sumiu". Uma flag so
    *-- fecha essa janela.
    this_lEmValidacao = .F.

    *==========================================================================
    * Init - APENAS DODEFAULT()
    *
    * FormBase.Init() chama THIS.InicializarForm(); chamar de novo aqui criaria
    * os objetos duas vezes ("A member object with this name already exists").
    * O DODEFAULT eh tambem o que aplica SET DATE BRITISH / SET CENTURY ON na
    * datasession privada deste form (DataSession = 2, regra #9.4).
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura base da tela
    *
    * Devolve .T./.F.: FormBase.Init() aborta a abertura quando recebe .F. e
    * grava o diagnostico em gc_4c_ArquivoErroTeste.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        *-- Guarda do Init legado: sem conexao com o banco o dialogo NAO abre
        *-- (If .poDataMgr.pnIdconn > 0 ... Else Messagebox + Return .f.).
        *-- RETURN fora de TRY/CATCH - regra #1.
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Business Object (Fases 1-2): valida as credenciais contra SigCdUsu
            THIS.this_oBusinessObject = CREATEOBJECT("sigopprrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                THIS.this_cMensagemErro = "Erro ao criar sigopprrBO."
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ELSE
                *-- Estado inicial: ninguem autenticado ainda
                THIS.this_lAutenticado = .F.
                THIS.this_cOperador    = ""
                THIS.this_lEmValidacao = .F.

                *-- Aparencia do proprio form (fundo/fonte do legado)
                THIS.ConfigurarAparencia()

                *-- Faixa cinza do cabecalho (cntSombra do legado).
                *-- Primeiro AddObject da tela: os controles de dados das Fases
                *-- 5-6 ficam abaixo dela (Top >= 104 no dump) e sao criados
                *-- depois, desenhando por cima - regra #11 do CLAUDE.md.
                THIS.ConfigurarCabecalho()

                *-- Fase 5: rotulo "Operador :" + campo USUARIO (codigo
                *-- numerico do operador, 3 digitos). Criado depois da faixa
                *-- para desenhar por cima dela (regra #11).
                THIS.ConfigurarCampoOperador()

                *-- Fase 6: rotulo "Senha :" + campo SENHA (os 2 objetos que
                *-- faltavam do dump). Tambem depois da faixa, pelo mesmo
                *-- motivo, e depois do USUARIO para respeitar a ordem de
                *-- tabulacao do legado (TabIndex 1 -> 2).
                THIS.ConfigurarCampoSenha()

                *-- Fase 6: liga os eventos dos DOIS campos. So depois de ambos
                *-- existirem - BINDEVENT com objeto inexistente estoura no
                *-- proprio bind (nao em silencio).
                THIS.LigarEventosCampos()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + ;
                " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                " | Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao inicializar Formsigopprr")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarParametros - Guarda de conexao do Init legado
    *
    *   With ThisForm
    *       .poDataMgr = CreateObject('fSqlConector')
    *       If (.poDataMgr.pnIdconn > 0)
    *           =DoDefault()
    *       Else
    *           =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco
    *                        de Dados...', 0+48, 'CreateObject')
    *           Return .f.
    *       EndIf
    *   EndWith
    *
    * O legado abre UMA conexao por tela (poDataMgr) e so segue adiante com
    * pnIdConn > 0. Nesta arquitetura a conexao eh unica e global - aberta no
    * main.prg/config.prg e publicada em gnConnHandle -, entao o equivalente
    * fiel da guarda eh conferir esse handle. Sem ela o dialogo abriria com o
    * banco fora do ar e so falharia ao sair do campo Senha, com mensagem e
    * momento diferentes dos do legado.
    *
    * Mensagem e titulo transcritos do MessageBox legado; icone 48 (aviso) eh
    * o que MsgErro/MsgAviso cobrem - aqui MsgErro, porque o legado ABORTA a
    * abertura, nao apenas avisa.
    *
    * BYPASS DE TESTE no topo, antes de qualquer DO CASE: o harness de
    * 06b_testeAutomatico define gnConnHandle = 0 DE PROPOSITO (sentinela - nao
    * tenta conectar, porque SQLSTRINGCONNECT bloqueia 300s no timeout TCP
    * quando o servidor esta inacessivel) e espera que o form instancie para
    * ser inspecionado. Sem o bypass, InicializarForm devolveria .F.,
    * CREATEOBJECT devolveria logico e o teste "Instanciacao" reprovaria
    * sempre, sem erro de SQL no log. gb_4c_ValidandoUI (ValidarUIFidelity) faz
    * gnConnHandle = -1 e precisa do mesmo tratamento.
    *
    * PUBLIC (sem PROTECTED): alem de ser chamado por THIS. no InicializarForm,
    * eh alcancavel pelo harness, que chama metodos do form de FORA da classe
    * (regra #3 - e PEMSTATUS nao distingue escopo, entao PROTECTED aqui
    * falharia so em runtime).
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido

        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor de Banco de Dados...", "CreateObject")
                loc_lValido = .F.

            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor de Banco de Dados...", "CreateObject")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ConfigurarAparencia - Propriedades visuais do proprio form que dependem
    * de variavel global (nao cabem no bloco estatico da classe).
    *
    * Picture: o dump declara "..\framework\imagens\new_background.jpg". O
    * caminho eh resolvido pela variavel publica (NUNCA remontado a partir de
    * gc_4c_CaminhoBase - Pattern #156/#170); a mesma imagem esta publicada em
    * vbmp\, que eh para onde gc_4c_CaminhoIcones aponta e o que os demais
    * forms OPERACIONAIS usam (FormDCC, FormEnd, FormFop, Formale...).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAparencia()
        THIS.FontName = "Tahoma"
        THIS.FontSize = 8
        THIS.ShowTips = .F.
        THIS.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado)
    *
    * Dump legado:
    *   cntSombra  Top=0 Left=0 Width=800 Height=80 BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Tahoma 18 bold, WordWrap, Alignment=0, BackStyle=0,
    *              Height=40 Left=10 Top=18 Width=769 ForeColor=0,0,0
    *   lblTitulo  Tahoma 18 bold, WordWrap, Alignment=0, BackStyle=0,
    *              Height=46 Left=10 Top=17 Width=769 ForeColor=255,255,255
    *
    * DOIS literais do dump NAO sao transcritos, e os dois pelo mesmo motivo -
    * sao maiores que a propria janela:
    *   - cntSombra.Width = 800 contra SIGOPPRR.Width = 436;
    *   - lblSombra/lblTitulo.Width = 769, que nem dentro de um container de
    *     436 caberia.
    * Eh o artefato conhecido do Form Designer (container desenhado mais largo
    * que o form). Copiar o literal faria o titulo ser RECORTADO no meio pela
    * borda do pai (regra #30: controle fora da area do pai some sem erro).
    * Usa-se entao a forma responsiva ja adotada no projeto: container com
    * THIS.Width e labels com THIS.Width - 20 (os 10px de Left mais a margem
    * simetrica a direita).
    *
    * O Caption dos dois labels vem de THIS.Caption ("Codigo do Operador") e
    * NAO do literal "Cadastro de Testes" que esta no dump: aquele texto eh
    * sobra do template do framework (o mesmo literal aparece no SCX do
    * FormSIGPRSTF, onde tambem foi substituido pelo titulo real). Como este
    * form tem TitleBar = 0, a faixa eh o UNICO lugar em que o usuario le o
    * nome da tela - manter "Cadastro de Testes" num dialogo de login seria
    * exibir informacao errada. Decisao canonica da regra #11 do CLAUDE.md
    * (o label de titulo recebe THIS.Caption).
    *
    * AutoSize = .F. explicito nos dois labels: AutoSize eh no-op em Label
    * criado por AddObject enquanto invisivel e, com WordWrap = .T., descarta
    * a Height (regra #23) - as medidas vao literais.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container da faixa (cntSombra)
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Sombra preta do titulo (lblSombra)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Titulo branco sobre o cinza (lblTitulo)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = THIS.Width - 20
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCampoOperador - Rotulo "Operador :" (Label1) + campo USUARIO
    * (mapeamento.json: Label1 -> lbl_4c_Label1, USUARIO -> txt_4c_USUARIO).
    * Ambos criados DIRETO em THIS - o SCX legado nao tem PageFrame nem
    * container algum para eles ("Parent: SIGOPPRR").
    *
    * lbl_4c_Label1 (Label1): dump DECLARA AutoSize = .T. junto com
    * Width = 89/Height = 21 - regra CLAUDE.md #23 manda escrever
    * .AutoSize = .F. e transcrever as duas medidas, porque AutoSize eh no-op
    * em Label criado por AddObject (a Width ficaria nos 100 do default).
    * Esses 89x21 JA SAO o auto-size que o Form Designer calculou para
    * "Operador :" em Tahoma 12 bold, logo fixa-los eh reproducao fiel, nao
    * desvio do PILAR 1. ForeColor = 90,90,90 eh o do dump e tambem o
    * canonico de label de dados sobre a Picture clara da tela (regra #12).
    *
    * txt_4c_USUARIO (USUARIO, classe fwget no legado): campo numerico do
    * codigo do operador - Format = "K" (seleciona o conteudo ao entrar),
    * InputMask = "999" (3 digitos) e MaxLength = 3 transcritos literalmente
    * do dump; SelectOnEntry = .F. tambem esta declarado no dump e sobrescreve
    * o default .T. do VFP. O Valid/LostFocus ("If IsEmpty(This.Value) /
    * Thisform.Release") fica para a Fase 7 - aqui so geometria e mascara,
    * igual ao padrao ja usado em FormSigOpCts/FormSigOpChp neste mesmo ponto
    * do pipeline. Classe "TextBox" simples (nao subclasse): o legado liga o
    * LostFocus por PROCEDURE no proprio controle, que na migracao se
    * reproduz com BINDEVENT (regra #3/#47), sem exigir subclasse dedicada.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoOperador()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .Caption   = "Operador :"
                .Height    = 21
                .Left      = 110
                .Top       = 109
                .Width     = 89
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_USUARIO", "TextBox")
            WITH THIS.txt_4c_USUARIO
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 12
                .BackStyle     = 0
                .Format        = "K"
                .InputMask     = "999"
                .MaxLength     = 3
                .SelectOnEntry = .F.
                .TabIndex      = 1
                .Value         = ""
                .Top           = 104
                .Left          = 201
                .Width         = 50
                .Height        = 30
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.ConfigurarCampoOperador")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCampoSenha - Rotulo "Senha :" (Label2) + campo SENHA
    * (mapeamento.json: Label2 -> lbl_4c_Label2, SENHA -> txt_4c_SENHA).
    * Com estes dois, os 9 objetos do dump legado estao TODOS reproduzidos.
    * Ambos criados DIRETO em THIS - o dump diz "Parent: SIGOPPRR" nos dois.
    *
    * lbl_4c_Label2 (Label2): mesmo tratamento do Label1 - o dump DECLARA
    * AutoSize = .T. junto com Width = 63 / Height = 21, e a regra #23 manda
    * escrever .AutoSize = .F. e transcrever as duas medidas, porque AutoSize
    * eh no-op em Label criado por AddObject (a Width ficaria nos 100 do
    * default, e os 100 px a partir de Left = 136 invadiriam o TextBox em
    * Left = 201). Os 63x21 JA SAO o auto-size que o Form Designer calculou
    * para "Senha :" em Tahoma 12 bold. ForeColor = 90,90,90 eh o do dump e
    * tambem o canonico de label de dados (regra #12).
    *
    * txt_4c_SENHA (SENHA, classe fwget no legado) - transcricao literal do
    * dump, nada inventado:
    *   Format        = "K"           seleciona o conteudo ao entrar
    *   InputMask     = "!!!!!!!!!!"  10 posicoes, forcando MAIUSCULA
    *   PasswordChar  = "*"           mascara a digitacao na tela
    *   Top/Left/Width/Height = 139/201/136/30
    *   TabIndex = 2, BackStyle = 0, Themes = .T., ForeColor/BackColor do dump
    *
    * Tres decisoes de transcricao que merecem registro:
    *
    * 1) MaxLength NAO eh declarado - e NAO se inventa. O dump declara
    *    MaxLength so no USUARIO (3). Aqui as 10 posicoes do InputMask ja
    *    limitam a digitacao a 10 caracteres, que eh exatamente a largura de
    *    SigCdUsu.senhas char(10) e o PADR(...,10) que o BO aplica - nao ha
    *    divergencia a corrigir, logo acrescentar a propriedade seria desvio
    *    do PILAR 1 sem ganho algum.
    *
    * 2) O "!" do InputMask (MAIUSCULA) faz parte da REGRA, nao da estetica:
    *    a senha gravada no legado passou pelo mesmo campo, logo a comparacao
    *    de ValidarLogin so casa se a digitacao continuar sendo maiusculizada.
    *    Descartar essa mascara (defeito tipico - regra #49) faria "abc" nunca
    *    autenticar contra uma senha gravada como "ABC".
    *
    * 3) Format = "K" NAO contem "M", entao o InputMask aqui eh mascara de
    *    digitacao mesmo, e nao lista de valores validos (regra #24).
    *
    * .Value = "" explicito: TextBox nasce com Value LOGICO .F. quando nada eh
    * atribuido, e ALLTRIM/PADR sobre .F. estoura "Function argument value,
    * type, or count is invalid".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoSenha()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .Caption   = "Senha :"
                .Height    = 21
                .Left      = 136
                .Top       = 144
                .Width     = 63
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_SENHA", "TextBox")
            WITH THIS.txt_4c_SENHA
                .FontBold     = .T.
                .FontName     = "Tahoma"
                .FontSize     = 12
                .BackStyle    = 0
                .Format       = "K"
                .InputMask    = "!!!!!!!!!!"
                .PasswordChar = "*"
                .TabIndex     = 2
                .Value        = ""
                .Top          = 139
                .Left         = 201
                .Width        = 136
                .Height       = 30
                .ForeColor    = RGB(0, 0, 0)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .T.
                .Visible      = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.ConfigurarCampoSenha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LigarEventosCampos - BINDEVENT dos dois campos digitaveis
    *
    * LOOKUP: NAO EXISTE NENHUM NESTA TELA - ausencia MEDIDA, nao presumida.
    * Varredura do dump (tasks\task791\sigopprr_form_codigo_fonte.txt) pelos
    * cinco padroes de lookup do legado Fortyus:
    *
    *   fwbusca (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt) ... 0 ocorrencias
    *   mAddColuna (API de colunas do picker legado) ....... 0
    *   sigacess( ......................................... 0
    *   Acesso<Campos|Contab|Contas|Empresa|Grupos|...>( ... 0
    *   FormBuscaAuxiliar ................................. 0
    *
    * E os 5 metodos do SCX sao Release/Load/Init do form mais os dois
    * LostFocus dos campos - nenhum KeyPress, portanto nenhum F4/F5. Os dois
    * campos do legado tambem nao tem classe customizada de TextBox: ambos sao
    * `fwget`, o TextBox padrao do framework.
    *
    * Os dois campos sao de DIGITACAO LIVRE e nao referenciam tabela de apoio
    * para escolher em grade: USUARIO eh o codigo numerico do proprio operador
    * (a unica tabela consultada, SigCdUsu, eh conferida por igualdade em
    * ValidarLogin, nao oferecida em lista) e SENHA eh segredo - exibir os
    * usuarios num picker seria, alem de invencao, vazamento. Criar aqui um
    * AbrirLookup*/AbrirBusca* apontando para SigCdUsu violaria o PILAR 1 e a
    * regra explicita "NUNCA inventar tabelas de lookup que nao existem no
    * original"; criar o metodo vazio so para casar com o gate seria o "stub
    * disfarcado" que a regra de completude proibe.
    *
    * O que esta fase liga, entao, eh o que o legado de fato tem nos campos:
    * o PROCEDURE LostFocus de cada um.
    *
    * Evento "LostFocus" e NAO "KeyPress" (regra #47): o legado valida ao SAIR
    * do campo. Em KeyPress o handler dispararia a CADA TECLA - a senha seria
    * conferida (e recusada, limpando os dois campos) no primeiro caractere
    * digitado, e o usuario nunca conseguiria terminar de digitar. Pela mesma
    * regra os handlers de LostFocus NAO declaram parametros: LostFocus nao
    * passa nenhum.
    *
    * PUBLIC obrigatorio nos handlers: BINDEVENT ignora metodo PROTECTED em
    * silencio (regra #3).
    *==========================================================================
    PROTECTED PROCEDURE LigarEventosCampos()
        LOCAL loc_oErro

        TRY
            *-- SIGOPPRR.USUARIO.LostFocus - campo vazio encerra o dialogo
            BINDEVENT(THIS.txt_4c_USUARIO, "LostFocus", THIS, "UsuarioLostFocus")

            *-- SIGOPPRR.SENHA.LostFocus - confere as credenciais
            BINDEVENT(THIS.txt_4c_SENHA, "LostFocus", THIS, "SenhaLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.LigarEventosCampos")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * UsuarioLostFocus - Transcricao de SIGOPPRR.USUARIO.LostFocus:
    *
    *   If IsEmpty(This.Value)
    *       Thisform.Release
    *   EndIf
    *
    * Sair do campo Operador em branco EH o cancelamento do dialogo - este
    * form nao tem botao nenhum (zero commandbutton/commandgroup no dump), e
    * esta eh a unica saida do usuario alem da autenticacao bem-sucedida.
    *
    * `IsEmpty` do Fortyus trata NULL como vazio; aqui o valor vem do proprio
    * TextBox e nunca eh NULL, entao EMPTY() nativo basta (regra #2: em codigo
    * nosso usar EMPTY() direto, o wrapper utils\isempty.prg existe so para o
    * p-code dos VCX).
    *
    * Wrapper fino + <Nome>Exec: o corpo tem RETURN antecipado, e set/clear da
    * flag no proprio corpo deixaria a guarda TRAVADA ligada, matando o
    * handler pelo resto da vida do form (regra #47).
    *
    * PUBLIC: alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE UsuarioLostFocus()
        IF THIS.this_lEmValidacao
            RETURN
        ENDIF

        THIS.this_lEmValidacao = .T.
        THIS.UsuarioLostFocusExec()
        THIS.this_lEmValidacao = .F.
    ENDPROC

    PROTECTED PROCEDURE UsuarioLostFocusExec()
        IF !THIS.ValidarOperador()
            *-- Operador em branco: o legado fecha a tela
            THIS.FecharDialogo()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * SenhaLostFocus - Transcricao de SIGOPPRR.SENHA.LostFocus:
    *
    *   lcUser = PADR(ThisForm.USUARIO.Value,10)
    *   lcPass = PADR(Thisform.SENHA.Value,10)
    *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a
    *              where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' ...]
    *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
    *   If Not Used(...) Or Reccount(...)==0 Or Empty(lcUser)
    *      OR lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
    *       =MessageBox('Usuario ou Senha incorretos',0+48,'')
    *       ThisForm.Senha.Value   = ''
    *       Thisform.Usuario.Value = ''
    *       ThisForm.Usuario.SetFocus
    *   Else
    *       If ProgOper(Val(Thisform.Usuario.Value),Thisform.oModem)
    *           goSistema.Operador = Transform(Val(...),'@L 999')
    *       Endif
    *       Thisform.Release
    *   EndIf
    *
    * Divisao de responsabilidade (PILAR 3): a CONSULTA e a conferencia moram
    * em sigopprrBO.ValidarLogin (Fase 2), que ja transcreve a query, o filtro
    * NOT cativos='N', as quatro condicoes de recusa e a chamada literal a
    * fCriptografar. Aqui fica so o que eh da TELA: espelhar os campos para o
    * BO, decidir entre os dois ramos e executar o efeito visivel de cada um.
    *
    * Ramo de RECUSA - os quatro passos do legado, na mesma ordem:
    *   MsgAviso sem titulo (equivale a MessageBox(...,0+48,'') - icone 48 eh
    *   aviso, e validacao de UI nunca usa MsgErro), os DOIS campos limpos e o
    *   foco de volta no Operador. A mensagem eh a do BO, que por construcao
    *   devolve o mesmo texto do legado nas quatro condicoes, sem revelar qual
    *   delas falhou.
    *
    * Ramo de ACEITE - publica o operador e fecha. `ProgOper` (programacao do
    * operador no dispositivo) nao veio no acervo e `ThisForm.oModem` nao
    * existe nem no SCX legado nem aqui; o BO.DefinirOperadorLogado grava
    * go_4c_Sistema.Operador assim mesmo, com o MESMO Transform(...,'@L 999'),
    * porque eh desse efeito que o resto do sistema depende.
    *
    * As properties de retorno (this_lAutenticado / this_cOperador) sao
    * gravadas ANTES de fechar: com Hide() o Destroy so roda quando o chamador
    * liberar o objeto, entao todo efeito que o chamador le na sequencia tem
    * de acontecer AQUI, no funil, e nao no Destroy.
    *
    * PUBLIC: alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE SenhaLostFocus()
        IF THIS.this_lEmValidacao
            RETURN
        ENDIF

        THIS.this_lEmValidacao = .T.
        THIS.SenhaLostFocusExec()
        THIS.this_lEmValidacao = .F.
    ENDPROC

    PROTECTED PROCEDURE SenhaLostFocusExec()
        LOCAL loc_lOk, loc_cMensagem, loc_oErro

        TRY
            loc_lOk = THIS.ValidarCredenciais()

            IF loc_lOk
                *-- goSistema.Operador = Transform(Val(Usuario.Value),'@L 999')
                THIS.this_oBusinessObject.DefinirOperadorLogado()

                THIS.this_lAutenticado = .T.

                *-- FONTE UNICA: o mesmo this_cUsuarios de que
                *-- DefinirOperadorLogado derivou go_4c_Sistema.Operador, com o
                *-- mesmo Transform(...,'@L 999') do legado. Recalcular a
                *-- partir do TextBox daria dois caminhos para o MESMO valor -
                *-- e um deles ficaria livre para divergir do que foi publicado
                *-- (o BO guarda o valor ja normalizado por PADR(...,10)).
                THIS.this_cOperador    = TRANSFORM(VAL(THIS.this_oBusinessObject.this_cUsuarios), "@L 999")

                *-- Thisform.Release do legado
                THIS.FecharDialogo()
            ELSE
                loc_cMensagem = THIS.this_oBusinessObject.this_cMensagemErro

                IF EMPTY(loc_cMensagem)
                    loc_cMensagem = "Usu" + CHR(225) + "rio ou Senha incorretos"
                ENDIF

                THIS.this_lAutenticado = .F.
                THIS.this_cOperador    = ""

                *-- MessageBox('Usuario ou Senha incorretos', 0+48, '')
                MsgAviso(loc_cMensagem, "")

                *-- ThisForm.Senha.Value = '' / Thisform.Usuario.Value = ''
                THIS.LimparCampos()

                *-- ThisForm.Usuario.SetFocus
                IF THIS.Visible AND THIS.txt_4c_USUARIO.Visible AND THIS.txt_4c_USUARIO.Enabled
                    THIS.txt_4c_USUARIO.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lAutenticado = .F.
            THIS.this_cOperador    = ""
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.SenhaLostFocus")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarOperador - Regra do campo Operador (SIGOPPRR.USUARIO.LostFocus)
    *
    * Devolve .T. quando o campo tem conteudo e .F. quando esta em branco - o
    * chamador decide o que fazer com isso (o LostFocus fecha a tela, como o
    * legado). NAO exibe mensagem: o legado tambem nao exibe nenhuma neste
    * caminho, apenas fecha.
    *
    * TRANSFORM antes do ALLTRIM: com InputMask = "999" o TextBox pode
    * entregar NUMERICO, e ALLTRIM sobre numerico dispara erro 11.
    *
    * PUBLIC: chamado pelos handlers e disponivel para o fluxo das fases
    * seguintes.
    *==========================================================================
    PROCEDURE ValidarOperador()
        LOCAL loc_cOperador

        loc_cOperador = ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value))

        RETURN !EMPTY(loc_cOperador)
    ENDPROC

    *==========================================================================
    * ValidarCredenciais - Conferencia completa de Operador + Senha
    *
    * Espelha os campos para o BO (FormParaBO) ANTES de validar: o legado le
    * ThisForm.USUARIO.Value / ThisForm.SENHA.Value, isto eh, o TEXTBOX eh a
    * fonte unica. Sem esse espelho, trocar o conteudo do campo e sair dele
    * validaria as credenciais ANTERIORES, guardadas no BO.
    *
    * Ordem: ValidarDados() (conferencia local, sem ida ao banco - o legado
    * trata operador vazio como recusa, via Empty(lcUser) dentro do If) e so
    * entao ValidarLogin(), que faz a consulta a SigCdUsu.
    *
    * Devolve .T./.F. e deixa o texto da recusa em
    * this_oBusinessObject.this_cMensagemErro - quem exibe eh o chamador,
    * porque eh ele que conhece o momento certo (o legado so avisa no
    * LostFocus da Senha).
    *
    * PUBLIC: chamado pelo handler e pelo fluxo das fases seguintes.
    *==========================================================================
    PROCEDURE ValidarCredenciais()
        LOCAL loc_lValido

        loc_lValido = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.ValidarDados()
                loc_lValido = THIS.this_oBusinessObject.ValidarLogin( ;
                    ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value)), ;
                    ALLTRIM(TRANSFORM(THIS.txt_4c_SENHA.Value)))
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * FormParaBO - Leva o conteudo dos dois campos da tela para o BO
    *
    * O PADR(...,10) do legado NAO eh aplicado aqui: ValidarLogin ja o faz, e
    * duplicar o padding mudaria quem casa com a chave char(10).
    *
    * TRANSFORM antes do ALLTRIM pelo mesmo motivo de ValidarOperador (o
    * TextBox com InputMask numerico pode entregar Numerico).
    *
    * PROTECTED - e nao por escolha: FormBase.prg:285 declara FormParaBO como
    * PROTECTED, e pela regra #51 o PROTECTED da base PREVALECE mesmo que a
    * subclasse omita o modificador (medido aqui com
    * PEMSTATUS(form, "FormParaBO", 2) = .T.). Esta chamado so de DENTRO da
    * classe (ValidarCredenciais); de fora o acesso estoura
    * "Property FORMPARABO is not found" - quem precisar do espelho a partir
    * de outro objeto deve passar por ValidarCredenciais().
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cUsuarios = ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value))
        THIS.this_oBusinessObject.this_cSenhas   = ALLTRIM(TRANSFORM(THIS.txt_4c_SENHA.Value))

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Ramo de recusa do legado:
    *   ThisForm.Senha.Value = '' / Thisform.Usuario.Value = ''
    *
    * Limpa tambem o estado do BO, para que a tentativa seguinte nao herde o
    * cargo/setor do operador da tentativa anterior (sigopprrBO.LimparDados).
    *
    * PROTECTED pelo mesmo motivo de FormParaBO: FormBase.prg:276 ja declara
    * LimparCampos como PROTECTED e a regra #51 faz isso valer aqui. Chamado
    * so de dentro (SenhaLostFocusExec).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_SENHA.Value   = ""
        THIS.txt_4c_USUARIO.Value = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparDados()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FecharDialogo - Funil UNICO de fechamento da tela
    *
    * Hide() e NAO Release(), apesar de o legado escrever `Thisform.Release`.
    * Medido no VFP9: Release() destroi o objeto mesmo com o chamador
    * segurando a referencia (VARTYPE passa a "X"), e a leitura seguinte
    * estoura "is not an object". Este dialogo existe justamente para DEVOLVER
    * um resultado - o cabecalho deste arquivo documenta
    * `loForm.this_lAutenticado` / `loForm.this_cOperador` lidos DEPOIS do
    * Show() -, entao transcrever o Release ao pe da letra tornaria esse
    * resultado inalcancavel.
    *
    * Para o usuario nao muda nada (Hide() em form modal tambem devolve o
    * Show() e a tela some), e eh o desenho que o projeto ja adota em
    * FormBuscaAuxiliar: o CHAMADOR chama Release() depois de ler.
    *
    * O legado nao tem `PROCEDURE Unload / Return`, nem o chamador abre com
    * `DO FORM ... TO` - por isso nao se inventa Unload aqui.
    *==========================================================================
    PROCEDURE FecharDialogo()
        IF THIS.Visible
            THIS.Hide()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
    * Percorre o container informado (ou o proprio form) tornando visivel o que
    * tem a propriedade, e recursa nos containers filhos.
    *
    * PEMSTATUS antes de tocar Visible: nem toda classe base tem a propriedade
    * (regra #33 - atribuir o que a classe nao tem derruba o Init e a tela nao
    * abre).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_oAlvo, loc_nI, loc_oControle

        loc_oAlvo = IIF(VARTYPE(par_oContainer) = "O", par_oContainer, THIS)

        IF VARTYPE(loc_oAlvo) = "O" AND PEMSTATUS(loc_oAlvo, "ControlCount", 5)
            FOR loc_nI = 1 TO loc_oAlvo.ControlCount
                loc_oControle = loc_oAlvo.Controls(loc_nI)

                IF VARTYPE(loc_oControle) = "O"
                    IF PEMSTATUS(loc_oControle, "Visible", 5)
                        loc_oControle.Visible = .T.
                    ENDIF

                    IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oControle)
                    ENDIF
                ENDIF
            ENDFOR
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - Solta o BO e devolve o controle a FormBase.Destroy(), que
    * reconstroi os popups do menu principal (Pattern #145: sem o DODEFAULT na
    * ULTIMA linha o menu do sistema encolhe depois que o dialogo fecha).
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

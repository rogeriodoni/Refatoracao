*====================================================================
* Formsigoppop.prg
*
* Form OPERACIONAL "Transferencia Entre Locais" (SIGOPPOP) - copia
* operacoes de movimento (SigMvCab/SigMvItn/SigMvHst/SigMvNfi) de uma
* empresa/documento de ORIGEM para uma empresa/documento de DESTINO,
* conforme um "Processo de Copia" pre-configurado em outro cadastro
* (SigPcOoP/SigPcOoI). Form de TOPO: o Init do legado nao recebe
* Lparameters - diferente de sigoppag/sigoporc (forms filhos abertos
* pelo cabecalho do movimento), este eh aberto direto do menu
* (popMovimentos) e cria sua propria conexao/datasession.
*
* PILAR 3 (arquitetura): o legado (SIGOPPOP.scx) eh um form FLAT do
* VFP9 - SEM PageFrame, SEM Page1/Page2: cntSombra (faixa do
* cabecalho), cmdBtnGrade (CommandGroup de 3 botoes ao lado da grade -
* Selecionar Tudo/Desmarcar/Documentos), cntGrade (grid de 11 colunas
* - GrdOperacoes), cntOperacoes (processo de copia + periodo + opt
* "Nao Processadas/Ja Processadas" + chk "Exibir Mensagens"),
* cntFiltro (empresa origem/destino), cntComplemento (data de
* lancamento + tolerancia AU) e cmdBtnForm (CommandGroup de 3 botoes -
* Limpar/Copiar/Encerrar) sao TODOS filhos diretos do form - nao ha
* PageFrame nenhum no dump (layout.json/sigoppop_form_codigo_fonte_
* slim.txt), entao este form migrado reproduz a mesma estrutura flat
* (excecao documentada em CLAUDE.md para o Gate da Fase 3 quando o
* legado nao tem PageFrame - referencia: Formsigoppag.prg/
* Formsigoporc.prg, mesma familia "Processo de Copia").
*
* PILAR 1 (UX): dialogo 1000x600, sem barra de titulo (TitleBar=0),
* sem controle de janela (ControlBox=.F./Closable=.F./MaxButton=.F./
* MinButton=.F.), com a faixa de cabecalho cinza (cntSombra) no topo
* mostrando "Transferencia Entre Locais". WindowType do dump eh 0
* (modeless) - NAO transcrito literalmente: regra CLAUDE.md
* "WindowType 0 transcrito do SCX mata a tela" - usado WindowType=1
* (modal), mesmo padrao de Formsigopfin/Formsigopind/Formsigoppag.
*
* Mapeamento (tasks/task787/mapeamento.json): SIGOPPOP.cntSombra ->
* cnt_4c_Sombra, .lblSombra -> lbl_4c_LblSombra, .lblTitulo ->
* lbl_4c_LblTitulo.
*
* FASE 3/8 - ESTRUTURA BASE (esta fase): DEFINE CLASS, propriedades
* visuais, Init()/Destroy(), InicializarForm() (cria sigoppopBO +
* fundo new_background.jpg) e ConfigurarLayout() com SO a faixa do
* cabecalho (ConfigurarCabecalho - cnt_4c_Sombra) e o container vazio
* que vai hospedar o CommandGroup de acao (cnt_4c_Botoes, posicionado
* na bbox de cmdBtnForm do dump - Top=-2/Left=769/Width=235/Height=85,
* flutuante/transparente sobre a faixa, regra CLAUDE.md #11: criado
* DEPOIS da faixa para desenhar por cima). O CommandGroup cmg_4c_
* CmdBtnForm (Limpar/Copiar/Encerrar) entra dentro deste container em
* fase posterior.
*
* FASE 4/8 - GRADE + BOTOES DE LINHA (layout FLAT, sem PageFrame,
* mesmo padrao de Formsigoppag): cnt_4c_Grade (equivalente a cntGrade)
* hospedando grd_4c_Dados (equivalente a GrdOperacoes, 11 colunas -
* Check1 de marcacao + Codigo/Data/Valor/Documento/Usuario/Origem/
* Destino/Orig./Dest./Movimentacao, regra #18
* Column.AddObject+CurrentControl+Sparse para a coluna de check) +
* cmg_4c_CmdBtnGrade (equivalente a cmdBtnGrade - Selecionar Tudo/
* Desmarcar/Documentos) + o funil CarregarLista() ligado a
* this_oBusinessObject.this_cCursorOperacoes (cursor_4c_Operacoes).
* Mapeamento das 10 colunas de dado (dump nao declara ControlSource
* explicito - GrdOperacoes e um Grid nativo sem metodo de bind no
* trecho de codigo disponivel; inferido pelos ToolTipText de cada
* Column.Text1 do dump, casando contra o CREATE CURSOR do legado -
* csOperacoes - citado em comportamento.json): Codigo->Numes,
* Data->Datas, Valor->Valos, Documento->Notas, Usuario->Usuars,
* Origem->ContaOs, Destino->ContaDs, Orig.->Emps, Dest.->EmpDs,
* Movimentacao->Dopes (mais largo - 242px - compativel com Dopes
* char(20)). O cursor so e POPULADO pelo Selecionar() do legado
* (cntOperacoes.cmdSelecionar.Valid), nao no Init - nesta fase o
* cursor_4c_Operacoes nasce vazio (casca) e CarregarLista() so
* faz o bind/repintura (regra #21 - popular cursor NAO repinta a
* grade); Selecionar() entra na Fase 7/8 e reusa este mesmo metodo
* para repintar depois de popular.
*
* FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1) - esta fase: cnt_4c_Operacoes
* (equivalente a cntOperacoes do dump) com lbl_4c_TituloOperacoes
* (titulo em negrito "Operacoes" - Label1 do dump), obj_4c_OptProcessados
* (OptionGroup "Nao Processadas"/"Ja Processadas" - 2 botoes, INDICE,
* regra "numeric(1,0) de 2 opcoes nao eh logica" - NUNCA converter para
* logico), lbl_4c_Processo + cbo_4c_CmbOperacoes (Processo de Copia -
* RowSourceType=2/Alias sobre this_cCursorProcessos, populado por
* sigoppopBO.CarregarProcessos() a partir de SigPcOoP.processos char(20);
* o legado le o texto selecionado via ListItem(ListIndex), NAO por
* codigos numeric - no migrado o equivalente e ler cbo.Value, que e o
* mesmo texto pela ColumnCount=1), lbl_4c_Periodo + txt_4c_DtIni +
* lbl_4c_Ate + txt_4c_DtFin (periodo - Value inicial = DATE(), igual ao
* Init legado), cmd_4c_CmdSelecionar (botao que dispara Selecionar()),
* chk_4c_Fwcheckbox1 (CheckBox grafico Picture=consultar.bmp que liga
* ThisForm.ShowTips - comportamento.json InteractiveChange) e
* chk_4c_ChkMensa (Exibir Mensagens de Erro - .Value NUMERICO, regra
* CLAUDE.md, NUNCA .T./.F.). BINDEVENT dos eventos (Click/
* InteractiveChange) fica para a Fase 7/8, junto com os demais botoes
* do form.
*
* Colisao de nome resolvida (regra "nomes legado diferem so na caixa
* colidem"): mapeamento.json mapeia TANTO Say1 ("Periodo :") QUANTO
* Label1 ("Operacoes") para "lbl_4c_Label1" - sao dois Labels distintos
* no MESMO container (cntOperacoes), e usar o mesmo nome AddObject
* estouraria "object already exists". Say1 ficou lbl_4c_Periodo (label
* de campo) e Label1 ficou lbl_4c_TituloOperacoes (titulo de secao em
* negrito, Left=13/Top=3/AutoSize=.T.) - nomes diferentes do mapeamento
* gerado, documentados aqui.
*
* Say2 (Caption = "?" no dump/layout.json, Left=464 entre getDtIni e
* getDtFin) - a extracao corrompeu o caractere; pela posicao (entre as
* duas datas do periodo) e o padrao "Periodo : <DtIni> a <DtFin>", o
* texto original e a preposicao "a". Migrado como lbl_4c_Ate = "a".
*
* FASE 6/8 (esta fase) - CAMPOS RESTANTES E LOOKUPS (PARTE 2):
* cnt_4c_Filtro (equivalente a cntFiltro do dump) com os 4 campos de
* empresa origem/destino (txt_4c_EmpOs/txt_4c_DEmpOs/txt_4c_EmpDs/
* txt_4c_DEmpDs) e cnt_4c_Complemento (equivalente a cntComplemento)
* com txt_4c_DtLanc e txt_4c_Toleras (Format "K"/InputMask "999.99"
* do dump). Os 4 campos de empresa tem lookup completo: o legado
* chama fAcessoEmpresa(Usuar, 'C'|'D', This.Value, getEmpX, getDEmpX,
* poDataMgr) no Valid de cada campo (comportamento.json) -
* fAcessoEmpresa() NAO existe no sistema novo (regra CLAUDE.md), e o
* padrao MODO LOOKUP (5 args, popula 2 textboxes) substituido eh o
* bloco FormBuscaAuxiliar apontando SigCdEmp (Cemps/Razas),
* referencia canonica Formsigatcrp.prg:2285-2445 (ValidarEmp/
* AbrirBuscaEmp/ValidarDemp/AbrirBuscaDemp) - NAO o
* VerificarAcessoEmpresa (modo CHECK, 2 args, sem UI), que nao se
* aplica aqui porque o legado preenche os DOIS textboxes a partir do
* picker. BINDEVENT em "KeyPress" com par_nKeyCode testado (F4=115
* abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato e so
* abrem o picker em caso de miss) - regra CLAUDE.md #47, handler
* TESTA a tecla, entao KeyPress eh legitimo (nao precisa LostFocus
* nem guarda de reentrancia, que so vale para handler ligado a
* LostFocus). Pares: ValidarEmpOs/AbrirBuscaEmpOs (Cemps) +
* ValidarDEmpOs/AbrirBuscaDEmpOs (Razas, so ativo quando EmpOs esta
* vazio - When do dump) para Origem; ValidarEmpDs/AbrirBuscaEmpDs +
* ValidarDEmpDs/AbrirBuscaDEmpDs para Destino, mesmo padrao.
*
* FASE 7/8 (esta fase) - EVENTOS: BINDEVENT dos Click de cmg_4c_
* CmdBtnForm (btnLimpar/btnCopiar/btnSair - equivalentes a
* LimpaSelecao()/Processamento()/Release do legado, dump:
* sigoppop_form_codigo_fonte.txt:10809-10897) e de cmg_4c_CmdBtnGrade
* (btnMarcaTudo/btnDesmarcar/btnDocumentos, dump:10488-10513), Click
* de cmd_4c_CmdSelecionar (equivalente ao Valid legado "ThisForm.
* Selecionar()", dump:10713-10715 - migrado para "Click", que e o
* evento confiavel para CommandButton via BINDEVENT neste projeto) e
* os 4 handlers (Click/KeyPress/MouseDown/MouseUp, todos NODEFAULT) da
* coluna de marcacao da grade (regra CLAUDE.md #46 - Valid/KeyPress da
* celula, NUNCA AfterRowColChange; dump:10525-10575).
*
* THIS.LimpaSelecao() e os handlers de cmg_4c_CmdBtnGrade/Check1 sao
* AUTOSSUFICIENTES (so manipulam cursor_4c_Operacoes e estado visual -
* nenhuma dependencia de metodo ainda nao escrito). THIS.
* CmdSelecionarClick() e o ramo "Copiar" de CmdBtnFormClick() chamam
* THIS.this_oBusinessObject.Selecionar()/.Processamento() - metodos
* QUE AINDA NAO EXISTEM no BO (o legado so tem fonte completo, sem
* truncamento, para Selecionar - dump:9941-10289 - e para Processamento
* - dump:5652-9936, ~4300 linhas; este ultimo ainda abre uma conexao
* fSqlConector POR EMPRESA DE DESTINO, via Drives/cIdConns de
* SigCdLoc, porque no legado cada empresa mora em um arquivo .DBF
* fisico separado - premissa que NAO existe na arquitetura nova, onde
* todas as empresas compartilham o MESMO SQL Server/gnConnHandle e sao
* filtradas pela coluna Emps/EmpDs, Pilar 2). Forward-reference
* deliberada, documentada tambem no cabecalho de sigoppopBO.prg - a
* Fase 8/8 implementa os dois no BO, adaptando o algoritmo de
* Processamento() para o modelo de conexao unica em vez de abrir uma
* conexao fisica por empresa.
*
* FASE 8/8 (esta fase) - CONSOLIDACAO. No Form:
*   - fConfigGeral() e fChecaAcesso([SIGOPPOP],[OPJAPROC]) no
*     InicializarForm, como no Init legado (dump:10297 e 10440);
*   - o gate de AcertaEmpDopNums() do Init legado (dump:10323-10327),
*     que NAO abre a tela quando a chave EmpDopNums nao pode ser
*     corrigida (pulado em modo de teste/validacao de UI);
*   - os CINCO indices do cursor da grade (Load legado, dump:10459-
*     10463) e o laco final do Init legado (dump:10425-10431 - fonte
*     Courier New e colunas travadas da 2 em diante) mais o
*     DynamicForeColor que pinta de VERMELHO a operacao ja excluida;
*   - BOParaForm() (tolerancia e data inicial que o Selecionar do BO
*     altera) e AplicarOrdemGrade() (SigPcOoP.Ordems);
*   - no CmdSelecionarClick, a confirmacao de REPROCESSAMENTO e as
*     validacoes de periodo com SetFocus (dump:9951-10013);
*   - no CmdBtnFormClick, o fecho "LimpaSelecao + refazer a selecao"
*     que o legado executa ao concluir a copia.
*
* BO: sigoppopBO - Selecionar() e o ciclo de fiscais/logs, o acerto de
* EmpDopNums, as faixas de peso, a geracao de codigo de produto, o
* casamento de produto, o modo FRANQUIA completo (Financeiro +
* FazContra + log em SigPcOoL) e a Delecao da origem estao
* implementados. A copia da MOVIMENTACAO completa (LancaProduto/
* LancaProdutoF/LancaProducao + o laco de destinos do Processamento,
* ~6.900 linhas do dump) NAO esta transcrita: Processamento() recusa
* esse caminho ANTES de gravar qualquer coisa, com mensagem que diz o
* que falta - ver "ESTADO DESTA FASE" no cabecalho de
* sigoppopBO.Processamento().
* Herda de: FormBase
*====================================================================

DEFINE CLASS Formsigoppop AS FormBase

    *-- DataSession privada (fiel ao legado: DataSession=2). O fix
    *-- sistemico de FormBase.Init() (SET DATE TO BRITISH + SET
    *-- CENTURY ON) roda incondicionalmente, regra CLAUDE.md #9.4.
    DataSession  = 2

    ShowWindow   = 1
    WindowType   = 1          && canonico - legado declara 0 (modeless), que MATA a tela (CLAUDE.md "WindowType 0 transcrito do SCX mata a tela")

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Transfer" + CHR(234) + "ncia Entre Locais"

    *-- Nome do cursor da grade de operacoes candidatas/selecionadas -
    *-- copiado de sigoppopBO.this_cCursorOperacoes em InicializarForm
    *-- (fonte unica, evita literal duplicado). Usado por CarregarLista
    *-- (Fase 4/8) e fechado em Destroy().
    this_cCursorOperacoes = ""

    *-- Nome do cursor da lista de Processos de Copia (RowSource do
    *-- combo cbo_4c_CmbOperacoes) - copiado de sigoppopBO.this_cCursorProcessos
    *-- em InicializarForm. Usado por ConfigurarOperacoes (Fase 5/8) e
    *-- fechado em Destroy().
    this_cCursorProcessos = ""

    *====================================================================
    * Init - form de topo, sem parametros (legado nao tem Lparameters).
    * DODEFAULT() aciona FormBase.Init(), que chama InicializarForm().
    *====================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - cria o Business Object, aplica o fundo padrao
    * do framework legado e monta a casca visual (Fase 3/8: so a faixa
    * do cabecalho + o container vazio de botoes).
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigoppopBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar sigoppopBO.", "Erro")
            ELSE
                THIS.this_cCursorOperacoes  = THIS.this_oBusinessObject.this_cCursorOperacoes
                THIS.this_cCursorProcessos  = THIS.this_oBusinessObject.this_cCursorProcessos

                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                *-- fConfigGeral() - primeira linha do Init legado
                *-- (dump:10297). Carrega a configuracao geral do sistema
                *-- legado; existe como wrapper em utils\fconfiggeral.prg
                *-- (regra CLAUDE.md #27).
                fConfigGeral()

                THIS.this_oBusinessObject.CarregarProcessos()

                *-- Cadastro de destinos do Processo de Copia e parametros
                *-- gerais (crTodosDestinos / crSigCdPam / crSigCdPac do Init
                *-- legado - dump:10354-10395). Lidos aqui para o BO nao
                *-- depender de quem o chama.
                THIS.this_oBusinessObject.CarregarDestinos()
                THIS.this_oBusinessObject.CarregarParametros()

                THIS.ConfigurarLayout()
                THIS.CarregarLista()

                *-- "If (.AcertaEmpDopNums() < 1) ... Return .f." do Init
                *-- legado (dump:10323-10327): sem a chave EmpDopNums
                *-- preenchida em SigMvCab/SigMvItn/SigMvPar a selecao nao
                *-- encontra operacao nenhuma, entao o legado NAO abre a tela.
                *-- Pulado em modo de teste/validacao de UI, que roda sem
                *-- conexao (gnConnHandle = -1).
                loc_lSucesso = .T.

                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                   (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
                    IF !THIS.this_oBusinessObject.AcertaEmpDopNums()
                        MsgAviso("A Chave EmpDopNums Est" + CHR(225) + " Inv" + CHR(225) + ;
                            "lida e N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Corrigir o Erro." + CHR(13) + ;
                            "Contate o Suporte T" + CHR(233) + "cnico e Informe Este Problema.", ;
                            "Acerta EmpDopNums")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                *-- "cntOperacoes.optProcessados.Enabled = fChecaAcesso(
                *-- [SIGOPPOP],[OPJAPROC])" do Init legado (dump:10440): so
                *-- quem tem a permissao OPJAPROC pode pedir reprocessamento
                *-- de operacoes ja copiadas.
                IF loc_lSucesso
                    THIS.cnt_4c_Operacoes.obj_4c_OptProcessados.Enabled = ;
                        fChecaAcesso("SIGOPPOP", "OPJAPROC")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppop.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarLayout - orquestrador de montagem visual (layout FLAT,
    * sem PageFrame - o legado nao tem). Fase 3/8: a faixa do cabecalho
    * e o container de botoes de acao. Fase 4/8: a grade de operacoes,
    * o CommandGroup de marcacao ao lado dela (cmg_4c_CmdBtnGrade) e o
    * CommandGroup de acao dentro do container (cmg_4c_CmdBtnForm).
    * Fase 5/8 em diante acrescenta os campos de filtro.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarLayout()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainerBotoes()
        THIS.ConfigurarCmdBtnForm()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCmdBtnGrade()
        THIS.ConfigurarOperacoes()
        THIS.ConfigurarFiltro()
        THIS.ConfigurarComplemento()
        THIS.ConfigurarEventosBotoes()
    ENDPROC

    *====================================================================
    * ConfigurarCabecalho - faixa cinza do topo com o titulo do form.
    * Nomes conforme tasks/task787/mapeamento.json (SIGOPPOP.cntSombra/
    * lblSombra/lblTitulo -> cnt_4c_Sombra/lbl_4c_LblSombra/
    * lbl_4c_LblTitulo). Width usa THIS.Width (canonico do projeto) em
    * vez do literal 1004 do dump, que extrapola o Width=1000 do form.
    * Caption dos labels fica .Caption = THIS.Caption (equivalente ao
    * "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" do
    * Init legado), nao o texto generico "Cadastro de Testes" do dump.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top           = 0
                .Left          = 0
                .Width         = THIS.Width
                .Height        = 80
                .BackStyle     = 1
                .BackColor     = RGB(100, 100, 100)
                .BorderWidth   = 0
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .Top       = 15
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarContainerBotoes - container que hospeda o CommandGroup
    * de acao (equivalente a cmdBtnForm do dump - Limpar/Copiar/
    * Encerrar, 3 botoes, Top=-2/Left=769/Width=235/Height=85).
    * Transparente (BackStyle=0) e criado DEPOIS da faixa (regra
    * CLAUDE.md #11) para flutuar por cima dela - a bbox do legado
    * (Top=-2..83) cobre quase toda a altura da faixa (0..80).
    * O CommandGroup entra em ConfigurarCmdBtnForm(), logo a seguir.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top         = -2
                .Left        =  542
                .Width       = 235
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoes")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarCmdBtnForm - CommandGroup de acao do form, dentro de
    * cnt_4c_Botoes (equivalente a cmdBtnForm do dump: btnLimpar/
    * btnCopiar/btnSair). Sao os botoes REAIS do legado - este form
    * OPERACIONAL nao tem CRUD (Incluir/Alterar/Excluir), e inventar
    * esses botoes violaria o PILAR 1.
    *
    * Geometria: o grupo ocupa o container inteiro (Top/Left = 0,
    * 235x85 - a mesma bbox que o dump declara em coordenadas de form,
    * Top=-2/Left=769, ja absorvida pelo container). Os Buttons usam os
    * Top/Left do dump, que ja sao relativos ao grupo (5,5 / 5,80 /
    * 5,155, todos 75x75). Width/Height do grupo ficam EXPLICITOS em
    * vez de AutoSize = .T.: sao os mesmos numeros que o Form Designer
    * calculou, logo fixa-los eh reproducao fiel (regra CLAUDE.md #23).
    *
    * Picture/ForeColor/BackColor/Font/Themes transcritos do dump -
    * NUNCA inventar nome de icone (regra CLAUDE.md #25). O btnSair ja
    * nasce no padrao canonico de saida (75x75, Caption "Encerrar",
    * cadastro_sair_60.jpg), entao nao ha conflito com a regra #10.
    * Os Click entram na Fase 7/8.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCmdBtnForm()
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Botoes.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
            WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
                .Top         = 0
                .Left        = 0
                .Width       = 235
                .Height      = 85
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 5
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Caption         = "Limpar"
                    .ToolTipText     = "Limpar Sele" + CHR(231) + CHR(227) + "o"
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnLimpar.Enabled = .f. no Init - dump:10313).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 80
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Caption         = "Copiar"
                    .ToolTipText     = ""
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnCopiar.Enabled = .f. no Init - dump:10314).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 5
                    .Left            = 155
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Cancel          = .T.
                    .Caption         = "Encerrar"
                    .ToolTipText     = "[ESC] Sair"
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCmdBtnForm")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarGrid - cria o cursor (casca) da grade de operacoes
    * candidatas (equivalente ao "Create Cursor csOperacoes" do Init
    * legado - regra OPERACIONAL #4: SET NULL ON antes do CREATE
    * CURSOR, pois os valores reais virao de SQLEXEC no Selecionar() da
    * Fase 7/8) e o container+Grid que a exibem (cnt_4c_Grade/
    * grd_4c_Dados, nomes conforme mapeamento.json).
    *
    * ORDEM OBRIGATORIA (regra "grid_autobind_area_corrente_quebra_
    * addobject_checkbox"): um Grid SEM RecordSource ainda atribuida
    * auto-binda sozinho ao alias CORRENTE no instante em que
    * ColumnCount e definido - e se a coluna que vai receber o
    * Column.AddObject("Check1","CheckBox") cair, por acaso, numa
    * coluna CHARACTER dessa auto-bind, o AddObject estoura "Data type
    * mismatch" DENTRO de si mesmo (CheckBox.Value nasce NUMERICO).
    * Por isso RecordSource + ControlSource de TODAS as colunas e
    * aplicado ANTES do AddObject do Check1 - nunca depois. ColumnCount
    * e fixado AQUI, UMA UNICA VEZ (regra "SOREDUZIRColumn" -
    * reatribuir ColumnCount recria as colunas e destroi o Check1).
    * CarregarLista() so REBINDA (RecordSource/ControlSource/Width/
    * Header1.Caption, que o RecordSource RESETA a cada chamada - regra
    * "Problema 48"), sem tocar no AddObject.
    *
    * Colunas 1 a 11 (Width/ToolTipText/FontName/FontSize transcritos
    * do dump): Column1 = Check1 (marcacao, regra #18 - AddObject +
    * CurrentControl + Sparse); Columns 2-11 = Text1 de exibicao
    * (Codigo/Data/Valor/Documento/Usuario/Origem/Destino/Orig./Dest./
    * Movimentacao).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cCursor, loc_oGrid, loc_nCol, loc_oColuna, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        TRY
            IF !USED(loc_cCursor)
                SET NULL ON
                CREATE CURSOR (loc_cCursor) ;
                    (SelImp L NULL, Emps C(3) NULL, Dopes C(20) NULL, ;
                     Numes N(6, 0) NULL, Datas D NULL, Valos N(12, 2) NULL, ;
                     Notas C(10) NULL, Usuars C(10) NULL, ContaOs C(10) NULL, ;
                     ContaDs C(10) NULL, EmpDs C(3) NULL, Deletado L NULL)
                SET NULL OFF

                *-- Os CINCO indices do Load legado (dump:10459-10463). Um TAG
                *-- por criterio de ordenacao do Processo de Copia
                *-- (SigPcOoP.Ordems): 1-Operacao / 2-Data / 3-Nota /
                *-- 4-Origem / 5-Destino. Sem eles o "SET ORDER TO TAG <x>"
                *-- que AplicarOrdemGrade() faz depois de Selecionar nao tem
                *-- em que se apoiar.
                INDEX ON Emps + Dopes + STR(Numes, 6)                   TAG Operacao
                INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)     TAG Data
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6)           TAG Nota
                INDEX ON ContaOs + Emps + Dopes + STR(Numes, 6)         TAG Origem
                INDEX ON ContaDs + Emps + Dopes + STR(Numes, 6)         TAG Destino
                SET ORDER TO TAG Operacao
            ENDIF

            THIS.AddObject("cnt_4c_Grade", "Container")
            WITH THIS.cnt_4c_Grade
                .Top         = 209
                .Left        = 9
                .Width       = 932
                .Height      = 375
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Grade.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.cnt_4c_Grade.grd_4c_Dados

            WITH loc_oGrid
                .Top               = 2
                .Left              = 1
                .Width             = 929
                .Height            = 372
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .HeaderHeight      = 16
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ColumnCount       = 11

                *-- RecordSource + ControlSource de TODAS as colunas
                *-- ANTES do AddObject do Check1 (ver comentario do
                *-- metodo acima - evita o auto-bind em coluna
                *-- CHARACTER estourar o AddObject do CheckBox).
                .RecordSource = loc_cCursor

                .Column1.ControlSource  = loc_cCursor + ".SelImp"
                .Column2.ControlSource  = loc_cCursor + ".Numes"
                .Column3.ControlSource  = loc_cCursor + ".Datas"
                .Column4.ControlSource  = loc_cCursor + ".Valos"
                .Column5.ControlSource  = loc_cCursor + ".Notas"
                .Column6.ControlSource  = loc_cCursor + ".Usuars"
                .Column7.ControlSource  = loc_cCursor + ".ContaOs"
                .Column8.ControlSource  = loc_cCursor + ".ContaDs"
                .Column9.ControlSource  = loc_cCursor + ".Emps"
                .Column10.ControlSource = loc_cCursor + ".EmpDs"
                .Column11.ControlSource = loc_cCursor + ".Dopes"

                *-- Column1 - marcacao (Check1). CurrentControl/Sparse
                *-- obrigatorios (regra #18) para o CheckBox aparecer e
                *-- ser editavel em TODAS as linhas.
                .Column1.FontName = "Tahoma"
                .Column1.FontSize = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = ""
                .Column1.AddObject("Check1", "CheckBox")
                WITH .Column1.Check1
                    .Top         = 9
                    .Left        = 2
                    .Height      = 17
                    .Width       = 22
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Alignment   = 0
                    .Caption     = ""
                    .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
                    .Visible     = .T.
                    .ReadOnly    = .F.
                ENDWITH
                .Column1.CurrentControl = "Check1"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.
                .Column1.Width          = 15

                .Column2.FontName = "Tahoma"
                .Column2.FontSize = 8
                .Column2.Width    = 52
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "C" + CHR(243) + "digo"
                .Column2.Text1.BorderStyle = 1
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.ToolTipText = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column3.FontName = "Tahoma"
                .Column3.FontSize = 8
                .Column3.Width    = 80
                .Column3.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Data"
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ToolTipText = "Data da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column4.FontName = "Tahoma"
                .Column4.FontSize = 8
                .Column4.Width    = 104
                .Column4.Header1.Alignment = 2
                .Column4.Header1.Caption   = "Valor"
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)
                .Column4.Text1.ToolTipText = "Valor da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column5.FontName = "Tahoma"
                .Column5.FontSize = 8
                .Column5.Width    = 75
                .Column5.Header1.Alignment = 2
                .Column5.Header1.Caption   = "Documento"
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
                .Column5.Text1.ToolTipText = "Documento da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column6.FontName = "Tahoma"
                .Column6.FontSize = 8
                .Column6.Width    = 85
                .Column6.Header1.Alignment = 2
                .Column6.Header1.Caption   = "Usu" + CHR(225) + "rio"
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(255, 255, 255)
                .Column6.Text1.ToolTipText = "Usu" + CHR(225) + "rio Que Gerou a Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column7.FontName = "Tahoma"
                .Column7.FontSize = 8
                .Column7.Width    = 85
                .Column7.Header1.Alignment = 2
                .Column7.Header1.Caption   = "Origem"
                .Column7.Text1.BorderStyle = 0
                .Column7.Text1.Margin      = 0
                .Column7.Text1.ForeColor   = RGB(0, 0, 0)
                .Column7.Text1.BackColor   = RGB(255, 255, 255)
                .Column7.Text1.ToolTipText = "Conta de Origem da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column8.FontName = "Tahoma"
                .Column8.FontSize = 8
                .Column8.Width    = 85
                .Column8.Header1.Alignment = 2
                .Column8.Header1.Caption   = "Destino"
                .Column8.Text1.BorderStyle = 0
                .Column8.Text1.Margin      = 0
                .Column8.Text1.ForeColor   = RGB(0, 0, 0)
                .Column8.Text1.BackColor   = RGB(255, 255, 255)
                .Column8.Text1.ToolTipText = "Conta de Destino da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column9.FontName = "Tahoma"
                .Column9.FontSize = 8
                .Column9.Width    = 37
                .Column9.Header1.Alignment = 2
                .Column9.Header1.Caption   = "Orig."
                .Column9.Text1.BorderStyle = 0
                .Column9.Text1.Margin      = 0
                .Column9.Text1.ForeColor   = RGB(0, 0, 0)
                .Column9.Text1.BackColor   = RGB(255, 255, 255)
                .Column9.Text1.ToolTipText = "Empresa da Opera" + CHR(231) + CHR(227) + "o de Origem"

                .Column10.FontName = "Tahoma"
                .Column10.FontSize = 8
                .Column10.Width    = 37
                .Column10.Header1.Alignment = 2
                .Column10.Header1.Caption   = "Dest."
                .Column10.Text1.BorderStyle = 0
                .Column10.Text1.Margin      = 0
                .Column10.Text1.ForeColor   = RGB(0, 0, 0)
                .Column10.Text1.BackColor   = RGB(255, 255, 255)
                .Column10.Text1.ToolTipText = "Empresa da Opera" + CHR(231) + CHR(227) + "o de Destino"

                .Column11.FontName = "Tahoma"
                .Column11.FontSize = 8
                .Column11.Width    = 242
                .Column11.Header1.Alignment = 2
                .Column11.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Column11.Text1.BorderStyle = 0
                .Column11.Text1.Margin      = 0
                .Column11.Text1.ForeColor   = RGB(0, 0, 0)
                .Column11.Text1.BackColor   = RGB(255, 255, 255)

                *-- Laco final do Init legado (dump:10425-10431): da coluna 2
                *-- ate a ultima, fonte Courier New e coluna TRAVADA
                *-- (Movable/Resizable/ReadOnly). Esse laco roda DEPOIS das
                *-- propriedades do SCX, entao ele e quem decide o estado
                *-- final - inclusive da Column11, que o SCX declara
                *-- ReadOnly = .F. e o laco volta para .T. Como o Grid.ReadOnly
                *-- propaga para as colunas, o ReadOnly de coluna vem DEPOIS
                *-- dele (regra CLAUDE.md #18/#46).
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.

                FOR loc_nCol = 2 TO .ColumnCount
                    loc_oColuna = .Columns(loc_nCol)
                    loc_oColuna.FontName  = "Courier New"
                    loc_oColuna.Movable   = .F.
                    loc_oColuna.Resizable = .F.
                    loc_oColuna.ReadOnly  = .T.
                ENDFOR

                *-- "SetAll([DynamicForeColor], [Iif(csOperacoes.Deletado,
                *-- Rgb(255,0,0), Rgb(0,0,0))], [Column])" do Init legado: a
                *-- operacao que veio de SigExMvc (ja excluida na origem)
                *-- aparece em VERMELHO na grade.
                .SetAll("DynamicForeColor", ;
                    "IIF(" + loc_cCursor + ".Deletado, RGB(255,0,0), RGB(0,0,0))", ;
                    "Column")

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarCmdBtnGrade - CommandGroup de 3 botoes ao lado direito
    * da grade (equivalente a cmdBtnGrade do dump - Selecionar Tudo/
    * Desmarcar/Documentos). Posicao, Picture e cores transcritas do
    * dump; Themes = .F. nos Buttons internos (padrao canonico de
    * Buttons dentro de CommandGroup). Os Click (btnMarcaTudo/
    * btnDesmarcar/btnDocumentos) entram na Fase 7/8.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCmdBtnGrade()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmg_4c_CmdBtnGrade", "CommandGroup")
            WITH THIS.cmg_4c_CmdBtnGrade
                .Top         = 364
                .Left        = 944
                .Width       = 43
                .Height      = 135
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top             = -1
                    .Left            = -1
                    .Height          = 45
                    .Width           = 45
                    .FontName        = "Verdana"
                    .FontSize        = 8
                    .Caption         = ""
                    .ToolTipText     = "Selecionar"
                    .ForeColor       = RGB(36, 84, 155)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnMarcaTudo.Enabled = .f. no Init - dump:10315).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 45
                    .Left            = -1
                    .Height          = 45
                    .Width           = 45
                    .FontName        = "Verdana"
                    .FontSize        = 8
                    .Caption         = ""
                    .ToolTipText     = "Desmarcar"
                    .ForeColor       = RGB(36, 84, 155)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnDesmarcar.Enabled = .f. no Init - dump:10316).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 91
                    .Left            = -1
                    .Height          = 45
                    .Width           = 45
                    .FontName        = "Verdana"
                    .FontSize        = 8
                    .Caption         = ""
                    .ToolTipText     = "Documento"
                    .ForeColor       = RGB(36, 84, 155)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnDocumentos.Enabled = .f. no Init - dump:10317).
                    .Enabled         = .F.
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCmdBtnGrade")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarOperacoes - cnt_4c_Operacoes (equivalente a cntOperacoes
    * do dump): titulo de secao, Processo de Copia (combo), periodo
    * (datas) e o botao Selecionar. Geometria/cores/fontes transcritas
    * do dump (tasks/task787/sigoppop_form_codigo_fonte_slim.txt). Ver
    * comentario de Fase 5/8 no topo do arquivo para a colisao de nome
    * Say1/Label1 e a leitura de Say2 ("a").
    *====================================================================
    PROTECTED PROCEDURE ConfigurarOperacoes()
        LOCAL loc_oCnt, loc_oErro

        TRY
            *-- Guarda defensiva: se CarregarProcessos() (chamado em
            *-- InicializarForm, antes desta fase) nao conseguiu abrir
            *-- conexao (ex.: modo de teste sem SQL Server), garantir que
            *-- o cursor existe antes de amarrar o RowSourceType=2 do
            *-- combo - senao o AddObject do ComboBox estoura.
            IF !USED(THIS.this_cCursorProcessos)
                CREATE CURSOR (THIS.this_cCursorProcessos) (processos C(20))
            ENDIF

            THIS.AddObject("cnt_4c_Operacoes", "Container")
            loc_oCnt = THIS.cnt_4c_Operacoes
            WITH loc_oCnt
                .Top         = 88
                .Left        = 6
                .Width       = 732
                .Height      = 46
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            *-- Label1 do dump - titulo de secao em negrito ("Operacoes").
            *-- Nome lbl_4c_TituloOperacoes (NAO lbl_4c_Label1 do
            *-- mapeamento.json - colide com Say1, ver comentario de topo).
            loc_oCnt.AddObject("lbl_4c_TituloOperacoes", "Label")
            WITH loc_oCnt.lbl_4c_TituloOperacoes
                .Top       = 3
                .Left      = 13
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .FontItalic = .F.
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Oper" + "\<" + "a" + CHR(231) + CHR(245) + "es"
                .Visible   = .T.
            ENDWITH

            *-- optProcessados - OptionGroup "Nao Processadas"/"Ja
            *-- Processadas". Value = INDICE (1/2), NUNCA booleano (regra
            *-- CLAUDE.md "numeric(1,0) de duas opcoes nao eh logica").
            *-- Default = 1 (Nao Processadas), igual a BO.this_nProcessados.
            loc_oCnt.AddObject("obj_4c_OptProcessados", "OptionGroup")
            WITH loc_oCnt.obj_4c_OptProcessados
                .Top         = 5
                .Left        = 83
                .Width       = 235
                .Height      = 15
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top       = -1
                    .Left      = 5
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Caption   = "N" + CHR(227) + "o Processadas"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH

                WITH .Buttons(2)
                    .Top       = -1
                    .Left      = 126
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Caption   = "J" + CHR(225) + " Processadas"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH

            *-- Say3 do dump - "Processo :".
            loc_oCnt.AddObject("lbl_4c_Processo", "Label")
            WITH loc_oCnt.lbl_4c_Processo
                .Top        = 24
                .Left       = 23
                .Width      = 60
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Processo :"
                .Visible    = .T.
            ENDWITH

            *-- cmbOperacoes - Processo de Copia cadastrado (SigPcOoP).
            *-- RowSourceType=2 (Alias) sobre this_cCursorProcessos,
            *-- populado por sigoppopBO.CarregarProcessos() ANTES desta
            *-- fase (THIS.InicializarForm() chama o BO antes de
            *-- ConfigurarLayout()). ColumnCount=1 (so o texto Processos,
            *-- char(20) - o legado le o mesmo texto via
            *-- ListItem(ListIndex), nao por codigo numerico).
            loc_oCnt.AddObject("cbo_4c_CmbOperacoes", "ComboBox")
            WITH loc_oCnt.cbo_4c_CmbOperacoes
                .Top            = 20
                .Left           = 87
                .Width          = 196
                .Height         = 24
                .FontName       = "Courier New"
                .FontSize       = 8
                .SpecialEffect  = 1
                .Style          = 2
                .ColumnCount    = 1
                .RowSourceType  = 2
                .RowSource      = THIS.this_cCursorProcessos
                .ToolTipText    = "Opera" + CHR(231) + CHR(245) + "es de C" + CHR(243) + "pia Configuradas no Cadastro de Opera" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia"
                .BorderColor    = RGB(90, 90, 90)
                .Visible        = .T.
            ENDWITH

            *-- Say1 do dump - "Periodo :". Nome lbl_4c_Periodo (NAO
            *-- lbl_4c_Label1 do mapeamento.json - colide com Label1).
            loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
            WITH loc_oCnt.lbl_4c_Periodo
                .Top        = 23
                .Left       = 323
                .Width      = 50
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Per" + CHR(237) + "odo :"
                .Visible    = .T.
            ENDWITH

            *-- getDtIni - data inicial do periodo. Value inicial =
            *-- DATE(), igual ao Init do legado (ver comentario da
            *-- property BO.this_dDtIni em sigoppopBO.prg).
            loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
            WITH loc_oCnt.txt_4c_DtIni
                .Top          = 20
                .Left         = 377
                .Width        = 80
                .Height       = 23
                .SpecialEffect = 1
                .ToolTipText  = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
                .BorderColor  = RGB(90, 90, 90)
                .Value        = DATE()
                .Visible      = .T.
            ENDWITH

            *-- Say2 do dump - "a" entre as duas datas do periodo (ver
            *-- comentario de topo sobre a extracao corrompida).
            loc_oCnt.AddObject("lbl_4c_Ate", "Label")
            WITH loc_oCnt.lbl_4c_Ate
                .Top        = 24
                .Left       = 464
                .Width      = 10
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "a"
                .Visible    = .T.
            ENDWITH

            *-- getDtFin - data final do periodo. Value inicial = DATE().
            loc_oCnt.AddObject("txt_4c_DtFin", "TextBox")
            WITH loc_oCnt.txt_4c_DtFin
                .Top          = 21
                .Left         = 477
                .Width        = 80
                .Height       = 23
                .SpecialEffect = 1
                .ToolTipText  = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
                .BorderColor  = RGB(90, 90, 90)
                .Value        = DATE()
                .Visible      = .T.
            ENDWITH

            *-- cmdSelecionar - dispara Selecionar() (BO), que monta
            *-- cursor_4c_Operacoes a partir do filtro. BINDEVENT do
            *-- Click fica para a Fase 7/8.
            loc_oCnt.AddObject("cmd_4c_CmdSelecionar", "CommandButton")
            WITH loc_oCnt.cmd_4c_CmdSelecionar
                .Top         = 21
                .Left        = 595
                .Width       = 99
                .Height      = 23
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Caption     = "\<Selecionar"
                .ToolTipText = "Seleciona as Opera" + CHR(231) + CHR(245) + "es Conforme os Dados Digitados"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            *-- fwcheckbox1 do dump - CheckBox grafico (Style=1,
            *-- Picture=consultar.bmp do framework legado, rule #25 -
            *-- NUNCA inventar nome de icone) que liga/desliga
            *-- ThisForm.ShowTips (comportamento.json:
            *-- "ThisForm.ShowTips = (This.Value = 1)" no InteractiveChange).
            *-- .Value NUMERICO (regra CLAUDE.md). BINDEVENT do
            *-- InteractiveChange fica para a Fase 7/8, junto com os
            *-- demais eventos do form.
            loc_oCnt.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
            WITH loc_oCnt.chk_4c_Fwcheckbox1
                .Top       = 21
                .Left      = 704
                .Width     = 24
                .Height    = 23
                .Style     = 1
                .Alignment = 0
                .Caption   = ""
                .Value     = 0
                .BackColor = RGB(255, 255, 255)
                .Picture   = gc_4c_CaminhoFramework + "imagens\consultar.bmp"
                .Visible   = .T.
            ENDWITH

            *-- chkMensa - "Exibir Mensagens de Erro". .Value NUMERICO
            *-- (regra CLAUDE.md), NUNCA .T./.F.. Default = 1 (marcado),
            *-- igual a BO.this_lExibirMensagens = .T..
            loc_oCnt.AddObject("chk_4c_ChkMensa", "CheckBox")
            WITH loc_oCnt.chk_4c_ChkMensa
                .Top         = 3
                .Left        = 377
                .Width       = 180
                .Height      = 17
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontItalic  = .F.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = "Exibir Mensagens de Erro"
                .Value       = 1
                .ToolTipText = "Exibe Mensagens Relativas a Erros de Lan" + CHR(231) + "amento"
                .ForeColor   = RGB(90, 90, 90)
                .Visible     = .T.
                *-- Desabilitado ate Selecionar() popular a grade (regra do
                *-- legado: chkMensa.Enabled = .f. no Init - dump:10318).
                .Enabled     = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarOperacoes")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarFiltro - cnt_4c_Filtro (equivalente a cntFiltro do dump):
    * 2 pares codigo+descricao de empresa (Origem/Destino). Geometria/
    * cores/fontes transcritas do dump (sigoppop_form_codigo_fonte_
    * slim.txt). MaxLength=3 nos campos de codigo (regra CLAUDE.md
    * "SigCdEmp TextBox de codigo - MaxLength=3 obrigatorio", conferido
    * no dump - getEmpOs/getEmpDs ja declaram MaxLength=3).
    *
    * Lookup: o legado valida no Valid (ao sair do campo) chamando
    * fAcessoEmpresa no modo LOOKUP de 5 argumentos (comportamento.json);
    * aqui, como BINDEVENT em "Valid" de TextBox nao e confiavel (regra
    * CLAUDE.md #3), o equivalente fica no "KeyPress", testando a tecla
    * (F4=115 abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato
    * contra SigCdEmp e so abrem o picker em caso de miss - regra
    * CLAUDE.md #47, sem necessidade de guarda de reentrancia porque o
    * handler testa par_nKeyCode). Os pickers (AbrirBuscaEmpOs/
    * AbrirBuscaDEmpOs/AbrirBuscaEmpDs/AbrirBuscaDEmpDs) e os validadores
    * (ValidarEmpOs/ValidarDEmpOs/ValidarEmpDs/ValidarDEmpDs) estao
    * definidos mais abaixo, no mesmo padrao de Formsigatcrp.prg:2285-
    * 2445 (ValidarEmp/AbrirBuscaEmp/ValidarDemp/AbrirBuscaDemp).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarFiltro()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Filtro", "Container")
            loc_oCnt = THIS.cnt_4c_Filtro
            WITH loc_oCnt
                .Top         = 134
                .Left        = 6
                .Width       = 699
                .Height      = 89
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            *-- Label2 do dump - titulo de secao em negrito ("Filtro por Empresa").
            loc_oCnt.AddObject("lbl_4c_FiltroEmpresa", "Label")
            WITH loc_oCnt.lbl_4c_FiltroEmpresa
                .Top        = 1
                .Left       = 9
                .Width      = 105
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Filtro por " + "\<" + "Empresa"
                .Visible    = .T.
            ENDWITH

            *-- Say4 do dump - "Origem :".
            loc_oCnt.AddObject("lbl_4c_Origem", "Label")
            WITH loc_oCnt.lbl_4c_Origem
                .Top        = 23
                .Left       = 31
                .Width      = 55
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Origem :"
                .Visible    = .T.
            ENDWITH

            *-- getEmpOs - codigo da empresa de ORIGEM (SigCdEmp.Cemps char(3)).
            loc_oCnt.AddObject("txt_4c_EmpOs", "TextBox")
            WITH loc_oCnt.txt_4c_EmpOs
                .Top           = 19
                .Left          = 88
                .Width         = 31
                .MaxLength     = 3
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- getDEmpOs - razao social da empresa de ORIGEM (SigCdEmp.Razas char(40)).
            loc_oCnt.AddObject("txt_4c_DEmpOs", "TextBox")
            WITH loc_oCnt.txt_4c_DEmpOs
                .Top           = 19
                .Left          = 122
                .Width         = 305
                .Height        = 23
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Say5 do dump - "Destino :".
            loc_oCnt.AddObject("lbl_4c_Destino", "Label")
            WITH loc_oCnt.lbl_4c_Destino
                .Top        = 49
                .Left       = 30
                .Width      = 56
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Destino :"
                .Visible    = .T.
            ENDWITH

            *-- getEmpDs - codigo da empresa de DESTINO.
            loc_oCnt.AddObject("txt_4c_EmpDs", "TextBox")
            WITH loc_oCnt.txt_4c_EmpDs
                .Top           = 45
                .Left          = 88
                .Width         = 31
                .MaxLength     = 3
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- getDEmpDs - razao social da empresa de DESTINO.
            loc_oCnt.AddObject("txt_4c_DEmpDs", "TextBox")
            WITH loc_oCnt.txt_4c_DEmpDs
                .Top           = 45
                .Left          = 122
                .Width         = 305
                .Height        = 23
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oCnt.txt_4c_EmpOs,  "KeyPress", THIS, "ValidarEmpOs")
            BINDEVENT(loc_oCnt.txt_4c_DEmpOs, "KeyPress", THIS, "ValidarDEmpOs")
            BINDEVENT(loc_oCnt.txt_4c_EmpDs,  "KeyPress", THIS, "ValidarEmpDs")
            BINDEVENT(loc_oCnt.txt_4c_DEmpDs, "KeyPress", THIS, "ValidarDEmpDs")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltro")
        ENDTRY
    ENDPROC

    *====================================================================
    * ValidarEmpOs - KeyPress em txt_4c_EmpOs (codigo da empresa ORIGEM).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Cemps; hit preenche DEmpOs,
    *                miss abre picker
    *====================================================================
    PROCEDURE ValidarEmpOs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpOs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpOsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
                SELECT cursor_4c_EmpOsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpOs()
            ENDIF
            IF USED("cursor_4c_EmpOsVal")
                USE IN cursor_4c_EmpOsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaEmpOs - picker por Cemps em SigCdEmp (empresa ORIGEM).
    *====================================================================
    PROCEDURE AbrirBuscaEmpOs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Origem"

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpOs")
                    USE IN cursor_4c_BuscaEmpOs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmpOs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
                        SELECT cursor_4c_BuscaEmpOs
                        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * ValidarDEmpOs - KeyPress em txt_4c_DEmpOs (razao social da empresa
    * ORIGEM). Ativo apenas quando txt_4c_EmpOs esta vazio (equivalente
    * ao When "Return Empty(ThisForm.cntFiltro.getEmpOs.Value)" do dump).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Razas; miss abre picker
    *====================================================================
    PROCEDURE ValidarDEmpOs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaDEmpOs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpOsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
                SELECT cursor_4c_EmpOsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
            ELSE
                THIS.AbrirBuscaDEmpOs()
            ENDIF
            IF USED("cursor_4c_EmpOsVal")
                USE IN cursor_4c_EmpOsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaDEmpOs - picker por Razas em SigCdEmp (empresa ORIGEM).
    *====================================================================
    PROCEDURE AbrirBuscaDEmpOs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Origem"

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Razas"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpOs")
                    USE IN cursor_4c_BuscaEmpOs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
                    "cursor_4c_BuscaEmpOs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
                        SELECT cursor_4c_BuscaEmpOs
                        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * ValidarEmpDs - KeyPress em txt_4c_EmpDs (codigo da empresa DESTINO).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Cemps; hit preenche DEmpDs,
    *                miss abre picker
    *====================================================================
    PROCEDURE ValidarEmpDs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpDs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpDsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
                SELECT cursor_4c_EmpDsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpDs()
            ENDIF
            IF USED("cursor_4c_EmpDsVal")
                USE IN cursor_4c_EmpDsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaEmpDs - picker por Cemps em SigCdEmp (empresa DESTINO).
    *====================================================================
    PROCEDURE AbrirBuscaEmpDs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Destino"

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpDs")
                    USE IN cursor_4c_BuscaEmpDs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmpDs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
                        SELECT cursor_4c_BuscaEmpDs
                        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * ValidarDEmpDs - KeyPress em txt_4c_DEmpDs (razao social da empresa
    * DESTINO). Ativo apenas quando txt_4c_EmpDs esta vazio (equivalente
    * ao When "Return Empty(ThisForm.cntFiltro.getEmpDs.Value)" do dump).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Razas; miss abre picker
    *====================================================================
    PROCEDURE ValidarDEmpDs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaDEmpDs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpDsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
                SELECT cursor_4c_EmpDsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
            ELSE
                THIS.AbrirBuscaDEmpDs()
            ENDIF
            IF USED("cursor_4c_EmpDsVal")
                USE IN cursor_4c_EmpDsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaDEmpDs - picker por Razas em SigCdEmp (empresa DESTINO).
    *====================================================================
    PROCEDURE AbrirBuscaDEmpDs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Destino"

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Razas"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpDs")
                    USE IN cursor_4c_BuscaEmpDs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
                    "cursor_4c_BuscaEmpDs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
                        SELECT cursor_4c_BuscaEmpDs
                        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * ConfigurarComplemento - cnt_4c_Complemento (equivalente a
    * cntComplemento do dump): data de lancamento no destino e
    * tolerancia AU. Geometria/Format/InputMask transcritos do dump
    * (regra CLAUDE.md #49 - Format/InputMask do SCX sao OBRIGATORIOS).
    * Sem lookup - campos simples, so transcricao de propriedades.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarComplemento()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Complemento", "Container")
            loc_oCnt = THIS.cnt_4c_Complemento
            WITH loc_oCnt
                .Top         = 151
                .Left        = 453
                .Width       = 240
                .Height      = 60
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            *-- Say1 do dump - "Lancar em :".
            loc_oCnt.AddObject("lbl_4c_LancarEm", "Label")
            WITH loc_oCnt.lbl_4c_LancarEm
                .Top       = 5
                .Left      = 20
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "La" + "\<" + "n" + CHR(231) + "ar em :"
                .Visible   = .T.
            ENDWITH

            *-- getDtLanc - data de lancamento das operacoes no DESTINO
            *-- (vazia assume a data da origem - this_dDtLanc do BO).
            loc_oCnt.AddObject("txt_4c_DtLanc", "TextBox")
            WITH loc_oCnt.txt_4c_DtLanc
                .Top           = 1
                .Left          = 90
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .ToolTipText   = "Data Para Lan" + CHR(231) + "amento das Opera" + CHR(231) + CHR(245) + "es no Destino (Em Branco Assume a Data da Origem)"
                .BorderColor   = RGB(90, 90, 90)
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- getToleras - tolerancia AU (Format "K"/InputMask "999.99"
            *-- do dump - regra CLAUDE.md #49, transcricao literal).
            loc_oCnt.AddObject("txt_4c_Toleras", "TextBox")
            WITH loc_oCnt.txt_4c_Toleras
                .Top               = 27
                .Left              = 90
                .Width             = 55
                .Height            = 25
                .FontName          = "Courier New"
                .FontSize          = 9
                .Format            = "K"
                .InputMask         = "999.99"
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(90, 90, 90)
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            *-- Say7 do dump - "Tolerancia AU :".
            loc_oCnt.AddObject("lbl_4c_Toleras", "Label")
            WITH loc_oCnt.lbl_4c_Toleras
                .Top       = 32
                .Left      = 3
                .Width     = 75
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "\<" + "Toler" + CHR(226) + "ncia AU :"
                .Visible   = .T.
            ENDWITH

            *-- Say2 do dump - "Gr." (rotulo residual ao lado da tolerancia).
            loc_oCnt.AddObject("lbl_4c_Gr", "Label")
            WITH loc_oCnt.lbl_4c_Gr
                .Top       = 32
                .Left      = 152
                .Width     = 17
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Gr."
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarComplemento")
        ENDTRY
    ENDPROC

    *====================================================================
    * CarregarLista - metodo UNICO de bind/repintura da grade de
    * operacoes candidatas (cursor_4c_Operacoes), chamado por
    * InicializarForm() (cursor ainda vazio, so pinta a casca da grade)
    * e reusado pelo Selecionar() da Fase 7/8 (cursor ja populado).
    *
    * Ordem canonica (regra "Problema 48"/CLAUDE.md): RecordSource (que
    * RESETA Width e Header1.Caption) -> ControlSource de cada coluna ->
    * Width -> Header1.Caption -> GO TOP + Refresh (regra #21 - popular
    * cursor nao repinta a grade por si so). ColumnCount NAO e
    * reatribuido aqui (ja fixo em ConfigurarGrid - regra
    * "SOREDUZIRColumn"); CurrentControl/Sparse do Column1 sao
    * reforcados defensivamente apos o RecordSource.
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_cCursor, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        TRY
            loc_oGrid = THIS.cnt_4c_Grade.grd_4c_Dados

            loc_oGrid.RecordSource = loc_cCursor

            loc_oGrid.Column1.ControlSource = loc_cCursor + ".SelImp"
            *-- Check1 ja foi criado por ConfigurarGrid() - AddObject de novo
            *-- aqui estouraria "Name is already in use" (Column1 e o mesmo
            *-- objeto, nao e recriado). So reforcar as props idempotentes.
            loc_oGrid.Column1.Check1.Caption = ""
            loc_oGrid.Column1.AddObject("Check1", "CheckBox")
            loc_oGrid.Column1.Check1.Caption = ""
            loc_oGrid.Column1.CurrentControl = "Check1"
            loc_oGrid.Column1.Sparse         = .F.
            loc_oGrid.Column1.ReadOnly       = .F.
            loc_oGrid.Column1.Width          = 15

            loc_oGrid.Column2.ControlSource = loc_cCursor + ".Numes"
            loc_oGrid.Column2.Width         = 52
            loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"

            loc_oGrid.Column3.ControlSource = loc_cCursor + ".Datas"
            loc_oGrid.Column3.Width         = 80
            loc_oGrid.Column3.Header1.Caption = "Data"

            loc_oGrid.Column4.ControlSource = loc_cCursor + ".Valos"
            loc_oGrid.Column4.Width         = 104
            loc_oGrid.Column4.Header1.Caption = "Valor"

            loc_oGrid.Column5.ControlSource = loc_cCursor + ".Notas"
            loc_oGrid.Column5.Width         = 75
            loc_oGrid.Column5.Header1.Caption = "Documento"

            loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuars"
            loc_oGrid.Column6.Width         = 85
            loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"

            loc_oGrid.Column7.ControlSource = loc_cCursor + ".ContaOs"
            loc_oGrid.Column7.Width         = 85
            loc_oGrid.Column7.Header1.Caption = "Origem"

            loc_oGrid.Column8.ControlSource = loc_cCursor + ".ContaDs"
            loc_oGrid.Column8.Width         = 85
            loc_oGrid.Column8.Header1.Caption = "Destino"

            loc_oGrid.Column9.ControlSource = loc_cCursor + ".Emps"
            loc_oGrid.Column9.Width         = 37
            loc_oGrid.Column9.Header1.Caption = "Orig."

            loc_oGrid.Column10.ControlSource = loc_cCursor + ".EmpDs"
            loc_oGrid.Column10.Width         = 37
            loc_oGrid.Column10.Header1.Caption = "Dest."

            loc_oGrid.Column11.ControlSource = loc_cCursor + ".Dopes"
            loc_oGrid.Column11.Width         = 242
            loc_oGrid.Column11.ReadOnly      = .F.
            loc_oGrid.Column11.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"

            SELECT (loc_cCursor)
            GO TOP
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarEventosBotoes - BINDEVENT dos botoes de acao (cmg_4c_
    * CmdBtnForm/cmg_4c_CmdBtnGrade/cmd_4c_CmdSelecionar), do checkbox
    * grafico (chk_4c_Fwcheckbox1) e dos 4 handlers da coluna de
    * marcacao da grade (Column1.Check1 - regra CLAUDE.md #46/#18).
    * Chamado ao final de ConfigurarLayout(), depois que todos os
    * controles referenciados ja existem (regra CLAUDE.md "BINDEVENT em
    * objeto que ainda nao existe estoura no proprio bind").
    *====================================================================
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_CmdSelecionar, "Click", THIS, "CmdSelecionarClick")
            BINDEVENT(THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1, "InteractiveChange", THIS, "ChkFwcheckbox1InteractiveChange")
            BINDEVENT(THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm, "Click", THIS, "CmdBtnFormClick")
            BINDEVENT(THIS.cmg_4c_CmdBtnGrade, "Click", THIS, "CmdBtnGradeClick")

            WITH THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "Click",     THIS, "Check1Click")
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "KeyPress",  THIS, "Check1KeyPress")
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "MouseDown", THIS, "Check1MouseDown")
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "MouseUp",   THIS, "Check1MouseUp")
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventosBotoes")
        ENDTRY
    ENDPROC

    *====================================================================
    * AtualizarFiltroNoBO - copia o filtro/periodo/processo/complemento
    * da tela para as properties correspondentes do BO (cntFiltro/
    * cntOperacoes/cntComplemento do legado -> this_cEmpOs/this_cEmpDs/
    * this_dDtIni/this_dDtFin/this_cProcesso/this_nProcessados/
    * this_lExibirMensagens/this_dDtLanc/this_nToleras - ver cabecalho
    * de sigoppopBO.prg). Chamado por CmdSelecionarClick() antes de
    * THIS.this_oBusinessObject.Selecionar().
    *====================================================================
    PROTECTED PROCEDURE AtualizarFiltroNoBO()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_cEmpOs           = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
        loc_oBO.this_cEmpDs           = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
        loc_oBO.this_dDtIni           = ConverterParaData(THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value)
        loc_oBO.this_dDtFin           = ConverterParaData(THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value)
        loc_oBO.this_cProcesso        = ALLTRIM(THIS.cnt_4c_Operacoes.cbo_4c_CmbOperacoes.Value)
        loc_oBO.this_nProcessados     = THIS.cnt_4c_Operacoes.obj_4c_OptProcessados.Value
        loc_oBO.this_lExibirMensagens = (THIS.cnt_4c_Operacoes.chk_4c_ChkMensa.Value = 1)
        loc_oBO.this_dDtLanc          = ConverterParaData(THIS.cnt_4c_Complemento.txt_4c_DtLanc.Value)
        loc_oBO.this_nToleras         = THIS.cnt_4c_Complemento.txt_4c_Toleras.Value
    ENDPROC

    *====================================================================
    * CmdSelecionarClick - equivalente ao Valid legado de cmdSelecionar
    * ("ThisForm.Selecionar()", dump:10713-10715) - migrado para Click
    * (evento confiavel para CommandButton via BINDEVENT neste
    * projeto). Delega a selecao de operacoes candidatas ao BO
    * (Fase 8/8 - ver nota no cabecalho do arquivo) e, com sucesso,
    * repinta a grade e reproduz o bloco de habilitar/desabilitar do
    * legado (dump:10265-10287): trava o filtro/periodo/processo,
    * libera Limpar/Copiar/MarcaTudo/Desmarcar/Documentos/ChkMensa.
    *====================================================================
    PROCEDURE CmdSelecionarClick()
        LOCAL loc_oCnt, loc_dIni, loc_dFin, loc_lProsseguir, loc_oErro

        loc_lProsseguir = .T.

        TRY
            loc_oCnt = THIS.cnt_4c_Operacoes

            *-- Confirmacao de REPROCESSAMENTO (dump:9951-9958): escolher
            *-- "Ja Processadas" avisa que o destino pode receber registros
            *-- duplicados e, recusando, volta a opcao para 1.
            IF loc_oCnt.obj_4c_OptProcessados.Value = 2
                IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
                        CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?" + CHR(13) + ;
                        "Este Processo Poder" + CHR(225) + " Lan" + CHR(231) + "ar Registros Duplicados no Destino no" + CHR(13) + ;
                        "Caso dos Mesmos N" + CHR(227) + "o Terem Sido Anteriormente Exclu" + CHR(237) + "dos.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oCnt.obj_4c_OptProcessados.Value = 1
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Validacao do periodo (dump:9995-10013) - com SetFocus no
            *-- campo recusado, por isso fica aqui e nao no BO.
            IF loc_lProsseguir
                loc_dIni = ConverterParaData(loc_oCnt.txt_4c_DtIni.Value)
                loc_dFin = ConverterParaData(loc_oCnt.txt_4c_DtFin.Value)

                DO CASE
                CASE EMPTY(loc_dIni)
                    MsgAviso("Data Inicial Inv" + CHR(225) + "lida", "")
                    loc_oCnt.txt_4c_DtIni.SetFocus()
                    loc_lProsseguir = .F.

                CASE EMPTY(loc_dFin)
                    MsgAviso("Data Final Inv" + CHR(225) + "lida", "")
                    loc_oCnt.txt_4c_DtFin.SetFocus()
                    loc_lProsseguir = .F.

                CASE loc_dFin < loc_dIni
                    MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial", "")
                    loc_oCnt.txt_4c_DtFin.SetFocus()
                    loc_lProsseguir = .F.
                ENDCASE
            ENDIF

            IF loc_lProsseguir
                THIS.AtualizarFiltroNoBO()
            ENDIF

            IF loc_lProsseguir AND THIS.this_oBusinessObject.Selecionar()
                *-- O Selecionar do BO pode ter MUDADO a tolerancia (vem do
                *-- processo) e recuado a data inicial (processo que copia
                *-- fiscais): a tela tem de refletir isso.
                THIS.BOParaForm()

                THIS.CarregarLista()
                THIS.AplicarOrdemGrade()

                WITH THIS.cnt_4c_Operacoes
                    .txt_4c_DtIni.Enabled                     = .F.
                    .txt_4c_DtFin.Enabled                     = .F.
                    .obj_4c_OptProcessados.Buttons(1).Enabled = .F.
                    .obj_4c_OptProcessados.Buttons(2).Enabled = .F.
                    .cbo_4c_CmbOperacoes.Enabled               = .F.
                    .cmd_4c_CmdSelecionar.Enabled               = .F.
                    .chk_4c_ChkMensa.Enabled                    = .T.
                ENDWITH

                WITH THIS.cnt_4c_Filtro
                    .txt_4c_EmpOs.Enabled  = .F.
                    .txt_4c_DEmpOs.Enabled = .F.
                    .txt_4c_EmpDs.Enabled  = .F.
                    .txt_4c_DEmpDs.Enabled = .F.
                ENDWITH

                WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .T.
                ENDWITH

                WITH THIS.cmg_4c_CmdBtnGrade
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .T.
                    .Buttons(3).Enabled = .T.
                ENDWITH

                THIS.cnt_4c_Grade.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CmdSelecionarClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BOParaForm - devolve a tela os dois valores que o Selecionar() do
    * BO altera, reproduzindo o que o legado faz escrevendo direto no
    * controle de dentro do proprio Selecionar:
    *
    *   this_nToleras -> cnt_4c_Complemento.txt_4c_Toleras
    *       ("ThisForm.cntComplemento.getToleras.Value =
    *         crSigPcOop.Toleras" - dump:9967)
    *   this_dDtIni   -> cnt_4c_Operacoes.txt_4c_DtIni
    *       (processo que copia fiscais recua a data inicial em 5 dias:
    *        "getDtIni.Value = getDtIni.Value - 5" + Refresh -
    *        dump:9969-9974)
    *
    * Par de AtualizarFiltroNoBO (Form -> BO). Chamado por
    * CmdSelecionarClick depois de Selecionar().
    *====================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        THIS.cnt_4c_Complemento.txt_4c_Toleras.Value = loc_oBO.this_nToleras
        THIS.cnt_4c_Complemento.txt_4c_Toleras.Refresh()

        IF !EMPTY(loc_oBO.this_dDtIni)
            THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value = loc_oBO.this_dDtIni
            THIS.cnt_4c_Operacoes.txt_4c_DtIni.Refresh()
        ENDIF
    ENDPROC

    *====================================================================
    * AplicarOrdemGrade - ordena a grade pelo criterio escolhido no
    * Processo de Copia (SigPcOoP.Ordems, lido por Selecionar() em
    * this_nOrdemGrade). Equivalente ao
    * "Select csOperacoes / Set Order To Operacao / Do Case ... Set
    * Order To Data|Nota|Origem|Destino / Go Top" do legado
    * (dump:10251-10263). Os TAGs sao criados com o cursor, em
    * ConfigurarGrid.
    *====================================================================
    PROCEDURE AplicarOrdemGrade()
        LOCAL loc_cCursor, loc_nOrdem, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        TRY
            loc_nOrdem = THIS.this_oBusinessObject.this_nOrdemGrade

            SELECT (loc_cCursor)

            DO CASE
            CASE loc_nOrdem = 2
                SET ORDER TO TAG Data
            CASE loc_nOrdem = 3
                SET ORDER TO TAG Nota
            CASE loc_nOrdem = 4
                SET ORDER TO TAG Origem
            CASE loc_nOrdem = 5
                SET ORDER TO TAG Destino
            OTHERWISE
                SET ORDER TO TAG Operacao
            ENDCASE

            GO TOP
            THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AplicarOrdemGrade")
        ENDTRY
    ENDPROC

    *====================================================================
    * ChkFwcheckbox1InteractiveChange - equivalente ao InteractiveChange
    * legado ("ThisForm.ShowTips = (This.Value = 1)", dump:10727-10729).
    *====================================================================
    PROCEDURE ChkFwcheckbox1InteractiveChange()
        THIS.ShowTips = (THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1.Value = 1)
    ENDPROC

    *====================================================================
    * LimpaSelecao - equivalente ao metodo legado "limpaselecao"
    * (dump:5610-5647): limpa o cursor de operacoes candidatas e
    * devolve o filtro/periodo/processo ao estado inicial (reabilita
    * para nova selecao, desabilita Limpar/Copiar/MarcaTudo/Desmarcar/
    * Documentos/ChkMensa - espelho exato do bloco Enabled do legado).
    * Metodo autossuficiente - nao depende de nenhum metodo do BO ainda
    * nao escrito.
    *====================================================================
    PROCEDURE LimpaSelecao()
        LOCAL loc_cCursor, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
            ENDIF

            WITH THIS.cnt_4c_Operacoes
                .txt_4c_DtIni.Enabled                     = .T.
                .txt_4c_DtFin.Enabled                     = .T.
                .cbo_4c_CmbOperacoes.Enabled               = .T.
                .cmd_4c_CmdSelecionar.Enabled               = .T.
                .obj_4c_OptProcessados.Buttons(1).Enabled = .T.
                .obj_4c_OptProcessados.Buttons(2).Enabled = .T.
                .chk_4c_ChkMensa.Enabled                    = .F.
            ENDWITH

            WITH THIS.cnt_4c_Filtro
                .txt_4c_EmpOs.Enabled  = .T.
                .txt_4c_DEmpOs.Enabled = .T.
                .txt_4c_EmpDs.Enabled  = .T.
                .txt_4c_DEmpDs.Enabled = .T.
            ENDWITH

            WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
            ENDWITH

            WITH THIS.cmg_4c_CmdBtnGrade
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
            ENDWITH

            THIS.CarregarLista()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LimpaSelecao")
        ENDTRY
    ENDPROC

    *====================================================================
    * CmdBtnFormClick - equivalente ao Click de cmdBtnForm (dump:10809-
    * 10897): Value=1 Limpar -> THIS.LimpaSelecao(); Value=2 Copiar ->
    * guarda de selecao (regra CLAUDE.md #50 - "Select SelImp, Count(1)
    * ... Where SelImp ... If Selecionados < 1" do legado, aqui via
    * COUNT TO ... FOR SelImp apos SELECT do alias - regra CLAUDE.md
    * "COUNT TO var IN alias PROIBIDO") seguida de THIS.
    * this_oBusinessObject.Processamento() (Fase 8/8 - ver nota no
    * cabecalho do arquivo); Value=3 Encerrar -> THIS.Release()
    * (equivalente a "ThisForm.Release" do btnSair, dump:10885-10897).
    *====================================================================
    PROCEDURE CmdBtnFormClick()
        LOCAL loc_oGrupo, loc_cCursor, loc_nSelecionados, loc_oErro

        loc_oGrupo  = THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
        loc_cCursor = THIS.this_cCursorOperacoes

        TRY
            DO CASE
            CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
                THIS.LimpaSelecao()

            CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
                loc_nSelecionados = 0
                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    COUNT TO loc_nSelecionados FOR SelImp
                ENDIF

                IF loc_nSelecionados < 1
                    MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Encontrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.cnt_4c_Operacoes.cbo_4c_CmbOperacoes.SetFocus
                ELSE
                    *-- Fecho do legado, comum ao Processamento e ao
                    *-- Financeiro (dump:9933-9934 e 2761-2762): copia
                    *-- concluida devolve a tela ao estado inicial e refaz a
                    *-- selecao, para o usuario ver o que ainda falta copiar.
                    IF THIS.this_oBusinessObject.Processamento()
                        THIS.LimpaSelecao()
                        THIS.CmdSelecionarClick()
                    ENDIF
                ENDIF

            CASE loc_oGrupo.Value = 3
                THIS.Release()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CmdBtnFormClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * CmdBtnGradeClick - equivalente ao Click de cmdBtnGrade (dump:
    * 10488-10513): Value=1 Marca Tudo / Value=2 Desmarcar (REPLACE ALL
    * SelImp na cursor_4c_Operacoes + GO TOP + Refresh) / Value=3
    * Documentos (abre FormSigMvExp para a operacao corrente da grade,
    * ou avisa se Deletado - equivalente a "Do Form SigMvExp With
    * csOperacoes.Dopes, 'C', csOperacoes.Numes, csOperacoes.Emps,
    * .t."). Metodo autossuficiente.
    *====================================================================
    PROCEDURE CmdBtnGradeClick()
        LOCAL loc_oGrupo, loc_cCursor, loc_oForm, loc_oErro

        loc_oGrupo  = THIS.cmg_4c_CmdBtnGrade
        loc_cCursor = THIS.this_cCursorOperacoes

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        TRY
            DO CASE
            CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
                SELECT (loc_cCursor)
                REPLACE ALL SelImp WITH .T.
                GO TOP
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()

            CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
                SELECT (loc_cCursor)
                REPLACE ALL SelImp WITH .F.
                GO TOP
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()

            CASE loc_oGrupo.Value = 3 AND loc_oGrupo.Buttons(3).Enabled
                SELECT (loc_cCursor)
                IF !EOF()
                    IF Deletado
                        MsgAviso("Essa Opera" + CHR(231) + CHR(227) + "o Foi Exclu" + CHR(237) + "da do Sistema!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                    ELSE
                        loc_oForm = CREATEOBJECT("FormSigMvExp", Dopes, "C", Numes, Emps, .T.)
                        IF VARTYPE(loc_oForm) = "O"
                            loc_oForm.Show()
                        ENDIF
                    ENDIF
                ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CmdBtnGradeClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * Check1Click/KeyPress/MouseDown/MouseUp - toggle da marcacao
    * (SelImp) da coluna 1 da grade. NODEFAULT nos 4 (equivalente ao
    * legado, dump:10523-10575): o toggle nativo do CheckBox e
    * SUPRIMIDO e o REPLACE e feito a mao, igual ao legado ("m.SelImp =
    * (Not csOperacoes.SelImp) / Gather Memvar Fields SelImp"), regra
    * CLAUDE.md #46 (Valid/KeyPress da celula, nao AfterRowColChange).
    *====================================================================
    PROCEDURE Check1Click()
        NODEFAULT
    ENDPROC

    PROCEDURE Check1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor

        IF INLIST(par_nKeyCode, 13, 32)
            loc_cCursor = THIS.this_cCursorOperacoes
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE SelImp WITH !SelImp
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE Check1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorOperacoes
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE SelImp WITH !SelImp
            THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
        ENDIF
        NODEFAULT
    ENDPROC

    PROCEDURE Check1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *====================================================================
    * Destroy - fecha o cursor da grade de operacoes e o cursor da lista
    * de Processos de Copia (RowSource do combo) e encadeia para
    * FormBase.Destroy() (libera this_oBusinessObject e restaura o
    * menu principal).
    *====================================================================
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cCursorOperacoes) AND USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF

        IF !EMPTY(THIS.this_cCursorProcessos) AND USED(THIS.this_cCursorProcessos)
            USE IN (THIS.this_cCursorProcessos)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

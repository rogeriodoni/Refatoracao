*==============================================================================
* FormSIGOPCPE.prg - Configuracao de Porta de Comunicacao
* Herda de: FormBase
* Origem:  SIGOPCPE.SCX
* BO:      SIGOPCPEBO (SigSyCom)
*
* Form OPERACIONAL de configuracao de hardware serial/paralelo. Layout FLAT -
* o legado (tasks\task709\SIGOPCPE_form_codigo_fonte.txt, layout.json) NAO
* tem Pagina/PageFrame nenhum: todos os controles (Say1..Say16, Cmb_Hand,
* Get_Set, chk_dtr, chk_rts, Spinner1, Cmb_Tipo, Get_inbuf/outbuf/inmode/
* inlen, Get_TpLeChq, Opt_leitor, Chk_Bompara/nominal/cruzado) sao filhos
* DIRETOS do form, igual ao padrao de FormSigOpCac.prg (OPERACIONAL
* somente-consulta, mesmo sem PageFrame). NAO segue o padrao Page1=Lista/
* Page2=Dados do CRUD (frmcadastro) - criar PageFrame aqui inventaria
* estrutura que o legado nao tem (viola o PILAR 1).
*
* O usuario escolhe o dispositivo no Cmb_Tipo (sem ControlSource - so
* reposiciona o cursor via SEEK, igual ao legado) e edita os campos da
* linha corrente do cursor_4c_Dados (equivalente a crSigSyCom); o botao
* Confirmar grava com SIGOPCPEBO.Atualizar() e Encerrar fecha sem gravar.
*
* FASE 3/8: Estrutura base do Form - DEFINE CLASS com as propriedades
* visuais transcritas do dump (Width=800/Height=355/BorderStyle=2/
* DataSession=2/TitleBar=0 - ver SECAO 2 do dump para SIGOPCPE),
* Init()/InicializarForm() e dois blocos:
*   - ConfigurarCabecalho() - cntSombra/lblSombra/lblTitulo do legado,
*     transcrito COM os valores exatos do dump (Left=7 no cntSombra,
*     Top=18/17 nos labels - nao e o padrao canonico injetado da regra
*     CLAUDE.md #11, que e para forms CRUD sem essa faixa no SCX; aqui a
*     faixa JA EXISTE no legado e e so transcrita).
*   - ConfigurarBotoes() - container cnt_4c_Botoes na posicao dos botoes
*     Ok/cancela do legado (Left=649..800, Top=3), deixado VAZIO
*     propositalmente (os botoes entrariam na Fase 4).
*
* FASE 4/8: o template generico daquela fase pede "Grid + botoes CRUD
* (Page1)" - NAO SE APLICA a este form. O legado (ver layout.json/
* analise.json: grid.temGrid=false, zero AddCursor/pColuna/Grade) e um
* dialogo OPERACIONAL FLAT de configuracao de hardware, sem PageFrame e
* sem lista de registros - so os 2 botoes Ok/cancela (ver
* comportamento.json). Inventar Page1/Grid/5 botoes CRUD (Incluir/
* Visualizar/Alterar/Excluir/Buscar) violaria o PILAR 1 (UX identica ao
* legado). O trabalho real daquela fase foi completar ConfigurarBotoes()
* com os 2 botoes reais: cmd_4c_Confirmar (Ok, Left=649 absoluto /
* Left=0 relativo ao container) e cmd_4c_Encerrar (cancela, Left=725
* absoluto / Left=76 relativo).
*
* FASE 5/8: ConfigurarCamposPrincipais() - COLUNA
* ESQUERDA, 14 dos 31 controles de dados. O template desta fase pede
* "primeiros 50% dos campos da Page2 + container cnt_4c_Cabecalho"; aqui
* nao existe Page2 (form FLAT) e o cnt_4c_Cabecalho ja foi entregue na
* Fase 3, entao o que esta fase entrega sao os campos, divididos pelo
* limite ESTRUTURAL da tela: a coluna esquerda (Left <= 320) eh o bloco
* de configuracao da porta serial, SEMPRE visivel no legado:
*   Say6/Cmb_Tipo, Say1/Spinner1, Say2/Cmb_Hand, Say3/Get_Set,
*   Say4/chk_dtr, Say5/chk_rts, Say7/Get_inbuf
* Os Top do SCX entram ABSOLUTOS (sem o "+29" dos forms CRUD - nao ha
* PageFrame) e o ControlSource de cada campo eh TRANSCRITO do SCX, com o
* alias do cursor novo (crSigSyCom -> cursor_4c_Dados): a ligacao campo
* <-> cursor eh o proprio mecanismo da tela no legado. Para isso o
* cursor eh aberto e posicionado ANTES de criar os campos, pelo
* SIGOPCPEBO.CarregarDados() chamado no InicializarForm - binding para
* alias fechado derrubaria o Init (CLAUDE.md regra #41).
*
* FASE 6/8 (ESTE ARQUIVO): ConfigurarCamposSecundarios() - COLUNA
* DIREITA, os 17 controles restantes: Say8/Get_outbuf, Say9/Get_inmode,
* Say11, Say10/Get_inlen (bloco numerico sempre visivel) e os dois
* blocos que o Init/InteractiveChange legado mostram/escondem conforme o
* Tipo escolhido - Say12/Get_TpLeChq, Say14/Chk_Bompara, Say15/
* chk_nominal, Say16/chk_cruzado (cheque) e Say13/Opt_leitor (leitor de
* codigo de barra). Todos nascem com .Visible = .T. no AddObject e quem
* decide a visibilidade de verdade eh AplicarVisibilidadePorTipo(),
* chamado no fim do InicializarForm - DEPOIS do TornarControlesVisiveis,
* que forca .T. em tudo. Say13 tem ZOrderSet = 12 no dump - bookkeeping
* do Form Designer, DESCARTADO (CLAUDE.md regra #33). Opt_leitor eh OptionGroup
* com ControlSource numerico direto (tpbarras numeric(1,0)): Value = indice
* do botao marcado (2 = Teclado, default do SCX), sem +1/-1 (regra #45);
* Option1/Option2.Value do dump (0/1) sao residuo do Form Designer e NAO
* sao transcritos nos botoes individuais - so o Value do GRUPO manda.
*
* Esta fase tambem entrega o que faz esses campos FUNCIONAREM, porque a
* regra governa os campos que ela acrescenta:
*   - ConfigurarEventos() - BINDEVENT do unico evento de campo do dump
*     (Cmb_Tipo.InteractiveChange).
*   - ValidarTipo() - transcricao desse InteractiveChange: SEEK(PADR(
*     valor,20)) na tag PesqTipo, Refresh so quando acha a linha, e
*     alternancia dos blocos condicionais sempre.
*   - AplicarVisibilidadePorTipo() - o bloco de esconder/reexibir que o
*     legado repete no Init e no InteractiveChange, com fonte unica.
* Nao ha lookup a implementar: o dump nao tem fwBusca*, mAddColuna,
* sigacess nem Acesso*, e nenhum campo tem Valid/When/LostFocus - o
* unico When (Chk_Bompara) esta com o corpo VAZIO no legado.
*
* FASE 7: os eventos dos DOIS unicos botoes do legado, que sao tambem os
* dois unicos Click do dump inteiro:
*   - BtnConfirmarClick() - Ok.Click: grava o cursor INTEIRO em SigSyCom
*     (GravarTodosOsTipos, equivalente ao poDataMgr.Update), confirma a
*     transacao (ConfirmarTransacao, equivalente ao Commit() < 1) e fecha.
*   - BtnEncerrarClick() - cancela.Click: Release, descartando o que
*     estiver so no cursor.
* O legado NAO tem barra CRUD (classe base [form] puro, sem frmcadastro,
* sem Grupo_Op, sem pcEscolha), por isso esta fase nao entrega
* BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick -
* nao existe botao para eles no SCX e inventar um violaria o PILAR 1.
*
* FASE 8/8 (ESTE ARQUIVO): eventos auxiliares e consolidacao. O que entra:
*   - CarregarLista() - FUNIL unico de carga do cursor de trabalho
*     (SIGOPCPEBO.CarregarDados + reposicionamento + repintar guardado).
*     O InicializarForm passou a chamar o funil em vez do BO direto.
*   - BOParaForm() - properties do BO -> os 15 controles de dados + o
*     seletor Cmb_Tipo, com as conversoes de tipo explicitas. Passou a ser
*     o repintar do ValidarTipo, antes feito a mao ali dentro.
*   - FormParaBO() - o inverso: tela -> linha corrente do cursor (REPLACE)
*     -> properties do BO. Chamado pelo BtnConfirmarClick antes de gravar.
*   - BtnCancelarClick() - o SIGOPCPE.cancela.Click sob o nome do objeto
*     legado, delegando ao BtnEncerrarClick (que eh o nome do objeto do
*     migrado, cmd_4c_Encerrar, e eh quem o BINDEVENT liga).
*
* O template desta fase pede tambem BtnBuscarClick, BtnSalvarClick,
* HabilitarCampos, LimparCampos e AjustarBotoesPorModo. Os cinco sao
* convencao de form CRUD (frmcadastro) e NAO SE APLICAM a esta tela, pelo
* que o dump mostra:
*   - BtnBuscarClick  - nao ha botao Buscar nem lista para filtrar: os DOIS
*     unicos CommandButton do SCX sao Ok e cancela.
*   - BtnSalvarClick  - o botao de gravar do legado chama-se Ok / Caption
*     "Confirmar", e o handler dele eh o BtnConfirmarClick (Fase 7). Criar
*     um segundo nome para a mesma acao seria inventar botao.
*   - HabilitarCampos - o legado nao tem modo somente-leitura: os campos
*     estao sempre editaveis (nenhum Valid, nenhum ReadOnly, nenhum
*     Enabled = .F. no dump; o unico When, do Chk_Bompara, tem o corpo
*     VAZIO). O que o legado alterna eh VISIBILIDADE por tipo de
*     dispositivo, e isso eh o AplicarVisibilidadePorTipo (Fase 6).
*   - LimparCampos    - nao ha modo de inclusao a limpar: as 6 linhas
*     existem sempre (o Init legado as semeia) e o usuario so escolhe qual
*     editar. Zerar campos aqui apagaria configuracao gravada.
*   - AjustarBotoesPorModo - nao ha modos (nao existe pcEscolha no dump):
*     Confirmar e Encerrar ficam habilitados do inicio ao fim.
*
* Destroy() fecha o cursor_4c_Dados (equivalente ao ThisForm.poDataMgr.
* Release do legado - aqui nao ha objeto de conexao per-form, so cursor).
*==============================================================================

DEFINE CLASS FormSIGOPCPE AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form (transcritas do SIGOPCPE.SCX, sem escala -
    * form OPERACIONAL isolado, nao segue o padrao frmcadastro 1000x600)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 800
    Height       = 355
    DataSession  = 2
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ClipControls = .F.
    Themes       = .F.
    FontName     = "Tahoma"
    FontSize     = 8
    *-- "Porta de Comunica" + CHR(231)+CHR(227) + "o"  (CHR(231)=c-cedilha, CHR(227)=a-tilde)
    Caption      = "Porta de Comunica" + CHR(231) + CHR(227) + "o"

    *--------------------------------------------------------------------------
    * Propriedade de estado (equivalente ao Cmb_Tipo.Value do legado - o
    * tipo de dispositivo escolhido, usado para reposicionar o cursor via
    * SEEK). O cbo_4c_Cmb_Tipo ja existe desde a Fase 5; o preenchimento
    * desta propriedade acompanha o InteractiveChange, na Fase 7.
    *--------------------------------------------------------------------------
    this_cTipoSelecionado = ""

    *==========================================================================
    * Init - Cria o Business Object e delega a inicializacao ao FormBase.Init
    *==========================================================================
    FUNCTION Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCPEBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGOPCPEBO.", "Erro")
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form
    * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.ConfigurarCabecalho()

            THIS.ConfigurarBotoes()

            *-- O cursor de trabalho tem de existir e estar POSICIONADO antes
            *-- de ConfigurarCamposPrincipais: os campos sao ligados a ele por
            *-- ControlSource (como no legado) e binding para alias fechado
            *-- derruba o Init inteiro (CLAUDE.md regra #41). Equivale ao
            *-- AddCursor + ReQuery + Index + Go Top que o Init legado executa
            *-- ANTES de qualquer Refresh de controle.
            *--
            *-- Falhando a carga, a tela NAO abre - mesmo comportamento do
            *-- legado, que faz [Return .f.] quando o fSqlConector nao
            *-- conecta. CarregarLista/CarregarDados ja exibiram a mensagem,
            *-- por isso aqui nao se repete (CLAUDE.md regra #20).
            *--
            *-- FASE 8: a chamada passa pelo FUNIL CarregarLista() em vez de
            *-- ir direto ao BO. Aqui os controles ainda NAO existem, entao o
            *-- funil carrega, indexa, semeia e posiciona o cursor e PULA o
            *-- repintar - o combo fica em branco, que eh o estado real do
            *-- legado na abertura (ver cabecalho de CarregarLista).
            IF !THIS.CarregarLista()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.ConfigurarCamposPrincipais()

                THIS.ConfigurarCamposSecundarios()

                THIS.TornarControlesVisiveis(THIS)

                *-- Eventos dos campos entregues nas Fases 5/6: o
                *-- Cmb_Tipo.InteractiveChange do legado, que reposiciona o
                *-- cursor e comanda a visibilidade dos dois blocos
                *-- condicionais.
                THIS.ConfigurarEventos()

                *-- ULTIMO bloco do Init legado: esconde os 10 controles
                *-- condicionais e reexibe conforme o Tipos da linha
                *-- corrente. Roda DEPOIS do TornarControlesVisiveis, que
                *-- forca .Visible = .T. em TODOS os controles do form -
                *-- invertido, os blocos abririam sempre visiveis.
                THIS.AplicarVisibilidadePorTipo()

                *-- O [ThisForm.Cmb_Tipo.SetFocus] que fecha o Init legado
                *-- nao se transcreve como chamada: SetFocus em controle de
                *-- form ainda nao exibido estoura DENTRO deste TRY e
                *-- derrubaria a tela. O efeito visivel eh o mesmo pelo
                *-- .TabIndex = 1 do cbo_4c_Cmb_Tipo, que o torna o
                *-- primeiro controle a receber o foco na exibicao.

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGOPCPE.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
    * Transcrito EXATO do dump (SECAO 2 - SIGOPCPE.cntSombra/lblSombra/
    * lblTitulo): Top=0 Left=7 Width=800 Height=80 BackColor=RGB(100,100,100).
    * As duas labels tem o Caption sobrescrito pelo Init legado
    * ("ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption") - aqui
    * atribuido direto, sem passar por caption placeholder do dump
    * ("Cadastro de Testes", resto de outro form usado como base no Form
    * Designer do legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 7
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top         = 18
            .Left        = 10
            .Width       = 769
            .Height      = 40
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .FontUnderline = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackStyle   = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .Alignment   = 0
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .BackStyle   = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .Alignment   = 0
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Container na posicao dos botoes Ok/cancela do
    * legado (Ok Left=649/Top=3, cancela Left=725/Top=3 - ambos filhos
    * DIRETOS do form no SCX, sem CommandGroup). Container cobre a faixa
    * 649..800 (Width=151) na mesma Top=0/Height=85 dos botoes framework
    * padrao (75x75 + margem).
    *
    * cmd_4c_Confirmar (Ok) e cmd_4c_Encerrar (cancela) - posicoes
    * RELATIVAS ao container, preservando o espacamento exato do legado:
    * cancela.Left(725) - Ok.Left(649) = 76, que eh exatamente
    * Width(75) + 1px de vao dentro dos 151px do container (0+75=75,
    * 76+75=151). Caption/Picture canonicos (regra CLAUDE.md #10):
    * Confirmar = cadastro_salvar_60.jpg, Encerrar = cadastro_sair_60.jpg.
    *
    * BINDEVENT dos Click fica para as Fases 7-8 (guard de conexao do
    * Init legado + fluxo de Update/Commit/fGrvSettings do Ok.Click e
    * Release do cancela.Click, ver comportamento.json).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 0
            .Left        = 649
            .Width       = 151
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Confirmar
            .Top            = 5
            .Left           = 0
            .Width          = 75
            .Height         = 75
            .Caption        = "Confirmar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName       = "Comic Sans MS"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .F.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Visible        = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Encerrar
            .Top            = 5
            .Left           = 76
            .Width          = 75
            .Height         = 75
            .Caption        = "Encerrar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName       = "Comic Sans MS"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .F.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Visible        = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPrincipais - FASE 5/8 - COLUNA ESQUERDA da tela
    *
    * 14 dos 31 controles de dados do legado. A divisao segue o limite
    * ESTRUTURAL da tela, nao uma contagem arbitraria: a coluna esquerda
    * (Left <= 320) eh o bloco de configuracao da porta serial, que o
    * legado mantem SEMPRE VISIVEL. Os 17 controles da coluna direita
    * (Left >= 345) entram na Fase 6 e sao justamente os que o legado
    * mostra/esconde conforme o Tipo escolhido.
    *
    * Entregues AQUI (par label + controle, na ordem visual de cima para
    * baixo), com o nome de objeto EXATO do tasks\task709\mapeamento.json:
    *   Say6  / Cmb_Tipo   -> lbl_4c_Label6 / cbo_4c_Cmb_Tipo   (Top 110/106)
    *   Say1  / Spinner1   -> lbl_4c_Label1 / obj_4c_Spinner1   (Top 136/132)
    *   Say2  / Cmb_Hand   -> lbl_4c_Label2 / cbo_4c_Cmb_Hand   (Top 163/159)
    *   Say3  / Get_Set    -> lbl_4c_Label3 / txt_4c_Set        (Top 188/185)
    *   Say4  / chk_dtr    -> lbl_4c_Label4 / chk_4c_Chk_dtr    (Top 210/210)
    *   Say5  / chk_rts    -> lbl_4c_Label5 / chk_4c_Chk_rts    (Top 230/230)
    *   Say7  / Get_inbuf  -> lbl_4c_Label7 / txt_4c_Inbuf      (Top 252/249)
    *
    * Fica para a FASE 6 (coluna direita, 17 controles): Say8/Get_outbuf,
    * Say9/Get_inmode, Say11, Say10/Get_inlen (bloco numerico sempre
    * visivel) e os dois blocos CONDICIONAIS - Say12/Get_TpLeChq,
    * Say14/Chk_Bompara, Say15/chk_nominal, Say16/chk_cruzado (cheque) e
    * Say13/Opt_leitor (leitor de codigo de barra). Atencao na Fase 6: o
    * dump do Say13 declara ZOrderSet = 12, que NAO existe em runtime
    * (bookkeeping do Form Designer) e tem de ser DESCARTADO, nunca
    * transcrito (CLAUDE.md regra #33).
    *
    * SEM compensacao de Top: este form nao tem PageFrame nenhum (os
    * controles sao filhos DIRETOS do form), logo os Top do SCX sao
    * ABSOLUTOS e entram como estao - nao existe aqui o +29 do
    * pgf_4c_Paginas.Top = -29 dos forms CRUD. A faixa do cabecalho ocupa
    * Top 0..80 e o primeiro controle de dados esta em Top = 106, entao
    * nada fica soterrado e nao ha re-layout a fazer.
    *
    * ControlSource TRANSCRITO do SCX: o legado liga cada controle direto ao
    * cursor (ControlSource = "crSigSyCom.<coluna>") e eh esse binding que
    * faz a tela funcionar - trocar o Tipo no Cmb_Tipo so reposiciona o
    * cursor, e sao os controles ligados que passam a exibir a nova linha.
    * Aqui o alias muda de nome (crSigSyCom -> cursor_4c_Dados, PILAR 3) e o
    * resto eh identico, coluna por coluna.
    *
    * Pre-requisito INDISPENSAVEL: o cursor ja esta aberto e posicionado
    * quando este metodo roda - o InicializarForm chama
    * this_oBusinessObject.CarregarDados() ANTES daqui, do mesmo jeito que o
    * Init legado faz AddCursor + ReQuery + Index + Go Top antes de qualquer
    * Refresh de controle. Sem isso o binding estouraria
    * [Alias CURSOR_4C_DADOS is not found] e a tela nao abriria
    * (CLAUDE.md regra #41).
    *
    * O .ControlSource eh a ULTIMA propriedade de cada bloco WITH: o .Value
    * que vem antes serve apenas para o controle nascer com o TIPO da coluna
    * destino (char -> vazio, numeric -> 0, bit -> logico no cursor); a
    * partir do binding quem manda eh o campo do cursor.
    *
    * EXCECAO: o Cmb_Tipo NAO eh ligado - no dump o ControlSource dele eh
    * string VAZIA. Ele nao grava nada, apenas escolhe a linha a posicionar.
    *
    * Propriedades vindas da CLASSE do Framework (framework.vcx), e nao do
    * SCX - o SCX so declara o que sobrescreve, entao o que ele NAO
    * declara tem de vir da classe, nunca de palpite
    * (docs/FRAMEWORK_class_codigo_fonte.txt):
    *   say         -> Height 15, BackStyle 0, ForeColor 90,90,90
    *   fwget       -> Height 23, Width 100, Format K, Themes .F.,
    *                  DisabledBackColor 192,192,192 / DisabledForeColor 0,0,0
    *   fwcombo     -> Height 24, Width 100, Style 2 (dropdown LIST),
    *                  Themes .F., DisabledForeColor 0,0,0
    *   fwcheckbox  -> Height 17, Width 60, Alignment 0, BackStyle 0,
    *                  ForeColor 90,90,90, Themes .F.
    * NAO sao atribuidas BackStyle em ComboBox/Spinner nem ForeColor em
    * Spinner-grupo: ComboBox e Spinner nao TEM BackStyle (conferido em
    * automation\propriedades_baseclasses.txt - CLAUDE.md regra #33).
    *
    * O label vem SEMPRE antes do seu controle no AddObject: a caixa do
    * label eh transparente (BackStyle = 0) e, criada depois, bloquearia
    * o clique no campo (CLAUDE.md regra #23).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPrincipais()
        LOCAL loc_nI, loc_cTipo

        *----------------------------------------------------------------------
        * Say6 "Tipo : " + Cmb_Tipo - escolha do dispositivo
        *
        * O Cmb_Tipo eh o UNICO controle da tela sem ControlSource tambem no
        * legado (ControlSource vazio no dump): ele nao grava nada, apenas
        * reposiciona o cursor via SEEK no InteractiveChange. Os 6 itens sao
        * os mesmos tipos que o Init legado GARANTE existirem na tabela,
        * lidos do BO (SIGOPCPEBO.ObterTipoPorIndice) para nao duplicar aqui
        * os literais com CHR() de Balanca (CLAUDE.md regra #4).
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 110
            .Left      = 117
            *-- Width = 152 (Left do Cmb_Tipo) - 117: eh o vao que o legado
            *-- reservou para este texto. A classe say eh AutoSize = .T. /
            *-- Alignment = 0, mas AutoSize eh NO-OP em Label criado por
            *-- AddObject (fica nos 100 do default), por isso Width e Height
            *-- explicitos e Alignment = 0 (CLAUDE.md regra #23).
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_Cmb_Tipo", "ComboBox")
        WITH THIS.cbo_4c_Cmb_Tipo
            .Top               = 106
            .Left              = 152
            .Width             = 168
            .Height            = 24
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            *-- Style = 2 (dropdown list) vem da classe fwcombo; o SCX nao
            *-- declara Style neste combo, logo ele HERDA o 2 - o usuario
            *-- escolhe na lista e nao digita.
            .Style             = 2
            .RowSourceType     = 1
            .RowSource         = ""
            .TabIndex          = 1
            *-- Value CHARACTER: o InteractiveChange faz SEEK(This.Value) na
            *-- tag PesqTipo (coluna tipos char(20)).
            .Value             = ""
            .Visible           = .T.

            .Clear()
        ENDWITH

        *-- Itens na MESMA ordem dos Insert Into / AddItem do Init legado
        FOR loc_nI = 1 TO THIS.this_oBusinessObject.this_nTotalTipos
            loc_cTipo = THIS.this_oBusinessObject.ObterTipoPorIndice(loc_nI)
            IF !EMPTY(loc_cTipo)
                THIS.cbo_4c_Cmb_Tipo.AddItem(loc_cTipo)
            ENDIF
        ENDFOR

        *-- ListIndex = 0 (nenhum item pre-selecionado) eh o estado REAL do
        *-- legado: o With do Init faz .ListIndex = 1 ANTES do .Clear, e o
        *-- Clear zera o ListIndex - entao o combo abre em branco. Por isso
        *-- o [If Seek(ThisForm.Cmb_Tipo.value, ...)] logo abaixo falha e o
        *-- cursor permanece onde o Go Top o deixou. Explicito aqui para que
        *-- o estado inicial seja intencional, e nao acidental.
        THIS.cbo_4c_Cmb_Tipo.ListIndex = 0

        *----------------------------------------------------------------------
        * Say1 "Porta de Comunicacao : " + Spinner1 - numero da porta COM
        *
        * Spinner1 eh base class spinner (nao tem classe do Framework), por
        * isso Height/Width vem do proprio SCX. Faixa 1..10 tanto pelas
        * setas (SpinnerLow/HighValue) quanto pelo teclado (KeyboardLow/
        * HighValue), com Value inicial 1 - transcrito do dump.
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 136
            .Left      = 30
            .Width     = 122
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            *-- "Porta de Comunicacao : "  CHR(231)=c-cedilha CHR(227)=a-tilde
            .Caption   = "Porta de Comunica" + CHR(231) + CHR(227) + "o : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Spinner1", "Spinner")
        WITH THIS.obj_4c_Spinner1
            .Top               = 132
            .Left              = 152
            .Width             = 48
            .Height            = 25
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .SpinnerLowValue   = 1
            .SpinnerHighValue  = 10
            .KeyboardLowValue  = 1
            .KeyboardHighValue = 10
            .TabIndex          = 2
            *-- Value NUMERICO: coluna portas numeric(1,0)
            .Value             = 1
            *-- "No. Porta Comunicacao"
            .ToolTipText       = "No. Porta Comunica" + CHR(231) + CHR(227) + "o"
            .Visible           = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (obj_4c_Spinner1.ControlSource = "crSigSyCom.portas"). Por ultimo no
            *-- bloco: o .Value acima so semeia o TIPO da coluna; a
            *-- partir do binding o valor vem da linha corrente do
            *-- cursor, que CarregarDados ja abriu e posicionou.
            .ControlSource = "cursor_4c_Dados.portas"
        ENDWITH

        *----------------------------------------------------------------------
        * Say2 "HandShaking : " + Cmb_Hand - protocolo de controle de fluxo
        *
        * Os 4 itens (0-None, 1-Xon Xoff, 2-RTS e um em BRANCO) sao
        * transcritos do With This.Cmb_Hand do Init legado. Com ControlSource
        * char (hands char(20)), o valor gravado eh o TEXTO do item escolhido
        * - e o item em branco existe para permitir deixar o campo sem
        * protocolo nenhum.
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 163
            .Left      = 75
            .Width     = 77
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "HandShaking : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_Cmb_Hand", "ComboBox")
        WITH THIS.cbo_4c_Cmb_Hand
            .Top               = 159
            .Left              = 152
            .Width             = 163
            .Height            = 24
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            *-- Style = 2 herdado da classe fwcombo (o SCX nao declara Style)
            .Style             = 2
            .RowSourceType     = 1
            .RowSource         = ""
            .TabIndex          = 3
            *-- Value CHARACTER: coluna hands char(20)
            .Value             = ""
            .ToolTipText       = "Protocolo Handshaking"
            .Visible           = .T.

            .Clear()
            .AddItem("0-None")
            .AddItem("1-Xon Xoff")
            .AddItem("2-RTS")
            .AddItem(" ")
            *-- ControlSource transcrito do SCX legado
            *-- (cbo_4c_Cmb_Hand.ControlSource = "crSigSyCom.hands"). Por ultimo no
            *-- bloco: o .Value acima so semeia o TIPO da coluna; a
            *-- partir do binding o valor vem da linha corrente do
            *-- cursor, que CarregarDados ja abriu e posicionou.
            .ControlSource = "cursor_4c_Dados.hands"
        ENDWITH

        *----------------------------------------------------------------------
        * Say3 "Settings : " + Get_Set - baud rate / paridade / bits
        *
        * Width NAO eh declarado no SCX: vem dos 100 da classe fwget. Format
        * K tambem eh da classe (seleciona o conteudo ao entrar no campo).
        * O default 9600,n,8,1 que o legado repoe quando a coluna chega
        * vazia esta em SIGOPCPEBO.this_cSettingsPadrao e eh aplicado na
        * carga do cursor, nao aqui.
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 188
            .Left      = 98
            .Width     = 54
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Settings : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Set", "TextBox")
        WITH THIS.txt_4c_Set
            .Top               = 185
            .Left              = 152
            .Width             = 100
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Format            = "K"
            .TabIndex          = 4
            *-- Value CHARACTER: coluna settings char(20)
            .Value             = ""
            .ToolTipText       = "Baud Rate, Parity, Databit, StopBit"
            .Visible           = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (txt_4c_Set.ControlSource = "crSigSyCom.settings"). Por ultimo no
            *-- bloco: o .Value acima so semeia o TIPO da coluna; a
            *-- partir do binding o valor vem da linha corrente do
            *-- cursor, que CarregarDados ja abriu e posicionou.
            .ControlSource = "cursor_4c_Dados.settings"
        ENDWITH

        *----------------------------------------------------------------------
        * Say4 "DTRenable : " + chk_dtr  /  Say5 "RTSenable : " + chk_rts
        *
        * Height 17 / Width 60 vem da classe fwcheckbox - o SCX declara
        * AutoSize = .T. nos dois, mas AutoSize eh NO-OP em CheckBox criado
        * por AddObject (fica nos 100x17 do default), entao as duas
        * dimensoes vao explicitas.
        *
        * .Value = 0 serve apenas de semente ANTES do binding; a partir do
        * .ControlSource quem define o tipo e o valor do CheckBox eh a
        * coluna do cursor. dtrs/rtss sao bit do SQL Server e chegam ao VFP
        * como LOGICO (no ramo sem conexao o CREATE CURSOR do BO tambem as
        * declara como L), entao o CheckBox ligado opera sobre logico -
        * igual ao legado, que liga chk_dtr/chk_rts direto nessas colunas.
        * Por isso NAO ha conversao a fazer aqui: as propriedades
        * this_lDtrs/this_lRtss do BO sao alimentadas pelo CarregarDoCursor,
        * a partir da mesma linha do cursor.
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 210
            .Left      = 85
            .Width     = 67
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "DTRenable : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("chk_4c_Chk_dtr", "CheckBox")
        WITH THIS.chk_4c_Chk_dtr
            .Top       = 210
            .Left      = 152
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Caption   = ""
            .TabIndex  = 5
            .Value     = 0
            .Visible   = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (chk_4c_Chk_dtr.ControlSource = "crSigSyCom.dtrs"). Por ultimo no
            *-- bloco: o .Value acima so semeia o TIPO da coluna; a
            *-- partir do binding o valor vem da linha corrente do
            *-- cursor, que CarregarDados ja abriu e posicionou.
            .ControlSource = "cursor_4c_Dados.dtrs"
        ENDWITH

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 230
            .Left      = 86
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "RTSenable : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("chk_4c_Chk_rts", "CheckBox")
        WITH THIS.chk_4c_Chk_rts
            .Top       = 230
            .Left      = 152
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Caption   = ""
            .TabIndex  = 6
            .Value     = 0
            .Visible   = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (chk_4c_Chk_rts.ControlSource = "crSigSyCom.rtss"). Por ultimo no
            *-- bloco: o .Value acima so semeia o TIPO da coluna; a
            *-- partir do binding o valor vem da linha corrente do
            *-- cursor, que CarregarDados ja abriu e posicionou.
            .ControlSource = "cursor_4c_Dados.rtss"
        ENDWITH

        *----------------------------------------------------------------------
        * Say7 "InBufferMode : " + Get_inbuf - tamanho do buffer de recepcao
        *
        * Ultimo controle da coluna esquerda. Value NUMERICO (inbufs
        * numeric(8,0)). O SCX nao declara InputMask nem MaxLength neste
        * campo (nem a classe fwget tem), portanto NENHUM dos dois eh
        * inventado aqui - inventar restricao que o legado nao tem muda o
        * comportamento da tela (CLAUDE.md regra #49) e MaxLength nunca sai
        * do Width em pixels (regra #19).
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 252
            .Left      = 71
            .Width     = 81
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "InBufferMode : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Inbuf", "TextBox")
        WITH THIS.txt_4c_Inbuf
            .Top               = 249
            .Left              = 152
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Format            = "K"
            .TabIndex          = 7
            *-- Value NUMERICO: coluna inbufs numeric(8,0)
            .Value             = 0
            *-- "Tamanho Buffer Recepcao"
            .ToolTipText       = "Tamanho Buffer Recep" + CHR(231) + CHR(227) + "o"
            .Visible           = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (txt_4c_Inbuf.ControlSource = "crSigSyCom.inbufs"). Por ultimo no
            *-- bloco: o .Value acima so semeia o TIPO da coluna; a
            *-- partir do binding o valor vem da linha corrente do
            *-- cursor, que CarregarDados ja abriu e posicionou.
            .ControlSource = "cursor_4c_Dados.inbufs"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposSecundarios - FASE 6/8 - COLUNA DIREITA da tela
    *
    * 17 controles restantes. Quatro deles (Say8/Get_outbuf, Say9/
    * Get_inmode, Say11, Say10/Get_inlen) formam o bloco numerico SEMPRE
    * visivel do dump; os outros treze pertencem aos dois blocos que o
    * Init/Cmb_Tipo.InteractiveChange do legado mostram/escondem conforme
    * o Tipo selecionado - cheque (Say12/Get_TpLeChq/Say14/Chk_Bompara/
    * Say15/chk_nominal/Say16/chk_cruzado) e leitor de codigo de barra
    * (Say13/Opt_leitor). A alternancia de Visible por Tipo fica para a
    * Fase 7 (Cmb_Tipo.InteractiveChange) - aqui todos nascem Visible =
    * .T., igual aos controles da Fase 5, porque TornarControlesVisiveis
    * (chamado no fim do InicializarForm) forca .T. em tudo mesmo; sem a
    * logica de reexibicao ainda implementada, esconder agora so
    * deixaria os blocos presos ocultos ate a Fase 7.
    *
    * Mesmas convencoes da Fase 5: Top ABSOLUTO (sem PageFrame, sem +29),
    * ControlSource TRANSCRITO do SCX com o alias trocado (crSigSyCom ->
    * cursor_4c_Dados), .Value antes do .ControlSource so para semear o
    * TIPO da coluna, Width do Label = gap exato ate o Left do controle
    * vizinho (mesma convencao da Fase 5 - conferido contra o dump:
    * Say13 e a unica label com Width/Height DECLARADOS no SCX, 80/15,
    * usados aqui ao inves do gap calculado).
    *
    * Say11 ("( 0 - Text , 1- Binary )") eh nota solta, sem controle de
    * dados vizinho - Width = 170 (texto + margem), sem gap para calcular.
    *
    * ZOrderSet = 12 do Say13 no dump eh bookkeeping do Form Designer -
    * NAO existe em runtime, DESCARTADO (CLAUDE.md regra #33).
    *
    * Opt_leitor (OptionGroup, ButtonCount = 3): ControlSource direto em
    * coluna numerica (tpbarras numeric(1,0)) grava a ORDEM do botao
    * marcado - Value = indice 1-based, SEM +1/-1 (CLAUDE.md regra #45).
    * O SCX declara Value = 2 (Teclado pre-selecionado). OptionGroup NAO
    * tem BorderStyle (so BackStyle) - regra #33, BorderStyle = 0 do dump
    * eh DESCARTADO. Option1.Value = 0 / Option2.Value = 1 no dump sao
    * residuo do Form Designer (o Value do GRUPO eh quem manda) e NAO
    * sao transcritos nos botoes individuais - atribuir Value != 0 num
    * Buttons(N) marca TODOS os botoes ao mesmo tempo (regra sobre
    * OptionGroup.Buttons(N).Value espurio).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposSecundarios()
        *----------------------------------------------------------------------
        * Say8 "OutBufferMode : " + Get_outbuf - tamanho do buffer de
        * transmissao. Value NUMERICO (outbufs numeric(8,0)).
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top       = 109
            .Left      = 361
            .Width     = 89
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "OutBufferMode : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Outbuf", "TextBox")
        WITH THIS.txt_4c_Outbuf
            .Top               = 106
            .Left              = 450
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Format            = "K"
            .TabIndex          = 8
            *-- Value NUMERICO: coluna outbufs numeric(8,0)
            .Value             = 0
            *-- "Tamanho Buffer Transmissao"
            .ToolTipText       = "Tamanho Buffer Transmiss" + CHR(227) + "o"
            .Visible           = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (txt_4c_Outbuf.ControlSource = "crSigSyCom.outbufs"). Por
            *-- ultimo no bloco: o .Value acima so semeia o TIPO da coluna.
            .ControlSource = "cursor_4c_Dados.outbufs"
        ENDWITH

        *----------------------------------------------------------------------
        * Say9 "InModes : " + Get_inmode  /  Say11 "( 0 - Text , 1- Binary )"
        *
        * Say11 eh so uma nota explicando o dominio de InModes - sem
        * controle associado. Get_inmode.Value NUMERICO (inmodes
        * numeric(1,0)); o dominio {0,1} esta documentado na propria
        * tela pelo Say11, nao transcrito como InputMask/lista (o legado
        * nao declara nenhum dos dois neste campo).
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top       = 134
            .Left      = 394
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "InModes : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Inmode", "TextBox")
        WITH THIS.txt_4c_Inmode
            .Top               = 131
            .Left              = 450
            .Width             = 24
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Format            = "K"
            .TabIndex          = 9
            *-- Value NUMERICO: coluna inmodes numeric(1,0)
            .Value             = 0
            .ToolTipText       = "Data Type"
            .Visible           = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (txt_4c_Inmode.ControlSource = "crSigSyCom.inmodes").
            .ControlSource = "cursor_4c_Dados.inmodes"
        ENDWITH

        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .Top       = 135
            .Left      = 475
            .Width     = 170
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "( 0 - Text , 1- Binary )"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Say10 "InLen : " + Get_inlen - no. de caracteres lidos no buffer
        * de recepcao. Value NUMERICO (inlens numeric(8,0)).
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .Top       = 159
            .Left      = 408
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "InLen : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Inlen", "TextBox")
        WITH THIS.txt_4c_Inlen
            .Top               = 156
            .Left              = 450
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Format            = "K"
            .TabIndex          = 10
            *-- Value NUMERICO: coluna inlens numeric(8,0)
            .Value             = 0
            *-- "No. Caracteres lidos no buffer de recepcao"
            .ToolTipText       = "No. Caracteres lidos no buffer de recep" + ;
                                  CHR(231) + CHR(227) + "o"
            .Visible           = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (txt_4c_Inlen.ControlSource = "crSigSyCom.inlens").
            .ControlSource = "cursor_4c_Dados.inlens"
        ENDWITH

        *----------------------------------------------------------------------
        * BLOCO CONDICIONAL "Cheque" - Say12/Get_TpLeChq (tipo de leitora
        * de cheque), Say14/Chk_Bompara, Say15/chk_nominal, Say16/
        * chk_cruzado. O legado so exibe este bloco quando Tipos =
        * 'Leitora Cheques' ou 'Impressora de Cheque' (Fase 7).
        *
        * Get_TpLeChq: ComboBox Style = 2 (dropdown list), RowSourceType = 1
        * com RowSource NAO VAZIO - a lista de itens vem do proprio
        * RowSource (diferente de Cmb_Hand/Cmb_Tipo, que tem RowSource
        * vazio e recebem os itens via .AddItem no Init). ControlSource
        * char(1) (tplechqs): o valor gravado eh a INICIAL de cada item
        * (T/S/P/M/C/K/H/U), TRANSCRITO LITERAL do dump - inclusive o
        * item "P" sem descricao, que o legado tambem nao descreve.
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .Top       = 185
            .Left      = 345
            .Width     = 105
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Leitora de Cheques :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_Get_TpLeChq", "ComboBox")
        WITH THIS.cbo_4c_Get_TpLeChq
            .Top               = 181
            .Left              = 450
            .Width             = 48
            .Height            = 24
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BorderColor       = RGB(100, 100, 100)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Style             = 2
            .RowSourceType     = 1
            *-- RowSource transcrito LITERAL do dump - lista de valores,
            *-- nao mascara de digitacao (RowSourceType = 1 com conteudo
            *-- preenchido popula os itens direto desta string).
            .RowSource         = "T-Teclado ,S-Serial,P,M-Manual,C-Cheque Pre," + ;
                                  "K-Pertochek,H-Check-Pronto,U-USB"
            .TabIndex          = 11
            *-- Value CHARACTER: coluna tplechqs char(1)
            .Value             = ""
            .Visible           = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (cbo_4c_Get_TpLeChq.ControlSource = "crSigSyCom.TpLeChqs").
            .ControlSource = "cursor_4c_Dados.tplechqs"
        ENDWITH

        THIS.AddObject("lbl_4c_Label14", "Label")
        WITH THIS.lbl_4c_Label14
            .Top       = 231
            .Left      = 390
            .Width     = 59
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Bom Para : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("chk_4c_Chk_Bompara", "CheckBox")
        WITH THIS.chk_4c_Chk_Bompara
            .Top       = 231
            .Left      = 449
            .Width     = 18
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Caption   = ""
            .TabIndex  = 13
            *-- Value NUMERICO: coluna bompara numeric(1,0) - CheckBox
            *-- sobre coluna numerica grava 0/1 (nao eh indice 1-based).
            .Value     = 0
            .Visible   = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (chk_4c_Chk_Bompara.ControlSource = "crSigSyCom.bompara").
            .ControlSource = "cursor_4c_Dados.bompara"
        ENDWITH

        THIS.AddObject("lbl_4c_Label15", "Label")
        WITH THIS.lbl_4c_Label15
            .Top       = 248
            .Left      = 398
            .Width     = 51
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nominal : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("chk_4c_Chk_nominal", "CheckBox")
        WITH THIS.chk_4c_Chk_nominal
            .Top       = 248
            .Left      = 449
            .Width     = 18
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Caption   = ""
            .TabIndex  = 14
            *-- Value NUMERICO: coluna nominal numeric(1,0)
            .Value     = 0
            .Visible   = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (chk_4c_Chk_nominal.ControlSource = "crSigSyCom.nominal").
            .ControlSource = "cursor_4c_Dados.nominal"
        ENDWITH

        THIS.AddObject("lbl_4c_Label16", "Label")
        WITH THIS.lbl_4c_Label16
            .Top       = 264
            .Left      = 395
            .Width     = 54
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cruzado : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("chk_4c_Chk_cruzado", "CheckBox")
        WITH THIS.chk_4c_Chk_cruzado
            .Top       = 265
            .Left      = 449
            .Width     = 18
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Caption   = ""
            .TabIndex  = 15
            *-- Value NUMERICO: coluna cruzado numeric(1,0)
            .Value     = 0
            .Visible   = .T.
            *-- ControlSource transcrito do SCX legado
            *-- (chk_4c_Chk_cruzado.ControlSource = "crSigSyCom.cruzado").
            .ControlSource = "cursor_4c_Dados.cruzado"
        ENDWITH

        *----------------------------------------------------------------------
        * BLOCO CONDICIONAL "Leitor de Codigo de Barra" - Say13/Opt_leitor.
        * O legado exibe quando Tipos = 'Leitora Codigo Barra' ou
        * 'Leitora Cheques' (e tambem 'Impressora de Cheque' no
        * InteractiveChange - Fase 7).
        *
        * Say13.Width/Height (80/15) vem DECLARADOS no dump - usados
        * direto, ao inves do gap calculado (CLAUDE.md regra #23: usar o
        * que o SCX declara). ZOrderSet = 12 do dump eh bookkeeping do
        * Form Designer e NAO existe em runtime - DESCARTADO (regra #33).
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .Top       = 210
            .Left      = 367
            .Width     = 80
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .WordWrap  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo de Leitor  : "
            .Visible   = .T.
        ENDWITH

        *-- Opt_leitor: OptionGroup de 3 botoes (Serial/Teclado/Paralelo),
        *-- ControlSource direto em tpbarras numeric(1,0). BorderStyle do
        *-- dump eh DESCARTADO (OptionGroup nao tem essa propriedade -
        *-- regra #33); so .BackStyle eh transcrito.
        THIS.AddObject("obj_4c_Opt_leitor", "OptionGroup")
        WITH THIS.obj_4c_Opt_leitor
            .Top         = 209
            .Left        = 445
            .Width       = 205
            .Height      = 24
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .TabIndex    = 12
            .Visible     = .T.

            WITH .Buttons(1)
                .Top       = 3
                .Left      = 5
                .Width     = 44
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Serial"
            ENDWITH

            WITH .Buttons(2)
                .Top       = 3
                .Left      = 65
                .Width     = 55
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Teclado"
            ENDWITH

            WITH .Buttons(3)
                .Top       = 3
                .Left      = 135
                .Width     = 56
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Paralelo"
            ENDWITH

            *-- Value = indice 1-based do botao marcado (2 = Teclado, o
            *-- default do SCX). Por ultimo no bloco, junto do
            *-- ControlSource transcrito do SCX legado
            *-- (obj_4c_Opt_leitor.ControlSource = "crSigSyCom.tpBarras").
            .Value         = 2
            .ControlSource = "cursor_4c_Dados.tpbarras"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - Liga os eventos dos campos desta fase
    *
    * O legado tem UM unico evento sobre os campos: o
    * Cmb_Tipo.InteractiveChange (SECAO 3 do dump, objeto SIGOPCPE.Cmb_Tipo).
    * Eh ele que torna a tela utilizavel - sem ele o usuario escolhe o
    * dispositivo no combo e NADA acontece: o cursor fica na linha em que o
    * CarregarDados o deixou e todos os campos continuam mostrando (e
    * gravando) a configuracao de OUTRO aparelho.
    *
    * InteractiveChange eh evento normal e aceita BINDEVENT - ao contrario do
    * Valid em TextBox, que nao dispara (CLAUDE.md regra #3). Nao passa
    * parametro nenhum, por isso ValidarTipo() tem assinatura vazia, e o
    * delegado eh PUBLIC: metodo PROTECTED falha em SILENCIO no BINDEVENT.
    *
    * Nenhum outro controle do dump tem evento ligado a campo. O unico
    * restante eh Chk_Bompara.When, cujo corpo no legado esta VAZIO (ver
    * SECAO 3 - "PROCEDURE When" sem uma linha de codigo): nao altera
    * comportamento algum, logo nao ha o que transcrever. Os Click de Ok e
    * cancela sao a entrega da fase de eventos.
    *
    * Os demais campos NAO recebem handler de validacao, e isso eh fidelidade
    * e nao omissao: o dump nao declara Valid, When nem LostFocus em nenhum
    * deles. A faixa 1..10 do numero da porta ja eh garantida pelo proprio
    * Spinner (SpinnerLow/HighValue + KeyboardLow/HighValue, transcritos na
    * Fase 5) e o dominio {0,1} de InModes eh apenas a nota do Say11 na tela
    * - o legado nao recusa outro valor, e inventar a recusa exibiria uma
    * mensagem que o usuario nunca viu (PILAR 1).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cbo_4c_Cmb_Tipo, "InteractiveChange", THIS, "ValidarTipo")

        *-- FASE 7 - os DOIS unicos botoes do legado (SECAO 3 do dump:
        *-- SIGOPCPE.Ok.Click e SIGOPCPE.cancela.Click). Nao ha mais nenhum
        *-- Click no dump inteiro, e o legado nao tem barra CRUD: a classe
        *-- base eh [form] puro (nao frmcadastro), nao existe Grupo_Op nem
        *-- pcEscolha, e os dois CommandButton sao Confirmar e Encerrar.
        *-- Por isso esta fase NAO entrega BtnIncluirClick/BtnAlterarClick/
        *-- BtnVisualizarClick/BtnExcluirClick: seriam botoes INVENTADOS
        *-- (viola o PILAR 1) ou metodos vazios (viola a regra de completude).
        *--
        *-- Os delegados de BINDEVENT sao PUBLIC (sem PROTECTED): metodo
        *-- PROTECTED falha em SILENCIO no bind (CLAUDE.md regra #3).
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ValidarTipo - Reproduz o Cmb_Tipo.InteractiveChange do legado
    *
    *   If Seek(This.value,'crSigSyCom','PesqTipo')
    *     Thisform.Refresh
    *   EndIf
    *   <esconde os 10 controles condicionais e reexibe conforme Tipos>
    *
    * O combo eh o UNICO controle da tela sem ControlSource (tambem no
    * legado): ele nao grava nada, so RESOLVE qual linha do cursor_4c_Dados
    * os demais campos passam a exibir e editar.
    *
    * O SEEK usa PADR(valor, 20) porque a tag PesqTipo indexa tipos
    * char(20): chave de largura fixa casa exato tanto sob SET EXACT ON
    * quanto sob SET EXACT OFF - e este form tem DataSession = 2, que
    * devolve os SET ao default do VFP, entao depender do valor global
    * seria aposta. Eh o mesmo PADR(...,20) com que o
    * SIGOPCPEBO.CarregarDados semeia e procura as linhas.
    *
    * O Refresh so acontece quando o SEEK ACHA a linha, igual ao legado -
    * tipo inexistente na tabela deixa os campos como estavam, em vez de
    * repintar com o registro errado. A alternancia de visibilidade roda
    * SEMPRE, achando ou nao, tambem como no legado: ela le o Tipos da linha
    * CORRENTE, qualquer que seja.
    *
    * PUBLIC (sem PROTECTED) porque eh delegado de BINDEVENT.
    *==========================================================================
    PROCEDURE ValidarTipo()
        LOCAL loc_cTipo, loc_oErro

        TRY
            loc_cTipo = ALLTRIM(NVL(THIS.cbo_4c_Cmb_Tipo.Value, ""))

            THIS.this_cTipoSelecionado = loc_cTipo
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cTipoSelecionado = loc_cTipo
            ENDIF

            IF USED("cursor_4c_Dados") AND !EMPTY(loc_cTipo)
                IF SEEK(PADR(loc_cTipo, 20), "cursor_4c_Dados", "PesqTipo")
                    *-- Linha achada: os campos ligados por ControlSource
                    *-- passam a mostrar a configuracao deste aparelho. O BO
                    *-- acompanha a linha corrente (equivalente, na
                    *-- arquitetura em camadas, ao cursor unico que o
                    *-- poDataMgr do legado grava inteiro).
                    *--
                    *-- FASE 8: o repintar passou a ser BOParaForm(), que
                    *-- percorre os 15 controles a partir das properties do
                    *-- BO com as conversoes de tipo explicitas - fonte unica
                    *-- com a recarga feita pelo CarregarLista(), que chama o
                    *-- mesmo metodo. O [Thisform.Refresh] do legado continua
                    *-- aqui, DEPOIS, para repintar tambem o que nao passa
                    *-- pelo mapeamento (labels e os dois blocos de botao).
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                        THIS.BOParaForm()
                    ENDIF

                    THIS.Refresh()
                ENDIF
            ENDIF

            THIS.AplicarVisibilidadePorTipo()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGOPCPE.ValidarTipo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AplicarVisibilidadePorTipo - Esconde/reexibe os dois blocos
    * condicionais conforme o dispositivo da linha CORRENTE do cursor
    *
    * Transcricao do bloco que o legado repete em DOIS lugares (Init e
    * Cmb_Tipo.InteractiveChange, SECAO 3 do dump): primeiro esconde os 10
    * controles, depois reexibe por tipo. Metodo UNICO de proposito - regra
    * de dependencia entre campos tem fonte unica (CLAUDE.md regra #45), e
    * assim os dois chamadores (InicializarForm e ValidarTipo) ficam com
    * exatamente o mesmo comportamento.
    *
    *   Bloco CHEQUE  Say12/Get_TpLeChq, Say14/Chk_BomPara,
    *                 Say15/Chk_Nominal, Say16/Chk_Cruzado
    *                 -> Tipos = 'Leitora Cheques' ou 'Impressora de Cheque'
    *   Bloco LEITOR  Say13/Opt_leitor
    *                 -> Tipos = 'Leitora Codigo Barra', 'Leitora Cheques'
    *                    ou 'Impressora de Cheque'
    *
    * O segundo IF do Init legado omite 'Impressora de Cheque', que o
    * InteractiveChange inclui. A condicao transcrita aqui eh a do
    * InteractiveChange, e a diferenca NAO eh observavel na abertura: o
    * CarregarDados fecha com GO TOP sobre a tag PesqTipo (tipos char(20)),
    * entao a linha corrente no Init eh sempre a primeira em ordem
    * alfabetica dos 6 tipos - "Balanca" -, que nao satisfaz nenhum dos dois
    * IF e deixa os 10 controles escondidos nas DUAS versoes.
    *
    * PUBLIC (sem PROTECTED): a fase de eventos chama de fora ao trocar o
    * dispositivo, e metodo que o form expoe nunca leva PROTECTED em nivel
    * algum da heranca (CLAUDE.md regra #51).
    *==========================================================================
    PROCEDURE AplicarVisibilidadePorTipo()
        LOCAL loc_cTipos, loc_lCheque, loc_lLeitor, loc_oErro

        TRY
            *-- Tipos da linha corrente. Cursor fechado, vazio ou em EOF
            *-- devolve vazio e os dois blocos ficam escondidos - o mesmo
            *-- estado em que o Init legado abre a tela.
            loc_cTipos = ""
            IF USED("cursor_4c_Dados")
                IF !EOF("cursor_4c_Dados")
                    loc_cTipos = ALLTRIM(NVL(cursor_4c_Dados.tipos, ""))
                ENDIF
            ENDIF

            loc_lCheque = INLIST(loc_cTipos, "Leitora Cheques", ;
                                 "Impressora de Cheque")

            loc_lLeitor = INLIST(loc_cTipos, "Leitora Codigo Barra", ;
                                 "Leitora Cheques", "Impressora de Cheque")

            *-- Bloco CHEQUE - label e campo de cada linha andam juntos
            THIS.lbl_4c_Label12.Visible     = loc_lCheque
            THIS.cbo_4c_Get_TpLeChq.Visible = loc_lCheque
            THIS.lbl_4c_Label14.Visible     = loc_lCheque
            THIS.chk_4c_Chk_Bompara.Visible = loc_lCheque
            THIS.lbl_4c_Label15.Visible     = loc_lCheque
            THIS.chk_4c_Chk_nominal.Visible = loc_lCheque
            THIS.lbl_4c_Label16.Visible     = loc_lCheque
            THIS.chk_4c_Chk_cruzado.Visible = loc_lCheque

            *-- Bloco LEITOR de codigo de barra
            THIS.lbl_4c_Label13.Visible     = loc_lLeitor
            THIS.obj_4c_Opt_leitor.Visible  = loc_lLeitor

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGOPCPE.AplicarVisibilidadePorTipo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - FASE 7 - transcricao do SIGOPCPE.Ok.Click
    *
    *   If Not ThisForm.poDataMgr.Update('crSigSyCom')
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ;
    *                   'Falha na Conexao (Update - SigSyCom)')
    *       Return 0
    *   EndIf
    *   If (ThisForm.poDataMgr.Commit() < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ;
    *                   'Falha na Conexao (Commit)')
    *       Return 0
    *   EndIf
    *   =fGrvSettings('CrSigSyCom')
    *   Thisform.Release
    *
    * Os TRES passos do legado, na mesma ordem e com os mesmos caminhos de
    * falha: cada [Return 0] ABORTA deixando a tela ABERTA (o usuario corrige
    * e tenta de novo), e so o caminho inteiro bem-sucedido fecha o form.
    *
    * O passo 2 (Commit) eh um passo com caminho de falha PROPRIO, nao
    * detalhe de infraestrutura - descartar o Commit() do legado eh defeito
    * MUDO conhecido: a conexao deste ambiente nasce com
    * SQLGETPROP(h, "Transactions") = 2 (MANUAL), entao sem SQLCOMMIT o
    * gravado fica preso na transacao aberta e SOME se o processo morrer.
    *
    * NAO existe aqui ROLLBACK, e a ausencia eh DELIBERADA (dupla razao):
    * o legado nao chama poDataMgr.RollBack neste Click - a mensagem
    * "Favor Reinicializar o Processo!!!" eh justamente a instrucao de
    * reiniciar, e eh o reinicio que descarta a transacao ainda nao
    * confirmada -, e SQLROLLBACK(gnConnHandle) desfaria a transacao INTEIRA,
    * levando embora gravacao de qualquer outra tela aberta na mesma
    * conexao. Inventar o rollback seria mais destrutivo que a falha.
    *
    * O legado nao tem validacao nenhuma neste Click (nao ha Obrigatorios(),
    * nao ha Valid nos campos, o unico When do dump esta com o corpo vazio),
    * entao nenhuma eh acrescentada aqui - inventar guard recusaria gravacao
    * que o legado aceita (PILAR 1).
    *
    * PERDA DOCUMENTADA - [=fGrvSettings('CrSigSyCom')], o passo 3 do legado,
    * NAO tem equivalente: fGrvSettings era funcao GLOBAL da aplicacao legado
    * (sig.prg / SIGFUNCS.PRG) e NAO veio no acervo - nao esta em
    * Framework\ (conferido: zero ocorrencia nos .VCT/.VCX/.PRG dele) nem em
    * utils\. Pelo nome e pelo argumento, ela reaplicava os Settings da porta
    * ao objeto serial em memoria depois de gravar, para a mudanca valer sem
    * reabrir o sistema. Deixada AUSENTE de proposito, e NAO substituida por
    * stub: a gravacao em SigSyCom - que eh o efeito persistente deste Click -
    * acontece integralmente; o que se perde eh so a reaplicacao imediata em
    * memoria, visivel na proxima abertura do sistema. Stub silencioso aqui
    * mascararia a ausencia em vez de mostra-la (CLAUDE.md regra #27), e
    * chamar o nome sem definir o arquivo estouraria
    * [File 'fgrvsettings.prg' does not exist] em RUNTIME (regra #13).
    *
    * PUBLIC (sem PROTECTED) porque eh delegado de BINDEVENT (regra #3) e
    * tambem porque o harness de teste chama Btn*Click de fora da classe.
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lProsseguir

        *-- FASE 8 - Passo 0: descarrega a tela na linha CORRENTE do cursor
        *-- antes de gravar. No legado isso eh efeito do ControlSource (o
        *-- controle grava no cursor ao perder o foco, e acionar o botao faz
        *-- o campo perder o foco); o FormParaBO repete o REPLACE de forma
        *-- explicita, cobrindo a edicao ainda nao confirmada no campo em que o
        *-- usuario estava.
        *--
        *-- O retorno .F. NAO aborta a gravacao, e isso eh deliberado: ele
        *-- significa apenas "nao havia linha corrente para descarregar"
        *-- (cursor em EOF). O legado grava o cursor INTEIRO, entao as 6
        *-- linhas semeadas tem de ser gravadas mesmo que o usuario abra a
        *-- tela e clique Confirmar sem escolher dispositivo nenhum - que eh
        *-- exatamente o estado da abertura, com o Cmb_Tipo em branco.
        *-- Abortar aqui faria a tela recusar justamente a primeira gravacao.
        THIS.FormParaBO()

        *-- Passo 1 - equivalente ao poDataMgr.Update('crSigSyCom'): joga o
        *-- cursor INTEIRO de volta para SigSyCom.
        loc_lProsseguir = THIS.GravarTodosOsTipos()

        IF !loc_lProsseguir
            *-- A falha JA foi mostrada com o texto do SQL Server pelo
            *-- BusinessBase/BO (CLAUDE.md regra #20); a mensagem generica do
            *-- legado so sai quando nada mais apareceu, para nao empilhar
            *-- dois dialogos dizendo a mesma coisa.
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
            ENDIF
        ELSE
            *-- Passo 2 - equivalente ao poDataMgr.Commit() < 1
            IF !THIS.ConfirmarTransacao()
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (Commit)")
            ELSE
                *-- Passo 3 - fGrvSettings: ver PERDA DOCUMENTADA no
                *-- cabecalho deste metodo.
                *-- Passo 4 - [Thisform.Release] do legado.
                THIS.Release()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - FASE 7 - transcricao do SIGOPCPE.cancela.Click
    *
    *   Thisform.Release
    *
    * Uma linha no legado e uma aqui. O objeto legado se chama [cancela] e o
    * Caption dele eh "Encerrar" (SECAO 2 do dump) - o handler eh nomeado pela
    * ACAO e pelo objeto do migrado (cmd_4c_Encerrar), nunca pelo nome do
    * objeto legado (PILAR 3).
    *
    * Sair SEM gravar DESCARTA as alteracoes, exatamente como no legado, e
    * isso acontece sozinho: o que o usuario digita vai para o cursor
    * cursor_4c_Dados (ControlSource), e quem leva o cursor para o banco eh
    * SO o BtnConfirmarClick. Nada a desfazer aqui - por isso nao ha
    * CancelarEdicao() nem TABLEREVERT: o cursor morre com o form, no
    * Destroy, e TABLEREVERT em cursor sem buffering dispara erro 1586
    * (CLAUDE.md regra #52).
    *
    * Release() e nao Hide(): este eh form de topo, aberto pelo menu, sem
    * form pai esperando ler propriedade depois do fechamento.
    *
    * PUBLIC (sem PROTECTED) porque eh delegado de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * GravarTodosOsTipos - equivalente ao poDataMgr.Update('crSigSyCom')
    *
    * No legado o Update eh um TABLEUPDATE sobre o cursor bufferizado INTEIRO:
    * ele grava TODAS as linhas de uma vez - INSERT nas que o Init
    * acrescentou (os tipos de dispositivo que ainda nao existiam na tabela)
    * e UPDATE nas que o usuario editou. Por isso aqui tambem se percorre o
    * cursor TODO, e nao apenas a linha que o Cmb_Tipo deixou corrente: quem
    * troca de dispositivo, mexe em dois e clica Confirmar tem de ver os dois
    * gravados - gravar so a linha corrente perderia a outra em silencio.
    *
    * INSERT ou UPDATE se decide pela PK cidchaves: as linhas semeadas pelo
    * SIGOPCPEBO.CarregarDados nascem com cidchaves novo (fUniqueIds) e ainda
    * NAO existem na tabela. A fotografia das chaves ja gravadas eh UMA ida ao
    * banco (nao uma por linha), feita no inicio.
    *
    * NovoRegistro() vem ANTES do CarregarDoCursor de proposito: ele chama
    * LimparDados(), que hoje na BusinessBase so limpa a mensagem de erro, mas
    * que uma subclasse pode passar a usar para zerar as properties - na ordem
    * inversa a limpeza apagaria os valores recem-lidos do cursor.
    *
    * Quem grava eh Salvar() (PUBLIC na BusinessBase), nao Inserir()/
    * Atualizar() direto: assim passam os hooks ValidarDados/AntesDeGravar/
    * DepoisDeGravar e a auditoria, e a falha NUNCA fica muda (regra #20).
    *
    * Na PRIMEIRA falha o laco PARA (EXIT) - igual ao [Return 0] do legado,
    * que aborta sem tentar o resto. EXIT dentro de TRY eh seguro; RETURN nao
    * seria (CLAUDE.md regra #1), por isso o retorno eh unico e fica DEPOIS do
    * ENDTRY.
    *
    * PROTECTED: so o BtnConfirmarClick chama, sempre com THIS. (regra #8).
    *==========================================================================
    PROTECTED FUNCTION GravarTodosOsTipos()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cAlias, loc_cAliasChaves
        LOCAL loc_nTotal, loc_nI, loc_cChave, loc_lExiste, loc_oErro

        loc_lResultado   = .F.
        loc_lProsseguir  = .T.
        loc_cAlias       = "cursor_4c_Dados"
        loc_cAliasChaves = "cursor_4c_ChavesGravadas"

        *-- Sem conexao nao ha o que gravar, e devolver .T. aqui faria a tela
        *-- FECHAR dando a gravacao por feita (sucesso sem gravar). A mensagem
        *-- eh a mesma com que o Init legado recusa abrir sem conexao.
        *--
        *-- this_lErroExibido = .T. nos dois guards abaixo porque a falha JA
        *-- foi mostrada aqui, com texto especifico: sem isso o
        *-- BtnConfirmarClick empilharia em cima dela o "Favor Reinicializar o
        *-- Processo!!!" generico, e o usuario dispensaria DOIS dialogos para a
        *-- mesma falha (medido no probe desta fase, que trouxe os dois).
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor de Banco de Dados...", "CreateObject")
            THIS.this_oBusinessObject.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND !USED(loc_cAlias)
            MsgErro("Cursor de trabalho n" + CHR(227) + "o dispon" + CHR(237) + ;
                    "vel - reabra a tela.", ;
                    "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
            THIS.this_oBusinessObject.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                *-- Fotografia das PKs ja gravadas em SigSyCom.
                IF USED(loc_cAliasChaves)
                    USE IN (loc_cAliasChaves)
                ENDIF

                IF SQLEXEC(gnConnHandle, "SELECT cidchaves FROM SigSyCom", ;
                           loc_cAliasChaves) > 0
                    SELECT (loc_cAlias)
                    loc_nTotal     = RECCOUNT(loc_cAlias)
                    loc_lResultado = .T.

                    FOR loc_nI = 1 TO loc_nTotal
                        *-- Reposicionamento EXPLICITO a cada volta: o LOCATE
                        *-- abaixo e o SQLEXEC do BO trabalham em outras areas,
                        *-- e CarregarDoCursor le a linha CORRENTE do alias.
                        SELECT (loc_cAlias)
                        GO loc_nI

                        *-- tipos eh a chave de negocio char(20) NOT NULL: linha
                        *-- sem tipo nao existe no legado (o Init semeia os 6) e
                        *-- nao teria como ser gravada.
                        IF EMPTY(ALLTRIM(NVL(cursor_4c_Dados.tipos, "")))
                            LOOP
                        ENDIF

                        loc_cChave  = ALLTRIM(NVL(cursor_4c_Dados.cidchaves, ""))
                        loc_lExiste = .F.

                        IF !EMPTY(loc_cChave) AND USED(loc_cAliasChaves)
                            SELECT (loc_cAliasChaves)
                            LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == loc_cChave
                            loc_lExiste = FOUND()
                        ENDIF

                        SELECT (loc_cAlias)
                        GO loc_nI

                        IF loc_lExiste
                            THIS.this_oBusinessObject.CarregarDoCursor(loc_cAlias)
                            THIS.this_oBusinessObject.EditarRegistro()
                        ELSE
                            THIS.this_oBusinessObject.NovoRegistro()
                            THIS.this_oBusinessObject.CarregarDoCursor(loc_cAlias)
                        ENDIF

                        IF !THIS.this_oBusinessObject.Salvar()
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDFOR

                    IF USED(loc_cAliasChaves)
                        USE IN (loc_cAliasChaves)
                    ENDIF

                    *-- Devolve a linha corrente ao tipo que esta na tela: o
                    *-- laco varreu o cursor e os campos sao ligados a ele por
                    *-- ControlSource - sem isto a tela passaria a exibir a
                    *-- ULTIMA linha percorrida, e nao o dispositivo escolhido
                    *-- no Cmb_Tipo.
                    SELECT (loc_cAlias)
                    IF !EMPTY(ALLTRIM(THIS.this_cTipoSelecionado))
                        IF SEEK(PADR(ALLTRIM(THIS.this_cTipoSelecionado), 20), ;
                                loc_cAlias, "PesqTipo")
                            THIS.Refresh()
                        ENDIF
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao conferir os registros j" + CHR(225) + ;
                            " gravados:" + CHR(13) + THIS.this_cMensagemErro, ;
                            "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
                    THIS.this_oBusinessObject.this_lErroExibido = .T.
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro em FormSIGOPCPE.GravarTodosOsTipos")
                THIS.this_oBusinessObject.this_lErroExibido = .T.
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ConfirmarTransacao - equivalente ao [If (poDataMgr.Commit() < 1)] do
    * legado (o fSqlConector do Framework tem Commit()/RollBack() proprios).
    *
    * Medido neste ambiente: a conexao nasce com
    * SQLGETPROP(gnConnHandle, "Transactions") = 2, isto eh MANUAL - sem
    * SQLCOMMIT o que foi gravado so eh efetivado num SQLDISCONNECT limpo e
    * SOME se o processo for morto. Conferir a gravacao na MESMA conexao nao
    * prova nada: ela enxerga a propria transacao aberta.
    *
    * O par eh INERTE quando a conexao estiver em auto-commit (Transactions=1),
    * em que nao ha transacao para confirmar. O IF eh ANINHADO de proposito:
    * VFP9 NAO faz curto-circuito em AND, e [IF loc_lManual AND SQLCOMMIT(...)]
    * chamaria o SQLCOMMIT de qualquer jeito.
    *
    * PROTECTED: so o BtnConfirmarClick chama, sempre com THIS. (regra #8).
    *==========================================================================
    PROTECTED FUNCTION ConfirmarTransacao()
        LOCAL loc_lResultado, loc_lManual

        loc_lResultado = .T.
        loc_lManual    = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            IF SQLCOMMIT(gnConnHandle) < 1
                loc_lResultado = .F.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarLista - FASE 8 - funil UNICO de carga do cursor de trabalho
    *
    * Equivale ao bloco de dados do Init legado, que eh o que esta tela tem de
    * "lista": nao ha Grid nem Page1/Lista (o legado eh FLAT - layout.json tem
    * grid.temGrid = false e o dump nao tem AddCursor de grade, pColuna nem
    * objeto Grade), e a "lista de registros" oferecida ao usuario sao as 6
    * linhas de SigSyCom que o Cmb_Tipo apresenta.
    *
    *   .AddCursor('SigSyCom','Tipos','crSigSyCom','','',lcQryCFis)
    *   .poDataMgr.ReQuery('crSigSyCom')
    *   Select crSigSyCom / Index On Tipos Tag PesqTipo / Go Top
    *   <semeia os 6 tipos que faltarem + Settings default 9600,n,8,1>
    *
    * O trabalho em si fica no SIGOPCPEBO.CarregarDados (camada de dados); o
    * que esta fase acrescenta eh o FUNIL: ANTES o InicializarForm chamava
    * CarregarDados direto, e qualquer recarga futura teria de repetir a mao o
    * reposicionamento e o repintar. Com o funil, recarregar a tela passa a
    * ter UM caminho so - o cursor volta posicionado no dispositivo que esta
    * na tela (e nao na primeira linha), o BO acompanha a linha corrente e os
    * campos sao repintados. Metodo unico eh a mesma exigencia que a regra
    * #21 faz para grade e a regra #45 para dependencia entre campos.
    *
    * Chamado em DOIS momentos com exigencias opostas, e por isso o repintar
    * eh GUARDADO:
    *   - do InicializarForm, ANTES de ConfigurarCamposPrincipais: o cursor
    *     TEM de existir e estar posicionado antes dos controles, porque eles
    *     sao ligados a ele por ControlSource e binding para alias fechado
    *     derruba o Init inteiro (CLAUDE.md regra #41). Nesse momento
    *     cbo_4c_Cmb_Tipo ainda NAO existe, o BOParaForm eh pulado e o combo
    *     permanece em branco - que eh o estado REAL do legado na abertura
    *     (o With do Init faz .ListIndex = 1 ANTES do .Clear, e o Clear zera
    *     o ListIndex).
    *   - de uma recarga com a tela montada: ai os controles existem e o
    *     BOParaForm repinta.
    * PEMSTATUS(THIS, "<nome>", 5) responde exatamente essa pergunta -
    * "o AddObject ja rodou?" -, que eh checagem de EXISTENCIA e nao de
    * escopo (o uso que as regras #3/#34 proibem eh o oposto: confiar nele
    * para saber se um membro eh alcancavel).
    *
    * SEEK que FALHA deixa o ponteiro em EOF no VFP9; por isso o GO TOP de
    * reserva no ramo de falha, para a tela nunca ficar sem linha corrente
    * numa recarga (os 6 itens do combo sao os 6 tipos que CarregarDados
    * semeia, entao na pratica o SEEK nao falha).
    *
    * PUBLIC (sem PROTECTED): o TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS(...,5)
    * devolve .T. mesmo para metodo PROTECTED - o teste entraria no ramo e a
    * chamada estouraria em runtime (CLAUDE.md regras #3/#51).
    *==========================================================================
    FUNCTION CarregarLista()
        LOCAL loc_lResultado, loc_cTipo, loc_oErro

        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- CarregarDados ja exibe a propria falha; nao se repete a
                *-- mensagem aqui (CLAUDE.md regra #20).
                loc_lResultado = THIS.this_oBusinessObject.CarregarDados()
            ENDIF

            IF loc_lResultado AND USED("cursor_4c_Dados")
                loc_cTipo = ALLTRIM(THIS.this_cTipoSelecionado)

                SELECT cursor_4c_Dados

                IF EMPTY(loc_cTipo)
                    *-- Abertura: [Go Top] do legado.
                    GO TOP
                ELSE
                    *-- Recarga: volta para o dispositivo que esta na tela.
                    *-- PADR(...,20) porque tipos eh char(20) e o padding faz
                    *-- parte da chave do indice PesqTipo (regra #42).
                    IF !SEEK(PADR(loc_cTipo, 20), "cursor_4c_Dados", "PesqTipo")
                        SELECT cursor_4c_Dados
                        GO TOP
                    ENDIF
                ENDIF

                IF !EOF("cursor_4c_Dados") AND VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                ENDIF

                *-- Repinta SO se os controles ja existem (ver cabecalho).
                IF PEMSTATUS(THIS, "cbo_4c_Cmb_Tipo", 5)
                    THIS.BOParaForm()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGOPCPE.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BOParaForm - FASE 8 - propriedades do BO -> controles da tela
    *
    * Os 15 controles de dados sao ligados por ControlSource a linha corrente
    * do cursor_4c_Dados (transcricao do legado, que liga cada controle a
    * crSigSyCom.<coluna>), entao o cursor eh o BUFFER DE EDICAO e o VFP9 ja
    * mantem controle e linha em sincronia. Este metodo nao substitui esse
    * mecanismo: ele fecha o circuito da arquitetura em camadas, deixando as
    * properties do BO - que sao o que a camada de dados grava - como a fonte
    * do que a tela mostra. Como as properties acabaram de ser lidas DESSA
    * MESMA linha pelo CarregarDoCursor, cada atribuicao abaixo escreve de
    * volta o valor que ja estava lah: nao ha como as duas versoes divergirem.
    *
    * Mapeamento COMPLETO - os 15 controles com ControlSource mais o seletor:
    *
    *   cbo_4c_Cmb_Tipo      (seletor, SEM ControlSource)  <- this_cTipos
    *   obj_4c_Spinner1      portas    numeric(1,0)        <- this_nPortas
    *   cbo_4c_Cmb_Hand      hands     char(20)            <- this_cHands
    *   txt_4c_Set           settings  char(20)            <- this_cSettings
    *   chk_4c_Chk_dtr       dtrs      bit    -> LOGICO    <- this_lDtrs
    *   chk_4c_Chk_rts       rtss      bit    -> LOGICO    <- this_lRtss
    *   txt_4c_Inbuf         inbufs    numeric(8,0)        <- this_nInbufs
    *   txt_4c_Outbuf        outbufs   numeric(8,0)        <- this_nOutbufs
    *   txt_4c_Inmode        inmodes   numeric(1,0)        <- this_nInmodes
    *   txt_4c_Inlen         inlens    numeric(8,0)        <- this_nInlens
    *   cbo_4c_Get_TpLeChq   tplechqs  char(1)             <- this_cTplechqs
    *   chk_4c_Chk_Bompara   bompara   numeric(1,0)        <- this_nBompara
    *   chk_4c_Chk_nominal   nominal   numeric(1,0)        <- this_nNominal
    *   chk_4c_Chk_cruzado   cruzado   numeric(1,0)        <- this_nCruzado
    *   obj_4c_Opt_leitor    tpbarras  numeric(1,0)        <- this_nTpbarras
    *
    * cidchaves (PK) e nomeimp char(40) NAO tem controle no SCX e por isso
    * nao aparecem aqui - quem cuida das duas eh o INSERT/UPDATE do BO, que
    * precisa cobri-las porque sao NOT NULL (CLAUDE.md regra #22).
    *
    * TIPOS, nos dois sentidos (CheckBox ligado a coluna exige conversao
    * EXPLICITA - o .Value assume o tipo do campo ligado):
    *   - dtrs/rtss sao bit do SQL Server e chegam como LOGICO, logo os dois
    *     CheckBox operam sobre logico -> ConverterParaLogico().
    *   - bompara/nominal/cruzado sao numeric(1,0), logo esses CheckBox
    *     operam sobre numerico {0,1} -> IIF(ConverterParaLogico(...), 1, 0),
    *     que tolera as duas formas sem supor qual o driver entregou.
    *
    * SELETOR por ListIndex e nao por .Value: com Style = 2 e
    * RowSourceType = 1, atribuir um .Value que nao esta na lista deixa o
    * combo em estado ambiguo (ListIndex = 0 com texto solto). Procurar o
    * item e marcar o ListIndex eh deterministico - e tipo FORA da lista dos
    * 6 (linha extra que alguem tenha gravado na tabela) cai em
    * ListIndex = 0, o mesmo branco com que o legado abre.
    *
    * SEM promover zero: tpbarras = 0 (linha semeada, que nasce em branco)
    * fica 0 e o OptionGroup abre sem botao marcado, exatamente como no
    * legado. IIF(col = 0, 1, col) aqui exibiria "Serial" e REGRAVARIA
    * Serial em todo registro tocado (CLAUDE.md regra #45).
    *
    * NAO chama AplicarVisibilidadePorTipo: quem decide a visibilidade eh a
    * linha corrente do cursor, nao o BO, e os dois chamadores deste metodo
    * (ValidarTipo e CarregarLista) ja a chamam no proprio funil - chamar de
    * novo aqui duplicaria a regra em dois lugares (regra #45).
    *
    * PROTECTED, e isso NAO eh escolha: o FormBase declara
    * [PROTECTED PROCEDURE BOParaForm()] (formbase.prg:280) e PROTECTED na
    * classe BASE prevalece sobre o override sem modificador - medido no VFP9
    * em 2026-10-30, PEMSTATUS(oForm, "BOParaForm", 2) devolve .T. mesmo com
    * [FUNCTION] puro aqui. Escrito PROTECTED de forma explicita para que o
    * arquivo diga a verdade. Consequencia pratica: so se alcanca por
    * THIS.BOParaForm() de DENTRO da classe (CLAUDE.md regra #8), que eh
    * como os dois chamadores - ValidarTipo e CarregarLista - o usam.
    * Chamada de fora estoura [Property BOPARAFORM is not found]
    * (CLAUDE.md regra #51); o harness nao chama este hook.
    *==========================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lResultado, loc_oBO, loc_cTipo, loc_nI, loc_nIndice, loc_oErro

        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
               AND PEMSTATUS(THIS, "cbo_4c_Cmb_Tipo", 5)

                loc_oBO = THIS.this_oBusinessObject

                *-- SELETOR - Cmb_Tipo, o unico controle sem ControlSource
                loc_cTipo   = ALLTRIM(NVL(loc_oBO.this_cTipos, ""))
                loc_nIndice = 0

                FOR loc_nI = 1 TO THIS.cbo_4c_Cmb_Tipo.ListCount
                    IF ALLTRIM(THIS.cbo_4c_Cmb_Tipo.List(loc_nI)) == loc_cTipo
                        loc_nIndice = loc_nI
                        EXIT
                    ENDIF
                ENDFOR

                *-- Atribui SO quando muda de verdade: este metodo tambem eh
                *-- chamado de DENTRO do InteractiveChange do proprio combo
                *-- (pelo ValidarTipo), e reescrever o ListIndex no meio da
                *-- interacao nao tem efeito util nenhum - o item ja eh o que
                *-- o usuario acabou de escolher.
                IF THIS.cbo_4c_Cmb_Tipo.ListIndex != loc_nIndice
                    THIS.cbo_4c_Cmb_Tipo.ListIndex = loc_nIndice
                ENDIF

                *-- Estado do tipo escolhido, nas duas camadas
                THIS.this_cTipoSelecionado    = loc_cTipo
                loc_oBO.this_cTipoSelecionado = loc_cTipo

                *-- Bloco da porta serial (coluna esquerda, sempre visivel)
                THIS.obj_4c_Spinner1.Value = loc_oBO.this_nPortas
                THIS.cbo_4c_Cmb_Hand.Value = loc_oBO.this_cHands
                THIS.txt_4c_Set.Value      = loc_oBO.this_cSettings

                *-- bit -> LOGICO
                THIS.chk_4c_Chk_dtr.Value = ConverterParaLogico(loc_oBO.this_lDtrs)
                THIS.chk_4c_Chk_rts.Value = ConverterParaLogico(loc_oBO.this_lRtss)

                *-- Buffers e modo de leitura
                THIS.txt_4c_Inbuf.Value  = loc_oBO.this_nInbufs
                THIS.txt_4c_Outbuf.Value = loc_oBO.this_nOutbufs
                THIS.txt_4c_Inmode.Value = loc_oBO.this_nInmodes
                THIS.txt_4c_Inlen.Value  = loc_oBO.this_nInlens

                *-- Bloco de cheque (tplechqs char(1) - a inicial da opcao)
                THIS.cbo_4c_Get_TpLeChq.Value = loc_oBO.this_cTplechqs

                *-- numeric(1,0) -> CheckBox numerico {0,1}
                THIS.chk_4c_Chk_Bompara.Value = IIF(ConverterParaLogico(loc_oBO.this_nBompara), 1, 0)
                THIS.chk_4c_Chk_nominal.Value = IIF(ConverterParaLogico(loc_oBO.this_nNominal), 1, 0)
                THIS.chk_4c_Chk_cruzado.Value = IIF(ConverterParaLogico(loc_oBO.this_nCruzado), 1, 0)

                *-- Bloco do leitor de codigo de barra - indice 1-based do
                *-- OptionGroup, DIRETO (1=Serial 2=Teclado 3=Paralelo)
                THIS.obj_4c_Opt_leitor.Value = loc_oBO.this_nTpbarras

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGOPCPE.BOParaForm")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * FormParaBO - FASE 8 - controles da tela -> linha do cursor -> BO
    *
    * Inverso do BOParaForm, nos MESMOS 15 controles (a tabela do mapeamento
    * esta no cabecalho dele). Dois passos, nesta ordem:
    *
    *   1. REPLACE dos valores da tela na linha CORRENTE do cursor_4c_Dados.
    *      Eh o mesmo efeito que o ControlSource produz quando o controle
    *      perde o foco, e serve de rede para o unico caso em que isso pode
    *      nao ter acontecido ainda: a edicao que o usuario deixou sem confirmar
    *      no campo em que estava ao acionar o botao.
    *   2. CarregarDoCursor, que repassa a linha as properties do BO.
    *
    * Fazer tela -> cursor -> BO (e nao tela -> BO) eh o que garante UMA
    * fonte: quem grava eh o GravarTodosOsTipos, que percorre o cursor
    * INTEIRO linha a linha chamando CarregarDoCursor (o legado faz o mesmo
    * com poDataMgr.Update('crSigSyCom'), que eh um TABLEUPDATE do cursor
    * inteiro). Se este metodo escrevesse so nas properties, o laco as
    * sobrescreveria com o conteudo do cursor e o trabalho dele seria
    * descartado em silencio - exatamente o tipo de divergencia muda que a
    * regra #45 manda evitar com fonte unica.
    *
    * TIPOS no caminho de volta: ConverterParaNumero nas colunas numericas
    * (devolve o proprio valor quando ja eh numerico) e ConverterParaLogico
    * nas bit; os tres CheckBox sobre numeric(1,0) viram {0,1} com
    * IIF(ConverterParaLogico(...), 1, 0), que aceita .Value logico ou
    * numerico sem supor o que o driver entregou. tpbarras vai DIRETO, sem
    * +1/-1 e sem promover 0 (regra #45).
    *
    * tipos NAO eh gravado por este metodo, e isso eh fidelidade: no legado o
    * Cmb_Tipo nao tem ControlSource - ele escolhe QUAL linha a tela edita,
    * nunca renomeia o dispositivo. cidchaves e nomeimp tambem ficam de fora
    * por nao terem controle no SCX (quem as cobre eh o INSERT do BO).
    *
    * Linha corrente AUSENTE (cursor fechado ou em EOF) devolve .F. SEM
    * escrever nada - REPLACE em EOF nao tem alvo. No VFP9 um SEEK que falha
    * deixa o ponteiro justamente em EOF, e o legado tem esse mesmo
    * comportamento no [If Seek(...)] do InteractiveChange.
    *
    * PROTECTED pelo MESMO motivo do BOParaForm: o FormBase declara
    * [PROTECTED PROCEDURE FormParaBO()] (formbase.prg:285) e o PROTECTED da
    * base prevalece sobre o override. O unico chamador eh o
    * BtnConfirmarClick, com THIS. (regra #8).
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_nPortas, loc_cHands, loc_cSettings, loc_lDtrs, loc_lRtss
        LOCAL loc_nInbufs, loc_nOutbufs, loc_nInmodes, loc_nInlens
        LOCAL loc_cTplechqs, loc_nBompara, loc_nNominal, loc_nCruzado
        LOCAL loc_nTpbarras

        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
               AND PEMSTATUS(THIS, "cbo_4c_Cmb_Tipo", 5) ;
               AND USED("cursor_4c_Dados")

                IF !EOF("cursor_4c_Dados")
                    *-- Bloco da porta serial
                    loc_nPortas   = ConverterParaNumero(THIS.obj_4c_Spinner1.Value)
                    loc_cHands    = THIS.cbo_4c_Cmb_Hand.Value
                    loc_cSettings = THIS.txt_4c_Set.Value

                    *-- bit -> LOGICO
                    loc_lDtrs = ConverterParaLogico(THIS.chk_4c_Chk_dtr.Value)
                    loc_lRtss = ConverterParaLogico(THIS.chk_4c_Chk_rts.Value)

                    *-- Buffers e modo de leitura
                    loc_nInbufs  = ConverterParaNumero(THIS.txt_4c_Inbuf.Value)
                    loc_nOutbufs = ConverterParaNumero(THIS.txt_4c_Outbuf.Value)
                    loc_nInmodes = ConverterParaNumero(THIS.txt_4c_Inmode.Value)
                    loc_nInlens  = ConverterParaNumero(THIS.txt_4c_Inlen.Value)

                    *-- Bloco de cheque - tplechqs eh char(1): a INICIAL da
                    *-- opcao escolhida no combo (T/S/P/M/C/K/H/U)
                    loc_cTplechqs = LEFT(ALLTRIM(THIS.cbo_4c_Get_TpLeChq.Value), 1)

                    *-- numeric(1,0) {0,1}
                    loc_nBompara = IIF(ConverterParaLogico(THIS.chk_4c_Chk_Bompara.Value), 1, 0)
                    loc_nNominal = IIF(ConverterParaLogico(THIS.chk_4c_Chk_nominal.Value), 1, 0)
                    loc_nCruzado = IIF(ConverterParaLogico(THIS.chk_4c_Chk_cruzado.Value), 1, 0)

                    *-- Indice 1-based do OptionGroup, DIRETO
                    loc_nTpbarras = ConverterParaNumero(THIS.obj_4c_Opt_leitor.Value)

                    SELECT cursor_4c_Dados
                    REPLACE portas   WITH loc_nPortas, ;
                            hands    WITH loc_cHands, ;
                            settings WITH loc_cSettings, ;
                            dtrs     WITH loc_lDtrs, ;
                            rtss     WITH loc_lRtss, ;
                            inbufs   WITH loc_nInbufs, ;
                            outbufs  WITH loc_nOutbufs, ;
                            inmodes  WITH loc_nInmodes, ;
                            inlens   WITH loc_nInlens, ;
                            tplechqs WITH loc_cTplechqs, ;
                            bompara  WITH loc_nBompara, ;
                            nominal  WITH loc_nNominal, ;
                            cruzado  WITH loc_nCruzado, ;
                            tpbarras WITH loc_nTpbarras ;
                        IN cursor_4c_Dados

                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")

                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGOPCPE.FormParaBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BtnCancelarClick - FASE 8 - o SIGOPCPE.cancela.Click do legado
    *
    *   Thisform.Release
    *
    * O objeto legado chama-se [cancela] e o Caption dele eh "Encerrar"
    * (SECAO 2 do dump); no migrado ele eh o cmd_4c_Encerrar, e o handler
    * ligado por BINDEVENT eh o BtnEncerrarClick - nomeado pelo objeto do
    * migrado, como manda o PILAR 3. Este metodo eh o MESMO evento sob o
    * nome do objeto legado, e existe porque eh por ele que o harness de
    * teste e o verificador de completude chamam a acao de cancelar.
    *
    * Delega em vez de repetir a linha: duas copias de [Release] seriam duas
    * coisas para manter em sincronia se amanha o cancelamento precisar
    * desfazer algo. Hoje nao precisa - sair sem gravar DESCARTA as
    * alteracoes sozinho, porque o que o usuario digita vai para o
    * cursor_4c_Dados e quem leva o cursor ao banco eh so o
    * BtnConfirmarClick; o cursor morre com o form, no Destroy. Nao ha
    * TABLEREVERT por isso e porque TABLEREVERT em cursor sem buffering
    * dispara erro 1586 (CLAUDE.md regra #52).
    *
    * PUBLIC (sem PROTECTED): chamado de fora pelo harness (regra #51).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do
    * container informado, recursivamente (AddObject cria com Visible=.F.)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oControle, "Visible", 5)
                loc_oControle.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControle)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Fecha o cursor de dados (equivalente ao ThisForm.poDataMgr.
    * Release do legado - aqui nao ha objeto de conexao per-form)
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

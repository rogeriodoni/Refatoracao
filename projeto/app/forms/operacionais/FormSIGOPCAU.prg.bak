*==============================================================================
* FormSIGOPCAU.prg - Consulta de Acessos de Usuario
*==============================================================================
* Tipo: OPERACIONAL (layout customizado, SEM PageFrame, SEM Container)
* Migrado de: SIGOPCAU.SCX
*
* Pilares:
*   UX   -> layout e comportamento o mais proximo possivel do legado (800x600)
*   BD   -> SigCdUsu/SigCdGrA/SigCdAcU/SigCdAcG/SigCdPrg (ver SIGOPCAUBO.prg)
*   CODE -> arquitetura em camadas (FormBase / SIGOPCAUBO)
*
* NOTA (paridade com o legado): o SIGOPCAU eh uma tela de CONSULTA em arvore
* (TreeView) dos acessos (Programas/Parametros/Descricaos) ligados a um
* Usuario ou a um Grupo filtrado - nunca os dois ao mesmo tempo (os
* guards When de GetcUsu/GetDUsu/GetGrupo sao mutuamente exclusivos no
* legado: so um dos dois filtros fica habilitado por vez). O legado
* (tasks\task652\SIGOPCAU_form_codigo_fonte.txt - raiz "Class: form,
* BaseClass: form", SEM BaseClass: pageframe NEM BaseClass: container na
* arvore de objetos) pendura os 7 controles (TreeView, Commandgroup1,
* 2 Label, 3 TextBox) direto na Form, sem Page1(Lista)/Page2(Dados) e sem
* nenhum Container de agrupamento. Inventar PageFrame, Container ou os 6
* botoes CRUD canonicos (Incluir/Visualizar/Alterar/Excluir/Buscar/
* Encerrar) violaria o PILAR 1 e a regra "NUNCA inventar funcionalidade
* que o legado nao tem". A LISTA desta tela eh a ARVORE: o legado desenha
* os nos com AddPictureNode/NodeCargo/NodeExpanded e navega por NodeLevel -
* um Grid nao reproduz expandir/retrair por nivel, que eh a tela inteira.
*
* FASE 3/8 - ESTRUTURA BASE: DEFINE CLASS, propriedade de estado
* this_nNodeExp (espelha a PUBLIC pnNodeExp do form legado - ver RESERVED3/
* ClassInfo do dump: "pnnodeexp / podatamgr / *maketree" sao os UNICOS
* membros customizados; podatamgr eh substituido pelo gnConnHandle global
* do sistema novo, ja usado em SIGOPCAUBO.MontarArvoreAcessos), Init()/
* InicializarForm()/Destroy().
*
* FASE 4/8 - LISTA (ARVORE) + BOTOES + METODO DE CARGA:
*   ConfigurarControles() cria, direto na Form (layout flat sem container,
*   fiel ao legado):
*     lbl_4c_Label1/txt_4c_CUsu/txt_4c_DUsu - filtro por Usuario (codigo+nome)
*     lbl_4c_Label2/txt_4c_Grupo             - filtro por Grupo
*     cmg_4c_Commandgroup1 - 3 botoes: Expandir Niveis / Recolher Niveis /
*                            Encerrar (Command1/Command2/Command3 do legado,
*                            cada um com o proprio Click - NAO o Click do
*                            grupo). Prefixo canonico cmg_4c_ para
*                            CommandGroup (PILAR 3) - mapeamento.json
*                            atualizado junto.
*     obj_4c_TreeView      - arvore hierarquica (controle ActiveX de terceiros,
*                            confirmado "cttree.ocx" embutido no SIGOPCAU.sct,
*                            sem substituto nativo VFP9 - instanciado via
*                            OLEControl("cttree.cttreeview"), guardado em
*                            TRY/CATCH e pulado em gb_4c_ValidandoUI/
*                            gb_4c_ModoTeste. NAO trocar por MSComctlLib.
*                            TreeCtrl: trava o VFP9 num modal de licenca que
*                            TRY/CATCH nao intercepta - mesmo padrao de
*                            FormSIGMVMVT.prg/ConfigurarControles)
*   CarregarDados() - metodo de carga desta tela, equivalente ao PROCEDURE
*                     maketree do legado: pede o cursor de acessos ao
*                     SIGOPCAUBO e desenha a arvore inteira (PopularArvore).
*   BtnExpandirClick/BtnRecolherClick/BtnEncerrarClick - Command1/2/3.Click
*                     do legado, transcritos linha a linha.
*   CUsuGotFocus/GrupoGotFocus - GotFocus de GetcUsu/GetGrupo do legado
*                     (ClearNodes). GetDUsu NAO declara GotFocus no dump.
*
* BINDEVENT so eh registrado para handler que JA existe: medido no VFP9 em
* 2026-10-17 (automation\medir_bindevent_delegate.prg) que BINDEVENT com
* delegate inexistente estoura NA HORA DO BIND com "Property <X> is not
* found." - nao eh resolvido em runtime. Como ConfigurarControles roda
* dentro de InicializarForm, um bind sem handler derrubaria a abertura da
* tela. Por isso os binds de LostFocus (equivalente ao Valid: lookup
* fwBuscaExt contra SigCdUsu/SigCdGrA + remontagem da arvore) entram na
* Fase 6, JUNTO com os respectivos handlers.
*
* O Change/KeyPress/NodeClick do TreeView legado NAO sao reproduzidos: no
* dump os tres corpos estao vazios ou comentados com *!* ("*!* This.
* NodeClick(nIndex)"), isto eh, nao tem comportamento nenhum - criar handler
* para eles seria stub.
*
* As 3 imagens da arvore (Menu1.Bmp = indice 1, x_planilha1.bmp = 2,
* MsgStop1.Gif = 3), carregadas no Init legado via AddImage, sao carregadas
* UMA unica vez em PrepararArvore() sob guarda de this_lImagensArvore:
* AddImage repetido empilharia indices e quebraria os indices fixos 1/2/3
* usados em AddPictureNode - mesmo padrao de PrepararArvore() em
* FormSIGMVMVT.prg.
*
* DESVIO DOCUMENTADO (ja registrado em SIGOPCAUBO.prg): no ramo "filtro por
* Grupo" do legado (maketree, Else final) o SCX repete por engano
* ThisForm.GetcUsu.Value (sempre vazio nesse ramo) no lugar de
* ThisForm.GetGrupo.Value - typo que faz a busca por Grupo nunca trazer
* nada no legado. O BO usa this_cGrupos (o campo correto), preservando a
* INTENCAO da consulta.
*
* FASE 5/8 - AUDITORIA DE PROPRIEDADES: este legado eh FLAT e SEM Page2 de
* Dados (ver nota acima sobre a arvore de objetos nao ter PageFrame nem
* Container), e a Fase 4 ja criou os 7 controles de uma vez so dentro de
* ConfigurarControles() - nao ha campo NOVO para "a primeira metade"
* acrescentar (inventar Page2/ConfigurarPaginaDados violaria o PILAR 1 e a
* regra "NUNCA inventar estrutura que o legado nao tem"). O trabalho real
* desta fase foi conferir, propriedade a propriedade, o que a Fase 4
* transcreveu contra a SECAO 2 do dump: faltava .AutoSize = .T. em
* cmg_4c_Commandgroup1 (unica lacuna - os TabIndex de lbl_4c_Label1/Label2
* foram deliberadamente NAO transcritos, porque Label nao tem TabStop e
* numera-los so embaralharia a ordem dos controles que de fato param o Tab).
*
* FASE 6/8 - LOOKUPS: implementa os tres PROCEDURE Valid do legado
* (GetcUsu/GetDUsu/GetGrupo), que a Fase 4 deixou para esta fase (ver nota
* acima sobre BINDEVENT exigir delegate ja existente):
*   ValidarCUsu/ValidarCUsuExec   - LostFocus de txt_4c_CUsu (busca por
*                                   codigo em SigCdUsu via AbrirBuscaUsuario)
*   ValidarDUsu/ValidarDUsuExec   - LostFocus de txt_4c_DUsu (mesma busca,
*                                   mas pela coluna nComps - nome)
*   ValidarGrupo/ValidarGrupoExec - LostFocus de txt_4c_Grupo (busca em
*                                   SigCdGrA via AbrirBuscaGrupo)
*   AbrirBuscaUsuario/AbrirBuscaGrupo - abrem FormBuscaAuxiliar (contrato da
*                                   regra CLAUDE.md #37: Init ja tenta match
*                                   exato; Show() so quando NAO achou).
*   AtualizarHabilitacaoFiltros  - equivalente aos tres guards When do
*                                   legado (GetcUsu/GetGrupo mutuamente
*                                   exclusivos; GetDUsu so digitavel quando
*                                   os dois outros estao vazios) - ver nota
*                                   no topo do arquivo.
* Todos ligados por LostFocus (nunca KeyPress sem testar a tecla - regra
* CLAUDE.md #47), com guarda de reentrancia this_lEmLookup (regra #37): o
* picker e MODAL e tira o foco do campo, o que poderia redisparar o proprio
* LostFocus.
*
* FASE 7/8 - EVENTOS PRINCIPAIS: NAO adiciona BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick. O legado (SIGOPCAU.SCX) nao e um
* frmcadastro - a arvore de objetos (ver nota no topo do arquivo) nao tem
* Grupo_Op nem pcEscolha propria, e o unico CommandGroup do dump
* (Commandgroup1, ButtonCount = 3) ja foi transcrito na Fase 4 como
* BtnExpandirClick/BtnRecolherClick/BtnEncerrarClick - esses SAO os "eventos
* principais dos botoes" desta tela. Inventar os 4 metodos CRUD canonicos
* violaria o PILAR 1 e a regra "NUNCA inventar funcionalidade que o legado
* nao tem" (seriam stubs disfarcados, sem nenhum Click correspondente no
* SCX original para transcrever).
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL: NAO adiciona
* BtnBuscarClick/BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
* HabilitarCampos/LimparCampos/CarregarLista/AjustarBotoesPorModo. Esse
* conjunto eh convencao do form CRUD (frmcadastro: Page1=Lista populada por
* CarregarLista + Page2=Dados com modo INCLUIR/ALTERAR/VISUALIZAR
* transferido por FormParaBO/BOParaForm e descartavel por
* BtnCancelarClick). O SIGOPCAU nao tem nenhuma dessas pecas no legado (ver
* nota no topo do arquivo: raiz "Class: form, BaseClass: form", sem
* PageFrame nem pcEscolha) e cada uma ja tem o equivalente real, construido
* nas fases anteriores, com o nome que reflete o que de fato faz:
*
*   BtnBuscarClick    -> nao existe botao "Buscar" no legado. O papel de
*                        buscar/filtrar jah eh cumprido pelos tres LostFocus
*                        de lookup (ValidarCUsu/ValidarDUsu/ValidarGrupo,
*                        Fase 6), que disparam CarregarDados() a cada filtro
*                        resolvido - exatamente como o Valid do legado
*                        encadeia no MakeTree.
*   BtnSalvarClick    -> o legado nao persiste NADA (SIGOPCAUBO.prg, cabecalho:
*                        "o legado nao faz nenhum Insert/Update/Delete em
*                        tabela"). Inventar um botao de gravar violaria o
*                        PILAR 1 e a regra "NUNCA inventar funcionalidade
*                        que o legado nao tem".
*   BtnCancelarClick  -> eh o Cancelar da Page2 de Dados (descarta edicao em
*                        andamento). Nao ha Page2, nem modo de edicao, nem
*                        edicao para descartar - so uma consulta.
*   FormParaBO/
*   BOParaForm        -> transferem TODOS os campos de uma ficha indo/vindo
*                        do BO em bloco, convencao do par Page2+modo do
*                        frmcadastro. Aqui a transferencia eh por CAMPO
*                        INDIVIDUAL dentro de CarregarDados() (que faz
*                        .this_cUsuarios = loc_cUsuario / .this_cNComps =
*                        ... / .this_cGrupos = loc_cGrupo), porque cada
*                        filtro dispara a consulta por si so (regra mutua-
*                        mente exclusiva de AtualizarHabilitacaoFiltros) -
*                        nao existe "a ficha toda" para mapear de uma vez.
*   HabilitarCampos   -> equivalente real: AtualizarHabilitacaoFiltros()
*                        (Fase 4), que reproduz os tres guards When do
*                        legado (GetcUsu/GetGrupo mutuamente exclusivos,
*                        GetDUsu condicionado aos dois). Nao ha modo
*                        INCLUIR/ALTERAR/VISUALIZAR para alternar - o
*                        habilitar/desabilitar aqui depende do CONTEUDO dos
*                        campos, nao de um modo de tela.
*   LimparCampos      -> equivalente real: LimparArvore() (Fase 4/6),
*                        chamado no GotFocus dos filtros (CUsuGotFocus/
*                        GrupoGotFocus), tal como o legado limpa a arvore ao
*                        voltar para o campo ("m.loTree1.ClearNodes").
*   CarregarLista     -> equivalente real: CarregarDados() (Fase 3/4), que
*                        popula a arvore (a LISTA desta tela, ver nota no
*                        topo do arquivo) chamando SIGOPCAUBO.
*                        MontarArvoreAcessos() e desenhando os nos em
*                        PopularArvore() - o mesmo papel de CarregarLista,
*                        com o nome refletindo que a superficie eh arvore,
*                        nao grid.
*   AjustarBotoesPorModo -> nao ha MODO de tela (LISTA/INCLUIR/ALTERAR/
*                        VISUALIZAR) para os tres botoes (Expandir/
*                        Recolher/Encerrar) reagirem a - eles ficam
*                        habilitados o tempo todo, como no legado (nenhum
*                        dos tres Command1/2/3.Click do SCX testa pcEscolha
*                        ou modo nenhum).
*
* Inventar os nove nomes canonicos criaria NOVE metodos vazios ou stubs
* disfarcados (proibido pela regra de completude) para uma superficie que o
* legado nao tem - a mesma armadilha que a Fase 7 ja evitou com os quatro
* botoes CRUD. O form, atraves da Fase 7, ja estava completo e funcional;
* esta fase nao modifica logica, so documenta a equivalencia acima para que
* a decisao fique auditavel no mesmo padrao de comentario das fases
* anteriores.
*
* CHAMADA (menu.prg):
*   loForm = CREATEOBJECT("FormSIGOPCAU")
*   loForm.Show()
*==============================================================================

DEFINE CLASS FormSIGOPCAU AS FormBase

    *-- Dimensoes e comportamento identicos ao legado (SIGOPCAU.SCX)
    Height      = 600
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    DataSession = 2
    ShowTips    = .T.

    *-- Canonico do projeto para form aberto via menu.prg (CREATEOBJECT +
    *-- variavel LOCAL + Show()) - NAO transcrever o WindowType=0 implicito
    *-- do baseclass "form" do SCX: Show() modeless retorna na hora, a
    *-- referencia local cai e o Destroy dispara antes do usuario ver a
    *-- tela (435 dos 459 forms do projeto usam este par).
    WindowType = 1
    ShowWindow = 1

    *-- ThisForm.pnNodeExp do legado - nivel de expansao corrente da arvore,
    *-- usado por Command1(Expandir)/Command2(Recolher).
    this_nNodeExp = 0

    *-- Guarda de carga unica das 3 imagens da arvore (ver cabecalho).
    this_lImagensArvore = .F.

    *-- Guarda de reentrancia dos lookups (regra CLAUDE.md #47/#37): o
    *-- picker (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que
    *-- poderia redisparar o proprio LostFocus. So um dos tres campos pode
    *-- estar em foco por vez, entao uma flag unica compartilhada basta.
    this_lEmLookup = .F.

    *==========================================================================
    * Init - FormBase.Init() (via DODEFAULT) chama InicializarForm() e
    * aplica os SETs de data/hora da DataSession privada (regra CLAUDE.md
    * #9.4 - obrigatorio por este form ter DataSession = 2).
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o Business Object, reinicializa o estado
    * de navegacao da arvore e cria os controles visuais.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCAUBO")

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Falha ao criar SIGOPCAUBO", "Erro")
        ELSE
            THIS.Caption = "Consulta de Acessos de Usu" + CHR(225) + "rio"

            *-- Picture = ..\framework\imagens\new_background.jpg no legado -
            *-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
            *-- #27/Pattern #170 - NUNCA gc_4c_CaminhoBase + "Framework\...").
            IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")
                THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
            ENDIF

            *-- Reinicializa o estado de navegacao da arvore (equivalente ao
            *-- "ThisForm.pnNodeExp = 0" ao final do maketree legado).
            THIS.this_nNodeExp = 0

            THIS.ConfigurarControles()
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarControles - Cria os controles visuais da tela (layout FLAT,
    * sem PageFrame/Container, direto na Form - fiel ao SIGOPCAU.SCX, ver
    * nota no cabecalho do arquivo sobre a ausencia de PageFrame/Container
    * no legado). Propriedades transcritas da SECAO 2 do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_oErrOle

        *-- lbl_4c_Label1 "Usuario : " (classe label do legado - AutoSize=.T.
        *-- no SCX eh no-op em Label criado por AddObject, regra CLAUDE.md
        *-- #23: transcrever Width/Height do dump em vez de confiar nisso)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 144
            .Left      = 286
            .Width     = 64
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Caption   = "Usu" + CHR(225) + "rio : "
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CUsu (GetcUsu) - codigo do usuario filtrado
        THIS.AddObject("txt_4c_CUsu", "TextBox")
        WITH THIS.txt_4c_CUsu
            .Top       = 141
            .Left      = 348
            .Width     = 96
            .Height    = 23
            .Alignment = 0
            .FontName  = "Courier New"
            .Format    = "!"
            .MaxLength = 10
            .TabIndex  = 2
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DUsu (GetDUsu) - nome do usuario (preenchido pelo lookup)
        THIS.AddObject("txt_4c_DUsu", "TextBox")
        WITH THIS.txt_4c_DUsu
            .Top       = 141
            .Left      = 446
            .Width     = 298
            .Height    = 23
            .Alignment = 0
            .FontName  = "Courier New"
            .Format    = "!"
            .MaxLength = 30
            .TabIndex  = 3
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label2 "Grupo : "
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 144
            .Left      = 50
            .Width     = 53
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Caption   = "Grupo : "
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Grupo (GetGrupo) - codigo do grupo filtrado
        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Top       = 140
            .Left      = 102
            .Width     = 144
            .Height    = 24
            .Alignment = 0
            .FontName  = "Courier New"
            .Format    = "!"
            .MaxLength = 10
            .TabIndex  = 1
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- cmg_4c_Commandgroup1 - Expandir Niveis / Recolher Niveis / Encerrar
        *-- (cada Buttons(N) tem o proprio Click no legado - Command1.Click/
        *-- Command2.Click/Command3.Click - NAO o Click do grupo).
        *-- CommandGroup NAO tem ForeColor (regra CLAUDE.md #33): a cor mora
        *-- nos Buttons(N), exatamente como o SCX declara.
        THIS.AddObject("cmg_4c_Commandgroup1", "CommandGroup")
        WITH THIS.cmg_4c_Commandgroup1
            .ButtonCount   = 3
            *-- AutoSize = .T. no dump (regra CLAUDE.md #33 - CommandGroup
            *-- NAO eh Label: aqui a propriedade EH funcional, recalcula
            *-- Width/Height a partir da geometria dos Buttons(N). Inofensivo
            *-- aqui porque 256x110 abaixo JA eh o resultado desse calculo
            *-- (Button3: Left=171+Width=80=251 +5 de margem = 256; Height:
            *-- Top=5+Height=100+5 de margem = 110).
            .AutoSize      = .T.
            .Top           = 7
            .Left          = 528
            .Height        = 110
            .Width         = 256
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .TabIndex      = 5

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 5
                .Height      = 100
                .Width       = 80
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "expandcl.bmp"
                .Caption     = "Expandir Niveis"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .ToolTipText = "Expandir Niveis"
                .Themes      = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top         = 5
                .Left        = 88
                .Height      = 100
                .Width       = 80
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "collapsecl.bmp"
                .Caption     = "Recolher Niveis"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .ToolTipText = "Recolher Niveis"
                .Themes      = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top         = 5
                .Left        = 171
                .Height      = 100
                .Width       = 80
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "Encerrar"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .ToolTipText = "Sair"
                .Themes      = .F.
            ENDWITH

            .Value   = 1
            .Visible = .T.
        ENDWITH

        *-- BINDEVENT exige que o metodo delegate JA exista e seja PUBLIC
        *-- (regra CLAUDE.md #3 + medicao de 2026-10-17 citada no cabecalho).
        BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnExpandirClick")
        BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnRecolherClick")
        BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")

        *-- GotFocus dos campos de filtro (ClearNodes, igual ao legado - so
        *-- GetcUsu e GetGrupo declaram esse evento no dump).
        BINDEVENT(THIS.txt_4c_CUsu,  "GotFocus", THIS, "CUsuGotFocus")
        BINDEVENT(THIS.txt_4c_Grupo, "GotFocus", THIS, "GrupoGotFocus")

        *-- Lookup (equivalente ao Valid do legado - fwBuscaExt contra
        *-- SigCdUsu/SigCdGrA). Vai em "LostFocus" (ao SAIR do campo), nunca
        *-- em "KeyPress" sem testar a tecla (regra CLAUDE.md #47: picker
        *-- ligado a KeyPress sem guard abre a CADA tecla digitada).
        BINDEVENT(THIS.txt_4c_CUsu,  "LostFocus", THIS, "ValidarCUsu")
        BINDEVENT(THIS.txt_4c_DUsu,  "LostFocus", THIS, "ValidarDUsu")
        BINDEVENT(THIS.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupo")

        *-- Estado inicial dos guards de exclusividade mutua (GetcUsu.When/
        *-- GetGrupo.When/GetDUsu.When do legado - ver AtualizarHabilitacaoFiltros).
        THIS.AtualizarHabilitacaoFiltros()

        *-- obj_4c_TreeView - NAO instanciar em modo teste: AddObject
        *-- OLEControl pode travar sem usuario, e o OCX pode nao estar
        *-- registrado na maquina de build - nesse caso a arvore fica
        *-- ausente mas o resto da tela funciona (guard em TRY/CATCH, sem
        *-- impedir a abertura do form - ver ArvoreDisponivel()).
        IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
           (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
            TRY
                THIS.AddObject("obj_4c_TreeView", "OLEControl", "cttree.cttreeview")
                WITH THIS.obj_4c_TreeView
                    .Top      = 169
                    .Left     = 29
                    .Height   = 406
                    .Width    = 738
                    .TabIndex = 4
                    .Visible  = .T.
                ENDWITH
            CATCH TO loc_oErrOle
                MsgErro("Controle de " + CHR(225) + "rvore (ctTree.ocx) indispon" + ;
                        CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o: " + ;
                        loc_oErrOle.Message, "Aviso")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible = .F.;
    * este metodo percorre recursivamente o container e torna tudo visivel.
    * Este form nao tem container que nasca oculto no legado (os 7 controles
    * sao todos visiveis no SCX), entao nao ha lista de excecao.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ArvoreDisponivel - .T. somente quando o OLEControl da arvore foi criado
    * com sucesso em ConfigurarControles. O ctTree.ocx pode nao estar
    * registrado na estacao (ou o form estar em modo teste) e, nesse caso,
    * TODA chamada a API de nos tem de ser evitada - o objeto simplesmente
    * nao existe e qualquer referencia derrubaria o metodo.
    *==========================================================================
    PROTECTED FUNCTION ArvoreDisponivel()
        RETURN PEMSTATUS(THIS, "obj_4c_TreeView", 5) AND ;
               VARTYPE(THIS.obj_4c_TreeView) = "O"
    ENDFUNC

    *==========================================================================
    * TextoNivel - Le um elemento do vetor de niveis como TEXTO. DIMENSION
    * que CRESCE o vetor inicializa os elementos novos como Logico .F.
    * (e o proprio legado testa isso com Type('laNivel[lnNivel]') = 'L'):
    * aplicar UPPER()/comparar com string num elemento ainda nao atribuido
    * dispararia "Operator/operand type mismatch". Devolver "" reproduz o
    * tratamento que o legado da ao elemento nao inicializado.
    *==========================================================================
    PROTECTED FUNCTION TextoNivel(par_uElemento)
        IF VARTYPE(par_uElemento) = "C"
            RETURN par_uElemento
        ENDIF
        RETURN ""
    ENDFUNC

    *==========================================================================
    * ObterTextoNivel - Transcricao da expressao que o maketree legado repete
    * tres vezes para recortar UM nivel do texto hierarquico separado por "-":
    *   Alltrim(Substr(lcDesc, Iif(lnNivel=1, 1, At('-',lcDesc,lnNivel-1)+1), ;
    *          At('-',lcDesc,lnNivel) - Iif(lnNivel=1,1,At('-',lcDesc,lnNivel-1)+1) - 1))
    * Extraida para metodo para nao reescrever a formula em cada site (a
    * expressao eh regra de negocio - regra CLAUDE.md #17).
    * Quando nao existe o N-esimo "-" a formula original produziria tamanho
    * NEGATIVO em SUBSTR (erro 11 do VFP9); devolve-se "" nesse caso, que eh
    * o que faz o laco do legado cair no ramo de reinicio do nivel.
    *==========================================================================
    PROTECTED FUNCTION ObterTextoNivel(par_cDesc, par_nNivel)
        LOCAL loc_nIni, loc_nFim

        loc_nIni = IIF(par_nNivel = 1, 1, AT("-", par_cDesc, par_nNivel - 1) + 1)
        loc_nFim = AT("-", par_cDesc, par_nNivel)

        IF loc_nFim = 0 OR (loc_nFim - loc_nIni - 1) <= 0
            RETURN ""
        ENDIF

        RETURN ALLTRIM(SUBSTR(par_cDesc, loc_nIni, loc_nFim - loc_nIni - 1))
    ENDFUNC

    *==========================================================================
    * PrepararArvore - Reproduz o bloco de inicializacao que o maketree
    * legado executa antes de desenhar os nos:
    *   loTree1.ClearNodes / TipsDisplay = .t. / ExpandOnDClick /
    *   SmallIcons = .t. / PicAlign = 0 / SelectedStyle = 2 / PictureType = 1
    * As tres imagens (indices 1..3 usados em AddPictureNode) sao carregadas
    * uma unica vez, como no Init legado:
    *   AddImage(LoadPicture('\vbmp\Menu1.Bmp'))        -> 1 (raiz / folha de nivel 1)
    *   AddImage(LoadPicture('\vbmp\x_planilha1.bmp'))  -> 2 (folha de nivel > 1)
    *   AddImage(LoadPicture('\vbmp\MsgStop1.Gif'))     -> 3 (no intermediario)
    * .ExpandOnDClick eh chamado SEM atribuicao no legado (eh metodo do OCX);
    * fica por ULTIMO para que uma divergencia de interface do controle nao
    * descarte os SETs anteriores.
    *==========================================================================
    PROTECTED PROCEDURE PrepararArvore()
        LOCAL loc_oErro

        IF THIS.ArvoreDisponivel()
            TRY
                WITH THIS.obj_4c_TreeView
                    IF !THIS.this_lImagensArvore
                        .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "Menu1.Bmp"))
                        .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "x_planilha1.bmp"))
                        .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "MsgStop1.Gif"))
                        THIS.this_lImagensArvore = .T.
                    ENDIF

                    .ClearNodes
                    .TipsDisplay   = .T.
                    .SmallIcons    = .T.
                    .PicAlign      = 0
                    .SelectedStyle = 2
                    .PictureType   = 1
                    .ExpandOnDClick
                ENDWITH
            CATCH TO loc_oErro
                MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + ;
                        loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparArvore - ClearNodes puro, como no GotFocus de GetcUsu/GetGrupo do
    * legado ("m.loTree1 = ThisForm.TreeView / m.loTree1.ClearNodes").
    * Zera tambem o nivel de expansao corrente, porque sem nos nao ha nivel
    * expandido - o legado reseta pnNodeExp no fim do maketree seguinte.
    *==========================================================================
    PROTECTED PROCEDURE LimparArvore()
        LOCAL loc_oErro

        IF THIS.ArvoreDisponivel()
            TRY
                THIS.obj_4c_TreeView.ClearNodes
                THIS.this_nNodeExp = 0
            CATCH TO loc_oErro
                MsgErro("Falha ao limpar a " + CHR(225) + "rvore: " + ;
                        loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarDados - Metodo de carga desta tela (equivalente ao PROCEDURE
    * maketree do legado). Transfere os filtros da tela para o Business
    * Object, pede o cursor de acessos (SIGOPCAUBO.MontarArvoreAcessos -
    * SigCdAcU/SigCdAcG/SigCdPrg, ou SigCdPrg puro para o super-usuario
    * '4CONTROL') e desenha a arvore inteira em PopularArvore().
    *
    * O guard "pelo menos um filtro preenchido" eh o que o legado escreve nos
    * TRES call sites do MakeTree (GetcUsu.Valid/GetDUsu.Valid/GetGrupo.Valid:
    * "If ! Empty(This.Value) Or ! Empty(This.Parent.GetGrupo.Value)"). Ele
    * mora aqui para o metodo ser seguro vindo de qualquer chamador: sem
    * filtro nenhum a consulta por Grupo casaria com grupos em branco.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cUsuario, loc_cGrupo, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel", "Erro")
        ELSE
            loc_cUsuario = ALLTRIM(THIS.txt_4c_CUsu.Value)
            loc_cGrupo   = ALLTRIM(THIS.txt_4c_Grupo.Value)

            IF EMPTY(loc_cUsuario) AND EMPTY(loc_cGrupo)
                *-- Nada a consultar: a arvore fica vazia, como no legado
                *-- (o MakeTree nem eh chamado nessa situacao).
                THIS.LimparArvore()
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_cUsuarios = loc_cUsuario
                    .this_cNComps   = ALLTRIM(THIS.txt_4c_DUsu.Value)
                    .this_cGrupos   = loc_cGrupo
                ENDWITH

                *-- SQLEXEC com handle invalido DISPARA excecao em vez de
                *-- devolver -1; sem este TRY o usuario veria o "Program
                *-- Error" CRU do VFP no lugar do dialogo do sistema.
                *-- RETURN so DEPOIS do ENDTRY (regra CLAUDE.md #1).
                TRY
                    IF THIS.this_oBusinessObject.MontarArvoreAcessos()
                        THIS.PopularArvore()
                        loc_lSucesso = .T.
                    ELSE
                        MsgAviso(IIF(EMPTY(THIS.this_oBusinessObject.this_cMensagemErro), ;
                            "N" + CHR(227) + "o foi poss" + CHR(237) + "vel consultar os acessos.", ;
                            THIS.this_oBusinessObject.this_cMensagemErro), ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro("Falha ao consultar os acessos: " + loc_oErro.Message + CHR(13) + ;
                            "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                            "Procedure: " + loc_oErro.Procedure, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PopularArvore - Desenha os nos a partir do cursor que o BO acabou de
    * popular. Transcricao linha a linha do laco Scan do maketree legado:
    * o texto da coluna descricaos eh hierarquico, separado por "-", e cada
    * segmento vira um nivel da arvore. O vetor de niveis guarda o caminho
    * ja desenhado para nao repetir o no intermediario.
    *
    * Separado de CarregarDados para que a consulta continue valendo mesmo
    * quando o controle ActiveX da arvore nao esta disponivel na estacao.
    *==========================================================================
    PROTECTED PROCEDURE PopularArvore()
        LOCAL loc_oErro, loc_cCursor, loc_cDesc, loc_cDescs, loc_cCargo
        LOCAL loc_nNivel, loc_nNo, loc_nPicture, loc_nUltimo
        LOCAL ARRAY loc_aNivel[1]

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorArvore

        IF THIS.ArvoreDisponivel() AND USED(loc_cCursor)
            THIS.PrepararArvore()

            TRY
                loc_aNivel[1] = ""

                SELECT (loc_cCursor)
                SCAN
                    loc_cDesc = fLimpaTexto(ALLTRIM(TratarNulo(descricaos, "")))

                    *-- NodeCargo = Programas + Parametros do legado, SEM
                    *-- ALLTRIM nas partes: eh chave POSICIONAL (programas
                    *-- char(15) + parametros char(10) = 25) e encurtar
                    *-- qualquer parte quebraria a identificacao do no
                    *-- (regra CLAUDE.md #42).
                    loc_cCargo = PADR(TratarNulo(programas,  ""), 15) + ;
                                 PADR(TratarNulo(parametros, ""), 10)

                    IF AT("-", loc_cDesc) = 0
                        *-- Descricao sem "-": no de nivel 1, icone 1
                        loc_nNo = THIS.obj_4c_TreeView.AddPictureNode(ALLTRIM(loc_cDesc), 0, 1, 1, 0, 0)
                        THIS.ConfigurarNo(loc_nNo, loc_cCargo)
                        loc_aNivel[1] = loc_cDesc
                    ELSE
                        IF !ISNULL(loc_cDesc)
                            *-- Localiza em que nivel o caminho desta linha
                            *-- deixa de coincidir com o caminho ja desenhado.
                            loc_nNivel = 1
                            DO WHILE .T.
                                IF ALEN(loc_aNivel) < loc_nNivel
                                    DIMENSION loc_aNivel[loc_nNivel]
                                    loc_aNivel[loc_nNivel] = ""
                                    EXIT
                                ENDIF

                                loc_cDescs = THIS.ObterTextoNivel(loc_cDesc, loc_nNivel)

                                IF VARTYPE(loc_aNivel[loc_nNivel]) = "L" AND !loc_aNivel[loc_nNivel]
                                    loc_aNivel[loc_nNivel] = ""
                                    EXIT
                                ENDIF

                                IF UPPER(THIS.TextoNivel(loc_aNivel[loc_nNivel])) == UPPER(loc_cDescs)
                                    loc_nNivel = loc_nNivel + 1
                                ELSE
                                    DIMENSION loc_aNivel[loc_nNivel]
                                    loc_aNivel[loc_nNivel] = ""
                                    EXIT
                                ENDIF
                            ENDDO

                            *-- Desenha os niveis INTERMEDIARIOS que faltam
                            *-- (icone 3) ate chegar ao ultimo segmento.
                            DO WHILE AT("-", loc_cDesc, loc_nNivel) <> 0
                                loc_nUltimo = ALEN(loc_aNivel)

                                IF THIS.TextoNivel(loc_aNivel[loc_nUltimo]) <> ;
                                   ALLTRIM(LEFT(loc_cDesc, AT("-", loc_cDesc, loc_nNivel) - 1))
                                    loc_cDescs = THIS.ObterTextoNivel(loc_cDesc, loc_nNivel)
                                    loc_aNivel[loc_nUltimo] = loc_cDescs
                                    loc_nPicture = 3
                                    loc_nNo = THIS.obj_4c_TreeView.AddPictureNode( ;
                                        ALLTRIM(loc_cDescs), 0, loc_nNivel, loc_nPicture, 0, 0)
                                    THIS.ConfigurarNo(loc_nNo, loc_cCargo)
                                ENDIF

                                loc_nNivel = loc_nNivel + 1
                                DIMENSION loc_aNivel[ALEN(loc_aNivel) + 1]
                                loc_aNivel[ALEN(loc_aNivel)] = ""
                            ENDDO

                            loc_aNivel[ALEN(loc_aNivel)] = ;
                                ALLTRIM(LEFT(loc_cDesc, AT("-", loc_cDesc, loc_nNivel) - 1))

                            *-- Ultimo segmento (a folha): icone 1 no nivel 1,
                            *-- icone 2 nos demais.
                            loc_cDescs   = ALLTRIM(SUBSTR(loc_cDesc, ;
                                IIF(loc_nNivel = 1, 1, AT("-", loc_cDesc, loc_nNivel - 1) + 1), ;
                                LEN(loc_cDesc)))
                            loc_nPicture = IIF(loc_nNivel = 1, 1, 2)
                            loc_nNo = THIS.obj_4c_TreeView.AddPictureNode( ;
                                ALLTRIM(loc_cDescs), 0, loc_nNivel, loc_nPicture, 0, 0)
                            THIS.ConfigurarNo(loc_nNo, loc_cCargo)
                            loc_aNivel[loc_nNivel] = loc_cDescs
                        ENDIF
                    ENDIF
                ENDSCAN

                THIS.obj_4c_TreeView.ReDraw(.T.)
                THIS.obj_4c_TreeView.Refresh

                *-- "ThisForm.pnNodeExp = 0" do fim do maketree legado: a
                *-- arvore nasce toda recolhida (NodeExpanded = .f. em cada no).
                THIS.this_nNodeExp = 0
            CATCH TO loc_oErro
                MsgErro("Falha ao montar a " + CHR(225) + "rvore de acessos: " + ;
                        loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarNo - Propriedades que o maketree legado aplica a TODO no
    * recem-criado, identicas nos tres sites de AddPictureNode:
    *   NodeHeader = .t. / NodeExpanded = .f. / NodeShowChecks = .f. /
    *   NodeFontBold = 2 / NodeCargo = Programas + Parametros
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarNo(par_nNo, par_cCargo)
        WITH THIS.obj_4c_TreeView
            .NodeHeader(par_nNo)     = .T.
            .NodeExpanded(par_nNo)   = .F.
            .NodeShowChecks(par_nNo) = .F.
            .NodeFontBold(par_nNo)   = 2
            .NodeCargo(par_nNo)      = par_cCargo
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnExpandirClick - Command1.Click do legado ("Expandir Niveis"):
    * expande todos os nos do nivel imediatamente abaixo do nivel corrente e
    * so avanca pnNodeExp quando houve de fato algo para expandir.
    *==========================================================================
    PROCEDURE BtnExpandirClick()
        LOCAL loc_nNode, loc_lExpande, loc_oErro
        loc_lExpande = .F.

        IF THIS.ArvoreDisponivel()
            TRY
                WITH THIS.obj_4c_TreeView
                    FOR loc_nNode = 0 TO .ListCount - 1
                        IF THIS.this_nNodeExp + 1 = .NodeLevel(loc_nNode)
                            .NodeExpanded(loc_nNode) = .T.
                            loc_lExpande = .T.
                        ENDIF
                    ENDFOR
                ENDWITH

                IF loc_lExpande
                    THIS.this_nNodeExp = THIS.this_nNodeExp + 1
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Falha ao expandir n" + CHR(237) + "veis: " + ;
                        loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRecolherClick - Command2.Click do legado ("Recolher Niveis"):
    * recolhe os nos do nivel corrente e volta um nivel.
    *==========================================================================
    PROCEDURE BtnRecolherClick()
        LOCAL loc_nNode, loc_oErro

        IF THIS.ArvoreDisponivel() AND THIS.this_nNodeExp > 0
            TRY
                WITH THIS.obj_4c_TreeView
                    FOR loc_nNode = 0 TO .ListCount - 1
                        IF THIS.this_nNodeExp = .NodeLevel(loc_nNode)
                            .NodeExpanded(loc_nNode) = .F.
                        ENDIF
                    ENDFOR
                ENDWITH

                THIS.this_nNodeExp = THIS.this_nNodeExp - 1
            CATCH TO loc_oErro
                MsgErro("Falha ao recolher n" + CHR(237) + "veis: " + ;
                        loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Command3.Click do legado ("Release Windows"), que no
    * sistema novo eh o Release() do proprio form (o legado abre a tela como
    * janela unica; aqui ela eh modal, aberta por menu.prg).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CUsuGotFocus / GrupoGotFocus - GotFocus de GetcUsu/GetGrupo do legado:
    * ao voltar para o campo de filtro a arvore eh zerada, porque o conteudo
    * exibido deixa de corresponder ao filtro que esta sendo digitado.
    * GetDUsu NAO declara GotFocus no dump - por isso nao ha DUsuGotFocus.
    *==========================================================================
    PROCEDURE CUsuGotFocus()
        THIS.LimparArvore()
    ENDPROC

    PROCEDURE GrupoGotFocus()
        THIS.LimparArvore()
    ENDPROC

    *==========================================================================
    * AtualizarHabilitacaoFiltros - Reproduz a exclusividade mutua dos tres
    * guards When do legado:
    *   GetcUsu.When  -> Return(Empty(ThisForm.GetGrupo.Value))
    *   GetGrupo.When -> Return(Empty(ThisForm.GetcUsu.Value))
    *   GetDUsu.When  -> Return(Empty(ThisForm.GetcUsu.Value) And
    *                           Empty(ThisForm.GetGrupo.Value))
    * No legado, When = .F. impede o campo de RECEBER foco (o Tab salta para
    * o proximo controle); aqui o equivalente e .Enabled = .F. - o usuario
    * nao consegue comecar a digitar no campo trancado, e o efeito liquido e
    * o mesmo: filtrar por Usuario OU por Grupo, nunca os dois ao mesmo
    * tempo, e GetDUsu (nome) so aceita digitacao direta quando NENHUM dos
    * dois filtros de codigo esta preenchido.
    *
    * Chamado apos ConfigurarControles (estado inicial) e ao fim de cada
    * ValidarXxxExec, pois e quando o CONTEUDO dos campos pode ter mudado
    * (preenchido pelo lookup, ou limpo quando o usuario cancela o picker).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarHabilitacaoFiltros()
        LOCAL loc_lTemUsuario, loc_lTemGrupo

        loc_lTemUsuario = !EMPTY(ALLTRIM(THIS.txt_4c_CUsu.Value))
        loc_lTemGrupo   = !EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))

        THIS.txt_4c_Grupo.Enabled = !loc_lTemUsuario
        THIS.txt_4c_CUsu.Enabled  = !loc_lTemGrupo
        THIS.txt_4c_DUsu.Enabled  = !loc_lTemUsuario AND !loc_lTemGrupo
    ENDPROC

    *==========================================================================
    * ValidarCUsu / ValidarCUsuExec - LostFocus de txt_4c_CUsu (GetcUsu.Valid
    * do legado): busca o usuario digitado em SigCdUsu e preenche o nome
    * (txt_4c_DUsu); nao achando, abre o picker (AbrirBuscaUsuario). Ao
    * final, SEMPRE reconsulta a arvore - o legado reavalia a condicao
    * "If !Empty(This.Value) Or !Empty(GetGrupo.Value) -> MakeTree" apos o
    * bloco de lookup, independente do resultado (CarregarDados() ja cobre
    * o caso de ambos os filtros vazios, limpando a arvore).
    *
    * Guarda de reentrancia (regra CLAUDE.md #37/#47): o picker e MODAL e
    * tira o foco do campo, o que poderia redisparar este proprio LostFocus.
    * O corpo fica em ValidarCUsuExec para a flag ser SEMPRE liberada.
    *==========================================================================
    PROCEDURE ValidarCUsu()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarCUsuExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarCUsuExec()
        LOCAL loc_cUsuario

        loc_cUsuario = ALLTRIM(THIS.txt_4c_CUsu.Value)

        IF !EMPTY(loc_cUsuario)
            THIS.AbrirBuscaUsuario("Usuarios", loc_cUsuario)
        ENDIF

        THIS.AtualizarHabilitacaoFiltros()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * ValidarDUsu / ValidarDUsuExec - LostFocus de txt_4c_DUsu (GetDUsu.Valid
    * do legado): mesma logica de ValidarCUsu, mas a busca exata/parcial e
    * pelo NOME (coluna nComps), nao pelo codigo.
    *==========================================================================
    PROCEDURE ValidarDUsu()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDUsuExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarDUsuExec()
        LOCAL loc_cNome

        loc_cNome = ALLTRIM(THIS.txt_4c_DUsu.Value)

        IF !EMPTY(loc_cNome)
            THIS.AbrirBuscaUsuario("nComps", loc_cNome)
        ENDIF

        THIS.AtualizarHabilitacaoFiltros()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * ValidarGrupo / ValidarGrupoExec - LostFocus de txt_4c_Grupo (GetGrupo.
    * Valid do legado): busca o grupo digitado em SigCdGrA; nao achando,
    * abre o picker (AbrirBuscaGrupo).
    *==========================================================================
    PROCEDURE ValidarGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarGrupoExec()
        LOCAL loc_cGrupo

        loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)

        IF !EMPTY(loc_cGrupo)
            THIS.AbrirBuscaGrupo(loc_cGrupo)
        ENDIF

        THIS.AtualizarHabilitacaoFiltros()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * AbrirBuscaUsuario - Transcricao do bloco fwBuscaExt comum a GetcUsu.
    * Valid e GetDUsu.Valid (so o campo de busca muda: Usuarios ou nComps).
    * Contrato do FormBuscaAuxiliar (regra CLAUDE.md #37): o Init ja tenta o
    * match exato; so mostrar o picker quando NAO achou (this_lAchouRegistro).
    * Preenche os DOIS campos (codigo+nome) quando this_lSelecionou; senao
    * limpa os dois - exatamente o "If lastkey()<>27 ... Else ... Endif" do
    * legado (NAO eh o MsgAviso+clear da regra #50: o legado tambem limpa
    * aqui, e NAO ha aviso nenhum sendo exibido).
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaUsuario(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", par_cCampoBusca, par_cValorBusca, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    *-- Ordem das colunas segue o legado: a busca por
                    *-- Usuarios mostra Codigo primeiro; a busca por nComps
                    *-- (GetDUsu) mostra Nome primeiro.
                    IF UPPER(par_cCampoBusca) == "USUARIOS"
                        loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("nComps", "", "Nome")
                    ELSE
                        loc_oBusca.mAddColuna("nComps", "", "Nome")
                        loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
                    ENDIF
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                    SELECT cursor_4c_BuscaUsu
                    THIS.txt_4c_CUsu.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    THIS.txt_4c_DUsu.Value = ALLTRIM(cursor_4c_BuscaUsu.nComps)
                ELSE
                    THIS.txt_4c_CUsu.Value = ""
                    THIS.txt_4c_DUsu.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Falha ao buscar usu" + CHR(225) + "rio: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - Transcricao do bloco fwBuscaExt de GetGrupo.Valid
    * (busca em SigCdGrA pelo codigo do grupo).
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupo(par_cValorBusca)
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrA", "cursor_4c_BuscaGrp", "Grupos", par_cValorBusca, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("nComps", "", "Nome")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    SELECT cursor_4c_BuscaGrp
                    THIS.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.Grupos)
                ELSE
                    THIS.txt_4c_Grupo.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Falha ao buscar grupo: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Fecha o cursor da arvore de acessos (cursor_4c_Arvore,
    * populado por SIGOPCAUBO.MontarArvoreAcessos) antes de liberar o
    * Business Object. FormBase.Destroy() cuida do this_oBusinessObject e
    * da restauracao do menu principal (regra CLAUDE.md Pattern #145 -
    * DODEFAULT() como ULTIMA linha).
    *==========================================================================
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           USED(THIS.this_oBusinessObject.this_cCursorArvore)
            USE IN (THIS.this_oBusinessObject.this_cCursorArvore)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

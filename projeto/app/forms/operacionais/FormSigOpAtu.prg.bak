*====================================================================
* FormSigOpAtu.prg
*
* Dialogo modal "Operacao para Atualizacao" (SIGOPATU do legado): pede
* ao usuario o codigo de uma Operacao de Estoque ja cadastrada em
* SigCdOpe (PK unica dopes - "SigCdOpe eh single-column", CLAUDE.md) e
* confirma com o botao "Ok". Nao ha INSERT/UPDATE/DELETE - o dialogo so
* consulta (Valid do campo) e fecha (ver SigOpAtuBO.prg para o
* detalhamento do comportamento e a justificativa de nao sobrescrever
* Inserir/Atualizar/ExecutarExclusao).
*
* Form OPERACIONAL - layout CUSTOMIZADO (flat, SEM PageFrame): o SCX
* legado nao tem Page1/Page2, e um dialogo unico de 1 campo + 1 botao
* (CLAUDE.md: forms OPERACIONAIS nao seguem o padrao Lista/Dados do
* CRUD - analisar o original).
*
* FASE 3/8 - ESTRUTURA BASE: cria o Business Object e monta so o
* elemento decorativo do layout (faixa do cabecalho cnt_4c_Sombra,
* equivalente ao cntSombra legado - o Init legado so faz
* ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption e o mesmo
* para lblTitulo, ja reproduzido aqui). NAO ha Load/=fConfigGeral() no
* migrado - fconfiggeral.prg (utils) eh wrapper de compatibilidade so
* para p-code de VCX legado (CLAUDE.md regra #2); codigo nosso nunca
* chama essa funcao.
*
* FASE 4/8 - BOTOES (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid
* nem botoes CRUD (analise.json: temGrid=false; layout.json nao
* declara PageFrame nem grid) - o UNICO "botao" deste legado eh o
* Command1/"Ok" (SigOpAtu_form_codigo_fonte.txt:160-166), que fica
* para a Fase 7 (evento Click), junto com o campo que ele valida.
* Este eh um dialogo FLAT de CAPTURA (1 campo editavel + 1 botao, sem
* lista) - mesma familia do SIGMVVDE/FormSigMvVde documentada no
* gate da Fase 4 do OrquestradorMigracao.ps1 (ramo "layout captura").
* Inventar Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o
* legado eh um popup de 800x130 com 1 campo, nao um cadastro).
*
* FASE 5/8 - CAMPOS (PARTE 1, CONCLUIDA): cria lbl_4c_Label1 ("Operacao
* de Estoque :", equivalente ao Say1 legado - classe say sem Width nem
* Alignment no dump, logo .Alignment=0 com Width explicita, CLAUDE.md
* regra #23) e txt_4c_DopEstq (DopEstq/fwget do legado, ligado a
* SigCdOpe.dopes char(20) - regra "SigCdOpe eh single-column" acima).
* So a geometria/visual - BINDEVENT do Valid fica para a Fase 7.
*
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS: nao sobrou nenhum campo de
* dados (o legado tem UM so, entregue na Fase 5), entao esta fase
* entrega (a) o ultimo objeto de tela - cmd_4c_Command1, o "Ok"
* (Command1/fwbtng do legado) - e (b) o LOOKUP do campo DopEstq
* COMPLETO, que eh o trabalho principal desta fase.
*
* O "equivalente do cnt_4c_BotoesAcao (Salvar/Cancelar)" do roteiro
* CRUD aqui eh esse botao unico, criado DIRETO no Form (o SCX nao tem
* container de botoes). Ele sai desta fase com o Click JA
* implementado (BtnOkClick): botao visivel sem funcionalidade real
* seria stub, o que o pipeline proibe - ver nota em BtnOkClick sobre
* a transcricao literal do Click legado.
*
* LOOKUP (o Valid do DopEstq legado): o legado faz Seek no cursor
* global Fortyus CrOpera e, falhando, abre o picker fwBuscaInt
* ('CrOpera','Dopes',...,'Operacoes') com mAddColuna('Dopes','','Codigo').
* No migrado isso vira FormBuscaAuxiliar sobre o MESMO universo, com a
* MESMA coluna/titulo - ver a entrega (1) da Fase 8 abaixo, que trocou
* o "SigCdOpe inteira" desta fase pelo proprio crOpera quando ele esta
* aberto. Eventos:
*   DopEstqLostFocus  - equivalente do Valid (regra #47: lookup vai em
*     LostFocus, nunca em KeyPress sem testar a tecla; regra #34:
*     BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox).
*   DopEstqKeyPress   - ENTER/TAB resolvem o digitado, F4/F5 abrem o
*     picker; TESTA a tecla antes de abrir (regra #47).
*   DopEstqDblClick   - atalho de mouse para o mesmo picker.
*   AbrirLookupDopEstq - funil unico; regra #36 (1o argumento eh o
*     HANDLE) e regra #37 (guarda this_lAchouRegistro antes do Show(),
*     atribuicao SO sob this_lSelecionou).
*
* FASE 7/8 - EVENTOS PRINCIPAIS: os quatro nomes canonicos
* BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
* NAO existem aqui, e isso eh deliberado: sao a barra CRUD da Page1 do
* frmcadastro, e este legado nao tem CRUD nenhum (Class: form puro, sem
* frmcadastro, sem Grupo_Op, sem pcEscolha, sem X.Click de verbo CRUD).
* Inventa-los violaria o PILAR 1 e so poderia produzir metodo vazio, que
* o pipeline proibe. O UNICO botao do dump eh o Command1/"Ok", cujo
* evento eh BtnOkClick.
*
* O trabalho REAL desta fase foi o CONTRATO DE RETORNO do BtnOkClick: o
* dialogo nao existe para si mesmo - ele eh chamado pelo "Acerto de
* Inventario" do SIGCDBAL ("Do Form SigOpAtu" seguido de
* "If Not Used('crOpera') Or IsEmpty(crOpera.Dopes) / Return",
* SIGCDBAL_form_codigo_fonte.txt:6014-6019), que LE a Operacao escolhida
* logo depois. Como estava, o Click fazia THIS.Release(): o form se
* destruia junto com o BO e o chamador NAO TINHA COMO LER nada - o
* dialogo "funcionava" na tela e devolvia NADA, sem erro e sem log. Ver
* BtnOkClick e PublicarOperacaoEscolhida.
*
* FASE 8/8 - CONSOLIDACAO FINAL. Quatro entregas, todas com call site
* real - metodo que ninguem chama eh stub, e stub o pipeline proibe:
*
* (1) UNIVERSO DO LOOKUP - fecha a pendencia aberta na Fase 6. O picker
*     consultava SigCdOpe INTEIRA, e o universo legitimo eh o
*     subconjunto que o CHAMADOR preparou em crOpera ("Where Parcs <> 1
*     And Opers = 3 And DigItens = 1 And Caixas <> 1",
*     SIGCDBAL_form_codigo_fonte.txt:5476). Nao eh refinamento
*     opcional: o legado chama fwBusca*Int* ('CrOpera','Dopes',...), o
*     picker de CURSOR LOCAL - ele JA navegava crOpera, nunca a tabela.
*     Consultar SigCdOpe inteira era desvio do PILAR 1 e produzia a
*     pior UX possivel: o usuario escolhia no picker uma operacao que o
*     PublicarOperacaoEscolhida recusava logo depois.
*     Ver CarregarUniversoOperacoes e AbrirLookupDopEstq.
*
*     O filtro NAO eh copiado para ca - seria filtro inventado num
*     dialogo que nao o conhece. Ele chega pronto DENTRO de crOpera.
*     Sem crOpera aberto (dialogo acionado fora do SIGCDBAL) o universo
*     cai para SigCdOpe, unico superconjunto honesto.
*
* (2) CANCELAMENTO VISIVEL AO CHAMADOR - o chamador detecta
*     cancelamento por "Not Used('crOpera') Or IsEmpty(crOpera.Dopes)"
*     (SIGCDBAL:6016). Como ele faz "Go Top" em crOpera ao montar o
*     cursor (SIGCDBAL:5484), um cancelamento que NAO mexesse na
*     posicao deixaria o cursor na PRIMEIRA operacao, e o chamador
*     leria isso como "o usuario escolheu a operacao 1" - gravacao
*     errada, sem erro e sem log (familia das regras #17/#20/#42). Por
*     isso cancelar agora POSICIONA crOpera em EOF, unico estado em que
*     crOpera.Dopes le vazio. Ver BtnCancelarClick e
*     PublicarOperacaoEscolhida.
*
* (3) HOOKS DE TRANSFERENCIA COMPLETOS - BOParaForm (contraparte do
*     FormParaBO da Fase 7) e LimparCampos, chamados em
*     InicializarForm e no caminho de cancelamento.
*
* (4) LIBERACAO DE RECURSOS - QueryUnload publica o cancelamento quando
*     a tela morre sem confirmar; Destroy fecha o cursor do picker.
*
* Metodos CRUD-canonicos que seguem NAO se aplicando: ver o comentario
* dedicado antes de Destroy().
*
* Herda de: FormBase
*====================================================================

DEFINE CLASS FormSigOpAtu AS FormBase

    *-- Propriedades visuais (copiadas do SCX legado - SIGOPATU)
    this_cMensagemErro = ""
    Width       = 800
    Height      = 130
    Caption     = "Opera" + CHR(231) + CHR(227) + "o para Atualiza" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow = 1
    ControlBox  = .F.
    Movable     = .F.
    TitleBar    = 0
    WindowType  = 1

    *-- Propriedades do Form
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia do lookup (regra #37): o FormBuscaAuxiliar eh
    *-- MODAL, tira o foco do campo e redispara o proprio LostFocus.
    this_lEmLookup = .F.

    *-- Guarda de valor-nao-mudou: depois de o picker devolver o foco ao
    *-- campo, o LostFocus dispara de novo com o MESMO valor. Sem este memo
    *-- o picker reabriria em laco e prenderia o usuario no dialogo modal.
    *-- Sentinela CHR(0) (nenhum valor digitavel bate) para que a PRIMEIRA
    *-- validacao sempre aconteca, inclusive com o campo vazio.
    this_cUltimoDopEstqValidado = CHR(0)

    *-- CONTRATO DE RETORNO para o form chamador (Fase 7/8).
    *-- O legado nao devolve nada por valor: o SIGCDBAL/"Acerto de
    *-- Inventario" faz "Do Form SigOpAtu" e logo depois LE O RESULTADO
    *-- do cursor dele proprio (SIGCDBAL_form_codigo_fonte.txt:6014-6019):
    *--
    *--     Do Form SigOpAtu
    *--     If Not Used('crOpera') Or IsEmpty(crOpera.Dopes)
    *--         && caso nao tenha escolhido a operacao cancel o processamento...
    *--         Return
    *--     Endif
    *--
    *-- Isto eh: a SAIDA do dialogo eh a LINHA em que o cursor "crOpera"
    *-- ficou POSICIONADO. O crOpera NAO eh deste dialogo - eh do
    *-- CHAMADOR, que o cria filtrado no proprio Init
    *-- (SIGCDBAL_form_codigo_fonte.txt:5476-5484: "Select * From SigCdOpe
    *-- Where Parcs <> 1 And Opers = 3 And DigItens = 1 And Caixas <> 1" +
    *-- "Index On Dopes Tag Dopes") e de onde, depois, le "crOpera.Dopes"
    *-- (linhas 6097/6104/6154) E "crOpera.Estoqs" (linha 6132). O Valid
    *-- legado so dava "Select CrOpera / Seek()", ou seja POSICIONAVA o
    *-- cursor do chamador - e essa posicao era a resposta.
    *--
    *-- Estas duas properties sao o mesmo contrato em forma utilizavel pelo
    *-- sistema novo (canonico do projeto - formbuscaauxiliar.prg:367-369:
    *-- o botao de confirmar marca a flag e faz Hide(), e o CHAMADOR le o
    *-- resultado depois do Show()).
    this_lConfirmado         = .F.
    this_cDopEstqSelecionado = ""

    *====================================================================
    * Init
    *====================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - cria o Business Object e monta a faixa do
    * cabecalho (cnt_4c_Sombra).
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpAtuBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarLayoutBase()
                THIS.ConfigurarCampos()
                THIS.ConfigurarBotaoOk()
                THIS.ConfigurarEventos()

                *-- Estado inicial da tela vem do BO (hooks da Fase 8/8):
                *   LimparCampos zera o memo de validacao e o contrato de
                *   retorno e chama BOParaForm, que escreve no campo o
                *   valor que a property do BO carrega. Com o BO recem
                *   criado isso da campo vazio - o mesmo estado inicial do
                *   legado - e, ao mesmo tempo, da aos dois hooks um call
                *   site REAL em vez de deixa-los como decoracao.
                THIS.LimparCampos()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Opera" + ;
                CHR(231) + CHR(227) + "o para Atualiza" + CHR(231) + CHR(227) + "o")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarLayoutBase - fundo (Picture do legado) e faixa do
    * cabecalho (cnt_4c_Sombra, equivalente ao cntSombra legado). Campo
    * (DopEstq), label (Say1) e botao (Command1) entram nas fases
    * seguintes.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarLayoutBase()
        THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        *-- lblSombra: Init legado faz ThisForm.cntSombra.lblSombra.Caption
        *   = ThisForm.Caption - reproduzido direto no .Caption abaixo.
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: idem - ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarCampos - Fase 5/8 (Parte 1): label + campo digitavel
    * (SigOpAtu_form_codigo_fonte.txt:139-157). Direto na raiz do Form
    * (sem Page/PageFrame - dialogo FLAT), entao sem compensacao +29.
    * lbl_4c_Label1 = Say1 (classe say sem Width/Alignment no dump ->
    * Alignment=0 com Width explicita - CLAUDE.md regra #23; sem
    * ForeColor declarado -> RGB(90,90,90) - regra #12).
    * txt_4c_DopEstq = DopEstq (fwget), ligado a SigCdOpe.dopes char(20)
    * - MaxLength = 20 (regra #19, largura vem do SCHEMA, nao do Width
    * em pixels). BINDEVENT do Valid (lookup em SigCdOpe) fica para a
    * Fase 7 (regra #47 - lookup vai em LostFocus, nao em KeyPress sem
    * testar a tecla).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Estoque :"
            .Left      = 105
            .Top       = 94
            .Width     = 130
            .Height    = 17
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DopEstq", "TextBox")
        WITH THIS.txt_4c_DopEstq
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .MaxLength = 20
            .Left      = 241
            .Top       = 91
            .Width     = 150
            .Height    = 21
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarBotaoOk - Fase 6/8: Command1 do legado (mapeamento.json:
    * SIGOPATU.Command1 -> cmd_4c_Command1). Unico botao do form, criado
    * DIRETO no Form porque o SCX nao tem container de botoes.
    *
    * Top/Left/Picture/Caption EXATOS do dump
    * (SigOpAtu_form_codigo_fonte.txt:147-152). Width/Height/FontName/
    * FontSize/FontBold/FontItalic/ForeColor/BackColor/MousePointer/
    * WordWrap sao os defaults da classe fwbtng (framework.vcx, ver
    * docs/FRAMEWORK_class_codigo_fonte.txt:3495-3509), que o SCX nao
    * sobrescreve.
    *
    * Themes = .T. + DisabledPicture: CommandButton STANDALONE (fora de
    * CommandGroup) com .Picture nao desenha o icone com Themes = .F.
    * (o default do fwbtng) - este eh o unico desvio consciente do dump,
    * ja normatizado no projeto (Pattern #99).
    *
    * Left = 723 + Width = 80 = 803 passa 3px da Width do Form (800),
    * entao a borda direita do botao fica RECORTADA (regra #30). Isso eh
    * HERDADO do SCX, que declara exatamente 723 (regra #28: diante de
    * geometria incoerente do legado, nao inventar posicao nova - a
    * classe fwbtng nao declara Left/Top, logo nao ha valor "da classe"
    * para preferir). Icone e caption ficam inteiros na area visivel.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarBotaoOk()
        THIS.AddObject("cmd_4c_Command1", "CommandButton")
        WITH THIS.cmd_4c_Command1
            .Top             = 3
            .Left            = 723
            .Width           = 80
            .Height          = 100
            .Caption         = "\<Ok"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarEventos - Fase 6/8: liga os dois unicos eventos do dump
    * (DopEstq.Valid e Command1.Click). Chamado por ULTIMO em
    * InicializarForm, depois de ConfigurarCampos/ConfigurarBotaoOk -
    * BINDEVENT precisa dos objetos ja criados.
    *
    * Todos os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo
    * PROTECTED falha em SILENCIO (regra #3).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        *-- Equivalente do Valid legado. "LostFocus" e nao "Valid" porque
        *   BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox
        *   (regra #34); e nao "KeyPress" solto porque ali o picker subiria
        *   a CADA tecla, antes de o usuario terminar de digitar (regra #47).
        BINDEVENT(THIS.txt_4c_DopEstq, "LostFocus", THIS, "DopEstqLostFocus")

        *-- KeyPress TESTANDO a tecla (regra #47): ENTER/TAB resolvem o
        *   valor digitado, F4/F5 abrem o picker direto.
        BINDEVENT(THIS.txt_4c_DopEstq, "KeyPress", THIS, "DopEstqKeyPress")

        *-- Atalho de mouse para o mesmo funil de lookup.
        BINDEVENT(THIS.txt_4c_DopEstq, "DblClick", THIS, "DopEstqDblClick")

        BINDEVENT(THIS.cmd_4c_Command1, "Click", THIS, "BtnOkClick")
    ENDPROC

    *====================================================================
    * DopEstqLostFocus - Wrapper do funil de validacao do campo (Valid
    * legado). O corpo vive em DopEstqLostFocusExec para que a flag de
    * reentrancia seja SEMPRE liberada, inclusive nos RETURN antecipados
    * (regra #47: set/clear no wrapper, nunca em volta de um corpo com
    * RETURN no meio, senao a flag trava ligada e MATA o lookup pelo
    * resto da vida do form).
    *====================================================================
    PROCEDURE DopEstqLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.DopEstqLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *====================================================================
    * DopEstqLostFocusExec - Corpo do Valid legado:
    *
    *   Select CrOpera / Go Top / Set Near On
    *   If !Seek(This.Value)
    *       loLista = CreateObject('fwBuscaInt','CrOpera','Dopes',This.Value,'Operacoes')
    *       loLista.mAddColuna('Dopes','','Codigo')
    *       loLista.Show()
    *   EndIf
    *
    * O Seek + picker viraram UMA chamada a AbrirLookupDopEstq: o Init do
    * FormBuscaAuxiliar JA faz o match exato e sinaliza em
    * this_lAchouRegistro, que eh o equivalente direto do !Seek(). Por
    * isso NAO ha SQLEXEC de existencia aqui - duplicar a checagem antes
    * do picker eh proibido pela regra #37 (so cria caminho para
    * divergir), motivo pelo qual SigOpAtuBO.ExisteOperacao() nao eh
    * chamado neste fluxo.
    *====================================================================
    PROCEDURE DopEstqLostFocusExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))

        *-- Campo VAZIO: nenhum picker e NENHUMA mensagem (regra #50 -
        *   universo/valor vazio nao eh erro, e avisar + apagar impediria
        *   o usuario de preencher). Tambem NAO se auto-preenche com o
        *   primeiro registro: pegar "o primeiro que casa" sem escolha do
        *   usuario eh o defeito ja proibido no projeto (fAcessoContas).
        *   O campo em branco segue para o botao "Ok", que eh quem avisa
        *   no legado - ver BtnOkClick.
        IF EMPTY(loc_cValor)
            THIS.this_cUltimoDopEstqValidado = ""
            RETURN
        ENDIF

        *-- Valor ja validado nesta passagem: nao reabrir o picker.
        IF loc_cValor == THIS.this_cUltimoDopEstqValidado
            RETURN
        ENDIF

        THIS.AbrirLookupDopEstq(loc_cValor)

        THIS.this_cUltimoDopEstqValidado = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
    ENDPROC

    *====================================================================
    * DopEstqKeyPress - ENTER(13)/TAB(9) resolvem o valor digitado;
    * F4(115)/F5(116) abrem o picker direto. O teste da tecla eh
    * OBRIGATORIO (regra #47) - sem ele o dialogo modal subiria a cada
    * caractere e o usuario nao conseguiria terminar de digitar o codigo.
    * Assinatura com os parametros do evento (regra #3: handler de
    * KeyPress SEM parametros estoura a cada tecla).
    *
    * Guarda save/restore e nao set/clear (regra #47): este eh um IRMAO
    * do funil e pode ser acionado de dentro do proprio fluxo de lookup;
    * um clear simples liberaria a flag cedo demais.
    *====================================================================
    PROCEDURE DopEstqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt

        IF !INLIST(par_nKeyCode, 13, 9, 115, 116)
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))) AND ;
                INLIST(par_nKeyCode, 13, 9)
            *-- ENTER/TAB com campo vazio: deixa o foco seguir (regra #50).
            *   F4/F5 continuam abrindo o picker com a lista completa.
            RETURN
        ENDIF

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.

        THIS.AbrirLookupDopEstq(ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, "")))
        THIS.this_cUltimoDopEstqValidado = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))

        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *====================================================================
    * DopEstqDblClick - Atalho de mouse para o picker. Mesma guarda
    * save/restore do irmao de KeyPress (regra #47).
    *====================================================================
    PROCEDURE DopEstqDblClick()
        LOCAL loc_lEmLookupAnt

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.

        THIS.AbrirLookupDopEstq(ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, "")))
        THIS.this_cUltimoDopEstqValidado = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))

        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *====================================================================
    * CarregarUniversoOperacoes - Monta o cursor que o lookup navega.
    *
    * O legado chama fwBusca*Int* ('CrOpera','Dopes',...), que eh o
    * picker de cursor LOCAL: o universo dele NUNCA foi "SigCdOpe
    * inteira" - era o crOpera que o CHAMADOR montou ja filtrado
    * ("Select * From SigCdOpe Where Parcs <> 1 And Opers = 3 And
    * DigItens = 1 And Caixas <> 1", SIGCDBAL_form_codigo_fonte.txt:5476)
    * e indexou por Dopes (SIGCDBAL:5483).
    *
    * Por isso aqui NAO se reescreve aquele WHERE: copiar o filtro do
    * chamador para dentro do dialogo seria filtro INVENTADO - o dialogo
    * nao o conhece, e outro chamador teria outro. O filtro chega pronto
    * DENTRO do crOpera; basta copiar as linhas dele.
    *
    * Sem crOpera aberto, o dialogo foi acionado fora do SIGCDBAL: ai o
    * universo honesto eh SigCdOpe, superconjunto de qualquer crOpera.
    *
    * UMA coluna so (Dopes), como no mAddColuna unico do legado:
    * SigCdOpe eh SINGLE-COLUMN (CLAUDE.md) - dopes char(20) eh a PK E a
    * descricao (CONSTRAINT sigcdope_dopes PRIMARY KEY (dopes)). NUNCA
    * acrescentar descrs/Descrs: a coluna nao existe e o
    * FormBuscaAuxiliar estoura ao montar o grid.
    *
    * READWRITE no ramo local porque cursor de SELECT ... INTO CURSOR
    * nasce somente-leitura; o Grid do picker precisa navegar nele.
    *====================================================================
    PROTECTED FUNCTION CarregarUniversoOperacoes()
        LOCAL loc_lSucesso, loc_nResultado, loc_cAliasAnt, loc_oErro
        loc_lSucesso  = .F.
        loc_cAliasAnt = ALIAS()

        TRY
            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF

            IF USED("crOpera") AND TYPE("crOpera.Dopes") = "C"
                *-- Universo do CHAMADOR - o CrOpera do fwBuscaInt legado.
                SELECT Dopes ;
                    FROM crOpera ;
                    ORDER BY Dopes ;
                    INTO CURSOR cursor_4c_BuscaOpe READWRITE

                loc_lSucesso = USED("cursor_4c_BuscaOpe")
            ELSE
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
                        "cursor_4c_BuscaOpe")

                    loc_lSucesso = (loc_nResultado > 0 AND USED("cursor_4c_BuscaOpe"))

                    IF NOT loc_lSucesso
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar as " + ;
                            "Opera" + CHR(231) + CHR(245) + "es de Estoque." + CHR(13) + ;
                            CapturarErroSQL(), "Opera" + CHR(231) + CHR(227) + ;
                            "o para Atualiza" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF

            *-- Universo VAZIO nao eh erro e nao recebe aviso (regra #50):
            *   o picker abre com a lista vazia e o que o usuario digitou
            *   permanece no campo. O veredito final fica com o botao Ok,
            *   via PublicarOperacaoEscolhida.
            IF loc_lSucesso
                SELECT cursor_4c_BuscaOpe
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Opera" + CHR(231) + CHR(245) + "es de Estoque")
        ENDTRY

        IF NOT EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * AbrirLookupDopEstq - Funil UNICO do lookup de Operacao de Estoque.
    * Reproduz o Valid legado inteiro, sobre o universo que
    * CarregarUniversoOperacoes acabou de montar:
    *
    *   Select CrOpera / Go Top / Set Near On
    *   If !Seek(This.Value)
    *       loLista = CreateObject('fwBuscaInt','CrOpera','Dopes',This.Value,'Operacoes')
    *       loLista.mAddColuna('Dopes','','Codigo')
    *       loLista.Show()
    *   EndIf
    *   ... This.Value = Evaluate('CrOpera.dopes') ... This.Refresh
    *
    * O match EXATO (o "If !Seek") roda sobre o MESMO cursor que o picker
    * exibe - fonte UNICA, nenhum caminho para divergir, que eh o que a
    * regra #37 cobra ao proibir consulta de existencia duplicada antes
    * do picker. Por isso o FormBuscaAuxiliar eh usado em modo CURSOR
    * (CREATEOBJECT sem parametros + this_cCursorDestino) e nao em modo
    * tabela: la o Init refaria a consulta por conta propria, contra
    * SigCdOpe inteira, reabrindo o desvio de universo que a Fase 8
    * fechou. Em modo cursor this_lAchouRegistro nao eh usado - quem
    * responde "achei exato?" eh o LOCATE logo abaixo.
    *
    * LOCATE e nao SEEK: SEEK depende de TAG, e com SET EXACT ON
    * (config.prg) chave parcial em char nao casa de forma confiavel.
    *
    * Nada escolhido => o codigo digitado FICA (regras #37/#50): apagar o
    * que o usuario digitou eh exatamente o defeito do Erro198. Aqui o
    * legado reatribuia This.Value = CrOpera.dopes em TODOS os caminhos
    * (com Set Near On isso trazia o registro MAIS PROXIMO mesmo sem
    * escolha nenhuma); reproduzir isso gravaria um valor que o usuario
    * nao escolheu. Desvio consciente do PILAR 1, limitado ao caminho de
    * cancelamento do picker.
    *
    * O .Refresh() do campo eh o This.Refresh do fim do Valid legado.
    *====================================================================
    PROCEDURE AbrirLookupDopEstq(par_cValor)
        LOCAL loc_oBusca, loc_cValor, loc_cAliasAnt, loc_cTitulo, loc_oErro
        loc_oBusca    = .NULL.
        loc_cValor    = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
        loc_cAliasAnt = ALIAS()
        loc_cTitulo   = "Opera" + CHR(231) + CHR(245) + "es"

        TRY
            IF THIS.CarregarUniversoOperacoes()
                SELECT cursor_4c_BuscaOpe
                LOCATE FOR UPPER(ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))) == UPPER(loc_cValor)

                IF FOUND()
                    *-- Ramo "Else" do Valid legado: o campo recebe o valor
                    *   canonico do cursor (grafia/caixa da tabela).
                    THIS.txt_4c_DopEstq.Value = ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))
                    THIS.txt_4c_DopEstq.Refresh()
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                    IF VARTYPE(loc_oBusca) = "O"
                        *-- Modo CURSOR: sem os parametros de Init o
                        *   FormBuscaAuxiliar nao consulta nada por conta
                        *   propria - so exibe o cursor que recebe aqui.
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
                        loc_oBusca.this_cTitulo        = loc_cTitulo

                        IF PEMSTATUS(loc_oBusca, "cnt_4c_Cabecalho", 5)
                            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                        ENDIF

                        *-- UMA coluna so - mAddColuna('Dopes','','Codigo')
                        *   do legado (SigCdOpe eh single-column).
                        loc_oBusca.mAddColuna("Dopes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()

                        *-- O picker sai do Show() apenas OCULTO
                        *   (BtnSelecionarClick faz Hide(), nao Release()),
                        *   entao o cursor continua aberto e POSICIONADO na
                        *   linha escolhida - eh de la que o valor eh lido.
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                            SELECT cursor_4c_BuscaOpe
                            THIS.txt_4c_DopEstq.Value = ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))
                            THIS.txt_4c_DopEstq.Refresh()
                        ENDIF

                        *-- Release ANTES do USE IN: o Grid do picker ainda
                        *   tem o cursor como RecordSource enquanto o form
                        *   existe.
                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Busca de Opera" + CHR(231) + CHR(227) + "o de Estoque")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        IF NOT EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnOkClick - Command1.Click legado, transcrito LITERALMENTE:
    *
    *   If Empty(ThisForm.DopEstq.Value)
    *       MessageBox('Operacao Invalida !!!',48,'Campo Obrigatorio')
    *       ThisForm.DopEstq.SetFocus
    *   EndIf
    *   ThisForm.Release
    *   Return(.T.)
    *
    * ATENCAO - o Release do legado esta FORA do IF: o dialogo avisa que
    * a Operacao eh invalida, chama SetFocus (que nao tem efeito algum,
    * porque a tela fecha logo depois) e FECHA DO MESMO JEITO, com o
    * campo vazio. Isso NAO eh descuido desta migracao nem descuido do
    * legado: campo vazio eh justamente o canal de CANCELAMENTO que o
    * chamador le ("caso nao tenha escolhido a operacao cancel o
    * processamento...", SIGCDBAL_form_codigo_fonte.txt:6016-6019). Por
    * isso o fechamento incondicional eh MANTIDO (PILAR 1) - o que nao
    * pode faltar eh a PUBLICACAO do resultado, abaixo.
    *
    * MessageBox(...,48,...) -> MsgAviso (mesmo icone 48; MESSAGEBOX
    * direto eh proibido no projeto e nao se suprime em modo de teste).
    *
    * Hide() e NAO Release(): com Release() o form se destroi junto com o
    * this_oBusinessObject, e o chamador - que acabou de desbloquear do
    * Show() modal - NAO TEM MAIS COMO LER a Operacao escolhida. O
    * FormParaBO() sozinho nao resolve: ele grava numa instancia de BO
    * que morre na mesma linha. Canonico do projeto para dialogo que
    * devolve valor: formbuscaauxiliar.prg:367-369 (BtnSelecionarClick =
    * flag + Hide(); quem solta eh o chamador). Sem isso o dialogo
    * "funciona" na tela e devolve NADA - falha silenciosa, sem erro e
    * sem log, exatamente a familia das regras #20/#42.
    *====================================================================
    PROCEDURE BtnOkClick()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))

        THIS.FormParaBO()

        IF EMPTY(loc_cValor)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!", ;
                "Campo Obrigat" + CHR(243) + "rio")
            THIS.txt_4c_DopEstq.SetFocus()

            *-- Campo vazio EH o canal de cancelamento do legado, entao
            *   passa pelo MESMO funil do cancelamento - nao existem duas
            *   versoes do que "cancelar" faz.
            THIS.BtnCancelarClick()
        ELSE
            THIS.PublicarOperacaoEscolhida(loc_cValor)
        ENDIF

        THIS.Hide()
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Funil UNICO de cancelamento.
    *
    * NAO eh botao novo: o SCX nao tem Cancelar, e inventar um violaria o
    * PILAR 1. Este eh o NOME do caminho de cancelamento que o legado JA
    * tem - sair do dialogo com o campo vazio -, extraido para um metodo
    * porque ha mais de uma entrada para ele (o Ok com campo em branco e
    * a morte da tela sem confirmacao, via QueryUnload) e porque o que
    * ele faz nao eh "nada": tem de deixar o CHAMADOR enxergando o
    * cancelamento.
    *
    * O chamador testa "Not Used('crOpera') Or IsEmpty(crOpera.Dopes)"
    * (SIGCDBAL_form_codigo_fonte.txt:6016). Como ele faz "Go Top" em
    * crOpera ao montar o cursor (SIGCDBAL:5484), NAO mexer na posicao
    * deixaria o cursor na PRIMEIRA operacao e o chamador leria o
    * cancelamento como "o usuario escolheu a operacao 1" - gravacao
    * errada, sem erro e sem log. Por isso cancelar passa valor VAZIO
    * para PublicarOperacaoEscolhida, que empurra crOpera para EOF: o
    * unico estado em que crOpera.Dopes le vazio.
    *
    * O campo digitado NAO eh apagado aqui (regras #37/#50) - quem
    * cancela ja esta saindo, e limpar a tela na saida nao ajuda
    * ninguem; o que vale eh o contrato publicado.
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.PublicarOperacaoEscolhida("")
    ENDPROC

    *====================================================================
    * PublicarOperacaoEscolhida - Entrega o resultado do dialogo nos DOIS
    * canais, porque o legado usa um e o sistema novo usa o outro:
    *
    *  (a) properties this_lConfirmado / this_cDopEstqSelecionado - o que
    *      um chamador MIGRADO le depois do Show() (ver o contrato
    *      transcrito no bloco de properties).
    *
    *  (b) o cursor "crOpera" do CHAMADOR, POSICIONADO - o canal do
    *      legado. O Valid legado fazia "Select CrOpera / Seek(...)" e
    *      era essa POSICAO que o SIGCDBAL lia em seguida, inclusive uma
    *      coluna que este dialogo nem exibe (crOpera.Estoqs,
    *      SIGCDBAL_form_codigo_fonte.txt:6132).
    *
    * O crOpera NAO eh criado aqui - ele eh do chamador (query FILTRADA:
    * "Where Parcs <> 1 And Opers = 3 And DigItens = 1 And Caixas <> 1").
    * Criar um cursor homonimo de 1 linha mascararia a lista filtrada do
    * chamador e faria o fluxo seguinte ler dado errado; por isso o canal
    * (b) so eh usado quando o cursor JA esta aberto, como no legado.
    *
    * POSICIONAR vale para os DOIS desfechos, e esse eh o ponto fino
    * (entrega (2) da Fase 8):
    *
    *   CONFIRMOU -> crOpera na linha escolhida.
    *   CANCELOU  -> crOpera em EOF. O chamador decide por
    *                "IsEmpty(crOpera.Dopes)" (SIGCDBAL:6016), e ele
    *                mesmo deu "Go Top" no cursor ao monta-lo
    *                (SIGCDBAL:5484): deixar a posicao intacta faria o
    *                cancelamento ser lido como "escolheu a PRIMEIRA
    *                operacao da lista". EOF eh o unico estado em que
    *                crOpera.Dopes le vazio - e LOCATE FOR .F. eh a
    *                forma de chegar la sem depender de indice nem do
    *                cursor ter registros.
    *
    * Codigo que NAO esta em crOpera tambem cai no ramo de cancelamento,
    * pelo mesmo motivo: o cursor ficaria parado onde estava e o chamador
    * leria a linha de OUTRA operacao sem perceber (regra #17). Com o
    * universo do lookup ja estreitado para crOpera (entrega (1) da Fase
    * 8), isto virou rede de seguranca: so alcanca quem digitou o codigo
    * e acionou o Ok sem o campo nunca ter sido validado.
    *
    * LOCATE e nao SEEK: o SEEK depende do TAG "Dopes" existir no cursor
    * do chamador, e com SET EXACT ON (config.prg) chave parcial em char
    * nao casa de forma confiavel (regra do INDEX/SEEK parcial). O LOCATE
    * por ALLTRIM compara o valor util e nao depende de indice nenhum.
    *====================================================================
    PROCEDURE PublicarOperacaoEscolhida(par_cValor)
        LOCAL loc_cValor, loc_lOk, loc_cAliasAnt, loc_oErro
        loc_cValor    = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
        loc_lOk       = NOT EMPTY(loc_cValor)
        loc_cAliasAnt = ALIAS()

        *-- Canal (b): posiciona o cursor do chamador, se ele existir.
        IF USED("crOpera") AND TYPE("crOpera.Dopes") = "C"
            TRY
                SELECT crOpera

                IF loc_lOk
                    LOCATE FOR UPPER(ALLTRIM(NVL(crOpera.Dopes, ""))) == UPPER(loc_cValor)

                    IF NOT FOUND()
                        loc_lOk = .F.
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o [" + loc_cValor + ;
                            "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
                            "vel para esta atualiza" + CHR(231) + CHR(227) + "o.", ;
                            "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
                    ENDIF
                ENDIF

                *-- Cancelamento (campo vazio, ou codigo fora do universo
                *   do chamador): EOF, para crOpera.Dopes ler vazio. O
                *   LOCATE acima ja deixa o cursor em EOF quando nao
                *   encontra, mas o caminho do campo VAZIO nao passa por
                *   ele - entao o reposicionamento tem de ser explicito.
                IF NOT loc_lOk
                    LOCATE FOR .F.
                ENDIF
            CATCH TO loc_oErro
                loc_lOk = .F.
                MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + ;
                    TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + ;
                    loc_oErro.Procedure, "Opera" + CHR(231) + CHR(227) + ;
                    "o para Atualiza" + CHR(231) + CHR(227) + "o")
            ENDTRY

            IF NOT EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF
        ENDIF

        *-- Canal (a): properties lidas pelo chamador migrado.
        THIS.this_lConfirmado         = loc_lOk
        THIS.this_cDopEstqSelecionado = IIF(loc_lOk, loc_cValor, "")
    ENDPROC


    *====================================================================
    * FormParaBO - Copia o unico campo de tela (txt_4c_DopEstq) para a
    * property correspondente do BO (this_cDopEstq / SigCdOpe.dopes).
    * PROTECTED como em FormBase: metodo protegido na base PREVALECE
    * sobre override sem modificador na subclasse (regra #51), entao
    * tentar "alargar" o escopo aqui seria ilusorio - o metodo eh
    * chamado so de dentro da classe (BtnOkClick).
    *====================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cDopEstq = ;
                ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * BOParaForm - Contraparte do FormParaBO: leva a property do BO
    * (this_cDopEstq / SigCdOpe.dopes) para o unico campo de tela.
    *
    * PROTECTED porque FormBase ja declara o hook assim, e PROTECTED na
    * base PREVALECE sobre override sem modificador na subclasse (regra
    * #51) - declarar sem o modificador daria a ILUSAO de metodo
    * publico. Os dois call sites sao internos: LimparCampos (estado
    * inicial, via InicializarForm) e qualquer recarga futura.
    *
    * Atribuir .Value sempre com string (NVL + ALLTRIM): TextBox criado
    * com .Value = "" eh CARACTERE, e deixar um .NULL. do banco chegar
    * ali trocaria o tipo do controle.
    *====================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_DopEstq.Value = ;
                ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDopEstq, ""))
            THIS.txt_4c_DopEstq.Refresh()
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * LimparCampos - Repoe o estado inicial do dialogo.
    *
    * NAO eh o LimparCampos de form CRUD (que alterna entre modo de
    * edicao e modo lista - aqui nao ha modos). Eh o ponto UNICO que
    * devolve a tela ao estado de abertura, e por isso cuida das TRES
    * coisas que compoem esse estado, nao so do campo:
    *
    *   1. o campo, que vem do BO (BOParaForm) e nao de um "" literal -
    *      assim a tela e a property nunca divergem;
    *   2. o memo de valor-ja-validado, que precisa voltar ao sentinela
    *      CHR(0) e nao a "": com "" o campo em branco passaria a contar
    *      como "ja validado" e a PRIMEIRA validacao nao aconteceria;
    *   3. o contrato de retorno, que tem de voltar a "nao confirmado" -
    *      resto de uma confirmacao anterior lido por um chamador novo
    *      eh exatamente a falha silenciosa que a Fase 8 veio fechar.
    *
    * NAO mexe em crOpera: o cursor eh do CHAMADOR e so
    * PublicarOperacaoEscolhida tem motivo para reposiciona-lo.
    *====================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_cUltimoDopEstqValidado = CHR(0)
        THIS.this_lConfirmado            = .F.
        THIS.this_cDopEstqSelecionado    = ""
        THIS.this_lEmLookup              = .F.

        THIS.BOParaForm()
    ENDPROC

    *====================================================================
    * Metodos CRUD-canonicos que NAO se aplicam a este dialogo (analise
    * fechada desde a Fase 3 e reconfirmada na consolidacao). SigOpAtu
    * eh um dialogo modal UNICO (1 campo + 1 botao), sem
    * Page1(Lista)/Page2(Dados), sem lista de registros e sem modos
    * INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR:
    *
    *   BtnSalvarClick/BtnBuscarClick/BtnEncerrarClick - convencao de
    *     form CRUD (Page1 "Lista" com Buscar/Encerrar, Page2 "Dados"
    *     com Salvar/Cancelar). O unico botao deste legado se chama
    *     "Ok" (Command1/cmd_4c_Command1 + BtnOkClick, Fase 6/8), e ele
    *     NAO grava: SigCdOpe eh consultada, nunca escrita por esta
    *     tela (ver cabecalho do SigOpAtuBO.prg).
    *   CarregarLista/AjustarBotoesPorModo - pressupoem grid de LISTA e
    *     modo atual (this_cModoAtual). analise.json confirma
    *     temGrid=false; layout.json nao declara nenhum BaseClass
    *     grid/pageframe. O cursor que a Fase 8 passou a montar
    *     (CarregarUniversoOperacoes) NAO eh uma lista da tela: ele
    *     existe so enquanto o picker esta aberto e eh fechado em
    *     seguida.
    *   HabilitarCampos - pressupoe alternancia entre modo de edicao e
    *     modo de consulta. Aqui ha UM campo, sempre editavel, e UM
    *     fluxo: o dialogo abre, o usuario digita ou escolhe a Operacao
    *     e confirma. Um HabilitarCampos aqui so poderia ser metodo sem
    *     chamador - stub, que o pipeline proibe.
    *
    * BtnCancelarClick e LimparCampos SAIRAM desta lista na Fase 8: os
    * dois ganharam conteudo e call site reais (ver cada um acima).
    *====================================================================

    *====================================================================
    * QueryUnload - Ultima linha de defesa do contrato de retorno.
    *
    * O caminho normal de saida eh BtnOkClick (Hide, nao Release), entao
    * este metodo so eh alcancado quando a tela morre SEM passar pelo
    * Ok - Release() externo, encerramento da aplicacao. Nesse caso o
    * chamador ainda vai ler crOpera, e um cursor parado na primeira
    * linha seria lido como escolha valida (mesmo defeito descrito em
    * BtnCancelarClick). Publicar o cancelamento aqui fecha esse flanco.
    *
    * A guarda por this_lConfirmado eh o que impede o estrago oposto:
    * depois de um Ok bem-sucedido, o Release do chamador tambem passa
    * por aqui, e sem a guarda o EOF apagaria a escolha que acabou de
    * ser publicada.
    *====================================================================
    PROCEDURE QueryUnload()
        IF NOT THIS.this_lConfirmado
            THIS.BtnCancelarClick()
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * Destroy - Fecha o cursor do picker (AbrirLookupDopEstq ja o fecha
    * no caminho normal; aqui cobre a saida por excecao) e delega ao
    * FormBase, que libera o Business Object e rebuilda os popups do
    * menu principal (fix menu-shrinks de forms modais).
    *
    * crOpera NAO eh fechado: o cursor eh do CHAMADOR, que continua
    * lendo dele depois que este dialogo morre.
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

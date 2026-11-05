*==============================================================================
* Formsigopftc.prg - Formulario Operacional: Ficha de Complementos da
* Movimentacao (Ficha Tecnica)
* Herda de: FormBase
* Origem:  SIGOPFTC.SCX
* BO:      sigopftcBO.prg (SigCdCet)
*
* Dialogo filho aberto por um form de movimentacao/pedido, para coletar as
* respostas da "ficha tecnica" (caracteristicas cadastradas em SigCdFtc)
* associadas a uma Operacao (SigCdOpe.Dopes), para o cliente corrente.
*
* O legado cria uma janela filha (frmbarcta) com um container de scroll
* (ScrollBarContainer.ScrollSlide) onde monta, em runtime, um par
* Label+Memo/TextBox por caracteristica (MontaFichaTecnica). Esse container
* dinamico equivale aqui a cnt_4c_AreaFicha (fase 3: criado vazio; as fases
* seguintes populam os controles via AddObject em SCAN, igual ao legado).
*
* MIGRADO (Fases 3-4/8):
*   - DEFINE CLASS + propriedades visuais (dimensoes exatas do legado,
*     800x500 - dialogo flutuante, NAO segue o canonico 1000x600 de
*     frmcadastro, que nao se aplica a este form)
*   - Init(par_cTipoAcao, par_cOperacao, par_cIclis) / InicializarForm / Destroy
*   - ConfigurarCabecalho (cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo,
*     mapeamento.json)
*   - ConfigurarAreaFicha (cnt_4c_AreaFicha - container vazio que recebera
*     os campos dinamicos da ficha tecnica nas proximas fases)
*   - TornarControlesVisiveis recursivo
*   - FASE 4: ConfigurarContainerBotoes COMPLETO - cmg_4c_Botoes com os 2
*     botoes do cntBotoes legado (Caption/Picture/fonte/cor/TabIndex/Cancel
*     transcritos do dump) e os BINDEVENT de Click; BtnCancelarClick (que a
*     Fase 4 chamou BtnSairClick - ver Fase 8, nomear pela ACAO) e
*     BtnConfirmarClick (os dois Click do legado); GravarFichaTecnica e
*     CarregarRespostasGravadas (gravafichatecnica legado -> INSERT em
*     SigCdCet via sigopftcBO)
*
* ESTE FORM NAO TEM GRID NEM BOTOES CRUD - e nao deve ter. O SCX legado tem
* EXATAMENTE 4 objetos visuais (cntSombra + lblSombra + lblTitulo + cntBotoes):
* zero objeto de BaseClass grid/pageframe, zero controle de entrada de dados e
* zero AddCursor/pColuna/RecordSource/ControlSource. A estrutura Lista/Dados
* com 6 botoes CRUD do frmcadastro teria de ser INVENTADA (viola o PILAR 1), e
* os campos da ficha nao sao desenhados no SCX: o legado os cria em RUNTIME no
* MontaFichaTecnica (fases 5-6). O que a Fase 4 acrescenta aqui sao os botoes
* de acao que o legado realmente tem - Confirmar e Cancelar - com a logica de
* gravacao do btnConfirmar.
*
* MIGRADO (Fase 7/8) - eventos PRINCIPAIS do dialogo. Os quatro nomes de
* convencao Btn<Incluir|Alterar|Visualizar|Excluir> + Click NAO existem
* aqui e nao devem existir: o SCX legado tem DOIS botoes (Confirmar/Cancelar,
* ja na Fase 4) e ZERO superficie CRUD - inventa-los violaria o PILAR 1 e
* criar metodo vazio e proibido pela regra de completude. Os eventos
* principais deste form sao os metodos do PROPRIO SCX, chamados pelo form PAI
* de movimentacao, todos PUBLIC por isso (regra #51):
*   - ChecarFichaTecnica(par_cTipo)  (checarfichatecnica - "GRUPO_OP"/
*     "MOSTRARFORM"; o gatilho central, que decide montar ou nao a ficha)
*   - MontarFichaTecnica / CarregarFichaTecnica / DesmontarFichaTecnica
*     (montafichatecnica/carregafichatecnica/desmontafichatecnica - criam,
*     preenchem e removem em RUNTIME os controles mem_4c_Ficha<COrds> que a
*     Fase 4 ja le em GravarFichaTecnica)
*   - ValidarFichaTecnica (validafichatecnica - tamanho minimo da resposta)
*   - MostrarForm / OcultarForm (mostrarform/ocultarform)
* e os carregadores de dados que esses eventos usam:
* CarregarOperacaoComFicha (cnSigCdOpe), CarregarCaracteristicas
* (crTmpFicha) e RespostaEhFixa (crResp de SigCdFtr).
*
* As Fases 5 e 6 do pipeline nao produziram codigo (os fase_5_output.txt e
* fase_6_output.txt de tasks\task737 registram o agente sem prompt de tarefa),
* entao os campos dinamicos - que seriam delas - entraram aqui: sem eles
* ChecarFichaTecnica chamaria um metodo inexistente (regra #13) e o Confirmar
* da Fase 4 nunca teria cursor_4c_Ficha para percorrer.
*
* LIMITE CONHECIDO, registrado (nao e omissao silenciosa): a janela de scroll
* do legado - frmbarcta, com ScrollBarContainer/VerticalScrollBar - NAO foi
* portada para o projeto novo, assim como fwprogressbar precisou de stub. Os
* campos sao empilhados em cnt_4c_AreaFicha e o excedente fica recortado se a
* ficha for mais alta que o container; o pnCaixa/plSelecao do fweditbox legado
* (lista de respostas pre-cadastradas) tambem depende dessa classe. Ver
* MontarFichaTecnica.
*
* MIGRADO (Fase 8/8) - CONSOLIDACAO. Nenhum metodo novo inventa superficie: os
* quatro acrescentados sao o FUNIL dos blocos que as fases anteriores tinham
* inline e duplicado, o que elimina a chance de dois deles montarem nomes de
* controle diferentes (a armadilha que a regra #42 descreve para chave e que
* vale igual para nome de objeto montado em runtime):
*   - CarregarLista()        - ponto UNICO de (re)carga da lista de
*     caracteristicas: desmonta o que esta na tela, recarrega cursor_4c_Operacao
*     e remonta/repinta a ficha. Eh exatamente o bloco "If llOks / If Not
*     Empty(Operacao)" do checarfichatecnica legado, extraido para ter ponto de
*     recarga. PUBLIC (regra #3: o harness TesteAutomatico.prg chama
*     THIS.oForm.CarregarLista() de FORA da classe).
*   - FormParaBO()           - le a linha corrente de cursor_4c_Ficha MAIS o
*     valor do campo mem_4c_Ficha<COrds> da tela para as properties do BO.
*     Eh o "lcVal = loObjForm1.&lcObj..Value" + o "Insert Into crSigCdCeT (...)
*     Values (<campos>)" do gravafichatecnica legado, que estava inline em
*     GravarFichaTecnica.
*   - BOParaForm()           - o inverso: joga this_cResps do BO no campo da
*     tela respeitando this_cTpDados. Eh o corpo do carregafichatecnica legado
*     ("loObjForm1.&lcObj..Value = lcVal / .Refresh").
*   - BtnCancelarClick()     - renomeado de BtnSairClick. O objeto legado
*     chama-se btnSair, mas o Caption que o usuario le eh "\<Cancelar": o
*     handler migrado tem de levar o nome da ACAO, nunca o Name do objeto
*     legado (PILAR 3). O corpo continua o "ThisForm.Release" do legado.
* e os tres auxiliares que esses quatro compartilham:
*   - ObterControleResposta(par_nCords) - monta o nome mem_4c_Ficha<COrds> e
*     devolve a REFERENCIA do controle (ou .NULL.). Fonte unica dos cinco sites
*     que antes repetiam o par PEMSTATUS + EVALUATE (regras #15/#34).
*   - LerRespostaDaTela(par_nCords, par_cTpDados) - valor do campo JA
*     normalizado para char, com o "lcVal = Dtoc(lcVal)" do legado aplicado
*     quando cTpDados = "D". Fonte unica da conversao que estava triplicada em
*     GravarFichaTecnica, CarregarFichaTecnica e ValidarFichaTecnica.
*   - CarregarLinhaFichaNoBO() - linha corrente de cursor_4c_Ficha ->
*     properties do BO (o espelho de crTmpFicha que a Fase 1 declarou).
*   - HabilitarCampos(par_lHabilitar) - liga/desliga em bloco a edicao dos
*     campos da ficha. Eh o "ReadOnly = Not InList(pcEscolha,'INSERIR',
*     'ALTERAR')" que o legado aplica controle a controle no montafichatecnica,
*     com fonte UNICA e respeitando a resposta FIXA (SigCdFtr.nResps = 1), que
*     continua somente-leitura em qualquer modo - a marca fica no .Tag do
*     controle ("FIXA"), que em TextBox/EditBox so aceita Character.
*     PUBLIC pela mesma razao de CarregarLista.
*
* O QUE NAO SE APLICA a este form, e por que (nao e omissao - os nomes abaixo
* sao convencao de form CRUD "frmcadastro" e aqui teriam de ser INVENTADOS,
* violando o PILAR 1, ou criados vazios, proibido pela regra de completude):
*   - Btn<Incluir|Alterar|Visualizar|Excluir>Click e BtnBuscarClick: o SCX
*     legado tem DOIS botoes (btnSair/btnConfirmar) e ZERO superficie CRUD -
*     sem Grid, sem PageFrame, sem AddCursor/pColuna, sem Page1/Page2.
*   - BtnSalvarClick: o botao de gravar deste legado chama-se "Confirmar"
*     (Caption "\<Confirmar") e o handler leva o nome da acao dele -
*     BtnConfirmarClick, ja na Fase 4. Nao existe btnSalvar/btnGravar nem
*     mGravaDados no dump.
*   - BtnEncerrarClick: o unico botao que fecha a tela e o "Cancelar"
*     (Cancel = .T., responde ESC) - dar a ele um segundo nome faria o metodo
*     mentir sobre qual botao do legado ele atende.
*   - LimparCampos: no legado o que "limpa" a ficha e o desmontafichatecnica,
*     que REMOVE os controles em vez de zerar valores (ja migrado em
*     DesmontarFichaTecnica). Um LimparCampos aqui nao teria chamador algum.
*   - AjustarBotoesPorModo: o legado nao mexe no Enabled de botao nenhum em
*     funcao de pcEscolha - o que varia por modo e a EDICAO dos campos, e isso
*     e HabilitarCampos. O que o modo decide (PROCURAR nao monta ficha) ja
*     esta transcrito em MontarFichaTecnica/DesmontarFichaTecnica.
*
* DIVERGENCIA DELIBERADA acrescentada pela Fase 8, declarada: CarregarLista
* comeca por DesmontarFichaTecnica(). No legado, a chamada
* ChecarFichaTecnica([GRUPO_OP]) com pcEscolha <> INSERIR liga llOks SEM
* passar pelo DesmontaFichaTecnica, entao uma SEGUNDA chamada remontaria a
* ficha sobre os controles que ja existem - e AddObject com nome repetido
* estoura "Object ... is already defined" e mata o dialogo. DesmontarFichaTecnica
* ja se protege por this_lMontouCampos, logo a chamada e no-op no caminho em
* que o legado desmonta antes; ela so AGE justamente no caminho que o legado
* deixou quebrado. Tem de vir ANTES da recarga: o Desmontar le o cursor
* cursor_4c_Ficha ANTIGO para saber quais objetos remover, e
* CarregarCaracteristicas substitui esse cursor.
*==============================================================================

DEFINE CLASS Formsigopftc AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form (dimensoes exatas do legado - dialogo
    * flutuante, nao e frmcadastro)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 800
    Height       = 500
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    WindowType   = 1
    AlwaysOnTop  = .T.
    KeyPreview   = .T.
    Themes       = .F.
    FontName     = "Verdana"
    FontSize     = 8
    BorderStyle  = 2
    Caption      = "Ficha de Complementos da Movimenta" + CHR(231) + CHR(227) + "o"

    *--------------------------------------------------------------------------
    * Propriedades de estado (espelham as properties customizadas do legado:
    * pcEscolha/Operacao/CriouForm/PrimeiraEntrada/MontouCampos). O cliente
    * (IClis) era lido do cursor global crSigCdCli do form pai no legado;
    * aqui vem explicito por parametro para nao depender de cursor global.
    *--------------------------------------------------------------------------
    this_oBusinessObject   = .NULL.
    this_cTipoAcao         = ""    && pcEscolha herdado do form pai: INSERIR/ALTERAR/CONSULTAR/PROCURAR
    this_cOperacao         = ""    && Dopes: codigo da Operacao (SigCdOpe.Dopes)
    this_cIclis            = ""    && codigo do cliente (SigCdCli.IClis)
    this_lCriouForm        = .F.   && .T. apos ConfigurarAreaFicha criar o container dinamico
    this_lPrimeiraEntrada  = .T.
    this_lMontouCampos     = .F.

    *==========================================================================
    * Init - Recebe o contexto do form pai e cria o Business Object
    * par_cTipoAcao : INSERIR / ALTERAR / CONSULTAR / PROCURAR (pcEscolha legado)
    * par_cOperacao : codigo da Operacao (Dopes/CGrus - pcDopes legado)
    * par_cIclis    : codigo do cliente (IClis)
    *==========================================================================
    FUNCTION Init(par_cTipoAcao, par_cOperacao, par_cIclis)
        THIS.this_cTipoAcao = IIF(VARTYPE(par_cTipoAcao) = "C", par_cTipoAcao, "")
        THIS.this_cOperacao = IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")
        THIS.this_cIclis    = IIF(VARTYPE(par_cIclis) = "C", par_cIclis, "")

        THIS.this_oBusinessObject = CREATEOBJECT("sigopftcBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar sigopftcBO.", "Erro")
            RETURN .F.
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_cTipoAcao = THIS.this_cTipoAcao
            .this_cOperacao = THIS.this_cOperacao
            .this_cIclis    = THIS.this_cIclis
        ENDWITH

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do dialogo
    * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainerBotoes()
            THIS.ConfigurarAreaFicha()

            THIS.TornarControlesVisiveis(THIS)

            *-- Legado (Init): ThisForm.CriarForm() seguido de
            *-- Thisform.MostrarForm() - eh o MostrarForm que dispara
            *-- ChecarFichaTecnica("MOSTRARFORM") e MONTA os campos da ficha.
            *-- ConfigurarAreaFicha acima equivale ao CriarForm (cria o
            *-- container e liga this_lCriouForm).
            *--
            *-- Em modo de teste/validacao de UI nao ha conexao SQL: montar a
            *-- ficha exigiria SigCdFtc/SigOpFtc e o erro abortaria o Init,
            *-- fazendo CREATEOBJECT devolver .F. e a tela nao abrir.
            IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) ;
               AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.MostrarForm()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
    * cnt_4c_Sombra: Top=0 Left=0 Width=THIS.Width Height=80 BackColor=RGB(100,100,100)
    * Nomes conforme mapeamento.json (task737).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top        = 18
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 40
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(0, 0, 0)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top        = 17
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 46
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(255, 255, 255)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoes - CommandGroup dos botoes de acao do dialogo
    * (cntBotoes legado -> cmg_4c_Botoes).
    *
    * Transcrito do dump de SIGOPFTC.cntBotoes (task737):
    *   grupo      : Top=-2 Left=645 Width=160 Height=85 ButtonCount=2 Value=0
    *                BackStyle=0 BorderStyle=0 SpecialEffect=1
    *                BorderColor=136,189,188 Themes=.F. TabIndex=2
    *   Command1 = btnSair      -> Buttons(1): Top=5 Left=80 75x75, Cancel=.T.,
    *                Picture=cadastro_sair_60.jpg,   TabIndex=2, SpecialEffect=0
    *   Command2 = btnConfirmar -> Buttons(2): Top=5 Left=5  75x75,
    *                Picture=cadastro_salvar_60.jpg, TabIndex=1
    *
    * A ORDEM dos botoes eh a do legado - Cancelar em Buttons(1) e Confirmar em
    * Buttons(2). Inverter trocaria Left/TabIndex/Cancel e mudaria a tela.
    *
    * O grupo recebe AutoSize = .F. com a Width/Height do dump: esses numeros
    * JA SAO o auto-size calculado pelo Form Designer, e AutoSize = .T. em
    * objeto criado por AddObject descarta a geometria declarada (regra #23).
    * A geometria dos botoes INTERNOS eh aplicada ANTES da do grupo (regra #31).
    *
    * CommandGroup nao tem FontName nem ForeColor - as duas moram nos botoes
    * (regra #33); por isso fonte e cor sao definidas em cada Buttons(N).
    * Os Picture vem do dump legado, nunca de palpite semantico (regra #25):
    * "Cancelar" usa cadastro_sair_60.jpg e "Confirmar" cadastro_salvar_60.jpg,
    * ambos conferidos em vbmp\.
    *
    * Criado DEPOIS de cnt_4c_Sombra de proposito: com Top=-2 os botoes caem
    * sobre a area da faixa do cabecalho (0..80) e so aparecem desenhando por
    * cima dela - a mesma ordem do SCX legado (regra #11).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoes()
        LOCAL loc_oCmg

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Botoes

        loc_oCmg.ButtonCount = 2

        *-- Buttons(1) = btnSair legado: "\<Cancelar", Cancel = .T. (responde ESC)
        WITH loc_oCmg.Buttons(1)
            .Top           = 5
            .Left          = 80
            .Width         = 75
            .Height        = 75
            .Caption       = "\<Cancelar"
            .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .MousePointer  = 15
            .Cancel        = .T.
            .TabIndex      = 2
            .ToolTipText   = "[Esc] Encerrar"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Buttons(2) = btnConfirmar legado: "\<Confirmar"
        WITH loc_oCmg.Buttons(2)
            .Top           = 5
            .Left          = 5
            .Width         = 75
            .Height        = 75
            .Caption       = "\<Confirmar"
            .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .MousePointer  = 15
            .TabIndex      = 1
            .ToolTipText   = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Geometria do grupo DEPOIS dos botoes internos (regra #31)
        WITH loc_oCmg
            .Top           = -2
            .Left          = 645
            .Width         = 160
            .Height        = 85
            .AutoSize      = .F.
            .Value         = 0
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .TabIndex      = 2
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Handlers dos dois Click do legado. Os metodos alvo sao PUBLIC
        *-- (regra #3: BINDEVENT nao alcanca metodo PROTECTED).
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnCancelarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarAreaFicha - Container vazio que recebera os campos dinamicos
    * da ficha tecnica (equivalente ao poWindowOpe.ScrollBarContainer.ScrollSlide
    * do legado). Fases seguintes populam via AddObject em SCAN de
    * crTmpFicha/cursor_4c_Ficha (MontarFichaTecnica).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaFicha()
        THIS.AddObject("cnt_4c_AreaFicha", "Container")
        WITH THIS.cnt_4c_AreaFicha
            .Top         = 80
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height - 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.this_lCriouForm = .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda hierarquia
    * Form flat sem containers flutuantes, portanto sem lista de skip.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Click de cntBotoes.btnConfirmar (Command2) legado
    *
    * Legado (SIGOPFTC.cntBotoes.btnConfirmar.Click):
    *     If( ThisForm.CriouForm )
    *         This.Gravafichatecnica()
    *     Endif
    *
    * Transcrito como esta: o legado NAO fecha o dialogo ao confirmar e NAO
    * chama ValidaFichaTecnica aqui (a validacao de tamanho minimo da resposta
    * eh disparada pelo form pai, fase 7-8). PUBLIC por ser alvo de BINDEVENT
    * (regra #3).
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        IF THIS.this_lCriouForm
            THIS.GravarFichaTecnica()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Click de cntBotoes.btnSair (Command1) legado
    * Legado: ThisForm.Release
    *
    * Nomeado pela ACAO, nao pelo Name do objeto legado: o objeto chama-se
    * btnSair, mas o Caption que o usuario le e "\<Cancelar" e o botao tem
    * Cancel = .T. (responde ESC). Herdar "BtnSairClick" violaria o PILAR 3 e
    * esconderia de quem le qual botao da tela o metodo atende. O corpo e o do
    * legado - abandonar o dialogo sem gravar nada; nada a desfazer, porque a
    * gravacao so acontece no Confirmar.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ChecarFichaTecnica - Evento PRINCIPAL do dialogo (checarfichatecnica)
    *
    * Transcricao de SIGOPFTC.checarfichatecnica (task737):
    *     Lparameters pTip
    *     lcArea = Alias()
    *     llOks = .f.
    *     If ((pTip = [GRUPO_OP]) And (ThisForm.pcEscolha <> [INSERIR]))
    *         llOks = .t.
    *     EndIf
    *     If Not llOks And InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR], ;
    *                             [CONSULTAR]) And ThisForm.PrimeiraEntrada ;
    *                             And ThisForm.CriouForm
    *         This.DesmontaFichaTecnica
    *         ThisForm.PrimeiraEntrada = .f.
    *         llOks = .t.
    *     EndIf
    *     If llOks
    *         If Not Empty(ThisForm.Operacao)
    *             <query SigCdOpe + SigCdFtc -> cnSigCdOpe>
    *             If (SqlExecute(...) < 1) / MessageBox('Favor Reinicializar o
    *                 Processo!!!') / Return .f.
    *             Select cnSigCdOpe / Go Top
    *             If Not This.MontaFichaTecnica(ThisForm.Operacao)
    *                 Select &lcArea / Return 0
    *             EndIf
    *         EndIf
    *     EndIf
    *     If !Empty(lcArea) / Select &lcArea / Endif
    *
    * par_cTipo eh o pTip legado - o TAG de texto que identifica QUEM chamou:
    * "GRUPO_OP" quando o disparo vem da barra de acao do form PAI e
    * "MOSTRARFORM" quando vem do proprio MostrarForm. NAO eh objeto nenhum:
    * eh literal comparado com "=", por isso nao implica superficie CRUD neste
    * form (o SCX tem 4 objetos visuais e dois botoes - Confirmar/Cancelar).
    *
    * PUBLIC: o form PAI chama este metodo de fora (no legado,
    * "ThisForm.ChecarFichaTecnica([GRUPO_OP])") - metodo PROTECTED alcancado
    * de fora estoura "Property CHECARFICHATECNICA is not found" (regra #51).
    *==========================================================================
    PROCEDURE ChecarFichaTecnica(par_cTipo)
        LOCAL loc_lSucesso, loc_lOks, loc_cTipo, loc_cArea, loc_oErro

        loc_lSucesso = .T.
        loc_cArea    = ALIAS()
        loc_cTipo    = UPPER(ALLTRIM(IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")))
        loc_lOks     = .F.

        TRY
            IF loc_cTipo == "GRUPO_OP" AND UPPER(ALLTRIM(THIS.this_cTipoAcao)) != "INSERIR"
                loc_lOks = .T.
            ENDIF

            IF !loc_lOks ;
               AND INLIST(UPPER(ALLTRIM(THIS.this_cTipoAcao)), "INSERIR", "ALTERAR", "CONSULTAR") ;
               AND THIS.this_lPrimeiraEntrada AND THIS.this_lCriouForm
                THIS.DesmontarFichaTecnica()
                THIS.this_lPrimeiraEntrada = .F.
                loc_lOks = .T.
            ENDIF

            IF loc_lOks AND !EMPTY(ALLTRIM(THIS.this_cOperacao))
                *-- Legado: query cnSigCdOpe + Go Top + MontaFichaTecnica. O
                *-- bloco inteiro mora em CarregarLista (ponto UNICO de carga),
                *-- para o form pai e o harness terem como recarregar a ficha
                *-- sem repetir a sequencia - e para a recarga nunca acontecer
                *-- sem o Desmontar que a remontagem exige.
                loc_lSucesso = THIS.CarregarLista()
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.ChecarFichaTecnica")
        ENDTRY

        *-- Legado: If !Empty(lcArea) / Select &lcArea
        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MostrarForm - Exibe a ficha tecnica (mostrarform legado)
    *
    * Legado:
    *     If ThisForm.CriouForm
    *         ThisForm.ChecarFichaTecnica([MOSTRARFORM])
    *         ThisForm.Top = This.Top + 60
    *         ThisForm.ZOrder(1)
    *         ThisForm.Refresh
    *     EndIf
    *
    * DIVERGENCIA DELIBERADA, registrada: o "ThisForm.Top = This.Top + 60" e o
    * ZOrder(1) do legado sao empilhamento de JANELA - posicionam o form sobre
    * a janela filha frmbarcta (poWindowOpe), que hospeda o container de
    * scroll. Aqui esse container eh filho do PROPRIO form (cnt_4c_AreaFicha),
    * nao outra janela, e o form tem AutoCenter = .T.: deslocar o Top a cada
    * chamada faria a tela DESCER 60px por vez. Nao se transcreve o Top.
    *
    * O ZOrder(1) (= mandar para TRAS) DO CONTAINER nao eh transcricao do
    * legado e sim consequencia da ordem de AddObject deste form:
    * cnt_4c_AreaFicha eh criado DEPOIS de cmg_4c_Botoes, e os dois se cruzam
    * em 80..83 (botoes em Top = -2 + Height 85; area da ficha em Top = 80).
    * Como o container eh BackStyle = 0, ele nao PINTA nada - mas, estando por
    * cima, intercepta o clique nessa faixa de 3px da base dos botoes (mesmo
    * efeito da caixa transparente da regra #23). ZOrder(1) devolve a faixa aos
    * botoes sem mexer na geometria transcrita do SCX.
    *
    * PUBLIC: chamado de fora pelo form pai (legado: "Thisform.MostrarForm()").
    *==========================================================================
    PROCEDURE MostrarForm()
        LOCAL loc_lSucesso

        loc_lSucesso = .T.

        IF THIS.this_lCriouForm
            loc_lSucesso = THIS.ChecarFichaTecnica("MOSTRARFORM")

            THIS.cnt_4c_AreaFicha.Visible = .T.
            THIS.cnt_4c_AreaFicha.ZOrder(1)
            THIS.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * OcultarForm - Oculta a ficha tecnica (ocultarform legado)
    *
    * Legado: If ThisForm.CriouForm / ThisForm.poWindowOpe.Top = This.Top + 600
    * O legado "esconde" a janela filha jogando-a 600px para baixo (fora da
    * area visivel) porque frmbarcta nao pode ser fechada sem perder os campos
    * montados. Com o container no proprio form, o equivalente exato eh
    * Visible = .F.: os controles continuam montados (MontouCampos segue .T.)
    * e voltam com MostrarForm.
    *
    * PUBLIC: chamado de fora pelo form pai.
    *==========================================================================
    PROCEDURE OcultarForm()
        IF THIS.this_lCriouForm
            THIS.cnt_4c_AreaFicha.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * MontarFichaTecnica - Cria em RUNTIME um campo por caracteristica
    * (montafichatecnica legado, 182 linhas)
    *
    * Equivalencias da transcricao:
    *   crTmpFicha  -> cursor_4c_Ficha (CarregarCaracteristicas)
    *   loObjForm1  -> THIS.cnt_4c_AreaFicha (no legado,
    *                  poWindowOpe.ScrollBarContainer.ScrollSlide)
    *   sayFicha<N> -> lbl_4c_CarFicha<N>  (titulo da caracteristica)
    *   shpFicha<N> -> shp_4c_CarFicha<N>  (linha separadora)
    *   lblFicha<N> -> lbl_4c_Ficha<N>     (pergunta)
    *   memFicha<N> -> mem_4c_Ficha<N>     (resposta - CONTRATO lido por
    *                  GravarFichaTecnica/CarregarFichaTecnica/
    *                  ValidarFichaTecnica)
    *   [Say]       -> Label (classe say do framework legado)
    *   [fweditbox] -> EditBox (mesma troca aplicada no FormSigPrEml)
    *   [fwget]     -> TextBox com InputMask "99/99/9999"
    *
    * Cada Label leva AutoSize = .F. com Width/Height EXPLICITOS: AutoSize eh
    * NO-OP em objeto criado por AddObject (regra #23) - e o legado avanca o
    * lnTop pela .Height do Label, que sem isso viria do default e empilharia
    * os campos errado.
    *
    * O nome de cada controle eh montado em runtime, entao a referencia sai de
    * EVALUATE (regras #15 e #34: Controls(<nome>) nao funciona e EVALUATE eh a
    * forma correta de LEITURA - aqui devolvendo a REFERENCIA do objeto, que
    * depois recebe atribuicao normal).
    *
    * LIMITE CONHECIDO, registrado: a janela de scroll do legado (frmbarcta,
    * com ScrollBarContainer/VerticalScrollBar) NAO foi portada - essa classe
    * nao existe no projeto novo. Os campos sao empilhados em cnt_4c_AreaFicha
    * e, se a soma das alturas passar da altura do container, o excedente fica
    * RECORTADO (regra #30). O legado fecha com "SetSlideTop(0, ...)" (rolar
    * para o topo), que aqui nao tem equivalente. Portar frmbarcta eh
    * pre-requisito para ficha com muitas caracteristicas.
    *==========================================================================
    PROCEDURE MontarFichaTecnica(par_cOperacao)
        LOCAL loc_lSucesso, loc_cArea, loc_cDopes, loc_nTop, loc_nLef, loc_nWid
        LOCAL loc_cCar, loc_cObj, loc_nHei, loc_cPerg, loc_oCtrl, loc_oArea
        LOCAL loc_lRespFixa, loc_lEditavel, loc_oErro

        loc_lSucesso = .F.
        loc_cArea    = ALIAS()

        TRY
            IF THIS.this_lCriouForm AND UPPER(ALLTRIM(THIS.this_cTipoAcao)) != "PROCURAR"
                loc_cDopes = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20)

                IF THIS.CarregarCaracteristicas(loc_cDopes)
                    loc_oArea = THIS.cnt_4c_AreaFicha
                    loc_nTop  = 1
                    loc_nLef  = 6
                    loc_nWid  = loc_oArea.Width - 14
                    loc_cCar  = ""

                    *-- Legado: ReadOnly = Not InList(pcEscolha,'INSERIR','ALTERAR')
                    loc_lEditavel = INLIST(UPPER(ALLTRIM(THIS.this_cTipoAcao)), "INSERIR", "ALTERAR")

                    THIS.this_lMontouCampos = .T.

                    SELECT cursor_4c_Ficha
                    GO TOP IN cursor_4c_Ficha
                    SCAN
                        *-- Troca de caracteristica: titulo + linha separadora
                        IF loc_cCar != NVL(cursor_4c_Ficha.ccars, "")
                            loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
                            loc_nTop = loc_nTop + 1

                            loc_cObj = "lbl_4c_CarFicha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
                            loc_oArea.AddObject(loc_cObj, "Label")
                            loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
                            WITH loc_oCtrl
                                .AutoSize  = .F.
                                .Top       = loc_nTop
                                .Left      = 1
                                .Width     = loc_nWid
                                .Height    = 18
                                .Caption   = PROPER(ALLTRIM(loc_cCar))
                                .FontName  = "Tahoma"
                                .FontSize  = 9
                                .FontBold  = .T.
                                .Alignment = 0
                                .BackStyle = 0
                                .ForeColor = RGB(0, 0, 128)
                                .Visible   = .T.
                                loc_nTop   = loc_nTop + .Height
                            ENDWITH

                            loc_cObj = "shp_4c_CarFicha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
                            loc_oArea.AddObject(loc_cObj, "Shape")
                            loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
                            WITH loc_oCtrl
                                .Top           = loc_nTop
                                .Left          = 1
                                .Width         = loc_nWid + 9
                                .Height        = 2
                                .SpecialEffect = 0
                                .Visible       = .T.
                                loc_nTop       = loc_nTop + .Height + 2
                            ENDWITH
                        ENDIF

                        *-- Pergunta (Descrs de SigPrCpP; sem cadastro, o CTits)
                        loc_cObj = "lbl_4c_Ficha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
                        loc_oArea.AddObject(loc_cObj, "Label")
                        loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
                        WITH loc_oCtrl
                            .AutoSize  = .F.
                            .Top       = loc_nTop
                            .Left      = loc_nLef + 4
                            .Width     = loc_nWid - 10
                            .Height    = 14
                            .Caption   = PROPER(ALLTRIM(IIF(!EMPTY(NVL(cursor_4c_Ficha.descrs, "")), ;
                                                            NVL(cursor_4c_Ficha.descrs, ""), ;
                                                            NVL(cursor_4c_Ficha.ctits, ""))))
                            .FontName  = "Tahoma"
                            .FontSize  = 8
                            .FontBold  = .T.
                            .Alignment = 0
                            .BackStyle = 0
                            .ForeColor = RGB(0, 0, 128)
                            .Visible   = .T.
                            loc_cPerg  = .Caption
                        ENDWITH
                        loc_nTop = loc_nTop + 12

                        *-- Resposta. Legado: lnHei = Iif(CLins = 1, 23,
                        *-- ((CLins - 1) * 16) + 23)
                        loc_nHei = IIF(NVL(cursor_4c_Ficha.clins, 0) = 1, 23, ;
                                       ((NVL(cursor_4c_Ficha.clins, 0) - 1) * 16) + 23)

                        loc_cObj = "mem_4c_Ficha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))

                        IF UPPER(ALLTRIM(NVL(cursor_4c_Ficha.ctpdados, ""))) == "D"
                            *-- Legado: [fwget] com InputMask 99/99/9999,
                            *-- Format [E] e Value Ctod([])
                            loc_oArea.AddObject(loc_cObj, "TextBox")
                            loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
                            WITH loc_oCtrl
                                .Top         = loc_nTop
                                .Left        = loc_nLef
                                .Width       = 80
                                .Height      = loc_nHei
                                .Value       = {}
                                *-- Format/InputMask transcritos do legado -
                                *-- descartar o par faz o campo aceitar
                                *-- qualquer coisa (regra #49). "E" = data no
                                *-- formato britanico (dd/mm/aaaa)
                                .Format      = "E"
                                .InputMask   = "99/99/9999"
                                .MaxLength   = 10
                                *-- ReadOnly e de HabilitarCampos (fonte unica,
                                *-- chamado no fim do SCAN). Campo de data nao
                                *-- tem resposta FIXA no legado - o SigCdFtr so
                                *-- eh consultado no ramo de texto -, entao o
                                *-- Tag de marcacao sai vazio.
                                .Tag         = ""
                                .ToolTipText = loc_cPerg
                                .Visible     = .T.
                            ENDWITH
                        ELSE
                            *-- Legado: pergunta com resposta FIXA cadastrada
                            *-- (SigCdFtr.nResps = 1) entra somente-leitura
                            loc_lRespFixa = THIS.RespostaEhFixa(loc_cDopes, ;
                                                NVL(cursor_4c_Ficha.ccars, ""), ;
                                                NVL(cursor_4c_Ficha.ctits, ""))

                            loc_oArea.AddObject(loc_cObj, "EditBox")
                            loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
                            WITH loc_oCtrl
                                .Top         = loc_nTop
                                .Left        = loc_nLef
                                .Width       = loc_nWid
                                .Height      = loc_nHei
                                .Value       = ""
                                .ScrollBars  = 2
                                *-- Resposta FIXA cadastrada (SigCdFtr.nResps =
                                *-- 1) fica somente-leitura em QUALQUER modo: a
                                *-- marca vai no .Tag para HabilitarCampos nao
                                *-- destravar o campo depois. Tag de
                                *-- TextBox/EditBox so aceita Character.
                                .Tag         = IIF(loc_lRespFixa, "FIXA", "")
                                .ToolTipText = loc_cPerg
                                .Visible     = .T.

                                *-- MaxLength vem do CADASTRO (SigCdFtc.Maxs) e,
                                *-- sem cadastro, do tamanho da coluna de origem
                                *-- SigCdFtr.resps char(254) - nunca da largura
                                *-- em pixels (regra #19)
                                IF NVL(cursor_4c_Ficha.maxs, 0) > 0
                                    .MaxLength = NVL(cursor_4c_Ficha.maxs, 0)
                                ELSE
                                    .MaxLength = 254
                                ENDIF
                            ENDWITH
                        ENDIF

                        loc_nTop = loc_nTop + loc_nHei + 2

                        *-- Volta a area do SCAN antes do SKIP implicito: o
                        *-- RespostaEhFixa acima roda SQL e troca a work area
                        SELECT cursor_4c_Ficha
                    ENDSCAN

                    *-- Legado: fecho da lista (shpFichaFim). O sayFichaFim do
                    *-- legado eh um Label de UM PONTO pintado na cor do fundo
                    *-- 100px abaixo, cujo unico proposito eh dar altura extra
                    *-- ao ScrollSlide para a barra de rolagem - sem frmbarcta
                    *-- portado ele nao tem funcao e seria um controle invisivel
                    *-- a mais na tela.
                    IF RECCOUNT("cursor_4c_Ficha") > 0
                        loc_oArea.AddObject("shp_4c_FichaFim", "Shape")
                        WITH THIS.cnt_4c_AreaFicha.shp_4c_FichaFim
                            .Top           = loc_nTop
                            .Left          = 1
                            .Width         = loc_nWid + 9
                            .Height        = 2
                            .SpecialEffect = 0
                            .Visible       = .T.
                        ENDWITH
                    ENDIF

                    *-- Legado: ReadOnly = Not InList(pcEscolha,'INSERIR',
                    *-- 'ALTERAR') aplicado controle a controle na criacao.
                    *-- Aqui num passe unico, DEPOIS do SCAN, para o criterio
                    *-- de edicao ter fonte unica e poder ser reaplicado se o
                    *-- modo mudar - e para a resposta FIXA (marcada no .Tag)
                    *-- continuar travada em qualquer modo.
                    THIS.HabilitarCampos(loc_lEditavel)

                    *-- Legado: This.CarregaFichaTecnica
                    THIS.CarregarFichaTecnica()

                    loc_lSucesso = .T.
                ENDIF
            ELSE
                *-- Legado: fora de CriouForm, ou em PROCURAR, o metodo nao
                *-- monta nada e ainda assim devolve .T. (Return .t. no fim)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.MontarFichaTecnica")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFichaTecnica - Joga as respostas do cursor nos campos montados
    * (carregafichatecnica legado)
    *
    * Legado:
    *     If ThisForm.CriouForm
    *         Select crTmpFicha
    *         Scan
    *             If( crTmpFicha.cTpDados <> [D] )
    *                 lcVal = Nvl(crTmpFicha.Resps, [])
    *             Else
    *                 lcVal = Nvl(Ctod(crTmpFicha.Resps),Ctod(''))
    *             Endif
    *             lcObj = [memFicha] + Alltrim(Str(crTmpFicha.COrds))
    *             loObjForm1.&lcObj..Value = lcVal
    *             loObjForm1.&lcObj..Refresh
    *         EndScan
    *     EndIf
    *
    * A resposta vem de SigOpFtc (o Left Join de CarregarCaracteristicas): eh
    * a resposta JA cadastrada para a OPERACAO, nao a do cliente - a do cliente
    * mora em SigCdCet e eh o que GravarFichaTecnica grava.
    *
    * O par "le a linha do cursor / escreve na tela" eh exatamente o par
    * CarregarLinhaFichaNoBO + BOParaForm da Fase 8: o SCAN abaixo so percorre
    * e delega, para a escrita na tela ter UM lugar so (o mesmo que o form pai
    * usa se precisar repintar um campo isolado).
    *==========================================================================
    PROCEDURE CarregarFichaTecnica()
        LOCAL loc_cArea, loc_oErro

        loc_cArea = ALIAS()

        TRY
            IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
                SELECT cursor_4c_Ficha
                GO TOP IN cursor_4c_Ficha
                SCAN
                    THIS.CarregarLinhaFichaNoBO()
                    THIS.BOParaForm()

                    *-- Volta a area do SCAN antes do SKIP implicito: os dois
                    *-- metodos acima nao trocam de work area hoje, mas
                    *-- reafirmar o alias eh o que impede que uma mudanca neles
                    *-- quebre o laco em silencio
                    SELECT cursor_4c_Ficha
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.CarregarFichaTecnica")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF
    ENDPROC

    *==========================================================================
    * DesmontarFichaTecnica - Remove os campos montados (desmontafichatecnica)
    *
    * Legado:
    *     If ThisForm.CriouForm And Used('crTmpFicha') And
    *        (ThisForm.pcEscolha <> [PROCURAR]) And ThisForm.MontouCampos
    *         ... RemoveObject de sayFicha/shpFicha (por caracteristica),
    *             lblFicha e memFicha (por linha) ...
    *         If (Reccount('crTmpFicha') > 0)
    *             RemoveObject shpFichaFim / sayFichaFim
    *         EndIf
    *         ThisForm.MontouCampos = .f.
    *     EndIf
    *
    * RemoveObject recebe o nome como STRING, entao nao precisa de EVALUATE -
    * mas precisa do PEMSTATUS antes: remover objeto inexistente estoura.
    *==========================================================================
    PROCEDURE DesmontarFichaTecnica()
        LOCAL loc_cArea, loc_cCar, loc_cObj, loc_cOrd, loc_oErro

        loc_cArea = ALIAS()

        TRY
            IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha") ;
               AND UPPER(ALLTRIM(THIS.this_cTipoAcao)) != "PROCURAR" ;
               AND THIS.this_lMontouCampos

                loc_cCar = ""

                SELECT cursor_4c_Ficha
                GO TOP IN cursor_4c_Ficha
                SCAN
                    loc_cOrd = ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))

                    IF loc_cCar != NVL(cursor_4c_Ficha.ccars, "")
                        loc_cCar = NVL(cursor_4c_Ficha.ccars, "")

                        loc_cObj = "lbl_4c_CarFicha" + loc_cOrd
                        IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
                            THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
                        ENDIF

                        loc_cObj = "shp_4c_CarFicha" + loc_cOrd
                        IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
                            THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
                        ENDIF
                    ENDIF

                    loc_cObj = "lbl_4c_Ficha" + loc_cOrd
                    IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
                        THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
                    ENDIF

                    loc_cObj = "mem_4c_Ficha" + loc_cOrd
                    IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
                        THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
                    ENDIF
                ENDSCAN

                IF RECCOUNT("cursor_4c_Ficha") > 0
                    IF PEMSTATUS(THIS.cnt_4c_AreaFicha, "shp_4c_FichaFim", 5)
                        THIS.cnt_4c_AreaFicha.RemoveObject("shp_4c_FichaFim")
                    ENDIF
                ENDIF

                THIS.this_lMontouCampos = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.DesmontarFichaTecnica")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarFichaTecnica - Exige o tamanho MINIMO de cada resposta
    * (validafichatecnica legado)
    *
    * Legado:
    *     If Len(Alltrim(lcVal)) < crTmpFicha.Mins
    *         lcMsgs = 'O Titulo ' + Alltrim(CTits) +
    *                  ' da Caracteristica ' + Alltrim(CCars) + CRLF +
    *                  'deve conter no minimo ' + Alltrim(Str(Mins)) +
    *                  ' caracteres.'
    *         MessageBox(lcMsgs,16,'')
    *         Return(.f.)
    *     EndIf
    *
    * Texto da mensagem transcrito do legado (que escreve "Titulo"/
    * "Caracteristica"/"minimo" SEM acento - manter, para o usuario ler o
    * mesmo de sempre). MsgAviso e nao MsgErro: eh validacao de preenchimento
    * da tela, nao erro tecnico.
    *
    * PUBLIC: o form PAI chama antes de confirmar a movimentacao.
    *==========================================================================
    PROCEDURE ValidarFichaTecnica()
        LOCAL loc_lValido, loc_cArea, loc_cVal, loc_cMsg, loc_oErro

        loc_lValido = .T.
        loc_cArea   = ALIAS()

        TRY
            IF USED("cursor_4c_Ficha")
                SELECT cursor_4c_Ficha
                GO TOP IN cursor_4c_Ficha
                SCAN WHILE loc_lValido
                    *-- Mesmo leitor usado por GravarFichaTecnica/FormParaBO:
                    *-- validar com uma conversao e gravar com outra eh como se
                    *-- aprova o que depois nao entra
                    loc_cVal = THIS.LerRespostaDaTela(NVL(cursor_4c_Ficha.cords, 0), ;
                                                      NVL(cursor_4c_Ficha.ctpdados, ""))

                    IF LEN(ALLTRIM(loc_cVal)) < NVL(cursor_4c_Ficha.mins, 0)
                        loc_cMsg = "O Titulo " + ALLTRIM(NVL(cursor_4c_Ficha.ctits, "")) + ;
                                   " da Caracteristica " + ALLTRIM(NVL(cursor_4c_Ficha.ccars, "")) + ;
                                   CHR(13) + CHR(10) + ;
                                   "deve conter no minimo " + ;
                                   ALLTRIM(STR(NVL(cursor_4c_Ficha.mins, 0), 3)) + ;
                                   " caracteres."
                        MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                    ENDIF

                    *-- Reafirma a area antes do SKIP implicito, igual aos
                    *-- outros lacos do form
                    SELECT cursor_4c_Ficha
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            loc_lValido = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.ValidarFichaTecnica")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * CarregarOperacaoComFicha - cursor_4c_Operacao (cnSigCdOpe legado)
    *
    * Legado (checarfichatecnica):
    *     Select Distinct a.Dopes, a.TitOpes, b.CGrus as TemDados
    *       From SigCdOpe a
    *       Left Join SigCdFtc b On a.Dopes = b.CGrus
    *      Where a.Dopes = '<Padr(Operacao,20)>' And b.nTipos = 2
    *      Order By a.Dopes
    *
    * Colunas conferidas em docs/schema.sql (UTF-16, lido com Get-Content -Raw
    * - regra #14): SigCdOpe.dopes char(20), SigCdOpe.titopes char(30),
    * SigCdFtc.cgrus char(20), SigCdFtc.ntipos numeric(1,0).
    *
    * A comparacao usa PADR(...,20) sem ALLTRIM no meio: Dopes eh char(20) e a
    * chave eh POSICIONAL (regra #42).
    *==========================================================================
    PROTECTED PROCEDURE CarregarOperacaoComFicha(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDopes, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (cursor_4c_Operacao)")
            ELSE
                loc_cDopes = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20)

                IF USED("cursor_4c_Operacao")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Operacao") > 1
                        TABLEREVERT(.T., "cursor_4c_Operacao")
                    ENDIF
                    USE IN cursor_4c_Operacao
                ENDIF

                loc_cSQL = "SELECT DISTINCT a.dopes, a.titopes, b.cgrus AS temdados" + ;
                           "  FROM SigCdOpe a" + ;
                           "  LEFT JOIN SigCdFtc b ON a.dopes = b.cgrus" + ;
                           " WHERE a.dopes = " + EscaparSQL(loc_cDopes) + ;
                           "   AND b.ntipos = 2" + ;
                           " ORDER BY a.dopes"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    *-- Mesma mensagem do legado para falha de consulta
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (cursor_4c_Operacao)")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.CarregarOperacaoComFicha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCaracteristicas - cursor_4c_Ficha (crTmpFicha legado)
    *
    * Legado (montafichatecnica):
    *     Select a.CCars, a.CTits, a.CLins, a.COrds, a.Maxs, a.Mins,
    *            a.nChkCxas, a.cSelecaos, a.cTpDados, b.Resps, c.Descrs
    *       From SigCdFtc a
    *       Left Join SigOpFtc b On '<lcDopes>' + a.CCars + a.CTits = b.DopCarTits
    *       Left Join SigPrCpP c on a.CTits = c.Codigos
    *      Where a.CGrus = '<lcDopes>'
    *        And a.SGrus = Space(6) And a.nTipos = 2
    *      Order By a.COrds
    *
    * DopCarTits eh char(60) = dopes(20) + ccars(20) + ctits(20): chave
    * POSICIONAL montada com PADR e sem ALLTRIM nas partes (regra #42) - o
    * ALLTRIM no meio encurtaria a chave, o JOIN nao casaria e a resposta ja
    * cadastrada da Operacao desapareceria SEM erro nenhum.
    *
    * O cursor sai READWRITE porque GravarFichaTecnica/CarregarFichaTecnica/
    * ValidarFichaTecnica percorrem o alias - cursor de pass-through nasce
    * somente-leitura. O nome e as colunas (cords, ctpdados, ccars, ctits) sao
    * o CONTRATO que a Fase 4 ja documentou em GravarFichaTecnica.
    *==========================================================================
    PROTECTED PROCEDURE CarregarCaracteristicas(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDopes, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (cursor_4c_Ficha)")
            ELSE
                loc_cDopes = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20)

                IF USED("cursor_4c_Ficha")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Ficha") > 1
                        TABLEREVERT(.T., "cursor_4c_Ficha")
                    ENDIF
                    USE IN cursor_4c_Ficha
                ENDIF

                loc_cSQL = "SELECT a.ccars, a.ctits, a.clins, a.cords, a.maxs," + ;
                           "       a.mins, a.nchkcxas, a.cselecaos, a.ctpdados," + ;
                           "       b.resps, c.descrs" + ;
                           "  FROM SigCdFtc a" + ;
                           "  LEFT JOIN SigOpFtc b" + ;
                           "    ON " + EscaparSQL(loc_cDopes) + " + a.ccars + a.ctits = b.dopcartits" + ;
                           "  LEFT JOIN SigPrCpP c" + ;
                           "    ON a.ctits = c.codigos" + ;
                           " WHERE a.cgrus = " + EscaparSQL(loc_cDopes) + ;
                           "   AND a.sgrus = SPACE(6)" + ;
                           "   AND a.ntipos = 2" + ;
                           " ORDER BY a.cords"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FichaTmp")

                IF loc_nResultado >= 0
                    SELECT * FROM cursor_4c_FichaTmp ;
                        INTO CURSOR cursor_4c_Ficha READWRITE

                    IF USED("cursor_4c_FichaTmp")
                        USE IN cursor_4c_FichaTmp
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (cursor_4c_Ficha)")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.CarregarCaracteristicas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RespostaEhFixa - .T. quando a pergunta tem resposta FIXA cadastrada
    *
    * Legado (montafichatecnica):
    *     lcQryResp = [Select nResps from SigCdFtr where GruCarTits = ']
    *                 + lcDopes + crTmpFicha.CCars + crTmpFicha.CTits + [']
    *     If ThisForm.poDataMgr.SQLExecute(lcQryResp,[crResp]) < 1
    *         MessageBox('Favor Reinicializar o Processo!!!') / Return .f.
    *     EndIf
    *     If !Eof([crResp]) and crResp.nResps == 1
    *         llRespFixa = .T.
    *     Endif
    *
    * SigCdFtr.grucartits eh char(66) e a comparacao do legado monta 60
    * caracteres (dopes 20 + ccars 20 + ctits 20) - o SQL Server completa com
    * branco na comparacao de char. Transcrito LITERALMENTE, com PADR em cada
    * parte e sem ALLTRIM no meio (regra #42): acrescentar ou tirar padding
    * mudaria o conjunto de linhas casadas.
    *
    * Falha de consulta devolve .F. (resposta editavel, como o legado deixaria
    * llRespFixa) e ja exibiu a mensagem - nunca silencioso (regra #9).
    *==========================================================================
    PROTECTED FUNCTION RespostaEhFixa(par_cOperacao, par_cCcars, par_cCtits)
        LOCAL loc_lFixa, loc_cSQL, loc_cChave, loc_nResultado, loc_cArea, loc_oErro

        loc_lFixa = .F.
        loc_cArea = ALIAS()

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cChave = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20) + ;
                             PADR(ALLTRIM(IIF(VARTYPE(par_cCcars) = "C", par_cCcars, "")), 20) + ;
                             PADR(ALLTRIM(IIF(VARTYPE(par_cCtits) = "C", par_cCtits, "")), 20)

                IF USED("cursor_4c_RespFixa")
                    IF CURSORGETPROP("Buffering", "cursor_4c_RespFixa") > 1
                        TABLEREVERT(.T., "cursor_4c_RespFixa")
                    ENDIF
                    USE IN cursor_4c_RespFixa
                ENDIF

                loc_cSQL = "SELECT nresps FROM SigCdFtr" + ;
                           " WHERE grucartits = " + EscaparSQL(loc_cChave)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespFixa")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_RespFixa")
                        SELECT cursor_4c_RespFixa
                        GO TOP IN cursor_4c_RespFixa
                        IF !EOF("cursor_4c_RespFixa")
                            *-- nresps eh numeric(1,0) e chega NUMERICO; coluna
                            *-- de marcacao pode chegar Logica conforme o driver
                            *-- - testar VARTYPE antes de comparar (regra #13).
                            *-- Ordem "L" primeiro, com o NVL no ELSE: eh a
                            *-- forma canonica que o pattern NVL_BIT_FIELD do
                            *-- CorretorAutomatico reconhece como JA corrigida.
                            *-- Com o teste de "N" na frente, o guard de
                            *-- idempotencia dele nao casa e ele reinjeta um
                            *-- IF VARTYPE = "L" ANINHADO dentro do ramo que ja
                            *-- provou ser "N" - codigo morto a cada sweep
                            *-- (regra #44, item 5). Medido rodando o corretor
                            *-- numa copia deste .prg.
                            IF VARTYPE(cursor_4c_RespFixa.nresps) = "L"
                                loc_lFixa = cursor_4c_RespFixa.nresps
                            ELSE
                                loc_lFixa = (NVL(cursor_4c_RespFixa.nresps, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (cursor_4c_RespFixa)")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lFixa = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.RespostaEhFixa")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF

        RETURN loc_lFixa
    ENDFUNC

    *==========================================================================
    * GravarFichaTecnica - Grava as respostas da ficha tecnica em SigCdCet
    *
    * Transcricao de SIGOPFTC.gravafichatecnica (task737). Trecho legado:
    *     If ThisForm.CriouForm And Used("crTmpFicha")
    *         loObjForm1 = ThisForm.poWindowOpe.ScrollBarContainer.ScrollSlide
    *         Zap in crSigCdCeT
    *         Select crTmpFicha
    *         Scan
    *             lcObj = [memFicha] + Alltrim(Str(crTmpFicha.COrds))
    *             lcVal = loObjForm1.&lcObj..Value
    *             If( crTmpFicha.cTpDados == [D] )
    *                 lcVal = Dtoc(lcVal)
    *             Endif
    *             If Not Empty(lcVal)
    *                 Select crSigCdCeT
    *                 Go Top In crSigCdCeT
    *                 Locate For IClis + CCars + CTits = <cliente> + CCars + CTits
    *                 If Eof([crSigCdCeT])
    *                     Insert Into crSigCdCeT (...) Values (..., NewIdChave())
    *                 EndIf
    *             EndIf
    *         EndScan
    *     EndIf
    *     Return(.t.)
    *
    * Equivalencias (CONTRATO que a fase 5 tem de respeitar ao montar a ficha):
    *   crTmpFicha        -> cursor_4c_Ficha, montado por MontarFichaTecnica;
    *                        colunas usadas aqui: cords, ctpdados, ccars, ctits
    *   memFicha<COrds>   -> mem_4c_Ficha<COrds>, filho de cnt_4c_AreaFicha,
    *                        lido por EVALUATE porque o nome eh montado em
    *                        runtime (regras #15 e #34: Controls(<nome>) nao
    *                        funciona e EVALUATE eh a forma correta de LEITURA)
    *   crSigCdCeT        -> cursor_4c_Respostas, respostas JA gravadas do
    *                        cliente (CarregarRespostasGravadas)
    *   crSigCdCli.IClis  -> THIS.this_cIclis, recebido no Init
    *   Insert Into ...   -> sigopftcBO.NovoRegistro() + Salvar(), que faz o
    *                        INSERT real em SigCdCet (NewIdChave -> fUniqueIds,
    *                        regra #22). Inserir() eh PROTECTED no BO, por isso
    *                        a chamada externa vai pelo par PUBLIC NovoRegistro/
    *                        Salvar da BusinessBase (regra #51).
    *
    * DIVERGENCIA DELIBERADA, registrada: o "Zap in crSigCdCeT" do legado
    * esvazia o CURSOR local de respostas antes do SCAN; a propagacao disso
    * para a base depende do buffering do AddCursor Fortyus e nao ha evidencia
    * de que o legado apague respostas ja gravadas. Aqui a gravacao eh direta
    * em SigCdCet e so INCLUI a resposta que ainda NAO existe para o par
    * Caracteristica/Titulo - o mesmo criterio do "If Eof([crSigCdCeT])" e o
    * ja documentado em sigopftcBO.Inserir. Nenhuma resposta existente eh
    * apagada nem sobrescrita (PILAR 2).
    *
    * Retorna .T. como o legado (Return(.t.) incondicional); so devolve .F. se
    * a carga das respostas existentes falhar ou se um INSERT recusar - e nesses
    * casos a mensagem ja foi exibida (CarregarRespostasGravadas / regra #20).
    *==========================================================================
    PROCEDURE GravarFichaTecnica()
        LOCAL loc_lSucesso, loc_cArea, loc_cVal
        LOCAL loc_cCar, loc_cTit, loc_cCarCmp, loc_cTitCmp, loc_oErro

        loc_lSucesso = .T.
        loc_cArea    = ALIAS()

        TRY
            IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
                IF THIS.CarregarRespostasGravadas()

                    SELECT cursor_4c_Ficha
                    GO TOP IN cursor_4c_Ficha
                    SCAN
                        loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
                        loc_cTit = NVL(cursor_4c_Ficha.ctits, "")

                        *-- Legado: lcVal = loObjForm1.&lcObj..Value, com
                        *-- Dtoc() quando cTpDados = "D". LerRespostaDaTela eh
                        *-- a fonte unica dessa leitura (a MESMA que
                        *-- ValidarFichaTecnica e FormParaBO usam).
                        loc_cVal = THIS.LerRespostaDaTela(NVL(cursor_4c_Ficha.cords, 0), ;
                                                          NVL(cursor_4c_Ficha.ctpdados, ""))

                        IF !EMPTY(loc_cVal)
                            loc_cCarCmp = UPPER(ALLTRIM(loc_cCar))
                            loc_cTitCmp = UPPER(ALLTRIM(loc_cTit))

                            SELECT cursor_4c_Respostas
                            GO TOP IN cursor_4c_Respostas
                            LOCATE FOR UPPER(ALLTRIM(NVL(cursor_4c_Respostas.ccars, ""))) == loc_cCarCmp ;
                                   AND UPPER(ALLTRIM(NVL(cursor_4c_Respostas.ctits, ""))) == loc_cTitCmp

                            IF EOF("cursor_4c_Respostas")
                                *-- Volta ao cursor da ficha ANTES do
                                *-- FormParaBO: ele le a linha CORRENTE de
                                *-- cursor_4c_Ficha, e o LOCATE acima deixou a
                                *-- area em cursor_4c_Respostas
                                SELECT cursor_4c_Ficha

                                *-- NovoRegistro() PRIMEIRO: ele chama
                                *-- LimparDados/InicializarValoresPadrao e
                                *-- liga this_lEmEdicao, sem o qual
                                *-- BusinessBase.Salvar() recusa a gravacao.
                                *-- Invertido, FormParaBO seria desfeito.
                                THIS.this_oBusinessObject.NovoRegistro()

                                IF THIS.FormParaBO()
                                    IF THIS.this_oBusinessObject.Salvar()
                                        *-- Equivale ao "Insert Into
                                        *-- crSigCdCeT" do legado: a resposta
                                        *-- recem-gravada passa a constar como
                                        *-- existente, para a mesma
                                        *-- Caracteristica/Titulo nao ser
                                        *-- inserida duas vezes no mesmo SCAN.
                                        INSERT INTO cursor_4c_Respostas (iclis, ccars, ctits) ;
                                               VALUES (THIS.this_cIclis, loc_cCar, loc_cTit)
                                    ELSE
                                        *-- BusinessBase.Salvar ja exibiu a
                                        *-- falha (regra #20) - nao repetir
                                        loc_lSucesso = .F.
                                    ENDIF
                                ELSE
                                    *-- FormParaBO so devolve .F. quando o
                                    *-- campo da tela esta vazio, e o
                                    *-- !EMPTY acima ja garantiu que nao esta:
                                    *-- chegar aqui significa que o controle
                                    *-- da linha nao existe na tela, e nao ha
                                    *-- resposta para gravar
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Volta a area do SCAN antes do SKIP implicito
                        SELECT cursor_4c_Ficha
                    ENDSCAN
                ELSE
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.GravarFichaTecnica")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarRespostasGravadas - Monta cursor_4c_Respostas com as respostas
    * JA gravadas em SigCdCet para o cliente corrente.
    *
    * Equivale ao cursor crSigCdCeT que o form pai legado mantinha aberto e que
    * gravafichatecnica consulta com Locate antes de inserir. Precisa ser
    * READWRITE porque GravarFichaTecnica acrescenta nele cada resposta que
    * acabou de gravar, reproduzindo o "Insert Into crSigCdCeT" do legado - por
    * isso o SQLEXEC vai num alias TEMPORARIO e o cursor final sai de
    * SELECT ... INTO CURSOR ... READWRITE (cursor de pass-through nasce
    * somente-leitura). O TABLEREVERT do fechamento vem guardado por
    * CURSORGETPROP("Buffering"), senao estoura erro 1586 em cursor sem
    * buffering (regra #52).
    *==========================================================================
    PROTECTED PROCEDURE CarregarRespostasGravadas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIclis))
                MsgAviso("Cliente n" + CHR(227) + "o informado - n" + CHR(227) + ;
                         "o h" + CHR(225) + " como gravar a ficha t" + CHR(233) + "cnica.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                            "o estabelecida.", "Erro")
                ELSE
                    IF USED("cursor_4c_Respostas")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Respostas") > 1
                            TABLEREVERT(.T., "cursor_4c_Respostas")
                        ENDIF
                        USE IN cursor_4c_Respostas
                    ENDIF

                    loc_cSQL = "SELECT iclis, ccars, ctits FROM SigCdCet" + ;
                               " WHERE iclis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespostasTmp")

                    IF loc_nResultado >= 0
                        SELECT * FROM cursor_4c_RespostasTmp ;
                            INTO CURSOR cursor_4c_Respostas READWRITE

                        IF USED("cursor_4c_RespostasTmp")
                            USE IN cursor_4c_RespostasTmp
                        ENDIF

                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao carregar as respostas j" + CHR(225) + ;
                                " gravadas da ficha t" + CHR(233) + "cnica:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.CarregarRespostasGravadas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLista - Ponto UNICO de (re)carga da lista de caracteristicas da
    * ficha tecnica: desmonta o que esta na tela, recarrega cursor_4c_Operacao
    * e remonta/repinta os campos.
    *
    * Eh o bloco "If llOks / If Not Empty(ThisForm.Operacao)" do
    * checarfichatecnica legado, extraido para ter ponto de recarga:
    *     <query cnSigCdOpe>  -> CarregarOperacaoComFicha
    *     Select cnSigCdOpe / Go Top
    *     If Not This.MontaFichaTecnica(ThisForm.Operacao) / Return 0
    *
    * A "lista" deste dialogo eh a relacao de caracteristicas (cursor_4c_Ficha,
    * o crTmpFicha legado), que o legado nao exibe em Grid e sim como uma pilha
    * de pares pergunta/resposta - montada em runtime por MontarFichaTecnica.
    * Nao ha Grid algum no SCX (4 objetos visuais, zero BaseClass grid), entao
    * repintar aqui eh Refresh do container que hospeda a pilha, e nao
    * GO TOP + Grid.Refresh de grade; o GO TOP no cursor fica, porque o
    * MontarFichaTecnica e os metodos de gravacao/validacao percorrem o alias
    * do inicio (regra #21a).
    *
    * DesmontarFichaTecnica PRIMEIRO, e por dois motivos: (a) remontar sobre
    * controle que ja existe estoura "Object ... is already defined" e mata o
    * dialogo - o legado deixa esse caminho aberto quando chamado com
    * [GRUPO_OP] e pcEscolha <> INSERIR (divergencia declarada no cabecalho);
    * (b) o Desmontar le o cursor_4c_Ficha ANTIGO para saber quais objetos
    * remover, e CarregarCaracteristicas (dentro de MontarFichaTecnica)
    * substitui esse cursor - desmontar depois nao acharia mais os nomes.
    * DesmontarFichaTecnica ja se protege por this_lMontouCampos, logo a
    * chamada eh no-op no caminho em que o legado desmonta antes.
    *
    * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de FORA da classe - regra #3 do CLAUDE.md.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cArea, loc_oErro

        loc_lSucesso = .F.
        loc_cArea    = ALIAS()

        TRY
            IF !THIS.this_lCriouForm
                *-- Sem o container dinamico nao ha onde montar a ficha. O
                *-- legado protege todo metodo de ficha com If ThisForm.CriouForm
                loc_lSucesso = .T.
            ELSE
                *-- Remove a ficha anterior antes de trocar o cursor
                THIS.DesmontarFichaTecnica()

                IF THIS.CarregarOperacaoComFicha(THIS.this_cOperacao)
                    IF USED("cursor_4c_Operacao")
                        SELECT cursor_4c_Operacao
                        GO TOP IN cursor_4c_Operacao
                    ENDIF

                    loc_lSucesso = THIS.MontarFichaTecnica(THIS.this_cOperacao)

                    *-- Popular cursor NAO repinta o que esta na tela
                    *-- (regra #21a). Aqui o equivalente ao Grid.Refresh eh o
                    *-- Refresh do container que hospeda a pilha de campos.
                    IF USED("cursor_4c_Ficha")
                        SELECT cursor_4c_Ficha
                        GO TOP IN cursor_4c_Ficha
                    ENDIF

                    THIS.cnt_4c_AreaFicha.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.CarregarLista")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Liga/desliga em bloco a edicao dos campos da ficha
    *
    * Legado (montafichatecnica, por controle, na criacao):
    *     .ReadOnly = Not InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
    * e, no ramo de texto, a resposta FIXA cadastrada tambem entra travada:
    *     If !Eof([crResp]) and crResp.nResps == 1 / llRespFixa = .T.
    *
    * Aqui num passe UNICO sobre os campos montados, chamado no fim de
    * MontarFichaTecnica. Resposta FIXA fica travada em QUALQUER modo: a marca
    * eh o .Tag = "FIXA" posto na criacao do controle (o Tag de TextBox/EditBox
    * so aceita Character, por isso a marca eh texto e nao logico).
    *
    * Varre por cursor_4c_Ficha e nao por ControlCount do container de
    * proposito: o container tambem hospeda os Label/Shape da ficha, que nao
    * tem ReadOnly - alcancar so os campos de resposta (os mem_4c_Ficha<COrds>)
    * evita depender de PEMSTATUS por propriedade para distinguir.
    *
    * PUBLIC (sem PROTECTED): mesma razao de CarregarLista - o harness chama de
    * fora da classe. NAO sobrescreve nada de FormBase (que nao declara
    * HabilitarCampos), portanto nao ha escopo herdado a respeitar.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_cArea, loc_oCtrl, loc_oErro

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_cArea      = ALIAS()

        TRY
            IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
                SELECT cursor_4c_Ficha
                GO TOP IN cursor_4c_Ficha
                SCAN
                    loc_oCtrl = THIS.ObterControleResposta(NVL(cursor_4c_Ficha.cords, 0))

                    IF VARTYPE(loc_oCtrl) = "O"
                        *-- Campo com resposta FIXA nunca destrava
                        IF UPPER(ALLTRIM(NVL(loc_oCtrl.Tag, ""))) == "FIXA"
                            loc_oCtrl.ReadOnly = .T.
                        ELSE
                            loc_oCtrl.ReadOnly = !loc_lHabilitar
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Ficha
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigopftc.HabilitarCampos")
        ENDTRY

        IF !EMPTY(loc_cArea) AND USED(loc_cArea)
            SELECT (loc_cArea)
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterControleResposta - Devolve o campo de resposta mem_4c_Ficha<COrds>
    * (ou .NULL. quando a linha nao tem controle montado na tela)
    *
    * Fonte UNICA da montagem desse nome em runtime. Antes da Fase 8 o par
    * PEMSTATUS + EVALUATE estava repetido em cinco metodos, e qualquer
    * divergencia na forma de montar o sufixo (NVL, STR com largura diferente,
    * ALLTRIM) faria um deles procurar um nome que outro nunca criou - defeito
    * silencioso, porque PEMSTATUS apenas devolveria .F. e o campo seria
    * ignorado.
    *
    * EVALUATE eh a forma correta de alcancar membro por NOME: Controls(<nome>)
    * nao funciona (indexado por NUMERO - regra #34) e aqui o EVALUATE eh
    * LEITURA, devolvendo a referencia do objeto (regra #15).
    *
    * NVL + STR com largura 3 reproduz o Alltrim(Str(crTmpFicha.COrds)) do
    * legado: SigCdFtc.cords eh numeric(3,0) NULL-avel e STR(.NULL.) devolve
    * .NULL., que propagaria pela concatenacao e estouraria no PEMSTATUS.
    *==========================================================================
    PROTECTED FUNCTION ObterControleResposta(par_nCords)
        LOCAL loc_oCtrl, loc_cObj, loc_nCords

        loc_oCtrl = .NULL.
        loc_nCords = IIF(VARTYPE(par_nCords) = "N", NVL(par_nCords, 0), 0)

        loc_cObj = "mem_4c_Ficha" + ALLTRIM(STR(loc_nCords, 3))

        IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
            loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
        ENDIF

        RETURN loc_oCtrl
    ENDFUNC

    *==========================================================================
    * LerRespostaDaTela - Valor do campo de resposta JA normalizado para char
    *
    * Legado (gravafichatecnica e validafichatecnica, identicos):
    *     lcVal = loObjForm1.&lcObj..Value
    *     If( crTmpFicha.cTpDados == [D] ) / lcVal = Dtoc(lcVal) / Endif
    *
    * Fonte UNICA dessa conversao, que antes estava triplicada em
    * GravarFichaTecnica, CarregarFichaTecnica e ValidarFichaTecnica - validar
    * com uma conversao e gravar com outra aprovaria o que depois nao entra.
    *
    * Data em BRANCO devolve "" e nao os separadores: DTOC de data vazia
    * devolve "  /  /    ", que EMPTY() nao reconhece como vazio, e o
    * !EMPTY(loc_cVal) de GravarFichaTecnica passaria a gravar resposta nao
    * preenchida. ConverterParaData normaliza DATE/DATETIME/CHAR - TTOD aqui
    * estouraria erro 11 quando o controle entrega DATE (regra #16), que eh o
    * caso do TextBox criado com .Value = {}.
    *
    * Campo ausente na tela (linha sem controle montado - modo PROCURAR, ou
    * ficha desmontada) devolve "" em vez de estourar, igual ao PEMSTATUS que
    * cercava os sites anteriores.
    *==========================================================================
    PROTECTED FUNCTION LerRespostaDaTela(par_nCords, par_cTpDados)
        LOCAL loc_cVal, loc_oCtrl, loc_uVal, loc_dVal

        loc_cVal  = ""
        loc_oCtrl = THIS.ObterControleResposta(par_nCords)

        IF VARTYPE(loc_oCtrl) = "O"
            loc_uVal = loc_oCtrl.Value

            IF UPPER(ALLTRIM(IIF(VARTYPE(par_cTpDados) = "C", par_cTpDados, ""))) == "D"
                loc_dVal = ConverterParaData(loc_uVal)
                loc_cVal = IIF(EMPTY(loc_dVal), "", DTOC(loc_dVal))
            ELSE
                loc_cVal = IIF(VARTYPE(loc_uVal) = "C", loc_uVal, TRANSFORM(loc_uVal))
            ENDIF
        ENDIF

        RETURN loc_cVal
    ENDFUNC

    *==========================================================================
    * CarregarLinhaFichaNoBO - Linha CORRENTE de cursor_4c_Ficha -> properties
    * do Business Object
    *
    * cursor_4c_Ficha eh o crTmpFicha legado, e as properties this_c*/this_n*
    * do sigopftcBO foram declaradas na Fase 1 justamente para espelhar essas
    * colunas. Nao usa o CarregarDoCursor do BO de proposito: aquele le as
    * colunas de SigCdCet (cidchaves/clicartits/resps gravados do CLIENTE),
    * que nao existem neste cursor - chamar CarregarDoCursor aqui estouraria
    * "Variable CIDCHAVES is not found" em runtime.
    *
    * this_cSgrus recebe SPACE(6) porque eh exatamente o valor que
    * CarregarCaracteristicas usa no filtro (a.sgrus = SPACE(6)) e a coluna nao
    * vem no SELECT - ler do cursor estouraria.
    *
    * NAO toca this_cIclis/this_cTipoAcao/this_cOperacao: esses tres sao o
    * contexto recebido no Init, nao variam por linha, e FormParaBO os repoe
    * depois do NovoRegistro().
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhaFichaNoBO()
        IF !USED("cursor_4c_Ficha") OR EOF("cursor_4c_Ficha")
            *-- Sem linha corrente nao ha o que transferir. Guarda por IF e
            *-- nao por RETURN de saida antecipada (regra #1): este metodo eh
            *-- chamado de dentro do TRY de CarregarFichaTecnica e do TRY de
            *-- GravarFichaTecnica (via FormParaBO)
        ELSE
            WITH THIS.this_oBusinessObject
                .this_cCcars    = TratarNulo(cursor_4c_Ficha.ccars,     "")
                .this_cCtits    = TratarNulo(cursor_4c_Ficha.ctits,     "")
                .this_nClins    = TratarNulo(cursor_4c_Ficha.clins,     0)
                .this_nCords    = TratarNulo(cursor_4c_Ficha.cords,     0)
                .this_nMaxs     = TratarNulo(cursor_4c_Ficha.maxs,      0)
                .this_nMins     = TratarNulo(cursor_4c_Ficha.mins,      0)
                .this_cSelecaos = TratarNulo(cursor_4c_Ficha.cselecaos, "")
                .this_nChkCxas  = TratarNulo(cursor_4c_Ficha.nchkcxas,  0)
                .this_cTpDados  = TratarNulo(cursor_4c_Ficha.ctpdados,  "")
                .this_cDescrs   = TratarNulo(cursor_4c_Ficha.descrs,    "")
                .this_cResps    = TratarNulo(cursor_4c_Ficha.resps,     "")

                *-- Nao vem no SELECT: eh o valor fixo do filtro de
                *-- CarregarCaracteristicas (a.sgrus = SPACE(6))
                .this_cSgrus    = SPACE(6)
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Campos da TELA + linha corrente da ficha -> properties do BO
    *
    * Reune, para a linha CORRENTE de cursor_4c_Ficha, o que o
    * gravafichatecnica legado monta antes do Insert:
    *     lcVal = loObjForm1.&lcObj..Value   (+ Dtoc se cTpDados = "D")
    *     Insert Into crSigCdCeT (IClis, CCars, CTits, Resps, ...)
    *            Values (crSigCdCli.IClis, crTmpFicha.CCars,
    *                    crTmpFicha.CTits, lcVal, ..., NewIdChave())
    * O IClis vem de THIS.this_cIclis (recebido no Init, equivalente ao cursor
    * global crSigCdCli do form pai) e o cidchaves eh gerado por
    * sigopftcBO.Inserir com fUniqueIds() (regra #22).
    *
    * Chamado DEPOIS de NovoRegistro(): aquele limpa as properties e liga
    * this_lEmEdicao (sem o qual BusinessBase.Salvar() recusa a gravacao), logo
    * a ordem inversa desfaria esta transferencia.
    *
    * Retorna .F. - e NAO transfere - quando a resposta da tela esta vazia:
    * eh o "If Not Empty(lcVal)" do legado, que nunca grava resposta em branco
    * (e as cinco colunas de SigCdCet sao NOT NULL). Em vez de gravar vazio em
    * silencio, quem chama decide; GravarFichaTecnica ja filtra antes, entao
    * este retorno eh a segunda barreira, nao a primeira.
    *
    * PROTECTED porque FormBase.FormParaBO eh PROTECTED - VFP9 nao permite
    * ALARGAR o escopo de um metodo herdado.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lApto, loc_cVal

        loc_lApto = .F.

        IF USED("cursor_4c_Ficha") AND !EOF("cursor_4c_Ficha")
            *-- Linha da ficha (crTmpFicha) para o BO
            THIS.CarregarLinhaFichaNoBO()

            *-- Campo da tela, JA normalizado para char com o Dtoc do legado
            loc_cVal = THIS.LerRespostaDaTela(NVL(cursor_4c_Ficha.cords, 0), ;
                                              NVL(cursor_4c_Ficha.ctpdados, ""))

            IF !EMPTY(loc_cVal)
                WITH THIS.this_oBusinessObject
                    *-- O que o usuario digitou PREVALECE sobre o resps que
                    *-- CarregarLinhaFichaNoBO trouxe de SigOpFtc (resposta
                    *-- padrao da OPERACAO): o que se grava em SigCdCet eh a
                    *-- resposta do CLIENTE
                    .this_cResps = loc_cVal

                    *-- Contexto do Init, reposto porque NovoRegistro() limpou
                    .this_cIclis    = THIS.this_cIclis
                    .this_cTipoAcao = THIS.this_cTipoAcao
                    .this_cOperacao = THIS.this_cOperacao
                ENDWITH

                loc_lApto = .T.
            ENDIF
        ENDIF

        RETURN loc_lApto
    ENDFUNC

    *==========================================================================
    * BOParaForm - Property de resposta do BO -> campo da TELA
    *
    * Legado (carregafichatecnica, por linha):
    *     If( crTmpFicha.cTpDados <> [D] ) / lcVal = Nvl(crTmpFicha.Resps, [])
    *     Else / lcVal = Nvl(Ctod(crTmpFicha.Resps), Ctod('')) / Endif
    *     loObjForm1.&lcObj..Value = lcVal
    *     loObjForm1.&lcObj..Refresh
    *
    * Escreve no campo mem_4c_Ficha<this_nCords>, respeitando this_cTpDados:
    * campo de data recebe DATE (o controle nasce com .Value = {}) e campo de
    * texto recebe char - atribuir o tipo errado estouraria, porque o TextBox
    * de data tem InputMask "99/99/9999".
    *
    * Linha sem controle montado na tela eh ignorada em silencio, igual ao
    * PEMSTATUS que cercava o site original: em modo PROCURAR o legado nao
    * monta campo nenhum e o carregafichatecnica roda do mesmo jeito.
    *
    * PROTECTED porque FormBase.BOParaForm eh PROTECTED (nao alargar escopo).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCtrl, loc_uVal

        loc_oCtrl = THIS.ObterControleResposta(THIS.this_oBusinessObject.this_nCords)

        IF VARTYPE(loc_oCtrl) = "O"
            IF UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cTpDados)) == "D"
                *-- Legado: Nvl(Ctod(Resps), Ctod('')). ConverterParaData
                *-- normaliza DATE/DATETIME/CHAR e devolve data vazia quando
                *-- nao da para converter - TTOD estouraria erro 11 se a
                *-- property viesse como DATE (regra #16)
                loc_uVal = ConverterParaData(THIS.this_oBusinessObject.this_cResps)
            ELSE
                loc_uVal = THIS.this_oBusinessObject.this_cResps
            ENDIF

            loc_oCtrl.Value = loc_uVal
            loc_oCtrl.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera o Business Object. DODEFAULT no fim (rebuild menu).
    *
    * Fecha os cursores do dialogo. O TABLEREVERT vem guardado por
    * CURSORGETPROP("Buffering"): cursor sem buffering estoura erro 1586 nele,
    * e USE IN fecha o alias mesmo com buffer sujo (regra #52).
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_i, loc_cCursor, loc_aCursores[4]

        loc_aCursores[1] = "cursor_4c_Respostas"
        loc_aCursores[2] = "cursor_4c_Ficha"
        loc_aCursores[3] = "cursor_4c_Operacao"
        loc_aCursores[4] = "cursor_4c_RespFixa"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            loc_cCursor = loc_aCursores[loc_i]
            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF
        ENDFOR

        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

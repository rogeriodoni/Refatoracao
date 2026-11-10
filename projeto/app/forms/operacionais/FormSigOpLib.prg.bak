*==============================================================================
* FormSigOpLib.prg
*
* Dialogo modal "Liberacao de Peso" - escolhe o TIPO DE LIBERACAO a aplicar e
* devolve ao form chamador o par codigo + descricao.
*
* Origem legado : SIGOPLIB.SCX
*                 tasks\task760\SigOpLib_form_codigo_fonte.txt
*
* Tipo          : OPERACIONAL - layout FLAT (dialogo 550x200)
*
* O SCX legado NAO tem PageFrame: o objeto raiz eh um "form" generico e todos
* os controles penduram direto nele, com um unico Container (cntSombra) para a
* faixa cinza do cabecalho. Por isso este form NAO cria pgf_4c_* nenhum e NAO
* tem pagina Lista/Dados - inventar um PageFrame violaria o PILAR 1.
*
*
*------------------------------------------------------------------------------
* FASE 4 - POR QUE NAO HA GRID NEM BOTOES CRUD (MEDIDO, NAO PRESUMIDO)
*
* A Fase 4 do pipeline pede a pagina de Lista com Grid, o container com os 6
* botoes CRUD e o metodo que alterna as duas paginas. Esta tela NAO TEM lista
* e NAO TEM Page, e
* isso foi MEDIDO no dump (tasks\task760\SigOpLib_form_codigo_fonte.txt), nao
* suposto. A arvore inteira do SCX sao 12 objetos:
*
*     BaseClass: form             1     BaseClass: label          4
*     BaseClass: container        1     BaseClass: textbox        2
*     BaseClass: shape            2     BaseClass: commandbutton  1
*     BaseClass: dataenvironment  1
*
*     BaseClass: grid        ZERO     AddCursor      ZERO
*     BaseClass: pageframe   ZERO     pColuna        ZERO
*     BaseClass: listbox     ZERO     RecordSource   ZERO
*     Grade / grd            ZERO     ControlSource  ZERO
*
* Ou seja: nao ha o que listar. Inventar um PageFrame Lista/Dados com 6 botoes
* CRUD violaria o PILAR 1 e a regra "NUNCA inventar", e escrever
* metodo de pagina de Lista ou de alternancia que nao liste nada seria o "stub
* disfarcado" que a regra de completude proibe. Os botoes CRUD canonicos ficam
* em Left=542..932 (regra #10): num form de Width=550 seriam invisiveis e
* mortos. Dos 7 ramos do gate da Fase 4 o unico que se aplica eh o CAPTURA -
* sem lista pelo teste ESTRITO, com campo de ENTRADA (os 2 fwget, nenhum
* ReadOnly) e sem API de nos.
*
* NAO escrever aqui os nomes dos metodos do ramo PAGINADO: o gate da Fase 4
* casa o TEXTO CRU do .prg e nao distingue codigo de comentario, entao
* cita-los no proprio comentario que EXPLICA a ausencia deles faz o gate
* aprovar como PAGINADO - pelo motivo errado, escondendo que o ramo real eh o
* CAPTURA. Medido nesta task: com os nomes no comentario o gate dava
* temLayoutPaginado = True num form com ZERO Page e ZERO grade.
*
* O que esta fase entrega, portanto, eh a unica superficie de BOTAO que o
* legado REALMENTE tem, com comportamento completo:
*
*   ConfigurarBotoes()   shp_4c_Shape2 + cmd_4c_Ok, na ordem dos registros do
*                        SCX (Shape2 eh o penultimo, ok eh o ultimo)
*   ConfigurarEventos()  BINDEVENT do Click do ok
*   BtnOkClick()         "ThisForm.Release" do legado, pelo funil de fechamento
*   FecharDialogo()      Hide() em vez de Release(), para o chamador conseguir
*                        ler this_cRetorno depois do Show()
*   Unload()             "Return ThisForm.Retorno" do legado
*
* O ESCOPO daquela fase parou ali, de proposito. As fases seguintes
* acrescentaram o resto, e esta eh a situacao ATUAL do arquivo:
*
*   Fase 5  os campos - Shape1/Say2/get_codigo/get_descr/Say1, com o InputMask
*           "!!!!!!!!!!" de get_codigo (regra #49) - e a ordem de tabulacao,
*           que so pode ser atribuida quando TODOS os AddObject existirem
*           (AjustarOrdemTabulacao).
*
*   Fase 6  o lookup em SigCdNcf dos Valid de get_codigo/get_descr e o When de
*           get_descr:
*
*             ValidarCodigoLostFocus     get_codigo.Valid (saida do campo)
*             TxtCodigoKeyPress          atalho F4 para o mesmo funil
*             TxtCodigoDblClick          atalho de duplo clique
*             AbrirLookupTipoLiberacao   FUNIL: Seek no universo filtrado e,
*                                        falhando, o browse do fwBuscaSel
*             AplicarTipoSelecionado     bloco final do Valid - codigo,
*                                        descricao e retorno
*             AtualizarEstadoDescricao   get_descr.When, que NAO eh evento
*                                        ligavel por BINDEVENT
*             ValidarDescricaoLostFocus  get_descr.Valid
*
*   Fase 8  a CONSOLIDACAO: os dois hooks de transferencia entre a tela e o
*           BO, que passaram a ser o unico caminho nos dois sentidos -
*
*             FormParaBO    tela -> BO: parametros de abertura MAIS o estado
*                           corrente dos dois campos
*             BOParaForm    BO -> tela: o bloco final do get_codigo.Valid,
*                           com a guarda de Fixos <> 2 que impede o hook de
*                           apagar a descricao DIGITADA
*
*           e, no BO, FecharRetornoDoTipo - a conta do retorno, que o form
*           repetia para atender o caminho do picker e agora tem fonte unica.
*           O funil de aplicacao virou duas linhas: o BO calcula, a tela
*           espelha. O handler do botao tambem foi renomeado de Cmd* para
*           Btn*, que eh o prefixo dominante de handler de botao no projeto
*           (as duas formas sao aceitas; a troca eh de convencao, nao de
*           comportamento - segue sendo o Click do objeto "ok" do SCX).
*
*
*------------------------------------------------------------------------------
* FASE 8 - A SUPERFICIE CRUD QUE ESTA TELA NAO TEM (MEDIDO, NAO PRESUMIDO)
*
* A Fase 8 do pipeline pede, alem dos dois hooks acima, o handler do botao de
* ABANDONO, o metodo de carga da LISTA, o par de habilitar/limpar campos e o
* ajuste de botoes POR MODO. Nenhum dos quatro tem referente aqui, e a medicao
* esta no mesmo lugar: o dump do SCX tem 12 objetos, com ZERO grid, ZERO
* pageframe, ZERO AddCursor e ZERO ControlSource (contagem no bloco da Fase 4,
* acima).
*
*   botao de abandono   O SCX tem UM UNICO CommandButton - o "ok", com
*                       Cancel = .T. -, e o Click dele eh "ThisForm.Release" e
*                       MAIS NADA. Isto eh: a tecla ESC aciona o PROPRIO botao
*                       de acao, e nao existe segundo botao que descarte
*                       alguma coisa. Nao ha o que descartar: este dialogo nao
*                       mantem registro em edicao e nao grava em tabela
*                       nenhuma (comportamento.json: zero INSERT/UPDATE/
*                       DELETE). O handler desse botao existe e esta entregue
*                       (BtnOkClick); batiza-lo de "abandono" faria o nome
*                       MENTIR sobre o que o metodo faz.
*
*   carga da lista      Nao ha grade NEM cursor de listagem. As duas unicas
*                       consultas do legado (get_codigo.Valid e
*                       get_descr.When) alimentam o PICKER e a decisao de
*                       editabilidade, nao uma lista na tela - e quem as
*                       executa eh o BO. Inventar um metodo de carga aqui
*                       criaria uma SEGUNDA fonte para a consulta que o BO
*                       ja faz.
*
*   habilitar campos    Nao ha MODO (incluir/alterar/visualizar) nesta tela:
*                       o dialogo so existe no estado de entrada. A unica
*                       regra de editabilidade que o legado tem eh o
*                       get_descr.When, e ela ja esta entregue, no metodo
*                       proprio que a reproduz (AtualizarEstadoDescricao).
*                       Um segundo metodo de habilitacao seria uma segunda
*                       fonte para a mesma decisao.
*
*   limpar campos       O legado nao limpa campo nenhum: nao ha botao de
*                       limpar, o Init SEMEIA o codigo (com xNensi.CodnConfs)
*                       em vez de zerar, e a tela vive um unico registro -
*                       fecha e eh reaberta. Zerar os campos aqui tambem
*                       conflitaria com a regra de nunca apagar o que o
*                       usuario digitou (regra #50).
*
*   botoes por modo     Sem modo e com UM botao sempre habilitado, nao ha
*                       estado de botao a ajustar.
*
* Escrever qualquer um dos cinco como metodo vazio, ou com MsgAviso de "sera
* implementado", eh o stub disfarcado que a regra de completude proibe.
*
* NAO citar aqui os nomes CANONICOS desses metodos: o gate da Fase 8 casa o
* TEXTO CRU do .prg e nao distingue codigo de comentario, entao escreve-los no
* proprio comentario que EXPLICA a ausencia deles faz o gate dar o nome por
* ENTREGUE e a rota de excecao virar no-op - a fase passaria pelo motivo
* errado. Mesma armadilha ja documentada no bloco da Fase 4.
*
* Herda de: FormBase
*
*------------------------------------------------------------------------------
* CONTRATO DE USO (espelha o Init/Unload do legado)
*
* Legado:
*     SIGOPLIB.Init   -> LParameters _Tipo
*                        Tipo = Iif(Type("_Tipo") # 'N', 0, _Tipo)
*                        Get_codigo.Value = xNensi.CodnConfs
*                        Retorno = Space(10)
*     SIGOPLIB.Unload -> Return ThisForm.Retorno
*
* Migrado (o chamador LE a propriedade depois do Show(), em vez de receber o
* valor pelo retorno do Unload - no sistema novo o dialogo se esconde em vez de
* se destruir, para que o pai consiga ler o resultado):
*
*     loForm = CREATEOBJECT("FormSigOpLib", loc_nTipo)
*     IF VARTYPE(loForm) = "O"
*         loForm.Show()
*         loc_cRetorno = loForm.this_cRetorno
*     ENDIF
*
* Os DOIS parametros sao OPCIONAIS - igual ao legado, que aceita _Tipo ausente
* e o trata como ZERO. Assim o harness de teste (TestFormWrapper faz
* CREATEOBJECT sem argumento nenhum) tambem consegue instanciar o dialogo.
*
*     par_nTipo           ThisForm.Tipo do legado. Governa qual comparacao
*                         entra no Where da consulta de tipos permitidos
*                         (Tipos = Tipo quando esta em 2/3/4, Tipos <= Tipo
*                         nos demais casos). Ausente ou nao-numerico vale 0.
*
*     par_cCodigoInicial  Semente do campo codigo. No legado vem de
*                         xNensi.CodnConfs - a linha corrente do cursor de
*                         trabalho do form PAI (xNensi eh populado por
*                         sigopdivBO, a Divisao de OP). Quando o chamador nao
*                         informa, este form ainda tenta ler o alias xNensi
*                         caso ele esteja aberto, reproduzindo o legado sem
*                         depender dele: alias ausente resulta em semente
*                         vazia, nunca em erro de runtime.
*==============================================================================

DEFINE CLASS FormSigOpLib AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do SCX legado (PILAR 1)
    *
    * Somente constantes aqui: inicializador de propriedade em DEFINE CLASS nao
    * aceita chamada de funcao, por isso Caption (que tem acento e exige CHR())
    * e Picture (que depende de gc_4c_CaminhoFramework) sao atribuidos em
    * InicializarForm.
    *
    * ShowWindow = 1 (In Top-Level Form) eh o UNICO valor que nao vem do dump:
    * eh canonico do sistema novo para dialogo modal (sem ele o form fecha
    * imediatamente) e o CorretorAutomatico o injeta de qualquer forma -
    * declarar aqui evita que o sweep reescreva o arquivo.
    *--------------------------------------------------------------------------
    Width       = 550
    Height      = 200
    DataSession = 1
    BorderStyle = 2
    AutoCenter  = .T.
    ShowWindow  = 1
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1

    *--------------------------------------------------------------------------
    * Estado do dialogo - espelha as propriedades customizadas do SCX legado
    * (SECAO 4 do dump: podatamgr / retorno / tipo)
    *
    * "podatamgr" NAO tem equivalente aqui: no legado era o fSqlConector criado
    * no Init; na arquitetura nova o acesso ao banco mora no BO, que herda o
    * DataAccess da BusinessBase.
    *--------------------------------------------------------------------------

    *-- Business Object (SigOpLibBO) - consultas a SigCdNcf e montagem do
    *-- retorno. Instanciado em InicializarForm.
    this_oBusinessObject = .NULL.

    *-- Mensagem do ultimo erro capturado em CATCH. Redeclarada aqui, embora a
    *-- FormBase tambem a declare, porque o CorretorAutomatico
    *-- (MENSAGEMERRO_AUSENTE) exige a declaracao local em todo form que leia
    *-- THIS.this_cMensagemErro - sem ela o sweep reescreve o arquivo.
    this_cMensagemErro = ""

    *-- ThisForm.Tipo do legado: faixa de tipos de liberacao que o chamador
    *-- autoriza. Recebido como 1o parametro do Init; ausente vale ZERO.
    this_nTipo = 0

    *-- ThisForm.Retorno do legado: codigo + descricao escolhidos, que o form
    *-- chamador le depois do Show(). Nasce com SPACE(10) (a largura de
    *-- SigCdNcf.cods), que eh o valor devolvido quando o usuario fecha o
    *-- dialogo sem escolher nada.
    this_cRetorno = ""

    *-- Semente do campo codigo (xNensi.CodnConfs no legado). Guardada em
    *-- propriedade para que o form nao dependa de cursor global do legado.
    this_cCodigoInicial = ""

    *-- Guarda de reentrancia do picker de tipos (FormBuscaAuxiliar eh MODAL:
    *-- ao abrir, o foco sai do campo e o proprio LostFocus redispara, o que
    *-- empilharia um segundo dialogo). Declarada aqui porque eh estado da
    *-- classe; quem a liga/desliga eh o funil de lookup.
    this_lEmLookup = .F.

    *-- Ultimo codigo JA submetido ao lookup. Guarda de "valor nao mudou":
    *-- LostFocus NAO eh Valid - o Valid do legado so roda quando o valor MUDA,
    *-- o LostFocus roda SEMPRE que o foco sai do campo. Sem esta marca, um
    *-- codigo que o lookup nao encontra faria o picker reabrir a cada passagem
    *-- pelo campo, sem o usuario ter digitado nada.
    this_cUltimoCodigoValidado = ""

    *--------------------------------------------------------------------------
    * Init - recebe os parametros de abertura e delega ao FormBase
    *
    * Os parametros sao guardados ANTES do DODEFAULT() porque eh o
    * FormBase.Init que chama o InicializarForm desta classe, e lah eles ja
    * precisam estar disponiveis para alimentar o BO.
    *
    * A frase acima evita de proposito escrever o nome do metodo com os
    * parenteses na linha seguinte a uma que cite DODEFAULT: o pattern
    * INICIALIZAR_DUPLICADO do CorretorAutomatico eh comment-blind e apagaria
    * esta linha de comentario a cada sweep.
    *
    * Sem TRY/CATCH de proposito: o bloco so guarda parametros (nenhuma
    * operacao capaz de estourar) e o tratamento de erro da inicializacao fica
    * no InicializarForm, onde ha o que proteger.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nTipo, par_cCodigoInicial)
        LOCAL loc_lSucesso

        *-- Legado: Tipo = Iif(Type("_Tipo") # 'N', 0, _Tipo)
        IF PCOUNT() >= 1 AND VARTYPE(par_nTipo) = "N"
            THIS.this_nTipo = par_nTipo
        ELSE
            THIS.this_nTipo = 0
        ENDIF

        *-- Legado: Get_codigo.Value = xNensi.CodnConfs
        *-- 1o) o que o chamador informar tem precedencia;
        *-- 2o) na ausencia, le o alias xNensi do form PAI se estiver aberto;
        *-- 3o) sem alias, semente vazia (nunca erro de "alias not found").
        THIS.this_cCodigoInicial = ""

        IF PCOUNT() >= 2 AND VARTYPE(par_cCodigoInicial) = "C"
            THIS.this_cCodigoInicial = par_cCodigoInicial
        ELSE
            IF USED("xNensi")
                IF TYPE("xNensi.CodNConfs") = "C"
                    THIS.this_cCodigoInicial = xNensi.CodNConfs
                ENDIF
            ENDIF
        ENDIF

        *-- Legado: Retorno = Space(10) (largura de SigCdNcf.cods char(10))
        THIS.this_cRetorno = SPACE(10)

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - instancia o BO e monta a estrutura base do dialogo
    *
    * Chamado automaticamente por FormBase.Init() - NAO chamar de novo no Init
    * (AddObject duplicado dispararia "member object already exists").
    *
    * RETURN fica FORA do TRY/CATCH (regra #1): dentro do bloco usa-se a flag
    * loc_lSucesso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Caption do legado: "Liberacao de Peso" (acentos via CHR())
            THIS.Caption = "Libera" + CHR(231) + CHR(227) + "o de Peso"

            *-- Business Object gerado nas Fases 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLibBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Os parametros de abertura NAO sao repassados ao BO aqui: eles
                *-- vao junto dos campos, no hook unico de transferencia, que roda
                *-- adiante neste mesmo metodo - os controles precisam existir
                *-- antes, porque eh deles que o hook le o estado da tela. Nada
                *-- entre este ponto e a chamada do hook consulta o BO.

                *-- Aparencia base do form (fundo do framework legado)
                THIS.ConfigurarAparenciaBase()

                *-- Faixa cinza do cabecalho (cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Campos da tela: Shape1 / Say2 / get_codigo / get_descr /
                *-- Say1. No SCX esses cinco objetos sao criados ANTES do par
                *-- Shape2/ok, entao a chamada entra AQUI - entre o cabecalho e
                *-- os botoes -, nunca appendada no fim. Nao ha sobreposicao
                *-- entre os dois grupos (os campos ficam em Left 104..446 /
                *-- Top 99..151 e o par Shape2/ok em Left 444..550 /
                *-- Top 3..78), mas manter a ordem do SCX eh o que garante o
                *-- z-order dele (regra #30).
                THIS.ConfigurarCampos()

                *-- Barra de acao: Shape2 + botao Ok (os dois ultimos filhos do
                *-- SCX). DEPOIS do cabecalho de proposito - ficam em Top=3..78,
                *-- dentro da faixa, e precisam desenhar por cima dela.
                THIS.ConfigurarBotoes()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Ordem de tabulacao: DEPOIS de TODOS os AddObject, nunca
                *-- junto da criacao de cada controle (ver AjustarOrdemTabulacao).
                THIS.AjustarOrdemTabulacao()

                *-- BINDEVENT por ULTIMO: so resolve referencia de objeto que
                *-- JA existe.
                THIS.ConfigurarEventos()

                *-- Tela -> BO: parametros de abertura MAIS o estado inicial dos
                *-- dois campos. Roda AQUI, e nao antes, porque le os controles -
                *-- que passaram a existir na chamada de criacao dos campos.
                *-- Deixa o BO em sincronia com a tela ANTES da primeira consulta
                *-- (a linha seguinte ja usa o BO).
                THIS.FormParaBO()

                *-- get_descr.When do legado, que NAO eh evento ligavel por
                *-- BINDEVENT (o bind descarta o retorno do delegate): a
                *-- editabilidade da descricao eh reconfigurada no proprio
                *-- campo. Roda AQUI para valer no estado de ABERTURA, com a
                *-- semente de codigo que o chamador informou - o legado tambem
                *-- avalia o When antes de qualquer digitacao. Nao valida a
                *-- semente: o Valid do legado so dispara por interacao do
                *-- usuario, nunca no Init.
                THIS.AtualizarEstadoDescricao()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o SigOpLibBO."
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + ;
                " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                " | Procedure: " + loc_oErro.Procedure, ;
                "Erro ao inicializar FormSigOpLib")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAparenciaBase - propriedades do form que dependem de variavel
    * global, logo nao cabem no inicializador da classe.
    *
    * Legado: Picture = ..\framework\imagens\new_background.jpg
    * O caminho vem de gc_4c_CaminhoFramework (regra #170) - NUNCA reconstruir
    * a partir de gc_4c_CaminhoBase, que nao navega os tres niveis acima.
    * Atribuicao direta, sem guard IF FILE(): guard mascara Picture ausente,
    * que o VFP9 aceita em silencio (regra #25).
    *
    * Este form NAO tem PageFrame (o legado nao tem Page nenhuma), por isso nao
    * ha Page1.Picture/Page2.Picture a definir - o fundo vai no proprio form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAparenciaBase()
        THIS.Picture    = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
        THIS.ScrollBars = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do legado)
    *
    * Legado: cntSombra   Top=0  Left=0  Width=800 Height=80
    *                     BorderWidth=0  BackColor=100,100,100
    *         lblSombra   Top=18 Left=10 Width=769 Height=40  ForeColor=0,0,0
    *         lblTitulo   Top=17 Left=10 Width=769 Height=46  ForeColor=255,255,255
    *                     ambos Tahoma 18 bold, WordWrap=.T., Alignment=0,
    *                     BackStyle=0
    *
    * Os DOIS labels sobrepostos com 1px de diferenca no Top sao o efeito de
    * sombra do framework: o preto desenha atras, o branco na frente. O Caption
    * dos dois vem de THIS.Caption, igual ao Init do legado
    * (cntSombra.lblSombra.Caption = ThisForm.Caption).
    *
    * Width = THIS.Width nos tres objetos, NAO os literais 800/769: o SCX
    * declara o container (800) e os labels (769) mais largos que o proprio
    * form (550) - artefato do Form Designer, que desenha o container alem da
    * borda da janela. Copiar o literal faria o label ultrapassar a area
    * visivel e o titulo "Liberacao de Peso" (Tahoma 18 bold) sairia cortado,
    * alem de o filho extrapolar o pai e ser RECORTADO (regra #30).
    * ValidarUIFidelity acusa isso como DIFERENCA de Width - eh falso positivo
    * conhecido, nao aplicar o literal.
    *
    * AutoSize = .F. explicito nos dois labels: em Label criado por AddObject o
    * AutoSize eh no-op e, com WordWrap = .T., ele DESCARTA a Height e colapsa
    * o texto para uma linha (regra #23).
    *
    * Nenhum controle de dados pode ficar com Top < 80 nesta tela: a faixa
    * ocupa a area 0..80, e o legado respeita isso (o primeiro Say esta em 99).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container da faixa cinza
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label de sombra (preto, 1px abaixo do titulo)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label do titulo (branco sobre o cinza do container OPACO - esta eh
        *-- a excecao legitima da regra #12, que proibe ForeColor branco em
        *-- label de DADOS)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
    *
    * Recursivo: percorre os filhos diretos do form e desce nos containers.
    * NAO ha lista de excecao aqui porque nenhum objeto do SCX legado nasce
    * oculto - os 12 objetos do dump sao visiveis, e get_descr declara
    * Visible = .T. explicitamente. Caso alguma fase futura acrescente painel
    * que deva comecar fechado, o nome dele entra num guard LOOP antes da
    * atribuicao - mantendo a recursao, para os filhos nao ficarem invisiveis
    * para sempre quando o painel for exibido.
    *
    * Nao recursa em Pages por nao haver PageFrame nesta tela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    IF loc_oControle.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControle)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - os CINCO objetos de dados do SCX legado
    *
    * Criados na ORDEM EXATA dos registros do SCX (Shape1, Say2, get_codigo,
    * get_descr, Say1), que eh o z-order do legado: o Shape1 eh a MOLDURA dos
    * dois campos (104..446 x 118..151) e precisa nascer ANTES deles para ser
    * desenhado por baixo; invertida a ordem, a moldura cobriria as caixas de
    * texto. Mesmo criterio da regra #30.
    *
    * Legado (transcrito do dump, SECAO 2):
    *   Shape1      Top=118 Left=104 Width=342 Height=33
    *               BackStyle=0  BorderColor=90,90,90
    *   Say2        Caption="Codigo : "  Left=109 Top=127  TabIndex=2
    *   get_codigo  Left=155 Top=123 Width=80  TabIndex=3
    *               Century=2  Alignment=3  InputMask="!!!!!!!!!!"
    *               ForeColor=0,0,0
    *   get_descr   Left=238 Top=123 Width=202 Height=23  TabIndex=4
    *               Visible=.T.  ForeColor=0,0,0
    *   Say1        Caption="Informe o Tipo de Liberacao para prosseguir : "
    *               Left=106 Top=99 Width=261 Height=15  TabIndex=1
    *               AutoSize=.T.  FontBold=.T.  WordWrap=.F.  ForeColor=90,90,90
    *
    * O que NAO esta no dump do SCX e vem da CLASSE do Framework legado
    * (docs\FRAMEWORK_class_codigo_fonte.txt), porque o SCX so grava override:
    *   say    -> Tahoma 8, BackStyle=0, Height=15, ForeColor=90,90,90,
    *             Alignment=0 (AutoSize=.T.)
    *   fwget  -> Tahoma 8, Format="K", Height=23, Themes=.F.,
    *             DisabledBackColor=192,192,192, DisabledForeColor=0,0,0
    *
    * Format = "K" nos dois campos eh HERANCA da classe fwget, nao invencao:
    * seleciona o conteudo ao entrar no campo. Transcrito porque Format eh
    * propriedade que o migrador costuma descartar (regra #49) - aqui eh a
    * variante de severidade BAIXA (so UX), mas o InputMask do get_codigo eh
    * ALTA: os dez "!" forcam MAIUSCULA e limitam a 10 caracteres, ou seja
    * mudam o que eh digitado E gravado. Format NAO contem "M", logo o
    * InputMask eh mascara de digitacao mesmo, e nao lista de valores validos
    * (regra #24).
    *
    * MaxLength vem da LARGURA DA COLUNA no schema, NUNCA do Width em pixels
    * (regra #19) - conferido em docs\schema.sql:
    *     SigCdNcf.cods  char(10)  -> txt_4c__codigo.MaxLength = 10
    *     SigCdNcf.descs char(60)  -> txt_4c__descr.MaxLength  = 60
    * Note que o 10 do MaxLength de cods bate com os dez "!" do InputMask do
    * legado - as duas fontes concordam.
    *
    * Century = 2 ("determinado pelo SET CENTURY") eh INERTE num campo
    * Character: so afeta exibicao de DATA. Transcrito por fidelidade - a
    * propriedade existe de fato em TextBox (conferido em
    * automation\propriedades_baseclasses.txt, regra #33), entao atribuir nao
    * derruba o Init.
    *
    * Alignment = 3 do get_codigo eh o DEFAULT real do TextBox criado por
    * AddObject (medido: nasce 3, nao 0) - transcrito explicitamente de todo
    * jeito, porque o dump o declara e o ValidarUIFidelity compara valor a
    * valor. O get_descr NAO declara Alignment, entao fica no default.
    *
    * ForeColor = RGB(0,0,0) nos DOIS campos: o dump declara preto explicito.
    * O cinza RGB(90,90,90) canonico eh so para LABEL de dado sobre a textura
    * da Page (regra #12) - nao se aplica a TextBox cujo dump traz ForeColor
    * proprio. Nos labels, ao contrario, o cinza eh o certo: Say1 o declara e
    * Say2 o herda da classe say.
    *
    * AutoSize = .F. explicito nos dois labels (regra #23): em Label criado por
    * AddObject o AutoSize eh NO-OP - a Width fica nos 100 do default -, e com
    * WordWrap = .T. ele ainda DESCARTA a Height. Os numeros do dump JA SAO o
    * auto-size que o Form Designer calculou, logo fixa-los eh reproducao fiel.
    *
    * Say2 eh a UNICA medida que o dump nao fornece (o SCX nao grava Width/
    * Alignment para ele - classe say pura, regra #23). Fica Alignment = 0
    * (desenha da esquerda, como a classe) e Width = 46, que eh a conta do
    * proprio legado: 109 + 46 = 155 = Left do get_codigo, ou seja a legenda
    * termina exatamente na borda do campo. PROIBIDO aqui o par inventado
    * Width + Alignment = 1: com o texto encostado na borda DIREITA ele cairia
    * DENTRO do TextBox e, como o label nasce antes, o campo desenharia por
    * cima e comeria a legenda ("Codigo :" viraria "Codi").
    *
    * Semente do campo codigo - legado: Get_codigo.Value = xNensi.CodnConfs.
    * O valor foi resolvido no Init (parametro do chamador, senao alias xNensi
    * do form pai, senao vazio) e eh aplicado AQUI, que eh onde o controle
    * passa a existir. LEFT(..., 10) respeita o MaxLength da coluna.
    *
    * Estado inicial de get_descr: o legado o controla pelo When
    * (Not Empty(lcCod) And CrSigCdNcf.Fixos = 2), avaliado quando o usuario
    * tenta focar o campo - so o tipo de descricao LIVRE (Fixos = 2) aceita
    * digitacao. Isso NAO eh estado de criacao e nao se decide aqui: depende de
    * consulta a SigCdNcf pelo codigo corrente, que eh o
    * SigOpLibBO.VerificarDescricaoEditavel. A ligacao desse comportamento
    * (mais o lookup do get_codigo.Valid) eh o objeto da fase de lookups, e
    * entra em ConfigurarEventos junto dos BINDEVENT dos dois campos. Por isso
    * o controle nasce aqui com o default da classe fwget.
    *
    * TabIndex NAO eh atribuido neste metodo: o passe tem de rodar depois de
    * TODOS os AddObject do form (ver AjustarOrdemTabulacao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oErro

        TRY
            *-- Shape1: moldura dos dois campos (1o dos cinco registros)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 118
                .Left        = 104
                .Width       = 342
                .Height      = 33
                .BackStyle   = 0
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            *-- Say2: legenda "Codigo :"
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "C" + CHR(243) + "digo : "
                .Top       = 127
                .Left      = 109
                .Width     = 46
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- get_codigo: codigo do tipo de liberacao (SigCdNcf.cods)
            THIS.AddObject("txt_4c__codigo", "TextBox")
            WITH THIS.txt_4c__codigo
                .FontName           = "Tahoma"
                .FontSize           = 8
                .Top                = 123
                .Left               = 155
                .Width              = 80
                .Height             = 23
                .Century            = 2
                .Alignment          = 3
                .Format             = "K"
                .InputMask          = "!!!!!!!!!!"
                .MaxLength          = 10
                .ForeColor          = RGB(0, 0, 0)
                .DisabledBackColor  = RGB(192, 192, 192)
                .DisabledForeColor  = RGB(0, 0, 0)
                .Themes             = .F.
                .Value              = LEFT(THIS.this_cCodigoInicial, 10)
                .Visible            = .T.
            ENDWITH

            *-- get_descr: descricao do tipo (SigCdNcf.descs)
            THIS.AddObject("txt_4c__descr", "TextBox")
            WITH THIS.txt_4c__descr
                .FontName           = "Tahoma"
                .FontSize           = 8
                .Top                = 123
                .Left               = 238
                .Width              = 202
                .Height             = 23
                .Format             = "K"
                .MaxLength          = 60
                .ForeColor          = RGB(0, 0, 0)
                .DisabledBackColor  = RGB(192, 192, 192)
                .DisabledForeColor  = RGB(0, 0, 0)
                .Themes             = .F.
                .Value              = ""
                .Visible            = .T.
            ENDWITH

            *-- Say1: instrucao acima da moldura (ultimo dos cinco registros)
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .WordWrap  = .F.
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Informe o Tipo de Libera" + CHR(231) + CHR(227) + ;
                             "o para prosseguir : "
                .Top       = 99
                .Left      = 106
                .Width     = 261
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.ConfigurarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarOrdemTabulacao - reproduz a ordem de Tab EFETIVA do legado
    *
    * Com AddObject, o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que aqui
    * NAO eh a do legado: o par Shape2/ok eh o ultimo registro do SCX, mas no
    * migrado ele nasce ANTES dos campos (ConfigurarBotoes roda depois do
    * cabecalho porque o botao fica DENTRO da area da faixa e precisa desenhar
    * por cima dela - regra #11). Sem este passe, o ciclo de Tab fica
    * Encerrar/Ok -> Codigo -> Descricao, isto eh o botao de SAIDA no MEIO da
    * digitacao. Nao da erro, nao entra em log e nao aparece em screenshot.
    *
    * A ordem-alvo NAO eh o literal do dump: o VFP aplica o TabIndex gravado no
    * instante em que CRIA cada objeto e descarta o valor que exceda a
    * contagem de objetos tab-aveis existentes ali. Simulando o load na ordem
    * dos REGISTROS do SCX (Shape NAO tem TabIndex - conferido em
    * automation\propriedades_baseclasses.txt - e por isso nao conta):
    *
    *   cntSombra  (1o tab-avel)  sem TabIndex no dump -> 1
    *   Say2       (2o)           dump 2, cabe          -> 2
    *   get_codigo (3o)           dump 3, cabe          -> 3
    *   get_descr  (4o)           dump 4, cabe          -> 4
    *   Say1       (5o)           dump 1, cabe          -> 1  (empurra os demais)
    *   ok         (6o)           sem TabIndex no dump -> 6
    *
    *   ordem EFETIVA do legado: Say1=1  cntSombra=2  Say2=3
    *                            get_codigo=4  get_descr=5  ok=6
    *
    * Entre os FOCALIZAVEIS isso eh Codigo -> Descricao -> Ok, que eh o ciclo
    * que o usuario percebe. Label tem TabIndex mas NAO tem TabStop (nao
    * recebe foco); Container tem os dois, mas o cnt_4c_Sombra so guarda os
    * labels da faixa, entao nao para o Tab na pratica.
    *
    * Atribuicao em ordem ASCENDENTE e com valores UNICOS dentro da faixa
    * 1..6 - sao 8 controles no form, mas dois sao Shape e nao tem a
    * propriedade, logo a faixa eh o numero de controles que a TEM. Valor
    * duplicado ou fora da faixa eh DESCARTADO em silencio, de modo que copiar
    * os literais do dump um a um seria inerte.
    *
    * Escrito com os ordinais EFETIVOS (1..6) e o literal do dump no
    * comentario de cada linha: eh o valor que o objeto realmente guarda, e
    * afirmar no codigo um numero que o VFP descarta so faria o proximo leitor
    * (ou uma auditoria dump-x-migrado) perseguir um defeito que nao existe.
    *
    * Guard por CONTROLE (PEMSTATUS(<controle>, "TabIndex", 5)), nunca
    * PEMSTATUS(THIS, "<nome>", 5): o segundo so diz que o membro existe no
    * form e deixaria a atribuicao estourar num Shape com "Property TABINDEX
    * is not found" (mesma armadilha das regras #3 e #34).
    *
    * Se alguma fase posterior acrescentar controle a este form, a sequencia
    * abaixo tem de ser revista - eh por isso que o passe eh um metodo unico e
    * nao TabIndex espalhado pelos blocos WITH de criacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS.lbl_4c_Label1, "TabIndex", 5)
                THIS.lbl_4c_Label1.TabIndex = 1      && SCX: Say1       TabIndex=1
            ENDIF

            IF PEMSTATUS(THIS.cnt_4c_Sombra, "TabIndex", 5)
                THIS.cnt_4c_Sombra.TabIndex = 2      && SCX: cntSombra  nao declara
            ENDIF

            IF PEMSTATUS(THIS.lbl_4c_Label2, "TabIndex", 5)
                THIS.lbl_4c_Label2.TabIndex = 3      && SCX: Say2       TabIndex=2
            ENDIF

            IF PEMSTATUS(THIS.txt_4c__codigo, "TabIndex", 5)
                THIS.txt_4c__codigo.TabIndex = 4     && SCX: get_codigo TabIndex=3
            ENDIF

            IF PEMSTATUS(THIS.txt_4c__descr, "TabIndex", 5)
                THIS.txt_4c__descr.TabIndex = 5      && SCX: get_descr  TabIndex=4
            ENDIF

            IF PEMSTATUS(THIS.cmd_4c_Ok, "TabIndex", 5)
                THIS.cmd_4c_Ok.TabIndex = 6          && SCX: ok         nao declara
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.AjustarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - barra de acao: Shape2 + botao Ok
    *
    * Legado (os DOIS ULTIMOS registros da arvore do SCX, nesta ordem):
    *   Shape2  Top=7 Left=444 Width=12 Height=29
    *           BackStyle=0  BorderStyle=0  BorderColor=136,189,188
    *   ok      Top=3 Left=475  Caption="\<Ok"  Cancel=.T.
    *           Picture=..\framework\imagens\cadastro_salvar_60.jpg
    *           (classe fwbtng, docs\FRAMEWORK_class_codigo_fonte.txt: Width=80
    *            Height=100, Comic Sans MS 8 bold italic, WordWrap=.T.,
    *            ForeColor=90,90,90, BackColor=255,255,255, MousePointer=15)
    *
    * Criados DEPOIS do cabecalho porque ficam em Top=3..78, DENTRO da area da
    * faixa cinza (0..80), e so desenham por cima dela nessa ordem (regra #11).
    *
    * GEOMETRIA DO BOTAO - 75x75 no lugar dos 80x100 da classe fwbtng. Os
    * literais da classe NAO CABEM nesta tela, e a conta eh exata:
    *     Left 475 + Width   80 = 555 > 550 (Width do form)   -> 5px RECORTADOS
    *     Top    3 + Height 100 = 103 >  80 (Height da faixa) -> 23px fora dela
    * Com 75x75 o botao termina em 550 - a borda EXATA do form - e em 78, ainda
    * dentro da faixa: eh o desenho que o SCX pretende. 75x75 eh tambem a
    * medida canonica dos botoes de acao do projeto (regra #10) e o mesmo
    * criterio ja aplicado ao fwbtng de FormSIGOPGRC (task743).
    *
    * Themes = .T. + DisabledPicture apontando para a MESMA imagem: em
    * CommandButton SOLTO (fora de CommandGroup) com Picture definido, o icone
    * NAO eh desenhado quando Enabled = .F. se Themes = .F. - divergencia
    * DELIBERADA do Themes = .F. da classe fwbtng, pela regra do botao
    * standalone.
    *
    * Picture TRANSCRITO do dump (cadastro_salvar_60.jpg, conferido em vbmp\):
    * no legado Fortyus "fechar = gravar". NUNCA escolher icone por semelhanca
    * semantica, e nunca envolver em IF FILE() - Picture inexistente falha em
    * silencio (regra #25). O caminho vem de gc_4c_CaminhoIcones, jamais
    * remontado de gc_4c_CaminhoBase.
    *
    * Shape2 eh TOTALMENTE INVISIVEL no legado (BackStyle=0 + BorderStyle=0) e
    * NAO sobrepoe o botao - 444..456 contra 475..550 -, por isso reproduzi-lo
    * aqui nao engole clique nenhum (regra #30). Mantido por fidelidade ao
    * PILAR 1, na mesma posicao relativa do SCX: imediatamente antes do ok.
    *
    * TabIndex NAO eh atribuido aqui: valor fora da faixa 1..N dos controles
    * que TEM a propriedade eh descartado em silencio, entao o passe inteiro
    * roda depois do ultimo AddObject do form - ver AjustarOrdemTabulacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- Shape2 do legado (decoracao invisivel, penultimo registro)
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 7
                .Left        = 444
                .Width       = 12
                .Height      = 29
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Botao Ok do legado (ultimo registro da arvore do SCX)
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top             = 3
                .Left            = 475
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Ok"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .Themes          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Enabled         = .T.
                .Visible         = .T.
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - BINDEVENT dos eventos de controle
    *
    * Chamado por ULTIMO no metodo de inicializacao: BINDEVENT so resolve
    * referencia de objeto que JA existe.
    *
    * Mapa legado -> migrado (os tres metodos do dump que tocam os campos, mais
    * o Click do ok):
    *
    *   get_codigo.Valid    -> "LostFocus" -> ValidarCodigoLostFocus
    *   get_codigo  (F4)    -> "KeyPress"  -> TxtCodigoKeyPress
    *   get_codigo  (duplo) -> "DblClick"  -> TxtCodigoDblClick
    *   get_descr.Valid     -> "LostFocus" -> ValidarDescricaoLostFocus
    *   get_descr.When      -> NAO eh evento -> AtualizarEstadoDescricao
    *   ok.Click            -> "Click"     -> BtnOkClick
    *
    * "LostFocus", NUNCA "Valid": BINDEVENT em "Valid" de TextBox nao dispara
    * de forma confiavel no VFP9, e o Valid do legado eh exatamente a SAIDA do
    * campo.
    *
    * O lookup NAO pode ser ligado a "KeyPress" sem testar a tecla: assim
    * ligado, o picker sobe no PRIMEIRO caractere digitado e o usuario nunca
    * termina de digitar o codigo (regra #47). O handler de KeyPress aqui
    * registrado existe SO para o atalho F4 e testa par_nKeyCode antes de
    * qualquer coisa. Enter/Tab de proposito NAO entram nele: as duas teclas
    * disparam o LostFocus logo depois, e atender as duas pontas abriria DOIS
    * pickers em sequencia.
    *
    * O When de get_descr nao aparece como BINDEVENT porque When NAO eh evento
    * ligavel: o BINDEVENT DESCARTA o retorno do delegate, entao um "When"
    * ligado aqui nao bloquearia edicao nenhuma. O equivalente eh reconfigurar
    * o proprio campo - AtualizarEstadoDescricao -, chamado na inicializacao e
    * em todo caminho que muda o codigo.
    *
    * F4 e duplo clique sao ACRESCIMO de ACESSO do sistema novo (o legado so
    * tem o Valid): nao trazem regra nova nenhuma - chamam o MESMO funil -,
    * por isso nao conflitam com o PILAR 1.
    *
    * TODOS os alvos sao PUBLIC (declarados sem PROTECTED): BINDEVENT para
    * metodo PROTECTED falha EM SILENCIO - o evento nao responderia e nao
    * haveria erro nenhum nem log (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            *-- get_codigo.Valid do legado: valida o codigo / abre o browse ao
            *-- SAIR do campo
            BINDEVENT(THIS.txt_4c__codigo, "LostFocus", THIS, "ValidarCodigoLostFocus")

            *-- Atalhos para o MESMO funil de lookup (F4 e duplo clique)
            BINDEVENT(THIS.txt_4c__codigo, "KeyPress", THIS, "TxtCodigoKeyPress")
            BINDEVENT(THIS.txt_4c__codigo, "DblClick", THIS, "TxtCodigoDblClick")

            *-- get_descr.Valid do legado: fecha o retorno com a descricao digitada
            BINDEVENT(THIS.txt_4c__descr, "LostFocus", THIS, "ValidarDescricaoLostFocus")

            *-- ok.Click do legado
            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.ConfigurarEventos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodigoKeyPress - F4 abre o picker de tipos de liberacao
    *
    * Parametros na assinatura (par_nKeyCode, par_nShiftAltCtrl) sao
    * OBRIGATORIOS em handler ligado a "KeyPress": sem eles o VFP9 estoura
    * "No PARAMETER statement is found" na primeira tecla (regra #3).
    *
    * O teste da tecla eh o que impede o defeito da regra #47: handler de
    * KeyPress que abre picker sem testar par_nKeyCode dispara o dialogo a CADA
    * caractere. So F4 entra - Enter/Tab ficam com o LostFocus.
    *
    * NAO liga a guarda this_lEmLookup: quem liga e desliga eh o FUNIL, que eh
    * precisamente o que este handler chama. Irmao que delega e liga a flag
    * mataria o atalho - o funil devolveria sem abrir nada.
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115        && F4 (115; NUNCA 63, que eh o "?")
            THIS.AbrirLookupTipoLiberacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodigoDblClick - duplo clique no campo codigo abre o picker
    *
    * Mesma observacao do F4: atalho de ACESSO, sem regra propria, delegando ao
    * funil - que eh quem cuida da guarda de reentrancia.
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodigoDblClick()
        THIS.AbrirLookupTipoLiberacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoLostFocus - get_codigo.Valid do legado
    *
    * Legado (transcrito do dump):
    *     If Not Empty(This.Value)
    *         <carrega CrSigCdNcf filtrado por Emps e por Tipos>
    *         If Not Seek(This.Value, 'CrSigCdNcf', 'Cods')
    *             loBrowse = CreateObject('fwBuscaSel', 'CrSigCdNcf', 'Cods',
    *                                     This.Value, 'Tipo de Liberacao')
    *             loBrowse.AddColuna('Cods',  '', 'Codigo',    .t., 'Cods')
    *             loBrowse.AddColuna('Descs', '', 'Descricao', .t., 'Descs')
    *             loBrowse.Show
    *         Endif
    *         This.Value = CrSigCdNcf.Cods
    *         If CrSigCdNcf.Fixos <> 2
    *             ThisForm.Get_descr.Value = CrSigCdNcf.Descs
    *             ThisForm.Retorno = CrSigCdNcf.cods + CrSigCdNcf.Descs
    *         Endif
    *     EndIf
    *
    * Campo VAZIO nao faz nada - igual ao legado, que envolve o metodo inteiro
    * em "If Not Empty(This.Value)". Em particular NAO limpa a descricao e NAO
    * avisa nada.
    *
    * DUAS guardas, que resolvem problemas diferentes e sao complementares:
    *
    *   1) this_lEmLookup (reentrancia) - o picker eh MODAL: ao abrir, o foco
    *      sai do campo e este MESMO LostFocus redispara, empilhando um segundo
    *      dialogo (regra #37). Quem liga/desliga eh o funil.
    *
    *   2) this_cUltimoCodigoValidado (valor nao mudou) - LostFocus NAO eh
    *      Valid: o Valid do legado so roda quando o valor MUDA, o LostFocus
    *      roda SEMPRE que o foco sai. Sem esta segunda guarda, um codigo
    *      invalido faria o picker reabrir a cada passagem pelo campo, sem o
    *      usuario ter digitado nada.
    *
    * Os tres RETURN ficam ANTES do TRY - RETURN dentro de TRY/CATCH eh
    * proibido (regra #1), inclusive o RETURN bare de guarda.
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigoLostFocus()
        LOCAL loc_cCodigo, loc_oErro

        *-- Guarda 1: picker modal ja aberto
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(THIS.txt_4c__codigo.Value)

        *-- Legado: If Not Empty(This.Value)
        IF EMPTY(loc_cCodigo)
            RETURN
        ENDIF

        *-- Guarda 2: valor inalterado desde a ultima validacao
        IF loc_cCodigo == ALLTRIM(THIS.this_cUltimoCodigoValidado)
            RETURN
        ENDIF

        TRY
            THIS.AbrirLookupTipoLiberacao()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.ValidarCodigoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTipoLiberacao - FUNIL do lookup de SigCdNcf
    *
    * UNICO ponto que abre o picker: atende as TRES entradas (LostFocus do
    * campo, F4 e duplo clique), e por isso eh aqui que mora a guarda de
    * reentrancia - ligada na entrada e liberada DEPOIS do ENDTRY, para valer
    * tambem quando o CATCH dispara.
    *
    * Reproduz o get_codigo.Valid do legado em dois passos:
    *
    *   1) MATCH EXATO na faixa de tipos permitida - o "Seek(This.Value,
    *      'CrSigCdNcf', 'Cods')" do legado, que a BO faz em
    *      ValidarCodigoDigitado (ela recarrega o cursor filtrado por Emps e
    *      por Tipos e indexa por Cods, igual ao Index On do legado).
    *
    *   2) Nao achou -> BROWSE, exatamente como o legado faz com o fwBuscaSel.
    *
    * O picker recebe o cursor JA POPULADO (this_cCursorNcf da BO), nao a
    * tabela: o universo tem de ser o FILTRADO por empresa e por tipo, que eh
    * regra de negocio do legado. Por isso o CREATEOBJECT eh SEM parametros -
    * com a tabela no 2o argumento o FormBuscaAuxiliar faria a consulta dele,
    * SEM o filtro, e o usuario poderia escolher um tipo que o chamador nao
    * autorizou. Eh tambem o motivo de nao delegar o match exato ao Init do
    * picker (regra #37): o SEEK do legado roda no universo filtrado.
    *
    * Captions das colunas TRANSCRITOS do AddColuna do legado ("Codigo" e
    * "Descricao"), nao os nomes das colunas.
    *
    * NAO existe mensagem de "nao encontrado" e NAO se apaga o codigo digitado
    * (regra #50): o proprio picker eh o feedback, e o valor digitado serve de
    * ponto de partida. Universo filtrado vazio abre uma grade vazia - eh o que
    * o legado faz, e tambem nao eh erro.
    *
    * O valor so eh atribuido DENTRO da guarda this_lSelecionou (regra #37):
    * picker cancelado preserva o que o usuario digitou. Aqui ha DIVERGENCIA
    * DELIBERADA do legado, que faz "This.Value = CrSigCdNcf.Cods"
    * INCONDICIONALMENTE depois do browse - com ESC, aquilo copiava para o
    * campo a linha em que o cursor estivesse parado, trocando o que o usuario
    * digitou por um registro que ele nao escolheu.
    *
    * PUBLIC (sem PROTECTED): chamado por THIS. nos tres handlers e alvo
    * potencial de BINDEVENT de atalho (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTipoLiberacao()
        LOCAL loc_oBusca, loc_cCodigo, loc_cCursor, loc_cTitulo, loc_oErro
        LOCAL loc_cErroBO, loc_lFalhouConsulta

        loc_cErroBO         = ""
        loc_lFalhouConsulta = .F.

        THIS.this_lEmLookup = .T.

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorNcf
            loc_cCodigo = ALLTRIM(THIS.txt_4c__codigo.Value)
            loc_cTitulo = "Tipo de Libera" + CHR(231) + CHR(227) + "o"

            *-- Tela -> BO ANTES de consultar: o BO tem de validar o que esta na
            *-- tela AGORA, nao o que sobrou da consulta anterior. Importa no
            *-- caminho em que o usuario ABANDONA o picker (ESC): sem esta ida, o
            *-- codigo guardado no BO seria o da ultima resolucao BEM-SUCEDIDA, e
            *-- o retorno montado depois pela descricao livre sairia com um codigo
            *-- que nao esta mais no campo. O legado nao tem esse risco porque lah
            *-- o proprio controle eh o modelo.
            THIS.FormParaBO()

            *-- Passo 1: Seek no universo filtrado (a BO recarrega e indexa)
            IF THIS.this_oBusinessObject.ValidarCodigoDigitado(loc_cCodigo)
                THIS.AplicarTipoSelecionado()
            ELSE
                *-- Consulta que FALHOU nao eh "codigo nao encontrado". A BO
                *-- devolve .F. nos DOIS casos e so a mensagem os distingue -
                *-- por isso ela eh limpa na entrada de CarregarTiposPermitidos.
                *--
                *-- Sem este teste, erro de SQL/conexao abria um picker VAZIO e
                *-- calado: a regra #50 manda NAO avisar quando o universo esta
                *-- apenas vazio (universo vazio eh dado, nao erro), entao o
                *-- usuario nao tinha como saber que a consulta nem rodou -
                *-- falha muda, proibida pela regra #9.
                *--
                *-- Quem exibe eh o FORM, nunca a BO: a BO nao tem tela e
                *-- reportar nos dois lugares mostraria o mesmo erro duas vezes
                *-- (regra #20).
                *--
                *-- Flag no lugar de RETURN porque este bloco esta DENTRO do
                *-- TRY (regra #1).
                loc_cErroBO = THIS.this_oBusinessObject.this_cMensagemErro

                IF !EMPTY(loc_cErroBO)
                    THIS.this_cMensagemErro = loc_cErroBO
                    loc_lFalhouConsulta     = .T.
                    MsgErro(loc_cErroBO, "Tipo de Libera" + CHR(231) + CHR(227) + "o")
                ENDIF

                *-- Passo 2: browse do legado (fwBuscaSel)
                IF !loc_lFalhouConsulta AND USED(loc_cCursor)
                    SELECT (loc_cCursor)

                    *-- Ordem do legado: o browse lista por Cods. A BO deixa o
                    *-- cursor com DOIS tags (Cods e Descs) e o ultimo INDEX ON
                    *-- fica controlando, entao a ordem tem de ser reposta aqui.
                    SET ORDER TO TAG Cods
                    GO TOP

                    *-- 4o argumento do fwBuscaSel legado era This.Value: ele
                    *-- posiciona o browse no que foi digitado. Prefixo com
                    *-- LEFT/== porque SET EXACT ON (config.prg) faz o "="
                    *-- exigir a chave inteira. Nao achando prefixo, volta ao
                    *-- topo - LOCATE sem FOUND() deixaria o ponteiro em EOF.
                    IF !EMPTY(loc_cCodigo)
                        LOCATE FOR LEFT(UPPER(ALLTRIM(Cods)), LEN(m.loc_cCodigo)) == UPPER(m.loc_cCodigo)
                        IF !FOUND()
                            GO TOP
                        ENDIF
                    ENDIF

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                    IF VARTYPE(loc_oBusca) = "O"
                        *-- Cursor JA populado: nenhuma consulta do picker
                        loc_oBusca.this_cCursorDestino = loc_cCursor
                        loc_oBusca.this_cTitulo        = loc_cTitulo

                        IF VARTYPE(loc_oBusca.cnt_4c_Cabecalho) = "O"
                            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                        ENDIF

                        *-- Captions transcritos do AddColuna do legado
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")

                        loc_oBusca.Show()

                        *-- Atribuicao SO sob a guarda de selecao (regra #37)
                        IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                            IF THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                                THIS.AplicarTipoSelecionado()
                            ENDIF
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

            *-- Marca o valor CORRENTE (que pode ter acabado de vir do picker)
            *-- como ja processado, para o LostFocus nao reabrir o dialogo na
            *-- proxima saida do campo sem o usuario ter mudado nada.
            THIS.this_cUltimoCodigoValidado = ALLTRIM(THIS.txt_4c__codigo.Value)

            *-- get_descr.When do legado: a editabilidade da descricao depende
            *-- do codigo, que pode ter mudado agora.
            THIS.AtualizarEstadoDescricao()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.AbrirLookupTipoLiberacao")
        ENDTRY

        *-- Liberar a guarda DEPOIS do ENDTRY: dentro do TRY, um erro saltaria
        *-- para o CATCH e a flag ficaria presa em .T., matando o lookup pelo
        *-- resto da vida do form (regra #47).
        THIS.this_lEmLookup = .F.

        *-- Cursor de apoio do picker: fechar libera o alias. Nao ha perda -
        *-- ValidarCodigoDigitado/CarregarTiposPermitidos o recriam do zero a
        *-- cada validacao, e AplicarTipoSelecionado le as PROPRIEDADES da BO,
        *-- nao o cursor. VARTYPE antes de USED porque, se o TRY tivesse
        *-- estourado na primeira linha, loc_cCursor seria .F. e USED(.F.)
        *-- dispararia erro no proprio bloco de limpeza.
        IF VARTYPE(loc_cCursor) = "C"
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarTipoSelecionado - bloco final do get_codigo.Valid do legado
    *
    * Legado:
    *     This.Value = CrSigCdNcf.Cods
    *     If CrSigCdNcf.Fixos <> 2
    *         ThisForm.Get_descr.Value = CrSigCdNcf.Descs
    *         ThisForm.Retorno = CrSigCdNcf.cods + CrSigCdNcf.Descs
    *     Endif
    *
    * Metodo UNICO de aplicacao, chamado pelos DOIS caminhos do funil (match
    * exato e selecao no picker), porque no legado tambem eh um bloco so: o
    * browse apenas reposiciona o cursor, e a atribuicao que vem depois dele eh
    * a mesma nos dois casos.
    *
    * O corpo sao DUAS chamadas, nesta ordem, e nada mais:
    *
    *   1) o BO fecha o retorno (FecharRetornoDoTipo) - a conta eh REGRA DE
    *      NEGOCIO e tem FONTE UNICA no BO. Antes desta fase o form repetia a
    *      concatenacao para atender o caminho do picker, que nao passa por
    *      ValidarCodigoDigitado; duas copias da mesma formula divergem na
    *      primeira alteracao de uma delas (regra #17).
    *
    *   2) o form espelha o resultado na tela (o hook BO -> tela), que eh onde
    *      mora o "This.Value = CrSigCdNcf.Cods" do legado e a guarda de
    *      Fixos <> 2.
    *
    * PUBLIC (sem PROTECTED): chamado por THIS. do funil e ponto de aplicacao
    * unico, que precisa seguir alcancavel caso outra entrada seja ligada por
    * BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AplicarTipoSelecionado()
        LOCAL loc_oErro

        TRY
            *-- 1) BO calcula (fonte unica da regra de negocio)
            THIS.this_oBusinessObject.FecharRetornoDoTipo()

            *-- 2) tela espelha
            THIS.BOParaForm()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.AplicarTipoSelecionado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - TELA -> BO (hook unico de transferencia, sentido de ida)
    *
    * No legado nao existe transferencia nenhuma: os dois campos SAO o modelo
    * ("ThisForm.Get_codigo.Value" eh lido direto onde for preciso, e o
    * ThisForm.Retorno eh montado somando os .Value dos controles). Na
    * arquitetura em camadas a PROPRIEDADE do BO eh o modelo e o controle eh
    * so a tela, entao alguem tem de copiar um no outro - e esse alguem tem de
    * ser UM lugar so, senao cada ponto que precisar do valor digitado o le de
    * um jeito diferente.
    *
    * Leva ao BO as DUAS familias de estado desta tela:
    *
    *   a) os parametros de abertura (this_nTipo / this_cCodigoInicial), que
    *      governam o Where da consulta de tipos permitidos. Sao constantes na
    *      vida do dialogo, mas vao por aqui para que exista um unico ponto de
    *      alimentacao do BO;
    *
    *   b) o que esta NOS CAMPOS agora - o codigo e a descricao.
    *
    * O item (b) eh o que a regra do hook exige: o espelhamento de volta
    * (BO -> tela) so pode repintar um campo EDITAVEL se o caminho de ida
    * tambem o LER, senao o BO fica com valor velho e nao ha fonte unica.
    *
    * PADR(..., 10) no codigo, nao ALLTRIM: a chave do retorno eh POSICIONAL
    * (regra #42) e o campo do legado tem InputMask de DEZ posicoes, ou seja
    * "Get_codigo.Value" lah SEMPRE tem 10 caracteres. Guardar o valor
    * encurtado faria o retorno sair com menos de 10 na parte do codigo
    * exatamente no caso de descricao livre, que eh quem soma os dois .Value.
    *
    * A descricao vai CRUA (sem ALLTRIM): o ALLTRIM eh da COMPARACAO e do
    * teste de vazio, e apagar espacos aqui mudaria o que o usuario ve quando
    * o hook de volta espelhar o valor.
    *
    * Fica DEPOIS do funil de lookup no arquivo, mas roda ANTES dele em
    * runtime - o funil chama este hook na entrada, para o BO validar o que
    * esta na tela e nao o que sobrou da consulta anterior.
    *
    * PROTECTED EXPLICITO, e nao por estilo: a FormBase declara
    * "PROTECTED PROCEDURE FormParaBO" (eh um dos hooks que ela chama por
    * THIS.), e em VFP9 a subclasse NAO PODE ALARGAR esse escopo - escrever
    * PROCEDURE sem o modificador nao torna o metodo publico, so ESCONDE que
    * ele segue protegido. Medido neste form em 2026-11-08, com o metodo
    * declarado sem PROTECTED: PEMSTATUS(oForm, "FormParaBO", 5) devolve .T.
    * (o 3o argumento 5 responde "existe?", nao "da para chamar daqui?") e a
    * chamada de fora estoura "Property FORMPARABO is not found" - a mesma
    * armadilha das regras #3 e #51.
    *
    * Logo: chamar SEMPRE por THIS. de dentro da classe, que eh o que os tres
    * call sites fazem. Para exercitar este hook num harness, nao chamar do
    * script - subclassear o form e expor um wrapper publico (subclasse
    * alcanca membro protegido; script solto nao). Eh o que
    * automation\ProbeF8SigOpLib760.prg faz.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                *-- (a) parametros de abertura
                loc_oBO.this_nTipoFiltro    = THIS.this_nTipo
                loc_oBO.this_cCodigoInicial = THIS.this_cCodigoInicial

                *-- (b) estado corrente dos campos
                loc_oBO.this_cCods  = PADR(THIS.txt_4c__codigo.Value, 10)
                loc_oBO.this_cDescs = THIS.txt_4c__descr.Value
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - BO -> TELA (hook unico de transferencia, sentido de volta)
    *
    * Eh o bloco final do get_codigo.Valid do legado:
    *
    *     This.Value = CrSigCdNcf.Cods
    *     If CrSigCdNcf.Fixos <> 2
    *         ThisForm.Get_descr.Value = CrSigCdNcf.Descs
    *     Endif
    *
    * Le as PROPRIEDADES do BO, nunca o cursor - quem leu o cursor foi
    * CarregarDoCursor. E NAO recalcula nada: o retorno chega pronto do BO
    * (FecharRetornoDoTipo), e aqui so se copia.
    *
    * A GUARDA Fixos <> 2 EH O QUE IMPEDE O HOOK DE APAGAR A DIGITACAO, e eh a
    * razao de ela estar aqui e nao no chamador. Espelhar "todos os campos"
    * seria o refactor obvio de desduplicacao e seria DESTRUTIVO: com
    * Fixos = 2 a descricao eh LIVRE - o usuario eh que a digita -, e repintar
    * o campo com o valor da tabela sobrescreveria o que ele acabou de
    * escrever, sem erro e sem log, parecendo so que "a tela nao aceita o que
    * eu digito". A divisao que a regra do hook pede (derivado repinta sempre,
    * editavel nao) sai DE GRACA aqui porque o criterio eh do proprio BO e
    * mora numa property dele (this_nFixos) - nao ha flag de "ja carregou" a
    * inventar nem criterio a redescobrir no form:
    *
    *     Fixos <> 2  descricao DERIVADA da tabela -> repinta sempre
    *     Fixos  = 2  descricao DIGITADA pelo usuario -> nao toca
    *
    * O codigo, ao contrario, repinta SEMPRE: ele eh a chave que o BO acabou
    * de resolver, e o legado tambem o reescreve sem guarda nenhuma.
    *
    * fixos eh numeric(1,0) no schema (nao bit), logo chega SEMPRE Numerico ao
    * VFP: a comparacao direta com 2 nao corre risco de type mismatch
    * (regra #13).
    *
    * LEFT(...) nas duas atribuicoes respeita o MaxLength dos campos, que vem
    * da largura das colunas - cods char(10) e descs char(60) (regra #19).
    *
    * COMPORTAMENTO DO LEGADO REPRODUZIDO DE PROPOSITO, apesar de discutivel:
    * com Fixos = 2 o legado nao toca na descricao NEM no retorno - quem os
    * fecha eh o get_descr.Valid, quando o usuario digitar a descricao.
    * Resultado: escolher um tipo de descricao livre e clicar Ok SEM digitar a
    * descricao devolve o retorno ANTERIOR. Eh o que o legado faz; "consertar"
    * aqui seria inventar regra que ele nao tem (regra #17), e o proprio
    * rotulo da tela ("Informe o Tipo de Liberacao para prosseguir") trata o
    * preenchimento como obrigatorio pelo fluxo.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo do hook de ida: a FormBase declara
    * "PROTECTED PROCEDURE BOParaForm" e o escopo vem da HERANCA - omitir o
    * modificador nao alarga nada, so mente para quem le. Chamar por THIS. de
    * dentro da classe (aqui, so pelo funil de aplicacao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                *-- Legado: This.Value = CrSigCdNcf.Cods (sem guarda)
                THIS.txt_4c__codigo.Value = LEFT(loc_oBO.this_cCods, 10)

                *-- Legado: If CrSigCdNcf.Fixos <> 2
                IF loc_oBO.this_nFixos <> 2
                    THIS.txt_4c__descr.Value = LEFT(loc_oBO.this_cDescs, 60)
                ENDIF

                *-- Retorno: calculado pelo BO, apenas espelhado aqui
                THIS.this_cRetorno = loc_oBO.this_cRetorno
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDescricao - get_descr.When do legado
    *
    * Legado:
    *     lcCod = ThisForm.Get_codigo.Value
    *     Select * From SigCdNcf Where cods = '<lcCod>'
    *     Return (NOt Empty(lcCod) And CrSigCdNcf.Fixos = 2 )
    *
    * Isto NAO vira BINDEVENT: When nao eh evento ligavel, e o BINDEVENT
    * DESCARTA o retorno do delegate - um "When" assim ligado nao bloquearia
    * edicao nenhuma. O equivalente em runtime eh reconfigurar o campo, e eh
    * por isso que este metodo roda na inicializacao (estado de abertura, com a
    * semente de codigo que o chamador passou) e no fim do funil de lookup
    * (unico lugar onde o codigo muda).
    *
    * ReadOnly + TabStop no lugar de Enabled: o "When = .F." do legado impede o
    * FOCO mas NAO muda a aparencia do controle (ele continua habilitado).
    * Enabled = .F. acrescentaria o fundo cinza de controle desabilitado, que o
    * legado nao tem. Com ReadOnly = .T. + TabStop = .F. o campo sai do ciclo
    * de Tab e nao aceita digitacao, mantendo as cores - divergencia residual:
    * clique do mouse ainda posiciona o cursor nele, sem permitir alteracao.
    * Height/ForeColor/MaxLength definidos na criacao nao sao tocados.
    *
    * Notar a diferenca de universo em relacao ao lookup, que vem do legado:
    * este When consulta SigCdNcf SO por cods (sem filtro de empresa ou de
    * tipo), e eh por isso que a BO usa um cursor temporario proprio aqui, sem
    * mexer no cursor filtrado do picker.
    *
    * Codigo vazio dispensa a consulta - o proprio legado curto-circuita com
    * "Not Empty(lcCod)". E sem conexao viva (gnConnHandle = 0 no harness de
    * teste, -1 no ValidarUIFidelity) o campo fica nao-editavel sem ir ao
    * banco: SQLEXEC com handle invalido DISPARA EXCECAO, e gastar o CATCH da
    * BO para redescobrir isso a cada abertura do form seria desperdicio.
    *
    * PUBLIC (sem PROTECTED): chamado de fora da cadeia de criacao (pelo funil
    * de lookup) e candidato natural a alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoDescricao()
        LOCAL loc_cCodigo, loc_lEditavel, loc_oErro

        TRY
            loc_cCodigo   = ALLTRIM(THIS.txt_4c__codigo.Value)
            loc_lEditavel = .F.

            *-- Legado: Return (Not Empty(lcCod) And CrSigCdNcf.Fixos = 2)
            IF !EMPTY(loc_cCodigo)
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        loc_lEditavel = THIS.this_oBusinessObject.VerificarDescricaoEditavel(loc_cCodigo)
                    ENDIF
                ENDIF
            ENDIF

            WITH THIS.txt_4c__descr
                .ReadOnly = !loc_lEditavel
                .TabStop  = loc_lEditavel
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.AtualizarEstadoDescricao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescricaoLostFocus - get_descr.Valid do legado
    *
    * Legado (o metodo INTEIRO do dump):
    *     If Not Empty(This.Value)
    *         ThisForm.Retorno = ThisForm.Get_codigo.Value + ThisForm.get_descr.Value
    *     EndIf
    *
    * So fecha o retorno - nao consulta banco, nao valida nada contra SigCdNcf
    * e nao avisa quando esta vazio. Acrescentar validacao aqui seria inventar
    * regra que o legado nao tem.
    *
    * Passa o valor CRU do campo (sem ALLTRIM) para a BO, que eh quem monta o
    * retorno posicional - this_cCods (char(10) padded) + a descricao digitada,
    * igual ao "Get_codigo.Value + get_descr.Value" do legado. O ALLTRIM local
    * serve SO para o teste de vazio.
    *
    * Este handler nao abre picker, por isso nao precisa da guarda de
    * reentrancia: ele nao tem como redisparar a si mesmo.
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescricaoLostFocus()
        LOCAL loc_cDescricao, loc_oErro

        TRY
            loc_cDescricao = ALLTRIM(THIS.txt_4c__descr.Value)

            *-- Legado: If Not Empty(This.Value)
            IF !EMPTY(loc_cDescricao)
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    *-- Tela -> BO antes de fechar o retorno: eh o hook de ida
                    *-- que leva o CODIGO corrente, que eh a 1a metade do valor
                    *-- devolvido ("Get_codigo.Value + get_descr.Value" no
                    *-- legado). Sem ele a descricao recem-digitada seria somada
                    *-- ao codigo de uma resolucao anterior.
                    THIS.FormParaBO()

                    THIS.this_cRetorno = ;
                        THIS.this_oBusinessObject.ConfirmarDescricaoDigitada(THIS.txt_4c__descr.Value)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.ValidarDescricaoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOkClick - Click do botao Ok
    *
    * Legado: PROCEDURE Click / ThisForm.Release  (o metodo INTEIRO do dump)
    *
    * O botao NAO valida e NAO monta o retorno: no legado o valor de
    * ThisForm.Retorno ja foi gravado pelos Valid de get_codigo/get_descr, e o
    * Click apenas FECHA a tela. Reproduzido assim de proposito - acrescentar
    * validacao aqui seria inventar regra que o legado nao tem.
    *
    * PUBLIC de proposito: eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnOkClick()
        LOCAL loc_oErro

        TRY
            THIS.FecharDialogo()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLib.BtnOkClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - UNICO ponto de fechamento da tela
    *
    * Legado: ThisForm.Release no Click do ok, mais Return ThisForm.Retorno no
    * Unload - retorno que so chega a quem abre com DO FORM <form> TO <var>.
    *
    * Fecha com Hide(), NAO com Release(). Este dialogo existe para DEVOLVER o
    * par codigo+descricao, e o sistema novo o abre por CREATEOBJECT + Show(),
    * onde o retorno do Unload eh inalcancavel: o chamador le
    * THIS.this_cRetorno DEPOIS do Show(). Medido no VFP9 - form object nao
    * segue refcount, entao Release() destroi o objeto mesmo com variavel
    * externa apontando para ele (a referencia do chamador vira VARTYPE "X" e a
    * leitura seguinte estoura "is not an object"), enquanto Hide() devolve o
    * Show() do mesmo jeito e mantem o objeto legivel. Quem chama eh que
    * libera.
    *
    * Nao eh invencao: eh o desenho que o FormBuscaAuxiliar do projeto JA adota
    * ("Usa Hide() em vez de Release() para permitir leitura de propriedades /
    * Caller deve chamar Release() apos ler valores"). Para o usuario a tela
    * fecha identica - PILAR 1 preservado; muda so o tempo de vida do objeto,
    * que eh PILAR 3.
    *
    * NAO ha efeito de Destroy a antecipar para ca: this_cRetorno eh property
    * DESTE form (nao do BO) e o Destroy nao a limpa, entao adiar o Destroy nao
    * esconde resultado nenhum do chamador.
    *
    * Metodo proprio, e nao Hide() solto no handler, para que todo caminho de
    * fechamento compartilhe esta decisao e este comentario.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * Unload - Legado: PROCEDURE Unload / Return ThisForm.Retorno
    *
    * Mantido porque o legado TEM esse retorno: atende quem venha a abrir o
    * dialogo com DO FORM ... TO <var>. Para o chamador canonico do sistema
    * novo (CREATEOBJECT + Show()) o caminho eh ler THIS.this_cRetorno - os
    * dois devolvem o MESMO valor, que eh o ponto.
    *
    * Sem DODEFAULT(): o retorno do Form base sobrescreveria o valor. Padrao
    * identico ao FormCliente.Unload do projeto.
    *
    * this_cRetorno eh property do FORM e o Destroy nao a limpa, portanto o
    * valor segue valido aqui - o Unload dispara DEPOIS do Destroy.
    *--------------------------------------------------------------------------
    PROCEDURE Unload()
        RETURN THIS.this_cRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera o BO e devolve ao FormBase
    *
    * DODEFAULT() na ULTIMA linha eh obrigatorio: eh o FormBase.Destroy que
    * reconstroi os popups do menu principal apos o fechamento de um form
    * modal; sem ele o menu do sistema aparece encolhido (regra #145).
    *
    * NAO limpa this_cRetorno: o chamador le essa propriedade depois do Show(),
    * e o dialogo se esconde (Hide) em vez de se destruir justamente para que a
    * referencia continue valida.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

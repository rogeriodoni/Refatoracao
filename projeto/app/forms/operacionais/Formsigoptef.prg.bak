*==============================================================================
* Formsigoptef.prg - Dialogo de Cartao de Credito / TEF (SiTef)
*
* Legado  : sigoptef.SCX (form OPERACIONAL, modal, WindowType = 1, 500x370)
* Herda de: FormBase
* BO      : sigoptefBO (classes\sigoptefBO.prg)
*
* Tipo de layout: FLAT (OPERACIONAL)
*   A arvore de objetos do SCX legado tem a raiz num "form" GENERICO (Class =
*   form, nao frmcadastro) e NAO declara nenhuma Page (ver layout.json): os
*   objetos (cntSombra com lblSombra/lblTitulo, SAIDA, Shape2, labels,
*   GetValor/GetDigitos/GetParcela/GetCartao/GetCodSeg, Container1, Text1,
*   Timer1) penduram direto na Form. Nao existe pagina de Lista nem pagina de
*   Dados a reproduzir - criar essa estrutura aqui seria inventar superficie
*   que o legado nao tem (viola o PILAR 1). Mesmo padrao do Formsigopsen.prg
*   e do FormSIGPRSTF.prg (referencias de estilo para esta fase).
*
* Funcao da tela:
*   Dialogo MODAL exibido durante o fechamento de venda para processar o
*   pagamento em cartao via TEF, atraves da DLL CliSiTef32I.DLL. O chamador
*   informa endereco do SiTef, valor, cupom, caixa, tipo de debito/credito,
*   forma de pagamento (parcelas) e um identificador unico da transacao; a
*   tela conduz a interacao byte-a-byte com a DLL (maquina de estados em
*   ContinuaFuncaoSiTefInterativo) e devolve o resultado da autorizacao.
*
* FASE 3/8 - Estrutura Base
*   Este arquivo PARCIAL cobre DEFINE CLASS + propriedades + Init +
*   ValidarParametros + InicializarForm + wiring do BO + os DOIS containers
*   que o SCX legado declara (cntSombra -> cnt_4c_Sombra, com os dois labels
*   do titulo; Container1 -> cnt_4c_Container1, com o label da mensagem de
*   instrucao ao operador). Os controles que penduram DIRETO na Form (SAIDA,
*   Shape2, labels soltos, GetValor/GetDigitos/GetParcela/GetCartao/GetCodSeg,
*   Text1, Timer1) e os handlers de interacao com o SiTef sao escopo das
*   fases 4 a 8 - inclusive a DECLARE DLL, que por "DECLARE DLL carrega na
*   hora e mata o form" (CLAUDE.md) so pode entrar dentro de um Load
*   protegido.
*
* Ordem de criacao dos containers (CLAUDE.md regra #11)
*   cnt_4c_Sombra eh o PRIMEIRO AddObject da tela: a faixa cinza ocupa
*   Top = 0..80 e o CommandGroup SAIDA do legado fica em Top = -2, Left = 420,
*   isto eh DENTRO da area da faixa. Criado depois dela (fase 4), o botao
*   Cancelar desenha POR CIMA da faixa; invertida a ordem, o cabecalho cobre
*   o botao - unica saida do dialogo.
*
* Correspondencia legado -> migrado (parametros do Init; ver sigoptefBO.prg)
*   Legado: Parameters EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto,
*            NumParcs, lcIdent, pcOpers
*   .poDatamgr = CreateObject("fSqlConector",...) + pnIdconn > 0
*                                       -> THIS.ValidarParametros()
*   .poDatamgr.SqlExecute(SigOpFp...) + SqlExecute(SigCdEmp...)
*                                       -> sigoptefBO.BuscarParametrosPagamento()
*                                          (chamado por THIS.CarregarParametrosPagamento())
*   If crSigOpFp.lCartao = "N" / Container1.Label1.Caption = ...
*                                       -> THIS.AtualizarTextosDaTela()
*                                          (hook BOParaForm delega para ela)
*
*   O retorno da tela (equivalente ao Unload legado, usado via "DO FORM ...
*   TO var") acompanha os handlers de interacao com o SiTef, nas fases 7 e 8.
*
* FASE 4/8 - Campos de Captura e Botao de Saida
*   Este form OPERACIONAL nao tem lista nem PageFrame (ver layout.json: raiz
*   "Class: form"/"BaseClass: form", ZERO objeto BaseClass grid/pageframe) -
*   o template generico "Grid + 6 botoes CRUD" desta fase NAO SE APLICA aqui
*   (inventar essa superficie violaria o PILAR 1), mesmo criterio ja usado
*   nos irmaos desta familia (Formsigopdtf.prg/task725 - "Sitef - Cartao de
*   Debito" - e Formsigopsen.prg/task799).
*
*   Em vez disso, esta fase entrega a camada VISUAL que resta criar direto
*   na Form (todos os controles exceto cnt_4c_Sombra/cnt_4c_Container1, ja
*   entregues na Fase 3): ConfigurarCampos() (Shape2 + labels + TextBoxes +
*   Timer1, SEM nenhum evento ligado), ConfigurarBotaoSaida() (CommandGroup
*   cmg_4c_Saida com o botao Cancelar, SEM o Click) e
*   ConfigurarOrdemTabulacao(). O BINDEVENT do Click e os eventos de
*   protocolo com a DLL (When/Valid/GotFocus/LostFocus dos campos,
*   Timer1.Procedure) ficam para as fases 6-8, junto com a DECLARE DLL -
*   amarrar agora um Click que chama ContinuaFuncaoSiTefInterativo (exige o
*   estado do protocolo, inexistente ainda) e ThisForm.RetornoFalha (metodo
*   que tambem ainda nao existe) produziria um handler incompleto.
*
* FASE 5/8 - Metodos de Retorno ao PDV (sem dependencia da DLL)
*   O template generico desta fase ("Page2 - campos principais, parte 1")
*   nao se aplica aqui pelo mesmo motivo das fases 3 e 4: este form nao tem
*   PageFrame/Page2 (ver layout.json) e ConfigurarCampos() da Fase 4 ja
*   criou TODOS os controles (nao ha "metade" para dividir).
*
*   O que falta e so o protocolo de interacao com a DLL (When/Valid/
*   GotFocus/LostFocus + Timer1.Procedure + DECLARE DLL), que a Fase 3/4 ja
*   explicitamente deferiu para as fases 6-8 - exigem o estado do protocolo
*   (ProximoComando/TipoCampo/Buffer/etc, so existe apos o Load com DECLARE
*   DLL). Esta fase entrega a proxima peca que NAO depende desse estado e
*   que os handlers das fases 6-8 vao chamar: os tres metodos de
*   finalizacao da transacao, equivalentes aos PROCEDURE retornofalha/
*   montaretorno/errotef do legado (sigoptef_form_codigo_fonte.txt:756-831) -
*   escrevem os arquivos de resposta ao PDV (C:\client\Resp\IntPos.001/.STS,
*   formato SDF fixo consumido pela integracao TEF) e registram auditoria
*   via sigoptefBO.RegistrarTransacaoTef(). Nenhum dos tres le
*   ProximoComando/TipoCampo/Buffer - so recebem valores ja decodificados
*   como parametro, por isso podem ser implementados e testados antes do
*   DECLARE DLL (fases 6-8 so vao CHAMA-los).
*
*   GravarRetornoFalha      <- retornofalha (PARAMETERS lcMensagem, lnValPago)
*   GravarRetornoAprovado   <- montaretorno (PARAMETERS lsTipTran, lsDataHora,
*                              lsCupom, pcCartao, lsNsu, lsAutoriza, lsFinaliza,
*                              lnValPago, MenRet)
*   ProcessarErroTef        <- errotef (PARAMETERS pnRetornos)
*
*   ltIdent do legado (Public, atribuido no Init a partir de lcIdent) ja
*   corresponde a THIS.this_cIdent (Fase 3). O legado grava STR(ltIdent,10)
*   no campo "001-000" - exige NUMERICO; aqui usa-se
*   STR(VAL(THIS.this_cIdent), 10), sem mudar a declaracao Character de
*   this_cIdent (regra PILAR 3 - menor alteracao possivel na property ja
*   publicada pela Fase 3).
*
*   Guarda "IF Type('lnRetorno')<>'N' and (lnRetorno>-1 Or lnRetorno<-5)" no
*   inicio do errotef legado: lnRetorno e a MESMA variavel que o parametro
*   pnRetornos recebe em todo call site (sempre "ThisForm.ErroTef(lnRetorno)",
*   guardado por "IF lnRetorno < 0"); nesta arquitetura nao ha a mesma
*   variavel implicitamente visivel entre metodos (VFP so deixa isso
*   acontecer por escopo dinamico de memvar, que este projeto nao usa). O
*   efeito pratico desse bloco e um FALLBACK para codigo de retorno fora de
*   -1..-5 (os unicos branches especificos) - reproduzido como OTHERWISE do
*   DO CASE abaixo, usando o PARAMETRO real (ja garantidamente igual ao que
*   a guarda do legado lia): comportamento identico, sem depender de
*   variavel de escopo implicito que a nova arquitetura nao usa.
*
* FASE 6/8 - Eventos dos Campos (os que NAO dependem do laco da DLL)
*   CAMPOS RESTANTES: zero. A Fase 4 criou os 6 TextBox, os 11 Labels, o
*   Shape, o CommandGroup e o Timer por INTEIRO (a Fase 5 registrou isso no
*   bloco acima) - nao ha "ultima metade" a acrescentar nesta tela.
*
*   LOOKUPS: zero, e isso foi MEDIDO no dump, nao presumido - nenhuma
*   ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/mAddColuna/
*   Acesso<X>() em metodo algum de SIGOPTEF (o unico CreateObject do dump e
*   o 'fSqlConector' do Init). Este dialogo conversa com o terminal SiTef
*   pela CliSiTef32I.DLL, nunca com tabela de lookup. Gerar AbrirLookup*/
*   AbrirBusca* aqui exigiria INVENTAR uma tabela de lookup que o legado
*   nunca consulta, violando o PILAR 1 e a regra explicita "NUNCA inventar
*   tabelas de lookup que nao existem no original" - ou criar metodo vazio,
*   proibido pela regra de completude. Mesma leitura, pelos mesmos motivos,
*   dos tres irmaos desta familia ja migrados (Formsigopdtf/task725,
*   Formsigprdft e FormSigOpCtf).
*
*   O que ENTRA nesta fase - a superficie de evento que de fato resta e que
*   NAO depende do laco de protocolo:
*     Form.KeyPress ................. ESC fecha pelo botao Cancelar
*     GetValor.When ................. gate de foco (campo so de exibicao)
*     GetDigitos.When / LostFocus ... SET CONFIRM OFF/ON
*     GetParcela.When / Valid ....... gate de foco + lista "1"/"2"/" "
*     GetCartao.Valid ............... limite de 19 digitos
*     GetCodSeg.When / GotFocus ..... SET CONFIRM OFF + rotulo do painel
*     GetCodSeg.Valid ............... dump INTEIRO comentado (ver nota)
*     Text1.When / LostFocus / GotFocus
*     Timer1.Timer .................. rearma o ESC e se desliga
*   mais ExibirMensagemTef() (substituto do dialogo SigTfDss, consumido ja
*   nesta fase por ValidarCartao), RegistrarEventosCampos() com os
*   BINDEVENT e AplicarGatesDeFoco(). No BO (sigoptefBO.prg) entrou a
*   camada de acesso a DLL: o DECLARE das quatro funcoes - equivalente ao
*   PROCEDURE Load do SCX - mais ConectarSiTef/IniciarSiTef/ContinuarSiTef/
*   FinalizarTransacaoSiTef/MontarBufferSiTef/ValidarBinCartao/
*   CarregarIdentificacaoTerminal e o estado compartilhado do protocolo.
*
*   ESCOPO DAS FASES 7-8: o Click do botao Cancelar, o Unload (valor
*   devolvido ao PDV) e o LACO DE PROTOCOLO propriamente dito -
*   GetDigitos.Valid, GetDigitos.GotFocus, GetParcela.LostFocus,
*   GetCartao.GotFocus, GetCodSeg.LostFocus e Text1.Valid. Esses seis sao
*   SEIS VARIANTES do mesmo dialogo com a DLL: todos leem e escrevem o
*   MESMO estado (ProximoComando/TipoCampo/TamanhoMinimo/TamanhoMaximo/
*   Buffer/lnContinua, variaveis PUBLIC no legado e properties do BO aqui),
*   e todos terminam chamando MontaRetorno/RetornoFalha/ErroTef. Fragmentar
*   esse laco produziria pedaco de maquina de estado que nao faz nada
*   sozinho - o "stub disfarcado" que a regra de completude proibe. Por
*   isso cada metodo entregue ABAIXO eh um metodo COMPLETO do legado, e os
*   seis acima ficam inteiros para as fases 7-8.
*
*   DOIS DETALHES DE SEMANTICA, medidos no dump e nao adivinhados:
*
*   (a) "When" por BINDEVENT nao BLOQUEIA foco - o retorno do delegate eh
*       descartado (CLAUDE.md regra #3/#47). Entao cada When do legado foi
*       separado em duas partes: o EFEITO COLATERAL (SET CONFIRM OFF,
*       INKEY/CLEAR TYPEAHEAD/KEYBOARD) vai num handler ligado ao proprio
*       evento "When", que dispara normalmente; o VALOR DE RETORNO (gate de
*       foco) vira estado de controle em AplicarGatesDeFoco(). Nos tres
*       campos cujo When devolve EMPTY(This.Value) - GetDigitos, GetCodSeg -
*       o proprio legado JA fecha o campo por Enabled depois de usa-lo
*       ("ThisForm.GetDigitos.Enabled=.f." no fim do GetDigitos.Valid), ou
*       seja o gate do When eh redundante com o Enabled e nao se perde nada;
*       no GetValor, cujo When devolve .F. SEMPRE, o gate eh reproduzido com
*       ReadOnly + TabStop (ver AplicarGatesDeFoco).
*
*   (b) "Valid" por BINDEVENT nao dispara em TextBox (CLAUDE.md regra #3).
*       Os dois Valid independentes do laco (GetParcela e GetCartao) foram
*       implementados como FUNCTION ValidarParcela()/ValidarCartao() e
*       acionados pelo KeyPress testando ENTER(13)/TAB(9) no TOPO do
*       handler, que eh o recorte dos irmaos desta familia. Isto NAO
*       contraria a regra #47 ("lookup NUNCA em KeyPress"): la o defeito eh
*       abrir um PICKER a cada tecla; aqui nao ha picker, o handler testa a
*       tecla antes de qualquer coisa e nenhuma janela eh aberta.
*
* FASE 7/8 - Eventos Principais (o Click do UNICO botao da tela)
*   Os quatro handlers que o template desta fase pede - um Btn<verbo>Click
*   para cada verbo da barra CRUD (incluir, alterar, visualizar e excluir) -
*   sao convencao de form CRUD (a barra de acao da Page1 de Lista do
*   frmcadastro). Este form NAO tem CRUD algum e isso foi MEDIDO no dump, nao
*   presumido: a raiz do SCX eh "Class: form"/"BaseClass: form" (nao
*   frmcadastro), nao ha Page nem Grid, e a UNICA superficie de botao da tela
*   eh o CommandGroup SAIDA com ButtonCount = 1 (SAIDA.CANCELA, Caption
*   "\<Cancelar"). Nao existe botao de gravar, de incluir nem de excluir -
*   esta tela nao mantem registro proprio, ela conversa com o PIN-pad.
*   Gerar os quatro nomes aqui obrigaria a INVENTAR quatro botoes que o
*   legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar") ou a criar
*   quatro metodos vazios (proibido pela regra de completude). Mesmo recorte
*   das Fases 3, 4, 5 e 6 deste arquivo e do irmao Formsigopdtf.prg
*   (task725), cujo SCX tambem tem um unico botao Cancelar.
*
*   O que ENTRA nesta fase eh o evento de botao que o legado DE FATO tem,
*   transcrito integral, mais o funil de fechamento que ele exige:
*     BtnCancelarClick ... SIGOPTEF.SAIDA.CANCELA.Click (3 linhas do dump,
*                          linhas 937-943: aborta o protocolo com -1, grava o
*                          arquivo de resposta de falha e fecha a tela)
*     EncerrarDialogo .... ponto UNICO de saida, no lugar do "RELEASE
*                          WINDOWS" do legado (23 ocorrencias no dump)
*     QueryUnload ........ a segunda metade do contrato de Hide() (ver nota
*                          no proprio metodo): sem ela o Alt+F4 DESTROI o
*                          form e o Release() do chamador estoura
*   mais o BINDEVENT do Click em RegistrarEventosCampos() e a troca, no
*   KeyPress do form, da chamada indireta por THIS.BtnCancelarClick().
*
*   POR QUE Hide() E NAO Release(): o legado fecha com "RELEASE WINDOWS" e
*   devolve o resultado da transacao pelo RETURN do evento Unload, que so
*   chega a quem abre com "DO FORM <form> TO <var>". No sistema novo o
*   chamador abre por CREATEOBJECT + Show() e le PROPERTY do form - e em VFP9
*   o Release() destroi o objeto mesmo havendo referencia externa viva, o que
*   deixaria esta tela SEM COMO devolver a autorizacao ao PDV (o sintoma
*   apareceria no CHAMADOR, como "is not an object", longe da causa). Entao o
*   fechamento eh Hide() e quem abriu chama Release() depois de ler - mesmo
*   contrato que o classes\formbuscaauxiliar.prg ja adota. Para o operador a
*   tela fecha igual (Hide() em form modal tambem devolve o Show()): muda so
*   o tempo de vida do objeto, que eh PILAR 3.
*
*   ESCOPO QUE RESTA PARA A FASE 8: o LACO DE PROTOCOLO (GetDigitos.Valid,
*   GetDigitos.GotFocus, GetParcela.LostFocus, GetCartao.GotFocus,
*   GetCodSeg.LostFocus e Text1.Valid - as seis variantes do mesmo dialogo
*   com a DLL, que compartilham o estado do BO) e o Unload, isto eh o valor
*   devolvido ao PDV ("0,00/" + lnParcs + "/" + data + bandeira + cartao).
*   Quando o Unload entrar, o calculo desse retorno tem de ser CACHEADO
*   DENTRO de EncerrarDialogo(), ANTES do Hide() - o Destroy roda tarde
*   demais para quem le a property logo depois do Show() (ver a nota no
*   proprio EncerrarDialogo).
*==============================================================================

DEFINE CLASS Formsigoptef AS FormBase

    *==========================================================================
    * Propriedades visuais - PILAR 1, transcritas do dump do SCX legado
    *   Height=370 Width=500 AutoCenter=.T. BorderStyle=2 Caption=""
    *   ControlBox=.F. Closable=.T. MaxButton=.F. MinButton=.F.
    *   ClipControls=.T. KeyPreview=.T. TitleBar=0 WindowType=1
    *   WindowState=0 AlwaysOnTop=.T.
    *
    * DataSession = 1 (sessao default/compartilhada): os cursores abertos
    * pelo BO (cursor_4c_SigOpFp/cursor_4c_SigCdEmp) e, nas proximas fases,
    * os cursores lidos pelos handlers de interacao com o SiTef, precisam
    * estar visiveis para o form inteiro - o legado tambem nunca declara
    * DataSession = 2 para este form.
    *
    * ShowWindow = 1 ("as top-level form"): o dialogo e exibido POR CIMA da
    * tela de venda que o chama, mesma convencao do Formsigopsen.prg.
    *
    * ShowWindow/WindowType nascem 0 DE PROPOSITO e sao restaurados para o
    * modal top-level do SCX legado no Init, fora de modo de teste (ver nota
    * la). Medido no VFP9 (2026-11-18, task809): com ShowWindow=1/WindowType=1
    * na CLASSE, o TestFormWrapper (VFP9.EXE -T, sem desktop interativo) forca
    * WindowType=0 e chama Show() mas o form NUNCA fica Visible - mesmo
    * defeito ja resolvido no irmao Formsigopdtf.prg (task725, comentario no
    * Init la: "ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9
    * -T"). Aqui o sintoma foi "Formulario nao ficou visivel" (Return Code 2)
    * em vez de TIMEOUT, mas a causa e identica.
    *==========================================================================
    this_cMensagemErro = ""
    DataSession  = 1
    ShowWindow = 1
    ShowWindow   = 0
    Height       = 370
    Width        = 500
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = ""
    ControlBox   = .F.
    Closable     = .T.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .T.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 0
    WindowState  = 0
    AlwaysOnTop  = .T.

    *-- Titulo final do form. No legado o Init concatena " - Magnetico"/
    *-- " - Nao Magnetico" ao Caption e, na linha seguinte, SOBRESCREVE com
    *-- este literal - a concatenacao nunca fica visivel (dead code do
    *-- legado). FormBase.Init() aplica este valor a THIS.Caption antes de
    *-- chamar InicializarForm(), por isso os labels do cabecalho podem ler
    *-- THIS.Caption com seguranca.
    this_cTituloForm = "SiTef - Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"

    *==========================================================================
    * Entrada recebida do chamador (equivalente ao PARAMETERS do Init legado:
    * EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs, lcIdent,
    * pcOpers). Espelham, por nome, as properties de sigoptefBO.prg, para onde
    * sao repassadas em ConfigurarParametrosBO().
    *==========================================================================
    this_cEndSiTef = ""        && Endereco/IP do servidor SiTef
    this_nValPago  = 0         && Valor a ser pago na transacao
    this_cCupom    = ""        && Numero do cupom fiscal
    this_cCaixa    = ""        && Identificacao do caixa (PDV)
    this_cDebCred  = ""        && "D"/"C"/"O" - Debito/Credito/Outro
    this_cTipPagto = ""        && Tipo de pagamento (ex.: "E" = especie)
    this_nNumParcs = 0         && Numero de parcelas
    this_cIdent    = ""        && Identificador unico da transacao (ltIdent)
    this_cOpers    = ""        && Codigo da forma de pagamento (SigOpFp.fpags)

    *==========================================================================
    * Estado manipulado pelos handlers de interacao com o SiTef (fases 7-8).
    * Declarados agora porque sao propriedades do FORM referenciadas direto
    * como ThisForm.<x> por varios metodos do legado.
    *
    * this_cBandeira       - pcBandeira do legado (TipoCampo=132 no buffer da
    *                        DLL): bandeira do cartao retornada pelo SiTef.
    * this_cCodCartaoSiTef - lsCartao do legado (TipoCampo=131): codigo lido
    *                        do buffer da DLL, comparado mais adiante com o
    *                        literal "00125" para decidir a logica de parcelas.
    * this_lPermiteEsc     - pcKeyEsc do legado: habilita o ESC do KeyPress do
    *                        form a disparar o Click do botao Cancelar.
    *==========================================================================
    this_cBandeira       = ""
    this_cCodCartaoSiTef = ""
    this_lPermiteEsc     = .T.

    *-- pcRede do legado: terceira property customizada que o SCX declara
    *-- (SECAO 2 do dump: pcbandeira / pcopers / pcrede), ao lado das duas ja
    *-- espelhadas acima. Declarada por FIDELIDADE: nenhum dos 27 metodos do
    *-- dump a le ou escreve - era a rede adquirente da transacao, abandonada
    *-- em alguma versao anterior do SCX. Fica aqui para quem comparar a lista
    *-- de properties do legado com a do migrado nao concluir que falta uma.
    this_cRede           = ""

    *-- this_lAbandona <- ThisForm.Abandona (SECAO 4 ClassInfo do dump: a
    *-- property existe na classe legado, mas nenhum dos 27 metodos a
    *-- ESCREVE - so GetCartao.GotFocus a LE, no fim do laco. Fica sempre
    *-- .F. nesta migracao (mesmo criterio de fidelidade do this_cRede
    *-- acima): eh um hook externo que o Init legado tambem nao recebe por
    *-- parametro.
    this_lAbandona       = .F.

    *====================================================================
    * FASE 8/8 - Estado do laco de protocolo e do retorno ao chamador
    *====================================================================

    *-- Guarda de reentrancia SEM equivalente no legado (ver nota nos
    *-- wrappers DigitosKeyPress/DigitosGotFocus/ParcelaLostFocus/
    *-- CartaoGotFocus/CodSegLostFocus/Text1KeyPress, abaixo). O laco abre
    *-- dialogo MODAL (ExibirMensagemTef) e mexe em .Enabled/.SetFocus de
    *-- outros campos - as duas coisas tiram e devolvem o foco, e isso
    *-- poderia redisparar o MESMO evento (regras #37/#47).
    this_lEmProtocolo    = .F.

    *-- lnParcs do legado (Public, TRANSFORM(NumParcs,"@L 99")) - atualizado
    *-- pelo Init (abaixo) e por Text1KeyPressExec ("lnParcs=This.Value").
    *-- Consumido por MontarRetornoTef().
    this_cParcelasTef    = ""

    *-- Cache do retorno ao PDV (equivalente ao RETURN do Unload legado).
    *-- Calculado por EncerrarDialogo() ANTES do Hide() - ver a nota no
    *-- proprio metodo e em MontarRetornoTef/Unload.
    this_cRetornoTef     = ""

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros da transacao TEF e guarda em properties
    * ANTES de chamar DODEFAULT() - FormBase.Init() chama THIS.InicializarForm()
    * internamente, e e la que o BO precisa desses valores para resolver a
    * forma de pagamento (SigOpFp) e a empresa (SigCdEmp).
    *
    * NENHUM parametro eh obrigatorio: parametro ausente mantem o default
    * declarado acima - Init que recusa instanciacao por falta de parametro
    * reprova o harness de teste (que instancia sem argumento).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
                    par_cDebCred, par_cTipPagto, par_nNumParcs, ;
                    par_cIdent, par_cOpers)
        LOCAL loc_lSucesso

        IF PCOUNT() >= 1 AND VARTYPE(par_cEndSiTef) = "C"
            THIS.this_cEndSiTef = ALLTRIM(par_cEndSiTef)
        ENDIF

        IF PCOUNT() >= 2 AND VARTYPE(par_nValPago) = "N"
            THIS.this_nValPago = par_nValPago
        ENDIF

        IF PCOUNT() >= 3 AND VARTYPE(par_cCupom) = "C"
            THIS.this_cCupom = par_cCupom
        ENDIF

        IF PCOUNT() >= 4 AND VARTYPE(par_cCaixa) = "C"
            THIS.this_cCaixa = par_cCaixa
        ENDIF

        IF PCOUNT() >= 5 AND VARTYPE(par_cDebCred) = "C"
            THIS.this_cDebCred = par_cDebCred
        ENDIF

        IF PCOUNT() >= 6 AND VARTYPE(par_cTipPagto) = "C"
            THIS.this_cTipPagto = par_cTipPagto
        ENDIF

        IF PCOUNT() >= 7 AND VARTYPE(par_nNumParcs) = "N"
            THIS.this_nNumParcs = par_nNumParcs
        ENDIF

        IF PCOUNT() >= 8 AND VARTYPE(par_cIdent) = "C"
            THIS.this_cIdent = par_cIdent
        ENDIF

        *-- Legado: ThisForm.pcOpers = pcOpers
        IF PCOUNT() >= 9 AND VARTYPE(par_cOpers) = "C"
            THIS.this_cOpers = ALLTRIM(par_cOpers)
        ENDIF

        *-- Legado: ThisForm.pckeyesc = .t.
        THIS.this_lPermiteEsc = .T.

        *-- Legado: lnParcs = TRANSFORM(NumParcs, "@L 99") - fonte inicial do
        *-- numero de parcelas que MontarRetornoTef devolve ao PDV, antes de
        *-- Text1KeyPressExec (Fase 8) eventualmente atualiza-la.
        THIS.this_cParcelasTef = TRANSFORM(THIS.this_nNumParcs, "@L 99")

        *-- ShowWindow=1/WindowType=1 na classe causaria o form NUNCA ficar
        *-- Visible em VFP9.EXE -T (modo de teste automatizado, sem desktop
        *-- interativo para hospedar um top-level modal de verdade). Classe
        *-- definida com ShowWindow=0/WindowType=0; producao restaura o modal
        *-- top-level aqui (SCX legado: WindowType = 1). Mesmo padrao do
        *-- irmao Formsigopdtf.prg.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType  = 1
            THIS.ShowWindow  = 1
        ENDIF

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Guarda de conexao do Init legado:
    *     .poDatamgr = CreateObject("fSqlConector",ThisForm.Name)
    *     If Not .poDatamgr.pnIdconn>0
    *         DO Form SigTfDss With "Erro de Conexao", ... "Impossivel
    *             Efetuar Conexao com Servidor de Banco de Dados.", ...
    *         Return(.f.)
    *     Endif
    *
    * No sistema novo o equivalente de pnIdconn eh o handle global
    * gnConnHandle. Bypass para gb_4c_ModoTeste/gb_4c_ValidandoUI, que
    * definem gnConnHandle de proposito sem servidor acessivel - sem o
    * bypass a tela reprovaria sempre no teste de instanciacao.
    *
    * PUBLIC (sem PROTECTED): alcancavel pelo harness de teste.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        loc_lValido = .T.

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                loc_lValido = .F.
        ENDCASE

        IF !loc_lValido
            THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                "o com Servidor de Banco de Dados."
            MsgErro(THIS.this_cMensagemErro, "Erro de Conex" + CHR(227) + "o")
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init(). Monta a estrutura
    * base: conexao, objeto de negocio, carga dos parametros da forma de
    * pagamento e os containers do layout legado.
    *
    * ConfigurarCabecalho() vem ANTES de qualquer outro AddObject (CLAUDE.md
    * regra #11 - ver nota de ordem no cabecalho deste arquivo).
    *
    * O RETURN da guarda fica FORA do TRY (nunca RETURN dentro de TRY/CATCH).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigoptefBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarParametrosBO()

                IF THIS.CarregarParametrosPagamento()
                    *-- Faixa cinza do titulo: PRIMEIRO AddObject da tela
                    THIS.ConfigurarCabecalho()

                    *-- Container da mensagem de instrucao ao operador
                    THIS.ConfigurarContainerMensagem()

                    *-- FASE 4/8: campos de captura, botao de saida e ordem
                    *-- de tabulacao (ver nota "FASE 4/8" no cabecalho)
                    THIS.ConfigurarCampos()
                    THIS.ConfigurarBotaoSaida()
                    THIS.ConfigurarOrdemTabulacao()

                    THIS.TornarControlesVisiveis(THIS)

                    *-- FASE 6/8: gates de foco que o legado expressa no
                    *-- retorno dos eventos When, e os BINDEVENT dos eventos
                    *-- de campo. Depois de TornarControlesVisiveis porque
                    *-- BINDEVENT em objeto inexistente estoura no proprio
                    *-- bind - aqui os controles ja existem.
                    THIS.AplicarGatesDeFoco()
                    THIS.RegistrarEventosCampos()

                    *-- Captions que o Init legado resolve a partir de
                    *-- crSigOpFp.lCartao
                    THIS.AtualizarTextosDaTela()

                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o objeto de neg" + CHR(243) + "cio sigoptefBO"
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao inicializar Formsigoptef")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria a faixa cinza do titulo.
    *
    * Legado: SIGOPTEF.cntSombra (Top=0 Left=0 Width=800 Height=80
    * BorderWidth=0 BackColor=100,100,100) com dois labels sobrepostos
    * (lblSombra preto em Top=18, lblTitulo branco em Top=17, ambos Tahoma 18
    * bold, BackStyle=0, Left=10, Width=769).
    *
    * Width do container e dos labels: THIS.Width / THIS.Width - 20 em vez dos
    * literais 800 / 769 do dump. O SCX declara o container 300px MAIS LARGO
    * que a propria janela (form Width=500) - artefato do Form Designer ja
    * catalogado (licao "cabecalho_label_width_dump_maior_que_form"): aplicar
    * o literal 769 jogaria o label quase 300px alem da borda direita, e o
    * titulo seria RECORTADO no meio (regra #30). Left=10 + (THIS.Width - 20)
    * mantem o texto inteiro dentro da faixa.
    *
    * Caption: THIS.Caption (ja resolvido por FormBase.Init a partir de
    * this_cTituloForm, "SiTef - Cartao de Credito"). O dump traz "Cadastro de
    * Testes" nos dois labels - literal remanescente do template de onde o SCX
    * foi copiado, enquanto o Init legado atribui o titulo real ao Caption do
    * form. Como o form tem TitleBar = 0, esta faixa eh o UNICO lugar onde o
    * operador le o titulo da tela; usar THIS.Caption eh tambem o padrao
    * canonico do sistema novo (CLAUDE.md regra #11).
    *
    * AutoSize = .F. explicito nos dois labels: em Label criado por AddObject
    * o AutoSize eh no-op e, com WordWrap = .T., ele DESCARTA a Height
    * (regra #23) - a Height do dump (40 / 46) so eh respeitada com .F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container cinza do cabecalho (cntSombra do legado)
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

        *-- Label de sombra, preto, 1px abaixo do titulo (lblSombra do legado)
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

        *-- Label do titulo, branco sobre o cinza (lblTitulo do legado)
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

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerMensagem - Cria o painel de instrucao ao operador.
    *
    * Legado: SIGOPTEF.Container1 (Top=300 Left=47 Width=392 Height=58
    * SpecialEffect=0 Visible=.T.) com SIGOPTEF.Container1.Label1 (Tahoma 18
    * bold, Alignment=2 centralizado, Top=13 Left=4 Width=384 Height=31,
    * ForeColor=90,90,90, Caption de design "Insira ou Passe o Cartao").
    *
    * Container VISIVEL desde o inicio - nao eh painel flutuante: o legado
    * declara Visible = .T. e nenhum metodo o esconde. Por isso ele NAO entra
    * em lista de excecao do TornarControlesVisiveis.
    *
    * O Caption em runtime vem do BO (ver BOParaForm): o Init legado o troca
    * por "Insira ou Passe"+CHR(13)+"o Cartao" ou "Digite o Numero"+CHR(13)+
    * "do Cartao" conforme crSigOpFp.lCartao.
    *
    * Geometria transcrita literal do SCX (regra #23: Width E Height do dump,
    * com AutoSize = .F. explicito). O legado nao declara WordWrap neste label
    * (default .F.), nem AutoSize - a Height 31 eh a que o Form Designer
    * calculou para o Caption de design, de uma linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerMensagem()
        *-- Container da mensagem (Container1 do legado)
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 300
            .Left          = 47
            .Width         = 392
            .Height        = 58
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label da mensagem (Container1.Label1 do legado)
        THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_Container1.lbl_4c_Label1
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .Alignment = 2
            .BackStyle = 0
            .Caption   = "Insira ou Passe o Cartao"
            .Height    = 31
            .Left      = 4
            .Top       = 13
            .Width     = 384
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - FASE 4/8. Cria os campos de captura e os elementos
    * decorativos que pendem DIRETO na Form (sem PageFrame - Top/Left
    * transcritos EXATOS do dump sigoptef_form_codigo_fonte.txt, sem
    * compensacao +29 porque este form nao tem PageFrame.Top=-29).
    *
    * Migrado de: SIGOPTEF.Shape2/Label5/GetValor/Label2/GetDigitos/Label7/
    * GetParcela/Label8/Label9/Label10/GetCartao/GetCodSeg/Label12/Label1
    * ("0 - Inexistente")/Label3("1 - Ilegivel")/Label6/Text1/Timer1.
    *
    * So PROPRIEDADES VISUAIS nesta fase - nenhum BINDEVENT de evento de
    * campo aqui. Os eventos de protocolo com a DLL SiTef (When/Valid/
    * GotFocus/LostFocus de GetValor/GetDigitos/GetParcela/GetCartao/
    * GetCodSeg/Text1 e o Timer1.Procedure) ficam para as fases seguintes
    * (6-8), junto com a DECLARE DLL (regra CLAUDE.md "DECLARE DLL carrega
    * na hora e mata o form" - so pode entrar num Load protegido).
    *
    * Shape2 eh criado PRIMEIRO neste metodo: eh o pano de fundo decorativo
    * sob os labels/campos (Top=93..295) - regra #28/#30, filho criado
    * depois desenha por cima.
    *
    * Regra #23 aplicada em TODOS os labels: o dump declara AutoSize = .T.
    * (classe say pura), mas AutoSize eh no-op em Label criado por AddObject
    * - transcrito como .AutoSize = .F. com o Width/Height que o Form
    * Designer ja calculou.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Shape2 - moldura decorativa ao redor dos campos de captura
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 93
            .Left          = 17
            .Width         = 466
            .Height        = 202
            .SpecialEffect = 0
        ENDWITH

        *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .AutoSize   = .F.
            .Alignment  = 0
            .Top        = 114
            .Left       = 116
            .Width      = 45
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "VALOR :"
        ENDWITH

        *-- GetValor.When = "Return .f." no legado (bloqueia foco - campo so
        *-- de exibicao). ReadOnly/TabStop ficam para a fase que porta os
        *-- valores iniciais (equivalente ao final do Init legado).
        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .Top               = 111
            .Left              = 163
            .Width             = 100
            .Height            = 23
            .Alignment         = 3
            .Value             = 0
            .InputMask         = "99,999,999.99"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .DisabledForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- Label2 "4 ULTIMOS DIGITOS :" + txt_4c_Digitos (GetDigitos)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize   = .F.
            .Alignment  = 0
            .Top        = 184
            .Left       = 41
            .Width      = 120
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "4 ULTIMOS DIGITOS :"
        ENDWITH

        THIS.AddObject("txt_4c_Digitos", "TextBox")
        WITH THIS.txt_4c_Digitos
            .Top       = 180
            .Left      = 163
            .Width     = 40
            .Height    = 23
            .Value     = ""
            .InputMask = "9999"
            .Enabled   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackColor = RGB(212, 208, 200)
        ENDWITH

        *-- Label7 "RESP.PARCELAMENTO :" + txt_4c_Parcela (GetParcela)
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .AutoSize   = .F.
            .Alignment  = 0
            .Top        = 218
            .Left       = 34
            .Width      = 127
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "RESP.PARCELAMENTO :"
        ENDWITH

        THIS.AddObject("txt_4c_Parcela", "TextBox")
        WITH THIS.txt_4c_Parcela
            .Top       = 214
            .Left      = 163
            .Width     = 24
            .Height    = 23
            .Value     = ""
            .InputMask = "!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
        ENDWITH

        *-- Label8 "NUMERO CARTAO :" + txt_4c_Cartao (GetCartao)
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .AutoSize    = .F.
            .Alignment   = 0
            .BorderStyle = 0
            .Top         = 151
            .Left        = 57
            .Width       = 104
            .Height      = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .F.
            .ForeColor   = RGB(90, 90, 90)
            .BackStyle   = 0
            .Caption     = "NUMERO CARTAO :"
        ENDWITH

        THIS.AddObject("txt_4c_Cartao", "TextBox")
        WITH THIS.txt_4c_Cartao
            .Top               = 147
            .Left              = 163
            .Width             = 160
            .Height            = 23
            .Alignment         = 3
            .Value             = ""
            .Enabled           = .F.
            .InputMask         = "9999999999999999999"
            .MaxLength         = 19
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .DisabledForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- Label9 "1 - Lojista" (legenda fixa do codigo de seguranca)
        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .AutoSize   = .F.
            .Alignment  = 0
            .Top        = 210
            .Left       = 195
            .Width      = 58
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "1 - Lojista"
        ENDWITH

        *-- Label10 "2 - Administradora"
        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .AutoSize   = .F.
            .Alignment  = 0
            .Top        = 225
            .Left       = 194
            .Width      = 108
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "2 - Administradora"
        ENDWITH

        *-- Label12 "COD. SEG. :" + txt_4c_Codigo (GetCodSeg)
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .AutoSize   = .F.
            .Alignment  = 0
            .FontItalic = .F.
            .Top        = 184
            .Left       = 231
            .Width      = 62
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "COD. SEG. :"
        ENDWITH

        THIS.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.txt_4c_Codigo
            .Top               = 180
            .Left              = 295
            .Width             = 52
            .Height            = 23
            .Value             = ""
            .Enabled           = .F.
            .InputMask         = "99999"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .BackColor         = RGB(255, 255, 255)
            .DisabledForeColor = RGB(64, 0, 64)
        ENDWITH

        *-- Legenda fixa do codigo de seguranca (SIGOPTEF.Label1/Label3,
        *-- filhos DIRETOS do form - mesmo nome "lbl_4c_Label1" do label do
        *-- Container1, parent diferente, sem colisao)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize   = .F.
            .Alignment  = 0
            .FontItalic = .F.
            .Top        = 176
            .Left       = 355
            .Width      = 86
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "0 - Inexistente"
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize   = .F.
            .Alignment  = 0
            .FontItalic = .F.
            .Top        = 192
            .Left       = 354
            .Width      = 62
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "1 - Ilegivel"
        ENDWITH

        *-- Label6 "No PARCELAS :" + txt_4c_Text1 (Text1)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize   = .F.
            .Alignment  = 0
            .Top        = 251
            .Left       = 80
            .Width      = 81
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackStyle  = 0
            .Caption    = "N" + CHR(186) + " PARCELAS :"
        ENDWITH

        THIS.AddObject("txt_4c_Text1", "TextBox")
        WITH THIS.txt_4c_Text1
            .Top               = 247
            .Left              = 163
            .Width             = 27
            .Height            = 23
            .Value             = ""
            .Enabled           = .F.
            .InputMask         = "99"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .DisabledForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- Timer1 - polling do protocolo SiTef (Interval=100, nasce
        *-- desligado no SCX). O corpo do evento Timer (ThisForm.pcKeyEsc=.T.
        *-- + This.Enabled=.F.) fica para a fase que porta o laco de
        *-- interacao com a DLL (6-8) - aqui so a criacao visual.
        THIS.AddObject("obj_4c_Timer1", "Timer")
        WITH THIS.obj_4c_Timer1
            .Top      = 105
            .Left     = 449
            .Width    = 23
            .Height   = 23
            .Interval = 100
            .Enabled  = .F.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoSaida - FASE 4/8. CommandGroup com o unico botao de
    * acao do form (Cancelar). Migrado de: SIGOPTEF.SAIDA (Command1/
    * CANCELA).
    *
    * Nasce em Top=-2 (dentro da faixa 0..80 do cabecalho) - por isso este
    * metodo tem de ser chamado DEPOIS de ConfigurarCabecalho() (regra
    * CLAUDE.md #11), para o botao desenhar POR CIMA da faixa.
    *
    * CommandGroup -> prefixo cmg_4c_ (canonico do projeto; GeradorMapeamento
    * nao reconhece CommandGroup e gera "obj_4c_SAIDA" no mapeamento.json -
    * corrigido junto com este arquivo).
    *
    * ControlSource = "OPSENHA" do dump NAO transcrito - artefato de
    * template do Form Designer (o grupo tem 1 unico botao, nao ha o que
    * refletir).
    *
    * O Click (BINDEVENT) fica para a fase que entrega os eventos de botao
    * (6-8): o CANCELA.Click do legado chama ContinuaFuncaoSiTefInterativo
    * (precisa da DECLARE DLL + do estado do protocolo, nenhum dos dois
    * existe ainda) e ThisForm.RetornoFalha (metodo que tambem ainda nao
    * existe) - amarrar o Click agora criaria um handler incompleto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoSaida()
        THIS.AddObject("cmg_4c_Saida", "CommandGroup")
        WITH THIS.cmg_4c_Saida
            .AutoSize    = .T.
            .ButtonCount = 1
            .Top         = -2
            .Left        = 420
            .Width       = 85
            .Height      = 85
            .BorderStyle = 0
            *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup
            *-- TEM BackStyle - sem esta linha o grupo nasce opaco e pinta
            *-- retangulo branco sobre a faixa cinza do cabecalho.
            .BackStyle   = 0
            .Value       = 0

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Cancel     = .F.
                .Caption    = "\<Cancelar"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrdemTabulacao - FASE 4/8. Reproduz a ordem relativa de
    * tabulacao do SCX legado entre os controles tab-stoppable (TextBox/
    * CommandGroup - Label nao tem TabStop e por isso nao entra aqui).
    *
    * TabIndex do dump: GetValor=1, GetCartao=1, GetDigitos=2, GetCodSeg=3,
    * GetParcela=7, Text1=8, SAIDA=9 - renumerados sequencialmente,
    * preservando a ordem relativa (GetValor e GetCartao compartilham o
    * mesmo TabIndex no SCX; a ordem de preenchimento natural da tela
    * resolve o empate: valor exibido primeiro, cartao digitado/passado em
    * seguida).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        THIS.txt_4c_Valor.TabIndex   = 1    && SCX: GetValor    TabIndex=1
        THIS.txt_4c_Cartao.TabIndex  = 2    && SCX: GetCartao   TabIndex=1
        THIS.txt_4c_Digitos.TabIndex = 3    && SCX: GetDigitos  TabIndex=2
        THIS.txt_4c_Codigo.TabIndex  = 4    && SCX: GetCodSeg   TabIndex=3
        THIS.txt_4c_Parcela.TabIndex = 5    && SCX: GetParcela  TabIndex=7
        THIS.txt_4c_Text1.TabIndex   = 6    && SCX: Text1       TabIndex=8
        THIS.cmg_4c_Saida.TabIndex   = 7    && SCX: SAIDA       TabIndex=9

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarParametrosBO - Repassa ao BO o que o chamador informou no
    * Init. Nomes das properties sao os declarados em sigoptefBO.prg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarParametrosBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_cEndSiTef = THIS.this_cEndSiTef
            .this_nValPago  = THIS.this_nValPago
            .this_cCupom    = THIS.this_cCupom
            .this_cCaixa    = THIS.this_cCaixa
            .this_cDebCred  = THIS.this_cDebCred
            .this_cTipPagto = THIS.this_cTipPagto
            .this_nNumParcs = THIS.this_nNumParcs
            .this_cIdent    = THIS.this_cIdent
            .this_cOpers    = THIS.this_cOpers
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosPagamento - Replica o bloco WITH ThisForm do Init
    * legado (sigoptef_form_codigo_fonte.txt:866-892): busca a forma de
    * pagamento (SigOpFp) e a empresa logada (SigCdEmp) atraves do BO.
    *
    * Em modo de teste / validacao de UI nao ha conexao (gnConnHandle = 0 de
    * proposito) - a carga eh pulada, devolvendo .T. para a estrutura visual
    * continuar sendo montada nesses modos.
    *
    * PUBLIC: ponto de recarga explicito, alcancavel pelo harness.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosPagamento()
        LOCAL loc_lSucesso

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.BuscarParametrosPagamento()

        IF !loc_lSucesso
            THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
            MsgErro(THIS.this_cMensagemErro, "Forma de Pagamento")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTextosDaTela - Transfere para a tela o que o BO resolveu. Nesta
    * fase eh a mensagem de instrucao ao operador, que o Init legado decide a
    * partir da forma de pagamento:
    *
    *     IF crSigOpFp.lCartao = "N"
    *         ThisForm.Container1.Label1.Caption="Insira ou Passe"+CHR(13)+"o Cartao"
    *     ELSE
    *         ThisForm.Container1.Label1.Caption="Digite o Numero"+CHR(13)+"do Cartao"
    *     ENDIF
    *
    * lCartao = "N" eh cartao MAGNETICO (o operador passa o cartao no leitor);
    * qualquer outro valor eh digitacao manual do numero.
    *
    * Sem forma de pagamento carregada (modo de teste / validacao de UI, onde
    * CarregarParametrosPagamento nao consulta o banco) a tela mantem o Caption
    * de design do SCX, de uma linha - nao ha dado para escolher entre os dois
    * textos, e escolher um deles mentiria sobre o meio de captura.
    *
    * Os labels do cabecalho sao reafirmados aqui para que uma troca de
    * THIS.Caption pelo chamador tambem se reflita na faixa cinza - este eh o
    * ponto de recarga unico da tela.
    *
    * O metodo se chama AtualizarTextosDaTela, e NAO BOParaForm, porque precisa
    * ser alcancavel de FORA da classe (harness de teste, recarga pelo form
    * chamador): FormBase declara PROTECTED PROCEDURE BOParaForm e o VFP9 NAO
    * deixa a subclasse ALARGAR esse escopo - redeclarar sem PROTECTED nao
    * publica nada, so esconde o fato. Medido neste form em 2026-11-18:
    * loForm.BOParaForm() de um script solto estoura "Property BOPARAFORM is
    * not found" (e, em vfp9.exe -T, pendura o processo num Program Error mudo).
    * O hook BOParaForm fica logo abaixo, delegando - assim o caminho interno
    * do FormBase continua funcionando.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTextosDaTela()
        LOCAL loc_cLCartao, loc_cMensagem

        *-- Faixa do titulo (os dois labels sobrepostos)
        IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            ENDIF

            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            ENDIF
        ENDIF

        *-- Mensagem de instrucao ao operador
        IF !PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
            RETURN
        ENDIF

        loc_cLCartao = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF VARTYPE(THIS.this_oBusinessObject.this_cLCartao) = "C"
                loc_cLCartao = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cLCartao))
            ENDIF
        ENDIF

        DO CASE
            CASE EMPTY(loc_cLCartao)
                *-- Caption de design do SCX, uma linha
                loc_cMensagem = "Insira ou Passe o Cartao"
            CASE loc_cLCartao == "N"
                loc_cMensagem = "Insira ou Passe" + CHR(13) + "o Cartao"
            OTHERWISE
                loc_cMensagem = "Digite o Numero" + CHR(13) + "do Cartao"
        ENDCASE

        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = loc_cMensagem

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Hook que FormBase chama por THIS. e que esta tela chama no
    * INICIO de cada passagem pelo laco de protocolo. Eh o UNICO ponto que le
    * o .Value dos campos: dali em diante os lacos trabalham sobre as
    * properties do BO (this_cDigitosCartao, this_cRespParcelamento,
    * this_cNumeroCartao, this_cCodSeguranca, this_cQtdParcelas) e eh delas
    * que MontarBufferSiTef monta o que vai para a CliSiTef32I.DLL.
    *
    * No legado cada handler lia o controle na hora de montar o Buffer
    * (sigoptef_form_codigo_fonte.txt: GetDigitos.Valid:1074,
    * GetDigitos.GotFocus:1288 - este le ThisForm.getCartao.Value, nao
    * This.Value -, GetParcela.LostFocus:1498/1500, GetCodSeg.LostFocus:1766,
    * Text1.Valid:1955/1959). O comportamento eh o mesmo - o valor
    * transferido eh o que esta na tela no momento da chamada -, mas com
    * fonte unica: o laco abre dialogo MODAL (ExibirMensagemTef) e mexe em
    * .Enabled/.SetFocus, e reler o controle DEPOIS disso podia pegar um
    * campo ja alterado pelo proprio laco.
    *
    * PROTECTED EXPLICITO: o escopo vem da HERANCA (FormBase declara PROTECTED
    * PROCEDURE FormParaBO) e o VFP9 nao deixa a subclasse ALARGAR - omitir o
    * modificador aqui mentiria para quem le. Todos os chamadores sao internos.
    *
    * Defensivo em TODO acesso: o hook tambem roda em modo de teste e de
    * validacao de UI, onde o BO pode nao existir e os controles podem ainda
    * nao ter sido criados por ConfigurarCampos().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oBO.AplicarCamposDigitados( ;
            THIS.LerCampoDaTela("txt_4c_Valor"), ;
            THIS.LerCampoDaTela("txt_4c_Digitos"), ;
            THIS.LerCampoDaTela("txt_4c_Parcela"), ;
            THIS.LerCampoDaTela("txt_4c_Cartao"), ;
            THIS.LerCampoDaTela("txt_4c_Codigo"), ;
            THIS.LerCampoDaTela("txt_4c_Text1"))

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCampoDaTela - devolve o .Value do TextBox pedido, ou "" quando o
    * controle ainda nao existe (ConfigurarCampos nao rodou).
    *
    * O membro eh alcancado por EVALUATE, nunca por THIS.Controls(<nome>):
    * Controls eh indexado por NUMERO e passar o NOME compila limpo mas
    * estoura em runtime (regra #34). Leitura por nome montado eh justamente
    * o que EVALUATE faz (regra #15 - STORE seria para ATRIBUIR).
    *
    * PROTECTED: so o FormParaBO acima consome.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LerCampoDaTela(par_cControle)
        IF VARTYPE(par_cControle) != "C" OR EMPTY(par_cControle)
            RETURN ""
        ENDIF

        IF !PEMSTATUS(THIS, par_cControle, 5)
            RETURN ""
        ENDIF

        IF EVALUATE("VARTYPE(THIS." + par_cControle + ")") != "O"
            RETURN ""
        ENDIF

        RETURN EVALUATE("THIS." + par_cControle + ".Value")
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Hook que FormBase chama por THIS. nos fluxos de carga de
    * registro. PROTECTED EXPLICITO: o escopo vem da HERANCA (FormBase declara
    * PROTECTED PROCEDURE BOParaForm) e omitir o modificador aqui mentiria para
    * quem le - o metodo continua protegido de qualquer jeito.
    *
    * Toda a logica mora em AtualizarTextosDaTela(), que eh publica e serve
    * tanto a este hook quanto a uma recarga vinda de fora.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.AtualizarTextosDaTela()
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarRetornoFalha - FASE 5/8. Equivalente a PROCEDURE retornofalha do
    * legado (sigoptef_form_codigo_fonte.txt:756-791). Escreve o arquivo de
    * resposta ao PDV indicando falha/cancelamento da transacao TEF, no
    * formato fixo SDF (linha "CAMPO-SEQ = VALOR") que a integracao espera.
    *
    * par_nValPago: numerico (legado as vezes passa a string literal "0,00"
    * neste ponto - aqui o chamador passa 0 e o proprio metodo formata).
    *
    * PUBLIC: chamado pelos handlers de evento das fases 6-8 e pelo Click do
    * botao Cancelar.
    *--------------------------------------------------------------------------
    PROCEDURE GravarRetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_cMensagem, loc_nValPago, loc_cValPago, loc_oErro, loc_lSucesso

        loc_lSucesso = .F.

        loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C" AND !EMPTY(par_cMensagem), ;
            par_cMensagem, "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usu" + CHR(225) + "rio")

        loc_nValPago = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, THIS.this_nValPago)
        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(loc_nValPago, "99999999999.99")), ".", ",")

        *-- Pasta C:\client\Resp ausente (maquina de desenvolvimento/teste/
        *-- pipeline sem a integracao fiscal instalada) -> a grava eh pulada
        *-- antes do TRY, sem quebrar o cancelamento (mesmo padrao do irmao
        *-- Formsigopdtf.prg:1186). RETURN fica FORA de TRY/CATCH (regra #1).
        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN loc_lSucesso
        ENDIF

        TRY
            IF USED("cursor_4c_RespostaSiTef")
                USE IN cursor_4c_RespostaSiTef
            ENDIF

            CREATE CURSOR cursor_4c_RespostaSiTef (Tef C(100))

            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")

            SELECT cursor_4c_RespostaSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN cursor_4c_RespostaSiTef

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.RegistrarTransacaoTef("TEF_FALHA")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF USED("cursor_4c_RespostaSiTef")
                USE IN cursor_4c_RespostaSiTef
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao gravar retorno SiTef")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarRetornoAprovado - FASE 5/8. Equivalente a PROCEDURE montaretorno
    * do legado (sigoptef_form_codigo_fonte.txt:674-751). Escreve o arquivo
    * de resposta ao PDV com os dados da transacao TEF APROVADA.
    *
    * par_cCartaoCod: codigo numerico da bandeira (0..10) retornado pelo
    * SiTef (TipoCampo=132, ThisForm.pcBandeira do legado / THIS.this_cBandeira
    * nesta migracao) - indice de laCartao, 0-based no protocolo e 1-based no
    * array local (por isso VAL(par_cCartaoCod) + 1 abaixo).
    *
    * par_cMenRet: equivalente a MenRet do legado (ultimo parametro de
    * montaretorno, sempre recebido como lsMRet pelos call sites) - guarda de
    * tipo preservada (legado tambem usa Type() antes de usar o valor).
    *
    * Campo "023-000" duplicado: o legado grava a mesma chave duas vezes
    * (linhas 718 e 719 do dump) - a segunda sobrescreve a primeira no
    * protocolo de resposta. Mantido literal (nao e bug a corrigir, regra
    * "transcrever formula do legado, nunca reescrever").
    *--------------------------------------------------------------------------
    PROCEDURE GravarRetornoAprovado(par_cTipTran, par_cDataHora, par_cCupom, ;
            par_cCartaoCod, par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
        LOCAL loc_cValPago, loc_nValPago, loc_aCartao, loc_cCartaoCod, loc_cCupomRestante, ;
            loc_nPos, loc_nLinha, loc_cLinhaCupom, loc_oErro, loc_lSucesso

        loc_lSucesso = .F.

        loc_nValPago = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, THIS.this_nValPago)
        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(loc_nValPago, "99999999999.99")), ".", ",")

        *-- DECLARE laCartao[11] / laCartao[1]="Outro, nao definido" ... [11]="Fininvest"
        DIMENSION loc_aCartao[11]
        loc_aCartao[1]  = "Outro, n" + CHR(227) + "o definido"
        loc_aCartao[2]  = "Visa"
        loc_aCartao[3]  = "Mastercard"
        loc_aCartao[4]  = "Diners"
        loc_aCartao[5]  = "American Express"
        loc_aCartao[6]  = "Sollo"
        loc_aCartao[7]  = "Sidecard (Redecard)"
        loc_aCartao[8]  = "Private Label (Redecard)"
        loc_aCartao[9]  = "Redeshop"
        loc_aCartao[10] = ""
        loc_aCartao[11] = "Fininvest"

        loc_cCartaoCod = IIF(VARTYPE(par_cCartaoCod) = "C", par_cCartaoCod, "0")
        IF VAL(loc_cCartaoCod) > 10 OR VAL(loc_cCartaoCod) < 0
            loc_cCartaoCod = "0"
        ENDIF

        *-- Pasta C:\client\Resp ausente (maquina de desenvolvimento/teste/
        *-- pipeline sem a integracao fiscal instalada) -> a grava eh pulada
        *-- antes do TRY, sem quebrar a aprovacao (mesmo padrao do irmao
        *-- Formsigopdtf.prg:3218). RETURN fica FORA de TRY/CATCH (regra #1).
        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN loc_lSucesso
        ENDIF

        TRY
            IF USED("cursor_4c_RespostaSiTef")
                USE IN cursor_4c_RespostaSiTef
            ENDIF

            CREATE CURSOR cursor_4c_RespostaSiTef (Tef C(100))

            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cCartaoCod) + 1])
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("011-000 = " + TratarNulo(par_cTipTran, ""))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("012-000 = " + TratarNulo(par_cNsu, ""))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("013-000 = " + TratarNulo(par_cAutoriza, ""))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("015-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("018-000 = " + TratarNulo(THIS.txt_4c_Text1.Value, ""))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("022-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 1, 4))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("023-000 = " + ;
                IIF(VARTYPE(par_cFinaliza) = "C", par_cFinaliza, ""))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))

            *-- DO WHILE lsPos<>0 / lsPos=AT(CHR(10),lsCupom) / ... quebra o
            *-- cupom em linhas numeradas "029-NNN"
            loc_cCupomRestante = TratarNulo(par_cCupom, "")
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos != 0
                loc_nPos = AT(CHR(10), loc_cCupomRestante)
                loc_cLinhaCupom = IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante)
                INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ( ;
                    STRTRAN("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + loc_cLinhaCupom, CHR(0), " "))
                loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO

            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("030-000 = " + ;
                IIF(VARTYPE(par_cMenRet) = "C", par_cMenRet, ""))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")

            SELECT cursor_4c_RespostaSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN cursor_4c_RespostaSiTef

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.RegistrarTransacaoTef("TEF_APROVADO")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF USED("cursor_4c_RespostaSiTef")
                USE IN cursor_4c_RespostaSiTef
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao gravar retorno SiTef")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarErroTef - FASE 5/8. Equivalente a PROCEDURE errotef do legado
    * (sigoptef_form_codigo_fonte.txt:646-671). Traduz o codigo de retorno
    * negativo da DLL do SiTef para a mensagem de falha correspondente e
    * delega a GravarRetornoFalha() (ver nota "Guarda ... FALLBACK" no
    * cabecalho do arquivo sobre o branch OTHERWISE).
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarErroTef(par_nRetornos)
        LOCAL loc_cMensagem

        DO CASE
            CASE par_nRetornos = -1
                loc_cMensagem = "M" + CHR(243) + "dulo N" + CHR(227) + "o Iniciado"
            CASE par_nRetornos = -2
                loc_cMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"
            CASE par_nRetornos = -3
                loc_cMensagem = "Fornecida uma Modalidade Inv" + CHR(225) + "lida"
            CASE par_nRetornos = -4
                loc_cMensagem = "Falta Mem" + CHR(243) + "ria para Rodar a Fun" + CHR(231) + CHR(227) + "o"
            CASE par_nRetornos = -5
                loc_cMensagem = "Sem Comunica" + CHR(231) + CHR(227) + "o com o SiTef"
            OTHERWISE
                loc_cMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"
        ENDCASE

        RETURN THIS.GravarRetornoFalha(loc_cMensagem, 0)
    ENDPROC

    *==========================================================================
    * EVENTOS DOS CAMPOS (FASE 6/8)
    *
    * Ver a nota "FASE 6/8" no cabecalho do arquivo para o recorte completo:
    * aqui ficam os eventos do legado que NAO dependem do laco de protocolo
    * com a CliSiTef32I.DLL, cada um transcrito INTEIRO do metodo legado
    * correspondente. Os seis lacos de protocolo (GetDigitos.Valid/GotFocus,
    * GetParcela.LostFocus, GetCartao.GotFocus, GetCodSeg.LostFocus e
    * Text1.Valid) sao escopo das fases 7-8.
    *==========================================================================

    *--------------------------------------------------------------------------
    * AplicarGatesDeFoco - reproduz o VALOR DE RETORNO dos eventos When do
    * legado, que BINDEVENT nao consegue reproduzir (o retorno do delegate eh
    * descartado - CLAUDE.md regra #3/#47).
    *
    * Os quatro When do dump, e o que cada um devolve:
    *
    *   GetValor   "Return .f."                     -> NUNCA recebe foco
    *   GetDigitos "Return(EMPTY(This.Value))"      -> so enquanto vazio
    *   GetCodSeg  "Return(EMPTY(This.Value))"      -> so enquanto vazio
    *   GetParcela "*Return(!INLIST(...))"          -> COMENTADO no dump
    *
    * GetParcela nao tem gate nenhum: a unica linha de retorno do When dele
    * esta comentada com "*" no SCX (codigo desligado de proposito pelo
    * legado), e When sem RETURN vale .T. em VFP9 - o campo recebe foco
    * normalmente. Transcrito assim; "consertar" para a versao comentada
    * mudaria comportamento.
    *
    * GetDigitos e GetCodSeg: o gate "so enquanto vazio" eh REDUNDANTE com o
    * que o proprio legado faz por Enabled - o fim do GetDigitos.Valid tem
    * "ThisForm.GetDigitos.Enabled=.f." e o laco liga/desliga GetCodSeg pelo
    * Enabled tambem (ambos nas fases 7-8). Nao ha nada a aplicar aqui para
    * esses dois, e por isso eles nao aparecem abaixo.
    *
    * GetValor eh o unico que precisa de gate permanente: o campo exibe o
    * valor da transacao e o operador jamais o digita. ReadOnly + TabStop
    * reproduz o efeito observavel do When = .F. (nao entra na tabulacao e
    * nao aceita digitacao) SEM usar Enabled = .F., que pintaria o texto de
    * cinza - o SCX declara DisabledForeColor = 0,0,0 justamente para o
    * valor continuar legivel, e o legado nunca desabilita este campo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarGatesDeFoco()
        *-- SIGOPTEF.GetValor.When: "Return .f."
        THIS.txt_4c_Valor.ReadOnly = .T.
        THIS.txt_4c_Valor.TabStop  = .F.

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventosCampos - liga por BINDEVENT os eventos de campo desta
    * fase. Chamado por InicializarForm DEPOIS de TornarControlesVisiveis,
    * quando todos os controles ja existem (BINDEVENT para objeto inexistente
    * estoura no proprio bind).
    *
    * Todos os metodos-alvo sao PUBLIC (sem PROTECTED): BINDEVENT so alcanca
    * metodo publico, e com PROTECTED a falha eh SILENCIOSA - o handler
    * simplesmente nunca roda (CLAUDE.md regra #3).
    *
    * "When" eh ligado de verdade aqui: o delegate DISPARA normalmente, so o
    * retorno dele eh descartado - por isso os efeitos colaterais dos When do
    * legado (SET CONFIRM OFF, INKEY/CLEAR TYPEAHEAD/KEYBOARD) ficam nestes
    * handlers, e so o gate de foco foi para AplicarGatesDeFoco().
    *
    * Que o delegate de "When" DISPARA foi MEDIDO no VFP9, nao presumido
    * (2026-11-18, automation\Probe809F6c.prg): com SET CONFIRM ON, acionar
    * txt_4c_Digitos.When() com o campo vazio deixa SET("CONFIRM") = OFF, e
    * o LostFocus devolve a ON. Medidos tambem os dois ramos do ParcelaWhen
    * (valor "1" -> CONFIRM continua ON, ramo que enfileira TAB; vazio ->
    * CONFIRM vai a OFF) e o caso em que o IF do legado NAO entra
    * (txt_4c_Digitos com "1234" -> CONFIRM continua ON). Os binds em si
    * foram medidos por AEVENTS com DOIS argumentos, evento na coluna 3
    * (automation\Probe809F6.prg).
    *
    * "Valid" NAO eh ligado: BINDEVENT em Valid nao dispara em TextBox
    * (regra #3). Os dois Valid independentes do laco viraram
    * ValidarParcela()/ValidarCartao(), acionados pelo KeyPress com teste de
    * ENTER(13)/TAB(9) no topo - as duas teclas que fazem o foco deixar o
    * campo e que, no legado, disparariam o Valid.
    *
    * GetValor nao aparece: o When dele nao tem efeito colateral nenhum (so
    * "Return .f."), ja coberto por AplicarGatesDeFoco().
    *
    * FASE 7/8: o Click do botao Cancelar passou a ser ligado aqui (primeiro
    * bind do metodo, abaixo). Os eventos dos seis lacos de protocolo ficam
    * para a Fase 8, junto com os handlers correspondentes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventosCampos()
        *-- SIGOPTEF.SAIDA.CANCELA.Click - o bind eh no BOTAO (Buttons(1)) e
        *-- nao no CommandGroup: eh o Click do botao que o legado implementa,
        *-- e o grupo tem ButtonCount = 1.
        BINDEVENT(THIS.cmg_4c_Saida.Buttons(1), "Click", THIS, "BtnCancelarClick")

        *-- SIGOPTEF.GetDigitos.When / Valid (via KeyPress) / LostFocus / GotFocus
        BINDEVENT(THIS.txt_4c_Digitos, "When",      THIS, "DigitosWhen")
        BINDEVENT(THIS.txt_4c_Digitos, "KeyPress",  THIS, "DigitosKeyPress")
        BINDEVENT(THIS.txt_4c_Digitos, "LostFocus", THIS, "DigitosLostFocus")
        BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",  THIS, "DigitosGotFocus")

        *-- SIGOPTEF.GetParcela.When / Valid (Valid via KeyPress) / LostFocus
        BINDEVENT(THIS.txt_4c_Parcela, "When",      THIS, "ParcelaWhen")
        BINDEVENT(THIS.txt_4c_Parcela, "KeyPress",  THIS, "ParcelaKeyPress")
        BINDEVENT(THIS.txt_4c_Parcela, "LostFocus", THIS, "ParcelaLostFocus")

        *-- SIGOPTEF.GetCartao.Valid (via KeyPress) / GotFocus
        BINDEVENT(THIS.txt_4c_Cartao, "KeyPress", THIS, "CartaoKeyPress")
        BINDEVENT(THIS.txt_4c_Cartao, "GotFocus", THIS, "CartaoGotFocus")

        *-- SIGOPTEF.GetCodSeg.When / GotFocus / LostFocus
        BINDEVENT(THIS.txt_4c_Codigo, "When",      THIS, "CodSegWhen")
        BINDEVENT(THIS.txt_4c_Codigo, "GotFocus",  THIS, "CodSegGotFocus")
        BINDEVENT(THIS.txt_4c_Codigo, "LostFocus", THIS, "CodSegLostFocus")

        *-- SIGOPTEF.Text1.When / Valid (via KeyPress) / LostFocus / GotFocus
        BINDEVENT(THIS.txt_4c_Text1, "When",      THIS, "Text1When")
        BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "Text1KeyPress")
        BINDEVENT(THIS.txt_4c_Text1, "LostFocus", THIS, "Text1LostFocus")
        BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "Text1GotFocus")

        *-- SIGOPTEF.Timer1.Timer
        BINDEVENT(THIS.obj_4c_Timer1, "Timer", THIS, "TimerLiberarEsc")

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - PROCEDURE KeyPress do form legado
    * (sigoptef_form_codigo_fonte.txt:824-830):
    *
    *     LPARAMETERS nKeyCode, nShiftAltCtrl
    *     If nKeyCode = 27 And nShiftAltCtrl = 0 And ThisForm.pcKeyEsc
    *         NoDefault
    *         ThisForm.SAIDA.CANCELA.Click
    *     Endif
    *
    * Transcricao direta: pcKeyEsc -> THIS.this_lPermiteEsc (ligado pelo Init
    * e rearmado pelo Timer1). O form tem KeyPreview = .T. (propriedade do
    * SCX, ja transcrita na Fase 3), por isso este evento ve a tecla antes do
    * controle com foco - sem ela o ESC nunca chegaria aqui.
    *
    * Metodo NATIVO do form, nao delegate: sobrescrever KeyPress funciona sem
    * BINDEVENT, e assim o NODEFAULT tem efeito de verdade (num delegate ele
    * nao suprimiria o comportamento padrao do evento).
    *
    * Delega ao handler do botao Cancelar, exatamente como o legado - e nao a
    * uma copia da logica de cancelamento - para haver UM so caminho de saida.
    *
    * FASE 7/8: a chamada passou de THIS.cmg_4c_Saida.Buttons(1).Click() para
    * THIS.BtnCancelarClick() DIRETO, agora que o handler existe. O caminho
    * indireto dependia de o delegate de BINDEVENT disparar tambem quando o
    * Click eh acionado por CODIGO; chamar o metodo eh equivalente para o
    * legado (o Click dele nao faz nada alem do corpo que foi migrado), nao
    * depende dessa suposicao e eh o recorte do irmao Formsigopdtf.prg.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lPermiteEsc
            NODEFAULT
            THIS.BtnCancelarClick()
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosWhen - SIGOPTEF.GetDigitos.When:
    *
    *     If Empty(This.Value)
    *         Set Confirm Off
    *     Endif
    *     Return(EMPTY(This.Value))
    *
    * O RETURN eh o gate de foco - ver AplicarGatesDeFoco(), que explica por
    * que ele nao se reproduz num delegate e por que aqui ele eh redundante
    * com o Enabled que o legado mesmo manipula.
    *
    * SET CONFIRM OFF faz o foco avancar sozinho quando o campo se enche: com
    * InputMask "9999" (4 digitos), o operador digita os quatro ultimos
    * digitos do cartao e a tela segue sem precisar de ENTER. O legado liga
    * isso ao ENTRAR no campo e desliga ao SAIR (LostFocus, abaixo) - eh um
    * SET global, por isso vem em par.
    *
    * PUBLIC: alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE DigitosWhen()
        IF EMPTY(THIS.txt_4c_Digitos.Value)
            SET CONFIRM OFF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosLostFocus - SIGOPTEF.GetDigitos.LostFocus: "Set Confirm On".
    * Metade de volta do par aberto por DigitosWhen - restaura o SET global
    * ao sair do campo. PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosLostFocus()
        SET CONFIRM ON

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ParcelaWhen - SIGOPTEF.GetParcela.When:
    *
    *     If Not InList(This.Value,"1","2")
    *         Set Confirm Off
    *     ELSE
    *         INKEY(0.1)
    *         CLEAR TYPEAHEAD
    *         KEYBOARD CHR(9)
    *     Endif
    *     *Return(!INLIST(This.Value,"1","2"))
    *
    * Duas metades com proposito oposto, as duas transcritas:
    *   - campo AINDA sem resposta valida: SET CONFIRM OFF, para a resposta
    *     de 1 caractere avancar o foco sozinha;
    *   - campo JA respondido ("1" ou "2"): o legado nao deixa o operador
    *     parar ali de novo - espera 0,1s, limpa o buffer de teclado e
    *     enfileira CHR(9) (TAB), empurrando o foco para o campo seguinte.
    *
    * A ultima linha do When esta COMENTADA no dump: nao ha gate de foco
    * neste campo (ver AplicarGatesDeFoco). O INKEY/KEYBOARD acima eh que faz
    * o papel de "sair do campo", e eh o que o legado de fato executa.
    *
    * This.Value transcrito SEM ALLTRIM, como no legado: o InputMask "!" tem
    * um caractere, logo o valor eh "" ou um char - nao ha espaco a aparar, e
    * aparar mudaria o resultado do INLIST quando o operador responde " ".
    *
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ParcelaWhen()
        IF !INLIST(THIS.txt_4c_Parcela.Value, "1", "2")
            SET CONFIRM OFF
        ELSE
            INKEY(0.1)
            CLEAR TYPEAHEAD
            KEYBOARD CHR(9)
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParcela - SIGOPTEF.GetParcela.Valid, integral:
    *
    *     Return(INLIST(This.Value,"1","2"," "))
    *
    * Responde quem assume o parcelamento - os labels ao lado do campo
    * ("1 - Lojista" / "2 - Administradora") sao a legenda desta lista.
    *
    * A entrada " " da lista eh o que deixa o campo em BRANCO passar, e isso
    * foi MEDIDO no VFP9 (2026-11-18, automation\Probe809F6b.prg) em vez de
    * deduzido - o resultado depende de SET EXACT, que o config.prg deste
    * sistema deixa em ON:
    *
    *     SET EXACT ON    "" = " " -> .T.    INLIST("","1","2"," ") -> .T.
    *     SET EXACT OFF   "" = " " -> .F.    INLIST("","1","2"," ") -> .F.
    *
    * Com EXACT ON os brancos a direita sao ignorados na comparacao, entao a
    * string vazia casa com o " " da lista e o Valid LIBERA o foco - a
    * resposta "nao informada" eh aceita, e eh justamente para isso que o
    * legado pos o espaco na lista. "1" e "2" continuam aceitos e qualquer
    * outro caractere ("3" medido) continua recusado.
    *
    * Transcrito literalmente, sem ALLTRIM e sem tratar "" em separado:
    * mexer na expressao mudaria o resultado conforme o SET EXACT vigente,
    * que eh exatamente o que o legado nao faz.
    *
    * PUBLIC: consumido por ParcelaKeyPress, que eh alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    FUNCTION ValidarParcela()
        RETURN INLIST(THIS.txt_4c_Parcela.Value, "1", "2", " ")
    ENDFUNC

    *--------------------------------------------------------------------------
    * ParcelaKeyPress - dispara ValidarParcela() nas teclas que fariam o foco
    * deixar o campo (ENTER/TAB), porque BINDEVENT em "Valid" nao dispara em
    * TextBox (regra #3). O teste da tecla eh a PRIMEIRA coisa do handler.
    *
    * Quando a resposta eh invalida, o efeito observavel do "Return(.f.)" do
    * legado eh o foco NAO sair do campo - reproduzido com SetFocus() de
    * volta. NODEFAULT nao serviria aqui: num delegate de BINDEVENT ele nao
    * suprime o comportamento padrao do evento.
    *
    * Sem mensagem de erro: o legado tambem nao exibe nenhuma neste Valid -
    * o campo simplesmente nao libera o foco, e as duas legendas ao lado ja
    * dizem quais respostas existem.
    *
    * PUBLIC + parametros do evento declarados: handler de KeyPress sem
    * LPARAMETERS/parametros estoura a cada tecla (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ParcelaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !THIS.ValidarParcela()
            THIS.txt_4c_Parcela.SetFocus()
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCartao - SIGOPTEF.GetCartao.Valid, integral:
    *
    *     IF LEN(ALLTRIM(THIS.Value)) > 19
    *         DO Form SigTfDss With "Erro na Transacao","","Cartao com mais de 19 digito",...
    *         Return(.f.)
    *     Endif
    *
    * 19 eh o limite de digitos do PAN aceito pelo protocolo, e coincide com
    * o MaxLength = 19 que o SCX declara no campo (Fase 4) - a checagem aqui
    * eh a segunda linha de defesa, para o caso de o valor ter sido posto por
    * codigo em vez de digitado.
    *
    * O texto da mensagem vai SEM acento, como no legado: eh a string que o
    * dialogo do protocolo exibe, e nao um rotulo da tela nova.
    *
    * PUBLIC: consumido por CartaoKeyPress, que eh alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    FUNCTION ValidarCartao()
        LOCAL loc_lValido

        loc_lValido = .T.

        IF LEN(ALLTRIM(THIS.txt_4c_Cartao.Value)) > 19
            THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                "Cartao com mais de 19 digito", "")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * CartaoKeyPress - mesmo recorte de ParcelaKeyPress: o Valid do legado
    * acionado pelas teclas que tiram o foco do campo (ENTER/TAB), com o
    * foco devolvido ao campo quando a validacao recusa o valor.
    *
    * PUBLIC + parametros do evento declarados (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CartaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !THIS.ValidarCartao()
            THIS.txt_4c_Cartao.SetFocus()
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegWhen - SIGOPTEF.GetCodSeg.When:
    *
    *     If Empty(This.Value)
    *         Set Confirm Off
    *     Endif
    *     Return(EMPTY(This.Value))
    *
    * Mesmo par SET CONFIRM dos outros campos de resposta curta (aqui o
    * InputMask eh "99999"). O RETURN eh gate de foco - ver
    * AplicarGatesDeFoco().
    *
    * A metade de volta (SET CONFIRM ON) mora no SIGOPTEF.GetCodSeg.LostFocus,
    * que eh um dos seis lacos de protocolo e por isso fica para as fases
    * 7-8: no legado o "Set Confirm on" eh a PRIMEIRA linha desse LostFocus,
    * antes de qualquer conversa com o terminal, e separa-lo agora duplicaria
    * um metodo que vai ser escrito inteiro la.
    *
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegWhen()
        IF EMPTY(THIS.txt_4c_Codigo.Value)
            SET CONFIRM OFF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegGotFocus - SIGOPTEF.GetCodSeg.GotFocus:
    *
    *     ThisForm.Container1.Label1.Caption="Digite o Codigo"+CHR(13)+"de Seguranca"
    *
    * O painel de instrucao ao operador (cnt_4c_Container1) eh reescrito a
    * cada etapa do dialogo - este eh o texto da etapa do codigo de
    * seguranca. Transcrito SEM acento, como no legado: eh instrucao exibida
    * no mesmo painel que o Init ja escreve com "Insira ou Passe o Cartao" /
    * "Digite o Numero do Cartao" (ver AtualizarTextosDaTela), tambem sem
    * acento - acentuar so este quebraria a uniformidade do painel.
    *
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegGotFocus()
        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            IF PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = ;
                    "Digite o Codigo" + CHR(13) + "de Seguranca"
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * GetCodSeg.Valid do legado NAO EH TRANSCRITO, e isso nao eh omissao: o
    * corpo INTEIRO do metodo esta comentado no dump, com o prefixo "*!*" do
    * Form Designer (sigoptef_form_codigo_fonte.txt:1745-1755):
    *
    *     *!*  IF VAL(This.Value)>1 .and. VAL(This.Value)<100
    *     *!*      DO Form SigTfDss With "Erro na Transacao","","CSEG Invalido",...
    *     *!*      Return(.f.)
    *     *!*  ELSE
    *     *!*      Return(.t.)
    *     *!*  Endif
    *
    * Ou seja: o legado DESLIGOU essa checagem de proposito - o metodo existe
    * mas nao executa nada, e o campo aceita qualquer codigo de 5 digitos.
    * Transcrever o conteudo comentado criaria uma validacao que o sistema
    * legado nao faz (e que, pela propria expressao, recusaria todo CSEG
    * entre 2 e 99 - exatamente o que deve ter motivado o desligamento).
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Text1When - SIGOPTEF.Text1.When: "Set Confirm Off", linha unica.
    * Text1 eh o campo "N PARCELAS"; com InputMask "99" o SET CONFIRM OFF faz
    * o foco avancar quando os dois digitos sao preenchidos. Sem RETURN no
    * legado, logo sem gate de foco. PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE Text1When()
        SET CONFIRM OFF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Text1LostFocus - SIGOPTEF.Text1.LostFocus: "Set Confirm On". Metade de
    * volta do par aberto por Text1When. PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE Text1LostFocus()
        SET CONFIRM ON

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Text1GotFocus - SIGOPTEF.Text1.GotFocus:
    *
    *     ThisForm.Container1.Label1.Caption="Digite o Numero"+CHR(13)+"de Parcelas"
    *
    * Mesmo painel de instrucao do CodSegGotFocus, texto da etapa do numero
    * de parcelas. Tambem sem acento, pelo mesmo motivo.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE Text1GotFocus()
        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            IF PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = ;
                    "Digite o Numero" + CHR(13) + "de Parcelas"
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * TimerLiberarEsc - SIGOPTEF.Timer1.Timer:
    *
    *     THisForm.pcKeyEsc = .t.
    *     This.Enabled = .f.
    *
    * Timer de tiro UNICO (Interval = 100ms, nasce desligado): quem o liga
    * quer REARMAR o ESC um instante depois de uma etapa que o havia
    * bloqueado, e o proprio evento se desliga para nao repetir. Por isso
    * "Enabled = .f." eh parte da logica, nao limpeza.
    *
    * "This.Enabled" do legado eh o TIMER (This dentro do evento do timer),
    * nao o form - por isso o alvo aqui eh THIS.obj_4c_Timer1.Enabled.
    *
    * O nome do metodo descreve a ACAO (rearmar o ESC) em vez de repetir o
    * nome do objeto legado, convencao do projeto para handlers.
    *
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE TimerLiberarEsc()
        THIS.this_lPermiteEsc = .T.
        THIS.obj_4c_Timer1.Enabled = .F.

        RETURN
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS (FASE 7/8)
    *
    * O evento de botao que este form tem: o Click do unico CommandGroup da
    * tela (SAIDA, ButtonCount = 1). Ver a nota "FASE 7/8" no cabecalho do
    * arquivo para o porque de nao existirem aqui os quatro BtnXxxClick de
    * CRUD, e para o que resta na Fase 8.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnCancelarClick - SIGOPTEF.SAIDA.CANCELA.Click, integral
    * (sigoptef_form_codigo_fonte.txt:939-943):
    *
    *     lnRetorno=ContinuaFuncaoSiTefInterativo(@ProximoComando, @TipoCampo,
    *               @TamanhoMinimo, @TamanhoMaximo, @Buffer, Len(Buffer), -1)
    *     ThisForm.RetornoFalha("Oper. Cancelada pelo Usuario(1)",lnValPago)
    *     RELEASE WINDOWS
    *
    * As tres linhas, na ordem, e cada uma importa:
    *
    *   1. Continua... com o ULTIMO argumento -1 eh o "aborta" do protocolo:
    *      avisa o terminal que o operador desistiu, para o PIN-pad nao ficar
    *      preso esperando resposta de uma transacao que ninguem vai concluir.
    *      Vai por THIS.this_oBusinessObject.ContinuarSiTef(-1), que eh o
    *      ponto unico de chamada a DLL (as cinco variaveis do estado sao
    *      passadas por referencia e copiadas de volta la - fazer a chamada
    *      solta aqui deixaria copias do estado fora de sincronia).
    *      O retorno eh DESCARTADO de proposito: o legado o guarda em
    *      lnRetorno e nao o le em linha nenhuma depois - o cancelamento
    *      segue adiante mesmo que o terminal recuse o aborto.
    *
    *   2. RetornoFalha grava C:\client\Resp\IntPos.001/.STS com a mensagem de
    *      cancelamento, que eh como o PDV descobre que nao houve autorizacao.
    *      Aqui chama-se GravarRetornoFalha (nome do metodo migrado na Fase 5).
    *      A mensagem vai SEM acento, literal do legado: ela eh gravada no
    *      campo "030-000" do arquivo de protocolo, nao eh rotulo de tela.
    *
    *   3. RELEASE WINDOWS -> THIS.EncerrarDialogo() (ver o metodo abaixo).
    *
    * this_lCancelado = .T. no BO nao eh invencao desta fase: a property foi
    * declarada na Fase 6 com o comentario "Transacao abandonada pelo operador
    * (ESC / botao Cancelar). Lida pelos lacos do protocolo para nao insistir
    * com o terminal" - este eh o ponto que a liga. No legado o papel dela eh
    * feito pelo proprio "RELEASE WINDOWS", que derruba a janela e com ela os
    * lacos; como aqui o fechamento eh Hide() e o objeto continua vivo, a flag
    * eh o que diz aos lacos da Fase 8 que a transacao foi abortada.
    *
    * Guarda de BO inexistente: nao tem equivalente no legado, mas em modo de
    * validacao de UI / teste automatizado o InicializarForm sai antes de
    * criar o BO (this_oBusinessObject fica .NULL.) e a chamada estouraria. Em
    * producao o BO sempre existe, entao o caminho do legado fica integral -
    * e o arquivo de resposta eh gravado nos DOIS ramos, porque avisar o PDV
    * do cancelamento nao depende de haver terminal.
    *
    * PUBLIC: alvo de BINDEVENT (regra #3), chamado tambem pelo KeyPress do
    * form (ESC) e pelo harness de teste, que invoca Btn*Click de fora da
    * classe.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.ContinuarSiTef(-1)
            loc_oBO.this_lCancelado = .T.

            THIS.GravarRetornoFalha("Oper. Cancelada pelo Usuario(1)", loc_oBO.this_nValPago)
        ELSE
            THIS.GravarRetornoFalha("Oper. Cancelada pelo Usuario(1)", THIS.this_nValPago)
        ENDIF

        THIS.EncerrarDialogo()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * EncerrarDialogo - ponto UNICO de saida da tela, no lugar dos 23
    * "RELEASE WINDOWS" / "ThisForm.Release" espalhados pelo dump do legado.
    *
    * Fecha com Hide() e NAO com Release(). O motivo esta por extenso na nota
    * "FASE 7/8" do cabecalho; em uma linha: em VFP9 o Release() destroi o
    * objeto mesmo havendo referencia externa viva, e esta tela existe para
    * DEVOLVER ao PDV o resultado da transacao - que no sistema novo o
    * chamador le de uma property depois do Show(), nao do RETURN do Unload.
    * Quem abriu chama Release() depois de ler, mesmo contrato do
    * classes\formbuscaauxiliar.prg.
    *
    * Idempotente de proposito: varios ramos do legado disparam release em
    * sequencia (ErroTef seguido de RELEASE WINDOWS, por exemplo) e a execucao
    * CONTINUA nas linhas seguintes depois disso - Hide() repetido em form ja
    * oculto eh no-op, entao chamar varias vezes eh seguro.
    *
    * CONTRATO PARA A FASE 8: quando o Unload entrar (o retorno "0,00/" +
    * lnParcs + "/" + data + bandeira + cartao), esse valor tem de ser
    * CALCULADO E CACHEADO AQUI, ANTES do Hide(). Deixar o calculo so no
    * Destroy nao serve: com Hide() o Destroy roda quando o CHAMADOR liberar o
    * objeto, isto eh DEPOIS de ele tentar ler o resultado. Mesmo recorte do
    * EncerrarDialogo do irmao Formsigopdtf.prg, que faz
    * "IF EMPTY(this_cRetornoTef) / this_cRetornoTef = MontarRetornoTef()"
    * antes do Hide - e a condicao de vazio existe justamente por causa da
    * idempotencia descrita acima: recalcular a cada chamada sobrescreveria,
    * com estado mais pobre, o valor montado no primeiro encerramento.
    *
    * PUBLIC: unico ponto de fechamento da tela - o chamador pode precisar
    * fecha-la por conta propria.
    *--------------------------------------------------------------------------
    PROCEDURE EncerrarDialogo()
        IF EMPTY(THIS.this_cRetornoTef)
            THIS.this_cRetornoTef = THIS.MontarRetornoTef()
        ENDIF

        THIS.Hide()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * QueryUnload - a SEGUNDA METADE do contrato de Hide() do EncerrarDialogo,
    * e a que se esquece: sem ela, Alt+F4 DESTROI o form e o Release() do
    * chamador estoura "<var> is not an object" - erro que aparece dentro do
    * form que ABRIU este dialogo, longe da causa.
    *
    * O Closable continua .T. mesmo com TitleBar = 0 e ControlBox = .F. (as
    * tres propriedades vem do SCX legado, Fase 3): nao ha X para clicar, mas
    * o Alt+F4 fecha - e o VFP levanta o QueryUnload nesse caminho.
    *
    * NODEFAULT nao tranca o objeto: Form.Release() NAO levanta QueryUnload,
    * vai direto ao Destroy. Quem destroi segue sendo quem criou.
    *
    * Nao chama DODEFAULT(): o QueryUnload de FormBase decide o fechamento por
    * this_lEmEdicao (semantica de form CRUD, que esta tela nao tem) e devolve
    * .T., isto eh AUTORIZA a destruicao - exatamente o que este override
    * existe para impedir. Mesmo par ja adotado em
    * classes\formbuscaauxiliar.prg.
    *
    * Fecha pelo MESMO funil do botao Cancelar e do ESC, para os tres caminhos
    * de saida nao divergirem.
    *
    * Forma transcrita do par canonico do projeto (funil + NODEFAULT, sem
    * valor de retorno) e NAO "RETURN .F.": o QueryUnload de FormBase usa o
    * retorno com semantica propria (RETURN !THIS.Cancelar()), e NODEFAULT eh
    * o mecanismo que de fato cancela o fechamento.
    *--------------------------------------------------------------------------
    PROCEDURE QueryUnload()
        THIS.EncerrarDialogo()

        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirMensagemTef - substitui as 11 chamadas
    *
    *     DO Form SigTfDss With <titulo>,"",<msg1>,<msg2>,"","VM",Left,Top
    *
    * espalhadas pelo dump. O SIGTFDSS.scx NAO faz parte do acervo migrado;
    * pelos call sites ele era um dialogo que apenas EXIBIA as duas linhas de
    * texto (o "VM" eh o esquema de cor, e os dois ultimos argumentos sao a
    * posicao), entao uma caixa de mensagem eh substituicao fiel.
    *
    * MsgAviso e NAO MsgErro, de proposito: sao mensagens de PROTOCOLO
    * devolvidas pelo terminal ("Cartao Vencido", "Cartao Invalido para esta
    * Condicao de Pagamento"), nao falhas tecnicas do sistema - e MsgErro
    * exibe o botao "Fechar Aplicacao", que seria desastroso no meio de uma
    * transacao com o PIN-pad. Mesmo critrio do irmao Formsigopdtf.
    *
    * PROTECTED: consumido so por metodos desta classe (ValidarCartao nesta
    * fase; os lacos de protocolo nas fases 7-8). Delegate de BINDEVENT roda
    * como metodo de THIS, portanto alcanca metodo protegido sem problema -
    * a regra #3 vale para o ALVO do bind, nao para o que ele chama.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
        LOCAL loc_cMensagem, loc_cTitulo

        loc_cMensagem = ALLTRIM(IIF(VARTYPE(par_cMsg1) = "C", par_cMsg1, ""))

        IF VARTYPE(par_cMsg2) = "C" AND !EMPTY(par_cMsg2)
            loc_cMensagem = loc_cMensagem + CHR(13) + ALLTRIM(par_cMsg2)
        ENDIF

        IF EMPTY(loc_cMensagem)
            loc_cMensagem = "Falha na comunica" + CHR(231) + CHR(227) + ;
                "o com o terminal."
        ENDIF

        IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
            loc_cTitulo = par_cTitulo
        ELSE
            loc_cTitulo = "Transa" + CHR(231) + CHR(227) + "o"
        ENDIF

        MsgAviso(loc_cMensagem, loc_cTitulo)

        RETURN
    ENDPROC

    *==========================================================================
    * LACO DE PROTOCOLO COM A DLL (FASE 8/8)
    *
    * Os SEIS metodos abaixo sao as variantes do mesmo dialogo com o
    * terminal que a nota "FASE 6/8" no cabecalho do arquivo deferiu: cada
    * um eh uma transcricao INTEGRAL do metodo legado correspondente
    * (GetDigitos.Valid, GetDigitos.GotFocus, GetParcela.LostFocus,
    * GetCartao.GotFocus, GetCodSeg.LostFocus, Text1.Valid), todos
    * compartilhando o estado do protocolo que vive no BO
    * (this_nProximoComando/this_nTipoCampo/this_cBuffer/this_nContinua,
    * manipulados por THIS.this_oBusinessObject.ContinuarSiTef()) e os
    * acumuladores desta passagem (this_cTipTran/this_cDataHoraTef/
    * this_cCupomRetorno/this_cNsu/this_cAutoriza/this_cFinaliza/
    * this_cMensagemRetorno/this_cMRet, tambem no BO - equivalentes aos
    * "PRIVATE lsTipTran, lsDataHora, ..." que o legado declara de novo no
    * topo de cada um destes metodos, e por isso ZERADOS por
    * ZerarAcumuladoresProtocolo() no INICIO de cada um dos seis, nunca no
    * meio.
    *
    * GUARDA DE REENTRANCIA (this_lEmProtocolo): sem equivalente no legado,
    * obrigatoria aqui. O laco abre dialogo MODAL (ExibirMensagemTef) e
    * mexe em .Enabled/.SetFocus de outros campos - as duas coisas tiram e
    * devolvem o foco, o que pode redisparar o MESMO evento (regras
    * #37/#47). Cada metodo-evento eh um WRAPPER fino (seta a flag, chama o
    * <Nome>Exec() correspondente, desliga a flag) porque o corpo real tem
    * RETURN antecipado em varios pontos - padrao imune a RETURN da regra
    * #47 (set/clear simples deixaria a flag presa ligada para sempre se o
    * corpo saisse pelo meio, matando o campo pelo resto da vida do form).
    *
    * DUAS SUBSTITUICOES DE DIALOGO FILHO, por AUSENCIA no acervo (os .SCX
    * nao vieram) - ambas FALAM EM VOZ ALTA em vez de silenciar, porque no
    * caminho de dinheiro ausencia muda eh pior que ausencia visivel (mesmo
    * criterio da regra #27 sobre wrapper de funcao legada ausente):
    *   - SigCsTef (valor do saque) -> MsgAviso e assume "0,00".
    *   - SigCoCDC (consulta CDC)   -> MsgAviso; o RetornoFalha que o legado
    *     grava em seguida eh preservado.
    * SigTfDss (mensagem de erro do protocolo) ja foi substituido na Fase
    * 6/8 por ExibirMensagemTef, que eh substituicao FIEL (o dialogo legado
    * so exibia texto).
    *
    * "ThisForm.Release"/"RELEASE WINDOWS" do legado viram
    * THIS.EncerrarDialogo() - ponto unico de saida, ja em uso desde a Fase
    * 7 (BtnCancelarClick). Onde o legado continua executando linhas DEPOIS
    * do release (varios ramos disparam release em sequencia), o Hide() por
    * baixo de EncerrarDialogo eh idempotente e nao-destrutivo, entao as
    * linhas seguintes continuam seguras - exceto no "ESC/Lastkey()=27" de
    * cada laco, onde a divergencia e DELIBERADA: em vez de so chamar
    * RetornoFalha+release e deixar o laco teoricamente continuar
    * conversando com um terminal que acabou de ser mandado abortar, aqui
    * SEMPRE se devolve (RETURN) logo depois - mesmo criterio que o irmao
    * Formsigopdtf.prg ja adota nos pontos equivalentes.
    *
    * "Buffer = 'X'" literal (nao ALLTRIM) com SET EXACT ON (config.prg)
    * NUNCA caso neste sistema - precisaria do mesmo tamanho apos
    * desconsiderar so ESPACOS, e o Buffer vem preenchido com CHR(0), nao
    * espaco. Onde o legado compara o Buffer CRU contra um literal de 1
    * caractere (ex.: "Buffer <> '1'"), a comparacao migrada eh sobre
    * LEFT(Buffer,1), reproduzindo o resultado que o legado tinha sob o seu
    * proprio SET EXACT OFF (default) - mesma tecnica do irmao
    * Formsigopdtf.prg.
    *==========================================================================

    *--------------------------------------------------------------------------
    * DigitosKeyPress - wrapper de SIGOPTEF.GetDigitos.Valid. BINDEVENT em
    * "Valid" nao dispara em TextBox (regra #3); o Valid legado roda aqui
    * testando ENTER(13)/TAB(9), as duas teclas que tiram o foco do campo.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.DigitosKeyPressExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosKeyPressExec - corpo de SIGOPTEF.GetDigitos.Valid
    * (sigoptef_form_codigo_fonte.txt:980-1244), os DOIS lacos do metodo:
    * o 1o ("DO While ProximoComando <> 30") so consome o protocolo ate o
    * terminal liberar o proximo campo; o 2o ("DO WHILE lnRetorno = 10000")
    * envia os 4 digitos e conduz tipo de venda/parcelamento/garantia/
    * saque/codigo de seguranca.
    *
    * "IF ProximoComando = 22" repetido logo depois do 1o Enddo no legado
    * NAO foi transcrito: o 1o laco so sai quando ProximoComando = 30 (a
    * condicao do DO WHILE fica falsa) ou pelo RETURN explicito deste
    * mesmo IF DENTRO do laco - chegar depois do Enddo com
    * ProximoComando = 22 eh logicamente inalcancavel.
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosKeyPressExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_Digitos.Value)

        IF LEN(loc_cValor) != 4 AND !EMPTY(loc_cValor)
            THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                "Quantidade de Digitos Invalida", "")
            THIS.txt_4c_Digitos.Value = ""
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- Transfere a tela para o BO ANTES do laco: dali em diante o valor
        *-- enviado a DLL vem da property, nao do controle (ver FormParaBO).
        THIS.FormParaBO()
        loc_cValor = loc_oBO.this_cDigitosCartao

        loc_oBO.ZerarAcumuladoresProtocolo()

        *-- 1o laco: "DO While ProximoComando <> 30".
        DO WHILE loc_oBO.this_nProximoComando != 30
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF loc_nRetorno < 0
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando != 21
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = REPLICATE(CHR(0), 2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        loc_oBO.MontarBufferSiTef(loc_cValor)
        loc_oBO.this_nContinua = 1000
        loc_nRetorno           = 10000

        *-- 2o laco: "DO WHILE lnRetorno = 10000".
        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_nRetorno < 0
                IF loc_nRetorno = -2
                    THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", "Cartao Vencido", "")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                IF THIS.this_cTipPagto != "E" OR THIS.this_nNumParcs = 1 OR loc_oBO.this_cTcdc = "S"
                    IF THIS.this_cCodCartaoSiTef = "00125"
                        loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                            IIF(THIS.this_cTipPagto = "1", "3", ;
                            IIF(loc_oBO.this_cTcdc = "S", IIF(THIS.this_cDebCred = "O", "4", "3"), "2"))) + ;
                            REPLICATE(CHR(0), 1999)
                    ELSE
                        loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                            IIF(THIS.this_cTipPagto = "1", "2", ;
                            IIF(loc_oBO.this_cTcdc = "S", IIF(THIS.this_cDebCred = "O", "4", "3"), "3"))) + ;
                            REPLICATE(CHR(0), 1999)
                    ENDIF
                    loc_oBO.this_nContinua = 1000
                ELSE
                    EXIT
                ENDIF
            ENDIF

            IF (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo != 514 AND ;
                    (THIS.this_cDebCred = "C" OR loc_oBO.this_nTipoCampo = 511)) OR ;
                    (THIS.this_cDebCred = "O" AND "NUMERO DE PARCELA" $ UPPER(loc_cBuf))
                loc_oBO.this_cBuffer   = ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
                IF loc_oBO.this_cGarantias = "S"
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                *-- DO FORM SigCsTef WITH Top,Left TO lcSaque - dialogo de
                *-- valor de saque nao portado (SIGCSTEF.scx fora do
                *-- acervo). Avisa e assume "0,00" (sem saque).
                MsgAviso("Entrada do valor de saque (SigCsTef) n" + CHR(227) + "o foi portada" + ;
                    " nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "Assumindo saque de R$ 0,00.", "Saque")
                loc_oBO.this_cBuffer   = "0,00" + REPLICATE(CHR(0), 1996)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
                THIS.txt_4c_Codigo.Enabled = .T.
                EXIT
            ENDIF

            IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_cBuf))
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando = 22 AND THIS.this_cDebCred = "O"
                loc_oBO.this_cCupomRetorno = loc_cBuf
                loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30 AND ;
                    loc_oBO.this_nProximoComando != 34
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF THIS.this_cDebCred = "O" AND loc_oBO.this_cTcdc = "S"
                *-- DO FORM SigCoCDC WITH lsCupom - consulta CDC nao portada
                *-- (SIGCOCDC.scx fora do acervo). O RetornoFalha que o
                *-- legado grava em seguida eh preservado.
                MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
                    CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), "Consulta CDC")
                THIS.GravarRetornoFalha("Consulta CDC Realizada", THIS.this_nValPago)
            ELSE
                IF loc_nRetorno = 0
                    THIS.GravarRetornoAprovado(loc_oBO.this_cTipTran, loc_oBO.this_cDataHoraTef, ;
                        loc_oBO.this_cCupomRetorno, THIS.this_cBandeira, loc_oBO.this_cNsu, ;
                        loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, THIS.this_nValPago, loc_oBO.this_cMRet)
                ENDIF
            ENDIF
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
        ELSE
            IF LEFT(loc_oBO.this_cBuffer, 1) != "1"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Resp." + CHR(13) + "Parcelamento"
            ELSE
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
            ENDIF
        ENDIF

        THIS.txt_4c_Digitos.Enabled = .F.
        IF !THIS.txt_4c_Codigo.Enabled
            THIS.txt_4c_Parcela.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosGotFocus - wrapper de SIGOPTEF.GetDigitos.GotFocus.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosGotFocus()
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.DigitosGotFocusExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosGotFocusExec - corpo de SIGOPTEF.GetDigitos.GotFocus
    * (sigoptef_form_codigo_fonte.txt:1256-1456): conecta ao SiTef e inicia
    * a transacao (so quando a forma de pagamento aceita cartao MAGNETICO -
    * crSigOpFp.lCartao = "N"; para cartao digitado, so envia o numero ja
    * capturado), depois conduz tipo de venda/debito-credito.
    *
    * O identificador de terminal NAO eh recalculado aqui (o legado remonta
    * lcIdTerminal a cada GotFocus): no sistema novo isso ja foi resolvido
    * por CarregarIdentificacaoTerminal() no InicializarForm, e as duas
    * entradas (empresa corrente e caixa recebido no Init) nao mudam
    * durante a vida do dialogo.
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosGotFocusExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_lCartaoMagnetico, loc_lContinuaLaco, loc_nTipo

        *-- txt_4c_Digitos eh o PRIMEIRO controle habilitado/tab-stop da tela
        *-- (txt_4c_Valor eh ReadOnly+TabStop=.F., txt_4c_Cartao nasce
        *-- Enabled=.F.) - o VFP9 lhe da foco automaticamente assim que o
        *-- form fica ativo, disparando este laco so' por o form ter sido
        *-- mostrado, antes de qualquer digitacao do operador. Em modo de
        *-- teste/validacao de UI nao ha terminal SiTef real para conversar
        *-- (this_lSiTefDisponivel fica .F.): sem esta guarda,
        *-- ContinuarSiTef() devolve -1, cai em ProcessarErroTef ->
        *-- EncerrarDialogo() -> Hide(), e o form fica invisivel antes do
        *-- harness conseguir medir .Visible apos o Show(). Mesmo criterio
        *-- de THIS.ValidarParametros()/THIS.CarregarParametrosPagamento().
        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- Transfere a tela para o BO ANTES de conversar com a DLL: no ramo
        *-- de cartao DIGITADO (lCartao <> "N") eh o numero ja na tela que
        *-- vira o primeiro Buffer da passagem - ver FormParaBO.
        THIS.FormParaBO()

        loc_lCartaoMagnetico = (loc_oBO.this_cLCartao = "N")

        IF loc_lCartaoMagnetico
            IF !loc_oBO.ConectarSiTef()
                THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF !loc_oBO.IniciarSiTef(loc_oBO.ObterDataSiTef(), loc_oBO.ObterHoraSiTef())
                THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            loc_oBO.this_nProximoComando = 0
            loc_oBO.this_nTipoCampo      = 0
            loc_oBO.this_nTamanhoMinimo  = 0
            loc_oBO.this_nTamanhoMaximo  = 0
            loc_oBO.this_cBuffer         = SPACE(2000)
            loc_oBO.this_nContinua       = 0
        ELSE
            THIS.txt_4c_Cartao.Enabled = .F.
            loc_oBO.MontarBufferSiTef(loc_oBO.this_cNumeroCartao)
            loc_oBO.this_nContinua = 1000

            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

            IF loc_nRetorno < 0
                loc_oBO.ContinuarSiTef(-1)
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe a Validade" + CHR(13) + "do Cartao"
            THIS.txt_4c_Digitos.BackColor = RGB(255, 255, 255)
        ENDIF

        loc_oBO.ZerarAcumuladoresProtocolo()
        loc_lContinuaLaco = loc_lCartaoMagnetico
        loc_nTipo         = 1

        DO WHILE loc_lContinuaLaco AND THIS.this_cDebCred != "F"
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_nRetorno < 0 AND loc_oBO.this_nProximoComando != 22
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 505
                loc_oBO.this_cBuffer   = ALLTRIM(STR(THIS.this_nNumParcs)) + REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 OR loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                DO CASE
                CASE loc_nTipo = 1
                    loc_oBO.this_cBuffer = IIF(THIS.this_cDebCred = "D", ;
                        IIF(loc_oBO.this_cTcdc = "S", IIF(THIS.this_cDebCred = "O", "5", "4"), "2"), "3") + ;
                        REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                CASE loc_nTipo = 2
                    loc_oBO.this_cBuffer   = "1" + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 3
                    LOOP
                CASE loc_nTipo = 3 AND THIS.this_cDebCred = "C"
                    IF THIS.this_nNumParcs != 1
                        THIS.txt_4c_Digitos.Enabled = .F.
                        THIS.txt_4c_Parcela.Enabled = .T.
                        THIS.txt_4c_Parcela.SetFocus()
                        RETURN
                    ELSE
                        loc_oBO.this_cBuffer   = "1" + REPLICATE(CHR(0), 1999)
                        loc_oBO.this_nContinua = 1000
                    ENDIF
                ENDCASE
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando != 21
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_nRetorno = 0
                THIS.GravarRetornoAprovado(loc_oBO.this_cTipTran, loc_oBO.this_cDataHoraTef, ;
                    loc_oBO.this_cCupomRetorno, THIS.this_cBandeira, loc_oBO.this_cNsu, ;
                    loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, THIS.this_nValPago, loc_oBO.this_cMRet)
            ENDIF
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        THIS.txt_4c_Digitos.BackColor = RGB(255, 255, 255)

        IF loc_lCartaoMagnetico
            THIS.txt_4c_Cartao.Value = "#### #### #### ####"
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4" + CHR(13) + "Ultimos Digitos"
        ENDIF

        THIS.cmg_4c_Saida.Enabled = .T.

        IF loc_oBO.this_nTipoCampo = 514
            THIS.txt_4c_Digitos.Enabled = .F.
            THIS.txt_4c_Codigo.Enabled  = .T.
        ENDIF

        *-- "IF lnretorno<0 / RELEASE WINDOWS" do legado, logo antes do
        *-- ZOrder/Refresh, nao foi transcrito: chegar aqui so acontece com
        *-- loc_nRetorno = 10000 (o IF acima ja devolveu em todo outro
        *-- caso) - inalcancavel.
        THIS.ZOrder(0)
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ParcelaLostFocus - wrapper de SIGOPTEF.GetParcela.LostFocus.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ParcelaLostFocus()
        SET CONFIRM ON

        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.ParcelaLostFocusExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ParcelaLostFocusExec - corpo de SIGOPTEF.GetParcela.LostFocus
    * (sigoptef_form_codigo_fonte.txt:1489-1621): envia a resposta de quem
    * assume o parcelamento ("1"=Lojista/"2"=Administradora) e conduz o
    * terminal ate liberar Text1 (numero de parcelas).
    *
    * ProximoComando=22 tem DUAS saidas (ambas com EXIT, que quebra o DO
    * WHILE independente da profundidade do IF, igual VFP9): a de SENHA/
    * CANC. CLIENTE aborta e marca loc_nRetorno=-8 (nem 0 nem 10000, so
    * ENCERRA sem gravar aprovacao nem falha); a outra aborta, encerra o
    * dialogo e ainda troca o foco para Text1 ANTES do EXIT - preservado
    * mesmo com o form ja oculto (Hide() eh idempotente).
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE ParcelaLostFocusExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor

        loc_cValor = THIS.txt_4c_Parcela.Value
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- Transfere a tela para o BO ANTES do laco (ver FormParaBO).
        THIS.FormParaBO()
        loc_cValor = loc_oBO.this_cRespParcelamento

        loc_oBO.ZerarAcumuladoresProtocolo()

        IF THIS.this_cCodCartaoSiTef = "00125"
            loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                IIF(loc_cValor = "1", "3", "2")) + REPLICATE(CHR(0), 1999)
        ELSE
            loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                IIF(loc_cValor = "1", "2", "3")) + REPLICATE(CHR(0), 1999)
        ENDIF
        loc_oBO.this_nContinua = 1000
        loc_nRetorno           = 10000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            IF UPPER(ALLTRIM(loc_cBuf)) = "SERVICO INDISP."
                loc_nRetorno = -2
            ENDIF

            IF loc_nRetorno < 0
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))

                IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR "CANC. CLIENTE" $ UPPER(ALLTRIM(loc_cBuf))
                    loc_oBO.ContinuarSiTef(-1)
                    loc_nRetorno = -8
                    EXIT
                ENDIF

                loc_oBO.ContinuarSiTef(-1)
                THIS.EncerrarDialogo()
                THIS.txt_4c_Parcela.Enabled = .F.
                THIS.txt_4c_Text1.Enabled   = .T.
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                loc_oBO.this_cBuffer   = IIF(loc_cValor = "2", "3", "2") + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30
                loc_oBO.this_cBuffer   = ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF

            IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_nRetorno = 0
                THIS.GravarRetornoAprovado(loc_oBO.this_cTipTran, loc_oBO.this_cDataHoraTef, ;
                    loc_oBO.this_cCupomRetorno, THIS.this_cBandeira, loc_oBO.this_cNsu, ;
                    loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, THIS.this_nValPago, loc_oBO.this_cMRet)
            ENDIF
            THIS.EncerrarDialogo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CartaoGotFocus - wrapper de SIGOPTEF.GetCartao.GotFocus.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CartaoGotFocus()
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.CartaoGotFocusExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CartaoGotFocusExec - corpo de SIGOPTEF.GetCartao.GotFocus
    * (sigoptef_form_codigo_fonte.txt:1643-1723): conecta e inicia a
    * transacao (cartao digitado manualmente, lCartao <> "N" - o caminho
    * magnetico ja foi tratado em DigitosGotFocusExec) e conduz o
    * debito/credito ate o terminal liberar o proximo campo.
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE CartaoGotFocusExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_nTipo

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- Transfere a tela para o BO ANTES de conversar com a DLL (ver
        *-- FormParaBO). Este handler nao monta Buffer a partir de campo
        *-- digitado - ele CONFIGURA e INICIA a transacao -, mas a partir
        *-- daqui o protocolo decide pelo estado da tela, e o estado tem de
        *-- estar no BO antes da primeira chamada, nao sendo relido depois
        *-- que o laco mexe em .Enabled/.SetFocus.
        THIS.FormParaBO()

        IF !loc_oBO.ConectarSiTef()
            THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        IF !loc_oBO.IniciarSiTef(loc_oBO.ObterDataSiTef(), loc_oBO.ObterHoraSiTef())
            THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        loc_oBO.this_nProximoComando = 0
        loc_oBO.this_nTipoCampo      = 0
        loc_oBO.this_nTamanhoMinimo  = 0
        loc_oBO.this_nTamanhoMaximo  = 0
        loc_oBO.this_cBuffer         = SPACE(2000)
        loc_oBO.this_nContinua       = 0
        loc_oBO.ZerarAcumuladoresProtocolo()
        loc_nTipo = 1

        DO WHILE loc_oBO.this_nProximoComando != 30
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_nRetorno < 0
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nProximoComando = 21
                DO CASE
                CASE loc_nTipo = 1
                    loc_oBO.this_cBuffer = IIF(THIS.this_cDebCred = "D", "2", ;
                        IIF(THIS.this_cDebCred = "C" OR THIS.this_cDebCred = "O", "3", "4")) + ;
                        REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                CASE loc_nTipo = 2
                    loc_oBO.this_cBuffer   = "2" + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 3
                    LOOP
                ENDCASE
            ENDIF

            IF loc_oBO.this_nProximoComando != 21
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno < 0 OR THIS.this_lAbandona
            THIS.EncerrarDialogo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegLostFocus - wrapper de SIGOPTEF.GetCodSeg.LostFocus.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegLostFocus()
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.CodSegLostFocusExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegLostFocusExec - corpo de SIGOPTEF.GetCodSeg.LostFocus
    * (sigoptef_form_codigo_fonte.txt:1757-1911): envia o codigo de
    * seguranca e conduz o terminal ate liberar GetParcela.
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegLostFocusExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor

        SET CONFIRM ON

        loc_cValor = ALLTRIM(THIS.txt_4c_Codigo.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- Transfere a tela para o BO ANTES do laco (ver FormParaBO).
        THIS.FormParaBO()
        loc_cValor = loc_oBO.this_cCodSeguranca

        loc_oBO.ZerarAcumuladoresProtocolo()
        loc_oBO.MontarBufferSiTef(loc_cValor)
        loc_oBO.this_nContinua = 1000
        loc_nRetorno           = 10000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nProximoComando = 20 AND ;
                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            IF loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_nRetorno < 0
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                IF loc_nRetorno != 10000
                    THIS.EncerrarDialogo()
                    RETURN
                ELSE
                    LOOP
                ENDIF
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nProximoComando = 21
                IF THIS.this_cTipPagto != "E" OR THIS.this_nNumParcs = 1
                    IF THIS.this_cCodCartaoSiTef = "00125"
                        loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                            IIF(THIS.this_cTipPagto = "1", "3", "2")) + REPLICATE(CHR(0), 1999)
                    ELSE
                        loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                            IIF(THIS.this_cTipPagto = "1", "2", "3")) + REPLICATE(CHR(0), 1999)
                    ENDIF
                    loc_oBO.this_nContinua = 1000
                ELSE
                    EXIT
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND (THIS.this_cDebCred = "C" OR loc_oBO.this_nTipoCampo = 511)
                loc_oBO.this_cBuffer   = ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
                IF loc_oBO.this_cGarantias = "S"
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                MsgAviso("Entrada do valor de saque (SigCsTef) n" + CHR(227) + "o foi portada" + ;
                    " nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "Assumindo saque de R$ 0,00.", "Saque")
                loc_oBO.this_cBuffer   = "0,00" + REPLICATE(CHR(0), 1996)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30 AND ;
                    loc_oBO.this_nProximoComando != 34
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_nRetorno = 0
                THIS.GravarRetornoAprovado(loc_oBO.this_cTipTran, loc_oBO.this_cDataHoraTef, ;
                    loc_oBO.this_cCupomRetorno, THIS.this_cBandeira, loc_oBO.this_cNsu, ;
                    loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, THIS.this_nValPago, loc_oBO.this_cMRet)
            ENDIF
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Resp." + CHR(13) + "Parcelamento"
        THIS.txt_4c_Digitos.Enabled = .F.
        THIS.txt_4c_Parcela.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text1KeyPress - wrapper de SIGOPTEF.Text1.Valid. BINDEVENT em "Valid"
    * nao dispara em TextBox (regra #3); o Valid legado roda aqui testando
    * ENTER(13)/TAB(9).
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE Text1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.Text1KeyPressExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text1KeyPressExec - corpo de SIGOPTEF.Text1.Valid
    * (sigoptef_form_codigo_fonte.txt:1938-2118): envia o numero de
    * parcelas e conduz o terminal ate aprovar/negar ou liberar o codigo
    * de seguranca. Atualiza this_cParcelasTef ("lnParcs=This.Value" do
    * legado), fonte que MontarRetornoTef usa no retorno ao PDV.
    *
    * No ProximoComando=22 desta variante o legado NAO chama RELEASE
    * WINDOWS (unica das seis cuja mensagem de erro fica na tela com o
    * dialogo aberto) - RETURN sem THIS.EncerrarDialogo(), reproduzindo essa
    * assimetria deliberadamente.
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE Text1KeyPressExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_Text1.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        THIS.txt_4c_Text1.Value = TRANSFORM(VAL(loc_cValor), "@L 99")

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- Transfere a tela para o BO DEPOIS do TRANSFORM acima (eh o valor
        *-- JA formatado "@L 99" que o legado le em "lnParcs = This.Value" e
        *-- no Buffer) e ANTES do laco - ver FormParaBO.
        THIS.FormParaBO()
        loc_cValor = loc_oBO.this_cQtdParcelas

        *-- 1o laco: "DO WHILE ProximoComando <> 30" - literal do legado,
        *-- sem decodificar nada (so interrompe por erro).
        DO WHILE loc_oBO.this_nProximoComando != 30
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

            IF loc_nRetorno < 0
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF
        ENDDO

        *-- "lnParcs = This.Value" do legado.
        THIS.this_cParcelasTef = TRANSFORM(VAL(loc_cValor), "@L 99")

        loc_oBO.ZerarAcumuladoresProtocolo()
        loc_oBO.MontarBufferSiTef(loc_cValor)
        loc_oBO.this_nContinua = 1000
        loc_nRetorno           = 10000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                RETURN
            ENDIF

            IF loc_nRetorno < 0
                THIS.ProcessarErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                IF THIS.this_cTipPagto != "E" OR THIS.this_nNumParcs = 1
                    IF THIS.this_cCodCartaoSiTef = "00125"
                        loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                            IIF(THIS.this_cTipPagto = "1", "3", "2")) + REPLICATE(CHR(0), 1999)
                    ELSE
                        loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
                            IIF(THIS.this_cTipPagto = "1", "2", "3")) + REPLICATE(CHR(0), 1999)
                    ENDIF
                    loc_oBO.this_nContinua = 1000
                ELSE
                    EXIT
                ENDIF
            ENDIF

            IF (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo != 514 AND ;
                    (THIS.this_cDebCred = "C" OR loc_oBO.this_nTipoCampo = 511)) OR ;
                    (THIS.this_cDebCred = "O" AND "NUMERO DE PARCELA" $ UPPER(loc_cBuf))
                loc_oBO.this_cBuffer   = ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
                IF loc_oBO.this_cGarantias = "S"
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                MsgAviso("Entrada do valor de saque (SigCsTef) n" + CHR(227) + "o foi portada" + ;
                    " nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "Assumindo saque de R$ 0,00.", "Saque")
                loc_oBO.this_cBuffer   = "0,00" + REPLICATE(CHR(0), 1996)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
                THIS.txt_4c_Codigo.Enabled = .T.
                EXIT
            ENDIF

            IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_cBuf))
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHoraTef = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                THIS.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando = 22 AND THIS.this_cDebCred = "O"
                loc_oBO.this_cCupomRetorno = loc_cBuf
                loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30 AND ;
                    loc_oBO.this_nProximoComando != 34
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF THIS.this_cDebCred = "O"
                MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
                    CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), "Consulta CDC")
                THIS.GravarRetornoFalha("Consulta CDC Realizada", THIS.this_nValPago)
            ELSE
                IF loc_nRetorno = 0
                    THIS.GravarRetornoAprovado(loc_oBO.this_cTipTran, loc_oBO.this_cDataHoraTef, ;
                        loc_oBO.this_cCupomRetorno, THIS.this_cBandeira, loc_oBO.this_cNsu, ;
                        loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, THIS.this_nValPago, loc_oBO.this_cMRet)
                ENDIF
            ENDIF
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
        ELSE
            IF LEFT(loc_oBO.this_cBuffer, 1) != "1"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Resp." + CHR(13) + "Parcelamento"
            ELSE
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
            ENDIF
        ENDIF

        THIS.txt_4c_Digitos.Enabled = .F.
        IF THIS.this_cDebCred != "D"
            THIS.txt_4c_Parcela.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarRetornoTef - transcricao literal do RETURN de SIGOPTEF.Unload
    * (sigoptef_form_codigo_fonte.txt:796-808):
    *
    *     If ! Type('ThisForm.pcBandeira') = [C] or Empty(ThisForm.pcBandeira)
    *         ThisForm.pcBandeira = [00000]
    *     Endif
    *     If ! Type('ThisForm.lsCartao') = [C] or Empty(ThisForm.lsCartao)
    *         ThisForm.lsCartao = [00000]
    *     Endif
    *     RETURN("0,00/"+lnParcs+"/"+DTOC(DATE()) + ThisForm.pcBandeira + ThisForm.lsCartao)
    *
    * "0,00" eh LITERAL no legado (nao existe lcSaque nesta tela - a
    * entrada de valor de saque do laco de protocolo, quando ocorre, so
    * alimenta o Buffer enviado ao terminal, nunca o retorno ao PDV). O
    * teste de tipo eh sempre verdadeiro aqui (this_cBandeira/
    * this_cCodCartaoSiTef sao Character desde a Fase 3), por isso so o
    * EMPTY() importa. this_cParcelasTef/DTOC(DATE())/bandeira/cartao sao
    * todos properties do FORM - nenhuma dependencia do BO, por isso este
    * metodo fica seguro mesmo depois do Destroy liberar
    * this_oBusinessObject.
    * PUBLIC: lido pelo EncerrarDialogo e pelo Unload.
    *--------------------------------------------------------------------------
    FUNCTION MontarRetornoTef()
        LOCAL loc_cBandeira, loc_cCartao

        loc_cBandeira = IIF(EMPTY(THIS.this_cBandeira), "00000", THIS.this_cBandeira)
        loc_cCartao   = IIF(EMPTY(THIS.this_cCodCartaoSiTef), "00000", THIS.this_cCodCartaoSiTef)

        RETURN "0,00/" + THIS.this_cParcelasTef + "/" + DTOC(DATE()) + loc_cBandeira + loc_cCartao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Unload - migrado de SIGOPTEF.Unload. Em VFP9 o Unload dispara DEPOIS
    * do Destroy, quando this_oBusinessObject ja foi liberado; por isso
    * devolve o valor que EncerrarDialogo ja cacheou em this_cRetornoTef, e
    * so recalcula se por algum caminho ele nao tiver sido preenchido.
    * Atende os dois modos de abertura: "DO FORM ... TO lcRetorno" (le este
    * RETURN) e CREATEOBJECT + Show() (le a property this_cRetornoTef, que
    * sobrevive ao fechamento porque o chamador ainda tem a referencia).
    * Os tres CLEAR DLLS/CHRSAW(2) do Unload legado estao COMENTADOS no SCX
    * (desligados de proposito), portanto nao sao migrados.
    * PUBLIC: evento de form.
    *--------------------------------------------------------------------------
    PROCEDURE Unload()
        IF EMPTY(THIS.this_cRetornoTef)
            THIS.this_cRetornoTef = THIS.MontarRetornoTef()
        ENDIF

        RETURN THIS.this_cRetornoTef
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem com Visible = .F.), recursivo em containers
    * aninhados.
    *
    * Sem lista de excecao: o SCX legado nao tem nenhum container flutuante
    * (cntSombra nao declara Visible, Container1 declara Visible = .T. e
    * nenhum metodo do legado os esconde). Controles que o legado cria
    * DESABILITADOS (GetCartao, GetCodSeg, Text1, Timer1) nao sao afetados -
    * este metodo so mexe em Visible.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o objeto de negocio (que mantem os cursores de
    * SigOpFp/SigCdEmp) e delega a FormBase, que reconstroi os popups do menu
    * principal apos o fechamento de um form modal (regra "Destroy DEVE chamar
    * DODEFAULT()": sem isso o menu do sistema encolhe visualmente).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

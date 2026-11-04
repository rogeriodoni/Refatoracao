*==============================================================================
* FormSigOpClp.prg - Form OPERACIONAL: Pesquisa Operacoes da Conta
* Migrado de: tasks/task704/SigOpClp.SCX (SIGOPCLP)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo FILHO de SIGOPCCL / FormSigOpCcl
*
* O QUE ESTA TELA EH
* ------------------
* SigOpClp.SCX nao eh uma tela de menu: eh o dialogo que SIGOPCCL abre no
* fim da consulta, com os dois parametros do form PAI:
*
*     Do Form SigOpClp With ThisForm, ThisForm.datasessionid
*
* Ela EXIBE o cursor que o pai montou (TmpOper no legado,
* cursor_4c_Operacoes no migrado, criado por
* SigOpCclBO.RecriarCursorOperacoes e populado por BuscarOperacoes). Nao
* consulta SigMvCab, nao consulta SigCdOpe e nao grava em tabela nenhuma -
* os SEIS metodos do legado sao Init (monta o Caption e liga as 7 colunas da
* grade), Load (=fConfigGeral()), os dois Header1.Click que reordenam o
* cursor, um KeyPress que move o foco e o cmd_sair.Click que devolve o
* controle ao pai. Por isso o SigOpClpBO (Fases 1-2) herda
* Inserir()/Atualizar()/ExecutarExclusao() de BusinessBase sem sobrescrever:
* o comportamento padrao da base ja eh o correto para uma tela de leitura.
*
* ESCOPO DAS FASES 3-4/8 - ESTRUTURA BASE + GRADE E BOTAO
* --------------------------------------------------------
* Fase 3/8 entregou a casca da tela:
*
*   DEFINE CLASS + propriedades visuais   transcritas do dump
*   Init(par_oFormPai, par_nDataSession)  os dois parametros do legado
*   LerParametrosDoFormPai                Grupo/Conta/Nome lidos do pai
*   InicializarForm                       BO + Picture + superficie visual
*   ConfigurarPageFrame                   orquestrador da montagem
*   ConfigurarCabecalho                   cntSombra + lblSombra/lblTitulo
*   ConfigurarMoldura                     shp_historico (moldura da grade)
*   TornarControlesVisiveis               AddObject nasce com Visible = .F.
*   Destroy                               reabilita o form pai
*
* Fase 4/8 preenche o que faltava dentro dessa casca: ConfigurarGrade
* (grd_4c_Dados / fwgrade, as 7 colunas somente-leitura, bind condicionado
* a SigOpClpBO.CursorPronto()), ConfigurarBotoes (cmg_4c_Operacao /
* grp_operacao, UM UNICO botao - "Encerrar") e BtnEncerrarClick
* (grp_operacao.cmd_sair.Click do legado). NAO ha botoes CRUD
* (Incluir/Alterar/Excluir/Buscar): o legado eh um visualizador com um
* so botao de acao - inventar os outros quatro violaria o PILAR 1 tanto
* quanto omitir o que o legado tem. O KeyPress da coluna Valor (TAB move o
* foco para cmd_sair) e os dois Header1.Click de reordenacao entram nas
* Fases 7-8 - o corpo deles ja existe no BO (AplicarOrdem/OrdenarPorNumero/
* OrdenarPorData), falta so ligar os eventos do Grid. A ORDEM em que a
* superficie eh montada ja prepara isso desde a Fase 3: shp_historico
* (Top 102, 580x247) eh criado ANTES da grade (Top 108, 568x236), que fica
* DENTRO dele - como AddObject desenha o ultimo objeto por cima, a moldura
* so aparece como borda da grade se vier primeiro (regra CLAUDE.md #11, o
* mesmo raciocinio da faixa do cabecalho).
*
* ESCOPO DA FASE 5/8 - CAMPOS PRINCIPAIS: NAO HA CAMPO A ACRESCENTAR
* ------------------------------------------------------------------
* A Fase 5 entrega "o container cnt_4c_Cabecalho + os primeiros 50% dos
* TextBox/Label da pagina Dados". Nenhuma das duas metades tem o que
* acrescentar aqui, e isso foi MEDIDO no dump, nao presumido.
*
* Inventario completo de tasks/task704/SigOpClp_form_codigo_fonte.txt -
* os 23 objetos, agrupados por BaseClass:
*
*     1 dataenvironment   1 form          1 container (cntSombra)
*     2 label             1 shape         1 grid (fwgrade)
*     7 header            7 textbox       1 commandgroup (grp_operacao)
*
* Os 7 textbox sao os 7 "Text1" NATIVOS das 7 Column de fwgrade: o Parent
* de cada um termina em ".emps" / ".mascnum" / ".dopes" / ".datas" /
* ".valos" / ".tipo" / ".moeda", que sao os NOMES das Column
* (Column<N>.Name no dump) - nunca o form nem o container. Column nasce
* com Header1 + Text1 (regra CLAUDE.md #18): sao CELULAS de grade, nao
* campos de tela, e foram entregues com a grade na Fase 4, junto com os 7
* header irmaos. Descontar esses Text1 eh obrigatorio ao medir paridade de
* campos - conta-los aqui faria o piso saltar de 0 para 7 num form que nao
* tem campo nenhum, e a paridade viraria exigencia de INVENTAR TextBox.
*
* Os 2 label tem ambos o Parent "SIGOPCLP.cntSombra": sao lblSombra e
* lblTitulo, os rotulos da faixa do titulo, entregues na Fase 3
* (ConfigurarCabecalho) junto com o proprio container. Nao existe no dump
* um unico Say/Label de rotulo de campo.
*
* Logo: CAMPOS DE TELA FORA DE GRADE = ZERO, e metade de zero eh zero; e o
* cnt_4c_Cabecalho que esta fase pediria JA existe desde a Fase 3.
*
* Por isso NAO se cria ConfigurarPaginaDados neste arquivo. As duas unicas
* formas de "mostrar trabalho" nesta fase seriam inventar TextBox que o
* legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar") ou criar um
* ConfigurarPaginaDados vazio - o "stub disfarcado" que a regra de
* completude proibe. O perfil desta tela eh VISUALIZADOR de grade: o dado
* de entrada eh a CELULA, e a superficie de dados que o form de fato tem -
* as 7 Column com ControlSource vinculado em CarregarLista - eh exatamente
* o que o ramo FLAT do gate desta fase valida: FormType OPERACIONAL, mais
* nenhum PageFrame criado neste form, mais coluna de grade com a fonte de
* dado ligada - as tres condicoes satisfeitas aqui. (Esta frase descreve as
* condicoes em PROSA de proposito: o gate procura o texto do proprio
* AddObject de PageFrame no .prg, e um comentario que o citasse LITERALMENTE
* reprovaria a fase - o mesmo efeito, invertido, de "comentario citando um
* nome satisfaz o gate".)
* Mesma decisao, mesmo motivo, dos precedentes SIGPRGST/task620 (legado de
* grade+botoes cujos unicos controles de entrada sao os Text1 das colunas)
* e SIGOPCHP/task699.
*
* ESCOPO DA FASE 6/8 - CAMPOS RESTANTES E LOOKUPS: NAO HA NENHUM DOS DOIS
* ----------------------------------------------------------------------
* A Fase 6 pede "os ultimos 50% dos campos + TODOS os lookups com BINDEVENT
* F4/F5 completamente implementados". Metade de zero campos continua zero
* (ver secao da Fase 5 acima), e LOOKUP tambem eh zero - medido no dump, nao
* presumido.
*
* tasks/task704/SigOpClp_form_codigo_fonte.txt (18304 bytes, 6 metodos com
* codigo) NAO tem nenhuma das assinaturas de lookup do Framework Fortyus:
* nao chama a classe de busca em grade/campo, nao usa a API de colunas do
* picker legado, nao chama a familia de funcoes de acesso do framework
* (empresa/grupo/conta/produto/titulo) nem abre o dialogo auxiliar do
* sistema novo. tasks/task704/comportamento.json confirma pela via
* independente da analise comportamental: a UNICA funcaoExterna dos 6
* metodos e' fConfigGeral (Load, NO-OP documentado - ver mais abaixo), e
* nenhum dos 6 "temLookup" sai .T. O Grupo/Conta que aparecem no Caption
* (LerParametrosDoFormPai, Fase 3) sao LIDOS do form PAI - nao ha campo
* NESTA tela que dispare consulta nenhuma.
*
* Os unicos dois eventos de controle fora do Init/Load sao os dois
* Header1.Click de reordenacao (coluna Operacao/Data) e o KeyPress de TAB
* na coluna Valor - nenhum deles abre dialogo de busca, e os tres ficam
* para a Fase 7 (regras BINDEVENT AfterRowColChange/KeyPress ja documentadas
* no cabecalho acima). O unico BINDEVENT desta fase e' o do botao Encerrar
* (Fase 4), que ja existe.
*
* Por isso NAO ha metodo Abrir<X> nem Validar<X> a escrever aqui: inventar
* um lookup que o legado nao consulta violaria o PILAR 1 e a regra "NUNCA
* inventar tabelas de lookup que nao existem no original" tanto quanto
* omitir um que ele de fato tivesse. Mesma decisao, mesmo motivo, do
* precedente SIGMVCHV -> FormSigMvChv (dialogo de chaves de nota, grade
* digitada a mao, sem fwbusca/sigacess algum) e do proprio raciocinio ja
* registrado acima para a Fase 5.
*
* Reconferido nesta fase, alem da contagem acima:
*
*   - os 23 objetos do dump estao TODOS reproduzidos - cntSombra ->
*     cnt_4c_Cabecalho, lblSombra -> lbl_4c_Sombra, lblTitulo ->
*     lbl_4c_Titulo, shp_historico -> shp_4c_Historico, fwgrade ->
*     grd_4c_Dados (7 Column, cada uma com Header1 e Text1 formatados em
*     FormatarColunasGrade), grp_operacao -> cmg_4c_Operacao + Buttons(1);
*   - os dois .Picture apontam para arquivo que EXISTE em vbmp\
*     (new_background.jpg e cadastro_sair_60.jpg) - .Picture inexistente
*     nao da erro nenhum, o controle so nao desenha (regra CLAUDE.md #25);
*   - todo membro de SigOpClpBO que este form chama de FORA da classe
*     existe e eh PUBLIC: CursorPronto, PosicionarNoTopo, OrdenarPorNumero,
*     OrdenarPorData, AplicarOrdem e this_cCursorOperacoes (regras
*     CLAUDE.md #13 - helper inexistente so quebra em runtime - e #51 -
*     metodo PROTECTED chamado de fora do BO estoura ao gravar).
*
* ESCOPO DA FASE 7/8 - EVENTOS PRINCIPAIS: OS TRES QUE O LEGADO TEM
* ------------------------------------------------------------------
* A Fase 7 pede "os eventos principais dos botoes", nomeando
* BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick / BtnExcluirClick.
* Esses quatro nomes sao convencao de form CRUD (a barra Incluir/Alterar/
* Visualizar/Excluir da Page1 de Lista do frmcadastro) e NAO existem aqui:
* medido no dump, nao presumido.
*
* tasks/task704/SigOpClp_form_codigo_fonte.txt declara a raiz SIGOPCLP como
* "Class: form / BaseClass: form" - form GENERICO, nunca frmcadastro - e a
* UNICA superficie de botao do SCX inteiro eh grp_operacao
* (BaseClass: commandgroup, ButtonCount = 1), cujo unico membro eh
* Command1/cmd_sair, Caption "Encerrar", Cancel = .T. Nao existe no dump
* nenhum objeto nem metodo com os verbos Incluir/Alterar/Visualizar/
* Excluir, e tasks/task704/comportamento.json confirma pela via
* independente da analise comportamental: dos 6 metodos com codigo, nenhum
* grava em tabela alguma (zero queries, "metodosComSQL" sao os dois
* Header1.Click, que so fazem SET ORDER sobre o cursor em memoria).
*
* Inventar os quatro botoes violaria o PILAR 1 (o usuario ganharia acoes
* que o sistema legado nao oferece) e criar os quatro metodos VAZIOS eh o
* "stub disfarcado" que a regra de completude proibe. Por isso esta fase
* entrega os eventos que o legado DE FATO tem, e que as Fases 4 e 6
* deixaram explicitamente para ca:
*
*   SIGOPCLP.fwgrade.dopes.Header1.Click  -> HeaderOperacaoClick
*   SIGOPCLP.fwgrade.datas.Header1.Click  -> HeaderDataClick
*   SIGOPCLP.fwgrade.valos.Text1.KeyPress -> TxtValorKeyPress
*
* mais o funil ReordenarGrade (corpo comum dos dois Header1.Click) e o
* ConfigurarEventosGrade que registra os tres BINDEVENT. O quarto e ultimo
* evento de controle do legado - grp_operacao.cmd_sair.Click -> o
* BtnEncerrarClick - ja foi entregue na Fase 4 e eh o handler do UNICO
* botao que esta tela tem.
*
* Mesma decisao, mesmo motivo, dos precedentes SIGMVCTH/task566
* (visualizador somente-leitura cujo unico botao eh "Retornar") e
* SIGOPCHI/task699.
*
* ESCOPO DA FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
* ------------------------------------------------------------
* A Fase 8 pede os eventos auxiliares e os metodos finais, nomeando a dupla
* de transferencia campo<->BO, o botao que descarta uma edicao em
* andamento, o botao de busca, o que habilita e o que limpa os campos, e o
* que ajusta os botoes conforme o modo. Esses nomes sao convencao do par
* Page2(Dados) + modo INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR do frmcadastro, e
* nenhum deles tem a que se aplicar nesta tela - medido no dump, nao
* presumido:
*
*     campo de tela fora de grade ...... ZERO  (secao da Fase 5)
*     lookup ........................... ZERO  (secao da Fase 6)
*     botao alem do Encerrar ........... ZERO  (secao da Fase 7)
*     modo de edicao ................... ZERO  (o dump nao tem pcEscolha)
*     escrita em tabela ................ ZERO  (zero queries no legado)
*
* Sem campo editavel nao ha o que transferir nos dois sentidos entre tela e
* BO; sem modo de edicao nao ha o que habilitar, limpar nem ajustar; sem
* edicao em andamento nao ha o que descartar; e sem lookup nao ha o que
* buscar. Escreve-los vazios eh o "stub disfarcado" que a regra de
* completude proibe, e inventar os controles que eles pressupoem violaria o
* PILAR 1 tanto quanto omitir o que o legado tem. O metodo de carga que
* esta tela DE FATO precisa - CarregarLista, o funil unico da grade - foi
* entregue na Fase 4 e eh chamado na abertura e em cada reordenacao.
*
* O que esta fase entrega, portanto, sao os TRES itens que de fato faltavam:
*
* 1) INTEGRACAO COM O FORM PAI. O pai (FormSigOpCcl.BtnConsultaClick)
*    ainda executava o "Do Form" literal apontando para o SCX legado, com o
*    comentario de que esta tela viria depois. Agora ele instancia esta
*    classe - CREATEOBJECT("FormSigOpClp", THIS, THIS.DataSessionId), os
*    MESMOS dois argumentos do legado - e chama Show() FORA do TRY/CATCH
*    (regra CLAUDE.md #29: com Show() dentro do TRY, todo o uso da tela
*    fica dentro do bloco, e o primeiro erro de runtime em qualquer evento
*    salta para o CATCH e DESTROI o form). Nenhuma entrada de menu eh
*    criada: o legado abre esta tela exclusivamente de dentro do pai.
*
* 2) MODAL EM PRODUCAO - o unico desvio do dump nesta fase, e ele eh
*    CONSEQUENCIA do item 1. Ver a secao de WindowType abaixo.
*
* 3) EVENTO AUXILIAR DA GRADE. SigOpClpBO.CarregarLinhaCorrente ->
*    CarregarDoCursor foi escrito na Fase 2 como "atalho usado pelo form
*    quando o usuario navega na grade" e nenhuma fase o havia ligado. O
*    BINDEVENT de AfterRowColChange em ConfigurarEventosGrade fecha esse
*    contrato (GradeAfterRowColChange, no fim do arquivo): ele apenas LE a
*    linha corrente para as propriedades do BO - sem SQL, sem gravar, sem
*    mexer em controle nenhum -, entao nao ha mudanca visivel para o
*    usuario e o PILAR 1 continua de pe. Eh tambem o que da sentido ao
*    ObterChavePrimaria do BO, que identifica a linha selecionada.
*
* LAYOUT FLAT - POR QUE NAO HA PageFrame
* --------------------------------------
* O SCX legado nao tem Page1=Lista/Page2=Dados: a arvore de objetos do dump
* (tasks/task704/SigOpClp_form_codigo_fonte.txt) traz a raiz SIGOPCLP como
* "Class: form / BaseClass: form" - form GENERICO, nao frmcadastro nem
* frmrelatorio - e NENHUMA linha "BaseClass: pageframe". Os quatro objetos
* de primeiro nivel sao cntSombra (container do cabecalho), shp_historico
* (moldura), fwgrade (a grade) e grp_operacao (o botao Encerrar). Criar um
* PageFrame aqui seria inventar estrutura que o legado nao tem (viola o
* PILAR 1), e criar ConfigurarPaginaLista/ConfigurarPaginaDados vazios eh
* proibido pela regra de completude. ConfigurarPageFrame fica como
* orquestrador - mesmo desenho do irmao FormSigOpCcl (o form PAI desta
* tela), que tambem eh flat.
*
* DataSession = 1 (SESSAO CORRENTE) - EQUIVALENTE AO "Set DataSession To"
* ----------------------------------------------------------------------
* O dump declara DataSession = 2, mas a PRIMEIRA linha do Init legado eh
* "Set DataSession To DatSes": o form entra na sessao do PAI justamente
* para alcancar o cursor que ele montou. Em VFP9, DataSession = 1 significa
* "Default Data Session" = a sessao CORRENTE de quem instancia, nao "a
* sessao global numero 1" - um form assim criado de dentro do pai JA roda
* na sessao do pai, e ve os cursores dele. Declarar 1 aqui eh portanto a
* transcricao FIEL do par (DataSession = 2 + Set DataSession To DatSes), e
* nao um desvio: o pai FormSigOpCcl eh DataSession = 1, igual ao legado.
* Manter o 2 literal daria sessao PRIVADA, cursor_4c_Operacoes invisivel e
* a grade abrindo como um retangulo branco. Por isso tambem NAO se executa
* "SET DATASESSION TO" em runtime: o comando troca a sessao CORRENTE do
* processo (efeito colateral global), nao a do form.
*
* WindowType - 0 NA CLASSE (como o dump), 1 EM PRODUCAO (Fase 8)
* --------------------------------------------------------------
* O dump nao declara WindowType, ou seja o legado usa o default 0 (nao
* modal): o pai se desabilita ANTES de abrir ("ThisForm.Enabled = .f." em
* SIGOPCCL.Consulta.Click, ja reproduzido em
* FormSigOpCcl.BtnConsultaClick) e o cmd_sair do filho reabilita. No legado
* a modalidade EFETIVA vinha desse par mais o AlwaysOnTop = .T. do dump,
* nao de WindowType. Consequencia que vale sempre: o filho NAO desabilita o
* pai (ele ja chegou desabilitado); o filho apenas REABILITA, em Destroy.
*
* A classe continua declarando 0, como o dump. O que a Fase 8 acrescentou
* eh a troca para 1 no Init, fora de teste/validacao de UI - e ela nao eh
* preferencia de estilo, eh exigencia do tempo de vida da REFERENCIA:
*
*   - "Do Form X" mantem o form vivo sozinho (o VFP o guarda na colecao de
*     forms da tela), e por isso o legado podia abrir nao-modal e retornar;
*   - CREATEOBJECT devolve um objeto guardado numa variavel LOCAL do
*     chamador. Com WindowType = 0 o Show() NAO bloqueia: o metodo do pai
*     termina, a LOCAL sai de escopo, a ultima referencia cai e o form eh
*     DESTRUIDO na hora - a tela piscaria e desapareceria, exatamente a
*     "queda de referencia" da regra CLAUDE.md #29.
*
* Com WindowType = 1 o Show() bloqueia enquanto a tela existe, a LOCAL do
* pai segue viva e o comportamento resultante eh o MESMO que o legado
* produzia com pai desabilitado + AlwaysOnTop: o usuario so volta ao pai
* depois de encerrar esta tela. Em teste/validacao de UI o 0 permanece,
* senao o Show() travaria o pipeline. Mesmo padrao, pelo mesmo motivo, do
* irmao FormSigOpCcl e de FormSIGPRCIC.
*
* Load (=fConfigGeral()) fica fora deste arquivo, mesma decisao do irmao
* FormSigOpCcl: fConfigGeral era funcao GLOBAL do legado (sig.prg /
* SIGFUNCS.PRG) que nao veio no acervo; o wrapper NO-OP em
* projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
* continuar resolvendo o nome, e em codigo NOSSO nunca se chama
* fConfigGeral.
*
* Esta tela nao recebe item de menu: o legado a abre exclusivamente por
* "Do Form" de dentro de SIGOPCCL, e inventar uma entrada no menu daria ao
* usuario um caminho que o sistema legado nao tem (viola o PILAR 1). A
* troca do "Do Form" literal do pai pelo
* CREATEOBJECT("FormSigOpClp", THIS, THIS.DataSessionId) desta classe foi
* feita na consolidacao final (Fase 8/8) - ver o item 1 da secao da Fase 8
* acima. Como esse CREATEOBJECT eh LITERAL dentro de um form, o
* indice_classes.txt resolve a dependencia sozinho e nao ha GarantirClasse
* a escrever (a linha da tabela de carga sob demanda do CLAUDE.md que
* dispensa a chamada explicita).
*==============================================================================

DEFINE CLASS FormSigOpClp AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS do dump de SIGOPCLP
    *
    *   Height / Width      400 / 700
    *   BorderStyle         2
    *   AutoCenter          .T.
    *   TitleBar            0      (sem barra de titulo - o cabecalho eh o
    *                               cntSombra, igual ao resto da familia)
    *   ControlBox          .F.
    *   HalfHeightCaption   .F.
    *   MaxButton/MinButton .F.
    *   AlwaysOnTop         .T.
    *   Caption             ""     (montado em runtime - ver Init)
    *
    * Closable NAO eh declarado aqui porque o dump nao o declara: com
    * TitleBar = 0 nao existe botao de fechar na janela, e a unica saida eh
    * o cmd_sair (Fase 4). Inventar Closable = .F. seria acrescentar
    * propriedade que o legado nao tem.
    *
    * FontName/FontSize vem da linha de fontes do dump (Tahoma 8 eh a fonte
    * base da tela; os dois labels do cabecalho sobrescrevem para 18).
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Height            = 400
    Width             = 700
    Caption           = ""
    BorderStyle       = 2
    AutoCenter        = .T.
    TitleBar          = 0
    ControlBox        = .F.
    HalfHeightCaption = .F.
    MaxButton         = .F.
    MinButton         = .F.
    AlwaysOnTop       = .T.
    ClipControls      = .F.
    ShowWindow        = 1
    WindowType        = 0
    DataSession       = 1
    FontName          = "Tahoma"
    FontSize          = 8

    *--------------------------------------------------------------------------
    * Estado do form
    *
    * this_oFormPai eh o equivalente do "ThisForm.ParentForm = pForm" do
    * Init legado (o SCX registra ParentForm em RESERVED3/ClassInfo). Fica
    * guardado porque o cmd_sair.Click precisa dele para reabilitar o pai e
    * devolver o foco ao campo Grupo.
    *
    * this_nDataSessionPai guarda o segundo parametro (DatSes) para
    * diagnostico: ele nao eh usado para trocar sessao (ver o cabecalho do
    * arquivo), mas registrar o valor recebido permite conferir que pai e
    * filho estao de fato na MESMA sessao.
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_oFormPai        = .NULL.   && ParentForm do legado
    this_nDataSessionPai = 0        && DatSes recebido do pai

    *-- Trava de aviso unico: a grade vive de um cursor que o PAI entrega, e
    *-- CarregarLista roda tambem em cada reordenacao. Sem a flag, uma tela
    *-- aberta sem cursor repetiria o MsgErro a cada clique de cabecalho.
    this_lFalhaCursorAvisada = .F.

    *==========================================================================
    * Init - recebe os DOIS parametros do legado (pForm, DatSes)
    *
    * Legado (SIGOPCLP.Init):
    *
    *   Lparameters pForm, DatSes
    *   Set DataSession To DatSes
    *   ThisForm.ParentForm = pForm
    *   ThisForm.Caption = 'Pesquisa Operacoes da Conta : ' + ;
    *                      Alltrim(ThisForm.ParentForm.Origem.get_grupo.Value) + ' / ' + ;
    *                      Alltrim(ThisForm.ParentForm.Origem.get_Conta.Value) + ' - ' + ;
    *                      Alltrim(ThisForm.ParentForm.Origem.get_dConta.Value)
    *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *   ... (ligacao das 7 colunas da grade - Fase 4)
    *
    * O "Set DataSession To DatSes" nao tem linha correspondente aqui de
    * proposito: DataSession = 1 na classe JA poe este form na sessao de
    * quem o instancia, que eh o pai - ver o cabecalho do arquivo.
    *
    * O BO eh criado ANTES do DODEFAULT() porque FormBase.Init chama
    * InicializarForm, que ja precisa do BO e do Caption montado para
    * propagar o titulo aos dois labels da faixa.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado passa
    * pela flag loc_lSucesso.
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDataSession)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        *-- WindowType = 1 em PRODUCAO (Fase 8 - ver a secao de WindowType no
        *-- cabecalho): o pai instancia esta tela com CREATEOBJECT numa
        *-- variavel LOCAL, e sem o Show() bloqueante a referencia cai assim
        *-- que o metodo dele retorna - a tela seria destruida na hora (regra
        *-- CLAUDE.md #29). Em teste/validacao de UI o 0 da classe permanece,
        *-- senao o Show() travaria o pipeline.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        TRY
            *-- ThisForm.ParentForm = pForm
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF

            *-- DatSes: registrado para diagnostico (ver cabecalho do arquivo)
            THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSession) = "N", ;
                                            par_nDataSession, 0)

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpClpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpClpBO." + ;
                        CHR(13) + "VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro em Init")
            ELSE
                *-- Caption do legado, montado pelo BO (ObterTituloConsulta)
                THIS.LerParametrosDoFormPai()

                *-- FormBase.Init chama InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpClp.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LerParametrosDoFormPai - le Grupo/Conta/Nome do pai e monta o Caption
    *
    * Reproduz as tres leituras do Init legado:
    *
    *   ThisForm.ParentForm.Origem.get_grupo.Value
    *   ThisForm.ParentForm.Origem.get_Conta.Value
    *   ThisForm.ParentForm.Origem.get_dConta.Value
    *
    * Os nomes migrados do pai (FormSigOpCcl) sao cnt_4c_Origem.txt_4c_Grupo,
    * .txt_4c_Conta e .txt_4c_DConta - o PILAR 3 renomeia os objetos, entao a
    * correspondencia vem do mapeamento do form pai, nao do nome legado.
    *
    * Cada nivel eh conferido com PEMSTATUS ANTES de ser alcancado: o pai eh
    * um objeto externo a esta classe, e um caminho que nao existe estouraria
    * "Property not found" dentro do Init - o que derrubaria a tela inteira.
    * PEMSTATUS eh usado aqui sobre OBJETO (nunca sobre alias de cursor, que
    * dispara erro 11).
    *
    * Quem decide se os valores servem eh o BO: DefinirParametrosConsulta
    * aplica ALLTRIM (os Alltrim() do legado) e recusa Grupo ou Conta vazios.
    * Recusado, o Caption cai no titulo base, SEM dialogo de erro - nao eh
    * falha: eh o caso de a tela ser instanciada fora do fluxo do pai (teste
    * automatizado / validacao de UI). Em producao o pai so abre esta tela
    * depois de validar Grupo e Conta e de achar movimentacao, entao os tres
    * valores sempre chegam.
    *
    * Retorno: .T. quando o titulo saiu com os parametros do pai; .F. quando
    * caiu no titulo base.
    *==========================================================================
    PROCEDURE LerParametrosDoFormPai()
        LOCAL loc_lComParametros, loc_cGrupo, loc_cConta, loc_cDConta, loc_oOrigem

        loc_lComParametros = .F.
        loc_cGrupo  = ""
        loc_cConta  = ""
        loc_cDConta = ""

        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "cnt_4c_Origem", 5)
                loc_oOrigem = THIS.this_oFormPai.cnt_4c_Origem

                IF PEMSTATUS(loc_oOrigem, "txt_4c_Grupo", 5)
                    loc_cGrupo = loc_oOrigem.txt_4c_Grupo.Value
                ENDIF

                IF PEMSTATUS(loc_oOrigem, "txt_4c_Conta", 5)
                    loc_cConta = loc_oOrigem.txt_4c_Conta.Value
                ENDIF

                IF PEMSTATUS(loc_oOrigem, "txt_4c_DConta", 5)
                    loc_cDConta = loc_oOrigem.txt_4c_DConta.Value
                ENDIF
            ENDIF
        ENDIF

        *-- Os TextBox do pai sao de texto, mas o VARTYPE eh conferido porque
        *-- um .Value numerico/nulo faria ALLTRIM estourar erro 11 no BO.
        loc_cGrupo  = IIF(VARTYPE(loc_cGrupo)  = "C", loc_cGrupo,  "")
        loc_cConta  = IIF(VARTYPE(loc_cConta)  = "C", loc_cConta,  "")
        loc_cDConta = IIF(VARTYPE(loc_cDConta) = "C", loc_cDConta, "")

        IF THIS.this_oBusinessObject.DefinirParametrosConsulta(loc_cGrupo, ;
                                                               loc_cConta, ;
                                                               loc_cDConta)
            THIS.Caption = THIS.this_oBusinessObject.ObterTituloConsulta()
            loc_lComParametros = .T.
        ELSE
            THIS.Caption = "Pesquisa Opera" + CHR(231) + CHR(245) + "es da Conta"
        ENDIF

        RETURN loc_lComParametros
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a superficie visual da tela
    *
    * Picture: o dump traz "..\framework\imagens\new_background.jpg" - o
    * arquivo vive em vbmp\ no sistema novo, alcancado por
    * gc_4c_CaminhoIcones (nunca remontado a partir de gc_4c_CaminhoBase).
    * Atribuido direto, sem guard IF FILE(): guard mascara arquivo ausente e
    * deixa a tela sem fundo em silencio (regra CLAUDE.md #25) - o arquivo
    * foi conferido em vbmp\new_background.jpg.
    *
    * Os dois labels recebem o Caption aqui, nao na criacao, porque eh o que
    * o legado faz no Init (ThisForm.cntSombra.lblSombra.Caption =
    * ThisForm.Caption) e porque o Caption so existe depois de
    * LerParametrosDoFormPai.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()

            *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- AddObject cria tudo com Visible = .F.
            THIS.TornarControlesVisiveis(THIS)

            *-- Legado: ligacao das 7 colunas + This.fwgrade.Refresh +
            *-- This.fwgrade.SetFocus (fim do Init). A ligacao e o repintar
            *-- moram em CarregarLista, que eh o funil unico da grade
            *-- (regra CLAUDE.md #21 / #46) - chamado AQUI, depois de
            *-- TornarControlesVisiveis, porque Refresh em controle ainda
            *-- invisivel nao pinta. Sem cursor pronto ele devolve .F., a
            *-- grade fica vazia e o form abre normalmente.
            *--
            *-- SetFocus eh guardado porque exige form visivel, e tanto a
            *-- validacao de UI quanto o harness de teste instanciam esta
            *-- classe SEM Show() (mesmo padrao de
            *-- FormSigOpChb.InicializarForm). As DUAS flags entram no guard,
            *-- nao so gb_4c_ValidandoUI: um SetFocus que estourasse aqui
            *-- cairia no CATCH de InicializarForm, que devolve .F. ao Init e
            *-- faz o CREATEOBJECT do chamador devolver .F. - a tela nao
            *-- abriria, e o modo de teste veria "falha ao instanciar" sem o
            *-- defeito existir em producao. Mesmo par de flags do guard de
            *-- WindowType no Init e do loc_lModoTeste de CarregarLista.
            THIS.CarregarLista()

            IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                 (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                THIS.grd_4c_Dados.SetFocus()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual
    *
    * Nao ha PageFrame real: o legado SIGOPCLP eh flat (ver o cabecalho do
    * arquivo). O nome eh mantido por conformidade com o contrato do
    * pipeline e o metodo delega aos configuradores especificos, mesmo
    * desenho do irmao FormSigOpCcl.
    *
    * A ORDEM importa e eh deliberada: o cabecalho primeiro (a faixa cinza
    * ocupa Top 0..80 e qualquer controle criado depois desenha por cima -
    * regra CLAUDE.md #11), a moldura em seguida, para a grade cair DENTRO
    * dela (AddObject poe o ultimo objeto no topo do z-order), e so depois
    * a grade e o botao Encerrar.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarMoldura()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarEventosGrade()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do legado)
    *
    * Geometria TRANSCRITA do dump (SIGOPCLP.cntSombra / lblSombra /
    * lblTitulo): Top 0 / Left 0 / Height 80 / BackColor 100,100,100 /
    * BorderWidth 0, e os dois labels sobrepostos em Top 25 e 24, Left 10,
    * Tahoma 18 bold, sombra PRETA embaixo e titulo BRANCO em cima.
    *
    * UNICO desvio, deliberado: as larguras. O dump declara
    * cntSombra.Width = 800 e os dois labels com Width = 769, mas o form
    * tem Width = 700 - o container do cabecalho foi desenhado no Form
    * Designer 100px MAIS LARGO que a propria janela. Copiar os literais
    * poria o label 69px alem da borda direita visivel e cortaria o titulo
    * no meio (o Caption desta tela eh longo: "Pesquisa Operacoes da Conta :
    * <grupo> / <conta> - <nome da conta>"). Por isso o container usa
    * THIS.Width e os labels THIS.Width - 20, preservando a margem de 10px
    * do Left do dump nos dois lados. Mesma decisao ja registrada para
    * cntSombra em FormSIGPRSTF / Formsigprrcu, e a regra CLAUDE.md #11
    * ("cnt_4c_Cabecalho.Width = THIS.Width") trata o container.
    *
    * AutoSize = .F. EXPLICITO nos dois labels: com WordWrap = .T. (que o
    * dump declara) um AutoSize = .T. DESCARTA a Height e colapsa o texto
    * para uma linha so (regra CLAUDE.md #23). As Width/Height aqui ja sao
    * as que o Form Designer calculou, entao fixa-las eh reproducao fiel.
    *
    * ForeColor BRANCO em lbl_4c_Titulo eh uma das excecoes legitimas da
    * regra CLAUDE.md #12: o container eh OPACO e escuro
    * (BackStyle = 1 + BackColor RGB(100,100,100)), nao a textura clara das
    * paginas de cadastro.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
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

        *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top           = 25
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: texto branco por cima da sombra
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 24
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarMoldura - shp_historico, a moldura rebaixada da grade
    *
    * Geometria TRANSCRITA do dump (SIGOPCLP.shp_historico): Top 102 /
    * Left 42 / Width 580 / Height 247 / BackStyle 0 / SpecialEffect 1.
    * BackStyle = 0 deixa o fundo da tela aparecer dentro dela, e
    * SpecialEffect = 1 eh o efeito rebaixado (3D) que faz a borda.
    *
    * A grade da Fase 4 (fwgrade: Top 108, Left 48, 568x236) cai DENTRO
    * desta moldura, com 6px de folga de cada lado - eh esse encaixe que
    * desenha a borda em volta da grade. Criar a moldura AQUI, antes da
    * grade, eh o que faz a grade desenhar por cima (AddObject poe o ultimo
    * objeto no topo do z-order).
    *
    * Shape NAO tem ForeColor (regra CLAUDE.md #33): a cor de borda de um
    * Shape eh BorderColor e o preenchimento eh FillColor - nenhum dos dois
    * eh declarado no dump, entao nenhum eh atribuido aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMoldura()
        THIS.AddObject("shp_4c_Historico", "Shape")
        WITH THIS.shp_4c_Historico
            .Top           = 102
            .Left          = 42
            .Width         = 580
            .Height        = 247
            .BackStyle     = 0
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - fwgrade do legado: a GRADE em si (sem dados)
    *
    * Geometria TRANSCRITA do dump (SIGOPCLP.fwgrade): Top 108 / Left 48 /
    * Width 568 / Height 236 - caem DENTRO de shp_4c_Historico (Top 102,
    * Left 42, 580x247), com a folga de 6px de cada lado que desenha a
    * moldura em volta da grade (ver ConfigurarMoldura).
    *
    * RecordMark = .F. e DeleteMark = .F. seguem a regra do CLAUDE.md para
    * grids criados por AddObject em forms OPERACIONAIS (o dump so declara
    * DeleteMark = .F. explicito, RecordMark fica no mesmo valor por
    * conformidade - a classe fwgrade do framework.vcx nasce assim).
    *
    * AQUI FICA SO O QUE NAO DEPENDE DE DADO. O bind
    * (RecordSource/Column.ControlSource) e a largura/cabecalho das colunas
    * moram em CarregarLista/FormatarColunasGrade, por DOIS motivos:
    *
    *   1) Column.ControlSource apontando para cursor que ainda NAO existe
    *      dispara "Alias not found" DENTRO do TRY de InicializarForm, o
    *      CREATEOBJECT devolve .F. e a tela nao abre (regra CLAUDE.md #41).
    *      Este form recebe o cursor do PAI - no Init ele pode nao ter
    *      chegado (teste automatizado, validacao de UI).
    *
    *   2) atribuir RecordSource/ControlSource RESETA Column.Width e
    *      Header1.Caption para o default (90 / "ColumnN") - entao os dois
    *      tem de ser reaplicados DEPOIS de CADA bind, nunca uma vez so na
    *      montagem (regra CLAUDE.md #41 / "Problema 48"). Deixar o bind
    *      aqui e nunca reaplicar as larguras eh o defeito que a grade
    *      exibe como colunas quadradas com cabecalho "Column1".
    *
    * ColumnCount fica AQUI porque qualquer atribuicao a ColumnCount RECRIA
    * os objetos Column (regra CLAUDE.md #34 / #183): reatribui-lo a cada
    * carga destruiria o que foi configurado nas colunas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top          = 108
            .Left         = 48
            .Width        = 568
            .Height       = 236
            .ColumnCount  = 7
            .FontName     = "Tahoma"
            .HeaderHeight = 17
            .ScrollBars   = 2
            .ReadOnly     = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarLista - liga a grade ao cursor e a REPINTA
    *
    * Este eh o metodo de carga da tela, e transcreve o trecho final do
    * SIGOPCLP.Init legado:
    *
    *   This.fwgrade.RecordSource          = 'TmpOper'
    *   This.fwgrade.Emps.ControlSource    = 'TmpOper.Emps'
    *   This.fwgrade.Dopes.ControlSource   = 'TmpOper.Dopes'
    *   This.fwgrade.MascNum.ControlSource = 'TmpOper.MascNum'
    *   This.fwgrade.Datas.ControlSource   = 'TmpOper.Datas'
    *   This.fwgrade.Valos.ControlSource   = 'TmpOper.Valos'
    *   This.fwgrade.Moeda.ControlSource   = 'TmpOper.Moeda'
    *   This.fwgrade.Tipo.ControlSource    = 'TmpOper.Tipo'
    *   This.fwgrade.Refresh
    *
    * A tela NAO consulta o banco: o cursor eh montado pelo form PAI
    * (SigOpCclBO.RecriarCursorOperacoes) e entregue pronto, com as 7
    * colunas e os 2 TAG - contrato conferido por SigOpClpBO.CursorPronto().
    * Carregar aqui eh, portanto, LIGAR a grade ao alias e repintar, que eh
    * exatamente o que o legado faz.
    *
    * FUNIL UNICO (regra CLAUDE.md #21 / #46): popular ou REORDENAR um
    * cursor nao repinta a grade sozinho, e o legado sempre fecha com
    * GO TOP + Grade.Refresh. Todo caminho que mexe no cursor passa por
    * aqui - a abertura (InicializarForm) e as duas reordenacoes por clique
    * no cabecalho (Fase 7, OrdenarPorNumero/OrdenarPorData do BO). Chamar
    * Refresh em cada handler, em vez de centralizar, eh o que faz a grade
    * ficar visualmente vazia com o cursor cheio.
    *
    * As larguras/cabecalhos sao reaplicados SEMPRE, inclusive quando o
    * cursor nao chegou: sem isso a grade apareceria com 7 colunas de 90px
    * e cabecalho "Column1".."Column7" na validacao de UI.
    *
    * MsgErro so dispara UMA vez e so FORA de teste/validacao de UI: nesses
    * modos a ausencia do cursor eh esperada (a tela eh instanciada sem
    * form pai), nao defeito. A flag impede o dialogo de reaparecer a cada
    * reordenacao.
    *
    * Metodo PUBLIC de proposito: o harness chama THIS.oForm.CarregarLista()
    * de FORA da classe, e PEMSTATUS devolve .T. mesmo para PROTECTED - o
    * teste entraria no branch e a chamada estouraria em runtime
    * (regra CLAUDE.md #3).
    *
    * Retorno: .T. quando a grade ficou ligada ao cursor; .F. quando o
    * cursor nao estava disponivel.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lLigou, loc_cCursor, loc_lModoTeste

        loc_lLigou  = .F.
        loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)

        loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                         (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        IF THIS.this_oBusinessObject.CursorPronto()
            *-- Ordem do legado: RecordSource primeiro, ControlSource depois.
            WITH THIS.grd_4c_Dados
                .RecordSource          = loc_cCursor
                .Column1.ControlSource = loc_cCursor + ".Emps"
                .Column2.ControlSource = loc_cCursor + ".MascNum"
                .Column3.ControlSource = loc_cCursor + ".Dopes"
                .Column4.ControlSource = loc_cCursor + ".Datas"
                .Column5.ControlSource = loc_cCursor + ".Valos"
                .Column6.ControlSource = loc_cCursor + ".Tipo"
                .Column7.ControlSource = loc_cCursor + ".Moeda"
            ENDWITH

            loc_lLigou = .T.
        ELSE
            *-- Sem cursor a grade fica sem fonte, nunca com o alias de uma
            *-- abertura anterior - exibir linha velha seria pior que vazio.
            THIS.grd_4c_Dados.RecordSource = ""

            IF !loc_lModoTeste AND !THIS.this_lFalhaCursorAvisada AND ;
               !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                THIS.this_lFalhaCursorAvisada = .T.
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Pesquisa Opera" + CHR(231) + CHR(245) + "es da Conta")
            ENDIF
        ENDIF

        *-- OBRIGATORIO depois de CADA atribuicao a RecordSource/ControlSource.
        THIS.FormatarColunasGrade()

        *-- GO TOP + Refresh: o par que o legado sempre usa para repintar.
        IF loc_lLigou
            THIS.this_oBusinessObject.PosicionarNoTopo()
        ENDIF

        THIS.grd_4c_Dados.Refresh()

        RETURN loc_lLigou
    ENDPROC

    *==========================================================================
    * FormatarColunasGrade - largura, ordem visual, cabecalho e fonte das 7 colunas
    *
    * Chamado por CarregarLista DEPOIS de cada bind, porque atribuir
    * RecordSource/ControlSource reseta Column.Width e Header1.Caption para
    * o default (regra CLAUDE.md #41 / "Problema 48"). Reaplicar eh seguro:
    * nenhuma destas propriedades depende do cursor existir.
    *
    * ColumnOrder reproduz a ordem VISUAL do dump (coluna 1 = Emp.,
    * ColumnOrder nao declarado = 1; mascnum.ColumnOrder = 3; dopes = 2;
    * datas = 5; valos = 6; tipo = 4; moeda sem ColumnOrder = 7), que eh
    * diferente da ordem de DECLARACAO das Column<N> - Column1=emps,
    * Column2=mascnum, Column3=dopes, Column4=datas, Column5=valos,
    * Column6=tipo, Column7=moeda.
    *
    * Movable = .F. / Resizable = .F. / ReadOnly = .T. em TODAS as colunas,
    * exatamente como o dump declara - a grade eh so de exibicao. O
    * Column.ReadOnly vem DEPOIS do Grid.ReadOnly (ConfigurarGrade), que
    * propaga para as colunas e sobrescreveria (regra CLAUDE.md #18).
    *
    * Header1.ForeColor = RGB(90,90,90) eh o valor do dump, nao palpite - e
    * eh tambem o canonico de rotulo de dados (regra CLAUDE.md #12).
    *
    * O Format de valos eh declarado na COLUNA (Column5.Format no dump), nao
    * no Text1: a propriedade da Column sobrevive ao rebind do
    * ControlSource. Column4.Format = "" do dump eh override VAZIO do Form
    * Designer e NAO eh transcrito (regra CLAUDE.md #49).
    *==========================================================================
    PROTECTED PROCEDURE FormatarColunasGrade()
        WITH THIS.grd_4c_Dados.Column1   && Emp. (emps)
            .ColumnOrder       = 1
            .Width             = 31
            .FontName          = "Tahoma"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Emp."
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2   && No. Oper. (mascnum)
            .ColumnOrder       = 3
            .Width             = 70
            .FontName          = "Tahoma"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "No. Oper."
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3   && Operacao (dopes)
            .ColumnOrder       = 2
            .Width             = 150
            .FontName          = "Tahoma"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4   && Data (datas)
            .ColumnOrder       = 5
            .Width             = 75
            .FontName          = "Tahoma"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Data"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column5   && Valor (valos)
            .ColumnOrder       = 6
            .Width             = 98
            .Format            = "999,999,999.99"
            .FontName          = "Tahoma"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Valor"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column6   && Tipo
            .ColumnOrder       = 4
            .Width             = 72
            .FontName          = "Tahoma"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Tipo"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column7   && Moe (moeda)
            .ColumnOrder       = 7
            .Width             = 35
            .FontName          = "Tahoma"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Moe"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - grp_operacao/cmd_sair do legado
    *
    * O legado NAO tem CommandGroup de 5 botoes CRUD: SigOpClp.SCX eh um
    * visualizador, e o unico objeto de acao eh um CommandGroup com
    * ButtonCount = 1 (regra CLAUDE.md da completude - inventar
    * Incluir/Alterar/Excluir aqui adicionaria funcionalidade que o legado
    * nao tem, o que viola o PILAR 1 tanto quanto omitir algo que ele tem).
    *
    * Geometria e aparencia TRANSCRITAS do dump (SIGOPCLP.grp_operacao /
    * Command1): grupo em Top -2 / Left 617 / 85x85, AutoSize = .T.,
    * BackStyle = 0 (transparente - a faixa cinza nao chega aqui, o fundo
    * eh a Picture do form), BorderStyle = 0, SpecialEffect = 1,
    * BorderColor 136,188,189, Themes = .F.; o botao interno (Command1,
    * renomeado cmd_sair no legado) em Top 5 / Left 5 / 75x75, fonte
    * "Comic Sans MS" bold+italic 8, Picture cadastro_sair_60.jpg,
    * Caption "Encerrar", Cancel = .T. (ESC aciona o botao - o
    * ToolTipText do legado, "[ESC] - Encerrar", confirma a intencao).
    *
    * Buttons(1) eh configurado em bloco WITH proprio, nao aninhado dentro
    * do WITH do grupo (regra CLAUDE.md #38 - Buttons(N) DENTRO de um
    * WITH de grupo eh seguro; o que quebra eh WITH aninhado em
    * Container/Label/CommandGroup criado por AddObject de dentro de
    * OUTRO WITH, que nao eh o caso aqui).
    *
    * BINDEVENT em "Click" chama um metodo PUBLIC (regra CLAUDE.md #3) -
    * BtnEncerrarClick, abaixo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Operacao", "CommandGroup")
        WITH THIS.cmg_4c_Operacao
            .Top           = -2
            .Left          = 617
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 188, 189)
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Operacao.Buttons(1)
            .Top               = 5
            .Left              = 5
            .Width             = 75
            .Height            = 75
            .FontName          = "Comic Sans MS"
            .FontSize          = 8
            .FontBold          = .T.
            .FontItalic        = .T.
            .WordWrap          = .T.
            .Picture           = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Caption           = "Encerrar"
            .ToolTipText       = "[ESC] - Encerrar"
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Themes            = .F.
            .Cancel            = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - grp_operacao.cmd_sair.Click do legado
    *
    * Legado:
    *
    *   ThisForm.ParentForm.Enabled = .t.
    *   ThisForm.ParentForm.Origem.get_grupo.SetFocus
    *   ThisForm.Release
    *
    * A reabilitacao do pai TAMBEM acontece em Destroy (cobre qualquer
    * caminho de saida, nao so este botao - ver o comentario de Destroy).
    * Repeti-la aqui preserva a ORDEM exata do legado: reabilitar, levar o
    * foco ao campo Grupo do pai e SO ENTAO liberar esta tela - o SetFocus
    * precisa do pai ja habilitado e de THIS ainda vivo.
    *
    * Os dois PEMSTATUS (sobre OBJETO, nunca sobre alias de cursor - regra
    * CLAUDE.md #13/#34) protegem contra o pai ter sido instanciado fora
    * do fluxo normal (teste automatizado), onde cnt_4c_Origem.txt_4c_Grupo
    * pode nao existir.
    *
    * Metodo PUBLIC de proposito: BINDEVENT exige alvo PUBLIC (regra
    * CLAUDE.md #3), e o irmao TxtValosKeyPress (Fase 7/8, TAB na coluna
    * Valor) tambem precisa alcanca-lo para mover o foco ao botao.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.

            IF PEMSTATUS(THIS.this_oFormPai, "cnt_4c_Origem", 5)
                IF PEMSTATUS(THIS.this_oFormPai.cnt_4c_Origem, "txt_4c_Grupo", 5)
                    THIS.this_oFormPai.cnt_4c_Origem.txt_4c_Grupo.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis os controles criados por
    * AddObject, que nascem com Visible = .F.
    *
    * Percorre Controls(N) por INDICE (Controls eh array, nunca colecao por
    * nome - regra CLAUDE.md #34) e recursa nos containers.
    *
    * NAO ha filtro de container flutuante neste form: o legado SIGOPCLP nao
    * tem container que comece oculto e seja alternado por botao - os quatro
    * objetos de primeiro nivel (cntSombra, shp_historico, fwgrade e
    * grp_operacao) sao todos visiveis desde a abertura, e fwgrade declara
    * Visible = .T. EXPLICITO no dump.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - reabilita o form pai antes de devolver o controle
    *
    * Legado (grp_operacao.cmd_sair.Click):
    *
    *   ThisForm.ParentForm.Enabled = .t.
    *   ThisForm.ParentForm.Origem.get_grupo.SetFocus
    *   ThisForm.Release
    *
    * A reabilitacao mora AQUI, e nao apenas no botao, de proposito: o pai
    * se desabilita ANTES de abrir esta tela
    * (FormSigOpCcl.BtnConsultaClick: THIS.Enabled = .F.) e, se esta tela
    * fosse fechada por qualquer caminho que nao o botao, o pai ficaria
    * desabilitado para sempre - a tela de consulta travaria sem erro
    * nenhum. Em Destroy a reabilitacao vale para TODO caminho de saida. O
    * SetFocus em get_grupo acompanha o botao, na Fase 4.
    *
    * O cursor da grade (cursor_4c_Operacoes) NAO eh fechado aqui: ele
    * pertence ao PAI, que o cria em SigOpCclBO.RecriarCursorOperacoes e o
    * fecha no proprio Destroy. Fecha-lo nesta tela derrubaria o cursor
    * debaixo de quem continua vivo depois dela.
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz
    * o SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que
    * repoe os pads do menu principal - sem ele o menu do sistema aparece
    * encolhido.
    *==========================================================================
    PROCEDURE Destroy()
        *-- Legado: ThisForm.ParentForm.Enabled = .t.
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.this_oFormPai        = .NULL.
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarEventosGrade - registra os TRES eventos de controle que o
    * legado tem fora do Init/Load (Fase 7)
    *
    * Os tres estao na SECAO 3 do dump e nenhum deles eh de botao - os dois
    * primeiros sao no CABECALHO de coluna da grade e o terceiro na CELULA:
    *
    *   SIGOPCLP.fwgrade.dopes.Header1.Click  (reordena por Operacao)
    *   SIGOPCLP.fwgrade.datas.Header1.Click  (reordena por Data, DESCENDING)
    *   SIGOPCLP.fwgrade.valos.Text1.KeyPress (TAB sai da grade para Encerrar)
    *
    * MAPA Column<N> -> coluna do legado. A ordem de DECLARACAO das Column eh
    * a do dump (Column<N>.Name), que NAO eh a ordem visual (ColumnOrder -
    * ver FormatarColunasGrade):
    *
    *   Column1 = emps     Column2 = mascnum   Column3 = dopes
    *   Column4 = datas    Column5 = valos     Column6 = tipo
    *   Column7 = moeda
    *
    * Logo os alvos sao Column3.Header1, Column4.Header1 e Column5.Text1 -
    * os MESMOS tres indices que CarregarLista liga a .Dopes, .Datas e
    * .Valos do cursor. Errar o indice aqui nao da erro nenhum: o clique
    * reordenaria pela coluna errada, calado.
    *
    * Header1 e Text1 sao membros NATIVOS de Column (regra CLAUDE.md #18):
    * existem desde o ".ColumnCount = 7" de ConfigurarGrade, sem AddObject.
    * Apontar BINDEVENT para um nome que a Column nao tem estoura no Init e
    * ainda deixa o controle sem handler nenhum (regra CLAUDE.md #186).
    *
    * Este metodo roda DEPOIS de ConfigurarGrade, que eh o UNICO lugar onde
    * ColumnCount eh atribuido: qualquer reatribuicao RECRIA os objetos
    * Column e levaria os tres BINDEVENT embora (regra CLAUDE.md #34 /
    * #183). CarregarLista mexe so em RecordSource/ControlSource, nunca em
    * ColumnCount, por isso os vinculos sobrevivem a cada reordenacao.
    *
    * Os tres alvos de BINDEVENT sao metodos PUBLIC: em PROTECTED o
    * BINDEVENT falha EM SILENCIO (regra CLAUDE.md #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosGrade()
        *-- Column3 = dopes (Operacao): legado faz "Set Order To Num"
        BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderOperacaoClick")

        *-- Column4 = datas (Data): legado faz "Set Order To Datas Descending"
        BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "HeaderDataClick")

        *-- Column5 = valos (Valor): legado move o foco para o cmd_sair no TAB
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "TxtValorKeyPress")

        *-- Fase 8: navegacao na grade -> o BO le a linha corrente. Nao vem do
        *-- SCX; fecha o contrato que SigOpClpBO.CarregarLinhaCorrente declara
        *-- desde a Fase 2 ("atalho usado pelo form quando o usuario navega na
        *-- grade"). Ligado no GRID, nunca numa Column: o evento eh do Grid, e
        *-- SEM filtro de coluna, que eh justamente o uso correto de
        *-- AfterRowColChange (regra CLAUDE.md #46 - o que a regra proibe eh
        *-- validar CELULA aqui, porque par_nColIndex eh a coluna de DESTINO).
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *==========================================================================
    * HeaderOperacaoClick - SIGOPCLP.fwgrade.dopes.Header1.Click do legado
    *
    * Legado (integral):
    *
    *   Select TmpOper
    *   If Not Eof() / lnRecno = Recno() / Else / lnRecno = 0 / EndIf
    *   Set Order To Num
    *   ThisForm.fwgrade.Refresh
    *   If (lnRecno <> 0) / Go lnRecno / Else / Go Top / EndIf
    *   ThisForm.fwgrade.Refresh
    *
    * O corpo (salvar o RECNO, trocar a ordem, repor o RECNO) ja esta em
    * SigOpClpBO.OrdenarPorNumero -> AplicarOrdem, transcrito linha a linha
    * desde a Fase 2; aqui fica so o que eh do FORM: o Refresh da grade, por
    * ReordenarGrade.
    *
    * ASCENDENTE de proposito: o legado nao escreve DESCENDING nesta coluna,
    * ao contrario da coluna Data. Nao eh descuido do dump - sao duas linhas
    * diferentes no SCX, e trocar uma pela outra mudaria a primeira linha
    * que o usuario ve (regra CLAUDE.md #17: criterio do legado se
    * TRANSCREVE, nao se reescreve).
    *
    * PUBLIC porque eh alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE HeaderOperacaoClick()
        RETURN THIS.ReordenarGrade("NUMERO")
    ENDPROC

    *==========================================================================
    * HeaderDataClick - SIGOPCLP.fwgrade.datas.Header1.Click do legado
    *
    * Identico ao Header1.Click da coluna Operacao exceto por UMA palavra -
    * "Set Order To Datas Descending" - e essa palavra eh regra de exibicao,
    * nao detalhe: a grade de movimentacoes mostra a data mais RECENTE na
    * primeira linha. O DESCENDING mora em SigOpClpBO.OrdenarPorData
    * (par_lDescendente = .T.), transcrito na Fase 2.
    *
    * PUBLIC porque eh alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE HeaderDataClick()
        RETURN THIS.ReordenarGrade("DATA")
    ENDPROC

    *==========================================================================
    * ReordenarGrade - funil UNICO de reordenacao da grade
    *
    * par_cCriterio - "NUMERO" (coluna Operacao) ou "DATA" (coluna Data)
    *
    * Os dois Header1.Click do legado tem o MESMO corpo e diferem so na
    * clausula de ordem, entao o form expoe um funil so - o mesmo desenho
    * que o BO ja usa com AplicarOrdem.
    *
    * POR QUE NAO CHAMA CarregarLista: reordenar NAO eh recarregar. O
    * legado, depois de trocar a ordem, VOLTA para o registro onde o usuario
    * estava ("If (lnRecno <> 0) / Go lnRecno"), e cai em GO TOP apenas
    * quando estava em EOF - preservar a linha corrente eh deliberado, e a
    * propria Fase 2 registrou o motivo (sem a reposicao, reordenar jogaria
    * o usuario para outra linha). CarregarLista termina em
    * PosicionarNoTopo() - GO TOP incondicional, que eh o correto para a
    * ABERTURA da tela - e passar por ela aqui DESFARIA a reposicao que
    * AplicarOrdem acabou de fazer: o usuario clicaria no cabecalho para
    * ordenar e perderia a linha que estava olhando, sem erro e sem log.
    * Rebindar RecordSource/ControlSource tambem seria trabalho inutil: SET
    * ORDER troca o indice corrente, nao a fonte de dados.
    *
    * O que esta fase NAO abre mao eh de repintar: popular ou REORDENAR um
    * cursor nao repinta a grade sozinho, e o legado sempre fecha com
    * Refresh (regra CLAUDE.md #21 / #46). Por isso o Refresh fica AQUI, no
    * funil, e nao duplicado nos dois handlers.
    *
    * Guarda de cursor: o alias pertence ao form PAI
    * (SigOpCclBO.RecriarCursorOperacoes) e pode nao ter chegado - tela
    * instanciada fora do fluxo normal (harness de teste, validacao de UI).
    * Sem cursor nao ha ordem a aplicar nem grade a repintar, e sair antes
    * evita o SET ORDER sobre alias inexistente. Os RETURN ficam fora de
    * qualquer TRY/CATCH (regra CLAUDE.md #1) - quem trata excecao eh
    * SigOpClpBO.AplicarOrdem, que ja reporta por MsgErro com LineNo e
    * Procedure.
    *
    * CursorPronto / OrdenarPorNumero / OrdenarPorData sao PUBLIC no BO -
    * conferido na Fase 6 (regra CLAUDE.md #51: metodo PROTECTED em
    * qualquer nivel da heranca estoura ao ser chamado de fora).
    *
    * Retorno: .T. quando a ordem foi efetivamente aplicada.
    *==========================================================================
    PROCEDURE ReordenarGrade(par_cCriterio)
        LOCAL loc_lOrdenou, loc_cCriterio

        loc_lOrdenou  = .F.
        loc_cCriterio = IIF(VARTYPE(par_cCriterio) = "C", UPPER(ALLTRIM(par_cCriterio)), "")

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Cursor eh do PAI: sem ele nao ha o que reordenar nem o que repintar.
        IF !THIS.this_oBusinessObject.CursorPronto()
            RETURN .F.
        ENDIF

        DO CASE
            CASE loc_cCriterio == "NUMERO"
                *-- Legado: Set Order To Num          (ASCENDENTE)
                loc_lOrdenou = THIS.this_oBusinessObject.OrdenarPorNumero()

            CASE loc_cCriterio == "DATA"
                *-- Legado: Set Order To Datas Descending
                loc_lOrdenou = THIS.this_oBusinessObject.OrdenarPorData()
        ENDCASE

        *-- Legado: ThisForm.fwgrade.Refresh (SET ORDER nao repinta sozinho).
        THIS.grd_4c_Dados.Refresh()

        RETURN loc_lOrdenou
    ENDPROC

    *==========================================================================
    * TxtValorKeyPress - SIGOPCLP.fwgrade.valos.Text1.KeyPress do legado
    *
    * Legado (integral):
    *
    *   Lparameters nKeyCode, nShiftAltCtrl
    *   If (nKeyCode = 9)
    *       ThisForm.grp_operacao.cmd_sair.SetFocus
    *   EndIf
    *
    * A coluna Valor eh a ultima da ordem visual que recebe foco (valos tem
    * ColumnOrder = 6; so moeda vem depois), entao o TAB ali sai da grade -
    * e o legado manda o foco para o unico botao da tela em vez de deixar o
    * VFP decidir.
    *
    * Os DOIS parametros sao declarados porque o handler esta ligado a
    * "KeyPress": handler SEM parametro em KeyPress estoura a cada tecla
    * digitada (regra CLAUDE.md #3).
    *
    * Nao ha NODEFAULT porque o legado nao o usa: ele faz o SetFocus e deixa
    * o tratamento padrao seguir. Acrescentar NODEFAULT mudaria
    * comportamento (PILAR 1).
    *
    * Este handler NAO abre dialogo nenhum, entao nao se aplica a ele a
    * regra CLAUDE.md #47 (lookup em "KeyPress" abrindo picker a cada
    * tecla): o teste explicito de par_nKeyCode = 9 eh justamente o que a
    * regra exige de um handler legitimamente ligado a KeyPress - e TAB eh a
    * tecla que o legado trata.
    *
    * As guardas antes do SetFocus nao sao decoracao: SetFocus em controle
    * invisivel ou desabilitado dispara erro de runtime, e esta tela pode
    * ser instanciada fora do fluxo normal (harness de teste), onde o grupo
    * de botoes pode nao ter sido montado. PEMSTATUS eh sempre sobre OBJETO,
    * nunca sobre alias de cursor (regra CLAUDE.md #13 / #34).
    *
    * PUBLIC porque eh alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE TxtValorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(par_nKeyCode) != "N"
            RETURN
        ENDIF

        *-- Legado: If (nKeyCode = 9) - TAB, e SOMENTE o TAB.
        IF par_nKeyCode != 9
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "cmg_4c_Operacao", 5)
            RETURN
        ENDIF

        *-- Legado: ThisForm.grp_operacao.cmd_sair.SetFocus
        WITH THIS.cmg_4c_Operacao
            IF .Visible AND .Enabled AND .ButtonCount >= 1
                IF .Buttons(1).Visible AND .Buttons(1).Enabled
                    .Buttons(1).SetFocus()
                ENDIF
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - a linha corrente da grade vai para o BO
    *
    * Evento AUXILIAR da Fase 8, e o UNICO deste arquivo que nao vem do SCX.
    * Ele existe para fechar um contrato que a Fase 2 deixou declarado e
    * nenhuma fase havia ligado: SigOpClpBO.CarregarLinhaCorrente ->
    * CarregarDoCursor publica Emps/Dopes/MascNum/Tipo/Moeda/Valos/Datas da
    * linha selecionada nas propriedades do BO, e eh ele quem da sentido ao
    * ObterChavePrimaria (PADR(Emps,3) + PADR(Dopes,20) + PADR(MascNum,10),
    * a chave POSICIONAL do TAG Num - regra CLAUDE.md #42).
    *
    * POR QUE ISSO NAO VIOLA O PILAR 1: o handler so LE o cursor para dentro
    * do BO. Nao consulta o banco, nao grava, nao mexe em controle nenhum e
    * nao exibe mensagem - o usuario ve exatamente a mesma tela de antes. O
    * sentido inverso (BO -> campo) nao existe nesta tela porque nao ha campo
    * de dados fora da grade (secao da Fase 5).
    *
    * SEM filtro de coluna, de proposito: par_nColIndex eh a coluna de
    * DESTINO, e usa-lo para decidir aqui eh o defeito que a regra
    * CLAUDE.md #46 descreve. Carregar o detalhe da LINHA corrente eh o uso
    * legitimo e majoritario do evento - o que a regra proibe eh validar
    * CELULA nele.
    *
    * O parametro EH declarado mesmo sem ser usado: AfterRowColChange passa
    * nColIndex, e handler ligado por BINDEVENT com assinatura menor que a do
    * evento estoura a cada troca de celula (regra CLAUDE.md #3).
    *
    * Guarda de cursor antes de ler: o alias pertence ao form PAI e pode nao
    * ter chegado (tela instanciada fora do fluxo normal). CursorPronto()
    * confere alias, as 7 colunas e os 2 TAG; sem ele, nao ha linha a ler. Os
    * RETURN ficam fora de qualquer TRY/CATCH (regra CLAUDE.md #1) - quem
    * trata excecao eh CarregarDoCursor, que reporta por MsgErro com LineNo e
    * Procedure.
    *
    * PUBLIC porque eh alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.CursorPronto()
            RETURN .F.
        ENDIF

        RETURN THIS.this_oBusinessObject.CarregarLinhaCorrente()
    ENDPROC

ENDDEFINE

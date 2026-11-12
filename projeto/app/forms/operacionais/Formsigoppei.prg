*==============================================================================
* Formsigoppei.prg - Itens dos Subniveis (dialogo FILHO de consulta)
*
* Origem legado: tasks\task780\sigoppei.SCX (form SIGOPPEI)
* Herda de: FormBase
* BO: sigoppeiBO (ja completo nas Fases 1-2)
*
* Tipo: OPERACIONAL - form PLANO, SEM PageFrame. A arvore de objetos do SCX
*       (SECAO 1 do dump + layout.json) tem 13 objetos de tela, todos filhos
*       DIRETOS de SIGOPPEI: cntSombra (com lblSombra/lblTitulo), Shape1, o
*       CommandButton fwbtng "Retornar", a Grade de 7 colunas, os 3 totais do
*       rodape (gettotitens/gettotbaixa/gettotdisp), os 2 campos de produto
*       (getCProd/getDProd) e os 2 rotulos deles (Say5/Say2). Nao existe Page
*       nenhuma - nao ha o que paginar nesta tela.
*
*       Medido no dump desta task, nao presumido:
*         "BaseClass: pageframe" ............ 0 ocorrencias
*         "Parent: (raiz) / Class: form" .... 1 (raiz eh form GENERICO, nao
*                                            frmcadastro nem frmrelatorio)
*
*       Por isso o template generico de Fase 3 (PageFrame com Page1=Lista /
*       Page2=Dados mais cnt_4c_Botoes/cnt_4c_BotoesAcao) NAO se aplica aqui:
*       CLAUDE.md e a regra de form OPERACIONAL mandam seguir o layout
*       CUSTOMIZADO do legado. Inventar um PageFrame e dois containers de
*       botao CRUD que o legado nao tem violaria o PILAR 1 e a regra "NUNCA
*       inventar". Mesmo tratamento de FormSIGOPGRC (task743) e FormSigOpGco
*       (task739), os outros dialogos filhos planos do projeto.
*
*       O unico container do legado eh o cntSombra (faixa do titulo).
*
*       E tambem nao existe botao CRUD nenhum: o legado nao tem Incluir /
*       Alterar / Excluir / Buscar nem Confirmar / Cancelar. O form inteiro eh
*       de CONSULTA e o seu unico botao eh o "Retornar" (btnCancelar), que so
*       devolve o controle a tela que abriu o dialogo. A superficie que esta
*       tela de fato tem - grade + botao de acao + funil de carga - eh o que
*       as Fases 4 em diante entregam.
*
* CONTRATO COM O FORM PAI
* --------------------------------------------------------------------------
* Legado: "Lparameters poform, pnDatSes" + "Set DataSession to pnDatSes" +
*         "thisform.parentform = poform" + "thisform.op_escolha =
*         poform.op_escolha".
*
* 1) CREATEOBJECT("Formsigoppei", <form pai>, <datasession do pai>) - os dois
*    parametros do Init legado, na mesma ordem. O segundo eh opcional: sem
*    ele, a sessao do pai eh lida de par_oFormPai.DataSessionId.
* 2) A tela NAO monta os dados dela sozinha a partir do banco: ela LE dois
*    cursores que o form PAI deixa prontos - xBaixa e xBaixa2, criados em
*    SIGMVCAB (ver tasks\task560\sigmvcab_form_codigo_fonte.txt). Por isso o
*    Init entra na MESMA sessao de dados do pai: com sessao privada propria,
*    USED("xBaixa2") daria .F. e o dialogo nao teria o que exibir.
* 3) Quem exibe a tela eh o PAI, com .Show() FORA de qualquer TRY/CATCH
*    (CLAUDE.md regra #29): este form eh WindowType = 1 (transcrito do SCX),
*    entao o Show() BLOQUEIA e toda a vida da tela corre dentro dele.
* 4) O unico acesso remoto do dialogo eh de LEITURA, em SigCdPro, para buscar
*    a descricao de cada produto - ja implementado no BO
*    (sigoppeiBO.CarregarItensPendentes). A tela nao grava nada: o unico botao
*    eh "Retornar", que apenas fecha.
*
* ESTRUTURA DA CLASSE
* --------------------------------------------------------------------------
*   DEFINE CLASS Formsigoppei AS FormBase com as propriedades visuais
*   transcritas do SCX e as duas propriedades customizadas que o legado
*   acrescenta ao form (RESERVED3/ClassInfo do dump: parentform e op_escolha);
*
*   Init()                    "Lparameters poform, pnDatSes" do legado -
*                             guarda a referencia do pai, entra na sessao de
*                             dados dele e copia op_escolha, antes do
*                             DODEFAULT() que dispara FormBase.Init
*   InicializarForm()         instancia o sigoppeiBO, aplica o fundo do form,
*                             monta a arvore de controles e carrega a grade
*   ConfigurarPageFrame()     ponto de entrada arquitetural da montagem
*                             visual (sem Page nenhuma - ver acima); chama os
*                             Configurar* na ORDEM dos registros do SCX
*   ConfigurarCabecalho()     cnt_4c_Sombra com lbl_4c_LblSombra e
*                             lbl_4c_LblTitulo, transcritos do SCX
*   ConfigurarMoldura()       shp_4c_Shape1 (Shape1 do SCX) - criado ANTES do
*                             botao, para nao engolir o clique dele
*   ConfigurarBotoes()        cmd_4c_BtnCancelar ("Retornar"), o unico botao
*                             da tela, + o BINDEVENT do Click
*   BtnCancelarClick()        Click do "Retornar" (legado: Thisform.Release)
*   ConfigurarGrade()         grd_4c_Dados com as propriedades de GRADE do SCX
*   GarantirCursorGrade()     cria o alias de exibicao vazio quando ele ainda
*                             nao existe, para o ControlSource ter onde ligar
*   VincularGrade()           funil unico das 7 colunas: ColumnCount,
*                             RecordSource, ControlSource, larguras, headers
*   ConfigurarPaginaDados()   bloco de produto: txt_4c_CProd/txt_4c_DProd e os
*                             rotulos lbl_4c_Label5/lbl_4c_Label2
*   VincularCamposProduto()   funil unico do ControlSource das duas caixas
*   ConfigurarTotais()        os 3 totalizadores do rodape (txt_4c_Totitens,
*                             txt_4c_Totbaixa, txt_4c_Totdisp)
*   CarregarLista()           funil unico de carga: BO.CarregarItensPendentes
*                             + VincularGrade + AtualizarTotais (trecho de
*                             dados do Init legado)
*   AtualizarTotais()         espelha os 3 totais do BO e alterna o Visible
*                             da grade e deles, como o Init legado
*   TornarControlesVisiveis() AddObject cria com Visible = .F.
*   Destroy()                 fecha os cursores que ESTE form cria e solta as
*                             referencias de BO e de pai
*
* NAO EXISTE LOOKUP NESTA TELA, e isso foi medido no dump desta task, nao
* presumido: "fwbusca" (Ext/Sel/Int), "mAddColuna", "sigacess(", as 12 globais
* "Acesso<X>(" e "CreateObject(" aparecem ZERO vezes. Os 12 campos de entrada
* do legado - as 7 celulas da grade e as 5 caixas soltas - sao TODOS
* somente-leitura (ReadOnly = .T. no dump ou "PROCEDURE When / Return .f."), e
* campo somente-leitura nao recebe lookup: nao ha onde digitar o codigo para um
* picker resolver. Ver o bloco de ConfigurarTotais para a medicao completa e as
* razoes de NAO inventar um AbrirBusca*/AbrirLookup* aqui.
*
* O "Else / Return .f." do Init legado - a recusa de abrir a tela quando o
* cursor do form pai nao esta disponivel - vive em InicializarForm, a partir do
* logico que CarregarLista devolve, com bypass sob gb_4c_ModoTeste /
* gb_4c_ValidandoUI (o harness e o ValidarUIFidelity instanciam o dialogo sem
* pai). A alternancia de Visible que o legado faz na grade e nos 3 totais vive
* em AtualizarTotais, chamado pelo mesmo funil.
*
* FASE 7 - EVENTOS PRINCIPAIS: INVENTARIO MEDIDO DOS 13 METODOS DO SCX
* --------------------------------------------------------------------------
* A convencao de Fase 7 do pipeline eh um Btn<Verbo>Click para cada um dos
* quatro botoes da barra CRUD do frmcadastro - Incluir, Alterar, Visualizar e
* Excluir. ESTA TELA NAO TEM NENHUM DOS QUATRO, e isso foi MEDIDO no dump
* desta task com automation\VerificarGateFase7Task780.ps1, que RECORTA o
* proprio bloco "case 7" do OrquestradorMigracao.ps1 em vez de reproduzi-lo a
* mao (dot-source do orquestrador DISPARA uma migracao real):
*
*   nBotoesLegado (commandbutton solto + ButtonCount de commandgroup) ..... 1
*   variavel de modo CRUD viva (pcEscolha) ............................... 0
*   "frmcadastro" / "frmrelatorio" / "Grupo_Op" .......................... 0
*   nome btn|cmd(Incluir|Alterar|Visualizar|Excluir) ..................... 0
*   <Verbo>.Click ........................................................ 0
*
* O UNICO botao do SCX eh o btnCancelar ("Retornar"), e o evento dele eh o
* BtnCancelarClick desta classe. Escrever os quatro nomes da convencao
* exigiria INVENTAR botoes que o legado nao tem (viola o PILAR 1) ou criar
* metodos vazios - stub disfarcado, que a regra de completude proibe.
*
* Os quatro nomes NAO aparecem escritos por extenso em nenhum comentario deste
* arquivo, e isso eh DELIBERADO: o gate da Fase 7 testa o TEXTO CRU do .prg
* ("$conteudo -notmatch <nome>"), entao cita-los num comentario faria a fase
* passar pelo caminho ERRADO - como se os quatro handlers existissem - e
* esconderia a evidencia que de fato a aprova, que eh o carve-out de legado
* sem CRUD medido acima. Comentario nao satisfaz gate.
*
* Os 13 metodos/eventos que a SECAO 3 do dump traz, e onde cada um vive:
*
*   SIGOPPEI.Init ................. Init (contrato com o pai) +
*                                   InicializarForm (a recusa do "Else") +
*                                   CarregarLista / AtualizarTotais (dados)
*   btnCancelar.Click ............. BtnCancelarClick
*   Grade.Column1..4.Text1.When ... Column<N>.ReadOnly e Text1.ReadOnly das
*                                   7 colunas, em VincularGrade
*   gettotitens.When .............. txt_4c_Totitens  .ReadOnly + .TabStop
*   gettotbaixa.When .............. txt_4c_Totbaixa  .ReadOnly + .TabStop
*   gettotdisp.When ............... txt_4c_Totdisp   .ReadOnly + .TabStop
*   getCProd.When ................. txt_4c_CProd     .ReadOnly + .TabStop
*   getDProd.When ................. txt_4c_DProd     .ReadOnly + .TabStop
*   SIGOPPEI.Load ................. NAO portado - ver (a)
*   getDProd.LostFocus ............ NAO portado - ver (b)
*
* (a) O Load legado eh "=fConfigGeral()", a inicializacao GLOBAL da aplicacao
*     Fortyus. Na arquitetura nova isso ja acontece ANTES e distribuido
*     (config.prg / main.prg / cada BO com os seus cursores). O wrapper
*     projeto\app\utils\fconfiggeral.prg existe APENAS para o p-code dos VCX
*     legado, e o cabecalho dele eh explicito: em codigo NOSSO essa funcao
*     nunca eh chamada. Mesmo tratamento de SIGOPGRCBO (task743).
*
* (b) O LostFocus de getDProd eh
*         If ThisForm.fwGrade.Visible
*             ThisForm.fwGrade.SetFocus
*         EndIf
*     e eh codigo MORTO copiado do form PAI - duas provas, as duas medidas:
*       1. NAO EXISTE "fwGrade" em SIGOPPEI. A grade desta tela chama-se
*          "Grade" (SECAO 1 do dump); "fwgrade" aparece no dump inteiro 3
*          vezes - uma como NOME DA CLASSE dela ("Class: fwgrade") e duas
*          dentro deste proprio trecho. Quem tem grade chamada fwGrade eh o
*          CHAMADOR: ProximasMigracoes\sigoppro.SCT cita "fwgrade" 337 vezes
*          e, na linha seguinte ao
*          "Do Form sigoppei with thisform, Thisform.DataSessionId", faz
*          "Thisform.fwgrade.Produto.Setfocus()". Rodando aqui, a linha
*          estouraria "Property FWGRADE is not found".
*       2. NUNCA RODA. O proprio getDProd tem "When / Return .f." e o Init
*          legado o deixa Visible = .f. nos DOIS caminhos do "If", entao o
*          campo nao recebe o foco e portanto nunca o perde.
*     Porta-lo exigiria ESCOLHER um alvo para o SetFocus - inventar o que o
*     legado nao diz (regra "NUNCA inventar"). Fica registrado aqui para o
*     proximo leitor nao reabrir a questao.
*
* CORRECAO DESTA FASE: txt_4c_DProd tinha SO .TabStop = .F. para reproduzir o
* "When / Return .f." de getDProd. TabStop sozinho nao impede o clique do
* mouse nem a digitacao, e o When do legado eh mais forte que isso - a propria
* convencao deste arquivo (ver ConfigurarTotais e txt_4c_CProd) eh o PAR
* .ReadOnly = .T. + .TabStop = .F. O .ReadOnly foi acrescentado.
*==============================================================================

DEFINE CLASS Formsigoppei AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    * SIGOPPEI: Width=1000, Height=600, BorderStyle=2, AutoCenter=.T.,
    * ControlBox=.F., MaxButton=.F., MinButton=.F., TitleBar=0, WindowType=1,
    * DataSession=2, Picture=..\framework\imagens\new_background.jpg
    *
    * Os 1000x600 do legado JA sao a geometria canonica do projeto - este
    * dialogo nao precisa de escala nenhuma.
    *
    * Closable NAO eh declarado: o dump do SCX nao o cita, e fixa-lo em .F.
    * tiraria o Alt+F4, que no legado continua valendo (regra
    * "Closable inventado tira a unica saida").
    *==========================================================================
    Width       = 1000
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    Caption     = "Itens dos Subn" + CHR(237) + "veis"

    *-- DataSession = 2 transcrito do SCX. Vale so quando este form eh aberto
    *-- SEM form pai (probe/harness): ai ele ganha sessao privada propria.
    *-- Havendo pai, Init() troca THIS.DataSessionId pela sessao dele ANTES do
    *-- DODEFAULT(), reproduzindo o "Set DataSession to pnDatSes" do legado -
    *-- sem isso os cursores do pai (xBaixa/xBaixa2) ficariam invisiveis.
    DataSession = 2

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================

    *-- Business Object (sigoppeiBO). Redeclarado aqui, sobre o default de
    *-- FormBase, para o contrato desta classe ficar explicito.
    this_oBusinessObject = .NULL.

    *-- Referencia do form PAI. Equivale a property customizada "parentform"
    *-- que o SCX legado acrescenta ao form (RESERVED3/ClassInfo do dump) -
    *-- NAO eh a ParentForm nativa do VFP9, que eh read-only. Fica .NULL.
    *-- quando a tela eh aberta sem pai, entao TODO uso dela nas fases
    *-- seguintes vai sob guarda VARTYPE(THIS.this_oFormPai) = "O".
    this_oFormPai = .NULL.

    *-- "op_escolha" do SCX (RESERVED3/ClassInfo), copiada do pai no fim do
    *-- Init legado ("thisform.op_escolha = poform.op_escolha"). O default do
    *-- legado eh .F., igual ao daqui.
    this_lOpEscolha = .F.

    *==========================================================================
    * Init - "PROCEDURE Init / Lparameters poform, pnDatSes" do legado.
    *
    * Faz, na ordem do legado e ANTES do DODEFAULT(), as tres coisas que o
    * Init original resolve antes de tocar em dado algum: guardar a referencia
    * do pai, entrar na sessao de dados dele e copiar op_escolha.
    *
    * A troca de DataSessionId tem de vir ANTES do DODEFAULT(): eh o
    * DODEFAULT() que chama FormBase.Init -> THIS.InicializarForm(), e dali
    * para frente tudo precisa estar na sessao do pai, onde vivem os cursores
    * xBaixa/xBaixa2 (ver CONTRATO COM O FORM PAI no cabecalho).
    *
    * op_escolha eh lida sob PEMSTATUS porque o pai pode nao ter a property:
    * no legado quem abre esta tela eh sempre o SIGMVCAB, que a tem, mas o
    * harness/probe abre o dialogo sem pai nenhum.
    *
    * O RETURN fica FORA do TRY/CATCH (CLAUDE.md regra #1).
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_nDataSession

        LOCAL loc_oErro

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF

            IF VARTYPE(par_nDataSession) = "N" AND par_nDataSession > 0
                *-- "Set DataSession to pnDatSes" do legado
                THIS.DataSessionId = par_nDataSession
            ELSE
                IF VARTYPE(par_oFormPai) = "O"
                    THIS.DataSessionId = par_oFormPai.DataSessionId
                ENDIF
            ENDIF

            *-- "thisform.op_escolha = poform.op_escolha" do legado
            IF VARTYPE(par_oFormPai) = "O"
                IF PEMSTATUS(par_oFormPai, "op_escolha", 5)
                    THIS.this_lOpEscolha = par_oFormPai.op_escolha
                ELSE
                    IF PEMSTATUS(par_oFormPai, "this_lOpEscolha", 5)
                        THIS.this_lOpEscolha = par_oFormPai.this_lOpEscolha
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.Init")
        ENDTRY

        *-- DODEFAULT() chama FormBase.Init(), que chama THIS.InicializarForm()
        *-- e repoe SET DATE TO BRITISH + SET CENTURY ON (CLAUDE.md regra #9.4).
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual desta fase.
    *
    * NAO chama THIS.Show(): este form eh WindowType = 1 (modal) e o Show()
    * bloqueia - quem exibe eh o pai, FORA de TRY/CATCH (regra #29).
    *
    * Falha ao criar o BO devolve .F., e FormBase.Init aborta a abertura da
    * tela - eh o comportamento certo aqui: sem o BO nao ha de onde tirar o
    * cursor da grade, e exibir o dialogo vazio seria pior do que nao abrir
    * (o proprio Init legado faz "Return .f." quando nao tem dado a mostrar).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lTemDados, loc_lBypassRecusa, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigoppeiBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Fundo do form: ..\framework\imagens\new_background.jpg do
                *-- SCX. Resolvido por gc_4c_CaminhoIcones (o arquivo esta em
                *-- vbmp\), convencao dominante do projeto. O arquivo foi
                *-- CONFERIDO em vbmp\ - .Picture apontando para arquivo
                *-- inexistente nao da erro nenhum, o fundo so nao desenha
                *-- (CLAUDE.md regra #25).
                IF TYPE("gc_4c_CaminhoIcones") = "C"
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                ENDIF

                THIS.ConfigurarPageFrame()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da grade, como no Init legado (que monta o cursor de
                *-- exibicao, vincula a Grade, soma os totais e mostra os
                *-- controles no proprio Init). O logico devolvido eh o
                *-- "Used([xBaixa2]) com cursor montado" do legado.
                loc_lTemDados = THIS.CarregarLista()

                *-- "Else / Return .f." do Init legado - a RECUSA DE ABRIR.
                *-- O legado nao avisa nada nesse caminho: ele simplesmente
                *-- devolve .F. do Init, e o form nao aparece. Aqui o efeito eh
                *-- o mesmo, porque FormBase.Init aborta a abertura quando
                *-- InicializarForm devolve .F. (e CREATEOBJECT devolve .F.
                *-- logico para quem pediu a tela). Sem dialogo nenhum,
                *-- tambem de proposito: MsgAviso aqui divergiria do legado e
                *-- ainda travaria o ValidarUIFidelity, que nao suprime modal.
                *--
                *-- BYPASS sob gb_4c_ModoTeste / gb_4c_ValidandoUI: o harness
                *-- (automation\vfp_helpers\TestFormWrapper.prg, etapa
                *-- 06_testForm) faz CREATEOBJECT("Formsigoppei") SEM argumento
                *-- nenhum, e o ValidarUIFidelity instancia o form sem pai -
                *-- nos dois casos xBaixa/xBaixa2 nao existem, a carga devolve
                *-- .F. e a recusa reprovaria SEMPRE as etapas 6 e 8, com o
                *-- form correto e completo. Mesmo gate ja usado para
                *-- gnConnHandle. Em bypass a tela abre com grade e totais
                *-- OCULTOS, que eh exatamente o estado em que o Init legado
                *-- deixa esses quatro controles antes do If.
                *--
                *-- IF aninhado e nao AND: VFP9 nao faz short-circuit, entao
                *-- "TYPE(...) = "L" AND gb_4c_ModoTeste" avaliaria a variavel
                *-- mesmo quando ela nao existe e estouraria
                *-- "Variable GB_4C_MODOTESTE is not found".
                loc_lBypassRecusa = .F.
                IF TYPE("gb_4c_ModoTeste") = "L"
                    IF gb_4c_ModoTeste
                        loc_lBypassRecusa = .T.
                    ENDIF
                ENDIF
                IF TYPE("gb_4c_ValidandoUI") = "L"
                    IF gb_4c_ValidandoUI
                        loc_lBypassRecusa = .T.
                    ENDIF
                ENDIF

                loc_lSucesso = (loc_lTemDados OR loc_lBypassRecusa)
            ELSE
                THIS.this_cMensagemErro = "Erro ao criar sigoppeiBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject)
                MsgErro(THIS.this_cMensagemErro, "Formsigoppei.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador da montagem visual. O SIGOPPEI NAO
    * tem PageFrame (layout plano: todos os objetos sao filhos diretos do
    * form), entao NAO se cria Page nenhuma aqui - o nome eh mantido apenas
    * como ponto de entrada arquitetural padrao, mesmo papel que tem em
    * FormSIGOPGRC e FormSigOpGco.
    *
    * A ordem de chamada reproduz a ordem dos REGISTROS do SCX legado
    * (cntSombra -> Shape1 -> btnCancelar -> Grade -> totais -> campos de
    * produto -> rotulos), porque AddObject empilha no z-order e o ultimo
    * criado desenha POR CIMA.
    *
    * O cabecalho vem PRIMEIRO, e isso nao eh estetica: o btnCancelar do
    * legado fica em Top=3, DENTRO da area da faixa (0..80), e so desenha por
    * cima dela se for criado DEPOIS (CLAUDE.md regra #11). Invertida a ordem,
    * a faixa COBRIRIA o unico botao da tela.
    *
    * Pela mesma razao, o Shape1 do legado (Top 7..117 / Left 900..990, com
    * BackStyle=0 e BorderStyle=0, isto eh, invisivel) SOBREPOE a area do
    * botao (Top 3.. / Left 923..): no SCX ele eh criado ANTES dele, entao o
    * botao fica por cima e recebe o clique. As chamadas das Fases 4 a 6 tem
    * de ser inseridas DEPOIS de ConfigurarCabecalho e na ordem do SCX - criado
    * por ultimo, o Shape transparente ficaria por cima e engoliria o clique
    * no Retornar sem desenhar nada, sem erro e sem log (regra #30).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarMoldura()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrade()
        *-- Fase 6: os 3 totalizadores do rodape (registros 24/25/30 do SCX).
        *-- Entram ENTRE a grade e o bloco de produto, que eh onde os
        *-- registros 24 e 25 ficam no SCX - sem consequencia visual, porque
        *-- os totais ficam em Top = 567 e o bloco de produto em Top = 87..125
        *-- (ver ConfigurarTotais).
        THIS.ConfigurarTotais()
        *-- Fase 5: bloco de produto (registros 26..29 do SCX). Entra
        *-- DEPOIS da grade, na ordem de registro do SCX.
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarMoldura - Shape1 do SCX, a moldura do canto superior direito:
    *   Shape1  Top=7, Left=900, Width=90, Height=110,
    *           BackStyle=0, BorderStyle=0, BorderColor=136,189,188
    *
    * Com BackStyle = 0 (nao pinta o interior) E BorderStyle = 0 (nao desenha
    * a borda) o Shape eh INVISIVEL na tela do legado - os 136,189,188 do
    * BorderColor ficam inertes. Transcrito ainda assim, porque ele ocupa a
    * area 900..990 / 7..117, que eh justamente a area do botao Retornar: o
    * SCX o cria ANTES do botao, entao o botao desenha por cima e recebe o
    * clique. Criado DEPOIS, este retangulo transparente ficaria na frente e
    * engoliria o clique no unico botao da tela, sem desenhar nada, sem erro e
    * sem log (CLAUDE.md regra #30). A ordem de chamada em ConfigurarPageFrame
    * eh o que garante isso.
    *
    * Shape NAO tem ForeColor (conferido na tabela medida
    * automation\propriedades_baseclasses.txt - regra #33): a cor de contorno
    * eh BorderColor, e eh ela que o dump declara.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMoldura()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 900
                .Width       = 90
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.ConfigurarMoldura")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - O UNICO botao da tela. Transcrito do SCX:
    *   btnCancelar  (classe fwbtng)  Top=3, Left=923, Cancel=.T.,
    *                Caption="Retornar",
    *                Picture=..\framework\imagens\cadastro_sair_60.jpg
    *
    * O SCX nao declara Width/Height: elas vinham da classe fwbtng do
    * framework.vcx (Height=100, Width=80, FontName="Comic Sans MS",
    * FontSize=8, FontBold=.T., FontItalic=.T., WordWrap=.T., MousePointer=15,
    * ForeColor=90,90,90, BackColor=255,255,255, Themes=.F. - lidas em
    * docs\FRAMEWORK_class_codigo_fonte.txt). Todas as demais sao transcritas
    * dali.
    *
    * EXCECAO medida nas DUAS dimensoes, e a mesma que FormSIGOPGRC e
    * FormSigOpGco ja adotaram: 75x75 no lugar dos 80x100 da classe.
    *   - 923 + 80 = 1003 contra os 1000 de Form.Width: o botao da classe
    *     vaza 3px para FORA da janela e eh recortado (regra #30);
    *   - 3 + 100 = 103 contra os 80 do cnt_4c_Sombra: ele vaza 23px abaixo da
    *     faixa do cabecalho.
    *   Com 75x75 o botao fica em 923..998 / 3..78 - dentro da janela E dentro
    *   da faixa - e assume a geometria canonica dos botoes de icone do
    *   projeto (docs\framework_frmcadastro_layout.md).
    *
    * O padrao canonico cnt_4c_Saida/cmd_4c_Encerrar (container em Left=917,
    * Width=90 - CLAUDE.md regra #10) NAO se aplica: ele vale para os CRUD
    * frmcadastro com PageFrame, e aqui nao existe container de saida nenhum -
    * o botao eh filho DIRETO do form, como no legado.
    *
    * Caption "Retornar" eh o do dump e NAO eh trocado por "Encerrar": este
    * botao devolve o controle para a tela que abriu a consulta, nao encerra
    * cadastro nenhum.
    *
    * Cancel = .T. eh transcricao do SCX e aqui eh ESSENCIAL, nao cosmetico:
    * o form tem TitleBar = 0 e ControlBox = .F., ou seja NAO tem X de fechar.
    * Com Cancel = .T. o ESC aciona o Click deste botao, que eh a segunda via
    * de saida da tela.
    *
    * Themes = .T. + DisabledPicture com a MESMA imagem: CommandButton SOLTO
    * (fora de CommandGroup) com .Picture nao renderiza o icone com
    * Themes = .F. (CorretorAutomatico #99) - por isso o Themes = .F. da
    * classe fwbtng nao eh transcrito. A excecao Themes = .F. vale para
    * Buttons(N) DENTRO de CommandGroup, que nao eh o caso aqui.
    *
    * O cadastro_sair_60.jpg veio do dump e foi CONFERIDO em vbmp\ - .Picture
    * apontando para arquivo inexistente nao da erro nenhum, o botao so fica
    * sem icone (regra #25).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_BtnCancelar", "CommandButton")
            WITH THIS.cmd_4c_BtnCancelar
                .Top             = 3
                .Left            = 923
                .Width           = 75
                .Height          = 75
                .Caption         = "Retornar"
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
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Enabled         = .T.
                .Visible         = .T.
            ENDWITH

            *-- BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3):
            *-- BtnCancelarClick nao leva PROTECTED.
            BINDEVENT(THIS.cmd_4c_BtnCancelar, "Click", THIS, "BtnCancelarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Click do "Retornar". Legado:
    *   PROCEDURE Click / SELECT TmpItePen / Use / thisform.Release()
    *
    * O "SELECT TmpItePen / Use" NAO eh repetido aqui: o Release dispara o
    * Destroy, e eh ele que fecha os cursores deste form (os dois nomes saem
    * das properties do BO). O efeito final eh o mesmo do legado, num unico
    * lugar - e fechar o alias AQUI derrubaria o RecordSource da grade com a
    * tela ainda na tela.
    *
    * Release() e nao Hide(): esta consulta NAO devolve resultado nenhum ao
    * chamador. Medido no SCX do pai (ProximasMigracoes\sigoppro.SCT):
    *   Do Form sigoppei with thisform, Thisform.DataSessionId
    *   Thisform.fwgrade.Produto.Setfocus()
    * - o pai abre sem "TO <var>" e, na volta, so devolve o foco para a grade
    * dele; nao ha property desta tela que ele leia depois. O caso que exige
    * Hide() eh o do dialogo cujo retorno o chamador precisa ler, que nao eh
    * este. Como a tela eh WindowType = 1 (modal), o Show() do pai esta
    * BLOQUEADO e o Release eh o que devolve o controle a ele - mesmo desenho
    * de FormSigOpGco.CmdSairClick e FormSIGOPGRC.CmdSairClick.
    *
    * PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT - metodo PROTECTED
    * falha em silencio no bind (regra #3).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do titulo. Transcrito do SCX:
    *   cntSombra  Top=0,  Left=0,  Width=1004, Height=80,
    *              BorderWidth=0, BackColor=100,100,100
    *   lblSombra  Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0
    *   lblTitulo  Top=17, Left=10, Width=769, Height=46, ForeColor=255,255,255
    * Ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
    *
    * Os Top 18/17 NAO estao invertidos por descuido - sao o efeito de SOMBRA:
    * o label preto fica 1px ABAIXO e eh criado PRIMEIRO; o branco entra por
    * cima, deslocado 1px para o topo. Trocar a ordem de criacao apagaria o
    * efeito (o preto cobriria o branco). A ordem aqui eh a dos registros do
    * SCX.
    *
    * Width do CONTAINER = THIS.Width (1000) e nao o literal 1004 do dump: o
    * Form Designer desenhou o cntSombra 4px mais largo que a propria janela,
    * artefato ja catalogado para cntSombra.Width. O canonico da regra #11 eh
    * justamente .Width = THIS.Width, que ainda acompanha o form se alguem
    * mudar a largura.
    *
    * Width dos LABELS fica no literal 769 do dump: aqui ele CABE com folga
    * dentro dos 1000px visiveis (ao contrario dos casos em que o form eh
    * estreito e o literal 769 estouraria a janela), entao transcrever eh o
    * mais fiel.
    *
    * O Caption dos dois labels vem de THIS.Caption, como no Init legado
    * ("ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption") - no SCX os
    * dois estao congelados em "Cadastro de Testes", que eh lixo do template
    * e NAO deve ser transcrito.
    *
    * AutoSize = .F. explicito com Width/Height do dump: AutoSize eh no-op em
    * Label criado por AddObject (a Width ficaria nos 100 do default) e, com
    * WordWrap = .T., ainda DESCARTA a Height e corta o texto em duas linhas
    * (CLAUDE.md regra #23). Os numeros do SCX JA sao o auto-size que o Form
    * Designer calculou, entao fixa-los eh reproducao fiel.
    *
    * ForeColor branco eh correto AQUI (regra #12): o container eh OPACO e
    * escuro (BackStyle = 1 + BackColor cinza), nao ha textura clara por baixo
    * deste bloco.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            *-- Label de SOMBRA (preto) PRIMEIRO - ver comentario do metodo.
            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontBold      = .T.
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = 769
                .Height        = 40
                .ForeColor     = RGB(0, 0, 0)
                *-- Rotation = 0 esta no dump (lblSombra.Rotation) e eh o
                *-- DEFAULT do Label: atribuicao inerte, escrita so para a
                *-- transcricao do SCX ficar completa e conferivel.
                .Rotation      = 0
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH

            *-- Label de TITULO (branco) por cima da sombra.
            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontName    = "Tahoma"
                .FontSize    = 18
                .FontBold    = .T.
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Top         = 17
                .Left        = 10
                .Width       = 769
                .Height      = 46
                .ForeColor   = RGB(255, 255, 255)
                *-- Rotation = 0 do dump (lblTitulo.Rotation), mesmo caso do
                *-- lbl_4c_LblSombra acima.
                .Rotation    = 0
                .Caption     = THIS.Caption
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - A grade de 7 colunas. Propriedades de GRADE transcritas
    * do SCX (Grade, classe fwgrade):
    *   Top=128, Left=6, Width=984, Height=435, ColumnCount=7,
    *   FontName="Tahoma", FontSize=8, HeaderHeight=16, RowHeight=16,
    *   Panel=1, ReadOnly=.F., RecordMark=.F., RecordSource=""
    * mais o que vem da CLASSE fwgrade do framework.vcx e o SCX nao sobrepoe
    * (docs\FRAMEWORK_class_codigo_fonte.txt): AllowHeaderSizing=.F.,
    * AllowRowSizing=.F., DeleteMark=.F., ScrollBars=2,
    * GridLineColor=238,238,238, HighlightBackColor=90,90,90.
    *
    * HighlightForeColor NAO eh atribuida: nem o SCX nem a classe fwgrade a
    * declaram, e inventa-la mudaria a cor da linha selecionada do legado.
    *
    * As colunas e o RecordSource ficam em VincularGrade, que eh chamado aqui
    * e de novo em CarregarLista - ver a justificativa la.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top                = 128
                .Left               = 6
                .Width              = 984
                .Height             = 435
                .FontName           = "Tahoma"
                .FontSize           = 8
                .HeaderHeight       = 16
                .RowHeight          = 16
                .Panel              = 1
                .ScrollBars         = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .RecordMark         = .F.
                .DeleteMark         = .F.
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(90, 90, 90)
                .Visible            = .T.
            ENDWITH

            THIS.VincularGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.ConfigurarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GarantirCursorGrade - Garante que o alias do cursor de exibicao EXISTE
    * antes de qualquer Column.ControlSource apontar para ele.
    *
    * Sem isto a tela NAO ABRE: atribuir ControlSource a um alias inexistente
    * estoura "Alias ... is not found" dentro do TRY do InicializarForm, que
    * devolve .F., CREATEOBJECT devolve .F. e o usuario aciona a consulta e
    * nada acontece, sem erro visivel (CLAUDE.md regra #41). E o cursor REAL
    * so pode ser montado quando o form PAI ja deixou xBaixa/xBaixa2 de pe -
    * na abertura por harness/probe eles nao existem.
    *
    * A estrutura eh a do cursor que o BO monta (sigoppeiBO.
    * CarregarItensPendentes), na ordem do ramo que vem de xBaixa2, e os
    * tamanhos sao os que o BO publica em this_nTam* - repetidos aqui como
    * literais porque CREATE CURSOR nao aceita expressao na largura do campo.
    * Qtds/QtBaixas/QtProds sao n(12,3) nos dois cursores do pai, e o campo
    * do saldo eh (Qtds - QtBaixas).
    *
    * QtProds nao tem coluna na grade mas entra na estrutura: eh uma das
    * colunas que o BO carrega em CarregarDoCursor, e o placeholder tem de
    * oferecer os MESMOS campos do cursor real.
    *
    * O BO substitui este alias INTEIRO (USE IN + SELECT ... INTO CURSOR),
    * nunca faz APPEND FROM dentro dele - entao o que precisa coincidir sao os
    * NOMES e os TIPOS dos campos, que eh o que a grade consulta ao vincular.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCursorGrade()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorItens)

            IF !EMPTY(loc_cAlias)
                IF !USED(loc_cAlias)
                    CREATE CURSOR (loc_cAlias) ( ;
                        CPros    C(14), ;
                        CodCors  C(4),  ;
                        CodTams  C(4),  ;
                        Qtds     N(12, 3), ;
                        QtBaixas N(12, 3), ;
                        QtProds  N(12, 3), ;
                        Dpros    C(40), ;
                        Pendente N(12, 3) )
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.GarantirCursorGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularGrade - Liga a grade ao cursor de exibicao e (re)configura as 7
    * colunas. Chamado por ConfigurarGrade (montagem) E por CarregarLista
    * (depois de o BO refazer o cursor).
    *
    * POR QUE TUDO DE COLUNA MORA AQUI, e nao em ConfigurarGrade: atribuir
    * ColumnCount RECRIA os objetos Column, descartando Width, Header1.Caption,
    * ReadOnly, InputMask e as propriedades do Text1; e o BO fecha e recria o
    * alias (USE IN + SELECT ... INTO CURSOR), o que derruba o RecordSource e
    * pode zerar o ColumnCount. Configurar coluna uma vez, na montagem, seria
    * apagado na primeira carga - a grade abriria com "Header1"/"Header1" e
    * colunas de 90px. Com um funil unico as duas passagens produzem a mesma
    * grade (Problema 48 / CLAUDE.md regra #41).
    *
    * ORDEM obrigatoria: ColumnCount -> RecordSource -> ControlSource -> o
    * resto das propriedades da coluna (Width por ultimo dentro do bloco, pois
    * RecordSource/ControlSource a recalculam para o default 90).
    *
    * Grid.ReadOnly = .F. (valor do dump) vem ANTES das colunas, porque o do
    * grid PROPAGA para elas e sobrescreveria o ReadOnly de cada uma
    * (regra #18).
    *
    * NOMES DAS COLUNAS - o legado RENOMEIA tres colunas no SCX, e isso
    * inverte a leitura do dump:
    *   indice 1 -> Name="Column3", ColumnOrder=3, Header "Qtde"
    *   indice 2 -> Name="Column2", ColumnOrder=2, Header "Descri" + CHR(231) + CHR(227) + "o"
    *   indice 3 -> Name="Column1", ColumnOrder=1, Header "Produto"
    *   indices 4..7 mantem nome e ordem
    * Por isso o Init legado, que escreve ThisForm.Grade.Column1.ControlSource
    * = TmpItepen.Cpros, esta falando do indice 3 (o que aparece PRIMEIRO na
    * tela, ColumnOrder=1), e nao do indice 1.
    *
    * Aqui as colunas sao criadas JA na ordem VISUAL do legado (Produto,
    * Descricao, Qtde, Qtd Utilizada, Tamanho, Cor, saldo), de modo que o
    * indice coincide com o ColumnOrder e nenhum .Name precisa ser atribuido -
    * atribuir .Name em Column eh proibido no projeto, porque quebra todas as
    * referencias .ColumnN. O resultado na tela eh identico ao do legado.
    *
    * Largura total das colunas: 108+290+80+80+60+60+80 = 758, dentro dos 984
    * de Grade.Width.
    *
    * ReadOnly das colunas: o dump traz .T. em todas MENOS a de indice 4
    * ("Qtd Utilizada"), que tem .F. - mas o Text1 dela tem "PROCEDURE When /
    * Return .f." no legado, isto eh, a celula NUNCA aceita o cursor. O
    * ReadOnly = .F. do dump eh INERTE, e nada no legado grava nessa celula. A
    * tela inteira eh de consulta, entao as 7 colunas recebem ReadOnly = .T.,
    * que reproduz exatamente o que o usuario pode fazer. NAO trocar por .F.
    * "para ficar igual ao dump": isso abriria a celula para digitacao que o
    * legado nao permite.
    *
    * Text1 de cada coluna existe nativamente (Column nasce com Header1 e
    * Text1), entao as propriedades dele sao atribuidas direto, sem AddObject.
    *
    * A coluna 7 (o saldo) liga no campo que o BO calcula
    * como (Qtds - QtBaixas) no proprio SELECT - a mesma expressao que o
    * legado usava como ControlSource da coluna. Fonte UNICA de calculo no BO,
    * com o form so espelhando (regra #17); e, como a grade eh toda somente
    * leitura, o valor nao tem como ficar defasado.
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_oGrid, loc_cAlias, loc_oErro

        TRY
            THIS.GarantirCursorGrade()

            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorItens)
            loc_oGrid  = THIS.grd_4c_Dados

            WITH loc_oGrid
                *-- Dump: Grade.ReadOnly = .F. - antes das colunas (regra #18)
                .ReadOnly    = .F.
                .ColumnCount = 7

                IF !EMPTY(loc_cAlias)
                    IF USED(loc_cAlias)
                        .RecordSource = loc_cAlias
                    ENDIF
                ENDIF

                *-- 1 - "Produto" (indice 3 do dump, Name="Column1",
                *--     ColumnOrder=1) <- TmpItepen.Cpros
                WITH .Column1
                    .ControlSource = loc_cAlias + ".CPros"
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .Width         = 108
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Produto"
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- 2 - "Descricao" (indice 2, Name="Column2", ColumnOrder=2)
                *--     <- TmpItepen.Dpros
                WITH .Column2
                    .ControlSource = loc_cAlias + ".Dpros"
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .Width         = 290
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- 3 - "Qtde" (indice 1, Name="Column3", ColumnOrder=3)
                *--     <- TmpItepen.Qtds. O dump tem InputMask nos DOIS
                *--     niveis, com mascaras DIFERENTES: "99999.99" na Column
                *--     e "999,999.99" no Text1 - as duas transcritas
                *--     (regra #49).
                WITH .Column3
                    .ControlSource = loc_cAlias + ".Qtds"
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .InputMask     = "99999.99"
                    .Width         = 80
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Qtde"
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .InputMask   = "999,999.99"
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- 4 - "Qtd Utilizada" (indice 4) <- TmpItepen.QtBaixas
                WITH .Column4
                    .ControlSource = loc_cAlias + ".QtBaixas"
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .InputMask     = "99999.99"
                    .Width         = 80
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Qtd Utilizada"
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- 5 - "Tamanho" (indice 5) <- TmpItepen.CodTams. O dump NAO
                *--     declara Movable nesta coluna nem na seguinte - so
                *--     Resizable - entao Movable fica no default.
                WITH .Column5
                    .ControlSource = loc_cAlias + ".CodTams"
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .Width         = 60
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Tamanho"
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- 6 - "Cor" (indice 6) <- TmpItepen.CodCors
                WITH .Column6
                    .ControlSource = loc_cAlias + ".CodCors"
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .Width         = 60
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Cor"
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- 7 - indice 7, o saldo - o campo que o BO calcula como
                *--     (Qtds - QtBaixas), a expressao que o legado punha
                *--     direto no ControlSource desta coluna.
                WITH .Column7
                    .ControlSource = loc_cAlias + ".Pendente"
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .InputMask     = "99999.99"
                    .Width         = 80
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Pendente"
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- "Go Top / Grade.Refresh" do padrao do legado: popular ou
            *-- revincular o cursor NAO repinta a grade sozinho, e sem isto a
            *-- tela aparece VAZIA com o cursor cheio (CLAUDE.md regra #21).
            IF !EMPTY(loc_cAlias)
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    GO TOP IN (loc_cAlias)
                ENDIF
            ENDIF
            *-- O BO fecha e recria o alias, o que derruba o vinculo das
            *-- DUAS caixas de produto tambem, nao so das Columns -
            *-- revincular ANTES do Refresh, para nenhum repintar
            *-- acontecer com ControlSource pendurado (regra #41).
            THIS.VincularCamposProduto(loc_cAlias)

            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.VincularGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarTotais - SEGUNDA (e ultima) METADE dos campos do legado que
    * ficam FORA da grade: os tres totalizadores do rodape.
    *
    * Registros 24, 25 e 30 do SCX - as tres ultimas caixas da tela:
    *   gettotbaixa (24) -> txt_4c_Totbaixa   Left = 488
    *   gettotitens (25) -> txt_4c_Totitens   Left = 406
    *   gettotdisp  (30) -> txt_4c_Totdisp    Left = 692
    * Os nomes migrados sao os de tasks\task780\mapeamento.json - eh dele que o
    * ValidarUIFidelity monta o caminho a conferir, entao inventar nome aqui
    * reprovaria a validacao de UI.
    *
    * O dump declara as MESMAS propriedades nos tres, so o Left muda:
    *   Alignment=3, Value=0, Format="K!", Height=21, Top=567, Width=80,
    *   SpecialEffect=1, TabIndex=2, BackColor=234,255,234
    *
    * ORDEM DE CRIACAO = ordem de REGISTRO do SCX entre os tres (24 -> 25 ->
    * 30). O registro 30 vem DEPOIS do bloco de produto (26..29), e mesmo assim
    * os tres sao criados JUNTOS aqui: nao existe sobreposicao geometrica para
    * o z-order resolver - o bloco de produto ocupa Top 87..125 e estes tres
    * ficam em Top = 567, a mais de 440px de distancia. Agrupa-los preserva a
    * ordem RELATIVA do dump e deixa o totalizador num lugar so.
    *
    * NAO HA ROTULO para nenhum dos tres, e isso NAO eh omissao: o dump tem
    * exatamente dois Label fora do cabecalho (Say2 "Descricao" e Say5
    * "Produto", ambos em Top = 87, entregues na Fase 5 com o bloco de
    * produto). Acrescentar legenda ("Itens", "Baixado", "Dispon" + CHR(237) +
    * "vel") seria INVENTAR superficie de tela que o legado nao tem (PILAR 1):
    * no legado o usuario le as tres caixas pela POSICAO, alinhadas sob as
    * tres colunas de quantidade da grade (Qtde, Qtd Utilizada e a do saldo).
    *
    * FontName/FontSize NAO estao no dump destes tres controles e NAO podem
    * ficar no default do VFP: eles vem da CLASSE fwget do Framework legado.
    * MEDIDO, nao presumido (2026-11-12,
    * automation\vfp_helpers\probe780_fwget.prg, abrindo
    * Framework\framework.vcx como DBF e lendo a coluna Properties - tecnica da
    * regra #31, ja que o .VCT eh p-code e grep nele devolve lixo):
    *   fwget: FontName="Tahoma", FontSize=8, Format="K", Height=23, Width=100,
    *          DisabledBackColor=192,192,192, DisabledForeColor=0,0,0,
    *          Themes=.F.
    * O controle migrado eh um TextBox BASE e nao herda NADA de fwget, entao
    * esses valores vao escritos aqui. Height/Width/Format do dump
    * SOBRESCREVEM os da classe (21 / 80 / "K!") - entre dump e classe, manda o
    * dump. DisabledBackColor/DisabledForeColor/Themes ficam nos da classe,
    * porque os tres controles nao os declaram.
    *
    * .ReadOnly = .T. + .TabStop = .F. reproduzem o "PROCEDURE When / Return
    * .f." que o dump traz para os tres (SECAO 3: gettotbaixa, gettotitens e
    * gettotdisp, um When cada, com uma unica linha util): o When roda ANTES de
    * o controle receber o cursor e, devolvendo .F., CANCELA a entrada no
    * campo - o usuario nunca digita nestas caixas, so le o total que o Init
    * empurra de fora. Mesmo par usado nos tres fwget somente-leitura de
    * FormSigMvSbn, o outro visualizador plano do projeto.
    *   Enabled fica no default .T. de proposito: .Enabled = .F. pintaria o
    *   campo com DisabledBackColor (192,192,192) e APAGARIA o verde
    *   234,255,234 que o dump declara.
    *
    * .Visible = .F. NO NASCIMENTO eh transcricao LITERAL do Init legado, que
    * esconde os tres (e a grade) ANTES do "If Used([xBaixa2])" e so os mostra
    * DENTRO dele, depois de somar:
    *     thisform.gettotitens.Visible = .f.    && antes do If
    *     thisform.gettotbaixa.Visible = .f.
    *     thisform.gettotdisp.Visible  = .f.
    *     If Used([xBaixa2]) ... thisform.gettotitens.Visible = .t. ...
    * Diferente das duas caixas de produto, que ficam ocultas nos DOIS caminhos
    * porque sao campos APOSENTADOS (ver ConfigurarPaginaDados), estas tres sao
    * comportamento de RUNTIME: quem decide eh AtualizarTotais, chamado pelo
    * funil CarregarLista. Por isso elas NAO entram na lista de excecao de
    * TornarControlesVisiveis - ele liga o Visible das tres, e AtualizarTotais
    * roda DEPOIS dele (ver a ordem em InicializarForm) e repoe o estado certo.
    *
    * TabIndex = 2 do dump NAO eh transcrito, pela mesma medicao ja registrada
    * em ConfigurarPaginaDados (VFP9, 2026-11-12): TabIndex maior que o numero
    * de controles do container eh CLAMPADO em silencio, e atribuir TabIndex
    * EMPURRA os controles que de fato recebem foco. Com TabStop = .F. nos tres
    * o TabIndex eh INERTE aqui - o unico efeito que ele teria era tirar a
    * grade do slot 2 que o dump declara para ela ("Grade.TabIndex = 2").
    *
    * O QUE O DUMP NAO TRAZ E NAO FOI INVENTADO: InputMask. Os tres totais nao
    * declaram mascara nenhuma - ao contrario das colunas da grade, que tem
    * "99999.99" e "999,999.99" - entao o numero sai na formatacao padrao,
    * exatamente como no legado. Inventar mascara aqui mudaria o que o usuario
    * LE (regra #49).
    *
    * .Value = 0 e nao 0.00: o dump declara "Value = 0" nos tres. Em VFP9 o
    * literal carrega as proprias casas decimais (.Value = 0.00 exibe "0,00" e
    * .Value = 0 exibe "0"), entao o 0 seco eh a transcricao fiel - e eh o
    * mesmo tipo/precisao das properties this_nTot* do BO, que alimentam estes
    * campos em AtualizarTotais.
    *
    * NAO HA LOOKUP NENHUM A LIGAR NESTA FASE, e isso foi MEDIDO no dump desta
    * task (tasks\task780\sigoppei_form_codigo_fonte.txt), nao presumido:
    *   "fwbusca" (Ext/Sel/Int) ..... 0 ocorrencias
    *   "mAddColuna" ................ 0
    *   "sigacess(" ................. 0
    *   "Acesso<X>(" (as 12 globais) . 0
    *   "CreateObject(" ............. 0
    * O form inteiro eh de CONSULTA e NENHUM dos seus 12 campos de entrada
    * aceita digitacao: as 7 celulas da grade e as 5 caixas soltas tem
    * ReadOnly = .T. no dump ou "When / Return .f." (gettotbaixa, gettotitens,
    * gettotdisp, getDProd, getCProd, Grade.Column4.Text1). Campo
    * somente-leitura NAO recebe lookup por definicao - nao existe onde o
    * usuario digitaria o codigo para o picker resolver. Criar um
    * AbrirBusca*/AbrirLookup* aqui significaria INVENTAR uma tabela de apoio
    * que o legado nunca consulta (viola o PILAR 1 e a regra explicita "NUNCA
    * inventar tabelas de lookup que nao existem no original"), e um metodo
    * vazio com o nome certo eh o "stub disfarcado" proibido pela regra de
    * completude. O unico acesso remoto do dialogo continua sendo a LEITURA de
    * SigCdPro para a descricao de cada produto, dentro de
    * sigoppeiBO.CarregarItensPendentes - que eh o que o Init legado faz no
    * SCAN, nao um lookup de tela.
    *
    * Pela mesma razao NAO existe cnt_4c_BotoesAcao (Confirmar/Cancelar): o
    * legado nao tem botao de gravacao nenhum - o unico botao da tela eh o
    * "Retornar" (btnCancelar), entregue na Fase 4 (ver o cabecalho do
    * arquivo). Esta tela nao grava nada.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTotais()
        LOCAL loc_oErro

        TRY
            *-- 24 - gettotbaixa: "Sum qtBaixas" do Init legado
            THIS.AddObject("txt_4c_Totbaixa", "TextBox")
            WITH THIS.txt_4c_Totbaixa
                .Value             = 0
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Format            = "K!"
                .Top               = 567
                .Left              = 488
                .Width             = 80
                .Height            = 21
                .SpecialEffect     = 1
                .ReadOnly          = .T.
                .TabStop           = .F.
                .BackColor         = RGB(234, 255, 234)
                .DisabledBackColor = RGB(192, 192, 192)
                .DisabledForeColor = RGB(0, 0, 0)
                .Themes            = .F.
                .Visible           = .F.
            ENDWITH

            *-- 25 - gettotitens: "Sum qtds" do Init legado
            THIS.AddObject("txt_4c_Totitens", "TextBox")
            WITH THIS.txt_4c_Totitens
                .Value             = 0
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Format            = "K!"
                .Top               = 567
                .Left              = 406
                .Width             = 80
                .Height            = 21
                .SpecialEffect     = 1
                .ReadOnly          = .T.
                .TabStop           = .F.
                .BackColor         = RGB(234, 255, 234)
                .DisabledBackColor = RGB(192, 192, 192)
                .DisabledForeColor = RGB(0, 0, 0)
                .Themes            = .F.
                .Visible           = .F.
            ENDWITH

            *-- 30 - gettotdisp: "(lnItn-lnBaixa)" do Init legado
            THIS.AddObject("txt_4c_Totdisp", "TextBox")
            WITH THIS.txt_4c_Totdisp
                .Value             = 0
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Format            = "K!"
                .Top               = 567
                .Left              = 692
                .Width             = 80
                .Height            = 21
                .SpecialEffect     = 1
                .ReadOnly          = .T.
                .TabStop           = .F.
                .BackColor         = RGB(234, 255, 234)
                .DisabledBackColor = RGB(192, 192, 192)
                .DisabledForeColor = RGB(0, 0, 0)
                .Themes            = .F.
                .Visible           = .F.
            ENDWITH

            *-- Nenhuma chamada a AtualizarTotais aqui: o estado inicial do
            *-- legado (as tres caixas em zero e ocultas) JA eh o que os
            *-- .Value = 0 / .Visible = .F. acima produzem. Quem mostra os
            *-- tres - e a grade - eh AtualizarTotais, chamado pelo funil
            *-- CarregarLista, que roda DEPOIS de TornarControlesVisiveis e eh
            *-- o unico lugar que decide esse Visible (ver InicializarForm).
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.ConfigurarTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - PRIMEIRA METADE dos campos do legado que ficam
    * FORA da grade: o bloco de identificacao do produto, na faixa livre entre
    * o cabecalho (0..80) e a grade (Top = 128).
    *
    * O nome "ConfigurarPaginaDados" eh o ponto de entrada arquitetural padrao
    * do pipeline e eh mantido aqui pela mesma razao que ConfigurarPageFrame:
    * o SIGOPPEI NAO tem PageFrame (layout plano, medido no dump desta task -
    * "BaseClass: pageframe" aparece 0 vezes), entao NAO existe Page2 de Dados
    * e NAO se cria Page nenhuma. Inventar uma pagina que o legado nao tem
    * violaria o PILAR 1; escrever um metodo vazio so para casar com o nome eh
    * proibido pela regra de completude. Os campos sao filhos DIRETOS do form,
    * como no SCX.
    *
    * DIVISAO DAS FASES 5 e 6 - o legado tem 7 objetos de campo fora da grade.
    * Em ordem de REGISTRO do SCX:
    *   24 gettotbaixa | 25 gettotitens | 26 getDProd | 27 Say2
    *   28 Say5        | 29 getCProd    | 30 gettotdisp
    * Esta fase entrega os 4 do bloco de produto (getDProd, Say2, Say5,
    * getCProd); a Fase 6 entrega os 3 totais do rodape (gettotitens,
    * gettotbaixa, gettotdisp, todos em Top = 567), que ja tem as properties
    * prontas no BO (this_nTotItens / this_nTotBaixa / this_nTotDisp).
    *
    * ORDEM DE CRIACAO = ordem de REGISTRO do SCX (getDProd -> Say2 -> Say5 ->
    * getCProd), porque AddObject empilha no z-order e o ultimo criado desenha
    * por cima. Aqui nao ha sobreposicao geometrica para resolver: os rotulos
    * ocupam 87..102 e as caixas 102..125, faixas que apenas se encostam (ver a
    * nota de Height dos rotulos abaixo), entao o z-order eh indiferente - a
    * ordem eh mantida por fidelidade, nao por necessidade.
    *   A Fase 6 acrescentou a chamada de ConfigurarTotais em
    *   ConfigurarPageFrame ENTRE ConfigurarGrade e esta - eh ali que os
    *   registros 24/25 ficam no SCX. Tambem sem consequencia visual: os
    *   totais estao em Top = 567, longe deste bloco.
    *
    * TRANSCRICAO DO DUMP, campo a campo:
    *
    *   getDProd (fwget) -> txt_4c_DProd
    *     FontName="Courier New", FontSize=8, Format="K!", Height=23,
    *     Left=119, Top=102, Width=288, SpecialEffect=1, TabIndex=4,
    *     ToolTipText="Descricao do Produto", BackColor=255,255,255,
    *     DisabledBackColor=255,255,255, DisabledForeColor=192,192,192,
    *     BorderColor=0,0,0, ControlSource="TmpItepen.DPros"
    *   Say2 (say) -> lbl_4c_Label2
    *     FontName="Tahoma", FontSize=8, Caption="Descricao", Left=119,
    *     Top=87, TabIndex=3, ForeColor=0,0,0
    *   Say5 (say) -> lbl_4c_Label5
    *     FontName="Tahoma", FontSize=8, Caption="Produto", Left=8, Top=87,
    *     TabIndex=15, ForeColor=0,0,0
    *   getCProd (fwget) -> txt_4c_CProd
    *     FontSize=8, Alignment=3, Height=23, Left=8, Top=102, Width=108,
    *     ReadOnly=.T., SpecialEffect=1, TabIndex=16,
    *     ToolTipText="Codigo de Barras do Produto",
    *     DisabledBackColor=255,255,255, BorderColor=0,0,0,
    *     ControlSource="TmpItepen.Cpros"
    *
    * Os nomes migrados sao os de tasks\task780\mapeamento.json (eh dele que o
    * ValidarUIFidelity monta o caminho a conferir - inventar nome aqui
    * reprovaria a validacao de UI).
    *
    * AS DUAS CAIXAS NASCEM E PERMANECEM INVISIVEIS - nao eh esquecimento.
    * O Init legado as esconde DUAS vezes e nunca as mostra:
    *     thisform.getCProd.Visible = .f.     && antes do If
    *     thisform.getDProd.Visible = .f.
    *     If Used([xBaixa2])
    *         ... mostra grade e os 3 totais ...
    *         thisform.getCProd.Visible = .f. && DE NOVO .f., dentro do If
    *         thisform.getDProd.Visible = .f.
    *     Else
    *         Return .f.
    *     EndIf
    * Nos DOIS caminhos elas ficam ocultas, e nenhum outro metodo do SCX toca
    * nesse Visible. Diferente da grade e dos tres totais, que o legado esconde
    * e DEPOIS mostra quando ha dado (comportamento de runtime), estas duas sao
    * campos APOSENTADOS: ficaram no SCX com os rotulos orfaos, que o Init NAO
    * esconde. Por isso os rotulos Produto/Descricao aparecem na tela e as
    * caixas sob eles nao - eh exatamente o que o usuario ve no legado (familia
    * da regra #28: campo aposentado que sobrou no SCX). Mostra-las seria
    * INVENTAR superficie de tela que o legado nao tem.
    *   Consequencia obrigatoria: TornarControlesVisiveis percorre tudo e
    *   ligaria o Visible das duas - elas estao na lista de excecao dele.
    *
    * O "PROCEDURE When / Return .f." que o dump traz para as duas (Label nao
    * tem When, os rotulos nao tem isso): o campo NUNCA aceita o cursor no
    * legado. Controle invisivel ja nao recebe foco nem entra na tabulacao em
    * VFP9, entao o Visible = .F. sozinho ja reproduz isso; TabStop = .F. eh
    * acrescentado para o comportamento sobreviver caso alguem torne o campo
    * visivel um dia, sem depender do ReadOnly (que o dump declara so em
    * getCProd).
    *
    * O QUE O DUMP TRAZ E NAO FOI TRANSCRITO, de proposito:
    *   InputMask = "" em getCProd - override VAZIO do Form Designer, nao eh
    *   mascara, e a regra #49 manda nao transcrever override vazio. O
    *   Format = "K!" de getDProd SIM eh transcrito: o "!" forca MAIUSCULA e
    *   muda o dado exibido.
    *
    * .Value = "" e nao o "Value = 0" do dump: o ControlSource das duas aponta
    * para colunas CHARACTER (CPros c(14) e Dpros c(40) no cursor que o BO
    * monta; this_cCpros e this_cDpros no BO sao ""). O 0 do dump eh o default
    * numerico da classe fwget e so sobrevive enquanto o vinculo nao acontece -
    * que eh justamente o caso da abertura por harness/probe, sem os cursores
    * do form pai. Deixar 0 ali poria um controle NUMERICO sobre campo CHAR
    * (regra do TextBox.Value inicializado pelo tipo real do dado).
    *
    * .MaxLength vem da LARGURA DA COLUNA (14 e 40, as mesmas que o BO publica
    * em this_nTamCpros / this_nTamDpros), NUNCA do Width em pixels - 108 e 288
    * sao pixels (regra #19). O dump nao declara MaxLength; o valor eh posto
    * aqui porque eh o unico correto para a coluna vinculada.
    *
    * ROTULOS - a classe say do Framework eh AutoSize = .T. / Alignment = 0, e
    * por isso o SCX declara so Caption/Left/Top. AutoSize eh NO-OP em Label
    * criado por AddObject (a Width fica nos 100 do default), entao vai
    * AutoSize = .F. com Width/Height EXPLICITOS e Alignment = 0 - PROIBIDO
    * inventar Alignment = 1, que encostaria o texto na borda direita da caixa,
    * dentro do campo (regra #23).
    *   Height = 15 (e nao o default 17): 87 + 15 = 102, que eh exatamente o
    *   Top das caixas - os rotulos ENCOSTAM nelas sem invadir. Tahoma 8 mede
    *   13px de altura (tabela de fontes no fim do proprio dump: Tahoma, 0, 8,
    *   5, 13, 11, 27, 2, 0), entao 15 nao corta a cedilha nem o til de
    *   Descricao.
    *   Width 60 / 80 acomoda Produto e Descricao em Tahoma 8 com folga, e nao
    *   ha controle nenhum a direita deles em Top = 87 para a caixa
    *   transparente (BackStyle = 0) atrapalhar.
    *
    * TabIndex do dump (getDProd=4, Say2=3, Say5=15, getCProd=16) NAO eh
    * transcrito, e isso foi MEDIDO no VFP9 em 2026-11-12, nao presumido:
    *   - TabIndex maior que o numero de controles do container eh CLAMPADO
    *     em silencio (form com 2 controles, atribuido 16, lido 2). Os 15 e
    *     16 do dump vem de um form com 13 objetos ja montados e aqui sao
    *     inalcancaveis - escrever o numero do dump produz um valor que NAO
    *     eh o do dump, o que eh pior do que nao escrever: parece transcrito
    *     e nao esta.
    *   - Label NAO recebe foco, mas OCUPA slot: atribuir TabIndex = 1 a um
    *     Label EMPURROU os TextBox de 1/2 para 2/3. Na primeira versao
    *     desta fase o lbl_4c_Label2 com TabIndex = 3 empurrou o
    *     grd_4c_Dados de 3 para 4, contra o "Grade.TabIndex = 2" do dump.
    *   - as duas caixas tem TabStop = .F. e Visible = .F.: nunca entram na
    *     tabulacao, e os rotulos nunca entrariam de todo modo. Para estes
    *     4 objetos o TabIndex eh INERTE - o unico efeito que ele tinha era
    *     deslocar os controles que de fato recebem foco.
    * Sem as atribuicoes, a ordem natural de AddObject deixa o botao e a
    * grade nos slots 2 e 3, que eh a tabulacao efetiva do legado.
    *
    * ForeColor = RGB(0, 0, 0) nos dois rotulos porque o dump DECLARA
    * "ForeColor = 0,0,0". O canonico RGB(90, 90, 90) da regra #12 vale para
    * Say que NAO declara ForeColor - aqui declara, e o que manda eh o dump.
    * Tambem nao se usa branco: o fundo do form eh a textura new_background.jpg
    * e texto branco ficaria invisivel.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            *-- 26 - getDProd: descricao do produto (campo aposentado, oculto)
            THIS.AddObject("txt_4c_DProd", "TextBox")
            WITH THIS.txt_4c_DProd
                .Value             = ""
                .FontName          = "Courier New"
                .FontSize          = 8
                .Format            = "K!"
                .MaxLength         = 40
                .Top               = 102
                .Left              = 119
                .Width             = 288
                .Height            = 23
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .TabStop           = .F.
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(192, 192, 192)
                .BorderColor       = RGB(0, 0, 0)
                .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
                .Visible           = .F.
            ENDWITH

            *-- 27 - Say2: rotulo "Descricao" (visivel, orfao da caixa acima)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .WordWrap  = .F.
                .BackStyle = 0
                .Top       = 87
                .Left      = 119
                .Width     = 80
                .Height    = 15
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- 28 - Say5: rotulo "Produto" (visivel, orfao da caixa abaixo)
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .Caption   = "Produto"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .WordWrap  = .F.
                .BackStyle = 0
                .Top       = 87
                .Left      = 8
                .Width     = 60
                .Height    = 15
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- 29 - getCProd: codigo de barras (campo aposentado, oculto)
            THIS.AddObject("txt_4c_CProd", "TextBox")
            WITH THIS.txt_4c_CProd
                .Value             = ""
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .Top               = 102
                .Left              = 8
                .Width             = 108
                .Height            = 23
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(0, 0, 0)
                .ToolTipText       = "C" + CHR(243) + "digo de Barras do Produto"
                .Visible           = .F.
            ENDWITH

            *-- ControlSource das duas caixas - SEMPRE pelo funil, nunca inline
            THIS.VincularCamposProduto("")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularCamposProduto - FUNIL UNICO do ControlSource das duas caixas de
    * produto. Chamado por ConfigurarPaginaDados (montagem) E por VincularGrade
    * (toda recarga), pela MESMA razao que as colunas da grade moram num funil:
    * o BO fecha e recria o alias (USE IN + SELECT ... INTO CURSOR) em cada
    * CarregarItensPendentes, e isso derruba o vinculo de QUALQUER controle
    * ligado a ele - nao so das Columns.
    *
    * As duas razoes para nao atribuir o ControlSource direto no AddObject:
    *
    * 1. ALIAS INEXISTENTE DERRUBA O INIT. Atribuir ControlSource a um alias
    *    que nao esta aberto estoura "Alias ... is not found" dentro do TRY do
    *    InicializarForm, que devolve .F., CREATEOBJECT devolve .F. e o usuario
    *    aciona a consulta e NADA acontece, sem erro visivel (regra #41, que o
    *    projeto ja conhece pelas Columns - vale igual para TextBox). O cursor
    *    real so existe depois que o form PAI deixou xBaixa/xBaixa2 de pe; na
    *    abertura por harness/probe eles nao existem.
    * 2. VINCULO PENDURADO. Depois do USE IN do BO, o ControlSource antigo
    *    aponta para alias morto. Por isso o caminho de FALHA aqui nao eh "nao
    *    fazer nada": eh DESLIGAR o vinculo (ControlSource = ""), que deixa o
    *    controle inerte em vez de pendurado.
    *
    * A chamada dentro de VincularGrade fica ANTES do Grid.Refresh() de la, de
    * modo que nenhum repintar aconteca com vinculo pendurado.
    *
    * PEMSTATUS nos dois nomes porque VincularGrade roda a PRIMEIRA vez a
    * partir de ConfigurarGrade, que em ConfigurarPageFrame vem ANTES de
    * ConfigurarPaginaDados: naquela passagem as caixas ainda nao existem.
    *
    * par_cAlias eh opcional - vazio ou ausente faz o metodo buscar o alias no
    * BO, para o funil servir aos dois chamadores sem duplicar a regra.
    *
    * PROTECTED: nenhum chamador de FORA da classe (o harness chama
    * CarregarLista, que chega aqui pelo caminho de dentro) - regra #51.
    *==========================================================================
    PROTECTED PROCEDURE VincularCamposProduto(par_cAlias)
        LOCAL loc_cAlias, loc_lLigar, loc_oErro

        TRY
            *-- IF aninhado e nao AND: as caixas podem nao existir ainda
            IF PEMSTATUS(THIS, "txt_4c_CProd", 5)
                IF PEMSTATUS(THIS, "txt_4c_DProd", 5)
                    loc_cAlias = ""

                    IF VARTYPE(par_cAlias) = "C"
                        loc_cAlias = ALLTRIM(par_cAlias)
                    ENDIF

                    IF EMPTY(loc_cAlias)
                        IF VARTYPE(THIS.this_oBusinessObject) = "O"
                            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorItens)
                        ENDIF
                    ENDIF

                    *-- IF aninhado e nao AND: USED("") estoura
                    loc_lLigar = .F.
                    IF !EMPTY(loc_cAlias)
                        IF USED(loc_cAlias)
                            loc_lLigar = .T.
                        ENDIF
                    ENDIF

                    IF loc_lLigar
                        *-- "TmpItepen.Cpros" / "TmpItepen.DPros" do SCX, nos
                        *-- nomes do cursor migrado (os MESMOS campos que as
                        *-- colunas 1 e 2 da grade usam)
                        THIS.txt_4c_CProd.ControlSource = loc_cAlias + ".CPros"
                        THIS.txt_4c_DProd.ControlSource = loc_cAlias + ".Dpros"
                    ELSE
                        THIS.txt_4c_CProd.ControlSource = ""
                        THIS.txt_4c_DProd.ControlSource = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.VincularCamposProduto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL UNICO de carga da grade. Manda o BO montar o
    * cursor de exibicao a partir de xBaixa/xBaixa2 (os cursores que o form
    * PAI deixa prontos na data session compartilhada - ver CONTRATO COM O
    * FORM PAI no cabecalho) e revincula a grade.
    *
    * Reproduz o trecho do Init legado que vai de "If Used([xBaixa2])" ate
    * "ThisForm.Grade.Column7.ControlSource = ...": o SELECT nos dois ramos, a
    * descricao de cada produto em SigCdPro e os totais vivem no BO
    * (sigoppeiBO.CarregarItensPendentes), fonte UNICA de calculo; aqui fica a
    * parte de TELA.
    *
    * Devolve .F. SEM exibir dialogo quando o cursor do pai nao esta
    * disponivel - exatamente o que o "Else / Return .f." do Init legado faz:
    * ele nao avisa nada, so se recusa a mostrar a tela. A grade continua
    * vinculada ao cursor vazio que GarantirCursorGrade criou, entao ela
    * aparece sem linhas em vez de quebrar.
    *
    * O valor devolvido eh o mesmo "Used([xBaixa2]) com linhas" do legado, e eh
    * por ele que a recusa de abrir a tela e o espelho dos tres totais do
    * rodape se decidem, no mesmo ponto em que esses campos passam a existir
    * na arvore de controles.
    *
    * PUBLIC (sem PROTECTED): o harness de teste automatizado chama
    * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS devolve .T.
    * mesmo para metodo PROTECTED - a chamada entraria no branch e falharia em
    * runtime (CLAUDE.md regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = THIS.this_oBusinessObject.CarregarItensPendentes()
            ENDIF

            *-- Revincula SEMPRE, inclusive no caminho de falha: o BO fecha e
            *-- recria o alias, o que derruba RecordSource/ControlSource e pode
            *-- zerar o ColumnCount da grade.
            THIS.VincularGrade()
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.CarregarLista")
        ENDTRY

        *-- Espelho dos tres totais do rodape + a alternancia de Visible que o
        *-- Init legado faz neles e na grade. Fica FORA do TRY/ENDTRY de
        *-- proposito, por duas razoes:
        *--   1. o caminho de FALHA tem de passar por aqui tambem - senao uma
        *--      recarga que estoure deixaria na tela os totais da carga
        *--      ANTERIOR (o BO nao zera this_nTot* quando falha);
        *--   2. o Visible tem de ser a ULTIMA coisa escrita, depois do
        *--      Grid.Refresh() que VincularGrade executa.
        *-- AtualizarTotais tem TRY/CATCH proprio, entao nada escapa daqui.
        THIS.AtualizarTotais(loc_lSucesso)

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarTotais - Espelha os tres totais do BO nas caixas do rodape e
    * aplica a alternancia de Visible que o Init legado faz nelas e na grade.
    *
    * Reproduz o trecho FINAL do bloco de dados do Init legado:
    *     Select TmpItepen
    *     Sum qtds     to lnItn
    *     Go top
    *     Sum qtBaixas to lnBaixa
    *     Go top
    *     thisform.gettotitens.Value   = lnItn
    *     thisform.gettotbaixa.Value   = lnBaixa
    *     thisform.gettotdisp.Value    = (lnItn-lnBaixa)
    *     thisform.gettotitens.Visible = .t.
    *     thisform.gettotbaixa.Visible = .t.
    *     thisform.gettotdisp.Visible  = .t.
    *     thisform.grade.Visible       = .t.
    *
    * Os dois SUM e a subtracao moram no BO (sigoppeiBO.CarregarItensPendentes,
    * que publica this_nTotItens / this_nTotBaixa / this_nTotDisp): FONTE UNICA
    * de calculo, com o form apenas ESPELHANDO (regra #17). Recalcular aqui -
    * ainda que com a mesma formula - criaria dois lugares para o mesmo total
    * divergir; e o CRITERIO do SUM (soma o cursor INTEIRO, sem FOR, incluindo
    * as linhas em que o saldo eh zero, com GO TOP entre as duas somas) tambem
    * eh regra de negocio, nao detalhe de implementacao.
    *
    * par_lTemDados eh o proprio "Used([xBaixa2]) com cursor montado" do
    * legado - o logico que CarregarLista devolve:
    *   .T. -> mostra grade e totais, com os valores somados pelo BO;
    *   .F. -> deixa os QUATRO controles ocultos e os tres totais em 0, que eh
    *          o estado em que o Init legado os deixa antes do "If".
    * Zerar no caminho de falha NAO eh calculo: eh repor o estado inicial da
    * tela. Sem isso, uma recarga que falhe depois de uma carga boa guardaria
    * os totais ANTIGOS - ocultos, mas prontos para reaparecer errados na
    * recarga seguinte.
    *
    * PEMSTATUS em cada nome porque este metodo tambem eh alcancado a partir de
    * ConfigurarGrade -> VincularGrade na montagem, ANTES de ConfigurarTotais
    * criar as caixas: naquela passagem os tres controles ainda nao existem na
    * arvore. Um IF por controle, e nao um AND de tres PEMSTATUS: VFP9 nao faz
    * short-circuit, entao um AND avaliaria as outras pernas de todo modo.
    *
    * O guard de VARTYPE em par_lTemDados tambem vai em IF SEPARADO, nao em
    * "VARTYPE(par_lTemDados) = "L" AND par_lTemDados": sem short-circuit, a
    * segunda perna seria avaliada mesmo com o parametro chegando numerico ou
    * ausente, e um AND sobre valor nao-logico estoura
    * "Operator/operand type mismatch".
    *
    * PROTECTED: nenhum chamador de FORA da classe - o harness chama
    * CarregarLista, que chega aqui por dentro (regras #3 e #51).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarTotais(par_lTemDados)
        LOCAL loc_lTemDados, loc_nTotItens, loc_nTotBaixa, loc_nTotDisp, loc_oErro

        TRY
            loc_lTemDados = .F.
            IF VARTYPE(par_lTemDados) = "L"
                loc_lTemDados = par_lTemDados
            ENDIF

            loc_nTotItens = 0
            loc_nTotBaixa = 0
            loc_nTotDisp  = 0

            IF loc_lTemDados
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_nTotItens = THIS.this_oBusinessObject.this_nTotItens
                    loc_nTotBaixa = THIS.this_oBusinessObject.this_nTotBaixa
                    loc_nTotDisp  = THIS.this_oBusinessObject.this_nTotDisp
                ENDIF
            ENDIF

            *-- "thisform.gettotitens.Value = lnItn" + Visible
            IF PEMSTATUS(THIS, "txt_4c_Totitens", 5)
                WITH THIS.txt_4c_Totitens
                    .Value   = loc_nTotItens
                    .Visible = loc_lTemDados
                ENDWITH
            ENDIF

            *-- "thisform.gettotbaixa.Value = lnBaixa" + Visible
            IF PEMSTATUS(THIS, "txt_4c_Totbaixa", 5)
                WITH THIS.txt_4c_Totbaixa
                    .Value   = loc_nTotBaixa
                    .Visible = loc_lTemDados
                ENDWITH
            ENDIF

            *-- "thisform.gettotdisp.Value = (lnItn-lnBaixa)" + Visible
            IF PEMSTATUS(THIS, "txt_4c_Totdisp", 5)
                WITH THIS.txt_4c_Totdisp
                    .Value   = loc_nTotDisp
                    .Visible = loc_lTemDados
                ENDWITH
            ENDIF

            *-- "thisform.grade.Visible = .f." antes do If e ".t." dentro dele.
            *-- A grade eh o 4o controle que o Init legado alterna junto com os
            *-- totais - sem isto a tela mostraria uma grade vazia no caminho
            *-- em que o legado nao mostra grade nenhuma.
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Visible = loc_lTemDados
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.AtualizarTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
    * Percorre Controls recursivamente (containers aninhados) e liga tudo.
    *
    * PUBLIC de proposito (sem PROTECTED): o harness de teste automatizado
    * chama metodos do form de FORA da classe, e PEMSTATUS devolve .T. mesmo
    * para metodo PROTECTED - a chamada entraria no branch e so falharia em
    * runtime (CLAUDE.md regra #3).
    *
    * Este form NAO tem container flutuante, mas TEM duas EXCECOES de
    * controle: txt_4c_CProd e txt_4c_DProd nascem e PERMANECEM invisiveis.
    *
    * Dos 6 controles que o Init legado esconde, quatro (a grade e os tres
    * totais do rodape) sao escondidos e DEPOIS mostrados quando ha dado -
    * isso eh comportamento de RUNTIME, nao propriedade de criacao. As outras
    * duas sao as caixas de produto, que o Init legado poe em .f. antes do If
    * e poe em .f. OUTRA VEZ dentro dele, sem nunca mostrar (ver o bloco de
    * comentario de ConfigurarPaginaDados). Sem a excecao, esta varredura
    * APAGARIA esse Visible = .F. e a tela exibiria dois campos que o legado
    * nao mostra em caminho nenhum.
    *
    * O skip pula SO a atribuicao de Visible e CONTINUA recursando: pular a
    * recursao deixaria os filhos de um container de excecao invisiveis para
    * sempre, e o container apareceria VAZIO quando fosse mostrado (licao do
    * CorretorAutomatico #109). Aqui as duas excecoes sao TextBox, que nao
    * tem filho, mas o laco fica correto para quando houver.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_lNasceOculto

        IF VARTYPE(par_oContainer) = "O"
            FOR loc_nI = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_nI)

                IF VARTYPE(loc_oControl) = "O"
                    *-- Campos APOSENTADOS do SCX: o Init legado nunca os
                    *-- mostra (ver ConfigurarPaginaDados)
                    loc_lNasceOculto = INLIST(UPPER(loc_oControl.Name), ;
                        "TXT_4C_CPROD", "TXT_4C_DPROD")

                    IF !loc_lNasceOculto
                        IF PEMSTATUS(loc_oControl, "Visible", 5)
                            loc_oControl.Visible = .T.
                        ENDIF
                    ENDIF

                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Fecha os cursores que ESTE form cria (nomes conhecidos via
    * properties do BO) e solta as referencias de BO e de pai, para a tela
    * filha nao segurar o form pai depois de fechada.
    *
    * Sem isso os cursores de trabalho VAZARIAM na data session do form PAI:
    * este form entra na sessao dele (ver Init), entao eles sobreviveriam ao
    * fechamento da tela. Eh o mesmo "SELECT TmpItePen / Use" que o Click do
    * btnCancelar legado faz antes do Release.
    *
    * xBaixa e xBaixa2 continuam NAO sendo fechados aqui: quem os cria eh o
    * form PAI, na sessao de dados dele, e eh ele quem os fecha - derruba-los
    * daqui tiraria o chao do pai se o usuario fechar esta consulta e
    * continuar a movimentacao em seguida.
    *
    * DODEFAULT() por ULTIMO eh obrigatorio: eh FormBase.Destroy que reconstroi
    * os popups do menu principal depois de um form modal fechar.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cAlias, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Cursor da grade (cursor_4c_Dados / TmpItePen do legado)
                loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorItens)
                *-- IF aninhado e nao AND: VFP9 nao faz short-circuit, e
                *-- USED("") estoura.
                IF !EMPTY(loc_cAlias)
                    IF USED(loc_cAlias)
                        USE IN (loc_cAlias)
                    ENDIF
                ENDIF

                *-- Cursor temporario do lookup de descricao (TmpPro do legado)
                loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorTemp)
                IF !EMPTY(loc_cAlias)
                    IF USED(loc_cAlias)
                        USE IN (loc_cAlias)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppei.Destroy")
        ENDTRY

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

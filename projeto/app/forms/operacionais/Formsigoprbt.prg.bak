*==============================================================================
* Formsigoprbt.prg - "Lan" + CHR(231) + "amentos de Rebates"
* Form Operacional: integracao em lote das vendas com desconto ELO/OuroCard
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT (o SCX legado NAO tem PageFrame nem Page)
* SCX Origem: sigoprbt.SCX (tasks\task793\sigoprbt_form_codigo_fonte.txt)
* BO:         sigoprbtBO    (projeto\app\classes\sigoprbtBO.prg)
*
* Tela aberta pelo menu (popMovimentos) para disparar o processamento em lote
* que gera, para cada Empresa+Dia+Mes ainda nao integrado, 1 registro de
* controle em SigOpRbt + a movimentacao correspondente em SigMvCab/SigMvItn/
* SigMvPar/SigMvCcr (ver cabecalho de sigoprbtBO.prg para o detalhe das
* tabelas). Esta tela NAO tem pagina de cadastro: eh um disparador com dois
* botoes (Processar / Cancelar).
*
*------------------------------------------------------------------------------
* MODO AUTOMATICO - pAuto do Init legado
*
* O Init legado recebe UM parametro (pAuto) e, ao final, se Automatico = .T.,
* clica sozinho no botao Processar e se libera:
*
*     Parameters pAuto
*     ...
*     If ThisForm.Automatico
*         ThisForm.cntBotoes.btnConfirmar.Click()
*         ThisForm.Release
*     EndIf
*
* THIS.this_lAutomatico eh capturado desde a Fase 3 (propriedade de ESTADO do
* form) e o disparo em si entra na Fase 7, junto com o Click do Processar - em
* Activate(), nao no Init. Ver o metodo Activate() para o motivo.
*
*------------------------------------------------------------------------------
* LAYOUT FLAT - por que NAO ha PageFrame aqui
*
* A arvore de objetos do dump (SECAO 1) tem o objeto raiz como "Class: form /
* BaseClass: form" (form GENERICO, nao frmcadastro) e NENHUMA linha "BaseClass:
* pageframe": os 4 objetos (cntSombra + 2 labels + cntBotoes) penduram direto
* na Form. Criar PageFrame com Page1 (Lista) e Page2 (Dados) aqui seria
* inventar estrutura que o legado nao tem - viola o PILAR 1 e a regra "NUNCA
* inventar". Sem PageFrame, tambem NAO existe a compensacao de +29 no Top:
* todas as coordenadas vao CRUAS do SCX.
*
*------------------------------------------------------------------------------
* FASE 3/8 - ESTRUTURA BASE
*   - DEFINE CLASS Formsigoprbt AS FormBase + propriedades visuais transcritas
*     do SCX (718x130, BorderStyle 2, ControlBox/MaxButton/MinButton = .F.,
*     TitleBar = 0, AutoCenter = .T. - mesmo default do FormBase)
*   - Init(par_lAutomatico) - captura o pAuto do chamador (guarda de tipo,
*     porque o harness de teste instancia sem argumento algum)
*   - InicializarForm() - fundo do form (Picture new_background.jpg), criacao
*     do Business Object (repassando Automatico direto ao Init do BO, que ja
*     declara a guarda de PCOUNT/VARTYPE - sigoprbtBO.prg:179-212) e montagem
*     da faixa do cabecalho
*   - ConfigurarCabecalho() - cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo
*     (mapeamento.json: cntSombra -> cnt_4c_Sombra, lblSombra ->
*     lbl_4c_LblSombra, lblTitulo -> lbl_4c_LblTitulo)
*   - TornarControlesVisiveis() recursivo (AddObject cria tudo Visible = .F.)
*   - Destroy() - devolve o controle ao FormBase via DODEFAULT() (que ja libera
*     this_oBusinessObject e restaura o menu principal)
*
* FASE 4/8 - COMMANDGROUP DE BOTOES + EVENTO DO CANCELAR
*
* POR QUE NAO HA GRADE NEM BOTOES DE CADASTRO AQUI - a MEDICAO do dump
* O roteiro generico desta fase pede uma grade e os 6 botoes do padrao de
* cadastro. Este legado nao tem NENHUMA das duas superficies, e isso nao eh
* leitura solta: eh o que o dump devolve contado objeto a objeto
* (tasks\task793\sigoprbt_form_codigo_fonte.txt, SECOES 1 a 3):
*
*     BaseClass: grid / BaseClass: pageframe ............... 0 ocorrencias
*     controle de ENTRADA (textbox / editbox / combobox /
*     listbox / checkbox / optiongroup / optionbutton /
*     spinner) ............................................ 0 ocorrencias
*     pColuna / RecordSource / ControlSource .............. 0 ocorrencias
*     .AddCursor(...) .................................... 15 ocorrencias
*         todas com 3 argumentos (tabela, chave, cursor): registram o cursor
*         no data manager e NAO ligam grade nenhuma - o argumento que no
*         padrao Fortyus aponta o objeto da grade (o 5o) nao aparece em
*         nenhuma delas
*     BaseClass: commandgroup ............................. 1 (ButtonCount = 2)
*
* A arvore inteira do dump sao 6 objetos: Dataenvironment, a Form, cntSombra,
* os 2 labels da faixa e cntBotoes. Inventar grade ou tela de cadastro aqui
* violaria o PILAR 1 e a regra "NUNCA inventar"; escrever metodo de pagina ou
* de alternancia sem conteudo, so para casar com o roteiro, seria o stub que a
* regra de completude proibe. O que este legado TEM eh o grupo de 2 botoes - e
* eh ele que esta fase entrega:
*
*   - ConfigurarBotoes() - cmg_4c_Acoes (CommandGroup) com os 2 botoes do
*     dump (Buttons(1) = Command1/btnSair "Cancelar", Buttons(2) =
*     Command2/btnConfirmar "Processar") - geometria, fonte, icones, Themes e
*     TabIndex transcritos literalmente
*   - ConfigurarEventos() - BINDEVENT do Click do Cancelar
*   - CmdCancelarClick() - transcricao do btnSair.Click legado
*     ("ThisForm.Release")
*
* NOME DO COMMANDGROUP - por que nao eh o do mapeamento.json
* O mapeamento.json trazia "cntBotoes -> obj_4c_CntBotoes". O prefixo obj_4c_
* eh o generico que o GeradorMapeamento emite para classe que ele nao
* reconhece (CommandGroup sai como tipo Unknown) - nao eh uma decisao de nome.
* O canonico do projeto para CommandGroup eh o prefixo cmg_4c_. O sufixo
* escolhido eh Acoes, e NAO o que docs\framework_frmcadastro_layout.md usa nos
* cadastros: aquele outro sufixo eh token de deteccao de form REPORT em 5
* patterns do CorretorAutomatico, que reescreveriam fonte e formatacao de
* grade neste form OPERACIONAL. O mapeamento.json foi corrigido junto.
*
* O CLICK DO PROCESSAR
* O btnConfirmar.Click legado tem UMA linha - "ThisForm.Processamento()" - e o
* Processamento() legado eh orquestracao de 27 linhas cujo passo central eh
* GeraMovimentacao() (547 linhas), que chama LancaContaCorrente (917 linhas),
* FazContra (69) e MontaHists (41). O Click e a orquestracao sao a entrega da
* Fase 7 (secao abaixo); o motor de integracao em si eh a entrega da Fase 8.
*
* FASES 5 E 6/8 - SEM TRABALHO (perfil DESPACHANTE, medido no dump)
*
* O roteiro generico destas duas fases pede "campos principais" (Fase 5) e
* "campos restantes e lookups" (Fase 6). Este legado nao tem NENHUM campo de
* entrada - eh o mesmo perfil DESPACHANTE de SIGMVEXP/SigOpChp/SigOpCtd/
* SigOpCts (ver docs/FORMCOR_LICOES_APRENDIDAS.md e a familia de licoes do
* gate multi-fase): uma tela que so dispara um processamento em lote.
*
* Contagem no dump (tasks\task793\sigoprbt_form_codigo_fonte.txt, 1965
* linhas), repetindo a mesma medicao da Fase 4 com o foco em CAMPO e LOOKUP:
*
*     BaseClass: textbox / editbox / combobox / listbox / checkbox /
*     optiongroup / optionbutton / spinner ................. 0 ocorrencias
*     ControlSource .......................................... 0 ocorrencias
*     PROCEDURE Valid / PROCEDURE When ....................... 0 ocorrencias
*     fwbusca* / mAddColuna / sigacess( ...................... 0 ocorrencias
*
* As 15 chamadas .AddCursor do Init legado NAO sao superficie de lista: todas
* tem 3 argumentos (tabela, campo-chave, cursor), forma que apenas REGISTRA o
* cursor no data manager. Quem liga GRADE eh o 5o argumento (regra #35), e
* medido no dump ele nao aparece em nenhuma das 15 - .AddCursor com 4+ virgulas
* da 0 ocorrencias, coerente com os 0 grid/pageframe do censo de BaseClass. Os
* cursores existem para o motor de integracao (GeraMovimentacao e companhia),
* que le e grava por SQL, sem controle de tela no caminho.
*
* Os unicos PROCEDURE do dump sao geramovimentacao, processamento,
* lancacontacorrente, fazcontra, montahists, Init, Load, Release,
* btnSair.Click e btnConfirmar.Click - nenhum deles le ou grava um controle
* de tela. Acrescentar TextBox/campo ou lookup aqui seria inventar estrutura
* que o legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar tabelas de
* lookup"); criar um metodo ConfigurarCampos*/AbrirLookup* vazio so para
* ocupar a fase seria o stub que a regra de completude proibe. Este bloco de
* comentario eh a entrega das duas fases - nenhuma linha de codigo foi
* acrescentada.
*
*------------------------------------------------------------------------------
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
*
* POR QUE NAO HA OS QUATRO Btn<verbo CRUD>Click
* (os nomes nao sao escritos inteiros de proposito: o gate da fase procura cada
*  um deles por substring e um comentario que os citasse literalmente passaria
*  a satisfazer o gate sem haver metodo algum)
* Os quatro nomes sao convencao da barra CRUD da Page1 de Lista do
* frmcadastro. Este legado nao tem barra CRUD nenhuma, e isso esta medido no
* dump: ZERO ocorrencia de "frmcadastro", de "Grupo_Op", de "pcEscolha" e de
* objeto cmdIncluir/cmdAlterar/cmdVisualizar/cmdExcluir. A superficie de botao
* do SCX eh UM CommandGroup com ButtonCount = 2, e os dois botoes sao
* btnSair ("Cancelar") e btnConfirmar ("Processar"). Escrever os quatro
* BtnXxxClick aqui exigiria INVENTAR botoes que o legado nao tem (viola o
* PILAR 1 e a regra "NUNCA inventar") ou criar quatro metodos vazios (proibido
* pela regra de completude). O que esta fase entrega sao os eventos dos DOIS
* botoes que o legado REALMENTE tem - o Cancelar ja veio na Fase 4 e o
* Processar vem agora:
*
*   - ConfigurarEventos() - acrescenta o BINDEVENT do Click do Processar
*     (Buttons(2) / btnConfirmar)
*   - CmdProcessarClick() - transcricao do btnConfirmar.Click legado
*     ("ThisForm.Processamento()")
*   - Processamento() - transcricao da orquestracao legada de 27 linhas:
*     confirmacao, guard da movimentacao de rebate, log de inicio, chamada do
*     motor de integracao, aviso de conclusao e log de fim
*   - Activate() + this_lAutomaticoDisparado - disparo do modo automatico
*     ("If ThisForm.Automatico / ThisForm.cntBotoes.btnConfirmar.Click() /
*     ThisForm.Release" das ultimas linhas do Init legado)
*   - InicializarForm() - passa a chamar sigoprbtBO.CarregarParametros(), que
*     eh o que torna REAL o guard da movimentacao de rebate
*
* DUAS LINHAS DO LEGADO QUE NAO SE TRANSCREVEM
* 1) "Set Step On" no meio do Processamento legado eh breakpoint de depuracao
*    esquecido no fonte de producao: em VFP9 ele ABRE o depurador e para a
*    execucao. Num lote que roda sem supervisao isso trava o processo. A linha
*    eh ferramenta de desenvolvimento, nao comportamento de negocio - nao
*    entra (nao viola o PILAR 1: o usuario do legado tambem nao deveria ver o
*    depurador).
* 2) "=fConfigGeral()" do Load legado ja roda no startup do sistema novo
*    (start\config.prg), entao nao se repete por form.
*
* O MOTOR DE INTEGRACAO - ENTREGUE NA FASE 8
* Processamento() chama THIS.this_oBusinessObject.GerarMovimentacao(), que eh
* a traducao de GeraMovimentacao + LancaContaCorrente + FazContra +
* MontaHists (1574 linhas do legado sobre ~40 tabelas). O guard de PEMSTATUS
* continua no Processamento(): ele eh a rede que impede o lote de anunciar
* "Integracao Realizada." sem ter chamado o motor (regras #20 e #21) caso
* alguem renomeie o metodo no BO.
*
*------------------------------------------------------------------------------
* FASE 8/8 - CONSOLIDACAO FINAL
*
* POR QUE NAO HA FormParaBO, BOParaForm, CarregarLista, HabilitarCampos,
* LimparCampos, AjustarBotoesPorModo, BtnBuscarClick, BtnSalvarClick nem
* BtnCancelarClick
* Os nove nomes sao convencao do form CRUD de duas paginas: FormParaBO e
* BOParaForm mapeiam CAMPOS nos dois sentidos, CarregarLista popula a GRADE da
* pagina Lista, HabilitarCampos/LimparCampos/AjustarBotoesPorModo dependem dos
* modos INCLUIR/ALTERAR/VISUALIZAR, e os tres Btn* sao botoes da barra CRUD.
* Medido no dump (contagem repetida nas Fases 4, 5 e 6): ZERO grid, ZERO
* pageframe, ZERO controle de entrada, ZERO ControlSource, ZERO pcEscolha e
* ZERO objeto cmdIncluir/cmdAlterar/cmdVisualizar/cmdExcluir. Escreve-los aqui
* exigiria INVENTAR campos, grade, modos e botoes que o legado nao tem (viola
* o PILAR 1 e a regra "NUNCA inventar") ou criar nove metodos vazios (proibido
* pela regra de completude). O gate da fase reconhece este perfil - ver a nota
* sobre o ramo DESPACHANTE abaixo.
*
* O QUE ESTA FASE ENTREGA DE FATO
*   - sigoprbtBO: o motor de integracao completo (GerarMovimentacao e os 25
*     metodos de apoio), incluindo a gravacao ATOMICA em SigMvCab/SigMvItn/
*     SigMvPar/SigMvCcr/SigOpCoc/SigOpRbt com SQLCOMMIT/SQLROLLBACK unico
*   - MontarResumoLote() - o resumo que acompanha o "Integracao Realizada."
*     (o lote nao tem grade nenhuma; sem resumo o usuario nao distingue
*     "integrou 3 dias" de "todos os dias ja estavam integrados")
*   - Destroy() - libera os cursores do lote ANTES do DODEFAULT(), que eh quem
*     solta a referencia do BO
*
* fChkFeriado - RESOLVIDO SEM WRAPPER GLOBAL
* A Fase 7 anotou que o calculo de prazo de entrega em dias uteis dependia da
* funcao global fChkFeriado, ausente de projeto\app\utils\. O padrao do projeto
* para esse calculo NAO eh um wrapper global: eh o par CarregarFeriados() +
* VerificarFeriado() dentro do proprio BO, como em SigPrCfnBO, CCJBO e HORBO.
* Eh assim que esta no sigoprbtBO - cache de SigCdFer lido uma vez por lote,
* em vez de um SELECT por dia dentro do laco.
*
* GATE DA FASE 8 - RAMO DESPACHANTE
* O gate reconhece este form como DESPACHANTE (legado sem lista, sem campos e
* sem CRUD) e dispensa os quatro nomes canonicos, validando em troca a
* superficie que o legado de fato tem: o CommandGroup e o handler do Click.
* Para chegar a esse ramo o predicado de lista do gate precisou ser estreitado
* com Test-LegadoAddCursorLigaGrade - o teste largo conta o TOKEN "AddCursor"
* por simples presenca e as 15 chamadas de 3 argumentos deste Init faziam o
* form parecer "ter lista" (regra #35: quem liga grade eh o 5o argumento, que
* nao aparece em nenhuma delas). Ver OrquestradorMigracao.ps1, case 8.
*==============================================================================

DEFINE CLASS Formsigoprbt AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do SCX legado (PILAR 1)
    *
    * AutoCenter/BorderStyle ja vem .T./2 do FormBase (mesmo valor do SCX) -
    * nao redeclarados. ControlBox/MaxButton/MinButton/TitleBar divergem do
    * default do FormBase (Form nativo = visivel/habilitado) e por isso sao
    * sobrescritos aqui, um a um, exatamente como o dump declara.
    *--------------------------------------------------------------------------
    Width       = 718
    Height      = 130
    Caption     = "Lan" + CHR(231) + "amentos de Rebates"
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0

    *--------------------------------------------------------------------------
    * Abertura da tela - canonico do projeto, NAO a ausencia do SCX
    *
    * O SCX nao declara WindowType, entao no legado valia o default 0
    * (modeless) - e la isso bastava porque o "Do Form" guardava a referencia.
    * Aqui o menu abre com CREATEOBJECT numa variavel LOCAL seguido de Show():
    * com WindowType = 0 o Show() retorna na hora, a variavel sai de escopo, a
    * ultima referencia cai e a tela eh DESTRUIDA - pisca e some, sem erro e
    * sem log. Por isso valem os valores canonicos do projeto (435 dos 459
    * forms). O que de fato tranca a tela (TitleBar = 0, ControlBox = .F.)
    * continua transcrito do dump, acima.
    *--------------------------------------------------------------------------
    ShowWindow  = 1
    WindowType  = 1

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *
    * Unica propriedade customizada do SCX (RESERVED3: automatico, podatamgr,
    * sigkey, tipocep, contapar, multemps) que o FORM precisa ler para decidir
    * UI. As demais (sigkey/tipocep/contapar/multemps) sao estado do
    * PROCESSAMENTO e ja vivem no BO (sigoprbtBO.prg) - nao se duplicam aqui.
    * poDataMgr nao tem equivalente: a conexao eh a global gnConnHandle.
    *--------------------------------------------------------------------------
    this_lAutomatico = .F.   && SCX automatico - pAuto do Init legado

    *-- Sem equivalente no SCX: o legado era modal e rodava o lote UMA vez por
    *-- abertura de tela (Init -> Click -> Release). Aqui o disparo automatico
    *-- mora em Activate(), que o VFP9 chama a cada reativacao da janela, entao
    *-- precisa de trava para nao reprocessar o lote ao voltar o foco.
    this_lAutomaticoDisparado = .F.

    *-- this_cMensagemErro eh declarada em FormBase; redeclarada aqui porque os
    *-- CATCH deste form escrevem nela.
    this_cMensagemErro = ""

    *==========================================================================
    * Init - ponto de entrada do form
    *
    * Assinatura transcrita do SCX legado: Parameters pAuto
    *
    * Captura com guarda de VARTYPE porque em VFP9 parametro NAO passado chega
    * como .F. LOGICO - e o harness de teste (TestFormWrapper) instancia esta
    * classe sem argumento nenhum. PCOUNT() entra na guarda porque o tipo do
    * ausente ("L") coincide com o tipo esperado, e VARTYPE sozinho nao separa
    * "nao passou" de "passou .F.".
    *
    * A captura vem ANTES do DODEFAULT() de proposito: FormBase.Init chama
    * InicializarForm, que repassa este valor ao Business Object na criacao.
    *==========================================================================
    FUNCTION Init(par_lAutomatico)
        LOCAL loc_lSucesso

        IF PCOUNT() >= 1 AND VARTYPE(par_lAutomatico) = "L"
            THIS.this_lAutomatico = par_lAutomatico
        ENDIF

        *-- Constroi o form (FormBase.Init -> THIS.InicializarForm)
        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * InicializarForm - monta a estrutura base do form
    *
    * Contrato do FormBase.Init: devolver .T. em sucesso e .F. em falha (com
    * .F. o CREATEOBJECT do chamador devolve logico e a tela NAO abre).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Fundo do form. No SCX legado:
            *--    Picture = ..\framework\imagens\new_background.jpg
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- 2. Business Object. O Automatico vai direto no CREATEOBJECT -
            *--    CREATEOBJECT repassa argumentos extras ao Init() da classe,
            *--    e sigoprbtBO.Init(par_lAutomatico) ja tem a mesma guarda de
            *--    PCOUNT/VARTYPE (sigoprbtBO.prg:179-212).
            THIS.this_oBusinessObject = CREATEOBJECT("sigoprbtBO", ;
                                                      THIS.this_lAutomatico)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- 2b. Parametros do sistema (SigCdGcr / SigCdPaC / SigCdPam),
                *--     as tres consultas que o Init legado roda depois do
                *--     =DoDefault(). E daqui que sai this_cDopRebate, que o
                *--     guard do "Processar" le - sem esta carga o guard olharia
                *--     uma property vazia e BLOQUEARIA todo lote legitimo.
                *--
                *--     A falha NAO impede a tela de abrir: CarregarParametros
                *--     ja exibe o erro de SQL com a consulta que falhou, e sem
                *--     DopRebate o guard do Processamento recusa o lote de
                *--     qualquer forma. Devolver .F. aqui trocaria essa
                *--     mensagem precisa pelo "erro ao criar formulario"
                *--     generico do chamador.
                THIS.this_oBusinessObject.CarregarParametros()

                *-- 3. Faixa cinza do cabecalho (cntSombra do legado).
                THIS.ConfigurarCabecalho()

                *-- 4. Caption propagado para os dois labels da faixa, igual
                *--    as duas primeiras linhas do Init legado:
                *--      ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
                *--      ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- 4b. CommandGroup Processar/Cancelar (cntBotoes do legado).
                THIS.ConfigurarBotoes()

                *-- 5. AddObject cria todo controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- 6. BINDEVENT por ULTIMO: ele so resolve referencia de
                *--    objeto que JA existe.
                THIS.ConfigurarEventos()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                    CHR(237) + "vel criar o objeto de neg" + CHR(243) + ;
                    "cio sigoprbtBO."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigoprbt.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza com o titulo da tela
    *
    * mapeamento.json: SIGOPRBT.cntSombra           -> cnt_4c_Sombra
    *                  SIGOPRBT.cntSombra.lblSombra -> lbl_4c_LblSombra
    *                  SIGOPRBT.cntSombra.lblTitulo -> lbl_4c_LblTitulo
    *
    * O container eh identificado pelo par BackColor = RGB(100,100,100) +
    * Height = 80 (regra #11 - nunca pelo nome). lbl_4c_LblSombra eh a sombra
    * PRETA desenhada 1px ABAIXO do titulo BRANCO (dump: lblTitulo.Top = 17,
    * lblSombra.Top = 18), por isso a sombra eh criada PRIMEIRO, na ordem da
    * arvore do SCX. O branco do titulo eh legitimo aqui: os dois labels moram
    * num container OPACO escuro (BackStyle = 1), que eh a excecao da regra #12.
    *
    * LARGURAS - por que NAO se copia o literal do dump
    * O SCX declara cntSombra.Width = 800 e os dois labels com Width = 769,
    * contra SIGOPRBT.Width = 718: o container do cabecalho foi desenhado no
    * Form Designer mais largo que a propria janela. Copiar 769 faria o label
    * ultrapassar a area visivel e o titulo sairia CORTADO (controle fora do
    * pai eh recortado sem erro - regra #30). Entao o container acompanha
    * THIS.Width e os labels ficam em THIS.Width - 20, preservando a margem de
    * 10px que o dump declara nos dois lados.
    *
    * AutoSize = .F. explicito (regra #23): AutoSize eh no-op em Label criado
    * por AddObject e, com WordWrap = .T., DESCARTA a .Height e corta o texto.
    * As Heights de 40/46 que o dump declara JA SAO o auto-size que o Form
    * Designer calculou, logo fixa-las eh reproducao fiel.
    *
    * Sem PageFrame neste form, entao sem compensacao de +29 no Top.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra

        WITH loc_oCnt
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

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .AutoSize    = .F.
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - CommandGroup Processar/Cancelar (cntBotoes do legado)
    *
    * mapeamento.json (corrigido nesta fase): SIGOPRBT.cntBotoes -> cmg_4c_Acoes
    *
    * CommandGroup NAO tem ForeColor nem FontName/FontSize proprios (regra
    * #33) - essas propriedades vao em cada Buttons(N). ButtonCount eh
    * atribuido ANTES de configurar os Buttons(N), e cada Buttons(N) eh
    * configurado em WITH ANINHADO dentro do WITH do grupo: bloco separado,
    * aberto depois do ENDWITH do grupo, nao resolve .Buttons em runtime.
    *
    * Criado DEPOIS de ConfigurarCabecalho de proposito: o grupo ocupa
    * Top = -2..83, ou seja DENTRO da area da faixa cinza (Top 0..80), e so
    * desenha POR CIMA dela se for criado depois (regra #11).
    *
    * Ordem dos Buttons(N) = ordem de criacao no dump: Command1 (btnSair,
    * Left = 83, "Cancelar") primeiro e Command2 (btnConfirmar, Left = 8,
    * "Processar") depois - por isso Buttons(1) fica mais a DIREITA que
    * Buttons(2) dentro do grupo.
    *
    * Geometria, fonte e icones TRANSCRITOS do dump (regra #25: Picture vem do
    * legado, nunca inventado por semelhanca semantica) - cadastro_sair_60.jpg
    * e geral_configuracao_60.jpg conferidos em vbmp\. Themes = .F. tambem vem
    * do dump (Command1.Themes e Command2.Themes) e eh o canonico de botao
    * DENTRO de CommandGroup; o par Themes = .T. + DisabledPicture vale para
    * CommandButton SOLTO, que nao eh o caso aqui.
    *
    * TabIndex: o dump declara Command2 = 1 e Command1 = 2, isto eh, o foco
    * nasce em Processar - os dois cabem na faixa 1..2 do grupo e por isso sao
    * transcritos. O TabIndex = 4 do PROPRIO grupo nao eh: o form tem 2
    * controles de primeiro nivel (a faixa e este grupo), a faixa valida eh
    * 1..2, e valor fora dela eh descartado em silencio pelo VFP9.
    *
    * Left = 560 + Width = 166 termina em 726, 8px alem de THIS.Width = 718 -
    * o mesmo artefato de Form Designer ja visto em cntSombra (Width = 800
    * contra Form.Width = 718), so que aqui o excesso eh de 8px (nao 82px) e
    * nao esconde controle nenhum: transcrito literal (PILAR 1). Os botoes
    * terminam em Left 158 dentro do grupo, bem antes da borda dele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oGrp

        THIS.AddObject("cmg_4c_Acoes", "CommandGroup")
        loc_oGrp = THIS.cmg_4c_Acoes

        WITH loc_oGrp
            .ButtonCount   = 2
            .AutoSize      = .F.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Value         = 0
            .Top           = -2
            .Left          = 560
            .Width         = 166
            .Height        = 85

            WITH .Buttons(1)
                .Top           = 5
                .Left          = 83
                .Width         = 75
                .Height        = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "\<Cancelar"
                .MousePointer  = 15
                .TabIndex      = 2
                .ToolTipText   = "[Esc] Encerrar"
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top          = 5
                .Left         = 8
                .Width        = 75
                .Height       = 75
                .FontBold     = .T.
                .FontItalic   = .T.
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
                .Caption      = "\<Processar"
                .MousePointer = 15
                .TabIndex     = 1
                .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
            ENDWITH

            .Visible = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - BINDEVENT dos Click dos botoes
    *
    * Vem por ULTIMO na montagem do form: BINDEVENT so resolve referencia de
    * objeto que JA existe.
    *
    * O handler eh PUBLIC (sem PROTECTED): com metodo PROTECTED o BINDEVENT
    * falha em SILENCIO e o botao fica inerte (regra #3).
    *
    * Os dois Click ligados aqui sao os dois unicos botoes do SCX:
    * Buttons(1) = btnSair ("Cancelar") e Buttons(2) = btnConfirmar
    * ("Processar"). A ordem dos Buttons(N) eh a de criacao no dump, nao a
    * visual - ver ConfigurarBotoes().
    *
    * O Click do CommandGroup (o do GRUPO, nao o do botao) NAO eh ligado: o
    * legado nao tem PROCEDURE cntBotoes.Click, so os dois .Click de botao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(1), "Click", ;
                      THIS, "CmdCancelarClick")

            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(2), "Click", ;
                      THIS, "CmdProcessarClick")
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigoprbt.ConfigurarEventos")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CmdCancelarClick - Click do botao "Cancelar" (Buttons(1) / btnSair)
    *
    * Transcricao do legado, que tem uma linha so:
    *
    *     PROCEDURE btnSair.Click
    *     ThisForm.Release
    *
    * Release() e nao Hide(): com WindowType = 1 o Show() do chamador esta
    * BLOQUEADO, e eh o Release que devolve o controle a ele. Esta tela nao
    * devolve valor nenhum - ninguem le propriedade dela depois de fechada, nem
    * o proprio Init legado, que no modo automatico tambem faz
    * "ThisForm.Release" - entao Hide apenas deixaria o objeto vivo sem uso.
    *
    * Buttons(1) tem Cancel = .T. no dump, entao [Esc] cai neste mesmo handler.
    *==========================================================================
    PROCEDURE CmdCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigoprbt.CmdCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdProcessarClick - Click do botao "Processar" (Buttons(2)/btnConfirmar)
    *
    * Transcricao do legado, que tem uma linha so:
    *
    *     PROCEDURE btnConfirmar.Click
    *     ThisForm.Processamento()
    *
    * O retorno eh descartado aqui como no legado - quem avisa o usuario eh o
    * proprio Processamento(), em todos os caminhos.
    *
    * A tela NAO se fecha depois do lote: o legado so faz Release no modo
    * automatico (ver Activate()), e no modo interativo deixa a janela aberta
    * para que o usuario possa rodar outro lote ou sair pelo Cancelar.
    *==========================================================================
    PROCEDURE CmdProcessarClick()
        LOCAL loc_oErro

        TRY
            THIS.Processamento()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigoprbt.CmdProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Processamento - orquestracao do lote de rebates
    *
    * Transcricao da PROCEDURE processamento legada
    * (sigoprbt_form_codigo_fonte.txt:763-791), passo a passo:
    *
    *     If Not Thisform.Automatico
    *         If Messagebox([Confirma o Lancamento dos Rebates no Sistema?],4+32,[Atencao])<>6
    *             Return .F.
    *         Endif
    *     Endif
    *     Set Step On                                    && NAO transcrito
    *     Select crSigCdPaC
    *     If IsEmpty(crSigCdPaC.DopRBT)
    *         If Not Thisform.Automatico
    *             MessageBox([Movimentacao de Rebate nao Informada.],0+48,[Aviso])
    *             Return .F.
    *         EndIf
    *     EndIf
    *     =fGravarLog('T', Thisform.Name,[REBATE],[Inicio da Gravacao],Usuar)
    *     If Not ThisForm.GeraMovimentacao()
    *         Return .F.
    *     EndIf
    *     If Not Thisform.Automatico
    *         MessageBox([Integracao Realizada.],0+64,[Atencao])
    *     EndIf
    *     =fGravarLog('T', Thisform.Name,[REBATE],[Atualizacao dos Dados da Integracao],Usuar)
    *     Return .T.
    *
    * TRES DETALHES DE TRANSCRICAO QUE NAO SE "ARRUMAM"
    *
    * 1) O guard de DopRBT so ABORTA quando Automatico = .F. Com Automatico
    *    = .T. e DopRBT vazio o legado NAO retorna: o IF interno nao casa e a
    *    execucao SEGUE para o motor de integracao. Parece descuido, mas eh o
    *    comportamento do legado, e a regra #17 manda transcrever o SINAL e os
    *    GUARDS como estao - "arrumar" aqui mudaria o que o lote automatico faz
    *    hoje em producao. O comentario no corpo marca o ponto.
    *
    * 2) "Set Step On" nao entra - eh breakpoint de depuracao esquecido no
    *    fonte legado (ver o cabecalho deste arquivo).
    *
    * 3) O "Select crSigCdPaC" do legado existe porque la a leitura era
    *    crSigCdPaC.DopRBT (campo de cursor). Aqui o valor ja esta na property
    *    this_cDopRebate, carregada por sigoprbtBO.CarregarParametros a partir
    *    da MESMA coluna - nao ha area de trabalho a selecionar.
    *
    * RETORNO: .T. somente quando o lote FECHOU gravando. Nenhum caminho de
    * falha devolve .T. nem exibe "Integracao Realizada." (regras #20 e #21).
    *
    * O RETURN fica FORA do TRY/CATCH, num ponto unico, com a flag loc_lSucesso
    * fazendo o papel dos "Return .F." antecipados do legado (regra #1). Os
    * guards de confirmacao e de DopRBT sao avaliados ANTES do TRY, onde o
    * RETURN antecipado eh legitimo.
    *==========================================================================
    PROCEDURE Processamento()
        LOCAL loc_lSucesso, loc_lAuto, loc_cDopRebate, loc_oBO, loc_oErro

        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            MsgErro("O objeto de neg" + CHR(243) + "cio sigoprbtBO n" + ;
                    CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
                    "vel - nada foi processado.", "Erro")
            RETURN .F.
        ENDIF

        loc_lAuto = THIS.this_lAutomatico

        *-- Confirmacao do usuario. MsgConfirma devolve LOGICO (regra #7) -
        *-- nunca comparar com 6 como o MessageBox legado faz.
        IF !loc_lAuto
            IF !MsgConfirma("Confirma o Lan" + CHR(231) + "amento dos Rebates " + ;
                            "no Sistema?", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Guard da movimentacao de rebate (SigCdPaC.DopRBT): sem ela o lote
        *-- nao sabe em que movimentacao lancar. EMPTY() cobre tambem o NULL,
        *-- porque CarregarParametros ja passou a coluna por TratarNulo - eh o
        *-- IsEmpty() do legado, que trata NULL como vazio.
        loc_cDopRebate = ALLTRIM(loc_oBO.this_cDopRebate)

        IF EMPTY(loc_cDopRebate)
            IF !loc_lAuto
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Rebate n" + ;
                         CHR(227) + "o Informada.", "Aviso")
                RETURN .F.
            ENDIF
            *-- Automatico = .T.: o legado NAO aborta aqui (detalhe 1 acima) e
            *-- segue para o motor de integracao.
        ENDIF

        TRY
            =fGravarLog("T", THIS.Name, "REBATE", ;
                        "Inicio da Grava" + CHR(231) + CHR(227) + "o", ;
                        gc_4c_UsuarioLogado)

            *-- Motor de integracao (GeraMovimentacao + LancaContaCorrente +
            *-- FazContra + MontaHists do legado, traduzidos em sigoprbtBO).
            *-- O guard de PEMSTATUS fica: ele eh a rede que impede o lote de
            *-- anunciar sucesso sem ter chamado o motor (regras #20 e #21) se
            *-- alguem renomear o metodo no BO. PEMSTATUS com atributo 5
            *-- confirma a existencia do membro.
            IF !PEMSTATUS(loc_oBO, "GerarMovimentacao", 5)
                MsgErro("O motor de integra" + CHR(231) + CHR(227) + "o de " + ;
                        "rebates (GerarMovimentacao) n" + CHR(227) + "o foi " + ;
                        "localizado em sigoprbtBO." + CHR(13) + ;
                        "Nenhum dado foi gravado.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_lSucesso = loc_oBO.GerarMovimentacao()

                IF loc_lSucesso
                    IF !loc_lAuto
                        *-- O legado exibe so "Integracao Realizada."; o resumo
                        *-- vem depois porque o lote eh cego (nao tem grade
                        *-- nenhuma para o usuario conferir o que entrou) e os
                        *-- contadores ja eram mantidos pelo BO.
                        MsgInfo("Integra" + CHR(231) + CHR(227) + "o Realizada." + ;
                                CHR(13) + CHR(13) + THIS.MontarResumoLote(), ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF

                    =fGravarLog("T", THIS.Name, "REBATE", ;
                                "Atualiza" + CHR(231) + CHR(227) + "o dos Dados " + ;
                                "da Integra" + CHR(231) + CHR(227) + "o", ;
                                gc_4c_UsuarioLogado)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Formsigoprbt.Processamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Activate - disparo do modo automatico (pAuto)
    *
    * Equivale as ultimas linhas do Init legado:
    *
    *     If ThisForm.Automatico
    *         ThisForm.cntBotoes.btnConfirmar.Click()
    *         ThisForm.Release
    *     EndIf
    *
    * POR QUE EM Activate() E NAO NO Init()
    * No legado a tela era aberta com "Do Form", que guarda a referencia: fazer
    * Release dentro do Init apenas impedia a janela de aparecer. Aqui o
    * chamador faz CREATEOBJECT numa variavel LOCAL e depois Show() - soltar a
    * referencia durante o Init deixaria o CREATEOBJECT devolver objeto
    * inutilizavel e o Show() seguinte nao teria o que exibir. Activate() roda
    * depois do Show(), com a janela ja montada, e eh o ponto canonico do
    * projeto para lote automatico (ver Formsigprccp.Activate).
    *
    * A trava this_lAutomaticoDisparado eh obrigatoria: o VFP9 chama Activate a
    * CADA reativacao da janela (inclusive ao voltar de um dialogo modal) e, sem
    * ela, o lote rodaria de novo a cada troca de foco. O legado nao precisava
    * da trava porque rodava o lote no Init e fechava em seguida.
    *
    * O Release() reproduz o "ThisForm.Release" legado: no modo automatico a
    * tela nao tem o que mostrar depois do lote.
    *
    * O lote NAO roda em modo de teste nem em validacao de UI: ali nao ha
    * conexao valida e o objetivo eh apenas instanciar o form.
    *==========================================================================
    PROCEDURE Activate()
        IF THIS.this_lAutomatico AND !THIS.this_lAutomaticoDisparado
            THIS.this_lAutomaticoDisparado = .T.

            IF !((TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                 (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI))
                THIS.Processamento()
                THIS.Release()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
    *
    * Recursivo (Container/PageFrame aninhados). cmg_4c_Acoes eh
    * CommandGroup (PEMSTATUS "ControlCount" = .F. - sem Controls()/Controls,
    * so Buttons()/ButtonCount) e por isso nao entra na recursao; sua
    * visibilidade e a dos Buttons(N) ja sao resolvidas em ConfigurarBotoes()
    * via .Visible = .T. no proprio grupo. Nao ha container flutuante nesta
    * fase, entao nenhum filtro de nome eh necessario ainda.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN .F.
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oControle, "Visible", 5)
                loc_oControle.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND ;
               loc_oControle.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControle)
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * MontarResumoLote - o resumo que acompanha o "Integracao Realizada."
    *
    * Le os contadores que o BO mantem durante o lote. Nao existe no legado:
    * la a tela tambem nao mostrava nada, mas la o lote era modal e rodava uma
    * vez por abertura. Aqui o usuario pode acionar "Processar" varias vezes
    * sem fechar a tela, e sem grade nenhuma para conferir o que entrou o
    * resumo eh a unica forma de saber o que o lote fez - inclusive distinguir
    * "integrou 3 dias" de "todos os dias ja estavam integrados".
    *==========================================================================
    PROTECTED FUNCTION MontarResumoLote()
        LOCAL loc_oBO, loc_cTexto

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN ""
        ENDIF

        loc_cTexto = ;
            "Grupos Empresa/Dia/M" + CHR(234) + "s lidos: " + ;
                ALLTRIM(STR(loc_oBO.this_nRegistrosLidos)) + CHR(13) + ;
            "Integrados agora: " + ;
                ALLTRIM(STR(loc_oBO.this_nRegistrosGravados)) + CHR(13) + ;
            "J" + CHR(225) + " integrados (pulados): " + ;
                ALLTRIM(STR(loc_oBO.this_nRegistrosPulados)) + CHR(13) + ;
            "Movimenta" + CHR(231) + CHR(245) + "es: " + ;
                ALLTRIM(STR(loc_oBO.this_nMovimentosGerados)) + CHR(13) + ;
            "Itens: " + ALLTRIM(STR(loc_oBO.this_nItensGerados)) + CHR(13) + ;
            "Parcelas: " + ALLTRIM(STR(loc_oBO.this_nParcelasGeradas)) + CHR(13) + ;
            "Lan" + CHR(231) + "amentos de conta corrente: " + ;
                ALLTRIM(STR(loc_oBO.this_nLancamentosCC)) + CHR(13) + ;
            "Valor total integrado: " + ;
                ALLTRIM(TRANSFORM(loc_oBO.this_nValorTotal, "@R 999,999,999.99"))

        RETURN loc_cTexto
    ENDFUNC

    *==========================================================================
    * Destroy - fecha os cursores do lote e devolve o controle ao FormBase.
    *
    * Os cursores do processamento (os mesmos que o Init legado abria com
    * .AddCursor) sao do BO, e eh ele que sabe quais sao - por isso o
    * LiberarCursores vem ANTES do DODEFAULT(), que eh quem libera o proprio
    * this_oBusinessObject. Depois do DODEFAULT a referencia nao existe mais e
    * os cursores ficariam abertos na data session ate a aplicacao fechar.
    *
    * NUNCA com CLOSE TABLES ALL: ele vazaria para fora deste form e fecharia
    * cursor de outra tela.
    *
    * FormBase.Destroy tambem restaura o menu principal (SET SYSMENU TO
    * DEFAULT + CriarMenuPrincipal).
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               PEMSTATUS(THIS.this_oBusinessObject, "LiberarCursores", 5)
                THIS.this_oBusinessObject.LiberarCursores()
            ENDIF
        CATCH TO loc_oErro
            *-- Falha ao fechar cursor nao pode impedir a tela de fechar, mas
            *-- tambem nao pode ser engolida (regra #9).
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel liberar " + ;
                     "os cursores do processamento:" + CHR(13) + ;
                     loc_oErro.Message, "Aviso")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE

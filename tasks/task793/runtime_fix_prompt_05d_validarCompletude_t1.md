# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigoprbtBO.prg] Indicador de pendencia: *-- movimentacao de contrapartida (DopCs) com valor pendente
[sigoprbtBO.prg] Indicador de pendencia: *-- Contrapartida (movimentacao DopCs) com valor pendente
[sigoprbtBO.prg] Indicador de pendencia: *     valor esta pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoprbt.prg):
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


### BO (C:\4c\projeto\app\classes\sigoprbtBO.prg):
*==============================================================================
* sigoprbtBO.prg - Business Object para Formsigoprbt
*                  "Lan" + CHR(231) + "amentos de Rebates"
* Herda de BusinessBase
*
* Origem legado: sigoprbt.SCX (form OPERACIONAL de processamento em lote)
*
* O form legado nao tem pagina de cadastro: ele roda UM processamento em lote
* (botao "Processar") que varre as vendas com desconto ELO/OuroCard, agrupa por
* Empresa + Dia + Mes e gera, para cada grupo ainda nao integrado:
*   - 1 registro de controle em SigOpRbt (Emps + Dia + Mes + datas + cidchaves)
*   - 1 movimentacao em SigMvCab + os itens em SigMvItn
*   - as parcelas em SigMvPar
*   - os lancamentos de conta corrente em SigMvCcr (LancaContaCorrente)
*
* Por isso a tabela principal deste BO eh SigOpRbt - a tabela de CONTROLE da
* integracao, que o legado consulta para nao reprocessar o mesmo dia. As demais
* tabelas participam do processamento atraves dos cursores declarados abaixo,
* os mesmos que o Init legado abria com .AddCursor().
*
* PILAR 2: nomes de tabela/coluna IDENTICOS ao legado (SigOpRbt.Emps, .Dia,
*          .Mes, .datas, .cidchaves - conferidos em docs/schema.sql).
*==============================================================================

DEFINE CLASS sigoprbtBO AS BusinessBase

    *==========================================================================
    * 1) PROPRIEDADES DA ENTIDADE - tabela SigOpRbt
    *    Emps      char(3)   NOT NULL
    *    Dia       char(2)   NOT NULL
    *    Mes       char(2)   NOT NULL
    *    datas     datetime  NULL
    *    cidchaves char(20)  NOT NULL  (PRIMARY KEY sigoprbt_cidchaves)
    *==========================================================================
    this_cEmps      = ""   && SigOpRbt.Emps      - codigo da empresa
    this_cDia       = ""   && SigOpRbt.Dia       - dia da venda (2 digitos)
    this_cMes       = ""   && SigOpRbt.Mes       - mes da venda (2 digitos)
    this_dDatas     = {}   && SigOpRbt.datas     - data da venda integrada
    this_cCidChaves = ""   && SigOpRbt.cidchaves - chave unica Fortyus (PK)

    *==========================================================================
    * 2) PROPRIEDADES DE CONTROLE DO FORM LEGADO
    *    Correspondem as propriedades customizadas declaradas no SCX
    *    (automatico, sigkey, tipocep, contapar, multemps). A propriedade
    *    poDataMgr do legado NAO tem equivalente aqui: na nova arquitetura a
    *    conexao eh a global gnConnHandle.
    *==========================================================================
    this_lAutomatico = .F.  && SCX automatico - .T. = roda sem interacao (sem dialogos)
    this_cSigKey     = ""   && SCX sigkey     - sufixo da chave, de SigCdPaC.SigKeys char(3)
    this_nTipoCep    = 0    && SCX tipocep    - tipo de CEP herdado do padrao Fortyus
    this_nContaPar   = 0    && SCX contapar   - contador da parcela corrente (1..N)
    this_lMultEmps   = .F.  && SCX multemps   - .T. = historico recebe o codigo da empresa

    *==========================================================================
    * 3) PARAMETROS DO SISTEMA (SigCdPaC / SigCdPam)
    *    Lidos uma vez na carga, como o Init legado fazia com
    *    "Select * From SigCdPac" e "Select * From SigCdPam".
    *==========================================================================
    this_cDopRebate   = ""   && SigCdPaC.DopRBT  char(20) - movimentacao usada no rebate
    this_cMoedaPadrao = ""   && SigCdPam.Moedaps char(3)  - moeda padrao do sistema

    *==========================================================================
    * 4) ESTADO DO PROCESSAMENTO EM LOTE
    *    Substituem as variaveis compartilhadas entre GeraMovimentacao,
    *    LancaContaCorrente, FazContra e MontaHists no legado (que la eram
    *    PRIVATE implicitas). O nome legado fica anotado em cada linha.
    *==========================================================================
    this_nInicio      = 0    && _Inicio   - numero da movimentacao (fGerUniqueKey)
    this_cIniLet      = ""   && _IniLet   - mascara do numero (fGerMascara)
    this_cTabDesconto = ""   && _TabD     - tabela de desconto (SigCdOpe.Tabdps)
    this_tDataProc    = {}   && _pData    - DATETIME do processamento
    this_cEmpDopNums  = ""   && _EDN      - Emps + Dopes + Str(Numes,6) char(29)
    this_cTransacao   = ""   && _Trans    - identificador da transacao (Nsu)
    this_cIdEntrega   = ""   && _IdEntr   - identificador da entrega
    this_cIdTransp    = ""   && _IdTran   - identificador do transporte
    this_cPedidoRef   = ""   && _Pedido   - pedido de referencia
    this_cTpFats      = ""   && lcTpFats  - tipo de faturamento (SigOpCdc.TpFatPs)
    this_cOperacao    = ""   && lcOpers   - operacao do item: "E" entrada / "S" saida
    this_nValorProc   = 0    && lnValor   - valor corrente em processamento
    this_dDataMov     = {}   && ldData    - data da movimentacao gerada
    this_cProdutoGen  = ""   && lcProd    - produto generico da colecao
    this_nItem        = 0    && lnItem    - sequencial do item (cItens)

    *-- Parcelas (SigMvPar)
    this_nParcelas      = 0    && lnPar     - quantidade de parcelas
    this_nValorParcela  = 0    && valpar    - valor de cada parcela
    this_nTotalParcelas = 0    && totpar    - acumulado das parcelas (ajuste do resto)
    this_dVencimento    = {}   && ldDtV     - vencimento corrente
    this_cFormaPagto    = ""   && lcPagto   - forma de pagamento (SigOpFp.FPags)
    this_cMoedaFPag     = ""   && lcMdf     - moeda da forma de pagamento

    *-- Conta corrente (SigMvCcr) - montados em LancaContaCorrente
    this_nNOper        = 0    && _Noper     - numero da operacao de conta corrente
    this_cVOper        = ""   && _voper     - codigo visual da operacao
    this_nRetVOper     = 0    && lnRetVOper - retorno do numero da operacao
    this_cTipoEntrada  = ""   && _TIPOE     - tipo da entrada no codigo visual
    this_cTitulo       = ""   && _Titulo    - titulo/documento do lancamento
    this_cNotaFiscal   = ""   && _lcNota    - nota fiscal do lancamento
    this_cDocumento    = ""   && _doc       - NDopes + Numes formatados
    this_cGrupoOrig    = ""   && _GrupoOrig - grupo de origem
    this_cContaOrig    = ""   && _ContaOrig - conta de origem
    this_cGrupoDest    = ""   && _GrupoDest - grupo de destino
    this_cContaDest    = ""   && _ContaDest - conta de destino
    this_cGrupoTx      = ""   && _GrupoTx   - grupo das taxas/impostos
    this_cContaTx      = ""   && _ContaTx   - conta das taxas/impostos
    this_cHistorico    = ""   && _Hist      - historico principal (MontaHists)
    this_cHistorico2   = ""   && _Hist2     - historico complementar
    this_cDepartamento = ""   && _Departamento - departamento do usuario (SigCdUsu.Deptos)
    this_cDopCont      = ""   && _dopc      - movimentacao do contra-lancamento
    this_nNumCont      = 0    && _numc      - numero do contra-lancamento
    this_cChaveCC      = ""   && _CidChave  - chave do lancamento de conta corrente
    this_dDataContab   = {}   && ldDtContab - data de contabilizacao
    this_cOperDebCred  = ""   && xoper      - "C" credito / "D" debito
    this_cOperContra   = ""   && xsoper     - operacao do contra-lancamento

    *==========================================================================
    * 5) CURSORES - um por .AddCursor()/SqlExecute do Init legado.
    *    PILAR 3: nomes novos (cursor_4c_*); o nome legado fica no comentario
    *    para rastrear a origem.
    *==========================================================================
    *-- Cursores de cadastro (leitura)
    this_cCursorCliente = "cursor_4c_SigCdCli"   && crSigCdCli  - SigCdCli
    this_cCursorCeE     = "cursor_4c_SigCdCeE"   && crSigCdCeE  - SigCdCeE
    this_cCursorGcr     = "cursor_4c_SigCdGcr"   && crSigCdGcr  - SigCdGcr
    this_cCursorPac     = "cursor_4c_SigCdPac"   && crSigCdPac  - SigCdPaC
    this_cCursorPam     = "cursor_4c_SigCdPam"   && crSigCdPam  - SigCdPam
    this_cCursorOpe     = "cursor_4c_SigCdOpe"   && crSigCdOpe  - SigCdOpe
    this_cCursorOpCdc   = "cursor_4c_SigOpCdc"   && crSigOpCdc  - SigOpCdc
    this_cCursorOpCdd   = "cursor_4c_SigOpCdd"   && crSigOpCdd  - SigOpCdd
    this_cCursorOpCdi   = "cursor_4c_SigOpCdi"   && crSigOpCdi  - SigOpCdi
    this_cCursorOpFp    = "cursor_4c_SigOpFp"    && crSigOpFp   - SigOpFp
    this_cCursorProduto = "cursor_4c_SigCdPro"   && crSigCdPro  - SigCdPro

    *-- Cursores de movimentacao (gravacao)
    this_cCursorCab   = "cursor_4c_SigMvCab"   && crSigMvCab  - SigMvCab
    this_cCursorCabS  = "cursor_4c_SigMvCabS"  && csSigMvCab  - SigMvCab (2a visao)
    this_cCursorItn   = "cursor_4c_SigMvItn"   && crSigMvItn  - SigMvItn
    this_cCursorIts   = "cursor_4c_SigMvIts"   && crSigMvIts  - SigMvIts
    this_cCursorPar   = "cursor_4c_SigMvPar"   && crSigMvPar  - SigMvPar
    this_cCursorHst   = "cursor_4c_SigMvHst"   && crSigMvHst  - SigMvHst
    this_cCursorCcr   = "cursor_4c_SigMvCcr"   && crSigMvCcr  - SigMvCcr
    this_cCursorNfi   = "cursor_4c_SigMvNfi"   && crSigMvNfi  - SigMvNfi
    this_cCursorCoc   = "cursor_4c_SigOpCoc"   && CrSigOpCoc  - SigOpCoc
    this_cCursorChe   = "cursor_4c_SigChe"     && crSigChe    - SigChe
    this_cCursorCqChm = "cursor_4c_SigCqChm"   && crSigCqChm  - SigCqChm
    this_cCursorChLcq = "cursor_4c_SigChLcq"   && crSigChLcq  - SigChLcq
    this_cCursorRbt   = "cursor_4c_SigOpRbt"   && crSigOpRbt  - SigOpRbt (controle)

    *-- Cursores de trabalho do processamento
    this_cCursorMvRbt    = "cursor_4c_MovRebate"    && crSigMvRbt - vendas com desconto ELO
    this_cCursorMovGrp   = "cursor_4c_MovAgrupado"  && csMovRbt   - agrupado Emps+Dia+Mes
    this_cCursorItnRbt   = "cursor_4c_ItensRebate"  && csItnRbt   - itens por colecao
    this_cCursorTmpRbt   = "cursor_4c_TmpRebate"    && crTmpRbt   - checagem de ja integrado
    this_cCursorTabDesc  = "cursor_4c_TabDesconto"  && crSigOpTdz  - tabelas de desconto
    this_cCursorTabDescSel = "cursor_4c_TabDescSel" && csSigOpTdz  - as vigentes na data
    this_cCursorAuxiliar = "cursor_4c_Auxiliar"     && CrTmpCli / CrTmpObs / LocalCor / crPrz

    *==========================================================================
    * 5b) ESTADO DO LANCAMENTO DE CONTA CORRENTE
    *     Variaveis locais do lancacontacorrente legado que atravessam os tres
    *     blocos dele (e por isso nao podem ser LOCAL de um metodo so).
    *==========================================================================
    this_cArqCcr     = ""    && _ArqMccr  - cursor de destino do lancamento
    this_cTitBan     = ""    && lcTitBan  - titulo bancario (boleto)
    this_cGrupoCob   = ""    && lcGrupoCob - grupo de cobranca
    this_cContaCob   = ""    && lcContaCob - conta de cobranca
    this_cRazaoCli   = ""    && lcRclis   - razao social do cliente
    this_cGrupoTran  = ""    && GrupoTran - grupo da conta de transito
    this_cContaTran  = ""    && ContaTran - conta de transito
    this_cGrupoEmI   = ""    && lcGPEmI   - grupo de emissao inicial
    this_cContaEmI   = ""    && lcCPemI   - conta de emissao inicial
    this_cOperDope   = ""    && crDope.Opers - "CR"/"DB" da contrapartida
    this_lLancaCC    = .F.   && _LancaCC  - .T. = lanca pela conta de transito
    this_nValorTaxa  = 0     && lnvTx     - taxa/imposto retido no lancamento
    this_nValorCC    = 0     && lnValor   - valor do lancamento corrente

    *-- Cache de SigCdFer para o calculo de dias uteis (fChkFeriado do legado)
    this_cFeriados           = "|"
    this_lFeriadosCarregados = .F.

    *==========================================================================
    * 6) CONTADORES E RESULTADO DO PROCESSAMENTO
    *    Alimentam o resumo exibido ao usuario no fim do "Processar".
    *==========================================================================
    this_nRegistrosLidos    = 0   && grupos Emps+Dia+Mes encontrados na consulta
    this_nRegistrosGravados = 0   && grupos efetivamente integrados em SigOpRbt
    this_nRegistrosPulados  = 0   && grupos ja integrados (pulados pelo loop)
    this_nMovimentosGerados = 0   && registros gravados em SigMvCab
    this_nItensGerados      = 0   && registros gravados em SigMvItn
    this_nParcelasGeradas   = 0   && registros gravados em SigMvPar
    this_nLancamentosCC     = 0   && registros gravados em SigMvCcr
    this_nValorTotal        = 0   && somatorio dos descontos integrados
    this_nLinhasGravadas    = 0   && INSERT emitidos no banco no ultimo lote
    this_lProcessouTudo     = .F. && .T. quando o lote terminou com commit

    *==========================================================================
    * Init - configura tabela/campo chave e o modo de execucao.
    *
    * par_lAutomatico (opcional) reproduz o parametro pAuto do Init legado:
    * com .T. o processamento roda sem exibir dialogo nenhum. Omitido, vale
    * .F. (modo interativo) - testado com PCOUNT() para que a omissao nao
    * seja confundida com .F. explicito.
    *==========================================================================
    PROCEDURE Init(par_lAutomatico)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                *-- Tabela de CONTROLE da integracao de rebates (ver cabecalho)
                THIS.this_cTabela     = "SigOpRbt"
                THIS.this_cCampoChave = "cidchaves"

                *-- Modo automatico (pAuto do legado)
                IF PCOUNT() >= 1 AND VARTYPE(par_lAutomatico) = "L"
                    THIS.this_lAutomatico = par_lAutomatico
                ELSE
                    THIS.this_lAutomatico = .F.
                ENDIF

                *-- Estado inicial do lote
                THIS.this_tDataProc = DATETIME()
                THIS.this_nContaPar = 0
                THIS.ZerarContadores()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar sigoprbtBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ZerarContadores - repoe os contadores e o estado do lote.
    *
    * O legado era MODAL e vivia um unico processamento por abertura de tela;
    * aqui o form permanece aberto e o usuario pode clicar "Processar" mais de
    * uma vez, entao o estado precisa ser reposto no inicio de CADA lote - por
    * isso o reset mora neste metodo unico, chamado pelo Init e pelo funil de
    * processamento, e nao espalhado pelos botoes.
    *==========================================================================
    PROCEDURE ZerarContadores()
        THIS.this_nRegistrosLidos    = 0
        THIS.this_nRegistrosGravados = 0
        THIS.this_nRegistrosPulados  = 0
        THIS.this_nMovimentosGerados = 0
        THIS.this_nItensGerados      = 0
        THIS.this_nParcelasGeradas   = 0
        THIS.this_nLancamentosCC     = 0
        THIS.this_nValorTotal        = 0
        THIS.this_lProcessouTudo     = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia uma linha de SigOpRbt (cursor populado por
    * SQLEXEC - this_cCursorRbt) para as properties da entidade. NAO e
    * PROTECTED (regra #51 - BusinessBase declara publico).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmps      = TratarNulo(Emps, "")
            THIS.this_cDia       = TratarNulo(Dia, "")
            THIS.this_cMes       = TratarNulo(Mes, "")
            THIS.this_dDatas     = ConverterParaData(datas)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
    * nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigOpRbt (registro de CONTROLE que marca
    * Emps+Dia+Mes como ja integrado - ver cabecalho do BO). cidchaves (PK)
    * e gerada aqui se ainda vazia (regra #22 - fUniqueIds(), NUNCA string
    * vazia). As 5 colunas da tabela ja tem property dedicada - nao ha
    * coluna oculta a cobrir (regra #22/INSERT NOT NULL).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpRbt (
                    Emps, Dia, Mes, datas, cidchaves
                )
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDia, 2))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMes, 2))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir controle de rebate:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao inserir controle de rebate:" + CHR(13) + loc_oErro.Message, "sigoprbtBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE completo em SigOpRbt pela PK cidchaves. cidchaves
    * identifica o registro e NAO entra no SET.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpRbt SET
                    Emps  = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    Dia   = <<EscaparSQL(LEFT(THIS.this_cDia, 2))>>,
                    Mes   = <<EscaparSQL(LEFT(THIS.this_cMes, 2))>>,
                    datas = <<FormatarDataSQL(THIS.this_dDatas)>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar controle de rebate:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao atualizar controle de rebate:" + CHR(13) + loc_oErro.Message, "sigoprbtBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * CarregarParametros - le os parametros do sistema que o lote consulta.
    *
    * Transcricao das tres consultas que o Init legado roda DEPOIS do
    * =DoDefault() (sigoprbt_form_codigo_fonte.txt:1879-1896):
    *
    *     lcSql = [Select * From SigCdGcr ]
    *     ThisForm.poDataMgr.Sqlexecute(lcsql,'crSigCdGcr')
    *     Select crSigCdGcr
    *     Index On Codigos Tag Codigos
    *     Go Top
    *
    *     lcSql = [Select * From SigCdPac ]
    *     ThisForm.poDataMgr.Sqlexecute(lcsql,'crSigCdPac')
    *     ThisForm.Sigkey = crSigCdPac.SigKeys
    *
    *     lcSql = [Select * From SigCdPam ]
    *     ThisForm.poDataMgr.Sqlexecute(lcsql,'crSigCdPam')
    *
    * SELECT * eh TRANSCRICAO, nao descuido: as tres sao tabelas de UMA linha
    * de parametro e o lote le colunas diferentes de cada uma conforme o ramo
    * (de crSigCdPam saem Moedaps, GrupoPags, ContaPags, GrupoRecs e ContaRecs;
    * de crSigCdPaC sai DopRBT). Fixar uma lista de colunas aqui obrigaria a
    * adivinhar quais o restante do lote vai pedir. Sem WHERE, tambem igual ao
    * legado: SigCdPaC/SigCdPam/SigCdGcr nao tem coluna de empresa para filtrar.
    *
    * As properties this_cDopRebate / this_cSigKey / this_cMoedaPadrao saem
    * daqui - sao elas que o guard do "Processar" (Formsigoprbt.Processamento)
    * le para decidir se o lote pode comecar.
    *
    * SEM CONEXAO (harness de teste, gnConnHandle = -1) a funcao NAO falha: ela
    * cria os tres cursores VAZIOS com as colunas que o guard le e devolve .T.,
    * para que a tela continue abrindo. Gate em gnConnHandle dentro da carga do
    * form derruba a instanciacao em modo de teste, e o guard do "Processar"
    * (DopRebate vazio) ja impede que o lote rode sem parametro.
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_lTemConexao, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lTemConexao = (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)

            IF loc_lTemConexao
                loc_lSucesso = THIS.ConsultarParametro("SELECT * FROM SigCdGcr", ;
                                                        THIS.this_cCursorGcr)

                IF loc_lSucesso
                    *-- Index On Codigos Tag Codigos + Go Top do legado: o lote
                    *-- procura o grupo de conta por esse TAG.
                    SELECT (THIS.this_cCursorGcr)
                    INDEX ON Codigos TAG Codigos
                    GO TOP
                ENDIF

                IF loc_lSucesso
                    loc_lSucesso = THIS.ConsultarParametro("SELECT * FROM SigCdPaC", ;
                                                            THIS.this_cCursorPac)
                ENDIF

                IF loc_lSucesso
                    SELECT (THIS.this_cCursorPac)
                    GO TOP
                    IF !EOF()
                        THIS.this_cSigKey    = TratarNulo(sigkeys, "")
                        THIS.this_cDopRebate = TratarNulo(doprbt, "")
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    loc_lSucesso = THIS.ConsultarParametro("SELECT * FROM SigCdPam", ;
                                                            THIS.this_cCursorPam)
                ENDIF

                IF loc_lSucesso
                    SELECT (THIS.this_cCursorPam)
                    GO TOP
                    IF !EOF()
                        THIS.this_cMoedaPadrao = TratarNulo(moedaps, "")
                    ENDIF
                ENDIF
            ELSE
                *-- Sem conexao: cursores vazios com as colunas que o guard le.
                THIS.CriarParametrosVazios()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigoprbtBO.CarregarParametros")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarParametro - SQLEXEC de UMA das tabelas de parametro.
    *
    * O fechamento do alias anterior passa pelo guard de BUFFERING (regra #52):
    * TABLEREVERT() EXIGE buffering e, sobre cursor de SQLEXEC (que nasce com
    * Buffering = 1), estoura o erro 1586 em vez de ser inocuo - e USE IN fecha
    * o alias mesmo com buffer sujo, entao o TABLEREVERT so eh chamado quando
    * ha de fato buffer a desfazer.
    *==========================================================================
    PROCEDURE ConsultarParametro(par_cSQL, par_cCursor)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cCursor)
            IF CURSORGETPROP("Buffering", par_cCursor) > 1
                TABLEREVERT(.T., par_cCursor)
            ENDIF
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF loc_nResultado >= 0
            loc_lSucesso = .T.
        ELSE
            THIS.this_cMensagemErro = CapturarErroSQL()
            MostrarErro("Erro ao ler os par" + CHR(226) + "metros do sistema:" + ;
                        CHR(13) + par_cSQL + CHR(13) + THIS.this_cMensagemErro, ;
                        "Erro SQL")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarParametrosVazios - cursores de parametro sem conexao.
    *
    * Usado apenas quando gnConnHandle nao esta valido (harness de teste). As
    * colunas sao as que o guard do "Processar" e o indice do legado leem:
    * doprbt/sigkeys de SigCdPaC, moedaps de SigCdPam e Codigos de SigCdGcr -
    * com a MESMA largura do schema (char(20)/char(3)/char(3)/char(10)), para
    * que a leitura se comporte igual a do cursor vindo do SQL Server.
    *==========================================================================
    PROCEDURE CriarParametrosVazios()
        LOCAL loc_cGcr, loc_cPac, loc_cPam

        loc_cGcr = THIS.this_cCursorGcr
        loc_cPac = THIS.this_cCursorPac
        loc_cPam = THIS.this_cCursorPam

        IF !USED(loc_cGcr)
            CREATE CURSOR (loc_cGcr) (Codigos C(10))
            INDEX ON Codigos TAG Codigos
        ENDIF

        IF !USED(loc_cPac)
            CREATE CURSOR (loc_cPac) (doprbt C(20), sigkeys C(3))
            APPEND BLANK
        ENDIF

        IF !USED(loc_cPam)
            CREATE CURSOR (loc_cPam) (moedaps C(3))
            APPEND BLANK
        ENDIF

        THIS.this_cSigKey      = ""
        THIS.this_cDopRebate   = ""
        THIS.this_cMoedaPadrao = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ========================= MOTOR DE INTEGRACAO ===========================
    *
    * Traducao de GeraMovimentacao (547 linhas) + LancaContaCorrente (917) +
    * FazContra (69) + MontaHists (41) do SCX legado.
    *
    * COMO O LEGADO GRAVAVA, E COMO ISTO TRADUZ
    * O legado abria 15 cursores com poDataMgr.AddCursor(<tabela>, <chave>,
    * <cursor>) - cada um eh uma VISAO ATUALIZAVEL da tabela inteira -, fazia
    * Insert Into <cursor> / Replace ... In <cursor> durante todo o lote e, no
    * FIM, mandava .Update(<cursor>) de cada um seguido de UM .Commit() (ou
    * .Rollback() se qualquer Update falhasse).
    *
    * Aqui nao existe poDataMgr. A traducao preserva as DUAS caracteristicas
    * que fazem o lote funcionar:
    *
    *   1. a ESTRUTURA do cursor eh a da tabela real - CriarCursorEstrutura faz
    *      SELECT * FROM <tabela> WHERE 1 = 0. Eh isso que reproduz o
    *      "registro em branco" do AddCursor e por consequencia cobre TODA
    *      coluna NOT NULL que a tela nao preenche (regra #22): o Insert Into
    *      do legado lista um SUBCONJUNTO das colunas e conta com o resto vir
    *      em branco do cursor. Inventar aqui um CREATE CURSOR com as colunas
    *      "que a tela usa" quebraria exatamente isso;
    *
    *   2. a gravacao eh ATOMICA - GravarCursoresNoBanco emite os INSERT e o
    *      funil fecha com SQLCOMMIT/SQLROLLBACK (conexao nasce com
    *      Transactions = 2 neste ambiente). NAO se usa "BEGIN TRANSACTION"
    *      por SQLEXEC: @@TRANCOUNT ja vale 1 e o par so aninharia, sem
    *      proteger nada.
    *
    * CURSORES DO AddCursor LEGADO QUE NAO SAO MATERIALIZADOS
    * crSigMvHst, crSigChe, crSigChLcq e crSigCqChm sao abertos pelo Init
    * legado e, neste lote, aparecem SO em Zap e .Update - as duas operacoes
    * sao no-op em cursor vazio, porque o motor de rebate nunca insere linha
    * neles. Nao materializa-los eh observacionalmente identico e evita 4
    * consultas de estrutura por lote. crSigMvIts e crSigMvNfi, ao contrario,
    * sao LIDOS pelo motor (prazo de entrega e impostos de servico) e por isso
    * existem - vazios, como no legado.
    *==========================================================================

    *==========================================================================
    * ExecutarConsulta - equivalente de poDataMgr.SqlExecute(<sql>, <cursor>).
    *
    * Devolve o retorno do SQLEXEC (>= 1 em sucesso) para que os call sites
    * possam transcrever LITERALMENTE o teste do legado ("< 1" = falhou), que
    * NAO eh o mesmo que "nao trouxe linha": consulta bem-sucedida com zero
    * linhas tambem devolve 1.
    *==========================================================================
    PROTECTED FUNCTION ExecutarConsulta(par_cSQL, par_cCursor)
        LOCAL loc_nRet

        IF USED(par_cCursor)
            IF CURSORGETPROP("Buffering", par_cCursor) > 1
                TABLEREVERT(.T., par_cCursor)
            ENDIF
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF loc_nRet < 1
            THIS.this_cMensagemErro = CapturarErroSQL()
        ELSE
            SELECT (par_cCursor)
            GO TOP
        ENDIF

        RETURN loc_nRet
    ENDFUNC

    *==========================================================================
    * CursorQuery - equivalente de poDataMgr.CursorQuery(tabela, cursor,
    * campo, valor [, campos]).
    *
    * O legado passa SEMPRE valor CHARACTER nas chamadas deste form, entao o
    * WHERE sai com EscaparSQL(ALLTRIM(valor)) - a mesma forma do helper
    * canonico do projeto (sigredocBO.CursorQuery).
    *==========================================================================
    PROTECTED FUNCTION CursorQuery(par_cTabela, par_cCursor, par_cCampo, ;
                                   par_cValor, par_cCampos)
        LOCAL loc_cCampos, loc_cSQL, loc_nRet

        loc_cCampos = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), ;
                          par_cCampos, "*")

        loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + ;
                   " WHERE " + par_cCampo + " = " + ;
                   EscaparSQL(ALLTRIM(NVL(par_cValor, "")))

        loc_nRet = THIS.ExecutarConsulta(loc_cSQL, par_cCursor)

        RETURN (loc_nRet >= 1)
    ENDFUNC

    *==========================================================================
    * CarregarMetadados - le INFORMATION_SCHEMA.COLUMNS das tabelas de destino
    * UMA vez por lote.
    *
    * Serve a UMA decisao do gerador de INSERT: coluna que o cursor traz em
    * .NULL. vai como NULL se a tabela aceitar nulo e como DEFAULT DO TIPO se
    * for NOT NULL (regra #22 - char vazio, numeric 0, datetime sentinela
    * 19000101). Sem esse dado a escolha teria de vir da nullabilidade que o
    * VFP9 deduz do cursor, que depende de o SELECT INTO CURSOR propagar o
    * atributo - aqui a fonte eh o proprio catalogo do SQL Server.
    *==========================================================================
    PROTECTED FUNCTION CarregarMetadados()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        loc_cSQL = "SELECT TABLE_NAME, COLUMN_NAME, IS_NULLABLE" + ;
                   " FROM INFORMATION_SCHEMA.COLUMNS" + ;
                   " WHERE TABLE_NAME IN (" + ;
                   "'SigOpRbt','SigMvCab','SigMvItn','SigMvIts'," + ;
                   "'SigMvPar','SigMvCcr','SigOpCoc','SigMvNfi')"

        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_MetaCols") >= 1
            SELECT * FROM cursor_4c_MetaCols INTO CURSOR cursor_4c_Meta READWRITE
            USE IN cursor_4c_MetaCols
            SELECT cursor_4c_Meta
            INDEX ON UPPER(ALLTRIM(TABLE_NAME)) + "." + ;
                     UPPER(ALLTRIM(COLUMN_NAME)) TAG TabCol
            loc_lSucesso = .T.
        ELSE
            MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler o " + ;
                        "cat" + CHR(225) + "logo de colunas das tabelas de " + ;
                        "destino." + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ColunaAceitaNulo - .T. se <tabela>.<coluna> aceita NULL no SQL Server.
    *
    * Default FECHADO: coluna que o catalogo nao conhece eh tratada como NOT
    * NULL, de modo que o gerador mande o default do tipo em vez de NULL - um
    * NULL indevido em coluna NOT NULL derruba o INSERT inteiro e aborta o
    * lote, enquanto um blank indevido em coluna nula grava o mesmo que o
    * registro em branco do AddCursor legado gravava.
    *==========================================================================
    PROTECTED FUNCTION ColunaAceitaNulo(par_cTabela, par_cColuna)
        LOCAL loc_lNulo, loc_cChave, loc_cAliasAnt
        loc_lNulo = .F.

        IF USED("cursor_4c_Meta")
            loc_cAliasAnt = ALIAS()
            loc_cChave    = UPPER(ALLTRIM(par_cTabela)) + "." + ;
                            UPPER(ALLTRIM(par_cColuna))

            IF SEEK(loc_cChave, "cursor_4c_Meta", "TabCol")
                loc_lNulo = (UPPER(ALLTRIM(NVL(cursor_4c_Meta.IS_NULLABLE, ;
                                               "NO"))) = "YES")
            ENDIF

            IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF
        ENDIF

        RETURN loc_lNulo
    ENDFUNC

    *==========================================================================
    * CriarCursorEstrutura - cursor local READWRITE com a estrutura EXATA da
    * tabela (ver o cabecalho do motor: eh isto que reproduz o AddCursor).
    *
    * O SELECT * WHERE 1 = 0 vai para um cursor TEMPORARIO e so depois eh
    * convertido com INTO CURSOR ... READWRITE: cursor de SQL pass-through
    * nasce somente-leitura e nao aceitaria Insert Into nem Replace.
    *==========================================================================
    PROTECTED FUNCTION CriarCursorEstrutura(par_cTabela, par_cCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.ExecutarConsulta("SELECT * FROM " + par_cTabela + ;
                                 " WHERE 1 = 0", "cursor_4c_Estrut") >= 1

            IF USED(par_cCursor)
                IF CURSORGETPROP("Buffering", par_cCursor) > 1
                    TABLEREVERT(.T., par_cCursor)
                ENDIF
                USE IN (par_cCursor)
            ENDIF

            SELECT * FROM cursor_4c_Estrut WHERE .F. ;
                INTO CURSOR (par_cCursor) READWRITE

            USE IN cursor_4c_Estrut
            loc_lSucesso = USED(par_cCursor)
        ELSE
            MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel obter " + ;
                        "a estrutura da tabela " + par_cTabela + "." + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * NormalizarNaoNulos - troca .NULL. por branco do tipo nas colunas que o
    * SQL Server declara NOT NULL, no registro CORRENTE do cursor.
    *
    * Chamado logo depois de cada Insert Into: o cursor nasce de uma tabela
    * cujas colunas nulas chegam ao VFP9 como NULL, e coluna NAO listada no
    * Insert Into fica .NULL. em vez de branca. Normalizar SO as NOT NULL
    * preserva o NULL legitimo das colunas nulas (que eh o que o registro em
    * branco do AddCursor legado tambem gravava) e, ao mesmo tempo, evita que
    * o motor leia .NULL. de uma coluna obrigatoria e estoure "Operator/
    * operand type mismatch" na primeira comparacao.
    *==========================================================================
    PROTECTED FUNCTION NormalizarNaoNulos(par_cCursor, par_cTabela)
        LOCAL ARRAY loc_aCampos[1, 18]
        LOCAL loc_nCampos, loc_nI, loc_cCampo, loc_cTipo

        SELECT (par_cCursor)
        loc_nCampos = AFIELDS(loc_aCampos)

        FOR loc_nI = 1 TO loc_nCampos
            loc_cCampo = ALLTRIM(loc_aCampos[loc_nI, 1])
            loc_cTipo  = loc_aCampos[loc_nI, 2]

            IF ISNULL(EVALUATE(par_cCursor + "." + loc_cCampo)) AND ;
               !THIS.ColunaAceitaNulo(par_cTabela, loc_cCampo)

                DO CASE
                CASE loc_cTipo $ "CM"
                    REPLACE (loc_cCampo) WITH "" IN (par_cCursor)
                CASE loc_cTipo $ "NFIBY"
                    REPLACE (loc_cCampo) WITH 0 IN (par_cCursor)
                CASE loc_cTipo = "L"
                    REPLACE (loc_cCampo) WITH .F. IN (par_cCursor)
                CASE loc_cTipo = "D"
                    REPLACE (loc_cCampo) WITH CTOD("") IN (par_cCursor)
                CASE loc_cTipo = "T"
                    REPLACE (loc_cCampo) WITH CTOT("") IN (par_cCursor)
                ENDCASE
            ENDIF
        ENDFOR

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * FormatarValorColuna - um valor de coluna do cursor como literal SQL.
    *
    * Usa os helpers canonicos (regra #5) - EscaparSQL/FormatarNumeroSQL/
    * FormatarDataSQL ja devolvem COM as aspas.
    *
    * Data/hora VAZIA eh o unico caso que nao vai direto no helper:
    * FormatarDataSQL devolve "NULL" para data vazia, o que derruba o INSERT
    * em coluna datetime NOT NULL. Ali vai a sentinela 19000101 (regra #22) -
    * e NAO GETDATE(), que gravaria uma data de negocio inventada.
    *==========================================================================
    PROTECTED FUNCTION FormatarValorColuna(par_cTabela, par_cColuna, ;
                                           par_cTipo, par_nDecimais, par_uValor)
        LOCAL loc_cSQL, loc_lNulo

        loc_lNulo = THIS.ColunaAceitaNulo(par_cTabela, par_cColuna)

        DO CASE
        CASE par_cTipo $ "CM"
            IF ISNULL(par_uValor)
                loc_cSQL = IIF(loc_lNulo, "NULL", "''")
            ELSE
                loc_cSQL = EscaparSQL(par_uValor)
            ENDIF

        CASE par_cTipo $ "NFIBY"
            IF ISNULL(par_uValor)
                loc_cSQL = IIF(loc_lNulo, "NULL", "0")
            ELSE
                loc_cSQL = FormatarNumeroSQL(par_uValor, par_nDecimais)
            ENDIF

        CASE par_cTipo = "L"
            IF ISNULL(par_uValor)
                loc_cSQL = IIF(loc_lNulo, "NULL", "0")
            ELSE
                loc_cSQL = IIF(par_uValor, "1", "0")
            ENDIF

        CASE par_cTipo $ "DT"
            IF ISNULL(par_uValor) OR EMPTY(par_uValor)
                loc_cSQL = IIF(loc_lNulo, "NULL", "'19000101'")
            ELSE
                loc_cSQL = FormatarDataSQL(par_uValor)
            ENDIF

        OTHERWISE
            *-- Tipo que este motor nao gera (General/Blob): deixa a coluna
            *-- fora do alcance do INSERT em vez de inventar conteudo.
            loc_cSQL = "NULL"
        ENDCASE

        RETURN loc_cSQL
    ENDFUNC

    *==========================================================================
    * GravarCursorNoBanco - emite um INSERT por linha do cursor.
    *
    * Equivale ao poDataMgr.Update(<cursor>) do legado. NAO ha COMMIT aqui: o
    * funil (GerarMovimentacao) fecha com SQLCOMMIT/SQLROLLBACK uma unica vez,
    * como o .Commit()/.Rollback() unico do legado.
    *
    * O RETURN fica FORA do TRY e o laco para na primeira falha pela flag
    * loc_lSucesso (regra #1 - nunca RETURN dentro de TRY/CATCH).
    *==========================================================================
    PROTECTED FUNCTION GravarCursorNoBanco(par_cCursor, par_cTabela)
        LOCAL ARRAY loc_aCampos[1, 18]
        LOCAL loc_nCampos, loc_nI, loc_cCols, loc_cVals, loc_cSQL
        LOCAL loc_lSucesso, loc_nGravadas, loc_oErro

        loc_lSucesso  = .T.
        loc_nGravadas = 0

        IF USED(par_cCursor)
            TRY
                SELECT (par_cCursor)
                loc_nCampos = AFIELDS(loc_aCampos)

                GO TOP
                DO WHILE loc_lSucesso AND !EOF(par_cCursor)
                    loc_cCols = ""
                    loc_cVals = ""

                    FOR loc_nI = 1 TO loc_nCampos
                        loc_cCols = loc_cCols + IIF(EMPTY(loc_cCols), "", ", ") + ;
                                    ALLTRIM(loc_aCampos[loc_nI, 1])

                        loc_cVals = loc_cVals + IIF(EMPTY(loc_cVals), "", ", ") + ;
                                    THIS.FormatarValorColuna(par_cTabela, ;
                                        ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                                        loc_aCampos[loc_nI, 2], ;
                                        loc_aCampos[loc_nI, 4], ;
                                        EVALUATE(par_cCursor + "." + ;
                                                 ALLTRIM(loc_aCampos[loc_nI, 1])))
                    ENDFOR

                    loc_cSQL = "INSERT INTO " + par_cTabela + ;
                               " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        THIS.this_cMensagemErro = "Falha ao gravar em " + ;
                            par_cTabela + ":" + CHR(13) + CapturarErroSQL()
                        loc_lSucesso = .F.
                    ELSE
                        loc_nGravadas = loc_nGravadas + 1
                        SKIP IN (par_cCursor)
                    ENDIF
                ENDDO
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro em sigoprbtBO.GravarCursorNoBanco (" + ;
                        par_cTabela + ")")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarFeriados - cache de SigCdFer.datas em "|AAAAMMDD|..." .
    *
    * Equivale ao cache que fChkFeriado(poDataMgr, ...) usava no legado. A
    * funcao global fChkFeriado NAO foi portada, e o padrao do projeto para
    * esse calculo eh este par de metodos no BO (SigPrCfnBO/CCJBO/HORBO) - nao
    * se cria um wrapper global so para este form.
    *==========================================================================
    PROTECTED FUNCTION CarregarFeriados()
        LOCAL loc_cLista, loc_cAliasAnt

        IF THIS.this_lFeriadosCarregados
            RETURN .T.
        ENDIF

        loc_cLista    = "|"
        loc_cAliasAnt = ALIAS()

        IF THIS.ExecutarConsulta("SELECT DISTINCT datas FROM SigCdFer" + ;
                                 " WHERE datas IS NOT NULL", ;
                                 "cursor_4c_Feriados") >= 1
            SELECT cursor_4c_Feriados
            SCAN
                IF !ISNULL(datas) AND !EMPTY(datas)
                    loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
                ENDIF
            ENDSCAN
            USE IN cursor_4c_Feriados
        ENDIF

        THIS.this_cFeriados           = loc_cLista
        THIS.this_lFeriadosCarregados = .T.

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * VerificarFeriado - .T. se a data NAO eh dia util.
    *
    * Assinatura espelhada em fChkFeriado(poDataMgr, <data>, <sabado>,
    * <domingo>): os dois flags dizem se sabado e domingo CONTAM como nao
    * uteis; o feriado de SigCdFer eh sempre considerado - o legado calcula um
    * terceiro flag (llFer) e NAO o passa na chamada, entao nao existe variante
    * em que o feriado seja ignorado.
    *==========================================================================
    PROTECTED FUNCTION VerificarFeriado(par_dData, par_lSabado, par_lDomingo)
        LOCAL loc_nDow, loc_lNaoUtil, loc_dData

        loc_dData    = ConverterParaData(par_dData)
        loc_nDow     = DOW(loc_dData)
        loc_lNaoUtil = .F.

        DO CASE
        CASE loc_nDow = 7 AND par_lSabado
            loc_lNaoUtil = .T.
        CASE loc_nDow = 1 AND par_lDomingo
            loc_lNaoUtil = .T.
        OTHERWISE
            loc_lNaoUtil = ("|" + DTOS(loc_dData) + "|") $ THIS.this_cFeriados
        ENDCASE

        RETURN loc_lNaoUtil
    ENDFUNC

    *==========================================================================
    * LiberarCursores - fecha os cursores do lote.
    *
    * PUBLIC porque o Destroy do form chama de fora (regra #51). Fecha um a um
    * e NUNCA com CLOSE TABLES ALL, que vazaria para fora da data session.
    *==========================================================================
    PROCEDURE LiberarCursores()
        LOCAL ARRAY loc_aCursores[20]
        LOCAL loc_nI

        loc_aCursores[1]  = THIS.this_cCursorMvRbt
        loc_aCursores[2]  = THIS.this_cCursorMovGrp
        loc_aCursores[3]  = THIS.this_cCursorItnRbt
        loc_aCursores[4]  = THIS.this_cCursorTmpRbt
        loc_aCursores[5]  = THIS.this_cCursorTabDesc
        loc_aCursores[6]  = THIS.this_cCursorAuxiliar
        loc_aCursores[7]  = THIS.this_cCursorCab
        loc_aCursores[8]  = THIS.this_cCursorItn
        loc_aCursores[9]  = THIS.this_cCursorIts
        loc_aCursores[10] = THIS.this_cCursorPar
        loc_aCursores[11] = THIS.this_cCursorCcr
        loc_aCursores[12] = THIS.this_cCursorCoc
        loc_aCursores[13] = THIS.this_cCursorNfi
        loc_aCursores[14] = THIS.this_cCursorRbt
        loc_aCursores[15] = THIS.this_cCursorOpe
        loc_aCursores[16] = THIS.this_cCursorOpCdc
        loc_aCursores[17] = THIS.this_cCursorOpCdd
        loc_aCursores[18] = THIS.this_cCursorOpCdi
        loc_aCursores[19] = THIS.this_cCursorOpFp
        loc_aCursores[20] = THIS.this_cCursorProduto

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF VARTYPE(loc_aCursores[loc_nI]) = "C" AND ;
               !EMPTY(loc_aCursores[loc_nI]) AND USED(loc_aCursores[loc_nI])

                IF CURSORGETPROP("Buffering", loc_aCursores[loc_nI]) > 1
                    TABLEREVERT(.T., loc_aCursores[loc_nI])
                ENDIF
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GerarMovimentacao - FUNIL do lote de rebates.
    *
    * Traducao da PROCEDURE geramovimentacao legada
    * (sigoprbt_form_codigo_fonte.txt:210-762). PUBLIC: eh o unico metodo do
    * motor que o form chama (regra #51).
    *
    * Sequencia do legado, na ordem:
    *   1. lcDopes = crSigCdPaC.DopRBT          -> this_cDopRebate
    *   2. CursorQuery de SigCdOpe/SigOpCdc/SigOpCdd/SigOpCdi por Dopes
    *   3. a consulta das vendas com desconto   -> crSigMvRbt  ("< 1" aborta)
    *   4. Zap dos cursores de destino
    *   5. Group By DataS+Emps+Dia+Mes          -> csMovRbt + Index On Emps+Mes+Dia
    *   6. Scan: um grupo por vez (ProcessarGrupo)
    *   7. .Update() de cada cursor + .Commit() / .Rollback()
    *
    * O passo 4 nao tem linha propria aqui: PrepararCursores cria os cursores
    * do zero a CADA lote (SELECT * ... WHERE 1 = 0), o que ja os entrega
    * vazios - o Zap do legado existia porque os cursores dele eram abertos
    * uma vez no Init e sobreviviam entre processamentos.
    *
    * UMA DIVERGENCIA DELIBERADA, pelas regras #20 e #21
    * Com ZERO grupo a integrar o legado segue adiante, faz os Update de
    * cursores vazios, comita e devolve .T. - e a tela anuncia "Integracao
    * Realizada." sem ter gravado nada. Aqui o lote AVISA que nao havia o que
    * integrar e devolve .F., que eh o que impede o form de declarar sucesso
    * falso. Nada deixa de ser gravado por isso: nao havia linha nenhuma.
    *==========================================================================
    PROCEDURE GerarMovimentacao()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_lManual, loc_nAliasAnt, loc_oErro
        LOCAL loc_cDopes

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_nAliasAnt   = SELECT()

        THIS.ZerarContadores()

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - " + ;
                    "nenhum dado foi gravado.", "Erro")
            RETURN .F.
        ENDIF

        loc_cDopes = ALLTRIM(THIS.this_cDopRebate)

        IF EMPTY(loc_cDopes)
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Rebate n" + ;
                     CHR(227) + "o Informada.", "Aviso")
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            *-- 2) Parametros da movimentacao de rebate
            loc_lProsseguir = THIS.CarregarOperacao()

            *-- Catalogo de colunas (usado pelo gerador de INSERT)
            IF loc_lProsseguir
                loc_lProsseguir = THIS.CarregarMetadados()
            ENDIF

            *-- Cache de feriados (prazo de entrega em dias uteis)
            IF loc_lProsseguir
                THIS.CarregarFeriados()
            ENDIF

            *-- 3) Vendas com desconto ELO/OuroCard ainda nao integradas
            IF loc_lProsseguir
                loc_lProsseguir = THIS.ConsultarVendasRebate()
            ENDIF

            *-- 4) Cursores de destino, com a estrutura das tabelas reais
            IF loc_lProsseguir
                loc_lProsseguir = THIS.PrepararCursores()
            ENDIF

            *-- 5) Agrupamento por Empresa + Dia + Mes
            IF loc_lProsseguir
                loc_lProsseguir = THIS.AgruparVendasRebate()
            ENDIF

            *-- 6) Um grupo por vez
            IF loc_lProsseguir
                SELECT (THIS.this_cCursorMovGrp)
                GO TOP
                DO WHILE loc_lProsseguir AND !EOF(THIS.this_cCursorMovGrp)
                    loc_lProsseguir = THIS.ProcessarGrupo()
                    IF loc_lProsseguir
                        SELECT (THIS.this_cCursorMovGrp)
                        SKIP
                    ENDIF
                ENDDO
            ENDIF

            *-- Nada a integrar: ver "UMA DIVERGENCIA DELIBERADA" no cabecalho
            IF loc_lProsseguir AND THIS.this_nRegistrosGravados = 0
                MsgAviso("Nenhuma venda com desconto ELO/OuroCard pendente " + ;
                         "de integra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                         "Grupos lidos: " + ALLTRIM(STR(THIS.this_nRegistrosLidos)) + ;
                         " - j" + CHR(225) + " integrados: " + ;
                         ALLTRIM(STR(THIS.this_nRegistrosPulados)) + ".", ;
                         "Aviso")
                loc_lProsseguir = .F.
            ENDIF

            *-- 7) Um unico ponto de gravacao, equivalente aos .Update()
            IF loc_lProsseguir
                loc_lProsseguir = THIS.GravarCursoresNoBanco()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigoprbtBO.GerarMovimentacao")
            loc_lProsseguir = .F.
        ENDTRY

        *-- .Commit() / .Rollback() do legado. Com Transactions = 2 (este
        *-- ambiente) eh o SQLCOMMIT/SQLROLLBACK que efetiva ou desfaz TUDO -
        *-- "BEGIN/COMMIT TRANSACTION" por SQLEXEC nao protegeria nada, porque
        *-- @@TRANCOUNT ja vale 1 e o par apenas aninharia.
        IF loc_lProsseguir
            IF loc_lManual
                = SQLCOMMIT(gnConnHandle)
            ENDIF
            THIS.this_lProcessouTudo = .T.
            loc_lSucesso = .T.

            *-- fRecalculaS acumulou grupo/conta/data/moeda a cada lancamento;
            *-- o modo de PROCESSAMENTO (argumento logico) recalcula os saldos
            *-- e so pode rodar DEPOIS do commit, com os lancamentos no banco.
            = fRecalculaS(.T.)
        ELSE
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            IF !EMPTY(THIS.this_cMensagemErro)
                MsgErro(THIS.this_cMensagemErro, "Falha na Integra" + ;
                        CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF

        IF BETWEEN(loc_nAliasAnt, 1, 32767)
            SELECT (loc_nAliasAnt)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarOperacao - os quatro CursorQuery do inicio do geramovimentacao:
    *
    *     CursorQuery([SigCdOpe],[crSigCdOpe],[Dopes],lcDopes)
    *     CursorQuery([SigOpCdc],[crSigOpCdc],[Dopes],lcDopes)
    *     CursorQuery([SigOpCdd],[crSigOpCdd],[Dopes],lcDopes)
    *     CursorQuery([SigOpCdi],[crSigOpCdi],[Dopes],lcDopes)
    *
    * Sao os PARAMETROS da movimentacao de rebate: SigCdOpe diz o que a
    * operacao faz (origem/destino, historico, conta corrente, tabela de
    * desconto) e os tres SigOpCd* complementam. O legado nao testa o retorno
    * destes quatro; aqui a AUSENCIA dos parametros aborta o lote, porque sem
    * eles cada leitura seguinte cairia em cursor inexistente.
    *==========================================================================
    PROTECTED FUNCTION CarregarOperacao()
        LOCAL loc_cDopes, loc_lSucesso

        loc_cDopes   = ALLTRIM(THIS.this_cDopRebate)
        loc_lSucesso = THIS.CursorQuery("SigCdOpe", THIS.this_cCursorOpe, ;
                                        "Dopes", loc_cDopes)

        IF loc_lSucesso
            loc_lSucesso = THIS.CursorQuery("SigOpCdc", THIS.this_cCursorOpCdc, ;
                                             "Dopes", loc_cDopes)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CursorQuery("SigOpCdd", THIS.this_cCursorOpCdd, ;
                                             "Dopes", loc_cDopes)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CursorQuery("SigOpCdi", THIS.this_cCursorOpCdi, ;
                                             "Dopes", loc_cDopes)
        ENDIF

        IF loc_lSucesso
            IF EOF(THIS.this_cCursorOpe)
                THIS.this_cMensagemErro = "A movimenta" + CHR(231) + CHR(227) + ;
                    "o de rebate [" + loc_cDopes + "] n" + CHR(227) + "o est" + ;
                    CHR(225) + " cadastrada em SigCdOpe."
                loc_lSucesso = .F.
            ENDIF
        ELSE
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = "Falha ao ler os par" + CHR(226) + ;
                    "metros da movimenta" + CHR(231) + CHR(227) + "o de rebate."
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarVendasRebate - a consulta central do lote, TRANSCRITA.
    *
    * Vendas (SIGMVCAB/SIGMVITN de operacao com TIPOOPS = 4) que tem desconto
    * "DESCONTO ELO/OUROCARD" ou "DESCONTO ELO" em SIGMVITD, somadas por
    * movimentacao e colecao, EXCLUINDO os trios Empresa+Dia+Mes que ja estao
    * em SIGOPRBT.
    *
    * NAO se "arruma" nada aqui (regra #17): a lista de descricoes de desconto,
    * o TIPOOPS = 4, a excecao de 'ENTREGA CONSERTO CLI', o REPLICATE que
    * monta DIA/MES com dois digitos e o NOT IN contra SIGOPRBT sao a propria
    * regra de negocio. O ORDER BY 4,3,5,2 tambem eh transcrito - ele ordena
    * por MES, DIA, COLECOES, EMPS e eh o que da ao lote a ordem cronologica.
    *
    * O teste do legado eh "< 1" (falha de SQL), que NAO eh o mesmo que "zero
    * linha": consulta valida sem linha nenhuma devolve 1 e segue - quem trata
    * o caso vazio eh o funil.
    *==========================================================================
    PROTECTED FUNCTION ConsultarVendasRebate()
        LOCAL loc_cSQL, loc_nRet, loc_lSucesso

        loc_cSQL = ;
            "SELECT B.DATAS,B.EMPS,CONVERT(CHAR(2),B.DIA) AS DIA," + ;
            "CONVERT(CHAR(2),B.MES) AS MES,A.COLECOES,B.VENDA,A.DESCONTO " + ;
            "FROM ( " + ;
            "SELECT A.EMPDOPNUMS,B.COLECOES,SUM(VDES) AS 'DESCONTO' FROM SIGMVITD A " + ;
            "LEFT OUTER JOIN SIGCDPRO B ON A.CPROS=B.CPROS " + ;
            "WHERE DDESC IN ('DESCONTO ELO/OUROCARD','DESCONTO ELO') " + ;
            "GROUP BY A.EMPDOPNUMS,B.COLECOES ) A " + ;
            "INNER JOIN ( " + ;
            "SELECT A.EMPS,A.DATAS,REPLICATE('0',2-LEN(DAY(A.DATAS))) " + ;
            "+CONVERT(VARCHAR(2),DAY(A.DATAS)) AS DIA, " + ;
            "REPLICATE('0',2-LEN(MONTH(A.DATAS))) " + ;
            "+CONVERT(VARCHAR(2),MONTH(A.DATAS)) AS MES, " + ;
            "A.EMPDOPNUMS,D.COLECOES,SUM(C.TOTAS) AS 'VENDA' FROM SIGMVCAB A " + ;
            "INNER JOIN SIGCDOPE B ON A.DOPES=B.DOPES " + ;
            "INNER JOIN SIGMVITN C ON A.EMPDOPNUMS=C.EMPDOPNUMS " + ;
            "LEFT OUTER JOIN SIGCDPRO D ON C.CPROS=D.CPROS " + ;
            "LEFT OUTER JOIN SIGMVITD E ON C.EMPDOPNUMS=E.EMPDOPNUMS " + ;
            "AND C.CITENS=E.CITENS AND E.CPROS=D.CPROS " + ;
            "WHERE B.TIPOOPS=4 AND A.DOPES NOT IN ('ENTREGA CONSERTO CLI') " + ;
            "GROUP BY A.DATAS,A.EMPS,DAY(A.DATAS),MONTH(A.DATAS)," + ;
            "A.EMPDOPNUMS,D.COLECOES)  B ON A.EMPDOPNUMS=B.EMPDOPNUMS " + ;
            "AND A.COLECOES=B.COLECOES " + ;
            "AND LTRIM(RTRIM(B.EMPS))+LTRIM(RTRIM(B.DIA))+LTRIM(RTRIM(B.MES)) " + ;
            "NOT IN(SELECT LTRIM(RTRIM(EMPS))+LTRIM(RTRIM(DIA))+LTRIM(RTRIM(MES)) " + ;
            "FROM SIGOPRBT) " + ;
            "ORDER BY 4,3,5,2"

        loc_nRet     = THIS.ExecutarConsulta(loc_cSQL, THIS.this_cCursorMvRbt)
        loc_lSucesso = (loc_nRet >= 1)

        IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
            THIS.this_cMensagemErro = "Falha na consulta das vendas com " + ;
                "desconto ELO/OuroCard."
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * PrepararCursores - cria, com a estrutura das tabelas reais, os cursores
    * que o lote preenche (ver cabecalho do motor).
    *
    * crSigMvIts e crSigMvNfi entram vazios e NAO recebem linha neste motor -
    * existem porque o calculo de prazo de entrega LE crSigMvIts e os blocos
    * de imposto de servico LEEM crSigMvNfi.CodServs. Com eles ausentes essas
    * leituras estourariam "alias not found"; com eles vazios, as condicoes
    * dao falso e os blocos ficam inertes, que eh exatamente o que acontece no
    * legado.
    *==========================================================================
    PROTECTED FUNCTION PrepararCursores()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.CriarCursorEstrutura("SigOpRbt", THIS.this_cCursorRbt)

        IF loc_lSucesso
            loc_lSucesso = THIS.CriarCursorEstrutura("SigMvCab", THIS.this_cCursorCab)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CriarCursorEstrutura("SigMvItn", THIS.this_cCursorItn)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CriarCursorEstrutura("SigMvIts", THIS.this_cCursorIts)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CriarCursorEstrutura("SigMvPar", THIS.this_cCursorPar)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CriarCursorEstrutura("SigMvCcr", THIS.this_cCursorCcr)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CriarCursorEstrutura("SigOpCoc", THIS.this_cCursorCoc)
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.CriarCursorEstrutura("SigMvNfi", THIS.this_cCursorNfi)
        ENDIF

        IF loc_lSucesso
            *-- Index On EmpDopNums Tag EmpDopNums do legado (crSigMvPar)
            SELECT (THIS.this_cCursorPar)
            INDEX ON EmpDopNums TAG EmpDopNums
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AgruparVendasRebate - o Group By do legado:
    *
    *     Select DataS, Emps, Dia, Mes, Sum(Desconto) As Desconto
    *       From crSigMvRbt Group By DataS, Emps, Dia, Mes
    *       Into Cursor csMovRbt Readwrite
    *     Index On Emps + Mes + Dia Tag Chave
    *
    * Uma linha por Empresa + Dia + Mes, com o desconto TOTAL do dia - eh essa
    * a granularidade do registro de controle em SigOpRbt e da movimentacao
    * gerada. A soma por colecao continua em crSigMvRbt e eh o que vira ITEM.
    *==========================================================================
    PROTECTED FUNCTION AgruparVendasRebate()
        LOCAL loc_cOrigem, loc_cDestino, loc_lSucesso

        loc_cOrigem  = THIS.this_cCursorMvRbt
        loc_cDestino = THIS.this_cCursorMovGrp

        IF USED(loc_cDestino)
            USE IN (loc_cDestino)
        ENDIF

        SELECT DataS, Emps, Dia, Mes, SUM(Desconto) AS Desconto ;
            FROM (loc_cOrigem) ;
            GROUP BY DataS, Emps, Dia, Mes ;
            INTO CURSOR (loc_cDestino) READWRITE

        loc_lSucesso = USED(loc_cDestino)

        IF loc_lSucesso
            SELECT (loc_cDestino)
            INDEX ON Emps + Mes + Dia TAG Chave
            GO TOP
            THIS.this_nRegistrosLidos = RECCOUNT(loc_cDestino)
        ELSE
            THIS.this_cMensagemErro = "Falha ao agrupar as vendas por " + ;
                "Empresa + Dia + M" + CHR(234) + "s."
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ProcessarGrupo - um grupo Empresa + Dia + Mes (o corpo do Scan legado).
    *
    * Ordem do legado, preservada:
    *   - estado do grupo (_Inicio, _IniLet, _TabD, _pData, _EDN, lcTpFats)
    *   - consulta de ja-integrado em SigOpRbt; achando, "loop" (pula o grupo)
    *   - Insert no registro de controle (crSigOpRbt)
    *   - Insert do cabecalho (crSigMvCab) + as regras que o ajustam
    *   - Itens por colecao (crSigMvItn)
    *   - Prazo de entrega
    *   - Parcela + lancamentos de conta corrente
    *
    * O "loop" do legado (grupo ja integrado) NAO eh erro: devolve .T. e o
    * funil segue para o grupo seguinte, contando o pulo em
    * this_nRegistrosPulados.
    *
    * fGerUniqueKey usa Alltrim(lcDopes) + lcEmps, que eh a chave do contador
    * da movimentacao daquela empresa - transcrito literalmente, inclusive o
    * ALLTRIM so no Dopes.
    *==========================================================================
    PROTECTED FUNCTION ProcessarGrupo()
        LOCAL loc_lSucesso, loc_cDopes, loc_cSQL, loc_nRet

        loc_lSucesso = .T.
        loc_cDopes   = ALLTRIM(THIS.this_cDopRebate)

        SELECT (THIS.this_cCursorMovGrp)

        THIS.this_nInicio = 0
        THIS.this_cEmps   = PADR(NVL(cursor_4c_MovAgrupado.Emps, ""), 3)
        THIS.this_cDia    = PADR(NVL(cursor_4c_MovAgrupado.Dia, ""), 2)
        THIS.this_cMes    = PADR(NVL(cursor_4c_MovAgrupado.Mes, ""), 2)
        THIS.this_nValorProc = NVL(cursor_4c_MovAgrupado.Desconto, 0)
        THIS.this_dDataMov   = NVL(cursor_4c_MovAgrupado.DataS, CTOT(""))
        THIS.this_dDatas     = ConverterParaData(THIS.this_dDataMov)

        THIS.this_nInicio = fGerUniqueKey(loc_cDopes + THIS.this_cEmps)
        THIS.this_cIniLet = ALLTRIM(fGerMascara(THIS.this_nInicio))

        *-- _TabD = Iif(Not Inlist(TabDescs,1,2,4,5,6), Space(10), Tabdps)
        IF !INLIST(NVL(cursor_4c_SigCdOpe.TabDescs, 0), 1, 2, 4, 5, 6)
            THIS.this_cTabDesconto = SPACE(10)
        ELSE
            THIS.this_cTabDesconto = NVL(cursor_4c_SigCdOpe.Tabdps, "")
        ENDIF

        THIS.this_tDataProc   = DATETIME()
        THIS.this_cPedidoRef  = ""

        *-- _EDN = lcEmps + lcDopes + Str(_Inicio,6) - chave POSICIONAL
        *-- (regra #42): Emps char(3) + Dopes char(20) + Str(,6) = char(29),
        *-- que eh a largura de SigMvCab.EmpDopNums. O PADR eh explicito de
        *-- proposito - confiar no padding que o cursor trouxe quebra a chave
        *-- em silencio e a consulta seguinte devolve ZERO linha.
        THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + ;
                                PADR(loc_cDopes, 20) + ;
                                STR(THIS.this_nInicio, 6)

        THIS.this_cTransacao = ""
        THIS.this_cIdEntrega = ""
        THIS.this_cIdTransp  = ""

        *-- lcTpFats = Iif(edtpfats=1, crSigOpCdc.TpFatPs, ' ')
        IF NVL(cursor_4c_SigCdOpe.edtpfats, 0) = 1
            THIS.this_cTpFats = NVL(cursor_4c_SigOpCdc.TpFatPs, "")
        ELSE
            THIS.this_cTpFats = " "
        ENDIF

        *-- Grupo ja integrado? (o "loop" do Scan legado)
        loc_cSQL = "Select CidChaves From SigOpRbt" + ;
                   " Where Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                   " And Dia = " + EscaparSQL(THIS.this_cDia) + ;
                   " and Mes = " + EscaparSQL(THIS.this_cMes)

        loc_nRet = THIS.ExecutarConsulta(loc_cSQL, THIS.this_cCursorTmpRbt)

        IF loc_nRet < 1
            THIS.this_cMensagemErro = "Falha ao verificar se o grupo " + ;
                ALLTRIM(THIS.this_cEmps) + "/" + ALLTRIM(THIS.this_cDia) + "/" + ;
                ALLTRIM(THIS.this_cMes) + " j" + CHR(225) + " foi integrado." + ;
                CHR(13) + THIS.this_cMensagemErro
            RETURN .F.
        ENDIF

        IF RECCOUNT(THIS.this_cCursorTmpRbt) > 0
            THIS.this_nRegistrosPulados = THIS.this_nRegistrosPulados + 1
            RETURN .T.
        ENDIF

        *-- Registro de CONTROLE da integracao. cidchaves eh a PK Fortyus e
        *-- vem de fUniqueIds() (regra #22) - NUNCA string vazia, senao o
        *-- segundo grupo do lote colide no indice unico.
        SELECT (THIS.this_cCursorRbt)
        INSERT INTO (THIS.this_cCursorRbt) (Emps, dia, mes, datas, cidchaves) ;
            VALUES (THIS.this_cEmps, THIS.this_cDia, THIS.this_cMes, ;
                    THIS.this_dDataMov, fUniqueIds())
        THIS.NormalizarNaoNulos(THIS.this_cCursorRbt, "SigOpRbt")

        *-- Cabecalho + regras que o ajustam
        loc_lSucesso = THIS.GravarCabecalho()

        *-- Itens por colecao
        IF loc_lSucesso
            loc_lSucesso = THIS.GravarItens()
        ENDIF

        *-- Prazo de entrega
        IF loc_lSucesso
            loc_lSucesso = THIS.AjustarPrazoEntrega()
        ENDIF

        *-- Parcela + conta corrente
        IF loc_lSucesso
            loc_lSucesso = THIS.GravarParcelas()
        ENDIF

        IF loc_lSucesso
            THIS.this_nRegistrosGravados = THIS.this_nRegistrosGravados + 1
            THIS.this_nValorTotal        = THIS.this_nValorTotal + THIS.this_nValorProc
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarCabecalho - o Insert do cabecalho (crSigMvCab) e TODAS as regras
    * que o legado aplica sobre ele em seguida.
    *
    * As regras sao transcritas uma a uma, na ORDEM do legado, porque varias
    * dependem do que a anterior deixou no registro (por exemplo: Tabds eh
    * gravado no Insert e depois pode ser trocado pela tabela de desconto
    * padrao; grvends alimenta GrResps).
    *
    * DUAS REGRAS QUE O LEGADO ESCREVE SOBRE CURSOR QUE ESTE SCX NAO ABRE
    * O ramo "crSigOpCdc.InibMVends = 6" insere em TprMvCabV e o ramo de
    * frete com NFiscals 1 ou 2 escreve em crSigMvNfi. Nenhum dos dois cursores
    * recebe linha neste motor:
    *   - TprMvCabV NAO esta entre os 15 AddCursor do Init legado, isto eh, no
    *     legado esse ramo ABORTA a tela com erro de alias inexistente. Aqui o
    *     lote PARA com a condicao nomeada, em vez de gravar o grupo pela
    *     metade - a ausencia fica VISIVEL (mesmo criterio da regra #27);
    *   - crSigMvNfi existe e esta VAZIO, e Replace em cursor vazio eh no-op
    *     no legado tambem. Mantido com guarda explicita de !EOF.
    *==========================================================================
    PROTECTED FUNCTION GravarCabecalho()
        LOCAL loc_lSucesso, loc_cDopes, loc_cSQL, loc_cObs, loc_cGrupoCad
        LOCAL loc_cCab, loc_cOpe, loc_cCdc, loc_cCdd, loc_cAux
        LOCAL loc_dPrazo, loc_cConta

        loc_lSucesso = .T.
        loc_cDopes   = ALLTRIM(THIS.this_cDopRebate)
        loc_cCab     = THIS.this_cCursorCab
        loc_cAux     = THIS.this_cCursorAuxiliar

        SELECT (loc_cCab)
        INSERT INTO (loc_cCab) ;
            (Emps, Dopes, Numes, Usuars, Datars, DataS, Transps, Mascnum, ;
             Tabds, LPrecos, CidChaves, EmpDopNums, Dgopes, vcompensas, TpFats) ;
            VALUES ;
            (THIS.this_cEmps, loc_cDopes, THIS.this_nInicio, ;
             gc_4c_UsuarioLogado, THIS.this_tDataProc, THIS.this_dDataMov, ;
             .F., THIS.this_cIniLet, THIS.this_cTabDesconto, "", ;
             fUniqueIds(), THIS.this_cEmpDopNums, "", ;
             NVL(cursor_4c_SigCdOpe.vcompensas, 0), THIS.this_cTpFats)

        THIS.NormalizarNaoNulos(loc_cCab, "SigMvCab")

        REPLACE Valos   WITH THIS.this_nValorProc IN (loc_cCab)
        REPLACE ValInis WITH THIS.this_nValorProc IN (loc_cCab)

        *-- Empresa de destino herda a da movimentacao
        IF NVL(cursor_4c_SigCdOpe.cEmpSubns, 0) = 5 AND ;
           NVL(cursor_4c_SigOpCdc.CarESubns, 0) != 1
            REPLACE Empds WITH cursor_4c_SigMvCab.Emps IN (loc_cCab)
        ENDIF

        *-- Observacao padrao da operacao. Os sete testes de caractere sao do
        *-- legado: marcador de substituicao (#, $, %, @, !, ^$, ^V) na
        *-- observacao significa texto que precisa ser preenchido na tela, e
        *-- lote nao tem tela - por isso nao se copia.
        IF INLIST(NVL(cursor_4c_SigCdOpe.DigObs, 0), 1, 3) AND ;
           !EMPTY(NVL(cursor_4c_SigCdOpe.ObsPads, 0))

            IF THIS.CursorQuery("SigCdObs", loc_cAux, "codigos", ;
                                ALLTRIM(STR(NVL(cursor_4c_SigCdOpe.ObsPads, 0))))
                SELECT (loc_cAux)
                GO TOP
                IF RECCOUNT(loc_cAux) > 0
                    loc_cObs = NVL(cursor_4c_Auxiliar.Observas, "")
                    IF !("#"  $ loc_cObs) AND !("$"  $ loc_cObs) AND ;
                       !("%"  $ loc_cObs) AND !("@"  $ loc_cObs) AND ;
                       !("!"  $ loc_cObs) AND !("^$" $ loc_cObs) AND ;
                       !("^V" $ loc_cObs)
                        REPLACE Obses  WITH loc_cObs, ;
                                CodObs WITH NVL(cursor_4c_SigCdOpe.ObsPads, 0) ;
                                IN (loc_cCab)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        *-- Tabela de desconto vigente na data da movimentacao
        loc_lSucesso = THIS.SelecionarTabelaDesconto()

        IF loc_lSucesso
            *-- Variacao padrao
            IF NVL(cursor_4c_SigCdOpe.vars, 0) = 1 AND ;
               NVL(cursor_4c_SigOpCdc.VarPads, 0) != 0
                REPLACE vars WITH NVL(cursor_4c_SigOpCdc.VarPads, 0) IN (loc_cCab)
            ENDIF

            *-- Frete minimo: na nota fiscal (NFiscals 1 ou 2) ou no transporte
            IF !EMPTY(NVL(cursor_4c_SigOpCdd.MinFretes, 0))
                IF INLIST(NVL(cursor_4c_SigCdOpe.NFiscals, 0), 1, 2)
                    *-- crSigMvNfi esta VAZIO neste motor: o Replace eh no-op,
                    *-- igual ao legado. A guarda existe para deixar isso
                    *-- explicito, nao para mudar comportamento.
                    IF !EOF(THIS.this_cCursorNfi)
                        REPLACE VlFretes WITH NVL(cursor_4c_SigOpCdd.MinFretes, 0) ;
                                IN (THIS.this_cCursorNfi)
                    ENDIF
                ELSE
                    REPLACE ValTrans WITH NVL(cursor_4c_SigOpCdd.MinFretes, 0) ;
                            IN (loc_cCab)
                ENDIF
            ENDIF

            *-- Grupo do vendedor e do responsavel saem da MESMA coluna
            *-- grvends de SigCdOpe: os 10 primeiros caracteres sao o grupo do
            *-- vendedor, os 10 ultimos o do responsavel. Transcrito literal -
            *-- Left/Right aqui nao sao detalhe de formatacao.
            IF INLIST(NVL(cursor_4c_SigCdOpe.Vendes, 0), 1, 2, 4, 5)
                REPLACE grvends WITH LEFT(NVL(cursor_4c_SigCdOpe.grvends, ""), 10) ;
                        IN (loc_cCab)
            ENDIF
            IF INLIST(NVL(cursor_4c_SigCdOpe.ComisDivs, 0), ;
                      1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
                REPLACE GrResps WITH RIGHT(NVL(cursor_4c_SigCdOpe.grvends, ""), 10) ;
                        IN (loc_cCab)
            ENDIF

            *-- Vendedor = usuario que roda o lote (salvo LibcSens = 3)
            IF INLIST(NVL(cursor_4c_SigCdOpe.Vendes, 0), 4, 5)
                REPLACE Vends WITH ;
                    IIF(NVL(cursor_4c_SigOpCdd.LibcSens, 0) = 3, "", ;
                        gc_4c_UsuarioLogado) IN (loc_cCab)

                IF !EMPTY(cursor_4c_SigMvCab.Vends)
                    loc_cSQL = "Select Iclis, Rclis, Cpfs, Senhas From SigCdCli" + ;
                               " Where Iclis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_SigMvCab.Vends))
                    IF THIS.ExecutarConsulta(loc_cSQL, loc_cAux) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o " + ;
                            "Processo!!!" + CHR(13) + "Falha na Conex" + ;
                            CHR(227) + "o (CrTmpCli 3)"
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF loc_lSucesso
            *-- Grupo/conta de origem e de destino fixos da operacao
            IF NVL(cursor_4c_SigCdOpe.Origems, 0) = 1
                REPLACE grupoos WITH NVL(cursor_4c_SigCdOpe.GruOrigs, ""), ;
                        contaos WITH NVL(cursor_4c_SigCdOpe.ConOrigs, "") ;
                        IN (loc_cCab)
            ENDIF
            IF NVL(cursor_4c_SigCdOpe.Destinos, 0) = 1
                REPLACE grupods WITH NVL(cursor_4c_SigCdOpe.GruDests, ""), ;
                        contads WITH NVL(cursor_4c_SigCdOpe.ConDests, "") ;
                        IN (loc_cCab)
            ENDIF

            *-- Responsavel = departamento do usuario
            IF NVL(cursor_4c_SigCdOpe.ComisDivs, 0) = 8
                loc_cSQL = "Select Deptos From SigCdUsu Where Usuarios = " + ;
                           EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
                IF THIS.ExecutarConsulta(loc_cSQL, loc_cAux) >= 1 AND ;
                   !EOF(loc_cAux)
                    REPLACE Resps WITH NVL(cursor_4c_Auxiliar.Deptos, "") ;
                            IN (loc_cCab)
                ENDIF
            ENDIF

            *-- Responsavel = gerente do cargo CargV2s
            IF NVL(cursor_4c_SigCdOpe.ComisDivs, 0) = 12 AND ;
               !EMPTY(NVL(cursor_4c_SigOpCdd.CargV2s, ""))

                loc_cGrupoCad = RIGHT(NVL(cursor_4c_SigCdOpe.GruCadVs, ""), 10)
                loc_cSQL = "Select Iclis From SigCdCli Where CCargs = " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_SigOpCdd.CargV2s)) + ;
                           " And Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                           IIF(!EMPTY(loc_cGrupoCad), ;
                               " And Grupos = " + EscaparSQL(ALLTRIM(loc_cGrupoCad)), ;
                               " ")

                IF THIS.ExecutarConsulta(loc_cSQL, loc_cAux) < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + ;
                        CHR(13) + "Falha na Conex" + CHR(227) + "o (CsGerente)"
                    loc_lSucesso = .F.
                ELSE
                    IF RECCOUNT(loc_cAux) = 1
                        REPLACE Resps WITH NVL(cursor_4c_Auxiliar.Iclis, "") ;
                                IN (loc_cCab)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        *-- Replica do cabecalho por vendedor do grupo (TprMvCabV). Ver a nota
        *-- "DUAS REGRAS QUE O LEGADO ESCREVE SOBRE CURSOR QUE ESTE SCX NAO
        *-- ABRE" no cabecalho deste metodo.
        IF loc_lSucesso AND NVL(cursor_4c_SigOpCdc.InibMVends, 0) = 6
            THIS.this_cMensagemErro = "A movimenta" + CHR(231) + CHR(227) + ;
                "o de rebate [" + loc_cDopes + "] est" + CHR(225) + ;
                " configurada com SigOpCdc.InibMVends = 6, que exige a " + ;
                "replica do cabe" + CHR(231) + "alho por vendedor em " + ;
                "TprMvCabV - tabela que esta tela n" + CHR(227) + "o abre, " + ;
                "nem no sistema legado." + CHR(13) + ;
                "Nenhum dado foi gravado."
            loc_lSucesso = .F.
        ENDIF

        *-- Prazo de entrega preliminar (soma o prazo do cliente de destino)
        IF loc_lSucesso AND NVL(cursor_4c_SigCdOpe.TransOns, 0) = 1
            IF INLIST(NVL(cursor_4c_SigCdOpe.DtEntrs, 0), 1, 4, 6)
                IF NVL(cursor_4c_SigCdOpe.COpers, 0) = 1
                    loc_cConta = NVL(cursor_4c_SigMvCab.contads, "")
                ELSE
                    loc_cConta = NVL(cursor_4c_SigMvCab.contaos, "")
                ENDIF

                IF EMPTY(NVL(cursor_4c_SigMvCab.PrazoEnts, CTOT("")))
                    loc_dPrazo = DATE()
                    IF NVL(cursor_4c_SigOpCdc.NMinEnts, 0) = ;
                       NVL(cursor_4c_SigOpCdc.nMaxEnts, 0)
                        loc_dPrazo = DATE() + NVL(cursor_4c_SigOpCdc.NMinEnts, 0)
                        REPLACE PrazoEnts WITH loc_dPrazo IN (loc_cCab)
                    ENDIF
                ELSE
                    loc_dPrazo = ConverterParaData(cursor_4c_SigMvCab.PrazoEnts)
                ENDIF

                IF THIS.CursorQuery("SigCdCli", loc_cAux, "IClis", ;
                                    loc_cConta, "PrazoEnts")
                    IF !EOF(loc_cAux) AND NVL(cursor_4c_Auxiliar.PrazoEnts, 0) > 0
                        loc_dPrazo = loc_dPrazo + NVL(cursor_4c_Auxiliar.PrazoEnts, 0)
                        REPLACE PrazoEnts WITH loc_dPrazo IN (loc_cCab)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF loc_lSucesso
            THIS.this_nMovimentosGerados = THIS.this_nMovimentosGerados + 1
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * SelecionarTabelaDesconto - a cascata de TRES consultas do legado que
    * descobre qual tabela de desconto vale na data da movimentacao:
    *
    *   1. as tabelas amarradas a esta movimentacao (SigOpTdz x SigOpTdo);
    *   2. nao achando nenhuma vigente, as tabelas da EMPRESA (SigOpTde);
    *   3. nao achando ainda, TODAS as tabelas, com Padraos = 0.
    *
    * "Vigente" eh DtTerms vazia OU DtTerms >= data da movimentacao. O legado
    * escreve esse filtro com IsEmpty(DtTerms); aqui vai
    * (ISNULL(DtTerms) OR EMPTY(DtTerms)), que eh o MESMO predicado - o
    * IsEmpty do Fortyus trata NULL como vazio - sem por funcao de usuario
    * dentro de um SELECT (regra #16).
    *
    * Depois, com TabDescs = 4 e sem tabela valida no cabecalho, assume a
    * primeira tabela marcada como padrao.
    *==========================================================================
    PROTECTED FUNCTION SelecionarTabelaDesconto()
        LOCAL loc_cSQL, loc_cTdz, loc_cTds, loc_cCab, loc_lSucesso, loc_dData

        loc_lSucesso = .T.
        loc_cTdz     = THIS.this_cCursorTabDesc
        loc_cTds     = THIS.this_cCursorTabDescSel
        loc_cCab     = THIS.this_cCursorCab
        loc_dData    = NVL(cursor_4c_SigMvCab.DataS, CTOT(""))

        loc_cSQL = "Select a.* From SigOpTdz a, SigOpTdo b" + ;
                   " Where b.Dopes = " + ;
                   EscaparSQL(ALLTRIM(NVL(cursor_4c_SigCdOpe.Dopes, ""))) + ;
                   " And a.Codigos = b.Tabds"

        IF THIS.ExecutarConsulta(loc_cSQL, loc_cTdz) < 1
            THIS.this_cMensagemErro = "Falha ao ler a tabela de desconto da " + ;
                "movimenta" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                THIS.this_cMensagemErro
            RETURN .F.
        ENDIF

        IF USED(loc_cTds)
            USE IN (loc_cTds)
        ENDIF
        SELECT * FROM (loc_cTdz) ;
            WHERE (ISNULL(DtTerms) OR EMPTY(DtTerms)) OR DtTerms >= m.loc_dData ;
            INTO CURSOR (loc_cTds) READWRITE

        IF RECCOUNT(loc_cTds) = 0
            loc_cSQL = "Select a.*,b.Padraos From SigOpTdz a, SigOpTde b" + ;
                       " Where a.Codigos = b.CodtabDs And b.Emps = " + ;
                       EscaparSQL(ALLTRIM(NVL(cursor_4c_SigMvCab.Emps, "")))

            IF THIS.ExecutarConsulta(loc_cSQL, loc_cTdz) < 1
                THIS.this_cMensagemErro = "Falha ao ler a tabela de desconto " + ;
                    "da empresa." + CHR(13) + THIS.this_cMensagemErro
                RETURN .F.
            ENDIF

            USE IN (loc_cTds)
            SELECT * FROM (loc_cTdz) ;
                WHERE (ISNULL(DtTerms) OR EMPTY(DtTerms)) OR DtTerms >= m.loc_dData ;
                INTO CURSOR (loc_cTds) READWRITE

            IF RECCOUNT(loc_cTds) = 0
                IF THIS.ExecutarConsulta("Select *, 0 as Padraos From SigOpTdz", ;
                                         loc_cTdz) < 1
                    THIS.this_cMensagemErro = "Falha ao ler as tabelas de " + ;
                        "desconto." + CHR(13) + THIS.this_cMensagemErro
                    RETURN .F.
                ENDIF

                USE IN (loc_cTds)
                SELECT * FROM (loc_cTdz) ;
                    WHERE (ISNULL(DtTerms) OR EMPTY(DtTerms)) OR DtTerms >= m.loc_dData ;
                    INTO CURSOR (loc_cTds) READWRITE
            ENDIF
        ENDIF

        SELECT (loc_cTds)
        INDEX ON Codigos TAG Codigos

        IF NVL(cursor_4c_SigCdOpe.TabDescs, 0) = 4 AND ;
           (EMPTY(NVL(cursor_4c_SigMvCab.Tabds, "")) OR ;
            !SEEK(cursor_4c_SigMvCab.Tabds, loc_cTds, "Codigos"))

            SELECT (loc_cTds)
            SCAN
                IF NVL(cursor_4c_TabDescSel.Padraos, 0) = 1
                    REPLACE Tabds WITH NVL(cursor_4c_TabDescSel.Codigos, "") ;
                            IN (loc_cCab)
                    EXIT
                ENDIF
            ENDSCAN
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarItens - um item de movimentacao por COLECAO do grupo.
    *
    * O legado reconsulta crSigMvRbt filtrando o grupo corrente (DataS + Emps
    * + Dia + Mes) ordenado por Colecoes, e para cada colecao grava UM item do
    * produto generico daquela colecao:
    *
    *     lcProd = 'GENERICO ' + Alltrim(csItnRbt.Colecoes)
    *
    * Esse nome com o prefixo "GENERICO " eh REGRA DE NEGOCIO, nao formatacao:
    * eh o codigo em SigCdPro.Cpros do produto que representa a colecao.
    * Colecao sem produto generico cadastrado nao gera item (Reccount = 0) e
    * NAO aborta o lote - igual ao legado.
    *
    * A consulta de SigCdGrp.TipoEstos tem o retorno DESCARTADO pelo legado;
    * ela permanece porque a FALHA dela aborta o lote, e porque suprimi-la
    * mudaria o que o lote exige do banco.
    *
    * O "For i = 1 To Abs(lnQtds)" com lnQtds fixo em 1 roda uma vez so -
    * transcrito como esta, porque eh ele que define que a quantidade do item
    * de rebate eh 1 (o valor do desconto vai no preco unitario, nao na
    * quantidade).
    *==========================================================================
    PROTECTED FUNCTION GravarItens()
        LOCAL loc_lSucesso, loc_cDopes, loc_cOpers, loc_cSQL, loc_cProd
        LOCAL loc_nQtds, loc_nDesc, loc_nValor, loc_nValor2, loc_cMsg
        LOCAL loc_nBarras, loc_nI, loc_cItens, loc_cPro, loc_cAux, loc_cOrig
        LOCAL loc_dData, loc_cEmps, loc_cDia, loc_cMes

        loc_lSucesso = .T.
        loc_cDopes   = ALLTRIM(THIS.this_cDopRebate)
        loc_cItens   = THIS.this_cCursorItnRbt
        loc_cPro     = THIS.this_cCursorProduto
        loc_cAux     = THIS.this_cCursorAuxiliar

        *-- lcOpers = Iif(Opers=1,'E',Iif(Opers=2,'S',Iif(Opers=3,OpePads,'S')))
        DO CASE
        CASE NVL(cursor_4c_SigCdOpe.Opers, 0) = 1
            loc_cOpers = "E"
        CASE NVL(cursor_4c_SigCdOpe.Opers, 0) = 2
            loc_cOpers = "S"
        CASE NVL(cursor_4c_SigCdOpe.Opers, 0) = 3
            loc_cOpers = NVL(cursor_4c_SigCdOpe.OpePads, "")
        OTHERWISE
            loc_cOpers = "S"
        ENDCASE
        THIS.this_cOperacao = loc_cOpers

        loc_cEmps = THIS.this_cEmps
        loc_cDia  = THIS.this_cDia
        loc_cMes  = THIS.this_cMes
        loc_dData = THIS.this_dDataMov

        IF USED(loc_cItens)
            USE IN (loc_cItens)
        ENDIF

        loc_cOrig = THIS.this_cCursorMvRbt

        SELECT DataS, Emps, Dia, Mes, Colecoes, Desconto AS Valor ;
            FROM (loc_cOrig) ;
            WHERE DataS = m.loc_dData AND Emps = m.loc_cEmps ;
              AND Dia = m.loc_cDia AND Mes = m.loc_cMes ;
            ORDER BY Colecoes ;
            INTO CURSOR (loc_cItens) READWRITE

        THIS.this_nItem = 1

        SELECT (loc_cItens)
        GO TOP
        DO WHILE loc_lSucesso AND !EOF(loc_cItens)

            loc_cProd   = "GENERICO " + ALLTRIM(NVL(cursor_4c_ItensRebate.Colecoes, ""))
            loc_nQtds   = 1
            loc_nDesc   = 0
            loc_nValor  = NVL(cursor_4c_ItensRebate.Valor, 0)
            loc_cMsg    = ""
            loc_nValor2 = loc_nValor - loc_nDesc

            loc_cSQL = "Select Dpros, Cunis, Cunips, Moevs, Cpros, CodCors," + ;
                       " Conjunts, CGrus From SigCdPro Where Cpros = " + ;
                       EscaparSQL(loc_cProd)

            IF THIS.ExecutarConsulta(loc_cSQL, loc_cPro) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + ;
                    CHR(13) + "Falha na Conex" + CHR(227) + "o (crSigCdPro)"
                loc_lSucesso = .F.
            ELSE
                SELECT (loc_cPro)
                IF RECCOUNT(loc_cPro) > 0

                    loc_cSQL = "Select TipoEstos From SigCdGrp Where CGrus = " + ;
                               EscaparSQL(ALLTRIM(NVL(cursor_4c_SigCdPro.CGrus, "")))

                    IF THIS.ExecutarConsulta(loc_cSQL, loc_cAux) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o " + ;
                            "Processo!!!" + CHR(13) + "Falha na Conex" + ;
                            CHR(227) + "o (crTmpGru)"
                        loc_lSucesso = .F.
                    ELSE
                        loc_nBarras = 0

                        FOR loc_nI = 1 TO ABS(loc_nQtds)
                            SELECT (THIS.this_cCursorItn)
                            INSERT INTO (THIS.this_cCursorItn) ;
                                (cPros, Dopes, Emps, Numes, Opers, Qtds, CItens, ;
                                 Units, Unit2s, RatFrts, ValRats, Totas, Moedas, ;
                                 DPros, CUnis, CidChaves, DtAlts, EmpDopNums, ;
                                 Pesos, codbarras, Obs) ;
                                VALUES ;
                                (NVL(cursor_4c_SigCdPro.cPros, ""), loc_cDopes, ;
                                 THIS.this_cEmps, THIS.this_nInicio, loc_cOpers, ;
                                 1, THIS.this_nItem, loc_nValor, loc_nValor2, 0, ;
                                 (loc_nDesc * (-1)), (loc_nValor * 1), ;
                                 NVL(cursor_4c_SigCdPro.MoeVs, ""), ;
                                 NVL(cursor_4c_SigCdPro.DPros, ""), ;
                                 NVL(cursor_4c_SigCdPro.CUnis, ""), ;
                                 fUniqueIds(), DATE(), THIS.this_cEmpDopNums, ;
                                 0, loc_nBarras, loc_cMsg)

                            THIS.NormalizarNaoNulos(THIS.this_cCursorItn, "SigMvItn")
                            THIS.this_nItensGerados = THIS.this_nItensGerados + 1
                            THIS.this_nItem = THIS.this_nItem + 1
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lSucesso
                SELECT (loc_cItens)
                SKIP
            ENDIF
        ENDDO

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AjustarPrazoEntrega - o bloco "Inlist(crSigCdOpe.DtEntrs, 1, 4, 6)" do
    * legado, que soma dias ao prazo de entrega conforme a configuracao de
    * "Adicionar na Entrega" (crSigCdOpe.Situas):
    *
    *     1-Nenhum  2-Cor  3-Componente  4-Ambos  5-Servico (prazo por grupo)
    *
    * POR QUE ESTE BLOCO NAO SOMA NADA NESTE LOTE
    * Situas 2 e 5 percorrem crSigMvIts (itens de TAMANHO/COR da movimentacao)
    * e este motor nunca insere linha nesse cursor - ele grava os itens em
    * crSigMvItn. Com crSigMvIts vazio, o Max(DiasEnts) nao acha linha e o
    * Scan nao itera, entao lnSum fica 0 e nada eh somado; Situas 3 ja vem com
    * lnMax = 0 escrito no proprio legado. Isso NAO eh simplificacao desta
    * migracao: eh o comportamento do legado, e eh por isso que a contagem de
    * dias uteis (fChkFeriado) tambem nao chega a rodar.
    *
    * O bloco eh transcrito inteiro, com o cache de feriados ja carregado,
    * porque basta a tela passar a alimentar crSigMvIts para ele voltar a
    * valer - e porque descartar o calculo escondendo a razao eh o que a regra
    * #17 proibe.
    *==========================================================================
    PROTECTED FUNCTION AjustarPrazoEntrega()
        LOCAL loc_lSucesso, loc_nSum, loc_nMax, loc_cSQL, loc_cAux, loc_cIts
        LOCAL loc_lSab, loc_lDom, loc_lFer, loc_dDI1, loc_dDI2, loc_dEnt
        LOCAL loc_cCab

        loc_lSucesso = .T.
        loc_cCab     = THIS.this_cCursorCab
        loc_cAux     = THIS.this_cCursorAuxiliar
        loc_cIts     = THIS.this_cCursorIts

        IF !INLIST(NVL(cursor_4c_SigCdOpe.DtEntrs, 0), 1, 4, 6)
            RETURN .T.
        ENDIF
        IF NVL(cursor_4c_SigCdOpe.Situas, 0) <= 1
            RETURN .T.
        ENDIF

        loc_nSum = 0

        *-- Situas 2/4: maior prazo de entrega entre as CORES dos itens
        IF INLIST(NVL(cursor_4c_SigCdOpe.Situas, 0), 2, 4)
            IF THIS.ExecutarConsulta("Select Cods, DiasEnts From SigCdCor", ;
                                     loc_cAux) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + ;
                    CHR(13) + "Falha na Conex" + CHR(227) + "o (LocalCor)"
                RETURN .F.
            ENDIF

            IF USED("cursor_4c_LocalDias")
                USE IN cursor_4c_LocalDias
            ENDIF
            SELECT MAX(b.DiasEnts) AS Dias ;
                FROM (loc_cIts) a, (loc_cAux) b ;
                WHERE a.CodCors = b.Cods ;
                INTO CURSOR cursor_4c_LocalDias

            SELECT cursor_4c_LocalDias
            GO TOP IN cursor_4c_LocalDias
            IF !EOF("cursor_4c_LocalDias") AND NVL(cursor_4c_LocalDias.Dias, 0) > 0
                loc_nSum = loc_nSum + NVL(cursor_4c_LocalDias.Dias, 0)
            ENDIF
            USE IN cursor_4c_LocalDias
        ENDIF

        *-- Situas 3/4: componente. O legado deixa lnMax = 0 fixo (o calculo
        *-- por componente nunca foi implementado la) - transcrito como esta.
        IF INLIST(NVL(cursor_4c_SigCdOpe.Situas, 0), 3, 4)
            loc_nMax = 0
            IF loc_nMax > 0
                loc_nSum = loc_nSum + loc_nMax
            ENDIF
        ENDIF

        *-- Situas 5: prazo de servico por grupo do produto (SigCdPrz)
        IF INLIST(NVL(cursor_4c_SigCdOpe.Situas, 0), 5)
            loc_nMax = 0
            SELECT (loc_cIts)
            GO TOP
            DO WHILE loc_lSucesso AND !EOF(loc_cIts)
                *-- O legado le crSigcdemp.Cemps aqui - cursor que este SCX
                *-- NAO abre (nao esta entre os 15 AddCursor do Init). A
                *-- empresa do grupo corrente eh o unico referente possivel e
                *-- eh o que vai aqui; a alternativa seria abortar um calculo
                *-- que, como explicado no cabecalho, nem chega a iterar.
                loc_cSQL = "Select b.DiasPrz From SigCdPro a, SigCdprz b" + ;
                           " where a.cpros = " + ;
                           EscaparSQL(ALLTRIM(EVALUATE(loc_cIts + ".cPros"))) + ;
                           " and a.CGrus = b.codigos And b.Emps = " + ;
                           EscaparSQL(THIS.this_cEmps)

                IF THIS.ExecutarConsulta(loc_cSQL, loc_cAux) < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o " + ;
                        "Processo!!!" + CHR(13) + "Falha na Conex" + ;
                        CHR(227) + "o (crPrz)"
                    loc_lSucesso = .F.
                ELSE
                    SELECT (loc_cAux)
                    GO TOP
                    IF !EOF(loc_cAux) AND NVL(cursor_4c_Auxiliar.DiasPrz, 0) > loc_nMax
                        loc_nMax = NVL(cursor_4c_Auxiliar.DiasPrz, 0)
                    ENDIF

                    SELECT (loc_cIts)
                    SKIP
                ENDIF
            ENDDO

            IF loc_lSucesso AND loc_nMax > 0
                loc_nSum = loc_nMax
            ENDIF
        ENDIF

        IF loc_lSucesso AND loc_nSum > 0
            *-- Dias UTEIS. chkUteis: 0/4 = corridos; 1 = pula sabado, domingo
            *-- e feriado; 2 = so feriado; 3 = domingo e feriado.
            *-- llFer eh calculado pelo legado e NAO entra na chamada de
            *-- fChkFeriado - transcrito igual, inclusive por isso: o feriado
            *-- eh sempre considerado.
            IF !INLIST(NVL(cursor_4c_SigOpCdd.chkUteis, 0), 0, 4)
                loc_lSab = INLIST(NVL(cursor_4c_SigOpCdd.chkUteis, 0), 1)
                loc_lDom = INLIST(NVL(cursor_4c_SigOpCdd.chkUteis, 0), 1, 3)
                loc_lFer = INLIST(NVL(cursor_4c_SigOpCdd.chkUteis, 0), 1, 2, 3)

                loc_dDI1 = ConverterParaData(cursor_4c_SigMvCab.DataS)
                loc_dDI2 = ConverterParaData(cursor_4c_SigMvCab.DataS) + loc_nSum
                DO WHILE loc_dDI1 <= loc_dDI2
                    IF THIS.VerificarFeriado(loc_dDI1, loc_lSab, loc_lDom)
                        loc_nSum = loc_nSum + 1
                    ENDIF
                    loc_dDI1 = loc_dDI1 + 1
                    loc_dDI2 = ConverterParaData(cursor_4c_SigMvCab.DataS) + loc_nSum
                ENDDO
            ENDIF

            loc_dEnt = ConverterParaData(cursor_4c_SigMvCab.DataS) + loc_nSum

            IF ConverterParaData(cursor_4c_SigMvCab.PrazoEnts) != loc_dEnt
                REPLACE PrazoEnts WITH loc_dEnt IN (loc_cCab)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarParcelas - a parcela (crSigMvPar) e, por parcela, o lancamento de
    * conta corrente.
    *
    * Transcricao do bloco "Lanca as informacoes da Parcela" do legado. Os
    * pontos que NAO se "arrumam" (regra #17):
    *
    *   - lnPar = 1: o rebate eh integrado em UMA parcela. O laco "For i = 1
    *     To lnPar" e o ajuste de resto existem no legado para o caso geral e
    *     sao transcritos, mas com lnPar = 1 o resto eh sempre zero;
    *   - valpar = Round(lnValor / lnPar, 2) e o ajuste
    *     "If totpar # lnValor -> Valos = Valos + (lnValor - totpar)" na
    *     ULTIMA parcela: eh o que garante que a soma das parcelas feche com o
    *     valor do cabecalho, centavo a centavo;
    *   - ldDtV = ldDatas + LocalFPag.Dias, somado ANTES da primeira parcela e
    *     de novo depois de cada uma - o primeiro vencimento ja vem deslocado;
    *   - a conta corrente so eh lancada quando
    *     (COpers = 1 Or ctipos = 2) And Inlist(ParContas, 1, 3).
    *
    * A forma de pagamento vem de crSigCdOpe.FpagOpCrs; sem ela cadastrada em
    * SigOpFp o legado aborta o lote ("Falha na Conexao - LocalFPag"), e eh o
    * que se reproduz aqui.
    *==========================================================================
    PROTECTED FUNCTION GravarParcelas()
        LOCAL loc_lSucesso, loc_cDopes, loc_cSQL, loc_cFPag, loc_cPar
        LOCAL loc_nPar, loc_nValor, loc_nValPar, loc_nTotPar, loc_nDif
        LOCAL loc_dDatas, loc_dDtV, loc_cPagto, loc_cMdf, loc_cMoe
        LOCAL loc_nI, loc_nNumP, loc_nParc

        loc_lSucesso = .T.
        loc_cDopes   = ALLTRIM(THIS.this_cDopRebate)
        loc_cFPag    = THIS.this_cCursorOpFp
        loc_cPar     = THIS.this_cCursorPar

        *-- _Noper = fGerUniqueKey('SigMvCcr')
        THIS.this_nNOper = fGerUniqueKey("SigMvCcr")
        loc_cMoe         = ALLTRIM(THIS.this_cMoedaPadrao)

        loc_nPar   = 1
        loc_dDatas = NVL(cursor_4c_SigMvCab.DataS, CTOT(""))
        loc_nValor = NVL(cursor_4c_SigMvCab.Valos, 0)
        loc_dDtV   = loc_dDatas

        loc_cPagto = NVL(cursor_4c_SigCdOpe.FpagOpCrs, "")

        loc_cSQL = "Select * from SigOpFp Where FPags = " + ;
                   EscaparSQL(ALLTRIM(loc_cPagto))

        IF THIS.ExecutarConsulta(loc_cSQL, loc_cFPag) < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + ;
                CHR(13) + "Falha na Conex" + CHR(227) + ;
                "o (CursorQuery - LocalFPag)"
            RETURN .F.
        ENDIF

        THIS.this_nContaPar = 0

        loc_nTotPar = 0
        loc_nNumP   = 1
        loc_nParc   = loc_nPar

        SELECT (loc_cFPag)
        IF EOF(loc_cFPag)
            *-- Forma de pagamento inexistente: o legado nao grava parcela
            *-- nenhuma e segue (o If "Not Eof" simplesmente nao entra).
            RETURN .T.
        ENDIF

        loc_cMdf   = IIF(EMPTY(NVL(cursor_4c_SigOpFp.MoeFpgs, "")), loc_cMoe, ;
                         NVL(cursor_4c_SigOpFp.MoeFpgs, ""))
        loc_cPagto = NVL(cursor_4c_SigOpFp.FPags, "")

        loc_dDtV = ConverterParaData(loc_dDtV) + NVL(cursor_4c_SigOpFp.Dias, 0)

        FOR loc_nI = 1 TO loc_nPar

            loc_nValPar = ROUND(loc_nValor / loc_nPar, 2)
            loc_nTotPar = loc_nTotPar + loc_nValPar

            SELECT (loc_cPar)
            INSERT INTO (loc_cPar) ;
                (Emps, Dopes, Numes, EmpDopNums, DataS, CidChaves, CotFPgs, ;
                 FPags, MoeFpgs, NOpers, Valos, Vencs, Parcs, Pagos, DtAlts, ;
                 Nsu, Autoriza) ;
                VALUES ;
                (THIS.this_cEmps, loc_cDopes, THIS.this_nInicio, ;
                 THIS.this_cEmpDopNums, loc_dDatas, fUniqueIds(), 1, ;
                 loc_cPagto, loc_cMdf, THIS.this_nNOper, loc_nValPar, ;
                 loc_dDtV, loc_nI, "1", DATETIME(), THIS.this_cTransacao, ".")

            THIS.NormalizarNaoNulos(loc_cPar, "SigMvPar")
            THIS.this_nParcelasGeradas = THIS.this_nParcelasGeradas + 1
            THIS.this_nValorParcela    = loc_nValPar
            THIS.this_dVencimento      = loc_dDtV
            THIS.this_cFormaPagto      = loc_cPagto
            THIS.this_cMoedaFPag       = loc_cMdf

            loc_dDtV = loc_dDtV + NVL(cursor_4c_SigOpFp.Dias, 0)

            *-- Ajuste de resto na ULTIMA parcela
            IF loc_nParc = loc_nNumP
                IF loc_nTotPar != loc_nValor
                    loc_nDif = (loc_nValor - loc_nTotPar)
                    REPLACE Valos WITH EVALUATE(loc_cPar + ".Valos") + loc_nDif ;
                            IN (loc_cPar)
                ENDIF
            ENDIF

            *-- Conta corrente da parcela
            THIS.this_nContaPar = THIS.this_nContaPar + 1

            IF (NVL(cursor_4c_SigCdOpe.COpers, 0) = 1 OR ;
                NVL(cursor_4c_SigCdOpe.ctipos, 0) = 2) AND ;
               INLIST(NVL(cursor_4c_SigCdOpe.ParContas, 0), 1, 3)

                IF !THIS.LancarContaCorrente(.F.)
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDIF

            loc_nParc = loc_nParc - 1
        ENDFOR

        THIS.this_nTotalParcelas = loc_nTotPar
        THIS.this_nParcelas      = loc_nPar

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarCursoresNoBanco - os onze .Update() seguidos do .Commit() unico.
    *
    * O legado faz os Update NESTA ordem e para no primeiro que falha
    * (lnErro1 deixa de ser > 0), caindo no .Rollback(). A ordem importa:
    * cabecalho antes dos itens, itens antes das parcelas, e o registro de
    * CONTROLE (SigOpRbt) por ULTIMO - assim um erro em qualquer tabela da
    * movimentacao deixa o trio Empresa+Dia+Mes fora de SigOpRbt e o lote
    * seguinte reprocessa o dia, em vez de marca-lo como integrado sem ter
    * gravado a movimentacao.
    *
    * crSigMvHst/crSigChe/crSigChLcq/crSigCqChm nao aparecem: ver o cabecalho
    * do motor (sao .Update de cursor vazio, no-op).
    *==========================================================================
    PROTECTED FUNCTION GravarCursoresNoBanco()
        LOCAL loc_lSucesso

        THIS.this_nLinhasGravadas = 0

        loc_lSucesso = THIS.GravarCursorNoBanco(THIS.this_cCursorCab, "SigMvCab")

        IF loc_lSucesso
            loc_lSucesso = THIS.GravarCursorNoBanco(THIS.this_cCursorItn, "SigMvItn")
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.GravarCursorNoBanco(THIS.this_cCursorIts, "SigMvIts")
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.GravarCursorNoBanco(THIS.this_cCursorPar, "SigMvPar")
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.GravarCursorNoBanco(THIS.this_cCursorCcr, "SigMvCcr")
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.GravarCursorNoBanco(THIS.this_cCursorCoc, "SigOpCoc")
        ENDIF
        IF loc_lSucesso
            loc_lSucesso = THIS.GravarCursorNoBanco(THIS.this_cCursorRbt, "SigOpRbt")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * LancarContaCorrente - PREAMBULO + os tres blocos de lancamento.
    *
    * Traducao da PROCEDURE lancacontacorrente legada
    * (sigoprbt_form_codigo_fonte.txt:796-1718), chamada UMA vez por parcela.
    *
    * O legado eh um metodo unico de 917 linhas com tres blocos claramente
    * delimitados por comentario; aqui cada bloco eh um metodo, com o estado
    * comum nas properties this_* (sao as MESMAS variaveis "_" do legado - ver
    * a secao de propriedades no topo deste BO). Nenhuma condicao foi
    * reagrupada: a ordem e os testes sao linha a linha do dump.
    *
    *   PREAMBULO              data de contabilizacao, forma de pagamento,
    *                          documento, titulo e nota
    *   LancarMovimentacaoCliente   "Movimentacao x Cliente" - as DUAS pernas
    *                          (debito e credito) do lancamento principal
    *   LancarClienteFormaPagto     "Cliente X Forma de Pagamento" - a perna
    *                          adicional quando a forma de pagamento tem
    *                          grupo/conta de destino proprios
    *   LancarTaxaCartao       "Taxas de Cartao de Credito"
    *
    * PARAMETRO llvoper
    * O legado aceita um parametro logico que troca o retorno (numero da
    * operacao em vez de .T./.F.) e muda a MONTAGEM de _voper. Neste form a
    * unica chamada eh "=ThisForm.LancaContaCorrente()" - sem argumento, isto
    * eh, llvoper vem .F. O parametro eh preservado porque e' ele que decide
    * se _voper leva o _TIPOE no meio, e remover isso faria o identificador
    * visual da operacao mudar de formato.
    *==========================================================================
    PROTECTED FUNCTION LancarContaCorrente(par_lVOper)
        LOCAL loc_lSucesso, loc_lVOper, loc_cTit, loc_cSQL, loc_cAux

        loc_lSucesso = .T.
        loc_lVOper   = (PCOUNT() >= 1 AND VARTYPE(par_lVOper) = "L" AND par_lVOper)
        loc_cAux     = THIS.this_cCursorAuxiliar

        WAIT WINDOW "Aguarde. Processando Lancamentos de Conta Corrente!!! " NOWAIT

        THIS.this_tDataProc  = DATETIME()
        THIS.this_cRazaoCli  = ""
        THIS.this_nRetVOper  = 0

        *-- Data de contabilizacao: 2 = no VENCIMENTO da parcela; qualquer
        *-- outro valor = na data de LANCAMENTO (a da parcela, ou a do
        *-- cabecalho quando a parcela nao tem data).
        IF NVL(cursor_4c_SigCdOpe.DtContab, 0) = 2
            THIS.this_dDataContab = NVL(cursor_4c_SigMvPar.Vencs, CTOT(""))
        ELSE
            IF EMPTY(NVL(cursor_4c_SigMvPar.Datas, CTOT("")))
                THIS.this_dDataContab = NVL(cursor_4c_SigMvCab.Datas, CTOT(""))
            ELSE
                THIS.this_dDataContab = NVL(cursor_4c_SigMvPar.Datas, CTOT(""))
            ENDIF
        ENDIF

        *-- Forma de pagamento da PARCELA (pode diferir da da operacao)
        IF !THIS.CursorQuery("SigOpFp", THIS.this_cCursorOpFp, "Fpags", ;
                             NVL(cursor_4c_SigMvPar.Fpags, ""))
            THIS.this_cMensagemErro = "Falha ao ler a forma de pagamento [" + ;
                ALLTRIM(NVL(cursor_4c_SigMvPar.Fpags, "")) + "]." + CHR(13) + ;
                THIS.this_cMensagemErro
            RETURN .F.
        ENDIF

        *-- _doc = Transf(NDopes,"@L 999") + Transf(Numes,"@L 999999")
        THIS.this_cDocumento = TRANSFORM(NVL(cursor_4c_SigCdOpe.NDopes, 0), "@L 999") + ;
                               TRANSFORM(NVL(cursor_4c_SigMvCab.Numes, 0), "@L 999999")

        *-- Titulo bancario: so quando a forma de pagamento eh BOLETO (Infos
        *-- = "B") com impressao de boleto ligada.
        IF NVL(cursor_4c_SigOpFp.Infos, "") = "B" AND ;
           NVL(cursor_4c_SigOpFp.ImpBols, 0) = 1
            THIS.this_cTitBan = NVL(cursor_4c_SigMvPar.nCarnes, "")
        ELSE
            THIS.this_cTitBan = ""
        ENDIF

        THIS.this_cDepartamento = SPACE(10)

        *-- Titulo: a nota da movimentacao; nao havendo nota e existindo
        *-- movimentacao de contrapartida (DopCs) com valor pendente, o titulo
        *-- eh gerado pelo identificador da operacao + um sequencial proprio.
        loc_cTit = ALLTRIM(NVL(cursor_4c_SigMvCab.Notas, ""))

        IF EMPTY(loc_cTit) AND !EMPTY(NVL(cursor_4c_SigCdOpe.DopCs, ""))
            IF THIS.CursorQuery("SigOpFp", loc_cAux, "Fpags", ;
                                NVL(cursor_4c_SigMvPar.Fpags, "")) AND ;
               NVL(cursor_4c_Auxiliar.ValPends, 0) = 1

                IF THIS.CursorQuery("SigOpOpe", loc_cAux, "Dopes", ;
                                    NVL(cursor_4c_SigCdOpe.DopCs, ""), "Identifics")
                    loc_cTit = NVL(cursor_4c_Auxiliar.Identifics, "") + ;
                        TRANSFORM(fGerUniqueKey(ALLTRIM(NVL(cursor_4c_SigCdOpe.DopCs, ""))), ;
                                  "@L 999999")
                ENDIF
            ENDIF
        ENDIF

        THIS.this_cTitulo = loc_cTit

        *-- OpcSNAs = 2: a nota NAO vai para o lancamento
        IF NVL(cursor_4c_SigOpFp.OpcSNAs, 0) = 2
            THIS.this_cNotaFiscal = " "
        ELSE
            THIS.this_cNotaFiscal = NVL(cursor_4c_SigMvCab.Notas, "")
        ENDIF

        *-- Bloco 1 - Movimentacao x Cliente
        IF !EMPTY(NVL(cursor_4c_SigCdOpe.Grupos, "") + ;
                  NVL(cursor_4c_SigCdOpe.Contas, "")) OR ;
           EOF(THIS.this_cCursorPar)
            loc_lSucesso = THIS.LancarMovimentacaoCliente(loc_lVOper)
        ENDIF

        *-- Bloco 2 - Cliente x Forma de Pagamento
        IF loc_lSucesso
            IF !EMPTY(NVL(cursor_4c_SigOpFp.Grupods, "")) AND ;
               (NVL(cursor_4c_SigOpFp.ValPends, 0) != 1 OR ;
                (NVL(cursor_4c_SigOpFp.ValPends, 0) = 1 AND ;
                 NVL(cursor_4c_SigOpFp.AgCobs, 0) != 1)) AND ;
               (!EMPTY(NVL(cursor_4c_SigOpFp.Contads, "")) OR ;
                INLIST(NVL(cursor_4c_SigOpFp.OriDes, 0), 1, 2)) AND ;
               !EOF(THIS.this_cCursorPar)
                loc_lSucesso = THIS.LancarClienteFormaPagto(loc_lVOper)
            ENDIF
        ENDIF

        *-- Bloco 3 - Taxas de Cartao de Credito
        IF loc_lSucesso
            IF !EMPTY(NVL(cursor_4c_SigCdOpe.Grupos, "") + ;
                      NVL(cursor_4c_SigCdOpe.Contas, "")) AND ;
               NVL(cursor_4c_SigOpFp.Infos, "") = "T" AND ;
               !EMPTY(NVL(cursor_4c_SigOpFp.GrupoTs, "")) AND ;
               !EMPTY(NVL(cursor_4c_SigOpFp.ContaTs, "")) AND ;
               NVL(cursor_4c_SigOpFp.Desc2s, 0) > 0 AND ;
               THIS.this_nNumCont > 0 AND !EOF(THIS.this_cCursorPar)
                loc_lSucesso = THIS.LancarTaxaCartao(loc_lVOper)
            ENDIF
        ENDIF

        WAIT CLEAR

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * LancarMovimentacaoCliente - bloco "Movimentacao x Cliente".
    *
    * Grava as DUAS pernas do lancamento principal no mesmo cursor
    * (crSigMvCcr): a primeira com grupo/conta de ORIGEM nas colunas
    * grupos/contas e o destino nas s*, a segunda com os dois lados INVERTIDOS.
    * Eh esse par que fecha o debito e o credito - gravar so a primeira
    * deixaria a conta corrente desbalanceada sem erro nenhum.
    *
    * CONTEXTO QUE ESTE SCX NAO ESTABELECE (ver GravarCabecalho para o mesmo
    * criterio): tres ramos do legado escrevem em cursores que o Init dele NAO
    * abre - crSigTtCcd (observacao da contrapartida), crSigMvCpv (lancamento
    * PREVISTO, quando SigOpOpe.RealPrevs = 2) e crSigCdCmm (rateio de
    * comissao, quando SigCdOpe.EdComis eh 3 ou 4). No legado qualquer um
    * deles ABORTA a tela com erro de alias inexistente. Aqui o lote PARA com
    * a condicao NOMEADA, antes de gravar o grupo pela metade.
    *==========================================================================
    PROTECTED FUNCTION LancarMovimentacaoCliente(par_lVOper)
        LOCAL loc_lSucesso, loc_cAux, loc_cCcr, loc_cMd1, loc_cKey
        LOCAL loc_nValor, loc_cHist2, loc_cDopc

        loc_lSucesso = .T.
        loc_cAux     = THIS.this_cCursorAuxiliar
        loc_cCcr     = THIS.this_cCursorCcr

        *-- Origem
        IF NVL(cursor_4c_SigCdOpe.ctipos, 0) = 1
            THIS.this_cGrupoOrig = NVL(cursor_4c_SigCdOpe.Grupos, "")
            THIS.this_cContaOrig = NVL(cursor_4c_SigCdOpe.Contas, "")
        ELSE
            IF NVL(cursor_4c_SigCdOpe.COpers, 0) = 1
                THIS.this_cGrupoOrig = NVL(cursor_4c_SigMvCab.Grupoos, "")
                THIS.this_cContaOrig = NVL(cursor_4c_SigMvCab.Contaos, "")
            ELSE
                THIS.this_cGrupoOrig = NVL(cursor_4c_SigMvCab.Grupods, "")
                THIS.this_cContaOrig = NVL(cursor_4c_SigMvCab.Contads, "")
            ENDIF

            *-- LanFinMats = 2: o lancamento financeiro vai para a conta de
            *-- MATRIZ do cliente, quando ele tiver uma.
            IF NVL(cursor_4c_SigOpCdd.LanFinMats, 0) = 2 AND ;
               !EMPTY(THIS.this_cGrupoOrig + THIS.this_cContaOrig) AND ;
               !EMPTY(THIS.this_cContaOrig)

                IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                    THIS.this_cContaOrig, "grupomats, contamats")
                    IF !EMPTY(NVL(cursor_4c_Auxiliar.GrupoMats, "")) AND ;
                       !EMPTY(NVL(cursor_4c_Auxiliar.ContaMats, ""))
                        THIS.this_cGrupoOrig = NVL(cursor_4c_Auxiliar.GrupoMats, "")
                        THIS.this_cContaOrig = NVL(cursor_4c_Auxiliar.ContaMats, "")
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        *-- Destino
        IF NVL(cursor_4c_SigCdOpe.COpers, 0) = 1
            THIS.this_cGrupoDest = NVL(cursor_4c_SigMvCab.Grupods, "")
            THIS.this_cContaDest = NVL(cursor_4c_SigMvCab.Contads, "")
        ELSE
            THIS.this_cGrupoDest = NVL(cursor_4c_SigMvCab.Grupoos, "")
            THIS.this_cContaDest = NVL(cursor_4c_SigMvCab.Contaos, "")
        ENDIF

        IF NVL(cursor_4c_SigOpCdd.LanFinMats, 0) = 2 AND ;
           !EMPTY(THIS.this_cContaDest)
            IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                THIS.this_cContaDest, "grupomats, contamats")
                IF !EMPTY(NVL(cursor_4c_Auxiliar.GrupoMats, "")) AND ;
                   !EMPTY(NVL(cursor_4c_Auxiliar.ContaMats, ""))
                    THIS.this_cGrupoDest = NVL(cursor_4c_Auxiliar.GrupoMats, "")
                    THIS.this_cContaDest = NVL(cursor_4c_Auxiliar.ContaMats, "")
                ENDIF
            ENDIF
        ENDIF

        THIS.this_cRazaoCli = ""
        IF !EMPTY(THIS.this_cContaDest)
            IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                THIS.this_cContaDest, "Rclis")
                THIS.this_cRazaoCli = NVL(cursor_4c_Auxiliar.Rclis, "")
            ENDIF
        ENDIF

        THIS.this_cDepartamento = SPACE(10)

        *-- Contrapartida (movimentacao DopCs) com valor pendente
        IF !EMPTY(NVL(cursor_4c_SigCdOpe.Dopcs, "")) AND ;
           NVL(cursor_4c_SigOpFp.ValPends, 0) = 1

            loc_cDopc = ALLTRIM(NVL(cursor_4c_SigCdOpe.Dopcs, ""))
            THIS.this_nNumCont = fGerUniqueKey(loc_cDopc)
            THIS.this_cDopCont = NVL(cursor_4c_SigCdOpe.Dopcs, "")

            IF THIS.CursorQuery("SigCdUsu", loc_cAux, "Usuarios", ;
                                gc_4c_UsuarioLogado, "Deptos")
                THIS.this_cDepartamento = NVL(cursor_4c_Auxiliar.Deptos, "")
            ENDIF

            IF !EMPTY(NVL(cursor_4c_SigMvCab.Obses, ""))
                THIS.this_cMensagemErro = "A movimenta" + CHR(231) + CHR(227) + ;
                    "o de rebate tem observa" + CHR(231) + CHR(227) + "o e " + ;
                    "contrapartida pendente, o que exige gravar em " + ;
                    "SigTtCcd - tabela que esta tela n" + CHR(227) + "o abre, " + ;
                    "nem no sistema legado." + CHR(13) + ;
                    "Nenhum dado foi gravado."
                RETURN .F.
            ENDIF
        ELSE
            THIS.this_nNumCont = 0
            THIS.this_cDopCont = ""
        ENDIF

        *-- Historico principal
        SELECT (THIS.this_cCursorCab)
        THIS.this_cHistorico = THIS.MontarHistorico(THIS.this_cTitulo, ;
            NVL(cursor_4c_SigOpFp.FPags, ""), THIS.this_cRazaoCli)

        *-- Numero e identificador visual da operacao
        THIS.this_nNOper = fGerUniqueKey("SigMvCcr")
        IF par_lVOper
            THIS.this_cVOper = NVL(cursor_4c_SigMvCab.Emps, "") + ;
                               ALLTRIM(STR(THIS.this_nNOper, 9))
            THIS.this_nRetVOper = THIS.this_nNOper
        ELSE
            THIS.this_cVOper = NVL(cursor_4c_SigMvCab.Emps, "") + ;
                               THIS.this_cTipoEntrada + ;
                               ALLTRIM(STR(THIS.this_nNOper, 9))
            THIS.this_nRetVOper = 0
        ENDIF

        *-- Valor: o da parcela; nao havendo, o do cabecalho
        IF EMPTY(NVL(cursor_4c_SigMvPar.Valos, 0))
            loc_nValor = ABS(NVL(cursor_4c_SigMvCab.Valos, 0))
        ELSE
            loc_nValor = ABS(NVL(cursor_4c_SigMvPar.Valos, 0))
        ENDIF
        THIS.this_nValorCC = loc_nValor

        *-- Debito/credito. Trocos = 1 INVERTE o par - eh troco, nao
        *-- recebimento. COpers = 1 significa que a operacao credita a origem.
        IF NVL(cursor_4c_SigOpFp.Trocos, 0) = 1
            THIS.this_cOperContra  = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "C", "D")
            THIS.this_cOperDebCred = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "D", "C")
        ELSE
            THIS.this_cOperDebCred = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "C", "D")
            THIS.this_cOperContra  = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "D", "C")
        ENDIF

        *-- Grupo/conta de COBRANCA do cliente de origem
        THIS.this_cGrupoCob = ""
        THIS.this_cContaCob = ""
        THIS.this_cRazaoCli = ""

        IF !EMPTY(THIS.this_cContaOrig)
            IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                THIS.this_cContaOrig, ;
                                "Grupocobs, contacobs, Rclis")
                THIS.this_cGrupoCob = NVL(cursor_4c_Auxiliar.GrupoCobs, "")
                THIS.this_cContaCob = NVL(cursor_4c_Auxiliar.ContaCobs, "")
                THIS.this_cRazaoCli = NVL(cursor_4c_Auxiliar.Rclis, "")
            ENDIF
        ENDIF

        THIS.this_cGrupoTx = THIS.this_cGrupoDest
        THIS.this_cContaTx = THIS.this_cContaDest

        THIS.this_cHistorico2 = THIS.MontarHistorico2()

        THIS.this_cChaveCC = THIS.GerarChaveCC()

        THIS.this_cArqCcr    = THIS.this_cCursorCcr
        THIS.this_lLancaCC   = .F.
        THIS.this_nValorTaxa = 0

        *-- Parametros da movimentacao de contrapartida
        IF !THIS.CursorQuery("SigOpOpe", loc_cAux, "Dopes", ;
                             THIS.this_cDopCont, "RealPrevs,Opers")
            THIS.this_cMensagemErro = "Falha ao ler a movimenta" + CHR(231) + ;
                CHR(227) + "o de contrapartida." + CHR(13) + ;
                THIS.this_cMensagemErro
            RETURN .F.
        ENDIF

        THIS.this_cOperDope = NVL(cursor_4c_Auxiliar.Opers, "")

        IF THIS.this_nNumCont > 0
            IF NVL(cursor_4c_Auxiliar.RealPrevs, 0) = 2
                THIS.this_cMensagemErro = "A movimenta" + CHR(231) + CHR(227) + ;
                    "o de contrapartida [" + ALLTRIM(THIS.this_cDopCont) + ;
                    "] est" + CHR(225) + " cadastrada como PREVISTA " + ;
                    "(SigOpOpe.RealPrevs = 2), o que exige gravar em " + ;
                    "SigMvCpv - tabela que esta tela n" + CHR(227) + "o abre, " + ;
                    "nem no sistema legado." + CHR(13) + ;
                    "Nenhum dado foi gravado."
                RETURN .F.
            ENDIF
        ENDIF

        *-- Conta de transito: a de PAGAMENTOS quando a contrapartida eh
        *-- "CR" (contas a receber); a de RECEBIMENTOS no caso contrario.
        IF THIS.this_cOperDope = "CR"
            THIS.this_cGrupoTran = NVL(cursor_4c_SigCdPam.GrupoPags, "")
            THIS.this_cContaTran = NVL(cursor_4c_SigCdPam.ContaPags, "")
        ELSE
            THIS.this_cGrupoTran = NVL(cursor_4c_SigCdPam.GrupoRecs, "")
            THIS.this_cContaTran = NVL(cursor_4c_SigCdPam.ContaRecs, "")
        ENDIF

        IF INLIST(NVL(cursor_4c_SigCdOpe.EdComis, 0), 3, 4)
            THIS.this_lLancaCC = .T.
        ENDIF

        IF THIS.this_nNumCont > 0
            *-- Taxa da administradora de cartao descontada no lancamento
            IF NVL(cursor_4c_SigOpFp.Infos, "") = "T" AND ;
               !EMPTY(NVL(cursor_4c_SigOpFp.GrupoTs, "")) AND ;
               !EMPTY(NVL(cursor_4c_SigOpFp.ContaTs, "")) AND ;
               NVL(cursor_4c_SigOpFp.Desc2s, 0) > 0

                THIS.this_nValorTaxa = ;
                    ROUND(loc_nValor * NVL(cursor_4c_SigOpFp.Desc2s, 0) / 100, 2) * -1
            ELSE
                *-- Impostos retidos de NOTA DE SERVICO. crSigMvNfi esta
                *-- VAZIO neste motor (ver PrepararCursores), entao CodServs
                *-- vem em branco e este ramo nao entra - igual ao legado.
                IF !EMPTY(NVL(cursor_4c_SigMvNfi.CodServs, ""))
                    THIS.this_cMensagemErro = "A movimenta" + CHR(231) + ;
                        CHR(227) + "o de rebate chegou com c" + CHR(243) + ;
                        "digo de servi" + CHR(231) + "o em SigMvNfi, caminho " + ;
                        "que esta tela n" + CHR(227) + "o alimenta (o motor " + ;
                        "de rebate grava itens em SigMvItn, n" + CHR(227) + ;
                        "o nota de servi" + CHR(231) + "o)." + CHR(13) + ;
                        "Nenhum dado foi gravado."
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF

        IF NVL(cursor_4c_SigOpFp.AgCobs, 0) = 1
            THIS.this_cGrupoCob = NVL(cursor_4c_SigOpFp.GrupoDs, "")
            THIS.this_cContaCob = NVL(cursor_4c_SigOpFp.ContaDs, "")
        ENDIF

        THIS.this_cGrupoEmI = THIS.this_cGrupoDest
        THIS.this_cContaEmI = THIS.this_cContaDest

        *-- TpHists = 4 SOBREPOE o historico montado por MontarHistorico com
        *-- um texto proprio por tipo de informacao da forma de pagamento.
        IF NVL(cursor_4c_SigOpFp.TpHists, 0) = 4
            THIS.AplicarHistoricoTpHists4()
        ENDIF

        loc_cMd1 = THIS.ObterMoedaLancamento()

        *-- PERNA 1 - origem em grupos/contas, destino em sgrupos/scontas
        SELECT (THIS.this_cArqCcr)
        INSERT INTO (THIS.this_cArqCcr) ;
            (NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists, ;
             opers, sopers, moedas, cotacaos, valors, autos, grupos, contas, ;
             sgrupos, scontas, smoedas, scotacaos, svalors, Dopes, numes, ;
             valpags, dopcs, numcs, nfs, titulos, grupems, contems, grupages, ;
             contages, valliqs, dtemis, Hist2s, CidChaves, EmpDopNums, ;
             bContas, TitBans, ValOcurs, Jobs) ;
            VALUES ;
            (THIS.this_nNOper, THIS.this_cVOper, THIS.this_cDocumento, ;
             NVL(cursor_4c_SigMvCab.emps, ""), THIS.this_dDataContab, ;
             gc_4c_UsuarioLogado, THIS.this_tDataProc, ;
             IIF(EMPTY(NVL(cursor_4c_SigMvPar.Vencs, CTOT(""))), ;
                 THIS.this_dDataContab, NVL(cursor_4c_SigMvPar.Vencs, CTOT(""))), ;
             THIS.this_cHistorico, THIS.this_cOperDebCred, THIS.this_cOperContra, ;
             loc_cMd1, 1, loc_nValor, .T., ;
             IIF(THIS.this_lLancaCC, THIS.this_cGrupoTran, THIS.this_cGrupoOrig), ;
             IIF(THIS.this_lLancaCC, THIS.this_cContaTran, THIS.this_cContaOrig), ;
             THIS.this_cGrupoDest, THIS.this_cContaDest, loc_cMd1, 1, loc_nValor, ;
             NVL(cursor_4c_SigMvCab.Dopes, ""), NVL(cursor_4c_SigMvCab.numes, 0), ;
             NVL(cursor_4c_SigMvPar.VPags, 0), THIS.this_cDopCont, ;
             THIS.this_nNumCont, THIS.this_cNotaFiscal, ;
             ALLTRIM(THIS.this_cTitulo) + "/" + ALLTRIM(STR(THIS.this_nContaPar)), ;
             THIS.this_cGrupoOrig, THIS.this_cContaOrig, ;
             THIS.this_cGrupoCob, THIS.this_cContaCob, loc_nValor, ;
             NVL(cursor_4c_SigMvCab.DtEmis, CTOT("")), THIS.this_cHistorico2, ;
             THIS.this_cChaveCC, ;
             PADR(NVL(cursor_4c_SigMvCab.Emps, ""), 3) + ;
             PADR(ALLTRIM(NVL(cursor_4c_SigMvCab.Dopes, "")), 20) + ;
             STR(NVL(cursor_4c_SigMvCab.Numes, 0), 6), ;
             THIS.this_cDepartamento, THIS.this_cTitBan, THIS.this_nValorTaxa, ;
             NVL(cursor_4c_SigMvCab.Jobs, ""))

        THIS.NormalizarNaoNulos(THIS.this_cArqCcr, "SigMvCcr")
        THIS.AjustarChavesLancamento()
        THIS.this_nLancamentosCC = THIS.this_nLancamentosCC + 1

        *-- Perna de DESPESAS pela conta de entrega do cliente (CTipos = 2).
        *-- Scatter/Insert From Memvar duplica a linha e troca o par de contas
        *-- - transcrito assim porque eh a copia do lancamento inteiro, nao um
        *-- INSERT com colunas escolhidas.
        IF NVL(cursor_4c_SigCdOpe.CTipos, 0) = 2
            IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                THIS.this_cContaOrig, "GrupocEnts,ContacEnts")
                IF !EMPTY(NVL(cursor_4c_Auxiliar.GrupoCEnts, ""))

                    SELECT (loc_cCcr)
                    SCATTER MEMO MEMVAR
                    INSERT INTO (loc_cCcr) FROM MEMVAR

                    REPLACE Tipos   WITH "E", ;
                            Grupos  WITH NVL(cursor_4c_Auxiliar.GrupoCEnts, ""), ;
                            Contas  WITH IIF(EMPTY(NVL(cursor_4c_Auxiliar.ContaCEnts, "")), ;
                                             THIS.this_cContaOrig, ;
                                             NVL(cursor_4c_Auxiliar.ContaCEnts, "")), ;
                            SGrupos WITH THIS.this_cGrupoOrig, ;
                            SContas WITH THIS.this_cContaOrig, ;
                            GrupEms WITH THIS.this_cGrupoOrig, ;
                            ContEms WITH THIS.this_cContaOrig, ;
                            Opers   WITH m.Opers, ;
                            SOpers  WITH m.SOpers, ;
                            Nopers  WITH fGerUniqueKey("SigMvCcr"), ;
                            Autos   WITH .T. IN (loc_cCcr)

                    loc_cKey = DTOS(ConverterParaData(EVALUATE(loc_cCcr + ".Datas"))) + ;
                               TRANSFORM(fGerUniqueKey(DTOS(ConverterParaData(EVALUATE(loc_cCcr + ".Datas")))), ;
                                         "@L 999999") + THIS.this_cSigKey

                    REPLACE GruConMoes WITH Grupos + Contas + Moedas, ;
                            EmpDopNcs  WITH Emps + Dopcs + STR(Numcs, 6), ;
                            Pagos      WITH IIF(Valors = ValPags, "0", "1"), ;
                            DopoTps    WITH Dopcs + Opers + Tipos + Pagos, ;
                            cIdChaves  WITH loc_cKey IN (loc_cCcr)

                    = fRecalculaS(EVALUATE(loc_cCcr + ".Grupos"), ;
                                  EVALUATE(loc_cCcr + ".Contas"), ;
                                  EVALUATE(loc_cCcr + ".Datas"), ;
                                  EVALUATE(loc_cCcr + ".Moedas"), gnConnHandle)

                    THIS.this_nLancamentosCC = THIS.this_nLancamentosCC + 1
                ENDIF
            ENDIF
        ENDIF

        *-- Cobranca recalculada para a perna 2, agora pelo cliente de DESTINO
        THIS.this_cGrupoCob = ""
        THIS.this_cContaCob = ""

        IF !EMPTY(THIS.this_cContaDest)
            IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                THIS.this_cContaDest, "grupocobs, contacobs")
                THIS.this_cGrupoCob = NVL(cursor_4c_Auxiliar.GrupoCobs, "")
                THIS.this_cContaCob = NVL(cursor_4c_Auxiliar.ContaCobs, "")
            ENDIF
        ENDIF
        IF NVL(cursor_4c_SigOpFp.AgCobs, 0) = 1
            THIS.this_cGrupoCob = NVL(cursor_4c_SigOpFp.GrupoDs, "")
            THIS.this_cContaCob = NVL(cursor_4c_SigOpFp.ContaDs, "")
        ENDIF

        THIS.this_cChaveCC = THIS.GerarChaveCC()
        loc_cMd1           = THIS.ObterMoedaLancamento()

        *-- PERNA 2 - os MESMOS valores com origem e destino TROCADOS de
        *-- coluna (sgrupos/scontas recebem a origem, grupos/contas o destino).
        *-- O valpags aqui soma Abs(lnvTx): a taxa retida entra no valor pago.
        SELECT (THIS.this_cArqCcr)
        INSERT INTO (THIS.this_cArqCcr) ;
            (NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists, ;
             sopers, opers, smoedas, scotacaos, svalors, autos, sgrupos, scontas, ;
             grupos, contas, moedas, cotacaos, valors, Dopes, numes, valpags, ;
             dopcs, numcs, nfs, titulos, grupems, contems, grupages, contages, ;
             valliqs, dtemis, Hist2s, CidChaves, EmpDopNums, bContas, TitBans, ;
             ValOcurs, Jobs) ;
            VALUES ;
            (THIS.this_nNOper, THIS.this_cVOper, THIS.this_cDocumento, ;
             NVL(cursor_4c_SigMvCab.emps, ""), THIS.this_dDataContab, ;
             gc_4c_UsuarioLogado, THIS.this_tDataProc, ;
             IIF(EMPTY(NVL(cursor_4c_SigMvPar.Vencs, CTOT(""))), ;
                 THIS.this_dDataContab, NVL(cursor_4c_SigMvPar.Vencs, CTOT(""))), ;
             THIS.this_cHistorico, THIS.this_cOperDebCred, THIS.this_cOperContra, ;
             loc_cMd1, 1, loc_nValor, .T., ;
             IIF(THIS.this_lLancaCC, THIS.this_cGrupoTran, THIS.this_cGrupoOrig), ;
             IIF(THIS.this_lLancaCC, THIS.this_cContaTran, THIS.this_cContaOrig), ;
             THIS.this_cGrupoDest, THIS.this_cContaDest, loc_cMd1, 1, loc_nValor, ;
             NVL(cursor_4c_SigMvCab.Dopes, ""), NVL(cursor_4c_SigMvCab.numes, 0), ;
             NVL(cursor_4c_SigMvPar.VPags, 0) + ABS(THIS.this_nValorTaxa), ;
             THIS.this_cDopCont, THIS.this_nNumCont, THIS.this_cNotaFiscal, ;
             ALLTRIM(THIS.this_cTitulo) + "/" + ALLTRIM(STR(THIS.this_nContaPar)), ;
             THIS.this_cGrupoDest, THIS.this_cContaDest, ;
             THIS.this_cGrupoCob, THIS.this_cContaCob, loc_nValor, ;
             NVL(cursor_4c_SigMvCab.DtEmis, CTOT("")), THIS.this_cHistorico2, ;
             THIS.this_cChaveCC, ;
             PADR(NVL(cursor_4c_SigMvCab.Emps, ""), 3) + ;
             PADR(ALLTRIM(NVL(cursor_4c_SigMvCab.Dopes, "")), 20) + ;
             STR(NVL(cursor_4c_SigMvCab.Numes, 0), 6), ;
             THIS.this_cDepartamento, THIS.this_cTitBan, THIS.this_nValorTaxa, ;
             NVL(cursor_4c_SigMvCab.Jobs, ""))

        THIS.NormalizarNaoNulos(THIS.this_cArqCcr, "SigMvCcr")
        THIS.AjustarChavesLancamento()
        THIS.this_nLancamentosCC = THIS.this_nLancamentosCC + 1

        *-- A parcela guarda o numero da operacao de conta corrente
        SELECT (THIS.this_cCursorPar)
        REPLACE NOpers WITH THIS.this_nNOper, ;
                DtAlts WITH THIS.this_tDataProc IN (THIS.this_cCursorPar)

        *-- Rateio de comissao por moeda (crSigCdCmm). Ver a nota "CONTEXTO
        *-- QUE ESTE SCX NAO ESTABELECE" no cabecalho deste metodo.
        IF THIS.this_lLancaCC
            THIS.this_cMensagemErro = "A movimenta" + CHR(231) + CHR(227) + ;
                "o de rebate est" + CHR(225) + " configurada com " + ;
                "SigCdOpe.EdComis = " + ;
                ALLTRIM(STR(NVL(cursor_4c_SigCdOpe.EdComis, 0))) + ", que " + ;
                "exige o rateio de comiss" + CHR(227) + "o por moeda sobre " + ;
                "SigCdCmm - tabela que esta tela n" + CHR(227) + "o abre, " + ;
                "nem no sistema legado." + CHR(13) + ;
                "Nenhum dado foi gravado."
            RETURN .F.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarChaveCC - a chave unica do lancamento de conta corrente:
    *
    *     Dtos(ldDtContab) + Transform(fGerUniqueKey(Dtos(ldDtContab)),"@L 999999")
    *     + ThisForm.Sigkey
    *
    * Eh POSICIONAL (8 + 6 + 3 = 17 caracteres, em SigMvCcr.CidChaves char(20))
    * e o contador eh por DIA de contabilizacao - cada lancamento do mesmo dia
    * recebe o proximo numero. O legado remonta essa chave antes de CADA
    * insercao, e nao uma vez por parcela: duas pernas do mesmo lancamento tem
    * chaves DIFERENTES. Por isso este metodo existe e eh chamado em cada
    * ponto em que o legado recalcula _CidChave.
    *==========================================================================
    PROTECTED FUNCTION GerarChaveCC()
        LOCAL loc_cDtos

        loc_cDtos = DTOS(ConverterParaData(THIS.this_dDataContab))

        RETURN loc_cDtos + ;
               TRANSFORM(fGerUniqueKey(loc_cDtos), "@L 999999") + ;
               THIS.this_cSigKey
    ENDFUNC

    *==========================================================================
    * ObterMoedaLancamento - Iif(Empty(crSigOpFp.MoeFpgs), crSigCdOpe.CMoes,
    * crSigOpFp.MoeFpgs): a moeda da forma de pagamento prevalece; sem ela,
    * vale a moeda da operacao.
    *==========================================================================
    PROTECTED FUNCTION ObterMoedaLancamento()
        IF EMPTY(NVL(cursor_4c_SigOpFp.MoeFpgs, ""))
            RETURN NVL(cursor_4c_SigCdOpe.CMoes, "")
        ENDIF

        RETURN NVL(cursor_4c_SigOpFp.MoeFpgs, "")
    ENDFUNC

    *==========================================================================
    * MontarHistorico2 - o historico COMPLEMENTAR (Hist2s).
    *
    * Transcricao do "Do Case crSigCdOpe.tpHist2s" do legado, que aparece
    * IDENTICO nos blocos 1 e 2 do lancacontacorrente:
    *   1 = titulo, 2 = dados do cheque/cartao, 3 = razao do cliente,
    *   4 = conta de origem, 5 = observacao da movimentacao.
    *
    * No caso 3 o bloco 1 do legado usa a variavel lcRclis e o bloco 2 le
    * CrTmpCli.Rclis - nos dois o valor eh a razao do cliente de ORIGEM, que
    * acabou de ser lida para aquela variavel. Aqui vale a property
    * this_cRazaoCli nos dois, pelo mesmo motivo.
    *==========================================================================
    PROTECTED FUNCTION MontarHistorico2()
        LOCAL loc_cHist2

        loc_cHist2 = ALLTRIM(NVL(cursor_4c_SigCdOpe.Hist2s, ""))

        DO CASE
        CASE NVL(cursor_4c_SigCdOpe.tpHist2s, 0) = 1
            loc_cHist2 = loc_cHist2 + " " + THIS.this_cTitulo

        CASE NVL(cursor_4c_SigCdOpe.tpHist2s, 0) = 2
            IF NVL(cursor_4c_SigOpFp.Infos, "") = "C"
                loc_cHist2 = loc_cHist2 + " Ch:" + ;
                    NVL(cursor_4c_SigMvPar.Bancos, "") + "-" + ;
                    NVL(cursor_4c_SigMvPar.Agencias, "") + "-" + ;
                    NVL(cursor_4c_SigMvPar.Contas, "") + "-" + ;
                    NVL(cursor_4c_SigMvPar.numeros, "")
            ELSE
                IF NVL(cursor_4c_SigOpFp.Infos, "") = "T"
                    loc_cHist2 = loc_cHist2 + " Ct:" + ;
                        NVL(cursor_4c_SigMvPar.cnnsuparcs, "")
                ENDIF
            ENDIF

        CASE NVL(cursor_4c_SigCdOpe.tpHist2s, 0) = 3
            loc_cHist2 = loc_cHist2 + " " + ALLTRIM(THIS.this_cRazaoCli)

        CASE NVL(cursor_4c_SigCdOpe.tpHist2s, 0) = 4
            loc_cHist2 = loc_cHist2 + " " + ALLTRIM(THIS.this_cContaOrig)

        CASE NVL(cursor_4c_SigCdOpe.TpHist2s, 0) = 5
            loc_cHist2 = loc_cHist2 + " " + ;
                IIF(!ISNULL(cursor_4c_SigMvCab.Obses), ;
                    ALLTRIM(NVL(cursor_4c_SigMvCab.Obses, "")), "")
        ENDCASE

        RETURN loc_cHist2
    ENDFUNC

    *==========================================================================
    * AplicarHistoricoTpHists4 - quando a forma de pagamento tem TpHists = 4,
    * o historico (e o complementar) sao SOBRESCRITOS por um texto proprio de
    * cada tipo de informacao: C = cheque, D = duplicata, O = outros,
    * R = conta corrente, T = cartao, e um padrao para o resto.
    *
    * Isto roda DEPOIS de MontarHistorico/MontarHistorico2, descartando o que
    * eles produziram - eh a ordem do legado, nos dois blocos onde aparece.
    *==========================================================================
    PROTECTED PROCEDURE AplicarHistoricoTpHists4()
        LOCAL loc_cNotas

        loc_cNotas = NVL(cursor_4c_SigMvCab.Notas, "")

        DO CASE
        CASE NVL(cursor_4c_SigOpFp.Infos, "") = "C"
            THIS.this_cHistorico = loc_cNotas + " CHQ: " + ;
                NVL(cursor_4c_SigMvPar.Bancos, "") + "/" + ;
                NVL(cursor_4c_SigMvPar.Agencias, "") + "/" + ;
                NVL(cursor_4c_SigMvPar.Contas, "") + "/" + ;
                NVL(cursor_4c_SigMvPar.Numeros, "")
            THIS.this_cHistorico2 = "CPF: " + NVL(cursor_4c_SigMvPar.Cpfs, "")

        CASE NVL(cursor_4c_SigOpFp.Infos, "") = "D"
            THIS.this_cHistorico = loc_cNotas + " (" + ;
                ALLTRIM(STR(NVL(cursor_4c_SigMvPar.Parcs, 0), 2)) + "/" + ;
                ALLTRIM(STR(NVL(cursor_4c_SigMvPar.TParcs, 0), 2)) + ")"
            THIS.this_cHistorico2 = THIS.this_cRazaoCli

        CASE NVL(cursor_4c_SigOpFp.Infos, "") = "O"
            THIS.this_cHistorico  = loc_cNotas
            THIS.this_cHistorico2 = THIS.this_cRazaoCli

        CASE NVL(cursor_4c_SigOpFp.Infos, "") = "R"
            THIS.this_cHistorico  = loc_cNotas
            THIS.this_cHistorico2 = THIS.this_cRazaoCli

        CASE NVL(cursor_4c_SigOpFp.Infos, "") = "T"
            THIS.this_cHistorico = loc_cNotas + " - " + ;
                ALLTRIM(NVL(cursor_4c_SigMvPar.Outros, "")) + " - (" + ;
                ALLTRIM(STR(NVL(cursor_4c_SigMvPar.Parcs, 0), 2)) + "/" + ;
                ALLTRIM(STR(NVL(cursor_4c_SigMvPar.TParcs, 0), 2)) + ")"
            THIS.this_cHistorico2 = THIS.this_cRazaoCli

        OTHERWISE
            THIS.this_cHistorico  = loc_cNotas
            THIS.this_cHistorico2 = THIS.this_cRazaoCli
        ENDCASE

        RETURN
    ENDPROC

    *==========================================================================
    * AjustarChavesLancamento - as quatro colunas DERIVADAS que o legado
    * recalcula depois de CADA insercao em conta corrente:
    *
    *     gruconmoes = grupos + contas + moedas       (chave de saldo)
    *     EmpDopncs  = Emps + Dopcs + Str(Numcs,6)    (chave da contrapartida)
    *     Pagos      = '0' se Valors = ValPags, senao '1'
    *     DopoTps    = Dopcs + Opers + Tipos + Pagos
    *
    * Sao CONCATENACOES POSICIONAIS (regra #42): o padding das colunas faz
    * parte da chave, por isso nada aqui leva ALLTRIM.
    *
    * Em seguida, com _Numc > 0, o usuario que pagou vai para bGrupos, e o
    * saldo da conta entra na fila do recalculo (fRecalculaS em modo de
    * REGISTRO - o processamento roda depois do commit).
    *==========================================================================
    PROTECTED PROCEDURE AjustarChavesLancamento()
        LOCAL loc_cCcr

        loc_cCcr = THIS.this_cArqCcr

        SELECT (loc_cCcr)
        REPLACE gruconmoes WITH grupos + contas + moedas, ;
                EmpDopncs  WITH Emps + Dopcs + STR(Numcs, 6), ;
                Pagos      WITH IIF(Valors = valpags, "0", "1"), ;
                DopoTps    WITH Dopcs + Opers + Tipos + Pagos IN (loc_cCcr)

        IF loc_cCcr == THIS.this_cCursorCcr
            IF THIS.this_nNumCont > 0
                REPLACE bGrupos WITH NVL(cursor_4c_SigMvCab.UsuPagos, "") ;
                        IN (loc_cCcr)
            ENDIF

            = fRecalculaS(EVALUATE(loc_cCcr + ".Grupos"), ;
                          EVALUATE(loc_cCcr + ".Contas"), ;
                          EVALUATE(loc_cCcr + ".Datas"), ;
                          EVALUATE(loc_cCcr + ".Moedas"), gnConnHandle)
        ELSE
            *-- Ramo do lancamento PREVISTO (crSigMvCpv). Inalcancavel neste
            *-- motor - LancarMovimentacaoCliente ja para o lote quando
            *-- SigOpOpe.RealPrevs = 2 -, mantido porque eh o que o legado faz
            *-- e porque remove-lo esconderia que o previsto nasce liquidado
            *-- quando valor e ocorrencia se anulam.
            IF EVALUATE(loc_cCcr + ".Valors") + ;
               EVALUATE(loc_cCcr + ".valocurs") = 0
                REPLACE Pagos   WITH "1", ;
                        DopoTps WITH Dopcs + Opers + Tipos + Pagos IN (loc_cCcr)
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *==========================================================================
    * LancarClienteFormaPagto - bloco "Cliente X Forma de Pagamento".
    *
    * Quando a forma de pagamento tem grupo/conta de destino PROPRIOS, o valor
    * da parcela recebe um lancamento adicional entre a conta da movimentacao
    * e a conta da forma de pagamento (o "caminho do dinheiro": cliente ->
    * cartao/banco). Esse lancamento tem a contrapartida gravada por
    * FazerContra, nao por uma segunda perna escrita a mao.
    *
    * DIFERENCAS DESTE BLOCO EM RELACAO AO BLOCO 1, que NAO se uniformizam:
    *   - com ValPends = 1 a origem eh a conta de TRANSITO de SigCdPam (o
    *     valor esta pendente, ainda nao entrou na conta do cliente);
    *   - com OriDes = 1 e ValPends = 1 o par debito/credito eh decidido por
    *     "copers = 2", nao por "copers = 1" como em todo o resto;
    *   - o identificador visual usa lnRetVOper (nao _noper) no modo llVOper;
    *   - o Insert eh LITERAL em crSigMvCcr, nao em &_ArqMccr - previsto nunca
    *     passa por aqui;
    *   - a parcela so recebe NOpers quando OriDes NAO eh 1 nem 2.
    *==========================================================================
    PROTECTED FUNCTION LancarClienteFormaPagto(par_lVOper)
        LOCAL loc_cAux, loc_cCcr, loc_cMd1, loc_nValor

        loc_cAux = THIS.this_cCursorAuxiliar
        loc_cCcr = THIS.this_cCursorCcr

        THIS.this_cGrupoDest = NVL(cursor_4c_SigOpFp.Grupods, "")

        IF !EMPTY(NVL(cursor_4c_SigOpFp.ContaDs, ""))
            THIS.this_cContaDest = NVL(cursor_4c_SigOpFp.Contads, "")
        ELSE
            IF NVL(cursor_4c_SigOpFp.OriDes, 0) = 1
                THIS.this_cContaDest = NVL(cursor_4c_SigMvCab.ContaOs, "")
            ELSE
                THIS.this_cContaDest = NVL(cursor_4c_SigMvCab.ContaDs, "")
            ENDIF
        ENDIF

        IF NVL(cursor_4c_SigOpFp.ValPends, 0) = 1
            IF NVL(cursor_4c_SigCdOpe.copers, 0) = 1
                THIS.this_cGrupoOrig = NVL(cursor_4c_SigCdPam.gruporecs, "")
                THIS.this_cContaOrig = NVL(cursor_4c_SigCdPam.contarecs, "")
            ELSE
                THIS.this_cGrupoOrig = NVL(cursor_4c_SigCdPam.grupopags, "")
                THIS.this_cContaOrig = NVL(cursor_4c_SigCdPam.Contapags, "")
            ENDIF
        ELSE
            IF NVL(cursor_4c_SigCdOpe.COpers, 0) = 1
                THIS.this_cGrupoOrig = NVL(cursor_4c_SigMvCab.Grupods, "")
                THIS.this_cContaOrig = NVL(cursor_4c_SigMvCab.Contads, "")
            ELSE
                THIS.this_cGrupoOrig = NVL(cursor_4c_SigMvCab.Grupoos, "")
                THIS.this_cContaOrig = NVL(cursor_4c_SigMvCab.Contaos, "")
            ENDIF

            IF NVL(cursor_4c_SigOpCdd.LanFinMats, 0) = 2 AND ;
               !EMPTY(THIS.this_cContaOrig)
                IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                    THIS.this_cContaOrig, "grupomats, contamats")
                    IF !EMPTY(NVL(cursor_4c_Auxiliar.GrupoMats, "")) AND ;
                       !EMPTY(NVL(cursor_4c_Auxiliar.ContaMats, ""))
                        THIS.this_cGrupoOrig = NVL(cursor_4c_Auxiliar.GrupoMats, "")
                        THIS.this_cContaOrig = NVL(cursor_4c_Auxiliar.ContaMats, "")
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF !EMPTY(THIS.this_cContaOrig)
            IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", ;
                                THIS.this_cContaOrig, "rclis")
                THIS.this_cRazaoCli = NVL(cursor_4c_Auxiliar.Rclis, "")
            ENDIF
        ENDIF

        SELECT (THIS.this_cCursorCab)
        THIS.this_cHistorico = THIS.MontarHistorico(THIS.this_cTitulo, ;
            NVL(cursor_4c_SigOpFp.FPags, ""), THIS.this_cRazaoCli)

        THIS.this_nNOper = fGerUniqueKey("SigMvCcr")

        IF par_lVOper
            THIS.this_cVOper = NVL(cursor_4c_SigMvCab.Emps, "") + ;
                               ALLTRIM(STR(THIS.this_nRetVOper, 9))
        ELSE
            THIS.this_cVOper = NVL(cursor_4c_SigMvCab.Emps, "") + ;
                               THIS.this_cTipoEntrada + ;
                               ALLTRIM(STR(THIS.this_nNOper, 9))
        ENDIF

        loc_nValor         = ABS(NVL(cursor_4c_SigMvPar.Valos, 0))
        THIS.this_nValorCC = loc_nValor

        IF NVL(cursor_4c_SigOpFp.Trocos, 0) = 1
            THIS.this_cOperContra  = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "C", "D")
            THIS.this_cOperDebCred = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "D", "C")
        ELSE
            IF NVL(cursor_4c_SigOpFp.OriDes, 0) = 1 AND ;
               NVL(cursor_4c_SigOpFp.ValPends, 0) = 1
                THIS.this_cOperDebCred = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 2, "C", "D")
                THIS.this_cOperContra  = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 2, "D", "C")
            ELSE
                THIS.this_cOperDebCred = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "C", "D")
                THIS.this_cOperContra  = IIF(NVL(cursor_4c_SigCdOpe.copers, 0) = 1, "D", "C")
            ENDIF
        ENDIF

        THIS.this_cHistorico2 = THIS.MontarHistorico2()

        IF NVL(cursor_4c_SigOpFp.TpHists, 0) = 4
            THIS.AplicarHistoricoTpHists4()
        ENDIF

        THIS.this_cChaveCC = THIS.GerarChaveCC()
        loc_cMd1           = THIS.ObterMoedaLancamento()

        SELECT (loc_cCcr)
        INSERT INTO (loc_cCcr) ;
            (NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists, ;
             opers, sopers, moedas, cotacaos, valors, autos, grupos, contas, ;
             sgrupos, scontas, smoedas, scotacaos, svalors, Dopes, numes, ;
             valpags, Hist2s, CidChaves, EmpDopNums, Jobs) ;
            VALUES ;
            (THIS.this_nNOper, THIS.this_cVOper, THIS.this_cDocumento, ;
             NVL(cursor_4c_SigMvCab.emps, ""), THIS.this_dDataContab, ;
             gc_4c_UsuarioLogado, THIS.this_tDataProc, ;
             NVL(cursor_4c_SigMvPar.Vencs, CTOT("")), ;
             THIS.this_cHistorico, THIS.this_cOperDebCred, THIS.this_cOperContra, ;
             loc_cMd1, 1, loc_nValor, .T., ;
             THIS.this_cGrupoOrig, THIS.this_cContaOrig, ;
             THIS.this_cGrupoDest, THIS.this_cContaDest, ;
             loc_cMd1, 1, loc_nValor, ;
             NVL(cursor_4c_SigMvCab.Dopes, ""), NVL(cursor_4c_SigMvCab.numes, 0), ;
             NVL(cursor_4c_SigMvPar.VPags, 0), THIS.this_cHistorico2, ;
             THIS.this_cChaveCC, ;
             PADR(NVL(cursor_4c_SigMvCab.Emps, ""), 3) + ;
             PADR(ALLTRIM(NVL(cursor_4c_SigMvCab.Dopes, "")), 20) + ;
             STR(NVL(cursor_4c_SigMvCab.Numes, 0), 6), ;
             NVL(cursor_4c_SigMvCab.Jobs, ""))

        THIS.NormalizarNaoNulos(loc_cCcr, "SigMvCcr")

        REPLACE gruconmoes WITH grupos + contas + moedas, ;
                EmpDopncs  WITH Emps + Dopcs + STR(Numcs, 6), ;
                Pagos      WITH IIF(Valors = valpags, "0", "1"), ;
                DopoTps    WITH Dopcs + Opers + Tipos + Pagos IN (loc_cCcr)

        = fRecalculaS(EVALUATE(loc_cCcr + ".Grupos"), ;
                      EVALUATE(loc_cCcr + ".Contas"), ;
                      EVALUATE(loc_cCcr + ".Datas"), ;
                      EVALUATE(loc_cCcr + ".Moedas"), gnConnHandle)

        THIS.this_nLancamentosCC = THIS.this_nLancamentosCC + 1

        *-- Contrapartida (ThisForm.FazContra do legado, sem argumento)
        THIS.FazerContra()

        SELECT (THIS.this_cCursorPar)
        IF !INLIST(NVL(cursor_4c_SigOpFp.OriDes, 0), 1, 2)
            REPLACE NOpers WITH THIS.this_nNOper, ;
                    DtAlts WITH THIS.this_tDataProc IN (THIS.this_cCursorPar)
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * LancarTaxaCartao - bloco "Taxas de Cartao de Credito".
    *
    * Com forma de pagamento de CARTAO (Infos = "T") que tem grupo/conta de
    * taxa e percentual Desc2s, a taxa da administradora eh lancada como
    * OCORRENCIA (SigOpCoc) e as DUAS pernas correspondentes vao para a conta
    * corrente, com Tipos = "O".
    *
    * A ocorrencia tem de estar cadastrada em SIGOPOCO para o par
    * grupo/conta de taxa com a operacao INVERSA a da contrapartida; nao
    * estando, o legado avisa e aborta - transcrito.
    *
    * lnvTx = Round(lnValor * Desc2s / 100, 2) * crSigMvPar.Cotfpgs: a taxa eh
    * percentual sobre o valor do lancamento e eh CONVERTIDA pela cotacao da
    * forma de pagamento. NAO se "simplifica" o fator de cotacao (regra #17).
    *
    * O "If lnvTx = 0 -> Loop" dentro do laco das duas pernas eh do legado:
    * taxa zerada nao gera lancamento, mas a ocorrencia em SigOpCoc JA foI
    * gravada antes do laco.
    *==========================================================================
    PROTECTED FUNCTION LancarTaxaCartao(par_lVOper)
        LOCAL loc_cSQL, loc_cAux, loc_cCcr, loc_cCoc, loc_cMd1
        LOCAL loc_nValor, loc_nVTx, loc_nCont
        LOCAL loc_cGOri, loc_cCOri, loc_cGDes, loc_cCDes, loc_cOdc, loc_cSdc
        LOCAL loc_cGPem, loc_cCPem

        loc_cAux   = THIS.this_cCursorAuxiliar
        loc_cCcr   = THIS.this_cArqCcr
        loc_cCoc   = THIS.this_cCursorCoc
        loc_nValor = THIS.this_nValorCC

        loc_cSQL = "Select * From SIGOPOCO Where Grupos = " + ;
                   EscaparSQL(ALLTRIM(NVL(cursor_4c_SigOpFp.GrupoTs, ""))) + ;
                   " And Contas = " + ;
                   EscaparSQL(ALLTRIM(NVL(cursor_4c_SigOpFp.ContaTs, ""))) + ;
                   IIF(THIS.this_cOperDope = "CR", " And Opers = 'DB' ", ;
                                                   " And Opers = 'CR'")

        IF THIS.ExecutarConsulta(loc_cSQL, loc_cAux) < 1
            THIS.this_cMensagemErro = "Falha ao ler a ocorr" + CHR(234) + ;
                "ncia da taxa de cart" + CHR(227) + "o." + CHR(13) + ;
                THIS.this_cMensagemErro
            RETURN .F.
        ENDIF

        IF RECCOUNT(loc_cAux) = 0
            THIS.this_cMensagemErro = "Ocorrencia n" + CHR(227) + ;
                "o Cadastrada para Taxa de Cart" + CHR(227) + "o da Condi" + ;
                CHR(231) + CHR(227) + "o de Pagamento " + ;
                ALLTRIM(NVL(cursor_4c_SigOpFp.Fpags, ""))
            RETURN .F.
        ENDIF

        THIS.this_cOperContra  = NVL(cursor_4c_Auxiliar.Opers, "")
        THIS.this_cOperDebCred = IIF(THIS.this_cOperContra = "DB", "CR", "DB")

        loc_nVTx = ROUND(loc_nValor * NVL(cursor_4c_SigOpFp.Desc2s, 0) / 100, 2) * ;
                   NVL(cursor_4c_SigMvPar.Cotfpgs, 0)
        THIS.this_nValorTaxa = loc_nVTx

        THIS.this_nNOper = fGerUniqueKey("SigMvCcr")

        SELECT (loc_cCoc)
        INSERT INTO (loc_cCoc) ;
            (Emps, Dopcs, Dataos, Notitulos, Moedas, Cotacaos, EmpDopNcs, ;
             CidChaves, Nopers, Valors, Opers, Codigos, ValConvs, Autos) ;
            VALUES ;
            (NVL(cursor_4c_SigMvCab.Emps, ""), THIS.this_cDopCont, DATE(), ;
             THIS.this_nNumCont, NVL(cursor_4c_SigMvPar.MoeFpgs, ""), ;
             NVL(cursor_4c_SigMvPar.CotFpgs, 0), ;
             PADR(NVL(cursor_4c_SigMvCab.Emps, ""), 3) + ;
             PADR(ALLTRIM(THIS.this_cDopCont), 20) + ;
             STR(THIS.this_nNumCont, 6), ;
             fUniqueIds(), THIS.this_nNOper, loc_nVTx, ;
             NVL(cursor_4c_Auxiliar.Opers, ""), ;
             NVL(cursor_4c_Auxiliar.Codigos, ""), ABS(loc_nVTx), .T.)

        THIS.NormalizarNaoNulos(loc_cCoc, "SigOpCoc")

        THIS.this_cHistorico = ALLTRIM(NVL(cursor_4c_Auxiliar.Descrs, "")) + "-" + ;
            ALLTRIM(NVL(EVALUATE(loc_cCoc + ".codigos"), "")) + "-" + ;
            THIS.this_cTitulo

        FOR loc_nCont = 1 TO 2

            loc_cGOri = IIF(loc_nCont = 1, NVL(cursor_4c_SigOpFp.GrupoTs, ""), ;
                                           THIS.this_cGrupoTx)
            loc_cCOri = IIF(loc_nCont = 1, NVL(cursor_4c_SigOpFp.ContaTs, ""), ;
                                           THIS.this_cContaTx)
            loc_cGDes = IIF(loc_nCont = 1, THIS.this_cGrupoTx, ;
                                           NVL(cursor_4c_SigOpFp.GrupoTs, ""))
            loc_cCDes = IIF(loc_nCont = 1, THIS.this_cContaTx, ;
                                           NVL(cursor_4c_SigOpFp.ContaTs, ""))
            loc_cOdc  = IIF(loc_nCont = 1, THIS.this_cOperDebCred, ;
                                           THIS.this_cOperContra)
            loc_cSdc  = IIF(loc_nCont = 1, THIS.this_cOperContra, ;
                                           THIS.this_cOperDebCred)
            loc_cGPem = " "
            loc_cCPem = " "

            IF par_lVOper
                THIS.this_cVOper = NVL(cursor_4c_SigMvCab.Emps, "") + ;
                                   ALLTRIM(STR(THIS.this_nNOper, 9))
            ELSE
                THIS.this_cVOper = NVL(cursor_4c_SigMvCab.Emps, "") + ;
                                   THIS.this_cTipoEntrada + ;
                                   ALLTRIM(STR(THIS.this_nNOper, 9))
            ENDIF

            IF loc_nVTx = 0
                LOOP
            ENDIF

            THIS.this_cChaveCC = THIS.GerarChaveCC()
            loc_cMd1           = THIS.ObterMoedaLancamento()

            SELECT (loc_cCcr)
            INSERT INTO (loc_cCcr) ;
                (NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, ;
                 hists, opers, sopers, moedas, cotacaos, valors, autos, grupos, ;
                 contas, sgrupos, scontas, smoedas, scotacaos, svalors, Dopes, ;
                 numes, valpags, dopcs, numcs, nfs, titulos, grupems, contems, ;
                 grupages, contages, valliqs, dtemis, Hist2s, CidChaves, ;
                 EmpDopNums, bContas, TitBans, Tipos, Jobs) ;
                VALUES ;
                (THIS.this_nNOper, THIS.this_cVOper, THIS.this_cDocumento, ;
                 NVL(cursor_4c_SigMvCab.emps, ""), THIS.this_dDataContab, ;
                 gc_4c_UsuarioLogado, THIS.this_tDataProc, ;
                 NVL(cursor_4c_SigMvPar.Vencs, CTOT("")), ;
                 THIS.this_cHistorico, loc_cOdc, loc_cSdc, loc_cMd1, 1, ;
                 loc_nVTx, .T., loc_cGOri, loc_cCOri, loc_cGDes, loc_cCDes, ;
                 loc_cMd1, 1, loc_nVTx, ;
                 NVL(cursor_4c_SigMvCab.Dopes, ""), ;
                 NVL(cursor_4c_SigMvCab.numes, 0), loc_nVTx, ;
                 THIS.this_cDopCont, THIS.this_nNumCont, THIS.this_cNotaFiscal, ;
                 ALLTRIM(THIS.this_cTitulo) + "/" + ;
                 ALLTRIM(STR(THIS.this_nContaPar)), ;
                 loc_cGPem, loc_cCPem, THIS.this_cGrupoCob, THIS.this_cContaCob, ;
                 0, NVL(cursor_4c_SigMvCab.DtEmis, CTOT("")), ;
                 THIS.this_cHistorico2, THIS.this_cChaveCC, ;
                 PADR(NVL(cursor_4c_SigMvCab.Emps, ""), 3) + ;
                 PADR(ALLTRIM(NVL(cursor_4c_SigMvCab.Dopes, "")), 20) + ;
                 STR(NVL(cursor_4c_SigMvCab.Numes, 0), 6), ;
                 THIS.this_cDepartamento, THIS.this_cTitBan, "O", ;
                 NVL(cursor_4c_SigMvCab.Jobs, ""))

            THIS.NormalizarNaoNulos(loc_cCcr, "SigMvCcr")
            THIS.AjustarChavesLancamento()
            THIS.this_nLancamentosCC = THIS.this_nLancamentosCC + 1
        ENDFOR

        SELECT (THIS.this_cCursorPar)
        REPLACE VPags    WITH loc_nVTx, ;
                ValoCurs WITH loc_nVTx, ;
                Pagos    WITH IIF(Valos = Vpags, "0", "1") ;
                IN (THIS.this_cCursorPar)

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * FazerContra - a CONTRAPARTIDA de um lancamento de conta corrente.
    *
    * Traducao da PROCEDURE fazcontra legada: le o registro CORRENTE do cursor
    * de conta corrente e insere um NOVO registro com os dois lados trocados
    * de coluna - opers <-> sopers, grupos <-> sgrupos, contas <-> scontas,
    * moedas <-> smoedas, cotacaos <-> scotacaos, valors <-> svalors. Eh isso
    * que fecha a partida dobrada.
    *
    * Os parametros do legado (vTipo, pArquivo) sao preservados: a chamada
    * deste form eh "ThisForm.FazContra" sem argumento, entao vTipo vem .F. e
    * Tipos sai como " " - PCOUNT() separa "nao passou" de "passou .F.",
    * porque em VFP9 parametro omitido chega como .F. logico.
    *==========================================================================
    PROTECTED FUNCTION FazerContra(par_lTipo, par_cArquivo)
        LOCAL loc_cCcr, loc_lTipo, loc_cTipo, loc_cChave

        loc_cCcr = THIS.this_cCursorCcr
        IF PCOUNT() >= 2 AND VARTYPE(par_cArquivo) = "C"
            loc_cCcr = par_cArquivo
        ENDIF

        loc_lTipo = (PCOUNT() >= 1 AND VARTYPE(par_lTipo) = "L" AND par_lTipo)

        SELECT (loc_cCcr)

        loc_cTipo = IIF(loc_lTipo, NVL(EVALUATE(loc_cCcr + ".Tipos"), ""), " ")

        loc_cChave = DTOS(ConverterParaData(EVALUATE(loc_cCcr + ".datas"))) + ;
                     TRANSFORM(fGerUniqueKey(DTOS(ConverterParaData( ;
                         EVALUATE(loc_cCcr + ".datas")))), "@L 999999") + ;
                     THIS.this_cSigKey

        INSERT INTO (loc_cCcr) ;
            (VOpers, NOpers, NLancs, VLancs, Opers, Grupos, Contas, Moedas, ;
             Cotacaos, Valors, Emps, Datas, usualts, datalts, sgrupos, scontas, ;
             smoedas, scotacaos, svalors, sopers, autos, hists, Dopes, numes, ;
             valpags, vencs, dopcs, numcs, nfs, titulos, grupems, contems, ;
             grupages, contages, valliqs, CidChaves, Tipos, Hist2s, Jobs) ;
            VALUES ;
            (EVALUATE(loc_cCcr + ".vopers"), EVALUATE(loc_cCcr + ".nopers"), ;
             EVALUATE(loc_cCcr + ".nlancs"), EVALUATE(loc_cCcr + ".vlancs"), ;
             EVALUATE(loc_cCcr + ".sopers"), EVALUATE(loc_cCcr + ".sgrupos"), ;
             EVALUATE(loc_cCcr + ".scontas"), EVALUATE(loc_cCcr + ".smoedas"), ;
             EVALUATE(loc_cCcr + ".scotacaos"), EVALUATE(loc_cCcr + ".svalors"), ;
             EVALUATE(loc_cCcr + ".emps"), EVALUATE(loc_cCcr + ".datas"), ;
             gc_4c_UsuarioLogado, EVALUATE(loc_cCcr + ".datalts"), ;
             EVALUATE(loc_cCcr + ".grupos"), EVALUATE(loc_cCcr + ".contas"), ;
             EVALUATE(loc_cCcr + ".moedas"), EVALUATE(loc_cCcr + ".cotacaos"), ;
             EVALUATE(loc_cCcr + ".valors"), EVALUATE(loc_cCcr + ".opers"), ;
             .T., EVALUATE(loc_cCcr + ".hists"), EVALUATE(loc_cCcr + ".Dopes"), ;
             EVALUATE(loc_cCcr + ".numes"), EVALUATE(loc_cCcr + ".valpags"), ;
             EVALUATE(loc_cCcr + ".vencs"), EVALUATE(loc_cCcr + ".dopcs"), ;
             EVALUATE(loc_cCcr + ".numcs"), EVALUATE(loc_cCcr + ".nfs"), ;
             EVALUATE(loc_cCcr + ".titulos"), EVALUATE(loc_cCcr + ".grupems"), ;
             EVALUATE(loc_cCcr + ".contems"), EVALUATE(loc_cCcr + ".grupages"), ;
             EVALUATE(loc_cCcr + ".contages"), EVALUATE(loc_cCcr + ".valliqs"), ;
             loc_cChave, loc_cTipo, EVALUATE(loc_cCcr + ".Hist2s"), ;
             EVALUATE(loc_cCcr + ".Jobs"))

        THIS.NormalizarNaoNulos(loc_cCcr, "SigMvCcr")

        REPLACE gruconmoes WITH grupos + contas + moedas, ;
                empdopnums WITH emps + dopes + STR(numes, 6), ;
                empdopncs  WITH emps + dopcs + STR(numcs, 6), ;
                Pagos      WITH IIF(Valors = valpags, "0", "1"), ;
                DopoTps    WITH Dopcs + Opers + Tipos + Pagos IN (loc_cCcr)

        IF loc_cCcr == THIS.this_cCursorCcr
            = fRecalculaS(EVALUATE(loc_cCcr + ".Grupos"), ;
                          EVALUATE(loc_cCcr + ".Contas"), ;
                          EVALUATE(loc_cCcr + ".Datas"), ;
                          EVALUATE(loc_cCcr + ".Moedas"), gnConnHandle)
        ENDIF

        THIS.this_nLancamentosCC = THIS.this_nLancamentosCC + 1

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * MontarHistorico - o historico do lancamento (crSigCdOpe.TpHists).
    *
    * Traducao da PROCEDURE montahists legada. O prefixo fixo crSigCdOpe.Hists
    * sempre entra; depois, conforme TpHists:
    *   1 = nota fiscal ("SEM DOCUMENTO" quando vazia)
    *   2 = titulo + "/" + numero da parcela corrente
    *   3 = numero da movimentacao mascarado (fGerMascara)
    *   5 = movimentacao detalhada (Dopes + numero + forma de pagamento + cliente)
    *   6 = razao e codigo da conta (origem ou destino, conforme Origems)
    * TpHists = 4 nao tem caso aqui: ele eh tratado DEPOIS, sobrescrevendo o
    * historico (ver AplicarHistoricoTpHists4).
    *
    * Com TpHists = 5 e MultEmps ligado, o codigo da empresa entra ANTES do
    * resto - transcrito na mesma posicao.
    *
    * Os campos sem alias no legado (Notas, Numes, Dopes, Emps) resolvem para
    * crSigMvCab, que eh o cursor SELECIONADO pelo chamador; aqui vem
    * qualificados, para nao depender da area de trabalho corrente.
    *==========================================================================
    PROTECTED FUNCTION MontarHistorico(par_cTit, par_cFpg, par_cCli)
        LOCAL loc_cHis, loc_cTit, loc_cFpg, loc_cCli, loc_cCta, loc_cAux

        *-- O legado escreve "lcTit = Iif(Type([pTit])=[C], pTit, Titulos)".
        *-- Esse "Titulos" sem alias NAO TEM REFERENTE aqui: a area corrente no
        *-- momento da chamada eh crSigMvCab, e SigMvCab nao tem coluna
        *-- Titulos (ela eh de SigMvCcr - conferido em docs/schema.sql). No
        *-- legado o ramo nunca eh alcancado, porque as duas chamadas deste
        *-- form passam _Titulo, que eh CHARACTER; alcancado, estouraria
        *-- "Variable TITULOS is not found". Transcrever a leitura inexistente
        *-- so transportaria esse erro latente, entao o fallback fica vazio -
        *-- com o par_cTit sempre informado, o resultado eh identico.
        loc_cTit = IIF(VARTYPE(par_cTit) = "C", par_cTit, "")
        loc_cFpg = IIF(VARTYPE(par_cFpg) = "C", par_cFpg, "")
        loc_cCli = IIF(VARTYPE(par_cCli) = "C", par_cCli, "")
        loc_cAux = THIS.this_cCursorAuxiliar

        loc_cHis = ""
        IF !EMPTY(NVL(cursor_4c_SigCdOpe.Hists, ""))
            loc_cHis = loc_cHis + ALLTRIM(NVL(cursor_4c_SigCdOpe.Hists, "")) + " "
        ENDIF

        IF NVL(cursor_4c_SigCdOpe.TpHists, 0) = 5 AND THIS.this_lMultEmps
            loc_cHis = loc_cHis + ALLTRIM(NVL(cursor_4c_SigMvCab.Emps, "")) + " "
        ENDIF

        DO CASE
        CASE NVL(cursor_4c_SigCdOpe.TpHists, 0) = 1
            loc_cHis = loc_cHis + ;
                IIF(EMPTY(NVL(cursor_4c_SigMvCab.Notas, "")), "SEM DOCUMENTO", ;
                    ALLTRIM(NVL(cursor_4c_SigMvCab.Notas, "")))

        CASE NVL(cursor_4c_SigCdOpe.TpHists, 0) = 2
            loc_cHis = loc_cHis + ;
                IIF(EMPTY(loc_cTit), "SEM DOCUMENTO", ALLTRIM(loc_cTit)) + ;
                "/" + ALLTRIM(STR(THIS.this_nContaPar))

        CASE NVL(cursor_4c_SigCdOpe.TpHists, 0) = 3
            loc_cHis = loc_cHis + ;
                fGerMascara(NVL(cursor_4c_SigMvCab.Numes, 0))

        CASE NVL(cursor_4c_SigCdOpe.TpHists, 0) = 5
            loc_cHis = loc_cHis + ;
                ALLTRIM(NVL(cursor_4c_SigMvCab.Dopes, "")) + " " + ;
                ALLTRIM(fGerMascara(NVL(cursor_4c_SigMvCab.Numes, 0))) + " " + ;
                IIF(EMPTY(loc_cFpg), "", ;
                    "(" + ALLTRIM(NVL(cursor_4c_SigOpFp.FPags, "")) + ") ") + ;
                ALLTRIM(loc_cCli)

        CASE NVL(cursor_4c_SigCdOpe.TpHists, 0) = 6
            IF NVL(cursor_4c_SigCdOpe.Origems, 0) = 1
                loc_cCta = NVL(cursor_4c_SigMvCab.ContaOs, "")
            ELSE
                loc_cCta = NVL(cursor_4c_SigMvCab.ContaDs, "")
            ENDIF

            IF THIS.CursorQuery("SigCdCli", loc_cAux, "Iclis", loc_cCta, ;
                                "IClis, RClis")
                loc_cHis = loc_cHis + ;
                    ALLTRIM(NVL(cursor_4c_Auxiliar.RClis, "")) + " (" + ;
                    ALLTRIM(NVL(cursor_4c_Auxiliar.IClis, "")) + ")"
            ENDIF
        ENDCASE

        RETURN loc_cHis
    ENDFUNC

ENDDEFINE


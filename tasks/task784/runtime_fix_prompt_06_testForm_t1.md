# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-13 06:16:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-13 06:16:30] [INFO] Config FPW: (nao fornecido)
[2026-11-13 06:16:30] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 06:16:30] [INFO] Timeout: 300 segundos
[2026-11-13 06:16:30] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvlviczh.prg
[2026-11-13 06:16:31] [INFO] Conteudo do wrapper:
[2026-11-13 06:16:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpPdt', 'C:\4c\tasks\task784\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpPdt', 'C:\4c\tasks\task784\logs\06_testForm.log'
QUIT

[2026-11-13 06:16:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvlviczh.prg
[2026-11-13 06:16:32] [INFO] VFP output esperado em: C:\4c\tasks\task784\vfp_output.txt
[2026-11-13 06:16:32] [INFO] Executando Visual FoxPro 9...
[2026-11-13 06:16:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvlviczh.prg
[2026-11-13 06:16:32] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvlviczh.prg
[2026-11-13 06:16:32] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpPdt
Inicio: 13/11/2026 06:16:33

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 13/11/2026 06:18:39
Duracao: 126 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-13 06:18:39] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-13 06:18:40] [INFO] VFP9 finalizado em 127.9699111 segundos
[2026-11-13 06:18:40] [INFO] Exit Code: 
[2026-11-13 06:18:40] [INFO] 
[2026-11-13 06:18:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-13 06:18:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvlviczh.prg
[2026-11-13 06:18:40] [INFO] 
[2026-11-13 06:18:41] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-13 06:18:41] [INFO] * Auto-generated wrapper for parameters
[2026-11-13 06:18:41] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 06:18:41] [INFO] * Parameters: 'FormSigOpPdt', 'C:\4c\tasks\task784\logs\06_testForm.log'
[2026-11-13 06:18:42] [INFO] 
[2026-11-13 06:18:42] [INFO] * Anti-dialog protections for unattended execution
[2026-11-13 06:18:42] [INFO] SET SAFETY OFF
[2026-11-13 06:18:42] [INFO] SET RESOURCE OFF
[2026-11-13 06:18:42] [INFO] SET TALK OFF
[2026-11-13 06:18:43] [INFO] SET NOTIFY OFF
[2026-11-13 06:18:43] [INFO] SYS(2335, 0)
[2026-11-13 06:18:43] [INFO] 
[2026-11-13 06:18:44] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpPdt', 'C:\4c\tasks\task784\logs\06_testForm.log'
[2026-11-13 06:18:44] [INFO] QUIT
[2026-11-13 06:18:44] [INFO] 
[2026-11-13 06:18:44] [INFO] === Fim do Wrapper.prg ===
[2026-11-13 06:18:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPdt.prg):
*==============================================================================
* FORMSIGOPPDT.PRG
* Form de consulta das operacoes em aberto (SigOpPdt)
* Migracao de SIGOPPDT.SCX (task784)
*
* Form OPERACIONAL de layout proprio: o objeto raiz do legado eh "form"
* generico (nao frmcadastro), DataSession = 2 (privada na CLASSE), WindowType
* = 1 (dialogo MODAL - Show() sempre bloqueia), ControlBox = .F. + Closable =
* .F. + TitleBar = 0 - sem X e sem barra de titulo. Nao existe PageFrame nem
* Page1=Lista/Page2=Dados: a tela eh um unico painel com o cabecalho
* (cntSombra), duas molduras decorativas (Shape1/Shape2), uma grade de 8
* colunas (Grade: seleciona/empresa/operacao/codigo/data/Grupo=Origem/
* Conta=Destino/Column8=Valor) exibindo as pendencias do documento corrente,
* um campo de busca por codigo (Get_Procura) e tres botoes standalone
* (SelTudo "Seleciona tudo", apaga "Desmarca tudo", ok "\<Ok") - ver
* tasks\task784\layout.json e mapeamento.json.
*
* Aberto pelo form PAI de movimentacao (SigMvCab) - "Lparameters pForm,
* pData, pCnx" no Init legado (ver comportamento.json): pForm = form pai
* (ThisForm.ParentForm), pData = DataSessionId do pai, pCnx = poDataMgr
* (conexao do framework legado, sem equivalente nesta arquitetura -
* gnConnHandle eh compartilhado via config.prg). O legado faz "Set
* Datasession To pData" logo no Init, ANTES de montar qualquer cursor -
* sem isso os cursores crSigMvCab/crLclMvItn/TmpOperacao do form pai
* ficariam invisiveis para este dialogo (DataSession privada isolada).
* Transcrito fielmente: SET DATASESSION TO (par_nDataSessionPai) dentro do
* Init, ANTES de DODEFAULT() (que dispara InicializarForm) - mesmo padrao
* de Formsigopped.prg/Formsigoppei.prg.
*
* this_oFormPai equivale a property customizada "parentform" do legado
* (ThisForm.ParentForm = pForm no Init; usado por Marca/Desmarca para ler
* crSigMvCab/crLclMvItn/TmpOperacao do pai e por ok.Click/SelTudo.Click/
* apaga.Click para reabilitar o pai e devolver o controle - fases
* seguintes).
*
* Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
*
* Herda de: FormBase          BO associado: SigOpPdtBO
* Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
*
* Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
* Fase 4/8: a grade de 8 colunas (grd_4c_Dados) ligada a
*   this_oBusinessObject.this_cCursorPendentes ("cursor_4c_Pendentes"),
*   incluindo a coluna checkbox "seleciona" (Column.AddObject + CurrentControl
*   + Sparse = .F., regra CLAUDE.md #18).
*   A Fase 4 entregou tambem, junto com a grade, os tres botoes standalone
*   (SelTudo/apaga/ok) em ConfigurarBotoes e AjustarBotoesPorModo.
* Fase 5/8: Shape2/Shape1 (molduras decorativas, em ConfigurarMolduras) e
*   Say_Procura/Get_Procura (campo de busca por codigo, em
*   ConfigurarCamposBusca) - os dois ultimos blocos de controles que faltavam
*   para a superficie do form ficar completa em relacao ao dump do SCX.
* Fase 6/8: a VALIDACAO do unico campo digitavel da tela - os tres eventos
*   que o legado escreve em Get_Procura (Valid com o SEEK por Numes,
*   LostFocus devolvendo o foco a coluna de selecao da grade e When
*   zerando o campo na entrada), implementados em ValidarProcura /
*   ValidarProcuraExec / ProcuraGotFocus / FocarSelecaoGrade e ligados por
*   BINDEVENT em ConfigurarCamposBusca ("LostFocus" e "GotFocus" - em
*   TextBox o BINDEVENT de "Valid"/"When" nao dispara de forma confiavel,
*   regra CLAUDE.md #3/#35). O cursor placeholder de GarantirCursorGrade
*   ganhou os dois TAGs que o cursor real do BO ja tinha (EmpDopNum e
*   Numes), sem os quais o SEEK do Valid estoura.
*   NAO HA LOOKUP a implementar, e isso eh fato do LEGADO e nao omissao de
*   migracao: varredura do dump (SigOpPdt_form_codigo_fonte.txt) e de
*   comportamento.json devolve ZERO ocorrencia de todos os padroes de
*   lookup do projeto - fwBusca (Ext/Sel/Int), mAddColuna, sigacess(,
*   Acesso<X>( e FormBuscaAuxiliar - e ZERO "PROCEDURE KeyPress" (logo
*   nenhum F3/F4/F5). O SEEK de Get_Procura posiciona o ponteiro DENTRO da
*   propria grade, sem consultar outra tabela. Inventar um lookup para
*   "preencher a fase" violaria o PILAR 1 e a regra "NUNCA inventar tabelas
*   de lookup que nao existem no original".
*   Tambem nao sobra CAMPO a acrescentar: os dois unicos controles soltos do
*   dump (Say_Procura/Get_Procura) sairam na Fase 5 e os outros 8 controles
*   de dado sao colunas de grade (Fase 4) - este form nao tem Page2 de
*   Dados (nao tem PageFrame algum).
* Fase 7/8: eventos dos botoes e das CELULAS da grade - ENTREGUE.
*   Este form NAO tem botao CRUD algum (o legado herda de `form` puro, nao de
*   frmcadastro: zero Grupo_Op, zero Incluir/Alterar/Visualizar/Excluir no
*   dump), entao nao existe BtnIncluirClick/BtnAlterarClick/
*   BtnVisualizarClick/BtnExcluirClick a escrever - inventa-los violaria o
*   PILAR 1 e a regra "NUNCA inventar". Os eventos que o legado REALMENTE
*   tem, todos portados:
*     - SelTudo.Click  -> BtnSelTudoClick  (marca todas as linhas, via
*       SigOpPdtBO.MarcarPendencia(.T.) - o .T. suprime os avisos)
*     - apaga.Click    -> BtnApagaClick    (desmarca todas, via
*       SigOpPdtBO.DesmarcarPendencia)
*     - ok.Click       -> BtnOkClick       (reabilita o form pai e fecha)
*     - fwcheckbox1.InteractiveChange -> GradeSelecaoInteractiveChange
*       (marca/desmarca UMA linha - equivalente a ThisForm.Marca()/
*       ThisForm.Desmarca())
*     - fwcheckbox1.When -> gate de modo em AjustarBotoesPorModo
*       (Column1.ReadOnly) + o mesmo gate dentro do handler acima
*     - GotFocus do Text1 das 6 colunas de consulta ->
*       GradeColunaGotFocus, que devolve o foco a coluna de selecao
*   O religamento de tudo isso vive em VincularEventosGrade, chamado do fim
*   de VincularGrade, porque recarregar o cursor DESTROI as colunas (e com
*   elas o Check1 e os BINDEVENT) - ver o cabecalho daquele metodo.
* Fase 8/8: orquestracao do Init legado em InicializarForm - chamada a
*   this_oBusinessObject.CarregarPendencias() (ja implementado na Fase 2 do
*   BO) apos criar o cursor placeholder cursor_4c_Pendentes, e o fechamento
*   do dialogo em ok.Click (equivalente a "ThisForm.ParentForm.Enabled = .t.
*   / ThisForm.Release").
*   Fecha tambem a CAUDA do Marca() legado, que as fases anteriores havia
*   descartado: AtualizarFormPai devolve ao form PAI as tres razoes sociais
*   resolvidas (origem/destino/responsavel) e manda ele se repintar, o que
*   no legado era o bloco "With ThisForm.ParentForm.Pagina.Dados ...
*   .Refresh / Endwith" - ver o cabecalho daquele metodo. Chamado nos DOIS
*   caminhos que marcam pendencia (GradeSelecaoInteractiveChange, uma linha;
*   BtnSelTudoClick, a lista inteira) e em nenhum que desmarca, porque o
*   Desmarca() legado nao toca na pagina de Dados do pai.
*==============================================================================

DEFINE CLASS FormSigOpPdt AS FormBase

    *==========================================================================
    * Propriedades visuais - transcritas do dump do SCX legado (secao
    * "PROPRIEDADES DE: SIGOPPDT"). DataSession = 2: dialogo nasce com sessao
    * PRIVADA, rebindada para a do form pai dentro do Init (ver abaixo).
    * ControlBox/Closable/TitleBar: sem X e sem barra de titulo - nenhum
    * botao de sistema desenha. WindowType = 1: Show() desta classe SEMPRE
    * roda modal.
    *==========================================================================
    Height       = 600
    Width        = 800
    DataSession  = 2
    ShowWindow = 1
    BorderStyle  = 2
    DoCreate     = .T.
    ShowTips     = .T.
    AutoCenter   = .T.
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    WindowState  = 0
    AlwaysOnTop  = .F.
    Caption      = "Opera" + CHR(231) + CHR(245) + "es Pendentes"

    *==========================================================================
    * this_oFormPai - equivale a property customizada "parentform" do legado
    * ("Lparameters pForm,pData,pCnx" + "ThisForm.ParentForm = pForm" no
    * Init). Referencia ao form de movimentacao (SigMvCab) que abriu este
    * dialogo - usado nas fases seguintes para localizar os cursores
    * crSigMvCab/crLclMvItn/TmpOperacao e para reabilitar o form pai ao
    * fechar ("ThisForm.ParentForm.Enabled = .t.").
    *==========================================================================
    this_oFormPai = .NULL.

    *==========================================================================
    * this_cOpEscolha - equivale a property customizada "op_escolha" do
    * legado ("ThisForm.Op_Escolha = ThisForm.Parentform.pcEscolha", no fim do
    * Init). Guarda o MODO em que o form PAI de movimentacao esta ("INSERIR",
    * "ALTERAR", "VISUALIZAR", ...) e governa a superficie desta tela: no
    * legado SelTudo, apaga, Say_Procura e Get_Procura so ficam VISIVEIS
    * quando Op_Escolha = "INSERIR", e o When dos dois botoes os habilita em
    * "INSERIR" e "ALTERAR".
    *
    * Sem form pai (harness de teste, probe e ValidarUIFidelity instanciam
    * com CREATEOBJECT("FormSigOpPdt") sem parametro algum) nao existe
    * pcEscolha para ler; nesse caso o valor fica "INSERIR", que eh o unico
    * modo em que o legado desenha a tela COMPLETA - assim a validacao de UI
    * compara a superficie inteira, em vez de uma tela parcial.
    *==========================================================================
    this_cOpEscolha = "INSERIR"

    *==========================================================================
    * this_lEmValidacaoProcura - guarda de REENTRANCIA de ValidarProcura (o
    * handler do campo de busca). O handler chama SetFocus, e mover o foco
    * redispara LostFocus/GotFocus do proprio campo: sem a guarda o handler
    * se chamaria em cascata (regra CLAUDE.md #47). A flag eh ligada e
    * liberada no WRAPPER (ValidarProcura), nunca dentro do corpo - corpo com
    * RETURN antecipado deixaria a flag presa em .T. e MATARIA a validacao
    * pelo resto da vida do form.
    *==========================================================================
    this_lEmValidacaoProcura = .F.

    *==========================================================================
    * this_nProcuraPendente - codigo digitado em Get_Procura que NAO existe na
    * grade. Serve para reproduzir fielmente o par Valid/When do legado: o
    * "Return 0" do Valid mantem o foco no campo e o legado NAO reavalia o
    * When nesse retorno, logo o valor digitado continua A VISTA para
    * correcao. No migrado o foco volta por SetFocus, o que dispara GotFocus
    * (onde mora o "This.Value = 0" do When) - esta property marca a entrada
    * FORCADA, em que o GotFocus devolve o valor em vez de zerar o campo.
    * Zero = nenhuma pendencia (Numes eh n(6); o proprio legado usa 0 como
    * "campo vazio", ver o When e o LostFocus de Get_Procura).
    *==========================================================================
    this_nProcuraPendente = 0

    *==========================================================================
    * this_lEmToggleSelecao - guarda de REENTRANCIA de
    * GradeSelecaoInteractiveChange (o toggle do checkbox da coluna de
    * selecao). MarcarPendencia exibe MsgAviso MODAL em cada regra de
    * bloqueio, e dialogo modal devolve o controle ao loop de eventos: sem a
    * guarda um segundo clique na grade reentraria no handler com o primeiro
    * ainda no meio da gravacao (regra CLAUDE.md #47). Ligada e liberada no
    * WRAPPER (GradeSelecaoInteractiveChange), nunca no corpo
    * (GradeSelecaoInteractiveChangeExec) - corpo com RETURN antecipado
    * deixaria a flag presa em .T. e MATARIA o toggle pelo resto da vida do
    * form.
    *==========================================================================
    this_lEmToggleSelecao = .F.

    *==========================================================================
    * this_lEmFocoGrade - guarda de REENTRANCIA de GradeColunaGotFocus (o
    * "ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus" que o legado tem no
    * GotFocus de TODA coluna de consulta). O handler MOVE o foco, e mover o
    * foco dentro da grade dispara GotFocus de outra celula: sem a guarda o
    * redirecionamento se chamaria em cascata. Mesmo padrao wrapper/corpo de
    * this_lEmValidacaoProcura.
    *==========================================================================
    this_lEmFocoGrade = .F.

    *==========================================================================
    * Init - replica "Lparameters pForm, pData, pCnx" do legado. Os tres
    * parametros sao OPCIONAIS: o harness de teste e a validacao de UI
    * instanciam o form sem parametro nenhum (CREATEOBJECT("FormSigOpPdt")).
    * par_oConexao (equivalente a pCnx/poDataMgr) NAO tem uso nesta
    * arquitetura - gnConnHandle ja eh compartilhado via config.prg (mesma
    * decisao documentada em Formsigopped.prg) - por isso o 3o parametro eh
    * recebido so para preservar a assinatura posicional do legado e
    * descartado.
    *
    * SET DATASESSION TO roda ANTES de DODEFAULT() (que dispara
    * InicializarForm via FormBase.Init), replicando a ordem exata do Init
    * legado ("Set Datasession To pData" eh a 1a linha executavel, antes de
    * qualquer manipulacao de cursor). NUNCA chamar InicializarForm aqui
    * tambem - DODEFAULT() chamado duas vezes estoura "member object already
    * exists" nos AddObject (regra CLAUDE.md - Problema 8/FORMCOR_LICOES).
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_oConexao)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai

            *-- "ThisForm.Op_Escolha = ThisForm.Parentform.pcEscolha" do Init
            *-- legado. No legado essa linha fica no FIM do Init (depois de
            *-- montar a grade); aqui ela sobe para ANTES do DODEFAULT porque
            *-- InicializarForm ja precisa do modo para decidir a visibilidade
            *-- de SelTudo/apaga (ver AjustarBotoesPorModo). O resultado eh o
            *-- mesmo: o valor nao muda ao longo da montagem.
            *--
            *-- PEMSTATUS protege o pai que nao tenha a property: ler nome
            *-- inexistente estoura "Property PCESCOLHA is not found" dentro
            *-- do Init e o form nao abriria (CREATEOBJECT devolveria .F.).
            IF PEMSTATUS(par_oFormPai, "pcEscolha", 5)
                IF VARTYPE(par_oFormPai.pcEscolha) = "C" AND !EMPTY(par_oFormPai.pcEscolha)
                    THIS.this_cOpEscolha = UPPER(ALLTRIM(par_oFormPai.pcEscolha))
                ENDIF
            ENDIF
        ENDIF

        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            SET DATASESSION TO (par_nDataSessionPai)
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base e orquestra a abertura, na
    * mesma ordem do Init legado: fundo do form, Business Object, os blocos
    * visuais (ConfigurarPageFrame, que chama cabecalho/molduras/grade/campo
    * de busca/botoes na ordem do dump do SCX), TornarControlesVisiveis e,
    * por fim, a CARGA da grade.
    *
    * A carga vai por CarregarLista, que orquestra
    * this_oBusinessObject.CarregarPendencias() (o SELECT que popula
    * cursor_4c_Pendentes) e religa a grade. O .F. dela equivale ao
    * "Return 0" do Init legado, que abortava a abertura da tela.
    *
    * AjustarBotoesPorModo fica DEPOIS de TornarControlesVisiveis de
    * proposito - ver o comentario no corpo.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpPdtBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpPdtBO.", ;
                    "Erro em InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da grade: o Init legado monta TmpPends e liga a
                *-- grade ANTES de devolver o controle (a tela nunca abre
                *-- vazia esperando o usuario). Pulada em modo de teste/
                *-- validacao de UI e quando os cursores do form pai nao
                *-- estao abertos - ver CarregarLista. O .F. equivale ao
                *-- "Return 0" do Init legado, que abortava a abertura.
                IF THIS.CarregarLista()
                    *-- DEPOIS de TornarControlesVisiveis (que forca
                    *-- Visible = .T. em todo controle criado via AddObject,
                    *-- inclusive os dois botoes que o legado mantem ocultos
                    *-- fora de "INSERIR").
                    THIS.AjustarBotoesPorModo()

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
    * real neste form (objeto raiz do legado eh "Class: form" generico, sem
    * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
    * convencao com o restante do pipeline (mesmo padrao de Formsigopped.prg/
    * Formsigoppei.prg, outros forms OPERACIONAIS sem PageFrame). Ordem de
    * criacao conforme o dump (ver SECAO 1 do codigo fonte): cntSombra ->
    * Shape2 -> Shape1 -> Grade -> Say_Procura/Get_Procura -> SelTudo -> apaga
    * -> ok.
    *
    * A ordem importa: o ultimo AddObject fica no TOPO do z-order (desenha
    * por cima). As duas molduras (Shape2/Shape1) sao criadas ANTES da grade
    * e dos campos de busca, como no dump - assim nenhuma delas cobre o
    * controle que ela emoldura.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarMolduras()
        THIS.ConfigurarGrade()
        THIS.ConfigurarCamposBusca()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
    * (cntSombra do legado) e os dois labels sobrepostos que produzem o
    * efeito de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
    * (Top = 17). Width/Height/Font/ForeColor transcritos do dump (secao
    * "PROPRIEDADES DE: SIGOPPDT.cntSombra" e dos dois labels filhos).
    *
    * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
    * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
    * criado por AddObject e, com WordWrap, descarta a Height).
    *
    * Caption = THIS.Caption transcreve "ThisForm.cntSombra.lblSombra.Caption
    * = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption" do Init
    * legado (o dump mostra "Cadastro de Testes" por ser o valor congelado no
    * Form Designer - em runtime o Init sempre sobrescreve com o Caption do
    * form).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarMolduras - as duas molduras decorativas do legado (Shape2 e
    * Shape1, ambas classe "shape" base), criadas nesta ordem porque eh a do
    * dump (ver SECAO 1 do codigo fonte): Shape2 emoldura o bloco do campo de
    * busca no rodape (Top=339 Left=73 Width=168 Height=39, envolvendo
    * Say_Procura em 350/83 e Get_Procura em 347/186) e Shape1 emoldura a
    * area do botao "ok" no topo direito (Top=7 Left=672 Width=27 Height=41).
    *
    * Propriedades TRANSCRITAS do dump ("PROPRIEDADES DE: SIGOPPDT.Shape2" e
    * ".Shape1"): BackStyle = 0 (sem preenchimento), BorderStyle = 0 e
    * BorderColor = 136,189,188. Em VFP9 BorderStyle = 0 eh "Transparent" -
    * com BackStyle = 0 junto, as duas molduras nao pintam NADA na tela,
    * apesar da BorderColor declarada. Isso eh HERDADO do SCX, nao defeito de
    * migracao: o legado declara exatamente estes tres valores e a tela do
    * sistema antigo tambem nao desenha moldura nenhuma. Transcrever (PILAR
    * 1) - "consertar" para BorderStyle = 1 faria aparecer na tela nova uma
    * linha que nunca existiu na antiga.
    *
    * Shape NAO tem ForeColor nem ShapeType (regra CLAUDE.md #33 - as cores
    * moram em BorderColor/FillColor, e ShapeType eh de VB; no VFP o
    * equivalente eh Curvature, cujo default 0 ja eh o retangulo pretendido).
    * Por isso nenhuma das duas eh atribuida aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMolduras()
        LOCAL loc_oErro

        TRY
            *-- Shape2 - moldura do bloco "Procurar Codigo" (rodape)
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 339
                .Left        = 73
                .Width       = 168
                .Height      = 39
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Shape1 - moldura da area do botao "ok" (topo direito)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 672
                .Width       = 27
                .Height      = 41
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarMolduras")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - a grade de 8 colunas (Grade do legado, classe
    * fwgrade). Propriedades transcritas do dump (layout.json): Top=180,
    * Left=72, Width=622, Height=148, ColumnCount=8, Visible=.T. - mais o que
    * vem da classe fwgrade do framework.vcx e o SCX nao sobrepoe
    * (docs\FRAMEWORK_class_codigo_fonte.txt): AllowHeaderSizing=.F.,
    * AllowRowSizing=.F., DeleteMark=.F., RecordMark=.F., ScrollBars=2,
    * GridLineColor=238,238,238, HighlightBackColor=90,90,90.
    *
    * Nao ha PageFrame neste form (ver cabecalho do arquivo) - Top/Left sao
    * absolutos ao form, sem compensacao de -29 (essa regra eh exclusiva de
    * frmcadastro).
    *
    * As colunas e o RecordSource ficam em VincularGrade, chamado aqui e de
    * novo apos this_oBusinessObject.CarregarPendencias() (Fase 8) - ver a
    * justificativa no cabecalho de VincularGrade (Problema 48/regra #41).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top               = 180
                .Left              = 72
                .Width             = 622
                .Height            = 148
                .TabIndex          = 1
                .FontName          = "Courier New"
                .FontSize          = 8
                .HeaderHeight      = 16
                .RowHeight         = 16
                .ScrollBars        = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .RecordMark        = .F.
                .DeleteMark        = .F.
                .GridLineColor     = RGB(238, 238, 238)
                .HighlightBackColor = RGB(90, 90, 90)
                .Visible           = .T.
            ENDWITH

            THIS.VincularGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GarantirCursorGrade - garante que cursor_4c_Pendentes EXISTE antes de
    * qualquer Column.ControlSource apontar para ele (regra CLAUDE.md #41 -
    * Column.ControlSource de cursor que ainda nao existe derruba o Init: o
    * ALIAS inexistente estoura dentro do TRY de InicializarForm, que devolve
    * .F., CREATEOBJECT devolve .F. e o usuario clica no menu e nada
    * acontece, sem erro visivel).
    *
    * O cursor REAL (populado pelo SELECT em SigMvCab) so existe depois de
    * this_oBusinessObject.CarregarPendencias() rodar (Fase 8), e so pode
    * rodar com o form PAI (crSigMvCab/TmpOperacao) ja aberto - na abertura
    * por harness/probe ou ValidarUIFidelity esses cursores nao existem.
    *
    * Estrutura EXATA do cursor que SigOpPdtBO.CarregarPendencias monta
    * (CREATE CURSOR cursor_4c_Pendentes, ver o BO) - os nomes e os tipos sao
    * o que a grade consulta ao vincular; o BO SEMPRE recria este alias
    * inteiro (USE IN + CREATE CURSOR), nunca faz APPEND FROM dentro dele.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCursorGrade()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)

            IF !EMPTY(loc_cAlias)
                IF !USED(loc_cAlias)
                    CREATE CURSOR (loc_cAlias) ( ;
                        Flag    L,     ;
                        Emps    C(3),  ;
                        Dopes   C(20), ;
                        Numes   N(6),  ;
                        MascNum C(6),  ;
                        Datas   T,     ;
                        TpFats  C(3),  ;
                        Origem  C(21), ;
                        Destino C(21), ;
                        Valos   N(12, 2) )

                    *-- Os MESMOS dois TAGs que SigOpPdtBO.CarregarPendencias
                    *-- cria no cursor real, transcritos do Init legado
                    *-- ("Index On Emps + Dopes + Str(Numes, 6) Tag EmpDopNum"
                    *-- e "Index On Numes Tag Numes"). O placeholder precisa
                    *-- deles tanto quanto o cursor real: ValidarProcura faz
                    *-- "SET ORDER TO Numes" + SEEK (transcricao do Valid de
                    *-- Get_Procura) e o SEEK estoura sem o TAG.
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                    INDEX ON Numes TAG Numes
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GarantirCursorGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularGrade - liga a grade ao cursor de exibicao e (re)configura as 8
    * colunas. Chamado por ConfigurarGrade (montagem) E (Fase 8) depois de
    * this_oBusinessObject.CarregarPendencias() recriar o cursor.
    *
    * POR QUE TUDO DE COLUNA MORA AQUI, e nao em ConfigurarGrade: atribuir
    * ColumnCount RECRIA os objetos Column (descartando Width, Header1.
    * Caption, CurrentControl, ReadOnly); e o BO fecha e recria o alias
    * inteiro (USE IN + CREATE CURSOR) em CarregarPendencias, o que derruba
    * RecordSource/ControlSource. Configurar coluna uma unica vez na
    * montagem seria apagado na primeira carga - a grade abriria com
    * "Header1"/colunas de 90px (Problema 48/CLAUDE.md regra #41).
    *
    * ORDEM obrigatoria: Grid.ReadOnly (ANTES das colunas - regra #18, o do
    * grid propaga e sobrescreveria o das colunas) -> ColumnCount ->
    * RecordSource -> Column.ControlSource -> resto da coluna (Width por
    * ultimo, pois RecordSource/ControlSource recalculam para o default 90).
    *
    * WITH de cada Column fica FORA do WITH do grid (regra CLAUDE.md #44 -
    * WITH aninhado com .AddObject dentro ignora propriedades em silencio).
    *
    * Colunas (ordem visual = ordem do dump/layout.json, ver mapeamento.json
    * e o cabecalho de SigOpPdtBO.prg para a estrutura do alias
    * cursor_4c_Pendentes):
    *   1 "seleciona" (checkbox, Flag)       - unica coluna EDITAVEL; o
    *       toggle real (InteractiveChange -> Marcar/DesmarcarPendencia) fica
    *       em GradeSelecaoInteractiveChange, ligado por VincularEventosGrade
    *       no fim deste metodo; aqui a renderizacao (AddObject +
    *       CurrentControl + Sparse = .F., regra #18)
    *   2 "empresa" (Emps)        - "Emp"
    *   3 "operacao" (Dopes)      - "Opera" + CHR(231) + CHR(227) + "o"
    *   4 "codigo" (MascNum)      - "C" + CHR(243) + "d" - numero do
    *       documento FORMATADO para exibicao (TmpPends.MascNum no legado),
    *       nao o Numes cru (que eh so a chave de ordenacao)
    *   5 "data" (Datas)          - "Data"
    *   6 "Grupo" (Origem)        - "Origem"
    *   7 "Conta" (Destino)       - "Destino"
    *   8 "Column8" (Valos)       - "Valor"
    *
    * Fonte, largura, Alignment e ForeColor de cada coluna/Header1 sao
    * TRANSCRITOS do dump (secao "PROPRIEDADES DE: SIGOPPDT.Grade" e as de
    * cada <coluna>.Header1): Column1 em Courier New 9 e as demais em Arial
    * 8; Header1 das colunas 1 a 4 em Arial 8 e das colunas 5 a 8 em Verdana
    * 8 com ForeColor 36,84,155; todos os Header1 com Alignment = 2
    * (centralizado).
    *
    * Largura total: 15+25+110+40+60+130+130+75 = 585, dentro dos 622 de
    * Grade.Width.
    *
    * DESVIO DOCUMENTADO - ReadOnly das colunas 2 a 7: o dump declara
    * "ReadOnly = .F." nelas (so Column8 eh .T.), mas o legado as torna
    * inacessiveis por COMPORTAMENTO, nao por propriedade - empresa/operacao/
    * data tem "PROCEDURE When / Return .f." no Text1, e TODAS redirecionam o
    * foco de volta ao checkbox no GotFocus ("ThisForm.Grade.Seleciona.
    * fwcheckbox1.SetFocus"). O redirecionamento de foco esta portado em
    * GradeColunaGotFocus (ligado por VincularEventosGrade), e o ReadOnly =
    * .T. aqui reproduz o "When / Return .f." - as duas metades do legado,
    * nao uma substituindo a outra: ReadOnly impede DIGITAR na celula e o
    * GotFocus impede PARAR nela. Resultado observavel igual ao legado: a
    * tela inteira eh de consulta e so o checkbox da coluna 1 eh editavel.
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_oGrid, loc_cAlias, loc_oErro

        TRY
            THIS.GarantirCursorGrade()

            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)
            loc_oGrid  = THIS.grd_4c_Dados

            WITH loc_oGrid
                .ReadOnly    = .F.
                .ColumnCount = 8

                IF !EMPTY(loc_cAlias)
                    IF USED(loc_cAlias)
                        .RecordSource = loc_cAlias
                    ENDIF
                ENDIF
            ENDWITH

            *-- 1 - "seleciona" (checkbox) <- Flag
            *-- Propriedades do dump: Column1 Courier New 9, Width = 15,
            *-- Sparse = .F., ForeColor = 0,0,0; Header1 Arial, Alignment = 2,
            *-- Caption = ""; fwcheckbox1 Top = 31 / Left = 12 / Alignment = 0
            *-- / BackStyle = 0 / Caption = "" / ReadOnly = .F. (o resto vem da
            *-- classe fwcheckbox: 60x17, Tahoma 8, ForeColor 90,90,90,
            *-- Themes = .F.).
            *--
            *-- O dump declara AutoSize = .T. no checkbox: escrito como
            *-- AutoSize = .F. + Width/Height EXPLICITOS porque AutoSize eh
            *-- NO-OP em controle criado por AddObject (medido no VFP9) e,
            *-- junto com WordWrap, ainda descarta a Height - os numeros 60x17
            *-- sao os da propria classe, logo fixa-los eh reproducao fiel.
            *--
            *-- PEMSTATUS antes do AddObject: dois AddObject com o MESMO nome
            *-- no mesmo alvo estouram "Object CHECK1 is already defined" e
            *-- derrubam o Init - e este metodo roda de novo a cada carga
            *-- (ver cabecalho). Atribuir ColumnCount normalmente recria as
            *-- Columns (destruindo o Check1), mas nao se pode contar com
            *-- isso quando o valor atribuido eh o mesmo de antes.
            WITH loc_oGrid.Column1
                .ControlSource = loc_cAlias + ".Flag"
                .FontName      = "Courier New"
                .FontSize      = 9
                .Movable       = .F.
                .Resizable     = .F.
                .Sparse        = .F.
                .ForeColor     = RGB(0, 0, 0)

                IF !PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
                    .AddObject("Check1", "CheckBox")
                ENDIF

                .Check1.Caption   = ""
                .Check1.FontName  = "Tahoma"
                .Check1.FontSize  = 8
                .Check1.Alignment = 0
                .Check1.BackStyle = 0
                .Check1.ForeColor = RGB(90, 90, 90)
                .Check1.Themes    = .F.
                .Check1.ReadOnly  = .F.
                .Check1.AutoSize  = .F.
                .Check1.Top       = 31
                .Check1.Left      = 12
                .Check1.Width     = 60
                .Check1.Height    = 17
                .Check1.Visible   = .T.

                .CurrentControl    = "Check1"
                .ReadOnly          = .F.
                .Header1.FontName  = "Arial"
                .Header1.Alignment = 2
                .Header1.Caption   = ""
                .Width             = 15
            ENDWITH

            *-- 2 - "empresa" <- Emps
            WITH loc_oGrid.Column2
                .ControlSource = loc_cAlias + ".Emps"
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.Caption   = "Emp"
                .Width             = 25
            ENDWITH

            *-- 3 - "operacao" <- Dopes
            WITH loc_oGrid.Column3
                .ControlSource = loc_cAlias + ".Dopes"
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Width             = 110
            ENDWITH

            *-- 4 - "codigo" <- MascNum (numero do documento FORMATADO)
            WITH loc_oGrid.Column4
                .ControlSource = loc_cAlias + ".MascNum"
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.Caption   = "C" + CHR(243) + "d"
                .Width             = 40
            ENDWITH

            *-- 5 - "data" <- Datas
            WITH loc_oGrid.Column5
                .ControlSource = loc_cAlias + ".Datas"
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
                .Header1.Caption   = "Data"
                .Width             = 60
            ENDWITH

            *-- 6 - "Grupo" <- Origem
            WITH loc_oGrid.Column6
                .ControlSource = loc_cAlias + ".Origem"
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
                .Header1.Caption   = "Origem"
                .Width             = 130
            ENDWITH

            *-- 7 - "Conta" <- Destino
            WITH loc_oGrid.Column7
                .ControlSource = loc_cAlias + ".Destino"
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
                .Header1.Caption   = "Destino"
                .Width             = 130
            ENDWITH

            *-- 8 - "Column8" <- Valos
            *-- InputMask "999,999.99" transcrita do dump (a coluna eh a unica
            *-- do legado com mascara - formata o valor do documento).
            WITH loc_oGrid.Column8
                .ControlSource = loc_cAlias + ".Valos"
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .InputMask     = "999,999.99"
                .ForeColor     = RGB(0, 0, 0)
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
                .Header1.Caption   = "Valor"
                .Width             = 75
            ENDWITH

            *-- Eventos das celulas + o gate de modo do checkbox. Tem de
            *-- rodar AQUI, no fim de VincularGrade, por DOIS motivos
            *-- medidos (ver o cabecalho de VincularEventosGrade).
            THIS.VincularEventosGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em VincularGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularEventosGrade - liga os eventos das CELULAS da grade e reaplica o
    * gate de modo do checkbox de selecao. Chamado SO do fim de VincularGrade,
    * que por sua vez roda na montagem E depois de cada
    * SigOpPdtBO.CarregarPendencias().
    *
    * POR QUE no fim de VincularGrade, e nao em ConfigurarGrade (medido no
    * VFP9 em 2026-11-13):
    *
    *   1) O BO fecha o alias (USE IN + CREATE CURSOR) para refazer a grade, e
    *      FECHAR O ALIAS QUE EH RecordSource DERRUBA AS COLUNAS - no probe o
    *      ColumnCount caiu de 3 para 0 e Column1 virou "Unknown member".
    *      Logo o Check1 reconstruido por VincularGrade eh um objeto NOVO, e
    *      as ligacoes do anterior morreram com ele: sem religar aqui, o
    *      checkbox reaparece na tela e NAO alterna mais nada - o usuario ve
    *      a caixa, clica, e o vinculo nunca eh gravado (sem erro, sem log).
    *
    *   2) Grid.ReadOnly PROPAGA para Column.ReadOnly e SOBRESCREVE o que a
    *      coluna tinha (medido: Column2.ReadOnly = .T. volta a .F. depois de
    *      Grid.ReadOnly = .F.; regra CLAUDE.md #18/#46). VincularGrade
    *      atribui Grid.ReadOnly no TOPO, entao o gate de modo da coluna 1 so
    *      sobrevive se for aplicado DEPOIS - e eh por isso que ele mora em
    *      AjustarBotoesPorModo, chamado no FIM deste metodo.
    *
    * BINDEVENT REPETIDO eh seguro: o VFP9 DEDUPLICA o mesmo quadruplo
    * (objeto, evento, delegado, metodo) - medido, AEVENTS devolve 1 depois de
    * dois BINDEVENT identicos e o handler dispara UMA vez. Por isso nao ha
    * UNBINDEVENT aqui (e a forma de 2 argumentos
    * "UNBINDEVENT(obj, evento)" dispara erro 11 - tambem medido).
    *
    * Os delegados sao PUBLIC de proposito: BINDEVENT com metodo PROTECTED
    * NAO falha em silencio, ele ESTOURA ("Property <X> is not found" -
    * medido) e, como esta cadeia roda dentro do TRY de InicializarForm, o
    * erro viraria "a tela nao abre" (regra CLAUDE.md #3).
    *==========================================================================
    PROTECTED PROCEDURE VincularEventosGrade()
        LOCAL loc_oGrid, loc_nCol, loc_oErro

        TRY
            loc_oGrid = THIS.grd_4c_Dados

            *-- (a) Toggle do checkbox da coluna de selecao - "PROCEDURE
            *-- InteractiveChange" de SIGOPPDT.Grade.seleciona.fwcheckbox1.
            *-- "InteractiveChange" (e nao o quarteto Click/MouseDown/MouseUp/
            *-- KeyPress com NODEFAULT da regra CLAUDE.md #46) porque o legado
            *-- ABRE com "=DoDefault()", ou seja ele CONTA com o toggle
            *-- NATIVO e so reage ao valor resultante. E o toggle nativo de
            *-- fato funciona neste caso, medido no VFP9: o alias eh
            *-- CREATE CURSOR local (gravavel) com Flag LOGICO, e atribuir
            *-- Check1.Value PROPAGA para a coluna do cursor pelo
            *-- ControlSource. O quarteto com NODEFAULT eh para o caso oposto
            *-- (legado que SUPRIME o toggle nativo) e aqui alternaria DUAS
            *-- vezes, anulando o clique.
            IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
                BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", ;
                    THIS, "GradeSelecaoInteractiveChange")
            ENDIF

            *-- (b) "PROCEDURE GotFocus / ThisForm.Grade.Seleciona.
            *-- fwcheckbox1.SetFocus" de Text1 das colunas de CONSULTA
            *-- (empresa, operacao, data, Grupo, Conta e Column8 no dump - as
            *-- seis que o legado declara). O foco sempre volta para a coluna
            *-- de selecao, a unica editavel da tela.
            *--
            *-- A coluna 4 ("codigo") NAO entra: o dump nao declara GotFocus
            *-- nela (o controle dela eh "Ingrid1", classe ingrid do
            *-- Framework, e a secao de comportamento do legado nao lista
            *-- evento algum para ele). Nao inventar evento que o legado nao
            *-- tem.
            *--
            *-- A coluna 1 tambem NAO entra, e isso eh o que quebra o ciclo:
            *-- o handler move o foco PARA a coluna 1, que nao tem GotFocus
            *-- ligado e portanto nao reentra. A guarda this_lEmFocoGrade eh
            *-- a segunda linha de defesa, para o transito do foco entre
            *-- celulas.
            *--
            *-- Text1 eh membro NATIVO da Column (ao contrario do Check1, que
            *-- vem de AddObject), e BINDEVENT nele funciona - medido:
            *-- AEVENTS confirma GOTFOCUS -> o delegado.
            FOR loc_nCol = 2 TO 8
                IF loc_nCol != 4
                    IF PEMSTATUS(loc_oGrid, "Column" + TRANSFORM(loc_nCol), 5)
                        BINDEVENT(EVALUATE("loc_oGrid.Column" + TRANSFORM(loc_nCol) + ".Text1"), ;
                            "GotFocus", THIS, "GradeColunaGotFocus")
                    ENDIF
                ENDIF
            ENDFOR

            *-- (c) "PROCEDURE When / Return (ThisForm.Op_Escolha =
            *-- 'INSERIR')" do fwcheckbox1, aplicado como Column1.ReadOnly
            *-- (ver AjustarBotoesPorModo). OBRIGATORIO aqui no fim, depois do
            *-- Grid.ReadOnly do topo de VincularGrade - motivo (2) do
            *-- cabecalho.
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em VincularEventosGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCamposBusca - o campo de busca por codigo do rodape:
    * Say_Procura (label) + Get_Procura (textbox), ambos classe BASE do VFP
    * (o dump traz "Classe: label (Base: label)" e "Classe: textbox (Base:
    * textbox)" - nao sao fwget/say do Framework, por isso NAO ha propriedade
    * herdada de classe para completar: tudo o que vale esta no dump).
    *
    * Posicoes e propriedades transcritas de "PROPRIEDADES DE:
    * SIGOPPDT.Say_Procura" e ".Get_Procura" - os dois ficam DENTRO da
    * moldura shp_4c_Shape2 (339..378 x 73..241), criada antes em
    * ConfigurarMolduras.
    *
    * lbl_4c__Procura (Say_Procura): o dump declara AutoSize = .T., mas
    * AutoSize eh NO-OP em Label criado por AddObject (medido no VFP9: a
    * Width fica nos 100 do default) e, com WordWrap, ainda DESCARTA a
    * Height - por isso aqui vai AutoSize = .F. com a Width = 89 e a Height =
    * 15 do proprio dump (regra CLAUDE.md #23). Esses numeros JA SAO o
    * auto-size que o Form Designer calculou, logo fixa-los eh reproducao
    * fiel, nao desvio do PILAR 1. Alignment = 0 porque o dump NAO declara
    * Alignment (classe label pura, texto da esquerda) - inventar
    * Alignment = 1 aqui encostaria a legenda na borda direita da caixa, que
    * termina em 83+89 = 172, DENTRO do Get_Procura (que comeca em 186)...
    * na verdade sobra folga, mas a regra vale pelo principio: Alignment nao
    * se inventa. ForeColor = 90,90,90 eh o valor EXPLICITO do dump e
    * coincide com o canonico de label de dados (regra #12) - nunca branco,
    * que ficaria invisivel sobre o fundo claro de new_background.jpg.
    *
    * txt_4c_Procura (Get_Procura): .Value = 0 - campo NUMERICO (o legado
    * compara "TmpPends.Numes == This.Value" e zera com "This.Value = 0" no
    * When/Valid; Numes eh n(6), dai MaxLength = 6). Alignment = 3
    * (automatico) e Format = "K" (seleciona o conteudo ao entrar no campo)
    * sao transcritos do dump - Format/InputMask do SCX sao obrigatorios e o
    * migrador costuma descarta-los (regra CLAUDE.md #49). NAO ha InputMask
    * no dump: nao inventar.
    *
    * Visibilidade: no legado os dois obedecem a "ThisForm.Say_Procura.Visible
    * = (ThisForm.Op_Escolha = 'INSERIR')" / "...Get_Procura.Visible = ..."
    * no fim do Init - isso esta em AjustarBotoesPorModo (ja escrito), que
    * roda DEPOIS de TornarControlesVisiveis. Aqui os dois nascem com
    * Visible = .T., que eh o estado do modo "INSERIR".
    *
    * Os eventos de Get_Procura (When "This.Value = 0", Valid com o SEEK
    * posicional no cursor da grade e LostFocus devolvendo o foco a coluna de
    * selecao) sao ligados por BINDEVENT no fim deste metodo e implementados
    * em ValidarProcura / ProcuraGotFocus / FocarSelecaoGrade (ver os
    * cabecalhos desses metodos para o codigo legado transcrito).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposBusca()
        LOCAL loc_oErro

        TRY
            *-- Say_Procura - legenda "Procurar Codigo : "
            THIS.AddObject("lbl_4c__Procura", "Label")
            WITH THIS.lbl_4c__Procura
                .AutoSize  = .F.
                .Top       = 350
                .Left      = 83
                .Width     = 89
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 6
                .Caption   = "Procurar C" + CHR(243) + "digo : "
                .Visible   = .T.
            ENDWITH

            *-- Get_Procura - codigo procurado na grade (Numes, n(6))
            THIS.AddObject("txt_4c_Procura", "TextBox")
            WITH THIS.txt_4c_Procura
                .Top       = 347
                .Left      = 186
                .Width     = 48
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 3
                .Format    = "K"
                .MaxLength = 6
                .TabIndex  = 2
                .Value     = 0
                .Visible   = .T.
            ENDWITH

            *-- Eventos de Get_Procura (handlers PUBLIC - BINDEVENT falha em
            *-- SILENCIO com metodo PROTECTED, regra CLAUDE.md #3).
            *--
            *-- "LostFocus" no lugar do Valid e "GotFocus" no lugar do When:
            *-- BINDEVENT em "Valid"/"When" de TextBox NAO dispara de forma
            *-- confiavel (regra CLAUDE.md #3/#35), e o Valid do legado roda
            *-- justamente ao SAIR do campo - LostFocus eh o evento
            *-- equivalente que o BINDEVENT alcanca.
            *--
            *-- Nao existe BINDEVENT de "KeyPress" aqui porque o legado NAO
            *-- tem KeyPress algum neste form (zero "PROCEDURE KeyPress" no
            *-- dump): nao ha F3/F4 a reproduzir, e ligar este handler a
            *-- KeyPress sem testar a tecla o faria rodar a CADA caractere
            *-- digitado (regra CLAUDE.md #47).
            BINDEVENT(THIS.txt_4c_Procura, "LostFocus", THIS, "ValidarProcura")
            BINDEVENT(THIS.txt_4c_Procura, "GotFocus",  THIS, "ProcuraGotFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposBusca")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - os tres botoes STANDALONE do legado (nao ha
    * CommandGroup nesta tela - cada um eh um CommandButton filho direto do
    * form):
    *
    *   SelTudo (classe fwbtnp)  Top=216 Left=704  "Seleciona tudo"
    *   apaga   (classe fwbtnp)  Top=256 Left=704  "Desmarca tudo"
    *   ok      (classe fwbtng)  Top=4   Left=723  Caption "\<Ok", Cancel=.T.
    *
    * Top/Left/Picture/Caption/ToolTipText/Cancel vem do dump do SCX (secoes
    * "PROPRIEDADES DE: SIGOPPDT.SelTudo / .apaga / .ok"); Width/Height/fonte/
    * cores vem das CLASSES do Framework (docs\FRAMEWORK_class_codigo_fonte.
    * txt), que o SCX nao sobrescreve: fwbtnp = 40x40 e fwbtng = 80x100,
    * ambas Comic Sans MS 8 bold+italic, WordWrap = .T., MousePointer = 15,
    * ForeColor 90,90,90, BackColor 255,255,255.
    *
    * Picture: nomes TRANSCRITOS do dump, nunca deduzidos pela acao do botao
    * (regra CLAUDE.md #25 - .Picture inexistente nao renderiza icone e NAO
    * da erro nenhum). Os tres arquivos existem em vbmp\:
    * to-do-list_checked2.ico, onebit_33.ico e cadastro_salvar_60.jpg (o
    * legado busca o ultimo em ..\framework\imagens\, que no projeto novo
    * esta consolidado em gc_4c_CaminhoIcones).
    *
    * DESVIO DOCUMENTADO - Themes: as classes fwbtnp/fwbtng declaram
    * Themes = .F., mas o canonico do projeto para CommandButton STANDALONE
    * com .Picture eh Themes = .T. + DisabledPicture (Pattern #99 do
    * CorretorAutomatico) - sem isso o icone nao renderiza quando o botao
    * esta desabilitado.
    *
    * cmd_4c_Ok termina em Left+Width = 723+80 = 803, 3px alem do Width = 800
    * do form: a sobra eh RECORTADA. Isso eh HERDADO do SCX (o legado declara
    * exatamente esses numeros) - nao se "corrige" inventando posicao nova
    * (regras #28/#30).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- SelTudo - marca TODAS as pendencias ainda nao vinculadas
            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top              = 216
                .Left             = 704
                .Width            = 40
                .Height           = 40
                .Caption          = ""
                .FontName         = "Comic Sans MS"
                .FontSize         = 8
                .FontBold         = .T.
                .FontItalic       = .T.
                .WordWrap         = .T.
                .MousePointer     = 15
                .ForeColor        = RGB(90, 90, 90)
                .BackColor        = RGB(255, 255, 255)
                .Themes           = .T.
                .Picture          = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
                .DisabledPicture  = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
                .ToolTipText      = "Seleciona tudo"
                .Visible          = .T.
            ENDWITH

            *-- apaga - desmarca TODAS as pendencias ja vinculadas
            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top              = 256
                .Left             = 704
                .Width            = 40
                .Height           = 40
                .Caption          = ""
                .FontName         = "Comic Sans MS"
                .FontSize         = 8
                .FontBold         = .T.
                .FontItalic       = .T.
                .WordWrap         = .T.
                .MousePointer     = 15
                .ForeColor        = RGB(90, 90, 90)
                .BackColor        = RGB(255, 255, 255)
                .Themes           = .T.
                .Picture          = gc_4c_CaminhoIcones + "onebit_33.ico"
                .DisabledPicture  = gc_4c_CaminhoIcones + "onebit_33.ico"
                .ToolTipText      = "Desmarca tudo"
                .Visible          = .T.
            ENDWITH

            *-- ok - encerra o dialogo devolvendo o controle ao form pai.
            *-- Cancel = .T. transcrito do dump: ESC aciona este botao (eh a
            *-- UNICA saida da tela, que nao tem X nem barra de titulo -
            *-- ControlBox = .F. / Closable = .F. / TitleBar = 0).
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top              = 4
                .Left             = 723
                .Width            = 80
                .Height           = 100
                .Caption          = "\<Ok"
                .Cancel           = .T.
                .FontName         = "Comic Sans MS"
                .FontSize         = 8
                .FontBold         = .T.
                .FontItalic       = .T.
                .WordWrap         = .T.
                .MousePointer     = 15
                .ForeColor        = RGB(90, 90, 90)
                .BackColor        = RGB(255, 255, 255)
                .Themes           = .T.
                .Picture          = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture  = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Visible          = .T.
            ENDWITH

            *-- Handlers dos tres Click (PUBLIC - BINDEVENT falha em silencio
            *-- com metodo PROTECTED, regra CLAUDE.md #3).
            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
            BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnApagaClick")
            BINDEVENT(THIS.cmd_4c_Ok,      "Click", THIS, "BtnOkClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - aplica a superficie que o legado define em funcao
    * de Op_Escolha, no fim do Init:
    *
    *   ThisForm.SelTudo.Visible = (ThisForm.Op_Escolha = 'INSERIR')
    *   ThisForm.Apaga.Visible   = (ThisForm.Op_Escolha = 'INSERIR')
    *
    * ("ok" nao tem linha de Visible no legado - esta sempre visivel, por ser
    * a unica saida da tela.) Say_Procura/Get_Procura obedecem a MESMA
    * condicao e entram aqui junto com os dois controles, na fase do campo de
    * busca - por isso o PEMSTATUS: o metodo roda desde esta fase, quando
    * esses dois ainda nao existem.
    *
    * Chamado DEPOIS de TornarControlesVisiveis, que forca Visible = .T.
    * em cada controle criado por AddObject e apagaria estas regras.
    *
    * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
    * THIS.oForm.AjustarBotoesPorModo() de FORA da classe e PEMSTATUS nao
    * distingue escopo - com PROTECTED a chamada estoura em runtime com
    * "Property AJUSTARBOTOESPORMODO is not found" (regra CLAUDE.md #3).
    *
    * NOTA - o When dos dois botoes no legado eh
    * "Return Inlist(ThisForm.op_escolha, 'INSERIR', 'ALTERAR')", ou seja
    * Enabled. Ele NAO eh transcrito como .Enabled porque eh redundante por
    * construcao: o unico modo em que os botoes estao VISIVEIS ("INSERIR")
    * ja pertence a lista do Inlist, logo o When nunca recusa um botao que o
    * usuario possa ver. E setar Enabled = .F. nestes dois seria ativamente
    * nocivo - sao botoes icone-only (Caption = "") e, desabilitados, o VFP9
    * nao desenha o icone, deixando dois retangulos vazios na tela (regra
    * CLAUDE.md #25/Pattern #106).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lInserir

        loc_lInserir = (UPPER(ALLTRIM(THIS.this_cOpEscolha)) == "INSERIR")

        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Visible = loc_lInserir
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Visible = loc_lInserir
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c__Procura", 5)
            THIS.lbl_4c__Procura.Visible = loc_lInserir
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Procura", 5)
            THIS.txt_4c_Procura.Visible = loc_lInserir
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.Visible = .T.
        ENDIF

        *-- "PROCEDURE When / Return (ThisForm.Op_Escolha = 'INSERIR')" do
        *-- fwcheckbox1 da coluna de selecao: fora do modo INSERIR a celula
        *-- nao aceita marcacao. Aplicado como Column1.ReadOnly porque, em
        *-- VFP9, o ReadOnly da Column PROPAGA para o controle que ela
        *-- desenha - medido: Column1.ReadOnly = .T. deixa Check1.ReadOnly em
        *-- .T., e voltar a .F. destrava. Reproduz o When por PROPRIEDADE, e
        *-- nao por BINDEVENT("When"), porque BINDEVENT DESCARTA o retorno do
        *-- delegado: um When ligado por BINDEVENT nao recusa edicao nenhuma
        *-- (regra CLAUDE.md #3/#46). O gate equivalente em COMPORTAMENTO
        *-- continua dentro de GradeSelecaoInteractiveChangeExec, que eh o
        *-- caminho que de fato grava.
        *--
        *-- Column1.ReadOnly eh reaplicado a cada VincularGrade (via
        *-- VincularEventosGrade) porque o Grid.ReadOnly do topo daquele
        *-- metodo sobrescreve o das colunas.
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
                THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lInserir
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - carga da grade. Equivale ao trecho do Init legado que
    * monta TmpPends (Create Cursor + o SELECT em SigMvCab + o Scan que
    * resolve Origem/Destino e grava as linhas) e, no fim, liga a grade ao
    * cursor ("With ThisForm.Grade / .RecordSource = 'TmpPends' / ...").
    *
    * A montagem do cursor mora no BO (SigOpPdtBO.CarregarPendencias - PILAR
    * 3: o form nao emite SQL); aqui ficam a orquestracao, o rebind da grade
    * e o repintar.
    *
    * VincularGrade DEPOIS da carga eh OBRIGATORIO: o BO fecha e recria o
    * alias inteiro (USE IN + CREATE CURSOR), o que derruba RecordSource/
    * ControlSource e as larguras das colunas (Problema 48/regra #41).
    *
    * Retorno .F. equivale ao "Return 0" do Init legado (que abortava a
    * abertura da tela) - so acontece quando a consulta FOI tentada e falhou.
    *
    * Pulado (sem erro, devolvendo .T.) em modo de teste/validacao de UI, sem
    * gnConnHandle, ou quando crSigMvCab (cursor do FORM PAI, contrato de
    * abertura deste dialogo) nao esta aberto - nesses casos a grade fica
    * ligada ao cursor placeholder de GarantirCursorGrade e a tela abre
    * vazia, em vez de exibir erro de conexao num probe.
    *
    * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de FORA da classe (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_lSemConexao, loc_lModoValidacaoOuTeste, loc_oErro

        loc_lResultado = .F.

        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        *-- IF aninhado, nunca "TYPE(...) = N OR gnConnHandle <= 0": VFP9 nao
        *-- faz short-circuit em OR e avaliaria a comparacao mesmo com a
        *-- variavel inexistente.
        loc_lSemConexao = .T.
        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                loc_lSemConexao = .F.
            ENDIF
        ENDIF

        TRY
            IF loc_lModoValidacaoOuTeste OR loc_lSemConexao OR !USED("crSigMvCab")
                THIS.VincularGrade()
                THIS.RepintarGrade()
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.CarregarPendencias()
                    THIS.VincularGrade()
                    THIS.RepintarGrade()
                    loc_lResultado = .T.
                ELSE
                    *-- Equivale ao MessageBox('Favor Reinicializar o
                    *-- Processo!!!') + Return 0 do Init legado. A mensagem
                    *-- exata vem do BO (this_cMensagemErro).
                    MsgAviso(IIF(EMPTY(THIS.this_oBusinessObject.this_cMensagemErro), ;
                            "Favor Reinicializar o Processo!!!", ;
                            THIS.this_oBusinessObject.this_cMensagemErro), ;
                        "Falha na Conex" + CHR(227) + "o (Pend" + CHR(234) + "ncias)")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * RepintarGrade - "Go Top In <cursor>" + "<grid>.Refresh" do legado
    * ("ThisForm.Grade.Refresh" no fim de cada Click, e "ThisForm.Refresh" no
    * fim do Init). Popular o cursor NAO repinta a grade: sem este passo ela
    * fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela nao traz
    * dados") manda o diagnostico para SQL/permissao (regra CLAUDE.md #21).
    *
    * Metodo UNICO, chamado em TODO caminho que popula ou altera o cursor
    * (CarregarLista, BtnSelTudoClick, BtnApagaClick).
    *==========================================================================
    PROTECTED PROCEDURE RepintarGrade()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)

            IF !EMPTY(loc_cAlias)
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    GO TOP
                ENDIF
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em RepintarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick - PROCEDURE Click de SelTudo no legado:
    *
    *   Select TmpPends
    *   Scan For Not Flag
    *       Replace Flag With ThisForm.Marca(.t.)
    *   EndScan
    *   ThisForm.Grade.Refresh
    *
    * "Marca(.t.)" eh SigOpPdtBO.MarcarPendencia(.T.) - o .T. eh o
    * "llAutomatico" do legado, que SUPRIME os avisos de bloqueio (percorrendo
    * a lista inteira o usuario nao pode levar um modal por linha). Flag
    * recebe o RESULTADO: pendencia recusada continua desmarcada, exatamente
    * como no legado.
    *
    * O laco eh DO WHILE com RECNO/GOTO explicitos, e nao SCAN: MarcarPendencia
    * troca a area de trabalho corrente (abre cursores proprios de SigCdOpe/
    * SigMvCab), e um SCAN cujo corpo muda o SELECT aplicaria o SKIP no alias
    * errado.
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        LOCAL loc_cAlias, loc_nRec, loc_lMarcou, loc_lAlgumMarcou, loc_oErro

        loc_lAlgumMarcou = .F.

        TRY
            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)

            IF !EMPTY(loc_cAlias)
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    GO TOP

                    DO WHILE !EOF(loc_cAlias)
                        loc_nRec = RECNO(loc_cAlias)

                        IF !EVALUATE(loc_cAlias + ".Flag")
                            loc_lMarcou = THIS.this_oBusinessObject.MarcarPendencia(.T.)
                            REPLACE Flag WITH loc_lMarcou IN (loc_cAlias)

                            IF loc_lMarcou
                                loc_lAlgumMarcou = .T.
                            ENDIF
                        ENDIF

                        SELECT (loc_cAlias)
                        GOTO loc_nRec
                        SKIP 1
                    ENDDO

                    *-- Cauda do Marca() legado. O legado a executa a cada
                    *-- iteracao do "Scan For Not Flag"; aqui ela roda UMA vez
                    *-- no fim, com o mesmo resultado visivel (as tres
                    *-- descricoes sao sempre recalculadas de crSigMvCab, que
                    *-- no fim do laco ja tem o estado final) e sem repintar o
                    *-- form pai uma vez por linha.
                    IF loc_lAlgumMarcou
                        THIS.AtualizarFormPai()
                    ENDIF

                    THIS.RepintarGrade()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelTudoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnApagaClick - PROCEDURE Click de apaga no legado:
    *
    *   Select TmpPends
    *   Scan For Flag
    *       Replace Flag With .f.
    *       =ThisForm.Desmarca()
    *   EndScan
    *   ThisForm.Grade.Refresh
    *
    * Ordem TRANSCRITA: o legado limpa o Flag ANTES de chamar Desmarca()
    * (SigOpPdtBO.DesmarcarPendencia), e nao depende do retorno dela. Mesmo
    * laco explicito de BtnSelTudoClick, pelo mesmo motivo (o BO troca a area
    * de trabalho corrente).
    *==========================================================================
    PROCEDURE BtnApagaClick()
        LOCAL loc_cAlias, loc_nRec, loc_oErro

        TRY
            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)

            IF !EMPTY(loc_cAlias)
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    GO TOP

                    DO WHILE !EOF(loc_cAlias)
                        loc_nRec = RECNO(loc_cAlias)

                        IF EVALUATE(loc_cAlias + ".Flag")
                            REPLACE Flag WITH .F. IN (loc_cAlias)
                            THIS.this_oBusinessObject.DesmarcarPendencia()
                        ENDIF

                        SELECT (loc_cAlias)
                        GOTO loc_nRec
                        SKIP 1
                    ENDDO

                    THIS.RepintarGrade()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnOkClick - PROCEDURE Click de ok no legado:
    *
    *   ThisForm.ParentForm.Enabled = .t.
    *   ThisForm.Release
    *
    * Este dialogo DESABILITA o form pai enquanto esta aberto; reabilitar eh
    * pre-requisito para o usuario voltar a usar a tela de movimentacao.
    * THIS.Release() fica FORA do TRY para o dialogo fechar mesmo que
    * reabilitar o pai falhe - caso contrario o usuario ficaria preso numa
    * tela sem X e sem barra de titulo.
    *==========================================================================
    PROCEDURE BtnOkClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnOkClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *==========================================================================
    * GradeSelecaoInteractiveChange - "PROCEDURE InteractiveChange" de
    * SIGOPPDT.Grade.seleciona.fwcheckbox1, o evento que de fato VINCULA e
    * DESVINCULA a pendencia marcada:
    *
    *   =DoDefault()
    *   If Not This.Value
    *       ThisForm.Desmarca
    *   Else
    *       This.Value = ThisForm.Marca()
    *   EndIf
    *
    * Tres coisas que a transcricao precisa preservar:
    *
    *   - "=DoDefault()" significa que o toggle NATIVO do checkbox JA rodou
    *     quando este codigo comeca; "This.Value" eh o valor DEPOIS do
    *     clique, nao antes. Por isso o handler LE o estado em vez de
    *     alterna-lo.
    *   - "Marca()" sem argumento eh MarcarPendencia() sem argumento: o
    *     llAutomatico do legado fica .F. e os MsgAviso de bloqueio APARECEM
    *     (ao contrario do botao "Selecionar Tudo", que passa .T. para nao
    *     disparar um modal por linha). Em VFP9 parametro logico nao passado
    *     chega como .F., e o BO resolve com "(par_lAutomatico = .T.)" - logo
    *     a chamada sem argumento ja produz o default certo, sem PCOUNT.
    *   - "This.Value = ThisForm.Marca()" eh REVERSAO: pendencia recusada
    *     volta a desmarcada. Atribuir Check1.Value grava no cursor pelo
    *     ControlSource (medido no VFP9), que eh exatamente o efeito do
    *     legado.
    *
    * NAO chama RepintarGrade: aquele metodo faz "GO TOP" (fiel ao Init e aos
    * dois Click, que recarregam a lista inteira) e aqui isso JOGARIA O
    * CURSOR PARA A PRIMEIRA LINHA a cada marcacao - o usuario marca a linha
    * 5 e o foco salta para a 1. O legado tambem nao repinta neste evento: a
    * celula se redesenha sozinha pelo ControlSource.
    *
    * PUBLIC (sem PROTECTED): BINDEVENT com delegado PROTECTED ESTOURA
    * ("Property <X> is not found", medido) dentro do TRY de InicializarForm,
    * o que viraria "a tela nao abre" (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE GradeSelecaoInteractiveChange()
        IF THIS.this_lEmToggleSelecao
            RETURN
        ENDIF

        THIS.this_lEmToggleSelecao = .T.
        THIS.GradeSelecaoInteractiveChangeExec()
        THIS.this_lEmToggleSelecao = .F.
    ENDPROC

    *==========================================================================
    * GradeSelecaoInteractiveChangeExec - corpo de
    * GradeSelecaoInteractiveChange. Separado do wrapper para que os
    * early-exits (modo errado, cursor fechado, EOF) nao deixem
    * this_lEmToggleSelecao presa em .T. - regra CLAUDE.md #47.
    *
    * RECNO salvo e restaurado em volta das chamadas ao BO: MarcarPendencia e
    * DesmarcarPendencia abrem cursores proprios (SigCdOpe, SigMvCab) e TROCAM
    * a area de trabalho corrente. Sem repor alias e registro, a reversao de
    * Check1.Value escreveria o Flag na LINHA ERRADA - mesmo cuidado que os
    * lacos de BtnSelTudoClick/BtnApagaClick ja tomam.
    *==========================================================================
    PROTECTED PROCEDURE GradeSelecaoInteractiveChangeExec()
        LOCAL loc_cAlias, loc_oChk, loc_nRec, loc_lAceito, loc_lProsseguir, loc_oErro

        loc_lProsseguir = .T.

        TRY
            *-- O When do legado ("Return (ThisForm.Op_Escolha = 'INSERIR')")
            *-- repetido AQUI, e nao apenas como Column1.ReadOnly: BINDEVENT
            *-- descarta o retorno do delegado, entao o unico gate que de
            *-- fato impede a GRAVACAO eh este.
            IF UPPER(ALLTRIM(THIS.this_cOpEscolha)) != "INSERIR"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !PEMSTATUS(THIS.grd_4c_Dados.Column1, "Check1", 5)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)

                IF EMPTY(loc_cAlias)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED(loc_cAlias)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF(loc_cAlias)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_oChk = THIS.grd_4c_Dados.Column1.Check1

                SELECT (loc_cAlias)
                loc_nRec = RECNO(loc_cAlias)

                IF !loc_oChk.Value
                    *-- "If Not This.Value / ThisForm.Desmarca"
                    THIS.this_oBusinessObject.DesmarcarPendencia()
                    THIS.ReposicionarPendencia(loc_cAlias, loc_nRec)
                ELSE
                    *-- "Else / This.Value = ThisForm.Marca()" - a atribuicao
                    *-- do RETORNO eh a reversao: recusado volta a desmarcado.
                    loc_lAceito = THIS.this_oBusinessObject.MarcarPendencia()

                    *-- Reposicionar ANTES de tocar em Check1.Value: a
                    *-- atribuicao grava no cursor pelo ControlSource, e o BO
                    *-- acabou de mover a area de trabalho corrente.
                    THIS.ReposicionarPendencia(loc_cAlias, loc_nRec)

                    IF !loc_lAceito
                        loc_oChk.Value = .F.
                    ELSE
                        *-- Cauda do Marca() legado: so roda quando a
                        *-- pendencia foi ACEITA (o legado tambem nao chega
                        *-- la nos ramos que dao "Return .f.").
                        THIS.AtualizarFormPai()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em GradeSelecaoInteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ReposicionarPendencia - repoe o alias da grade como area de trabalho
    * corrente E o registro em que ele estava.
    *
    * MarcarPendencia e DesmarcarPendencia abrem cursores proprios (SigCdOpe,
    * SigMvCab) e portanto TROCAM a area de trabalho corrente; algumas
    * validacoes ainda navegam o proprio cursor de pendencias. Quem chama o
    * BO e depois mexe no cursor da grade - REPLACE, leitura de coluna ou
    * atribuicao a Check1.Value (que grava pelo ControlSource) - precisa
    * repor os dois, senao escreve na LINHA ERRADA sem erro nenhum.
    *
    * O BETWEEN eh necessario: nada garante que o registro ainda exista
    * depois de o BO rodar, e GOTO fora da faixa estoura ("Record is out of
    * range").
    *==========================================================================
    PROTECTED PROCEDURE ReposicionarPendencia(par_cAlias, par_nRecno)
        IF !USED(par_cAlias)
            RETURN
        ENDIF

        SELECT (par_cAlias)

        IF BETWEEN(par_nRecno, 1, RECCOUNT(par_cAlias))
            GOTO par_nRecno
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarFormPai - a CAUDA do PROCEDURE Marca() do legado, que a
    * migracao havia descartado:
    *
    *   Select crSigMvCab
    *   With ThisForm.ParentForm.Pagina.Dados
    *       ...CursorQuery('SigCdCli','crCli','IClis',crSigMvCab.ContaOs,'RClis')
    *       .Origem.get_dconta.Value      = crCli.RClis   (ou '')
    *       .Destino.get_dconta.Value     = crCli.RClis   (ou '')
    *       .Responsavel.get_dconta.Value = crCli.RClis   (ou '')
    *       .Refresh
    *   Endwith
    *
    * Marcar uma pendencia PUXA grupo e conta de origem, de destino e do
    * responsavel para o documento corrente (os "REPLACE ... IN crSigMvCab"
    * de SigOpPdtBO.MarcarPendencia) e resolve as tres razoes sociais em
    * SigCdCli (SigOpPdtBO.ObterDescricaoConta, que ja deixa o resultado em
    * this_cOrigemDesc/this_cDestinoDesc/this_cResponsavelDesc).
    *
    * No legado os campos Grupo/Conta do form PAI tem
    * ControlSource = "crSigMvCab.<coluna>", entao o ".Refresh" final ja os
    * repintava sozinho; so as tres DESCRICOES, que nao tem ControlSource,
    * precisavam de atribuicao explicita. No sistema novo o form pai NAO usa
    * ControlSource na pagina de Dados (carrega os campos por BOParaForm, a
    * partir das properties do BO dele), logo NADA se repinta sozinho: sem
    * esta chamada o usuario escolhe a pendencia, a origem/destino sao
    * gravadas no cursor e a tela de movimentacao continua exibindo os
    * valores ANTIGOS. E o efeito nao eh so visual - o Salvar seguinte leria
    * os campos velhos de volta pelo FormParaBO do pai e DESFARIA o que foi
    * puxado.
    *
    * Quem conhece o layout do pai eh o PAI (PILAR 3): este metodo so avisa,
    * entregando as tres descricoes; o form pai se repinta no proprio
    * AtualizarDadosPendencia (que tambem re-sincroniza o BO dele com as
    * colunas que o BO deste dialogo acabou de gravar em crSigMvCab).
    *
    * PEMSTATUS nos DOIS niveis porque (a) o harness de teste, o probe e o
    * ValidarUIFidelity instanciam este dialogo SEM pai (this_oFormPai =
    * .NULL.) e (b) pai sem o metodo nao pode derrubar a tela. O metodo do
    * pai TEM de ser PUBLIC - PEMSTATUS devolve .T. tambem para PROTECTED e
    * a chamada de fora estouraria "Property ... is not found" (regra
    * CLAUDE.md #3/#51).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarFormPai()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "AtualizarDadosPendencia", 5)
                    THIS.this_oFormPai.AtualizarDadosPendencia( ;
                        THIS.this_oBusinessObject.this_cOrigemDesc, ;
                        THIS.this_oBusinessObject.this_cDestinoDesc, ;
                        THIS.this_oBusinessObject.this_cResponsavelDesc)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AtualizarFormPai")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeColunaGotFocus - "PROCEDURE GotFocus / ThisForm.Grade.Seleciona.
    * fwcheckbox1.SetFocus", que o legado declara no Text1 de SEIS colunas de
    * consulta (empresa, operacao, data, Grupo, Conta e Column8): tentar
    * entrar em qualquer coluna que nao seja a de selecao devolve o foco a
    * coluna de selecao.
    *
    * Wrapper com guarda de reentrancia e corpo em FocarSelecaoGrade, mesmo
    * padrao de ValidarProcura: o handler MOVE o foco, e mover o foco dentro
    * da grade dispara GotFocus de outra celula. A flag eh liberada no
    * wrapper para que um early-exit do corpo nao a deixe presa (regra
    * CLAUDE.md #47).
    *
    * PUBLIC pelo mesmo motivo de GradeSelecaoInteractiveChange: BINDEVENT com
    * delegado PROTECTED estoura (regra CLAUDE.md #3) - e eh por isso que
    * FocarSelecaoGrade, que eh PROTECTED, NAO pode ser ligado diretamente.
    *==========================================================================
    PROCEDURE GradeColunaGotFocus()
        IF THIS.this_lEmFocoGrade
            RETURN
        ENDIF

        THIS.this_lEmFocoGrade = .T.
        THIS.FocarSelecaoGrade()
        THIS.this_lEmFocoGrade = .F.
    ENDPROC

    *==========================================================================
    * ValidarProcura - validacao do campo de busca por codigo (Get_Procura do
    * legado). Funil UNICO das DUAS regras que o legado escreve nesse campo,
    * ligado por BINDEVENT em "LostFocus" (ver ConfigurarCamposBusca):
    *
    *   PROCEDURE Valid                       PROCEDURE LostFocus
    *   If Not Empty(This.Value)              If (TmpPends.Numes == This.Value) ;
    *       Select TmpPends                      Or (This.Value = 0)
    *       Set Order To Numes                       ThisForm.Grade.Seleciona. ;
    *       Set Near On                                  fwcheckbox1.SetFocus
    *       Seek This.Value                   EndIf
    *       Set Near Off
    *       ThisForm.Refresh
    *       If (This.Value == TmpPends.Numes)
    *           This.Value = 0
    *       Else
    *           Return 0
    *       EndIf
    *   EndIf
    *
    * As duas moram no MESMO handler porque, no legado, o LostFocus so chega a
    * rodar quando o Valid NAO recusou o valor - o "Return 0" mantem o foco no
    * campo e aborta a saida. Dai o loc_lProsseguir: codigo inexistente para o
    * fluxo antes de chegar na parte do LostFocus.
    *
    * Este SEEK NAO eh lookup: ele posiciona o ponteiro DENTRO da propria
    * grade (cursor de pendencias, TAG Numes), sem consultar outra tabela - o
    * form legado nao tem lookup algum (zero fwBusca/sigacess/mAddColuna no
    * dump) e inventar um violaria o PILAR 1 e a regra "NUNCA inventar tabelas
    * de lookup que nao existem no original".
    *
    * PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com metodo
    * PROTECTED (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarProcura()
        *-- Guarda de reentrancia (regra CLAUDE.md #47): o corpo chama
        *-- SetFocus e mover o foco redispara LostFocus/GotFocus do proprio
        *-- campo. A flag eh ligada e liberada AQUI, no wrapper - o corpo fica
        *-- em ValidarProcuraExec para que nenhum caminho de saida dele possa
        *-- deixar a flag presa em .T. (o que mataria a validacao pelo resto
        *-- da vida do form).
        IF THIS.this_lEmValidacaoProcura
            RETURN
        ENDIF

        THIS.this_lEmValidacaoProcura = .T.
        THIS.ValidarProcuraExec()
        THIS.this_lEmValidacaoProcura = .F.
    ENDPROC

    *==========================================================================
    * ValidarProcuraExec - corpo de ValidarProcura (ver o cabecalho dela para
    * o codigo legado transcrito). Separado so para que a guarda de
    * reentrancia seja liberada pelo wrapper.
    *==========================================================================
    PROTECTED PROCEDURE ValidarProcuraExec()
        LOCAL loc_cAlias, loc_nProcurado, loc_lProsseguir, loc_oErro

        loc_lProsseguir = .T.

        TRY
            loc_cAlias     = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)
            loc_nProcurado = THIS.txt_4c_Procura.Value

            *-- O TextBox nasce com .Value = 0 (numerico, transcrito do dump),
            *-- mas Format = "K" nao impede que uma atribuicao externa deixe
            *-- Caractere ali - VARTYPE antes de comparar com numero, senao
            *-- "Operator/operand type mismatch".
            IF VARTYPE(loc_nProcurado) != "N"
                loc_nProcurado = VAL(TRANSFORM(loc_nProcurado))
            ENDIF

            *-- IF aninhado, nunca "EMPTY(x) OR !USED(x)": VFP9 nao faz
            *-- short-circuit em OR e avaliaria USED() com alias vazio.
            IF EMPTY(loc_cAlias)
                loc_lProsseguir = .F.
            ELSE
                IF !USED(loc_cAlias)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Transcricao do Valid legado.
            IF loc_lProsseguir AND !EMPTY(loc_nProcurado)
                SELECT (loc_cAlias)
                SET ORDER TO Numes
                SET NEAR ON
                SEEK loc_nProcurado
                SET NEAR OFF

                *-- "ThisForm.Refresh" do legado: REPINTA, sem mexer no
                *-- ponteiro. NAO chamar RepintarGrade aqui - o GO TOP dele
                *-- desfaria o posicionamento que o SEEK acabou de obter.
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF

                IF loc_nProcurado == EVALUATE(loc_cAlias + ".Numes")
                    *-- Achou exatamente: o legado ZERA o campo (a busca ja
                    *-- levou a grade ate a linha procurada).
                    THIS.txt_4c_Procura.Value = 0
                ELSE
                    *-- Equivalente ao "Return 0" do legado: codigo inexistente
                    *-- mantem o foco no campo, com o valor digitado A VISTA
                    *-- para correcao. this_nProcuraPendente devolve o valor no
                    *-- GotFocus, que senao o zeraria (When legado).
                    THIS.this_nProcuraPendente = loc_nProcurado

                    *-- IF THIS.Visible: SetFocus em controle de form que
                    *-- ainda nao foi exibido estoura em runtime, e a tela
                    *-- eh instanciada sem Show() por harness/probe e pelo
                    *-- ValidarUIFidelity. Em producao (depois do Show
                    *-- modal) a condicao eh sempre verdadeira, logo nao
                    *-- altera o comportamento observavel pelo usuario.
                    IF THIS.Visible
                        THIS.txt_4c_Procura.SetFocus()
                    ENDIF

                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Transcricao do LostFocus legado: busca resolvida (ou campo
            *-- vazio) devolve o foco a coluna de selecao da grade.
            IF loc_lProsseguir
                IF (EVALUATE(loc_cAlias + ".Numes") == THIS.txt_4c_Procura.Value) ;
                        OR (THIS.txt_4c_Procura.Value = 0)
                    THIS.FocarSelecaoGrade()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarProcura")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ProcuraGotFocus - "PROCEDURE When / This.Value = 0" de Get_Procura: o
    * campo nasce ZERADO a cada entrada. Ligado por BINDEVENT em "GotFocus"
    * porque o When do legado roda ao ENTRAR no campo e BINDEVENT de
    * "When"/"Valid" em TextBox nao dispara de forma confiavel (regra
    * CLAUDE.md #3/#35).
    *
    * EXCECAO - entrada FORCADA por codigo inexistente: ali ValidarProcura
    * devolveu o foco ao campo (equivalente ao "Return 0" do Valid) e o legado
    * NAO reavalia o When nesse retorno, logo o valor digitado continua a
    * vista para correcao. this_nProcuraPendente marca esse caso e o valor eh
    * devolvido em vez de zerado - sem isso o migrado apagaria o que o usuario
    * acabou de digitar, divergindo do legado.
    *
    * PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com metodo
    * PROTECTED (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ProcuraGotFocus()
        IF THIS.this_nProcuraPendente != 0
            THIS.txt_4c_Procura.Value  = THIS.this_nProcuraPendente
            THIS.this_nProcuraPendente = 0
        ELSE
            THIS.txt_4c_Procura.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * FocarSelecaoGrade - "ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus" do
    * legado, que aparece no LostFocus de Get_Procura e no GotFocus de TODA
    * coluna de consulta da grade (empresa/operacao/codigo/data/Grupo/Conta/
    * Column8): o foco sempre volta para a coluna de SELECAO, a unica
    * editavel da tela.
    *
    * Reproduzido com Grid.SetFocus() SEGUIDO de ActivateCell(<linha>, 1), e
    * nao com Check1.SetFocus() direto: SetFocus no controle de uma celula
    * que nao esta ativa estoura em runtime.
    *
    * ActivateCell eh OBRIGATORIO e nao decorativo. Grid.SetFocus() sozinho
    * ativa a celula CORRENTE, e a corrente nem sempre eh a da coluna 1:
    * quando este metodo roda a partir do GotFocus de uma coluna de consulta
    * (ver GradeColunaGotFocus), a coluna corrente eh justamente aquela de
    * onde o foco precisa SAIR - o foco ficaria la, e o unico freio contra a
    * cascata seria a guarda de reentrancia. Com ActivateCell o foco vai para
    * a coluna 1, que nao tem GotFocus ligado, e o ciclo se fecha por
    * ESTRUTURA. ActivateCell usa coordenadas RELATIVAS (linha visivel,
    * coluna visivel) e a coluna visivel 1 eh a Column1 porque nenhuma coluna
    * eh Movable (ver VincularGrade). Medido no VFP9: o metodo existe e nao
    * estoura nem em form ainda nao exibido.
    *
    * Guarda de Visible/Enabled: no legado estes caminhos so existem com a
    * grade na tela, e SetFocus em controle invisivel, desabilitado ou de um
    * form que ainda nao foi exibido (harness/probe e ValidarUIFidelity
    * instanciam sem Show()) dispara erro de runtime. Em producao, depois do
    * Show modal, as tres condicoes sao verdadeiras - a guarda nao altera o
    * comportamento observavel pelo usuario.
    *==========================================================================
    PROTECTED PROCEDURE FocarSelecaoGrade()
        LOCAL loc_oGrid, loc_nLinha, loc_oErro

        TRY
            IF THIS.Visible AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_oGrid = THIS.grd_4c_Dados

                IF loc_oGrid.Visible AND loc_oGrid.Enabled
                    loc_oGrid.SetFocus()

                    *-- RelativeRow eh 0 enquanto nenhuma celula foi ativada
                    *-- (grade recem-montada); ActivateCell exige linha >= 1.
                    loc_nLinha = MAX(loc_oGrid.RelativeRow, 1)
                    loc_oGrid.ActivateCell(loc_nLinha, 1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FocarSelecaoGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis todos os controles criados via
    * AddObject (que nascem com Visible = .F.), percorrendo Controls()
    * recursivamente e Pages() quando houver PageFrame (nao ha nesta tela,
    * mas o metodo fica generico para as fases seguintes). Padrao canonico
    * do projeto (FormCor.prg, Formsigopped.prg).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - equivale a "PROCEDURE Release" do legado (que so chamava
    * "ThisForm.poDataMgr.Release" + DoDefault). poDataMgr nao existe nesta
    * arquitetura (gnConnHandle eh compartilhado via config.prg, nao
    * instanciado por form) - nada a liberar alem do que FormBase.Destroy()
    * ja faz. DODEFAULT() OBRIGATORIO (regra CLAUDE.md Pattern #145 - sem
    * isso o menu do sistema encolhe visualmente apos fechar este dialogo).
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpPdtBO.prg):
*==============================================================================
* SigOpPdtBO.prg - Business Object para FormSigOpPdt (operacoes em aberto)
* Herda de BusinessBase
*
* Origem legado: tasks\task784\SigOpPdt.SCX (form SIGOPPDT, DataSession = 2,
* WindowType = 1 - dialogo MODAL aberto pela tela de movimentacao SigMvCab
* para marcar/desmarcar quais operacoes em aberto ficam vinculadas ao
* documento corrente).
*
* ATENCAO - ESTE DIALOGO NAO TEM TABELA PROPRIA NO SQL SERVER:
* o Init legado cria o cursor de exibicao TmpPends a partir de um SELECT em
* SigMvCab (armazenado em PendEest) e usa TRES cursores que pertencem ao
* FORM PAI (crSigMvCab, crLclMvItn, TmpOperacao - ver Init/Marca/Desmarca do
* dump legado). A gravacao da marcacao/desmarcacao eh um UPDATE direto em
* SigMvCab (coluna ChkSubn), nao um Inserir/Atualizar de registro proprio -
* por isso this_cTabela fica vazio (ver Init) e a persistencia real sera
* feita em metodos dedicados (fase 2), nao em Inserir()/Atualizar().
*
* Estrutura EXATA do cursor de exibicao (transcrita do Create Cursor legado):
*   TmpPends ( Flag l, Emps c(3), Dopes c(20), Numes n(6), MascNum c(6),
*              Datas t Null, TpFats c(3), Origem c(21), Destino c(21),
*              Valos n(12,2) )
*              Index on Emps + Dopes + Str(Numes, 6) Tag EmpDopNum
*              Index on Numes Tag Numes
*
* Chave de cada linha da grade (lcNivel no legado) = Emps + Dopes + Str(Numes,6),
* usada no WHERE EmpDopNums = '<lcNivel>' do UPDATE SigMvCab em Marca/Desmarca.
*
* Cursores do FORM PAI (SigMvCab), CONTRATO - nomes NAO renomeados:
*   crSigMvCab   - cabecalho do movimento corrente (Emps, Dopes, Numes,
*                  ContaOs, ContaDs, GrupoOs, GrupoDs, GrVends, Vends, Obses)
*   crLclMvItn   - cursor local de itens do movimento corrente
*   TmpOperacao  - cursor de controle (Codigos) com os niveis ja vinculados
*
* FASE 1/8: declaracao de TODAS as propriedades + Init.
* FASE 2/8: CarregarPendencias (reproduz o SELECT em SigMvCab + filtros de
* conta do Init legado), CarregarDoCursor (linha corrente -> propriedades),
* MarcarPendencia/DesmarcarPendencia (equivalentes a Marca/Desmarca) e
* ObterChavePrimaria. Inserir/Atualizar/ExecutarExclusao ficam com o default
* herdado - este dialogo nao insere nem exclui registro proprio nenhum.
*==============================================================================
DEFINE CLASS SigOpPdtBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da LINHA CORRENTE do cursor de exibicao (TmpPends), uma
    * para cada coluna da grade de 8 colunas do legado (seleciona, empresa,
    * operacao, codigo, data, Grupo=Origem, Conta=Destino, Column8=valor)
    *--------------------------------------------------------------------------
    this_lFlag     = .F.   && Flag      l       - pendencia esta marcada (vinculada)
    this_cEmps     = ""    && Emps      c(3)    - empresa do documento pendente
    this_cDopes    = ""    && Dopes     c(20)   - codigo da operacao (SigCdOpe.Dopes)
    this_nNumes    = 0     && Numes     n(6)    - numero do documento pendente
    this_cMascNum  = ""    && MascNum   c(6)    - numero do documento formatado p/ exibicao
    this_dDatas    = {}    && Datas     t       - data/hora do documento pendente
    this_cTpFats   = ""    && TpFats    c(3)    - tipo de fatura (nao exibido na grade,
                           && mas faz parte da estrutura do cursor legado)
    this_cOrigem   = ""    && Origem    c(21)   - "GrupoOs/ContaOs" resolvido no Init
    this_cDestino  = ""    && Destino   c(21)   - "GrupoDs/ContaDs" resolvido no Init
    this_nValos    = 0     && Valos     n(12,2) - valor do documento pendente

    *--------------------------------------------------------------------------
    * Variaveis de sessao do dialogo, calculadas UMA VEZ no Init legado a
    * partir de crSigMvCab.Dopes (consulta a SigCdOpe) e reaproveitadas
    * durante o ciclo de vida da tela - decidem como Origem/Destino sao
    * resolvidos e filtrados (equivalente a lcDopesNivel, lnPuxaOrigem,
    * lnPuxaDestino, lcNumeroNivel do Init; FixGOrigs/FixGDests/ConOSubs/
    * ConDSubs sao relidos em Marca a partir da operacao do documento
    * CORRENTE, mas com a MESMA semantica)
    *--------------------------------------------------------------------------
    this_cDopesNivel    = ""   && TempOpe.Nivels  - codigo de operacao "nivel" do documento
    this_cNumeroNivel   = ""   && Str(TempOpe.NDopes, 4) - numero sequencial da operacao nivel
    this_nPuxaOrigem    = 0    && TempOpe.ConOSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_nPuxaDestino   = 0    && TempOpe.ConDSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_lFixGOrigs     = .F.  && TempOpe.FixGOrigs - grupo de origem fixo (nao sobrescrever)
    this_lFixGDests     = .F.  && TempOpe.FixGDests - grupo de destino fixo (nao sobrescrever)

    *--------------------------------------------------------------------------
    * Escolha operacional herdada do form pai (ThisForm.Op_Escolha =
    * ThisForm.Parentform.pcEscolha no legado). Controla se o checkbox de
    * marcacao esta habilitado (When = Op_Escolha = 'INSERIR') e se os
    * botoes SelTudo/Apaga agem (When = Inlist(Op_Escolha,'INSERIR','ALTERAR')).
    *--------------------------------------------------------------------------
    this_cOpEscolha = ""

    *--------------------------------------------------------------------------
    * Descricoes resolvidas (SigCdCli.RClis) apos Marcar/Desmarcar uma
    * pendencia - equivalente ao bloco final de Marca() do legado que
    * preenchia ThisForm.ParentForm.Pagina.Dados.Origem/Destino/Responsavel.
    * get_dconta.Value. Aqui ficam disponiveis como SAIDA de dados para o
    * FORM repassar ao form pai (BO nunca toca em controle de outro form).
    *--------------------------------------------------------------------------
    this_cOrigemDesc      = ""
    this_cDestinoDesc     = ""
    this_cResponsavelDesc = ""

    *--------------------------------------------------------------------------
    * Cursores proprios deste dialogo (nomenclatura nova - PILAR 3)
    *--------------------------------------------------------------------------
    this_cCursorPendentes = "cursor_4c_Pendentes"  && migrado de TmpPends (grade)
    this_cCursorPendEest  = "cursor_4c_PendEest"   && migrado de PendEest (SELECT em SigMvCab)
    this_cCursorTempOpe   = "cursor_4c_TempOpe"    && migrado de TempOpe (lookup SigCdOpe)
    this_cCursorCli       = "cursor_4c_Cli"        && migrado de crCli (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Cursores do FORM PAI (SigMvCab) - CONTRATO, nomes do legado preservados
    * de proposito (ver cabecalho do arquivo). Este dialogo entra na data
    * session do form pai (par_nDataSession recebido pelo Form) e LE/ESCREVE
    * nesses cursores sem recria-los.
    *--------------------------------------------------------------------------
    this_cCursorSigMvCab    = "crSigMvCab"
    this_cCursorLclMvItn    = "crLclMvItn"
    this_cCursorTmpOperacao = "TmpOperacao"

    *--------------------------------------------------------------------------
    * Tabelas do SQL Server consultadas/atualizadas por este dialogo
    *--------------------------------------------------------------------------
    this_cTabelaSigMvCab = "SigMvCab"
    this_cTabelaSigCdOpe = "SigCdOpe"
    this_cTabelaSigMvItn = "SigMvItn"
    this_cTabelaSigCdCli = "SigCdCli"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * this_cTabela fica VAZIO de proposito: este dialogo nao persiste um
    * registro proprio (ver cabecalho) - a gravacao eh um UPDATE direto em
    * SigMvCab.ChkSubn, feito por metodo dedicado na fase 2. O campo chave
    * eh Numes, que eh o indice usado pelo legado para localizar a pendencia
    * ao digitar o numero no campo de procura (Get_Procura.Valid faz
    * Set Order To Numes / Seek This.Value em TmpPends).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Numes"

                *-- Estado inicial da linha corrente - zerado aqui (e nao so na
                *-- declaracao) para que reusar a mesma instancia do BO numa
                *-- segunda abertura do dialogo nunca exiba dados da anterior.
                THIS.this_lFlag     = .F.
                THIS.this_cEmps     = ""
                THIS.this_cDopes    = ""
                THIS.this_nNumes    = 0
                THIS.this_cMascNum  = ""
                THIS.this_dDatas    = {}
                THIS.this_cTpFats   = ""
                THIS.this_cOrigem   = ""
                THIS.this_cDestino  = ""
                THIS.this_nValos    = 0

                THIS.this_cDopesNivel  = ""
                THIS.this_cNumeroNivel = ""
                THIS.this_nPuxaOrigem  = 0
                THIS.this_nPuxaDestino = 0
                THIS.this_lFixGOrigs   = .F.
                THIS.this_lFixGDests   = .F.

                THIS.this_cOpEscolha = ""

                THIS.this_cOrigemDesc      = ""
                THIS.this_cDestinoDesc     = ""
                THIS.this_cResponsavelDesc = ""

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE de cursor_4c_Pendentes (o
    * cursor de exibicao, equivalente a TmpPends do legado) para as
    * propriedades this_* da linha. Chamado antes de Marcar/Desmarcar e pelo
    * Form sempre que precisar ler os dados da linha selecionada na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_lFlag    = Flag
                    THIS.this_cEmps    = TratarNulo(Emps, "")
                    THIS.this_cDopes   = TratarNulo(Dopes, "")
                    THIS.this_nNumes   = TratarNulo(Numes, 0)
                    THIS.this_cMascNum = TratarNulo(MascNum, "")
                    THIS.this_dDatas   = TratarNulo(Datas, {})
                    THIS.this_cTpFats  = TratarNulo(TpFats, "")
                    THIS.this_cOrigem  = TratarNulo(Origem, "")
                    THIS.this_cDestino = TratarNulo(Destino, "")
                    THIS.this_nValos   = TratarNulo(Valos, 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Monta a chave POSICIONAL EmpDopNums (Emps char(3)
    * + Dopes char(20) + Str(Numes,6) = 29 chars) da LINHA CORRENTE, a partir
    * das propriedades carregadas por CarregarDoCursor. PADR explicito em
    * cada parte (regra #42) - NUNCA ALLTRIM nas partes internas, senao a
    * chave nunca casa com SigMvCab.EmpDopNums.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Resolve a razao social (SigCdCli.RClis) de um
    * codigo de conta (IClis). Equivalente ao
    * "ThisForm.poDataMgr.CursorQuery('SigCdCli','crCli','IClis',<cod>,'RClis')
    * + If Not Eof('crCli') ... Else ''" repetido 3x no final de Marca().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterDescricaoConta(par_cCodigo)
        LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT RClis FROM " + THIS.this_cTabelaSigCdCli + ;
                           " WHERE IClis = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado > 0
                    IF !EOF("cursor_4c_Cli")
                        loc_cDescricao = TratarNulo(cursor_4c_Cli.RClis, "")
                    ENDIF
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPendencias - Monta cursor_4c_Pendentes (grade de exibicao,
    * equivalente a TmpPends) a partir do movimento corrente (crSigMvCab,
    * cursor do FORM PAI). Transcricao literal do PROCEDURE Init do legado
    * (a parte de montagem de dados - o restante do Init, que cria o
    * FormSigOpPdt e configura a grade, fica na FASE 3/Form).
    *
    * Pre-requisitos (contrato do form pai, ver cabecalho do arquivo):
    *   - crSigMvCab posicionado no documento corrente
    *   - TmpOperacao aberto (cursor de niveis ja vinculados)
    *
    * Retorno: .T. com cursor_4c_Pendentes populado (GO TOP); .F. em falha,
    * com this_cMensagemErro preenchido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPendencias()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_cDopesNivel, loc_cNumeroNivel, loc_nPuxaOrigem, loc_nPuxaDestino
        LOCAL loc_cEd1, loc_cEd2, loc_cOrigem, loc_cDestino, loc_lFlag, loc_nNivelAtual

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursor de controle do movimento (TmpOperacao) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_Pendentes")
                    USE IN cursor_4c_Pendentes
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Pendentes ;
                    (Flag L, Emps C(3), Dopes C(20), Numes N(6), MascNum C(6), ;
                     Datas T, TpFats C(3), Origem C(21), Destino C(21), Valos N(12,2))
                SET NULL OFF
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON Numes TAG Numes

                SELECT TmpOperacao
                DELETE ALL FOR EMPTY(Codigos)

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT Nivels, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cDopesNivel  = TratarNulo(cursor_4c_TempOpe.Nivels, "")
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(loc_cDopesNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cNumeroNivel = STR(TratarNulo(cursor_4c_TempOpe.NDopes, 0), 4)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cEd1 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(0, 6)
                loc_cEd2 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(999999, 6)

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT Emps, Dopes, Numes, MascNum, Datas, Valos, ChkSubn, GrupoOs, GrupoDs, ContaOs, ContaDs" + ;
                           " FROM " + THIS.this_cTabelaSigMvCab + ;
                           " WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_PendEest
                SCAN
                    loc_nNivelAtual = VAL(loc_cNumeroNivel + TRANSFORM(cursor_4c_PendEest.Numes, "@L 999999"))

                    IF cursor_4c_PendEest.ChkSubn AND !SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")
                        LOOP
                    ENDIF

                    loc_cOrigem  = ""
                    loc_cDestino = ""

                    IF INLIST(loc_nPuxaOrigem, 1, 2)
                        IF loc_nPuxaOrigem = 1
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                    ENDIF

                    IF INLIST(loc_nPuxaDestino, 1, 2)
                        IF loc_nPuxaDestino = 1
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                    ENDIF

                    loc_lFlag = SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")

                    INSERT INTO cursor_4c_Pendentes (Flag, Emps, Dopes, Numes, MascNum, Datas, Origem, Destino, Valos) ;
                        VALUES (loc_lFlag, cursor_4c_PendEest.Emps, cursor_4c_PendEest.Dopes, cursor_4c_PendEest.Numes, ;
                                cursor_4c_PendEest.MascNum, cursor_4c_PendEest.Datas, loc_cOrigem, loc_cDestino, ;
                                cursor_4c_PendEest.Valos)
                ENDSCAN

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                SELECT cursor_4c_Pendentes
                GO TOP

                THIS.this_cDopesNivel  = loc_cDopesNivel
                THIS.this_cNumeroNivel = loc_cNumeroNivel
                THIS.this_nPuxaOrigem  = loc_nPuxaOrigem
                THIS.this_nPuxaDestino = loc_nPuxaDestino

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarPendencia - vincula a pendencia CORRENTE de cursor_4c_Pendentes
    * ao documento corrente (crSigMvCab), gravando o vinculo em
    * SigMvCab.ChkSubn. Equivalente ao PROCEDURE Marca() do legado - esta EH
    * a persistencia real deste dialogo (ver cabecalho do arquivo: nao ha
    * Inserir()/Atualizar() de registro proprio porque o dado gravado
    * pertence a SigMvCab, nao a uma tabela deste BO).
    *
    * par_lAutomatico (.T./.F.) suprime os MsgAviso de bloqueio - equivalente
    * a "llAutomatico" do legado, usado pelo botao "Selecionar Tudo".
    *
    * Apos marcar com sucesso, this_cOrigemDesc/this_cDestinoDesc/
    * this_cResponsavelDesc ficam com a razao social resolvida (SigCdCli)
    * das contas de Origem/Destino/Responsavel de crSigMvCab, para o FORM
    * repassar aos controles do form pai.
    *
    * Retorno: .T. se marcou com sucesso; .F. se bloqueado ou se falhou a
    * gravacao (mensagem em this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarPendencia(par_lAutomatico)
        LOCAL loc_lResultado, loc_lProsseguir, loc_lAutomatico
        LOCAL loc_cNivel, loc_nNumNivel, loc_cSQL, loc_nResultado
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_lFixGOrigs, loc_lFixGDests
        LOCAL loc_nItens

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_lAutomatico = (par_lAutomatico = .T.)
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crLclMvItn") OR !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursores do movimento corrente (crLclMvItn/TmpOperacao) nao estao abertos."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                    IF !loc_lAutomatico
                        MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Digitada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    THIS.this_cMensagemErro = "Movimentacao ja digitada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT FixGDests, FixGOrigs, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    loc_lFixGOrigs   = cursor_4c_TempOpe.FixGOrigs
                    loc_lFixGDests   = cursor_4c_TempOpe.FixGDests
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT ChkSubn, Obses, GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends FROM " + ;
                           THIS.this_cTabelaSigMvCab + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                DO CASE
                    CASE cursor_4c_PendEest.ChkSubn
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Utilizada Em Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao ja utilizada em outra operacao."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaDs) AND cursor_4c_PendEest.ContaDs <> crSigMvCab.ContaDs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaOs) AND cursor_4c_PendEest.ContaOs <> crSigMvCab.ContaOs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.
                ENDCASE
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 1, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crLclMvItn
                DELETE ALL FOR EMPTY(Cpros)
                GO BOTTOM

                SELECT TmpOperacao
                INSERT INTO TmpOperacao (Codigos) VALUES (loc_nNumNivel)

                IF EMPTY(crSigMvCab.Obses)
                    REPLACE Obses WITH cursor_4c_PendEest.Obses IN crSigMvCab
                ENDIF

                IF INLIST(loc_nPuxaOrigem, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoOs) OR (EMPTY(crSigMvCab.ContaOs) AND !loc_lFixGOrigs)
                        REPLACE GrupoOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaOs)
                        REPLACE ContaOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF INLIST(loc_nPuxaDestino, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoDs) OR (EMPTY(crSigMvCab.ContaDs) AND !loc_lFixGDests)
                        REPLACE GrupoDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaDs)
                        REPLACE ContaDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF EMPTY(crSigMvCab.GrVends)
                    REPLACE GrVends WITH cursor_4c_PendEest.GrVends IN crSigMvCab
                ENDIF
                IF EMPTY(crSigMvCab.Vends)
                    IF crSigMvCab.GrVends = cursor_4c_PendEest.GrVends
                        REPLACE Vends WITH cursor_4c_PendEest.Vends IN crSigMvCab
                    ENDIF
                ENDIF

                USE IN cursor_4c_PendEest

                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                loc_cSQL = "SELECT * FROM " + THIS.this_cTabelaSigMvItn + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

                IF loc_nResultado >= 0
                    SELECT cursor_4c_Itens
                    SCAN
                        SCATTER MEMVAR MEMO
                        INSERT INTO crLclMvItn FROM MEMVAR
                    ENDSCAN

                    IF USED("cursor_4c_Itens")
                        USE IN cursor_4c_Itens
                    ENDIF
                ENDIF

                loc_nItens = 0
                SELECT crLclMvItn
                SET ORDER TO
                SCAN
                    IF EMPTY(Cpros)
                        LOOP
                    ENDIF
                    loc_nItens = loc_nItens + 1
                    REPLACE cItens WITH loc_nItens
                ENDSCAN

                GO TOP
                IF EOF()
                    INSERT INTO crLclMvItn (Emps, Dopes, Numes, cItens) ;
                        VALUES (crSigMvCab.Emps, crSigMvCab.Dopes, crSigMvCab.Numes, loc_nItens + 1)
                ENDIF
                SET ORDER TO

                THIS.this_cOrigemDesc      = THIS.ObterDescricaoConta(crSigMvCab.ContaOs)
                THIS.this_cDestinoDesc     = THIS.ObterDescricaoConta(crSigMvCab.ContaDs)
                THIS.this_cResponsavelDesc = THIS.ObterDescricaoConta(crSigMvCab.Vends)

                THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_cTabela = ""

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarPendencia - desfaz o vinculo da pendencia CORRENTE de
    * cursor_4c_Pendentes com o documento corrente (crSigMvCab), gravando
    * SigMvCab.ChkSubn = 0. Equivalente ao PROCEDURE Desmarca() do legado.
    *
    * Retorno: .T. se desvinculou com sucesso; .F. em falha (mensagem em
    * this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarPendencia()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cNivel, loc_nNumNivel
        LOCAL loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("crLclMvItn")
                    SELECT crLclMvItn
                    DELETE ALL FOR Dopes + STR(Numes, 6) = THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                ENDIF

                IF USED("TmpOperacao")
                    IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                        SELECT TmpOperacao
                        DELETE
                    ENDIF
                ENDIF

                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 0, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                    THIS.RegistrarAuditoria("UPDATE")
                    THIS.this_cTabela = ""

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir/Atualizar/ExecutarExclusao - PROPOSITALMENTE nao sobrescritos.
    *
    * Este dialogo nao grava um registro proprio (ver cabecalho do arquivo
    * e comentario do Init): a gravacao real e o UPDATE SigMvCab.ChkSubn,
    * feito por MarcarPendencia()/DesmarcarPendencia() acima - que SAO, na
    * pratica, o Inserir()/Atualizar() desta tela. O comportamento padrao
    * herdado de BusinessBase (recusar a operacao) ja eh o correto para
    * estes tres metodos.
    *--------------------------------------------------------------------------

ENDDEFINE


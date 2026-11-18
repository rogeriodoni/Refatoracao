# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigopspr
Erro: Variable 'LOC_OCONTROL' is not found.


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigopspr
Erro: Variable 'LOC_OCONTROL' is not found.


### LOG DA ETAPA (06_testForm):
[2026-11-17 21:51:20] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-17 21:51:20] [INFO] Config FPW: (nao fornecido)
[2026-11-17 21:51:21] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-17 21:51:21] [INFO] Timeout: 300 segundos
[2026-11-17 21:51:21] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_310uk1it.prg
[2026-11-17 21:51:21] [INFO] Conteudo do wrapper:
[2026-11-17 21:51:21] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpSpr', 'C:\4c\tasks\task805\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpSpr', 'C:\4c\tasks\task805\logs\06_testForm.log'
QUIT

[2026-11-17 21:51:21] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_310uk1it.prg
[2026-11-17 21:51:21] [INFO] VFP output esperado em: C:\4c\tasks\task805\vfp_output.txt
[2026-11-17 21:51:21] [INFO] Executando Visual FoxPro 9...
[2026-11-17 21:51:21] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_310uk1it.prg
[2026-11-17 21:51:21] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_310uk1it.prg
[2026-11-17 21:51:21] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpSpr
Inicio: 17/11/2026 21:51:21

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 17/11/2026 21:51:41
Duracao: 20 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-17 21:51:41] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-17 21:51:41] [INFO] VFP9 finalizado em 20.8279158 segundos
[2026-11-17 21:51:41] [INFO] Exit Code: 
[2026-11-17 21:51:41] [INFO] 
[2026-11-17 21:51:41] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-17 21:51:41] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_310uk1it.prg
[2026-11-17 21:51:41] [INFO] 
[2026-11-17 21:51:41] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-17 21:51:41] [INFO] * Auto-generated wrapper for parameters
[2026-11-17 21:51:41] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-17 21:51:41] [INFO] * Parameters: 'FormSigOpSpr', 'C:\4c\tasks\task805\logs\06_testForm.log'
[2026-11-17 21:51:41] [INFO] 
[2026-11-17 21:51:41] [INFO] * Anti-dialog protections for unattended execution
[2026-11-17 21:51:41] [INFO] SET SAFETY OFF
[2026-11-17 21:51:41] [INFO] SET RESOURCE OFF
[2026-11-17 21:51:41] [INFO] SET TALK OFF
[2026-11-17 21:51:41] [INFO] SET NOTIFY OFF
[2026-11-17 21:51:41] [INFO] SYS(2335, 0)
[2026-11-17 21:51:41] [INFO] 
[2026-11-17 21:51:41] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpSpr', 'C:\4c\tasks\task805\logs\06_testForm.log'
[2026-11-17 21:51:41] [INFO] QUIT
[2026-11-17 21:51:41] [INFO] 
[2026-11-17 21:51:41] [INFO] === Fim do Wrapper.prg ===
[2026-11-17 21:51:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.prg):
*==============================================================================
* FORMSIGOPSPR.PRG - Formulario Operacional: Selecionar Produtos (dialogo filho)
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SigOpSpr.SCX (task805)
*
* Pilares:
*   UX   -> layout identico ao legado (800x600, TitleBar=0, ControlBox=.F.,
*           Movable=.F., ClipControls=.F., cabecalho cinza no topo com o
*           Caption "Selecionar Produtos")
*   BD   -> SigCdPro/SigMvItn/SigMvEst/SigPrIvl (consulta, via SigOpSprBO);
*           a gravacao real acontece no cursor LOCAL do form PAI
*           (cursor_4c_Produtos, equivalente a crProdutos), nunca no SQL
*           Server por este dialogo
*   CODE -> arquitetura em camadas (FormBase / SigOpSprBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que o form pai (ex.: SIGCDBAL - Balanco) abre para o
*   usuario montar a lista de produtos de um cursor local do PAI
*   (crProdutos). O legado recebe "poForm" no Init, migra para a
*   DataSession do pai (Set DataSession To poForm.DataSessionId) e
*   manipula esse cursor direto - no migrado o form roda com
*   DataSession = 1 (sessao CORRENTE, compartilhada com o pai), que
*   reproduz o MESMO efeito sem a troca manual de sessao (padrao ja
*   adotado em FormSigOpSlc.prg).
*
*   O usuario pode (fases futuras):
*     1) Inserir/Excluir linhas na grade e digitar o produto (lookup em
*        SigCdPro por CPros ou DPros - fwBuscaExt do legado);
*     2) Processar em LOTE (tres botoes, so visiveis quando o pai esta
*        em INSERIR/ALTERAR e, para os dois ultimos, quando o pai eh o
*        SIGCDBAL): "Produtos com Mov." (SigMvItn), "Produtos nao Inv."
*        (SigMvEst com SQtds <> 0) e "Todos nao Inv." (SigCdPro) - os
*        tres excluem o que ja foi inventariado em SigPrIvl desde a data
*        de corte (Date() - Dias) e aplicam as faixas de filtro herdadas
*        do pai (loFil: Mercs/CGrus/SGrus/Colecoes/Linhas/IFors).
*
* CHAMADA (equivale ao "Do Form SigOpSpr With ThisForm" do legado, onde
* o proprio form pai eh "poForm"):
*   loForm = CREATEOBJECT("FormSigOpSpr", THISFORM)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (btnSair.Click -
*   fase 7), nao do chamador. O resultado fica inteiramente no cursor
*   local do pai (cursor_4c_Produtos) - nao ha propriedade de retorno
*   como MoedaMaior/CanceladoExterno em FormSigOpSlc.prg.
*
* PARAMETRO (legado: LParameters poForm)
*   par_oFormPai - legado: poForm/ThisForm.ParentForm (RESERVED3/ClassInfo
*                  do SCX cita "parentform" e "podatamgr" como properties
*                  customizadas do form). O form pai precisa expor:
*                    .pcEscolha      - INSERIR/ALTERAR/PROCURAR (visibilidade)
*                    .Name           - usado em UPPER(.Name) = "SIGCDBAL"
*                    .DataSessionId  - legado: Set DataSession To
*                    .loFil.<Faixa>I/F - filtros herdados (fase 4+)
*                    .poDataMgr      - conexao/SqlExecute do pai (fase 6+)
*
* FASE 3: estrutura base do form - DEFINE CLASS com as
* propriedades visuais transcritas do SCX, a propriedade de estado
* this_oFormPai (espelho do poForm/ParentForm do Init legado), Init com o
* parametro, ValidarParametros, InicializarForm, CarregarContextoFormPai
* (migra o contexto do pai para o BO, equivalente a "Set DataSession To
* poForm.DataSessionId" + leitura de pcEscolha/Name/loFil), ConfigurarDecoracao
* (Picture), ConfigurarCabecalho (cntSombra), TornarControlesVisiveis e
* Destroy (reabilita o form pai - legado: .ParentForm.Enabled = .f. no
* Init / = .t. no btnSair.Click; aqui a reabilitacao tambem fica como
* rede de seguranca no Destroy).
*
* FASE 4 (esta fase): grdProdutos -> grd_4c_Dados (ConfigurarGrade +
* AplicarFormatoGrade), os CommandGroup cmg_4c_CmdEscolha (Inserir/
* Excluir) e cmg_4c_CmdSalva (Encerrar) com as barrinhas img_4c_ImgBarra1/
* img_4c_ImgBarra2 (ConfigurarBotoesAcao), a visibilidade condicional de
* cmdEscolha (AplicarVisibilidadePorContexto) e o FUNIL de carga da grade
* (CarregarDados + GarantirLinhaEmBranco), que transcreve o bloco do Init
* legado: Go Top + RecordSource/ControlSource + linha em branco no fim +
* Refresh. Os botoes sao criados DEPOIS do cabecalho (regra #11 do
* CLAUDE.md: cmdEscolha/cmdSalva/cmdProcessar ficam em Top = -1..84,
* dentro da faixa Top 0..80, e tem de ser criados depois dela para
* desenhar por cima). Os Click dos botoes sao da fase 7.
*
* FASE 5 (esta fase): cmg_4c_CmdProcessar (3 botoes de lote - btnEstI/
* btnEst/btnGeral), txt_4c_Dias/lbl_4c_LblDias (getDias/lblDias) e
* cnt_4c_CnpProcessando ("Selecionando Produtos..." - legado posiciona em
* Top = 500 ao final do Init, nao no Top = 300 do dump; NAO eh um toggle
* de Visible (fica sempre Visible = .T.) e por isso nao entra no filtro de
* TornarControlesVisiveis - so sobe para Top = 120 durante o processamento,
* fase 8). Tambem a visibilidade condicional do Init legado que faltava
* (cmdProcessar/lblDias/getDias.Visible = InList(pcEscolha,INSERIR,ALTERAR)
* And Upper(ParentForm.Name) = "SIGCDBAL"), calculada a partir do contexto
* ja carregado em CarregarContextoFormPai (fase 3).
*
* FASE 6: lookup de produto nas duas colunas da grade (Column1/
* Column2.Text1.Valid do legado - fwBuscaExt por CPros/DPros), nas celulas
* TextBoxCelulaSpr_4c instaladas por InstalarCelulasLookup. O bind do grid
* ao cursor_4c_Produtos ja havia sido entregue na fase 4 (CarregarDados).
*
* FASE 7 (esta fase): Click dos CommandGroup criados na fase 4 -
* btnInserir/btnExcluir (cmg_4c_CmdEscolha) e btnSair (cmg_4c_CmdSalva).
* Os Buttons(N) mantem o nome default do VFP, entao o Click deles so
* dispara por BINDEVENT (ConfigurarEventosBotoes). Entregues:
* BtnInserirClick (reusa PosicionarProximaLinha, da fase 6 - o bloco
* "Select LocalBrancos -> Locate / Append Blank" do legado),
* BtnExcluirClick (Delete + Skip/Skip -1 na linha corrente),
* RemoverLinhasEmBranco (o "Delete From crProdutos Where Empty(CPros)",
* que o Click de cmdProcessar tambem usa) e BtnEncerrarClick (limpa as
* linhas em branco, reabilita o form pai e fecha o dialogo), mais a cauda
* comum FocarGradeProdutos (Column1.SetFocus + Refresh).
*
* FASE 8 (esta fase): Click de cmg_4c_CmdProcessar (os 3 botoes de lote -
* BtnProcessarLoteClick), unico "PROCEDURE Click" do CommandGroup no
* legado, despachado por This.Value (1/2/3), diferente do par
* btnInserir/btnExcluir de cmg_4c_CmdEscolha (fase 7), que tem um Click por
* botao. Usa THIS.this_oBusinessObject.ObterProdutosEmLote (ja
* implementado no BO) e faz o SCAN + Insert no cursor_4c_Produtos do pai
* aqui no Form, que eh manipulacao de cursor VFP (ver cabecalho de
* SigOpSprBO.prg). Esta eh a FASE FINAL do form - nao ha metodos
* "BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
* CarregarLista" porque este dialogo nao eh CRUD (nao tem entidade propria
* para persistir nem modos Incluir/Alterar/Visualizar): toda a gravacao
* final eh do form PAI, no cursor local que ele mesmo abriu antes do
* "Do Form SigOpSpr With ThisForm". Os equivalentes deste dialogo sao:
* BtnEncerrarClick (saida/"confirmar", fase 7), BtnInserirClick/
* BtnExcluirClick (edicao de linha, fase 7) e CarregarDados (funil de
* carga da grade, fase 4).
*==============================================================================

DEFINE CLASS FormSigOpSpr AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *==========================================================================

    *-- SIGOPSPR: Height = 600 / Width = 800
    this_cMensagemErro = ""
    Height       = 600
    Width        = 800

    *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. / ShowTips = .T.
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.

    *-- Caption = "Selecionar Produtos" no SCX legado. O Init legado copia
    *-- ThisForm.Caption para os dois labels do cabecalho (transcrito em
    *-- ConfigurarCabecalho, abaixo)
    Caption      = "Selecionar Produtos"

    *-- TitleBar = 0 / ControlBox = .F. (legado) -> Closable/MaxButton/
    *-- MinButton = .F. (padrao do projeto para dialogo sem chrome, ja
    *-- usado em FormSigOpSlc.prg) / Movable = .F. / ClipControls = .F. -
    *-- as seis sao declaradas no SCX (Movable/ClipControls/TitleBar
    *-- literais, ControlBox cobre Closable/MaxButton/MinButton). Sem
    *-- barra de titulo e sem ControlBox, a unica saida eh pelo botao
    *-- Encerrar (fase 7)
    TitleBar     = 0
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.

    *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
    *-- Show() bloqueie ate o usuario Encerrar (legado: .ParentForm.Enabled
    *-- = .f. enquanto este form esta aberto, emulando modalidade)
    WindowType   = 1
    WindowState  = 0

    *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
    ShowWindow   = 1

    *-- Fonte base do Framework legado. Os controles do corpo declaram a
    *-- propria fonte no SCX (Tahoma 18 no cabecalho, Tahoma 8 nos demais)
    *-- e serao transcritos nas fases seguintes
    FontName     = "Tahoma"
    FontSize     = 8

    *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
    *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
    *-- DataSession To poForm.DataSessionId", ou seja: na pratica este
    *-- dialogo roda SEMPRE na sessao do form pai, para enxergar o cursor
    *-- local dele (crProdutos / cursor_4c_Produtos). DataSession = 1 eh a
    *-- reproducao direta desse resultado, sem a troca manual de sessao -
    *-- mesmo padrao adotado em FormSigOpSlc.prg
    DataSession  = 1

    *==========================================================================
    * PROPRIEDADE DE ESTADO - espelha o LParameters do Init legado
    *==========================================================================

    *-- this_oFormPai -> poForm / ThisForm.ParentForm do legado (RESERVED3/
    *-- ClassInfo do SCX = "parentform"): o form que abriu este dialogo e
    *-- que possui o cursor local cursor_4c_Produtos (crProdutos), o
    *-- contexto pcEscolha/Name/loFil e a conexao poDataMgr (fases futuras)
    this_oFormPai = .NULL.

    *-- NAO ha flag this_lEmLookup aqui, e eh de proposito. A guarda de
    *-- reentrancia da regra #47 existe para lookup ligado a LostFocus, que
    *-- o Show() MODAL do picker redispara. Estas celulas usam Valid (regra
    *-- #46), que o VFP9 nao re-entra enquanto ja esta executando, e o
    *-- contrato do FormBuscaAuxiliar (regra #37) fecha o unico caminho de
    *-- picker duplo: resolvido o codigo, a passagem seguinte pelo Valid
    *-- acha 1 registro no match exato, marca this_lAchouRegistro e NAO
    *-- mostra o dialogo. Uma flag aqui seria pior que a ausencia dela: sem
    *-- TRY em volta do Show() (regra #29 - TRY em volta de Show modal
    *-- derruba a tela a cada erro de runtime) nao ha como garantir o clear,
    *-- e flag travada MATA o lookup pelo resto da vida do form. Mesma
    *-- escolha das duas implementacoes de referencia do projeto
    *-- (TextBoxCelulaSno_4c/FormSigOpSno e FormLpr).

    *==========================================================================
    * Init - LParameters poForm do legado
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_oFormPai

        *-- Legado: ThisForm.ParentForm = _Parent (poForm)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
    * cursor_4c_Produtos para editar, nem contexto (pcEscolha/Name/loFil)
    * para decidir o que fica visivel - o legado tambem depende dessa
    * referencia (ThisForm.ParentForm.* em praticamente todo metodo).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
    * bypass a instanciacao reprovaria sempre.
    *
    * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
    * bloco algum.
    *==========================================================================
    PROCEDURE ValidarParametros
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) != "O"
            MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir de " + ;
                    "outro formul" + CHR(225) + "rio.", ;
                    "Selecionar Produtos")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - estrutura base do dialogo
    *
    * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
    * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
        *-- dentro de TRY/CATCH (regra #1)
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Business Object das Fases 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpSprBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigOpSprBO.", "Selecionar Produtos")
            ELSE
                *-- Legado: .ParentForm.Enabled = .f. (Init) - migra o
                *-- contexto do pai (pcEscolha/Name/loFil) para o BO
                THIS.CarregarContextoFormPai()

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form: os CommandGroup (fase 4+) ficam em
                *-- Top = -1..84, DENTRO da faixa (Top 0..80), e precisam
                *-- ser criados depois para desenhar por cima (regra #11)
                THIS.ConfigurarCabecalho()

                *-- Grade de produtos (grdProdutos do legado)
                THIS.ConfigurarGrade()

                *-- Inserir/Excluir (cmdEscolha) e Encerrar (cmdSalva). Vem
                *-- DEPOIS do cabecalho porque ficam em Top = -1..84, dentro
                *-- da faixa (Top 0..80), e precisam desenhar por cima dela
                THIS.ConfigurarBotoesAcao()

                *-- cmdProcessar (os 3 botoes de lote) - mesma razao do
                *-- ConfigurarBotoesAcao: Top = -1, dentro da faixa
                THIS.ConfigurarBotoesLote()

                *-- getDias/lblDias (parametro "Dias a Considerar")
                THIS.ConfigurarDias()

                *-- Container "Selecionando Produtos..." (cnpProcessando)
                THIS.ConfigurarProcessando()

                *-- Click dos botoes dos CommandGroup. Depois de todos os
                *-- AddObject, para os Buttons(N) existirem no momento do
                *-- BINDEVENT
                THIS.ConfigurarEventosBotoes()

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- Visibilidade condicional do Init legado - DEPOIS do
                *-- TornarControlesVisiveis, que forca Visible = .T. em tudo
                THIS.AplicarVisibilidadePorContexto()

                *-- Funil de carga: liga a grade ao cursor de produtos do
                *-- form pai e a repinta. Devolve .F. sem o cursor aberto
                *-- (caminho normal do harness), o que nao impede a abertura
                THIS.CarregarDados()

                *-- Legado: This.Refresh (equivalente ao fim do Init)
                THIS.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigOpSpr: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarContextoFormPai - migra para o BO o que o Init legado le do
    * form pai:
    *
    *     Set DataSession To poForm.DataSessionId   (ver nota de
    *                                                 DataSession = 1, acima)
    *     .ParentForm = poForm
    *     .ParentForm.Enabled = .f.
    *     <pcEscolha, Upper(Name), loFil.*>          (usados na fase 5 para
    *                                                 decidir visibilidade,
    *                                                 e na fase 8 para o
    *                                                 processamento em lote)
    *
    * Cada leitura eh protegida por PEMSTATUS/VARTYPE: em modo teste
    * (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL. ou um
    * stub sem essas properties, e a ausencia aqui NAO eh falha de
    * inicializacao (ValidarParametros ja fez o bypass acima).
    *==========================================================================
    PROTECTED PROCEDURE CarregarContextoFormPai
        LOCAL loc_oFil

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN
        ENDIF

        *-- Legado: .ParentForm.Enabled = .f. (reabilitado no Destroy -
        *-- rede de seguranca - e no btnSair.Click, fase 7)
        IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
            THIS.this_oFormPai.Enabled = .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            *-- Legado: InList(.ParentForm.pcEscolha, [INSERIR], [ALTERAR])
            IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5) AND ;
               VARTYPE(THIS.this_oFormPai.pcEscolha) = "C"
                .this_cEscolha = UPPER(ALLTRIM(THIS.this_oFormPai.pcEscolha))
            ENDIF

            *-- Legado: Upper(ParentForm.Name) = [SIGCDBAL]
            .this_cNomeFormPai = UPPER(ALLTRIM(THIS.this_oFormPai.Name))

            IF PEMSTATUS(THIS.this_oFormPai, "DataSessionId", 5) AND ;
               VARTYPE(THIS.this_oFormPai.DataSessionId) = "N"
                .this_nDataSessionPai = THIS.this_oFormPai.DataSessionId
            ENDIF

            *-- Legado: ThisForm.ParentForm.loFil.<Faixa>I/F (cmdProcessar.Click)
            IF PEMSTATUS(THIS.this_oFormPai, "loFil", 5) AND ;
               VARTYPE(THIS.this_oFormPai.loFil) = "O"
                loc_oFil = THIS.this_oFormPai.loFil

                IF VARTYPE(loc_oFil.MercsI) = "C"
                    .this_cMercsI = ALLTRIM(loc_oFil.MercsI)
                ENDIF
                IF VARTYPE(loc_oFil.MercsF) = "C"
                    .this_cMercsF = ALLTRIM(loc_oFil.MercsF)
                ENDIF
                IF VARTYPE(loc_oFil.CGrusI) = "C"
                    .this_cCGrusI = ALLTRIM(loc_oFil.CGrusI)
                ENDIF
                IF VARTYPE(loc_oFil.CGrusF) = "C"
                    .this_cCGrusF = ALLTRIM(loc_oFil.CGrusF)
                ENDIF
                IF VARTYPE(loc_oFil.SGrusI) = "C"
                    .this_cSGrusI = ALLTRIM(loc_oFil.SGrusI)
                ENDIF
                IF VARTYPE(loc_oFil.SGrusF) = "C"
                    .this_cSGrusF = ALLTRIM(loc_oFil.SGrusF)
                ENDIF
                IF VARTYPE(loc_oFil.ColecoesI) = "C"
                    .this_cColecoesI = ALLTRIM(loc_oFil.ColecoesI)
                ENDIF
                IF VARTYPE(loc_oFil.ColecoesF) = "C"
                    .this_cColecoesF = ALLTRIM(loc_oFil.ColecoesF)
                ENDIF
                IF VARTYPE(loc_oFil.LinhasI) = "C"
                    .this_cLinhasI = ALLTRIM(loc_oFil.LinhasI)
                ENDIF
                IF VARTYPE(loc_oFil.LinhasF) = "C"
                    .this_cLinhasF = ALLTRIM(loc_oFil.LinhasF)
                ENDIF
                IF VARTYPE(loc_oFil.IForsI) = "C"
                    .this_cIForsI = ALLTRIM(loc_oFil.IForsI)
                ENDIF
                IF VARTYPE(loc_oFil.IForsF) = "C"
                    .this_cIForsF = ALLTRIM(loc_oFil.IForsF)
                ENDIF
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
        LOCAL loc_cImagemFundo
        loc_cImagemFundo = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
            THIS.Picture = loc_cImagemFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Legado:
    *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Init legado sobrescreve os dois Caption com ThisForm.Caption
    * ("Selecionar Produtos"), por isso .Caption = THIS.Caption (dinamico),
    * nao o literal "Cadastro de Testes" que aparece no dump (esse literal
    * eh so o default do Form Designer, nunca chega a ser exibido).
    *
    * Width do container usa THIS.Width (canonico da faixa, regra #11) em
    * vez do literal 800 - sao o mesmo valor aqui, mas THIS.Width acompanha
    * o form se o layout mudar numa fase futura.
    *
    * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
    * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
    * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        *-- Container da faixa (cntSombra)
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

        *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
        *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
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
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
        *-- aqui porque o container eh OPACO e escuro (excecao prevista na
        *-- regra #12)
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
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - grdProdutos do legado -> grd_4c_Dados
    *
    * Transcricao do dump (SIGOPSPR.grdProdutos):
    *   ColumnCount=2  FontName="Tahoma"  DeleteMark=.F.  RecordMark=.F.
    *   HeaderHeight=17  RowHeight=17  ScrollBars=2  TabIndex=1
    *   Top=192  Left=190  Width=420  Height=309
    *   GridLineColor=238,238,238
    *
    * O grid NAO eh somente-leitura: o dump nao declara ReadOnly no Grid e
    * declara Column2.Text1.ReadOnly = .F. - esta eh a grade em que o
    * usuario DIGITA o produto (o lookup das duas colunas entra na fase 6).
    *
    * Aqui ficam SO as propriedades que NAO dependem de dado (regra #41):
    * geometria, ColumnCount, fontes e cores. Largura de coluna e caption de
    * cabecalho moram em AplicarFormatoGrade, que eh a FONTE UNICA desses
    * numeros e eh reusada pelo CarregarDados depois do RecordSource
    * (atribuir RecordSource zera Column.Width e Header1.Caption - Problema
    * 48 / regra #41).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount   = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .Top           = 192
            .Left          = 190
            .Width         = 420
            .Height        = 309
            .TabIndex      = 1
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Column.ReadOnly vai DEPOIS do Grid.ReadOnly (o do grid propaga
        *-- para as colunas e sobrescreveria o que viesse antes - regra #18)
        THIS.AplicarFormatoGrade()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA da geometria/decoracao das colunas
    *
    * Transcrito do dump:
    *   Column1  Width=108  Movable=.F.  Resizable=.F.  FontName="Tahoma"
    *            Header1: Tahoma 8, Alignment=2, Caption="Codigo",
    *                     ForeColor=36,84,155
    *            Text1:   Tahoma, BorderStyle=0, Margin=0,
    *                     ForeColor=0,0,0, BackColor=255,255,255
    *   Column2  Width=290  FontName="Tahoma"   (o dump NAO declara
    *            Movable/Resizable nesta coluna - ficam no default .T.)
    *            Header1: Tahoma 8, Alignment=2, Caption="Descricao",
    *                     ForeColor=36,84,155
    *            Text1:   Tahoma, BorderStyle=0, Margin=0, ReadOnly=.F.,
    *                     ForeColor=0,0,0, BackColor=255,255,255
    * Conferencia: 108 + 290 = 398, dentro dos Grid.Width = 420.
    *
    * Existe como metodo porque a grade eh formatada em DOIS momentos - na
    * montagem (ConfigurarGrade) e na recarga (CarregarDados, depois do
    * RecordSource). Com os dois chamando este metodo nao ha como os dois
    * lados divergirem em silencio.
    *
    * Metodo PUBLIC: o form pai pode reaplicar o formato depois de repopular
    * o proprio cursor de produtos.
    *==========================================================================
    PROCEDURE AplicarFormatoGrade
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            WITH THIS.grd_4c_Dados
                .Column1.Width             = 108
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.ReadOnly          = .F.
                .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.Width             = 290
                .Column2.FontName          = "Tahoma"
                .Column2.FontSize          = 8
                .Column2.ReadOnly          = .F.
                .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .F.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Celulas de lookup POR CIMA do Text1 de cada coluna. Fica no
            *-- fim deste metodo de proposito: o CurrentControl e o Sparse
            *-- tambem sao resetados pelo rebind do RecordSource, e como a
            *-- recarga (CarregarDados) passa por aqui, reaplicar junto com
            *-- Width/Caption garante que os dois lados nunca divirjam
            THIS.InstalarCelulasLookup()

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * InstalarCelulasLookup - poe as celulas de lookup (TextBoxCelulaSpr_4c)
    * por cima do Text1 das duas colunas da grade.
    *
    * Legado: o lookup mora no Valid de grdProdutos.Column1.Text1 (busca por
    * CPros) e de grdProdutos.Column2.Text1 (busca por DPros), com o When de
    * cada um controlando se a celula aceita edicao. BINDEVENT em When/Valid
    * de Column.Text1 NAO eh confiavel (regra #46), por isso os eventos moram
    * na classe da celula, que delega para os metodos PUBLIC deste form.
    *
    * As TRES linhas sao obrigatorias para o controle APARECER e aceitar
    * clique (regra #18):
    *   AddObject      - cria o controle (que a Column NAO desenha sozinha:
    *                    ela segue pintando o Text1 dela)
    *   CurrentControl - diz a Column qual controle desenhar
    *   Sparse = .F.   - senao o controle so aparece na linha ATIVA
    * E o Column.ReadOnly vai DEPOIS do Grid.ReadOnly (o do grid propaga para
    * as colunas e sobrescreveria o que viesse antes) - este metodo eh
    * chamado no fim de AplicarFormatoGrade, que por sua vez roda depois do
    * bloco que define Grid.ReadOnly em ConfigurarGrade.
    *
    * IDEMPOTENTE: o AddObject so acontece quando o controle ainda nao
    * existe (um segundo AddObject com o mesmo nome estoura "Object is
    * already defined"), mas CurrentControl/Sparse/ReadOnly sao reaplicados
    * sempre - eh exatamente isso que o rebind do RecordSource derruba. O
    * re-AddObject protegido tambem cobre o caso de a Column perder os
    * controles quando o alias ligado a ela eh fechado e reaberto.
    *
    * MaxLength vem da largura da COLUNA no schema (regra #19), nunca do
    * Width em pixels: SigCdPro.CPros char(14) e SigCdPro.DPros char(65).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora para reinstalar as celulas depois de repopular o cursor.
    *==========================================================================
    PROCEDURE InstalarCelulasLookup
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        *-- Column1 - CPros (codigo do produto)
        *-- O PEMSTATUS repete a expressao do WITH de proposito: .Self NAO
        *-- existe em VFP9 (regra #38) - compila limpo e estoura "Property
        *-- SELF is not found" em runtime, derrubando o Init
        WITH THIS.grd_4c_Dados.Column1
            IF !PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_Codigo", 5)
                .AddObject("txt_4c_Codigo", "TextBoxCelulaSpr_4c")
            ENDIF
            .txt_4c_Codigo.this_cCelula = "CODIGO"
            .txt_4c_Codigo.MaxLength    = 14
            .CurrentControl = "txt_4c_Codigo"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        *-- Column2 - DPros (descricao do produto)
        WITH THIS.grd_4c_Dados.Column2
            IF !PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_Descricao", 5)
                .AddObject("txt_4c_Descricao", "TextBoxCelulaSpr_4c")
            ENDIF
            .txt_4c_Descricao.this_cCelula = "DESCRICAO"
            .txt_4c_Descricao.MaxLength    = 65
            .CurrentControl = "txt_4c_Descricao"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - cmdEscolha (Inserir/Excluir) e cmdSalva
    * (Encerrar) do legado, mais as duas barrinhas decorativas ImgBarra1 e
    * ImgBarra2, que ficam entre eles na ordem de objetos do SCX.
    *
    * Criados DEPOIS de ConfigurarCabecalho: os dois CommandGroup ficam em
    * Top = -1 com Height = 85, ou seja DENTRO da faixa cinza (Top 0..80), e
    * so desenham por cima dela se forem criados depois (regra #11).
    *
    * Transcricao do dump:
    *   cmdEscolha   AutoSize=.T. ButtonCount=2 BackStyle=0 BorderStyle=0
    *                SpecialEffect=1 BorderColor=136,189,188 Value=0
    *                Top=-1 Left=343 Width=160 Height=85 TabIndex=5
    *     btnInserir Top=5 Left=5  75x75 "\<Inserir" cadastro_inserir_60.jpg
    *     btnExcluir Top=5 Left=80 75x75 "\<Excluir" cadastro_excluir_60.jpg
    *   cmdSalva     AutoSize=.T. ButtonCount=1 BackStyle=0 BorderStyle=0
    *                SpecialEffect=1 BorderColor=136,189,188 Value=0
    *                Top=-1 Left=718 Width=85 Height=85 TabIndex=6
    *     btnSair    Top=5 Left=5  75x75 "Encerrar" Cancel=.T. AutoSize=.F.
    *                cadastro_sair_60.jpg
    *
    * Os Buttons(N) mantem o nome default do VFP (Command1/Command2): o
    * legado os rebatiza (btnInserir/btnExcluir/btnSair), mas o canonico do
    * projeto eh alcancar por Buttons(N), e eh assim que a fase 7 liga o
    * Click de cada um.
    *
    * A geometria dos botoes INTERNOS eh aplicada ANTES da geometria do
    * grupo: com AutoSize = .T. eh o tamanho do botao interno que define a
    * altura do grupo (regra #31).
    *
    * CommandGroup NAO tem FontName nem ForeColor (regra #33) - fonte e cor
    * moram em cada Buttons(N). Themes = .F. nos botoes, como no dump: o
    * Themes = .T. do padrao standalone NAO vale para membro de CommandGroup.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao
        LOCAL loc_cIconeInserir, loc_cIconeExcluir, loc_cIconeSair, loc_cBarrinha

        loc_cIconeInserir = ""
        loc_cIconeExcluir = ""
        loc_cIconeSair    = ""
        loc_cBarrinha     = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeInserir = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            loc_cIconeExcluir = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            loc_cIconeSair    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            loc_cBarrinha     = gc_4c_CaminhoIcones + "barrinha.bmp"
        ENDIF

        *-- cmdEscolha -> cmg_4c_CmdEscolha (Inserir / Excluir)
        THIS.AddObject("cmg_4c_CmdEscolha", "CommandGroup")
        WITH THIS.cmg_4c_CmdEscolha
            .ButtonCount = 2

            *-- btnInserir ("\<Inserir": o \< marca o atalho Alt+I,
            *-- transcrito literal do Caption do SCX)
            WITH .Buttons(1)
                .Caption       = "\<Inserir"
                .Top           = 5
                .Left          = 5
                .Width         = 75
                .Height        = 75
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .MousePointer  = 15
                .TabIndex      = 1
                .ToolTipText   = "Inserir Um Novo Produto"

                IF !EMPTY(loc_cIconeInserir) AND FILE(loc_cIconeInserir)
                    .Picture         = loc_cIconeInserir
                    .DisabledPicture = loc_cIconeInserir
                    .PicturePosition = 13
                ENDIF

                .Visible = .T.
            ENDWITH

            *-- btnExcluir
            WITH .Buttons(2)
                .Caption       = "\<Excluir"
                .Top           = 5
                .Left          = 80
                .Width         = 75
                .Height        = 75
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .MousePointer  = 15
                .ToolTipText   = "Excluir o Produto Selecionado"

                IF !EMPTY(loc_cIconeExcluir) AND FILE(loc_cIconeExcluir)
                    .Picture         = loc_cIconeExcluir
                    .DisabledPicture = loc_cIconeExcluir
                    .PicturePosition = 13
                ENDIF

                .Visible = .T.
            ENDWITH

            *-- Geometria do GRUPO depois da dos botoes internos (regra #31)
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .Top           = -1
            .Left          = 343
            .Width         = 160
            .Height        = 85
            .TabIndex      = 5
            .Visible       = .T.
        ENDWITH

        *-- ImgBarra1: barrinha decorativa. Nasce Visible = .F. no SCX, de
        *-- proposito - por isso esta na lista de excecao de
        *-- TornarControlesVisiveis
        THIS.AddObject("img_4c_ImgBarra1", "Image")
        WITH THIS.img_4c_ImgBarra1
            .Top     = 109
            .Left    = 627
            .Width   = 9
            .Height  = 33
            .Stretch = 0

            IF !EMPTY(loc_cBarrinha) AND FILE(loc_cBarrinha)
                .Picture = loc_cBarrinha
            ENDIF

            .Visible = .F.
        ENDWITH

        *-- cmdSalva -> cmg_4c_CmdSalva (Encerrar). Sem TitleBar e sem
        *-- ControlBox (ver propriedades do form), este botao eh a UNICA
        *-- saida do dialogo - o Click entra na fase 7
        THIS.AddObject("cmg_4c_CmdSalva", "CommandGroup")
        WITH THIS.cmg_4c_CmdSalva
            .ButtonCount = 1

            *-- btnSair (Cancel = .T.: eh o botao do ESC no legado)
            WITH .Buttons(1)
                .Caption      = "Encerrar"
                .Cancel       = .T.
                .Top          = 5
                .Left         = 5
                .Width        = 75
                .Height       = 75
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .FontBold     = .T.
                .FontItalic   = .T.
                .WordWrap     = .T.
                .AutoSize     = .F.
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .MousePointer = 15
                .ToolTipText  = "Sair do Cadastro"

                IF !EMPTY(loc_cIconeSair) AND FILE(loc_cIconeSair)
                    .Picture         = loc_cIconeSair
                    .DisabledPicture = loc_cIconeSair
                    .PicturePosition = 13
                ENDIF

                .Visible = .T.
            ENDWITH

            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .Top           = -1
            .Left          = 718
            .Width         = 85
            .Height        = 85
            .TabIndex      = 6
            .Visible       = .T.
        ENDWITH

        *-- ImgBarra2: idem ImgBarra1 (Visible = .F. no SCX)
        THIS.AddObject("img_4c_ImgBarra2", "Image")
        WITH THIS.img_4c_ImgBarra2
            .Top     = 109
            .Left    = 644
            .Width   = 8
            .Height  = 33
            .Stretch = 0

            IF !EMPTY(loc_cBarrinha) AND FILE(loc_cBarrinha)
                .Picture = loc_cBarrinha
            ENDIF

            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesLote - cmdProcessar do legado -> cmg_4c_CmdProcessar
    * (os 3 botoes de processamento em lote), mais a barrinha ImgBarra3.
    *
    * Criado DEPOIS de ConfigurarCabecalho, pela mesma razao de
    * ConfigurarBotoesAcao: Top = -1 / Height = 85 cai DENTRO da faixa
    * cinza (Top 0..80) e precisa ser criado depois dela para desenhar por
    * cima (regra #11).
    *
    * Transcricao do dump:
    *   cmdProcessar AutoSize=.T. ButtonCount=3 BackStyle=0 BorderStyle=0
    *                SpecialEffect=1 BorderColor=136,189,188 Value=0
    *                Top=-1 Left=493 Width=235 Height=85 TabIndex=4
    *     btnEstI  (Command1) Top=5 Left=5   75x75 "Produtos com Mov."
    *               geral_cambio_60.jpg
    *     btnEst   (Command2) Top=5 Left=80  75x75 "Produtos n" + CHR(227) + "o Inv."
    *               geral_empilha_60.jpg
    *     btnGeral (Command3) Top=5 Left=155 75x75 "Todos n" + CHR(227) + "o Inv."
    *               geral_palete_60.jpg
    *
    * Value = 1/2/3 identifica qual dos tres foi clicado (fase 8 - o Click
    * do legado faz Do Case (This.Value = 1/2/3), que corresponde direto a
    * par_nOpcao de SigOpSprBO.ObterProdutosEmLote).
    *
    * A visibilidade real (cmdProcessar.Visible = InList(pcEscolha,
    * INSERIR,ALTERAR) And Upper(ParentForm.Name) = "SIGCDBAL") eh aplicada
    * depois de TornarControlesVisiveis, em AplicarVisibilidadePorContexto.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesLote
        LOCAL loc_cIconeEstI, loc_cIconeEst, loc_cIconeGeral, loc_cBarrinha

        loc_cIconeEstI  = ""
        loc_cIconeEst   = ""
        loc_cIconeGeral = ""
        loc_cBarrinha   = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeEstI  = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
            loc_cIconeEst   = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            loc_cIconeGeral = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
            loc_cBarrinha   = gc_4c_CaminhoIcones + "barrinha.bmp"
        ENDIF

        THIS.AddObject("cmg_4c_CmdProcessar", "CommandGroup")
        WITH THIS.cmg_4c_CmdProcessar
            .ButtonCount = 3

            *-- btnEstI - "Produtos com Mov." (SigMvItn, opcao 1)
            WITH .Buttons(1)
                .Caption       = "Produtos com Mov."
                .Top           = 5
                .Left          = 5
                .Width         = 75
                .Height        = 75
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .MousePointer  = 15
                .TabIndex      = 1
                .ToolTipText   = "Apanha Produtos Com Movimenta" + CHR(231) + ;
                                 CHR(227) + "o e N" + CHR(227) + "o Inventariados"

                IF !EMPTY(loc_cIconeEstI) AND FILE(loc_cIconeEstI)
                    .Picture         = loc_cIconeEstI
                    .DisabledPicture = loc_cIconeEstI
                    .PicturePosition = 13
                ENDIF

                .Visible = .T.
            ENDWITH

            *-- btnEst - "Produtos nao Inv." (SigMvEst com SQtds <> 0, opcao 2)
            WITH .Buttons(2)
                .Caption       = "Produtos n" + CHR(227) + "o Inv."
                .Top           = 5
                .Left          = 80
                .Width         = 75
                .Height        = 75
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .MousePointer  = 15
                .ToolTipText   = "Apanha Produtos Que Tenham Estoque e N" + ;
                                 CHR(227) + "o Inventariados"

                IF !EMPTY(loc_cIconeEst) AND FILE(loc_cIconeEst)
                    .Picture         = loc_cIconeEst
                    .DisabledPicture = loc_cIconeEst
                    .PicturePosition = 13
                ENDIF

                .Visible = .T.
            ENDWITH

            *-- btnGeral - "Todos nao Inv." (SigCdPro, opcao 3)
            WITH .Buttons(3)
                .Caption       = "Todos n" + CHR(227) + "o Inv."
                .Top           = 5
                .Left          = 155
                .Width         = 75
                .Height        = 75
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .MousePointer  = 15
                .ToolTipText   = "Apanha Todos os Produtos N" + CHR(227) + ;
                                 "o Inventariados"

                IF !EMPTY(loc_cIconeGeral) AND FILE(loc_cIconeGeral)
                    .Picture         = loc_cIconeGeral
                    .DisabledPicture = loc_cIconeGeral
                    .PicturePosition = 13
                ENDIF

                .Visible = .T.
            ENDWITH

            *-- Geometria do GRUPO depois da dos botoes internos (regra #31)
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .Top           = -1
            .Left          = 493
            .Width         = 235
            .Height        = 85
            .TabIndex      = 4
            .Visible       = .T.
        ENDWITH

        *-- ImgBarra3: barrinha decorativa, Visible = .F. no SCX (mesma
        *-- excecao de ImgBarra1/ImgBarra2 em TornarControlesVisiveis)
        THIS.AddObject("img_4c_ImgBarra3", "Image")
        WITH THIS.img_4c_ImgBarra3
            .Top     = 109
            .Left    = 612
            .Width   = 9
            .Height  = 33
            .Stretch = 0

            IF !EMPTY(loc_cBarrinha) AND FILE(loc_cBarrinha)
                .Picture = loc_cBarrinha
            ENDIF

            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarDias - getDias/lblDias do legado -> txt_4c_Dias/lbl_4c_LblDias
    * ("Dias a Considerar" para o processamento em lote).
    *
    * Transcricao do dump:
    *   getDias  Alignment=3 Value=0 InputMask="9999" MaxLength=4
    *            Top=506 Left=236 Width=38 Height=23 TabIndex=3
    *   lblDias  AutoSize=.T. FontBold=.T. FontSize=8 Alignment=0
    *            Caption="Dias :" Top=511 Left=197 Width=32 Height=15
    *            TabIndex=2 ForeColor=90,90,90
    *
    * getDias NAO tem ControlSource no dump: eh um valor de trabalho lido
    * direto pelo Click de cmdProcessar (ThisForm.getDias.Value), nao uma
    * coluna de tabela - por isso nao ha bind a SigOpSprBO.this_nDias aqui;
    * a fase 8 (Click dos botoes de lote) le THIS.txt_4c_Dias.Value e grava
    * em THIS.this_oBusinessObject.this_nDias antes de chamar
    * ObterProdutosEmLote().
    *
    * AutoSize = .F. explicito no label (regra #23 - AutoSize eh NO-OP em
    * Label criado por AddObject): Width/Height vem do dump, ja calculados
    * pelo Form Designer para a legenda "Dias :".
    *
    * A visibilidade real (Visible = InList(pcEscolha,INSERIR,ALTERAR) And
    * Upper(ParentForm.Name) = "SIGCDBAL") eh aplicada depois de
    * TornarControlesVisiveis, em AplicarVisibilidadePorContexto.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDias
        THIS.AddObject("txt_4c_Dias", "TextBox")
        WITH THIS.txt_4c_Dias
            .Value        = 0
            .Alignment    = 3
            .InputMask    = "9999"
            .MaxLength    = 4
            .Top          = 506
            .Left         = 236
            .Width        = 38
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .TabIndex     = 3
            .ToolTipText  = "N" + CHR(250) + "mero de Dias a Considerar Nos " + ;
                            "Produtos N" + CHR(227) + "o Inventariados"
            .Visible      = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblDias", "Label")
        WITH THIS.lbl_4c_LblDias
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = "Dias :"
            .Top        = 511
            .Left       = 197
            .Width      = 32
            .Height     = 15
            .TabIndex   = 2
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarProcessando - cnpProcessando do legado -> cnt_4c_CnpProcessando
    * ("Selecionando Produtos..." - overlay exibido durante o processamento
    * em lote, fase 8).
    *
    * Transcricao do dump:
    *   cnpProcessando Top=300 Left=231 Width=345 Height=60 BorderWidth=2
    *                  SpecialEffect=2 BackColor=255,255,255
    *                  BorderColor=167,167,167
    *     Image4 (processando.gif) Top=15 Left=13 Width=30 Height=30
    *     Say1   "Selecionando Produtos..." Top=18 Left=60 Width=239
    *            Height=25 Tahoma bold 14, Alignment=2 (direita),
    *            ForeColor=90,90,90
    *
    * O Top=300 do dump e' o valor de DESENHO do Form Designer - o Init
    * legado SOBRESCREVE com Top=500 ao final (depois do bloco With
    * .grdProdutos), e e' esse Top=500 que fica ativo quando a tela abre.
    * Nessa posicao o container cobre exatamente a faixa de getDias/lblDias
    * (Top 506..529 / 511..526): o overlay troca o campo "Dias" pela
    * mensagem de progresso. O Click de cmdProcessar (fase 8) sobe para
    * Top=120 (sobre a grade) durante o processamento e devolve a Top=500
    * ao terminar - exatamente como no legado.
    *
    * NAO entra no filtro de TornarControlesVisiveis: ao contrario de
    * ImgBarra1/2/3, este container fica SEMPRE Visible = .T.; e' a
    * POSICAO (Top), nao o Visible, que o esconde/mostra.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarProcessando
        LOCAL loc_cImagemProcessando

        loc_cImagemProcessando = ""
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cImagemProcessando = gc_4c_CaminhoIcones + "processando.gif"
        ENDIF

        THIS.AddObject("cnt_4c_CnpProcessando", "Container")
        WITH THIS.cnt_4c_CnpProcessando
            .Top           = 500
            .Left          = 231
            .Width         = 345
            .Height        = 60
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(167, 167, 167)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_CnpProcessando.AddObject("img_4c_Image4", "Image")
        WITH THIS.cnt_4c_CnpProcessando.img_4c_Image4
            .Top     = 15
            .Left    = 13
            .Width   = 30
            .Height  = 30
            .Stretch = 0

            IF !EMPTY(loc_cImagemProcessando) AND FILE(loc_cImagemProcessando)
                .Picture = loc_cImagemProcessando
            ENDIF

            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_CnpProcessando.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_CnpProcessando.lbl_4c_Label1
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .WordWrap  = .F.
            .Alignment = 2
            .BackStyle = 0
            .Caption   = "Selecionando Produtos..."
            .Top       = 18
            .Left      = 60
            .Width     = 239
            .Height    = 25
            .TabIndex  = 2
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * EmModoEdicao - FONTE UNICA da condicao que o legado repete em quatro
    * lugares: InList(ThisForm.ParentForm.pcEscolha, [INSERIR], [ALTERAR]).
    *
    * Decide (a) se Inserir/Excluir aparecem (AplicarVisibilidadePorContexto)
    * e (b) se as celulas da grade aceitam edicao (o When de Column1.Text1 e,
    * somado a outra condicao, o de Column2.Text1). Com o pai em PROCURAR a
    * tela eh so de leitura.
    *
    * Sem form pai (harness de teste / ValidarUIFidelity, onde pcEscolha fica
    * vazio) devolve .T., para a validacao enxergar a tela utilizavel.
    *
    * Metodo PUBLIC (regra #3): a classe da celula o alcanca indiretamente
    * via CelulaSprEditavel, e o harness o chama de fora.
    *==========================================================================
    PROCEDURE EmModoEdicao
        LOCAL loc_cEscolha

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN .T.
        ENDIF

        loc_cEscolha = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cEscolha = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha))
        ENDIF

        RETURN INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * ObterCursorProdutos - alias do cursor LOCAL do form pai que a grade
    * edita (crProdutos do legado). FONTE UNICA: o nome mora no BO
    * (this_cCursorProdutos) e o default repete o canonico para o caso de o
    * BO nao ter sido criado (caminho de falha de InicializarForm).
    *
    * Metodo PUBLIC: o form pai pode consultar qual alias este dialogo edita.
    *==========================================================================
    PROCEDURE ObterCursorProdutos
        LOCAL loc_cCursor
        loc_cCursor = "cursor_4c_Produtos"

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorProdutos)
        ENDIF

        RETURN loc_cCursor
    ENDPROC

    *==========================================================================
    * ObterCursorBusca - alias do cursor de lookup de SigCdPro
    * (crListaRemota do legado). Mesma razao de ObterCursorProdutos: o nome
    * mora no BO (this_cCursorBusca) e o default repete o canonico.
    *==========================================================================
    PROCEDURE ObterCursorBusca
        LOCAL loc_cCursor
        loc_cCursor = "cursor_4c_BuscaProduto"

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorBusca)
        ENDIF

        RETURN loc_cCursor
    ENDPROC

    *==========================================================================
    * AplicarVisibilidadePorContexto - visibilidade condicional que o Init
    * legado calcula a partir do form pai:
    *
    *     .cmdEscolha.Visible   = InList(.ParentForm.pcEscolha, [INSERIR], [ALTERAR])
    *     .cmdProcessar.Visible = InList(.ParentForm.pcEscolha, [INSERIR], [ALTERAR]) ;
    *                             And (Upper(.ParentForm.Name) = [SIGCDBAL])
    *     .lblDias.Visible      = <mesma expressao de cmdProcessar>
    *     .getDias.Visible      = <mesma expressao de cmdProcessar>
    *
    * Com o pai em PROCURAR (consulta) o usuario nao pode mexer na lista: os
    * botoes Inserir/Excluir somem e a tela fica so de leitura. O
    * processamento em lote (cmdProcessar/lblDias/getDias) soma a essa
    * mesma condicao o requisito de o form pai ser o SIGCDBAL (Balanco) -
    * nos demais chamadores do dialogo esses tres controles ficam ocultos.
    *
    * Roda DEPOIS de TornarControlesVisiveis, que forca Visible = .T. em
    * tudo que foi criado por AddObject e apagaria esta decisao.
    *
    * Sem form pai (harness de teste / ValidarUIFidelity, onde pcEscolha e
    * Name ficam vazios) todos os controles continuam visiveis, para que a
    * validacao enxergue os controles recem-criados.
    *
    * Metodo PUBLIC: o form pai pode reaplicar depois de trocar de modo.
    *==========================================================================
    PROCEDURE AplicarVisibilidadePorContexto
        LOCAL loc_lEditando, loc_lLote, loc_cNomeFormPai

        loc_cNomeFormPai = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cNomeFormPai = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNomeFormPai))
        ENDIF

        *-- FONTE UNICA da condicao InList(pcEscolha, INSERIR, ALTERAR) - o
        *-- When das duas celulas de lookup le exatamente a mesma coisa
        loc_lEditando = THIS.EmModoEdicao()

        IF VARTYPE(THIS.this_oFormPai) != "O"
            loc_lLote = .T.
        ELSE
            loc_lLote = loc_lEditando AND (loc_cNomeFormPai == "SIGCDBAL")
        ENDIF

        IF PEMSTATUS(THIS, "cmg_4c_CmdEscolha", 5)
            THIS.cmg_4c_CmdEscolha.Visible = loc_lEditando
        ENDIF

        IF PEMSTATUS(THIS, "cmg_4c_CmdProcessar", 5)
            THIS.cmg_4c_CmdProcessar.Visible = loc_lLote
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c_LblDias", 5)
            THIS.lbl_4c_LblDias.Visible = loc_lLote
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Dias", 5)
            THIS.txt_4c_Dias.Visible = loc_lLote
        ENDIF

        RETURN loc_lEditando
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL de carga da grade. Transcreve o bloco do Init
    * legado que liga a grade ao cursor do form PAI e a repinta:
    *
    *     Go Top In crProdutos
    *     With .grdProdutos
    *         .RecordSource          = [crProdutos]
    *         .Column1.ControlSource = [crProdutos.CPros]
    *         .Column2.ControlSource = [crProdutos.DPros]
    *         .Refresh
    *         <garante uma linha em branco - ver GarantirLinhaEmBranco>
    *         .Column1.SetFocus
    *         .Refresh
    *     EndWith
    *
    * crProdutos NAO pertence a este dialogo: eh um cursor LOCAL do form
    * chamador (cursor_4c_Produtos), aberto por ele antes do Do Form. Por
    * isso aqui nao ha SQLEXEC - nao ha consulta propria a fazer, so o
    * binding. Pela mesma razao o Destroy NAO fecha esse alias: ele eh do
    * pai, que depende dele depois deste dialogo fechar.
    *
    * Sem o cursor aberto o binding NAO eh aplicado - atribuir RecordSource
    * de alias inexistente derruba o Init (regra #41). Devolve .F. nesse
    * caso, sem estourar: eh o caminho normal do harness, que instancia o
    * form sem chamador.
    *
    * O SetFocus do legado NAO eh reproduzido aqui: o Init do VFP9 roda com
    * o form ainda nao exibido e SetFocus em controle invisivel estoura
    * "Cannot access a visible or enabled control" - o foco inicial fica com
    * o TabIndex = 1 da grade, que eh o mesmo controle.
    *
    * Fecha com GO TOP + Refresh (regra #21a): ligar/popular cursor NAO
    * repinta a grade sozinho.
    *
    * Metodo PUBLIC (regra #3): o harness de teste o chama de FORA da
    * classe, sem argumento, e PROTECTED faria a chamada estourar em runtime
    * com "Property CARREGARDADOS is not found".
    *
    * Nao ha RETURN dentro de TRY/CATCH (regra #1): o resultado sai por flag
    * e o unico RETURN do bloco fica depois do ENDTRY.
    *==========================================================================
    PROCEDURE CarregarDados
        LOCAL loc_lCarregou, loc_cCursor, loc_oErro
        loc_lCarregou = .F.
        loc_cCursor   = THIS.ObterCursorProdutos()

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        TRY
            *-- Legado: Go Top In crProdutos (antes do binding)
            SELECT (loc_cCursor)
            GO TOP

            *-- ColumnCount antes do RecordSource. Reatribuir o MESMO valor
            *-- nao recria as Column (nao ha controle posto por
            *-- Column.AddObject nesta grade a perder). Fora do WITH do
            *-- Grid, para RecordSource/ColumnCount nao compartilhar bloco
            *-- com o acesso a .Column1/.Column2 (regra GRID-WITH)
            THIS.grd_4c_Dados.ColumnCount  = 2
            THIS.grd_4c_Dados.RecordSource = loc_cCursor

            *-- Column1 = CPros (codigo), Column2 = DPros (descricao)
            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = loc_cCursor + ".CPros"
                .Column2.ControlSource = loc_cCursor + ".DPros"
            ENDWITH

            *-- Rede de seguranca do Problema 48: RecordSource/ControlSource
            *-- zeram Column.Width e Header1.Caption. Mesma fonte usada na
            *-- montagem, entao nao ha numero duplicado aqui
            THIS.AplicarFormatoGrade()

            *-- Legado: a linha em branco no fim da lista eh o que permite
            *-- comecar a digitar assim que a tela abre
            THIS.GarantirLinhaEmBranco()

            *-- Legado: .Refresh (o Init chama duas vezes, antes e depois do
            *-- bloco da linha em branco - o efeito util eh o ultimo)
            THIS.grd_4c_Dados.Refresh()

            loc_lCarregou = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar a grade de produtos: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Selecionar Produtos")
            loc_lCarregou = .F.
        ENDTRY

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * GarantirLinhaEmBranco - transcricao do bloco do Init legado:
    *
    *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
    *     Go Top In LocalBrancos
    *     If Eof([LocalBrancos])
    *         Append Blank In crProdutos
    *         Go Bottom In crProdutos
    *     EndIf
    *
    * Ou seja: se NAO existe nenhuma linha com codigo vazio, acrescenta uma,
    * para o usuario ter sempre onde digitar o proximo produto. Se ja existe,
    * nao mexe.
    *
    * O APPEND BLANK age no cursor LOCAL do form pai, nao no SQL Server:
    * esta tela nao persiste nada - quem grava eh o pai, depois que o
    * dialogo fecha.
    *
    * O mesmo bloco reaparece no btnInserir.Click do legado, com um ELSE a
    * mais (Locate For Empty(CPros) quando o branco ja existe); esse handler
    * eh da fase 7 e vai reusar este metodo.
    *
    * Metodo PUBLIC: eh chamado pelo funil de carga e, na fase 7, pelo Click
    * do botao Inserir.
    *==========================================================================
    PROCEDURE GarantirLinhaEmBranco
        LOCAL loc_lIncluiu, loc_cCursor, loc_cBrancos, loc_oErro
        loc_lIncluiu = .F.
        loc_cCursor  = THIS.ObterCursorProdutos()
        loc_cBrancos = "cursor_4c_LinhasBrancas"

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cBrancos = ALLTRIM(THIS.this_oBusinessObject.this_cCursorBrancos)
        ENDIF

        IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cBrancos)
                USE IN (loc_cBrancos)
            ENDIF

            SELECT * ;
              FROM (loc_cCursor) ;
             WHERE EMPTY(CPros) ;
              INTO CURSOR (loc_cBrancos)

            GO TOP IN (loc_cBrancos)

            IF EOF(loc_cBrancos)
                SELECT (loc_cCursor)
                APPEND BLANK
                GO BOTTOM
                loc_lIncluiu = .T.
            ENDIF

            IF USED(loc_cBrancos)
                USE IN (loc_cBrancos)
            ENDIF

            *-- Deixa o cursor do pai como area corrente, igual ao legado
            SELECT (loc_cCursor)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao preparar a linha em branco da grade: " + ;
                    loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Selecionar Produtos")
            loc_lIncluiu = .F.
        ENDTRY

        RETURN loc_lIncluiu
    ENDPROC

    *==========================================================================
    * CelulaSprEditavel - When das celulas de lookup instaladas em
    * txt_4c_Codigo (Column1) e txt_4c_Descricao (Column2), chamado por
    * TextBoxCelulaSpr_4c.When() (textboxgridlookup.PRG).
    *
    * Legado:
    *   Column1.Text1.When -> Return InList(ParentForm.pcEscolha,
    *                                       [INSERIR], [ALTERAR])
    *   Column2.Text1.When -> Return Empty(Column1.Text1.Value) And
    *                                InList(ParentForm.pcEscolha,
    *                                       [INSERIR], [ALTERAR])
    *
    * Ou seja: a descricao SO eh digitavel enquanto o codigo da linha esta
    * vazio - digitar o codigo eh o caminho principal, e a busca por
    * descricao eh a alternativa para quem nao sabe o codigo.
    *
    * A condicao do codigo eh lida do CURSOR da grade, nao do .Value do
    * controle vizinho: com Sparse = .F. os dois controles existem em todas
    * as linhas, mas o valor confiavel da linha CORRENTE eh o que ja foi
    * confirmado no cursor (o digitado ainda nao commitado esta no .Value da
    * celula em edicao, que nunca eh esta - regra #46).
    *
    * Metodo PUBLIC (regra #3): a classe da celula delega via THISFORM, de
    * FORA da classe do form.
    *==========================================================================
    PROCEDURE CelulaSprEditavel(par_cCelula, par_oTxt)
        LOCAL loc_cCursor

        *-- Comum as duas celulas: com o pai em PROCURAR a tela eh so leitura
        IF !THIS.EmModoEdicao()
            RETURN .F.
        ENDIF

        IF par_cCelula == "DESCRICAO"
            loc_cCursor = THIS.ObterCursorProdutos()

            *-- Sem o cursor do pai (harness) nao ha codigo preenchido para
            *-- bloquear a celula - mesmo efeito do Value vazio no legado
            IF !USED(loc_cCursor)
                RETURN .T.
            ENDIF

            IF EOF(loc_cCursor)
                RETURN .T.
            ENDIF

            RETURN EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".CPros"), "")))
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarCelulaSprExec - Valid das celulas de lookup (regra #46: valida
    * na saida da CELULA, nunca em AfterRowColChange, cujo nColIndex eh a
    * coluna de DESTINO). Recebe o proprio TextBox porque dentro do Valid o
    * valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao cursor da
    * grade.
    *
    * Legado (os dois Valid tem a mesma moldura):
    *   If Not Empty(This.Value)
    *       <lookup em SigCdPro + duplicidade + proxima linha>
    *   Else
    *       <zera a celula irma>
    *   EndIf
    *
    * O retorno eh o retorno do Valid: .F. prende o foco na celula (usado
    * so no "Produto Ja Selecionado!!!" do legado), .T. libera.
    *
    * NAO ha TRY/CATCH neste caminho: ele chega a um Show() MODAL, e TRY em
    * volta de Show modal faz a tela fechar a cada erro de runtime (regra
    * #29). Sem TRY tambem nao ha RETURN dentro de TRY/CATCH (regra #1).
    *
    * Metodo PUBLIC (regra #3): a classe da celula delega via THISFORM.
    *==========================================================================
    PROCEDURE ValidarCelulaSprExec(par_cCelula, par_oTxt)
        LOCAL loc_cValor

        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        loc_cValor = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, "")))

        *-- Legado (ramo Else): limpar o codigo zera a descricao, e limpar a
        *-- descricao zera o codigo
        IF EMPTY(loc_cValor)
            THIS.LimparCelulaIrma(par_cCelula)
            RETURN .T.
        ENDIF

        RETURN THIS.ResolverCelulaSpr(par_cCelula, par_oTxt)
    ENDPROC

    *==========================================================================
    * AbrirLookupCelulaSpr - F4/F5/duplo clique (afordancia do sistema novo,
    * padrao dos demais lookups de grade do projeto). O legado so tinha o
    * Valid; aqui o picker tambem abre sob demanda, inclusive com a celula
    * vazia, mostrando o universo inteiro de SigCdPro.
    *
    * Respeita o mesmo gate de edicao do When: em PROCURAR nao ha o que
    * escolher, e na celula de descricao o codigo da linha tem de estar
    * vazio - sem isso o F4 driblaria a regra que o When impoe.
    *
    * Metodo PUBLIC (regra #3): a classe da celula delega via THISFORM.
    *==========================================================================
    PROCEDURE AbrirLookupCelulaSpr(par_cCelula, par_oTxt)
        IF VARTYPE(par_oTxt) != "O"
            RETURN .F.
        ENDIF

        IF !THIS.CelulaSprEditavel(par_cCelula, par_oTxt)
            RETURN .F.
        ENDIF

        THIS.ResolverCelulaSpr(par_cCelula, par_oTxt)
        par_oTxt.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ResolverCelulaSpr - corpo COMUM do Valid e do F4/F5/duplo clique.
    *
    * Transcricao do bloco central dos dois Valid do legado:
    *
    *     loLista = CreateObject('fwBuscaExt', <conn>, 'SigCdPro',
    *                            'crListaRemota', 'CPros'|'DPros',
    *                            Padr(This.Value, 14|40), 'Selecao', 1000)
    *     If Not loLista.plAchouRegistro
    *         loLista.mAddColuna(<na ordem da celula>)
    *         loLista.Show()
    *     EndIf
    *     Column1.Text1.Value = crListaRemota.CPros
    *     Column2.Text1.Value = crListaRemota.DPros
    *     Use In crListaRemota
    *     <duplicidade: Produto Ja Selecionado!!!>
    *     <posiciona na proxima linha em branco>
    *     If (Lastkey() = 13) / Keyboard '{DNARROW}' / EndIf
    *
    * Equivalencias e divergencias conscientes:
    *
    *  a) fwBuscaExt -> FormBuscaAuxiliar, cujo Init JA tenta o match EXATO e
    *     resolve sozinho quando acha 1 registro (this_lAchouRegistro) - por
    *     isso o Show() fica sob a guarda, exatamente como o
    *     "If Not loLista.plAchouRegistro" do legado (regra #37). O valor de
    *     busca vai em ALLTRIM: o Padr do legado era exigencia do fwBuscaExt,
    *     e aqui o padding atrapalharia o LIKE de prefixo do Init.
    *
    *  b) o legado atribui as duas celulas SEM guarda de selecao, lendo
    *     crListaRemota mesmo quando o usuario CANCELA o picker. Aqui a
    *     atribuicao fica sob this_lSelecionou (regra #37/#50): fora dela o
    *     cancelamento ZERARIA o codigo que o usuario acabou de digitar, e
    *     nao haveria sequencia de teclas capaz de preencher o campo. O
    *     digitado FICA e nenhuma mensagem eh exibida - universo vazio de
    *     lookup nao eh erro (regra #50).
    *
    *  c) a checagem de duplicidade usa o CODIGO resolvido nas DUAS celulas.
    *     No legado, o Valid da descricao faz "Where CPros = This.Value"
    *     onde This.Value acabou de receber a DESCRICAO - compara codigo com
    *     descricao e por isso nunca casa, deixando a checagem morta nesse
    *     caminho (defeito HERDADO, no estilo da regra #28: transcrever ao
    *     pe da letra o reproduziria). Como as duas celulas resolvem para o
    *     MESMO par codigo+descricao, usar o codigo resolvido eh a leitura
    *     coerente do mesmo bloco, e impede incluir o produto duas vezes
    *     entrando pela descricao - que eh justamente o que esta tela existe
    *     para evitar.
    *
    *  d) o legado grava nos .Value dos dois Text1; aqui o par resolvido vai
    *     ao CURSOR por REPLACE (e so depois aos .Value - regra #46), que eh
    *     o unico caminho confiavel de levar valor a coluna que NAO esta em
    *     edicao. LEFT() nas larguras do schema (CPros char(14), DPros
    *     char(65) - regra #19).
    *
    * PROTECTED: so o Valid e o F4 deste form entram aqui, sempre pelos dois
    * metodos PUBLIC acima. Chamado SEMPRE com THIS. (regra #8).
    *==========================================================================
    PROTECTED FUNCTION ResolverCelulaSpr(par_cCelula, par_oTxt)
        LOCAL loc_cCursor, loc_cCursorBusca, loc_cValor, loc_cCampoBusca
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_lResolveu

        loc_cCursor      = THIS.ObterCursorProdutos()
        loc_cCursorBusca = THIS.ObterCursorBusca()
        loc_cValor       = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, "")))
        loc_cCodigo      = ""
        loc_cDescricao   = ""
        loc_lResolveu    = .F.

        *-- Legado: 'CPros' na celula de codigo, 'DPros' na de descricao -
        *-- a MESMA tabela SigCdPro, mudando so o campo de busca
        loc_cCampoBusca = IIF(par_cCelula == "DESCRICAO", "DPros", "CPros")

        IF USED(loc_cCursorBusca)
            USE IN (loc_cCursorBusca)
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
            loc_cCursorBusca, loc_cCampoBusca, loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            *-- Show SO quando o match exato do Init nao resolveu (regra #37)
            IF !loc_oBusca.this_lAchouRegistro
                *-- Ordem das colunas do picker igual a do mAddColuna do
                *-- legado: o campo pelo qual se buscou vem PRIMEIRO
                IF par_cCelula == "DESCRICAO"
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                ELSE
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                ENDIF

                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
                *-- Alias em variavel: SELECT (alias) e depois campo NU -
                *-- campo eh sintaxe INVALIDA em VFP9
                SELECT (loc_cCursorBusca)
                loc_cCodigo    = ALLTRIM(NVL(CPros, ""))
                loc_cDescricao = ALLTRIM(NVL(DPros, ""))

                *-- Codigo vazio nao conta como resolvido: CPros eh a chave de
                *-- SigCdPro (NOT NULL) e so viria em branco se o cursor
                *-- estivesse fora de linha. Sem este teste, o REPLACE adiante
                *-- LIMPARIA a linha que o usuario acabou de preencher - em
                *-- silencio, porque nenhuma validacao recusa branco aqui
                loc_lResolveu = !EMPTY(loc_cCodigo)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED(loc_cCursorBusca)
            USE IN (loc_cCursorBusca)
        ENDIF

        *-- Legado: Use In crListaRemota e o cursor da grade volta a ser a
        *-- area corrente
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
        ENDIF

        *-- Cancelou/nao achou: o digitado FICA (regra #50) e o foco eh
        *-- liberado - esta tela nao trata universo vazio como erro
        IF !loc_lResolveu
            RETURN .T.
        ENDIF

        *-- Sem o cursor do pai (harness) so o proprio campo recebe o valor
        IF !USED(loc_cCursor)
            par_oTxt.Value = IIF(par_cCelula == "DESCRICAO", loc_cDescricao, loc_cCodigo)
            RETURN .T.
        ENDIF

        *-- Legado: MessageBox([Produto Ja Selecionado!!!], 0+16,
        *-- [Atencao!!!]) - validacao de uso, portanto MsgAviso
        IF THIS.ProdutoJaSelecionado(loc_cCodigo)
            MsgAviso("Produto J" + CHR(225) + " Selecionado!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")

            *-- Assimetria do legado, reproduzida: so o Valid do CODIGO
            *-- limpa o campo antes do Return .f. (This.Value = []); o da
            *-- descricao devolve .f. deixando o texto como esta
            IF par_cCelula == "CODIGO"
                par_oTxt.Value = ""
            ENDIF

            RETURN .F.
        ENDIF

        *-- Legado: as DUAS celulas recebem o par resolvido. Vai primeiro ao
        *-- cursor (unico caminho confiavel para a coluna que nao esta em
        *-- edicao) e so depois aos controles
        IF !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE CPros WITH LEFT(loc_cCodigo, 14), ;
                    DPros WITH LEFT(loc_cDescricao, 65)
        ENDIF

        par_oTxt.Value = IIF(par_cCelula == "DESCRICAO", loc_cDescricao, loc_cCodigo)
        THIS.EspelharCelulasProduto(loc_cCodigo, loc_cDescricao)

        *-- Legado: posiciona na proxima linha em branco (criando uma se
        *-- preciso), repinta a grade e, no ENTER, desce uma linha
        THIS.PosicionarProximaLinha()

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.Column1.Refresh()
        ENDIF

        IF LASTKEY() = 13
            KEYBOARD "{DNARROW}"
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ProdutoJaSelecionado - checagem de duplicidade do legado:
    *
    *     lnRec = Recno([crProdutos])
    *     Select * From crProdutos
    *      Where CPros = This.Value And Recno() <> lnRec
    *       Into Cursor LocalBrancos
    *     If Not Eof([LocalBrancos]) -> "Produto Ja Selecionado!!!"
    *
    * Ou seja: o mesmo codigo em QUALQUER outra linha do cursor do pai (a
    * propria linha corrente eh excluida, senao reeditar uma linha acusaria
    * duplicidade de si mesma).
    *
    * Feito com SCAN em vez de SELECT ... INTO CURSOR de proposito: o
    * criterio compara uma variavel LOCAL com a coluna, e em SELECT VFP
    * local isso exige prefixo m. em toda referencia (nome solto eh lido
    * como COLUNA). O SCAN sobre o alias eh equivalente - inclusive quanto a
    * registros excluidos, porque SET DELETED esta ON (config.prg) e tanto o
    * SCAN quanto o SELECT os ignoram - e nao tem essa armadilha.
    *
    * REPOE o ponteiro do cursor ao sair: quem chama esta no meio do Valid e
    * conta com a linha corrente preservada.
    *
    * Metodo PUBLIC: o form pai pode reusar a checagem antes de persistir.
    *==========================================================================
    PROCEDURE ProdutoJaSelecionado(par_cCodigo)
        LOCAL loc_lDuplicado, loc_cCursor, loc_cCodigo, loc_nRec, loc_nTotal
        loc_lDuplicado = .F.
        loc_cCursor    = THIS.ObterCursorProdutos()
        loc_cCodigo    = ALLTRIM(TRANSFORM(NVL(par_cCodigo, "")))

        IF EMPTY(loc_cCodigo) OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        SELECT (loc_cCursor)
        loc_nRec   = RECNO()
        loc_nTotal = RECCOUNT()

        SCAN
            IF RECNO() != loc_nRec AND ALLTRIM(NVL(CPros, "")) == loc_cCodigo
                loc_lDuplicado = .T.
                EXIT
            ENDIF
        ENDSCAN

        *-- Repoe o ponteiro. Em EOF o RECNO() vale RECCOUNT()+1, que GO nao
        *-- aceita: nesse caso volta ao fim e sai do ultimo registro, que eh
        *-- o mesmo estado de antes
        DO CASE
        CASE loc_nRec >= 1 AND loc_nRec <= loc_nTotal
            GO loc_nRec
        CASE loc_nTotal > 0
            GO BOTTOM
            SKIP
        ENDCASE

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * EspelharCelulasProduto - leva o par codigo+descricao resolvido aos
    * DOIS controles da grade, como os dois Valid do legado fazem:
    *
    *     ThisForm.grdProdutos.Column1.Text1.Value = crListaRemota.CPros
    *     ThisForm.grdProdutos.Column2.Text1.Value = crListaRemota.DPros
    *     ThisForm.grdProdutos.Column1.Text1.Refresh
    *     ThisForm.grdProdutos.Column2.Text1.Refresh
    *
    * No migrado os controles sao as celulas instaladas por
    * InstalarCelulasLookup (txt_4c_Codigo/txt_4c_Descricao), que ficam POR
    * CIMA do Text1 via CurrentControl (regra #18) - por isso o alvo eh
    * outro, e cada um eh alcancado sob PEMSTATUS: se o rebind do
    * RecordSource tiver derrubado a celula, espelhar nao pode estourar (o
    * valor ja esta no cursor, que eh a fonte da grade).
    *
    * Metodo PUBLIC: usado pelo funil de lookup e disponivel ao form pai.
    *==========================================================================
    PROCEDURE EspelharCelulasProduto(par_cCodigo, par_cDescricao)
        LOCAL loc_cCodigo, loc_cDescricao

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_cCodigo    = ALLTRIM(TRANSFORM(NVL(par_cCodigo, "")))
        loc_cDescricao = ALLTRIM(TRANSFORM(NVL(par_cDescricao, "")))

        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_Codigo", 5)
            THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Value = loc_cCodigo
            THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Refresh()
        ENDIF

        IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_Descricao", 5)
            THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Value = loc_cDescricao
            THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Refresh()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparCelulaIrma - ramo Else dos dois Valid do legado:
    *
    *     Column1.Text1.Valid, Else -> Column2.Text1.Value = []
    *     Column2.Text1.Valid, Else -> Column1.Text1.Value = []
    *
    * Esvaziar o codigo esvazia a descricao, e vice-versa: as duas colunas
    * sao duas vistas do MESMO produto, e deixar uma preenchida com a outra
    * em branco gravaria meia linha.
    *
    * Zera tambem no CURSOR, nao so no controle: a coluna que nao esta em
    * edicao nao commita pelo .Value (regra #46), e eh o cursor que vai para
    * o form pai.
    *
    * Metodo PUBLIC: chamado pelo Valid das celulas, via ValidarCelulaSprExec.
    *==========================================================================
    PROCEDURE LimparCelulaIrma(par_cCelula)
        LOCAL loc_cCursor

        loc_cCursor = THIS.ObterCursorProdutos()

        IF USED(loc_cCursor)
            IF !EOF(loc_cCursor)
                SELECT (loc_cCursor)

                IF par_cCelula == "DESCRICAO"
                    REPLACE CPros WITH ""
                ELSE
                    REPLACE DPros WITH ""
                ENDIF
            ENDIF
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF par_cCelula == "DESCRICAO"
            IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_Codigo", 5)
                THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Value = ""
                THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Refresh()
            ENDIF
        ELSE
            IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_Descricao", 5)
                THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Value = ""
                THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Refresh()
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * PosicionarProximaLinha - bloco que fecha os dois Valid do legado (e
    * tambem o btnInserir.Click, da fase 7):
    *
    *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
    *     Go Top In LocalBrancos
    *     If Not Eof([LocalBrancos])
    *         Select crProdutos
    *         Locate For Empty(CPros)      && ja existe linha livre: vai nela
    *     Else
    *         Append Blank In crProdutos   && nao existe: cria uma
    *         Go Bottom In crProdutos
    *     EndIf
    *
    * Depois de confirmar um produto o usuario tem de cair numa linha vazia
    * para digitar o proximo, sem reclicar em Inserir.
    *
    * Reusa GarantirLinhaEmBranco, que JA eh o ramo Else (acrescenta a linha
    * e vai para o fim quando NAO ha nenhuma vazia) e devolve .T. nesse
    * caso; so o ramo positivo (Locate) fica aqui. Assim o APPEND BLANK
    * existe num lugar unico.
    *
    * Metodo PUBLIC: o Click do botao Inserir (fase 7) entra por aqui.
    *==========================================================================
    PROCEDURE PosicionarProximaLinha
        LOCAL loc_cCursor

        loc_cCursor = THIS.ObterCursorProdutos()

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        *-- .T. = nao havia linha vazia, GarantirLinhaEmBranco criou uma e
        *-- ja deixou o ponteiro nela (Go Bottom). .F. = ja existia: basta
        *-- ir ate ela, como o Locate do legado
        IF !THIS.GarantirLinhaEmBranco()
            SELECT (loc_cCursor)
            LOCATE FOR EMPTY(NVL(CPros, ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarEventosBotoes - liga o Click de cada botao dos CommandGroup ao
    * handler correspondente deste form.
    *
    * Os Buttons(N) sao criados por AddObject e ficam com o nome default do
    * VFP (Command1/Command2/...): nao existe metodo de classe onde escrever o
    * codigo, como havia no SCX (btnInserir.Click, btnExcluir.Click,
    * btnSair.Click), por isso o Click desses botoes SO dispara via BINDEVENT.
    *
    * O BINDEVENT eh feito em Buttons(N), nao no CommandGroup: no legado cada
    * um destes tres botoes tem o SEU proprio PROCEDURE <nome>.Click. Ligar o
    * GRUPO e despachar por .Value eh o padrao do caso oposto - cmdProcessar,
    * onde o legado escreve UM "PROCEDURE Click" para o grupo inteiro, com
    * "Do Case (This.Value = 1/2/3)" dentro (fase 8).
    *
    * Alvo de BINDEVENT tem de ser PUBLIC (regra #3): os handlers abaixo nao
    * levam PROTECTED - com PROTECTED o bind falha em SILENCIO e o botao fica
    * inerte. Os PEMSTATUS cobrem o caminho em que ConfigurarBotoesAcao nao
    * chegou a criar o grupo (falha anterior no InicializarForm).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosBotoes
        *-- cmdEscolha: btnInserir = Buttons(1), btnExcluir = Buttons(2)
        IF PEMSTATUS(THIS, "cmg_4c_CmdEscolha", 5)
            BINDEVENT(THIS.cmg_4c_CmdEscolha.Buttons(1), "Click", THIS, "BtnInserirClick")
            BINDEVENT(THIS.cmg_4c_CmdEscolha.Buttons(2), "Click", THIS, "BtnExcluirClick")
        ENDIF

        *-- cmdSalva: btnSair = Buttons(1) (Caption "Encerrar", Cancel = .T.,
        *-- ou seja tambem acionado pelo ESC)
        IF PEMSTATUS(THIS, "cmg_4c_CmdSalva", 5)
            BINDEVENT(THIS.cmg_4c_CmdSalva.Buttons(1), "Click", THIS, "BtnEncerrarClick")
        ENDIF

        *-- cmdProcessar: legado escreve UM "PROCEDURE Click" para o GRUPO
        *-- inteiro (Do Case This.Value = 1/2/3) - por isso o BINDEVENT vai
        *-- no CommandGroup, nao em cada Buttons(N), ao contrario de
        *-- cmg_4c_CmdEscolha acima
        IF PEMSTATUS(THIS, "cmg_4c_CmdProcessar", 5)
            BINDEVENT(THIS.cmg_4c_CmdProcessar, "Click", THIS, "BtnProcessarLoteClick")
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FocarGradeProdutos - cauda COMUM de btnInserir.Click e btnExcluir.Click
    * no legado, que terminam identicos:
    *
    *     ThisForm.grdProdutos.Column1.SetFocus
    *     ThisForm.grdProdutos.Refresh
    *
    * Depois de inserir ou apagar uma linha o usuario tem de voltar ao campo
    * Codigo da linha corrente, para seguir digitando sem usar o mouse.
    *
    * Column1.SetFocus do legado vira Grid.SetFocus + ActiveColumn = 1 (mesmo
    * efeito, e eh o canonico do projeto - FormSigOpSno.CmdInserirClick).
    *
    * O SetFocus eh GUARDADO por Visible/Enabled: SetFocus em controle que nao
    * esta na tela estoura "Cannot access a visible or enabled control", e o
    * harness de teste chama estes handlers com o form ainda nao exibido. O
    * Refresh roda de qualquer jeito - alterar o cursor NAO repinta a grade
    * sozinho (regra #21a).
    *
    * PROTECTED: cauda interna dos dois handlers, sempre chamada com THIS.
    * (regra #8).
    *==========================================================================
    PROTECTED PROCEDURE FocarGradeProdutos
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF THIS.Visible AND THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.ActiveColumn = 1
        ENDIF

        THIS.grd_4c_Dados.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnInserirClick - btnInserir.Click do legado (Buttons(1) de cmdEscolha,
    * Caption "\<Inserir"):
    *
    *     Select crProdutos
    *     Go Top In crProdutos
    *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
    *     Go Top In LocalBrancos
    *     If Not Eof([LocalBrancos])
    *         Select crProdutos
    *         Locate For Empty(CPros)
    *     Else
    *         Append Blank In crProdutos
    *         Go Bottom In crProdutos
    *     EndIf
    *     ThisForm.grdProdutos.Column1.SetFocus
    *     ThisForm.grdProdutos.Refresh
    *
    * O bloco do meio eh EXATAMENTE PosicionarProximaLinha (entregue na fase
    * 6, que o reusa no fim do Valid das celulas): se ja existe linha com
    * codigo vazio, vai nela; se nao existe, acrescenta uma e vai para o fim.
    * Chamar o metodo em vez de repetir o bloco mantem o APPEND BLANK num
    * lugar unico - os dois caminhos nunca divergem.
    *
    * O APPEND BLANK age no cursor LOCAL do form pai (cursor_4c_Produtos), nao
    * no SQL Server: esta tela nao persiste nada - quem grava eh o pai, depois
    * que o dialogo fecha.
    *
    * GUARDA DE MODO: o legado nao repete InList(pcEscolha,INSERIR,ALTERAR)
    * dentro do Click porque o Init ja deixa cmdEscolha INVISIVEL em PROCURAR.
    * Aqui a condicao eh relida (FONTE UNICA em EmModoEdicao) porque o atalho
    * Alt+I do Caption "\<Inserir" e uma chamada externa (form pai, harness)
    * alcancam o handler mesmo com o grupo oculto - em consulta nao se insere
    * linha.
    *
    * Os RETURN de guarda ficam ANTES do TRY (regra #1 - nenhum RETURN dentro
    * de TRY/CATCH, nem o bare); o resultado do bloco sai por flag.
    *
    * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de fora.
    *==========================================================================
    PROCEDURE BtnInserirClick
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.ObterCursorProdutos()

        *-- Legado: cmdEscolha.Visible = InList(pcEscolha, INSERIR, ALTERAR)
        IF !THIS.EmModoEdicao()
            RETURN .F.
        ENDIF

        *-- Sem o cursor do pai nao ha linha a inserir (caminho do harness,
        *-- que instancia o dialogo sem chamador)
        IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        TRY
            *-- Legado: Select crProdutos / Go Top In crProdutos
            SELECT (loc_cCursor)
            GO TOP

            *-- Legado: bloco Select LocalBrancos -> Locate / Append Blank
            THIS.PosicionarProximaLinha()

            *-- Legado: Column1.SetFocus + grdProdutos.Refresh
            THIS.FocarGradeProdutos()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir a linha de produto: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Selecionar Produtos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - btnExcluir.Click do legado (Buttons(2) de cmdEscolha,
    * Caption "\<Excluir"):
    *
    *     Select crProdutos
    *     If Not Eof([crProdutos])
    *         Delete In crProdutos
    *         Skip
    *         Skip - 1
    *     EndIf
    *     ThisForm.grdProdutos.Column1.SetFocus
    *     ThisForm.grdProdutos.Refresh
    *
    * Apaga a linha CORRENTE da grade - um item da lista de produtos do pai,
    * nao um registro de tabela: nao ha DELETE em SQL Server neste caminho (e
    * por isso tambem nao ha MsgConfirma, que o legado nao tem - a lista eh de
    * trabalho e a linha se reinsere em um clique).
    *
    * O par SKIP / SKIP -1 eh o idioma do legado para sair de cima do registro
    * recem-apagado: com SET DELETED ON (config.prg) o SKIP pula o que foi
    * marcado e o SKIP -1 volta uma linha VISIVEL, deixando o ponteiro numa
    * linha valida. Transcrito literal - no ultimo registro o SKIP chega a
    * EOF() e o SKIP -1 devolve a ultima linha visivel, que eh o resultado
    * pretendido.
    *
    * Mesma guarda de modo de BtnInserirClick, pela mesma razao (o legado
    * conta com cmdEscolha oculto em PROCURAR, e o atalho Alt+E segue
    * alcancavel).
    *
    * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de fora.
    *==========================================================================
    PROCEDURE BtnExcluirClick
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.ObterCursorProdutos()

        *-- Legado: cmdEscolha.Visible = InList(pcEscolha, INSERIR, ALTERAR)
        IF !THIS.EmModoEdicao()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        TRY
            *-- Legado: Select crProdutos / If Not Eof([crProdutos])
            SELECT (loc_cCursor)

            IF !EOF()
                *-- Legado: Delete In crProdutos / Skip / Skip - 1
                DELETE
                SKIP
                SKIP -1
            ENDIF

            *-- Legado: Column1.SetFocus + grdProdutos.Refresh
            THIS.FocarGradeProdutos()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao excluir a linha de produto: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Selecionar Produtos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RemoverLinhasEmBranco - primeira linha de btnSair.Click do legado:
    *
    *     Delete From crProdutos Where Empty(CPros)
    *
    * Descarta as linhas que nasceram em branco (a que o Init cria para o
    * usuario digitar, e as que ele inseriu e abandonou) ANTES de devolver o
    * cursor ao form pai - sem isso o pai gravaria itens de produto vazios (o
    * SIGCDBAL percorre crProdutos com Scan e faz um Insert por linha).
    *
    * Escrito com SELECT (alias) + DELETE FOR, nao com DELETE FROM <alias>
    * WHERE: o alias mora numa variavel (ObterCursorProdutos) e comando SQL do
    * VFP9 nao aceita name expression no lugar do nome da tabela. A forma
    * xBase age sobre a area corrente e eh equivalente - mesmo padrao de
    * FormSigOpSno.BtnSairClick.
    *
    * NVL em volta de CPros porque o cursor do pai vem de consulta remota e a
    * coluna pode chegar NULL (EMPTY(.NULL.) eh .F. no VFP, logo sem o NVL a
    * linha nula NAO seria apagada).
    *
    * O ponteiro fica onde o DELETE FOR o deixar, como no legado: o pai
    * percorre o cursor com Scan, cujo escopo ALL reposiciona sozinho.
    *
    * Metodo PUBLIC: o Click de cmdProcessar (fase 8) repete esta MESMA linha
    * no legado e entra por aqui, e o form pai pode reusar a limpeza.
    *==========================================================================
    PROCEDURE RemoverLinhasEmBranco
        LOCAL loc_lRemoveu, loc_cCursor, loc_oErro

        loc_lRemoveu = .F.
        loc_cCursor  = THIS.ObterCursorProdutos()

        IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cCursor)
            DELETE FOR EMPTY(NVL(CPros, ""))
            loc_lRemoveu = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao descartar as linhas em branco: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Selecionar Produtos")
            loc_lRemoveu = .F.
        ENDTRY

        RETURN loc_lRemoveu
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - btnSair.Click do legado (Buttons(1) de cmdSalva,
    * Caption "Encerrar", Cancel = .T.):
    *
    *     Delete From crProdutos Where Empty(CPros)
    *     ThisForm.ParentForm.Enabled = .t.
    *     ThisForm.Release
    *
    * Sem TitleBar e sem ControlBox (propriedades do form, transcritas do
    * SCX), este botao - e o ESC, por Cancel = .T. - eh a UNICA saida da tela.
    *
    * NAO ha par Confirmar/Cancelar aqui, e isso eh do legado: a lista JA foi
    * editada no cursor do pai a cada linha, entao encerrar eh aceitar. Pela
    * mesma razao nao ha propriedade de retorno - o resultado inteiro esta no
    * cursor_4c_Produtos, que eh do pai.
    *
    * O THIS.Release() fica FORA do TRY de proposito: se a limpeza das linhas
    * em branco falhar, o dialogo ainda tem de fechar - do contrario o usuario
    * ficaria preso numa tela sem outra saida, com o form pai desabilitado.
    *
    * O Enabled = .T. do pai eh repetido no Destroy como rede de seguranca
    * (caminho em que o dialogo eh destruido sem passar por aqui); atribuir
    * .T. duas vezes eh inocuo.
    *
    * As properties lhouveexcl/lhouveins que o RESERVED3/ClassInfo do SCX
    * lista NAO sao atribuidas nem lidas por metodo algum do dump, e o
    * chamador ("Do Form SigOpSpr With ThisForm", no SIGCDBAL) nao consulta
    * nada do dialogo depois que ele fecha - logo nao ha comportamento delas a
    * portar, e inventar um violaria o PILAR 1.
    *
    * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de fora.
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        LOCAL loc_oErro

        TRY
            *-- Legado: Delete From crProdutos Where Empty(CPros)
            THIS.RemoverLinhasEmBranco()

            *-- Legado: ThisForm.ParentForm.Enabled = .t.
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao encerrar a sele" + CHR(231) + CHR(227) + "o de produtos: " + ;
                    loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Selecionar Produtos")
        ENDTRY

        *-- Legado: ThisForm.Release
        THIS.Release()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnProcessarLoteClick - cmdProcessar.Click do legado (CommandGroup
    * inteiro, Do Case This.Value = 1/2/3 - diferente de cmg_4c_CmdEscolha,
    * que tem um Click por botao). Equivale aos tres botoes "Produtos com
    * Mov." / "Produtos nao Inv." / "Todos nao Inv." (fase 5).
    *
    * Transcricao do legado (SIGOPSPR.cmdProcessar.Click):
    *
    *     If (ThisForm.getDias.Value < 1)
    *         =MessageBox([Preencha os Dias...], 0+16, [Atencao!!!])
    *         Return .f.
    *     EndIf
    *     pDat = fDtoSQL(Date() - ThisForm.getDias.Value)
    *     ThisForm.cnpProcessando.Top = 120
    *     <monta lcWhe a partir de ParentForm.loFil.*>
    *     Do Case (This.Value = 1/2/3) -> lcQuery -> SqlExecute(lcQuery,'LocalCPros')
    *     If (...SqlExecute(...) < 1)
    *         =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
    *         Return .f.
    *     EndIf
    *     Delete From crProdutos Where Empty(CPros)
    *     lnCnt = 0
    *     Select LocalCPros
    *     Scan
    *         If Not Empty(LocalCPros.CPros)
    *             Scatter Memvar Memo
    *             Select crProdutos
    *             Go Top In crProdutos
    *             Locate For CPros = LocalCPros.CPros
    *             If Eof([crProdutos])
    *                 lnCnt = lnCnt + 1
    *                 Insert Into crProdutos From Memvar
    *             EndIf
    *         EndIf
    *     EndScan
    *     ThisForm.cnpProcessando.Top = 500
    *     =MessageBox([Foram Selecionados ]+Alltrim(Str(lnCnt,10))+[ Produtos!!!], 0+64, ...)
    *     Select crProdutos / Go Top In crProdutos / grdProdutos.Refresh
    *     Go Bottom In crProdutos / grdProdutos.Refresh
    *
    * Equivalencias:
    *
    *  a) "pDat = fDtoSQL(Date()-Dias)" e o "Do Case -> lcQuery -> SqlExecute"
    *     inteiros vivem no BO (SigOpSprBO.ObterProdutosEmLote, fases 1-2):
    *     este metodo so le THIS.txt_4c_Dias.Value, grava em
    *     this_oBusinessObject.this_nDias e delega. O lcWhe (faixas do pai)
    *     ja foi migrado para o BO em CarregarContextoFormPai (fase 3) e
    *     MontarFiltroFaixas.
    *
    *  b) "Delete From crProdutos Where Empty(CPros)" ANTES do Scan e
    *     RemoverLinhasEmBranco (fase 7) - mesma linha, metodo unico.
    *
    *  c) "Locate For CPros = LocalCPros.CPros" no legado roda sobre o
    *     cursor INTEIRO (as linhas em branco ja foram removidas no passo
    *     acima) - por isso aqui NAO se reusa ProdutoJaSelecionado (que
    *     exclui a linha CORRENTE pelo RECNO, pensado para o Valid de uma
    *     UNICA celula, fase 6): o lote confere contra TODAS as linhas.
    *
    *  d) "Insert Into crProdutos From Memvar" (Scatter Memvar de
    *     LocalCPros, que so tem CPros/DPros) equivale a APPEND BLANK +
    *     REPLACE dos mesmos dois campos - cursor_4c_Produtos (crProdutos)
    *     tem exatamente essas duas colunas (regra #19: LEFT nas larguras
    *     do schema, CPros char(14) / DPros char(65), ja usadas em
    *     ResolverCelulaSpr).
    *
    *  e) cnpProcessando.Top = 120/500 (mostrar/esconder o aviso "Selecionando
    *     Produtos...", fase 5) fica dentro do MESMO TRY que faz a consulta e
    *     o Scan, com o Top = 500 repetido no CATCH - sem isso um erro no
    *     meio do processamento deixaria o aviso cobrindo a tela para sempre.
    *
    *  f) Depois do Scan o legado garante foco na grade so por via do
    *     Refresh (Go Top/Go Bottom); aqui GarantirLinhaEmBranco (fase 4)
    *     tambem roda, para a tela continuar com uma linha livre para
    *     digitacao - mesmo efeito que o Init e o btnInserir.Click (fase 7)
    *     ja garantem nos outros caminhos.
    *
    * GUARDA DE CONTEXTO: o legado nao repete a condicao de Visible dentro do
    * Click porque o grupo fica OCULTO fora de INSERIR/ALTERAR no form
    * SIGCDBAL (fase 5). Aqui a mesma condicao e relida (EmModoEdicao +
    * nome do form pai) porque harness/chamada externa alcancam o metodo
    * mesmo com o grupo escondido - nos demais chamadores do dialogo (que
    * nao sao o SIGCDBAL) este processamento nao se aplica.
    *
    * Os RETURN de guarda ficam ANTES do TRY (regra #1); o resultado interno
    * do bloco sai por variavel, nunca por RETURN dentro de TRY/CATCH.
    *
    * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de
    * fora.
    *==========================================================================
    PROCEDURE BtnProcessarLoteClick
        LOCAL loc_nOpcao, loc_nDias, loc_cNomeFormPai, loc_cCursorProdutos
        LOCAL loc_cCursorProcessa, loc_nResultado, loc_nInseridos
        LOCAL loc_cCodigo, loc_cDescricao, loc_oErro

        loc_nOpcao = 0
        IF PEMSTATUS(THIS, "cmg_4c_CmdProcessar", 5)
            loc_nOpcao = THIS.cmg_4c_CmdProcessar.Value
        ENDIF

        *-- Legado: cmdProcessar.Visible = InList(pcEscolha,INSERIR,ALTERAR)
        *-- And Upper(ParentForm.Name) = "SIGCDBAL"
        loc_cNomeFormPai = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cNomeFormPai = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNomeFormPai))
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
           !(THIS.EmModoEdicao() AND loc_cNomeFormPai == "SIGCDBAL")
            RETURN .F.
        ENDIF

        *-- Legado: If (ThisForm.getDias.Value < 1) -> MessageBox + Return .f.
        loc_nDias = 0
        IF PEMSTATUS(THIS, "txt_4c_Dias", 5)
            loc_nDias = THIS.txt_4c_Dias.Value
        ENDIF

        IF loc_nDias < 1
            MsgAviso("Preencha os Dias a Considerar Para os Produtos!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN .F.
        ENDIF

        loc_cCursorProdutos = THIS.ObterCursorProdutos()

        IF EMPTY(loc_cCursorProdutos) OR !USED(loc_cCursorProdutos)
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_nInseridos = 0

        TRY
            *-- Legado: ThisForm.cnpProcessando.Top = 120
            IF PEMSTATUS(THIS, "cnt_4c_CnpProcessando", 5)
                THIS.cnt_4c_CnpProcessando.Top = 120
                THIS.cnt_4c_CnpProcessando.Refresh()
            ENDIF

            THIS.this_oBusinessObject.this_nDias = loc_nDias

            *-- Legado: pDat = fDtoSQL(...) + Do Case(This.Value) -> lcQuery
            *-- -> SqlExecute(lcQuery,'LocalCPros') - tudo isso no BO
            loc_nResultado = THIS.this_oBusinessObject.ObterProdutosEmLote(loc_nOpcao)

            IF loc_nResultado < 0
                *-- Legado: MessageBox([Favor Reinicializar o Processo!!!],16,...)
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (LocalCPros)")
            ELSE
                loc_cCursorProcessa = ALLTRIM(THIS.this_oBusinessObject.this_cCursorProcessa)

                *-- Legado: Delete From crProdutos Where Empty(CPros), ANTES
                *-- do Scan (mesma linha de RemoverLinhasEmBranco, fase 7)
                THIS.RemoverLinhasEmBranco()

                IF USED(loc_cCursorProcessa)
                    *-- Legado: Select LocalCPros / Scan
                    SELECT (loc_cCursorProcessa)
                    SCAN
                        *-- Legado: If Not Empty(LocalCPros.CPros)
                        loc_cCodigo    = ALLTRIM(NVL(CPros, ""))
                        loc_cDescricao = ALLTRIM(NVL(DPros, ""))

                        IF !EMPTY(loc_cCodigo)
                            *-- Legado: Select crProdutos / Go Top In crProdutos
                            *-- / Locate For CPros = LocalCPros.CPros - sobre o
                            *-- cursor INTEIRO, pois as linhas em branco ja
                            *-- foram removidas acima (item c do cabecalho)
                            SELECT (loc_cCursorProdutos)
                            GO TOP
                            LOCATE FOR ALLTRIM(NVL(CPros, "")) == loc_cCodigo

                            *-- Legado: If Eof([crProdutos]) -> Insert Into
                            *-- crProdutos From Memvar (Scatter de CPros/DPros)
                            IF EOF()
                                APPEND BLANK
                                REPLACE CPros WITH LEFT(loc_cCodigo, 14), ;
                                        DPros WITH LEFT(loc_cDescricao, 65)
                                loc_nInseridos = loc_nInseridos + 1
                            ENDIF

                            *-- Volta para o cursor de resultado, para o SCAN
                            *-- continuar sobre o alias certo
                            SELECT (loc_cCursorProcessa)
                        ENDIF
                    ENDSCAN

                    USE IN (loc_cCursorProcessa)
                ENDIF

                THIS.this_oBusinessObject.this_nQtdSelecionados = loc_nInseridos

                *-- Legado: ThisForm.cnpProcessando.Top = 500
                IF PEMSTATUS(THIS, "cnt_4c_CnpProcessando", 5)
                    THIS.cnt_4c_CnpProcessando.Top = 500
                ENDIF

                *-- Legado nao repete este bloco aqui (ja rodou no Init), mas
                *-- sem ele uma selecao que preencheu TODAS as linhas em
                *-- branco deixaria a grade sem onde digitar o proximo
                *-- produto (item f do cabecalho)
                THIS.GarantirLinhaEmBranco()

                *-- Legado: Select crProdutos / Go Top In crProdutos /
                *-- grdProdutos.Refresh / Go Bottom In crProdutos /
                *-- grdProdutos.Refresh
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    SELECT (loc_cCursorProdutos)
                    GO TOP
                    THIS.grd_4c_Dados.Refresh()
                    GO BOTTOM
                    THIS.grd_4c_Dados.Refresh()
                ENDIF

                *-- Legado: MessageBox([Foram Selecionados ]+Alltrim(Str(lnCnt,10))+
                *-- [ Produtos!!!], 0+64, [Selecao Concluida!!!])
                MsgInfo("Foram Selecionados " + ALLTRIM(STR(loc_nInseridos, 10)) + ;
                        " Produtos!!!", ;
                        "Sele" + CHR(231) + CHR(227) + "o Conclu" + CHR(237) + "da!!!")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message

            *-- Rede de seguranca: erro no meio do processamento nao pode
            *-- deixar o aviso "Selecionando Produtos..." cobrindo a tela
            IF PEMSTATUS(THIS, "cnt_4c_CnpProcessando", 5)
                THIS.cnt_4c_CnpProcessando.Top = 500
            ENDIF

            MsgErro("Erro ao processar produtos em lote: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Selecionar Produtos")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre o form e os containers tornando
    * visivel o que foi criado.
    *
    * Metodo PUBLIC (regra #3): o harness de teste o chama de fora.
    *
    * Esta tela NAO tem container flutuante do tipo Visible=.F./.T.
    * alternado por botao: o unico elemento "escondido" do legado
    * (cnpProcessando - fase 5) fica sempre Visible = .T. e eh deslocado
    * para Top = 500 (fora da area visivel do dialogo, Height = 600) - um
    * truque de POSICAO, nao de Visible - por isso nao precisa de filtro
    * aqui.
    *
    * Ha, porem, controles que NASCEM invisiveis no SCX e tem de continuar
    * assim: as barrinhas decorativas ImgBarra1/ImgBarra2 (e ImgBarra3, na
    * fase 5), todas com Visible = .F. no dump. Sem a lista de excecao este
    * metodo as exporia na tela, que eh o oposto do legado.
    *
    * A visibilidade que depende do CONTEXTO do form pai (cmdEscolha e, na
    * fase 5, cmdProcessar/lblDias/getDias) nao entra aqui: ela eh decidida
    * em AplicarVisibilidadePorContexto, chamado logo DEPOIS deste metodo.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis
        LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oControle = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oControle) != "O"
                LOOP
            ENDIF

            *-- Nascem Visible = .F. no SCX e assim devem ficar. Image nao eh
            *-- container (nao tem ControlCount/Controls), entao nao ha
            *-- sub-controle a recursar aqui
            IF INLIST(UPPER(loc_oControle.Name), "IMG_4C_IMGBARRA1", ;
                      "IMG_4C_IMGBARRA2", "IMG_4C_IMGBARRA3")
                *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControle, "Visible", 5)
                loc_oControle.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                IF loc_oControle.ControlCount > 0
                    FOR loc_nJ = 1 TO loc_oControle.ControlCount
                        loc_oFilho = loc_oControle.Controls(loc_nJ)

                        IF VARTYPE(loc_oFilho) = "O"
                            IF PEMSTATUS(loc_oFilho, "Visible", 5)
                                loc_oFilho.Visible = .T.
                            ENDIF
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - devolve o controle ao FormBase (que libera o BO e restaura o
    * menu - regra #52 do CLAUDE.md).
    *
    * Reabilita o form pai (legado: .ParentForm.Enabled = .f. no Init / .t.
    * no btnSair.Click) como REDE DE SEGURANCA - se o dialogo for destruido
    * por qualquer caminho alem do botao Encerrar (fase 7), o pai nao fica
    * travado. Guardado por PEMSTATUS/VARTYPE: em modo teste o form pai
    * pode ser .NULL. ou nao ter a property Enabled.
    *==========================================================================
    PROCEDURE Destroy
        IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpSprBO.prg):
*==============================================================================
* SigOpSprBO.prg - Business Object para "Selecionar Produtos" (SIGOPSPR)
*
* Origem legado : SigOpSpr.SCX  (tasks\task805)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pelo form pai)
* Tabela base   : SigCdPro | PK: CPros
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que monta a lista de produtos do form pai (o legado recebe
* "poForm" no Init, troca para a DataSession do pai e manipula o cursor
* LOCAL "crProdutos", que pertence ao pai - no migrado esse alias fica em
* THIS.this_cCursorProdutos). O usuario pode:
*   1) Inserir/Excluir linhas na grade e digitar o produto (lookup em
*      SigCdPro por CPros ou por DPros - fwBuscaExt do legado);
*   2) Processar em LOTE (tres botoes, so quando o pai eh o SIGCDBAL e
*      pcEscolha esta em INSERIR/ALTERAR):
*        Value = 1 "Produtos com Mov."  -> SigMvItn
*        Value = 2 "Produtos nao Inv."  -> SigMvEst com SQtds <> 0
*        Value = 3 "Todos nao Inv."     -> SigCdPro
*      Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
*      corte (Date() - Dias) e aplicam as faixas de filtro herdadas do pai
*      (loFil: Mercs / CGrus / SGrus / Colecoes / Linhas / IFors).
*
* GRAVACAO
* --------
* Toda escrita do legado tem por destino o CURSOR LOCAL do form pai
* (Append Blank / Insert Into crProdutos From Memvar / Delete In crProdutos);
* o acesso ao SQL Server eh 100% de leitura (Select). Por isso este BO NAO
* sobrescreve Inserir() / Atualizar() / ExecutarExclusao(): o comportamento
* padrao herdado de BusinessBase ja eh o correto, e inventar INSERT/UPDATE
* aqui violaria a regra #22 (a lista de colunas vem do schema, nunca de
* adivinhacao).
*
* METODOS DE DADOS (equivalentes a CRUD para este form de leitura)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia CPros/DPros de uma linha de
*       lookup para this_cCPros/this_cDPros.
*   MontarFiltroFaixas()               - helper PROTECTED: monta o lcWhe do
*       legado a partir das faixas herdadas do pai.
*   ObterProdutosEmLote(par_nOpcao)    - equivalente ao cmdProcessar.Click
*       (as 3 consultas SigMvItn/SigMvEst/SigCdPro). O Form faz o SCAN e o
*       Insert Into no cursor local do pai (manipulacao de cursor VFP, fora
*       deste BO).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas em MaxLength e LEFT()
* -------------------------------------------------------------------
*   SigCdPro.CPros    char(14)   SigCdPro.Mercs    char(3)
*   SigCdPro.DPros    char(65)   SigCdPro.CGrus    char(3)
*   SigMvItn.Emps     char(3)    SigCdPro.SGrus    char(6)
*   SigMvEst.Emps     char(3)    SigCdPro.Colecoes char(10)
*   SigPrIvl.Emps     char(3)    SigCdPro.Linhas   char(10)
*   SigPrIvl.DtHrs    datetime   SigCdPro.IFors    char(10)
*   SigMvEst.SQtds    numeric(11,3)
*==============================================================================

DEFINE CLASS SigOpSprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de produto selecionado
    * (colunas do cursor de produtos do form pai, espelhando SigCdPro)
    *--------------------------------------------------------------------------
    this_cCPros              = ""      && CPros char(14) - codigo do produto
    this_cDPros              = ""      && DPros char(65) - descricao do produto

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm.<x> / Set DataSession To poForm.DataSessionId
    *--------------------------------------------------------------------------
    this_cEscolha            = ""      && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_cNomeFormPai        = ""      && Upper(ParentForm.Name) - lote so quando "SIGCDBAL"
    this_nDataSessionPai     = 0       && DataSessionId do pai (poForm.DataSessionId)
    this_cEmps               = ""      && Emps char(3) - empresa corrente (go_4c_Sistema.cCodEmpresa do legado)

    *--------------------------------------------------------------------------
    * PARAMETROS DO PROCESSAMENTO EM LOTE (cmdProcessar)
    *--------------------------------------------------------------------------
    this_nOpcaoProcessamento = 0       && 1=SigMvItn  2=SigMvEst  3=SigCdPro
    this_nDias               = 0       && getDias.Value - numeric(4), InputMask "9999"
    this_dDataCorte          = {}      && Date() - Dias  (pDat do legado, via fDtoSQL)
    this_nQtdSelecionados    = 0       && lnCnt - produtos efetivamente incluidos
    this_nMaxRegistrosBusca  = 1000    && limite do fwBuscaExt legado (ultimo argumento)

    *--------------------------------------------------------------------------
    * FAIXAS DE FILTRO HERDADAS DO PAI (ParentForm.loFil)
    * Cada par monta "And p.<col> >= 'I'" / "And p.<col> <= 'F'" somente quando
    * nao esta vazio - exatamente como o legado monta lcWhe.
    *--------------------------------------------------------------------------
    this_cMercsI             = ""      && Mercs    char(3)  - inicial
    this_cMercsF             = ""      && Mercs    char(3)  - final
    this_cCGrusI             = ""      && CGrus    char(3)  - inicial
    this_cCGrusF             = ""      && CGrus    char(3)  - final
    this_cSGrusI             = ""      && SGrus    char(6)  - inicial
    this_cSGrusF             = ""      && SGrus    char(6)  - final
    this_cColecoesI          = ""      && Colecoes char(10) - inicial
    this_cColecoesF          = ""      && Colecoes char(10) - final
    this_cLinhasI            = ""      && Linhas   char(10) - inicial
    this_cLinhasF            = ""      && Linhas   char(10) - final
    this_cIForsI             = ""      && IFors    char(10) - inicial
    this_cIForsF             = ""      && IFors    char(10) - final

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorProdutos     = "cursor_4c_Produtos"       && crProdutos    - cursor do PAI, editado pela grade
    this_cCursorProcessa     = "cursor_4c_ProdProcessa"   && LocalCPros    - resultado do SELECT em lote
    this_cCursorBrancos      = "cursor_4c_LinhasBrancas"  && LocalBrancos  - linhas com CPros vazio
    this_cCursorBusca        = "cursor_4c_BuscaProduto"   && crListaRemota - lookup de SigCdPro

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSPR
    *--------------------------------------------------------------------------
    this_lHouveInclusao      = .F.     && lhouveins  - houve inclusao de linha
    this_lHouveExclusao      = .F.     && lhouveexcl - houve exclusao de linha

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de leitura (SigCdPro.CPros), herda a empresa
    * corrente (o _Empr do legado) e repoe os valores iniciais que o legado
    * tem no proprio SCX: getDias.Value = 0 e cmdProcessar.Value = 0.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"

        *-- Empresa corrente: o legado usa a PUBLIC _Empr; no sistema novo o
        *-- equivalente eh go_4c_Sistema.cCodEmpresa (ver CLAUDE.md).
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ELSE
            THIS.this_cEmps = ""
        ENDIF

        *-- Valores iniciais identicos aos do SCX legado
        THIS.this_nDias               = 0
        THIS.this_nOpcaoProcessamento = 0
        THIS.this_nQtdSelecionados    = 0
        THIS.this_dDataCorte          = DATE()
        THIS.this_lHouveInclusao      = .F.
        THIS.this_lHouveExclusao      = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCPros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de uma linha de SigCdPro (CPros,
    * DPros) para as propriedades do BO. Usado depois de um SELECT de
    * verificacao/lookup (ex.: cursor_4c_BuscaProduto) para o Form ler o
    * produto corrente sem acessar o cursor diretamente.
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCPros = TratarNulo(CPros, "C")
            THIS.this_cDPros = TratarNulo(DPros, "C")
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarFiltroFaixas - Monta o trecho "AND p.<col> >= '..' AND p.<col>
    * <= '..'" a partir das faixas herdadas do pai (loFil do legado),
    * exatamente como o cmdProcessar.Click monta lcWhe: cada faixa so entra
    * quando NAO esta vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarFiltroFaixas()
        LOCAL loc_cWhe
        loc_cWhe = ""

        IF !EMPTY(THIS.this_cMercsI)
            loc_cWhe = loc_cWhe + " AND p.Mercs >= " + EscaparSQL(ALLTRIM(THIS.this_cMercsI))
        ENDIF
        IF !EMPTY(THIS.this_cMercsF)
            loc_cWhe = loc_cWhe + " AND p.Mercs <= " + EscaparSQL(ALLTRIM(THIS.this_cMercsF))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusI)
            loc_cWhe = loc_cWhe + " AND p.CGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusF)
            loc_cWhe = loc_cWhe + " AND p.CGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusI)
            loc_cWhe = loc_cWhe + " AND p.SGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusF)
            loc_cWhe = loc_cWhe + " AND p.SGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesI)
            loc_cWhe = loc_cWhe + " AND p.Colecoes >= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesI))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesF)
            loc_cWhe = loc_cWhe + " AND p.Colecoes <= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesF))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasI)
            loc_cWhe = loc_cWhe + " AND p.Linhas >= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasI))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasF)
            loc_cWhe = loc_cWhe + " AND p.Linhas <= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasF))
        ENDIF
        IF !EMPTY(THIS.this_cIForsI)
            loc_cWhe = loc_cWhe + " AND p.IFors >= " + EscaparSQL(ALLTRIM(THIS.this_cIForsI))
        ENDIF
        IF !EMPTY(THIS.this_cIForsF)
            loc_cWhe = loc_cWhe + " AND p.IFors <= " + EscaparSQL(ALLTRIM(THIS.this_cIForsF))
        ENDIF

        RETURN loc_cWhe
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProdutosEmLote - Equivalente ao cmdProcessar.Click do legado.
    * par_nOpcao: 1 = "Produtos com Mov." (SigMvItn)
    *             2 = "Produtos nao Inv." (SigMvEst com SQtds <> 0)
    *             3 = "Todos nao Inv."    (SigCdPro)
    * Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
    * corte (Date() - Dias) e aplicam as faixas herdadas do pai. Resultado
    * fica em THIS.this_cCursorProcessa (equivalente a LocalCPros); quem
    * chama (o Form) faz o SCAN e o Insert Into no cursor local do pai -
    * esse ultimo passo eh manipulacao de cursor VFP, nao SQL, e por isso
    * fica fora deste BO (ver cabecalho: toda escrita vai para o cursor do
    * form pai).
    *
    * Retorna o numero de linhas (>= 0) ou -1 em falha de conexao/opcao
    * invalida - igual ao "< 1" do SqlExecute legado.
    *--------------------------------------------------------------------------
    FUNCTION ObterProdutosEmLote(par_nOpcao)
        LOCAL loc_cSQL, loc_cWhe, loc_cDataCorte, loc_nResultado

        IF THIS.this_nDias < 1
            RETURN -1
        ENDIF

        THIS.this_nOpcaoProcessamento = par_nOpcao
        THIS.this_dDataCorte          = DATE() - THIS.this_nDias
        loc_cDataCorte                = FormatarDataSQL(THIS.this_dDataCorte)
        loc_cWhe                      = THIS.MontarFiltroFaixas()

        DO CASE
            CASE par_nOpcao = 1
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvItn a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 2
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvEst a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND NOT a.SQtds = 0" +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 3
                loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros" +;
                           " FROM SigCdPro p" +;
                           " WHERE p.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" + loc_cWhe +;
                           " ORDER BY p.CPros"

            OTHERWISE
                RETURN -1
        ENDCASE

        IF USED(THIS.this_cCursorProcessa)
            USE IN (THIS.this_cCursorProcessa)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProcessa)

        RETURN loc_nResultado
    ENDFUNC

ENDDEFINE


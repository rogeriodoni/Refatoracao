# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 4/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-09 02:50:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-09 02:50:10] [INFO] Config FPW: (nao fornecido)
[2026-11-09 02:50:10] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 02:50:10] [INFO] Timeout: 300 segundos
[2026-11-09 02:50:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oe4zlxeo.prg
[2026-11-09 02:50:10] [INFO] Conteudo do wrapper:
[2026-11-09 02:50:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpMop', 'C:\4c\tasks\task767\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpMop', 'C:\4c\tasks\task767\logs\06_testForm.log'
QUIT

[2026-11-09 02:50:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oe4zlxeo.prg
[2026-11-09 02:50:10] [INFO] VFP output esperado em: C:\4c\tasks\task767\vfp_output.txt
[2026-11-09 02:50:11] [INFO] Executando Visual FoxPro 9...
[2026-11-09 02:50:11] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oe4zlxeo.prg
[2026-11-09 02:50:11] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oe4zlxeo.prg
[2026-11-09 02:50:11] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpMop
Inicio: 09/11/2026 02:50:11

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 09/11/2026 02:51:26
Duracao: 75 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-09 02:51:26] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-09 02:51:26] [INFO] VFP9 finalizado em 75.4348341 segundos
[2026-11-09 02:51:26] [INFO] Exit Code: 
[2026-11-09 02:51:26] [INFO] 
[2026-11-09 02:51:27] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-09 02:51:27] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oe4zlxeo.prg
[2026-11-09 02:51:27] [INFO] 
[2026-11-09 02:51:27] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-09 02:51:27] [INFO] * Auto-generated wrapper for parameters
[2026-11-09 02:51:28] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 02:51:28] [INFO] * Parameters: 'FormSigOpMop', 'C:\4c\tasks\task767\logs\06_testForm.log'
[2026-11-09 02:51:28] [INFO] 
[2026-11-09 02:51:28] [INFO] * Anti-dialog protections for unattended execution
[2026-11-09 02:51:29] [INFO] SET SAFETY OFF
[2026-11-09 02:51:29] [INFO] SET RESOURCE OFF
[2026-11-09 02:51:29] [INFO] SET TALK OFF
[2026-11-09 02:51:29] [INFO] SET NOTIFY OFF
[2026-11-09 02:51:29] [INFO] SYS(2335, 0)
[2026-11-09 02:51:30] [INFO] 
[2026-11-09 02:51:30] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpMop', 'C:\4c\tasks\task767\logs\06_testForm.log'
[2026-11-09 02:51:30] [INFO] QUIT
[2026-11-09 02:51:30] [INFO] 
[2026-11-09 02:51:30] [INFO] === Fim do Wrapper.prg ===
[2026-11-09 02:51:30] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMop.prg):
*==============================================================================
* FormSigOpMop.prg - Form OPERACIONAL: Geracao de Multiplas Operacoes
* Migrado de: tasks/task767/SigOpMop.SCX (SIGOPMOP)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo filho do Cadastro de Operacoes
*
* Esta tela NAO eh um cadastro paginado: o SCX legado herda de "form" PURO
* (nao de frmcadastro), nao declara PageFrame nenhum e nao tem as duas paginas
* Lista/Dados. Eh um dialogo filho, aberto pelo Cadastro de Operacoes
* (SIGCDOPE -> FormOPE), com 759x430, TitleBar = 0 e Movable = .F.: uma faixa
* de cabecalho (cntSombra), UMA grade de 7 colunas (GradeSubN) ligada as linhas
* de SigCdMop da operacao corrente, um Shape que emoldura a barra de botoes e
* TRES botoes pendurados direto na Form (cmdInserir, cmdExcluir, cmdSair).
*
* Cada linha da grade amarra a operacao PAI (cdopes) a uma operacao FILHA
* (cnivels), com cor, marca de padrao, ordem, grande grupo e empresa de
* destino - ver o cabecalho de SigOpMopBO.prg para o mapa das colunas.
*
* Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades de estado,
* Init() recebendo o contexto do form chamador, InicializarForm(),
* ConfigurarPageFrame(), Destroy()) e a faixa do cabecalho
* (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo), com geometria TRANSCRITA
* do dump (tasks/task767/layout.json + SECAO 2 do arquivo de extracao).
*
* Fase 4/8 - GRADE E BOTOES DE ACAO: a grade de 7 colunas (grd_4c_Dados), a
* moldura (shp_4c_Shape1), os TRES botoes (cmd_4c_CmdInserir /
* cmd_4c_CmdExcluir / cmd_4c_CmdSair) com a regra de permissao do Init legado,
* a ordem de tabulacao e o funil de carga (CarregarDados -> MontaGrade ->
* ConfigurarColunasGrade / GarantirCheckBoxPadrao), mais os dois metodos de
* carga que isso exige no BO (CarregarConfiguracaoOperacao e CarregarGrade).
*
* NAO HA barra de seis botoes CRUD nem PageFrame Lista/Dados para esta fase
* entregar, e isso foi MEDIDO no dump, nao presumido: a SECAO 1 lista 25
* objetos, com ZERO "BaseClass: pageframe", UM "BaseClass: grid" (GradeSubN) e
* exatamente tres "BaseClass: commandbutton" (cmdExcluir, cmdSair, cmdInserir),
* todos com "Parent: SIGOPMOP". A superficie desta tela eh a GRADE, e eh ela
* que esta fase entrega - inventar Lista/Dados com Incluir/Alterar/Excluir/
* Buscar violaria o PILAR 1, e criar ConfigurarPaginaLista()/AlternarPagina()
* vazios so para casar com o roteiro generico seria o stub disfarcado que a
* regra de completude proibe.
*
* Fase 5/8 - CELULAS DIGITAVEIS SEM LOOKUP (Movimentacao e Cores): o When/
* Valid/LostFocus de Column1 (TextBoxMovimentacaoMop_4c) e Column3
* (TextBoxCoresMop_4c), instalados via Column.AddObject + CurrentControl +
* Sparse = .F. (regra #18/#46 - BINDEVENT em evento de celula de Grid NAO eh
* confiavel). GarantirCelulasEditaveisGrade() reinstala as duas celulas a
* cada MontaGrade(), pela mesma razao de GarantirCheckBoxPadrao(): o bind do
* cursor DERRUBA o que foi posto por AddObject.
*
* O Valid de "Cores" (ValidarCoresMopExec) ficou na Fase 5 porque usa
* GETCOLOR() - funcao NATIVA do VFP9 (seletor de cor do Windows), nao consulta
* em tabela: nao eh lookup, logo nao eh materia desta fase.
*
* Fase 6/8 - LOOKUPS DAS CELULAS DA GRADE: os TRES lookups que o dump declara,
* todos no Valid de uma celula de Column (nunca em AfterRowColChange, que
* entrega a coluna de DESTINO e validaria a linha errada - regra #46):
*
*   Column1 "Movimentacao" -> SigCdOpe   (dopes char(20) + ndopes numeric(4,0))
*       ValidarMovimentacaoMopExec/Corpo + ObterOperacaoInativa (a recusa de
*       operacao INATIVA, que o legado le do cursor de SigOpCdc), e o REPLACE
*       de ndopes, que eh o que preenche a coluna "  #  " da grade.
*   Column6 "G.Grp"        -> SigCdGpr   (codigos char(3) + descs char(40))
*       ValidarGrandeGrupoMopExec/Corpo mais o par GotFocus/LostFocus que o
*       legado usa como detector de alteracao (Tag de entrada x valor de saida
*       ligando this_lHouveInsercao).
*   Column7 "Emp."         -> SigCdEmp   (cemps char(3) + razas char(40))
*       ValidarEmpresaMopExec/Corpo.
*
* As duas celulas novas (TextBoxGrandeGrupoMop_4c e TextBoxEmpresaMop_4c, em
* classes\TextBoxGridLookup.prg) sao instaladas por
* GarantirCelulasEditaveisGrade() junto com as da Fase 5, pelo mesmo motivo de
* idempotencia: CarregarGrade() derruba o alias da grade e isso destroi o que
* foi posto por Column.AddObject. Como elas passam a ser o CurrentControl das
* Columns 6 e 7, os .Text1.* dessas colunas sairam de ConfigurarColunasGrade -
* a coluna deixa de desenhar o Text1, e manter aquelas linhas seria codigo
* morto. MaxLength vem da LARGURA DA COLUNA no schema (3, 3 e 20), nunca do
* Width em pixels (regra #19).
*
* Os tres lookups passam pelo contrato do FormBuscaAuxiliar (regra #37): 1o
* argumento eh o HANDLE da conexao, Show() SO quando this_lAchouRegistro eh
* .F. (com match exato o dialogo subiria por cima da celula ja resolvida) e
* atribuicao SO dentro da guarda this_lSelecionou - o legado le o cursor do
* picker mesmo quando o usuario sai com ESC, e com isso a celula recebia a
* primeira linha da busca parcial sem ninguem ter escolhido. Universo vazio
* NAO gera aviso nem apaga o que foi digitado (regra #50). Cada divergencia
* deliberada em relacao ao legado esta justificada no metodo correspondente.
*
* Os tres Exec sao WRAPPERS da guarda de reentrancia this_lEmLookup, com o
* corpo num <Nome>Corpo separado: o picker eh MODAL, tira o foco da celula e
* pode redisparar o proprio Valid, e corpo com RETURN antecipado dentro do
* wrapper deixaria a flag travada ligada, matando o lookup pelo resto da vida
* do form (regra #47).
*
* Sem conexao (harness/validacao de UI) nenhum dos tres lookups roda e o valor
* digitado eh aceito como esta: SQLEXEC com handle invalido dispara excecao, e
* Show() de form MODAL em teste headless travaria o processo.
*
* Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: BtnInserirClick/BtnExcluirClick
* (cmd_4c_CmdInserir/cmd_4c_CmdExcluir, TRANSCRITOS do Click do legado) e
* BtnEncerrarClick (cmd_4c_CmdSair - nome CANONICO que TesteAutomatico.prg
* procura), mais a alternancia exclusiva do CheckBox "Padrao" (Column4),
* instalada em GarantirCheckBoxPadrao com os 4 handlers Click/MouseDown/
* MouseUp/KeyPress + NODEFAULT (checkbox em coluna de Grid NAO alterna pelo
* binding nativo), e ControlarBotoesFormPai - equivalente ao mCtrlBotoes do
* legado, chamado por HabilitarFormPai com o MESMO par_lHabilitar, que
* desliga/religa granularmente os botoes do form chamador (FormOPE: o grupo
* CRUD cnt_4c_Botoes, cmd_4c_MultiSubN e cnt_4c_Saida.cmd_4c_Encerrar, todos
* na Page1 - Lista).
*
* Fase 8/8 - CONSOLIDACAO FINAL (gravacao): o bloco interno do cmdSair.Click
* legado, que as fases anteriores deixaram para esta, e os hooks de
* transferencia entre a linha da grade e o objeto de negocio.
*
*   BtnEncerrarClick  - agora completo, com os DOIS guards do legado (modo de
*       edicao pela visibilidade de Inserir/Excluir, e "houve mudanca?" pelas
*       flags lHouveIns/lHouveExcl) e os DOIS desfechos distintos do legado:
*       duplicidade ABORTA o encerramento ("Return .f." de dentro do Click),
*       falha de gravacao apenas avisa e a tela fecha.
*   ValidarDuplicidadeGrade - o "Select ... GROUP by 1,2,3 Into cursor Totais"
*       + Scan por TT > 1, agrupando por cNivels + Mercs + EmpDs.
*   GravarGrade       - o "poDataMgr.UpDate('crSigCdMop')" + Commit/RollBack.
*       Como o cursor desta arquitetura nao tem buffer de view remota (regra
*       #52), o estado novo/alterado/apagado eh RECONSTRUIDO por
*       RECONCILIACAO contra o banco, com UMA consulta de chaves
*       (BO.CarregarChavesGravadas) - ver o comentario do metodo.
*   LocalizarChave    - a busca de chave usada pela reconciliacao, por LOCATE
*       com ALLTRIM (SET EXACT ON torna SEEK sobre char(20) dependente do
*       padding exato - regra #42) e preservando alias/RECNO do chamador.
*   FormParaBO / BOParaForm - transferencia linha-da-grade <-> BO. A "ficha"
*       desta tela eh a LINHA da grade, nao uma pagina de Dados: as nove
*       colunas do cursor sao as nove colunas de SigCdMop. Os dois sao
*       PROTECTED **EXPLICITO**: FormBase.prg declara os dois nomes como
*       PROTECTED e VFP9 NAO deixa a subclasse alargar esse escopo - omitir o
*       modificador nao os tornaria publicos, so esconderia o fato. Quem os
*       chama eh GravarGrade, por THIS., de dentro da classe.
*   CarregarLista     - entrada PUBLICA de recarga da superficie de lista (que
*       aqui eh a grade), preservando a linha corrente pela cidchaves.
*
* Tambem nesta fase, no BO: ExecutarExclusao (sem ele a linha apagada na grade
* ficava no banco), CarregarChavesGravadas, ConfirmarGravacao/DesfazerGravacao
* (o par Commit/RollBack, que eh passo com caminho de falha PROPRIO no legado e
* nao detalhe de infraestrutura) e a troca do INNER JOIN de CarregarGrade por
* LEFT JOIN - sem ela a linha de cnivels em branco, que o legado grava, nao
* voltava do banco e a reconciliacao a APAGARIA em silencio.
*
* O QUE A FASE 8 NAO ENTREGA, e por que (medido no dump, nao presumido):
*   - BtnSalvarClick / BtnCancelarClick / BtnBuscarClick: a SECAO 1 do dump
*     lista 25 objetos e os UNICOS CommandButton sao cmdInserir, cmdExcluir e
*     cmdSair, os tres com "Parent: SIGOPMOP". Nao ha Salvar, nao ha Cancelar e
*     nao ha Buscar - a gravacao mora no cmdSair ("Encerrar"), que eh quem roda
*     o UpDate/Commit, e nao existe edicao cancelavel: a grade escreve direto no
*     cursor. Criar esses handlers exigiria inventar botoes que o legado nao tem
*     (contra o PILAR 1) ou deixar metodos vazios (contra a regra de
*     completude).
*   - AjustarBotoesPorModo / HabilitarCampos / LimparCampos: convencao do
*     frmcadastro, que tem Page1(Lista)/Page2(Dados) e modos INCLUIR/ALTERAR/
*     VISUALIZAR/EXCLUIR. O SCX aqui herda de "form" PURO, nao declara
*     PageFrame nenhum e nao tem modo proprio - o unico "modo" eh o do form PAI
*     (PcEscolha), e ele ja eh aplicado por AplicarPermissoesBotoes
*     (visibilidade de Inserir/Excluir, transcrita do Init legado) e pelo When
*     das celulas. Em particular, travar a grade em PROCURAR seria DIVERGIR: o
*     legado deixa as celulas editaveis em consulta e impede a gravacao pelo
*     guard de visibilidade do cmdSair - e eh esse guard que BtnEncerrarClick
*     reproduz.
*
* NAO HA container de Salvar/Cancelar para esta fase entregar, e isso foi LIDO
* no dump: a SECAO 1 lista 25 objetos e os unicos CommandButton sao
* cmdInserir, cmdExcluir e cmdSair, os tres com "Parent: SIGOPMOP" e os tres
* JA criados na Fase 4. Esta tela nao eh um frmcadastro: nao tem pagina de
* Dados, nao tem Grupo_Salva e nao tem o par Confirmar/Cancelar. A gravacao
* mora no cmdSair ("Encerrar"), que eh quem roda o UpDate/Commit do legado -
* criar aqui um cnt_4c_BotoesAcao com Salvar/Cancelar inventaria interface que
* o legado nao possui, contra o PILAR 1.
*
* NENHUM metodo vazio foi criado para "cumprir fase": ConfigurarPageFrame()
* orquestra apenas o que esta entregue. Vincular BINDEVENT a metodo
* inexistente aborta a inicializacao do form, e metodo vazio viola a regra de
* completude - por isso os BINDEVENT dos botoes entram junto com os handlers
* que eles chamam, na Fase 7. Os botoes JA nascem com geometria, icone e a
* regra de permissao do legado: o que falta neles eh so a acao do clique.
*
* NAO existe barra de seis botoes de cadastro (inclusao/alteracao/consulta/
* remocao/busca) nesta tela, e isso foi LIDO no dump, nao presumido: a SECAO 1
* lista 25 objetos e os unicos CommandButton sao cmdExcluir, cmdSair e
* cmdInserir, todos com "Parent: SIGOPMOP". Nao ha CommandGroup, nao ha
* Grupo_Op nem Grupo_Saida, e o SCX nao declara a variavel de modo do
* frmcadastro. Reproduzir aqui aquela barra seria inventar interface que o
* legado nao possui, contra o PILAR 1.
*
* DataSession = 1 (sessao CORRENTE, nao "sessao global 1") eh o equivalente
* fiel ao "Set DataSession to pnDataSes" do Init legado: o dialogo passa a
* rodar na mesma sessao de dados do form chamador, e o cursor da grade cruza
* a fronteira normalmente. Medido no VFP9: form com DataSession = 1
* instanciado de dentro de um form DataSession = 2 roda na sessao PRIVADA do
* pai. O parametro par_nDataSession continua na assinatura por paridade com o
* legado e fica guardado em this_nDataSessionPai para rastreio, mas NAO se
* emite "SET DATASESSION TO" aqui: com DataSession = 1 o form ja esta na
* sessao do chamador, e o SET global deixaria efeito colateral depois do
* Release.
*==============================================================================

DEFINE CLASS FormSigOpMop AS FormBase

    *-- Geometria e aparencia TRANSCRITAS de SIGOPMOP (SECAO 2 do dump)
    Height       = 430
    Width        = 759
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    BorderStyle  = 2
    DataSession  = 1
    AutoCenter   = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- WindowType = 0 na CLASSE (modal bloquearia o harness headless com
    *-- timeout); o Init restaura 1 em producao. Mesmo padrao dos dialogos
    *-- filhos irmaos (FormSIGOPCOR/FormSIGOPCCO).
    WindowType   = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Contexto recebido do form chamador - equivalente as properties
    * customizadas que o SCX legado guarda na Form:
    *   ParentForm -> this_oFormPai        (Thisform.ParentForm)
    *   PcEscolha  -> this_cEscolha        (Thisform.PcEscolha)
    * mais a operacao PAI, que no legado era lida do cursor compartilhado
    * crSigCdOpe (lcOperacao = crSigCdOpe.Dopes) e aqui chega explicita.
    *--------------------------------------------------------------------------
    this_oFormPai        = .NULL.
    this_cEscolha        = ""
    this_cOperacaoPai    = ""
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * Estado da edicao da grade - equivalente as flags do legado:
    *   lHouveIns  -> this_lHouveInsercao  (ligada em cmdInserir.Click e nos
    *                                       Valid/Click das colunas editaveis)
    *   lHouveExcl -> this_lHouveExclusao  (ligada em cmdExcluir.Click)
    *   Antvalue   -> this_nValorAnterior  (guardado no When das colunas Cores
    *                                       e Padrao, para detectar mudanca)
    * As duas flags sao o que o cmdSair.Click do legado consulta para decidir
    * se grava ("If ( Thisform.lHouveExcl Or Thisform.lHouveIns )") - por isso
    * nascem em .F. e sao propriedades do FORM, nao do BO.
    *--------------------------------------------------------------------------
    this_lHouveInsercao = .F.
    this_lHouveExclusao = .F.
    this_nValorAnterior = 0

    *--------------------------------------------------------------------------
    * Guarda de REENTRANCIA dos lookups das celulas da grade.
    *
    * FormBuscaAuxiliar eh MODAL: o Show() bloqueia, tira o foco da celula e
    * pode fazer o proprio Valid disparar de novo quando o foco volta -
    * empilhando um segundo picker sobre o primeiro. A flag eh ligada no
    * WRAPPER de cada lookup (Validar<X>MopExec) e liberada por ele DEPOIS do
    * corpo, para valer tambem quando o corpo sai por um caminho de recusa.
    *
    * O corpo mora num metodo separado (Validar<X>MopCorpo) exatamente por
    * isso: corpo com RETURN antecipado dentro do proprio wrapper deixaria a
    * flag TRAVADA ligada e mataria o lookup pelo resto da vida do form.
    *--------------------------------------------------------------------------
    this_lEmLookup = .F.

    *--------------------------------------------------------------------------
    * Modo de operacao da tela. Nasce em "EDICAO" e nao em "LISTA" porque esta
    * tela nao tem pagina de lista: a grade EH a superficie de trabalho, e o
    * que define se ela aceita digitacao eh o modo do form PAI (this_cEscolha),
    * nao um modo proprio alternado por botoes.
    *--------------------------------------------------------------------------
    this_cModoAtual = "EDICAO"

    *--------------------------------------------------------------------------
    * Cursor da grade. Nome centralizado numa property para a grade nao perder
    * o bind quando as fases seguintes recarregarem os dados (o BO usa o mesmo
    * nome em this_cCursorDados).
    *--------------------------------------------------------------------------
    this_cCursorDados = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - recebe o contexto do form chamador, igual ao
    * "LParameters poForm, pnDataSes, pcEscolha" do Init legado, mais a
    * operacao PAI (que no legado vinha do cursor compartilhado crSigCdOpe).
    *
    * O Caption reproduz o do legado:
    *   'Geracao de Multiplas Operacoes ' + AllTrim( Proper( crSigCdOpe.Dopes ) )
    * Sem operacao informada fica so o titulo, sem o espaco sobrando no fim.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_nDataSession, par_cEscolha, par_cOperacaoPai)
        LOCAL loc_cTitulo, loc_cOperacao

        THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", UPPER(ALLTRIM(par_cEscolha)), "")
        THIS.this_cOperacaoPai    = IIF(VARTYPE(par_cOperacaoPai) = "C", ALLTRIM(par_cOperacaoPai), "")
        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSession) = "N", par_nDataSession, 0)

        loc_cTitulo   = "Gera" + CHR(231) + CHR(227) + "o de Multiplas Opera" + CHR(231) + CHR(245) + "es"
        loc_cOperacao = ALLTRIM(PROPER(THIS.this_cOperacaoPai))

        IF !EMPTY(loc_cOperacao)
            loc_cTitulo = loc_cTitulo + " " + loc_cOperacao
        ENDIF

        THIS.Caption = loc_cTitulo

        *-- WindowType = 1 (modal) so em producao: no harness headless o Show()
        *-- modal bloqueia a execucao e a instanciacao estoura por timeout.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, repassa a ele o contexto
    * recebido do form chamador, monta a estrutura visual e desabilita o form
    * PAI enquanto o dialogo esta aberto ("Thisform.ParentForm.Enabled = .F."
    * do Init legado). A reabilitacao mora no Destroy - ver o comentario de la.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpMopBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpMopBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                *-- Contexto do form chamador para o BO: a operacao PAI entra em
                *-- cdopes de toda linha nova (InicializarValoresPadrao) e o modo
                *-- governa quem pode inserir/excluir.
                THIS.this_oBusinessObject.this_cOperacaoPai = THIS.this_cOperacaoPai
                THIS.this_oBusinessObject.this_cEscolha     = THIS.this_cEscolha

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                *-- Caption nos dois labels da faixa, como o Init legado faz:
                *-- ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
                *-- ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- DEPOIS da varredura: ela forca Visible = .T. em tudo e
                *-- apagaria a decisao de permissao de Inserir/Excluir.
                THIS.AplicarPermissoesBotoes()

                *-- Depois do ULTIMO AddObject: TabIndex fora da faixa 1..N eh
                *-- descartado em silencio.
                THIS.AjustarOrdemTabulacao()

                *-- Configuracao da operacao + linhas da grade + bind visual
                THIS.CarregarDados()

                *-- "Thisform.ParentForm.Enabled = .F." + "Thisform.mCtrlBotoes(.F.)"
                *-- do Init legado: o chamador (form inteiro + botoes
                *-- granulares) fica inerte enquanto este dialogo esta aberto.
                THIS.HabilitarFormPai(.F.)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual da tela.
    *
    * NAO existe PageFrame real: o legado SIGOPMOP eh flat (a SECAO 1 do dump
    * nao declara nenhum objeto de BaseClass pageframe, e as referencias a
    * "Pagina.Lista" no codigo dos metodos sao do form PAI, via
    * Thisform.ParentForm.Pagina.Lista). O nome do metodo eh mantido por
    * conformidade com o contrato do pipeline multi-fase.
    *
    * ORDEM IMPORTA: os tres botoes do legado ficam em Top = 3 com altura de
    * botao do framework, ou seja DENTRO da area da faixa (Top 0, Height 80).
    * Eles tem de ser criados DEPOIS dela para desenhar POR CIMA - invertido,
    * o cabecalho cobriria Inserir/Excluir/Encerrar. Por isso a faixa eh o
    * PRIMEIRO AddObject da tela, e as chamadas das fases seguintes
    * (ConfigurarGrade/ConfigurarBotoes) entram ABAIXO desta linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- A ordem abaixo eh a ORDEM DA ARVORE do SCX (SECAO 1 do dump):
        *-- cntSombra -> GradeSubN -> Shape1 -> cmdExcluir/cmdSair/cmdInserir.
        *-- Isso NAO eh estilo, eh z-order: o Shape1 tem BackStyle = 0 E
        *-- BorderStyle = 0 (nao desenha NADA) e, depois do reposicionamento
        *-- que AplicarPermissoesBotoes faz, cobre a faixa dos tres botoes
        *-- (Left 528..769 / Top 7..48 contra botoes em Left 533..758 /
        *-- Top 3..78). Criado DEPOIS deles, esse retangulo invisivel ficaria
        *-- por cima e BLOQUEARIA o clique sem desenhar nada; no SCX ele vem
        *-- antes e os botoes recebem o clique.
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrade()
        THIS.ConfigurarMoldura()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa cinza do titulo (SIGOPMOP.cntSombra) com os
    * dois labels sobrepostos: lblSombra em preto por tras e lblTitulo em
    * branco por cima, o que produz o relevo do framework legado.
    *
    * Geometria TRANSCRITA do dump:
    *   cntSombra  Top=0  Left=0  Width=800 Height=80 BackColor=100,100,100
    *              BorderWidth=0
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, BackStyle=0, WordWrap=.T., Alignment=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, BackStyle=0, WordWrap=.T., Alignment=0
    *
    * O Width = 800 do container legado eh MAIOR que o Width = 759 do form (o
    * cntSombra do framework.vcx vem dimensionado para a tela de 800px e fica
    * recortado nesta); aqui usa-se THIS.Width para a faixa cobrir a largura
    * real sem sobra nem corte - o resultado visivel eh o mesmo, porque o
    * excedente do legado nunca foi desenhado.
    *
    * AutoSize = .F. explicito nos dois labels: AutoSize eh no-op em Label
    * criado por AddObject (a largura ficaria nos 100 do default) e, com
    * WordWrap = .T., descartaria a Height transcrita e cortaria a segunda
    * linha do titulo. Os Width/Height do dump JA sao o auto-size que o Form
    * Designer calculou, entao fixa-los eh reproducao fiel.
    *
    * ForeColor branco eh legitimo AQUI: lbl_4c_LblTitulo esta dentro de um
    * container OPACO escuro (BackStyle = 1 + BackColor 100,100,100), nao
    * sobre a textura clara do fundo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
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

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
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

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
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

    *--------------------------------------------------------------------------
    * ConfigurarGrade - cria a grade de operacoes multiplas (SIGOPMOP.GradeSubN)
    * com as propriedades de NIVEL DE GRADE, geometria TRANSCRITA do dump:
    *
    *   GradeSubN  Top=99 Left=58 Width=483 Height=311  ColumnCount=7
    *              FontName="Tahoma" FontSize=8  RowHeight=16  ScrollBars=2
    *              DeleteMark=.F.  GridLineColor=238,238,238  TabIndex=1
    *
    * O que este metodo NAO faz, de proposito: NAO define ColumnCount nem
    * toca nas Columns. Medido no VFP9 - Grid cuja RecordSource ainda nao foi
    * atribuida se AUTO-LIGA ao alias CORRENTE no instante em que o
    * ColumnCount eh definido, e a Column cai na coluna que estiver naquela
    * posicao do alias. Se for coluna de TEXTO, o AddObject do CheckBox da
    * coluna "Padrao" estoura "Data type mismatch" DENTRO do AddObject (o
    * .Value do CheckBox nasce NUMERICO) - e o erro cai no TRY de
    * InicializarForm, que devolve .F., o CREATEOBJECT devolve o logico .F. e
    * o usuario aciona a opcao e NADA acontece, sem erro na tela e sem log.
    *
    * Por isso a sequencia INTEIRA (ColumnCount -> RecordSource ->
    * ControlSource de TODAS as colunas -> AddObject do CheckBox ->
    * CurrentControl -> largura/cabecalho) vive num funil unico, MontaGrade,
    * que roda em TODA repintura - nao aqui.
    *
    * RecordMark/DeleteMark em .F.: o dump declara so DeleteMark = .F. (a
    * classe eh "grid" cru, entao RecordMark ficava no default .T.), mas a
    * convencao do projeto para grade de form OPERACIONAL criada por
    * AddObject eh desligar as DUAS barras de marcacao. Nao ha perda
    * funcional - a linha corrente, que eh o que o botao Excluir consome,
    * tambem muda ao clicar em qualquer celula.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top           = 99
            .Left          = 58
            .Width         = 483
            .Height        = 311
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowHeight     = 16
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLineColor = RGB(238, 238, 238)
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMoldura - Shape que emoldura a barra de botoes
    * (SIGOPMOP.Shape1), geometria TRANSCRITA do dump:
    *
    *   Shape1  Top=7 Left=229 Height=41 Width=59
    *           BackStyle=0  BorderStyle=0  BorderColor=136,189,188
    *
    * BackStyle = 0 (transparente) com BorderStyle = 0 (sem borda) significa
    * que este Shape NAO desenha nada - nem fundo, nem contorno. Ele eh
    * transcrito por fidelidade (PILAR 1) e porque o Init legado reposiciona
    * Left/Width dele em funcao de QUAIS botoes ficaram visiveis; esse
    * recalculo esta em AplicarPermissoesBotoes, com os valores de 229/59
    * aqui representando o estado de projeto, antes do ajuste.
    *
    * BorderColor transcrito mesmo com BorderStyle = 0: eh o valor do dump, e
    * manter os dois juntos deixa explicito que o invisivel eh intencional, e
    * nao propriedade esquecida.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMoldura()
        THIS.AddObject("shp_4c_Shape1", "Shape")

        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 229
            .Height      = 41
            .Width       = 59
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - os TRES botoes da tela, pendurados DIRETO na Form
    * (nao ha container de botoes nem CommandGroup no SCX - a SECAO 1 lista
    * cmdExcluir/cmdSair/cmdInserir todos com "Parent: SIGOPMOP").
    *
    * Geometria TRANSCRITA do dump:
    *   cmdInserir Top=3 Left=533 Picture=cadastro_inserir_60.jpg Caption="Inserir"  TabIndex=4
    *   cmdExcluir Top=3 Left=608 Picture=cadastro_excluir_60.jpg Caption="Excluir"  TabIndex=2
    *   cmdSair    Top=3 Left=683 Picture=cadastro_sair_60.jpg    Caption="Encerrar" TabIndex=3 Cancel=.T.
    *
    * Width/Height: o dump NAO os declara (vinham da classe fwbtng do
    * framework legado, que nao foi portada). O passo entre os Left do SCX eh
    * de EXATAMENTE 75 (533 -> 608 -> 683), e 683 + 75 = 758 fecha na borda do
    * form de 759 - logo 75x75 eh a medida que o layout legado pressupoe, e eh
    * tambem a medida canonica dos botoes do projeto. As posicoes canonicas de
    * cnt_4c_Saida (Left = 917) NAO se aplicam aqui: sao dos cadastros de
    * 1000px e cairiam 158px fora desta tela.
    *
    * Picture TRANSCRITO do dump, nunca escolhido por semelhanca: o VFP9
    * aceita .Picture apontando para arquivo inexistente em SILENCIO (sem erro
    * de compilacao, sem erro de runtime, sem log) e o botao simplesmente nao
    * desenha icone. Os tres arquivos foram conferidos em vbmp\.
    *
    * Themes = .T. + DisabledPicture: estes sao CommandButton STANDALONE (fora
    * de CommandGroup) e o legado DESABILITA dois deles por permissao. Com
    * Themes = .F. + Enabled = .F. o icone nao renderiza e o botao vira uma
    * caixa com texto. A excecao Themes = .F. vale para Buttons(N) DENTRO de
    * CommandGroup, que nao eh o caso aqui.
    *
    * Enabled = .T. e Visible = .T. nascem ligados: quem decide eh
    * AplicarPermissoesBotoes, que roda DEPOIS de TornarControlesVisiveis
    * (essa varredura forca Visible = .T. em tudo e apagaria a decisao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Ordem de criacao = ordem da arvore do SCX
        THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH THIS.cmd_4c_CmdExcluir
            .Top             = 3
            .Left            = 608
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Themes          = .T.
            .SpecialEffect   = 0
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Excluir a linha corrente da grade"
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirClick")

        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 3
            .Left            = 683
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Themes          = .T.
            .SpecialEffect   = 0
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            *-- Cancel = .T. TRANSCRITO do dump: eh o que faz o ESC encerrar o
            *-- dialogo, e eh a UNICA saida desta tela (TitleBar = 0 e
            *-- ControlBox = .F., ou seja nao ha botao de fechar da janela).
            .Cancel          = .T.
            .ToolTipText     = "Gravar as altera" + CHR(231) + CHR(245) + "es e encerrar"
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnEncerrarClick")

        THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH THIS.cmd_4c_CmdInserir
            .Top             = 3
            .Left            = 533
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .PicturePosition = 13
            .Themes          = .T.
            .SpecialEffect   = 0
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Inserir uma nova opera" + CHR(231) + CHR(227) + "o na grade"
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarFormPai - liga/desliga o form chamador E os botoes granulares
    * dele, equivalente ao par que o legado sempre aciona JUNTO:
    *   Init:          Thisform.ParentForm.Enabled = .F. + Thisform.mCtrlBotoes(.F.)
    *   cmdSair.Click: Thisform.ParentForm.Enabled = .T. + Thisform.mCtrlBotoes(.T.)
    *
    * O controle GRANULAR (mCtrlBotoes do legado) mora em
    * ControlarBotoesFormPai - aqui so delega, com o MESMO par_lHabilitar,
    * porque o legado nunca desacopla os dois.
    *
    * Guardado por PEMSTATUS porque o dialogo tambem pode ser instanciado sem
    * pai (harness de teste e validacao de UI chamam CREATEOBJECT sem
    * parametro) - sem a guarda, o Init falharia nesse cenario e o
    * CREATEOBJECT devolveria valor nao-objeto.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarFormPai(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = loc_lHabilitar
            ENDIF
        ENDIF

        THIS.ControlarBotoesFormPai(loc_lHabilitar)
    ENDPROC

    *--------------------------------------------------------------------------
    * ControlarBotoesFormPai - equivalente ao mCtrlBotoes(plHabilita) do
    * legado (metodo do proprio SIGOPMOP): desliga/religa GRANULARMENTE os
    * botoes do form chamador, alem do Enabled do form inteiro que
    * HabilitarFormPai ja cobre.
    *
    * TRANSCRITO do legado:
    *   With Thisform.ParentForm.Pagina.Lista
    *       For lnI=1 to .Grupo_Op.ButtonCount
    *           If .Grupo_Op.Buttons(lnI).BaseClass = 'Commandbutton' And ;
    *              .Grupo_Op.Buttons(lnI).Visible
    *               .Grupo_Op.Buttons(lnI).Enabled = plHabilita
    *           EndIf
    *       EndFor
    *       .cmdFPOper.Enabled = plHabilita
    *       .cmdMultiSubN.Enabled = plHabilita
    *       .Grupo_Saida.Sair.Enabled = plHabilita
    *   EndWith
    *
    * Mapeamento para a arquitetura nova (FormOPE - Cadastro de Operacoes,
    * na Page1 - Lista):
    *   Grupo_Op (CommandGroup CRUD)   -> cnt_4c_Botoes (Container com
    *       cmd_4c_Incluir/Alterar/Visualizar/Excluir/Buscar)
    *   cmdMultiSubN (abre ESTE dialogo) -> cmd_4c_MultiSubN
    *   Grupo_Saida.Sair                 -> cnt_4c_Saida.cmd_4c_Encerrar
    *       (padrao canonico de saida - CLAUDE.md regra #10)
    *
    * cmdFPOper NAO tem equivalente confirmado no FormOPE migrado (nenhum
    * botao com esse papel foi localizado na migracao atual) - omitido de
    * proposito, em vez de adivinhar um nome que o form pai nao declara
    * (regra de nunca inventar controle por semelhanca).
    *
    * Tudo sob PEMSTATUS: o form pai pode nao ter essa estrutura, ou o
    * dialogo pode ser instanciado sem pai (harness) - ausencia de qualquer
    * peca so faz esta parte da rotina ser pulada, nunca estoura o Click.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ControlarBotoesFormPai(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oPaginaLista, loc_oBotoesCrud, loc_nI, loc_oBotao
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas, "Page1", 5)
            RETURN
        ENDIF

        loc_oPaginaLista = THIS.this_oFormPai.pgf_4c_Paginas.Page1

        *-- Grupo_Op do legado -> cnt_4c_Botoes (grupo CRUD) na pagina Lista.
        IF PEMSTATUS(loc_oPaginaLista, "cnt_4c_Botoes", 5)
            loc_oBotoesCrud = loc_oPaginaLista.cnt_4c_Botoes

            FOR loc_nI = 1 TO loc_oBotoesCrud.ControlCount
                loc_oBotao = loc_oBotoesCrud.Controls(loc_nI)

                IF VARTYPE(loc_oBotao) = "O" AND UPPER(loc_oBotao.BaseClass) == "COMMANDBUTTON" AND ;
                   PEMSTATUS(loc_oBotao, "Visible", 5) AND loc_oBotao.Visible AND ;
                   PEMSTATUS(loc_oBotao, "Enabled", 5)
                    loc_oBotao.Enabled = loc_lHabilitar
                ENDIF
            ENDFOR
        ENDIF

        *-- cmdMultiSubN do legado -> cmd_4c_MultiSubN (o proprio botao que
        *-- abre este dialogo), na mesma pagina.
        IF PEMSTATUS(loc_oPaginaLista, "cmd_4c_MultiSubN", 5)
            loc_oPaginaLista.cmd_4c_MultiSubN.Enabled = loc_lHabilitar
        ENDIF

        *-- Grupo_Saida.Sair do legado -> cnt_4c_Saida.cmd_4c_Encerrar.
        IF PEMSTATUS(loc_oPaginaLista, "cnt_4c_Saida", 5)
            IF PEMSTATUS(loc_oPaginaLista.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
                loc_oPaginaLista.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = loc_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Click de cmd_4c_CmdInserir ("Inserir").
    *
    * TRANSCRITO do legado (SIGOPMOP.cmdInserir.Click):
    *   Thisform.lHouveIns = .T.
    *   Select crSigCdMop
    *   Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
    *   If Eof()
    *       Insert Into crSigCdMop (cDopes, CidChaves) ;
    *           Values (crSigCdOpe.Dopes, fUniqueIds())
    *   EndIf
    *   Select crSigCdMop
    *   Thisform.GradeSubN.Column1.SetFocus
    *
    * O LOCATE usa ALLTRIM + == (nao o "=" cru do legado) pela MESMA razao
    * do resto deste arquivo: o projeto roda com SET EXACT ON, e comparar
    * char(20) sem ALLTRIM exigiria o padding exato. cnivels = Space(20) do
    * legado equivale a EMPTY(ALLTRIM(cnivels)) - a linha NOVA, ainda sem
    * operacao filha escolhida.
    *
    * fUniqueIds() gera a PK (cidchaves) - mesma funcao que
    * InicializarValoresPadrao do BO usa, chamada aqui porque esta tela
    * insere a linha DIRETO no cursor da grade, igual ao legado, e nao via
    * NovoRegistro()/BO (regra #51 - BO nao eh chamado para isto).
    *
    * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_cCursor, loc_oErro

        TRY
            loc_cCursor = THIS.this_cCursorDados

            IF !USED(loc_cCursor)
                MsgErro("Cursor da grade n" + CHR(227) + "o dispon" + CHR(237) + ;
                        "vel.", "Erro em BtnInserirClick")
            ELSE
                THIS.this_lHouveInsercao = .T.

                SELECT (loc_cCursor)
                LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) AND ;
                           EMPTY(ALLTRIM(cnivels))

                IF EOF()
                    INSERT INTO (loc_cCursor) (cdopes, cidchaves) ;
                        VALUES (ALLTRIM(THIS.this_cOperacaoPai), fUniqueIds())
                ENDIF

                SELECT (loc_cCursor)
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnInserirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Click de cmd_4c_CmdExcluir ("Excluir").
    *
    * TRANSCRITO do legado (SIGOPMOP.cmdExcluir.Click):
    *   Select crSigCdMop
    *   If Not Eof() And ( crSigCdMop.cDopes = crSigCdOpe.Dopes )
    *       Thisform.lHouveExcl = .T.
    *       Delete
    *       Skip
    *       Skip - 1
    *   Endif
    *   Thisform.GradeSubN.Refresh
    *
    * SET DELETED ON eh global (start\config.prg) - o DELETE some da grade
    * e do LOCATE/SCAN imediatamente, igual ao legado. A linha apagada pode
    * ja existir no SQL Server (cidchaves gravado numa sessao anterior) -
    * quem resolve isso no commit eh a Fase 8, que ainda nao existe aqui.
    *
    * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCursor, loc_oErro

        TRY
            loc_cCursor = THIS.this_cCursorDados

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)

                IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
                    THIS.this_lHouveExclusao = .T.
                    DELETE
                    SKIP
                    SKIP -1
                ENDIF
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Click de cmd_4c_CmdSair ("Encerrar"), ligado tambem
    * ao ESC (.Cancel = .T. em ConfigurarBotoes) - a UNICA saida desta tela,
    * que nao tem ControlBox nem TitleBar.
    *
    * TRANSCRITO do legado (SIGOPMOP.cmdSair.Click):
    *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
    *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
    *           <checagem de duplicidade + UpDate/Commit/RollBack do cursor>
    *       EndIf
    *   EndIf
    *   Thisform.ParentForm.Enabled = .T.
    *   Thisform.mCtrlBotoes(.T.)
    *   ThisForm.Release
    *
    * Os DOIS guards do legado sao regra, nao detalhe (regra #21b - "a condicao
    * que CERCA a validacao faz parte dela"):
    *
    *   1) "If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible"
    *      So grava quando a tela esta em modo de EDICAO. Em PROCURAR os dois
    *      botoes ficam invisiveis (AplicarPermissoesBotoes, transcrito do Init
    *      legado) e NADA eh persistido - mesmo que o usuario tenha digitado nas
    *      celulas, porque o legado nao trava a grade em consulta: quem impede a
    *      gravacao eh exatamente este teste. Trocar por um teste de modo
    *      (this_cEscolha) daria o mesmo resultado hoje, mas deixaria de seguir
    *      a permissao do usuario (fChecaAcesso), que tambem entra na
    *      visibilidade.
    *
    *   2) "If ( Thisform.lHouveExcl Or Thisform.lHouveIns )"
    *      Nada mudou, nada a gravar - e nenhuma ida ao banco.
    *
    * Na duplicidade o legado faz "Return .f." de DENTRO do Click: a tela NAO
    * fecha, o form pai continua desabilitado e o usuario volta a grade para
    * corrigir. Na falha de GRAVACAO o legado so avisa e segue fechando - sao
    * dois desfechos DIFERENTES, por isso a checagem de duplicidade
    * (ValidarDuplicidadeGrade) e a gravacao (GravarGrade) sao metodos
    * separados e so a primeira pode abortar o encerramento.
    *
    * PUBLIC (nao PROTECTED): alvo de BINDEVENT e nome CANONICO que
    * TesteAutomatico.prg procura (TesteBtnEncerrarExiste) - regras #3 e #51.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lEncerra, loc_oErro
        loc_lEncerra = .T.

        TRY
            IF THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible
                IF THIS.this_lHouveExclusao OR THIS.this_lHouveInsercao
                    IF THIS.ValidarDuplicidadeGrade()
                        THIS.GravarGrade()
                    ELSE
                        loc_lEncerra = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Encerra mesmo assim (o legado tambem fecha quando a gravacao
            *-- falha); o que nao pode acontecer eh a falha ficar muda.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnEncerrarClick")
        ENDTRY

        *-- Cauda do cmdSair.Click legado, FORA do TRY:
        *--   Thisform.ParentForm.Enabled = .T.
        *--   Thisform.mCtrlBotoes(.T.)
        *--   ThisForm.Release
        *-- HabilitarFormPai cobre as duas primeiras linhas. Ela roda tambem no
        *-- Destroy (funil de QUALQUER caminho de fechamento) e eh idempotente:
        *-- chamar duas vezes com .T. nao tem efeito extra.
        IF loc_lEncerra
            THIS.HabilitarFormPai(.T.)
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicidadeGrade - checagem de duplicidade do cmdSair.Click.
    *
    * TRANSCRITA do legado:
    *   Select CrSigCdMop
    *   Go Bott
    *   Go Top
    *   Select cNivels as Dopes, Mercs, EmpDs, sum(1) as TT ;
    *       From CrSigCdMop GROUP by 1,2,3 Into cursor Totais
    *   Select Totais
    *   Scan
    *       If TT > 1
    *           MessageBox('Operacao '+Alltrim(Totais.Dopes)+
    *                      ' Digitada em Duplicidade!!!!',0+16,'Atencao')
    *           Return .f.
    *       EndIf
    *   EndScan
    *
    * O trio de agrupamento eh cNivels + Mercs + EmpDs, NAO cNivels sozinho: a
    * MESMA operacao filha pode repetir desde que o grande grupo ou a empresa de
    * destino sejam diferentes. Reduzir a chave recusaria gravacao legitima.
    *
    * "Go Bott / Go Top" eh o idioma do legado para forcar a view remota a
    * buscar TODAS as linhas antes de agrupar - num cursor LOCAL nao ha busca
    * preguicosa e as duas linhas nao tem efeito, por isso nao foram
    * transcritas. O que foi transcrito eh o que elas protegiam: o SELECT ve o
    * cursor inteiro.
    *
    * MsgAviso, e nao MsgErro, apesar do icone 16 (Critical) do legado:
    * duplicidade digitada eh validacao de ENTRADA do usuario, e a convencao do
    * projeto reserva o dialogo vermelho (com "Fechar Aplicacao") para falha
    * tecnica. A mensagem e o momento sao os mesmos.
    *
    * O RECNO corrente eh salvo e devolvido: o SELECT ... GROUP BY troca a area
    * de trabalho e o usuario tem de voltar a encontrar a grade na linha em que
    * estava para corrigir a duplicidade.
    *
    * PUBLIC: chamado por BtnEncerrarClick, que eh alvo de BINDEVENT, e util
    * como ponto de verificacao de fora em teste.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicidadeGrade()
        LOCAL loc_lValido, loc_cCursor, loc_cTotais, loc_nRecno, loc_oErro
        loc_lValido = .T.
        loc_cCursor = THIS.this_cCursorDados
        loc_cTotais = "cursor_4c_TotaisMop"

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                loc_nRecno = RECNO()

                IF USED(loc_cTotais)
                    USE IN (loc_cTotais)
                ENDIF

                SELECT cnivels AS dopes, mercs, empds, COUNT(*) AS tt ;
                    FROM (loc_cCursor) ;
                    GROUP BY 1, 2, 3 ;
                    INTO CURSOR (loc_cTotais) READWRITE

                SELECT (loc_cTotais)
                SCAN FOR tt > 1
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + ;
                             ALLTRIM(NVL(dopes, "")) + ;
                             " Digitada em Duplicidade!!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                    EXIT
                ENDSCAN

                IF USED(loc_cTotais)
                    USE IN (loc_cTotais)
                ENDIF

                *-- Devolve o ponteiro da grade a linha em que o usuario estava.
                SELECT (loc_cCursor)
                IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                    GO (loc_nRecno)
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            loc_lValido = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarDuplicidadeGrade")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarGrade - persiste a grade inteira em SigCdMop.
    *
    * Equivale ao bloco de gravacao do cmdSair.Click legado:
    *   m.lnErro1 = SigCdOpe.poDatamgr.pnIdConn
    *   With SigCdOpe
    *       If m.lnErro1>0
    *           m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
    *       EndIf
    *       If m.lnErro1>0
    *           m.lnErro1 = .poDataMgr.Commit()
    *       EndIf
    *       If Not m.lnErro1>0
    *           .poDataMgr.RollBack()
    *       EndIf
    *   EndWith
    *   If Not m.lnErro1>0
    *       = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
    *   EndIf
    *
    * O "UpDate('crSigCdMop')" do legado eh um TABLEUPDATE de VIEW REMOTA: o
    * buffer sabia, registro por registro, quem era novo, alterado ou apagado.
    * O cursor desta arquitetura NAO guarda esse estado - ele nasce de um
    * "SELECT ... INTO CURSOR ... READWRITE", cujo Buffering eh 1 (regra #52),
    * entao INSERT/DELETE no cursor nao esperam em buffer nenhum.
    *
    * O estado eh portanto RECONSTRUIDO por RECONCILIACAO contra o banco, numa
    * unica consulta (BO.CarregarChavesGravadas):
    *
    *   chave na grade   E   no banco -> UPDATE  (BO.Salvar com registro existente)
    *   chave na grade e NAO no banco -> INSERT  (BO.Salvar com registro novo)
    *   chave no banco e NAO na grade -> DELETE  (BO.Excluir)
    *
    * A terceira linha eh o que substitui o DELETE do TABLEUPDATE: linha que o
    * usuario apagou com o botao Excluir saiu da grade (DELETE + SET DELETED ON
    * global), logo nao tem chave na grade e eh apagada no banco. Isto EXIGE que
    * o cursor seja a imagem FIEL de "SigCdMop WHERE cdopes = <operacao pai>" -
    * por isso a Fase 8 trocou o INNER JOIN de BO.CarregarGrade por LEFT JOIN
    * (com INNER, a linha de cnivels em branco nao voltava do banco e esta
    * reconciliacao a APAGARIA; ver o comentario do metodo no BO).
    *
    * Atomicidade: todos os statements vao na MESMA conexao, que neste ambiente
    * nasce com Transactions = 2 (manual), entao o par ConfirmarGravacao/
    * DesfazerGravacao do BO (SQLCOMMIT/SQLROLLBACK) tem o mesmo efeito do
    * Commit/RollBack do legado. NAO se usa "BEGIN/COMMIT TRANSACTION" por
    * SQLEXEC: com @@TRANCOUNT ja em 1 esse par so aninha e nao efetiva nada.
    *
    * A primeira falha ABORTA o laco (EXIT) e desfaz tudo - igual ao legado, que
    * nao continua depois de um UpDate recusado.
    *
    * Nao se repete a mensagem quando o BO ja a exibiu (regra #20): Salvar/
    * Excluir de BusinessBase mostram o erro do SQL Server e marcam
    * this_lErroExibido.
    *
    * As DUAS chamadas que de fato PERSISTEM (Salvar e Excluir) sao escritas por
    * THIS.this_oBusinessObject, e nao pelo apelido local loc_oBO usado no
    * resto do metodo: eh o idioma do projeto para gravacao e deixa as duas
    * unicas linhas que escrevem no banco visiveis numa busca pelo nome do BO.
    *
    * PUBLIC: chamado por BtnEncerrarClick, que eh alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE GravarGrade()
        LOCAL loc_lSucesso, loc_lFalhou, loc_oBO, loc_cCursor, loc_cChaves
        LOCAL loc_nRecno, loc_nLinha, loc_cChave, loc_lNovo, loc_cMensagem
        LOCAL loc_oErro

        loc_lSucesso = .F.
        loc_lFalhou  = .F.
        loc_nRecno   = 0

        TRY
            loc_oBO     = THIS.this_oBusinessObject
            loc_cCursor = THIS.this_cCursorDados

            DO CASE
                CASE VARTYPE(loc_oBO) != "O"
                    MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                            "o dispon" + CHR(237) + "vel para gravar a grade.", ;
                            "Erro em GravarGrade")

                CASE !USED(loc_cCursor)
                    MsgErro("Cursor da grade n" + CHR(227) + "o dispon" + CHR(237) + ;
                            "vel para gravar.", "Erro em GravarGrade")

                CASE !loc_oBO.ConexaoAtiva()
                    *-- Equivale ao "If m.lnErro1>0" do legado, que testa
                    *-- poDataMgr.pnIdConn antes de tentar o UpDate.
                    MsgErro("Sem conex" + CHR(227) + "o com o banco: as altera" + ;
                            CHR(231) + CHR(245) + "es da grade N" + CHR(195) + "O foram " + ;
                            "gravadas.", "Erro em GravarGrade")

                CASE !loc_oBO.CarregarChavesGravadas()
                    loc_cMensagem = ALLTRIM(NVL(loc_oBO.this_cMensagemErro, ""))
                    IF EMPTY(loc_cMensagem)
                        loc_cMensagem = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel ler as opera" + CHR(231) + CHR(245) + "es j" + CHR(225) + ;
                            " gravadas."
                    ENDIF
                    MsgErro(loc_cMensagem, "Erro em GravarGrade")

                OTHERWISE
                    loc_cChaves = loc_oBO.this_cCursorChaves

                    SELECT (loc_cCursor)
                    loc_nRecno = RECNO()

                    *----------------------------------------------------------
                    * 1) INSERT/UPDATE de cada linha VIVA da grade.
                    *
                    * Laco com RECNO explicito (e nao SCAN): o corpo chama o BO,
                    * que troca a area de trabalho corrente, e SCAN nao sobrevive
                    * a isso. A linha apagada pelo botao Excluir nao aparece aqui
                    * (SET DELETED ON global) - ela eh tratada no passo 2.
                    *----------------------------------------------------------
                    SELECT (loc_cCursor)
                    GO TOP

                    DO WHILE .T.
                        SELECT (loc_cCursor)
                        IF EOF()
                            EXIT
                        ENDIF

                        loc_nLinha = RECNO()
                        loc_cChave = ALLTRIM(NVL(cidchaves, ""))
                        loc_lNovo  = EMPTY(loc_cChave) OR ;
                                     !THIS.LocalizarChave(loc_cChaves, loc_cChave)

                        *-- Estado do BO: CancelarEdicao zera o que sobrou da
                        *-- linha anterior (sem isso, EditarRegistro recusaria o
                        *-- registro com "Nao ha registro para editar" quando a
                        *-- linha anterior era nova).
                        loc_oBO.CancelarEdicao()

                        IF loc_lNovo
                            *-- NovoRegistro() faz LimparDados + os defaults do
                            *-- ramo INSERIR do legado (inclusive uma cidchaves
                            *-- nova); FormParaBO roda DEPOIS e sobrepoe com os
                            *-- valores reais da linha.
                            loc_oBO.NovoRegistro()
                        ELSE
                            loc_oBO.EditarRegistro()
                        ENDIF

                        SELECT (loc_cCursor)
                        GO (loc_nLinha)

                        IF THIS.FormParaBO()
                            *-- Linha sem PK (dado legado com cidchaves em
                            *-- branco): gera a chave e DEVOLVE ao cursor, senao
                            *-- a reconciliacao da proxima gravacao nao
                            *-- encontraria a linha e inseriria de novo.
                            IF EMPTY(ALLTRIM(loc_oBO.this_cCidChaves))
                                loc_oBO.this_cCidChaves = fUniqueIds()

                                SELECT (loc_cCursor)
                                GO (loc_nLinha)
                                THIS.BOParaForm()
                            ENDIF

                            IF !THIS.this_oBusinessObject.Salvar()
                                loc_lFalhou = .T.
                            ENDIF
                        ELSE
                            loc_lFalhou = .T.
                            loc_oBO.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                                CHR(237) + "vel ler a linha " + TRANSFORM(loc_nLinha) + ;
                                " da grade."
                        ENDIF

                        IF loc_lFalhou
                            EXIT
                        ENDIF

                        SELECT (loc_cCursor)
                        GO (loc_nLinha)
                        SKIP
                    ENDDO

                    *----------------------------------------------------------
                    * 2) DELETE das chaves que estao no banco e nao na grade.
                    *----------------------------------------------------------
                    IF !loc_lFalhou AND USED(loc_cChaves)
                        SELECT (loc_cChaves)
                        GO TOP

                        DO WHILE .T.
                            SELECT (loc_cChaves)
                            IF EOF()
                                EXIT
                            ENDIF

                            loc_nLinha = RECNO()
                            loc_cChave = ALLTRIM(NVL(cidchaves, ""))

                            *-- Chave VAZIA nunca gera DELETE: "WHERE cidchaves
                            *-- = ''" casaria com toda linha de chave em branco
                            *-- da tabela. O BO tambem recusa (ExecutarExclusao),
                            *-- e aqui nem se tenta.
                            IF !EMPTY(loc_cChave)
                                IF !THIS.LocalizarChave(loc_cCursor, loc_cChave)
                                    loc_oBO.CancelarEdicao()
                                    loc_oBO.this_cCidChaves = loc_cChave
                                    loc_oBO.this_cCdopes    = ALLTRIM(THIS.this_cOperacaoPai)

                                    IF !THIS.this_oBusinessObject.Excluir()
                                        loc_lFalhou = .T.
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF loc_lFalhou
                                EXIT
                            ENDIF

                            SELECT (loc_cChaves)
                            GO (loc_nLinha)
                            SKIP
                        ENDDO
                    ENDIF

                    *----------------------------------------------------------
                    * 3) Commit / RollBack - o passo PROPRIO do legado.
                    *----------------------------------------------------------
                    IF loc_lFalhou
                        loc_oBO.DesfazerGravacao()
                    ELSE
                        IF loc_oBO.ConfirmarGravacao()
                            loc_lSucesso = .T.

                            *-- Nada mais a gravar: zerar as flags evita que uma
                            *-- segunda passada (ESC apos o Encerrar, por
                            *-- exemplo) refaca a gravacao inteira.
                            THIS.this_lHouveInsercao = .F.
                            THIS.this_lHouveExclusao = .F.
                        ELSE
                            loc_lFalhou = .T.
                            loc_oBO.DesfazerGravacao()
                        ENDIF
                    ENDIF

                    IF loc_lFalhou AND !loc_oBO.this_lErroExibido
                        loc_cMensagem = "Erro na Grava" + CHR(231) + CHR(227) + ;
                            "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + "es."

                        IF !EMPTY(ALLTRIM(NVL(loc_oBO.this_cMensagemErro, "")))
                            loc_cMensagem = loc_cMensagem + CHR(13) + ;
                                ALLTRIM(loc_oBO.this_cMensagemErro)
                        ENDIF

                        MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF

                    IF USED(loc_cChaves)
                        USE IN (loc_cChaves)
                    ENDIF
            ENDCASE

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em GravarGrade")
        ENDTRY

        *-- Devolve o ponteiro da grade a linha em que o usuario estava.
        IF USED(THIS.this_cCursorDados) AND loc_nRecno > 0
            SELECT (THIS.this_cCursorDados)
            IF BETWEEN(loc_nRecno, 1, RECCOUNT(THIS.this_cCursorDados))
                GO (loc_nRecno)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarChave - devolve .T. quando par_cChave existe em par_cAlias.
    *
    * LOCATE com ALLTRIM e "==", e nao SEEK sobre indice, de proposito: o
    * projeto roda com SET EXACT ON (start\config.prg), e sob EXACT ON o SEEK
    * exige a chave COMPLETA do indice - comparar char(20) exigiria reproduzir o
    * padding exato dos dois lados, que eh justamente a armadilha da regra #42.
    * Com ALLTRIM nas duas pontas o padding deixa de importar. As grades desta
    * tela tem poucas linhas, entao a varredura nao pesa.
    *
    * "m.loc_cChave" (e nao "loc_cChave") porque dentro de LOCATE FOR o VFP
    * resolve nome como CAMPO antes de variavel - o prefixo m. elimina a
    * ambiguidade.
    *
    * O ALIAS e o RECNO correntes sao devolvidos: o metodo eh chamado de dentro
    * de lacos que percorrem OUTRO cursor, e mover o ponteiro deles em silencio
    * faria o laco pular ou repetir linhas.
    *
    * PUBLIC: usado por GravarGrade (alvo indireto de BINDEVENT) e util como
    * ponto de verificacao de fora em teste.
    *--------------------------------------------------------------------------
    PROCEDURE LocalizarChave(par_cAlias, par_cChave)
        LOCAL loc_lAchou, loc_cAliasAnterior, loc_nRecno, loc_cChave

        loc_lAchou = .F.
        loc_cChave = ALLTRIM(NVL(par_cChave, ""))

        IF VARTYPE(par_cAlias) != "C"
            RETURN .F.
        ENDIF

        IF !USED(par_cAlias) OR EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cAliasAnterior = ALIAS()

        SELECT (par_cAlias)
        loc_nRecno = RECNO()

        LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == m.loc_cChave
        loc_lAchou = FOUND()

        *-- RECNO() em EOF devolve RECCOUNT()+1, e "GO <esse numero>" estoura
        *-- "Record is out of range" - por isso o BETWEEN.
        IF BETWEEN(loc_nRecno, 1, RECCOUNT(par_cAlias))
            GO (loc_nRecno)
        ELSE
            GO BOTTOM
            IF !EOF()
                SKIP
            ENDIF
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere a LINHA CORRENTE da grade para o objeto de negocio.
    *
    * Nesta tela a "ficha" nao eh uma pagina de Dados com TextBox: eh a LINHA da
    * grade. Cada uma delas eh um registro de SigCdMop, e as nove colunas do
    * cursor sao exatamente as nove colunas da tabela (mais ndopes, que eh de
    * exibicao). Por isso os dois hooks de transferencia leem e escrevem o
    * CURSOR, e nao controles.
    *
    * NAO se usa o CarregarDoCursor do BO para isto, e nao eh escolha de estilo:
    * ele esta PROTECTED no BO, e metodo protegido chamado de fora compila limpo
    * e estoura em runtime com "Property CARREGARDOCURSOR is not found"
    * (regra #51).
    *
    * cdopes cai na operacao PAI quando a coluna vem vazia: no legado toda linha
    * nasce amarrada a ela ("Insert Into crSigCdMop (cDopes, CidChaves) Values
    * (crSigCdOpe.Dopes, fUniqueIds())"), e cdopes eh NOT NULL e entra no WHERE
    * do DELETE.
    *
    * ALLTRIM nos campos char: as colunas do cursor vem com padding de char(N) e
    * EscaparSQL/LEFT do BO trabalham sobre o valor util. Isto NAO eh a
    * armadilha da regra #42 (ALLTRIM em PARTE de chave posicional concatenada):
    * aqui cada valor eh um campo independente, e a comparacao de char no SQL
    * Server eh blank-padded ANSI.
    *
    * PROTECTED **EXPLICITO**, e nao por estilo: FormBase.prg declara
    * "PROTECTED PROCEDURE FormParaBO" (eh um hook que FormBase.Salvar chama por
    * THIS.), e em VFP9 a subclasse NAO ALARGA escopo herdado - escrever
    * "PROCEDURE FormParaBO" aqui deixaria o metodo protegido do mesmo jeito e
    * MENTIRIA para quem le. Medido nesta tela em 2026-11-09: com a declaracao
    * sem modificador, "loForm.FormParaBO()" de fora da classe estourou
    * "Property FORMPARABO is not found." (erro 1734) - e num vfp9.exe -T esse
    * Program Error eh um dialogo que ninguem fecha, ou seja o processo PENDURA
    * sem log nenhum. Chamar sempre por THIS., de dentro da classe (GravarGrade).
    * O mesmo vale para BOParaForm. CarregarLista NAO existe em FormBase, logo
    * aquele sim eh publico de verdade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_cCursor, loc_oBO, loc_cCdopes, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = THIS.this_cCursorDados
            loc_oBO     = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O" AND USED(loc_cCursor)
                SELECT (loc_cCursor)

                IF !EOF()
                    loc_cCdopes = ALLTRIM(TratarNulo(cdopes, ""))

                    IF EMPTY(loc_cCdopes)
                        loc_cCdopes = ALLTRIM(THIS.this_cOperacaoPai)
                    ENDIF

                    loc_oBO.this_cCdopes    = loc_cCdopes
                    loc_oBO.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, ""))
                    loc_oBO.this_cCnivels   = ALLTRIM(TratarNulo(cnivels, ""))
                    loc_oBO.this_nNcors     = TratarNulo(ncors,   0)
                    loc_oBO.this_nPadraos   = TratarNulo(padraos, 0)
                    loc_oBO.this_nOrdems    = TratarNulo(ordems,  0)
                    loc_oBO.this_cMercs     = ALLTRIM(TratarNulo(mercs, ""))
                    loc_oBO.this_cEmpds     = ALLTRIM(TratarNulo(empds, ""))
                    loc_oBO.this_cOpers     = ALLTRIM(TratarNulo(opers, ""))

                    *-- Coluna de EXIBICAO (vem do LEFT JOIN com SigCdOpe) - nao
                    *-- existe em SigCdMop e nunca entra no INSERT/UPDATE.
                    IF TYPE(loc_cCursor + ".ndopes") != "U"
                        loc_oBO.this_nNdopes = TratarNulo(ndopes, 0)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transfere o objeto de negocio para a LINHA CORRENTE da grade.
    *
    * Caminho inverso de FormParaBO (ver o comentario dele sobre a linha da
    * grade ser a ficha desta tela). Quem usa de fato eh GravarGrade, para
    * devolver ao cursor a cidchaves gerada numa linha que chegou sem chave: sem
    * essa volta, a reconciliacao da gravacao seguinte nao encontraria a linha e
    * inseriria o MESMO registro outra vez.
    *
    * REPLACE num cursor exige que ele seja READWRITE - e eh
    * (BO.CarregarGrade usa "SELECT ... INTO CURSOR ... READWRITE", e o
    * cursor vazio inicial vem de CREATE CURSOR).
    *
    * Os char vao com ALLTRIM e o proprio VFP completa com espacos ate a largura
    * da coluna; valor mais longo que a coluna eh truncado pelo VFP, igual ao
    * LEFT() que o BO aplica no SQL.
    *
    * PROTECTED EXPLICITO pela MESMA razao de FormParaBO (ver o comentario
    * dele): FormBase declara os dois como PROTECTED e VFP9 nao deixa a
    * subclasse alargar o escopo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_cCursor, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = THIS.this_cCursorDados
            loc_oBO     = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O" AND USED(loc_cCursor)
                SELECT (loc_cCursor)

                IF !EOF()
                    REPLACE cdopes    WITH ALLTRIM(loc_oBO.this_cCdopes),    ;
                            cidchaves WITH ALLTRIM(loc_oBO.this_cCidChaves), ;
                            cnivels   WITH ALLTRIM(loc_oBO.this_cCnivels),   ;
                            ncors     WITH loc_oBO.this_nNcors,              ;
                            padraos   WITH loc_oBO.this_nPadraos,            ;
                            ordems    WITH loc_oBO.this_nOrdems,             ;
                            mercs     WITH ALLTRIM(loc_oBO.this_cMercs),     ;
                            empds     WITH ALLTRIM(loc_oBO.this_cEmpds),     ;
                            opers     WITH ALLTRIM(loc_oBO.this_cOpers)

                    IF TYPE(loc_cCursor + ".ndopes") != "U"
                        REPLACE ndopes WITH loc_oBO.this_nNdopes
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - entrada PUBLICA de recarga da superficie de lista desta
    * tela, que eh a GRADE (esta tela nao tem pagina de Lista separada).
    *
    * Nao eh um apelido de CarregarDados: ela acrescenta o que falta para a
    * recarga ser utilizavel de fora da inicializacao - preservar a LINHA
    * CORRENTE. BO.CarregarGrade RECRIA o cursor, e sem isto o usuario eh jogado
    * de volta para a primeira linha a cada recarga. Eh o mesmo cuidado que o
    * legado toma onde ele mesmo recarrega (o Click do CheckBox "Padrao" guarda
    * e devolve lnRecno).
    *
    * A linha eh reencontrada pela cidchaves, nao pelo RECNO: a recarga vem
    * ordenada por cdopes+cnivels e o numero do registro pode mudar.
    *
    * PUBLIC: eh por este nome que o harness (TesteAutomatico.prg) chama a
    * recarga, de FORA da classe - regra #3.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cCursor, loc_cChaveAtual, loc_oErro
        loc_lSucesso    = .F.
        loc_cChaveAtual = ""

        TRY
            loc_cCursor = THIS.this_cCursorDados

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF()
                    loc_cChaveAtual = ALLTRIM(NVL(cidchaves, ""))
                ENDIF
            ENDIF

            loc_lSucesso = THIS.CarregarDados()

            *-- Reler a property: CarregarDados a sincroniza com o BO.
            loc_cCursor = THIS.this_cCursorDados

            IF loc_lSucesso AND !EMPTY(loc_cChaveAtual) AND USED(loc_cCursor)
                IF THIS.LocalizarChave(loc_cCursor, loc_cChaveAtual)
                    SELECT (loc_cCursor)
                    LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == m.loc_cChaveAtual
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarPermissao - equivalente ao fChecaAcesso('SIGOPMOP', <operacao>)
    * do Init legado.
    *
    * fChecaAcesso tem DUAS definicoes vivas no repo e a que VENCE eh a de
    * Framework\sigacess.PRG, que abre conexao propria e consulta SigCdAcu.
    * Em execucao headless sem SQL Server ela PENDURA - e penduraria DENTRO do
    * CREATEOBJECT deste form, o que se le como "a tela nao instancia" quando o
    * problema eh o banco. Por isso a chamada fica atras do mesmo guard de modo
    * de teste que o Init ja usa para o WindowType.
    *
    * A chamada com 2 argumentos eh FIEL ao legado: os 3 parametros restantes de
    * sigacess.PRG tem fallback proprio (pUsu cai em Usuar, pTot ausente avalia
    * como .F.) - NAO "consertar" acrescentando argumentos.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarPermissao(par_cOperacao)
        LOCAL loc_lPermitido

        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
            RETURN .T.
        ENDIF

        loc_lPermitido = fChecaAcesso("SIGOPMOP", par_cOperacao)

        RETURN IIF(VARTYPE(loc_lPermitido) = "L", loc_lPermitido, .F.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * AplicarPermissoesBotoes - decide a visibilidade/habilitacao de Inserir e
    * Excluir e reposiciona a moldura em funcao do que sobrou visivel.
    *
    * TRANSCRITO do Init legado:
    *   .cmdInserir.Visible = fChecaAcesso('SIGOPMOP','INSERIR') And ;
    *                         Iif( Type('Thisform.PcEscolha') # 'C', .T., ;
    *                         InList( Thisform.PcEscolha,'INSERIR','ALTERAR') )
    *   .cmdInserir.Enabled = <a mesma expressao>
    *   .cmdExcluir.Visible = fChecaAcesso('SIGOPMOP','EXCLUIR') And <modo>
    *   .cmdExcluir.Enabled = <a mesma expressao>
    *   .shape1.Left  = IIF(.cmdInserir.visible, .cmdInserir.Left - 5, ;
    *                   IIF(.cmdExcluir.visible, .cmdExcluir.left - 5, ;
    *                       .cmdSair.Left - 5))
    *   .shape1.width = IIF(.cmdInserir.visible, 3, ;
    *                   IIF(.cmdExcluir.visible, 2, 1)) * .cmdsair.width + 16
    *
    * O "Iif( Type('Thisform.PcEscolha') # 'C', ...)" do legado cobre o caso do
    * chamador que NAO passou o modo: a property fica logica (.F.) e o teste de
    * tipo libera a acao. Aqui this_cEscolha eh sempre Caractere, entao o
    * equivalente exato eh EMPTY() - modo nao informado libera, modo informado
    * exige INSERIR/ALTERAR. Em PROCURAR os dois botoes desaparecem e a tela
    * fica somente de consulta, como no legado.
    *
    * Roda DEPOIS de TornarControlesVisiveis de proposito: aquela varredura
    * forca Visible = .T. em TODO controle e apagaria esta decisao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPermissoesBotoes()
        LOCAL loc_lModoEdicao, loc_lPodeInserir, loc_lPodeExcluir
        LOCAL loc_nLeftMoldura, loc_nFatorMoldura

        *-- Modo do form PAI: sem modo informado, libera (legado: Type() # 'C')
        loc_lModoEdicao = EMPTY(THIS.this_cEscolha) OR ;
                          INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        loc_lPodeInserir = THIS.VerificarPermissao("INSERIR") AND loc_lModoEdicao
        loc_lPodeExcluir = THIS.VerificarPermissao("EXCLUIR") AND loc_lModoEdicao

        THIS.cmd_4c_CmdInserir.Visible = loc_lPodeInserir
        THIS.cmd_4c_CmdInserir.Enabled = loc_lPodeInserir

        THIS.cmd_4c_CmdExcluir.Visible = loc_lPodeExcluir
        THIS.cmd_4c_CmdExcluir.Enabled = loc_lPodeExcluir

        *-- Moldura acompanha o PRIMEIRO botao visivel, da esquerda para a
        *-- direita, e cresce 1/2/3 larguras de botao conforme quantos sobraram.
        DO CASE
            CASE THIS.cmd_4c_CmdInserir.Visible
                loc_nLeftMoldura  = THIS.cmd_4c_CmdInserir.Left - 5
                loc_nFatorMoldura = 3
            CASE THIS.cmd_4c_CmdExcluir.Visible
                loc_nLeftMoldura  = THIS.cmd_4c_CmdExcluir.Left - 5
                loc_nFatorMoldura = 2
            OTHERWISE
                loc_nLeftMoldura  = THIS.cmd_4c_CmdSair.Left - 5
                loc_nFatorMoldura = 1
        ENDCASE

        THIS.shp_4c_Shape1.Left  = loc_nLeftMoldura
        THIS.shp_4c_Shape1.Width = loc_nFatorMoldura * THIS.cmd_4c_CmdSair.Width + 16
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarOrdemTabulacao - TabIndex TRANSCRITO do dump (GradeSubN = 1,
    * cmdExcluir = 2, cmdSair = 3, cmdInserir = 4).
    *
    * Fica aqui, e nao em ConfigurarGrade/ConfigurarBotoes, porque TabIndex
    * fora da faixa 1..N eh descartado em SILENCIO: a faixa so vale depois do
    * ULTIMO controle focalizavel existir. Sao quatro (a grade e os tres
    * botoes), logo 1..4.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        THIS.grd_4c_Dados.TabIndex        = 1
        THIS.cmd_4c_CmdExcluir.TabIndex   = 2
        THIS.cmd_4c_CmdSair.TabIndex      = 3
        THIS.cmd_4c_CmdInserir.TabIndex   = 4
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - funil UNICO de carga: configuracao da operacao, linhas da
    * grade e remontagem do vinculo visual.
    *
    * Equivale ao bloco final do Init legado, que carrega LocalDcOpe
    * (configuracao), faz ReQuery('crSigCdMop') e so DEPOIS liga a grade.
    *
    * A ordem eh obrigatoria: MontaGrade consulta this_nGerOpes para decidir se
    * a coluna "Cores" aceita digitacao, e esse valor sai de
    * CarregarConfiguracaoOperacao.
    *
    * MontaGrade roda SEMPRE depois da carga, mesmo quando a consulta falha:
    * CarregarGrade DERRUBA o alias da grade, e fechar o alias de um Grid
    * destroi o controle posto por Column.AddObject. A perda eh PARCIAL e por
    * isso enganosa - largura e cabecalho sobrevivem, a grade continua bonita, e
    * so o CheckBox da coluna "Padrao" desaparece, voltando a desenhar o Text1
    * com 0/1 cru e sem como marcar linha nenhuma.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel para carregar a grade.", ;
                        "Erro em CarregarDados")
            ELSE
                *-- Nome do cursor vem do BO (fonte unica), para a grade nao
                *-- ligar num alias diferente do que foi populado.
                THIS.this_cCursorDados = THIS.this_oBusinessObject.this_cCursorDados

                THIS.this_oBusinessObject.CarregarConfiguracaoOperacao()
                THIS.this_oBusinessObject.CarregarGrade()

                loc_lSucesso = THIS.MontaGrade()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaGrade - vincula a grade ao cursor e configura as 7 colunas.
    *
    * Mapa de colunas TRANSCRITO do Init legado:
    *   .RecordSource          = 'crSigCdMop'
    *   .Column1.ControlSource = 'crSigCdMop.cNivels'   "Movimentacao"  150
    *   .Column2.ControlSource = 'crSigCdMop.nDopes'    "  #  "          38  ReadOnly
    *   .Column3.ControlSource = 'crSigCdMop.nCors'     "Cores"          80
    *   .Column4.ControlSource = 'crSigCdMop.Padraos'   "Padrao"         50  CheckBox
    *   .Column5.ControlSource = 'crSigCdMop.Ordems'    "Ordem"          45
    *   .Column6.ControlSource = 'crSigCdMop.Mercs'     "G.Grp"          42
    *   .Column7.ControlSource = 'crSigCdMop.EmpDs'     "Emp."           40
    *
    * A SEQUENCIA abaixo eh medida, nao estilistica:
    *   ColumnCount -> RecordSource -> ControlSource de TODAS as colunas ->
    *   Column4.AddObject(CheckBox) -> CurrentControl/Sparse -> larguras e
    *   cabecalhos -> ReadOnly das colunas.
    * Inverter os dois primeiros blocos faz o Grid se auto-ligar ao alias
    * CORRENTE no instante do ColumnCount e o AddObject do CheckBox estourar
    * "Data type mismatch" se a coluna 4 daquele alias for texto.
    * Largura e cabecalho vem POR ULTIMO porque atribuir RecordSource/
    * ControlSource os reseta (a largura volta ao default 90 e o Caption volta
    * a "Header1").
    *
    * Este metodo eh IDEMPOTENTE e eh o funil de TODA repintura - nao da
    * inicializacao apenas.
    *--------------------------------------------------------------------------
    PROCEDURE MontaGrade()
        LOCAL loc_lSucesso, loc_oErro, loc_oGrade, loc_cCursor
        loc_lSucesso = .F.

        TRY
            loc_cCursor = THIS.this_cCursorDados

            IF !USED(loc_cCursor)
                *-- Sem cursor nao ha o que ligar; sair sem mexer na grade eh
                *-- melhor que ligar em alias inexistente, que derruba o Init.
                MsgAviso("Cursor da grade n" + CHR(227) + "o dispon" + CHR(237) + ;
                         "vel: " + loc_cCursor, "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oGrade = THIS.grd_4c_Dados

                SELECT (loc_cCursor)

                WITH loc_oGrade
                    .ColumnCount      = 7
                    .RecordSourceType = 1
                    .RecordSource     = loc_cCursor

                    .Column1.ControlSource = loc_cCursor + ".cnivels"
                    .Column2.ControlSource = loc_cCursor + ".ndopes"
                    .Column3.ControlSource = loc_cCursor + ".ncors"
                    .Column4.ControlSource = loc_cCursor + ".padraos"
                    .Column5.ControlSource = loc_cCursor + ".ordems"
                    .Column6.ControlSource = loc_cCursor + ".mercs"
                    .Column7.ControlSource = loc_cCursor + ".empds"
                ENDWITH

                *-- CheckBox da coluna "Padrao" so DEPOIS do bind, e de forma
                *-- idempotente (AddObject repetido num objeto vivo estoura).
                THIS.GarantirCheckBoxPadrao()

                *-- Celulas customizadas de Movimentacao/Cores (Fase 5) -
                *-- mesma idempotencia: o bind acima recria as Columns.
                THIS.GarantirCelulasEditaveisGrade()

                *-- Fonte das Columns e dos controles internos (dump: Tahoma 8
                *-- em todas as 7 colunas e em todos os Text1)
                loc_oGrade.FontName = "Tahoma"
                loc_oGrade.FontSize = 8

                *-- Larguras, cabecalhos e travas, coluna a coluna
                THIS.ConfigurarColunasGrade()

                *-- "Go Top In <cursor>" + Refresh do legado: popular o cursor
                *-- NAO repinta a grade sozinho.
                SELECT (loc_cCursor)
                GO TOP
                loc_oGrade.Refresh()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em MontaGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCheckBoxPadrao - instala o CheckBox da coluna "Padrao"
    * (SIGOPMOP.GradeSubN.Column4.Check1) de forma IDEMPOTENTE.
    *
    * Column.AddObject sozinho NAO faz o controle aparecer: a coluna continua
    * desenhando o Text1 dela ate receber CurrentControl com o NOME do controle
    * adicionado. E sem Sparse = .F. o CheckBox apareceria so na linha corrente,
    * com as demais linhas exibindo 0/1 como texto - o dump do legado ja declara
    * Column4.Sparse = .F. por isso.
    *
    * Idempotente porque o metodo roda em toda repintura e o alias da grade eh
    * derrubado a cada recarga: objeto recriado eh OUTRO objeto, e AddObject
    * sobre um que ainda esta vivo estoura "already defined".
    *
    * GEOMETRIA NAO EH ATRIBUIVEL AQUI - medido no VFP9 em 2026-11-09. Em
    * CheckBox que eh CurrentControl de uma Column, Top/Left/Width/Height sao
    * geridos pelo VFP e ficam em 0,0,10,10 independentemente do que se atribua
    * e da ORDEM em que se atribua. Medido com quatro variantes, grade com
    * RowHeight = 16 e Column.Width = 50:
    *
    *   geometria ANTES do CurrentControl   -> T=0 L=0 W=10 H=10
    *   geometria DEPOIS do CurrentControl  -> T=0 L=0 W=10 H=10
    *   geometria DEPOIS de Grid.Refresh()  -> T=0 L=0 W=10 H=10
    *   SEM atribuir geometria nenhuma      -> T=0 L=0 W=10 H=10
    *
    * Por isso os Top=24 / Left=13 / Height=17 / Width=60 do dump NAO sao
    * transcritos: sao coordenadas de TEMPO DE PROJETO do Form Designer (Top=24
    * em linha de 16px e 60 de largura em coluna de 50 ja mostram que nao sao de
    * renderizacao), e atribui-las seria codigo morto sugerindo que a area
    * clicavel foi ajustada quando nao foi. As demais propriedades PEGAM, e
    * foram medidas uma a uma: Caption, Alignment, ReadOnly, Visible, FontName,
    * FontSize e Value.
    *
    * .Value NUMERICO (0): CheckBox em VFP9 nasce com Value numerico (medido:
    * VARTYPE = "N"), e padraos eh numeric(1,0). Atribuir .F. criaria Value
    * logico e o primeiro REPLACE/comparacao estouraria "Operator/operand type
    * mismatch".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCheckBoxPadrao()
        IF PEMSTATUS(THIS.grd_4c_Dados.Column4, "chk_4c_Check1", 5)
            *-- Ainda vivo: nao recriar.
            RETURN .T.
        ENDIF

        THIS.grd_4c_Dados.Column4.AddObject("chk_4c_Check1", "CheckBox")

        WITH THIS.grd_4c_Dados.Column4.chk_4c_Check1
            .Caption   = ""
            .Alignment = 0
            .ReadOnly  = .F.
            .Visible   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
        ENDWITH

        *-- CheckBox em coluna de Grid NAO alterna pelo binding nativo: os 4
        *-- handlers suprimem o toggle automatico (NODEFAULT) e o REPLACE
        *-- exclusivo de PadraoMopKeyPress eh quem decide o valor novo.
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "Click",     THIS, "PadraoMopClick")
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "MouseDown", THIS, "PadraoMopMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "MouseUp",   THIS, "PadraoMopMouseUp")
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "KeyPress",  THIS, "PadraoMopKeyPress")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PadraoMopClick / PadraoMopMouseDown / PadraoMopMouseUp - suprimem o
    * toggle NATIVO do CheckBox da coluna "Padrao" (grd_4c_Dados.Column4.
    * chk_4c_Check1). Medido: CheckBox em coluna de Grid nao alterna o valor
    * so por clique/tecla quando o toggle real precisa ser EXCLUSIVO entre
    * linhas (REPLACE ALL) - por isso os tres so chamam NODEFAULT, e
    * PadraoMopMouseUp delega para PadraoMopKeyPress(13, 0), que faz o
    * trabalho de fato (equivalente a soltar o botao do mouse = Enter).
    *
    * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
    *--------------------------------------------------------------------------
    PROCEDURE PadraoMopClick()
        NODEFAULT
    ENDPROC

    PROCEDURE PadraoMopMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE PadraoMopMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.PadraoMopKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * PadraoMopKeyPress - alternancia EXCLUSIVA da coluna "Padrao": so UMA
    * linha da operacao pode ser a padrao.
    *
    * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column4.Check1.Click - o
    * legado le "This.Value"/"crSigCdMop.padraos" JA TROCADO pelo toggle
    * nativo do CheckBox; aqui o toggle eh calculado a mao, porque os
    * handlers acima suprimem o nativo):
    *   Select crSigCdMop
    *   lnRecno = Recno('crSigCdMop')
    *   If crSigCdMop.padraos = 0
    *       Update crSigCdMop Set padraos = 0
    *       Go lnRecno
    *   Else
    *       Update crSigCdMop Set padraos = 0 Where Recno() # lnRecno
    *       Update crSigCdMop Set padraos = 1 Where Recno() = lnRecno
    *       Select crSigCdMop
    *       Go lnRecno
    *   EndIf
    *   Select crSigCdMop
    *   ThisForm.GradeSubN.Refresh
    *
    * Disparado so em Enter(13) ou Espaco(32), igual ao padrao do projeto
    * para CheckBox de Grid (BINDEVENT KeyPress nao distingue tecla sozinho
    * - o filtro fica dentro do handler).
    *--------------------------------------------------------------------------
    PROCEDURE PadraoMopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor, loc_nRecno, loc_nNovoValor

        loc_cCursor = THIS.this_cCursorDados

        IF INLIST(NVL(par_nKeyCode, 0), 13, 32) AND USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)

            loc_nRecno     = RECNO()
            loc_nNovoValor = IIF(padraos = 0, 1, 0)

            REPLACE padraos WITH 0 ALL

            IF loc_nNovoValor = 1
                GOTO loc_nRecno
                REPLACE padraos WITH 1
            ENDIF

            GOTO loc_nRecno
            THIS.this_lHouveInsercao = .T.
            THIS.grd_4c_Dados.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCelulasEditaveisGrade - instala, de forma IDEMPOTENTE, as
    * celulas customizadas das colunas "Movimentacao" (Column1) e "Cores"
    * (Column3) - TextBoxMovimentacaoMop_4c / TextBoxCoresMop_4c
    * (classes\TextBoxGridLookup.prg).
    *
    * Mesma razao da idempotencia de GarantirCheckBoxPadrao: este metodo roda
    * em toda repintura (MontaGrade), e CarregarGrade DERRUBA o alias da
    * grade antes de cada recarga - o que destroi qualquer objeto posto por
    * Column.AddObject.
    *
    * Column.AddObject sozinho NAO faz o controle aparecer (regra #18): soh
    * depois do CurrentControl receber o NOME do objeto a Column passa a
    * desenhar ele no lugar do Text1 nativo. Sparse = .F. evita que o
    * controle so apareca na linha corrente (dump do legado: Column1 e
    * Column3 nao ficam Sparse por default so porque nunca precisaram antes
    * de ganhar controle customizado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCelulasEditaveisGrade()
        LOCAL loc_oGrade
        loc_oGrade = THIS.grd_4c_Dados

        IF !PEMSTATUS(loc_oGrade.Column1, "txt_4c_Movimentacao", 5)
            loc_oGrade.Column1.AddObject("txt_4c_Movimentacao", "TextBoxMovimentacaoMop_4c")
        ENDIF
        loc_oGrade.Column1.CurrentControl = "txt_4c_Movimentacao"
        loc_oGrade.Column1.Sparse         = .F.

        IF !PEMSTATUS(loc_oGrade.Column3, "txt_4c_Cores", 5)
            loc_oGrade.Column3.AddObject("txt_4c_Cores", "TextBoxCoresMop_4c")
        ENDIF
        loc_oGrade.Column3.CurrentControl = "txt_4c_Cores"
        loc_oGrade.Column3.Sparse         = .F.

        IF !PEMSTATUS(loc_oGrade.Column6, "txt_4c_GrandeGrupo", 5)
            loc_oGrade.Column6.AddObject("txt_4c_GrandeGrupo", "TextBoxGrandeGrupoMop_4c")
        ENDIF
        loc_oGrade.Column6.CurrentControl = "txt_4c_GrandeGrupo"
        loc_oGrade.Column6.Sparse         = .F.

        IF !PEMSTATUS(loc_oGrade.Column7, "txt_4c_Empresa", 5)
            loc_oGrade.Column7.AddObject("txt_4c_Empresa", "TextBoxEmpresaMop_4c")
        ENDIF
        loc_oGrade.Column7.CurrentControl = "txt_4c_Empresa"
        loc_oGrade.Column7.Sparse         = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarColunasGrade - largura, cabecalho, mascara e travas das 7
    * colunas, TRANSCRITAS do dump (SECAO 2).
    *
    * Roda sempre DEPOIS do bind: atribuir RecordSource/ControlSource reseta
    * Column.Width para o default 90 e Header1.Caption para "Header1".
    *
    * Column.ReadOnly vem DEPOIS de Grid.ReadOnly (definido em ConfigurarGrade):
    * o do grid propaga para as colunas e sobrescreveria estas travas.
    *
    * A coluna "Cores" segue a configuracao da operacao, igual ao legado:
    *   If LocalDcOpe.GerOpes <> 2
    *       .Column3.ReadOnly = .t.
    *   Else
    *       .SetAll('DynamicForeColor','iif(CrSigCdMop.ncors>0,nCors,0)','Column')
    *   Endif
    * Isto eh, so quando geropes = 2 a cor eh digitavel - e nesse caso o texto de
    * TODAS as colunas passa a ser pintado com a cor gravada na linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarColunasGrade()
        LOCAL loc_oGrade, loc_cCursor
        loc_oGrade  = THIS.grd_4c_Dados
        loc_cCursor = THIS.this_cCursorDados

        *-- Column1 "Movimentacao" - operacao FILHA (cnivels char(20)).
        *-- Aparencia do controle (FontName/BorderStyle/Margin/cores) vem da
        *-- classe TextBoxMovimentacaoMop_4c (GarantirCelulasEditaveisGrade),
        *-- que substitui o Text1 nativo - por isso nao se repete aqui.
        WITH loc_oGrade.Column1
            .Width     = 150
            .Movable   = .F.
            .Resizable = .F.
            .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        *-- Column2 "  #  " - numero da operacao, vem do JOIN e NAO eh editavel
        WITH loc_oGrade.Column2
            .Width     = 38
            .Movable   = .F.
            .InputMask = "9999"
            .Header1.Caption   = "  #  "
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.ReadOnly    = .T.
            .ReadOnly          = .T.
        ENDWITH

        *-- Column3 "Cores" - cor RGB (ncors numeric(10,0)). InputMask/
        *-- MaxLength/aparencia vem da classe TextBoxCoresMop_4c
        *-- (GarantirCelulasEditaveisGrade), que substitui o Text1 nativo.
        WITH loc_oGrade.Column3
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .Header1.Caption   = "Cores"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        *-- Column4 "Padrao" - CheckBox instalado por GarantirCheckBoxPadrao
        WITH loc_oGrade.Column4
            .Width     = 50
            .Sparse    = .F.
            .Header1.Caption   = "Padr" + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        *-- CurrentControl SO depois de o objeto existir: sem isto a coluna
        *-- continua desenhando o Text1 e o CheckBox nunca aparece.
        IF PEMSTATUS(loc_oGrade.Column4, "chk_4c_Check1", 5)
            loc_oGrade.Column4.CurrentControl = "chk_4c_Check1"
        ENDIF
        loc_oGrade.Column4.ReadOnly = .F.

        *-- Column5 "Ordem" - ordems numeric(3,0)
        WITH loc_oGrade.Column5
            .Width = 45
            .Header1.Caption   = "Ordem"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.InputMask   = "999"
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 "G.Grp" - grande grupo (mercs char(3), lookup SigCdGpr)
        WITH loc_oGrade.Column6
            .Width = 42
            .Header1.Caption   = "G.Grp"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            *-- Aparencia do controle (FontName/BorderStyle/Margin/cores) vem da
            *-- classe instalada por GarantirCelulasEditaveisGrade, que SUBSTITUI o
            *-- Text1 nativo via CurrentControl - repetir .Text1.* aqui seria codigo
            *-- morto, porque a coluna deixa de desenhar o Text1.
        ENDWITH

        *-- Column7 "Emp." - empresa de destino (empds char(3), lookup SigCdEmp)
        WITH loc_oGrade.Column7
            .Width     = 40
            .Movable   = .F.
            .Resizable = .F.
            .Header1.Caption   = "Emp."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .ReadOnly          = .F.
            *-- Aparencia do controle (FontName/BorderStyle/Margin/cores) vem da
            *-- classe instalada por GarantirCelulasEditaveisGrade, que SUBSTITUI o
            *-- Text1 nativo via CurrentControl - repetir .Text1.* aqui seria codigo
            *-- morto, porque a coluna deixa de desenhar o Text1.
        ENDWITH

        *-- Coluna "Cores": digitavel so quando geropes = 2 (legado)
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           THIS.this_oBusinessObject.this_nGerOpes = 2
            loc_oGrade.Column3.ReadOnly = .F.
            loc_oGrade.SetAll("DynamicForeColor", ;
                "IIF(" + loc_cCursor + ".ncors > 0, " + loc_cCursor + ".ncors, 0)", ;
                "Column")
        ELSE
            loc_oGrade.Column3.ReadOnly = .T.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaMovimentacaoMopEditavel - When da celula "Movimentacao"
    * (grd_4c_Dados.Column1.txt_4c_Movimentacao).
    *
    * TRANSCRITO do legado (Column1.Text1.When):
    *   Return( ( crSigCdMop.cDopes = crSigCdOpe.Dopes ) And
    *            IsEmpty( crSigCdMop.cNivels ) )
    * Isto eh: so a linha NOVA (ainda sem operacao filha) aceita foco nesta
    * coluna - uma vez preenchida, a Movimentacao nao se edita mais aqui.
    *
    * PUBLIC (sem PROTECTED): chamado de fora da classe pelo TextBox
    * customizado da Column (regra #3 - metodo delegado por objeto fora da
    * hierarquia do form tem de ser PUBLIC).
    *--------------------------------------------------------------------------
    PROCEDURE CelulaMovimentacaoMopEditavel()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorDados

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        RETURN ALLTRIM(EVALUATE(loc_cCursor + ".cdopes")) == ALLTRIM(THIS.this_cOperacaoPai) AND ;
               EMPTY(ALLTRIM(EVALUATE(loc_cCursor + ".cnivels")))
    ENDPROC

    *--------------------------------------------------------------------------
    * MovimentacaoMopLostFocusExec - LostFocus da celula "Movimentacao".
    *
    * TRANSCRITO do legado (Column1.Text1.LostFocus):
    *   If IsEmpty(This.Value) / Thisform.cmdSair.SetFocus / Endif
    * (linha ficou sem Movimentacao - foca o botao de saida em vez de deixar
    * o foco preso na grade).
    *--------------------------------------------------------------------------
    PROCEDURE MovimentacaoMopLostFocusExec(par_oTxt)
        IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) AND PEMSTATUS(THIS, "cmd_4c_CmdSair", 5)
            THIS.cmd_4c_CmdSair.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMovimentacaoMopExec - Valid da celula "Movimentacao"
    * (grd_4c_Dados.Column1.txt_4c_Movimentacao): LOOKUP em SigCdOpe.
    *
    * WRAPPER da guarda de reentrancia (ver this_lEmLookup). O corpo fica em
    * ValidarMovimentacaoMopCorpo para que a flag seja SEMPRE liberada aqui,
    * inclusive quando o corpo recusa o valor e devolve .F.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMovimentacaoMopExec(par_oTxt)
        LOCAL loc_lAceita

        IF THIS.this_lEmLookup
            RETURN .T.
        ENDIF

        THIS.this_lEmLookup = .T.
        loc_lAceita         = THIS.ValidarMovimentacaoMopCorpo(par_oTxt)
        THIS.this_lEmLookup = .F.

        RETURN loc_lAceita
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMovimentacaoMopCorpo - corpo do lookup da operacao FILHA.
    *
    * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column1.Text1.Valid):
    *   If Not IsEmpty(This.Value)
    *       xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'cpSigCdOpe',
    *                 'Dopes', This.Value, 'Cadastro de Operacoes', .t., 'Dopes')
    *       If Not xBrox.plAchouRegistro
    *           xBrox.mAddColuna('Dopes',  '',     'Operacao', .t.)
    *           xBrox.mAddColuna('nDopes', '9999', ' # ',      .f.)
    *           xBrox.Show()
    *       EndIf
    *       =Seek(cpSigCdOpe.Dopes,'LocalDcOpe','Dopes')
    *       If LocalDcOpe.OpeInatvs = 1
    *           MessageBox('Esta Operacao esta Inativa!!!!',0+16,'Atencao...')
    *           This.Value = ' '
    *           Return .f.
    *       Endif
    *       This.Value = cpSigCdOpe.Dopes
    *       Replace nDopes With CpSigCdOpe.nDopes in CrSigCdMop
    *       This.Refresh
    *   EndIf
    *   Select CrSigCdMop
    *   Return .t.
    *
    * O "LocalDcOpe" do legado eh o cursor de SigOpCdc que o Init carrega
    * (Select Dopes, GerOpes, OpeInatvs From SigOpCdc + Index On Dopes) - aqui
    * ele eh this_oBusinessObject.this_cCursorConfig, populado por
    * CarregarConfiguracaoOperacao. A consulta de inatividade esta em
    * ObterOperacaoInativa, que usa LOCATE e nao SEEK: o projeto roda com
    * SET EXACT ON e, nesse modo, o SEEK exigiria a chave com o padding exato
    * de char(20) (mesma razao ja documentada no BO).
    *
    * O REPLACE de ndopes eh o que preenche a coluna "  #  " da grade: ela NAO
    * existe em SigCdMop, vem do JOIN com SigCdOpe, e por isso tem de ser
    * gravada no cursor a mao quando o usuario escolhe a operacao FILHA.
    *
    * DUAS divergencias deliberadas em relacao ao legado, as duas pelo mesmo
    * motivo (regras #37 e #50):
    *
    *   1. O legado le cpSigCdOpe.Dopes mesmo quando o usuario ABANDONA o
    *      picker (ESC) - e nesse caso o cursor esta posicionado na primeira
    *      linha da busca parcial, de modo que a celula recebe um valor que
    *      ninguem escolheu. Aqui a atribuicao fica DENTRO da guarda
    *      this_lSelecionou e o valor DIGITADO eh preservado.
    *   2. Universo vazio NAO gera aviso nem apaga o que foi digitado: o
    *      proprio picker eh o feedback, e limpar o campo impediria o usuario
    *      de terminar de preencher o codigo.
    *
    * O "This.Value = ' '" da operacao INATIVA, por outro lado, eh TRANSCRITO:
    * ali o registro EXISTE e foi escolhido, e eh o legado que o recusa
    * explicitamente, com mensagem e com Return .f. para o foco nao sair da
    * celula.
    *
    * Sem conexao (harness/validacao de UI) o lookup nao roda e o valor
    * digitado eh aceito como esta: SQLEXEC com handle invalido dispara
    * excecao, e abrir picker MODAL em teste headless travaria o processo.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMovimentacaoMopCorpo(par_oTxt)
        LOCAL loc_lAceita, loc_cCursor, loc_cDigitado

        loc_lAceita   = .T.
        loc_cCursor   = THIS.this_cCursorDados
        loc_cDigitado = ALLTRIM(NVL(par_oTxt.Value, ""))

        *-- Sem conexao (harness/validacao de UI) o picker nao roda e o valor
        *-- digitado eh aceito como esta: SQLEXEC com handle invalido dispara
        *-- excecao, e abrir picker MODAL em teste headless travaria o processo.
        IF !EMPTY(loc_cDigitado) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_lAceita = THIS.AbrirBuscaMovimentacaoMop(par_oTxt)
        ENDIF

        *-- "Select CrSigCdMop" do fim do Valid legado: o picker e o cursor de
        *-- configuracao mexem na area de trabalho corrente, e a grade continua
        *-- operando sobre o cursor dela.
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
        ENDIF

        RETURN loc_lAceita
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMovimentacaoMop - picker de SigCdOpe da celula "Movimentacao".
    *
    * Equivale ao bloco fwBuscaExt do Valid legado:
    *   xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'cpSigCdOpe',
    *             'Dopes', This.Value, 'Cadastro de Operacoes', .t., 'Dopes')
    *   If Not xBrox.plAchouRegistro
    *       xBrox.mAddColuna('Dopes',  '',     'Operacao', .t.)
    *       xBrox.mAddColuna('nDopes', '9999', ' # ',      .f.)
    *       xBrox.Show()
    *   EndIf
    *
    * Devolve .F. SO quando a operacao escolhida esta INATIVA - ai o Valid
    * precisa recusar o valor para o foco nao sair da celula (transcrito do
    * "This.Value = ' ' / Return .f." do legado). Nos demais caminhos devolve
    * .T.: nao achar nada NAO eh erro (regra #50).
    *
    * O REPLACE de ndopes eh o que preenche a coluna "  #  " da grade: ela NAO
    * existe em SigCdMop, vem do JOIN com SigCdOpe, e por isso tem de ser
    * gravada no cursor a mao quando o usuario escolhe a operacao FILHA.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMovimentacaoMop(par_oTxt)
        LOCAL loc_lAceita, loc_cCursor, loc_cCursorBusca, loc_cDigitado
        LOCAL loc_oBusca, loc_oErro, loc_cEscolhida, loc_nNdopes, loc_nInativa

        loc_lAceita      = .T.
        loc_cCursor      = THIS.this_cCursorDados
        loc_cCursorBusca = "cursor_4c_BuscaOpe"
        loc_cDigitado    = ALLTRIM(NVL(par_oTxt.Value, ""))

        TRY
            IF USED(loc_cCursorBusca)
                USE IN (loc_cCursorBusca)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", loc_cCursorBusca, "dopes", loc_cDigitado, ;
                "Cadastro de Opera" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() SO quando o Init nao resolveu sozinho: com match
                *-- exato o dialogo subiria por cima da celula ja resolvida
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dopes", "", ;
                        "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("ndopes", "9999", "  #  ")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
                    loc_cEscolhida = ALLTRIM(NVL(EVALUATE(loc_cCursorBusca + ".dopes"), ""))
                    loc_nNdopes    = TratarNulo(EVALUATE(loc_cCursorBusca + ".ndopes"), 0)
                    loc_nInativa   = THIS.ObterOperacaoInativa(loc_cEscolhida)

                    IF loc_nInativa = 1
                        MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o est" + ;
                                 CHR(225) + " Inativa!!!!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o...")
                        par_oTxt.Value = " "
                        loc_lAceita    = .F.
                    ELSE
                        par_oTxt.Value = loc_cEscolhida

                        IF USED(loc_cCursor)
                            REPLACE ndopes WITH loc_nNdopes IN (loc_cCursor)
                        ENDIF

                        par_oTxt.Refresh()
                    ENDIF
                ENDIF

                IF USED(loc_cCursorBusca)
                    USE IN (loc_cCursorBusca)
                ENDIF

                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em AbrirBuscaMovimentacaoMop")
        ENDTRY

        RETURN loc_lAceita
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterOperacaoInativa - devolve 1 quando a operacao informada esta
    * marcada como INATIVA em SigOpCdc, e 0 caso contrario.
    *
    * Equivale ao par do legado:
    *   =Seek(cpSigCdOpe.Dopes,'LocalDcOpe','Dopes')
    *   If LocalDcOpe.OpeInatvs = 1
    *
    * LOCATE em vez de SEEK por causa do SET EXACT ON do projeto (mesma razao
    * do comentario de CarregarConfiguracaoOperacao no BO). A area de trabalho
    * corrente eh salva e restaurada: o LOCATE roda no cursor de configuracao e
    * quem chama continua precisando do cursor da GRADE selecionado.
    *
    * O VARTYPE eh conferido antes de comparar porque coluna de marcacao do
    * SQL Server chega ao VFP ora Numerica (numeric(1,0)) ora Logica (bit),
    * conforme o driver - comparar Logico com 1 estouraria
    * "Operator/operand type mismatch" (regra #13).
    *--------------------------------------------------------------------------
    PROCEDURE ObterOperacaoInativa(par_cOperacao)
        LOCAL loc_nInativa, loc_cCursorConfig, loc_cAreaAnterior, loc_uValor

        loc_nInativa = 0

        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
           VARTYPE(par_cOperacao) != "C" OR EMPTY(ALLTRIM(par_cOperacao))
            RETURN loc_nInativa
        ENDIF

        loc_cCursorConfig = THIS.this_oBusinessObject.this_cCursorConfig

        IF !USED(loc_cCursorConfig)
            RETURN loc_nInativa
        ENDIF

        loc_cAreaAnterior = ALIAS()

        SELECT (loc_cCursorConfig)
        LOCATE FOR ALLTRIM(dopes) == ALLTRIM(par_cOperacao)

        IF FOUND()
            loc_uValor = TratarNulo(opeinatvs, 0)

            DO CASE
                CASE VARTYPE(loc_uValor) = "N"
                    loc_nInativa = loc_uValor
                CASE VARTYPE(loc_uValor) = "L"
                    loc_nInativa = IIF(loc_uValor, 1, 0)
                OTHERWISE
                    loc_nInativa = 0
            ENDCASE
        ENDIF

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_nInativa
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaCoresMopEditavel - When da celula "Cores"
    * (grd_4c_Dados.Column3.txt_4c_Cores).
    *
    * TRANSCRITO do legado (Column3.Text1.When):
    *   ThisForm.Antvalue = This.Value
    *   Return( ( crSigCdMop.cDopes = crSigCdOpe.Dopes ) And
    *            Not IsEmpty( crSigCdMop.cNivels ) )
    * O snapshot do valor anterior (this_nValorAnterior) vai ANTES do teste
    * de editabilidade, na MESMA ordem do legado - eh dele que o Valid
    * (ValidarCoresMopExec) decide se o usuario realmente mudou o valor.
    *--------------------------------------------------------------------------
    PROCEDURE CelulaCoresMopEditavel(par_oTxt)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorDados

        THIS.this_nValorAnterior = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, 0)

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        RETURN ALLTRIM(EVALUATE(loc_cCursor + ".cdopes")) == ALLTRIM(THIS.this_cOperacaoPai) AND ;
               !EMPTY(ALLTRIM(EVALUATE(loc_cCursor + ".cnivels")))
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCoresMopExec - Valid da celula "Cores".
    *
    * TRANSCRITO do legado (Column3.Text1.Valid):
    *   If This.Value <> ThisForm.Antvalue
    *       Thisform.lHouveIns = .T.
    *       If This.Value > 0
    *           x = GetColor(This.Value)
    *           If x > 0 / This.Value = x / Else / This.Value = 0 / Endif
    *           This.Refresh
    *       Endif
    *   Endif
    * GETCOLOR() eh funcao NATIVA do VFP9 (abre o seletor de cor do Windows) -
    * nao eh lookup em tabela, por isso o Valid inteiro fica nesta fase e nao
    * na Fase 6 (que cobre os lookups de SigCdOpe/SigCdGpr/SigCdEmp).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCoresMopExec(par_oTxt)
        LOCAL loc_nEscolhida

        IF par_oTxt.Value != THIS.this_nValorAnterior
            THIS.this_lHouveInsercao = .T.

            IF par_oTxt.Value > 0
                loc_nEscolhida = GETCOLOR(par_oTxt.Value)

                IF loc_nEscolhida > 0
                    par_oTxt.Value = loc_nEscolhida
                ELSE
                    par_oTxt.Value = 0
                ENDIF

                par_oTxt.Refresh()
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GrandeGrupoMopGotFocusExec - GotFocus da celula "G.Grp"
    * (grd_4c_Dados.Column6.txt_4c_GrandeGrupo).
    *
    * TRANSCRITO do legado (Column6.Text1.GotFocus):
    *   This.Tag = This.Value
    *
    * Metade do detector de alteracao: o Tag guarda o valor de ENTRADA e o
    * LostFocus compara com o de SAIDA. Sem este GotFocus o Tag nasceria vazio
    * e QUALQUER passagem pela celula marcaria a tela como alterada.
    *
    * .Tag eh CHARACTER em VFP9 e nao aceita outro tipo - por isso guarda-se o
    * ALLTRIM() do valor, nunca o valor cru.
    *--------------------------------------------------------------------------
    PROCEDURE GrandeGrupoMopGotFocusExec(par_oTxt)
        par_oTxt.Tag = ALLTRIM(NVL(par_oTxt.Value, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * GrandeGrupoMopLostFocusExec - LostFocus da celula "G.Grp".
    *
    * TRANSCRITO do legado (Column6.Text1.LostFocus):
    *   If (This.Tag <> This.Value)
    *       Thisform.lHouveIns = .T.
    *   EndIf
    *
    * A outra metade do detector: trocou o grande grupo, a tela passa a ter o
    * que gravar. Eh esta flag que o cmdSair do legado consulta para decidir se
    * executa a gravacao do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE GrandeGrupoMopLostFocusExec(par_oTxt)
        IF ALLTRIM(NVL(par_oTxt.Tag, "")) != ALLTRIM(NVL(par_oTxt.Value, ""))
            THIS.this_lHouveInsercao = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrandeGrupoMopExec - Valid da celula "G.Grp": LOOKUP em SigCdGpr.
    *
    * WRAPPER da guarda de reentrancia (ver this_lEmLookup) - o corpo fica em
    * ValidarGrandeGrupoMopCorpo para que a flag seja SEMPRE liberada aqui.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrandeGrupoMopExec(par_oTxt)
        LOCAL loc_lAceita

        IF THIS.this_lEmLookup
            RETURN .T.
        ENDIF

        THIS.this_lEmLookup = .T.
        loc_lAceita         = THIS.ValidarGrandeGrupoMopCorpo(par_oTxt)
        THIS.this_lEmLookup = .F.

        RETURN loc_lAceita
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrandeGrupoMopCorpo - corpo do lookup do grande grupo.
    *
    * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column6.Text1.Valid):
    *   If Not Empty(This.Value)
    *       loLista = CreateObject([fwBuscaExt], <conn>, [SigCdGpr],
    *                   [crListaRemota], [Codigos], This.Value, [Selecao], .t.)
    *       If Not loLista.plAchouRegistro
    *           loLista.mAddColuna([Codigos], [], [Codigo])
    *           loLista.mAddColuna([Descs],   [], [Descricao])
    *           loLista.Show()
    *       EndIf
    *       This.Value = crListaRemota.Codigos
    *       Use In crListaRemota
    *   EndIf
    *   This.Refresh
    *
    * Colunas conferidas em docs\schema.sql: SigCdGpr.codigos char(3) e
    * SigCdGpr.descrs char(40) - NAO "descrs" (essa eh de SigCdGcr, que eh outra
    * tabela). O destino na grade eh SigCdMop.mercs, tambem char(3).
    *
    * A atribuicao fica DENTRO da guarda this_lSelecionou (regra #37): o legado
    * le crListaRemota.Codigos mesmo quando o usuario abandona o picker, e com
    * isso a celula recebe a primeira linha da busca parcial sem ninguem ter
    * escolhido. Universo vazio nao gera aviso nem apaga o digitado (regra #50).
    *
    * O Refresh final fica FORA do IF, igual ao legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrandeGrupoMopCorpo(par_oTxt)
        LOCAL loc_cCursor, loc_cDigitado

        loc_cCursor   = THIS.this_cCursorDados
        loc_cDigitado = ALLTRIM(NVL(par_oTxt.Value, ""))

        *-- Sem conexao (harness/validacao de UI) o picker nao roda e o valor
        *-- digitado eh aceito como esta.
        IF !EMPTY(loc_cDigitado) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.AbrirBuscaGrandeGrupoMop(par_oTxt)
        ENDIF

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
        ENDIF

        *-- O Refresh final fica FORA do IF, igual ao legado.
        par_oTxt.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrandeGrupoMop - picker de SigCdGpr da celula "G.Grp".
    *
    * Equivale ao bloco fwBuscaExt do Valid legado (Column6.Text1.Valid):
    *   loLista = CreateObject([fwBuscaExt], <conn>, [SigCdGpr],
    *               [crListaRemota], [Codigos], This.Value, [Selecao], .t.)
    *   If Not loLista.plAchouRegistro
    *       loLista.mAddColuna([Codigos], [], [Codigo])
    *       loLista.mAddColuna([Descs],   [], [Descricao])
    *       loLista.Show()
    *   EndIf
    *
    * DIVERGENCIA deliberada: o legado faz "This.Value = crListaRemota.Codigos"
    * FORA de qualquer guarda, inclusive quando o usuario ABANDONA o picker com
    * ESC - e nesse caso o cursor esta na primeira linha da busca parcial, de
    * modo que a celula recebe um valor que ninguem escolheu. Aqui a atribuicao
    * fica DENTRO da guarda this_lSelecionou e o valor DIGITADO eh preservado
    * (regras #37 e #50). Universo vazio nao avisa nem apaga o digitado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrandeGrupoMop(par_oTxt)
        LOCAL loc_cCursorBusca, loc_cDigitado
        LOCAL loc_oBusca, loc_oErro, loc_cEscolhido

        loc_cCursorBusca = "cursor_4c_BuscaGpr"
        loc_cDigitado    = ALLTRIM(NVL(par_oTxt.Value, ""))

        TRY
            IF USED(loc_cCursorBusca)
                USE IN (loc_cCursorBusca)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", loc_cCursorBusca, "codigos", loc_cDigitado, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
                    loc_cEscolhido = ALLTRIM(NVL(EVALUATE(loc_cCursorBusca + ".codigos"), ""))
                    par_oTxt.Value = loc_cEscolhido
                ENDIF

                IF USED(loc_cCursorBusca)
                    USE IN (loc_cCursorBusca)
                ENDIF

                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em AbrirBuscaGrandeGrupoMop")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaMopExec - Valid da celula "Emp."
    * (grd_4c_Dados.Column7.txt_4c_Empresa): LOOKUP em SigCdEmp.
    *
    * WRAPPER da guarda de reentrancia (ver this_lEmLookup) - o corpo fica em
    * ValidarEmpresaMopCorpo para que a flag seja SEMPRE liberada aqui.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresaMopExec(par_oTxt)
        LOCAL loc_lAceita

        IF THIS.this_lEmLookup
            RETURN .T.
        ENDIF

        THIS.this_lEmLookup = .T.
        loc_lAceita         = THIS.ValidarEmpresaMopCorpo(par_oTxt)
        THIS.this_lEmLookup = .F.

        RETURN loc_lAceita
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaMopCorpo - corpo do lookup da empresa de destino.
    *
    * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column7.Text1.Valid):
    *   If !IsEmpty( This.Value )
    *       xBrox = CreateObject('fwbuscaext', <conn>, 'SigCdEmp', 'crSigCdEmp',
    *                 'cEmps', This.Value, 'Empresas', .t., 'cEmps')
    *       If  Not xBrox.plAchouRegistro
    *           xBrox.mAddColuna('CEmps', 'XXXXXX', 'Codigo', .t.)
    *           xBrox.mAddColuna('Razas', '', 'Descricao', .t.)
    *           xBrox.Show()
    *           This.Value = Iif( LastKey() # 27, Evaluate('crSigCdEmp.CEmps'), '' )
    *       EndIf
    *   Endif
    *
    * Colunas CANONICAS de SigCdEmp, conferidas em docs\schema.sql:
    * cemps char(3) (codigo) e razas char(40) (descricao) - NUNCA "Emps" nem
    * "NComps", que nao existem nessa tabela. O destino na grade eh
    * SigCdMop.empds, tambem char(3).
    *
    * A mascara da coluna de codigo vai como "XXX" (tres posicoes = char(3)) e
    * nao como o "XXXXXX" do dump: o legado tinha seis X para uma coluna de
    * tres, e "XXX" eh tambem a forma canonica do projeto para SigCdEmp.cemps.
    *
    * DIVERGENCIA DELIBERADA: o legado limpa a celula quando o usuario sai do
    * picker com ESC ("Iif( LastKey() # 27, ..., '' )"). O FormBuscaAuxiliar do
    * projeto nao distingue ESC de universo vazio - as duas situacoes chegam
    * como this_lSelecionou = .F. -, entao reproduzir o clear apagaria o codigo
    * digitado tambem quando a consulta nao devolve linha nenhuma, que eh
    * exatamente o defeito proibido pela regra #50 (o usuario fica sem como
    * preencher o campo). Aqui o valor escolhido eh atribuido sob a guarda e, em
    * qualquer outro caminho, o DIGITADO eh preservado.
    *
    * Esta celula NAO tem LostFocus no legado - editar so a empresa nao liga a
    * flag de gravacao. Comportamento TRANSCRITO, nao esquecimento: na pratica a
    * linha so chega a ter empresa depois de passar por Inserir, que ja liga a
    * flag, e inventar aqui um LostFocus que o legado nao tem mudaria o criterio
    * com que a tela decide gravar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresaMopCorpo(par_oTxt)
        LOCAL loc_cCursor, loc_cDigitado

        loc_cCursor   = THIS.this_cCursorDados
        loc_cDigitado = ALLTRIM(NVL(par_oTxt.Value, ""))

        *-- Sem conexao (harness/validacao de UI) o picker nao roda e o valor
        *-- digitado eh aceito como esta.
        IF !EMPTY(loc_cDigitado) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.AbrirBuscaEmpresaMop(par_oTxt)
        ENDIF

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresaMop - picker de SigCdEmp da celula "Emp.".
    *
    * Equivale ao bloco fwBuscaExt do Valid legado (Column7.Text1.Valid):
    *   xBrox = CreateObject('fwbuscaext', <conn>, 'SigCdEmp', 'crSigCdEmp',
    *             'cEmps', This.Value, 'Empresas', .t., 'cEmps')
    *   If Not xBrox.plAchouRegistro
    *       xBrox.mAddColuna('CEmps', 'XXXXXX', 'Codigo',    .t.)
    *       xBrox.mAddColuna('Razas', '',       'Descricao', .t.)
    *       xBrox.Show()
    *       This.Value = Iif( LastKey() # 27, Evaluate('crSigCdEmp.CEmps'), '' )
    *   EndIf
    *
    * As colunas sao cemps char(3) + razas char(40) - nomes CANONICOS de
    * SigCdEmp (NUNCA Cemps/Razas, que nao existem). A mascara do codigo eh
    * "XXX", nao o "XXXXXX" do legado, porque a coluna eh char(3).
    *
    * DIVERGENCIA deliberada: o legado limpa a celula quando LastKey() = 27
    * (ESC). Como o FormBuscaAuxiliar nao distingue ESC de universo vazio,
    * reproduzir esse clear cairia exatamente no defeito da regra #50 - o
    * usuario digitaria o codigo e o campo voltaria vazio, sem conseguir
    * preencher. Aqui o valor so eh trocado sob this_lSelecionou (regra #37).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresaMop(par_oTxt)
        LOCAL loc_cCursorBusca, loc_cDigitado
        LOCAL loc_oBusca, loc_oErro, loc_cEscolhida

        loc_cCursorBusca = "cursor_4c_BuscaEmp"
        loc_cDigitado    = ALLTRIM(NVL(par_oTxt.Value, ""))

        TRY
            IF USED(loc_cCursorBusca)
                USE IN (loc_cCursorBusca)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", loc_cCursorBusca, "cemps", loc_cDigitado, ;
                "Empresas")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cemps", "XXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razas", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
                    loc_cEscolhida = ALLTRIM(NVL(EVALUATE(loc_cCursorBusca + ".cemps"), ""))
                    par_oTxt.Value = loc_cEscolhida
                ENDIF

                IF USED(loc_cCursorBusca)
                    USE IN (loc_cCursorBusca)
                ENDIF

                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em AbrirBuscaEmpresaMop")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.;
    * este metodo percorre a arvore e liga a visibilidade.
    *
    * Nao ha lista de excecao aqui: o dump de SIGOPMOP nao declara Visible
    * = .F. em objeto nenhum, e esta tela nao tem container flutuante
    * alternado por botao. A visibilidade condicional que o legado tem eh a de
    * cmdInserir/cmdExcluir, calculada por permissao e pelo modo do form PAI -
    * ela eh aplicada DEPOIS desta varredura, junto com os botoes (Fase 4).
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControle)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form chamador e libera o objeto de negocio.
    *
    * A reabilitacao do pai eh FUNIL: o legado a faz no cmdSair.Click, que so
    * cobre a saida pelo botao Encerrar; aqui ela fica no Destroy, que roda
    * em qualquer caminho de fechamento (botao, ESC/Cancel, Release de fora).
    * Sem isso, fechar o dialogo por outro caminho deixaria o Cadastro de
    * Operacoes inerte para o resto da sessao - estado que ninguem restaura,
    * nao estoura e nao entra em log.
    *
    * O cursor da grade NAO eh fechado aqui: com DataSession = 1 ele vive na
    * sessao do form chamador (que eh quem continua a usa-lo depois deste
    * dialogo fechar), igual ao legado, que roda na sessao do pai e nao fecha
    * crSigCdMop no cmdSair.
    *
    * DODEFAULT() na ULTIMA linha, para que FormBase.Destroy execute e
    * reconstrua os popups do menu principal.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.HabilitarFormPai(.T.)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpMopBO.prg):
*====================================================================
* SigOpMopBO.prg
*
* Business Object para Geracao de Multiplas Operacoes
* Origem legado: SIGOPMOP.SCX (form OPERACIONAL - dialogo filho de SIGCDOPE)
* Tabela: SigCdMop
* Herda de: BusinessBase
*
* A tela eh um dialogo filho aberto pelo Cadastro de Operacoes (SigCdOpe).
* Cada linha da grade eh um registro de SigCdMop que amarra a operacao PAI
* (cdopes) a uma operacao FILHA (cnivels), com cor, ordem, grande grupo e
* empresa de destino.
*
* Colunas de SigCdMop (TODAS NOT NULL - ver docs\schema.sql):
*   cdopes    char(20)        - operacao PAI  (crSigCdOpe.Dopes no legado)
*   cidchaves char(20)        - PK, gerada por fUniqueIds()
*   cnivels   char(20)        - operacao FILHA ("Movimentacao" na grade)
*   ncors     numeric(10,0)   - cor RGB ("Cores")
*   padraos   numeric(1,0)    - marca de linha padrao ("Padrao")
*   ordems    numeric(3,0)    - ordem de execucao ("Ordem")
*   mercs     char(3)         - grande grupo ("G.Grp")
*   empds     char(3)         - empresa de destino ("Emp.") - DEFAULT ('')
*   opers     char(1)         - sem controle na tela      - DEFAULT ('')
*
* ATENCAO: ndopes NAO existe em SigCdMop. Eh coluna de EXIBICAO da grade,
* lida de SigCdOpe.ndopes pelo legado ("Replace nDopes With CpSigCdOpe.nDopes
* in CrSigCdMop") e por isso NUNCA entra no INSERT/UPDATE desta tabela.
*====================================================================

DEFINE CLASS SigOpMopBO AS BusinessBase

    *----------------------------------------------------------------
    * Propriedades da entidade (mapeamento 1-para-1 com SigCdMop)
    *----------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves char(20)      - PK (fUniqueIds)
    this_cCdopes      = ""    && cdopes    char(20)      - operacao PAI
    this_cCnivels     = ""    && cnivels   char(20)      - operacao FILHA
    this_nNcors       = 0     && ncors     numeric(10,0) - cor RGB
    this_nPadraos     = 0     && padraos   numeric(1,0)  - linha padrao
    this_nOrdems      = 0     && ordems    numeric(3,0)  - ordem
    this_cMercs       = ""    && mercs     char(3)       - grande grupo
    this_cEmpds       = ""    && empds     char(3)       - empresa destino
    this_cOpers       = ""    && opers     char(1)       - sem UI (NOT NULL)

    *----------------------------------------------------------------
    * Propriedade de EXIBICAO - vem de SigCdOpe.ndopes, NAO de SigCdMop.
    * Fica no cursor da grade (coluna " # ") e nao eh persistida aqui.
    *----------------------------------------------------------------
    this_nNdopes      = 0     && ndopes    numeric(4,0)  - numero da operacao

    *----------------------------------------------------------------
    * Contexto recebido do form PAI (SigCdOpe) ao abrir o dialogo
    *----------------------------------------------------------------
    this_cOperacaoPai = ""    && Dopes da operacao corrente no form pai
    this_cEscolha     = ""    && Modo do pai: INSERIR / ALTERAR / PROCURAR

    *----------------------------------------------------------------
    * Configuracao da operacao (SigOpCdc) - decide o comportamento da grade
    *   geropes   <> 2 trava a coluna "Cores" (legado: Column3.ReadOnly = .T.)
    *   opeinatvs  = 1 recusa a operacao digitada em "Movimentacao"
    *----------------------------------------------------------------
    this_nGerOpes     = 0     && SigOpCdc.geropes   numeric(1,0)
    this_nOpeInatvs   = 0     && SigOpCdc.opeinatvs numeric(1,0)

    *----------------------------------------------------------------
    * Nomes de cursores (centralizados para a grade nao perder o bind)
    *----------------------------------------------------------------
    this_cCursorDados  = "cursor_4c_Dados"       && cursor da grade (crSigCdMop)
    this_cCursorTemp   = "cursor_4c_DadosTmp"    && destino dos SQLEXEC
    this_cCursorConfig = "cursor_4c_ConfigOpe"   && LocalDcOpe do legado
    this_cCursorBusca  = "cursor_4c_Busca"       && reserva (os lookups da grade usam um cursor por tabela)
    this_cCursorChaves = "cursor_4c_ChavesMop"   && cidchaves JA gravadas (reconciliacao da gravacao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMop"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cCursorDados  = "cursor_4c_Dados"
            THIS.this_cCursorTemp   = "cursor_4c_DadosTmp"
            THIS.this_cCursorConfig = "cursor_4c_ConfigOpe"
            THIS.this_cCursorBusca  = "cursor_4c_Busca"
            THIS.this_cCursorChaves = "cursor_4c_ChavesMop"

            THIS.this_lEmEdicao     = .F.
            THIS.this_lNovoRegistro = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpMopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria para a auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de uma linha
    * do cursor da grade (cursor_4c_Dados / crSigCdMop no legado).
    *
    * this_nNdopes NAO vem de SigCdMop - eh lido do mesmo cursor porque a
    * grade de SigOpMopBO.Buscar() ja traz essa coluna de exibicao vinda
    * do JOIN com SigCdOpe (ver comentario no cabecalho do arquivo).
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCdopes    = TratarNulo(cdopes,    "")
                THIS.this_cCnivels   = TratarNulo(cnivels,   "")
                THIS.this_nNcors     = TratarNulo(ncors,      0)
                THIS.this_nPadraos   = TratarNulo(padraos,    0)
                THIS.this_nOrdems    = TratarNulo(ordems,     0)
                THIS.this_cMercs     = TratarNulo(mercs,     "")
                THIS.this_cEmpds     = TratarNulo(empds,     "")
                THIS.this_cOpers     = TratarNulo(opers,     "")

                IF TYPE(par_cAliasCursor + ".ndopes") != "U"
                    THIS.this_nNdopes = TratarNulo(ndopes,  0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere nova linha na tabela SigCdMop
    *
    * Transcreve o cmdInserir.Click do legado (ver InicializarValoresPadrao):
    * todas as colunas sao NOT NULL, entao TODAS entram no INSERT - inclusive
    * empds/opers, que nao tem controle visivel na grade (regra #22).
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMop (cidchaves, cdopes, cnivels, ncors, padraos, ordems, mercs, empds, opers)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCdopes)>>,
                    <<EscaparSQL(THIS.this_cCnivels)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    <<EscaparSQL(THIS.this_cMercs)>>,
                    <<EscaparSQL(THIS.this_cEmpds)>>,
                    <<EscaparSQL(THIS.this_cOpers)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza linha existente na tabela SigCdMop
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMop
                SET cdopes  = <<EscaparSQL(THIS.this_cCdopes)>>,
                    cnivels = <<EscaparSQL(THIS.this_cCnivels)>>,
                    ncors   = <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    padraos = <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    ordems  = <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    mercs   = <<EscaparSQL(THIS.this_cMercs)>>,
                    empds   = <<EscaparSQL(THIS.this_cEmpds)>>,
                    opers   = <<EscaparSQL(THIS.this_cOpers)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as propriedades da entidade
    *
    * Mantem o CONTEXTO (operacao pai, modo e configuracao da operacao):
    * ele vem do form pai na abertura do dialogo e vale para todas as
    * linhas, nao para uma linha so.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCdopes    = ""
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Defaults da linha NOVA
    *
    * Transcreve o cmdInserir.Click do legado:
    *   Insert Into crSigCdMop (cDopes, CidChaves) ;
    *       Values (crSigCdOpe.Dopes, fUniqueIds())
    * Ou seja: a linha nova nasce amarrada a operacao PAI, com PK propria,
    * e o restante em branco/zero (as colunas sao NOT NULL, por isso
    * precisam de valor explicito - nunca NULL).
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
        THIS.this_cCdopes    = ALLTRIM(THIS.this_cOperacaoPai)
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarConfiguracaoOperacao - popula o cursor de configuracao das
    * operacoes (SigOpCdc) e resolve geropes/opeinatvs da operacao PAI.
    *
    * TRANSCRITO do Init legado:
    *   lcSql = [Select Dopes, GerOpes, OpeInatvs From SigOpCdc ]
    *   SigCdOpe.Podatamgr.Sqlexecute(lcSql,'LocalDcOpe')
    *   Select LocalDcOpe
    *   Index On Dopes Tag dopes
    *   =Seek(CrSigCdOpe.Dopes)
    *
    * O cursor carrega TODAS as operacoes de proposito, e NAO so a corrente:
    * o Valid da coluna "Movimentacao" reconsulta este mesmo cursor para
    * recusar a operacao digitada quando ela esta inativa ("=Seek(
    * cpSigCdOpe.Dopes,'LocalDcOpe','Dopes') / If LocalDcOpe.OpeInatvs = 1").
    * Filtrar aqui pela operacao PAI deixaria aquela checagem sem base.
    *
    * geropes decide se a coluna "Cores" aceita digitacao (<> 2 trava), e eh
    * por isso que esta carga roda ANTES da montagem da grade.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        THIS.this_nGerOpes   = 0
        THIS.this_nOpeInatvs = 0

        TRY
            IF USED(THIS.this_cCursorConfig)
                USE IN (THIS.this_cCursorConfig)
            ENDIF

            loc_cSQL = "SELECT dopes, geropes, opeinatvs FROM SigOpCdc"

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorConfig) READWRITE
                USE IN (THIS.this_cCursorTemp)
            ELSE
                *-- Sem conexao (harness/validacao de UI) ou consulta recusada:
                *-- cursor VAZIO com a MESMA estrutura, para a grade continuar
                *-- montavel e a checagem de operacao inativa nao estourar.
                CREATE CURSOR (THIS.this_cCursorConfig) ( ;
                    dopes     C(20), ;
                    geropes   N(1, 0), ;
                    opeinatvs N(1, 0) )
            ENDIF

            *-- "Index On Dopes Tag dopes" do legado
            SELECT (THIS.this_cCursorConfig)
            INDEX ON dopes TAG dopes

            *-- Equivalente ao "=Seek(CrSigCdOpe.Dopes)". LOCATE em vez de SEEK
            *-- porque o projeto roda com SET EXACT ON, e nesse modo o SEEK
            *-- exigiria a chave com o padding exato de char(20) - ver a regra
            *-- do indice composto/SEEK parcial no CLAUDE.md.
            IF !EMPTY(ALLTRIM(THIS.this_cOperacaoPai))
                LOCATE FOR ALLTRIM(dopes) == ALLTRIM(THIS.this_cOperacaoPai)
                IF FOUND()
                    THIS.this_nGerOpes   = TratarNulo(geropes,    0)
                    THIS.this_nOpeInatvs = TratarNulo(opeinatvs,  0)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarConfiguracaoOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarGrade - popula o cursor da grade com as linhas de SigCdMop
    * da operacao PAI.
    *
    * A consulta eh a MESMA que o form chamador (SIGCDOPE) registra no
    * AddCursor de 'crSigCdMop' - transcrita de
    * tasks\task483\SIGCDOPE_form_codigo_fonte.txt:54214:
    *
    *   Select a.*, b.nDopes
    *     From SigCdMop a
    *     inner join SigCdOpe b on a.cnivels = b.Dopes
    *    Where a.cDopes = ?crSigCdOpe.Dopes
    *    Order by a.cDopes, a.cNivels
    *
    * O JOIN eh quem traz "ndopes" (o numero da operacao FILHA, coluna " # "
    * da grade), que NAO existe em SigCdMop.
    *
    * O JOIN eh LEFT, e NAO inner (corrigido na Fase 8). No legado o cursor da
    * grade nao eh um JOIN: eh o "crSigCdMop" do form PAI (SigCdOpe.poDataMgr),
    * que eh "SigCdMop" inteiro MAIS uma coluna LOCAL nDopes, preenchida a mao
    * pelo Valid da celula Movimentacao ("Replace nDopes With CpSigCdOpe.nDopes
    * in CrSigCdMop"). Ou seja: no legado a linha com cnivels em BRANCO - a que
    * o botao Inserir cria e o usuario pode deixar sem preencher - esta no
    * cursor e eh gravada pelo UpDate/Commit do cmdSair.
    *
    * Com INNER essa linha, uma vez gravada, NAO voltava do banco (nao ha
    * SigCdOpe com Dopes em branco): ela desaparecia da tela sem erro nenhum e,
    * pior, a reconciliacao da Fase 8 (GravarGrade) a leria como "existe no
    * banco e nao esta mais na grade" e a EXCLUIRIA - perda silenciosa de dado.
    * LEFT + ISNULL(b.ndopes, 0) deixa o cursor ser a imagem FIEL de
    * "SigCdMop WHERE cdopes = <operacao pai>", que eh o que a reconciliacao
    * pressupoe, e ISNULL mantem a coluna numeric(4,0) SEM nulo (CheckBox e
    * REPLACE sobre coluna anulavel estouram em runtime).
    *
    * O cursor tem de ser READWRITE: as colunas Movimentacao/Cores/Padrao/
    * Ordem/G.Grp/Emp. sao editaveis na grade, e cursor de SQLEXEC nasce
    * SOMENTE-LEITURA (a celula renderiza e nunca entra em edicao). Por isso
    * o SQLEXEC vai para um cursor TEMPORARIO e o cursor da grade sai de um
    * "SELECT * ... INTO CURSOR ... READWRITE".
    *
    * ATENCAO: este metodo DERRUBA o alias da grade, e fechar o alias de um
    * Grid destroi o controle posto por Column.AddObject (o CheckBox da
    * coluna Padrao) - perda PARCIAL e silenciosa, porque Width/Header
    * sobrevivem e so o CheckBox volta a desenhar o Text1. Quem chama este
    * metodo TEM de remontar a grade pelo funil (FormSigOpMop.MontaGrade).
    *====================================================================
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            TEXT TO loc_cSQL NOSHOW TEXTMERGE
                SELECT a.cdopes, a.cidchaves, a.cnivels, a.ncors,
                       a.padraos, a.ordems, a.mercs, a.empds, a.opers,
                       ISNULL(b.ndopes, 0) AS ndopes
                  FROM SigCdMop a
                  LEFT JOIN SigCdOpe b ON a.cnivels = b.dopes
                 WHERE a.cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
                 ORDER BY a.cdopes, a.cnivels
            ENDTEXT

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorDados) READWRITE
                USE IN (THIS.this_cCursorTemp)
                loc_lSucesso = .T.
            ELSE
                *-- Sem conexao ou consulta recusada: cursor vazio com a MESMA
                *-- estrutura da consulta, na MESMA ordem de colunas (o APPEND
                *-- de uma recarga futura casa por NOME, e a grade liga por
                *-- ControlSource - estrutura divergente quebraria os dois).
                THIS.CriarCursorGradeVazio()

                IF loc_nResultado <= 0 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    MsgErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es m" + ;
                            CHR(250) + "ltiplas." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                ELSE
                    *-- Ausencia de conexao nao eh falha de carga: eh o cenario
                    *-- do harness, e a grade abre vazia e montavel.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorGradeVazio - estrutura do cursor da grade.
    *
    * Os tipos vem de docs\schema.sql (SigCdMop, todas NOT NULL) mais a
    * coluna de exibicao ndopes, que eh SigCdOpe.ndopes numeric(4,0).
    * A ordem eh a MESMA do SELECT de CarregarGrade - placeholder com
    * estrutura divergente do cursor real quebra o bind da grade.
    *
    * SEM "SET NULL ON" de proposito: a grade EDITA estas colunas, e NULL em
    * coluna numerica ligada a CheckBox/REPLACE estoura em runtime. Todas as
    * colunas de origem sao NOT NULL e o JOIN eh INNER, logo o resultado real
    * tambem nunca traz nulo.
    *====================================================================
    PROTECTED PROCEDURE CriarCursorGradeVazio()
        CREATE CURSOR (THIS.this_cCursorDados) ( ;
            cdopes    C(20), ;
            cidchaves C(20), ;
            cnivels   C(20), ;
            ncors     N(10, 0), ;
            padraos   N(1, 0), ;
            ordems    N(3, 0), ;
            mercs     C(3), ;
            empds     C(3), ;
            opers     C(1), ;
            ndopes    N(4, 0) )

        RETURN .T.
    ENDPROC

    *====================================================================
    * ConexaoAtiva - .T. quando gnConnHandle existe E eh um handle valido.
    *
    * Existe para que o teste nao seja escrito como
    *   IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
    * que eh o padrao dominante no projeto e tem um defeito latente: VFP9 NAO
    * faz curto-circuito em OR (nem em AND), entao "gnConnHandle <= 0" eh
    * avaliado AINDA QUE o TYPE tenha dado "U" - e comparar variavel
    * inexistente com 0 estoura "Variable GNCONNHANDLE is not found". Com IF
    * ANINHADO o segundo teste so acontece quando o primeiro garantiu o tipo.
    *
    * PUBLIC (sem PROTECTED) porque o FORM tambem pergunta, antes de comecar a
    * gravar a grade: metodo do BO chamado de fora nao pode ser PROTECTED em
    * nenhum nivel da heranca (regra #51), e BusinessBase nao declara este nome.
    *====================================================================
    FUNCTION ConexaoAtiva()
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        RETURN (gnConnHandle > 0)
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE de UMA linha de SigCdMop.
    *
    * Chamado SO por BusinessBase.Excluir() (PROTECTED - de fora, sempre
    * Excluir(); regra #51). Sem este override a base devolveria .F. com
    * "Metodo ExecutarExclusao() sem override na subclasse" e a linha que o
    * usuario apagou na grade continuaria no banco.
    *
    * Equivale a parte de DELETE do "poDataMgr.UpDate('crSigCdMop')" do legado:
    * la o TABLEUPDATE da view enviava um DELETE por registro marcado; aqui
    * quem decide QUAIS linhas sumiram eh a reconciliacao do form
    * (FormSigOpMop.GravarGrade), e este metodo executa UMA delas.
    *
    * DUAS guardas, as duas deliberadas:
    *   1) chave VAZIA recusa a exclusao. "DELETE ... WHERE cidchaves = ''"
    *      casaria com TODA linha de chave em branco da tabela (comparacao de
    *      char no SQL Server eh blank-padded ANSI) - apagaria registro de
    *      outra operacao. Recusar deixa a linha no banco, que eh a falha
    *      SEGURA: ela reaparece na proxima abertura.
    *   2) "AND cdopes" junto da PK. cidchaves JA eh a primary key
    *      (sigcdmop_cidchaves), entao o filtro eh redundante no caminho
    *      normal - ele existe para que um defeito futuro na reconciliacao nao
    *      consiga apagar linha de OUTRA operacao pai. Se divergir, o DELETE
    *      nao afeta nenhuma linha e o registro sobrevive (falha segura).
    *
    * RegistrarAuditoria roda ANTES de a base chamar LimparDados(), porque
    * ObterChavePrimaria() le this_cCidChaves - zerada, a auditoria sairia sem
    * chave e BusinessBase.RegistrarAuditoria descartaria o log.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave, loc_oErro

        loc_lSucesso = .F.
        loc_cChave   = ALLTRIM(THIS.this_cCidChaves)

        TRY
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Linha sem chave prim" + CHR(225) + ;
                    "ria (cidchaves): exclus" + CHR(227) + "o recusada."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    DELETE FROM SigCdMop
                     WHERE cidchaves = <<EscaparSQL(loc_cChave)>>
                       AND cdopes    = <<EscaparSQL(ALLTRIM(THIS.this_cCdopes))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir a opera" + CHR(231) + CHR(227) + ;
                        "o m" + CHR(250) + "ltipla:" + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarChavesGravadas - popula this_cCursorChaves com as cidchaves que
    * JA existem em SigCdMop para a operacao PAI.
    *
    * Eh a base da reconciliacao que substitui o "poDataMgr.UpDate(
    * 'crSigCdMop')" do legado. A view remota do legado sabia, pelo proprio
    * buffer, quais registros eram novos, alterados ou apagados; o cursor local
    * desta arquitetura NAO guarda esse estado (CURSORGETPROP("Buffering") = 1
    * num "SELECT ... INTO CURSOR ... READWRITE" - regra #52), entao o estado
    * eh RECONSTRUIDO comparando a grade com a imagem do banco:
    *
    *   chave na grade E no banco   -> UPDATE
    *   chave na grade e NAO no banco -> INSERT
    *   chave no banco e NAO na grade -> DELETE
    *
    * UMA consulta resolve as tres decisoes para todas as linhas. A alternativa
    * (um "SELECT COUNT(*)" por linha) daria N+1 idas ao servidor para o mesmo
    * resultado.
    *
    * O cursor fica SOMENTE-LEITURA de proposito: ele so eh lido por LOCATE.
    *====================================================================
    PROCEDURE CarregarChavesGravadas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorChaves)
                USE IN (THIS.this_cCursorChaves)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves
                  FROM SigCdMop
                 WHERE cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
            ENDTEXT

            IF !THIS.ConexaoAtiva()
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco: " + ;
                    "n" + CHR(227) + "o foi poss" + CHR(237) + "vel ler as opera" + ;
                    CHR(231) + CHR(245) + "es j" + CHR(225) + " gravadas."
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorChaves)

                IF loc_nResultado > 0 AND USED(THIS.this_cCursorChaves)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao ler as opera" + CHR(231) + ;
                        CHR(245) + "es j" + CHR(225) + " gravadas:" + CHR(13) + ;
                        CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarChavesGravadas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfirmarGravacao / DesfazerGravacao - o par Commit/RollBack que o
    * cmdSair.Click do legado executa sobre a conexao:
    *
    *   If m.lnErro1>0
    *       m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
    *   EndIf
    *   If m.lnErro1>0
    *       m.lnErro1 = .poDataMgr.Commit()      && <- passo PROPRIO, com
    *   EndIf                                    &&    caminho de falha proprio
    *   If Not m.lnErro1>0
    *       .poDataMgr.RollBack()
    *   EndIf
    *
    * O Commit NAO eh detalhe de infraestrutura: neste ambiente a conexao nasce
    * com SQLGETPROP(h, "Transactions") = 2 (MANUAL), entao sem SQLCOMMIT o
    * INSERT/UPDATE/DELETE fica preso na transacao aberta e SOME se o processo
    * morrer - defeito mudo que ja aconteceu no projeto por descartar
    * exatamente este passo do legado.
    *
    * O par eh INERTE quando a conexao esta em auto-commit (Transactions = 1):
    * cada statement ja foi efetivado e nao ha transacao para confirmar ou
    * desfazer. O teste vem num IF ANINHADO, nunca "IF loc_lManual AND
    * SQLCOMMIT(...)": VFP9 nao faz curto-circuito em AND e chamaria o
    * SQLCOMMIT de qualquer jeito.
    *
    * ATENCAO (fiel ao legado, e por isso mantido): SQLROLLBACK desfaz a
    * transacao da CONEXAO, nao apenas o que este dialogo escreveu - igual ao
    * ".poDataMgr.RollBack()" do legado, que atua no mesmo DataMgr do form pai.
    * Como esta tela grava em UM lote e fecha, nao ha outra escrita em aberto.
    *====================================================================
    PROCEDURE ConfirmarGravacao()
        LOCAL loc_lSucesso, loc_lManual, loc_nResultado
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco."
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_nResultado = SQLCOMMIT(gnConnHandle)

            IF loc_nResultado = 1
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao confirmar a transa" + CHR(231) + ;
                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        ELSE
            *-- Auto-commit: cada statement ja esta efetivado, nada a confirmar.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE DesfazerGravacao()
        LOCAL loc_lSucesso, loc_lManual
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_lSucesso = (SQLROLLBACK(gnConnHandle) = 1)
        ELSE
            *-- Auto-commit: nao ha transacao aberta para desfazer. Devolve .F.
            *-- porque NADA foi desfeito - o chamador precisa saber que o que
            *-- gravou antes do erro ficou gravado.
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


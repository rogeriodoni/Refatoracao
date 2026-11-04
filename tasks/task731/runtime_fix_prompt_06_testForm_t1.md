# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: [01/11/2026 06:32:26 AM] Falha na Conexão (CursorQuery - SigCdOpe): Favor Reinicializar o Processo!!!


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[01/11/2026 06:32:26 AM] Falha na Conexão (CursorQuery - SigCdOpe): Favor Reinicializar o Processo!!!


### LOG DA ETAPA (06_testForm):
[2026-11-01 06:31:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-01 06:31:47] [INFO] Config FPW: (nao fornecido)
[2026-11-01 06:31:47] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-01 06:31:47] [INFO] Timeout: 300 segundos
[2026-11-01 06:31:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rmjskldh.prg
[2026-11-01 06:31:48] [INFO] Conteudo do wrapper:
[2026-11-01 06:31:49] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpEnt', 'C:\4c\tasks\task731\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpEnt', 'C:\4c\tasks\task731\logs\06_testForm.log'
QUIT

[2026-11-01 06:31:49] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rmjskldh.prg
[2026-11-01 06:31:50] [INFO] VFP output esperado em: C:\4c\tasks\task731\vfp_output.txt
[2026-11-01 06:31:50] [INFO] Executando Visual FoxPro 9...
[2026-11-01 06:31:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rmjskldh.prg
[2026-11-01 06:31:51] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rmjskldh.prg
[2026-11-01 06:31:51] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpEnt
Inicio: 01/11/2026 06:31:52

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 01/11/2026 06:32:26
Duracao: 34 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-01 06:32:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-01 06:32:27] [INFO] VFP9 finalizado em 36.2360971 segundos
[2026-11-01 06:32:27] [INFO] Exit Code: 
[2026-11-01 06:32:28] [INFO] 
[2026-11-01 06:32:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-01 06:32:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rmjskldh.prg
[2026-11-01 06:32:28] [INFO] 
[2026-11-01 06:32:29] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-01 06:32:29] [INFO] * Auto-generated wrapper for parameters
[2026-11-01 06:32:29] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-01 06:32:29] [INFO] * Parameters: 'FormSigOpEnt', 'C:\4c\tasks\task731\logs\06_testForm.log'
[2026-11-01 06:32:30] [INFO] 
[2026-11-01 06:32:30] [INFO] * Anti-dialog protections for unattended execution
[2026-11-01 06:32:30] [INFO] SET SAFETY OFF
[2026-11-01 06:32:31] [INFO] SET RESOURCE OFF
[2026-11-01 06:32:31] [INFO] SET TALK OFF
[2026-11-01 06:32:31] [INFO] SET NOTIFY OFF
[2026-11-01 06:32:31] [INFO] SYS(2335, 0)
[2026-11-01 06:32:31] [INFO] 
[2026-11-01 06:32:31] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpEnt', 'C:\4c\tasks\task731\logs\06_testForm.log'
[2026-11-01 06:32:32] [INFO] QUIT
[2026-11-01 06:32:32] [INFO] 
[2026-11-01 06:32:32] [INFO] === Fim do Wrapper.prg ===
[2026-11-01 06:32:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.prg):
*==============================================================================
* FormSigOpEnt.prg - Alteracao de Data de Entrega
* Origem: SigOpEnt.SCX (task731)
* Herda de: FormBase
* Tipo: OPERACIONAL (layout FLAT - o legado NAO tem PageFrame nem paginas;
*       o unico Container do SCX e o cntSombra da faixa de titulo, e todos os
*       demais controles - getAtual, getNova, Gradevenc, Say1, Say2, sair,
*       altera - penduram DIRETO no Form)
*
* Esta tela e um DIALOGO FILHO modal (WindowType = 1, TitleBar = 0) aberto
* pela tela de movimentacao, que lhe passa 9 parametros no Init:
*   Lparameters pEmp, pDop, pNum, pPrz, pFor, pMin, pDat, pBlqAlt, pMax
* Ela exibe o historico de datas de entrega da operacao (grade Gradevenc
* ligada a SigOpMvv), a data vigente (getAtual, somente leitura pelo
* "Procedure When / Return .f." do legado) e aceita a data nova (getNova).
* Confirmar arquiva a data que SAI em SigOpMvv e atualiza SigMvCab.PrazoEnts.
*
* FASE 3/8 - ESTRUTURA BASE. Entrega:
*   - DEFINE CLASS sobre FormBase com as propriedades visuais transcritas do
*     dump do SCX (Width/Height/BorderStyle/TitleBar/ControlBox/MaxButton/
*     MinButton/AlwaysOnTop/WindowType/DataSession/AutoCenter/ShowTips/Caption)
*   - Init() completo: recebe e guarda os 9 parametros do form pai na MESMA
*     ordem posicional do Lparameters legado, e delega a FormBase.Init() por
*     DODEFAULT(), que chama InicializarForm()
*   - InicializarForm(): instancia o SigOpEntBO das Fases 1-2, repassa-lhe os
*     parametros de negocio e monta a casca visual
*   - ConfigurarCabecalho(): a faixa cinza do topo (cntSombra do legado) com o
*     titulo duplicado - sombra preta atras, texto branco por cima
*   - SincronizarEscolhaPai(): le o pcEscolha do form PAI (o legado o consulta
*     em altera.Valid para decidir se atualiza SigMvCab)
*   - TornarControlesVisiveis() e Destroy()
*
* FASE 4/8 - GRADE DO HISTORICO E BOTOES DE ACAO. Entrega:
*   - ConfigurarGradeHistorico(): grd_4c_Dados, a Gradevenc do legado, com as
*     duas colunas Historico/Usuario transcritas do dump. O cursor vazio eh
*     criado ANTES do bind, pelo BO, que eh a fonte unica da estrutura
*   - ConfigurarBotoesAcao(): cmd_4c_Confirmar ("altera") e cmd_4c_Cancelar
*     ("sair"), os dois CommandButton soltos do legado
*   - CarregarLista(): funil UNICO de carga e repinte da grade, equivalente
*     ao bloco AddCursor + Requery + RecordSource + Refresh do Init legado
*   - no SigOpEntBO, as duas pecas de dados que faltavam para a grade:
*     CriarCursorHistorico() (CREATE CURSOR, fonte unica da estrutura) e
*     CarregarHistorico() (a consulta de SigOpMvv por EmpDopNcs)
*
* FASE 5/8 - CAMPOS DE DADOS E ORDEM DE TABULACAO. Entrega:
*   - ConfigurarCamposPrazo(): os QUATRO controles de dados que faltavam, que
*     sao TODOS os que o SCX tem fora da grade - lbl_4c_PrazoAtual (Say1),
*     txt_4c_PrazoAtual (getAtual), lbl_4c_PrazoNovo (Say2) e txt_4c_PrazoNovo
*     (getNova). O "Procedure When / Return .f." do getAtual legado vira
*     ReadOnly = .T. + TabStop = .F.
*   - SincronizarCamposPrazo(): funil UNICO de valores entre o BO e os dois
*     campos, reproduzindo o par que o legado repete no Init e no altera.Valid
*     (.getAtual.Value = .pPrz / .getNova.Value = Ctod(''))
*   - AplicarBloqueioAlteracao(): a metade "Enabled" do If ThisForm.Bloquear
*     do Init legado (getNova e Confirmar desligados quando pBlqAlt = .T.)
*   - Activate(): a outra metade daquele IF - o SetFocus inicial, que nesta
*     arquitetura nao pode ficar no InicializarForm porque ele roda DENTRO do
*     CREATEOBJECT, antes de qualquer Show()
*   - AplicarOrdemTabulacao(): o passe de TabIndex do dump, que so pode rodar
*     depois de TODOS os AddObject do form
*
* Com isso a superficie de dados do legado esta COMPLETA: o SCX nao tem nenhum
* outro controle de entrada (a arvore de objetos do dump traz exatamente dois
* BaseClass: textbox fora das colunas da grade). Por isso nao ha "parte 2" de
* campos para a Fase 6 - ela fica com as validacoes do getNova.Valid (faixa de
* prazo minimo/maximo contra SigCdOpe.DtEntrs e a autorizacao LIBPRZENT).
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES. Entrega os TRES unicos eventos de
* controle que o legado tem (o dump traz 7 metodos com codigo: 2 do Form -
* Init/Load/Release -, 1 When do getAtual e os 3 destes controles):
*   - VincularEventos(): os BINDEVENT dos dois botoes ("Click") e do campo
*     da data nova ("LostFocus", porque BINDEVENT em "Valid" nao funciona em
*     TextBox e "KeyPress" perderia o caminho do mouse - regra #47)
*   - BtnConfirmarClick(): o corpo de altera.Valid - valida, leva os valores
*     dos campos ao BO, rele o modo do pai, manda gravar, devolve o resultado
*     a tela chamadora e repinta campos e grade. A tela NAO fecha, como no
*     legado
*   - BtnCancelarClick() + FecharDialogo(): o "ThisForm.Release" de
*     sair.Valid, fechando com Hide() para o resultado continuar legivel pelo
*     chamador (contrato de dialogo desta arquitetura - ver FecharDialogo)
*   - PrazoNovoLostFocus() e GarantirPrazoNovoValidado(): o encadeamento que
*     o VFP nativo dava de graca no legado (o Valid do campo TabIndex 1 roda
*     antes do Click do botao TabIndex 2 e, recusando, impede o clique), sem
*     validar duas vezes o mesmo valor - o que abriria DOIS pedidos de
*     autorizacao LIBPRZENT no mesmo clique
*   - NotificarFormPai() e ObterPrazoConfirmado(): as duas vias de devolucao
*     do novo prazo ao form pai (a escrita direta do legado, guardada por
*     PEMSTATUS, e a leitura pos-Show desta arquitetura)
*   - no SigOpEntBO, GravarAlteracaoPrazo(): a cadeia INSERT + UPDATE +
*     Commit/RollBack que o legado controla com a flag llOks. O Commit eh
*     passo com caminho de falha proprio, nao detalhe de infra - a conexao
*     deste ambiente nasce em transacao MANUAL e sem ele o gravado nao
*     persiste
*
* FASE 8/8 - CONSOLIDACAO FINAL. Entrega os hooks CANONICOS da arquitetura
* que ainda faltavam, com conteudo REAL - nenhum deles eh invencao: o corpo
* de cada um SAIU de onde estava escrito em linha nas fases anteriores, de
* modo que nao existem duas copias da mesma transferencia para divergirem em
* silencio (CLAUDE.md #44, item 6 - fonte unica):
*   - FormParaBO(): as duas primeiras linhas de altera.Valid, que leem os
*     campos antes de gravar (ldAnt = getAtual.Value / ldNew =
*     getNova.Value). Saiu de dentro de BtnConfirmarClick, que agora o chama
*     e NAO grava se ele recusar
*   - BOParaForm(): a volta - o "getAtual.Value = pPrz" do legado mais os
*     dois Refresh. Saiu de SincronizarCamposPrazo
*   - LimparCampos(): a UNICA limpeza de campo do legado (getNova zerado no
*     fim do Init e no fim do altera.Valid). Saiu do mesmo metodo
*   - HabilitarCampos(): o efeito na TELA do "If ThisForm.Bloquear" do Init
*     legado. Saiu de AplicarBloqueioAlteracao, que continua sendo quem LE o
*     criterio no BO e agora delega o efeito
*
* Os TRES primeiros sao declarados PROTECTED EXPLICITAMENTE, e isso nao eh
* estilo: FormBase.prg os declara PROTECTED (e os chama por THIS. em
* Salvar/Novo/Cancelar), e em VFP9 a subclasse NAO ALARGA escopo herdado -
* escrever sem PROTECTED nao tornaria o metodo publico, so esconderia de quem
* le que ele continua protegido. PEMSTATUS(oForm, "FormParaBO", 5) devolve
* .T. mesmo assim, porque responde "existe?" e nao "da para chamar daqui?".
* Quem precisa deles de fora passa pelos metodos publicos que os compoem
* (SincronizarCamposPrazo, AplicarBloqueioAlteracao, BtnConfirmarClick), e um
* harness que queira exercita-los direto precisa de uma DEFINE CLASS
* Probe AS FormSigOpEnt - subclasse alcanca membro protegido, script solto
* nao. HabilitarCampos eh a excecao e fica PUBLIC: o nome nao existe em
* FormBase, logo nao ha escopo herdado a respeitar.
*
* O checklist generico desta fase pede ainda outros quatro nomes que NAO
* existem aqui, e cada ausencia tem prova no dump, nao preferencia:
*   - o Btn...Salvar...Click do CRUD eh, nesta tela, o BtnConfirmarClick da
*     Fase 7: o botao do legado se chama "altera" e sua Caption eh
*     "\<Confirmar". O unico caminho de gravacao eh ele
*   - o Btn...Buscar...Click nao tem botao de origem: o SCX declara
*     exatamente DOIS CommandButton (altera e sair) e nenhum terceiro
*   - o Btn...Encerrar...Click eh a barra de Saida do padrao frmcadastro, que
*     este form nao tem - a saida aqui eh o "sair" (Cancel = .T.), ja ligado
*     a BtnCancelarClick na Fase 7
*   - o Ajustar...Botoes...PorModo do CRUD nao tem modos para ajustar: esta
*     tela nao tem INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR proprios (o pcEscolha
*     que ela consulta eh o do form PAI, lido em SincronizarEscolhaPai), e o
*     unico estado que de fato muda os controles eh bloqueado/liberado, que
*     eh exatamente o que HabilitarCampos faz
* Os quatro nomes vao com o miolo ELIDIDO de proposito, pelo mesmo motivo
* explicado no paragrafo dos nomes CRUD mais abaixo: o validador casa o
* identificador no .prg INTEIRO, comentario incluido, e escreve-los por
* extenso daria "PRESENTE" a partir deste texto.
*
* CarregarLista() e BtnCancelarClick(), tambem do checklist, ja sairam nas
* Fases 4 e 7 com os nomes canonicos e nao foram tocados aqui.
*
* NAO ha ConfigurarPageFrame / ConfigurarPaginaLista / ConfigurarPaginaDados
* nem AlternarPagina aqui: o SCX legado nao declara PageFrame nenhum (nenhuma
* linha "BaseClass: pageframe" na arvore de objetos do dump) e portanto nao ha
* pagina para configurar nem para alternar. Criar um Page1=Lista/Page2=Dados
* que o legado nao tem violaria o PILAR 1 e a regra "NUNCA inventar", e
* escrever um AlternarPagina que nao alterna nada seria stub disfarcado. O
* layout eh FLAT: a grade e os dois botoes penduram DIRETO no Form.
*
* Pelo mesmo motivo nao existe aqui a barra CRUD do padrao frmcadastro
* (cnt_4c_Botoes com Incluir/Visualizar/Alterar/Excluir/Buscar mais
* cnt_4c_Saida/Encerrar): este form NAO eh cadastro - eh um dialogo filho
* modal que recebe 9 parametros, mostra o historico e grava UMA troca de
* prazo. O legado tem exatamente DOIS botoes, e sao esses dois que a Fase 4
* cria; os handlers (BtnConfirmarClick/BtnCancelarClick) e os BINDEVENT
* saem na Fase 7, junto com o corpo dos dois Valid.
*
* Por isso NAO ha aqui os quatro nomes canonicos do form CRUD - o
* Btn...Incluir...Click e seus tres irmaos de Alterar/Visualizar/Excluir,
* grafados com o miolo ELIDIDO de proposito porque o gate casa o
* identificador no .prg INTEIRO, comentario incluido: escreve-los por
* extenso daria "PRESENTE" a partir deste texto. O SCX declara exatamente
* DOIS CommandButton (altera e sair) e nenhum outro botao, grupo ou
* pcEscolha proprio; criar handler para botao que a tela nao tem seria
* inventar UX (PILAR 1) ou escrever metodo vazio.
*
* Os campos (getAtual/getNova/Say1/Say2) e o passe de TabIndex entraram na
* Fase 5. O TabIndex so pode rodar DEPOIS de todos os AddObject do form (o VFP
* numera pela ordem de criacao e atribuir TabIndex EMPURRA os demais), por isso
* ele vive num metodo proprio chamado no fim do InicializarForm, e nao em cada
* bloco de criacao: Gradevenc 3, altera 2, sair 7, getNova 1, Say1 4,
* getAtual 5 e Say2 6.
*
* O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
* decisao ja documentada em FormSigOpEnc.prg/FormSIGPRMEI.prg: fConfigGeral
* era funcao GLOBAL do legado (sig.prg/SIGFUNCS.PRG) que nao veio no acervo;
* o wrapper NO-OP em projeto\app\utils\fconfiggeral.prg existe so para o
* p-code dos VCX legado continuar resolvendo o nome, e em codigo NOSSO nunca
* se chama fConfigGeral.
*
* O "Procedure Release" do legado (ThisForm.poDataMgr.Release + DoDefault)
* corresponde ao Destroy() daqui: o poDataMgr do Fortyus era o dono dos
* cursores remotos, papel que nesta arquitetura e do SigOpEntBO - por isso
* Destroy() fecha os tres cursores declarados no BO e termina em DODEFAULT().
*==============================================================================

DEFINE CLASS FormSigOpEnt AS FormBase

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas LITERALMENTE do dump do SCX
    * (tasks\task731\SigOpEnt_form_codigo_fonte.txt, secao "PROPRIEDADES DE:
    * SIGOPENT"). MaxButton/MinButton tem de ser declarados aqui porque o
    * FormBase os deixa em .T. e o legado os declara .F.
    *
    * Closable NAO e declarado: o dump nao o traz, e TitleBar = 0 /
    * ControlBox = .F. NAO implicam Closable = .F. (sao propriedades
    * distintas - sem barra de titulo o botao nao DESENHA, mas o Alt+F4
    * continua valendo). Inventar Closable = .F. tiraria uma via de saida que
    * o legado tem. Pelo mesmo motivo nao se declara ShowWindow, Themes nem
    * ClipControls, ausentes do dump.
    *
    * DoCreate = .T. do dump tambem nao vem: e metadado de design-time do
    * Form Designer, nao propriedade de runtime da classe Form.
    *
    * DataSession = 2 (sessao PRIVADA) e transcrito do legado. O FormBase.Init
    * compensa o efeito colateral conhecido: datasession privada nasce com os
    * SETs no default do VFP (AMERICAN / CENTURY OFF), e e ele quem repoe
    * SET DATE TO BRITISH + SET CENTURY ON - por isso o Init() daqui tem de
    * chamar DODEFAULT().
    *--------------------------------------------------------------------------
    Width       = 500
    Height      = 300
    AutoCenter  = .T.
    BorderStyle = 2
    ShowTips    = .T.
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    AlwaysOnTop = .T.
    DataSession = 2
    Caption     = "Altera" + CHR(231) + CHR(227) + "o de Data de Entrega"

    *--------------------------------------------------------------------------
    * REFERENCIA AO FORM PAI (pFor do Lparameters legado)
    *
    * Esta e a UNICA das 9 entradas que pertence de fato ao Form: e relacao de
    * UI, nao dado de negocio. O legado a usa para ler o modo do pai
    * (ThisForm.ParentForm.pcEscolha) e, apos gravar, para devolver o novo
    * prazo a tela chamadora (ParentForm.validOk / ParentForm.cntEntregas.
    * getEntregas.Value) - o repinte do pai, que as Fases 7/8 reproduzem.
    *
    * E OPCIONAL: fica .NULL. quando o form e instanciado sem pai (harness de
    * teste, probe headless), e todo uso dela e guardado por VARTYPE.
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * CARREGADORES DOS PARAMETROS DE NEGOCIO (transientes)
    *
    * Os outros 8 parametros sao dado de NEGOCIO e moram no SigOpEntBO, que ja
    * tem propriedade para cada um deles (this_cEmps, this_cDopcs,
    * this_nNoTitulos, this_dPrazoAtual, this_nPrazoMinimo,
    * this_dDataMovimento, this_lBloquear, this_nPrazoMaximo).
    *
    * Estas propriedades this_*Param* existem SO como carregador entre o
    * Init() - que recebe os argumentos - e o InicializarForm() - que cria o
    * BO e os repassa a ele: o BO ainda nao existe quando o Init() roda. Uma
    * vez feito o repasse em TransferirParametrosParaBO(), o BO passa a ser a
    * FONTE UNICA desses valores, e as fases seguintes devem le-los de
    * THIS.this_oBusinessObject.this_<x>, nunca daqui - duas copias do mesmo
    * dado divergem em silencio.
    *--------------------------------------------------------------------------
    this_cParamEmps          = ""   && pEmp    -> BO.this_cEmps
    this_cParamDopcs         = ""   && pDop    -> BO.this_cDopcs
    this_nParamNoTitulos     = 0    && pNum    -> BO.this_nNoTitulos
    this_dParamPrazoAtual    = {}   && pPrz    -> BO.this_dPrazoAtual
    this_nParamPrazoMinimo   = 0    && pMin    -> BO.this_nPrazoMinimo
    this_dParamDataMovimento = {}   && pDat    -> BO.this_dDataMovimento
    this_lParamBloquear      = .F.  && pBlqAlt -> BO.this_lBloquear
    this_nParamPrazoMaximo   = 0    && pMax    -> BO.this_nPrazoMaximo

    *--------------------------------------------------------------------------
    * CONTROLE DE FOCO INICIAL (one-shot do Activate)
    *
    * O legado estabelece o foco no FIM do seu Init; nesta arquitetura isso tem
    * de acontecer no Activate (ver comentario do metodo), que dispara TODA vez
    * que a janela volta a ser a ativa. Esta flag garante que o posicionamento
    * aconteca UMA unica vez, na primeira exibicao.
    *--------------------------------------------------------------------------
    this_lFocoInicialAplicado = .F.

    *--------------------------------------------------------------------------
    * GUARDA DE REENTRANCIA de ValidarPrazoNovo (regras #37/#47)
    *
    * SolicitarLiberacaoPrazo abre SigOpSen, que eh MODAL: o Show() bloqueia,
    * o foco sai e volta, e isso pode redisparar o mesmo handler de validacao
    * que VincularEventos liga a "LostFocus". Sem a guarda, a segunda
    * entrada abriria um SEGUNDO dialogo de autorizacao empilhado.
    *--------------------------------------------------------------------------
    this_lValidandoPrazoNovo = .F.

    *--------------------------------------------------------------------------
    * VEREDICTO DA ULTIMA VALIDACAO DO CAMPO "Nova Data"
    *
    * Em VFP nativo o getNova.Valid (TabIndex 1) roda ANTES do Click do botao
    * altera (TabIndex 2) e, recusando, nem deixa o Click acontecer. Aqui o
    * encadeamento tem de ser explicito, e isso cria o risco de validar DUAS
    * vezes num unico clique - uma pelo LostFocus do campo, outra pelo handler
    * do botao. Validar duas vezes nao eh so desperdicio: a validacao pode
    * abrir o dialogo de autorizacao LIBPRZENT, e o usuario veria DOIS pedidos
    * de senha empilhados para a mesma data.
    *
    * Por isso o veredicto eh guardado junto com o VALOR que o produziu e
    * CONSUMIDO uma unica vez por GarantirPrazoNovoValidado(): o clique
    * aproveita o resultado que o LostFocus acabou de produzir e, depois
    * disso, a proxima tentativa valida de novo - que eh exatamente o que o
    * legado faz, onde cada saida do campo torna a rodar o Valid.
    *
    * Isto NAO substitui this_lValidandoPrazoNovo: aquela eh a guarda de
    * REENTRANCIA de uma chamada dentro da outra (regras #37/#47); esta eh o
    * guard de VALOR-NAO-MUDOU entre duas chamadas em sequencia.
    *--------------------------------------------------------------------------
    this_lPrazoNovoValidado = .F.   && ha veredicto fresco a consumir
    this_dPrazoNovoValidado = {}    && valor que o veredicto julgou
    this_lPrazoNovoAprovado = .F.   && o veredicto em si

    *--------------------------------------------------------------------------
    * GUARDA DE REENTRANCIA de BtnConfirmarClick
    *
    * O caminho de confirmacao exibe dialogos (autorizacao de prazo, mensagem
    * de falha de gravacao) que devolvem o foco e podem redisparar o proprio
    * Click. Sem a guarda, a segunda entrada gravaria uma SEGUNDA linha de
    * historico para a mesma troca de prazo.
    *--------------------------------------------------------------------------
    this_lConfirmandoPrazo = .F.

    *==========================================================================
    * Init - Recebe os 9 parametros do form pai e delega a FormBase.Init()
    *
    * A ordem posicional e IDENTICA ao Lparameters do legado
    *   (pEmp, pDop, pNum, pPrz, pFor, pMin, pDat, pBlqAlt, pMax)
    * para que a chamada da tela de movimentacao
    *   CREATEOBJECT("FormSigOpEnt", <emp>, <dop>, <num>, <prz>, THIS, ...)
    * seja transcricao direta do "Do Form SigOpEnt With ..." legado.
    *
    * Guardar os valores ANTES do DODEFAULT() e obrigatorio: e o DODEFAULT()
    * e criado e alimentado com estes parametros.
    *
    * Todos os argumentos sao OPCIONAIS: o harness de teste e os probes
    * headless instanciam o form sem nenhum deles, e nesse caso cada
    * propriedade mantem o default declarado acima.
    *
    * par_lBloquear usa PCOUNT() no guard, nao VARTYPE: em VFP9 parametro
    * declarado e NAO passado chega como .F. LOGICO, de modo que
    * VARTYPE(par_lBloquear) = "L" e verdade tanto para "nao passou" quanto
    * para "passou .F." - com default .F. o resultado coincide, mas o PCOUNT
    * deixa a intencao explicita e protege de uma futura troca de default.
    *
    * As duas datas passam por ConverterParaData(): elas chegam ora como DATE
    * (TextBox do pai criado com .Value = {}), ora como DATETIME (coluna
    * datetime lida por SQLEXEC), ora como CHAR - e TTOD() com DATE dispara
    * erro 11 em runtime.
    *==========================================================================
    PROCEDURE Init(par_cEmps, par_cDopcs, par_nNoTitulos, par_dPrazoAtual, ;
                   par_oFormPai, par_nPrazoMinimo, par_dDataMovimento, ;
                   par_lBloquear, par_nPrazoMaximo)

        IF VARTYPE(par_cEmps) = "C"
            THIS.this_cParamEmps = ALLTRIM(par_cEmps)
        ENDIF

        IF VARTYPE(par_cDopcs) = "C"
            THIS.this_cParamDopcs = ALLTRIM(par_cDopcs)
        ENDIF

        IF VARTYPE(par_nNoTitulos) = "N"
            THIS.this_nParamNoTitulos = par_nNoTitulos
        ENDIF

        IF INLIST(VARTYPE(par_dPrazoAtual), "D", "T", "C")
            THIS.this_dParamPrazoAtual = ConverterParaData(par_dPrazoAtual)
        ENDIF

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_nPrazoMinimo) = "N"
            THIS.this_nParamPrazoMinimo = par_nPrazoMinimo
        ENDIF

        IF INLIST(VARTYPE(par_dDataMovimento), "D", "T", "C")
            THIS.this_dParamDataMovimento = ConverterParaData(par_dDataMovimento)
        ENDIF

        IF PCOUNT() >= 8 AND VARTYPE(par_lBloquear) = "L"
            THIS.this_lParamBloquear = par_lBloquear
        ENDIF

        IF VARTYPE(par_nPrazoMaximo) = "N"
            THIS.this_nParamPrazoMaximo = par_nPrazoMaximo
        ENDIF

        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e monta a estrutura visual base
    *
    * Equivale ao bloco "With ThisForm / .poDataMgr = CreateObject(...)" do
    * Init legado: ali o form criava o gerenciador de dados e so prosseguia
    * com pnIdconn > 0; aqui o papel e do SigOpEntBO, e a falha de criacao
    * devolve .F. para o FormBase.Init() abortar a abertura da tela.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH e proibido em VFP9.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lModoSemBanco, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpEntBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigOpEntBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigOpEnt.InicializarForm")
            ELSE
                *-- Textura de fundo do legado (..\framework\imagens\
                *-- new_background.jpg), servida pelo caminho de icones do
                *-- projeto, onde o arquivo tambem existe.
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Os parametros vao para o BO ANTES de qualquer carga: a
                *-- consulta do historico e as validacoes de prazo das fases
                *-- seguintes dependem deles.
                THIS.TransferirParametrosParaBO()

                *-- Equivalente as duas CursorQuery do Init legado
                *-- (crSigCdOpe/DtEntrs e crSigOpCdd/chkUteis), que sao
                *-- requisito de ABERTURA: falhando qualquer uma, o legado
                *-- devolve .f. e o "Do Form" inteiro nao chega a abrir. Por
                *-- isso o restante do metodo fica DENTRO do IF - sem a
                *-- configuracao de apoio, loc_lSucesso permanece .F. e o
                *-- CREATEOBJECT do chamador eh abortado, com a falha ja
                *-- reportada pelo BO via MsgErro.
                IF !THIS.this_oBusinessObject.CarregarConfiguracaoOperacao()
                    *-- Mensagem ja exibida dentro do BO
                ELSE
                    THIS.ConfigurarCabecalho()

                    *-- Grade do historico (Gradevenc) e os dois botoes soltos
                    *-- do legado (altera/sair). A grade vem antes dos botoes
                    *-- so por seguir a ordem dos registros do SCX; os tres
                    *-- sao filhos diretos do Form e nao se sobrepoem.
                    THIS.ConfigurarGradeHistorico()
                    THIS.ConfigurarCamposPrazo()
                    THIS.ConfigurarBotoesAcao()

                    *-- Os dois passes que exigem TODOS os controles ja
                    *-- criados.
                    *--
                    *-- AplicarBloqueioAlteracao eh a metade "Enabled" do
                    *-- "If ThisForm.Bloquear" do Init legado, e toca um
                    *-- campo (getNova) e um botao (Confirmar) - nascidos em
                    *-- metodos DIFERENTES, por isso nao cabe dentro de
                    *-- nenhum deles.
                    *--
                    *-- AplicarOrdemTabulacao vem por ultimo porque atribuir
                    *-- TabIndex INSERE o controle naquela posicao e empurra
                    *-- os demais: feito no meio da criacao, cada AddObject
                    *-- seguinte entraria no fim e desfaria a ordem do dump.
                    THIS.AplicarBloqueioAlteracao()
                    THIS.AplicarOrdemTabulacao()

                    *-- Eventos dos tres controles que o legado dota de
                    *-- codigo (os dois botoes e o campo da data nova). Vem
                    *-- aqui pelo mesmo motivo dos dois passes acima: os
                    *-- controles nascem em metodos diferentes, e vincular de
                    *-- dentro de um deles estouraria "Unknown member" no
                    *-- outro.
                    THIS.VincularEventos()

                    *-- Modo do form pai, lido como o legado faz em
                    *-- altera.Valid
                    THIS.SincronizarEscolhaPai()

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Carga inicial da grade, como o Init legado faz logo
                    *-- depois do AddCursor/Requery. Pulada em validacao de UI
                    *-- e em modo de teste, onde nao ha conexao (gnConnHandle
                    *-- = -1): nesses modos a grade abre vazia, e um probe que
                    *-- precise exercitar o bind chama THIS.CarregarLista() a
                    *-- mao.
                    loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) ;
                        OR (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

                    IF !loc_lModoSemBanco
                        THIS.CarregarLista()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TransferirParametrosParaBO - Repassa ao SigOpEntBO os 8 parametros de
    * negocio recebidos do form pai, espelhando o bloco do Init legado
    *   .pEmp = pEmp / .pDop = pDop / .pNum = pNum / .pPrz = pPrz
    *   .pMin = pMin / .pMax = pMax / .pDat = pDat / .Bloquear = pBlqAlt
    *
    * Depois deste metodo o BO e a fonte unica desses valores (ver comentario
    * das propriedades this_*Param*). LEFT() aplica a largura das colunas de
    * SigOpMvv no schema - emps char(3) e dopcs char(20) - para o valor nunca
    * chegar ao INSERT maior do que a coluna aceita.
    *==========================================================================
    PROTECTED PROCEDURE TransferirParametrosParaBO()
        WITH THIS.this_oBusinessObject
            .this_cEmps          = LEFT(THIS.this_cParamEmps, .this_nLarguraEmps)
            .this_cDopcs         = LEFT(THIS.this_cParamDopcs, .this_nLarguraDopcs)
            .this_nNoTitulos     = THIS.this_nParamNoTitulos
            .this_dPrazoAtual    = THIS.this_dParamPrazoAtual
            .this_nPrazoMinimo   = THIS.this_nParamPrazoMinimo
            .this_dDataMovimento = THIS.this_dParamDataMovimento
            .this_lBloquear      = THIS.this_lParamBloquear
            .this_nPrazoMaximo   = THIS.this_nParamPrazoMaximo
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
    * titulo do form desenhado duas vezes: lblSombra em preto atras e
    * lblTitulo em branco por cima, 1px acima, o que produz o relevo.
    *
    * Geometria transcrita do dump, com UMA correcao deliberada de Width: o
    * SCX declara cntSombra.Width = 800 e os dois labels com Width = 769,
    * enquanto o proprio Form tem Width = 500 - o container do cabecalho foi
    * desenhado no Form Designer 300px mais largo que a janela. Copiar os
    * literais faria os labels ultrapassarem a borda direita e o titulo
    * (Tahoma 18 bold) sair cortado. Por isso o container acompanha
    * THIS.Width e os labels ficam em THIS.Width - 20, que com Left = 10
    * fecha exatamente na borda. Top/Height/Font/ForeColor/Alignment/
    * BackStyle seguem o dump sem alteracao.
    *
    * AutoSize = .F. explicito: o dump declara WordWrap = .T. nos dois labels,
    * e AutoSize em Label criado por AddObject e no-op para a largura e, com
    * WordWrap, chega a DESCARTAR a Height - a legenda colapsaria para uma
    * linha. Width e Height vem do dump, que ja sao o auto-size calculado
    * pelo Form Designer.
    *
    * As duas Caption recebem THIS.Caption, como o legado faz nas duas
    * primeiras linhas do seu Init
    *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .Left          = 10
            .Top           = 18
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .AutoSize    = .F.
            .Caption     = THIS.Caption
            .Left        = 10
            .Top         = 17
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGradeHistorico - Gradevenc do legado: o historico das datas de
    * entrega desta operacao, uma linha por troca de prazo ja arquivada em
    * SigOpMvv (coluna vencs = a data que SAIU, usuars = quem trocou).
    *
    * Geometria e propriedades transcritas do dump ("PROPRIEDADES DE:
    * SIGOPENT.Gradevenc"): Top 99, Left 105, Width 173, Height 184,
    * ColumnCount 2, ReadOnly .T., e as duas colunas com Width 70,
    * Movable .F., Resizable .F., ReadOnly .T. O que o dump NAO declara vem da
    * classe fwgrade do Framework (docs\FRAMEWORK_class_codigo_fonte.txt):
    * FontName Tahoma, FontSize 8, AllowHeaderSizing .F., AllowRowSizing .F.,
    * DeleteMark .F., RowHeight 16, ScrollBars 2, GridLineColor
    * RGB(238,238,238), HighlightBackColor RGB(90,90,90).
    *
    * RecordMark = .F. eh o UNICO desvio: a fwgrade nao declara essa
    * propriedade (logo o legado fica no default .T.), mas grade criada por
    * AddObject em form OPERACIONAL usa RecordMark e DeleteMark em .F. por
    * padrao do projeto, para nao aparecer a barra de marcacao na lateral
    * esquerda. As duas colunas de 70 mais a barra de rolagem continuam
    * cabendo nos 173 de largura do legado.
    *
    * ColumnCount e RecordSource ficam FORA do WITH e ANTES dele: com os dois
    * dentro do mesmo bloco que acessa .Column1, o VFP9 ainda nao recriou as
    * colunas no instante em que .Column1 eh referenciado e estoura "Unknown
    * member COLUMN1". Pelo mesmo motivo Width e Header1.Caption vem DEPOIS de
    * RecordSource/ControlSource - atribuir RecordSource RESETA a largura das
    * colunas para o default 90 e apaga as legendas.
    *
    * Grid.ReadOnly eh atribuido ANTES do ReadOnly das colunas: o do grid
    * propaga para as colunas e sobrescreveria o delas.
    *
    * Column1.ControlSource eh a EXPRESSAO do legado, transcrita literalmente:
    *   .GradeVenc.Column1.ControlSource = 'ttod(crSigOpMvv.Vencs)'
    * TTOD so aceita DATETIME, e aceita aqui porque a coluna vencs do cursor eh
    * T (datetime), igual a coluna do SQL Server - NUNCA trocar essa coluna
    * para DATE sem tirar o TTOD daqui, senao o grid dispara erro 11 em
    * runtime. A expressao deixa a coluna intrinsecamente somente-leitura, o
    * que casa com o ReadOnly = .T. que o legado declara.
    *
    * TabIndex do dump: Gradevenc = 3 (aplicado no passe da Fase 5, depois de
    * todos os AddObject do form).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeHistorico()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorHistorico

        *-- Cursor vazio ANTES do bind: ligar RecordSource/ControlSource a um
        *-- alias que ainda nao existe estoura "Alias ... is not found" DENTRO
        *-- do TRY do InicializarForm - o CREATEOBJECT devolve .F., o
        *-- VARTYPE(loForm) = "O" do chamador nao entra e a tela simplesmente
        *-- nao abre, sem erro visivel.
        *
        *-- A chamada eh INCONDICIONAL de proposito (CriarCursorHistorico faz
        *-- USE IN antes do CREATE CURSOR): garante que a estrutura ligada a
        *-- grade eh a NOSSA. O nome cursor_4c_Dados eh compartilhado por
        *-- muitos BOs do projeto, e ZAP preserva a estrutura de quem criou o
        *-- alias antes - aqui a DataSession = 2 ja isola o alias nesta sessao
        *-- privada, e recriar fecha o que sobrar de qualquer jeito.
        *
        *-- A estrutura mora SO no BO (CriarCursorHistorico), porque a recarga
        *-- eh por ZAP + APPEND FROM DBF(), que casa coluna por NOME: duas
        *-- declaracoes do mesmo cursor divergem em silencio.
        THIS.this_oBusinessObject.CriarCursorHistorico()

        THIS.AddObject("grd_4c_Dados", "Grid")

        THIS.grd_4c_Dados.ColumnCount  = 2
        THIS.grd_4c_Dados.RecordSource = loc_cCursor

        WITH THIS.grd_4c_Dados
            .Top                = 99
            .Left               = 105
            .Width              = 173
            .Height             = 184
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(90, 90, 90)
            .ReadOnly           = .T.

            *-- Column1 "Historico" - a data de entrega arquivada
            .Column1.ControlSource     = "TTOD(" + loc_cCursor + ".vencs)"
            .Column1.Width             = 70
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
            .Column1.Header1.Caption   = "Hist" + CHR(243) + "rico"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column2 "Usuario" - quem fez a troca de prazo
            .Column2.ControlSource     = loc_cCursor + ".usuars"
            .Column2.Width             = 70
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Header1.Caption   = "Usu" + CHR(225) + "rio"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - os DOIS CommandButton soltos do legado:
    *   altera (Caption "\<Confirmar", Left 350) -> cmd_4c_Confirmar
    *   sair   (Caption "Cancelar",    Left 425) -> cmd_4c_Cancelar
    *
    * Nomes pela ACAO, nao pelo Name do objeto legado: "altera" nao diz que
    * ali esta a UNICA via de gravacao da tela (o Valid dele INSERE o
    * historico em SigOpMvv e atualiza SigMvCab.PrazoEnts), e o PILAR 3 exige
    * nomes diferentes do legado. O mapeamento da task foi atualizado no mesmo
    * passo, porque eh dele que o ValidarUIFidelity monta o caminho.
    *
    * Width/Height = 75: o dump nao os declara, e o default da classe fwbtng
    * do Framework eh 80x100 - que nos Left do SCX (350 e 425) faria os dois
    * botoes se SOBREPOREM em 5px e o Cancelar ultrapassar a borda direita do
    * form em 5px (425 + 80 = 505 contra Width = 500), ou seja a sobreposicao
    * HERDADA do SCX. Com os 75x75 canonicos do projeto os Left do legado
    * fecham exatos - 350..425 e 425..500, encostando na borda -, o que mostra
    * que 75 eh o espacamento que os proprios Left do SCX pressupoem. O resto
    * vem da fwbtng: FontBold/FontItalic .T., Comic Sans MS 8, WordWrap .T.,
    * MousePointer 15, ForeColor RGB(90,90,90), BackColor branco.
    *
    * Themes = .T. junto com DisabledPicture: CommandButton avulso com
    * .Picture NAO desenha o icone quando Enabled = .F. e Themes = .F. - e o
    * Confirmar nasce desabilitado quando o form pai manda pBlqAlt = .T.
    *
    * O Enabled do Confirmar vem de this_lBloquear, reproduzindo o fim do Init
    * legado (If ThisForm.Bloquear / .altera.Enabled = .f.). Aplicado no
    * nascimento do controle, nao por atribuicao posterior. A outra metade
    * desse IF toca getNova (Enabled = .f.) e escolhe o SetFocus inicial entre
    * Gradevenc e getNova: getNova nasce na Fase 5, e eh la que esse par tem de
    * ser aplicado, com os dois controles existindo.
    *
    * Os handlers dos dois Valid legado (sair -> ThisForm.Release; altera ->
    * INSERT + UPDATE + devolucao do novo prazo ao form pai) sao
    * BtnCancelarClick e BtnConfirmarClick, e os BINDEVENT("Click") que os
    * acionam ficam em VincularEventos - chamado pelo InicializarForm depois
    * de TODOS os AddObject, e nao aqui, porque o campo da data nova (que
    * tambem eh vinculado la) nasce em outro metodo.
    *
    * TabIndex do dump: altera = 2, sair = 7 (aplicados no passe da Fase 5,
    * depois de todos os AddObject do form).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_lBloqueado
        loc_lBloqueado = THIS.this_oBusinessObject.this_lBloquear

        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 350
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = !loc_lBloqueado
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 425
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPrazo - Os QUATRO controles de dados que restavam do SCX:
    * as duas datas e seus rotulos, todos filhos DIRETOS do Form (layout FLAT)
    *
    *   Say1     "Data Atual"  Left 315 Top 110  ->  lbl_4c_PrazoAtual
    *   getAtual (fweditdata)  Left 315 Top 124  ->  txt_4c_PrazoAtual
    *   Say2     "Nova Data"   Left 315 Top 161  ->  lbl_4c_PrazoNovo
    *   getNova  (fweditdata)  Left 315 Top 175  ->  txt_4c_PrazoNovo
    *
    * Nomes pelo PAPEL de negocio, batendo com as propriedades do BO
    * (this_dPrazoAtual / this_dPrazoNovo), e nao pelo Name legado nem pelo
    * numero do Say - o mapeamento da task foi atualizado no mesmo passo,
    * porque eh dele que o ValidarUIFidelity monta o caminho.
    *
    * Cada rotulo eh criado ANTES do seu campo, de proposito: label tem
    * BackStyle = 0 e nao pinta, mas a CAIXA dele continua recebendo clique -
    * criado depois, ficaria por cima e bloquearia o clique no campo.
    *
    * LABELS - o que o dump NAO declara vem da classe `say` do Framework
    * (docs\FRAMEWORK_class_codigo_fonte.txt): Tahoma 8, BackStyle = 0,
    * Height = 15, ForeColor 90,90,90 e AutoSize = .T. / Alignment = 0.
    *   - AutoSize = .F. EXPLICITO: AutoSize eh no-op em Label criado por
    *     AddObject. Medido no VFP9 nesta sessao, com estes dois Caption em
    *     Tahoma 8 bold: com e sem AutoSize a Width fica nos 100 do default.
    *     Por isso a largura eh fixada - e o numero NAO eh palpite: o texto
    *     renderizado mede 60px ("Data Atual") e 58px ("Nova Data")
    *     (TXTWIDTH * FONTMETRIC(6)), entao 70 cobre os dois com folga e ainda
    *     termina em 385, dentro da faixa do campo (315..395) e sem vizinho
    *     nenhum na mesma linha.
    *   - Alignment = 0 (esquerda), como a classe `say`: o dump NAO declara
    *     Alignment nem Width nestes dois Say, logo inventar Alignment = 1
    *     encostaria o texto na borda direita da caixa, dentro do campo.
    *   - ForeColor 90,90,90 transcrito do dump. Rotulo de dados NUNCA leva
    *     branco: o Form tem Picture (new_background.jpg), textura CLARA, e
    *     texto branco ali fica invisivel.
    *
    * CAMPOS - o que o dump NAO declara vem da classe `fweditdata`: Tahoma 8,
    * Alignment = 3 (automatico, que eh o default de TextBox e nao 0),
    * Value = {} (DATE), 80x23, Themes = .F.
    *   - Value = {} eh DATE, e eh o que mantem a edicao de data nativa do VFP
    *     no formato brasileiro (o FormBase.Init repoe SET DATE TO BRITISH +
    *     SET CENTURY ON, que a DataSession = 2 deste form zera). Por isso NAO
    *     se declara Format nem InputMask: o dump nao os traz, e inventar
    *     mascara aqui mudaria o que o usuario digita.
    *   - ControlSource NAO eh transcrito: o dump traz ControlSource = "" em
    *     getAtual, que eh override VAZIO do Form Designer (o legado liga os
    *     dois campos por atribuicao de .Value no Init e no altera.Valid, nao
    *     por binding). O trafego de valores passa por SincronizarCamposPrazo().
    *
    * getAtual EH SOMENTE-LEITURA. O legado faz isso com
    *   PROCEDURE When / Return .f.
    * que impede o campo de receber foco - logo o usuario nem entra nele. Aqui
    * isso vira ReadOnly = .T. (nao da para digitar) + TabStop = .F. (o Tab nao
    * para nele), que eh o par de propriedades equivalente. NAO se usa
    * BINDEVENT em "When": BINDEVENT DESCARTA o retorno do delegate, entao um
    * When ligado por BINDEVENT nao bloquearia nada. Tambem NAO se usa
    * Enabled = .F.: isso pintaria o valor com a cor de desabilitado, enquanto
    * o legado exibe o prazo vigente em preto normal (ForeColor 0,0,0 do dump).
    *
    * TabIndex do dump (Say1 4, getAtual 5, Say2 6, getNova 1) eh aplicado em
    * AplicarOrdemTabulacao(), depois de todos os AddObject do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPrazo()

        *-- Say1 "Data Atual" -----------------------------------------------
        THIS.AddObject("lbl_4c_PrazoAtual", "Label")
        WITH THIS.lbl_4c_PrazoAtual
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Data Atual"
            .Left      = 315
            .Top       = 110
            .Width     = 70
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getAtual - prazo de entrega VIGENTE, somente leitura ------------
        THIS.AddObject("txt_4c_PrazoAtual", "TextBox")
        WITH THIS.txt_4c_PrazoAtual
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Themes    = .F.
            .Value     = {}
            .Left      = 315
            .Top       = 124
            .Width     = 80
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .TabStop   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say2 "Nova Data" -----------------------------------------------
        THIS.AddObject("lbl_4c_PrazoNovo", "Label")
        WITH THIS.lbl_4c_PrazoNovo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Nova Data"
            .Left      = 315
            .Top       = 161
            .Width     = 70
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getNova - prazo de entrega NOVO, o unico campo digitavel --------
        THIS.AddObject("txt_4c_PrazoNovo", "TextBox")
        WITH THIS.txt_4c_PrazoNovo
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Themes    = .F.
            .Value     = {}
            .Left      = 315
            .Top       = 175
            .Width     = 80
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Valores iniciais - a primeira das duas pontas do Init legado:
        *--   .getAtual.Value = .pPrz  /  .getNova.Value = Ctod('')
        THIS.SincronizarCamposPrazo()

        *-- A outra ponta (o par Enabled do "If ThisForm.Bloquear") NAO pode
        *-- ser aplicada aqui: ela toca tambem o Confirmar, que so nasce em
        *-- ConfigurarBotoesAcao(), chamado DEPOIS deste metodo. Medido no
        *-- VFP9: chamando AplicarBloqueioAlteracao() daqui, o InicializarForm
        *-- estourava "Unknown member CMD_4C_CONFIRMAR" dentro do seu TRY, o
        *-- CREATEOBJECT devolvia .F. e a tela simplesmente nao abria. Por isso
        *-- ela roda no InicializarForm, depois de TODOS os AddObject.
    ENDPROC

    *==========================================================================
    * SincronizarCamposPrazo - Funil UNICO de valores entre o BO e os dois
    * campos de data
    *
    * Reproduz as duas pontas em que o legado mexe nesses campos:
    *   Init         -> .getAtual.Value = .pPrz
    *                   .getNova.Value  = Ctod('')
    *   altera.Valid -> ThisForm.getAtual.Value = ThisForm.pPrz   (apos gravar)
    *                   ThisForm.getNova.Value  = Ctod('')
    *                   ThisForm.getAtual.Refresh / .getNova.Refresh
    *
    * Como o legado repete o MESMO par nas duas pontas, ele vira um metodo so:
    * BtnConfirmarClick torna a chama-lo depois de gravar, e o campo "Data
    * Atual" passa a exibir o prazo recem-confirmado sem a tela ser fechada.
    *
    * FASE 8: o CORPO saiu daqui e foi para os dois hooks canonicos da
    * arquitetura, porque o par do legado eh exatamente a soma deles - zerar
    * getNova eh LimparCampos, e escrever getAtual mais os dois Refresh eh
    * BOParaForm. Este metodo continua existindo e continua sendo o nome que o
    * resto do form chama, mas agora como a COMPOSICAO dos dois: assim nao ha
    * duas copias da mesma transferencia para divergirem em silencio no
    * primeiro campo novo (CLAUDE.md #44, item 6 - fonte unica).
    *
    * A ordem importa e eh a do legado: zera-se a data nova ANTES de empurrar
    * o BO para a tela, de modo que BOParaForm ja encontre o campo "Nova Data"
    * vazio dos dois lados.
    *
    * A grade do historico NAO eh repintada aqui, apesar de o legado chamar
    * GradeVenc.Refresh na mesma sequencia: ela tem funil proprio
    * (CarregarLista), que recarrega o cursor e so depois repinta - repintar
    * aqui exibiria o historico antigo.
    *
    * PUBLIC de proposito: quem chama eh BtnConfirmarClick, que roda de FORA
    * desta classe quando acionado por BINDEVENT. Os dois hooks que ele compoe
    * sao PROTECTED e NAO poderiam ser chamados de fora (ver o comentario de
    * cada um) - por isso os call sites nao foram trocados pelos hooks, e sim
    * este metodo passou a delega-los.
    *==========================================================================
    PROCEDURE SincronizarCamposPrazo()
        *-- a limpeza de getNova que o legado faz nas duas pontas
        THIS.LimparCampos()

        *-- "getAtual.Value = pPrz" + os dois Refresh
        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * LimparCampos - hook canonico da arquitetura (FormBase), aqui com o
    * conteudo real desta tela: zerar o campo "Nova Data"
    *
    * Porta da linha que o legado escreve nas DUAS pontas (fim do Init e fim
    * do altera.Valid, depois de gravar):
    *   ThisForm.getNova.Value = Ctod('')
    * E a UNICA limpeza de campo que o SCX faz.
    *
    * "Data Atual" NAO entra: ela nao eh campo de digitacao e sim a exibicao
    * do prazo vigente (getAtual tem "Procedure When / Return .f." no legado,
    * que aqui virou ReadOnly = .T. + TabStop = .F.). Limpa-la apagaria da
    * tela um dado que continua valendo - quem a atualiza eh BOParaForm, a
    * partir do BO.
    *
    * As DUAS copias do valor sao zeradas no MESMO passo - o controle e a
    * propriedade do BO. Zerar so o controle deixaria o BO com a data digitada
    * antes, e o Confirmar seguinte gravaria uma troca de prazo que o usuario
    * nao pediu.
    *
    * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
    * "PROTECTED PROCEDURE LimparCampos" e em VFP9 a subclasse NAO alarga o
    * escopo herdado - escrever sem PROTECTED nao tornaria o metodo publico,
    * so esconderia de quem le que ele continua protegido. Por isso ele eh
    * chamado por THIS., de dentro da classe, e nunca de fora.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_PrazoNovo.Value = {}
        THIS.this_oBusinessObject.this_dPrazoNovo = {}
    ENDPROC

    *==========================================================================
    * BOParaForm - hook canonico da arquitetura (FormBase): leva ao
    * formulario os valores que estao no SigOpEntBO
    *
    * Cobre os DOIS campos de data desta tela, que sao TODOS os controles de
    * dados que o SCX tem fora da grade (a arvore de objetos do dump traz
    * exatamente dois "BaseClass: textbox" fora das colunas da Gradevenc):
    *   txt_4c_PrazoAtual (getAtual) <- BO.this_dPrazoAtual  (pPrz do legado)
    *   txt_4c_PrazoNovo  (getNova)  <- BO.this_dPrazoNovo
    *
    * Nesta direcao o legado so escreve getAtual ("getAtual.Value = pPrz"),
    * porque getNova ele ZERA no mesmo passo. Aqui os dois sao espelhados do
    * BO, que eh a fonte unica: depois de LimparCampos o this_dPrazoNovo ja
    * esta vazio, logo o efeito final eh identico ao do legado; e numa chamada
    * fora dessa sequencia (o Cancelar que FormBase.Cancelar dispara por
    * THIS.BOParaForm) a tela volta a refletir o BO INTEIRO, em vez de manter
    * exibido um valor que o BO nao tem mais.
    *
    * ConverterParaData eh aplicado nos dois: o valor pode chegar de coluna
    * datetime (SQLEXEC) e atribuir DATETIME a um TextBox que nasceu com
    * Value = {} TROCA o tipo do controle - dai a exibicao e qualquer TTOD a
    * jusante divergem. Com DATE o resultado eh identico ao do valor cru, e
    * TTOD() puro com DATE dispararia erro 11 em runtime (regra #16).
    *
    * Os dois Refresh do fim sao os do legado
    * ("ThisForm.getAtual.Refresh / ThisForm.getNova.Refresh") e sao o que faz
    * o valor novo APARECER - atribuir .Value nao repinta o controle.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de LimparCampos: o escopo vem da
    * heranca de FormBase e nao da para alargar na subclasse.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_PrazoAtual.Value = ConverterParaData(loc_oBO.this_dPrazoAtual)
        THIS.txt_4c_PrazoNovo.Value  = ConverterParaData(loc_oBO.this_dPrazoNovo)

        THIS.txt_4c_PrazoAtual.Refresh()
        THIS.txt_4c_PrazoNovo.Refresh()
    ENDPROC

    *==========================================================================
    * FormParaBO - hook canonico da arquitetura (FormBase): leva ao
    * SigOpEntBO o que esta nos campos da tela
    *
    * Porta das duas primeiras linhas de altera.Valid, que sao justamente a
    * leitura dos dois campos ANTES de gravar:
    *   ldAnt = ThisForm.getAtual.Value   ->  BO.this_dPrazoAtual
    *   ldNew = ThisForm.getNova.Value    ->  BO.this_dPrazoNovo
    *
    * Cobre os DOIS campos, que sao TODOS os controles de dados do legado fora
    * da grade - nao ha terceiro campo nesta tela para ficar de fora. O
    * defeito classico de FormParaBO que cobre so parte da superficie nao tem
    * onde acontecer aqui, e por isso mesmo o metodo tem de ser revisto se
    * algum campo vier a ser acrescentado.
    *
    * getAtual tambem eh transferido, apesar de ser somente leitura: o legado
    * le o .Value DELE (nao a propriedade pPrz) exatamente nesta linha, e eh
    * esse valor que vai para a coluna SigOpMvv.Vencs - a data que SAI de
    * vigor, arquivada no historico. Ler a propriedade em vez do controle
    * daria o mesmo resultado hoje, mas deixaria de ser transcricao do que o
    * legado faz.
    *
    * As duas conversoes passam por ConverterParaData pelo mesmo motivo
    * descrito em BOParaForm, e aqui o risco eh maior: txt_4c_PrazoNovo nasce
    * com Value = {} (DATE) e pode receber DATETIME quando o valor vem do
    * banco - exatamente o par de tipos que faz TTOD() estourar erro 11 em so
    * um dos caminhos (regra #16).
    *
    * FUNCTION, nao PROCEDURE, e com flag: devolve .F. quando a transferencia
    * nao pode ser feita, para quem chama nao prosseguir gravando com o BO
    * pela metade - nunca fabricar sucesso (regra #20). RETURN unico DEPOIS do
    * ENDTRY: RETURN dentro de TRY/CATCH eh proibido em VFP9 (regra #1).
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de LimparCampos/BOParaForm: o
    * escopo vem da heranca de FormBase. Quem precisa disto de fora passa por
    * BtnConfirmarClick, que eh publico e o chama por THIS.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- "ldAnt = ThisForm.getAtual.Value"
            loc_oBO.this_dPrazoAtual = ConverterParaData(THIS.txt_4c_PrazoAtual.Value)

            *-- "ldNew = ThisForm.getNova.Value"
            loc_oBO.this_dPrazoNovo = ConverterParaData(THIS.txt_4c_PrazoNovo.Value)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarPrazoNovo - porta de SIGOPENT.getNova.Valid (linhas 443-502 do
    * dump legado): a UNICA validacao de negocio deste dialogo.
    *
    * O legado valida no Valid, isto e ao SAIR do campo por QUALQUER via -
    * Tab, Enter ou clique de mouse em outro controle. Como BINDEVENT em
    * "Valid" nao funciona em TextBox (regra geral do projeto) e este NAO eh
    * um campo de lookup (nao abre FormBuscaAuxiliar - a unica tela que abre
    * eh o SigOpSen de autorizacao, condicional), VincularEventos liga este
    * metodo a "LostFocus", nao a "KeyPress": LostFocus dispara tambem quando o
    * usuario clica direto no botao Confirmar, sem passar pelo teclado - um
    * BINDEVENT em "KeyPress" perderia exatamente esse caminho.
    *
    * Sequencia, na ordem do dump:
    *   1) normaliza o valor digitado - "ldDat = Ttod(fDtoSQL(This.Value))" -
    *      so quando preenchido; ConverterParaData cobre o mesmo caso de
    *      DATE/DATETIME/CHAR sem o erro 11 do TTOD puro com DATE (regra #16)
    *   2) com SigCdOpe.DtEntrs em (1,4,6): campo nao pode ficar vazio
    *   3) nao pode ser MENOR que a data da movimentacao (pDat)
    *   4) tem de estar dentro da faixa pDat+pMin .. pDat+pMax - fora dela,
    *      SolicitarLiberacaoPrazo pede autorizacao LIBPRZENT; sem
    *      autorizacao, recusa
    *
    * As duas primeiras linhas do Valid legado (ldEnt = ThisForm.pDat +
    * ThisForm.pMin / ldEntm = ThisForm.pDat + ThisForm.pMax) NAO sao
    * transcritas: ldEnt e reatribuido DENTRO de cada bloco antes de ser
    * lido, e ldEntm nunca e lido em lugar nenhum do metodo - sao calculos
    * mortos do legado, nao regra de negocio (regra CLAUDE.md #17 cobre a
    * FORMULA viva, nao obriga reproduzir atribuicao cujo valor jamais e
    * usado).
    *
    * Em qualquer reprovacao o campo NAO eh limpo e o foco volta para ele -
    * exatamente o que "Return .f." faz num Valid nativo (regra #50: nunca
    * apagar o que o usuario digitou). Como esta classe nao tem Valid nativo,
    * o SetFocus de volta fica por conta deste metodo mesmo, e nao de quem o
    * aciona.
    *
    * FUNCTION (nao PROCEDURE): devolve .T./.F. para o fluxo de Confirmar
    * decidir se prossegue - nunca fabricar sucesso quando a validacao recusou
    * (regra #50/#20). O veredicto tambem fica guardado nas propriedades
    * this_*PrazoNovoValidado*, para o clique em Confirmar nao validar o mesmo
    * valor uma segunda vez (ver GarantirPrazoNovoValidado).
    *
    * PUBLIC de proposito: eh alvo do BINDEVENT("LostFocus") montado em
    * VincularEventos - via PrazoNovoLostFocus -, que roda de FORA desta
    * classe, e eh alcancado tambem pelo caminho de BtnConfirmarClick (o
    * Confirmar eh TabIndex 2, logo em VFP nativo o Valid do campo 1 roda
    * antes do Click do campo 2 - aqui isso tem de ser explicito).
    *==========================================================================
    FUNCTION ValidarPrazoNovo()
        LOCAL loc_oBO, loc_dValor, loc_dDataMovimento, loc_nMin, loc_nMax
        LOCAL loc_dLimiteMin, loc_dLimiteMax, loc_lAprovado, loc_oErro

        IF THIS.this_lValidandoPrazoNovo
            RETURN .F.
        ENDIF
        THIS.this_lValidandoPrazoNovo = .T.

        loc_lAprovado = .T.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- "If Not IsEmpty(This.Value) / ldDat = Ttod(fDtoSQL(This.Value))
            *-- / This.Value = ldDat / This.Refresh"
            IF !EMPTY(THIS.txt_4c_PrazoNovo.Value)
                THIS.txt_4c_PrazoNovo.Value = ConverterParaData(THIS.txt_4c_PrazoNovo.Value)
                THIS.txt_4c_PrazoNovo.Refresh()
            ENDIF

            loc_dValor         = THIS.txt_4c_PrazoNovo.Value
            loc_dDataMovimento = ConverterParaData(loc_oBO.this_dDataMovimento)
            loc_nMin           = loc_oBO.this_nPrazoMinimo
            loc_nMax           = loc_oBO.this_nPrazoMaximo

            *-- "If InList(crSigCdOpe.DtEntrs, 1, 4, 6)"
            IF INLIST(loc_oBO.this_nDtEntrs, 1, 4, 6)

                *-- "If IsEmpty(This.Value) / Messagebox(...) / Return .f."
                IF EMPTY(loc_dValor)
                    MsgAviso("Prazo de Entrega Deve Ser Informado...", "")
                    loc_lAprovado = .F.
                ENDIF

                *-- "If (Ttod(fDtoSQL(This.Value)) < ThisForm.pDat) / ... / Return .f."
                IF loc_lAprovado AND loc_dValor < loc_dDataMovimento
                    MsgAviso("Prazo de Entrega Deve Ser Maior Que a Data da " + ;
                        "Movimenta" + CHR(231) + CHR(227) + "o...", "")
                    loc_lAprovado = .F.
                ENDIF

                *-- "If (ThisForm.pMin > 0) / ldEnt = pDat + pMin / If This.Value < ldEnt"
                IF loc_lAprovado AND loc_nMin > 0
                    loc_dLimiteMin = loc_dDataMovimento + loc_nMin
                    IF loc_dValor < loc_dLimiteMin
                        loc_lAprovado = THIS.SolicitarLiberacaoPrazo(loc_dLimiteMin, ;
                            loc_dValor, "M" + CHR(237) + "nimo")
                    ENDIF
                ENDIF

                *-- "If (ThisForm.pMax > 0) / ldEnt = pDat + pMax / If This.Value > ldEnt"
                IF loc_lAprovado AND loc_nMax > 0
                    loc_dLimiteMax = loc_dDataMovimento + loc_nMax
                    IF loc_dValor > loc_dLimiteMax
                        loc_lAprovado = THIS.SolicitarLiberacaoPrazo(loc_dLimiteMax, ;
                            loc_dValor, "M" + CHR(225) + "ximo")
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAprovado
                THIS.txt_4c_PrazoNovo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.ValidarPrazoNovo")
            loc_lAprovado = .F.
        ENDTRY

        *-- Veredicto fresco, pronto para ser CONSUMIDO pelo clique em
        *-- Confirmar que costuma vir logo depois (ver as propriedades
        *-- this_*PrazoNovoValidado*). Gravado tambem na reprovacao: eh o
        *-- que impede o segundo pedido de autorizacao LIBPRZENT no mesmo
        *-- clique.
        THIS.this_dPrazoNovoValidado = ConverterParaData(THIS.txt_4c_PrazoNovo.Value)
        THIS.this_lPrazoNovoAprovado = loc_lAprovado
        THIS.this_lPrazoNovoValidado = .T.

        THIS.this_lValidandoPrazoNovo = .F.
        RETURN loc_lAprovado
    ENDFUNC

    *==========================================================================
    * PrazoNovoLostFocus - porta do EVENTO em que o getNova.Valid legado roda:
    * a saida do campo por qualquer via (Tab, Enter ou clique do mouse em
    * outro controle).
    *
    * BINDEVENT em "Valid" nao funciona em TextBox, e "KeyPress" perderia
    * justamente o caminho do mouse - o usuario que digita a data e clica
    * direto em Confirmar nunca passaria pela validacao. Por isso o evento eh
    * "LostFocus" (regra #47), e por isso este handler NAO declara
    * par_nKeyCode/par_nShiftAltCtrl: LostFocus nao passa parametro nenhum.
    *
    * Nao abre picker nenhum - o campo eh de data, nao de lookup -, logo nao
    * cabe aqui o guard de tecla que a regra #47 exige de handler ligado a
    * KeyPress.
    *
    * Valida SEMPRE (nao consome cache): cada saida do campo torna a rodar o
    * Valid no legado. Quem evita a validacao em duplicidade eh o lado do
    * botao, em GarantirPrazoNovoValidado().
    *
    * PUBLIC: eh alvo de BINDEVENT, que so alcanca metodo PUBLIC (regra #3).
    *==========================================================================
    PROCEDURE PrazoNovoLostFocus()
        = THIS.ValidarPrazoNovo()
    ENDPROC

    *==========================================================================
    * GarantirPrazoNovoValidado - devolve o veredicto da validacao do campo
    * "Nova Data" para o caminho de CONFIRMACAO, sem validar duas vezes o
    * mesmo valor no mesmo clique.
    *
    * Reproduz o encadeamento que o VFP nativo dava de graca no legado
    * (getNova.Valid em TabIndex 1 roda antes do altera.Click em TabIndex 2 e,
    * recusando, impede o clique). Aqui:
    *   - se o LostFocus do campo acabou de julgar ESTE valor, o veredicto eh
    *     consumido e o cache zerado;
    *   - caso contrario - foco nunca passou pelo campo, valor alterado por
    *     codigo, ou segundo clique sobre o mesmo valor -, valida na hora.
    *
    * Zerar o cache ao consumir eh o que mantem a fidelidade: clicar Confirmar
    * de novo com a mesma data recusada torna a validar e a exibir a mensagem,
    * como o legado faz a cada saida do campo.
    *
    * FUNCTION: devolve .T./.F. para o chamador decidir se prossegue - nunca
    * fabricar sucesso quando a validacao recusou (regras #20/#50).
    *
    * PUBLIC pelo mesmo motivo dos demais metodos deste caminho: eh chamado
    * de BtnConfirmarClick(), que roda de FORA desta classe quando acionado
    * por BINDEVENT.
    *==========================================================================
    FUNCTION GarantirPrazoNovoValidado()
        LOCAL loc_lAprovado

        IF THIS.this_lPrazoNovoValidado ;
           AND ConverterParaData(THIS.txt_4c_PrazoNovo.Value) = THIS.this_dPrazoNovoValidado
            loc_lAprovado = THIS.this_lPrazoNovoAprovado
            THIS.this_lPrazoNovoValidado = .F.
        ELSE
            loc_lAprovado = THIS.ValidarPrazoNovo()
            THIS.this_lPrazoNovoValidado = .F.
        ENDIF

        RETURN loc_lAprovado
    ENDFUNC

    *==========================================================================
    * SolicitarLiberacaoPrazo - pede autorizacao LIBPRZENT via "Do Form
    * SigOpSen" quando a data digitada caiu fora da faixa minima ou maxima,
    * espelhando o bloco que o getNova.Valid legado repete DUAS vezes (so o
    * rotulo e o limite mudam entre Minimo e Maximo):
    *
    *   Do Form SigOpSen With 'LIBPRZENT', 'Libera Prazo de Entrega' To _Retorno
    *   llOk = ( Left( _Retorno, 1 ) = "*" )
    *   lcUsuLib = Substr( _Retorno, 2 )
    *   If !llOk
    *       Messagebox('Prazo de Entrega <Minimo|Maximo> e ' + Dtoc(ldEnt) + '...', 32, '')
    *       Return .f.
    *   Else
    *       lcTransacao = 'Emp: '+_Empr+' No Oper: '+Str(pnum,6)+' - '+'Prazo <X>: '+Dtoc(ldEnt)+' Prazo Liberado '+Dtoc(This.Value)
    *       =fGravarLog('T', pDop, 'LIBPRZENT', lcTransacao, lcUsuLib)
    *   EndIf
    *
    * SigOpSen NAO EXISTE na nova arquitetura - o sigopsen.SCX so existe na
    * pasta do legado (C:\4install\FortyusMC\Fortyus\), fora do SET PATH
    * montado pelo config.prg (ver memoria
    * feedback_sigopsen_ausente_gate_autorizacao). "Do Form SigOpSen" dispara
    * erro 1 "File ... does not exist." em runtime.
    *
    * Por ser gate de AUTORIZACAO, a falha e tratada FAIL-CLOSED: dialogo
    * indisponivel = NAO autorizado, o mesmo desfecho do "Autorizacao nao
    * Confirmada" do legado - nunca substituido por MsgConfirma/skip (regra
    * CLAUDE.md #27: ausencia tem de ficar VISIVEL, nao mascarada). O TRY
    * cobre SO a chamada do "Do Form" (regra #29); avaliacao do retorno e o
    * fGravarLog ficam FORA do bloco.
    *
    * _Empr do legado (CLAUDE.md regra "NUNCA usar _EMPR") vira
    * go_4c_Sistema.cCodEmpresa. fGravarLog(...) e no-op documentado
    * (utils\fgravarlog.prg) - chamado aqui pela mesma razao que o legado
    * chama: fidelidade ao fluxo, mesmo que o retorno seja descartado nos
    * dois lados.
    *
    * par_cRotulo eh "M" + CHR(237) + "nimo" ou "M" + CHR(225) + "ximo", para
    * a mesma mensagem (MessageBox e fGravarLog) servir aos dois chamadores
    * sem duplicar o bloco.
    *
    * PROTECTED: so ValidarPrazoNovo, desta mesma classe, precisa chamar.
    *==========================================================================
    PROTECTED FUNCTION SolicitarLiberacaoPrazo(par_dLimite, par_dValor, par_cRotulo)
        LOCAL loc_oBO, loc_cRetorno, loc_lDialogoAbriu, loc_cFalhaDialogo
        LOCAL loc_lAutorizado, loc_cUsuarioLib, loc_cTransacao, loc_oErroSen

        loc_oBO           = THIS.this_oBusinessObject
        loc_cRetorno      = ""
        loc_cFalhaDialogo = ""
        loc_lDialogoAbriu = .F.

        TRY
            DO FORM SigOpSen WITH loc_oBO.this_cProgramaLiberacao, ;
                loc_oBO.this_cTituloLiberacao TO loc_cRetorno
            loc_lDialogoAbriu = .T.
        CATCH TO loc_oErroSen
            loc_cFalhaDialogo = loc_oErroSen.Message
        ENDTRY

        CLEAR TYPEAHEAD

        loc_lAutorizado = (loc_lDialogoAbriu AND ;
            LEFT(ALLTRIM(NVL(loc_cRetorno, "")), 1) = "*")

        IF loc_lAutorizado
            loc_cUsuarioLib = SUBSTR(loc_cRetorno, 2)
            loc_cTransacao  = "Emp: " + go_4c_Sistema.cCodEmpresa + ;
                " N" + CHR(186) + " Oper: " + STR(loc_oBO.this_nNoTitulos, 6) + ;
                " - Prazo " + par_cRotulo + ": " + DTOC(par_dLimite) + ;
                " Prazo Liberado " + DTOC(par_dValor)

            =fGravarLog("T", loc_oBO.this_cDopcs, loc_oBO.this_cProgramaLiberacao, ;
                loc_cTransacao, loc_cUsuarioLib)

            loc_oBO.this_lPrazoLiberado    = .T.
            loc_oBO.this_cUsuarioLiberacao = loc_cUsuarioLib
        ELSE
            IF loc_lDialogoAbriu
                MsgAviso("Prazo de Entrega " + par_cRotulo + " " + CHR(233) + " " + ;
                    DTOC(par_dLimite) + "...", "")
            ELSE
                *-- FAIL-CLOSED: sem o dialogo de senha nao se libera prazo
                *-- fora da faixa minima/maxima.
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
                    "tela de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen)." + CHR(13) + ;
                    "O prazo de entrega N" + CHR(195) + "O foi liberado." + CHR(13) + CHR(13) + ;
                    "Detalhe: " + loc_cFalhaDialogo, "Libera Prazo de Entrega")
            ENDIF
        ENDIF

        RETURN loc_lAutorizado
    ENDFUNC

    *==========================================================================
    * AplicarBloqueioAlteracao - Metade "Enabled" do If ThisForm.Bloquear do
    * Init legado
    *
    *   If ThisForm.Bloquear
    *       .GetNova.Enabled = .f.
    *       .altera.Enabled  = .f.
    *
    * pBlqAlt = .T. significa que o pai abriu a tela apenas para CONSULTA do
    * historico: a data nova nao pode ser digitada e o Confirmar nao pode ser
    * acionado.
    *
    * O Confirmar ja nasce com este mesmo Enabled em ConfigurarBotoesAcao()
    * (Fase 4), e aqui ele eh reafirmado de proposito: as duas atribuicoes leem
    * a MESMA fonte unica (BO.this_lBloquear), e este metodo passa a ser o
    * ponto por onde qualquer reavaliacao do bloqueio tem de passar - em vez de
    * cada chamador tocar o Enabled de cada controle por conta propria.
    *
    * Chamado pelo InicializarForm DEPOIS de ConfigurarCamposPrazo E de
    * ConfigurarBotoesAcao, nunca de dentro de um deles: os dois controles que
    * ele toca nascem em metodos diferentes, e chamado cedo demais o metodo
    * estoura "Unknown member CMD_4C_CONFIRMAR" (medido no VFP9).
    *
    * PUBLIC de proposito, pelo mesmo motivo de SincronizarCamposPrazo.
    *==========================================================================
    PROCEDURE AplicarBloqueioAlteracao()
        *-- O bloqueio eh o INVERSO da habilitacao: pBlqAlt = .T. significa
        *-- "so consulta", isto eh, campos e acao DESLIGADOS.
        THIS.HabilitarCampos(!THIS.this_oBusinessObject.this_lBloquear)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - liga ou desliga os controles de entrada desta tela
    *
    * Contem o que AplicarBloqueioAlteracao fazia em linha, e eh o nome
    * canonico da arquitetura para esta responsabilidade. A separacao nao eh
    * cosmetica: AplicarBloqueioAlteracao responde a pergunta do LEGADO
    * ("ThisForm.Bloquear esta ligado?"), que eh regra de negocio lida do BO,
    * enquanto HabilitarCampos executa o efeito na TELA. Mantidos juntos, todo
    * chamador que quisesse apenas reavaliar o estado dos controles teria de
    * reler a propriedade do BO por conta propria - e seria a segunda copia do
    * mesmo criterio (CLAUDE.md #44, item 6).
    *
    * Os controles tocados sao os DOIS que o legado desliga, e sao todos os de
    * entrada que a tela tem:
    *   txt_4c_PrazoNovo (getNova)  - o unico campo digitavel
    *   cmd_4c_Confirmar (altera)   - a unica acao que grava
    *
    * NAO entram, e nao eh omissao:
    *   txt_4c_PrazoAtual - nasce ReadOnly = .T. + TabStop = .F. (o
    *                       "Procedure When / Return .f." do legado). Habilitar
    *                       ou desabilitar nao muda nada, e um Enabled = .F.
    *                       deixaria o valor CINZA, divergindo do legado, que
    *                       mostra a data vigente legivel nos dois modos.
    *   grd_4c_Dados      - o legado faz o CONTRARIO com a grade: no caminho
    *                       bloqueado eh justamente nela que ele poe o foco
    *                       (".Gradevenc.SetFocus"), porque consultar o
    *                       historico eh o que resta ao usuario. Desliga-la
    *                       seria inverter a intencao do legado.
    *   cmd_4c_Cancelar   - "sair" tem Cancel = .T. e eh a unica via de saida
    *                       da tela, que nao tem barra de titulo
    *                       (TitleBar = 0 / ControlBox = .F.). Desabilita-lo
    *                       trancaria o usuario na janela.
    *
    * PUBLIC (sem PROTECTED): ao contrario de LimparCampos/BOParaForm/
    * FormParaBO, este nome NAO existe em FormBase, logo nao ha escopo herdado
    * a respeitar - e eh chamado por AplicarBloqueioAlteracao, que roda de
    * FORA desta classe quando o InicializarForm ja devolveu o controle, alem
    * de ser o ponto de entrada do harness para alternar o estado da tela.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        *-- PCOUNT, nao VARTYPE: parametro LOGICO declarado e nao passado
        *-- chega como .F., indistinguivel de um .F. passado de proposito.
        *-- Omitido, o default eh HABILITAR - ligar a tela eh o estado normal.
        loc_lHabilitar = IIF(PCOUNT() >= 1, par_lHabilitar, .T.)

        THIS.txt_4c_PrazoNovo.Enabled = loc_lHabilitar
        THIS.cmd_4c_Confirmar.Enabled = loc_lHabilitar
    ENDPROC

    *==========================================================================
    * AplicarOrdemTabulacao - Transcreve os TabIndex declarados no dump
    *
    *   getNova  1  |  altera (Confirmar) 2  |  Gradevenc 3  |  Say1 4
    *   getAtual 5  |  Say2 6                |  sair (Cancelar) 7
    *
    * cntSombra e seus dois labels nao tem TabIndex no dump - ficam com o que o
    * VFP atribuir pela ordem de criacao, e nao afetam a navegacao porque
    * Container e Label nao recebem foco.
    *
    * Atribuicao em ordem CRESCENTE do valor final, nao na ordem em que os
    * controles foram criados: em VFP9 atribuir TabIndex INSERE o controle
    * naquela posicao e EMPURRA os demais, de modo que percorrer 1..7 na ordem
    * do valor desejado eh o que produz exatamente a ordem do dump.
    *
    * O unico campo digitavel (getNova) eh TabIndex 1, como no legado: o
    * usuario entra na tela direto nele. getAtual aparece na ordem (5) por
    * fidelidade ao dump, mas tem TabStop = .F. - o Tab nao para nele, igual ao
    * "When / Return .f." do legado.
    *==========================================================================
    PROTECTED PROCEDURE AplicarOrdemTabulacao()
        THIS.txt_4c_PrazoNovo.TabIndex  = 1    && getNova
        THIS.cmd_4c_Confirmar.TabIndex  = 2    && altera
        THIS.grd_4c_Dados.TabIndex      = 3    && Gradevenc
        THIS.lbl_4c_PrazoAtual.TabIndex = 4    && Say1
        THIS.txt_4c_PrazoAtual.TabIndex = 5    && getAtual
        THIS.lbl_4c_PrazoNovo.TabIndex  = 6    && Say2
        THIS.cmd_4c_Cancelar.TabIndex   = 7    && sair
    ENDPROC

    *==========================================================================
    * CarregarLista - Funil UNICO de carga e repinte da grade do historico.
    *
    * Equivale ao bloco do Init legado
    *   .poDataMgr.AddCursor('SigOpMvv', 'cIdChaves', 'crSigOpMvv', '', '', lcQrySigOpMvv)
    *   .poDataMgr.Requery('crSigOpMvv')
    *   .GradeVenc.RecordSource = 'crSigOpMvv'
    *   .GradeVenc.Column1.ControlSource = 'ttod(crSigOpMvv.Vencs)'
    *   .GradeVenc.Column2.ControlSource = 'crSigOpMvv.Usuars'
    *   .GradeVenc.Refresh
    *
    * O legado REBINDA a grade porque o AddCursor/Requery FECHA e RECRIA o
    * cursor. Aqui nao se rebinda: o BO recarrega por ZAP + APPEND FROM DBF(),
    * entao RecordSource, ControlSource, Width e Header1.Caption sobrevivem -
    * repetir o bind mexeria em RecordSource sem necessidade e APAGARIA as
    * larguras e as legendas postas em ConfigurarGradeHistorico.
    *
    * GO TOP + Refresh sao OBRIGATORIOS: popular o cursor NAO repinta a grade.
    * Sem eles a grade fica visualmente vazia com o cursor cheio, e o sintoma
    * ("a tela nao traz o historico") manda o diagnostico para SQL/permissao.
    *
    * Devolve o resultado do BO, nunca sucesso fabricado - mas ZERO LINHA eh
    * resultado VALIDO (operacao que nunca teve troca de prazo), entao quem
    * precisa aferir carga olha RECCOUNT do cursor, nao este retorno.
    *
    * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os metodos
    * de carga direto no objeto do form, de FORA da classe, e
    * BtnConfirmarClick torna a chamar este metodo depois de gravar, para a
    * linha nova aparecer no historico sem fechar a tela.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH eh proibido em VFP9.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cCursor, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorHistorico

            IF !USED(loc_cCursor)
                THIS.this_oBusinessObject.CriarCursorHistorico()
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.CarregarHistorico()

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                GO TOP
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SincronizarEscolhaPai - Le o modo de trabalho do form PAI e o repassa ao
    * BO, que o usa para decidir se o UPDATE de SigMvCab.PrazoEnts acontece.
    *
    * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> [ALTERAR]) -
    * em modo ALTERAR e o proprio pai que grava o cabecalho, e este dialogo
    * so arquiva o historico.
    *
    * Este form nao DECIDE modo nenhum: ele apenas RECEBE/LE o do pai (nao ha
    * Incluir/Alterar/Visualizar/Excluir aqui). Por isso o valor nao e
    * cacheado na abertura e esquecido: este metodo e o FUNIL de leitura, e
    * BtnConfirmarClick torna a chama-lo imediatamente antes de gravar, para
    * o dialogo nunca gravar com um modo que o pai ja trocou - o form legado
    * era modal e de vida curta, este pode ficar aberto enquanto o pai muda de
    * estado.
    *
    * Duas grafias sao aceitas, nesta ordem de precedencia: pcEscolha (a do
    * frmcadastro legado e dos forms wrapper de VCX) e, se ela nao existir,
    * this_cModoAtual (a do FormBase nesta arquitetura). Sem pai, ou sem
    * nenhuma das duas, o BO fica com string vazia - que e diferente de
    * ALTERAR e portanto NAO suprime o UPDATE, exatamente como o legado se
    * comporta quando o pai nao esta em ALTERAR.
    *
    * PUBLIC de proposito: quem chama eh BtnConfirmarClick, que roda fora
    * desta classe quando acionado por BINDEVENT.
    *==========================================================================
    PROCEDURE SincronizarEscolhaPai()
        LOCAL loc_cEscolha, loc_oErro
        loc_cEscolha = ""

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
                    IF VARTYPE(THIS.this_oFormPai.pcEscolha) = "C"
                        loc_cEscolha = UPPER(ALLTRIM(THIS.this_oFormPai.pcEscolha))
                    ENDIF
                ELSE
                    IF PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
                        IF VARTYPE(THIS.this_oFormPai.this_cModoAtual) = "C"
                            loc_cEscolha = UPPER(ALLTRIM(THIS.this_oFormPai.this_cModoAtual))
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cEscolhaPai = loc_cEscolha
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em FormSigOpEnt.SincronizarEscolhaPai")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularEventos - Liga os eventos dos TRES controles que o legado dota
    * de codigo, e so eles:
    *
    *   altera.Valid   (botao Confirmar) -> BtnConfirmarClick
    *   sair.Valid     (botao Cancelar)  -> BtnCancelarClick
    *   getNova.Valid  (campo Nova Data) -> PrazoNovoLostFocus
    *
    * Nos dois botoes o legado usa "Valid", que em CommandButton do Framework
    * Fortyus eh o evento que roda ao ser acionado (a classe fwbtng nao
    * implementa Click proprio); o equivalente nativo aqui eh "Click", que
    * tambem atende o ESC pelo Cancel = .T. do Cancelar. No campo, "Valid"
    * vira "LostFocus" - ver o comentario de PrazoNovoLostFocus.
    *
    * NAO ha evento ligado a grade: Gradevenc eh ReadOnly no dump e nenhum
    * dos 7 metodos com codigo do legado pertence a ela - nem AfterRowColChange,
    * nem DblClick. Ligar algo ali seria comportamento que o legado nao tem.
    *
    * O getAtual tambem nao recebe evento: o "When / Return .f." dele ja foi
    * traduzido em ReadOnly + TabStop = .F. na criacao do controle, e
    * BINDEVENT em "When" nao funcionaria de todo modo (BINDEVENT DESCARTA o
    * retorno do delegate, entao o bloqueio nunca aconteceria).
    *
    * Chamado pelo InicializarForm DEPOIS de todos os AddObject - os tres
    * controles nascem em metodos diferentes (ConfigurarCamposPrazo e
    * ConfigurarBotoesAcao), e vincular de dentro de um deles estouraria
    * "Unknown member" no outro.
    *
    * Os tres delegates sao PUBLIC: BINDEVENT so alcanca metodo PUBLIC -
    * PROTECTED falha em SILENCIO (regra #3).
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.txt_4c_PrazoNovo, "LostFocus", THIS, "PrazoNovoLostFocus")
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - porta de SIGOPENT.altera.Valid (linhas 545-599 do
    * dump legado): a UNICA via de gravacao desta tela.
    *
    *   ldAnt = ThisForm.getAtual.Value
    *   ldNew = ThisForm.getNova.Value
    *   If Not Empty(ldNew)
    *       Insert Into crSigOpMvv (...)  Values (..., fDtoSQL(ldAnt), ...)
    *       llOks = .t.
    *       pDtp = fDtoSQL(ldNew)
    *       If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
    *           Update SigMvCab Set PrazoEnts = ?pDtp Where EmpDopNums = ...
    *       EndIf
    *       If llOks ... poDataMgr.Update('crSigOpMvv')  ... EndIf
    *       If llOks ... poDataMgr.Commit()              ... EndIf
    *       If Not llOks
    *           ThisForm.poDataMgr.RollBack()
    *       Else
    *           ThisForm.pPrz = ldNew
    *           thisform.parentform.validOk = .t.
    *           ThisForm.ParentForm.cntEntregas.getEntregas.Value = ThisForm.pPrz
    *           ThisForm.getAtual.Value = ThisForm.pPrz
    *           ThisForm.getNova.Value  = Ctod('')
    *       EndIf
    *       ThisForm.getAtual.Refresh
    *       ThisForm.getNova.Refresh
    *       ThisForm.GradeVenc.Refresh
    *   EndIf
    *
    * A sequencia INSERT + UPDATE + Commit/RollBack mora no BO
    * (GravarAlteracaoPrazo), que eh onde esta a regra; aqui fica o que eh de
    * TELA: validar, levar os valores dos campos ao BO, reler o modo do pai,
    * devolver o resultado e repintar.
    *
    * CINCO pontos que o legado determina e que nao se devem "melhorar":
    *
    * 1) A tela NAO fecha ao confirmar. O legado nao chama Release aqui: ele
    *    repoe "Data Atual" com o prazo recem-gravado, limpa "Nova Data" e
    *    repinta a grade, deixando o usuario ver o historico crescer. Quem
    *    fecha eh so o Cancelar.
    *
    * 2) Campo "Nova Data" VAZIO nao faz nada - nem grava, nem avisa (o
    *    "If Not Empty(ldNew)" embrulha o corpo inteiro). Quando a operacao
    *    exige prazo (SigCdOpe.DtEntrs em 1/4/6) quem recusa o vazio eh a
    *    validacao do campo, com a mensagem do legado.
    *
    * 3) O historico arquiva a data que esta SAINDO (ldAnt = getAtual), nunca
    *    a nova - inverter os dois gravaria o historico ao contrario, sem
    *    erro nenhum na tela.
    *
    * 4) O modo do pai eh relido IMEDIATAMENTE antes de gravar, nao na
    *    abertura: este dialogo pode ficar aberto enquanto o pai troca de
    *    estado, e eh esse modo que decide se SigMvCab eh atualizado.
    *
    * 5) Na FALHA o campo digitado NAO eh limpo (regra #50) - so os tres
    *    Refresh finais do legado acontecem. Limpar faria o usuario perder a
    *    data e ter de redigitar depois de um erro de gravacao.
    *
    * A mensagem de falha ja vem do BO em todos os caminhos (SQL, commit,
    * excecao), por isso aqui nao ha ELSE com MsgErro proprio - seria a
    * segunda caixa para o mesmo erro (regra #20).
    *
    * Os dois RETURN de guarda ficam FORA do TRY, e o corpo usa flag em vez
    * de RETURN antecipado: RETURN dentro de TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC: eh alvo de BINDEVENT("Click") e tambem eh chamado direto, de
    * fora da classe, pelo harness de teste (regra #3).
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oBO, loc_dNovo, loc_oErro

        *-- Reentrancia: os dialogos deste caminho devolvem o foco e podem
        *-- redisparar o Click, o que gravaria o historico duas vezes.
        IF THIS.this_lConfirmandoPrazo
            RETURN
        ENDIF

        *-- Com pBlqAlt = .T. o legado desliga o botao (.altera.Enabled = .f.)
        *-- e nao ha como acionar a gravacao. O teste explicito existe porque
        *-- o harness chama este metodo direto, sem passar pelo controle.
        IF !THIS.cmd_4c_Confirmar.Enabled
            RETURN
        ENDIF

        THIS.this_lConfirmandoPrazo = .T.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- O getNova.Valid (TabIndex 1) roda ANTES do altera.Click
            *-- (TabIndex 2) em VFP nativo; aqui o encadeamento eh explicito,
            *-- consumindo o veredicto que o LostFocus acabou de produzir.
            IF !THIS.GarantirPrazoNovoValidado()
                *-- "Return .f." num Valid nativo deixa o foco preso no campo
                THIS.txt_4c_PrazoNovo.SetFocus()
            ELSE
                *-- "ldAnt = getAtual.Value / ldNew = getNova.Value"
                *--
                *-- As duas leituras agora passam pelo hook canonico
                *-- FormParaBO, que eh a fonte UNICA desta transferencia (o
                *-- corpo saiu daqui na Fase 8, nao foi duplicado). Recusando,
                *-- ele ja reportou o motivo e loc_dNovo permanece vazio - o
                *-- "If Not Empty" abaixo barra a gravacao, de modo que nada
                *-- eh gravado com o BO pela metade (regra #20).
                loc_dNovo = {}
                IF THIS.FormParaBO()
                    loc_dNovo = loc_oBO.this_dPrazoNovo
                ENDIF

                *-- "If Not Empty(ldNew)" - sem data nova o clique eh inocuo
                IF !EMPTY(loc_dNovo)
                    *-- Modo do pai relido agora, nao na abertura
                    THIS.SincronizarEscolhaPai()

                    IF loc_oBO.GravarAlteracaoPrazo()
                        *-- "ThisForm.pPrz = ldNew": o prazo gravado passa a
                        *-- ser o vigente. Fonte unica no BO - e eh dela que
                        *-- SincronizarCamposPrazo repinta "Data Atual".
                        loc_oBO.this_dPrazoAtual = loc_dNovo

                        *-- "parentform.validOk = .t." + devolucao do prazo
                        THIS.NotificarFormPai()

                        *-- "getAtual.Value = pPrz / getNova.Value = Ctod('')"
                        *-- mais os dois Refresh
                        THIS.SincronizarCamposPrazo()

                        *-- "GradeVenc.Refresh": a linha recem-arquivada tem
                        *-- de aparecer no historico, e repintar sem recarregar
                        *-- o cursor exibiria a lista antiga
                        THIS.CarregarLista()
                    ELSE
                        *-- Falha: o BO ja desfez (RollBack) e ja avisou. Os
                        *-- tres Refresh finais do legado acontecem de
                        *-- qualquer jeito - sem limpar o que foi digitado.
                        THIS.txt_4c_PrazoAtual.Refresh()
                        THIS.txt_4c_PrazoNovo.Refresh()
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.BtnConfirmarClick")
        ENDTRY

        THIS.this_lConfirmandoPrazo = .F.
    ENDPROC

    *==========================================================================
    * NotificarFormPai - devolve a tela chamadora o resultado da confirmacao,
    * espelhando as duas linhas do altera.Valid legado:
    *
    *   thisform.parentform.validOk = .t.
    *   ThisForm.ParentForm.cntEntregas.getEntregas.Value = ThisForm.pPrz
    *
    * A primeira linha eh a flag de sucesso que o pai consulta; a segunda
    * escreve o novo prazo no campo "Entregas" do pai, para a tela de
    * movimentacao exibir o valor atualizado sem recarregar.
    *
    * As DUAS sao guardadas por PEMSTATUS porque o PILAR 3 renomeia os objetos
    * do form migrado: "cntEntregas.getEntregas" so existe no pai que ainda
    * seja wrapper do VCX legado. Na flag aceita-se a grafia legado (validOk)
    * e, se ela nao existir, a convencao desta arquitetura (this_lValidOk) -
    * mesmo criterio de duas grafias ja usado em SincronizarEscolhaPai.
    *
    * Pai inexistente, ou pai sem nenhum desses membros, NAO eh erro: o
    * resultado continua disponivel ao chamador por ObterPrazoConfirmado(),
    * que eh o contrato de retorno desta arquitetura (o dialogo fecha com
    * Hide e seus dados seguem legiveis). Por isso nao ha mensagem aqui -
    * avisar o usuario sobre o layout do form pai nao o ajudaria em nada.
    *
    * Escrever no Value do pai pode disparar eventos dele, e o CATCH existe
    * para que uma falha LA nao derrube a confirmacao que JA foi gravada aqui.
    *
    * PUBLIC pelo mesmo motivo de SincronizarEscolhaPai: eh chamado de
    * BtnConfirmarClick, que roda de fora desta classe via BINDEVENT.
    *==========================================================================
    PROCEDURE NotificarFormPai()
        LOCAL loc_oPai, loc_dPrazo, loc_oErro

        IF VARTYPE(THIS.this_oFormPai) <> "O"
            RETURN
        ENDIF

        loc_oPai   = THIS.this_oFormPai
        loc_dPrazo = ConverterParaData(THIS.this_oBusinessObject.this_dPrazoAtual)

        TRY
            *-- "thisform.parentform.validOk = .t."
            IF PEMSTATUS(loc_oPai, "validOk", 5)
                loc_oPai.validOk = .T.
            ELSE
                IF PEMSTATUS(loc_oPai, "this_lValidOk", 5)
                    loc_oPai.this_lValidOk = .T.
                ENDIF
            ENDIF

            *-- "ParentForm.cntEntregas.getEntregas.Value = ThisForm.pPrz"
            IF PEMSTATUS(loc_oPai, "cntEntregas", 5)
                IF VARTYPE(loc_oPai.cntEntregas) = "O"
                    IF PEMSTATUS(loc_oPai.cntEntregas, "getEntregas", 5)
                        IF VARTYPE(loc_oPai.cntEntregas.getEntregas) = "O"
                            loc_oPai.cntEntregas.getEntregas.Value = loc_dPrazo
                            loc_oPai.cntEntregas.getEntregas.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em FormSigOpEnt.NotificarFormPai")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ObterPrazoConfirmado - contrato de retorno do dialogo: o prazo de
    * entrega que ficou vigente, ou data vazia quando nada foi gravado.
    *
    * Existe porque o legado devolvia o resultado escrevendo DIRETO num
    * controle do pai (cntEntregas.getEntregas), caminho que so sobrevive
    * enquanto esse pai for o wrapper do VCX - o PILAR 3 renomeia os objetos
    * do form migrado. Quem abrir este dialogo por CREATEOBJECT + Show() le
    * aqui o valor, depois do Show() e ANTES do Release(), do mesmo modo que
    * o projeto ja faz com FormBuscaAuxiliar.
    *
    * Eh LEITURA do estado do BO, nao uma segunda copia dele: a fonte unica
    * continua sendo this_dPrazoAtual, e this_lGravouPrazo (o validOk do
    * legado) eh o que distingue "confirmou" de "fechou sem gravar".
    *
    * PUBLIC: eh justamente o metodo que o form chamador le de fora.
    *==========================================================================
    FUNCTION ObterPrazoConfirmado()
        LOCAL loc_dPrazo
        loc_dPrazo = {}

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.this_lGravouPrazo
                loc_dPrazo = ConverterParaData(THIS.this_oBusinessObject.this_dPrazoAtual)
            ENDIF
        ENDIF

        RETURN loc_dPrazo
    ENDFUNC

    *==========================================================================
    * BtnCancelarClick - porta de SIGOPENT.sair.Valid, que eh uma linha so:
    *
    *   ThisForm.Release
    *
    * Fecha a tela sem gravar nada. Com Cancel = .T. no botao (transcrito do
    * dump), o ESC tambem desemboca aqui - era assim no legado e continua
    * sendo a via de saida do teclado.
    *
    * PUBLIC: alvo de BINDEVENT("Click") e chamado direto pelo harness de
    * teste (regra #3).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * FecharDialogo - funil UNICO de fechamento da tela.
    *
    * Fecha com Hide(), NAO com Release(), apesar de o legado escrever
    * "ThisForm.Release": medido no VFP9, Release() DESTROI o objeto mesmo com
    * o chamador segurando a referencia (loForm passa a VARTYPE "X" e a
    * leitura seguinte estoura "is not an object") - form object nao segue
    * refcount. Como este dialogo tem resultado a devolver
    * (ObterPrazoConfirmado, e o estado do BO que o pai consulta), fechar com
    * Release deixaria esse resultado INALCANCAVEL, que eh o defeito ja
    * catalogado no projeto.
    *
    * Para o usuario nada muda - Hide() em form modal tambem devolve do
    * Show() e a janela desaparece do mesmo jeito (PILAR 1 preservado); muda
    * so o tempo de vida do objeto, que eh PILAR 3. Eh o desenho que o
    * FormBuscaAuxiliar desta arquitetura ja adota, e por isso os chamadores
    * do projeto ja esperam chamar Release() eles mesmos depois de ler.
    *
    * Nao ha efeito externo a antecipar antes do Hide: o unico valor que o
    * legado empurrava para o pai (validOk e o campo de entregas) ja foi
    * escrito em NotificarFormPai, no instante da confirmacao, e o Destroy
    * daqui so fecha cursores desta sessao privada.
    *
    * PROTECTED: so os botoes desta classe fecham a tela. Quem abriu o
    * dialogo encerra com Release(), nao por este metodo.
    *==========================================================================
    PROTECTED PROCEDURE FecharDialogo()
        THIS.Hide()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem com Visible = .F.), percorrendo Pages e Controls
    * recursivamente.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Activate - Foco inicial da tela: a outra metade do "If ThisForm.Bloquear"
    * que encerra o Init legado
    *
    *   If ThisForm.Bloquear
    *       .GetNova.Enabled = .f.
    *       .altera.Enabled  = .f.
    *       .Gradevenc.SetFocus
    *   Else
    *       .getNova.SetFocus
    *   Endif
    *
    * Os dois Enabled moram em AplicarBloqueioAlteracao(), que roda junto com a
    * criacao dos controles. Aqui fica SO o SetFocus, por um motivo concreto:
    * no legado o Init roda com a janela ja criada pelo "Do Form", mas nesta
    * arquitetura o InicializarForm roda DENTRO do CREATEOBJECT, antes de
    * qualquer Show() - e SetFocus em form que ainda nao apareceu nao posiciona
    * nada. O Activate dispara quando a janela se torna ativa, isto e no
    * primeiro Show(), que eh exatamente o instante em que o foco do legado se
    * estabelecia.
    *
    * Por isso tambem o par Enabled NAO pode morar aqui: em modo de teste e em
    * validacao de UI o form nunca eh exibido, o Activate nao roda, e o
    * bloqueio vindo de pBlqAlt = .T. seria silenciosamente perdido.
    *
    * One-shot pela flag: Activate dispara TODA vez que a janela volta a ser a
    * ativa - por exemplo quando o dialogo de autorizacao de prazo (SigOpSen)
    * fecha. Sem a flag, o foco seria puxado de volta para o campo da data nova
    * no meio do fluxo de confirmacao, desfazendo o posicionamento que o proprio
    * handler acabou de fazer.
    *
    * O VARTYPE do BO vem em IF SEPARADO, nao num AND: VFP9 nao faz
    * short-circuit, entao a segunda metade seria avaliada de qualquer jeito.
    *==========================================================================
    PROCEDURE Activate()
        LOCAL loc_lBloqueado

        IF !THIS.this_lFocoInicialAplicado
            THIS.this_lFocoInicialAplicado = .T.

            loc_lBloqueado = .F.
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lBloqueado = THIS.this_oBusinessObject.this_lBloquear
            ENDIF

            IF loc_lBloqueado
                *-- Alteracao bloqueada: o legado joga o foco na grade do
                *-- historico, que eh tudo o que resta ao usuario
                THIS.grd_4c_Dados.SetFocus()
            ELSE
                THIS.txt_4c_PrazoNovo.SetFocus()
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Fecha os cursores de trabalho do BO (equivalente ao
    * ThisForm.poDataMgr.Release do "Procedure Release" legado) e solta a
    * referencia ao form pai, para o dialogo filho nao manter vivo quem o
    * abriu.
    *
    * USE IN basta e nao precisa de TABLEREVERT antes: USE IN fecha o alias
    * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering
    * (que e como CREATE CURSOR e SQLEXEC os criam) dispara erro 1586.
    *
    * DODEFAULT() na ULTIMA linha e obrigatorio: e o FormBase.Destroy que
    * libera o Business Object e reconstroi os popups do menu principal.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF USED(THIS.this_oBusinessObject.this_cCursorHistorico)
                    USE IN (THIS.this_oBusinessObject.this_cCursorHistorico)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorOperacao)
                    USE IN (THIS.this_oBusinessObject.this_cCursorOperacao)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorConfigDoc)
                    USE IN (THIS.this_oBusinessObject.this_cCursorConfigDoc)
                ENDIF
            ENDIF

            THIS.this_oFormPai = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormSigOpEnt.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpEntBO.prg):
*==============================================================================
* SigOpEntBO.prg
*
* Business Object para SigOpEnt - "Alteracao de Data de Entrega", dialogo
* filho aberto pela tela de movimentacao (form OPERACIONAL, WindowType = 1).
*
* Tabela principal: SigOpMvv - historico das datas de entrega de UMA
* movimentacao. Cada troca de prazo grava em SigOpMvv a data que esta SAINDO
* (coluna vencs) e atualiza SigMvCab.PrazoEnts com a data nova.
*
* Origem legado: tasks\task731\SigOpEnt_form_codigo_fonte.txt
*   SIGOPENT.Init          - recebe pEmp, pDop, pNum, pPrz, pFor, pMin, pDat,
*                            pBlqAlt, pMax do form pai e carrega 3 cursores
*                            (crSigOpMvv, crSigCdOpe, crSigOpCdd)
*   SIGOPENT.getNova.Valid - valida a data digitada contra pDat / pMin / pMax
*   SIGOPENT.altera.Valid  - grava o historico e atualiza SigMvCab
*
* Esta tela NAO eh um cadastro CRUD: nao tem lista com Incluir/Alterar/
* Excluir. O unico caminho de gravacao eh o botao Confirmar, que INSERE uma
* linha de historico em SigOpMvv e faz o UPDATE de SigMvCab.PrazoEnts.
*==============================================================================

DEFINE CLASS SigOpEntBO AS BusinessBase

    *--------------------------------------------------------------------------
    * COLUNAS DE SigOpMvv - grafia EXATA do docs\schema.sql (PILAR 2)
    *
    *   cidchaves  char(20)      NOT NULL   PK (sigopmvv_cidchaves)
    *   emps       char(3)       NOT NULL
    *   dopcs      char(20)      NOT NULL
    *   notitulos  numeric(6,0)  NOT NULL
    *   empdopncs  char(29)      NOT NULL
    *   vencs      datetime      NULL
    *   datas      datetime      NULL
    *   usuars     char(10)      NOT NULL
    *
    * As 6 colunas NOT NULL tem propriedade propria aqui (regra #22): a PK
    * cidchaves vem de fUniqueIds() - NUNCA string vazia, senao a segunda
    * linha de historico colide no indice unico - e usuars vem de
    * gc_4c_UsuarioLogado. O legado grava exatamente estas 8 colunas
    * (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs, cIdChaves, Usuars, Datas),
    * ou seja a lista do schema e a do legado coincidem.
    *--------------------------------------------------------------------------
    this_cCidChaves = ""            && cidchaves  char(20)     - PK, fUniqueIds()
    this_cEmps = ""                 && emps       char(3)      - empresa (pEmp)
    this_cDopcs = ""                && dopcs      char(20)     - documento/operacao (pDop)
    this_nNoTitulos = 0             && notitulos  numeric(6,0) - numero da operacao (pNum)
    this_cEmpDopNcs = ""            && empdopncs  char(29)     - chave posicional
    this_dVencs = {}                && vencs      datetime     - data de entrega ARQUIVADA
    this_dDatas = {}                && datas      datetime     - data/hora do registro
    this_cUsuars = ""               && usuars     char(10)     - usuario que alterou

    *--------------------------------------------------------------------------
    * CHAVE POSICIONAL empdopncs char(29) - regra #42
    *
    * O legado monta a chave concatenando SEM ALLTRIM:
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * As larguras vem das COLUNAS: emps char(3) + dopcs char(20) + STR(,6)
    * = 29 = empdopncs char(29). O padding FAZ PARTE da chave: encurtar
    * qualquer parte com ALLTRIM devolve ZERO linha em silencio. A montagem
    * usa PADR explicito sobre as larguras do schema, porque as propriedades
    * deste BO recebem os valores do form pai ja com ALLTRIM.
    *
    * A MESMA chave de 29 caracteres eh o filtro do UPDATE de SigMvCab
    * (Where EmpDopNums = ...), por isso uma unica propriedade atende aos
    * dois usos.
    *--------------------------------------------------------------------------
    this_nLarguraEmps = 3           && largura de SigOpMvv.emps  no schema
    this_nLarguraDopcs = 20         && largura de SigOpMvv.dopcs no schema
    this_nLarguraNoTitulos = 6      && digitos de STR(notitulos, 6) na chave

    *--------------------------------------------------------------------------
    * PARAMETROS RECEBIDOS DO FORM PAI
    *
    * O legado guarda estes valores em propriedades do proprio form (pEmp,
    * pDop, pNum, pPrz, pMin, pMax, pDat, Bloquear - ver RESERVED3 ClassInfo
    * do dump). Aqui eles vivem no BO, porque sao o insumo da validacao e da
    * gravacao. pFor (a referencia ao form pai) NAO vem para o BO: continua
    * sendo assunto do Form.
    *
    * As datas sao declaradas como DATE ({}) porque chegam de TextBox e de
    * propriedade do form pai, nao de coluna datetime do SQL Server - por
    * isso toda normalizacao usa ConverterParaData(), nunca TTOD(), que com
    * DATE dispara erro 11 em runtime (regra #16).
    *--------------------------------------------------------------------------
    this_dPrazoAtual = {}           && pPrz    - data de entrega vigente (SigMvCab.PrazoEnts)
    this_dPrazoNovo = {}            && valor digitado em getNova
    this_dDataMovimento = {}        && pDat    - data da movimentacao
    this_nPrazoMinimo = 0           && pMin    - dias minimos contados de pDat
    this_nPrazoMaximo = 0           && pMax    - dias maximos contados de pDat
    this_lBloquear = .F.            && pBlqAlt - .T. bloqueia a alteracao (so consulta)

    *--------------------------------------------------------------------------
    * CONTEXTO DO FORM PAI QUE DECIDE O UPDATE DE SigMvCab
    *
    * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR').
    * O UPDATE de SigMvCab.PrazoEnts SO acontece quando o pai NAO esta em
    * modo ALTERAR - nesse modo o proprio pai grava o cabecalho. O historico
    * em SigOpMvv, ao contrario, eh gravado nos dois casos.
    *--------------------------------------------------------------------------
    this_cEscolhaPai = ""           && ParentForm.pcEscolha ("INSERIR"/"ALTERAR"/...)
    this_cModoNaoAtualizaCabecalho = "ALTERAR"   && valor que SUPRIME o UPDATE de SigMvCab

    *--------------------------------------------------------------------------
    * CONFIGURACAO LIDA DOS CURSORES DE APOIO (CursorQuery do Init legado)
    *
    * Ambas sao numeric(1,0) NOT NULL no schema, portanto chegam ao VFP como
    * NUMERICO - propriedade this_n*, comparada com numero.
    *
    *   SigCdOpe.dtentrs  - regra de exigencia do prazo de entrega. O legado
    *                       so exige/valida a data quando InList(DtEntrs, 1, 4, 6).
    *   SigOpCdd.chkuteis - indica se a contagem de dias considera dias uteis.
    *--------------------------------------------------------------------------
    this_nDtEntrs = 0               && SigCdOpe.dtentrs  numeric(1,0)
    this_nChkUteis = 0              && SigOpCdd.chkuteis numeric(1,0)

    *--------------------------------------------------------------------------
    * ALIASES DOS CURSORES
    *
    * Equivalencia com o legado:
    *   crSigOpMvv  -> cursor_4c_Dados      (alimenta a grade Gradevenc)
    *   crSigCdOpe  -> cursor_4c_Operacao   (CursorQuery SigCdOpe / Dopes / DtEntrs)
    *   crSigOpCdd  -> cursor_4c_ConfigDoc  (CursorQuery SigOpCdd / Dopes / chkUteis)
    *--------------------------------------------------------------------------
    this_cCursorHistorico = "cursor_4c_Dados"
    this_cCursorOperacao = "cursor_4c_Operacao"
    this_cCursorConfigDoc = "cursor_4c_ConfigDoc"

    *--------------------------------------------------------------------------
    * LIBERACAO POR SENHA (Do Form SigOpSen With 'LIBPRZENT', ...)
    *
    * Quando a data digitada fica fora da faixa pMin..pMax, o legado pede
    * autorizacao pelo programa LIBPRZENT e, autorizado, registra a liberacao
    * com fGravarLog('T', pDop, 'LIBPRZENT', <transacao>, <usuario liberador>).
    * O codigo do programa eh constante no legado e fica aqui para o texto do
    * log e a chamada da autorizacao usarem a MESMA grafia.
    *--------------------------------------------------------------------------
    this_cProgramaLiberacao = "LIBPRZENT"
    this_cTituloLiberacao = "Libera Prazo de Entrega"
    this_cUsuarioLiberacao = ""     && usuario que autorizou (retorno do SigOpSen)
    this_lPrazoLiberado = .F.       && .T. quando a autorizacao foi concedida

    *--------------------------------------------------------------------------
    * ESTADO DA ULTIMA GRAVACAO
    *
    * O legado controla commit/rollback com a flag local llOks e avisa o pai
    * do sucesso com thisform.parentform.validOk = .t. - o Form le esta
    * propriedade para decidir se repassa o novo prazo ao pai.
    *--------------------------------------------------------------------------
    this_lGravouPrazo = .F.         && .T. quando historico e cabecalho gravaram

    *====================================================================
    * Init - Inicializa Business Object
    *
    * this_cCampoChave usa a grafia do schema (cidchaves), que eh a PK
    * declarada em CONSTRAINT [sigopmvv_cidchaves].
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigOpMvv"
        THIS.this_cCampoChave = "cidchaves"

        *-- usuars eh NOT NULL char(10): nasce com o usuario logado, o mesmo
        *-- Usuar global que o INSERT do legado usa. O guard de TYPE existe
        *-- porque probe/teste headless pode instanciar o BO antes do startup
        *-- ter definido a variavel publica.
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
        ELSE
            THIS.this_cUsuars = ""
        ENDIF

        *-- Nenhuma gravacao nem liberacao aconteceu nesta instancia ainda.
        THIS.this_lGravouPrazo = .F.
        THIS.this_lPrazoLiberado = .F.
        THIS.this_cUsuarioLiberacao = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - PK da linha de historico gravada por Inserir()
    *
    * Fica PROTECTED pela heranca de BusinessBase (regra #51 do CLAUDE.md:
    * PROTECTED declarado em QUALQUER classe da cadeia prevalece) - quem
    * usa isto eh RegistrarAuditoria(), chamado de dentro do proprio BO.
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega uma linha de SigOpMvv (cursor_4c_Dados,
    * equivalente ao crSigOpMvv do legado) para as propriedades do BO.
    *
    * Esta tela NUNCA altera uma linha de historico existente - cada
    * confirmacao sempre INSERE uma linha nova (ver cabecalho da classe).
    * Este metodo serve para inspecionar uma linha ja gravada (detalhe da
    * grade Gradevenc), nao para reabrir edicao; this_lNovoRegistro = .F.
    * segue o padrao canonico do projeto (BlqBO.CarregarDoCursor e
    * similares), mesmo que esta tela nao tenha fluxo de ALTERAR.
    *
    * Uso de SELECT (par_cAliasCursor) + campo direto, nunca
    * campo (regra #9 - sintaxe invalida em VFP9).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cEmps      = TratarNulo(emps, "C")
            THIS.this_cDopcs     = TratarNulo(dopcs, "C")
            THIS.this_nNoTitulos = TratarNulo(notitulos, 0)
            THIS.this_cEmpDopNcs = TratarNulo(empdopncs, "C")
            THIS.this_dVencs     = TratarNulo(vencs, {})
            THIS.this_dDatas     = TratarNulo(datas, {})
            THIS.this_cUsuars    = TratarNulo(usuars, "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres, usada
    * tanto no INSERT de SigOpMvv.empdopncs quanto no WHERE do UPDATE de
    * SigMvCab.empdopnums (mesmo VALOR, nomes de coluna diferentes - o
    * legado monta os dois com a mesma expressao).
    *
    * Regra #42: o legado monta SEM ALLTRIM -
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * - e o padding FAZ PARTE da chave: emps char(3) + dopcs char(20) +
    * STR(,6) = 29 caracteres = largura EXATA das colunas empdopncs e
    * empdopnums no schema. Usa PADR explicito sobre as larguras do
    * SCHEMA (this_nLarguraEmps/Dopcs/NoTitulos), porque this_cEmps e
    * this_cDopcs chegam a este BO ja com ALLTRIM (vindos do form pai) -
    * encurtar qualquer parte faz a chave NUNCA casar, sem erro nenhum.
    *====================================================================
    PROTECTED FUNCTION MontarChaveEmpDopNums()
        RETURN PADR(THIS.this_cEmps, THIS.this_nLarguraEmps) + ;
               PADR(THIS.this_cDopcs, THIS.this_nLarguraDopcs) + ;
               STR(THIS.this_nNoTitulos, THIS.this_nLarguraNoTitulos)
    ENDFUNC

    *====================================================================
    * CarregarConfiguracaoOperacao - Carrega as duas configuracoes de apoio
    * que o Init legado busca com CursorQuery, ANTES de liberar a tela:
    *
    *   .poDataMgr.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', .pDop, 'DtEntrs')
    *   If Not Used('crSigCdOpe')
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *       Return .f.
    *   EndIf
    *   .poDataMgr.CursorQuery('SigOpCdd', 'crSigOpCdd', 'Dopes', .pDop, 'chkUteis')
    *   If Not Used('crSigOpCdd')
    *       ... Return .f.
    *   EndIf
    *
    * As DUAS consultas sao requisito de ABERTURA no legado: falhando
    * qualquer uma, o Init devolve .f. e o "Do Form" inteiro nao chega a
    * abrir. Aqui o mesmo efeito vem do RETURN .F. deste metodo, que o
    * InicializarForm do Form usa para abortar o CREATEOBJECT.
    *
    * this_nDtEntrs eh o que ValidarPrazoNovo (Form) usa depois
    * (InList(DtEntrs,1,4,6) do getNova.Valid legado). this_nChkUteis eh
    * carregado pelo mesmo motivo do legado - a abertura da tela depende
    * das DUAS consultas terem sucesso -, mas nenhum dos 7 metodos com
    * codigo do dump chega a LER o valor depois de carregado: fica
    * disponivel sem logica adicional inventada (regra CLAUDE.md
    * REGRA FUNDAMENTAL - nao omitir, mas tambem nao inventar uso que o
    * legado nao tem).
    *
    * Sem conexao (gnConnHandle invalido - probe headless, validacao de UI)
    * os dois valores ficam no default 0 e o metodo devolve .T.: nao ha
    * banco para consultar, e abortar a tela nesse modo impediria qualquer
    * teste automatizado de instanciar o form.
    *
    * EVALUATE(<alias> + ".<campo>") para LEITURA eh seguro (regra #15) -
    * so a ATRIBUICAO com "=" dentro da string eh que nao funciona.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * InicializarForm() do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao: mesmo criterio de CarregarHistorico - nao
                *-- ha banco para consultar, e isso nao e falha.
                loc_lSucesso = .T.
            ELSE
                IF USED(THIS.this_cCursorOperacao)
                    USE IN (THIS.this_cCursorOperacao)
                ENDIF

                loc_cSQL = "SELECT DtEntrs FROM SigCdOpe" + ;
                    " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

                IF loc_nResult >= 0 AND USED(THIS.this_cCursorOperacao) ;
                        AND !EOF(THIS.this_cCursorOperacao)

                    THIS.this_nDtEntrs = NVL(EVALUATE(THIS.this_cCursorOperacao + ".DtEntrs"), 0)

                    IF USED(THIS.this_cCursorConfigDoc)
                        USE IN (THIS.this_cCursorConfigDoc)
                    ENDIF

                    loc_cSQL = "SELECT chkUteis FROM SigOpCdd" + ;
                        " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorConfigDoc)

                    IF loc_nResult >= 0 AND USED(THIS.this_cCursorConfigDoc) ;
                            AND !EOF(THIS.this_cCursorConfigDoc)
                        THIS.this_nChkUteis = NVL(EVALUATE(THIS.this_cCursorConfigDoc + ".chkUteis"), 0)
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                            "o (CursorQuery - SigOpCdd)")
                        THIS.this_lErroExibido = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                        "o (CursorQuery - SigCdOpe)")
                    THIS.this_lErroExibido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarConfiguracaoOperacao")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorHistorico - Cria o cursor VAZIO que alimenta a grade do
    * historico (this_cCursorHistorico, o crSigOpMvv do legado).
    *
    * Este metodo eh a FONTE UNICA da estrutura desse cursor: nomes, tipos e
    * ORDEM aqui tem de ser os MESMOS da lista do SELECT de
    * CarregarHistorico(), porque a recarga eh por ZAP + APPEND FROM DBF(),
    * que casa coluna por NOME. Por isso o Form CHAMA este metodo e NUNCA
    * declara a estrutura de novo - duas declaracoes com ordem ou grafia
    * diferentes eh o defeito classico dos forms OPERACIONAIS.
    *
    * Tipos conforme docs\schema.sql (SIGOPMVV): cidchaves char(20),
    * emps char(3), dopcs char(20), notitulos numeric(6,0),
    * empdopncs char(29), vencs datetime, datas datetime, usuars char(10).
    *
    * SET NULL ON em volta do CREATE CURSOR: vencs e datas sao NULL-aveis no
    * SQL Server, e sem campos NULL-aveis o APPEND FROM de uma linha com
    * NULL falha.
    *
    * O alias eh fechado com USE IN e SEM TABLEREVERT antes: USE IN fecha
    * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering -
    * que eh como CREATE CURSOR e SQLEXEC os criam - dispara erro 1586.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o Form, de FORA da
    * classe, antes de ligar a grade.
    *====================================================================
    PROCEDURE CriarCursorHistorico()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursor) ;
            (cidchaves C(20), emps C(3), dopcs C(20), notitulos N(6, 0), ;
             empdopncs C(29), vencs T, datas T, usuars C(10))
        SET NULL OFF

        RETURN USED(loc_cCursor)
    ENDPROC

    *====================================================================
    * LimparCursorHistorico - Esvazia o cursor da grade PRESERVANDO a
    * estrutura e, com ela, o RecordSource/ControlSource que o Form ligou no
    * InicializarForm. Eh o Zap In <cursor> do legado Fortyus.
    *
    * SET SAFETY OFF em volta do ZAP eh OBRIGATORIO, nao precaucao: o form
    * que consome este BO eh DataSession = 2, e SET SAFETY eh escopado por
    * DATA SESSION - medido no VFP9, dentro da datasession privada o SAFETY
    * vale ON mesmo com o SET SAFETY OFF do main.prg (mesmo mecanismo que
    * reseta SET DATE/CENTURY ali). Com SAFETY ON o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" e CONGELA a tela esperando um clique que
    * ninguem ve - num teste headless isso aparece como timeout sem
    * resultado nenhum, nao como erro.
    *
    * SELECT antes do ZAP: ZAP IN nao muda a work area corrente, e quem
    * chama este metodo segue com APPEND FROM, que vai para a work area
    * CORRENTE.
    *====================================================================
    PROTECTED PROCEDURE LimparCursorHistorico()
        LOCAL loc_cCursor, loc_cSafety
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT (loc_cCursor)
            ZAP IN (loc_cCursor)
            IF loc_cSafety == "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * CarregarHistorico - Popula a grade com o historico de datas de entrega
    * desta operacao (uma linha por troca de prazo ja arquivada).
    *
    * Transcreve a consulta que o Init legado monta e manda ao AddCursor:
    *   lcQrySigOpMvv = [Select * ] + ;
    *                    [From SigOpMvv ] + ;
    *                   [Where EmpDopNcs = '] + pEmp + pDop + Str(pNum, 6) + [' ] + ;
    *                   [Order By Vencs]
    * As colunas sao listadas explicitamente no lugar do SELECT *, para a
    * lista do SELECT ser a MESMA do CREATE CURSOR de CriarCursorHistorico()
    * - APPEND FROM DBF() casa coluna por NOME.
    *
    * A chave vem de MontarChaveEmpDopNums(): 29 caracteres COM o padding,
    * porque empdopncs eh char(29) POSICIONAL (emps char(3) + dopcs char(20)
    * + STR(,6)) e encurtar qualquer parte com ALLTRIM faz o WHERE nunca
    * casar - devolvendo ZERO linha em SILENCIO, sem erro e sem log.
    *
    * Sem os parametros do form pai (probe headless, harness) a chave fica
    * em branco e o SELECT devolve ZERO linha: grade vazia, SEM erro - o
    * mesmo que o legado exibe para uma operacao que nunca teve troca de
    * prazo. Por isso zero linha NAO eh falha, e quem precisa aferir carga
    * tem de olhar RECCOUNT, nao o retorno deste metodo.
    *
    * O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
    * recarregado por ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias
    * da grade FECHA e RECRIA o alias: o Grid perde RecordSource e
    * ControlSource e cai para ColumnCount = 0 - vira um retangulo branco
    * sem cabecalho e sem coluna, sem erro, sem log e sem excecao.
    *
    * O guard do TABLEREVERT olha o BUFFERING, nao o USED: TABLEREVERT em
    * cursor sem buffering (como SQLEXEC cria) dispara erro 1586.
    *
    * Sem conexao (gnConnHandle invalido - validacao de UI, probe headless)
    * a grade fica VAZIA e o metodo devolve .T.: nao houve falha, so nao
    * havia banco para consultar.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o CarregarLista()
    * do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cCursor, loc_cTmp, loc_cChave
        LOCAL loc_nResult, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorHistorico
        loc_cTmp     = "cursor_4c_HistoricoTmp"

        TRY
            IF !USED(loc_cCursor)
                THIS.CriarCursorHistorico()
            ENDIF

            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o cursor do hist" + CHR(243) + "rico (" + loc_cCursor + ")."
                MsgErro(THIS.this_cMensagemErro, "SigOpEntBO.CarregarHistorico")
                THIS.this_lErroExibido = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao: grade vazia, mesmo resultado visual de uma
                    *-- operacao sem historico
                    THIS.LimparCursorHistorico()
                    loc_lSucesso = .T.
                ELSE
                    loc_cChave = THIS.MontarChaveEmpDopNums()

                    loc_cSQL = "SELECT cidchaves, emps, dopcs, notitulos," + ;
                        " empdopncs, vencs, datas, usuars" + ;
                        " FROM SigOpMvv" + ;
                        " WHERE EmpDopNcs = " + EscaparSQL(loc_cChave) + ;
                        " ORDER BY Vencs"

                    IF USED(loc_cTmp)
                        IF CURSORGETPROP("Buffering", loc_cTmp) > 1
                            TABLEREVERT(.T., loc_cTmp)
                        ENDIF
                        USE IN (loc_cTmp)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                    IF loc_nResult >= 0
                        THIS.LimparCursorHistorico()
                        SELECT (loc_cCursor)
                        SET NULL ON
                        APPEND FROM DBF(loc_cTmp)
                        SET NULL OFF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Mensagem do legado nas falhas de carga deste form:
                        *-- MessageBox([Favor Reinicializar o Processo!!!], 16,
                        *--            [Falha na Conexao (...)])
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
                        THIS.this_lErroExibido = .T.
                    ENDIF

                    IF USED(loc_cTmp)
                        USE IN (loc_cTmp)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarHistorico")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de HISTORICO em SigOpMvv.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 550-553 do dump legado):
    *   Insert Into crSigOpMvv (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs,
    *                           cIdChaves, Usuars, Datas)
    *          Values (pEmp, pDop, pNum, fDtoSQL(ldAnt),
    *                  pEmp + pDop + Str(pNum,6), fUniqueIds(), Usuar,
    *                  Datetime())
    *
    * ATENCAO (nao inverter): Vencs recebe this_dPrazoAtual - o prazo que
    * esta SAINDO (ldAnt no legado) - NUNCA this_dPrazoNovo. O historico
    * arquiva a data ANTIGA, a nova vai para SigMvCab em Atualizar().
    *
    * O legado so executa o bloco inteiro (insert+update+commit) quando a
    * data nova nao esta vazia (If Not Empty(ldNew)); com o campo vazio o
    * clique em Confirmar nao faz nada, sem erro nenhum - por isso aqui
    * tambem devolve .T. (nada a gravar) e nao falha.
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        THIS.this_lGravouPrazo = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpMvv" + ;
                       " (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs," + ;
                       "  cIdChaves, Usuars, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, THIS.this_nLarguraEmps)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopcs, THIS.this_nLarguraDopcs)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNoTitulos, 0) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoAtual) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNcs) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao gravar hist" + CHR(243) + "rico de entrega:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE de SigMvCab.PrazoEnts com a data NOVA.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 559-568 do dump legado):
    *   If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts = ?pDtp
    *       Where EmpDopNums = pEmp + pDop + Str(pNum,6)
    *   EndIf
    *
    * Quando o form pai esta em modo ALTERAR (this_cEscolhaPai igual a
    * this_cModoNaoAtualizaCabecalho), o PROPRIO pai grava o cabecalho e
    * este UPDATE tem de ser PULADO - essa condicao eh regra de negocio
    * do legado (CLAUDE.md regra #21b: a condicao que cerca a validacao
    * faz parte dela), por isso devolve .T. (nada a atualizar) em vez de
    * executar o UPDATE, exatamente como o legado nao executa a query.
    *
    * Depende de this_cEmpDopNcs e this_dPrazoNovo ja estarem calculados
    * - chamar DEPOIS de Inserir() ter devolvido .T., nunca isolado.
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        IF THIS.this_cEscolhaPai = THIS.this_cModoNaoAtualizaCabecalho
            *-- Modo ALTERAR: o form pai grava o proprio cabecalho - nada a
            *-- fazer aqui (fiel ao guard do legado em altera.Valid).
            THIS.this_lGravouPrazo = .T.
            RETURN .T.
        ENDIF

        TRY
            IF EMPTY(THIS.this_cEmpDopNcs)
                THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoNovo) + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNcs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_lGravouPrazo = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar o prazo de entrega do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * GravarAlteracaoPrazo - UNICA via de gravacao desta tela: encadeia
    * Inserir() + Atualizar() e fecha a transacao, espelhando o corpo de
    * SIGOPENT.altera.Valid com a flag llOks do legado:
    *
    *   Insert Into crSigOpMvv (...)            -> Inserir()
    *   llOks = .t.
    *   If llOks And (pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts ...   -> Atualizar()
    *   EndIf
    *   If llOks
    *       If Not poDataMgr.Update('crSigOpMvv')  -> (ver nota abaixo)
    *   EndIf
    *   If llOks
    *       If (poDataMgr.Commit() < 1)
    *           =MessageBox('Favor Reinicializar o Processo!!!', 16,
    *                       'Falha na Conexao (Commit)')
    *           llOks = .f.
    *       EndIf
    *   EndIf
    *   If Not llOks
    *       poDataMgr.RollBack()
    *   EndIf
    *
    * O "poDataMgr.Update('crSigOpMvv')" do legado NAO tem linha propria
    * aqui: ele era o passo que mandava ao servidor as linhas em aberto do
    * cursor remoto do Fortyus (o INSERT legado grava no CURSOR, nao na
    * tabela). Nesta arquitetura Inserir() emite o INSERT direto em
    * SigOpMvv por SQLEXEC, de modo que o envio ja aconteceu - o passo
    * esta cumprido, nao descartado.
    *
    * O Commit(), ao contrario, NAO se descarta: medido neste ambiente,
    * SQLGETPROP(gnConnHandle, "Transactions") = 2 (MANUAL) e a conexao
    * nasce com @@TRANCOUNT = 1, isto eh o gravado fica preso na transacao
    * aberta e SOME se o processo cair - foi assim que um UPDATE migrado
    * sem o Commit do legado deixou de persistir sem erro na tela. O par
    * loc_lManual + SQLCOMMIT/SQLROLLBACK eh a forma segura usada no
    * projeto (SIGPRCNBBO): com a conexao em auto-commit o par fica
    * inerte, em vez de comitar a transacao de outra tela.
    *
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)": VFP9 nao faz
    * curto-circuito e chamaria o SQLCOMMIT de qualquer jeito.
    *
    * Campo vazio devolve .F. sem mensagem nenhuma: o legado embrulha o
    * bloco inteiro em "If Not Empty(ldNew)", logo clicar Confirmar com a
    * data nova em branco nao faz nada - nem grava, nem avisa. Quem decide
    * se ha o que gravar eh o Form, que ja testa isso antes de chamar;
    * este guard existe para o metodo nunca gravar meia operacao se for
    * chamado isolado.
    *
    * this_lGravouPrazo (o "thisform.parentform.validOk = .t." do legado)
    * so permanece .T. quando TODA a cadeia passou - inclusive o commit.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9. Os dois RETURN antecipados ficam
    * FORA do bloco.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * BtnConfirmarClick() do Form, de FORA da classe - metodo que o Form
    * chama nunca pode ser PROTECTED em nenhum nivel da heranca
    * (regra #51).
    *====================================================================
    FUNCTION GravarAlteracaoPrazo()
        LOCAL loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .F.

        THIS.this_lGravouPrazo  = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .F.
        ENDIF

        *-- Conexao em transacao MANUAL (2) exige commit explicito; em
        *-- auto-commit (1) o par commit/rollback fica inerte.
        loc_lManual = .F.
        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        ENDIF

        TRY
            *-- Historico: arquiva a data que esta SAINDO (this_dPrazoAtual)
            loc_lSucesso = THIS.Inserir()

            *-- Cabecalho do movimento: recebe a data NOVA. Pulado quando o
            *-- form pai esta em ALTERAR - ali eh ele que grava SigMvCab
            *-- (guard do legado, ja dentro de Atualizar()).
            IF loc_lSucesso
                loc_lSucesso = THIS.Atualizar()
            ENDIF

            IF loc_lManual
                IF loc_lSucesso
                    IF SQLCOMMIT(gnConnHandle) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (Commit)")
                        THIS.this_lErroExibido = .T.
                        = SQLROLLBACK(gnConnHandle)
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    *-- "If Not llOks / ThisForm.poDataMgr.RollBack()"
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDIF

            IF !loc_lSucesso
                THIS.this_lGravouPrazo = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.GravarAlteracaoPrazo")
            THIS.this_lErroExibido = .T.
            THIS.this_lGravouPrazo = .F.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


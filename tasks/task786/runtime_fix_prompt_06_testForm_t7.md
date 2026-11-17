# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 7/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-13 16:28:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-13 16:28:38] [INFO] Config FPW: (nao fornecido)
[2026-11-13 16:28:39] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 16:28:39] [INFO] Timeout: 300 segundos
[2026-11-13 16:28:39] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jq0rad0o.prg
[2026-11-13 16:28:40] [INFO] Conteudo do wrapper:
[2026-11-13 16:28:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGOPPGC', 'C:\4c\tasks\task786\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPPGC', 'C:\4c\tasks\task786\logs\06_testForm.log'
QUIT

[2026-11-13 16:28:40] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jq0rad0o.prg
[2026-11-13 16:28:40] [INFO] VFP output esperado em: C:\4c\tasks\task786\vfp_output.txt
[2026-11-13 16:28:41] [INFO] Executando Visual FoxPro 9...
[2026-11-13 16:28:41] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jq0rad0o.prg
[2026-11-13 16:28:41] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jq0rad0o.prg
[2026-11-13 16:28:41] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGOPPGC
Inicio: 13/11/2026 16:28:42

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 13/11/2026 16:30:37
Duracao: 115 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-13 16:30:37] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-13 16:30:38] [INFO] VFP9 finalizado em 116.7069345 segundos
[2026-11-13 16:30:38] [INFO] Exit Code: 
[2026-11-13 16:30:38] [INFO] 
[2026-11-13 16:30:39] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-13 16:30:39] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jq0rad0o.prg
[2026-11-13 16:30:39] [INFO] 
[2026-11-13 16:30:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-13 16:30:40] [INFO] * Auto-generated wrapper for parameters
[2026-11-13 16:30:40] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 16:30:41] [INFO] * Parameters: 'FormSIGOPPGC', 'C:\4c\tasks\task786\logs\06_testForm.log'
[2026-11-13 16:30:41] [INFO] 
[2026-11-13 16:30:42] [INFO] * Anti-dialog protections for unattended execution
[2026-11-13 16:30:42] [INFO] SET SAFETY OFF
[2026-11-13 16:30:42] [INFO] SET RESOURCE OFF
[2026-11-13 16:30:43] [INFO] SET TALK OFF
[2026-11-13 16:30:43] [INFO] SET NOTIFY OFF
[2026-11-13 16:30:44] [INFO] SYS(2335, 0)
[2026-11-13 16:30:44] [INFO] 
[2026-11-13 16:30:44] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPPGC', 'C:\4c\tasks\task786\logs\06_testForm.log'
[2026-11-13 16:30:45] [INFO] QUIT
[2026-11-13 16:30:45] [INFO] 
[2026-11-13 16:30:45] [INFO] === Fim do Wrapper.prg ===
[2026-11-13 16:30:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPGC.prg):
*==============================================================================
* FORMSIGOPPGC.PRG
* Form de Informar os Barras (SigOpPgc)
* Migracao de SIGOPPGC.SCX (task786)
*
* Form OPERACIONAL de layout proprio: o objeto raiz do legado eh "form"
* generico (nao frmcadastro), WindowType = 1 (dialogo MODAL - Show() sempre
* bloqueia, independente de parametro), ControlBox = .F. + TitleBar = 0 - sem
* X e sem barra de titulo. Nao existe PageFrame nem Page1=Lista/Page2=Dados:
* a tela eh um unico painel com o cabecalho (cntSombra), uma moldura
* decorativa (Shape1), o rotulo da forma de pagamento (Label1), os dois
* botoes de acao (Ok/Cancela), uma grade de 2 colunas (Grade - Barra/Valor)
* e os controles de saldo (Get_Saldo/Label2/Label3) - ver
* tasks\task786\layout.json e mapeamento.json.
*
* Aberto pelo form PAI de pagamento (que mantem o cursor crSigOpFp - forma
* de pagamento corrente, com as colunas fpags/VlrFpgs) via
* "Do Form SigOpPgc With ThisForm, <DataSessionId do pai>, <Saldo>,
* <Conexao>" ("LParameters poForm, pnDataSes, poValor, pConexao" no Init
* legado - ver comportamento.json). O 2o parametro (par_nDataSessionPai) eh
* o DataSessionId do form pai: o legado declara DataSession = 2 (privada) na
* CLASSE, mas o Init logo chama "Set Datasession To DatSes" para REBINDAR a
* sessao corrente para a do form pai - sem isso o cursor crSigOpFp do pai
* ficaria invisivel para este dialogo (sessao privada isolada). Transcrito
* fielmente: SET DATASESSION TO (par_nDataSessionPai) dentro do Init, ANTES
* de DODEFAULT() (que dispara InicializarForm).
*
* this_oFormPai equivale a property customizada "parentform" do legado
* (RESERVED3 ClassInfo: antvalue/gravadados/parentform/podatamgr/saldo/
* *mctrlbotoes - comentada). this_nSaldoRecebido equivale a "Saldo" - valor
* disponivel para pagamento (poValor), recebido ANTES do Business Object
* existir (criado so em InicializarForm) e repassado a
* this_oBusinessObject.this_nSaldoInicial/this_nSaldoAtual logo apos a
* criacao; a reproducao em tela (txt_4c_Saldo.Value = Saldo, equivalente a
* "ThisForm.Get_Saldo.Value = ThisForm.Saldo" do Init legado) entra so na
* fase em que o controle Get_Saldo for criado. "antvalue"/"gravadados" e o
* "*mctrlbotoes" (comentado no dump) sao reservados no ClassInfo mas NUNCA
* referenciados em metodo/evento nenhum da SECAO 3 do dump extraido -
* residuo de template copiado de outro form da familia SigOpPxx (o mesmo
* fenomeno documentado em Formsigopped.prg para "gravadados") - por isso
* NAO sao portados como property (evita inventar estado morto). poDataMgr
* (4o parametro do Init legado, pConexao) tambem nao tem equivalente nesta
* arquitetura - gnConnHandle eh compartilhado via config.prg - o parametro
* eh aceito so por compatibilidade de assinatura com a chamada do form pai
* e descartado (mesma decisao de Formsigopped.prg para poDataMgr).
*
* O cursor LOCAL BarBonus (sem tabela no SQL Server - SIGOPPGCBO.this_cTabela
* fica vazio de proposito, ver cabecalho de SIGOPPGCBO.prg) eh criado por
* este proprio form, no mesmo padrao de GarantirCursorGrade de
* Formsigoppei.prg - entra na Fase 4/8, junto com a grade que o consome
* (ColumnCount -> RecordSource -> ControlSource, regra CLAUDE.md #41 -
* Column.ControlSource de cursor que ainda nao existe derruba o Init).
*
* Esta tela NAO eh acessada pelo menu principal (nenhum "Abrir*" em
* menu.prg) - eh sempre aberta por um form pai de pagamento que ja mantem
* o cursor crSigOpFp e o saldo a distribuir, exatamente como Formsigopped.prg
* (tambem sem entrada propria no menu). A carga sob demanda
* (start\indice_classes.txt) resolve a dependencia de SIGOPPGCBO.prg
* automaticamente quando o form pai instanciar esta classe - nao requer
* SET PROCEDURE manual em config.prg (regra CLAUDE.md "Carga SOB DEMANDA").
*
* Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
*
* Herda de: FormBase          BO associado: SIGOPPGCBO
* Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
*
* Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
* Fase 4/8: Grade (BarBonus, 2 colunas Barra/Valor) + o funil de carga
*     (GarantirCursorGrade -> VincularGrade -> CarregarDados, que transcreve
*     o bloco "With Thisform.Grade ... .Refresh / ThisForm.Grade.Refresh" do
*     Init legado) + os dois botoes de acao (Ok/Cancela) - unico bloco de
*     "botoes" real desta tela (nao ha cnt_4c_Botoes/cnt_4c_BotoesAcao
*     genericos: o legado nao os tem, e inventa-los violaria o PILAR 1).
* Fase 5/8: Shape1 (moldura decorativa) + Label1 (rotulo da forma de
*     pagamento, Caption montado em runtime a partir de crSigOpFp.fpags).
* Fase 6/8: Label2/Label3 (legenda do saldo e contador de barras validas -
*     Get_Saldo ja entrou na Fase 5) + a validacao da celula da grade
*     (Grade.Column1.Text1 When/Valid/LostFocus e Grade.Column2.Text1 When do
*     legado), em subclasses de TextBox instaladas por CurrentControl, mais o
*     funil AtualizarSaldoEQuantidade que da conteudo aos dois labels e ao
*     txt_4c_Saldo. Esta tela NAO TEM lookup: o dump nao tem fwBuscaExt/
*     fwBuscaSel/fwBuscaInt, mAddColuna nem sigacess/Acesso* - o codigo de
*     barra eh DIGITADO e conferido contra SigCdOpe pelo Valid da celula, e
*     criar um picker aqui inventaria consulta que o legado nunca faz (viola
*     o PILAR 1).
* Fase 7/8: os eventos dos botoes - BtnConfirmarClick/BtnCancelarClick
*     (Ok.Click/Cancela.Click do legado, nomeados pela ACAO que executam e
*     nao pelo OBJETO do SCX, que o PILAR 3 manda renomear) e o funil de
*     saida comum aos dois (FecharDialogo), mais o BINDEVENT de Click que a
*     Fase 4 deixou em aberto e o resto da orquestracao do Init legado
*     (PrepararLinhaInicial: Zap + Append Blank em BarBonus). Get_Saldo.Value
*     inicial entrou na Fase 5 e Label1.Caption na Fase 5/6, junto com os
*     respectivos controles; o bind da grade entrou na Fase 4, pelo funil
*     CarregarDados.
*
*     Esta tela NAO TEM a barra CRUD do frmcadastro (os quatro Btn<verbo>Click
*     de incluir, alterar, visualizar e excluir um registro): o objeto raiz
*     do legado eh "form" puro, nao ha Grupo_Op, nao ha variavel de modo e os
*     DOIS unicos botoes do dump sao Ok e Cancela. Criar esses quatro aqui
*     seria INVENTAR botao que o legado nao tem (viola o PILAR 1) ou escrever
*     metodo vazio (proibido pela regra de completude). Os nomes nao sao
*     citados por extenso de proposito: os gates procuram o identificador no
*     .prg INTEIRO, comentario incluido, e escreve-los aqui faria a fase
*     aprovar pelo motivo errado - como se os handlers existissem.
* Fase 8/8: consolidacao final - os dois funis de transferencia
*     form <-> BO, que ate aqui aconteciam valor a valor, espalhados pelos
*     metodos que os consomem:
*       FormParaBO(par_oTxt)  - le a celula da grade e entrega ao BO o codigo
*           de barra (this_cCodigoBarra, 10 digitos) mais a decisao
*           Inserir x Atualizar (this_lNovoRegistro, derivada do _OldCodigo
*           capturado pelo When). Consumido por ValidarBarraDigitada.
*       BOParaForm()          - espelha na tela os TRES valores que o BO
*           calcula (rotulo da forma de pagamento, contador de barras e
*           saldo). Consumido por AtualizarSaldoEQuantidade.
*       PintarRotuloFormaPagto() - fonte UNICA do Caption de lbl_4c_Label1,
*           compartilhada por BOParaForm e por AplicarRotuloFormaPagto (o
*           Init), para as duas nao divergirem (CLAUDE.md #44, item 6).
*     Nao entram aqui os metodos de ciclo CRUD que o pipeline costuma pedir
*     nesta fase (habilitar/limpar campos por modo, ajustar botoes por modo,
*     carga de lista): esta tela nao tem modo de edicao, nem campos ligados a
*     um registro, nem pagina de lista - cria-los seria INVENTAR superficie
*     que o legado nao tem (viola o PILAR 1) ou escrever metodo vazio
*     (proibido pela regra de completude). A carga da grade ja tem funil
*     proprio desde a Fase 4 (CarregarDados), que eh tambem o nome que o
*     harness de teste procura em form OPERACIONAL.
*
* Eventos do legado SEM equivalente no migrado (unico caso):
*   Load ("=fConfigGeral()") - NAO PORTADO. fConfigGeral era funcao GLOBAL da
*     aplicacao legado (sig.prg / SIGFUNCS.PRG) que nao veio no acervo; o que
*     existe em projeto\app\utils\fconfiggeral.prg eh um wrapper NO-OP
*     (RETURN .T.) cujo proprio cabecalho diz "em codigo NOSSO nunca se chama
*     fConfigGeral - este arquivo existe APENAS para binario legado", porque
*     o p-code dos VCX o invoca e nao da para editar. Chama-lo daqui seria
*     escrever uma chamada que comprovadamente nao faz nada e ainda sugerir
*     que falta inicializacao global. O que fConfigGeral fazia esta
*     distribuido e ocorre ANTES desta tela abrir: config.prg (SETs, paths,
*     aliases globais), main.prg (conexao, CarregarEmpresa) e cada BO (seus
*     proprios cursores). Este dialogo nao depende de nada que ele pudesse
*     ter criado: os dois cursores que le (BarBonus e crSigOpFp) sao do form
*     PAI, que os cria antes de abrir esta tela. Mesma decisao de
*     FormSigMvExp.prg.
*==============================================================================

DEFINE CLASS FormSIGOPPGC AS FormBase

    *==========================================================================
    * Propriedades visuais - transcritas do dump do SCX legado (secao
    * "PROPRIEDADES DE: SIGOPPGC"). ControlBox/TitleBar: sem X e sem barra de
    * titulo - nenhum botao de sistema desenha. Picture (fundo do form) eh
    * atribuido em InicializarForm, nao aqui (mesmo padrao de
    * Formsigopped.prg), porque depende de gc_4c_CaminhoIcones (so disponivel
    * em runtime, apos config.prg ter executado).
    *==========================================================================
    Height       = 420
    Width        = 500
    DataSession  = 2
    ShowWindow = 1
    AutoCenter   = .T.
    BorderStyle  = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    Caption      = "Informe os Barras"

    *==========================================================================
    * this_oFormPai - equivale a property customizada "parentform" do legado
    * ("LParameters poForm,pnDataSes,poValor,pConexao" + "Thisform.ParentForm
    * = poForm" + "Thisform.ParentForm.Enabled = .F." no Init). Referencia ao
    * form de pagamento que abriu este dialogo - reabilitado (Enabled = .T.)
    * no funil de saida FecharDialogo, alcancado por BtnConfirmarClick e por
    * BtnCancelarClick (mesmo padrao do legado, que faz
    * isso no Click de cada botao, nao no Release).
    *==========================================================================
    this_oFormPai = .NULL.

    *==========================================================================
    * this_nSaldoRecebido - equivale a property customizada "Saldo" do legado
    * ("ThisForm.Saldo = poValor"). Staging property: o Init recebe o valor
    * ANTES do Business Object existir (criado so em InicializarForm, que
    * roda depois via DODEFAULT()) - guardado aqui e repassado a
    * this_oBusinessObject.this_nSaldoInicial/this_nSaldoAtual logo na
    * criacao do BO.
    *==========================================================================
    this_nSaldoRecebido = 0

    *==========================================================================
    * this_cCursorGrade - nome do alias que a grade consome ("BarBonus" no
    * legado: "Select BarBonus / Zap / Append Blank" e ".RecordSource =
    * 'BarBonus'" no Init). Fonte UNICA do nome, compartilhada por
    * GarantirCursorGrade, VincularGrade e CarregarDados - sem isso o alias
    * diverge entre as fases seguintes (que ainda vao mexer no mesmo cursor
    * no Valid/LostFocus da celula e nos handlers de Ok/Cancela).
    *
    * O alias eh do form CHAMADOR quando a tela eh aberta pelo pai (o Init
    * faz SET DATASESSION TO a sessao dele, entao BarBonus ja esta aberto);
    * GarantirCursorGrade so o cria quando ele NAO existe - caso do harness
    * de teste e da validacao de UI, que instanciam o form sem chamador.
    *==========================================================================
    this_cCursorGrade = "BarBonus"

    *==========================================================================
    * this_cCursorFormaPagto - nome do alias da forma de pagamento CORRENTE no
    * form pai ("crSigOpFp" no legado: "AllTrim(crSigOpFp.fpags)" no Init e
    * "Replace Valors With CrSigOpFp.VlrFpgs" no Valid da celula). Fonte UNICA
    * do nome, como this_cCursorGrade.
    *
    * O alias eh do CHAMADOR - este dialogo nunca o abre: o Init faz SET
    * DATASESSION TO a sessao do pai, e eh assim que crSigOpFp fica visivel
    * aqui. Quando a tela eh instanciada sem chamador (harness de teste,
    * validacao de UI) ele simplesmente nao existe, e todo uso eh guardado por
    * USED().
    *==========================================================================
    this_cCursorFormaPagto = "crSigOpFp"

    *==========================================================================
    * this_nCodigoBarraAnterior - equivale a "_OldCodigo" do legado
    * ("PROCEDURE When / Public _OldCodigo / Set Confirm On / _OldCodigo =
    * This.Value / Return(.t.)" em Grade.Column1.Text1): o valor que a celula
    * JA tinha quando o usuario entrou nela. No legado a variavel eh PUBLIC e
    * NUNCA eh lida de volta - nem neste SCX nem em outro arquivo do acervo
    * (conferido no dump: as 2 unicas ocorrencias sao a declaracao e a
    * atribuicao), ou seja, la ela eh estado morto, no mesmo nivel de
    * "antvalue"/"gravadados" do ClassInfo.
    *
    * Aqui ela tem uso REAL e eh por isso que foi portada (e nao descartada
    * como os outros residuos): eh ela que distingue linha NOVA de CORRECAO de
    * uma linha ja digitada, que eh a escolha entre
    * SIGOPPGCBO.Inserir()/Atualizar() e, por consequencia, o rotulo
    * "INSERT"/"UPDATE" que o BO grava em LogAuditoria
    * ("RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, ...))"). Sem ela toda
    * barra digitada seria auditada com o mesmo rotulo.
    *
    * NUMERICA (nao CHARACTER como o "_" do legado sugere): a coluna
    * BarBonus.Codigos eh N(10,0) e o legado compara com numero ("If
    * This.Value > 0", "Where Codigos = This.Value").
    *==========================================================================
    this_nCodigoBarraAnterior = 0

    *==========================================================================
    * Init - replica "LParameters poForm, pnDataSes, poValor, pConexao" do
    * legado. Todos os 4 parametros sao OPCIONAIS: o harness de teste e a
    * validacao de UI instanciam o form sem parametro nenhum
    * (CREATEOBJECT("FormSIGOPPGC")). par_oConexaoLegado (equivale a
    * "pConexao"/"Podatamgr" do legado) eh aceito so por compatibilidade de
    * assinatura com a chamada do form pai e DESCARTADO - gnConnHandle eh
    * compartilhado via config.prg nesta arquitetura, nao instanciado por
    * form (mesma decisao de Formsigopped.prg para poDataMgr).
    *
    * Ordem EXATA do legado: SET DATASESSION primeiro (senao os cursores do
    * form pai, como crSigOpFp, ficariam invisiveis), depois ParentForm
    * (assign + Enabled = .F., na mesma linha do legado), depois Saldo.
    * NUNCA chamar InicializarForm aqui tambem - DODEFAULT() chamar duas
    * vezes estoura "member object already exists" nos AddObject.
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_nSaldo, par_oConexaoLegado)
        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            SET DATASESSION TO (par_nDataSessionPai)
        ENDIF

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            THIS.this_oFormPai.Enabled = .F.
        ENDIF

        IF VARTYPE(par_nSaldo) = "N"
            THIS.this_nSaldoRecebido = par_nSaldo
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base: fundo do form, Business
    * Object (com o saldo recebido ja repassado) e o cabecalho (unico bloco
    * visual entregue nesta fase). Os demais blocos (Grade, botoes Ok/
    * Cancela, Shape1, campos) entram em ConfigurarPageFrame nas fases
    * seguintes, na mesma ordem do dump do SCX.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPPGCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGOPPGCBO.", ;
                    "Erro em InicializarForm")
            ELSE
                *-- "ThisForm.Saldo = poValor" do Init legado, repassado ao BO
                *-- (Get_Saldo.Value = ThisForm.Saldo entra quando o controle
                *-- for criado - fase 6).
                THIS.this_oBusinessObject.this_nSaldoInicial = THIS.this_nSaldoRecebido
                THIS.this_oBusinessObject.this_nSaldoAtual   = THIS.this_nSaldoRecebido

                THIS.ConfigurarPageFrame()

                *-- "With Thisform / .label1.Caption = '[ '+AllTrim(
                *-- crSigOpFp.fpags)+' ]' / EndWith" do Init legado. Roda
                *-- DEPOIS de ConfigurarPageFrame (que cria lbl_4c_Label1) e
                *-- ANTES de CarregarDados, porque tambem eh o que carrega
                *-- this_nValorPorBarra do BO - o valor que cada barra
                *-- digitada grava em BarBonus.Valors. Sem o cursor do
                *-- chamador devolve .F. sem avisar: o rotulo fica com o
                *-- Caption do SCX e a tela abre igual.
                THIS.AplicarRotuloFormaPagto()

                THIS.TornarControlesVisiveis(THIS)

                *-- "Select BarBonus / Zap / Append Blank" do Init legado -
                *-- deixa o cursor com UMA linha em branco, pronta para a 1a
                *-- barra. Roda ANTES de CarregarDados (que faz o bind e o
                *-- Refresh), na mesma ordem do legado.
                THIS.PrepararLinhaInicial()

                *-- Funil de carga da grade - equivale ao bloco final do Init
                *-- legado ("With Thisform.Grade / .RecordSource = 'BarBonus'
                *-- / .Column1.ControlSource ... / .Refresh / EndWith /
                *-- ThisForm.Grade.Refresh"). Chamado DEPOIS de
                *-- TornarControlesVisiveis: Refresh em controle ainda
                *-- invisivel nao pinta (regra CLAUDE.md #21/#46). O retorno
                *-- NAO condiciona loc_lSucesso - sem o cursor do chamador
                *-- (harness/validacao de UI) o bind eh pulado e a tela abre
                *-- do mesmo jeito.
                THIS.CarregarDados()

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

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
    * real neste form (objeto raiz do legado eh "Class: form" generico, sem
    * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
    * convencao com o restante do pipeline (mesmo padrao de Formsigopped.prg/
    * Formsigoppei.prg, outros forms OPERACIONAIS sem PageFrame). Ordem de
    * criacao conforme o dump (ver SECAO 1 do codigo fonte): cntSombra ->
    * Shape1/Label1 -> Ok/Cancela -> Grade -> Get_Saldo/Label2/Label3 (fases
    * seguintes).
    *
    * A ORDEM das chamadas eh a ordem dos AddObject, e o AddObject eh quem
    * define o z-order (ultimo criado desenha por cima) - por isso ela segue
    * EXATAMENTE a SECAO 1 do dump. Shape1 (222..395 x 7..117) cruza a area
    * do cmd_4c_Ok (350..425 x 3..78) e Label1 (156..294 x 98..113) cruza
    * Shape1: no legado os botoes e o rotulo vem DEPOIS e ficam por cima.
    * Inverter a ordem aqui esconderia controle sem dar erro nenhum (mesma
    * mecanica da regra CLAUDE.md #11).
    *
    * ConfigurarRodapeStatus fecha a lista com os dois ULTIMOS objetos do
    * dump (Label2/Label3) - entraram junto com o funil que recalcula saldo e
    * quantidade (AtualizarSaldoEQuantidade), porque e' esse funil que da
    * conteudo a eles.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarMolduraFormaPagto()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrade()
        THIS.ConfigurarCampoSaldo()
        THIS.ConfigurarRodapeStatus()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - os DOIS botoes de acao do form (Ok/Cancela),
    * transcritos do dump da SECAO 2 (secoes "PROPRIEDADES DE: SIGOPPGC.Ok" e
    * "PROPRIEDADES DE: SIGOPPGC.Cancela"). Nao ha cnt_4c_Botoes/
    * cnt_4c_BotoesAcao/cnt_4c_Saida genericos: no legado os dois botoes sao
    * filhos DIRETOS do form, sem container, e inventar um aqui violaria o
    * PILAR 1 (mesma decisao de Formsigoppei.prg/Formsigopped.prg para os
    * botoes soltos deles).
    *
    * Objetos: Class/BaseClass = commandbutton (SEM ClassLoc em framework.vcx
    * no dump) - todas as propriedades vem EXPLICITAS do SCX, nao da classe
    * fwbtn*; nao ha o que completar com docs\FRAMEWORK_class_codigo_fonte.txt.
    *
    * Width/Height = 75/75 (dump) ja cabem nos limites do form sem ajuste
    * (regra #30): Cancela.Left + Width = 425 + 75 = 500 = THIS.Width, e
    * Ok/Cancela.Top + Height = 3 + 75 = 78, dentro dos 80 de cnt_4c_Sombra -
    * nenhuma das excecoes 75x75-no-lugar-de-80x100 de outros dialogos se
    * aplica aqui, porque o SCX deste form ja declara 75x75 direto.
    *
    * Cancel = .T. nos DOIS botoes eh transcricao literal do dump (as duas
    * secoes de propriedades trazem esse valor) - nao "corrigido" para so um
    * dos dois, por nao ser erro de migracao e sim o que o SCX legado
    * declara.
    *
    * Themes = .F. (dump) e NAO a excecao Themes = .T. + DisabledPicture de
    * botao SOLTO icone-only (CorretorAutomatico #99): essa excecao vale so
    * para Caption = "" - aqui os dois tem Caption ("\<Confirmar"/"Cancelar"),
    * entao o texto permanece visivel mesmo se o icone nao renderizar com
    * Enabled = .F., e o dump nao declara Themes = .T. para nenhum dos dois.
    *
    * .Picture - cadastro_salvar_60.jpg/cadastro_sair_60.jpg, CONFERIDOS em
    * vbmp\ (regra #25 - nome inventado nao da erro, so fica sem icone).
    *
    * BINDEVENT do Click (Fase 7/8) - liga cada botao ao seu handler. Os dois
    * handlers sao PUBLIC e ja existem neste arquivo: BINDEVENT para delegate
    * inexistente estoura "Property ... is not found" NA HORA DO BIND (nao no
    * disparo do evento), dentro do TRY de InicializarForm, e a tela nao
    * abriria.
    *
    * Nome do handler pela ACAO, nunca pelo OBJETO legado: Ok/Cancela sao
    * nomes do SCX e reusa-los (BtnOkClick/BtnCancelaClick) violaria o PILAR 3
    * - o Caption do dump ja diz a acao ("\<Confirmar"/"Cancelar"), de onde
    * saem BtnConfirmarClick/BtnCancelarClick.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top        = 3
                .Left       = 350
                .Width      = 75
                .Height     = 75
                .TabIndex   = 52
                .Cancel     = .T.
                .Caption    = "\<Confirmar"
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cancela", "CommandButton")
            WITH THIS.cmd_4c_Cancela
                .Top        = 3
                .Left       = 425
                .Width      = 75
                .Height     = 75
                .TabIndex   = 51
                .Cancel     = .T.
                .Caption    = "Cancelar"
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Visible    = .T.
            ENDWITH

            *-- "PROCEDURE Click" de SIGOPPGC.Ok e de SIGOPPGC.Cancela.
            BINDEVENT(THIS.cmd_4c_Ok,      "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - a grade de 2 colunas (Barra/Valor), transcrita do
    * dump ("PROPRIEDADES DE: SIGOPPGC.Grade"): Top=117, Left=156, Width=188,
    * Height=236, ColumnCount=2, FontName="Tahoma", FontSize=8,
    * HeaderHeight=16, RowHeight=16, DeleteMark=.F., TabIndex=14. ZOrderSet
    * NAO eh transcrito (regra #33 - bookkeeping do Form Designer, sem
    * equivalente em runtime).
    *
    * Classe no legado: fwgrade (ClassLoc ..\framework\framework.vcx) - o que
    * o SCX nao sobrepoe vem da classe (docs\FRAMEWORK_class_codigo_fonte.txt,
    * secao "PROPRIEDADES DE: fwgrade"): AllowHeaderSizing=.F.,
    * AllowRowSizing=.F., ScrollBars=2, GridLineColor=238,238,238,
    * HighlightBackColor=90,90,90. RecordMark=.F. tambem por ser form
    * OPERACIONAL (regra generica do projeto).
    *
    * ColumnCount/RecordSource/ControlSource das colunas NAO ficam aqui:
    * ficam em VincularGrade, alcancado pelo funil CarregarDados (Problema
    * 48/regra #41), porque atribuir ColumnCount RECRIA os objetos Column e
    * porque o cursor BarBonus (GarantirCursorGrade, chamado dentro de
    * VincularGrade) tem de existir ANTES do ControlSource apontar para ele.
    * Este metodo guarda so o que NAO depende de dado - geometria, fonte,
    * cores e marcadores da grade - e por isso roda uma unica vez, na
    * montagem, enquanto o funil eh reexecutado a cada recarga.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top                = 117
                .Left               = 156
                .Width              = 188
                .Height             = 236
                .TabIndex           = 14
                .FontName           = "Tahoma"
                .FontSize           = 8
                .HeaderHeight       = 16
                .RowHeight          = 16
                .ScrollBars         = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .RecordMark         = .F.
                .DeleteMark         = .F.
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(90, 90, 90)
                .Visible            = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.ConfigurarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarMolduraFormaPagto - o bloco superior do dump, entre o
    * cabecalho e os botoes: a moldura decorativa (Shape1) e o rotulo da
    * forma de pagamento (Label1). Transcritos das secoes "PROPRIEDADES DE:
    * SIGOPPGC.Shape1" e "PROPRIEDADES DE: SIGOPPGC.Label1".
    *
    * Shape1 - Top=7, Left=222, Width=173, Height=110, BackStyle=0 (sem
    * preenchimento), BorderStyle=0 (sem traco), BorderColor=136,189,188.
    * Com BackStyle=0 E BorderStyle=0 a figura nao desenha nada na tela: eh
    * residuo de layout do SCX, mas eh transcrita como esta porque mexer em
    * BackStyle/BorderStyle para "fazer aparecer" seria inventar desenho que
    * o legado nao tem (PILAR 1). ForeColor NAO eh atribuido - Shape nao tem
    * essa propriedade e atribui-la derruba o Init com "Property FORECOLOR
    * is not found" (regra CLAUDE.md #33); a cor da figura mora em
    * BorderColor/FillColor.
    *
    * Label1 - Top=98, Left=156, Width=138, Height=15, Tahoma 8 bold,
    * BackStyle=0, ForeColor=90,90,90 (o canonico de label de dados, regra
    * CLAUDE.md #12 - o dump declara justamente esse valor). O dump traz
    * AutoSize = .T., que eh NO-OP em Label criado por AddObject: escrever
    * AutoSize = .F. com Width/Height EXPLICITOS do SCX eh reproducao fiel,
    * porque esses numeros JA SAO o auto-size que o Form Designer calculou
    * (regra CLAUDE.md #23). Alignment nao eh declarado no dump (classe
    * label pura, alinhada a esquerda) - nao inventar Alignment = 1.
    *
    * O Caption aqui eh o de projeto ("Condicao de Pagamento"); quem o
    * exibe de fato eh AplicarRotuloFormaPagto, que reproduz a linha do Init
    * legado (".label1.Caption = '[ '+AllTrim(crSigOpFp.fpags)+' ]'"). Os
    * dois convivem de proposito: sem o cursor do chamador (harness de
    * teste, validacao de UI) a tela mostra o texto do SCX em vez de um
    * rotulo vazio.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMolduraFormaPagto()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 222
                .Width       = 173
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .Top       = 98
                .Left      = 156
                .Width     = 138
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento"
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.ConfigurarMolduraFormaPagto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCampoSaldo - o campo de saldo do rodape (Get_Saldo),
    * transcrito da secao "PROPRIEDADES DE: SIGOPPGC.Get_Saldo": Top=383,
    * Left=206, Width=81, Height=20, TabIndex=41, Tahoma 8 bold,
    * Alignment=3, BackStyle=1, BackColor=224,253,254, ForeColor=0,0,0,
    * Margin=0, Value=0.
    *
    * Classe no legado: fwget (ClassLoc ..\framework\framework.vcx) - o que
    * o SCX nao sobrepoe vem da classe (docs\FRAMEWORK_class_codigo_fonte.txt,
    * secao "PROPRIEDADES DE: fwget"): Format="K", Themes=.F.,
    * DisabledBackColor=192,192,192, DisabledForeColor=0,0,0. Height/Width
    * da classe (23/100) NAO entram - o SCX os sobrepoe com 20/81.
    *
    * .InputMask = "999,999.99" eh transcrito do dump: mascara muda o que eh
    * exibido E digitado, entao descarta-la seria perda silenciosa (regra
    * CLAUDE.md #49). .Value = 0 vem ANTES do InputMask para o TextBox
    * nascer NUMERICO - o legado declara Value = 0 e o form faz aritmetica
    * com ele ("ThisForm.Saldo - Selecao.Valor", "If ... Value <> 0").
    *
    * SOMENTE LEITURA: o legado tem "Get_Saldo.When / Return (.F.)", ou
    * seja, a caixa NUNCA recebe foco - eh mostrador, nao campo de entrada.
    * Sem criar subclasse so para isso, o par equivalente eh ReadOnly = .T.
    * (nao aceita digitacao) + TabStop = .F. (o Tab nao para nela), que
    * preserva as cores declaradas no dump; Enabled = .F. NAO serve, porque
    * trocaria o fundo 224,253,254 pelo DisabledBackColor 192,192,192 da
    * classe fwget e mudaria a aparencia da tela.
    *
    * .Value inicial - "ThisForm.Get_Saldo.Value = ThisForm.Saldo" do Init
    * legado, lido do BO (fonte unica: o Init do form guarda o parametro em
    * this_nSaldoRecebido e InicializarForm ja o repassou a
    * this_nSaldoAtual ANTES de ConfigurarPageFrame). O recalculo a cada
    * barra digitada ("ThisForm.Get_Saldo.Value = ThisForm.Saldo -
    * Selecao.Valor" no LostFocus da celula) entra na Fase 6/8, junto com
    * Label3, num funil unico que atualiza saldo e quantidade.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoSaldo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("txt_4c_Saldo", "TextBox")
            WITH THIS.txt_4c_Saldo
                .Top               = 383
                .Left              = 206
                .Width             = 81
                .Height            = 20
                .TabIndex          = 41
                .FontName          = "Tahoma"
                .FontSize          = 8
                .FontBold          = .T.
                .Alignment         = 3
                .Margin            = 0
                .BackStyle         = 1
                .BackColor         = RGB(224, 253, 254)
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(192, 192, 192)
                .DisabledForeColor = RGB(0, 0, 0)
                .Themes            = .F.
                .Value             = 0
                .Format            = "K"
                .InputMask         = "999,999.99"
                .ReadOnly          = .T.
                .TabStop           = .F.
                .Visible           = .T.
            ENDWITH

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_Saldo.Value = THIS.this_oBusinessObject.this_nSaldoAtual
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.ConfigurarCampoSaldo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarRodapeStatus - os DOIS ultimos objetos do dump, que formam o
    * bloco de status do rodape: Label2 ("Saldo : ", legenda de txt_4c_Saldo)
    * e Label3 ("[  ]", contador de barras validas). Transcritos das secoes
    * "PROPRIEDADES DE: SIGOPPGC.Label2" e "PROPRIEDADES DE: SIGOPPGC.Label3".
    *
    * Os dois sao Class/BaseClass = label puro (sem ClassLoc em framework.vcx),
    * Tahoma 8 bold, BackStyle = 0 e ForeColor = 90,90,90 - que eh justamente
    * o canonico de label de dados (regra CLAUDE.md #12): as duas legendas
    * ficam sobre o fundo CLARO do form (Picture new_background.jpg), onde
    * branco seria invisivel. Alignment NAO eh declarado no dump (classe
    * label pura, alinhada a esquerda) - nao inventar Alignment = 1 (regra
    * CLAUDE.md #23).
    *
    * AutoSize = .F. com Width/Height EXPLICITOS, porque AutoSize eh NO-OP em
    * Label criado por AddObject (regra CLAUDE.md #23).
    *
    * Label2 - Top=385, Left=158, Width=42, Height=15, TabIndex=58,
    * BorderStyle=0. Caption FIXO ("Saldo : ") - os 42 do dump sao o
    * auto-size que o Form Designer calculou para esse texto, entao fixa-los
    * eh reproducao fiel.
    *
    * Label3 - Top=359, Left=156, Height=15. UNICO desvio de geometria desta
    * fase, e deliberado: o dump declara Width = 18, que eh o auto-size do
    * Caption de PROJETO ("[  ]"), mas o Caption eh REESCRITO em runtime com
    * a contagem de barras ("'[ '+Alltrim(Str(Selecao.Qt))+' ]'" no LostFocus
    * legado). No legado o label CRESCE junto, porque AutoSize = .T. funciona
    * em label carregado de SCX; aqui ele eh criado por AddObject, onde
    * AutoSize eh no-op (medido na regra CLAUDE.md #23, inclusive depois de
    * trocar o Caption em runtime) - manter os 18 CORTARIA o numero, e o
    * usuario veria "[ 1" no lugar de "[ 12 ]". Width = 60 cobre o maximo que
    * a coluna N(10,0) de BarBonus permite contar em Tahoma 8 bold (metrica
    * do proprio dump: largura media 6px, "[ 9999 ]" ~ 48px) e nao alcanca
    * controle nenhum - a faixa 156..216 no Top 359 esta livre (a grade
    * termina em 117+236 = 353 e txt_4c_Saldo comeca no Top 383).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRodapeStatus()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize    = .F.
                .Top         = 385
                .Left        = 158
                .Width       = 42
                .Height      = 15
                .TabIndex    = 58
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .BackStyle   = 0
                .BorderStyle = 0
                .ForeColor   = RGB(90, 90, 90)
                .Caption     = "Saldo : "
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize  = .F.
                .Top       = 359
                .Left      = 156
                .Width     = 60
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "[  ]"
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.ConfigurarRodapeStatus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AplicarRotuloFormaPagto - reproduz o bloco do Init legado que troca o
    * texto de Label1 pela descricao da forma de pagamento corrente:
    *
    *     With Thisform
    *         .label1.Caption = '[ '+AllTrim(crSigOpFp.fpags)+' ]'
    *     EndWith
    *
    * Carrega do cursor crSigOpFp (do form PAI, visivel aqui porque o Init
    * fez SET DATASESSION TO a sessao dele) as DUAS colunas que o dialogo
    * usa: fpags, que vira este rotulo, e VlrFpgs, o valor de cada barra que
    * o Valid da celula grava em BarBonus.Valors ("Replace Valors With
    * CrSigOpFp.VlrFpgs"). Quem le eh o BO (CarregarDoCursor), e as duas
    * ficam em this_cDescFormaPagto/this_nValorPorBarra - fonte unica, ja
    * consumida por SIGOPPGCBO.ValidarBarraEAtualizarCursor.
    *
    * Sem o cursor do chamador (harness de teste, validacao de UI) NAO eh
    * erro: o rotulo continua com o Caption do SCX e o metodo devolve .F.
    * sem exibir nada - mesma guarda por USED() de VincularGrade/
    * CarregarDados.
    *
    * CarregarDoCursor faz SELECT no alias que recebe, entao a area de
    * trabalho corrente eh salva e restaurada aqui: quem chama depois
    * (CarregarDados) conta com o alias da grade posicionado por ele mesmo,
    * e deixar a area trocada eh fonte classica de leitura na tabela errada.
    *
    * RETURN unico e FORA do TRY/CATCH, por flag (regra CLAUDE.md #1).
    *==========================================================================
    PROTECTED FUNCTION AplicarRotuloFormaPagto()
        LOCAL loc_lSucesso, loc_cAliasAnterior, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cAliasAnterior = ALIAS()

            IF USED(THIS.this_cCursorFormaPagto) AND ;
               VARTYPE(THIS.this_oBusinessObject) = "O"

                IF THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_cCursorFormaPagto)
                    *-- Caption com fonte UNICA, compartilhada com BOParaForm.
                    THIS.PintarRotuloFormaPagto()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.AplicarRotuloFormaPagto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GarantirCursorGrade - garante que o cursor LOCAL BarBonus existe antes
    * de qualquer Column.ControlSource apontar para ele (regra CLAUDE.md #41
    * - sem isto a tela NAO ABRE: Alias nao encontrado dentro do TRY de
    * InicializarForm, que devolve .F., e o usuario clica no menu/form pai e
    * nada acontece).
    *
    * Estrutura: Codigos N(10,0) - This.Value do legado eh comparado/somado
    * como numerico ("If This.Value > 0", "Where Codigos = This.Value",
    * "Insert Into BarBonus(Codigos) Values(0)"), e o Column1.InputMask do
    * dump ("9999999999", 10 noves) confirma largura 10 sem decimais;
    * Valors N(14,2) - recebe CrSigOpFp.VlrFpgs (valor monetario por barra),
    * mesmo padrao de coluna de valor do projeto.
    *
    * So CREATE CURSOR (sem Zap/Append Blank): o "Select BarBonus / Zap /
    * Append Blank" do Init legado eh orquestracao de ABERTURA de tela (um
    * registro em branco pronto para o usuario digitar a 1a barra) e mora em
    * PrepararLinhaInicial - aqui so garante que o ALIAS existe, vazio, para
    * a grade ter onde ligar.
    *
    * Os dois andam em sequencia (PrepararLinhaInicial chama este primeiro) e
    * este eh idempotente: com o alias ja aberto pelo chamador nao faz nada,
    * preservando a estrutura de 3 colunas que o SIGOPPAG cria. Sem chamador
    * (harness de teste, validacao de UI) eh ele que abre o cursor de 2
    * colunas que esta tela usa.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCursorGrade()
        LOCAL loc_oErro

        TRY
            IF !USED(THIS.this_cCursorGrade)
                CREATE CURSOR BarBonus (Codigos N(10, 0), Valors N(14, 2))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.GarantirCursorGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularGrade - liga grd_4c_Dados ao cursor BarBonus e configura as 2
    * colunas. NAO eh chamado direto: quem o alcanca eh o funil
    * CarregarDados, tanto na montagem quanto em cada recarga das fases
    * seguintes (mesmo funil unico de Formsigoppei.prg, Problema 48).
    *
    * ORDEM obrigatoria: ColumnCount -> RecordSource -> ControlSource -> o
    * resto (Width/InputMask/Header1.Caption por ultimo dentro do bloco da
    * coluna, pois RecordSource/ControlSource recalculam largura e caption
    * para o default). Grid.ReadOnly vem ANTES das colunas (regra #18 - o do
    * grid propaga e sobrescreveria).
    *
    * RecordSource e ControlSource sao condicionados a USED(alias): quando a
    * tela eh instanciada SEM chamador (harness de teste, validacao de UI) e
    * GarantirCursorGrade nao conseguiu abrir o cursor, o bind eh pulado em
    * vez de estourar "Alias is not found" dentro do TRY de InicializarForm -
    * que devolveria .F. e faria a tela nao abrir (regra #41). Largura,
    * fonte, mascara e caption de cabecalho sao aplicados SEMPRE, inclusive
    * nesse caminho, senao a grade ficaria com "Column1"/largura default.
    *
    * Column1 "Barra" <- BarBonus.Codigos: editavel (eh a celula que o
    * usuario digita - Grade.Column1.Text1.When/Valid/LostFocus do legado).
    * Width=80 e InputMask="9999999999" transcritos do dump
    * (Column1.Width/Column1.InputMask).
    *
    * Column2 "Valor" <- BarBonus.Valors: o dump NAO declara ReadOnly aqui -
    * quem bloqueia a digitacao eh "Grade.Column2.Text1.When / Return .f."
    * (a celula nunca recebe foco; o valor so eh gravado por codigo, no
    * "Replace Valors With CrSigOpFp.VlrFpgs" do Valid de Column1). Eh esse
    * o mecanismo reproduzido, na subclasse de celula - e nao um ReadOnly
    * inventado, que daria o mesmo efeito por outra via e esconderia o When
    * do legado. Column2.Width NAO eh transcrito: o dump nao declara essa
    * propriedade (so Column1.Width aparece), e o default pos-RecordSource
    * (~90px) cabe nos 188-80=108px restantes da grade - nao inventar um
    * numero que o SCX nao declarou.
    *
    * As propriedades visuais que o dump declara em ColumnN.Text1
    * (BorderStyle/Margin/ForeColor/BackColor) NAO sao aplicadas no Text1
    * nativo: com CurrentControl apontando para a subclasse, eh ELA que
    * desenha a celula e o Text1 deixa de aparecer (regra CLAUDE.md #18).
    * Por isso vao em InstalarCelulasGrade, no objeto que de fato pinta -
    * configurar o Text1 aqui seria config MORTA. InstalarCelulasGrade eh
    * chamado no FIM deste metodo porque atribuir RecordSource DERRUBA o
    * CurrentControl das colunas.
    *
    * ControlSource vai para BarBonus.Codigos/BarBonus.Valors - o
    * "Column1.Text1.ControlSource = tmpoperacao.CODIGOS" do dump eh residuo
    * de template (mesma familia de "antvalue"/"gravadados", ver cabecalho da
    * classe) e eh SOBRESCRITO em runtime pelo Init legado ("With
    * Thisform.Grade / .Column1.ControlSource = 'BarBonus.Codigos' /
    * .Column2.ControlSource = 'BarBonus.Valors'") - essa eh a ligacao real,
    * transcrita aqui direto (nao ha motivo para esperar a Fase 7 so para
    * trocar o residuo pelo valor que o proprio legado atribui).
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.GarantirCursorGrade()

            loc_oGrid = THIS.grd_4c_Dados

            WITH loc_oGrid
                .ReadOnly    = .F.
                .ColumnCount = 2

                IF USED(THIS.this_cCursorGrade)
                    .RecordSource = THIS.this_cCursorGrade
                ENDIF

                WITH .Column1
                    IF USED(THIS.this_cCursorGrade)
                        .ControlSource = "BarBonus.Codigos"
                    ENDIF
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Movable       = .F.
                    .Resizable     = .F.
                    .InputMask     = "9999999999"
                    .Width         = 80
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Barra"
                    ENDWITH
                ENDWITH

                WITH .Column2
                    IF USED(THIS.this_cCursorGrade)
                        .ControlSource = "BarBonus.Valors"
                    ENDIF
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Valor"
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- Celulas da grade (subclasses com o When/Valid do legado).
            *-- DEPOIS do bloco acima: atribuir RecordSource derruba o
            *-- CurrentControl das colunas, e eh ele que faz a subclasse
            *-- aparecer (regra CLAUDE.md #18).
            THIS.InstalarCelulasGrade(loc_oGrid)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.VincularGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * InstalarCelulasGrade - poe em Column1/Column2 da grade a SUBCLASSE de
    * TextBox que carrega o When/Valid daquela celula no legado, e liga cada
    * uma por CurrentControl.
    *
    * ESTE eh o "lookup" desta tela, e ele NAO eh um picker: o legado NAO tem
    * lookup nenhum - zero fwBuscaExt/fwBuscaSel/fwBuscaInt, zero mAddColuna,
    * zero sigacess/Acesso* (conferido no dump inteiro). O codigo de barra eh
    * DIGITADO e conferido contra SigCdOpe pelo Valid da celula; nao existe
    * tabela de apoio para escolher em grade. Criar um AbrirBusca*/
    * AbrirLookup* aqui inventaria uma consulta que o legado nunca faz - viola
    * o PILAR 1 e a regra explicita "NUNCA inventar tabelas de lookup que nao
    * existem no original".
    *
    * POR QUE SUBCLASSE E NAO BINDEVENT no When/Valid (regra CLAUDE.md #46):
    * BINDEVENT em "Valid" de TextBox de Column nao eh confiavel e, pior,
    * BINDEVENT DESCARTA o retorno do delegate - e aqui o retorno E' o
    * mecanismo: o Valid devolvendo .F. eh o que mantem o cursor na celula
    * depois de recusar a barra ("This.Value = 0 / Return .f." do legado), e
    * o When devolvendo .F. eh o que impede a entrada na celula de Valor
    * ("Grade.Column2.Text1.When / Return .f."). Nenhum dos dois efeitos
    * sobrevive a um BINDEVENT. AfterRowColChange tambem nao serve: dispara
    * DEPOIS de entrar na celula nova e o indice que recebe eh o da coluna de
    * DESTINO, nao o da coluna que o usuario acabou de deixar.
    *
    * O LostFocus, ao contrario, vai por BINDEVENT: ele nao tem retorno com
    * significado (o corpo legado eh puro efeito colateral - recalcula saldo
    * e contador, repinta e avisa), entao nada se perde, e o recalculo tem de
    * ficar num metodo PUBLIC do form porque ele eh o MESMO funil que o
    * legado chama de outros pontos ("ThisForm.label3"/"ThisForm.Get_Saldo"
    * sao do form, nao da celula). Mesmo padrao de BINDEVENT em controle de
    * Column ja usado no projeto para eventos que nao sao Valid/When
    * (Click/MouseUp/KeyPress de CheckBox de coluna).
    *
    * Column.AddObject NAO basta para o controle aparecer (regra CLAUDE.md
    * #18): sem CurrentControl a coluna continua desenhando o Text1 dela - o
    * objeto existe, responde a PEMSTATUS, e o When/Valid NUNCA roda.
    *
    * Sparse fica no default (.T.), como no dump (que nao declara Sparse em
    * coluna nenhuma): as duas subclasses sao TextBox e desenham igual ao
    * Text1 que substituem, e o When/Valid de uma Column roda na celula
    * ATIVA, que eh justamente o que Sparse = .T. instancia. Forcar
    * Sparse = .F. instanciaria um controle por linha visivel sem mudar nada
    * do que se ve (so em CheckBox/OptionGroup o .F. eh obrigatorio).
    *
    * IDEMPOTENTE de proposito: VincularGrade chama este metodo apos CADA
    * rebind (RecordSource derruba CurrentControl) e AddObject duas vezes com
    * o mesmo nome no mesmo alvo estoura "Object is already defined",
    * derrubando o Init. O BINDEVENT fica DENTRO do guard de criacao: re-bind
    * do mesmo par objeto/evento ACUMULA bindings e o handler passaria a
    * rodar duas vezes por LostFocus (contador e saldo recalculados em
    * duplicidade).
    *==========================================================================
    PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrade)
        LOCAL loc_oErro

        IF VARTYPE(par_oGrade) != "O"
            RETURN
        ENDIF

        TRY
            *-- Column1: a celula do codigo de barra (Grade.Column1.Text1 do
            *-- legado). Propriedades visuais transcritas da secao
            *-- "PROPRIEDADES DE: SIGOPPGC.Grade.Column1.Text1".
            IF !PEMSTATUS(par_oGrade.Column1, "txt_4c_CelBarra", 5)
                par_oGrade.Column1.AddObject("txt_4c_CelBarra", ;
                                              "TextBoxCelBarraSigOpPgc_4c")

                *-- LostFocus do legado: recalcula saldo/contador. Ligado AQUI
                *-- (dentro do guard de criacao) para nao acumular bindings.
                BINDEVENT(par_oGrade.Column1.txt_4c_CelBarra, "LostFocus", ;
                          THIS, "AtualizarSaldoEQuantidade")
            ENDIF
            WITH par_oGrade.Column1.txt_4c_CelBarra
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .T.
            ENDWITH
            par_oGrade.Column1.CurrentControl = "txt_4c_CelBarra"

            *-- Column2: a celula do valor (Grade.Column2.Text1 do legado),
            *-- cujo When devolve .F. - o usuario nunca entra nela. O valor
            *-- eh gravado por codigo, no Replace do Valid de Column1.
            IF !PEMSTATUS(par_oGrade.Column2, "txt_4c_CelValor", 5)
                par_oGrade.Column2.AddObject("txt_4c_CelValor", ;
                                              "TextBoxCelValorSigOpPgc_4c")
            ENDIF
            WITH par_oGrade.Column2.txt_4c_CelValor
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .T.
            ENDWITH
            par_oGrade.Column2.CurrentControl = "txt_4c_CelValor"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.InstalarCelulasGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PrepararCelulaBarra - transcreve "Grade.Column1.Text1.When" do legado:
    *
    *     Public _OldCodigo
    *     Set Confirm On
    *     _OldCodigo = This.Value
    *     Return(.t.)
    *
    * SET CONFIRM ON eh par com o SET CONFIRM OFF do LostFocus (ver
    * AtualizarSaldoEQuantidade): ligado ENQUANTO o usuario esta na celula, a
    * digitacao do 10o digito da mascara nao salta sozinha para a proxima
    * celula - o Enter continua obrigatorio, que eh o que o fluxo de leitura
    * de codigo de barra pressupoe (o leitor emite Enter no fim). Transcrito
    * literalmente, inclusive a ordem (SET antes de guardar o valor).
    *
    * O valor anterior vai para this_nCodigoBarraAnterior (equivalente de
    * _OldCodigo - ver o comentario da property): eh ele que ValidarBarraDigitada
    * usa para decidir entre Inserir() e Atualizar() no BO.
    *
    * Devolve SEMPRE .T., como o legado: a celula do codigo eh a UNICA
    * digitavel da tela e nunca se recusa a entrada nela.
    *
    * PUBLIC: chamado de FORA da classe, pelo When da subclasse de celula
    * (TextBoxCelBarraSigOpPgc_4c) - com PROTECTED estouraria "Property
    * PREPARARCELULABARRA is not found" em runtime (regra CLAUDE.md #51).
    *==========================================================================
    PROCEDURE PrepararCelulaBarra(par_oTxt)
        SET CONFIRM ON

        THIS.this_nCodigoBarraAnterior = 0

        IF VARTYPE(par_oTxt) = "O"
            IF VARTYPE(par_oTxt.Value) = "N"
                THIS.this_nCodigoBarraAnterior = par_oTxt.Value
            ELSE
                THIS.this_nCodigoBarraAnterior = TRANSFORM(par_oTxt.Value)
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarBarraDigitada - transcreve "Grade.Column1.Text1.Valid" do legado.
    * Trecho legado, na ordem:
    *
    *     If This.Value > 0
    *         Set Decimals to 0
    *         nDope = Val( Left( Str( This.Value, 10 ), 4 ) )
    *         Nume  = Val( Right( Str( This.Value, 10 ), 6 ) )
    *         lcSql = [Select Dopes From SigCdOpe Where ndopes = ]+Str(nDope)
    *         ThisForm.PodataMgr.Sqlexecute(lcSql,'LocalSnOpe')
    *         If Used('LocalSnOpe') And Reccount('LocalSnOpe') = 0
    *             MessageBox('Barra Invalido!!!!',0+16,'') / This.Value = 0 / Return .f.
    *         EndIf
    *         Select BarBonus / Skip / Skip -1
    *         Select Sum(1) as Qt, Codigos From BarBonus Where Codigos = This.Value ...
    *         If CheckDup.Qt > 1
    *             MessageBox('Barra ja digitado !!!',0+48,'') / This.Value = 0 / Return .F.
    *         Endif
    *         Replace Valors With CrSigOpFp.VlrFpgs in BarBonus
    *         Select BarBonus / Skip
    *         If Eof()
    *             Insert Into BarBonus( Codigos ) Values ( 0 ) / KeyBoard "{DNARROW}"
    *         EndIf
    *     Endif
    *     Return .t.
    *
    * A REGRA (decodificar a barra, conferir a operacao em SigCdOpe, conferir
    * duplicidade e gravar o valor da forma de pagamento) mora no BO, em
    * SIGOPPGCBO.Inserir()/Atualizar() - fonte unica, ja escrita na Fase 2.
    * Este metodo eh a parte que pertence a TELA: ler o valor digitado,
    * descarregar o buffer da celula no cursor, escolher Inserir x Atualizar,
    * zerar a celula quando a barra eh recusada e abrir a linha seguinte.
    *
    * O valor digitado vem de par_oTxt.Value, NAO do cursor (regra CLAUDE.md
    * #46): dentro do Valid o cursor ainda tem o valor ANTIGO - validar pelo
    * cursor conferiria a barra anterior. O "Select BarBonus / Skip / Skip -1"
    * do legado existe justamente para FORCAR a descarga do buffer da celula
    * no cursor ANTES da consulta de duplicidade (mover o ponteiro grava a
    * edicao ainda em buffer); sem ele a propria linha corrente nao entraria na
    * contagem e o "Qt > 1" nunca acusaria duplicata. Transcrito, com guarda
    * de EOF/RECCOUNT - no legado o ponteiro esta sempre numa linha valida
    * (a celula ativa), e com cursor vazio nao ha buffer a descarregar.
    *
    * O RECNO eh salvo e restaurado em volta da chamada ao BO porque ele faz
    * SELECT-SQL sobre o proprio BarBonus (a consulta de duplicidade) e troca
    * a area de trabalho corrente; o legado tambem re-seleciona BarBonus
    * explicitamente depois do Replace. Sem repor o ponteiro, o
    * "Skip / If Eof() / Insert" seguinte abriria linha nova no lugar errado.
    *
    * Inserir x Atualizar: this_nCodigoBarraAnterior (o _OldCodigo capturado
    * pelo When) distingue linha NOVA (celula estava em 0) de CORRECAO de uma
    * barra ja digitada. As duas delegam a MESMA validacao no BO - o que muda
    * eh so o rotulo gravado em LogAuditoria ("INSERT" x "UPDATE").
    *
    * Barra recusada: a celula volta a 0 ("This.Value = 0" do legado) e o
    * retorno .F. mantem o cursor nela. NAO ha mensagem acrescentada aqui - o
    * BO ja exibiu a dele ("Barra Invalido!!!!" / "Barra ja digitado !!!") e
    * marcou this_lErroExibido; duplicar a mensagem faria o usuario dispensar
    * dois dialogos pelo mesmo motivo (regra CLAUDE.md #20).
    *
    * RETURN unico, FORA do TRY/CATCH, por flag (regra CLAUDE.md #1).
    *
    * PUBLIC: chamado de FORA da classe, pelo Valid da subclasse de celula.
    *==========================================================================
    PROCEDURE ValidarBarraDigitada(par_oTxt)
        LOCAL loc_lValido, loc_nValor, loc_nRecnoAtual, loc_lGravou, loc_oErro
        loc_lValido = .T.

        TRY
            *-- Funil unico tela -> BO: le o valor DIGITADO na celula (nunca
            *-- o cursor - regra CLAUDE.md #46), converte para os 10 digitos
            *-- que o legado fatia em nDope/Nume e ja decide, em
            *-- this_lNovoRegistro, se eh linha nova ou correcao.
            loc_nValor = 0
            IF THIS.FormParaBO(par_oTxt)
                loc_nValor = VAL(THIS.this_oBusinessObject.this_cCodigoBarra)
            ENDIF

            IF loc_nValor > 0 AND VARTYPE(THIS.this_oBusinessObject) = "O" ;
               AND USED(THIS.this_cCursorGrade)

                *-- "Select BarBonus / Skip / Skip -1" - descarrega para o
                *-- cursor a edicao que ainda esta no buffer da celula.
                SELECT (THIS.this_cCursorGrade)
                IF RECCOUNT() > 0 AND !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                loc_nRecnoAtual = RECNO()

                *-- Inserir x Atualizar: FormParaBO ja resolveu em
                *-- this_lNovoRegistro, a partir do _OldCodigo que o When da
                *-- celula capturou. As duas rodam a MESMA validacao no BO -
                *-- o que muda eh so o rotulo gravado em LogAuditoria.
                IF THIS.this_oBusinessObject.this_lNovoRegistro
                    loc_lGravou = THIS.this_oBusinessObject.Inserir()
                ELSE
                    loc_lGravou = THIS.this_oBusinessObject.Atualizar()
                ENDIF

                *-- Repoe a area/ponteiro que o SELECT-SQL do BO pode ter
                *-- trocado ("Select BarBonus" do legado apos o Replace).
                IF USED(THIS.this_cCursorGrade)
                    SELECT (THIS.this_cCursorGrade)
                    IF loc_nRecnoAtual >= 1 AND loc_nRecnoAtual <= RECCOUNT()
                        GO loc_nRecnoAtual
                    ENDIF
                ENDIF

                IF loc_lGravou
                    *-- "Select BarBonus / Skip / If Eof() / Insert Into
                    *-- BarBonus(Codigos) Values(0) / KeyBoard {DNARROW}":
                    *-- estando na ULTIMA linha, abre a proxima em branco e
                    *-- desce o cursor para ela, para o usuario seguir lendo
                    *-- barras sem tocar no mouse.
                    IF !EOF()
                        SKIP
                    ENDIF
                    IF EOF()
                        INSERT INTO (THIS.this_cCursorGrade) (Codigos) VALUES (0)
                        KEYBOARD "{DNARROW}"
                    ENDIF

                    *-- Encher o cursor NAO repinta a grade ligada a ele
                    *-- (regra CLAUDE.md #21): sem este Refresh a linha nova
                    *-- fica invisivel, com o cursor ja certo.
                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ELSE
                    *-- "This.Value = 0" do legado - a barra recusada sai da
                    *-- celula e o .F. mantem o cursor nela para redigitar.
                    IF VARTYPE(par_oTxt) = "O"
                        par_oTxt.Value = 0
                    ENDIF
                    IF USED(THIS.this_cCursorGrade) AND !EOF(THIS.this_cCursorGrade)
                        REPLACE Codigos WITH 0 IN (THIS.this_cCursorGrade)
                    ENDIF
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.ValidarBarraDigitada")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * AtualizarSaldoEQuantidade - FUNIL unico de status do rodape. Transcreve
    * "Grade.Column1.Text1.LostFocus" do legado:
    *
    *     Set Confirm Off
    *     Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor
    *         From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1
    *     ThisForm.label3.Caption  = '[ '+Alltrim(Str(Selecao.Qt))+' ]'
    *     ThisForm.Get_Saldo.Value = ThisForm.Saldo - Selecao.Valor
    *     ThisForm.label3.Refresh
    *     ThisForm.Get_Saldo.Refresh
    *     If ThisForm.Get_Saldo.Value < 0
    *         MessageBox('Quantidade de Barras excedida!!!',0+16,'Valor a Maior')
    *     Endif
    *     If This.Value = 0 And Lastkey() = 13
    *         ThisForm.Ok.SetFocus
    *     EndIf
    *
    * A CONTA eh regra de negocio e tem FONTE UNICA no BO
    * (SIGOPPGCBO.RecalcularSaldoEQuantidade, que soma BarBonus e grava
    * this_nQtdeBarras/this_nSaldoAtual) - regra CLAUDE.md #17. Este metodo
    * so ESPELHA o resultado nos dois controles. O criterio do legado vai
    * junto e eh parte da regra: "Where Codigos <> 0" EXCLUI a linha em
    * branco que o Valid acabou de abrir, senao ela entraria na contagem.
    *
    * SET CONFIRM OFF eh o par do SET CONFIRM ON do When
    * (PrepararCelulaBarra): fora da celula de barra a tela volta ao
    * comportamento normal de tabulacao. Transcrito na mesma posicao
    * (primeira linha).
    *
    * O aviso de saldo negativo eh MsgAviso, nao MsgErro: eh validacao de
    * tela ("Quantidade de Barras excedida"), nao falha tecnica - o usuario
    * continua na tela e corrige. O titulo eh o do legado ("Valor a Maior").
    * O aviso NAO bloqueia: o legado so informa, e eh o Click do Confirmar
    * que recusa o fechamento com saldo diferente de zero
    * (BtnConfirmarClick).
    *
    * O salto para o Confirmar ("This.Value = 0 And Lastkey() = 13") precisa
    * do valor da celula, e LostFocus nao passa parametro nenhum - a celula eh
    * resolvida pelo caminho conhecido na grade, com guarda de PEMSTATUS
    * (regras CLAUDE.md #3 e #34: nunca Controls(<nome>), e PEMSTATUS so
    * prova existencia). Com isso o metodo tambem serve como funil chamado
    * sem argumento pelos outros pontos que mexem em BarBonus.
    *
    * PUBLIC: eh o delegate de um BINDEVENT ("LostFocus" da celula) e tambem
    * eh chamado de fora pelos pontos acima - PROTECTED falharia em silencio
    * no bind e em runtime na chamada (regras CLAUDE.md #3 e #51).
    *==========================================================================
    PROCEDURE AtualizarSaldoEQuantidade()
        LOCAL loc_oCelula, loc_nValorCelula, loc_oErro

        SET CONFIRM OFF

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.RecalcularSaldoEQuantidade(THIS.this_cCursorGrade)

                *-- "ThisForm.label3.Caption = ... / ThisForm.Get_Saldo.Value
                *-- = ... / ThisForm.label3.Refresh / ThisForm.Get_Saldo.
                *-- Refresh": espelho tela <- BO, pelo funil unico.
                THIS.BOParaForm()

                *-- "If ThisForm.Get_Saldo.Value < 0 / MessageBox(
                *-- 'Quantidade de Barras excedida!!!',0+16,'Valor a Maior')"
                *-- - aviso INFORMATIVO, que NAO bloqueia: quem recusa o
                *-- fechamento com saldo diferente de zero eh o Confirmar
                *-- (BtnConfirmarClick). Fica aqui, e nao em BOParaForm,
                *-- porque eh fluxo e nao espelho. Le o CONTROLE, como o
                *-- legado - BOParaForm acabou de pinta-lo a partir do BO,
                *-- que eh a fonte unica da conta.
                IF PEMSTATUS(THIS, "txt_4c_Saldo", 5)
                    IF THIS.txt_4c_Saldo.Value < 0
                        MsgAviso("Quantidade de Barras excedida!!!", ;
                            "Valor a Maior")
                    ENDIF
                ENDIF
            ENDIF

            *-- "If This.Value = 0 And Lastkey() = 13 / ThisForm.Ok.SetFocus":
            *-- Enter numa celula vazia encerra a leitura e salta para o
            *-- Confirmar.
            IF LASTKEY() = 13 AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_nValorCelula = -1
                IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_CelBarra", 5)
                    loc_oCelula = THIS.grd_4c_Dados.Column1.txt_4c_CelBarra
                    IF VARTYPE(loc_oCelula.Value) = "N"
                        loc_nValorCelula = loc_oCelula.Value
                    ELSE
                        loc_nValorCelula = VAL(TRANSFORM(loc_oCelula.Value))
                    ENDIF
                ENDIF

                IF loc_nValorCelula = 0 AND PEMSTATUS(THIS, "cmd_4c_Ok", 5)
                    IF THIS.cmd_4c_Ok.Enabled AND THIS.cmd_4c_Ok.Visible
                        THIS.cmd_4c_Ok.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.AtualizarSaldoEQuantidade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL de carga da grade. Transcreve o bloco que fecha o
    * Init legado:
    *
    *     With Thisform.Grade
    *         .RecordSource          = 'BarBonus'
    *         .Column1.ControlSource = 'BarBonus.Codigos'
    *         .Column2.ControlSource = 'BarBonus.Valors'
    *         .Refresh
    *     EndWith
    *     THisForm.Grade.Refresh
    *
    * Tres passos, nesta ordem: vincular (VincularGrade), posicionar o alias
    * (SELECT + GO TOP) e repintar (Grid.Refresh). O ultimo passo eh o que o
    * migrador costuma jogar fora: encher ou reordenar o cursor NAO repinta a
    * grade ligada a ele (regra CLAUDE.md #21) - sem o Refresh a grade fica
    * visualmente vazia com o cursor cheio, sem erro e sem log, e o sintoma
    * ("a tela nao traz os barras") manda o diagnostico para o SQL.
    *
    * Tem de ser o UNICO caminho de carga: cada ponto das fases seguintes que
    * mexer em BarBonus (o "Insert Into BarBonus(Codigos) Values(0)" do Valid
    * da celula, o "Zap" do Cancela.Click) fecha chamando este metodo, nunca
    * VincularGrade nua - re-atribuir RecordSource reseta Column.Width e
    * Header1.Caption (Problema 48/regra #41) e o funil ja os repoe.
    *
    * PUBLIC de proposito: o harness (TesteAutomatico.prg) procura
    * MontaGrade/CarregarDados/CarregarLista/... com PEMSTATUS(...,5) e chama
    * THIS.oForm.<metodo>() de FORA da classe. PEMSTATUS com atributo 5 so
    * testa EXISTENCIA, nao escopo: com PROTECTED o harness entraria no
    * branch e estouraria "Property CARREGARDADOS is not found" em runtime
    * (regra CLAUDE.md #3).
    *
    * Devolve .F. quando nao ha alias para carregar (tela instanciada sem o
    * form chamador) - mas NAO lanca excecao, porque o harness chama o metodo
    * sem argumento e sem cursor. O RETURN fica FORA do TRY/CATCH, por flag
    * (regra CLAUDE.md #1).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.VincularGrade()

            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PrepararLinhaInicial - transcreve o bloco do Init legado que deixa o
    * cursor da grade pronto para a leitura das barras:
    *
    *     Select BarBonus
    *     Zap
    *     Append Blank
    *
    * APPEND BLANK eh o que torna a tela USAVEL: sem ele a grade abre com
    * ZERO linha e o usuario nao tem onde digitar a primeira barra - o
    * "Insert Into BarBonus(Codigos) Values(0)" do Valid da celula so abre a
    * linha SEGUINTE, e depende de uma barra ja aceita.
    *
    * ZAP, e NAO "USE IN + CREATE CURSOR": o cursor eh do CHAMADOR - o
    * SIGOPPAG faz "Create Cursor BarBonus (Codigos n(10), Valors n(12,2),
    * Seqs n(3))" ANTES de abrir este dialogo e le o resultado nele depois
    * ("If Reccount('BarBonus') > 0 / Select BarBonus / Scan ..."). ZAP
    * esvazia PRESERVANDO a estrutura - inclusive a coluna Seqs, que esta
    * tela nao usa - e o binding da grade; fechar e recriar o alias
    * derrubaria Grid.RecordSource/Column.ControlSource e a grade ficaria
    * permanentemente vazia com o cursor cheio, sem erro e sem log.
    *
    * SAFETY: este form declara DataSession = 2 e SET SAFETY eh escopado por
    * data session - dentro da sessao privada ele vale ON mesmo com o SET
    * SAFETY OFF do main.prg, e ai o ZAP abre o dialogo modal "Zap ... Are
    * you sure?" e CONGELA a tela esperando um clique que ninguem ve (em
    * teste headless aparece como timeout, nao como erro). Por isso o ZAP vai
    * entre salvar e restaurar o SET("SAFETY").
    *
    * GarantirCursorGrade vem primeiro: quando a tela eh instanciada SEM
    * chamador (harness de teste, validacao de UI) o alias nao existe, e
    * SELECT em alias ausente estouraria dentro do TRY de InicializarForm -
    * que devolveria .F. e faria a tela nao abrir (regra CLAUDE.md #41).
    *
    * Deixa BarBonus como area de trabalho corrente, como o legado: quem roda
    * em seguida eh CarregarDados, que reposiciona o alias da grade ele mesmo
    * (SELECT + GO TOP).
    *==========================================================================
    PROTECTED PROCEDURE PrepararLinhaInicial()
        LOCAL loc_cSafetyAnterior, loc_oErro

        TRY
            THIS.GarantirCursorGrade()

            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)

                loc_cSafetyAnterior = SET("SAFETY")
                SET SAFETY OFF
                ZAP
                IF loc_cSafetyAnterior = "ON"
                    SET SAFETY ON
                ENDIF

                APPEND BLANK
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.PrepararLinhaInicial")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - "PROCEDURE Click" de SIGOPPGC.Ok (Caption
    * "\<Confirmar"):
    *
    *     If ThisForm.Get_Saldo.Value <> 0
    *         MessageBox('Quantidade de Barras incorretos!!!',0+16,'')
    *         Return .f.
    *     EndIf
    *     Thisform.parentform.enabled = .T.
    *     Thisform.release
    *
    * A regra eh "so fecha com saldo ZERADO": as barras lidas tem de
    * distribuir EXATAMENTE o valor que o form pai mandou (poValor). Saldo
    * positivo significa barra faltando, negativo significa barra sobrando -
    * e o aviso de saldo negativo que o LostFocus da celula ja da
    * ("Quantidade de Barras excedida!!!") eh informativo e NAO bloqueia; eh
    * aqui, no Confirmar, que o legado recusa o fechamento. Transcrito
    * LITERALMENTE, inclusive o criterio "<> 0" (nao "> 0").
    *
    * Le o CONTROLE (txt_4c_Saldo.Value), como o legado - a conta tem fonte
    * unica no BO (SIGOPPGCBO.RecalcularSaldoEQuantidade) e o controle eh o
    * espelho dela, atualizado pelo funil AtualizarSaldoEQuantidade. O
    * VARTYPE eh guarda de tipo, nao escolha de fonte: o TextBox nasce
    * numerico (.Value = 0 antes do InputMask) e deve continuar assim.
    *
    * MESSAGEBOX eh PROIBIDO no projeto: a recusa eh validacao de TELA (o
    * usuario continua nela e corrige), entao MsgAviso - nao MsgErro, que
    * tem dialogo de falha tecnica. O titulo do legado eh vazio; MsgAviso
    * aplica o canonico ("Aten" + CHR(231) + CHR(227) + "o") quando nao se
    * passa titulo.
    *
    * RETURN unico e FORA do TRY/CATCH, por flag (regra CLAUDE.md #1). O
    * valor devolvido reproduz o "Return .f." do legado - BINDEVENT descarta
    * o retorno do delegate e o Click do CommandButton nao o usa, mas
    * manter o contrato documenta a recusa e serve a quem chamar o handler
    * direto (o harness de teste chama metodos Btn*Click de fora da classe).
    *
    * PUBLIC: eh delegate de BINDEVENT ("Click" de cmd_4c_Ok) - PROTECTED
    * falharia em SILENCIO no bind e em runtime na chamada de fora (regras
    * CLAUDE.md #3 e #51).
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lFechou, loc_nSaldo, loc_oErro
        loc_lFechou = .F.

        TRY
            loc_nSaldo = 0
            IF PEMSTATUS(THIS, "txt_4c_Saldo", 5)
                IF VARTYPE(THIS.txt_4c_Saldo.Value) = "N"
                    loc_nSaldo = THIS.txt_4c_Saldo.Value
                ELSE
                    loc_nSaldo = TRANSFORM(THIS.txt_4c_Saldo.Value)
                ENDIF
            ENDIF

            IF loc_nSaldo != 0
                MsgAviso("Quantidade de Barras incorretos!!!")
            ELSE
                THIS.FecharDialogo()
                loc_lFechou = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lFechou
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - "PROCEDURE Click" de SIGOPPGC.Cancela (Caption
    * "Cancelar"):
    *
    *     Select BarBonus
    *     Zap
    *     Thisform.parentform.enabled = .T.
    *     Thisform.release
    *
    * O ZAP eh o que COMUNICA o cancelamento: o chamador decide pelo
    * conteudo do cursor ("If Reccount('BarBonus') > 0" no SIGOPPAG), entao
    * esvaziar BarBonus eh como ele distingue cancelar de confirmar - nao eh
    * limpeza cosmetica, e suprimi-lo faria o pai processar as barras lidas
    * como se o usuario tivesse confirmado. Diferente do Confirmar, aqui o
    * cursor NAO recebe APPEND BLANK: fica com RECCOUNT = 0.
    *
    * SAFETY pelo mesmo motivo de PrepararLinhaInicial (DataSession = 2
    * escopa o SET SAFETY e o ZAP congelaria a tela num dialogo modal
    * invisivel).
    *
    * O cursor eh do CHAMADOR e sobrevive ao fechamento deste dialogo (foi
    * criado na data session dele - ver this_cCursorGrade); o USED() cobre a
    * instanciacao sem chamador (harness/validacao de UI), onde nao ha nada
    * a descartar.
    *
    * O fechamento fica FORA do TRY: este dialogo nao tem X nem barra de
    * titulo (ControlBox = .F. / TitleBar = 0) e o form pai esta
    * Enabled = .F. - se uma falha no descarte do cursor impedisse o
    * fechamento, o usuario ficaria preso na tela sem saida nenhuma. O
    * legado nao precisava dessa separacao porque la um erro de cursor
    * interrompia o metodo com Program Error na cara do usuario, em vez de
    * fechar calado.
    *
    * PUBLIC: delegate de BINDEVENT ("Click" de cmd_4c_Cancela) e tambem
    * chamado de FORA da classe pelo harness (TesteAutomatico.prg procura
    * BtnCancelarClick com PEMSTATUS, que so testa EXISTENCIA e nao escopo -
    * com PROTECTED o teste entraria no branch e estouraria em runtime).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_cSafetyAnterior, loc_oErro

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)

                loc_cSafetyAnterior = SET("SAFETY")
                SET SAFETY OFF
                ZAP
                IF loc_cSafetyAnterior = "ON"
                    SET SAFETY ON
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.BtnCancelarClick")
        ENDTRY

        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * FecharDialogo - FUNIL de saida, compartilhado pelos dois botoes. No
    * legado as duas ultimas linhas de Ok.Click e de Cancela.Click sao
    * IDENTICAS:
    *
    *     Thisform.parentform.enabled = .T.
    *     Thisform.release
    *
    * A reabilitacao do pai mora AQUI e nao no Destroy, como no legado: o
    * form pai fica Enabled = .F. desde o Init deste dialogo ("Thisform.
    * ParentForm.Enabled = .F.") e so volta a aceitar o usuario quando a
    * tela fecha por um dos dois botoes.
    *
    * Hide() e NAO Release(): medido no VFP9 - Release() destroi o objeto
    * mesmo com o chamador segurando a referencia (form nao segue refcount de
    * COM), e a leitura seguinte estoura "is not an object" NO CHAMADOR,
    * longe da causa. Em form MODAL o Hide() tambem devolve o Show(), entao
    * para o usuario a tela fecha igual - muda so o tempo de vida do objeto
    * (PILAR 3), nao o comportamento (PILAR 1). Eh o contrato que o projeto
    * ja adota em FormBuscaAuxiliar ("usa Hide() em vez de Release() para
    * permitir leitura de propriedades / caller deve chamar Release() apos
    * ler valores"), e por isso o CHAMADOR eh quem libera este dialogo
    * depois de ler o cursor BarBonus.
    *
    * Nada a antecipar do Destroy: o Destroy desta classe so faz DODEFAULT()
    * (rebuild dos popups do menu principal) - nao ha efeito externo que o
    * chamador leia na sequencia e que o Hide() atrasaria.
    *
    * PROTECTED: nao eh delegate de BINDEVENT nem alvo do harness - os dois
    * unicos pontos de saida da tela sao os Btn*Click acima, que sao PUBLIC.
    *==========================================================================
    PROTECTED PROCEDURE FecharDialogo()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Hide()
    ENDPROC

    *==========================================================================
    * FormParaBO - FUNIL unico de transferencia TELA -> Business Object.
    *
    * Esta tela nao tem formulario de campos: o UNICO dado que o usuario
    * informa eh o codigo de barra digitado na celula da grade
    * (Grade.Column1.Text1 do legado). Por isso o metodo transfere DOIS
    * valores, e nao uma lista de campos:
    *
    *   this_cCodigoBarra  <- o valor da celula, como CHARACTER de 10 digitos
    *                         (STR(x, 10)) - exatamente os 10 que o Valid
    *                         legado fatia em nDope ("Val(Left(Str(This.Value,
    *                         10),4))", 4 primeiros) e Nume ("Val(Right(
    *                         Str(This.Value,10),6))", 6 ultimos). O BO
    *                         converte com VAL.
    *   this_lNovoRegistro <- derivado de this_nCodigoBarraAnterior (o
    *                         "_OldCodigo" que o When da celula captura):
    *                         celula que estava em ZERO eh linha NOVA
    *                         (Inserir), celula que ja tinha barra eh
    *                         CORRECAO (Atualizar). As duas rodam a MESMA
    *                         validacao no BO - o que muda eh so o rotulo
    *                         ("INSERT"/"UPDATE") gravado em LogAuditoria.
    *
    * Le o CONTROLE e NUNCA o cursor (regra CLAUDE.md #46): dentro do Valid o
    * cursor ainda tem o valor ANTIGO, entao validar pelo cursor conferiria a
    * barra anterior. Pelo mesmo motivo nao importa que este metodo rode
    * ANTES do "Select BarBonus / Skip / Skip -1" que descarrega o buffer da
    * celula - ele nao depende do cursor.
    *
    * par_oTxt eh OPCIONAL: a celula ativa chega por parametro quando quem
    * chama eh o Valid da subclasse (que a recebe como THIS), e eh resolvida
    * pelo caminho conhecido na grade quando o metodo eh chamado sem
    * argumento. A Column tem UMA instancia do CurrentControl, compartilhada
    * por todas as linhas, entao os dois caminhos alcancam o MESMO objeto.
    * NUNCA Controls(<nome>) para alcancar membro por nome (regra CLAUDE.md
    * #34), e PEMSTATUS so prova EXISTENCIA, nao escopo (regra CLAUDE.md #3).
    *
    * O saldo recebido do form pai (poValor) NAO passa por aqui: ele chega ao
    * BO em InicializarForm, ANTES de qualquer controle existir - eh
    * parametro do Init ("ThisForm.Saldo = poValor"), nao campo de tela.
    *
    * Devolve .F. quando nao ha BO ou nao ha celula a ler (tela instanciada
    * sem o form chamador - harness de teste, validacao de UI), sem exibir
    * nada. RETURN unico e FORA do TRY/CATCH, por flag (regra CLAUDE.md #1).
    *
    * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase ja declara
    * "PROTECTED PROCEDURE FormParaBO" (formbase.prg:285) e o VFP9 NAO deixa
    * a subclasse ALARGAR o escopo herdado - declarar sem o modificador aqui
    * nao tornaria o metodo publico, so esconderia que ele continua
    * protegido. Medido no VFP9 nesta propria tela: PEMSTATUS(oForm,
    * "FormParaBO", 5) devolve .T. (so testa EXISTENCIA) e
    * PEMSTATUS(..., 2) devolve .T. para Protected, enquanto a chamada de
    * fora estoura "Property FORMPARABO is not found". Por isso o unico
    * chamador eh THIS.FormParaBO(par_oTxt), de dentro de
    * ValidarBarraDigitada (regra CLAUDE.md #8); quem chega do Valid da
    * subclasse de celula entra por ValidarBarraDigitada, que eh PUBLIC.
    * Exercitar este metodo num harness exige subclasse com wrapper publico -
    * script solto nao alcanca membro protegido.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO(par_oTxt)
        LOCAL loc_lTransferiu, loc_oCelula, loc_nValor, loc_oErro
        loc_lTransferiu = .F.

        TRY
            loc_oCelula = .NULL.

            IF VARTYPE(par_oTxt) = "O"
                loc_oCelula = par_oTxt
            ELSE
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_CelBarra", 5)
                        loc_oCelula = THIS.grd_4c_Dados.Column1.txt_4c_CelBarra
                    ENDIF
                ENDIF
            ENDIF

            IF VARTYPE(loc_oCelula) = "O" AND VARTYPE(THIS.this_oBusinessObject) = "O"
                IF VARTYPE(loc_oCelula.Value) = "N"
                    loc_nValor = loc_oCelula.Value
                ELSE
                    loc_nValor = VAL(TRANSFORM(loc_oCelula.Value))
                ENDIF

                WITH THIS.this_oBusinessObject
                    .this_cCodigoBarra  = ALLTRIM(STR(loc_nValor, 10))
                    .this_lNovoRegistro = (THIS.this_nCodigoBarraAnterior = 0)
                ENDWITH

                loc_lTransferiu = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.FormParaBO")
        ENDTRY

        RETURN loc_lTransferiu
    ENDPROC

    *==========================================================================
    * BOParaForm - contrapartida de FormParaBO: FUNIL unico que espelha na
    * tela o que o Business Object calculou. Sao os TRES unicos pontos desta
    * tela que exibem estado vindo do BO, e todos os tres existem no legado:
    *
    *   lbl_4c_Label1 <- this_cDescFormaPagto  ("'[ '+AllTrim(crSigOpFp.fpags)
    *                                           +' ]'" no Init)
    *   lbl_4c_Label3 <- this_nQtdeBarras      ("'[ '+Alltrim(Str(Selecao.Qt))
    *                                           +' ]'" no LostFocus da celula)
    *   txt_4c_Saldo  <- this_nSaldoAtual      ("ThisForm.Get_Saldo.Value =
    *                                           ThisForm.Saldo - Selecao.Valor")
    *
    * A CONTA nao mora aqui: ela tem fonte unica em
    * SIGOPPGCBO.RecalcularSaldoEQuantidade, e este metodo so pinta o
    * resultado. O Refresh explicito nos dois controles recalculados
    * reproduz "ThisForm.label3.Refresh" / "ThisForm.Get_Saldo.Refresh" do
    * legado - e eh necessario, porque atribuir .Value/.Caption nao repinta
    * sozinho (mesma mecanica da regra CLAUDE.md #21).
    *
    * O aviso de saldo NEGATIVO ("Quantidade de Barras excedida!!!") NAO vem
    * para ca: no legado ele esta no LostFocus, depois do Refresh, e eh fluxo
    * (interrompe o usuario), nao espelho - fica em
    * AtualizarSaldoEQuantidade, que eh quem transcreve aquele evento.
    *
    * NAO eh chamado no Init, de proposito: la o contador ainda nao foi
    * calculado e o legado mantem o Caption de projeto de Label3 ("[  ]")
    * ate o primeiro LostFocus - pintar "[ 0 ]" na abertura seria desvio do
    * PILAR 1. O rotulo da forma de pagamento, que o Init legado DE FATO
    * troca, eh pintado la por PintarRotuloFormaPagto, o mesmo helper que
    * este metodo usa (fonte unica do Caption - CLAUDE.md #44, item 6).
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: FormBase declara
    * "PROTECTED PROCEDURE BOParaForm" (formbase.prg:280) e o escopo herdado
    * NAO se alarga na subclasse. Chamado por THIS.BOParaForm(), de dentro de
    * AtualizarSaldoEQuantidade - que eh PUBLIC e eh por onde o LostFocus da
    * celula chega.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lEspelhou, loc_oErro
        loc_lEspelhou = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.PintarRotuloFormaPagto()

                IF PEMSTATUS(THIS, "lbl_4c_Label3", 5)
                    THIS.lbl_4c_Label3.Caption = "[ " + ;
                        ALLTRIM(STR(THIS.this_oBusinessObject.this_nQtdeBarras)) + " ]"
                    THIS.lbl_4c_Label3.Refresh()
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c_Saldo", 5)
                    THIS.txt_4c_Saldo.Value = THIS.this_oBusinessObject.this_nSaldoAtual
                    THIS.txt_4c_Saldo.Refresh()
                ENDIF

                loc_lEspelhou = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSIGOPPGC.BOParaForm")
        ENDTRY

        RETURN loc_lEspelhou
    ENDPROC

    *==========================================================================
    * PintarRotuloFormaPagto - FONTE UNICA do Caption de lbl_4c_Label1
    * ("'[ '+AllTrim(crSigOpFp.fpags)+' ]'" do Init legado), consumida pelos
    * DOIS pontos que precisam dele: AplicarRotuloFormaPagto (que CARREGA a
    * forma de pagamento do cursor do chamador para o BO, na abertura) e
    * BOParaForm (o espelho completo). Escrever a expressao nos dois lugares
    * faria as duas copias divergirem em silencio na primeira mudanca de
    * formato (CLAUDE.md #44, item 6).
    *
    * So pinta com descricao PREENCHIDA: sem o cursor do chamador (harness de
    * teste, validacao de UI) this_cDescFormaPagto fica vazia, e pintar
    * "[  ]" por cima APAGARIA o Caption de projeto que o SCX traz
    * ("Condi" + CHR(231) + CHR(227) + "o de Pagamento"). Mesma guarda por
    * conteudo que AplicarRotuloFormaPagto ja aplicava ao condicionar a
    * pintura ao sucesso de CarregarDoCursor.
    *
    * Sem Refresh: o legado nao o faz neste label (so em label3 e Get_Saldo),
    * e aqui a troca acontece antes de a tela ser exibida.
    *
    * PROTECTED: nao eh delegate de BINDEVENT nem alvo do harness - os dois
    * chamadores sao metodos desta propria classe.
    *==========================================================================
    PROTECTED PROCEDURE PintarRotuloFormaPagto()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
           AND PEMSTATUS(THIS, "lbl_4c_Label1", 5)

            IF !EMPTY(THIS.this_oBusinessObject.this_cDescFormaPagto)
                THIS.lbl_4c_Label1.Caption = "[ " + ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cDescFormaPagto) + " ]"
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
    * (cntSombra do legado) e os dois labels sobrepostos que produzem o
    * efeito de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
    * (Top = 17). Width/Height/Font/ForeColor transcritos do dump (secao
    * "PROPRIEDADES DE: SIGOPPGC.cntSombra" e dos dois labels filhos).
    *
    * Container.Width = THIS.Width (NAO o 800 literal do dump, que eh
    * residuo do template da classe base e excede o Width real do form -
    * regra CLAUDE.md sobre cnt_4c_Cabecalho.Width).
    *
    * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
    * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
    * criado por AddObject e, com WordWrap, descarta a Height).
    *
    * Caption = THIS.Caption - o dump traz "Cadastro de Testes" literal nos
    * dois labels, que eh residuo de template (nao bate com o Caption real
    * do form, "Informe os Barras") - transcrever o texto do template
    * reproduziria o defeito, nao o legado (mesma decisao de
    * Formsigopped.prg e regra CLAUDE.md #11 - ambos os labels usam
    * THIS.Caption).
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
    * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
    * criados via AddObject (que nascem Visible = .F. por padrao) e desce em
    * PageFrames/Containers. Nao ha containers flutuantes (Visible = .F. por
    * design) nesta tela - sem lista de excecao, diferente de forms com
    * paineis alternaveis.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oObjeto

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_i)

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
    * Destroy - equivale a "PROCEDURE Release" do legado (nao existe neste
    * dump - a reabilitacao do form pai mora nos Click de Ok/Cancela, fase
    * 8, mesmo padrao de Formsigopped.prg). DODEFAULT() OBRIGATORIO (regra
    * CLAUDE.md Pattern #145 - sem ele os popups do menu principal ficam com
    * cache visual encolhido apos este dialogo modal fechar).
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* SUBCLASSES DE CELULA DA GRADE
*
* Levam o When/Valid que o legado tem em SIGOPPGC.Grade.ColumnN.Text1, e sao
* instaladas por FormSIGOPPGC.InstalarCelulasGrade (Column.AddObject +
* CurrentControl - regra CLAUDE.md #18).
*
* POR QUE SUBCLASSE E NAO BINDEVENT (regra CLAUDE.md #46): a validacao de
* celula de grade mora no Valid do TextBox da coluna, BINDEVENT em "Valid" de
* TextBox de Column nao eh confiavel e, acima de tudo, BINDEVENT DESCARTA o
* retorno do delegate - e aqui o retorno E' o mecanismo: Valid devolvendo .F.
* recusa a saida da celula, When devolvendo .F. recusa a entrada. Nenhum dos
* dois efeitos sobrevive a um BINDEVENT. (O LostFocus, que nao tem retorno com
* significado, fica por BINDEVENT - ver InstalarCelulasGrade.)
*
* Cada subclasse so decide ENTRAR/SAIR e DELEGA a regra ao metodo PUBLIC
* correspondente do form (fonte unica) - o legado faz o mesmo, chamando
* "ThisForm.label3"/"ThisForm.Get_Saldo" de dentro dos eventos da celula.
*
* O guard PEMSTATUS existe porque estas classes vivem no mesmo arquivo do form
* mas sao instanciadas pelo Grid: se um dia a celula for reusada em outro form
* sem esses metodos, a ausencia vira "a celula nao valida" em vez de "Property
* is not found" derrubando a tela.
*==============================================================================

*------------------------------------------------------------------------------
* TextBoxCelBarraSigOpPgc_4c - celula da coluna "Barra"
* (SIGOPPGC.Grade.Column1.Text1), a UNICA digitavel da tela.
*
* When  legado: "Public _OldCodigo / Set Confirm On / _OldCodigo = This.Value /
*               Return(.t.)" - vive em FormSIGOPPGC.PrepararCelulaBarra.
* Valid legado: decodifica a barra, confere a operacao em SigCdOpe, confere
*               duplicidade, grava o valor da forma de pagamento e abre a
*               linha seguinte - vive em FormSIGOPPGC.ValidarBarraDigitada
*               (que delega a regra a SIGOPPGCBO).
*
* THIS eh passado adiante porque o valor DIGITADO so existe em .Value durante
* o Valid - o cursor ainda guarda o valor anterior (regra CLAUDE.md #46).
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelBarraSigOpPgc_4c AS TextBox

    PROCEDURE When()
        LOCAL loc_lPermite

        loc_lPermite = .T.

        IF PEMSTATUS(THISFORM, "PrepararCelulaBarra", 5)
            loc_lPermite = THISFORM.PrepararCelulaBarra(THIS)
        ENDIF

        RETURN loc_lPermite
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lValido

        loc_lValido = .T.

        IF PEMSTATUS(THISFORM, "ValidarBarraDigitada", 5)
            loc_lValido = THISFORM.ValidarBarraDigitada(THIS)
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

*------------------------------------------------------------------------------
* TextBoxCelValorSigOpPgc_4c - celula da coluna "Valor"
* (SIGOPPGC.Grade.Column2.Text1).
*
* When legado: "Return .f." - a celula NUNCA recebe foco. O valor nao eh
* digitado: eh gravado por codigo, no "Replace Valors With CrSigOpFp.VlrFpgs"
* do Valid da coluna 1 (hoje em SIGOPPGCBO).
*
* Eh este o mecanismo do legado, e por isso a Column NAO leva ReadOnly = .T.
* inventado: daria o mesmo efeito por outra via e esconderia o When que o
* dump declara.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelValorSigOpPgc_4c AS TextBox

    PROCEDURE When()
        RETURN .F.
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPPGCBO.prg):
*==============================================================================
* SIGOPPGCBO.prg - Business Object para FormSIGOPPGC (Informe os Barras)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal) aberto por um form pai
* para informar as "barras" (codigos de barra) usadas como forma de pagamento
* por barras/bonus. O dialogo NAO possui tabela propria no SQL Server: ele
* grava os codigos digitados no cursor local BarBonus (criado pelo proprio
* form, no mesmo padrao de SIGOPPED), e por isso this_cTabela fica vazio.
* this_cCampoChave aponta para a coluna que identifica cada linha desse
* cursor (Codigos), usada pelo legado em "Where Codigos = This.Value".
*==============================================================================
DEFINE CLASS SIGOPPGCBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (dados manipulados pelo dialogo Informe os Barras)
    *--------------------------------------------------------------------------
    this_nSaldoInicial    = 0    && poValor - saldo recebido do form pai (ThisForm.Saldo)
    this_nSaldoAtual      = 0    && saldo apos descontar a soma dos valores das barras validas (Get_Saldo.Value)
    this_nQtdeBarras      = 0    && quantidade de barras validas digitadas (label3 "[ N ]")
    this_cDescFormaPagto  = ""   && crSigOpFp.fpags - descricao da forma de pagamento (label1.Caption)
    this_nValorPorBarra   = 0    && crSigOpFp.VlrFpgs - valor atribuido a cada barra digitada (Replace Valors)
    this_cCodigoBarra     = ""   && ultimo codigo de barra validado na celula da grade (BarBonus.Codigos)
    this_nDopeBarra       = 0    && nDope - codigo da operacao decodificado dos 4 primeiros digitos da barra
    this_nNumeBarra       = 0    && Nume - numero sequencial decodificado dos 6 ultimos digitos da barra
    this_lBarraValida     = .F.  && resultado da ultima validacao de barra contra SigCdOpe

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Codigos"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega da forma de pagamento (cursor crSigOpFp,
    * aberto pelo form pai e repassado na mesma datasession) a descricao
    * (fpags, equivalente ao label1.Caption do Init legado) e o valor
    * atribuido a cada barra (VlrFpgs, equivalente ao Replace Valors do
    * Valid legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cDescFormaPagto = TratarNulo(fpags, "")
                THIS.this_nValorPorBarra  = TratarNulo(VlrFpgs, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo de barra validado por ultimo (Codigos, a
    * mesma coluna usada pelo legado em "Where Codigos = This.Value")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigoBarra
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Este dialogo nao grava em tabela do SQL Server (so
    * atualiza o cursor local BarBonus - ver Init, que por isso deixa
    * this_cTabela vazio de proposito). Sobrescrito aqui so para o log de
    * auditoria identificar o cursor afetado em vez de uma tabela vazia.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cChave, loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        loc_cChave = THIS.ObterChavePrimaria()

        IF !EMPTY(loc_cChave) AND !(TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + EscaparSQL("BarBonus") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"
            loc_lResultado = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - A grade aceita uma barra nova por linha (sempre Codigos = 0
    * antes de validar - ver Insert Into BarBonus(Codigos) Values(0) do
    * legado); a validacao e a gravacao sao a MESMA operacao do Valid
    * legado, por isso delega para o mesmo metodo que Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Revalida uma barra ja existente na grade (usuario corrige
    * o codigo de uma linha) - mesma operacao de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBarraEAtualizarCursor - Transcricao de
    * SIGOPPGC.Grade.Column1.Text1.Valid: decodifica o codigo de barra
    * (this_cCodigoBarra, 10 digitos) nos 4 primeiros digitos (codigo da
    * operacao, this_nDopeBarra) e nos 6 ultimos (numero sequencial,
    * this_nNumeBarra); confere o codigo da operacao contra SigCdOpe;
    * confere duplicidade da mesma barra dentro do cursor local BarBonus; e,
    * se tudo valido, grava o valor da forma de pagamento (this_nValorPorBarra,
    * carregado de crSigOpFp.VlrFpgs em CarregarDoCursor) na linha corrente
    * de BarBonus.Valors.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarBarraEAtualizarCursor()
        LOCAL loc_lResultado, loc_nCodigoBarra, loc_cSqlOpe, loc_nResultado, loc_oErro

        loc_lResultado   = .T.
        loc_nCodigoBarra = VAL(THIS.this_cCodigoBarra)

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        THIS.this_lBarraValida  = .F.
        THIS.this_nDopeBarra    = 0
        THIS.this_nNumeBarra    = 0

        TRY
            IF loc_nCodigoBarra > 0
                SET DECIMALS TO 0
                THIS.this_nDopeBarra = VAL(LEFT(STR(loc_nCodigoBarra, 10), 4))
                THIS.this_nNumeBarra = VAL(RIGHT(STR(loc_nCodigoBarra, 10), 6))

                loc_cSqlOpe = "SELECT Dopes FROM SigCdOpe WHERE ndopes = " + STR(THIS.this_nDopeBarra)

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSqlOpe, "cursor_4c_ValidaOpe")

                IF loc_nResultado < 0 OR !USED("cursor_4c_ValidaOpe") OR RECCOUNT("cursor_4c_ValidaOpe") = 0
                    THIS.this_cMensagemErro = "Barra Inv" + CHR(225) + "lido!!!!"
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lResultado = .F.
                ELSE
                    IF USED("BarBonus")
                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF

                        *-- m. OBRIGATORIO: em SELECT VFP local, nome solto eh
                        *-- resolvido primeiro como COLUNA - sem o prefixo a
                        *-- consulta de duplicidade pode estourar "Column
                        *-- LOC_NCODIGOBARRA is not found" em vez de comparar
                        *-- com a variavel.
                        SELECT SUM(1) AS Qt, Codigos FROM BarBonus ;
                            WHERE Codigos = m.loc_nCodigoBarra ;
                            GROUP BY Codigos ;
                            INTO CURSOR cursor_4c_CheckDup

                        IF USED("cursor_4c_CheckDup") AND cursor_4c_CheckDup.Qt > 1
                            THIS.this_cMensagemErro = "Barra j" + CHR(225) + " digitado !!!"
                            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.this_lErroExibido = .T.
                            loc_lResultado = .F.
                        ELSE
                            REPLACE Valors WITH THIS.this_nValorPorBarra IN BarBonus
                            THIS.this_lBarraValida = .T.
                        ENDIF

                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "Cursor de barras (BarBonus) n" + CHR(227) + "o est" + CHR(225) + " aberto."
                        THIS.this_lErroExibido = .T.
                        loc_lResultado = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
            ENDIF

            IF loc_lResultado AND THIS.this_lBarraValida
                THIS.RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar barra: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * RecalcularSaldoEQuantidade - Transcricao da conta que
    * SIGOPPGC.Grade.Column1.Text1.LostFocus faz no legado:
    *
    *     Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor
    *         From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1
    *     ThisForm.label3.Caption  = '[ '+Alltrim(Str(Selecao.Qt))+' ]'
    *     ThisForm.Get_Saldo.Value = ThisForm.Saldo - Selecao.Valor
    *
    * Fica NO BO porque eh regra de negocio com FONTE UNICA (regra CLAUDE.md
    * #17 - totais calculados pelo BO, o form so espelha): grava
    * this_nQtdeBarras (contador "[ N ]" de label3) e this_nSaldoAtual (saldo
    * restante de Get_Saldo), que FormSIGOPPGC.AtualizarSaldoEQuantidade le
    * para repintar os dois controles.
    *
    * O CRITERIO do legado vai junto e eh parte da regra: "Where Codigos <> 0"
    * EXCLUI a linha em branco que o Valid acabou de abrir (o
    * "Insert Into BarBonus(Codigos) Values(0)"), senao ela entraria na
    * contagem de barras e inflaria o total em um.
    *
    * Cursor vazio / nenhuma barra valida: no legado o GROUP BY devolve ZERO
    * linhas e "Selecao.Qt"/"Selecao.Valor" lidos em EOF valem 0, ou seja
    * contador 0 e saldo = saldo inicial. Reproduzido com guarda EXPLICITA de
    * RECCOUNT, que da o mesmo resultado sem depender da leitura em EOF.
    *
    * A area de trabalho corrente eh salva e restaurada: o SELECT-SQL a troca,
    * e quem chama (o Valid da celula) depende do ponteiro de BarBonus para
    * decidir se abre linha nova.
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularSaldoEQuantidade(par_cAliasGrade)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_nRecno, loc_oErro
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasGrade) = "C" AND !EMPTY(par_cAliasGrade), ;
                         ALLTRIM(par_cAliasGrade), "BarBonus")

        THIS.this_nQtdeBarras = 0
        THIS.this_nSaldoAtual = THIS.this_nSaldoInicial

        TRY
            IF USED(loc_cAlias)
                loc_cAliasAnterior = ALIAS()
                SELECT (loc_cAlias)
                loc_nRecno = RECNO()

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- FROM por MACRO (&), nao "(loc_cAlias)": o FROM de um
                *-- SELECT-SQL do VFP nao aceita expressao de nome entre
                *-- parenteses - so literal ou substituicao de macro. Sem o
                *-- ponto final o VFP leria o "nome" ate o ";" da continuacao.
                *-- O "[ ] as Agrupar ... group by 1" do legado existe so para
                *-- forcar UMA linha de resultado; a agregacao sem GROUP BY ja
                *-- devolve exatamente uma linha, inclusive quando nenhuma
                *-- barra casa (ai com total zerado), entao a coluna constante
                *-- nao eh reproduzida - ninguem a le.
                SELECT SUM(1) AS Qt, SUM(Valors) AS Valor ;
                    FROM &loc_cAlias. ;
                    WHERE Codigos <> 0 ;
                    INTO CURSOR cursor_4c_Selecao

                IF USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
                    SELECT cursor_4c_Selecao
                    GO TOP
                    THIS.this_nQtdeBarras = NVL(cursor_4c_Selecao.Qt, 0)
                    THIS.this_nSaldoAtual = THIS.this_nSaldoInicial - ;
                                            NVL(cursor_4c_Selecao.Valor, 0)
                ENDIF

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- Repoe area e ponteiro para quem chamou (o Valid da celula
                *-- depende do RECNO de BarBonus).
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    IF loc_nRecno >= 1 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao recalcular saldo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


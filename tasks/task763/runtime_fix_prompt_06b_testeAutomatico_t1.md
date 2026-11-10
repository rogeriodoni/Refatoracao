# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-08 18:09:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-08 18:09:30] [INFO] Config FPW: (nao fornecido)
[2026-11-08 18:09:30] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 18:09:30] [INFO] Timeout: 300 segundos
[2026-11-08 18:09:30] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_of4fdzzd.prg
[2026-11-08 18:09:31] [INFO] Conteudo do wrapper:
[2026-11-08 18:09:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpLoc', 'C:\4c\tasks\task763', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLoc', 'C:\4c\tasks\task763', 'OPERACIONAL'
QUIT

[2026-11-08 18:09:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_of4fdzzd.prg
[2026-11-08 18:09:31] [INFO] VFP output esperado em: C:\4c\tasks\task763\vfp_output.txt
[2026-11-08 18:09:31] [INFO] Executando Visual FoxPro 9...
[2026-11-08 18:09:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_of4fdzzd.prg
[2026-11-08 18:09:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_of4fdzzd.prg
[2026-11-08 18:09:31] [INFO] Timeout configurado: 300 segundos
[2026-11-08 18:09:31] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-08 18:09:32] [INFO] VFP9 finalizado em 0.8757039 segundos
[2026-11-08 18:09:32] [INFO] Exit Code: 
[2026-11-08 18:09:32] [INFO] 
[2026-11-08 18:09:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-08 18:09:32] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_of4fdzzd.prg
[2026-11-08 18:09:32] [INFO] 
[2026-11-08 18:09:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-08 18:09:32] [INFO] * Auto-generated wrapper for parameters
[2026-11-08 18:09:32] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 18:09:32] [INFO] * Parameters: 'FormSigOpLoc', 'C:\4c\tasks\task763', 'OPERACIONAL'
[2026-11-08 18:09:33] [INFO] 
[2026-11-08 18:09:33] [INFO] * Anti-dialog protections for unattended execution
[2026-11-08 18:09:33] [INFO] SET SAFETY OFF
[2026-11-08 18:09:33] [INFO] SET RESOURCE OFF
[2026-11-08 18:09:33] [INFO] SET TALK OFF
[2026-11-08 18:09:33] [INFO] SET NOTIFY OFF
[2026-11-08 18:09:33] [INFO] SYS(2335, 0)
[2026-11-08 18:09:34] [INFO] 
[2026-11-08 18:09:34] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLoc', 'C:\4c\tasks\task763', 'OPERACIONAL'
[2026-11-08 18:09:34] [INFO] QUIT
[2026-11-08 18:09:34] [INFO] 
[2026-11-08 18:09:34] [INFO] === Fim do Wrapper.prg ===
[2026-11-08 18:09:34] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpLoc",
  "timestamp": "20261108180931",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": true,
      "erro": "",
      "detalhes": "CarregarDados() executado | (sem registros - tabela pode estar vazia)"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (CHKMARCACAOKEYPRESS, KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLoc.prg):
*==============================================================================
* FormSigOpLoc.prg
* Form Operacional: Selecao de Ocorrencias Para Impressao
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT (o SCX legado NAO tem PageFrame nem Page)
* SCX Origem: SigOpLoc.SCX  (tasks\task763\SigOpLoc_form_codigo_fonte.txt)
* BO:         SigOpLocBO    (projeto\app\classes\SigOpLocBO.prg)
*
* Dialogo MODAL (WindowType = 1, TitleBar = 0) aberto por um form de
* movimentacao para o usuario escolher, numa grade com caixa de marcacao,
* QUAIS ocorrencias de SigOpOco entram na impressao. A tela nao grava em
* SQL Server: ela so liga/desliga a coluna Imps do cursor de trabalho.
*
* CONTRATO EXTERNO - crSigOpOco eh do form CHAMADOR
*   O "PROCEDURE Init" do SCX legado comeca com "Select crSigOpOco" e liga a
*   grade a esse alias sem nunca cria-lo: o cursor eh montado pelo form PAI e
*   chega a esta tela pela data session. Dai duas consequencias que valem para
*   o form inteiro:
*     (a) DataSession = 1 (sessao corrente), igual ao SCX. Trocar para 2
*         isolaria a sessao e o cursor do chamador ficaria INVISIVEL aqui.
*     (b) Destroy() NAO fecha crSigOpOco - quem abriu eh o chamador, e fechar
*         o alias de outro form tiraria dele o resultado da selecao.
*   SigOpLocBO (Fases 1-2) ja segue o mesmo contrato: MarcarTodos(),
*   DesmarcarTodos() e AlternarSelecao() agem sobre crSigOpOco guardadas por
*   USED(), e devolvem .F. quando o alias nao esta aberto - situacao normal no
*   harness de teste, que instancia o form sem nenhum chamador.
*
* LAYOUT FLAT - por que NAO ha PageFrame aqui
*   A arvore de objetos do dump tem o objeto raiz como "Class: form /
*   BaseClass: form" (form GENERICO, nao frmcadastro nem frmrelatorio) e
*   NENHUMA linha "BaseClass: pageframe". Os 17 objetos penduram direto na
*   Form ou no container do cabecalho. Criar um PageFrame com Page1 (Lista) e
*   Page2 (Dados) aqui seria inventar estrutura que o legado nao tem - viola o
*   PILAR 1 e a regra "NUNCA inventar". Sem PageFrame tambem nao existe a
*   compensacao de +29 no Top: todas as coordenadas vao cruas do SCX.
*
* FASE 3/8 - ESTRUTURA BASE (o que este arquivo entrega)
*   - DEFINE CLASS FormSigOpLoc AS FormBase + propriedades visuais transcritas
*     do SCX (800x350, AutoCenter, TitleBar = 0, ControlBox/MaxButton/
*     MinButton = .F., WindowType = 1, DataSession = 1)
*   - Init() - ponto de entrada; delega ao FormBase.Init via DODEFAULT()
*   - InicializarForm() - fundo do form (Picture new_background.jpg),
*     criacao do Business Object e montagem da faixa do cabecalho
*   - ConfigurarCabecalho() - cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo
*     (mapeamento.json: cntSombra -> cnt_4c_Sombra, lblSombra ->
*     lbl_4c_LblSombra, lblTitulo -> lbl_4c_LblTitulo)
*   - TornarControlesVisiveis() recursivo (AddObject cria tudo Visible = .F.)
*   - Destroy() - libera o BO e devolve o controle ao FormBase via DODEFAULT()
*
*   A faixa do cabecalho eh o PRIMEIRO AddObject do form (regra #11): o
*   cmd_4c_BtnSair, em Top = 3, fica DENTRO da area da faixa (Top 0..80) e
*   precisa ser criado depois dela para desenhar por cima.
*
* FASE 4/8 - GRADE E BOTOES (o que esta fase acrescenta)
*   O gate desta fase tem dois ramos. O PAGINADO (ConfigurarPaginaLista +
*   AlternarPagina) nao se aplica: o legado nao tem PageFrame (ver "LAYOUT FLAT"
*   acima), e inventar Page de Lista/Dados com os 6 botoes CRUD violaria o
*   PILAR 1. Vale o ramo FLAT, que cobra a superficie que o legado de fato tem -
*   grade, botoes e metodo de carga:
*     - ConfigurarGrade()          - grd_4c_Dados (GridSels), 337x165 em 192,132
*     - FormatarColunasGrade()     - as tres colunas, larguras 15/80/220
*     - GarantirCheckBoxMarcacao() - chk_4c_Check1 na Column1, IDEMPOTENTE
*     - ConfigurarBotoes()         - shp_4c_Shape2 + os tres CommandButton
*     - AjustarOrdemTabulacao()    - TabIndex dos focalizaveis
*     - CarregarDados()            - FUNIL: bind + GO TOP + Refresh
*     - ChkMarcacao{KeyPress,MouseUp,MouseDown,Click} - alternancia da linha
*
*   Nao ha botao CRUD a acrescentar: os tres botoes do dump (MarcarEmp,
*   DesmarcarEmp, btnSair) nao sao verbo de cadastro, e os dois primeiros so
*   ligam/desligam a coluna Imps do cursor.
*
*   As quatro medicoes feitas no VFP9 em 2026-11-08 que determinaram a ORDEM do
*   codigo desta fase (scripts em automation\probe763.prg e
*   automation\probevcx763.prg) estao registradas no comentario de cada metodo:
*     1. Grid auto-liga ao alias CORRENTE quando ColumnCount eh definido;
*     2. AddObject de CheckBox em Column ligada a coluna de TEXTO estoura
*        "Data type mismatch"; ligada a Imps (bit -> Logico), funciona;
*     3. Column.Width aplicada depois de RecordSource fica (15/80/220);
*     4. Shape nao tem ForeColor nem ZOrderSet; fwbtnp = 40x40, fwbtng = 80x100.
*
* FASE 7/8 - EVENTOS PRINCIPAIS (o que esta fase acrescenta)
*   O Click dos TRES botoes que o legado tem, cada um registrado por BINDEVENT
*   junto do proprio AddObject em ConfigurarBotoes:
*     - CmdMarcarEmpClick     - BO.MarcarTodos()    + Grade.Refresh
*     - CmdDesmarcarEmpClick  - BO.DesmarcarTodos() + Grade.Refresh
*     - CmdBtnSairClick       - THIS.Release() ("ThisForm.Release" do legado)
*
*   NAO ha os quatro handlers da barra CRUD (Incluir / Alterar / Visualizar /
*   Excluir):
*   os quatro nomes sao a convencao da barra CRUD do frmcadastro, e o dump
*   prova que ela nao existe aqui - objeto raiz "Class: form / BaseClass: form"
*   (sem "frmcadastro"), nenhum "Grupo_Op", nenhum "pcEscolha" e nenhum dos
*   tres botoes com verbo de cadastro. Ver o bloco "EVENTOS DOS BOTOES" junto
*   dos handlers, que registra as quatro provas uma a uma.
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
*   Esta fase NAO acrescentou metodo novo, e isso eh o resultado correto: a
*   superficie que o legado tem ja estava inteira ao fim da Fase 7. Os 10
*   metodos/eventos do dump foram conferidos um a um contra o migrado:
*     SIGOPLOC.Init ................. InicializarForm + ConfigurarGrade +
*                                     CarregarDados + Caption nos 2 labels
*     Check1.Click .................. ChkMarcacaoClick      (NODEFAULT)
*     Check1.KeyPress ............... ChkMarcacaoKeyPress   (13/32 + toggle)
*     Check1.MouseDown .............. ChkMarcacaoMouseDown  (NODEFAULT)
*     Check1.MouseUp ................ ChkMarcacaoMouseUp    (toggle - par canonico)
*     Column2.Text1.When -> .f. ..... Column2.ReadOnly = .T.
*     Column3.Text1.When -> .f. ..... Column3.ReadOnly = .T.
*     DesmarcarEmp.Click ............ CmdDesmarcarEmpClick
*     MarcarEmp.Click ............... CmdMarcarEmpClick
*     btnSair.Click ................. CmdBtnSairClick
*
*   OS QUATRO NOMES CANONICOS DA FASE 8 NAO TEM REFERENTE NESTE LEGADO
*   BtnCancelarClick, FormParaBO, BOParaForm e CarregarLista sao convencao do
*   par Page2(Dados) + modo INCLUIR/ALTERAR do frmcadastro. Aqui nao existe
*   nenhum dos dois, e escrever os quatro obrigaria a INVENTAR superficie
*   (viola o PILAR 1) ou a criar metodo vazio (proibido pela regra de
*   completude). O gate da Fase 8 reconhece exatamente este formato no ramo
*   FLUXO-UNICO - "sem CRUD mas COM lista e campo editavel reais" -, que
*   dispensa os quatro em troca de um metodo Carregar* alimentando a grade
*   (CarregarDados, acima). Os predicados foram MEDIDOS em 2026-11-08
*   (automation\MedirGateF8Task763.ps1, que reusa os helpers do proprio
*   orquestrador em vez de reimplementa-los):
*     temListaLegadoF8  = True   (BaseClass: grid no dump)
*     temCamposLegadoF8 = True   (BaseClass: checkbox/textbox no dump)
*     semCrudLegadoF8   = True   (sem frmcadastro, Grupo_Op, pcEscolha nem
*                                 botao com verbo Incluir/Alterar/Visualizar/Excluir)
*     legadoSemSalvar   = True   (sem btnSalvar/btnGravar/mGravaDados)
*     Test-LegadoSomenteLeitura = False  -> NAO eh visualizador/exibicao: a
*                                 caixa de marcacao da Column1 eh editavel
*                                 (ReadOnly = .F. no dump, e sem When -> .f.)
*     => legadoFluxoUnicoF8 = True
*   E a exigencia de BOTAO DE ACAO eh satisfeita por
*   Test-AcaoDoLegadoTemHandler = True: o verbo vem do proprio dump
*   ("DesmarcarEmp") e o migrado tem CmdDesmarcarEmpClick. Nao se acrescenta
*   BtnSalvarClick/BtnConfirmarClick - a acao desta tela nao eh gravar.
*
*   INTEGRACAO - o que NAO se faz neste form, e por que
*     - menu.prg: NENHUM item. Esta tela eh dialogo FILHO modal cuja grade
*       vive do crSigOpOco do CHAMADOR (ver "CONTRATO EXTERNO" acima); aberta
*       pelo menu, sem chamador, abriria com a grade VAZIA. Mesmo criterio ja
*       aplicado aos outros dialogos filhos migrados - FormSigOpCtd,
*       FormSigOpCcj, FormSigPrCar, FormSigPrEml e FormSIGPRSTF tambem nao
*       tem entrada em menu.prg. Quem abre esta tela eh o form de
*       movimentacao que monta o cursor, e ele chama GarantirClasse antes do
*       CREATEOBJECT.
*     - config.prg: NENHUM SET PROCEDURE. Desde 2026-10-28 a carga eh SOB
*       DEMANDA (CLAUDE.md, secao config.prg): acrescentar BO/Form ali eh
*       proibido. forms\operacionais ja esta no escopo de
*       automation\GerarIndiceClasses.ps1, entao start\indice_classes.txt
*       passa a listar FormSigOpLoc/SigOpLocBO sozinho na proxima abertura.
*
*   VERIFICACAO DESTA FASE (2026-11-08)
*     COMPILACAO PROVADA: o smoke test do VFP9 desta sessao FALHOU (exit = 0,
*     .FXP criado, arquivo de saida ausente - o VFP compila e sai sem
*     executar), entao vale a variante que ainda prova compilacao: passar o
*     proprio .prg em "vfp9.exe -T". FormSigOpLoc.FXP e SigOpLocBO.FXP
*     gerados, nenhum .ERR. Com CONTROLE NEGATIVO na mesma rodada - uma copia
*     deste form com "PUBLIC PROCEDURE" (regra #9.1) colada no fim gerou .ERR
*     apontando SO as linhas acrescentadas (1020-1022: "Syntax error" /
*     "Statement is not valid in a class definition" / "Nesting error") -, o
*     que prova de uma vez que o detector funciona E que as 1017 linhas deste
*     arquivo compilam limpas.
*     NAO FOI PROVADO runtime/instanciacao: sem execucao no VFP9 desta sessao
*     nao ha como afirmar CREATEOBJECT nem o bind real da grade.
*     Estatico, tudo medido e com resultado ZERO: acento literal em .prg
*     (regra #4), "this_X .Value" (regra #43), RETURN dentro de TRY (regra
*     #1, por profundidade), MESSAGEBOX direto, ISEMPTY/MostrarAviso/.Self/
*     Controls("nome") (regras #2/#9.3/#38/#34), chamada a nome nao resolvido
*     contra utils + metodos da classe + heranca (regra #13), THIS.<membro>
*     sem referente, Test-CompletudeCodigo (TODO/stub) nos dois arquivos e
*     VerificarPropriedadesInexistentes.ps1 (regra #33). Os 4 arquivos de
*     .Picture conferidos em disco (regra #25): onebit_33.ico,
*     to-do-list_checked2.ico e cadastro_sair_60.jpg em vbmp\, mais
*     imagens\new_background.jpg em Framework\. Os 3 metodos do BO que o form
*     chama (MarcarTodos, DesmarcarTodos, AlternarSelecao) conferidos PUBLIC
*     no BO E na BusinessBase (regra #51).
*
* O QUE ESTE FORM NAO TEM, e por que
*   - barra CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar) e os botoes
*     Confirmar/Cancelar de uma Page2 de Dados: o SCX eh "Class: form" puro,
*     sem frmcadastro e sem Grupo_Op. Os unicos botoes do dump sao tres
*     (MarcarEmp, DesmarcarEmp e btnSair), e nenhum deles eh verbo de
*     cadastro - os dois primeiros alternam a coluna Imps do cursor e o
*     terceiro faz "ThisForm.Release".
*   - Commandgroup3 do legado: declara ButtonCount = 0 com BackStyle = 0 e
*     BorderStyle = 0, ou seja um grupo SEM nenhum botao que nao pinta fundo
*     nem borda - artefato morto do framework, que nao desenha nada na tela e
*     nao eh pai de botao nenhum (btnSair tem "Parent: SIGOPLOC", nao
*     "Parent: SIGOPLOC.Commandgroup3"). Deliberadamente fora do migrado,
*     mesmo criterio ja aplicado em FormSigMvVde para o Commandgroup3
*     identico do SIGMVVDE.SCX.
*==============================================================================

DEFINE CLASS FormSigOpLoc AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 800
    Height       = 350
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Sele" + CHR(231) + CHR(227) + "o de Ocorr" + CHR(234) + ;
                   "ncias Para Impress" + CHR(227) + "o"
    ShowWindow   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    WindowState  = 0
    FontName     = "Tahoma"
    FontSize     = 8

    *-- DataSession = 1 (sessao corrente) - OBRIGATORIO. crSigOpOco eh criado
    *-- pelo form chamador e precisa continuar visivel aqui; ver "CONTRATO
    *-- EXTERNO" no cabecalho deste arquivo.
    DataSession  = 1

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    *-- Alias do cursor de ocorrencias que chega do form chamador. Mantido em
    *-- property (e nao espalhado como literal) para que a grade, os dois
    *-- botoes de marcacao e o Destroy falem todos do MESMO alias.
    this_cCursorOcorrencias = "crSigOpOco"

    *==========================================================================
    * Init - ponto de entrada do form
    *
    * O Init legado nao recebe parametro nenhum (nao ha "lParameters" no dump):
    * ele so liga a grade a crSigOpOco e copia o Caption para os dois labels do
    * cabecalho. Aqui a montagem toda fica em InicializarForm, que o
    * FormBase.Init chama via DODEFAULT().
    *==========================================================================
    FUNCTION Init()
        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - monta a estrutura base do form
    *
    * Contrato do FormBase.Init: devolver .T. em sucesso e .F. em falha (com
    * .F. o CREATEOBJECT do chamador devolve logico e a tela nao abre), por
    * isso o unico caminho que devolve .F. aqui eh falha real de construcao.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Fundo do form. No SCX legado:
            *--    Picture = ..\framework\imagens\new_background.jpg
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- 2. Business Object (Fases 1-2)
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLocBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- 3. Faixa cinza do cabecalho (cntSombra do legado). Primeiro
                *--    AddObject do form - regra #11; ver cabecalho do arquivo.
                THIS.ConfigurarCabecalho()

                *-- 4. Caption propagado para os dois labels da faixa, igual as
                *--    duas ultimas linhas do Init legado:
                *--      ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
                *--      ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- 5. Grade de ocorrencias (GridSels do legado). Vem DEPOIS da
                *--    faixa do cabecalho e ANTES dos botoes, na ordem da arvore
                *--    de objetos do SCX.
                THIS.ConfigurarGrade()

                *-- 6. Shape2 e os tres botoes. O Shape2 do legado (Top 170..260,
                *--    Left 536..586) SOBREPOE os dois botoes de marcacao
                *--    (Top 175..255, Left 541..581) e no SCX ele vem ANTES deles,
                *--    por isso os botoes recebem o clique. Criado depois, um
                *--    Shape com BackStyle = 0 + BorderStyle = 0 ficaria por cima
                *--    e bloquearia o clique sem desenhar nada (regra #30) - a
                *--    ordem dentro de ConfigurarBotoes reproduz a do SCX.
                THIS.ConfigurarBotoes()

                *-- 7. Ordem de tabulacao, depois de TODOS os AddObject: TabIndex
                *--    fora da faixa 1..N eh descartado em silencio.
                THIS.AjustarOrdemTabulacao()

                *-- 8. AddObject cria todo controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- 9. Ligacao da grade ao cursor do chamador + repintura. Roda
                *--    DEPOIS de TornarControlesVisiveis porque Refresh em
                *--    controle invisivel nao pinta (regra #46). Devolve .F.
                *--    quando crSigOpOco nao esta aberto - caso normal do harness
                *--    de teste, que instancia a tela sem nenhum chamador, e que
                *--    NAO impede o form de abrir.
                THIS.CarregarDados()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                    CHR(237) + "vel criar o objeto de neg" + CHR(243) + ;
                    "cio SigOpLocBO."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpLoc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza com o titulo da tela
    *
    * mapeamento.json: SIGOPLOC.cntSombra           -> cnt_4c_Sombra
    *                  SIGOPLOC.cntSombra.lblSombra -> lbl_4c_LblSombra
    *                  SIGOPLOC.cntSombra.lblTitulo -> lbl_4c_LblTitulo
    *
    * O container eh identificado pelo par BackColor = RGB(100,100,100) +
    * Height = 80 (regra #11 - nunca pelo nome). lblSombra eh a sombra PRETA
    * desenhada 1px abaixo do titulo BRANCO (lblTitulo): o branco aqui eh
    * legitimo porque os dois labels moram num container OPACO escuro
    * (BackStyle = 1), que eh a excecao da regra #12.
    *
    * Geometria, fonte e ToolTipText vem do dump do SCX. AutoSize = .F.
    * explicito (regra #23: AutoSize eh no-op em Label criado por AddObject e,
    * com WordWrap = .T., descartaria a .Height e cortaria o texto) - a Width
    * de 769 e as Heights de 40/46 que o dump declara JA SAO o auto-size que o
    * Form Designer calculou, logo fixa-las eh reproducao fiel.
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
            .Width         = 769
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
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - grade de selecao das ocorrencias (GridSels do legado)
    *
    * mapeamento.json: SIGOPLOC.GridSels -> grd_4c_Dados
    *
    * Geometria e propriedades vem de DUAS fontes do dump, nesta ordem:
    *   (a) a secao de PROPRIEDADES do SCX (Top 132, Left 192, 337x165,
    *       ColumnCount 3, FontName Tahoma, HeaderHeight 0, DeleteMark/RecordMark
    *       .F., ScrollBars 2, AllowHeaderSizing/AllowRowSizing .F.,
    *       GridLineColor 238,238,238);
    *   (b) o "PROCEDURE Init", que repete varias delas e ACRESCENTA
    *       ReadOnly = .F. e RowHeight = 18.
    * O "ZOrderSet = 16" do dump NAO eh transcrito: medido no VFP9 em 2026-11-08,
    * a propriedade nao existe em Grid (PEMSTATUS = .F.) - eh escrituracao do Form
    * Designer, e o equivalente em runtime seria o METODO ZOrder(), que o legado
    * nao chama (regra #33).
    *
    * O que NAO fica aqui: RecordSource, os tres ControlSource e a caixa de
    * marcacao da Column1. Atribuir ControlSource de cursor que ainda nao existe
    * derruba o Init (regra #41), e crSigOpOco eh do form CHAMADOR - pode nao
    * estar aberto. Essa ligacao toda mora no funil CarregarDados().
    *
    * ARMADILHA MEDIDA (VFP9, 2026-11-08, automation\probe763.prg): Grid sem
    * RecordSource atribuida AUTO-LIGA ao alias CORRENTE no instante em que o
    * ColumnCount eh definido. Com crSigOpOco selecionado o resultado medido foi
    *   RecordSource = [Crsigopoco] / Column1.ControlSource = [crsigopoco.codigos]
    * e codigos eh char(10) (1a coluna de SigOpOco no docs\schema.sql), de modo
    * que um Column1.AddObject("...", "CheckBox") ali estoura NO PROPRIO AddObject
    * com "Error with ... Value : Data type mismatch" - o .Value do CheckBox nasce
    * numerico e a coluna esta ligada a texto. Por isso o ColumnCount eh a ULTIMA
    * atribuicao deste metodo e a caixa de marcacao so nasce em
    * GarantirCheckBoxMarcacao(), depois de Column1.ControlSource apontar para
    * Imps (bit -> Logico), onde o mesmo AddObject foi medido OK.
    *
    * Sem PageFrame neste form, entao sem compensacao de +29 no Top.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrade

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrade = THIS.grd_4c_Dados

        WITH loc_oGrade
            .Top               = 132
            .Left              = 192
            .Width             = 337
            .Height            = 165
            .FontName          = "Tahoma"
            .HeaderHeight      = 0
            .RowHeight         = 18
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.

            *-- ULTIMA atribuicao do bloco: dispara o auto-bind descrito acima e
            *-- recria os objetos Column. Definido UMA vez e nunca mais - tocar
            *-- em ColumnCount depois destruiria a caixa de marcacao da Column1.
            .ColumnCount = 3
        ENDWITH

        *-- Com crSigOpOco fechado o auto-bind pegaria o alias corrente do
        *-- chamador e a grade exibiria dados de outra tela. RecordSource vazia
        *-- deixa a grade em branco ate CarregarDados() ligar o cursor certo.
        IF !USED(THIS.this_cCursorOcorrencias)
            loc_oGrade.RecordSourceType = 1
            loc_oGrade.RecordSource     = ""
        ENDIF

        THIS.FormatarColunasGrade()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormatarColunasGrade - propriedades das tres colunas da grade
    *
    * Chamado em DOIS pontos: no fim de ConfigurarGrade (para a grade ja nascer
    * formatada) e no fim de CarregarDados, DEPOIS de RecordSource - atribuir
    * RecordSource recalcula Column.Width para o default 90, entao a largura tem
    * de ser reaplicada por ultimo (regra #41). Medido no VFP9 (2026-11-08):
    * aplicadas depois do RecordSource, as larguras 15/80/220 do dump ficam.
    *
    * Ordem interna de cada coluna reproduz a cronologia do legado: primeiro as
    * propriedades que o SCX declara no Header1/Text1 da coluna, depois as que o
    * "PROCEDURE Init" atribui na COLUNA (que sobrescreve FontName de Tahoma para
    * Courier New).
    *
    * Header1.Caption nao eh atribuido de proposito: o default do VFP9 ja eh
    * "Header1", exatamente o que o SCX declara, e com HeaderHeight = 0 nenhum
    * cabecalho aparece na tela.
    *
    * Column.ReadOnly vem DEPOIS de Grid.ReadOnly (feito em ConfigurarGrade): o
    * do grid propaga para as colunas e sobrescreveria estes valores (regra #18).
    * Column1 fica editavel (eh a caixa de marcacao); Column2 e Column3 ficam
    * ReadOnly = .T., que eh o efeito do "Return(.f.)" no When dos Text1 delas.
    *==========================================================================
    PROTECTED PROCEDURE FormatarColunasGrade()
        LOCAL loc_oGrade
        loc_oGrade = THIS.grd_4c_Dados

        *-- Column1 - caixa de marcacao (crSigOpOco.Imps)
        WITH loc_oGrade.Column1
            .Header1.FontName  = "Tahoma"
            .Header1.ForeColor = RGB(90, 90, 90)
            .FontName          = "Courier New"
            .Movable           = .F.
            .Resizable         = .F.
            .Width             = 15
            .ReadOnly          = .F.
        ENDWITH

        *-- Column2 - codigo da ocorrencia (crSigOpOco.Codigos)
        WITH loc_oGrade.Column2
            .Header1.FontName  = "Tahoma"
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.FontName    = "Tahoma"
            .Text1.BorderStyle = 1
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.Visible     = .T.
            .FontName          = "Courier New"
            .Movable           = .F.
            .Resizable         = .F.
            .Width             = 80
            .ReadOnly          = .T.
        ENDWITH

        *-- Column3 - descricao da ocorrencia (crSigOpOco.Descrs)
        WITH loc_oGrade.Column3
            .Header1.FontName  = "Tahoma"
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.FontName    = "Tahoma"
            .Text1.Margin      = 0
            .Text1.Visible     = .T.
            .FontName          = "Courier New"
            .Movable           = .F.
            .Resizable         = .F.
            .Width             = 220
            .ReadOnly          = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCheckBoxMarcacao - cria (uma vez) a caixa de marcacao da Column1
    *
    * mapeamento.json: SIGOPLOC.GridSels.Column1.Check1 -> chk_4c_Check1
    *
    * Column.AddObject cria o objeto mas NAO o exibe: sem CurrentControl a coluna
    * continua desenhando o Text1 dela, e sem Sparse = .F. a caixa so aparece na
    * linha ATIVA (regra #18). As duas atribuicoes ficam FORA do IF, para serem
    * reaplicadas em toda repintura.
    *
    * IDEMPOTENTE de proposito: fechar o alias que eh RecordSource de um Grid
    * DESTROI o objeto adicionado por Column.AddObject (CurrentControl volta a
    * "Text1") preservando Width e Header - perda parcial e silenciosa. Como
    * crSigOpOco eh do chamador, ele pode refazer o cursor entre duas aberturas
    * desta tela. O guard PEMSTATUS eh obrigatorio no outro sentido tambem: um
    * segundo AddObject com o mesmo nome estouraria "object already exists".
    *
    * Os quatro BINDEVENT ficam DENTRO do mesmo IF, junto do AddObject: objeto
    * recriado eh outro objeto e as ligacoes do anterior morreram com ele - sem
    * religar, a caixa aparece e nao alterna nada.
    *
    * .Value NAO eh atribuido. Medido no VFP9 (2026-11-08,
    * automation\probe763.prg) com a Column1 ligada a Imps (bit -> Logico): a
    * caixa nasce com .Value LOGICO vindo da linha corrente (VARTYPE = "L"), e
    * atribuir .Value = 0 o converte para NUMERICO (VARTYPE = "N"), divergindo do
    * tipo da coluna. A regra geral "CheckBox .Value = 0 no AddObject" vale para
    * caixa SOLTA ou ligada a coluna numerica, nao para esta.
    *
    * AutoSize = .F. explicito: o Init legado faz ".Column1.Check1.AutoSize = .t.",
    * mas AutoSize eh no-op em controle criado por AddObject (regra #23), entao
    * Width e Height sao transcritos do dump (22x17). Num controle de Column o
    * Grid redimensiona o CurrentControl para a celula, de modo que Top/Left/
    * Width/Height do dump sao reproduzidos sem efeito colateral.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCheckBoxMarcacao()
        LOCAL loc_oColuna
        loc_oColuna = THIS.grd_4c_Dados.Column1

        IF !PEMSTATUS(loc_oColuna, "chk_4c_Check1", 5)
            loc_oColuna.AddObject("chk_4c_Check1", "CheckBox")

            WITH loc_oColuna.chk_4c_Check1
                .Caption   = ""
                .FontName  = "Tahoma"
                .Alignment = 0
                .AutoSize  = .F.
                .Top       = 9
                .Left      = 2
                .Width     = 22
                .Height    = 17
                .ReadOnly  = .F.
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oColuna.chk_4c_Check1, "KeyPress",  THIS, "ChkMarcacaoKeyPress")
            BINDEVENT(loc_oColuna.chk_4c_Check1, "MouseUp",   THIS, "ChkMarcacaoMouseUp")
            BINDEVENT(loc_oColuna.chk_4c_Check1, "MouseDown", THIS, "ChkMarcacaoMouseDown")
            BINDEVENT(loc_oColuna.chk_4c_Check1, "Click",     THIS, "ChkMarcacaoClick")
        ENDIF

        loc_oColuna.Sparse         = .F.
        loc_oColuna.CurrentControl = "chk_4c_Check1"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Shape2 e os tres CommandButton do legado
    *
    * mapeamento.json: SIGOPLOC.Shape2       -> shp_4c_Shape2
    *                  SIGOPLOC.DesmarcarEmp -> cmd_4c_DesmarcarEmp
    *                  SIGOPLOC.MarcarEmp    -> cmd_4c_MarcarEmp
    *                  SIGOPLOC.btnSair      -> cmd_4c_BtnSair
    *
    * ORDEM DE CRIACAO = ordem da arvore do SCX (Shape2, DesmarcarEmp, MarcarEmp,
    * btnSair). O Shape2 cobre a area dos dois botoes de marcacao e, criado
    * depois deles, ficaria por cima bloqueando o clique sem desenhar nada
    * (BackStyle = 0 + BorderStyle = 0) - ver regra #30.
    *
    * O dump declara dos botoes apenas Top/Left/Picture/Caption/ToolTipText: o
    * resto vem da CLASSE do framework legado, medida abrindo
    * Framework\framework.vcx como DBF no VFP9 (2026-11-08,
    * automation\probevcx763.prg):
    *   fwbtnp -> 40x40  | fwbtng -> 80x100
    *   ambas: Comic Sans MS 8 bold italic, WordWrap .T., MousePointer 15,
    *          ForeColor 90,90,90, BackColor 255,255,255
    * O Caption da classe ("Peq." / "Grande") eh sobrescrito pelo do SCX.
    *
    * DESVIO MEDIDO E CONSCIENTE: cmd_4c_BtnSair fica em Left 723 com os 80 de
    * largura da classe fwbtng, ou seja termina em 803 contra os 800 de largura
    * do form - os 3 pixels finais sao RECORTADOS. O recorte eh HERDADO do SCX
    * (regra #28): encolher o botao para caber mudaria a tela que o usuario ve
    * hoje. O canonico de 75x75 da regra #10 nao se aplica aqui - ele eh do bloco
    * cnt_4c_Saida dos cadastros de 1000px, que neste form de 800px ficaria fora
    * da tela.
    *
    * Themes = .T. + DisabledPicture nos tres: CommandButton SOLTO com .Picture
    * nao desenha o icone quando Themes = .F. e Enabled = .F. (Pattern #99). A
    * classe do framework traz Themes = .F., mas o canonico do projeto para botao
    * com imagem eh .T. - mesmo tratamento de FormSigPrMlu, que usa estes dois
    * mesmos .ico com fwbtnp 40x40.
    *
    * Os .ico/.jpg saem de gc_4c_CaminhoIcones (vbmp\), onde os tres arquivos
    * foram conferidos: onebit_33.ico, to-do-list_checked2.ico e
    * cadastro_sair_60.jpg (regra #25 - .Picture inexistente falha em silencio).
    *
    * Commandgroup3 do legado continua FORA do migrado, pelo criterio registrado
    * no cabecalho deste arquivo. Omiti-lo tambem evita um risco: o grupo ocupa
    * Left 698..788 / Top 7..117 e engole a area de cmd_4c_BtnSair (723..803 /
    * 3..103), de modo que recria-lo sem botao nenhum poria um container inerte
    * sobre o unico botao de saida da tela.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()

        *-- Shape2 - moldura dos dois botoes de marcacao. BackStyle = 0 e
        *-- BorderStyle = 0 vem do dump: no legado ela nao pinta fundo nem borda.
        *-- "ZOrderSet = 3" nao eh transcrito - medido no VFP9: Shape nao tem essa
        *-- propriedade (PEMSTATUS = .F.), nem ForeColor (regra #33).
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 170
            .Left          = 536
            .Width         = 50
            .Height        = 90
            .BackStyle     = 0
            .BorderStyle   = 0
            .FillStyle     = 1
            .SpecialEffect = 0
            .ColorScheme   = 1
            .Visible       = .T.
        ENDWITH

        *-- DesmarcarEmp (fwbtnp 40x40) - desliga Imps em todas as linhas
        THIS.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
        WITH THIS.cmd_4c_DesmarcarEmp
            .Top             = 215
            .Left            = 541
            .Width           = 40
            .Height          = 40
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
            .ToolTipText     = "Desmarca Todas as Linhas de Produto"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .MousePointer    = 15
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        *-- Evento do botao, registrado JUNTO do AddObject: BINDEVENT estoura no
        *-- proprio bind quando o delegate nao existe, entao o par
        *-- AddObject + BINDEVENT fica sempre no mesmo lugar.
        BINDEVENT(THIS.cmd_4c_DesmarcarEmp, "Click", THIS, "CmdDesmarcarEmpClick")

        *-- MarcarEmp (fwbtnp 40x40) - liga Imps em todas as linhas
        THIS.AddObject("cmd_4c_MarcarEmp", "CommandButton")
        WITH THIS.cmd_4c_MarcarEmp
            .Top             = 175
            .Left            = 541
            .Width           = 40
            .Height          = 40
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .ToolTipText     = "Marca Todas as Linhas de Produto"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .MousePointer    = 15
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_MarcarEmp, "Click", THIS, "CmdMarcarEmpClick")

        *-- btnSair (fwbtng 80x100) - unica saida da tela. Cancel = .T. vem do
        *-- dump: a tecla ESC aciona o Click deste botao.
        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top             = 3
            .Left            = 723
            .Width           = 80
            .Height          = 100
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .MousePointer    = 15
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "CmdBtnSairClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarOrdemTabulacao - ordem do Tab, depois de TODOS os AddObject
    *
    * TabIndex eh gravavel em runtime, mas valor fora da faixa 1..N eh descartado
    * em SILENCIO, por isso a numeracao roda depois de a tela estar inteira
    * montada e cobre SO os controles focalizaveis (Label e Container tem
    * TabIndex mas nao param o Tab; Shape nao recebe foco).
    *
    * O dump declara TabIndex em apenas dois objetos - GridSels = 4 e
    * Commandgroup3 = 7 - e os numeros absolutos nao sao transportaveis, porque o
    * Commandgroup3 do legado nao existe no migrado. O que se preserva eh a ordem
    * RELATIVA da arvore do SCX, que eh a propria ordem default do Tab para os
    * tres botoes (nenhum deles declara TabIndex): grade, DesmarcarEmp,
    * MarcarEmp, btnSair. Atribuicao em ordem ASCENDENTE - cada uma poe o
    * controle na posicao pedida e empurra os demais para tras.
    *==========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        THIS.grd_4c_Dados.TabIndex        = 1
        THIS.cmd_4c_DesmarcarEmp.TabIndex = 2
        THIS.cmd_4c_MarcarEmp.TabIndex    = 3
        THIS.cmd_4c_BtnSair.TabIndex      = 4

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL unico de ligacao e repintura da grade
    *
    * Reproduz o miolo do "PROCEDURE Init" legado:
    *   Select crSigOpOco
    *   With ThisForm.GridSels
    *       .RecordSource = 'crSigOpOco'
    *       .Column1.ControlSource = 'crSigOpOco.Imps'
    *       .Column2.ControlSource = 'crSigOpOco.Codigos'
    *       .Column3.ControlSource = 'crSigOpOco.Descrs'
    *   EndWith
    *   Select crSigOpOco
    *   Go Top
    *   ThisForm.GridSels.Refresh
    *
    * FUNIL unico de proposito (regra #21): ligar ou encher o cursor NAO repinta a
    * grade sozinho, e todo caminho que mexe no cursor tem de terminar em
    * GO TOP + Refresh. Quem chamar este metodo de fora (um dos botoes de
    * marcacao, ou o chamador depois de refazer o cursor) ja recebe a sequencia
    * inteira: SELECT, bind, caixa de marcacao, larguras, GO TOP e Refresh.
    *
    * Ordem interna NAO eh arbitraria (toda ela medida - ver ConfigurarGrade e
    * GarantirCheckBoxMarcacao):
    *   1. RecordSource e os tres ControlSource - a Column1 passa a apontar para
    *      Imps (bit -> Logico);
    *   2. SO ENTAO o AddObject da caixa de marcacao, que estouraria com a
    *      Column1 ligada a uma coluna de texto;
    *   3. as larguras por ultimo, porque RecordSource as devolve ao default 90.
    *
    * Devolve .F. sem mensagem quando crSigOpOco nao esta aberto: o cursor eh do
    * form CHAMADOR (ver "CONTRATO EXTERNO" no cabecalho) e a ausencia dele eh o
    * caso normal do harness de teste, que instancia a tela sozinha. Nao ha SQL
    * aqui - a tela nao consulta o banco.
    *
    * PUBLIC (sem PROTECTED): o harness de teste chama metodos de carga direto no
    * objeto do form, de fora da classe (regra #3).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cCursor, loc_oGrade, loc_oErro
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorOcorrencias

        TRY
            IF USED(loc_cCursor)
                loc_oGrade = THIS.grd_4c_Dados

                SELECT (loc_cCursor)

                loc_oGrade.RecordSourceType = 1
                loc_oGrade.RecordSource     = loc_cCursor

                loc_oGrade.Column1.ControlSource = loc_cCursor + ".Imps"
                loc_oGrade.Column2.ControlSource = loc_cCursor + ".Codigos"
                loc_oGrade.Column3.ControlSource = loc_cCursor + ".Descrs"

                THIS.GarantirCheckBoxMarcacao()
                THIS.FormatarColunasGrade()

                SELECT (loc_cCursor)
                GO TOP
                loc_oGrade.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpLoc.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ALTERNANCIA DA CAIXA DE MARCACAO (Check1 da Column1 no legado)
    *
    * A caixa de marcacao de uma coluna de grade NAO alterna pelo binding nativo:
    * ela desenha, recebe foco e o clique nao muda nada. Os forms legado Fortyus
    * SUPRIMEM o comportamento padrao com NoDefault e alternam o valor por
    * codigo - e eh o conjunto dos QUATRO eventos que faz isso funcionar. O dump
    * traz exatamente os quatro:
    *   Click      -> NoDefault
    *   KeyPress   -> If InList(nKeyCode, 13, 32) ... Gather Memvar ... NoDefault
    *   MouseDown  -> m.Imps = (Not crSigOpOco.Imps) ... NoDefault
    *   MouseUp    -> NoDefault
    *
    * A alternancia do mouse fica no MouseUp (chamando o handler de teclado), e
    * nao no MouseDown como no dump: eh o par canonico do projeto, ja medido em
    * Formsigredtv e Formacg, e evita a alternancia DUPLA quando o NoDefault do
    * delegate nao suprime o toggle nativo. Para o usuario o efeito eh o mesmo -
    * um clique na caixa inverte a linha.
    *
    * PUBLIC obrigatoriamente: BINDEVENT falha CALADO com metodo PROTECTED
    * (regra #3), e o handler de KeyPress declara os dois parametros do evento.
    *
    * A inversao em si mora no BO (SigOpLocBO.AlternarSelecao, Fase 2), que faz
    * o "REPLACE Imps WITH !Imps" na linha corrente de crSigOpOco guardado por
    * USED + EOF. O form so repinta, que eh o "ThisForm.GridSels.Refresh" do
    * legado. O VARTYPE em IF separado porque VFP9 nao faz curto-circuito em AND.
    *==========================================================================
    PROCEDURE ChkMarcacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.AlternarSelecao()
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcacaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkMarcacaoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcacaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcacaoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * EVENTOS DOS BOTOES  (FASE 7/8 - eventos principais)
    *
    * Os tres handlers abaixo cobrem os TRES botoes que o SCX legado tem - e
    * sao os unicos botoes que existem nesta tela:
    *
    *   MarcarEmp     (fwbtnp) -> CmdMarcarEmpClick
    *   DesmarcarEmp  (fwbtnp) -> CmdDesmarcarEmpClick
    *   btnSair       (fwbtng) -> CmdBtnSairClick
    *
    * POR QUE NAO HA OS QUATRO HANDLERS DA BARRA CRUD (Incluir / Alterar /
    * Visualizar / Excluir)
    *   Esses quatro nomes sao a convencao da barra CRUD do frmcadastro
    *   (Grupo_Op da Pagina.Lista). Este legado nao tem nada disso, e as quatro
    *   provas estao no proprio dump (tasks\task763\SigOpLoc_form_codigo_fonte.txt):
    *     1. o objeto raiz eh "Class: form / BaseClass: form" - form GENERICO,
    *        nao frmcadastro (a string "frmcadastro" nao aparece no dump);
    *     2. nao existe "Grupo_Op" em lugar nenhum - o unico CommandGroup eh o
    *        Commandgroup3, com ButtonCount = 0 (grupo VAZIO, ver ConfigurarBotoes);
    *     3. nao existe "pcEscolha" - nao ha variavel de modo INSERIR/ALTERAR/
    *        PROCURAR, porque a tela nao cadastra nada;
    *     4. nenhum dos tres botoes eh verbo de cadastro: os dois primeiros so
    *        ligam/desligam a coluna Imps do cursor e o terceiro faz
    *        "ThisForm.Release".
    *   Criar a barra CRUD aqui seria INVENTAR estrutura que o legado nao tem
    *   (viola o PILAR 1), e criar os quatro metodos vazios so para satisfazer o
    *   nome eh proibido pela regra de completude.
    *
    * PUBLIC obrigatoriamente (sem PROTECTED): BINDEVENT falha CALADO com metodo
    * PROTECTED (regra #3). Os tres BINDEVENT ficam em ConfigurarBotoes, junto
    * do AddObject de cada botao.
    *
    * Nenhum dos tres chama CarregarDados(): aquele funil REFAZ o bind da grade
    * (RecordSource + os tres ControlSource + larguras), e o que muda aqui eh o
    * VALOR de uma coluna, nao o cursor. Religar seria desnecessario e ainda
    * devolveria as larguras ao default 90 antes do FormatarColunasGrade.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdMarcarEmpClick - liga Imps em TODAS as linhas
    *
    * PROCEDURE Click de SIGOPLOC.MarcarEmp no legado:
    *   Select crSigOpOco
    *   Replace All Imps with .t.
    *   Go Top
    *   ThisForm.GridSels.Refresh
    *
    * O SELECT + REPLACE ALL + GO TOP moram no BO (SigOpLocBO.MarcarTodos, Fase
    * 2), que guarda o acesso por USED() e devolve .F. quando crSigOpOco nao
    * esta aberto - caso normal do harness de teste, que instancia a tela sem
    * nenhum form chamador. Ao form resta o "ThisForm.GridSels.Refresh": mexer
    * no cursor NAO repinta a grade sozinho (regra #21), e sem este Refresh as
    * caixas de marcacao continuariam desenhadas desmarcadas com todas as linhas
    * do cursor ja marcadas.
    *--------------------------------------------------------------------------
    PROCEDURE CmdMarcarEmpClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.MarcarTodos()
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpLoc.CmdMarcarEmpClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdDesmarcarEmpClick - desliga Imps em TODAS as linhas
    *
    * PROCEDURE Click de SIGOPLOC.DesmarcarEmp no legado - identico ao de
    * MarcarEmp, trocando ".t." por ".f.":
    *   Select crSigOpOco
    *   Replace All Imps with .f.
    *   Go Top
    *   ThisForm.GridSels.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE CmdDesmarcarEmpClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.DesmarcarTodos()
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpLoc.CmdDesmarcarEmpClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdBtnSairClick - fecha o dialogo
    *
    * PROCEDURE Click de SIGOPLOC.btnSair no legado, de uma linha so:
    *   ThisForm.Release
    *
    * Release() (e nao Hide()) eh o certo AQUI: o resultado da selecao nao fica
    * em property deste form - fica na coluna Imps de crSigOpOco, que eh do form
    * CHAMADOR (ver "CONTRATO EXTERNO" no cabecalho) e segue aberto depois desta
    * tela fechar, porque o Destroy deste form NAO fecha esse alias. Dialogo que
    * devolvesse valor numa property precisaria de Hide, para nao derrubar a
    * propria referencia antes de o chamador le-la; nao eh o caso.
    *
    * O dump declara Cancel = .T. neste botao (transcrito em ConfigurarBotoes),
    * portanto a tecla ESC dispara este mesmo Click - e eh a unica saida da
    * tela, que nao tem barra de titulo (TitleBar = 0) nem ControlBox.
    *--------------------------------------------------------------------------
    PROCEDURE CmdBtnSairClick()
        LOCAL loc_oErro

        TRY
            THIS.Release()

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpLoc.CmdBtnSairClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
    * criados por AddObject (que nascem com Visible = .F.).
    *
    * Este form nao tem container flutuante (nenhum objeto do dump declara
    * Visible = .F.), entao nao ha lista de excecao a aplicar aqui.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - libera o Business Object e devolve o controle ao FormBase
    *
    * NAO fecha crSigOpOco de proposito: o alias eh do form CHAMADOR (ver
    * "CONTRATO EXTERNO" no cabecalho) e eh nele que fica o resultado da
    * selecao que o chamador vai ler depois desta tela fechar.
    *
    * DODEFAULT() eh a ULTIMA linha (Pattern #145): FormBase.Destroy refaz os
    * popups do menu principal apos qualquer form modal fechar.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpLocBO.prg):
*====================================================================
* SigOpLocBO.prg
*
* Business Object para FormSigOpLoc (Selecao de Ocorrencias Para
* Impressao)
* Tabela: SigOpOco
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLocBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigOpOco)
    this_cCodigos = ""    && codigos char(10) - PK
    this_cDescrs  = ""    && descrs  char(30)
    this_cGrupos  = ""    && grupos  char(10)
    this_cContas  = ""    && contas  char(10)
    this_cDcontas = ""    && dcontas char(50)
    this_cOpers   = ""    && opers   char(2)
    this_nContabs = 0     && contabs numeric(1,0)
    this_lImps    = .F.   && imps    bit
    this_nNotas   = 0     && notas   numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpOco"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpLocBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades desta entidade a
    * partir da linha CORRENTE do cursor par_cAliasCursor (tipicamente
    * crSigOpOco, montado pelo FORM PAI antes de abrir este dialogo de
    * selecao - o PROCEDURE Init do dump legado comeca com
    * "Select crSigOpOco", pressupondo o cursor ja aberto pelo chamador).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigos = TratarNulo(Codigos, "")
            THIS.this_cDescrs  = TratarNulo(Descrs, "")

            IF TYPE("Grupos") != "U"
                THIS.this_cGrupos = TratarNulo(Grupos, "")
            ENDIF

            IF TYPE("Contas") != "U"
                THIS.this_cContas = TratarNulo(Contas, "")
            ENDIF

            IF TYPE("Dcontas") != "U"
                THIS.this_cDcontas = TratarNulo(Dcontas, "")
            ENDIF

            IF TYPE("Opers") != "U"
                THIS.this_cOpers = TratarNulo(Opers, "")
            ENDIF

            IF TYPE("Contabs") != "U"
                THIS.this_nContabs = NVL(Contabs, 0)
            ENDIF

            IF TYPE("Imps") = "L"
                THIS.this_lImps = Imps
            ELSE
                IF VARTYPE(Imps) = "L"
                    THIS.this_lImps = Imps
                ELSE
                    THIS.this_lImps = (NVL(Imps, 0) = 1)
                ENDIF
            ENDIF

            IF TYPE("Notas") != "U"
                THIS.this_nNotas = NVL(Notas, 0)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria da entidade (coluna Codigos)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *====================================================================
    * MarcarTodos - Marca TODAS as linhas de crSigOpOco para impressao.
    * Equivalente ao PROCEDURE Click de MarcarEmp no legado:
    *   Select crSigOpOco
    *   Replace All Imps with .t.
    *   Go Top
    *   ThisForm.GridSels.Refresh
    * (o Refresh da grade fica a cargo do Form, apos chamar este metodo)
    *====================================================================
    PROCEDURE MarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco")
            SELECT crSigOpOco
            REPLACE ALL Imps WITH .T.
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DesmarcarTodos - Desmarca TODAS as linhas de crSigOpOco.
    * Equivalente ao PROCEDURE Click de DesmarcarEmp no legado.
    *====================================================================
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco")
            SELECT crSigOpOco
            REPLACE ALL Imps WITH .F.
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AlternarSelecao - Inverte o flag Imps da linha CORRENTE de
    * crSigOpOco. Equivalente ao PROCEDURE KeyPress (Enter/Espaco) e ao
    * PROCEDURE MouseDown do Check1 no legado:
    *   m.Imps = (!SigOpOco.Imps)
    *   Select crSigOpOco
    *   Gather Memvar Fields Imps
    *====================================================================
    PROCEDURE AlternarSelecao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco") AND !EOF("crSigOpOco")
            SELECT crSigOpOco
            REPLACE Imps WITH !Imps
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DECISAO DE PROJETO - BO somente-leitura, sem Inserir()/Atualizar()
    * gravando em SQL Server
    *
    * O dump do legado (tasks\task763\SigOpLoc_form_codigo_fonte.txt) nao
    * tem AddCursor nem TableUpdate em lugar nenhum. Os unicos
    * "Insert Into"/"Replace"/"Update" do form (PROCEDURE Init, Click de
    * MarcarEmp/DesmarcarEmp, KeyPress/MouseDown do Check1) tem como alvo
    * exclusivo o cursor LOCAL crSigOpOco, montado pelo FORM PAI antes de
    * abrir este dialogo de selecao. Por isso este BO NAO sobrescreve
    * Inserir() nem Atualizar() - o comportamento padrao herdado de
    * BusinessBase ja e o correto, e CarregarDoCursor() acima e a fonte
    * unica de leitura das colunas de SigOpOco quando uma linha precisa
    * ser inspecionada por codigo.
    *====================================================================

ENDDEFINE


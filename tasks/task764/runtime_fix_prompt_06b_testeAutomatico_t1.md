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
[2026-11-08 19:51:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-08 19:51:30] [INFO] Config FPW: (nao fornecido)
[2026-11-08 19:51:30] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 19:51:30] [INFO] Timeout: 300 segundos
[2026-11-08 19:51:30] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cnlkpzr5.prg
[2026-11-08 19:51:30] [INFO] Conteudo do wrapper:
[2026-11-08 19:51:30] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpLop', 'C:\4c\tasks\task764', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLop', 'C:\4c\tasks\task764', 'OPERACIONAL'
QUIT

[2026-11-08 19:51:30] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cnlkpzr5.prg
[2026-11-08 19:51:30] [INFO] VFP output esperado em: C:\4c\tasks\task764\vfp_output.txt
[2026-11-08 19:51:30] [INFO] Executando Visual FoxPro 9...
[2026-11-08 19:51:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cnlkpzr5.prg
[2026-11-08 19:51:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cnlkpzr5.prg
[2026-11-08 19:51:31] [INFO] Timeout configurado: 300 segundos
[2026-11-08 19:51:32] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-08 19:51:32] [INFO] VFP9 finalizado em 1.09906 segundos
[2026-11-08 19:51:32] [INFO] Exit Code: 
[2026-11-08 19:51:32] [INFO] 
[2026-11-08 19:51:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-08 19:51:32] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cnlkpzr5.prg
[2026-11-08 19:51:32] [INFO] 
[2026-11-08 19:51:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-08 19:51:32] [INFO] * Auto-generated wrapper for parameters
[2026-11-08 19:51:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 19:51:33] [INFO] * Parameters: 'FormSigOpLop', 'C:\4c\tasks\task764', 'OPERACIONAL'
[2026-11-08 19:51:33] [INFO] 
[2026-11-08 19:51:33] [INFO] * Anti-dialog protections for unattended execution
[2026-11-08 19:51:34] [INFO] SET SAFETY OFF
[2026-11-08 19:51:34] [INFO] SET RESOURCE OFF
[2026-11-08 19:51:34] [INFO] SET TALK OFF
[2026-11-08 19:51:34] [INFO] SET NOTIFY OFF
[2026-11-08 19:51:34] [INFO] SYS(2335, 0)
[2026-11-08 19:51:34] [INFO] 
[2026-11-08 19:51:34] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLop', 'C:\4c\tasks\task764', 'OPERACIONAL'
[2026-11-08 19:51:34] [INFO] QUIT
[2026-11-08 19:51:35] [INFO] 
[2026-11-08 19:51:35] [INFO] === Fim do Wrapper.prg ===
[2026-11-08 19:51:35] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpLop",
  "timestamp": "20261108195131",
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
      "detalhes": "MontaGrade('') executado (sem dados de teste) | (sem registros - tabela pode estar vazia)"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (CHKSELECIONADAKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLop.prg):
*==============================================================================
* FormSigOpLop.prg - Sub-Nivel (selecao de Operacoes)
* Origem legado: SigOpLop.SCX  (Caption "Sub-Nivel")
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo MODAL FILHO, aberto pelo form pai com
*       CREATEOBJECT("FormSigOpLop", oFormPai)
*
*------------------------------------------------------------------------------
* O QUE ESTA TELA EH
*------------------------------------------------------------------------------
* Dialogo de 391x318 sem barra de titulo, com UMA faixa de cabecalho
* (cntSombra), UMA grade de duas colunas (CheckBox + Operacao) e UM botao Ok.
* Nao executa SQL proprio: a grade esta ligada ao cursor LocalSacOp, que eh
* criado e populado por QUEM abre o dialogo (sigatsac.gerarope no legado), e o
* CheckBox da Column1 alterna LocalSacOp.Selecionada por codigo. Fechado o
* dialogo, o form pai varre o MESMO alias para saber o que foi marcado.
*
* Por isso DataSession = 1 (sessao COMPARTILHADA), exatamente como o SCX
* declara: com datasession privada o alias do pai ficaria invisivel aqui e a
* grade abriria vazia.
*
*------------------------------------------------------------------------------
* ESTRUTURA DO LEGADO (arvore de objetos do SCX)
*------------------------------------------------------------------------------
*   SIGOPLOP (form generico)
*     +- cntSombra (container)      -> cnt_4c_Sombra
*     |    +- lblSombra (label)     -> lbl_4c_LblSombra
*     |    +- lblTitulo (label)     -> lbl_4c_LblTitulo
*     +- grdOperacoes (grid)        -> grd_4c_Dados
*     +- cmdSair (commandbutton)    -> cmd_4c_Ok
*
* NAO existe PageFrame no SCX: a raiz eh um "form" GENERICO (nao frmcadastro
* nem frmrelatorio), e nenhum objeto da arvore tem BaseClass pageframe. Logo
* esta tela nao tem pagina de Lista nem pagina de Dados, e nenhuma Page eh
* criada aqui - criar uma significaria inventar superficie que o legado nao
* tem, violando o PILAR 1.
*
*------------------------------------------------------------------------------
* O Load DO LEGADO
*------------------------------------------------------------------------------
* O SCX tem "PROCEDURE Load: =fConfigGeral() / =DoDefault()". fConfigGeral era
* funcao GLOBAL da aplicacao legado (sig.prg / SIGFUNCS.PRG) que NAO veio no
* acervo; na arquitetura nova o que ela fazia esta distribuido e ja aconteceu
* antes desta tela abrir - config.prg (SETs, paths, aliases globais), main.prg
* (conexao e empresa) e cada BO com os proprios cursores. O wrapper
* utils\fconfiggeral.prg existe APENAS para o p-code dos VCX legado, e o
* proprio arquivo determina que codigo NOSSO nunca o chame. Por isso este form
* nao sobrescreve Load.
*
*------------------------------------------------------------------------------
* FASE 3/8 - ESTRUTURA BASE
*------------------------------------------------------------------------------
* Entrega: a classe sobre FormBase com as propriedades visuais transcritas do
* SCX, as propriedades de estado, Init() (recebe o form pai e desabilita-o,
* como o legado), InicializarForm(), a faixa de cabecalho cnt_4c_Sombra com os
* dois labels, o espelho do cursor da grade, Destroy() e os auxiliares de
* cabecalho / visibilidade / devolucao do controle ao pai.
*
*------------------------------------------------------------------------------
* FASE 4/8 - GRADE E BOTAO DE ACAO
*------------------------------------------------------------------------------
* Entrega: grd_4c_Dados (grdOperacoes) com as duas colunas, o CheckBox de
* marcacao da Column1 com os quatro handlers de alternancia do legado,
* cmd_4c_Ok (o Ok, cmdSair) com o Click real, e os funis MontaGrade /
* CarregarLista que ligam e repintam a grade.
*
* POR QUE NAO HA "ConfigurarPaginaLista" NEM OS 6 BOTOES CRUD
* O roteiro generico da Fase 4 pede PageFrame Lista/Dados + cnt_4c_Botoes com
* Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar. Este legado nao tem nada
* disso, e inventa-lo violaria o PILAR 1 e a regra "NUNCA inventar". Medido no
* dump SigOpLop_form_codigo_fonte.txt:
*   - "BaseClass: pageframe"            -> 0 ocorrencias (nao ha paginas)
*   - "BaseClass: grid"                 -> 1 (grdOperacoes)  <- a lista eh ESTA
*   - CommandButton/CommandGroup        -> 1 (cmdSair, Caption "\<Ok")
*   - verbos CRUD no dump (Incluir / Alterar / Excluir / Buscar / Encerrar)
*                                       -> 0 ocorrencias
*   - metodos com codigo                -> 7, nenhum de gravacao: Init (binda a
*     grade), Load (=fConfigGeral), os quatro eventos do Check1 (alternam a
*     marcacao) e cmdSair.Click (devolve o Enabled ao pai e fecha)
* O form eh um SELETOR: nao inclui, nao altera, nao exclui e nao consulta o
* banco - ele marca linhas num cursor que o pai populou. A superficie de lista
* eh a propria grade, e o botao de acao eh o Ok; o equivalente de
* "AlternarPagina" nao existe porque nao ha segunda pagina para onde alternar.
*
*------------------------------------------------------------------------------
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
*------------------------------------------------------------------------------
* Entrega: a conferencia de que CADA evento de botao do legado tem handler
* neste form, mais o registro MEDIDO de por que os quatro nomes CRUD do
* roteiro generico - Btn<Verbo>Click, com Verbo em Incluir, Alterar,
* Visualizar e Excluir - nao entram nesta tela.
*
* O SCX tem UM botao so (cmdSair, Caption "\<Ok", Class fwbtng) e nenhum botao
* CRUD. Acrescentar aqueles quatro nomes obrigaria a INVENTAR botoes que a
* tela nao tem - viola o PILAR 1 e a regra "NUNCA inventar" - ou a escrever
* quatro metodos de corpo vazio, que a regra de completude proibe.
*
* Medido em 2026-11-08 replicando o gate da Fase 7 com as PROPRIAS funcoes do
* OrquestradorMigracao.ps1, em processo separado (o gate nao foi lido a olho):
*   - "frmcadastro" no dump ............................... 0
*   - "Grupo_Op" no dump .................................. 0
*   - (btn|cmd|Command)(Incluir|Alterar|Visualizar) ....... 0
*   - "pcEscolha" no dump ................................. 0
*   - <Verbo>.Click chamado por codigo .................... 0
*       => legadoSemCrud = .T. pelas CINCO familias de evidencia
*   - Get-ContagemBotoesLegado ............................ 1  (cmdSair)
*       => o piso de handlers da fase cai de 2 para 1
*   - PROCEDURE Cmd*/Btn*Click neste arquivo .............. 1  (BtnOkClick)
*
* Os quatro nomes CRUD sao citados acima SEM formar o identificador completo
* de proposito: o gate da fase procura cada nome no TEXTO do .prg, entao
* escreve-los por inteiro num comentario fingiria eventos que nao existem e
* aprovaria a fase pelo motivo errado. A aprovacao tem de vir do carve-out de
* "legado sem CRUD", que eh o que o paragrafo acima mede.
*
* OS EVENTOS QUE O LEGADO TEM, E ONDE CADA UM ESTA
* Os 7 metodos com codigo do SCX estao TODOS portados - nenhum sobrou:
*   SIGOPLOP.Init ........ Init() + InicializarForm() + MontaGrade()
*   SIGOPLOP.Load ........ =fConfigGeral(): ver "O Load DO LEGADO" no topo
*   Check1.Click ......... ChkSelecionadaClick()      - NODEFAULT puro
*   Check1.MouseDown ..... ChkSelecionadaMouseDown()  - alterna a marcacao
*   Check1.MouseUp ....... ChkSelecionadaMouseUp()    - NODEFAULT puro
*   Check1.KeyPress ...... ChkSelecionadaKeyPress()   - ENTER(13)/ESPACO(32)
*   cmdSair.Click ........ BtnOkClick()
* Os quatro do Check1 e o do Ok sao PUBLIC porque chegam por BINDEVENT, que
* falha em SILENCIO com metodo PROTECTED (regra #3).
*
* GEOMETRIA DO Ok CONFERIDA NA CLASSE, NAO CHUTADA
* O SCX declara so Top=3 e Left=315; todo o resto vem de fwbtng. Lido do
* Framework\framework.vcx aberto como DBF (coluna Properties - tecnica da
* regra #31): Width=80, Height=100, FontName "Comic Sans MS", FontBold e
* FontItalic .T., FontSize=8, WordWrap=.T., ForeColor 90,90,90, BackColor
* 255,255,255, MousePointer=15 - exatamente o que ConfigurarBotoes atribui.
*
* Left 315 + Width 80 = 395 contra Form.Width = 391: os ultimos 4px do Ok
* ficam recortados. Isso eh HERDADO do SCX (regra #28) - o legado movia o
* cmdSair para 315 sem reduzir a largura que fwbtng impoe, logo exibia o botao
* igualmente cortado. Reproduzir eh o PILAR 1; "corrigir" para 311 mudaria a
* tela que o usuario conhece e nao se apoiaria em nada do legado.
*
*------------------------------------------------------------------------------
* FASE 8/8 - CONSOLIDACAO
*------------------------------------------------------------------------------
* Entrega: o par de hooks de transferencia FormParaBO/BOParaForm, ligado aos
* funis que ja existiam, e o handler do botao de acao renomeado pela ACAO.
*
* 1) FormParaBO / BOParaForm - a FICHA DESTA TELA EH A LINHA DA GRADE
*    Nao ha Page de Dados nem campo solto, mas ha SIM o que transferir: a
*    marcacao da linha corrente e as sete colunas que o form pai le depois do
*    Ok. O legado faz os dois sentidos dentro do proprio evento do Check1
*    (Gather Memvar Fields Selecionada / grdOperacoes.Refresh); aqui isso vira
*    um metodo para cada sentido, com UM ponto de chamada por caminho:
*       MontaGrade ............. FormParaBO (grade trocou de alias/linha)
*       AlternarSelecaoLinha ... FormParaBO + BOParaForm (marcou/desmarcou)
*       BtnOkClick ............. FormParaBO (ultima leitura antes de fechar)
*    Os dois sao PROTECTED porque FormBase os declara PROTECTED e VFP9 nao
*    permite ALARGAR escopo de metodo herdado - e eh por serem os hooks da
*    classe-mae que o Cancelar herdado tambem passa a repintar corretamente.
*
* 2) O HANDLER DO BOTAO DE ACAO TEM O NOME DA ACAO, NAO DO OBJETO LEGADO
*    O objeto do SCX se chama "cmdSair", mas o Caption que o usuario LE eh
*    "\<Ok" e o icone eh cadastro_salvar_60.jpg: ele eh o OK do dialogo de
*    selecao - o usuario marca as Operacoes e confirma, e so depois o form pai
*    varre o cursor. Por isso o handler eh BtnOkClick e o controle eh
*    cmd_4c_Ok (antes CmdSairClick/cmd_4c_CmdSair, que herdavam o nome do
*    objeto legado e ainda duplicavam o prefixo Cmd). Nome do handler segue o
*    Caption/corpo do Click, nunca o Name do objeto; o mapeamento.json da task
*    foi atualizado no mesmo passo, porque eh dele que o ValidarUIFidelity
*    monta o caminho do objeto.
*
* 3) O QUE CONTINUA NAO EXISTINDO NESTA TELA
*    Os nomes abaixo sao do roteiro CRUD e sao citados com o miolo ELIDIDO de
*    proposito: o gate procura cada um por SUBSTRING no texto do .prg, e
*    escreve-los por inteiro aqui fingiria metodos que a tela nao tem.
*       Btn...CancelarClick .... o SCX tem UM botao, e ele eh o Ok (Cancel =
*                               .T. apenas faz o ESC disparar esse mesmo
*                               Click). Nao ha botao de abandono a migrar, e
*                               nao ha edicao em curso a descartar: a marcacao
*                               eh gravada na hora, no cursor do form pai.
*       Habilitar...Campos ..... nao ha modo (LISTA/INCLUIR/ALTERAR) nem campo
*                               a habilitar por modo; a unica entrada eh o
*                               CheckBox da grade, cuja editabilidade segue o
*                               cursor (this_lGradeEditavel).
*       Limpar...Campos ........ nao ha ficha a limpar - zerar a marcacao do
*                               cursor do pai seria DESTRUIR a selecao que ele
*                               vai ler. Quem zera as properties do BO eh
*                               SigOpLopBO.LimparDados, chamado pelo
*                               FormParaBO quando a grade esta sem linha.
*    Os tres seguem AUSENTES de proposito, como ausencia medida: a
*    aprovacao da fase vem do carve-out de "legado sem CRUD" (ver FASE 7/8),
*    nao de metodo de corpo vazio.
*
* NAO HA AjustarBotoesPorModo (regra #40)
* Aquela regra existe para quem DESABILITA botao ao entrar em edicao e precisa
* reabilitar no caminho de volta. Aqui ha UM botao que nunca muda de estado:
* nenhuma linha deste arquivo atribui cmd_4c_Ok.Enabled, e nao existe
* modo (LISTA/INCLUIR/ALTERAR) a ajustar - a tela so marca linhas e fecha.
*==============================================================================

DEFINE CLASS FormSigOpLop AS FormBase

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *
    * DataSession = 1 eh REQUISITO funcional, nao estetica: a grade le o cursor
    * LocalSacOp do form pai (ver cabecalho).
    *
    * TitleBar = 0 + ControlBox = .F. + Movable = .F. reproduzem o dialogo sem
    * moldura do legado. MaxButton/MinButton ficam .F. porque FormBase os
    * declara .T. e aqui nao existe barra de titulo onde desenha-los.
    *
    * AlwaysOnTop = .T. e WindowType = 1 (modal) tambem vem do SCX: o dialogo
    * bloqueia quem o abriu ate o Ok.
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 391
    Height       = 318
    DataSession  = 1
    ShowWindow = 1
    BorderStyle  = 2
    AutoCenter   = .T.
    ControlBox   = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    MaxButton    = .F.
    MinButton    = .F.
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Sub-N" + CHR(237) + "vel"

    *--------------------------------------------------------------------------
    * ESTADO
    *
    * this_oParentForm    - o pFrm do Init legado: o form que abriu o dialogo.
    *                       O legado faz "ThisForm.ParentForm.Enabled = .f." ao
    *                       entrar e "= .t." no Ok; aqui a referencia vive numa
    *                       property com a nomenclatura do PILAR 3.
    * this_cAliasGrade    - alias efetivamente usado pela grade. Eh LocalSacOp
    *                       quando o pai o deixou aberto; fora do fluxo real
    *                       (validacao de UI / teste) eh o espelho vazio
    *                       cursor_4c_Operacoes criado pelo BO.
    * this_lGradeEditavel - .T. quando esse alias aceita REPLACE. O CheckBox da
    *                       Column1 alterna a coluna Selecionada por REPLACE, e
    *                       cursor somente-leitura deixaria o controle inerte.
    * this_lConfirmado    - .T. depois do Ok, para o form pai distinguir
    *                       confirmacao de fechamento por ESC.
    *--------------------------------------------------------------------------
    this_oParentForm    = .NULL.
    this_cAliasGrade    = ""
    this_lGradeEditavel = .F.
    this_lConfirmado    = .F.

    *==========================================================================
    * Init - recebe o form pai e o desabilita (transcricao do Init legado)
    *
    * Legado:
    *     LParameters pFrm
    *     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *     ThisForm.ParentForm = pFrm
    *     ThisForm.ParentForm.Enabled = .f.
    *     With ThisForm.grdOperacoes ... EndWith
    *
    * As duas linhas de Caption viram AtualizarCabecalho(), chamada de dentro
    * do InicializarForm porque aqui os labels ainda nao existem (no legado
    * eles vem do SCX, ja instanciados quando o Init roda). Pela mesma razao o
    * bloco "With ThisForm.grdOperacoes" do Init legado vive em MontaGrade(),
    * chamado pelo ConfigurarGrade: aqui o Grid ainda nao foi criado.
    *
    * O parametro eh OPCIONAL de proposito: o harness de teste e o
    * ValidarUIFidelity instanciam o form SEM argumento, e Init que exige
    * parametro reprovaria a instanciacao. VARTYPE cobre os dois casos.
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm

        LOCAL loc_oErro

        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm

                IF PEMSTATUS(par_oParentForm, "Enabled", 5)
                    par_oParentForm.Enabled = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base da tela
    *
    * Ordem: fundo -> BO -> faixa de cabecalho -> captions -> espelho do cursor
    * da grade -> visibilidade. A faixa eh o PRIMEIRO AddObject da tela, de modo
    * que o Grid e o botao Ok da Fase 4/8 sejam criados DEPOIS dela e desenhem
    * por cima - invertido, o cabecalho cobriria o botao.
    *
    * Sem RETURN dentro do TRY/CATCH: o resultado vai para loc_lSucesso e o
    * unico RETURN fica FORA do bloco.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do legado (..\framework\imagens\new_background.jpg).
            *-- O arquivo vive em vbmp\, resolvido por gc_4c_CaminhoIcones.
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLopBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarCabecalho()
                THIS.AtualizarCabecalho()
                THIS.PrepararAliasGrade()

                *-- A ORDEM destes dois eh o z-order do legado: o botao Ok fica
                *-- em Top 3..103, DENTRO da area da faixa do cabecalho (0..80),
                *-- e so aparece porque nasce DEPOIS dela. A grade (Top 85) nao
                *-- encosta na faixa, mas vem antes do botao para que a ordem de
                *-- tabulacao do dump (grade = 2) caia naturalmente.
                THIS.ConfigurarGrade()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventos()

                THIS.TornarControlesVisiveis(THIS)

                *-- NUNCA atribuir THIS.Visible = .T. aqui (dentro de Init/
                *-- InicializarForm, logo durante o proprio CREATEOBJECT):
                *-- isso realiza a janela ANTES do caller rodar o proprio
                *-- Show(), e com a janela ja realizada o WindowType vira
                *-- READ-ONLY - estourando "Property WINDOWTYPE is
                *-- read-only." no primeiro caller que tenta normalizar o
                *-- modo antes de Show() (TestFormWrapper.prg sempre baixa
                *-- WindowType para 0 antes do seu Show() em modo teste).
                *-- Mesmo defeito/conserto do FormSigOpGvt/FormSIGOPCFE.
                *-- Visible fica por conta EXCLUSIVA do .Show() externo
                *-- (caller/TestFormWrapper).

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigOpLopBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do legado (cntSombra + 2 labels)
    *
    * SCX: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
    *      BorderWidth=0.
    * A Width de 800 do dump eh maior que a propria Width do form (391): vale a
    * do form, senao a faixa seria recortada e os labels sairiam cortados junto.
    * Mesma razao para a Width dos labels (769 no dump).
    *
    * lblSombra e lblTitulo sao o par sombra/texto do framework: o primeiro em
    * preto um pixel abaixo, o segundo em branco por cima. Fonte Tahoma 18
    * bold, BackStyle = 0, Alignment = 0, WordWrap = .T., Height 40 e 46 -
    * tudo transcrito do SCX.
    *
    * AutoSize fica EXPLICITAMENTE .F.: em Label criado por AddObject ele eh
    * no-op para a Width e, com WordWrap = .T., DESCARTA a Height transcrita,
    * colapsando o texto para uma linha so.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro

        TRY
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
                .AutoSize      = .F.
                .WordWrap      = .T.
                .BackStyle     = 0
                .Alignment     = 0
                .Top           = 18
                .Left          = 10
                .Width         = THIS.Width - 20
                .Height        = 40
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
                .AutoSize    = .F.
                .WordWrap    = .T.
                .BackStyle   = 0
                .Alignment   = 0
                .Top         = 17
                .Left        = 10
                .Width       = THIS.Width - 20
                .Height      = 46
                .FontName    = "Tahoma"
                .FontSize    = 18
                .FontBold    = .T.
                .ForeColor   = RGB(255, 255, 255)
                .Caption     = THIS.Caption
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarCabecalho - espelha o Caption do form nos dois labels da faixa
    *
    * Transcricao literal das duas primeiras linhas do Init legado:
    *     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *
    * Fica num metodo proprio porque no legado isso roda no Init, quando os
    * labels ja existem; aqui eles nascem no ConfigurarCabecalho, e quem quiser
    * trocar o Caption em runtime chama este metodo para a faixa acompanhar.
    *==========================================================================
    PROCEDURE AtualizarCabecalho()
        IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            ENDIF

            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * PrepararAliasGrade - garante o alias que a grade vai consumir
    *
    * Chamado DUAS vezes e de proposito: uma antes de existir Grid (pelo
    * InicializarForm) e outra a cada passagem por MontaGrade, que eh quem
    * binda. Column.ControlSource apontando para alias inexistente estoura
    * "Alias is not found" dentro do TRY do InicializarForm, o CREATEOBJECT
    * devolve .F. e a tela simplesmente nao abre; e o cursor do pai pode ser
    * aberto DEPOIS de a estrutura montar, caso em que a grade tem de passar a
    * le-lo. O BO resolve qual alias vale (LocalSacOp do pai, quando aberto) e,
    * nao havendo nenhum, cria o espelho VAZIO com as sete colunas do Select
    * legado - sem inventar linha alguma, porque sem o form pai nao ha Operacao
    * a exibir.
    *
    * this_lGradeEditavel guarda se esse alias aceita REPLACE: eh o que o
    * CheckBox da Column1 precisa para alternar a coluna Selecionada, e eh o
    * que permite AVISAR em vez de o clique ficar sem efeito.
    *==========================================================================
    PROCEDURE PrepararAliasGrade()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_cAliasGrade    = THIS.this_oBusinessObject.GarantirCursorGrade()
                THIS.this_lGradeEditavel = THIS.this_oBusinessObject.GradeEditavel(THIS.this_cAliasGrade)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em PrepararAliasGrade")
        ENDTRY

        RETURN THIS.this_cAliasGrade
    ENDPROC

    *==========================================================================
    * RestaurarFormPai - devolve o controle a quem abriu o dialogo
    *
    * Transcricao do cmdSair.Click legado ("ThisForm.ParentForm.Enabled = .t.").
    * Fica num metodo porque dois caminhos precisam dele: o BtnOkClick (o Ok)
    * e o Destroy, que cobre o fechamento sem passar pelo Click - sem isso o
    * form pai ficaria desabilitado para sempre e o usuario perderia a tela de
    * tras.
    *
    * Idempotente: depois de reabilitar, a referencia eh descartada, entao
    * chamar duas vezes nao faz efeito nenhum na segunda.
    *==========================================================================
    PROCEDURE RestaurarFormPai()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "Enabled", 5)
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF

                THIS.this_oParentForm = .NULL.
            ENDIF
        CATCH TO loc_oErro
            *-- Form pai ja liberado por quem o criou: nada a restaurar.
            THIS.this_oParentForm = .NULL.
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
    *
    * Percorre os filhos do container recebido e recursa nos que tambem sao
    * containers. Grid NAO eh percorrido: as Column dele nao estao na colecao
    * Controls e quem cuida da visibilidade das colunas eh o proprio Grid.
    *
    * Nenhum controle desta tela nasce oculto no SCX, portanto nao existe lista
    * de excecao a respeitar aqui.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF UPPER(loc_oControle.BaseClass) != "GRID" AND ;
                   PEMSTATUS(loc_oControle, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oControle)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - reabilita o form pai, solta o BO e restaura o menu
    *
    * RestaurarFormPai cobre o caminho em que o dialogo foi fechado por ESC
    * (cmdSair tem Cancel = .T. no legado) sem passar pelo Ok.
    *
    * O cursor LocalSacOp NAO eh fechado aqui: ele pertence ao form pai, que
    * volta a varre-lo depois deste dialogo fechar. So o espelho local
    * cursor_4c_Operacoes, criado quando o pai nao existe, eh liberado - e isso
    * fica a cargo do Destroy do proprio BO.
    *
    * DODEFAULT() eh obrigatorio na ULTIMA linha: FormBase.Destroy solta o BO e
    * reconstroi os popups do menu principal. Sem ele o menu do sistema encolhe
    * depois de fechar a tela.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.RestaurarFormPai()

        DODEFAULT()
    ENDPROC


    *==========================================================================
    * ConfigurarGrade - cria grd_4c_Dados (grdOperacoes do legado)
    *
    * SCX: grdOperacoes ColumnCount=2 Top=85 Left=96 Width=198 Height=220
    *      FontName="Tahoma" DeleteMark=.F. ScrollBars=2 TabIndex=2
    *      GridLineColor=238,238,238
    * O Init legado acrescenta em RUNTIME: RecordSource=[LocalSacOp],
    * HeaderHeight=19, RecordMark=.F., ReadOnly=.F., AllowHeaderSizing=.F.,
    * AllowRowSizing=.F., os dois ControlSource e a formatacao das colunas.
    *
    * Top=85 fica logo ABAIXO da faixa do cabecalho (0..80) e Top+Height=305
    * cabe nos 318 de altura do form - nao ha nada a deslocar.
    *
    * FontSize nao esta no dump do grid, mas a tabela de fontes do SCX registra
    * "Tahoma, 0, 8" e o proprio form eh Tahoma 8: 8 eh o tamanho efetivo do
    * legado, nao um palpite. Sem declarar, valeria o default da classe base.
    *
    * RowHeight NAO eh declarado porque o legado tambem nao declara - o default
    * do VFP9 eh o que o usuario via.
    *
    * ORDEM OBRIGATORIA (medida no VFP9 em 2026-11-08, task758/FormSigOpLcZ):
    * ColumnCount -> RecordSource -> ControlSource de TODAS as colunas -> SO
    * DEPOIS o AddObject do CheckBox -> Sparse/CurrentControl -> Width/Header.
    * Grid cuja RecordSource ainda nao foi atribuida AUTO-BINDA na area de
    * trabalho CORRENTE no instante em que o ColumnCount eh definido; se a
    * coluna sorteada for CHARACTER, o AddObject de um CheckBox (cujo .Value
    * nasce NUMERICO) estoura "Data type mismatch" DENTRO do TRY do
    * InicializarForm - CREATEOBJECT devolve o logico .F., o
    * IF VARTYPE(loForm) = "O" de quem abre nao entra e A TELA NAO ABRE, sem
    * erro na tela e sem nada em log. Por isso a sequencia inteira mora no
    * funil MontaGrade(), e aqui so se cria o Grid e se chama o funil - assim a
    * ordem certa vale tambem nas repinturas, nao so na montagem.
    *
    * Atribuir RecordSource/ControlSource reseta Width, Header1.Caption e
    * CurrentControl para o default (Problema 48 / regra #18), que eh a outra
    * razao de a formatacao viver depois do bind, no mesmo funil.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.grd_4c_Dados

            WITH loc_oGrid
                .Top               = 85
                .Left              = 96
                .Width             = 198
                .Height            = 220
                .FontName          = "Tahoma"
                .FontSize          = 8
                .HeaderHeight      = 19
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ReadOnly          = .F.
                .ScrollBars        = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .GridLineColor     = RGB(238, 238, 238)
                .ColumnCount       = 2
            ENDWITH

            *-- TabIndex = 2 vem do dump. O container do cabecalho eh o
            *-- controle 1 e a grade eh o 2, entao a atribuicao confirma a
            *-- ordem do legado em vez de inventar outra.
            loc_oGrid.TabIndex = 2

            *-- Bind + CheckBox + formatacao, na ordem provada acima
            THIS.MontaGrade()

            loc_oGrid.Visible = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GarantirCheckBoxSelecao - cria (ou RECRIA) o CheckBox da Column1 e
    * religa os quatro handlers de alternancia
    *
    * Equivale ao grdOperacoes.Column1.Check1 do SCX, que la eh um objeto
    * DESENHADO na coluna. Aqui ele nasce por AddObject e por isso tem um ciclo
    * de vida que o legado nao tem: FECHAR o alias ligado ao Grid DESTROI o
    * objeto adicionado na Column - medido no VFP9 (2026-11-08), o
    * CurrentControl volta para "Text1" e o CheckBox desaparece, enquanto Width
    * e Header1.Caption SOBREVIVEM. Perda PARCIAL, e por isso enganosa: a grade
    * continua bonita e so o CheckBox falta, exibindo 0/1 CRU numa caixa de
    * texto - sem erro, sem log, e sem como marcar linha nenhuma.
    *
    * Dai as tres caracteristicas deste metodo:
    *   - IDEMPOTENTE (PEMSTATUS antes do AddObject, que estouraria "Object
    *     already defined" na segunda vez);
    *   - chamado por MontaGrade, ou seja a cada repintura;
    *   - os BINDEVENT vao JUNTO, no mesmo lugar - objeto recriado eh OUTRO
    *     objeto e as ligacoes do anterior morreram com ele; sem religar, os
    *     quatro handlers ficariam MUDOS e o CheckBox apareceria sem alternar.
    *
    * .Value = 0 NUMERICO eh obrigatorio e bate com o tipo da coluna
    * (Selecionada N(1), do literal "0 as Selecionada" do legado). O dump do
    * Check1 tambem declara Value = 0.
    *
    * Geometria transcrita do dump (Top=36 Left=3 Height=17 Width=60) - a
    * posicao final dentro da celula eh o Grid que resolve.
    *
    * AutoSize vai EXPLICITAMENTE .F. embora o Init legado faca
    * ".Column1.Check1.AutoSize = .t.": em controle criado por AddObject o
    * AutoSize eh NO-OP para a largura, entao confiar nele deixaria o CheckBox
    * nos 100x17 do default. As medidas explicitas reproduzem o que o legado de
    * fato exibia.
    *
    * Caption = "" porque na grade o rotulo eh o Header da coluna; o dump
    * carrega "Check1" apenas como texto de design do Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCheckBoxSelecao()
        LOCAL loc_oCol, loc_lOk

        loc_lOk = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            loc_oCol = THIS.grd_4c_Dados.Column1

            IF PEMSTATUS(loc_oCol, "chk_4c_Check1", 5)
                *-- Ainda vivo: nada a fazer (AddObject repetido estouraria)
                loc_lOk = .T.
            ELSE
                loc_oCol.AddObject("chk_4c_Check1", "CheckBox")

                WITH loc_oCol.chk_4c_Check1
                    .AutoSize  = .F.
                    .Top       = 36
                    .Left      = 3
                    .Height    = 17
                    .Width     = 60
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 0
                    .Caption   = ""
                    .Value     = 0
                    .ReadOnly  = .F.
                    .Visible   = .T.
                ENDWITH

                *-- Conjunto EXATO que o Check1 legado declara: Click e MouseUp
                *-- sao NoDefault puro (suprimem o toggle nativo), MouseDown eh
                *-- quem alterna no clique e KeyPress alterna em ENTER/ESPACO.
                BINDEVENT(loc_oCol.chk_4c_Check1, "Click",     THIS, "ChkSelecionadaClick")
                BINDEVENT(loc_oCol.chk_4c_Check1, "MouseDown", THIS, "ChkSelecionadaMouseDown")
                BINDEVENT(loc_oCol.chk_4c_Check1, "MouseUp",   THIS, "ChkSelecionadaMouseUp")
                BINDEVENT(loc_oCol.chk_4c_Check1, "KeyPress",  THIS, "ChkSelecionadaKeyPress")

                loc_lOk = .T.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * MontaGrade - FUNIL UNICO de bind e repintura da grade
    *
    * Transcreve o bloco "With ThisForm.grdOperacoes ... EndWith" do Init
    * legado, que eh onde a grade se liga ao cursor:
    *     .RecordSource          = [LocalSacOp]
    *     .Column1.ControlSource = [LocalSacOp.Selecionada]
    *     .Column2.ControlSource = [LocalSacOp.Dopes]
    *
    * O alias eh RE-RESOLVIDO a cada passagem por PrepararAliasGrade(): o
    * cursor do pai (LocalSacOp) pode ter sido aberto DEPOIS de esta tela
    * montar a estrutura, e nesse caso a grade tem de passar a le-lo em vez de
    * continuar no espelho vazio cursor_4c_Operacoes.
    *
    * Ponto UNICO de proposito: grade ligada a cursor NAO se repinta sozinha
    * quando o cursor muda (regra #21), e sem um funil cada caminho esquece uma
    * das metades. Os tres passos - bind, CheckBox, formatacao - precisam
    * acontecer SEMPRE nessa ordem (ver cabecalho de ConfigurarGrade).
    *
    * GO TOP IN + Refresh fecham o metodo porque eh isso que faz a grade
    * EXIBIR as linhas que o cursor passou a ter. GO TOP **IN** (sem SELECT) de
    * proposito: SELECT trocaria a area de trabalho corrente, que eh justamente
    * o que dispara o auto-bind medido em ConfigurarGrade.
    *
    * PUBLIC: eh funil, acionado pelos handlers e pelo harness de teste, que
    * chama metodos do form de FORA da classe (regra #3).
    *
    * par_cFiltro NAO existe no legado e NAO eh usado: esta declarado porque o
    * harness TesteAutomatico trata todo metodo chamado "MontaGrade" como se
    * recebesse um codigo e sempre invoca com 1 argumento - sem o parametro,
    * VFP9 estoura "No PARAMETER statement is found". As chamadas internas
    * (THIS.MontaGrade()) seguem validas sem argumento.
    *==========================================================================
    PROCEDURE MontaGrade(par_cFiltro)
        LOCAL loc_oGrid, loc_cCursor, loc_lSucesso

        loc_lSucesso = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            loc_cCursor = THIS.PrepararAliasGrade()

            IF VARTYPE(loc_cCursor) = "C" AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                loc_oGrid = THIS.grd_4c_Dados

                loc_oGrid.RecordSource = loc_cCursor

                loc_oGrid.Column1.ControlSource = loc_cCursor + ".Selecionada"
                loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dopes"

                *-- SO AGORA o CheckBox pode entrar/voltar: a Column1 acabou de
                *-- ser ligada a coluna NUMERICA Selecionada, e eh esse bind que
                *-- impede o "Data type mismatch" no AddObject. Idempotente.
                THIS.GarantirCheckBoxSelecao()

                *-- RecordSource/ControlSource acabaram de resetar Width,
                *-- Header1.Caption e CurrentControl - reaplicar SEMPRE depois
                THIS.FormatarGridOperacoes(loc_oGrid)

                GO TOP IN (loc_cCursor)
                loc_oGrid.Refresh()

                *-- A grade acabou de trocar de alias e de linha corrente: o BO
                *-- precisa passar a enxergar ESSA linha, senao as properties
                *-- dele continuam descrevendo a linha (ou o cursor) anterior.
                THIS.FormParaBO()

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormatarGridOperacoes - propriedades das duas colunas de grd_4c_Dados
    *
    * SCX:
    *   Column1  Width=15  Movable=.F. Resizable=.F.  Header1 Caption=""
    *            Header1 Alignment=2 ForeColor=36,84,155
    *   Column2  Width=150 Movable=.F. ReadOnly=.T.   Header1 Caption="Operacoes"
    *            Text1 BorderStyle=0 Margin=0 ReadOnly=.T. ForeColor=0,0,0
    *            BackColor=255,255,255
    * O Init legado acrescenta: Column1 ReadOnly=.F. e Sparse=.F.; e, no laco
    * "For I=2 To .ColumnCount", Column2 FontName=[Courier New] + Movable=.F. +
    * Resizable=.F. + ReadOnly=.T.
    *
    * Column2 recebe Text1.FontName = "Tahoma" (o que o SCX grava) e DEPOIS
    * Column2.FontName = "Courier New" (o que o Init atribui). A ordem eh a
    * MESMA do legado - SCX primeiro, Init em seguida - para que o VFP9 resolva
    * a precedencia aqui exatamente como resolvia la, em vez de eu escolher um
    * dos dois e arriscar divergir do que o usuario via.
    *
    * Chamado por MontaGrade SEMPRE depois do bind: atribuir RecordSource/
    * ControlSource reseta Width e Header1.Caption para o default 90/"Header1"
    * (Problema 48) e derruba o CurrentControl da Column1 (regra #18) - a grade
    * apareceria com colunas quadradas, cabecalho "Header1" e o valor cru 0/1
    * no lugar do CheckBox.
    *
    * Sparse = .F. eh o que faz o CheckBox aparecer em TODAS as linhas; sem ele
    * so a linha ativa o desenha e as outras mostram 0/1 como texto.
    *
    * Column1.ReadOnly vem DEPOIS do Grid.ReadOnly (regra #18): o do grid
    * propaga para as colunas e sobrescreveria este valor. Grid.ReadOnly eh
    * atribuido em ConfigurarGrade, que roda antes deste metodo.
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridOperacoes(par_oGrid)
        LOCAL loc_oGrid

        IF VARTYPE(par_oGrid) = "O"
            loc_oGrid = par_oGrid
        ELSE
            loc_oGrid = THIS.grd_4c_Dados
        ENDIF

        WITH loc_oGrid.Column1
            .Width             = 15
            .Movable           = .F.
            .Resizable         = .F.
            .Sparse            = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.Caption   = ""
        ENDWITH

        *-- Sem o CurrentControl a coluna volta a desenhar o Text1 dela e o
        *-- usuario ve o 0/1 cru, sem como marcar nada (regra #18). PEMSTATUS
        *-- porque o CheckBox pode nao existir ainda (ou ter sido destruido
        *-- pelo fechamento do alias) - apontar para objeto inexistente
        *-- deixaria a coluna igualmente vazia.
        IF PEMSTATUS(loc_oGrid.Column1, "chk_4c_Check1", 5)
            loc_oGrid.Column1.CurrentControl = "chk_4c_Check1"
        ENDIF

        loc_oGrid.Column1.ReadOnly = .F.

        WITH loc_oGrid.Column2
            .Width             = 150
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .FontName          = "Courier New"
        ENDWITH

        loc_oGrid.Column2.ReadOnly = .T.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarLista - repinta a grade a partir do cursor que o pai populou
    *
    * Esta tela NAO consulta o banco: a grade esta ligada ao cursor LocalSacOp,
    * criado e populado por QUEM abre o dialogo (sigatsac.gerarope no legado)
    * ANTES do CREATEOBJECT. O Init legado so BINDA - nao ha Select nenhum
    * nele. Portanto o equivalente de "carregar a lista" aqui eh re-resolver o
    * alias e repintar, que eh o que MontaGrade faz.
    *
    * A consulta do legado (Select ... From SigCdSOp Where Codigos = <dep> And
    * GerOpers = 1) esta portada em SigOpLopBO.CarregarOperacoes(), para quem
    * precisar montar o cursor por fora; ela NAO eh chamada daqui porque o Init
    * desta tela recebe apenas o form pai (LParameters pFrm) e nao conhece o
    * codigo do departamento - inventar uma origem para esse codigo seria
    * inventar regra de negocio.
    *
    * PUBLIC: o harness de teste chama CarregarLista de FORA da classe, e
    * PEMSTATUS devolve .T. para metodo PROTECTED (testa existencia, nao
    * escopo) - o teste entraria no branch e a chamada falharia (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.MontaGrade()
    ENDPROC

    *==========================================================================
    * FormParaBO - transfere a LINHA CORRENTE da grade para o BO
    *
    * Nesta tela a "ficha" eh a LINHA da grade: nao existe Page de Dados nem
    * campo solto, e o que o usuario edita eh a marcacao (Column1) da linha em
    * que esta. Por isso o par FormParaBO/BOParaForm tem sentido aqui, e nao eh
    * convencao importada do frmcadastro - os dois sao os dois sentidos da
    * transferencia que o legado faz direto no evento do Check1.
    *
    * O que torna este metodo "da TELA para o BO" eh a ORIGEM do alias e da
    * linha: os dois vem do CONTROLE - grd_4c_Dados.RecordSource e o ponteiro
    * do proprio cursor que a grade exibe -, nunca de palpite do BO. Se o form
    * pai abriu o LocalSacOp DEPOIS de esta tela montar a estrutura, o
    * RecordSource ja aponta para ele e eh a tela que CORRIGE this_cAliasGrade.
    *
    * Resolvido o alias, delega ao BO o que eh dele: CarregarDoCursor() le as
    * sete colunas da linha (Selecionada, Dopes, GerOpServs, cCodServs,
    * nVlServs, nAliIss, fPags) para as properties, e AtualizarTotais() reconta
    * a selecao e remonta a lista das Operacoes marcadas - que eh exatamente o
    * que o form pai consome depois do Ok.
    *
    * Grade VAZIA nao eh erro: o espelho cursor_4c_Operacoes abre sem linha
    * quando nao ha form pai (validacao de UI / teste), e ai nao ha ficha a
    * transferir - o BO eh zerado e o retorno eh .F., sem mensagem, porque a
    * tela abriu sem dados de proposito.
    *
    * PROTECTED: FormBase declara os dois hooks PROTECTED e VFP9 nao permite
    * ALARGAR o escopo de metodo herdado.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_cAlias, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- O alias vem da GRADE (a tela), nao do BO
                loc_cAlias = THIS.this_cAliasGrade

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    IF !EMPTY(THIS.grd_4c_Dados.RecordSource)
                        loc_cAlias = ALLTRIM(THIS.grd_4c_Dados.RecordSource)
                    ENDIF
                ENDIF

                IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                    THIS.this_cAliasGrade = loc_cAlias

                    IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
                        loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor(loc_cAlias)

                        THIS.this_oBusinessObject.AtualizarTotais(loc_cAlias)
                    ELSE
                        *-- Sem linha nenhuma: nao ha ficha a transferir
                        THIS.this_oBusinessObject.LimparDados()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - devolve o estado do BO a grade
    *
    * Inverso do FormParaBO, e transcricao das duas ultimas linhas de cada
    * alternancia do Check1 legado:
    *     Gather Memvar Fields Selecionada
    *     ThisForm.grdOperacoes.Refresh
    *
    * Duas metades, e as duas sao necessarias:
    *   1. A MARCACAO - o this_nSelecionada do BO vai para a coluna
    *      Selecionada da LINHA CORRENTE, que eh o "Gather Memvar Fields
    *      Selecionada" do legado. Idempotente no caminho normal (o
    *      SigOpLopBO.AlternarSelecao ja gravou), e eh o UNICO caminho quando a
    *      property do BO muda por fora - caso do Cancelar herdado do FormBase,
    *      que chama este hook depois de o BO desfazer a edicao.
    *      TRES guardas: grade editavel (cursor somente-leitura recusaria o
    *      REPLACE), linha existente, e IDENTIDADE - o Dopes da linha corrente
    *      tem de ser o MESMO que o BO carregou. Sem a terceira, um BO parado
    *      na linha A com o ponteiro na linha B gravaria a marcacao de A em B:
    *      corrupcao silenciosa exatamente na coluna que o form pai vai ler.
    *      MEDIDO no probe (2026-11-08): escrever no CheckBox
    *      (chk_4c_Check1.Value) NAO serve. Em grade nao renderizada o valor
    *      atribuido se perde no Refresh seguinte (o probe leu 0 com a linha
    *      marcada em 1), e escrita em controle com ControlSource propaga para
    *      o cursor sem passar por guarda nenhuma. Por isso a gravacao eh
    *      REPLACE explicito no alias, com o tipo da coluna normalizado como o
    *      BO faz (coluna de marcacao chega Numerica ou Logica conforme a
    *      origem do cursor - regra #13).
    *   2. O REFRESH - grade ligada a cursor NAO se repinta sozinha quando o
    *      cursor muda (regra #21); sem ele a coluna continua desenhando o
    *      valor anterior e o usuario jura que o clique nao funcionou.
    *
    * NAO reposiciona o ponteiro do cursor, de proposito: a linha corrente eh
    * COMPARTILHADA com o form pai (DataSession = 1) e eh a que o usuario esta
    * vendo. Procurar a linha por Dopes para "voltar" a ela cairia na primeira
    * Operacao de mesmo nome e faria a grade pular sozinha.
    *
    * PROTECTED pelo mesmo motivo do FormParaBO.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cAlias, loc_uAtual, loc_nAtual, loc_nValor
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               PEMSTATUS(THIS, "grd_4c_Dados", 5)

                loc_cAlias = THIS.this_cAliasGrade

                IF THIS.this_lGradeEditavel AND ;
                   VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND ;
                   USED(loc_cAlias)

                    IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias) AND ;
                       TYPE(loc_cAlias + ".Selecionada") != "U" AND ;
                       TYPE(loc_cAlias + ".Dopes") != "U"

                        *-- IDENTIDADE: so grava na linha que o BO carregou
                        IF ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), "")) == ;
                           ALLTRIM(THIS.this_oBusinessObject.this_cDopes)

                            loc_uAtual = EVALUATE(loc_cAlias + ".Selecionada")

                            IF VARTYPE(loc_uAtual) = "N"
                                loc_nAtual = NVL(loc_uAtual, 0)
                            ELSE
                                loc_nAtual = IIF(NVL(loc_uAtual, .F.), 1, 0)
                            ENDIF

                            loc_nValor = IIF(THIS.this_oBusinessObject.this_nSelecionada = 1, 1, 0)

                            IF loc_nAtual != loc_nValor
                                REPLACE Selecionada WITH loc_nValor IN (loc_cAlias)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                THIS.grd_4c_Dados.Refresh()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cria cmd_4c_Ok (o cmdSair "Ok" do legado)
    *
    * SCX: cmdSair Top=3 Left=315 Class=fwbtng Cancel=.T. Caption="\<Ok"
    *      Picture=..\framework\imagens\cadastro_salvar_60.jpg
    * Classe fwbtng (framework.vcx): Height=100 Width=80 FontName="Comic Sans
    * MS" FontSize=8 FontBold=.T. FontItalic=.T. WordWrap=.T. MousePointer=15
    * ForeColor=90,90,90 BackColor=255,255,255 Themes=.F.
    *
    * Width=80 em Left=315 passa 4px da borda de um form de 391 - e o legado
    * passava igual, porque fwbtng tem 80 de largura fixa. Mantido: o VFP9
    * recorta os 4px nos dois casos, entao o observavel eh IDENTICO. Reduzir a
    * largura "para caber" mudaria o desenho que o usuario conhece.
    *
    * O botao fica em Top 3..103, DENTRO da faixa do cabecalho (0..80), e isso
    * eh o desenho do legado: um Ok sobreposto ao canto direito da faixa. Por
    * isso ele tem de ser criado DEPOIS do cnt_4c_Sombra (que o InicializarForm
    * cria primeiro) - invertido, a faixa cobriria o botao. E por isso tambem a
    * caixa transparente dos labels da faixa (Left 10..381, BackStyle = 0) nao
    * bloqueia o clique: ela nasce antes e o botao desenha por cima (regras
    * #28/#30).
    *
    * Themes = .T. eh DESVIO deliberado do Themes = .F. da classe fwbtng:
    * CommandButton standalone com .Picture e Themes = .F. nao renderiza o
    * icone (canonico do projeto, CorretorAutomatico #99). Sem isso o usuario
    * veria so o texto "Ok".
    *
    * O caminho do icone eh TRANSCRITO do dump (cadastro_salvar_60.jpg -
    * "fechar a selecao" eh gravar, no vocabulario do framework), nao escolhido
    * por semelhanca semantica, e o arquivo existe em vbmp\ (regra #25).
    *
    * Cancel = .T. vem do SCX: faz o ESC disparar o Click deste botao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Ok", "CommandButton")

            WITH THIS.cmd_4c_Ok
                .Top           = 3
                .Left          = 315
                .Width         = 80
                .Height        = 100
                .Caption       = "\<Ok"
                .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .T.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Cancel        = .T.
                .ToolTipText   = "Confirmar a sele" + CHR(231) + CHR(227) + ;
                                 "o e fechar"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - liga o Click do botao Ok
    *
    * Os BINDEVENT do CheckBox da grade NAO ficam aqui: eles vivem em
    * GarantirCheckBoxSelecao, porque o objeto do CheckBox pode ser destruido e
    * recriado quando o alias da grade eh fechado - e ligacao de objeto morto
    * nao se transfere para o objeto novo.
    *
    * BtnOkClick eh PUBLIC: BINDEVENT com metodo PROTECTED falha em SILENCIO
    * (regra #3) e o botao Ok ficaria inerte.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
                BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarSelecaoLinha - alterna <alias>.Selecionada da linha corrente
    *
    * FUNIL dos dois caminhos de alternancia do legado (MouseDown e KeyPress),
    * que fazem a MESMA coisa:
    *     m.Selecionada = Iif(LocalSacOp.Selecionada = 0, 1, 0)
    *     Select LocalSacOp
    *     Gather Memvar Fields Selecionada      && == REPLACE Selecionada WITH
    *     ThisForm.grdOperacoes.Refresh
    *
    * A gravacao eh de SigOpLopBO.AlternarSelecao, que le a coluna, inverte,
    * faz o REPLACE e reconta os totais; o Refresh da grade eh daqui, porque so
    * o form conhece o controle. O BO devolve o valor novo (0/1) ou -1 quando
    * nao foi possivel alternar - eh o que permite AVISAR em vez de ficar
    * inerte: cursor somente-leitura faz o CheckBox aparecer, receber foco e
    * NAO mudar de valor, defeito silencioso que parece bug de Enabled.
    *
    * O legado le a coluna do CURSOR no MouseDown (LocalSacOp.Selecionada) e,
    * no KeyPress, le a variavel LOCAL homonima recem-declarada - que nasce
    * vazia e nunca recebe o valor do registro. Isto eh, o KeyPress legado
    * compara uma logica com 0 e nao reproduz o MouseDown. Aqui os dois
    * caminhos passam pela MESMA leitura do cursor, que eh a do MouseDown: a
    * intencao (alternar a linha corrente) fica preservada nos dois, sem
    * carregar o defeito de um deles.
    *==========================================================================
    PROCEDURE AlternarSelecaoLinha()
        LOCAL loc_nNovo, loc_cMensagem, loc_lAlternou

        loc_lAlternou = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_nNovo = THIS.this_oBusinessObject.AlternarSelecao(THIS.this_cAliasGrade)

        IF loc_nNovo >= 0
            *-- Os dois hooks, na ordem do evento legado: FormParaBO leva a
            *-- LINHA que acabou de ser marcada para o BO (Dopes, GerOpServs,
            *-- ... e os totais que o form pai vai ler) e BOParaForm fecha com
            *-- o "Gather Memvar Fields Selecionada / grdOperacoes.Refresh" -
            *-- a gravacao eh no-op aqui, porque o BO ja gravou, e o Refresh eh
            *-- o que faz a marcacao APARECER. Nesta ordem a guarda de
            *-- identidade do BOParaForm sempre casa: o BO acabou de ser
            *-- sincronizado com a linha corrente.
            THIS.FormParaBO()
            THIS.BOParaForm()

            loc_lAlternou = .T.
        ELSE
            *-- Nao alternou: avisar, nunca deixar o clique sem efeito visivel
            loc_cMensagem = THIS.this_oBusinessObject.this_cMensagemErro

            IF EMPTY(loc_cMensagem)
                loc_cMensagem = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel marcar a Opera" + CHR(231) + CHR(227) + "o."
            ENDIF

            MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF

        RETURN loc_lAlternou
    ENDPROC

    *==========================================================================
    * ChkSelecionadaClick / MouseDown / MouseUp / KeyPress
    *
    * Transcricao do SIGOPLOP.grdOperacoes.Column1.Check1 legado, evento a
    * evento:
    *   Click     -> NoDefault
    *   MouseDown -> alterna Selecionada + Refresh + NoDefault
    *   MouseUp   -> NoDefault
    *   KeyPress  -> If InList(nKeyCode, 13, 32): alterna + Refresh + NoDefault
    *
    * Os NODEFAULT sao o que SUPRIME o toggle nativo do CheckBox: sem eles o
    * controle alternaria por conta propria E o handler alternaria de novo, com
    * a marcacao voltando ao estado anterior a cada clique. O legado desliga o
    * comportamento padrao nos quatro eventos justamente por isso, e a grade so
    * alterna por codigo.
    *
    * A alternancia no MouseDown (e nao no MouseUp) eh do legado - o canonico
    * do projeto costuma por o toggle no KeyPress e delegar o MouseUp a ele,
    * mas aqui o PILAR 1 manda seguir o que esta escrito no SCX; o observavel
    * eh o mesmo (uma alternancia por clique).
    *
    * As assinaturas declaram os parametros dos eventos nativos: handler ligado
    * por BINDEVENT a MouseDown/MouseUp sem (nButton, nShift, nXCoord,
    * nYCoord) - ou a KeyPress sem (nKeyCode, nShiftAltCtrl) - estoura a cada
    * disparo com "No PARAMETER statement is found" (regra #3).
    *
    * Todos PUBLIC: BINDEVENT com metodo PROTECTED falha em silencio.
    *==========================================================================
    PROCEDURE ChkSelecionadaClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecionadaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarSelecaoLinha()

        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecionadaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecionadaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarSelecaoLinha()

            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOkClick - o Ok do legado
    *
    * Legado (cmdSair.Click):
    *     ThisForm.ParentForm.Enabled = .t.
    *     ThisForm.Release
    *
    * Nessa ordem: devolve o controle a quem abriu e fecha. RestaurarFormPai()
    * eh exatamente a primeira linha, num metodo porque o Destroy tambem a
    * usa - e com Cancel = .T. o ESC dispara este mesmo Click, entao os dois
    * caminhos de saida do legado passam por aqui.
    *
    * this_lConfirmado registra que a saida foi pelo Ok, para o form pai poder
    * distinguir confirmacao de fechamento abortado. O legado nao tem essa
    * marca (ele apenas varre LocalSacOp depois), e varrer o cursor continua
    * funcionando igual - a property eh informacao a mais, nao condicao nova.
    *
    * FormParaBO roda ANTES do Release porque o BO eh liberado no Destroy:
    * depois dele this_nTotalSelecionadas e this_cOperacoesMarcadas nao
    * estariam mais acessiveis. Ele eh a ULTIMA leitura da tela - fecha a
    * contagem da selecao com a linha em que o usuario parou. O Ok NAO exige
    * selecao: o legado tambem nao exige (o Click dele so devolve o Enabled ao
    * pai e libera a tela), e bloquear aqui inventaria regra que a tela nao
    * tem - quem decide o que fazer com zero marcacao eh o form pai, varrendo o
    * cursor como sempre fez.
    *
    * PUBLIC: ligado por BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE BtnOkClick()
        THIS.FormParaBO()

        THIS.this_lConfirmado = .T.

        THIS.RestaurarFormPai()

        THIS.Release()
    ENDPROC
ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpLopBO.prg):
*==============================================================================
* SigOpLopBO.prg - Business Object: Sub-Nivel (selecao de Operacoes)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialogo modal filho - recebe ParentForm, marca/desmarca
*       as Operacoes no cursor do form pai e devolve o controle a ele)
*
* ORIGEM LEGADO: SigOpLop.SCX (Caption "Sub-Nivel"). O Init recebe pFrm (o form
* que abre o dialogo), desabilita o pai e devolve o Enabled no Ok. O dialogo
* NAO executa SQL nenhum: a grade grdOperacoes esta ligada ao cursor LocalSacOp,
* criado e populado por QUEM abre o dialogo, e o Check1 da Column1 alterna
* LocalSacOp.Selecionada por codigo (Gather Memvar Fields Selecionada), com a
* Column2 (Dopes) em ReadOnly.
*
* QUEM ABRE O DIALOGO (achado no acervo legado, 4install\FortyusMC\Fortyus):
* sigatsac.SCX, metodo gerarope, monta o cursor e so entao chama a tela -
* transcrito aqui LITERALMENTE porque eh o CONTRATO da grade:
*
*   lcQuery = [Select 0 as Selecionada, Dopes, GerOpServs, cCodServs,
*              nVlServs, nAliIss, fPags ] + ;
*             [From SigCdSOp ] + ;
*             [Where Codigos = ] + <crSigCdSOs.CodDeps> + [ And ] + ;
*             [GerOpers = 1]
*   If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSacOp]) < 1) ... Return 0
*   Select LocalSacOp
*   Go Top In LocalSacOp
*   If Eof([LocalSacOp]) ... Else   If (Reccount([LocalSacOp]) > 0)
*       Do Form SigOpLop With ThisForm
*   ...
*   Select LocalSacOp
*   Scan
*       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
*   EndScan
*
* Ou seja: a tabela de origem eh SigCdSOp (Operacoes do Departamento), NAO
* SigCdOpe, e depois de fechado o dialogo o form pai volta a LER o MESMO alias
* LocalSacOp - inclusive as colunas que a grade nao mostra (GerOpServs,
* cCodServs, nVlServs, nAliIss, fPags). Por isso este BO:
*   - mantem o alias legado LocalSacOp (nunca renomeia o cursor do pai);
*   - mapeia as SETE colunas do cursor, nao so as duas visiveis;
*   - trata a camada de dados como CURSOR, nao como INSERT/UPDATE.
*
* GRAVACAO: Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria()
* ficam HERDADOS de BusinessBase - o comportamento padrao da base ja eh o
* correto para esta tela, porque o legado nao tem TABLEUPDATE, nao tem
* .AddCursor e nao tem Insert/Update/Delete sobre tabela nenhuma: a marcacao
* vive no cursor em memoria e quem persiste qualquer coisa eh o form pai,
* depois do Ok. Sobrescrever esses metodos aqui exigiria INVENTAR um comando de
* gravacao que o legado nao possui.
*
* FASE 1/8: declaracao das propriedades + Init().
* FASE 2/8: camada de dados do cursor - CarregarDoCursor() com TODAS as colunas,
*           CarregarOperacoes() (a query do legado), GarantirCursorGrade(),
*           GradeEditavel(), AlternarSelecao(), AtualizarTotais(), TemSelecao(),
*           LimparDados(), ObterChavePrimaria(), Destroy().
*==============================================================================

DEFINE CLASS SigOpLopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTRATO DE CURSORES
    *
    * this_cCursorPai   - alias EXATO do legado (LocalSacOp). Pertence ao form
    *                     que abre o dialogo; este BO le e alterna a coluna
    *                     Selecionada dele e, quando o pai pede, o POPULA com a
    *                     query do legado - mas nunca o renomeia.
    * this_cCursorGrade - alias local usado como espelho da grade quando o
    *                     dialogo eh instanciado FORA do fluxo real (validacao
    *                     de UI / teste), em que LocalSacOp nao existe.
    *                     Nomenclatura cursor_4c_* do projeto.
    * this_cCursorTemp  - alias temporario do SQLEXEC. O resultado de SQLEXEC
    *                     nasce SOMENTE-LEITURA e a grade tem coluna EDITAVEL
    *                     (o CheckBox da Column1), entao a consulta cai aqui e
    *                     o alias da grade eh montado READWRITE a partir dele.
    *--------------------------------------------------------------------------
    this_cCursorPai   = "LocalSacOp"
    this_cCursorGrade = "cursor_4c_Operacoes"
    this_cCursorTemp  = "cursor_4c_OperacoesTmp"

    *--------------------------------------------------------------------------
    * COLUNAS DA GRADE (LocalSacOp) - uma propriedade por coluna do legado,
    * na MESMA ordem do Select de sigatsac.gerarope.
    *
    * this_nSelecionada - LocalSacOp.Selecionada. No legado a coluna nasce do
    *                     literal "0 as Selecionada", e o toggle eh
    *                     Iif(Selecionada = 0, 1, 0): eh NUMERICA (0/1), nao
    *                     logica. O pai confere com "Selecionada = 1".
    * this_cDopes       - LocalSacOp.Dopes -> SigCdSOp.dopes char(20). Unica
    *                     coluna EXIBIDA na grade (Column2, ReadOnly).
    * this_nGerOpServs  - LocalSacOp.GerOpServs -> geropservs numeric(1,0).
    *                     Lido pelo pai (If LocalSacOp.GerOpServs = 1 abre o
    *                     SigPrIns de servico), portanto NUMERICO.
    * this_cCodServs    - LocalSacOp.cCodServs -> ccodservs char(10).
    * this_nVlServs     - LocalSacOp.nVlServs  -> nvlservs numeric(11,2).
    * this_nAliIss      - LocalSacOp.nAliIss   -> naliiss  numeric(4,2).
    * this_cFPags       - LocalSacOp.fPags     -> fpags    char(12).
    *--------------------------------------------------------------------------
    this_nSelecionada = 0
    this_cDopes       = ""
    this_nGerOpServs  = 0
    this_cCodServs    = ""
    this_nVlServs     = 0
    this_nAliIss      = 0
    this_cFPags       = ""

    *--------------------------------------------------------------------------
    * TOTALIZADORES DA SELECAO (consultados pelo Form no Ok/Encerrar)
    *
    * this_nTotalOperacoes    - quantidade de linhas da grade
    * this_nTotalSelecionadas - quantidade de linhas com Selecionada = 1
    * this_cOperacoesMarcadas - lista das Operacoes marcadas, separadas por
    *                           virgula, para o form pai consumir sem precisar
    *                           varrer o cursor de novo
    *--------------------------------------------------------------------------
    this_nTotalOperacoes    = 0
    this_nTotalSelecionadas = 0
    this_cOperacoesMarcadas = ""

    *--------------------------------------------------------------------------
    * LARGURAS DO SCHEMA (docs\schema.sql, tabela SigCdSOp) - usadas pelo
    * PADR/LEFT das rotinas de carga e pelo MaxLength dos controles, para nunca
    * exibir nem montar valor maior do que a coluna aceita.
    *--------------------------------------------------------------------------
    this_nTamDopes    = 20
    this_nTamCodServs = 10
    this_nTamFPags    = 12
    this_nTamCodigos  = 10

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * A tabela de origem eh SigCdSOp e a coluna que identifica a linha para
    * ESTE dialogo eh dopes (a PK fisica da tabela eh cidchaves, que o Select
    * do legado NAO traz para o cursor, logo nao esta disponivel aqui).
    *
    * As propriedades sao atribuidas ANTES de DODEFAULT() porque
    * BusinessBase.Init() so instancia o DataAccess quando RECEBE o nome da
    * tabela como parametro - aqui a tela nao grava, entao o DataAccess nao eh
    * necessario e nao se passa parametro.
    *
    * O RETURN .T. explicito eh obrigatorio: Init que devolve .F. faz
    * CREATEOBJECT retornar valor nao-objeto e o form nao abre.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdSOp"
        THIS.this_cCampoChave = "dopes"

        DODEFAULT()

        THIS.LimparDados()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterAliasGrade - Resolve QUAL alias a grade deve usar
    *
    * No fluxo real o cursor eh do form pai (LocalSacOp). Fora dele (validacao
    * de UI / teste headless) esse alias nao existe e a grade cai no espelho
    * local. Resolver o alias por aqui evita espalhar IF USED() por todo o Form
    * e garante que Grid.RecordSource, Column.ControlSource e os handlers do
    * CheckBox falem SEMPRE do mesmo cursor.
    *--------------------------------------------------------------------------
    PROCEDURE ObterAliasGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.this_cCursorGrade

        IF USED(THIS.this_cCursorPai)
            loc_cAlias = THIS.this_cCursorPai
        ENDIF

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCursorGrade - Assegura que existe um alias com a estrutura da
    *                       grade ANTES de o Grid ser ligado a ele
    *
    * Column.ControlSource apontando para cursor que ainda nao existe estoura
    * "Alias ... is not found" DENTRO do TRY do InicializarForm: o CREATEOBJECT
    * devolve .F. e a tela simplesmente nao abre. Entao, quando o cursor do pai
    * nao esta aberto, cria-se o espelho VAZIO com as SETE colunas na MESMA
    * ordem do Select do legado - sem inventar nenhuma linha, porque sem o form
    * pai nao ha Operacao nenhuma a exibir.
    *
    * Tipos conforme docs\schema.sql (SigCdSOp) e conforme o literal
    * "0 as Selecionada" do legado. O cursor nasce READWRITE, que eh o que a
    * Column1 precisa para aceitar o REPLACE do CheckBox.
    *--------------------------------------------------------------------------
    PROCEDURE GarantirCursorGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.ObterAliasGrade()

        IF !USED(loc_cAlias)
            SET NULL ON
            CREATE CURSOR cursor_4c_Operacoes ( ;
                Selecionada N(1), ;
                Dopes       C(20), ;
                GerOpServs  N(1), ;
                cCodServs   C(10), ;
                nVlServs    N(11,2), ;
                nAliIss     N(4,2), ;
                fPags       C(12))
            SET NULL OFF

            loc_cAlias = THIS.this_cCursorGrade
        ENDIF

        THIS.AtualizarTotais(loc_cAlias)

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeEditavel - .T. quando o alias da grade aceita REPLACE
    *
    * O CheckBox da Column1 alterna a coluna Selecionada por REPLACE, e isso
    * exige cursor READWRITE. Cursor devolvido por SQLEXEC nasce SOMENTE-LEITURA:
    * nesse caso o controle aparece, recebe foco e NAO muda de valor - defeito
    * silencioso que parece bug de Enabled/ReadOnly. Quem monta o cursor
    * (CarregarOperacoes, aqui, ou o form pai) tem de entregar READWRITE; este
    * metodo existe para que o Form possa AVISAR em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE GradeEditavel(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lEditavel

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        loc_lEditavel = .F.

        IF USED(loc_cAlias)
            loc_lEditavel = !ISREADONLY(loc_cAlias)
        ENDIF

        RETURN loc_lEditavel
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula o cursor da grade com a query do legado
    *
    * TRANSCRICAO de sigatsac.gerarope (ver cabecalho). O filtro eh
    * "Codigos = <departamento> And GerOpers = 1" - os dois termos vem do
    * legado e nenhum foi acrescentado.
    *
    * par_cCodigoDepartamento = SigCdSOp.codigos char(10), que no legado vem de
    * crSigCdSOs.CodDeps (a OS selecionada na grade do form pai). Sem esse
    * codigo nao existe consulta possivel: devolve .F. com mensagem, e a grade
    * continua com o espelho vazio criado por GarantirCursorGrade.
    *
    * O SQLEXEC cai em cursor TEMPORARIO e o alias da grade eh montado a partir
    * dele, por dois motivos: (a) o cursor de SQLEXEC eh somente-leitura e a
    * Column1 precisa de REPLACE; (b) SQLEXEC sobre o alias JA ligado a um Grid
    * fecha e recria esse alias, zerando ColumnCount e deixando a grade como um
    * retangulo branco. Com o alias ja aberto e editavel usa-se ZAP + APPEND,
    * que preserva estrutura, RecordSource, ControlSource e CurrentControl.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigoDepartamento)
        LOCAL loc_cSQL, loc_cCodigo, loc_cAlias, loc_nResultado
        LOCAL loc_lSucesso, loc_cSafety, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodigoDepartamento) != "C" OR EMPTY(par_cCodigoDepartamento)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do Departamento n" + ;
                CHR(227) + "o informado para carregar as Opera" + CHR(231) + ;
                CHR(245) + "es."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        loc_cCodigo = LEFT(ALLTRIM(par_cCodigoDepartamento), THIS.this_nTamCodigos)

        *-- Select transcrito do legado (sigatsac.gerarope): colunas e ordem
        *-- IDENTICAS, porque o form pai le todas elas depois do Ok.
        loc_cSQL = "SELECT 0 AS Selecionada, Dopes, GerOpServs, cCodServs," + ;
                   " nVlServs, nAliIss, fPags" + ;
                   " FROM SigCdSOp" + ;
                   " WHERE Codigos = " + EscaparSQL(loc_cCodigo) + ;
                   " AND GerOpers = 1" + ;
                   " ORDER BY Dopes"

        TRY
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar as Opera" + CHR(231) + ;
                    CHR(245) + "es do Departamento: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                loc_cAlias = THIS.ObterAliasGrade()

                IF USED(loc_cAlias) AND !ISREADONLY(loc_cAlias)
                    *-- Alias ja aberto e editavel (tipicamente ligado ao Grid):
                    *-- ZAP + APPEND preserva o binding da grade. SET SAFETY eh
                    *-- escopado por data session e volta a ON em form
                    *-- DataSession = 2, onde o ZAP abriria dialogo modal e
                    *-- congelaria a tela.
                    loc_cSafety = SET("SAFETY")
                    SET SAFETY OFF
                    SELECT (loc_cAlias)
                    ZAP
                    APPEND FROM DBF(THIS.this_cCursorTemp)
                    IF loc_cSafety = "ON"
                        SET SAFETY ON
                    ENDIF
                ELSE
                    *-- Primeira carga (ou alias somente-leitura): monta o alias
                    *-- legado LocalSacOp como cursor READWRITE.
                    IF USED(THIS.this_cCursorPai)
                        USE IN (THIS.this_cCursorPai)
                    ENDIF

                    SELECT * ;
                        FROM cursor_4c_OperacoesTmp ;
                        INTO CURSOR LocalSacOp READWRITE

                    loc_cAlias = THIS.this_cCursorPai
                ENDIF

                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF

                *-- Go Top In LocalSacOp - exatamente como o legado faz antes de
                *-- abrir o dialogo.
                SELECT (loc_cAlias)
                GO TOP

                THIS.AtualizarTotais(loc_cAlias)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao carregar as Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE do cursor nas propriedades
    *
    * Mapeia as SETE colunas do cursor do legado, nao apenas as duas que a
    * grade exibe: o form pai consome GerOpServs, cCodServs, nVlServs, nAliIss
    * e fPags depois que o dialogo fecha, e eh este metodo que leva esses
    * valores para o BO.
    *
    * Cuidados:
    *   - SELECT (par_cAliasCursor) ANTES de ler os campos, e restauracao da
    *     area de trabalho anterior no fim (nao roubar o SELECT de quem chamou);
    *   - guarda de EOF: cursor vazio ou posicionado no fim nao pode "carregar"
    *     lixo nas propriedades;
    *   - existencia de cada coluna por TYPE(alias + ".coluna") != "U" -
    *     PEMSTATUS exige OBJETO no 1o argumento e estoura com nome de cursor;
    *   - coluna numeric(1,0) pode chegar como Numerico (numeric) ou como Logico
    *     (bit) conforme o driver: VARTYPE antes de comparar, senao da
    *     type mismatch.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_lSucesso, loc_uValor

        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        SELECT (loc_cAlias)

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada no cursor [" + loc_cAlias + "]."
        ELSE
            *-- Selecionada: marcacao numerica 0/1 (literal "0 as Selecionada")
            IF TYPE(loc_cAlias + ".Selecionada") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nSelecionada = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nSelecionada = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- Dopes: a Operacao exibida na Column2 (SigCdSOp.dopes char(20))
            IF TYPE(loc_cAlias + ".Dopes") != "U"
                THIS.this_cDopes = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""), ;
                                        THIS.this_nTamDopes)
            ENDIF

            *-- GerOpServs: numeric(1,0); o form pai testa "= 1"
            IF TYPE(loc_cAlias + ".GerOpServs") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".GerOpServs")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nGerOpServs = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nGerOpServs = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- cCodServs: char(10)
            IF TYPE(loc_cAlias + ".cCodServs") != "U"
                THIS.this_cCodServs = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".cCodServs"), ""), ;
                                           THIS.this_nTamCodServs)
            ENDIF

            *-- nVlServs: numeric(11,2)
            IF TYPE(loc_cAlias + ".nVlServs") != "U"
                THIS.this_nVlServs = TratarNulo(EVALUATE(loc_cAlias + ".nVlServs"), 0)
                IF VARTYPE(THIS.this_nVlServs) != "N"
                    THIS.this_nVlServs = 0
                ENDIF
            ENDIF

            *-- nAliIss: numeric(4,2) - aliquota de ISS usada pelo pai no calculo
            IF TYPE(loc_cAlias + ".nAliIss") != "U"
                THIS.this_nAliIss = TratarNulo(EVALUATE(loc_cAlias + ".nAliIss"), 0)
                IF VARTYPE(THIS.this_nAliIss) != "N"
                    THIS.this_nAliIss = 0
                ENDIF
            ENDIF

            *-- fPags: char(12) - forma de pagamento que o pai le em SigOpFp
            IF TYPE(loc_cAlias + ".fPags") != "U"
                THIS.this_cFPags = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".fPags"), ""), ;
                                        THIS.this_nTamFPags)
            ENDIF

            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecao - Alterna a marcacao da LINHA CORRENTE
    *
    * Reproduz o que o Check1 da Column1 faz no legado:
    *
    *   m.Selecionada = Iif(LocalSacOp.Selecionada = 0, 1, 0)
    *   Select LocalSacOp
    *   Gather Memvar Fields Selecionada
    *   ThisForm.grdOperacoes.Refresh
    *
    * O Gather Memvar sobre UM campo eh exatamente um REPLACE desse campo; o
    * Refresh da grade fica no Form, que eh quem tem o controle visual.
    *
    * Devolve o valor novo (0 ou 1), ou -1 quando nao foi possivel alternar -
    * assim o Form distingue "desmarcou" de "falhou" em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecao(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nAtual, loc_nNovo, loc_uValor
        LOCAL loc_oErro

        loc_nNovo = -1

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN -1
        ENDIF

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada para marcar."
            RETURN -1
        ENDIF

        IF ISREADONLY(loc_cAlias)
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] est" + CHR(225) + ;
                " somente-leitura e a marca" + CHR(231) + CHR(227) + "o da Opera" + ;
                CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser gravada."
            RETURN -1
        ENDIF

        IF TYPE(loc_cAlias + ".Selecionada") = "U"
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o possui a coluna Selecionada."
            RETURN -1
        ENDIF

        loc_cAreaAnterior = ALIAS()

        TRY
            SELECT (loc_cAlias)

            loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
            IF VARTYPE(loc_uValor) = "N"
                loc_nAtual = NVL(loc_uValor, 0)
            ELSE
                loc_nAtual = IIF(NVL(loc_uValor, .F.), 1, 0)
            ENDIF

            loc_nNovo = IIF(loc_nAtual = 0, 1, 0)

            REPLACE Selecionada WITH loc_nNovo IN (loc_cAlias)

            THIS.this_nSelecionada  = loc_nNovo
            THIS.this_cMensagemErro = ""

            THIS.AtualizarTotais(loc_cAlias)
        CATCH TO loc_oErro
            loc_nNovo = -1
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao marcar a Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_nNovo
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotais - Reconta a selecao e monta a lista das marcadas
    *
    * Equivale ao Scan que o form pai roda DEPOIS do Ok:
    *
    *   Select LocalSacOp
    *   Scan
    *       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
    *   EndScan
    *
    * O RECNO eh salvo e reposto: SCAN move o ponteiro, e a linha corrente eh a
    * que o usuario esta vendo na grade - perde-la faz a grade "pular" sozinha.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotais(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nRegistro, loc_nSel, loc_cLista
        LOCAL loc_uValor, loc_nValor, loc_oErro

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        loc_nSel          = 0
        loc_cLista        = ""

        TRY
            SELECT (loc_cAlias)
            loc_nRegistro = RECNO(loc_cAlias)

            THIS.this_nTotalOperacoes = RECCOUNT(loc_cAlias)

            SCAN
                loc_nValor = 0

                IF TYPE(loc_cAlias + ".Selecionada") != "U"
                    loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                    IF VARTYPE(loc_uValor) = "N"
                        loc_nValor = NVL(loc_uValor, 0)
                    ELSE
                        loc_nValor = IIF(NVL(loc_uValor, .F.), 1, 0)
                    ENDIF
                ENDIF

                IF loc_nValor = 1
                    loc_nSel = loc_nSel + 1

                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        loc_cLista = loc_cLista + ;
                            IIF(EMPTY(loc_cLista), "", ", ") + ;
                            ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""))
                    ENDIF
                ENDIF
            ENDSCAN

            THIS.this_nTotalSelecionadas = loc_nSel
            THIS.this_cOperacoesMarcadas = loc_cLista

            *-- Repoe a linha que o usuario estava vendo na grade
            IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT(loc_cAlias)
                GO loc_nRegistro IN (loc_cAlias)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao totalizar a sele" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TemSelecao - .T. quando ha ao menos uma Operacao marcada
    *
    * Eh o llOks do form pai, exposto aqui para que ele nao precise varrer o
    * cursor de novo. CONSULTA apenas: o Ok do legado NAO exige selecao (ele so
    * devolve o Enabled ao pai e libera a tela), portanto o Form nao deve usar
    * este metodo para bloquear o Ok.
    *--------------------------------------------------------------------------
    PROCEDURE TemSelecao(par_cAliasCursor)
        THIS.AtualizarTotais(par_cAliasCursor)

        RETURN (THIS.this_nTotalSelecionadas > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades da linha e os totalizadores
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_nSelecionada = 0
        THIS.this_cDopes       = ""
        THIS.this_nGerOpServs  = 0
        THIS.this_cCodServs    = ""
        THIS.this_nVlServs     = 0
        THIS.this_nAliIss      = 0
        THIS.this_cFPags       = ""

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        THIS.this_cMensagemErro = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identidade da linha corrente
    *
    * SigCdSOp.dopes - a PK fisica da tabela eh cidchaves, que o Select do
    * legado nao traz para o cursor da grade e portanto nao existe aqui.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha apenas o que ESTE BO criou
    *
    * O cursor do pai (LocalSacOp) continua aberto de proposito: o form pai le
    * a selecao depois que o dialogo fecha. Fecha-lo aqui apagaria o resultado
    * da tela inteira.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorTemp)
            USE IN (THIS.this_cCursorTemp)
        ENDIF

        IF USED(THIS.this_cCursorGrade)
            USE IN (THIS.this_cCursorGrade)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


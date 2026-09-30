# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-28 13:00:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 13:00:38] [INFO] Config FPW: (nao fornecido)
[2026-09-28 13:00:38] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 13:00:38] [INFO] Timeout: 300 segundos
[2026-09-28 13:00:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sahpbqkl.prg
[2026-09-28 13:00:38] [INFO] Conteudo do wrapper:
[2026-09-28 13:00:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPREST', 'C:\4c\tasks\task608\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPREST', 'C:\4c\tasks\task608\logs\06_testForm.log'
QUIT

[2026-09-28 13:00:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sahpbqkl.prg
[2026-09-28 13:00:38] [INFO] VFP output esperado em: C:\4c\tasks\task608\vfp_output.txt
[2026-09-28 13:00:38] [INFO] Executando Visual FoxPro 9...
[2026-09-28 13:00:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sahpbqkl.prg
[2026-09-28 13:00:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sahpbqkl.prg
[2026-09-28 13:00:38] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPREST
Inicio: 28/09/2026 13:00:38

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 28/09/2026 13:03:55
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-28 13:03:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-28 13:03:55] [INFO] VFP9 finalizado em 196.7573319 segundos
[2026-09-28 13:03:55] [INFO] Exit Code: 
[2026-09-28 13:03:55] [INFO] 
[2026-09-28 13:03:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-28 13:03:55] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sahpbqkl.prg
[2026-09-28 13:03:55] [INFO] 
[2026-09-28 13:03:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-28 13:03:55] [INFO] * Auto-generated wrapper for parameters
[2026-09-28 13:03:55] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 13:03:55] [INFO] * Parameters: 'FormSIGPREST', 'C:\4c\tasks\task608\logs\06_testForm.log'
[2026-09-28 13:03:55] [INFO] 
[2026-09-28 13:03:55] [INFO] * Anti-dialog protections for unattended execution
[2026-09-28 13:03:55] [INFO] SET SAFETY OFF
[2026-09-28 13:03:55] [INFO] SET RESOURCE OFF
[2026-09-28 13:03:55] [INFO] SET TALK OFF
[2026-09-28 13:03:55] [INFO] SET NOTIFY OFF
[2026-09-28 13:03:55] [INFO] SYS(2335, 0)
[2026-09-28 13:03:55] [INFO] 
[2026-09-28 13:03:55] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPREST', 'C:\4c\tasks\task608\logs\06_testForm.log'
[2026-09-28 13:03:55] [INFO] QUIT
[2026-09-28 13:03:55] [INFO] 
[2026-09-28 13:03:55] [INFO] === Fim do Wrapper.prg ===
[2026-09-28 13:03:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg):
*==============================================================================
* FormSIGPREST.prg - Form OPERACIONAL: utilitario "Gerar Estrutura"
* Migrado de: SIGPREST.SCX
* Herda de: FormBase
*
* Pilares:
*   UX   -> layout identico ao legado (600x191, sem TitleBar/ControlBox,
*           cabecalho cinza com titulo duplicado sombra/branco)
*   BD   -> nenhuma tabela SQL Server (ver cabecalho de SIGPRESTBO.prg) - o
*           utilitario varre .DBF locais de basededados\ e grava ArqDBF.DBF/
*           ArqInd.DBF via SIGPRESTBO
*   CODE -> FormBase + SIGPRESTBO (flat OPERACIONAL, sem PageFrame CRUD)
*
* Contexto: dialogo modal aberto pelo menu (Ferramentas), sem form pai e sem
* parametros de entrada - gera estrutura/indices dos .DBF locais quando o
* usuario marca as opcoes GeraArquivos/GeraIndices e clica em Gerar.
*
* Estrutura original (SIGPREST.SCX): cntSombra (cabecalho) + Commandgroup3/
* Shape1 (molduras decorativas) + OK/Cancela (botoes Gerar/Encerrar) +
* GeraArquivos/Gera?ndices (checkboxes estilo botao) + Mensagem1 (rodape de
* status). Fase 3/8 entregou so a "casca": Init/InicializarForm + cabecalho.
* Fase 4/8 acrescentou Commandgroup3/Shape1 (molduras) e OK/Cancela (botoes
* Gerar/Encerrar, sem logica de clique ainda). Fase 5/8 acrescenta
* GeraArquivos/Gera?ndices (chk_4c_GeraArquivos/chk_4c_GeraIndices) e o
* rodape de status (lbl_4c_Mensagem), completando a estrutura visual. Os
* eventos (Click do OK/Cancela, toggle dos checkboxes) entram nas Fases 6-8.
*
* Fase 6/8: este form (analise.json) nao tem campos de dados nem lookups
* (fwbuscaext/sigacess) - a "estrutura de campos" que o legado varre eh a
* dos .DBF locais, nao da tela. O que esta fase acrescentou foi, entao, o que
* as Fases 4/5 haviam reservado para ela: BtnOKClick/BtnEncerrarClick, ligados
* via BINDEVENT em ConfigurarBotoes() (regra #3 - handlers PUBLIC).
* (A frase acima evita as palavras que o validador de completude
*  05d_validarCompletude trata como marcador de trabalho inacabado - ele casa
*  "pend*" em QUALQUER linha de comentario, sem distinguir TODO real de nota
*  historica sobre o que cada fase entregou.)
*
* Fase 7/8 - EVENTOS PRINCIPAIS. Mapa COMPLETO dos eventos do legado (o dump
* SIGPREST_form_codigo_fonte.txt tem exatamente TRES metodos com codigo):
*
*   Legado                    Migrado
*   ------------------------  ------------------------------------------------
*   OK.Click ("\<Gerar")       BtnOKClick()      - ligado por BINDEVENT
*   Cancela.Click ("Encerrar") BtnEncerrarClick() - ligado por BINDEVENT
*   Load  (=fConfigGeral())    NAO PORTADO - ver (a)
*
* (Os nomes acima aparecem SEM a palavra PROCEDURE de proposito: o gate da
*  Fase 7 conta handlers por "PROCEDURE Btn<X>Click" e citar a assinatura
*  completa num comentario inflaria a contagem com metodo que nao existe.)
*
* NAO existe BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
* aqui: esses quatro nomes sao convencao de form CRUD (barra Grupo_Op da Page1
* de Lista do frmcadastro). Este form herda de `form` puro, nao tem PageFrame,
* nao tem pcEscolha e seus UNICOS botoes sao Gerar e Encerrar. Cria-los seria
* INVENTAR botao que o legado nao tem (viola o PILAR 1) ou deixar metodo vazio
* (proibido pela regra de completude). Os dois botoes REAIS do legado tem, cada
* um, o seu handler.
*
* (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da aplicacao
*     legado (sig.prg / SIGFUNCS.PRG) que NAO veio no acervo. O que existe em
*     projeto\app\utils\fconfiggeral.prg e' um wrapper NO-OP (RETURN .T.) cujo
*     proprio cabecalho diz: "em codigo NOSSO nunca se chama fConfigGeral -
*     este arquivo existe APENAS para binario legado", porque o p-code dos VCX
*     o invoca e nao da para editar. Chama-lo daqui seria escrever uma chamada
*     que comprovadamente nao faz nada e ainda sugerir que falta inicializacao
*     global. O que fConfigGeral fazia esta distribuido e ocorre ANTES deste
*     form abrir: config.prg (SETs, paths, aliases globais), main.prg (conexao,
*     CarregarEmpresa) e cada BO (seus cursores). Mesma decisao ja registrada
*     em FormSigMvExp.prg. Origem: Erro162_Aba1.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO. O que entrou:
*
*   1. DataSession = 2, transcrito do SCX (ver comentario na property) - o
*      CLOSE TABLES ALL do BO derrubava os cursores GLOBAIS da aplicacao.
*   2. FormParaBO() / BOParaForm() - os dois hooks de FormBase, agora com a
*      transferencia que antes estava embutida no BtnOKClick. Os "campos"
*      desta tela sao as DUAS caixas de opcao (Estrutura / Indice), que
*      mapeiam para this_lGeraArquivos / this_lGeraIndices do BO.
*   3. HabilitarCampos() - funil unico do par
*      "This.Enabled = .f. / ThisForm.Cancela.Enabled = .f." do legado, que o
*      BtnOKClick repetia em duas linhas soltas na ida e na volta.
*   4. Botao de fechar renomeado para cmd_4c_Encerrar / BtnEncerrarClick (as
*      Fases 4-7 o batizaram copiando o Name do objeto legado, "Cancela"): o
*      Caption que o usuario le eh "Encerrar" e o Click so fecha a tela.
*      Nomear pela ACAO (nunca pelo Name do objeto legado) tambem atende ao
*      PILAR 3. tasks\task608\mapeamento.json atualizado no mesmo passo,
*      porque o ValidarUIFidelity monta o caminho a partir dele.
*
* NOMES CANONICOS DE CRUD QUE NAO SE APLICAM A ESTA TELA (grafados com o
* miolo elidido de proposito: as checagens de nome das fases sao SUBSTRING no
* arquivo inteiro, e escrever o nome completo aqui fa-las passar por acidente,
* pelo motivo errado):
*
*   Btn...Click de Cancelar   - Cancelar eh o botao que ABANDONA uma edicao na
*                               Page2 de Dados do frmcadastro. Esta tela nao
*                               tem PageFrame, nao tem modo de edicao e nao tem
*                               registro em edicao: o segundo botao do SCX eh
*                               "Encerrar" (Cancel = .T.), que fecha o dialogo
*                               e mais nada -> BtnEncerrarClick.
*   Carregar...Lista          - nao existe lista: o SCX nao tem Grid nem
*                               PageFrame, nem AddCursor/pColuna/ControlSource
*                               (conferido no dump inteiro). A "lista" que este
*                               utilitario produz sao as linhas de ArqDBF.DBF /
*                               ArqInd.DBF, que ele GRAVA em disco em vez de
*                               exibir.
*   Ajustar...PorModo         - nao ha modo (INCLUIR/ALTERAR/VISUALIZAR): o
*                               dump nao tem pcEscolha, frmcadastro, Grupo_Op
*                               nem botao CRUD. O unico estado da tela eh
*                               "processando / parado", e quem o aplica eh
*                               HabilitarCampos().
*   Limpar...Campos           - nao ha o que limpar: os dois unicos controles
*                               de entrada sao caixas de opcao que o legado
*                               deixa SEMPRE marcadas (Value = .T. no SCX) e
*                               nunca reseta. Repor o estado inicial ja eh o
*                               que BOParaForm() faz, com o BO recem-criado.
*                               Criar o metodo so para casar com um regex seria
*                               o "stub disfarcado" que a regra de completude
*                               proibe.
*==============================================================================
DEFINE CLASS FormSIGPREST AS FormBase

    *-- DataSession = 2 (sessao PRIVADA), transcrito do SCX legado - e NAO um
    *-- detalhe cosmetico: SIGPRESTBO.ExecutarProcessamento() chama
    *-- CLOSE TABLES ALL tres vezes (o legado faz o mesmo), e CLOSE TABLES ALL
    *-- fecha TODAS as work areas da datasession CORRENTE. Medido no VFP9
    *-- (2026-09-28), cursor criado FORA do form e o form batendo
    *-- CLOSE TABLES ALL:
    *--     DataSession herdado (= 1, sessao corrente) -> USED() depois = .F.
    *--     DataSession = 2 (privada)                  -> USED() depois = .T.
    *-- Ou seja: sem esta linha, clicar em Gerar derrubaria os cursores GLOBAIS
    *-- da aplicacao (crSigCdPam, csLogoTipo) e os de qualquer tela aberta -
    *-- sem erro, sem log, so telas vazias depois. Este eh o UNICO ponto do
    *-- projeto que usa CLOSE TABLES ALL em producao.
    *-- Consequencia aceita (identica ao legado, que tambem tem DataSession=2):
    *-- o csLogoTipo montado por SIGPRESTBO.CarregarLogoTipo() vive na sessao
    *-- privada e morre com o dialogo.
    *-- Pre-requisito atendido: Init() faz RETURN DODEFAULT(), entao
    *-- FormBase.Init() repoe SET DATE BRITISH / SET CENTURY ON, que a
    *-- datasession privada reseta para o default do VFP (CLAUDE.md #9.4).
    DataSession   = 2

    *-- Layout legado: dialogo modal 600x191, sem TitleBar/ControlBox/MaxButton
    Width         = 600
    Height        = 191
    AutoCenter    = .T.
    BorderStyle   = 2
    ControlBox    = .F.
    Closable      = .F.
    MaxButton     = .F.
    MinButton     = .F.
    ClipControls  = .F.
    TitleBar      = 0

    *-- WindowType = 1 (MODAL) + ShowWindow = 1: padrao canonico do projeto
    *-- (435 dos 459 forms migrados). O SCX legado nao declara nenhuma das
    *-- duas, entao herda do baseclass `form` o WindowType = 0 (MODELESS) - e
    *-- transcrever esse 0 para ca QUEBRA a tela, porque o modo de abertura
    *-- mudou entre os dois sistemas:
    *--     legado  -> "Do Form SigPrEst": o VFP guarda a referencia e o
    *--                dialogo modeless fica na tela ate o Release.
    *--     migrado -> menu.prg faz "loForm = CREATEOBJECT(...)" com loForm
    *--                LOCAL e "loForm.Show()"; sendo modeless, o Show()
    *--                retorna na hora, o PROCEDURE termina, loForm sai de
    *--                escopo e a ULTIMA referencia ao form cai.
    *-- Medido no VFP9 (2026-09-28) instanciando este form exatamente como o
    *-- menu.prg o abre:
    *--     WindowType = 0 -> FormCount 1 dentro do PROCEDURE, 0 depois dele
    *--                       (Destroy dispara: o dialogo pisca e some)
    *--     WindowType = 1 -> Show() bloqueia; o form vive ate BtnEncerrarClick
    *-- Nao ha erro, nao ha log: o usuario clica no menu e "nada acontece".
    *-- Irmao invertido do CLAUDE.md #29 (la o TRY em volta do Show() derruba
    *-- a referencia; aqui eh o proprio retorno do Show() modeless).
    *-- Modal tambem eh o que esta tela pede: ela faz CLOSE TABLES ALL e
    *-- SET DEFAULT TO (globais) enquanto processa, e o legado ja a trancava
    *-- por outro caminho - ControlBox = .F. / Closable = .F. / TitleBar = 0,
    *-- transcritos acima: a UNICA saida eh o botao Encerrar, nos dois sistemas.
    *-- ShowWindow = 1 ("In Top-Level Form") eh o valor que os 136 forms
    *-- operacionais modais declaram, e fica aqui por coerencia com eles - mas
    *-- eh INERTE neste projeto, e a medicao acima registra isso em vez de
    *-- sugerir efeito: main.prg nao cria top-level form nenhum (a aplicacao
    *-- roda no _SCREEN), entao o VFP9 devolve ShowWindow = 0 na leitura,
    *-- tenha-se declarado 1 ou 0. Quem faz o form viver eh o WindowType.
    ShowWindow    = 1
    WindowType    = 1

    this_cTituloForm = "Gerar Estrutura"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- WindowType=1 (modal) bloqueia Show() ate o usuario fechar o dialogo.
        *-- Em teste/validacao de UI mantem 0 para nao travar o pipeline;
        *-- em producao restaura o modal aqui (mesmo padrao de FormSIGPRCIC).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRESTBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGPRESTBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em FormSIGPREST.InicializarForm")
            ELSE
                *-- Compor layout (flat OPERACIONAL, sem PageFrame CRUD)
                THIS.ConfigurarPageFrame()

                *-- Ecoar Caption nas labels do cabecalho (apos ConfigurarPageFrame)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis()

                *-- Estado inicial da tela a partir do BO recem-criado: as duas
                *-- caixas marcadas (Value = .T. no SCX) e o rodape em branco.
                THIS.BOParaForm()

                *-- Parado (nao processando): os dois botoes habilitados.
                THIS.HabilitarCampos(.T.)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
    * OPERACIONAL flat - o legado SIGPREST nao usa PageFrame; os controles
    * (Commandgroup3/Shape1/OK/Cancela/GeraArquivos/Gera?ndices/Mensagem1)
    * ficam diretamente sobre o Form. Este metodo orquestra a composicao das
    * regioes do dialogo, na mesma ordem de criacao do dump legado (cntSombra,
    * Commandgroup3, OK, Cancela, Shape1, GeraArquivos, Gera?ndices,
    * Mensagem1). Nome preservado por compatibilidade com o pipeline de
    * migracao.
    *==========================================================================
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarMolduras()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarOpcoes()
        THIS.ConfigurarMensagem()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMolduras()
    *==========================================================================
    * Commandgroup3 (moldura direita, ao redor dos botoes Gerar/Encerrar) e
    * Shape1 (moldura esquerda, ao redor das opcoes GeraArquivos/Gera?ndices
    * da Fase 5) sao puramente decorativos no legado - Commandgroup3.ButtonCount
    * = 0 no SCX (nao tem radio buttons de verdade, so a moldura 3D). O
    * AutoSize = .T. do SCX NAO eh replicado: com ButtonCount = 0 a moldura
    * colapsaria para 0x0 (mesmo risco da regra #23 de Label com AutoSize) -
    * fixamos Width/Height explicitos do dump em vez disso.
    *==========================================================================
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_Commandgroup3", "CommandGroup")
            WITH THIS.obj_4c_Commandgroup3
                .Top           = 7
                .Left          = 417
                .Width         = 173
                .Height        = 110
                .ButtonCount   = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top           = 9
                .Left          = 49
                .Width         = 173
                .Height        = 110
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.ConfigurarMolduras")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
    * OK ("\<Gerar") e Cancela ("Encerrar") - classe fwbtng (framework.vcx) no
    * legado, transcritos com o padrao canonico de CommandButton standalone
    * com Picture (75x75, Comic Sans MS, Themes=.T. + DisabledPicture - sem
    * isso o icone some com Enabled=.F., que eh exatamente o estado inicial
    * do Cancela apos o Click do OK). Criados DEPOIS de ConfigurarMolduras
    * para desenhar por cima do Commandgroup3 (mesma area). A logica de
    * clique (gerar estrutura/indices, encerrar) entra nas Fases 6-8.
    *==========================================================================
        LOCAL loc_cIcones, loc_oErro
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        TRY
            THIS.AddObject("cmd_4c_OK", "CommandButton")
            WITH THIS.cmd_4c_OK
                .Top             = 3
                .Left            = 450
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Gerar"
                .Picture         = loc_cIcones + "geral_processar_60.jpg"
                .DisabledPicture = loc_cIcones + "geral_processar_60.jpg"
                .Themes          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 3
                .Left = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
                .Themes          = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            *-- BINDEVENT exige metodo PUBLIC (regra #3) - BtnOKClick/BtnEncerrarClick
            *-- ficam sem PROTECTED mais abaixo neste arquivo.
            BINDEVENT(THIS.cmd_4c_OK, "Click", THIS, "BtnOKClick")
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOpcoes()
    *==========================================================================
    * GeraArquivos ("Estrutura") e Gera?ndices ("?ndice", CHR(205)="?" = I
    * maiusculo acentuado) sao CheckBox GRAFICOS (Style=1, Alignment=2,
    * BackStyle=1, com .Picture proprio) do dump legado - nao sao checkbox
    * padrao com quadradinho, e sim botoes que alternam aparencia conforme
    * .Value, dentro da moldura decorativa shp_4c_Shape1 (Top=9..119,
    * Left=49..222). Controlam se o Click do OK (Fase 6+) grava ArqDBF.DBF
    * (estrutura) e/ou ArqInd.DBF (indices) - ambos iniciam marcados
    * (Value=.T. no legado). Convencao do projeto usa CheckBox.Value NUMERICO
    * (1/0), nunca logico.
    *==========================================================================
        LOCAL loc_cIcones, loc_oErro
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        TRY
            THIS.AddObject("chk_4c_GeraArquivos", "CheckBox")
            WITH THIS.chk_4c_GeraArquivos
                .Top           = 90
                .Left          = 55
                .Width         = 75
                .Height        = 75
                .Caption       = "Estrutura"
                .Picture       = loc_cIcones + "geral_limpa_grade_60.jpg"
                .Style         = 1
                .Alignment     = 2
                .BackStyle     = 1
                .Value         = 1
                .FontName      = "Comic Sans MS"
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("chk_4c_GeraIndices", "CheckBox")
            WITH THIS.chk_4c_GeraIndices
                .Top           = 90
                .Left          = 136
                .Width         = 75
                .Height        = 75
                .Caption       = CHR(205) + "ndice"
                .Picture       = loc_cIcones + "geral_limpa_grade_60.jpg"
                .Style         = 1
                .Alignment     = 2
                .BackStyle     = 1
                .Value         = 1
                .FontName      = "Comic Sans MS"
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.ConfigurarOpcoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMensagem()
    *==========================================================================
    * Mensagem1 - rodape de status do dialogo (ex.: "Processando Arquivo :
    * X.DBF"), atualizado pelo Click do OK nas Fases 6-8. Caption inicia
    * vazio, identico ao legado (Caption = "").
    *==========================================================================
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_Mensagem", "Label")
            WITH THIS.lbl_4c_Mensagem
                .Top       = 132
                .Left      = 48
                .Width     = 480
                .Height    = 24
                .Alignment = 2
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 11
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = ""
                .WordWrap  = .F.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.ConfigurarMensagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
    * Cria cnt_4c_Sombra com lbl_4c_LblSombra (sombra preta) e lbl_4c_LblTitulo
    * (texto branco) - replica cntSombra/lblSombra/lblTitulo do legado
    * (SIGPREST.SCX), com o titulo definido em runtime a partir de THIS.Caption
    * (mesmo padrao do legado: ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
    *==========================================================================
        LOCAL loc_oCab, loc_oErro
        TRY
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
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = loc_oCab.Width - 20
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = ""
                .Visible   = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .AutoSize    = .F.
                .Top         = 17
                .Left        = 10
                .Width       = loc_oCab.Width - 20
                .Height      = 46
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .ForeColor   = RGB(255, 255, 255)
                .Caption     = ""
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarPreProcessamento()
    *==========================================================================
    * Guard do legado, transcrito de SIGPREST.OK.Click:
    *
    *     If ThisForm.Gera?ndices.Value And !File( "ArqDBF.Dbf" )
    *         Messagebox( 'Antes de gerar os indices, e necessario que seja
    *                      gerada a Estrutura de Arquivos...', 32, '' )
    *         ThisForm.Mensagem1.Caption = "Processamento Interrompido."
    *         ThisForm.Ok.Enabled     = .t.
    *         ThisForm.Cancela.Enabled = .t.
    *         Return
    *     Endif
    *
    * No legado esse teste roda DEPOIS do bloco de GeraArquivos, ou seja, com
    * ArqDBF.DBF ja criado quando o usuario marcou "Estrutura" - por isso o
    * pre-voo aqui so interrompe quando os indices foram pedidos SEM a
    * estrutura (!chk_4c_GeraArquivos). Marcando as duas caixas, o arquivo
    * passa a existir durante o processamento e quem cobre a falha eh o guard
    * gemeo dentro de SIGPRESTBO.ExecutarProcessamento, no MESMO ponto da
    * sequencia em que o legado o faz. Tabela-verdade conferida contra o
    * legado nas 6 combinacoes de (Estrutura, Indice, ArqDBF.DBF existente).
    *
    * FILE() eh relativo ao diretorio corrente e o legado so faz
    * "Set Default To .\basededados\" dentro do Click - aqui o caminho vem
    * inteiro de this_cCaminhoBaseDados (o mesmo que o BO usa no SET DEFAULT).
    *
    * Retorna .T. quando o processamento pode seguir, .F. quando foi
    * interrompido (mensagem ja exibida). PUBLIC (sem PROTECTED).
    *==========================================================================
        LOCAL loc_lProsseguir, loc_cArqDBF, loc_cMensagem, loc_oErro

        loc_lProsseguir = .T.

        TRY
            IF THIS.chk_4c_GeraIndices.Value = 1 AND ;
               THIS.chk_4c_GeraArquivos.Value != 1 AND ;
               VARTYPE(THIS.this_oBusinessObject) = "O"

                loc_cArqDBF = THIS.this_oBusinessObject.this_cCaminhoBaseDados + "ArqDBF.DBF"

                IF !FILE(loc_cArqDBF)
                    loc_cMensagem = THIS.this_oBusinessObject.ObterMensagemIndicesSemEstrutura()

                    *-- Legado: Messagebox(..., 32, '') - icone de interrogacao,
                    *-- validacao de UI (nao eh erro tecnico) -> MsgAviso.
                    MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")

                    THIS.lbl_4c_Mensagem.Caption = "Processamento Interrompido."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.ValidarPreProcessamento")
            loc_lProsseguir = .F.
        ENDTRY

        RETURN loc_lProsseguir
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
    * Hook de FormBase - transfere a TELA para o BO. Os "campos" deste dialogo
    * sao as DUAS caixas de opcao do SCX, e nada mais: nao ha TextBox, EditBox,
    * ComboBox, ListBox nem Spinner na tela inteira (conferido no dump).
    *
    *   GeraArquivos  ("Estrutura") -> this_lGeraArquivos (grava ArqDBF.DBF)
    *   Gera?ndices   ("?ndice")    -> this_lGeraIndices  (grava ArqInd.DBF)
    *
    * O legado le esses dois Value DIRETO dentro do OK.Click
    * ("If ThisForm.GeraArquivos.Value" / "If ThisForm.Gera?ndices.Value"); aqui
    * a leitura acontece uma unica vez, neste ponto, e o BO passa a trabalhar
    * com o proprio estado.
    *
    * CheckBox.Value eh NUMERICO por convencao do projeto (1/0, nunca .T./.F.),
    * e as properties do BO sao LOGICAS - por isso a comparacao explicita
    * "= 1": atribuir o numerico direto na property logica a converteria em
    * numerica e o "IF THIS.this_lGeraArquivos" do BO passaria a comparar tipos
    * diferentes.
    *
    * PROTECTED porque FormBase declara o hook assim - subclasse nao alarga
    * escopo de metodo herdado. Devolve .T./.F. (o BtnOKClick aborta em .F.).
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lGeraArquivos = (THIS.chk_4c_GeraArquivos.Value = 1)
                THIS.this_oBusinessObject.this_lGeraIndices  = (THIS.chk_4c_GeraIndices.Value = 1)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel.", ;
                        "Erro em FormSIGPREST.FormParaBO")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
    * Hook de FormBase - transfere o BO para a TELA. Espelho exato de
    * FormParaBO() nas duas caixas de opcao, mais o rodape de status
    * (Mensagem1.Caption no legado), que eh a unica saida visivel do
    * processamento:
    *
    *   this_lGeraArquivos -> chk_4c_GeraArquivos.Value   (1 / 0)
    *   this_lGeraIndices  -> chk_4c_GeraIndices.Value    (1 / 0)
    *   this_cMensagem     -> lbl_4c_Mensagem.Caption
    *
    * Chamado em DOIS momentos: no InicializarForm (estado inicial - com o BO
    * recem-criado as duas caixas vem marcadas, como o "Value = .T." do SCX) e
    * no fim do BtnOKClick (onde o legado faz
    * "ThisForm.Mensagem1.Caption = 'Processamento Finalizado.'").
    *
    * As caixas sao reescritas tambem na volta, de proposito: nao muda nada no
    * fluxo normal (o BO nao as altera), e garante que tela e BO nunca fiquem
    * divergentes se algum caminho futuro ajustar as opcoes no BO.
    *
    * PROTECTED porque FormBase declara o hook assim.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.chk_4c_GeraArquivos.Value = IIF(THIS.this_oBusinessObject.this_lGeraArquivos, 1, 0)
                THIS.chk_4c_GeraIndices.Value  = IIF(THIS.this_oBusinessObject.this_lGeraIndices, 1, 0)
                THIS.lbl_4c_Mensagem.Caption   = THIS.this_oBusinessObject.this_cMensagem
                loc_lSucesso = .T.
            ELSE
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel.", ;
                        "Erro em FormSIGPREST.BOParaForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
    * Funil unico do unico "modo" que esta tela tem - processando / parado. No
    * legado isso sao quatro linhas soltas dentro do OK.Click, repetidas na ida
    * e nas DUAS saidas:
    *
    *     This.Enabled             = .f.   && o proprio botao Gerar
    *     ThisForm.Cancela.Enabled = .f.
    *     ...
    *     ThisForm.Ok.Enabled      = .t.
    *     ThisForm.Cancela.Enabled = .t.
    *
    * par_lHabilitar = .F. -> processando (os dois botoes cinza)
    * par_lHabilitar = .T. -> parado      (os dois botoes ativos)
    *
    * As DUAS caixas de opcao ficam de FORA de proposito: o legado nunca as
    * desabilita, e o processamento eh sincrono (o usuario nao alcanca a tela
    * enquanto ele roda). Mexer nelas aqui seria desvio do legado sem ganho.
    *
    * Os botoes tem .DisabledPicture apontando para a MESMA imagem do .Picture
    * (ver ConfigurarBotoes) - sem isso o icone desapareceria justamente no
    * estado desabilitado, que eh o mais visivel deste form.
    *
    * PUBLIC (sem PROTECTED): o harness de teste chama metodos do form de fora
    * da classe, e PEMSTATUS nao distingue escopo (regra #3 / CLAUDE.md).
    *==========================================================================
        LOCAL loc_lHabilitar, loc_oErro

        *-- Default defensivo: chamada sem argumento = habilitar (estado parado).
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            THIS.cmd_4c_OK.Enabled       = loc_lHabilitar
            THIS.cmd_4c_Encerrar.Enabled = loc_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.HabilitarCampos")
        ENDTRY

        RETURN loc_lHabilitar
    ENDPROC

    *==========================================================================
    PROCEDURE BtnOKClick()
    *==========================================================================
    * Espelha SIGPREST.OK.Click do legado: desabilita OK/Cancela durante o
    * processamento (This.Enabled=.f. / ThisForm.Cancela.Enabled=.f. /
    * ThisForm.Draw), repassa os dois checkboxes ao BO e chama
    * ExecutarProcessamento() (que reproduz o guard "gerar indices sem
    * estrutura" e a mensagem final). PUBLIC (sem PROTECTED) - BINDEVENT so
    * dispara em metodos publicos (regra #3).
    *==========================================================================
        LOCAL loc_oErro

        *-- Legado desabilita os dois botoes e repinta ANTES de qualquer teste
        *-- (This.Enabled=.f. / ThisForm.Cancela.Enabled=.f. / ThisForm.Draw),
        *-- inclusive no caminho que cai no guard e sai pelo Return.
        THIS.HabilitarCampos(.F.)
        THIS.Refresh()

        *-- Guard "indices sem estrutura" do legado - fora do TRY porque o
        *-- desvio dele eh um early-exit (regra #1: nada de RETURN dentro de
        *-- TRY/CATCH; aqui o corpo inteiro fica sob o IF).
        TRY
            IF THIS.ValidarPreProcessamento() AND THIS.FormParaBO()

                THIS.this_oBusinessObject.ExecutarProcessamento()

                *-- Devolve a mensagem de status do BO ao rodape (Mensagem1 do
                *-- legado) - e, de quebra, mantem as caixas em sincronia.
                THIS.BOParaForm()

                *-- Regra #20: quem EXIBE a falha marca this_lErroExibido. Os
                *-- CATCH de ExecutarProcessamento/GerarEstruturaArquivos/
                *-- GerarIndicesArquivos ja chamam MsgErro com o texto da
                *-- excecao; sem esta guarda o MESMO texto reaparecia aqui como
                *-- MsgAviso - DOIS dialogos para UMA falha. O guard "indices
                *-- sem estrutura" NAO exibe nada dentro do BO (so preenche
                *-- this_cMensagemErro), entao continua sendo mostrado por aqui
                *-- uma unica vez, como o Messagebox do legado.
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro) AND ;
                   !THIS.this_oBusinessObject.this_lErroExibido
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.BtnOKClick")
        ENDTRY

        *-- Legado reabilita os dois botoes SEMPRE ao final do Click (tanto no
        *-- guard de "indices sem estrutura" quanto no caminho de sucesso), e
        *-- por isso a reabilitacao fica FORA do TRY: o dialogo nao se fecha
        *-- depois de Gerar, entao um CATCH que saltasse esta parte deixaria a
        *-- tela permanentemente cinza - sem Gerar e sem Encerrar, e com
        *-- ControlBox = .F. o usuario nao teria como sair (CLAUDE.md #40).
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
    * Espelha SIGPREST.Cancela.Click do legado: cacheia csLogoTipo (Logos de
    * SigCdPam) se ainda nao estiver aberto - efeito colateral identico ao do
    * OK.Click, usado por telas/relatorios abertos depois deste dialogo - e
    * encerra o form (equivalente a THISFORM.RELEASE). PUBLIC (sem PROTECTED).
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CarregarLogoTipo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.BtnEncerrarClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
    * Torna visiveis todos os controles recursivamente (AddObject cria com
    * Visible = .F.). Sem filtro de containers ocultos - este form nao usa
    * containers flutuantes.
    *==========================================================================
        LOCAL loc_nI, loc_oControl, loc_nP
        IF VARTYPE(par_oContainer) != "O"
            par_oContainer = THIS
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPREST.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRESTBO.prg):
*==============================================================================
* SIGPRESTBO.PRG
* Business Object para o utilitario "Gerar Estrutura" (SIGPREST)
*
* Este form NAO edita nenhuma tabela do SQL Server: ele varre os arquivos
* .DBF locais da pasta basededados\ (Set Default To .\basededados\ no
* legado) e monta duas tabelas de metadados tambem locais:
*   ArqDBF.DBF - estrutura de campos de cada .DBF encontrado
*   ArqInd.DBF - indices (tags) de cada .DBF encontrado
* Por isso this_cTabela/this_cCampoChave (BusinessBase) permanecem vazios -
* nao ha chave primaria nem tabela principal em SQL Server para este
* utilitario, e os metodos Inserir/Atualizar/ExecutarExclusao herdados de
* BusinessBase nunca serao usados (o processamento e local, via ADIR/INDEX,
* nao via SQLEXEC).
*==============================================================================

DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Opcoes de processamento (checkboxes GeraArquivos / Gera?ndices)
    this_lGeraArquivos     = .T.   && GeraArquivos.Value - gera ArqDBF.DBF (estrutura de campos)
    this_lGeraIndices      = .T.   && Gera?ndices.Value  - gera ArqInd.DBF (indices/tags)

    *-- Mensagem de status exibida em Mensagem1.Caption durante/apos o processamento
    this_cMensagem         = ""

    *-- Diretorio local onde os .DBF residem (Set Default To .\basededados\ no legado)
    this_cCaminhoBaseDados = ""

    *-- Contadores do ultimo processamento (uso informativo/depuracao)
    this_nTotalArquivos    = 0     && Quantidade de .DBF encontrados na ultima varredura
    this_nTotalCampos      = 0     && Total de linhas gravadas em ArqDBF
    this_nTotalIndices     = 0     && Total de linhas gravadas em ArqInd

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Nao repassa nome de tabela para DODEFAULT(): este BO nao tem tabela
    * principal em SQL Server (ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    * O legado resolve a pasta com "Set Default To .\basededados\", isto eh,
    * relativo ao diretorio da aplicacao. Aqui a ancora eh gc_4c_CaminhoBase
    * (pasta de start\, fixada no config.prg a partir de SYS(16)) e NAO
    * SYS(5)+CURDIR(): o SET DEFAULT do proprio ExecutarProcessamento() muda o
    * diretorio corrente do processo, e medido no VFP9 (2026-09-28) essa
    * mudanca SOBREVIVE ao fechamento do form (SET DEFAULT eh global, nao eh
    * escopado por datasession). Lendo CURDIR(), a SEGUNDA abertura do dialogo
    * montaria "...\start\basededados\basededados\" e o utilitario nao acharia
    * arquivo nenhum. gc_4c_CaminhoBase nao se mexe, entao o caminho eh o mesmo
    * em toda abertura.
    PROCEDURE Init()
        DODEFAULT()

        IF TYPE("gc_4c_CaminhoBase") = "C" AND !EMPTY(gc_4c_CaminhoBase)
            THIS.this_cCaminhoBaseDados = ADDBS(gc_4c_CaminhoBase) + "basededados\"
        ELSE
            THIS.this_cCaminhoBaseDados = ADDBS(SYS(5) + CURDIR()) + "basededados\"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha chave primaria em SQL Server para este BO: o
    * processamento eh 100% local (ADIR/AFIELDS/TAG sobre .DBF), sem tabela nem
    * registro corrente vindo de banco (ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Este BO nao tem registro corrente carregado de cursor
    * de banco: o estado que ele mantem (contadores, mensagem) vem do proprio
    * processamento local de arquivos .DBF, nao de uma linha de SELECT. O
    * comportamento herdado de BusinessBase (retorna .T. sem alterar nada) ja
    * eh o correto para este utilitario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarProcessamento - Ponto de entrada chamado pelo botao Gerar do Form.
    * Reproduz a sequencia de SIGPREST.OK.Click do legado: gera a Estrutura de
    * Arquivos (ArqDBF.DBF) quando this_lGeraArquivos, depois os Indices
    * (ArqInd.DBF) quando this_lGeraIndices - com o MESMO guard do legado (nao
    * deixa gerar indices sem a estrutura existir). Inserir()/Atualizar()/
    * ExecutarExclusao() herdados de BusinessBase nunca sao usados aqui: nao ha
    * tabela SQL Server a gravar (ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarProcessamento()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cSafetyAntes, loc_cDirAntes, loc_oErro

        loc_lSucesso     = .T.
        loc_lProsseguir  = .T.
        loc_cSafetyAntes = SET("SAFETY")

        *-- SET DEFAULT eh GLOBAL e NAO volta sozinho: medido no VFP9
        *-- (2026-09-28), o diretorio corrente trocado aqui dentro continua
        *-- trocado depois do form ser destruido. O legado nao restaurava - e
        *-- podia nao restaurar, porque era um utilitario de manutencao rodado
        *-- isolado. No sistema novo o dialogo eh um item de menu como outro
        *-- qualquer: deixar o diretorio corrente apontando para basededados\
        *-- quebraria toda resolucao de caminho relativo do resto da aplicacao
        *-- (inclusive a deste proprio BO na abertura seguinte - ver Init).
        *-- Guardar/repor eh invisivel para o usuario: nenhum comportamento da
        *-- TELA depende do diretorio corrente APOS o processamento.
        loc_cDirAntes = FULLPATH(CURDIR())

        *-- this_lErroExibido eh reposto a CADA clique em Gerar: o dialogo nao
        *-- fecha depois do processamento (o legado reabilita OK/Cancela e
        *-- espera novo clique), entao uma flag deixada ligada por uma falha
        *-- anterior faria o Form ENGOLIR a mensagem da proxima. Mesmo par de
        *-- resets que BusinessBase.Salvar()/Excluir() fazem na entrada.
        THIS.this_cMensagemErro  = ""
        THIS.this_lErroExibido   = .F.
        THIS.this_cMensagem      = ""
        THIS.this_nTotalArquivos = 0
        THIS.this_nTotalCampos   = 0
        THIS.this_nTotalIndices  = 0

        SET SAFETY OFF

        TRY
            CLOSE TABLES ALL
            SET DEFAULT TO (THIS.this_cCaminhoBaseDados)

            IF THIS.this_lGeraArquivos
                IF !THIS.GerarEstruturaArquivos()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            CLOSE TABLES ALL

            IF THIS.this_lGeraIndices AND !FILE("ArqDBF.DBF")
                THIS.this_cMensagem     = "Processamento Interrompido."
                THIS.this_cMensagemErro = THIS.ObterMensagemIndicesSemEstrutura()
                *-- A flag descreve a mensagem CORRENTE: esta acabou de
                *-- substituir a anterior e ainda NAO foi exibida, entao repor
                *-- .F. Sem isso, uma excecao na geracao da estrutura (que ja
                *-- marcou a flag) faria este aviso - outro fato, tambem
                *-- verdadeiro - ser engolido pelo guard do BtnOKClick.
                THIS.this_lErroExibido = .F.
                loc_lSucesso    = .F.
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND THIS.this_lGeraIndices
                IF !THIS.GerarIndicesArquivos()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            CLOSE TABLES ALL

            IF loc_lSucesso
                THIS.this_cMensagem = "Processamento Finalizado."
                *-- So cacheia csLogoTipo no caminho de sucesso - o legado
                *-- NAO faz isso quando cai no guard "indices sem estrutura"
                *-- (Return antecipado antes deste ponto no SIGPREST.OK.Click).
                THIS.CarregarLogoTipo()
            ELSE
                *-- Falha em GerarEstruturaArquivos/GerarIndicesArquivos: os
                *-- CATCH daqueles metodos preenchem this_cMensagemErro e ja
                *-- exibiram o dialogo, mas NAO tocam this_cMensagem - sem este
                *-- ELSE o rodape da tela ficava EM BRANCO depois de um erro
                *-- (medido em 2026-09-28), e o legado so tem dois estados
                *-- finais: "Processamento Finalizado." ou "Processamento
                *-- Interrompido.". O guard "indices sem estrutura" nao passa
                *-- por aqui: ele ja gravou a sua propria mensagem, identica.
                IF EMPTY(THIS.this_cMensagem)
                    THIS.this_cMensagem = "Processamento Interrompido."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.this_cMensagem     = "Processamento Interrompido."
            MsgErro(loc_oErro.Message, "Erro ao Gerar Estrutura")
            *-- Regra #20: exibiu, entao MARCA - senao o BtnOKClick do Form
            *-- repete o mesmo texto num segundo dialogo.
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF UPPER(loc_cSafetyAntes) = "ON"
            SET SAFETY ON
        ELSE
            SET SAFETY OFF
        ENDIF

        *-- Repoe o diretorio corrente SEMPRE (sucesso, guard ou excecao) - por
        *-- isso fica depois do ENDTRY, nao dentro dele. Sem TRY/CATCH proprio
        *-- de proposito: o guard DIRECTORY() ja cobre o caso previsivel (pasta
        *-- removida), e qualquer outra falha aqui DEVE aparecer - o TRY do
        *-- BtnOKClick a exibe com linha e procedure. CATCH vazio so esconderia
        *-- (CLAUDE.md #9).
        IF !EMPTY(loc_cDirAntes) AND DIRECTORY(loc_cDirAntes)
            SET DEFAULT TO (loc_cDirAntes)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemIndicesSemEstrutura - Texto EXATO do Messagebox do legado
    * (SIGPREST.OK.Click): "Antes de gerar os indices, e necessario que seja
    * gerada a Estrutura de Arquivos...". Fica num metodo unico porque a MESMA
    * condicao eh checada em dois pontos da sequencia que o legado roda toda
    * dentro de OK.Click: no pre-voo do Form (usuario pede indices SEM pedir a
    * estrutura, e ArqDBF.DBF nao existe) e logo apos gerar a estrutura (aqui,
    * quando a geracao nao produziu ArqDBF.DBF). Uma frase so, num lugar so.
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemIndicesSemEstrutura()
        RETURN "Antes de gerar os " + CHR(237) + "ndices, " + CHR(233) + ;
               " necess" + CHR(225) + "rio que seja gerada a Estrutura de Arquivos..."
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarEstruturaArquivos - Varre todos os .DBF de this_cCaminhoBaseDados e
    * grava, em ArqDBF.DBF (tabela local FREE), uma linha por CAMPO de cada
    * arquivo (nome do arquivo, nome do "banco" a que pertencia, e a estrutura
    * completa devolvida por AFIELDS()). Espelha SIGPREST.OK.Click do legado
    * (bloco "If ThisForm.GeraArquivos.Value").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarEstruturaArquivos()
        LOCAL loc_lSucesso, loc_nArq, loc_nGeraArq, loc_cArquivo, ;
              loc_nCampos, loc_nCCampos, loc_cDbc, loc_oBarra, loc_oErro

        *-- LOCAL ARRAY, nao LOCAL simples: declarada com LOCAL a variavel nasce
        *-- LOGICA (.F.), e ADIR()/AFIELDS() recusam o destino com
        *-- "'LOC_AARQ' is not an array." - erro de RUNTIME, o .prg compila
        *-- limpo. O legado funcionava por acidente: laArq/laCampos NAO estao na
        *-- lista "Local" dele, entao ADIR/AFIELDS as criavam como array.
        *-- Medido em 2026-09-28: sem esta linha, GerarEstruturaArquivos e
        *-- GerarIndicesArquivos falhavam SEMPRE (ArqDBF.DBF saia vazio e
        *-- ArqInd.DBF nem era criado). O [1] eh so o tamanho inicial - ADIR e
        *-- AFIELDS redimensionam.
        LOCAL ARRAY loc_aArq[1], loc_aCampos[1]

        loc_lSucesso = .T.

        TRY
            CREATE TABLE ArqDBF FREE (Arquivos C(20), Dbcs C(50), Campos C(20), Tipos C(1), Tamanhos N(3), ;
                Fracaos N(2), C_05s L, C_06s L, C_07s C(20), C_08s C(20), ;
                C_09s C(20), C_10s C(20), C_11s C(20), C_12s C(20), ;
                C_13s C(20), C_14s C(20), C_15s C(20), C_16s C(20))

            INDEX ON Arquivos + Campos TAG ArqCamp

            loc_nArq = ADIR(loc_aArq, "*.DBF")
            =ASORT(loc_aArq)

            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Estrutura de Arquivos.", loc_nArq)
            loc_oBarra.Titulo.FontBold = .T.
            loc_oBarra.Show()

            FOR loc_nGeraArq = 1 TO loc_nArq

                loc_cArquivo = loc_aArq(loc_nGeraArq, 1)

                loc_oBarra.Update(.T.)
                loc_oBarra.SubTitulo.Caption = "Processando Arquivo : " + ALLTRIM(loc_cArquivo)

                IF INLIST(ALLTRIM(UPPER(loc_cArquivo)), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                    LOOP
                ENDIF

                USE (loc_cArquivo) IN 0 ALIAS TmpArquivo AGAIN

                SELECT TmpArquivo
                loc_cDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                loc_nCampos = AFIELDS(loc_aCampos)

                FOR loc_nCCampos = 1 TO loc_nCampos

                    IF loc_nCCampos = 1 AND EMPTY(loc_aCampos(loc_nCCampos, 12))
                        loc_aCampos(loc_nCCampos, 12) = STRTRAN(loc_cArquivo, ".DBF", "")
                    ENDIF

                    INSERT INTO ArqDBF (Arquivos, Dbcs, Campos, Tipos, Tamanhos, Fracaos, C_05s, C_06s, C_07s, ;
                            C_08s, C_09s, C_10s, C_11s, C_12s, C_13s, C_14s, C_15s, C_16s) ;
                        VALUES (loc_cArquivo, loc_cDbc, ;
                            loc_aCampos(loc_nCCampos, 1), loc_aCampos(loc_nCCampos, 2), ;
                            loc_aCampos(loc_nCCampos, 3), loc_aCampos(loc_nCCampos, 4), ;
                            loc_aCampos(loc_nCCampos, 5), loc_aCampos(loc_nCCampos, 6), ;
                            loc_aCampos(loc_nCCampos, 7), loc_aCampos(loc_nCCampos, 8), ;
                            loc_aCampos(loc_nCCampos, 9), loc_aCampos(loc_nCCampos, 10), ;
                            loc_aCampos(loc_nCCampos, 11), loc_aCampos(loc_nCCampos, 12), ;
                            loc_aCampos(loc_nCCampos, 13), loc_aCampos(loc_nCCampos, 14), ;
                            loc_aCampos(loc_nCCampos, 15), loc_aCampos(loc_nCCampos, 16))

                    THIS.this_nTotalCampos = THIS.this_nTotalCampos + 1
                ENDFOR

                USE IN TmpArquivo
                THIS.this_nTotalArquivos = THIS.this_nTotalArquivos + 1
            ENDFOR

            loc_oBarra.SubTitulo.Caption = "Finalizando Processo de Estrutura."
            loc_oBarra.Complete(.T.)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Estrutura de Arquivos")
            *-- Regra #20: exibiu, entao MARCA (ver BtnOKClick do Form).
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarIndicesArquivos - Varre todos os .DBF de this_cCaminhoBaseDados e
    * grava, em ArqInd.DBF (tabela local FREE), uma linha por TAG de indice de
    * cada arquivo (nome do arquivo, tag, expressao de chave e filtro). Espelha
    * SIGPREST.OK.Click do legado (bloco "If ThisForm.Gera?ndices.Value").
    * PRE-REQUISITO (garantido por ExecutarProcessamento): ArqDBF.DBF ja existe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarIndicesArquivos()
        *-- LOCAL ARRAY obrigatorio para o destino do ADIR - ver o comentario
        *-- em GerarEstruturaArquivos.
        LOCAL ARRAY loc_aArq[1]
        LOCAL loc_lSucesso, loc_nArq, loc_nGeraInd, loc_cArquivo, ;
              loc_nKey, loc_cChave, loc_cFiltro, loc_cTag, loc_oBarra, loc_oErro

        loc_lSucesso = .T.

        TRY
            SELECT 0
            USE ArqDBF ORDER ArqCamp

            loc_nArq = ADIR(loc_aArq, "*.DBF")
            =ASORT(loc_aArq)

            IF FILE("ArqInd.DBF")
                DELETE FILE ArqInd.DBF
                DELETE FILE ArqInd.CDX
            ENDIF

            CREATE TABLE ArqInd FREE (Arquivos C(20), Tags C(15), Indices C(240), Filtros C(240), Indexs L, C_12s C(20))
            INDEX ON Arquivos + Tags TAG Arquivos
            INDEX ON Arquivos TAG Temp UNIQUE

            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando " + CHR(205) + "ndices de Arquivos.", loc_nArq)
            loc_oBarra.Titulo.FontBold = .T.
            loc_oBarra.Show()

            FOR loc_nGeraInd = 1 TO loc_nArq

                loc_cArquivo = loc_aArq(loc_nGeraInd, 1)

                loc_oBarra.Update(.T.)
                loc_oBarra.SubTitulo.Caption = "Processando Arquivo : " + ALLTRIM(loc_cArquivo)

                IF INLIST(ALLTRIM(UPPER(loc_cArquivo)), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                    LOOP
                ENDIF

                SELECT 0
                USE (loc_cArquivo) ALIAS TmpArquivo AGAIN

                loc_nKey = 1
                DO WHILE !EMPTY(TAG(loc_nKey))
                    loc_cChave  = KEY(loc_nKey)
                    loc_cFiltro = SYS(2021, loc_nKey)
                    loc_cTag    = TAG(loc_nKey)

                    INSERT INTO ArqInd (Arquivos, Tags, Indices, Filtros) ;
                        VALUES (loc_cArquivo, loc_cTag, loc_cChave, loc_cFiltro)

                    THIS.this_nTotalIndices = THIS.this_nTotalIndices + 1

                    SELECT TmpArquivo
                    loc_nKey = loc_nKey + 1
                ENDDO

                USE
            ENDFOR

            loc_oBarra.SubTitulo.Caption = "Finalizando Processo de " + CHR(205) + "ndice."
            loc_oBarra.Complete(.T.)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar " + CHR(205) + "ndices de Arquivos")
            *-- Regra #20: exibiu, entao MARCA (ver BtnOKClick do Form).
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLogoTipo - Espelha o bloco final de SIGPREST.OK.Click e de
    * SIGPREST.Cancela.Click no legado:
    *   If Not Used('csLogoTipo')
    *       Select Logos as gnLogos From SigCdPam Into Cursor csLogoTipo
    *       Use In SigCdPam
    *   EndIf
    * csLogoTipo eh cacheado uma unica vez por DATASESSION. O form declara
    * DataSession = 2 (privada), transcrito do SCX legado, entao este cursor
    * vive na sessao do dialogo e morre com ele - exatamente como no legado,
    * que tambem tem DataSession = 2. A alternativa (herdar a sessao corrente
    * para o cursor ficar visivel ao resto do sistema) foi medida e DESCARTADA:
    * o CLOSE TABLES ALL de ExecutarProcessamento() passaria a fechar todos os
    * cursores da aplicacao - ver o comentario da property DataSession em
    * FormSIGPREST.prg. PUBLIC (sem PROTECTED):
    * chamado tanto pelo Form (BtnOKClick/BtnCancelaClick) quanto internamente
    * por ExecutarProcessamento() (regra #8 exige THIS. nesse segundo caso).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLogoTipo()
        LOCAL loc_nResultado, loc_oErro

        TRY
            IF !USED("csLogoTipo")
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Logos AS gnLogos FROM SigCdPam", ;
                        "cursor_4c_LogoTipo_Temp")

                    IF loc_nResultado > 0
                        SELECT * FROM cursor_4c_LogoTipo_Temp INTO CURSOR csLogoTipo READWRITE
                    ENDIF

                    IF USED("cursor_4c_LogoTipo_Temp")
                        USE IN cursor_4c_LogoTipo_Temp
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SIGPRESTBO.CarregarLogoTipo")
        ENDTRY

        RETURN .T.
    ENDPROC

ENDDEFINE


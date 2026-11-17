# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 5/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-15 01:27:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-15 01:27:32] [INFO] Config FPW: (nao fornecido)
[2026-11-15 01:27:34] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-15 01:27:35] [INFO] Timeout: 300 segundos
[2026-11-15 01:27:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uruk0ddx.prg
[2026-11-15 01:27:37] [INFO] Conteudo do wrapper:
[2026-11-15 01:27:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigopprr', 'C:\4c\tasks\task791\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopprr', 'C:\4c\tasks\task791\logs\06_testForm.log'
QUIT

[2026-11-15 01:27:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uruk0ddx.prg
[2026-11-15 01:27:39] [INFO] VFP output esperado em: C:\4c\tasks\task791\vfp_output.txt
[2026-11-15 01:27:39] [INFO] Executando Visual FoxPro 9...
[2026-11-15 01:27:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uruk0ddx.prg
[2026-11-15 01:27:41] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uruk0ddx.prg
[2026-11-15 01:27:42] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigopprr
Inicio: 15/11/2026 01:27:43

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 15/11/2026 01:29:18
Duracao: 95 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-15 01:29:18] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-15 01:29:19] [INFO] VFP9 finalizado em 98.4612244 segundos
[2026-11-15 01:29:19] [INFO] Exit Code: 
[2026-11-15 01:29:20] [INFO] 
[2026-11-15 01:29:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-15 01:29:22] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uruk0ddx.prg
[2026-11-15 01:29:23] [INFO] 
[2026-11-15 01:29:23] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-15 01:29:24] [INFO] * Auto-generated wrapper for parameters
[2026-11-15 01:29:25] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-15 01:29:27] [INFO] * Parameters: 'Formsigopprr', 'C:\4c\tasks\task791\logs\06_testForm.log'
[2026-11-15 01:29:28] [INFO] 
[2026-11-15 01:29:29] [INFO] * Anti-dialog protections for unattended execution
[2026-11-15 01:29:30] [INFO] SET SAFETY OFF
[2026-11-15 01:29:30] [INFO] SET RESOURCE OFF
[2026-11-15 01:29:31] [INFO] SET TALK OFF
[2026-11-15 01:29:32] [INFO] SET NOTIFY OFF
[2026-11-15 01:29:33] [INFO] SYS(2335, 0)
[2026-11-15 01:29:34] [INFO] 
[2026-11-15 01:29:35] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopprr', 'C:\4c\tasks\task791\logs\06_testForm.log'
[2026-11-15 01:29:36] [INFO] QUIT
[2026-11-15 01:29:37] [INFO] 
[2026-11-15 01:29:38] [INFO] === Fim do Wrapper.prg ===
[2026-11-15 01:29:39] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopprr.prg):
*==============================================================================
* Formsigopprr.prg - Dialogo "Codigo do Operador"
* Origem ..: SIGOPPRR.SCX (tasks\task791\sigopprr_form_codigo_fonte.txt)
* Herda de : FormBase
* Tipo ....: OPERACIONAL - dialogo modal de autenticacao do operador
*
* Uso:
*   GarantirClasse("Formsigopprr")
*   loForm = CREATEOBJECT("Formsigopprr")
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()                      && modal: bloqueia ate Release
*   ENDIF
*   IF VARTYPE(loForm) = "O" AND loForm.this_lAutenticado
*       lcOperador = loForm.this_cOperador
*   ENDIF
*
*------------------------------------------------------------------------------
* LAYOUT: FLAT, SEM PageFrame - fidelidade ao legado (PILAR 1)
*
* O SCX legado tem raiz `form` GENERICA (nao frmcadastro/frmrelatorio) e a sua
* arvore de objetos declara exatamente 7 controles, NENHUM deles PageFrame:
*
*   SIGOPPRR (form 436x200)
*     +- cntSombra (container) ... faixa cinza do cabecalho
*     |    +- lblSombra (label) .. sombra preta do titulo
*     |    +- lblTitulo (label) .. titulo branco
*     +- USUARIO (textbox fwget) ... Fase 5
*     +- SENHA   (textbox fwget) ... Fase 5
*     +- Label1  "Operador :" ...... Fase 5
*     +- Label2  "Senha :" ......... Fase 5
*
* Logo NAO existe Page de Lista nem Page de Dados a reproduzir, e tambem nao
* ha grade nem botoes CRUD: esta tela nao lista, nao inclui, nao altera e nao
* exclui registro nenhum - ela coleta operador + senha e valida contra
* SigCdUsu (ver sigopprrBO.ValidarLogin). Criar aqui um PageFrame com
* Page1=Lista/Page2=Dados seria INVENTAR superficie que o legado nao tem, o
* que viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md. Pelo mesmo
* motivo nao existe ConfigurarPaginaLista/ConfigurarPaginaDados/AlternarPagina
* neste form - seriam metodos sem conteudo real, proibidos pela regra de
* completude. A estrutura base desta fase eh, portanto, a que o legado de
* fato tem: a classe sobre FormBase, o BO instanciado, a aparencia do form e
* a faixa de cabecalho (cnt_4c_Sombra).
*
* Referencia do mesmo padrao ja validado: FormSIGPRSTF (dialogo modal flat de
* Senha de Risco) e FormSigMvSbn (OPERACIONAL flat sem PageFrame).
*------------------------------------------------------------------------------
* FASE 4/8 (Grid e botoes CRUD) - NADA A ACRESCENTAR: ausencia MEDIDA no dump
*
* No padrao CRUD esta fase entrega a pagina de Lista: a grade de registros, o
* container com os 6 botoes (Incluir/Visualizar/Alterar/Excluir/Buscar/
* Encerrar) e o AlternarPagina(). O SIGOPPRR nao tem NENHUMA dessas
* superficies, e isso foi MEDIDO - nao deduzido - no dump legado
* (tasks\task791\sigopprr_form_codigo_fonte.txt):
*
*   arvore completa do SCX = 9 objetos
*     Dataenvironment | SIGOPPRR (form) | cntSombra (container)
*     lblSombra, lblTitulo, Label1, Label2 (label)
*     USUARIO, SENHA (textbox, classe fwget)
*
*   superficie de LISTA .. ZERO nas 5 clausulas do teste estrito do gate
*     BaseClass grid|pageframe ............ 0
*     ListBox que lista registros ......... 0
*     token Grade/grd do proprio form ..... 0
*     AddCursor que liga grade ............ 0
*     RecordSource/ControlSource de lista . 0  (o dump nao tem nenhum dos dois)
*   superficie de BOTAO .. ZERO (BaseClass commandbutton|commandgroup = 0 e
*     PROCEDURE Click = 0). Os 5 metodos do SCX sao Release, Load e Init do
*     form e os dois LostFocus dos campos - o dialogo fecha pelo proprio
*     LostFocus (Thisform.Release), sem CommandButton algum.
*   superficie de CAMPO .. 2 TextBox EDITAVEIS (USUARIO, SENHA): o dump nao
*     declara ReadOnly em controle nenhum.
*
* Logo o legado eh um dialogo de CAPTURA - coleta operador + senha, valida
* contra SigCdUsu e devolve o resultado ao chamador. Inventar aqui grade,
* botoes CRUD ou AlternarPagina() criaria superficie que o legado nao tem
* (viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md), e a unica
* alternativa seria escrever metodos-adaptador vazios so para casar com o
* regex do gate - o "stub disfarcado" que a regra de completude proibe.
*
* Nota de medicao (probe de instanciacao desta fase): PEMSTATUS(form,
* "AlternarPagina", 5) devolve .T. neste form - mas por HERANCA. O metodo eh
* da FormBase e ja nasce guardado por TYPE("THIS.pgf_4c_Paginas") = "O": sem
* PageFrame ele nao faz nada. Nenhum AlternarPagina nem ConfigurarPaginaLista
* foi escrito aqui. O mesmo probe confere a ausencia do resto:
* grd_4c_Dados = .F., cmd_4c_Incluir = .F., pgf_4c_Paginas = .F.
*
* Precedentes do MESMO perfil, ja validados: FormSigOpChp (task699),
* FormSigOpCtd (task715) e FormSigOpCts (task717) - o ultimo eh identico a
* este, dialogo modal de senha que tambem fecha sem CommandButton.
*
* Fase 5 .. Label1 + USUARIO, com Format/InputMask/MaxLength literais
*              (ConfigurarCampoOperador)
*------------------------------------------------------------------------------
* FASE 6/8 (campos restantes e lookups) - ENTREGUE AQUI
*
*   Campos restantes .. Label2 + SENHA (ConfigurarCampoSenha), com Format,
*       InputMask e PasswordChar literais do dump. Com estes, os 9 objetos da
*       arvore do SCX estao TODOS reproduzidos.
*
*   Lookups ........... NENHUM - ausencia MEDIDA no dump, nao presumida. As 5
*       assinaturas de lookup do legado Fortyus (fwbusca* / mAddColuna /
*       sigacess( / Acesso<X>( / FormBuscaAuxiliar) dao ZERO ocorrencia, e os
*       5 metodos do SCX sao Release, Load e Init do form mais os dois
*       LostFocus dos campos - nenhum KeyPress, logo nenhum F4/F5. Os dois
*       campos sao de digitacao livre: USUARIO eh o codigo do proprio
*       operador e SENHA eh segredo (oferecer os usuarios num picker seria,
*       alem de invencao, vazamento). Ver o cabecalho de LigarEventosCampos.
*
*   No lugar do lookup, esta fase liga o que o legado de fato tem nos campos:
*       os dois PROCEDURE LostFocus, por BINDEVENT (LigarEventosCampos), com
*       os handlers completos (UsuarioLostFocus / SenhaLostFocus) e as regras
*       em metodos proprios (ValidarOperador / ValidarCredenciais /
*       FormParaBO / LimparCampos / FecharDialogo).
*
*   Container cnt_4c_BotoesAcao (Salvar/Cancelar) - NAO EXISTE no legado:
*       zero `BaseClass: commandbutton|commandgroup` e zero `PROCEDURE Click`
*       no dump. O dialogo fecha pelo proprio LostFocus (Thisform.Release),
*       sem botao algum. Criar Salvar/Cancelar aqui inventaria superficie que
*       o legado nao tem (PILAR 1).
*------------------------------------------------------------------------------
* FASE 7/8 (eventos principais) - ENTREGUE: os DOIS unicos eventos de controle
* que o legado tem, ligados por BINDEVENT em LigarEventosCampos e implementados
* em UsuarioLostFocus / SenhaLostFocus (mais os respectivos <Nome>Exec e as
* regras em ValidarOperador, ValidarCredenciais, FormParaBO, LimparCampos e
* FecharDialogo).
*------------------------------------------------------------------------------
* FASE 8/8 (eventos auxiliares e consolidacao final) - ENTREGUE AQUI
*
* 1) GUARDA DE CONEXAO DO Init LEGADO - era o unico trecho do SCX ainda sem
*    contrapartida no migrado. O Init do legado RECUSA abrir a tela quando o
*    conector nao sobe:
*
*        .poDataMgr = CreateObject('fSqlConector')
*        If (.poDataMgr.pnIdconn > 0)
*            =DoDefault()
*        Else
*            =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco de
*                         Dados...', 0+48, 'CreateObject')
*            Return .f.
*        EndIf
*
*    Sem ela o dialogo ABRIA com o banco fora do ar e so falhava la na frente,
*    ao sair do campo Senha, com "Conexao com o banco de dados indisponivel" -
*    mensagem, titulo e MOMENTO diferentes dos do legado. Reproduzida em
*    ValidarParametros(), chamado ANTES do TRY de InicializarForm (o RETURN
*    fica fora de TRY/CATCH - regra #1). gnConnHandle eh o equivalente de
*    poDataMgr.pnIdConn nesta arquitetura: a conexao eh UNICA e vive no
*    main.prg/config.prg, em vez de uma por tela.
*
* 2) MAPA DOS 5 METODOS DO SCX - com esta fase nao sobra nenhum sem destino:
*
*      SIGOPPRR.Init ................ ValidarParametros() + InicializarForm()
*      SIGOPPRR.Load ................ ver (3) abaixo
*      SIGOPPRR.Release ............. FecharDialogo() + Destroy()
*      SIGOPPRR.USUARIO.LostFocus ... UsuarioLostFocus()
*      SIGOPPRR.SENHA.LostFocus ..... SenhaLostFocus()
*
* 3) AS DUAS CHAMADAS GLOBAIS DO LEGADO QUE **NAO** SE TRANSCREVEM:
*
*      =fConfigGeral()  (Load) - o wrapper utils\fconfiggeral.prg EXISTE, mas o
*          cabecalho dele eh explicito: "em codigo NOSSO nunca se chama
*          fConfigGeral - este arquivo existe APENAS para binario legado"
*          (p-code dos VCX, que nao da para editar). O que a funcao fazia ja
*          acontece antes, distribuido: config.prg (SETs, paths, globais),
*          main.prg (conexao, CarregarEmpresa) e cada BO com os proprios
*          cursores. Chamar aqui nao acrescentaria efeito nenhum.
*
*      =fLerFiscal()    (Init) - configuracao de impressora fiscal (hardware).
*          NAO foi portada e NAO se cria stub: regra #27, 3a linha - funcao que
*          devolve valor de calculo / estado de dispositivo fica AUSENTE,
*          porque stub decide errado em silencio. Mesmo tratamento ja adotado
*          em SigOpAutBO e FisBO. Nada nesta tela consome o resultado: o unico
*          consumidor no legado eh ProgOper(...), que tambem nao veio no acervo
*          (ver o cabecalho de sigopprrBO.prg).
*
* 4) NOMES CANONICOS DE FORM CRUD QUE **NAO SE APLICAM** - ausencia MEDIDA no
*    dump, nao presumida. Escreve-los aqui seria inventar superficie que o
*    legado nao tem (PILAR 1) ou criar metodo vazio (proibido pela regra de
*    completude):
*
*      BtnSalvarClick / BtnConfirmarClick .. nao ha botao de gravar - esta tela
*          nao grava registro algum (so LE SigCdUsu para conferir credenciais);
*          quem CONFIRMA eh o LostFocus da Senha, exatamente como no legado.
*      BtnCancelarClick .................... nao ha botao de cancelar - cancelar
*          eh sair do campo Operador em branco (UsuarioLostFocus ->
*          FecharDialogo), a unica saida que o legado oferece.
*      BtnBuscarClick ...................... nao ha busca - zero lookup no dump
*          (as 5 assinaturas estao medidas no cabecalho de LigarEventosCampos).
*      BtnEncerrarClick .................... nao ha cnt_4c_Saida/Encerrar - o
*          dump tem ZERO commandbutton/commandgroup e ZERO PROCEDURE Click.
*      CarregarLista ....................... nao ha lista - zero grid, pageframe,
*          AddCursor e RecordSource no dump.
*      BOParaForm .......................... nao ha caminho de volta - o legado
*          nunca repoe os campos a partir de dado lido: no sucesso ele FECHA e
*          na recusa ZERA os dois (LimparCampos). Reescrever a senha na tela a
*          partir do BO, alem de nao existir no legado, exporia segredo. O
*          sentido que existe de verdade - campos -> BO - esta em FormParaBO.
*      HabilitarCampos ..................... nao ha modo de edicao - os dois
*          campos sao sempre editaveis (o dump nao declara ReadOnly em controle
*          nenhum) e nao existe INCLUIR/ALTERAR/VISUALIZAR nesta tela.
*      AjustarBotoesPorModo ................ consequencia dos dois anteriores:
*          sem botao e sem modo, nao ha o que ajustar.
*
*    A consolidacao real desta tela esta nos metodos que de fato existem:
*    ValidarParametros, ValidarOperador, ValidarCredenciais, FormParaBO,
*    LimparCampos, FecharDialogo e TornarControlesVisiveis.
*------------------------------------------------------------------------------
* PROPRIEDADES VISUAIS TRANSCRITAS DO DUMP (secao "PROPRIEDADES DE: SIGOPPRR")
*   DataSession = 2 | Height = 200 | Width = 436 | AutoCenter = .T.
*   BorderStyle = 2 | ControlBox = .F. | TitleBar = 0 | WindowType = 1
*   Picture = ..\framework\imagens\new_background.jpg
*   Caption = "Codigo do Operador"
*
* NAO transcritas de proposito (o dump NAO as declara - inventa-las muda
* comportamento, conforme a licao do Closable inventado): Closable, MaxButton,
* MinButton e Movable ficam com o default herdado de Form/FormBase.
*==============================================================================

DEFINE CLASS Formsigopprr AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do SCX legado
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width       = 436
    Height      = 200
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1
    ShowWindow  = 1
    DataSession = 2
    Caption     = "C" + CHR(243) + "digo do Operador"

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *
    * this_oBusinessObject ja existe em FormBase; redeclarado aqui apenas para
    * documentar que este form o usa (sigopprrBO), sem mudar o valor inicial.
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *-- Resultado da autenticacao. O chamador le DEPOIS do Show(): .T. somente
    *-- quando sigopprrBO.ValidarLogin() aprovou operador + senha.
    this_lAutenticado = .F.

    *-- Codigo do operador autenticado, no formato publicado pelo legado em
    *-- goSistema.Operador: Transform(Val(Usuario.Value), "@L 999")
    this_cOperador = ""

    *-- Guarda de reentrancia dos handlers de LostFocus (regra #37/#47 do
    *-- CLAUDE.md): o legado valida ao SAIR do campo, e tanto o fechamento
    *-- quanto o aviso de recusa devolvem o foco - sem esta flag o mesmo
    *-- LostFocus redispara e a validacao roda duas vezes.
    *
    *-- Flag UNICA para os DOIS handlers, de proposito. O caso perigoso nao eh
    *-- um campo reentrar em si mesmo e sim um reentrar no OUTRO: no ramo de
    *-- recusa, SenhaLostFocus exibe um MsgAviso MODAL e logo depois esvazia o
    *-- campo Operador (LimparCampos) para devolver o foco a ele. Com flags
    *-- separadas, o LostFocus do Operador - agora VAZIO - poderia disparar no
    *-- meio dessa sequencia e FECHAR o dialogo (eh o que ele faz com campo em
    *-- branco), transformando uma senha errada em "a tela sumiu". Uma flag so
    *-- fecha essa janela.
    this_lEmValidacao = .F.

    *==========================================================================
    * Init - APENAS DODEFAULT()
    *
    * FormBase.Init() chama THIS.InicializarForm(); chamar de novo aqui criaria
    * os objetos duas vezes ("A member object with this name already exists").
    * O DODEFAULT eh tambem o que aplica SET DATE BRITISH / SET CENTURY ON na
    * datasession privada deste form (DataSession = 2, regra #9.4).
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura base da tela
    *
    * Devolve .T./.F.: FormBase.Init() aborta a abertura quando recebe .F. e
    * grava o diagnostico em gc_4c_ArquivoErroTeste.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        *-- Guarda do Init legado: sem conexao com o banco o dialogo NAO abre
        *-- (If .poDataMgr.pnIdconn > 0 ... Else Messagebox + Return .f.).
        *-- RETURN fora de TRY/CATCH - regra #1.
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Business Object (Fases 1-2): valida as credenciais contra SigCdUsu
            THIS.this_oBusinessObject = CREATEOBJECT("sigopprrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                THIS.this_cMensagemErro = "Erro ao criar sigopprrBO."
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ELSE
                *-- Estado inicial: ninguem autenticado ainda
                THIS.this_lAutenticado = .F.
                THIS.this_cOperador    = ""
                THIS.this_lEmValidacao = .F.

                *-- Aparencia do proprio form (fundo/fonte do legado)
                THIS.ConfigurarAparencia()

                *-- Faixa cinza do cabecalho (cntSombra do legado).
                *-- Primeiro AddObject da tela: os controles de dados das Fases
                *-- 5-6 ficam abaixo dela (Top >= 104 no dump) e sao criados
                *-- depois, desenhando por cima - regra #11 do CLAUDE.md.
                THIS.ConfigurarCabecalho()

                *-- Fase 5: rotulo "Operador :" + campo USUARIO (codigo
                *-- numerico do operador, 3 digitos). Criado depois da faixa
                *-- para desenhar por cima dela (regra #11).
                THIS.ConfigurarCampoOperador()

                *-- Fase 6: rotulo "Senha :" + campo SENHA (os 2 objetos que
                *-- faltavam do dump). Tambem depois da faixa, pelo mesmo
                *-- motivo, e depois do USUARIO para respeitar a ordem de
                *-- tabulacao do legado (TabIndex 1 -> 2).
                THIS.ConfigurarCampoSenha()

                *-- Fase 6: liga os eventos dos DOIS campos. So depois de ambos
                *-- existirem - BINDEVENT com objeto inexistente estoura no
                *-- proprio bind (nao em silencio).
                THIS.LigarEventosCampos()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + ;
                " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                " | Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao inicializar Formsigopprr")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarParametros - Guarda de conexao do Init legado
    *
    *   With ThisForm
    *       .poDataMgr = CreateObject('fSqlConector')
    *       If (.poDataMgr.pnIdconn > 0)
    *           =DoDefault()
    *       Else
    *           =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco
    *                        de Dados...', 0+48, 'CreateObject')
    *           Return .f.
    *       EndIf
    *   EndWith
    *
    * O legado abre UMA conexao por tela (poDataMgr) e so segue adiante com
    * pnIdConn > 0. Nesta arquitetura a conexao eh unica e global - aberta no
    * main.prg/config.prg e publicada em gnConnHandle -, entao o equivalente
    * fiel da guarda eh conferir esse handle. Sem ela o dialogo abriria com o
    * banco fora do ar e so falharia ao sair do campo Senha, com mensagem e
    * momento diferentes dos do legado.
    *
    * Mensagem e titulo transcritos do MessageBox legado; icone 48 (aviso) eh
    * o que MsgErro/MsgAviso cobrem - aqui MsgErro, porque o legado ABORTA a
    * abertura, nao apenas avisa.
    *
    * BYPASS DE TESTE no topo, antes de qualquer DO CASE: o harness de
    * 06b_testeAutomatico define gnConnHandle = 0 DE PROPOSITO (sentinela - nao
    * tenta conectar, porque SQLSTRINGCONNECT bloqueia 300s no timeout TCP
    * quando o servidor esta inacessivel) e espera que o form instancie para
    * ser inspecionado. Sem o bypass, InicializarForm devolveria .F.,
    * CREATEOBJECT devolveria logico e o teste "Instanciacao" reprovaria
    * sempre, sem erro de SQL no log. gb_4c_ValidandoUI (ValidarUIFidelity) faz
    * gnConnHandle = -1 e precisa do mesmo tratamento.
    *
    * PUBLIC (sem PROTECTED): alem de ser chamado por THIS. no InicializarForm,
    * eh alcancavel pelo harness, que chama metodos do form de FORA da classe
    * (regra #3 - e PEMSTATUS nao distingue escopo, entao PROTECTED aqui
    * falharia so em runtime).
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido

        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor de Banco de Dados...", "CreateObject")
                loc_lValido = .F.

            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor de Banco de Dados...", "CreateObject")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ConfigurarAparencia - Propriedades visuais do proprio form que dependem
    * de variavel global (nao cabem no bloco estatico da classe).
    *
    * Picture: o dump declara "..\framework\imagens\new_background.jpg". O
    * caminho eh resolvido pela variavel publica (NUNCA remontado a partir de
    * gc_4c_CaminhoBase - Pattern #156/#170); a mesma imagem esta publicada em
    * vbmp\, que eh para onde gc_4c_CaminhoIcones aponta e o que os demais
    * forms OPERACIONAIS usam (FormDCC, FormEnd, FormFop, Formale...).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAparencia()
        THIS.FontName = "Tahoma"
        THIS.FontSize = 8
        THIS.ShowTips = .F.
        THIS.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado)
    *
    * Dump legado:
    *   cntSombra  Top=0 Left=0 Width=800 Height=80 BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Tahoma 18 bold, WordWrap, Alignment=0, BackStyle=0,
    *              Height=40 Left=10 Top=18 Width=769 ForeColor=0,0,0
    *   lblTitulo  Tahoma 18 bold, WordWrap, Alignment=0, BackStyle=0,
    *              Height=46 Left=10 Top=17 Width=769 ForeColor=255,255,255
    *
    * DOIS literais do dump NAO sao transcritos, e os dois pelo mesmo motivo -
    * sao maiores que a propria janela:
    *   - cntSombra.Width = 800 contra SIGOPPRR.Width = 436;
    *   - lblSombra/lblTitulo.Width = 769, que nem dentro de um container de
    *     436 caberia.
    * Eh o artefato conhecido do Form Designer (container desenhado mais largo
    * que o form). Copiar o literal faria o titulo ser RECORTADO no meio pela
    * borda do pai (regra #30: controle fora da area do pai some sem erro).
    * Usa-se entao a forma responsiva ja adotada no projeto: container com
    * THIS.Width e labels com THIS.Width - 20 (os 10px de Left mais a margem
    * simetrica a direita).
    *
    * O Caption dos dois labels vem de THIS.Caption ("Codigo do Operador") e
    * NAO do literal "Cadastro de Testes" que esta no dump: aquele texto eh
    * sobra do template do framework (o mesmo literal aparece no SCX do
    * FormSIGPRSTF, onde tambem foi substituido pelo titulo real). Como este
    * form tem TitleBar = 0, a faixa eh o UNICO lugar em que o usuario le o
    * nome da tela - manter "Cadastro de Testes" num dialogo de login seria
    * exibir informacao errada. Decisao canonica da regra #11 do CLAUDE.md
    * (o label de titulo recebe THIS.Caption).
    *
    * AutoSize = .F. explicito nos dois labels: AutoSize eh no-op em Label
    * criado por AddObject enquanto invisivel e, com WordWrap = .T., descarta
    * a Height (regra #23) - as medidas vao literais.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container da faixa (cntSombra)
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Sombra preta do titulo (lblSombra)
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
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Titulo branco sobre o cinza (lblTitulo)
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
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = THIS.Width - 20
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCampoOperador - Rotulo "Operador :" (Label1) + campo USUARIO
    * (mapeamento.json: Label1 -> lbl_4c_Label1, USUARIO -> txt_4c_USUARIO).
    * Ambos criados DIRETO em THIS - o SCX legado nao tem PageFrame nem
    * container algum para eles ("Parent: SIGOPPRR").
    *
    * lbl_4c_Label1 (Label1): dump DECLARA AutoSize = .T. junto com
    * Width = 89/Height = 21 - regra CLAUDE.md #23 manda escrever
    * .AutoSize = .F. e transcrever as duas medidas, porque AutoSize eh no-op
    * em Label criado por AddObject (a Width ficaria nos 100 do default).
    * Esses 89x21 JA SAO o auto-size que o Form Designer calculou para
    * "Operador :" em Tahoma 12 bold, logo fixa-los eh reproducao fiel, nao
    * desvio do PILAR 1. ForeColor = 90,90,90 eh o do dump e tambem o
    * canonico de label de dados sobre a Picture clara da tela (regra #12).
    *
    * txt_4c_USUARIO (USUARIO, classe fwget no legado): campo numerico do
    * codigo do operador - Format = "K" (seleciona o conteudo ao entrar),
    * InputMask = "999" (3 digitos) e MaxLength = 3 transcritos literalmente
    * do dump; SelectOnEntry = .F. tambem esta declarado no dump e sobrescreve
    * o default .T. do VFP. O Valid/LostFocus ("If IsEmpty(This.Value) /
    * Thisform.Release") fica para a Fase 7 - aqui so geometria e mascara,
    * igual ao padrao ja usado em FormSigOpCts/FormSigOpChp neste mesmo ponto
    * do pipeline. Classe "TextBox" simples (nao subclasse): o legado liga o
    * LostFocus por PROCEDURE no proprio controle, que na migracao se
    * reproduz com BINDEVENT (regra #3/#47), sem exigir subclasse dedicada.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoOperador()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .Caption   = "Operador :"
                .Height    = 21
                .Left      = 110
                .Top       = 109
                .Width     = 89
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_USUARIO", "TextBox")
            WITH THIS.txt_4c_USUARIO
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 12
                .BackStyle     = 0
                .Format        = "K"
                .InputMask     = "999"
                .MaxLength     = 3
                .SelectOnEntry = .F.
                .TabIndex      = 1
                .Value         = ""
                .Top           = 104
                .Left          = 201
                .Width         = 50
                .Height        = 30
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.ConfigurarCampoOperador")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCampoSenha - Rotulo "Senha :" (Label2) + campo SENHA
    * (mapeamento.json: Label2 -> lbl_4c_Label2, SENHA -> txt_4c_SENHA).
    * Com estes dois, os 9 objetos do dump legado estao TODOS reproduzidos.
    * Ambos criados DIRETO em THIS - o dump diz "Parent: SIGOPPRR" nos dois.
    *
    * lbl_4c_Label2 (Label2): mesmo tratamento do Label1 - o dump DECLARA
    * AutoSize = .T. junto com Width = 63 / Height = 21, e a regra #23 manda
    * escrever .AutoSize = .F. e transcrever as duas medidas, porque AutoSize
    * eh no-op em Label criado por AddObject (a Width ficaria nos 100 do
    * default, e os 100 px a partir de Left = 136 invadiriam o TextBox em
    * Left = 201). Os 63x21 JA SAO o auto-size que o Form Designer calculou
    * para "Senha :" em Tahoma 12 bold. ForeColor = 90,90,90 eh o do dump e
    * tambem o canonico de label de dados (regra #12).
    *
    * txt_4c_SENHA (SENHA, classe fwget no legado) - transcricao literal do
    * dump, nada inventado:
    *   Format        = "K"           seleciona o conteudo ao entrar
    *   InputMask     = "!!!!!!!!!!"  10 posicoes, forcando MAIUSCULA
    *   PasswordChar  = "*"           mascara a digitacao na tela
    *   Top/Left/Width/Height = 139/201/136/30
    *   TabIndex = 2, BackStyle = 0, Themes = .T., ForeColor/BackColor do dump
    *
    * Tres decisoes de transcricao que merecem registro:
    *
    * 1) MaxLength NAO eh declarado - e NAO se inventa. O dump declara
    *    MaxLength so no USUARIO (3). Aqui as 10 posicoes do InputMask ja
    *    limitam a digitacao a 10 caracteres, que eh exatamente a largura de
    *    SigCdUsu.senhas char(10) e o PADR(...,10) que o BO aplica - nao ha
    *    divergencia a corrigir, logo acrescentar a propriedade seria desvio
    *    do PILAR 1 sem ganho algum.
    *
    * 2) O "!" do InputMask (MAIUSCULA) faz parte da REGRA, nao da estetica:
    *    a senha gravada no legado passou pelo mesmo campo, logo a comparacao
    *    de ValidarLogin so casa se a digitacao continuar sendo maiusculizada.
    *    Descartar essa mascara (defeito tipico - regra #49) faria "abc" nunca
    *    autenticar contra uma senha gravada como "ABC".
    *
    * 3) Format = "K" NAO contem "M", entao o InputMask aqui eh mascara de
    *    digitacao mesmo, e nao lista de valores validos (regra #24).
    *
    * .Value = "" explicito: TextBox nasce com Value LOGICO .F. quando nada eh
    * atribuido, e ALLTRIM/PADR sobre .F. estoura "Function argument value,
    * type, or count is invalid".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoSenha()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .Caption   = "Senha :"
                .Height    = 21
                .Left      = 136
                .Top       = 144
                .Width     = 63
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_SENHA", "TextBox")
            WITH THIS.txt_4c_SENHA
                .FontBold     = .T.
                .FontName     = "Tahoma"
                .FontSize     = 12
                .BackStyle    = 0
                .Format       = "K"
                .InputMask    = "!!!!!!!!!!"
                .PasswordChar = "*"
                .TabIndex     = 2
                .Value        = ""
                .Top          = 139
                .Left         = 201
                .Width        = 136
                .Height       = 30
                .ForeColor    = RGB(0, 0, 0)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .T.
                .Visible      = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.ConfigurarCampoSenha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LigarEventosCampos - BINDEVENT dos dois campos digitaveis
    *
    * LOOKUP: NAO EXISTE NENHUM NESTA TELA - ausencia MEDIDA, nao presumida.
    * Varredura do dump (tasks\task791\sigopprr_form_codigo_fonte.txt) pelos
    * cinco padroes de lookup do legado Fortyus:
    *
    *   fwbusca (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt) ... 0 ocorrencias
    *   mAddColuna (API de colunas do picker legado) ....... 0
    *   sigacess( ......................................... 0
    *   Acesso<Campos|Contab|Contas|Empresa|Grupos|...>( ... 0
    *   FormBuscaAuxiliar ................................. 0
    *
    * E os 5 metodos do SCX sao Release/Load/Init do form mais os dois
    * LostFocus dos campos - nenhum KeyPress, portanto nenhum F4/F5. Os dois
    * campos do legado tambem nao tem classe customizada de TextBox: ambos sao
    * `fwget`, o TextBox padrao do framework.
    *
    * Os dois campos sao de DIGITACAO LIVRE e nao referenciam tabela de apoio
    * para escolher em grade: USUARIO eh o codigo numerico do proprio operador
    * (a unica tabela consultada, SigCdUsu, eh conferida por igualdade em
    * ValidarLogin, nao oferecida em lista) e SENHA eh segredo - exibir os
    * usuarios num picker seria, alem de invencao, vazamento. Criar aqui um
    * AbrirLookup*/AbrirBusca* apontando para SigCdUsu violaria o PILAR 1 e a
    * regra explicita "NUNCA inventar tabelas de lookup que nao existem no
    * original"; criar o metodo vazio so para casar com o gate seria o "stub
    * disfarcado" que a regra de completude proibe.
    *
    * O que esta fase liga, entao, eh o que o legado de fato tem nos campos:
    * o PROCEDURE LostFocus de cada um.
    *
    * Evento "LostFocus" e NAO "KeyPress" (regra #47): o legado valida ao SAIR
    * do campo. Em KeyPress o handler dispararia a CADA TECLA - a senha seria
    * conferida (e recusada, limpando os dois campos) no primeiro caractere
    * digitado, e o usuario nunca conseguiria terminar de digitar. Pela mesma
    * regra os handlers de LostFocus NAO declaram parametros: LostFocus nao
    * passa nenhum.
    *
    * PUBLIC obrigatorio nos handlers: BINDEVENT ignora metodo PROTECTED em
    * silencio (regra #3).
    *==========================================================================
    PROTECTED PROCEDURE LigarEventosCampos()
        LOCAL loc_oErro

        TRY
            *-- SIGOPPRR.USUARIO.LostFocus - campo vazio encerra o dialogo
            BINDEVENT(THIS.txt_4c_USUARIO, "LostFocus", THIS, "UsuarioLostFocus")

            *-- SIGOPPRR.SENHA.LostFocus - confere as credenciais
            BINDEVENT(THIS.txt_4c_SENHA, "LostFocus", THIS, "SenhaLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.LigarEventosCampos")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * UsuarioLostFocus - Transcricao de SIGOPPRR.USUARIO.LostFocus:
    *
    *   If IsEmpty(This.Value)
    *       Thisform.Release
    *   EndIf
    *
    * Sair do campo Operador em branco EH o cancelamento do dialogo - este
    * form nao tem botao nenhum (zero commandbutton/commandgroup no dump), e
    * esta eh a unica saida do usuario alem da autenticacao bem-sucedida.
    *
    * `IsEmpty` do Fortyus trata NULL como vazio; aqui o valor vem do proprio
    * TextBox e nunca eh NULL, entao EMPTY() nativo basta (regra #2: em codigo
    * nosso usar EMPTY() direto, o wrapper utils\isempty.prg existe so para o
    * p-code dos VCX).
    *
    * Wrapper fino + <Nome>Exec: o corpo tem RETURN antecipado, e set/clear da
    * flag no proprio corpo deixaria a guarda TRAVADA ligada, matando o
    * handler pelo resto da vida do form (regra #47).
    *
    * PUBLIC: alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE UsuarioLostFocus()
        IF THIS.this_lEmValidacao
            RETURN
        ENDIF

        THIS.this_lEmValidacao = .T.
        THIS.UsuarioLostFocusExec()
        THIS.this_lEmValidacao = .F.
    ENDPROC

    PROTECTED PROCEDURE UsuarioLostFocusExec()
        IF !THIS.ValidarOperador()
            *-- Operador em branco: o legado fecha a tela
            THIS.FecharDialogo()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * SenhaLostFocus - Transcricao de SIGOPPRR.SENHA.LostFocus:
    *
    *   lcUser = PADR(ThisForm.USUARIO.Value,10)
    *   lcPass = PADR(Thisform.SENHA.Value,10)
    *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a
    *              where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' ...]
    *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
    *   If Not Used(...) Or Reccount(...)==0 Or Empty(lcUser)
    *      OR lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
    *       =MessageBox('Usuario ou Senha incorretos',0+48,'')
    *       ThisForm.Senha.Value   = ''
    *       Thisform.Usuario.Value = ''
    *       ThisForm.Usuario.SetFocus
    *   Else
    *       If ProgOper(Val(Thisform.Usuario.Value),Thisform.oModem)
    *           goSistema.Operador = Transform(Val(...),'@L 999')
    *       Endif
    *       Thisform.Release
    *   EndIf
    *
    * Divisao de responsabilidade (PILAR 3): a CONSULTA e a conferencia moram
    * em sigopprrBO.ValidarLogin (Fase 2), que ja transcreve a query, o filtro
    * NOT cativos='N', as quatro condicoes de recusa e a chamada literal a
    * fCriptografar. Aqui fica so o que eh da TELA: espelhar os campos para o
    * BO, decidir entre os dois ramos e executar o efeito visivel de cada um.
    *
    * Ramo de RECUSA - os quatro passos do legado, na mesma ordem:
    *   MsgAviso sem titulo (equivale a MessageBox(...,0+48,'') - icone 48 eh
    *   aviso, e validacao de UI nunca usa MsgErro), os DOIS campos limpos e o
    *   foco de volta no Operador. A mensagem eh a do BO, que por construcao
    *   devolve o mesmo texto do legado nas quatro condicoes, sem revelar qual
    *   delas falhou.
    *
    * Ramo de ACEITE - publica o operador e fecha. `ProgOper` (programacao do
    * operador no dispositivo) nao veio no acervo e `ThisForm.oModem` nao
    * existe nem no SCX legado nem aqui; o BO.DefinirOperadorLogado grava
    * go_4c_Sistema.Operador assim mesmo, com o MESMO Transform(...,'@L 999'),
    * porque eh desse efeito que o resto do sistema depende.
    *
    * As properties de retorno (this_lAutenticado / this_cOperador) sao
    * gravadas ANTES de fechar: com Hide() o Destroy so roda quando o chamador
    * liberar o objeto, entao todo efeito que o chamador le na sequencia tem
    * de acontecer AQUI, no funil, e nao no Destroy.
    *
    * PUBLIC: alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE SenhaLostFocus()
        IF THIS.this_lEmValidacao
            RETURN
        ENDIF

        THIS.this_lEmValidacao = .T.
        THIS.SenhaLostFocusExec()
        THIS.this_lEmValidacao = .F.
    ENDPROC

    PROTECTED PROCEDURE SenhaLostFocusExec()
        LOCAL loc_lOk, loc_cMensagem, loc_oErro

        TRY
            loc_lOk = THIS.ValidarCredenciais()

            IF loc_lOk
                *-- goSistema.Operador = Transform(Val(Usuario.Value),'@L 999')
                THIS.this_oBusinessObject.DefinirOperadorLogado()

                THIS.this_lAutenticado = .T.

                *-- FONTE UNICA: o mesmo this_cUsuarios de que
                *-- DefinirOperadorLogado derivou go_4c_Sistema.Operador, com o
                *-- mesmo Transform(...,'@L 999') do legado. Recalcular a
                *-- partir do TextBox daria dois caminhos para o MESMO valor -
                *-- e um deles ficaria livre para divergir do que foi publicado
                *-- (o BO guarda o valor ja normalizado por PADR(...,10)).
                THIS.this_cOperador    = TRANSFORM(VAL(THIS.this_oBusinessObject.this_cUsuarios), "@L 999")

                *-- Thisform.Release do legado
                THIS.FecharDialogo()
            ELSE
                loc_cMensagem = THIS.this_oBusinessObject.this_cMensagemErro

                IF EMPTY(loc_cMensagem)
                    loc_cMensagem = "Usu" + CHR(225) + "rio ou Senha incorretos"
                ENDIF

                THIS.this_lAutenticado = .F.
                THIS.this_cOperador    = ""

                *-- MessageBox('Usuario ou Senha incorretos', 0+48, '')
                MsgAviso(loc_cMensagem, "")

                *-- ThisForm.Senha.Value = '' / Thisform.Usuario.Value = ''
                THIS.LimparCampos()

                *-- ThisForm.Usuario.SetFocus
                IF THIS.Visible AND THIS.txt_4c_USUARIO.Visible AND THIS.txt_4c_USUARIO.Enabled
                    THIS.txt_4c_USUARIO.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lAutenticado = .F.
            THIS.this_cOperador    = ""
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.SenhaLostFocus")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarOperador - Regra do campo Operador (SIGOPPRR.USUARIO.LostFocus)
    *
    * Devolve .T. quando o campo tem conteudo e .F. quando esta em branco - o
    * chamador decide o que fazer com isso (o LostFocus fecha a tela, como o
    * legado). NAO exibe mensagem: o legado tambem nao exibe nenhuma neste
    * caminho, apenas fecha.
    *
    * TRANSFORM antes do ALLTRIM: com InputMask = "999" o TextBox pode
    * entregar NUMERICO, e ALLTRIM sobre numerico dispara erro 11.
    *
    * PUBLIC: chamado pelos handlers e disponivel para o fluxo das fases
    * seguintes.
    *==========================================================================
    PROCEDURE ValidarOperador()
        LOCAL loc_cOperador

        loc_cOperador = ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value))

        RETURN !EMPTY(loc_cOperador)
    ENDPROC

    *==========================================================================
    * ValidarCredenciais - Conferencia completa de Operador + Senha
    *
    * Espelha os campos para o BO (FormParaBO) ANTES de validar: o legado le
    * ThisForm.USUARIO.Value / ThisForm.SENHA.Value, isto eh, o TEXTBOX eh a
    * fonte unica. Sem esse espelho, trocar o conteudo do campo e sair dele
    * validaria as credenciais ANTERIORES, guardadas no BO.
    *
    * Ordem: ValidarDados() (conferencia local, sem ida ao banco - o legado
    * trata operador vazio como recusa, via Empty(lcUser) dentro do If) e so
    * entao ValidarLogin(), que faz a consulta a SigCdUsu.
    *
    * Devolve .T./.F. e deixa o texto da recusa em
    * this_oBusinessObject.this_cMensagemErro - quem exibe eh o chamador,
    * porque eh ele que conhece o momento certo (o legado so avisa no
    * LostFocus da Senha).
    *
    * PUBLIC: chamado pelo handler e pelo fluxo das fases seguintes.
    *==========================================================================
    PROCEDURE ValidarCredenciais()
        LOCAL loc_lValido

        loc_lValido = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.ValidarDados()
                loc_lValido = THIS.this_oBusinessObject.ValidarLogin( ;
                    ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value)), ;
                    ALLTRIM(TRANSFORM(THIS.txt_4c_SENHA.Value)))
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * FormParaBO - Leva o conteudo dos dois campos da tela para o BO
    *
    * O PADR(...,10) do legado NAO eh aplicado aqui: ValidarLogin ja o faz, e
    * duplicar o padding mudaria quem casa com a chave char(10).
    *
    * TRANSFORM antes do ALLTRIM pelo mesmo motivo de ValidarOperador (o
    * TextBox com InputMask numerico pode entregar Numerico).
    *
    * PROTECTED - e nao por escolha: FormBase.prg:285 declara FormParaBO como
    * PROTECTED, e pela regra #51 o PROTECTED da base PREVALECE mesmo que a
    * subclasse omita o modificador (medido aqui com
    * PEMSTATUS(form, "FormParaBO", 2) = .T.). Esta chamado so de DENTRO da
    * classe (ValidarCredenciais); de fora o acesso estoura
    * "Property FORMPARABO is not found" - quem precisar do espelho a partir
    * de outro objeto deve passar por ValidarCredenciais().
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cUsuarios = ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value))
        THIS.this_oBusinessObject.this_cSenhas   = ALLTRIM(TRANSFORM(THIS.txt_4c_SENHA.Value))

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Ramo de recusa do legado:
    *   ThisForm.Senha.Value = '' / Thisform.Usuario.Value = ''
    *
    * Limpa tambem o estado do BO, para que a tentativa seguinte nao herde o
    * cargo/setor do operador da tentativa anterior (sigopprrBO.LimparDados).
    *
    * PROTECTED pelo mesmo motivo de FormParaBO: FormBase.prg:276 ja declara
    * LimparCampos como PROTECTED e a regra #51 faz isso valer aqui. Chamado
    * so de dentro (SenhaLostFocusExec).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_SENHA.Value   = ""
        THIS.txt_4c_USUARIO.Value = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparDados()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FecharDialogo - Funil UNICO de fechamento da tela
    *
    * Hide() e NAO Release(), apesar de o legado escrever `Thisform.Release`.
    * Medido no VFP9: Release() destroi o objeto mesmo com o chamador
    * segurando a referencia (VARTYPE passa a "X"), e a leitura seguinte
    * estoura "is not an object". Este dialogo existe justamente para DEVOLVER
    * um resultado - o cabecalho deste arquivo documenta
    * `loForm.this_lAutenticado` / `loForm.this_cOperador` lidos DEPOIS do
    * Show() -, entao transcrever o Release ao pe da letra tornaria esse
    * resultado inalcancavel.
    *
    * Para o usuario nao muda nada (Hide() em form modal tambem devolve o
    * Show() e a tela some), e eh o desenho que o projeto ja adota em
    * FormBuscaAuxiliar: o CHAMADOR chama Release() depois de ler.
    *
    * O legado nao tem `PROCEDURE Unload / Return`, nem o chamador abre com
    * `DO FORM ... TO` - por isso nao se inventa Unload aqui.
    *==========================================================================
    PROCEDURE FecharDialogo()
        IF THIS.Visible
            THIS.Hide()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
    * Percorre o container informado (ou o proprio form) tornando visivel o que
    * tem a propriedade, e recursa nos containers filhos.
    *
    * PEMSTATUS antes de tocar Visible: nem toda classe base tem a propriedade
    * (regra #33 - atribuir o que a classe nao tem derruba o Init e a tela nao
    * abre).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_oAlvo, loc_nI, loc_oControle

        loc_oAlvo = IIF(VARTYPE(par_oContainer) = "O", par_oContainer, THIS)

        IF VARTYPE(loc_oAlvo) = "O" AND PEMSTATUS(loc_oAlvo, "ControlCount", 5)
            FOR loc_nI = 1 TO loc_oAlvo.ControlCount
                loc_oControle = loc_oAlvo.Controls(loc_nI)

                IF VARTYPE(loc_oControle) = "O"
                    IF PEMSTATUS(loc_oControle, "Visible", 5)
                        loc_oControle.Visible = .T.
                    ENDIF

                    IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oControle)
                    ENDIF
                ENDIF
            ENDFOR
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - Solta o BO e devolve o controle a FormBase.Destroy(), que
    * reconstroi os popups do menu principal (Pattern #145: sem o DODEFAULT na
    * ULTIMA linha o menu do sistema encolhe depois que o dialogo fecha).
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopprrBO.prg):
*==============================================================================
* sigopprrBO.prg - Business Object para Formsigopprr (Codigo do Operador)
* Herda de BusinessBase
*
* Form OPERACIONAL (dialogo de login/reautenticacao do operador). O legado
* (SIGOPPRR) nao faz CRUD - o Init() da tela conecta ao banco e chama
* fConfigGeral()/fLerFiscal(), e o LostFocus de Senha valida USUARIO + SENHA
* contra SigCdUsu (tabela de usuarios, nao editada por este dialogo):
*     lcUser = Padr(ThisForm.USUARIO.Value,10)
*     lcPass = Padr(ThisForm.SENHA.Value,10)
*     Select a.usuarios, a.senhas From SigCdUsu a
*         Where Not a.cAtivos='N' And a.usuarios = ?lcUser Order By 1
*     If Not Used('CrSigCdUsu') Or Reccount=0 Or Empty(lcUser) ;
*         Or lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
*         *-- usuario/senha incorretos
*
* Como a tela so LE SigCdUsu para validar credenciais (nunca insere, altera
* ou exclui), o comportamento padrao herdado de BusinessBase para
* Inserir()/Atualizar()/ExecutarExclusao() ja eh o correto. Sobrescrever esses
* tres metodos aqui exigiria INVENTAR um INSERT/UPDATE em SigCdUsu que o
* legado nunca faz - o oposto da regra #22 do CLAUDE.md (a lista de colunas
* vem do schema, e a operacao vem do legado). ObterChavePrimaria() continua
* sobrescrito para que qualquer caminho herdado de auditoria reporte a chave
* certa (usuarios).
*
* Tabela ...: SigCdUsu (consulta de validacao)
* Chave .....: usuarios (char 10) - PK sigcdusu_usuarios
*
*------------------------------------------------------------------------------
* DEPENDENCIAS DO LEGADO FORTYUS QUE NAO VIERAM NO ACERVO (regra #27)
*
* fCriptografar(<senha gravada>) - devolve a senha em claro, comparavel com o
*   que o operador digitou. A funcao vive em sig.prg/SIGFUNCS.PRG, que nao
*   veio no acervo, e o algoritmo nao esta legivel em fonte nenhum. A chamada
*   eh transcrita LITERALMENTE em ValidarLogin(): se a funcao faltar, o VFP
*   estoura dentro do TRY e o CATCH devolve a mensagem pelo this_cMensagemErro
*   em vez de fechar a tela. NUNCA criar utils\fcriptografar.prg com algoritmo
*   inventado: hash inventado autentica quem nao deveria entrar, e em silencio.
*   Mesmo tratamento ja adotado em SigOpAlCBO, SigOpLimBO e SigOpCtsBO.
*
* ProgOper(<operador>, <modem>) - programa o codigo do operador no dispositivo
*   (modem/ECF) antes de publicar goSistema.Operador. Tambem nao veio no
*   acervo, e o objeto que o legado passa como 2o argumento (ThisForm.oModem)
*   nao existe nem no SCX legado nem no form migrado, entao a chamada nao eh
*   sequer expressavel aqui. DIVERGENCIA CONSCIENTE: DefinirOperadorLogado()
*   publica o operador SEM o passo de dispositivo - era o unico efeito do qual
*   o resto do sistema depende; sem ele o dialogo inteiro nao teria proposito.
*==============================================================================
DEFINE CLASS sigopprrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - credenciais digitadas pelo operador
    * Tipos conferidos em docs/schema.sql (tabela sigcdusu):
    *   usuarios char(10) NOT NULL (PK) | senhas char(10) NOT NULL
    *--------------------------------------------------------------------------
    this_cUsuarios = ""    && SigCdUsu.usuarios - codigo do operador digitado (char 10)
    this_cSenhas   = ""    && SigCdUsu.senhas   - senha digitada em texto claro (char 10)

    *--------------------------------------------------------------------------
    * Propriedades - estado da validacao (NAO existem em SigCdUsu)
    *--------------------------------------------------------------------------
    this_lLoginValido = .F.    && .T. apos ValidarLogin() encontrar usuario/senha corretos

    *--------------------------------------------------------------------------
    * Propriedades - demais colunas de SigCdUsu, preenchidas por
    * CarregarDoCursor() com a linha do operador autenticado. Tipos conferidos
    * em docs/schema.sql (lido com Get-Content -Raw - o arquivo eh UTF-16,
    * regra #14):
    *   supervis char(1)   | ccargs char(10)  | limdescs char(1)
    *   ncomps char(30)    | deptos char(10)  | libpess char(1)
    *   libprods char(1)   | setores char(10) | cativos char(1)
    *   tdtsenhas datetime NULL                | iclis char(10)
    *   obrigsenhas numeric(1,0)               | libqtmins char(1)
    *
    * As duas colunas text de sigcdusu (mbiodigs = digital biometrica,
    * figjpgsuser = foto do usuario) ficam DE FORA de proposito: o legado deste
    * dialogo nunca as le, elas sao blobs, e o SELECT de ValidarLogin() lista
    * as colunas explicitamente - logo nao chegam ao cursor e nao ha o que
    * mapear. Tela que precisar da biometria/foto deve consulta-las no seu
    * proprio BO.
    *--------------------------------------------------------------------------
    this_cSupervis    = ""    && SigCdUsu.supervis  - indicador de supervisor (char 1)
    this_cCcargs      = ""    && SigCdUsu.ccargs    - cargo do operador (char 10)
    this_cLimdescs    = ""    && SigCdUsu.limdescs  - limite de desconto (char 1)
    this_cNcomps      = ""    && SigCdUsu.ncomps    - nome completo do operador (char 30)
    this_cDeptos      = ""    && SigCdUsu.deptos    - departamento (char 10)
    this_cLibpess     = ""    && SigCdUsu.libpess   - liberacao de dados pessoais (char 1)
    this_cLibprods    = ""    && SigCdUsu.libprods  - liberacao de produtos (char 1)
    this_cSetores     = ""    && SigCdUsu.setores   - setor do operador (char 10)
    this_cCativos     = ""    && SigCdUsu.cativos   - N = usuario inativo (char 1)
    this_dTdtsenhas   = {}    && SigCdUsu.tdtsenhas - data/hora da ultima troca de senha
    this_cIclis       = ""    && SigCdUsu.iclis     - conta/cliente vinculado (char 10)
    this_nObrigsenhas = 0     && SigCdUsu.obrigsenhas - numeric(1,0), NAO eh logico
    this_cLibqtmins   = ""    && SigCdUsu.libqtmins - liberacao de quantidade minima (char 1)

    *--------------------------------------------------------------------------
    * Cursor de trabalho da consulta de credenciais (equivale ao CrSigCdUsu do
    * legado; nome novo por causa do PILAR 3)
    *--------------------------------------------------------------------------
    this_cCursorUsuario = "cursor_4c_UsuarioLogin"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigCdUsu"
                THIS.this_cCampoChave = "usuarios"

                *-- Estado inicial da validacao de login
                THIS.LimparDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar sigopprrBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia a linha corrente do cursor informado para as
    * propriedades do BO. Chamado por ValidarLogin() e por CarregarPorCodigo()
    * depois do SELECT em SigCdUsu.
    *
    * Metodo PUBLIC (a base tambem eh): o Form pode chamar de fora depois de
    * popular o cursor por conta propria - regra #51.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias   = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- usuarios char(10) - chave primaria
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuarios = TratarNulo(usuarios, "")
                    ENDIF

                    *-- senhas char(10) vem no cursor para a conferencia de
                    *-- ValidarLogin, mas NAO eh copiada para propriedade
                    *-- nenhuma: a senha gravada nao fica viva na memoria do BO
                    *-- depois do login.

                    *-- supervis char(1)
                    IF TYPE(loc_cAlias + ".supervis") == "C"
                        THIS.this_cSupervis = TratarNulo(supervis, "")
                    ENDIF

                    *-- ccargs char(10)
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCcargs = TratarNulo(ccargs, "")
                    ENDIF

                    *-- limdescs char(1)
                    IF TYPE(loc_cAlias + ".limdescs") == "C"
                        THIS.this_cLimdescs = TratarNulo(limdescs, "")
                    ENDIF

                    *-- ncomps char(30)
                    IF TYPE(loc_cAlias + ".ncomps") == "C"
                        THIS.this_cNcomps = TratarNulo(ncomps, "")
                    ENDIF

                    *-- deptos char(10)
                    IF TYPE(loc_cAlias + ".deptos") == "C"
                        THIS.this_cDeptos = TratarNulo(deptos, "")
                    ENDIF

                    *-- libpess char(1)
                    IF TYPE(loc_cAlias + ".libpess") == "C"
                        THIS.this_cLibpess = TratarNulo(libpess, "")
                    ENDIF

                    *-- libprods char(1)
                    IF TYPE(loc_cAlias + ".libprods") == "C"
                        THIS.this_cLibprods = TratarNulo(libprods, "")
                    ENDIF

                    *-- setores char(10)
                    IF TYPE(loc_cAlias + ".setores") == "C"
                        THIS.this_cSetores = TratarNulo(setores, "")
                    ENDIF

                    *-- cativos char(1) - N marca usuario inativo
                    IF TYPE(loc_cAlias + ".cativos") == "C"
                        THIS.this_cCativos = TratarNulo(cativos, "")
                    ENDIF

                    *-- tdtsenhas datetime NULL - ConverterParaData normaliza
                    *-- DATE/DATETIME/CHAR (regra #16: TTOD so aceita DATETIME)
                    IF INLIST(TYPE(loc_cAlias + ".tdtsenhas"), "T", "D")
                        THIS.this_dTdtsenhas = ConverterParaData(TratarNulo(tdtsenhas, {}))
                    ENDIF

                    *-- iclis char(10)
                    IF TYPE(loc_cAlias + ".iclis") == "C"
                        THIS.this_cIclis = TratarNulo(iclis, "")
                    ENDIF

                    *-- obrigsenhas numeric(1,0) - NAO eh logico, nao achatar
                    *-- para .T./.F. (perderia os valores diferentes de 0 e 1)
                    IF TYPE(loc_cAlias + ".obrigsenhas") == "N"
                        THIS.this_nObrigsenhas = NVL(obrigsenhas, 0)
                    ENDIF

                    *-- libqtmins char(1)
                    IF TYPE(loc_cAlias + ".libqtmins") == "C"
                        THIS.this_cLibqtmins = TratarNulo(libqtmins, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados do operador:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Le a linha de SigCdUsu do operador informado e
    * preenche as propriedades, SEM conferir senha. Usado quando a tela so
    * precisa dos dados do operador (cargo/setor/nome) ja autenticado.
    *
    * Mantem o filtro do legado (Not cativos = N): operador inativo nao eh
    * encontrado, igual a consulta do SENHA.LostFocus.
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cUsuarioPad, loc_cCursor, loc_oErro

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""
        loc_cCursor             = THIS.this_cCursorUsuario
        loc_cUsuarioPad         = PADR(THIS.NormalizarTexto(par_cUsuario), 10)

        TRY
            IF EMPTY(loc_cUsuarioPad)
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o informado."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "indispon" + CHR(237) + "vel."
                ELSE
                    THIS.FecharCursorUsuario()

                    loc_cSQL = "SELECT a.usuarios, a.senhas, a.supervis, a.ccargs" + ;
                               ", a.limdescs, a.ncomps, a.deptos, a.libpess" + ;
                               ", a.libprods, a.setores, a.cativos, a.tdtsenhas" + ;
                               ", a.iclis, a.obrigsenhas, a.libqtmins" + ;
                               " FROM SigCdUsu a" + ;
                               " WHERE NOT a.cativos = 'N'" + ;
                               " AND a.usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                               " ORDER BY a.usuarios"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                    IF loc_nResultado <= 0
                        THIS.this_cMensagemErro = "Erro ao consultar o operador:" + CHR(13) + ;
                            CapturarErroSQL()
                    ELSE
                        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                            THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o cadastrado " + ;
                                "ou inativo."
                        ELSE
                            SELECT (loc_cCursor)
                            GO TOP
                            loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                        ENDIF
                    ENDIF

                    THIS.FecharCursorUsuario()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            THIS.FecharCursorUsuario()
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarLogin - Transcricao do SIGOPPRR.SENHA.LostFocus:
    *
    *   lcUser = PADR(ThisForm.USUARIO.Value,10)
    *   lcPass = PADR(Thisform.SENHA.Value,10)
    *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a
    *              where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' order by 1]
    *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
    *   If Not Used('CrSigCdUsu') Or Reccount('CrSigCdUsu')==0 Or Empty(lcUser) ;
    *      OR lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
    *       *-- recusa
    *
    * Fidelidade preservada ponto a ponto:
    *  - PADR SEM ALLTRIM nos dois valores: o campo USUARIO tem InputMask 999
    *    e o legado compara o que esta no controle, com o espacamento que
    *    estiver la. ALLTRIM aqui mudaria quem casa com a chave char(10).
    *  - o filtro continua NOT cativos = N (usuario inativo nao autentica).
    *  - as quatro condicoes de recusa do If sao as mesmas, e todas devolvem a
    *    MESMA mensagem do legado (Usuario ou Senha incorretos), sem revelar
    *    qual delas falhou.
    *
    * Unica extensao: o SELECT lista as demais colunas escalares da linha (o
    * legado pede so usuarios+senhas) para preencher as propriedades de estado
    * declaradas neste BO. O criterio de autenticacao nao muda.
    *==========================================================================
    PROCEDURE ValidarLogin(par_cUsuario, par_cSenha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCursor
        LOCAL loc_cUsuarioPad, loc_cSenhaPad, loc_cSenhaGravada, loc_oErro

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lLoginValido  = .F.
        loc_cCursor             = THIS.this_cCursorUsuario

        *-- PADR sem ALLTRIM, exatamente como o legado
        loc_cUsuarioPad = PADR(THIS.NormalizarTexto(par_cUsuario), 10)
        loc_cSenhaPad   = PADR(THIS.NormalizarTexto(par_cSenha), 10)

        THIS.this_cUsuarios = loc_cUsuarioPad
        THIS.this_cSenhas   = loc_cSenhaPad

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "indispon" + CHR(237) + "vel."
            ELSE
                THIS.FecharCursorUsuario()

                loc_cSQL = "SELECT a.usuarios, a.senhas, a.supervis, a.ccargs" + ;
                           ", a.limdescs, a.ncomps, a.deptos, a.libpess" + ;
                           ", a.libprods, a.setores, a.cativos, a.tdtsenhas" + ;
                           ", a.iclis, a.obrigsenhas, a.libqtmins" + ;
                           " FROM SigCdUsu a" + ;
                           " WHERE NOT a.cativos = 'N'" + ;
                           " AND a.usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                           " ORDER BY a.usuarios"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                IF loc_nResultado <= 0
                    THIS.this_cMensagemErro = "Erro ao consultar o operador:" + CHR(13) + ;
                        CapturarErroSQL()
                ELSE
                    IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0 OR EMPTY(loc_cUsuarioPad)
                        *-- 3 das 4 condicoes do If legado
                        THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
                    ELSE
                        SELECT (loc_cCursor)
                        GO TOP

                        *-- 4a condicao: lcPass <> fCriptografar(CrSigCdUsu.SENHAS).
                        *-- fCriptografar NAO foi portada (ver cabecalho): a
                        *-- chamada eh literal e, faltando a funcao, o VFP
                        *-- estoura aqui dentro e cai no CATCH abaixo - que eh
                        *-- o comportamento desejado (ausencia VISIVEL), nunca
                        *-- um stub devolvendo valor de calculo.
                        loc_cSenhaGravada = fCriptografar(senhas)

                        IF loc_cSenhaPad == PADR(TratarNulo(loc_cSenhaGravada, ""), 10)
                            loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)

                            IF loc_lSucesso
                                THIS.this_lLoginValido = .T.
                            ELSE
                                THIS.this_cMensagemErro = "Erro ao ler os dados do operador " + ;
                                    "autenticado." + CHR(13) + THIS.this_cMensagemErro
                            ENDIF
                        ELSE
                            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
                        ENDIF
                    ENDIF
                ENDIF

                THIS.FecharCursorUsuario()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            THIS.FecharCursorUsuario()
        ENDTRY

        *-- A senha em claro nunca permanece viva no BO depois da conferencia
        THIS.this_cSenhas = ""

        IF !loc_lSucesso
            THIS.this_lLoginValido = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * DefinirOperadorLogado - Publica o operador autenticado em
    * go_4c_Sistema.Operador, no mesmo formato do legado:
    *
    *   If ProgOper(Val(Thisform.Usuario.Value), Thisform.oModem)
    *       goSistema.Operador = Transform(Val(Thisform.Usuario.Value),'@L 999')
    *   Endif
    *
    * ProgOper (programacao do operador no dispositivo) nao veio no acervo e o
    * objeto ThisForm.oModem nao existe nem no SCX legado nem no form migrado -
    * ver o cabecalho deste arquivo. O operador eh publicado assim mesmo: eh o
    * efeito do qual o resto do sistema depende.
    *
    * go_4c_Sistema eh um objeto Empty: ler/gravar property que ele nao tem
    * estoura "Property OPERADOR is not found" (medido no VFP9), e Empty nao
    * tem metodo AddProperty - por isso a criacao vai pela FUNCAO ADDPROPERTY().
    *==========================================================================
    PROCEDURE DefinirOperadorLogado()
        LOCAL loc_lSucesso, loc_cOperador, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF THIS.this_lLoginValido AND !EMPTY(THIS.this_cUsuarios)
                loc_cOperador = TRANSFORM(VAL(THIS.this_cUsuarios), "@L 999")

                IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                    IF PEMSTATUS(go_4c_Sistema, "Operador", 5)
                        go_4c_Sistema.Operador = loc_cOperador
                    ELSE
                        ADDPROPERTY(go_4c_Sistema, "Operador", loc_cOperador)
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Objeto de sistema indispon" + CHR(237) + "vel " + ;
                        "para registrar o operador."
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o autenticado."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Conferencia previa dos campos da tela, antes de gastar
    * uma ida ao banco. O legado trata operador vazio como recusa
    * (Empty(lcUser) entra no If de erro) e o LostFocus de USUARIO fecha o
    * dialogo quando o campo fica em branco.
    *
    * PUBLIC (como na base) - o Form chama de fora. Regra #51.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido             = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            CASE EMPTY(THIS.this_cUsuarios)
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o informado."

            CASE EMPTY(THIS.this_cSenhas)
                THIS.this_cMensagemErro = "Senha n" + CHR(227) + "o informada."

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * LimparDados - Devolve o BO ao estado de "ninguem autenticado". Chamado
    * pelo Init e pelo Form a cada nova tentativa, para que a tentativa
    * seguinte nunca herde o cargo/setor do operador anterior.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cUsuarios    = ""
        THIS.this_cSenhas      = ""
        THIS.this_lLoginValido = .F.

        THIS.this_cSupervis    = ""
        THIS.this_cCcargs      = ""
        THIS.this_cLimdescs    = ""
        THIS.this_cNcomps      = ""
        THIS.this_cDeptos      = ""
        THIS.this_cLibpess     = ""
        THIS.this_cLibprods    = ""
        THIS.this_cSetores     = ""
        THIS.this_cCativos     = ""
        THIS.this_dTdtsenhas   = {}
        THIS.this_cIclis       = ""
        THIS.this_nObrigsenhas = 0
        THIS.this_cLibqtmins   = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * NormalizarTexto - Devolve sempre CARACTERE, qualquer que seja o tipo
    * recebido do controle (TextBox com InputMask numerico pode entregar
    * Numerico, e coluna anulavel chega como .NULL.). Existe para que o PADR de
    * ValidarLogin/CarregarPorCodigo nunca receba tipo errado - PADR com
    * numerico dispara "Function argument value, type, or count is invalid".
    *==========================================================================
    PROTECTED PROCEDURE NormalizarTexto(par_uValor)
        LOCAL loc_cTexto

        DO CASE
            CASE VARTYPE(par_uValor) = "C"
                loc_cTexto = par_uValor

            CASE ISNULL(par_uValor)
                loc_cTexto = ""

            CASE VARTYPE(par_uValor) = "N"
                loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))

            OTHERWISE
                loc_cTexto = ""
        ENDCASE

        RETURN loc_cTexto
    ENDPROC

    *==========================================================================
    * FecharCursorUsuario - Fecha o cursor de trabalho da consulta de
    * credenciais. O guard pelo BUFFERING antes do TABLEREVERT eh a regra #52:
    * cursor nascido com Buffering = 1 faz TABLEREVERT estourar erro 1586, e
    * USE IN fecha o alias de qualquer modo.
    *==========================================================================
    PROTECTED PROCEDURE FecharCursorUsuario()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorUsuario

        IF USED(loc_cCursor)
            IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                TABLEREVERT(.T., loc_cCursor)
            ENDIF
            USE IN (loc_cCursor)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave de SigCdUsu (usuarios char 10). Sobrescrito
    * para que o caminho herdado de auditoria do BusinessBase reporte a chave
    * correta. PROTECTED como na base: de fora ninguem chama (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Garante que o cursor de trabalho nao fique aberto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.FecharCursorUsuario()
        DODEFAULT()
    ENDPROC

ENDDEFINE


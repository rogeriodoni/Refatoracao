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
[2026-11-08 02:29:15] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-08 02:29:15] [INFO] Config FPW: (nao fornecido)
[2026-11-08 02:29:15] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 02:29:15] [INFO] Timeout: 300 segundos
[2026-11-08 02:29:16] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_khlukctx.prg
[2026-11-08 02:29:16] [INFO] Conteudo do wrapper:
[2026-11-08 02:29:16] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpJob', 'C:\4c\tasks\task755', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpJob', 'C:\4c\tasks\task755', 'OPERACIONAL'
QUIT

[2026-11-08 02:29:16] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_khlukctx.prg
[2026-11-08 02:29:17] [INFO] VFP output esperado em: C:\4c\tasks\task755\vfp_output.txt
[2026-11-08 02:29:17] [INFO] Executando Visual FoxPro 9...
[2026-11-08 02:29:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_khlukctx.prg
[2026-11-08 02:29:18] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_khlukctx.prg
[2026-11-08 02:29:18] [INFO] Timeout configurado: 300 segundos
[2026-11-08 02:29:19] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-08 02:29:20] [INFO] VFP9 finalizado em 2.2599693 segundos
[2026-11-08 02:29:20] [INFO] Exit Code: 
[2026-11-08 02:29:20] [INFO] 
[2026-11-08 02:29:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-08 02:29:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_khlukctx.prg
[2026-11-08 02:29:21] [INFO] 
[2026-11-08 02:29:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-08 02:29:21] [INFO] * Auto-generated wrapper for parameters
[2026-11-08 02:29:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 02:29:22] [INFO] * Parameters: 'FormSigOpJob', 'C:\4c\tasks\task755', 'OPERACIONAL'
[2026-11-08 02:29:22] [INFO] 
[2026-11-08 02:29:22] [INFO] * Anti-dialog protections for unattended execution
[2026-11-08 02:29:23] [INFO] SET SAFETY OFF
[2026-11-08 02:29:23] [INFO] SET RESOURCE OFF
[2026-11-08 02:29:23] [INFO] SET TALK OFF
[2026-11-08 02:29:23] [INFO] SET NOTIFY OFF
[2026-11-08 02:29:24] [INFO] SYS(2335, 0)
[2026-11-08 02:29:24] [INFO] 
[2026-11-08 02:29:24] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpJob', 'C:\4c\tasks\task755', 'OPERACIONAL'
[2026-11-08 02:29:24] [INFO] QUIT
[2026-11-08 02:29:24] [INFO] 
[2026-11-08 02:29:25] [INFO] === Fim do Wrapper.prg ===
[2026-11-08 02:29:25] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpJob",
  "timestamp": "20261108022919",
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
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "6/6 paginas navegadas com sucesso"
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPCONTA) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg):
*==============================================================================
* FormSigOpJob.prg - Complementos de Job (Briefing / Complemento de Movimento)
* Origem: SIGOPJOB.SCX (Framework legado Fortyus)
* Herda de: FormBase
* Tipo: OPERACIONAL (form FILHO do cabecalho de movimentacao de Job -
*       SIGMVCAB/SigMvCab. Nao segue o padrao Page1=Lista/Page2=Dados do
*       CRUD: o legado abre direto num PageFrame de 6 abas nativas
*       (Tabs=.T.) sobre um registro UNICO de SigMvJbC, sem grid de lista.
*       O Click de "Retornar" reabilita o form pai (ThisForm.ParentForm) -
*       nao ha container de cabecalho cinza (cntSombra) no SCX legado,
*       apenas os campos de identificacao do Job direto na raiz do form).
*
* Criado em: Fase 3 - Form: Estrutura Base
*==============================================================================

DEFINE CLASS FormSigOpJob AS FormBase

    DataSession  = 2
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 1
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .T.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    Caption      = "Complementos"
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Equivalente ao "LParameters pFrm, pCta" do Init legado. O form pai
    *-- (cabecalho do Job) eh desabilitado pelo chamador antes de abrir este
    *-- form filho, e reabilitado em Destroy() ao fechar (CmdRetornarClick
    *-- chama THIS.Release(), que dispara Destroy() na cadeia de heranca).
    this_oFormPai = .NULL.
    this_cContas  = ""

    *-- Equivalente ao "pcEscolha" do legado (herdado do form pai no Init -
    *-- ".pcEscolha = .ParentForm.pcEscolha"). Controla a edicao da grade
    *-- "Fontes Pagadoras" (Page5) e a visibilidade dos botoes Inserir/
    *-- Excluir dela. Sem form pai (abertura standalone/teste), assume
    *-- INCLUIR.
    this_cModoAtual = "INCLUIR"

    *-- Partes da chave posicional EmpDopNums (Emps(3)+Dopes(20)+Str(Numes,6))
    *-- do registro de SigMvJbC sendo editado - equivalentes a TprMvCab.Emps/
    *-- Dopes/Jobs do cursor global do form pai legado. Preenchidas pelo
    *-- chamador antes do Show() (CREATEOBJECT + atribuicao, ou via Init).
    this_cEmps  = ""
    this_cDopes = ""
    this_nNumes = 0

    *-- Guarda de reentrancia do lookup de contas da Page3 (regra #37/#47):
    *-- o picker (FormBuscaAuxiliar) eh MODAL e tira o foco do TextBox de
    *-- codigo, o que pode redisparar o proprio LostFocus antes do primeiro
    *-- Show() terminar.
    this_lEmLookupConta = .F.

    *-- Guarda de "valor nao mudou" (regra #47 - complementar a reentrancia
    *-- acima): LostFocus dispara SEMPRE que o foco sai do campo, mas o
    *-- Valid do legado (get_01_0NN/get_01_0NNa) so dispara quando o valor
    *-- MUDA. Sem isto, tabular pelas 14 linhas de equipe sem digitar nada
    *-- reabriria o lookup (ou repetiria o SQLEXEC do match exato) a cada
    *-- saida de campo. Uma property por LINHA (nao por campo): o par
    *-- codigo+nome da mesma linha compartilha o guard, igual ao padrao
    *-- de FormSigOpIpE.ValidarOcorrenciaEtiqueta (codigo+descricao
    *-- combinados com "|").
    this_cUltimoValidarConta024Validado = ""
    this_cUltimoValidarConta025Validado = ""
    this_cUltimoValidarConta026Validado = ""
    this_cUltimoValidarConta027Validado = ""
    this_cUltimoValidarConta028Validado = ""
    this_cUltimoValidarConta029Validado = ""
    this_cUltimoValidarConta030Validado = ""
    this_cUltimoValidarConta031Validado = ""
    this_cUltimoValidarConta032Validado = ""
    this_cUltimoValidarConta033Validado = ""
    this_cUltimoValidarConta034Validado = ""
    this_cUltimoValidarConta035Validado = ""
    this_cUltimoValidarConta036Validado = ""
    this_cUltimoValidarConta037Validado = ""

    *==========================================================================
    * Init - Recebe o form pai e a chave do Job sendo complementado.
    * Todos os parametros sao opcionais para permitir abertura standalone
    * (menu/teste automatizado) sem um form pai real.
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cEmps, par_cDopes, par_nNumes, par_cContas)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
                THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
            ENDIF
        ENDIF
        IF VARTYPE(par_cEmps) = "C"
            THIS.this_cEmps = par_cEmps
        ENDIF
        IF VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = par_cDopes
        ENDIF
        IF VARTYPE(par_nNumes) = "N"
            THIS.this_nNumes = par_nNumes
        ENDIF
        IF VARTYPE(par_cContas) = "C"
            THIS.this_cContas = par_cContas
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o SigOpJobBO e cria a estrutura visual base
    * (PageFrame de 6 abas + botao de retorno). Carga de dados (CarregarDo-
    * Cursor/Buscar), campos de identificacao do Job e os controles de cada
    * aba ficam para as Fases 5-6 (TextBoxes de dados).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpJobBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                IF !EMPTY(ALLTRIM(THIS.this_cDopes))
                    THIS.Caption = "Complementos : " + ALLTRIM(PROPER(THIS.this_cDopes))
                ENDIF

                THIS.this_oBusinessObject.this_cEmpDopNums = ;
                    THIS.this_oBusinessObject.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

                *-- Define se o BO vai Inserir (registro novo) ou Atualizar
                *-- (complemento ja gravado) - precisa vir ANTES de CmdRetornarClick
                *-- chamar Salvar(), que exige this_lEmEdicao = .T. (regra do
                *-- BusinessBase: Salvar() sem NovoRegistro/EditarRegistro falha).
                THIS.CarregarOuIniciarRegistro()

                *-- Parametrizacao da OPERACAO (SigOpCdI) e divisao de notas
                *-- da EMPRESA (SigCdEmp). No legado as duas vem prontas na
                *-- data session do form pai (crSigOpCdI) ou de um
                *-- CursorQuery do proprio Init (LocalEmps); aqui o BO
                *-- carrega. Precisam vir ANTES da configuracao visual porque
                *-- alimentam os captions (AplicarTitulosPersonalizados), a
                *-- marcacao de obrigatoriedade (ChecarCamposObrigatorios) e
                *-- a visibilidade dos blocos de equipe
                *-- (AplicarVisibilidadeEquipes).
                THIS.this_oBusinessObject.CarregarConfiguracaoJob(THIS.this_cDopes)
                THIS.this_oBusinessObject.CarregarDivisaoNotas(THIS.this_cEmps)

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalhoJob()
                THIS.ConfigurarAbaBriefing()
                THIS.ConfigurarAbaDesafio()
                THIS.ConfigurarAbaEquipes()
                THIS.ConfigurarAbaMateriais()
                THIS.ConfigurarAbaFinanceiroCampos()
                THIS.ConfigurarAbaApresentacao()
                THIS.ConfigurarBotaoRetornar()
                THIS.ConfigurarGridFontes()

                *-- Depois de TODOS os controles existirem: o metodo varre a
                *-- arvore e nao enxerga o que ainda nao foi criado.
                THIS.VincularChecagemObrigatorios(THIS)

                THIS.TornarControlesVisiveis(THIS)

                *-- DEPOIS de TornarControlesVisiveis, que forca Visible = .T.
                *-- em tudo: aplicado antes, a regra de visibilidade dos
                *-- blocos de equipe seria apagada.
                THIS.AplicarTitulosPersonalizados()

                THIS.CarregarLista()
                THIS.CarregarCabecalhoJob()
                THIS.BOParaForm()

                THIS.AplicarVisibilidadeEquipes()

                *-- Por ultimo: o legado chama ChecaObrigs no Init com o
                *-- cursor ja preenchido, e aqui o equivalente e' depois de
                *-- BOParaForm ter levado os valores para os controles.
                THIS.ChecarCamposObrigatorios()

                *-- Ultima linha do Init legado: ".pgfPagina.ActivePage =
                *-- .pgfPagina.pgPagina1.PageOrder". Hoje e' equivalente ao
                *-- default do VFP (Page1.PageOrder = 1), mas fica explicito
                *-- porque ActivePage e' o PageOrder e NAO a ordem de
                *-- declaracao (regra #31) - neste PageFrame a Page6 tem
                *-- PageOrder 3, entao presumir a ordem de declaracao aqui
                *-- abriria a aba errada se alguem mexer nos PageOrder.
                THIS.pgf_4c_Job.ActivePage = THIS.pgf_4c_Job.Page1.PageOrder

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigOpJobBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarOuIniciarRegistro - Decide se o complemento do Job (SigMvJbC)
    * ja existe ou e novo, e prepara o BusinessBase de acordo:
    *
    *   - EXISTE  -> CarregarDoCursor() preenche as propriedades this_* a
    *                partir do registro gravado, depois EditarRegistro()
    *                (this_lEmEdicao = .T., this_lNovoRegistro = .F.).
    *   - NAO EXISTE -> NovoRegistro() (this_lEmEdicao = .T.,
    *                   this_lNovoRegistro = .T.) - os valores ficam nos
    *                   defaults declarados no BO (campos em branco).
    *
    * O legado nao precisa dessa distincao porque o TextBox ja esta ligado
    * por ControlSource ao cursor BUFFERED do form pai (sempre existe uma
    * linha, em branco ou nao, e o TableUpdate acontece quando o movimento
    * inteiro e salvo). Nesta arquitetura o BO grava com SQLEXEC explicito
    * em CmdRetornarClick, que exige this_lEmEdicao = .T. (BusinessBase.
    * Salvar() recusa gravar fora de edicao) e decide Inserir/Atualizar pelo
    * this_lNovoRegistro definido aqui.
    *
    * Sem conexao (modo de teste/validacao de UI) cai direto em
    * NovoRegistro() - ConexaoAtiva() ja devolve .F. nesse caso.
    *==========================================================================
    PROTECTED PROCEDURE CarregarOuIniciarRegistro()
        LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_oErro
        loc_cAliasTmp = "cursor_4c_JobTmp"

        TRY
            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF

            loc_nResultado = -1
            IF THIS.this_oBusinessObject.ConexaoAtiva()
                loc_cSQL = "SELECT * FROM SigMvJbC WHERE empdopnums = " + ;
                    EscaparSQL(THIS.this_oBusinessObject.this_cEmpDopNums)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)
            ENDIF

            IF loc_nResultado >= 0 AND USED(loc_cAliasTmp) AND RECCOUNT(loc_cAliasTmp) > 0
                SELECT (loc_cAliasTmp)
                GO TOP
                THIS.this_oBusinessObject.CarregarDoCursor(loc_cAliasTmp)
                THIS.this_oBusinessObject.EditarRegistro()
            ELSE
                THIS.this_oBusinessObject.NovoRegistro()
            ENDIF

            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarOuIniciarRegistro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Job com as 6 abas do legado
    * (pgfPagina.pgPagina1..pgPagina6). Tabs=.T. porque o SCX nao tem nenhum
    * CommandGroup/OptionGroup navegando entre paginas (so cmdRetornar, que
    * fecha o form) - a navegacao eh pelas abas nativas mesmo.
    *
    * Posicoes EXATAS do dump do SCX legado (tasks\task755\layout.json):
    * pgfPagina Top=130, Left=-1, Width=1005, Height=473.
    *
    * Captions, fonte, cores e Picture de cada Page vem do dump do SCX
    * (bloco "Page<N>.*" de SIGOPJOB.pgfPagina) - transcritos LITERALMENTE.
    *
    * ATENCAO (regra #31): o PageOrder do legado NAO eh a ordem de declaracao.
    * pgPagina6 ("Apresentacao") tem PageOrder = 3, e por isso pgPagina3/4/5
    * aparecem em 4/5/6. Medido no VFP9 (automation\medir_pageorder_755.prg):
    * UMA atribuicao .Page6.PageOrder = 3 empurra Page3/4/5 para 4/5/6 e
    * reproduz exatamente a ordem do legado; o acesso por NOME (.Page3,
    * .Page6) continua apontando para o mesmo objeto depois disso, entao os
    * metodos Configurar*/Carregar* nao mudam.
    *
    * O PageFrame NAO recebe FontName/FontSize nem as Pages recebem Visible:
    * nenhuma das duas classes tem essas propriedades (medido em
    * automation\propriedades_baseclasses.txt) e a atribuicao abortaria este
    * metodo no meio, deixando o PageFrame sem Caption e invisivel (regra #33).
    * A fonte do legado mora na PAGE, que tem FontBold/FontName/FontSize.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro, loc_cFundo, loc_nI, loc_oPg
        TRY
            loc_cFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.AddObject("pgf_4c_Job", "PageFrame")
            WITH THIS.pgf_4c_Job
                .Top        = 130
                .Left       = -1
                .Width      = 1005
                .Height     = 473
                .PageCount  = 6
                .Tabs       = .T.
                .Visible    = .T.

                *-- Captions EXATOS do dump (Page<N>.Caption)
                .Page1.Caption = "Briefing"
                .Page2.Caption = "Briefing Continua" + CHR(231) + CHR(227) + "o"
                .Page3.Caption = "Informa" + CHR(231) + CHR(245) + "es Gerais"
                .Page4.Caption = "Informa" + CHR(231) + CHR(245) + "es Gerais Continua" + ;
                                 CHR(231) + CHR(227) + "o"
                .Page5.Caption = "Controladoria / Fiscal"
                .Page6.Caption = "Apresenta" + CHR(231) + CHR(227) + "o"

                *-- Ordem das abas do legado: pgPagina6 vem na 3a posicao
                .Page6.PageOrder = 3
            ENDWITH

            *-- Fonte/cores/fundo de cada Page (Page<N>.FontBold/FontName/
            *-- FontSize/BackColor/ForeColor/Picture do dump, iguais nas 6)
            FOR loc_nI = 1 TO THIS.pgf_4c_Job.PageCount
                loc_oPg = EVALUATE("THIS.pgf_4c_Job.Page" + TRANSFORM(loc_nI))
                WITH loc_oPg
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    *-- Sem guard IF FILE(): .Picture inexistente falha em
                    *-- SILENCIO (regra #25) e o guard so esconderia o
                    *-- problema. O arquivo foi conferido no acervo legado.
                    .Picture = loc_cFundo
                ENDWITH
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaBriefing - Page1 ("Briefing") - campos Jb_001/002/017..023
    * (datas) e Jb_003..008/021..023 (texto). Posicoes EXATAS do dump
    * (tasks\task755\layout.json). Nomes conforme tasks\task755\mapeamento.json.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaBriefing()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Job.Page1

            *-- Apresentacao (data) + Orcamento (data)
            loc_oPag.AddObject("lbl_4c_Lbl_01_001", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_001
                .Top = 7
                .Left = 13
                .Width = 90
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Apresenta" + CHR(231) + CHR(227) + "o"
            ENDWITH

            loc_oPag.AddObject("txt_4c__01_001", "TextBox")
            WITH loc_oPag.txt_4c__01_001
                .Top = 22
                .Left = 13
                .Width = 90
                .Height = 23
                .Value = {}
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Lbl_01_002", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_002
                .Top = 7
                .Left = 112
                .Width = 90
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Or" + CHR(231) + "amento"
            ENDWITH

            loc_oPag.AddObject("txt_4c__01_002", "TextBox")
            WITH loc_oPag.txt_4c__01_002
                .Top = 22
                .Left = 112
                .Width = 90
                .Height = 23
                .Value = {}
            ENDWITH

            *-- Periodo do Evento (Inicio) ... ate ... (Fim)
            loc_oPag.AddObject("lbl_4c_Lbl_01_017", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_017
                .Top = 7
                .Left = 211
                .Width = 90
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Per" + CHR(237) + "odo do Evento"
            ENDWITH

            loc_oPag.AddObject("txt_4c__01_017", "TextBox")
            WITH loc_oPag.txt_4c__01_017
                .Top = 22
                .Left = 211
                .Width = 80
                .Height = 23
                .Value = {}
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Lbl_01_017a", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_017a
                .Top = 26
                .Left = 295
                .Width = 20
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "at" + CHR(233)
            ENDWITH

            loc_oPag.AddObject("txt_4c__01_018", "TextBox")
            WITH loc_oPag.txt_4c__01_018
                .Top = 22
                .Left = 318
                .Width = 80
                .Height = 23
                .Value = {}
            ENDWITH

            *-- Montagem ... ate ... Desmontagem
            loc_oPag.AddObject("lbl_4c_Lbl_01_019", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_019
                .Top = 7
                .Left = 417
                .Width = 150
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Montagem            Desmontagem"
            ENDWITH

            loc_oPag.AddObject("txt_4c__01_019", "TextBox")
            WITH loc_oPag.txt_4c__01_019
                .Top = 22
                .Left = 417
                .Width = 80
                .Height = 23
                .Value = {}
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Lbl_01_019a", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_019a
                .Top = 26
                .Left = 501
                .Width = 20
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "at" + CHR(233)
            ENDWITH

            loc_oPag.AddObject("txt_4c__01_020", "TextBox")
            WITH loc_oPag.txt_4c__01_020
                .Top = 22
                .Left = 524
                .Width = 80
                .Height = 23
                .Value = {}
            ENDWITH

            *-- Publico Estimado / Budget Estimado
            loc_oPag.AddObject("lbl_4c_Lbl_01_022", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_022
                .Top = 7
                .Left = 623
                .Width = 150
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "P" + CHR(250) + "blico Estimado"
            ENDWITH

            loc_oPag.AddObject("obj_4c_Get_01_022", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_022
                .Top = 22
                .Left = 623
                .Width = 172
                .Height = 23
                .ScrollBars = 0
                .Value = ""
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Lbl_01_023", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_023
                .Top = 7
                .Left = 815
                .Width = 150
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Budget Estimado"
            ENDWITH

            loc_oPag.AddObject("obj_4c_Get_01_023", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_023
                .Top = 22
                .Left = 815
                .Width = 172
                .Height = 23
                .ScrollBars = 0
                .Value = ""
            ENDWITH

            *-- Local do Evento (memo largo)
            loc_oPag.AddObject("lbl_4c_Lbl_01_021", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_021
                .Top = 48
                .Left = 13
                .Width = 200
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Local do Evento"
            ENDWITH

            loc_oPag.AddObject("obj_4c_Get_01_021", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_021
                .Top = 63
                .Left = 13
                .Width = 974
                .Height = 48
                .ScrollBars = 2
                .Value = ""
            ENDWITH

            *-- Blocos de 4 memos duplos (2 colunas x 4 linhas)
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_003", "lbl_4c_Lbl_01_003", ;
                129, 13, "Sobre o que estamos falando? (o brief do brief - resumo do brief criativo)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_004", "lbl_4c_Lbl_01_004", ;
                129, 505, "Hist" + CHR(243) + "rico (informa" + CHR(231) + CHR(245) + "es da empresa, produto/servi" + CHR(231) + "o - o que e para quem ela vende)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_005", "lbl_4c_Lbl_01_005", ;
                238, 13, "Contexto Mercadol" + CHR(243) + "gico (fatores do mercado, an" + CHR(225) + "lise do setor, infos competitivas)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_006", "lbl_4c_Lbl_01_006", ;
                238, 505, "Cen" + CHR(225) + "rio (como est" + CHR(225) + " a situa" + CHR(231) + CHR(227) + "o da empresa, eventos j" + CHR(225) + " realizados, etc)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_007", "lbl_4c_Lbl_01_007", ;
                347, 13, "Target (quem s" + CHR(227) + "o, grupos et" + CHR(225) + "rios, perfil social e psicogr" + CHR(225) + "fico)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_008", "lbl_4c_Lbl_01_008", ;
                347, 505, "O problema (o que n" + CHR(227) + "o foi resolvido, feedbacks anteriores)")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaBriefing")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AdicionarBlocoMemoBriefing - Helper para o par Label+EditBox (482x90)
    * repetido 4 vezes em 2 colunas na Page1 (Briefing).
    *==========================================================================
    PROTECTED PROCEDURE AdicionarBlocoMemoBriefing(par_oPag, par_cNomeEdit, par_cNomeLbl, par_nTop, par_nLeft, par_cCaption)
        LOCAL loc_oLbl, loc_oEdt

        par_oPag.AddObject(par_cNomeLbl, "Label")
        loc_oLbl = EVALUATE("par_oPag." + par_cNomeLbl)
        WITH loc_oLbl
            .Top = par_nTop - 15
            .Left = par_nLeft
            .Width = 482
            .Height = 15
            .Alignment = 0
            .AutoSize = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName = "Tahoma"
            .FontSize = 8
            .Caption = par_cCaption
        ENDWITH

        par_oPag.AddObject(par_cNomeEdit, "EditBox")
        loc_oEdt = EVALUATE("par_oPag." + par_cNomeEdit)
        WITH loc_oEdt
            .Top = par_nTop
            .Left = par_nLeft
            .Width = 482
            .Height = 90
            .ScrollBars = 2
            .Value = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaDesafio - Page2 ("Desafio / Objetivos") - campos Jb_009..016,
    * todos memos de 482x90 em 2 colunas x 4 linhas (mesmo padrao da Page1).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaDesafio()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Job.Page2

            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_009", "lbl_4c_Lbl_01_009", ;
                23, 13, "Desafio (o que queremos alcan" + CHR(231) + "ar, em " + CHR(250) + "ltima an" + CHR(225) + "lise, para o cliente)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_010", "lbl_4c_Lbl_01_010", ;
                23, 505, "Objetivos (detalhamento dos objetivos)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_011", "lbl_4c_Lbl_01_011", ;
                131, 13, "Tom de voz (como " + CHR(233) + " a linguagem que deve ser passada)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_012", "lbl_4c_Lbl_01_012", ;
                131, 505, "Inspira" + CHR(231) + CHR(245) + "es (o que pode ser trabalhado relacionado ao objetivo e target)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_013", "lbl_4c_Lbl_01_013", ;
                239, 13, "Cliente (expectativas, coment" + CHR(225) + "rios do cliente sobre o job em reuni" + CHR(227) + "o, fone e-mail)")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_014", "lbl_4c_Lbl_01_014", ;
                239, 505, "Sugest" + CHR(245) + "es / obrigatoriedades e/ou restri" + CHR(231) + CHR(245) + "es")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_015", "lbl_4c_Lbl_01_015", ;
                347, 13, "Comunica" + CHR(231) + CHR(227) + "o / pe" + CHR(231) + "as obrigat" + CHR(243) + "rias")
            THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_016", "lbl_4c_Lbl_01_016", ;
                347, 505, "Informa" + CHR(231) + CHR(245) + "es do local do evento (caracter" + CHR(237) + "sticas, restri" + CHR(231) + CHR(245) + "es de montagem, plantas)")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaDesafio")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaEquipes - Page3, cuja aba se chama "Informacoes Gerais" no
    * legado (Page3.Caption do dump; o nome deste metodo descreve o CONTEUDO).
    * Traz os dois blocos de equipe do legado (cntEmp1 = "P&G" e
    * cntEmp2 = "SRCOM"), cada um com 7 linhas de Funcao / Nome / Codigo, mais
    * a faixa "Tipo de Projeto" / "Tipo de Desenvolvimento" abaixo da linha
    * divisoria.
    *
    * Posicoes/propriedades EXATAS do dump (SIGOPJOB.pgfPagina.pgPagina3.*).
    * Nomes conforme tasks\task755\mapeamento.json.
    *
    * Cada linha tem DOIS TextBox, como no legado:
    *   get_01_0NNa (Left=2, Width=355)  - NOME da conta, SEM ControlSource no
    *                                      SCX (preenchido por codigo a partir
    *                                      de SigCdCli.RClis - char(50))
    *   get_01_0NN  (Left=360, Width=80) - CODIGO, ControlSource
    *                                      "crSigMvJbC.Jb_0NN" (char(10))
    * O MaxLength vem da LARGURA DA COLUNA no schema (10 e 50), NUNCA do
    * Width em pixels (regra #19).
    *
    * A ordem de tabulacao do legado entra no NOME antes do CODIGO
    * (get_01_024a TabIndex=3, get_01_024 TabIndex=4) - transcrita.
    *
    * Os lookups (Valid/fwBuscaInt sobre crEquipes nos dois campos de cada
    * linha) sao da fase de lookups; aqui entra a superficie de dados.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaEquipes()
        LOCAL loc_oPag, loc_oCnt, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Job.Page3

            *------------------------------------------------------------------
            * cntEmp1 - "P&G"
            *------------------------------------------------------------------
            loc_oPag.AddObject("cnt_4c_Emp1", "Container")
            WITH loc_oPag.cnt_4c_Emp1
                .Top = 4
                .Left = 23
                .Width = 442
                .Height = 305
                .BackStyle = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH
            loc_oCnt = loc_oPag.cnt_4c_Emp1

            loc_oCnt.AddObject("lbl_4c_Lbl_02_001", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_02_001
                .Top = 2
                .Left = 2
                .Width = 40
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
                .TabIndex = 1
                .Caption = "P&G"
            ENDWITH

            *-- Atendimento
            loc_oCnt.AddObject("lbl_4c_Lbl_01_024", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_024
                .Top = 19
                .Left = 2
                .Width = 80
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 2
                .Caption = "Atendimento"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_024a", "TextBox")
            WITH loc_oCnt.txt_4c__01_024a
                .Top = 34
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 3
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_024", "TextBox")
            WITH loc_oCnt.txt_4c__01_024
                .Top = 34
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 4
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Comercial
            loc_oCnt.AddObject("lbl_4c_Lbl_01_025", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_025
                .Top = 60
                .Left = 2
                .Width = 70
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 5
                .Caption = "Comercial"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_025a", "TextBox")
            WITH loc_oCnt.txt_4c__01_025a
                .Top = 75
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 6
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_025", "TextBox")
            WITH loc_oCnt.txt_4c__01_025
                .Top = 75
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 7
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Gerencia de Projeto
            loc_oCnt.AddObject("lbl_4c_Lbl_01_026", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_026
                .Top = 101
                .Left = 2
                .Width = 120
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 8
                .Caption = "Ger" + CHR(234) + "ncia de Projeto"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_026a", "TextBox")
            WITH loc_oCnt.txt_4c__01_026a
                .Top = 116
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 9
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_026", "TextBox")
            WITH loc_oCnt.txt_4c__01_026
                .Top = 116
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 10
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Criacao
            loc_oCnt.AddObject("lbl_4c_Lbl_01_027", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_027
                .Top = 143
                .Left = 2
                .Width = 60
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 11
                .Caption = "Cria" + CHR(231) + CHR(227) + "o"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_027a", "TextBox")
            WITH loc_oCnt.txt_4c__01_027a
                .Top = 158
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 12
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_027", "TextBox")
            WITH loc_oCnt.txt_4c__01_027
                .Top = 158
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 13
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Arquiteto
            loc_oCnt.AddObject("lbl_4c_Lbl_01_028", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_028
                .Top = 184
                .Left = 2
                .Width = 70
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 14
                .Caption = "Arquiteto"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_028a", "TextBox")
            WITH loc_oCnt.txt_4c__01_028a
                .Top = 199
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 15
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_028", "TextBox")
            WITH loc_oCnt.txt_4c__01_028
                .Top = 199
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 16
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Orcamento
            loc_oCnt.AddObject("lbl_4c_Lbl_01_029", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_029
                .Top = 225
                .Left = 2
                .Width = 70
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 17
                .Caption = "Or" + CHR(231) + "amento"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_029a", "TextBox")
            WITH loc_oCnt.txt_4c__01_029a
                .Top = 240
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 18
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_029", "TextBox")
            WITH loc_oCnt.txt_4c__01_029
                .Top = 240
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 19
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Montagem
            loc_oCnt.AddObject("lbl_4c_Lbl_01_030", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_030
                .Top = 265
                .Left = 2
                .Width = 65
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 20
                .Caption = "Montagem"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_030a", "TextBox")
            WITH loc_oCnt.txt_4c__01_030a
                .Top = 280
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 21
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_030", "TextBox")
            WITH loc_oCnt.txt_4c__01_030
                .Top = 280
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 22
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *------------------------------------------------------------------
            * cntEmp2 - "SRCOM"
            *------------------------------------------------------------------
            loc_oPag.AddObject("cnt_4c_Emp2", "Container")
            WITH loc_oPag.cnt_4c_Emp2
                .Top = 4
                .Left = 533
                .Width = 442
                .Height = 305
                .BackStyle = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH
            loc_oCnt = loc_oPag.cnt_4c_Emp2

            loc_oCnt.AddObject("lbl_4c_Lbl_02_002", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_02_002
                .Top = 2
                .Left = 2
                .Width = 50
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
                .TabIndex = 23
                .Caption = "SRCOM"
            ENDWITH

            *-- Lider de Projeto
            loc_oCnt.AddObject("lbl_4c_Lbl_01_031", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_031
                .Top = 19
                .Left = 2
                .Width = 105
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 24
                .Caption = "L" + CHR(237) + "der de Projeto"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_031a", "TextBox")
            WITH loc_oCnt.txt_4c__01_031a
                .Top = 34
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 25
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_031", "TextBox")
            WITH loc_oCnt.txt_4c__01_031
                .Top = 34
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 26
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Atendimento
            loc_oCnt.AddObject("lbl_4c_Lbl_01_032", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_032
                .Top = 60
                .Left = 2
                .Width = 80
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 27
                .Caption = "Atendimento"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_032a", "TextBox")
            WITH loc_oCnt.txt_4c__01_032a
                .Top = 75
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 28
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_032", "TextBox")
            WITH loc_oCnt.txt_4c__01_032
                .Top = 75
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 29
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Comercial
            loc_oCnt.AddObject("lbl_4c_Lbl_01_033", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_033
                .Top = 101
                .Left = 2
                .Width = 70
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 30
                .Caption = "Comercial"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_033a", "TextBox")
            WITH loc_oCnt.txt_4c__01_033a
                .Top = 116
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 31
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_033", "TextBox")
            WITH loc_oCnt.txt_4c__01_033
                .Top = 116
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 32
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Criacao
            loc_oCnt.AddObject("lbl_4c_Lbl_01_034", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_034
                .Top = 143
                .Left = 2
                .Width = 60
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 33
                .Caption = "Cria" + CHR(231) + CHR(227) + "o"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_034a", "TextBox")
            WITH loc_oCnt.txt_4c__01_034a
                .Top = 158
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 34
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_034", "TextBox")
            WITH loc_oCnt.txt_4c__01_034
                .Top = 158
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 35
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Planejamento
            loc_oCnt.AddObject("lbl_4c_Lbl_01_035", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_035
                .Top = 184
                .Left = 2
                .Width = 85
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 36
                .Caption = "Planejamento"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_035a", "TextBox")
            WITH loc_oCnt.txt_4c__01_035a
                .Top = 199
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 37
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_035", "TextBox")
            WITH loc_oCnt.txt_4c__01_035
                .Top = 199
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 38
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Producao
            loc_oCnt.AddObject("lbl_4c_Lbl_01_036", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_036
                .Top = 225
                .Left = 2
                .Width = 65
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 39
                .Caption = "Produ" + CHR(231) + CHR(227) + "o"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_036a", "TextBox")
            WITH loc_oCnt.txt_4c__01_036a
                .Top = 240
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 40
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_036", "TextBox")
            WITH loc_oCnt.txt_4c__01_036
                .Top = 240
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 41
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *-- Producao Financeira
            loc_oCnt.AddObject("lbl_4c_Lbl_01_037", "Label")
            WITH loc_oCnt.lbl_4c_Lbl_01_037
                .Top = 265
                .Left = 2
                .Width = 125
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 42
                .Caption = "Produ" + CHR(231) + CHR(227) + "o Financeira"
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_037a", "TextBox")
            WITH loc_oCnt.txt_4c__01_037a
                .Top = 280
                .Left = 2
                .Width = 355
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 43
                .MaxLength = 50
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value = ""
            ENDWITH
            loc_oCnt.AddObject("txt_4c__01_037", "TextBox")
            WITH loc_oCnt.txt_4c__01_037
                .Top = 280
                .Left = 360
                .Width = 80
                .Height = 23
                .SpecialEffect = 1
                .TabIndex = 44
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH

            *------------------------------------------------------------------
            * Linha divisoria + faixa de classificacao do Job (Page3, abaixo
            * dos dois containers de equipe)
            *------------------------------------------------------------------
            loc_oPag.AddObject("lin_4c_Line1", "Line")
            WITH loc_oPag.lin_4c_Line1
                .Top = 317
                .Left = 25
                .Width = 950
                .Height = 0
                .BorderWidth = 1
                .BorderColor = RGB(90, 90, 90)
            ENDWITH

            THIS.ConfigurarTiposProjeto(loc_oPag)

            *------------------------------------------------------------------
            * Lookups das 14 contas de equipe. O legado tem DOIS Valid por
            * linha (Locate em crEquipes + fwBuscaInt sem match):
            *   get_01_0NN  -> por IClis (codigo)
            *   get_01_0NNa -> por RClis (nome)
            * No migrado os dois vao no LostFocus do respectivo campo (regra
            * #47 - o handler nao testa tecla, logo nao pode ficar em
            * KeyPress), ligados ao funil THIS.AbrirLookupConta por wrappers
            * finos. O InteractiveChange do campo de codigo reavalia o When
            * do campo de nome da mesma linha.
            *------------------------------------------------------------------
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024, "LostFocus", THIS, "ValidarConta024")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025, "LostFocus", THIS, "ValidarConta025")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026, "LostFocus", THIS, "ValidarConta026")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027, "LostFocus", THIS, "ValidarConta027")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028, "LostFocus", THIS, "ValidarConta028")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029, "LostFocus", THIS, "ValidarConta029")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030, "LostFocus", THIS, "ValidarConta030")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031, "LostFocus", THIS, "ValidarConta031")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032, "LostFocus", THIS, "ValidarConta032")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033, "LostFocus", THIS, "ValidarConta033")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034, "LostFocus", THIS, "ValidarConta034")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035, "LostFocus", THIS, "ValidarConta035")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036, "LostFocus", THIS, "ValidarConta036")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037, "LostFocus", THIS, "ValidarConta037")

            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024a, "LostFocus", THIS, "ValidarNomeConta024")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025a, "LostFocus", THIS, "ValidarNomeConta025")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026a, "LostFocus", THIS, "ValidarNomeConta026")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027a, "LostFocus", THIS, "ValidarNomeConta027")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028a, "LostFocus", THIS, "ValidarNomeConta028")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029a, "LostFocus", THIS, "ValidarNomeConta029")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030a, "LostFocus", THIS, "ValidarNomeConta030")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031a, "LostFocus", THIS, "ValidarNomeConta031")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032a, "LostFocus", THIS, "ValidarNomeConta032")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033a, "LostFocus", THIS, "ValidarNomeConta033")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034a, "LostFocus", THIS, "ValidarNomeConta034")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035a, "LostFocus", THIS, "ValidarNomeConta035")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036a, "LostFocus", THIS, "ValidarNomeConta036")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037a, "LostFocus", THIS, "ValidarNomeConta037")

            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
            BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaEquipes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ObterFiltroContaEquipe - Universo do lookup de conta de equipe.
    *
    * O legado NAO busca em SigCdCli inteiro: o Init monta o cursor crEquipes
    * com
    *     Select a.IClis, a.RClis
    *       From SigCdCli a, SigCdGcr b
    *      Where a.Grupos = b.Codigos And b.Coletors = 8   && Atendimento
    * e TODO Locate/fwBuscaInt das 14 linhas roda sobre esse cursor. O filtro
    * eh REGRA DE NEGOCIO (so contas do grupo "Atendimento" podem ocupar os
    * papeis de equipe) e eh transcrito aqui como condicao do 9o parametro
    * (par_cFiltro) do FormBuscaAuxiliar - que o aplica nos TRES caminhos
    * dele: match exato, LIKE prefixo e fallback show-all.
    *
    * Vai como subconsulta (nao JOIN) porque par_cFiltro eh colado dentro de
    * um WHERE sobre uma tabela unica. Colunas conferidas em docs/schema.sql:
    * SigCdCli.grupos char(10), SigCdGcr.codigos char(10),
    * SigCdGcr.coletors numeric(2,0).
    *==========================================================================
    PROTECTED FUNCTION ObterFiltroContaEquipe()
        RETURN "Grupos IN (SELECT Codigos FROM SigCdGcr WHERE Coletors = 8)"
    ENDFUNC

    *==========================================================================
    * AbrirLookupConta - Nucleo do lookup de conta (equipe) usado pelas 14
    * linhas da Page3, nos DOIS sentidos que o legado tem.
    *
    * Equivale ao Valid de cada get_01_0NN (campo de CODIGO, par_cCampo =
    * "Iclis") e ao Valid de cada get_01_0NNa (campo de NOME, par_cCampo =
    * "Rclis"): o legado faz Locate em crEquipes pelo campo correspondente e,
    * sem match (Eof), abre fwBuscaInt sobre o MESMO campo. Aqui o papel do
    * crEquipes + fwBuscaInt eh feito pelo FormBuscaAuxiliar canonico (regras
    * #36/#37), que ja executa o match EXATO no proprio Init - por isso NAO se
    * duplica a checagem de existencia com um SQLEXEC proprio antes do picker.
    *
    * Os DOIS campos da linha sao escritos em qualquer um dos caminhos, como
    * no legado (get_01_0NN.Value e get_01_0NNa.Value sao atribuidos juntos),
    * e os dois sao limpos quando nada eh escolhido - transcricao do
    * "If (Lastkey() <> 27) ... Else ... = [] / = [] / EndIf". Nao ha MsgAviso
    * em nenhum ramo: o picker eh o proprio feedback (regra #50).
    *
    * Campo VAZIO nao abre picker: o legado abriria (Padr([],10) nunca casa em
    * crEquipes), mas isso faz o dialogo subir a cada Tab por cada um dos 14
    * papeis nao preenchidos. Mantido o guard de vazio, que eh o padrao do
    * projeto para lookup em LostFocus (regras #47/#50) e ja era o
    * comportamento desta tela.
    *
    * PUBLIC (BINDEVENT exige metodo publico - regra #3). Guarda de
    * reentrancia: o picker eh MODAL, tira o foco do TextBox e redisparia o
    * proprio LostFocus. Save/restore (nao set/clear) porque os wrappers de
    * codigo e de nome compartilham este funil e o restore nao pode liberar a
    * flag cedo demais caso um dia se encadeiem (regra #47).
    *==========================================================================
    PROCEDURE AbrirLookupConta(par_oTxtCod, par_oTxtNome, par_cCampo)
        LOCAL loc_cValor, loc_cCampo, loc_oBusca, loc_lEmLookupAnt, loc_oErro

        IF THIS.this_lEmLookupConta
            RETURN
        ENDIF
        IF VARTYPE(par_oTxtCod) != "O" OR VARTYPE(par_oTxtNome) != "O"
            RETURN
        ENDIF

        loc_cCampo = IIF(VARTYPE(par_cCampo) = "C" AND !EMPTY(par_cCampo), ;
                         ALLTRIM(par_cCampo), "Iclis")

        loc_lEmLookupAnt         = THIS.this_lEmLookupConta
        THIS.this_lEmLookupConta = .T.
        TRY
            *-- O valor pesquisado eh o do campo em que o usuario digitou:
            *-- codigo quando o lookup partiu de get_01_0NN, nome quando
            *-- partiu de get_01_0NNa.
            IF UPPER(loc_cCampo) == "RCLIS"
                loc_cValor = ALLTRIM(par_oTxtNome.Value)
            ELSE
                loc_cValor = ALLTRIM(par_oTxtCod.Value)
            ENDIF

            IF EMPTY(loc_cValor)
                *-- Campo de origem vazio: nada a resolver. Limpa so o PAR
                *-- (codigo vazio nao pode ficar com nome preenchido, e nome
                *-- vazio com codigo preenchido eh resolvido pelo lookup de
                *-- codigo), sem abrir dialogo.
                IF UPPER(loc_cCampo) == "RCLIS"
                    IF EMPTY(ALLTRIM(par_oTxtCod.Value))
                        par_oTxtNome.Value = ""
                    ENDIF
                ELSE
                    par_oTxtNome.Value = ""
                ENDIF
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaConta", loc_cCampo, loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Filtros", .F., .T., ;
                    THIS.ObterFiltroContaEquipe())

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        *-- Ordem das colunas igual a do legado: o campo
                        *-- pesquisado vem primeiro em cada um dos dois Valid.
                        IF UPPER(loc_cCampo) == "RCLIS"
                            loc_oBusca.mAddColuna("Rclis", "", "Nome")
                            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        ELSE
                            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("Rclis", "", "Nome")
                        ENDIF
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        par_oTxtCod.Value  = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Iclis, ""))
                        par_oTxtNome.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Rclis, ""))
                    ELSE
                        *-- Legado: ESC / nada escolhido limpa os DOIS campos
                        *-- da linha, nao so a descricao.
                        par_oTxtCod.Value  = ""
                        par_oTxtNome.Value = ""
                    ENDIF

                    IF USED("cursor_4c_BuscaConta")
                        USE IN cursor_4c_BuscaConta
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

            *-- Legado fecha os dois Valid com ".Refresh" nos dois campos.
            par_oTxtCod.Refresh()
            par_oTxtNome.Refresh()

            *-- Reaplica o When de get_01_0NNa, que depende do codigo recem
            *-- resolvido ("Empty(This.Parent.get_01_0NN.Value) And ...").
            THIS.AtualizarEstadoContasEquipe()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupConta")
        ENDTRY
        THIS.this_lEmLookupConta = loc_lEmLookupAnt
    ENDPROC

    *==========================================================================
    * AtualizarEstadoContasEquipe - Reproduz o "PROCEDURE When" dos 14 campos
    * de NOME da Page3:
    *     Return Empty(This.Parent.get_01_0NN.Value) And
    *            InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
    * ou seja: o nome so aceita digitacao enquanto o codigo da MESMA linha
    * esta vazio (resolvido o codigo, a descricao passa a ser so exibicao).
    *
    * Vive num metodo PUBLIC unico chamado pelo funil do lookup, pelo
    * BOParaForm e por BINDEVENT InteractiveChange dos campos de codigo
    * (regra #45.3) - BINDEVENT em "When" nao serve porque o retorno do
    * delegate eh descartado e nao bloquearia a edicao.
    *==========================================================================
    PROCEDURE AtualizarEstadoContasEquipe()
        LOCAL loc_oCnt1, loc_oCnt2, loc_lModoEdicao, loc_oErro

        TRY
            loc_oCnt1       = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
            loc_oCnt2       = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
            loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_024, loc_oCnt1.txt_4c__01_024a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_025, loc_oCnt1.txt_4c__01_025a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_026, loc_oCnt1.txt_4c__01_026a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_027, loc_oCnt1.txt_4c__01_027a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_028, loc_oCnt1.txt_4c__01_028a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_029, loc_oCnt1.txt_4c__01_029a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_030, loc_oCnt1.txt_4c__01_030a, loc_lModoEdicao)

            THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_031, loc_oCnt2.txt_4c__01_031a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_032, loc_oCnt2.txt_4c__01_032a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_033, loc_oCnt2.txt_4c__01_033a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_034, loc_oCnt2.txt_4c__01_034a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_035, loc_oCnt2.txt_4c__01_035a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_036, loc_oCnt2.txt_4c__01_036a, loc_lModoEdicao)
            THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_037, loc_oCnt2.txt_4c__01_037a, loc_lModoEdicao)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarEstadoContasEquipe")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarNomeContaEquipe - Aplica a UMA linha o When do campo de nome.
    *
    * O campo de CODIGO (get_01_0NN) NAO recebe tratamento: no dump o legado
    * declara nele apenas Valid e LostFocus - nao ha When - logo ele eh
    * sempre editavel, inclusive em VISUALIZAR. Desabilitar por modo seria
    * inventar comportamento que o legado nao tem (PILAR 1).
    *
    * IFs aninhados em vez de AND encadeado porque VFP9 nao faz
    * short-circuit: ALLTRIM teria de ser avaliado mesmo com o modo fora de
    * edicao.
    *==========================================================================
    PROTECTED PROCEDURE AjustarNomeContaEquipe(par_oTxtCod, par_oTxtNome, par_lModoEdicao)
        LOCAL loc_lHabilitaNome
        loc_lHabilitaNome = .F.

        IF par_lModoEdicao
            IF EMPTY(ALLTRIM(par_oTxtCod.Value))
                loc_lHabilitaNome = .T.
            ENDIF
        ENDIF

        *-- So atribui quando MUDA: este metodo roda tambem de dentro do
        *-- LostFocus do proprio campo de nome (via AbrirLookupConta), e
        *-- mexer em Enabled no meio de uma transicao de foco sem necessidade
        *-- eh a forma mais facil de criar efeito colateral de foco.
        IF par_oTxtNome.Enabled != loc_lHabilitaNome
            par_oTxtNome.Enabled = loc_lHabilitaNome
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarContaLinha - Funil COMUM dos wrappers ValidarConta0NN/
    * ValidarNomeConta0NN: aplica o guard de "valor nao mudou" (regra #47 -
    * LostFocus dispara SEMPRE que o foco sai do campo, mas o Valid do
    * legado de get_01_0NN/get_01_0NNa so dispara quando o valor MUDA) antes
    * de delegar a THIS.AbrirLookupConta.
    *
    * par_cPropGuarda identifica a property this_cUltimoValidarConta0NN-
    * Validado da LINHA (compartilhada entre o wrapper de codigo e o de
    * nome, como em FormSigOpIpE.ValidarOcorrenciaEtiqueta) - lida/escrita
    * por EVALUATE/STORE...TO porque o nome vem em variavel (regra #15/#34).
    *==========================================================================
    PROCEDURE ValidarContaLinha(par_oTxtCod, par_oTxtNome, par_cCampo, par_cPropGuarda)
        LOCAL loc_cValorAtual

        loc_cValorAtual = ALLTRIM(par_oTxtCod.Value) + "|" + ALLTRIM(par_oTxtNome.Value)

        IF loc_cValorAtual == EVALUATE("THIS." + par_cPropGuarda)
            RETURN
        ENDIF

        THIS.AbrirLookupConta(par_oTxtCod, par_oTxtNome, par_cCampo)

        STORE ALLTRIM(par_oTxtCod.Value) + "|" + ALLTRIM(par_oTxtNome.Value) ;
            TO ("THIS." + par_cPropGuarda)
    ENDPROC

    *==========================================================================
    * ValidarConta024..037 - Wrappers finos de ValidarContaLinha para o campo
    * de CODIGO de cada uma das 14 linhas de equipe (Page3, cnt_4c_Emp1 /
    * cnt_4c_Emp2) - equivalem ao "PROCEDURE Valid" de get_01_0NN. PUBLIC
    * (BINDEVENT exige - regra #3); sem parametros (LostFocus nao passa
    * nenhum - regra #47).
    *==========================================================================
    PROCEDURE ValidarConta024()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a, "Iclis", ;
                              "this_cUltimoValidarConta024Validado")
    ENDPROC

    PROCEDURE ValidarConta025()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a, "Iclis", ;
                              "this_cUltimoValidarConta025Validado")
    ENDPROC

    PROCEDURE ValidarConta026()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a, "Iclis", ;
                              "this_cUltimoValidarConta026Validado")
    ENDPROC

    PROCEDURE ValidarConta027()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027a, "Iclis", ;
                              "this_cUltimoValidarConta027Validado")
    ENDPROC

    PROCEDURE ValidarConta028()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028a, "Iclis", ;
                              "this_cUltimoValidarConta028Validado")
    ENDPROC

    PROCEDURE ValidarConta029()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029a, "Iclis", ;
                              "this_cUltimoValidarConta029Validado")
    ENDPROC

    PROCEDURE ValidarConta030()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030a, "Iclis", ;
                              "this_cUltimoValidarConta030Validado")
    ENDPROC

    PROCEDURE ValidarConta031()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031a, "Iclis", ;
                              "this_cUltimoValidarConta031Validado")
    ENDPROC

    PROCEDURE ValidarConta032()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032a, "Iclis", ;
                              "this_cUltimoValidarConta032Validado")
    ENDPROC

    PROCEDURE ValidarConta033()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033a, "Iclis", ;
                              "this_cUltimoValidarConta033Validado")
    ENDPROC

    PROCEDURE ValidarConta034()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034a, "Iclis", ;
                              "this_cUltimoValidarConta034Validado")
    ENDPROC

    PROCEDURE ValidarConta035()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035a, "Iclis", ;
                              "this_cUltimoValidarConta035Validado")
    ENDPROC

    PROCEDURE ValidarConta036()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036a, "Iclis", ;
                              "this_cUltimoValidarConta036Validado")
    ENDPROC

    PROCEDURE ValidarConta037()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037a, "Iclis", ;
                              "this_cUltimoValidarConta037Validado")
    ENDPROC

    *==========================================================================
    * ValidarNomeConta024..037 - Wrappers finos de ValidarContaLinha para o
    * campo de NOME de cada linha de equipe - equivalem ao "PROCEDURE Valid"
    * de get_01_0NNa, que faz "Locate For RClis = Padr(This.Value, 50)" e,
    * sem match, abre fwBuscaInt sobre RClis. Era a METADE do lookup de cada
    * linha que faltava: sem eles o usuario que digitasse o NOME da conta nao
    * tinha como resolver o codigo. Compartilha o MESMO guard de "valor nao
    * mudou" do wrapper de codigo da mesma linha (par_cPropGuarda identico).
    *==========================================================================
    PROCEDURE ValidarNomeConta024()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a, "Rclis", ;
                              "this_cUltimoValidarConta024Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta025()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a, "Rclis", ;
                              "this_cUltimoValidarConta025Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta026()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a, "Rclis", ;
                              "this_cUltimoValidarConta026Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta027()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027a, "Rclis", ;
                              "this_cUltimoValidarConta027Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta028()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028a, "Rclis", ;
                              "this_cUltimoValidarConta028Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta029()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029a, "Rclis", ;
                              "this_cUltimoValidarConta029Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta030()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030a, "Rclis", ;
                              "this_cUltimoValidarConta030Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta031()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031a, "Rclis", ;
                              "this_cUltimoValidarConta031Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta032()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032a, "Rclis", ;
                              "this_cUltimoValidarConta032Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta033()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033a, "Rclis", ;
                              "this_cUltimoValidarConta033Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta034()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034a, "Rclis", ;
                              "this_cUltimoValidarConta034Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta035()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035a, "Rclis", ;
                              "this_cUltimoValidarConta035Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta036()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036a, "Rclis", ;
                              "this_cUltimoValidarConta036Validado")
    ENDPROC

    PROCEDURE ValidarNomeConta037()
        THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037, ;
                              THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037a, "Rclis", ;
                              "this_cUltimoValidarConta037Validado")
    ENDPROC

    *==========================================================================
    * ContaEquipeInteractiveChange - Reavalia o When dos campos de nome a cada
    * tecla digitada no campo de codigo (o legado reavalia o When em cada
    * refresh do container). Ligado por BINDEVENT nos 14 campos de codigo.
    *==========================================================================
    PROCEDURE ContaEquipeInteractiveChange()
        THIS.AtualizarEstadoContasEquipe()
    ENDPROC

    *==========================================================================
    * ConfigurarTiposProjeto - Blocos "Tipo de Projeto" (Jb_038..041) e "Tipo
    * de Desenvolvimento" (Jb_042..044) da Page3, abaixo da linha divisoria.
    * Sao CheckBoxes independentes no legado (nao OptionGroup): o SCX declara
    * sete checkbox separados, cada um com ControlSource proprio em coluna
    * numeric(1,0) de SigMvJbC - mais de um pode ficar marcado.
    * Posicoes EXATAS do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTiposProjeto(par_oPag)
        *-- Tipo de Projeto (coluna da esquerda)
        THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_003", 326, 26, 100, ;
            "Tipo de Projeto", 45)
        THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_038", "lbl_4c_Lbl_01_038", ;
            350, 26, 44, 110, "Pedido do Cliente", 46, 47)
        THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_039", "lbl_4c_Lbl_01_039", ;
            369, 26, 44, 85, "Concorr" + CHR(234) + "ncia", 48, 49)
        THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_040", "lbl_4c_Lbl_01_040", ;
            389, 26, 44, 70, "Licita" + CHR(231) + CHR(227) + "o", 50, 51)
        THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_041", "lbl_4c_Lbl_01_041", ;
            408, 26, 44, 85, "Propriet" + CHR(225) + "rio", 52, 53)

        *-- Tipo de Desenvolvimento (coluna da direita)
        THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_004", 326, 208, 150, ;
            "Tipo de Desenvolvimento", 54)
        THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_042", "lbl_4c_Lbl_01_042", ;
            350, 208, 226, 135, "Desenvolvimento Total", 55, 56)
        THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_043", "lbl_4c_Lbl_01_043", ;
            369, 208, 226, 65, "Produ" + CHR(231) + CHR(227) + "o", 57, 58)
        THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_044", "lbl_4c_Lbl_01_044", ;
            389, 208, 226, 60, "Cria" + CHR(231) + CHR(227) + "o", 59, 60)
    ENDPROC

    *==========================================================================
    * AdicionarRotuloSecao - Label de titulo de bloco (os "lbl_02_NNN" do
    * legado: FontBold = .T., sem Width/Alignment no dump - ver regra #23).
    *==========================================================================
    PROTECTED PROCEDURE AdicionarRotuloSecao(par_oPai, par_cNome, par_nTop, par_nLeft, ;
                                             par_nWidth, par_cCaption, par_nTabIndex)
        LOCAL loc_oLbl

        par_oPai.AddObject(par_cNome, "Label")
        loc_oLbl = EVALUATE("par_oPai." + par_cNome)
        WITH loc_oLbl
            .Top = par_nTop
            .Left = par_nLeft
            .Width = par_nWidth
            .Height = 15
            .Alignment = 0
            .AutoSize = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .TabIndex = par_nTabIndex
            .Caption = par_cCaption
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarCheckBoxRotulado - Par CheckBox (Caption vazio) + Label ao lado,
    * padrao repetido no SCX legado nas Pages 3, 5 e 6.
    *
    * O CheckBox do legado tem Caption = "" e o texto vem num Label separado,
    * entao a caixa recebe Width/Height EXPLICITOS (16x17): AutoSize eh no-op
    * em CheckBox criado por AddObject e a caixa ficaria nos 100x17 do default,
    * cobrindo o Label ao lado. O Label vem DEPOIS da caixa, como no dump
    * (TabIndex do Label eh o maior do par), e a caixa termina antes do Left
    * do Label (26+16=42 < 44), sem sobreposicao.
    *
    * .Value = 0 NUMERICO (nunca .F.): as colunas Jb_0NN sao numeric(1,0) e
    * misturar logico com numerico dispara "Operator/operand type mismatch".
    *==========================================================================
    PROTECTED PROCEDURE AdicionarCheckBoxRotulado(par_oPai, par_cNomeChk, par_cNomeLbl, ;
                                                  par_nTop, par_nLeftChk, par_nLeftLbl, ;
                                                  par_nWidthLbl, par_cCaption, ;
                                                  par_nTabChk, par_nTabLbl)
        LOCAL loc_oChk, loc_oLbl

        par_oPai.AddObject(par_cNomeChk, "CheckBox")
        loc_oChk = EVALUATE("par_oPai." + par_cNomeChk)
        WITH loc_oChk
            .Top = par_nTop
            .Left = par_nLeftChk
            .Width = 16
            .Height = 17
            .Alignment = 0
            .AutoSize = .F.
            .BackStyle = 0
            .SpecialEffect = 1
            .TabIndex = par_nTabChk
            .Caption = ""
            .Value = 0
        ENDWITH

        par_oPai.AddObject(par_cNomeLbl, "Label")
        loc_oLbl = EVALUATE("par_oPai." + par_cNomeLbl)
        WITH loc_oLbl
            .Top = par_nTop
            .Left = par_nLeftLbl
            .Width = par_nWidthLbl
            .Height = 15
            .Alignment = 0
            .AutoSize = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName = "Tahoma"
            .FontSize = 8
            .TabIndex = par_nTabLbl
            .Caption = par_cCaption
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaMateriais - Page4 ("Informacoes Gerais Continuacao" no
    * dump), cinco campos de caminho de pasta/arquivo (Jb_045/046/047/048/061)
    * com par de botoes "Escolher" (GetDir) + "Abrir" (Shell.Application), e
    * o memo largo "Avaliacao do Job" (Jb_058). Posicoes EXATAS do dump
    * (tasks\task755\layout.json).
    *
    * O SCX legado NAO declara .Picture para btn_01_045/046/047/048/061 nem
    * para os pares "b" no dump capturado - inventar nome de arquivo violaria
    * a regra #25 (icone so do dump confirmado). Os botoes usam Caption
    * textual ("..." / "Abrir") em vez de icone.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaMateriais()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Job.Page4

            loc_oPag.AddObject("lbl_4c_Lbl_02_008", "Label")
            WITH loc_oPag.lbl_4c_Lbl_02_008
                .Top = 14
                .Left = 13
                .Width = 150
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
                .Caption = "Infos Clientes"
            ENDWITH

            THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_045", "lbl_4c_Lbl_01_045", ;
                "cmd_4c_Btn_01_045", "cmd_4c_Btn_01_045b", 33, 48, "Logomarca", ;
                "Btn045Click", "Btn045bClick")
            THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_046", "lbl_4c_Lbl_01_046", ;
                "cmd_4c_Btn_01_046", "cmd_4c_Btn_01_046b", 77, 92, "Manual de Marca", ;
                "Btn046Click", "Btn046bClick")
            THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_047", "lbl_4c_Lbl_01_047", ;
                "cmd_4c_Btn_01_047", "cmd_4c_Btn_01_047b", 121, 136, "Imagens", ;
                "Btn047Click", "Btn047bClick")
            THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_048", "lbl_4c_Lbl_01_048", ;
                "cmd_4c_Btn_01_048", "cmd_4c_Btn_01_048b", 165, 180, "Refer" + CHR(234) + "ncias", ;
                "Btn048Click", "Btn048bClick")
            THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_061", "lbl_4c_Lbl_01_061", ;
                "cmd_4c_Btn_01_061", "cmd_4c_Btn_01_061b", 209, 224, ;
                "Atas, emails e correspond" + CHR(234) + "ncias de altera" + CHR(231) + CHR(245) + "es e aprova" + CHR(231) + CHR(227) + "o do cliente", ;
                "Btn061Click", "Btn061bClick")

            *-- Avaliacao do Job (memo largo, Jb_058)
            loc_oPag.AddObject("lbl_4c_Lbl_01_058", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_058
                .Top = 255
                .Left = 13
                .Width = 400
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Avalia" + CHR(231) + CHR(227) + "o do Job (ap" + CHR(243) + "s primeira reuni" + CHR(227) + "o do time)"
            ENDWITH

            loc_oPag.AddObject("obj_4c_Get_01_058", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_058
                .Top = 273
                .Left = 13
                .Width = 973
                .Height = 166
                .ScrollBars = 2
                .Value = ""
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaMateriais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AdicionarCampoPastaMaterial - Helper para o padrao repetido 5x na Page4:
    * Label + EditBox (caminho) + botao "Escolher" (GetDir) + botao "Abrir"
    * (Shell.Application), nas posicoes EXATAS do dump (Top do label eh
    * par_nTopLbl, Top do campo/botoes eh par_nTopCampo - a mesma relacao de
    * -15/-9 vista nas 5 linhas do SCX).
    *==========================================================================
    PROTECTED PROCEDURE AdicionarCampoPastaMaterial(par_oPag, par_cNomeEdit, par_cNomeLbl, ;
            par_cNomeBtn, par_cNomeBtnB, par_nTopLbl, par_nTopCampo, par_cCaption, ;
            par_cHandlerBtn, par_cHandlerBtnB)
        LOCAL loc_oLbl, loc_oEdt, loc_oBtn, loc_oBtnB

        par_oPag.AddObject(par_cNomeLbl, "Label")
        loc_oLbl = EVALUATE("par_oPag." + par_cNomeLbl)
        WITH loc_oLbl
            .Top = par_nTopLbl
            .Left = 13
            .Width = 888
            .Height = 15
            .Alignment = 0
            .AutoSize = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName = "Tahoma"
            .FontSize = 8
            .Caption = par_cCaption
        ENDWITH

        par_oPag.AddObject(par_cNomeEdit, "EditBox")
        loc_oEdt = EVALUATE("par_oPag." + par_cNomeEdit)
        WITH loc_oEdt
            .Top = par_nTopCampo
            .Left = 13
            .Width = 888
            .Height = 23
            .ScrollBars = 0
            .Value = ""
            *-- Legado: "PROCEDURE When / Return .f." - o campo NUNCA recebe
            *-- foco por digitacao, em modo algum; o valor so muda pelos
            *-- botoes "..."/"Abrir" (EscolherPasta/AbrirPasta).
            .ReadOnly = .T.
        ENDWITH

        par_oPag.AddObject(par_cNomeBtn, "CommandButton")
        loc_oBtn = EVALUATE("par_oPag." + par_cNomeBtn)
        WITH loc_oBtn
            .Top = par_nTopCampo - 9
            .Left = 905
            .Width = 40
            .Height = 32
            .FontName = "Tahoma"
            .FontSize = 8
            .Caption = "..."
            .ToolTipText = "Selecionar Diret" + CHR(243) + "rio, Pasta ou Caminho de Rede"
        ENDWITH
        BINDEVENT(loc_oBtn, "Click", THIS, par_cHandlerBtn)

        par_oPag.AddObject(par_cNomeBtnB, "CommandButton")
        loc_oBtnB = EVALUATE("par_oPag." + par_cNomeBtnB)
        WITH loc_oBtnB
            .Top = par_nTopCampo - 9
            .Left = 947
            .Width = 40
            .Height = 32
            .FontName = "Tahoma"
            .FontSize = 8
            .Caption = "Abrir"
            .ToolTipText = "Abrir no Explorer"
        ENDWITH
        BINDEVENT(loc_oBtnB, "Click", THIS, par_cHandlerBtnB)
    ENDPROC

    *==========================================================================
    * EscolherPasta/AbrirPasta - Nucleo dos 10 botoes "..."/"Abrir" da Page4
    * (legado: btn_01_0NN.Click - GetDir + Alltrim; btn_01_0NNb.Click -
    * Shell.Application.Open). PUBLIC (chamados pelos wrappers via THIS.).
    *==========================================================================
    PROCEDURE EscolherPasta(par_oTxt)
        LOCAL loc_cDir
        loc_cDir = GETDIR("", "Selecione o Diret" + CHR(243) + "rio, Pasta ou Caminho de Rede", ;
            "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios")

        IF !EMPTY(loc_cDir)
            par_oTxt.Value = ALLTRIM(loc_cDir)
        ELSE
            par_oTxt.Value = ""
        ENDIF
        par_oTxt.Refresh()
    ENDPROC

    PROCEDURE AbrirPasta(par_oTxt)
        LOCAL loc_cDir, loc_oApp, loc_oErro
        TRY
            loc_cDir = ALLTRIM(par_oTxt.Value)
            IF !EMPTY(loc_cDir)
                loc_oApp = CREATEOBJECT("Shell.Application")
                loc_oApp.Open(loc_cDir)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir pasta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Btn045Click..Btn061bClick - Wrappers finos de EscolherPasta/AbrirPasta
    * para cada um dos 5 campos de caminho da Page4. PUBLIC (BINDEVENT exige).
    *==========================================================================
    PROCEDURE Btn045Click()
        THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045)
    ENDPROC
    PROCEDURE Btn045bClick()
        THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045)
    ENDPROC
    PROCEDURE Btn046Click()
        THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046)
    ENDPROC
    PROCEDURE Btn046bClick()
        THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046)
    ENDPROC
    PROCEDURE Btn047Click()
        THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047)
    ENDPROC
    PROCEDURE Btn047bClick()
        THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047)
    ENDPROC
    PROCEDURE Btn048Click()
        THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048)
    ENDPROC
    PROCEDURE Btn048bClick()
        THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048)
    ENDPROC
    PROCEDURE Btn061Click()
        THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061)
    ENDPROC
    PROCEDURE Btn061bClick()
        THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaFinanceiroCampos - Page5 ("Controladoria / Fiscal"),
    * campos restantes alem da grade "Fontes Pagadoras" (ja criada por
    * ConfigurarGridFontes): titulo de secao, 8 checkboxes (Jb_063..069,075),
    * Codigo de Atividade (Jb_062), Outras Receitas (Jb_070) e Comentarios
    * Financeiros (Jb_071). Posicoes EXATAS do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaFinanceiroCampos()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Job.Page5

            THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_009", 21, 15, 330, ;
                "Modelo Fiscal / Considera" + CHR(231) + CHR(245) + "es Financeiras", 1)

            *-- Coluna da esquerda
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_063", "lbl_4c_Lbl_01_063", ;
                45, 15, 33, 90, "NF de Servi" + CHR(231) + "o", 2, 3)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_064", "lbl_4c_Lbl_01_064", ;
                64, 15, 33, 90, "Nota de D" + CHR(233) + "bito", 4, 5)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_065", "lbl_4c_Lbl_01_065", ;
                84, 15, 33, 90, "NF de Loca" + CHR(231) + CHR(227) + "o", 6, 7)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_075", "lbl_4c_Lbl_01_075", ;
                103, 15, 33, 100, "Conta Corrente", 8, 9)

            *-- Coluna do meio
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_066", "lbl_4c_Lbl_01_066", ;
                45, 174, 192, 100, "Incentivo ICMS", 10, 11)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_067", "lbl_4c_Lbl_01_067", ;
                64, 174, 192, 110, "Incentivo Rouanet", 12, 13)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_068", "lbl_4c_Lbl_01_068", ;
                84, 174, 192, 90, "Incentivo ISS", 14, 15)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_069", "lbl_4c_Lbl_01_069", ;
                103, 174, 192, 80, "Patroc" + CHR(237) + "nio", 16, 17)

            *-- Coluna da direita
            loc_oPag.AddObject("lbl_4c_Lbl_01_062", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_062
                .Top = 7
                .Left = 347
                .Width = 150
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 18
                .Caption = "C" + CHR(243) + "digo de Atividade"
            ENDWITH
            loc_oPag.AddObject("obj_4c_Get_01_062", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_062
                .Top = 22
                .Left = 347
                .Width = 640
                .Height = 23
                .ScrollBars = 0
                .TabIndex = 19
                .Value = ""
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Lbl_01_070", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_070
                .Top = 47
                .Left = 347
                .Width = 150
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 20
                .Caption = "Outras Receitas"
            ENDWITH
            loc_oPag.AddObject("obj_4c_Get_01_070", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_070
                .Top = 62
                .Left = 347
                .Width = 640
                .Height = 23
                .ScrollBars = 0
                .TabIndex = 21
                .Value = ""
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Lbl_01_071", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_071
                .Top = 87
                .Left = 347
                .Width = 453
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 22
                .Caption = "Coment" + CHR(225) + "rios Financeiros (condi" + CHR(231) + CHR(245) + "es de pagamento, verba estimada, hist" + CHR(243) + "rico de verba gasta)"
            ENDWITH
            loc_oPag.AddObject("obj_4c_Get_01_071", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_071
                .Top = 102
                .Left = 347
                .Width = 640
                .Height = 85
                .ScrollBars = 2
                .TabIndex = 23
                .Value = ""
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaFinanceiroCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaApresentacao - Page6 ("Apresentacao" no dump): tipo de
    * apresentacao (Jb_049/050), Proposta Comercial (Jb_051/052/053 + Jb_073
    * "Outros"), Proposta Tecnica (Jb_054/055/056 + Jb_074 "Outros") e o memo
    * largo "Documentos Necessarios" (Jb_057). Posicoes EXATAS do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaApresentacao()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Job.Page6

            THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_005", 30, 16, 100, "Apresenta" + CHR(231) + CHR(227) + "o", 1)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_049", "lbl_4c_Lbl_01_049", ;
                54, 16, 34, 70, "Presencial", 2, 3)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_050", "lbl_4c_Lbl_01_050", ;
                73, 16, 34, 70, "Eletr" + CHR(244) + "nica", 4, 5)

            THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_006", 30, 233, 150, "Proposta Comercial", 6)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_051", "lbl_4c_Lbl_01_051", ;
                54, 233, 251, 65, "Impress" + CHR(227) + "o", 7, 8)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_052", "lbl_4c_Lbl_01_052", ;
                73, 233, 251, 30, "CD", 9, 10)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_053", "lbl_4c_Lbl_01_053", ;
                93, 233, 251, 50, "Outros", 11, 12)
            loc_oPag.AddObject("obj_4c_Get_01_073", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_073
                .Top = 114
                .Left = 233
                .Width = 360
                .Height = 23
                .ScrollBars = 0
                .TabIndex = 13
                .Value = ""
            ENDWITH

            THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_007", 30, 625, 150, "Proposta T" + CHR(233) + "cnica", 14)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_054", "lbl_4c_Lbl_01_054", ;
                54, 625, 643, 65, "Impress" + CHR(227) + "o", 15, 16)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_055", "lbl_4c_Lbl_01_055", ;
                73, 625, 643, 30, "CD", 17, 18)
            THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_056", "lbl_4c_Lbl_01_056", ;
                93, 625, 643, 50, "Outros", 19, 20)
            loc_oPag.AddObject("obj_4c_Get_01_074", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_074
                .Top = 114
                .Left = 625
                .Width = 360
                .Height = 23
                .ScrollBars = 0
                .TabIndex = 21
                .Value = ""
            ENDWITH

            loc_oPag.AddObject("lin_4c_Line1", "Line")
            WITH loc_oPag.lin_4c_Line1
                .Top = 150
                .Left = 12
                .Width = 974
                .Height = 0
                .BorderWidth = 1
                .BorderColor = RGB(90, 90, 90)
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Lbl_01_057", "Label")
            WITH loc_oPag.lbl_4c_Lbl_01_057
                .Top = 156
                .Left = 12
                .Width = 300
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 22
                .Caption = "Documentos Necess" + CHR(225) + "rios"
            ENDWITH
            loc_oPag.AddObject("obj_4c_Get_01_057", "EditBox")
            WITH loc_oPag.obj_4c_Get_01_057
                .Top = 171
                .Left = 12
                .Width = 973
                .Height = 268
                .ScrollBars = 2
                .TabIndex = 23
                .Value = ""
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaApresentacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalhoJob - Bloco de identificacao do Job, criado DIRETO na
    * raiz do form (acima do PageFrame), exatamente como no SCX legado: o
    * SIGOPJOB nao tem o container de cabecalho cinza (cntSombra) do
    * frmcadastro - sao campos soltos na Form.
    *
    * Posicoes/propriedades EXATAS do dump (SIGOPJOB.getCab*/lblCab*/Say3/
    * get_Extra/lbl_Extra). Nomes conforme tasks\task755\mapeamento.json.
    *
    * getCab001/002/005/006/010 sao SOMENTE-LEITURA: o SCX declara
    * "Enabled = .F." explicitamente nos cinco, com DisabledBackColor
    * 255,255,244 (creme) - eh a cor que da a aparencia de campo travado do
    * legado. Quem os preenche eh CarregarCabecalhoJob(), a partir das
    * propriedades this_cCab* do BO.
    *
    * O Label vem SEMPRE antes do campo (a caixa transparente do Label nao
    * pode ficar por cima do controle - regra #23). Os Labels da classe "say"
    * do legado nao declaram Width nem Alignment, entao recebem
    * Alignment = 0 + AutoSize = .F. + Width que caiba o texto, e ForeColor
    * RGB(90,90,90) - sobre o fundo claro da Form, branco seria INVISIVEL
    * (regra #12).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalhoJob()
        LOCAL loc_oErro
        TRY
            *-- Linha 1: Job (codigo) + Descricao do Job
            THIS.AddObject("lbl_4c_LblCab001", "Label")
            WITH THIS.lbl_4c_LblCab001
                .Top = 3
                .Left = 16
                .Width = 30
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 1
                .Caption = "Job"
            ENDWITH

            THIS.AddObject("txt_4c_Cab001", "TextBox")
            WITH THIS.txt_4c_Cab001
                .Top = 18
                .Left = 16
                .Width = 80
                .Height = 23
                .BorderStyle = 1
                .SpecialEffect = 1
                .TabIndex = 2
                .Enabled = .F.
                .MaxLength = 10
                .BackColor         = RGB(255, 255, 244)
                .DisabledBackColor = RGB(255, 255, 244)
                .Value = ""
            ENDWITH

            THIS.AddObject("lbl_4c_LblCab002", "Label")
            WITH THIS.lbl_4c_LblCab002
                .Top = 3
                .Left = 99
                .Width = 60
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 3
                .Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.AddObject("txt_4c_Cab002", "TextBox")
            WITH THIS.txt_4c_Cab002
                .Top = 18
                .Left = 99
                .Width = 290
                .Height = 23
                .BorderStyle = 1
                .SpecialEffect = 1
                .TabIndex = 4
                .Enabled = .F.
                .MaxLength = 50
                .BackColor         = RGB(255, 255, 244)
                .DisabledBackColor = RGB(255, 255, 244)
                .Value = ""
            ENDWITH

            *-- Linha 2: Cliente (conta recebida do form pai) + Descricao
            THIS.AddObject("lbl_4c_LblCab005", "Label")
            WITH THIS.lbl_4c_LblCab005
                .Top = 45
                .Left = 16
                .Width = 50
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 5
                .Caption = "Cliente"
            ENDWITH

            THIS.AddObject("txt_4c_Cab005", "TextBox")
            WITH THIS.txt_4c_Cab005
                .Top = 60
                .Left = 16
                .Width = 80
                .Height = 23
                .BorderStyle = 1
                .SpecialEffect = 1
                .TabIndex = 6
                .Enabled = .F.
                .MaxLength = 10
                .BackColor         = RGB(255, 255, 244)
                .DisabledBackColor = RGB(255, 255, 244)
                .Value = ""
            ENDWITH

            THIS.AddObject("lbl_4c_LblCab006", "Label")
            WITH THIS.lbl_4c_LblCab006
                .Top = 45
                .Left = 99
                .Width = 60
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 7
                .Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.AddObject("txt_4c_Cab006", "TextBox")
            WITH THIS.txt_4c_Cab006
                .Top = 60
                .Left = 99
                .Width = 290
                .Height = 23
                .BorderStyle = 1
                .SpecialEffect = 1
                .TabIndex = 8
                .Enabled = .F.
                .MaxLength = 50
                .BackColor         = RGB(255, 255, 244)
                .DisabledBackColor = RGB(255, 255, 244)
                .Value = ""
            ENDWITH

            *-- Linha 3: Data Entrada (menor data das movimentacoes do Job)
            THIS.AddObject("lbl_4c_LblCab011", "Label")
            WITH THIS.lbl_4c_LblCab011
                .Top = 85
                .Left = 16
                .Width = 75
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 9
                .Caption = "Data Entrada"
            ENDWITH

            THIS.AddObject("txt_4c_Cab010", "TextBox")
            WITH THIS.txt_4c_Cab010
                .Top = 100
                .Left = 16
                .Width = 80
                .Height = 23
                .BorderStyle = 1
                .SpecialEffect = 1
                .TabIndex = 10
                .Enabled = .F.
                .BackColor         = RGB(255, 255, 244)
                .DisabledBackColor = RGB(255, 255, 244)
                .Value = {}
            ENDWITH

            *-- "Briefing Extra" (CheckBox + rotulo). ControlSource legado
            *-- "crSigMvJbC.Jb_072" - mapeado por BOParaForm/FormParaBO.
            *-- O AutoSize = .T. do dump NAO eh transcrito: em CheckBox criado
            *-- por AddObject ele eh no-op (a caixa ficaria nos 100x17 do
            *-- default e cobriria o rotulo ao lado) - Width/Height explicitos.
            THIS.AddObject("chk_4c_Get_Extra", "CheckBox")
            WITH THIS.chk_4c_Get_Extra
                .Top = 104
                .Left = 102
                .Width = 16
                .Height = 17
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .SpecialEffect = 1
                .Themes = .T.
                .TabIndex = 11
                .ForeColor = RGB(36, 84, 155)
                .Caption = ""
                .Value = 0
            ENDWITH

            THIS.AddObject("lbl_4c_Lbl_Extra", "Label")
            WITH THIS.lbl_4c_Lbl_Extra
                .Top = 104
                .Left = 120
                .Width = 90
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
                .TabIndex = 12
                .Caption = "Briefing Extra"
            ENDWITH

            *-- Contatos com o Cliente (memo largo, a direita do cabecalho)
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top = 3
                .Left = 396
                .Width = 300
                .Height = 15
                .Alignment = 0
                .AutoSize = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName = "Tahoma"
                .FontSize = 8
                .TabIndex = 13
                .Caption = "Contatos com o Cliente [Nome, e-mail, telefones, etc]"
            ENDWITH

            *-- ATENCAO - divergencia de BANCO, nao de migracao (regra #14/#45):
            *-- o SCX legado liga este EditBox a ControlSource
            *-- "crSigMvJbC.Jb_Contatos", e essa coluna NAO EXISTE no schema
            *-- canonico. Medido em docs\schema.sql: SigMvJbC tem 77 colunas -
            *-- empdopnums, jb_001..jb_075 e jb_contato (datetime); nao existe
            *-- jb_contatos de texto. O dump do form eh mais novo que o banco.
            *-- O campo eh reproduzido para a tela ficar fiel ao legado
            *-- (PILAR 1), mas NAO eh persistido: criar a coluna violaria o
            *-- PILAR 2 (schema identico) e apontar para jb_contato (datetime)
            *-- gravaria texto no campo errado. A ausencia fica VISIVEL aqui de
            *-- proposito, em vez de ser mascarada por um binding inventado.
            THIS.AddObject("obj_4c_GetCabContatos", "EditBox")
            WITH THIS.obj_4c_GetCabContatos
                .Top = 18
                .Left = 396
                .Width = 494
                .Height = 106
                .FontName = "Verdana"
                .FontSize = 8
                .SpecialEffect = 1
                .ScrollBars = 2
                .TabIndex = 14
                .DisabledBackColor = RGB(255, 255, 244)
                .DisabledForeColor = RGB(36, 84, 155)
                .NullDisplay = " "
                .Value = ""
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalhoJob")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoRetornar - Cria obj_4c_CmdRetornar (cmdRetornar legado),
    * CommandGroup de 1 botao que fecha o dialogo de Complementos do Job
    * (Click em CmdRetornarClick, regra #3/#45 - BINDEVENT em Buttons(1)).
    * Posicao EXATA do dump: Top=13, Left=907, Width=85, Height=85.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoRetornar()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_CmdRetornar", "CommandGroup")
            WITH THIS.obj_4c_CmdRetornar
                .Top         = 13
                .Left        = 907
                .Width       = 85
                .Height      = 85
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 0
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top        = 5
                    .Left       = 5
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Caption    = "Retornar"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                    .Cancel     = .T.
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.obj_4c_CmdRetornar.Buttons(1), "Click", THIS, "CmdRetornarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoRetornar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGridFontes - Cria a secao "Fontes Pagadoras" (grdFontes do
    * legado) na Page5 (Financeiro): label de secao, linha divisoria, grade
    * editavel ligada a cursor_4c_Fontes, botoes Inserir/Excluir (icones
    * cadastro_inserir_26.jpg / cadastro_excluir_26.jpg - transcritos do dump
    * em tasks\task755\SigOpJob_form_codigo_fonte.txt:3677/3689, regra #25)
    * e os totalizadores txt_4c_TotFontes/txt_4c_TotValores (somente leitura).
    *
    * O cursor placeholder nasce ANTES do Grid (regra #41) com a MESMA ordem
    * de colunas do SELECT feito por SigOpJobBO.CarregarFontes(), para o
    * rebind em CarregarLista() nao reordenar nada.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridFontes()
        LOCAL loc_oPagina, loc_oErro
        TRY
            IF USED("cursor_4c_Fontes")
                USE IN cursor_4c_Fontes
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Fontes ;
                (empdopnums C(29), jbi_autors C(20), jbi_fontes C(50), ;
                 jbi_modelos C(30), jbi_valors N(11,2), pkchaves C(20))
            SET NULL OFF

            loc_oPagina = THIS.pgf_4c_Job.Page5

            loc_oPagina.AddObject("lbl_4c_Lbl_02_010", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_02_010
                .Top       = 199
                .Left      = 13
                .Width     = 200
                .Height    = 15
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Fontes Pagadoras"
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("lin_4c_Line1", "Line")
            WITH loc_oPagina.lin_4c_Line1
                .Top     = 194
                .Left    = 13
                .Width   = 974
                .Height  = 0
                .Visible = .T.
            ENDWITH

            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            WITH loc_oPagina.grd_4c_Dados
                .Top               = 217
                .Left              = 12
                .Width             = 928
                .Height            = 203
                .ColumnCount       = 4
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .GridLines         = 3
                .GridLineWidth     = 1
                .GridLineColor     = RGB(238, 238, 238)
                .HeaderHeight      = 20
                .ScrollBars        = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .ReadOnly          = .F.
                .Visible           = .T.

                .Column1.Movable   = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .F.
                .Column1.Width     = 360
                .Column1.Format    = "K!"
                .Column1.FontName  = "Courier New"
                .Column1.FontSize  = 8
                .Column1.Header1.Caption   = "Cliente"
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8

                .Column2.Movable   = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .F.
                .Column2.Width     = 220
                .Column2.Format    = "K!"
                .Column2.FontName  = "Courier New"
                .Column2.FontSize  = 8
                .Column2.Header1.Caption   = "Modelo Fiscal"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8

                .Column3.Movable   = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly  = .F.
                .Column3.Width     = 150
                .Column3.Format    = "K!"
                .Column3.FontName  = "Courier New"
                .Column3.FontSize  = 8
                .Column3.Header1.Caption   = "N" + CHR(250) + "mero Incentivo"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8

                .Column4.Movable   = .F.
                .Column4.Resizable = .F.
                .Column4.ReadOnly  = .F.
                .Column4.Width     = 174
                .Column4.Format    = "999,999,999.99"
                .Column4.InputMask = "999,999,999.99"
                .Column4.FontName  = "Courier New"
                .Column4.FontSize  = 8
                .Column4.Header1.Caption   = "Valor"
                .Column4.Header1.Alignment = 2
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
            ENDWITH
            BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdFontesAfterRowColChange")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "When", THIS, "GrdFontesColumnWhen")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Text1, "When", THIS, "GrdFontesColumnWhen")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column3.Text1, "When", THIS, "GrdFontesColumnWhen")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Text1, "When", THIS, "GrdFontesColumnWhen")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Text1, "Valid", THIS, "GrdFontesColumn4Valid")

            *-- Botao Inserir linha (legado: btnInserir top=217, left=947)
            loc_oPagina.AddObject("cmd_4c_BtnInserir", "CommandButton")
            WITH loc_oPagina.cmd_4c_BtnInserir
                .Top             = 217
                .Left            = 947
                .Width           = 42
                .Height          = 42
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Inserir Linha em Branco na Grade"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_BtnInserir, "Click", THIS, "BtnInserirClick")

            *-- Botao Excluir linha (legado: btnExcluir top=257, left=947)
            loc_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
            WITH loc_oPagina.cmd_4c_BtnExcluir
                .Top             = 257
                .Left            = 947
                .Width           = 42
                .Height          = 42
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .PicturePosition = 13
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Excluir"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirClick")

            *-- Totalizadores (somente leitura) - legado: getTotFontes/getTotValores
            loc_oPagina.AddObject("txt_4c_TotFontes", "TextBox")
            WITH loc_oPagina.txt_4c_TotFontes
                .Top               = 419
                .Left              = 595
                .Width             = 150
                .Height            = 23
                .Alignment         = 1
                .BorderStyle       = 1
                .SpecialEffect     = 1
                .Enabled           = .F.
                .Value             = ""
                .BackColor         = RGB(255, 255, 244)
                .DisabledBackColor = RGB(255, 255, 244)
                .Visible           = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_TotValores", "TextBox")
            WITH loc_oPagina.txt_4c_TotValores
                .Top               = 419
                .Left              = 747
                .Width             = 174
                .Height            = 23
                .Alignment         = 1
                .BorderStyle       = 1
                .SpecialEffect     = 1
                .Enabled           = .F.
                .Value             = ""
                .BackColor         = RGB(255, 255, 244)
                .DisabledBackColor = RGB(255, 255, 244)
                .Visible           = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridFontes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega SigMvJbI (via BO.CarregarFontes) na grade
    * "Fontes Pagadoras" e rebinda RecordSource/ControlSource/Width/Header -
    * RecordSource RESETA essas propriedades (Problema 48), por isso sao
    * reaplicadas aqui, depois do load (legado: PROCEDURE montagrades).
    *
    * Em modo INCLUIR/ALTERAR garante ao menos 1 linha em branco (mesma
    * logica do btnInserir.Click) e exibe os botoes de Inserir/Excluir;
    * em VISUALIZAR eles ficam ocultos e a grade some de edicao via o
    * guard de GrdFontesColumnWhen.
    *
    * PUBLIC de proposito: este e' o FUNIL de carga da lista deste dialogo
    * (a grade "Fontes Pagadoras" e' a unica lista que o SCX legado tem), e
    * o harness de teste chama THIS.oForm.CarregarLista() de FORA da classe
    * - PEMSTATUS devolve .T. para metodo PROTECTED, entao o teste entraria
    * no branch e a chamada estouraria em runtime (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_cAlias, loc_lModoEdicao, loc_lProsseguir, loc_oErro

        TRY
            *-- Guarda SEM "RETURN" dentro do TRY (regra #1): o early-exit vira
            *-- flag e o corpo fica sob o IF.
            loc_lProsseguir = THIS.this_oBusinessObject.CarregarFontes()

            IF loc_lProsseguir
                loc_cAlias      = THIS.this_oBusinessObject.this_cCursorFontes
                loc_oGrid       = THIS.pgf_4c_Job.Page5.grd_4c_Dados
                loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

                *-- .RecordSource FORA do WITH (regra GRID-WITH/#41): com ela
                *-- dentro do mesmo WITH que acessa .ColumnN, o VFP9 ainda
                *-- nao tem as colunas religadas ao novo RecordSource e
                *-- estoura "Unknown member COLUMN1".
                loc_oGrid.RecordSource = loc_cAlias

                WITH loc_oGrid
                    .Column1.ControlSource   = loc_cAlias + ".jbi_fontes"
                    .Column1.Width           = 360
                    .Column1.Header1.Caption = "Cliente"

                    .Column2.ControlSource   = loc_cAlias + ".jbi_modelos"
                    .Column2.Width           = 220
                    .Column2.Header1.Caption = "Modelo Fiscal"

                    .Column3.ControlSource   = loc_cAlias + ".jbi_autors"
                    .Column3.Width           = 150
                    .Column3.Header1.Caption = "N" + CHR(250) + "mero Incentivo"

                    .Column4.ControlSource   = loc_cAlias + ".jbi_valors"
                    .Column4.Width           = 174
                    .Column4.Header1.Caption = "Valor"
                ENDWITH

                SELECT (loc_cAlias)
                GO TOP

                THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .F.
                THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .F.

                IF loc_lModoEdicao
                    LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
                    IF !FOUND()
                        INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
                            (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
                    ENDIF
                    GO BOTTOM

                    THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .T.
                    THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .T.
                ENDIF

                loc_oGrid.Refresh()
                THIS.GrdFontesAfterRowColChange(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCabecalhoJob - Preenche o bloco de identificacao do Job
    * (equivalente a PROCEDURE carregacabs do SCX legado, que tambem comeca
    * LIMPANDO os getCab antes de recarregar).
    *
    * Os cinco campos sao Enabled = .F.: quem le o banco eh
    * SigOpJobBO.CarregarCabecalho(), e aqui so se espelha o resultado.
    *==========================================================================
    PROTECTED PROCEDURE CarregarCabecalhoJob()
        LOCAL loc_oBO, loc_oErro

        TRY
            *-- Limpeza previa (o "For lnClr = 1 To 12 ... Value = []" legado)
            THIS.txt_4c_Cab001.Value = ""
            THIS.txt_4c_Cab002.Value = ""
            THIS.txt_4c_Cab005.Value = ""
            THIS.txt_4c_Cab006.Value = ""
            THIS.txt_4c_Cab010.Value = {}

            *-- Guarda de conexao em IF SEPARADO (VFP9 nao garante
            *-- short-circuit em AND) e delegada ao BO.ConexaoAtiva(), que
            *-- testa TYPE antes do valor - sem conexao a variavel
            *-- gnConnHandle pode nem existir.
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                IF loc_oBO.ConexaoAtiva()
                    loc_oBO.CarregarCabecalho(THIS.this_cContas)

                    THIS.txt_4c_Cab001.Value = loc_oBO.this_cCabJobs
                    THIS.txt_4c_Cab002.Value = loc_oBO.this_cCabJobDesc
                    THIS.txt_4c_Cab005.Value = loc_oBO.this_cCabContas
                    THIS.txt_4c_Cab006.Value = loc_oBO.this_cCabContaDesc
                    THIS.txt_4c_Cab010.Value = ConverterParaData(loc_oBO.this_dCabDataEntrada)
                ENDIF
            ENDIF

            THIS.txt_4c_Cab001.Refresh()
            THIS.txt_4c_Cab002.Refresh()
            THIS.txt_4c_Cab005.Refresh()
            THIS.txt_4c_Cab006.Refresh()
            THIS.txt_4c_Cab010.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCabecalhoJob")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarNomesEquipes - Preenche os 14 campos de NOME da Page3 a partir
    * do codigo gravado em cada campo de codigo (equivalente a PROCEDURE
    * mdadosequipes do SCX legado, que para cada Jb_024..037 nao vazio faz
    * CursorQuery em SigCdCli e joga RClis no campo "a").
    *
    * O legado NAO tem ControlSource nos campos "a": eles sao preenchidos por
    * codigo, e eh isso que se reproduz aqui.
    *==========================================================================
    PROTECTED PROCEDURE CarregarNomesEquipes()
        LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO   = THIS.this_oBusinessObject
                loc_oCnt1 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
                loc_oCnt2 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2

                loc_oCnt1.txt_4c__01_024a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb024)
                loc_oCnt1.txt_4c__01_025a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb025)
                loc_oCnt1.txt_4c__01_026a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb026)
                loc_oCnt1.txt_4c__01_027a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb027)
                loc_oCnt1.txt_4c__01_028a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb028)
                loc_oCnt1.txt_4c__01_029a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb029)
                loc_oCnt1.txt_4c__01_030a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb030)

                loc_oCnt2.txt_4c__01_031a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb031)
                loc_oCnt2.txt_4c__01_032a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb032)
                loc_oCnt2.txt_4c__01_033a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb033)
                loc_oCnt2.txt_4c__01_034a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb034)
                loc_oCnt2.txt_4c__01_035a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb035)
                loc_oCnt2.txt_4c__01_036a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb036)
                loc_oCnt2.txt_4c__01_037a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb037)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarNomesEquipes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ObterNomeConta - SigCdCli.RClis do codigo informado, delegando ao BO.
    * Devolve "" para codigo vazio ou sem conexao (modo de teste/validacao de
    * UI roda com gnConnHandle invalido).
    *==========================================================================
    PROTECTED FUNCTION ObterNomeConta(par_cCodigo)
        LOCAL loc_cNome
        loc_cNome = ""

        *-- IFs aninhados, nao AND encadeado: VFP9 nao garante short-circuit,
        *-- e a guarda de conexao tem de vir DEPOIS de provar que o BO existe.
        IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(ALLTRIM(par_cCodigo))
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.ConexaoAtiva()
                    loc_cNome = THIS.this_oBusinessObject.ObterRazaoConta(par_cCodigo)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cNome
    ENDFUNC

    *==========================================================================
    * GrdFontesColumnWhen - Controla editabilidade das 4 colunas da grade
    * "Fontes Pagadoras" (legado: Column1..4.Text1.When, texto identico nas
    * quatro - "Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])").
    *==========================================================================
    PROCEDURE GrdFontesColumnWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * GrdFontesColumn4Valid - Ao sair da coluna Valor com Cliente e Modelo
    * Fiscal preenchidos, garante uma nova linha em branco no final da grade
    * (legado: Column4.Text1.Valid).
    *==========================================================================
    PROCEDURE GrdFontesColumn4Valid()
        LOCAL loc_cAlias

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .T.
        ENDIF

        loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        SELECT (loc_cAlias)
        IF !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos) AND !EOF()
            SKIP
            IF EOF()
                INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
                    (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
            ENDIF
        ENDIF

        GO TOP
        THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
        GO BOTTOM

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnInserirClick - Insere linha em branco na grade "Fontes Pagadoras"
    * (legado: pgPagina5.btnInserir.Click). So reutiliza linha ja vazia
    * (JBI_Fontes e JBI_Modelos vazios); senao cria uma nova com pkChaves
    * unico (fUniqueIds()).
    *==========================================================================
    PROCEDURE BtnInserirClick()
        *-- Guardas por FLAG, nunca RETURN: RETURN dentro de TRY/ENDTRY (bare
        *-- ou com valor) estoura "RETURN/RETRY statement not allowed in
        *-- TRY/CATCH" em RUNTIME, e so no caminho em que a guarda pega -
        *-- o .prg compila limpo e o caminho feliz passa nos testes (regra #1).
        LOCAL loc_cAlias, loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
                IF !USED(loc_cAlias)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT (loc_cAlias)
                LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
                IF !FOUND()
                    INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
                        (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
                ENDIF

                SELECT (loc_cAlias)
                GO TOP
                THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
                GO BOTTOM
                THIS.pgf_4c_Job.Page5.grd_4c_Dados.SetFocus()
                THIS.GrdFontesAfterRowColChange(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui a linha corrente da grade "Fontes Pagadoras"
    * (legado: pgPagina5.btnExcluir.Click). DELETE sem PACK - SET DELETED ON
    * (config.prg) ja tira a linha da visao do Grid.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        *-- Guardas por FLAG, nunca RETURN - ver comentario de BtnInserirClick
        *-- (regra #1). Aqui o RETURN era ainda mais perigoso: ele ficava
        *-- ANTES do LockScreen = .T., mas o estouro em runtime deixaria o
        *-- metodo pelo CATCH, que repoe LockScreen = .F.
        LOCAL loc_cAlias, loc_nRec, loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
                IF !USED(loc_cAlias)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.LockScreen = .T.

                SELECT (loc_cAlias)
                loc_nRec = RECNO()
                IF !EOF()
                    DELETE
                ENDIF

                GO TOP
                THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
                IF BETWEEN(loc_nRec, 1, RECCOUNT())
                    GO (loc_nRec)
                ELSE
                    GO BOTTOM
                ENDIF
                THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
                THIS.GrdFontesAfterRowColChange(1)

                THIS.LockScreen = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdFontesAfterRowColChange - Recalcula os totalizadores da grade.
    * Uso legitimo de AfterRowColChange (regra #46): nao valida CELULA, so
    * agrega o cursor inteiro - igual ao legado, que tambem chama este
    * evento manualmente apos cada INSERT/DELETE/GO (nao confia em disparo
    * automatico do Grid para recalculo).
    *==========================================================================
    PROCEDURE GrdFontesAfterRowColChange(par_nColIndex)
        THIS.RecalcularTotaisFontes()
    ENDPROC

    *==========================================================================
    * RecalcularTotaisFontes - Soma Count(1)/Sum(JBI_Valors) por EmpDopNums,
    * igual ao legado (grdFontes.AfterRowColChange), e espelha nos
    * totalizadores txt_4c_TotFontes/txt_4c_TotValores.
    *==========================================================================
    PROCEDURE RecalcularTotaisFontes()
        LOCAL loc_cAlias, loc_nSoma, loc_nValors, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
        IF !USED(loc_cAlias)
            RETURN
        ENDIF

        TRY
            SELECT empdopnums, COUNT(1) AS Soma, SUM(jbi_valors) AS Valors ;
                FROM (loc_cAlias) ;
                GROUP BY empdopnums ;
                INTO CURSOR cursor_4c_FontesTot

            IF RECCOUNT("cursor_4c_FontesTot") > 0
                GO TOP IN cursor_4c_FontesTot
                loc_nSoma   = cursor_4c_FontesTot.Soma
                loc_nValors = cursor_4c_FontesTot.Valors
            ELSE
                loc_nSoma   = 0
                loc_nValors = 0
            ENDIF

            IF USED("cursor_4c_FontesTot")
                USE IN cursor_4c_FontesTot
            ENDIF

            THIS.pgf_4c_Job.Page5.txt_4c_TotFontes.Value  = TRANSFORM(loc_nSoma, "999,999,999")
            THIS.pgf_4c_Job.Page5.txt_4c_TotValores.Value = TRANSFORM(loc_nValors, "999,999,999,999.99")
            THIS.pgf_4c_Job.Page5.txt_4c_TotFontes.Refresh()
            THIS.pgf_4c_Job.Page5.txt_4c_TotValores.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RecalcularTotaisFontes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Espelha as propriedades this_* do BO nos controles da tela.
    * NESTA FASE cobre o cabecalho de identificacao do Job (raiz do form),
    * Page1 (Briefing), Page2 (Desafio/Objetivos) e Page3 (Equipes). As
    * paginas restantes (Materiais/Financeiro/Apresentacao) sao adicionadas
    * nas proximas fases e este metodo sera estendido junto.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPag1, loc_oPag2, loc_oPag3, loc_oCnt1, loc_oCnt2, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oPag1 = THIS.pgf_4c_Job.Page1
            loc_oPag2 = THIS.pgf_4c_Job.Page2

            *-- Page1 - Briefing
            loc_oPag1.txt_4c__01_001.Value = ConverterParaData(loc_oBO.this_dJb001)
            loc_oPag1.txt_4c__01_002.Value = ConverterParaData(loc_oBO.this_dJb002)
            loc_oPag1.obj_4c_Get_01_003.Value = loc_oBO.this_cJb003
            loc_oPag1.obj_4c_Get_01_004.Value = loc_oBO.this_cJb004
            loc_oPag1.obj_4c_Get_01_005.Value = loc_oBO.this_cJb005
            loc_oPag1.obj_4c_Get_01_006.Value = loc_oBO.this_cJb006
            loc_oPag1.obj_4c_Get_01_007.Value = loc_oBO.this_cJb007
            loc_oPag1.obj_4c_Get_01_008.Value = loc_oBO.this_cJb008
            loc_oPag1.txt_4c__01_017.Value = ConverterParaData(loc_oBO.this_dJb017)
            loc_oPag1.txt_4c__01_018.Value = ConverterParaData(loc_oBO.this_dJb018)
            loc_oPag1.txt_4c__01_019.Value = ConverterParaData(loc_oBO.this_dJb019)
            loc_oPag1.txt_4c__01_020.Value = ConverterParaData(loc_oBO.this_dJb020)
            loc_oPag1.obj_4c_Get_01_021.Value = loc_oBO.this_cJb021
            loc_oPag1.obj_4c_Get_01_022.Value = loc_oBO.this_cJb022
            loc_oPag1.obj_4c_Get_01_023.Value = loc_oBO.this_cJb023

            *-- Page2 - Desafio / Objetivos
            loc_oPag2.obj_4c_Get_01_009.Value = loc_oBO.this_cJb009
            loc_oPag2.obj_4c_Get_01_010.Value = loc_oBO.this_cJb010
            loc_oPag2.obj_4c_Get_01_011.Value = loc_oBO.this_cJb011
            loc_oPag2.obj_4c_Get_01_012.Value = loc_oBO.this_cJb012
            loc_oPag2.obj_4c_Get_01_013.Value = loc_oBO.this_cJb013
            loc_oPag2.obj_4c_Get_01_014.Value = loc_oBO.this_cJb014
            loc_oPag2.obj_4c_Get_01_015.Value = loc_oBO.this_cJb015
            loc_oPag2.obj_4c_Get_01_016.Value = loc_oBO.this_cJb016

            *-- Raiz do form - "Briefing Extra" (Jb_072, numeric(1,0)).
            *-- CheckBox.Value eh NUMERICO: comparar explicitamente, nunca
            *-- atribuir a property direto (IIF exige condicao LOGICA).
            THIS.chk_4c_Get_Extra.Value = IIF(loc_oBO.this_nJb072 = 1, 1, 0)

            *-- Page3 - Equipes (codigos) e classificacao do Job
            loc_oPag3 = THIS.pgf_4c_Job.Page3
            loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
            loc_oCnt2 = loc_oPag3.cnt_4c_Emp2

            loc_oCnt1.txt_4c__01_024.Value = loc_oBO.this_cJb024
            loc_oCnt1.txt_4c__01_025.Value = loc_oBO.this_cJb025
            loc_oCnt1.txt_4c__01_026.Value = loc_oBO.this_cJb026
            loc_oCnt1.txt_4c__01_027.Value = loc_oBO.this_cJb027
            loc_oCnt1.txt_4c__01_028.Value = loc_oBO.this_cJb028
            loc_oCnt1.txt_4c__01_029.Value = loc_oBO.this_cJb029
            loc_oCnt1.txt_4c__01_030.Value = loc_oBO.this_cJb030

            loc_oCnt2.txt_4c__01_031.Value = loc_oBO.this_cJb031
            loc_oCnt2.txt_4c__01_032.Value = loc_oBO.this_cJb032
            loc_oCnt2.txt_4c__01_033.Value = loc_oBO.this_cJb033
            loc_oCnt2.txt_4c__01_034.Value = loc_oBO.this_cJb034
            loc_oCnt2.txt_4c__01_035.Value = loc_oBO.this_cJb035
            loc_oCnt2.txt_4c__01_036.Value = loc_oBO.this_cJb036
            loc_oCnt2.txt_4c__01_037.Value = loc_oBO.this_cJb037

            loc_oPag3.chk_4c_Get_01_038.Value = IIF(loc_oBO.this_nJb038 = 1, 1, 0)
            loc_oPag3.chk_4c_Get_01_039.Value = IIF(loc_oBO.this_nJb039 = 1, 1, 0)
            loc_oPag3.chk_4c_Get_01_040.Value = IIF(loc_oBO.this_nJb040 = 1, 1, 0)
            loc_oPag3.chk_4c_Get_01_041.Value = IIF(loc_oBO.this_nJb041 = 1, 1, 0)
            loc_oPag3.chk_4c_Get_01_042.Value = IIF(loc_oBO.this_nJb042 = 1, 1, 0)
            loc_oPag3.chk_4c_Get_01_043.Value = IIF(loc_oBO.this_nJb043 = 1, 1, 0)
            loc_oPag3.chk_4c_Get_01_044.Value = IIF(loc_oBO.this_nJb044 = 1, 1, 0)

            *-- Os campos de NOME da Page3 nao tem ControlSource no legado:
            *-- vem de SigCdCli.RClis pelo codigo de cada linha.
            THIS.CarregarNomesEquipes()

            *-- Page4 - Materiais de Apoio (caminhos de pasta/arquivo)
            THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045.Value = loc_oBO.this_cJb045
            THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046.Value = loc_oBO.this_cJb046
            THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047.Value = loc_oBO.this_cJb047
            THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048.Value = loc_oBO.this_cJb048
            THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061.Value = loc_oBO.this_cJb061
            THIS.pgf_4c_Job.Page4.obj_4c_Get_01_058.Value = loc_oBO.this_cJb058

            *-- Page5 - Modelo Fiscal / Fontes Pagadoras
            THIS.pgf_4c_Job.Page5.obj_4c_Get_01_062.Value = loc_oBO.this_cJb062
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_063.Value = IIF(loc_oBO.this_nJb063 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_064.Value = IIF(loc_oBO.this_nJb064 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_065.Value = IIF(loc_oBO.this_nJb065 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_066.Value = IIF(loc_oBO.this_nJb066 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_067.Value = IIF(loc_oBO.this_nJb067 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_068.Value = IIF(loc_oBO.this_nJb068 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_069.Value = IIF(loc_oBO.this_nJb069 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.chk_4c_Get_01_075.Value = IIF(loc_oBO.this_nJb075 = 1, 1, 0)
            THIS.pgf_4c_Job.Page5.obj_4c_Get_01_070.Value = TRANSFORM(loc_oBO.this_nJb070)
            THIS.pgf_4c_Job.Page5.obj_4c_Get_01_071.Value = loc_oBO.this_cJb071

            *-- Page6 - Apresentacao / Propostas / Documentos
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_049.Value = IIF(loc_oBO.this_nJb049 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_050.Value = IIF(loc_oBO.this_nJb050 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_051.Value = IIF(loc_oBO.this_nJb051 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_052.Value = IIF(loc_oBO.this_nJb052 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_053.Value = IIF(loc_oBO.this_nJb053 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.obj_4c_Get_01_073.Value = loc_oBO.this_cJb073
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_054.Value = IIF(loc_oBO.this_nJb054 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_055.Value = IIF(loc_oBO.this_nJb055 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.chk_4c_Get_01_056.Value = IIF(loc_oBO.this_nJb056 = 1, 1, 0)
            THIS.pgf_4c_Job.Page6.obj_4c_Get_01_074.Value = loc_oBO.this_cJb074
            THIS.pgf_4c_Job.Page6.obj_4c_Get_01_057.Value = loc_oBO.this_cJb057

            *-- Aplica o When dos 14 campos de nome da Page3 depois de todos os
            *-- codigos estarem na tela (regra #45.3: regra de dependencia num
            *-- metodo unico, chamado no fim do funil de carga).
            THIS.AtualizarEstadoContasEquipe()

            *-- Aplica o When dos demais campos gatilhados por modo
            *-- (Page1/Page4/raiz - ver HabilitarCampos).
            THIS.HabilitarCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Aplica o "PROCEDURE When" do legado aos campos que so
    * ficam editaveis em INCLUIR/ALTERAR. BINDEVENT em "When" nao funciona
    * (regra #45.3 - o retorno do delegate eh descartado e nao bloqueia a
    * edicao), entao a gate vira .Enabled direto, aplicado uma vez a partir
    * do BOParaForm - este dialogo nao troca de modo depois de aberto
    * (this_cModoAtual vem do form pai no Init e fica fixo pelo resto da
    * vida do form, nao ha AlternarPagina/troca de modo em runtime aqui).
    *
    * Campos SEM When no dump (todos os outros TextBox/EditBox/CheckBox de
    * Jb_003..016, 021..023, 024..044, 049..058, 062..075) ficam sempre
    * editaveis, inclusive em VISUALIZAR - nao inventar gate que o legado
    * nao tem (PILAR 1). A grade "Fontes Pagadoras" ja tem seu proprio guard
    * (GrdFontesColumnWhen) e as equipes da Page3 o seu
    * (AtualizarEstadoContasEquipe/AjustarNomeContaEquipe).
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos()
        LOCAL loc_lModoEdicao, loc_oPag1, loc_oPag4, loc_oErro
        loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            *-- Page1 - as 2 datas de Apresentacao/Orcamento e as 4 do
            *-- Periodo do Evento/Montagem (legado: get_01_001/002/017..020)
            loc_oPag1 = THIS.pgf_4c_Job.Page1
            loc_oPag1.txt_4c__01_001.Enabled = loc_lModoEdicao
            loc_oPag1.txt_4c__01_002.Enabled = loc_lModoEdicao
            loc_oPag1.txt_4c__01_017.Enabled = loc_lModoEdicao
            loc_oPag1.txt_4c__01_018.Enabled = loc_lModoEdicao
            loc_oPag1.txt_4c__01_019.Enabled = loc_lModoEdicao
            loc_oPag1.txt_4c__01_020.Enabled = loc_lModoEdicao

            *-- Page4 - botoes "..." (GetDir) dos 5 campos de pasta/arquivo.
            *-- O botao "Abrir" (b) nao tem When no dump - so le o caminho e
            *-- abre o Explorer, inofensivo em qualquer modo; o EditBox e
            *-- ReadOnly sempre (AdicionarCampoPastaMaterial), nao precisa
            *-- gate por modo.
            loc_oPag4 = THIS.pgf_4c_Job.Page4
            loc_oPag4.cmd_4c_Btn_01_045.Enabled = loc_lModoEdicao
            loc_oPag4.cmd_4c_Btn_01_046.Enabled = loc_lModoEdicao
            loc_oPag4.cmd_4c_Btn_01_047.Enabled = loc_lModoEdicao
            loc_oPag4.cmd_4c_Btn_01_048.Enabled = loc_lModoEdicao
            loc_oPag4.cmd_4c_Btn_01_061.Enabled = loc_lModoEdicao

            *-- Raiz do form - Contatos com o Cliente (legado: getCabContatos)
            THIS.obj_4c_GetCabContatos.Enabled = loc_lModoEdicao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Le os controles da tela para as propriedades this_* do BO.
    * NESTA FASE cobre "Briefing Extra" (raiz), Page1 (Briefing), Page2
    * (Desafio/Objetivos) e Page3 (Equipes) - ver comentario de BOParaForm
    * sobre a extensao nas proximas fases.
    *
    * Os getCab* do cabecalho NAO entram aqui: sao somente-leitura e seus
    * valores vem de SigMvCab/SigCdCli, nao de colunas de SigMvJbC.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPag1, loc_oPag2, loc_oPag3, loc_oCnt1, loc_oCnt2, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oPag1 = THIS.pgf_4c_Job.Page1
            loc_oPag2 = THIS.pgf_4c_Job.Page2

            *-- Page1 - Briefing
            loc_oBO.this_dJb001 = ConverterParaData(loc_oPag1.txt_4c__01_001.Value)
            loc_oBO.this_dJb002 = ConverterParaData(loc_oPag1.txt_4c__01_002.Value)
            loc_oBO.this_cJb003 = loc_oPag1.obj_4c_Get_01_003.Value
            loc_oBO.this_cJb004 = loc_oPag1.obj_4c_Get_01_004.Value
            loc_oBO.this_cJb005 = loc_oPag1.obj_4c_Get_01_005.Value
            loc_oBO.this_cJb006 = loc_oPag1.obj_4c_Get_01_006.Value
            loc_oBO.this_cJb007 = loc_oPag1.obj_4c_Get_01_007.Value
            loc_oBO.this_cJb008 = loc_oPag1.obj_4c_Get_01_008.Value
            loc_oBO.this_dJb017 = ConverterParaData(loc_oPag1.txt_4c__01_017.Value)
            loc_oBO.this_dJb018 = ConverterParaData(loc_oPag1.txt_4c__01_018.Value)
            loc_oBO.this_dJb019 = ConverterParaData(loc_oPag1.txt_4c__01_019.Value)
            loc_oBO.this_dJb020 = ConverterParaData(loc_oPag1.txt_4c__01_020.Value)
            loc_oBO.this_cJb021 = loc_oPag1.obj_4c_Get_01_021.Value
            loc_oBO.this_cJb022 = loc_oPag1.obj_4c_Get_01_022.Value
            loc_oBO.this_cJb023 = loc_oPag1.obj_4c_Get_01_023.Value

            *-- Page2 - Desafio / Objetivos
            loc_oBO.this_cJb009 = loc_oPag2.obj_4c_Get_01_009.Value
            loc_oBO.this_cJb010 = loc_oPag2.obj_4c_Get_01_010.Value
            loc_oBO.this_cJb011 = loc_oPag2.obj_4c_Get_01_011.Value
            loc_oBO.this_cJb012 = loc_oPag2.obj_4c_Get_01_012.Value
            loc_oBO.this_cJb013 = loc_oPag2.obj_4c_Get_01_013.Value
            loc_oBO.this_cJb014 = loc_oPag2.obj_4c_Get_01_014.Value
            loc_oBO.this_cJb015 = loc_oPag2.obj_4c_Get_01_015.Value
            loc_oBO.this_cJb016 = loc_oPag2.obj_4c_Get_01_016.Value

            *-- Raiz do form - "Briefing Extra" (Jb_072, numeric(1,0))
            loc_oBO.this_nJb072 = IIF(THIS.chk_4c_Get_Extra.Value = 1, 1, 0)

            *-- Page3 - Equipes (codigos) e classificacao do Job.
            *-- Apenas os campos de CODIGO voltam para o BO: os campos de NOME
            *-- (txt_4c__01_0NNa) nao tem coluna em SigMvJbC - no legado
            *-- tambem nao tem ControlSource, sao exibicao de SigCdCli.RClis.
            *-- As colunas Jb_024..037 sao char(10) NOT NULL: ALLTRIM aqui
            *-- (o SQL Server faz blank-padding ANSI em char) e o INSERT/UPDATE
            *-- do BO fecha com PADR(..., 10), o MESMO tamanho do .MaxLength
            *-- destes TextBox.
            loc_oPag3 = THIS.pgf_4c_Job.Page3
            loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
            loc_oCnt2 = loc_oPag3.cnt_4c_Emp2

            loc_oBO.this_cJb024 = ALLTRIM(loc_oCnt1.txt_4c__01_024.Value)
            loc_oBO.this_cJb025 = ALLTRIM(loc_oCnt1.txt_4c__01_025.Value)
            loc_oBO.this_cJb026 = ALLTRIM(loc_oCnt1.txt_4c__01_026.Value)
            loc_oBO.this_cJb027 = ALLTRIM(loc_oCnt1.txt_4c__01_027.Value)
            loc_oBO.this_cJb028 = ALLTRIM(loc_oCnt1.txt_4c__01_028.Value)
            loc_oBO.this_cJb029 = ALLTRIM(loc_oCnt1.txt_4c__01_029.Value)
            loc_oBO.this_cJb030 = ALLTRIM(loc_oCnt1.txt_4c__01_030.Value)

            loc_oBO.this_cJb031 = ALLTRIM(loc_oCnt2.txt_4c__01_031.Value)
            loc_oBO.this_cJb032 = ALLTRIM(loc_oCnt2.txt_4c__01_032.Value)
            loc_oBO.this_cJb033 = ALLTRIM(loc_oCnt2.txt_4c__01_033.Value)
            loc_oBO.this_cJb034 = ALLTRIM(loc_oCnt2.txt_4c__01_034.Value)
            loc_oBO.this_cJb035 = ALLTRIM(loc_oCnt2.txt_4c__01_035.Value)
            loc_oBO.this_cJb036 = ALLTRIM(loc_oCnt2.txt_4c__01_036.Value)
            loc_oBO.this_cJb037 = ALLTRIM(loc_oCnt2.txt_4c__01_037.Value)

            loc_oBO.this_nJb038 = IIF(loc_oPag3.chk_4c_Get_01_038.Value = 1, 1, 0)
            loc_oBO.this_nJb039 = IIF(loc_oPag3.chk_4c_Get_01_039.Value = 1, 1, 0)
            loc_oBO.this_nJb040 = IIF(loc_oPag3.chk_4c_Get_01_040.Value = 1, 1, 0)
            loc_oBO.this_nJb041 = IIF(loc_oPag3.chk_4c_Get_01_041.Value = 1, 1, 0)
            loc_oBO.this_nJb042 = IIF(loc_oPag3.chk_4c_Get_01_042.Value = 1, 1, 0)
            loc_oBO.this_nJb043 = IIF(loc_oPag3.chk_4c_Get_01_043.Value = 1, 1, 0)
            loc_oBO.this_nJb044 = IIF(loc_oPag3.chk_4c_Get_01_044.Value = 1, 1, 0)

            *-- Page4 - Materiais de Apoio (caminhos de pasta/arquivo)
            loc_oBO.this_cJb045 = THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045.Value
            loc_oBO.this_cJb046 = THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046.Value
            loc_oBO.this_cJb047 = THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047.Value
            loc_oBO.this_cJb048 = THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048.Value
            loc_oBO.this_cJb061 = THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061.Value
            loc_oBO.this_cJb058 = THIS.pgf_4c_Job.Page4.obj_4c_Get_01_058.Value

            *-- Page5 - Modelo Fiscal / Fontes Pagadoras
            loc_oBO.this_cJb062 = THIS.pgf_4c_Job.Page5.obj_4c_Get_01_062.Value
            loc_oBO.this_nJb063 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_063.Value = 1, 1, 0)
            loc_oBO.this_nJb064 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_064.Value = 1, 1, 0)
            loc_oBO.this_nJb065 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_065.Value = 1, 1, 0)
            loc_oBO.this_nJb066 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_066.Value = 1, 1, 0)
            loc_oBO.this_nJb067 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_067.Value = 1, 1, 0)
            loc_oBO.this_nJb068 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_068.Value = 1, 1, 0)
            loc_oBO.this_nJb069 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_069.Value = 1, 1, 0)
            loc_oBO.this_nJb075 = IIF(THIS.pgf_4c_Job.Page5.chk_4c_Get_01_075.Value = 1, 1, 0)
            loc_oBO.this_nJb070 = ALLTRIM(THIS.pgf_4c_Job.Page5.obj_4c_Get_01_070.Value)
            loc_oBO.this_cJb071 = THIS.pgf_4c_Job.Page5.obj_4c_Get_01_071.Value

            *-- Page6 - Apresentacao / Propostas / Documentos
            loc_oBO.this_nJb049 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_049.Value = 1, 1, 0)
            loc_oBO.this_nJb050 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_050.Value = 1, 1, 0)
            loc_oBO.this_nJb051 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_051.Value = 1, 1, 0)
            loc_oBO.this_nJb052 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_052.Value = 1, 1, 0)
            loc_oBO.this_nJb053 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_053.Value = 1, 1, 0)
            loc_oBO.this_cJb073 = ALLTRIM(THIS.pgf_4c_Job.Page6.obj_4c_Get_01_073.Value)
            loc_oBO.this_nJb054 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_054.Value = 1, 1, 0)
            loc_oBO.this_nJb055 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_055.Value = 1, 1, 0)
            loc_oBO.this_nJb056 = IIF(THIS.pgf_4c_Job.Page6.chk_4c_Get_01_056.Value = 1, 1, 0)
            loc_oBO.this_cJb074 = ALLTRIM(THIS.pgf_4c_Job.Page6.obj_4c_Get_01_074.Value)
            loc_oBO.this_cJb057 = THIS.pgf_4c_Job.Page6.obj_4c_Get_01_057.Value
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles criados via
    * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame
    * e Controls de Container/CommandGroup recursivamente.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- cnt_4c_Emp1/cnt_4c_Emp2 (Page3) tem a visibilidade decidida
                *-- por regra de negocio (AplicarVisibilidadeEquipes, conforme
                *-- SigCdEmp.divnotas) - excluidos aqui para nao forcar
                *-- Visible=.T. e depender da ordem de chamada no Init para
                *-- a regra ser desfeita depois.
                IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
                   !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_EMP1", "CNT_4C_EMP2")
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
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
    * VincularChecagemObrigatorios - Liga ChecarCamposObrigatorios ao
    * LostFocus de todo campo digitavel/marcavel da tela.
    *
    * No SCX legado isso esta escrito campo a campo: ~60 "PROCEDURE
    * LostFocus" cujo corpo e' uma linha so, "ThisForm.ChecaObrigs()". O
    * efeito e' que QUALQUER saida de campo repinta a marcacao de
    * obrigatoriedade; reproduzir por varredura da arvore de controles da o
    * mesmo resultado sem repetir 60 BINDEVENTs, e nao pode divergir da
    * lista de campos quando uma aba mudar.
    *
    * LostFocus (nao KeyPress): o legado valida ao SAIR do campo, e o
    * handler nao testa tecla nenhuma (regra #47). ChecarCamposObrigatorios
    * nao tem parametros - LostFocus nao passa nenhum.
    *
    * O Grid fica de FORA: as celulas tem funil proprio
    * (GrdFontesColumn4Valid / GrdFontesAfterRowColChange) e o legado nao
    * liga ChecaObrigs a nenhuma coluna da grade.
    *
    * Os campos de conta da Page3 ganham um SEGUNDO delegate aqui, somado ao
    * ValidarConta0NN/ValidarNomeConta0NN que ja tinham - exatamente como no
    * legado, em que get_01_0NN declara Valid (lookup) E LostFocus
    * (ChecaObrigs). Como este BINDEVENT e' registrado DEPOIS, ele roda
    * DEPOIS do lookup, isto e' com o campo ja resolvido.
    *==========================================================================
    PROTECTED PROCEDURE VincularChecagemObrigatorios(par_oContainer)
        LOCAL loc_nI, loc_oObj, loc_cBase, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObj) = "O"
                loc_cBase = UPPER(loc_oObj.BaseClass)

                DO CASE
                    CASE loc_cBase = "GRID"
                        *-- grade tem funil proprio - ver comentario acima

                    CASE INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "CHECKBOX")
                        BINDEVENT(loc_oObj, "LostFocus", THIS, "ChecarCamposObrigatorios")

                    CASE loc_cBase = "PAGEFRAME"
                        FOR loc_nP = 1 TO loc_oObj.PageCount
                            THIS.VincularChecagemObrigatorios(loc_oObj.Pages(loc_nP))
                        ENDFOR

                    OTHERWISE
                        IF PEMSTATUS(loc_oObj, "ControlCount", 5)
                            IF loc_oObj.ControlCount > 0
                                THIS.VincularChecagemObrigatorios(loc_oObj)
                            ENDIF
                        ENDIF
                ENDCASE
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ResolverControle - Devolve o objeto de controle no caminho
    * par_cCaminho, SEMPRE relativo a THIS.pgf_4c_Job (ex.:
    * "Page1.txt_4c__01_001", "Page3.cnt_4c_Emp1.txt_4c__01_024").
    *
    * Alcancar membro por NOME em VFP9 se faz com EVALUATE na LEITURA
    * (regra #15/#34) - Controls("nome") estoura, e PEMSTATUS nao protege.
    * O TYPE() antes do EVALUATE evita TRY/CATCH: caminho invalido devolve
    * "U" sem erro, e CATCH aqui seria silencioso ou ruidoso demais (este
    * metodo roda em laco de 69 posicoes).
    *
    * Devolve .NULL. quando o controle nao existe - acontece legitimamente
    * em probe/harness, em que parte da tela pode nao ter sido criada.
    *==========================================================================
    PROTECTED FUNCTION ResolverControle(par_cCaminho)
        LOCAL loc_cExpr

        IF VARTYPE(par_cCaminho) != "C"
            RETURN .NULL.
        ENDIF
        IF EMPTY(par_cCaminho)
            RETURN .NULL.
        ENDIF

        loc_cExpr = "THIS.pgf_4c_Job." + ALLTRIM(par_cCaminho)
        IF TYPE(loc_cExpr) != "O"
            RETURN .NULL.
        ENDIF

        RETURN EVALUATE(loc_cExpr)
    ENDFUNC

    *==========================================================================
    * CampoPreenchido - O controle em par_cCaminho tem conteudo?
    * Equivale a "Not IsEmpty(crSigMvJbC.Jb_NNN)" do legado.
    *
    * Le o CONTROLE, nao a property do BO, porque ChecarCamposObrigatorios
    * roda a cada LostFocus - ANTES de FormParaBO - e a property ainda tem o
    * valor anterior. No legado o TextBox tem ControlSource para o cursor
    * buffered, entao ler o cursor ja era ler o valor na tela; aqui o
    * equivalente fiel e' ler o proprio controle.
    *
    * Controle ausente devolve .T. (nao bloqueia): mesma postura do legado,
    * que nem chega a testar indice cujo laCpo esta vazio.
    *==========================================================================
    PROTECTED FUNCTION CampoPreenchido(par_cCaminho)
        LOCAL loc_oCtrl, loc_uValor

        loc_oCtrl = THIS.ResolverControle(par_cCaminho)
        IF VARTYPE(loc_oCtrl) != "O"
            RETURN .T.
        ENDIF
        IF !PEMSTATUS(loc_oCtrl, "Value", 5)
            RETURN .T.
        ENDIF

        loc_uValor = loc_oCtrl.Value
        IF VARTYPE(loc_uValor) = "C"
            RETURN !EMPTY(ALLTRIM(loc_uValor))
        ENDIF

        RETURN !EMPTY(loc_uValor)
    ENDFUNC

    *==========================================================================
    * ValorCheck - Valor NUMERICO do CheckBox em par_cCaminho (0 ou 1), para
    * as somas de grupo do legado ("crSigMvJbC.Jb_038 + Jb_039 + ... <> 0").
    * CheckBox.Value e' numerico no projeto (nunca .T./.F.); o VARTYPE cobre
    * o caso de um driver/estado devolver logico.
    *==========================================================================
    PROTECTED FUNCTION ValorCheck(par_cCaminho)
        LOCAL loc_oCtrl, loc_uValor

        loc_oCtrl = THIS.ResolverControle(par_cCaminho)
        IF VARTYPE(loc_oCtrl) != "O"
            RETURN 0
        ENDIF
        IF !PEMSTATUS(loc_oCtrl, "Value", 5)
            RETURN 0
        ENDIF

        loc_uValor = loc_oCtrl.Value
        IF VARTYPE(loc_uValor) = "N"
            RETURN loc_uValor
        ENDIF
        IF VARTYPE(loc_uValor) = "L"
            RETURN IIF(loc_uValor, 1, 0)
        ENDIF

        RETURN 0
    ENDFUNC

    *==========================================================================
    * MarcarCampoObrigatorio - Pinta o controle de par_cCaminho de AZUL
    * (atendido) ou VERMELHO (em falta), exatamente como o legado:
    *   Iif(llOks, Rgb(36,84,155), Rgb(255,0,0))
    *
    * par_cPropriedade: "F" pinta ForeColor (rotulo de grupo de CheckBox),
    * qualquer outro valor pinta BorderColor (campo digitavel) - mesma
    * divisao que o legado faz entre os Case de grupo e os demais.
    *
    * PEMSTATUS antes de atribuir porque propriedade que a classe nao tem
    * estoura em runtime e derruba a tela (regra #33).
    *==========================================================================
    PROTECTED PROCEDURE MarcarCampoObrigatorio(par_cCaminho, par_lOk, par_cPropriedade)
        LOCAL loc_oCtrl, loc_nCor

        loc_oCtrl = THIS.ResolverControle(par_cCaminho)
        IF VARTYPE(loc_oCtrl) != "O"
            RETURN
        ENDIF

        loc_nCor = IIF(par_lOk, RGB(36, 84, 155), RGB(255, 0, 0))

        IF par_cPropriedade = "F"
            IF PEMSTATUS(loc_oCtrl, "ForeColor", 5)
                loc_oCtrl.ForeColor = loc_nCor
            ENDIF
        ELSE
            IF PEMSTATUS(loc_oCtrl, "BorderColor", 5)
                loc_oCtrl.BorderColor = loc_nCor
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ChecarCamposObrigatorios - Transcricao de "PROCEDURE checaobrigs" do
    * SCX legado. Devolve "OK" ou "ERRO" e, no caminho, PINTA cada campo
    * conferido de azul (atendido) ou vermelho (em falta).
    *
    * A obrigatoriedade NAO esta no codigo: vem da MASCARA POSICIONAL
    * SigOpCdI.job_mv_obr, em que o caractere da posicao N vale "1" quando o
    * campo N desta lista e obrigatorio NESTA operacao
    * (BO.CampoObrigatorio). Sem mascara carregada nada e' obrigatorio e o
    * metodo devolve "OK" pintando tudo de azul - comportamento neutro.
    *
    * A lista de 69 posicoes e a ORDEM dela sao regra de negocio: e' a
    * mascara que as indexa, logo reordenar ou "compactar" os indices vagos
    * muda qual campo cada "1" da mascara torna obrigatorio (regra #17 -
    * transcrever, nunca reescrever). Por isso os indices sem campo proprio
    * (membros de grupo de CheckBox, conferidos pelo rotulo do grupo) ficam
    * EXPLICITOS na lista, com caminho vazio, em vez de omitidos.
    *
    * DUAS PECULIARIDADES DO LEGADO, PRESERVADAS DE PROPOSITO:
    *
    * 1. O indice 65 ("Outras Receitas") le a mascara na posicao 69, nao na
    *    65 - "Substr(Nvl(crSigOpCdI.JOB_MV_OBR, []), 69, 1)" esta escrito
    *    literalmente assim no SCX.
    *
    * 2. As duas guardas que deveriam DISPENSAR os campos de equipe quando o
    *    bloco esta oculto estao escritas no SCX como
    *    "If InList(22, 23, 24, 25, 26, 27, 28) And Not ...cntEmp1.Visible" -
    *    sem "lnCnt" como primeiro argumento. InList(22, 23, ..., 28) testa
    *    se 22 esta em {23..28}, ou seja e' SEMPRE .F., e a dispensa nunca
    *    acontece no legado. Reproduzido como esta (e nao "corrigido"):
    *    ativar a dispensa mudaria quais campos bloqueiam o retorno, que e'
    *    justamente a regra que esta mascara existe para definir. A terceira
    *    InList do mesmo bloco traz "lnCnt" e funciona - e' ela que pinta
    *    tambem o campo de NOME da linha de equipe.
    *
    * PUBLIC: chamado por BINDEVENT nos LostFocus dos campos (regra #3) e
    * por CmdRetornarClick.
    *==========================================================================
    PROCEDURE ChecarCamposObrigatorios()
        LOCAL loc_cRet, loc_lOks, loc_nI, loc_oBO, loc_lObrig, loc_oErro
        LOCAL ARRAY loc_aCpo[69]

        loc_cRet = "OK"

        *-- RETURN fora do TRY (regra #1)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN loc_cRet
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        *-- Caminhos relativos a THIS.pgf_4c_Job, na MESMA ordem do laCpo
        *-- legado. "" = indice sem campo proprio (membro de grupo).
        *-- Pagina 1 (Briefing)
        loc_aCpo[01] = "Page1.txt_4c__01_001"              && Apresentacao
        loc_aCpo[02] = "Page1.txt_4c__01_002"              && Orcamento
        loc_aCpo[03] = "Page1.txt_4c__01_017"              && Periodo do Evento
        loc_aCpo[04] = "Page1.txt_4c__01_019"              && Periodo de Montagem
        loc_aCpo[05] = "Page1.obj_4c_Get_01_022"           && Publico Estimado
        loc_aCpo[06] = "Page1.obj_4c_Get_01_023"           && Budget Estimado
        loc_aCpo[07] = "Page1.obj_4c_Get_01_021"           && Local do Evento
        loc_aCpo[08] = "Page1.obj_4c_Get_01_003"           && Sobre o que estamos falando
        loc_aCpo[09] = "Page1.obj_4c_Get_01_004"           && Historico
        loc_aCpo[10] = "Page1.obj_4c_Get_01_005"           && Contexto Mercadologico
        loc_aCpo[11] = "Page1.obj_4c_Get_01_006"           && Cenario
        loc_aCpo[12] = "Page1.obj_4c_Get_01_007"           && Target
        loc_aCpo[13] = "Page1.obj_4c_Get_01_008"           && O problema
        *-- Pagina 2 (Briefing Continuacao)
        loc_aCpo[14] = "Page2.obj_4c_Get_01_009"           && Desafio
        loc_aCpo[15] = "Page2.obj_4c_Get_01_010"           && Objetivos
        loc_aCpo[16] = "Page2.obj_4c_Get_01_011"           && Tom de voz
        loc_aCpo[17] = "Page2.obj_4c_Get_01_012"           && Inspiracoes
        loc_aCpo[18] = "Page2.obj_4c_Get_01_013"           && Cliente
        loc_aCpo[19] = "Page2.obj_4c_Get_01_014"           && Sugestoes
        loc_aCpo[20] = "Page2.obj_4c_Get_01_015"           && Comunicacao
        loc_aCpo[21] = "Page2.obj_4c_Get_01_016"           && Infos do local do evento
        *-- Pagina 3 (Informacoes Gerais) - bloco de equipe 1
        loc_aCpo[22] = "Page3.cnt_4c_Emp1.txt_4c__01_024"  && Atendimento
        loc_aCpo[23] = "Page3.cnt_4c_Emp1.txt_4c__01_025"  && Comercial
        loc_aCpo[24] = "Page3.cnt_4c_Emp1.txt_4c__01_028"  && Arquiteto
        loc_aCpo[25] = "Page3.cnt_4c_Emp1.txt_4c__01_026"  && Gerencia de Projeto
        loc_aCpo[26] = "Page3.cnt_4c_Emp1.txt_4c__01_029"  && Orcamento
        loc_aCpo[27] = "Page3.cnt_4c_Emp1.txt_4c__01_027"  && Criacao
        loc_aCpo[28] = "Page3.cnt_4c_Emp1.txt_4c__01_030"  && Montagem
        *-- Pagina 3 - bloco de equipe 2
        loc_aCpo[29] = "Page3.cnt_4c_Emp2.txt_4c__01_031"  && Lider de Projeto
        loc_aCpo[30] = "Page3.cnt_4c_Emp2.txt_4c__01_032"  && Atendimento
        loc_aCpo[31] = "Page3.cnt_4c_Emp2.txt_4c__01_035"  && Planejamento
        loc_aCpo[32] = "Page3.cnt_4c_Emp2.txt_4c__01_033"  && Comercial
        loc_aCpo[33] = "Page3.cnt_4c_Emp2.txt_4c__01_036"  && Producao
        loc_aCpo[34] = "Page3.cnt_4c_Emp2.txt_4c__01_034"  && Criacao
        loc_aCpo[35] = "Page3.cnt_4c_Emp2.txt_4c__01_037"  && Producao Financeira
        *-- Pagina 3 - grupos de CheckBox (conferidos pelo rotulo da secao)
        loc_aCpo[36] = "Page3.lbl_4c_Lbl_02_003"           && Tipo de Projeto
        loc_aCpo[37] = ""                                  && Concorrencia
        loc_aCpo[38] = ""                                  && Licitacao
        loc_aCpo[39] = ""                                  && Proprietario
        loc_aCpo[40] = "Page3.lbl_4c_Lbl_02_004"           && Tipo de Desenvolvimento
        loc_aCpo[41] = ""                                  && Producao
        loc_aCpo[42] = ""                                  && Criacao
        *-- Pagina 6 (Apresentacao) - grupos de CheckBox
        loc_aCpo[43] = "Page6.lbl_4c_Lbl_02_005"           && Apresentacao
        loc_aCpo[44] = ""                                  && Eletronica
        loc_aCpo[45] = "Page6.lbl_4c_Lbl_02_006"           && Proposta Comercial
        loc_aCpo[46] = ""                                  && CD 1
        loc_aCpo[47] = ""                                  && Outros 1
        loc_aCpo[48] = "Page6.lbl_4c_Lbl_02_007"           && Proposta Tecnica
        loc_aCpo[49] = ""                                  && CD 2
        loc_aCpo[50] = ""                                  && Outros 2
        *-- Pagina 4 (Informacoes Gerais Continuacao) - pastas e avaliacao
        loc_aCpo[51] = "Page4.obj_4c_Get_01_045"           && Logomarca
        loc_aCpo[52] = "Page4.obj_4c_Get_01_046"           && Manual de Marca
        loc_aCpo[53] = "Page4.obj_4c_Get_01_047"           && Imagens
        loc_aCpo[54] = "Page4.obj_4c_Get_01_048"           && Referencias
        loc_aCpo[55] = "Page4.obj_4c_Get_01_061"           && Atas, emails e correspondencias
        loc_aCpo[56] = "Page6.obj_4c_Get_01_057"           && Documentos Necessarios
        loc_aCpo[57] = "Page4.obj_4c_Get_01_058"           && Avaliacao do Job
        *-- Pagina 5 (Controladoria / Fiscal)
        loc_aCpo[58] = "Page5.lbl_4c_Lbl_02_009"           && Modelo Fiscal (3 CheckBox)
        loc_aCpo[59] = ""                                  && Nota de Debito
        loc_aCpo[60] = ""                                  && NF de Locacao
        loc_aCpo[61] = "Page5.lbl_4c_Lbl_02_009"           && Modelo Fiscal (4 CheckBox)
        loc_aCpo[62] = ""                                  && Incentivo Rouanet
        loc_aCpo[63] = ""                                  && Incentivo ISS
        loc_aCpo[64] = ""                                  && Patrocinio
        loc_aCpo[65] = "Page5.obj_4c_Get_01_070"           && Outras Receitas (mascara pos. 69)
        loc_aCpo[66] = "Page5.obj_4c_Get_01_062"           && Codigo de Atividade
        loc_aCpo[67] = "Page5.obj_4c_Get_01_071"           && Comentarios Financeiros
        *-- 68: o legado aponta [get_Extra] aqui, mas o indice esta na lista
        *-- de "nao valida nada" logo abaixo, entao o caminho nunca e' usado.
        *-- Fica "" de proposito: get_Extra mora na RAIZ do form, nao dentro
        *-- do PageFrame, e os caminhos desta lista sao todos relativos a
        *-- THIS.pgf_4c_Job - preencher com o nome dele criaria um caminho
        *-- que nao resolve.
        loc_aCpo[68] = ""                                  && Briefing Extra (nao validado)
        loc_aCpo[69] = ""                                  && Conta Corrente (Jb_075)

        TRY
            FOR loc_nI = 1 TO 69
                loc_lOks = .T.

                DO CASE
                    *-- Membros de grupo de CheckBox e o "Briefing Extra":
                    *-- o legado nao valida nenhum deles ("Nao Valida Nada
                    *-- Pois Sao os Checkbox Multiplos"). Lista literal do
                    *-- SCX, inclusive 68.
                    *--
                    *-- Em DOIS InList porque o do legado tem 20 valores mais
                    *-- o lnCnt e VFP9 limita os argumentos de INLIST. Os
                    *-- valores 72, 73 e 74 da lista legada ficaram FORA: o
                    *-- laco dela vai so ate lnCpo = 69, logo esses tres nunca
                    *-- sao testados la tambem - omiti-los nao muda nada.
                    CASE INLIST(loc_nI, 37, 38, 39, 41, 42, 44, 46, 47, 49, 50) OR ;
                         INLIST(loc_nI, 59, 60, 62, 63, 64, 68, 69)
                        loc_lOks = .T.

                    CASE loc_nI = 3        && Periodo do Evento - DUAS datas
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = THIS.CampoPreenchido("Page1.txt_4c__01_017") AND ;
                                       THIS.CampoPreenchido("Page1.txt_4c__01_018")
                        ENDIF
                        THIS.MarcarCampoObrigatorio("Page1.txt_4c__01_017", loc_lOks, "B")
                        THIS.MarcarCampoObrigatorio("Page1.txt_4c__01_018", loc_lOks, "B")

                    CASE loc_nI = 4        && Periodo de Montagem - DUAS datas
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = THIS.CampoPreenchido("Page1.txt_4c__01_019") AND ;
                                       THIS.CampoPreenchido("Page1.txt_4c__01_020")
                        ENDIF
                        THIS.MarcarCampoObrigatorio("Page1.txt_4c__01_019", loc_lOks, "B")
                        THIS.MarcarCampoObrigatorio("Page1.txt_4c__01_020", loc_lOks, "B")

                    CASE loc_nI = 36       && Tipo de Projeto (4 CheckBox)
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = (THIS.ValorCheck("Page3.chk_4c_Get_01_038") + ;
                                        THIS.ValorCheck("Page3.chk_4c_Get_01_039") + ;
                                        THIS.ValorCheck("Page3.chk_4c_Get_01_040") + ;
                                        THIS.ValorCheck("Page3.chk_4c_Get_01_041")) != 0
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "F")

                    CASE loc_nI = 40       && Tipo de Desenvolvimento (3 CheckBox)
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = (THIS.ValorCheck("Page3.chk_4c_Get_01_042") + ;
                                        THIS.ValorCheck("Page3.chk_4c_Get_01_043") + ;
                                        THIS.ValorCheck("Page3.chk_4c_Get_01_044")) != 0
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "F")

                    CASE loc_nI = 43       && Apresentacao (2 CheckBox)
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = (THIS.ValorCheck("Page6.chk_4c_Get_01_049") + ;
                                        THIS.ValorCheck("Page6.chk_4c_Get_01_050")) != 0
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "F")

                    CASE loc_nI = 45       && Proposta Comercial (3 CheckBox)
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = (THIS.ValorCheck("Page6.chk_4c_Get_01_051") + ;
                                        THIS.ValorCheck("Page6.chk_4c_Get_01_052") + ;
                                        THIS.ValorCheck("Page6.chk_4c_Get_01_053")) != 0
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "F")

                    CASE loc_nI = 48       && Proposta Tecnica (3 CheckBox)
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = (THIS.ValorCheck("Page6.chk_4c_Get_01_054") + ;
                                        THIS.ValorCheck("Page6.chk_4c_Get_01_055") + ;
                                        THIS.ValorCheck("Page6.chk_4c_Get_01_056")) != 0
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "F")

                    CASE loc_nI = 58       && Modelo Fiscal (Jb_063/064/065/075)
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = (THIS.ValorCheck("Page5.chk_4c_Get_01_063") + ;
                                        THIS.ValorCheck("Page5.chk_4c_Get_01_064") + ;
                                        THIS.ValorCheck("Page5.chk_4c_Get_01_065") + ;
                                        THIS.ValorCheck("Page5.chk_4c_Get_01_075")) != 0
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "F")

                    CASE loc_nI = 61       && Incentivos (Jb_066/067/068/069)
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = (THIS.ValorCheck("Page5.chk_4c_Get_01_066") + ;
                                        THIS.ValorCheck("Page5.chk_4c_Get_01_067") + ;
                                        THIS.ValorCheck("Page5.chk_4c_Get_01_068") + ;
                                        THIS.ValorCheck("Page5.chk_4c_Get_01_069")) != 0
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "F")

                    CASE loc_nI = 65       && Outras Receitas - mascara na posicao 69
                        loc_lObrig = loc_oBO.CampoObrigatorio(69)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = THIS.CampoPreenchido(loc_aCpo[loc_nI])
                        ENDIF
                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "B")

                    OTHERWISE
                        loc_lObrig = loc_oBO.CampoObrigatorio(loc_nI)
                        loc_lOks   = !loc_lObrig
                        IF loc_lObrig
                            loc_lOks = THIS.CampoPreenchido(loc_aCpo[loc_nI])
                        ENDIF

                        THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI], loc_lOks, "B")

                        *-- Linha de equipe: o legado pinta tambem o campo de
                        *-- NOME ao lado ("lcObj = laCpo(lnCnt) + [a]").
                        IF INLIST(loc_nI, 22, 23, 24, 25, 26, 27, 28) OR ;
                           INLIST(loc_nI, 29, 30, 31, 32, 33, 34, 35)
                            THIS.MarcarCampoObrigatorio(loc_aCpo[loc_nI] + "a", loc_lOks, "B")
                        ENDIF
                ENDCASE

                IF loc_cRet = "OK"
                    IF !loc_lOks
                        loc_cRet = "ERRO"
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ChecarCamposObrigatorios")
        ENDTRY

        RETURN loc_cRet
    ENDPROC

    *==========================================================================
    * AplicarTitulosPersonalizados - Transcricao de "PROCEDURE carregatits"
    * (titulos de aba/secao) mais o unico site de job_mv_cpo que o SCX usa
    * (o rotulo do "Briefing Extra", dentro de carregacabs).
    *
    * Cada titulo vive num bloco de 50 caracteres numa POSICAO FIXA de
    * SigOpCdI.job_mv_tit, e o legado so sobrescreve o Caption quando vem
    * texto ("If Not Empty(...)") - sem parametrizacao a tela fica com os
    * captions transcritos do SCX. Mesma postura aqui.
    *
    * A posicao 551 existe no legado e esta COMENTADA la ("Nao Colocado na
    * Tela Ainda"); nao ha controle para ela e por isso nao aparece aqui.
    *==========================================================================
    PROTECTED PROCEDURE AplicarTitulosPersonalizados()
        LOCAL loc_oBO, loc_cTexto, loc_oErro

        *-- RETURN fora do TRY (regra #1)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        TRY
            *-- 101: Caption da Page1 e, com sufixo, da Page2
            loc_cTexto = loc_oBO.ObterTituloPersonalizado(101)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page1.Caption = loc_cTexto
                THIS.pgf_4c_Job.Page2.Caption = loc_cTexto + " Continua" + ;
                                                CHR(231) + CHR(227) + "o"
            ENDIF

            *-- 151 / 201: rotulos dos dois blocos de equipe da Page3
            loc_cTexto = loc_oBO.ObterTituloPersonalizado(151)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.lbl_4c_Lbl_02_001.Caption = loc_cTexto
            ENDIF

            loc_cTexto = loc_oBO.ObterTituloPersonalizado(201)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.lbl_4c_Lbl_02_002.Caption = loc_cTexto
            ENDIF

            *-- 251 / 301: secoes "Tipo de Projeto" e "Tipo de Desenvolvimento"
            loc_cTexto = loc_oBO.ObterTituloPersonalizado(251)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page3.lbl_4c_Lbl_02_003.Caption = loc_cTexto
            ENDIF

            loc_cTexto = loc_oBO.ObterTituloPersonalizado(301)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page3.lbl_4c_Lbl_02_004.Caption = loc_cTexto
            ENDIF

            *-- 351: secao "Infos Clientes" da Page4
            loc_cTexto = loc_oBO.ObterTituloPersonalizado(351)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page4.lbl_4c_Lbl_02_008.Caption = loc_cTexto
            ENDIF

            *-- 401 / 451 / 501: secoes da Page6 (Apresentacao / Proposta
            *-- Comercial / Proposta Tecnica)
            loc_cTexto = loc_oBO.ObterTituloPersonalizado(401)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page6.lbl_4c_Lbl_02_005.Caption = loc_cTexto
            ENDIF

            loc_cTexto = loc_oBO.ObterTituloPersonalizado(451)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page6.lbl_4c_Lbl_02_006.Caption = loc_cTexto
            ENDIF

            loc_cTexto = loc_oBO.ObterTituloPersonalizado(501)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page6.lbl_4c_Lbl_02_007.Caption = loc_cTexto
            ENDIF

            *-- 601: secao "Modelo Fiscal / Consideracoes Financeiras" (Page5)
            loc_cTexto = loc_oBO.ObterTituloPersonalizado(601)
            IF !EMPTY(loc_cTexto)
                THIS.pgf_4c_Job.Page5.lbl_4c_Lbl_02_009.Caption = loc_cTexto
            ENDIF

            *-- job_mv_cpo posicao 3351: rotulo do "Briefing Extra" (raiz do
            *-- form, nao do PageFrame - por isso o caminho e' direto)
            loc_cTexto = loc_oBO.ObterRotuloPersonalizado(3351)
            IF !EMPTY(loc_cTexto)
                THIS.lbl_4c_Lbl_Extra.Caption = loc_cTexto
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AplicarTitulosPersonalizados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AplicarVisibilidadeEquipes - Mostra/esconde os dois blocos de equipe da
    * Page3 conforme SigCdEmp.divnotas da empresa do movimento. Transcricao
    * do "Do Case" do Init legado:
    *
    *   Case (lnEmp = 2) && Um      -> cntEmp1 visivel, cntEmp2 oculto
    *   Case (lnEmp = 3) && Dois    -> cntEmp2 assume o Left de cntEmp1,
    *                                  cntEmp1 oculto, cntEmp2 visivel
    *   Case (lnEmp = 4) && Nenhuma -> os dois ocultos
    *
    * Nao ha "Otherwise": com divnotas 1 (ou qualquer outro valor) o legado
    * deixa os dois blocos como nasceram, e e' o que acontece aqui.
    *
    * TEM DE RODAR DEPOIS DE TornarControlesVisiveis(), que forca
    * Visible = .T. em tudo e apagaria esta regra - mesma armadilha
    * documentada para toda regra de visibilidade por modo.
    *==========================================================================
    PROTECTED PROCEDURE AplicarVisibilidadeEquipes()
        LOCAL loc_oPag, loc_nDiv, loc_oErro

        *-- RETURN fora do TRY (regra #1)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        TRY
            loc_oPag = THIS.pgf_4c_Job.Page3
            loc_nDiv = THIS.this_oBusinessObject.this_nDivNotas

            DO CASE
                CASE loc_nDiv = 2
                    loc_oPag.cnt_4c_Emp1.Visible = .T.
                    loc_oPag.cnt_4c_Emp2.Visible = .F.

                CASE loc_nDiv = 3
                    loc_oPag.cnt_4c_Emp2.Left    = loc_oPag.cnt_4c_Emp1.Left
                    loc_oPag.cnt_4c_Emp1.Visible = .F.
                    loc_oPag.cnt_4c_Emp2.Visible = .T.

                CASE loc_nDiv = 4
                    loc_oPag.cnt_4c_Emp1.Visible = .F.
                    loc_oPag.cnt_4c_Emp2.Visible = .F.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AplicarVisibilidadeEquipes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdRetornarClick - Fecha o dialogo de Complementos do Job (legado:
    * SIGOPJOB.cmdRetornar.btnRetornar.Click). Em INCLUIR/ALTERAR, ANTES de
    * fechar: remove da grade "Fontes Pagadoras" as linhas em branco deixadas
    * pela edicao - transcricao de "Delete From crSigMvJbI Where Empty(
    * JBI_Fontes) Or Empty(JBI_Modelos)" - e GRAVA o complemento (FormParaBO +
    * BO.Salvar() + BO.PersistirFontes()).
    *
    * O legado nao precisa gravar aqui: o TextBox ja esta ligado por
    * ControlSource ao cursor BUFFERED do form pai, e o TableUpdate acontece
    * quando o movimento inteiro e salvo (fora deste dialogo). Nesta
    * arquitetura em camadas o BO grava com SQLEXEC explicito, e so ha um
    * ponto de saida (Retornar) para persistir - fechar sem gravar perderia
    * tudo o que foi digitado. Em VISUALIZAR fecha direto, sem gravar nada
    * (igual ao legado, que tambem so limpa a grade e fecha).
    *
    * Se Salvar()/PersistirFontes() falhar, o dialogo NAO fecha (a falha ja
    * foi exibida pelo proprio BO - regra "CATCH nunca silencioso" /
    * "ExibirFalha") e o usuario pode corrigir e tentar de novo.
    *
    * PUBLIC (BINDEVENT exige - regra #3). THIS.Release() dispara Destroy()
    * na cadeia de heranca, que reabilita THIS.this_oFormPai (equivalente ao
    * "PROCEDURE Release / ThisForm.ParentForm.Enabled = .t." do SCX legado).
    *==========================================================================
    PROCEDURE CmdRetornarClick()
        LOCAL loc_cAlias, loc_lEmEdicao, loc_lSalvou, loc_lProsseguir, loc_oErro
        loc_lEmEdicao   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_lSalvou     = .T.
        loc_lProsseguir = .T.

        *-- Campos obrigatorios em falta: o legado reconfere ChecaObrigs aqui
        *-- (nao confia na marcacao deixada pelos LostFocus) e, se houver
        *-- pendencia, PERGUNTA se o usuario quer corrigir agora. Respondendo
        *-- SIM ele devolve .f. e a tela NAO fecha nem grava - os campos ficam
        *-- vermelhos para conferencia. Respondendo NAO, segue e fecha.
        *-- MsgConfirma devolve LOGICAL, nunca 6 (regra #7).
        IF loc_lEmEdicao
            IF THIS.ChecarCamposObrigatorios() = "ERRO"
                IF MsgConfirma("Existem Campos Obrigat" + CHR(243) + "rios Que N" + CHR(227) + ;
                               "o Foram Preenchidos!!!" + CHR(13) + ;
                               "Esses Campos Est" + CHR(227) + "o Marcados em Vermelho Para Verifica" + ;
                               CHR(231) + CHR(227) + "o" + CHR(13) + ;
                               "E N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
                               "vel Salvar a Movimenta" + CHR(231) + CHR(227) + "o Sem Preench" + ;
                               CHR(234) + "-los." + CHR(13) + ;
                               "Deseja Corrigir Esses Campos Agora?", ;
                               "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- RETURN fora do TRY (regra #1)
        IF !loc_lProsseguir
            RETURN
        ENDIF

        TRY
            IF loc_lEmEdicao AND VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    DELETE FOR EMPTY(jbi_fontes) OR EMPTY(jbi_modelos)
                    GO BOTTOM
                ENDIF

                THIS.FormParaBO()

                loc_lSalvou = THIS.this_oBusinessObject.Salvar()
                IF loc_lSalvou
                    loc_lSalvou = THIS.this_oBusinessObject.PersistirFontes()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSalvou = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmdRetornarClick")
        ENDTRY

        IF loc_lSalvou
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Reabilita o form pai (equivalente ao Click legado de
    * cmdRetornar, repetido aqui para cobrir fechamento pelo X da janela ou
    * ESC) antes de delegar para FormBase.Destroy (libera this_oBusinessObject
    * e restaura o menu principal).
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpJobBO.prg):
*============================================================================
* SigOpJobBO.prg - Business Object para Complementos de Job (SIGOPJOB)
*
* Tabela cabecalho : SigMvJbC  (PK: EmpDopNums char(29) = Emps(3)+Dopes(20)+Str(Numes,6))
* Tabela detalhe   : SigMvJbI  (PK: pkChaves char(20), FK: EmpDopNums char(29)) - grade "Fontes Pagadoras"
* Lookup equipe     : SigCdCli  (PK: Iclis, desc: Rclis) - codigos de atendimento/comercial/etc.
* Lookup empresa    : SigCdEmp  (PK: Cemps, desc: Razas)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpJobBO AS BusinessBase

    *==========================================================================
    * Chave primaria (composta, posicional - ver regra de montagem de chave)
    *==========================================================================
    this_cEmpDopNums = ""    && char(29) NOT NULL - PK (Emps+Dopes+Str(Numes,6))

    *==========================================================================
    * Pagina 1 - Apresentacao / Briefing (crSigMvJbC.Jb_001 .. Jb_023)
    *==========================================================================
    this_dJb001 = {}    && datetime - Apresentacao
    this_dJb002 = {}    && datetime - Orcamento
    this_cJb003 = ""    && text - Sobre o que estamos falando (resumo do brief)
    this_cJb004 = ""    && text - Historico (empresa/produto/servico)
    this_cJb005 = ""    && text - Contexto Mercadologico
    this_cJb006 = ""    && text - Cenario
    this_cJb007 = ""    && text - Target
    this_cJb008 = ""    && text - O problema
    this_dJb017 = {}    && datetime - Periodo do Evento (inicio)
    this_dJb018 = {}    && datetime - Periodo do Evento (fim)
    this_dJb019 = {}    && datetime - Periodo de Montagem (inicio)
    this_dJb020 = {}    && datetime - Periodo de Montagem/Desmontagem (fim)
    this_cJb021 = ""    && text - Local do Evento
    this_cJb022 = ""    && text - Publico Estimado
    this_cJb023 = ""    && text - Budget Estimado

    *==========================================================================
    * Pagina 2 - Desafio / Objetivos (crSigMvJbC.Jb_009 .. Jb_016)
    *==========================================================================
    this_cJb009 = ""    && text - Desafio
    this_cJb010 = ""    && text - Objetivos
    this_cJb011 = ""    && text - Tom de voz
    this_cJb012 = ""    && text - Inspiracoes
    this_cJb013 = ""    && text - Cliente (expectativas, comentarios)
    this_cJb014 = ""    && text - Sugestoes/obrigatoriedades e/ou restricoes
    this_cJb015 = ""    && text - Comunicacao/pecas obrigatorias
    this_cJb016 = ""    && text - Informacoes do local do evento

    *==========================================================================
    * Pagina 3 - Equipes (cntEmp1/cntEmp2) e Tipo de Projeto (crSigMvJbC.Jb_024 .. Jb_044)
    * Jb_024..030 = cntEmp1 (Atendimento/Comercial/Gerencia Projeto/Criacao/Arquiteto/Orcamento/Montagem)
    * Jb_031..037 = cntEmp2 (Lider de Projeto/Atendimento/Comercial/Criacao/Planejamento/Producao/Producao Financeira)
    *==========================================================================
    this_cJb024 = ""    && char(10) - cntEmp1 Atendimento (codigo SigCdCli.Iclis)
    this_cJb025 = ""    && char(10) - cntEmp1 Comercial (codigo SigCdCli.Iclis)
    this_cJb026 = ""    && char(10) - cntEmp1 Gerencia de Projeto (codigo SigCdCli.Iclis)
    this_cJb027 = ""    && char(10) - cntEmp1 Criacao (codigo SigCdCli.Iclis)
    this_cJb028 = ""    && char(10) - cntEmp1 Arquiteto (codigo SigCdCli.Iclis)
    this_cJb029 = ""    && char(10) - cntEmp1 Orcamento (codigo SigCdCli.Iclis)
    this_cJb030 = ""    && char(10) - cntEmp1 Montagem (codigo SigCdCli.Iclis)
    this_cJb031 = ""    && char(10) - cntEmp2 Lider de Projeto (codigo SigCdCli.Iclis)
    this_cJb032 = ""    && char(10) - cntEmp2 Atendimento (codigo SigCdCli.Iclis)
    this_cJb033 = ""    && char(10) - cntEmp2 Comercial (codigo SigCdCli.Iclis)
    this_cJb034 = ""    && char(10) - cntEmp2 Criacao (codigo SigCdCli.Iclis)
    this_cJb035 = ""    && char(10) - cntEmp2 Planejamento (codigo SigCdCli.Iclis)
    this_cJb036 = ""    && char(10) - cntEmp2 Producao (codigo SigCdCli.Iclis)
    this_cJb037 = ""    && char(10) - cntEmp2 Producao Financeira (codigo SigCdCli.Iclis)
    this_nJb038 = 0     && numeric(1,0) - Pedido do Cliente (checkbox)
    this_nJb039 = 0     && numeric(1,0) - Concorrencia (checkbox)
    this_nJb040 = 0     && numeric(1,0) - Licitacao (checkbox)
    this_nJb041 = 0     && numeric(1,0) - Proprietario (checkbox)
    this_nJb042 = 0     && numeric(1,0) - Desenvolvimento Total (checkbox)
    this_nJb043 = 0     && numeric(1,0) - Producao (checkbox)
    this_nJb044 = 0     && numeric(1,0) - Criacao (checkbox)

    *==========================================================================
    * Pagina 4 - Materiais de Apoio (crSigMvJbC.Jb_045 .. Jb_048 e Jb_061)
    * Campos de caminho de diretorio/arquivo (GetDir no legado)
    *==========================================================================
    this_cJb045 = ""    && text - Logomarca (caminho)
    this_cJb046 = ""    && text - Manual de Marca (caminho)
    this_cJb047 = ""    && text - Imagens (caminho)
    this_cJb048 = ""    && text - Referencias (caminho)
    this_cJb061 = ""    && text - Atas, emails e correspondencias de alteracoes/aprovacao do cliente
    this_cJb058 = ""    && text - Avaliacao do Job (apos primeira reuniao do time)

    *==========================================================================
    * Pagina 5 - Modelo Fiscal / Fontes Pagadoras (crSigMvJbC.Jb_062 .. Jb_071, Jb_075)
    * A grade "Fontes Pagadoras" (SigMvJbI) eh mantida em cursor separado, nao em property escalar
    *==========================================================================
    this_cJb062 = ""    && text - Codigo de Atividade
    this_nJb063 = 0     && numeric(1,0) - NF de Servico (checkbox)
    this_nJb064 = 0     && numeric(1,0) - Nota de Debito (checkbox)
    this_nJb065 = 0     && numeric(1,0) - NF de Locacao (checkbox)
    this_nJb066 = 0     && numeric(1,0) - Incentivo ICMS (checkbox)
    this_nJb067 = 0     && numeric(1,0) - Incentivo Rouanet (checkbox)
    this_nJb068 = 0     && numeric(1,0) - Incentivo ISS (checkbox)
    this_nJb069 = 0     && numeric(1,0) - Patrocinio (checkbox)
    this_nJb075 = 0     && numeric(1,0) - Conta Corrente (checkbox)
    this_nJb070 = 0     && decimal(1,0) - Outras Receitas
    this_cJb071 = ""    && text - Comentarios Financeiros (condicoes de pagamento, verba)

    *==========================================================================
    * Pagina 6 - Apresentacao / Propostas / Documentos (crSigMvJbC.Jb_049 .. Jb_057, Jb_073, Jb_074)
    *==========================================================================
    this_nJb049 = 0     && numeric(1,0) - Apresentacao Presencial (checkbox)
    this_nJb050 = 0     && numeric(1,0) - Apresentacao Eletronica (checkbox)
    this_nJb051 = 0     && numeric(1,0) - Proposta Comercial Impressao (checkbox)
    this_nJb052 = 0     && numeric(1,0) - Proposta Comercial CD (checkbox)
    this_nJb053 = 0     && numeric(1,0) - Proposta Comercial Outros (checkbox)
    this_cJb073 = ""    && char(50) - Proposta Comercial Outros (descricao)
    this_nJb054 = 0     && numeric(1,0) - Proposta Tecnica Impressao (checkbox)
    this_nJb055 = 0     && numeric(1,0) - Proposta Tecnica CD (checkbox)
    this_nJb056 = 0     && numeric(1,0) - Proposta Tecnica Outros (checkbox)
    this_cJb074 = ""    && char(50) - Proposta Tecnica Outros (descricao)
    this_cJb057 = ""    && text - Documentos Necessarios

    *==========================================================================
    * Colunas do schema sem controle visivel no SCX desta versao do form
    * (mantidas por fidelidade ao PILAR 2 - schema de banco identico)
    *==========================================================================
    this_cJb059    = ""    && text - reservado (sem controle no SCX atual)
    this_cJb060    = ""    && text - reservado (sem controle no SCX atual)
    this_dJbContato = {}   && datetime - Jb_Contato (data do ultimo contato)

    *-- numeric(1,0) - "Briefing Extra" (chk_4c_Get_Extra na raiz do form).
    *-- O SCX legado liga SIGOPJOB.get_Extra a ControlSource
    *-- "crSigMvJbC.Jb_072", e o ChecaObrigs legado conta [get_Extra] entre
    *-- os campos obrigatorios (laCpo(68)) - a coluna TEM controle visivel.
    this_nJb072    = 0

    *==========================================================================
    * Alias do cursor de detalhe (grade "Fontes Pagadoras" - SigMvJbI)
    *==========================================================================
    this_cCursorFontes = "cursor_4c_Fontes"

    *==========================================================================
    * Cabecalho de identificacao do Job (bloco de campos somente-leitura na
    * raiz do form - getCab001/002/005/006/010 do SCX legado).
    *
    * NAO sao colunas de SigMvJbC: vem do cabecalho da movimentacao
    * (SigMvCab) e do cadastro de contas (SigCdCli), carregados pela
    * PROCEDURE carregacabs do SCX legado. Por isso ficam em propriedades
    * proprias e NAO entram no INSERT/UPDATE de SigMvJbC.
    *==========================================================================
    this_cCabJobs         = ""   && SigMvCab.Jobs      - codigo do Job
    this_cCabJobDesc      = ""   && SigCdCli.RClis do Job
    this_cCabContas       = ""   && conta recebida do form pai (pCta)
    this_cCabContaDesc    = ""   && SigCdCli.RClis da conta
    this_dCabDataEntrada  = {}   && Min(SigMvCab.Datas) do Job

    *==========================================================================
    * Parametrizacao da operacao (SigOpCdI, chave dopes char(20)) - as tres
    * colunas "text" que o legado le atraves do cursor crSigOpCdI, carregado
    * pelo form PAI e visivel neste dialogo por heranca de data session:
    *
    *   job_mv_obr - MASCARA DE OBRIGATORIEDADE. Posicional: o caractere da
    *                posicao N vale "1" quando o campo N da lista do
    *                ChecaObrigs legado e obrigatorio. Lido por
    *                CampoObrigatorio().
    *   job_mv_tit - TITULOS personalizados por operacao (blocos de 50
    *                caracteres em posicoes fixas 101, 151, 201, ...). Lido
    *                por ObterTituloPersonalizado().
    *   job_mv_cpo - ROTULOS de campo personalizados (mesmos blocos de 50).
    *                Lido por ObterRotuloPersonalizado().
    *
    * Ficam em propriedades proprias e NAO entram no INSERT/UPDATE de
    * SigMvJbC: sao parametros de cadastro da operacao, somente-leitura
    * aqui (PILAR 2 - este form nunca escreve em SigOpCdI).
    *==========================================================================
    this_cJobMvObr = ""   && SigOpCdI.job_mv_obr - mascara de obrigatoriedade
    this_cJobMvTit = ""   && SigOpCdI.job_mv_tit - titulos por operacao
    this_cJobMvCpo = ""   && SigOpCdI.job_mv_cpo - rotulos de campo

    *-- SigCdEmp.divnotas numeric(1,0) da empresa do movimento. Decide quais
    *-- dos dois blocos de equipe (cntEmp1/cntEmp2) ficam visiveis na Page3:
    *-- 2 = so o primeiro, 3 = so o segundo, 4 = nenhum. O legado parte de 1
    *-- quando nao acha a empresa ("lnEmp = Iif(Eof([LocalEmps]), 1,
    *-- LocalEmps.DivNotas)"), e 1 nao cai em nenhum dos tres Case - os dois
    *-- blocos ficam como nasceram. Mesmo default aqui.
    this_nDivNotas = 1

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvJbC"
            THIS.this_cCampoChave = "EmpDopNums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConexaoAtiva - Ha handle de conexao utilizavel?
    *
    * Testa TYPE() antes do valor: em modo de teste / validacao de UI a
    * variavel gnConnHandle pode nem EXISTIR, e cita-la direto estoura
    * "Variable 'GNCONNHANDLE' is not found" - erro que nao diz nada sobre a
    * causa e polui o log do harness. O teste de TYPE fica num IF SEPARADO
    * porque VFP9 nao faz short-circuit em AND/OR.
    *==========================================================================
    FUNCTION ConexaoAtiva()
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF
        RETURN (gnConnHandle > 0)
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Retorna o valor da PK (EmpDopNums) para
    * RegistrarAuditoria(). Quem monta/preenche this_cEmpDopNums eh
    * CarregarDoCursor() (registro existente) ou MontarChaveEmpDopNums()
    * (registro novo, chamado pelo Form antes de NovoRegistro).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *==========================================================================
    * MontarChaveEmpDopNums - Monta a chave posicional de 29 caracteres usada
    * pelo legado (lcEmpDopNums): Emps(3) + Dopes(20) + Str(Numes,6).
    *
    * ALLTRIM nas PARTES quebra a busca/gravacao em silencio - "001" + "MALOTE"
    * + "     3" da 15 chars e nunca casa com o valor gravado (29 chars). Usar
    * SEMPRE PADR explicito nas partes (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
               PADR(TratarNulo(par_cDopes, ""), 20) + ;
               STR(TratarNulo(par_nNumes, 0), 6)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvJbC (cursor corrente
    * de par_cAliasCursor) para as propriedades this_* do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

            *-- Pagina 1 - Apresentacao / Briefing
            THIS.this_dJb001 = ConverterParaData(jb_001)
            THIS.this_dJb002 = ConverterParaData(jb_002)
            THIS.this_cJb003 = TratarNulo(jb_003, "")
            THIS.this_cJb004 = TratarNulo(jb_004, "")
            THIS.this_cJb005 = TratarNulo(jb_005, "")
            THIS.this_cJb006 = TratarNulo(jb_006, "")
            THIS.this_cJb007 = TratarNulo(jb_007, "")
            THIS.this_cJb008 = TratarNulo(jb_008, "")
            THIS.this_dJb017 = ConverterParaData(jb_017)
            THIS.this_dJb018 = ConverterParaData(jb_018)
            THIS.this_dJb019 = ConverterParaData(jb_019)
            THIS.this_dJb020 = ConverterParaData(jb_020)
            THIS.this_cJb021 = TratarNulo(jb_021, "")
            THIS.this_cJb022 = TratarNulo(jb_022, "")
            THIS.this_cJb023 = TratarNulo(jb_023, "")

            *-- Pagina 2 - Desafio / Objetivos
            THIS.this_cJb009 = TratarNulo(jb_009, "")
            THIS.this_cJb010 = TratarNulo(jb_010, "")
            THIS.this_cJb011 = TratarNulo(jb_011, "")
            THIS.this_cJb012 = TratarNulo(jb_012, "")
            THIS.this_cJb013 = TratarNulo(jb_013, "")
            THIS.this_cJb014 = TratarNulo(jb_014, "")
            THIS.this_cJb015 = TratarNulo(jb_015, "")
            THIS.this_cJb016 = TratarNulo(jb_016, "")

            *-- Pagina 3 - Equipes e Tipo de Projeto
            THIS.this_cJb024 = ALLTRIM(TratarNulo(jb_024, ""))
            THIS.this_cJb025 = ALLTRIM(TratarNulo(jb_025, ""))
            THIS.this_cJb026 = ALLTRIM(TratarNulo(jb_026, ""))
            THIS.this_cJb027 = ALLTRIM(TratarNulo(jb_027, ""))
            THIS.this_cJb028 = ALLTRIM(TratarNulo(jb_028, ""))
            THIS.this_cJb029 = ALLTRIM(TratarNulo(jb_029, ""))
            THIS.this_cJb030 = ALLTRIM(TratarNulo(jb_030, ""))
            THIS.this_cJb031 = ALLTRIM(TratarNulo(jb_031, ""))
            THIS.this_cJb032 = ALLTRIM(TratarNulo(jb_032, ""))
            THIS.this_cJb033 = ALLTRIM(TratarNulo(jb_033, ""))
            THIS.this_cJb034 = ALLTRIM(TratarNulo(jb_034, ""))
            THIS.this_cJb035 = ALLTRIM(TratarNulo(jb_035, ""))
            THIS.this_cJb036 = ALLTRIM(TratarNulo(jb_036, ""))
            THIS.this_cJb037 = ALLTRIM(TratarNulo(jb_037, ""))
            THIS.this_nJb038 = NVL(jb_038, 0)
            THIS.this_nJb039 = NVL(jb_039, 0)
            THIS.this_nJb040 = NVL(jb_040, 0)
            THIS.this_nJb041 = NVL(jb_041, 0)
            THIS.this_nJb042 = NVL(jb_042, 0)
            THIS.this_nJb043 = NVL(jb_043, 0)
            THIS.this_nJb044 = NVL(jb_044, 0)

            *-- Pagina 4 - Materiais de Apoio
            THIS.this_cJb045 = TratarNulo(jb_045, "")
            THIS.this_cJb046 = TratarNulo(jb_046, "")
            THIS.this_cJb047 = TratarNulo(jb_047, "")
            THIS.this_cJb048 = TratarNulo(jb_048, "")
            THIS.this_cJb061 = TratarNulo(jb_061, "")
            THIS.this_cJb058 = TratarNulo(jb_058, "")

            *-- Pagina 5 - Modelo Fiscal / Fontes Pagadoras
            THIS.this_cJb062 = TratarNulo(jb_062, "")
            THIS.this_nJb063 = NVL(jb_063, 0)
            THIS.this_nJb064 = NVL(jb_064, 0)
            THIS.this_nJb065 = NVL(jb_065, 0)
            THIS.this_nJb066 = NVL(jb_066, 0)
            THIS.this_nJb067 = NVL(jb_067, 0)
            THIS.this_nJb068 = NVL(jb_068, 0)
            THIS.this_nJb069 = NVL(jb_069, 0)
            THIS.this_nJb075 = NVL(jb_075, 0)
            THIS.this_nJb070 = NVL(jb_070, 0)
            THIS.this_cJb071 = TratarNulo(jb_071, "")

            *-- Pagina 6 - Apresentacao / Propostas / Documentos
            THIS.this_nJb049 = NVL(jb_049, 0)
            THIS.this_nJb050 = NVL(jb_050, 0)
            THIS.this_nJb051 = NVL(jb_051, 0)
            THIS.this_nJb052 = NVL(jb_052, 0)
            THIS.this_nJb053 = NVL(jb_053, 0)
            THIS.this_cJb073 = ALLTRIM(TratarNulo(jb_073, ""))
            THIS.this_nJb054 = NVL(jb_054, 0)
            THIS.this_nJb055 = NVL(jb_055, 0)
            THIS.this_nJb056 = NVL(jb_056, 0)
            THIS.this_cJb074 = ALLTRIM(TratarNulo(jb_074, ""))
            THIS.this_cJb057 = TratarNulo(jb_057, "")

            *-- Colunas sem controle visivel no SCX desta versao do form
            THIS.this_cJb059     = TratarNulo(jb_059, "")
            THIS.this_cJb060     = TratarNulo(jb_060, "")
            THIS.this_nJb072     = NVL(jb_072, 0)
            THIS.this_dJbContato = ConverterParaData(jb_contato)

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigMvJbC (todas as colunas do schema)
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmpDopNums, "")))
            THIS.this_cMensagemErro = "Chave EmpDopNums n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigMvJbC (empdopnums, jb_001, jb_002, jb_003, jb_004, jb_005," + ;
                " jb_006, jb_007, jb_008, jb_009, jb_010, jb_011, jb_012, jb_013, jb_014, jb_015," + ;
                " jb_016, jb_017, jb_018, jb_019, jb_020, jb_021, jb_022, jb_023, jb_024, jb_025," + ;
                " jb_026, jb_027, jb_028, jb_029, jb_030, jb_031, jb_032, jb_033, jb_034, jb_035," + ;
                " jb_036, jb_037, jb_038, jb_039, jb_040, jb_041, jb_042, jb_043, jb_044, jb_045," + ;
                " jb_046, jb_047, jb_048, jb_049, jb_050, jb_051, jb_052, jb_053, jb_054, jb_055," + ;
                " jb_056, jb_057, jb_058, jb_059, jb_060, jb_061, jb_062, jb_063, jb_064, jb_065," + ;
                " jb_066, jb_067, jb_068, jb_069, jb_070, jb_071, jb_072, jb_073, jb_074, jb_075," + ;
                " jb_contato)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                FormatarDataSQL(THIS.this_dJb001) + "," + ;
                FormatarDataSQL(THIS.this_dJb002) + "," + ;
                EscaparSQL(THIS.this_cJb003) + "," + ;
                EscaparSQL(THIS.this_cJb004) + "," + ;
                EscaparSQL(THIS.this_cJb005) + "," + ;
                EscaparSQL(THIS.this_cJb006) + "," + ;
                EscaparSQL(THIS.this_cJb007) + "," + ;
                EscaparSQL(THIS.this_cJb008) + "," + ;
                EscaparSQL(THIS.this_cJb009) + "," + ;
                EscaparSQL(THIS.this_cJb010) + "," + ;
                EscaparSQL(THIS.this_cJb011) + "," + ;
                EscaparSQL(THIS.this_cJb012) + "," + ;
                EscaparSQL(THIS.this_cJb013) + "," + ;
                EscaparSQL(THIS.this_cJb014) + "," + ;
                EscaparSQL(THIS.this_cJb015) + "," + ;
                EscaparSQL(THIS.this_cJb016) + "," + ;
                FormatarDataSQL(THIS.this_dJb017) + "," + ;
                FormatarDataSQL(THIS.this_dJb018) + "," + ;
                FormatarDataSQL(THIS.this_dJb019) + "," + ;
                FormatarDataSQL(THIS.this_dJb020) + "," + ;
                EscaparSQL(THIS.this_cJb021) + "," + ;
                EscaparSQL(THIS.this_cJb022) + "," + ;
                EscaparSQL(THIS.this_cJb023) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb024, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb025, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb026, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb027, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb028, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb029, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb030, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb031, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb032, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb033, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb034, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb035, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb036, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb037, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb038, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb039, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb040, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb041, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb042, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb043, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb044, 0) + "," + ;
                EscaparSQL(THIS.this_cJb045) + "," + ;
                EscaparSQL(THIS.this_cJb046) + "," + ;
                EscaparSQL(THIS.this_cJb047) + "," + ;
                EscaparSQL(THIS.this_cJb048) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb049, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb050, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb051, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb052, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb053, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb054, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb055, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb056, 0) + "," + ;
                EscaparSQL(THIS.this_cJb057) + "," + ;
                EscaparSQL(THIS.this_cJb058) + "," + ;
                EscaparSQL(THIS.this_cJb059) + "," + ;
                EscaparSQL(THIS.this_cJb060) + "," + ;
                EscaparSQL(THIS.this_cJb061) + "," + ;
                EscaparSQL(THIS.this_cJb062) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb063, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb064, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb065, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb066, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb067, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb068, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb069, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb070, 0) + "," + ;
                EscaparSQL(THIS.this_cJb071) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb072, 0) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb073, 50)) + "," + ;
                EscaparSQL(PADR(THIS.this_cJb074, 50)) + "," + ;
                FormatarNumeroSQL(THIS.this_nJb075, 0) + "," + ;
                FormatarDataSQL(THIS.this_dJbContato) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Complemento de Job:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE completo em SigMvJbC (todas as colunas, exceto a PK)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmpDopNums, "")))
            THIS.this_cMensagemErro = "Chave EmpDopNums n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigMvJbC SET " + ;
                "jb_001 = "    + FormatarDataSQL(THIS.this_dJb001)              + "," + ;
                "jb_002 = "    + FormatarDataSQL(THIS.this_dJb002)              + "," + ;
                "jb_003 = "    + EscaparSQL(THIS.this_cJb003)                   + "," + ;
                "jb_004 = "    + EscaparSQL(THIS.this_cJb004)                   + "," + ;
                "jb_005 = "    + EscaparSQL(THIS.this_cJb005)                   + "," + ;
                "jb_006 = "    + EscaparSQL(THIS.this_cJb006)                   + "," + ;
                "jb_007 = "    + EscaparSQL(THIS.this_cJb007)                   + "," + ;
                "jb_008 = "    + EscaparSQL(THIS.this_cJb008)                   + "," + ;
                "jb_009 = "    + EscaparSQL(THIS.this_cJb009)                   + "," + ;
                "jb_010 = "    + EscaparSQL(THIS.this_cJb010)                   + "," + ;
                "jb_011 = "    + EscaparSQL(THIS.this_cJb011)                   + "," + ;
                "jb_012 = "    + EscaparSQL(THIS.this_cJb012)                   + "," + ;
                "jb_013 = "    + EscaparSQL(THIS.this_cJb013)                   + "," + ;
                "jb_014 = "    + EscaparSQL(THIS.this_cJb014)                   + "," + ;
                "jb_015 = "    + EscaparSQL(THIS.this_cJb015)                   + "," + ;
                "jb_016 = "    + EscaparSQL(THIS.this_cJb016)                   + "," + ;
                "jb_017 = "    + FormatarDataSQL(THIS.this_dJb017)              + "," + ;
                "jb_018 = "    + FormatarDataSQL(THIS.this_dJb018)              + "," + ;
                "jb_019 = "    + FormatarDataSQL(THIS.this_dJb019)              + "," + ;
                "jb_020 = "    + FormatarDataSQL(THIS.this_dJb020)              + "," + ;
                "jb_021 = "    + EscaparSQL(THIS.this_cJb021)                   + "," + ;
                "jb_022 = "    + EscaparSQL(THIS.this_cJb022)                   + "," + ;
                "jb_023 = "    + EscaparSQL(THIS.this_cJb023)                   + "," + ;
                "jb_024 = "    + EscaparSQL(PADR(THIS.this_cJb024, 10))         + "," + ;
                "jb_025 = "    + EscaparSQL(PADR(THIS.this_cJb025, 10))         + "," + ;
                "jb_026 = "    + EscaparSQL(PADR(THIS.this_cJb026, 10))         + "," + ;
                "jb_027 = "    + EscaparSQL(PADR(THIS.this_cJb027, 10))         + "," + ;
                "jb_028 = "    + EscaparSQL(PADR(THIS.this_cJb028, 10))         + "," + ;
                "jb_029 = "    + EscaparSQL(PADR(THIS.this_cJb029, 10))         + "," + ;
                "jb_030 = "    + EscaparSQL(PADR(THIS.this_cJb030, 10))         + "," + ;
                "jb_031 = "    + EscaparSQL(PADR(THIS.this_cJb031, 10))         + "," + ;
                "jb_032 = "    + EscaparSQL(PADR(THIS.this_cJb032, 10))         + "," + ;
                "jb_033 = "    + EscaparSQL(PADR(THIS.this_cJb033, 10))         + "," + ;
                "jb_034 = "    + EscaparSQL(PADR(THIS.this_cJb034, 10))         + "," + ;
                "jb_035 = "    + EscaparSQL(PADR(THIS.this_cJb035, 10))         + "," + ;
                "jb_036 = "    + EscaparSQL(PADR(THIS.this_cJb036, 10))         + "," + ;
                "jb_037 = "    + EscaparSQL(PADR(THIS.this_cJb037, 10))         + "," + ;
                "jb_038 = "    + FormatarNumeroSQL(THIS.this_nJb038, 0)         + "," + ;
                "jb_039 = "    + FormatarNumeroSQL(THIS.this_nJb039, 0)         + "," + ;
                "jb_040 = "    + FormatarNumeroSQL(THIS.this_nJb040, 0)         + "," + ;
                "jb_041 = "    + FormatarNumeroSQL(THIS.this_nJb041, 0)         + "," + ;
                "jb_042 = "    + FormatarNumeroSQL(THIS.this_nJb042, 0)         + "," + ;
                "jb_043 = "    + FormatarNumeroSQL(THIS.this_nJb043, 0)         + "," + ;
                "jb_044 = "    + FormatarNumeroSQL(THIS.this_nJb044, 0)         + "," + ;
                "jb_045 = "    + EscaparSQL(THIS.this_cJb045)                   + "," + ;
                "jb_046 = "    + EscaparSQL(THIS.this_cJb046)                   + "," + ;
                "jb_047 = "    + EscaparSQL(THIS.this_cJb047)                   + "," + ;
                "jb_048 = "    + EscaparSQL(THIS.this_cJb048)                   + "," + ;
                "jb_049 = "    + FormatarNumeroSQL(THIS.this_nJb049, 0)         + "," + ;
                "jb_050 = "    + FormatarNumeroSQL(THIS.this_nJb050, 0)         + "," + ;
                "jb_051 = "    + FormatarNumeroSQL(THIS.this_nJb051, 0)         + "," + ;
                "jb_052 = "    + FormatarNumeroSQL(THIS.this_nJb052, 0)         + "," + ;
                "jb_053 = "    + FormatarNumeroSQL(THIS.this_nJb053, 0)         + "," + ;
                "jb_054 = "    + FormatarNumeroSQL(THIS.this_nJb054, 0)         + "," + ;
                "jb_055 = "    + FormatarNumeroSQL(THIS.this_nJb055, 0)         + "," + ;
                "jb_056 = "    + FormatarNumeroSQL(THIS.this_nJb056, 0)         + "," + ;
                "jb_057 = "    + EscaparSQL(THIS.this_cJb057)                   + "," + ;
                "jb_058 = "    + EscaparSQL(THIS.this_cJb058)                   + "," + ;
                "jb_059 = "    + EscaparSQL(THIS.this_cJb059)                   + "," + ;
                "jb_060 = "    + EscaparSQL(THIS.this_cJb060)                   + "," + ;
                "jb_061 = "    + EscaparSQL(THIS.this_cJb061)                   + "," + ;
                "jb_062 = "    + EscaparSQL(THIS.this_cJb062)                   + "," + ;
                "jb_063 = "    + FormatarNumeroSQL(THIS.this_nJb063, 0)         + "," + ;
                "jb_064 = "    + FormatarNumeroSQL(THIS.this_nJb064, 0)         + "," + ;
                "jb_065 = "    + FormatarNumeroSQL(THIS.this_nJb065, 0)         + "," + ;
                "jb_066 = "    + FormatarNumeroSQL(THIS.this_nJb066, 0)         + "," + ;
                "jb_067 = "    + FormatarNumeroSQL(THIS.this_nJb067, 0)         + "," + ;
                "jb_068 = "    + FormatarNumeroSQL(THIS.this_nJb068, 0)         + "," + ;
                "jb_069 = "    + FormatarNumeroSQL(THIS.this_nJb069, 0)         + "," + ;
                "jb_070 = "    + FormatarNumeroSQL(THIS.this_nJb070, 0)         + "," + ;
                "jb_071 = "    + EscaparSQL(THIS.this_cJb071)                   + "," + ;
                "jb_072 = "    + FormatarNumeroSQL(THIS.this_nJb072, 0)         + "," + ;
                "jb_073 = "    + EscaparSQL(PADR(THIS.this_cJb073, 50))         + "," + ;
                "jb_074 = "    + EscaparSQL(PADR(THIS.this_cJb074, 50))         + "," + ;
                "jb_075 = "    + FormatarNumeroSQL(THIS.this_nJb075, 0)         + "," + ;
                "jb_contato = " + FormatarDataSQL(THIS.this_dJbContato) + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Complemento de Job:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFontes - Carrega a grade "Fontes Pagadoras" (SigMvJbI) filtrada
    * pela chave do Job (this_cEmpDopNums) em cursor_4c_Fontes.
    *
    * SQLEXEC() nasce SOMENTE-LEITURA; como a grade do form permite Incluir/
    * Excluir/editar linha (REPLACE/INSERT/DELETE direto no cursor), carrega
    * num alias temporario e reconstroi via SELECT ... INTO CURSOR READWRITE
    * com o MESMO nome e MESMA ordem de colunas do placeholder criado pelo
    * Form (regra: cursor de grid editavel exige READWRITE).
    *==========================================================================
    PROCEDURE CarregarFontes()
        LOCAL loc_cSQL, loc_cAliasTmp, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cAliasTmp = THIS.this_cCursorFontes + "Tmp"

        TRY
            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF

            loc_cSQL = "SELECT empdopnums, jbi_autors, jbi_fontes, jbi_modelos, jbi_valors, pkchaves" + ;
                " FROM SigMvJbI WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)

            *-- Sem conexao (modo de teste / validacao de UI) o SQLEXEC nao
            *-- chega a rodar: gnConnHandle pode nem existir como variavel, e
            *-- a referencia estouraria "Variable 'GNCONNHANDLE' is not found"
            *-- - erro que nao diz nada sobre a causa real.
            loc_nResultado = -1
            IF THIS.ConexaoAtiva()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)
            ENDIF

            IF loc_nResultado >= 0
                IF USED(THIS.this_cCursorFontes)
                    USE IN (THIS.this_cCursorFontes)
                ENDIF

                SELECT * FROM (loc_cAliasTmp) INTO CURSOR (THIS.this_cCursorFontes) READWRITE

                IF USED(loc_cAliasTmp)
                    USE IN (loc_cAliasTmp)
                ENDIF

                loc_lSucesso = .T.
            ELSE
                IF THIS.ConexaoAtiva()
                    MsgErro("Erro ao carregar Fontes Pagadoras:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarFontes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PersistirFontes - Grava a grade "Fontes Pagadoras" (SigMvJbI) a partir
    * de cursor_4c_Fontes: apaga todas as linhas do Job na tabela e reinsere
    * as que sobraram no cursor. O Form ja remove as linhas em branco antes
    * de chamar (CmdRetornarClick - transcricao de "Delete From crSigMvJbI
    * Where Empty(JBI_Fontes) Or Empty(JBI_Modelos)" do legado); o SCAN FOR
    * abaixo repete o mesmo filtro por seguranca, caso o metodo seja chamado
    * de outro lugar sem passar por aquela limpeza.
    *
    * Apagar+reinserir (em vez de UPDATE linha a linha) eh seguro aqui porque
    * pkchaves NAO tem FK de fora apontando para ele - e evita ter de rastrear
    * quais linhas o usuario excluiu da grade desde a ultima gravacao.
    *
    * Chamado pelo Form DEPOIS de THIS.Salvar() ter sucesso - a chave
    * EmpDopNums do cabecalho (SigMvJbC) precisa estar gravada antes do
    * detalhe (SigMvJbI), que a referencia.
    *==========================================================================
    PROCEDURE PersistirFontes()
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPk, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmpDopNums, "")))
            THIS.this_cMensagemErro = "Chave EmpDopNums n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        loc_cAlias = THIS.this_cCursorFontes
        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigMvJbI WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar Fontes Pagadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.

                SELECT (loc_cAlias)
                SCAN FOR !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos)
                    loc_cPk = ALLTRIM(TratarNulo(pkchaves, ""))
                    IF EMPTY(loc_cPk)
                        loc_cPk = fUniqueIds()
                    ENDIF

                    loc_cSQL = "INSERT INTO SigMvJbI" + ;
                        " (empdopnums, pkchaves, jbi_autors, jbi_fontes, jbi_modelos, jbi_valors)" + ;
                        " VALUES (" + ;
                        EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                        EscaparSQL(PADR(loc_cPk, 20)) + "," + ;
                        EscaparSQL(PADR(TratarNulo(jbi_autors, ""), 20)) + "," + ;
                        EscaparSQL(PADR(TratarNulo(jbi_fontes, ""), 50)) + "," + ;
                        EscaparSQL(PADR(TratarNulo(jbi_modelos, ""), 30)) + "," + ;
                        FormatarNumeroSQL(NVL(jbi_valors, 0), 2) + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado < 0
                        MsgErro("Erro ao gravar linha de Fontes Pagadoras:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em PersistirFontes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Transcricao da PROCEDURE carregacabs do SCX legado.
    * Preenche as propriedades this_cCab*/this_dCab* do bloco de identificacao
    * do Job (campos somente-leitura na raiz do form).
    *
    * Legado (SIGOPJOB.carregacabs):
    *   getCab001 = TprMvCab.Jobs
    *   CursorQuery('SigCdCli','LocalBus','IClis', TprMvCab.Jobs, 'RClis,...')
    *     -> getCab002 = LocalBus.RClis
    *   getCab005 = ThisForm.Contas
    *   CursorQuery('SigCdCli','LocalBus','IClis', ThisForm.Contas, 'RClis,...')
    *     -> getCab006 = LocalBus.RClis
    *   Select Jobs, Min(Datas) as Datas From SigMvCab
    *    Where Dopes = TprMvCab.Dopes And Jobs = TprMvCab.Jobs Group By Jobs
    *     -> getCab010 = Ttod(LocalBus.Datas)
    *
    * Diferenca de ORIGEM (nao de regra): o legado le TprMvCab, o cursor
    * global que o form PAI mantem aberto. O form migrado nao compartilha
    * cursor com o pai - recebe Emps/Dopes/Numes no Init e le o MESMO
    * registro de SigMvCab por empdopnums para obter Jobs. O criterio do
    * Min(Datas) continua o do legado: agrupado por Jobs, filtrado por
    * Dopes + Jobs (NAO pela chave do registro - o Job pode ter varias
    * movimentacoes e a data de entrada eh a MENOR delas).
    *
    * par_cContas: valor de pCta (2o parametro do Init legado).
    *==========================================================================
    PROCEDURE CarregarCabecalho(par_cContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cJobs, loc_cDopes, loc_cContas
        loc_lSucesso = .F.

        *-- Limpeza ANTES da guarda de conexao: sem conexao o cabecalho tem de
        *-- ficar VAZIO, nunca com o valor do Job anterior.
        THIS.this_cCabJobs        = ""
        THIS.this_cCabJobDesc     = ""
        THIS.this_cCabContaDesc   = ""
        THIS.this_dCabDataEntrada = {}
        THIS.this_cCabContas      = IIF(VARTYPE(par_cContas) = "C", ALLTRIM(par_cContas), "")

        *-- RETURN fora do TRY (regra #1)
        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        TRY

            *-- 1) Jobs + Dopes do registro de SigMvCab apontado pela chave
            IF USED("cursor_4c_CabTmp")
                USE IN cursor_4c_CabTmp
            ENDIF

            loc_cSQL = "SELECT jobs, dopes FROM SigMvCab" + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabTmp")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar cabecalho do Job:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cJobs  = ""
                loc_cDopes = ""

                SELECT cursor_4c_CabTmp
                GO TOP
                IF !EOF("cursor_4c_CabTmp")
                    loc_cJobs  = TratarNulo(cursor_4c_CabTmp.jobs, "")
                    loc_cDopes = TratarNulo(cursor_4c_CabTmp.dopes, "")
                ENDIF
                USE IN cursor_4c_CabTmp

                THIS.this_cCabJobs = ALLTRIM(loc_cJobs)

                *-- 2) Descricao do Job (SigCdCli.RClis por IClis = Jobs)
                IF !EMPTY(ALLTRIM(loc_cJobs))
                    THIS.this_cCabJobDesc = THIS.ObterRazaoConta(loc_cJobs)
                ENDIF

                *-- 3) Descricao da conta recebida do form pai
                loc_cContas = THIS.this_cCabContas
                IF !EMPTY(loc_cContas)
                    THIS.this_cCabContaDesc = THIS.ObterRazaoConta(loc_cContas)
                ENDIF

                *-- 4) Data de entrada = MENOR data das movimentacoes do Job
                IF !EMPTY(ALLTRIM(loc_cJobs))
                    IF USED("cursor_4c_CabTmp")
                        USE IN cursor_4c_CabTmp
                    ENDIF

                    loc_cSQL = "SELECT jobs, MIN(datas) AS datas FROM SigMvCab" + ;
                        " WHERE dopes = " + EscaparSQL(ALLTRIM(loc_cDopes)) + ;
                        "   AND jobs = "  + EscaparSQL(ALLTRIM(loc_cJobs)) + ;
                        " GROUP BY jobs"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabTmp")

                    IF loc_nResultado < 0
                        MsgErro("Erro ao carregar data de entrada do Job:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ELSE
                        SELECT cursor_4c_CabTmp
                        GO TOP
                        IF !EOF("cursor_4c_CabTmp")
                            THIS.this_dCabDataEntrada = ConverterParaData(cursor_4c_CabTmp.datas)
                        ENDIF
                        USE IN cursor_4c_CabTmp
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCabecalho")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterRazaoConta - SigCdCli.RClis de um IClis (equivale ao
    * CursorQuery('SigCdCli','LocalBus','IClis', <valor>, 'RClis') do legado).
    * Usado pelo cabecalho (descricao do Job e da conta) e pelos campos de
    * nome das equipes (Page3).
    *
    * SigCdCli.iclis eh char(10): compara-se com o valor ALLTRIM porque o
    * SQL Server faz blank-padding ANSI em char - diferente da chave
    * POSICIONAL empdopnums, onde o padding faz parte da chave (regra #42).
    *==========================================================================
    FUNCTION ObterRazaoConta(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_cRazao, loc_oErro
        loc_cRazao = ""

        TRY
            IF VARTYPE(par_cIClis) = "C" AND !EMPTY(ALLTRIM(par_cIClis)) AND ;
               THIS.ConexaoAtiva()
                IF USED("cursor_4c_RazaoTmp")
                    USE IN cursor_4c_RazaoTmp
                ENDIF

                loc_cSQL = "SELECT rclis FROM SigCdCli" + ;
                    " WHERE RTRIM(iclis) = " + EscaparSQL(ALLTRIM(par_cIClis))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp")

                IF loc_nResultado < 0
                    MsgErro("Erro ao consultar conta " + ALLTRIM(par_cIClis) + ":" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    SELECT cursor_4c_RazaoTmp
                    GO TOP
                    IF !EOF("cursor_4c_RazaoTmp")
                        loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_RazaoTmp.rclis, ""))
                    ENDIF
                    USE IN cursor_4c_RazaoTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ObterRazaoConta")
        ENDTRY

        RETURN loc_cRazao
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoJob - Le as tres colunas de parametrizacao da
    * operacao em SigOpCdI (job_mv_obr / job_mv_tit / job_mv_cpo).
    *
    * No legado quem abre esse cursor (crSigOpCdI) e o form PAI; este dialogo
    * so le, porque entra na data session do chamador
    * ("Set Datasession To .ParentForm.DataSessionId"). Nesta arquitetura o
    * dialogo tem BO proprio e precisa carregar por conta - a chave e a
    * OPERACAO (SigOpCdI.dopes), nao a chave do movimento.
    *
    * par_cDopes: codigo da operacao (SigMvCab.Dopes), vindo do form.
    *
    * Sem conexao (modo de teste / validacao de UI) as tres propriedades
    * ficam VAZIAS, e e' exatamente o comportamento neutro desejado:
    * CampoObrigatorio() devolve .F. para todo indice (nada obrigatorio) e
    * ObterTituloPersonalizado()/ObterRotuloPersonalizado() devolvem ""
    * (mantem o caption transcrito do SCX).
    *==========================================================================
    PROCEDURE CarregarConfiguracaoJob(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDopes, loc_oErro
        loc_lSucesso = .F.

        *-- Limpeza ANTES da guarda de conexao: operacao sem parametrizacao
        *-- tem de ficar NEUTRA, nunca com a mascara da operacao anterior.
        THIS.this_cJobMvObr = ""
        THIS.this_cJobMvTit = ""
        THIS.this_cJobMvCpo = ""

        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

        *-- RETURN fora do TRY (regra #1)
        IF EMPTY(loc_cDopes)
            RETURN .F.
        ENDIF
        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_CfgJobTmp")
                IF CURSORGETPROP("Buffering", "cursor_4c_CfgJobTmp") > 1
                    TABLEREVERT(.T., "cursor_4c_CfgJobTmp")
                ENDIF
                USE IN cursor_4c_CfgJobTmp
            ENDIF

            loc_cSQL = "SELECT job_mv_obr, job_mv_tit, job_mv_cpo" + ;
                " FROM SigOpCdI" + ;
                " WHERE RTRIM(dopes) = RTRIM(" + EscaparSQL(loc_cDopes) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgJobTmp")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar a parametriza" + CHR(231) + CHR(227) + "o da opera" + ;
                        CHR(231) + CHR(227) + "o " + loc_cDopes + ":" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT cursor_4c_CfgJobTmp
                GO TOP
                IF !EOF("cursor_4c_CfgJobTmp")
                    THIS.this_cJobMvObr = TratarNulo(cursor_4c_CfgJobTmp.job_mv_obr, "")
                    THIS.this_cJobMvTit = TratarNulo(cursor_4c_CfgJobTmp.job_mv_tit, "")
                    THIS.this_cJobMvCpo = TratarNulo(cursor_4c_CfgJobTmp.job_mv_cpo, "")
                ENDIF
                USE IN cursor_4c_CfgJobTmp
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarConfiguracaoJob")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CampoObrigatorio - O campo de indice par_nIndice da lista do
    * ChecaObrigs e obrigatorio nesta operacao?
    *
    * Transcricao de "Int(Val(Substr(Nvl(crSigOpCdI.JOB_MV_OBR, []),
    * lnCnt, 1))) = 1" (o legado escreve a condicao NEGADA, "<> 1", porque
    * la ela entra somada ao teste de preenchimento).
    *
    * Posicao fora do texto carregado devolve .F. - SUBSTR de alem do fim
    * devolve "", VAL("") da 0 e 0 nao e' 1. Explicito aqui para a leitura
    * nao depender desse encadeamento.
    *==========================================================================
    FUNCTION CampoObrigatorio(par_nIndice)
        LOCAL loc_cMarca

        IF VARTYPE(par_nIndice) != "N"
            RETURN .F.
        ENDIF
        IF par_nIndice < 1
            RETURN .F.
        ENDIF
        IF par_nIndice > LEN(THIS.this_cJobMvObr)
            RETURN .F.
        ENDIF

        loc_cMarca = SUBSTR(THIS.this_cJobMvObr, par_nIndice, 1)
        RETURN (INT(VAL(loc_cMarca)) = 1)
    ENDFUNC

    *==========================================================================
    * ObterTituloPersonalizado - Bloco de 50 caracteres de job_mv_tit na
    * posicao par_nPos, ja com ALLTRIM - transcricao de
    * "Alltrim(Substr(Nvl(crSigOpCdI.JOB_MV_TIT, []), <pos>, 50))".
    *
    * Devolve "" quando a operacao nao personaliza aquele titulo; o chamador
    * so sobrescreve o Caption quando vem texto (o legado tambem cerca cada
    * atribuicao com "If Not Empty(...)").
    *==========================================================================
    FUNCTION ObterTituloPersonalizado(par_nPos)
        IF VARTYPE(par_nPos) != "N"
            RETURN ""
        ENDIF
        RETURN ALLTRIM(SUBSTR(THIS.this_cJobMvTit, par_nPos, 50))
    ENDFUNC

    *==========================================================================
    * ObterRotuloPersonalizado - Irmao de ObterTituloPersonalizado para
    * job_mv_cpo (rotulo de CAMPO). O unico site no SCX legado e a posicao
    * 3351, que renomeia o "Briefing Extra" da raiz do form.
    *==========================================================================
    FUNCTION ObterRotuloPersonalizado(par_nPos)
        IF VARTYPE(par_nPos) != "N"
            RETURN ""
        ENDIF
        RETURN ALLTRIM(SUBSTR(THIS.this_cJobMvCpo, par_nPos, 50))
    ENDFUNC

    *==========================================================================
    * CarregarDivisaoNotas - Le SigCdEmp.divnotas da empresa do movimento,
    * que decide quais blocos de equipe aparecem na Page3.
    *
    * Transcricao do trecho do Init legado:
    *   .poDataMgr.CursorQuery([SigCdEmp], [LocalEmps], [Cemps],
    *                          TprMvCab.Emps, [DivNotas])
    *   lnEmp = Iif(Eof([LocalEmps]), 1, LocalEmps.DivNotas)
    *
    * ATENCAO ao nome da coluna de empresa: em SigCdEmp e' "cemps" COM C
    * (regra #48 - o prefixo da tabela nao decide, so o schema). Conferido
    * em docs/schema.sql.
    *
    * Empresa nao encontrada / sem conexao mantem o default 1, igual ao
    * Iif(Eof(...), 1, ...) do legado.
    *==========================================================================
    PROCEDURE CarregarDivisaoNotas(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmps, loc_oErro
        loc_lSucesso = .F.

        THIS.this_nDivNotas = 1

        loc_cEmps = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")

        *-- RETURN fora do TRY (regra #1)
        IF EMPTY(loc_cEmps)
            RETURN .F.
        ENDIF
        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_DivNotasTmp")
                IF CURSORGETPROP("Buffering", "cursor_4c_DivNotasTmp") > 1
                    TABLEREVERT(.T., "cursor_4c_DivNotasTmp")
                ENDIF
                USE IN cursor_4c_DivNotasTmp
            ENDIF

            loc_cSQL = "SELECT divnotas FROM SigCdEmp" + ;
                " WHERE RTRIM(cemps) = RTRIM(" + EscaparSQL(loc_cEmps) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DivNotasTmp")

            IF loc_nResultado < 0
                MsgErro("Erro ao consultar a divis" + CHR(227) + "o de notas da empresa " + ;
                        loc_cEmps + ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT cursor_4c_DivNotasTmp
                GO TOP
                IF !EOF("cursor_4c_DivNotasTmp")
                    THIS.this_nDivNotas = TratarNulo(cursor_4c_DivNotasTmp.divnotas, 1)
                ENDIF
                USE IN cursor_4c_DivNotasTmp
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDivisaoNotas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


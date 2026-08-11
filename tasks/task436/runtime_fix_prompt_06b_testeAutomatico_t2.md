# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 56% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'BtnIncluirNavegacao': Unknown member OFORM. | Detalhes: Linha: 1001, Proc: testebtnincluirnavegacao; Teste 'BtnEncerrarExiste': Function argument value, type, or count is invalid. | Detalhes: Linha: 1054, Proc: testebtnencerrarexiste; Teste 'LookupMetodosExistem': Function argument value, type, or count is invalid. | Detalhes: Linha: 1197, Proc: testelookupmetodosexistem

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 22:15:53] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 22:15:53] [INFO] Config FPW: (nao fornecido)
[2026-08-06 22:15:53] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 22:15:53] [INFO] Timeout: 300 segundos
[2026-08-06 22:15:53] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_205ixuzz.prg
[2026-08-06 22:15:53] [INFO] Conteudo do wrapper:
[2026-08-06 22:15:53] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'
QUIT

[2026-08-06 22:15:53] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_205ixuzz.prg
[2026-08-06 22:15:53] [INFO] VFP output esperado em: C:\4c\tasks\task436\vfp_output.txt
[2026-08-06 22:15:53] [INFO] Executando Visual FoxPro 9...
[2026-08-06 22:15:53] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_205ixuzz.prg
[2026-08-06 22:15:53] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_205ixuzz.prg
[2026-08-06 22:15:53] [INFO] Timeout configurado: 300 segundos
[2026-08-06 22:20:53] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 19300)...
[2026-08-06 22:20:55] [INFO] VFP9 finalizado em 302.0690123 segundos
[2026-08-06 22:20:55] [INFO] Exit Code: 4
[2026-08-06 22:20:55] [INFO] 
[2026-08-06 22:20:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 22:20:55] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_205ixuzz.prg
[2026-08-06 22:20:55] [INFO] 
[2026-08-06 22:20:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 22:20:55] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 22:20:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 22:20:55] [INFO] * Parameters: 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'
[2026-08-06 22:20:55] [INFO] 
[2026-08-06 22:20:55] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 22:20:55] [INFO] SET SAFETY OFF
[2026-08-06 22:20:55] [INFO] SET RESOURCE OFF
[2026-08-06 22:20:55] [INFO] SET TALK OFF
[2026-08-06 22:20:55] [INFO] SET NOTIFY OFF
[2026-08-06 22:20:55] [INFO] SYS(2335, 0)
[2026-08-06 22:20:55] [INFO] 
[2026-08-06 22:20:55] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'
[2026-08-06 22:20:55] [INFO] QUIT
[2026-08-06 22:20:55] [INFO] 
[2026-08-06 22:20:55] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 22:20:55] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-06 22:59:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 22:59:01] [INFO] Config FPW: (nao fornecido)
[2026-08-06 22:59:01] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 22:59:01] [INFO] Timeout: 300 segundos
[2026-08-06 22:59:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0vyjhvdx.prg
[2026-08-06 22:59:01] [INFO] Conteudo do wrapper:
[2026-08-06 22:59:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'
QUIT

[2026-08-06 22:59:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0vyjhvdx.prg
[2026-08-06 22:59:01] [INFO] VFP output esperado em: C:\4c\tasks\task436\vfp_output.txt
[2026-08-06 22:59:01] [INFO] Executando Visual FoxPro 9...
[2026-08-06 22:59:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0vyjhvdx.prg
[2026-08-06 22:59:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0vyjhvdx.prg
[2026-08-06 22:59:01] [INFO] Timeout configurado: 300 segundos
[2026-08-06 23:00:08] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 23:00:08] [INFO] VFP9 finalizado em 67.1437375 segundos
[2026-08-06 23:00:08] [INFO] Exit Code: 
[2026-08-06 23:00:08] [INFO] 
[2026-08-06 23:00:08] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 23:00:08] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0vyjhvdx.prg
[2026-08-06 23:00:08] [INFO] 
[2026-08-06 23:00:08] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 23:00:08] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 23:00:08] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 23:00:08] [INFO] * Parameters: 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'
[2026-08-06 23:00:08] [INFO] 
[2026-08-06 23:00:08] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 23:00:08] [INFO] SET SAFETY OFF
[2026-08-06 23:00:08] [INFO] SET RESOURCE OFF
[2026-08-06 23:00:08] [INFO] SET TALK OFF
[2026-08-06 23:00:08] [INFO] SET NOTIFY OFF
[2026-08-06 23:00:08] [INFO] SYS(2335, 0)
[2026-08-06 23:00:08] [INFO] 
[2026-08-06 23:00:08] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGcp', 'C:\4c\tasks\task436', 'CRUD'
[2026-08-06 23:00:08] [INFO] QUIT
[2026-08-06 23:00:08] [INFO] 
[2026-08-06 23:00:08] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 23:00:08] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormGcp",
  "timestamp": "20260806230008",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": false,
      "erro": "Unknown member OFORM.",
      "detalhes": "Linha: 1001, Proc: testebtnincluirnavegacao"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 1054, Proc: testebtnencerrarexiste"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 1197, Proc: testelookupmetodosexistem"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "Objeto form ja era invalido",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 5,
    "falhou": 4,
    "percentual": 56
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormGcp.prg):
*==============================================================================
* FormGcp.prg
* Formulario: Grupos/Contas Permitidas/Nao Permitidas por Operacao (SigCdGcp)
* Tipo      : OPERACIONAL (popup modal - aberto por FormSigCdOpe ou similar)
* BO        : GcpBO
* Tabela    : SigCdGcp
*
* PARAMETROS DE ABERTURA (Init):
*   par_oParentForm : referencia ao form pai (FormSigCdOpe)
*   par_cDopes      : codigo da operacao (SigCdOpe.Dopes)
*   par_cEscolha    : "INSERIR"/"ALTERAR" para acesso restrito, "" = acesso completo
*
* CICLO DE VIDA:
*   1. Form pai chama CREATEOBJECT("FormGcp", oForm, cDopes, cEscolha)
*   2. Init() armazena params e chama DODEFAULT() -> FormBase.Init() -> InicializarForm()
*   3. InicializarForm() cria BO + PageFrame + containers + carrega TmpGcOpe
*   4. Ao encerrar, SalvarTmpGcOpe() persiste mudancas, reabilita form pai e Release()
*==============================================================================

DEFINE CLASS FormGcp AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX FIDELITY)
    * Dimensoes originais: Width=592, Height=375
    *--------------------------------------------------------------------------
    Height      = 375
    Width       = 592
    Caption     = "Grupos / Contas Permitidas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Movable     = .F.
    ClipControls = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *--------------------------------------------------------------------------
    * Objeto de negocio e estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Propriedades de contexto do popup
    *--------------------------------------------------------------------------
    this_oParentForm = .NULL.   && referencia ao form pai
    this_cDopesAtual = ""       && codigo da operacao corrente (ex: "PIX")
    this_cEscolha    = ""       && "" = acesso pleno; "INSERIR"/"ALTERAR" = restrito

    *--------------------------------------------------------------------------
    * Flags de controle de modificacoes (equivalentes a lhouveins/lhouveexcl)
    *--------------------------------------------------------------------------
    this_lHouveIns   = .F.   && houve insercao no TmpGcOpe
    this_lHouveExcl  = .F.   && houve exclusao no TmpGcOpe
    this_cPeAntValue = ""    && valor anterior da celula antes de editar (para change detection)

    *==========================================================================
    * INIT - Recebe contexto do form pai e inicializa
    *==========================================================================
    PROCEDURE Init(par_oParentForm, par_cDopes, par_cEscolha)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Armazenar params ANTES de DODEFAULT (InicializarForm() precisa deles)
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            IF VARTYPE(par_cDopes) = "C" AND !EMPTY(ALLTRIM(par_cDopes))
                THIS.this_cDopesAtual = ALLTRIM(par_cDopes)
                THIS.Caption = "Grupos / Contas Permitidas " + ;
                               PROPER(ALLTRIM(par_cDopes))
            ENDIF

            IF VARTYPE(par_cEscolha) = "C"
                THIS.this_cEscolha = ALLTRIM(par_cEscolha)
            ENDIF

            *-- Desabilitar form pai ANTES de abrir este popup
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            *-- DODEFAULT() -> FormBase.Init() -> THIS.InicializarForm()
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "FormGcp.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Hook chamado por FormBase.Init() via DODEFAULT()
    * Nao chamar diretamente - FormBase.Init() cuida disso
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Instanciar o Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("GcpBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Propagar operacao corrente para o BO
                THIS.this_oBusinessObject.this_cDopesAtual = THIS.this_cDopesAtual

                *-- Construir estrutura visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaPrincipal()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar dados do banco (pular se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarDados()
                ENDIF

                *-- Ajustar botoes conforme modo de acesso (this_cEscolha)
                THIS.AjustarBotoesPorModo()

                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao criar GcpBO", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - Cria o PageFrame com 2 paginas
    * Page1: area de trabalho (grid + controles)
    * Page2: reservada (nao usada neste form)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.

            *-- Page1: area principal de trabalho
            WITH .Page1
                .Caption   = "Principal"
                .Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDWITH

            *-- Page2: reservada
            WITH .Page2
                .Caption   = "Reservada"
                .BackColor = RGB(240, 240, 240)
            ENDWITH
        ENDWITH
        THIS.pgf_4c_Paginas.Visible    = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINAPRINCIPAL - Cria containers vazios na Page1
    * Conteudo (labels, grid, botoes) sera adicionado nas Fases 4-6
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaPrincipal()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * cnt_4c_Cabecalho - Cabecalho escuro com shadow + titulo
        * Original: cntSombra (Top=-1, Left=-2, Width=800, Height=80)
        * Compensacao PageFrame: Top = -1 + 29 = 28
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 28
            .Left        = -2
            .Width       = THIS.Width + 4
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Botoes - Botoes de acao: Inserir e Excluir
        * Original: cmdInserir.Left=366, cmdExcluir.Left=440 (ambos Top=2)
        * Compensacao PageFrame: Top = 2 + 29 = 31 -> container Top = 29
        * Posicao: Left=360 (5px antes de Inserir), Width=155 (2 botoes x 75 + margens)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 155
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Saida - Container canonico para botao Encerrar
        * Original: cmdSair.Left=515, Width~75 (borda direita ~590)
        * Canonico: Left = THIS.Width - 90 = 502, Width = 90
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_BotoesAcao - Area de controles inferiores
        * Engloba: Label1/2, Get_Dgru, Get_DConta, Opt_Permite
        * Original: area a partir de Top=320; compensacao: 320+29=349
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 349
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 55
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Preencher conteudo: grid, botoes e labels (Fase 4)
        THIS.ConfigurarPaginaLista(loc_oPagina)

        *-- Adicionar campos principais - Parte 1 (Fase 5)
        THIS.ConfigurarPaginaDados(loc_oPagina)

        *-- Tornar todos os controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CARREGARDADOS - Carrega TmpGcOpe pelo BO para a operacao corrente
    * Chamado no InicializarForm() e pode ser chamado apos mudanca de operacao
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lResultado, loc_nBlqCtsInicial, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopesAtual))
                loc_lResultado = .T.
            ELSE
                *-- BlqCts inicial: 1=Permitidas (default do form original)
                loc_nBlqCtsInicial = 1
                loc_lResultado = THIS.this_oBusinessObject.CarregarTmpGcOpe( ;
                    THIS.this_cDopesAtual, loc_nBlqCtsInicial)

                *-- Conectar grid ao cursor TmpGcOpe apos carregamento
                IF loc_lResultado AND USED("TmpGcOpe")
                    LOCAL loc_oPg1, loc_oCnt
                    loc_oPg1 = THIS.pgf_4c_Paginas.Page1
                    loc_oCnt = loc_oPg1.cnt_4c_BotoesAcao

                    loc_oGrid = loc_oPg1.grd_4c_Dados
                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.RecordSource = "TmpGcOpe"
                        loc_oGrid.Column1.ControlSource = "TmpGcOpe.Grupos"
                        loc_oGrid.Column2.ControlSource = "TmpGcOpe.Contas"
                        loc_oGrid.Column3.ControlSource = "TmpGcOpe.OriDes"
                        loc_oGrid.Column1.Header1.Caption = "Grupo"
                        loc_oGrid.Column2.Header1.Caption = "Conta"
                        loc_oGrid.Column3.Header1.Caption = "O/D/A"
                        *-- DynamicForeColor: azul para Permitidas (BlqCts!=2), rosa para Nao Permitidas (BlqCts=2)
                        loc_oGrid.SetAll("DynamicForeColor", ;
                            "IIF(TmpGcOpe.BlqCts = 2, RGB(255,0,128), RGB(0,0,128))", "Column")
                        loc_oGrid.Refresh()
                    ENDIF

                    *-- ControlSource dos campos de display (requer TmpGcOpe ativo)
                    IF VARTYPE(loc_oCnt) = "O"
                        IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
                            loc_oCnt.txt_4c_Dgru.ControlSource = "TmpGcOpe.Dgrus"
                        ENDIF
                        IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
                            loc_oCnt.txt_4c_DConta.ControlSource = "TmpGcOpe.Rclis"
                        ENDIF

                        *-- Valor inicial do OptionGroup baseado no BlqCts do primeiro registro
                        IF VARTYPE(loc_oCnt.opt_4c_Permite) = "O"
                            SELECT TmpGcOpe
                            GO TOP IN TmpGcOpe
                            IF !EOF("TmpGcOpe")
                                loc_oCnt.opt_4c_Permite.Value = IIF(TmpGcOpe.BlqCts = 2, 2, 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.CarregarDados")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - Alterna entre paginas do PageFrame
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        RETURN .T.
    ENDPROC

    *==========================================================================
    * TORNARCONTROLESVISIVEIS - Torna controles visiveis recursivamente
    * Necessario pois AddObject() cria controles com Visible=.F. por padrao
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- PageFrame: iterar Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Container com filhos: recursao
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALIST A - Adiciona Grid e Botoes na Page1
    * Chamado por ConfigurarPaginaPrincipal apos criar os containers base
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)
        LOCAL loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        *----------------------------------------------------------------------
        * Labels do cabecalho (cnt_4c_Cabecalho)
        * Original: lblSombra.Top=18/Left=10 (sombra preta), lblTitulo.Top=17/Left=10 (branco)
        *----------------------------------------------------------------------
        loc_oCab = par_oPagina.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 12
            .Width     = loc_oCab.Width - 14
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 17
            .Left      = 10
            .Width     = loc_oCab.Width - 14
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Botoes em cnt_4c_Botoes: Inserir e Excluir
        * Original: cmdInserir.Left=366 Top=2, cmdExcluir.Left=440 Top=2
        * Container Left=360 -> Inserir.Left=5 (=366-360-1), Excluir.Left=80 (=440-360)
        *----------------------------------------------------------------------
        loc_oBotoes = par_oPagina.cnt_4c_Botoes

        loc_oBotoes.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Inserir
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Botao Encerrar em cnt_4c_Saida (canonico)
        * Original: cmdSair.Left=515, Top=2 -> cnt_4c_Saida.Left=THIS.Width-90
        *----------------------------------------------------------------------
        loc_oSaida = par_oPagina.cnt_4c_Saida
        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * BINDEVENTs para botoes (metodos devem ser PUBLIC)
        *----------------------------------------------------------------------
        BINDEVENT(loc_oBotoes.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Labels informativos: O=Origem, D=Destino, A=Ambos (Say1/2/3 do legado)
        * Original: Say1.Top=180, Say2.Top=195, Say3.Top=210; Left=386; Width=75
        * Com compensacao +29: Top = 209, 224, 239
        *----------------------------------------------------------------------
        par_oPagina.AddObject("lbl_4c_LegO", "Label")
        WITH par_oPagina.lbl_4c_LegO
            .Caption   = "O = Origem"
            .Top       = 209
            .Left      = 386
            .Width     = 75
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(216, 39, 70)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LegD", "Label")
        WITH par_oPagina.lbl_4c_LegD
            .Caption   = "D = Destino"
            .Top       = 224
            .Left      = 386
            .Width     = 75
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(216, 39, 70)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LegA", "Label")
        WITH par_oPagina.lbl_4c_LegA
            .Caption   = "A = Ambos"
            .Top       = 239
            .Left      = 386
            .Width     = 75
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(216, 39, 70)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Grid grd_4c_Dados (equivale a GradeSubN do legado)
        * Original: top=91, left=141, width=237, height=221, columnCount=3
        * Com compensacao PageFrame +29: top=120
        * RecordSource sera setado em CarregarDados() apos TmpGcOpe existir
        *----------------------------------------------------------------------
        par_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = par_oPagina.grd_4c_Dados

        loc_oGrid.Top         = 120
        loc_oGrid.Left        = 141
        loc_oGrid.Width       = 237
        loc_oGrid.Height      = 221
        loc_oGrid.ColumnCount = 3

        WITH loc_oGrid
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH

        loc_oGrid.Column1.Width          = 60
        loc_oGrid.Column1.Header1.Caption = "Grupo"
        loc_oGrid.Column2.Width          = 100
        loc_oGrid.Column2.Header1.Caption = "Conta"
        loc_oGrid.Column3.Width          = 75
        loc_oGrid.Column3.Header1.Caption = "O/D/A"

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")

        *----------------------------------------------------------------------
        * BINDEVENTs para validacao de celulas do Grid (Column1/2/3 Text1)
        * Equivalem aos eventos When/Valid/LostFocus das colunas no legado
        *----------------------------------------------------------------------
        BINDEVENT(loc_oGrid.Column1.Text1, "When",      THIS, "GridCol1WhenEvent")
        BINDEVENT(loc_oGrid.Column1.Text1, "Valid",     THIS, "GridCol1ValidEvent")
        BINDEVENT(loc_oGrid.Column1.Text1, "LostFocus", THIS, "GridCol1LostFocusEvent")
        BINDEVENT(loc_oGrid.Column2.Text1, "When",      THIS, "GridCol2WhenEvent")
        BINDEVENT(loc_oGrid.Column2.Text1, "Valid",     THIS, "GridCol2ValidEvent")
        BINDEVENT(loc_oGrid.Column3.Text1, "Valid",     THIS, "GridCol3ValidEvent")
    ENDPROC

    *==========================================================================
    * GRIDDADOSAFTERROWCOLCHANGE - Refresh dos campos de exibicao ao mudar linha
    * Equivale a GradeSubN.AfterRowColChange do legado
    *==========================================================================
    PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg1, loc_oCnt
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oCnt = loc_oPg1.cnt_4c_BotoesAcao
        *-- Refresh dos campos de display Dgru/DConta (controles da Fase 5)
        IF TYPE("loc_oCnt.txt_4c_Dgru") = "O"
            loc_oCnt.txt_4c_Dgru.Refresh()
        ENDIF
        IF TYPE("loc_oCnt.txt_4c_DConta") = "O"
            loc_oCnt.txt_4c_DConta.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNINSERICLICK - Insere nova linha em branco no TmpGcOpe
    * Equivale a cmdInserir.Click do legado
    *==========================================================================
    PROCEDURE BtnInserirClick()
        LOCAL loc_oPg1, loc_nBlqCts
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_nBlqCts = THIS.this_oBusinessObject.this_nBlqCtsAtual

        IF !USED("TmpGcOpe")
            RETURN
        ENDIF

        TRY
            *-- Verificar se ja ha linha em branco (nao inserir multiplas linhas vazias)
            SELECT TmpGcOpe
            LOCATE FOR EMPTY(ALLTRIM(Grupos))
            IF !EOF()
                loc_oPg1.grd_4c_Dados.Refresh()
                IF THIS.Visible
                    loc_oPg1.grd_4c_Dados.Column1.SetFocus
                ENDIF
                RETURN
            ENDIF

            *-- Inserir nova linha com valores padrao em branco
            THIS.this_lHouveIns = .T.
            INSERT INTO TmpGcOpe ;
                (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts) ;
                VALUES ("", THIS.this_cDopesAtual, " ", " ", " ", loc_nBlqCts)

            SELECT TmpGcOpe
            loc_oPg1.grd_4c_Dados.Refresh()
            IF THIS.Visible
                loc_oPg1.grd_4c_Dados.Column1.SetFocus
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.BtnInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - Exclui linha selecionada do TmpGcOpe
    * Equivale a cmdExcluir.Click do legado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF USED("TmpGcOpe") AND !EOF("TmpGcOpe")
            THIS.this_lHouveExcl = .T.
            SELECT TmpGcOpe
            DELETE
            SKIP
            SKIP -1
        ENDIF

        loc_oPg1.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Salva mudancas e fecha o popup
    * Equivale a cmdSair.Click do legado (inclui validacao de duplicatas via BO)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lResultado, loc_nBlqCts, loc_oPg1
        loc_lResultado = .T.
        loc_nBlqCts    = THIS.this_oBusinessObject.this_nBlqCtsAtual
        loc_oPg1       = THIS.pgf_4c_Paginas.Page1

        *-- Obter BlqCts do OptionGroup se ja existir (Fase 5 adiciona opt_4c_Permite)
        IF TYPE("loc_oPg1.cnt_4c_BotoesAcao.opt_4c_Permite") = "O"
            loc_nBlqCts = loc_oPg1.cnt_4c_BotoesAcao.opt_4c_Permite.Value
        ENDIF

        *-- Salvar apenas se houve modificacoes
        IF THIS.this_lHouveIns OR THIS.this_lHouveExcl
            *-- SalvarTmpGcOpe: limpa brancos, valida duplicatas, persiste
            loc_lResultado = THIS.this_oBusinessObject.SalvarTmpGcOpe( ;
                THIS.this_cDopesAtual, loc_nBlqCts)
        ENDIF

        *-- So fechar se salvou OK (ou nao havia modificacoes)
        IF loc_lResultado
            THIS.ControlarBotoesPai(.T.)
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CONTROLARBOTOESPAI - Habilita/desabilita botoes do form pai
    * Equivale ao mCtrlBotoes() do legado
    * O form pai e reabilitado/desabilitado conforme o popup abre/fecha
    *==========================================================================
    PROCEDURE ControlarBotoesPai(par_lHabilita)
        LOCAL loc_lHabilita
        loc_lHabilita = (VARTYPE(par_lHabilita) = "L" AND par_lHabilita)

        IF VARTYPE(THIS.this_oParentForm) = "O"
            TRY
                THIS.this_oParentForm.Enabled = loc_lHabilita
            CATCH TO loException
                MostrarErro(loException, "FormGcp.ControlarBotoesPai")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADADOS - Adiciona controles inferiores em cnt_4c_BotoesAcao
    * Fase 5/8: Primeiros 50% - Labels Grupo/Conta e txt_4c_Dgru (display-only)
    *
    * Mapeamento de coordenadas (original -> container):
    *   Container cnt_4c_BotoesAcao: Top=349 (=320+29), Left=0
    *   Top relativo = Top_original + 29 - 349
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_BotoesAcao

        *----------------------------------------------------------------------
        * lbl_4c_LblGrupo - Label "Grupo : " (equivale a Label1 do legado)
        * Original: Top=323, Left=57, Width=45, Height=17
        * No container (Top=349): relative Top = 323+29-349 = 3
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupo
            .Caption   = "Grupo : "
            .Top       = 3
            .Left      = 57
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * txt_4c_Dgru - TextBox read-only exibindo descricao do grupo corrente
        * Equivale a Get_Dgru do legado (When retorna .F. = nao editavel)
        * Original: Top=320, Left=104, Width=289, Height=23
        * No container: relative Top = 320+29-349 = 0
        * Exibe TmpGcOpe.Dgrus (preenchido apos validar Column1 do grid)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oCnt.txt_4c_Dgru
            .Top           = 0
            .Left          = 104
            .Width         = 289
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 225)
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * lbl_4c_LblConta - Label "Conta : " (equivale a Label2 do legado)
        * Original: Top=346, Left=57, Width=45, Height=17
        * No container: relative Top = 346+29-349 = 26
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
        WITH loc_oCnt.lbl_4c_LblConta
            .Caption   = "Conta : "
            .Top       = 26
            .Left      = 57
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * txt_4c_DConta - TextBox read-only exibindo descricao da conta corrente
        * Equivale a Get_DConta do legado (When retorna .F. = nao editavel)
        * Original: Top=344, Left=104, Width=289, Height=23
        * No container (Top=349): relative Top = 344+29-349 = 24
        * ControlSource = "TmpGcOpe.Rclis" (setado em CarregarDados)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .Top           = 24
            .Left          = 104
            .Width         = 289
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 225)
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * opt_4c_Permite - OptionGroup "Permitidas / Nao Permitidas"
        * Equivale a Opt_Permite do legado
        * Original: Top=321, Left=408, Width=127, Height=46, ButtonCount=2
        * No container (Top=349): relative Top = 321+29-349 = 1
        * Value=1 = Permitidas, Value=2 = Nao Permitidas
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("opt_4c_Permite", "OptionGroup")
        WITH loc_oCnt.opt_4c_Permite
            .Top         = 1
            .Left        = 408
            .Width       = 127
            .Height      = 46
            .ButtonCount = 2
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 1
            .BorderColor = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Visible     = .T.
        ENDWITH

        WITH loc_oCnt.opt_4c_Permite.Buttons(1)
            .Caption   = "Permitidas"
            .Left      = 5
            .Top       = 5
            .Width     = 79
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        WITH loc_oCnt.opt_4c_Permite.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Permitidas"
            .Left      = 5
            .Top       = 24
            .Width     = 103
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- BINDEVENT para InteractiveChange do OptionGroup
        BINDEVENT(loc_oCnt.opt_4c_Permite, "InteractiveChange", THIS, "OptPermiteInteractiveChange")
    ENDPROC

    *==========================================================================
    * GRIDCOL1WHENEVENT - Salva valor anterior da celula Grupo antes de editar
    * Equivale a GradeSubN.Column1.Text1.When do legado
    *==========================================================================
    PROCEDURE GridCol1WhenEvent()
        LOCAL loc_oGrd
        loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            THIS.this_cPeAntValue = ALLTRIM(loc_oGrd.Column1.Text1.Value)
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GRIDCOL1VALIDEVENT - Valida Grupo e atualiza descricao Dgrus em TmpGcOpe
    * Equivale a GradeSubN.Column1.Text1.Valid do legado
    *==========================================================================
    PROCEDURE GridCol1ValidEvent()
        LOCAL loc_lResultado, loc_oGrd, loc_cValor, loc_cSQL, loc_nResult
        loc_lResultado = .T.

        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF VARTYPE(loc_oGrd) != "O"
                loc_lResultado = .T.
            ENDIF
            loc_cValor = ALLTRIM(loc_oGrd.Column1.Text1.Value)

            IF !EMPTY(loc_cValor)
                *-- Buscar descricao do grupo em SigCdGcr
                loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
                IF loc_nResult > 0
                    IF RECCOUNT("cursor_4c_GrupoDesc") > 0
                        SELECT cursor_4c_GrupoDesc
                        IF USED("TmpGcOpe")
                            REPLACE Dgrus WITH ALLTRIM(cursor_4c_GrupoDesc.Descrs) IN TmpGcOpe
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_GrupoDesc
                ENDIF
            ENDIF

            IF loc_cValor != THIS.this_cPeAntValue
                THIS.this_lHouveIns = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.GridCol1ValidEvent")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GRIDCOL1LOSTFOCUSEVENT - Se Grupo em branco, move foco para Encerrar
    * Equivale a GradeSubN.Column1.Text1.LostFocus do legado
    *==========================================================================
    PROCEDURE GridCol1LostFocusEvent()
        LOCAL loc_oGrd, loc_cValor
        loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_cValor = ALLTRIM(loc_oGrd.Column1.Text1.Value)
            IF EMPTY(loc_cValor)
                TRY
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar.SetFocus
                CATCH
                ENDTRY
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GRIDCOL2WHENEVENT - Salva valor anterior da celula Conta antes de editar
    * Equivale a GradeSubN.Column2.Text1.When do legado
    *==========================================================================
    PROCEDURE GridCol2WhenEvent()
        LOCAL loc_oGrd
        loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            THIS.this_cPeAntValue = ALLTRIM(loc_oGrd.Column2.Text1.Value)
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GRIDCOL2VALIDEVENT - Valida Conta e atualiza descricao Rclis em TmpGcOpe
    * Equivale a GradeSubN.Column2.Text1.Valid do legado
    * Original: verifica fAcessoContas + busca Rclis de SigCdCli onde Iclis=conta
    *==========================================================================
    PROCEDURE GridCol2ValidEvent()
        LOCAL loc_lResultado, loc_oGrd, loc_cValor, loc_cGrupo, loc_cSQL, loc_nResult
        loc_lResultado = .T.

        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF VARTYPE(loc_oGrd) != "O"
                loc_lResultado = .T.
            ENDIF

            loc_cValor  = ALLTRIM(loc_oGrd.Column2.Text1.Value)
            loc_cGrupo  = ALLTRIM(loc_oGrd.Column1.Text1.Value)

            IF !EMPTY(loc_cValor)
                *-- Buscar descricao da conta em SigCdCli
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDesc")
                IF loc_nResult > 0
                    IF RECCOUNT("cursor_4c_ContaDesc") > 0
                        SELECT cursor_4c_ContaDesc
                        IF USED("TmpGcOpe")
                            REPLACE Rclis WITH ALLTRIM(cursor_4c_ContaDesc.Rclis) IN TmpGcOpe
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_ContaDesc
                ENDIF
            ENDIF

            IF loc_cValor != THIS.this_cPeAntValue
                THIS.this_lHouveIns = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.GridCol2ValidEvent")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GRIDCOL3VALIDEVENT - Valida que OriDes seja O, D ou A
    * Equivale a GradeSubN.Column3.Text1.Valid do legado
    *==========================================================================
    PROCEDURE GridCol3ValidEvent()
        LOCAL loc_oGrd, loc_cValor
        loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        IF VARTYPE(loc_oGrd) != "O"
            RETURN .T.
        ENDIF
        loc_cValor = ALLTRIM(loc_oGrd.Column3.Text1.Value)
        IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "O", "D", "A")
            MsgAviso("Op" + CHR(231) + CHR(227) + "o Incorreta!!! Use O, D ou A.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * OPTPERMITEINTERACTIVECHANGE - Atualiza BlqCts de todos os registros TmpGcOpe
    * Equivale a Opt_Permite.InteractiveChange do legado
    *==========================================================================
    PROCEDURE OptPermiteInteractiveChange()
        LOCAL loc_oPg1, loc_oCnt, loc_nAntValue, loc_nNovoValue, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oCnt = loc_oPg1.cnt_4c_BotoesAcao

        IF !USED("TmpGcOpe")
            RETURN
        ENDIF

        TRY
            loc_nAntValue  = TmpGcOpe.BlqCts
            loc_nNovoValue = loc_oCnt.opt_4c_Permite.Value

            *-- Atualizar BlqCts em todos os registros do cursor local TmpGcOpe
            UPDATE TmpGcOpe SET BlqCts = loc_nNovoValue
            GO BOTTOM IN TmpGcOpe

            loc_oGrid = loc_oPg1.grd_4c_Dados
            IF VARTYPE(loc_oGrid) = "O"
                loc_oGrid.Refresh()
            ENDIF

            IF loc_nNovoValue != loc_nAntValue
                THIS.this_lHouveIns = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.OptPermiteInteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - Insere nova linha em branco no TmpGcOpe (alias CRUD)
    * Equivale a cmdInserir.Click do legado; delega para BtnInserirClick
    * (mantido para compatibilidade com o padrao CRUD do sistema novo)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg1, loc_nBlqCts
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_nBlqCts = THIS.this_oBusinessObject.this_nBlqCtsAtual

        *-- Restricao de acesso: modo "ALTERAR" nao permite inserir
        IF UPPER(ALLTRIM(THIS.this_cEscolha)) == "ALTERAR"
            MsgAviso("Acesso negado para inser" + CHR(231) + CHR(227) + "o.", ;
                     "Aten" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN
        ENDIF

        *-- TmpGcOpe criado apenas em CarregarDados (exige Dopes e conexao ao banco)
        IF !USED("TmpGcOpe")
            RETURN
        ENDIF

        TRY
            *-- Evitar linha em branco duplicada
            SELECT TmpGcOpe
            LOCATE FOR EMPTY(ALLTRIM(Grupos))
            IF !EOF()
                loc_oPg1.grd_4c_Dados.Refresh()
                RETURN
            ENDIF

            THIS.this_lHouveIns = .T.
            INSERT INTO TmpGcOpe ;
                (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts) ;
                VALUES ("", THIS.this_cDopesAtual, " ", " ", " ", loc_nBlqCts)

            SELECT TmpGcOpe
            loc_oPg1.grd_4c_Dados.Refresh()
            *-- SetFocus apenas quando o form esta visivel (evita Show() implicito em testes)
            IF THIS.Visible
                loc_oPg1.grd_4c_Dados.Column1.SetFocus
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - Coloca a linha corrente do grid em modo de edicao
    * Em forms OPERACIONAL a edicao acontece inline no grid: dar foco na
    * primeira coluna da linha selecionada equivale a "Alterar" do CRUD.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg1, loc_oGrid
        loc_oPg1  = THIS.pgf_4c_Paginas.Page1
        loc_oGrid = loc_oPg1.grd_4c_Dados

        *-- Restricao de acesso: modo "INSERIR" nao permite alterar
        IF UPPER(ALLTRIM(THIS.this_cEscolha)) == "INSERIR"
            MsgAviso("Acesso negado para altera" + CHR(231) + CHR(227) + "o.", ;
                     "Aten" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !USED("TmpGcOpe") OR EOF("TmpGcOpe")
            MsgAviso("Nenhum registro selecionado para altera" + CHR(231) + CHR(227) + "o.", ;
                     "Aten" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.this_lHouveIns = .T.
        IF VARTYPE(loc_oGrid) = "O"
            loc_oGrid.SetFocus
            loc_oGrid.Column1.SetFocus
            loc_oGrid.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Atualiza os campos de exibicao Dgru/DConta
    * Em forms OPERACIONAL a "visualizacao" e a propria linha selecionada
    * no grid: refresh dos campos de display reproduz o comportamento.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPg1, loc_oCnt, loc_oGrid
        loc_oPg1  = THIS.pgf_4c_Paginas.Page1
        loc_oCnt  = loc_oPg1.cnt_4c_BotoesAcao
        loc_oGrid = loc_oPg1.grd_4c_Dados

        IF !USED("TmpGcOpe") OR EOF("TmpGcOpe")
            MsgAviso("Nenhum registro selecionado para visualiza" + CHR(231) + CHR(227) + "o.", ;
                     "Aten" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT TmpGcOpe

        *-- Refresh dos campos de display (descricoes Grupo/Conta)
        IF VARTYPE(loc_oCnt) = "O"
            IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
                loc_oCnt.txt_4c_Dgru.Refresh()
            ENDIF
            IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
                loc_oCnt.txt_4c_DConta.Refresh()
            ENDIF
            *-- Sincroniza OptionGroup com o BlqCts do registro corrente
            IF VARTYPE(loc_oCnt.opt_4c_Permite) = "O"
                loc_oCnt.opt_4c_Permite.Value = IIF(TmpGcOpe.BlqCts = 2, 2, 1)
            ENDIF
        ENDIF

        IF VARTYPE(loc_oGrid) = "O"
            loc_oGrid.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CARRERLISTA - Alias para CarregarDados() (compatibilidade com padrao CRUD)
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BTNBUSCARCLICK - Abre lookup para o campo Grupo (Column1 do grid)
    * Permite selecionar um grupo de SigCdGcr e preencher na linha corrente
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_oPg1, loc_oGrid, loc_cGrupo, loc_cDescrs
        loc_oPg1  = THIS.pgf_4c_Paginas.Page1
        loc_oGrid = loc_oPg1.grd_4c_Dados

        IF !USED("TmpGcOpe") OR EOF("TmpGcOpe")
            MsgAviso("Selecione ou insira uma linha no grid antes de buscar.", ;
                     "Busca")
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", "", ;
                "Buscar Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_cGrupo  = ALLTRIM(Codigos)
                    loc_cDescrs = ALLTRIM(Descrs)

                    IF USED("TmpGcOpe") AND !EOF("TmpGcOpe")
                        SELECT TmpGcOpe
                        REPLACE Grupos WITH loc_cGrupo, Dgrus WITH loc_cDescrs
                        THIS.this_lHouveIns = .T.
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormGcp.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF

        IF VARTYPE(loc_oGrid) = "O"
            loc_oGrid.Refresh()
        ENDIF

        IF VARTYPE(loc_oPg1.cnt_4c_BotoesAcao) = "O"
            IF VARTYPE(loc_oPg1.cnt_4c_BotoesAcao.txt_4c_Dgru) = "O"
                loc_oPg1.cnt_4c_BotoesAcao.txt_4c_Dgru.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - Salva TmpGcOpe sem fechar o popup
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_nBlqCts, loc_oPg1
        loc_lResultado = .T.
        loc_nBlqCts    = THIS.this_oBusinessObject.this_nBlqCtsAtual
        loc_oPg1       = THIS.pgf_4c_Paginas.Page1

        IF TYPE("loc_oPg1.cnt_4c_BotoesAcao.opt_4c_Permite") = "O"
            loc_nBlqCts = loc_oPg1.cnt_4c_BotoesAcao.opt_4c_Permite.Value
        ENDIF

        IF THIS.this_lHouveIns OR THIS.this_lHouveExcl
            loc_lResultado = THIS.this_oBusinessObject.SalvarTmpGcOpe( ;
                THIS.this_cDopesAtual, loc_nBlqCts)

            IF loc_lResultado
                THIS.this_lHouveIns  = .F.
                THIS.this_lHouveExcl = .F.
                MsgInfo("Registros salvos com sucesso!", "Salvar")
            ENDIF
        ELSE
            MsgInfo("Nenhuma altera" + CHR(231) + CHR(227) + "o a salvar.", "Salvar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNCANCELARCLICK - Fecha popup sem salvar, pedindo confirmacao se houve mudancas
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lConfirmar
        loc_lConfirmar = .T.

        IF THIS.this_lHouveIns OR THIS.this_lHouveExcl
            loc_lConfirmar = MsgConfirma( ;
                "Existem altera" + CHR(231) + CHR(245) + "es n" + ;
                CHR(227) + "o salvas. Deseja descartar?" + CHR(13) + ;
                "Clique SIM para fechar sem salvar.", ;
                "Cancelar")
        ENDIF

        IF loc_lConfirmar
            THIS.ControlarBotoesPai(.T.)
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * FORMPARABO - Transfere dados do formulario para o BO
    * OPERACIONAL: le linha corrente de TmpGcOpe -> propriedades do BO
    *==========================================================================
    PROCEDURE FormParaBO()
        IF !USED("TmpGcOpe") OR EOF("TmpGcOpe")
            RETURN .F.
        ENDIF

        SELECT TmpGcOpe
        THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(CidChaves)
        THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(Dopes)
        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(Grupos)
        THIS.this_oBusinessObject.this_cContas    = ALLTRIM(Contas)
        THIS.this_oBusinessObject.this_cOriDes    = ALLTRIM(OriDes)
        THIS.this_oBusinessObject.this_nBlqCts    = BlqCts
        THIS.this_oBusinessObject.this_cDgrus     = ALLTRIM(Dgrus)
        THIS.this_oBusinessObject.this_cRclis     = ALLTRIM(Rclis)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOPARAFORM - Transfere dados do BO para os campos de display do formulario
    * OPERACIONAL: atualiza TextBoxes de descricao (Dgru/DConta)
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg1, loc_oCnt
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oCnt = loc_oPg1.cnt_4c_BotoesAcao

        IF VARTYPE(loc_oCnt) = "O"
            IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
                loc_oCnt.txt_4c_Dgru.Value = THIS.this_oBusinessObject.this_cDgrus
            ENDIF
            IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
                loc_oCnt.txt_4c_DConta.Value = THIS.this_oBusinessObject.this_cRclis
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HABILITARCAMPOS - Habilita ou desabilita controles de edicao
    * Respeita restricoes de this_cEscolha (INSERIR/ALTERAR)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1, loc_oBotoes, loc_oGrid, loc_lHabilita
        loc_lHabilita = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
        loc_oPg1      = THIS.pgf_4c_Paginas.Page1
        loc_oBotoes   = loc_oPg1.cnt_4c_Botoes
        loc_oGrid     = loc_oPg1.grd_4c_Dados

        IF VARTYPE(loc_oGrid) = "O"
            loc_oGrid.ReadOnly = !loc_lHabilita
        ENDIF

        IF VARTYPE(loc_oBotoes) = "O"
            IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
                loc_oBotoes.cmd_4c_Inserir.Enabled = loc_lHabilita AND ;
                    UPPER(ALLTRIM(THIS.this_cEscolha)) != "ALTERAR"
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
                loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lHabilita AND ;
                    UPPER(ALLTRIM(THIS.this_cEscolha)) != "INSERIR"
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Limpa campos de exibicao (descricoes Grupo e Conta)
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg1, loc_oCnt
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oCnt = loc_oPg1.cnt_4c_BotoesAcao

        IF VARTYPE(loc_oCnt) = "O"
            IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
                loc_oCnt.txt_4c_Dgru.Value = ""
            ENDIF
            IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
                loc_oCnt.txt_4c_DConta.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AJUSTARBOTOESSPORMODO - Ajusta habilitacao dos botoes conforme this_cEscolha
    * "" = acesso pleno / "INSERIR" = apenas inserir / "ALTERAR" = apenas alterar
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oBotoes, loc_cEscolha
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_cEscolha = UPPER(ALLTRIM(THIS.this_cEscolha))

        IF TYPE("loc_oPg1.cnt_4c_Botoes") != "O"
            RETURN
        ENDIF
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes

        DO CASE
        CASE loc_cEscolha == "INSERIR"
            IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
                loc_oBotoes.cmd_4c_Inserir.Enabled = .T.
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
                loc_oBotoes.cmd_4c_Excluir.Enabled = .F.
            ENDIF

        CASE loc_cEscolha == "ALTERAR"
            IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
                loc_oBotoes.cmd_4c_Inserir.Enabled = .F.
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
                loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
            ENDIF

        OTHERWISE
            IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
                loc_oBotoes.cmd_4c_Inserir.Enabled = .T.
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
                loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
            ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * DESTROY - Libera recursos, reabilita form pai e solta cursores
    *==========================================================================
    PROCEDURE Destroy()
        *-- Reabilitar form pai (garante que nao fica travado mesmo se houver erro)
        THIS.ControlarBotoesPai(.T.)

        *-- Liberar BO
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\GcpBO.prg):
*==============================================================================
* GcpBO.prg
* Business Object: Grupos/Contas Permitidas por Operacao (SigCdGcp)
* Herda de: BusinessBase
*
* Tabela principal: SigCdGcp
* Chave primaria  : cidchaves (char 20, gerado via GerarCidChaves)
*
* SigCdGcp schema:
*   cidchaves  char(20) PK
*   contas     char(10) FK SigCdCli.iclis
*   dopes      char(20) FK SigCdOpe.Dopes
*   grupos     char(10) FK SigCdGcr.Codigos
*   orides     char(1)  O=Origem / D=Destino / A=Ambos
*   blqcts     numeric(1,0)  1=Permitidas / 2=Nao Permitidas
*==============================================================================

DEFINE CLASS GcpBO AS BusinessBase

    *-- Identificacao da tabela (exigido pelo BusinessBase)
    this_cTabela     = "SigCdGcp"
    this_cCampoChave = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - mapeamento direto das colunas de SigCdGcp
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && char(20) - chave unica PK
    this_cContas    = ""   && char(10) - codigo da conta/cliente (FK SigCdCli.iclis)
    this_cDopes     = ""   && char(20) - codigo da operacao (FK SigCdOpe.Dopes)
    this_cGrupos    = ""   && char(10) - codigo do grupo contabil (FK SigCdGcr.Codigos)
    this_cOriDes    = ""   && char(1)  - O=Origem / D=Destino / A=Ambos
    this_nBlqCts    = 0    && numeric(1,0) - 1=Permitidas / 2=Nao Permitidas

    *--------------------------------------------------------------------------
    * Propriedades desnormalizadas (preenchidas via JOIN no carregamento)
    *--------------------------------------------------------------------------
    this_cDgrus = ""   && descricao do grupo  (SigCdGcr.Descrs)
    this_cRclis = ""   && nome do cliente/conta (SigCdCli.Rclis)

    *--------------------------------------------------------------------------
    * Propriedades de contexto de colecao
    * Este BO gerencia um CONJUNTO de registros para uma operacao
    *--------------------------------------------------------------------------
    this_cDopesAtual  = ""  && operacao atualmente sendo editada (filtro da colecao)
    this_nBlqCtsAtual = 1   && status da colecao (1=Permitidas / 2=Nao Permitidas)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGcp"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidChaves - Gera chave unica de 20 caracteres (substituto de fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidChaves()
        LOCAL loc_cParte1, loc_cParte2
        loc_cParte1 = ALLTRIM(SYS(2015))
        loc_cParte2 = ALLTRIM(SYS(2015))
        RETURN PADR(loc_cParte1 + loc_cParte2, 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cContas    = TratarNulo(contas,    "C")
            THIS.this_cDopes     = TratarNulo(dopes,     "C")
            THIS.this_cGrupos    = TratarNulo(grupos,    "C")
            THIS.this_cOriDes    = TratarNulo(orides,    "C")
            THIS.this_nBlqCts    = TratarNulo(blqcts,    "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigCdGcp com JOIN de descricoes
    * par_cFiltro: filtro adicional WHERE (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(THIS.this_cDopesAtual)
                loc_cWhere = "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopesAtual)
            ENDIF
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = "WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " " + loc_cWhere + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao buscar grupos/contas:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo CidChaves
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = THIS.GerarCidChaves()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                       " (CidChaves, Contas, Dopes, Grupos, OriDes, BlqCts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cContas)    + ", " + ;
                       EscaparSQL(THIS.this_cDopes)     + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       EscaparSQL(THIS.this_cOriDes)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqCts) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcp SET" + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas)         + "," + ;
                       " Dopes  = " + EscaparSQL(THIS.this_cDopes)          + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos)         + "," + ;
                       " OriDes = " + EscaparSQL(THIS.this_cOriDes)         + "," + ;
                       " BlqCts = " + FormatarNumeroSQL(THIS.this_nBlqCts)  + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGcp" + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTmpGcOpe - Cria cursor local TmpGcOpe com dados de uma operacao
    * par_cDopes  : codigo da operacao (SigCdOpe.Dopes)
    * par_nBlqCts : BlqCts inicial (1=Permitidas / 2=Nao Permitidas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cDopesAtual  = par_cDopes
            THIS.this_nBlqCtsAtual = par_nBlqCts

            IF USED("TmpGcOpe")
                USE IN TmpGcOpe
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpGcOpe ;
                (CidChaves C(20), Dopes C(20), Grupos C(10), Contas C(10), ;
                 Dgrus C(60), Rclis C(80), OriDes C(1), BlqCts N(1))
            SET NULL OFF

            loc_cSQL = "SELECT a.CidChaves, a.Dopes, a.Grupos, a.Contas," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis," + ;
                       " a.OriDes, a.BlqCts" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes) + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcpTemp")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_GcpTemp") > 0
                    SELECT TmpGcOpe
                    APPEND FROM DBF("cursor_4c_GcpTemp")
                ENDIF
                SELECT TmpGcOpe
                GO TOP
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos/contas da opera" + ;
                            CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_GcpTemp")
                USE IN cursor_4c_GcpTemp
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarTmpGcOpe")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicatas - Verifica se ha Grupos/Contas duplicados no TmpGcOpe
    * Retorna .T. se NAO ha duplicatas (pode salvar)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicatas()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF

            SELECT Grupos, Contas, SUM(1) AS Total ;
                FROM TmpGcOpe ;
                GROUP BY Grupos, Contas ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_SecKey NOFILTER

            IF RECCOUNT("cursor_4c_SecKey") > 0
                MostrarErro("Existem Grupos/Contas em duplicidade. Favor acertar!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarDuplicatas")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarTmpGcOpe - Persiste TmpGcOpe no banco (SigCdGcp) para a operacao
    * Deleta registros antigos da operacao e insere os do TmpGcOpe
    * par_cDopes  : codigo da operacao
    * par_nBlqCts : BlqCts a aplicar em todos os registros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cChave, loc_cGrupos, loc_cContas, loc_cOriDes, loc_nBlqCts
        loc_lResultado = .F.

        TRY
            IF !USED("TmpGcOpe")
                MostrarErro("Cursor TmpGcOpe n" + CHR(227) + ;
                            "o encontrado!", "Erro")
            ELSE
                *-- Remove linhas em branco do cursor local
                SELECT TmpGcOpe
                DELETE FOR EMPTY(ALLTRIM(Grupos)) OR EMPTY(ALLTRIM(Contas))
                PACK

                *-- Valida duplicatas antes de persistir
                IF !THIS.ValidarDuplicatas()
                    loc_lResultado = .F.
                ELSE
                    *-- Atualiza Dopes e BlqCts em todo o cursor local
                    SELECT TmpGcOpe
                    REPLACE ALL Dopes WITH par_cDopes, BlqCts WITH par_nBlqCts

                    *-- Garante CidChaves em linhas novas
                    GO TOP
                    DO WHILE !EOF()
                        IF EMPTY(ALLTRIM(CidChaves))
                            REPLACE CidChaves WITH THIS.GerarCidChaves()
                        ENDIF
                        SKIP
                    ENDDO

                    *-- Persiste no SQL Server em transacao atomica
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trn")
                    IF USED("cursor_4c_Trn")
                        USE IN cursor_4c_Trn
                    ENDIF

                    *-- Deleta registros antigos da operacao
                    loc_cSQL = "DELETE FROM SigCdGcp WHERE Dopes = " + ;
                               EscaparSQL(par_cDopes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                    IF USED("cursor_4c_Del")
                        USE IN cursor_4c_Del
                    ENDIF

                    IF loc_nResultado < 0
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                        IF USED("cursor_4c_Rb")
                            USE IN cursor_4c_Rb
                        ENDIF
                        MostrarErro("Erro ao limpar registros antigos:" + CHR(13) + ;
                                    CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ELSE
                        *-- Insere linhas do TmpGcOpe
                        SELECT TmpGcOpe
                        GO TOP
                        loc_lResultado = .T.

                        DO WHILE !EOF() AND loc_lResultado
                            loc_cChave  = ALLTRIM(CidChaves)
                            loc_cGrupos = ALLTRIM(Grupos)
                            loc_cContas = ALLTRIM(Contas)
                            loc_cOriDes = ALLTRIM(OriDes)
                            loc_nBlqCts = BlqCts

                            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                                       " (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave)  + ", " + ;
                                       EscaparSQL(par_cDopes)  + ", " + ;
                                       EscaparSQL(loc_cGrupos) + ", " + ;
                                       EscaparSQL(loc_cContas) + ", " + ;
                                       EscaparSQL(loc_cOriDes) + ", " + ;
                                       FormatarNumeroSQL(loc_nBlqCts) + ;
                                       ")"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                            IF USED("cursor_4c_Ins")
                                USE IN cursor_4c_Ins
                            ENDIF

                            IF loc_nResultado < 0
                                MostrarErro("Erro ao inserir linha:" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF

                            SKIP
                        ENDDO

                        IF loc_lResultado
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
                            IF USED("cursor_4c_Cmt")
                                USE IN cursor_4c_Cmt
                            ENDIF
                            THIS.RegistrarAuditoria("INSERT")
                        ELSE
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                            IF USED("cursor_4c_Rb")
                                USE IN cursor_4c_Rb
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
            IF USED("cursor_4c_Rb")
                USE IN cursor_4c_Rb
            ENDIF
            MostrarErro(loException, "GcpBO.SalvarTmpGcOpe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida Grupo em SigCdGcr e retorna descricao
    * par_cGrupo : codigo a validar
    * par_cDescrs: (BYREF OUTPUT) descricao encontrada
    * Retorna .T. se grupo existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupo, par_cDescrs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cDescrs    = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupo))
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF

                loc_cSQL = "SELECT Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Gcr") > 0
                    SELECT cursor_4c_Gcr
                    par_cDescrs = ALLTRIM(Descrs)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarGrupo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida Conta em SigCdCli e retorna Rclis
    * par_cConta : codigo da conta (SigCdCli.Iclis) a validar
    * par_cRclis : (BYREF OUTPUT) nome/razao social do cliente
    * Retorna .T. se conta existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta(par_cConta, par_cRclis)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cRclis     = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cli") > 0
                    SELECT cursor_4c_Cli
                    par_cRclis = ALLTRIM(Rclis)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarConta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("TmpGcOpe")
            USE IN TmpGcOpe
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


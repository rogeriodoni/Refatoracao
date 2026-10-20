# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 8/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: [19/10/2026 13:48:45] Erro: A member object with this name already exists. LN=360 PROC=aplicarcontratogradeitens


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[19/10/2026 13:48:45] Erro: A member object with this name already exists. LN=360 PROC=aplicarcontratogradeitens


### LOG DA ETAPA (06_testForm):
[2026-10-19 13:45:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-19 13:45:03] [INFO] Config FPW: (nao fornecido)
[2026-10-19 13:45:04] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 13:45:05] [INFO] Timeout: 300 segundos
[2026-10-19 13:45:05] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zob0tp0k.prg
[2026-10-19 13:45:06] [INFO] Conteudo do wrapper:
[2026-10-19 13:45:06] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrSlp', 'C:\4c\tasks\task677\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSlp', 'C:\4c\tasks\task677\logs\06_testForm.log'
QUIT

[2026-10-19 13:45:08] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zob0tp0k.prg
[2026-10-19 13:45:08] [INFO] VFP output esperado em: C:\4c\tasks\task677\vfp_output.txt
[2026-10-19 13:45:09] [INFO] Executando Visual FoxPro 9...
[2026-10-19 13:45:09] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zob0tp0k.prg
[2026-10-19 13:45:09] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zob0tp0k.prg
[2026-10-19 13:45:10] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrSlp
Inicio: 19/10/2026 13:45:10

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 19/10/2026 13:48:45
Duracao: 215 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-19 13:48:45] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-19 13:48:46] [INFO] VFP9 finalizado em 217.3409736 segundos
[2026-10-19 13:48:46] [INFO] Exit Code: 
[2026-10-19 13:48:46] [INFO] 
[2026-10-19 13:48:47] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-19 13:48:47] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zob0tp0k.prg
[2026-10-19 13:48:48] [INFO] 
[2026-10-19 13:48:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-19 13:48:48] [INFO] * Auto-generated wrapper for parameters
[2026-10-19 13:48:48] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 13:48:49] [INFO] * Parameters: 'FormSigPrSlp', 'C:\4c\tasks\task677\logs\06_testForm.log'
[2026-10-19 13:48:49] [INFO] 
[2026-10-19 13:48:50] [INFO] * Anti-dialog protections for unattended execution
[2026-10-19 13:48:50] [INFO] SET SAFETY OFF
[2026-10-19 13:48:50] [INFO] SET RESOURCE OFF
[2026-10-19 13:48:51] [INFO] SET TALK OFF
[2026-10-19 13:48:51] [INFO] SET NOTIFY OFF
[2026-10-19 13:48:51] [INFO] SYS(2335, 0)
[2026-10-19 13:48:52] [INFO] 
[2026-10-19 13:48:52] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSlp', 'C:\4c\tasks\task677\logs\06_testForm.log'
[2026-10-19 13:48:52] [INFO] QUIT
[2026-10-19 13:48:53] [INFO] 
[2026-10-19 13:48:54] [INFO] === Fim do Wrapper.prg ===
[2026-10-19 13:48:54] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSlp.prg):
*==============================================================================
* FormSigPrSlp.prg - Selecao Lista de Preco (Form Operacional)
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo filho do form de pedido/venda
* Chamado via: CREATEOBJECT("FormSigPrSlp", oParentForm, cLPrecoAtual [, cCursorDestino])
*   Legado (SIGCDLPR.PAGINA.Dados.COPIA.Click):
*       Do Form SigPrSlp With ThisForm, CrSigCdLpc.lprecos
*   O 2o argumento eh a lista CORRENTE do pai, que serve a DOIS propositos no
*   legado: filtrar grd_4c_Listas (Init: "Where lprecos <> ?") e ser gravado
*   em m.lprecos no Command1.Click - por isso this_cLPrecoAtual eh usado nos
*   dois lugares. O 3o eh opcional (ver ResolverCursorDestino).
* Tabelas: SigCdLpc (cabecalho lista), SigCdLpi (itens lista)
* Legado: SIGPRSLP.SCX (form, Width=800, Height=600)
*
* METODOS DO LEGADO E ONDE FORAM PARAR
*   Init              -> Init + InicializarForm
*   montagrade2       -> MontaGrade2
*   Release           -> Destroy + DevolverFocoAoPai
*   Command1.Click    -> CmdAdicionarClick + SigPrSlpBO.AdicionarItensMarcados
*   GradeLista.AfterRowColChange -> GradeListasAfterRowColChange
*   Check1.When       -> gate replicado em TgItens1KeyPress (ver la o porque)
*   Sair.Click        -> CmdEncerrarClick
*   cmdSelTudo.Click  -> CmdSelTudoClick  / CmdApgTudo.Click -> CmdApgaTudoClick
*   Load (=fConfigGeral())  NAO PORTADO - deliberado, ver (a)
*
* PONTES PARA O PAI MIGRADO (nomes que o PILAR 3 trocou) - ver (c)
*   "CrSigCdLpi" (destino do Insert)  -> ResolverCursorDestino
*   ParentForm.CompVenda              -> ObterCompVendaDoPai
*   ParentForm.Pagina.Dados.Grade     -> DevolverFocoAoPai + FocarPrimeiraGrade
*
* (c) O PILAR 3 RENOMEIA objetos e cursores, e este dialogo eh o unico do
*     projeto que escreve DENTRO de estrutura do form PAI. Os tres nomes que
*     o legado cita literalmente nao existem no pai migrado (FormLpr,
*     task461): o cursor de itens dele eh "cursor_4c_Itens" ("CrSigCdLpi" tem
*     ZERO ocorrencias no arquivo), a property eh "this_cCompVenda" e a
*     pagina de dados eh "pgf_4c_Paginas.Page2" com "grd_4c_Grade"/
*     "grd_4c_GradeC". Com os literais do legado fixos no codigo, o
*     AdicionarItensMarcados nao achava o destino e devolvia -1: o usuario
*     marcava os itens, clicava em "Adiciona os itens marcados" e so recebia
*     "Erro ao adicionar itens" - a UNICA funcao da tela falhava. Cada ponte
*     tenta PRIMEIRO o nome do legado (pai wrapper) e so depois o do migrado,
*     entao nenhum dos dois pais fica de fora.
*
* (a) fConfigGeral era funcao GLOBAL da aplicacao legado (sig.prg/SIGFUNCS.PRG)
*     que nao veio no acervo. O wrapper app/utils/fconfiggeral.prg existe
*     APENAS para o p-code dos VCX legado que a chamam no proprio Load, e o
*     cabecalho dele diz textualmente: "em codigo NOSSO nunca se chama
*     fConfigGeral". Na arquitetura nova a inicializacao global esta
*     distribuida e ja ocorreu antes deste dialogo abrir (config.prg, main.prg
*     e o proprio BO, que cria os cursores de que precisa). Mesmo tratamento e
*     mesma justificativa de FormSigMvExp.prg.
*
* (b) fArredondamento (Command1.Click do legado) tambem NAO veio no acervo e
*     devolve VALOR DE CALCULO - fica AUSENTE em vez de receber stub, para nao
*     gravar preco errado em silencio. Ver SigPrSlpBO.AdicionarItensMarcados.
*==============================================================================

DEFINE CLASS FormSigPrSlp AS FormBase

    *-- Dimensoes (dialogo - manter 800x600 do legado)
    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    FontName     = "Arial"
    FontSize     = 9
    ShowTips     = .T.

    *-- BO e estado
    this_oBusinessObject  = .NULL.
    this_cModoAtual       = ""
    this_cMensagemErro    = ""

    *-- Parametros recebidos do form pai
    this_oParentForm   = .NULL.   && Referencia ao form pai (pedido/venda)
    this_cLPrecoAtual  = ""       && Codigo da lista corrente (excluida de grd_4c_Listas)

    *-- Cursor de itens DO FORM PAI onde os itens marcados sao inseridos.
    *-- Default = nome do legado; o valor efetivo eh resolvido em runtime por
    *-- ResolverCursorDestino() (ver o cabecalho daquele metodo).
    this_cCursorDestino = "CrSigCdLpi"

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form pai, configura Caption e propriedades
    *
    * par_cCursorDestino eh OPCIONAL: permite ao pai dizer explicitamente em
    * qual cursor os itens marcados devem ser inseridos. Omitido, o nome eh
    * descoberto em runtime (ResolverCursorDestino) - necessario porque o
    * PILAR 3 renomeia os cursores e o nome do legado ("CrSigCdLpi") nao
    * existe no form pai migrado.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cLPreco, par_cCursorDestino)
        THIS.Caption          = "Sele" + CHR(231) + CHR(227) + "o Lista de Pre" + CHR(231) + "o"
        THIS.this_oParentForm = par_oParentForm
        THIS.this_cLPrecoAtual = IIF(VARTYPE(par_cLPreco) = "C", ALLTRIM(par_cLPreco), "")

        IF VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino)
            THIS.this_cCursorDestino = ALLTRIM(par_cCursorDestino)
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura, carrega dados e vincula eventos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lCarregou

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrSlpBO")

            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Area de dados (grade de itens marcaveis): garante os objetos e
            *-- aplica o contrato visual das colunas das duas grades
            THIS.ConfigurarPaginaDados()

            THIS.TornarControlesVisiveis(THIS)

            *-- Carrega listas disponiveis e vincula evento de selecao.
            *-- O BINDEVENT vem DEPOIS da carga de proposito: ligado antes, a
            *-- troca de RecordSource dispara AfterRowColChange e MontaGrade2
            *-- roda duas vezes na abertura.
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                loc_lCarregou = THIS.CarregarGradeLista()
            ELSE
                loc_lCarregou = .T.
            ENDIF
            BINDEVENT(THIS.grd_4c_Listas, "AfterRowColChange", THIS, "GradeListasAfterRowColChange")

            *-- Legado: falhando a consulta de SigCdLpc ou o MontaGrade2, o Init
            *-- exibe "Favor reinicializar o processo." e chama ThisForm.Release.
            *-- Aqui o equivalente eh devolver .F.: o CREATEOBJECT do chamador
            *-- recebe .F. e o dialogo nao abre (Release dentro do Init nao eh
            *-- seguro - o objeto ainda esta sendo construido).
            IF loc_lCarregou
                loc_lSucesso = .T.
            ELSE
                THIS.ReportarFalhaProcesso()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria cabecalho + grids + botoes (flat, sem PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Fundo do dialogo (original: Picture = new_background.jpg)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        *-- Layout flat (dialogo sem PageFrame): grids + botoes de acao
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta a area de selecao (grid de listas + grid de
    * itens marcaveis + botoes de acao). Neste dialogo OPERACIONAL nao existe
    * PageFrame; o nome eh mantido para paridade com a API dos forms CRUD e
    * agrega toda a configuracao visual da "lista" de itens selecionaveis.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGradeLista()
        THIS.ConfigurarGradeItens()
        THIS.ConfigurarBotoesForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Monta/reaplica a area de DADOS do dialogo.
    *
    * O SCX legado SIGPRSLP nao declara nenhum TextBox nem Label de dados: a
    * arvore de objetos tem apenas cntSombra (+ lblSombra/lblTitulo), as duas
    * grades (GradeLista e GradeItens) e os quatro botoes. A area de dados
    * deste dialogo EH a grade de itens marcaveis (CheckBox + Codigo Produto +
    * Descricao do Produto + Preco de Venda + Moeda + Comissao), por isso nao
    * ha campos individuais a criar - nao se inventam campos que o legado nao
    * tem (PILAR 1).
    *
    * O metodo garante que as duas grades existam e REAPLICA o contrato visual
    * das colunas. Idempotente: seguro para ser chamado novamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.ConfigurarGradeLista()
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.ConfigurarGradeItens()
        ENDIF

        THIS.AplicarContratoGradeListas()
        THIS.AplicarContratoGradeItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCheckBoxItens - Cria (ou RECRIA) o CheckBox de marcacao da
    * Column1 de grd_4c_Itens e religa os handlers dele.
    *
    * A Column nasce apenas com Header1/Text1, entao o CheckBox tem de ser
    * adicionado (regra #18). E, MEDIDO no VFP9 em 2026-10-19: quando o BO
    * derruba e recria o alias (USE IN + SQLEXEC) com a grade ainda vinculada,
    * o VFP RECONSTROI os objetos Column e o Check1 DEIXA DE EXISTIR
    * (PEMSTATUS passa de .T. para .F.) - reatribuir propriedades nao traz o
    * controle de volta, so recria-lo. Sem isso, da segunda lista selecionada
    * em diante a coluna desenha o Text1 com o 0/1 cru e nao ha como marcar.
    *
    * Geometria: o SCX declara Width=60 para o Check1, mas a coluna tem 22px e
    * recorta o excedente; usar 22 evita o clipping sem alterar o que o usuario
    * ve (a caixa de marcacao fica identica).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCheckBoxItens()
        LOCAL loc_oColuna

        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            RETURN
        ENDIF

        loc_oColuna = THIS.grd_4c_Itens.Column1

        *-- So cria quando ausente: assim os BINDEVENT abaixo acontecem uma
        *-- unica vez por instancia de Check1 (sem binding duplicado)
        IF PEMSTATUS(loc_oColuna, "Check1", 5)
            RETURN
        ENDIF

        loc_oColuna.AddObject("Check1", "CheckBox")
        WITH loc_oColuna.Check1
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
            .FontName  = "Courier New"
            .Alignment = 0
            .Caption   = ""
            .ReadOnly  = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- When original: Return(CsSigCdLpi.lMarcas = 0)
        BINDEVENT(loc_oColuna.Check1, "When", THIS, "GradeItensCheck1When")

        *-- Pattern #185 / Erro146: CheckBox de grid nao alterna pelo binding
        *-- nativo - os 4 handlers abaixo fazem o toggle por codigo
        THIS.BindToggleItens1(loc_oColuna.Check1)
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarContratoGradeItens - (Re)aplica o contrato visual de grd_4c_Itens
    *
    * OBRIGATORIO em TODO caminho que (re)vincula o RecordSource. O BO RECRIA o
    * cursor de itens a cada troca de lista (USE IN + SQLEXEC dentro de
    * BuscarItensDaLista) e, com o cursor recriado, o VFP9 reseta Column.Width
    * para o default, perde Column.Sparse e devolve CurrentControl para "Text1".
    * Sem esta reaplicacao, da SEGUNDA lista selecionada em diante o CheckBox de
    * marcacao DESAPARECE (a coluna volta a desenhar o Text1 com o 0/1 cru) e o
    * usuario nao consegue marcar item nenhum - sem erro e sem log.
    * Referencia: CLAUDE.md regras #18 e #41 + Problema 48 (FormCor).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarContratoGradeItens()
        LOCAL loc_oGrid

        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Itens

        *-- Grid.ReadOnly ANTES das colunas: ele propaga e sobrescreve o delas
        loc_oGrid.ReadOnly = .F.

        *-- Column1 - CheckBox de marcacao (Original: Width=22 ReadOnly=.F. Sparse=.F.)
        WITH loc_oGrid.Column1
            .Width            = 22
            .FontName         = "Courier New"
            .FontSize         = 9
            .Sparse           = .F.
            .ReadOnly         = .F.
            .Header1.Caption  = ""
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
        ENDWITH

        *-- O Check1 eh DESTRUIDO quando o alias eh recriado sob a grade:
        *-- recria-lo antes de apontar o CurrentControl para ele
        THIS.GarantirCheckBoxItens()

        *-- CurrentControl por ULTIMO e so com o Check1 existente: sem ele a
        *-- coluna segue desenhando o Text1 e o CheckBox nunca aparece (#18)
        *-- Check1 JA foi criado (ou ja existia) por GarantirCheckBoxItens()
        *-- acima - NUNCA chamar AddObject de novo aqui: um segundo AddObject
        *-- sobre objeto que acabou de ser criado estoura "A member object
        *-- with this name already exists" (e quebrava ja na 1a montagem da
        *-- grade, dentro do InicializarForm).
        IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
            loc_oGrid.Column1.AddObject("Check1", "CheckBox")
            loc_oGrid.Column1.Check1.Caption = ""
            loc_oGrid.Column1.CurrentControl = "Check1"
        ENDIF

        *-- Colunas 2..6 - somente leitura (Original: ReadOnly=.T. em todas)
        THIS.AplicarContratoColunaItens(loc_oGrid.Column2, 108, ;
            "C" + CHR(243) + "digo Produto", "")
        THIS.AplicarContratoColunaItens(loc_oGrid.Column3, 290, ;
            "Descri" + CHR(231) + CHR(227) + "o do Produto", "")
        THIS.AplicarContratoColunaItens(loc_oGrid.Column4, 108, ;
            "Pre" + CHR(231) + "o de Venda", "999,999,999.99")
        THIS.AplicarContratoColunaItens(loc_oGrid.Column5, 40, ;
            "Moeda", "")
        THIS.AplicarContratoColunaItens(loc_oGrid.Column6, 60, ;
            "Comiss" + CHR(227) + "o", "999.99")
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarContratoColunaItens - Contrato de UMA coluna somente-leitura de
    * grd_4c_Itens. Larguras, captions e mascaras transcritos do SCX legado.
    * par_cInputMask vazio = o legado NAO declara mascara naquela coluna; nesse
    * caso nada eh atribuido (override vazio do Form Designer nao se transcreve
    * - CLAUDE.md regra #49).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarContratoColunaItens(par_oColuna, par_nWidth, par_cCaption, par_cInputMask)
        WITH par_oColuna
            .Width             = par_nWidth
            .FontName          = "Courier New"
            .FontSize          = 9
            .ReadOnly          = .T.
            .Header1.Caption   = par_cCaption
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH

        IF !EMPTY(par_cInputMask)
            par_oColuna.InputMask = par_cInputMask
        ENDIF

        *-- Estilo do TextBox da coluna (Original: BorderStyle=0 Margin=0 ReadOnly=.T.)
        IF PEMSTATUS(par_oColuna, "Text1", 5)
            WITH par_oColuna.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarContratoGradeListas - (Re)aplica o contrato visual de grd_4c_Listas
    * Mesmo motivo de AplicarContratoGradeItens: BuscarListasDisponiveis recria
    * o cursor (USE IN + SQLEXEC), o que zera Column1.Width (220 -> default) e
    * o Header1. Chamar depois de cada rebind do RecordSource.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarContratoGradeListas()
        LOCAL loc_oGrid

        IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Listas

        *-- Grid.ReadOnly ANTES da coluna: ele propaga e sobrescreve (regra #18)
        loc_oGrid.ReadOnly = .T.

        WITH loc_oGrid.Column1
            .Width             = 220
            .FontName          = "Courier New"
            .FontSize          = 9
            .ReadOnly          = .T.
            .Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- Estilo do TextBox da coluna (Original: BorderStyle=0 Margin=0 ReadOnly=.T.)
        IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
            WITH loc_oGrid.Column1.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Move o foco entre os dois grids do dialogo.
    * par_nPagina = 1  -> grd_4c_Listas (cabecalho: escolha da lista de preco)
    * par_nPagina = 2  -> grd_4c_Itens  (detalhe: marcacao dos itens)
    * Neste dialogo nao ha PageFrame real; o metodo existe para compatibilidade
    * de API com forms CRUD e para permitir navegacao programatica entre grids.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina

        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
            CASE loc_nPagina = 1
                IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
                    THIS.grd_4c_Listas.SetFocus()
                ENDIF
            CASE loc_nPagina = 2
                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.SetFocus()
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeLista - Cria grd_4c_Listas para selecao de lista de preco
    * Original: GradeLista Top=96 Left=263 Width=258 Height=112 ColumnCount=1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeLista()
        THIS.AddObject("grd_4c_Listas", "Grid")
        WITH THIS.grd_4c_Listas
            .Top         = 96
            .Left        = 263
            .Width       = 258
            .Height      = 112
            .ColumnCount = 1
            .TabIndex    = 1       && SCX: GradeLista.TabIndex = 1
            .FontName    = "Courier New"
            .FontSize    = 9
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .ScrollBars  = 2
            .RowHeight   = 16
            .Visible     = .T.
        ENDWITH

        *-- Larguras, header e estilo da coluna ficam no contrato reaplicavel
        *-- (ReadOnly do grid eh aplicado la, ANTES do da coluna - regra #18)
        THIS.AplicarContratoGradeListas()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeItens - Cria grd_4c_Itens com checkbox na Column1 (6 cols)
    * Original: GradeItens Top=215 Left=72 Width=663 Height=184 ColumnCount=6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeItens()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Itens", "Grid")
        loc_oGrid = THIS.grd_4c_Itens

        WITH loc_oGrid
            .Top         = 215
            .Left        = 72
            .Width       = 663
            .Height      = 184
            .ColumnCount = 6
            .TabIndex    = 2       && SCX: GradeItens.TabIndex = 2
            .FontName    = "Courier New"
            .FontSize    = 9
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .ScrollBars  = 2
            .RowHeight   = 16
        ENDWITH

        *-- Column1 (CheckBox de marcacao), larguras, headers, mascaras,
        *-- Sparse e CurrentControl ficam no contrato reaplicavel, que eh
        *-- chamado tambem apos cada rebind do cursor
        THIS.AplicarContratoGradeItens()

        loc_oGrid.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesForm - Cria botoes de acao do dialogo
    * Original: Command1 Top=413 Left=80 W=288 H=27
    *           cmdSelTudo Top=407 Left=632 / CmdApgTudo Top=407 Left=672
    *           Sair Top=3 Left=725 (Encerrar, Cancel=.T.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesForm()
        *-- Botao principal: adiciona itens marcados a lista atual
        THIS.AddObject("cmd_4c_Adicionar", "CommandButton")
        WITH THIS.cmd_4c_Adicionar
            .Top       = 413
            .Left      = 80
            .Width     = 288
            .Height    = 27
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 3         && SCX: Command1.TabIndex = 3
            .Caption   = "Adiciona os itens marcados " + CHR(224) + " Lista atual"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Adicionar, "Click", THIS, "CmdAdicionarClick")

        *-- Botao Selecionar Tudo (icone pequeno ao lado do grid)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top             = 407
            .Left            = 632
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .Themes          = .T.
            .SpecialEffect   = 0
            .TabStop         = .F.
            .ToolTipText     = "Selec.Tudo"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        *-- Botao Desmarcar Tudo
        THIS.AddObject("cmd_4c_ApgaTudo", "CommandButton")
        WITH THIS.cmd_4c_ApgaTudo
            .Top             = 407
            .Left            = 672
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
            .Themes          = .T.
            .SpecialEffect   = 0
            .TabStop         = .F.
            .ToolTipText     = "Apaga Tudo"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_ApgaTudo, "Click", THIS, "CmdApgaTudoClick")

        *-- Botao Encerrar (canto superior direito, sobre o cabecalho)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725   && SCX: Sair.Left=725 (725+75=800 = Form.Width)
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeLista - Chama BO.BuscarListasDisponiveis e popula grd_4c_Listas
    * Apos carregar, chama MontaGrade2 com a primeira lista disponivel
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeLista()
        LOCAL loc_lSucesso, loc_cCursorListas

        loc_lSucesso = THIS.this_oBusinessObject.BuscarListasDisponiveis(THIS.this_cLPrecoAtual)

        IF loc_lSucesso
            loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas

            *-- Ordem canonica (regra #41): RecordSource ANTES do ControlSource
            THIS.grd_4c_Listas.RecordSource = ""
            THIS.grd_4c_Listas.RecordSource = loc_cCursorListas
            THIS.grd_4c_Listas.Column1.ControlSource = loc_cCursorListas + ".lprecos"
            *-- Cursor RECRIADO pelo BO: reaplicar largura/header da coluna
            THIS.AplicarContratoGradeListas()

            *-- Carregar itens da primeira lista disponivel. O legado testa o
            *-- retorno do MontaGrade2 no Init (If !(ThisForm.MontaGrade2(...)))
            *-- - descartar o retorno aqui esconde a falha e o dialogo abre com
            *-- a grade de itens vazia.
            SELECT (loc_cCursorListas)
            GO TOP
            IF !EOF()
                loc_lSucesso = THIS.MontaGrade2(ALLTRIM(lprecos))
            ENDIF
        ENDIF

        *-- FUNIL (regra #40): repor o estado dos controles em TODO caminho que
        *-- recarrega os cursores - inclusive no caminho de falha, senao uma
        *-- grade fica habilitada apontando para cursor que nao existe mais.
        THIS.AjustarBotoesPorModo()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaGrade2 - Carrega itens de SigCdLpi para grd_4c_Itens
    * par_cLPrecos: codigo da lista selecionada em grd_4c_Listas
    *--------------------------------------------------------------------------
    PROCEDURE MontaGrade2(par_cLPrecos)
        LOCAL loc_lSucesso, loc_cCursorItens

        loc_lSucesso = THIS.this_oBusinessObject.BuscarItensDaLista(par_cLPrecos)

        IF loc_lSucesso
            loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens

            *-- Ordem canonica (regra #41): RecordSource ANTES dos
            *-- ControlSource - atribuir RecordSource depois RESETA os
            *-- ControlSource ja definidos e a grade exibe colunas erradas
            THIS.grd_4c_Itens.RecordSource = ""
            THIS.grd_4c_Itens.RecordSource = loc_cCursorItens
            THIS.grd_4c_Itens.Column1.ControlSource = loc_cCursorItens + ".lMarcas"
            THIS.grd_4c_Itens.Column2.ControlSource = loc_cCursorItens + ".cpros"
            THIS.grd_4c_Itens.Column3.ControlSource = loc_cCursorItens + ".dpros"
            THIS.grd_4c_Itens.Column4.ControlSource = loc_cCursorItens + ".pvens"
            THIS.grd_4c_Itens.Column5.ControlSource = loc_cCursorItens + ".moevs"
            THIS.grd_4c_Itens.Column6.ControlSource = loc_cCursorItens + ".comiss"
            *-- O cursor foi RECRIADO (USE IN + SQLEXEC no BO): o rebind zera
            *-- Column.Width, perde Sparse e devolve CurrentControl para "Text1".
            *-- Sem reaplicar o contrato, o CheckBox de marcacao desaparece.
            THIS.AplicarContratoGradeItens()
            THIS.grd_4c_Itens.Refresh()
        ENDIF

        *-- FUNIL (regra #40): o cursor de itens foi recriado, repor o estado
        THIS.AjustarBotoesPorModo()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeListasAfterRowColChange - Atualiza grd_4c_Itens ao trocar linha em grd_4c_Listas
    *--------------------------------------------------------------------------
    PROCEDURE GradeListasAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursorListas, loc_cLPrecos

        loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursorListas)
            SELECT (loc_cCursorListas)
            IF !EOF()
                loc_cLPrecos = ALLTRIM(lprecos)
                IF !EMPTY(loc_cLPrecos)
                    *-- Legado: If !(ThisForm.MontaGrade2(lcLPrec)) -> MessageBox
                    *-- "Favor reinicializar o processo." + ThisForm.Release()
                    IF !THIS.MontaGrade2(loc_cLPrecos)
                        THIS.ReportarFalhaProcesso()
                        THIS.Release()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ReportarFalhaProcesso - Exibe a mensagem UNICA que o legado usa quando a
    * consulta das listas (SigCdLpc) ou dos itens (SigCdLpi) falha.
    *
    * Legado (Init e GradeLista.AfterRowColChange):
    *     MessageBox("Favor reinicializar o processo.", 16, "Falha na Conexao")
    *
    * Os metodos de busca do BO guardam a causa real em this_cMensagemErro sem
    * abrir dialogo, para que apenas ESTA mensagem apareca (o legado mostra uma
    * so). Quando a falha veio de excecao, o BO ja exibiu e marcou
    * this_lErroExibido - nesse caso nao se repete o dialogo (regra #20).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ReportarFalhaProcesso()
        LOCAL loc_cDetalhe, loc_lJaExibido

        loc_cDetalhe  = ""
        loc_lJaExibido = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            loc_lJaExibido = THIS.this_oBusinessObject.this_lErroExibido
            loc_cDetalhe   = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
        ENDIF

        IF loc_lJaExibido
            RETURN
        ENDIF

        MsgErro("Favor reinicializar o processo." + ;
                IIF(EMPTY(loc_cDetalhe), "", CHR(13) + CHR(13) + loc_cDetalhe), ;
                "Falha na Conex" + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAdicionarClick - Copia itens marcados para o cursor CrSigCdLpi do form pai
    *--------------------------------------------------------------------------
    PROCEDURE CmdAdicionarClick()
        LOCAL loc_lAplicarArredond, loc_cCursorDestino, loc_nAdicionados, loc_oErro

        IF VARTYPE(THIS.this_oParentForm) != "O" OR ISNULL(THIS.this_oParentForm)
            MsgAviso("Form pai n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN
        ENDIF

        loc_lAplicarArredond = THIS.ObterCompVendaDoPai()

        *-- Resolver AQUI, nao no Init: o form pai cria o cursor de itens de
        *-- forma preguicosa (FormLpr so o cria em CarregarItens/BtnINSERE),
        *-- entao no Init ele pode ainda nao existir
        loc_cCursorDestino = THIS.ResolverCursorDestino()

        IF !USED(loc_cCursorDestino)
            MsgAviso("A lista de pre" + CHR(231) + "o de destino n" + CHR(227) + ;
                     "o est" + CHR(225) + " aberta para edi" + CHR(231) + CHR(227) + "o.", ;
                     "Aviso")
            RETURN
        ENDIF

        TRY
            loc_nAdicionados = THIS.this_oBusinessObject.AdicionarItensMarcados(;
                THIS.this_cLPrecoAtual, ;
                loc_cCursorDestino, ;
                loc_lAplicarArredond)

            IF loc_nAdicionados >= 0
                THIS.Release()
            ELSE
                MsgErro("Erro ao adicionar itens da lista de pre" + CHR(231) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao adicionar itens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverCursorDestino - Descobre o cursor de itens DO FORM PAI onde os
    * itens marcados serao inseridos.
    *
    * O legado insere no literal "CrSigCdLpi" (Command1.Click:
    * "Insert Into CrSigCdLpi From MemVar"), que eh o cursor que o
    * frmcadastro Fortyus do SIGCDLPR cria via AddCursor. O PILAR 3 RENOMEIA
    * os cursores: no pai migrado (FormLpr, task461) o cursor de itens chama
    * "cursor_4c_Itens" e "CrSigCdLpi" NAO EXISTE em lugar nenhum do arquivo
    * (medido: zero ocorrencias). Com o nome do legado fixo no codigo, o
    * AdicionarItensMarcados do BO nao achava o destino, devolvia -1 e o
    * dialogo exibia "Erro ao adicionar itens" - ou seja, a UNICA funcao desta
    * tela falhava contra o unico pai que a chama.
    *
    * Ordem de resolucao (a 1a que estiver ABERTA ganha):
    *   1. this_cCursorDestino, quando o pai informou no Init (explicito)
    *   2. property this_cCursorItens do pai, se ele publicar o nome
    *   3. "CrSigCdLpi" - nome do legado (pai wrapper que ainda carrega o
    *      cursor Fortyus)
    *   4. "cursor_4c_Itens" - nome que o pai migrado realmente usa
    *
    * Nao havendo nenhum aberto, devolve o valor corrente de
    * this_cCursorDestino para que o chamador reporte com USED() (e nao
    * invente um alias).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverCursorDestino()
        LOCAL loc_cNome, loc_oPai

        *-- 1. Informado explicitamente no Init e aberto
        loc_cNome = ALLTRIM(NVL(THIS.this_cCursorDestino, ""))
        IF !EMPTY(loc_cNome) AND USED(loc_cNome)
            RETURN loc_cNome
        ENDIF

        *-- 2. O pai publica o nome do proprio cursor de itens
        loc_oPai = THIS.this_oParentForm
        IF VARTYPE(loc_oPai) = "O" AND !ISNULL(loc_oPai)
            IF PEMSTATUS(loc_oPai, "this_cCursorItens", 5)
                IF VARTYPE(loc_oPai.this_cCursorItens) = "C"
                    loc_cNome = ALLTRIM(loc_oPai.this_cCursorItens)
                    IF !EMPTY(loc_cNome) AND USED(loc_cNome)
                        THIS.this_cCursorDestino = loc_cNome
                        RETURN loc_cNome
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        *-- 3. Nome do legado
        IF USED("CrSigCdLpi")
            THIS.this_cCursorDestino = "CrSigCdLpi"
            RETURN "CrSigCdLpi"
        ENDIF

        *-- 4. Nome do pai migrado (FormLpr)
        IF USED("cursor_4c_Itens")
            THIS.this_cCursorDestino = "cursor_4c_Itens"
            RETURN "cursor_4c_Itens"
        ENDIF

        RETURN ALLTRIM(NVL(THIS.this_cCursorDestino, "CrSigCdLpi"))
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCompVendaDoPai - Reproduz o teste do Command1.Click legado
    *     If (ThisForm.ParentForm.CompVenda <> [C])
    * devolvendo .T. quando o arredondamento de pvens deve ser aplicado.
    *
    * O nome da property muda entre o pai LEGADO e o pai MIGRADO: o SIGCDLPR
    * tem "CompVenda", e o FormLpr migrado tem "this_cCompVenda" (PILAR 3).
    * Testar so o nome do legado faz este metodo devolver sempre .F. contra o
    * pai real - hoje inofensivo (fArredondamento nao veio no acervo, ver
    * nota (b) no cabecalho), mas no dia em que a funcao for portada o
    * arredondamento ficaria silenciosamente desligado.
    *
    * Pai sem nenhuma das duas properties: .F. (nao arredonda), que eh o
    * caminho conservador - o legado so arredonda quando sabe que NAO eh
    * compra.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterCompVendaDoPai()
        LOCAL loc_oPai

        loc_oPai = THIS.this_oParentForm

        IF VARTYPE(loc_oPai) != "O" OR ISNULL(loc_oPai)
            RETURN .F.
        ENDIF

        IF PEMSTATUS(loc_oPai, "CompVenda", 5)
            IF VARTYPE(loc_oPai.CompVenda) = "C"
                RETURN (ALLTRIM(UPPER(loc_oPai.CompVenda)) != "C")
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPai, "this_cCompVenda", 5)
            IF VARTYPE(loc_oPai.this_cCompVenda) = "C"
                RETURN (ALLTRIM(UPPER(loc_oPai.this_cCompVenda)) != "C")
            ENDIF
        ENDIF

        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Fecha o dialogo sem adicionar itens
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - Marca todos os itens de grd_4c_Itens
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        THIS.this_oBusinessObject.MarcarTodos()
        THIS.grd_4c_Itens.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApgaTudoClick - Desmarca todos os itens de grd_4c_Itens
    *--------------------------------------------------------------------------
    PROCEDURE CmdApgaTudoClick()
        THIS.this_oBusinessObject.DesmarcarTodos()
        THIS.grd_4c_Itens.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos e reativa o form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro, loc_cCursorDestino

        TRY
            *-- Resolver ANTES de soltar o BO: ResolverCursorDestino nao
            *-- depende dele, mas o alias corrente ainda esta nos cursores
            *-- deste dialogo e o LimparCursores abaixo vai fecha-los
            loc_cCursorDestino = THIS.ResolverCursorDestino()

            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject.LimparCursores()
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            *-- Legado (PROCEDURE Release): alem de reabilitar o pai, ele
            *-- reposiciona o alias corrente no cursor de itens do pai e
            *-- devolve o foco a grade da pagina de Dados dele -
            *--     Select CrSigCdLpi
            *--     With ThisForm.ParentForm.Pagina.Dados
            *--         .Refresh / .SetFocus / .Grade.Column1.SetFocus
            *-- Sem isso o usuario volta ao pedido com a grade de itens sem
            *-- foco e, por o alias corrente ter ficado nos cursores deste
            *-- dialogo (ja fechados), com a grade do pai sem reposicionar.
            *-- Nome do cursor RESOLVIDO (o literal do legado nao existe no
            *-- pai migrado - ver ResolverCursorDestino)
            IF !EMPTY(loc_cCursorDestino) AND USED(loc_cCursorDestino)
                SELECT (loc_cCursorDestino)
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
                *-- Enabled ANTES do foco: SetFocus em form desabilitado nao
                *-- pega (o legado faz na ordem inversa e perde o foco)
                THIS.this_oParentForm.Enabled = .T.

                IF PEMSTATUS(THIS.this_oParentForm, "Refresh", 5)
                    THIS.this_oParentForm.Refresh()
                ENDIF

                *-- Caminho do legado so existe quando o pai tem a pagina de
                *-- Dados: o PILAR 3 renomeia os objetos, entao cada nivel eh
                *-- testado por PEMSTATUS antes de ser alcancado
                THIS.DevolverFocoAoPai()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar di" + CHR(225) + "logo")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * DevolverFocoAoPai - Reproduz o bloco de foco do Release legado.
    *
    * Legado: With ThisForm.ParentForm.Pagina.Dados -> .Refresh / .SetFocus /
    *         .Grade.Column1.SetFocus
    *
    * Cada nivel eh alcancado so apos PEMSTATUS: o form pai no sistema novo
    * tem nomes diferentes (PILAR 3), e tocar "Pagina"/"Dados"/"Grade" as
    * cegas estouraria "Property PAGINA is not found" dentro do Destroy.
    *
    * Por isso DOIS caminhos: o do pai LEGADO (Pagina.Dados.Grade, nomes do
    * frmcadastro Fortyus) e o do pai MIGRADO (pgf_4c_Paginas.Page2 + a
    * primeira Grid da pagina). Sem o segundo, contra o pai real - o FormLpr,
    * que usa "pgf_4c_Paginas.Page2" e "grd_4c_Grade"/"grd_4c_GradeC" - todos
    * os PEMSTATUS falham e o foco NUNCA volta para a grade de itens: o
    * usuario fecha o dialogo e cai no pedido sem foco em campo nenhum.
    * Pai sem nenhuma das duas estruturas: nada a fazer, o Refresh ja ocorreu.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DevolverFocoAoPai()
        LOCAL loc_oPai, loc_oDados

        loc_oPai = THIS.this_oParentForm

        *-- PEMSTATUS sobre .NULL. estoura: guarda antes de tudo
        IF VARTYPE(loc_oPai) != "O" OR ISNULL(loc_oPai)
            RETURN
        ENDIF

        *-- Caminho 1: pai LEGADO (Pagina.Dados.Grade)
        loc_oDados = .NULL.
        IF PEMSTATUS(loc_oPai, "Pagina", 5)
            IF VARTYPE(loc_oPai.Pagina) = "O"
                IF PEMSTATUS(loc_oPai.Pagina, "Dados", 5)
                    IF VARTYPE(loc_oPai.Pagina.Dados) = "O"
                        loc_oDados = loc_oPai.Pagina.Dados
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        *-- Caminho 2: pai MIGRADO (pgf_4c_Paginas.Page2 = pagina de Dados)
        IF ISNULL(loc_oDados)
            IF PEMSTATUS(loc_oPai, "pgf_4c_Paginas", 5)
                IF VARTYPE(loc_oPai.pgf_4c_Paginas) = "O"
                    IF loc_oPai.pgf_4c_Paginas.PageCount >= 2
                        loc_oDados = loc_oPai.pgf_4c_Paginas.Page2
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF ISNULL(loc_oDados) OR VARTYPE(loc_oDados) != "O"
            RETURN
        ENDIF

        loc_oDados.Refresh()

        *-- Nome do legado primeiro; depois a primeira Grid VISIVEL da pagina
        IF PEMSTATUS(loc_oDados, "Grade", 5)
            IF VARTYPE(loc_oDados.Grade) = "O"
                loc_oDados.Grade.SetFocus()
                RETURN
            ENDIF
        ENDIF

        THIS.FocarPrimeiraGrade(loc_oDados)
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarPrimeiraGrade - Da foco a primeira Grid VISIVEL e habilitada do
    * container recebido. Equivale ao ".Grade.Column1.SetFocus" do Release
    * legado quando o pai eh migrado e a grade tem outro nome (PILAR 3).
    *
    * Varre por INDICE (Controls(N) eh array - regra #34, nunca por nome) e
    * filtra por BaseClass = "GRID": o pai migrado pode ter mais de uma grade
    * na pagina de Dados (FormLpr tem grd_4c_Grade para venda e
    * grd_4c_GradeC para compra, com a nao usada invisivel), entao o teste de
    * Visible eh o que escolhe a grade certa sem precisar saber o nome dela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarPrimeiraGrade(par_oContainer)
        LOCAL loc_nI, loc_oCtrl

        IF VARTYPE(par_oContainer) != "O" OR ISNULL(par_oContainer)
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN .F.
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oCtrl) = "O"
                IF UPPER(loc_oCtrl.BaseClass) == "GRID"
                    IF loc_oCtrl.Visible AND loc_oCtrl.Enabled
                        loc_oCtrl.SetFocus()
                        RETURN .T.
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR

        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Define foco inicial no grd_4c_Listas ao exibir o dialogo
    * Equivale ao ThisForm.GradeLista.Column1.SetFocus do Init legado
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.SetFocus()
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCheck1When - Replica o When original: Return(CsSigCdLpi.lMarcas = 0)
    * Itens ja marcados NAO podem ser desmarcados individualmente; para
    * desmarcar usar cmd_4c_ApgaTudo (Apaga Tudo).
    *
    * ATENCAO: este metodo NAO bloqueia nada por si - BINDEVENT descarta o
    * retorno do delegate. Ele fica aqui como a transcricao do When legado;
    * o gate que REALMENTE vale esta dentro de TgItens1KeyPress, que eh quem
    * altera lMarcas. Mexer na regra exige mexer NOS DOIS.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCheck1When()
        LOCAL loc_cCursor, loc_lPermitir

        loc_lPermitir = .T.
        loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            IF !EOF()
                loc_lPermitir = (lMarcas = 0)
            ENDIF
        ENDIF

        RETURN loc_lPermitir
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Adiciona os itens marcados a lista de preco atual do
    * form pai. Neste dialogo OPERACIONAL "incluir" significa incluir itens
    * marcados no cursor CrSigCdLpi do form pai (mesma acao do Command1 do SCX
    * original "Adiciona os itens marcados a Lista atual").
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdAdicionarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Move o foco para grd_4c_Itens permitindo ao usuario
    * alterar (marcar/desmarcar) os itens da lista de preco selecionada. Como
    * este eh um dialogo de selecao, "alterar" corresponde a editar quais
    * itens estao marcados para inclusao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Itens.Refresh()
            THIS.grd_4c_Itens.SetFocus()
        ELSE
            MsgAviso("Nenhuma lista de pre" + CHR(231) + "o selecionada.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Move o foco para grd_4c_Listas permitindo ao
    * usuario visualizar as listas de preco disponiveis para importacao.
    * Neste dialogo de selecao, "visualizar" corresponde a navegar entre as
    * listas de preco de origem (o SCX original faz isso via GradeLista).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Listas.Refresh()
            THIS.grd_4c_Listas.SetFocus()
        ELSE
            MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Desmarca todos os itens marcados de grd_4c_Itens.
    * Neste dialogo de selecao, "excluir" corresponde a remover as marcacoes
    * feitas pelo usuario (mesma acao do CmdApgTudo do SCX original), com
    * confirmacao previa se houver itens marcados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCursor, loc_nMarcados

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        COUNT FOR lMarcas = 1 TO loc_nMarcados

        IF loc_nMarcados = 0
            MsgAviso("Nenhum item marcado para remover.", "Aviso")
            RETURN
        ENDIF

        IF MsgConfirma("Desmarcar todos os " + TRANSFORM(loc_nMarcados) + ;
                       " itens marcados?", "Confirma" + CHR(231) + CHR(227) + "o")
            THIS.CmdApgaTudoClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega o grid de listas de preco disponiveis
    * Alias para CarregarGradeLista() - compatibilidade com API padrao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarGradeLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialogo sem adicionar itens
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Adiciona itens marcados e fecha o dialogo
    * Alias para CmdAdicionarClick() - compatibilidade com API padrao
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdAdicionarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e fecha o dialogo sem adicionar itens
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Refoca grd_4c_Listas para navegar entre listas disponiveis
    * Se o cursor de listas nao existe, recarrega via CarregarGradeLista()
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Listas.Refresh()
            THIS.grd_4c_Listas.SetFocus()
        ELSE
            IF !THIS.CarregarGradeLista()
                MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia dados do form para o Business Object
    * Neste dialogo OPERACIONAL, popula this_cLprecos com a lista selecionada
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            IF !EOF()
                THIS.this_oBusinessObject.this_cLprecos = ALLTRIM(lprecos)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza o form com dados do Business Object
    * Refresca os grids com os cursores atuais do BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_cCursorListas, loc_cCursorItens

        loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
        loc_cCursorItens  = THIS.this_oBusinessObject.this_cCursorItens

        IF USED(loc_cCursorListas) AND PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.Refresh()
        ENDIF

        IF USED(loc_cCursorItens) AND PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles editaveis do dialogo
    * par_lHabilitar: .T. habilita, .F. desabilita
    * OBS: cmd_4c_SelTudo e cmd_4c_ApgaTudo sao icone-only (Caption="") -
    *      NUNCA setar .Enabled neles (botao fica caixa vazia sem icone)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
            THIS.cmd_4c_Adicionar.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Desvincula grids e fecha cursores do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.RecordSource = ""
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.RecordSource = ""
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject.LimparCursores()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Repoe o estado dos controles do dialogo.
    *
    * FIDELIDADE (PILAR 1): o Command1 do SCX legado ("Adiciona os itens
    * marcados a Lista atual") NAO tem PROCEDURE When nem override de Enabled
    * - ele esta SEMPRE clicavel, e o proprio Click filtra com
    * "If CsSigCdLpi.lMarcas = 1" dentro do Scan, de modo que clicar sem nada
    * marcado simplesmente nao insere linha nenhuma. O unico When do form
    * inteiro esta em GradeItens.Column1.Check1 (ver GradeItensCheck1When).
    * Por isso NAO se condiciona cmd_4c_Adicionar.Enabled a contagem de
    * marcados: isso seria regra de negocio inventada e, como este metodo eh
    * chamado de fora (harness de teste), deixaria o botao preso em cinza sem
    * ninguem reabilitar (regra #40 - quem desabilita tem de reabilitar).
    *
    * As grades seguem a existencia do respectivo cursor: grade ligada a
    * cursor inexistente nao tem o que exibir nem como receber foco.
    * OBS: cmd_4c_SelTudo e cmd_4c_ApgaTudo sao icone-only (Caption = "") -
    *      NUNCA alterar .Enabled neles, o icone deixa de desenhar.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
            THIS.cmd_4c_Adicionar.Enabled = .T.
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.Enabled = USED(THIS.this_oBusinessObject.this_cCursorListas)
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Enabled = USED(THIS.this_oBusinessObject.this_cCursorItens)
        ENDIF
    ENDPROC


    *==========================================================================
    * Toggle do CheckBox de grid - grd_4c_Itens.Column1 (THIS.this_oBusinessObject.this_cCursorItens -> .lMarcas)
    * Pattern #185 / Erro146 (2026-09-04): CheckBox em coluna de Grid nao alterna
    * pelo binding nativo. Click/MouseDown suprimem o padrao; MouseUp delega ao
    * KeyPress, que alterna por codigo com REPLACE no cursor + Refresh do grid.
    *==========================================================================
    PROTECTED PROCEDURE BindToggleItens1(par_oChk)
        BINDEVENT(par_oChk, "KeyPress",  THIS, "TgItens1KeyPress")
        BINDEVENT(par_oChk, "MouseUp",   THIS, "TgItens1MouseUp")
        BINDEVENT(par_oChk, "MouseDown", THIS, "TgItens1MouseDown")
        BINDEVENT(par_oChk, "Click",     THIS, "TgItens1Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * TgItens1KeyPress - Alterna a marcacao da linha corrente de grd_4c_Itens.
    *
    * O gate do legado mora AQUI, nao no When. O SCX declara
    *     Check1.When -> Return(CsSigCdLpi.lMarcas = 0)
    * isto eh: item JA marcado nao entra mais na celula, logo NAO pode ser
    * desmarcado um a um (para limpar, o usuario usa o botao Apaga Tudo).
    * Esse gate NAO eh aplicado por GradeItensCheck1When: BINDEVENT DESCARTA
    * o retorno do delegate, entao um When ligado por BINDEVENT nao bloqueia
    * edicao nenhuma (regra conhecida do projeto, Pattern #185/Erro146). Sem
    * replicar a condicao dentro do proprio toggle, a marcacao vira 1 <-> 0
    * nos dois sentidos e o dialogo passa a permitir o que o legado proibe -
    * divergencia silenciosa, sem erro e sem log.
    *--------------------------------------------------------------------------
    PROCEDURE TgItens1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 32)
            RETURN
        ENDIF
        NODEFAULT
        LOCAL loc_cCur
        loc_cCur = THIS.this_oBusinessObject.this_cCursorItens
        IF VARTYPE(loc_cCur) != "C" OR !USED(loc_cCur) OR EOF(loc_cCur)
            RETURN
        ENDIF
        SELECT (loc_cCur)
        *-- Gate do When legado: so a transicao 0 -> 1 eh permitida
        IF VARTYPE(lMarcas) == "L"
            IF !lMarcas
                REPLACE lMarcas WITH .T.
            ENDIF
        ELSE
            IF lMarcas = 0
                REPLACE lMarcas WITH 1
            ENDIF
        ENDIF
        THIS.grd_4c_Itens.Refresh()
    ENDPROC

    PROCEDURE TgItens1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.TgItens1KeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE TgItens1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE TgItens1Click()
        NODEFAULT
    ENDPROC
ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSlpBO.prg):
*==============================================================================
* SigPrSlpBO.prg - Business Object: Selecao Lista de Preco
* Herda de: BusinessBase
* Tabelas: SigCdLpc (listas de preco), SigCdLpi (itens da lista)
* Tipo: OPERACIONAL - dialogo filho do form de pedido
*==============================================================================

DEFINE CLASS SigPrSlpBO AS BusinessBase

    *-- Configuracao da tabela base
    this_cTabela     = "SigCdLpi"
    this_cCampoChave = "cidchaves"

    *-- Cursores internos
    this_cCursorListas = "cursor_4c_Listas"
    this_cCursorItens  = "cursor_4c_Itens"

    *-- Propriedades mapeadas para colunas de SigCdLpi
    this_cCidchaves   = ""
    this_cCgrus       = ""
    this_nComiss      = 0
    this_cCpros       = ""
    this_cDpros       = ""
    this_lFlagutabs   = .F.
    this_cLprecos     = ""
    this_cMoevs       = ""
    this_nPvens       = 0
    this_dVencis      = {}
    this_dVencfs      = {}
    this_cOrdems      = ""
    this_cCcontroles  = ""
    this_nEan13       = 0
    this_nPcuss       = 0
    this_cReffs       = ""
    this_nPrecode     = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdLpi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarListasDisponiveis - Carrega SigCdLpc excluindo a lista atual
    * par_cLPrecoExcluir: codigo da lista de preco atual (a ser excluida)
    * Popula cursor_4c_Listas com colunas: lprecos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarListasDisponiveis(par_cLPrecoExcluir)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF USED(THIS.this_cCursorListas)
                USE IN (THIS.this_cCursorListas)
            ENDIF

            loc_cSQL = "SELECT lprecos FROM SigCdLpc " + ;
                       "WHERE lprecos <> " + EscaparSQL(par_cLPrecoExcluir) + " " + ;
                       "ORDER BY lprecos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorListas) > 0
                SELECT (THIS.this_cCursorListas)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                *-- Sem modal aqui: quem reporta eh o form, com a mensagem
                *-- do legado + este detalhe (evita dois dialogos)
                THIS.this_cMensagemErro = "Falha ao carregar listas de pre" + ;
                                          CHR(231) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensDaLista - Carrega SigCdLpi de uma lista especifica
    * par_cLPrecos: codigo da lista de preco selecionada
    * Popula cursor_4c_Itens com lMarcas=0 e todos os campos de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensDaLista(par_cLPrecos)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, a.cgrus, a.comiss, a.cpros, a.dpros, " + ;
                       "a.flagutabs, a.lprecos, a.moevs, a.pvens, a.vencis, a.vencfs, " + ;
                       "a.ordems, a.ccontroles, a.cidchaves, a.ean13, a.pcuss, " + ;
                       "a.reffs, a.precode " + ;
                       "FROM SigCdLpi a " + ;
                       "WHERE a.lprecos = " + EscaparSQL(par_cLPrecos) + " " + ;
                       "ORDER BY a.cpros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens) > 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                *-- Sem modal aqui: quem reporta eh o form (ver acima)
                THIS.this_cMensagemErro = "Falha ao carregar itens da lista de " + ;
                                          "pre" + CHR(231) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarItensMarcados - Copia itens marcados para o cursor de destino
    * par_cLPrecoAtual:        codigo da lista atual (destino)
    * par_cCursorDestino:      nome do cursor VFP local do form pai (CrSigCdLpi)
    * par_lAplicarArredond:    .T. se deve arredondar pvens (CompVenda <> "C")
    * Retorna: numero de itens adicionados, -1 em caso de erro
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarItensMarcados(par_cLPrecoAtual, par_cCursorDestino, par_lAplicarArredond)
        LOCAL loc_nAdicionados, loc_oErro, loc_cLPrecoAtual, loc_lPodeExecutar
        LOCAL loc_lTemTag

        loc_nAdicionados    = 0
        loc_lTemTag         = .F.
        loc_lPodeExecutar   = .T.
        loc_cLPrecoAtual    = ALLTRIM(par_cLPrecoAtual)

        IF !USED(THIS.this_cCursorItens)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF
        IF loc_lPodeExecutar AND !USED(par_cCursorDestino)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF

        IF loc_lPodeExecutar
            TRY
                *-- Remove itens vazios do cursor destino (sem cpros)
                *-- Legado: "Delete From CrSigCdLpi Where Empty(cpros)". A
                *-- forma SQL com NOME DE CURSOR EM EXPRESSAO - DELETE FROM
                *-- (var) - nao tem precedente nenhum no projeto; o padrao
                *-- estabelecido eh SELECT (alias) + DELETE FOR <cond>
                *-- (FpdBO:282, GcpBO:406).
                SELECT (par_cCursorDestino)
                DELETE FOR EMPTY(cpros)

                SELECT (THIS.this_cCursorItens)
                GO TOP

                *-- O legado usa Seek(...,'CrSigCdLpi','CPros'), que pressupoe a
                *-- TAG "CPros" sempre presente - verdade no cursor que o
                *-- AddCursor do frmcadastro Fortyus cria. No pai MIGRADO a tag
                *-- eh condicional: o FormLpr so faz "INDEX ON PADR(cpros,14)
                *-- TAG cpros" quando CarregarItens teve sucesso, entao em
                *-- INCLUIR (cursor recem-criado por CREATE CURSOR) ela NAO
                *-- existe e o SEEK estouraria dentro do TRY, devolvendo -1 e
                *-- exibindo "Erro ao adicionar itens" - sem nada ter sido
                *-- adicionado. Medir a tag UMA vez, fora do SCAN, e cair para
                *-- LOCATE quando faltar: os dois respondem a MESMA pergunta do
                *-- legado ("este produto ja esta no destino?").
                loc_lTemTag = THIS.DestinoTemTagCPros(par_cCursorDestino)

                SCAN
                    *-- Campos lidos do alias CORRENTE (o SELECT acima posiciona
                    *-- em this_cCursorItens): o nome do cursor eh PROPRIEDADE,
                    *-- citar "cursor_4c_Itens" literal quebra se ela mudar
                    IF lMarcas = 1
                        *-- Verifica se cpros ja existe no cursor destino
                        IF !THIS.ExisteProdutoNoDestino(cpros, par_cCursorDestino, loc_lTemTag)
                            SCATTER MEMVAR

                            m.lMarcas   = 0
                            m.lprecos   = loc_cLPrecoAtual
                            m.cidchaves = fUniqueIds()
                            m.vencis    = NVL(m.vencis, {})
                            m.vencfs    = NVL(m.vencfs, {})

                            *-- PENDENCIA DELIBERADA (regras #17 e #27)
                            *-- Legado: m.pvens = fArredondamento(m.pvens,
                            *-- ThisForm.ParentForm.poDataMgr) quando
                            *-- CompVenda <> "C". fArredondamento eh funcao
                            *-- GLOBAL do legado (SIGFUNCS) que NAO veio no
                            *-- acervo - nao existe na pasta Framework nem em
                            *-- app/utils. Ela devolve VALOR DE CALCULO, e a
                            *-- regra #27 manda DEIXAR AUSENTE em vez de
                            *-- inventar stub: ROUND(m.pvens, 2) nao eh a regra
                            *-- do legado (o arredondamento real vem de
                            *-- parametro gravado no banco, lido via poDataMgr)
                            *-- e gravaria PRECO ERRADO em silencio.
                            *-- par_lAplicarArredond continua chegando do form
                            *-- para que ligar fArredondamento seja uma linha
                            *-- so quando a funcao for portada.
                            *-- Mesmo tratamento em FormLpr.prg:2810 (mesma
                            *-- coluna pvens, mesma tabela SigCdLpi).

                            INSERT INTO (par_cCursorDestino) FROM MEMVAR
                            loc_nAdicionados = loc_nAdicionados + 1

                            SELECT (THIS.this_cCursorItens)
                        ENDIF
                    ENDIF
                ENDSCAN

            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
                loc_nAdicionados = -1
            ENDTRY
        ENDIF

        RETURN loc_nAdicionados
    ENDPROC

    *--------------------------------------------------------------------------
    * DestinoTemTagCPros - .T. quando o cursor de destino tem a TAG "CPros"
    * que o Seek do legado pressupoe.
    *
    * Enumera as tags por NUMERO com TAG(n), que devolve "" passado o ultimo
    * indice - mesma forma ja usada em SIGPRESTBO.prg:365. Evita de proposito
    * TAGNO("CPros") / TAGCOUNT(cCDX, alias): a 1a dispara erro com tag
    * inexistente (que eh exatamente o caso a detectar) e a 2a exige o
    * argumento do .CDX, sem precedente no projeto.
    *
    * TAG(n) le a work area CORRENTE, por isso o SELECT - com o alias salvo e
    * restaurado, ja que o chamador esta posicionado no cursor de itens.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DestinoTemTagCPros(par_cCursorDestino)
        LOCAL loc_lTem, loc_cAliasAnterior, loc_nTag

        loc_lTem           = .F.
        loc_cAliasAnterior = ALIAS()

        IF !USED(par_cCursorDestino)
            RETURN .F.
        ENDIF

        SELECT (par_cCursorDestino)

        loc_nTag = 1
        DO WHILE !EMPTY(TAG(loc_nTag))
            IF UPPER(ALLTRIM(TAG(loc_nTag))) == "CPROS"
                loc_lTem = .T.
                EXIT
            ENDIF
            loc_nTag = loc_nTag + 1
        ENDDO

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lTem
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteProdutoNoDestino - Responde a pergunta do Seek legado: o produto
    * par_cCpros ja esta no cursor de destino?
    *
    * par_lTemTag = .T.  -> usa SEEK pela TAG "CPros" (caminho do legado)
    * par_lTemTag = .F.  -> usa LOCATE FOR, para o cursor que nao foi indexado
    *
    * O LOCATE exige SELECT do destino, o que TROCA o alias corrente; como
    * quem chama esta no meio de um SCAN do cursor de itens, o alias eh
    * salvo e restaurado aqui - sem isso o SCAN passaria a andar no cursor
    * errado e o laco nao terminaria onde deve.
    *
    * A comparacao usa PADR na largura da coluna do destino: cpros eh char de
    * largura fixa e o LOCATE tem de casar o MESMO valor que a tag
    * "INDEX ON PADR(cpros, 14)" casaria (regra #42 - chave posicional).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExisteProdutoNoDestino(par_cCpros, par_cCursorDestino, par_lTemTag)
        LOCAL loc_lExiste, loc_cAliasAnterior, loc_cChave, loc_nLargura

        IF par_lTemTag
            RETURN SEEK(par_cCpros, par_cCursorDestino, "CPros")
        ENDIF

        loc_lExiste        = .F.
        loc_cAliasAnterior = ALIAS()

        SELECT (par_cCursorDestino)

        loc_nLargura = FSIZE("cpros", par_cCursorDestino)
        IF loc_nLargura <= 0
            loc_nLargura = LEN(par_cCpros)
        ENDIF
        loc_cChave = PADR(par_cCpros, loc_nLargura)

        LOCATE FOR PADR(cpros, loc_nLargura) == loc_cChave
        loc_lExiste = FOUND()

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 1
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 0
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorListas)
            USE IN (THIS.this_cCursorListas)
        ENDIF
        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para as propriedades this_*
    * par_cAliasCursor: nome do cursor com os dados de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves  = TratarNulo(cidchaves, "C")
                THIS.this_cCgrus      = TratarNulo(cgrus, "C")
                THIS.this_nComiss     = TratarNulo(comiss, "N")
                THIS.this_cCpros      = TratarNulo(cpros, "C")
                THIS.this_cDpros      = TratarNulo(dpros, "C")

                IF VARTYPE(flagutabs) = "L"
                    THIS.this_lFlagutabs = flagutabs
                ELSE
                    IF VARTYPE(flagutabs) = "N"
                        IF VARTYPE(flagutabs) = "L"
                            THIS.this_lFlagutabs = flagutabs
                        ELSE
                            THIS.this_lFlagutabs = (NVL(flagutabs, 0) = 1)
                        ENDIF
                    ELSE
                        THIS.this_lFlagutabs = NVL(flagutabs, .F.)
                    ENDIF
                ENDIF

                THIS.this_cLprecos    = TratarNulo(lprecos, "C")
                THIS.this_cMoevs      = TratarNulo(moevs, "C")
                THIS.this_nPvens      = TratarNulo(pvens, "N")
                THIS.this_dVencis     = NVL(vencis, {})
                THIS.this_dVencfs     = NVL(vencfs, {})
                THIS.this_cOrdems     = TratarNulo(ordems, "C")
                THIS.this_cCcontroles = TratarNulo(ccontroles, "C")
                THIS.this_nEan13      = TratarNulo(ean13, "N")
                THIS.this_nPcuss      = TratarNulo(pcuss, "N")
                THIS.this_cReffs      = TratarNulo(reffs, "C")
                THIS.this_nPrecode    = TratarNulo(precode, "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdLpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdLpi (cgrus, comiss, cpros, dpros, flagutabs, " + ;
                       "lprecos, moevs, pvens, vencis, vencfs, ordems, ccontroles, " + ;
                       "cidchaves, ean13, pcuss, reffs, precode) VALUES (" + ;
                       EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss, 2) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cDpros) + ", " + ;
                       IIF(THIS.this_lFlagutabs, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cLprecos) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPvens, 6) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencis), "NULL", FormatarDataSQL(THIS.this_dVencis)) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencfs), "NULL", FormatarDataSQL(THIS.this_dVencfs)) + ", " + ;
                       EscaparSQL(THIS.this_cOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cCcontroles) + ", " + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcuss, 6) + ", " + ;
                       EscaparSQL(THIS.this_cReffs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecode, 5) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE


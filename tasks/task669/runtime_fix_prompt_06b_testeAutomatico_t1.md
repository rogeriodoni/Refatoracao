# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/10/2026 04:54:55 PM] CreateObject: Impossível Efetuar Conexão com Servidor de Banco de Dados...


### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-18 16:52:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-18 16:52:24] [INFO] Config FPW: (nao fornecido)
[2026-10-18 16:52:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-18 16:52:24] [INFO] Timeout: 300 segundos
[2026-10-18 16:52:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sgbftw3q.prg
[2026-10-18 16:52:24] [INFO] Conteudo do wrapper:
[2026-10-18 16:52:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprrcu', 'C:\4c\tasks\task669', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprrcu', 'C:\4c\tasks\task669', 'OPERACIONAL'
QUIT

[2026-10-18 16:52:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sgbftw3q.prg
[2026-10-18 16:52:24] [INFO] VFP output esperado em: C:\4c\tasks\task669\vfp_output.txt
[2026-10-18 16:52:24] [INFO] Executando Visual FoxPro 9...
[2026-10-18 16:52:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sgbftw3q.prg
[2026-10-18 16:52:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sgbftw3q.prg
[2026-10-18 16:52:24] [INFO] Timeout configurado: 300 segundos
[2026-10-18 16:54:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-18 16:54:55] [INFO] VFP9 finalizado em 151.7314363 segundos
[2026-10-18 16:54:55] [INFO] Exit Code: 
[2026-10-18 16:54:55] [INFO] 
[2026-10-18 16:54:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-18 16:54:55] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sgbftw3q.prg
[2026-10-18 16:54:55] [INFO] 
[2026-10-18 16:54:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-18 16:54:55] [INFO] * Auto-generated wrapper for parameters
[2026-10-18 16:54:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-18 16:54:55] [INFO] * Parameters: 'Formsigprrcu', 'C:\4c\tasks\task669', 'OPERACIONAL'
[2026-10-18 16:54:55] [INFO] 
[2026-10-18 16:54:55] [INFO] * Anti-dialog protections for unattended execution
[2026-10-18 16:54:55] [INFO] SET SAFETY OFF
[2026-10-18 16:54:55] [INFO] SET RESOURCE OFF
[2026-10-18 16:54:55] [INFO] SET TALK OFF
[2026-10-18 16:54:55] [INFO] SET NOTIFY OFF
[2026-10-18 16:54:55] [INFO] SYS(2335, 0)
[2026-10-18 16:54:56] [INFO] 
[2026-10-18 16:54:56] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprrcu', 'C:\4c\tasks\task669', 'OPERACIONAL'
[2026-10-18 16:54:56] [INFO] QUIT
[2026-10-18 16:54:56] [INFO] 
[2026-10-18 16:54:56] [INFO] === Fim do Wrapper.prg ===
[2026-10-18 16:54:56] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprrcu",
  "timestamp": "20261018165455",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprrcu.prg):
*==============================================================================
* Formsigprrcu.prg - Form Operacional: Recalculo de Custos de Produto
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo simples (sem PageFrame no legado) que dispara o
*       reprocessamento em lote da fila SigOpClC (fRecalculaC por registro).
*       Layout FLAT: cabecalho (cntSombra), Shape de agrupamento dos botoes,
*       botao Processar (OK) e botao Encerrar (SAIR), com Label1 exibindo o
*       status do processamento.
* SCX Origem: SIGPRRCU.scx (tasks\task669)
* BO: sigprrcuBO (fila SigOpClC)
*
* FASE 3/8 - Estrutura base: DEFINE CLASS, Init/InicializarForm, cabecalho.
*
* FASE 4/8 - Este legado NAO tem Page1/Page2 nem grade de lista (dump
* confirma: form FLAT com so cntSombra + Shape1 + 2 CommandButton + 1
* Label - ver layout.json/analise.json de task669, "temGrid": false).
* Inventar Grid + 6 botoes CRUD aqui violaria o PILAR 1 (UX fiel ao
* legado); em vez disso, esta fase completa a UI REAL que faltava: Shape1,
* botoes Processar/Encerrar, Label1 de status, e os eventos Activate/
* BtnProcessarClick/BtnEncerrarClick com o recalculo de custo propriamente dito
* (fRecalculaC - rotina externa do Fortyus.Exe, fora do acervo migrado,
* deixada deliberadamente SEM wrapper - regra #27/pattern de funcao que
* devolve valor de calculo).
*
* Load legado ("=fConfigGeral()") NAO PORTADO de proposito (mesmo padrao de
* FormSigMvExp/Formsigprema): utils\fconfiggeral.prg e um wrapper NO-OP so
* para o p-code dos VCX legado - "em codigo NOSSO nunca se chama
* fConfigGeral" (cabecalho do proprio arquivo). O papel dele (SETs/paths/
* conexao) ja e do start\config.prg/main.prg, antes deste form abrir.
*
* FASE 7/8 - Eventos principais dos botoes. Este legado NAO tem CRUD algum
* (dump: Class "form" puro, sem frmcadastro, sem pcEscolha, sem
* Incluir/Alterar/Visualizar/Excluir) - os unicos botoes do SCX sao OK
* ("Processar") e SAIR ("Encerrar"), e sao esses dois os "eventos
* principais" aqui. Gerar BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick exigiria INVENTAR botao que o legado
* nao tem (viola o PILAR 1) ou criar metodo vazio (proibido pela regra de
* completude). O que esta fase entregou de REAL, conferido linha a linha
* contra o OK.Click legado:
*   1. Rollback de FIM DE RODADA (linha apos o "EndIf" do Scan, FORA do
*      If/Else) que a migracao havia perdido - so os Rollback de dentro do
*      Scan tinham vindo. Conexao manual (Transactions = 2) deixaria os
*      locks de SigOpClC presos pelo resto do polling.
*      -> sigprrcuBO.DescartarTransacaoPendente(), chamada no loop.
*   2. TRY/CATCH no corpo do processamento + restauracao do estado da UI
*      FORA do TRY: sem isso, qualquer excecao no loop deixava "Program
*      Error" cru do VFP e a tela CONGELADA (cursor off, Processar e
*      Encerrar desabilitados, sem via de saida).
*   3. Guarda de reentrancia (this_lEmProcessamento): BtnProcessarClick entra pelo
*      Click E pelo Activate, o corpo faz INKEY (que despacha eventos) e
*      Enabled = .F. NAO barra .Click() programatico - sem a guarda o
*      Activate aninhava um segundo loop de polling dentro do primeiro.
*   4. Encerrar durante o lote SINALIZA parada (this_lCancelarProcessamento)
*      em vez de dar Release com o loop ainda na pilha.
*
* FASE 8/8 - Eventos auxiliares e consolidacao final. O roteiro generico desta
* fase pede BtnBuscarClick/BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
* HabilitarCampos/LimparCampos/CarregarLista/AjustarBotoesPorModo - todos
* metodos de form CRUD (Page1=Lista/Page2=Dados). Este form NAO tem Lista, NAO
* tem campo de dados algum (so o texto de status do processamento, que nao e
* editavel) e NAO tem CRUD - gerar qualquer um desses stubs inventaria
* funcionalidade que o legado nao tem (viola o PILAR 1) ou seria metodo vazio
* (proibido pela regra de completude). O processamento em lote JA É o unico
* fluxo da tela, entregue nas Fases 4 e 7 (BtnProcessarClickExec/
* sigprrcuBO.ProcessarLoteFila).
*
* O trabalho REAL desta fase foi nomear os dois botoes PELA ACAO (Caption),
* nao pelo nome do objeto legado - a mesma regra que rege o gate da Fase 8
* para telas de "processador em lote" (criterios digitaveis ou nenhum + um
* botao que varre e GRAVA em tabela real + um botao que so fecha, sem Page2
* nem grade). O objeto do SCX se chama "OK" (Caption "Processar") e "SAIR"
* (Caption "Encerrar"), mas o migrado das fases anteriores tinha herdado o
* NOME DO OBJETO (cmd_4c_OK/BtnOkClick, cmd_4c_Sair/BtnSairClick) em vez da
* acao - exatamente o desvio do PILAR 3 que a convencao do projeto usa em
* 851+ handlers de "fechar" (BtnEncerrarClick) e 26+ de "processar"
* (BtnProcessarClick). Renomeado nesta fase: cmd_4c_OK -> cmd_4c_Processar,
* BtnOkClick/BtnOkClickExec -> BtnProcessarClick/BtnProcessarClickExec,
* cmd_4c_Sair -> cmd_4c_Encerrar, BtnSairClick -> BtnEncerrarClick (e
* tasks\task669\mapeamento.json atualizado no mesmo passo, ja que o objeto
* mudou de nome - o ValidarUIFidelity monta o caminho a partir dele).
*==============================================================================

DEFINE CLASS Formsigprrcu AS FormBase

    *-- Dimensoes EXATAS do dump legado (PILAR 1) - dialogo pequeno, nao eh
    *-- form CRUD (a largura canonica de 1000 e o cnt_4c_Saida.Left=917 so
    *-- valem para CRUD - regra #10/#79). SAIR termina em 505+75=580, exato
    *-- na borda direita do form - confirma que 580 e layout real, nao folga.
    Width        = 580
    Height       = 150
    Caption      = "Rec" + CHR(225) + "lculo de Custos de Produto"
    AutoCenter   = .T.
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowState  = 0
    *-- BorderStyle = 2 (Fixed Dialog) esta DECLARADO no dump do SCX
    *-- (secao de propriedades de SIGPRRCU) e a migracao tinha DESCARTADO
    *-- a linha. O default de Form no VFP9 e 3 (Sizable): sem esta
    *-- transcricao o dialogo nasce REDIMENSIONAVEL pela borda, e como
    *-- nenhum controle tem ancoragem, encolher a janela RECORTA em
    *-- silencio justamente o bloco da direita (shp_4c_Shape1 em
    *-- Left=498 e os botoes em Left=430/505, que terminam em 580 -
    *-- exatamente a borda). Transcricao, nao escolha. NAO confundir
    *-- com Closable, que o dump NAO declara e por isso segue fora
    *-- daqui (ver o comentario abaixo).
    BorderStyle  = 2
    *-- Themes = .F. esta DECLARADO no dump do SCX (secao de propriedades de
    *-- SIGPRRCU) - transcricao, nao escolha. Nao confundir com o Themes = .T.
    *-- dos dois CommandButton, que e desvio DELIBERADO e documentado em
    *-- ConfigurarBotoes (icone some com Enabled = .F. se Themes = .F.).
    Themes       = .F.
    ClipControls = .F.
    DataSession  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- "Closable = .F." foi REMOVIDO nesta fase: o dump do SCX NAO o declara
    *-- (declara so ControlBox = .F., MaxButton = .F., MinButton = .F. e
    *-- TitleBar = 0). As cinco propriedades sao INDEPENDENTES - sem barra de
    *-- titulo os botoes nao DESENHAM, mas Closable continua .T. e o Alt+F4 do
    *-- legado continua funcionando. Fixar .F. nao e redundancia inofensiva:
    *-- tira do usuario uma via de saida que o original tinha, sem erro, sem
    *-- log e sem aparecer em screenshot. Transcrever essas propriedades SO
    *-- quando o dump as declara - nunca derivar uma da outra.

    *-- Equivalente a ThisForm.Parametrizado do legado: Type('pParam')='C'.
    *-- Quando .T., falha de conexao nao exibe MessageBox (chamada silenciosa
    *-- em lote) - a mesma distincao do Init original.
    this_lParametrizado = .F.

    *-- Guarda de REENTRANCIA do processamento. BtnProcessarClick tem DUAS entradas
    *-- (BINDEVENT "Click" do botao Processar e a chamada direta
    *-- THIS.cmd_4c_Processar.Click() do Activate), e o corpo dele eh um loop de
    *-- polling com INKEY - que DESPACHA eventos. Activate volta a disparar
    *-- toda vez que o form reganha o foco (tipicamente quando um MsgErro do
    *-- BO fecha), e "cmd_4c_Processar.Enabled = .F." NAO impede uma chamada
    *-- PROGRAMATICA a .Click(): sem esta flag, o Activate aninha um segundo
    *-- loop de polling dentro do primeiro, cada um com seu INKEY, e a tela
    *-- fica inoperante sem erro nenhum. Mesmo padrao das guardas de lookup
    *-- modal do projeto (regra #37/#47).
    this_lEmProcessamento = .F.

    *-- Pedido de parada vindo do botao Encerrar DURANTE o processamento.
    *-- O legado tentava resolver isso no ramo "MouseSobreBotaoSair(...) And
    *-- (lnKey=151)" do OK.Click, que chamava Sair.Click() (= Release) e so
    *-- DEPOIS executava "Set Cursor On" / "Label1.Caption = ''" - ou seja
    *-- mexia no form JA liberado; e o metodo MouseSobreBotaoSair nao tem
    *-- corpo no dump do SCX, logo o ramo nunca rodou e o defeito nunca
    *-- apareceu. Aqui o Encerrar SINALIZA e o loop sai pelo caminho normal,
    *-- que entao libera o form - mesma UX (clicou, a tela fecha), sem
    *-- operar sobre objeto destruido.
    this_lCancelarProcessamento = .F.

    *--------------------------------------------------------------------------
    * Init - Recebe o parametro opcional (equivalente a LParameters pParam do
    * legado) e delega para FormBase.Init() -> InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cParametro)
        THIS.this_lParametrizado = (VARTYPE(par_cParametro) = "C")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Reproduz o With ThisForm / poDataMgr do Init legado:
    * sem conexao valida o form NAO abre (retorna .F.), e o MessageBox de erro
    * so aparece quando NAO esta parametrizado (chamada silenciosa em lote).
    * Com conexao OK, cria o BO (fila SigOpClC) e monta o cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(gnConnHandle) = "N" AND gnConnHandle > 0
                THIS.this_oBusinessObject = CREATEOBJECT("sigprrcuBO")

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.ConfigurarPageFrame()

                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Log de inicio do processamento (equivalente ao bloco
                    *-- "If ThisForm.Parametrizado" do Init legado) - so em
                    *-- modo lote/Fortyus.Exe, nunca em uso interativo.
                    IF THIS.this_lParametrizado
                        THIS.GravarLogProcessamento("Iniciando o Processamento : Fortyus.Exe (SigOpClC) - Recalculo de Custos")
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    IF !THIS.this_lParametrizado
                        MsgErro("Erro ao criar sigprrcuBO. VARTYPE retornou: " + ;
                                VARTYPE(THIS.this_oBusinessObject), "Erro")
                    ENDIF
                ENDIF
            ELSE
                *-- Mensagem EXATA do legado (CreateObject('fSqlConector',...)
                *-- com pnIdconn <= 0), so exibida fora do modo parametrizado.
                IF !THIS.this_lParametrizado
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados...", ;
                            "CreateObject")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Equivalente a "If ThisForm.Parametrizado / ThisForm.OK.Click()
    * / EndIf" do legado: em modo lote (Fortyus.Exe com parametro), dispara o
    * processamento sozinho ao exibir o form, sem o usuario clicar em nada.
    * PUBLIC (evento nativo do Form).
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        IF THIS.this_lParametrizado
            THIS.cmd_4c_Processar.Click()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL. Este
    * form nao usa PageFrame (legado "Class: form" sem BaseClass: pageframe).
    * Ordem de desenho igual ao legado: cabecalho, Shape (moldura atras dos
    * botoes), botoes OK/SAIR, label de status.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Fundo do form (dump: Picture = ..\framework\imagens\new_background.jpg).
        *-- A migracao tinha DESCARTADO esta linha - e .Picture inexistente/ausente
        *-- falha em SILENCIO no VFP9 (sem erro de compilacao, sem erro de runtime,
        *-- nada no log): a tela so abria com o cinza nativo em vez da textura do
        *-- legado. Conferido que new_background.jpg EXISTE em vbmp\ (alvo de
        *-- gc_4c_CaminhoIcones), que e a forma usada por 138 forms operacionais -
        *-- NUNCA remontar o caminho a partir de gc_4c_CaminhoBase.
        *-- Vem ANTES dos AddObject: o fundo tem de estar posto antes de os
        *-- controles desenharem por cima.
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.ConfigurarCabecalho()
        THIS.ConfigurarShape()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarLabelStatus()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original).
    * Width dos labels = THIS.Width - 20 (canonico do projeto, NUNCA o 769 do
    * dump legado) - controle filho com Width fixo maior que o container seria
    * RECORTADO (regra do controle fora da area do pai).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(255, 255, 255)
            *-- ToolTipText declarado no dump (lblTitulo) - o form tem
            *-- ShowTips = .T., logo a dica realmente aparece em runtime.
            *-- Acentos por CHR(): i-acute = 237, o-acute = 243.
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape - Moldura decorativa por tras dos botoes OK/SAIR (Shape1
    * do legado). BorderStyle=0 (sem borda desenhada) e fiel ao SCX - existe
    * so como area de agrupamento visual. Shape NAO tem ForeColor (regra #33
    * da arquitetura) - so BorderColor/FillColor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -5
            .Left        = 498
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Processar (OK) e Encerrar (SAIR), standalone
    * (fora de CommandGroup). Themes=.T. + DisabledPicture (em vez do
    * Themes=.F. do dump legado) para o icone continuar visivel quando o
    * botao fica Enabled=.F. durante o processamento - ambos os botoes sao
    * desabilitados em algum momento do loop de BtnProcessarClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 430
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Cancel          = .F.
            .Caption         = "Processar"
            .TabIndex        = 8
            .ToolTipText     = ""
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 505
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .TabIndex        = 9
            .ToolTipText     = "[ESC] Sair"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabelStatus - Label1 do legado: texto de status exibido
    * durante o processamento (preenchido/limpo pelo BtnProcessarClick). ForeColor
    * 90,90,90 igual ao dump (controle direto no form, sem container escuro
    * por tras). Caption inicial vazio - "Label1" no dump e placeholder do
    * Form Designer, nunca chega a ser exibido em runtime no legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelStatus()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top        = 108
            .Left       = 129
            .Width      = 321
            .Height     = 16
            .AutoSize   = .F.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = ""
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Entrada do botao Processar. Wrapper FINO: so a guarda de
    * reentrancia (this_lEmProcessamento) mora aqui; o corpo esta em
    * BtnProcessarClickExec. O padrao e o da regra #37/#47 (lookup modal), pelo mesmo
    * motivo: o corpo tem saida antecipada - no caso, um IF ... RETURN de
    * sanidade do BO - e, com set/clear no proprio corpo, essa saida deixaria a
    * flag TRAVADA ligada e o botao Processar morto pelo resto da vida do form.
    * Liberando a flag no wrapper, toda saida do corpo passa por ela.
    *
    * PUBLIC (chamado via BINDEVENT "Click" e por THIS.cmd_4c_Processar.Click() no
    * Activate - regra #3: handler de evento tem de ser PUBLIC).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        IF THIS.this_lEmProcessamento
            RETURN
        ENDIF

        THIS.this_lEmProcessamento = .T.

        THIS.BtnProcessarClickExec()

        THIS.this_lEmProcessamento = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClickExec - Corpo do processamento da fila de recalculo (SigOpClC).
    * Em modo INTERATIVO (nao parametrizado) processa uma unica rodada e para;
    * em modo PARAMETRIZADO (lote/Fortyus.Exe) fica em polling continuo a cada
    * 0.5s ate ESC, Encerrar ou erro de conexao - identico ao "Do While .t." do
    * OK.Click legado.
    *
    * Omitido de proposito: o ramo "ThisForm.MouseSobreBotaoSair(...) And
    * (lnKey=151)" do legado - MouseSobreBotaoSair nao tem corpo no dump do
    * SCX (metodo sem codigo), logo o ramo e sempre inerte tambem no
    * original. O que ele PRETENDIA fazer (sair quando o usuario aciona o
    * Encerrar durante o lote) esta coberto por this_lCancelarProcessamento,
    * sem o defeito de liberar o form por baixo do proprio loop.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClickExec()
        LOCAL loc_nMov, loc_lErroConexao, loc_lConsultaOk, loc_nKey, loc_oErro

        *-- Sem BO nao ha o que processar: o InicializarForm so devolve .T.
        *-- com o BO criado, mas BtnProcessarClick tambem entra pelo Activate, que
        *-- dispara mesmo quando o form foi exibido por outro caminho.
        *-- RETURN FORA de TRY/CATCH (regra #1).
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            IF !THIS.this_lParametrizado
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + CHR(237) + ;
                        "vel - imposs" + CHR(237) + "vel processar a fila de rec" + CHR(225) + "lculo.", "Processar")
            ENDIF
            RETURN
        ENDIF

        THIS.this_lCancelarProcessamento = .F.
        THIS.cmd_4c_Processar.Enabled = .F.
        SET CURSOR OFF

        loc_nMov = 1
        loc_lErroConexao = .F.

        KEYBOARD "{LEFTARROW}"

        TRY
            DO WHILE .T.
                THIS.cmd_4c_Encerrar.Enabled = .F.

                THIS.lbl_4c_Label1.Caption = "Aguardando Produtos Para Processar" + REPLICATE(".", loc_nMov)
                loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)

                loc_lConsultaOk = THIS.this_oBusinessObject.ProcessarLoteFila()
                IF !loc_lConsultaOk
                    loc_lErroConexao = .T.
                ENDIF

                *-- Rollback de FIM DE RODADA, FORA do IF/ELSE da consulta -
                *-- transcricao da linha que o legado executa logo apos o
                *-- "EndIf" do Scan e que a migracao havia perdido (so os
                *-- Rollback de DENTRO do Scan tinham sido portados). A
                *-- conexao e manual (Transactions = 2), entao o proprio
                *-- SELECT da fila abre transacao: sem o descarte, uma rodada
                *-- que termine com transacao aberta prende os locks de
                *-- SigOpClC pelo resto do polling.
                THIS.this_oBusinessObject.DescartarTransacaoPendente()

                THIS.cmd_4c_Encerrar.Enabled = .T.

                *-- INKEY despacha eventos (mouse/teclado): e aqui que o
                *-- clique no Encerrar chega durante o lote, e por isso a
                *-- flag de cancelamento e testada DEPOIS dele.
                loc_nKey = INKEY(0.5, "M")

                IF !THIS.this_lParametrizado OR loc_nKey = 27 OR loc_lErroConexao ;
                   OR THIS.this_lCancelarProcessamento
                    EXIT
                ENDIF
            ENDDO
        CATCH TO loc_oErro
            *-- CATCH nunca silencioso (regra #9). Sem este TRY o usuario
            *-- veria o "Program Error" CRU do VFP e - pior - a tela ficaria
            *-- CONGELADA: cursor desligado, Processar e Encerrar desabilitados
            *-- e nenhuma via de saida, porque a restauracao do estado da UI
            *-- esta depois do loop.
            loc_lErroConexao = .T.
            IF !THIS.this_lParametrizado
                MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                        " PROC=" + loc_oErro.Procedure, "Erro ao processar rec" + CHR(225) + "lculo")
            ENDIF
        ENDTRY

        *-- Restauracao do estado da UI: FORA do TRY, roda em todo caminho
        *-- (fim normal, ESC, Encerrar ou excecao). O legado nao reabilita o
        *-- Encerrar aqui porque, no caminho dele, o botao sempre volta a .T.
        *-- dentro do loop - mas no caminho de EXCECAO (que o legado nao tinha)
        *-- ele ficaria desabilitado para sempre.
        SET CURSOR ON
        THIS.lbl_4c_Label1.Caption = ""
        THIS.cmd_4c_Encerrar.Enabled = .T.
        THIS.cmd_4c_Processar.Enabled = .T.

        *-- Fim do lote em modo parametrizado: grava o log e encerra o
        *-- processo, INCONDICIONALMENTE como no legado (inclusive quando a
        *-- saida foi por erro de conexao - e o Fortyus.Exe que reagenda).
        IF THIS.this_lParametrizado
            THIS.GravarLogProcessamento("Concluindo o Processamento : Prod2005.Exe (SigOpClC) - Recalculo de Custos")
            THIS.Release()
            QUIT
        ENDIF

        *-- Pedido de parada feito pelo Encerrar durante o lote: o Release
        *-- que o BtnEncerrarClick adiou acontece agora, com o loop ja encerrado
        *-- e nenhum acesso a controle depois deste ponto.
        IF THIS.this_lCancelarProcessamento
            THIS.this_lCancelarProcessamento = .F.
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form (ThisForm.Release do legado). PUBLIC
    * (BINDEVENT "Click" - regra #3).
    *
    * Com processamento em andamento (so alcancavel em modo parametrizado, via
    * o despacho de eventos do INKEY), NAO libera o form na hora: sinaliza a
    * parada e deixa o loop sair pelo caminho normal, que faz o Release. Dar
    * Release aqui destruiria o form com BtnProcessarClickExec ainda na pilha, e as
    * linhas seguintes do loop (Label1.Caption, Enabled dos botoes) passariam a
    * tocar objeto ja liberado - exatamente o que o ramo inerte
    * MouseSobreBotaoSair do legado faria se algum dia tivesse corpo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        IF THIS.this_lEmProcessamento
            THIS.this_lCancelarProcessamento = .T.
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarLogProcessamento - Grava bloco de log identico ao legado (inicio
    * em InicializarForm, fim em BtnProcessarClick), usado so em modo PARAMETRIZADO
    * (lote via Fortyus.Exe). Caminho ancorado em gc_4c_CaminhoBase (regra de
    * paths - nunca depender do diretorio corrente implicito).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarLogProcessamento(par_cMensagem)
        LOCAL loc_cArquivo, loc_cLinha
        loc_cArquivo = ADDBS(gc_4c_CaminhoBase) + "Fortyus.Log"

        STRTOFILE("", loc_cArquivo, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), loc_cArquivo, .T.)

        STRTOFILE(par_cMensagem + CHR(10), loc_cArquivo, .T.)

        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), loc_cArquivo, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), loc_cArquivo, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
    * percorre recursivamente Controls e Pages (de eventuais PageFrames) para
    * garantir que tudo fique visivel apos a montagem do layout.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

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

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object e encerra pela heranca de FormBase
    * (RELEASE POPUP + CriarMenuPrincipal - regra do menu encolhido).
    * DODEFAULT() tem de ser a ULTIMA linha.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprrcuBO.prg):
*==============================================================================
* SIGPRRCUBO.PRG
*
* Business Object para sigprrcu (Formsigprrcu - "Recalculo de Custos de
* Produto"). Form OPERACIONAL: nao existe cadastro de entidade - o BO
* encapsula o processamento em lote da fila SigOpClC (origem legado:
* Fortyus.Exe processando o Click do botao OK/Processar do SIGPRRCU.scx).
*
* FASE 1/8 - Propriedades e Init().
* FASE 2/8 - CarregarDoCursor/Inserir/Atualizar/ObterChavePrimaria (CRUD
* generico da fila SigOpClC, com RegistrarAuditoria herdado de
* BusinessBase).
* FASE 4/8 - ProcessarLoteFila(): varredura da fila + UPDATE/fRecalculaC x2/
* DELETE/COMMIT por registro, chamada pelo BtnOkClick do Form a cada
* rodada do polling (equivalente ao Scan do OK.Click legado). Este form nao
* tem Page1/Page2 nem grade de lista (dump confirma: form FLAT com so
* cabecalho + Shape + 2 CommandButton + 1 Label) - a Fase 4 generica de
* "Grid e botoes CRUD" nao se aplica aqui.
*==============================================================================

DEFINE CLASS sigprrcuBO AS BusinessBase

    *-- Fila de processamento (legado: Select 0 as Flag,* From SigOpClC
    *-- Order by EmpCpros, no OK.Click do SIGPRRCU.scx)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Estado do processamento em lote (espelha variaveis do legado)
    this_lErroConexao    = .F.   && llErrCnx - SqlExecute da fila falhou
    this_nTotalPendentes = 0     && RECCOUNT da fila lida na ultima consulta
    this_cMensagemStatus = ""    && texto exibido em Label1.Caption durante o loop

    *-- Registro corrente da fila SigOpClC (espelha as colunas lidas por
    *-- CarregarDoCursor e gravadas por Inserir/Atualizar). cidchaves eh a
    *-- PK (char(20), gerada por fUniqueIds() - regra #22); empcpros eh
    *-- emps + cpros, exatamente como SigOpClC.EmpCpros do legado.
    this_cCidChaves   = ""   && SigOpClC.cidchaves char(20), PK
    this_cCpros       = ""   && SigOpClC.cpros char(14)
    this_dDatas       = {}   && SigOpClC.datas datetime NULL
    this_cEmpCpros    = ""   && SigOpClC.empcpros char(17)
    this_cEmps        = ""   && SigOpClC.emps char(3)
    this_cUsuars      = ""   && SigOpClC.usuars char(10)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "CidChaves"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades a partir de uma linha do
    * cursor da fila (equivalente a CrSigOpClC do legado: Select 0 as
    * Flag,* From SigOpClC Order by EmpCpros). O campo Flag e computado pelo
    * SELECT e nao tem property correspondente - nao e persistido.
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCpros     = TratarNulo(cpros,     "")
                THIS.this_dDatas     = TratarNulo(datas,     {})
                THIS.this_cEmpCpros  = TratarNulo(empcpros,  "")
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cUsuars    = TratarNulo(usuars,    "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigprrcuBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Grava um registro na fila de recalculo de custo (SigOpClC).
    * cidchaves eh a PK (regra #22: fUniqueIds(), nunca vazio, para nao
    * colidir no indice unico quando houver mais de um registro na fila).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpClC (cidchaves, cpros, datas, empcpros, emps, usuars)
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro na fila de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigprrcuBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza um registro existente da fila (SigOpClC),
    * localizado pela chave primaria this_cCidChaves.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpClC
                SET cpros    = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    empcpros = <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    emps     = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    usuars   = <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro da fila de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprrcuBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarLoteFila - Varre a fila de recalculo (SigOpClC) uma unica vez:
    * para cada item da fila, "toca" o registro (Update Usuars = Usuars,
    * equivalente ao legado) e chama fRecalculaC duas vezes - rotina de
    * recalculo de custo do Fortyus.Exe, EXTERNA ao acervo migrado. Regra
    * #27 do projeto: funcao que devolve VALOR DE CALCULO nao leva stub -
    * a ausencia tem de ficar VISIVEL (estoura "File frecalculac.prg does
    * not exist" em runtime), nunca um retorno inventado que gravaria custo
    * errado em silencio. Tendo sucesso nas duas chamadas, exclui o item da
    * fila. Cada registro e unidade propria de commit/rollback, igual ao
    * fSqlConector.Commit()/.Rollback() do legado (Click do botao OK) -
    * registro que falha so sofre Rollback e permanece na fila (proxima
    * rodada tenta de novo), nao interrompe o lote inteiro.
    *
    * Retorna .F. somente quando a CONSULTA da fila falhar (llErrCnx do
    * legado) - essa e a unica condicao que interrompe o polling no Form.
    *==========================================================================
    PROCEDURE ProcessarLoteFila()
        LOCAL loc_lConsultaOk, loc_cSQL, loc_nResultado, loc_cCidChave, ;
              loc_cUpdate, loc_cDelete, loc_lManual, loc_lContinua
        loc_lConsultaOk = .F.
        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cSQL = "Select 0 as Flag,* From SigOpClC Order by EmpCpros"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FilaRecalculo")
            loc_lConsultaOk = (loc_nResultado > 0)

            IF loc_lConsultaOk
                SELECT cursor_4c_FilaRecalculo
                SCAN
                    loc_lContinua = .T.
                    loc_cCidChave = cursor_4c_FilaRecalculo.cidchaves

                    loc_cUpdate = "Update SigOpClC Set Usuars = Usuars Where CidChaves = " + ;
                                  EscaparSQL(loc_cCidChave)
                    IF SQLEXEC(gnConnHandle, loc_cUpdate) <= 0
                        IF loc_lManual
                            = SQLROLLBACK(gnConnHandle)
                        ENDIF
                        loc_lContinua = .F.
                    ENDIF

                    IF loc_lContinua
                        IF USED("TmpCustPro")
                            USE IN TmpCustPro
                        ENDIF

                        IF !fRecalculaC(IIF(EMPTY(cursor_4c_FilaRecalculo.emps), go_4c_Sistema.cCodEmpresa, cursor_4c_FilaRecalculo.emps), ;
                                        cursor_4c_FilaRecalculo.cpros, cursor_4c_FilaRecalculo.datas)
                            IF loc_lManual
                                = SQLROLLBACK(gnConnHandle)
                            ENDIF
                            loc_lContinua = .F.
                        ENDIF
                    ENDIF

                    IF loc_lContinua
                        IF !fRecalculaC(.T., .T., .F., THIS, .T.)
                            IF loc_lManual
                                = SQLROLLBACK(gnConnHandle)
                            ENDIF
                            loc_lContinua = .F.
                        ENDIF
                    ENDIF

                    IF loc_lContinua
                        loc_cDelete = "Delete From SigOpClC Where CidChaves = " + EscaparSQL(loc_cCidChave)
                        IF SQLEXEC(gnConnHandle, loc_cDelete) <= 0
                            IF loc_lManual
                                = SQLROLLBACK(gnConnHandle)
                            ENDIF
                            loc_lContinua = .F.
                        ENDIF
                    ENDIF

                    IF loc_lContinua AND loc_lManual
                        = SQLCOMMIT(gnConnHandle)
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_FilaRecalculo")
                    USE IN cursor_4c_FilaRecalculo
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao processar fila de recalculo de custo:" + CHR(13) + ;
                        loException.Message, "sigprrcuBO.ProcessarLoteFila")
            loc_lConsultaOk = .F.
        ENDTRY

        RETURN loc_lConsultaOk
    ENDPROC

    *==========================================================================
    * DescartarTransacaoPendente - Equivalente ao "ThisForm.Podatamgr.Rollback()"
    * que o legado executa no FIM de CADA rodada do polling (OK.Click, linha
    * imediatamente apos o EndIf do Scan), FORA do If/Else - ou seja tanto
    * depois de uma varredura bem-sucedida quanto depois de a consulta da fila
    * falhar. A migracao tinha transcrito so os Rollback() de DENTRO do Scan
    * (um por registro) e PERDIDO este.
    *
    * Nao eh redundancia: a conexao nasce com Transactions = 2 (manual - ver
    * config.prg), entao o proprio SELECT da fila ABRE transacao. Sem este
    * descarte, uma rodada que termine com transacao aberta mantem os LOCKS
    * presos no SQL Server pelo resto da vida do polling (que em modo
    * parametrizado eh indefinido, rodada a cada 0,5s) - e o sintoma aparece
    * LONGE da causa: outra estacao travando em SigOpClC/SigCdPro, sem erro
    * nenhum nesta tela.
    *
    * PUBLIC de proposito: eh o Form que marca o fim da rodada (regra #51 -
    * metodo chamado de fora NUNCA leva PROTECTED em nenhum nivel da heranca).
    * Em modo autocommit (Transactions = 1) nao ha transacao para desfazer e o
    * metodo nao faz nada - mesma guarda de ProcessarLoteFila.
    *==========================================================================
    PROCEDURE DescartarTransacaoPendente()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(gnConnHandle) = "N" AND gnConnHandle > 0
                IF SQLGETPROP(gnConnHandle, "Transactions") = 2
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao descartar transacao pendente da fila de recalculo:" + CHR(13) + ;
                        loException.Message, "sigprrcuBO.DescartarTransacaoPendente")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave real do registro gravado por Inserir/
    * Atualizar (SigOpClC.cidchaves), usada por RegistrarAuditoria(). PROTECTED
    * porque so a propria BusinessBase a chama (regra #51 - nunca de fora).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

ENDDEFINE


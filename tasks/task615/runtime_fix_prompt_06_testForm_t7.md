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
[2026-09-29 08:51:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-29 08:51:25] [INFO] Config FPW: (nao fornecido)
[2026-09-29 08:51:26] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-29 08:51:26] [INFO] Timeout: 300 segundos
[2026-09-29 08:51:26] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ihwjj4k.prg
[2026-09-29 08:51:26] [INFO] Conteudo do wrapper:
[2026-09-29 08:51:26] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrGlo', 'C:\4c\tasks\task615\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGlo', 'C:\4c\tasks\task615\logs\06_testForm.log'
QUIT

[2026-09-29 08:51:27] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ihwjj4k.prg
[2026-09-29 08:51:27] [INFO] VFP output esperado em: C:\4c\tasks\task615\vfp_output.txt
[2026-09-29 08:51:27] [INFO] Executando Visual FoxPro 9...
[2026-09-29 08:51:27] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ihwjj4k.prg
[2026-09-29 08:51:27] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ihwjj4k.prg
[2026-09-29 08:51:27] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrGlo
Inicio: 29/09/2026 08:51:28

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 29/09/2026 08:55:44
Duracao: 256 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-29 08:55:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-29 08:55:45] [INFO] VFP9 finalizado em 258.0153422 segundos
[2026-09-29 08:55:46] [INFO] Exit Code: 
[2026-09-29 08:55:46] [INFO] 
[2026-09-29 08:55:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-29 08:55:47] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ihwjj4k.prg
[2026-09-29 08:55:47] [INFO] 
[2026-09-29 08:55:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-29 08:55:49] [INFO] * Auto-generated wrapper for parameters
[2026-09-29 08:55:49] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-29 08:55:49] [INFO] * Parameters: 'FormSigPrGlo', 'C:\4c\tasks\task615\logs\06_testForm.log'
[2026-09-29 08:55:50] [INFO] 
[2026-09-29 08:55:51] [INFO] * Anti-dialog protections for unattended execution
[2026-09-29 08:55:51] [INFO] SET SAFETY OFF
[2026-09-29 08:55:52] [INFO] SET RESOURCE OFF
[2026-09-29 08:55:53] [INFO] SET TALK OFF
[2026-09-29 08:55:53] [INFO] SET NOTIFY OFF
[2026-09-29 08:55:53] [INFO] SYS(2335, 0)
[2026-09-29 08:55:54] [INFO] 
[2026-09-29 08:55:54] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGlo', 'C:\4c\tasks\task615\logs\06_testForm.log'
[2026-09-29 08:55:55] [INFO] QUIT
[2026-09-29 08:55:56] [INFO] 
[2026-09-29 08:55:57] [INFO] === Fim do Wrapper.prg ===
[2026-09-29 08:55:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg):
*==============================================================================
* FormSigPrGlo.prg - Processamento de O.P.
* Tipo: OPERACIONAL (layout flat, sem PageFrame de conteudo - tela de parametros)
* Herda de: FormBase
* Legado: SIGPRGLO.SCX
*
* Tela de parametros que dispara o processamento em lote de Ordens de
* Producao a partir das movimentacoes em aberto (SigMvCab/SigMvItn),
* filtradas por periodo de emissao/entrega, operacao, conta (compradora) e
* conta responsavel (vendedor). Reusada pelo legado em tres modos, todos
* controlados pelas flags abaixo (espelhadas em SigPrGloBO):
*   - Processamento normal de O.P. (this_lReserva=.F., this_lGerPorTp=.F.)
*   - Reserva Automatica (this_lReserva=.T.)
*   - Processamento por Tipo de O.P. (this_lGerPorTp=.T., habilita cnt_4c_Container1)
*
* CHAMADA:
*   CREATEOBJECT("FormSigPrGlo", par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
*
* FASE 3/8 - Estrutura Base: DEFINE CLASS, Init/Destroy/InicializarForm,
* cabecalho e containers de agrupamento de campos VAZIOS.
* FASE 4/8 - Botoes de acao (Processar/Cancelar) e AlternarPagina() (funil de
* bloqueio/desbloqueio da UI durante o processamento - este form OPERACIONAL
* eh flat, sem PageFrame de conteudo, entao "pagina" aqui significa o MODO da
* tela: "ENTRADA" (usuario preenche os filtros) ou "PROCESSANDO" (BO executa
* o processamento em lote e a UI fica bloqueada)).
* FASE 5/8 - Campos Principais (Parte 1/2): primeira metade dos campos sem
* lookup - periodo de emissao (GetDataei/GetDataef), prazo de entrega
* (GetDatapi/GetDatapf), Movimentacao (cnt_4c_Operacao: Get_Operacao/
* Get_Operacaoi/Get_Operacaof) e Tipo de O.P. (cnt_4c_Container1:
* Get_TpGOp).
* FASE 6/8 - Campos Restantes e Lookups (Parte 2/2): cnt_4c_Conta/
* cnt_4c_Responsavel (Grupo/Conta/Descricao, SigCdGcr+SigCdCli filtrado por
* grupos), cnt_4c_Empresa (SigCdEmp.Cemps/Razas + Chec_pedra), cnt_4c_Previsao
* (data previsao/geracao, default vindo do BO) e cnt_4c_Op (numero manual da
* OP + checagem de duplicidade em SigOpPic). fAcessoContab/fAcessoContas/
* fAcessoEmpresa (funcoes globais Fortyus NAO portadas) substituidas pelo
* lookup canonico FormBase.AbrirLookupCanonico(). TODOS os BINDEVENT de
* KeyPress (Enter/Tab/F4) registrados em ConfigurarBindEvents(), chamado no
* fim de InicializarForm. AjustarVisibilidadeCondicional() reaplica, depois
* de TornarControlesVisiveis(), a ocultacao condicional do Init legado
* (Cnt_Previsao quando Reserva, Chec_pedra conforme parametros de
* transferencia, Cnt_Op conforme GlobAutos).
* FASE 7/8 - Eventos Principais: este form OPERACIONAL nao tem verbos CRUD
* (Incluir/Alterar/Visualizar/Excluir) - os "eventos principais" do legado
* sao BtnProcessarClick/BtnCancelarClick, ligados via BINDEVENT em
* ConfigurarBindEvents. BtnCancelarClick e so THIS.Release(). BtnProcessarClick
* transcreve as validacoes do Click legado e delega a varredura de
* SigMvCab/SigMvItn/SigMvIts para SigPrGloBO.Processar() (monta TmpCabec/
* TmpItens/TmpOper na DataSession corrente); com pelo menos 1 item
* selecionado, abre FormSigPrGl2 (CREATEOBJECT + VARTYPE + Show FORA do TRY -
* regra #29) reproduzindo "Do Form SigPrGl2 With ThisForm, DataSessionId,
* Reserva, poDataMgr, (Chec_pedra.Value=0), automatico, GetNop.Value" do
* legado (poDataMgr sai, pCnx nao existe mais - gnConnHandle global).
* FASE 8/8 - Consolidacao Final: FormParaBO()/BOParaForm() cobrindo TODOS os
* 18 campos de filtro da tela contra as properties this_* de SigPrGloBO
* (FormParaBO chamado em BtnProcessarClick logo antes de Processar();
* BOParaForm no fim de ConfigurarCamposPrevisaoOp, primeiro ponto em que
* todos os controles ja existem, aplicando os defaults calculados no Init do
* BO). Os handlers dos dois botoes do legado foram renomeados de Cmd*Click
* para Btn*Click - prefixo canonico do projeto, que eh o que torna handler de
* botao ENUMERAVEL pelos gates das Fases 7/8 (o objeto segue cmd_4c_Processar/
* cmd_4c_Cancelar, entao mapeamento.json nao muda).
*
* SUPERFICIE QUE ESTE LEGADO NAO TEM (ausencias deliberadas, nao omissoes):
*   - carga de grade de LISTA: o SCX nao tem Grid, PageFrame nem ListBox, e as
*     12 chamadas .AddCursor do Init legado passam string VAZIA na posicao do
*     grid (5o argumento) - sao registro de cursor para o processamento em
*     lote, nao ligacao de grade;
*   - verbos CRUD (Incluir/Alterar/Visualizar/Excluir) e botao de GRAVAR: a
*     tela filtra, monta TmpCabec/TmpItens em cursor LOCAL e entrega o
*     resultado ao FormSigPrGl2 ("Do Form SigPrGl2 With ..." do legado);
*     nenhuma escrita do dump tem tabela como alvo.
*==============================================================================

DEFINE CLASS FormSigPrGlo AS FormBase

    Top          = 0
    Left         = 0
    Width        = 680
    Height       = 379
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    ClipControls = .F.
    Caption      = "Processamento de O.P."
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Flags de modo de operacao (recebidas via Init, repassadas ao BO em
    *-- InicializarForm - equivalem a ThisForm.Reserva/automatico/Pordestino/
    *-- GerPorTp do legado)
    this_lReserva     = .F.   && .T. = "Processar Reserva Automatica"
    this_lAutomatico  = .F.   && .T. = processamento automatico (sem interacao)
    this_lPorDestino  = .F.   && .T. = globalizacao por destino
    this_lGerPorTp    = .F.   && .T. = "Processar Ordem de Producao por Tipo" (habilita cnt_4c_Container1)

    *--------------------------------------------------------------------------
    * Init - recebe as flags de modo (equivalente a LParameters _Reserva,
    * _Autom, _PorDestino, lcNomeFrm1, pTipo do legado - lcNomeFrm1 nao e
    * usado no migrado, o Caption e resolvido por modo em InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
        THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
        THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
        THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - os cursores de trabalho de Processar() (TmpOper/TmpCabec/
    * TmpItens/Produtos/cursor_4c_Temp*) ficam ABERTOS de proposito enquanto a
    * tela vive: sao o contrato do FormSigPrGl2, que roda MODAL por cima desta
    * (equivalente ao "Do Form SigPrGl2 With ThisForm.Datasessionid" do
    * legado). Todos vivem na datasession PRIVADA deste form (DataSession = 2),
    * que o VFP encerra junto com ele - nao ha o que fechar a mao aqui, so
    * delegar ao FormBase (libera this_oBusinessObject e restaura o menu
    * principal; DODEFAULT() eh obrigatorio como ULTIMA linha do Destroy).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, repassa as flags de modo e
    * monta a estrutura visual (cabecalho + containers de agrupamento vazios +
    * botoes de acao Processar/Cancelar). Os campos internos dos containers e
    * os eventos (BINDEVENT) sao adicionados nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGloBO.", "Erro")
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_lPorDestino = THIS.this_lPorDestino
                    .this_lGerPorTp   = THIS.this_lGerPorTp
                ENDWITH

                *-- Caption dinamico conforme modo de operacao (equivalente ao
                *-- If ThisForm.Reserva ... Else ... EndIf do Init legado)
                loc_cCaption = "Processamento de O.P."
                IF THIS.this_lReserva
                    loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica"
                ELSE
                    IF THIS.this_lGerPorTp
                        loc_cCaption = "Processar Ordem de Produ" + CHR(231) + CHR(227) + "o por Tipo"
                    ENDIF
                ENDIF
                THIS.Caption = loc_cCaption

                THIS.ConfigurarPageFrame()

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarShape()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarBindEvents()

                THIS.TornarControlesVisiveis()

                *-- Visibilidade condicional (Chec_pedra/Cnt_Op/Cnt_Previsao)
                *-- roda DEPOIS de TornarControlesVisiveis, que forca .Visible
                *-- = .T. em tudo - sem isso a ocultacao condicional do legado
                *-- seria sobrescrita.
                THIS.AjustarVisibilidadeCondicional()

                *-- Estado inicial: aguardando entrada do usuario (equivalente
                *-- ao form legado antes do Click em Processar)
                THIS.AlternarPagina("ENTRADA")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - imagem de fundo do form (OPERACIONAL flat, sem
    * PageFrame de conteudo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
        THIS.ScrollBars = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa cinza escuro com titulo (cntSombra legado)
    * Top=0, Left=0, Width=680, Height=80 - BackColor=RGB(100,100,100)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255, 255, 255)
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape - retangulo decorativo por tras dos botoes de acao
    * (Shape3 legado: Top=7, Left=486, Height=110, Width=173)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 7
            .Left        = 486
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - botoes de acao principais (Processar/Cancelar do
    * legado). Ficam sobre o shp_4c_Shape3 (Top=7, Left=486, W=173, H=110),
    * standalone (fora de CommandGroup), posicoes EXATAS do SIGPRGLO.SCX:
    *   Processar: Top=3, Left=528, 75x75, Caption="Processar"
    *   Cancelar : Top=3, Left=603, 75x75, Caption="Encerrar" (Cancel=.T. -
    *              ativa ESC, unica forma de fechar o form: ControlBox=.F.,
    *              Closable=.F., TitleBar=0)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 528
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 603
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - monta os containers de agrupamento de campos
    * (ainda VAZIOS - os campos internos e os eventos sao adicionados nas
    * proximas fases). Nome mantido por convencao do FormBase; este form
    * OPERACIONAL nao tem Page1=Lista/Page2=Dados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarContainers()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - nome mantido por convencao do FormBase (form
    * OPERACIONAL flat, sem Page2/Dados real). Monta a primeira metade dos
    * campos do SIGPRGLO.SCX (Fase 5/8) - os que nao dependem de lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCamposPeriodo()
        THIS.ConfigurarCamposOperacao()
        THIS.ConfigurarCamposTipoOp()
        THIS.ConfigurarCamposContas()
        THIS.ConfigurarCamposPrevisaoOp()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPeriodo - campos diretos do form (nao ficam dentro de
    * container no legado): faixa de Periodo de Emissao (GetDataei/GetDataef)
    * e faixa de Previsao de Entrega/Prazo (GetDatapi/GetDatapf), alem do
    * label "Movimentacao :" (TxtPedido) que fica acima do cnt_4c_Operacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPeriodo()
        *-- Label1: "Periodo de Emissao :" (Top=115, Left=32, Width=101)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
            .Left      = 32
            .Top       = 115
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDataei: inicio do periodo de emissao (Top=111, Left=142, W=80)
        THIS.AddObject("txt_4c_Dataei", "TextBox")
        WITH THIS.txt_4c_Dataei
            .Top           = 111
            .Left          = 142
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Label2: "ate" (Top=115, Left=227, Width=18)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 227
            .Top       = 115
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDataef: fim do periodo de emissao (Top=111, Left=255, W=80)
        THIS.AddObject("txt_4c_Dataef", "TextBox")
        WITH THIS.txt_4c_Dataef
            .Top           = 111
            .Left          = 255
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Label3: "Previsao de Entrega :" (Top=142, Left=27, Width=106)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Previs" + CHR(227) + "o de Entrega :"
            .Left      = 27
            .Top       = 142
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDatapi: inicio da faixa de prazo de entrega (Top=138, Left=142, W=80)
        THIS.AddObject("txt_4c_Datapi", "TextBox")
        WITH THIS.txt_4c_Datapi
            .Top           = 138
            .Left          = 142
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Label4: "ate" (Top=142, Left=227, Width=18)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 227
            .Top       = 142
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDatapf: fim da faixa de prazo de entrega (Top=138, Left=254, W=80)
        THIS.AddObject("txt_4c_Datapf", "TextBox")
        WITH THIS.txt_4c_Datapf
            .Top           = 138
            .Left          = 254
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- TxtPedido: "Movimentacao :" (Top=196, Left=55, Width=78) - label
        *-- do cnt_4c_Operacao (container ja criado em ConfigurarContainers)
        THIS.AddObject("lbl_4c_TxtPedido", "Label")
        WITH THIS.lbl_4c_TxtPedido
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 55
            .Top       = 196
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposOperacao - preenche o cnt_4c_Operacao (ja criado vazio
    * em ConfigurarContainers): codigo da Operacao (Movimentacao) + faixa
    * de numero (de/ate). ControlSource fica em branco, igual ao legado -
    * o valor eh resolvido por codigo (Valid/lookup), adicionado na Fase 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposOperacao()
        WITH THIS.cnt_4c_Operacao
            *-- Get_Operacao: codigo da operacao/movimentacao (Dopes char(20))
            .AddObject("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .Top           = 1
                .Left          = 3
                .Width         = 151
                .Height        = 23
                .FontName      = "Courier New"
                .MaxLength     = 20
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label1: "de" (Top=5, Left=180, Width=14)
            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "de"
                .Left      = 180
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Operacaoi: numero inicial da faixa (Numes, numerico)
            .AddObject("txt_4c_Operacaoi", "TextBox")
            WITH .txt_4c_Operacaoi
                .Top           = 1
                .Left          = 201
                .Width         = 55
                .Height        = 23
                .FontName      = "Courier New"
                .Alignment     = 3
                .Format        = "K"
                .InputMask     = "999999"
                .MaxLength     = 6
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Label9: "ate" (Top=4, Left=262, Width=18)
            .AddObject("lbl_4c_Label9", "Label")
            WITH .lbl_4c_Label9
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "at" + CHR(233)
                .Left      = 262
                .Top       = 4
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Operacaof: numero final da faixa (Numes, numerico)
            .AddObject("txt_4c_Operacaof", "TextBox")
            WITH .txt_4c_Operacaof
                .Top           = 1
                .Left          = 286
                .Width         = 55
                .Height        = 23
                .FontName      = "Courier New"
                .Alignment     = 3
                .Format        = "K"
                .InputMask     = "999999"
                .MaxLength     = 6
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposTipoOp - Label5 ("Tipo de O.P.:", direto no form) +
    * Get_TpGOp (dentro do cnt_4c_Container1, ja criado com .Enabled
    * condicionado a this_lGerPorTp em ConfigurarContainers).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposTipoOp()
        *-- Label5: "Tipo de O.P.:" (Top=169, Left=67, Width=66)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Tipo de O.P.:"
            .Left      = 67
            .Top       = 169
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_TpGOp: codigo do Tipo de Geracao de OP (char(10), Courier New)
        WITH THIS.cnt_4c_Container1
            .AddObject("txt_4c_TpGOp", "TextBox")
            WITH .txt_4c_TpGOp
                .Top           = 1
                .Left          = 3
                .Width         = 80
                .Height        = 23
                .FontName      = "Courier New"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposContas - preenche os containers cnt_4c_Conta,
    * cnt_4c_Responsavel e cnt_4c_Empresa (ja criados vazios em
    * ConfigurarContainers), alem dos labels diretos do form Label6
    * ("Conta :"), Label7 ("Vendedor :") e lbl_empresa ("Empresa :").
    * ControlSource fica em branco, igual ao legado - o valor eh resolvido
    * por lookup (BINDEVENT em ConfigurarBindEvents).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposContas()
        LOCAL loc_cEmpPadrao, loc_nResultado

        *-- Label6: "Conta :" (Top=223, Left=95, Width=38)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Conta :"
            .Left      = 95
            .Top       = 223
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label7: "Vendedor :" (Top=250, Left=78, Width=55)
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Vendedor :"
            .Left      = 78
            .Top       = 250
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_empresa: "Empresa :" (Top=277, Left=83, Width=50)
        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Empresa :"
            .Left      = 83
            .Top       = 277
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- cnt_4c_Conta: Grupo/Conta/Descricao - filtro de movimentacao
        *-- (compradora) - SigMvCab.GrupoOs/ContaOs quando Globalizas=1
        WITH THIS.cnt_4c_Conta
            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Top           = 1
                .Left          = 3
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top           = 1
                .Left          = 86
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .Top           = 1
                .Left          = 170
                .Width         = 360
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- cnt_4c_Responsavel: Grupo/Conta/Descricao do vendedor -
        *-- SigMvCab.GrVends/Vends
        WITH THIS.cnt_4c_Responsavel
            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Top           = 1
                .Left          = 3
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top           = 1
                .Left          = 86
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .Top           = 1
                .Left          = 170
                .Width         = 360
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- cnt_4c_Empresa: codigo/razao social + Chec_pedra ("Nao Empenhar
        *-- Pedras") - SigCdEmp.Cemps/Razas. AlterEmp do legado eh sempre
        *-- .T. no Init (ThisForm.AlterEmp = .t.), entao o campo fica sempre
        *-- editavel, sem gating adicional.
        WITH THIS.cnt_4c_Empresa
            .AddObject("txt_4c_CdEmpresa", "TextBox")
            WITH .txt_4c_CdEmpresa
                .Top           = 1
                .Left          = 4
                .Width         = 31
                .Height        = 23
                .FontName      = "Courier New"
                .FontSize      = 9
                .Alignment     = 0
                .BackStyle     = 1
                .Format        = "K"
                .InputMask     = "XXX"
                .MaxLength     = 3
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_DsEmpresa", "TextBox")
            WITH .txt_4c_DsEmpresa
                .Top           = 1
                .Left          = 38
                .Width         = 282
                .Height        = 23
                .FontName      = "Courier New"
                .Format        = "K"
                .MaxLength     = 40
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("chk_4c_ChecPedra", "CheckBox")
            WITH .chk_4c_ChecPedra
                .Top       = 5
                .Left      = 330
                .Width     = 124
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Empenhar Pedras"
                .ForeColor = RGB(90, 90, 90)
                .Value     = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Empresa padrao = go_4c_Sistema.cCodEmpresa (equivalente a
        *-- .Empresa.Get_cd_empresa.Value = _Empr do Init legado), com a
        *-- razao social resolvida direto de SigCdEmp (mesmo CursorQuery
        *-- ('SigCdEmp','TempEmp','Cemps',_Empr,'Razas') do legado)
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_cEmpPadrao = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            IF !EMPTY(loc_cEmpPadrao)
                THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = loc_cEmpPadrao
                IF USED("cursor_4c_ChkEmpPad")
                    USE IN cursor_4c_ChkEmpPad
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpPadrao), ;
                    "cursor_4c_ChkEmpPad")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpPad") AND RECCOUNT("cursor_4c_ChkEmpPad") > 0
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpPad.Razas)
                ENDIF
                IF USED("cursor_4c_ChkEmpPad")
                    USE IN cursor_4c_ChkEmpPad
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPrevisaoOp - preenche os containers cnt_4c_Previsao
    * (data de previsao de entrega + data de geracao) e cnt_4c_Op (numero
    * manual da O.P.), ja criados vazios em ConfigurarContainers. Os valores
    * default de Previsao/Geracao vem do BO (ja calculados no Init:
    * this_dPrevisaoEntrega = Date()+SigCdPam.PrevProds, this_dDataGeracao =
    * Date() quando !this_lAutomatico).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPrevisaoOp()
        WITH THIS.cnt_4c_Previsao
            *-- Label8: "Previsao de Entrega :" (Top=9, Left=7, Width=106)
            .AddObject("lbl_4c_Label8", "Label")
            WITH .lbl_4c_Label8
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontItalic = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Previs" + CHR(227) + "o de Entrega :"
                .Left      = 7
                .Top       = 9
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetPrevisao: data de previsao de entrega (Top=5, Left=134, W=80)
            .AddObject("txt_4c_Previsao", "TextBox")
            WITH .txt_4c_Previsao
                .Top           = 5
                .Left          = 134
                .Width         = 80
                .Height        = 23
                .Alignment     = 3
                .Format        = "K"
                .SpecialEffect = 1
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- Label9: "Data de Geracao :" (Top=9, Left=244, Width=90)
            .AddObject("lbl_4c_Label9", "Label")
            WITH .lbl_4c_Label9
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontItalic = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
                .Left      = 244
                .Top       = 9
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetGeracao: data de geracao (Top=5, Left=353, W=80)
            .AddObject("txt_4c_Geracao", "TextBox")
            WITH .txt_4c_Geracao
                .Top           = 5
                .Left          = 353
                .Width         = 80
                .Height        = 23
                .Alignment     = 3
                .Format        = "K"
                .SpecialEffect = 1
                .Value         = {}
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- cnt_4c_Op: numero manual da O.P. (visibilidade condicional -
        *-- GlobAutos=2 e !Reserva - aplicada em AjustarVisibilidadeCondicional)
        WITH THIS.cnt_4c_Op
            *-- Label8: "N. da O.P.:" (Top=5, Left=0, Width=58)
            .AddObject("lbl_4c_Label8", "Label")
            WITH .lbl_4c_Label8
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontItalic = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(176) + " da O.P.:"
                .Left      = 0
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetNop: numero manual da OP (Top=1, Left=71, W=59)
            .AddObject("txt_4c_Nop", "TextBox")
            WITH .txt_4c_Nop
                .Top           = 1
                .Left          = 71
                .Width         = 59
                .Height        = 23
                .Alignment     = 3
                .InputMask     = "999999"
                .MaxLength     = 6
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- Valores default vindos do BO (ja calculados no Init) - via
        *-- BOParaForm, que tambem cobre os demais campos de filtro. Chamado
        *-- so agora porque eh o primeiro ponto em que TODOS os controles de
        *-- filtro (inclusive cnt_4c_Op.txt_4c_Nop, criado acima) ja existem.
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainers - cria VAZIOS os containers de agrupamento de
    * campos, nas posicoes do SIGPRGLO.SCX legado (tasks\task615\layout.json).
    * cnt_4c_Container1 fica desabilitado fora do modo "Gerar por Tipo".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainers()
        *-- Container1: Tipo de O.P. (Get_TpGOp) - habilitado so quando this_lGerPorTp
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top         = 164
            .Left        = 139
            .Width       = 346
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Enabled     = THIS.this_lGerPorTp
            .Visible     = .T.
        ENDWITH

        *-- Operacao: codigo + faixa de/ate (Get_Operacao/Get_Operacaoi/Get_Operacaof)
        THIS.AddObject("cnt_4c_Operacao", "Container")
        WITH THIS.cnt_4c_Operacao
            .Top         = 191
            .Left        = 139
            .Width       = 350
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Conta: grupo/conta/descricao - filtro de movimentacao (compradora)
        THIS.AddObject("cnt_4c_Conta", "Container")
        WITH THIS.cnt_4c_Conta
            .Top         = 218
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Responsavel: grupo/conta/descricao do vendedor
        THIS.AddObject("cnt_4c_Responsavel", "Container")
        WITH THIS.cnt_4c_Responsavel
            .Top         = 245
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Empresa: cd_empresa + ds_empresa + Chec_pedra (Nao Empenhar Pedras)
        THIS.AddObject("cnt_4c_Empresa", "Container")
        WITH THIS.cnt_4c_Empresa
            .Top         = 272
            .Left        = 138
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Previsao: data de previsao de entrega + data de geracao
        THIS.AddObject("cnt_4c_Previsao", "Container")
        WITH THIS.cnt_4c_Previsao
            .Top         = 309
            .Left        = 7
            .Width       = 660
            .Height      = 33
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Op: numero da O.P. manual - visibilidade condicional (GlobAutos=2
        *-- e !Reserva) sera aplicada na Fase 5/6, junto com o campo txt_4c_Nop
        THIS.AddObject("cnt_4c_Op", "Container")
        WITH THIS.cnt_4c_Op
            .Top         = 313
            .Left        = 478
            .Width       = 130
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarVisibilidadeCondicional - reaplica, DEPOIS de
    * TornarControlesVisiveis (que forca .Visible = .T. em tudo), a
    * ocultacao condicional do Init legado:
    *   - Cnt_Previsao.Visible = .F. quando this_lReserva
    *   - Chec_pedra.Visible = .T. so quando os 4 parametros de transferencia
    *     de reserva estao configurados (DopEmphs/DopReqcs/DopPedcs/TransfRes)
    *   - Cnt_Op.Visible = (GlobAutos = 2 And !this_lReserva)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarVisibilidadeCondicional()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        THIS.cnt_4c_Previsao.Visible = !THIS.this_lReserva

        THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Visible = ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamDopEmphs))  AND ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamDopReqcs))  AND ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamDopPedcs))  AND ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamTransfRes))

        THIS.cnt_4c_Op.Visible = (loc_oBO.this_nPamGlobAutos = 2 AND !THIS.this_lReserva)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBindEvents - registra os handlers de KeyPress (Enter/Tab/F4)
    * de TODOS os campos com lookup do form. Chamado em InicializarForm,
    * depois que todos os controles ja existem (ConfigurarPaginaDados +
    * ConfigurarBotoes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBindEvents()
        BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao, "KeyPress", THIS, "OperacaoKeyPress")
        BINDEVENT(THIS.cnt_4c_Container1.txt_4c_TpGOp,  "KeyPress", THIS, "TpGOpKeyPress")

        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,  "KeyPress", THIS, "ConGrupoKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,  "KeyPress", THIS, "ConContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta, "KeyPress", THIS, "ConDcontaKeyPress")

        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Grupo,  "KeyPress", THIS, "RespGrupoKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Conta,  "KeyPress", THIS, "RespContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Dconta, "KeyPress", THIS, "RespDcontaKeyPress")

        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa, "KeyPress", THIS, "EmpresaCodKeyPress")
        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa, "KeyPress", THIS, "EmpresaDescKeyPress")

        BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop, "KeyPress", THIS, "NopKeyPress")

        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - copia os campos de filtro da tela para as properties
    * this_* de THIS.this_oBusinessObject (SigPrGloBO.prg, declaradas na
    * Fase 1). Este form OPERACIONAL nao grava registro nenhum diretamente
    * (Processar() recebe os valores por parametro posicional, ja que e
    * transcricao literal do Click legado - ver cabecalho de
    * BtnProcessarClick), mas as properties de filtro do BO existem
    * justamente para refletir o estado corrente da tela - chamado logo
    * antes de THIS.this_oBusinessObject.Processar(...) em BtnProcessarClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_dDataEmissaoIni = THIS.txt_4c_Dataei.Value
        loc_oBO.this_dDataEmissaoFim = THIS.txt_4c_Dataef.Value
        loc_oBO.this_dDataPrazoIni   = THIS.txt_4c_Datapi.Value
        loc_oBO.this_dDataPrazoFim   = THIS.txt_4c_Datapf.Value

        loc_oBO.this_cOperacao       = PADR(ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value), 20)
        loc_oBO.this_nOperacaoIni    = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
        loc_oBO.this_nOperacaoFim    = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value

        loc_oBO.this_cContaGrupo     = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cContaConta     = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value), 10)
        loc_oBO.this_cContaDescricao = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value), 40)

        loc_oBO.this_cRespGrupo      = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cRespConta      = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Conta.Value), 10)
        loc_oBO.this_cRespDescricao  = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Dconta.Value), 40)

        loc_oBO.this_cEmpresaCodigo    = PADR(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value), 3)
        loc_oBO.this_cEmpresaRazao     = PADR(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value), 40)
        loc_oBO.this_lNaoEmpenharPedra = (THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = 1)

        loc_oBO.this_dPrevisaoEntrega = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
        loc_oBO.this_dDataGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value

        loc_oBO.this_nNumeroOP      = THIS.cnt_4c_Op.txt_4c_Nop.Value
        loc_oBO.this_cTipoGeracaoOP = PADR(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value), 10)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - espelha as properties this_* de THIS.this_oBusinessObject
    * de volta para os campos da tela. Chamado ao final de
    * ConfigurarCamposPrevisaoOp (primeiro ponto em InicializarForm em que
    * TODOS os controles de filtro ja existem) para aplicar os defaults
    * calculados no Init do BO (this_dPrevisaoEntrega/this_dDataGeracao -
    * equivalente ao GetPrevisao.Value/GetGeracao.Value do Init legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_Dataei.Value = loc_oBO.this_dDataEmissaoIni
        THIS.txt_4c_Dataef.Value = loc_oBO.this_dDataEmissaoFim
        THIS.txt_4c_Datapi.Value = loc_oBO.this_dDataPrazoIni
        THIS.txt_4c_Datapf.Value = loc_oBO.this_dDataPrazoFim

        THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ALLTRIM(loc_oBO.this_cOperacao)
        THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = loc_oBO.this_nOperacaoIni
        THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = loc_oBO.this_nOperacaoFim

        THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cContaGrupo)
        THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cContaConta)
        THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(loc_oBO.this_cContaDescricao)

        THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cRespGrupo)
        THIS.cnt_4c_Responsavel.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cRespConta)
        THIS.cnt_4c_Responsavel.txt_4c_Dconta.Value = ALLTRIM(loc_oBO.this_cRespDescricao)

        *-- Empresa/Chec_pedra: so aplica quando o BO ja tem codigo resolvido
        *-- (ConfigurarCamposContas roda ANTES e ja fez o lookup default de
        *-- go_4c_Sistema.cCodEmpresa direto na tela, sem passar pelo BO) -
        *-- sem esse guard, BOParaForm apagaria o default com o SPACE(3)
        *-- inicial da property.
        IF !EMPTY(ALLTRIM(loc_oBO.this_cEmpresaCodigo))
            THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(loc_oBO.this_cEmpresaCodigo)
            THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(loc_oBO.this_cEmpresaRazao)
        ENDIF
        THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = IIF(loc_oBO.this_lNaoEmpenharPedra, 1, 0)

        THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = loc_oBO.this_dPrevisaoEntrega
        THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = loc_oBO.this_dDataGeracao

        THIS.cnt_4c_Op.txt_4c_Nop.Value = loc_oBO.this_nNumeroOP
        THIS.cnt_4c_Container1.txt_4c_TpGOp.Value = ALLTRIM(loc_oBO.this_cTipoGeracaoOP)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente ao SIGPRGLO.Cancelar.Click legado
    * (ThisForm.Release). PUBLIC porque e alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - equivalente ao SIGPRGLO.Processar.Click legado
    * (tasks\task615\SigPrGlo_form_codigo_fonte.txt linhas 1383-1703):
    * validacoes de UI identicas ao legado (early-exit com foco no campo que
    * falhou), depois delega a varredura de SigMvCab/SigMvItn/SigMvIts para
    * THIS.this_oBusinessObject.Processar() (SigPrGloBO.prg), que monta
    * TmpCabec/TmpItens na DataSession corrente. Com pelo menos um item
    * selecionado, abre FormSigPrGl2 exatamente como o legado fazia com
    * "Do Form SigPrGl2 With ThisForm, ThisForm.Datasessionid, ThisForm.
    * Reserva, ThisForm.poDataMgr, (ThisForm.Empresa.Chec_pedra.Value=0),
    * ThisForm.automatico, ThisForm.Cnt_Op.GetNop.Value" - mapeamento
    * posicional contra o LParameters real de SigPrGl2 (tasks\task614\
    * SigPrGl2_form_codigo_fonte.txt:1171 - _ParentForm,_Data,_ReservaAuto,
    * pCnx,_nGerEmphPdr,_Autom,_NumeroOp; pCnx sai, pois a conexao agora vem
    * de gnConnHandle - regra Global Variables).
    * PUBLIC porque e alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_oErro

        IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
            MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
            RETURN
        ENDIF
        IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
            MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.this_nPamGlobAutos = 2 AND THIS.cnt_4c_Op.txt_4c_Nop.Value = 0 AND !THIS.this_lReserva
            MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
            RETURN
        ENDIF
        IF THIS.this_lGerPorTp AND EMPTY(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value)
            MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + " Obrigat" + CHR(243) + "rio ser Preenchido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c_TpGOp.SetFocus
            RETURN
        ENDIF
        IF !EMPTY(THIS.txt_4c_Dataei.Value) AND !EMPTY(THIS.txt_4c_Dataef.Value) AND THIS.txt_4c_Dataef.Value < THIS.txt_4c_Dataei.Value
            MsgAviso("A Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Dataei.SetFocus
            RETURN
        ENDIF
        IF !EMPTY(THIS.txt_4c_Datapi.Value) AND !EMPTY(THIS.txt_4c_Datapf.Value) AND THIS.txt_4c_Datapf.Value < THIS.txt_4c_Datapi.Value
            MsgAviso("A Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Datapi.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        THIS.AlternarPagina("PROCESSANDO")

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.Processar( ;
                THIS.txt_4c_Dataei.Value, THIS.txt_4c_Dataef.Value, ;
                THIS.txt_4c_Datapi.Value, THIS.txt_4c_Datapf.Value, ;
                ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value), ;
                THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value, THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value, ;
                ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value), ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value), ;
                ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value), ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Conta.Value), ;
                IIF(EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)), ;
                    ALLTRIM(go_4c_Sistema.cCodEmpresa), ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)), ;
                ALLTRIM(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value))
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro ao Processar")
        ENDTRY

        THIS.AlternarPagina("ENTRADA")

        IF !loc_lSucesso
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            RETURN
        ENDIF

        IF !USED("TmpItens") OR !USED("TmpCabec") OR EOF("TmpItens") OR EOF("TmpCabec")
            MsgAviso("Nenhum Item Selecionado Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Dataei.SetFocus
            RETURN
        ENDIF

        *-- CREATEOBJECT/Show FORA de qualquer TRY (regra #29 - Show() de
        *-- form modal dentro de TRY fecha a tela a cada erro de runtime).
        *-- FormSigPrGl2 desabilita/reabilita THIS sozinho (Init/Destroy),
        *-- entao nao duplicamos THIS.Enabled = .F. aqui.
        LOCAL loc_oFormFilho
        loc_oFormFilho = CREATEOBJECT("FormSigPrGl2", THIS, THIS.DataSessionId, THIS.this_lReserva, ;
            (THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = 0), THIS.this_lAutomatico, ;
            THIS.cnt_4c_Op.txt_4c_Nop.Value, THIS.this_lPorDestino)
        IF VARTYPE(loc_oFormFilho) = "O"
            loc_oFormFilho.Show()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OperacaoKeyPress - lookup de Movimentacao (cnt_4c_Operacao.txt_4c_
    * Operacao, equivalente ao Get_Operacao.Valid legado). SigCdOpe so tem
    * Dopes como coluna de texto (nao ha Descrs) - filtro adicional por
    * Globalizas IN (1,2), igual ao TmpOper do Init legado. Enter/Tab vazio
    * zera a faixa de numero (Get_Operacaoi/Get_Operacaof), igual ao legado.
    *--------------------------------------------------------------------------
    PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Operacao
            loc_cValor = ALLTRIM(.txt_4c_Operacao.Value)

            IF EMPTY(loc_cValor)
                .txt_4c_Operacaoi.Value = 0
                .txt_4c_Operacaof.Value = 0
                IF par_nKeyCode != 115
                    RETURN
                ENDIF
            ENDIF

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkOper")
                    USE IN cursor_4c_ChkOper
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor) + ;
                    " AND Globalizas IN (1,2)", "cursor_4c_ChkOper")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkOper") AND RECCOUNT("cursor_4c_ChkOper") > 0
                    IF USED("cursor_4c_ChkOper")
                        USE IN cursor_4c_ChkOper
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkOper")
                    USE IN cursor_4c_ChkOper
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
                "Movimenta" + CHR(231) + CHR(227) + "o", loc_cValor, ;
                .txt_4c_Operacao, .NULL., "Globalizas IN (1,2)")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TpGOpKeyPress - lookup do Tipo de Geracao da OP (cnt_4c_Container1.
    * txt_4c_TpGOp, equivalente ao Get_TpGOp.Valid legado - fwBuscaSel sobre
    * CrTmpTpGop, aqui reproduzido como lookup direto em SigInTgo). O filtro
    * de acesso por usuario (fChecaAcesso) nao foi portado - ver regra de
    * funcoes de acesso Fortyus nao portadas.
    *--------------------------------------------------------------------------
    PROCEDURE TpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Container1
            loc_cValor = ALLTRIM(.txt_4c_TpGOp.Value)

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkTpGOp")
                    USE IN cursor_4c_ChkTpGOp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos FROM SigInTgo WHERE Codigos = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkTpGOp")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkTpGOp") AND RECCOUNT("cursor_4c_ChkTpGOp") > 0
                    IF USED("cursor_4c_ChkTpGOp")
                        USE IN cursor_4c_ChkTpGOp
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkTpGOp")
                    USE IN cursor_4c_ChkTpGOp
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigInTgo", "Codigos", "Descs", ;
                "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP", loc_cValor, ;
                .txt_4c_TpGOp, .NULL.)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConGrupoKeyPress / RespGrupoKeyPress - lookup do Grupo de Conta
    * (SigCdGcr), equivalente ao Get_grupo.Valid (fAcessoContab) das duas
    * containers Conta/Responsavel. Nao ha campo de descricao visivel para
    * o Grupo no form - so validacao/preenchimento do codigo.
    *--------------------------------------------------------------------------
    PROCEDURE ConGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarLookupGrupo(par_nKeyCode, THIS.cnt_4c_Conta.txt_4c_Grupo)
    ENDPROC

    PROCEDURE RespGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarLookupGrupo(par_nKeyCode, THIS.cnt_4c_Responsavel.txt_4c_Grupo)
    ENDPROC

    PROTECTED PROCEDURE ProcessarLookupGrupo(par_nKeyCode, par_oTxtGrupo)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(par_oTxtGrupo.Value)

        IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_ChkGrupo")
                USE IN cursor_4c_ChkGrupo
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
                "cursor_4c_ChkGrupo")
            IF loc_nResultado > 0 AND USED("cursor_4c_ChkGrupo") AND RECCOUNT("cursor_4c_ChkGrupo") > 0
                IF USED("cursor_4c_ChkGrupo")
                    USE IN cursor_4c_ChkGrupo
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkGrupo")
                USE IN cursor_4c_ChkGrupo
            ENDIF
        ENDIF

        THIS.AbrirLookupCanonico("SigCdGcr", "Codigos", "Descrs", ;
            "Grupo de Conta", loc_cValor, par_oTxtGrupo, .NULL.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConContaKeyPress / RespContaKeyPress - lookup da Conta por CODIGO
    * (SigCdCli.Iclis, filtrado por grupos = grupo digitado), equivalente ao
    * Get_conta.Valid (fAcessoContas modo 'C') das containers Conta/
    * Responsavel. Ao selecionar/casar, preenche a descricao (Rclis) no
    * txt_4c_Dconta irmao.
    *--------------------------------------------------------------------------
    PROCEDURE ConContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Conta
            THIS.ProcessarLookupConta(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROCEDURE RespContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Responsavel
            THIS.ProcessarLookupConta(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ProcessarLookupConta(par_nKeyCode, par_oTxtGrupo, par_oTxtConta, par_oTxtDconta)
        LOCAL loc_cValor, loc_cGrupo, loc_cFiltroExtra, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(par_oTxtConta.Value)
        loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
        loc_cFiltroExtra = ""
        IF !EMPTY(loc_cGrupo)
            loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF

        IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_ChkConta")
                USE IN cursor_4c_ChkConta
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor) + ;
                IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
                "cursor_4c_ChkConta")
            IF loc_nResultado > 0 AND USED("cursor_4c_ChkConta") AND RECCOUNT("cursor_4c_ChkConta") > 0
                par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkConta.Rclis)
                IF USED("cursor_4c_ChkConta")
                    USE IN cursor_4c_ChkConta
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkConta")
                USE IN cursor_4c_ChkConta
            ENDIF
        ENDIF

        THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
            "Conta", loc_cValor, par_oTxtConta, par_oTxtDconta, loc_cFiltroExtra)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConDcontaKeyPress / RespDcontaKeyPress - lookup da Conta por
    * DESCRICAO (SigCdCli.Rclis, filtrado por grupos), equivalente ao
    * Get_dconta.Valid (fAcessoContas modo 'D'). Ao casar/selecionar,
    * preenche TAMBEM o codigo (Iclis) no txt_4c_Conta irmao.
    *--------------------------------------------------------------------------
    PROCEDURE ConDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Conta
            THIS.ProcessarLookupContaPorDescricao(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROCEDURE RespDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Responsavel
            THIS.ProcessarLookupContaPorDescricao(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ProcessarLookupContaPorDescricao(par_nKeyCode, par_oTxtGrupo, par_oTxtConta, par_oTxtDconta)
        LOCAL loc_cValor, loc_cGrupo, loc_cFiltroExtra, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(par_oTxtDconta.Value)
        loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
        loc_cFiltroExtra = ""
        IF !EMPTY(loc_cGrupo)
            loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF

        IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_ChkContaD")
                USE IN cursor_4c_ChkContaD
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Iclis, Rclis FROM SigCdCli WHERE Rclis = " + EscaparSQL(loc_cValor) + ;
                IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
                "cursor_4c_ChkContaD")
            IF loc_nResultado > 0 AND USED("cursor_4c_ChkContaD") AND RECCOUNT("cursor_4c_ChkContaD") > 0
                par_oTxtConta.Value  = ALLTRIM(cursor_4c_ChkContaD.Iclis)
                par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkContaD.Rclis)
                IF USED("cursor_4c_ChkContaD")
                    USE IN cursor_4c_ChkContaD
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkContaD")
                USE IN cursor_4c_ChkContaD
            ENDIF
        ENDIF

        THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
            "Conta", loc_cValor, par_oTxtConta, par_oTxtDconta, loc_cFiltroExtra)
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaCodKeyPress / EmpresaDescKeyPress - lookup de Empresa
    * (SigCdEmp.Cemps/Razas), equivalente ao par get_cd_empresa.Valid /
    * get_ds_empresa.Valid (fAcessoEmpresa modos 'C'/'D') - fAcessoEmpresa
    * NAO foi portada (funcao global Fortyus - ver regra de funcoes de
    * acesso nao portadas), substituida pelo lookup canonico em SigCdEmp.
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaCodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Empresa
            loc_cValor = ALLTRIM(.txt_4c_CdEmpresa.Value)

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkEmpCod")
                    USE IN cursor_4c_ChkEmpCod
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkEmpCod")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpCod") AND RECCOUNT("cursor_4c_ChkEmpCod") > 0
                    .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpCod.Razas)
                    IF USED("cursor_4c_ChkEmpCod")
                        USE IN cursor_4c_ChkEmpCod
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkEmpCod")
                    USE IN cursor_4c_ChkEmpCod
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
                .txt_4c_CdEmpresa, .txt_4c_DsEmpresa)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROCEDURE EmpresaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Empresa
            loc_cValor = ALLTRIM(.txt_4c_DsEmpresa.Value)

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkEmpDesc")
                    USE IN cursor_4c_ChkEmpDesc
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkEmpDesc")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpDesc") AND RECCOUNT("cursor_4c_ChkEmpDesc") > 0
                    .txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Cemps)
                    .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Razas)
                    IF USED("cursor_4c_ChkEmpDesc")
                        USE IN cursor_4c_ChkEmpDesc
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkEmpDesc")
                    USE IN cursor_4c_ChkEmpDesc
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
                .txt_4c_CdEmpresa, .txt_4c_DsEmpresa)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * NopKeyPress - Numero manual da O.P. (cnt_4c_Op.txt_4c_Nop), equivalente
    * ao GetNop.Valid legado: NAO eh um picker, eh checagem de duplicidade
    * contra SigOpPic.Numps. Se ja existe, avisa e limpa o campo.
    *--------------------------------------------------------------------------
    PROCEDURE NopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Op
            loc_nValor = .txt_4c_Nop.Value
            IF loc_nValor > 0 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkNop")
                    USE IN cursor_4c_ChkNop
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Numps FROM SigOpPic WHERE Numps = " + FormatarNumeroSQL(loc_nValor, 0), ;
                    "cursor_4c_ChkNop")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkNop") AND RECCOUNT("cursor_4c_ChkNop") > 0
                    MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    .txt_4c_Nop.Value = 0
                    .txt_4c_Nop.SetFocus
                ENDIF
                IF USED("cursor_4c_ChkNop")
                    USE IN cursor_4c_ChkNop
                ENDIF
            ENDIF
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - funil de bloqueio/desbloqueio da UI durante o
    * processamento em lote. Este form OPERACIONAL eh flat (sem PageFrame de
    * conteudo), entao nao ha pagina para navegar - "par_cModo" alterna o
    * ESTADO da tela entre:
    *   "ENTRADA"     - usuario preenche os filtros (UI liberada)
    *   "PROCESSANDO" - THIS.this_oBusinessObject executa o processamento em
    *                   lote (UI bloqueada, equivalente ao trecho do Click
    *                   legado que roda entre a validacao e o Messagebox de
    *                   conclusao)
    * Chamado no fim de InicializarForm ("ENTRADA") e, nas proximas fases,
    * no BtnProcessarClick (antes/depois de THIS.this_oBusinessObject.Processar)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_cModo)
        LOCAL loc_lLiberado
        loc_lLiberado = (UPPER(ALLTRIM(par_cModo)) != "PROCESSANDO")

        THIS.cmd_4c_Processar.Enabled = loc_lLiberado

        THIS.cnt_4c_Container1.Enabled   = loc_lLiberado AND THIS.this_lGerPorTp
        THIS.cnt_4c_Operacao.Enabled     = loc_lLiberado
        THIS.cnt_4c_Conta.Enabled        = loc_lLiberado
        THIS.cnt_4c_Responsavel.Enabled  = loc_lLiberado
        THIS.cnt_4c_Empresa.Enabled      = loc_lLiberado
        THIS.cnt_4c_Previsao.Enabled     = loc_lLiberado
        THIS.cnt_4c_Op.Enabled           = loc_lLiberado

        IF loc_lLiberado
            THIS.MousePointer = 0
        ELSE
            THIS.MousePointer = 11
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visiveis (recursivamente) os controles
    * criados via AddObject, que nascem com Visible = .F.
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls[loc_i]
            IF VARTYPE(loc_oCtrl) != "O"
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls[loc_i]
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGloBO.prg):
*============================================================================
* SigPrGloBO.prg - Business Object para Processamento de O.P. (SIGPRGLO)
*
* Form OPERACIONAL (SIGPRGLO / FormSigPrGlo): tela de parametros que dispara
* o processamento em lote de Ordens de Producao a partir das movimentacoes
* em aberto (SigMvCab/SigMvItn), filtradas por periodo de emissao/entrega,
* operacao, conta (compradora) e conta responsavel (vendedor), gravando o
* resultado em cursores temporarios (SigTempd/CrSigTempd) antes de efetivar
* a geracao das O.P.s (SigOpPic/SigOpPii/SigCdNec/...).
*
* Reusado pelo legado em tres modos, controlados pelos parametros do Init:
*   - Processamento normal de O.P. (this_lReserva=.F., this_lGerPorTp=.F.)
*   - Reserva Automatica (this_lReserva=.T.)
*   - Processamento por Tipo de O.P. (this_lGerPorTp=.T., habilita Container1)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de processamento (Processar/CarregarDoCursor)
*============================================================================

DEFINE CLASS SigPrGloBO AS BusinessBase

    *==========================================================================
    * Flags de modo - equivalem a ThisForm.Reserva/automatico/Pordestino/
    * GerPorTp do legado, recebidos via parametro no Init do form legado
    * (LParameters _Reserva, _Autom, _PorDestino, lcNomeFrm1, pTipo)
    *==========================================================================
    this_lReserva     = .F.   && .T. = "Processar Reserva Automatica"
    this_lAutomatico  = .F.   && .T. = processamento automatico (sem interacao)
    this_lPorDestino  = .F.   && .T. = globalizacao por destino
    this_lGerPorTp    = .F.   && .T. = "Processar Ordem de Producao por Tipo" (habilita Container1/Get_TpGOp)

    *==========================================================================
    * Filtros - Periodo de Emissao e Previsao de Entrega (GetDataei/GetDataef/
    * GetDatapi/GetDatapf)
    *==========================================================================
    this_dDataEmissaoIni  = {}   && GetDataei - periodo de emissao, de
    this_dDataEmissaoFim  = {}   && GetDataef - periodo de emissao, ate
    this_dDataPrazoIni    = {}   && GetDatapi - previsao de entrega, de
    this_dDataPrazoFim    = {}   && GetDatapf - previsao de entrega, ate

    *==========================================================================
    * Filtros - Conta (Movimentacao) - container Conta (Get_grupo/Get_conta/
    * Get_dconta) - SigMvCab.GrupoOs/ContaOs quando Globalizas=1
    *==========================================================================
    this_cContaGrupo      = SPACE(10)  && Conta.Get_grupo
    this_cContaConta      = SPACE(10)  && Conta.Get_conta
    this_cContaDescricao  = SPACE(40)  && Conta.Get_dconta (lookup, nao gravado)

    *==========================================================================
    * Filtros - Responsavel/Vendedor - container Responsavel (Get_grupo/
    * Get_conta/Get_dconta) - SigMvCab.GrVends/Vends
    *==========================================================================
    this_cRespGrupo       = SPACE(10)  && Responsavel.Get_grupo
    this_cRespConta       = SPACE(10)  && Responsavel.Get_conta
    this_cRespDescricao   = SPACE(40)  && Responsavel.Get_dconta (lookup, nao gravado)

    *==========================================================================
    * Filtros - Movimentacao/Operacao - container Operacao (Get_Operacao/
    * Get_Operacaoi/Get_Operacaof) - SigCdOpe.Dopes / SigMvCab.Numes
    *==========================================================================
    this_cOperacao        = SPACE(20)  && Operacao.Get_Operacao
    this_nOperacaoIni     = 0          && Operacao.Get_Operacaoi
    this_nOperacaoFim     = 0          && Operacao.Get_Operacaof

    *==========================================================================
    * Filtro - Empresa - container Empresa (get_cd_empresa/get_ds_empresa/
    * Chec_pedra) - SigCdEmp.Cemps/Razas
    *==========================================================================
    this_cEmpresaCodigo   = SPACE(3)   && Empresa.get_cd_empresa - SigCdEmp.Cemps
    this_cEmpresaRazao    = SPACE(40)  && Empresa.get_ds_empresa - SigCdEmp.Razas (lookup)
    this_lNaoEmpenharPedra = .F.       && Empresa.Chec_pedra - "Nao Empenhar Pedras"

    *==========================================================================
    * Previsao/Geracao - container Cnt_Previsao (GetPrevisao/GetGeracao)
    *==========================================================================
    this_dPrevisaoEntrega = {}   && Cnt_Previsao.GetPrevisao - Date() + SigCdPam.PrevProds
    this_dDataGeracao     = {}   && Cnt_Previsao.GetGeracao  - Date() quando nao automatico

    *==========================================================================
    * Numero da O.P. manual - container Cnt_Op (GetNop), visivel apenas
    * quando SigCdPam.GlobAutos = 2 And !this_lReserva
    *==========================================================================
    this_nNumeroOP        = 0    && Cnt_Op.GetNop

    *==========================================================================
    * Tipo de Geracao da OP - Container1 (Get_TpGOp), habilitado apenas
    * quando this_lGerPorTp = .T. - SigInTgo.Codigos
    *==========================================================================
    this_cTipoGeracaoOP   = SPACE(10)  && Container1.Get_TpGOp

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init -
    * equivalente ao CursorQuery('SigCdPam','crSigCdPam',...,[lcCampos]) do
    * Init() legado
    *==========================================================================
    this_cPamDopEmphs     = SPACE(20)  && SigCdPam.dopemphs
    this_cPamDopReqcs     = SPACE(20)  && SigCdPam.dopreqcs
    this_cPamDopPedcs     = SPACE(20)  && SigCdPam.doppedcs
    this_cPamDopComps     = SPACE(20)  && SigCdPam.dopcomps
    this_cPamTransfRes    = SPACE(20)  && SigCdPam.transfres
    this_cPamGrPadClis    = SPACE(10)  && SigCdPam.grpadclis
    this_cPamDoppPads     = SPACE(20)  && SigCdPam.dopppads
    this_cPamDopTrfCps    = SPACE(20)  && SigCdPam.doptrfcps
    this_cPamGrPadVens    = SPACE(10)  && SigCdPam.grpadvens
    this_nPamPrevProds    = 0          && SigCdPam.prevprods
    this_cPamGrupoEsts    = SPACE(10)  && SigCdPam.grupoests
    this_cPamContaEsts    = SPACE(10)  && SigCdPam.contaests
    this_cPamGruReservs   = SPACE(10)  && SigCdPam.grureservs
    this_cPamConReservs   = SPACE(10)  && SigCdPam.conreservs
    this_nPamAgrupEmph    = 0          && SigCdPam.agrupemph
    this_cPamDoppServs    = SPACE(20)  && SigCdPam.doppservs
    this_nPamMascnums     = 0          && SigCdPam.mascnums
    this_cPamGruEstps     = SPACE(10)  && SigCdPam.gruestps
    this_cPamConEstps     = SPACE(10)  && SigCdPam.conestps
    this_cPamTransfencs   = SPACE(20)  && SigCdPam.transfencs
    this_cPamOuros        = SPACE(14)  && SigCdPam.ouros
    this_cPamGruConfs     = SPACE(10)  && SigCdPam.gruconfs
    this_cPamConConfs     = SPACE(10)  && SigCdPam.conconfs
    this_nPamGlobAutos    = 0          && SigCdPam.globautos
    this_cPamDopEntAus    = SPACE(20)  && SigCdPam.dopentaus
    this_cPamTpOpEntAus   = SPACE(15)  && SigCdPam.tpopentaus
    this_nPamAutComps     = 0          && SigCdPam.autcomps

    *==========================================================================
    * Colunas da tabela de staging SigTempd (this_cTabela/this_cCampoChave
    * definidos no Init) - equivalente ao cursor crSigTempd amarrado via
    * .Podatamgr2.AddCursor('SigTempd','CidChaves','CrSigTempd','','') do
    * Init legado. Prefixo "Td" evita colisao com as properties de filtro/
    * parametro acima (este bloco espelha a TABELA, nao a tela)
    *==========================================================================
    this_cTdCidChaves     = SPACE(64)  && cidchaves - chave primaria (NOT NULL)
    this_nTdCbars         = 0          && cbars
    this_cTdCgrus         = SPACE(3)   && cgrus
    this_cTdCidQuerys     = SPACE(20)  && cidquerys
    this_cTdCpros         = SPACE(10)  && cpros
    this_cTdEmpDopNums    = SPACE(29)  && empdopnums
    this_cTdEmpos         = SPACE(3)   && empos
    this_nTdQtds          = 0          && qtds
    this_cTdCmoes         = SPACE(3)   && cmoes
    this_cTdCnSuAdms      = SPACE(20)  && cnsuadms
    this_nTdCodObs        = 0          && codobs
    this_cTdContas        = SPACE(10)  && contas
    this_dTdDatas         = {}         && datas
    this_cTdDgopes        = SPACE(20)  && dgopes
    this_cTdDopes         = SPACE(20)  && dopes
    this_cTdDpros         = SPACE(65)  && dpros (NOT NULL)
    this_dTdDtAlts        = {}         && dtalts
    this_cTdEmpDopNum2    = SPACE(29)  && empdopnum2
    this_cTdEmpGruEsts    = SPACE(23)  && empgruests
    this_cTdEmps          = SPACE(3)   && emps
    this_cTdGrupos        = SPACE(10)  && grupos
    this_cTdMascNum       = SPACE(10)  && mascnum
    this_nTdNopers        = 0          && nopers
    this_nTdNumes         = 0          && numes
    this_cTdObss          = ""         && obss (memo)
    this_cTdOpers         = SPACE(1)   && opers
    this_cTdRazas         = SPACE(40)  && razas
    this_nTdValors        = 0          && valors
    this_nTdValpres       = 0          && valpres
    this_cTdDescrs        = SPACE(80)  && descrs
    this_cTdNewFld        = SPACE(10)  && newfld
    this_nTdVars          = 0          && vars

    *==========================================================================
    * Init - Inicializa o Business Object configurando a tabela/chave de
    * referencia (SigTempd/CidChaves - AddCursor('SigTempd','CidChaves',
    * 'CrSigTempd','','') do Init legado) e carrega os parametros do sistema
    * usados no processamento (SigCdPam)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigTempd"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopemphs, dopreqcs, doppedcs, dopcomps, transfres, " + ;
                    "grpadclis, dopppads, doptrfcps, grpadvens, prevprods, " + ;
                    "grupoests, contaests, grureservs, conreservs, agrupemph, " + ;
                    "doppservs, mascnums, gruestps, conestps, transfencs, ouros, " + ;
                    "gruconfs, conconfs, globautos, dopentaus, tpopentaus, autcomps " + ;
                    "FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cPamDopEmphs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopemphs, ""), 20)
                    THIS.this_cPamDopReqcs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopreqcs, ""), 20)
                    THIS.this_cPamDopPedcs   = PADR(TratarNulo(cursor_4c_SigCdPam.doppedcs, ""), 20)
                    THIS.this_cPamDopComps   = PADR(TratarNulo(cursor_4c_SigCdPam.dopcomps, ""), 20)
                    THIS.this_cPamTransfRes  = PADR(TratarNulo(cursor_4c_SigCdPam.transfres, ""), 20)
                    THIS.this_cPamGrPadClis  = PADR(TratarNulo(cursor_4c_SigCdPam.grpadclis, ""), 10)
                    THIS.this_cPamDoppPads   = PADR(TratarNulo(cursor_4c_SigCdPam.dopppads, ""), 20)
                    THIS.this_cPamDopTrfCps  = PADR(TratarNulo(cursor_4c_SigCdPam.doptrfcps, ""), 20)
                    THIS.this_cPamGrPadVens  = PADR(TratarNulo(cursor_4c_SigCdPam.grpadvens, ""), 10)
                    THIS.this_nPamPrevProds  = TratarNulo(cursor_4c_SigCdPam.prevprods, 0)
                    THIS.this_cPamGrupoEsts  = PADR(TratarNulo(cursor_4c_SigCdPam.grupoests, ""), 10)
                    THIS.this_cPamContaEsts  = PADR(TratarNulo(cursor_4c_SigCdPam.contaests, ""), 10)
                    THIS.this_cPamGruReservs = PADR(TratarNulo(cursor_4c_SigCdPam.grureservs, ""), 10)
                    THIS.this_cPamConReservs = PADR(TratarNulo(cursor_4c_SigCdPam.conreservs, ""), 10)
                    THIS.this_nPamAgrupEmph  = TratarNulo(cursor_4c_SigCdPam.agrupemph, 0)
                    THIS.this_cPamDoppServs  = PADR(TratarNulo(cursor_4c_SigCdPam.doppservs, ""), 20)
                    THIS.this_nPamMascnums   = TratarNulo(cursor_4c_SigCdPam.mascnums, 0)
                    THIS.this_cPamGruEstps   = PADR(TratarNulo(cursor_4c_SigCdPam.gruestps, ""), 10)
                    THIS.this_cPamConEstps   = PADR(TratarNulo(cursor_4c_SigCdPam.conestps, ""), 10)
                    THIS.this_cPamTransfencs = PADR(TratarNulo(cursor_4c_SigCdPam.transfencs, ""), 20)
                    THIS.this_cPamOuros      = PADR(TratarNulo(cursor_4c_SigCdPam.ouros, ""), 14)
                    THIS.this_cPamGruConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.gruconfs, ""), 10)
                    THIS.this_cPamConConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.conconfs, ""), 10)
                    THIS.this_nPamGlobAutos  = TratarNulo(cursor_4c_SigCdPam.globautos, 0)
                    THIS.this_cPamDopEntAus  = PADR(TratarNulo(cursor_4c_SigCdPam.dopentaus, ""), 20)
                    THIS.this_cPamTpOpEntAus = PADR(TratarNulo(cursor_4c_SigCdPam.tpopentaus, ""), 15)
                    THIS.this_nPamAutComps   = TratarNulo(cursor_4c_SigCdPam.autcomps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                * Valores padrao equivalentes ao final do Init legado -
                * Conta.Get_Grupo/Responsavel.Get_Grupo iniciam em branco
                * (o legado zera mesmo tendo crSigCdPam.GrPadClis/GrPadVens
                * disponivel - comentario "&&crSigCdPam.GrPadClis" mostra que
                * a atribuicao real foi desativada no legado) e a Previsao de
                * Entrega parte de Date() + PrevProds
                THIS.this_cContaGrupo      = SPACE(10)
                THIS.this_cRespGrupo       = SPACE(10)
                THIS.this_dPrevisaoEntrega = DATE() + THIS.this_nPamPrevProds

                IF !THIS.this_lAutomatico
                    THIS.this_dDataGeracao = DATE()
                ENDIF

            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha corrente do cursor de staging
    * (crSigTempd/SigTempd, amarrado no Init via AddCursor) para as
    * properties this_Td* desta classe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cTdCidChaves  = TratarNulo(cidchaves, "")
            THIS.this_nTdCbars      = TratarNulo(cbars, 0)
            THIS.this_cTdCgrus      = TratarNulo(cgrus, "")
            THIS.this_cTdCidQuerys  = TratarNulo(cidquerys, "")
            THIS.this_cTdCpros      = TratarNulo(cpros, "")
            THIS.this_cTdEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cTdEmpos      = TratarNulo(empos, "")
            THIS.this_nTdQtds       = TratarNulo(qtds, 0)
            THIS.this_cTdCmoes      = TratarNulo(cmoes, "")
            THIS.this_cTdCnSuAdms   = TratarNulo(cnsuadms, "")
            THIS.this_nTdCodObs     = TratarNulo(codobs, 0)
            THIS.this_cTdContas     = TratarNulo(contas, "")
            THIS.this_dTdDatas      = TratarNulo(datas, {})
            THIS.this_cTdDgopes     = TratarNulo(dgopes, "")
            THIS.this_cTdDopes      = TratarNulo(dopes, "")
            THIS.this_cTdDpros      = TratarNulo(dpros, "")
            THIS.this_dTdDtAlts     = TratarNulo(dtalts, {})
            THIS.this_cTdEmpDopNum2 = TratarNulo(empdopnum2, "")
            THIS.this_cTdEmpGruEsts = TratarNulo(empgruests, "")
            THIS.this_cTdEmps       = TratarNulo(emps, "")
            THIS.this_cTdGrupos     = TratarNulo(grupos, "")
            THIS.this_cTdMascNum    = TratarNulo(mascnum, "")
            THIS.this_nTdNopers     = TratarNulo(nopers, 0)
            THIS.this_nTdNumes      = TratarNulo(numes, 0)
            THIS.this_cTdObss       = TratarNulo(obss, "")
            THIS.this_cTdOpers      = TratarNulo(opers, "")
            THIS.this_cTdRazas      = TratarNulo(razas, "")
            THIS.this_nTdValors     = TratarNulo(valors, 0)
            THIS.this_nTdValpres    = TratarNulo(valpres, 0)
            THIS.this_cTdDescrs     = TratarNulo(descrs, "")
            THIS.this_cTdNewFld     = TratarNulo(newfld, "")
            THIS.this_nTdVars       = TratarNulo(vars, 0)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da tabela de staging (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTdCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo em SigTempd (tabela de staging amarrada via
    * AddCursor no Init legado, sem query = registro inteiro gravado). Cobre
    * as duas colunas NOT NULL sem default (cidchaves via fUniqueIds() quando
    * ausente, dpros com valor em branco) e todas as demais colunas do schema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nResultado, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cTdCidChaves))
            THIS.this_cTdCidChaves = fUniqueIds()
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cTdDpros))
            THIS.this_cTdDpros = " "
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigTempd (" + ;
                "cidchaves, cbars, cgrus, cidquerys, cpros, empdopnums, empos, qtds, " + ;
                "cmoes, cnsuadms, codobs, contas, datas, dgopes, dopes, dpros, dtalts, " + ;
                "empdopnum2, empgruests, emps, grupos, mascnum, nopers, numes, obss, " + ;
                "opers, razas, valors, valpres, descrs, newfld, vars" + ;
                ") VALUES (" + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdCidChaves), 64)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdCbars, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCgrus, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCidQuerys, 20)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCpros, 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpos, 3)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdQtds, 2) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCmoes, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCnSuAdms, 20)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdCodObs, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdContas, 10)) + ", " + ;
                FormatarDataSQL(THIS.this_dTdDatas) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdDgopes, 20)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdDopes, 20)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdDpros), 65)) + ", " + ;
                FormatarDataSQL(THIS.this_dTdDtAlts) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpDopNum2, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpGruEsts, 23)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmps, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdGrupos, 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdMascNum, 10)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdNopers, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdNumes, 0) + ", " + ;
                EscaparSQL(THIS.this_cTdObss) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdOpers, 1)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdRazas, 40)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdValors, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdValpres, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdDescrs, 80)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdNewFld, 10)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdVars, 4) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em SigTempd." + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo em SigTempd pela chave cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_nResultado, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cTdCidChaves))
            THIS.this_cMensagemErro = "Chave do registro (cidchaves) n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigTempd SET " + ;
                "cbars = " + FormatarNumeroSQL(THIS.this_nTdCbars, 0) + ", " + ;
                "cgrus = " + EscaparSQL(LEFT(THIS.this_cTdCgrus, 3)) + ", " + ;
                "cidquerys = " + EscaparSQL(LEFT(THIS.this_cTdCidQuerys, 20)) + ", " + ;
                "cpros = " + EscaparSQL(LEFT(THIS.this_cTdCpros, 10)) + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cTdEmpDopNums, 29)) + ", " + ;
                "empos = " + EscaparSQL(LEFT(THIS.this_cTdEmpos, 3)) + ", " + ;
                "qtds = " + FormatarNumeroSQL(THIS.this_nTdQtds, 2) + ", " + ;
                "cmoes = " + EscaparSQL(LEFT(THIS.this_cTdCmoes, 3)) + ", " + ;
                "cnsuadms = " + EscaparSQL(LEFT(THIS.this_cTdCnSuAdms, 20)) + ", " + ;
                "codobs = " + FormatarNumeroSQL(THIS.this_nTdCodObs, 0) + ", " + ;
                "contas = " + EscaparSQL(LEFT(THIS.this_cTdContas, 10)) + ", " + ;
                "datas = " + FormatarDataSQL(THIS.this_dTdDatas) + ", " + ;
                "dgopes = " + EscaparSQL(LEFT(THIS.this_cTdDgopes, 20)) + ", " + ;
                "dopes = " + EscaparSQL(LEFT(THIS.this_cTdDopes, 20)) + ", " + ;
                "dpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdDpros), 65)) + ", " + ;
                "dtalts = " + FormatarDataSQL(THIS.this_dTdDtAlts) + ", " + ;
                "empdopnum2 = " + EscaparSQL(LEFT(THIS.this_cTdEmpDopNum2, 29)) + ", " + ;
                "empgruests = " + EscaparSQL(LEFT(THIS.this_cTdEmpGruEsts, 23)) + ", " + ;
                "emps = " + EscaparSQL(LEFT(THIS.this_cTdEmps, 3)) + ", " + ;
                "grupos = " + EscaparSQL(LEFT(THIS.this_cTdGrupos, 10)) + ", " + ;
                "mascnum = " + EscaparSQL(LEFT(THIS.this_cTdMascNum, 10)) + ", " + ;
                "nopers = " + FormatarNumeroSQL(THIS.this_nTdNopers, 0) + ", " + ;
                "numes = " + FormatarNumeroSQL(THIS.this_nTdNumes, 0) + ", " + ;
                "obss = " + EscaparSQL(THIS.this_cTdObss) + ", " + ;
                "opers = " + EscaparSQL(LEFT(THIS.this_cTdOpers, 1)) + ", " + ;
                "razas = " + EscaparSQL(LEFT(THIS.this_cTdRazas, 40)) + ", " + ;
                "valors = " + FormatarNumeroSQL(THIS.this_nTdValors, 2) + ", " + ;
                "valpres = " + FormatarNumeroSQL(THIS.this_nTdValpres, 0) + ", " + ;
                "descrs = " + EscaparSQL(LEFT(THIS.this_cTdDescrs, 80)) + ", " + ;
                "newfld = " + EscaparSQL(LEFT(THIS.this_cTdNewFld, 10)) + ", " + ;
                "vars = " + FormatarNumeroSQL(THIS.this_nTdVars, 4) + " " + ;
                "WHERE cidchaves = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdCidChaves), 64))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em SigTempd." + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Nota de arquitetura: este form nao exclui registros de SigTempd (o
    * Click do botao Processar do legado so cria/consulta cursores locais
    * TmpCabec/TmpItens e delega a SigPrGl2 - ver SigPrGl2BO.ExecutarProcessamento
    * para o ciclo completo de escrita/limpeza do staging). O comportamento
    * padrao herdado de BusinessBase para ExecutarExclusao() ja e o correto
    * aqui.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * FecharCursoresProcessamento - fecha os cursores de trabalho de uma
    * execucao anterior de Processar() (idempotente - permite clicar em
    * Processar mais de uma vez na mesma sessao do form sem "Alias already
    * in use")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresProcessamento()
        LOCAL loc_aCursores[12], loc_nI
        loc_aCursores[1]  = "TmpOper"
        loc_aCursores[2]  = "TmpCabec"
        loc_aCursores[3]  = "TmpItens"
        loc_aCursores[4]  = "crSigCdOpd"
        loc_aCursores[5]  = "Produtos"
        loc_aCursores[6]  = "cursor_4c_TempEest"
        loc_aCursores[7]  = "cursor_4c_TempEestI"
        loc_aCursores[8]  = "cursor_4c_TempEsti2"
        loc_aCursores[9]  = "crSigCdPro"
        loc_aCursores[10] = "crSigCdGrp"
        loc_aCursores[11] = "crSigPrMtz"
        loc_aCursores[12] = "crLocalCli"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Transcricao do Click do botao Processar (SIGPRGLO.Processar.
    * Click, tasks\task615\SigPrGlo_form_codigo_fonte.txt linhas 1383-1703):
    * varre as movimentacoes em aberto (SigMvCab/SigMvItn/SigMvIts) que casam
    * com os filtros da tela e monta os cursores TmpCabec/TmpItens - deixados
    * ABERTOS na DataSession corrente para o FormSigPrGl2 (Do Form SigPrGl2
    * With ... do legado), que exige a estrutura fixada em
    * FormSigPrGl2.ConfigurarGrids/SigPrGl2BO.CarregarDoCursor (task614) -
    * NAO alterar nomes/tamanhos de campo aqui sem alterar o form filho junto.
    *
    * O contrato do form filho RENOMEOU o antigo par Grupo/Conta (legado) para
    * GrupoOs/ContaOs (grupo e conta DE ORIGEM, copiados literais de
    * SigMvCab) e manteve Conta/DConta como o codigo/descricao da conta
    * RESOLVIDA por Globalizas (_ContaG do legado - exibida como "Cliente" na
    * grade do form filho, ver FormSigPrGl2.prg:354-357). O campo Grupov
    * (GrVends) do legado nao existe mais no contrato - CarregarDoCursor do
    * SigPrGl2BO nao le esse campo.
    *
    * NAO transcrito (codigo morto/de depuracao no legado, conferido linha a
    * linha no dump e contra o form filho - grep em SigPrGl2BO.prg/
    * FormSigPrGl2.prg confirmando ausencia de uso):
    *   - "Set Step On" (abre o debugger do VFP - nao pode ir para producao)
    *   - bloco comentado (*!*) de override de _Dopp por TmpSigInTgo.Dopps
    *   - cursor DBParam (criado, nunca lido - nem pelo proprio Click nem
    *     pelo form filho)
    *   - CrSigCdPac/CrTmpTpGop dentro do Click (alimentavam so o DBParam
    *     morto - os dois cursores tem uso LEGITIMO em outro lugar do form,
    *     mas nao aqui)
    *   - cursor SelPedra (criado, nunca populado nem lido em lugar nenhum)
    *
    * Retorna .T. mesmo quando nenhum item casar com o filtro (TmpCabec/
    * TmpItens ficam vazios, porem existentes) - quem decide a mensagem
    * "Nenhum Item Selecionado Para Processar!!!" e o FORM, olhando
    * RECCOUNT() depois da chamada (mesma fonte unica ja usada na regra de
    * grade/validacao: o BO calcula, o form so espelha). Retorna .F. so em
    * falha de validacao (guardado em this_cMensagemErro) ou falha de SQL.
    *--------------------------------------------------------------------------
    FUNCTION Processar(par_dDataEmiIni, par_dDataEmiFim, par_dDataPzoIni, par_dDataPzoFim, ;
            par_cOperacao, par_nOperacaoIni, par_nOperacaoFim, ;
            par_cContaGrupo, par_cContaConta, par_cRespGrupo, par_cRespConta, ;
            par_cEmpresa, par_cTipoGeracaoOP)

        LOCAL loc_lSucesso, loc_oErro, loc_nResultado
        LOCAL loc_cCondeDatas, loc_cCondpDatas, loc_cDopp, loc_cQuery
        LOCAL loc_cEdn, loc_lProcessa, loc_nTPeso, loc_nSaldo, loc_nPeso, loc_nBaixa, loc_nQtdTb
        LOCAL loc_cGrupoG, loc_cContaG, loc_cGrupoD, loc_cContaD
        LOCAL loc_oProg, loc_lAbortar

        loc_lSucesso = .F.
        loc_lAbortar = .F.
        THIS.this_cMensagemErro = ""

        *-- Validacao de intervalo invertido (mesma regra do Form - o BO
        *-- tambem garante isso para quem chamar Processar() direto). Fica
        *-- FORA do TRY de proposito: sao comparacoes puras de data, entao o
        *-- early-exit pode ser RETURN de verdade. Dentro de TRY o RETURN nao
        *-- retorna - ele ABANDONA o bloco e cai no CATCH (regra #1 do
        *-- CLAUDE.md), e o chamador receberia .T. com os cursores vazios.
        IF !EMPTY(par_dDataEmiFim) AND !EMPTY(par_dDataEmiIni) AND par_dDataEmiFim < par_dDataEmiIni
            THIS.this_cMensagemErro = "A Data Final Deve Ser Maior Que a Inicial!!!"
            RETURN .F.
        ENDIF
        IF !EMPTY(par_dDataPzoFim) AND !EMPTY(par_dDataPzoIni) AND par_dDataPzoFim < par_dDataPzoIni
            THIS.this_cMensagemErro = "A Data Final Deve Ser Maior Que a Inicial!!!"
            RETURN .F.
        ENDIF

        TRY
            THIS.FecharCursoresProcessamento()

            *-- _Conde (periodo de emissao) - so entra na consulta quando a
            *-- data final foi preenchida (guard identico ao legado). Upper
            *-- bound reescrito como "< dia seguinte" (equivalente a
            *-- "<= 23:59:59" do legado) porque FormatarDataSQL() nao aceita
            *-- hora
            IF EMPTY(par_dDataEmiFim)
                loc_cCondeDatas = ""
            ELSE
                loc_cCondeDatas = "Datas >= " + FormatarDataSQL(par_dDataEmiIni) + ;
                    " AND Datas < " + FormatarDataSQL(par_dDataEmiFim + 1) + " AND "
            ENDIF

            *-- _Condp (prazo de entrega) - transcricao literal da arvore de
            *-- IFs do legado (Ini/Fim podem vir isolados)
            IF EMPTY(par_dDataPzoIni)
                IF EMPTY(par_dDataPzoFim)
                    loc_cCondpDatas = ""
                ELSE
                    loc_cCondpDatas = "PrazoEnts < " + FormatarDataSQL(par_dDataPzoFim + 1) + " AND "
                ENDIF
            ELSE
                IF EMPTY(par_dDataPzoFim)
                    loc_cCondpDatas = "PrazoEnts >= " + FormatarDataSQL(par_dDataPzoIni) + " AND "
                ELSE
                    loc_cCondpDatas = "PrazoEnts >= " + FormatarDataSQL(par_dDataPzoIni) + ;
                        " AND PrazoEnts < " + FormatarDataSQL(par_dDataPzoFim + 1) + " AND "
                ENDIF
            ENDIF

            *-- TmpOper: operacoes validas para OP (Globalizas IN (1,2)),
            *-- equivalente ao TmpOper2->TmpOper do Init legado. Fica ABERTO
            *-- ao final - contrato de SigPrGl2BO.this_cCursorOperacoes, que
            *-- faz SEEK por Dopes sem SET ORDER previo
            loc_cQuery = "SELECT a.Dopes, a.Globalizas, a.Opers, ISNULL(a.Reservas,0) AS Reservas, " + ;
                "ISNULL(b.OpeGops,' ') AS OpeGops, ISNULL(b.CodTgOps,' ') AS CodTgOps, " + ;
                "ISNULL(b.chkObs,0) AS ChkObs, ISNULL(c.carcompos,0) AS carcompos " + ;
                "FROM SigCdOpe a LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                "WHERE a.Globalizas IN (1,2)"
            IF !EMPTY(par_cOperacao)
                loc_cQuery = loc_cQuery + " AND a.Dopes = " + EscaparSQL(par_cOperacao)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpOper")
            IF loc_nResultado < 1 OR !USED("TmpOper")
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpOper)" + CHR(13) + CapturarErroSQL()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                SELECT TmpOper
                INDEX ON Dopes TAG Dopes
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar Ordem de Produ" + CHR(231) + CHR(227) + "o!!!"
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Corpo da varredura guardado por loc_lAbortar: as falhas de SQL
            *-- e as validacoes acima nao podem sair por RETURN (regra #1 -
            *-- RETURN dentro de TRY abandona o bloco em vez de retornar), e os
            *-- SCAN aninhados propagam o aborto por EXIT em cascata.
            IF !loc_lAbortar
                *-- SigCdOpd (grupo/conta de DESTINO padrao da geracao) - _Dopp
                *-- vem do parametro de sistema ja carregado no Init (DoppPads)
                loc_cDopp = ALLTRIM(THIS.this_cPamDoppPads)
                SQLEXEC(gnConnHandle, "SELECT TOP 1 GruDests, ConDests FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopp), "crSigCdOpd")
                IF !USED("crSigCdOpd")
                    CREATE CURSOR crSigCdOpd (GruDests C(10), ConDests C(10))
                    APPEND BLANK
                ENDIF

                *-- Cursores de trabalho - estrutura EXATA exigida por
                *-- SigPrGl2BO.CarregarDoCursor/ExecutarProcessamento (contrato
                *-- fixado em FormSigPrGl2.ConfigurarGrids, task614)
                CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6), ;
                    Datas D, Entregas D, Peso N(9,3), Contav C(10), Conta C(10), ;
                    DConta C(50), Obs M NULL, Notas C(6), GrupoOs C(10), ContaOs C(10), ;
                    GrupoDs C(10), ContaDs C(10), Jobs C(10))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
                SET ORDER TO EmpDopNum

                CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), ;
                    CodCors C(4), CodTams C(4), Linhas C(10), Citens N(10), Qtds N(10,3), ;
                    Saldo N(10,3), Peso N(9,3), Obs M NULL, Notas C(6), Dpros C(40), Reffs C(40))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON CPros TAG CPros
                SET ORDER TO EmpDopNum

                *-- Varredura das operacoes validas (TmpOper) -> movimentacoes
                *-- em aberto (SigMvCab) -> itens (SigMvItn/SigMvIts)
                SELECT TmpOper
                SCAN
                    IF THIS.this_lGerPorTp AND ALLTRIM(TmpOper.CodTgOps) != ALLTRIM(par_cTipoGeracaoOP)
                        LOOP
                    ENDIF

                    loc_cQuery = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, ContaOs, " + ;
                        "GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs " + ;
                        "FROM SigMvCab WHERE " + loc_cCondeDatas + loc_cCondpDatas + ;
                        "Emps = " + EscaparSQL(par_cEmpresa) + " AND Dopes = " + EscaparSQL(ALLTRIM(TmpOper.Dopes)) + " AND "

                    IF !EMPTY(par_cContaGrupo)
                        IF TmpOper.Globalizas = 1
                            loc_cQuery = loc_cQuery + "GrupoOs = " + EscaparSQL(par_cContaGrupo) + " AND "
                        ELSE
                            IF TmpOper.Globalizas = 2
                                loc_cQuery = loc_cQuery + "GrupoDs = " + EscaparSQL(par_cContaGrupo) + " AND "
                            ENDIF
                        ENDIF
                    ENDIF
                    IF !EMPTY(par_cContaConta)
                        IF TmpOper.Globalizas = 1
                            loc_cQuery = loc_cQuery + "ContaOs = " + EscaparSQL(par_cContaConta) + " AND "
                        ELSE
                            IF TmpOper.Globalizas = 2
                                loc_cQuery = loc_cQuery + "ContaDs = " + EscaparSQL(par_cContaConta) + " AND "
                            ENDIF
                        ENDIF
                    ENDIF
                    IF !EMPTY(par_cRespGrupo)
                        loc_cQuery = loc_cQuery + "GrVends = " + EscaparSQL(par_cRespGrupo) + " AND "
                    ENDIF
                    IF !EMPTY(par_cRespConta)
                        loc_cQuery = loc_cQuery + "Vends = " + EscaparSQL(par_cRespConta) + " AND "
                    ENDIF
                    loc_cQuery = loc_cQuery + "Nops = 0"

                    IF USED("cursor_4c_TempEest")
                        USE IN cursor_4c_TempEest
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_TempEest")
                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TempEest)" + CHR(13) + CapturarErroSQL()
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_TempEest
                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Processando Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(TmpOper.Dopes) + "...", RECCOUNT())
                    loc_oProg.Show()
                    SCAN
                        loc_oProg.Update(.T.)

                        IF !EMPTY(par_cOperacao) AND par_nOperacaoIni != 0 AND par_nOperacaoFim != 0 ;
                                AND !BETWEEN(cursor_4c_TempEest.Numes, par_nOperacaoIni, par_nOperacaoFim)
                            LOOP
                        ENDIF

                        IF TmpOper.Globalizas = 1
                            loc_cGrupoG = cursor_4c_TempEest.GrupoOs
                            loc_cContaG = cursor_4c_TempEest.ContaOs
                        ELSE
                            loc_cGrupoG = cursor_4c_TempEest.GrupoDs
                            loc_cContaG = cursor_4c_TempEest.ContaDs
                        ENDIF

                        IF THIS.this_lReserva AND cursor_4c_TempEest.rNops > 0
                            LOOP
                        ENDIF

                        loc_nTPeso    = 0
                        loc_lProcessa = .F.
                        loc_cEdn = cursor_4c_TempEest.Emps + cursor_4c_TempEest.Dopes + STR(cursor_4c_TempEest.Numes, 6)

                        IF USED("cursor_4c_TempEestI")
                            USE IN cursor_4c_TempEestI
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, Emps, Dopes, Numes, " + ;
                            "Obs, Notas, Dpros, Opers, Citem2 FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                            "cursor_4c_TempEestI")

                        IF USED("cursor_4c_TempEestI")
                            SELECT cursor_4c_TempEestI
                            SCAN
                                IF TmpOper.Opers = 3 AND !EMPTY(ALLTRIM(TmpOper.OpeGops)) AND cursor_4c_TempEestI.Opers != TmpOper.OpeGops
                                    LOOP
                                ENDIF
                                IF TmpOper.carcompos = 5 AND cursor_4c_TempEestI.Citem2 != 0
                                    LOOP
                                ENDIF

                                IF USED("crSigCdPro")
                                    USE IN crSigCdPro
                                ENDIF
                                SQLEXEC(gnConnHandle, ;
                                    "SELECT Pesoms, Linhas, QtdCpnts, DPros, Reffs, Cgrus FROM SigCdPro WHERE CPros = " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros)), "crSigCdPro")
                                IF !USED("crSigCdPro") OR EOF("crSigCdPro")
                                    LOOP
                                ENDIF

                                IF USED("crSigCdGrp")
                                    USE IN crSigCdGrp
                                ENDIF
                                SQLEXEC(gnConnHandle, ;
                                    "SELECT GeraTubs FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.Cgrus)), "crSigCdGrp")

                                IF USED("cursor_4c_TempEsti2")
                                    USE IN cursor_4c_TempEsti2
                                ENDIF
                                loc_nResultado = SQLEXEC(gnConnHandle, ;
                                    "SELECT Emps, Dopes, Numes, CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, CodCors, CodTams " + ;
                                    "FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                    " AND CItens = " + FormatarNumeroSQL(cursor_4c_TempEestI.CItens, 0), ;
                                    "cursor_4c_TempEsti2")
                                IF loc_nResultado < 0
                                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TempEsti2)" + CHR(13) + CapturarErroSQL()
                                    loc_lAbortar = .T.
                                    EXIT
                                ENDIF

                                IF !USED("cursor_4c_TempEsti2") OR EOF("cursor_4c_TempEsti2")
                                    loc_nBaixa = IIF(cursor_4c_TempEestI.QtBaixas > 0 AND cursor_4c_TempEestI.QtBaixas >= cursor_4c_TempEestI.QtProds, ;
                                        cursor_4c_TempEestI.QtBaixas - cursor_4c_TempEestI.QtProds, 0) + cursor_4c_TempEestI.QtProds
                                    loc_nSaldo = cursor_4c_TempEestI.Qtds - loc_nBaixa
                                    loc_nPeso  = IIF(EMPTY(cursor_4c_TempEestI.Pesos), crSigCdPro.Pesoms, cursor_4c_TempEestI.Pesos)
                                    IF loc_nSaldo != 0
                                        INSERT INTO TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, Citens, Notas, Dpros, Reffs) ;
                                            VALUES (cursor_4c_TempEestI.Emps, cursor_4c_TempEestI.Dopes, cursor_4c_TempEestI.Numes, ;
                                                cursor_4c_TempEestI.CPros, cursor_4c_TempEestI.Qtds, loc_nSaldo, cursor_4c_TempEestI.Obs, ;
                                                loc_nPeso, crSigCdPro.Linhas, cursor_4c_TempEestI.CItens, cursor_4c_TempEestI.Notas, ;
                                                cursor_4c_TempEestI.Dpros, crSigCdPro.Reffs)

                                        loc_nTPeso    = loc_nTPeso + (loc_nPeso * loc_nSaldo)
                                        loc_lProcessa = .T.

                                        IF crSigCdGrp.GeraTubs != 2
                                            loc_nQtdTb = crSigCdPro.QtdCpnts
                                        ELSE
                                            IF USED("crSigPrMtz")
                                                USE IN crSigPrMtz
                                            ENDIF
                                            SQLEXEC(gnConnHandle, ;
                                                "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = " + ;
                                                EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros)), "crSigPrMtz")
                                            loc_nQtdTb = TratarNulo(crSigPrMtz.total, 0)
                                        ENDIF
                                        IF loc_nQtdTb = 0
                                            IF !USED("Produtos")
                                                CREATE CURSOR Produtos (Cpros C(14), Dpros C(40))
                                                INDEX ON Cpros TAG Cpros
                                            ENDIF
                                            IF !SEEK(ALLTRIM(cursor_4c_TempEestI.CPros), "Produtos", "Cpros")
                                                INSERT INTO Produtos (Cpros, DPros) VALUES (cursor_4c_TempEestI.CPros, crSigCdPro.DPros)
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ELSE
                                    SELECT cursor_4c_TempEsti2
                                    SCAN
                                        loc_nBaixa = IIF(cursor_4c_TempEsti2.QtBaixas > 0 AND cursor_4c_TempEsti2.QtBaixas >= cursor_4c_TempEsti2.QtProds, ;
                                            cursor_4c_TempEsti2.QtBaixas - cursor_4c_TempEsti2.QtProds, 0) + cursor_4c_TempEsti2.QtProds
                                        loc_nSaldo = cursor_4c_TempEsti2.Qtds - loc_nBaixa
                                        loc_nPeso  = IIF(EMPTY(cursor_4c_TempEsti2.Pesos), crSigCdPro.Pesoms, cursor_4c_TempEsti2.Pesos)
                                        IF loc_nSaldo != 0
                                            INSERT INTO TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, ;
                                                    CodCors, CodTams, Citens, Notas, Dpros, Reffs) ;
                                                VALUES (cursor_4c_TempEsti2.Emps, cursor_4c_TempEsti2.Dopes, cursor_4c_TempEsti2.Numes, ;
                                                    cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.Qtds, loc_nSaldo, cursor_4c_TempEestI.Obs, ;
                                                    loc_nPeso, crSigCdPro.Linhas, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams, ;
                                                    cursor_4c_TempEsti2.CItens, cursor_4c_TempEestI.Notas, cursor_4c_TempEestI.Dpros, crSigCdPro.Reffs)

                                            loc_nTPeso    = loc_nTPeso + (loc_nPeso * loc_nSaldo)
                                            loc_lProcessa = .T.

                                            IF crSigCdGrp.GeraTubs != 2
                                                loc_nQtdTb = crSigCdPro.QtdCpnts
                                            ELSE
                                                IF USED("crSigPrMtz")
                                                    USE IN crSigPrMtz
                                                ENDIF
                                                SQLEXEC(gnConnHandle, ;
                                                    "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = " + ;
                                                    EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros)), "crSigPrMtz")
                                                loc_nQtdTb = TratarNulo(crSigPrMtz.total, 0)
                                            ENDIF
                                            IF loc_nQtdTb = 0
                                                IF !USED("Produtos")
                                                    CREATE CURSOR Produtos (Cpros C(14), Dpros C(40))
                                                    INDEX ON Cpros TAG Cpros
                                                ENDIF
                                                IF !SEEK(ALLTRIM(cursor_4c_TempEestI.CPros), "Produtos", "Cpros")
                                                    INSERT INTO Produtos (Cpros, DPros) VALUES (cursor_4c_TempEestI.CPros, crSigCdPro.DPros)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                        SELECT cursor_4c_TempEestI
                                    ENDSCAN
                                ENDIF
                                SELECT cursor_4c_TempEestI
                            ENDSCAN
                        ENDIF

                        *-- Propaga o aborto do SCAN interno (regra #1 - sem RETURN
                        *-- dentro de TRY, o early-exit sai em cascata por EXIT)
                        IF loc_lAbortar
                            EXIT
                        ENDIF

                        IF loc_lProcessa
                            loc_cGrupoD = IIF(EMPTY(crSigCdOpd.GruDests), cursor_4c_TempEest.GrupoDs, crSigCdOpd.GruDests)
                            loc_cContaD = IIF(EMPTY(crSigCdOpd.ConDests), cursor_4c_TempEest.ContaDs, crSigCdOpd.ConDests)

                            IF USED("crLocalCli")
                                USE IN crLocalCli
                            ENDIF
                            SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_cContaG)), "crLocalCli")
                            IF !USED("crLocalCli")
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalCli)" + CHR(13) + CapturarErroSQL()
                                loc_lAbortar = .T.
                                EXIT
                            ENDIF

                            INSERT INTO TmpCabec (Flag, Emps, Dopes, Numes, Datas, Entregas, Peso, Contav, Conta, DConta, ;
                                    Obs, Notas, GrupoOs, ContaOs, GrupoDs, ContaDs, Jobs) ;
                                VALUES (.T., cursor_4c_TempEest.Emps, cursor_4c_TempEest.Dopes, cursor_4c_TempEest.Numes, ;
                                    cursor_4c_TempEest.Datas, cursor_4c_TempEest.PrazoEnts, loc_nTPeso, cursor_4c_TempEest.Vends, ;
                                    loc_cContaG, IIF(!EOF("crLocalCli"), ALLTRIM(crLocalCli.RClis), ""), ;
                                    cursor_4c_TempEest.Obses, cursor_4c_TempEest.Notas, cursor_4c_TempEest.GrupoOs, ;
                                    cursor_4c_TempEest.ContaOs, loc_cGrupoD, loc_cContaD, cursor_4c_TempEest.Jobs)

                            IF USED("crLocalCli")
                                USE IN crLocalCli
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_TempEest
                    ENDSCAN
                    loc_oProg.Complete(.T.)
                    loc_oProg.Release()

                    IF loc_lAbortar
                        EXIT
                    ENDIF

                    SELECT TmpOper
                ENDSCAN

                IF !loc_lAbortar
                    GO TOP IN TmpCabec
                    GO TOP IN TmpItens
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]"
            MsgErro(THIS.this_cMensagemErro, "Erro ao Processar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


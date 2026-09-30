# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 3/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-27 12:41:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-27 12:41:31] [INFO] Config FPW: (nao fornecido)
[2026-09-27 12:41:31] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 12:41:31] [INFO] Timeout: 300 segundos
[2026-09-27 12:41:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhyurdg1.prg
[2026-09-27 12:41:31] [INFO] Conteudo do wrapper:
[2026-09-27 12:41:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRCPR', 'C:\4c\tasks\task596\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRCPR', 'C:\4c\tasks\task596\logs\06_testForm.log'
QUIT

[2026-09-27 12:41:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhyurdg1.prg
[2026-09-27 12:41:31] [INFO] VFP output esperado em: C:\4c\tasks\task596\vfp_output.txt
[2026-09-27 12:41:31] [INFO] Executando Visual FoxPro 9...
[2026-09-27 12:41:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhyurdg1.prg
[2026-09-27 12:41:32] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhyurdg1.prg
[2026-09-27 12:41:32] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRCPR
Inicio: 27/09/2026 12:41:32

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 27/09/2026 12:45:08
Duracao: 216 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-27 12:45:08] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-27 12:45:08] [INFO] VFP9 finalizado em 216.9988167 segundos
[2026-09-27 12:45:08] [INFO] Exit Code: 
[2026-09-27 12:45:09] [INFO] 
[2026-09-27 12:45:09] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-27 12:45:09] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhyurdg1.prg
[2026-09-27 12:45:09] [INFO] 
[2026-09-27 12:45:09] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-27 12:45:09] [INFO] * Auto-generated wrapper for parameters
[2026-09-27 12:45:09] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 12:45:09] [INFO] * Parameters: 'FormSIGPRCPR', 'C:\4c\tasks\task596\logs\06_testForm.log'
[2026-09-27 12:45:09] [INFO] 
[2026-09-27 12:45:09] [INFO] * Anti-dialog protections for unattended execution
[2026-09-27 12:45:09] [INFO] SET SAFETY OFF
[2026-09-27 12:45:09] [INFO] SET RESOURCE OFF
[2026-09-27 12:45:09] [INFO] SET TALK OFF
[2026-09-27 12:45:09] [INFO] SET NOTIFY OFF
[2026-09-27 12:45:09] [INFO] SYS(2335, 0)
[2026-09-27 12:45:09] [INFO] 
[2026-09-27 12:45:09] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRCPR', 'C:\4c\tasks\task596\logs\06_testForm.log'
[2026-09-27 12:45:09] [INFO] QUIT
[2026-09-27 12:45:09] [INFO] 
[2026-09-27 12:45:09] [INFO] === Fim do Wrapper.prg ===
[2026-09-27 12:45:09] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg):
*==============================================================================
* FormSIGPRCPR.prg - Formulario Operacional: Conferencia e Reserva de Producao
* Herda de: FormBase
* Origem:  SIGPRCPR.SCX (dialogo modal chamado por um form pai de Ordem de
*          Producao - recebe o form pai via parametro, igual ao legado
*          "LParameters _Form")
* BO:      SIGPRCPRBO (ver classes\SIGPRCPRBO.prg)
*
* Fase 3/8: Estrutura base.
*   - DEFINE CLASS + propriedades visuais/estado
*   - Init / InicializarForm / Destroy
*   - ConfigurarCabecalho (cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo)
*   - TornarControlesVisiveis recursivo
*
* Fase 4/8: Grid e botoes.
*   - ConfigurarGrid (grd_4c_Dados - equivalente a Grade/TmpBaixa, com o
*     cursor_4c_Baixa pre-criado com a MESMA estrutura que
*     o metodo de carga de etiquetas do SIGPRCPRBO usa)
*   - VincularGrid (bind do cursor + larguras + headers, na ordem canonica
*     RecordSource -> ControlSource -> Width -> Header1.Caption)
*   - CarregarDados (equivalente a "PROCEDURE carregabars" do legado:
*     carga do cursor da grade + GO TOP + Refresh + visibilidade dos
*     controles conforme Eof())
*   - AjustarVisibilidadePorEtiquetas (Grade/Txt_Leitura/Get_Leitura/Ok/
*     Conferencia .Visible = Not Eof(), igual ao fim do carregabars legado)
*   - ConfigurarBotoes (cmd_4c_Conferencia/cmd_4c_Ok/cmd_4c_Sair) + handlers
*     Click (delegam a SIGPRCPRBO.ConferenciaAutomatica()/
*     ConfirmarConferencia())
*
* Fase 5/8: Campo Data (1a metade dos campos principais).
*   - ConfigurarCampoData (lbl_4c_Label2 + txt_4c_Data - equivalente a
*     Label2/Get_Data do legado: TextBox READONLY que so exibe a data
*     recebida do form pai, igual ao "Get_Data.When = Return .f." +
*     "ThisForm.Get_Data.Value = ThisForm.ParentForm.Get_Data.Value" do
*     Init legado)
*   - ObterDataDoFormPai (le a data do form pai por nome; o form pai -
*     Ordem de Producao - ainda nao foi migrado, entao cai para DATE()
*     se a property nao existir, para o campo nunca abrir vazio)
*
* Fase 6/8: Campo de leitura de codigo de barra (2a metade dos campos -
* NAO HA LOOKUP neste form: o codigo-fonte original nao tem nenhum
* fwbuscaext/sigacess/CreateObject de busca, entao nenhum foi inventado).
*   - ConfigurarCampoLeitura (lbl_4c_Txt_Leitura + txt_4c_Leitura -
*     equivalente a Txt_Leitura/Get_Leitura do legado: label + TextBox
*     NUMERICO de leitura de codigo de barra, Visible=.F. ate haver
*     etiqueta em aberto - AjustarVisibilidadePorEtiquetas, ja escrito na
*     Fase 4, controla a visibilidade dos dois)
*   - LeituraKeyPress/ValidarLeituraCodigoBarra (equivalente ao Valid do
*     Get_Leitura: delega a SIGPRCPRBO.ProcessarLeituraCodigoBarra()
*     (Fase 2), traduz o resultado nas MESMAS mensagens do legado,
*     repinta a grade e zera o campo para a proxima leitura - igual a
*     "This.Value = 0" no fim do Valid legado, em AMBOS os caminhos)
*
* Fase 7/8: Eventos principais dos botoes.
*   O template generico desta fase pede BtnIncluirClick/BtnAlterarClick/
*   BtnVisualizarClick/BtnExcluirClick, que sao a barra CRUD do frmcadastro.
*   Este legado NAO TEM CRUD: o SCX herda de "form" puro (nao de frmcadastro),
*   nao tem Grupo_Op, nao tem pcEscolha e tem EXATAMENTE 3 botoes - Sair, Ok e
*   Conferencia, todos commandbutton soltos. Criar os 4 nomes aqui seria
*   INVENTAR botao que o legado nao tem (viola o PILAR 1) ou gerar metodo vazio
*   (proibido pela regra de completude). Os eventos dos botoes que o legado
*   REALMENTE tem sao BtnConferenciaClick/BtnOkClick/BtnSairClick, escritos na
*   Fase 4 e conferidos aqui contra os Click do dump legado.
*
*   O que esta fase ACRESCENTOU, por serem eventos do legado que a traducao
*   anterior nao cobria:
*   - LeituraWhen (Get_Leitura.When = "Set Confirm On") e LeituraLostFocus
*     (Get_Leitura.LostFocus = "Set Confirm Off"). Sem CONFIRM ON o TextBox
*     de mascara "99999999999999" sai do campo sozinho no 14o digito e o ENTER
*     do leitor de codigo de barra vaza para outro controle.
*   - o caminho do Valid legado que o KeyPress nao alcanca: sair do campo com o
*     MOUSE (clique em Ok/Conf. Auto) tambem processa a leitura em aberto, com
*     guarda de reentrancia (this_lProcessandoLeitura).
*   - SET CONFIRM OFF no Destroy: este form nao tem DataSession = 2, entao o
*     SET vale para a sessao CORRENTE e nao pode vazar para a aplicacao.
*
* Fase 8/8: Consolidacao final.
*   O template generico desta fase pede BtnBuscarClick/BtnEncerrarClick/
*   BtnSalvarClick/BtnCancelarClick, FormParaBO/BOParaForm, HabilitarCampos/
*   LimparCampos, CarregarLista/AjustarBotoesPorModo - vocabulario do
*   frmcadastro (Lista+Dados, modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR). Este
*   dialogo NAO tem PageFrame, NAO tem modo de edicao por registro e NAO
*   persiste campo-a-campo via FormParaBO/BOParaForm - ele confere etiquetas
*   por leitura de codigo de barra e grava tudo em LOTE em
*   SIGPRCPRBO.ConfirmarConferencia(). Gerar esses 9 metodos aqui seria
*   inventar funcionalidade que o legado nao tem (viola o PILAR 1) ou gerar
*   stub vazio (proibido pela regra de completude). Equivalentes REAIS ja
*   escritos nas fases anteriores:
*     BtnEncerrarClick -> BtnSairClick (Fase 4)
*     BtnSalvarClick   -> BtnOkClick (Fase 4)
*     CarregarLista    -> CarregarDados (Fase 4)
*   BtnBuscarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
*   LimparCampos/AjustarBotoesPorModo nao tem equivalente: o legado nao tem
*   busca, nao tem Cancelar (so Ok/Conf. Auto/Sair), nao tem campos de
*   cadastro persistidos por registro e nao alterna "modo" de tela.
*
*   Idem para o item "Integracao" (menu.prg): o SCX legado NAO aparece em
*   nenhum popup - eh aberto so pelo botao de conferencia da Ordem de
*   Producao (form pai ainda nao migrado), via "LParameters _Form". Registrar
*   um item de menu aqui inventaria uma rota de navegacao que o usuario do
*   legado nunca teve (viola o PILAR 1). SET PROCEDURE de BO/Form nao precisa
*   de entrada manual: config.prg ja varre classes\*BO.prg e
*   forms\operacionais\Form*.prg via ADIR (secao "Dynamic Loading").
*
*   O que esta fase efetivamente corrigiu, por ser uma lacuna real na
*   consolidacao das fases anteriores: Init() criava o BO mas nunca
*   preenchia this_cEmpresa/this_cUsuario (propriedades declaradas e usadas
*   no carregamento de etiquetas e em ConfirmarConferencia para montar
*   EmpDopNums/EmpGruEsts e para Usuars de SigMvCab/SigMvItn/SigMvHst, mas
*   sem nenhum ponto no form que as atribuisse). Sem isso, this_cEmpresa
*   ficaria "" a sessao inteira: MontarEmpDopNums(THIS.this_cEmpresa, ...)
*   geraria uma chave com os 3 primeiros caracteres em branco (PADR(""),3))
*   e o SEEK/ConsultarRegistro contra SigOpEtq.EmpDopNums NUNCA casaria - a
*   tela abriria sempre com "Nenhuma Etiqueta Selecionada", mascarando
*   qualquer etiqueta real em aberto. Corrigido lendo os globais que o
*   startup novo ja mantem (go_4c_Sistema.cCodEmpresa/gc_4c_UsuarioLogado -
*   equivalentes a _EMPR/Usuar do legado, que este form nao recebe do form
*   pai) logo apos criar o BO.
*
* Layout OPERACIONAL flat (800x400, igual ao legado) - dialogo modal SEM
* PageFrame Lista/Dados do padrao CRUD.
*==============================================================================

DEFINE CLASS FormSIGPRCPR AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 800
    Height       = 400
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)
    Caption      = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_oParent         = .NULL.

    *-- Guarda de reentrancia da leitura de codigo de barra: ValidarLeitura-
    *-- CodigoBarra exibe MsgAviso e devolve o foco ao campo, e as duas coisas
    *-- disparam LostFocus de novo - sem a flag o handler se empilharia.
    this_lProcessandoLeitura = .F.

    *==========================================================================
    * Init - Cria o BO e guarda referencia ao form pai (equivalente ao
    * "LParameters _Form" + "ThisForm.ParentForm = _Form" do legado).
    * par_oParent : form pai (Ordem de Producao) que abriu este dialogo
    *==========================================================================
    FUNCTION Init(par_oParent)
        IF VARTYPE(par_oParent) = "O"
            THIS.this_oParent = par_oParent
        ENDIF

        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCPRBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRCPRBO.", "Erro")
            RETURN .F.
        ENDIF

        *-- Equivalente a _Empr/Usuar do legado (cursores/globais Fortyus que o
        *-- startup novo NAO pre-carrega mais - CLAUDE.md: "_EMPR: LEGACY -
        *-- NUNCA usar -> go_4c_Sistema.cCodEmpresa"). Sem isto, EmpDopNums/
        *-- EmpGruEsts nasceriam com a empresa em branco (MontarEmpDopNums/
        *-- MontarEmpGruEsts nunca fariam ALLTRIM - regra de chave posicional -
        *-- e o SEEK contra SigOpEtq.EmpDopNums nunca casaria) e SigMvCab/
        *-- SigMvItn/SigMvHst gravariam Usuars em branco.
        THIS.this_oBusinessObject.this_cEmpresa = go_4c_Sistema.cCodEmpresa
        THIS.this_oBusinessObject.this_cUsuario = gc_4c_UsuarioLogado

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form
    * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste

        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.ConfigurarCabecalho()

            THIS.ConfigurarCampoData()

            THIS.ConfigurarCampoLeitura()

            THIS.ConfigurarGrid()

            THIS.ConfigurarBotoes()

            THIS.TornarControlesVisiveis(THIS)

            *-- Carga da grade: o Init legado chama "ThisForm.CarregaBars"
            *-- ANTES de vincular a Grade. Sem etiqueta em aberto o legado
            *-- apenas avisa e esconde Grade/leitura/Ok/Conferencia - a tela
            *-- CONTINUA abrindo (so com o Encerrar), por isso o retorno de
            *-- CarregarDados NAO entra em loc_lSucesso.
            *-- Em validacao de UI / modo teste nao existe form pai nem
            *-- conexao SQL: a carga eh pulada e o form abre so com o layout.
            IF !loc_lModoValidacaoOuTeste
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPRCPR.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
    * cnt_4c_Sombra: Top=0 Left=0 Width=800 Height=80 BackColor=RGB(100,100,100)
    *==========================================================================
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
            .Top        = 18
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 40
            .FontName   = "Tahoma"
            .FontSize   = 16
            .FontBold   = .T.
            .ForeColor  = RGB(0, 0, 0)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top        = 17
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 46
            .FontName   = "Tahoma"
            .FontSize   = 16
            .FontBold   = .T.
            .ForeColor  = RGB(255, 255, 255)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampoData - Label2 + Get_Data do legado (lbl_4c_Label2 +
    * txt_4c_Data). Get_Data eh READONLY no SCX (ReadOnly=.T. +
    * When retorna .f.) - o campo so EXIBE a data recebida do form pai, o
    * usuario nunca digita nela. Posicoes/propriedades EXATAS do SCX
    * legado (Label2/Get_Data).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoData()
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 110
            .Left      = 133
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Data", "TextBox")
        WITH THIS.txt_4c_Data
            .Top               = 107
            .Left              = 170
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(100, 100, 100)
            .Value             = THIS.ObterDataDoFormPai()
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ObterDataDoFormPai - Equivalente a "ThisForm.Get_Data.Value =
    * ThisForm.ParentForm.Get_Data.Value" do Init legado. O form pai (Ordem
    * de Producao) ainda nao foi migrado para a nova arquitetura; ate la,
    * tenta ler a data pelo nome novo (txt_4c_Data) e depois pelo nome
    * legado (Get_Data), e cai para DATE() se nenhum existir ou vier vazio -
    * o campo nunca abre em branco/invalido.
    *==========================================================================
    PROTECTED FUNCTION ObterDataDoFormPai()
        LOCAL loc_dData

        loc_dData = {}

        IF VARTYPE(THIS.this_oParent) = "O"
            IF PEMSTATUS(THIS.this_oParent, "txt_4c_Data", 5) AND ;
               VARTYPE(THIS.this_oParent.txt_4c_Data) = "O"
                loc_dData = ConverterParaData(THIS.this_oParent.txt_4c_Data.Value)
            ELSE
                IF PEMSTATUS(THIS.this_oParent, "Get_Data", 5) AND ;
                   VARTYPE(THIS.this_oParent.Get_Data) = "O"
                    loc_dData = ConverterParaData(THIS.this_oParent.Get_Data.Value)
                ENDIF
            ENDIF
        ENDIF

        IF EMPTY(loc_dData)
            loc_dData = DATE()
        ENDIF

        RETURN loc_dData
    ENDFUNC

    *==========================================================================
    * ConfigurarCampoLeitura - Txt_Leitura/Get_Leitura do legado
    * (lbl_4c_Txt_Leitura + txt_4c_Leitura): label + TextBox NUMERICO de
    * leitura de codigo de barra. Posicoes/propriedades EXATAS do SCX
    * legado. Visible = .F. nos dois (igual ao legado - so ficam visiveis
    * quando ha etiqueta em aberto; ver AjustarVisibilidadePorEtiquetas,
    * escrito na Fase 4, e o skip em TornarControlesVisiveis abaixo).
    *
    * lbl_4c_Txt_Leitura: o SCX declara AutoSize=.T. mas NAO WordWrap - regra
    * do projeto (#23): AutoSize=.T. eh no-op em Label criado por AddObject,
    * entao usar AutoSize=.F. + Width/Height EXATOS do dump (86x15), que ja
    * sao o auto-size calculado pelo Form Designer legado.
    *
    * txt_4c_Leitura: InputMask="99999999999999" (14 digitos, igual ao SCX) e
    * .Value = 0 (NUMERICO) - o Valid legado termina com "This.Value = 0" e a
    * BO (SIGPRCPRBO.ProcessarLeituraCodigoBarra) exige par_nCodigoBarra
    * numerico, entao o campo tem de nascer numerico, nao "".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoLeitura()
        THIS.AddObject("lbl_4c_Txt_Leitura", "Label")
        WITH THIS.lbl_4c_Txt_Leitura
            .Top       = 359
            .Left      = 133
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(243) + "digo de barra :"
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_Leitura", "TextBox")
        WITH THIS.txt_4c_Leitura
            .Top         = 355
            .Left        = 221
            .Width       = 108
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .InputMask   = "99999999999999"
            .BorderColor = RGB(100, 100, 100)
            .Value       = 0
            .Visible     = .F.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Leitura, "KeyPress",  THIS, "LeituraKeyPress")
        BINDEVENT(THIS.txt_4c_Leitura, "When",      THIS, "LeituraWhen")
        BINDEVENT(THIS.txt_4c_Leitura, "KeyPress", THIS, "LeituraLostFocus")
    ENDPROC

    *==========================================================================
    * LeituraWhen - equivalente ao When do Get_Leitura legado, que eh
    * "Set Confirm On" e MAIS NADA.
    *
    * Com SET CONFIRM OFF (default do VFP9) um TextBox sai do campo SOZINHO no
    * instante em que a mascara enche - e aqui a mascara eh "99999999999999",
    * 14 digitos, exatamente o tamanho de um codigo de barra. O leitor digita
    * os 14 digitos e SO DEPOIS manda o ENTER: sem CONFIRM ON o campo ja saiu
    * no 14o digito e o ENTER solto vai para o controle que ficou com o foco.
    * Por isso o legado liga CONFIRM ao ENTRAR no campo e desliga ao SAIR
    * (LeituraLostFocus) - nao eh detalhe de estilo, eh o que faz a leitura
    * por scanner funcionar.
    *==========================================================================
    PROCEDURE LeituraWhen()
        SET CONFIRM ON
        RETURN .T.
    ENDPROC

    *==========================================================================
    * LeituraLostFocus - equivalente ao LostFocus do Get_Leitura legado
    * ("Set Confirm Off"), MAIS o caminho do Valid legado que o KeyPress nao
    * cobre.
    *
    * O Valid legado dispara ao sair do campo por QUALQUER meio, inclusive
    * clique do mouse em Ok/Conf. Auto. Traduzir o Valid so em KeyPress
    * (ENTER/TAB) perde o codigo digitado quando o usuario sai com o mouse -
    * ele digita a etiqueta, clica em Ok e a leitura nunca eh processada.
    *
    * O "Return 0" do Valid legado (com valor preenchido) mantem o foco no
    * campo: o clique em Ok eh engolido e o usuario clica de novo. Isso eh
    * reproduzido pelo SetFocus do fim de ValidarLeituraCodigoBarra.
    *
    * SEM chamar CarregarDados/SQLEXEC aqui (regra do projeto: LostFocus
    * dispara sempre e nao serve para recarga) - so o processamento da leitura
    * em aberto, com a guarda de reentrancia.
    *==========================================================================
    PROCEDURE LeituraLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        SET CONFIRM OFF

        IF THIS.this_lProcessandoLeitura
            RETURN
        ENDIF

        IF VARTYPE(THIS.txt_4c_Leitura) != "O" OR THIS.txt_4c_Leitura.Value = 0
            RETURN
        ENDIF

        THIS.ValidarLeituraCodigoBarra()
    ENDPROC

    *==========================================================================
    * LeituraKeyPress - dispara a validacao em ENTER/TAB (BINDEVENT "Valid"
    * NAO funciona em TextBox - regra do projeto). O scanner de codigo de
    * barra tipicamente envia ENTER apos o codigo.
    *==========================================================================
    PROCEDURE LeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarLeituraCodigoBarra()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarLeituraCodigoBarra - equivalente ao Valid do Get_Leitura legado:
    * delega a SIGPRCPRBO.ProcessarLeituraCodigoBarra() (Fase 2 - ja faz o
    * SEEK/REPLACE no cursor_4c_Baixa) e traduz o status devolvido nas
    * MESMAS mensagens do legado. "This.Value = 0" do legado roda em AMBOS
    * os caminhos (achou ou nao achou) - aqui tambem, fora do DO CASE.
    *==========================================================================
    PROCEDURE ValidarLeituraCodigoBarra()
        LOCAL loc_nCodigo, loc_cResultado

        loc_nCodigo = THIS.txt_4c_Leitura.Value

        IF loc_nCodigo = 0
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Guarda de reentrancia: o MsgAviso e o SetFocus abaixo tiram e
        *-- devolvem o foco, e os dois disparam LostFocus outra vez. A flag eh
        *-- ligada APOS os RETURN de guarda acima (nenhum RETURN entre ligar e
        *-- desligar, senao ela ficaria presa em .T.).
        THIS.this_lProcessandoLeitura = .T.

        loc_cResultado = THIS.this_oBusinessObject.ProcessarLeituraCodigoBarra(loc_nCodigo)

        DO CASE
            CASE loc_cResultado = "JA_LIDO"
                MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + " Foi Lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            CASE loc_cResultado = "NAO_CADASTRADO"
                MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + "o Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            CASE loc_cResultado = "SEM_CURSOR"
                MsgAviso("Nenhuma etiqueta carregada para conferir.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
        ENDCASE

        *-- Popular/alterar o cursor da grade NAO repinta sozinho
        THIS.grd_4c_Dados.Refresh()

        THIS.txt_4c_Leitura.Value = 0

        IF THIS.Visible AND THIS.txt_4c_Leitura.Visible
            THIS.txt_4c_Leitura.SetFocus()
        ENDIF

        THIS.this_lProcessandoLeitura = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grade legado (grd_4c_Dados): 5 colunas (CodBarra,
    * CPros, Dopes, Numes, QtdeLido), ligadas ao MESMO cursor que
    * o metodo de carga de etiquetas do SIGPRCPRBO cria (this_cCursorBaixa,
    * default "cursor_4c_Baixa" - equivalente a TmpBaixa do legado).
    *
    * O cursor eh pre-criado AQUI, vazio, com a estrutura EXATA da
    * CREATE CURSOR do BO (regra do projeto: Column.ControlSource antes do
    * cursor existir derruba o Init - erro176/regra #41) - sem isso o
    * ColumnN.ControlSource abaixo estouraria "Alias is not found" e o
    * CREATEOBJECT("FormSIGPRCPR") devolveria .F. antes de qualquer etiqueta
    * ser carregada.
    *
    * Grid.Visible = .F. (legado: Grade.Visible = .F. no SCX, so vira .T.
    * quando ha etiquetas em aberto - equivalente a "ThisForm.Grade.Visible
    * = Not Eof()" no fim do CarregaBars legado). TornarControlesVisiveis
    * tem de IGNORAR este controle (ver skip abaixo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        CREATE CURSOR (loc_cCursor) ;
            (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
             Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))

        *-- Os MESMOS dois indices que o metodo de carga de etiquetas do SIGPRCPRBO
        *-- cria. Nao eh enfeite: o cursor placeholder tem de ser IDENTICO ao do
        *-- BO (campos E tags). SIGPRCPRBO.ProcessarLeituraCodigoBarra() e
        *-- ConferenciaAutomatica() fazem "SET ORDER TO TAG CodBarra" antes do
        *-- SEEK (igual ao "Set Order to CodBarra" do Valid legado) e
        *-- ConfirmarConferencia() usa "TAG GruConta" (o "Set Order to GruConta"
        *-- do Ok legado). Sem as tags aqui, o SET ORDER estoura "Table has no
        *-- index order set" FORA de qualquer TRY/CATCH - o usuario ve o
        *-- Program Error CRU do VFP no lugar do dialogo do sistema.
        INDEX ON CodBarra TAG CodBarra
        INDEX ON Grupods + Contads TAG GruConta

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 140
            .Left              = 133
            .Width             = 534
            .Height            = 207
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .ReadOnly          = .T.
            .ColumnCount       = 5
            .Visible           = .F.
        ENDWITH

        *-- Propriedades que NAO dependem do cursor (nao sao perdidas quando o
        *-- RecordSource eh reatribuido). Column.ReadOnly vem DEPOIS do
        *-- Grid.ReadOnly acima, senao o do grid sobrescreve o das colunas.
        WITH THIS.grd_4c_Dados.Column1
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column5
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        THIS.VincularGrid()
    ENDPROC

    *==========================================================================
    * VincularGrid - Liga a grade ao cursor de baixa. Equivalente ao bloco
    * "with ThisForm.Grade / .RecordSource = 'TmpBaixa' / .ColumnN.ControlSource
    * = 'TmpBaixa.<col>' / .Refresh / EndWith" que o Init legado executa DEPOIS
    * do CarregaBars.
    *
    * Tem de ser um metodo separado (e nao ficar so dentro do ConfigurarGrid)
    * porque o metodo de carga de etiquetas do SIGPRCPRBO faz USE IN + CREATE CURSOR
    * no cursor da grade: o cursor eh DESTRUIDO e recriado a cada carga, o que
    * derruba o binding do Grid. Por isso CarregarDados() chama este metodo
    * depois de cada carga.
    *
    * ORDEM CANONICA obrigatoria: RecordSource -> ControlSource -> Width ->
    * Header1.Caption. Atribuir RecordSource/ControlSource RECALCULA as larguras
    * das colunas para o default (~90) e reseta os captions dos headers, entao
    * Width e Header1.Caption tem de ser reaplicados DEPOIS - senao a grade
    * abre com colunas quadradas e headers "Header1".
    *
    * Larguras/captions/DynamicForeColor EXATOS do SCX legado (Column1..5:
    * 108/108/154/61/75; regra do DynamicForeColor: azul quando QtdeLido <> 0,
    * que eh o "Iif( TmpBaixa.QtdeLido#0, Rgb(0,0,255), Rgb(0,0,0) )" legado).
    *==========================================================================
    PROCEDURE VincularGrid()
        LOCAL loc_cCursor, loc_cCorDinamica

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        loc_cCorDinamica = "IIF(" + loc_cCursor + ".QtdeLido <> 0, RGB(0,0,255), RGB(0,0,0))"

        *-- ColumnCount so eh reatribuido se estiver diferente: REDUZIR
        *-- ColumnCount recria os objetos de coluna e destroi configuracao.
        IF THIS.grd_4c_Dados.ColumnCount != 5
            THIS.grd_4c_Dados.ColumnCount = 5
        ENDIF

        THIS.grd_4c_Dados.RecordSource = loc_cCursor

        THIS.grd_4c_Dados.Column1.ControlSource = loc_cCursor + ".CodBarra"
        THIS.grd_4c_Dados.Column2.ControlSource = loc_cCursor + ".CPros"
        THIS.grd_4c_Dados.Column3.ControlSource = loc_cCursor + ".Dopes"
        THIS.grd_4c_Dados.Column4.ControlSource = loc_cCursor + ".Numes"
        THIS.grd_4c_Dados.Column5.ControlSource = loc_cCursor + ".QtdeLido"

        THIS.grd_4c_Dados.Column1.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column2.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column3.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column4.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column5.DynamicForeColor = loc_cCorDinamica

        *-- Width DEPOIS do RecordSource/ControlSource (ordem obrigatoria)
        THIS.grd_4c_Dados.Column1.Width = 108
        THIS.grd_4c_Dados.Column2.Width = 108
        THIS.grd_4c_Dados.Column3.Width = 154
        THIS.grd_4c_Dados.Column4.Width = 61
        THIS.grd_4c_Dados.Column5.Width = 75

        *-- Header1.Caption DEPOIS do RecordSource (senao volta a "Header1")
        THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
        THIS.grd_4c_Dados.Column2.Header1.Caption = "Produto"
        THIS.grd_4c_Dados.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
        THIS.grd_4c_Dados.Column4.Header1.Caption = "N" + CHR(250) + "mero"
        THIS.grd_4c_Dados.Column5.Header1.Caption = "Qtde."

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - Carga da grade. Equivalente a "PROCEDURE carregabars" do
    * legado (SIGPRCPR.SCX), chamado pelo Init legado e por todo caminho que
    * precise repopular a grade.
    *
    * O legado monta TmpBaixa varrendo TmpEnc -> SigOpEtq -> SigMvCab/SigCdOpe;
    * essa logica INTEIRA vive no metodo de carga de etiquetas do SIGPRCPRBO
    * (Fases 1-2), entao aqui o form so: delega a carga, RE-VINCULA a grade (o
    * BO recria o cursor e o binding cai - ver VincularGrid), posiciona no
    * primeiro registro, repinta e ajusta a visibilidade dos controles.
    *
    * Fim do carregabars legado, reproduzido fielmente:
    *   Select TmpBaixa / Go Top
    *   If Eof() / =Messagebox('Nenhuma Etiqueta Selecionada Nesta Operacao!!!', 32, '')
    *   ThisForm.Grade.Visible = Not Eof()   (idem Txt_Leitura/Get_Leitura/Ok/Conferencia)
    *   ThisForm.Get_Leitura.SetFocus
    *
    * O legado NAO aborta a tela quando nao ha etiqueta: apenas avisa e esconde
    * os controles de conferencia, deixando so o Encerrar. Retorna .T. quando
    * ha pelo menos uma etiqueta em aberto.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lTemEtiquetas, loc_cCursor, loc_oErro, loc_lAvisoExibido

        loc_lTemEtiquetas = .F.
        loc_lAvisoExibido = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa

                *-- A carga pode falhar por parametro/operacao ausente. O BO
                *-- deixa o motivo em this_cMensagemErro; aqui vale MsgAviso
                *-- (validacao de uso, nao erro tecnico) e o fluxo segue para
                *-- esconder os controles, igual ao legado.
                IF !THIS.this_oBusinessObject.CarregarEtiquetasPendentes()
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lAvisoExibido = .T.
                    ENDIF
                ENDIF

                *-- Re-vincula SEMPRE: a carga de etiquetas fez
                *-- USE IN + CREATE CURSOR e o binding do Grid caiu.
                THIS.VincularGrid()

                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    GO TOP
                    loc_lTemEtiquetas = !EOF(loc_cCursor)
                ENDIF

                *-- Aviso do legado. Suprimido quando o BO ja explicou o
                *-- motivo acima, para nao empilhar dois dialogos (o legado
                *-- exibe UMA mensagem).
                IF !loc_lTemEtiquetas AND !loc_lAvisoExibido
                    MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
                             CHR(231) + CHR(227) + "o!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF

                THIS.AjustarVisibilidadePorEtiquetas(loc_lTemEtiquetas)

                *-- Popular o cursor NAO repinta a grade sozinho
                THIS.grd_4c_Dados.Refresh()

                *-- "ThisForm.Get_Leitura.SetFocus" do legado. So com o form JA
                *-- visivel: na primeira carga (dentro do InicializarForm) o
                *-- form ainda nao foi exibido e SetFocus estouraria.
                IF loc_lTemEtiquetas AND THIS.Visible AND ;
                   PEMSTATUS(THIS, "txt_4c_Leitura", 5)
                    IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
                        THIS.txt_4c_Leitura.SetFocus()
                    ENDIF
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Business Object n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel para carregar as etiquetas."
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            loc_lTemEtiquetas = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPRCPR.CarregarDados")
        ENDTRY

        RETURN loc_lTemEtiquetas
    ENDPROC

    *==========================================================================
    * AjustarVisibilidadePorEtiquetas - reproduz o bloco final do carregabars
    * legado: Grade, Txt_Leitura, Get_Leitura, Ok e Conferencia ficam visiveis
    * SOMENTE quando existe etiqueta em aberto (Visible = Not Eof()). O Sair/
    * Encerrar permanece sempre visivel (o legado nao o esconde), para o
    * usuario poder fechar o dialogo mesmo sem nada a conferir.
    *
    * lbl_4c_Txt_Leitura / txt_4c_Leitura sao criados na Fase 6
    * (ConfigurarCampoLeitura) - o PEMSTATUS antes de tocar cada um foi
    * escrito aqui na Fase 4, antes deles existirem, e continua valendo.
    *==========================================================================
    PROCEDURE AjustarVisibilidadePorEtiquetas(par_lTemEtiquetas)
        LOCAL loc_lVisivel

        loc_lVisivel = par_lTemEtiquetas

        THIS.grd_4c_Dados.Visible = loc_lVisivel

        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.Visible = loc_lVisivel
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Conferencia", 5)
            THIS.cmd_4c_Conferencia.Visible = loc_lVisivel
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c_Txt_Leitura", 5)
            THIS.lbl_4c_Txt_Leitura.Visible = loc_lVisivel
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Leitura", 5)
            THIS.txt_4c_Leitura.Visible = loc_lVisivel
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - 3 botoes standalone do legado (Conferencia/Ok/Sair),
    * mesmo padrao de dialogo OPERACIONAL do projeto (ver FormGrupo: Top=3,
    * Width/Height=75, Themes=.T.+DisabledPicture para icone renderizar com
    * Enabled=.F. - regra do projeto sobre standalone CommandButton).
    * Posicoes EXATAS do SCX legado: Conferencia Left=575, Ok Left=650,
    * Sair Left=725.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Conferencia", "CommandButton")
        WITH THIS.cmd_4c_Conferencia
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Conf. Auto"
            .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Conferencia, "Click", THIS, "BtnConferenciaClick")

        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Ok"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * BtnConferenciaClick - equivalente ao Click do "Conf. Auto" legado:
    * marca TODAS as etiquetas em aberto como conferidas (delega a
    * SIGPRCPRBO.ConferenciaAutomatica()) e repinta a grade (regra do
    * projeto: popular/alterar cursor da grade NUNCA repinta sozinho).
    *==========================================================================
    PROCEDURE BtnConferenciaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.ConferenciaAutomatica()
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOkClick - equivalente ao Click do Ok legado: confirma com o usuario,
    * delega a gravacao em lote a SIGPRCPRBO.ConfirmarConferencia() e, em
    * sucesso, reabilita o form pai e encerra o dialogo (equivalente a
    * "ThisForm.ParentForm.Enabled = .t." + "ThisForm.Release" do legado).
    * Em falha sem exception (ex.: nenhuma etiqueta conferida), o BO deixa a
    * mensagem em this_cMensagemErro e o form exibe via MsgAviso.
    *==========================================================================
    PROCEDURE BtnOkClick()
        LOCAL loc_lSucesso

        IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?", "Confirmar")
            IF PEMSTATUS(THIS, "txt_4c_Leitura", 5) AND VARTYPE(THIS.txt_4c_Leitura) = "O"
                THIS.txt_4c_Leitura.SetFocus()
            ENDIF
            RETURN
        ENDIF

        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.ConfirmarConferencia()
        ENDIF

        IF loc_lSucesso
            IF VARTYPE(THIS.this_oParent) = "O"
                THIS.this_oParent.Enabled = .T.
            ENDIF
            THIS.Release()
        ELSE
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSairClick - equivalente ao Click do Sair legado: reabilita o form
    * pai e encerra o dialogo SEM gravar nada.
    *==========================================================================
    PROCEDURE BtnSairClick()
        IF VARTYPE(THIS.this_oParent) = "O"
            THIS.this_oParent.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda
    * hierarquia. Skip: grd_4c_Dados/lbl_4c_Txt_Leitura/txt_4c_Leitura ficam
    * Visible=.F. (legado: so aparecem quando ha etiquetas em aberto - ver
    * ConfigurarGrid/ConfigurarCampoLeitura e AjustarVisibilidadePorEtiquetas,
    * chamado por CarregarDados logo depois desta varredura).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "GRD_4C_DADOS", "LBL_4C_TXT_LEITURA", "TXT_4C_LEITURA")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera referencias. DODEFAULT no fim (rebuild menu).
    *==========================================================================
    PROCEDURE Destroy()
        *-- Rede de seguranca do SET CONFIRM ON ligado por LeituraWhen: este
        *-- form NAO tem DataSession = 2, entao o SET vale para a sessao
        *-- CORRENTE e ficaria ligado no resto da aplicacao se a tela fosse
        *-- fechada com o foco ainda no campo de leitura (o LostFocus que o
        *-- desliga nao teria rodado).
        SET CONFIRM OFF

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED(THIS.this_oBusinessObject.this_cCursorBaixa)
            USE IN (THIS.this_oBusinessObject.this_cCursorBaixa)
        ENDIF

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oParent         = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Origem legada: SIGPRCPR.SCX (dialogo modal chamado por um form pai de
*                Ordem de Producao - recebe ParentForm, Get_Data.Value e
*                crSigCdPac.SigKeys do form que o abre)
* Herda de: BusinessBase
*
* Este dialogo NAO eh um CRUD de registro unico: ele confere (leitura de
* codigo de barra) etiquetas de producao ainda nao confirmadas e, ao
* confirmar, GERA em lote um cabecalho SigMvCab por combinacao Grupo/Conta
* de destino, com os detalhes SigMvItn e os DOIS historicos SigMvHst (saida
* da conta de confirmacao, entrada na conta de destino), alem de mover as
* etiquetas em SigOpEtq. Por isso a "gravacao" real fica em
* ConfirmarConferencia() (equivalente ao Click do Ok legado), e nao em
* Inserir()/Atualizar() por registro - ver comentario acima desses metodos.
*
* Fase 2/8: Metodos de negocio (equivalentes a CarregaBars/Valid do
* Get_Leitura/Click do Conferencia/Click do Ok do legado), CarregarDoCursor,
* ObterChavePrimaria.
*==============================================================================
DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Identificacao - a "entidade" persistida por este dialogo eh o
    *-- cabecalho de movimento gerado na confirmacao (equivalente ao Salvar)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "cidchaves"

    *-- Contexto recebido do form pai (fluxo modal legado via ParentForm)
    this_cEmpresa         = ""    && Empresa (Emps) - equivalente a go_4c_Sistema.cCodEmpresa do legado
    this_cUsuario         = ""    && Usuario logado (Usuar do legado)
    this_dDataBase        = {}    && Data (Get_Data.Value do form pai) - exibicao readonly
    this_cSigKey          = ""    && SigKeys (crSigCdPac.SigKeys do form pai/CarregarParametrosSistema)

    *-- Nome do cursor com as operacoes selecionadas no form pai (Dopps/Numps),
    *-- equivalente a TmpEnc do legado. O CALLER (form/BO chamador) deve
    *-- popular este cursor ANTES de chamar o metodo de carga de etiquetas.
    this_cCursorOperacoes = "cursor_4c_Operacoes"

    *-- Parametros do sistema (SigCdPam) usados na conferencia/reserva -
    *-- carregados por CarregarParametrosSistema()
    this_cGrupoConfirmacao   = ""    && GruConfs
    this_cContaConfirmacao   = ""    && ConConfs
    this_cDopeCitens         = ""    && DopeCitens (operacao de cite/transferencia parcial)
    this_cGrupoReserva       = ""    && GruReservs
    this_cContaReserva       = ""    && ConReservs
    this_cGrupoEstoque       = ""    && GrupoEsts
    this_cContaEstoque       = ""    && ContaEsts
    this_cDopeTransferencia  = ""    && TransfEncs (operacao do documento gerado ao confirmar)

    *-- Estado da grade de etiquetas (cursor equivalente a TmpBaixa do legado)
    this_cCursorBaixa      = "cursor_4c_Baixa"    && Nome fixo do cursor da grade
    this_lPossuiEtiquetas  = .F.                  && .T. quando ha pelo menos 1 etiqueta pendente

    *-- Leitura de codigo de barras
    this_cCodigoBarraLido  = ""

    *-- Linha CORRENTE do cursor de baixa (grid), populada por CarregarDoCursor
    *-- - espelha os campos de TmpBaixa do registro em foco na grade
    this_cCodigoBarraAtual    = ""
    this_cProdutoAtual        = ""
    this_cOperacaoAtual       = ""
    this_nNumeroAtual         = 0
    this_nQuantidadeAtual     = 0
    this_nQuantidadeLidaAtual = 0
    this_nSequenciaAtual      = 0
    this_cGrupoContaAtual     = ""    && Grupods da linha corrente
    this_cContaContaAtual     = ""    && Contads da linha corrente

    *-- Chave do ultimo documento de conferencia gerado (SigMvCab.cidchaves) -
    *-- usada por ObterChavePrimaria()/RegistrarAuditoria() ao confirmar
    this_cCidChaveGerada = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"

            IF EMPTY(THIS.this_cCursorOperacoes)
                THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
            ENDIF
            IF EMPTY(THIS.this_cCursorBaixa)
                THIS.this_cCursorBaixa = "cursor_4c_Baixa"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGPRCPRBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarEmpDopNums / MontarEmpGruEsts - chaves POSICIONAIS concatenadas.
    * NUNCA usar ALLTRIM nas partes: o padding faz parte da chave (regra do
    * projeto sobre chaves posicionais - Erro177). EmpDopNums = Emps(3) +
    * Dopes(20) + Str(Numes,6) = 29 (bate com char(29) do schema). EmpGruEsts
    * = Emp(3) + Grupo(10) + Conta(10) = 23 (bate com char(23) do schema).
    *==========================================================================
    PROTECTED PROCEDURE MontarEmpDopNums(par_cEmp, par_cDope, par_nNume)
        RETURN PADR(par_cEmp, 3) + PADR(par_cDope, 20) + STR(par_nNume, 6)
    ENDPROC

    PROTECTED PROCEDURE MontarEmpGruEsts(par_cEmp, par_cGrupo, par_cConta)
        RETURN PADR(par_cEmp, 3) + PADR(par_cGrupo, 10) + PADR(par_cConta, 10)
    ENDPROC

    *==========================================================================
    * ConsultarRegistro - helper generico equivalente ao
    * ThisForm.poDataMgr.CursorQuery(tabela, alias, campoChave, valor, campos)
    * do legado: SELECT <campos> FROM <tabela> WHERE <condicao> INTO CURSOR
    * <alias>. Fecha o cursor anterior (se existir) antes de reconsultar.
    * Devolve .T. apenas quando a consulta teve sucesso E trouxe pelo menos
    * 1 linha (equivalente ao "If Not Eof()" que cerca cada CursorQuery no
    * legado).
    *==========================================================================
    PROTECTED PROCEDURE ConsultarRegistro(par_cTabela, par_cAlias, par_cWhere, par_cCampos)
        LOCAL loc_cSQL, loc_nResultado, loc_cCampos

        IF USED(par_cAlias)
            USE IN (par_cAlias)
        ENDIF

        loc_cCampos = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + " WHERE " + par_cWhere

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

        RETURN (loc_nResultado >= 0) AND USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
    ENDPROC

    *==========================================================================
    * CarregarParametrosSistema - carrega os parametros de SigCdPam
    * (equivalente ao acesso direto a crSigCdPam no legado, que ja vinha
    * pre-carregado no startup do Fortyus - ver regra do projeto sobre
    * cursores globais Fortyus) e a SigKey de SigCdPac (Thisform.SigKey =
    * CrSigCdPac.SigKeys no Init legado). Chamado no inicio da
    * carga de etiquetas.
    *==========================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.ConsultarRegistro("SigCdPam", "cursor_4c_Pam", "1 = 1", ;
                    "GruConfs, ConConfs, DopeCitens, GruReservs, ConReservs, GrupoEsts, ContaEsts, TransfEncs")
                SELECT cursor_4c_Pam
                THIS.this_cGrupoConfirmacao  = TratarNulo(GruConfs, "")
                THIS.this_cContaConfirmacao  = TratarNulo(ConConfs, "")
                THIS.this_cDopeCitens        = TratarNulo(DopeCitens, "")
                THIS.this_cGrupoReserva      = TratarNulo(GruReservs, "")
                THIS.this_cContaReserva      = TratarNulo(ConReservs, "")
                THIS.this_cGrupoEstoque      = TratarNulo(GrupoEsts, "")
                THIS.this_cContaEstoque      = TratarNulo(ContaEsts, "")
                THIS.this_cDopeTransferencia = TratarNulo(TransfEncs, "")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Par" + CHR(226) + ;
                    "metros do Sistema N" + CHR(227) + "o Encontrada (SigCdPam)."
            ENDIF

            IF loc_lSucesso AND THIS.ConsultarRegistro("SigCdPac", "cursor_4c_Pac", "1 = 1", "SigKeys")
                THIS.this_cSigKey = TratarNulo(cursor_4c_Pac.SigKeys, "")
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarParametrosSistema")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CalcularQtdeBaixaCitacao - equivalente ao bloco "If Not
    * Empty(_DopeCit) ... EndIf" do CarregaBars legado. Quando existe uma
    * operacao de citacao (DopeCitens) e o documento gerador tambem existe
    * como movimento de citacao, aloca a quantidade da etiqueta contra as
    * linhas ainda nao baixadas (SigMvItn para produto simples - lnTipoEstos
    * = 1, SigMvIts+SigMvItn para produto com grade - lnTipoEstos 2/3/4) e
    * devolve a quantidade que foi baixada via citacao (_QtCit do legado).
    * Devolve -1 se uma escrita no SQL Server falhar (o caller deve abortar
    * o carregamento).
    *==========================================================================
    PROTECTED FUNCTION CalcularQtdeBaixaCitacao(par_cEmpos, par_cCPros, par_cCodCors, par_cCodTams, ;
            par_nNumeOs, par_nTipoEstos, par_nQtdeEtiqueta, par_dAgora)
        LOCAL loc_cChaveCite, loc_nBaixa, loc_nPendente, loc_nVal
        LOCAL loc_lBaixouTudo, loc_lPendenteMaior, loc_cSQL

        loc_nBaixa = par_nQtdeEtiqueta

        IF EMPTY(THIS.this_cDopeCitens)
            RETURN 0
        ENDIF

        loc_cChaveCite = THIS.MontarEmpDopNums(par_cEmpos, THIS.this_cDopeCitens, par_nNumeOs)

        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovCite", "EmpDopNums = " + EscaparSQL(loc_cChaveCite), "cidchaves")
            RETURN 0
        ENDIF

        IF par_nTipoEstos = 1
            IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItensCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + " AND CPros = " + EscaparSQL(par_cCPros), ;
                    "cIdChaves, QtBaixas, Qtds")
                SELECT cursor_4c_ItensCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF (cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas) != 0
                        loc_nPendente = cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas
                        IF loc_nPendente > loc_nBaixa
                            loc_nVal   = loc_nBaixa
                            loc_nBaixa = 0
                        ELSE
                            loc_nVal   = loc_nPendente
                            loc_nBaixa = loc_nBaixa - loc_nPendente
                        ENDIF
                        loc_lBaixouTudo = (cursor_4c_ItensCite.QtBaixas + loc_nVal = cursor_4c_ItensCite.Qtds)

                        loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                            "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + ", DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                            "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItensCite.cIdChaves)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI)" + CHR(13) + CapturarErroSQL()
                            RETURN -1
                        ENDIF
                        SQLCOMMIT(gnConnHandle)
                    ENDIF
                    SELECT cursor_4c_ItensCite
                ENDSCAN
            ENDIF
        ELSE
            IF THIS.ConsultarRegistro("SigMvIts", "cursor_4c_GradesCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + ;
                    " AND CPros = " + EscaparSQL(par_cCPros) + ;
                    " AND CodCors = " + EscaparSQL(par_cCodCors) + ;
                    " AND CodTams = " + EscaparSQL(par_cCodTams), ;
                    "cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds")
                SELECT cursor_4c_GradesCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItenCiteItn", ;
                            "EmpDopNums = " + EscaparSQL(cursor_4c_GradesCite.EmpDopNums) + ;
                            " AND CItens = " + FormatarNumeroSQL(cursor_4c_GradesCite.CItens, 0), ;
                            "cIdChaves, QtBaixas, Qtds")

                        loc_nPendente = cursor_4c_GradesCite.Qtds - cursor_4c_GradesCite.QtBaixas
                        IF loc_nPendente != 0
                            loc_lPendenteMaior = (loc_nPendente > loc_nBaixa)
                            loc_nVal        = IIF(loc_lPendenteMaior, loc_nBaixa, loc_nPendente)
                            loc_lBaixouTudo = (cursor_4c_GradesCite.QtBaixas + loc_nVal = cursor_4c_GradesCite.Qtds)

                            loc_cSQL = "UPDATE SigMvIts SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_GradesCite.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEstI2)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItenCiteItn.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI - CItens)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_nBaixa = IIF(loc_lPendenteMaior, 0, loc_nBaixa - loc_nPendente)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_GradesCite
                ENDSCAN
            ENDIF
        ENDIF

        RETURN par_nQtdeEtiqueta - loc_nBaixa
    ENDFUNC

    *==========================================================================
    * Carga das etiquetas do documento - equivalente a CarregaBars() do legado.
    * Para cada operacao (Dopps/Numps) do cursor THIS.this_cCursorOperacoes
    * (equivalente a TmpEnc, populado pelo CALLER), busca as etiquetas de
    * SigOpEtq atualmente na conta de confirmacao (GruConfs/ConConfs) e
    * calcula, para cada uma, a conta de destino (reserva do parametro, do
    * cliente ou do movimento de origem) e a parcela ja baixada por citacao
    * (CalcularQtdeBaixaCitacao), inserindo 1 ou 2 linhas por etiqueta em
    * THIS.this_cCursorBaixa (equivalente a TmpBaixa).
    *
    * Nao repinta grade nem mostra mensagem de "nenhuma etiqueta" - isso e
    * responsabilidade do Form (equivalente ao final de CarregaBars que
    * mexe em Visible/SetFocus), que deve checar THIS.this_lPossuiEtiquetas
    * apos chamar este metodo.
    *==========================================================================
    PROCEDURE CarregarEtiquetasPendentes()
        LOCAL loc_lSucesso, loc_oErro, loc_lProsseguir, loc_lFalhouCarga
        LOCAL loc_cChaveDoc, loc_dAgora
        LOCAL loc_nCBars, loc_cGrupos, loc_cContas, loc_cCPros, loc_cDopeOs, loc_cEmposE
        LOCAL loc_nNumeOs, loc_nNopsE, loc_nQtds, loc_cCodCorsE, loc_cCodTamsE
        LOCAL loc_cDopesOrigem, loc_cGrupoosOrig, loc_cContaosOrig, loc_cGrupodsOrig, loc_cContadsOrig
        LOCAL loc_lGlobalOuServico, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_nTipoEstos, loc_cCGrus, loc_cGruProds, loc_cConProds
        LOCAL loc_nQtEti, loc_nQtCit

        loc_lSucesso     = .F.
        loc_lProsseguir  = .T.
        loc_lFalhouCarga = .F.

        TRY
            IF USED(THIS.this_cCursorBaixa)
                USE IN (THIS.this_cCursorBaixa)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorBaixa) ;
                (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
                 Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))
            INDEX ON CodBarra TAG CodBarra
            INDEX ON Grupods + Contads TAG GruConta

            IF !THIS.CarregarParametrosSistema()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada para confer" + CHR(234) + "ncia."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_dAgora = DATETIME()

                SELECT (THIS.this_cCursorOperacoes)
                SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                    loc_cChaveDoc = THIS.MontarEmpDopNums(THIS.this_cEmpresa, Dopps, Numps)

                    IF !THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_Etiqueta", ;
                            "EmpDopNums = " + EscaparSQL(loc_cChaveDoc), "*")
                        SELECT (THIS.this_cCursorOperacoes)
                        LOOP
                    ENDIF

                    SELECT cursor_4c_Etiqueta
                    SCAN
                        loc_nCBars    = cursor_4c_Etiqueta.CBars
                        loc_cGrupos   = cursor_4c_Etiqueta.Grupos
                        loc_cContas   = cursor_4c_Etiqueta.Contas
                        loc_cCPros    = cursor_4c_Etiqueta.CPros
                        loc_cDopeOs   = cursor_4c_Etiqueta.DopeOs
                        loc_cEmposE   = cursor_4c_Etiqueta.Empos
                        loc_nNumeOs   = cursor_4c_Etiqueta.NumeOs
                        loc_nNopsE    = cursor_4c_Etiqueta.Nops
                        loc_nQtds     = cursor_4c_Etiqueta.Qtds
                        loc_cCodCorsE = cursor_4c_Etiqueta.CodCors
                        loc_cCodTamsE = cursor_4c_Etiqueta.CodTams

                        IF loc_cGrupos + loc_cContas != THIS.this_cGrupoConfirmacao + THIS.this_cContaConfirmacao
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF

                        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovOrigem", ;
                                "EmpDopNums = " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmposE, loc_cDopeOs, loc_nNumeOs)), "*")
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF
                        loc_cDopesOrigem = cursor_4c_MovOrigem.Dopes
                        loc_cGrupoosOrig = cursor_4c_MovOrigem.Grupoos
                        loc_cContaosOrig = cursor_4c_MovOrigem.Contaos
                        loc_cGrupodsOrig = cursor_4c_MovOrigem.Grupods
                        loc_cContadsOrig = cursor_4c_MovOrigem.Contads

                        loc_lGlobalOuServico = .F.
                        IF THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_TipoOper", ;
                                "Dopes = " + EscaparSQL(loc_cDopesOrigem), "Globalizas, Servicos")
                            loc_lGlobalOuServico = (cursor_4c_TipoOper.Globalizas = 1 OR cursor_4c_TipoOper.Servicos = 1)
                        ENDIF

                        IF loc_lGlobalOuServico
                            loc_cTGrupo = loc_cGrupoosOrig
                            loc_cTConta = loc_cContaosOrig
                        ELSE
                            loc_cTGrupo = loc_cGrupodsOrig
                            loc_cTConta = loc_cContadsOrig
                        ENDIF

                        loc_cGrupo = IIF(EMPTY(THIS.this_cGrupoReserva), loc_cTGrupo, THIS.this_cGrupoReserva)
                        loc_cConta = IIF(EMPTY(THIS.this_cContaReserva), loc_cTConta, THIS.this_cContaReserva)

                        loc_nTipoEstos = 1
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_Produto", "CPros = " + EscaparSQL(loc_cCPros), "CGrus")
                            loc_cCGrus = cursor_4c_Produto.CGrus
                            IF THIS.ConsultarRegistro("SigCdGrp", "cursor_4c_Grupo", "CGrus = " + EscaparSQL(loc_cCGrus), "TipoEstos")
                                loc_nTipoEstos = IIF(INLIST(cursor_4c_Grupo.TipoEstos, 2, 3, 4), cursor_4c_Grupo.TipoEstos, 1)
                            ENDIF
                        ENDIF

                        IF THIS.ConsultarRegistro("SigCdCli", "cursor_4c_Cliente", "IClis = " + EscaparSQL(loc_cTConta), "GruProds, ConProds")
                            loc_cGruProds = TratarNulo(cursor_4c_Cliente.GruProds, "")
                            loc_cConProds = TratarNulo(cursor_4c_Cliente.ConProds, "")
                        ELSE
                            loc_cGruProds = ""
                            loc_cConProds = ""
                        ENDIF

                        loc_nQtCit = THIS.CalcularQtdeBaixaCitacao(loc_cEmposE, loc_cCPros, loc_cCodCorsE, loc_cCodTamsE, ;
                                        loc_nNumeOs, loc_nTipoEstos, loc_nQtds, loc_dAgora)

                        IF loc_nQtCit < 0
                            THIS.this_cMensagemErro = "Falha ao processar baixa de cita" + CHR(231) + CHR(227) + ;
                                "o para a etiqueta " + TRANSFORM(loc_nCBars) + "."
                            loc_lFalhouCarga = .T.
                            SELECT cursor_4c_Etiqueta
                            EXIT
                        ENDIF

                        loc_nQtEti = loc_nQtds - loc_nQtCit

                        loc_cGrupo = IIF(EMPTY(loc_cGruProds), loc_cGrupo, loc_cGruProds)
                        loc_cConta = IIF(EMPTY(loc_cConProds), loc_cConta, loc_cConProds)

                        IF loc_nQtEti != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtEti, 0, loc_nNopsE, loc_cGrupo, loc_cConta)
                        ENDIF

                        IF loc_nQtCit != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtCit, 0, loc_nNopsE, ;
                                        THIS.this_cGrupoEstoque, THIS.this_cContaEstoque)
                        ENDIF

                        SELECT cursor_4c_Etiqueta
                    ENDSCAN

                    SELECT (THIS.this_cCursorOperacoes)

                    IF loc_lFalhouCarga
                        EXIT
                    ENDIF
                ENDSCAN

                THIS.this_lPossuiEtiquetas = (RECCOUNT(THIS.this_cCursorBaixa) > 0)
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhouCarga = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao carregar etiquetas pendentes")
        ENDTRY

        loc_lSucesso = loc_lProsseguir AND !loc_lFalhouCarga

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarLeituraCodigoBarra - equivalente ao Valid do Get_Leitura.
    * Recebe o codigo de barra digitado/lido e devolve um status para o
    * Form decidir a mensagem/refresh (o dialogo MsgAviso e o Refresh() do
    * Grid sao responsabilidade da UI, nao do BO):
    *   "VAZIO"          - nada foi digitado (o legado nao faz nada)
    *   "SEM_CURSOR"     - a carga de etiquetas ainda nao rodou
    *   "LIDO"           - encontrou a etiqueta e marcou QtdeLido = Qtde
    *   "JA_LIDO"        - encontrou a etiqueta mas ja estava conferida
    *   "NAO_CADASTRADO" - codigo de barra nao existe no cursor de baixa
    *==========================================================================
    FUNCTION ProcessarLeituraCodigoBarra(par_nCodigoBarra)
        LOCAL loc_cResultado

        loc_cResultado = "VAZIO"

        IF VARTYPE(par_nCodigoBarra) != "N" OR par_nCodigoBarra = 0
            RETURN loc_cResultado
        ENDIF

        THIS.this_cCodigoBarraLido = TRANSFORM(par_nCodigoBarra)

        IF !USED(THIS.this_cCursorBaixa)
            RETURN "SEM_CURSOR"
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra

        IF SEEK(par_nCodigoBarra)
            IF EVALUATE(THIS.this_cCursorBaixa + ".QtdeLido") = 0
                REPLACE QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)
                loc_cResultado = "LIDO"
            ELSE
                loc_cResultado = "JA_LIDO"
            ENDIF
        ELSE
            loc_cResultado = "NAO_CADASTRADO"
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * ConferenciaAutomatica - equivalente ao Click do botao "Conf. Auto"
    * (Conferencia): marca TODAS as etiquetas em aberto como conferidas.
    *==========================================================================
    PROCEDURE ConferenciaAutomatica()
        IF !USED(THIS.this_cCursorBaixa)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra
        REPLACE ALL QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia a linha CORRENTE de THIS.this_cCursorBaixa
    * (equivalente a TmpBaixa) para as properties this_*Atual, usadas pelo
    * Form para exibir/realcar a linha em foco na grade.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigoBarraAtual    = TRANSFORM(TratarNulo(CodBarra, 0))
            THIS.this_cProdutoAtual        = TratarNulo(CPros, "")
            THIS.this_cOperacaoAtual       = TratarNulo(Dopes, "")
            THIS.this_nNumeroAtual         = TratarNulo(Numes, 0)
            THIS.this_nQuantidadeAtual     = TratarNulo(Qtde, 0)
            THIS.this_nQuantidadeLidaAtual = TratarNulo(QtdeLido, 0)
            THIS.this_nSequenciaAtual      = TratarNulo(Nops, 0)
            THIS.this_cGrupoContaAtual     = TratarNulo(Grupods, "")
            THIS.this_cContaContaAtual     = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave do documento de confirmacao gerado por
    * ConfirmarConferencia() (SigMvCab.cidchaves). So fica preenchida DEPOIS
    * de uma confirmacao com sucesso - eh o que RegistrarAuditoria() usa.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaveGerada
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() - este dialogo NAO grava um
    * registro por vez: a "gravacao" real (equivalente ao Click do Ok
    * legado) e uma confirmacao em LOTE que cria 1 cabecalho SigMvCab por
    * combinacao Grupods/Contads presente no cursor de etiquetas conferidas,
    * mais os detalhes SigMvItn/SigMvHst e o reposicionamento das etiquetas
    * em SigOpEtq - por isso vive em ConfirmarConferencia(), que chama
    * THIS.RegistrarAuditoria() ao final com sucesso. O comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao
    * isolados) ja eh o correto para este dialogo.
    *==========================================================================

    *==========================================================================
    * ConfirmarConferencia - equivalente ao Click do Ok. Para cada
    * combinacao Grupods/Contads com QtdeLido <> 0 no cursor de baixa, gera
    * 1 cabecalho SigMvCab (documento TransfEncs), e para cada etiqueta
    * conferida daquele grupo/conta grava o detalhe SigMvItn e os 2
    * historicos SigMvHst (S = saida da conta de confirmacao, E = entrada
    * na conta de destino), recalculando custo/posicao (fRecalculaP/
    * fRecalculaC) e movendo a etiqueta em SigOpEtq para o grupo/conta de
    * destino. Tudo dentro de uma unica transacao manual (Transactions=2
    * neste ambiente): falha em qualquer passo faz SQLROLLBACK, sucesso
    * completo faz SQLCOMMIT + RegistrarAuditoria.
    *==========================================================================
    FUNCTION ConfirmarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_lFalhou, loc_lProsseguir
        LOCAL loc_cDope, loc_nNume, loc_cChaveCab, loc_cGrupoCab, loc_cContaCab
        LOCAL loc_nItem, loc_cSQL, loc_dAgora, loc_cCidC, loc_nSeq, loc_cCidCE, loc_nSeqE
        LOCAL loc_cCunis, loc_cDpros, loc_cCodCors, loc_cCodTams, loc_cEmpos
        LOCAL loc_nCodBarraLin, loc_cCProsLin, loc_nQtdeLidaLin

        loc_lSucesso    = .F.
        loc_lFalhou     = .F.
        loc_lProsseguir = .T.

        IF !USED(THIS.this_cCursorBaixa) OR RECCOUNT(THIS.this_cCursorBaixa) = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " etiquetas carregadas para confirmar."
            RETURN .F.
        ENDIF

        TRY
            loc_dAgora = DATETIME()
            loc_cDope  = THIS.this_cDopeTransferencia

            IF USED("cursor_4c_ConfCabec")
                USE IN cursor_4c_ConfCabec
            ENDIF
            SELECT DISTINCT Grupods, Contads ;
                FROM (THIS.this_cCursorBaixa) ;
                WHERE QtdeLido != 0 ;
                INTO CURSOR cursor_4c_ConfCabec READWRITE

            IF RECCOUNT("cursor_4c_ConfCabec") = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta foi conferida - realize a leitura antes de confirmar."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_ConfCabec
                SCAN
                    loc_cGrupoCab = cursor_4c_ConfCabec.Grupods
                    loc_cContaCab = cursor_4c_ConfCabec.Contads

                    loc_nNume     = fGerUniqueKey(THIS.this_cEmpresa + loc_cDope)
                    loc_cChaveCab = THIS.MontarEmpDopNums(THIS.this_cEmpresa, loc_cDope, loc_nNume)

                    *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
                    *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
                    *-- com limite de 8192 caracteres ("Line is too long" em runtime).
                    *-- Colunas NOT NULL sem property nesta rotina (regra #22): char = EscaparSQL(""),
                    *-- numeric = FormatarNumeroSQL(0, <dec>), bit = "0".
                    loc_cSQL = "INSERT INTO SigMvCab ("
                    loc_cSQL = loc_cSQL + "Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos,"
                    loc_cSQL = loc_cSQL + "Contaos, Grupods, Contads, EmpDopNums, cidchaves, DtAlts, EmpGopNums, npedclis,"
                    loc_cSQL = loc_cSQL + "acres, antecs, chksubn, codpeds, desc2s, descs, devols, empds,"
                    loc_cSQL = loc_cSQL + "grresps, grupos, grvends, iclis, ifors, locals, lotechqs, lprecos,"
                    loc_cSQL = loc_cSQL + "ncarnecs, nemps, nops, notas, nrcons, ntrans, numolds, opers,"
                    loc_cSQL = loc_cSQL + "resps, tabds, tpfats, transps, usuals, usulibs, valacres, valdes2s,"
                    loc_cSQL = loc_cSQL + "valdescs, valdevs, valencs, valinis, valos, valservs, valvars, vars,"
                    loc_cSQL = loc_cSQL + "vends, cotusus, espes, qtdes, lcancelas, cofs, livros, chkbxparcs,"
                    loc_cSQL = loc_cSQL + "ecfs, codobs, dgopes, trfisicos, utilizados, valndevs, valobxs, noforms,"
                    loc_cSQL = loc_cSQL + "auditors, contaes, localents, localizas, chkpagos, chkpgs, codtrans, empdnbxs,"
                    loc_cSQL = loc_cSQL + "empdncrds, obsagends, operadors, vcompensas, motdscs, ndeclaras, numbalds, numbals,"
                    loc_cSQL = loc_cSQL + "priors, procbals, procdbal, protats, usupagos, ultgrvs, moeits, rnops,"
                    loc_cSQL = loc_cSQL + "impress, pstatus, valvarps, cifccfs, cupfis, idconta, ncupoms, status,"
                    loc_cSQL = loc_cSQL + "valtrans, impcpfs, ccfgnfs, fpubls, jobs, ptax1s, ptax2s, ptax3s,"
                    loc_cSQL = loc_cSQL + "obscabmovs, codobs2"
                    loc_cSQL = loc_cSQL + ") VALUES ("
                    loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + FormatarNumeroSQL(loc_nNume, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuario) + ", " + EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", " + EscaparSQL(loc_cChaveCab) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(fUniqueIds()) + ", " + FormatarDataSQL(loc_dAgora) + ", " + EscaparSQL(THIS.MontarEmpDopNums(THIS.this_cEmpresa, "", 0)) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 4) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 4) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + "0" + ", " + "0" + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + "0" + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + "0" + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", " + EscaparSQL("")
                    loc_cSQL = loc_cSQL + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvCab)" + CHR(13) + CapturarErroSQL()
                        loc_lFalhou = .T.
                        SELECT cursor_4c_ConfCabec
                        EXIT
                    ENDIF

                    THIS.this_cCidChaveGerada = loc_cChaveCab

                    loc_nItem = 0
                    SELECT (THIS.this_cCursorBaixa)
                    SCAN FOR Grupods + Contads == loc_cGrupoCab + loc_cContaCab AND QtdeLido != 0
                        loc_nItem        = loc_nItem + 1
                        loc_nCodBarraLin = CodBarra
                        loc_cCProsLin    = CPros
                        loc_nQtdeLidaLin = QtdeLido

                        loc_cCunis = ""
                        loc_cDpros = ""
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_ProdutoConf", "CPros = " + EscaparSQL(loc_cCProsLin), "Cunis, Dpros")
                            loc_cCunis = TratarNulo(cursor_4c_ProdutoConf.Cunis, "")
                            loc_cDpros = TratarNulo(cursor_4c_ProdutoConf.Dpros, "")
                        ENDIF

                        loc_cCodCors = ""
                        loc_cCodTams = ""
                        loc_cEmpos   = ""
                        IF THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_EtiquetaConf", ;
                                "CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0), "CodCors, CodTams, Empos")
                            loc_cCodCors = TratarNulo(cursor_4c_EtiquetaConf.CodCors, "")
                            loc_cCodTams = TratarNulo(cursor_4c_EtiquetaConf.CodTams, "")
                            loc_cEmpos   = TratarNulo(cursor_4c_EtiquetaConf.Empos, "")
                        ENDIF

                        loc_cSQL = "INSERT INTO SigMvItn ("
                        loc_cSQL = loc_cSQL + "CItens, Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros,"
                        loc_cSQL = loc_cSQL + "Opers, CodBarras, EmpDopNums, cIdChaves, DtAlts, aqtds, descvals, etiesps,"
                        loc_cSQL = loc_cSQL + "fators, fatvals, fvals, iconfs, locals, moedas, moefats, moevals,"
                        loc_cSQL = loc_cSQL + "notas, nrcons, ntrans, numolds, pesos, qtbaixas, qtbxprods, qtprods,"
                        loc_cSQL = loc_cSQL + "totas, tpesos, unitembs, units, univals, vcoms, aliqs, sitribs,"
                        loc_cSQL = loc_cSQL + "tpipis, valipis, aliqicms, valdescs, empos, moevs, utilizas, ncodigos,"
                        loc_cSQL = loc_cSQL + "qtreservas, nlotes, baseicms, chksubn, unit2s, usulibs, valrats, codlprecs,"
                        loc_cSQL = loc_cSQL + "cunips, motdscs, tipos, unitinfs, cpro2s, abrevis, bcicmss, bcipis,"
                        loc_cSQL = loc_cSQL + "icms, icmss, pdescs, nchvtbds, idpro, unitorigs, origmercs, baseicm2s,"
                        loc_cSQL = loc_cSQL + "baseicm3s, baseipi2s, baseipi3s, cfops, ratdacs, ratfrts, raticmds, raticms,"
                        loc_cSQL = loc_cSQL + "ratsegs, sittricms, aliqiis, citem2, taxaiis, vcofins, vpis, aliqorigs,"
                        loc_cSQL = loc_cSQL + "lcancelas, compris, codfabs, nadis, niadis, aliqcofs, aliqpis, cssl,"
                        loc_cSQL = loc_cSQL + "inss, irrf, iss, valbases, localos"
                        loc_cSQL = loc_cSQL + ") VALUES ("
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nItem, 0) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cCunis) + ", " + EscaparSQL(loc_cDpros) + ", " + EscaparSQL("S") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cChaveCab) + ", " + EscaparSQL(fUniqueIds()) + ", "
                        loc_cSQL = loc_cSQL + FormatarDataSQL(loc_dAgora) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + "0" + ", " + "0" + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 4) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + "0" + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("")
                        loc_cSQL = loc_cSQL + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvItn)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        loc_nSeq  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidC = DTOS(DATE()) + "S" + TRANSFORM(loc_nSeq, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst ("
                        loc_cSQL = loc_cSQL + "Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros,"
                        loc_cSQL = loc_cSQL + "Qtds, Opers, Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves,"
                        loc_cSQL = loc_cSQL + "EmpDopNums, EmpGruEsts, OriDopNums, Seqs, sqtds, teqtds, totas, tsqtds,"
                        loc_cSQL = loc_cSQL + "units, moedas, numolds, ntrans, locals, unitmeds, moedmeds, recalmeds,"
                        loc_cSQL = loc_cSQL + "auditors, pesos, spesos, unitmfis, bcipis, medipis"
                        loc_cSQL = loc_cSQL + ") VALUES ("
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("S") + ", " + EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + EscaparSQL(loc_cCodTams) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidC) + ", " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao)) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeq, 0) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 6)
                        loc_cSQL = loc_cSQL + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - S)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_nSeqE  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidCE = DTOS(DATE()) + "E" + TRANSFORM(loc_nSeqE, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst ("
                        loc_cSQL = loc_cSQL + "Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros,"
                        loc_cSQL = loc_cSQL + "Qtds, Opers, Grupos, Estos, CodBarras, CodCors, CodTams, CidChaves,"
                        loc_cSQL = loc_cSQL + "EmpDopNums, EmpGruEsts, OriDopNums, Seqs, sqtds, teqtds, totas, tsqtds,"
                        loc_cSQL = loc_cSQL + "units, moedas, numolds, ntrans, locals, unitmeds, moedmeds, recalmeds,"
                        loc_cSQL = loc_cSQL + "auditors, pesos, spesos, unitmfis, bcipis, medipis"
                        loc_cSQL = loc_cSQL + ") VALUES ("
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("E") + ", " + EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + EscaparSQL(loc_cCodTams) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidCE) + ", " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, loc_cGrupoCab, loc_cContaCab)) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeqE, 0) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 6)
                        loc_cSQL = loc_cSQL + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - E)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, loc_cGrupoCab, loc_cContaCab, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_cSQL = "UPDATE SigOpEtq SET Grupos = " + EscaparSQL(loc_cGrupoCab) + ", " + ;
                            "Contas = " + EscaparSQL(loc_cContaCab) + ", DtMovs = " + FormatarDataSQL(loc_dAgora) + " " + ;
                            "WHERE CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigOpEtq)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        SELECT (THIS.this_cCursorBaixa)
                    ENDSCAN

                    SELECT cursor_4c_ConfCabec

                    IF loc_lFalhou
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaP(.T., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClP)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaC(.T., .T., .F., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClC)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhou = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao confirmar confer" + CHR(234) + "ncia")
        ENDTRY

        IF !loc_lProsseguir OR loc_lFalhou
            SQLROLLBACK(gnConnHandle)
            loc_lSucesso = .F.
        ELSE
            SQLCOMMIT(gnConnHandle)
            THIS.RegistrarAuditoria("CONFIRMAR")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


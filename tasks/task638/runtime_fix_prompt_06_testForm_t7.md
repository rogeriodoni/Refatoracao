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
[2026-10-16 11:15:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-16 11:15:31] [INFO] Config FPW: (nao fornecido)
[2026-10-16 11:15:31] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-16 11:15:31] [INFO] Timeout: 300 segundos
[2026-10-16 11:15:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a3hy0mwj.prg
[2026-10-16 11:15:31] [INFO] Conteudo do wrapper:
[2026-10-16 11:15:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrMlu', 'C:\4c\tasks\task638\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrMlu', 'C:\4c\tasks\task638\logs\06_testForm.log'
QUIT

[2026-10-16 11:15:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a3hy0mwj.prg
[2026-10-16 11:15:31] [INFO] VFP output esperado em: C:\4c\tasks\task638\vfp_output.txt
[2026-10-16 11:15:31] [INFO] Executando Visual FoxPro 9...
[2026-10-16 11:15:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a3hy0mwj.prg
[2026-10-16 11:15:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a3hy0mwj.prg
[2026-10-16 11:15:31] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrMlu
Inicio: 16/10/2026 11:15:31

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 16/10/2026 11:18:48
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-16 11:18:48] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-16 11:18:48] [INFO] VFP9 finalizado em 197.4045828 segundos
[2026-10-16 11:18:48] [INFO] Exit Code: 
[2026-10-16 11:18:48] [INFO] 
[2026-10-16 11:18:48] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-16 11:18:48] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a3hy0mwj.prg
[2026-10-16 11:18:48] [INFO] 
[2026-10-16 11:18:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-16 11:18:48] [INFO] * Auto-generated wrapper for parameters
[2026-10-16 11:18:48] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-16 11:18:48] [INFO] * Parameters: 'FormSigPrMlu', 'C:\4c\tasks\task638\logs\06_testForm.log'
[2026-10-16 11:18:48] [INFO] 
[2026-10-16 11:18:48] [INFO] * Anti-dialog protections for unattended execution
[2026-10-16 11:18:48] [INFO] SET SAFETY OFF
[2026-10-16 11:18:48] [INFO] SET RESOURCE OFF
[2026-10-16 11:18:48] [INFO] SET TALK OFF
[2026-10-16 11:18:48] [INFO] SET NOTIFY OFF
[2026-10-16 11:18:48] [INFO] SYS(2335, 0)
[2026-10-16 11:18:48] [INFO] 
[2026-10-16 11:18:48] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrMlu', 'C:\4c\tasks\task638\logs\06_testForm.log'
[2026-10-16 11:18:48] [INFO] QUIT
[2026-10-16 11:18:48] [INFO] 
[2026-10-16 11:18:48] [INFO] === Fim do Wrapper.prg ===
[2026-10-16 11:18:48] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg):
*==============================================================================
* FormSigPrMlu.prg - Unificacao de Mala Direta
* Origem: SIGPRMLU.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL (layout proprio, sem PageFrame) - lista as malas diretas
* cadastradas (SigMlItn, grid com checkbox de selecao na Column1) e permite
* unificar duas ou mais malas marcadas numa mala NOVA (nome digitado em
* cntNova.getNova), via SigPrMluBO.
*
* Legado (Init): Lparameters pCodigos - parametro declarado mas NUNCA usado no
* corpo (nao filtra cursor nem muda comportamento) - por isso o Init migrado
* nao recebe parametro nenhum.
*==============================================================================
* Fases 4-8 (Grid/Checkbox/CommandGroups/container "Nome da Unificacao",
* carga/ordenacao da grade e Processamento da unificacao) ja entregues abaixo.
*
* FASE 6 (campos restantes e lookups):
*  - LOOKUP: nenhum. O dump original (SigPrMlu_form_codigo_fonte.txt) nao tem
*    fwBuscaExt/fwBuscaSel/fwBuscaInt, mAddColuna, sigacess() nem Acesso*() -
*    o unico CreateObject do form eh o fSqlConector (gerenciador de dados, ja
*    coberto pelo BO). Inventar lookup aqui violaria o PILAR 1 e a regra
*    "NUNCA inventar tabelas de lookup que nao existem no original".
*  - CAMPOS: o unico campo DIGITAVEL do legado eh cntNova.getNova ("Nome da
*    Unificacao") -> cnt_4c_Nova.txt_4c_Nova, criado em
*    ConfigurarContainerNova() com Format = "K" e MaxLength = 20 transcritos
*    do SCX (regra #49). Os 5 Text1 das Column2..Column6 sao celulas da grade
*    e sao somente-leitura no legado (PROCEDURE When / Return(.f.)),
*    reproduzidas como Column.ReadOnly = .T. em ConfigurarGridDados().
*  - REGRA DO CAMPO: o getNova nao tem Valid/When/LostFocus - a regra que o
*    governa mora DENTRO do cmdProcessar.Click do legado (tres guards:
*    nenhuma mala marcada, uma so mala marcada, nome em branco). Ela eh de
*    QUEM ela governa, nao de quem a chama: entregue nesta fase como o funil
*    unico PUBLIC ValidarProcessamento(), que BtnProcessarClick apenas chama.
*
* FASE 7 (eventos principais dos botoes):
*  - NAO EXISTEM BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*    BtnExcluirClick porque o legado NAO TEM CRUD - e inventa-los violaria o
*    PILAR 1. Prova, medida no dump e no layout.json da task:
*      . "Class: form" PURO - nao herda de frmcadastro (de onde viria a barra
*        Incluir/Alterar/Visualizar/Excluir/Procurar), nem de frmrelatorio.
*      . nenhum objeto chamado cmdIncluir/cmdAlterar/cmdVisualizar/cmdExcluir,
*        nenhum Grupo_Op e nenhuma referencia a pcEscolha no dump inteiro.
*      . a superficie de botao do SCX sao 3 CommandGroup e nada mais:
*        cmdProcessar (ButtonCount 1, "btnProcessar"), Commandgroup2
*        (ButtonCount 1, "btnsair") e cmdBtnGrade (ButtonCount 2, "btnMarcar"
*        + "btnDesmarcar") = 4 botoes, TODOS com handler nesta classe
*        (BtnProcessarClick, BtnEncerrarClick, CmdSelTudoClick, CmdApagaTudoClick).
*    Esta tela nao cadastra mala direta nenhuma: ela SELECIONA malas existentes
*    (checkbox da Column1) e as UNIFICA numa nova. Quem inclui/altera/exclui
*    mala direta eh o cadastro de Mala Direta, outro form.
*  - O que esta fase entregou de verdade nos eventos dos botoes:
*      . MarcarTodasAs() - funil unico dos DOIS botoes do cmdBtnGrade, que no
*        legado compartilham UM Click so (o indice do botao eh o proprio valor
*        gravado), com UPDATE-SQL no lugar de REPLACE ALL para nao jogar o
*        ponteiro do cursor em EOF e fazer a grade saltar para o fim.
*      . BtnProcessarClick() - reabilitacao INCONDICIONAL do botao Processar
*        depois do ENDTRY, equivalente aos quatro "This.Enabled = .t." que o
*        legado repete em cada caminho de saida do cmdProcessar.Click.
*      . ValidarProcessamento() - TRY/CATCH que REPROVA quando a validacao nao
*        consegue concluir, em vez de deixar o Program Error cru do VFP subir.
*
* FASE 8 (eventos auxiliares e consolidacao final):
*  - RENOMEADOS para o nome CANONICO do projeto, que eh o VERBO da acao e nao
*    o nome do objeto legado: CmdProcessarClick -> BtnProcessarClick (botao de
*    acao, Caption "\<Processar", objeto legado cmdProcessar/btnProcessar) e
*    CmdSairClick -> BtnEncerrarClick (Caption "Encerrar", objeto legado
*    btnsair). CmdSelTudoClick/CmdApagaTudoClick FICAM com o prefixo Cmd: nao
*    sao acao da tela, sao os dois botoes que marcam/desmarcam a grade, e esse
*    eh o nome que o projeto ja usa para eles (FormSigPrSlp, Formsigrecmc,
*    FormSIGREEQR).
*  - FormParaBO() / BOParaForm() - FONTE UNICA da transferencia tela <-> BO.
*    Nao sao convencao de Page2 de Dados importada a forca: o bloco EXISTE no
*    legado, so nao tem esse nome (o cmdProcessar.Click le getNova.Value e
*    conta as malas marcadas, e o Processamento reusa os dois). Depois desta
*    fase o TextBox eh lido em UM lugar so - FormParaBO - e ValidarProcessamento
*    e ProcessarUnificacao consomem as properties do BO.
*  - LimparCampos() - zera o BO (SigPrMluBO.LimparDados, criado nesta fase) e
*    deixa o BOParaForm refletir o BO vazio no campo. Substitui o
*    "txt_4c_Nova.Value = ''" solto que havia no fim da unificacao.
*  - AjustarBotoesPorModo() - funil unico do Enabled do botao Processar,
*    derivado de this_cModoAtual ("LISTA"/"PROCESSANDO"), que ate a fase 7
*    estava declarado e nunca era usado. Substitui as duas atribuicoes diretas
*    a cmd_4c_Processar.Enabled (regra #40).
*  - CORRIGIDO: o toggle do checkbox da grade estava no MouseDown, com o
*    MouseUp so suprimindo o default - invertido em relacao ao legado
*    (MouseDown so suprime o default; MouseUp e quem alterna, simulando
*    Enter/tecla 13 como o legado faz de dentro do seu proprio MouseUp).
*
*  O QUE NAO SE APLICA, e por que (dump legado conferido, nao presumido):
*  - Handler de CANCELAR: o SCX nao tem botao de cancelar/descartar. A
*    superficie de botao do legado sao os 4 botoes dos 3 CommandGroup, todos
*    com handler aqui. Nao ha Page2 de Dados nem modo de edicao a abandonar -
*    o unico caminho de saida eh o Encerrar, e ele apenas fecha
*    (btnsair.Click = "ThisForm.Release"). Inventar o botao violaria o PILAR 1
*    e escrever o metodo vazio seria stub (proibido pela regra de completude).
*  - HabilitarCampos(): nao existe no legado estado em que campo ou grade
*    mudem de Enabled/ReadOnly. Os unicos "PROCEDURE When" do SCX sao os cinco
*    "Return(.f.)" das celulas Column2..Column6, ja migrados como
*    Column.ReadOnly = .T. em ConfigurarGridDados, e o unico Enabled que o
*    legado move em runtime eh o do PROPRIO botao Processar - que virou
*    AjustarBotoesPorModo. Implementar o metodo aqui seria ou um no-op (stub)
*    ou a invencao de um estado desabilitado que o legado nao tem.
*  - BtnBuscarClick(): a tela nao tem busca. A grade carrega a tabela inteira
*    ("Select 0 as SelImp, * From SigMlItn", sem Where no Init legado) e a
*    ordenacao por clique no cabecalho ja esta em OrdenarGrade/GradeHeader*Click.
*==============================================================================

DEFINE CLASS FormSigPrMlu AS FormBase

    *-- Dimensoes (PILAR 1: identico ao legado SIGPRMLU.SCX)
    Width       = 794
    Height      = 533
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    BorderStyle = 2
    DataSession = 2
    KeyPreview  = .T.
    Caption     = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado da tela. O legado NAO tem pcEscolha (nao herda de frmcadastro):
    *-- os estados reais sao "LISTA" (grade de malas disponivel para selecao)
    *-- e "PROCESSANDO" (unificacao em curso, com This.Enabled = .f. no
    *-- CommandGroup cmdProcessar - grade e botoes travados durante o SCAN).
    this_cModoAtual = "LISTA"

    *-- Equivalente a ThisForm.GridOrder do legado (AcertaGrades/MontaGrades):
    *-- coluna de ordenacao corrente da grade (2=Codigos, 3=Descs, 4=UsuIns,
    *-- 5=DatIns). Legado inicializa GridOrder = 2 no Init.
    this_nGridOrder = 2

    *==========================================================================
    * Init - Legado: "Lparameters pCodigos" (declarado mas nunca referenciado
    * no corpo do metodo nem em nenhum outro ponto do form) - nao ha parametro
    * real para repassar.
    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Sombra com os labels de titulo
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80, BackColor=100,100,100
    *   lblSombra  Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0 (sombra)
    *   lblTitulo  Top=17, Left=10, Width=769, Height=46, ForeColor=255,255,255
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_oErro
        TRY
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
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGridDados - Grade "grdselecoes" do legado: lista as malas
    * diretas cadastradas (SigMlItn), com checkbox de selecao na Column1
    * (SelImp) para escolher quais malas serao unificadas pelo cmd_4c_Processar.
    * ControlSource/RecordSource ficam para CarregarLista() - cursor_4c_Dados
    * ainda nao existe aqui (regra #41 do CLAUDE.md).
    * Original: grdselecoes Top=159 Left=49 Width=660 Height=324
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridDados()
    *==========================================================================
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top               = 159
            .Left              = 49
            .Width             = 660
            .Height            = 324
            .ColumnCount       = 6
            .FontName          = "Tahoma"
            .FontSize          = 8
            .HeaderHeight      = 16
            .RowHeight         = 16
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH

        *-- Column1: checkbox de marcacao (SelImp). Pattern #185/#186
        *-- (Erro146): CheckBox de Column exige AddObject + CurrentControl +
        *-- Sparse = .F., e NAO alterna sem os 4 handlers de evento abaixo.
        WITH loc_oGrid.Column1
            .Width     = 15
            .ReadOnly  = .F.
            .Sparse    = .F.
            .Movable   = .F.
            .Resizable = .F.
            .AddObject("chk_4c_Check1", "CheckBox")
            .chk_4c_Check1.Top       = 9
            .chk_4c_Check1.Left      = 2
            .chk_4c_Check1.Height    = 17
            .chk_4c_Check1.Width     = 22
            .chk_4c_Check1.FontName  = "Tahoma"
            .chk_4c_Check1.FontSize  = 8
            .chk_4c_Check1.Alignment = 0
            .chk_4c_Check1.Caption   = ""
            .chk_4c_Check1.Value     = 0
            .chk_4c_Check1.ReadOnly  = .F.
            .chk_4c_Check1.Visible   = .T.
            .CurrentControl    = "chk_4c_Check1"
            .Header1.Caption   = ""
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH
        THIS.BindToggleSelecao(THIS.grd_4c_Dados.Column1.chk_4c_Check1)

        *-- Column2: Codigos
        WITH loc_oGrid.Column2
            .Width     = 80
            .ReadOnly  = .T.
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Courier New"
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
            WITH loc_oGrid.Column2.Text1
                .FontName = "Courier New"
                .FontSize = 8
                .Margin   = 0
            ENDWITH
        ENDIF

        *-- Column3: Descs
        WITH loc_oGrid.Column3
            .Width     = 260
            .ReadOnly  = .T.
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Courier New"
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column3, "Text1", 5)
            WITH loc_oGrid.Column3.Text1
                .FontName = "Courier New"
                .FontSize = 8
            ENDWITH
        ENDIF

        *-- Column4: UsuIns
        WITH loc_oGrid.Column4
            .Width     = 120
            .ReadOnly  = .T.
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Courier New"
            .Header1.Caption   = "Usu" + CHR(225) + "rio"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column4, "Text1", 5)
            WITH loc_oGrid.Column4.Text1
                .FontName = "Courier New"
                .FontSize = 8
                .Margin   = 0
            ENDWITH
        ENDIF

        *-- Column5: DatIns
        WITH loc_oGrid.Column5
            .Width     = 80
            .ReadOnly  = .T.
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Courier New"
            .Header1.Caption   = "Dt.Entrada"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column5, "Text1", 5)
            WITH loc_oGrid.Column5.Text1
                .FontName = "Courier New"
                .FontSize = 8
                .Margin   = 0
            ENDWITH
        ENDIF

        *-- Column6: NRegis
        WITH loc_oGrid.Column6
            .Width     = 80
            .ReadOnly  = .T.
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Courier New"
            .Header1.Caption   = "N.Registros"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column6, "Text1", 5)
            WITH loc_oGrid.Column6.Text1
                .FontName = "Courier New"
                .FontSize = 8
                .Margin   = 0
            ENDWITH
        ENDIF

        *-- Ordenacao por clique no cabecalho (legado: Column2..5.Header1.Click
        *-- chama AcertaGrades(N) - Column1/Column6 nao tem Click no dump)
        BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GradeHeaderCodigosClick")
        BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GradeHeaderDescsClick")
        BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GradeHeaderUsuInsClick")
        BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "GradeHeaderDatInsClick")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes de acao da tela (equivalentes aos 3
    * CommandGroups do legado - cmdProcessar/Commandgroup2/cmdBtnGrade, cada
    * um com ButtonCount 1 ou 2); migrados para CommandButton standalone,
    * preservando a geometria ABSOLUTA (grupo.Left/Top + botao.Left/Top do
    * dump) e Caption/Picture/cor de cada botao interno.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
    *==========================================================================
        *-- cmdProcessar (Command1/btnProcessar): grupo Left=637 Top=-2,
        *-- botao Left=5 Top=5 -> absoluto 642,3. Themes=.T.+DisabledPicture
        *-- SAO EXCECAO ao legado (Themes=.F.): este botao e desabilitado em
        *-- runtime (This.Enabled=.f. durante o processamento) e sem Themes=.T.
        *-- o icone desaparece com Enabled=.F. (regra #99 do CLAUDE.md).
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 642
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "\<Processar"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Commandgroup2 (Command1/btnsair): grupo Left=712 Top=-2, botao
        *-- Left=5 Top=5 -> absoluto 717,3. Themes=.F. como no legado (nunca
        *-- desabilitado em runtime).
        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top        = 3
            .Left       = 717
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnEncerrarClick")

        *-- cmdBtnGrade (Command1/btnMarcar + Command2/btnDesmarcar): grupo
        *-- Left=715 Top=280. Command1 Left=5 Top=5 -> absoluto 720,285.
        *-- Command2 Left=5 Top=45 -> absoluto 720,325.
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 285
            .Left        = 720
            .Width       = 40
            .Height      = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .Caption     = ""
            .ToolTipText = "Seleciona Tudo"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        THIS.AddObject("cmd_4c_ApagaTudo", "CommandButton")
        WITH THIS.cmd_4c_ApagaTudo
            .Top         = 325
            .Left        = 720
            .Width       = 40
            .Height      = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "onebit_33.ico"
            .Caption     = ""
            .ToolTipText = "Apaga Tudo"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_ApagaTudo, "Click", THIS, "CmdApagaTudoClick")
    ENDPROC

    *==========================================================================
    * ConfigurarContainerNova - Container "cntNova": campo onde o usuario
    * digita o nome da unificacao (equivalente a ThisForm.cntNova.getNova do
    * legado, lido em BtnProcessarClick/ProcessarUnificacao).
    * Original: cntNova Top=112 Left=49 Width=660 Height=42
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerNova()
    *==========================================================================
        THIS.AddObject("cnt_4c_Nova", "Container")
        WITH THIS.cnt_4c_Nova
            .Top           = 112
            .Left          = 49
            .Width         = 660
            .Height        = 42
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label1: classe "say" do legado (AutoSize=.T. sem Width/Alignment
        *-- declarados) - regra #23 do CLAUDE.md: AutoSize e no-op em
        *-- AddObject, usar Width/Height ja calculados pelo Form Designer.
        THIS.cnt_4c_Nova.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_Nova.lbl_4c_Label1
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = " \<Nome da Unifica" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 20
            .Top       = 13
            .Width     = 121
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Nova.AddObject("txt_4c_Nova", "TextBox")
        WITH THIS.cnt_4c_Nova.txt_4c_Nova
            .FontName          = "Courier New"
            .FontSize          = 9
            .Format            = "K"
            .Height            = 25
            .Left              = 151
            .MaxLength         = 20
            .Top               = 8
            .Width             = 220
            .Value             = ""
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .T.
        ENDWITH

        *-- Valor inicial vem do BO (ponto de RECARGA): o .Value = "" acima eh
        *-- so o tipo do campo - quem decide o conteudo exibido eh BOParaForm,
        *-- para que tela e BO nunca divirjam.
        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o BO e a estrutura visual completa: cabecalho,
    * grade de selecao (grd_4c_Dados), botoes de acao (Processar/Sair/
    * Marcar/Desmarcar) e o campo "Nome da Unificacao".
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- DataSession=2 nasce no default do VFP (regra #9.4) - SET DELETED
            *-- nao herda o SET do config.prg
            SET DELETED ON

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrMluBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarGridDados()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarContainerNova()

                THIS.TornarControlesVisiveis(THIS)

                *-- Estado inicial pelo funil unico: a tela nasce em "LISTA"
                *-- (grade disponivel para selecao, Processar liberado)
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()

                *-- Carga inicial da grade - pulada em validacao de UI / modo
                *-- teste (sem gnConnHandle real)
                IF !loc_lModoValidacaoOuTeste
                    THIS.CarregarLista()
                ENDIF

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigPrMluBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLista - Popula cursor_4c_Dados (equivalente a crSigMlItn) com
    * as malas diretas cadastradas e liga a grade. O cursor precisa ser
    * READWRITE porque a Column1 (chk_4c_Check1) grava SelImp por linha
    * (regra do CLAUDE.md: Grid com coluna editavel exige cursor READWRITE -
    * SQLEXEC() cria cursor somente-leitura).
    *==========================================================================
    PROCEDURE CarregarLista()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF USED("cursor_4c_DadosTmp")
            USE IN cursor_4c_DadosTmp
        ENDIF

        loc_cSQL = "SELECT 0 AS SelImp, codigos AS Codigos, descs AS Descs, " + ;
            "usuins AS UsuIns, datins AS DatIns, nregis AS NRegis FROM SigMlItn"

        SET NULL ON
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
        SET NULL OFF

        IF loc_nResultado >= 0
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
            USE IN cursor_4c_DadosTmp

            SELECT cursor_4c_Dados
            INDEX ON Codigos TAG Codigos
            INDEX ON Descs   TAG Descs
            INDEX ON UsuIns  TAG UsuIns
            INDEX ON DatIns  TAG DatIns

            THIS.grd_4c_Dados.RecordSource = ""
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.SelImp"
            THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.Codigos"
            THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.Descs"
            THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Dados.UsuIns"
            THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Dados.DatIns"
            THIS.grd_4c_Dados.Column6.ControlSource = "cursor_4c_Dados.NRegis"
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"

            *-- RecordSource reseta ControlSource/Width/Header/CurrentControl
            *-- (auto-bind pela ordem dos campos do cursor) - reconfigurar
            *-- IMEDIATAMENTE depois (CLAUDE.md "Problema 48")
            THIS.grd_4c_Dados.Column1.ControlSource    = "cursor_4c_Dados.SelImp"
            THIS.grd_4c_Dados.Column1.CurrentControl = "chk_4c_Check1"
            THIS.grd_4c_Dados.Column1.Sparse         = .F.
            THIS.grd_4c_Dados.Column1.ReadOnly        = .F.
            THIS.grd_4c_Dados.Column1.Width           = 15
            THIS.grd_4c_Dados.Column1.Header1.Caption = ""
            THIS.grd_4c_Dados.Column2.ControlSource    = "cursor_4c_Dados.Codigos"
            THIS.grd_4c_Dados.Column2.Width           = 80
            THIS.grd_4c_Dados.Column2.Header1.Caption = "C" + CHR(243) + "digo"
            THIS.grd_4c_Dados.Column3.ControlSource    = "cursor_4c_Dados.Descs"
            THIS.grd_4c_Dados.Column3.Width           = 260
            THIS.grd_4c_Dados.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            THIS.grd_4c_Dados.Column4.ControlSource    = "cursor_4c_Dados.UsuIns"
            THIS.grd_4c_Dados.Column4.Width           = 120
            THIS.grd_4c_Dados.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
            THIS.grd_4c_Dados.Column5.ControlSource    = "cursor_4c_Dados.DatIns"
            THIS.grd_4c_Dados.Column5.Width           = 80
            THIS.grd_4c_Dados.Column5.Header1.Caption = "Dt.Entrada"
            THIS.grd_4c_Dados.Column6.ControlSource    = "cursor_4c_Dados.NRegis"
            THIS.grd_4c_Dados.Column6.Width           = 80
            THIS.grd_4c_Dados.Column6.Header1.Caption = "N.Registros"

            THIS.OrdenarGrade(THIS.this_nGridOrder)

            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao carregar malas diretas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * OrdenarGrade - Reordena cursor_4c_Dados pela coluna informada
    * (equivalente a AcertaGrades(pColuna) do legado) e realca o cabecalho
    * da coluna ativa com RGB(220,255,220), como no legado.
    *==========================================================================
    PROCEDURE OrdenarGrade(par_nColuna)
    *==========================================================================
        LOCAL loc_cTag, loc_nI, loc_cCaminho

        IF VARTYPE(par_nColuna) = "N"
            THIS.this_nGridOrder = par_nColuna
        ENDIF

        DO CASE
            CASE THIS.this_nGridOrder = 3
                loc_cTag = "Descs"
            CASE THIS.this_nGridOrder = 4
                loc_cTag = "UsuIns"
            CASE THIS.this_nGridOrder = 5
                loc_cTag = "DatIns"
            OTHERWISE
                loc_cTag = "Codigos"
        ENDCASE

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG (loc_cTag)
            GO TOP
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            FOR loc_nI = 1 TO THIS.grd_4c_Dados.ColumnCount
                loc_cCaminho = "THIS.grd_4c_Dados.Column" + ALLTRIM(STR(loc_nI, 2)) + ".Header1.BackColor"
                STORE IIF(THIS.this_nGridOrder = loc_nI, RGB(220, 255, 220), THIS.BackColor) TO (loc_cCaminho)
            ENDFOR
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeHeader*Click - Disparados pelo clique nos cabecalhos das colunas
    * 2 a 5 (equivalente a Column2..5.Header1.Click chamando AcertaGrades(N)
    * no legado - Column1/Column6 nao tem Click no dump)
    *==========================================================================
    PROCEDURE GradeHeaderCodigosClick()
    *==========================================================================
        THIS.OrdenarGrade(2)
    ENDPROC

    PROCEDURE GradeHeaderDescsClick()
    *==========================================================================
        THIS.OrdenarGrade(3)
    ENDPROC

    PROCEDURE GradeHeaderUsuInsClick()
    *==========================================================================
        THIS.OrdenarGrade(4)
    ENDPROC

    PROCEDURE GradeHeaderDatInsClick()
    *==========================================================================
        THIS.OrdenarGrade(5)
    ENDPROC

    *==========================================================================
    * BindToggleSelecao - Liga os 4 eventos do checkbox de selecao da grade
    * (Pattern #185/#186 - Erro146: CheckBox de Column NAO alterna sem os
    * handlers de Click/MouseDown/MouseUp/KeyPress, todos com NODEFAULT)
    *==========================================================================
    PROTECTED PROCEDURE BindToggleSelecao(par_oChk)
    *==========================================================================
        BINDEVENT(par_oChk, "KeyPress",  THIS, "ChkSelecaoKeyPress")
        BINDEVENT(par_oChk, "MouseDown", THIS, "ChkSelecaoMouseDown")
        BINDEVENT(par_oChk, "MouseUp",   THIS, "ChkSelecaoMouseUp")
        BINDEVENT(par_oChk, "Click",     THIS, "ChkSelecaoClick")
    ENDPROC

    *==========================================================================
    * ChkSelecaoToggle - Alterna SelImp da linha corrente de cursor_4c_Dados
    * (equivalente a "m.SelImp = Iif(crSigMlItn.SelImp=1, 0, 1) / Gather
    * Memvar Fields SelImp" do legado - disparado no MouseDown/KeyPress)
    *==========================================================================
    PROCEDURE ChkSelecaoToggle()
    *==========================================================================
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            REPLACE SelImp WITH IIF(NVL(SelImp, 0) = 1, 0, 1)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.ChkSelecaoToggle()
            NODEFAULT
        ENDIF
    ENDPROC

    *-- MouseDown apenas SUPRIME o toggle nativo (legado: "NoDefault" e nada
    *-- mais). Quem alterna eh o MouseUp - o legado simula a tecla Enter
    *-- (codigo 13) de dentro do seu proprio MouseUp para disparar o mesmo
    *-- toggle do KeyPress. Invertidos, o valor alterna antes de o clique
    *-- terminar e um arraste sobre a celula alterna sem o usuario soltar o
    *-- botao.
    PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
    *==========================================================================
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
    *==========================================================================
        THIS.ChkSelecaoToggle()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecaoClick()
    *==========================================================================
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario (equivalente a ThisForm.Release do
    * btnsair.Click legado)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MarcarTodasAs - Funil UNICO dos dois botoes do cmdBtnGrade legado. No
    * SCX os dois sao um CommandGroup com ButtonCount = 2 e UM Click so:
    *
    *     Update crSigMlItn Set SelImp = This.Value
    *     ThisForm.grdSelecoes.Refresh
    *
    * O unico dado que muda entre btnMarcar e btnDesmarcar e o "This.Value"
    * do grupo, isto e o INDICE do botao clicado - 1 no primeiro e 2 no
    * segundo. Por isso os dois handlers abaixo apenas chamam este metodo com
    * o indice correspondente, em vez de duplicar a logica.
    *
    * O valor 2 do botao Desmarcar e transcricao LITERAL (regra #17): o
    * legado nao grava 0 ao desmarcar, grava o indice do botao, e != 1 ja
    * basta para a linha sair do filtro "SelImp = 1" usado em
    * ValidarProcessamento/ProcessarUnificacao.
    *
    * UPDATE-SQL e nao REPLACE ALL: o legado usa "Update ... Set" porque
    * REPLACE ALL percorre o cursor inteiro e deixa o ponteiro em EOF - a
    * grade saltaria para o fim e perderia a linha corrente a cada clique nos
    * botoes, divergencia visivel que o legado nao tem. O RECNO() e salvo e
    * restaurado porque a grade continua ancorada no ponteiro do cursor
    * (regra #21a), e fechamos com Refresh como o legado.
    *
    * "m.par_nValor" com prefixo m. e obrigatorio: em comando SQL do VFP um
    * identificador solto e resolvido primeiro como COLUNA do cursor.
    *==========================================================================
    PROTECTED PROCEDURE MarcarTodasAs(par_nValor)
    *==========================================================================
        LOCAL loc_nRec, loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_nRec = RECNO()

                UPDATE cursor_4c_Dados SET SelImp = m.par_nValor

                SELECT cursor_4c_Dados
                IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Dados"))
                    GO loc_nRec
                ELSE
                    GO TOP
                ENDIF

                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em MarcarTodasAs")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSelTudoClick - 1o botao do cmdBtnGrade ("btnMarcar", ToolTip
    * "Seleciona Tudo"): marca todas as malas da grade. This.Value = 1.
    *==========================================================================
    PROCEDURE CmdSelTudoClick()
    *==========================================================================
        THIS.MarcarTodasAs(1)
    ENDPROC

    *==========================================================================
    * CmdApagaTudoClick - 2o botao do cmdBtnGrade ("btnDesmarcar", ToolTip
    * "Apaga Tudo"): desmarca todas as malas da grade. This.Value = 2.
    *==========================================================================
    PROCEDURE CmdApagaTudoClick()
    *==========================================================================
        THIS.MarcarTodasAs(2)
    ENDPROC

    *==========================================================================
    * ValidarProcessamento - REGRA DOS CAMPOS que esta fase entrega, em FONTE
    * UNICA. No legado ela NAO mora em evento de campo: o dump nao tem
    * Valid/When/LostFocus em getNova (grep "PROCEDURE" no SIGPRMLU devolve so
    * acertagrades/montagrades/processamento/Release/Init e os Click/KeyPress/
    * MouseUp/MouseDown do Check1 da grade) - ela mora DENTRO do
    * cmdProcessar.Click e governa o campo "Nome da Unificacao"
    * (cnt_4c_Nova.txt_4c_Nova) mais a selecao da grade. Por isso nasce AQUI e
    * o handler do botao apenas CHAMA.
    *
    * Transcricao literal dos tres guards do legado, na MESMA ordem, com as
    * MESMAS mensagens e os MESMOS destinos de SetFocus:
    *   1) Reccount('csTmp') < 1   -> "Nenhuma Mala Direta Com Registros..."    -> grade
    *   2) Reccount('csTmp') = 1   -> "Apenas Uma Mala Direta Com Registros..." -> grade
    *   3) IsEmpty(getNova.Value)  -> "Nome da Unificacao Invalido!!!..."        -> campo
    *
    * O csTmp do legado ("Select Codigos From crSigMlItn Where (SelImp = 1)
    * Into Cursor csTmp") so existe para ser contado: aqui o equivalente eh o
    * COUNT FOR sobre cursor_4c_Dados, sem criar cursor.
    *
    * O TEXTBOX eh a FONTE UNICA do nome - o legado le
    * ThisForm.cntNova.getNova.Value direto, inclusive no Insert e na mensagem
    * final de conclusao. O espelho para a property do BO eh feito aqui, DEPOIS
    * de validar, para que nenhum caminho grave o nome ANTIGO quando o usuario
    * limpa o campo entre duas unificacoes.
    *
    * PUBLIC de proposito: chamado de FORA da classe pelo handler do botao
    * (BINDEVENT descarta retorno de delegate, por isso o guard eh chamado em
    * codigo) e pelos harnesses de teste - regras #3 e #51 do CLAUDE.md.
    *
    * Retorna .T. quando os tres guards passam.
    *==========================================================================
    PROCEDURE ValidarProcessamento()
    *==========================================================================
        LOCAL loc_lValido, loc_nSelecionadas, loc_oErro

        loc_lValido       = .T.
        loc_nSelecionadas = 0

        *-- TRY/CATCH obrigatorio: este metodo eh o funil de validacao chamado
        *-- de FORA (BtnProcessarClick e harness de teste). Sem ele uma falha
        *-- aqui sobe como "Program Error" CRU do VFP, em vez do dialogo do
        *-- sistema, e o BtnProcessarClick nem chegaria a reabilitar o botao.
        *-- Nenhum RETURN dentro do TRY (regra #1): o veredicto sai pela flag
        *-- loc_lValido e ha um RETURN unico DEPOIS do ENDTRY.
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
                COUNT FOR NVL(SelImp, 0) = 1 TO loc_nSelecionadas
            ENDIF

            DO CASE
                CASE loc_nSelecionadas < 1
                    MsgAviso("Nenhuma Mala Direta Com Registros Foi Selecionada Para Unifica" + ;
                        CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.grd_4c_Dados.SetFocus()
                    loc_lValido = .F.

                CASE loc_nSelecionadas = 1
                    MsgAviso("Apenas Uma Mala Direta Com Registros Foi Selecionada Para Ser Unificada!!!" + CHR(13) + ;
                        "N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
                        "vel Unificar Apenas Uma Mala Direta, Selecione Ao Menos Duas!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.grd_4c_Dados.SetFocus()
                    loc_lValido = .F.

                CASE EMPTY(ALLTRIM(THIS.cnt_4c_Nova.txt_4c_Nova.Value))
                    MsgAviso("Nome da Unifica" + CHR(231) + CHR(227) + "o Invalido!!! Este " + CHR(233) + ;
                        " o Nome Que" + CHR(13) + "Vai Ser Utilizado Na Unifica" + CHR(231) + CHR(227) + ;
                        "o Que Ser" + CHR(225) + " Gerada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.cnt_4c_Nova.txt_4c_Nova.SetFocus()
                    loc_lValido = .F.
            ENDCASE

            *-- Espelho tela -> BO (so com os guards aprovados), delegado ao
            *-- funil unico FormParaBO. Fica DEPOIS da validacao para que
            *-- nenhum caminho grave o nome ANTIGO quando o usuario limpa o
            *-- campo entre duas unificacoes, e a falha dele REPROVA: sem o
            *-- espelho, ProcessarUnificacao leria property vazia.
            IF loc_lValido
                loc_lValido = THIS.FormParaBO()
            ENDIF
        CATCH TO loc_oErro
            *-- Validacao que nao conseguiu concluir REPROVA: deixar passar
            *-- gravaria a unificacao sem os tres guards do legado.
            loc_lValido = .F.
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarProcessamento")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Handler do botao Processar (cmdProcessar.Click do
    * legado). Reproduz, na ordem do legado: repinta a grade e volta ao topo
    * (Refresh / Go Top In crSigMlItn / Refresh - regra #21a: popular/alterar
    * cursor nao repinta sozinho, e o toggle do checkbox grava por REPLACE),
    * trava o botao (This.Enabled = .f.), valida pelo funil unico
    * ValidarProcessamento(), pede confirmacao e dispara ProcessarUnificacao().
    * O "This.Enabled = .t." aparece em TODOS os caminhos de saida do legado -
    * aqui eh uma unica linha no fim, equivalente e sem repeticao.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            THIS.grd_4c_Dados.Refresh()
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF
            THIS.grd_4c_Dados.Refresh()

            THIS.this_cModoAtual = "PROCESSANDO"
            THIS.AjustarBotoesPorModo()

            IF THIS.ValidarProcessamento()
                IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?", ;
                    "Confirma" + CHR(231) + CHR(227) + "o")
                    THIS.ProcessarUnificacao()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY

        *-- Reabilitacao INCONDICIONAL e FORA do TRY. O legado repete
        *-- "This.Enabled = .t." nos QUATRO caminhos de saida do
        *-- cmdProcessar.Click (os tres "Return 0" dos guards e o fim do
        *-- metodo) exatamente para que nenhuma saida deixe o botao travado.
        *-- Uma unica linha depois do ENDTRY cobre os quatro MAIS o caminho de
        *-- excecao: sem ela, um erro em ValidarProcessamento/
        *-- ProcessarUnificacao deixaria o Processar cinza pelo resto da vida
        *-- do form e a tela ficaria inutilizavel sem fechar e reabrir
        *-- (regra #40 - quem DESABILITA reabilita no funil de volta).
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * ProcessarUnificacao - Unifica as malas diretas marcadas numa mala NOVA
    * (equivalente ao PROCEDURE processamento do legado): gera um codigo novo,
    * duplica os registros de SigMlCab de cada mala selecionada na mala nova
    * (deduplicando por Desti+Ceps+Endes+Nums+Compls) e grava o cabecalho da
    * mala nova em SigMlItn via o BusinessObject.
    *==========================================================================
    PROCEDURE ProcessarUnificacao()
    *==========================================================================
        LOCAL loc_cCodigoNovo, loc_cNomeUnificacao, loc_cUnificas, loc_nTotalOrigem, ;
            loc_nTotalUnificado, loc_nMalasSelecionadas, loc_cSQL, loc_nResultado, ;
            loc_cChaveUnica, loc_lSucesso, loc_oErro, loc_cCodMala, loc_lErroInsercao, loc_cMsg, ;
            loc_lSnapshotOk

        loc_lSucesso        = .F.
        loc_lErroInsercao   = .F.
        loc_cUnificas        = ""
        loc_nTotalOrigem     = 0
        loc_nMalasSelecionadas = 0

        TRY
            loc_cCodigoNovo = PADR(SUBSTR(SYS(2015), 3, 10), 10)

            *-- Snapshot da tela pelo funil unico FormParaBO. Chamado tambem
            *-- aqui (e nao so no ValidarProcessamento) para o metodo ser
            *-- auto-suficiente quando acionado de fora - harness de teste - e
            *-- porque eh puro: reler a mesma tela devolve o mesmo valor.
            *-- Dai em diante o TextBox e a contagem da grade NAO sao mais
            *-- lidos: tudo vem das properties do BO.
            loc_lSnapshotOk = THIS.FormParaBO()
            IF !loc_lSnapshotOk
                *-- FormParaBO ja exibiu o proprio erro - aqui so aborta, sem
                *-- segunda mensagem (regra #9: CATCH nunca silencioso, mas
                *-- tambem nunca em duplicata).
                loc_lErroInsercao = .T.
            ENDIF

            loc_cNomeUnificacao    = ALLTRIM(THIS.this_oBusinessObject.this_cNomeUnificacao)
            loc_cUnificas          = THIS.this_oBusinessObject.this_cCodigosSelecionados
            loc_nMalasSelecionadas = THIS.this_oBusinessObject.this_nTotalMalasSelecionadas

            *-- Cursor de dedup final (equivalente a csMalaUnificada), chave
            *-- de unicidade igual ao legado: Padr(Upper(StrTran(Desti+Ceps+
            *-- Endes+Nums+Compls,' ','')),200)
            IF USED("cursor_4c_Unificada")
                USE IN cursor_4c_Unificada
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Unificada (ChaveUnica C(200), Cidchaves C(20), ;
                IClis C(10) NULL, Codigos C(10) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
                Compls C(25) NULL, Estas C(2) NULL, Faxs C(20) NULL, Grupos C(10) NULL, ;
                Mes C(2) NULL, Nums C(10) NULL, Rclis C(50) NULL, Tel1S C(20) NULL, ;
                Tel2S C(20) NULL, Cidas C(30) NULL, Endes C(60) NULL, Nascs T NULL, ;
                Profiss C(20) NULL, Sexos C(1) NULL, Ultcomps T NULL, Aptos N(6, 0) NULL, ;
                Opdest N(1, 0) NULL, Desti C(50) NULL, Opini N(1, 0) NULL, Dtncons T NULL, ;
                Conjuges C(60) NULL, Dtcasas T NULL, Situas C(3) NULL, Dataincs T NULL, ;
                Opani N(1, 0) NULL, Quebras C(40) NULL, Cpfs C(20) NULL)
            SET NULL OFF
            INDEX ON ChaveUnica TAG ChaveUnica

            *-- Malas marcadas (equivalente a "Select Codigos From crSigMlItn
            *-- Where SelImp = 1")
            IF USED("cursor_4c_MalasSel")
                USE IN cursor_4c_MalasSel
            ENDIF
            SELECT Codigos FROM cursor_4c_Dados WHERE SelImp = 1 ;
                INTO CURSOR cursor_4c_MalasSel

            SELECT cursor_4c_MalasSel
            SCAN
                IF loc_lErroInsercao
                    EXIT
                ENDIF

                loc_cCodMala = ALLTRIM(cursor_4c_MalasSel.Codigos)

                loc_cSQL = "SELECT iclis, codigos, bairs, ceps, compls, estas, faxs, " + ;
                    "grupos, mes, nums, rclis, tel1s, tel2s, cidas, endes, nascs, " + ;
                    "profiss, sexos, ultcomps, aptos, opdest, desti, opini, dtncons, " + ;
                    "conjuges, dtcasas, situas, dataincs, opani, quebras, cpfs " + ;
                    "FROM SigMlCab WHERE codigos = " + EscaparSQL(PADR(loc_cCodMala, 10))

                IF USED("cursor_4c_MlCabTmp")
                    USE IN cursor_4c_MlCabTmp
                ENDIF

                SET NULL ON
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MlCabTmp")
                SET NULL OFF

                IF loc_nResultado >= 0
                    loc_nTotalOrigem = loc_nTotalOrigem + RECCOUNT("cursor_4c_MlCabTmp")

                    SELECT cursor_4c_MlCabTmp
                    SCAN
                        SCATTER MEMVAR MEMO
                        loc_cChaveUnica = PADR(UPPER(STRTRAN(NVL(m.desti, "") + NVL(m.ceps, "") + ;
                            NVL(m.endes, "") + NVL(m.nums, "") + NVL(m.compls, ""), " ", "")), 200)

                        IF !SEEK(loc_cChaveUnica, "cursor_4c_Unificada", "ChaveUnica")
                            m.ChaveUnica = loc_cChaveUnica
                            m.Cidchaves  = LEFT(fUniqueIds(), 20)
                            m.Codigos    = PADR(loc_cCodigoNovo, 10)
                            INSERT INTO cursor_4c_Unificada FROM MEMVAR
                        ENDIF
                    ENDSCAN

                    USE IN cursor_4c_MlCabTmp
                ENDIF
            ENDSCAN

            USE IN cursor_4c_MalasSel

            loc_nTotalUnificado = RECCOUNT("cursor_4c_Unificada")

            *-- Grava cada registro deduplicado em SigMlCab (equivalente ao
            *-- .Update('crSigMlCab') do legado - aqui linha a linha via
            *-- SQLEXEC, pois a arquitetura nova nao usa cursor remoto
            *-- editavel). desdtcom/teldtcom sao NOT NULL sem DEFAULT (regra
            *-- #22) e o legado tambem os deixa em branco (nunca aparecem no
            *-- lcCampo copiado).
            SELECT cursor_4c_Unificada
            SCAN
                IF loc_lErroInsercao
                    EXIT
                ENDIF

                loc_cSQL = "INSERT INTO SigMlCab (" + ;
                    "cidchaves, iclis, codigos, bairs, ceps, compls, estas, faxs, " + ;
                    "grupos, mes, nums, rclis, tel1s, tel2s, cidas, endes, nascs, " + ;
                    "profiss, sexos, ultcomps, aptos, opdest, desti, opini, dtncons, " + ;
                    "conjuges, dtcasas, situas, dataincs, opani, quebras, cpfs, " + ;
                    "desdtcom, teldtcom) VALUES (" + ;
                    EscaparSQL(LEFT(ALLTRIM(cursor_4c_Unificada.Cidchaves), 20)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.IClis, ""), 10)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Codigos, ""), 10)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Bairs, ""), 40)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Ceps, ""), 9)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Compls, ""), 25)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Estas, ""), 2)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Faxs, ""), 20)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Grupos, ""), 10)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Mes, ""), 2)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Nums, ""), 10)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Rclis, ""), 50)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Tel1S, ""), 20)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Tel2S, ""), 20)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Cidas, ""), 30)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Endes, ""), 60)) + ", " + ;
                    FormatarDataSQL(cursor_4c_Unificada.Nascs) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Profiss, ""), 20)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Sexos, ""), 1)) + ", " + ;
                    FormatarDataSQL(cursor_4c_Unificada.Ultcomps) + ", " + ;
                    FormatarNumeroSQL(NVL(cursor_4c_Unificada.Aptos, 0), 0) + ", " + ;
                    FormatarNumeroSQL(NVL(cursor_4c_Unificada.Opdest, 0), 0) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Desti, ""), 50)) + ", " + ;
                    FormatarNumeroSQL(NVL(cursor_4c_Unificada.Opini, 0), 0) + ", " + ;
                    FormatarDataSQL(cursor_4c_Unificada.Dtncons) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Conjuges, ""), 60)) + ", " + ;
                    FormatarDataSQL(cursor_4c_Unificada.Dtcasas) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Situas, ""), 3)) + ", " + ;
                    FormatarDataSQL(cursor_4c_Unificada.Dataincs) + ", " + ;
                    FormatarNumeroSQL(NVL(cursor_4c_Unificada.Opani, 0), 0) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Quebras, ""), 40)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Cpfs, ""), 20)) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    loc_lErroInsercao = .T.
                ENDIF
            ENDSCAN

            USE IN cursor_4c_Unificada

            IF loc_lErroInsercao
                IF loc_lSnapshotOk
                    MsgErro("Erro ao gravar os registros unificados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                *-- Cabecalho da mala nova (equivalente ao "Insert Into
                *-- crSigMlItn" do legado) - reusa o BO ja existente
                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_oBusinessObject.this_cCodigos            = loc_cCodigoNovo
                THIS.this_oBusinessObject.this_cDescs              = loc_cNomeUnificacao
                THIS.this_oBusinessObject.this_cUsuIns             = gc_4c_UsuarioLogado
                THIS.this_oBusinessObject.this_dDatIns             = DATETIME()
                THIS.this_oBusinessObject.this_nNRegis             = loc_nTotalUnificado
                THIS.this_oBusinessObject.this_cUnificas           = loc_cUnificas
                THIS.this_oBusinessObject.this_cNomeUnificacao      = PADR(loc_cNomeUnificacao, 20)
                THIS.this_oBusinessObject.this_cCodigoGerado        = loc_cCodigoNovo
                THIS.this_oBusinessObject.this_nTotalRegistrosOrigem = loc_nTotalOrigem
                THIS.this_oBusinessObject.this_cCodigosSelecionados  = loc_cUnificas
                THIS.this_oBusinessObject.this_nTotalMalasSelecionadas = loc_nMalasSelecionadas

                IF THIS.this_oBusinessObject.Salvar()
                    loc_cMsg = "Unifica" + CHR(231) + CHR(227) + 'o "' + loc_cNomeUnificacao + ;
                        '" Conclu' + CHR(237) + "da!!!" + CHR(13) + ;
                        "Foram Selecionados " + ALLTRIM(STR(loc_nTotalUnificado)) + " Registros," + CHR(13) + ;
                        "Retirados de " + ALLTRIM(STR(loc_nMalasSelecionadas)) + " Malas Diretas," + CHR(13) + ;
                        "Que Continham Um Total de " + ALLTRIM(STR(loc_nTotalOrigem)) + " Registros."
                    MsgInfo(loc_cMsg, "Confirma" + CHR(231) + CHR(227) + "o")

                    *-- LimparCampos zera as properties do BO e o BOParaForm
                    *-- reflete o BO vazio no campo; CarregarLista refaz a
                    *-- consulta com "0 AS SelImp" e desmarca a grade, como o
                    *-- Requery(crSigMlItn) do legado.
                    THIS.LimparCampos()
                    THIS.CarregarLista()
                    THIS.grd_4c_Dados.SetFocus()

                    loc_lSucesso = .T.
                ELSE
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar a unifica" + ;
                            CHR(231) + CHR(227) + "o.", "Erro")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ProcessarUnificacao")
        ENDTRY

        *-- Encerra qualquer cursor temporario que tenha sobrevivido a um erro
        IF USED("cursor_4c_MalasSel")
            USE IN cursor_4c_MalasSel
        ENDIF
        IF USED("cursor_4c_MlCabTmp")
            USE IN cursor_4c_MlCabTmp
        ENDIF
        IF USED("cursor_4c_Unificada")
            USE IN cursor_4c_Unificada
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transferencia TELA -> BO, em FONTE UNICA.
    *
    * Nao eh convencao importada de form CRUD: o bloco EXISTE no legado, so
    * nao tem esse nome. O cmdProcessar.Click le a tela em dois pontos -
    * "ThisForm.cntNova.getNova.Value" (nome da unificacao) e o
    * "Select Codigos From crSigMlItn Where (SelImp = 1)" (malas marcadas) -
    * e o Processamento legado reusa os dois. Aqui os dois
    * viram UMA leitura, gravada nas properties do BO, e nenhum outro metodo
    * volta a tocar no TextBox nem a recontar a grade.
    *
    * PROTECTED obrigatoriamente: FormBase declara FormParaBO como PROTECTED e
    * VFP9 nao permite ALARGAR o escopo de metodo herdado.
    *
    * O RECNO eh salvo e restaurado porque a grade continua ancorada no
    * ponteiro do cursor (regra #21a) - o SCAN abaixo deixaria o ponteiro em
    * EOF e a grade saltaria para o fim a cada clique em Processar.
    *
    * Retorna .T. quando a transferencia concluiu.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
        LOCAL loc_lSucesso, loc_cCodigos, loc_nMalas, loc_nRec, loc_oErro

        loc_lSucesso = .F.
        loc_cCodigos = ""
        loc_nMalas   = 0

        *-- Nenhum RETURN dentro do TRY (regra #1): o veredicto sai pela flag
        *-- loc_lSucesso e ha um RETURN unico DEPOIS do ENDTRY.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    loc_nRec = RECNO()

                    SCAN FOR NVL(SelImp, 0) = 1
                        loc_cCodigos = loc_cCodigos + ALLTRIM(cursor_4c_Dados.Codigos) + "; "
                        loc_nMalas   = loc_nMalas + 1
                    ENDSCAN

                    SELECT cursor_4c_Dados
                    IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Dados"))
                        GO loc_nRec
                    ELSE
                        GO TOP
                    ENDIF
                ENDIF

                *-- MaxLength = 20 no SCX e SigMlItn.descs eh char(30): PADR em
                *-- 20 preserva a largura que o campo aceita, igual ao
                *-- Alltrim(getNova.Value) do Insert legado.
                THIS.this_oBusinessObject.this_cNomeUnificacao = ;
                    PADR(ALLTRIM(THIS.cnt_4c_Nova.txt_4c_Nova.Value), 20)

                THIS.this_oBusinessObject.this_cCodigosSelecionados    = loc_cCodigos
                THIS.this_oBusinessObject.this_nTotalMalasSelecionadas = loc_nMalas

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Transferencia BO -> TELA (sentido inverso de FormParaBO).
    * Reflete this_cNomeUnificacao no campo "Nome da Unificacao". Usado como
    * ponto de RECARGA em dois lugares: na criacao do campo
    * (ConfigurarContainerNova) e no LimparCampos, que zera o BO e deixa este
    * metodo apagar a tela - assim o valor exibido nunca divirge do BO.
    *
    * PROTECTED obrigatoriamente - FormBase declara BOParaForm como PROTECTED.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "cnt_4c_Nova", 5)
                THIS.cnt_4c_Nova.txt_4c_Nova.Value = ;
                    ALLTRIM(NVL(THIS.this_oBusinessObject.this_cNomeUnificacao, ""))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera o estado de uma unificacao concluida: limpa as
    * properties do BO (SigPrMluBO.LimparDados) e deixa o BOParaForm refletir
    * o BO zerado no campo "Nome da Unificacao".
    *
    * A GRADE nao eh tocada aqui de proposito: o legado desmarca as malas
    * refazendo a consulta ("ThisForm.poDataMgr.Requery('crSigMlItn')" sobre
    * "Select 0 as SelImp, * From SigMlItn"), e no migrado quem reproduz isso
    * eh CarregarLista, cujo SELECT tambem traz "0 AS SelImp". Desmarcar aqui
    * tambem duplicaria a regra em dois lugares.
    *
    * PROTECTED obrigatoriamente - FormBase declara LimparCampos como PROTECTED.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparDados()
            ENDIF

            THIS.BOParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - FUNIL UNICO do estado habilitado/desabilitado dos
    * botoes, derivado de this_cModoAtual ("LISTA" / "PROCESSANDO").
    *
    * Reproduz EXATAMENTE o que o legado faz, e so isso: o cmdProcessar.Click
    * trava e destrava o PROPRIO botao ("This.Enabled = .f." no inicio e
    * "This.Enabled = .t." nos quatro caminhos de saida) e NAO mexe em
    * Enabled/ReadOnly de mais nada - nem da grade, nem do campo, nem dos
    * botoes de marcar/desmarcar. Travar mais do que isso seria divergencia
    * visivel do legado (PILAR 1).
    *
    * Por que o funil existe em vez das duas atribuicoes soltas: quem
    * DESABILITA tem de REABILITAR no caminho de volta (regra #40), e com a
    * atribuicao espalhada pelos caminhos de saida basta um deles esquecer para
    * o botao ficar cinza pelo resto da vida do form. Aqui o modo eh a unica
    * fonte e BtnProcessarClick repoe "LISTA" DEPOIS do ENDTRY, cobrindo
    * tambem o caminho de excecao.
    *
    * PUBLIC de proposito: o harness TesteAutomatico.prg chama
    * oForm.AjustarBotoesPorModo() de FORA da classe (regras #3 e #51).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
    *==========================================================================
        LOCAL loc_lLiberado

        loc_lLiberado = (UPPER(ALLTRIM(NVL(THIS.this_cModoAtual, "LISTA"))) != "PROCESSANDO")

        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = loc_lLiberado
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados por
    * AddObject (nascem com Visible=.F.), recursando em Pages e Containers.
    * Este form nao tem container flutuante (Visible=.F. toggled por botao) -
    * todos os objetos do SIGPRMLU.SCX sao estaticos.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oControle

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) != "O"
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControle, "Visible", 5)
                loc_oControle.Visible = .T.
            ENDIF

            IF UPPER(loc_oControle.BaseClass) = "PAGEFRAME"
                LOCAL loc_nP
                FOR loc_nP = 1 TO loc_oControle.PageCount
                    THIS.TornarControlesVisiveis(loc_oControle.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                THIS.TornarControlesVisiveis(loc_oControle)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera o BO e os cursores abertos pelo form
    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DadosTmp")
            USE IN cursor_4c_DadosTmp
        ENDIF
        IF USED("cursor_4c_MalasSel")
            USE IN cursor_4c_MalasSel
        ENDIF
        IF USED("cursor_4c_MlCabTmp")
            USE IN cursor_4c_MlCabTmp
        ENDIF
        IF USED("cursor_4c_Unificada")
            USE IN cursor_4c_Unificada
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrMluBO.prg):
*============================================================================
* SigPrMluBO.prg - Business Object para Unificacao de Mala Direta (SIGPRMLU)
*
* Form OPERACIONAL (SIGPRMLU / FormSigPrMlu): lista as malas diretas
* cadastradas (SigMlItn, grid com checkbox de selecao), permite ao usuario
* marcar duas ou mais e "Processar" a unificacao delas numa mala NOVA:
*   - gera um codigo novo (equivalente a Substr(Sys(2015),3,10) do legado)
*   - duplica, deduplicando por chave logica (Desti+Ceps+Endes+Nums+Compls),
*     os registros de SigMlCab (Where Codigos = <malaSelecionada>) na mala
*     nova
*   - insere o cabecalho da mala nova em SigMlItn (Codigos/Descs/Ativos/
*     UsuIns/DatIns/NRegis/Espelhos/Unificas)
*
* this_cTabela/this_cCampoChave apontam para SigMlItn (cabecalho da mala,
* entidade listada na grade principal do form - equivalente ao
* AddCursor('SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado).
* SigMlCab (registros/clientes dentro de cada mala, PK cidchaves) e
* manipulada em bloco durante o Processamento (Fase 2+), sem mapeamento
* propriedade-a-propriedade, pois o legado faz Select * / Scatter Memvar /
* Gather Memvar (copia integral do registro, nao campo a campo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrMluBO AS BusinessBase

    *==========================================================================
    * Propriedades de registro - espelham as colunas de SigMlItn (docs/
    * schema.sql) efetivamente usadas pelo SIGPRMLU.scx (cabecalho da mala
    * direta exibido na grade e gravado ao final da unificacao). As demais
    * colunas de SigMlItn (filtros de geracao da mala: anivfs/cepfs/faixafs/
    * opsexs/etc.) pertencem ao cadastro de Mala Direta (outro form) e NAO
    * sao tocadas por SIGPRMLU - nao sao declaradas aqui.
    *==========================================================================
    this_cCodigos    = SPACE(10)  && SigMlItn.codigos  - char(10) NOT NULL (PK) - grdselecoes.Column2
    this_cDescs      = SPACE(30)  && SigMlItn.descs    - char(30) NOT NULL - grdselecoes.Column3 / nome da unificacao
    this_lAtivos     = .F.        && SigMlItn.ativos   - bit NOT NULL - sempre .T. na mala resultante da unificacao
    this_cUsuIns     = SPACE(10)  && SigMlItn.usuins   - char(10) NOT NULL - grdselecoes.Column4 (Usuar do legado)
    this_dDatIns     = {}         && SigMlItn.datins   - datetime NULL - grdselecoes.Column5 (DateTime() na gravacao)
    this_dDatAlts    = {}         && SigMlItn.datalts  - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dUlts       = {}         && SigMlItn.ults     - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dDtEnts     = {}         && SigMlItn.dtents   - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_nNRegis     = 0          && SigMlItn.nregis   - numeric(8,0) NOT NULL - grdselecoes.Column6 (Reccount da mala unificada)
    this_cEspelhos   = SPACE(8)   && SigMlItn.espelhos - char(8) NOT NULL - origem fixa 'SigPrMlu' (Insert legado)
    this_cUnificas   = ""         && SigMlItn.unificas - text NULL - lista "codigo1; codigo2; " das malas de origem

    *==========================================================================
    * Estado de processamento - nao sao colunas persistidas isoladamente;
    * controlam a unificacao (Processamento() legado) e espelham o estado da
    * tela (txt_4c_Nova/getNova e os resultados intermediarios do calculo)
    *==========================================================================
    this_cNomeUnificacao        = SPACE(20)  && cntNova.getNova.Value - MaxLength=20 no SCX legado
    this_cCodigoGerado          = SPACE(10)  && lcNew  - Substr(Sys(2015),3,10), codigo da mala resultante
    this_nTotalRegistrosOrigem  = 0          && lnTot  - soma de Reccount('crTmp') de cada mala selecionada
    this_cCodigosSelecionados   = ""         && lcUni  - "codigo1; codigo2; " das malas marcadas (SelImp = 1)
    this_nTotalMalasSelecionadas = 0         && Reccount('csMalasSelecionadas') - quantidade de malas marcadas

    *==========================================================================
    * Init - Inicializa o Business Object configurando a tabela/chave
    * primaria de referencia (SigMlItn/codigos - equivalente ao AddCursor(
    * 'SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado, que define
    * qual entidade a grade principal do form lista e processa)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMlItn"
            THIS.this_cCampoChave = "codigos"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor (crSigMlItn, populado via
    * SQLEXEC/AddCursor equivalente) para as propriedades this_* deste BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigos  = TratarNulo(codigos, "")
            THIS.this_cDescs    = TratarNulo(descs, "")
            IF VARTYPE(ativos) = "L"
                THIS.this_lAtivos = TratarNulo(ativos, .F.)
            ELSE
                THIS.this_lAtivos = (TratarNulo(ativos, 0) = 1)
            ENDIF
            THIS.this_cUsuIns   = TratarNulo(usuins, "")
            THIS.this_dDatIns   = TratarNulo(datins, {})
            THIS.this_dDatAlts  = TratarNulo(datalts, {})
            THIS.this_dUlts     = TratarNulo(ults, {})
            THIS.this_dDtEnts   = TratarNulo(dtents, {})
            THIS.this_nNRegis   = TratarNulo(nregis, 0)
            THIS.this_cEspelhos = TratarNulo(espelhos, "")
            THIS.this_cUnificas = TratarNulo(unificas, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT do cabecalho da mala direta unificada em SigMlItn
    * (equivalente ao "Insert Into crSigMlItn (Codigos, Descs, Ativos, UsuIns,
    * DatIns, DatAlts, Ults, DtEnts, NRegis, Espelhos, Unificas) Values (...)"
    * do Processamento legado).
    *
    * SigMlItn tem dezenas de colunas NOT NULL sem DEFAULT que pertencem aos
    * FILTROS de geracao de mala direta (cadastro de Mala Direta - outro form)
    * e NUNCA sao tocadas pelo SIGPRMLU. O legado grava o registro INTEIRO
    * (AddCursor sem query = Select * + Gather Memvar/TableUpdate), entao essas
    * colunas vao em branco/zero junto das que a tela de fato edita. A lista
    * abaixo vem do docs/schema.sql (regra #22 do CLAUDE.md - a lista de
    * colunas NOT NULL vem do SCHEMA, nunca do dump do legado).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigoGerado = PADR(SUBSTR(SYS(2015), 3, 10), 10)
                THIS.this_cCodigos      = THIS.this_cCodigoGerado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuIns))
                THIS.this_cUsuIns = gc_4c_UsuarioLogado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEspelhos))
                THIS.this_cEspelhos = "SigPrMlu"
            ENDIF

            * Legado grava Ativos = .t. incondicionalmente na mala resultante
            THIS.this_lAtivos = .T.

            loc_cIdChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigMlItn (" + ;
                "anivfs, anivis, ativos, cadas, cemps, cepfs, cepis, cidades, " + ;
                "ckanis, ckcads, ckceps, ckcids, ckemps, ckests, ckfnoms, cknomes, " + ;
                "ckprofs, ckrsocs, cksexs, ckults, codigos, datins, demps, descs, " + ;
                "destis, espelhos, ests, faixafs, faixais, nomes, nregis, opsexs, " + ;
                "optceps, optnrs, optults, profs, rsocs, usualts, usuins, ckclass, " + ;
                "cksituas, classifis, classifss, situas, ckregis, cksitua, opsitua, regifs, " + ;
                "regiis, situa, linhas, ckcivils, opanis, ckdtents, cklinhas, tabufs, " + ;
                "opcivis, bairs, ckbairs, estados, unificas, ckvends, vends, cidchaves, " + ;
                "ckidade, idadefs, idadeis, opidade, cparents, ckdtatus, opendes, cktlmk, " + ;
                "optlmk, ckncomp, ckultcom, ckpais, paises, ckmov, dopes, endigual, " + ;
                "valosf, valosi, ckconjuge, conjuge, ckpubls, cksegs, fpubls, codsegs" + ;
                ") VALUES (" + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                "0, 0, 0, 0, " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10)) + ", " + ;
                    FormatarDataSQL(IIF(EMPTY(THIS.this_dDatIns), DATETIME(), THIS.this_dDatIns)) + ", " + ;
                    EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                "0, " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspelhos), 8)) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", 0, " + ;
                "0, 0, 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuIns), 10)) + ", 0, " + ;
                "0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                "0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(LEFT(loc_cIdChaves, 20)) + ", " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, 0, 0, " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", 0, " + ;
                FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", 0, " + EscaparSQL("") + ", 0, 0, " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do cabecalho da mala direta em SigMlItn (apenas as
    * colunas que este form mantem - as demais colunas NOT NULL de SigMlItn
    * pertencem ao cadastro de Mala Direta e nao sao alteradas aqui)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o definido para atualiza" + ;
                    CHR(231) + CHR(227) + "o", "SigPrMluBO.Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigMlItn SET " + ;
                    "descs = "    + EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                    "ativos = "   + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    "nregis = "   + FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                    "unificas = " + EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", " + ;
                    "usualts = "  + EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    "datalts = GETDATE() " + ;
                    "WHERE codigos = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar mala direta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar mala direta:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Zera as properties deste BO. Sobrescreve o stub da
    * BusinessBase (que limpa apenas this_cMensagemErro) porque este form NAO
    * eh modal-por-registro como o legado: ele fica aberto e o usuario pode
    * fazer uma unificacao depois da outra. Sem o reset, o estado da anterior
    * (nome, codigo gerado, totais e a lista de malas de origem) sobrevive na
    * instancia e qualquer caminho que deixe de reatribuir uma dessas
    * properties gravaria o valor da unificacao PASSADA - o mesmo risco de
    * ciclo de vida da regra #32 do CLAUDE.md.
    *
    * PUBLIC (sem modificador) obrigatoriamente: LimparDados eh PUBLIC na
    * BusinessBase, o Form a chama de fora em LimparCampos, e VFP9 nao permite
    * REDUZIR o escopo sem quebrar o chamador (regra #51).
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        *-- Colunas de SigMlItn mantidas por este form
        THIS.this_cCodigos  = SPACE(10)
        THIS.this_cDescs    = SPACE(30)
        THIS.this_lAtivos   = .F.
        THIS.this_cUsuIns   = SPACE(10)
        THIS.this_dDatIns   = {}
        THIS.this_dDatAlts  = {}
        THIS.this_dUlts     = {}
        THIS.this_dDtEnts   = {}
        THIS.this_nNRegis   = 0
        THIS.this_cEspelhos = SPACE(8)
        THIS.this_cUnificas = ""

        *-- Estado de processamento (espelho da tela e resultados do calculo)
        THIS.this_cNomeUnificacao          = SPACE(20)
        THIS.this_cCodigoGerado            = SPACE(10)
        THIS.this_nTotalRegistrosOrigem    = 0
        THIS.this_cCodigosSelecionados     = ""
        THIS.this_nTotalMalasSelecionadas  = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna o codigo (char(10), PK de SigMlItn) do
    * registro atual
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

ENDDEFINE


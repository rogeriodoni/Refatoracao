# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 6/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-08 02:01:08] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-08 02:01:08] [INFO] Config FPW: (nao fornecido)
[2026-10-08 02:01:08] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-08 02:01:08] [INFO] Timeout: 300 segundos
[2026-10-08 02:01:08] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_faynhyrw.prg
[2026-10-08 02:01:09] [INFO] Conteudo do wrapper:
[2026-10-08 02:01:09] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprila', 'C:\4c\tasks\task627\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprila', 'C:\4c\tasks\task627\logs\06_testForm.log'
QUIT

[2026-10-08 02:01:09] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_faynhyrw.prg
[2026-10-08 02:01:09] [INFO] VFP output esperado em: C:\4c\tasks\task627\vfp_output.txt
[2026-10-08 02:01:09] [INFO] Executando Visual FoxPro 9...
[2026-10-08 02:01:09] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_faynhyrw.prg
[2026-10-08 02:01:09] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_faynhyrw.prg
[2026-10-08 02:01:10] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprila
Inicio: 08/10/2026 02:01:10

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 08/10/2026 02:05:17
Duracao: 247 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-08 02:05:17] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-08 02:05:17] [INFO] VFP9 finalizado em 247.9101702 segundos
[2026-10-08 02:05:17] [INFO] Exit Code: 
[2026-10-08 02:05:17] [INFO] 
[2026-10-08 02:05:18] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-08 02:05:18] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_faynhyrw.prg
[2026-10-08 02:05:18] [INFO] 
[2026-10-08 02:05:18] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-08 02:05:18] [INFO] * Auto-generated wrapper for parameters
[2026-10-08 02:05:18] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-08 02:05:18] [INFO] * Parameters: 'Formsigprila', 'C:\4c\tasks\task627\logs\06_testForm.log'
[2026-10-08 02:05:18] [INFO] 
[2026-10-08 02:05:18] [INFO] * Anti-dialog protections for unattended execution
[2026-10-08 02:05:18] [INFO] SET SAFETY OFF
[2026-10-08 02:05:18] [INFO] SET RESOURCE OFF
[2026-10-08 02:05:19] [INFO] SET TALK OFF
[2026-10-08 02:05:19] [INFO] SET NOTIFY OFF
[2026-10-08 02:05:19] [INFO] SYS(2335, 0)
[2026-10-08 02:05:19] [INFO] 
[2026-10-08 02:05:19] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprila', 'C:\4c\tasks\task627\logs\06_testForm.log'
[2026-10-08 02:05:19] [INFO] QUIT
[2026-10-08 02:05:19] [INFO] 
[2026-10-08 02:05:19] [INFO] === Fim do Wrapper.prg ===
[2026-10-08 02:05:19] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprila.prg):
*==============================================================================
* Formsigprila.prg - Form Operacional: Importacao de Planilha (SIGPRILA)
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo utilitario de importacao de planilha Excel que
*       alimenta 7 rotinas distintas (ListaPreco/GeraTransf/AtuaPreco/
*       GeraPedido/Pedidocons/PedidoFab/PedAcesso), escolhidas pelo usuario
*       no combo cntplanilha.cmbTipos. Sem PageFrame no legado (raiz
*       "Class: form" generica, sem BaseClass: pageframe no dump) - layout
*       FLAT com 2 containers (cntSombra/cntplanilha) + 1 CommandGroup
*       (Grupo_Botao), nos moldes de Formsigprsen.
* SCX Origem: sigprila.SCX (tasks\task627)
*
* Eventos do legado ligados por BINDEVENT em ConfigurarEventos:
*   Grupo_Botao.cmdok.Click   -> BtnProcessarClick   -> Processamento
*   Grupo_Botao.cmdsair.Click -> BtnEncerrarClick    -> Release
*   cntplanilha.cmdgetp.Click -> BtnGetPlanilhaClick -> GETFILE
*   cmbTipos.InteractiveChange -> CboTiposInteractiveChange -> CompletaLista
*   SIGPRILA.KeyPress (ESC)   -> BtnEncerrarClick
* As SETE rotinas de importacao que Processamento despacha (ListaPreco/
* GeraTransf/AtuaPreco/GeraPedido/Pedidocons/PedidoFab/PedAcesso) sao regra
* de negocio e moram em sigprilaBO, alcancadas por ObterMetodoRotina.
*
* Superficie que esta tela NAO tem (e por isso nao esta migrada): grade de
* registros, barra CRUD e modo de edicao cancelavel. O SCX legado nao tem
* nenhum dos tres - nem BaseClass grid/pageframe, nem Grupo_Op/frmcadastro,
* nem pcEscolha - e os DEZ AddCursor do Init passam '' na posicao do objeto
* de grade. O que a tela tem eh criterio digitavel (tipo de importacao,
* arquivo, cabecalho na 1a linha, Validar e Preco) mais UM botao de acao que
* le o .xls e GRAVA em tabela de verdade, e UM botao que so fecha. Os dois
* hooks de transferencia (FormParaBO / BOParaForm) sao o par que liga esse
* criterio ao BO nos dois sentidos.
*==============================================================================
DEFINE CLASS Formsigprila AS FormBase

    *-- Dimensoes pixel-perfect do SCX original (PILAR 1) - layout.json:
    *-- form.width=800 / form.height=350 (analise.json trazia 1000x600, mas
    *-- esse arquivo nao foi preenchido pela analise desta task - campos/
    *-- lookups/labels/grid todos vazios - entao prevalece o dump real)
    Width        = 800
    Height       = 350
    Caption      = "Importa" + CHR(231) + CHR(227) + "o de Planilha"
    AutoCenter   = .T.
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    DataSession  = 2
    KeyPreview   = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Init - Apenas delega para FormBase.Init() -> InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o BO, aplica background e monta a casca do layout
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprilaBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
                THIS.ConfigurarEventos()
                THIS.PreencheTipo()
                *-- Painel abre no estado dos criterios guardados no BO, para
                *-- tela e BO nunca comecarem divergentes. Visualmente nao muda
                *-- nada hoje (os defaults do BO sao os mesmos do SCX: arquivo
                *-- vazio, cabecalho desmarcado, OptTipo/OptPreco na 1a opcao) -
                *-- o ganho eh a fonte unica, que o fim do Processamento usa.
                THIS.BOParaForm()
                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar sigprilaBO. VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL.
    * Este form nao usa PageFrame (legado sem BaseClass: pageframe) - mantido
    * so como ponto de entrada unico, no mesmo padrao de Formsigprsen.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cabecalho (cntSombra) + painel do assistente de
    * importacao (cntplanilha, com todos os campos do dump)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPainelPlanilha()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Grupo de botoes de acao (Grupo_Botao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    * Posicoes/tamanhos EXATOS do layout.json (PILAR 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

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
        loc_oCab = THIS.cnt_4c_Sombra

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
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
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPainelPlanilha - Container principal do assistente (cntplanilha
    * original). Campos criados em duas partes, seguindo mapeamento.json.
    * Posicao/tamanho EXATOS do layout.json (PILAR 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPainelPlanilha()
        THIS.AddObject("cnt_4c_planilha", "Container")
        WITH THIS.cnt_4c_planilha
            .Top         = 96
            .Left        = 167
            .Width       = 466
            .Height      = 221
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarCamposPlanilhaParte1()
        THIS.ConfigurarCamposPlanilhaParte2()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPlanilhaParte1 - primeira metade dos campos de
    * cnt_4c_planilha (Say3/cmbTipos/Say4/GetPlanilha/cmdgetp/Say1 do dump
    * original). Posicoes/propriedades EXATAS de
    * tasks\task627\sigprila_form_codigo_fonte.txt (SECAO 2). Segunda metade
    * (List1/Say2/chkCabecalho/Say5/OptTipo/Say6/OptPreco) em
    * ConfigurarCamposPlanilhaParte2 (abaixo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPlanilhaParte1()
        LOCAL loc_oPnl
        loc_oPnl = THIS.cnt_4c_planilha

        *-- Say3 -> lbl_4c_Label3 ("Tipo:")
        loc_oPnl.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPnl.lbl_4c_Label3
            .Top       = 15
            .Left      = 54
            .Width     = 29
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo:"
        ENDWITH

        *-- cmbTipos -> cbo_4c_CmbTipos (fwcombo, Style=2 dropdown list;
        *-- RowSource eh ligado ao cursor ComboTipo em PreencheTipo, chamado
        *-- pelo InicializarForm - igual ao Init do legado)
        loc_oPnl.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH loc_oPnl.cbo_4c_CmbTipos
            .Top          = 12
            .Left         = 85
            .Width        = 187
            .Height       = 23
            .Style        = 2
            .ColumnCount  = 1
            .ColumnWidths = "100"
            .RowSourceType = 6
            .RowSource    = ""
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ForeColor    = RGB(0, 0, 0)
        ENDWITH

        *-- Say4 -> lbl_4c_Label4 ("Planilha:")
        loc_oPnl.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPnl.lbl_4c_Label4
            .Top       = 40
            .Left      = 34
            .Width     = 49
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Planilha:"
        ENDWITH

        *-- GetPlanilha -> txt_4c_Planilha (fwget, preenchido via GetFile() no
        *-- Click de cmdgetp - ReadOnly/Enabled=.F. iguais ao dump original)
        loc_oPnl.AddObject("txt_4c_Planilha", "TextBox")
        WITH loc_oPnl.txt_4c_Planilha
            .Top               = 37
            .Left              = 85
            .Width             = 336
            .Height            = 23
            .MaxLength         = 40
            .ReadOnly          = .T.
            .Enabled           = .F.
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- cmdgetp -> cmd_4c_Cmdgetp (botao icone-only que abre GetFile() -
        *-- Picture transcrito do dump; Click -> BtnGetPlanilhaClick)
        loc_oPnl.AddObject("cmd_4c_Cmdgetp", "CommandButton")
        WITH loc_oPnl.cmd_4c_Cmdgetp
            .Top       = 36
            .Left      = 423
            .Width     = 36
            .Height    = 25
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = ""
            .Picture   = gc_4c_CaminhoIcones + "a_fold1.bmp"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
        ENDWITH

        *-- Say1 -> lbl_4c_Label1 ("Ordem das Colunas na Planilha:")
        loc_oPnl.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPnl.lbl_4c_Label1
            .Top       = 63
            .Left      = 85
            .Width     = 177
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Ordem das Colunas na Planilha:"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPlanilhaParte2 - segunda metade dos campos de
    * cnt_4c_planilha: List1 (listbox de ordenacao de colunas, MoverBars),
    * Say2 (instrucao do drag), chkCabecalho, Say5/OptTipo (visiveis so para
    * alguns tipos - CompletaLista alterna .Visible conforme
    * o dump legado), Say6/OptPreco (idem). Posicoes/propriedades EXATAS de
    * tasks\task627\sigprila_form_codigo_fonte.txt (SECAO 2).
    *
    * LOOKUPS: a analise comportamental desta task (comportamento.json/
    * analise.json) NAO identificou nenhum padrao de lookup (fwBuscaExt,
    * fwBuscaSel, sigacess ou classe TextBox customizada de busca) em
    * nenhum campo de SIGPRILA - o formulario eh um assistente de
    * importacao de planilha sem campos de codigo/referencia a outra
    * tabela. cmbTipos eh populado localmente a partir do cursor ComboTipo
    * (array aComboTipo, montado no Init do form legado) e GetPlanilha eh
    * preenchido via GetFile() no Click de cmdgetp - nenhum dos dois abre
    * FormBuscaAuxiliar. Portanto esta fase nao adiciona BINDEVENT de F4/F5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPlanilhaParte2()
        LOCAL loc_oPnl
        loc_oPnl = THIS.cnt_4c_planilha

        *-- List1 -> obj_4c_List1 (listbox MoverBars para reordenar colunas da
        *-- planilha; RowSource real eh montado em runtime por CompletaLista,
        *-- e CriaPlanilha le a coluna 2 de cada item para criar TmpPlanilha)
        loc_oPnl.AddObject("obj_4c_List1", "ListBox")
        WITH loc_oPnl.obj_4c_List1
            .Top            = 78
            .Left           = 82
            .Width          = 191
            .Height         = 124
            .FontName       = "Tahoma"
            .FontSize       = 8
            .BoundColumn    = 2
            .ColumnCount    = 2
            .ColumnWidths   = "172,70"
            .RowSourceType  = 1
            .RowSource      = ""
            .MoverBars      = .T.
            .SpecialEffect  = 0
        ENDWITH

        *-- Say2 -> lbl_4c_Label2 ("Clique e Arraste para Mudar")
        loc_oPnl.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPnl.lbl_4c_Label2
            .Top       = 204
            .Left      = 83
            .Width     = 160
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Clique e Arraste para Mudar"
        ENDWITH

        *-- chkCabecalho -> chk_4c_ChkCabecalho ("Cabecalho na 1a Linha")
        loc_oPnl.AddObject("chk_4c_ChkCabecalho", "CheckBox")
        WITH loc_oPnl.chk_4c_ChkCabecalho
            .Top       = 204
            .Left      = 289
            .Width     = 142
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cabe" + CHR(231) + "alho na 1" + CHR(170) + " Linha"
            .Value     = 0
        ENDWITH

        *-- Say5 -> lbl_4c_Label5 ("Validar :")
        loc_oPnl.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPnl.lbl_4c_Label5
            .Top       = 82
            .Left      = 290
            .Width     = 47
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Validar :"
        ENDWITH

        *-- OptTipo -> obj_4c_OptTipo (optiongroup: Codigo/Descritivo/
        *-- Referencia Forn. - define qual coluna de SigCdPro casa com o
        *-- produto da planilha; mapeia para sigprilaBO.this_nTipoBusca)
        loc_oPnl.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH loc_oPnl.obj_4c_OptTipo
            .Top         = 80
            .Left        = 335
            .Width       = 123
            .Height      = 65
            .ButtonCount = 3
            .BackStyle   = 0
            .Themes      = .T.

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 51
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "C" + CHR(243) + "digo"
            ENDWITH

            WITH .Buttons(2)
                .Top       = 22
                .Left      = 5
                .Width     = 65
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Descritivo"
            ENDWITH

            WITH .Buttons(3)
                .Top       = 41
                .Left      = 5
                .Width     = 99
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Refer" + CHR(234) + "ncia Forn."
            ENDWITH

            .Value = 1
        ENDWITH

        *-- Say6 -> lbl_4c_Label6 ("Preco :")
        loc_oPnl.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPnl.lbl_4c_Label6
            .Top       = 142
            .Left      = 297
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pre" + CHR(231) + "o :"
        ENDWITH

        *-- OptPreco -> obj_4c_OptPreco (optiongroup: Venda/Custo - define se
        *-- o valor gravado no movimento vem de PVens/Moevs ou de
        *-- custofs/moecusfs; mapeia para sigprilaBO.this_nTipoPreco)
        loc_oPnl.AddObject("obj_4c_OptPreco", "OptionGroup")
        WITH loc_oPnl.obj_4c_OptPreco
            .Top         = 140
            .Left        = 335
            .Width       = 123
            .Height      = 44
            .ButtonCount = 2
            .BackStyle   = 0
            .Themes      = .T.

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 48
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Venda"
            ENDWITH

            WITH .Buttons(2)
                .Top       = 22
                .Left      = 5
                .Width     = 46
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Custo"
            ENDWITH

            .Value = 1
        ENDWITH

        *-- Visibilidade inicial de Say5/OptTipo e Say6/OptPreco: o legado
        *-- (CompletaLista) alterna .Visible conforme o tipo escolhido em
        *-- cmbTipos. O estado inicial eh oculto, igual ao fim do PreencheTipo
        *-- do legado, que esconde os dois blocos antes de qualquer escolha.
        loc_oPnl.lbl_4c_Label5.Visible    = .F.
        loc_oPnl.obj_4c_OptTipo.Visible   = .F.
        loc_oPnl.lbl_4c_Label6.Visible    = .F.
        loc_oPnl.obj_4c_OptPreco.Visible  = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de acao (Grupo_Botao original). Buttons(1)
    * "\<Processar" (cmdok) e Buttons(2) "Encerrar" (cmdsair) com Caption/
    * Picture/fontes/cores EXATOS do dump (SECAO 2, Grupo_Botao). Os Click
    * sao ligados por BINDEVENT em ConfigurarEventos: Buttons(1) ->
    * BtnProcessarClick e Buttons(2) -> BtnEncerrarClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("obj_4c_Grupo_Botao", "CommandGroup")
        WITH THIS.obj_4c_Grupo_Botao
            .Top           = -2
            .Left          = 645
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Visible       = .T.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption    = "\<Processar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga os eventos do legado aos handlers deste form.
    *
    * BINDEVENT exige metodo PUBLIC (regra #3 do CLAUDE.md) - por isso os
    * handlers Btn*Click/Cbo*InteractiveChange abaixo nao levam PROTECTED.
    *
    * Legado (SECAO 3 de tasks\task627\sigprila_form_codigo_fonte.txt):
    *   Grupo_Botao.cmdok.Click                -> ChecaPlanilha()/Processamento()
    *   Grupo_Botao.cmdsair.Click              -> thisform.Release
    *   cntplanilha.cmdgetp.Click              -> GetFile('xls','Planilha','Importar')
    *   cntplanilha.cmbTipos.InteractiveChange -> ThisForm.Completalista()
    *   cntplanilha.GetPlanilha.When           -> corpo VAZIO no dump (nada a ligar)
    *
    * O legado tem UM Click por BOTAO do CommandGroup, entao a ligacao eh em
    * Buttons(1)/Buttons(2) (padrao do projeto: FormGr1/FormCliente), nao no
    * Click do grupo - assim cada botao mantem o handler que o dump declara.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oPnl, loc_oGrp

        loc_oGrp = THIS.obj_4c_Grupo_Botao
        IF VARTYPE(loc_oGrp) = "O"
            IF loc_oGrp.ButtonCount >= 2
                BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnProcessarClick")
                BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
            ENDIF
        ENDIF

        loc_oPnl = THIS.cnt_4c_planilha
        IF VARTYPE(loc_oPnl) = "O"
            IF PEMSTATUS(loc_oPnl, "cmd_4c_Cmdgetp", 5)
                BINDEVENT(loc_oPnl.cmd_4c_Cmdgetp, "Click", THIS, "BtnGetPlanilhaClick")
            ENDIF
            IF PEMSTATUS(loc_oPnl, "cbo_4c_CmbTipos", 5)
                BINDEVENT(loc_oPnl.cbo_4c_CmbTipos, "InteractiveChange", ;
                          THIS, "CboTiposInteractiveChange")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencheTipo - Monta o cursor ComboTipo (as 7 rotinas de importacao) e
    * liga cmbTipos a ele. Transcricao literal de SIGPRILA.PreencheTipo
    * (dump, linha 2129): o array aComboTipo tem 3 colunas por rotina -
    *   1) Titulo exibido no combo
    *   2) Nome da rotina (tambem a chave de acesso em fChecaAcesso)
    *   3) Lista "Titulo da coluna,Campo <tipo>" que define a ORDEM das
    *      colunas da planilha e a estrutura de TmpPlanilha ("|" eh virgula
    *      escapada, trocada por "," em CriaPlanilha)
    *
    * As strings da coluna 3 sao REGRA DE NEGOCIO (definem a leitura do .xls
    * posicao por posicao) e estao transcritas caractere a caractere do dump,
    * inclusive os espacos em sobra dos titulos - mudar qualquer uma delas
    * desloca a leitura da planilha inteira.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencheTipo()
        LOCAL loc_nI, loc_oCombo
        LOCAL ARRAY loc_aComboTipo[7, 3]

        IF USED("ComboTipo")
            USE IN ComboTipo
        ENDIF
        CREATE CURSOR ComboTipo (Titulo C(20), Rotina C(20), ColunaLi M)

        loc_aComboTipo[1, 1] = "Lista de Pre" + CHR(231) + "o"
        loc_aComboTipo[1, 2] = "ListaPreco"
        loc_aComboTipo[1, 3] = "Empresa,Emps c(3), Nome da Lista,NomeLista c(20)," + ;
                               "C" + CHR(243) + "digo Produto,cPros c(14),Valor ,Valor c(16)," + ;
                               "Data Inicial,DataIni d,Data Final,DataFim d,Preco De ,PrecoDe c(16)"

        loc_aComboTipo[2, 1] = "Transferencia"
        loc_aComboTipo[2, 2] = "GeraTransf"
        loc_aComboTipo[2, 3] = "Empresa Origem,EmpresaO c(6),Empresa Destino,EmpresaD c(6)," + ;
                               "Categoria ,Categoria c(10),Colecao,Colecao c(20),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Grupo,Grupo c(10),Prazo Entrega ,prazo d," + ;
                               "Codigo Barra,CBars n(14|0),Cor,Cors c(4),Tamanho,Tams c(4) "

        loc_aComboTipo[3, 1] = "Precificacao"
        loc_aComboTipo[3, 2] = "AtuaPreco"
        loc_aComboTipo[3, 3] = "Referencia,Referencia c(20),Data Inicio,dtInicial d," + ;
                               "Data Termino,dtFinal d,Valor Venda,PrecoVen c(16)," + ;
                               "Preco Especial,PrecoEsp c(16),Produto Off,ProdOff c(1)"

        loc_aComboTipo[4, 1] = "Pedido Terceiro"
        loc_aComboTipo[4, 2] = "GeraPedido"
        loc_aComboTipo[4, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                               "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

        loc_aComboTipo[5, 1] = "Pedido Consignado"
        loc_aComboTipo[5, 2] = "Pedidocons"
        loc_aComboTipo[5, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                               "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

        loc_aComboTipo[6, 1] = "Pedido Fabrica"
        loc_aComboTipo[6, 2] = "PedidoFab"
        loc_aComboTipo[6, 3] = "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5), " + ;
                               "Valor ,Units n(12|5),Moeda,Moedas c(3),Prazo ,prazoents d," + ;
                               "Movimentacao, Dopes c(20)"

        loc_aComboTipo[7, 1] = "Pedido Acessorio"
        loc_aComboTipo[7, 2] = "PedAcesso"
        loc_aComboTipo[7, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                               "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

        *-- Legado: so entra no combo a rotina a que o usuario tem acesso
        FOR loc_nI = 1 TO ALEN(loc_aComboTipo, 1)
            IF fChecaAcesso("SIGPRILA", UPPER(loc_aComboTipo[loc_nI, 2]))
                INSERT INTO ComboTipo (Titulo, Rotina, ColunaLi) ;
                    VALUES (loc_aComboTipo[loc_nI, 1], ;
                            loc_aComboTipo[loc_nI, 2], ;
                            loc_aComboTipo[loc_nI, 3])
            ENDIF
        ENDFOR

        SELECT ComboTipo
        GO TOP

        loc_oCombo = THIS.cnt_4c_planilha.cbo_4c_CmbTipos
        WITH loc_oCombo
            .RowSourceType = 6
            .RowSource     = "ComboTipo.Titulo,Rotina,ColunaLi"
            .Style         = 2
            .ColumnCount   = 1
        ENDWITH

        *-- Legado (fim de PreencheTipo): os dois blocos opcionais nascem
        *-- ocultos e so CompletaLista os exibe, conforme o tipo escolhido
        WITH THIS.cnt_4c_planilha
            .lbl_4c_Label5.Visible   = .F.
            .obj_4c_OptTipo.Visible  = .F.
            .lbl_4c_Label6.Visible   = .F.
            .obj_4c_OptPreco.Visible = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTipo - Posiciona o cursor ComboTipo na rotina escolhida em
    * cmbTipos e carrega Rotina/ColunaLi no BO (sigprilaBO.CarregarDoCursor).
    *
    * O legado le ComboTipo.Titulo/Rotina/ColunaLi logo depois de um "Select
    * ComboTipo", contando com o ponteiro que o RowSourceType = 6 (Fields)
    * move ao escolher o item. Aqui o ponteiro eh CONFIRMADO por LOCATE sobre
    * o Titulo (que eh o .Value do combo, BoundColumn = 1): mesmo resultado do
    * legado, sem depender do efeito colateral do binding.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SelecionarTipo()
        LOCAL loc_cTitulo, loc_lAchou
        loc_lAchou = .F.

        IF USED("ComboTipo")
            loc_cTitulo = ALLTRIM(THIS.cnt_4c_planilha.cbo_4c_CmbTipos.Value)
            SELECT ComboTipo
            IF !EMPTY(loc_cTitulo)
                LOCATE FOR ALLTRIM(ComboTipo.Titulo) == loc_cTitulo
                loc_lAchou = FOUND()
            ENDIF
            IF !loc_lAchou AND !EOF("ComboTipo")
                loc_lAchou = .T.
            ENDIF
            IF loc_lAchou AND VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CarregarDoCursor("ComboTipo")
            ENDIF
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CompletaLista - Transcricao de SIGPRILA.CompletaLista (dump, linha 744).
    * Carrega em List1 a ordem de colunas da rotina escolhida e exibe/oculta
    * os dois blocos opcionais conforme o Titulo - os nomes testados no
    * INLIST sao os do legado, sem acento, e definem a regra:
    *   Validar (Say5/OptTipo)  -> Transferencia, Precificacao e os 4 Pedidos
    *   Preco   (Say6/OptPreco) -> somente os 4 Pedidos
    *--------------------------------------------------------------------------
    PROCEDURE CompletaLista()
        LOCAL loc_cTitulo, loc_oPnl

        IF !USED("ComboTipo")
            RETURN
        ENDIF

        THIS.SelecionarTipo()

        loc_oPnl    = THIS.cnt_4c_planilha
        loc_cTitulo = UPPER(ALLTRIM(ComboTipo.Titulo))

        loc_oPnl.obj_4c_List1.RowSourceType = 1
        loc_oPnl.obj_4c_List1.RowSource     = ALLTRIM(ComboTipo.ColunaLi)

        IF INLIST(loc_cTitulo, "TRANSFERENCIA", "PRECIFICACAO", "PEDIDO TERCEIRO", ;
                               "PEDIDO CONSIGNADO", "PEDIDO FABRICA", "PEDIDO ACESSORIO")
            loc_oPnl.lbl_4c_Label5.Visible  = .T.
            loc_oPnl.obj_4c_OptTipo.Visible = .T.
        ELSE
            loc_oPnl.lbl_4c_Label5.Visible  = .F.
            loc_oPnl.obj_4c_OptTipo.Visible = .F.
        ENDIF

        IF INLIST(loc_cTitulo, "PEDIDO TERCEIRO", "PEDIDO CONSIGNADO", ;
                               "PEDIDO FABRICA", "PEDIDO ACESSORIO")
            loc_oPnl.lbl_4c_Label6.Visible   = .T.
            loc_oPnl.obj_4c_OptPreco.Visible = .T.
        ELSE
            loc_oPnl.lbl_4c_Label6.Visible   = .F.
            loc_oPnl.obj_4c_OptPreco.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CriaPlanilha - Transcricao de SIGPRILA.CriaPlanilha (dump, linha 769).
    * Valida tipo e arquivo, monta TmpPlanilha com a estrutura da coluna 2 da
    * List1 (trocando "|" por ",") e importa o .xls com APPEND FROM ... TYPE
    * XL5. Descarta a 1a linha quando ChkCabecalho esta marcado.
    *
    * SET SAFETY eh salvo/desligado/restaurado em volta do CREATE TABLE: o
    * legado roda com SAFETY OFF do ambiente Fortyus e um dialogo de
    * sobrescrita travaria a tela (regra #6 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CriaPlanilha()
        LOCAL loc_lSucesso, loc_cComando, loc_nCnt, loc_cPasta, loc_cArquivo
        LOCAL loc_cSafety, loc_lLeu, loc_oErro, loc_oPnl
        loc_lSucesso = .F.
        loc_oPnl     = THIS.cnt_4c_planilha

        IF EMPTY(loc_oPnl.cbo_4c_CmbTipos.Value)
            MsgErro("Tipo Inv" + CHR(225) + "lido", "")
            loc_oPnl.cbo_4c_CmbTipos.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_oPnl.txt_4c_Planilha.Value)
            MsgErro("Arquivo Inv" + CHR(225) + "lido", "")
            loc_oPnl.cmd_4c_Cmdgetp.SetFocus()
            RETURN .F.
        ENDIF

        IF USED("TmpPlanilha")
            USE IN TmpPlanilha
        ENDIF

        loc_cPasta = ADDBS(SYS(5) + SYS(2003))

        *-- Estrutura de TmpPlanilha: coluna 2 de cada item de List1
        loc_cComando = "CREATE TABLE TmpPlanilha ("
        FOR loc_nCnt = 1 TO loc_oPnl.obj_4c_List1.ListCount
            loc_cComando = loc_cComando + loc_oPnl.obj_4c_List1.List(loc_nCnt, 2) + ","
        ENDFOR

        IF RIGHT(loc_cComando, 1) = ","
            loc_cComando = SUBSTR(loc_cComando, 1, LEN(loc_cComando) - 1)
        ENDIF

        loc_cComando = loc_cComando + ")"
        loc_cComando = STRTRAN(loc_cComando, "|", ",")

        loc_cSafety = SET("Safety")
        SET SAFETY OFF

        loc_lLeu = .F.
        TRY
            *-- O DELETE FILE fica DENTRO do TRY: TmpPlanilha.dbf aberto por
            *-- outro processo (a propria planilha/sessao anterior) faz o
            *-- comando estourar "File access is denied", e o legado, que o
            *-- deixa solto, exibe nesse caso o Program Error cru do VFP. Aqui
            *-- a falha cai no CATCH e sai pela mensagem do proprio legado
            *-- ("Verifique se a planilha nao esta aberta..."), que descreve
            *-- exatamente essa situacao.
            IF FILE(loc_cPasta + "TmpPlanilha.dbf")
                DELETE FILE (loc_cPasta + "TmpPlanilha.dbf")
            ENDIF

            &loc_cComando

            SELECT TmpPlanilha
            loc_cArquivo = ALLTRIM(loc_oPnl.txt_4c_Planilha.Value)
            APPEND FROM (loc_cArquivo) TYPE XL5
            loc_lLeu = .T.
        CATCH TO loc_oErro
            loc_lLeu = .F.
        ENDTRY

        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        IF loc_lLeu
            SELECT TmpPlanilha
            IF loc_oPnl.chk_4c_ChkCabecalho.Value = 1
                GO TOP
                DELETE
            ENDIF
            loc_lSucesso = .T.
        ELSE
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar o cursor tempor" + ;
                    CHR(225) + "rio." + CHR(13) + ;
                    "Verifique se a planilha n" + CHR(227) + "o est" + CHR(225) + ;
                    " aberta ou que esteja salva com o Formato :" + CHR(13) + ;
                    "Microsoft Excel 5.0/95 (.xls)", ;
                    "Problema na Leitura da Planilha")
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMetodoRotina - Traduz o nome da rotina do legado (ComboTipo.Rotina)
    * para o nome do metodo correspondente em sigprilaBO. O legado chama o
    * metodo por macro no PROPRIO form ("ThisForm." + Rotina + "()"); na
    * arquitetura em camadas a importacao eh regra de negocio e mora no BO,
    * com nomes proprios (PILAR 3). Rotina desconhecida devolve "".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterMetodoRotina(par_cRotina)
        LOCAL loc_cRotina, loc_cMetodo
        loc_cRotina = UPPER(ALLTRIM(IIF(VARTYPE(par_cRotina) = "C", par_cRotina, "")))
        loc_cMetodo = ""

        DO CASE
            CASE loc_cRotina == "LISTAPRECO"
                loc_cMetodo = "ImportarListaPreco"
            CASE loc_cRotina == "GERATRANSF"
                loc_cMetodo = "ImportarTransferencia"
            CASE loc_cRotina == "ATUAPRECO"
                loc_cMetodo = "ImportarPrecificacao"
            CASE loc_cRotina == "GERAPEDIDO"
                loc_cMetodo = "ImportarPedidoTerceiro"
            CASE loc_cRotina == "PEDIDOCONS"
                loc_cMetodo = "ImportarPedidoConsignado"
            CASE loc_cRotina == "PEDIDOFAB"
                loc_cMetodo = "ImportarPedidoFabrica"
            CASE loc_cRotina == "PEDACESSO"
                loc_cMetodo = "ImportarPedidoAcessorio"
        ENDCASE

        RETURN loc_cMetodo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidaCols - Transcricao de SIGPRILA.ValidaCols (dump, linha 2226):
    *     Lparameters pFrm, pPar
    *     Return (Vartype(pFrm.ReadMethod(pPar))=[C])
    * O legado pergunta "o objeto possui a rotina com este nome?" lendo o
    * fonte do metodo com ReadMethod (que so devolve Caractere quando o metodo
    * existe). O equivalente aqui eh PEMSTATUS sobre o objeto que hospeda a
    * rotina - o BO -, usando o nome traduzido por ObterMetodoRotina. Quando
    * devolve .F., Processamento exibe a MESMA mensagem do legado
    * ("Metodo <rotina> nao localizado"), que eh o ponto onde a falta de uma
    * rotina aparece ALTO para o usuario, exatamente como no original.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidaCols(par_oDestino, par_cRotina)
        LOCAL loc_cMetodo, loc_lOk
        loc_lOk     = .F.
        loc_cMetodo = THIS.ObterMetodoRotina(par_cRotina)

        IF !EMPTY(loc_cMetodo) AND VARTYPE(par_oDestino) = "O"
            loc_lOk = PEMSTATUS(par_oDestino, loc_cMetodo, 5)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarRotinaImportacao - Substitui a macro do legado
    *     lcRotina = 'ThisForm.'+Alltrim(ComboTipo.Rotina)+[()]
    *     &lcRotina
    * chamando o metodo correspondente em sigprilaBO. O nome so chega aqui
    * depois de ValidaCols confirmar que ele existe no BO, entao a chamada
    * por EVALUATE (regra #15 - leitura/chamada por nome montado) nao cai em
    * membro inexistente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarRotinaImportacao(par_cRotina)
        LOCAL loc_cMetodo, loc_oBO, loc_uRetorno, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cMetodo  = THIS.ObterMetodoRotina(par_cRotina)
        loc_oBO      = THIS.this_oBusinessObject

        IF !EMPTY(loc_cMetodo) AND VARTYPE(loc_oBO) = "O"
            TRY
                loc_uRetorno = EVALUATE("loc_oBO." + loc_cMetodo + "()")
                loc_lSucesso = IIF(VARTYPE(loc_uRetorno) = "L", loc_uRetorno, .T.)
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro na importa" + CHR(231) + CHR(227) + "o da planilha")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processamento - Transcricao de SIGPRILA.Processamento (dump, linha 2203):
    *   If ThisForm.CriaPlanilha()
    *       If ThisForm.ValidaCols(ThisForm, Alltrim(ComboTipo.Rotina))
    *           If MessageBox(<aviso de ordem das colunas>,4+64+256,'') = 6
    *               &('ThisForm.'+Rotina+'()')
    *           EndIf
    *       Else
    *           MessageBox('Metodo '+Rotina+' nao localizado',16,'')
    *       EndIf
    *   EndIf
    *   thisform.cntplanilha.getPlanilha.Value = ''
    *
    * O texto do aviso eh literal do legado (4+64+256 = Sim/Nao com default no
    * Nao -> MsgConfirma, que devolve LOGICAL, regra #7) e a limpeza final do
    * campo Planilha roda em QUALQUER caminho, igual ao dump.
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_cRotina, loc_cAviso

        *-- FormParaBO ANTES do CriaPlanilha (o legado nao tem este hook: le os
        *-- controles direto, em cada rotina). Transferir primeiro garante que o
        *-- BO espelhe a tela em TODO caminho - inclusive quando CriaPlanilha
        *-- recusa o tipo/arquivo -, o que o BOParaForm do fim depende para nao
        *-- devolver criterio de uma execucao ANTERIOR por cima do que o usuario
        *-- acabou de marcar. Nenhuma mudanca de comportamento: CriaPlanilha le
        *-- cbo_4c_CmbTipos/List1/txt_4c_Planilha, nao o ponteiro de ComboTipo.
        THIS.FormParaBO()

        IF THIS.CriaPlanilha()
            loc_cRotina = ALLTRIM(THIS.this_oBusinessObject.this_cRotina)

            IF THIS.ValidaCols(THIS.this_oBusinessObject, loc_cRotina)
                loc_cAviso = "Aten" + CHR(231) + CHR(227) + "o, a ordem das colunas " + ;
                             CHR(233) + " muito importante. Certifique-se que elas est" + ;
                             CHR(227) + "o corretas." + CHR(13) + ;
                             "Ordem incorreta resultar" + CHR(225) + " em uma importa" + ;
                             CHR(231) + CHR(227) + "o incorreta, e este processo " + ;
                             CHR(233) + " irrevers" + CHR(237) + "vel." + CHR(13) + ;
                             "Tem certeza que deseja continuar a importa" + CHR(231) + ;
                             CHR(227) + "o com a ordem selecionada"

                IF MsgConfirma(loc_cAviso, "")
                    THIS.ExecutarRotinaImportacao(loc_cRotina)
                ENDIF
            ELSE
                MsgErro("M" + CHR(233) + "todo " + loc_cRotina + " n" + CHR(227) + ;
                        "o localizado", "")
            ENDIF
        ENDIF

        *-- "thisform.cntplanilha.getPlanilha.Value = ''" do legado, em UM lugar
        *-- so: limpa a property e deixa o BOParaForm espelhar no campo. Antes a
        *-- limpeza era escrita DUAS vezes (campo e property), que eh a origem da
        *-- divergencia silenciosa entre tela e BO.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cArquivoPlanilha = ""
        ENDIF
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere o estado da tela para sigprilaBO antes de rodar a
    * rotina de importacao. PROTECTED EXPLICITO: FormBase declara este hook
    * como PROTECTED e o VFP9 nao deixa a subclasse alargar o escopo.
    *
    * chk_4c_ChkCabecalho.Value eh NUMERICO (0/1) e vai para uma property
    * LOGICA do BO - a conversao eh explicita, nunca atribuicao direta.
    * OptionGroup.Value ja eh o INDICE 1-based das opcoes (OptTipo 1..3,
    * OptPreco 1..2), igual ao que o legado le em lnTipo/lnTpPre.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPnl, loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"
            *-- Rotina/ColunaLi vem da linha corrente de ComboTipo
            THIS.SelecionarTipo()

            loc_oPnl = THIS.cnt_4c_planilha
            loc_oBO.this_cArquivoPlanilha = ALLTRIM(loc_oPnl.txt_4c_Planilha.Value)
            loc_oBO.this_lIncluiCabecalho = (loc_oPnl.chk_4c_ChkCabecalho.Value = 1)
            loc_oBO.this_nTipoBusca       = loc_oPnl.obj_4c_OptTipo.Value
            loc_oBO.this_nTipoPreco       = loc_oPnl.obj_4c_OptPreco.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Caminho inverso do FormParaBO: devolve a tela o estado dos
    * criterios guardado em sigprilaBO. PROTECTED EXPLICITO: FormBase declara
    * este hook como PROTECTED e o VFP9 nao deixa a subclasse alargar o escopo
    * (o mesmo motivo do FormParaBO acima).
    *
    * O legado nao tem este hook - cada rotina le os controles direto
    * (ThisForm.cntplanilha.OptTipo.Value, ...), entao tela e criterio sao a
    * MESMA coisa la. Na arquitetura em camadas o criterio mora no BO, e quem
    * o altera fora da tela precisa de um caminho de volta: eh o que o fim do
    * Processamento usa para reproduzir o "getPlanilha.Value = ''" do legado
    * sem escrever a limpeza duas vezes, e o que o InicializarForm usa para o
    * painel abrir no estado do BO.
    *
    * Conversoes espelhadas, nunca atribuicao direta (regras do CLAUDE.md):
    *   property LOGICA -> chk_4c_ChkCabecalho.Value, que eh NUMERICO (0/1);
    *   OptionGroup.Value eh INDICE 1-based - valor fora de faixa (0, vindo de
    *   property nao inicializada) atribuido a um OptionGroup deixa TODOS os
    *   botoes desmarcados, por isso o piso de 1 e o teto do ButtonCount.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPnl, loc_oBO, loc_nTipo, loc_nPreco

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oPnl = THIS.cnt_4c_planilha
        IF VARTYPE(loc_oPnl) != "O"
            RETURN
        ENDIF

        loc_oPnl.txt_4c_Planilha.Value = ALLTRIM(loc_oBO.this_cArquivoPlanilha)
        loc_oPnl.chk_4c_ChkCabecalho.Value = IIF(loc_oBO.this_lIncluiCabecalho, 1, 0)

        loc_nTipo = loc_oBO.this_nTipoBusca
        IF loc_nTipo < 1 OR loc_nTipo > loc_oPnl.obj_4c_OptTipo.ButtonCount
            loc_nTipo = 1
        ENDIF
        loc_oPnl.obj_4c_OptTipo.Value = loc_nTipo

        loc_nPreco = loc_oBO.this_nTipoPreco
        IF loc_nPreco < 1 OR loc_nPreco > loc_oPnl.obj_4c_OptPreco.ButtonCount
            loc_nPreco = 1
        ENDIF
        loc_oPnl.obj_4c_OptPreco.Value = loc_nPreco
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Legado: Grupo_Botao.cmdok.Click
    *     If Thisform.Planilha / ThisForm.ChecaPlanilha() / Else /
    *     ThisForm.Processamento() / EndIf
    *
    * O ramo .T. eh MORTO no legado: ThisForm.Planilha (espelhado em
    * sigprilaBO.this_lPlanilha) nasce .F. e nao eh atribuido em lugar nenhum
    * do dump, e o metodo ChecaPlanilha NAO EXISTE no SCX (nao aparece na
    * SECAO 3). Transcrever a chamada produziria exatamente o defeito da
    * regra #13 do CLAUDE.md - nome desconhecido compila limpo e estoura em
    * runtime procurando "checaplanilha.prg" -, entao so o caminho vivo
    * (Processamento) eh portado, com o estado morto preservado como
    * propriedade do BO para fidelidade de PILAR 1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro

        TRY
            THIS.Processamento()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao processar a planilha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Legado: Grupo_Botao.cmdsair.Click -> thisform.Release
    * Fecha a tela. Tambem eh o destino do ESC (KeyPress do form), como no
    * legado, que chama "thisform.grupo_Botao.cmdsair.Click".
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGetPlanilhaClick - Legado: cntplanilha.cmdgetp.Click
    *     This.Parent.getPlanilha.Value = GetFile('xls','Planilha','Importar')
    * GETFILE devolve "" quando o usuario cancela - o legado grava esse vazio
    * no campo, limpando a selecao anterior, e esse comportamento eh mantido.
    *--------------------------------------------------------------------------
    PROCEDURE BtnGetPlanilhaClick()
        LOCAL loc_cArquivo, loc_oErro

        TRY
            loc_cArquivo = GETFILE("xls", "Planilha", "Importar")
            THIS.cnt_4c_planilha.txt_4c_Planilha.Value = loc_cArquivo

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cArquivoPlanilha = ALLTRIM(loc_cArquivo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao selecionar a planilha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CboTiposInteractiveChange - Legado: cntplanilha.cmbTipos.
    * InteractiveChange -> ThisForm.Completalista()
    *--------------------------------------------------------------------------
    PROCEDURE CboTiposInteractiveChange()
        LOCAL loc_oErro

        TRY
            THIS.CompletaLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao trocar o tipo de importa" + ;
                    CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Legado: SIGPRILA.KeyPress
    *     LPARAMETERS nKeyCode, nShiftAltCtrl
    *     If nKeyCode = 27 / thisform.grupo_Botao.cmdsair.Click / EndIf
    * KeyPreview = .T. na classe garante que o FORM veja a tecla antes dos
    * controles - o SCX nao declara a propriedade (fica no default .F.), mas
    * sem ela o handler de ESC que o legado escreveu nunca dispararia com o
    * foco dentro do combo/lista/campo, e o ESC eh a saida que o usuario
    * espera desta tela (PILAR 1 - comportamento pretendido pelo legado).
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.BtnEncerrarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis apos
    * AddObject (que os cria com Visible = .F. por padrao).
    *
    * EXCECAO: lbl_4c_Label5/obj_4c_OptTipo/lbl_4c_Label6/obj_4c_OptPreco
    * nascem com Visible = .F. de proposito (ConfigurarCamposPlanilhaParte2 -
    * CompletaLista() do legado so os exibe para tipos de importacao
    * especificos). Pular a atribuicao de Visible para esses nomes, mas
    * continuar recursando dentro deles (caso de obj_4c_OptTipo/obj_4c_OptPreco,
    * que sao containers com Buttons filhos) para nao deixar os filhos
    * Visible = .F. quando a visibilidade do grupo for restaurada depois.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p, loc_lPularVisible

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                loc_lPularVisible = INLIST(UPPER(loc_oControl.Name), ;
                    "LBL_4C_LABEL5", "OBJ_4C_OPTTIPO", ;
                    "LBL_4C_LABEL6", "OBJ_4C_OPTPRECO")

                IF !loc_lPularVisible AND PEMSTATUS(loc_oControl, "Visible", 5)
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
    * Destroy - Encerramento padrao (restauracao de menu herdada de FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprilaBO.prg):
*============================================================================
* sigprilaBO.prg - Business Object para Importacao de Planilhas (SIGPRILA)
*
* Form OPERACIONAL (SIGPRILA / Formsigprila): utilitario generico de
* importacao de planilha Excel (.xls) que alimenta SETE rotinas distintas,
* escolhidas pelo usuario no combo cntplanilha.cmbTipos (cursor ComboTipo,
* montado em PreencheTipo a partir do array aComboTipo e filtrado por
* fChecaAcesso):
*   1) ListaPreco  - atualiza SigCdLpc/SigCdLpi (listas de preco)
*   2) GeraTransf  - gera SigMvCab/SigMvItn/SigMvIts/SigMvHst de TRANSFERENCIA
*   3) AtuaPreco   - atualiza pVens/PrecoDe de SigCdPro + SigPrTam + historico
*                    em CrSigPrPre + grava CrSigImpPr (log de importacao)
*   4) GeraPedido  - gera movimento de PEDIDO TERCEIRO (SigMvCab/SigMvItn/...)
*   5) Pedidocons  - gera movimento de PEDIDO CONSIGNADO (mesma familia)
*   6) PedidoFab   - gera movimento de PEDIDO FABRICA (mesma familia)
*   7) PedAcesso   - gera movimento de PEDIDO ACESSORIO (mesma familia)
*
* NAO existe uma unica "tabela principal" para este processo (this_cTabela
* permanece vazio) - cada rotina grava num conjunto diferente de tabelas de
* movimento, conforme tasks/task627/comportamento.json. O cursor da propria
* planilha (TmpPlanilha) tem estrutura DINAMICA, montada em runtime a partir
* da coluna 3 (ColunaLi) do item escolhido em ComboTipo.
*
* Parametros do sistema usados pelas rotinas (carregados UMA UNICA VEZ no
* Init, igual ao legado que faz "=ThisForm.Podatamgr.SqlExecute([Select *
* From SigCdPac],[crSigCdPac])" e mantem o cursor vivo para o resto da vida
* do form): cursor_4c_SigCdPac (SigCdPac - traz, entre outros, SigKeys e os
* codigos de movimentacao padrao DopTrfPed/DopImpPlan/DopPedCon usados por
* GeraPedido/GeraTransf/Pedidocons) e cursor_4c_SigCdPam (SigCdPam - usado
* por LimiteCreditoMatriz: MoedaPs/ChqlCreds/MoeLimes/TpPrecos). Os metodos
* que implementam cada rotina (fases seguintes) leem esses cursores
* DIRETAMENTE (Select cursor_4c_SigCdPac / lcDopes = cursor_4c_SigCdPac.
* DopTrfPed), exatamente como o legado le crSigCdPac/crSigCdPam - evita
* duplicar cada campo de parametro numa property so para ser lido num unico
* lugar.
*
* ATENCAO (a resolver na fase que implementar PedAcesso): o legado le
* crSigCdPac.DopAcePed (dump, linha 3028), mas a coluna "dopaceped" NAO
* aparece em docs/schema.sql dentro de SigCdPac (colunas Dop* existentes:
* dopests, dopzers, dopetiqs, dopimpplan, dopvdaveco, dopecomm, doppenecom,
* dopenvops, dopcortam, doppedcon, doprbt, doptrfped, dopbxbrest). Conferir
* no banco (INFORMATION_SCHEMA) e no dump antes de implementar PedAcesso -
* regra #14 do CLAUDE.md (grep no schema.sql da falso-negativo por ser
* UTF-16; mas aqui a tabela foi lida com Get-Content -Raw e a coluna
* realmente nao aparece. Pode ser tabela/ambiente, ou grafia divergente).
*
* Helpers globais que as rotinas vao precisar (fases seguintes) e que JA
* EXISTEM em projeto\app\utils\functions.prg - nao reinventar: fUniqueIds,
* fGerUniqueKey, fGerMascara, fDtoSQL, fChecaAcesso, fBuscarCotacao.
* fCarregarCambio NAO foi portada (ver memoria) - a rotina Cotacao do
* legado nao usa fCarregarCambio, usa fBuscarCotacao direto, entao essa
* lacuna nao se aplica aqui.
*
* this_lPlanilha espelha ThisForm.Planilha do legado: a propriedade nunca e
* setada para .T. em lugar nenhum do dump e o metodo ChecaPlanilha (chamado
* no ramo .T. do cmdok.Click) nunca e definido - e um ramo morto do
* framework legado, mantido aqui so para fidelidade de propriedades
* (PILAR 1), sem comportamento associado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2+ - CarregarDoCursor / metodos de cada rotina de
*                importacao / Inserir/Atualizar (quando aplicavel)
*============================================================================

DEFINE CLASS sigprilaBO AS BusinessBase

    *==========================================================================
    * Espelho de propriedades customizadas do form legado SIGPRILA
    *==========================================================================
    this_lPlanilha       = .F.       && ThisForm.Planilha - sempre .F. no legado (ramo morto, ver cabecalho)
    this_cSigKey         = SPACE(3)  && ThisForm.SigKey <- cursor_4c_SigCdPac.SigKeys (Init) - usado para montar CIdChaves de historico (CrSigMvHst) em GeraPedido/GeraTransf/Pedidocons/PedidoFab/PedAcesso
    this_nValorAcumulado = 0         && ThisForm.ValorAcumulado - acumulador de valor usado por LimiteCreditoMatriz, resetado no inicio de cada rotina de importacao de movimento

    *==========================================================================
    * Selecao feita pelo usuario na pagina de importacao (cntplanilha) -
    * o Form preenche estas propriedades (FormParaBO, fase do Form) antes de
    * chamar a rotina escolhida
    *==========================================================================
    this_nTipoBusca       = 1        && cntplanilha.OptTipo.Value   (1=Codigo, 2=Descritivo, 3=Referencia Forn.) - define qual coluna de SigCdPro casa com o produto da planilha
    this_nTipoPreco       = 1        && cntplanilha.OptPreco.Value  (1=Venda, 2=Custo) - define se o valor gravado no movimento vem de PVens/Moevs ou de custofs/moecusfs
    this_cArquivoPlanilha = ""       && cntplanilha.GetPlanilha.Value - caminho completo do arquivo .xls selecionado pelo usuario (GetFile)
    this_lIncluiCabecalho = .F.      && cntplanilha.ChkCabecalho.Value - .T. = a 1a linha da planilha e cabecalho e deve ser descartada ao montar TmpPlanilha
    this_cRotina          = ""       && ComboTipo.Rotina  do item selecionado em cmbTipos (ListaPreco/GeraTransf/AtuaPreco/GeraPedido/Pedidocons/PedidoFab/PedAcesso)
    this_cColunaLi        = ""       && ComboTipo.ColunaLi do item selecionado - memo com a lista "Titulo,Campo c(N),..." que define a estrutura do cursor TmpPlanilha

    *==========================================================================
    * Estado das rotinas de importacao (fase 8 - rotinas de importacao)
    *==========================================================================
    this_tDataMovimento  = {}       && pDt do legado (fDtoSQL(Datetime())) - data/hora unica de todo o lote da importacao, usada em Datars/DataS de SigMvCab e SigMvHst
    this_dDataMovimento  = {}       && a mesma data como DATE, para as conversoes de cotacao (fBuscarCotacao espera DATE)
    this_cTamValidado    = ""       && tamanho normalizado por ValidarProdutoGrupo (vazio quando o codigo nao existe em SigCdTam)
    this_cCorValidado    = ""       && cor normalizada por ValidarProdutoGrupo (vazio quando o codigo nao existe em SigCdCor)
    this_cRotinaAuditada = ""       && rotina + movimentacao/arquivo que identifica a operacao no LogAuditoria

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo (cada rotina grava em tabelas de movimento
    * diferentes), mas carrega uma unica vez os cursores de parametros do
    * sistema (SigCdPac/SigCdPam) usados pelas rotinas de importacao
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

            IF USED("cursor_4c_SigCdPac")
                USE IN cursor_4c_SigCdPac
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPac", "cursor_4c_SigCdPac")

            IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                THIS.this_cSigKey = PADR(TratarNulo(cursor_4c_SigCdPac.SigKeys, ""), 3)
            ENDIF

            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "cursor_4c_SigCdPam")

        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades de selecao do BO (rotina
    * escolhida e estrutura da planilha correspondente) a partir da linha
    * corrente do cursor ComboTipo (colunas Titulo/Rotina/ColunaLi, montado
    * pelo Form em PreencheTipo a partir do array aComboTipo). Nao ha
    * "registro" no sentido CRUD classico neste BO - a linha carregada eh a
    * opcao de importacao marcada pelo usuario em cntplanilha.cmbTipos.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cRotina   = TratarNulo(Rotina, "C")
            THIS.this_cColunaLi = TratarNulo(ColunaLi, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao ha chave de registro unica (o processo grava
    * em varias tabelas de movimento, conforme a rotina escolhida). Usado so
    * para identificar a operacao no log de auditoria quando as rotinas de
    * importacao chamam THIS.RegistrarAuditoria().
    *
    * Devolve o valor CRU, sem EscaparSQL: quem escapa eh o
    * RegistrarAuditoria do BusinessBase, que ja monta o INSERT com
    * EscaparSQL(loc_cChave). Escapar aqui tambem gravaria a chave com as
    * aspas dentro do proprio dado.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cRotinaAuditada)

        IF EMPTY(loc_cChave)
            loc_cChave = ALLTRIM(THIS.this_cRotina)
        ENDIF

        RETURN LEFT(loc_cChave, 20)
    ENDFUNC

    *==========================================================================
    * Inserir() / Atualizar() / ExecutarExclusao() - decisao de arquitetura:
    * este BO nao representa uma unica tabela/entidade, entao o
    * comportamento padrao herdado de BusinessBase para Inserir()/
    * Atualizar()/ExecutarExclusao() permanece correto aqui e NAO e
    * sobrescrito. Cada rotina de importacao (ListaPreco/GeraTransf/
    * AtuaPreco/GeraPedido/Pedidocons/PedidoFab/PedAcesso) grava num
    * conjunto diferente de tabelas legadas (SigCdLpc/SigCdLpi,
    * SigMvCab/SigMvItn/SigMvIts/SigMvHst, SigCdPro/SigPrTam/CrSigImpPr,
    * conforme tasks/task627/comportamento.json) usando SQLEXEC proprio de
    * cada metodo de rotina (fases seguintes), e cada um desses metodos
    * chama THIS.RegistrarAuditoria() com a operacao e a chave
    * (ObterChavePrimaria) apropriadas apos gravar - nao ha um unico ponto
    * central de insercao/atualizacao de registro onde encaixar um hook
    * generico.
    *==========================================================================


    *==========================================================================
    * INFRAESTRUTURA - substitutos do fSqlConector (poDataMgr) do legado
    *
    * O legado conversa com o SQL Server por um objeto do Framework Fortyus
    * (ThisForm.poDataMgr = CreateObject("fSqlConector")) que oferece:
    *   CursorQuery(tabela, cursor, campo, valor [, colunas])  -> consulta 1 chave
    *   SqlExecute(sql [, cursor])                             -> SQL livre
    *   AddCursor(tabela, chave, cursor, ...) + Update(cursor) + Commit()
    *                                                          -> buffer + gravacao
    * Nada disso foi portado. Os metodos abaixo cobrem os dois primeiros casos
    * com SQLEXEC direto; o terceiro (AddCursor/Update/Commit) vira acumulacao
    * em cursor LOCAL + um unico lote T-SQL no fim de cada rotina (ver
    * ExecutarLoteAtomico e o cabecalho de CriarCursoresMovimento).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConsultarRegistro - equivalente de poDataMgr.CursorQuery(). Consulta UMA
    * chave e deixa o resultado no cursor informado. par_cColunas vazio = "*".
    *
    * O valor pode ser Caractere ou Numerico - o legado passa os dois
    * (CursorQuery([SigCdEmp],...,[Cemps],lcEmps) e
    * CursorQuery([SigOpEtq],...,[Cbars],lnBarra)) - por isso o literal eh
    * escolhido por VARTYPE e nao fixado em EscaparSQL: passar um numerico para
    * EscaparSQL devolveria string vazia e a consulta nao casaria com nada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarRegistro(par_cTabela, par_cCursor, par_cCampo, par_uValor, par_cColunas)
        LOCAL loc_cSQL, loc_cCols, loc_cVal, loc_nRes

        loc_cCols = IIF(VARTYPE(par_cColunas) = "C" AND !EMPTY(par_cColunas), ALLTRIM(par_cColunas), "*")

        DO CASE
            CASE VARTYPE(par_uValor) = "N"
                loc_cVal = FormatarNumeroSQL(par_uValor, 0)
            CASE VARTYPE(par_uValor) = "D" OR VARTYPE(par_uValor) = "T"
                loc_cVal = FormatarDataSQL(par_uValor)
            OTHERWISE
                loc_cVal = EscaparSQL(ALLTRIM(TratarNulo(par_uValor, "")))
        ENDCASE

        loc_cSQL = "SELECT " + loc_cCols + " FROM " + ALLTRIM(par_cTabela) + ;
                   " WHERE " + ALLTRIM(par_cCampo) + " = " + loc_cVal

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor)

        IF loc_nRes >= 0 AND USED(par_cCursor)
            SELECT (par_cCursor)
            GO TOP
        ENDIF

        RETURN loc_nRes
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarSQL - equivalente de poDataMgr.SqlExecute(). Com cursor devolve o
    * resultado nele; sem cursor executa comando (UPDATE/DELETE).
    *
    * O legado testa "< 1" para detectar falha. O SQLEXEC do VFP9 devolve -1 em
    * erro, 1 em sucesso com resultado e 0 em comando SEM resultado, entao
    * copiar o "< 1" reprovaria todo UPDATE/DELETE bem-sucedido. Aqui o retorno
    * eh normalizado (1 = ok, -1 = erro) e cada chamador testa "< 0".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor)
        LOCAL loc_nRes, loc_lTemCursor

        loc_lTemCursor = (VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor))

        IF loc_lTemCursor
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
            IF loc_nRes >= 0 AND USED(par_cCursor)
                SELECT (par_cCursor)
                GO TOP
            ENDIF
        ELSE
            loc_nRes = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        RETURN IIF(loc_nRes < 0, -1, 1)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarLoteAtomico - grava um lote de comandos T-SQL de forma ATOMICA,
    * substituindo o par Update(cursor)/Commit() do fSqlConector.
    *
    * NAO basta mandar "BEGIN TRANSACTION" + INSERTs + "COMMIT" por SQLEXEC:
    * medido neste ambiente, a conexao nasce com Transactions = 2 (MANUAL) e
    * @@TRANCOUNT ja vale 1, entao o BEGIN apenas ANINHA (vai para 2) e o
    * COMMIT volta para 1 SEM efetivar nada - a gravacao fica desprotegida e o
    * teste "gravou?" passa do mesmo jeito. Por isso o controle de transacao vai
    * em T-SQL, com SAVE TRANSACTION quando ja ha transacao aberta (o caso
    * normal aqui), para o ROLLBACK desfazer SO este lote e nao a transacao do
    * resto da aplicacao na mesma conexao. THROW faz o erro chegar ao SQLEXEC,
    * que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    *
    * Mesmo padrao de ProdutoBO.CopiarProduto (Erro188).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarLoteAtomico(par_cLote, par_cContexto)
        LOCAL loc_cSQL, loc_nRes, loc_lOk
        loc_lOk = .F.

        IF VARTYPE(par_cLote) != "C" OR EMPTY(par_cLote)
            RETURN .T.
        ENDIF

        loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
                   "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
                   "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
                   "ELSE SAVE TRANSACTION Imp4c;" + CHR(13) + CHR(10) + ;
                   "BEGIN TRY" + CHR(13) + CHR(10) + ;
                   par_cLote + ;
                   "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
                   "END TRY" + CHR(13) + CHR(10) + ;
                   "BEGIN CATCH" + CHR(13) + CHR(10) + ;
                   "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
                   "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Imp4c; END;" + CHR(13) + CHR(10) + ;
                   "THROW;" + CHR(13) + CHR(10) + ;
                   "END CATCH"

        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nRes < 0
            THIS.this_cMensagemErro = "Falha na grava" + CHR(231) + CHR(227) + "o dos dados" + ;
                                      IIF(VARTYPE(par_cContexto) = "C" AND !EMPTY(par_cContexto), ;
                                          " (" + ALLTRIM(par_cContexto) + ")", "") + ":" + ;
                                      CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            THIS.this_lErroExibido = .T.
        ELSE
            THIS.ConfirmarSeManual()
            loc_lOk = .T.
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfirmarSeManual - equivalente do Commit() do fSqlConector.
    *
    * A conexao deste ambiente nasce com Transactions = 2 (MANUAL), entao o que
    * foi gravado so eh efetivado num SQLCOMMIT explicito (ou no disconnect
    * limpo) - sem isto a importacao "funciona", nao exibe erro nenhum, e os
    * registros desaparecem se o processo morrer. O teste de Transactions deixa
    * o par inerte caso a conexao esteja em auto-commit.
    *
    * IF ANINHADO de proposito: VFP9 nao faz curto-circuito em AND, logo
    * "IF loc_lManual AND SQLCOMMIT(...)" chamaria o SQLCOMMIT de qualquer jeito.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfirmarSeManual()
        LOCAL loc_lManual
        loc_lManual = .F.

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            IF loc_lManual
                SQLCOMMIT(gnConnHandle)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNum - monta a chave EmpDopNums, que eh POSICIONAL:
    *   SigMvCab/SigMvItn/SigMvIts/SigMvHst.EmpDopNums = char(29)
    *   Emps char(3) + Dopes char(20) + Str(Numes, 6) = 3 + 20 + 6 = 29
    *
    * O legado monta "lcEmps + lcDopes + Str(lnNumes,6)" SEM ALLTRIM porque os
    * valores vem das COLUNAS, ja com o padding. Aqui as partes chegam de
    * locais que passaram por ALLTRIM, entao o PADR eh EXPLICITO - encurtar
    * qualquer parte desloca o resto da chave, e dai o SELECT/UPDATE roda SEM
    * ERRO devolvendo ZERO linhas (sem excecao, sem log, so a grade vazia).
    * A conferencia eh a largura do destino: 3 + 20 + 6 TEM de dar 29.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarChaveEmpDopNum(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(ALLTRIM(TratarNulo(par_cEmps, "")), 3) + ;
               PADR(ALLTRIM(TratarNulo(par_cDopes, "")), 20) + ;
               STR(par_nNumes, 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarChaveEmpGruEst - monta EmpGruEsts, tambem POSICIONAL:
    *   SigMvHst.EmpGruEsts = char(23)
    *   Emps char(3) + Grupos char(10) + Estos char(10) = 3 + 10 + 10 = 23
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarChaveEmpGruEst(par_cEmps, par_cGrupos, par_cEstos)
        RETURN PADR(ALLTRIM(TratarNulo(par_cEmps, "")), 3) + ;
               PADR(ALLTRIM(TratarNulo(par_cGrupos, "")), 10) + ;
               PADR(ALLTRIM(TratarNulo(par_cEstos, "")), 10)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCotacao - transcricao de SIGPRILA.Cotacao (dump, linha 3415).
    *
    * Devolve a cotacao da moeda, usando os cursores de apoio TmpCot (cache por
    * moeda) e TmpTotal (cotacao por moeda do movimento, que o legado grava
    * para nao perder a cotacao quando o valor do item ja esta convertido).
    * Preserva o comportamento do legado: se SigCdMoe.Cotas estiver desligado a
    * cotacao eh 1 (moeda nao cotada), e o alias corrente eh restaurado no fim.
    *
    * "If LocalMoe.Cotas" do legado NAO pode ser copiado ao pe da letra: Cotas
    * eh numeric no schema e VFP9 exige LOGICO em IF, entao a comparacao eh
    * explicita com <> 0 (uma coluna bit chega como Logico em alguns drivers e
    * como Numerico em outros, por isso o VARTYPE).
    *--------------------------------------------------------------------------
    FUNCTION ObterCotacao(par_cMoeda, par_xData)
        LOCAL loc_nCotacao, loc_cAlias, loc_cSQL, loc_dData, loc_lCotada, loc_nRes

        loc_cAlias  = ALIAS()
        loc_nCotacao = 1

        IF VARTYPE(par_xData) = "D" OR VARTYPE(par_xData) = "T"
            loc_dData = ConverterParaData(par_xData)
        ELSE
            loc_dData = THIS.this_dDataMovimento
        ENDIF

        IF !ISNULL(par_cMoeda) AND VARTYPE(par_cMoeda) = "C" AND !EMPTY(par_cMoeda)

            loc_cSQL = "SELECT Cotas FROM SigCdMoe WHERE Cmoes = " + ;
                       EscaparSQL(ALLTRIM(par_cMoeda))

            loc_nRes = THIS.ExecutarSQL(loc_cSQL, "cursor_4c_LocalMoe")

            IF loc_nRes < 0
                MsgErro("Favor reiniciar o Processo." + CHR(13) + CapturarErroSQL(), ;
                        "Falha de conex" + CHR(227) + "o (LocalMoe)")
                THIS.this_lErroExibido = .T.
                loc_nCotacao = -1
            ELSE
                loc_lCotada = .F.
                IF USED("cursor_4c_LocalMoe") AND !EOF("cursor_4c_LocalMoe")
                    IF VARTYPE(cursor_4c_LocalMoe.Cotas) = "L"
                        loc_lCotada = NVL(cursor_4c_LocalMoe.Cotas, .F.)
                    ELSE
                        loc_lCotada = (NVL(cursor_4c_LocalMoe.Cotas, 0) <> 0)
                    ENDIF
                ENDIF

                IF loc_lCotada AND !USED("cursor_4c_TmpCot")
                    *-- O cache de cotacao eh criado por CriarCursoresMovimento.
                    *-- Chamado fora de uma rotina de movimento, nao ha cache:
                    *-- consulta direto, sem cachear, em vez de estourar
                    *-- "alias nao encontrado" no SEEK.
                    loc_nCotacao = fBuscarCotacao(ALLTRIM(par_cMoeda), loc_dData, gnConnHandle)
                ENDIF

                IF loc_lCotada AND USED("cursor_4c_TmpCot")
                    IF !SEEK(PADR(ALLTRIM(par_cMoeda), 3), "cursor_4c_TmpCot", "Cmoes")
                        loc_nCotacao = fBuscarCotacao(ALLTRIM(par_cMoeda), loc_dData, gnConnHandle)
                        INSERT INTO cursor_4c_TmpCot (Cmoes, Valos) ;
                            VALUES (PADR(ALLTRIM(par_cMoeda), 3), loc_nCotacao)
                    ELSE
                        IF cursor_4c_TmpCot.Valos = 0
                            loc_nCotacao = fBuscarCotacao(ALLTRIM(par_cMoeda), loc_dData, gnConnHandle)
                            REPLACE Valos WITH loc_nCotacao IN cursor_4c_TmpCot
                        ENDIF
                        loc_nCotacao = cursor_4c_TmpCot.Valos
                    ENDIF

                    *-- Legado: grava a cotacao em TmpTotal porque o valor do
                    *-- item em SigMvItn ja vai convertido e a cotacao se perde
                    IF USED("cursor_4c_TmpTotal")
                        SELECT cursor_4c_TmpTotal
                        SET ORDER TO TAG Moeds
                        IF !SEEK(PADR(ALLTRIM(par_cMoeda), 3))
                            INSERT INTO cursor_4c_TmpTotal (Moeds) VALUES (PADR(ALLTRIM(par_cMoeda), 3))
                        ENDIF
                        REPLACE MoeVals WITH loc_nCotacao IN cursor_4c_TmpTotal
                    ENDIF
                ENDIF

                IF !loc_lCotada
                    loc_nCotacao = 1
                ENDIF
            ENDIF
        ENDIF

        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            SELECT (loc_cAlias)
        ENDIF

        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCambio - a funcao global fCarregarCambio(pMoe, pDia) do Framework
    * legado (SIGFUNCS.PRG) NAO foi portada para a nova arquitetura. Chamar o
    * nome diretamente cairia na regra #13 (VFP9 procura fcarregarcambio.prg no
    * PATH e estoura em RUNTIME, dentro do processamento).
    *
    * O proprio legado desta tela usa fBuscarCotacao (que EXISTE em
    * utils\functions.prg) no metodo Cotacao, para a mesma finalidade. Aqui a
    * conversao delega a ObterCotacao, que cacheia por moeda em TmpCot - mesmo
    * resultado e sem rede nova de dependencia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_xData)
        RETURN THIS.ObterCotacao(par_cMoeda, par_xData)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CriarCursoresMovimento - cria os cursores LOCAIS de acumulacao que, no
    * legado, eram views remotas criadas no Init por
    *     poDataMgr.AddCursor('SigMvCab','CIdChaves','CrSigMvCab','','')
    * e gravadas no fim por poDataMgr.Update('CrSigMvCab') (TABLEUPDATE).
    *
    * A acumulacao em cursor local tem de ser PRESERVADA (nao trocada por
    * INSERT direto no SQL Server durante o laco) porque o legado, DEPOIS de
    * terminar o SCAN, ainda:
    *   1) soma os itens por EmpDopNums e atualiza Valos no cabecalho;
    *   2) percorre CrSigMvCab chamando LimiteCreditoMatriz;
    *   3) grava tudo de uma vez e faz Rollback se qualquer passo falhar.
    * Gravar linha a linha quebraria 1, 2 e 3.
    *
    * As colunas declaradas aqui sao SO as que o legado preenche; o restante de
    * cada tabela entra no INSERT final com o valor do registro em branco (era
    * o que o APPEND BLANK + TABLEUPDATE do legado gravava) - ver
    * MontarLoteMovimento, que cobre TODA coluna NOT NULL sem DEFAULT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresMovimento()
        LOCAL loc_nSel
        loc_nSel = SELECT()

        THIS.FecharCursoresMovimento()

        SET NULL OFF

        CREATE CURSOR cursor_4c_MvCab ( ;
            Datars T, Datas T, Dopes C(20), Emps C(3), EmpDs C(3), Numes N(6, 0), ;
            MascNum C(10), GrupoOs C(10), ContaOs C(10), GrupoDs C(10), ContaDs C(10), ;
            CidChaves C(20), DtAlts T, EmpDopNums C(29), Usuals C(10), Usuars C(10), ;
            PrazoEnts D, GrupoCCs C(10), ContaCCs C(10), Valos N(11, 2))
        INDEX ON EmpDopNums TAG EmpDopNums

        CREATE CURSOR cursor_4c_MvItn ( ;
            CPros C(14), Dopes C(20), Emps C(3), Numes N(6, 0), Opers C(1), ;
            Qtds N(9, 3), CItens N(10, 0), Units N(15, 6), Totas N(11, 2), ;
            Moedas C(3), DPros C(65), AQtds N(9, 3), CUnis C(3), CidChaves C(20), ;
            DtAlts D, EmpDopNums C(29), Pesos N(9, 3), CodBarras N(14, 0))
        INDEX ON EmpDopNums TAG EmpDopNums

        CREATE CURSOR cursor_4c_MvIts ( ;
            Emps C(3), Dopes C(20), Numes N(6, 0), CPros C(14), CodTams C(4), ;
            CodCors C(4), Qtds N(9, 3), AQtds N(9, 3), CodBarras N(14, 0), ;
            Pesos N(9, 3), CidChaves C(20), EmpDopNums C(29), ChkSubn L, CItens N(4, 0))

        CREATE CURSOR cursor_4c_MvHst ( ;
            CPros C(14), Datars T, Datas T, Dopes C(20), EmpOs C(3), Emps C(3), ;
            Opers C(1), Numes N(6, 0), Qtds N(9, 3), Units N(15, 6), Totas N(11, 2), ;
            Grupos C(10), Estos C(10), CidChaves C(20), EmpDopNums C(29), ;
            EmpGruEsts C(23), OriDopNums C(29), Seqs N(10, 0), Pesos N(15, 3), ;
            Usuars C(10), CodBarras N(14, 0), CodTams C(4), CodCors C(4))

        *-- Cache de cotacao por moeda (TmpCot do legado) e cotacao por moeda do
        *-- movimento (TmpTotal), usados por ObterCotacao
        CREATE CURSOR cursor_4c_TmpCot (Cmoes C(3), Valos N(15, 6))
        INDEX ON Cmoes TAG Cmoes

        CREATE CURSOR cursor_4c_TmpTotal (Moeds C(3), MoeVals N(15, 6))
        INDEX ON Moeds TAG Moeds

        *-- Relatorios de excecao do legado (exportados em .XLS no fim)
        CREATE CURSOR cursor_4c_PrNaoCad ( ;
            Origem C(10), Destino C(10), Produto C(20), Quantidade N(12, 2), ;
            Grupo C(10), Barra N(14, 0), Cor C(4), Tamanho C(4))

        CREATE CURSOR cursor_4c_PrSemCT ( ;
            Referencia C(25), Unidade C(3), Qtds N(12, 2), Pesos N(12, 2), Valor N(12, 2))

        IF loc_nSel > 0
            SELECT (loc_nSel)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursoresMovimento - libera os cursores de acumulacao. Chamado no
    * inicio (para nao herdar linhas de uma importacao anterior - o form nao
    * fecha entre uma e outra) e no fim de cada rotina.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresMovimento()
        LOCAL loc_nI, loc_cCur
        LOCAL ARRAY loc_aCur[10]

        loc_aCur[1]  = "cursor_4c_MvCab"
        loc_aCur[2]  = "cursor_4c_MvItn"
        loc_aCur[3]  = "cursor_4c_MvIts"
        loc_aCur[4]  = "cursor_4c_MvHst"
        loc_aCur[5]  = "cursor_4c_TmpCot"
        loc_aCur[6]  = "cursor_4c_TmpTotal"
        loc_aCur[7]  = "cursor_4c_PrNaoCad"
        loc_aCur[8]  = "cursor_4c_PrSemCT"
        loc_aCur[9]  = "cursor_4c_Transf"
        loc_aCur[10] = "cursor_4c_TmpTot"

        FOR loc_nI = 1 TO ALEN(loc_aCur)
            loc_cCur = loc_aCur[loc_nI]
            IF USED(loc_cCur)
                USE IN (loc_cCur)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarBarraProgresso - o legado abre fwprogressbar em toda rotina. A classe
    * existe como stub em app\classes\fwprogressbar.prg; se por qualquer motivo
    * nao instanciar, a importacao NAO pode parar por causa da barra, entao a
    * falha devolve .NULL. e os chamadores testam VARTYPE antes de usar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CriarBarraProgresso(par_cTitulo, par_nTotal)
        LOCAL loc_oBarra, loc_oErro
        loc_oBarra = .NULL.

        TRY
            loc_oBarra = CREATEOBJECT("fwprogressbar", par_cTitulo, MAX(par_nTotal, 1))
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top - INT(loc_oBarra.Height / 2) - 1
                IF PEMSTATUS(loc_oBarra, "Titulo", 5)
                    loc_oBarra.Titulo.FontBold = .T.
                ENDIF
                loc_oBarra.Show()
            ENDIF
        CATCH TO loc_oErro
            *-- Nao interrompe a importacao: a barra eh so feedback visual.
            *-- O erro fica registrado para nao virar CATCH silencioso (regra #9).
            THIS.this_cMensagemErro = "Barra de progresso indispon" + CHR(237) + "vel: " + ;
                                      loc_oErro.Message
            loc_oBarra = .NULL.
        ENDTRY

        RETURN loc_oBarra
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarBarra / EncerrarBarra - encapsulam o Update/Complete do legado
    * com guarda de objeto, para a ausencia da barra nunca derrubar a rotina.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarBarra(par_oBarra, par_cTexto)
        IF VARTYPE(par_oBarra) = "O"
            par_oBarra.Update(.T., par_cTexto)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE EncerrarBarra(par_oBarra)
        IF VARTYPE(par_oBarra) = "O"
            par_oBarra.Complete(.T.)
        ENDIF
    ENDPROC

    *==========================================================================
    * ROTINA 1 - ImportarListaPreco
    * Transcricao de SIGPRILA.ListaPreco (dump, linha 1608).
    *
    * Estrutura da planilha (ComboTipo.ColunaLi do item 1):
    *   Emps c(3), NomeLista c(20), cPros c(14), Valor c(16),
    *   DataIni d, DataFim d, PrecoDe c(16)
    *
    * Para cada lista distinta da planilha: se a empresa ja tem lista de preco
    * cadastrada, avisa e PULA a lista; se a lista (lPrecos+Emps) ainda nao
    * existe, cria o cabecalho em SigCdLpc e um item em SigCdLpi por produto;
    * se a lista ja existe, avisa e ABORTA o processo (Exit do legado).
    *
    * Observacao de fidelidade: o legado NAO guarda o produto nao encontrado -
    * quando crSigCdPro volta vazio ele grava o item com os campos do produto
    * em branco. Comportamento preservado de proposito (regra #17: formula/
    * regra do legado se transcreve, nao se "melhora"); o que mudou eh so a
    * mecanica de gravacao (lote atomico em vez de TABLEUPDATE).
    *==========================================================================
    FUNCTION ImportarListaPreco()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ExecutarImportarListaPreco()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro na importa" + CHR(231) + CHR(227) + "o da Lista de Pre" + CHR(231) + "o")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    PROTECTED FUNCTION ExecutarImportarListaPreco()
        LOCAL loc_lOk, loc_lAbortar, loc_oBarra, loc_oBarraPro, loc_cSQL
        LOCAL loc_cLista, loc_cEmps, loc_nRes, loc_cLote, loc_nCodigo, loc_cChaveCab
        LOCAL loc_nQtdItens, loc_nValor, loc_nPrecoDe

        loc_lOk      = .T.
        loc_lAbortar = .F.

        IF !USED("TmpPlanilha")
            MsgAviso("Planilha n" + CHR(227) + "o carregada.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT DISTINCT NomeLista, Emps ;
            FROM TmpPlanilha ;
            INTO CURSOR cursor_4c_NomeLista READWRITE

        loc_oBarra = THIS.CriarBarraProgresso("Importando Lista...", RECCOUNT("cursor_4c_NomeLista"))

        SELECT cursor_4c_NomeLista
        GO TOP
        SCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            loc_cLista = ALLTRIM(TratarNulo(cursor_4c_NomeLista.NomeLista, ""))
            loc_cEmps  = ALLTRIM(TratarNulo(cursor_4c_NomeLista.Emps, ""))

            THIS.AtualizarBarra(loc_oBarra, "Lista: " + loc_cLista)

            *-- Legado: uma empresa so pode ter UMA lista de preco
            IF !EMPTY(loc_cEmps)
                loc_cSQL = "SELECT lPrecos FROM SigCdLpc WHERE Emps = " + EscaparSQL(loc_cEmps)
                IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_LocalBus") < 0
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (LocalBus 1)")
                    THIS.this_lErroExibido = .T.
                    loc_lOk      = .F.
                    loc_lAbortar = .T.
                ENDIF

                IF !loc_lAbortar
                    IF USED("cursor_4c_LocalBus") AND !EOF("cursor_4c_LocalBus")
                        MsgAviso("J" + CHR(225) + " Existe uma Lista de Pre" + CHR(231) + "o " + ;
                                 "Cadastrado para a Empresa : " + loc_cEmps, ;
                                 "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT cursor_4c_NomeLista
                        LOOP
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lAbortar
                EXIT
            ENDIF

            *-- Legado: Requery('crSigCdLpc') com plCodLista/plEmps
            loc_cSQL = "SELECT lPrecos FROM SigCdLpc WHERE lPrecos = " + EscaparSQL(loc_cLista) + ;
                       " AND Emps = " + EscaparSQL(loc_cEmps)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Lpc") < 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (crSigCdLpc)")
                THIS.this_lErroExibido = .T.
                loc_lOk      = .F.
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                IF USED("cursor_4c_Lpc") AND !EOF("cursor_4c_Lpc")
                    *-- Legado: lista ja cadastrada -> avisa e ABORTA (Exit)
                    MsgErro("Lista " + loc_cLista + " j" + CHR(225) + " cadastrada" + CHR(13) + ;
                            "Processo Abortado", "")
                    THIS.this_lErroExibido = .T.
                    loc_lOk      = .F.
                    loc_lAbortar = .T.
                ELSE
                    *-- Itens da lista
                    SELECT * FROM TmpPlanilha ;
                        WHERE ALLTRIM(NVL(NomeLista, "")) == m.loc_cLista ;
                        INTO CURSOR cursor_4c_TmpLista READWRITE

                    loc_nQtdItens = RECCOUNT("cursor_4c_TmpLista")
                    loc_nCodigo   = fGerUniqueKey("SigCdLpc")
                    loc_cChaveCab = fUniqueIds()

                    *-- Cabecalho da lista (SigCdLpc). As colunas Formulas/
                    *-- Ncomiss/Nvencs = 2 e Tipos = " " sao do legado; as
                    *-- demais fecham as NOT NULL sem DEFAULT (regra #22).
                    loc_cLote = "INSERT INTO SigCdLpc " + ;
                        "(lPrecos, Codigos, Formulas, Ncomiss, Nvencs, Tipos, Emps, CidChaves, nQtdes, " + ;
                        "aplicTabds, Contas, Descos, Flags, Fpags, Tabds) VALUES (" + ;
                        EscaparSQL(LEFT(loc_cLista, 30)) + ", " + ;
                        FormatarNumeroSQL(loc_nCodigo, 0) + ", 2, 2, 2, " + ;
                        EscaparSQL(" ") + ", " + ;
                        EscaparSQL(LEFT(loc_cEmps, 3)) + ", " + ;
                        EscaparSQL(loc_cChaveCab) + ", " + ;
                        FormatarNumeroSQL(loc_nQtdItens, 0) + ", " + ;
                        "0, " + EscaparSQL("") + ", 0, 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ");" + ;
                        CHR(13) + CHR(10)

                    loc_oBarraPro = THIS.CriarBarraProgresso("Importando Lista...", loc_nQtdItens)

                    SELECT cursor_4c_TmpLista
                    GO TOP
                    SCAN
                        *-- Legado: Requery('crSigCdPro') com pPro = cPros
                        THIS.ConsultarRegistro("SigCdPro", "cursor_4c_ProLi", "cPros", ;
                            ALLTRIM(TratarNulo(cursor_4c_TmpLista.cPros, "")), ;
                            "cGrus, cPros, dPros, MoeVs, pCuss, Ean13, Reffs")

                        THIS.AtualizarBarra(loc_oBarraPro, "Produto: " + ;
                            ALLTRIM(TratarNulo(cursor_4c_ProLi.cPros, "")) + " - " + ;
                            ALLTRIM(TratarNulo(cursor_4c_ProLi.dPros, "")))

                        *-- Valor/PrecoDe vem como CARACTERE da planilha (c(16)),
                        *-- mas podem chegar numericos conforme a coluna montada
                        *-- em CriaPlanilha - por isso o teste de tipo do legado
                        loc_nValor = THIS.ValorNumerico(cursor_4c_TmpLista.Valor)
                        loc_nPrecoDe = THIS.ValorNumerico(cursor_4c_TmpLista.PrecoDe)

                        loc_cLote = loc_cLote + ;
                            "INSERT INTO SigCdLpi " + ;
                            "(cGrus, cPros, dPros, MoeVs, pCuss, Ean13, Reffs, lPrecos, pVens, " + ;
                            "PrecoDe, Vencis, Vencfs, CidChaves, " + ;
                            "cControles, Comiss, FlagUTabs, Ordems) VALUES (" + ;
                            EscaparSQL(LEFT(ALLTRIM(TratarNulo(cursor_4c_ProLi.cGrus, "")), 3)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(TratarNulo(cursor_4c_ProLi.cPros, "")), 14)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(TratarNulo(cursor_4c_ProLi.dPros, "")), 65)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(TratarNulo(cursor_4c_ProLi.MoeVs, "")), 3)) + ", " + ;
                            FormatarNumeroSQL(NVL(cursor_4c_ProLi.pCuss, 0), 6) + ", " + ;
                            FormatarNumeroSQL(NVL(cursor_4c_ProLi.Ean13, 0), 0) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(TratarNulo(cursor_4c_ProLi.Reffs, "")), 40)) + ", " + ;
                            EscaparSQL(LEFT(loc_cLista, 30)) + ", " + ;
                            FormatarNumeroSQL(loc_nValor, 6) + ", " + ;
                            FormatarNumeroSQL(loc_nPrecoDe, 5) + ", " + ;
                            FormatarDataSQL(ConverterParaData(cursor_4c_TmpLista.DataIni)) + ", " + ;
                            FormatarDataSQL(ConverterParaData(cursor_4c_TmpLista.DataFim)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", " + ;
                            EscaparSQL("") + ", 0, 0, " + EscaparSQL("") + ");" + CHR(13) + CHR(10)

                        SELECT cursor_4c_TmpLista
                    ENDSCAN

                    THIS.EncerrarBarra(loc_oBarraPro)

                    IF !THIS.ExecutarLoteAtomico(loc_cLote, "Lista de Pre" + CHR(231) + "o " + loc_cLista)
                        loc_lOk      = .F.
                        loc_lAbortar = .T.
                    ELSE
                        THIS.this_cRotinaAuditada = "LISTAPRECO " + loc_cLista
                        THIS.RegistrarAuditoria("INSERT")
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lAbortar
                EXIT
            ENDIF

            SELECT cursor_4c_NomeLista
        ENDSCAN

        THIS.EncerrarBarra(loc_oBarra)

        IF USED("cursor_4c_NomeLista")
            USE IN cursor_4c_NomeLista
        ENDIF
        IF USED("cursor_4c_TmpLista")
            USE IN cursor_4c_TmpLista
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorNumerico - reproduz o "Iif(Type([cursor.campo])=[N], campo, Val(campo))"
    * que o legado repete em toda leitura de valor da planilha. As colunas de
    * valor sao montadas como CARACTERE em CriaPlanilha (c(16)) mas o legado
    * aceita as duas formas, porque a estrutura do cursor vem da planilha.
    *
    * O teste de tipo vem ANTES e nao dentro de um IIF: VAL() exige Caractere e
    * IIF avaliaria os DOIS ramos, estourando erro 11 com valor numerico.
    *
    * A conversao eh VAL() PURO, de proposito. O separador decimal sai do
    * ambiente: config.prg faz SET POINT TO "," e SET SEPARATOR TO ".", entao
    * VAL("12,50") = 12,5 - certo para planilha pt-BR. Medido no VFP9
    * (2026-10-08): "normalizar" a virgula para ponto antes do VAL devolve 12
    * em vez de 12,5, porque com POINT = "," o ponto deixa de ser decimal; a
    * primeira versao deste metodo fazia isso e era PIOR que o legado.
    *
    * LIMITACAO HERDADA, nao corrigida aqui: VAL() nao entende o separador de
    * milhar, entao "1.234,56" devolve 1 - exatamente o que o Val() do legado
    * devolve. Nao foi "consertado" porque mudaria valor gravado sem que a
    * planilha de origem tenha mudado (regra #17); a planilha deve trazer o
    * valor sem separador de milhar, como hoje.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorNumerico(par_uValor)
        LOCAL loc_nRet

        DO CASE
            CASE VARTYPE(par_uValor) = "N"
                loc_nRet = NVL(par_uValor, 0)
            CASE VARTYPE(par_uValor) = "C"
                loc_nRet = VAL(ALLTRIM(NVL(par_uValor, "")))
            OTHERWISE
                loc_nRet = 0
        ENDCASE

        RETURN loc_nRet
    ENDFUNC

    *==========================================================================
    * ROTINA 3 - ImportarPrecificacao
    * Transcricao de SIGPRILA.AtuaPreco (dump, linha 598).
    *
    * Estrutura da planilha (ComboTipo.ColunaLi do item 3):
    *   Referencia c(20), dtInicial d, dtFinal d,
    *   PrecoVen c(16), PrecoEsp c(16), ProdOff c(1)
    *
    * Por linha da planilha: localiza o produto pelo criterio escolhido em
    * OptTipo (1=Cpros, 2=Dpro2s, 3=Reffs), registra o historico de preco em
    * SigPrPre quando houve mudanca, grava o log da importacao em SigImpPr,
    * propaga o preco para SigPrTam quando o grupo pede (SigCdGrp.AtuPreTam=1),
    * atualiza pVens/PrecoDe (e ProdOff quando informado) em SigCdPro e limpa
    * SigPrPrt do produto.
    *
    * Detalhes do legado preservados de proposito:
    *   - "If lnPVens = 0" inverte os dois valores: o preco especial em branco
    *     faz o preco de venda assumir o lugar dele e o "preco de" ir a zero;
    *   - MoevsAnt entra VAZIO no historico (o legado zera lcMoeAnt depois de
    *     ler lnValAnt e nunca o preenche);
    *   - Prodoff so entra no UPDATE quando a coluna da planilha veio
    *     preenchida ("S" = 1, qualquer outro valor = 0).
    *==========================================================================
    FUNCTION ImportarPrecificacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ExecutarImportarPrecificacao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro na importa" + CHR(231) + CHR(227) + "o da Precifica" + CHR(231) + CHR(227) + "o")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    PROTECTED FUNCTION ExecutarImportarPrecificacao()
        LOCAL loc_lOk, loc_lAbortar, loc_oBarra, loc_cNomArq, loc_cCampoBusca
        LOCAL loc_cRef, loc_nPreDe, loc_nPVens, loc_cProdOff, loc_cCpros, loc_cMoevs
        LOCAL loc_nValAnt, loc_nValDe, loc_cLote, loc_nValTam, loc_cSQL, loc_nAtuPreTam

        loc_lOk      = .T.
        loc_lAbortar = .F.
        loc_cLote    = ""

        IF !USED("TmpPlanilha")
            MsgAviso("Planilha n" + CHR(227) + "o carregada.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cNomArq = ALLTRIM(JUSTFNAME(THIS.this_cArquivoPlanilha))

        *-- Legado: Iif(lnTipo=1,[Cpros],Iif(lnTipo=2,[Dpro2s],[Reffs]))
        loc_cCampoBusca = THIS.ObterCampoBuscaProduto()

        loc_oBarra = THIS.CriarBarraProgresso("Importando Lista...", RECCOUNT("TmpPlanilha"))

        SELECT TmpPlanilha
        GO TOP
        SCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            IF EMPTY(TmpPlanilha.Referencia)
                SELECT TmpPlanilha
                LOOP
            ENDIF

            loc_cRef = ALLTRIM(TratarNulo(TmpPlanilha.Referencia, ""))
            THIS.AtualizarBarra(loc_oBarra, "Referencia: " + loc_cRef)

            loc_nPreDe   = THIS.ValorNumerico(TmpPlanilha.PrecoVen)
            loc_nPVens   = THIS.ValorNumerico(TmpPlanilha.PrecoEsp)
            loc_cProdOff = ALLTRIM(TratarNulo(TmpPlanilha.ProdOff, ""))

            *-- Legado: sem preco especial, o preco de venda assume o lugar dele
            IF loc_nPVens = 0
                loc_nPVens = loc_nPreDe
                loc_nPreDe = 0
            ENDIF

            THIS.ConsultarRegistro("SigCdPro", "cursor_4c_ProAtu", loc_cCampoBusca, loc_cRef, ;
                "Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, cGrus, PrecoDe")

            IF !USED("cursor_4c_ProAtu")
                SELECT TmpPlanilha
                LOOP
            ENDIF

            IF RECCOUNT("cursor_4c_ProAtu") = 0 OR EMPTY(cursor_4c_ProAtu.Cpros)
                SELECT TmpPlanilha
                LOOP
            ENDIF

            loc_cCpros  = ALLTRIM(TratarNulo(cursor_4c_ProAtu.Cpros, ""))
            loc_cMoevs  = ALLTRIM(TratarNulo(cursor_4c_ProAtu.Moevs, ""))
            loc_nValAnt = NVL(cursor_4c_ProAtu.pVens, 0)
            loc_nValDe  = NVL(cursor_4c_ProAtu.PrecoDe, 0)

            *-- Historico de preco: so quando houve mudanca (legado).
            *-- MoevsAnt vai VAZIO - ver cabecalho da rotina.
            IF loc_nPVens <> loc_nValAnt OR loc_nPreDe <> loc_nValDe
                loc_cLote = loc_cLote + ;
                    "INSERT INTO SigPrPre (Cpros, cIdChaves, PVens, PVensAnt, Moevs, MoevsAnt, Datas) VALUES (" + ;
                    EscaparSQL(LEFT(loc_cCpros, 14)) + ", " + ;
                    EscaparSQL(fUniqueIds()) + ", " + ;
                    FormatarNumeroSQL(loc_nPVens, 5) + ", " + ;
                    FormatarNumeroSQL(loc_nValAnt, 5) + ", " + ;
                    EscaparSQL(LEFT(loc_cMoevs, 3)) + ", " + ;
                    EscaparSQL("") + ", GETDATE());" + CHR(13) + CHR(10)
            ENDIF

            *-- Log da importacao (SigImpPr). Utilizado = 0 no legado.
            loc_cLote = loc_cLote + ;
                "INSERT INTO SigImpPr (Cpros, Referencia, PrecoVen, PrecoEsp, DtInicial, DtFinal, " + ;
                "UsuImp, DataImp, Utilizado, Arquivos, CidChaves) VALUES (" + ;
                EscaparSQL(LEFT(loc_cCpros, 14)) + ", " + ;
                EscaparSQL(LEFT(loc_cRef, 25)) + ", " + ;
                FormatarNumeroSQL(loc_nPreDe, 2) + ", " + ;
                FormatarNumeroSQL(loc_nPVens, 2) + ", " + ;
                FormatarDataSQL(ConverterParaData(TmpPlanilha.DtInicial)) + ", " + ;
                FormatarDataSQL(ConverterParaData(TmpPlanilha.DtFinal)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                "GETDATE(), 0, " + ;
                EscaparSQL(LEFT(loc_cNomArq, 200)) + ", " + ;
                EscaparSQL(fUniqueIds()) + ");" + CHR(13) + CHR(10)

            *-- 17/07/2017 (legado): propaga o preco para a tabela de tamanhos
            *-- quando o grupo do produto pede (SigCdGrp.AtuPreTam = 1)
            THIS.ConsultarRegistro("SigCdGrp", "cursor_4c_GrpAtu", "cGrus", ;
                ALLTRIM(TratarNulo(cursor_4c_ProAtu.cGrus, "")), "AtuPreTam")

            loc_nAtuPreTam = 0
            IF USED("cursor_4c_GrpAtu") AND !EOF("cursor_4c_GrpAtu")
                loc_nAtuPreTam = NVL(cursor_4c_GrpAtu.AtuPreTam, 0)
            ENDIF

            IF loc_nAtuPreTam = 1
                loc_cSQL = "SELECT cIdChaves, Percs FROM SigPrTam WHERE Cpros = " + ;
                           EscaparSQL(loc_cCpros)

                IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_PrTam") < 0
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (crSigPrTam)")
                    THIS.this_lErroExibido = .T.
                    loc_lOk      = .F.
                    loc_lAbortar = .T.
                ELSE
                    SELECT cursor_4c_PrTam
                    GO TOP
                    SCAN
                        *-- Formula do legado, transcrita (regra #17):
                        *--   lnValTam = lnPVens + (lnPVens * (Percs/100))
                        *-- com Percs vazio, o valor eh o proprio lnPVens
                        IF NVL(cursor_4c_PrTam.Percs, 0) <> 0
                            loc_nValTam = loc_nPVens + (loc_nPVens * (NVL(cursor_4c_PrTam.Percs, 0) / 100))
                        ELSE
                            loc_nValTam = loc_nPVens
                        ENDIF

                        loc_cLote = loc_cLote + ;
                            "UPDATE SigPrTam SET Valor = " + FormatarNumeroSQL(loc_nValTam, 5) + ;
                            " WHERE cIdChaves = " + ;
                            EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_PrTam.cIdChaves, ""))) + ";" + ;
                            CHR(13) + CHR(10)

                        SELECT cursor_4c_PrTam
                    ENDSCAN
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Preco do produto. Prodoff so entra quando a planilha informou.
                loc_cLote = loc_cLote + ;
                    "UPDATE SigCdPro SET pVens = " + FormatarNumeroSQL(loc_nPVens, 5) + ;
                    ", PrecoDe = " + FormatarNumeroSQL(loc_nPreDe, 5) + ;
                    IIF(!EMPTY(loc_cProdOff), ;
                        ", Prodoff = " + IIF(UPPER(loc_cProdOff) == "S", "1", "0"), "") + ;
                    " WHERE CPros = " + EscaparSQL(loc_cCpros) + ";" + CHR(13) + CHR(10)

                loc_cLote = loc_cLote + ;
                    "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cCpros) + ";" + ;
                    CHR(13) + CHR(10)
            ENDIF

            SELECT TmpPlanilha
        ENDSCAN

        THIS.EncerrarBarra(loc_oBarra)

        *-- O legado grava/commita DENTRO do laco (uma vez por linha). Aqui o
        *-- lote inteiro vai num unico SQLEXEC atomico: se qualquer linha falhar
        *-- NADA eh gravado, em vez de deixar a planilha meio importada - que eh
        *-- o que o legado faz e nao tem como desfazer ("processo irreversivel",
        *-- diz o proprio aviso da tela).
        IF loc_lOk AND !EMPTY(loc_cLote)
            IF THIS.ExecutarLoteAtomico(loc_cLote, "Precifica" + CHR(231) + CHR(227) + "o")
                THIS.this_cRotinaAuditada = "ATUAPRECO " + loc_cNomArq
                THIS.RegistrarAuditoria("UPDATE")
            ELSE
                loc_lOk = .F.
            ENDIF
        ENDIF

        IF USED("cursor_4c_PrTam")
            USE IN cursor_4c_PrTam
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCampoBuscaProduto - reproduz o criterio de busca do produto que todas
    * as rotinas repetem:
    *   Iif(lnTipo=1,[Cpros],Iif(lnTipo=2,[Dpro2s],[Reffs]))
    * onde lnTipo = cntplanilha.OptTipo.Value (1=Codigo, 2=Descritivo,
    * 3=Referencia do Fornecedor), que o Form transfere para this_nTipoBusca.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterCampoBuscaProduto()
        LOCAL loc_cCampo

        DO CASE
            CASE THIS.this_nTipoBusca = 1
                loc_cCampo = "Cpros"
            CASE THIS.this_nTipoBusca = 2
                loc_cCampo = "Dpro2s"
            OTHERWISE
                loc_cCampo = "Reffs"
        ENDCASE

        RETURN loc_cCampo
    ENDFUNC

    *==========================================================================
    * MontarLoteMovimento - converte os cursores de acumulacao
    * (cursor_4c_MvCab / MvItn / MvIts / MvHst) no lote T-SQL que substitui os
    * quatro poDataMgr.Update('CrSigMv...') do legado.
    *
    * REGRA #22 - cada INSERT cobre TODA coluna NOT NULL sem DEFAULT da tabela,
    * nao apenas as que o legado lista. O legado escapava disso porque gravava
    * por TABLEUPDATE sobre um APPEND BLANK (a linha inteira ia para o banco,
    * com os campos nao preenchidos em branco); um INSERT explicito com a lista
    * curta do legado seria RECUSADO pelo SQL Server ("nao permite nulos") e a
    * importacao nao gravaria nada. As colunas acrescentadas abaixo recebem
    * exatamente o valor que o registro em branco do legado levava: '' para
    * char, 0 para numeric/bit. Lista conferida contra docs\schema.sql (lida
    * com Get-Content -Raw - regra #14) cruzando NOT NULL x DEFAULT:
    *   SigMvCab 97, SigMvItn 83, SigMvIts 13, SigMvHst 15 colunas de preenchimento.
    *==========================================================================
    PROTECTED FUNCTION MontarLoteMovimento()
        LOCAL loc_cLote, loc_nSel
        loc_cLote = ""
        loc_nSel  = SELECT()

        *-- ---------------------------------------------------------------- Cab
        IF USED("cursor_4c_MvCab")
            SELECT cursor_4c_MvCab
            GO TOP
            SCAN
                loc_cLote = loc_cLote + "INSERT INTO SigMvCab (" + ;
                    "Datars, Datas, Dopes, Emps, EmpDs, Numes, MascNum, GrupoOs, ContaOs, " + ;
                    "GrupoDs, ContaDs, CidChaves, DtAlts, EmpDopNums, Usuals, Usuars, " + ;
                    "PrazoEnts, GrupoCCs, ContaCCs, Valos, " + ;
                    "acres, antecs, auditors, ccfgnfs, chkbxparcs, chkpagos, chkpgs, chksubn, " + ;
                    "cifccfs, codobs, codobs2, codpeds, codtrans, cofs, contaes, cotusus, " + ;
                    "cupfis, desc2s, descs, devols, dgopes, ecfs, empdnbxs, empdncrds, " + ;
                    "empgopnums, espes, fpubls, grresps, grupos, grvends, iclis, idconta, " + ;
                    "ifors, impcpfs, impress, jobs, lcancelas, livros, localents, localizas, " + ;
                    "locals, lotechqs, lprecos, moeits, motdscs, ncarnecs, ncupoms, ndeclaras, " + ;
                    "nemps, noforms, nops, notas, npedclis, nrcons, ntrans, numbalds, numbals, " + ;
                    "numolds, obsagends, obscabmovs, operadors, opers, priors, procbals, " + ;
                    "procdbal, protats, pstatus, ptax1s, ptax2s, ptax3s, qtdes, resps, rnops, " + ;
                    "status, tabds, tpfats, transps, trfisicos, ultgrvs, usulibs, usupagos, " + ;
                    "utilizados, valacres, valdes2s, valdescs, valdevs, valencs, valinis, " + ;
                    "valndevs, valobxs, valservs, valtrans, valvarps, valvars, vars, " + ;
                    "vcompensas, vends) VALUES (" + ;
                    FormatarDataSQL(cursor_4c_MvCab.Datars) + ", " + ;
                    FormatarDataSQL(cursor_4c_MvCab.Datas) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.Dopes, 20)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.Emps, 3)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.EmpDs, 3)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvCab.Numes, 0) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.MascNum, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.GrupoOs, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.ContaOs, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.GrupoDs, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.ContaDs, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.CidChaves, 20)) + ", " + ;
                    FormatarDataSQL(cursor_4c_MvCab.DtAlts) + ", " + ;
                    EscaparSQL(cursor_4c_MvCab.EmpDopNums) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.Usuals, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.Usuars, 10)) + ", " + ;
                    FormatarDataSQL(cursor_4c_MvCab.PrazoEnts) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.GrupoCCs, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvCab.ContaCCs, 10)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvCab.Valos, 2) + ", " + ;
                    "0, '', '', '', 0, 0, 0, 0, '', 0, '', 0, '', 0, '', '', 0, 0, 0, 0, '', " + ;
                    "'', '', '', '', '', '', '', '', '', '', 0, '', 0, 0, '', 0, 0, 0, '', '', " + ;
                    "0, '', '', '', '', '', 0, '', '', 0, '', 0, '', 0, 0, 0, 0, '', '', '', " + ;
                    "'', 0, 0, 0, 0, '', 0, 0, 0, 0, '', 0, '', '', '', 0, 0, '', '', '', 0, " + ;
                    "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');" + CHR(13) + CHR(10)
                SELECT cursor_4c_MvCab
            ENDSCAN
        ENDIF

        *-- ---------------------------------------------------------------- Itn
        IF USED("cursor_4c_MvItn")
            SELECT cursor_4c_MvItn
            GO TOP
            SCAN
                loc_cLote = loc_cLote + "INSERT INTO SigMvItn (" + ;
                    "CPros, Dopes, Emps, Numes, Opers, Qtds, CItens, Units, Totas, Moedas, " + ;
                    "DPros, AQtds, CUnis, CidChaves, DtAlts, EmpDopNums, Pesos, CodBarras, " + ;
                    "abrevis, aliqcofs, aliqicms, aliqiis, aliqorigs, aliqpis, aliqs, " + ;
                    "baseicm2s, baseicm3s, baseicms, baseipi2s, baseipi3s, bcicmss, bcipis, " + ;
                    "cfops, chksubn, citem2, codfabs, codlprecs, compris, cpro2s, cssl, " + ;
                    "cunips, descvals, empos, etiesps, fators, fatvals, fvals, icms, icmss, " + ;
                    "iconfs, idpro, inss, irrf, iss, lcancelas, localos, locals, moefats, " + ;
                    "moevals, moevs, motdscs, nadis, nchvtbds, ncodigos, niadis, nlotes, " + ;
                    "notas, nrcons, ntrans, numolds, origmercs, pdescs, qtbaixas, qtbxprods, " + ;
                    "qtprods, qtreservas, ratdacs, ratfrts, raticmds, raticms, ratsegs, " + ;
                    "sitribs, sittricms, taxaiis, tipos, tpesos, tpipis, unit2s, unitembs, " + ;
                    "unitinfs, unitorigs, univals, usulibs, utilizas, valbases, valdescs, " + ;
                    "valipis, valrats, vcofins, vcoms, vpis) VALUES (" + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.CPros, 14)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.Dopes, 20)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.Emps, 3)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.Numes, 0) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.Opers, 1)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.Qtds, 3) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.CItens, 0) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.Units, 6) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.Totas, 2) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.Moedas, 3)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.DPros, 65)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.AQtds, 3) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.CUnis, 3)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvItn.CidChaves, 20)) + ", " + ;
                    FormatarDataSQL(cursor_4c_MvItn.DtAlts) + ", " + ;
                    EscaparSQL(cursor_4c_MvItn.EmpDopNums) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.Pesos, 3) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvItn.CodBarras, 0) + ", " + ;
                    "'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, '', 0, 0, '', 0, " + ;
                    "'', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', 0, '', '', " + ;
                    "0, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', " + ;
                    "'', 0, '', 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0);" + ;
                    CHR(13) + CHR(10)
                SELECT cursor_4c_MvItn
            ENDSCAN
        ENDIF

        *-- ---------------------------------------------------------------- Its
        IF USED("cursor_4c_MvIts")
            SELECT cursor_4c_MvIts
            GO TOP
            SCAN
                loc_cLote = loc_cLote + "INSERT INTO SigMvIts (" + ;
                    "Emps, Dopes, Numes, CPros, CodTams, CodCors, Qtds, AQtds, CodBarras, " + ;
                    "Pesos, CidChaves, EmpDopNums, ChkSubn, CItens, " + ;
                    "aqtdembs, codembents, codembs, compris, locals, ntrans, prembs, " + ;
                    "qtbaixas, qtbxprods, qtdembs, qtdents, qtprods, qtreservas) VALUES (" + ;
                    EscaparSQL(LEFT(cursor_4c_MvIts.Emps, 3)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvIts.Dopes, 20)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvIts.Numes, 0) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvIts.CPros, 14)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvIts.CodTams, 4)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvIts.CodCors, 4)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvIts.Qtds, 3) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvIts.AQtds, 3) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvIts.CodBarras, 0) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvIts.Pesos, 3) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvIts.CidChaves, 20)) + ", " + ;
                    EscaparSQL(cursor_4c_MvIts.EmpDopNums) + ", " + ;
                    IIF(cursor_4c_MvIts.ChkSubn, "1", "0") + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvIts.CItens, 0) + ", " + ;
                    "0, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0);" + CHR(13) + CHR(10)
                SELECT cursor_4c_MvIts
            ENDSCAN
        ENDIF

        *-- ---------------------------------------------------------------- Hst
        IF USED("cursor_4c_MvHst")
            SELECT cursor_4c_MvHst
            GO TOP
            SCAN
                *-- DtAudits entra NULL, como no legado ("DtAudits ... Values ... Null").
                *-- Moedas fica em branco tambem por fidelidade: o INSERT do legado
                *-- nao lista essa coluna e o APPEND BLANK gravava vazio.
                loc_cLote = loc_cLote + "INSERT INTO SigMvHst (" + ;
                    "CPros, Datars, Datas, DtAudits, Dopes, EmpOs, Emps, Opers, Numes, " + ;
                    "Qtds, Units, Totas, Grupos, Estos, CidChaves, EmpDopNums, EmpGruEsts, " + ;
                    "OriDopNums, Seqs, Pesos, Usuars, CodBarras, CodTams, CodCors, " + ;
                    "auditors, bcipis, locals, medipis, moedas, moedmeds, ntrans, numolds, " + ;
                    "recalmeds, spesos, sqtds, teqtds, tsqtds, unitmeds, unitmfis) VALUES (" + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.CPros, 14)) + ", " + ;
                    FormatarDataSQL(cursor_4c_MvHst.Datars) + ", " + ;
                    FormatarDataSQL(cursor_4c_MvHst.Datas) + ", NULL, " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.Dopes, 20)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.EmpOs, 3)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.Emps, 3)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.Opers, 1)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvHst.Numes, 0) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvHst.Qtds, 3) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvHst.Units, 6) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvHst.Totas, 2) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.Grupos, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.Estos, 10)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.CidChaves, 20)) + ", " + ;
                    EscaparSQL(cursor_4c_MvHst.EmpDopNums) + ", " + ;
                    EscaparSQL(cursor_4c_MvHst.EmpGruEsts) + ", " + ;
                    EscaparSQL(cursor_4c_MvHst.OriDopNums) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvHst.Seqs, 0) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvHst.Pesos, 3) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.Usuars, 10)) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_MvHst.CodBarras, 0) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.CodTams, 4)) + ", " + ;
                    EscaparSQL(LEFT(cursor_4c_MvHst.CodCors, 4)) + ", " + ;
                    "'', 0, '', 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0);" + CHR(13) + CHR(10)
                SELECT cursor_4c_MvHst
            ENDSCAN
        ENDIF

        IF loc_nSel > 0
            SELECT (loc_nSel)
        ENDIF

        RETURN loc_cLote
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExportarExcecoes - reproduz os dois "Copy To ... Xl5" do fim das rotinas
    * de movimento: produtos nao cadastrados e produtos sem cor/tamanho.
    *
    * SET SAFETY eh salvo/restaurado porque COPY TO sobre arquivo existente
    * abriria dialogo de confirmacao e travaria o processamento (regra #6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExportarExcecoes()
        LOCAL loc_cPasta, loc_cSafety, loc_nSel, loc_oErro
        loc_nSel   = SELECT()
        loc_cPasta = ADDBS(SYS(5) + SYS(2003))
        loc_cSafety = SET("SAFETY")

        TRY
            SET SAFETY OFF

            IF USED("cursor_4c_PrNaoCad")
                SELECT cursor_4c_PrNaoCad
                GO TOP
                IF RECCOUNT("cursor_4c_PrNaoCad") > 0
                    MsgAviso("Houve Produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                             "Arquivo : " + loc_cPasta + "TRANSFERENCIA_NAO_IMPORTADA.XLS", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    SELECT cursor_4c_PrNaoCad
                    COPY TO (loc_cPasta + "TRANSFERENCIA_NAO_IMPORTADA") XL5
                ENDIF
            ENDIF

            IF USED("cursor_4c_PrSemCT")
                SELECT cursor_4c_PrSemCT
                GO TOP
                IF RECCOUNT("cursor_4c_PrSemCT") > 0
                    MsgAviso("Houve produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                             "Arquivo : " + loc_cPasta + "PRODUTOS_SEM_CORTAMANHO.XLS", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    SELECT cursor_4c_PrSemCT
                    COPY TO (loc_cPasta + "PRODUTOS_SEM_CORTAMANHO") XL5
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a planilha de " + ;
                    "exce" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
        ENDTRY

        IF loc_cSafety = "ON"
            SET SAFETY ON
        ELSE
            SET SAFETY OFF
        ENDIF

        IF loc_nSel > 0
            SELECT (loc_nSel)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterParametroDop - le de SigCdPac a movimentacao padrao usada por cada
    * rotina de movimento (crSigCdPac.DopImpPlan / DopTrfPed / DopPedCon /
    * DopAcePed no legado).
    *
    * A leitura eh por nome de coluna e DEFENSIVA: "DopAcePed", usado por
    * PedAcesso (dump, linha 3028), NAO EXISTE em docs\schema.sql - as colunas
    * Dop* de SigCdPac sao dopbxbrest, dopcortam, dopecomm, dopenvops, dopests,
    * dopetiqs, dopimpplan, doppedcon, doppenecom, doprbt, doptrfped,
    * dopvdaveco, dopzers (conferido com Get-Content -Raw, 682 tabelas lidas,
    * entao NAO eh o falso-negativo de encoding da regra #14).
    *
    * Como o legado le a coluna de um "Select * From SigCdPac", se ela nao
    * existir no banco o proprio legado estouraria "Variable DOPACEPED is not
    * found". Aqui a ausencia vira uma mensagem que diz QUAL parametro falta,
    * em vez de um erro de variavel - e NUNCA se substitui por outra coluna
    * Dop*, porque isso lancaria o movimento sob a operacao ERRADA (violacao
    * do PILAR 2, silenciosa e irreversivel).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterParametroDop(par_cColuna)
        LOCAL loc_cDopes, loc_cExpr
        loc_cDopes = ""

        IF !USED("cursor_4c_SigCdPac") OR EOF("cursor_4c_SigCdPac")
            MsgAviso("Par" + CHR(226) + "metros do Sistema n" + CHR(227) + "o carregados " + ;
                     "(SigCdPac)." + CHR(13) + CHR(13) + ;
                     "Par" + CHR(226) + "metros do Sistema > Diversos > Geral", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN ""
        ENDIF

        loc_cExpr = "cursor_4c_SigCdPac." + ALLTRIM(par_cColuna)

        IF TYPE(loc_cExpr) = "U"
            MsgAviso("A coluna " + ALLTRIM(par_cColuna) + " n" + CHR(227) + "o existe em " + ;
                     "SigCdPac neste banco, e eh ela que define a movimenta" + CHR(231) + ;
                     CHR(227) + "o desta importa" + CHR(231) + CHR(227) + "o." + CHR(13) + CHR(13) + ;
                     "Sem ela a importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode " + ;
                     "prosseguir - lan" + CHR(231) + "ar o movimento sob outra " + ;
                     "movimenta" + CHR(231) + CHR(227) + "o gravaria no lugar errado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN ""
        ENDIF

        loc_cDopes = ALLTRIM(TratarNulo(EVALUATE(loc_cExpr), ""))

        RETURN loc_cDopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarOperacao - le SigCdOpe/SigOpCdd da movimentacao e valida
    * grupo/conta de origem e destino, como o inicio de cada rotina de
    * movimento do legado. par_lExigeContaOrigem distingue os dois casos:
    * GeraTransf exige GruOrigs E ConOrigs (a origem eh a empresa); as rotinas
    * de pedido exigem apenas GruOrigs, porque a conta de origem vem da coluna
    * ContaOs da planilha.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarOperacao(par_cDopes, par_lExigeContaOrigem)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_Ope", "Dopes", par_cDopes, "") < 0
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdOpe)")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Ope") OR EOF("cursor_4c_Ope")
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o " + ALLTRIM(par_cDopes) + ;
                     " n" + CHR(227) + "o cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- SigOpCdd (centro de custo da movimentacao). Ausencia nao eh erro:
        *-- o legado so usa GruposCC/ContasCC quando estao preenchidos.
        THIS.ConsultarRegistro("SigOpCdd", "cursor_4c_OpCdd", "Dopes", par_cDopes, "")

        DO CASE
            CASE par_lExigeContaOrigem AND ;
                 (EMPTY(TratarNulo(cursor_4c_Ope.GruOrigs, "")) OR ;
                  EMPTY(TratarNulo(cursor_4c_Ope.ConOrigs, "")))
                MsgAviso("Grupo ou Conta de Origem n" + CHR(227) + "o definido na " + ;
                         "Movimenta" + CHR(231) + CHR(227) + "o " + ;
                         ALLTRIM(TratarNulo(cursor_4c_Ope.Dopes, "")), ;
                         "Aten" + CHR(231) + CHR(227) + "o")

            CASE !par_lExigeContaOrigem AND EMPTY(TratarNulo(cursor_4c_Ope.GruOrigs, ""))
                MsgAviso("Grupo de Origem n" + CHR(227) + "o definido na " + ;
                         "Movimenta" + CHR(231) + CHR(227) + "o " + ;
                         ALLTRIM(TratarNulo(cursor_4c_Ope.Dopes, "")), ;
                         "Aten" + CHR(231) + CHR(227) + "o")

            CASE EMPTY(TratarNulo(cursor_4c_Ope.GruDests, "")) OR ;
                 EMPTY(TratarNulo(cursor_4c_Ope.ConDests, ""))
                MsgAviso("Grupo ou Conta de Destino n" + CHR(227) + "o definido na " + ;
                         "Movimenta" + CHR(231) + CHR(227) + "o " + ;
                         ALLTRIM(TratarNulo(cursor_4c_Ope.Dopes, "")), ;
                         "Aten" + CHR(231) + CHR(227) + "o")

            OTHERWISE
                loc_lOk = .T.
        ENDCASE

        RETURN loc_lOk
    ENDFUNC


    *--------------------------------------------------------------------------
    * ValidarProdutoGrupo - bloco comum as rotinas de movimento: normaliza cor e
    * tamanho (codigo inexistente em SigCdTam/SigCdCor vira vazio, como no
    * legado) e decide, pelo TipoEstos do grupo, se o produto PODE entrar sem
    * cor/tamanho - o llPular do legado.
    *
    * Retorno:  0 = segue (nao pular)   1 = pular (vai para a excecao)
    *          -1 = erro de conexao (mensagem ja exibida)
    *
    * A cor e o tamanho JA NORMALIZADOS saem nas properties this_cTamValidado /
    * this_cCorValidado, e nao por parametro de referencia: o legado zera as
    * proprias lcCor/lcTam, mas em VFP9 um parametro so volta alterado quando o
    * chamador usa "@", e esquecer o "@" num unico call site faria a cor
    * invalida seguir para o INSERT em silencio.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarProdutoGrupo(par_cCgrus, par_cTam, par_cCor)
        LOCAL loc_nRet, loc_cSQL, loc_nTipoEstos, loc_cTam, loc_cCor
        loc_nRet = 0
        loc_cTam = ALLTRIM(TratarNulo(par_cTam, ""))
        loc_cCor = ALLTRIM(TratarNulo(par_cCor, ""))

        IF !EMPTY(loc_cTam) AND loc_nRet = 0
            loc_cSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cTam)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_TmpTam") < 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (crTmpTam)")
                THIS.this_lErroExibido = .T.
                loc_nRet = -1
            ELSE
                IF RECCOUNT("cursor_4c_TmpTam") = 0
                    loc_cTam = ""
                ENDIF
            ENDIF
        ENDIF

        IF !EMPTY(loc_cCor) AND loc_nRet = 0
            loc_cSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCor)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_TmpCor") < 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (crTmpCor)")
                THIS.this_lErroExibido = .T.
                loc_nRet = -1
            ELSE
                IF RECCOUNT("cursor_4c_TmpCor") = 0
                    loc_cCor = ""
                ENDIF
            ENDIF
        ENDIF

        IF loc_nRet = 0
            loc_cSQL = "SELECT TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, " + ;
                       "Entregas, mtPrimas, LocalPdr FROM SigCdGrp WHERE CGrus = " + ;
                       EscaparSQL(ALLTRIM(TratarNulo(par_cCgrus, ""))) + ;
                       " ORDER BY TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas"

            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_TmpGru") < 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (crTmpGru)")
                THIS.this_lErroExibido = .T.
                loc_nRet = -1
            ELSE
                loc_nTipoEstos = 0
                IF USED("cursor_4c_TmpGru") AND !EOF("cursor_4c_TmpGru")
                    loc_nTipoEstos = NVL(cursor_4c_TmpGru.TipoEstos, 0)
                ENDIF

                *-- Legado: TipoEstos 3/4 exigem tamanho; 2/4 exigem cor
                IF EMPTY(loc_cTam) AND INLIST(loc_nTipoEstos, 3, 4)
                    loc_nRet = 1
                ENDIF

                IF EMPTY(loc_cCor) AND INLIST(loc_nTipoEstos, 2, 4)
                    loc_nRet = 1
                ENDIF
            ENDIF
        ENDIF

        THIS.this_cTamValidado = loc_cTam
        THIS.this_cCorValidado = loc_cCor

        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfirmarProdutoRestrito - os dois MessageBox de confirmacao que o legado
    * faz por produto: descontinuado (ForaLinha = 1) e inativo (Situas = 2).
    * Devolve .F. quando o usuario recusa (o legado faz Loop e pula o item).
    *
    * MsgConfirma devolve LOGICO (regra #7) - o legado compara com 6 porque usa
    * MessageBox cru.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConfirmarProdutoRestrito(par_cCursorPro)
        LOCAL loc_lOk, loc_cCpros, loc_nForaLinha, loc_nSituas
        loc_lOk = .T.

        loc_cCpros     = ALLTRIM(TratarNulo(EVALUATE(par_cCursorPro + ".Cpros"), ""))
        loc_nForaLinha = NVL(EVALUATE(par_cCursorPro + ".ForaLinha"), 0)
        loc_nSituas    = NVL(EVALUATE(par_cCursorPro + ".Situas"), 0)

        IF loc_nForaLinha = 1
            IF !MsgConfirma("Produto " + loc_cCpros + " Descontinuado, Deseja importar " + ;
                            "mesmo descontinuado?", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            ENDIF
        ENDIF

        IF loc_lOk AND loc_nSituas = 2
            IF !MsgConfirma("Produto " + loc_cCpros + " Inativo, Deseja Importar mesmo " + ;
                            "Inativo?", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarCabecalhoMovimento - insere a linha de SigMvCab no cursor de
    * acumulacao e devolve o Numes gerado. Reproduz o bloco
    *     If lnVezes > 999
    *         lnNumes = fGerUniqueKey(Alltrim(lcDopes) + lcEmps)
    *         Insert Into CrSigMvCab (...)
    *         lnVezes = 1
    *     EndIf
    * do legado: um cabecalho novo a cada 999 itens ou a cada troca de par
    * empresa origem/destino.
    *
    * Numes = 0 ABORTA: fGerUniqueKey devolve 0 quando nao consegue incrementar
    * o contador (SIGSYSEQ), e seguir adiante gravaria o movimento com numero
    * zero - documento invalido que colide com o proximo. O legado nao tem essa
    * guarda porque la o contador nunca falhava silenciosamente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarCabecalhoMovimento(par_cDopes, par_cEmps, par_cEmpDs, ;
            par_cGrupoOs, par_cContaOs, par_cGrupoDs, par_cContaDs, ;
            par_dPrazo, par_cGrupoCCs, par_cContaCCs)

        LOCAL loc_nNumes, loc_cUsuario

        loc_nNumes = fGerUniqueKey(ALLTRIM(par_cDopes) + PADR(ALLTRIM(par_cEmps), 3))

        IF loc_nNumes = 0
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o n" + CHR(250) + ;
                    "mero do documento para a movimenta" + CHR(231) + CHR(227) + "o " + ;
                    ALLTRIM(par_cDopes) + " / empresa " + ALLTRIM(par_cEmps) + "." + ;
                    CHR(13) + "Importa" + CHR(231) + CHR(227) + "o abortada.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            THIS.this_lErroExibido = .T.
            RETURN 0
        ENDIF

        loc_cUsuario = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

        INSERT INTO cursor_4c_MvCab ;
            (Datars, Datas, Dopes, Emps, EmpDs, Numes, MascNum, GrupoOs, ContaOs, ;
             GrupoDs, ContaDs, CidChaves, DtAlts, EmpDopNums, Usuals, Usuars, ;
             PrazoEnts, GrupoCCs, ContaCCs, Valos) ;
            VALUES ;
            (THIS.this_tDataMovimento, THIS.this_tDataMovimento, ;
             PADR(ALLTRIM(par_cDopes), 20), PADR(ALLTRIM(par_cEmps), 3), ;
             PADR(ALLTRIM(par_cEmpDs), 3), loc_nNumes, fGerMascara(loc_nNumes), ;
             PADR(ALLTRIM(par_cGrupoOs), 10), PADR(ALLTRIM(par_cContaOs), 10), ;
             PADR(ALLTRIM(par_cGrupoDs), 10), PADR(ALLTRIM(par_cContaDs), 10), ;
             fUniqueIds(), DATETIME(), ;
             THIS.MontarChaveEmpDopNum(par_cEmps, par_cDopes, loc_nNumes), ;
             loc_cUsuario, loc_cUsuario, ConverterParaData(par_dPrazo), ;
             PADR(ALLTRIM(TratarNulo(par_cGrupoCCs, "")), 10), ;
             PADR(ALLTRIM(TratarNulo(par_cContaCCs, "")), 10), 0)

        RETURN loc_nNumes
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarItensMovimento - insere a linha de SigMvItn, a de SigMvIts (quando
    * ha cor ou tamanho) e a de SigMvHst (quando a movimentacao controla
    * estoque, SigCdOpe.Estoqs = 1), reproduzindo os tres Insert do legado.
    *
    * O historico chama em seguida SqlCalcP2/fRecalculaC, como no legado - ver
    * RecalcularEstoque.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarItensMovimento(par_cDopes, par_cEmps, par_nNumes, par_nVezes, ;
            par_cCpros, par_cDpros, par_nPecas, par_nUnit, par_cMoevs, par_cCunis, ;
            par_nPesos, par_nBarra, par_cTam, par_cCor, par_cOpers, ;
            par_cGrupoOs, par_cContaOs, par_nEstoqs)

        LOCAL loc_cChave, loc_cCidC, loc_nSeq, loc_cUsuario
        loc_cChave   = THIS.MontarChaveEmpDopNum(par_cEmps, par_cDopes, par_nNumes)
        loc_cUsuario = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

        INSERT INTO cursor_4c_MvItn ;
            (CPros, Dopes, Emps, Numes, Opers, Qtds, CItens, Units, Totas, Moedas, ;
             DPros, AQtds, CUnis, CidChaves, DtAlts, EmpDopNums, Pesos, CodBarras) ;
            VALUES ;
            (PADR(ALLTRIM(par_cCpros), 14), PADR(ALLTRIM(par_cDopes), 20), ;
             PADR(ALLTRIM(par_cEmps), 3), par_nNumes, par_cOpers, par_nPecas, ;
             par_nVezes, par_nUnit, par_nUnit * par_nPecas, ;
             PADR(ALLTRIM(TratarNulo(par_cMoevs, "")), 3), ;
             PADR(ALLTRIM(TratarNulo(par_cDpros, "")), 65), par_nPecas, ;
             PADR(ALLTRIM(TratarNulo(par_cCunis, "")), 3), fUniqueIds(), DATE(), ;
             loc_cChave, par_nPesos, par_nBarra)

        *-- Legado: "Lanca o Barra no SIGMVITS" - so quando ha cor ou tamanho
        IF !EMPTY(par_cCor) OR !EMPTY(par_cTam)
            INSERT INTO cursor_4c_MvIts ;
                (Emps, Dopes, Numes, CPros, CodTams, CodCors, Qtds, AQtds, CodBarras, ;
                 Pesos, CidChaves, EmpDopNums, ChkSubn, CItens) ;
                VALUES ;
                (PADR(ALLTRIM(par_cEmps), 3), PADR(ALLTRIM(par_cDopes), 20), par_nNumes, ;
                 PADR(ALLTRIM(par_cCpros), 14), PADR(ALLTRIM(TratarNulo(par_cTam, "")), 4), ;
                 PADR(ALLTRIM(TratarNulo(par_cCor, "")), 4), par_nPecas, par_nPecas, ;
                 par_nBarra, par_nPesos, fUniqueIds(), loc_cChave, .F., par_nVezes)
        ENDIF

        IF par_nEstoqs = 1
            *-- CIdChaves do historico, montado como no legado:
            *--   Dtos(pDt) + Opers + Transform(fGerUniqueKey(Dtos(pDt)),"@L 999999") + SigKey
            *--   8 + 1 + 6 + 3 = 18 caracteres, cabe no char(20)
            loc_nSeq  = fGerUniqueKey("HISTBAR")
            loc_cCidC = DTOS(THIS.this_tDataMovimento) + par_cOpers + ;
                        TRANSFORM(fGerUniqueKey(DTOS(THIS.this_tDataMovimento)), "@L 999999") + ;
                        PADR(ALLTRIM(THIS.this_cSigKey), 3)

            INSERT INTO cursor_4c_MvHst ;
                (CPros, Datars, Datas, Dopes, EmpOs, Emps, Opers, Numes, Qtds, Units, ;
                 Totas, Grupos, Estos, CidChaves, EmpDopNums, EmpGruEsts, OriDopNums, ;
                 Seqs, Pesos, Usuars, CodBarras, CodTams, CodCors) ;
                VALUES ;
                (PADR(ALLTRIM(par_cCpros), 14), THIS.this_tDataMovimento, ;
                 THIS.this_tDataMovimento, PADR(ALLTRIM(par_cDopes), 20), ;
                 PADR(ALLTRIM(par_cEmps), 3), PADR(ALLTRIM(par_cEmps), 3), par_cOpers, ;
                 par_nNumes, par_nPecas, par_nUnit, par_nUnit * par_nPecas, ;
                 PADR(ALLTRIM(par_cGrupoOs), 10), PADR(ALLTRIM(par_cContaOs), 10), ;
                 LEFT(loc_cCidC, 20), loc_cChave, ;
                 THIS.MontarChaveEmpGruEst(par_cEmps, par_cGrupoOs, par_cContaOs), ;
                 loc_cChave, loc_nSeq, par_nPesos, loc_cUsuario, par_nBarra, ;
                 PADR(ALLTRIM(TratarNulo(par_cTam, "")), 4), ;
                 PADR(ALLTRIM(TratarNulo(par_cCor, "")), 4))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularEstoque - o legado chama, por item de historico e no fim do
    * processo, as funcoes globais do Framework
    *     SqlCalcP2(Emps, Grupos, Estos, Cpros, DataS, CodCors, CodTams, conexao)
    *     fRecalculaC(Emps, Cpros, DataS, conexao)
    * que recalculam SALDO DE ESTOQUE e CUSTO. NENHUMA DAS DUAS foi portada
    * para projeto\app\utils - e NAO podem ser substituidas por stub: devolvem
    * VALOR DE CALCULO, e um stub que devolvesse .T./0 gravaria saldo e custo
    * ERRADOS em silencio (regra #27, 3a linha da tabela - mesma razao de
    * fCalcularST/fCalcularIPI terem ficado ausentes de proposito).
    *
    * Por isso a chamada eh mantida com a MESMA assinatura usada pelos outros
    * BOs do projeto que ja dependem delas (SIGMDETQBO, dmoBO), passando
    * gnConnHandle no lugar do poDataMgr. Enquanto as funcoes nao existirem, o
    * VFP9 procura sqlcalcp2.prg no PATH e o erro aparece ALTO, dentro do
    * TRY/CATCH da rotina, em vez de a importacao gravar estoque incorreto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularEstoque(par_cEmps, par_cGrupos, par_cEstos, par_cCpros, ;
            par_tData, par_cCodCors, par_cCodTams)

        =SqlCalcP2(par_cEmps, par_cGrupos, par_cEstos, par_cCpros, par_tData, ;
                   par_cCodCors, par_cCodTams, gnConnHandle)
        =fRecalculaC(par_cEmps, par_cCpros, par_tData, gnConnHandle)
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarValorCabecalho - reproduz o bloco que o legado roda DEPOIS do
    * SCAN: soma os itens por EmpDopNums e grava o total em SigMvCab.Valos.
    *
    *   Select EmpDopNums, Sum(Totas) as Total From CrSigMvItn
    *       Group by EmpDopNums Order by EmpDopNums Into Cursor csTmpTot
    *   Scan
    *       Update CrSigMvCab Set Valos = csTmpTot.Total Where EmpDopNums = ...
    *   EndScan
    *
    * Roda sobre os cursores de acumulacao, ANTES do lote ir para o banco - por
    * isso os INSERT de SigMvCab ja saem com o Valos correto, sem precisar de um
    * UPDATE posterior.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarValorCabecalho()
        IF !USED("cursor_4c_MvItn") OR !USED("cursor_4c_MvCab")
            RETURN
        ENDIF

        SELECT EmpDopNums, SUM(Totas) AS Total ;
            FROM cursor_4c_MvItn ;
            GROUP BY EmpDopNums ;
            ORDER BY EmpDopNums ;
            INTO CURSOR cursor_4c_TmpTot READWRITE

        SELECT cursor_4c_TmpTot
        GO TOP
        SCAN
            UPDATE cursor_4c_MvCab ;
                SET Valos = cursor_4c_TmpTot.Total ;
                WHERE cursor_4c_MvCab.EmpDopNums == cursor_4c_TmpTot.EmpDopNums
            SELECT cursor_4c_TmpTot
        ENDSCAN

        IF USED("cursor_4c_TmpTot")
            USE IN cursor_4c_TmpTot
        ENDIF
    ENDPROC

    *==========================================================================
    * ROTINA 2 - ImportarTransferencia
    * Transcricao de SIGPRILA.GeraTransf (dump, linha 1250).
    *
    * Estrutura da planilha (ComboTipo.ColunaLi do item 2):
    *   EmpresaO c(6), EmpresaD c(6), Categoria c(10), Colecao c(20),
    *   cpros c(20), Qtds n(10,3), Grupo c(10), prazo d,
    *   CBars n(14,0), Cors c(4), Tams c(4)
    *
    * Gera movimento de TRANSFERENCIA entre empresas: a movimentacao vem de
    * SigCdPac.DopImpPlan e grupo/conta de origem E destino vem todos de
    * SigCdOpe (diferente das rotinas de pedido, onde a conta de origem vem da
    * planilha). Nao usa OptPreco: o valor eh sempre o PVens do produto.
    *
    * Diferencas em relacao as rotinas de pedido, preservadas:
    *   - a contagem de duplicidade considera TODAS as linhas nao deletadas
    *     (as rotinas de pedido descartam antes as linhas sem empresa);
    *   - o indice de csTransf eh Emps + EmpDs (nas de pedido eh so EmpDs);
    *   - NAO ha soma de Valos no cabecalho nem checagem de limite de credito.
    *==========================================================================
    FUNCTION ImportarTransferencia()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ExecutarImportarTransferencia()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro na importa" + CHR(231) + CHR(227) + "o de Transfer" + CHR(234) + "ncias")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        THIS.FecharCursoresMovimento()

        RETURN loc_lSucesso
    ENDFUNC

    PROTECTED FUNCTION ExecutarImportarTransferencia()
        LOCAL loc_lOk, loc_lAbortar, loc_oBarra, loc_cDopes, loc_cOpers
        LOCAL loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs, loc_nEstoqs
        LOCAL loc_nQtdIni, loc_nQtdFim, loc_nVezes, loc_cXEmps, loc_cXEmpDs
        LOCAL loc_cEmps, loc_cEmpDs, loc_nPecas, loc_cProd, loc_nCBars, loc_cCor, loc_cTam
        LOCAL loc_dPrz, loc_nBarra, loc_cCpros, loc_cDpros, loc_nPvens, loc_cMoevs
        LOCAL loc_cCunis, loc_nPesos, loc_nNumes, loc_nPular, loc_cCampoBusca
        LOCAL loc_cLote, loc_cSQL, loc_cUpdEtq

        loc_lOk      = .T.
        loc_lAbortar = .F.
        loc_cUpdEtq  = ""

        IF !USED("TmpPlanilha")
            MsgAviso("Planilha n" + CHR(227) + "o carregada.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        THIS.CriarCursoresMovimento()
        THIS.this_tDataMovimento = fDtoSQL(DATETIME())
        THIS.this_dDataMovimento = ConverterParaData(THIS.this_tDataMovimento)

        loc_cCampoBusca = THIS.ObterCampoBuscaProduto()

        loc_cDopes = THIS.ObterParametroDop("DopImpPlan")
        IF EMPTY(loc_cDopes)
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o da Importa" + CHR(231) + CHR(227) + ;
                     "o da Planilha n" + CHR(227) + "o Informada." + CHR(13) + CHR(13) + ;
                     "Par" + CHR(226) + "metros do Sistema > Diversos > Geral", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF !THIS.CarregarOperacao(loc_cDopes, .T.)
            RETURN .F.
        ENDIF

        loc_cOpers   = IIF(NVL(cursor_4c_Ope.Opers, 0) = 1, "E", "S")
        loc_cGrupoOs = ALLTRIM(TratarNulo(cursor_4c_Ope.GruOrigs, ""))
        loc_cContaOs = ALLTRIM(TratarNulo(cursor_4c_Ope.ConOrigs, ""))
        loc_cGrupoDs = ALLTRIM(TratarNulo(cursor_4c_Ope.GruDests, ""))
        loc_cContaDs = ALLTRIM(TratarNulo(cursor_4c_Ope.ConDests, ""))
        loc_nEstoqs  = NVL(cursor_4c_Ope.Estoqs, 0)

        *-- Deteccao de duplicidade do legado: conta TODAS as linhas nao
        *-- deletadas e compara com o DISTINCT
        SELECT TmpPlanilha
        loc_nQtdIni = 0
        SCAN FOR !DELETED()
            loc_nQtdIni = loc_nQtdIni + 1
        ENDSCAN

        SELECT DISTINCT *, ALLTRIM(RIGHT(EmpresaO, 3)) AS Emps, ;
                           ALLTRIM(RIGHT(EmpresaD, 3)) AS EmpDs ;
            FROM TmpPlanilha ;
            INTO CURSOR cursor_4c_Transf READWRITE

        SELECT cursor_4c_Transf
        INDEX ON Emps + EmpDs TAG Empresa
        GO TOP
        loc_nQtdFim = RECCOUNT("cursor_4c_Transf")

        IF loc_nQtdIni <> loc_nQtdFim
            MsgAviso("H" + CHR(225) + " Registros duplicados, Favor Verificar a Planilha.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_nVezes  = 1
        loc_cXEmps  = "X"
        loc_cXEmpDs = "X"

        loc_oBarra = THIS.CriarBarraProgresso("Importando Transferencias...", ;
                                              RECCOUNT("cursor_4c_Transf"))

        SELECT cursor_4c_Transf
        GO TOP
        SCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            loc_cEmps  = ALLTRIM(TratarNulo(cursor_4c_Transf.Emps, ""))
            loc_cEmpDs = ALLTRIM(TratarNulo(cursor_4c_Transf.EmpDs, ""))

            THIS.AtualizarBarra(loc_oBarra, "Empresa: " + loc_cEmps)

            loc_nPecas = NVL(cursor_4c_Transf.Qtds, 0)
            loc_cProd  = ALLTRIM(TratarNulo(cursor_4c_Transf.Cpros, ""))
            loc_nCBars = NVL(cursor_4c_Transf.Cbars, 0)
            loc_cCor   = ALLTRIM(TratarNulo(cursor_4c_Transf.Cors, ""))
            loc_cTam   = ALLTRIM(TratarNulo(cursor_4c_Transf.Tams, ""))
            loc_dPrz   = ConverterParaData(cursor_4c_Transf.Prazo)

            IF loc_nPecas = 0 OR EMPTY(loc_cEmps) OR EMPTY(loc_cEmpDs) OR EMPTY(loc_cProd)
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            *-- Legado (transcrito literalmente): com codigo de barras E
            *-- cor/tamanho informados, a barra eh DESCARTADA do item
            IF !EMPTY(loc_nCBars) AND (!EMPTY(loc_cCor) OR !EMPTY(loc_cTam))
                loc_nBarra = 0
            ELSE
                loc_nBarra = loc_nCBars
            ENDIF

            *-- Empresa de origem e de destino tem de existir
            THIS.ConsultarRegistro("SigCdEmp", "cursor_4c_Emp", "Cemps", loc_cEmps, "Cemps")
            IF !USED("cursor_4c_Emp") OR RECCOUNT("cursor_4c_Emp") = 0
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            THIS.ConsultarRegistro("SigCdEmp", "cursor_4c_Emp2", "Cemps", loc_cEmpDs, "Cemps")
            IF !USED("cursor_4c_Emp2") OR RECCOUNT("cursor_4c_Emp2") = 0
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            THIS.ConsultarRegistro("SigCdPro", "cursor_4c_Pro", loc_cCampoBusca, loc_cProd, ;
                "Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, ForaLinha, Situas, cgrus")

            IF !USED("cursor_4c_Pro") OR RECCOUNT("cursor_4c_Pro") = 0 OR EMPTY(cursor_4c_Pro.Cpros)
                *-- Produto nao cadastrado -> planilha de excecao
                INSERT INTO cursor_4c_PrNaoCad (Produto, Quantidade, Cor, Tamanho, Barra, Origem, Destino) ;
                    VALUES (loc_cProd, loc_nPecas, loc_cCor, loc_cTam, loc_nCBars, loc_cEmps, loc_cEmpDs)
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            loc_cCpros = ALLTRIM(TratarNulo(cursor_4c_Pro.Cpros, ""))
            loc_cDpros = ALLTRIM(TratarNulo(cursor_4c_Pro.Dpros, ""))
            loc_nPvens = NVL(cursor_4c_Pro.PVens, 0)
            loc_cMoevs = ALLTRIM(TratarNulo(cursor_4c_Pro.Moevs, ""))
            loc_cCunis = ALLTRIM(TratarNulo(cursor_4c_Pro.CUnis, ""))
            loc_nPesos = NVL(cursor_4c_Pro.PesoMs, 0)

            IF !THIS.ConfirmarProdutoRestrito("cursor_4c_Pro")
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            *-- Com barra informada, ela tem de existir e ser DO MESMO produto
            IF !EMPTY(loc_nBarra)
                THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_OpEtq", "Cbars", loc_nBarra, "Cbars, CPros")

                IF !USED("cursor_4c_OpEtq") OR RECCOUNT("cursor_4c_OpEtq") = 0
                    SELECT cursor_4c_Transf
                    LOOP
                ENDIF

                IF ALLTRIM(TratarNulo(cursor_4c_OpEtq.Cpros, "")) <> loc_cCpros
                    SELECT cursor_4c_Transf
                    LOOP
                ENDIF
            ENDIF

            loc_nPular = THIS.ValidarProdutoGrupo(ALLTRIM(TratarNulo(cursor_4c_Pro.CGrus, "")), ;
                                                  loc_cTam, loc_cCor)
            IF loc_nPular < 0
                loc_lOk      = .F.
                loc_lAbortar = .T.
                EXIT
            ENDIF

            loc_cTam = THIS.this_cTamValidado
            loc_cCor = THIS.this_cCorValidado

            IF loc_nPular = 1
                INSERT INTO cursor_4c_PrSemCT (Referencia, Qtds, Pesos, Unidade, Valor) ;
                    VALUES (loc_cCpros, loc_nPecas, loc_nPesos, loc_cCunis, loc_nPvens)
            ELSE
                *-- Cabecalho novo a cada troca de par origem/destino ou a cada
                *-- 999 itens (lnVezes do legado)
                IF loc_cEmps <> loc_cXEmps OR loc_cEmpDs <> loc_cXEmpDs
                    loc_cXEmps  = loc_cEmps
                    loc_cXEmpDs = loc_cEmpDs
                    loc_nVezes  = 1000
                ENDIF

                IF loc_nVezes > 999
                    loc_nNumes = THIS.GravarCabecalhoMovimento(loc_cDopes, loc_cEmps, loc_cEmpDs, ;
                        loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs, ;
                        loc_dPrz, "", "")

                    IF loc_nNumes = 0
                        loc_lOk      = .F.
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    loc_nVezes = 1
                ENDIF

                THIS.GravarItensMovimento(loc_cDopes, loc_cEmps, loc_nNumes, loc_nVezes, ;
                    loc_cCpros, loc_cDpros, loc_nPecas, loc_nPvens, loc_cMoevs, loc_cCunis, ;
                    loc_nPesos, loc_nBarra, loc_cTam, loc_cCor, loc_cOpers, ;
                    loc_cGrupoOs, loc_cContaOs, loc_nEstoqs)

                IF loc_nEstoqs = 1
                    THIS.RecalcularEstoque(loc_cEmps, loc_cGrupoOs, loc_cContaOs, loc_cCpros, ;
                        THIS.this_tDataMovimento, loc_cCor, loc_cTam)
                ENDIF

                *-- Baixa da etiqueta na SAIDA (legado). Acumulado no lote para
                *-- ir junto com os INSERT, dentro da mesma transacao.
                IF !EMPTY(loc_nCBars) AND loc_cOpers == "S"
                    loc_cUpdEtq = loc_cUpdEtq + ;
                        "UPDATE SigOpEtq SET Contas = SPACE(10), Grupos = SPACE(10) WHERE Cbars = " + ;
                        FormatarNumeroSQL(loc_nCBars, 0) + ";" + CHR(13) + CHR(10)
                ENDIF

                loc_nVezes = loc_nVezes + 1
            ENDIF

            SELECT cursor_4c_Transf
        ENDSCAN

        THIS.EncerrarBarra(loc_oBarra)

        IF loc_lOk
            THIS.ExportarExcecoes()

            loc_cLote = THIS.MontarLoteMovimento() + loc_cUpdEtq

            IF EMPTY(loc_cLote)
                MsgAviso("Nenhum registro da planilha p" + CHR(244) + "de ser importado." + ;
                         CHR(13) + "Nada foi gravado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            ELSE
                IF THIS.ExecutarLoteAtomico(loc_cLote, "Transfer" + CHR(234) + "ncia")
                    =fGravarLog("T", loc_cDopes, "SIGPRILA", ;
                        "Importa" + CHR(231) + CHR(227) + "o da Planilha de Tranferencia: " + ;
                        ALLTRIM(THIS.this_cArquivoPlanilha), gc_4c_UsuarioLogado)

                    THIS.this_cRotinaAuditada = "GERATRANSF " + loc_cDopes
                    THIS.RegistrarAuditoria("INSERT")
                ELSE
                    loc_lOk = .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * ROTINAS 4, 5 e 7 - Pedido Terceiro / Consignado / Acessorio
    *
    * GeraPedido (dump 838), Pedidocons (dump 1720) e PedAcesso (dump 3003) sao
    * a MESMA rotina: comparadas linha a linha (normalizando caixa e espacos) a
    * unica diferenca real eh a coluna de SigCdPac que define a movimentacao -
    * DopTrfPed, DopPedCon e DopAcePed respectivamente - mais o detalhe de
    * validacao da empresa de destino descrito em ProcessarPedido. Por isso as
    * tres entram pelo mesmo nucleo, parametrizado, em vez de triplicar ~400
    * linhas de regra de negocio.
    *
    * Estrutura da planilha (identica nas tres):
    *   Emps c(6), Empds c(6), ContaOs c(10), cpros c(20), Qtds n(10,3),
    *   Cors c(4), Tams c(4), Pesos n(12,5), prazo d
    *
    * Diferencas em relacao a GeraTransf: a conta de origem vem da PLANILHA
    * (coluna ContaOs, validada contra SigCdCli) e nao de SigCdOpe; o valor do
    * item respeita OptPreco (1 = Venda -> PVens/Moevs, 2 = Custo ->
    * custofs/moecusfs); o peso pode vir da planilha; nao se usa codigo de
    * barras (o legado fixa lnCBars = 0); e no fim ha a soma de Valos no
    * cabecalho e a checagem de limite de credito por matriz contabil.
    *
    * NOTA sobre "Set Step On": o dump tem essa linha solta em GeraPedido
    * (antes do fGravarLog) e em PedAcesso - sobra de depuracao do legado. NAO
    * foi transcrita de proposito: SET STEP ON abre o depurador do VFP no meio
    * do processamento, o que num pipeline sem supervisao travaria a execucao.
    *==========================================================================
    FUNCTION ImportarPedidoTerceiro()
        RETURN THIS.ImportarPedido("DopTrfPed", ;
                                   "Pedido Terceiro", "GERAPEDIDO", .F.)
    ENDFUNC

    FUNCTION ImportarPedidoConsignado()
        RETURN THIS.ImportarPedido("DopPedCon", ;
                                   "Pedido Consignado", "PEDIDOCONS", .T.)
    ENDFUNC

    FUNCTION ImportarPedidoAcessorio()
        RETURN THIS.ImportarPedido("DopAcePed", ;
                                   "Pedido Acess" + CHR(243) + "rio", "PEDACESSO", .F.)
    ENDFUNC

    PROTECTED FUNCTION ImportarPedido(par_cColunaDop, par_cRotulo, par_cRotina, par_lValidaEmpDestino)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ProcessarPedido(par_cColunaDop, par_cRotina, par_lValidaEmpDestino)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro na importa" + CHR(231) + CHR(227) + "o de " + par_cRotulo)
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        THIS.FecharCursoresMovimento()

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPedido - nucleo comum das tres rotinas de pedido.
    *
    * par_lValidaEmpDestino reproduz uma divergencia REAL entre elas: Pedidocons
    * consulta SigCdEmp duas vezes, a 2a com a empresa de DESTINO (lcEmpds),
    * enquanto GeraPedido e PedAcesso repetem a de ORIGEM (lcEmps) na 2a
    * consulta - ou seja, nessas duas a empresa de destino nunca eh validada.
    * Pelo contexto eh descuido do legado, mas a condicao que cerca uma
    * validacao FAZ PARTE dela: validar o destino em GeraPedido/PedAcesso
    * passaria a REJEITAR linhas que hoje sao importadas. Fica fiel a cada
    * rotina, com a divergencia explicita aqui para decisao humana.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPedido(par_cColunaDop, par_cRotina, par_lValidaEmpDestino)
        LOCAL loc_lOk, loc_lAbortar, loc_oBarra, loc_cDopes, loc_cOpers
        LOCAL loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs, loc_nEstoqs
        LOCAL loc_cGrupoCs, loc_cContaCs, loc_nQtdIni, loc_nQtdFim
        LOCAL loc_nVezes, loc_cXEmps, loc_cXEmpDs, loc_cEmps, loc_cEmpDs
        LOCAL loc_nPecas, loc_cProd, loc_nCBars, loc_cCor, loc_cTam, loc_nPeso
        LOCAL loc_dPrz, loc_nBarra, loc_cCpros, loc_cDpros, loc_nPvens, loc_cMoevs
        LOCAL loc_cCunis, loc_nPesos, loc_nNumes, loc_nPular, loc_cCampoBusca, loc_cLote

        loc_lOk      = .T.
        loc_lAbortar = .F.

        IF !USED("TmpPlanilha")
            MsgAviso("Planilha n" + CHR(227) + "o carregada.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        THIS.CriarCursoresMovimento()
        THIS.this_tDataMovimento = fDtoSQL(DATETIME())
        THIS.this_dDataMovimento = ConverterParaData(THIS.this_tDataMovimento)

        loc_cCampoBusca = THIS.ObterCampoBuscaProduto()

        loc_cDopes = THIS.ObterParametroDop(par_cColunaDop)
        IF EMPTY(loc_cDopes)
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o da Importa" + CHR(231) + CHR(227) + ;
                     "o da Planilha n" + CHR(227) + "o Informada." + CHR(13) + CHR(13) + ;
                     "Par" + CHR(226) + "metros do Sistema > Diversos > Geral", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- Pedido exige apenas o GRUPO de origem: a conta vem da planilha
        IF !THIS.CarregarOperacao(loc_cDopes, .F.)
            RETURN .F.
        ENDIF

        loc_cOpers   = IIF(NVL(cursor_4c_Ope.Opers, 0) = 1, "E", "S")
        loc_cGrupoOs = ALLTRIM(TratarNulo(cursor_4c_Ope.GruOrigs, ""))
        loc_cGrupoDs = ALLTRIM(TratarNulo(cursor_4c_Ope.GruDests, ""))
        loc_cContaDs = ALLTRIM(TratarNulo(cursor_4c_Ope.ConDests, ""))
        loc_nEstoqs  = NVL(cursor_4c_Ope.Estoqs, 0)

        loc_cGrupoCs = ""
        loc_cContaCs = ""
        IF USED("cursor_4c_OpCdd") AND !EOF("cursor_4c_OpCdd")
            loc_cGrupoCs = ALLTRIM(TratarNulo(cursor_4c_OpCdd.GruposCC, ""))
            loc_cContaCs = ALLTRIM(TratarNulo(cursor_4c_OpCdd.ContasCC, ""))
        ENDIF

        *-- Duplicidade: aqui o legado DESCARTA antes as linhas sem empresa de
        *-- origem ou destino (diferente de GeraTransf, que conta todas)
        SELECT TmpPlanilha
        loc_nQtdIni = 0
        SCAN FOR !DELETED()
            IF EMPTY(TmpPlanilha.Empds) OR EMPTY(TmpPlanilha.Emps)
                LOOP
            ENDIF
            loc_nQtdIni = loc_nQtdIni + 1
        ENDSCAN

        SELECT DISTINCT * FROM TmpPlanilha INTO CURSOR cursor_4c_Transf READWRITE

        SELECT cursor_4c_Transf
        INDEX ON EmpDs TAG Empresa
        GO TOP
        loc_nQtdFim = 0
        SCAN FOR !DELETED()
            IF EMPTY(cursor_4c_Transf.Empds) OR EMPTY(cursor_4c_Transf.Emps)
                LOOP
            ENDIF
            loc_nQtdFim = loc_nQtdFim + 1
        ENDSCAN

        IF loc_nQtdIni <> loc_nQtdFim
            MsgAviso("H" + CHR(225) + " Registros duplicados, Favor Verificar a Planilha.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_nVezes  = 1
        loc_cXEmps  = "X"
        loc_cXEmpDs = "X"

        loc_oBarra = THIS.CriarBarraProgresso("Importando Transferencias...", ;
                                              RECCOUNT("cursor_4c_Transf"))

        SELECT cursor_4c_Transf
        GO TOP
        SCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            loc_cEmps  = PADR(ALLTRIM(TratarNulo(cursor_4c_Transf.Emps, "")), 3)
            loc_cEmpDs = PADR(ALLTRIM(TratarNulo(cursor_4c_Transf.Empds, "")), 3)

            THIS.AtualizarBarra(loc_oBarra, "Empresa: " + ALLTRIM(loc_cEmpDs))

            loc_nPecas   = NVL(cursor_4c_Transf.Qtds, 0)
            loc_cProd    = ALLTRIM(TratarNulo(cursor_4c_Transf.Cpros, ""))
            loc_nCBars   = 0
            loc_cCor     = ALLTRIM(TratarNulo(cursor_4c_Transf.Cors, ""))
            loc_cTam     = ALLTRIM(TratarNulo(cursor_4c_Transf.Tams, ""))
            loc_nPeso    = NVL(cursor_4c_Transf.Pesos, 0)
            loc_cContaOs = ALLTRIM(TratarNulo(cursor_4c_Transf.ContaOs, ""))
            loc_dPrz     = ConverterParaData(cursor_4c_Transf.Prazo)

            IF loc_nPecas = 0 OR EMPTY(ALLTRIM(loc_cEmps)) OR EMPTY(ALLTRIM(loc_cEmpDs)) ;
                    OR EMPTY(loc_cContaOs) OR EMPTY(loc_cProd)
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            *-- lnCBars eh sempre 0 nestas rotinas, entao lnBarra tambem - o
            *-- bloco do legado eh mantido porque eh ele que documenta a regra
            IF !EMPTY(loc_nCBars) AND (!EMPTY(loc_cCor) OR !EMPTY(loc_cTam))
                loc_nBarra = 0
            ELSE
                loc_nBarra = loc_nCBars
            ENDIF

            THIS.ConsultarRegistro("SigCdEmp", "cursor_4c_Emp", "Cemps", ALLTRIM(loc_cEmps), "Cemps")
            IF !USED("cursor_4c_Emp") OR RECCOUNT("cursor_4c_Emp") = 0
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            *-- 2a consulta: destino em Pedidocons, origem de novo nas outras
            *-- duas (ver cabecalho deste metodo)
            THIS.ConsultarRegistro("SigCdEmp", "cursor_4c_Emp2", "Cemps", ;
                IIF(par_lValidaEmpDestino, ALLTRIM(loc_cEmpDs), ALLTRIM(loc_cEmps)), "Cemps")
            IF !USED("cursor_4c_Emp2") OR RECCOUNT("cursor_4c_Emp2") = 0
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            *-- Conta de origem tem de existir em SigCdCli
            THIS.ConsultarRegistro("SigCdCli", "cursor_4c_Cli", "Iclis", loc_cContaOs, "Iclis")
            IF !USED("cursor_4c_Cli") OR RECCOUNT("cursor_4c_Cli") = 0
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            THIS.ConsultarRegistro("SigCdPro", "cursor_4c_Pro", loc_cCampoBusca, loc_cProd, ;
                "Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, ForaLinha, Situas, " + ;
                "moecusfs, custofs, cgrus")

            IF !USED("cursor_4c_Pro") OR RECCOUNT("cursor_4c_Pro") = 0 OR EMPTY(cursor_4c_Pro.Cpros)
                INSERT INTO cursor_4c_PrNaoCad (Produto, Quantidade, Cor, Tamanho, Barra, Origem, Destino) ;
                    VALUES (loc_cProd, loc_nPecas, loc_cCor, loc_cTam, loc_nCBars, ;
                            ALLTRIM(loc_cEmps), ALLTRIM(loc_cEmpDs))
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            IF !THIS.ConfirmarProdutoRestrito("cursor_4c_Pro")
                SELECT cursor_4c_Transf
                LOOP
            ENDIF

            loc_cCpros = ALLTRIM(TratarNulo(cursor_4c_Pro.Cpros, ""))
            loc_cDpros = ALLTRIM(TratarNulo(cursor_4c_Pro.Dpros, ""))

            *-- OptPreco: 1 = Venda, 2 = Custo (legado lnTpPre)
            IF THIS.this_nTipoPreco = 1
                loc_nPvens = NVL(cursor_4c_Pro.PVens, 0)
                loc_cMoevs = ALLTRIM(TratarNulo(cursor_4c_Pro.Moevs, ""))
            ELSE
                loc_nPvens = NVL(cursor_4c_Pro.custofs, 0)
                loc_cMoevs = ALLTRIM(TratarNulo(cursor_4c_Pro.moecusfs, ""))
            ENDIF

            loc_cCunis = ALLTRIM(TratarNulo(cursor_4c_Pro.CUnis, ""))
            loc_nPesos = IIF(EMPTY(loc_nPeso), NVL(cursor_4c_Pro.PesoMs, 0), loc_nPeso)

            loc_nPular = THIS.ValidarProdutoGrupo(ALLTRIM(TratarNulo(cursor_4c_Pro.CGrus, "")), ;
                                                  loc_cTam, loc_cCor)
            IF loc_nPular < 0
                loc_lOk      = .F.
                loc_lAbortar = .T.
                EXIT
            ENDIF

            loc_cTam = THIS.this_cTamValidado
            loc_cCor = THIS.this_cCorValidado

            IF loc_nPular = 1
                INSERT INTO cursor_4c_PrSemCT (Referencia, Qtds, Pesos, Unidade, Valor) ;
                    VALUES (loc_cCpros, loc_nPecas, loc_nPesos, loc_cCunis, loc_nPvens)
            ELSE
                IF loc_cEmps <> loc_cXEmps OR loc_cEmpDs <> loc_cXEmpDs
                    loc_cXEmps  = loc_cEmps
                    loc_cXEmpDs = loc_cEmpDs
                    loc_nVezes  = 1000
                ENDIF

                IF loc_nVezes > 999
                    loc_nNumes = THIS.GravarCabecalhoMovimento(loc_cDopes, loc_cEmps, loc_cEmpDs, ;
                        loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs, ;
                        loc_dPrz, loc_cGrupoCs, loc_cContaCs)

                    IF loc_nNumes = 0
                        loc_lOk      = .F.
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    loc_nVezes = 1
                ENDIF

                THIS.GravarItensMovimento(loc_cDopes, loc_cEmps, loc_nNumes, loc_nVezes, ;
                    loc_cCpros, loc_cDpros, loc_nPecas, loc_nPvens, loc_cMoevs, loc_cCunis, ;
                    loc_nPesos, loc_nBarra, loc_cTam, loc_cCor, loc_cOpers, ;
                    loc_cGrupoOs, loc_cContaOs, loc_nEstoqs)

                IF loc_nEstoqs = 1
                    THIS.RecalcularEstoque(loc_cEmps, loc_cGrupoOs, loc_cContaOs, loc_cCpros, ;
                        THIS.this_tDataMovimento, loc_cCor, loc_cTam)
                ENDIF

                loc_nVezes = loc_nVezes + 1
            ENDIF

            SELECT cursor_4c_Transf
        ENDSCAN

        THIS.EncerrarBarra(loc_oBarra)

        IF loc_lOk
            THIS.ExportarExcecoes()

            *-- Soma dos itens no cabecalho (so nas rotinas de pedido)
            THIS.AtualizarValorCabecalho()

            *-- Rafael - 14/11/2017 (legado): limite de credito pela matriz
            *-- contabil, so quando SigCdOpe.LimCres = 7 e os quatro campos de
            *-- centro de custo / emitente estao preenchidos em SigOpCdd
            THIS.this_nValorAcumulado = 0

            IF INLIST(NVL(cursor_4c_Ope.LimCres, 0), 7) AND USED("cursor_4c_OpCdd") ;
                    AND !EOF("cursor_4c_OpCdd")

                IF !EMPTY(TratarNulo(cursor_4c_OpCdd.GruposCC, "")) ;
                        AND !EMPTY(TratarNulo(cursor_4c_OpCdd.ContasCC, "")) ;
                        AND !EMPTY(TratarNulo(cursor_4c_OpCdd.GruposEmt, "")) ;
                        AND !EMPTY(TratarNulo(cursor_4c_OpCdd.ContasEmt, ""))

                    SELECT cursor_4c_MvCab
                    GO TOP
                    SCAN
                        IF !THIS.LimiteCreditoMatriz( ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.GruposCC, "")), ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.ContasCC, "")), ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.GruposEmt, "")), ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.ContasEmt, "")), ;
                                "Centro de Custo")
                            loc_lOk = .F.
                            EXIT
                        ENDIF
                        SELECT cursor_4c_MvCab
                    ENDSCAN
                ENDIF
            ENDIF
        ENDIF

        IF loc_lOk
            loc_cLote = THIS.MontarLoteMovimento()

            IF EMPTY(loc_cLote)
                MsgAviso("Nenhum registro da planilha p" + CHR(244) + "de ser importado." + ;
                         CHR(13) + "Nada foi gravado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            ELSE
                IF THIS.ExecutarLoteAtomico(loc_cLote, par_cRotina)
                    =fGravarLog("T", loc_cDopes, "SIGPRILA", ;
                        "Importa" + CHR(231) + CHR(227) + "o da Planilha de Tranferencia: " + ;
                        ALLTRIM(THIS.this_cArquivoPlanilha), gc_4c_UsuarioLogado)

                    THIS.this_cRotinaAuditada = ALLTRIM(par_cRotina) + " " + loc_cDopes
                    THIS.RegistrarAuditoria("INSERT")
                ELSE
                    loc_lOk = .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * ROTINA 6 - ImportarPedidoFabrica
    * Transcricao de SIGPRILA.PedidoFab (dump, linha 2630).
    *
    * Estrutura da planilha (ComboTipo.ColunaLi do item 6):
    *   ContaOs c(10), cpros c(20), Qtds n(10,3), Cors c(4), Tams c(4),
    *   Pesos n(12,5), Units n(12,5), Moedas c(3), prazoents d, Dopes c(20)
    *
    * Esta rotina eh estruturalmente DIFERENTE das outras quatro de movimento:
    *   - a MOVIMENTACAO vem da propria planilha (coluna Dopes), nao de
    *     SigCdPac, e por isso o laco externo percorre as combinacoes distintas
    *     de ContaOs + Dopes + PrazoEnts;
    *   - a empresa eh UNICA e vem de SigCdEmp.ChkEsc = 1 (escritorio);
    *   - a empresa de DESTINO fica VAZIA (o legado faz lcEmpDs = []);
    *   - o grupo de origem cai para SigCdCli.Grupos da conta quando
    *     SigCdOpe.GruOrigs esta vazio;
    *   - Units e Moedas da planilha, quando preenchidos, SOBREPOEM o preco e a
    *     moeda do produto;
    *   - grupo/conta de destino ausentes PULAM a movimentacao (Loop) em vez de
    *     abortar o processo todo.
    *
    * As confirmacoes de produto descontinuado/inativo estao COMENTADAS no
    * legado (*!* nas linhas 2726-2742 do dump) - por isso NAO sao chamadas
    * aqui, ao contrario das outras rotinas.
    *==========================================================================
    FUNCTION ImportarPedidoFabrica()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ExecutarImportarPedidoFabrica()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro na importa" + CHR(231) + CHR(227) + "o de Pedido F" + CHR(225) + "brica")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        THIS.FecharCursoresMovimento()

        RETURN loc_lSucesso
    ENDFUNC

    PROTECTED FUNCTION ExecutarImportarPedidoFabrica()
        LOCAL loc_lOk, loc_lAbortar, loc_oBarra, loc_cEmpresa, loc_cCampoBusca
        LOCAL loc_cDopes, loc_cGrupo, loc_cOpers, loc_cGrupoOs, loc_cContaOs
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_nEstoqs, loc_cGrupoCs, loc_cContaCs
        LOCAL loc_nVezes, loc_cEmps, loc_cEmpDs, loc_nPecas, loc_cProd, loc_nCBars
        LOCAL loc_cCor, loc_cTam, loc_nPeso, loc_nUnits, loc_cCta, loc_dPrz
        LOCAL loc_nBarra, loc_cMoeda, loc_cCpros, loc_cDpros, loc_nPvens, loc_cMoevs
        LOCAL loc_cCunis, loc_nPesos, loc_nNumes, loc_nPular, loc_cLote, loc_cUltDopes

        loc_lOk       = .T.
        loc_lAbortar  = .F.
        loc_cUltDopes = ""

        IF !USED("TmpPlanilha")
            MsgAviso("Planilha n" + CHR(227) + "o carregada.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        THIS.CriarCursoresMovimento()
        THIS.this_tDataMovimento = fDtoSQL(DATETIME())
        THIS.this_dDataMovimento = ConverterParaData(THIS.this_tDataMovimento)

        loc_cCampoBusca = THIS.ObterCampoBuscaProduto()

        *-- Empresa do escritorio (unica para todo o processo)
        IF THIS.ExecutarSQL("SELECT Cemps FROM SigCdEmp WHERE ChkEsc = 1", "cursor_4c_ChkEsc") < 0
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o- crChkEsc)")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        loc_cEmpresa = ""
        IF USED("cursor_4c_ChkEsc") AND !EOF("cursor_4c_ChkEsc")
            loc_cEmpresa = ALLTRIM(TratarNulo(cursor_4c_ChkEsc.Cemps, ""))
        ENDIF

        *-- Movimentacoes distintas da planilha
        SELECT DISTINCT ContaOs, Dopes, PrazoEnts ;
            FROM TmpPlanilha ;
            WHERE !EMPTY(NVL(ContaOs, "")) AND !EMPTY(NVL(Cpros, "")) ;
              AND !EMPTY(NVL(Qtds, 0)) AND !EMPTY(NVL(Dopes, "")) ;
            INTO CURSOR cursor_4c_MovPlan READWRITE

        loc_oBarra = THIS.CriarBarraProgresso("Importando Pedidos...", ;
                                              RECCOUNT("cursor_4c_MovPlan"))

        SELECT cursor_4c_MovPlan
        GO TOP
        SCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            loc_cDopes = ALLTRIM(TratarNulo(cursor_4c_MovPlan.Dopes, ""))
            loc_cGrupo = ""

            THIS.AtualizarBarra(loc_oBarra, "Movimenta" + CHR(231) + CHR(227) + "o: " + loc_cDopes)

            IF THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_Ope", "Dopes", loc_cDopes, "") < 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (crSigCdOpe)")
                THIS.this_lErroExibido = .T.
                loc_lOk      = .F.
                loc_lAbortar = .T.
                EXIT
            ENDIF

            THIS.ConsultarRegistro("SigOpCdd", "cursor_4c_OpCdd", "Dopes", loc_cDopes, "")

            IF !USED("cursor_4c_Ope") OR EOF("cursor_4c_Ope")
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o " + loc_cDopes + ;
                         " n" + CHR(227) + "o cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
                SELECT cursor_4c_MovPlan
                LOOP
            ENDIF

            *-- Grupo de origem: do cadastro da movimentacao ou, na falta dele,
            *-- do grupo da propria conta (SigCdCli.Grupos)
            IF EMPTY(TratarNulo(cursor_4c_Ope.GruOrigs, ""))
                THIS.ConsultarRegistro("SigCdCli", "cursor_4c_TmpCli", "Iclis", ;
                    ALLTRIM(TratarNulo(cursor_4c_MovPlan.ContaOs, "")), "Grupos")
                IF USED("cursor_4c_TmpCli") AND !EOF("cursor_4c_TmpCli")
                    loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Grupos, ""))
                ENDIF
            ELSE
                loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_Ope.GruOrigs, ""))
            ENDIF

            IF EMPTY(TratarNulo(cursor_4c_Ope.GruDests, "")) ;
                    OR EMPTY(TratarNulo(cursor_4c_Ope.ConDests, ""))
                MsgAviso("Grupo ou Conta de Destino n" + CHR(227) + "o definido na " + ;
                         "Movimenta" + CHR(231) + CHR(227) + "o " + ;
                         ALLTRIM(TratarNulo(cursor_4c_Ope.Dopes, "")), ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                SELECT cursor_4c_MovPlan
                LOOP
            ENDIF

            loc_cOpers   = IIF(NVL(cursor_4c_Ope.Opers, 0) = 1, "E", "S")
            loc_cGrupoOs = loc_cGrupo
            loc_cContaOs = ALLTRIM(TratarNulo(cursor_4c_MovPlan.ContaOs, ""))
            loc_cGrupoDs = ALLTRIM(TratarNulo(cursor_4c_Ope.GruDests, ""))
            loc_cContaDs = ALLTRIM(TratarNulo(cursor_4c_Ope.ConDests, ""))
            loc_nEstoqs  = NVL(cursor_4c_Ope.Estoqs, 0)
            loc_nVezes   = 1000

            loc_cGrupoCs = ""
            loc_cContaCs = ""
            IF USED("cursor_4c_OpCdd") AND !EOF("cursor_4c_OpCdd")
                loc_cGrupoCs = ALLTRIM(TratarNulo(cursor_4c_OpCdd.GruposCC, ""))
                loc_cContaCs = ALLTRIM(TratarNulo(cursor_4c_OpCdd.ContasCC, ""))
            ENDIF

            loc_cUltDopes = loc_cDopes

            SELECT * FROM TmpPlanilha ;
                WHERE ALLTRIM(NVL(ContaOs, "")) == m.loc_cContaOs ;
                  AND ALLTRIM(NVL(Dopes, "")) == m.loc_cDopes ;
                INTO CURSOR cursor_4c_PedFab READWRITE

            SELECT cursor_4c_PedFab
            GO TOP
            SCAN
                IF loc_lAbortar
                    EXIT
                ENDIF

                loc_cEmps  = PADR(ALLTRIM(loc_cEmpresa), 3)
                loc_cEmpDs = PADR("", 3)
                loc_nPecas = NVL(cursor_4c_PedFab.Qtds, 0)
                loc_cProd  = ALLTRIM(TratarNulo(cursor_4c_PedFab.Cpros, ""))
                loc_nCBars = 0
                loc_cCor   = ALLTRIM(TratarNulo(cursor_4c_PedFab.Cors, ""))
                loc_cTam   = ALLTRIM(TratarNulo(cursor_4c_PedFab.Tams, ""))
                loc_nPeso  = NVL(cursor_4c_PedFab.Pesos, 0)
                loc_nUnits = NVL(cursor_4c_PedFab.Units, 0)
                loc_cCta   = loc_cContaOs
                loc_dPrz   = ConverterParaData(cursor_4c_PedFab.PrazoEnts)
                loc_nBarra = 0
                loc_cMoeda = ALLTRIM(TratarNulo(cursor_4c_PedFab.Moedas, ""))

                IF loc_nPecas = 0 OR EMPTY(ALLTRIM(loc_cEmps)) OR EMPTY(loc_cCta) ;
                        OR EMPTY(loc_cProd)
                    SELECT cursor_4c_PedFab
                    LOOP
                ENDIF

                *-- Conta de origem tem de existir
                THIS.ConsultarRegistro("SigCdCli", "cursor_4c_Cli", "Iclis", loc_cCta, "Iclis")
                IF !USED("cursor_4c_Cli") OR RECCOUNT("cursor_4c_Cli") = 0
                    SELECT cursor_4c_PedFab
                    LOOP
                ENDIF

                THIS.ConsultarRegistro("SigCdPro", "cursor_4c_Pro", loc_cCampoBusca, loc_cProd, ;
                    "Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, ForaLinha, Situas, " + ;
                    "custofs, moecusfs, cgrus")

                IF !USED("cursor_4c_Pro") OR RECCOUNT("cursor_4c_Pro") = 0 ;
                        OR EMPTY(cursor_4c_Pro.Cpros)
                    INSERT INTO cursor_4c_PrNaoCad ;
                        (Produto, Quantidade, Cor, Tamanho, Barra, Origem, Destino) ;
                        VALUES (loc_cProd, loc_nPecas, loc_cCor, loc_cTam, loc_nCBars, ;
                                ALLTRIM(loc_cEmps), ALLTRIM(loc_cEmpDs))
                    SELECT cursor_4c_PedFab
                    LOOP
                ENDIF

                *-- As confirmacoes de descontinuado/inativo estao COMENTADAS no
                *-- legado desta rotina - ver cabecalho

                loc_cCpros = ALLTRIM(TratarNulo(cursor_4c_Pro.Cpros, ""))
                loc_cDpros = ALLTRIM(TratarNulo(cursor_4c_Pro.Dpros, ""))

                IF THIS.this_nTipoPreco = 1
                    loc_nPvens = NVL(cursor_4c_Pro.PVens, 0)
                    loc_cMoevs = ALLTRIM(TratarNulo(cursor_4c_Pro.Moevs, ""))
                ELSE
                    loc_nPvens = NVL(cursor_4c_Pro.custofs, 0)
                    loc_cMoevs = ALLTRIM(TratarNulo(cursor_4c_Pro.moecusfs, ""))
                ENDIF

                *-- Valor e moeda da PLANILHA sobrepoem o cadastro do produto
                IF !EMPTY(loc_nUnits)
                    loc_nPvens = loc_nUnits
                ENDIF

                IF !EMPTY(loc_cMoeda)
                    loc_cMoevs = loc_cMoeda
                ENDIF

                loc_cCunis = ALLTRIM(TratarNulo(cursor_4c_Pro.CUnis, ""))
                loc_nPesos = IIF(EMPTY(loc_nPeso), NVL(cursor_4c_Pro.PesoMs, 0), loc_nPeso)

                loc_nPular = THIS.ValidarProdutoGrupo( ;
                    ALLTRIM(TratarNulo(cursor_4c_Pro.CGrus, "")), loc_cTam, loc_cCor)

                IF loc_nPular < 0
                    loc_lOk      = .F.
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                loc_cTam = THIS.this_cTamValidado
                loc_cCor = THIS.this_cCorValidado

                IF loc_nPular = 1
                    INSERT INTO cursor_4c_PrSemCT (Referencia, Qtds, Pesos, Unidade, Valor) ;
                        VALUES (loc_cCpros, loc_nPecas, loc_nPesos, loc_cCunis, loc_nPvens)
                ELSE
                    IF loc_nVezes > 999
                        loc_nNumes = THIS.GravarCabecalhoMovimento(loc_cDopes, loc_cEmps, ;
                            loc_cEmpDs, loc_cGrupoOs, loc_cCta, loc_cGrupoDs, loc_cContaDs, ;
                            loc_dPrz, loc_cGrupoCs, loc_cContaCs)

                        IF loc_nNumes = 0
                            loc_lOk      = .F.
                            loc_lAbortar = .T.
                            EXIT
                        ENDIF

                        loc_nVezes = 1
                    ENDIF

                    THIS.GravarItensMovimento(loc_cDopes, loc_cEmps, loc_nNumes, loc_nVezes, ;
                        loc_cCpros, loc_cDpros, loc_nPecas, loc_nPvens, loc_cMoevs, loc_cCunis, ;
                        loc_nPesos, loc_nBarra, loc_cTam, loc_cCor, loc_cOpers, ;
                        loc_cGrupoOs, loc_cContaOs, loc_nEstoqs)

                    IF loc_nEstoqs = 1
                        THIS.RecalcularEstoque(loc_cEmps, loc_cGrupoOs, loc_cContaOs, ;
                            loc_cCpros, THIS.this_tDataMovimento, loc_cCor, loc_cTam)
                    ENDIF

                    loc_nVezes = loc_nVezes + 1
                ENDIF

                SELECT cursor_4c_PedFab
            ENDSCAN

            loc_nVezes = 1

            SELECT cursor_4c_MovPlan
        ENDSCAN

        THIS.EncerrarBarra(loc_oBarra)

        IF loc_lOk
            THIS.ExportarExcecoes()
            THIS.AtualizarValorCabecalho()

            THIS.this_nValorAcumulado = 0

            *-- Limite de credito: o legado usa aqui o crSigCdOpe/crSigOpCdd da
            *-- ULTIMA movimentacao do laco externo (os cursores sao
            *-- reaproveitados a cada volta), e nao um por cabecalho
            IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope") ;
                    AND INLIST(NVL(cursor_4c_Ope.LimCres, 0), 7) ;
                    AND USED("cursor_4c_OpCdd") AND !EOF("cursor_4c_OpCdd")

                IF !EMPTY(TratarNulo(cursor_4c_OpCdd.GruposCC, "")) ;
                        AND !EMPTY(TratarNulo(cursor_4c_OpCdd.ContasCC, "")) ;
                        AND !EMPTY(TratarNulo(cursor_4c_OpCdd.GruposEmt, "")) ;
                        AND !EMPTY(TratarNulo(cursor_4c_OpCdd.ContasEmt, ""))

                    SELECT cursor_4c_MvCab
                    GO TOP
                    SCAN
                        IF !THIS.LimiteCreditoMatriz( ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.GruposCC, "")), ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.ContasCC, "")), ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.GruposEmt, "")), ;
                                ALLTRIM(TratarNulo(cursor_4c_OpCdd.ContasEmt, "")), ;
                                "Centro de Custo")
                            loc_lOk = .F.
                            EXIT
                        ENDIF
                        SELECT cursor_4c_MvCab
                    ENDSCAN
                ENDIF
            ENDIF
        ENDIF

        IF loc_lOk
            loc_cLote = THIS.MontarLoteMovimento()

            IF EMPTY(loc_cLote)
                MsgAviso("Nenhum registro da planilha p" + CHR(244) + "de ser importado." + ;
                         CHR(13) + "Nada foi gravado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            ELSE
                IF THIS.ExecutarLoteAtomico(loc_cLote, "Pedido F" + CHR(225) + "brica")
                    =fGravarLog("T", loc_cUltDopes, "SIGPRILA", ;
                        "Importa" + CHR(231) + CHR(227) + "o da Planilha de Tranferencia: " + ;
                        ALLTRIM(THIS.this_cArquivoPlanilha), gc_4c_UsuarioLogado)

                    THIS.this_cRotinaAuditada = "PEDIDOFAB " + loc_cUltDopes
                    THIS.RegistrarAuditoria("INSERT")
                ELSE
                    loc_lOk = .F.
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_MovPlan")
            USE IN cursor_4c_MovPlan
        ENDIF
        IF USED("cursor_4c_PedFab")
            USE IN cursor_4c_PedFab
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * LimiteCreditoMatriz - transcricao de SIGPRILA.LimiteCreditoMatriz
    * (dump, linha 2236). Chamada pelas rotinas de pedido quando
    * SigCdOpe.LimCres = 7, uma vez por cabecalho de movimento gerado.
    *
    * Confere o limite de CREDITO (SigCdGcr.LimCres = 1) e o limite de ESTOQUE
    * (SigCdGcr.LimEstoqs = 1) da conta contra o orcamento da matriz contabil
    * (SigCdMtI/SigCdMtz, coluna do MES do movimento), somando o que ja foi
    * movimentado no mes, os cheques em aberto e o estoque da conta, tudo
    * convertido para a moeda do orcamento. Devolve .F. quando o limite eh
    * excedido - e dai a importacao inteira eh abortada pelo chamador.
    *
    * Ao final grava o acumulado do mes na coluna Acm_<Mes> de SigCdMtI.
    *
    * ---------------------------------------------------------------------
    * DEPENDENCIAS DO LEGADO QUE NAO EXISTEM NA NOVA ARQUITETURA
    * ---------------------------------------------------------------------
    * 1) fCarregarCambio() - nao portada. Substituida por THIS.CarregarCambio,
    *    que delega a ObterCotacao/fBuscarCotacao (o proprio legado desta tela
    *    usa fBuscarCotacao no metodo Cotacao, para a mesma finalidade).
    *
    * 2) DO FORM SigOpSen - o dialogo de LIBERACAO POR SENHA nao existe no
    *    acervo migrado. No legado, limite excedido abre esse form e, se o
    *    supervisor autoriza (retorno comecando com "*"), a gravacao segue.
    *    Sem ele NAO existe caminho de autorizacao, e a escolha aqui eh a
    *    SEGURA: o limite excedido BLOQUEIA (return .F.), com mensagem dizendo
    *    que a liberacao por senha esta indisponivel. O inverso - liberar por
    *    nao ter como pedir senha - transformaria um controle financeiro em
    *    no-op silencioso (regra #27: ausencia tem de ficar VISIVEL).
    *
    * 3) crSigClLcr - cursor de limites por moeda que o legado le no ramo de
    *    estoque (LimEstoqs com LimCres <> 1). NUNCA eh criado em lugar nenhum
    *    deste form - eh referencia orfa, herdada de copia de outra tela. O
    *    acesso fica sob USED(), como no restante do metodo; sem o cursor, o
    *    limite desse ramo permanece 0, exatamente como aconteceria no legado
    *    (que estouraria "alias nao encontrado" nesse caminho).
    *
    * 4) crTpmMvItn - idem, usado no UNION ALL do calculo de estoque quando
    *    SigCdOpe.EstDests = 1. Tambem nao existe; o UNION correspondente eh
    *    montado so com as parcelas que existem.
    *
    * 5) "xPar.Fpags" (dump, linha 2487) - erro do legado: o SCAN corrente eh
    *    sobre o cursor "Cheques" e o alias xPar nao existe no form. Aqui le-se
    *    a Fpags da LINHA CORRENTE de Cheques, que eh o que a logica pede.
    *
    * "Set Step On" (dump, linha 2317) nao foi transcrito - sobra de depuracao
    * que abriria o depurador no meio do processamento.
    *==========================================================================
    PROTECTED FUNCTION LimiteCreditoMatriz(par_cGrupo, par_cConta, par_cGrupoEm, ;
            par_cContaEm, par_cTipo)

        LOCAL loc_cGrupo, loc_cConta, loc_tData, loc_cAno, loc_cMes, loc_nValor
        LOCAL loc_cCampo, loc_cCmpUp, loc_lValidaLim, loc_cSQL, loc_cMoedaOrc
        LOCAL loc_cMoeMov, loc_nSaldoMov, loc_nSaldoAc, loc_cMoedaMov
        LOCAL loc_nCotAc, loc_nCotLim, loc_nCotSal, loc_nCotPar, loc_nCotMov
        LOCAL loc_cMatriz, loc_nLimite, loc_cMoeLim, loc_nSaldo, loc_nValorAnt
        LOCAL loc_nChequeC, loc_nChequeP, loc_cTitulo, loc_cChave, loc_nLimCres
        LOCAL loc_nLimEstoqs, loc_cMoeLimes, loc_nTpPrecos, loc_lChqlCreds
        LOCAL loc_nVlEst, loc_cMoeEst, loc_nEstDests, loc_nCotLmc, loc_nCotEst
        LOCAL loc_cUpdate, loc_lOk

        loc_cGrupo     = ALLTRIM(TratarNulo(par_cGrupo, ""))
        loc_cConta     = ALLTRIM(TratarNulo(par_cConta, ""))
        loc_lValidaLim = .T.
        loc_nLimite    = 0
        loc_nSaldo     = 0
        loc_cTitulo    = ""
        loc_cMoeLim    = ""
        loc_lOk        = .T.

        *-- Grupo de limite: SigCdGcr.GrupoLms substitui o grupo quando existe
        IF THIS.ConsultarRegistro("SigCdGcr", "cursor_4c_Gcr2", "Codigos", loc_cGrupo, "") < 0
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdGcr2)")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Gcr2") OR EOF("cursor_4c_Gcr2")
            *-- Sem grupo de limite cadastrado nao ha o que conferir
            RETURN .T.
        ENDIF

        IF !EMPTY(TratarNulo(cursor_4c_Gcr2.GrupoLms, ""))
            loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_Gcr2.GrupoLms, ""))
        ENDIF

        loc_nLimCres   = NVL(cursor_4c_Gcr2.LimCres, 0)
        loc_nLimEstoqs = NVL(cursor_4c_Gcr2.LimEstoqs, 0)

        loc_tData  = cursor_4c_MvCab.Datas
        loc_cAno   = STR(YEAR(loc_tData), 4)
        loc_cMes   = PADL(MONTH(loc_tData), 2, "0")
        loc_nValor = NVL(cursor_4c_MvCab.Valos, 0)

        *-- Coluna do mes no orcamento (Val_<Mes> = limite, Acm_<Mes> = acumulado)
        loc_cCampo = THIS.ObterColunaMesOrcamento(loc_cMes, .F.)
        loc_cCmpUp = THIS.ObterColunaMesOrcamento(loc_cMes, .T.)

        IF EMPTY(loc_cCampo)
            MsgErro("M" + CHR(234) + "s inv" + CHR(225) + "lido na data do movimento: " + ;
                    loc_cMes, "Aten" + CHR(231) + CHR(227) + "o")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT a.cidchaves, a.codigo, a.grupos, a.contas, a.chkvalida, " + ;
                   "b.sgrupos, b.scontas, b.Ano, b.moeda, " + loc_cCampo + " " + ;
                   "FROM SigCdMtI a " + ;
                   "JOIN SigCdMtz b ON a.codigo = b.codigo " + ;
                   "WHERE b.Inativas = 0 AND b.ano = " + EscaparSQL(loc_cAno) + ;
                   " AND b.sgrupos = " + EscaparSQL(loc_cGrupo) + ;
                   " AND b.scontas = " + EscaparSQL(loc_cConta) + ;
                   " AND Grupos = " + EscaparSQL(ALLTRIM(TratarNulo(par_cGrupoEm, ""))) + ;
                   " AND Contas = " + EscaparSQL(ALLTRIM(TratarNulo(par_cContaEm, "")))

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_MtI") < 0
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdMtI)")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        loc_cMoedaOrc = ""
        IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
            loc_cMoedaOrc = ALLTRIM(TratarNulo(cursor_4c_MtI.Moeda, ""))
        ENDIF

        IF EMPTY(loc_cMoedaOrc) AND USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
            loc_cMoedaOrc = ALLTRIM(TratarNulo(cursor_4c_SigCdPam.MoedaPs, ""))
        ENDIF

        loc_cMoeMov = loc_cMoedaOrc

        *-- Saldo ja movimentado no mes para este centro de custo / emitente.
        *-- Query transcrita do legado (as duas camadas de CASE WHEN resolvem o
        *-- grupo/conta efetivo quando SigOpCdd esta em branco).
        loc_cSQL = "SELECT Ano, replicate('0',2-len(ltrim(rtrim(Mes))))+ltrim(rtrim(Mes)) as Mes, " + ;
            "GruposEmt, ContasEmt, GruposCC, ContasCC, sum(valos) as Valos, a.cmoes " + ;
            "from( " + ;
            "select a.limcres, a.dopes, " + ;
            "case when b.GruposEmt = space(10) then c.grupods else b.GruposEmt end as GruposEmt, " + ;
            "case when b.ContasEmt = space(10) then c.Contads else b.ContasEmt end as ContasEmt, " + ;
            "month(datas) as mes, year(datas) as ano, " + ;
            "case when c.grupoccs = space(10) then b.GruposCC else c.grupoccs end as GruposCC, " + ;
            "case when c.contaccs = space(10) then b.ContasCC else c.contaccs end as ContasCC, " + ;
            "c.datas, case when a.cmoes = space(3) then (Select moedaps from sigcdpam) else a.cmoes end as cmoes, " + ;
            "case when a.limcres = 8 then c.valos*-1 else c.valos*1 end as valos " + ;
            "from sigcdope a " + ;
            "join sigopcdd b on a.dopes = b.dopes " + ;
            "join sigmvcab c on a.dopes = c.dopes " + ;
            "where a.limcres in(7,8) and c.valos <> 0 ) a " + ;
            "Where 0=0 " + ;
            "And Ano = " + EscaparSQL(loc_cAno) + " and Mes = " + EscaparSQL(loc_cMes) + ;
            " and GruposCC = " + EscaparSQL(loc_cGrupo) + ;
            " and ContasCC = " + EscaparSQL(loc_cConta) + ;
            " and GruposEmt = " + EscaparSQL(ALLTRIM(TratarNulo(par_cGrupoEm, ""))) + ;
            " and ContasEmt = " + EscaparSQL(ALLTRIM(TratarNulo(par_cContaEm, ""))) + ;
            " group by GruposEmt, ContasEmt, mes, ano, GruposCC, ContasCC, Cmoes"

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_SldMov") < 0
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o (crSldMov)")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        loc_nSaldoMov = 0

        IF USED("cursor_4c_SldMov")
            SELECT cursor_4c_SldMov
            GO TOP
            SCAN
                loc_nSaldoAc  = NVL(cursor_4c_SldMov.Valos, 0)
                loc_cMoedaMov = ALLTRIM(TratarNulo(cursor_4c_SldMov.CMoes, ""))

                loc_nCotAc  = THIS.ObterCotacao(loc_cMoedaMov, THIS.this_dDataMovimento)
                loc_nCotLim = THIS.ObterCotacao(loc_cMoedaOrc, THIS.this_dDataMovimento)

                IF loc_cMoedaMov <> loc_cMoedaOrc AND loc_nCotLim <> 0
                    loc_nSaldoMov = loc_nSaldoMov + ROUND(loc_nSaldoAc * loc_nCotAc / loc_nCotLim, 2)
                ELSE
                    loc_nSaldoMov = loc_nSaldoMov + loc_nSaldoAc
                ENDIF

                SELECT cursor_4c_SldMov
            ENDSCAN
        ENDIF

        loc_nSaldoMov = loc_nSaldoMov + THIS.this_nValorAcumulado

        IF EMPTY(loc_nSaldoMov) AND USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
            loc_nSaldoMov = NVL(cursor_4c_MtI.Saldos, 0)
        ENDIF

        *-- Empresa matriz de cobranca da conta
        loc_cMatriz = ""
        THIS.ConsultarRegistro("SigCdCli", "cursor_4c_LocalMtz", "IClis", loc_cConta, "ContaMats")

        IF !USED("cursor_4c_LocalMtz")
            MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (CursorQuery - LocalMtz)")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        IF !EOF("cursor_4c_LocalMtz") AND !EMPTY(TratarNulo(cursor_4c_LocalMtz.ContaMats, ""))
            loc_cMatriz = ALLTRIM(TratarNulo(cursor_4c_LocalMtz.ContaMats, ""))

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.grupos, a.contas, a.chkvalida, " + ;
                       "b.sgrupos, b.scontas, b.Ano, b.moeda, " + loc_cCampo + " " + ;
                       "FROM SigCdMtI a " + ;
                       "JOIN SigCdMtz b ON a.codigo = b.codigo " + ;
                       "WHERE b.ano = " + EscaparSQL(loc_cAno) + ;
                       " AND b.sgrupos = " + EscaparSQL(loc_cGrupo) + ;
                       " AND b.scontas = " + EscaparSQL(loc_cMatriz) + ;
                       " AND Grupos = " + EscaparSQL(ALLTRIM(TratarNulo(par_cGrupoEm, ""))) + ;
                       " AND Contas = " + EscaparSQL(ALLTRIM(TratarNulo(par_cContaEm, "")))

            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_MtI") < 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (crSigCdMtI)")
                THIS.this_lErroExibido = .T.
                RETURN .F.
            ENDIF
        ENDIF

        *-- Contas abrangidas pelo limite: as da matriz, ou so a propria
        IF EMPTY(loc_cMatriz)
            THIS.ConsultarRegistro("SigCdCli", "cursor_4c_LocalContas", "IClis", loc_cConta, "IClis")
        ELSE
            loc_cSQL = "SELECT IClis FROM SigCdCli WHERE ContaMats = " + EscaparSQL(loc_cMatriz)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_LocalContas") < 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (LocalContas)")
                THIS.this_lErroExibido = .T.
                RETURN .F.
            ENDIF
        ENDIF

        IF !USED("cursor_4c_LocalContas")
            MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (CursorQuery - LocalContas)")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        IF !EOF("cursor_4c_LocalContas")
            loc_cConta = ALLTRIM(TratarNulo(cursor_4c_LocalContas.IClis, ""))
        ENDIF

        loc_lValidaLim = .F.
        IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
            IF VARTYPE(cursor_4c_MtI.chkvalida) = "L"
                loc_lValidaLim = cursor_4c_MtI.chkvalida
            ELSE
                loc_lValidaLim = (NVL(cursor_4c_MtI.chkvalida, 0) = 1)
            ENDIF
        ENDIF

        *-- =============================== LIMITE DE CREDITO ==================
        IF loc_nLimCres = 1
            loc_cTitulo = "Cr" + CHR(233) + "dito"
            loc_nSaldo  = 0

            IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                GO TOP
                loc_nLimite = NVL(cursor_4c_MtI.LimCres, 0)
                loc_cMoeLim = ALLTRIM(TratarNulo(cursor_4c_MtI.Moeda, ""))
                loc_nCotLim = THIS.CarregarCambio(loc_cMoeLim, DATETIME())

                IF EMPTY(loc_nLimite)
                    loc_nLimite = 0.01
                ENDIF

                loc_nCotSal = THIS.ObterCotacao(loc_cMoeMov, THIS.this_dDataMovimento)

                IF loc_cMoeMov <> loc_cMoeLim AND loc_nCotLim <> 0
                    loc_nSaldo = loc_nSaldo + ROUND(loc_nSaldoMov * loc_nCotSal / loc_nCotLim, 2)
                ELSE
                    loc_nSaldo = loc_nSaldo + loc_nSaldoMov
                ENDIF

                THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_OpeLim", "dopes", ;
                    ALLTRIM(TratarNulo(cursor_4c_MvCab.Dopes, "")), "")

                IF USED("cursor_4c_OpeLim") AND !EOF("cursor_4c_OpeLim")
                    IF ALLTRIM(TratarNulo(cursor_4c_OpeLim.Cmoes, "")) <> loc_cMoeLim ;
                            AND loc_nCotLim <> 0
                        loc_nCotMov = THIS.ObterCotacao( ;
                            ALLTRIM(TratarNulo(cursor_4c_OpeLim.Cmoes, "")), ;
                            THIS.this_dDataMovimento)
                        loc_nValor = ROUND(loc_nValor * loc_nCotMov / loc_nCotLim, 2)
                    ENDIF
                ENDIF

                *-- Parcelas ja lancadas do mesmo documento
                loc_nValorAnt = 0
                THIS.ConsultarRegistro("SigMvPar", "cursor_4c_Par", "EmpDopNums", ;
                    THIS.MontarChaveEmpDopNum(cursor_4c_MvCab.Emps, cursor_4c_MvCab.Dopes, ;
                                              cursor_4c_MvCab.Numes), "")

                IF USED("cursor_4c_Par")
                    SELECT cursor_4c_Par
                    GO TOP
                    SCAN
                        THIS.ConsultarRegistro("SigOpFp", "cursor_4c_OpFp", "Fpags", ;
                            ALLTRIM(TratarNulo(cursor_4c_Par.Fpags, "")), "")

                        IF !USED("cursor_4c_OpFp") OR EOF("cursor_4c_OpFp")
                            SELECT cursor_4c_Par
                            LOOP
                        ENDIF

                        IF NVL(cursor_4c_OpFp.ValPends, 0) <> 1
                            SELECT cursor_4c_Par
                            LOOP
                        ENDIF

                        *-- Rafael - 30/06/2016 (legado): condicao de pagamento
                        *-- marcada para nao checar limite de credito
                        IF NVL(cursor_4c_OpFp.ChkLimCre, 0) = 2
                            SELECT cursor_4c_Par
                            LOOP
                        ENDIF

                        loc_nCotPar = THIS.CarregarCambio( ;
                            ALLTRIM(TratarNulo(cursor_4c_Par.Moefpgs, "")), DATETIME())

                        IF loc_nCotLim <> 0
                            loc_nValorAnt = loc_nValorAnt + ;
                                ROUND(NVL(cursor_4c_Par.Valos, 0) * loc_nCotPar / loc_nCotLim, 2)
                        ENDIF

                        SELECT cursor_4c_Par
                    ENDSCAN
                ENDIF

                loc_nSaldo = loc_nSaldo + loc_nValor - loc_nValorAnt

                *-- Cheques em aberto das contas abrangidas
                loc_nChequeC = 0
                loc_nChequeP = 0

                SELECT cursor_4c_LocalContas
                GO TOP
                SCAN
                    loc_cSQL = "SELECT sum(a.valors) as Valors, a.fpags " + ;
                        "FROM SigChe a, SigCdOpt b WHERE a.GrClis = " + EscaparSQL(loc_cGrupo) + ;
                        " AND a.Iclis = " + ;
                        EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_LocalContas.IClis, ""))) + ;
                        " AND a.umovs = b.operacaos AND b.tipos='DB' GROUP BY a.Fpags"

                    IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Cheques") < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                                "Falha na Conex" + CHR(227) + "o (Cheques)")
                        THIS.this_lErroExibido = .T.
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_Cheques
                    GO TOP
                    SCAN
                        IF EMPTY(cursor_4c_Cheques.Fpags)
                            loc_nChequeP = loc_nChequeP + NVL(cursor_4c_Cheques.Valors, 0)
                        ELSE
                            *-- Legado le "xPar.Fpags" aqui, alias que nao existe
                            *-- no form - ver nota 5 do cabecalho
                            THIS.ConsultarRegistro("SigOpFp", "cursor_4c_OpFp", "Fpags", ;
                                ALLTRIM(TratarNulo(cursor_4c_Cheques.Fpags, "")), "")

                            IF !USED("cursor_4c_OpFp") OR EOF("cursor_4c_OpFp")
                                SELECT cursor_4c_Cheques
                                LOOP
                            ENDIF

                            IF NVL(cursor_4c_OpFp.ChkLimCre, 0) = 2
                                SELECT cursor_4c_Cheques
                                LOOP
                            ENDIF

                            IF NVL(cursor_4c_OpFp.ValPends, 0) <> 1
                                loc_nChequeC = loc_nChequeC + NVL(cursor_4c_Cheques.Valors, 0)
                            ELSE
                                loc_nChequeP = loc_nChequeP + NVL(cursor_4c_Cheques.Valors, 0)
                            ENDIF
                        ENDIF
                        SELECT cursor_4c_Cheques
                    ENDSCAN

                    IF loc_nCotLim <> 0
                        loc_nChequeC = ROUND(loc_nChequeC / loc_nCotLim, 2)
                        loc_nChequeP = ROUND(loc_nChequeP / loc_nCotLim, 2)
                    ENDIF

                    loc_lChqlCreds = .F.
                    IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                        IF VARTYPE(cursor_4c_SigCdPam.ChqlCreds) = "L"
                            loc_lChqlCreds = NVL(cursor_4c_SigCdPam.ChqlCreds, .F.)
                        ELSE
                            loc_lChqlCreds = (NVL(cursor_4c_SigCdPam.ChqlCreds, 0) <> 0)
                        ENDIF
                    ENDIF

                    IF loc_lChqlCreds
                        loc_nSaldo = loc_nSaldo + loc_nChequeC
                    ENDIF

                    SELECT cursor_4c_LocalContas
                ENDSCAN
            ENDIF
        ENDIF

        IF !loc_lOk
            RETURN .F.
        ENDIF

        *-- =============================== LIMITE DE ESTOQUE ==================
        loc_cMoeLimes = ""
        IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
            loc_cMoeLimes = ALLTRIM(TratarNulo(cursor_4c_SigCdPam.MoeLimes, ""))
            loc_nTpPrecos = NVL(cursor_4c_SigCdPam.TpPrecos, 0)
        ENDIF

        IF loc_nLimEstoqs = 1 AND !EMPTY(loc_cMoeLimes)
            loc_cTitulo = "Estoque"
            loc_cChave  = THIS.MontarChaveEmpDopNum(cursor_4c_MvCab.Emps, ;
                              cursor_4c_MvCab.Dopes, cursor_4c_MvCab.Numes)

            loc_cMoeLim = loc_cMoeLimes
            loc_nCotLim = THIS.CarregarCambio(loc_cMoeLimes, THIS.this_dDataMovimento)

            IF loc_nLimCres <> 1
                loc_nLimite = 0
                loc_nSaldo  = 0

                *-- crSigClLcr nao existe neste form (nota 3 do cabecalho)
                IF USED("crSigClLcr")
                    SELECT crSigClLcr
                    GO TOP
                    SCAN
                        loc_nCotLmc = THIS.CarregarCambio( ;
                            ALLTRIM(TratarNulo(crSigClLcr.Moedas, "")), THIS.this_dDataMovimento)
                        loc_nLimite = loc_nLimite + (NVL(crSigClLcr.LimCres, 0) * ;
                            IIF(ALLTRIM(TratarNulo(crSigClLcr.Moedas, "")) <> loc_cMoeLim ;
                                AND loc_nCotLim <> 0, loc_nCotLmc / loc_nCotLim, 1))
                        SELECT crSigClLcr
                    ENDSCAN
                ENDIF
            ENDIF

            THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_OpeLim", "dopes", ;
                ALLTRIM(TratarNulo(cursor_4c_MvCab.Dopes, "")), "")

            loc_nEstDests = 0
            IF USED("cursor_4c_OpeLim") AND !EOF("cursor_4c_OpeLim")
                loc_nEstDests = NVL(cursor_4c_OpeLim.EstDests, 0)
            ENDIF

            SELECT cursor_4c_LocalContas
            GO TOP
            SCAN
                IF loc_nEstDests = 1
                    loc_cSQL = "SELECT a.Cpros, Sum(a.Sqtds) as Qtds FROM SigMvEst a, SigCdGcr b " + ;
                        "WHERE a.Estos = " + ;
                        EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_LocalContas.IClis, ""))) + ;
                        " AND a.Grupos = b.codigos AND b.chkLimEsts <> 2 GROUP BY a.Cpros"

                    IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Est") < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                                "Falha na Conex" + CHR(227) + "o (Estoque)")
                        THIS.this_lErroExibido = .T.
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    loc_cSQL = "SELECT Cpros, Sum(Qtds*-1) as Qtds FROM SigMvItn " + ;
                        "WHERE EmpDopNums = " + EscaparSQL(loc_cChave) + " GROUP BY Cpros"

                    IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Esti") < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                                "Falha na Conex" + CHR(227) + "o (Estoque 2)")
                        THIS.this_lErroExibido = .T.
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    *-- O UNION do legado tem 3 parcelas, a do meio sobre
                    *-- crTpmMvItn, que nao existe (nota 4 do cabecalho)
                    SELECT Cpros, SUM(qtds) AS qtds FROM cursor_4c_Est GROUP BY Cpros ;
                        UNION ALL ;
                        SELECT Cpros, SUM(qtds) AS qtds FROM cursor_4c_Esti GROUP BY Cpros ;
                        INTO CURSOR cursor_4c_TmpEst READWRITE
                ELSE
                    loc_cSQL = "SELECT a.Cpros, Sum(a.Sqtds) as Qtds FROM SigMvEst a, SigCdGcr b " + ;
                        "WHERE a.Estos = " + ;
                        EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_LocalContas.IClis, ""))) + ;
                        " AND a.Grupos = b.Codigos AND b.ChkLimEsts <> 2 GROUP BY a.Cpros"

                    IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_TmpEst") < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                                "Falha na Conex" + CHR(227) + "o (TmpEst)")
                        THIS.this_lErroExibido = .T.
                        loc_lOk = .F.
                        EXIT
                    ENDIF
                ENDIF

                SELECT cursor_4c_TmpEst
                GO TOP
                SCAN
                    THIS.ConsultarRegistro("SigCdPro", "cursor_4c_TmpPro", "Cpros", ;
                        ALLTRIM(TratarNulo(cursor_4c_TmpEst.Cpros, "")), ;
                        "Cpros, Moevs, pvens, fvendas, moepvs, pesoms, custofs, moecusfs, " + ;
                        "Linhas, cunis, cproeqs, sgrus, mercs, CodFinP")

                    THIS.ConsultarRegistro("SigCdLin", "cursor_4c_TmpLin", "Linhas", ;
                        ALLTRIM(TratarNulo(cursor_4c_TmpPro.Linhas, "")), "")

                    IF loc_nTpPrecos = 1
                        loc_cMoeEst = ALLTRIM(TratarNulo(cursor_4c_TmpPro.Moevs, ""))
                        loc_nVlEst  = ROUND(NVL(cursor_4c_TmpPro.pvens, 0) * ;
                            IIF(NVL(cursor_4c_TmpPro.fvendas, 0) <> 0 ;
                                AND !EMPTY(cursor_4c_TmpPro.moepvs), ;
                                NVL(cursor_4c_TmpPro.fvendas, 0), 1), 2)

                        IF USED("cursor_4c_TmpLin") AND !EOF("cursor_4c_TmpLin")
                            IF ALLTRIM(TratarNulo(cursor_4c_TmpLin.TpVendas, "")) == "2"
                                loc_nVlEst = NVL(cursor_4c_TmpPro.Pesoms, 0) * loc_nVlEst
                            ENDIF
                        ENDIF
                    ELSE
                        loc_nVlEst = NVL(cursor_4c_TmpPro.Custofs, 0)

                        IF USED("cursor_4c_TmpLin") AND !EOF("cursor_4c_TmpLin")
                            IF ALLTRIM(TratarNulo(cursor_4c_TmpLin.TpCustos, "")) == "2"
                                loc_nVlEst = NVL(cursor_4c_TmpPro.Pesoms, 0) * loc_nVlEst
                            ENDIF
                        ENDIF

                        loc_cMoeEst = ALLTRIM(TratarNulo(cursor_4c_TmpPro.Moecusfs, ""))
                    ENDIF

                    loc_nVlEst = loc_nVlEst * NVL(cursor_4c_TmpEst.qtds, 0)

                    IF loc_cMoeLim <> loc_cMoeEst AND loc_nCotLim <> 0
                        loc_nCotEst = THIS.CarregarCambio(loc_cMoeEst, THIS.this_dDataMovimento)
                        loc_nSaldo  = loc_nSaldo + (loc_nVlEst * loc_nCotEst / loc_nCotLim)
                    ELSE
                        loc_nSaldo = loc_nSaldo + loc_nVlEst
                    ENDIF

                    SELECT cursor_4c_TmpEst
                ENDSCAN

                SELECT cursor_4c_LocalContas
            ENDSCAN
        ENDIF

        IF !loc_lOk
            RETURN .F.
        ENDIF

        *-- =============================== CONFERENCIA FINAL ==================
        IF loc_nLimCres = 1 OR (loc_nLimEstoqs = 1 AND !EMPTY(loc_cMoeLimes))

            IF loc_nLimite <> 0 AND loc_nSaldo = 0
                loc_nSaldo = loc_nValor
            ENDIF

            IF loc_nSaldo > loc_nLimite AND loc_lValidaLim
                MsgAviso("O Limite de " + loc_cTitulo + " da conta de " + ;
                    ALLTRIM(TratarNulo(par_cTipo, "")) + " " + CHR(233) + " de : " + ;
                    TRANSFORM(loc_nLimite, "999,999,999.99") + " " + ALLTRIM(loc_cMoeLim) + ". " + ;
                    CHR(13) + "O saldo desta conta somado ao valor " + CHR(13) + ;
                    "da movimenta" + CHR(231) + CHR(227) + "o excedeu o limite de " + ;
                    loc_cTitulo + " : " + TRANSFORM(loc_nSaldo, "999,999,999.99") + " " + ;
                    ALLTRIM(loc_cMoeLim) + ". " + CHR(13), "")

                *-- No legado, aqui abre "DO FORM SigOpSen" para liberacao por
                *-- senha do supervisor. Esse form NAO existe no acervo migrado
                *-- (nota 2 do cabecalho), e sem ele a unica escolha correta eh
                *-- BLOQUEAR: liberar sozinho transformaria o controle de
                *-- limite num no-op silencioso.
                MsgErro("Limite de " + loc_cTitulo + " excedido e a libera" + CHR(231) + ;
                    CHR(227) + "o por senha (SigOpSen) n" + CHR(227) + "o est" + CHR(225) + ;
                    " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o." + CHR(13) + ;
                    "A importa" + CHR(231) + CHR(227) + "o foi abortada e NADA foi gravado.", ;
                    "Limite de " + loc_cTitulo)
                THIS.this_lErroExibido = .T.

                RETURN .F.
            ENDIF

            THIS.this_nValorAcumulado = THIS.this_nValorAcumulado + loc_nValor

            IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
                loc_cUpdate = "UPDATE SigCdMti SET " + loc_cCmpUp + " = " + ;
                    FormatarNumeroSQL(loc_nValor + loc_nSaldoMov, 2) + ;
                    " WHERE cIdChaves = " + ;
                    EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_MtI.cIdChaves, "")))

                IF THIS.ExecutarSQL(loc_cUpdate) < 0
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (SigCdMti)")
                    THIS.this_lErroExibido = .T.
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterColunaMesOrcamento - devolve a coluna de SigCdMtI correspondente ao
    * mes do movimento, reproduzindo o DO CASE de 12 ramos do legado:
    *   par_lAcumulado = .F. -> " ,a.Val_<Mes> As LimCres, a.Acm_<Mes> As Saldos "
    *   par_lAcumulado = .T. -> " Acm_<Mes> "  (coluna a ATUALIZAR no fim)
    * Mes invalido devolve "" e o chamador aborta.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterColunaMesOrcamento(par_cMes, par_lAcumulado)
        LOCAL loc_cSufixo, loc_nMes
        loc_nMes = VAL(ALLTRIM(TratarNulo(par_cMes, "")))

        DO CASE
            CASE loc_nMes = 1
                loc_cSufixo = "Jan"
            CASE loc_nMes = 2
                loc_cSufixo = "Fev"
            CASE loc_nMes = 3
                loc_cSufixo = "Mar"
            CASE loc_nMes = 4
                loc_cSufixo = "Abr"
            CASE loc_nMes = 5
                loc_cSufixo = "Mai"
            CASE loc_nMes = 6
                loc_cSufixo = "Jun"
            CASE loc_nMes = 7
                loc_cSufixo = "Jul"
            CASE loc_nMes = 8
                loc_cSufixo = "Ago"
            CASE loc_nMes = 9
                loc_cSufixo = "Set"
            CASE loc_nMes = 10
                loc_cSufixo = "Out"
            CASE loc_nMes = 11
                loc_cSufixo = "Nov"
            CASE loc_nMes = 12
                loc_cSufixo = "Dez"
            OTHERWISE
                loc_cSufixo = ""
        ENDCASE

        IF EMPTY(loc_cSufixo)
            RETURN ""
        ENDIF

        IF par_lAcumulado
            RETURN " Acm_" + loc_cSufixo + " "
        ENDIF

        RETURN " ,a.Val_" + loc_cSufixo + " As LimCres, a.Acm_" + loc_cSufixo + " As Saldos "
    ENDFUNC
ENDDEFINE


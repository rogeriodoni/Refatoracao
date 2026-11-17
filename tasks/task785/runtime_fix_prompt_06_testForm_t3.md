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
[2026-11-13 10:37:55] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-13 10:37:55] [INFO] Config FPW: (nao fornecido)
[2026-11-13 10:37:55] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 10:37:56] [INFO] Timeout: 300 segundos
[2026-11-13 10:37:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rqxzh4kb.prg
[2026-11-13 10:37:57] [INFO] Conteudo do wrapper:
[2026-11-13 10:37:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGOPPEN', 'C:\4c\tasks\task785\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPPEN', 'C:\4c\tasks\task785\logs\06_testForm.log'
QUIT

[2026-11-13 10:37:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rqxzh4kb.prg
[2026-11-13 10:37:57] [INFO] VFP output esperado em: C:\4c\tasks\task785\vfp_output.txt
[2026-11-13 10:37:58] [INFO] Executando Visual FoxPro 9...
[2026-11-13 10:37:58] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rqxzh4kb.prg
[2026-11-13 10:37:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rqxzh4kb.prg
[2026-11-13 10:37:59] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGOPPEN
Inicio: 13/11/2026 10:38:00

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 13/11/2026 10:39:48
Duracao: 108 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-13 10:39:49] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-13 10:39:49] [INFO] VFP9 finalizado em 110.9895275 segundos
[2026-11-13 10:39:49] [INFO] Exit Code: 
[2026-11-13 10:39:50] [INFO] 
[2026-11-13 10:39:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-13 10:39:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rqxzh4kb.prg
[2026-11-13 10:39:51] [INFO] 
[2026-11-13 10:39:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-13 10:39:52] [INFO] * Auto-generated wrapper for parameters
[2026-11-13 10:39:52] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 10:39:53] [INFO] * Parameters: 'FormSIGOPPEN', 'C:\4c\tasks\task785\logs\06_testForm.log'
[2026-11-13 10:39:53] [INFO] 
[2026-11-13 10:39:54] [INFO] * Anti-dialog protections for unattended execution
[2026-11-13 10:39:54] [INFO] SET SAFETY OFF
[2026-11-13 10:39:55] [INFO] SET RESOURCE OFF
[2026-11-13 10:39:55] [INFO] SET TALK OFF
[2026-11-13 10:39:55] [INFO] SET NOTIFY OFF
[2026-11-13 10:39:55] [INFO] SYS(2335, 0)
[2026-11-13 10:39:55] [INFO] 
[2026-11-13 10:39:55] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPPEN', 'C:\4c\tasks\task785\logs\06_testForm.log'
[2026-11-13 10:39:56] [INFO] QUIT
[2026-11-13 10:39:56] [INFO] 
[2026-11-13 10:39:56] [INFO] === Fim do Wrapper.prg ===
[2026-11-13 10:39:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPEN.prg):
*==============================================================================
* FormSIGOPPEN.prg - Pendencias Em Subniveis (SIGOPPEN)
* Form OPERACIONAL (layout customizado: grade principal + painel de Status
* de aprovacao). Fase 7/8: eventos principais - marcar/desmarcar linha
* (checkbox + select-all da grade) e o fluxo de Aprovar/Reprovar/Cancelar/
* Encerrar do painel de Status (CmdStatusClick/BtnAprovarClick/
* BtnReprovarClick/BtnCancelarClick/BtnEncerrarStatusClick), o grupo
* Produtos/Encerrar da Lista (CmdBotoesClick/BtnSelItensClick/BtnSairClick)
* e os botoes Subniveis (BtnSubNiveisClick) e de liberacao de consulta de
* todos os subniveis (BtnLiberarClick).
*
* FORA DE ESCOPO (dependem de subsistema ainda nao migrado): o painel
* Cnt_SelItem (grade de itens do subnivel - "Produtos") e os metodos
* Marca()/Desmarca() do legado, que preparam ~10 cursores de trabalho
* (crTpmMvItn, crTpmMvIts, crSigSubMv, xBaixaSS, crSigMvOrc/Orp, xPar,
* TprMvCabV, xParTef) para a baixa em subniveis - e a abertura condicional
* do painel de Status via oPendSnope.tStatus (cursor construido pelo metodo
* legado "Carregar", ~650 linhas, tambem nao migrado - ver nota de
* CarregarLista/SIGOPPENBO.Buscar abaixo). Nesta fase o painel de Status
* abre para TODA marcacao de linha (ver ChkFlagKeyPress), e o botao
* "Produtos" fica restrito ao guard real do legado (linha nao marcada ->
* foco na grade); a implementacao do subsistema de itens fica para fase
* dedicada.
*
* FASE 8/8 (eventos auxiliares e consolidacao final): grade da Page1
* agora carrega de verdade (CarregarLista/SIGOPPENBO.Buscar) e o form foi
* ligado ao menu (popMovimentos - "Pendencias em Subniveis"). O template
* generico desta fase pede nomes de form CRUD (BtnBuscarClick,
* BtnSalvarClick, FormParaBO/BOParaForm, HabilitarCampos/LimparCampos,
* AjustarBotoesPorModo) que NAO se aplicam aqui - esta tela nao tem
* Incluir/Alterar/Excluir nem pagina de dados espelhando o BO 1-para-1
* (regra fundamental: nao inventar botao/campo que o legado nao tem).
* Equivalentes REAIS ja implementados nas fases anteriores:
*   BtnSalvarClick    -> BtnAprovarClick/BtnReprovarClick/BtnCancelarClick
*                        (dispatcher CmdStatusClick, corpo comum em
*                        AplicarStatusMovimento)
*   BtnEncerrarClick  -> BtnSairClick (Page1) e BtnEncerrarStatusClick
*                        (Page2 - fecha o painel de Status sem gravar)
*   LimparCampos      -> AlternarPagina(2) zera edt_4c_Observacoes/
*                        txt_4c_CodTams ao entrar no painel de Status
*   BtnBuscarClick    -> nao existe no legado (cntBotoes so tem
*                        Produtos/Encerrar); a carga roda sozinha no
*                        Init (ver CarregarLista, mais abaixo)
*==============================================================================

DEFINE CLASS FormSIGOPPEN AS FormBase

    DataSession  = 2
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    ClipControls = .F.
    KeyPreview   = .F.
    Caption      = "Pend" + CHR(234) + "ncias Em Subn" + CHR(237) + "veis"
    FontName     = "Tahoma"
    FontSize     = 8

    this_oBusinessObject   = .NULL.
    this_cModoAtual        = ""      && "LISTA" / "SELECAO" / "STATUS" / "BARRAS"
    this_lEmLookupCodTams  = .F.     && guarda de reentrancia (regra #37/#47 CLAUDE.md)
    this_cUltimoValidarCodTamsLostFocusValidado = ""   && guarda de valor-nao-mudou (LostFocus dispara sempre, Valid legado so dispara na mudanca)

    *==========================================================================
    * Init - APENAS DODEFAULT (FormBase.Init chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Encerramento do form (sem cursores proprios ainda nesta fase)
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPPENBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Falha ao criar SIGOPPENBO.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Pula carga SQL durante validacao de UI (gnConnHandle = -1 -
                *-- regra do FORMCOR_LICOES_APRENDIDAS.md / #06 Problema 4)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage  = 1
                THIS.this_cModoAtual            = "LISTA"

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao inicializar FormSIGOPPEN")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Paginas (2 paginas: Lista e Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height
            .Tabs      = .F.
            .PageCount = 2
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: faixa de cabecalho + grade principal
    * (worklist de pendencias em subniveis, legado SIGOPPEN.Grade ligado a
    * TmpPends) + CommandGroup com os botoes REAIS do legado (cntBotoes:
    * Produtos/Encerrar). Esta tela NAO eh CRUD - o legado nao tem Incluir/
    * Alterar/Excluir (e um worklist de aprovacao/reprovacao de pendencias) -
    * entao o template generico de Fase 4 ("grid + 6 botoes CRUD") NAO se
    * aplica aqui. Mesmo precedente de FormSigOpPck (task783): constroi-se
    * os controles REAIS do legado, nunca botoes CRUD inventados (REGRA
    * FUNDAMENTAL / PILAR 1 do CLAUDE.md). Cnt_SelItem (painel de selecao
    * de produtos) e Cnt_Status (painel de aprovacao) ficam para fases
    * posteriores.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Faixa cinza do cabecalho (equivalente cntSombra do legado)
        loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPg.cnt_4c_Cabecalho
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
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .WordWrap  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .WordWrap  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Cursor placeholder - estrutura IDENTICA ao "Create Cursor TmpPends"
        *-- do Init legado (SIGOPPEN_form_codigo_fonte.txt, linha ~7436), para
        *-- o Column.ControlSource de cada coluna ja poder ser ligado nesta
        *-- fase sem derrubar o Init (regra #41 CLAUDE.md: ControlSource de
        *-- cursor ainda inexistente estoura "Alias ... is not found" dentro
        *-- do TRY do InicializarForm). A POPULACAO real (SQLEXEC/APPEND a
        *-- partir de SigMvCab) fica para a fase do BO - SIGOPPENBO.prg ainda
        *-- nao tem Buscar/CarregarLista nesta fase.
        IF !USED("cursor_4c_Dados")
            *-- SET NULL ON antes do CREATE CURSOR: sem isto as colunas sem
            *-- NULL explicito nascem NOT NULL, e o APPEND FROM DBF(...) feito
            *-- em SIGOPPENBO.Buscar() (populado por SQLEXEC contra SigMvCab
            *-- com LEFT JOIN, que pode trazer NULL em varias colunas) estoura
            *-- "Field XXX does not accept null values".
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ( ;
                Flag        L, ;
                Emps        C(3), ;
                Dopes       C(20), ;
                Numes       N(6), ;
                MascNum     C(6), ;
                Datas       T NULL, ;
                TpFats      C(3), ;
                Origem      C(21), ;
                Destino     C(21), ;
                Valos       N(12,2), ;
                Notas       C(6), ;
                ChkSubN     N(1), ;
                Obss        M NULL, ;
                DescsO      C(40), ;
                DescsD      C(40), ;
                cIdChaves   C(10), ;
                Usuars      C(10), ;
                EmpDs       C(3), ;
                pStatus     C(1), ;
                DtEnts      T NULL, ;
                ObsCabMovs  C(40), ;
                Jobs        C(10), ;
                Apagar      N(1), ;
                PedidoWeb   C(50), ;
                IDEntrega   C(50), ;
                ChaveNota   C(44), ;
                IDTransp    C(15), ;
                NumeroNota  C(10), ;
                EmpRet      C(3))
            SET NULL OFF
        ENDIF

        *-- Grade principal (legado: SIGOPPEN.Grade, RecordSource "tmppends")
        loc_oPg.AddObject("grd_4c_Dados", "Grid")

        *-- ColumnCount/RecordSource FORA do WITH (regra: colunas so existem
        *-- depois destas duas; Width/Caption de cada coluna tem de vir
        *-- DEPOIS do ControlSource, senao o VFP reseta para o default
        *-- 90/"Column1" - Problema 48 do FORMCOR_LICOES_APRENDIDAS.md)
        loc_oPg.grd_4c_Dados.ColumnCount  = 10
        loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_Dados"

        WITH loc_oPg.grd_4c_Dados
            .Top                = 213
            .Left               = 26
            .Width              = 999
            .Height             = 236
            .FontName           = "Verdana"
            .FontSize           = 8
            .HeaderHeight       = 22
            .RowHeight          = 16
            .ScrollBars         = 2
            .RecordMark         = .F.
            .ReadOnly           = .F.
            .HighlightBackColor = RGB(137, 209, 248)
            .HighlightForeColor = RGB(0, 0, 0)
            .HighlightStyle     = 2
            .Visible            = .T.

            *-- Column1 "seleciona" (ColumnOrder=1) - checkbox de marcacao
            *-- (legado: fwcheckbox1, ligado em runtime a TmpPends.Flag). O
            *-- "When" do legado (Op_Escolha='INSERIR' Or LibPend) le
            *-- Op_Escolha, que o legado recebe do form PAI no Init
            *-- (This.op_escolha = thisform.parentform.pcescolha). O SIGOPPEN
            *-- eh um dialogo filho e a cadeia do pai entra com a carga da
            *-- grade; sem Op_Escolha o guard negaria TODA marcacao, entao a
            *-- coluna fica habilitada - o toggle real esta em
            *-- ChkFlagKeyPress (regra #18: AddObject + CurrentControl +
            *-- Sparse=.F., DEPOIS do Grid.ReadOnly acima).
            .Column1.ColumnOrder       = 1
            .Column1.ControlSource     = "cursor_4c_Dados.Flag"
            .Column1.Width             = 20
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .F.
            .Column1.Sparse            = .F.
            .Column1.Alignment         = 2
            .Column1.FontName          = "Verdana"
            .Column1.FontSize          = 8
            .Column1.Header1.Caption   = ""
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Verdana"
            .Column1.Header1.FontSize  = 8

            .Column1.AddObject("chk_4c_Flag", "CheckBox")
            WITH .Column1.chk_4c_Flag
                .Top       = 31
                .Left      = 12
                .Height    = 17
                .Width     = 22
                .Alignment = 0
                .BackStyle = 0
                .Caption   = ""
                .ReadOnly  = .F.
                .Visible   = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
            ENDWITH
            .Column1.CurrentControl = "chk_4c_Flag"

            *-- Toggle da marcacao (legado: Grade.seleciona.fwcheckbox1.Click)
            *-- - CheckBox de Column exige os 4 handlers com NODEFAULT (regra
            *-- #46/pattern #185 CLAUDE.md), senao o clique nao alterna nada.
            BINDEVENT(.Column1.chk_4c_Flag, "Click",     THIS, "ChkFlagClick")
            BINDEVENT(.Column1.chk_4c_Flag, "MouseDown", THIS, "ChkFlagMouseDown")
            BINDEVENT(.Column1.chk_4c_Flag, "MouseUp",   THIS, "ChkFlagMouseUp")
            BINDEVENT(.Column1.chk_4c_Flag, "KeyPress",  THIS, "ChkFlagKeyPress")

            *-- Marcar/desmarcar TODAS as linhas de uma vez (legado:
            *-- Grade.seleciona.Header1.Click)
            BINDEVENT(.Column1.Header1, "Click", THIS, "HeaderSelecionaClick")

            *-- Column8 "empresa" (ColumnOrder=2) - caption "Emp"
            .Column8.ColumnOrder       = 2
            .Column8.ControlSource     = "cursor_4c_Dados.Emps"
            .Column8.Width             = 31
            .Column8.ReadOnly          = .T.
            .Column8.FontName          = "Verdana"
            .Column8.FontSize          = 8
            .Column8.Header1.Caption   = "Emp"
            .Column8.Header1.Alignment = 2
            .Column8.Header1.FontName  = "Verdana"
            .Column8.Header1.FontSize  = 8

            *-- Column3 "codigo" (ColumnOrder=3) - ControlSource EXPRESSAO
            *-- (legado: 'PADL(TmpPends.NUMES,10,[0])') - nao eh campo puro,
            *-- entao ReadOnly=.T. eh definitivo (nao da para gravar de volta
            *-- numa expressao), nao so um stand-in desta fase.
            .Column3.ColumnOrder       = 3
            .Column3.ControlSource     = "PADL(cursor_4c_Dados.Numes, 10, '0')"
            .Column3.Width             = 80
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.FontName          = "Verdana"
            .Column3.FontSize          = 8
            .Column3.Header1.Caption   = "Codigo"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Verdana"
            .Column3.Header1.FontSize  = 8

            *-- Column9 "operacao" (ColumnOrder=4) - caption "Movimentacao".
            *-- Confirmado no dump (linha ~7590): esta coluna exibe o CODIGO
            *-- da operacao (Dopes), apesar do nome "operacao"/caption
            *-- "Movimentacao" - this.grade.Operacao.controlsource =
            *-- 'TmpPends.Dopes'. Transcrito literal, nao reinterpretado.
            .Column9.ColumnOrder       = 4
            .Column9.ControlSource     = "cursor_4c_Dados.Dopes"
            .Column9.Width             = 270
            .Column9.ReadOnly          = .T.
            .Column9.FontName          = "Verdana"
            .Column9.FontSize          = 8
            .Column9.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column9.Header1.Alignment = 2
            .Column9.Header1.FontName  = "Verdana"
            .Column9.Header1.FontSize  = 8

            *-- Column4 "data" (ColumnOrder=5)
            .Column4.ColumnOrder       = 5
            .Column4.ControlSource     = "cursor_4c_Dados.Datas"
            .Column4.Width             = 70
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.FontName          = "Verdana"
            .Column4.FontSize          = 8
            .Column4.Header1.Caption   = "Data"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.FontName  = "Verdana"
            .Column4.Header1.FontSize  = 8

            *-- Column5 "Grupo" (ColumnOrder=6) - caption "Origem". ReadOnly
            *-- forcado para .T. nesta fase (sem Valid/lookup wireado ainda,
            *-- celula editavel "morta" confunde o usuario) - a lookup de
            *-- Grupo/Conta de origem/destino entra junto com os handlers de
            *-- grade (Fases 6/7, regra #46/#47 do CLAUDE.md).
            .Column5.ColumnOrder       = 6
            .Column5.ControlSource     = "cursor_4c_Dados.Origem"
            .Column5.Width             = 150
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.ReadOnly          = .T.
            .Column5.FontName          = "Verdana"
            .Column5.FontSize          = 8
            .Column5.Header1.Caption   = "Origem"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.FontName  = "Verdana"
            .Column5.Header1.FontSize  = 8

            *-- Column6 "Conta" (ColumnOrder=7) - caption "Destino" (mesma
            *-- ressalva de ReadOnly da Column5)
            .Column6.ColumnOrder       = 7
            .Column6.ControlSource     = "cursor_4c_Dados.Destino"
            .Column6.Width             = 150
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.ReadOnly          = .T.
            .Column6.FontName          = "Verdana"
            .Column6.FontSize          = 8
            .Column6.Header1.Caption   = "Destino"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.FontName  = "Verdana"
            .Column6.Header1.FontSize  = 8

            *-- Column2 "documento" (ColumnOrder=8) - caption "Docto." (mesma
            *-- ressalva de ReadOnly - sem Valid wireado ainda)
            .Column2.ColumnOrder       = 8
            .Column2.ControlSource     = "cursor_4c_Dados.Notas"
            .Column2.Width             = 68
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.FontName          = "Verdana"
            .Column2.FontSize          = 8
            .Column2.Header1.Caption   = "Docto."
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Verdana"
            .Column2.Header1.FontSize  = 8

            *-- Column7 "Valor" (ColumnOrder=9)
            .Column7.ColumnOrder       = 9
            .Column7.ControlSource     = "cursor_4c_Dados.Valos"
            .Column7.Width             = 91
            .Column7.Movable           = .F.
            .Column7.Resizable         = .F.
            .Column7.ReadOnly          = .T.
            .Column7.FontName          = "Verdana"
            .Column7.FontSize          = 8
            .Column7.Header1.Caption   = "Valor"
            .Column7.Header1.Alignment = 2
            .Column7.Header1.FontName  = "Verdana"
            .Column7.Header1.FontSize  = 8

            *-- Column10 "EmpDestino" (sem ColumnOrder explicito no dump -
            *-- mantem o default/ultima posicao) - caption "EmpD". Dump
            *-- legado tem ReadOnly=.F., mas sem handler nesta fase forcado
            *-- para .T. pela mesma razao das colunas Grupo/Conta/documento.
            .Column10.ControlSource     = "cursor_4c_Dados.EmpDs"
            .Column10.Width             = 39
            .Column10.ReadOnly          = .T.
            .Column10.FontName          = "Verdana"
            .Column10.FontSize          = 8
            .Column10.Header1.Caption   = "EmpD"
            .Column10.Header1.Alignment = 2
            .Column10.Header1.FontName  = "Verdana"
            .Column10.Header1.FontSize  = 8
        ENDWITH

        *-- CommandGroup com os botoes REAIS do legado (legado: cntBotoes -
        *-- Produtos/Encerrar). Esta tela NAO tem Incluir/Alterar/Excluir -
        *-- NAO inventar botoes CRUD (REGRA FUNDAMENTAL do CLAUDE.md).
        *-- Clicks: ver CmdBotoesClick, mais abaixo neste metodo.
        loc_oPg.AddObject("obj_4c_CmgBotoes", "CommandGroup")
        WITH loc_oPg.obj_4c_CmgBotoes
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 0
            .Themes        = .F.
            .Top           = 95
            .Left          = 834
            .Width         = 160
            .Height        = 85
            .Visible       = .T.

            *-- Buttons(1) "btnSelItens" - abre o painel de selecao de
            *-- produtos. Cnt_SelItem (a grade de itens do subnivel) ainda
            *-- nao foi migrado - ver BtnSelItensClick para o guard real que
            *-- ja funciona com a estrutura atual.
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
                .Caption         = "P\<rodutos"
                .ToolTipText     = "Selecionar os Produtos Que Deseja Carregar"
                .MousePointer    = 15
                .PicturePosition = 13
                .SpecialEffect   = 0
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Buttons(2) "btnSair" - Encerrar (legado: Cancel=.T., [Esc])
            WITH .Buttons(2)
                .Top           = 5
                .Left          = 80
                .Width         = 75
                .Height        = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Encerrar"
                .ToolTipText   = "[Esc] Encerrar"
                .MousePointer  = 15
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Dispatcher de clique do grupo Produtos/Encerrar (legado:
        *-- cntBotoes.btnSelItens.Click / cntBotoes.btnSair.Click)
        BINDEVENT(loc_oPg.obj_4c_CmgBotoes, "Click", THIS, "CmdBotoesClick")

        *-- Botao "Subniveis" (legado: SIGOPPEN.SubNiveis, Top=130/Left=284/
        *-- 75x75, Picture geral_subnivel_60.jpg). Abre o detalhamento em
        *-- subniveis da linha corrente da grade. ZOrderSet=14 do dump NAO eh
        *-- transcrito: eh bookkeeping do Form Designer e nao existe em
        *-- runtime (regra #33 CLAUDE.md).
        loc_oPg.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH loc_oPg.cmd_4c_SubNiveis
            .Top             = 130
            .Left            = 284
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
            .Caption         = "\<Subn" + CHR(237) + "veis"
            .ToolTipText     = "Subn" + CHR(237) + "veis"
            .MousePointer    = 15
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg.cmd_4c_SubNiveis, "Click", THIS, "BtnSubNiveisClick")

        *-- Botao "..." de liberacao de consulta de TODOS os subniveis
        *-- (legado: SIGOPPEN.BtnLiberar, Top=564/Left=210/18x19, Caption
        *-- "..."). O Init legado o deixa oculto e so o revela quando
        *-- Type([CrSigOpCdI.ValTmpSubn])=[N] And CrSigOpCdI.ValTmpSubn = 1 -
        *-- CrSigOpCdI eh montado pelo metodo "Carregar" do legado, que vem
        *-- com a carga da grade; ate la vale o estado inicial do legado
        *-- (oculto), transcrito literalmente.
        loc_oPg.AddObject("cmd_4c_Liberar", "CommandButton")
        WITH loc_oPg.cmd_4c_Liberar
            .Top               = 564
            .Left              = 210
            .Width             = 18
            .Height            = 19
            .FontName          = "Tahoma"
            .FontSize          = 7
            .Caption           = "..."
            .ToolTipText       = "Libera Consulta de Todos Subn" + CHR(237) + "veis"
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .F.
        ENDWITH

        BINDEVENT(loc_oPg.cmd_4c_Liberar, "Click", THIS, "BtnLiberarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: painel de Status da Movimentacao
    * (equivalente Cnt_Status do legado - Aprovar/Reprovar/Cancelar).
    * Faixa de cabecalho (regra #11 CLAUDE.md - cabecalho nas DUAS paginas) +
    * container de botoes de acao, reposicionado para DEPOIS da faixa, +
    * campos (Status/Tam/Observacao). Clicks: ver CmdStatusClick/
    * BtnEncerrarStatusClick, mais abaixo neste metodo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        *-- Faixa cinza do cabecalho (equivalente cntSombra do legado,
        *-- replicada aqui igual a Page1 - regra #11). DEVE ser o PRIMEIRO
        *-- AddObject da pagina: cnt_4c_BotoesAcao (Top=32, dentro da area
        *-- da faixa) e demais controles de acao desenham POR CIMA por
        *-- terem sido criados DEPOIS dela.
        loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPg.cnt_4c_Cabecalho
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
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .WordWrap  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .WordWrap  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container de botoes de acao (legado: Cnt_Status.Commandgroup1,
        *-- Top=32/Left=112/Width=235/Height=85) - "barra de acao do topo"
        *-- (regra #11, excecao: Top 20..55 e Height 60..100), mantido NA
        *-- POSICAO ORIGINAL do legado, sem deslocamento, por cima da faixa.
        loc_oPg.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPg.cnt_4c_BotoesAcao
            .Top         = 32
            .Left        = 112
            .Width       = 235
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            *-- CommandGroup (legado: Commandgroup1 - Aprovada/Reprovada/
            *-- Cancelada), relativo ao container (que ja ocupa a posicao
            *-- EXATA do Commandgroup1 legado). Clicks: ver CmdStatusClick e os
            *-- tres handlers BtnAprovarClick/BtnReprovarClick/BtnCancelarClick,
            *-- mais abaixo nesta classe.
            .AddObject("obj_4c_CmgStatus", "CommandGroup")
            WITH .obj_4c_CmgStatus
                .ButtonCount   = 3
                .Top           = 0
                .Left          = 0
                .Width         = 235
                .Height        = 85
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Value         = 1
                .Visible       = .T.

                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .WordWrap        = .T.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Caption         = "\<Aprovada"
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .WordWrap        = .T.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .Caption         = "\<Reprovada"
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Top        = 5
                    .Left       = 155
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .WordWrap   = .T.
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Caption    = "Cancelada"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                ENDWITH
            ENDWITH

            *-- Dispatcher de Aprovar/Reprovar/Cancelar (legado:
            *-- Cnt_Status.Commandgroup1.Command1/2/3.Click)
            BINDEVENT(.obj_4c_CmgStatus, "Click", THIS, "CmdStatusClick")
        ENDWITH

        *-- Shape5 (legado: Cnt_Status.Shape5, Top=34/Left=340) - borda 3D
        *-- decorativa ao lado do CommandGroup. Fica no mesmo Top do grupo
        *-- (32..34), sem deslocamento - companheira visual da barra de
        *-- acao do topo, mesma excecao da regra #11.
        loc_oPg.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oPg.shp_4c_Shape5
            .Top           = 34
            .Left          = 340
            .Width         = 85
            .Height        = 82
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say1 "Status da Movimentacao" (legado: Cnt_Status.Say1, Top=4) -
        *-- deslocado para Top=84 (imediatamente abaixo da faixa, que ocupa
        *-- 0-80). Label NAO esta na lista de excecoes da regra #11 (que
        *-- cobre so Container/CommandButton/OptionGroup da barra de acao).
        loc_oPg.AddObject("lbl_4c_Status", "Label")
        WITH loc_oPg.lbl_4c_Status
            .Top       = 84
            .Left      = 151
            .Width     = 230
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Status da Movimenta" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        *-- Label9 "Tam" (legado: Cnt_Status.Label9, Top=115/Left=5)
        loc_oPg.AddObject("lbl_4c_Tam", "Label")
        WITH loc_oPg.lbl_4c_Tam
            .Top       = 115
            .Left      = 5
            .Width     = 22
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tam"
            .Visible   = .T.
        ENDWITH

        *-- getCodTams (legado: Cnt_Status.getCodTams, Top=131/Left=5) -
        *-- codigo do Tamanho associado ao subnivel selecionado na grade
        *-- (lookup fwbuscaext contra SigCdTam.Cods - comportamento.json).
        loc_oPg.AddObject("txt_4c_CodTams", "TextBox")
        WITH loc_oPg.txt_4c_CodTams
            .Top         = 131
            .Left        = 5
            .Width       = 38
            .Height      = 23
            .Value       = ""
            .MaxLength   = 3
            .Alignment   = 3
            .FontName    = "Verdana"
            .FontSize    = 8
            .SpecialEffect = 1
            .Visible     = .T.
        ENDWITH

        *-- Lookup do Tamanho (legado: Cnt_Status.getCodTams.Valid -
        *-- fwbuscaext contra SigCdTam.Cods). BINDEVENT em LostFocus, que
        *-- eh o equivalente ao Valid do legado (regra #47 CLAUDE.md) - NAO
        *-- KeyPress sem testar a tecla, que abriria o picker a cada letra.
        BINDEVENT(loc_oPg.txt_4c_CodTams, "LostFocus", THIS, "ValidarCodTamsLostFocus")

        *-- Label10 "Observacao" (legado: Cnt_Status.Label10, Top=115/Left=47)
        loc_oPg.AddObject("lbl_4c_Observacao", "Label")
        WITH loc_oPg.lbl_4c_Observacao
            .Top       = 115
            .Left      = 47
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        *-- txtObses (legado: Cnt_Status.txtObses, EditBox, Top=131/Left=47)
        *-- - texto de aprovacao/reprovacao/cancelamento, concatenado pelo
        *-- BO com o usuario logado (ver BtnAprovarClick/BtnReprovarClick/
        *-- BtnCancelarClick). Sem ControlSource - o legado tambem nao liga a
        *-- cursor (ControlSource = "").
        loc_oPg.AddObject("edt_4c_Observacoes", "EditBox")
        WITH loc_oPg.edt_4c_Observacoes
            .Top           = 131
            .Left          = 47
            .Width         = 487
            .Height        = 101
            .Value         = ""
            .BorderStyle   = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- btnCancela "Encerrar" (legado: Cnt_Status.btnCancela, classe
        *-- fwbtng, Top=37/Left=342/Width=80 - sem Height explicito no
        *-- dump, herda 75 da classe fwbtng/padrao canonico de botao).
        loc_oPg.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPg.cmd_4c_Encerrar
            .Top             = 37
            .Left            = 342
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Dismiss do painel de Status sem gravar (legado:
        *-- Cnt_Status.btnCancela.Click)
        BINDEVENT(loc_oPg.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarStatusClick")
    ENDPROC

    *==========================================================================
    * ValidarCodTamsLostFocus - Lookup do campo Tamanho do painel de Status
    * (legado: Cnt_Status.getCodTams.Valid - fwbuscaext contra SigCdTam,
    * chave Cods). PUBLIC (BINDEVENT exige metodo PUBLIC - regra #3
    * CLAUDE.md). Guarda de reentrancia (regra #37): o picker eh MODAL e,
    * ao tirar o foco, pode redisparar o proprio LostFocus. Guarda de
    * valor-nao-mudou: o legado so dispara o Valid quando o valor MUDA,
    * mas LostFocus dispara SEMPRE (inclusive ao so passar o foco pelo
    * campo sem digitar nada) - sem este guard o picker abriria de novo a
    * cada vez que o campo perde o foco com o mesmo codigo ja validado.
    *==========================================================================
    PROCEDURE ValidarCodTamsLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupCodTams
            RETURN
        ENDIF

        loc_oPg    = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)

        IF loc_cValor == THIS.this_cUltimoValidarCodTamsLostFocusValidado
            RETURN
        ENDIF

        THIS.this_lEmLookupCodTams = .T.

        TRY
            IF !EMPTY(loc_cValor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdTam", "cursor_4c_BuscaTam", "Cods", loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                        loc_oPg.txt_4c_CodTams.Value = ALLTRIM(cursor_4c_BuscaTam.Cods)
                    ENDIF

                    IF USED("cursor_4c_BuscaTam")
                        USE IN cursor_4c_BuscaTam
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                loc_oPg.txt_4c_CodTams.Refresh()
            ENDIF

            THIS.this_cUltimoValidarCodTamsLostFocusValidado = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Tamanho")
        ENDTRY

        THIS.this_lEmLookupCodTams = .F.
    ENDPROC

    *==========================================================================
    * AlternarPagina - Funil unico de navegacao entre LISTA (Page1 - grade
    * de pendencias) e STATUS (Page2 - painel de Aprovar/Reprovar/Cancelar,
    * equivalente Cnt_Status do legado). PUBLIC (nao PROTECTED): o
    * TesteAutomatico.prg chama metodos de navegacao do form direto de fora
    * da classe, sem BINDEVENT (regra "TesteAutoprotec"/#3 do CLAUDE.md).
    * Esta tela NAO eh CRUD - nao ha botoes de lista para reabilitar (regra
    * #40 nao se aplica, mesmo precedente de FormSigOpPck/task783), so o
    * modo atual do form. NAO chama THIS.this_oBusinessObject.Buscar(...)/
    * CarregarLista() - SIGOPPENBO.prg ainda nao tem esse metodo nesta fase;
    * chamar algo inexistente estouraria em runtime (regra #13 CLAUDE.md).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
        ELSE
            THIS.this_cModoAtual = "STATUS"

            *-- txtObses/getCodTams nao tem ControlSource no legado (campos
            *-- de entrada livre a cada abertura do painel) - limpar ao
            *-- entrar evita que o texto digitado para a linha anterior
            *-- sobre e seja aplicado por engano a esta.
            THIS.pgf_4c_Paginas.Page2.edt_4c_Observacoes.Value = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_CodTams.Value     = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Popula cursor_4c_Dados (worklist de pendencias em
    * subniveis) via SIGOPPENBO.Buscar() e repinta a grade da Page1 (regra
    * #21 CLAUDE.md - popular cursor NAO repinta a grade sozinho). Chamada
    * no Init (ver InicializarForm) - aprovar/reprovar/cancelar NAO
    * recarregam do banco, so atualizam o cursor em memoria (ver
    * AplicarStatusMovimento), entao esta tela nao precisa de um botao
    * "Buscar" separado (o legado tambem nao tem um - regra fundamental:
    * nao inventar botao que o legado nao tem). PUBLIC (nao PROTECTED): o
    * TesteAutomatico.prg chama metodos de carga do form direto de fora da
    * classe, sem BINDEVENT (regra "TesteAutoprotec"/#3 CLAUDE.md).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.Buscar("")
        ENDIF

        IF USED("cursor_4c_Dados")
            GO TOP IN cursor_4c_Dados
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ChkFlagClick/MouseDown/MouseUp - Suprimem o toggle nativo do CheckBox
    * de Column (regra #46 CLAUDE.md / pattern #185) - a alternancia real
    * acontece em ChkFlagKeyPress, chamado por MouseUp/Enter/Espaco.
    *==========================================================================
    PROCEDURE ChkFlagClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkFlagMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkFlagMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkFlagKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkFlagKeyPress - Alterna a marcacao da linha corrente (legado:
    * Grade.seleciona.fwcheckbox1.Click - "If !This.Value / ThisForm.
    * Desmarca / Else / This.Value = ThisForm.Marca() / Endif"). Marca()/
    * Desmarca() do legado preparam ~10 cursores de trabalho (crTpmMvItn,
    * crTpmMvIts, crSigSubMv, xBaixaSS, ...) para a baixa em subniveis - esse
    * subsistema de carga de itens ainda nao foi migrado (fica para fase
    * dedicada); aqui fica o efeito visivel e auditavel da marcacao: alterna
    * Flag no cursor da grade e, ao MARCAR a linha, abre o painel de Status
    * (legado: "If oPendSnope.tStatus = 1 / ThisForm.Cnt_Status.Visible =
    * .T." - aqui simplificado para toda marcacao, ja que a tela nao tem
    * ainda o fluxo alternativo de baixa direta sem aprovacao).
    *==========================================================================
    PROCEDURE ChkFlagKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lNovoValor

        IF !INLIST(par_nKeyCode, 13, 32) OR !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_lNovoValor = !cursor_4c_Dados.Flag
        REPLACE Flag WITH loc_lNovoValor IN cursor_4c_Dados
        THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        NODEFAULT

        IF loc_lNovoValor
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * HeaderSelecionaClick - Marca/desmarca todas as linhas da grade (legado:
    * Grade.seleciona.Header1.Click - alterna o Tag do header entre 'X' e
    * ' ' e aplica Flag a todas as linhas do cursor).
    *==========================================================================
    PROCEDURE HeaderSelecionaClick()
        LOCAL loc_oGrid, loc_lMarcarTudo

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_oGrid      = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        loc_lMarcarTudo = (loc_oGrid.Column1.Header1.Tag <> "X")

        SELECT cursor_4c_Dados
        SCAN
            REPLACE Flag WITH loc_lMarcarTudo
        ENDSCAN
        GO TOP IN cursor_4c_Dados

        loc_oGrid.Column1.Header1.Tag = IIF(loc_lMarcarTudo, "X", "")
        loc_oGrid.Refresh()
    ENDPROC

    *==========================================================================
    * CmdBotoesClick - Dispatcher do grupo Produtos/Encerrar da Page1
    * (legado: cntBotoes - Buttons(1)=btnSelItens, Buttons(2)=btnSair).
    * O legado tem um Click POR BOTAO; aqui o CommandGroup entrega um unico
    * evento com o indice, e cada ramo delega ao handler nomeado do botao
    * correspondente - um para um com o legado.
    *==========================================================================
    PROCEDURE CmdBotoesClick(par_nValue)
        DO CASE
        CASE par_nValue = 1
            THIS.BtnSelItensClick()
        CASE par_nValue = 2
            THIS.BtnSairClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnSelItensClick - Botao "Produtos" (legado: cntBotoes.btnSelItens.
    * Click - "If Not TmpPends.Flag / Thisform.Grade.SetFocus / Else <monta
    * a grade de itens do subnivel e exibe Cnt_SelItem> / Endif").
    *
    * O ramo ELSE do legado religa Thisform.Cnt_SelItem.Grade a crTpmMvItn
    * (dez ControlSource + InputMask derivado de CrSigOpCdd.CasQtds) e torna
    * o painel visivel. crTpmMvItn eh um dos cursores de trabalho montados
    * pelo metodo "Carregar" do legado (~2860 linhas), que entra junto com a
    * carga da grade principal; enquanto o cursor nao existe, religar a grade
    * estouraria "Alias CRTPMMVITN is not found" (regra #41 CLAUDE.md). O
    * guard de marcacao abaixo eh transcrito literal e ja eh o caminho que o
    * usuario percorre hoje: sem linha marcada, o foco volta para a grade.
    *==========================================================================
    PROCEDURE BtnSelItensClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR !cursor_4c_Dados.Flag
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        *-- Linha marcada: o legado troca a grade principal pelo painel de
        *-- itens. Sem crTpmMvItn o painel nao tem o que exibir, entao avisa
        *-- em vez de abrir uma grade vazia (regra #27 CLAUDE.md: ausencia
        *-- tem de ficar VISIVEL, nunca mascarada).
        IF !USED("crTpmMvItn")
            MsgAviso("Os itens do subn" + CHR(237) + "vel n" + CHR(227) + "o est" + ;
                     CHR(227) + "o carregados para esta movimenta" + CHR(231) + CHR(227) + ;
                     "o.", "Produtos")
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        SELECT crTpmMvItn
        SET ORDER TO
        GO TOP
        REPLACE ALL Marcas WITH .T.
        GO TOP IN crTpmMvItn
    ENDPROC

    *==========================================================================
    * BtnSairClick - Botao "Encerrar" da Page1 (legado: cntBotoes.btnSair.
    * Click, Cancel = .T.).
    *
    * No legado este botao eh a FINALIZACAO da movimentacao: alem do
    * "ThisForm.Release", ele recalcula impostos, totais, cotacao e parcelas
    * chamando metodos do form PAI (ThisForm.parentform.CalcImposto /
    * AtuaTot / Cotacao / CalculaPar / calc_valite / AcioCancela e o
    * Grupo_Salva.Salva.Click dele) sobre os cursores de trabalho TprMvCab,
    * crTpmMvItn, crTpmMvIts, xPar, TmpOperacao, TmpPendR e crStsMvPec.
    * O SIGOPPEN eh um dialogo FILHO: o legado recebe o pai no Init
    * (pform/pForm2) e todo esse bloco opera exclusivamente sobre ele. A
    * cadeia pai + cursores de trabalho entra com a carga da grade; o que
    * pertence a ESTE form - fechar a tela - eh transcrito aqui.
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSubNiveisClick - Botao "Subniveis" (legado: SIGOPPEN.SubNiveis.Click
    * - "Thisform.Podatamgr = Thisform.ParentForm.Podatamgr / Do Form
    * SigMvSbn with Thisform, TmpPends.Emps, TmpPends.Dopes, TmpPends.Numes").
    *
    * A primeira linha do legado so repassa o gerenciador de conexao do pai;
    * na arquitetura nova a conexao eh a global gnConnHandle, entao resta a
    * abertura do dialogo. CREATEOBJECT no lugar de DO FORM (o projeto nao
    * tem .SCX; alem disso o indice de carga sob demanda so enxerga
    * CREATEOBJECT) e Show() FORA do TRY, porque FormSigMvSbn eh modal e o
    * TRY engoliria os erros da tela filha inteira, derrubando a referencia
    * LOCAL e fechando-a sozinha (regra #29 CLAUDE.md).
    *==========================================================================
    PROCEDURE BtnSubNiveisClick()
        LOCAL loc_oForm, loc_oErro
        loc_oForm = .NULL.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormSigMvSbn", THIS, ;
                                     cursor_4c_Dados.Emps, ;
                                     cursor_4c_Dados.Dopes, ;
                                     cursor_4c_Dados.Numes)
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir os Subn" + CHR(237) + "veis da movimenta" + CHR(231) + ;
                    CHR(227) + "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnLiberarClick - Botao "..." de liberacao da consulta de TODOS os
    * subniveis (legado: SIGOPPEN.BtnLiberar.Click).
    *
    * Legado: avisa que a liberacao exige autorizacao, chama o dialogo de
    * senha de supervisor ("Do Form SigOpSen With 'LIBSUBN', ... To
    * _Retorno"), aceita apenas retorno iniciado por "*" e, confirmada a
    * autorizacao, recarrega a grade com o sexto parametro de "Carregar"
    * ligado (LibPend = .T.).
    *
    * O SigOpSen do legado existe somente em C:\4install\FortyusMC\Fortyus\,
    * fora do SET PATH montado pelo config.prg - a chamada estoura "File
    * 'sigopsen.scx' does not exist". Sendo um gate de AUTORIZACAO, a falha eh
    * tratada FAIL-CLOSED e VISIVEL: ausencia do dialogo = NAO autorizado,
    * com o mesmo desfecho do "Autorizacao nao Confirmada" do legado. E
    * PROIBIDO trocar por MsgConfirma ou por um caminho que simplesmente
    * libere - seria conceder acesso sem senha, em silencio.
    *==========================================================================
    PROCEDURE BtnLiberarClick()
        LOCAL loc_cRetorno, loc_cUsuLibs, loc_lAutorizado, loc_oErro

        loc_cRetorno    = ""
        loc_cUsuLibs    = ""
        loc_lAutorizado = .F.

        MsgAviso("Liberar Consulta de Todos Subn" + CHR(237) + "veis somente com " + ;
                 "Autoriza" + CHR(231) + CHR(227) + "o!!", "ERRO")

        *-- TRY cobre SO a chamada do dialogo (regra #29): a avaliacao do
        *-- retorno fica fora, para o fluxo nao depender do CATCH.
        TRY
            DO FORM SigOpSen WITH "LIBSUBN", ;
                 "Libera Consulta de Todos Subn" + CHR(237) + "veis", "" TO loc_cRetorno
        CATCH TO loc_oErro
            loc_cRetorno = ""
            MsgErro("O di" + CHR(225) + "logo de autoriza" + CHR(231) + CHR(227) + "o " + ;
                    "(SigOpSen) n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
                    "vel neste ambiente, portanto a libera" + CHR(231) + CHR(227) + "o " + ;
                    "foi NEGADA." + CHR(13) + loc_oErro.Message, "Autoriza" + CHR(231) + ;
                    CHR(227) + "o Indispon" + CHR(237) + "vel")
        ENDTRY

        IF VARTYPE(loc_cRetorno) = "C" AND LEFT(loc_cRetorno, 1) = "*"
            loc_lAutorizado = .T.
            loc_cUsuLibs    = SUBSTR(loc_cRetorno, 2, 10)
        ENDIF

        IF !loc_lAutorizado
            MsgAviso("Autoriza" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o " + ;
                     "Confirmada!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(loc_cUsuLibs)
            RETURN
        ENDIF

        *-- Autorizada: o legado zera TmpPends e refaz a carga com LibPend
        *-- ligado. A flag fica no BO (this_lLibPend) para quando o filtro
        *-- de acesso por empresa (fAcessoEmpresa, regra fundamental: fora
        *-- de escopo sem o form chamador - ver nota de SIGOPPENBO.Buscar)
        *-- for implementado; hoje SIGOPPENBO.Buscar() nao restringe por
        *-- empresa, entao a flag ainda nao muda o resultado da consulta -
        *-- recarregar aqui e necessario mesmo assim, pois sem isso o
        *-- usuario autorizado via o mesmo ZAP sem reconsulta que deixava a
        *-- grade vazia antes desta fase.
        THIS.this_oBusinessObject.this_lLibPend = .T.
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * CmdStatusClick - Dispatcher do grupo de status da Page2 (legado:
    * Cnt_Status.Commandgroup1 - Command1=Aprovada, Command2=Reprovada,
    * Command3=Cancelada). Cada ramo delega ao handler nomeado do botao,
    * um para um com os tres Click do legado.
    *==========================================================================
    PROCEDURE CmdStatusClick(par_nValue)
        DO CASE
        CASE par_nValue = 1
            THIS.BtnAprovarClick()
        CASE par_nValue = 2
            THIS.BtnReprovarClick()
        CASE par_nValue = 3
            THIS.BtnCancelarClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnAprovarClick / BtnReprovarClick / BtnCancelarClick - os tres botoes
    * do grupo de status (legado: Cnt_Status.Commandgroup1.Command1.Click /
    * Command2.Click / Command3.Click). Os tres compartilham o mesmo corpo no
    * legado (monta a observacao, grava pStatus e devolve a Lista), variando
    * so a posicao lida em StsGrvs e o texto do prefixo - por isso o corpo
    * comum fica em AplicarStatusMovimento.
    *==========================================================================
    PROCEDURE BtnAprovarClick()
        THIS.AplicarStatusMovimento(1)
    ENDPROC

    PROCEDURE BtnReprovarClick()
        THIS.AplicarStatusMovimento(2)
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AplicarStatusMovimento(3)
    ENDPROC

    *==========================================================================
    * AplicarStatusMovimento - Corpo comum de Aprovar(1)/Reprovar(2)/
    * Cancelar(3). Status gravado vem de SigOpCdd.StsGrvs (char(3)
    * posicional - regra #42), carregado via SIGOPPENBO.CarregarConfigOperacao.
    * Antes de chamar Atualizar(), repoe no BO os valores REAIS gravados em
    * SigMvCab (CarregarDoCursor a partir de uma consulta fresca) - sem isso,
    * Atualizar() reescreveria ChkSubn/ChkBxParcs com o default .F. das
    * properties do BO (nunca carregadas para esta linha), corrompendo esses
    * campos a cada aprovacao.
    *==========================================================================
    PROTECTED PROCEDURE AplicarStatusMovimento(par_nValue)
        LOCAL loc_oPg, loc_oBO, loc_cBusca, loc_cSQL, loc_cObsAnterior, ;
              loc_cObsNova, loc_cStatus

        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBO = THIS.this_oBusinessObject

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        *-- Reprovar/Cancelar exigem motivo preenchido (legado: Command2.
        *-- Click/Command3.Click - MessageBox + Return quando txtObses esta
        *-- vazio)
        IF par_nValue = 2 AND EMPTY(loc_oPg.edt_4c_Observacoes.Value)
            MsgAviso("Necess" + CHR(225) + "rio informar o motivo da reprova" + ;
                     CHR(231) + CHR(227) + "o!", "Motivo N" + CHR(227) + "o Preenchido")
            loc_oPg.edt_4c_Observacoes.SetFocus()
            RETURN
        ENDIF

        IF par_nValue = 3 AND EMPTY(loc_oPg.edt_4c_Observacoes.Value)
            MsgAviso("Necess" + CHR(225) + "rio informar o motivo do cancelamento!", ;
                     "Motivo N" + CHR(227) + "o Preenchido")
            loc_oPg.edt_4c_Observacoes.SetFocus()
            RETURN
        ENDIF

        loc_cBusca = cursor_4c_Dados.Emps + cursor_4c_Dados.Dopes + STR(cursor_4c_Dados.Numes, 6)

        IF !loc_oBO.CarregarConfigOperacao(cursor_4c_Dados.Dopes)
            RETURN
        ENDIF

        *-- Repoe no BO os valores REAIS do registro (ver nota do cabecalho)
        IF USED("cursor_4c_MovAtual")
            USE IN cursor_4c_MovAtual
        ENDIF
        loc_cSQL = "SELECT * FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cBusca)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovAtual") < 0 OR ;
           !USED("cursor_4c_MovAtual") OR RECCOUNT("cursor_4c_MovAtual") = 0
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar a " + ;
                    "movimenta" + CHR(231) + CHR(227) + "o para atualiza" + CHR(231) + ;
                    CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            IF USED("cursor_4c_MovAtual")
                USE IN cursor_4c_MovAtual
            ENDIF
            RETURN
        ENDIF
        loc_oBO.CarregarDoCursor("cursor_4c_MovAtual")
        USE IN cursor_4c_MovAtual

        loc_cObsAnterior = ALLTRIM(TratarNulo(cursor_4c_Dados.Obss, "C"))

        DO CASE
        CASE par_nValue = 1
            loc_cStatus = SUBSTR(loc_oBO.this_cStsGrvs, 1, 1)
            IF !EMPTY(loc_oPg.edt_4c_Observacoes.Value)
                loc_cObsNova = IIF(!EMPTY(loc_cObsAnterior), loc_cObsAnterior + CHR(13), "") + ;
                               "Aprova" + CHR(231) + CHR(227) + "o : " + ;
                               ALLTRIM(loc_oPg.edt_4c_Observacoes.Value) + " (" + ;
                               ALLTRIM(gc_4c_UsuarioLogado) + ")"
            ELSE
                loc_cObsNova = "Aprovado!"
            ENDIF

        CASE par_nValue = 2
            loc_cStatus  = SUBSTR(loc_oBO.this_cStsGrvs, 2, 1)
            loc_cObsNova = IIF(!EMPTY(loc_cObsAnterior), loc_cObsAnterior + CHR(13), "") + ;
                           "Reprova" + CHR(231) + CHR(227) + "o : " + ;
                           ALLTRIM(loc_oPg.edt_4c_Observacoes.Value) + " (" + ;
                           ALLTRIM(gc_4c_UsuarioLogado) + ")"

        CASE par_nValue = 3
            loc_cStatus  = SUBSTR(loc_oBO.this_cStsGrvs, 3, 1)
            loc_cObsNova = IIF(!EMPTY(loc_cObsAnterior), loc_cObsAnterior + CHR(13), "") + ;
                           "Cancelamento : " + ;
                           ALLTRIM(loc_oPg.edt_4c_Observacoes.Value) + " (" + ;
                           ALLTRIM(gc_4c_UsuarioLogado) + ")"
        ENDCASE

        loc_oBO.this_cObses   = loc_cObsNova
        loc_oBO.this_cPStatus = loc_cStatus

        IF loc_oBO.Atualizar()
            REPLACE Obss WITH loc_cObsNova, pStatus WITH loc_cStatus IN cursor_4c_Dados

            IF par_nValue = 3
                REPLACE Flag WITH .F. IN cursor_4c_Dados
            ENDIF

            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            MsgInfo("Status da movimenta" + CHR(231) + CHR(227) + "o atualizado com " + ;
                    "sucesso!", "Confirmar")
            THIS.AlternarPagina(1)

            IF loc_oBO.this_lGrvAutos
                THIS.Release()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarStatusClick - Fecha o painel de Status sem gravar (legado:
    * Cnt_Status.btnCancela.Click - desmarca a linha e devolve a Lista).
    *==========================================================================
    PROCEDURE BtnEncerrarStatusClick()
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            REPLACE Flag WITH .F. IN cursor_4c_Dados
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF

        THIS.AlternarPagina(1)
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPPENBO.prg):
*==============================================================================
* SIGOPPENBO.prg - Business Object para Pendencias Em Subniveis (SIGOPPEN)
* Tabela principal: SigMvCab (cabecalho da movimentacao em aberto)
* Tabelas relacionadas: SigMvItn, SigCdOpe, SigCdEmp, SigCdPro, SigPrTrp,
*                        SigOpCdd, SigClJob, SigBxEst, SigSubMv
*==============================================================================

DEFINE CLASS SIGOPPENBO AS BusinessBase

    *-- Identificacao da movimentacao em aberto (SigMvCab) -------------------
    this_cEmps          = ""    && char(3)  - Empresa da movimentacao
    this_cDopes         = ""    && char(20) - Codigo da operacao (Dopes)
    this_nNumes         = 0     && numeric(6,0) - Numero sequencial da movimentacao
    this_cEmpDopNums    = ""    && char(29) - Chave combinada Emps+Dopes+Str(Numes,6)
    this_cCidChaves     = ""    && char(20) - Chave unica (PK de SigMvCab)
    this_cMascNum       = ""    && char(10) - Numero mascarado para exibicao em tela
    this_dDatas         = {}    && datetime - Data da movimentacao
    this_cNotas         = ""    && char(6)  - Numero da nota fiscal (legado)
    this_cNumeroNota    = ""    && char(10) - Numero da nota fiscal (NF-e)
    this_cPedidoWeb     = ""    && char(50) - Identificacao do pedido Web
    this_cIdTransp      = ""    && char(15) - Identificacao da transportadora
    this_cObsCabMovs    = ""    && char(40) - Observacao do cabecalho da movimentacao
    this_cObses         = ""    && text     - Observacoes gerais (memo)
    this_cPStatus       = ""    && char(1)  - Status de aprovacao da movimentacao
    this_cStatusAprRep  = ""    && char(1)  - Status aplicado na ultima Aprovacao/Reprovacao
    this_lChkSubn       = .F.   && bit      - Indica se ja foi baixada em subniveis
    this_lChkBxParcs    = .F.   && bit      - Indica baixa parcial permitida
    this_lChkQtdss      = .F.   && bit      - Indica conferencia de quantidades habilitada
    this_cGrupoOs       = ""    && char(10) - Grupo de origem
    this_cContaOs       = ""    && char(10) - Conta de origem
    this_cGrupoDs       = ""    && char(10) - Grupo de destino
    this_cContaDs       = ""    && char(10) - Conta de destino
    this_cGrResps       = ""    && char(10) - Grupo responsavel
    this_cVends         = ""    && char(10) - Responsavel/Vendedor
    this_dPrazoEnts     = {}    && datetime - Prazo de entrega
    this_nValOs         = 0     && numeric(11,2) - Valor da operacao de origem

    *-- Configuracao da operacao vigente (SigCdOpe / SigOpCdd) --------------
    this_cDopesAtual    = ""    && char(20) - Operacao vigente sendo tratada
    this_nDopesNivel    = 0     && numeric  - Nivel da operacao (Nivels)
    this_cOpera         = ""    && char(1)  - Tipo de operacao (Opers)
    this_nPuxaOrigem    = 0     && numeric  - ConOSubs: forma de puxar origem
    this_nPuxaDestino   = 0     && numeric  - ConDSubs: forma de puxar destino
    this_cOpePad        = ""    && char(20) - Operacao padrao associada (OpePads)
    this_cOpePadC       = ""    && char(20) - Operacao padrao de componentes (OpePadcs)
    this_lBaixaSubN     = .F.   && bit      - BaixaSns: baixa automatica em subniveis
    this_lBxParc        = .F.   && bit      - BxParcials: permite baixa parcial
    this_lBxAutos       = .F.   && bit      - BxAutos: baixa automatica
    this_cCarOpCr       = ""    && char(1)  - Opcrs: tipo de carga de operacao credito
    this_nMarcaSubns    = 0     && numeric  - MarcaSubns: marca subniveis ao localizar
    this_nCupFis        = 0     && numeric(1,0) - CupFis: tipo de cupom fiscal
    this_nDigItens      = 0     && numeric  - DigItens: permite digitar itens manualmente
    this_nVars          = 0     && numeric(9,4) - Vars: variacao percentual da operacao
    this_cCfos          = ""    && char     - Cfos: codigo fiscal da operacao
    this_nNDopes        = 0     && numeric  - nDopes: nivel numerico da operacao
    this_nParcs         = 0     && numeric  - parcs: quantidade de parcelas
    this_cCMoes         = ""    && char(3)  - cMoes: moeda da operacao
    this_nNDdVals       = 0     && numeric  - nDdVals: dias de vencimento padrao
    this_lValpres       = .F.   && bit      - Valpres: valores pre-definidos
    this_cCadprods      = ""    && char     - cadprods: cadastra produto na operacao

    *-- Filtros e parametros de tela (Init/Carregar do legado) --------------
    this_nMeses         = 0     && numeric  - Qtd. de meses do filtro de periodo
    this_dAntValue      = {}    && date     - Valor anterior do filtro de meses
    this_lLibPend       = .F.   && logical  - Libera visualizacao de subniveis bloqueados
    this_lChkPends      = .F.   && logical  - Filtra apenas pendencias marcadas
    this_lDdBloqueado   = .F.   && logical  - Indica filtro de datas bloqueado
    this_nNfServicos    = 0     && numeric  - Tipo de nota fiscal de servicos
    this_lBuscProd      = .F.   && logical  - Indica busca restrita por produto (pbusprod)
    this_lSelecStatus   = .F.   && logical  - Indica que o status foi selecionado no painel
    this_nItemMov       = 0     && numeric  - Item de movimentacao em edicao (ItemMov)
    this_cCfgTitOrigem      = "" && char   - Titulo configurado para "Origem"
    this_cCfgTitDestino     = "" && char   - Titulo configurado para "Destino"
    this_cCfgTitVendedor    = "" && char   - Titulo configurado para "Vendedor"
    this_cCfgTitResponsavel = "" && char   - Titulo configurado para "Responsavel"
    this_cCfgTitJob         = "" && char   - Titulo configurado para "Job"
    this_cCfgTitListaVends  = "" && char   - Titulo configurado para lista de vendedores
    this_cCodigo        = ""    && char    - Codigo digitado no filtro "Procura"
    this_cDoc           = ""    && char(6) - Documento digitado no filtro "Documento"
    this_cLocPed        = ""    && char    - Pedido/Localizacao digitada no filtro
    this_cCpros         = ""    && char(10)- Produto filtrado na pesquisa
    this_cIdTranspFiltro= ""    && char    - Transportadora filtrada na pesquisa
    this_lLiberaConsulta= .F.   && logical - Autorizacao para liberar consulta de subniveis

    *-- Itens da movimentacao (crTpmMvItn / SigMvItn) ------------------------
    this_nCItem         = 0     && numeric - Contador de itens no processo de carga
    this_nQtds          = 0     && numeric - Quantidade do item corrente
    this_nQtdsP         = 0     && numeric - Quantidade original do item (antes de ajuste)
    this_nValCars       = 0     && numeric - Valor carregado do item corrente
    this_nTotCar        = 0     && numeric - Total carregado (rateio de frete/despesas)
    this_nTotite        = 0     && numeric - Total de itens apos agrupamento

    *-- Configuracao de status de gravacao (SigOpCdd.StsGrvs/GrvAutos) ------
    this_cStsGrvs       = ""    && char(3) - pos1=Aprovado pos2=Reprovado pos3=Cancelado
    this_lGrvAutos      = .F.   && bit - fecha a tela automaticamente apos gravar o status

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_nMeses  = 0
            THIS.this_dAntValue = DATE()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SIGOPPENBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave usada nos UPDATE/auditoria (EmpDopNums,
    * o this_cCampoChave configurado no Init). char(29) posicional (Emps+Dopes+
    * Str(Numes,6)) lido direto da coluna - ALLTRIM na chave INTEIRA eh inofensivo
    * (char no SQL Server compara com blank-padding ANSI); regra #42 so proibe
    * ALLTRIM nas PARTES internas de uma montagem manual.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos de SigMvCab (cabecalho da movimentacao
    * em aberto) do cursor informado para as propriedades do BO.
    * this_cStatusAprRep (status aplicado na ultima Aprovacao/Reprovacao) e
    * this_lChkQtdss (ChkQtdss) NAO sao colunas de SigMvCab - o primeiro eh
    * variavel de trabalho do form, o segundo vem da config da operacao em
    * SigCdOpe - por isso ficam fora deste mapeamento.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps,       "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes,      "C"))
            THIS.this_nNumes       = TratarNulo(Numes,              "N")
            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cCidChaves   = ALLTRIM(TratarNulo(CidChaves,  "C"))
            THIS.this_cMascNum     = ALLTRIM(TratarNulo(MascNum,    "C"))
            THIS.this_dDatas       = ConverterParaData(TratarNulo(Datas, "D"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas,       "C"))
            THIS.this_cNumeroNota  = ALLTRIM(TratarNulo(NumeroNota,  "C"))
            THIS.this_cPedidoWeb   = ALLTRIM(TratarNulo(PedidoWeb,   "C"))
            THIS.this_cIdTransp    = ALLTRIM(TratarNulo(IdTransp,    "C"))
            THIS.this_cObsCabMovs  = ALLTRIM(TratarNulo(ObsCabMovs,  "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus,     "C"))
            THIS.this_lChkSubn     = ConverterParaLogico(ChkSubn)
            THIS.this_lChkBxParcs  = ConverterParaLogico(ChkBxParcs)
            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs,     "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs,     "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs,     "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs,     "C"))
            THIS.this_cGrResps     = ALLTRIM(TratarNulo(GrResps,     "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends,       "C"))
            THIS.this_dPrazoEnts   = ConverterParaData(TratarNulo(PrazoEnts, "D"))
            THIS.this_nValOs       = TratarNulo(ValOs, "N")

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Mantem o comportamento padrao herdado de BusinessBase (recusa a
    * operacao). Conferido no codigo fonte legado (SIGOPPEN_form_codigo_fonte.txt)
    * e no comportamento.json: a tela so aprova/reprova/cancela/baixa movimentos
    * EM ABERTO que ja existem em SigMvCab (varios "Update SigMvCab Set ...") -
    * em nenhum ponto o legado faz "Insert Into SigMvCab". Sobrescrever Inserir()
    * aqui exigiria inventar valores para as ~140 colunas NOT NULL de SigMvCab
    * que esta tela nunca grava, violando o PILAR 2 (schema identico) e o
    * PILAR 1 (a tela nao cria movimentacao nova).
    *==========================================================================

    *==========================================================================
    * Atualizar - UPDATE SigMvCab com os campos que as acoes de Aprovar/
    * Reprovar/Cancelar/Baixar Subnivel do legado alteram (Cnt_Status.
    * Commandgroup1.Click Command1/2/3 e o fluxo de SubNiveis), consolidados
    * num unico UPDATE pela chave EmpDopNums.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lContinuar, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            IF EMPTY(loc_cChave)
                MsgErro("Chave do movimento (EmpDopNums) n" + CHR(227) + "o definida " + ;
                        "para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Usuals = "     + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "DtAlts = GETDATE(), " + ;
                           "Obses = "      + EscaparSQL(THIS.this_cObses) + ", " + ;
                           "pStatus = "    + EscaparSQL(PADR(THIS.this_cPStatus, 1)) + ", " + ;
                           "ChkSubn = "    + IIF(THIS.this_lChkSubn, "1", "0") + ", " + ;
                           "ChkBxParcs = " + IIF(THIS.this_lChkBxParcs, "1", "0") + ", " + ;
                           "DtBaixas = "   + IIF(THIS.this_lChkSubn, "GETDATE()", "NULL") + " " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd") >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao atualizar a pend" + CHR(234) + "ncia em subn" + ;
                            CHR(237) + "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a worklist de pendencias em subniveis (Page1/
    * grd_4c_Dados) a partir de SigMvCab. Equivalente REDUZIDO do metodo
    * "Carregar" do legado (SIGOPPEN_form_codigo_fonte.txt, PROCEDURE
    * carregar, ~650 linhas).
    *
    * ESCOPO DELIBERADAMENTE REDUZIDO (documentado, NAO omitido em
    * silencio - REGRA FUNDAMENTAL do CLAUDE.md): o "Carregar" legado so
    * roda dentro de um dialogo FILHO aberto por uma tela de movimentacao
    * especifica ("Do Form SigOpPen With ThisForm, ..."), que fixa a
    * variavel de modulo TprMvCab (cabecalho da movimentacao do
    * CHAMADOR) e carrega quatro cursores de configuracao POR OPERACAO
    * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd/CrSigOpCdI) antes de montar a
    * consulta - sao eles que decidem, operacao por operacao, qual conta
    * vale como "origem"/"destino" (_PuxaOrigem/_PuxaDestino), quais
    * status ficam visiveis (StsSubs), o filtro de acesso por empresa
    * (fAcessoEmpresa) e o agrupamento por nivel de subnivel (SigOpCsn).
    * Esta task expoe FormSIGOPPEN como tela INDEPENDENTE no menu
    * (popMovimentos - "Pendencias em Subniveis"), sem nenhum form
    * chamador: TprMvCab e crSigCdOpe NUNCA existem neste caminho, e
    * fabricar os dois so para preencher o metodo seria inventar regra
    * de negocio (tambem PROIBIDO pelo CLAUDE.md).
    *
    * O que fica, fiel ao legado e sem depender do contexto ausente: a
    * condicao-base de pendencia - "ChkSubn = 0" - eh, em TODA variante
    * do WHERE do legado, o filtro que sempre aparece (Iif(crSigCdOpe.
    * Subns = 1,[a.ChkSubn = ?llsubnt And ],...) com llsubnt = .F." -
    * aqui aplicada a TODAS as operacoes de uma vez, no lugar de uma
    * unica operacao escolhida pelo form chamador. Origem/Destino usam
    * Grupo+Conta diretos de SigMvCab (sem o desvio _PuxaOrigem/
    * _PuxaDestino, que depende de configuracao por operacao) e a
    * descricao da conta vem de SigCdCli.Rclis - mesma tabela/coluna que
    * o legado consulta por CrEest.ContaOs/contads (dump, linha ~3480).
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltro, loc_oErro
        loc_lSucesso = .F.
        loc_cFiltro  = TratarNulo(par_cFiltro, "C")

        TRY
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.MascNum, a.Datas, a.TpFats, " + ;
                       "RTRIM(a.GrupoOs) + '/' + RTRIM(a.ContaOs) AS Origem, " + ;
                       "RTRIM(a.GrupoDs) + '/' + RTRIM(a.ContaDs) AS Destino, " + ;
                       "a.Valos, a.Notas, a.ChkSubn AS ChkSubN, " + ;
                       "CONVERT(VARCHAR(8000), a.Obses) AS Obss, " + ;
                       "ISNULL(co.Rclis, '') AS DescsO, ISNULL(cd.Rclis, '') AS DescsD, " + ;
                       "LEFT(a.CidChaves, 10) AS cIdChaves, a.Usuars, a.EmpDs, a.pStatus, " + ;
                       "a.PrazoEnts AS DtEnts, a.ObsCabMovs, a.Jobs, a.PedidoWeb, " + ;
                       "a.IDEntrega, a.ChaveNota, a.IDTransp, a.NumeroNota, a.EmpRet " + ;
                       "FROM SigMvCab a " + ;
                       "LEFT JOIN SigCdCli co ON co.Iclis = a.ContaOs " + ;
                       "LEFT JOIN SigCdCli cd ON cd.Iclis = a.ContaDs " + ;
                       "WHERE a.ChkSubn = 0"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND (" + loc_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Datas, a.Emps, a.Dopes, a.Numes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp") >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    IF USED("cursor_4c_DadosTmp") AND RECCOUNT("cursor_4c_DadosTmp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                    ENDIF
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar pend" + CHR(234) + "ncias em subn" + CHR(237) + ;
                        "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarConfigOperacao - Le StsGrvs/GrvAutos de SigOpCdd para a operacao
    * informada. StsGrvs eh char(3) posicional: pos1 = status gravado ao
    * Aprovar, pos2 = status gravado ao Reprovar, pos3 = status gravado ao
    * Cancelar (legado: Cnt_Status.Commandgroup1.Command1/2/3.Click -
    * Substr(crSigOpCdd.StsGrvs, 1|2|3, 1)). Usado pelo form antes de montar
    * o UPDATE de aprovacao/reprovacao/cancelamento.
    *==========================================================================
    PROCEDURE CarregarConfigOperacao(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cStsGrvs  = ""
            THIS.this_lGrvAutos = .F.

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

            loc_cSQL = "SELECT StsGrvs, GrvAutos FROM SigOpCdd " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") >= 0
                IF USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
                    SELECT cursor_4c_CfgOpe
                    GO TOP
                    THIS.this_cStsGrvs  = PADR(TratarNulo(StsGrvs, "C"), 3)
                    THIS.this_lGrvAutos = (TratarNulo(GrvAutos, "N") = 1)
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + ;
                            CHR(227) + "o " + ALLTRIM(par_cDopes) + " n" + CHR(227) + ;
                            "o encontrada em SigOpCdd.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar a configura" + CHR(231) + CHR(227) + "o da " + ;
                        "opera" + CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.CarregarConfigOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


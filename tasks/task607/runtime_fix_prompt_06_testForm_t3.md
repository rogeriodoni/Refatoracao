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
[2026-09-28 10:07:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 10:07:48] [INFO] Config FPW: (nao fornecido)
[2026-09-28 10:07:48] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 10:07:48] [INFO] Timeout: 300 segundos
[2026-09-28 10:07:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hubo23r.prg
[2026-09-28 10:07:48] [INFO] Conteudo do wrapper:
[2026-09-28 10:07:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigpres2', 'C:\4c\tasks\task607\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigpres2', 'C:\4c\tasks\task607\logs\06_testForm.log'
QUIT

[2026-09-28 10:07:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hubo23r.prg
[2026-09-28 10:07:48] [INFO] VFP output esperado em: C:\4c\tasks\task607\vfp_output.txt
[2026-09-28 10:07:48] [INFO] Executando Visual FoxPro 9...
[2026-09-28 10:07:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hubo23r.prg
[2026-09-28 10:07:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hubo23r.prg
[2026-09-28 10:07:48] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigpres2
Inicio: 28/09/2026 10:07:48

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 28/09/2026 10:10:59
Duracao: 191 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-28 10:10:59] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-28 10:10:59] [INFO] VFP9 finalizado em 190.7722495 segundos
[2026-09-28 10:10:59] [INFO] Exit Code: 
[2026-09-28 10:10:59] [INFO] 
[2026-09-28 10:10:59] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-28 10:10:59] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hubo23r.prg
[2026-09-28 10:10:59] [INFO] 
[2026-09-28 10:10:59] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-28 10:10:59] [INFO] * Auto-generated wrapper for parameters
[2026-09-28 10:10:59] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 10:10:59] [INFO] * Parameters: 'Formsigpres2', 'C:\4c\tasks\task607\logs\06_testForm.log'
[2026-09-28 10:10:59] [INFO] 
[2026-09-28 10:10:59] [INFO] * Anti-dialog protections for unattended execution
[2026-09-28 10:10:59] [INFO] SET SAFETY OFF
[2026-09-28 10:10:59] [INFO] SET RESOURCE OFF
[2026-09-28 10:10:59] [INFO] SET TALK OFF
[2026-09-28 10:10:59] [INFO] SET NOTIFY OFF
[2026-09-28 10:10:59] [INFO] SYS(2335, 0)
[2026-09-28 10:10:59] [INFO] 
[2026-09-28 10:10:59] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigpres2', 'C:\4c\tasks\task607\logs\06_testForm.log'
[2026-09-28 10:10:59] [INFO] QUIT
[2026-09-28 10:10:59] [INFO] 
[2026-09-28 10:10:59] [INFO] === Fim do Wrapper.prg ===
[2026-09-28 10:10:59] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg):
*==============================================================================
* Formsigpres2.prg - Dialogo de Origem/Destino/Representante de Movimento
* Migrado de: sigpres2.SCX (frmcadastro)
*
* Dialogo FILHO aberto por um form OPERACIONAL pai (legado: "Do Form SigPrEs2
* With ThisForm, ..."), NAO acessivel direto pelo menu do sistema.
*
* Diferenca de arquitetura em relacao ao legado (PILAR 3): o legado recebia
* Lparameters _Chave, pDataSes, poForm e usava "Set DataSession to pDataSes"
* para enxergar cursores locais ja abertos pelo form pai (csTemporario,
* xEestI, TmpOperacao). Neste sistema o sigpres2BO carrega o registro
* sozinho via SQLEXEC (CarregarPorCodigo/CidChaves) - nao ha cursor
* compartilhado entre forms - por isso o 2o parametro do Init deixa de ser
* o DataSessionId do pai e passa a ser a propria chave do movimento
* (CidChaves) que o form pai ja tinha selecionado. Ver cabecalho de
* sigpres2BO.prg para mais contexto sobre o fluxo do dialogo.
*==============================================================================

DEFINE CLASS Formsigpres2 AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

    *-- Propriedades recebidas do form pai (equivalentes a _Chave/pDataSes/poForm do legado)
    this_cChaveRecebida      = ""
    this_cCidChaveRecebida   = ""
    this_oFormPai            = .NULL.

    *===========================================================================
    * Init - Recebe os mesmos 3 parametros posicionais do Init legado
    * (Lparameters _Chave, pDataSes, poForm). Guarda os valores em properties
    * ANTES de chamar DODEFAULT(), pois FormBase.Init() -> InicializarForm()
    * ja precisa deles (this_cTituloForm define o Caption do form).
    *===========================================================================
    PROCEDURE Init(par_cChave, par_cCidChaveMovimento, par_oFormPai)
        IF VARTYPE(par_cChave) = "C"
            THIS.this_cChaveRecebida = par_cChave
            THIS.this_cTituloForm    = par_cChave
        ENDIF

        IF VARTYPE(par_cCidChaveMovimento) = "C"
            THIS.this_cCidChaveRecebida = par_cCidChaveMovimento
        ENDIF

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpres2BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigpres2BO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigpres2.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.AlternarPagina(1)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigpres2:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigpres2.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Estrutura base de Page1 (grid e botoes CRUD
    * entram na Fase seguinte). No legado, a maior parte dos botoes deste
    * grupo (Inserir/Alterar/Procurar/Excluir) fica oculta - o dialogo so
    * mantem a consulta do movimento ja selecionado pelo form pai.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado, herdado do frmcadastro)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption          = "Incluir"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 5
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption          = "Visualizar"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 80
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .Themes           = .F.
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption          = "Alterar"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 155
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .Themes           = .F.
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption          = "Excluir"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 230
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .Themes           = .F.
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption          = "Buscar"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 305
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .Themes           = .F.
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH

        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida (Grupo_Saida no legado) - padrao canonico do
        *-- sistema novo, prevalece sobre o PILAR 1 (regra #10 CLAUDE.md)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption          = "Encerrar"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 5
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid da Lista (Grade no legado) - somente leitura, mostra o
        *-- resumo do movimento (Origem/Destino/Doc.Op/Usuario/Status/EmpO/
        *-- EmpD) que o form pai ja selecionou. ControlSource/Header sao
        *-- (re)definidos em CarregarLista(), apos o RecordSource - regra
        *-- "Grade perde cabecalhos apos RecordSource" (FORMCOR_LICOES).
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top             = 150
            .Left            = 35
            .Width           = 944
            .Height          = 470
            .ColumnCount     = 11
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .GridLineColor   = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle  = 2
            .RowHeight       = 16
            .ScrollBars      = 2
            .Visible         = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- AcertaBotoes (legado): este dialogo NAO permite Incluir/Alterar/
        *-- Excluir/Procurar sobre o registro ja selecionado pelo form pai -
        *-- so "Consultar" (aqui Visualizar) fica ativo, e o grupo encolhe
        *-- para Width=90 (10+80), com Visualizar reposicionado para Left=5.
        *-- Transcricao literal de Pagina.Lista.Grupo_op.AcertaBotoes (regra
        *-- #17 CLAUDE.md - regra de negocio do legado, nao PILAR 1). Aplicado
        *-- DEPOIS de TornarControlesVisiveis (regra "Problema 26" - senao a
        *-- rotina generica reexibe estes botoes).
        WITH loc_oPagina.cnt_4c_Botoes
            .cmd_4c_Incluir.Enabled = .F.
            .cmd_4c_Incluir.Visible = .F.
            .cmd_4c_Alterar.Enabled = .F.
            .cmd_4c_Alterar.Visible = .F.
            .cmd_4c_Excluir.Enabled = .F.
            .cmd_4c_Excluir.Visible = .F.
            .cmd_4c_Buscar.Enabled  = .F.
            .cmd_4c_Buscar.Visible  = .F.
            .cmd_4c_Visualizar.Left = 5
            .Width                  = 90
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (campos entram nas
    * Fases seguintes)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista - regra #11 CLAUDE.md)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container BotoesAcao (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Confirmar (Salva no legado) - transcricao de Grupo_op.Click:
            *-- loGBotaosalva.Salva.Enabled = (Not .pcEscolha = 'CONSULTAR').
            *-- pcEscolha so chega a 'CONSULTAR' neste dialogo (o ramo
            *-- 'PROCURAR' e codigo morto - Inlist(This.Value,1,3,4,5) no
            *-- topo do Click ja intercepta o botao Procurar antes do Do
            *-- Case), entao Confirmar fica sempre desabilitado - transcrito
            *-- em AjustarBotoesPorModo(), nao aqui na criacao.
            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Caption          = "Confirmar"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 5
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH

            *-- Cancelar - unico botao funcional desta barra neste dialogo
            *-- (Cancelar.Click: DoDefault() + If ThisForm.plCancelar Then
            *-- mAtivapagina1 - plCancelar e property herdada do frmcadastro,
            *-- default .T. no Framework)
            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption          = "Encerrar"
                .Picture          = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition  = 13
                .Top              = 5
                .Left             = 80
                .Width            = 75
                .Height           = 75
                .BackColor        = RGB(255, 255, 255)
                .ForeColor        = RGB(90, 90, 90)
                .FontName         = "Comic Sans MS"
                .FontBold         = .T.
                .FontItalic       = .T.
                .FontSize         = 8
                .Themes           = .F.
                .SpecialEffect    = 0
                .MousePointer     = 15
                .WordWrap         = .T.
                .AutoSize         = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- FASE 5/8 - Campos principais (parte 1): bloco de cabecalho do
        *-- movimento (Codigo/Docto/Data/Prazo Entrega/OP/Status/Tb.Desconto)
        *-- e o container Origem/Destino/Representante. Todos os Top sao os
        *-- valores do SCX legado (Pagina.Dados.*) + 29 de compensacao do
        *-- PageFrame.Top=-29 (regra CLAUDE.md - "Compensacao PageFrame.Top").
        *-- Descricao do item (Get_descr), grades (fwgrade1/GradeOperacao),
        *-- imagem (FigJpg) e observacao geral (Container1) ficam para a
        *-- FASE 6/8 (segunda metade dos campos).

        *-- Botao "Entrega" (cmdEntrega no legado) - CommandGroup com 1
        *-- botao que abre "Do Form SigOpEnt" para alterar o Prazo de
        *-- Entrega (comportamento.json). Handler de Click fica para fase
        *-- posterior (chama form ainda nao migrado nesta tarefa).
        loc_oPagina.AddObject("cmg_4c_Entrega", "CommandGroup")
        WITH loc_oPagina.cmg_4c_Entrega
            .Top         = 36
            .Left        = 23
            .Width       = 90
            .Height      = 110
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.cmg_4c_Entrega.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Entrega"
            .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Alterar Prazo de Entrega"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
        ENDWITH

        *-- Codigo (mascarado, MascNum) - somente leitura conforme
        *-- documentado em sigpres2BO.this_cCodigoMascarado
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top       = 60
            .Left      = 131
            .Width     = 61
            .Height    = 23
            .FontBold  = .T.
            .FontSize  = 10
            .MaxLength = 10
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo"
            .Top       = 43
            .Left      = 131
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Docto (Notas)
        loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oPagina.txt_4c_Nota
            .Top       = 107
            .Left      = 193
            .Width     = 66
            .Height    = 23
            .FontBold  = .T.
            .FontSize  = 10
            .MaxLength = 6
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_Nota", "Label")
        WITH loc_oPagina.lbl_4c_Nota
            .Caption   = "Docto"
            .Top       = 91
            .Left      = 193
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Data (Datas)
        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Top       = 60
            .Left      = 201
            .Width     = 80
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = {}
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_Data", "Label")
        WITH loc_oPagina.lbl_4c_Data
            .Caption   = "Data"
            .Top       = 43
            .Left      = 201
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Prazo de Entrega (PrazoEnts)
        loc_oPagina.AddObject("txt_4c_PrazoEntrega", "TextBox")
        WITH loc_oPagina.txt_4c_PrazoEntrega
            .Top       = 60
            .Left      = 289
            .Width     = 80
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = {}
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_PrazoEntrega", "Label")
        WITH loc_oPagina.lbl_4c_PrazoEntrega
            .Caption   = "Prz Entrega"
            .Top       = 43
            .Left      = 289
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- OP (Nops) + botao Subniveis (Do Form SigMvSbn - handler em fase
        *-- posterior, form ainda nao migrado nesta tarefa)
        loc_oPagina.AddObject("txt_4c_NumeroOP", "TextBox")
        WITH loc_oPagina.txt_4c_NumeroOP
            .Top        = 108
            .Left       = 131
            .Width      = 55
            .Height     = 23
            .InputMask  = "999999"
            .ForeColor  = RGB(0, 0, 0)
            .BackColor  = RGB(255, 255, 255)
            .Value      = 0
            .Visible    = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_NumeroOP", "Label")
        WITH loc_oPagina.lbl_4c_NumeroOP
            .Caption   = "OP"
            .Top       = 91
            .Left      = 131
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH loc_oPagina.cmd_4c_SubNiveis
            .Top             = 154
            .Left            = 833
            .Width           = 137
            .Height          = 40
            .Caption         = "   \<Subn" + CHR(237) + "veis    "
            .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
            .PicturePosition = 1
            .ToolTipText     = "Subn" + CHR(237) + "veis"
            .FontName        = "Comic Sans MS"
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        *-- Tabela de Desconto (Tabds) + Status (PStatus)
        loc_oPagina.AddObject("txt_4c_TabelaDesconto", "TextBox")
        WITH loc_oPagina.txt_4c_TabelaDesconto
            .Top       = 108
            .Left      = 269
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_TabelaDesconto", "Label")
        WITH loc_oPagina.lbl_4c_TabelaDesconto
            .Caption   = "Tb. Desconto"
            .Top       = 91
            .Left      = 269
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Status", "TextBox")
        WITH loc_oPagina.txt_4c_Status
            .Top       = 108
            .Left      = 358
            .Width     = 36
            .Height    = 23
            .Alignment = 2
            .MaxLength = 1
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_Status", "Label")
        WITH loc_oPagina.lbl_4c_Status
            .Caption   = "Status"
            .Top       = 91
            .Left      = 358
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Container Origem/Destino/Representante (Origem no legado)
        loc_oPagina.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPagina.cnt_4c_Origem
            .Top         = 202
            .Left        = 27
            .Width       = 582
            .Height      = 164
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(136, 188, 189)
            .SpecialEffect = 0
            .Visible     = .T.

            *-- Titulos de secao
            .AddObject("lbl_4c_Origem", "Label")
            WITH .lbl_4c_Origem
                .Caption   = "Origem"
                .Top       = 5
                .Left      = 5
                .Width     = 100
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Destino", "Label")
            WITH .lbl_4c_Destino
                .Caption   = "Destino"
                .Top       = 59
                .Left      = 5
                .Width     = 100
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Representante", "Label")
            WITH .lbl_4c_Representante
                .Caption   = "Representante"
                .Top       = 113
                .Left      = 5
                .Width     = 120
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            *-- Linhas separadoras
            .AddObject("lin_4c_Line1", "Line")
            WITH .lin_4c_Line1
                .Top         = 20
                .Left        = 5
                .Width       = 340
                .Height      = 0
                .BorderWidth = 2
                .Visible     = .T.
            ENDWITH

            .AddObject("lin_4c_Line2", "Line")
            WITH .lin_4c_Line2
                .Top         = 74
                .Left        = 5
                .Width       = 340
                .Height      = 0
                .BorderWidth = 2
                .Visible     = .T.
            ENDWITH

            .AddObject("lin_4c_Line3", "Line")
            WITH .lin_4c_Line3
                .Top         = 129
                .Left        = 5
                .Width       = 340
                .Height      = 0
                .BorderWidth = 2
                .Visible     = .T.
            ENDWITH

            *-- Linha Origem: Grupo / Conta / Descricao da Conta
            .AddObject("lbl_4c_GrupoOrigem", "Label")
            WITH .lbl_4c_GrupoOrigem
                .Caption   = "Grupo :"
                .Top       = 30
                .Left      = 19
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_GrupoOrigem", "TextBox")
            WITH .txt_4c_GrupoOrigem
                .Top       = 27
                .Left      = 61
                .Width     = 80
                .Height    = 21
                .FontBold  = .T.
                .MaxLength = 10
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_ContaOrigem", "Label")
            WITH .lbl_4c_ContaOrigem
                .Caption   = "Conta :"
                .Top       = 30
                .Left      = 154
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_ContaOrigem", "TextBox")
            WITH .txt_4c_ContaOrigem
                .Top       = 27
                .Left      = 197
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_DescContaOrigem", "TextBox")
            WITH .txt_4c_DescContaOrigem
                .Top       = 27
                .Left      = 277
                .Width     = 267
                .Height    = 21
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Linha Destino: Grupo / Conta / Descricao da Conta
            .AddObject("lbl_4c_GrupoDestino", "Label")
            WITH .lbl_4c_GrupoDestino
                .Caption   = "Grupo :"
                .Top       = 85
                .Left      = 19
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_GrupoDestino", "TextBox")
            WITH .txt_4c_GrupoDestino
                .Top       = 82
                .Left      = 61
                .Width     = 80
                .Height    = 21
                .FontBold  = .T.
                .MaxLength = 10
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_ContaDestino", "Label")
            WITH .lbl_4c_ContaDestino
                .Caption   = "Conta :"
                .Top       = 85
                .Left      = 154
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_ContaDestino", "TextBox")
            WITH .txt_4c_ContaDestino
                .Top       = 82
                .Left      = 196
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_DescContaDestino", "TextBox")
            WITH .txt_4c_DescContaDestino
                .Top       = 82
                .Left      = 277
                .Width     = 267
                .Height    = 21
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Botao "Acessa o Cadastro Desta Conta" (F3) - vinculado a
            *-- Get_ContaD/txt_4c_ContaDestino no legado (comportamento.json).
            *-- Handler de Click fica para fase posterior (Do Form SIGCDCTA,
            *-- form ainda nao migrado nesta tarefa).
            .AddObject("cmd_4c_BtnCadastros", "CommandButton")
            WITH .cmd_4c_BtnCadastros
                .Top           = 79
                .Left          = 549
                .Width         = 27
                .Height        = 31
                .Caption       = ""
                .Picture       = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
                .FontSize      = 7
                .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Linha Representante: Grupo / Conta / Descricao (Get_resps eh
            *-- ReadOnly no legado - representante nao editavel diretamente
            *-- nesta tela, so o grupo do representante)
            .AddObject("lbl_4c_GrupoRepresentante", "Label")
            WITH .lbl_4c_GrupoRepresentante
                .Caption   = "Grupo :"
                .Top       = 138
                .Left      = 19
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_GrupoRepresentante", "TextBox")
            WITH .txt_4c_GrupoRepresentante
                .Top       = 135
                .Left      = 61
                .Width     = 80
                .Height    = 21
                .FontBold  = .T.
                .MaxLength = 10
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_ContaRepresentante", "Label")
            WITH .lbl_4c_ContaRepresentante
                .Caption   = "Conta :"
                .Top       = 138
                .Left      = 154
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Representante", "TextBox")
            WITH .txt_4c_Representante
                .Top       = 135
                .Left      = 195
                .Width     = 80
                .Height    = 21
                .ReadOnly  = .T.
                .MaxLength = 10
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_DescRepresentante", "TextBox")
            WITH .txt_4c_DescRepresentante
                .Top       = 135
                .Left      = 277
                .Width     = 267
                .Height    = 21
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- FASE 6/8 - Campos restantes (parte 2): grid de itens do
        *-- movimento (fwgrade1/xEestI), descricao/observacao do item
        *-- selecionado, imagem do produto (FigJpg), grade de operacoes
        *-- (GradeOperacao/TmpOperacao) e observacao geral do cabecalho
        *-- (Container1/fwmemo1 -> this_cObservacao, ja existente desde a
        *-- Fase 1/2). Todos os Top sao os valores do SCX legado + 29 de
        *-- compensacao do PageFrame.Top=-29 (exceto filhos de containers,
        *-- relativos ao proprio container).

        *-- Grade de Itens (fwgrade1/xEestI no legado) - 10 colunas,
        *-- somente leitura. RecordSource/ControlSource/Headers sao
        *-- (re)definidos em CarregarItensGrid(), apos SQLEXEC popular
        *-- cursor_4c_Itens (regra "Grade perde cabecalhos apos
        *-- RecordSource" - FORMCOR_LICOES/CLAUDE.md). O ramo
        *-- 'gcTpInstalas=V' do legado (troca de headers/formulas) nao foi
        *-- portado - essa global de configuracao nao existe na nova
        *-- arquitetura; o ramo aqui e o Else (default), que e o que bate
        *-- com os headers estaticos do SCX (layout.json).
        loc_oPagina.AddObject("grd_4c_Itens", "Grid")
        WITH loc_oPagina.grd_4c_Itens
            .Top             = 379
            .Left            = 23
            .Width           = 732
            .Height          = 191
            .ColumnCount     = 10
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .GridLines       = 3
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .GridLineColor   = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle  = 2
            .RowHeight       = 16
            .ScrollBars      = 2
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Itens, "AfterRowColChange", THIS, "GridItensAfterRowColChange")

        *-- Descricao do item selecionado (Get_descr -> xEestI.DPros)
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Top       = 591
            .Left      = 23
            .Width     = 454
            .Height    = 23
            .ReadOnly  = .T.
            .MaxLength = 65
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_Descr", "Label")
        WITH loc_oPagina.lbl_4c_Descr
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Top       = 575
            .Left      = 23
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Observacao do item selecionado (Get_obs -> xEestI.OBS)
        loc_oPagina.AddObject("edt_4c_ObservacaoItem", "EditBox")
        WITH loc_oPagina.edt_4c_ObservacaoItem
            .Top       = 590
            .Left      = 496
            .Width     = 454
            .Height    = 24
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_ObservacaoItem", "Label")
        WITH loc_oPagina.lbl_4c_ObservacaoItem
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do item"
            .Top       = 573
            .Left      = 496
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Moldura (Shape4) + Imagem do produto (FigJpg) - ambos ocultos
        *-- ate o usuario selecionar um item na grade (AtualizarItemSelecionado)
        loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPagina.shp_4c_Shape4
            .Top          = 394
            .Left         = 761
            .Width        = 226
            .Height       = 163
            .BorderColor  = RGB(0, 0, 0)
            .Visible      = .F.
        ENDWITH

        loc_oPagina.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPagina.img_4c_FigJpg
            .Top       = 394
            .Left      = 762
            .Width     = 225
            .Height    = 163
            .Stretch   = 1
            .Visible   = .F.
        ENDWITH

        *-- Grade de Operacoes vinculadas (GradeOperacao/TmpOperacao) -
        *-- somente leitura, 1 coluna, fonte Courier New (transcricao
        *-- literal do Column1.FontName do SCX legado).
        loc_oPagina.AddObject("grd_4c_Operacoes", "Grid")
        WITH loc_oPagina.grd_4c_Operacoes
            .Top         = 39
            .Left        = 679
            .Width       = 112
            .Height      = 148
            .ColumnCount = 1
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .GridLines   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Observacao geral do cabecalho do movimento (Container1/fwmemo1
        *-- -> csTemporario.obses no legado = this_cObservacao no BO, ja
        *-- existente desde a Fase 1/2)
        loc_oPagina.AddObject("cnt_4c_Observacao", "Container")
        WITH loc_oPagina.cnt_4c_Observacao
            .Top       = 202
            .Left      = 614
            .Width     = 373
            .Height    = 164
            .BackStyle = 0
            .Visible   = .T.

            .AddObject("lbl_4c_Observacao", "Label")
            WITH .lbl_4c_Observacao
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Top       = 3
                .Left      = 7
                .Width     = 100
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("edt_4c_Observacao", "EditBox")
            WITH .edt_4c_Observacao
                .Top       = 20
                .Left      = 7
                .Width     = 359
                .Height    = 138
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
                .Value     = ""
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Lookups Grupo/Conta Origem e Destino (Origem.Get_grupo/
        *-- Get_conta/Get_ContaD.Valid no legado). fAcessoContab/
        *-- fAcessoContas ja estao portadas em utils/functions.prg e sao
        *-- chamadas diretamente com os proprios TextBox (pCod/pDsc) -
        *-- mesmo padrao ja em producao em FormSigPrEs1.prg
        *-- (ValidarGrupoCodigo/ValidarContaCodigo): a funcao faz o SEEK
        *-- exato e so abre o picker interno (FormBuscaSimples) quando
        *-- nao acha, preenchendo os TextBox sozinha.
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrigem, "LostFocus", THIS, "ValidarGrupoOrigem")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrigem, "LostFocus", THIS, "ValidarContaOrigem")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaDestino, "LostFocus", THIS, "ValidarContaDestino")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista, 1) e Page2 (Dados, 2).
    * Ao voltar para a Lista, recarrega o resumo do movimento (regra "Popular
    * cursor NAO repinta a grade" - FORMCOR_LICOES / CLAUDE.md).
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarLista - Popula grd_4c_Lista com o resumo do movimento (Origem/
    * Destino/Doc.Op/Usuario/Status/EmpO/EmpD) equivalente ao csTemporario do
    * legado (MontaGrades). Esta tela NAO tem Buscar/lote de registros - o
    * form pai ja identificou o movimento (this_cCidChaveRecebida) antes de
    * abrir este dialogo, entao a "lista" e sempre a linha unica desse
    * movimento (por isso o Grupo_op so mantem "Visualizar" ativo).
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cCidChaveRecebida))
                    loc_lResultado = .F.
                ELSE
                    IF ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cCidChave, "")) != ;
                            ALLTRIM(THIS.this_cCidChaveRecebida)
                        THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCidChaveRecebida)
                    ENDIF

                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF

                    CREATE CURSOR cursor_4c_Dados ;
                        (numes N(6,0), datas T, grupoos C(10), contaos C(10), ;
                         grupods C(10), contads C(10), nops N(10,0), usuars C(10), ;
                         pstatus C(1), emps C(3), empds C(3))

                    APPEND BLANK IN cursor_4c_Dados
                    SELECT cursor_4c_Dados
                    REPLACE numes   WITH THIS.this_oBusinessObject.this_nNumero, ;
                            datas   WITH THIS.this_oBusinessObject.this_dData, ;
                            grupoos WITH THIS.this_oBusinessObject.this_cGrupoOrigem, ;
                            contaos WITH THIS.this_oBusinessObject.this_cContaOrigem, ;
                            grupods WITH THIS.this_oBusinessObject.this_cGrupoDestino, ;
                            contads WITH THIS.this_oBusinessObject.this_cContaDestino, ;
                            nops    WITH THIS.this_oBusinessObject.this_nNumeroOP, ;
                            usuars  WITH THIS.this_oBusinessObject.this_cUsuario, ;
                            pstatus WITH THIS.this_oBusinessObject.this_cStatus, ;
                            emps    WITH THIS.this_oBusinessObject.this_cEmpresa, ;
                            empds   WITH THIS.this_oBusinessObject.this_cEmpresaDestino
                    GO TOP IN cursor_4c_Dados

                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.numes"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datas"
                    loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.grupoos"
                    loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contaos"
                    loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.grupods"
                    loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.contads"
                    loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.nops"
                    loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.usuars"
                    loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.pstatus"
                    loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.emps"
                    loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.empds"

                    loc_oGrid.Column1.Width  = 80
                    loc_oGrid.Column2.Width  = 80
                    loc_oGrid.Column3.Width  = 80
                    loc_oGrid.Column4.Width  = 80
                    loc_oGrid.Column5.Width  = 80
                    loc_oGrid.Column6.Width  = 80
                    loc_oGrid.Column7.Width  = 80
                    loc_oGrid.Column8.Width  = 80
                    loc_oGrid.Column9.Width  = 40
                    loc_oGrid.Column9.Alignment = 2
                    loc_oGrid.Column10.Width = 50
                    loc_oGrid.Column11.Width = 50

                    loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption  = "Data"
                    loc_oGrid.Column3.Header1.Caption  = "Grupo"
                    loc_oGrid.Column4.Header1.Caption  = "Origem"
                    loc_oGrid.Column5.Header1.Caption  = "Grupo"
                    loc_oGrid.Column6.Header1.Caption  = "Destino"
                    loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
                    loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column9.Header1.Caption  = "Status"
                    loc_oGrid.Column10.Header1.Caption = "EmpO"
                    loc_oGrid.Column11.Header1.Caption = "EmpD"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Formsigpres2.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Equivalente ao "Consultar" do legado (Grupo_op,
    * Value=2): unico botao ativo do Grupo_op nesta tela - abre a Pagina de
    * Dados em modo somente-leitura para o movimento ja carregado, com o
    * grid de itens e a grade de operacoes (FASE 6/8).
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.BOParaForm()
        THIS.CarregarItensGrid()
        THIS.CarregarOperacoesGrid()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Equivalente ao Grupo_op.Click(Opcao=1) do legado: este
    * dialogo NAO permite Incluir sobre o movimento ja selecionado pelo form
    * pai. AcertaBotoes (ConfigurarPaginaLista) ja deixa cmd_4c_Incluir com
    * Enabled=.F./Visible=.F. - este metodo transcreve o proprio "Inlist(
    * This.Value, 1, 3, 4, 5)" do legado, que apenas volta para a Pagina 1
    * (ThisForm.mAtivaPagina1), sem abrir a Pagina de Dados (regra #17
    * CLAUDE.md - regra de negocio, nao PILAR 1).
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Equivalente ao Grupo_op.Click(Opcao=3) do legado: mesma
    * transcricao do "Inlist(This.Value, 1, 3, 4, 5)" - cmd_4c_Alterar ja esta
    * Enabled=.F./Visible=.F. via AcertaBotoes, este dialogo NAO permite Alterar
    * o movimento.
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Equivalente ao Grupo_op.Click(Opcao=4) do legado: mesma
    * transcricao do "Inlist(This.Value, 1, 3, 4, 5)" - cmd_4c_Excluir ja esta
    * Enabled=.F./Visible=.F. via AcertaBotoes, este dialogo NAO permite Excluir
    * o movimento.
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Equivalente ao Grupo_Saida.Sair do legado: encerra o
    * dialogo e devolve o controle ao form pai.
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Equivalente ao Grupo_op.Click(Opcao=5) do legado (botao
    * "procurar"): mesma transcricao do "Inlist(This.Value, 1, 3, 4, 5)" -
    * cmd_4c_Buscar ja esta Enabled=.F./Visible=.F. via AcertaBotoes (o ramo
    * 'PROCURAR' do Do Case abaixo do Inlist e codigo morto no legado - o
    * proprio Inlist ja intercepta Value=5 antes de chegar la). Este dialogo
    * NAO permite Buscar/Procurar sobre o movimento ja selecionado.
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Equivalente a Grupo_Salva.Salva.Click do legado
    * (=DoDefault() + Thisform.mAtivapagina1): nenhuma gravacao acontece -
    * o Salva.Click do legado nao chama SQL nenhum, so volta para a Lista.
    * Na pratica cmd_4c_Confirmar fica sempre desabilitado (ver
    * AjustarBotoesPorModo), pois pcEscolha so chega a 'CONSULTAR' neste
    * dialogo; o metodo e implementado por completude/fidelidade ao evento
    * do legado, nao porque seja alcancavel pela UI.
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Equivalente a Grupo_Salva.Cancelar.Click do legado
    * (=DoDefault() + If ThisForm.plCancelar Then mAtivapagina1). plCancelar
    * e property herdada do frmcadastro (Framework), nunca reatribuida neste
    * form - default .T. no Framework, por isso a transcricao e incondicional.
    * Unico botao realmente clicavel de cnt_4c_BotoesAcao neste dialogo.
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita cmd_4c_Confirmar/Cancelar de
    * cnt_4c_BotoesAcao. Transcricao de Grupo_op.Click: "loGBotaosalva.Salva.
    * Enabled = (Not .pcEscolha = 'CONSULTAR')". Como pcEscolha so assume
    * 'CONSULTAR' neste dialogo (regra #17 CLAUDE.md - so a formula, sem
    * reinterpretar: o ramo 'PROCURAR' e inalcancavel, ver BtnBuscarClick),
    * a formula colapsa em constante: Confirmar SEMPRE desabilitado.
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .F.
        loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Transcricao de ".mObjEnabled(.Pagina.Dados, .t.)"
    * chamado em Grupo_op.Click antes de exibir a Pagina de Dados. Alcanca os
    * campos interativos (cabecalho do movimento + Grupo/Conta de Origem e
    * Destino, que tem lookup via LostFocus - ValidarGrupoOrigem/
    * ValidarContaOrigem/ValidarContaDestino). txt_4c_Codigo permanece SEMPRE
    * ReadOnly (Get_codigo.When retorna .F. no legado - nao faz parte deste
    * toggle) e os campos Desc*/Representante permanecem ReadOnly (regra
    * propria, ja fixada na criacao dos controles).
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oOrigem, loc_lHabilitar
        loc_lHabilitar = (par_lHabilitar = .T.)
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_oOrigem    = loc_oPg2.cnt_4c_Origem

        loc_oPg2.txt_4c_Nota.Enabled           = loc_lHabilitar
        loc_oPg2.txt_4c_Data.Enabled           = loc_lHabilitar
        loc_oPg2.txt_4c_PrazoEntrega.Enabled   = loc_lHabilitar
        loc_oPg2.txt_4c_NumeroOP.Enabled       = loc_lHabilitar
        loc_oPg2.txt_4c_TabelaDesconto.Enabled = loc_lHabilitar
        loc_oPg2.txt_4c_Status.Enabled         = loc_lHabilitar
        loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Enabled = loc_lHabilitar

        loc_oOrigem.txt_4c_GrupoOrigem.Enabled        = loc_lHabilitar
        loc_oOrigem.txt_4c_ContaOrigem.Enabled        = loc_lHabilitar
        loc_oOrigem.txt_4c_GrupoDestino.Enabled       = loc_lHabilitar
        loc_oOrigem.txt_4c_ContaDestino.Enabled       = loc_lHabilitar
        loc_oOrigem.txt_4c_GrupoRepresentante.Enabled = loc_lHabilitar
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos de Page2 antes de voltar para a Lista
    * (BtnCancelarClick), evitando que dados do movimento anterior fiquem
    * visiveis por um instante ate o proximo CarregarLista/BOParaForm.
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2, loc_oOrigem
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oOrigem = loc_oPg2.cnt_4c_Origem

        loc_oPg2.txt_4c_Codigo.Value         = ""
        loc_oPg2.txt_4c_Nota.Value           = ""
        loc_oPg2.txt_4c_Data.Value           = {}
        loc_oPg2.txt_4c_PrazoEntrega.Value   = {}
        loc_oPg2.txt_4c_NumeroOP.Value       = 0
        loc_oPg2.txt_4c_TabelaDesconto.Value = ""
        loc_oPg2.txt_4c_Status.Value         = ""
        loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Value = ""
        loc_oPg2.txt_4c_Descr.Value           = ""
        loc_oPg2.edt_4c_ObservacaoItem.Value  = ""
        loc_oPg2.img_4c_FigJpg.Picture        = ""
        loc_oPg2.img_4c_FigJpg.Visible        = .F.

        loc_oOrigem.txt_4c_GrupoOrigem.Value        = ""
        loc_oOrigem.txt_4c_ContaOrigem.Value        = ""
        loc_oOrigem.txt_4c_DescContaOrigem.Value    = ""
        loc_oOrigem.txt_4c_GrupoDestino.Value       = ""
        loc_oOrigem.txt_4c_ContaDestino.Value       = ""
        loc_oOrigem.txt_4c_DescContaDestino.Value   = ""
        loc_oOrigem.txt_4c_Representante.Value      = ""
        loc_oOrigem.txt_4c_GrupoRepresentante.Value = ""
        loc_oOrigem.txt_4c_DescRepresentante.Value  = ""
    ENDPROC

    *===========================================================================
    * CarregarItensGrid - Popula grd_4c_Itens a partir de cursor_4c_Itens
    * (sigpres2BO.CarregarItens) e reconfigura RecordSource/ControlSource/
    * Header/Width - regra "Grade perde cabecalhos apos RecordSource"
    * (FORMCOR_LICOES/CLAUDE.md). Ao final, posiciona no 1o item e atualiza
    * Descricao/Observacao/Imagem (AtualizarItemSelecionado).
    *===========================================================================
    PROTECTED PROCEDURE CarregarItensGrid()
        LOCAL loc_lResultado, loc_oGrid, loc_oPagina
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page2

                IF !THIS.this_oBusinessObject.CarregarItens()
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = loc_oPagina.grd_4c_Itens
                    loc_oGrid.ColumnCount = 10
                    loc_oGrid.RecordSource = "cursor_4c_Itens"

                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Itens.cpros"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Itens.qtbxprods"
                    loc_oGrid.Column3.ControlSource  = "cursor_4c_Itens.qtds"
                    loc_oGrid.Column4.ControlSource  = "cursor_4c_Itens.saldo"
                    loc_oGrid.Column5.ControlSource  = "cursor_4c_Itens.qtbaixas"
                    loc_oGrid.Column6.ControlSource  = "cursor_4c_Itens.qtprods"
                    loc_oGrid.Column7.ControlSource  = "cursor_4c_Itens.citens"
                    loc_oGrid.Column8.ControlSource  = "cursor_4c_Itens.tpesos"
                    loc_oGrid.Column9.ControlSource  = "cursor_4c_Itens.descvals"
                    loc_oGrid.Column10.ControlSource = "cursor_4c_Itens.codtams"

                    loc_oGrid.Column1.Width  = 90
                    loc_oGrid.Column2.Width  = 70
                    loc_oGrid.Column3.Width  = 60
                    loc_oGrid.Column4.Width  = 60
                    loc_oGrid.Column5.Width  = 70
                    loc_oGrid.Column6.Width  = 70
                    loc_oGrid.Column7.Width  = 60
                    loc_oGrid.Column8.Width  = 70
                    loc_oGrid.Column9.Width  = 60
                    loc_oGrid.Column10.Width = 60

                    loc_oGrid.Column1.Header1.Caption  = "Produto"
                    loc_oGrid.Column2.Header1.Caption  = "Produzido"
                    loc_oGrid.Column3.Header1.Caption  = "Qtd."
                    loc_oGrid.Column4.Header1.Caption  = "Saldo"
                    loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
                    loc_oGrid.Column6.Header1.Caption  = "Produzir"
                    loc_oGrid.Column7.Header1.Caption  = ""
                    loc_oGrid.Column8.Header1.Caption  = "Peso"
                    loc_oGrid.Column9.Header1.Caption  = "%Ent."
                    loc_oGrid.Column10.Header1.Caption = "Tam."

                    loc_oGrid.FontName = "Tahoma"
                    loc_oGrid.FontSize = 8
                    loc_oGrid.Refresh()

                    IF USED("cursor_4c_Itens")
                        GO TOP IN cursor_4c_Itens
                    ENDIF
                    THIS.AtualizarItemSelecionado()

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "Formsigpres2.CarregarItensGrid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarOperacoesGrid - Popula grd_4c_Operacoes a partir de
    * cursor_4c_Operacoes (sigpres2BO.CarregarOperacoes).
    *===========================================================================
    PROTECTED PROCEDURE CarregarOperacoesGrid()
        LOCAL loc_lResultado, loc_oGrid, loc_oPagina
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page2

                IF !THIS.this_oBusinessObject.CarregarOperacoes()
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = loc_oPagina.grd_4c_Operacoes
                    loc_oGrid.ColumnCount = 1
                    loc_oGrid.RecordSource = "cursor_4c_Operacoes"
                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Operacoes.codigos"
                    loc_oGrid.Column1.Width          = 100
                    loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column1.FontName        = "Courier New"
                    loc_oGrid.Refresh()

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Formsigpres2.CarregarOperacoesGrid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * GridItensAfterRowColChange - Equivalente ao PROCEDURE (AfterRowColChange)
    * de fwgrade1 no legado: ao mudar a linha selecionada, atualiza
    * Descricao/Observacao/Imagem do item corrente.
    *===========================================================================
    PROCEDURE GridItensAfterRowColChange(par_nColIndex)
        THIS.AtualizarItemSelecionado()
    ENDPROC

    *===========================================================================
    * AtualizarItemSelecionado - Le a linha corrente de cursor_4c_Itens e
    * atualiza txt_4c_Descr (xEestI.DPros), edt_4c_ObservacaoItem
    * (xEestI.OBS) e img_4c_FigJpg (CursorQuery SigCdPro por Cpros + STRTOFILE
    * de FigJpgs em arquivo temporario) - transcricao do PROCEDURE do
    * fwgrade1 legado.
    *===========================================================================
    PROTECTED PROCEDURE AtualizarItemSelecionado()
        LOCAL loc_oPagina, loc_cArquivo, loc_cCodigoProduto
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.img_4c_FigJpg.Picture = ""
        loc_oPagina.img_4c_FigJpg.Visible = .F.

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
            loc_oPagina.txt_4c_Descr.Value          = ""
            loc_oPagina.edt_4c_ObservacaoItem.Value = ""
            RETURN
        ENDIF

        SELECT cursor_4c_Itens
        loc_oPagina.txt_4c_Descr.Value          = ALLTRIM(TratarNulo(cursor_4c_Itens.dpros, ""))
        loc_oPagina.edt_4c_ObservacaoItem.Value = TratarNulo(cursor_4c_Itens.obs, "")
        loc_cCodigoProduto                       = ALLTRIM(cursor_4c_Itens.cpros)

        IF !EMPTY(loc_cCodigoProduto)
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT figjpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigoProduto), "cursor_4c_Produto") >= 1
                IF RECCOUNT("cursor_4c_Produto") > 0 AND !EMPTY(TratarNulo(cursor_4c_Produto.figjpgs, ""))
                    loc_cArquivo = SYS(2023) + "\sigpres2_" + SYS(2015) + ".jpg"
                    IF STRTOFILE(cursor_4c_Produto.figjpgs, loc_cArquivo) > 0
                        loc_oPagina.img_4c_FigJpg.Picture = loc_cArquivo
                        loc_oPagina.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGrupoOrigem - Equivalente a Origem.Get_grupo.Valid do legado:
    * chama fAcessoContab (portada em utils/functions.prg), que faz o SEEK
    * exato e so abre o picker interno (FormBuscaSimples) quando nao acha,
    * preenchendo o proprio TextBox. pCta (6o arg) reproduz a checagem de
    * "Grupo Vinculado" contra a Conta de Origem ja digitada.
    *===========================================================================
    PROCEDURE ValidarGrupoOrigem()
        LOCAL loc_oOrigem
        loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem

        IF !EMPTY(ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value))
            = fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value), ;
                loc_oOrigem.txt_4c_GrupoOrigem, "", ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value))
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarContaOrigem - Equivalente a Origem.Get_conta.Valid do legado:
    * fAcessoContas (portada) faz o SEEK exato + picker interno, preenchendo
    * Conta/DescConta. Se o Grupo de Origem estiver vazio, e preenchido com
    * o grupo da conta encontrada (mesmo "If Empty(get_grupo.Value) ...
    * get_grupo.Value = crSigCdCli.Grupos" do legado).
    *===========================================================================
    PROCEDURE ValidarContaOrigem()
        LOCAL loc_oOrigem, loc_cGrupo, loc_cConta, loc_cSQL
        loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
        loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value)
        loc_cConta  = ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value)

        IF EMPTY(loc_cConta)
            loc_oOrigem.txt_4c_DescContaOrigem.Value = ""
            RETURN
        ENDIF

        IF fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cConta, ;
                loc_oOrigem.txt_4c_ContaOrigem, loc_oOrigem.txt_4c_DescContaOrigem)
            IF EMPTY(loc_cGrupo)
                loc_cSQL = "SELECT grupos FROM SigCdCli WHERE iclis = " + ;
                    EscaparSQL(ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value))

                IF USED("cursor_4c_GrupoConta")
                    USE IN cursor_4c_GrupoConta
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoConta") >= 1 AND RECCOUNT("cursor_4c_GrupoConta") > 0
                    loc_oOrigem.txt_4c_GrupoOrigem.Value = ALLTRIM(TratarNulo(cursor_4c_GrupoConta.grupos, ""))
                ENDIF
                IF USED("cursor_4c_GrupoConta")
                    USE IN cursor_4c_GrupoConta
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oOrigem.txt_4c_ContaOrigem.Value     = ""
            loc_oOrigem.txt_4c_DescContaOrigem.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarContaDestino - Equivalente a Origem.Get_ContaD.Valid do legado:
    * fAcessoContas (portada) faz o SEEK exato + picker interno, preenchendo
    * Conta/DescConta de Destino. NOTA: o fonte legado deste handler
    * referencia por engano os objetos da Conta de Origem (Get_Conta/
    * Get_DConta, provavelmente copy-paste de Get_conta.Valid sem ajustar
    * os "This.Parent.Get_*") - aqui a gravacao e feita nos proprios campos
    * de Destino (comportamento correto/simetrico), nao no defeito herdado.
    *===========================================================================
    PROCEDURE ValidarContaDestino()
        LOCAL loc_oOrigem, loc_cGrupo, loc_cConta
        loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
        loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value)
        loc_cConta  = ALLTRIM(loc_oOrigem.txt_4c_ContaDestino.Value)

        IF EMPTY(loc_cConta)
            loc_oOrigem.txt_4c_DescContaDestino.Value = ""
            RETURN
        ENDIF

        IF fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cConta, ;
                loc_oOrigem.txt_4c_ContaDestino, loc_oOrigem.txt_4c_DescContaDestino)
            * Acesso liberado - Conta/DescConta ja preenchidos pela funcao
        ELSE
            MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oOrigem.txt_4c_ContaDestino.Value     = ""
            loc_oOrigem.txt_4c_DescContaDestino.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCadastrosClick - Equivalente a Origem.btnCadastros.Click do legado
    * ("Acessa o Cadastro Desta Conta"): abre o cadastro de Contas Correntes
    * (FormCTA, migrado de SIGCDCTA) quando ha uma Conta de Destino
    * preenchida. FormCTA nao expõe parametro de filtro/valor inicial (API
    * atual so tem Init() sem argumentos) - abre a lista geral, sem o
    * preenchimento automatico que o "With ... 0, [SIGCDCTA], valor, ..."
    * fazia no legado.
    *===========================================================================
    PROCEDURE BtnCadastrosClick()
        LOCAL loc_oOrigem, loc_oForm
        loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem

        IF EMPTY(ALLTRIM(loc_oOrigem.txt_4c_ContaDestino.Value))
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormCTA")
        CATCH TO loException
            MostrarErro("Erro ao abrir cadastro de contas:" + CHR(13) + loException.Message, "Formsigpres2.BtnCadastrosClick")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do Form para o Business Object.
    * FASE 6/8: acrescenta a observacao geral do cabecalho (cnt_4c_Observacao.
    * edt_4c_Observacao -> this_cObservacao). Campos de descricao
    * (txt_4c_DescConta*) e os campos de item/grades (FASE 6/8, cursores
    * cursor_4c_Itens/cursor_4c_Operacoes) nao tem property escalar
    * equivalente no BO e ficam de fora (ver cabecalho de sigpres2BO.prg).
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oOrigem
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oOrigem = loc_oPg2.cnt_4c_Origem

        WITH THIS.this_oBusinessObject
            .this_cCodigoMascarado    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            .this_cDocumento          = ALLTRIM(loc_oPg2.txt_4c_Nota.Value)
            .this_dData               = loc_oPg2.txt_4c_Data.Value
            .this_dPrazoEntrega       = loc_oPg2.txt_4c_PrazoEntrega.Value
            .this_nNumeroOP           = loc_oPg2.txt_4c_NumeroOP.Value
            .this_cTabelaDesconto     = ALLTRIM(loc_oPg2.txt_4c_TabelaDesconto.Value)
            .this_cStatus             = ALLTRIM(loc_oPg2.txt_4c_Status.Value)
            .this_cObservacao         = loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Value

            .this_cGrupoOrigem        = ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value)
            .this_cContaOrigem        = ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value)
            .this_cGrupoDestino       = ALLTRIM(loc_oOrigem.txt_4c_GrupoDestino.Value)
            .this_cContaDestino       = ALLTRIM(loc_oOrigem.txt_4c_ContaDestino.Value)
            .this_cRepresentante      = ALLTRIM(loc_oOrigem.txt_4c_Representante.Value)
            .this_cGrupoRepresentante = ALLTRIM(loc_oOrigem.txt_4c_GrupoRepresentante.Value)
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do Business Object para o Form.
    * FASE 6/8: mesmos campos wireados em FormParaBO (ver comentario acima).
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oOrigem
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oOrigem = loc_oPg2.cnt_4c_Origem

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Codigo.Value           = .this_cCodigoMascarado
            loc_oPg2.txt_4c_Nota.Value             = .this_cDocumento
            loc_oPg2.txt_4c_Data.Value              = .this_dData
            loc_oPg2.txt_4c_PrazoEntrega.Value     = .this_dPrazoEntrega
            loc_oPg2.txt_4c_NumeroOP.Value          = .this_nNumeroOP
            loc_oPg2.txt_4c_TabelaDesconto.Value    = .this_cTabelaDesconto
            loc_oPg2.txt_4c_Status.Value             = .this_cStatus
            loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Value = .this_cObservacao

            loc_oOrigem.txt_4c_GrupoOrigem.Value        = .this_cGrupoOrigem
            loc_oOrigem.txt_4c_ContaOrigem.Value        = .this_cContaOrigem
            loc_oOrigem.txt_4c_GrupoDestino.Value       = .this_cGrupoDestino
            loc_oOrigem.txt_4c_ContaDestino.Value       = .this_cContaDestino
            loc_oOrigem.txt_4c_Representante.Value      = .this_cRepresentante
            loc_oOrigem.txt_4c_GrupoRepresentante.Value = .this_cGrupoRepresentante
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis
    * recursivamente (Pages de PageFrames E Controls de Containers)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * Destroy - Libera referencia do form pai antes do encerramento padrao
    * (FormBase.Destroy cuida do this_oBusinessObject e da restauracao do menu)
    *===========================================================================
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* SIGPRES2BO.PRG
* Business Object para o dialogo de Origem/Destino/Representante de Movimento
* (SIGPRES2 - dialogo filho aberto por um form OPERACIONAL pai via
*  "Do Form SigPrEs2 With ThisForm, ...", NAO acessivel direto pelo menu)
*
* Tabela Principal : SigMvCab (cabecalho de movimentacao)
* Chave Real (PK)  : CidChaves    CHAR(20)
* Chave Posicional : EmpDopNums   CHAR(29) = Emps CHAR(3) + Dopes CHAR(20) + Str(Numes, 6)
*                     (NUNCA usar ALLTRIM nas partes - ver CLAUDE.md regra #42)
*
* Logica do legado: o form pai ja populou um cursor local (csTemporario) com o
* registro (ou lote de registros) de SigMvCab a editar; o SIGPRES2 apenas edita
* os campos de cabecalho abaixo (Origem/Destino/Representante/Status/Prazo) e
* delega o commit ao TableUpdate do buffer do framework (Grupo_Salva.Salva.Click
* so chama DoDefault() + mAtivapagina1 - nao ha INSERT/UPDATE/DELETE proprios no
* codigo fonte do SIGPRES2). Os campos de item (grid fwgrade1/xEestI, vindos de
* SigMvItn/SigMvIts) e a grade de operacoes (TmpOperacao/SigMvPec) sao
* somente-leitura e pertencem a um cursor de detalhe, nao a properties escalares
* deste BO.
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento (SigMvCab)
    this_cEmpresa            = ""   && Emps        CHAR(3)  - Empresa (parte da chave posicional)
    this_cTipoDocumento      = ""   && Dopes        CHAR(20) - Tipo de documento (parte da chave posicional)
    this_nNumero             = 0    && Numes        NUMERIC(6,0) - Numero do documento (parte da chave posicional)
    this_cEmpresaDestino     = ""   && Empds        CHAR(3)  - Empresa de destino (grid Lista, coluna "EmpD")
    this_cChaveMovimento     = ""   && EmpDopNums   CHAR(29) - Chave posicional (Emps+Dopes+Str(Numes,6))
    this_cCidChave           = ""   && CidChaves    CHAR(20) - Chave primaria real da tabela

    *-- Origem / Destino / Representante (container "Origem" da Pagina Dados)
    this_cGrupoOrigem        = ""   && Grupoos      CHAR(10)
    this_cContaOrigem        = ""   && Contaos      CHAR(10)
    this_cGrupoDestino       = ""   && Grupods      CHAR(10)
    this_cContaDestino       = ""   && Contads      CHAR(10)
    this_cRepresentante      = ""   && Vends        CHAR(10)
    this_cGrupoRepresentante = ""   && Grvends      CHAR(10)

    *-- Demais campos de cabecalho editaveis na Pagina Dados
    this_cTabelaDesconto     = ""   && Tabds        CHAR(10)
    this_cStatus             = ""   && PStatus      CHAR(1)
    this_cUsuario            = ""   && Usuars       CHAR(10) - usuario do movimento (grid Lista, coluna "Usuario")
    this_nNumeroOP           = 0    && Nops         NUMERIC(10,0)
    this_dPrazoEntrega       = {}   && PrazoEnts    DATETIME
    this_cCodigoMascarado    = ""   && MascNum      CHAR(10) - exibicao formatada (Get_codigo), somente leitura
    this_cDocumento          = ""   && Notas        CHAR(6)  - numero do documento/nota (Get_nota)
    this_dData               = {}   && Datas        DATETIME
    this_cObservacao         = ""   && Obses        TEXT (memo)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela (CidChaves), usada por
    * RegistrarAuditoria() e pela clausula WHERE de Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigMvCab que este dialogo edita
    * (Origem/Destino/Representante/cabecalho) para as properties do BO.
    * SELECT (par_cAliasCursor) ANTES de acessar os campos (regra #8 CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpresa            = TratarNulo(emps, "")
                THIS.this_cTipoDocumento      = TratarNulo(dopes, "")
                THIS.this_nNumero             = TratarNulo(numes, 0)
                THIS.this_cEmpresaDestino     = TratarNulo(empds, "")
                THIS.this_cChaveMovimento     = TratarNulo(empdopnums, "")
                THIS.this_cCidChave           = TratarNulo(cidchaves, "")

                THIS.this_cGrupoOrigem        = TratarNulo(grupoos, "")
                THIS.this_cContaOrigem        = TratarNulo(contaos, "")
                THIS.this_cGrupoDestino       = TratarNulo(grupods, "")
                THIS.this_cContaDestino       = TratarNulo(contads, "")
                THIS.this_cRepresentante      = TratarNulo(vends, "")
                THIS.this_cGrupoRepresentante = TratarNulo(grvends, "")

                THIS.this_cTabelaDesconto     = TratarNulo(tabds, "")
                THIS.this_cStatus             = TratarNulo(pstatus, "")
                THIS.this_cUsuario            = TratarNulo(usuars, "")
                THIS.this_nNumeroOP           = TratarNulo(nops, 0)
                THIS.this_dPrazoEntrega       = TratarNulo(prazoents, {})
                THIS.this_cCodigoMascarado    = TratarNulo(mascnum, "")
                THIS.this_cDocumento          = TratarNulo(notas, "")
                THIS.this_dData               = TratarNulo(datas, {})
                THIS.this_cObservacao         = TratarNulo(obses, "")

                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega o movimento pela chave real (CidChaves).
    * SELECT * (como no legado, que abre o registro inteiro via csTemporario)
    * para que CarregarDoCursor sempre encontre as colunas que le.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigMvCab WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigpres2BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE parcial em SigMvCab, restrito aos campos que este
    * dialogo de fato edita (Origem/Destino/Representante/Status/Prazo/
    * Documento/Data/Observacao). Equivalente ao TableUpdate() do buffer
    * otimista do framework legado: Grupo_Salva.Salva.Click do SIGPRES2 nao
    * tem SQL proprio (so DoDefault() + mAtivapagina1 - ver cabecalho do
    * arquivo), mas o buffer so envia ao SQL Server as colunas realmente
    * alteradas na tela - por isso o UPDATE aqui cobre so essas colunas,
    * nunca a linha inteira (colunas de identificacao como Emps/Dopes/Numes/
    * EmpDopNums/MascNum sao somente leitura nesta tela e ficam de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " grupoos = "   + EscaparSQL(LEFT(THIS.this_cGrupoOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = "   + EscaparSQL(LEFT(THIS.this_cContaOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = "   + EscaparSQL(LEFT(THIS.this_cGrupoDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " contads = "   + EscaparSQL(LEFT(THIS.this_cContaDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " vends = "     + EscaparSQL(LEFT(THIS.this_cRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = "   + EscaparSQL(LEFT(THIS.this_cGrupoRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = "     + EscaparSQL(LEFT(THIS.this_cTabelaDesconto, 10)) + ","
            loc_cSQL = loc_cSQL + " pstatus = "   + EscaparSQL(LEFT(THIS.this_cStatus, 1)) + ","
            loc_cSQL = loc_cSQL + " nops = "      + FormatarNumeroSQL(THIS.this_nNumeroOP, 0) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoEntrega) + ","
            loc_cSQL = loc_cSQL + " notas = "     + EscaparSQL(LEFT(THIS.this_cDocumento, 6)) + ","
            loc_cSQL = loc_cSQL + " datas = "     + FormatarDataSQL(THIS.this_dData) + ","
            loc_cSQL = loc_cSQL + " obses = "     + EscaparSQL(THIS.this_cObservacao)
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir() e ExecutarExclusao() permanecem com o comportamento herdado
    * de BusinessBase (recusar a operacao): no fonte legado do SIGPRES2 nao
    * ha Append/Delete contra SigMvCab - o dialogo so edita um registro que
    * o form pai ja havia populado em csTemporario antes de abri-lo (ver
    * cabecalho do arquivo). Este BO nunca cria nem exclui movimentos.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega os itens do movimento (grid fwgrade1/xEestI do
    * legado) em cursor_4c_Itens. Fonte: SigMvItn (a) LEFT JOIN SigMvIts (b)
    * por EmpDopNums+Cpros+CItens (mesma juncao do PROCEDURE Init legado -
    * regra #42 CLAUDE.md, nunca ALLTRIM na chave posicional). Saldo =
    * Qtds - QtBaixas ja calculado no SELECT (equivalente ao
    * Column4.ControlSource legado 'xEestI.Qtds - xEestI.QtBaixas', ramo
    * Else de montagrades - o ramo If(gcTpInstalas='V') nao foi portado:
    * essa global de configuracao nao existe na nova arquitetura, e o ramo
    * Else e o que bate com os headers estaticos do SCX/layout.json).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.qtds, a.qtprods," + ;
                " a.qtbaixas, a.qtbxprods, a.citens, a.tpesos," + ;
                " a.descvals, ISNULL(b.codtams, '') AS codtams," + ;
                " a.obs, (a.qtds - a.qtbaixas) AS saldo" + ;
                " FROM sigmvitn a" + ;
                " LEFT JOIN sigmvits b ON b.empdopnums = a.empdopnums" + ;
                " AND b.cpros = a.cpros AND b.citens = a.citens" + ;
                " WHERE a.empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY a.citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigpres2BO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega os codigos de operacao vinculados ao
    * movimento (grid GradeOperacao/TmpOperacao do legado). Fonte: SigMvPec
    * filtrado por EmpDopNums (mesmo filtro do legado
    * CursorQuery('SigMvPec', 'TmpOperacao', 'EmpDopNums', pEdn)).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos FROM sigmvpec" + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "sigpres2BO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


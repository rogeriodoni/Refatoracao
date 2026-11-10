# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-07 02:20:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-07 02:20:57] [INFO] Config FPW: (nao fornecido)
[2026-11-07 02:20:58] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-07 02:21:00] [INFO] Timeout: 300 segundos
[2026-11-07 02:21:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2nawujgn.prg
[2026-11-07 02:21:03] [INFO] Conteudo do wrapper:
[2026-11-07 02:21:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpImg', 'C:\4c\tasks\task748\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpImg', 'C:\4c\tasks\task748\logs\06_testForm.log'
QUIT

[2026-11-07 02:21:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2nawujgn.prg
[2026-11-07 02:21:05] [INFO] VFP output esperado em: C:\4c\tasks\task748\vfp_output.txt
[2026-11-07 02:21:06] [INFO] Executando Visual FoxPro 9...
[2026-11-07 02:21:08] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2nawujgn.prg
[2026-11-07 02:21:09] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2nawujgn.prg
[2026-11-07 02:21:10] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpImg
Inicio: 07/11/2026 02:21:12

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
OK - Objeto criado com sucesso
     Tipo: O
     Classe: Formsigopimg

[ETAPA 3] Mostrando formulario (nao-modal)...
ERRO - Excecao ao mostrar formulario:
     Mensagem: Property WINDOWTYPE is read-only.

=== RESULTADO DO TESTE ===
Fim: 07/11/2026 02:22:04
Duracao: 52 segundos
Return Code: 2
Status: ERRO AO MOSTRAR FORM

===========================
[2026-11-07 02:22:05] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-07 02:22:06] [INFO] VFP9 finalizado em 58.1396616 segundos
[2026-11-07 02:22:07] [INFO] Exit Code: 
[2026-11-07 02:22:08] [INFO] 
[2026-11-07 02:22:09] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-07 02:22:10] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2nawujgn.prg
[2026-11-07 02:22:12] [INFO] 
[2026-11-07 02:22:13] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-07 02:22:14] [INFO] * Auto-generated wrapper for parameters
[2026-11-07 02:22:15] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-07 02:22:16] [INFO] * Parameters: 'FormSigOpImg', 'C:\4c\tasks\task748\logs\06_testForm.log'
[2026-11-07 02:22:17] [INFO] 
[2026-11-07 02:22:19] [INFO] * Anti-dialog protections for unattended execution
[2026-11-07 02:22:20] [INFO] SET SAFETY OFF
[2026-11-07 02:22:21] [INFO] SET RESOURCE OFF
[2026-11-07 02:22:22] [INFO] SET TALK OFF
[2026-11-07 02:22:23] [INFO] SET NOTIFY OFF
[2026-11-07 02:22:25] [INFO] SYS(2335, 0)
[2026-11-07 02:22:26] [INFO] 
[2026-11-07 02:22:27] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpImg', 'C:\4c\tasks\task748\logs\06_testForm.log'
[2026-11-07 02:22:28] [INFO] QUIT
[2026-11-07 02:22:29] [INFO] 
[2026-11-07 02:22:30] [INFO] === Fim do Wrapper.prg ===
[2026-11-07 02:22:31] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpImg.prg):
*==============================================================================
* FormSigOpImg.prg - Captura de Imagens de Produtos
* Origem: SIGOPIMG.SCX (Framework legado Fortyus)
* Herda de: FormBase
* Tipo: OPERACIONAL (form FLAT - legado sem PageFrame/abas; selecao de
*       produtos por filtro de periodo/grupo/produto/linha/situacao de
*       imagem + captura/visualizacao/exclusao da imagem do produto)
*       Aberto direto pelo menu (sem form pai) via AbrirFormSigOpImg
*==============================================================================

DEFINE CLASS FormSigOpImg AS FormBase

    DataSession  = 2
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    Caption      = "Captura de Imagens"
    FontName     = "Tahoma"
    FontSize     = 8

    *-- CorPadrao do legado: BackColor original do Header1 da 1a coluna,
    *-- usado para "despintar" os demais headers ao reordenar a grade
    this_nCorPadrao = 0

    *-- Guardas de reentrancia dos lookups de filtro (FormBuscaAuxiliar eh
    *-- MODAL e tira o foco do TextBox, o que redispara o proprio LostFocus
    *-- - regra #37/#47)
    this_lEmLookupGrupo   = .F.
    this_lEmLookupProduto = .F.
    this_lEmLookupLinha   = .F.

    *-- Guarda de "valor nao mudou" dos 6 handlers de LostFocus de lookup:
    *-- no legado o Valid so dispara quando o campo MUDA, mas LostFocus
    *-- dispara SEMPRE - sem isto, sair do campo sem digitar nada reabre a
    *-- consulta/picker de novo a cada Tab
    this_cUltimoValidarGrupoFiltroLostFocusValidado       = ""
    this_cUltimoValidarDescGrupoFiltroLostFocusValidado   = ""
    this_cUltimoValidarProdutoFiltroLostFocusValidado     = ""
    this_cUltimoValidarDescProdutoFiltroLostFocusValidado = ""
    this_cUltimoValidarLinhaFiltroLostFocusValidado       = ""
    this_cUltimoValidarDescLinhaFiltroLostFocusValidado   = ""

    *-- Estado para habilitar obj_4c_CmdgFigura.Buttons(3) (Zoom) - so fica
    *-- habilitado em modo RESULTADO (par_lModoFiltro = .F.) E com o produto
    *-- corrente tendo imagem (btnZoom.When legado: Not Empty(FigJpgs))
    this_lModoFiltroAtual   = .T.
    this_lProdutoTemImagem  = .F.

    *==========================================================================
    * Init - Inicializacao do formulario
    *==========================================================================
    PROCEDURE Init()
        THIS.Caption = "Captura de Imagens"
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o SigOpImgBO e cria a estrutura visual base
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Equivalente ao Load legado (Create Cursor csProdutos) -
            *-- precisa existir ANTES do BO e da grade
            THIS.ConfigurarCursorProdutos()

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpImgBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Defaults do Init legado (getDtIni.Value=Date()-1,
                *-- getDtFin.Value=Date(), optImagem.Value=1 "Sem Imagem")
                THIS.this_oBusinessObject.this_dDataIni    = DATE() - 1
                THIS.this_oBusinessObject.this_dDataFin    = DATE()
                THIS.this_oBusinessObject.this_nTipoImagem = 1

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Equivalente a "ThisForm.AcertaForm(.t.)" no fim do Init legado
                THIS.AjustarControlesPorModo(.T.)

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigOpImgBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestra a criacao da estrutura visual base.
    * Form FLAT (legado SIGOPIMG nao tem PageFrame/abas): cabecalho, moldura
    * + area de imagem, container dos botoes de periodo/encerramento,
    * container do grupo cmdgFigura e a grade de produtos.
    *
    * ORDEM = z-order do SCX legado: Shape3 eh o PRIMEIRO objeto da arvore
    * (antes de cntSombra) e ImgFigJpg desenha por cima dele; o container
    * transparente cnt_4c_BotoesAcao encosta 4px no Shape (Left 220..224
    * contra 23..224) e por isso vem DEPOIS da moldura. Criar o Shape por
    * ultimo o deixaria por cima do container, cobrindo esses 4px (regra #30).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarImagem()
        THIS.ConfigurarContainerBotoes()
        THIS.ConfigurarContainerBotoesAcao()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarFiltrosLinhaImagem()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBusca()
    ENDPROC

    *==========================================================================
    * ConfigurarCursorProdutos - Cria cursor_4c_Produtos (csProdutos legado),
    * cursor local que alimenta a grade. Estrutura e indices identicos ao
    * Create Cursor + 6 Index On do PROCEDURE Load legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCursorProdutos()
        LOCAL loc_cNullAnt

        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        *-- SQL Server devolve NULL em ifors/reffs/cgrus/linhas (FKs
        *-- opcionais); sem SET NULL ON, esses campos C() nascem NOT NULL
        *-- e o APPEND FROM DBF (em CarregarLista) estoura "Field XXX does
        *-- not accept null values"
        loc_cNullAnt = SET("NULL")
        SET NULL ON

        CREATE CURSOR cursor_4c_Produtos ( ;
            dtfilms D NULL, ;
            dtincs  D NULL, ;
            datas   D NULL, ;
            cpros   C(14), ;
            dpros   C(40), ;
            ifors   C(10), ;
            reffs   C(40), ;
            cgrus   C(3), ;
            linhas  C(10), ;
            figjpgs M NULL)

        INDEX ON cpros          TAG cpros
        INDEX ON dpros + cpros  TAG dpros
        INDEX ON ifors + cpros  TAG ifors
        INDEX ON reffs + cpros  TAG reffs
        INDEX ON cgrus + cpros  TAG cgrus
        INDEX ON linhas + cpros TAG linhas

        IF loc_cNullAnt = "OFF"
            SET NULL OFF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
    * Original: cntSombra Top=0, Left=0, Width=1100, Height=80,
    *           BackColor=RGB(100,100,100) (framework.vcx cntSombra)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
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
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoes - Container flutuante sobre a faixa do
    * cabecalho (BackStyle=0) com cmd_4c_Processar (cmdSelecionar legado) e
    * cmg_4c_Limpar (cmdBtnForm legado - "Limpar Sel." / "Encerrar").
    * Original: cmdSelecionar Top=3, Left=775, W=75, H=75 +
    *           cmdBtnForm     Top=-2, Left=845, W=160, H=85
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top         = 0
                .Left        = 770
                .Width       = 235
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- cmd_4c_Processar (cmdSelecionar legado) - Left relativo = 775-770
            THIS.cnt_4c_Botoes.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cnt_4c_Botoes.cmd_4c_Processar
                .Top             = 3
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "Processar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

            *-- cmg_4c_Limpar (cmdBtnForm legado) - Left relativo = 845-770
            THIS.cnt_4c_Botoes.AddObject("cmg_4c_Limpar", "CommandGroup")
            WITH THIS.cnt_4c_Botoes.cmg_4c_Limpar
                .Top         = -2
                .Left        = 75
                .Width       = 160
                .Height      = 85
                .ButtonCount = 2
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
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .Caption    = "\<Limpar Sel."
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top        = 5
                    .Left       = 80
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel     = .T.
                    .Caption    = "Encerrar"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.cnt_4c_Botoes.cmg_4c_Limpar, "Click", THIS, "CmgLimparClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoesAcao - Container que hospeda o grupo
    * cmdgFigura do legado (Imagem / Branco / Zoom), ao lado da moldura da
    * imagem do produto. Os tres botoes operam o campo FigJpgs do produto
    * corrente e sao montados junto com os handlers de imagem.
    * Original: cmdgFigura Top=492, Left=224, W=235, H=85
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoesAcao()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH THIS.cnt_4c_BotoesAcao
                .Top         = 485
                .Left        = 220
                .Width       = 245
                .Height      = 90
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- obj_4c_CmdgFigura (cmdgFigura legado) - Imagem / Branco / Zoom
            *-- Left relativo = 224-220. Picture/Caption/ordem transcritos do
            *-- dump do SCX (tasks\task748\SigOpImg_form_codigo_fonte.txt:778-823).
            THIS.cnt_4c_BotoesAcao.AddObject("obj_4c_CmdgFigura", "CommandGroup")
            WITH THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura
                .Top         = 7
                .Left        = 4
                .Width       = 235
                .Height      = 85
                .ButtonCount = 3
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
                    .Picture    = gc_4c_CaminhoIcones + "geral_selo_60.jpg"
                    .Caption    = "Imagem"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top        = 5
                    .Left       = 80
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .Picture    = gc_4c_CaminhoIcones + "geral_informacao_60.jpg"
                    .Caption    = "\<Branco"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
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
                    .Picture    = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
                    .Caption    = "\<Zoom"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                    *-- btnZoom.When legado (Return Not Empty(csProdutos.FigJpgs))
                    *-- - reavaliado em CarregarImagemProduto a cada troca de
                    *-- linha na grade, nao ha When real em CommandGroup.
                    .Enabled    = .F.
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Campos principais do filtro de selecao (PARTE 1):
    * Periodo de Inclusao (getDtIni/getDtFin), Grupo (getGrupo/getDGrupo) e
    * Produto (getCProsF/getDProsF), com os respectivos lookups. Linha
    * (getLin/getDLin) e Situacao de Imagem (optImagem) ficam em
    * ConfigurarFiltrosLinhaImagem() (PARTE 2).
    *
    * Posicoes/Captions transcritas literalmente do dump do SCX legado
    * (tasks\task748\layout.json) - direto em THIS, sem container, porque
    * o legado tambem os cria direto na SIGOPIMG (form FLAT, sem Pagina).
    *
    * Valores iniciais vem das properties do BO (ja definidas no
    * InicializarForm antes deste metodo rodar); a volta (TextBox -> BO) eh
    * feita por FormParaBO(), chamado no inicio de BtnProcessarClick.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_Periodo", "Label")
            WITH THIS.lbl_4c_Periodo
                .Top       = 94
                .Left      = 189
                .Width     = 140
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Per" + CHR(237) + "odo de Inclus" + CHR(227) + "o :"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DataIni", "TextBox")
            WITH THIS.txt_4c_DataIni
                .Top      = 90
                .Left     = 294
                .Width    = 90
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = NVL(THIS.this_oBusinessObject.this_dDataIni, {})
                .Visible  = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_PeriodoA", "Label")
            WITH THIS.lbl_4c_PeriodoA
                .Top       = 94
                .Left      = 380
                .Width     = 15
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "a"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DataFim", "TextBox")
            WITH THIS.txt_4c_DataFim
                .Top      = 90
                .Left     = 393
                .Width    = 90
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = NVL(THIS.this_oBusinessObject.this_dDataFin, {})
                .Visible  = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Grupo", "Label")
            WITH THIS.lbl_4c_Grupo
                .Top       = 118
                .Left      = 254
                .Width     = 38
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo :"
                .Visible   = .T.
            ENDWITH

            *-- cgrus char(3) - SigCdGrp
            THIS.AddObject("txt_4c_Grupo", "TextBox")
            WITH THIS.txt_4c_Grupo
                .Top       = 115
                .Left      = 294
                .Width     = 31
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Value     = NVL(THIS.this_oBusinessObject.this_cGrupoFiltro, "")
                .Visible   = .T.
            ENDWITH

            *-- dgrus char(20) - SigCdGrp
            THIS.AddObject("txt_4c_DescGrupo", "TextBox")
            WITH THIS.txt_4c_DescGrupo
                .Top       = 115
                .Left      = 327
                .Width     = 181
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 20
                .Value     = NVL(THIS.this_oBusinessObject.this_cDescGrupoFiltro, "")
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Produto", "Label")
            WITH THIS.lbl_4c_Produto
                .Top       = 143
                .Left      = 245
                .Width     = 47
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Produto :"
                .Visible   = .T.
            ENDWITH

            *-- cpros char(14) - SigCdPro
            THIS.AddObject("txt_4c_Produto", "TextBox")
            WITH THIS.txt_4c_Produto
                .Top       = 140
                .Left      = 294
                .Width     = 108
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 14
                .Value     = NVL(THIS.this_oBusinessObject.this_cProdutoFiltro, "")
                .Visible   = .T.
            ENDWITH

            *-- dpros char(65) - SigCdPro
            THIS.AddObject("txt_4c_DescProduto", "TextBox")
            WITH THIS.txt_4c_DescProduto
                .Top       = 140
                .Left      = 404
                .Width     = 332
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 65
                .Value     = NVL(THIS.this_oBusinessObject.this_cDescProdutoFiltro, "")
                .Visible   = .T.
            ENDWITH

            *-- Lookups (equivalentes ao Valid legado de getGrupo/getDGrupo e
            *-- getCProsF/getDProsF) - vao em LostFocus, nunca em KeyPress sem
            *-- testar a tecla (regra #47)
            BINDEVENT(THIS.txt_4c_Grupo,       "LostFocus", THIS, "ValidarGrupoFiltroLostFocus")
            BINDEVENT(THIS.txt_4c_DescGrupo,   "LostFocus", THIS, "ValidarDescGrupoFiltroLostFocus")
            BINDEVENT(THIS.txt_4c_Produto,     "LostFocus", THIS, "ValidarProdutoFiltroLostFocus")
            BINDEVENT(THIS.txt_4c_DescProduto, "LostFocus", THIS, "ValidarDescProdutoFiltroLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFiltrosLinhaImagem - Ultimos campos do filtro de selecao
    * (PARTE 2): Linha (getLin/getDLin) e Situacao de Imagem (optImagem).
    * Posicoes/Captions transcritas literalmente do dump do SCX legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltrosLinhaImagem()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_Linha", "Label")
            WITH THIS.lbl_4c_Linha
                .Top       = 168
                .Left      = 258
                .Width     = 34
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Linha :"
                .Visible   = .T.
            ENDWITH

            *-- linhas char(10) - SigCdLin
            THIS.AddObject("txt_4c_Linha", "TextBox")
            WITH THIS.txt_4c_Linha
                .Top       = 165
                .Left      = 294
                .Width     = 108
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Value     = NVL(THIS.this_oBusinessObject.this_cLinhaFiltro, "")
                .Visible   = .T.
            ENDWITH

            *-- descs char(40) - SigCdLin
            THIS.AddObject("txt_4c_DescLinha", "TextBox")
            WITH THIS.txt_4c_DescLinha
                .Top       = 165
                .Left      = 404
                .Width     = 332
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 40
                .Value     = NVL(THIS.this_oBusinessObject.this_cDescLinhaFiltro, "")
                .Visible   = .T.
            ENDWITH

            BINDEVENT(THIS.txt_4c_Linha,     "LostFocus", THIS, "ValidarLinhaFiltroLostFocus")
            BINDEVENT(THIS.txt_4c_DescLinha, "LostFocus", THIS, "ValidarDescLinhaFiltroLostFocus")

            *-- optImagem (OptionGroup) - Situacao da Imagem: 1=Sem Imagem,
            *-- 2=Com Imagem, 3=Geral. ControlSource numerico = indice do
            *-- botao (regra #188 - NUNCA 0/1 booleano)
            THIS.AddObject("opt_4c_TipoImagem", "OptionGroup")
            WITH THIS.opt_4c_TipoImagem
                .Top         = 88
                .Left        = 478
                .Width       = 260
                .Height      = 26
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = NVL(THIS.this_oBusinessObject.this_nTipoImagem, 1)
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top       = 5
                    .Left      = 3
                    .Width     = 100
                    .Height    = 16
                    .Style     = 0
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Sem Imagem"
                ENDWITH

                WITH .Buttons(2)
                    .Top       = 5
                    .Left      = 102
                    .Width     = 99
                    .Height    = 16
                    .Style     = 0
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Com Imagem"
                ENDWITH

                WITH .Buttons(3)
                    .Top       = 5
                    .Left      = 202
                    .Width     = 50
                    .Height    = 16
                    .Style     = 0
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Geral"
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltrosLinhaImagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere TODOS os campos da tela para as properties do
    * SigOpImgBO, equivalente ao que o legado faz implicitamente via
    * ControlSource direto em cada fwget/optImagem (e, no caso do produto
    * corrente, via "pPro = csProdutos.CPros" no inicio de cada handler).
    *
    * Dois blocos, porque esta tela tem duas "fichas" distintas:
    *   1) FILTRO - Periodo (getDtIni/getDtFin), Grupo (getGrupo/getDGrupo),
    *      Produto (getCProsF/getDProsF), Linha (getLin/getDLin) e Situacao
    *      de Imagem (optImagem). Alimenta SigOpImgBO.Processar().
    *   2) PRODUTO CORRENTE - linha selecionada na grade (cursor_4c_Produtos,
    *      csProdutos do legado). Alimenta SigOpImgBO.Atualizar(), que grava
    *      FigJpgs em SigCdPro.
    *
    * O bloco 2 so transfere quando ha linha corrente; sem isso, o produto
    * guardado por uma captura anterior seria apagado e o Atualizar seguinte
    * cairia no guard de ValidarDados.
    *
    * Devolve .T./.F. para que o chamador possa ABORTAR a acao (regra do
    * FormParaBO que falha no meio - nunca seguir gravando ficha parcial).
    *
    * PUBLIC (sem PROTECTED): o harness de teste e os handlers de imagem
    * chamam o metodo de fora da classe.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            WITH THIS.this_oBusinessObject
                *-- 1) Filtros da selecao
                .this_dDataIni           = THIS.txt_4c_DataIni.Value
                .this_dDataFin           = THIS.txt_4c_DataFim.Value
                .this_cGrupoFiltro       = ALLTRIM(THIS.txt_4c_Grupo.Value)
                .this_cDescGrupoFiltro   = ALLTRIM(THIS.txt_4c_DescGrupo.Value)
                .this_cProdutoFiltro     = ALLTRIM(THIS.txt_4c_Produto.Value)
                .this_cDescProdutoFiltro = ALLTRIM(THIS.txt_4c_DescProduto.Value)
                .this_cLinhaFiltro       = ALLTRIM(THIS.txt_4c_Linha.Value)
                .this_cDescLinhaFiltro   = ALLTRIM(THIS.txt_4c_DescLinha.Value)
                .this_nTipoImagem        = THIS.opt_4c_TipoImagem.Value
            ENDWITH

            *-- 2) Produto corrente (linha da grade) - CarregarDoCursor ja le
            *-- as 10 colunas do cursor nas properties equivalentes
            IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos") ;
                    AND RECCOUNT("cursor_4c_Produtos") > 0
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Produtos")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Caminho inverso de FormParaBO: devolve as properties do
    * SigOpImgBO para os controles da tela.
    *
    * Usado quando o estado do filtro eh definido FORA da tela: os defaults
    * do Init legado (getDtIni.Value = Date()-1, getDtFin.Value = Date(),
    * optImagem.Value = 1) sao gravados no BO pelo InicializarForm e so
    * chegam aos TextBox por aqui; e o "Limpar Sel." (BtnCancelarClick)
    * reexibe os filtros que geraram a ultima selecao.
    *
    * A imagem do produto corrente eh exibida por CarregarImagemProduto (que
    * decodifica FigJpgs e pinta img_4c_Imagem), chamado no fim deste metodo
    * para que tela e BO fiquem coerentes num unico passo.
    *
    * PUBLIC pelo mesmo motivo de FormParaBO.
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro, loc_nTipoImagem

        loc_lSucesso = .F.

        TRY
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_DataIni.Value      = ConverterParaData(.this_dDataIni)
                THIS.txt_4c_DataFim.Value      = ConverterParaData(.this_dDataFin)
                THIS.txt_4c_Grupo.Value        = ALLTRIM(NVL(.this_cGrupoFiltro, ""))
                THIS.txt_4c_DescGrupo.Value    = ALLTRIM(NVL(.this_cDescGrupoFiltro, ""))
                THIS.txt_4c_Produto.Value      = ALLTRIM(NVL(.this_cProdutoFiltro, ""))
                THIS.txt_4c_DescProduto.Value  = ALLTRIM(NVL(.this_cDescProdutoFiltro, ""))
                THIS.txt_4c_Linha.Value        = ALLTRIM(NVL(.this_cLinhaFiltro, ""))
                THIS.txt_4c_DescLinha.Value    = ALLTRIM(NVL(.this_cDescLinhaFiltro, ""))

                loc_nTipoImagem = NVL(.this_nTipoImagem, 1)
            ENDWITH

            *-- optImagem eh OptionGroup de 3 botoes com ControlSource
            *-- NUMERICO = indice 1-based (regra #188): 0 nunca eh valido
            THIS.opt_4c_TipoImagem.Value = IIF(BETWEEN(loc_nTipoImagem, 1, 3), loc_nTipoImagem, 1)

            *-- Imagem do produto corrente (equivalente ao CarregaImagem legado)
            THIS.CarregarImagemProduto(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodProduto, "")))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGrupoFiltroLostFocus / ValidarDescGrupoFiltroLostFocus -
    * Lookups do Grupo (equivalentes ao Valid legado de getGrupo/getDGrupo).
    * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3).
    *==========================================================================
    PROCEDURE ValidarGrupoFiltroLostFocus()
        LOCAL loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)
        IF loc_cValor == THIS.this_cUltimoValidarGrupoFiltroLostFocusValidado
            RETURN
        ENDIF

        THIS.AbrirLookupGrupoFiltro("cgrus")

        THIS.this_cUltimoValidarGrupoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_Grupo.Value)
    ENDPROC

    PROCEDURE ValidarDescGrupoFiltroLostFocus()
        LOCAL loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_DescGrupo.Value)
        IF loc_cValor == THIS.this_cUltimoValidarDescGrupoFiltroLostFocusValidado
            RETURN
        ENDIF

        THIS.AbrirLookupGrupoFiltro("dgrus")

        THIS.this_cUltimoValidarDescGrupoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_DescGrupo.Value)
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoFiltro - Funil unico dos dois Valid legados de
    * getGrupo/getDGrupo. Busca em SigCdGrp; o Init do FormBuscaAuxiliar ja
    * tenta o match exato (regra #37) - so mostra o picker quando precisa.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupoFiltro(par_cCampoBusca)
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupGrupo
            RETURN
        ENDIF
        THIS.this_lEmLookupGrupo = .T.

        TRY
            loc_cValor = IIF(par_cCampoBusca = "cgrus", ;
                ALLTRIM(THIS.txt_4c_Grupo.Value), ALLTRIM(THIS.txt_4c_DescGrupo.Value))

            IF !EMPTY(loc_cValor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_BuscaGrupo", par_cCampoBusca, loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Grupo")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_BuscaGrupo
                        THIS.txt_4c_Grupo.Value     = ALLTRIM(cgrus)
                        THIS.txt_4c_DescGrupo.Value = ALLTRIM(dgrus)
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
            ELSE
                THIS.txt_4c_Grupo.Value     = ""
                THIS.txt_4c_DescGrupo.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupoFiltro")
        ENDTRY

        THIS.this_lEmLookupGrupo = .F.
    ENDPROC

    *==========================================================================
    * ValidarProdutoFiltroLostFocus / ValidarDescProdutoFiltroLostFocus -
    * Lookups do Produto (equivalentes ao Valid legado de getCProsF/getDProsF).
    *==========================================================================
    PROCEDURE ValidarProdutoFiltroLostFocus()
        LOCAL loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_Produto.Value)
        IF loc_cValor == THIS.this_cUltimoValidarProdutoFiltroLostFocusValidado
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoFiltro("cpros")

        THIS.this_cUltimoValidarProdutoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_Produto.Value)
    ENDPROC

    PROCEDURE ValidarDescProdutoFiltroLostFocus()
        LOCAL loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_DescProduto.Value)
        IF loc_cValor == THIS.this_cUltimoValidarDescProdutoFiltroLostFocusValidado
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoFiltro("dpros")

        THIS.this_cUltimoValidarDescProdutoFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_DescProduto.Value)
    ENDPROC

    *==========================================================================
    * AbrirLookupProdutoFiltro - Funil unico dos dois Valid legados de
    * getCProsF/getDProsF. Busca em SigCdPro.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupProdutoFiltro(par_cCampoBusca)
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupProduto
            RETURN
        ENDIF
        THIS.this_lEmLookupProduto = .T.

        TRY
            loc_cValor = IIF(par_cCampoBusca = "cpros", ;
                ALLTRIM(THIS.txt_4c_Produto.Value), ALLTRIM(THIS.txt_4c_DescProduto.Value))

            IF !EMPTY(loc_cValor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BuscaProdutoFiltro", par_cCampoBusca, loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Produto")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoFiltro")
                        SELECT cursor_4c_BuscaProdutoFiltro
                        THIS.txt_4c_Produto.Value     = ALLTRIM(cpros)
                        THIS.txt_4c_DescProduto.Value = ALLTRIM(dpros)
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaProdutoFiltro")
                    USE IN cursor_4c_BuscaProdutoFiltro
                ENDIF
            ELSE
                THIS.txt_4c_Produto.Value     = ""
                THIS.txt_4c_DescProduto.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupProdutoFiltro")
        ENDTRY

        THIS.this_lEmLookupProduto = .F.
    ENDPROC

    *==========================================================================
    * ValidarLinhaFiltroLostFocus / ValidarDescLinhaFiltroLostFocus -
    * Lookups da Linha (equivalentes ao Valid legado de getLin/getDLin).
    *==========================================================================
    PROCEDURE ValidarLinhaFiltroLostFocus()
        LOCAL loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_Linha.Value)
        IF loc_cValor == THIS.this_cUltimoValidarLinhaFiltroLostFocusValidado
            RETURN
        ENDIF

        THIS.AbrirLookupLinhaFiltro("linhas")

        THIS.this_cUltimoValidarLinhaFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_Linha.Value)
    ENDPROC

    PROCEDURE ValidarDescLinhaFiltroLostFocus()
        LOCAL loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_DescLinha.Value)
        IF loc_cValor == THIS.this_cUltimoValidarDescLinhaFiltroLostFocusValidado
            RETURN
        ENDIF

        THIS.AbrirLookupLinhaFiltro("descs")

        THIS.this_cUltimoValidarDescLinhaFiltroLostFocusValidado = ALLTRIM(THIS.txt_4c_DescLinha.Value)
    ENDPROC

    *==========================================================================
    * AbrirLookupLinhaFiltro - Funil unico dos dois Valid legados de
    * getLin/getDLin. Busca em SigCdLin.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupLinhaFiltro(par_cCampoBusca)
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupLinha
            RETURN
        ENDIF
        THIS.this_lEmLookupLinha = .T.

        TRY
            loc_cValor = IIF(par_cCampoBusca = "linhas", ;
                ALLTRIM(THIS.txt_4c_Linha.Value), ALLTRIM(THIS.txt_4c_DescLinha.Value))

            IF !EMPTY(loc_cValor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdLin", "cursor_4c_BuscaLinha", par_cCampoBusca, loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Linha")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("linhas", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLinha")
                        SELECT cursor_4c_BuscaLinha
                        THIS.txt_4c_Linha.Value     = ALLTRIM(linhas)
                        THIS.txt_4c_DescLinha.Value = ALLTRIM(descs)
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaLinha")
                    USE IN cursor_4c_BuscaLinha
                ENDIF
            ELSE
                THIS.txt_4c_Linha.Value     = ""
                THIS.txt_4c_DescLinha.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupLinhaFiltro")
        ENDTRY

        THIS.this_lEmLookupLinha = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria grd_4c_Produtos (grdProdutos legado), ligado ao
    * cursor_4c_Produtos. Colunas/larguras/legendas identicas ao Init legado
    * (RecordSource/ControlSource antes de Width/Header1.Caption - regra #41).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("grd_4c_Produtos", "Grid")
            WITH THIS.grd_4c_Produtos
                .Top               = 192
                .Left              = 13
                .Width             = 974
                .Height            = 243
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ColumnCount       = 6
                .ScrollBars        = 2
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ReadOnly          = .F.
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .HeaderHeight      = 16
                .RowHeight         = 16
                .GridLineColor     = RGB(238, 238, 238)
                .RecordSource      = "cursor_4c_Produtos"

                .Column1.ControlSource = "cursor_4c_Produtos.cpros"
                .Column2.ControlSource = "cursor_4c_Produtos.dpros"
                .Column3.ControlSource = "cursor_4c_Produtos.ifors"
                .Column4.ControlSource = "cursor_4c_Produtos.reffs"
                .Column5.ControlSource = "cursor_4c_Produtos.cgrus"
                .Column6.ControlSource = "cursor_4c_Produtos.linhas"

                .Column1.Width = 129
                .Column2.Width = 366
                .Column3.Width = 112
                .Column4.Width = 191
                .Column5.Width = 50
                .Column6.Width = 100

                .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Column3.Header1.Caption = "Fornecedor"
                .Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
                .Column5.Header1.Caption = "Grupo"
                .Column6.Header1.Caption = "Linha"

                .Column1.Header1.Alignment = 2
                .Column2.Header1.Alignment = 2
                .Column3.Header1.Alignment = 2
                .Column4.Header1.Alignment = 2
                .Column5.Header1.Alignment = 2
                .Column6.Header1.Alignment = 2
                .Column1.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontName  = "Tahoma"
                .Column5.Header1.FontName  = "Tahoma"
                .Column6.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column2.Header1.FontSize  = 8
                .Column3.Header1.FontSize  = 8
                .Column4.Header1.FontSize  = 8
                .Column5.Header1.FontSize  = 8
                .Column6.Header1.FontSize  = 8

                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                .Column3.Text1.FontName    = "Tahoma"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                .Column4.Text1.FontName    = "Tahoma"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                .Column5.Text1.FontName    = "Tahoma"
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.Alignment   = 3
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)

                .Column6.Text1.FontName    = "Tahoma"
                .Column6.Text1.FontSize    = 8
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(255, 255, 255)

                *-- Loop do Init legado (For I=1 To ColumnCount): fonte da
                *-- COLUNA (distinta da fonte do Text1, que fica Tahoma) +
                *-- trava movimentacao/redimensionamento/edicao
                .Column1.FontName  = "Courier New"
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column2.FontName  = "Courier New"
                .Column2.Movable   = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column3.FontName  = "Courier New"
                .Column3.Movable   = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly  = .T.
                .Column4.FontName  = "Courier New"
                .Column4.Movable   = .F.
                .Column4.Resizable = .F.
                .Column4.ReadOnly  = .T.
                .Column5.FontName  = "Courier New"
                .Column5.Movable   = .F.
                .Column5.Resizable = .F.
                .Column5.ReadOnly  = .T.
                .Column6.FontName  = "Courier New"
                .Column6.Movable   = .F.
                .Column6.Resizable = .F.
                .Column6.ReadOnly  = .T.

                .SetAll("DynamicForeColor", ;
                    "IIF(EMPTY(cursor_4c_Produtos.figjpgs) OR ISNULL(cursor_4c_Produtos.figjpgs), RGB(255,0,0), RGB(0,0,0))", ;
                    "Column")

                .Visible = .T.
            ENDWITH

            THIS.this_nCorPadrao = THIS.grd_4c_Produtos.Column1.Header1.BackColor

            BINDEVENT(THIS.grd_4c_Produtos.Column1.Header1, "Click", THIS, "HeaderCodigoClick")
            BINDEVENT(THIS.grd_4c_Produtos.Column2.Header1, "Click", THIS, "HeaderDescricaoClick")
            BINDEVENT(THIS.grd_4c_Produtos.Column3.Header1, "Click", THIS, "HeaderFornecedorClick")
            BINDEVENT(THIS.grd_4c_Produtos.Column4.Header1, "Click", THIS, "HeaderReferenciaClick")
            BINDEVENT(THIS.grd_4c_Produtos.Column5.Header1, "Click", THIS, "HeaderGrupoClick")
            BINDEVENT(THIS.grd_4c_Produtos.Column6.Header1, "Click", THIS, "HeaderLinhaClick")
            BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GradeAfterRowColChange")

            *-- Ordem e realce iniciais: equivalente ao "Set Order To CPros In
            *-- csProdutos" + Column1.Header1 verde que o AcertaForm legado
            *-- aplica no fim do Init. O SetFocus fica a cargo do
            *-- OrdenarPorColuna, que o pula enquanto o form nao esta visivel
            *-- (aqui os AddObject acabaram de rodar e THIS.Visible ainda eh .F.).
            THIS.OrdenarPorColuna("cpros", 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarImagem - Cria a moldura (Shape3 legado) e o controle de
    * imagem (ImgFigJpg legado) que exibe a foto do produto corrente,
    * atualizada pelo GradeAfterRowColChange.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagem()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Imagem", "Shape")
            WITH THIS.shp_4c_Imagem
                .Top           = 477
                .Left          = 23
                .Width         = 201
                .Height        = 118
                .BackStyle     = 0
                .FillStyle     = 1
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("img_4c_Imagem", "Image")
            WITH THIS.img_4c_Imagem
                .Top     = 478
                .Left    = 24
                .Width   = 199
                .Height  = 116
                .Stretch = 1
                .Enabled = .F.
                .Picture = ""
                *-- O ImgFigJpg legado nao declara Visible (default .T.) e sem
                *-- Picture nao desenha nada; quem alterna eh o CarregaImagem.
                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarImagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBusca - Mini barra "Procurar" (Say3/getCPros/getDPros/
    * getIFors/getReffs) abaixo da grade: digitar e Tab/sair do campo
    * localiza o produto mais proximo na grade e limpa a caixa - equivalente
    * ao LostFocus dos 4 fwget legados.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBusca()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_Procurar", "Label")
            WITH THIS.lbl_4c_Procurar
                .Top       = 433
                .Left      = 24
                .Width     = 60
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Procurar"
                .Visible   = .T.
            ENDWITH

            *-- cpros char(14) - busca por Codigo
            THIS.AddObject("txt_4c_BuscaCodigo", "TextBox")
            WITH THIS.txt_4c_BuscaCodigo
                .Top       = 450
                .Left      = 23
                .Width     = 108
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 14
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- dpros char(65) - busca por Descricao
            THIS.AddObject("txt_4c_BuscaDescricao", "TextBox")
            WITH THIS.txt_4c_BuscaDescricao
                .Top       = 450
                .Left      = 134
                .Width     = 348
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 65
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- ifors char(10) - busca por Fornecedor
            THIS.AddObject("txt_4c_BuscaFornecedor", "TextBox")
            WITH THIS.txt_4c_BuscaFornecedor
                .Top       = 450
                .Left      = 502
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- reffs char(40) - busca por Referencia
            THIS.AddObject("txt_4c_BuscaReferencia", "TextBox")
            WITH THIS.txt_4c_BuscaReferencia
                .Top       = 450
                .Left      = 604
                .Width     = 150
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 40
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            BINDEVENT(THIS.txt_4c_BuscaCodigo,      "LostFocus", THIS, "BuscaCodigoLostFocus")
            BINDEVENT(THIS.txt_4c_BuscaDescricao,   "LostFocus", THIS, "BuscaDescricaoLostFocus")
            BINDEVENT(THIS.txt_4c_BuscaFornecedor,  "LostFocus", THIS, "BuscaFornecedorLostFocus")
            BINDEVENT(THIS.txt_4c_BuscaReferencia,  "LostFocus", THIS, "BuscaReferenciaLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBusca")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BuscaCodigoLostFocus / BuscaDescricaoLostFocus / BuscaFornecedorLostFocus
    * / BuscaReferenciaLostFocus - equivalentes aos 4 LostFocus legados de
    * getCPros/getDPros/getIFors/getReffs: localiza o produto mais proximo
    * do valor digitado e limpa a caixa.
    *==========================================================================
    PROCEDURE BuscaCodigoLostFocus()
        THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaCodigo, "cpros", 1)
    ENDPROC

    PROCEDURE BuscaDescricaoLostFocus()
        THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaDescricao, "dpros", 2)
    ENDPROC

    PROCEDURE BuscaFornecedorLostFocus()
        THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaFornecedor, "ifors", 3)
    ENDPROC

    PROCEDURE BuscaReferenciaLostFocus()
        THIS.LocalizarProdutoPorBusca(THIS.txt_4c_BuscaReferencia, "reffs", 4)
    ENDPROC

    *==========================================================================
    * LocalizarProdutoPorBusca - Funil unico dos 4 LostFocus legados
    * (getCPros/getDPros/getIFors/getReffs): "Set Order To <campo>" +
    * "Set Near On" + "Locate For <campo> = Alltrim(valor)" + "Set Near Off",
    * equivalente byte a byte ao legado.
    *
    * O legado conta com SET EXACT OFF (prefixo) para a busca por aproximacao
    * funcionar com valor PARCIAL; o config.prg deste projeto liga SET EXACT
    * ON globalmente (regra das chaves compostas), entao o EXACT eh alternado
    * localmente so em volta do LOCATE e restaurado imediatamente depois.
    *==========================================================================
    PROTECTED PROCEDURE LocalizarProdutoPorBusca(par_oTxt, par_cCampo, par_nColuna)
        LOCAL loc_cValor, loc_cExactAnt

        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        IF EMPTY(loc_cValor) OR !USED("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_cExactAnt = SET("EXACT")
        SET EXACT OFF

        SELECT cursor_4c_Produtos
        SET ORDER TO TAG (par_cCampo) IN cursor_4c_Produtos
        SET NEAR ON
        DO CASE
            CASE par_cCampo = "cpros"
                LOCATE FOR cpros = loc_cValor
            CASE par_cCampo = "dpros"
                LOCATE FOR dpros = loc_cValor
            CASE par_cCampo = "ifors"
                LOCATE FOR ifors = loc_cValor
            CASE par_cCampo = "reffs"
                LOCATE FOR reffs = loc_cValor
        ENDCASE
        SET NEAR OFF

        IF loc_cExactAnt = "ON"
            SET EXACT ON
        ENDIF

        par_oTxt.Value = ""

        THIS.RealcarColunaOrdenada(par_nColuna)
        IF THIS.Visible
            THIS.grd_4c_Produtos.Columns(par_nColuna).SetFocus()
        ENDIF
        THIS.grd_4c_Produtos.Refresh()

        IF !EOF("cursor_4c_Produtos")
            THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
        ENDIF
    ENDPROC

    *==========================================================================
    * HeaderCodigoClick / HeaderDescricaoClick / HeaderFornecedorClick /
    * HeaderReferenciaClick / HeaderGrupoClick / HeaderLinhaClick - Reordena
    * cursor_4c_Produtos pelo TAG correspondente e realca o header da
    * coluna ativa, equivalente aos 6 Header1.Click do grdProdutos legado.
    *==========================================================================
    PROCEDURE HeaderCodigoClick()
        THIS.OrdenarPorColuna("cpros", 1)
    ENDPROC

    PROCEDURE HeaderDescricaoClick()
        THIS.OrdenarPorColuna("dpros", 2)
    ENDPROC

    PROCEDURE HeaderFornecedorClick()
        THIS.OrdenarPorColuna("ifors", 3)
    ENDPROC

    PROCEDURE HeaderReferenciaClick()
        THIS.OrdenarPorColuna("reffs", 4)
    ENDPROC

    PROCEDURE HeaderGrupoClick()
        THIS.OrdenarPorColuna("cgrus", 5)
    ENDPROC

    PROCEDURE HeaderLinhaClick()
        THIS.OrdenarPorColuna("linhas", 6)
    ENDPROC

    *==========================================================================
    * OrdenarPorColuna - Funil unico dos 6 Header1.Click legados, na MESMA
    * ordem do legado: guarda o Recno, troca o TAG, repinta os headers, foca
    * a coluna, Refresh, volta o Recno e Refresh de novo.
    *
    * O SetFocus eh condicionado a THIS.Visible porque este mesmo funil eh
    * chamado pelo ConfigurarGrid (equivalente ao AcertaForm do Init legado),
    * quando os controles acabaram de nascer via AddObject e o form ainda
    * esta invisivel - SetFocus em controle de form invisivel estoura.
    *==========================================================================
    PROTECTED PROCEDURE OrdenarPorColuna(par_cTag, par_nColuna)
        LOCAL loc_nRecAtual

        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF

        *-- "lnRec = Recno('csProdutos')" + "Set Order To <tag> In csProdutos"
        *--
        *-- O ponteiro NAO pode ser reposicionado por SEEK: cinco dos seis TAGs
        *-- sao COMPOSTOS (dpros+cpros, ifors+cpros, reffs+cpros, cgrus+cpros,
        *-- linhas+cpros) e o config.prg liga SET EXACT ON, entao SEEK de chave
        *-- parcial devolveria .F. SEMPRE e deixaria a grade em EOF - sem erro
        *-- e sem log. RECNO eh independente da ordem, e eh o que o legado usa.
        loc_nRecAtual = RECNO("cursor_4c_Produtos")

        SET ORDER TO TAG (par_cTag) IN cursor_4c_Produtos

        THIS.RealcarColunaOrdenada(par_nColuna)

        *-- SetFocus condicionado a THIS.Visible: este funil tambem eh chamado
        *-- pelo ConfigurarGrid (equivalente ao AcertaForm do Init legado),
        *-- quando os controles acabaram de nascer via AddObject e o form ainda
        *-- esta invisivel - SetFocus em controle de form invisivel estoura.
        IF THIS.Visible
            THIS.grd_4c_Produtos.Columns(par_nColuna).SetFocus()
        ENDIF

        THIS.grd_4c_Produtos.Refresh()

        *-- "Go lnRec In csProdutos" + Refresh: o GO vem DEPOIS do primeiro
        *-- Refresh porque o Grid re-sincroniza o ponteiro do cursor com a
        *-- linha corrente dele ao repintar - invertendo a ordem, o registro
        *-- que estava selecionado antes da troca de ordem seria perdido.
        IF RECCOUNT("cursor_4c_Produtos") > 0 AND ;
                BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_Produtos"))
            GO loc_nRecAtual IN cursor_4c_Produtos
        ENDIF

        THIS.grd_4c_Produtos.Refresh()
    ENDPROC

    *==========================================================================
    * RealcarColunaOrdenada - Pinta o Header1 da coluna ativa com o verde do
    * legado (RGB(220,255,220)) e devolve os demais ao CorPadrao original.
    *
    * Repoe as SEIS colunas. O AcertaForm legado repoe so Column1..Column4
    * (ficou para tras quando as colunas 5 e 6 foram acrescentadas), o que
    * deixa DOIS headers verdes quando o usuario ordena por Grupo/Linha e
    * em seguida reprocessa; os seis Header1.Click legados ja repoem todas.
    *==========================================================================
    PROTECTED PROCEDURE RealcarColunaOrdenada(par_nColuna)
        LOCAL loc_nI

        FOR loc_nI = 1 TO 6
            IF loc_nI = par_nColuna
                THIS.grd_4c_Produtos.Columns(loc_nI).Header1.BackColor = RGB(220, 255, 220)
            ELSE
                THIS.grd_4c_Produtos.Columns(loc_nI).Header1.BackColor = THIS.this_nCorPadrao
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - Recarrega a imagem do produto da linha
    * corrente. Equivalente a "ThisForm.CarregaImagem(csProdutos.CPros)" do
    * AfterRowColChange legado - sem filtro de coluna (regra #46: carregar
    * detalhe da linha corrente eh uso correto de AfterRowColChange).
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
            THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarImagemProduto - Decodifica FigJpgs (base64) do produto cujo
    * cpros == par_cCodProduto, grava num arquivo temporario, exibe em
    * img_4c_Imagem e apaga o temporario - equivalente ao PROCEDURE
    * CarregaImagem legado.
    *==========================================================================
    PROTECTED PROCEDURE CarregarImagemProduto(par_cCodProduto)
        LOCAL loc_cArquivo, loc_cFoto, loc_lTemImagem

        loc_cArquivo  = SYS(2023) + "\SigCpImg.jpg"
        loc_lTemImagem = .F.

        THIS.img_4c_Imagem.Visible = .F.
        THIS.img_4c_Imagem.Picture = ""

        IF !EMPTY(ALLTRIM(NVL(par_cCodProduto, ""))) AND USED("cursor_4c_Produtos") ;
                AND !EOF("cursor_4c_Produtos") AND cursor_4c_Produtos.cpros == par_cCodProduto
            IF !EMPTY(cursor_4c_Produtos.figjpgs) AND !ISNULL(cursor_4c_Produtos.figjpgs)
                loc_lTemImagem = .T.
                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Produtos.figjpgs, ;
                    "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,", ""), 14)
                IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                    THIS.img_4c_Imagem.Picture = loc_cArquivo
                    THIS.img_4c_Imagem.Visible = .T.
                ENDIF
            ENDIF
        ENDIF

        IF FILE(loc_cArquivo)
            DELETE FILE (loc_cArquivo)
        ENDIF

        *-- btnZoom.When legado (Not Empty(FigJpgs)) - guardado para combinar
        *-- com o modo corrente (filtro/resultado) em AtualizarEstadoBotaoZoom
        THIS.this_lProdutoTemImagem = loc_lTemImagem
        THIS.AtualizarEstadoBotaoZoom()
    ENDPROC

    *==========================================================================
    * AtualizarEstadoBotaoZoom - obj_4c_CmdgFigura.Buttons(3) (Zoom) so fica
    * habilitado em modo RESULTADO (apos Processar) E com o produto corrente
    * tendo imagem - combina o toggle do AcertaForm legado (Not llEna) com o
    * btnZoom.When (Not Empty(FigJpgs)).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarEstadoBotaoZoom()
        IF PEMSTATUS(THIS.cnt_4c_BotoesAcao, "obj_4c_CmdgFigura", 5)
            THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(3).Enabled = ;
                !THIS.this_lModoFiltroAtual AND THIS.this_lProdutoTemImagem
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Valida o periodo (equivalente ao cmdSelecionar.
    * Click legado) e delega a busca para CarregarLista().
    *
    * FormParaBO() vem ANTES das validacoes e o seu retorno aborta a acao:
    * sem os filtros transferidos, o Processar consultaria com o estado
    * anterior do BO e traria o resultado errado em silencio.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_dDataIni, loc_dDataFin

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        loc_dDataIni = THIS.this_oBusinessObject.this_dDataIni
        loc_dDataFin = THIS.this_oBusinessObject.this_dDataFin

        IF EMPTY(loc_dDataIni)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(loc_dDataFin)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF loc_dDataFin < loc_dDataIni
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * CarregarLista - Metodo de carga da grade (PROCEDURE Processamento do
    * legado). Chama SigOpImgBO.Processar(), que faz o SQLEXEC num cursor
    * TEMPORARIO, e repopula cursor_4c_Produtos via ZAP + APPEND FROM DBF -
    * nunca SQLEXEC direto sobre o alias ligado ao Grid, que zeraria o
    * ColumnCount e deixaria a grade como um retangulo branco.
    *
    * O legado fecha com AcertaForm(.f.) (ordem CPros + realce da Column1) +
    * CarregaImagem + Refresh + foco na Column1 ou no btnLimpar quando nada
    * foi selecionado; so a parte de Enabled dos filtros do AcertaForm nao
    * cabe aqui, por depender dos controles de filtro.
    *
    * PUBLIC (sem PROTECTED): o TesteAutomatico.prg chama este metodo de FORA
    * da classe, por macro (THIS.oForm.&loc_cMetodo.()), e o PEMSTATUS(...,5)
    * que ele usa devolve .T. tambem para metodo PROTECTED - o harness entraria
    * no ramo e a chamada real estouraria "Property CARREGARLISTA is not found".
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro, loc_nRegistros

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.Processar("cursor_4c_ProdutosTemp")

            IF loc_lSucesso
                THIS.EsvaziarCursorProdutos()

                IF USED("cursor_4c_ProdutosTemp")
                    IF RECCOUNT("cursor_4c_ProdutosTemp") > 0
                        SELECT cursor_4c_Produtos
                        APPEND FROM DBF("cursor_4c_ProdutosTemp")
                    ENDIF
                    USE IN cursor_4c_ProdutosTemp
                ENDIF

                *-- GO TOP + Refresh: cursor populado nao repinta a grade sozinho
                SELECT cursor_4c_Produtos
                GO TOP
                loc_nRegistros = RECCOUNT("cursor_4c_Produtos")

                THIS.AjustarControlesPorModo(.F.)
                THIS.OrdenarPorColuna("cpros", 1)

                IF loc_nRegistros < 1
                    MsgAviso("Nenhum Produto Foi Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.CarregarImagemProduto("")
                    THIS.cnt_4c_Botoes.cmg_4c_Limpar.Buttons(1).SetFocus()
                ELSE
                    THIS.CarregarImagemProduto(cursor_4c_Produtos.cpros)
                ENDIF
            ELSE
                *-- Mensagem do legado para falha de consulta (Processamento - 1)
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        THIS.this_oBusinessObject.ObterMensagemErro(), ;
                        "Falha na Conex" + CHR(227) + "o (Processamento - 1)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Nome usado pelos handlers desta tela desde a migracao
    * da logica de selecao. Mantido como porta de entrada unica para
    * CarregarLista (que eh o nome canonico do projeto para o metodo que
    * popula a grade), para que exista UMA implementacao so.
    *==========================================================================
    PROCEDURE CarregarDados()
        RETURN THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * CmgLimparClick - Despacha os 2 botoes de cmg_4c_Limpar (cmdBtnForm
    * legado): Button1 "Limpar Sel." e Button2 "Encerrar" - equivalente ao
    * "If This.Value = 1 / ... / Else ThisForm.Release" do Click legado.
    *==========================================================================
    PROCEDURE CmgLimparClick()
        IF THIS.cnt_4c_Botoes.cmg_4c_Limpar.Value = 1
            THIS.BtnCancelarClick()
        ELSE
            THIS.BtnEncerrarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - "Limpar Sel." (cmdBtnForm.btnLimpar legado, ramo
    * "If This.Value = 1"): CANCELA a selecao corrente e devolve a tela ao
    * modo FILTRO, para o usuario montar outra consulta.
    *
    * Esta eh a unica acao cancelavel do SIGOPIMG - nao ha Page2 de Dados
    * nem Salvar/Cancelar de ficha: a gravacao da imagem eh imediata (botao
    * "Imagem"/"Branco"), e o que se cancela aqui eh o RESULTADO da selecao.
    *
    * Ordem identica ao legado: Zap In csProdutos -> CarregaImagem('') ->
    * AcertaForm(.t.) (que reordena por CPros, realca a Column1, devolve o
    * foco ao periodo e reabilita os filtros).
    *
    * PUBLIC: chamado pelo CmgLimparClick e pelo TesteAutomatico.prg.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.OrdenarPorColuna("cpros", 1)
        THIS.AjustarControlesPorModo(.T.)

        *-- Reexibe no form o filtro que gerou a selecao recem-descartada,
        *-- mantendo tela e BO coerentes para a proxima consulta
        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - "Encerrar" (cmdBtnForm.Buttons(2) legado, ramo
    * "Else ThisForm.Release"). Os cursores sao fechados no Destroy.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * LimparCampos - Descarta a selecao corrente: esvazia cursor_4c_Produtos
    * (Zap In csProdutos legado), apaga a imagem exibida (CarregaImagem('')) e
    * limpa as 4 caixas de "Procurar" (getCPros/getDPros/getIFors/getReffs),
    * que so fazem sentido com a grade preenchida.
    *
    * Os campos de FILTRO NAO sao limpos aqui - o legado tambem nao os limpa
    * no btnLimpar, e zera-los obrigaria o usuario a redigitar o periodo a
    * cada nova consulta.
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.EsvaziarCursorProdutos()

        THIS.txt_4c_BuscaCodigo.Value     = ""
        THIS.txt_4c_BuscaDescricao.Value  = ""
        THIS.txt_4c_BuscaFornecedor.Value = ""
        THIS.txt_4c_BuscaReferencia.Value = ""

        THIS.this_oBusinessObject.this_cCodProduto   = ""
        THIS.this_oBusinessObject.this_cImagemBase64 = ""

        THIS.CarregarImagemProduto("")
        THIS.grd_4c_Produtos.Refresh()
    ENDPROC

    *==========================================================================
    * CmdgFiguraClick - Despacha os 3 botoes de obj_4c_CmdgFigura (cmdgFigura
    * legado: Imagem/cmdFigura, Branco/cmdBranco, Zoom/btnZoom) para os
    * metodos equivalentes. Sem produto selecionado na grade, nenhum dos 3
    * tem o que fazer - mesma mensagem usada em CarregarLista para grade
    * vazia.
    *==========================================================================
    PROCEDURE CmdgFiguraClick()
        LOCAL loc_cProduto, loc_nBotao

        loc_nBotao = THIS.cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Value

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            MsgAviso("Nenhum Produto Foi Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cProduto = cursor_4c_Produtos.cpros

        DO CASE
            CASE loc_nBotao = 1
                THIS.CapturarImagemProduto(loc_cProduto)
            CASE loc_nBotao = 2
                THIS.AplicarImagemBrancoProduto(loc_cProduto)
            CASE loc_nBotao = 3
                THIS.AbrirZoomImagemProduto(loc_cProduto)
        ENDCASE
    ENDPROC

    *==========================================================================
    * CapturarImagemProduto - cmdFigura.Valid legado: abre o seletor de
    * arquivo (GetPict), confirma a transferencia, grava a imagem em
    * SigCdPro.FigJpgs (via SigOpImgBO.Atualizar) e limpa a previsualizacao
    * em cache em SigPrPrt - so esta acao faz essa limpeza no legado
    * (cmdBranco.Valid nao faz).
    *
    * FigJpgs guarda a imagem em BASE64 (nao em binario cru) - e o que
    * CarregarImagemProduto/demais BOs do sistema decodificam com
    * STRCONV(...,14) (ver docs - "double decode" STRCONV). O legado grava
    * com FileToStr() puro (sem encode) porque historicamente a captura
    * vinha de outro caminho; aqui o encode com STRCONV(...,13) eh
    * obrigatorio para nao gravar binario cru onde o resto do sistema
    * espera base64 (gravar cru corromperia a exibicao em TODOS os pontos
    * que leem FigJpgs, nao so nesta tela).
    *
    * fTamanhoImagem (SIGFUNCS.PRG) nao esta no acervo (regra #13/#27) -
    * mantido so o guard de arquivo existente/nao vazio; o limite real de
    * tamanho/dimensao do legado nao e reproduzido.
    *==========================================================================
    PROTECTED PROCEDURE CapturarImagemProduto(par_cCodProduto)
        LOCAL loc_cArquivo, loc_cImagem, loc_oErro

        loc_cArquivo = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar"))

        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF

        IF !FILE(loc_cArquivo)
            MsgErro("Arquivo " + UPPER(loc_cArquivo) + " n" + CHR(227) + "o encontrado.", "Imagem")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a Transfer" + CHR(234) + "ncia da Imagem ?")
            THIS.grd_4c_Produtos.Column1.SetFocus()
            RETURN
        ENDIF

        *-- FormParaBO leva a linha corrente INTEIRA para o BO (nao so o
        *-- codigo): Atualizar/RegistrarAuditoria/ObterChavePrimaria precisam
        *-- do produto completo, nao de uma ficha pela metade. Fica FORA do
        *-- TRY porque o seu RETURN de guarda nao pode morar dentro dele
        *-- (regra #1) - e porque falhar aqui eh nao ter o que gravar.
        IF !THIS.FormParaBO()
            THIS.grd_4c_Produtos.Column1.SetFocus()
            RETURN
        ENDIF

        WAIT WINDOW "Aguarde!!! Transferindo a Imagem..." NOWAIT

        TRY
            loc_cImagem = STRCONV(FILETOSTR(loc_cArquivo), 13)

            THIS.this_oBusinessObject.this_cCodProduto   = par_cCodProduto
            THIS.this_oBusinessObject.this_cImagemBase64 = loc_cImagem

            THIS.this_oBusinessObject.LimparPreviewImpressao(par_cCodProduto)

            IF THIS.this_oBusinessObject.Atualizar()
                THIS.AtualizarLinhaGradeComImagem(par_cCodProduto, loc_cImagem)

                WAIT CLEAR

                IF MsgConfirma("Deseja Excluir a Imagem Original ?")
                    IF FILE(loc_cArquivo)
                        DELETE FILE (loc_cArquivo)
                    ENDIF
                ENDIF

                THIS.CarregarImagemProduto(par_cCodProduto)
            ELSE
                WAIT CLEAR
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CapturarImagemProduto")
        ENDTRY

        THIS.grd_4c_Produtos.Column1.SetFocus()
    ENDPROC

    *==========================================================================
    * AplicarImagemBrancoProduto - cmdBranco.Valid legado: aplica a imagem
    * "em branco" padrao (BrJpg.JPG do legado, migrada para vbmp\brjpg.jpg -
    * gc_4c_CaminhoIcones) no produto corrente. Mesma gravacao de
    * CapturarImagemProduto, sem o delete de SigPrPrt (o legado nao faz
    * essa limpeza para esta opcao).
    *==========================================================================
    PROTECTED PROCEDURE AplicarImagemBrancoProduto(par_cCodProduto)
        LOCAL loc_cArquivo, loc_cImagem, loc_oErro

        loc_cArquivo = gc_4c_CaminhoIcones + "brjpg.jpg"

        IF !FILE(loc_cArquivo)
            MsgErro("O Arquivo " + UPPER(loc_cArquivo) + " N" + CHR(227) + "o Foi Encontrado!!!", ;
                     "Figura em Branco N" + CHR(227) + "o Encontrada...")
            RETURN
        ENDIF

        *-- Mesma transferencia de ficha de CapturarImagemProduto, FORA do
        *-- TRY pelo mesmo motivo (RETURN de guarda - regra #1)
        IF !THIS.FormParaBO()
            THIS.grd_4c_Produtos.Column1.SetFocus()
            RETURN
        ENDIF

        WAIT WINDOW "Aguarde!!! Transferindo a Imagem..." NOWAIT

        TRY
            loc_cImagem = STRCONV(FILETOSTR(loc_cArquivo), 13)

            THIS.this_oBusinessObject.this_cCodProduto   = par_cCodProduto
            THIS.this_oBusinessObject.this_cImagemBase64 = loc_cImagem

            IF THIS.this_oBusinessObject.Atualizar()
                THIS.AtualizarLinhaGradeComImagem(par_cCodProduto, loc_cImagem)
                WAIT CLEAR
                THIS.CarregarImagemProduto(par_cCodProduto)
            ELSE
                WAIT CLEAR
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AplicarImagemBrancoProduto")
        ENDTRY

        THIS.grd_4c_Produtos.Column1.SetFocus()
    ENDPROC

    *==========================================================================
    * AtualizarLinhaGradeComImagem - Espelha no cursor_4c_Produtos (grade)
    * a imagem/datas que acabaram de ser gravadas em SigCdPro, para o
    * DynamicForeColor (vermelho = sem imagem) e o proximo CarregarImagemProduto
    * refletirem a gravacao sem precisar reconsultar o banco.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarLinhaGradeComImagem(par_cCodProduto, par_cImagemBase64)
        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            IF SEEK(par_cCodProduto, "cursor_4c_Produtos", "cpros")
                REPLACE figjpgs WITH par_cImagemBase64, ;
                        dtfilms WITH DATETIME(), ;
                        datas   WITH DATETIME() ;
                        IN cursor_4c_Produtos
            ENDIF
            THIS.grd_4c_Produtos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirZoomImagemProduto - btnZoom.Click legado: decodifica a imagem do
    * produto corrente para um JPG temporario e abre o Zoom (Do Form
    * SigOpZom legado). SigOpZom.SCX ainda esta em ProximasMigracoes - mesmo
    * padrao de fallback (FILE + CREATEOBJECT guardado + MsgAviso) usado em
    * FormSigMvSbn/FormSigOpCpo/FormSigOpDoc/FormSigPrGlx.
    *==========================================================================
    PROTECTED PROCEDURE AbrirZoomImagemProduto(par_cCodProduto)
        LOCAL loc_cArquivo, loc_cFoto, loc_cLinha2, loc_cLinha3, loc_oForm, loc_oErro

        IF !USED("cursor_4c_Produtos") OR !SEEK(par_cCodProduto, "cursor_4c_Produtos", "cpros")
            RETURN
        ENDIF

        IF EMPTY(cursor_4c_Produtos.figjpgs) OR ISNULL(cursor_4c_Produtos.figjpgs)
            RETURN
        ENDIF

        loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Produtos.figjpgs, ;
            "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
            "data:image/jpg;base64,", ""), 14)
        STRTOFILE(loc_cFoto, loc_cArquivo)

        IF !FILE(loc_cArquivo)
            RETURN
        ENDIF

        loc_cLinha2 = "Produto : " + ALLTRIM(cursor_4c_Produtos.cpros) + " - " + ALLTRIM(cursor_4c_Produtos.dpros)
        loc_cLinha3 = "Fornecedor : " + ALLTRIM(cursor_4c_Produtos.ifors) + " - Refer" + CHR(234) + "ncia : " + ALLTRIM(cursor_4c_Produtos.reffs)

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpZom", loc_cArquivo, loc_cLinha2, loc_cLinha3)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
                "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
                "Aviso")
        ENDIF

        IF FILE(loc_cArquivo)
            DELETE FILE (loc_cArquivo)
        ENDIF

        THIS.grd_4c_Produtos.SetFocus()
    ENDPROC

    *==========================================================================
    * AjustarControlesPorModo - Equivalente ao bloco de Enabled do PROCEDURE
    * AcertaForm legado (LParameters llEna): par_lModoFiltro = .T. habilita
    * os campos de FILTRO (periodo/grupo/produto/linha/situacao de imagem +
    * Processar) e desabilita busca/grade/"Limpar Sel." - o inverso quando
    * .F. (modo RESULTADO, apos Processar).
    *
    * cmdgFigura.cmdFigura/cmdBranco/btnZoom (obj_4c_CmdgFigura.Buttons(1/2/3))
    * seguem o MESMO "Not llEna" do legado - habilitados so em RESULTADO.
    * Buttons(3) (Zoom) ainda combina com a presenca de imagem na linha
    * corrente, via AtualizarEstadoBotaoZoom (equivalente ao btnZoom.When).
    *==========================================================================
    PROTECTED PROCEDURE AjustarControlesPorModo(par_lModoFiltro)
        THIS.this_lModoFiltroAtual = par_lModoFiltro

        *-- LockScreen em volta do bloco inteiro, como no AcertaForm legado:
        *-- sao ~20 trocas de Enabled e a tela "pisca" sem isso
        THIS.LockScreen = .T.

        THIS.HabilitarCampos(par_lModoFiltro)
        THIS.AjustarBotoesPorModo()

        THIS.LockScreen = .F.

        IF THIS.Visible
            IF par_lModoFiltro
                THIS.txt_4c_DataIni.SetFocus()
            ELSE
                THIS.grd_4c_Produtos.Column1.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Metade de CAMPOS do AcertaForm legado (LParameters
    * llEna). par_lHabilitar = .T. (modo FILTRO) habilita periodo/grupo/
    * produto/linha/situacao de imagem; .F. (modo RESULTADO) habilita a
    * grade e as caixas de "Procurar".
    *
    * Transcricao literal do legado, inclusive nas ASSIMETRIAS: das 4 caixas
    * de Procurar, o AcertaForm so toca getCPros e getReffs - getDPros e
    * getIFors ficam sempre habilitadas. Uniformizar aqui mudaria o
    * comportamento da tela (PILAR 1).
    *
    * par_lHabilitar eh OPCIONAL: sem argumento assume o modo corrente
    * (this_lModoFiltroAtual), para poder ser chamado de fora sem conhecer
    * o estado interno.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", ;
            par_lHabilitar, THIS.this_lModoFiltroAtual)

        WITH THIS
            .txt_4c_DataIni.Enabled     = loc_lHabilitar
            .txt_4c_DataFim.Enabled     = loc_lHabilitar
            .txt_4c_Grupo.Enabled       = loc_lHabilitar
            .txt_4c_DescGrupo.Enabled   = loc_lHabilitar
            .txt_4c_Produto.Enabled     = loc_lHabilitar
            .txt_4c_DescProduto.Enabled = loc_lHabilitar
            .txt_4c_Linha.Enabled       = loc_lHabilitar
            .txt_4c_DescLinha.Enabled   = loc_lHabilitar

            .opt_4c_TipoImagem.Buttons(1).Enabled = loc_lHabilitar
            .opt_4c_TipoImagem.Buttons(2).Enabled = loc_lHabilitar
            .opt_4c_TipoImagem.Buttons(3).Enabled = loc_lHabilitar

            *-- "Not llEna" do legado: so valem no modo RESULTADO
            .txt_4c_BuscaCodigo.Enabled     = !loc_lHabilitar
            .txt_4c_BuscaReferencia.Enabled = !loc_lHabilitar
            .grd_4c_Produtos.Enabled        = !loc_lHabilitar
        ENDWITH
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Metade de BOTOES do AcertaForm legado, lida do
    * modo corrente (this_lModoFiltroAtual):
    *   modo FILTRO    -> so "Processar" (cmdSelecionar) habilitado
    *   modo RESULTADO -> "Limpar Sel." (btnLimpar) + Imagem/Branco/Zoom
    *                     (cmdgFigura.cmdFigura/cmdBranco/btnZoom)
    *
    * "Encerrar" (cmg_4c_Limpar.Buttons(2)) fica SEMPRE habilitado: o legado
    * nao o inclui no AcertaForm, e desabilita-lo tiraria a unica saida da
    * tela no modo filtro (o form tem ControlBox = .F.).
    *
    * Buttons(3) (Zoom) ainda depende de o produto corrente ter imagem -
    * essa parte fica em AtualizarEstadoBotaoZoom (btnZoom.When legado),
    * chamado no fim.
    *
    * PUBLIC: o TesteAutomatico.prg chama este metodo de FORA da classe
    * (regra #3 - PEMSTATUS nao distingue PROTECTED).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoFiltro

        loc_lModoFiltro = THIS.this_lModoFiltroAtual

        WITH THIS
            .cnt_4c_Botoes.cmd_4c_Processar.Enabled = loc_lModoFiltro

            .cnt_4c_Botoes.cmg_4c_Limpar.Buttons(1).Enabled = !loc_lModoFiltro
            .cnt_4c_Botoes.cmg_4c_Limpar.Buttons(2).Enabled = .T.

            IF PEMSTATUS(.cnt_4c_BotoesAcao, "obj_4c_CmdgFigura", 5)
                .cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(1).Enabled = !loc_lModoFiltro
                .cnt_4c_BotoesAcao.obj_4c_CmdgFigura.Buttons(2).Enabled = !loc_lModoFiltro
            ENDIF
        ENDWITH

        THIS.AtualizarEstadoBotaoZoom()
    ENDPROC

    *==========================================================================
    * EsvaziarCursorProdutos - "Zap In csProdutos" do legado.
    *
    * O ZAP tem de ser cercado por SET SAFETY OFF: SET SAFETY eh escopado por
    * DATA SESSION e este form eh DataSession = 2, logo o SET SAFETY OFF do
    * main.prg NAO alcanca a sessao privada - com SAFETY ON o ZAP abre o
    * dialogo modal "Zap ... Are you sure?" e CONGELA a tela.
    *
    * ZAP (e nao USE IN + CREATE CURSOR) porque fechar e recriar o alias
    * derrubaria Grid.RecordSource e as Column.ControlSource ligadas no
    * ConfigurarGrid, deixando a grade vazia com o cursor cheio.
    *==========================================================================
    PROTECTED PROCEDURE EsvaziarCursorProdutos()
        LOCAL loc_cSafety

        IF USED("cursor_4c_Produtos")
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF

            SELECT cursor_4c_Produtos
            ZAP

            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis recursivamente os controles
    * criados via AddObject (que nascem com Visible=.F.)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
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
    * Destroy - Libera cursores e recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdutosTemp")
            USE IN cursor_4c_ProdutosTemp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpImgBO.prg):
*====================================================================
* SigOpImgBO.prg
*
* Business Object para Captura de Imagens de Produtos
* Tabela principal: SigCdPro
* Herda de: BusinessBase
*
* Origem: SigOpImg.SCX (Framework legado Fortyus)
* Form OPERACIONAL - selecao de produtos por filtro (periodo de
* inclusao, grupo, produto, linha, situacao de imagem) + captura/
* visualizacao/exclusao da imagem (FigJpgs) do produto selecionado.
*====================================================================

DEFINE CLASS SigOpImgBO AS BusinessBase

    *-- Propriedades de FILTRO (tela de selecao - optImagem/getDtIni/
    *-- getDtFin/getGrupo/getDGrupo/getCProsF/getDProsF/getLin/getDLin)
    this_dDataIni           = {}    && getDtIni.Value  - periodo de inclusao (data inicial)
    this_dDataFin           = {}    && getDtFin.Value  - periodo de inclusao (data final)
    this_nTipoImagem        = 0     && optImagem.Value - 1=Sem Imagem, 2=Com Imagem, 3=Geral
    this_cGrupoFiltro       = ""    && getGrupo.Value    - cgrus char(3) do filtro
    this_cDescGrupoFiltro   = ""    && getDGrupo.Value   - descricao do grupo filtro (SigCdGrp.dgrus)
    this_cProdutoFiltro     = ""    && getCProsF.Value   - cpros char(14) do filtro
    this_cDescProdutoFiltro = ""    && getDProsF.Value   - descricao do produto filtro (dpros)
    this_cLinhaFiltro       = ""    && getLin.Value      - linhas char(10) do filtro
    this_cDescLinhaFiltro   = ""    && getDLin.Value     - descricao da linha filtro (SigCdLin.descs)

    *-- Propriedades do PRODUTO CORRENTE (linha selecionada na grade,
    *-- originadas de SigCdPro/cursor de listagem csProdutos)
    this_cCodProduto     = ""    && cpros char(14) - PK
    this_cDescProduto    = ""    && dpros char(65) (65 no banco, 40 no cursor legado de listagem)
    this_cCodFornecedor  = ""    && ifors char(10)
    this_cReferencia     = ""    && reffs char(40)
    this_cCodGrupo       = ""    && cgrus char(3)
    this_cCodLinha       = ""    && linhas char(10)
    this_cImagemBase64   = ""    && figjpgs text (memo) - imagem em base64/binario
    this_dDataFilme      = {}    && dtfilms datetime - data/hora da ultima transferencia de imagem
    this_dDataInclusao   = {}    && dtincs  datetime - data de inclusao do produto
    this_dData           = {}    && datas   datetime - data da ultima alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "cpros"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpImgBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do PRODUTO CORRENTE a
    * partir de um cursor posicionado em SigCdPro (SELECT * ou lista de
    * colunas equivalente ao csProdutos do legado: DtFilms, DtIncs,
    * Datas, CPros, DPros, IFors, Reffs, CGrus, Linhas, FigJpgs)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCodProduto    = ALLTRIM(TratarNulo(cpros, ""))
        THIS.this_cDescProduto   = ALLTRIM(TratarNulo(dpros, ""))
        THIS.this_cCodFornecedor = ALLTRIM(TratarNulo(ifors, ""))
        THIS.this_cReferencia    = ALLTRIM(TratarNulo(reffs, ""))
        THIS.this_cCodGrupo      = ALLTRIM(TratarNulo(cgrus, ""))
        THIS.this_cCodLinha      = ALLTRIM(TratarNulo(linhas, ""))
        THIS.this_cImagemBase64  = TratarNulo(figjpgs, "")
        THIS.this_dDataFilme     = ConverterParaData(TratarNulo(dtfilms, {}))
        THIS.this_dDataInclusao  = ConverterParaData(TratarNulo(dtincs, {}))
        THIS.this_dData          = ConverterParaData(TratarNulo(datas, {}))

        RETURN .T.
    ENDPROC

    *====================================================================
    * ValidarDados - Valida o produto corrente antes de atualizar a
    * imagem (coluna FigJpgs de SigCdPro)
    *====================================================================
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodProduto))
            THIS.this_cMensagemErro = "Nenhum produto selecionado para atualizar a imagem."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria do produto corrente (cpros)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodProduto, ""))
    ENDPROC

    *====================================================================
    * Atualizar - Grava a imagem (FigJpgs) do produto corrente em
    * SigCdPro, atualizando tambem DtFilms (data da transferencia) e
    * Datas (data da ultima alteracao). Reproduz o Update/Commit feito
    * pelo legado apos CmdgFigura.Valid (capturar imagem) e apos a
    * opcao de imagem em branco - as duas acoes sao a MESMA gravacao,
    * apenas com this_cImagemBase64 vazio ou preenchido.
    *
    * Este formulario (SigOpImg) so atualiza a imagem de produtos JA
    * cadastrados em SigCdPro - o cadastro completo do produto (Inserir)
    * e feito pelo ProdutoBO/FormProduto, e nao ha exclusao de registro
    * aqui. Por isso Inserir()/ExecutarExclusao() permanecem herdados de
    * BusinessBase (nunca chamados por este formulario).
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "figjpgs = " + EscaparSQL(THIS.this_cImagemBase64) + ", " + ;
                "dtfilms = GETDATE(), " + ;
                "datas = GETDATE() " + ;
                "WHERE cpros = " + EscaparSQL(THIS.this_cCodProduto)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_dDataFilme = DATE()
                THIS.this_dData      = DATE()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel atualizar a imagem do produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpImgBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparPreviewImpressao - "Delete From SigPrPrt Where Cpros = ..."
    * do cmdFigura.Valid legado: apaga a previsualizacao de impressao em
    * cache do produto antes de gravar a nova imagem (so a opcao "Imagem"
    * faz essa limpeza no legado; "Branco" nao chama este metodo).
    *====================================================================
    PROCEDURE LimparPreviewImpressao(par_cCodProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodProduto) != "C" OR EMPTY(ALLTRIM(par_cCodProduto))
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCodProduto))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)
        CATCH TO loc_oErro
            *-- Limpeza de cache de previsualizacao - falha aqui nao pode
            *-- bloquear a gravacao da imagem (que eh a acao principal),
            *-- mas o erro precisa ficar visivel (regra #9 - CATCH nunca
            *-- silencioso).
            MsgErro(loc_oErro.Message, "SigOpImgBO.LimparPreviewImpressao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processar - Busca em SigCdPro os produtos que atendem aos filtros
    * correntes (this_dDataIni/this_dDataFin/this_nTipoImagem/
    * this_cGrupoFiltro/this_cProdutoFiltro/this_cLinhaFiltro) e devolve
    * o resultado em par_cCursorDestino via SQLEXEC (cursor TEMPORARIO -
    * quem repopula o cursor ligado ao Grid eh o Form, via ZAP + APPEND
    * FROM DBF, nunca SQLEXEC direto no alias do Grid).
    *
    * Equivalente ao PROCEDURE Processamento do legado (SigOpImg.SCX):
    * mesmo WHERE (DtIncs Between, FigJpgs Is [Not] Null, CPros/CGrus/
    * Linhas quando informados) e mesmo Order By CPros.
    *====================================================================
    PROCEDURE Processar(par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDtIni, loc_cDtFin, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            THIS.this_cMensagemErro = "Cursor de destino n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- Limite superior do periodo com hora 23:59:59, igual ao
            *-- "pDtF = fDtoSQL(ThisForm.getDtFin.Value, '23:59:59')" legado
            loc_cDtIni = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDtFin = "'" + PADL(YEAR(THIS.this_dDataFin), 4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDataFin), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDataFin), 2, "0") + " 23:59:59'"

            loc_cSQL = "SELECT dtfilms, dtincs, datas, cpros, dpros, ifors, reffs, cgrus, linhas, figjpgs " + ;
                "FROM SigCdPro " + ;
                "WHERE dtincs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin

            DO CASE
                CASE THIS.this_nTipoImagem = 1
                    loc_cSQL = loc_cSQL + " AND figjpgs IS NULL"
                CASE THIS.this_nTipoImagem = 2
                    loc_cSQL = loc_cSQL + " AND figjpgs IS NOT NULL"
            ENDCASE

            IF !EMPTY(ALLTRIM(NVL(THIS.this_cProdutoFiltro, "")))
                loc_cSQL = loc_cSQL + " AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cProdutoFiltro))
            ENDIF
            IF !EMPTY(ALLTRIM(NVL(THIS.this_cGrupoFiltro, "")))
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupoFiltro))
            ENDIF
            IF !EMPTY(ALLTRIM(NVL(THIS.this_cLinhaFiltro, "")))
                loc_cSQL = loc_cSQL + " AND linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLinhaFiltro))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cpros"

            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel buscar os produtos." + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: TIMEOUT: VFP9 travou durante teste de formulario (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-04-24 17:12:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-24 17:12:42] [INFO] Config FPW: (nao fornecido)
[2026-04-24 17:12:42] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-04-24 17:12:42] [INFO] Timeout: 300 segundos
[2026-04-24 17:12:42] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xxdy0y3m.prg
[2026-04-24 17:12:42] [INFO] Conteudo do wrapper:
[2026-04-24 17:12:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'
QUIT

[2026-04-24 17:12:42] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xxdy0y3m.prg
[2026-04-24 17:12:42] [INFO] VFP output esperado em: C:\4c\tasks\task020\vfp_output.txt
[2026-04-24 17:12:42] [INFO] Executando Visual FoxPro 9...
[2026-04-24 17:12:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xxdy0y3m.prg
[2026-04-24 17:12:42] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xxdy0y3m.prg
[2026-04-24 17:12:42] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGMDETQ
Inicio: 24/04/26 05:12:43 PM

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
[2026-04-24 17:17:42] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 6204)...
[2026-04-24 17:17:44] [INFO] VFP9 finalizado em 302.0730422 segundos
[2026-04-24 17:17:44] [INFO] Exit Code: 4
[2026-04-24 17:17:44] [INFO] 
[2026-04-24 17:17:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-24 17:17:44] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xxdy0y3m.prg
[2026-04-24 17:17:44] [INFO] 
[2026-04-24 17:17:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-24 17:17:44] [INFO] * Auto-generated wrapper for parameters
[2026-04-24 17:17:44] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-04-24 17:17:44] [INFO] * Parameters: 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'
[2026-04-24 17:17:44] [INFO] 
[2026-04-24 17:17:44] [INFO] * Anti-dialog protections for unattended execution
[2026-04-24 17:17:44] [INFO] SET SAFETY OFF
[2026-04-24 17:17:44] [INFO] SET RESOURCE OFF
[2026-04-24 17:17:44] [INFO] SET TALK OFF
[2026-04-24 17:17:44] [INFO] SET NOTIFY OFF
[2026-04-24 17:17:44] [INFO] SYS(2335, 0)
[2026-04-24 17:17:44] [INFO] 
[2026-04-24 17:17:44] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'
[2026-04-24 17:17:44] [INFO] QUIT
[2026-04-24 17:17:44] [INFO] 
[2026-04-24 17:17:44] [INFO] === Fim do Wrapper.prg ===
[2026-04-24 17:17:44] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-04-24 17:29:32] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-24 17:29:32] [INFO] Config FPW: (nao fornecido)
[2026-04-24 17:29:32] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-04-24 17:29:32] [INFO] Timeout: 300 segundos
[2026-04-24 17:29:32] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pulklwkl.prg
[2026-04-24 17:29:32] [INFO] Conteudo do wrapper:
[2026-04-24 17:29:32] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'
QUIT

[2026-04-24 17:29:32] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pulklwkl.prg
[2026-04-24 17:29:32] [INFO] VFP output esperado em: C:\4c\tasks\task020\vfp_output.txt
[2026-04-24 17:29:32] [INFO] Executando Visual FoxPro 9...
[2026-04-24 17:29:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pulklwkl.prg
[2026-04-24 17:29:32] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pulklwkl.prg
[2026-04-24 17:29:32] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGMDETQ
Inicio: 24/04/26 05:29:33 PM

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
[2026-04-24 17:34:32] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 7084)...
[2026-04-24 17:34:34] [INFO] VFP9 finalizado em 302.0451096 segundos
[2026-04-24 17:34:34] [INFO] Exit Code: 4
[2026-04-24 17:34:34] [INFO] 
[2026-04-24 17:34:34] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-24 17:34:34] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pulklwkl.prg
[2026-04-24 17:34:34] [INFO] 
[2026-04-24 17:34:34] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-24 17:34:34] [INFO] * Auto-generated wrapper for parameters
[2026-04-24 17:34:34] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-04-24 17:34:34] [INFO] * Parameters: 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'
[2026-04-24 17:34:34] [INFO] 
[2026-04-24 17:34:34] [INFO] * Anti-dialog protections for unattended execution
[2026-04-24 17:34:34] [INFO] SET SAFETY OFF
[2026-04-24 17:34:34] [INFO] SET RESOURCE OFF
[2026-04-24 17:34:34] [INFO] SET TALK OFF
[2026-04-24 17:34:34] [INFO] SET NOTIFY OFF
[2026-04-24 17:34:34] [INFO] SYS(2335, 0)
[2026-04-24 17:34:34] [INFO] 
[2026-04-24 17:34:34] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGMDETQ', 'C:\4c\tasks\task020\logs\06_testForm.log'
[2026-04-24 17:34:34] [INFO] QUIT
[2026-04-24 17:34:34] [INFO] 
[2026-04-24 17:34:34] [INFO] === Fim do Wrapper.prg ===
[2026-04-24 17:34:34] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMDETQ.prg):
*------------------------------------------------------------------------------
* FormSIGMDETQ.prg - Form Operacional: Muda Cor/Tamanho de Etiqueta
* Herda de FormBase
* Migrado de SIGMDETQ.SCX
* Tabela: SigOpEtq / SigMvCab / SigMvHst
*------------------------------------------------------------------------------
DEFINE CLASS FormSIGMDETQ AS FormBase

    *-- Propriedades visuais identicas ao original SIGMDETQ.SCX
    Height      = 204
    Width       = 718
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Caption     = "Muda Cor / Tamanho Etiqueta"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGMDETQBO")

            THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"

            IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                *-- Modo teste automatizado: pular verificacoes de banco
                loc_lContinuar = .T.
            ELSE
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lContinuar = .T.
            ELSE
                IF gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lContinuar = .F.
                ENDIF
                ENDIF
            ENDIF

            *-- DopCorTam obrigatorio para abertura do form (igual ao legado)
            IF loc_lContinuar
                IF (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste) AND ;
                   (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                    IF !THIS.this_oBusinessObject.CarregarParametros()
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.TornarControlesVisiveis()
                THIS.ConfigurarBINDEVENTs()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
    * cntSombra (cabecalho cinza) com labels de titulo.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa do topo (equivalente ao "frame" da tela).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = 800
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top           = 18
                .Left          = 10
                .Width         = 769
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .BackStyle     = 0
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = "Muda Cor / Tamanho Etiqueta"
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 17
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Muda Cor / Tamanho Etiqueta"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Agrega botoes e campos do form OPERACIONAL.
    * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo unifica a
    * configuracao da "pagina unica" (equivalente logico da Page1 Lista)
    * para manter compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Reinicia o fluxo do form limpando campos de entrada,
    * resetando o BO e posicionando o foco no campo inicial (Codigo de Barras).
    * Forms OPERACIONAIS nao possuem PageFrame; "alternar para pagina 1" equivale
    * a preparar o form para uma nova operacao do zero.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "txt_4c_Barras", 5)
                THIS.txt_4c_Barras.Value = ""
                THIS.txt_4c_CorAnt.Value = ""
                THIS.txt_4c_TamAnt.Value = ""
                THIS.txt_4c_CorNew.Value = ""
                THIS.txt_4c_TamNew.Value = ""

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_nCodBarras = 0
                    THIS.this_oBusinessObject.this_cCPros     = ""
                    THIS.this_oBusinessObject.this_cCorAnt    = ""
                    THIS.this_oBusinessObject.this_cTamAnt    = ""
                    THIS.this_oBusinessObject.this_cCorNew    = ""
                    THIS.this_oBusinessObject.this_cTamNew    = ""
                ENDIF

                THIS.txt_4c_Barras.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes Processar e Cancelar
    * Posicoes absolutas derivadas do CommandGroup original (Left=562, Top=-2):
    *   Processar (Command2): Left=562+5=567, Top=-2+5=3
    *   Cancelar  (Command1): Left=562+80=642, Top=-2+5=3
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 567
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoBase + "Framework\imagens\geral_configuracao_60.jpg"
            .ToolTipText     = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 642
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Cancelar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .Themes          = .F.
            .MousePointer    = 15
            .Cancel          = .T.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoBase + "Framework\imagens\cadastro_sair_60.jpg"
            .ToolTipText     = "[Esc] Encerrar"
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
    * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarCabecalho
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oCtrl
        FOR EACH loc_oCtrl IN THIS.Controls
            IF VARTYPE(loc_oCtrl) = "O"
                loc_oCtrl.Visible = .T.
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos dos botoes principais
    * Eventos dos campos de entrada sao vinculados em fases posteriores
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.txt_4c_Barras, "KeyPress",          THIS, "TxtBarrasKeyPress")
        BINDEVENT(THIS.txt_4c_Barras, "InteractiveChange", THIS, "TxtBarrasInteractiveChange")
        BINDEVENT(THIS.txt_4c_CorNew, "KeyPress",          THIS, "TxtCorNewKeyPress")
        BINDEVENT(THIS.txt_4c_TamNew, "KeyPress",          THIS, "TxtTamNewKeyPress")
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Valida campos e chama ProcessarAlteracao no BO
    * Depende de txt_4c_Barras, txt_4c_CorNew, txt_4c_TamNew (criados na Fase 4)
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_nCodBarras, loc_lContinuar, loc_oErro
        loc_lContinuar = .T.

        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)

            IF EMPTY(loc_nCodBarras)
                MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            *-- Garante barras validado no banco antes de processar
            IF loc_lContinuar AND THIS.this_oBusinessObject.this_nCodBarras != loc_nCodBarras
                IF !THIS.ValidarBarras()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !MsgConfirma("Confirma a altera" + CHR(231) + CHR(227) + "o dos Dados do Barra?", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.this_oBusinessObject.this_cCorNew = ALLTRIM(THIS.txt_4c_CorNew.Value)
                THIS.this_oBusinessObject.this_cTamNew = ALLTRIM(THIS.txt_4c_TamNew.Value)

                IF THIS.this_oBusinessObject.ProcessarAlteracao()
                    MsgInfo("Grava" + CHR(231) + CHR(227) + "o Realizada.", "Aviso")
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria shapes, labels e textboxes do formulario.
    * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo contem a
    * configuracao de campos de dados (equivalente logico da Page2 Dados)
    * para manter compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Shape1: caixa ao redor do campo Codigo de Barra
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top       = 85
            .Left      = 28
            .Width     = 232
            .Height    = 31
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- Shape2: caixa externa Antigo+Novo
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top       = 118
            .Left      = 28
            .Width     = 399
            .Height    = 80
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- Shape4: caixa Antigo (metade esquerda)
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top       = 118
            .Left      = 28
            .Width     = 197
            .Height    = 80
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- Shape3: linha de header Antigo/Novo
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top       = 118
            .Left      = 28
            .Width     = 399
            .Height    = 24
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- lbl_4c_Say1: "Codigo de Barra :"
        THIS.AddObject("lbl_4c_Say1", "Label")
        WITH THIS.lbl_4c_Say1
            .Top       = 92
            .Left      = 56
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(243) + "digo de \<Barra :"
        ENDWITH

        *-- lbl_4c_Label1: "Antigo" - FontBold + FontSize 10 conforme original
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top      = 122
            .Left     = 94
            .Width    = 45
            .Height   = 18
            .AutoSize = .T.
            .FontBold = .T.
            .FontName = "Tahoma"
            .FontSize = 10
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Antigo"
        ENDWITH

        *-- lbl_4c_Label2: "Novo" - FontBold + FontSize 10 conforme original
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top      = 122
            .Left     = 292
            .Width    = 34
            .Height   = 18
            .AutoSize = .T.
            .FontBold = .T.
            .FontName = "Tahoma"
            .FontSize = 10
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Novo"
        ENDWITH

        *-- lbl_4c_Label3: "Cor :" (Antigo)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 150
            .Left      = 76
            .Width     = 26
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cor :"
        ENDWITH

        *-- lbl_4c_Label4: "Tamanho :" (Antigo)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 174
            .Left      = 49
            .Width     = 53
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tamanho :"
        ENDWITH

        *-- lbl_4c_Label5: "Cor :" (Novo)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 150
            .Left      = 272
            .Width     = 26
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cor :"
        ENDWITH

        *-- lbl_4c_Label6: "Tamanho :" (Novo)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 174
            .Left      = 245
            .Width     = 53
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tamanho :"
        ENDWITH

        *-- txt_4c_Barras: campo Codigo de Barra (numerico 14 digitos, seleciona ao focar)
        THIS.AddObject("txt_4c_Barras", "TextBox")
        WITH THIS.txt_4c_Barras
            .Top           = 89
            .Left          = 145
            .Width         = 108
            .Height        = 21
            .Value         = ""
            .Format        = "K"
            .InputMask     = "99999999999999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_CorAnt: Cor Antigo (somente leitura - When retorna .F. no original)
        THIS.AddObject("txt_4c_CorAnt", "TextBox")
        WITH THIS.txt_4c_CorAnt
            .Top           = 147
            .Left          = 108
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_TamAnt: Tamanho Antigo (somente leitura - When retorna .F. no original)
        THIS.AddObject("txt_4c_TamAnt", "TextBox")
        WITH THIS.txt_4c_TamAnt
            .Top           = 171
            .Left          = 108
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_CorNew: Cor Novo (lookup SigCdCor via F4/ENTER/TAB, max 3 chars)
        THIS.AddObject("txt_4c_CorNew", "TextBox")
        WITH THIS.txt_4c_CorNew
            .Top           = 147
            .Left          = 304
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_TamNew: Tamanho Novo (lookup SigCdTam via F4/ENTER/TAB, max 3 chars)
        THIS.AddObject("txt_4c_TamNew", "TextBox")
        WITH THIS.txt_4c_TamNew
            .Top           = 171
            .Left          = 304
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ValidarBarras - Busca etiqueta no banco e preenche campos Antigo
    * Retorna .T. se barras encontrado e valido
    *==========================================================================
    PROTECTED PROCEDURE ValidarBarras()
        LOCAL loc_nCodBarras, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)

            IF !EMPTY(loc_nCodBarras)
                IF THIS.this_oBusinessObject.BuscarPorBarras(loc_nCodBarras)
                    THIS.txt_4c_CorAnt.Value = THIS.this_oBusinessObject.this_cCorAnt
                    THIS.txt_4c_TamAnt.Value = THIS.this_oBusinessObject.this_cTamAnt
                    THIS.txt_4c_CorNew.Value = ""
                    THIS.txt_4c_TamNew.Value = ""
                    THIS.txt_4c_CorNew.SetFocus()
                    loc_lSucesso = .T.
                ELSE
                    THIS.txt_4c_Barras.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarBarras")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TxtBarrasKeyPress - Dispara ValidarBarras em ENTER (13) e TAB (9)
    *==========================================================================
    PROCEDURE TxtBarrasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarBarras()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtBarrasInteractiveChange - Limpa campos derivados ao editar barras
    *==========================================================================
    PROCEDURE TxtBarrasInteractiveChange()
        THIS.txt_4c_CorAnt.Value = ""
        THIS.txt_4c_TamAnt.Value = ""
        THIS.txt_4c_CorNew.Value = ""
        THIS.txt_4c_TamNew.Value = ""
        THIS.this_oBusinessObject.this_nCodBarras = 0
    ENDPROC

    *==========================================================================
    * AbrirBuscaCor - Lookup de Cores (SigCdCor) via FormBuscaAuxiliar
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaCor()
        LOCAL loc_cValor, loc_oBusca, loc_oErro

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CorNew.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Cores")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaCor") AND RECCOUNT("cursor_4c_BuscaCor") > 0
                        SELECT cursor_4c_BuscaCor
                        THIS.txt_4c_CorNew.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor") AND RECCOUNT("cursor_4c_BuscaCor") > 0
                        SELECT cursor_4c_BuscaCor
                        THIS.txt_4c_CorNew.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
                    ELSE
                        THIS.txt_4c_CorNew.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCor")
                    USE IN cursor_4c_BuscaCor
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaCor")
            IF USED("cursor_4c_BuscaCor")
                USE IN cursor_4c_BuscaCor
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCorNewKeyPress - Dispara lookup de Cor em F4 (115), ENTER (13), TAB (9)
    *==========================================================================
    PROCEDURE TxtCorNewKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaCor()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaTam - Lookup de Tamanhos (SigCdTam) via FormBuscaAuxiliar
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaTam()
        LOCAL loc_cValor, loc_oBusca, loc_oErro

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_TamNew.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Tamanhos")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaTam") AND RECCOUNT("cursor_4c_BuscaTam") > 0
                        SELECT cursor_4c_BuscaTam
                        THIS.txt_4c_TamNew.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam") AND RECCOUNT("cursor_4c_BuscaTam") > 0
                        SELECT cursor_4c_BuscaTam
                        THIS.txt_4c_TamNew.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                    ELSE
                        THIS.txt_4c_TamNew.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaTam")
                    USE IN cursor_4c_BuscaTam
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaTam")
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtTamNewKeyPress - Dispara lookup de Tamanho em F4 (115), ENTER (13), TAB (9)
    *==========================================================================
    PROCEDURE TxtTamNewKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaTam()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o
    * Form OPERACIONAL: "Incluir" equivale a resetar o form para nova entrada
    * de c" + CHR(243) + "digo de barras (equivalente a AlternarPagina no pipeline CRUD)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Executa a altera" + CHR(231) + CHR(227) + "o de Cor/Tamanho da etiqueta
    * Form OPERACIONAL: "Alterar" e' a opera" + CHR(231) + CHR(227) + "o principal (Processar)
    * Delega para BtnProcessarClick que valida campos e grava via BO
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Consulta dados da etiqueta pelo c" + CHR(243) + "digo de barras
    * Form OPERACIONAL: "Visualizar" = buscar barcode e exibir Cor/Tam antigos
    * Delega para ValidarBarras que faz SELECT em SigOpEtq e preenche os campos
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodBarras, loc_oErro

        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)

            IF EMPTY(loc_nCodBarras)
                MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ValidarBarras()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Encerra a opera" + CHR(231) + CHR(227) + "o e fecha o formul" + CHR(225) + "rio
    * Form OPERACIONAL: o legado SIGMDETQ n" + CHR(227) + "o possui opera" + CHR(231) + CHR(227) + "o de exclus" + CHR(227) + "o
    * (s" + CHR(243) + " alteracao via Processar). Aqui equivale ao bot" + CHR(227) + "o Cancelar do original.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            THIS.BtnCancelarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores editaveis do form para o BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCorNew = ALLTRIM(THIS.txt_4c_CorNew.Value)
                THIS.this_oBusinessObject.this_cTamNew = ALLTRIM(THIS.txt_4c_TamNew.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_CorAnt.Value = THIS.this_oBusinessObject.this_cCorAnt
                THIS.txt_4c_TamAnt.Value = THIS.this_oBusinessObject.this_cTamAnt
                THIS.txt_4c_CorNew.Value = THIS.this_oBusinessObject.this_cCorNew
                THIS.txt_4c_TamNew.Value = THIS.this_oBusinessObject.this_cTamNew
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis do form
    * txt_4c_CorAnt e txt_4c_TamAnt sao sempre somente leitura (ReadOnly=.T.)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Barras.Enabled    = par_lHabilitar
            THIS.txt_4c_CorNew.Enabled    = par_lHabilitar
            THIS.txt_4c_TamNew.Enabled    = par_lHabilitar
            THIS.cmd_4c_Processar.Enabled = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos e reseta propriedades do BO
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Barras.Value = ""
            THIS.txt_4c_CorAnt.Value = ""
            THIS.txt_4c_TamAnt.Value = ""
            THIS.txt_4c_CorNew.Value = ""
            THIS.txt_4c_TamNew.Value = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nCodBarras = 0
                THIS.this_oBusinessObject.this_cCPros     = ""
                THIS.this_oBusinessObject.this_cCorAnt    = ""
                THIS.this_oBusinessObject.this_cTamAnt    = ""
                THIS.this_oBusinessObject.this_cCorNew    = ""
                THIS.this_oBusinessObject.this_cTamNew    = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Form OPERACIONAL: sem lista paginada CRUD.
    * Presente por compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL: botoes Processar/Cancelar
    * permanecem habilitados. Presente por compatibilidade com o pipeline.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
                THIS.cmd_4c_Processar.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
                THIS.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Valida etiqueta pelo codigo de barras digitado
    * Equivalente semantico de "Buscar/Consultar" em forms CRUD
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_nCodBarras, loc_oErro
        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)
            IF EMPTY(loc_nCodBarras)
                MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ValidarBarras()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Processa a alteracao de Cor/Tamanho
    * Alias para BtnProcessarClick (compatibilidade com pipeline multi-fase)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGMDETQBO.prg):
*------------------------------------------------------------------------------
* SIGMDETQBO.prg - Business Object: Mudanca de Cor/Tamanho de Etiqueta
* Herda de BusinessBase
* Tabela principal: SigOpEtq (etiquetas de operacao)
*------------------------------------------------------------------------------
DEFINE CLASS SIGMDETQBO AS BusinessBase

    *-- Codigo de barras da etiqueta (numerico)
    this_nCodBarras  = 0

    *-- Codigo do produto (de CrSigOpEtq.CPros / CrSigMvHst.CPros)
    this_cCPros      = ""

    *-- Codigo da empresa (de CrSigMvHst.Emps)
    this_cEmps       = ""

    *-- Cor e Tamanho ANTIGOS (lidos de CrSigOpEtq.CodCors / .CodTams)
    this_cCorAnt     = ""
    this_cTamAnt     = ""

    *-- Cor e Tamanho NOVOS (informados pelo usuario, lookup SigCdCor / SigCdTam)
    this_cCorNew     = ""
    this_cTamNew     = ""

    *-- Chave de sessao do sistema (de crSigCdPac.SigKeys)
    this_cSigKey     = ""

    *-- Codigo da operacao padrao para mudanca cor/tamanho (de crSigCdPac.DopCorTam)
    this_cDopCorTam  = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigOpEtq"
        this_cCampoChave = "CBars"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdPac: SigKeys e DopCorTam
    * Deve ser chamado no InicializarForm do Form antes de qualquer operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 SigKeys, DopCorTam FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") >= 1
                IF RECCOUNT("cursor_4c_Pac") > 0
                    SELECT cursor_4c_Pac
                    THIS.this_cSigKey    = ALLTRIM(cursor_4c_Pac.SigKeys)
                    THIS.this_cDopCorTam = ALLTRIM(cursor_4c_Pac.DopCorTam)
                    IF EMPTY(THIS.this_cDopCorTam)
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o para Mudan" + CHR(231) + "a de Cor/Tamanho n" + CHR(227) + "o definida nos Par" + CHR(226) + "metros do Sistema.", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados em SigCdPac.", "Erro")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema (SigCdPac).", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarParametros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorBarras - Valida e carrega dados da etiqueta pelo codigo de barras
    * Popula: this_nCodBarras, this_cCPros, this_cEmps, this_cCorAnt, this_cTamAnt
    * Retorna .T. se encontrado e valido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorBarras(par_nCodBarras)
        LOCAL loc_lSucesso, loc_lContinuar, loc_nCodBars, loc_cSQL, loc_oErro

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBars = IIF(VARTYPE(par_nCodBarras) = "C", VAL(par_nCodBarras), par_nCodBarras)

            IF EMPTY(loc_nCodBars)
                loc_lContinuar = .F.
            ENDIF

            *-- Passo 1: Localiza em SigOpEtq + SigOpEta (trata barcode antigo)
            IF loc_lContinuar
                loc_cSQL = "SELECT a.CPros, a.CBars, b.cbars_old " + ;
                           "FROM SigOpEtq a " + ;
                           "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                           "WHERE (a.CBars = " + TRANSFORM(loc_nCodBars) + ;
                           " OR b.cbars_old = " + TRANSFORM(loc_nCodBars) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrEtiqs)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_Etiqs
                GO TOP
                IF RECCOUNT("cursor_4c_Etiqs") > 0
                    loc_nCodBars = cursor_4c_Etiqs.CBars
                ENDIF
                IF USED("cursor_4c_Etiqs")
                    USE IN cursor_4c_Etiqs
                ENDIF
            ENDIF

            *-- Passo 2: Carrega dados completos da etiqueta
            IF loc_lContinuar
                loc_cSQL = "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nCodBars)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtq") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrSigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF RECCOUNT("cursor_4c_SigOpEtq") = 0
                    MsgAviso("Barra N" + CHR(227) + "o Localizado!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                IF EMPTY(cursor_4c_SigOpEtq.Contas) OR EMPTY(cursor_4c_SigOpEtq.Grupos)
                    MsgAviso("Barra j" + CHR(225) + " Vendido!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 3: Valida conta transitoria no historico
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Estos FROM SigMvHst WHERE codbarras = " + ;
                           TRANSFORM(loc_nCodBars) + " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstVal") >= 1
                    IF RECCOUNT("cursor_4c_MvHstVal") > 0
                        SELECT cursor_4c_MvHstVal
                        IF INLIST(ALLTRIM(cursor_4c_MvHstVal.Estos), "15000100", "15000150", "15000113")
                            MsgAviso("O Barra Informado Est" + CHR(225) + " Em Uma Conta Transit" + CHR(243) + "ria/" + ;
                                     "Transferencia e N" + CHR(227) + "o Pode Realizar a Altera" + CHR(231) + CHR(227) + "o " + ;
                                     "Dos Dados. Favor Verificar.", "Aten" + CHR(231) + CHR(227) + "o")
                            loc_lContinuar = .F.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvHstVal")
                        USE IN cursor_4c_MvHstVal
                    ENDIF
                ENDIF
            ENDIF

            *-- Passo 4: Popula propriedades do BO
            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                THIS.this_nCodBarras = loc_nCodBars
                THIS.this_cCPros     = ALLTRIM(cursor_4c_SigOpEtq.CPros)
                THIS.this_cCorAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodCors)
                THIS.this_cTamAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodTams)
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BuscarPorBarras")
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF
            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigOpEtq para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodBarras = TratarNulo(CBars,    "N")
            THIS.this_cCPros     = ALLTRIM(TratarNulo(CPros,   "C"))
            THIS.this_cCorAnt    = ALLTRIM(TratarNulo(CodCors, "C"))
            THIS.this_cTamAnt    = ALLTRIM(TratarNulo(CodTams, "C"))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo de barras como string
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodBarras)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarAlteracao - Processa mudanca de Cor/Tamanho da etiqueta
    * Pre-condicao: BuscarPorBarras() e CarregarParametros() ja executados
    *               this_cCorNew e this_cTamNew devem estar preenchidos
    * Fluxo: INSERT SigMvCab + INSERT SigMvHst(S) + INSERT SigMvHst(E) + UPDATE SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarAlteracao()
        LOCAL loc_lSucesso, loc_lTransacao, loc_lContinuar
        LOCAL loc_nCodBarras, loc_cCorOld, loc_cTamOld, loc_cCorNew, loc_cTamNew
        LOCAL loc_cProd, loc_cEmps, loc_nTipoEstos
        LOCAL loc_cIds, loc_nPSeq, loc_nNume
        LOCAL loc_dtData, loc_dData, loc_cSQL, loc_cMsg, loc_oErro
        *-- Campos capturados do historico anterior
        LOCAL loc_cUnits, loc_cMoedas, loc_nTotas, loc_dDataTrans
        LOCAL loc_cEmpos, loc_nCodBarrasHist, loc_nQtds, loc_cGrupos
        LOCAL loc_cEstos, loc_nRecalMeds, loc_cObs, loc_nPesos
        LOCAL loc_cEmpGruEsts, loc_cOriDopNums, loc_nBcIpis, loc_dDtAudits

        loc_lSucesso   = .F.
        loc_lTransacao = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBarras = THIS.this_nCodBarras
            loc_cCorOld    = ALLTRIM(THIS.this_cCorAnt)
            loc_cTamOld    = ALLTRIM(THIS.this_cTamAnt)
            loc_cCorNew    = ALLTRIM(THIS.this_cCorNew)
            loc_cTamNew    = ALLTRIM(THIS.this_cTamNew)
            loc_dtData     = DATETIME()
            loc_dData      = DATE()

            *-- Passo 1: Carrega historico mais recente para obter campos de cabecalho
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Emps, CPros, Units, Moedas, Totas, DataTrans, Empos, " + ;
                           "CodBarras, Qtds, Grupos, Estos, RecalMeds, Obs, Pesos, " + ;
                           "DtAudits, EmpGruEsts, OriDopNums, BcIpis " + ;
                           "FROM SigMvHst WHERE codbarras = " + TRANSFORM(loc_nCodBarras) + ;
                           " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstProc") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvHst)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar AND RECCOUNT("cursor_4c_MvHstProc") = 0
                MsgErro("Hist" + CHR(243) + "rico n" + CHR(227) + "o encontrado para o barras.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_MvHstProc
                loc_cEmps          = ALLTRIM(cursor_4c_MvHstProc.Emps)
                loc_cProd          = ALLTRIM(cursor_4c_MvHstProc.CPros)
                loc_cUnits         = ALLTRIM(cursor_4c_MvHstProc.Units)
                loc_cMoedas        = ALLTRIM(cursor_4c_MvHstProc.Moedas)
                loc_nTotas         = cursor_4c_MvHstProc.Totas
                loc_dDataTrans     = cursor_4c_MvHstProc.DataTrans
                loc_cEmpos         = ALLTRIM(cursor_4c_MvHstProc.Empos)
                loc_nCodBarrasHist = cursor_4c_MvHstProc.CodBarras
                loc_nQtds          = cursor_4c_MvHstProc.Qtds
                loc_cGrupos        = ALLTRIM(cursor_4c_MvHstProc.Grupos)
                loc_cEstos         = ALLTRIM(cursor_4c_MvHstProc.Estos)
                loc_nRecalMeds     = IIF(VARTYPE(cursor_4c_MvHstProc.RecalMeds) = "L", ;
                                         IIF(cursor_4c_MvHstProc.RecalMeds, 1, 0), ;
                                         cursor_4c_MvHstProc.RecalMeds)
                loc_cObs           = ALLTRIM(cursor_4c_MvHstProc.Obs)
                loc_nPesos         = cursor_4c_MvHstProc.Pesos
                loc_cEmpGruEsts    = ALLTRIM(cursor_4c_MvHstProc.EmpGruEsts)
                loc_cOriDopNums    = ALLTRIM(cursor_4c_MvHstProc.OriDopNums)
                loc_nBcIpis        = cursor_4c_MvHstProc.BcIpis
                loc_dDtAudits      = cursor_4c_MvHstProc.DtAudits
                IF USED("cursor_4c_MvHstProc")
                    USE IN cursor_4c_MvHstProc
                ENDIF
            ENDIF

            *-- Passo 2: Valida TipoEstos do grupo do produto
            IF loc_lContinuar
                loc_cSQL = "SELECT b.tipoestos " + ;
                           "FROM sigcdpro a " + ;
                           "JOIN sigcdgrp b ON a.cgrus = b.cgrus " + ;
                           "WHERE a.cpros = " + EscaparSQL(loc_cProd)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProc") >= 1 AND RECCOUNT("cursor_4c_GruposProc") > 0
                    SELECT cursor_4c_GruposProc
                    loc_nTipoEstos = cursor_4c_GruposProc.TipoEstos
                    IF INLIST(loc_nTipoEstos, 2, 4) AND EMPTY(loc_cCorNew)
                        MsgAviso("Favor Informar a Cor.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND INLIST(loc_nTipoEstos, 3, 4) AND EMPTY(loc_cTamNew)
                        MsgAviso("Favor Informar o Tamanho.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 3 AND !EMPTY(loc_cCorNew)
                        loc_cCorNew = ""
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 2 AND !EMPTY(loc_cTamNew)
                        loc_cTamNew = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_GruposProc")
                    USE IN cursor_4c_GruposProc
                ENDIF
            ENDIF

            *-- Passo 3: Gera chaves unicas
            IF loc_lContinuar
                loc_nNume = fGerUniqueKey(ALLTRIM(THIS.this_cDopCorTam) + loc_cEmps)
                loc_cIds  = DTOS(loc_dData) + "S" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")
            ENDIF

            *-- Passo 4: Inicia transacao
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 1
                    loc_lTransacao = .T.
                ELSE
                    MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 5: INSERT em SigMvCab
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, Usuars, Datars, DataS, Mascnum, CidChaves, EmpDopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + ;
                           EscaparSQL(fUniqueIds()) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvCab)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 6: INSERT SigMvHst Saida (Opers='S', CodCors/CodTams ANTIGOS)
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, EmpDopNums, " + ;
                           "EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'S', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorOld) + ", " + ;
                           EscaparSQL(loc_cTamOld) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Sa" + CHR(237) + "da")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 7: INSERT SigMvHst Entrada (Opers='E', CodCors/CodTams NOVOS)
            IF loc_lContinuar
                loc_cIds  = DTOS(loc_dData) + "E" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")

                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, " + ;
                           "EmpDopNums, EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'E', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorNew) + ", " + ;
                           EscaparSQL(loc_cTamNew) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Entrada")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 8: UPDATE SigOpEtq com novos CodCors/CodTams
            IF loc_lContinuar
                loc_cSQL = "UPDATE SigOpEtq SET " + ;
                           "CodCors = " + EscaparSQL(loc_cCorNew) + ", " + ;
                           "CodTams = " + EscaparSQL(loc_cTamNew) + ;
                           " WHERE CBars = " + TRANSFORM(loc_nCodBarras)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 9: Recalculo de estoque via SqlCalcP2 e fRecalculaC
            IF loc_lContinuar
                SET NULL ON
                CREATE CURSOR cursor_4c_LocalHis ;
                    (Emps C(10), Grupos C(10), Estos C(20), CPros C(15), DataS D, CodCors C(6), CodTams C(6))
                SET NULL OFF
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorOld, loc_cTamOld)
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorNew, loc_cTamNew)
                SELECT cursor_4c_LocalHis
                GO TOP
                SCAN
                    =SqlCalcP2(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.Grupos, ;
                               cursor_4c_LocalHis.Estos, cursor_4c_LocalHis.CPros, ;
                               cursor_4c_LocalHis.DataS, cursor_4c_LocalHis.CodCors, ;
                               cursor_4c_LocalHis.CodTams, gnConnHandle)
                    =SqlCalcP2(.T., gnConnHandle, .T.)
                    =fRecalculaC(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.CPros, ;
                                 cursor_4c_LocalHis.DataS, gnConnHandle)
                    SELECT cursor_4c_LocalHis
                ENDSCAN
                IF USED("cursor_4c_LocalHis")
                    USE IN cursor_4c_LocalHis
                ENDIF
            ENDIF

            *-- Passo 10: Commit ou Rollback
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "COMMIT") >= 1
                    loc_lTransacao = .F.
                    loc_lSucesso   = .T.
                ELSE
                    MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ELSE
                IF loc_lTransacao
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF

            *-- Passo 11: Log de auditoria (somente apos sucesso)
            IF loc_lSucesso
                loc_cMsg = "Barra : " + TRANSFORM(loc_nCodBarras) + ;
                           " *** Anterior(C:" + loc_cCorOld + ",T:" + loc_cTamOld + ;
                           ") Novo(C:" + loc_cCorNew + ",T:" + loc_cTamNew + ") *** "
                =fGravarLog("T", "SIGMDETQ", ALLTRIM(THIS.this_cDopCorTam), loc_cMsg, gc_4c_UsuarioLogado)
                THIS.RegistrarAuditoria("ALTERAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ProcessarAltera" + CHR(231) + CHR(227) + "o")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            IF USED("cursor_4c_MvHstProc")
                USE IN cursor_4c_MvHstProc
            ENDIF
            IF USED("cursor_4c_GruposProc")
                USE IN cursor_4c_GruposProc
            ENDIF
            IF USED("cursor_4c_LocalHis")
                USE IN cursor_4c_LocalHis
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * Form SIGMDETQ nao possui insert tradicional. A operacao unica eh a
    * mudanca de cor/tamanho da etiqueta, que gera INSERT em SigMvCab/SigMvHst
    * e UPDATE em SigOpEtq atomicamente dentro de ProcessarAlteracao().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * A "atualizacao" da etiqueta (troca de cor/tamanho) segue o mesmo fluxo
    * transacional de ProcessarAlteracao (UPDATE SigOpEtq + historico).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpEtq") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nCodBarras)) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       THIS.FormatarDatetimeSQL(DATETIME()) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para CONVERT SQL Server
    * Retorna: CONVERT(DATETIME, 'AAAA-MM-DD HH:MM:SS', 120)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDatetimeSQL(par_dtVal)
        LOCAL loc_cDate, loc_cTime
        loc_cDate = PADL(TRANSFORM(YEAR(par_dtVal)),   4, "0") + "-" + ;
                    PADL(TRANSFORM(MONTH(par_dtVal)),  2, "0") + "-" + ;
                    PADL(TRANSFORM(DAY(par_dtVal)),    2, "0")
        loc_cTime = PADL(TRANSFORM(HOUR(par_dtVal)),   2, "0") + ":" + ;
                    PADL(TRANSFORM(MINUTE(par_dtVal)), 2, "0") + ":" + ;
                    PADL(TRANSFORM(SEC(par_dtVal)),    2, "0")
        RETURN "CONVERT(DATETIME, '" + loc_cDate + " " + loc_cTime + "', 120)"
    ENDPROC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARLISTA is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-17 05:17:00] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-17 05:17:00] [INFO] Config FPW: (nao fornecido)
[2026-07-17 05:17:00] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 05:17:00] [INFO] Timeout: 300 segundos
[2026-07-17 05:17:00] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pttswpah.prg
[2026-07-17 05:17:00] [INFO] Conteudo do wrapper:
[2026-07-17 05:17:00] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprico', 'C:\4c\tasks\task299', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprico', 'C:\4c\tasks\task299', 'OPERACIONAL'
QUIT

[2026-07-17 05:17:00] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pttswpah.prg
[2026-07-17 05:17:00] [INFO] VFP output esperado em: C:\4c\tasks\task299\vfp_output.txt
[2026-07-17 05:17:00] [INFO] Executando Visual FoxPro 9...
[2026-07-17 05:17:00] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pttswpah.prg
[2026-07-17 05:17:00] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pttswpah.prg
[2026-07-17 05:17:00] [INFO] Timeout configurado: 300 segundos
[2026-07-17 05:17:22] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 05:17:22] [INFO] VFP9 finalizado em 22.2695896 segundos
[2026-07-17 05:17:22] [INFO] Exit Code: 
[2026-07-17 05:17:22] [INFO] 
[2026-07-17 05:17:22] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 05:17:22] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pttswpah.prg
[2026-07-17 05:17:22] [INFO] 
[2026-07-17 05:17:22] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 05:17:22] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 05:17:22] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 05:17:22] [INFO] * Parameters: 'Formsigprico', 'C:\4c\tasks\task299', 'OPERACIONAL'
[2026-07-17 05:17:22] [INFO] 
[2026-07-17 05:17:22] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 05:17:22] [INFO] SET SAFETY OFF
[2026-07-17 05:17:22] [INFO] SET RESOURCE OFF
[2026-07-17 05:17:22] [INFO] SET TALK OFF
[2026-07-17 05:17:22] [INFO] SET NOTIFY OFF
[2026-07-17 05:17:22] [INFO] SYS(2335, 0)
[2026-07-17 05:17:22] [INFO] 
[2026-07-17 05:17:22] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprico', 'C:\4c\tasks\task299', 'OPERACIONAL'
[2026-07-17 05:17:22] [INFO] QUIT
[2026-07-17 05:17:22] [INFO] 
[2026-07-17 05:17:22] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 05:17:22] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprico",
  "timestamp": "20260717051722",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "2/2 containers togglados com sucesso"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "2/2 paginas navegadas com sucesso"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprico.prg):
*==============================================================================
* Formsigprico.prg
*
* Formulario OPERACIONAL - Mapa Visual (sigprico.SCX)
* Formulario exclusivamente visual: 27 imagens de icones/diagrama
* Sem tabela associada, sem operacoes CRUD, sem metodos de evento no original
*==============================================================================

DEFINE CLASS Formsigprico AS FormBase
	ShowWindow = 1
	WindowType = 1

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *--------------------------------------------------------------------------
    * Propriedades visuais do formulario
    * Original nao especifica Width/Height; usando dimensao padrao
    * de forms OPERACIONAIS para acomodar PageFrame e conteudo
    *--------------------------------------------------------------------------
    Caption      = "Mapa Visual"
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 1
    ControlBox   = .T.
    MaxButton    = .F.
    MinButton    = .F.
    Closable     = .T.
    ClipControls = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *============================================================================
    * Init - Inicializa o formulario via FormBase
    *============================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    * InicializarForm - Cria BO, configura PageFrame e prepara o formulario
    *============================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpricoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigpricoBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarContainersPrincipais()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "VISUAL"

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *============================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    * PageFrame.Top = -29 e Tabs = .F. seguindo padrao do framework
    *============================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .PageCount  = 2
            .Tabs       = .F.
            .BorderWidth = 0
            .Themes     = .F.
            .Visible    = .F.

            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *============================================================================
    * ConfigurarContainersPrincipais - Cria containers vazios das 2 paginas
    * Estes containers sao populados nas fases seguintes (Grid, botoes CRUD,
    * campos de dados, etc)
    *============================================================================
    PROTECTED PROCEDURE ConfigurarContainersPrincipais()
        LOCAL loc_oPag1, loc_oPag2

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1

        *-- Container do cabecalho escuro (topo da pagina Lista)
        loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPag1.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container dos botoes CRUD (lado direito, sera populado na Fase 4)
        loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag1.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container de Saida/Encerrar (padrao canonico)
        loc_oPag1.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPag1.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Container dos botoes de acao da pagina Dados (Salvar/Cancelar)
        loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag2.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *============================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    *============================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                *-- Pular containers que devem permanecer ocultos (Visible=.F. intencional)
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_BOTOES", "CNT_4C_CABECALHO")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *============================================================================
    * ConfigurarPaginaLista - Popula Page1 com cabecalho, botao Encerrar e
    * as 27 imagens do mapa visual (diagrama de icones do sistema)
    *============================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_nL, loc_nT

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_nL    = 371
        loc_nT    = 257

        *-- Labels do cabecalho (sombra deslocada + titulo branco)
        WITH loc_oPag1.cnt_4c_Cabecalho
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 12
                .Width     = 769
                .Height    = 40
                .AutoSize  = .F.
                .Caption   = "Mapa Visual"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .AutoSize  = .F.
                .Caption   = "Mapa Visual"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        *-- Botao Encerrar (padrao canonico cnt_4c_Saida)
        WITH loc_oPag1.cnt_4c_Saida
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPag1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Form puramente visual: cnt_4c_Botoes oculto (sem operacoes CRUD)
        loc_oPag1.cnt_4c_Botoes.Visible = .F.

        *-- 27 imagens do mapa visual centralizadas na area de conteudo
        loc_oPag1.AddObject("img_4c_Image1", "Image")
        WITH loc_oPag1.img_4c_Image1
            .Picture = gc_4c_CaminhoIcones + "form4.ico"
            .Stretch = 2
            .Top     = loc_nT + 0
            .Left    = loc_nL + 0
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image2", "Image")
        WITH loc_oPag1.img_4c_Image2
            .Picture = gc_4c_CaminhoIcones + "form7.ico"
            .Stretch = 2
            .Top     = loc_nT + 18
            .Left    = loc_nL + 0
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image3", "Image")
        WITH loc_oPag1.img_4c_Image3
            .Picture = gc_4c_CaminhoIcones + "ohist.ico"
            .Stretch = 2
            .Top     = loc_nT + 36
            .Left    = loc_nL + 0
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image4", "Image")
        WITH loc_oPag1.img_4c_Image4
            .Picture = gc_4c_CaminhoIcones + "replace.ico"
            .Stretch = 2
            .Top     = loc_nT + 1
            .Left    = loc_nL + 22
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image5", "Image")
        WITH loc_oPag1.img_4c_Image5
            .Picture = gc_4c_CaminhoIcones + "tab.ico"
            .Stretch = 2
            .Top     = loc_nT + 1
            .Left    = loc_nL + 44
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image6", "Image")
        WITH loc_oPag1.img_4c_Image6
            .Picture = gc_4c_CaminhoIcones + "a_fold3.bmp"
            .Stretch = 2
            .Top     = loc_nT + 1
            .Left    = loc_nL + 67
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image7", "Image")
        WITH loc_oPag1.img_4c_Image7
            .Picture = gc_4c_CaminhoIcones + "depend3.bmp"
            .Stretch = 2
            .Top     = loc_nT + 1
            .Left    = loc_nL + 90
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image8", "Image")
        WITH loc_oPag1.img_4c_Image8
            .Picture = gc_4c_CaminhoIcones + "b_arrow4.bmp"
            .Stretch = 2
            .Top     = loc_nT + 24
            .Left    = loc_nL + 24
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image9", "Image")
        WITH loc_oPag1.img_4c_Image9
            .Picture = gc_4c_CaminhoIcones + "b_arrow2.bmp"
            .Stretch = 2
            .Top     = loc_nT + 24
            .Left    = loc_nL + 53
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image10", "Image")
        WITH loc_oPag1.img_4c_Image10
            .Picture = gc_4c_CaminhoIcones + "b_arrow3.bmp"
            .Stretch = 2
            .Top     = loc_nT + 24
            .Left    = loc_nL + 84
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image11", "Image")
        WITH loc_oPag1.img_4c_Image11
            .Picture = gc_4c_CaminhoIcones + "b_arrow1.bmp"
            .Stretch = 2
            .Top     = loc_nT + 24
            .Left    = loc_nL + 116
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image15", "Image")
        WITH loc_oPag1.img_4c_Image15
            .Picture = gc_4c_CaminhoIcones + "kuser.bmp"
            .Stretch = 2
            .Top     = loc_nT + 47
            .Left    = loc_nL + 144
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image16", "Image")
        WITH loc_oPag1.img_4c_Image16
            .Picture = gc_4c_CaminhoIcones + "form4.ico"
            .Stretch = 2
            .Top     = loc_nT + 71
            .Left    = loc_nL + 5
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image17", "Image")
        WITH loc_oPag1.img_4c_Image17
            .Picture = gc_4c_CaminhoIcones + "ohist.ico"
            .Stretch = 2
            .Top     = loc_nT + 94
            .Left    = loc_nL + 13
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image18", "Image")
        WITH loc_oPag1.img_4c_Image18
            .Picture = gc_4c_CaminhoIcones + "depend3.bmp"
            .Stretch = 2
            .Top     = loc_nT + 73
            .Left    = loc_nL + 33
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image19", "Image")
        WITH loc_oPag1.img_4c_Image19
            .Picture = gc_4c_CaminhoIcones + "envmail.bmp"
            .Stretch = 2
            .Top     = loc_nT + 117
            .Left    = loc_nL + 11
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image20", "Image")
        WITH loc_oPag1.img_4c_Image20
            .Picture = gc_4c_CaminhoIcones + "replace.ico"
            .Stretch = 2
            .Top     = loc_nT + 95
            .Left    = loc_nL + 44
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image21", "Image")
        WITH loc_oPag1.img_4c_Image21
            .Picture = gc_4c_CaminhoIcones + "server15.ico"
            .Stretch = 2
            .Top     = loc_nT + 121
            .Left    = loc_nL + 40
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image22", "Image")
        WITH loc_oPag1.img_4c_Image22
            .Picture = gc_4c_CaminhoIcones + "people1.ico"
            .Stretch = 2
            .Top     = loc_nT + 84
            .Left    = loc_nL + 96
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image23", "Image")
        WITH loc_oPag1.img_4c_Image23
            .Picture = gc_4c_CaminhoIcones + "home.ico"
            .Stretch = 2
            .Top     = loc_nT + 108
            .Left    = loc_nL + 101
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image24", "Image")
        WITH loc_oPag1.img_4c_Image24
            .Picture = gc_4c_CaminhoIcones + "search2.ico"
            .Stretch = 2
            .Top     = loc_nT + 134
            .Left    = loc_nL + 106
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image25", "Image")
        WITH loc_oPag1.img_4c_Image25
            .Picture = gc_4c_CaminhoIcones + "menu1.bmp"
            .Stretch = 2
            .Top     = loc_nT + 84
            .Left    = loc_nL + 192
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image26", "Image")
        WITH loc_oPag1.img_4c_Image26
            .Picture = gc_4c_CaminhoIcones + "x_planilha1.bmp"
            .Stretch = 2
            .Top     = loc_nT + 132
            .Left    = loc_nL + 204
            .Width   = 18
            .Height  = 17
        ENDWITH

        loc_oPag1.AddObject("img_4c_Image27", "Image")
        WITH loc_oPag1.img_4c_Image27
            .Picture = gc_4c_CaminhoIcones + "msgstop1.gif"
            .Stretch = 2
            .Top     = loc_nT + 180
            .Left    = loc_nL + 240
            .Width   = 18
            .Height  = 17
        ENDWITH
    ENDPROC

    *============================================================================
    * ConfigurarPaginaDados - Configura Page2 (sem campos: form puramente visual)
    * O formulario sigprico.SCX original nao tem campos de entrada de dados,
    * lookups nem labels de conteudo ? apenas 27 imagens em Page1.
    * Page2 existe na estrutura padrao mas nao contem controles de dados.
    *============================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Cabecalho padrao da Page2 (cinza escuro com titulo)
        loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPag2.cnt_4c_Cabecalho
            .Top         = 31
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
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .Caption   = "Mapa Visual"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .Caption   = "Mapa Visual"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
            ENDWITH
        ENDWITH
    ENDPROC

    *============================================================================
    * AlternarPagina - Alterna a pagina ativa do PageFrame
    *============================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *============================================================================
    * BtnIncluirClick - Handler de inclusao
    * Form sigprico e puramente visual (Mapa Visual com 27 icones): nao possui
    * dados persistidos nem operacoes CRUD. Informa o usuario e retorna sem
    * alterar o estado do formulario.
    *============================================================================
    PROCEDURE BtnIncluirClick()
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas visual " + ;
                 "(Mapa Visual do sistema)." + CHR(13) + ;
                 "N" + CHR(227) + "o h" + CHR(225) + " opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                 "Aviso")
    ENDPROC

    *============================================================================
    * BtnAlterarClick - Handler de alteracao
    * Form sigprico e puramente visual (Mapa Visual com 27 icones): nao possui
    * dados persistidos nem operacoes CRUD. Informa o usuario e retorna sem
    * alterar o estado do formulario.
    *============================================================================
    PROCEDURE BtnAlterarClick()
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas visual " + ;
                 "(Mapa Visual do sistema)." + CHR(13) + ;
                 "N" + CHR(227) + "o h" + CHR(225) + " opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                 "Aviso")
    ENDPROC

    *============================================================================
    * BtnVisualizarClick - Handler de visualizacao
    * Form sigprico ja exibe o Mapa Visual completo em Page1 (27 icones
    * organizados no diagrama). Garante que a pagina de visualizacao esteja
    * ativa e o PageFrame visivel.
    *============================================================================
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual           = "VISUAL"
        ENDIF
    ENDPROC

    *============================================================================
    * BtnExcluirClick - Handler de exclusao
    * Form sigprico e puramente visual (Mapa Visual com 27 icones): nao possui
    * dados persistidos nem operacoes CRUD. Informa o usuario e retorna sem
    * alterar o estado do formulario.
    *============================================================================
    PROCEDURE BtnExcluirClick()
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas visual " + ;
                 "(Mapa Visual do sistema)." + CHR(13) + ;
                 "N" + CHR(227) + "o h" + CHR(225) + " opera" + CHR(231) + CHR(227) + "o de exclus" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                 "Aviso")
    ENDPROC

    *============================================================================
    * CarregarLista - Formulario visual: nao ha lista de dados para carregar
    *============================================================================
    PROTECTED FUNCTION CarregarLista()
        THIS.pgf_4c_Paginas.ActivePage = 1
        RETURN .T.
    ENDFUNC

    *============================================================================
    * AjustarBotoesPorModo - Formulario visual: botoes CRUD ocultos
    *============================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- Form puramente visual: cnt_4c_Botoes permanece oculto (sem CRUD)
        RETURN
    ENDPROC

    *============================================================================
    * HabilitarCampos - Formulario visual: sem campos de entrada
    *============================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Sem controles de entrada de dados
        RETURN
    ENDPROC

    *============================================================================
    * LimparCampos - Formulario visual: sem campos a limpar
    *============================================================================
    PROTECTED PROCEDURE LimparCampos()
        *-- Sem controles de entrada de dados
        RETURN
    ENDPROC

    *============================================================================
    * FormParaBO - Formulario visual: sem campos a transferir para o BO
    *============================================================================
    PROTECTED PROCEDURE FormParaBO()
        *-- Formulario exclusivamente visual: sem propriedades de dados no BO
        RETURN
    ENDPROC

    *============================================================================
    * BOParaForm - Formulario visual: sem campos a popular do BO
    *============================================================================
    PROTECTED PROCEDURE BOParaForm()
        *-- Formulario exclusivamente visual: sem propriedades de dados no BO
        RETURN
    ENDPROC

    *============================================================================
    * BtnBuscarClick - Formulario visual: sem operacao de busca
    *============================================================================
    PROCEDURE BtnBuscarClick()
        *-- Form puramente visual: sem dados para buscar
        RETURN
    ENDPROC

    *============================================================================
    * BtnSalvarClick - Formulario visual: retorna para visualizacao
    *============================================================================
    PROCEDURE BtnSalvarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual           = "VISUAL"
    ENDPROC

    *============================================================================
    * BtnCancelarClick - Formulario visual: retorna para visualizacao
    *============================================================================
    PROCEDURE BtnCancelarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual           = "VISUAL"
    ENDPROC

    *============================================================================
    * BtnEncerrarClick - Fecha o formulario
    *============================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *============================================================================
    * Destroy - Libera recursos ao fechar
    *============================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpricoBO.prg):
*==============================================================================
* sigpricoBO.prg
*
* Business Object para Formsigprico
* Formulario de mapa visual/diagrama operacional
* Sem tabela propria - apenas imagens de navegacao
*==============================================================================

DEFINE CLASS sigpricoBO AS BusinessBase

	*-- Sem propriedades de dados: formulario apenas visual (27 imagens)
	*-- Metodos CRUD implementados como no-op para conformidade com BusinessBase

	*============================================================================
	* Init - Inicializa Business Object
	*============================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela    = ""
		THIS.this_cCampoChave = ""
		RETURN .T.
	ENDPROC

	*============================================================================
	* ObterChavePrimaria - Retorna chave primaria (vazia: sem tabela)
	*============================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ""
	ENDFUNC

	*============================================================================
	* CarregarDoCursor - No-op: form nao tem cursor de dados (apenas imagens)
	*============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nao ha dados para carregar de cursor
		RETURN .T.
	ENDPROC

	*============================================================================
	* Inserir - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao INSERT realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Atualizar - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao UPDATE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* ExecutarExclusao - No-op: form nao persiste dados
	*============================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao DELETE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Buscar - No-op: form nao possui lista de registros
	*============================================================================
	FUNCTION Buscar(par_cFiltro)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma consulta SELECT realizada
		RETURN .T.
	ENDFUNC

	*============================================================================
	* RegistrarAuditoria - No-op: sem operacoes que exijam auditoria
	*============================================================================
	PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nenhuma operacao de dados a auditar
		RETURN
	ENDPROC

ENDDEFINE


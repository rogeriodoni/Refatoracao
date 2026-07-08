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
[01/07/2026 09:30:42 PM] Erro: Erro em CarregarParametros: Connection handle is invalid.
[01/07/2026 09:30:42 PM] Erro: Falha ao carregar parâmetros do sistema.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-01 21:30:28] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-01 21:30:28] [INFO] Config FPW: (nao fornecido)
[2026-07-01 21:30:28] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-01 21:30:28] [INFO] Timeout: 300 segundos
[2026-07-01 21:30:28] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4vobshba.prg
[2026-07-01 21:30:28] [INFO] Conteudo do wrapper:
[2026-07-01 21:30:28] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrApr', 'C:\4c\tasks\task156', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrApr', 'C:\4c\tasks\task156', 'OPERACIONAL'
QUIT

[2026-07-01 21:30:28] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4vobshba.prg
[2026-07-01 21:30:28] [INFO] VFP output esperado em: C:\4c\tasks\task156\vfp_output.txt
[2026-07-01 21:30:28] [INFO] Executando Visual FoxPro 9...
[2026-07-01 21:30:28] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4vobshba.prg
[2026-07-01 21:30:28] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4vobshba.prg
[2026-07-01 21:30:28] [INFO] Timeout configurado: 300 segundos
[2026-07-01 21:30:42] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-01 21:30:42] [INFO] VFP9 finalizado em 14.2816538 segundos
[2026-07-01 21:30:42] [INFO] Exit Code: 
[2026-07-01 21:30:42] [INFO] 
[2026-07-01 21:30:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-01 21:30:42] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4vobshba.prg
[2026-07-01 21:30:42] [INFO] 
[2026-07-01 21:30:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-01 21:30:42] [INFO] * Auto-generated wrapper for parameters
[2026-07-01 21:30:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-01 21:30:42] [INFO] * Parameters: 'FormSigPrApr', 'C:\4c\tasks\task156', 'OPERACIONAL'
[2026-07-01 21:30:42] [INFO] 
[2026-07-01 21:30:42] [INFO] * Anti-dialog protections for unattended execution
[2026-07-01 21:30:42] [INFO] SET SAFETY OFF
[2026-07-01 21:30:42] [INFO] SET RESOURCE OFF
[2026-07-01 21:30:42] [INFO] SET TALK OFF
[2026-07-01 21:30:42] [INFO] SET NOTIFY OFF
[2026-07-01 21:30:42] [INFO] SYS(2335, 0)
[2026-07-01 21:30:42] [INFO] 
[2026-07-01 21:30:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrApr', 'C:\4c\tasks\task156', 'OPERACIONAL'
[2026-07-01 21:30:42] [INFO] QUIT
[2026-07-01 21:30:42] [INFO] 
[2026-07-01 21:30:42] [INFO] === Fim do Wrapper.prg ===
[2026-07-01 21:30:42] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrApr",
  "timestamp": "20260701213042",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg):
*============================================================================
* FormSigPrApr.prg - Reajuste de Precifica" + CHR(231) + CHR(227) + "o
* Tipo: OPERACIONAL
* BO: SigPrAprBO (SigCdPro)
*============================================================================

DEFINE CLASS FormSigPrApr AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    DataSession  = 2
    Themes       = .F.
    ShowWindow   = 1
    FontName     = "Verdana"
    FontSize     = 8

    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_lAllSelected    = .T.
    this_lInCol5         = .F.
    this_nAntValAtu      = 0

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores de trabalho
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursors, loc_nI
        DIMENSION loc_aCursors[5]
        loc_aCursors[1] = "cursor_4c_Produtos"
        loc_aCursors[2] = "cursor_4c_TmpPro"
        loc_aCursors[3] = "cursor_4c_Pam"
        loc_aCursors[4] = "cursor_4c_Pac"
        loc_aCursors[5] = "cursor_4c_Grp"
        FOR loc_nI = 1 TO 5
            IF USED(loc_aCursors[loc_nI])
                USE IN (loc_aCursors[loc_nI])
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Constru" + CHR(231) + CHR(227) + "o do form operacional
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAprBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar SigPrAprBO.", "Erro")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarParametros()
                    MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
                ELSE
                    THIS.this_oBusinessObject.this_lLibValAtu = ;
                        THIS.this_oBusinessObject.VerificarAcessoEdicaoManual()

                    *-- Cursor de produtos para o grid (vazio no inicio)
                    IF USED("cursor_4c_Produtos")
                        USE IN cursor_4c_Produtos
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Produtos ( ;
                        lMarca  N(1)    NULL, ;
                        CPros   C(14)   NULL, ;
                        DPros   C(40)   NULL, ;
                        ValAnt  N(14,2) NULL, ;
                        ValAtu  N(14,2) NULL, ;
                        fCustos N(8,3)  NULL, ;
                        MoePcs  C(3)    NULL, ;
                        CustoFs N(12,3) NULL, ;
                        Manual  N(1)    NULL  ;
                    )
                    SET NULL OFF
                    INDEX ON CPros TAG CPros
                    SELECT cursor_4c_Produtos
                    SET ORDER TO
                    GO TOP

                    *-- Cursor de produtos temp (SigCdPro) vazio
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                    LOCAL loc_nR
                    loc_nR = SQLEXEC(gnConnHandle, ;
                        "SELECT * FROM SigCdPro WHERE 0 = 1", "cursor_4c_TmpPro")
                    IF loc_nR > 0
                        SELECT cursor_4c_TmpPro
                        INDEX ON CPros TAG CPros
                        GO TOP
                    ENDIF

                    THIS.ConfigurarPageFrame()
                    THIS.Caption = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarPaginaDados()

                    THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Visibilidade inicial por tipo (Tipo 1 = Variacao)
                    THIS.AtualizarVisibilidade(1)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Fundo + container cabecalho cinza
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Caption   = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Caption   = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Todos os controles do form operacional
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()

        *----------------------------------------------------------------------
        * CommandGroup: Processar | Atualizar | Encerrar
        *----------------------------------------------------------------------
        THIS.AddObject("cmg_4c_Acao", "CommandGroup")
        WITH THIS.cmg_4c_Acao
            .Top           = 0
            .Left          = 770
            .Width         = 225
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .ButtonCount   = 3
            .Themes        = .F.
            .AutoSize      = .F.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Processar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Atualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Enabled         = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Acao.Buttons(1), "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmg_4c_Acao.Buttons(2), "Click", THIS, "BtnAtualizarClick")
        BINDEVENT(THIS.cmg_4c_Acao.Buttons(3), "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * OptionGroup: Tipo de reajuste
        *----------------------------------------------------------------------
        THIS.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH THIS.opt_4c_Tipo
            .Top           = 134
            .Left          = 159
            .Width         = 208
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 0
            .AutoSize      = .F.
            .ButtonCount   = 3
            .Value         = 1

            WITH .Buttons(1)
                .Left      = 5
                .Top       = 5
                .Width     = 59
                .Height    = 15
                .Caption   = "Varia" + CHR(231) + CHR(227) + "o"
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Left      = 74
                .Top       = 5
                .Height    = 15
                .Caption   = "MarkUp"
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH

            WITH .Buttons(3)
                .Left      = 139
                .Top       = 5
                .Width     = 53
                .Height    = 15
                .Caption   = "C" + CHR(226) + "mbio"
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")

        *----------------------------------------------------------------------
        * Label: "Grupo de Produto :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .Top       = 113
            .Left      = 69
            .Width     = 94
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Grupo de Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Grupo de (codigo)
        THIS.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH THIS.txt_4c_CdGrupo
            .Top           = 109
            .Left          = 165
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_CdGrupo, "DblClick", THIS, "AbrirBuscaCdGrupo")
        BINDEVENT(THIS.txt_4c_CdGrupo, "KeyPress", THIS, "TeclaLookupCdGrupo")

        *-- Label: "at" + CHR(233)
        THIS.AddObject("lbl_4c_Ate", "Label")
        WITH THIS.lbl_4c_Ate
            .Top       = 113
            .Left      = 203
            .Width     = 18
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Grupo ate (codigo)
        THIS.AddObject("txt_4c_AteGrupo", "TextBox")
        WITH THIS.txt_4c_AteGrupo
            .Top           = 109
            .Left          = 228
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_AteGrupo, "DblClick", THIS, "AbrirBuscaAteGrupo")
        BINDEVENT(THIS.txt_4c_AteGrupo, "KeyPress", THIS, "TeclaLookupAteGrupo")

        *-- Label: "Ignorar Componentes" (CheckBox)
        THIS.AddObject("chk_4c_Ignorar", "CheckBox")
        WITH THIS.chk_4c_Ignorar
            .Top       = 112
            .Left      = 609
            .Width     = 123
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Ignorar Componentes"
            .BackStyle = 0
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .ToolTipText = "N" + CHR(227) + "o Checa Se o Produto Est" + CHR(225) + ;
                           " em Uso Como Componente de Outros Produtos"
        ENDWITH

        *-- Label: "Grupo de Venda :" (Colecao)
        THIS.AddObject("lbl_4c_GrupoVd", "Label")
        WITH THIS.lbl_4c_GrupoVd
            .Top       = 113
            .Left      = 399
            .Width     = 86
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Colecao
        THIS.AddObject("txt_4c_Col", "TextBox")
        WITH THIS.txt_4c_Col
            .Top           = 109
            .Left          = 487
            .Width         = 94
            .Height        = 23
            .MaxLength     = 10
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Col, "DblClick", THIS, "AbrirBuscaCol")
        BINDEVENT(THIS.txt_4c_Col, "KeyPress", THIS, "TeclaLookupCol")

        *----------------------------------------------------------------------
        * Label: "Reajuste por :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_TipoLabel", "Label")
        WITH THIS.lbl_4c_TipoLabel
            .Top       = 139
            .Left      = 92
            .Width     = 71
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Reajuste por :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label: "Variacao de Preco :" (Tipo 1)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .Top       = 139
            .Left      = 390
            .Width     = 95
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Variacao (Tipo 1)
        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Top           = 135
            .Left          = 487
            .Width         = 94
            .Height        = 23
            .Alignment     = 3
            .Format        = "K99,999.99"
            .InputMask     = "99,999.99"
            .MaxLength     = 9
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH
        BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "TxtVariacaoLostFocus")

        *-- Label: "%" (Tipo 1)
        THIS.AddObject("lbl_4c_Pct", "Label")
        WITH THIS.lbl_4c_Pct
            .Top       = 139
            .Left      = 585
            .Width     = 13
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- CheckBox: "Incluir Custos" (Tipo 1)
        THIS.AddObject("chk_4c_IncCusts", "CheckBox")
        WITH THIS.chk_4c_IncCusts
            .Top       = 139
            .Left      = 609
            .Width     = 83
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Incluir Custos"
            .BackStyle = 0
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label: "Moeda :" (Tipo 2)
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .Top       = 139
            .Left      = 444
            .Width     = 41
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Moeda (Tipo 2)
        THIS.AddObject("txt_4c_Moeda", "TextBox")
        WITH THIS.txt_4c_Moeda
            .Top           = 135
            .Left          = 487
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moeda, "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(THIS.txt_4c_Moeda, "KeyPress", THIS, "TeclaLookupMoeda")

        *----------------------------------------------------------------------
        * Row 2: Fator de Custo / MarkUp de / para
        *----------------------------------------------------------------------

        *-- Label: "Fator de Custo:" (Tipo 2)
        THIS.AddObject("lbl_4c_Fator", "Label")
        WITH THIS.lbl_4c_Fator
            .Top       = 165
            .Left      = 85
            .Width     = 78
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Fator de Custo:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Fator (Tipo 2)
        THIS.AddObject("txt_4c_Fator", "TextBox")
        WITH THIS.txt_4c_Fator
            .Top           = 161
            .Left          = 165
            .Width         = 73
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "9999.999"
            .MaxLength     = 8
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH

        *-- TextBox: Moeda Custo (Tipo 2)
        THIS.AddObject("txt_4c_MoeCusto", "TextBox")
        WITH THIS.txt_4c_MoeCusto
            .Top           = 161
            .Left          = 241
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderColor   = RGB(90, 90, 90)
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeCusto, "DblClick", THIS, "AbrirBuscaMoeCusto")
        BINDEVENT(THIS.txt_4c_MoeCusto, "KeyPress", THIS, "TeclaLookupMoeCusto")

        *-- Label: "MarkUp :" (Tipo 2)
        THIS.AddObject("lbl_4c_MarkUp", "Label")
        WITH THIS.lbl_4c_MarkUp
            .Top       = 165
            .Left      = 440
            .Width     = 45
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "MarkUp :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MarkUp1 (Tipo 2)
        THIS.AddObject("txt_4c_MarkUp1", "TextBox")
        WITH THIS.txt_4c_MarkUp1
            .Top           = 161
            .Left          = 487
            .Width         = 52
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "999.99"
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH

        *-- Label: "para" (Tipo 2)
        THIS.AddObject("lbl_4c_Para", "Label")
        WITH THIS.lbl_4c_Para
            .Top       = 165
            .Left      = 547
            .Width     = 24
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "para"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MarkUp2 (Tipo 2)
        THIS.AddObject("txt_4c_MarkUp2", "TextBox")
        WITH THIS.txt_4c_MarkUp2
            .Top           = 161
            .Left          = 580
            .Width         = 52
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "999.99"
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH

        *----------------------------------------------------------------------
        * Row 3: Promocao + Limpar
        *----------------------------------------------------------------------

        *-- Label: "Promo" + CHR(231) + CHR(227) + "o :"
        THIS.AddObject("lbl_4c_Promo", "Label")
        WITH THIS.lbl_4c_Promo
            .Top       = 191
            .Left      = 107
            .Width     = 56
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Promo
        THIS.AddObject("txt_4c_Promo", "TextBox")
        WITH THIS.txt_4c_Promo
            .Top           = 187
            .Left          = 165
            .Width         = 185
            .Height        = 23
            .MaxLength     = 25
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Promo, "DblClick", THIS, "AbrirBuscaPromo")
        BINDEVENT(THIS.txt_4c_Promo, "KeyPress", THIS, "TeclaLookupPromo")

        *-- CheckBox: "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
        THIS.AddObject("chk_4c_Limpar", "CheckBox")
        WITH THIS.chk_4c_Limpar
            .Top       = 191
            .Left      = 362
            .Width     = 157
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
            .BackStyle = 0
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *----------------------------------------------------------------------
        * Row 4: Fornecedor
        *----------------------------------------------------------------------

        *-- Label: "Fornecedor :"
        THIS.AddObject("lbl_4c_Forne", "Label")
        WITH THIS.lbl_4c_Forne
            .Top       = 216
            .Left      = 99
            .Width     = 64
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Conta (codigo fornecedor)
        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top           = 213
            .Left          = 165
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Conta, "DblClick", THIS, "AbrirBuscaConta")
        BINDEVENT(THIS.txt_4c_Conta, "KeyPress", THIS, "TeclaLookupConta")

        *-- TextBox: DConta (descricao fornecedor)
        THIS.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.txt_4c_DConta
            .Top           = 213
            .Left          = 248
            .Width         = 290
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_DConta, "DblClick", THIS, "AbrirBuscaDConta")
        BINDEVENT(THIS.txt_4c_DConta, "KeyPress", THIS, "TeclaLookupDConta")

        *----------------------------------------------------------------------
        * Row 5: Moeda Custo Compo / Moeda Preco Ideal / Feitio
        *----------------------------------------------------------------------

        *-- Label: "Moeda Custo Compo. :" (Tipo 2)
        THIS.AddObject("lbl_4c_Moecs", "Label")
        WITH THIS.lbl_4c_Moecs
            .Top       = 244
            .Left      = 51
            .Width     = 112
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Custo Compo. :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Moecs (Tipo 2)
        THIS.AddObject("txt_4c_Moecs", "TextBox")
        WITH THIS.txt_4c_Moecs
            .Top           = 240
            .Left          = 165
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moecs, "DblClick", THIS, "AbrirBuscaMoecs")
        BINDEVENT(THIS.txt_4c_Moecs, "KeyPress", THIS, "TeclaLookupMoecs")

        *-- Label: "Moeda Pre" + CHR(231) + "o Ideal :" (Tipo 2)
        THIS.AddObject("lbl_4c_Moedas", "Label")
        WITH THIS.lbl_4c_Moedas
            .Top       = 244
            .Left      = 320
            .Width     = 98
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Pre" + CHR(231) + "o Ideal :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Moedas (Tipo 2)
        THIS.AddObject("txt_4c_Moedas", "TextBox")
        WITH THIS.txt_4c_Moedas
            .Top           = 240
            .Left          = 420
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moedas, "DblClick", THIS, "AbrirBuscaMoedas")
        BINDEVENT(THIS.txt_4c_Moedas, "KeyPress", THIS, "TeclaLookupMoedas")

        *-- Label: "Feitio :" (Tipo 2)
        THIS.AddObject("lbl_4c_CFtios", "Label")
        WITH THIS.lbl_4c_CFtios
            .Top       = 244
            .Left      = 531
            .Width     = 35
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Feitio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: CFtios (Tipo 2)
        THIS.AddObject("txt_4c_CFtios", "TextBox")
        WITH THIS.txt_4c_CFtios
            .Top           = 240
            .Left          = 568
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_CFtios, "DblClick", THIS, "AbrirBuscaCFtios")
        BINDEVENT(THIS.txt_4c_CFtios, "KeyPress", THIS, "TeclaLookupCFtios")

        *----------------------------------------------------------------------
        * Row 6: Moeda Custo Total / Moeda Preco Atual
        *----------------------------------------------------------------------

        *-- Label: "Moeda Custo Total :" (Tipo 2)
        THIS.AddObject("lbl_4c_MoeCusFs", "Label")
        WITH THIS.lbl_4c_MoeCusFs
            .Top       = 270
            .Left      = 64
            .Width     = 99
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Custo Total :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MoeCusFs (Tipo 2)
        THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
        WITH THIS.txt_4c_MoeCusFs
            .Top           = 266
            .Left          = 165
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeCusFs, "DblClick", THIS, "AbrirBuscaMoeCusFs")
        BINDEVENT(THIS.txt_4c_MoeCusFs, "KeyPress", THIS, "TeclaLookupMoeCusFs")

        *-- Label: "Moeda Pre" + CHR(231) + "o Atual :" (Tipo 2)
        THIS.AddObject("lbl_4c_MoeVs", "Label")
        WITH THIS.lbl_4c_MoeVs
            .Top       = 270
            .Left      = 319
            .Width     = 99
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Pre" + CHR(231) + "o Atual :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MoeVs (Tipo 2)
        THIS.AddObject("txt_4c_MoeVs", "TextBox")
        WITH THIS.txt_4c_MoeVs
            .Top           = 266
            .Left          = 420
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeVs, "DblClick", THIS, "AbrirBuscaMoeVs")
        BINDEVENT(THIS.txt_4c_MoeVs, "KeyPress", THIS, "TeclaLookupMoeVs")

        *----------------------------------------------------------------------
        * CheckBox: Modo manual "Produtos" (chkAuditado)
        *----------------------------------------------------------------------
        THIS.AddObject("chk_4c_Auditado", "CheckBox")
        WITH THIS.chk_4c_Auditado
            .Top           = 307
            .Left          = 763
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .Caption       = "Produtos"
            .Value         = 0
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
        ENDWITH
        BINDEVENT(THIS.chk_4c_Auditado, "Click", THIS, "ChkAuditadoClick")

        *----------------------------------------------------------------------
        * Grid de produtos
        *----------------------------------------------------------------------
        THIS.AddObject("grd_4c_Produtos", "Grid")
        WITH THIS.grd_4c_Produtos
            .Top          = 307
            .Left         = 31
            .Width        = 725
            .Height       = 247
            .FontName     = "Verdana"
            .FontSize     = 8
            .HeaderHeight = 20
            .RowHeight    = 16
            .ScrollBars   = 2
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .GridLines    = 3
            .ColumnCount  = 5

            *-- Column1: CheckBox de selecao (lMarca)
            WITH .Column1
                .Width         = 20
                .Alignment     = 3
                .Movable       = .F.
                .Resizable     = .F.
                .Sparse        = .F.
                .FontName      = "Verdana"
                .FontSize      = 8
                .Header1.Caption   = ""
                .Header1.Picture   = gc_4c_CaminhoIcones + "checkbx.bmp"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column2: Codigo do produto (CPros)
            WITH .Column2
                .Width             = 108
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column3: Descricao (DPros)
            WITH .Column3
                .Width             = 350
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column4: Preco Anterior (ValAnt)
            WITH .Column4
                .Width             = 100
                .Alignment         = 1
                .Movable           = .F.
                .Resizable         = .F.
                .InputMask         = "999,999,999.99"
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Caption   = "Pre" + CHR(231) + "o Anterior"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column5: Preco Atual (ValAtu) - editavel se VMANUAL
            WITH .Column5
                .Width             = 111
                .Alignment         = 1
                .Movable           = .F.
                .Resizable         = .F.
                .InputMask         = "999,999,999.99"
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH
        ENDWITH

        *-- CheckBox em Column1 DEVE ser adicionado ANTES do ControlSource (regra Error 1767)
        THIS.grd_4c_Produtos.Column1.AddObject("Check1", "CheckBox")
        THIS.grd_4c_Produtos.Column1.Check1.Caption = ""
        THIS.grd_4c_Produtos.Column1.Check1.Value   = 0
        THIS.grd_4c_Produtos.Column1.CurrentControl = "Check1"

        *-- Define RecordSource FORA do WITH para evitar auto-bind sobrescrever ControlSources
        THIS.grd_4c_Produtos.ColumnCount = 5
        THIS.grd_4c_Produtos.RecordSource = "cursor_4c_Produtos"
        THIS.grd_4c_Produtos.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
        THIS.grd_4c_Produtos.Column2.ControlSource = "cursor_4c_Produtos.CPros"
        THIS.grd_4c_Produtos.Column3.ControlSource = "cursor_4c_Produtos.DPros"
        THIS.grd_4c_Produtos.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
        THIS.grd_4c_Produtos.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"

        *-- Caption e ReadOnly do Column5 conforme acesso VMANUAL
        LOCAL loc_lLibValAtu
        loc_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu
        IF loc_lLibValAtu
            THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
            THIS.grd_4c_Produtos.Column5.ReadOnly = .F.
        ELSE
            THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
            THIS.grd_4c_Produtos.Column5.Header1.Picture = gc_4c_CaminhoIcones + "lock.bmp"
            THIS.grd_4c_Produtos.Column5.ReadOnly = .T.
        ENDIF

        *-- Column2 come?a ReadOnly (modo normal; auditor inverte)
        THIS.grd_4c_Produtos.Column2.ReadOnly = .T.

        BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GrdAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Produtos.Column1.Header1, "Click", THIS, "GrdHeaderClick")

        *----------------------------------------------------------------------
        * Shape e Image para foto do produto
        *----------------------------------------------------------------------
        THIS.AddObject("shp_4c_Foto", "Shape")
        WITH THIS.shp_4c_Foto
            .Top          = 414
            .Left         = 763
            .Width        = 205
            .Height       = 140
            .BackStyle    = 0
            .BorderStyle  = 1
            .FillStyle    = 1
            .SpecialEffect = 1
            .BorderColor  = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("img_4c_Foto", "Image")
        WITH THIS.img_4c_Foto
            .Top     = 415
            .Left    = 764
            .Width   = 203
            .Height  = 138
            .Stretch = 1
            .Visible = .F.
        ENDWITH

    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL nao usa Page2; metodo requerido
    * pela hierarquia FormBase mas sem conteudo aplicavel aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * AlternarPagina - Reset da area operacional (limpa grid, filtros e foco)
    *   par_nPagina = 1 -> reset completo (equivalente a nova consulta)
    *   par_nPagina = 2 -> apenas limpar grid e desabilitar Atualizar
    * OPERACIONAL nao possui Page1/Page2; AlternarPagina age como reset de
    * estado, retornando o form ao ponto inicial de trabalho.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nModo
        loc_nModo = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)

        *-- Zera o cursor do grid de produtos
        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            IF RECCOUNT() > 0
                ZAP
            ENDIF
        ENDIF

        *-- Desabilita o botao Atualizar (fica ativo apenas apos Processar)
        IF VARTYPE(THIS.cmg_4c_Acao) = "O"
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
            THIS.cmg_4c_Acao.Buttons(2).Refresh
        ENDIF

        *-- Reseta selecao global do header (checkbox da coluna 1)
        THIS.this_lAllSelected = .T.
        THIS.this_lInCol5      = .F.
        THIS.this_nAntValAtu   = 0

        IF loc_nModo = 1
            *-- Reset COMPLETO: limpa TODOS os campos de filtro/parametros
            IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
                THIS.txt_4c_CdGrupo.Value  = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
                THIS.txt_4c_AteGrupo.Value = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Col)      = "O"
                THIS.txt_4c_Col.Value      = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Conta)    = "O"
                THIS.txt_4c_Conta.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_DConta)   = "O"
                THIS.txt_4c_DConta.Value   = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Variacao) = "O"
                THIS.txt_4c_Variacao.Value = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
                THIS.txt_4c_Moeda.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
                THIS.txt_4c_MarkUp1.Value  = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
                THIS.txt_4c_MarkUp2.Value  = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Fator)    = "O"
                THIS.txt_4c_Fator.Value    = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
                THIS.txt_4c_MoeCusto.Value = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Moecs)    = "O"
                THIS.txt_4c_Moecs.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_MoeCusFs) = "O"
                THIS.txt_4c_MoeCusFs.Value = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Moedas)   = "O"
                THIS.txt_4c_Moedas.Value   = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_CFtios)   = "O"
                THIS.txt_4c_CFtios.Value   = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_MoeVs)    = "O"
                THIS.txt_4c_MoeVs.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Promo)    = "O"
                THIS.txt_4c_Promo.Value    = ""
            ENDIF
            IF VARTYPE(THIS.chk_4c_Ignorar)  = "O"
                THIS.chk_4c_Ignorar.Value  = 0
            ENDIF
            IF VARTYPE(THIS.chk_4c_IncCusts) = "O"
                THIS.chk_4c_IncCusts.Value = 0
            ENDIF
            IF VARTYPE(THIS.chk_4c_Limpar)   = "O"
                THIS.chk_4c_Limpar.Value   = 0
            ENDIF
            IF VARTYPE(THIS.chk_4c_Auditado) = "O"
                THIS.chk_4c_Auditado.Value = 0
            ENDIF

            *-- Volta tipo de reajuste para 1 (Variacao) e atualiza visibilidade
            IF VARTYPE(THIS.opt_4c_Tipo) = "O"
                THIS.opt_4c_Tipo.Value = 1
                THIS.AtualizarVisibilidade(1)
            ENDIF

            *-- Esconde foto de produto (controlada por GrdAfterRowColChange)
            IF PEMSTATUS(THIS, "img_4c_Foto", 5) AND VARTYPE(THIS.img_4c_Foto) = "O"
                THIS.img_4c_Foto.Visible = .F.
                THIS.img_4c_Foto.Picture = ""
            ENDIF

            *-- Foco no primeiro campo de filtro (Grupo de Produto)
            IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
                THIS.txt_4c_CdGrupo.SetFocus
            ENDIF
        ENDIF

        *-- Refresca a grid e o form
        IF VARTYPE(THIS.grd_4c_Produtos) = "O"
            THIS.grd_4c_Produtos.Refresh
        ENDIF
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, respeita a regra de recursao antes do LOOP
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto
        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
                *-- img_4c_Foto comeca oculta; controlada por GrdAfterRowColChange
                *-- cnt_4c_Sombra permanece Visible=.F.; visibilidade controlada externamente
                IF INLIST(UPPER(loc_oObjeto.Name), "IMG_4C_FOTO", "CNT_4C_SOMBRA")
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AtualizarVisibilidade - Mostra/oculta controles pelo tipo de reajuste
    *==========================================================================
    PROCEDURE AtualizarVisibilidade(par_nTipo)
        LOCAL loc_lTipo1, loc_lTipo2

        loc_lTipo1 = (par_nTipo = 1)
        loc_lTipo2 = (par_nTipo = 2)

        *-- Tipo 1: Variacao
        THIS.lbl_4c_Variacao.Visible = loc_lTipo1
        THIS.txt_4c_Variacao.Visible = loc_lTipo1
        THIS.lbl_4c_Pct.Visible      = loc_lTipo1
        THIS.chk_4c_IncCusts.Visible = loc_lTipo1

        *-- Tipo 2: MarkUp
        THIS.lbl_4c_Moeda.Visible    = loc_lTipo2
        THIS.txt_4c_Moeda.Visible    = loc_lTipo2
        THIS.lbl_4c_MarkUp.Visible   = loc_lTipo2
        THIS.txt_4c_MarkUp1.Visible  = loc_lTipo2
        THIS.lbl_4c_Para.Visible     = loc_lTipo2
        THIS.txt_4c_MarkUp2.Visible  = loc_lTipo2
        THIS.lbl_4c_Fator.Visible    = loc_lTipo2
        THIS.txt_4c_Fator.Visible    = loc_lTipo2
        THIS.txt_4c_MoeCusto.Visible = loc_lTipo2
        THIS.lbl_4c_Moecs.Visible    = loc_lTipo2
        THIS.txt_4c_Moecs.Visible    = loc_lTipo2
        THIS.lbl_4c_MoeCusFs.Visible = loc_lTipo2
        THIS.txt_4c_MoeCusFs.Visible = loc_lTipo2
        THIS.lbl_4c_Moedas.Visible   = loc_lTipo2
        THIS.txt_4c_Moedas.Visible   = loc_lTipo2
        THIS.lbl_4c_CFtios.Visible   = loc_lTipo2
        THIS.txt_4c_CFtios.Visible   = loc_lTipo2
        THIS.lbl_4c_MoeVs.Visible    = loc_lTipo2
        THIS.txt_4c_MoeVs.Visible    = loc_lTipo2

        THIS.Refresh
    ENDPROC

    *==========================================================================
    * OptTipoInteractiveChange - Atualiza visibilidade ao mudar tipo
    *==========================================================================
    PROCEDURE OptTipoInteractiveChange()
        THIS.AtualizarVisibilidade(THIS.opt_4c_Tipo.Value)
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Coleta campos, chama ProcessarReajuste()
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF

        *-- Transfere campos do form para o BO
        loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
        loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
        loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
        loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
        loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
        loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
        loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
        loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
        loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
        loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
        loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
        loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
        loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
        loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
        loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
        loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
        loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
        loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
        loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
        loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
        loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
        loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value

        IF loc_oBO.ProcessarReajuste()
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
            THIS.grd_4c_Produtos.Column1.SetFocus
            THIS.grd_4c_Produtos.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAtualizarClick - Chama AtualizarPrecos(), desabilita Atualizar
    *==========================================================================
    PROCEDURE BtnAtualizarClick()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF
        IF loc_oBO.AtualizarPrecos()
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
            THIS.cmg_4c_Acao.Buttons(2).Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o form
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release
    ENDPROC

    *==========================================================================
    * TxtVariacaoLostFocus - Move foco para Processar ao sair do campo
    *==========================================================================
    PROCEDURE TxtVariacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.cmg_4c_Acao.Buttons(1).SetFocus
    ENDPROC

    *==========================================================================
    * GrdHeaderClick - Alterna selecao de todos os produtos (lMarca)
    *==========================================================================
    PROCEDURE GrdHeaderClick()
        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF
        IF THIS.this_lAllSelected
            UPDATE cursor_4c_Produtos SET lMarca = 0
            THIS.this_lAllSelected = .F.
        ELSE
            UPDATE cursor_4c_Produtos SET lMarca = 1
            THIS.this_lAllSelected = .T.
        ENDIF
        THIS.grd_4c_Produtos.Refresh
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * GrdAfterRowColChange - Manual tracking + auditor lookup + foto produto
    * par_nColIndex = coluna que acabou de ser ENTADA (nova coluna ativa)
    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        LOCAL loc_lcArqFig, loc_nResult, loc_lcFoto, loc_cCPros

        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF
        SELECT cursor_4c_Produtos

        *-- Rastreia edicao manual de ValAtu (Column5): detecta saida da coluna
        IF par_nColIndex != 5 AND THIS.this_lInCol5
            IF !EOF("cursor_4c_Produtos") AND ;
               NVL(cursor_4c_Produtos.ValAtu, 0) != THIS.this_nAntValAtu
                REPLACE Manual WITH 1 IN cursor_4c_Produtos
                *-- Em modo LibValAtu: adiciona linha vazia no fundo se ultimo item tem produto
                *-- Equivale ao Column5.Text1.Valid do legado (Insert From MemVar + DNARROW)
                IF THIS.this_oBusinessObject.this_lLibValAtu
                    SET ORDER TO
                    GO BOTTOM
                    IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
                        INSERT INTO cursor_4c_Produtos ;
                            (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
                            VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, SPACE(3), 0, 0)
                    ENDIF
                    THIS.grd_4c_Produtos.Refresh
                ENDIF
            ENDIF
            THIS.this_lInCol5 = .F.
        ENDIF
        IF par_nColIndex = 5 AND !EOF("cursor_4c_Produtos")
            THIS.this_nAntValAtu = NVL(cursor_4c_Produtos.ValAtu, 0)
            THIS.this_lInCol5    = .T.
        ENDIF

        *-- Modo auditado: ao sair de Column2 com codigo preenchido, carrega produto
        IF par_nColIndex != 2 AND THIS.chk_4c_Auditado.Value = 1 ;
            AND !EOF("cursor_4c_Produtos")
            loc_cCPros = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
            IF !EMPTY(loc_cCPros)
                THIS.CarregarProdutoAuditado(loc_cCPros)
            ENDIF
        ENDIF

        *-- Carrega foto do produto atual
        IF !EOF("cursor_4c_Produtos") AND !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
            loc_lcArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
            IF USED("cursor_4c_FigTmp")
                USE IN cursor_4c_FigTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros)), ;
                "cursor_4c_FigTmp")
            THIS.img_4c_Foto.Visible = .F.
            THIS.img_4c_Foto.Picture = ""
            IF loc_nResult > 0 AND !EOF("cursor_4c_FigTmp")
                SELECT cursor_4c_FigTmp
                IF !ISNULL(cursor_4c_FigTmp.FigJpgs) AND ;
                   !EMPTY(ALLTRIM(NVL(cursor_4c_FigTmp.FigJpgs, "")))
                    CLEAR RESOURCES
                    loc_lcFoto = STRCONV( ;
                        STRTRAN(STRTRAN(STRTRAN( ;
                            cursor_4c_FigTmp.FigJpgs, ;
                            "data:image/png;base64,",  ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,",  ""), 14)
                    STRTOFILE(loc_lcFoto, loc_lcArqFig)
                    THIS.img_4c_Foto.Picture = loc_lcArqFig
                    THIS.img_4c_Foto.Visible = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_FigTmp")
                USE IN cursor_4c_FigTmp
            ENDIF
        ELSE
            THIS.img_4c_Foto.Visible = .F.
            THIS.img_4c_Foto.Picture = ""
        ENDIF

        SELECT cursor_4c_Produtos
    ENDPROC

    *==========================================================================
    * CarregarProdutoAuditado - Modo auditado: busca produto e calcula preco
    * Chamado por GrdAfterRowColChange ao sair de Column2 com um codigo
    *==========================================================================
    PROCEDURE CarregarProdutoAuditado(par_cCPros)
        LOCAL loc_nResult, loc_nTipo, loc_nVariacao, loc_nMarkUp2
        LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen

        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN
        ENDIF

        *-- Busca produto em SigCdPro e adiciona a cursor_4c_TmpPro
        IF USED("cursor_4c_ProdAud")
            USE IN cursor_4c_ProdAud
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
            "cursor_4c_ProdAud")
        IF loc_nResult < 1 OR EOF("cursor_4c_ProdAud")
            IF USED("cursor_4c_ProdAud")
                USE IN cursor_4c_ProdAud
            ENDIF
            THIS.AbrirBuscaProdutoGrd()
            RETURN
        ENDIF

        *-- Insere no cursor_4c_TmpPro se ainda nao existe
        IF USED("cursor_4c_TmpPro")
            IF !SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
                SELECT cursor_4c_ProdAud
                GO TOP
                LOCAL loc_oErroIns
                TRY
                    SELECT cursor_4c_TmpPro
                    APPEND BLANK
                    *-- Copia campos essenciais manualmente (SCATTER/GATHER pode falhar entre cursores)
                    REPLACE CPros    WITH ALLTRIM(cursor_4c_ProdAud.CPros)
                    REPLACE DPros    WITH ALLTRIM(NVL(cursor_4c_ProdAud.DPros,    ""))
                    REPLACE PVens    WITH NVL(cursor_4c_ProdAud.PVens,    0)
                    REPLACE PVIdeals WITH NVL(cursor_4c_ProdAud.PVIdeals, 0)
                    REPLACE PCuss    WITH NVL(cursor_4c_ProdAud.PCuss,    0)
                    REPLACE CustoFs  WITH NVL(cursor_4c_ProdAud.CustoFs,  0)
                    REPLACE fCustos  WITH NVL(cursor_4c_ProdAud.fCustos,  0)
                    REPLACE Margems  WITH NVL(cursor_4c_ProdAud.Margems,  0)
                    REPLACE MoeVs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeVs,    ""))
                    REPLACE MoeCs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCs,    ""))
                    REPLACE MoePcs   WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoePcs,   ""))
                    REPLACE MoeCusFs WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCusFs, ""))
                    REPLACE Moedas   WITH ALLTRIM(NVL(cursor_4c_ProdAud.Moedas,   ""))
                    REPLACE MFtios   WITH ALLTRIM(NVL(cursor_4c_ProdAud.MFtios,   ""))
                    REPLACE PFtios   WITH NVL(cursor_4c_ProdAud.PFtios,   0)
                    REPLACE PesoMs   WITH NVL(cursor_4c_ProdAud.PesoMs,   0)
                    REPLACE Encargos WITH NVL(cursor_4c_ProdAud.Encargos, 0)
                    REPLACE CGrus    WITH ALLTRIM(NVL(cursor_4c_ProdAud.CGrus,    ""))
                CATCH TO loc_oErroIns
                    MsgErro("Erro ao inserir produto no buffer: " + loc_oErroIns.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        *-- Calcula novo preco conforme tipo
        IF USED("cursor_4c_TmpPro") AND SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
            SELECT cursor_4c_TmpPro
            GO TOP
            loc_nTipo     = THIS.opt_4c_Tipo.Value
            loc_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
            loc_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)

            DO CASE
            CASE loc_nTipo = 1
                loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0) + ;
                              (NVL(cursor_4c_TmpPro.PVens, 0) * loc_nVariacao / 100)
            CASE loc_nTipo = 2
                loc_nValAtu = THIS.this_oBusinessObject.CalcPreco(loc_nMarkUp2)
            CASE loc_nTipo = 3
                loc_nCotId = fBuscarCotacao( ;
                    ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), DATE(), gnConnHandle)
                loc_nCotVd = fBuscarCotacao( ;
                    ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")),  DATE(), gnConnHandle)
                loc_nPVen  = NVL(cursor_4c_TmpPro.PVIdeals, 0) * ;
                             IIF(loc_nCotVd <> 0, loc_nCotId / loc_nCotVd, 0)
                loc_nVlVen = IIF(NVL(cursor_4c_TmpPro.Encargos, 0) <> 0, ;
                                 loc_nPVen / cursor_4c_TmpPro.Encargos, loc_nPVen)
                loc_nValAtu = loc_nVlVen
            OTHERWISE
                loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0)
            ENDCASE

            *-- Atualiza registro corrente em cursor_4c_Produtos
            SELECT cursor_4c_Produtos
            REPLACE CPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.CPros, ""))
            REPLACE DPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.DPros, ""))
            REPLACE ValAnt  WITH NVL(cursor_4c_TmpPro.PVens,  0)
            REPLACE ValAtu  WITH loc_nValAtu
            REPLACE lMarca  WITH 1
            REPLACE Manual  WITH 0
            REPLACE fCustos WITH NVL(cursor_4c_TmpPro.fCustos, 0)
            REPLACE CustoFs WITH NVL(cursor_4c_TmpPro.CustoFs, 0)
            REPLACE MoePcs  WITH ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, ""))

            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.

            *-- Adiciona linha vazia abaixo se nao houver
            IF !THIS.this_oBusinessObject.this_lLibValAtu
                SELECT cursor_4c_Produtos
                SET ORDER TO
                GO BOTTOM
                IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
                    INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
                        VALUES (0, SPACE(14), SPACE(40), 0, 0)
                ENDIF
                SELECT cursor_4c_Produtos
                THIS.grd_4c_Produtos.Refresh
            ENDIF
        ENDIF

        IF USED("cursor_4c_ProdAud")
            USE IN cursor_4c_ProdAud
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkAuditadoClick - Alterna modo de entrada manual de produtos
    *==========================================================================
    PROCEDURE ChkAuditadoClick()
        IF THIS.chk_4c_Auditado.Value = 1
            *-- Modo auditado: limpa grid, Column2 editavel, Column1 readonly
            IF USED("cursor_4c_Produtos")
                LOCAL loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v
                loc_lMarca_v = 0
                loc_cCPros_v = SPACE(14)
                loc_cDPros_v = SPACE(40)
                loc_nValAtu_v = 0
                loc_nValAnt_v = 0
                INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
                    VALUES (loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v)
                SELECT cursor_4c_Produtos
                SET ORDER TO
                GO TOP
            ENDIF
            THIS.txt_4c_CdGrupo.Enabled  = .F.
            THIS.txt_4c_AteGrupo.Enabled = .F.
            THIS.txt_4c_Col.Enabled      = .F.
            THIS.txt_4c_Moeda.Enabled    = .F.
            THIS.txt_4c_MarkUp1.Enabled  = .F.
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
            THIS.grd_4c_Produtos.Column1.ReadOnly = .T.
            THIS.grd_4c_Produtos.Column2.ReadOnly = .F.
            THIS.grd_4c_Produtos.Column2.SetFocus
            THIS.grd_4c_Produtos.Refresh
        ELSE
            *-- Modo normal: limpa grid, Column2 readonly, Column1 editavel
            IF USED("cursor_4c_Produtos")
                DELETE FROM cursor_4c_Produtos
            ENDIF
            THIS.txt_4c_CdGrupo.Enabled  = .T.
            THIS.txt_4c_AteGrupo.Enabled = .T.
            THIS.txt_4c_Col.Enabled      = .T.
            THIS.txt_4c_Moeda.Enabled    = .T.
            THIS.txt_4c_MarkUp1.Enabled  = .T.
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
            THIS.grd_4c_Produtos.Column1.ReadOnly = .F.
            THIS.grd_4c_Produtos.Column2.ReadOnly = .T.
            SELECT cursor_4c_Produtos
            SET ORDER TO CPros
            GO TOP
            THIS.grd_4c_Produtos.Refresh
            THIS.txt_4c_CdGrupo.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup helpers
    *==========================================================================

    *-- Helper generico para SigCdMoe
    PROTECTED PROCEDURE BuscarMoedaHelper(par_oTxt)
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, "Moedas")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CMoes",  "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DMoes",  "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * Lookups - SigCdGrp (CdGrupo)
    *==========================================================================
    PROCEDURE AbrirBuscaCdGrupo()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
            "Grupos de Produto")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
            IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
                THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
            ENDIF
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
                    THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
                ENDIF
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCdGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdGrupo()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValGrp")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
            THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
            IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
                THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
            ENDIF
        ELSE
            MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
            THIS.txt_4c_CdGrupo.Value = ""
            THIS.AbrirBuscaCdGrupo()
        ENDIF
        IF USED("cursor_4c_ValGrp")
            USE IN cursor_4c_ValGrp
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdGrp (AteGrupo)
    *==========================================================================
    PROCEDURE AbrirBuscaAteGrupo()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
            "Grupos de Produto")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupAteGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaAteGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarAteGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarAteGrupo()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValGrp")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
            THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
        ELSE
            MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
            THIS.txt_4c_AteGrupo.Value = ""
            THIS.AbrirBuscaAteGrupo()
        ENDIF
        IF USED("cursor_4c_ValGrp")
            USE IN cursor_4c_ValGrp
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdCol
    *==========================================================================
    PROCEDURE AbrirBuscaCol()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Col.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cValor, ;
            "Cole" + CHR(231) + CHR(245) + "es")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descs",    "",           "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaCol")
            USE IN cursor_4c_BuscaCol
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupCol(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCol()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCol()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCol()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Col.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT Colecoes FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValCol")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValCol")
            THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_ValCol.Colecoes)
        ELSE
            MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_Col.Value = ""
            THIS.AbrirBuscaCol()
        ENDIF
        IF USED("cursor_4c_ValCol")
            USE IN cursor_4c_ValCol
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (Moeda - Tipo 2)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeda()
        THIS.BuscarMoedaHelper(THIS.txt_4c_Moeda)
    ENDPROC

    PROCEDURE TeclaLookupMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeda()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeda()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moeda.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_Moeda.Value = ""
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (Moecs)
    *==========================================================================
    PROCEDURE AbrirBuscaMoecs()
        THIS.BuscarMoedaHelper(THIS.txt_4c_Moecs)
    ENDPROC

    PROCEDURE TeclaLookupMoecs(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoecs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoecs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoecs()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moecs.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_Moecs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_Moecs.Value = ""
            THIS.AbrirBuscaMoecs()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (MoeCusFs)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeCusFs()
        THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusFs)
    ENDPROC

    PROCEDURE TeclaLookupMoeCusFs(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeCusFs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCusFs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeCusFs()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_MoeCusFs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_MoeCusFs.Value = ""
            THIS.AbrirBuscaMoeCusFs()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (Moedas = Moeda Preco Ideal)
    *==========================================================================
    PROCEDURE AbrirBuscaMoedas()
        THIS.BuscarMoedaHelper(THIS.txt_4c_Moedas)
    ENDPROC

    PROCEDURE TeclaLookupMoedas(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoedas()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedas()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoedas()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moedas.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_Moedas.Value = ""
            THIS.AbrirBuscaMoedas()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (MoeCusto = Moeda do Custo)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeCusto()
        THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusto)
    ENDPROC

    PROCEDURE TeclaLookupMoeCusto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeCusto()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCusto()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeCusto()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_MoeCusto.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_MoeCusto.Value = ""
            THIS.AbrirBuscaMoeCusto()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (MoeVs = Moeda Preco Atual)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeVs()
        THIS.BuscarMoedaHelper(THIS.txt_4c_MoeVs)
    ENDPROC

    PROCEDURE TeclaLookupMoeVs(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeVs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeVs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeVs()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_MoeVs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_MoeVs.Value = ""
            THIS.AbrirBuscaMoeVs()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigPrFti (CFtios = Feitio)
    *==========================================================================
    PROCEDURE AbrirBuscaCFtios()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrFti", "cursor_4c_BuscaFtio", "Cods", loc_cValor, "Feitio")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Cods",  "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descs", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
                THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaFtio")
            USE IN cursor_4c_BuscaFtio
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupCFtios(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCFtios()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCFtios()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCFtios()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT Cods FROM SigPrFti WHERE Cods = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValFtio")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValFtio")
            THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_ValFtio.Cods)
        ELSE
            MsgAviso("Feitio n" + CHR(227) + "o encontrado.", "")
            THIS.txt_4c_CFtios.Value = ""
            THIS.AbrirBuscaCFtios()
        ENDIF
        IF USED("cursor_4c_ValFtio")
            USE IN cursor_4c_ValFtio
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - Fornecedor via fAcessoContas (Conta / DConta)
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        fAcessoContas(gc_4c_UsuarioLogado, ;
                      THIS.this_oBusinessObject.this_cGrPadFors, ;
                      "C", THIS.txt_4c_Conta.Value, ;
                      THIS.txt_4c_Conta, THIS.txt_4c_DConta)
    ENDPROC

    PROCEDURE TeclaLookupConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarConta()
        IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")))
            IF !fAcessoContas(gc_4c_UsuarioLogado, ;
                              THIS.this_oBusinessObject.this_cGrPadFors, ;
                              "C", THIS.txt_4c_Conta.Value, ;
                              THIS.txt_4c_Conta, THIS.txt_4c_DConta)
                MsgAviso("Acesso Negado !!!", "")
                THIS.txt_4c_Conta.Value  = ""
                THIS.txt_4c_DConta.Value = ""
            ENDIF
        ELSE
            THIS.txt_4c_DConta.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDConta()
        fAcessoContas(gc_4c_UsuarioLogado, ;
                      THIS.this_oBusinessObject.this_cGrPadFors, ;
                      "D", THIS.txt_4c_DConta.Value, ;
                      THIS.txt_4c_Conta, THIS.txt_4c_DConta)
    ENDPROC

    PROCEDURE TeclaLookupDConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarDConta()
        IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_DConta.Value, "")))
            IF !fAcessoContas(gc_4c_UsuarioLogado, ;
                              THIS.this_oBusinessObject.this_cGrPadFors, ;
                              "D", THIS.txt_4c_DConta.Value, ;
                              THIS.txt_4c_Conta, THIS.txt_4c_DConta)
                MsgAviso("Acesso Negado !!!", "")
                THIS.txt_4c_DConta.Value = ""
                THIS.txt_4c_Conta.Value  = ""
            ENDIF
        ELSE
            THIS.txt_4c_Conta.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigPrPmc (Promo)
    *==========================================================================
    PROCEDURE AbrirBuscaPromo()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Promo.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrPmc", "cursor_4c_BuscaPmc", "Promos", loc_cValor, ;
            "Promo" + CHR(231) + CHR(227) + "o")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPmc")
                THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaPmc")
            USE IN cursor_4c_BuscaPmc
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupPromo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaPromo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarPromo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarPromo()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Promo.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValPmc")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValPmc")
            THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_ValPmc.Promos)
        ELSE
            MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
            THIS.txt_4c_Promo.Value = ""
            THIS.AbrirBuscaPromo()
        ENDIF
        IF USED("cursor_4c_ValPmc")
            USE IN cursor_4c_ValPmc
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia novo ciclo: limpa grid e parametros (equivale a
    *   "nova busca" no contexto operacional de reajuste de precificacao)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
                THIS.txt_4c_CdGrupo.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Reprocessa com os parametros atuais sem limpar filtros
    *   (equivale a "recalcular" preservando selecao atual do grid)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) # "O"
                RETURN
            ENDIF
            *-- Transfere campos do form para o BO (mesmo fluxo de Processar)
            loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
            loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
            loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
            loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
            loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
            loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
            loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
            loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
            loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
            loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
            loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
            loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
            loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
            loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
            loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
            loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
            loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
            loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
            loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
            loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
            loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
            loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value
            IF loc_oBO.ProcessarReajuste()
                THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
                THIS.grd_4c_Produtos.Column1.SetFocus
                THIS.grd_4c_Produtos.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe o estado atual do grid (precos antes x depois)
    *   Atualiza o grid a partir do cursor sem reprocessar
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                SELECT cursor_4c_Produtos
                GO TOP
                THIS.grd_4c_Produtos.Refresh
                THIS.Refresh
            ELSE
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " produtos processados " + ;
                         "para visualizar. Execute o Processar primeiro.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa apenas o grid de produtos sem resetar os filtros
    *   Permite reprocessar com os mesmos parametros mas lista limpa
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                RETURN
            ENDIF
            loc_lConfirma = MsgConfirma("Limpar a lista de produtos processados?", ;
                                        "Confirmar")
            IF loc_lConfirma
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaProdutoGrd - Lookup de produto para modo auditado (Column2)
    * Equivalente ao fwbuscaext do Column2.Text1.Valid no legado.
    *==========================================================================
    PROCEDURE AbrirBuscaProdutoGrd()
        LOCAL loc_cValAtual, loc_oForm, loc_cSelecionado

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF
        SELECT cursor_4c_Produtos
        loc_cValAtual = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValAtual, ;
            "Produtos")
        IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        loc_cSelecionado = ""
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPro")
            loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.CPros)
        ENDIF
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF

        IF !EMPTY(loc_cSelecionado)
            SELECT cursor_4c_Produtos
            REPLACE CPros WITH loc_cSelecionado
            THIS.grd_4c_Produtos.Refresh
            THIS.CarregarProdutoAuditado(loc_cSelecionado)
        ELSE
            SELECT cursor_4c_Produtos
            IF !EOF("cursor_4c_Produtos")
                REPLACE CPros WITH SPACE(14)
            ENDIF
            THIS.grd_4c_Produtos.Refresh
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere todos os campos do form para propriedades do BO
    * Usado por BtnProcessarClick e BtnAlterarClick para evitar duplicacao
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF
        loc_oBO.this_nTipo     = THIS.opt_4c_Tipo.Value
        loc_oBO.this_cCdGrupo  = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
        loc_oBO.this_cAteGrupo = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
        loc_oBO.this_cCol      = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
        loc_oBO.this_cConta    = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
        loc_oBO.this_cDConta   = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
        loc_oBO.this_nIgnorar  = THIS.chk_4c_Ignorar.Value
        loc_oBO.this_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
        loc_oBO.this_nIncCusts = THIS.chk_4c_IncCusts.Value
        loc_oBO.this_cMoeda    = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
        loc_oBO.this_nMarkUp1  = NVL(THIS.txt_4c_MarkUp1.Value,  0)
        loc_oBO.this_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)
        loc_oBO.this_nFator    = NVL(THIS.txt_4c_Fator.Value,    0)
        loc_oBO.this_cMoeCusto = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
        loc_oBO.this_cMoecs    = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
        loc_oBO.this_cMoeCusFs = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
        loc_oBO.this_cMoedas   = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
        loc_oBO.this_cCFtios   = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
        loc_oBO.this_cMoeVs    = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
        loc_oBO.this_cPromo    = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
        loc_oBO.this_nLimpar   = THIS.chk_4c_Limpar.Value
        loc_oBO.this_nAuditado = THIS.chk_4c_Auditado.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega propriedades do BO de volta para os campos do form
    * Util apos recarregar estado do BO ou em modo auditado
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.opt_4c_Tipo)     = "O"
            THIS.opt_4c_Tipo.Value     = loc_oBO.this_nTipo
            THIS.AtualizarVisibilidade(loc_oBO.this_nTipo)
        ENDIF
        IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
            THIS.txt_4c_CdGrupo.Value  = ALLTRIM(loc_oBO.this_cCdGrupo)
        ENDIF
        IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
            THIS.txt_4c_AteGrupo.Value = ALLTRIM(loc_oBO.this_cAteGrupo)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Col)      = "O"
            THIS.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cCol)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta)    = "O"
            THIS.txt_4c_Conta.Value    = ALLTRIM(loc_oBO.this_cConta)
        ENDIF
        IF VARTYPE(THIS.txt_4c_DConta)   = "O"
            THIS.txt_4c_DConta.Value   = ALLTRIM(loc_oBO.this_cDConta)
        ENDIF
        IF VARTYPE(THIS.chk_4c_Ignorar)  = "O"
            THIS.chk_4c_Ignorar.Value  = loc_oBO.this_nIgnorar
        ENDIF
        IF VARTYPE(THIS.txt_4c_Variacao) = "O"
            THIS.txt_4c_Variacao.Value = loc_oBO.this_nVariacao
        ENDIF
        IF VARTYPE(THIS.chk_4c_IncCusts) = "O"
            THIS.chk_4c_IncCusts.Value = loc_oBO.this_nIncCusts
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
            THIS.txt_4c_Moeda.Value    = ALLTRIM(loc_oBO.this_cMoeda)
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
            THIS.txt_4c_MarkUp1.Value  = loc_oBO.this_nMarkUp1
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
            THIS.txt_4c_MarkUp2.Value  = loc_oBO.this_nMarkUp2
        ENDIF
        IF VARTYPE(THIS.txt_4c_Fator)    = "O"
            THIS.txt_4c_Fator.Value    = loc_oBO.this_nFator
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
            THIS.txt_4c_MoeCusto.Value = ALLTRIM(loc_oBO.this_cMoeCusto)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moecs)    = "O"
            THIS.txt_4c_Moecs.Value    = ALLTRIM(loc_oBO.this_cMoecs)
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeCusFs) = "O"
            THIS.txt_4c_MoeCusFs.Value = ALLTRIM(loc_oBO.this_cMoeCusFs)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moedas)   = "O"
            THIS.txt_4c_Moedas.Value   = ALLTRIM(loc_oBO.this_cMoedas)
        ENDIF
        IF VARTYPE(THIS.txt_4c_CFtios)   = "O"
            THIS.txt_4c_CFtios.Value   = ALLTRIM(loc_oBO.this_cCFtios)
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeVs)    = "O"
            THIS.txt_4c_MoeVs.Value    = ALLTRIM(loc_oBO.this_cMoeVs)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Promo)    = "O"
            THIS.txt_4c_Promo.Value    = ALLTRIM(loc_oBO.this_cPromo)
        ENDIF
        IF VARTYPE(THIS.chk_4c_Limpar)   = "O"
            THIS.chk_4c_Limpar.Value   = loc_oBO.this_nLimpar
        ENDIF
        IF VARTYPE(THIS.chk_4c_Auditado) = "O"
            THIS.chk_4c_Auditado.Value = loc_oBO.this_nAuditado
        ENDIF
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de entrada e o grid de produtos
    * Equivalente a resetar o form para o estado inicial (nova consulta)
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos de entrada
    * par_lHabilitar = .T. -> habilitar | .F. -> desabilitar
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
            THIS.txt_4c_CdGrupo.Enabled  = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
            THIS.txt_4c_AteGrupo.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Col)      = "O"
            THIS.txt_4c_Col.Enabled      = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta)    = "O"
            THIS.txt_4c_Conta.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_DConta)   = "O"
            THIS.txt_4c_DConta.Enabled   = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Variacao) = "O"
            THIS.txt_4c_Variacao.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
            THIS.txt_4c_Moeda.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
            THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
            THIS.txt_4c_MarkUp2.Enabled  = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Fator)    = "O"
            THIS.txt_4c_Fator.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
            THIS.txt_4c_MoeCusto.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Promo)    = "O"
            THIS.txt_4c_Promo.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.opt_4c_Tipo)     = "O"
            THIS.opt_4c_Tipo.Enabled     = loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmg_4c_Acao)     = "O"
            THIS.cmg_4c_Acao.Buttons(1).Enabled = loc_lHab
        ENDIF
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * CarregarLista - Para este form OPERACIONAL o grid so e populado apos
    * executar ProcessarReajuste() via BtnProcessarClick.
    * Exibe o estado atual do cursor sem reprocessar.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
            SELECT cursor_4c_Produtos
            GO TOP
            IF VARTYPE(THIS.grd_4c_Produtos) = "O"
                THIS.grd_4c_Produtos.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
    * Para o form OPERACIONAL: habilita Processar, desabilita Atualizar
    * apos reset; habilita Atualizar apos Processar com sucesso.
    * par_cModo = "NORMAL"  -> estado inicial (Processar habilitado)
    *           = "PRONTO"  -> apos Processar (Atualizar habilitado)
    *           = "AUDITADO"-> modo entrada manual (Processar desabilitado)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo
        loc_cModo = UPPER(ALLTRIM(NVL(par_cModo, "NORMAL")))

        IF VARTYPE(THIS.cmg_4c_Acao) # "O"
            RETURN
        ENDIF

        DO CASE
        CASE loc_cModo = "PRONTO"
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.

        CASE loc_cModo = "AUDITADO"
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.

        OTHERWISE
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
        ENDCASE

        THIS.cmg_4c_Acao.Buttons(1).Refresh
        THIS.cmg_4c_Acao.Buttons(2).Refresh
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Alias semantico para BtnProcessarClick
    * Aciona o processamento de selecao e calculo de precos
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias semantico para BtnAtualizarClick
    * Confirma e grava os precos calculados no banco de dados
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnAtualizarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela o processamento atual sem gravar
    * Zera o grid mas mantem os parametros de filtro para reprocessar
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(2)
            IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
                THIS.txt_4c_CdGrupo.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrAprBO.prg):
*==============================================================================
* SIGPRAPRBO.PRG
* Business Object para Reajuste de Precificacao (SIGPRAPR)
* Entidade: SigPrApr
* Tabela principal: SigCdPro
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigPrAprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * FILTROS DE SELECAO DE PRODUTOS
    *--------------------------------------------------------------------------

    *-- Grupo de produto (de) - SigCdGrp.CGrus (C 3)
    this_cCdGrupo    = ""

    *-- Grupo de produto (ate) - SigCdGrp.CGrus (C 3)
    this_cAteGrupo   = ""

    *-- Colecao - SigCdCol.Colecoes (C 10)
    this_cCol        = ""

    *-- Fornecedor (codigo) - SigCdPro.IFors (C 10)
    this_cConta      = ""

    *-- Fornecedor (descricao) - C 50
    this_cDConta     = ""

    *-- Promocao - SigPrPmc.Promos (C 25)
    this_cPromo      = ""

    *--------------------------------------------------------------------------
    * TIPO DE REAJUSTE
    * 1 = Variacao de Preco (%)
    * 2 = MarkUp
    * 3 = Cambio (Preco Ideal)
    *--------------------------------------------------------------------------
    this_nTipo       = 1

    *--------------------------------------------------------------------------
    * CAMPOS PARA TIPO 1: VARIACAO DE PRECO
    *--------------------------------------------------------------------------

    *-- Percentual de variacao (N 9,2)
    this_nVariacao   = 0

    *-- Incluir custos no reajuste (1=Sim, 0=Nao)
    this_nIncCusts   = 0

    *--------------------------------------------------------------------------
    * CAMPOS PARA TIPO 2: MARKUP
    *--------------------------------------------------------------------------

    *-- Moeda de venda - SigCdMoe.CMoes (C 3)
    this_cMoeda      = ""

    *-- MarkUp de (N 6,2)
    this_nMarkUp1    = 0

    *-- MarkUp para (N 6,2)
    this_nMarkUp2    = 0

    *-- Fator de custo (N 8,3)
    this_nFator      = 0

    *-- Moeda do custo - SigCdMoe.CMoes (C 3)
    this_cMoeCusto   = ""

    *-- Moeda custo componente - SigCdMoe.CMoes (C 3)
    this_cMoecs      = ""

    *-- Moeda custo total - SigCdMoe.CMoes (C 3)
    this_cMoeCusFs   = ""

    *-- Feitio - SigPrFti.Cods (C 3)
    this_cCFtios     = ""

    *-- Moeda preco ideal - SigCdMoe.CMoes (C 3)
    this_cMoedas     = ""

    *-- Moeda preco atual - SigCdMoe.CMoes (C 3)
    this_cMoeVs      = ""

    *--------------------------------------------------------------------------
    * OPCOES DE PROCESSAMENTO
    *--------------------------------------------------------------------------

    *-- Modo entrada manual de produtos (CheckBox "Produtos") (1=Sim, 0=Nao)
    this_nAuditado   = 0

    *-- Limpar promocoes anteriores antes de aplicar (1=Sim, 0=Nao)
    this_nLimpar     = 0

    *-- Ignorar componentes na filtragem de produtos (1=Sim, 0=Nao)
    this_nIgnorar    = 0

    *--------------------------------------------------------------------------
    * ESTADO DO PROCESSAMENTO
    *--------------------------------------------------------------------------

    *-- Permissao para edicao manual de ValAtu (acesso SIGPRAPR/VMANUAL)
    this_lLibValAtu  = .F.

    *-- MarkUpCVs de SigCdPam (parametro de calculo)
    this_nMarkUpCV   = 0

    *-- GrPadFors de SigCdPam (grupo padrao fornecedor, usado em fAcessoContas)
    this_cGrPadFors  = ""

    *--------------------------------------------------------------------------
    * PARAMETROS DO SISTEMA (carregados por CarregarParametros)
    *--------------------------------------------------------------------------

    *-- SigCdPac.CalcCusts (1=usar peso no calculo, 2=nao usar peso)
    this_nCalcCusts  = 1

    *-- SigCdPac.nChkSubGrs (1=atualizar sub-grupos por faixa de preco)
    this_nChkSubGrs  = 0

    *--------------------------------------------------------------------------
    * REGISTRO CORRENTE (usado por CarregarDoCursor, Inserir, Atualizar)
    * Reflete a linha de SigPrPmi/SigCdPro atualmente sob manipulacao unitaria
    *--------------------------------------------------------------------------

    *-- Codigo do produto - SigCdPro.CPros / SigPrPmi.CPros (C 14)
    this_cCPros       = ""

    *-- Descricao do produto - SigCdPro.DPros (C 40)
    this_cDPros       = ""

    *-- Preco de venda anterior (snapshot antes do reajuste) N(14,2)
    this_nValAnt      = 0

    *-- Preco de venda atual (apos reajuste) N(14,2)
    this_nValAtu      = 0

    *-- Custo total do produto N(12,3)
    this_nCustoFs     = 0

    *-- Codigo de barras da promocao - SigPrPmi.CBars (C 20)
    this_cCBars       = ""

    *-- Pecas da promocao - SigPrPmi.Pecas (C 20)
    this_cPecas       = ""

    *-- Data da promocao - SigPrPmi.Datas (D)
    this_dDatas       = {}

    *-- Chave unica da promocao - SigPrPmi.CIdChaves (C 20)
    this_cCIdChaves   = ""

    *-- Chave secundaria PromoPro - SigPrPmi.PromoPro (C 40)
    this_cPromoPro    = ""

    *-- Data de alteracao - SigPrPmi.DtAlts (D)
    this_dDtAlts      = {}

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrPmi"
        THIS.this_cCampoChave = "CIdChaves"
        RETURN DODEFAULT("SigPrPmi")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave unica da promocao corrente
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados de SigPrPmi (ou SigCdPro) do cursor
    * para as propriedades do BO. Reconhece automaticamente as colunas
    * presentes no cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias   = ALLTRIM(NVL(par_cAliasCursor, ""))

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o est" + CHR(225) + ;
                                     " dispon" + CHR(237) + "vel: " + loc_cAlias
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            IF TYPE(loc_cAlias + ".CPros") != "U"
                THIS.this_cCPros    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CPros"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".DPros") != "U"
                THIS.this_cDPros    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".DPros"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".PVens") != "U"
                THIS.this_nValAnt   = NVL(EVALUATE(loc_cAlias + ".PVens"), 0)
                THIS.this_nValAtu   = NVL(EVALUATE(loc_cAlias + ".PVens"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".ValAnt") != "U"
                THIS.this_nValAnt   = NVL(EVALUATE(loc_cAlias + ".ValAnt"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".ValAtu") != "U"
                THIS.this_nValAtu   = NVL(EVALUATE(loc_cAlias + ".ValAtu"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".CustoFs") != "U"
                THIS.this_nCustoFs  = NVL(EVALUATE(loc_cAlias + ".CustoFs"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".fCustos") != "U"
                THIS.this_nFator    = NVL(EVALUATE(loc_cAlias + ".fCustos"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".MoePcs") != "U"
                THIS.this_cMoeCusto = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoePcs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".MoeCs") != "U"
                THIS.this_cMoecs    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoeCs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".MoeCusFs") != "U"
                THIS.this_cMoeCusFs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoeCusFs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Moedas") != "U"
                THIS.this_cMoedas   = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Moedas"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".MoeVs") != "U"
                THIS.this_cMoeVs    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoeVs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".CFtios") != "U"
                THIS.this_cCFtios   = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CFtios"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Promos") != "U"
                THIS.this_cPromo    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Promos"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".CBars") != "U"
                THIS.this_cCBars    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CBars"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Pecas") != "U"
                THIS.this_cPecas    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Pecas"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Datas") != "U"
                THIS.this_dDatas    = NVL(EVALUATE(loc_cAlias + ".Datas"), {})
            ENDIF
            IF TYPE(loc_cAlias + ".CIdChaves") != "U"
                THIS.this_cCIdChaves = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CIdChaves"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".PromoPro") != "U"
                THIS.this_cPromoPro = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".PromoPro"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".DtAlts") != "U"
                THIS.this_dDtAlts   = NVL(EVALUATE(loc_cAlias + ".DtAlts"), {})
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em CarregarDoCursor: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto " + ;
                                     CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cPromo))
            THIS.this_cMensagemErro = "Promo" + CHR(231) + CHR(227) + "o " + ;
                                     CHR(233) + " obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro de promocao em SigPrPmi
    * Chave unica em CIdChaves (gerada por fUniqueIds se vazia).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_dAgora

        loc_lSucesso = .F.

        TRY
            *-- Gera chave se ainda nao definida
            IF EMPTY(ALLTRIM(THIS.this_cCIdChaves))
                THIS.this_cCIdChaves = fUniqueIds()
            ENDIF

            *-- Data corrente para Datas/DtAlts se vazias
            loc_dAgora = DATE()
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas  = loc_dAgora
            ENDIF
            IF EMPTY(THIS.this_dDtAlts)
                THIS.this_dDtAlts = loc_dAgora
            ENDIF

            *-- PromoPro (chave secundaria = Promo + CPros) se vazia
            IF EMPTY(ALLTRIM(THIS.this_cPromoPro))
                THIS.this_cPromoPro = ALLTRIM(THIS.this_cPromo) + ;
                                     ALLTRIM(THIS.this_cCPros)
            ENDIF

            loc_cSQL = "INSERT INTO SigPrPmi " + ;
                       "(CPros, Pecas, Promos, CBars, Datas, " + ;
                       " CIdChaves, PromoPro, DtAlts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCPros))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPecas))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPromo))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCBars))     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCIdChaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPromoPro))  + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)         + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao inserir promo" + CHR(231) + ;
                                         CHR(227) + "o em SigPrPmi"
                loc_lSucesso = .F.
            ENDIF

            *-- Registra auditoria
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Inserir: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza SigPrPmi (Pecas, CBars, Datas) e opcionalmente
    * o preco do produto em SigCdPro (PVens = this_nValAtu, CustoFs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            THIS.this_cMensagemErro = "Produto n" + CHR(227) + ;
                                     "o informado para atualiza" + CHR(231) + ;
                                     CHR(227) + "o"
            RETURN .F.
        ENDIF

        TRY
            *-- Data de alteracao
            THIS.this_dDtAlts = DATE()

            *-- UPDATE SigPrPmi (promocao)
            loc_cSQL = "UPDATE SigPrPmi SET " + ;
                       "Pecas    = " + EscaparSQL(ALLTRIM(THIS.this_cPecas))  + ", " + ;
                       "CBars    = " + EscaparSQL(ALLTRIM(THIS.this_cCBars))  + ", " + ;
                       "Datas    = " + FormatarDataSQL(THIS.this_dDatas)       + ", " + ;
                       "PromoPro = " + EscaparSQL(ALLTRIM(THIS.this_cPromoPro)) + ", " + ;
                       "DtAlts   = " + FormatarDataSQL(THIS.this_dDtAlts)      + " " + ;
                       "WHERE CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros)) + ;
                       " AND Promos = " + EscaparSQL(ALLTRIM(THIS.this_cPromo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao atualizar SigPrPmi"
                loc_lSucesso = .F.
            ENDIF

            *-- UPDATE SigCdPro (preco de venda), se produto informado
            IF !EMPTY(ALLTRIM(THIS.this_cCPros)) AND THIS.this_nValAtu > 0
                loc_cSQL = "UPDATE SigCdPro SET " + ;
                           "PVens   = " + FormatarNumeroSQL(THIS.this_nValAtu)  + ", " + ;
                           "CustoFs = " + FormatarNumeroSQL(THIS.this_nCustoFs) + " " + ;
                           "WHERE CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar SigCdPro"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Registra auditoria
            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Atualizar: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove uma promocao de SigPrPmi por CPros + Promos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            THIS.this_cMensagemErro = "Produto n" + CHR(227) + ;
                                     "o informado para exclus" + CHR(227) + "o"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigPrPmi WHERE CPros = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCPros)) + ;
                       " AND Promos = " + EscaparSQL(ALLTRIM(THIS.this_cPromo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao excluir SigPrPmi"
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("DELETE")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em ExecutarExclusao: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros
    * Carrega SigCdPam (MarkUpCVs, GrPadFors) e SigCdPac (CalcCusts, nChkSubGrs)
    * e SigCdGrp (arredondamentos). Chama UMA vez no Init do Form.
    * Retorna .T. em sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.

        TRY
            *-- SigCdPam
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT MarkUpCVs, GrPadFors FROM SigCdPam", ;
                "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            GO TOP
            IF !EOF("cursor_4c_Pam")
                THIS.this_nMarkUpCV  = NVL(cursor_4c_Pam.MarkUpCVs, 0)
                THIS.this_cGrPadFors = ALLTRIM(NVL(cursor_4c_Pam.GrPadFors, ""))
            ENDIF

            *-- SigCdPac
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CalcCusts, nChkSubGrs FROM SigCdPac", ;
                "cursor_4c_Pac")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdPac)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pac
            GO TOP
            IF !EOF("cursor_4c_Pac")
                THIS.this_nCalcCusts = NVL(cursor_4c_Pac.CalcCusts,  1)
                THIS.this_nChkSubGrs = NVL(cursor_4c_Pac.nChkSubGrs, 0)
            ENDIF

            *-- SigCdGrp (grupos com arredondamentos, indexado por CGrus)
            IF USED("cursor_4c_Grp")
                USE IN cursor_4c_Grp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CGrus, Arreds FROM SigCdGrp ORDER BY CGrus", ;
                "cursor_4c_Grp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdGrp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Grp
            INDEX ON CGrus TAG CGrus
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarParametros: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarAcessoEdicaoManual
    * Retorna .T. se usuario tem permissao VMANUAL em SIGPRAPR
    *--------------------------------------------------------------------------
    PROCEDURE VerificarAcessoEdicaoManual()
        RETURN fChecaAcesso("SIGPRAPR", "VMANUAL")
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFatorMoeda
    * Retorna taxa de cambio de par_cMoeda, considerando a cadeia MoeQs/QtdeQs
    * de SigCdMoe (moeda quotada em outra moeda * fator de quantidade).
    * par_cMoeda: codigo da moeda (ex: "USD")
    * Retorna 1.0 se vazia ou "R$".
    *--------------------------------------------------------------------------
    PROCEDURE BuscarFatorMoeda(par_cMoeda)
        LOCAL loc_cMoeda, loc_cMoeRef, loc_nQtde, loc_nResult, loc_nTaxa

        loc_cMoeda = ALLTRIM(NVL(par_cMoeda, ""))
        loc_nTaxa  = 1.0

        IF EMPTY(loc_cMoeda)
            RETURN loc_nTaxa
        ENDIF

        TRY
            *-- Verifica se moeda tem alias (MoeQs) e fator (QtdeQs) em SigCdMoe
            IF USED("cursor_4c_MoeRef")
                USE IN cursor_4c_MoeRef
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 MoeQs, QtdeQs FROM SigCdMoe WHERE CMoes = " + ;
                EscaparSQL(loc_cMoeda), ;
                "cursor_4c_MoeRef")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MoeRef")
                SELECT cursor_4c_MoeRef
                IF !EMPTY(ALLTRIM(NVL(cursor_4c_MoeRef.MoeQs, "")))
                    loc_cMoeRef = ALLTRIM(cursor_4c_MoeRef.MoeQs)
                    loc_nQtde   = IIF(NVL(cursor_4c_MoeRef.QtdeQs, 0) = 0, 1, ;
                                      cursor_4c_MoeRef.QtdeQs)
                ELSE
                    loc_cMoeRef = loc_cMoeda
                    loc_nQtde   = 1
                ENDIF
            ELSE
                loc_cMoeRef = loc_cMoeda
                loc_nQtde   = 1
            ENDIF

            IF USED("cursor_4c_MoeRef")
                USE IN cursor_4c_MoeRef
            ENDIF

            loc_nTaxa = fBuscarCotacao(loc_cMoeRef, DATE(), gnConnHandle) * loc_nQtde

        CATCH TO loc_oErro
            MsgErro("Erro em BuscarFatorMoeda: " + loc_oErro.Message, "Erro")
            loc_nTaxa = 1.0
        ENDTRY

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcPreco
    * Calcula preco ideal por markup para o registro CORRENTE de cursor_4c_TmpPro.
    * par_nMargem: markup desejado (ex: 3.5 = 3.5x custo)
    * Usa this_cMoeCusto, this_nFator, this_cMoedas do BO (valores dos campos do form).
    * Escreve em cursor_4c_TmpPro.CustoFs o custo calculado.
    * Retorna preco ideal calculado.
    *--------------------------------------------------------------------------
    PROCEDURE CalcPreco(par_nMargem)
        LOCAL loc_nCusto, loc_nVenda, loc_nMoeC, loc_nMoeV, loc_nMoeCF, loc_nMoeFT
        LOCAL loc_nMoedas, loc_nFator, loc_nFPeso, loc_nIdeal, loc_nCustoF, loc_nMoeP
        LOCAL loc_cMoeCusto, loc_nFatCusto, loc_cMoeIdeal, loc_nFeitio, loc_nPreco

        IF !USED("cursor_4c_TmpPro")
            RETURN 0
        ENDIF
        SELECT cursor_4c_TmpPro

        *-- Resolve parametros: form override ou valor do produto
        loc_cMoeCusto = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ;
                            ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, "")), ;
                            ALLTRIM(THIS.this_cMoeCusto))
        loc_nFatCusto = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoeCusto), ;
                            THIS.this_nFator, ;
                            NVL(cursor_4c_TmpPro.fCustos, 0))
        loc_cMoeIdeal = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ;
                            ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), ;
                            ALLTRIM(THIS.this_cMoedas))

        loc_nCusto  = NVL(cursor_4c_TmpPro.PCuss,  0)
        loc_nFPeso  = NVL(cursor_4c_TmpPro.PesoMs, 0) * loc_nFatCusto
        loc_nFator  = par_nMargem
        loc_nFeitio = NVL(cursor_4c_TmpPro.PFtios, 0)

        *-- Taxas de cambio
        loc_nMoeC  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")))
        loc_nMoeP  = THIS.BuscarFatorMoeda(loc_cMoeCusto)
        loc_nMoeV  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")))
        loc_nMoeCF = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")))
        loc_nMoedas = THIS.BuscarFatorMoeda(loc_cMoeIdeal)
        loc_nMoeFT  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")))

        *-- Converte feitio para moeda de custo total se moedas diferentes
        IF ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / loc_nMoeCF
            ENDIF
        ENDIF

        *-- Custo convertido para moeda de custo total
        IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nCustoF = (loc_nCusto * loc_nMoeC) / loc_nMoeCF
            ELSE
                loc_nCustoF = loc_nCusto
            ENDIF
        ELSE
            loc_nCustoF = loc_nCusto
        ENDIF

        *-- Aplica fator de peso (CalcCusts: 1=soma peso, 2=multiplica fator)
        IF THIS.this_nCalcCusts = 2
            IF loc_cMoeCusto <> ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, ;
                                  loc_nFatCusto * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto)
            ENDIF
        ELSE
            IF loc_cMoeCusto <> ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF + (loc_nFPeso * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF + loc_nFPeso
            ENDIF
        ENDIF

        *-- Grava custo calculado no cursor temporario
        IF !EOF("cursor_4c_TmpPro")
            REPLACE CustoFs WITH loc_nCustoF IN cursor_4c_TmpPro
        ENDIF

        *-- Calcula preco ideal
        IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")) <> loc_cMoeIdeal
            IF loc_nMoedas <> 0
                loc_nIdeal = (loc_nCustoF + loc_nFeitio) * loc_nMoeCF / loc_nMoedas * loc_nFator
            ELSE
                loc_nIdeal = 0
            ENDIF
        ELSE
            loc_nIdeal = (loc_nCustoF + loc_nFeitio) * loc_nFator
        ENDIF

        RETURN loc_nIdeal
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcMargem
    * Calcula margem para um dado preco no registro CORRENTE de cursor_4c_TmpPro.
    * par_nPreco: preco de venda a avaliar
    * Retorna margem calculada.
    *--------------------------------------------------------------------------
    PROCEDURE CalcMargem(par_nPreco)
        LOCAL loc_nCusto, loc_nMoeC, loc_nMoeCF, loc_nMoeFT, loc_nMoedas
        LOCAL loc_nFatCusto, loc_cMoeIdeal, loc_nFeitio, loc_nCustoF, loc_nMargem
        LOCAL loc_nMoeP

        IF !USED("cursor_4c_TmpPro")
            RETURN 0
        ENDIF
        SELECT cursor_4c_TmpPro

        loc_cMoeIdeal = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ;
                            ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), ;
                            ALLTRIM(THIS.this_cMoedas))
        loc_nFatCusto = NVL(cursor_4c_TmpPro.fCustos, 0)

        loc_nCusto  = NVL(cursor_4c_TmpPro.PCuss,  0)
        loc_nFeitio = NVL(cursor_4c_TmpPro.PFtios, 0)
        loc_nFPeso  = NVL(cursor_4c_TmpPro.PesoMs, 0) * loc_nFatCusto

        loc_nMoeC  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")))
        loc_nMoeP  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoePCs, "")))
        loc_nMoeV  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")))
        loc_nMoeCF = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")))
        loc_nMoedas = THIS.BuscarFatorMoeda(loc_cMoeIdeal)
        loc_nMoeFT  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")))

        IF ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / loc_nMoeCF
            ENDIF
        ENDIF

        IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nCustoF = (loc_nCusto * loc_nMoeC) / loc_nMoeCF
            ELSE
                loc_nCustoF = loc_nCusto
            ENDIF
        ELSE
            loc_nCustoF = loc_nCusto
        ENDIF

        IF THIS.this_nCalcCusts = 2
            IF ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, "")) <> ;
               ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, ;
                                  loc_nFatCusto * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto)
            ENDIF
        ELSE
            IF ALLTRIM(NVL(cursor_4c_TmpPro.MoePCs, "")) <> ;
               ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF + (loc_nFPeso * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF + loc_nFPeso
            ENDIF
        ENDIF

        IF (loc_nCustoF + loc_nFeitio) = 0
            loc_nMargem = 0
        ELSE
            IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")) <> loc_cMoeIdeal
                IF loc_nMoedas <> 0
                    loc_nMargem = par_nPreco / ((loc_nCustoF + loc_nFeitio) * ;
                                  loc_nMoeCF / loc_nMoedas)
                ELSE
                    loc_nMargem = 0
                ENDIF
            ELSE
                loc_nMargem = par_nPreco / (loc_nCustoF + loc_nFeitio)
            ENDIF
        ENDIF

        RETURN loc_nMargem
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcMarkpa
    * Recalcula MarkupA para o registro CORRENTE de cursor_4c_Pro (SigCdPro buffer).
    * Grava resultado em cursor_4c_Pro.MarkupA via REPLACE.
    *--------------------------------------------------------------------------
    PROCEDURE CalcMarkpa()
        LOCAL loc_nMoeCF, loc_nMoeV, loc_nMarkpA

        IF !USED("cursor_4c_Pro")
            RETURN
        ENDIF
        SELECT cursor_4c_Pro

        loc_nMoeCF = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_Pro.MoeCusFs, "")))
        loc_nMoeV  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_Pro.MoeVs,   "")))

        IF NVL(cursor_4c_Pro.CustoFs, 0) = 0 OR loc_nMoeCF = 0
            loc_nMarkpA = 0
        ELSE
            loc_nMarkpA = ROUND((NVL(cursor_4c_Pro.PVens, 0) * loc_nMoeV) / ;
                                (NVL(cursor_4c_Pro.CustoFs, 0) * loc_nMoeCF), 3)
        ENDIF

        REPLACE MarkupA WITH loc_nMarkpA IN cursor_4c_Pro
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarReajuste
    * Equivale ao botao Processar (sair.Processa.Click) do legado.
    * Usa this_cCdGrupo, this_cAteGrupo, this_cCol, this_cConta, this_nTipo,
    * this_nVariacao, this_cMoeda, this_nMarkUp1, this_nMarkUp2, this_nIgnorar.
    * Cria cursor_4c_Produtos com os produtos recalculados.
    * Retorna .T. em sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarReajuste()
        LOCAL loc_lSucesso, loc_cWhere, loc_cSQL, loc_nResult
        LOCAL loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
        LOCAL loc_nValAtu, loc_cMoePcs, loc_nFCustos, loc_nCustoF

        loc_lSucesso = .F.

        TRY
            *-- Valida campos obrigatorios por tipo
            DO CASE
            CASE THIS.this_nTipo = 1
                IF THIS.this_nVariacao = 0
                    MsgAviso("Varia" + CHR(231) + CHR(227) + "o Inv" + ;
                             CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
            CASE THIS.this_nTipo = 2
                IF EMPTY(ALLTRIM(THIS.this_cMoeda))
                    MsgAviso("Moeda Inv" + CHR(225) + "lida !!!", ;
                             "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
                IF THIS.this_nMarkUp2 = 0
                    MsgAviso("MarkUp Inv" + CHR(225) + "lido !!!", ;
                             "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
            ENDCASE

            *-- Monta clausula WHERE
            loc_cWhere = "0 = 0 "
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrupo)) OR !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                IF !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                    loc_cWhere = loc_cWhere + ;
                        "AND CGrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + ;
                        " AND " + EscaparSQL(ALLTRIM(THIS.this_cAteGrupo)) + " "
                ELSE
                    loc_cWhere = loc_cWhere + ;
                        "AND CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + " "
                ENDIF
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCol))
                loc_cWhere = loc_cWhere + ;
                    "AND Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cCol)) + " "
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + ;
                    "AND IFors = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + " "
            ENDIF
            IF THIS.this_nTipo = 2
                loc_cWhere = loc_cWhere + ;
                    "AND MoeVs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + ;
                    " AND Margems = " + FormatarNumeroSQL(THIS.this_nMarkUp1) + " "
            ENDIF

            *-- Filtra componentes (exceto se chkIgnorar)
            IF THIS.this_nIgnorar <> 1
                loc_cWhere = loc_cWhere + ;
                    "AND CPros NOT IN (SELECT DISTINCT cpros FROM SigPrCpo) "
            ENDIF

            *-- Query principal -> cursor_4c_TmpPro
            IF USED("cursor_4c_TmpPro")
                TABLEREVERT(.T., "cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY CPros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de produtos (SigCdPro)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpPro
            INDEX ON CPros TAG CPros
            GO TOP

            *-- (Re)cria cursor de produtos para o Grid
            IF USED("cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos ( ;
                lMarca  N(1)    NULL, ;
                CPros   C(14)   NULL, ;
                DPros   C(40)   NULL, ;
                ValAnt  N(14,2) NULL, ;
                ValAtu  N(14,2) NULL, ;
                fCustos N(8,3)  NULL, ;
                MoePcs  C(3)    NULL, ;
                CustoFs N(12,3) NULL, ;
                Manual  N(1)    NULL  ;
            )
            SET NULL OFF
            INDEX ON CPros TAG CPros
            SELECT cursor_4c_Produtos
            SET ORDER TO
            GO TOP

            *-- Percorre produtos e calcula novos precos
            SELECT cursor_4c_TmpPro
            GO TOP
            SCAN
                loc_nCustoF  = NVL(cursor_4c_TmpPro.CustoFs, 0)

                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0) + ;
                                  (NVL(cursor_4c_TmpPro.PVens, 0) * THIS.this_nVariacao / 100)
                CASE THIS.this_nTipo = 2
                    loc_nValAtu = THIS.CalcPreco(THIS.this_nMarkUp2)
                CASE THIS.this_nTipo = 3
                    loc_nCotId = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), DATE(), gnConnHandle)
                    loc_nCotVd = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")), DATE(), gnConnHandle)
                    loc_nPVen  = NVL(cursor_4c_TmpPro.PVIdeals, 0) * ;
                                 IIF(loc_nCotVd <> 0, loc_nCotId / loc_nCotVd, 0)
                    IF NVL(cursor_4c_TmpPro.Encargos, 0) <> 0
                        loc_nVlVen = loc_nPVen / cursor_4c_TmpPro.Encargos
                    ELSE
                        loc_nVlVen = loc_nPVen
                    ENDIF
                    loc_nValAtu = loc_nVlVen
                OTHERWISE
                    loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0)
                ENDCASE

                loc_cMoePcs  = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ;
                                   ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, "")), ;
                                   ALLTRIM(THIS.this_cMoeCusto))
                IF THIS.this_nFator > 0 AND !EMPTY(loc_cMoePcs)
                    loc_nFCustos = THIS.this_nFator
                    loc_nCustoF  = NVL(cursor_4c_TmpPro.CustoFs, 0)
                ELSE
                    loc_nFCustos = NVL(cursor_4c_TmpPro.fCustos, 0)
                    loc_nCustoF  = NVL(cursor_4c_TmpPro.CustoFs, 0)
                ENDIF

                SELECT cursor_4c_Produtos
                APPEND BLANK
                REPLACE lMarca  WITH 1
                REPLACE CPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.CPros,  ""))
                REPLACE DPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.DPros,  ""))
                REPLACE ValAnt  WITH NVL(cursor_4c_TmpPro.PVens,  0)
                REPLACE ValAtu  WITH loc_nValAtu
                REPLACE fCustos WITH loc_nFCustos
                REPLACE MoePcs  WITH loc_cMoePcs
                REPLACE CustoFs WITH loc_nCustoF
                REPLACE Manual  WITH 0

                SELECT cursor_4c_TmpPro

            ENDSCAN

            SELECT cursor_4c_Produtos
            SET ORDER TO CPros
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro em ProcessarReajuste: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPrecos
    * Equivale ao botao Atualizar (sair.Atualiza.Click) do legado.
    * Processa registros marcados (lMarca=1) em cursor_4c_Produtos.
    * Salva historico em SigCdPrc, atualiza SigCdPro, SigPrCp2, SigPrPmi.
    * Retorna .T. em sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPrecos()
        LOCAL loc_lSucesso, loc_lImpEtiq, loc_nResult, loc_cSQL
        LOCAL loc_cCPros, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
        LOCAL loc_nPVens, loc_nPCuss, loc_nCustoFs, loc_cIdChave, loc_cOrigem
        LOCAL loc_dAgora, loc_cHora, loc_nCt, loc_llOk, loc_nArq

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Produtos")
                MsgAviso("Nenhum produto para atualizar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Verifica se ha marcados
            IF USED("cursor_4c_ProSel")
                USE IN cursor_4c_ProSel
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT 1 WHERE 0=1", "cursor_4c_ProSel")
            SELECT * FROM cursor_4c_Produtos WHERE lMarca = 1 ;
                ORDER BY CPros INTO CURSOR cursor_4c_ProSel READWRITE
            SELECT cursor_4c_ProSel
            GO TOP
            IF EOF("cursor_4c_ProSel")
                MsgAviso("Nenhum Produto Selecionado !!!", ;
                         "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                USE IN cursor_4c_ProSel
                loc_lSucesso = .F.
            ENDIF

            *-- Confirmacao de impressao de etiquetas
            loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?", ;
                                       "Etiquetas")

            *-- Processa cada produto marcado
            SELECT cursor_4c_ProSel
            GO TOP
            loc_llOk = .T.
            SCAN WHILE loc_llOk
                loc_cCPros  = ALLTRIM(cursor_4c_ProSel.CPros)
                loc_dAgora  = DATETIME()
                loc_cHora   = SUBSTR(TTOC(loc_dAgora), 12, 8)
                loc_cIdChave = fUniqueIds()
                loc_cOrigem  = DTOC(DATE()) + " SIGALTPC"

                *-- Obtem dados atuais do produto em SigCdPro
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros), ;
                    "cursor_4c_Pro")
                IF loc_nResult < 1 OR EOF("cursor_4c_Pro")
                    loc_llOk = .F.
                    EXIT
                ENDIF
                SELECT cursor_4c_Pro
                GO TOP

                *-- INSERT historico em SigCdPrc (snapshot antes do reajuste)
                loc_cSQL = "INSERT INTO SigCdPrc " + ;
                           "(cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
                           " margems, moevs, moecs, moepcs, moecusfs, moedas, " + ;
                           " DataAlts, HoraAlts, UsuaAlts, cIdChaves, Origem) " + ;
                           "SELECT cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
                           " margems, moevs, moecs, moepcs, moecusfs, moedas, " + ;
                           FormatarDataSQL(loc_dAgora) + ", " + ;
                           EscaparSQL(loc_cHora) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(loc_cIdChave) + ", " + ;
                           EscaparSQL(loc_cOrigem) + " " + ;
                           "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCPros)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nResult < 1
                    loc_llOk = .F.
                    THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
                                             "rico de pre" + CHR(231) + "os (SigCdPrc)"
                    EXIT
                ENDIF

                *-- Calcula novos valores
                SELECT cursor_4c_Pro
                loc_nPVens   = NVL(cursor_4c_Pro.PVens,   0)
                loc_nPCuss   = NVL(cursor_4c_Pro.PCuss,   0)
                loc_nCustoFs = NVL(cursor_4c_Pro.CustoFs, 0)

                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nPVens = loc_nPVens + (loc_nPVens * THIS.this_nVariacao / 100)
                    IF THIS.this_nIncCusts = 1
                        loc_nPCuss   = loc_nPCuss   + (loc_nPCuss   * THIS.this_nVariacao / 100)
                        loc_nCustoFs = loc_nCustoFs + (loc_nCustoFs * THIS.this_nVariacao / 100)
                    ENDIF
                CASE THIS.this_nTipo = 2
                    loc_nMargem  = THIS.this_nMarkUp2
                    IF USED("cursor_4c_TmpPro") AND SEEK(loc_cCPros, "cursor_4c_TmpPro", "CPros")
                        loc_nPVens   = THIS.CalcPreco(loc_nMargem)
                        loc_nCustoFs = cursor_4c_ProSel.CustoFs
                    ENDIF
                CASE THIS.this_nTipo = 3
                    loc_nCotId = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_Pro.Moedas, "")), DATE(), gnConnHandle)
                    loc_nCotVd = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_Pro.MoeVs, "")),  DATE(), gnConnHandle)
                    IF loc_nCotVd <> 0
                        loc_nPVen = NVL(cursor_4c_Pro.PVIdeals, 0) * loc_nCotId / loc_nCotVd
                    ELSE
                        loc_nPVen = 0
                    ENDIF
                    IF NVL(cursor_4c_Pro.Encargos, 0) <> 0
                        loc_nVlVen = loc_nPVen / cursor_4c_Pro.Encargos
                    ELSE
                        loc_nVlVen = loc_nPVen
                    ENDIF
                    loc_nPVens = loc_nVlVen
                ENDCASE

                *-- Se Manual=1, usa o valor digitado manualmente pelo usuario
                IF cursor_4c_ProSel.Manual = 1
                    loc_nPVens = cursor_4c_ProSel.ValAtu
                ENDIF

                *-- UPDATE SigCdPro com novos precos
                loc_cSQL = "UPDATE SigCdPro SET " + ;
                           "PVens  = " + FormatarNumeroSQL(loc_nPVens)   + ", " + ;
                           "PCuss  = " + FormatarNumeroSQL(loc_nPCuss)   + ", " + ;
                           "CustoFs = " + FormatarNumeroSQL(loc_nCustoFs) + ", " + ;
                           "ImpEtiqs = " + IIF(loc_lImpEtiq, "1", "0")
                IF THIS.this_nTipo = 2
                    loc_cSQL = loc_cSQL + ", " + ;
                               "Margems  = " + FormatarNumeroSQL(THIS.this_nMarkUp2) + ", " + ;
                               "PVIdeals = " + FormatarNumeroSQL(loc_nPVens) + ", " + ;
                               "fCustos  = " + FormatarNumeroSQL(cursor_4c_ProSel.fCustos) + ", " + ;
                               "MoePcs   = " + EscaparSQL(ALLTRIM(cursor_4c_ProSel.MoePcs))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoecs))
                    loc_cSQL = loc_cSQL + ", MoeCs   = " + EscaparSQL(ALLTRIM(THIS.this_cMoecs))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoeCusFs))
                    loc_cSQL = loc_cSQL + ", MoeCusFs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeCusFs))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoedas))
                    loc_cSQL = loc_cSQL + ", Moedas  = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cCFtios))
                    loc_cSQL = loc_cSQL + ", CFtios  = " + EscaparSQL(ALLTRIM(THIS.this_cCFtios))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoeVs))
                    loc_cSQL = loc_cSQL + ", MoeVs   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeVs))
                ENDIF
                loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCPros)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nResult < 1
                    loc_llOk = .F.
                    THIS.this_cMensagemErro = "Falha ao atualizar SigCdPro"
                    EXIT
                ENDIF

                *-- Recalcula MarkupA (CalcMarkpa) apos update
                *-- Recarrega cursor_4c_Pro com dados atualizados
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT PVens, CustoFs, MoeCusFs, MoeVs, MarkupA FROM SigCdPro " + ;
                    "WHERE CPros = " + EscaparSQL(loc_cCPros), ;
                    "cursor_4c_Pro")
                IF USED("cursor_4c_Pro") AND !EOF("cursor_4c_Pro")
                    SELECT cursor_4c_Pro
                    GO TOP
                    THIS.CalcMarkpa()
                    *-- Salva MarkupA calculado
                    SQLEXEC(gnConnHandle, ;
                        "UPDATE SigCdPro SET MarkupA = " + ;
                        FormatarNumeroSQL(NVL(cursor_4c_Pro.MarkupA, 0)) + ;
                        " WHERE cpros = " + EscaparSQL(loc_cCPros), "")
                ENDIF

                *-- Backup composicao -> SigPrCp2
                IF USED("cursor_4c_Compo")
                    USE IN cursor_4c_Compo
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(loc_cCPros), ;
                    "cursor_4c_Compo")
                IF loc_nResult > 0 AND !EOF("cursor_4c_Compo")
                    SELECT cursor_4c_Compo
                    GO TOP
                    SCAN
                        loc_cSQL = "INSERT INTO SigPrCp2 " + ;
                                   "(cpros, DataAlts, HoraAlts, UsuaAlts) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(NVL(cursor_4c_Compo.cpros, ""))) + ", " + ;
                                   FormatarDataSQL(loc_dAgora) + ", " + ;
                                   EscaparSQL(loc_cHora) + ", " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL, "")
                        SELECT cursor_4c_Compo
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_Compo")
                    USE IN cursor_4c_Compo
                ENDIF

                *-- Delete de SigPrPrt para o produto
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cCPros), "")

                *-- Limpar promocoes anteriores (se solicitado)
                IF THIS.this_nLimpar = 1
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigPrPmi WHERE CPros = " + EscaparSQL(loc_cCPros), "")
                    IF loc_nResult < 1
                        loc_llOk = .F.
                        THIS.this_cMensagemErro = "Falha ao limpar promo" + CHR(231) + ;
                                                 CHR(245) + "es (SigPrPmi)"
                        EXIT
                    ENDIF
                ENDIF

                *-- Inserir nova promocao (se informada)
                IF !EMPTY(ALLTRIM(THIS.this_cPromo))
                    IF USED("cursor_4c_PromoI")
                        USE IN cursor_4c_PromoI
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 1 FROM SigPrPmi " + ;
                        "WHERE CPros = " + EscaparSQL(loc_cCPros) + ;
                        " AND Promos = " + EscaparSQL(ALLTRIM(THIS.this_cPromo)), ;
                        "cursor_4c_PromoI")
                    IF loc_nResult > 0 AND EOF("cursor_4c_PromoI")
                        loc_cSQL = "INSERT INTO SigPrPmi " + ;
                                   "(CPros, Pecas, Promos, CBars, Datas, CIdChaves, PromoPro, DtAlts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCPros) + ", '', " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cPromo)) + ", 0, " + ;
                                   FormatarDataSQL(loc_dAgora) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cPromo) + loc_cCPros) + ", " + ;
                                   FormatarDataSQL(loc_dAgora) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                        IF loc_nResult < 1
                            loc_llOk = .F.
                            THIS.this_cMensagemErro = "Falha ao inserir promo" + CHR(231) + CHR(227) + "o"
                            EXIT
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_PromoI")
                        USE IN cursor_4c_PromoI
                    ENDIF
                ENDIF

                *-- Sub-grupos por faixa de preco (SigCdPac.nChkSubGrs = 1)
                IF THIS.this_nChkSubGrs = 1 AND USED("cursor_4c_Pro")
                    SELECT cursor_4c_Pro
                    GO TOP
                    IF !EOF("cursor_4c_Pro")
                        IF USED("cursor_4c_SubGrp")
                            USE IN cursor_4c_SubGrp
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Codigos, nFaixaFins FROM SigCdPsg " + ;
                            "WHERE CGrus = " + ;
                            EscaparSQL(ALLTRIM(NVL(cursor_4c_Pro.CGrus, ""))) + ;
                            " ORDER BY nFaixaFins", ;
                            "cursor_4c_SubGrp")
                        IF loc_nResult > 0 AND !EOF("cursor_4c_SubGrp")
                            LOCAL loc_nPVFinal, loc_cCodigos
                            loc_nPVFinal = IIF(NVL(cursor_4c_Pro.PVens, 0) = 0, ;
                                               NVL(cursor_4c_Pro.PVIdeals, 0), ;
                                               NVL(cursor_4c_Pro.PVens, 0))
                            SELECT cursor_4c_SubGrp
                            LOCATE FOR NVL(cursor_4c_SubGrp.nFaixaFins, 0) >= loc_nPVFinal
                            IF !EOF("cursor_4c_SubGrp")
                                loc_cCodigos = ALLTRIM(NVL(cursor_4c_SubGrp.Codigos, ""))
                                SQLEXEC(gnConnHandle, ;
                                    "UPDATE SigCdPro SET sGrus = " + EscaparSQL(loc_cCodigos) + ;
                                    " WHERE cpros = " + EscaparSQL(loc_cCPros), "")
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_SubGrp")
                            USE IN cursor_4c_SubGrp
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF

                SELECT cursor_4c_ProSel
            ENDSCAN

            IF loc_llOk
                loc_nResult = SQLCOMMIT(gnConnHandle)
                IF loc_nResult < 0
                    SQLROLLBACK(gnConnHandle)
                    THIS.this_cMensagemErro = "Falha ao confirmar transa" + CHR(231) + CHR(227) + "o"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    MsgInfo("Processamento Finalizado com Sucesso !!!", "")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                SQLROLLBACK(gnConnHandle)
                MsgErro(THIS.this_cMensagemErro, ;
                        "Falha na Atualiza" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_ProSel")
                USE IN cursor_4c_ProSel
            ENDIF

        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro("Erro em AtualizarPrecos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


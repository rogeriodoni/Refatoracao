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
[04/23/26 03:23:54 PM] Configuração: Operação de Divisão de Op não Configurada nos parâmetros do sistema...
[04/23/26 03:23:54 PM] Erro em InicializarForm: Alias 'CURSOR_4C_PAMDIV' is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-23 15:22:51] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-23 15:22:51] [INFO] Config FPW: (nao fornecido)
[2026-04-23 15:22:51] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-23 15:22:51] [INFO] Timeout: 300 segundos
[2026-04-23 15:22:51] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_es52smlv.prg
[2026-04-23 15:22:51] [INFO] Conteudo do wrapper:
[2026-04-23 15:22:51] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigopdiv', 'C:\4c\tasks\task019', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopdiv', 'C:\4c\tasks\task019', 'OPERACIONAL'
QUIT

[2026-04-23 15:22:51] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_es52smlv.prg
[2026-04-23 15:22:51] [INFO] VFP output esperado em: C:\4c\tasks\task019\vfp_output.txt
[2026-04-23 15:22:51] [INFO] Executando Visual FoxPro 9...
[2026-04-23 15:22:51] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_es52smlv.prg
[2026-04-23 15:22:51] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_es52smlv.prg
[2026-04-23 15:22:51] [INFO] Timeout configurado: 300 segundos
[2026-04-23 15:23:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-23 15:23:55] [INFO] VFP9 finalizado em 63.8478306 segundos
[2026-04-23 15:23:55] [INFO] Exit Code: 
[2026-04-23 15:23:55] [INFO] 
[2026-04-23 15:23:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-23 15:23:55] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_es52smlv.prg
[2026-04-23 15:23:55] [INFO] 
[2026-04-23 15:23:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-23 15:23:55] [INFO] * Auto-generated wrapper for parameters
[2026-04-23 15:23:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-23 15:23:55] [INFO] * Parameters: 'Formsigopdiv', 'C:\4c\tasks\task019', 'OPERACIONAL'
[2026-04-23 15:23:55] [INFO] 
[2026-04-23 15:23:55] [INFO] * Anti-dialog protections for unattended execution
[2026-04-23 15:23:55] [INFO] SET SAFETY OFF
[2026-04-23 15:23:55] [INFO] SET RESOURCE OFF
[2026-04-23 15:23:55] [INFO] SET TALK OFF
[2026-04-23 15:23:55] [INFO] SET NOTIFY OFF
[2026-04-23 15:23:55] [INFO] SYS(2335, 0)
[2026-04-23 15:23:55] [INFO] 
[2026-04-23 15:23:55] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopdiv', 'C:\4c\tasks\task019', 'OPERACIONAL'
[2026-04-23 15:23:55] [INFO] QUIT
[2026-04-23 15:23:55] [INFO] 
[2026-04-23 15:23:55] [INFO] === Fim do Wrapper.prg ===
[2026-04-23 15:23:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigopdiv",
  "timestamp": "20260423152354",
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg):
*============================================================================
* Formsigopdiv.prg - Separa/Reinicia Industrializa" + CHR(231) + CHR(227) + "o
* Tipo: OPERACIONAL - Divide ou Reinicia Ordens de Producao
* Tabelas principais: SigOpPic, SigCdNec, SigCdNei, SigPdMvf, SigCdOpd
* Fase 7/8: Form completo com eventos principais (GrupoSalvaClick/GrupoConfClick)
*============================================================================
DEFINE CLASS Formsigopdiv AS FormBase

    *-- Layout (pixel-perfect do legado)
    Width       = 830
    Height      = 527
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    DataSession = 2
    Themes      = .F.
    ShowWindow  = 1
    KeyPreview  = .F.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cOperacao       = "D"    && 'D'=Divisao, 'R'=Reinicia
    this_lAutomatico     = .F.

    *==========================================================================
    * Init - Aceita parametro de operacao antes de chamar FormBase.Init
    *==========================================================================
    PROCEDURE Init(par_cOperacao)
        IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao)
            THIS.this_cOperacao = UPPER(ALLTRIM(par_cOperacao))
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Construcao completa do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Criar BO
            THIS.this_oBusinessObject = CREATEOBJECT("sigopdivBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopdiv.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Validar DivOps em SigCdPam
            LOCAL loc_cSQL
            loc_cSQL = "SELECT DivOps FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamDiv") > 0
                SELECT cursor_4c_PamDiv
                GO TOP
                IF EMPTY(ALLTRIM(cursor_4c_PamDiv.DivOps))
                    USE IN cursor_4c_PamDiv
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o de Divis" + CHR(227) + ;
                             "o de Op n" + CHR(227) + "o Configurada nos par" + CHR(226) + ;
                             "metros do sistema...", "Configura" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
                USE IN cursor_4c_PamDiv
            ENDIF

            *-- Definir Caption conforme operacao
            IF THIS.this_cOperacao = "R"
                THIS.Caption = "Reinicia Industrializa" + CHR(231) + CHR(227) + "o"
            ELSE
                THIS.Caption = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
            ENDIF

            *-- Criar cursores de trabalho (privados desta sessao de dados)
            SET NULL ON
            CREATE CURSOR Temp_DivOp ;
                (Qtds N(12,3), QtdEtiqs N(5,0), QtdDivs N(12,3), Dopes C(20), ;
                 Numes N(6,0), Dataes D, Obss M NULL, Nops N(10,0), SeqDivs N(3,0), ;
                 Cpros C(14), CodCors C(4), CodTams C(4), Empds C(3), Dpros C(65), ;
                 Notas C(6), Contas C(10), Citens N(10,0), Pesos N(12,3))
            CREATE CURSOR Temporario ;
                (Qtds N(12,3), Dopes C(20), Numes N(6,0), Dataes D, Obss M NULL, ;
                 Nops N(10,0), SeqDivs N(3,0), Cpros C(14), CodCors C(4), CodTams C(4), ;
                 Empds C(3), Dpros C(65), Notas C(6), Contas C(10), Pesos N(9,3))
            INDEX ON Nops TAG Nops FOR Qtds > 0
            SET NULL OFF

            *-- Criar xNensi com estrutura identica a SigCdNei
            IF gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCdNei", ;
                           "cursor_4c_NensiStruct") > 0
                    DIMENSION loc_aNensiFields[1]
                    AFIELDS(loc_aNensiFields, "cursor_4c_NensiStruct")
                    CREATE CURSOR xNensi FROM ARRAY loc_aNensiFields
                    USE IN cursor_4c_NensiStruct
                ENDIF
            ENDIF

            *-- Construir todos os controles UI
            THIS.ConfigurarControles()

            *-- Inicializar estado visual do form (Grade principal visivel)
            THIS.ConfigurarPaginaLista()

            *-- Propagar Caption para labels de titulo
            THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

            *-- BINDEVENT: Get_OP
            *-- Valid nao funciona via BINDEVENT em TextBox; usar KeyPress ENTER/TAB
            BINDEVENT(THIS.txt_4c_Op, "When",     THIS, "GetOpWhen")
            BINDEVENT(THIS.txt_4c_Op, "KeyPress",  THIS, "GetOpKeyPress")
            BINDEVENT(THIS.txt_4c_Op, "LostFocus", THIS, "GetOpLostFocus")

            *-- BINDEVENT: CommandGroups
            BINDEVENT(THIS.grp_4c_GrupoSalva, "Click", THIS, "GrupoSalvaClick")
            BINDEVENT(THIS.grp_4c_GrupoConf,  "Click", THIS, "GrupoConfClick")

            *-- BINDEVENT: Grade (principal) eventos
            BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")

            *-- BINDEVENT: Grade2 (resultado) eventos
            BINDEVENT(THIS.grd_4c_Grade2, "AfterRowColChange", THIS, "Grade2AfterRowColChange")

            *-- BINDEVENT: colunas editaveis da Grade (QtdDivs e QtdEtiqs)
            *-- Regra VFP9: BINDEVENT "Valid" nao funciona em TextBox.
            *-- Usar KeyPress (ENTER=13/TAB=9) para simular Valid + LostFocus para rede de seguranca.
            BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "KeyPress",  THIS, "GradeCol4KeyPress")
            BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "LostFocus", THIS, "GradeCol4LostFocus")
            BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeCol4When")
            BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress",  THIS, "GradeCol2KeyPress")
            BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "LostFocus", THIS, "GradeCol2LostFocus")
            BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "When",      THIS, "GradeCol2When")

            *-- BINDEVENT: EditBoxes LostFocus
            BINDEVENT(THIS.edt_4c_MemoObs, "LostFocus", THIS, "MemoObsLostFocus")
            BINDEVENT(THIS.edt_4c_Obss,    "LostFocus", THIS, "ObssLostFocus")

            *-- Ajustar caption do botao Gerar para modo Reinicia
            IF THIS.this_cOperacao = "R"
                THIS.grp_4c_GrupoSalva.Buttons(1).Caption = "\<Reinicia"
            ENDIF

            *-- Tornar todos os controles visiveis (exceto flutuantes)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
    * Picture de fundo + container cabecalho (cntSombra) com labels de titulo.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa do topo (equivalente ao "frame" da tela).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Imagem de fundo (pixel-perfect do legado)
        THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container cabecalho (cntSombra): fundo cinza + labels de titulo
        *----------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = 828
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top      = 18
                .Left     = 10
                .Width    = 769
                .Height   = 40
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top      = 19
                .Left     = 10
                .Width    = 769
                .Height   = 46
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarControles - Cria todos os objetos visuais do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControles()
        *-- Construir frame (picture + cabecalho)
        THIS.ConfigurarPageFrame()

        *-- Construir campos principais (labels, textboxes, editboxes)
        THIS.ConfigurarCamposPrincipais()

        *----------------------------------------------------------------------
        * CommandGroup Grupo_Salva: "Gerar O.P." + "Encerrar"
        *----------------------------------------------------------------------
        THIS.AddObject("grp_4c_GrupoSalva", "CommandGroup")
        WITH THIS.grp_4c_GrupoSalva
            .Top           = -1
            .Left          = 673
            .Width         = 160
            .Height        = 85
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH THIS.grp_4c_GrupoSalva.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Gerar O.P."
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDWITH
        WITH THIS.grp_4c_GrupoSalva.Buttons(2)
            .Top             = 5
            .Left            = 80
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH

        *----------------------------------------------------------------------
        * CommandGroup Grupo_Conf: "Confirmar" + "Encerrar" (oculto inicialmente)
        *----------------------------------------------------------------------
        THIS.AddObject("grp_4c_GrupoConf", "CommandGroup")
        WITH THIS.grp_4c_GrupoConf
            .Top           = -1
            .Left          = 674
            .Width         = 173
            .Height        = 110
            .ButtonCount   = 2
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH
        WITH THIS.grp_4c_GrupoConf.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Confirmar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDWITH
        WITH THIS.grp_4c_GrupoConf.Buttons(2)
            .Top             = 5
            .Left            = 80
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH

        *----------------------------------------------------------------------
        * Grade principal (Temp_DivOp) e Grade2 resultado (Temporario)
        *----------------------------------------------------------------------
        THIS.ConfigurarGrade()
        THIS.ConfigurarGrade2()
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPrincipais (Fase 5) - Campos principais do form operacional
    * Labels (OP/Produto), TextBoxes de entrada (Get_OP/Get_Produto) e EditBoxes
    * de observacao (Get_obss/fwmemo_obs). Chamado por ConfigurarControles.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPrincipais()
        *----------------------------------------------------------------------
        * Label "OP :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Op", "Label")
        WITH THIS.lbl_4c_Op
            .Top       = 87
            .Left      = 41
            .Width     = 23
            .Height    = 15
            .Caption   = "OP :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Get_OP: entrada do numero da OP
        *----------------------------------------------------------------------
        THIS.AddObject("txt_4c_Op", "TextBox")
        WITH THIS.txt_4c_Op
            .Top           = 83
            .Left          = 67
            .Width         = 108
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "999999999999"
            .MaxLength     = 12
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = " "
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Produto :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Produto", "Label")
        WITH THIS.lbl_4c_Produto
            .Top       = 87
            .Left      = 213
            .Width     = 47
            .Height    = 15
            .Caption   = "Produto :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Produto: exibe codigo do produto (readonly)
        *----------------------------------------------------------------------
        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top           = 83
            .Left          = 262
            .Width         = 108
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .Value         = " "
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * EditBox Get_obss: observacao da OP selecionada (Temp_DivOp.Obss)
        *----------------------------------------------------------------------
        THIS.AddObject("edt_4c_Obss", "EditBox")
        WITH THIS.edt_4c_Obss
            .Top           = 421
            .Left          = 11
            .Width         = 626
            .Height        = 94
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ControlSource = "Temp_DivOp.Obss"
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * EditBox fwmemo_obs: observacao das OPs geradas (Temporario.Obss)
        * Oculto inicialmente; exibido apos geracao em modo Divisao
        *----------------------------------------------------------------------
        THIS.AddObject("edt_4c_MemoObs", "EditBox")
        WITH THIS.edt_4c_MemoObs
            .Top           = 421
            .Left          = 11
            .Width         = 626
            .Height        = 94
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .ControlSource = "Temporario.Obss"
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Grade principal (Temp_DivOp)
    * 7 colunas: Pedido | Cliente | Cor | Tam | Qtd.Op | QtdDivs | Quantidade
    * Nota: Column2=QtdEtiqs, Column4=QtdDivs sao editaveis pelo usuario
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Grade", "Grid")
        loc_oGrd = THIS.grd_4c_Grade
        WITH loc_oGrd
            .Top           = 121
            .Left          = 11
            .Width         = 626
            .Height        = 293
            .FontName      = "Arial"
            .FontSize      = 8
            .ColumnCount   = 7
            .DeleteMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(238, 238, 238)
            .HeaderHeight  = 17
            .RecordMark    = .F.
            .RowHeight     = 17
            .ScrollBars    = 2
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .RecordSource  = "Temp_DivOp"
            .Visible       = .T.
        ENDWITH

        *-- Column1: Pedido (expressao Dopes + Numes - readonly)
        WITH loc_oGrd.Column1
            .Header1.Caption     = "Pedido"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .Text1.ControlSource = "ALLTRIM(Temp_DivOp.Dopes)+' '+ALLTRIM(STR(Temp_DivOp.Numes,6))"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 0
            .Text1.Margin        = 0
            .Width               = 160
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column2: Qtd.Op (QtdEtiqs) - editavel para divisao por etiquetas
        WITH loc_oGrd.Column2
            .Header1.Caption     = "Qtd.Op"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .Text1.ControlSource = "Temp_DivOp.QtdEtiqs"
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 1
            .Text1.Format        = "K"
            .Text1.InputMask     = "99999"
            .Text1.Margin        = 0
            .Width               = 85
            .ColumnOrder         = 6
            .Movable             = .F.
            .Resizable           = .F.
        ENDWITH

        *-- Column3: Quantidade (Qtds - readonly)
        WITH loc_oGrd.Column3
            .Header1.Caption     = "Quantidade"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temp_DivOp.Qtds"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 1
            .Text1.InputMask     = "999,999.999"
            .Text1.Margin        = 0
            .Width               = 102
            .ColumnOrder         = 5
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column4: Divisao (QtdDivs) - editavel para informar quantidade a dividir
        WITH loc_oGrd.Column4
            .Header1.Caption     = "Divis" + CHR(227) + "o"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .Text1.ControlSource = "Temp_DivOp.QtdDivs"
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 1
            .Text1.Format        = "K"
            .Text1.InputMask     = "999,999.999"
            .Text1.Margin        = 0
            .Width               = 85
            .ColumnOrder         = 7
            .Movable             = .F.
            .Resizable           = .F.
        ENDWITH

        *-- Column5: Cor (CodCors - readonly)
        WITH loc_oGrd.Column5
            .Header1.Caption     = "Cor"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temp_DivOp.CodCors"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Width               = 38
            .ColumnOrder         = 3
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column6: Tam (CodTams - readonly)
        WITH loc_oGrd.Column6
            .Header1.Caption     = "Tam"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temp_DivOp.CodTams"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Width               = 38
            .ColumnOrder         = 4
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column7: Cliente (Contas - readonly)
        WITH loc_oGrd.Column7
            .Header1.Caption     = "Cliente"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temp_DivOp.Contas"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Width               = 90
            .ColumnOrder         = 2
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade2 - Grade resultado (Temporario - oculto ate geracao)
    * 7 colunas: O.P. | Pedido | Cliente | Cor | Tam | Quantidade | Peso
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade2()
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Grade2", "Grid")
        loc_oGrd = THIS.grd_4c_Grade2
        WITH loc_oGrd
            .Top           = 121
            .Left          = 11
            .Width         = 626
            .Height        = 293
            .FontName      = "Arial"
            .FontSize      = 8
            .ColumnCount   = 7
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLineWidth = 1
            .GridLineColor = RGB(136, 189, 188)
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .RecordSource  = "Temporario"
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH

        *-- Column1: Pedido
        WITH loc_oGrd.Column1
            .Header1.Caption     = "Pedido"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .Text1.ControlSource = "ALLTRIM(Temporario.Dopes)+' '+ALLTRIM(STR(Temporario.Numes,6))"
            .Text1.ReadOnly      = .T.
            .Text1.Alignment     = 0
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 205
            .ColumnOrder         = 2
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column2: O.P. (Nops)
        WITH loc_oGrd.Column2
            .Header1.Caption     = "O.P."
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .Text1.ControlSource = "Temporario.Nops"
            .Text1.ReadOnly      = .T.
            .Text1.Alignment     = 1
            .Text1.BorderStyle   = 0
            .Text1.Format        = "K"
            .Text1.InputMask     = "9999999999"
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 80
            .ColumnOrder         = 1
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column3: Quantidade (Qtds)
        WITH loc_oGrd.Column3
            .Header1.Caption     = "Quantidade"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .Text1.ControlSource = "Temporario.Qtds"
            .Text1.ReadOnly      = .T.
            .Text1.Alignment     = 1
            .Text1.BorderStyle   = 0
            .Text1.InputMask     = "999,999.999"
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 80
            .ColumnOrder         = 6
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column4: Cor
        WITH loc_oGrd.Column4
            .Header1.Caption     = "Cor"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temporario.CodCors"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 38
            .ColumnOrder         = 4
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column5: Tam
        WITH loc_oGrd.Column5
            .Header1.Caption     = "Tam"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temporario.CodTams"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 24
            .ColumnOrder         = 5
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column6: Cliente (Contas)
        WITH loc_oGrd.Column6
            .Header1.Caption     = "Cliente"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temporario.Contas"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 80
            .ColumnOrder         = 3
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column7: Peso
        WITH loc_oGrd.Column7
            .Header1.Caption     = "Peso"
            .Header1.Alignment   = 2
            .Text1.ControlSource = "Temporario.Pesos"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 75
            .Movable             = .F.
            .Resizable           = .F.
            .Enabled             = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Define estado inicial do form operacional:
    * Grade principal visivel, Grade2 oculta, GrupoSalva ativo.
    * Chamado em InicializarForm e ao retornar do estado de revisao.
    *==========================================================================
    PROCEDURE ConfigurarPaginaLista()
        WITH THIS.grd_4c_Grade
            .Enabled = .T.
            .Visible = .T.
        ENDWITH
        WITH THIS.grd_4c_Grade2
            .Enabled = .F.
            .Visible = .F.
        ENDWITH
        WITH THIS.edt_4c_Obss
            .Enabled = .T.
            .Visible = .T.
        ENDWITH
        WITH THIS.edt_4c_MemoObs
            .Enabled = .F.
            .Visible = .F.
        ENDWITH
        WITH THIS.grp_4c_GrupoSalva
            .Enabled = .T.
            .Visible = .T.
        ENDWITH
        WITH THIS.grp_4c_GrupoConf
            .Enabled = .F.
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna estado visual do form operacional
    * par_nPagina: 1 = Entrada (Grade principal + GrupoSalva)
    *              2 = Revisao (Grade2 resultado + GrupoConf)
    * Sobrescreve FormBase.AlternarPagina que usa pgf_4c_Paginas inexistente.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        DO CASE
        CASE par_nPagina = 1
            THIS.ConfigurarPaginaLista()
            THIS.grd_4c_Grade.Refresh()
        CASE par_nPagina = 2
            WITH THIS.grd_4c_Grade
                .Enabled = .F.
                .Visible = .F.
            ENDWITH
            WITH THIS.grd_4c_Grade2
                .Enabled = .T.
                .Visible = .T.
                .Refresh()
            ENDWITH
            WITH THIS.edt_4c_Obss
                .Enabled = .F.
                .Visible = .F.
            ENDWITH
            WITH THIS.edt_4c_MemoObs
                .Enabled = .T.
                .Visible = .T.
            ENDWITH
            WITH THIS.grp_4c_GrupoSalva
                .Enabled = .F.
                .Visible = .F.
            ENDWITH
            WITH THIS.grp_4c_GrupoConf
                .Enabled = .T.
                .Visible = .T.
            ENDWITH
        ENDCASE
    ENDPROC

    *==========================================================================
    * GetOpWhen - Get_OP.When
    * Permite digitacao apenas enquanto Temporario estiver vazio
    *==========================================================================
    PROCEDURE GetOpWhen()
        RETURN RECCOUNT("Temporario") = 0
    ENDPROC

    *==========================================================================
    * GetOpKeyPress - Get_OP.KeyPress
    * Dispara GetOpValid ao pressionar ENTER(13) ou TAB(9)
    *==========================================================================
    PROCEDURE GetOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.GetOpValid()
        ENDIF
    ENDPROC

    *==========================================================================
    * GetOpValid - Valida OP e carrega Temp_DivOp / xNensi via BO.BuscarOP
    *==========================================================================
    PROCEDURE GetOpValid()
        LOCAL loc_nOp, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
            RETURN .T.
        ENDIF

        IF LEN(ALLTRIM(THIS.txt_4c_Op.Value)) > 10
            THIS.txt_4c_Op.Value = RIGHT(ALLTRIM(THIS.txt_4c_Op.Value), 10)
        ENDIF

        loc_nOp = VAL(THIS.txt_4c_Op.Value)

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.BuscarOP(loc_nOp)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GetOpValid")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
            THIS.grd_4c_Grade.Refresh()
        ELSE
            THIS.txt_4c_Op.Value      = " "
            THIS.txt_4c_Produto.Value = " "
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GetOpLostFocus - Get_OP.LostFocus
    * Se OP valida carregada, move foco para coluna QtdEtiqs da grade
    *==========================================================================
    PROCEDURE GetOpLostFocus()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND ;
           USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            THIS.grd_4c_Grade.Column2.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrupoSalvaClick - Grupo_Salva.Click
    * Botao 1 (Gerar O.P.): valida e chama BO.GerarNovaOP
    * Botao 2 (Encerrar): rollback e fecha
    *==========================================================================
    PROCEDURE GrupoSalvaClick()
        LOCAL loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs
        LOCAL loc_lSucesso, loc_oErro

        IF THIS.grp_4c_GrupoSalva.Value = 2
            ON KEY LABEL ENTER
            THIS.this_oBusinessObject.RollbackTransacao()
            THIS.Release()
            RETURN
        ENDIF

        *-- Botao 1: Gerar O.P.
        IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
            MsgAviso("OP n" + CHR(227) + "o informada!!", "Aviso")
            THIS.txt_4c_Op.SetFocus()
            RETURN
        ENDIF

        loc_nOp       = VAL(THIS.txt_4c_Op.Value)
        loc_nQtds     = 0
        loc_nQtdDivs  = 0
        loc_nQtdEtiqs = 0

        *-- Somar quantidades de Temp_DivOp para validacao
        IF USED("Temp_DivOp") AND RECCOUNT("Temp_DivOp") > 0
            SELECT SUM(Qtds) AS SQtds, SUM(QtdDivs) AS SQtdDivs, SUM(QtdEtiqs) AS SQtdEtiqs ;
                FROM Temp_DivOp INTO CURSOR cursor_4c_SumTmpDiv
            SELECT cursor_4c_SumTmpDiv
            GO TOP
            loc_nQtds     = NVL(cursor_4c_SumTmpDiv.SQtds,     0)
            loc_nQtdDivs  = NVL(cursor_4c_SumTmpDiv.SQtdDivs,  0)
            loc_nQtdEtiqs = NVL(cursor_4c_SumTmpDiv.SQtdEtiqs, 0)
            USE IN cursor_4c_SumTmpDiv
        ENDIF

        ON KEY LABEL ENTER

        *-- Delegar para BO
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.GerarNovaOP(;
                THIS.this_cOperacao, loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrupoSalvaClick")
        ENDTRY

        IF loc_lSucesso
            IF THIS.this_cOperacao = "D"
                *-- Divisao: ir para estado de revisao (Grade2 + GrupoConf)
                IF USED("Temp_DivOp")
                    SELECT Temp_DivOp
                    ZAP
                ENDIF
                SELECT Temporario
                GO TOP
                THIS.AlternarPagina(2)

                IF !THIS.this_lAutomatico
                    THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
                ENDIF

            ELSE
                *-- Reinicia: confirmar transacao automaticamente (sem revisao em Grade2)
                LOCAL loc_lCommit
                loc_lCommit = .F.
                TRY
                    loc_lCommit = THIS.this_oBusinessObject.ConfirmarGravacao()
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message, "Erro ao confirmar Reinicia")
                ENDTRY

                IF loc_lCommit
                    IF USED("Temp_DivOp")
                        SELECT Temp_DivOp
                        ZAP
                    ENDIF
                    THIS.txt_4c_Op.Value      = " "
                    THIS.txt_4c_Produto.Value = " "
                    THIS.AlternarPagina(1)

                    IF !THIS.this_lAutomatico
                        THIS.txt_4c_Op.SetFocus()
                    ENDIF
                    THIS.Refresh()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GrupoConfClick - Grupo_Conf.Click
    * Botao 1 (Confirmar): persiste Obss e faz COMMIT via BO
    * Botao 2 (Encerrar): rollback e fecha
    *==========================================================================
    PROCEDURE GrupoConfClick()
        LOCAL loc_lSucesso, loc_oErro

        IF THIS.grp_4c_GrupoConf.Value = 2
            ON KEY LABEL ENTER
            THIS.this_oBusinessObject.RollbackTransacao()
            THIS.Release()
            RETURN
        ENDIF

        *-- Botao 1: Confirmar
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.ConfirmarGravacao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrupoConfClick")
        ENDTRY

        IF loc_lSucesso
            IF USED("Temporario")
                SELECT Temporario
                ZAP
            ENDIF
            THIS.txt_4c_Op.Value      = " "
            THIS.txt_4c_Produto.Value = " "
            THIS.AlternarPagina(1)

            IF !THIS.this_lAutomatico
                THIS.txt_4c_Op.SetFocus()
            ENDIF
            THIS.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - Grade.AfterRowColChange
    * Atualiza editbox de observacao ao navegar entre linhas
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        THIS.edt_4c_Obss.Refresh()
    ENDPROC

    *==========================================================================
    * Grade2AfterRowColChange - Grade2.AfterRowColChange
    * Atualiza editbox de observacao ao navegar entre OPs geradas
    *==========================================================================
    PROCEDURE Grade2AfterRowColChange(par_nColIndex)
        THIS.edt_4c_MemoObs.Refresh()
    ENDPROC

    *==========================================================================
    * GradeCol4Valid - Column4 (QtdDivs) Valid
    * Regras: QtdDivs e QtdEtiqs mutuamente exclusivos; nao pode exceder Qtds
    *==========================================================================
    PROCEDURE GradeCol4Valid()
        LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
        loc_lOk       = .T.
        loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
        loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value

        IF loc_nValEtiq > 0 AND loc_nValDivisao > 0
            MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
            THIS.grd_4c_Grade.Column4.Text1.Value = 0
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            IF loc_nValDivisao > Temp_DivOp.Qtds
                MsgAviso("Quantidade a dividir n" + CHR(227) + ;
                         "o pode ser maior que a quantidade do Pedido...", "Aviso")
                THIS.grd_4c_Grade.Column4.Text1.Value = 0
                loc_lOk = .F.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * GradeCol4When - Column4 (QtdDivs) When
    * Define ENTER para avan?ar linha (DNARROW) quando em QtdDivs
    *==========================================================================
    PROCEDURE GradeCol4When()
        ON KEY LABEL ENTER KEYBOARD "{DNARROW}"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GradeCol4KeyPress - Column4 (QtdDivs) KeyPress
    * Simula Valid em ENTER(13)/TAB(9). Retorna 0 via binding de Valid nao
    * funciona em TextBox sob BINDEVENT; aqui resetamos o valor se invalido
    * e deixamos a tecla fluir para o VFP9 processar navegacao.
    *==========================================================================
    PROCEDURE GradeCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.GradeCol4Valid()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeCol4LostFocus - Column4 (QtdDivs) LostFocus
    * Rede de seguranca: aplica validacao ao sair da celula por click/mouse
    *==========================================================================
    PROCEDURE GradeCol4LostFocus()
        THIS.GradeCol4Valid()
    ENDPROC

    *==========================================================================
    * GradeCol2KeyPress - Column2 (QtdEtiqs) KeyPress
    *==========================================================================
    PROCEDURE GradeCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.GradeCol2Valid()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeCol2LostFocus - Column2 (QtdEtiqs) LostFocus
    *==========================================================================
    PROCEDURE GradeCol2LostFocus()
        THIS.GradeCol2Valid()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do form
    * recursivamente, EXCETO containers/controles flutuantes que devem
    * permanecer Visible=.F. ate serem alternados por AlternarPagina(2).
    *
    * Controles flutuantes (estado inicial oculto):
    *   - grd_4c_Grade2      : Grade resultado, aparece apos Gerar O.P.
    *   - edt_4c_MemoObs     : EditBox de obs das OPs geradas
    *   - grp_4c_GrupoConf   : Botoes Confirmar/Encerrar (modo revisao)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_j, loc_oCtrl, loc_cNome

        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            loc_cNome = UPPER(loc_oCtrl.Name)

            *-- Controles flutuantes: permanecem ocultos (alternados via AlternarPagina)
            *-- CNT_4C_SOMBRA: visibilidade gerenciada por ConfigurarPageFrame
            IF INLIST(loc_cNome, ;
                    "GRD_4C_GRADE2",    ;
                    "EDT_4C_MEMOOBS",   ;
                    "GRP_4C_GRUPOCONF", ;
                    "CNT_4C_SOMBRA")
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF

            *-- Recursao em Containers
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
                IF loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF

            *-- Recursao em Pages de PageFrame
            IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                FOR loc_j = 1 TO loc_oCtrl.PageCount
                    THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
                ENDFOR
            ENDIF
        ENDFOR

        loc_oCtrl = .NULL.
    ENDPROC

    *==========================================================================
    * GradeCol2Valid - Column2 (QtdEtiqs) Valid
    * Regras: mutuamente exclusivo com QtdDivs; > 1; nao pode exceder Qtds
    *==========================================================================
    PROCEDURE GradeCol2Valid()
        LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
        loc_lOk         = .T.
        loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
        loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value

        IF loc_nValDivisao > 0 AND loc_nValEtiq > 0
            MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
            THIS.grd_4c_Grade.Column2.Text1.Value = 0
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND loc_nValEtiq = 1
            MsgAviso("Informe somente Qtde maior que 1.", "Aviso")
            THIS.grd_4c_Grade.Column2.Text1.Value = 0
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            IF loc_nValEtiq > Temp_DivOp.Qtds
                MsgAviso("Quantidade de Etiquetas n" + CHR(227) + ;
                         "o pode ser maior que a quantidade do Pedido...", "Aviso")
                THIS.grd_4c_Grade.Column2.Text1.Value = 0
                loc_lOk = .F.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * GradeCol2When - Column2 (QtdEtiqs) When
    * Limpa binding ENTER (cancelando atalho de Column4) e libera celula
    * apenas quando Qtds > 1 (nao faz sentido dividir em etiquetas se qtd=1)
    *==========================================================================
    PROCEDURE GradeCol2When()
        ON KEY LABEL ENTER
        IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            RETURN (Temp_DivOp.Qtds > 1)
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * MemoObsLostFocus - fwmemo_obs.LostFocus
    *==========================================================================
    PROCEDURE MemoObsLostFocus()
        IF THIS.grd_4c_Grade2.Visible
            THIS.grd_4c_Grade2.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ObssLostFocus - Get_obss.LostFocus
    *==========================================================================
    PROCEDURE ObssLostFocus()
        IF THIS.grd_4c_Grade2.Visible
            THIS.grd_4c_Grade2.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExecutarModoAutomatico - Execucao automatica para divisao programatica
    * par_aNop: array [n,1]=Dopes, [n,2]=Numes, [n,3]=CodCors, [n,4]=CodTams,
    *           [n,5]=Emps, [n,6]=Nops, [n,7]=NovaOp(out), [n,8]=Qtds,
    *           [n,9]=QtdsGeradas(out)
    *==========================================================================
    PROCEDURE ExecutarModoAutomatico(par_aNop)
        LOCAL loc_nCnt, loc_llOk, loc_nOp

        IF TYPE("par_aNop", 1) # "A"
            RETURN .F.
        ENDIF

        THIS.this_lAutomatico = .T.
        THIS.Visible = .F.

        *-- Simular entrada de OP (primeiro elemento)
        loc_nOp = par_aNop[1, 6]
        THIS.txt_4c_Op.Value = ALLTRIM(STR(loc_nOp))
        THIS.GetOpValid()

        SELECT Temp_DivOp
        IF RECCOUNT() = 0
            RETURN .F.
        ENDIF

        *-- Distribuir QtdDivs conforme array
        loc_llOk = .F.
        FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
            SELECT Temp_DivOp
            GO TOP
            LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
                       Numes   = par_aNop[loc_nCnt, 2] AND ;
                       CodCors = par_aNop[loc_nCnt, 3] AND ;
                       CodTams = par_aNop[loc_nCnt, 4]
            IF !EOF()
                REPLACE QtdDivs WITH QtdDivs + par_aNop[loc_nCnt, 8]
                loc_llOk = .T.
            ENDIF
        ENDFOR

        IF !loc_llOk
            RETURN .F.
        ENDIF

        *-- Executar geracao
        THIS.GrupoSalvaClick()

        *-- Capturar OPs geradas de volta no array
        FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
            SELECT Temporario
            GO TOP
            LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
                       Numes   = par_aNop[loc_nCnt, 2] AND ;
                       CodCors = par_aNop[loc_nCnt, 3] AND ;
                       CodTams = par_aNop[loc_nCnt, 4] AND ;
                       Qtds    = par_aNop[loc_nCnt, 8]
            IF !EOF()
                par_aNop[loc_nCnt, 7] = Temporario.Nops
                par_aNop[loc_nCnt, 9] = Temporario.Qtds
            ENDIF
        ENDFOR

        *-- Confirmar
        THIS.GrupoConfClick()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Override de FormBase.BtnIncluirClick
    * Form OPERACIONAL: a inclusao real acontece via GrupoSalvaClick (Gerar O.P.).
    * Ao ser acionado (por atalho herdado ou automacao), delega para o fluxo
    * operacional principal: valida OP digitada e gera as novas OPs divididas.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.grp_4c_GrupoSalva.Value = 1
        THIS.GrupoSalvaClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Override de FormBase.BtnAlterarClick
    * Form OPERACIONAL: alteracao corresponde a revisao da divisao gerada.
    * Se Grade2 estiver ativa (estado de revisao), move foco para coluna O.P.
    * para o usuario editar as novas OPs. Caso contrario, posiciona foco na
    * coluna de divisao da grade principal para iniciar a alteracao.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF THIS.grd_4c_Grade2.Visible
            THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
        ELSE
            IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
                THIS.grd_4c_Grade.Column4.Text1.SetFocus()
            ELSE
                THIS.txt_4c_Op.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Override de FormBase.BtnVisualizarClick
    * Form OPERACIONAL: visualizacao corresponde ao estado de revisao da
    * divisao (Grade2). Alterna para pagina de revisao se houver Temporario
    * preenchido; caso contrario, mantem estado atual e move foco para OP.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF USED("Temporario") AND RECCOUNT("Temporario") > 0
            THIS.AlternarPagina(2)
        ELSE
            THIS.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Override de FormBase.BtnExcluirClick
    * Form OPERACIONAL: exclusao equivale a rollback da transacao em curso.
    * Confirma com usuario; se aprovado, faz rollback no BO e volta para
    * estado inicial de entrada (Grade principal + GrupoSalva).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Cancelar a divis" + CHR(227) + ;
                                    "o em andamento e descartar altera" + ;
                                    CHR(231) + CHR(245) + "es?", "Confirma" + ;
                                    CHR(231) + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF

        IF USED("Temp_DivOp")
            SELECT Temp_DivOp
            ZAP
        ENDIF
        IF USED("Temporario")
            SELECT Temporario
            ZAP
        ENDIF
        IF USED("xNensi")
            SELECT xNensi
            ZAP
        ENDIF

        THIS.txt_4c_Op.Value      = " "
        THIS.txt_4c_Produto.Value = " "
        THIS.AlternarPagina(1)
        THIS.txt_4c_Op.SetFocus()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Override de FormBase.BtnBuscarClick
    * Form OPERACIONAL: re-executa a validacao e carga da OP corrente.
    * Permite ao usuario recarregar o grid caso os dados tenham sido
    * alterados externamente sem precisar limpar e redigitar a OP.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
            THIS.GetOpValid()
        ELSE
            THIS.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Override de FormBase.BtnEncerrarClick
    * Form OPERACIONAL: faz rollback da transacao em aberto e fecha o form.
    * Equivale a clicar "Encerrar" nos CommandGroups de Salva ou Conf.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        ON KEY LABEL ENTER
        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Override de FormBase.BtnSalvarClick
    * Form OPERACIONAL: delega para o CommandGroup ativo.
    * Se estiver em modo revisao (GrupoConf visivel) -> ConfirmarGravacao.
    * Se estiver em modo entrada (GrupoSalva visivel) -> GerarNovaOP.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        IF THIS.grp_4c_GrupoConf.Visible AND THIS.grp_4c_GrupoConf.Enabled
            THIS.grp_4c_GrupoConf.Value = 1
            THIS.GrupoConfClick()
        ELSE
            THIS.grp_4c_GrupoSalva.Value = 1
            THIS.GrupoSalvaClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Override de FormBase.BtnCancelarClick
    * Form OPERACIONAL: cancela a divisao em andamento, faz rollback e
    * retorna ao estado inicial de entrada sem pedir confirmacao.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        ON KEY LABEL ENTER
        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF

        IF USED("Temp_DivOp")
            SELECT Temp_DivOp
            ZAP
        ENDIF
        IF USED("Temporario")
            SELECT Temporario
            ZAP
        ENDIF
        IF USED("xNensi")
            SELECT xNensi
            ZAP
        ENDIF

        THIS.txt_4c_Op.Value      = " "
        THIS.txt_4c_Produto.Value = " "
        THIS.AlternarPagina(1)
        THIS.txt_4c_Op.SetFocus()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para propriedades do BO
    * Form OPERACIONAL: propaga numero da OP, operacao e empresa corrente.
    * Chamado antes de qualquer persistencia (GerarNovaOP/ConfirmarGravacao).
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_nNops     = ALLTRIM(THIS.txt_4c_Op.Value)
        THIS.this_oBusinessObject.this_cOperacao = THIS.this_cOperacao
        THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere estado do BO para os controles do form
    * Form OPERACIONAL: atualiza campo de produto apos carga da OP.
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles de entrada
    * Form OPERACIONAL: Get_OP editavel apenas enquanto Temporario estiver
    * vazio (antes de gerar as OPs). Get_Produto sempre readonly.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lOpHabilitada
        loc_lOpHabilitada = par_lHabilitar AND (RECCOUNT("Temporario") = 0)
        THIS.txt_4c_Op.Enabled = loc_lOpHabilitada
        THIS.txt_4c_Op.ReadOnly = !loc_lOpHabilitada
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera todos os campos e cursores de trabalho
    * Form OPERACIONAL: limpa Get_OP, Get_Produto, Temp_DivOp, Temporario,
    * xNensi e retorna form ao estado inicial (Grade principal + GrupoSalva).
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_Op.Value      = " "
        THIS.txt_4c_Produto.Value = " "

        IF USED("Temp_DivOp")
            SELECT Temp_DivOp
            ZAP
        ENDIF
        IF USED("Temporario")
            SELECT Temporario
            ZAP
        ENDIF
        IF USED("xNensi")
            SELECT xNensi
            ZAP
        ENDIF

        THIS.AlternarPagina(1)
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega o grid principal para a OP corrente
    * Form OPERACIONAL: se OP informada, re-executa GetOpValid para repopular
    * Temp_DivOp e atualizar o grid; caso contrario, apenas limpa os cursores.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
            THIS.GetOpValid()
        ENDIF
        IF USED("Temp_DivOp")
            THIS.grd_4c_Grade.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta visibilidade dos CommandGroups conforme modo
    * Form OPERACIONAL: usa AlternarPagina para controlar GrupoSalva/GrupoConf.
    * Parametro par_cModo: "LISTA"/"ENTRADA" -> pagina 1, "DADOS"/"REVISAO" -> pagina 2.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        IF VARTYPE(par_cModo) = "C"
            IF UPPER(ALLTRIM(par_cModo)) = "DADOS" OR UPPER(ALLTRIM(par_cModo)) = "REVISAO"
                THIS.AlternarPagina(2)
            ELSE
                THIS.AlternarPagina(1)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Destrutor: rollback seguro + limpeza de key bindings
    *==========================================================================
    PROCEDURE Destroy()
        ON KEY LABEL ENTER
        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopdivBO.prg):
*------------------------------------------------------------------------------
* sigopdivBO.prg - Business Object para Separacao de Industrializacao
* Form OPERACIONAL: Divide/Reinicia Ordens de Producao (SigOpPic)
* Tabelas principais: SigOpPic, SigCdNec, SigCdNei, SigPdMvf, SigCdOpd
*------------------------------------------------------------------------------
DEFINE CLASS sigopdivBO AS BusinessBase

    *-- Tabela e chave
    this_cTabela          = "SigOpPic"
    this_cCampoChave      = "CidChaves"

    *-- Estado da operacao
    this_cOperacao        = ""       && 'D'=Divisao, 'R'=Reinicia
    this_cEmps            = ""       && Empresa corrente
    this_cDivisaoop       = " "      && Dopps da nova OP gerada
    this_cSigKey          = ""       && SigKeys de SigCdPac
    this_lAutomatico      = .F.      && Modo automatico
    this_lEnvelopado      = .F.      && OP envelopada
    this_nEnvelope        = 0        && Numero do envelope
    this_lTransacaoAberta = .F.      && Flag de transacao aberta no SQL Server

    *-- Parametros de configuracao (SigCdPam)
    this_cDivOps          = ""       && Operacao de divisao configurada
    this_cDoppPads        = ""       && DoppPads de SigCdPam
    this_cDoppServs       = ""       && DoppServs de SigCdPam

    *-- OP sendo processada (campos de SigOpPic)
    this_nNops            = 0        && Numero da OP (Nops)
    this_nNumps           = 0        && Numps (Int(Nops/10000))
    this_cDopps           = ""       && Dopps da OP original
    this_cDopes           = ""       && Dopes (pedido)
    this_nNumes           = 0        && Numes (item do pedido)
    this_cCpros           = ""       && Codigo do produto (Cpros)
    this_cDpros           = ""       && Descricao do produto (Dpros)
    this_nQtds            = 0        && Quantidade da OP (Qtds)
    this_nPesos           = 0        && Peso da OP (Pesos)
    this_cCodCors         = ""       && Codigo da cor (CodCors)
    this_cCodTams         = ""       && Codigo do tamanho (CodTams)
    this_cEmpds           = ""       && Empresa destino (Empds)
    this_cNotas           = ""       && Nota fiscal (Notas)
    this_cContas          = ""       && Conta (Contas)
    this_nCitens          = 0        && Sequencia do item (Citens)
    this_nSeqDivs         = 0        && Sequencia de divisao (SeqDivs)
    this_nNopMaes         = 0        && OP mae (NopMaes)
    this_cObss            = ""       && Observacao (Obss)
    this_cCidChaves       = ""       && Chave unica (CidChaves)
    this_cEmpDopNums      = ""       && Chave composta (EmpDopNums)
    this_cEmpDNps         = ""       && Chave composta (EmpDNps)
    this_cEmpDopNops      = ""       && Chave composta (EmpDopNops)
    this_lDivs            = .F.      && Flag OP dividida (Divs - BIT)
    this_nQtdCpnts        = 0        && Quantidade de componentes (QtdCpnts)
    this_dDataes          = {}       && Data da OP (Dataes)

    *-- Configuracao da operacao de divisao (SigCdOpd)
    this_cGruOrigs        = ""       && Grupo origem (GruOrigs)
    this_cConOrigs        = ""       && Conta origem (ConOrigs)
    this_cGruDests        = ""       && Grupo destino (GruDests)
    this_cConDests        = ""       && Conta destino (ConDests)
    this_lChkDests        = .F.      && Flag destino (ChkDests - BIT)
    this_lEnvelopes       = .F.      && Flag envelope (Envelopes - BIT)
    this_cTpPadraos       = ""       && Tipo padrao (TpPadraos)
    this_lAutos           = .F.      && Automatico (Autos - BIT)

    *-- Produto carregado para exibicao
    this_cProduto         = ""       && Descricao do produto para Get_Produto

    *--------------------------------------------------------------------------
    * Init - Inicializa propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "CidChaves"
            THIS.this_cEmps       = go_4c_Sistema.cCodEmpresa

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor SigOpPic
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nNops      = TratarNulo(Nops,      "N")
                THIS.this_nNumps     = TratarNulo(Numps,     "N")
                THIS.this_cDopps     = TratarNulo(Dopps,     "C")
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_nNumes     = TratarNulo(Numes,     "N")
                THIS.this_cCpros     = TratarNulo(Cpros,     "C")
                THIS.this_cDpros     = TratarNulo(Dpros,     "C")
                THIS.this_nQtds      = TratarNulo(Qtds,      "N")
                THIS.this_nPesos     = TratarNulo(Pesos,     "N")
                THIS.this_cCodCors   = TratarNulo(CodCors,   "C")
                THIS.this_cCodTams   = TratarNulo(CodTams,   "C")
                THIS.this_cEmpds     = TratarNulo(Empds,     "C")
                THIS.this_cNotas     = TratarNulo(Notas,     "C")
                THIS.this_nCitens    = TratarNulo(Citens,    "N")
                THIS.this_nSeqDivs   = TratarNulo(SeqDivs,   "N")
                THIS.this_nNopMaes   = TratarNulo(NopMaes,   "N")
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                THIS.this_lDivs      = NVL(Divs, .F.)
                THIS.this_nQtdCpnts  = TratarNulo(QtdCpnts, "N")
                IF TYPE("Dataes") = "D" OR TYPE("Dataes") = "T"
                    THIS.this_dDataes = IIF(EMPTY(Dataes), DATE(), CTOD(DTOC(Dataes)))
                ENDIF
                THIS.this_cObss      = NVL(Obss, "")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                THIS.this_cEmpDNps   = TratarNulo(EmpDNps,   "C")
                THIS.this_cEmpDopNops = TratarNulo(EmpDopNops, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigOpPic via SQLEXEC
    * Usado para persistir uma OP individual gerada no processo de divisao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpPic (" + ;
                       "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                       "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, QtdCpnts, " + ;
                       "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, Citens, Pesos, " + ;
                       "Locals, Ntrans, CodBarras, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cDivisaoop) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       "GETDATE(), " + ;
                       FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       EscaparSQL(THIS.this_cObss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeqDivs) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cCodCors) + ", " + ;
                       EscaparSQL(THIS.this_cCodTams) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNopMaes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdCpnts) + ", " + ;
                       EscaparSQL(THIS.this_cEmpds) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDNps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNops) + ", " + ;
                       EscaparSQL(THIS.this_cDpros) + ", " + ;
                       EscaparSQL(THIS.this_cNotas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCitens) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos) + ", " + ;
                       "' ', 0, 0, 0, 0, '   ', 0, 0, '')"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigOpPic via SQLEXEC
    * Atualiza quantidade, divisao, usuario e peso do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpPic SET " + ;
                       "Qtds = "     + FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       "SeqDivs = "  + FormatarNumeroSQL(THIS.this_nSeqDivs) + ", " + ;
                       "Divs = "     + IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                       "Imprs = 0, " + ;
                       "Usuars = "   + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "Pesos = "    + FormatarNumeroSQL(THIS.this_nPesos) + ", " + ;
                       "QtdCpnts = " + FormatarNumeroSQL(THIS.this_nQtdCpnts) + " " + ;
                       "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("U")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOP - Carrega OP para divisao/reiniciacao (logica de Get_OP.Valid)
    * Popula os cursores Temp_DivOp e xNensi para uso no grid
    * Retorna: .T. se OP valida e carregada, .F. caso contrario
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOP(par_nNop)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nPNop, loc_lcEdn, loc_lcBusca, loc_lChkSubn
        LOCAL loc_lBlqDivOps, loc_nCitem, loc_lcConta, loc_cChaveNensi

        loc_lSucesso = .F.
        loc_nCitem   = 1

        TRY
            *-- Limpar cursores de trabalho
            IF USED("Temp_DivOp")
                SELECT Temp_DivOp
                ZAP
            ENDIF
            IF USED("xNensi")
                SELECT xNensi
                ZAP
            ENDIF
            IF USED("Temporario")
                SELECT Temporario
                ZAP
            ENDIF

            IF par_nNop <= 0
                loc_lSucesso = .F.
            ENDIF
            loc_nPNop = par_nNop

            *-- Verificar envelope: SigCdOpd WHERE ChkDests = 1
            loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE ChkDests = 1"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpp") > 0
                SELECT cursor_4c_TmpOpp
                IF RECCOUNT() > 0
                    GO TOP
                    loc_lcBusca = THIS.this_cEmps + ALLTRIM(cursor_4c_TmpOpp.Dopps) + STR(loc_nPNop, 10)
                    loc_cSQL = "SELECT Nops, Numps FROM SigPdMvf WHERE EmpDnPs = " + EscaparSQL(loc_lcBusca)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas") > 0
                        SELECT cursor_4c_TmpMfas
                        IF RECCOUNT() > 0
                            GO TOP
                            loc_nPNop = cursor_4c_TmpMfas.Nops
                            THIS.this_lEnvelopado = .T.
                            THIS.this_nEnvelope   = cursor_4c_TmpMfas.Numps
                        ELSE
                            loc_cSQL = "SELECT Nops, NumPs FROM SigPdMvf " + ;
                                       "WHERE Nops = " + FormatarNumeroSQL(loc_nPNop) + ;
                                       " AND Dopps = " + EscaparSQL(ALLTRIM(cursor_4c_TmpOpp.Dopps))
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas2") > 0
                                SELECT cursor_4c_TmpMfas2
                                IF RECCOUNT() > 0
                                    GO TOP
                                    THIS.this_lEnvelopado = .T.
                                    THIS.this_nEnvelope   = cursor_4c_TmpMfas2.Numps
                                ENDIF
                                USE IN cursor_4c_TmpMfas2
                            ENDIF
                        ENDIF
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpOpp
            ENDIF

            *-- Carregar TmpOpi: SigOpPic WHERE Nops = pNop
            loc_cSQL = "SELECT TOP 1 Nops, Emps, Dopps, CodBarras FROM SigOpPic " + ;
                       "WHERE Nops = " + FormatarNumeroSQL(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") <= 0
                MsgErro("Falha na consulta de OP: " + TRANSFORM(loc_nPNop), "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpOpi
            IF RECCOUNT() = 0
                MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                USE IN cursor_4c_TmpOpi
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(cursor_4c_TmpOpi.Emps) <> ALLTRIM(THIS.this_cEmps)
                MsgErro("Op " + TRANSFORM(loc_nPNop) + " " + CHR(233) + " de outra empresa " + ;
                        ALLTRIM(cursor_4c_TmpOpi.Emps), "Erro")
                USE IN cursor_4c_TmpOpi
                loc_lSucesso = .F.
            ENDIF
            loc_lcEdn = ALLTRIM(cursor_4c_TmpOpi.Emps) + ALLTRIM(cursor_4c_TmpOpi.Dopps) + ;
                        STR(cursor_4c_TmpOpi.Nops, 10)
            THIS.this_cDivisaoop = ALLTRIM(cursor_4c_TmpOpi.Dopps)
            THIS.this_nNops      = loc_nPNop
            USE IN cursor_4c_TmpOpi

            *-- Verificar status (ChkSubn = encerrada) em SigCdNec
            loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec WHERE EmpDnPs = " + EscaparSQL(loc_lcEdn)
            loc_lChkSubn = .F.
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpNens") > 0
                SELECT cursor_4c_TmpNens
                IF RECCOUNT() = 0
                    USE IN cursor_4c_TmpNens
                    MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
                GO TOP
                loc_lChkSubn = NVL(cursor_4c_TmpNens.ChkSubn, .F.)
                USE IN cursor_4c_TmpNens
            ENDIF
            IF loc_lChkSubn
                MsgAviso("O.P. j" + CHR(225) + " foi encerrada!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Carregar LocalMfas: SigPdMvf WHERE Nops = pNop
            loc_cSQL = "SELECT Nops, Emps, Dopps, Numps, cIdChaves, Grupods, " + ;
                       "Contads, Grupoos, Contaos, Qtds, Pesos, Nenvs, Ordems, Datars, Datas, EmpDnPs " + ;
                       "FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(loc_nPNop) + ;
                       " ORDER BY Nops DESC, cIdChaves DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMfas") <= 0
                MsgErro("Falha na consulta de fases da OP", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMfas
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalMfas
                MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            GO TOP

            *-- Verificar bloqueio de divisao (SigCdGcr.BlqDivOps)
            loc_lBlqDivOps = .F.
            IF !EMPTY(ALLTRIM(cursor_4c_LocalMfas.Grupods))
                loc_cSQL = "SELECT TOP 1 BlqDivOps FROM SigCdGcr"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGccr") > 0
                    SELECT cursor_4c_TmpGccr
                    IF RECCOUNT() > 0
                        GO TOP
                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                        ELSE
                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                            ELSE
                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                ELSE
                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                    ELSE
                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                        ELSE
                                            loc_lBlqDivOps = (NVL(cursor_4c_TmpGccr.BlqDivOps, 0) = 1)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_TmpGccr
                ENDIF
            ENDIF
            IF loc_lBlqDivOps
                USE IN cursor_4c_LocalMfas
                MsgAviso("Setor Bloqueado para Divis" + CHR(227) + "o de Op!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            USE IN cursor_4c_LocalMfas

            *-- Carregar LocalOpi: SigOpPic WHERE Nops = pNop (todos os itens)
            loc_cSQL = "SELECT CidChaves, Dopes, Numes, Qtds, Dataes, Obss, SeqDivs, Cpros, " + ;
                       "CodCors, CodTams, Empds, Dpros, Notas, Citens, Pesos, CodBarras, EmpDopNums " + ;
                       "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi") <= 0
                MsgErro("Falha na consulta detalhada da OP", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalOpi
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalOpi
                MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            GO TOP
            IF NVL(cursor_4c_LocalOpi.CodBarras, 0) > 0
                USE IN cursor_4c_LocalOpi
                MsgAviso("Op de Servi" + CHR(231) + "o com Barra n" + CHR(227) + "o pode ser Dividido!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Set produto para exibicao
            THIS.this_cProduto = ALLTRIM(cursor_4c_LocalOpi.Cpros)

            *-- Para cada item: buscar conta e inserir em Temp_DivOp
            SELECT cursor_4c_LocalOpi
            GO TOP
            DO WHILE !EOF()
                loc_cSQL = "SELECT a.ContaOs, a.ContaDs, b.Globalizas, b.Servicos " + ;
                           "FROM SigMvCab a INNER JOIN SigCdOpe b ON a.Dopes = b.dopes " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_LocalOpi.EmpDopNums))
                loc_lcConta = ""
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest") > 0
                    SELECT cursor_4c_LocalEest
                    IF RECCOUNT() > 0
                        GO TOP
                        IF NVL(cursor_4c_LocalEest.Globalizas, 0) = 1 OR ;
                           NVL(cursor_4c_LocalEest.Servicos,   0) = 1
                            loc_lcConta = ALLTRIM(cursor_4c_LocalEest.ContaOs)
                        ELSE
                            loc_lcConta = ALLTRIM(cursor_4c_LocalEest.ContaDs)
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_LocalEest
                ENDIF

                *-- UPDATE SeqDivs no SigOpPic
                loc_cSQL = "UPDATE SigOpPic SET SeqDivs = " + FormatarNumeroSQL(loc_nCitem) + ;
                           " WHERE CidChaves = " + EscaparSQL(ALLTRIM(cursor_4c_LocalOpi.CidChaves))
                SQLEXEC(gnConnHandle, loc_cSQL)

                *-- INSERT INTO Temp_DivOp
                SET NULL ON
                INSERT INTO Temp_DivOp ;
                    (Dopes, Numes, Qtds, Dataes, Obss, SeqDivs, Cpros, CodCors, ;
                     CodTams, Empds, Dpros, Notas, Contas, Citens, Pesos) ;
                    VALUES (cursor_4c_LocalOpi.Dopes, cursor_4c_LocalOpi.Numes, ;
                            cursor_4c_LocalOpi.Qtds, cursor_4c_LocalOpi.Dataes, ;
                            cursor_4c_LocalOpi.Obss, loc_nCitem, ;
                            cursor_4c_LocalOpi.Cpros, cursor_4c_LocalOpi.CodCors, ;
                            cursor_4c_LocalOpi.CodTams, cursor_4c_LocalOpi.Empds, ;
                            cursor_4c_LocalOpi.Dpros, cursor_4c_LocalOpi.Notas, ;
                            loc_lcConta, cursor_4c_LocalOpi.Citens, cursor_4c_LocalOpi.Pesos)
                SET NULL OFF

                loc_nCitem = loc_nCitem + 1
                SELECT cursor_4c_LocalOpi
                SKIP
            ENDDO
            USE IN cursor_4c_LocalOpi

            *-- Carregar xNensi: SigCdNei via join com SigCdNec e SigCdOpd
            loc_cSQL = "SELECT a.*, b.Datas, c.SepPedras, c.GrComps " + ;
                       "FROM SigCdNei a " + ;
                       "INNER JOIN SigCdNec b ON a.Empdnps = b.EmpDnps " + ;
                       "INNER JOIN SigCdOpd c ON a.Dopps = c.Dopps " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(loc_nPNop) + ;
                       " ORDER BY b.Datas DESC, b.EmpDnPs DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNensi") > 0
                SELECT cursor_4c_LocalNensi
                IF RECCOUNT() > 0
                    GO TOP
                    *-- Verificar SepPedras/GrComps: avancar ate condicao valida
                    DO WHILE !EOF()
                        IF (NOT INLIST(NVL(cursor_4c_LocalNensi.SepPedras, 0), 1, 3)) AND ;
                           (NVL(cursor_4c_LocalNensi.GrComps, 0) = 1)
                            EXIT
                        ENDIF
                        SKIP
                    ENDDO
                    *-- Copiar grupo com mesmo EmpDnPs para xNensi
                    IF !EOF()
                        loc_cChaveNensi = ALLTRIM(cursor_4c_LocalNensi.EmpDnPs)
                        IF USED("xNensi")
                            loc_cSQL = "SELECT * FROM SigCdNei WHERE EmpDnPs = " + ;
                                       EscaparSQL(loc_cChaveNensi)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensiSrc") > 0
                                SELECT xNensi
                                ZAP
                                APPEND FROM DBF("cursor_4c_NensiSrc")
                                USE IN cursor_4c_NensiSrc
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                USE IN cursor_4c_LocalNensi
            ENDIF

            SELECT Temp_DivOp
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNovaOP - Gera nova OP por divisao ('D') ou reinicio ('R')
    * Abre transacao SQL Server, executa operacao, aguarda ConfirmarGravacao
    * par_cOperacao: 'D'=Divisao, 'R'=Reinicia
    * par_nNop: numero da OP sendo processada
    * par_nQtds: soma total de Qtds em Temp_DivOp
    * par_nQtdDivs: soma total de QtdDivs em Temp_DivOp
    * par_nQtdEtiqs: soma total de QtdEtiqs em Temp_DivOp
    * Retorna: .T. se operacao iniciada com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE GerarNovaOP(par_cOperacao, par_nNop, par_nQtds, par_nQtdDivs, par_nQtdEtiqs)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        LOCAL loc_nNumOp, loc_nNovaOp, loc_xPeso

        loc_lSucesso = .F.

        TRY
            *-- Validacoes de entrada
            IF par_cOperacao = "D"
                IF par_nQtds = par_nQtdDivs
                    MsgAviso("A OP n" + CHR(227) + "o pode ficar com quantidade = 0", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
                IF par_nQtdDivs = 0 AND par_nQtdEtiqs = 0
                    MsgAviso("Nenhuma OP foi gerada...", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Calcular numeracao da nova OP
            loc_nNumOp = INT(par_nNop / 10000)
            loc_cSQL = "SELECT MAX(Nops) AS MaxNops FROM SigOpPic WHERE Numps = " + ;
                       FormatarNumeroSQL(loc_nNumOp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMaxOp") <= 0
                MsgErro("Falha ao obter pr" + CHR(243) + "xima OP", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMaxOp
            GO TOP
            loc_nNovaOp = NVL(cursor_4c_LocalMaxOp.MaxNops, 0) + 1
            USE IN cursor_4c_LocalMaxOp

            *-- Calcular xPeso (soma de pesos em xNensi)
            loc_xPeso = 0
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0
                SELECT SUM(Pesos) AS SomaPesos FROM xNensi INTO CURSOR cursor_4c_xPesoTmp
                SELECT cursor_4c_xPesoTmp
                GO TOP
                loc_xPeso = NVL(cursor_4c_xPesoTmp.SomaPesos, 0)
                USE IN cursor_4c_xPesoTmp
            ENDIF

            *-- Iniciar transacao SQL Server
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") <= 0
                MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o", "Erro")
                loc_lSucesso = .F.
            ENDIF
            THIS.this_lTransacaoAberta = .T.

            *-- Delegar para metodo especifico
            IF par_cOperacao = "D"
                loc_lSucesso = THIS.GerarDivisao(par_nNop, loc_nNovaOp, ;
                                                 THIS.this_cDivisaoop, ;
                                                 par_nQtdDivs, par_nQtdEtiqs, loc_xPeso)
            ELSE
                loc_lSucesso = THIS.GerarReinicio(par_nNop, loc_nNovaOp, THIS.this_cDivisaoop)
            ENDIF

            IF !loc_lSucesso
                THIS.RollbackTransacao()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.RollbackTransacao()
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarGravacao - Confirma gravacao: atualiza Obss e faz COMMIT
    * Chamado quando usuario clica "Confirmar" apos revisar Grade2
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarGravacao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF !THIS.this_lTransacaoAberta
                MsgErro("Nenhuma transa" + CHR(231) + CHR(227) + "o aberta para confirmar", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Atualizar Obss em SigOpPic a partir de Temporario
            IF USED("Temporario") AND RECCOUNT("Temporario") > 0
                SELECT Temporario
                GO TOP
                DO WHILE !EOF()
                    LOCAL loc_nNopTemp, loc_cObssTemp, loc_nSeqTemp
                    LOCAL loc_cDopesTemp, loc_nNumesTemp
                    loc_nNopTemp   = Temporario.Nops
                    loc_nSeqTemp   = Temporario.SeqDivs
                    loc_cObssTemp  = NVL(Temporario.Obss, "")
                    loc_cDopesTemp = ALLTRIM(Temporario.Dopes)
                    loc_nNumesTemp = Temporario.Numes

                    loc_cSQL = "UPDATE SigOpPic SET Obss = " + EscaparSQL(loc_cObssTemp) + ;
                               " WHERE Nops = " + FormatarNumeroSQL(loc_nNopTemp) + ;
                               " AND Dopes = " + EscaparSQL(loc_cDopesTemp) + ;
                               " AND Numes = " + FormatarNumeroSQL(loc_nNumesTemp)
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    SELECT Temporario
                    SKIP
                ENDDO
            ENDIF

            *-- Atualizar CodTgOps nas OPs geradas (busca fresh da OP original)
            *-- cursor_4c_TmpOpi foi fechado em BuscarOP; usar this_nNops para re-query
            IF THIS.this_nNops > 0 AND USED("Temporario") AND RECCOUNT("Temporario") > 0
                LOCAL loc_cCodTgOps
                loc_cCodTgOps = ""
                loc_cSQL = "SELECT TOP 1 CodTgOps FROM SigOpPic WHERE Nops = " + ;
                           FormatarNumeroSQL(THIS.this_nNops)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCodTg") > 0
                    SELECT cursor_4c_TmpCodTg
                    IF RECCOUNT() > 0
                        GO TOP
                        loc_cCodTgOps = ALLTRIM(NVL(cursor_4c_TmpCodTg.CodTgOps, ""))
                    ENDIF
                    USE IN cursor_4c_TmpCodTg
                ENDIF
                IF !EMPTY(loc_cCodTgOps)
                    SELECT Temporario
                    GO TOP
                    DO WHILE !EOF()
                        loc_cSQL = "UPDATE SigOpPic SET CodTgOps = " + EscaparSQL(loc_cCodTgOps) + ;
                                   " WHERE Nops = " + FormatarNumeroSQL(Temporario.Nops)
                        SQLEXEC(gnConnHandle, loc_cSQL)
                        SELECT Temporario
                        SKIP
                    ENDDO
                ENDIF
            ENDIF

            *-- COMMIT
            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") > 0
                THIS.this_lTransacaoAberta = .F.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o", "Erro")
                THIS.RollbackTransacao()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.RollbackTransacao()
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RollbackTransacao - Desfaz transacao aberta
    *--------------------------------------------------------------------------
    PROCEDURE RollbackTransacao()
        IF THIS.this_lTransacaoAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            THIS.this_lTransacaoAberta = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Auto-rollback se transacao aberta ao destruir BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.RollbackTransacao()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarDivisao - Logica de divisao de OP (operacao 'D')
    * Traduz Grupo_Salva.Click para operacao 'D' em nova arquitetura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarDivisao(par_nNop, par_nNovaOp, par_cDivisaoop, ;
                                     par_nQtdDivs, par_nQtdEtiqs, par_xPeso)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nCitem, loc_nTotal, loc_llGeraOp
        LOCAL loc_nNovaOpCurr, loc_nQtdTb, loc_nPesoOpNew
        LOCAL loc_cIdsNec, loc_cIds, loc_cEmpDnPs

        loc_lSucesso = .F.
        loc_nCitem   = 500
        loc_nTotal   = 0
        loc_llGeraOp = .F.
        loc_nNovaOpCurr = par_nNovaOp

        TRY
            *-- Carregar LocalMfas: SigPdMvf WHERE Nops = par_nNop
            loc_cSQL = "SELECT * FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                       " ORDER BY Nops DESC, cIdChaves DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMfas") <= 0
                MsgErro("Falha ao carregar SigPdMvf", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMfas
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalMfas
                loc_lSucesso = .F.
            ENDIF
            GO TOP

            *-- Inserir SigCdNec para nova OP se houver QtdDivs
            IF par_nQtdDivs > 0
                loc_cIdsNec  = fUniqueIds()
                loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                loc_cSQL = "INSERT INTO SigCdNec (" + ;
                           "Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, " + ;
                           "Grupods, Contads, CidChaves, EmpDnPs, " + ;
                           "ChkSubn, Imprs, Lccs, TotPesos, GrvEnds, Procbals, ProcDbal, " + ;
                           "Naceites, Ntrans, Locals, NumBalDs, NumBals, CodObs, Empds, " + ;
                           "NConforms, Nlotes, Jobs, Pesolancs, Usulibs, ChkBaixa, Usuconfs, Retrabs, CodNConfs, Nops, Autos, LibProds, Vends, Docus) " + ;
                           "SELECT " + ;
                           EscaparSQL(THIS.this_cEmps) + ", " + ;
                           EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                           FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           "GETDATE(), " + ;
                           "GrupoDs, ContaDs, Grupods, Contads, " + ;
                           EscaparSQL(loc_cIdsNec) + ", " + ;
                           EscaparSQL(loc_cEmpDnPs) + ", " + ;
                           "0, 0, 0, 0, '', 0, 0, 0, 0, ' ', 0, 0, 0, ' ', 0, 0, 0, ' ', 0, ' ', 0, ' ', 0, ' ', 0, 0, ' ', ' ', ' ' " + ;
                           "FROM SigPdMvf WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                    MsgErro("Favor Reinicializar o Processo!!! (SigCdNec D)", "Erro")
                    USE IN cursor_4c_LocalMfas
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- SCAN Temp_DivOp: processar cada item com QtdDivs > 0
            SELECT Temp_DivOp
            GO TOP
            DO WHILE !EOF()
                IF Temp_DivOp.QtdDivs > 0
                    *-- Obter QtdTb: SigCdPro + SigCdGrp + SigPrMtz
                    loc_nQtdTb = THIS.ObterQtdTubos(ALLTRIM(Temp_DivOp.Cpros))
                    *-- Calcular peso proporcional
                    loc_nPesoOpNew = IIF(Temp_DivOp.Pesos = 0, 0, ;
                                        (Temp_DivOp.Pesos / Temp_DivOp.Qtds) * Temp_DivOp.QtdDivs)

                    *-- INSERT INTO SigOpPic (nova OP)
                    loc_cIds    = fUniqueIds()
                    loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                    loc_cSQL = "INSERT INTO SigOpPic (" + ;
                               "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                               "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, QtdCpnts, " + ;
                               "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, Citens, Pesos, " + ;
                               "Locals, Ntrans, CodBarras, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                               "VALUES (" + ;
                               EscaparSQL(THIS.this_cEmps) + ", " + ;
                               EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                               FormatarNumeroSQL(INT(loc_nNovaOpCurr / 10000)) + ", " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ", " + ;
                               FormatarNumeroSQL(Temp_DivOp.Numes) + ", " + ;
                               "GETDATE(), " + ;
                               FormatarDataSQL(Temp_DivOp.Dataes) + ", " + ;
                               FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ", " + ;
                               EscaparSQL(NVL(Temp_DivOp.Obss, "")) + ", " + ;
                               FormatarNumeroSQL(loc_nCitem) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Cpros)) + ", " + ;
                               "1, " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.CodTams)) + ", " + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               FormatarNumeroSQL(par_nNop) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdTb * Temp_DivOp.QtdDivs) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Empds)) + ", " + ;
                               EscaparSQL(loc_cIds) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Empds) + ALLTRIM(Temp_DivOp.Dopes) + ;
                                          STR(Temp_DivOp.Numes, 6)) + ", " + ;
                               EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                          STR(INT(loc_nNovaOpCurr / 10000), 10)) + ", " + ;
                               EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                          STR(loc_nNovaOpCurr, 10)) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Dpros)) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Notas)) + ", " + ;
                               FormatarNumeroSQL(Temp_DivOp.Citens) + ", " + ;
                               FormatarNumeroSQL(loc_nPesoOpNew) + ", " + ;
                               "' ', 0, 0, 0, 0, '   ', 0, 0, '')"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                        MsgErro("Favor Reinicializar o Processo!!! (INSERT SigOpPic)", "Erro")
                        USE IN cursor_4c_LocalMfas
                        loc_lSucesso = .F.
                    ENDIF

                    *-- INSERT INTO Temporario (cursor local para exibicao em Grade2)
                    SET NULL ON
                    INSERT INTO Temporario ;
                        (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, ;
                         Empds, Dpros, Notas, Contas) ;
                        VALUES (Temp_DivOp.Dopes, Temp_DivOp.Numes, Temp_DivOp.QtdDivs, ;
                                Temp_DivOp.Obss, loc_nNovaOpCurr, loc_nCitem, ;
                                Temp_DivOp.Cpros, Temp_DivOp.CodCors, Temp_DivOp.CodTams, ;
                                Temp_DivOp.Empds, Temp_DivOp.Dpros, Temp_DivOp.Notas, ;
                                Temp_DivOp.Contas)
                    SET NULL OFF

                    loc_nCitem = loc_nCitem + 1

                    *-- INSERT INTO SigPdMvf (nova entrada de fase)
                    SELECT cursor_4c_LocalMfas
                    GO TOP
                    loc_cIds    = fUniqueIds()
                    loc_cEmpDnPs = ALLTRIM(cursor_4c_LocalMfas.Emps) + ;
                                   ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                    loc_cSQL = "INSERT INTO SigPdMvf (" + ;
                               "Codpds, Contads, Contaos, Dataes, Dataps, Datars, Datas, " + ;
                               "Dopes, Dopps, Emps, Etiqs, Grupods, Grupoos, " + ;
                               "Nenvs, Nops, Numes, Numps, Opers, Ordems, Pesos, Qtds, " + ;
                               "Unids, Usuars, Locals, Ntrans, Cretrabs, CidChaves, EmpDnPs, " + ;
                               "EmpDopNums, ChkSubn, Ordemos, TmpMins) " + ;
                               "SELECT Codpds, Contads, Grupods, Dataes, Dataps, GETDATE(), Datas, " + ;
                               "Dopes, " + EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", Emps, Etiqs, " + ;
                               "Grupods, Grupods, " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               "Numes, " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               "Opers, " + ;
                               "CASE WHEN " + FormatarNumeroSQL(par_xPeso) + " = 0 THEN 1 ELSE Ordems END, " + ;
                               "0, " + ;
                               FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ", " + ;
                               "Unids, Usuars, Locals, Ntrans, Cretrabs, " + ;
                               EscaparSQL(loc_cIds) + ", " + ;
                               EscaparSQL(loc_cEmpDnPs) + ", " + ;
                               "EmpDopNums, ChkSubn, Ordemos, TmpMins " + ;
                               "FROM SigPdMvf WHERE cIdChaves = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                    IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                        MsgErro("Favor Reinicializar o Processo!!! (SigPdMvf D)", "Erro")
                        USE IN cursor_4c_LocalMfas
                        loc_lSucesso = .F.
                    ENDIF

                    *-- UPDATE SigOpPic original: reduzir Qtds, marcar Divs
                    loc_cSQL = "UPDATE SigOpPic SET " + ;
                               "Qtds = Qtds - " + FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ", " + ;
                               "SeqDivs = " + FormatarNumeroSQL(loc_nCitem - 1) + ", " + ;
                               "Divs = 1, Imprs = 0, " + ;
                               "Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "Pesos = (Pesos / CASE WHEN Qtds = 0 THEN 1 ELSE Qtds END) * " + ;
                               "(Qtds - " + FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ") " + ;
                               "WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                               " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                               " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes) + ;
                               " AND CodCors = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ;
                               " AND CodTams = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodTams))
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    *-- Inserir Temporario para items sem divisao (QtdDivs=0 e QtdEtiqs=0)
                ELSE
                    IF NVL(Temp_DivOp.QtdEtiqs, 0) = 0 AND NVL(Temp_DivOp.QtdDivs, 0) = 0
                        SET NULL ON
                        INSERT INTO Temporario ;
                            (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, ;
                             Empds, Dpros, Notas, Contas) ;
                            VALUES (Temp_DivOp.Dopes, Temp_DivOp.Numes, Temp_DivOp.Qtds, ;
                                    Temp_DivOp.Obss, par_nNop, Temp_DivOp.SeqDivs, ;
                                    Temp_DivOp.Cpros, Temp_DivOp.CodCors, Temp_DivOp.CodTams, ;
                                    Temp_DivOp.Empds, Temp_DivOp.Dpros, Temp_DivOp.Notas, ;
                                    Temp_DivOp.Contas)
                        SET NULL OFF
                    ENDIF
                ENDIF

                SELECT Temp_DivOp
                SKIP
            ENDDO

            IF loc_nCitem > 500
                loc_nNovaOpCurr = loc_nNovaOpCurr + 1
            ENDIF

            *-- Processar etiquetas (QtdEtiqs > 0)
            SELECT Temp_DivOp
            GO TOP
            DO WHILE !EOF()
                IF NVL(Temp_DivOp.QtdEtiqs, 0) > 0
                    LOCAL loc_nQtd, loc_nY, loc_nX
                    loc_nQtd = INT(Temp_DivOp.Qtds / Temp_DivOp.QtdEtiqs)
                    loc_nY   = IIF(Temp_DivOp.QtdEtiqs = 1, 1, Temp_DivOp.QtdEtiqs - 1)
                    loc_nQtdTb = THIS.ObterQtdTubos(ALLTRIM(Temp_DivOp.Cpros))

                    FOR loc_nX = 1 TO loc_nY
                        *-- INSERT INTO SigOpPic para cada etiqueta
                        loc_cIds    = fUniqueIds()
                        loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                       STR(loc_nNovaOpCurr, 10)
                        loc_cSQL = "INSERT INTO SigOpPic (" + ;
                                   "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                                   "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, QtdCpnts, " + ;
                                   "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, Citens, " + ;
                                   "Locals, Ntrans, CodBarras, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(THIS.this_cEmps) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                   FormatarNumeroSQL(INT(loc_nNovaOpCurr / 10000)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ", " + ;
                                   FormatarNumeroSQL(Temp_DivOp.Numes) + ", " + ;
                                   "GETDATE(), " + ;
                                   FormatarDataSQL(Temp_DivOp.Dataes) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtd) + ", " + ;
                                   EscaparSQL(NVL(Temp_DivOp.Obss, "")) + ", " + ;
                                   FormatarNumeroSQL(loc_nCitem) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Cpros)) + ", " + ;
                                   "1, " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.CodTams)) + ", " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   FormatarNumeroSQL(par_nNop) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdTb * loc_nQtd) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Empds)) + ", " + ;
                                   EscaparSQL(loc_cIds) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Empds) + ALLTRIM(Temp_DivOp.Dopes) + ;
                                              STR(Temp_DivOp.Numes, 6)) + ", " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(INT(loc_nNovaOpCurr / 10000), 10)) + ", " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(loc_nNovaOpCurr, 10)) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Dpros)) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Notas)) + ", " + ;
                                   FormatarNumeroSQL(Temp_DivOp.Citens) + ", " + ;
                                   "' ', 0, 0, 0, 0, '   ', 0, 0, '')"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            MsgErro("Favor Reinicializar o Processo!!! (SigOpPic Etiq)", "Erro")
                            USE IN cursor_4c_LocalMfas
                            loc_lSucesso = .F.
                        ENDIF

                        *-- INSERT INTO Temporario para etiqueta
                        SET NULL ON
                        INSERT INTO Temporario ;
                            (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, ;
                             Empds, Dpros, Notas, Contas) ;
                            VALUES (Temp_DivOp.Dopes, Temp_DivOp.Numes, loc_nQtd, ;
                                    Temp_DivOp.Obss, loc_nNovaOpCurr, loc_nCitem, ;
                                    Temp_DivOp.Cpros, Temp_DivOp.CodCors, Temp_DivOp.CodTams, ;
                                    Temp_DivOp.Empds, Temp_DivOp.Dpros, Temp_DivOp.Notas, ;
                                    Temp_DivOp.Contas)
                        SET NULL OFF

                        *-- INSERT INTO SigCdNec para etiqueta
                        SELECT cursor_4c_LocalMfas
                        GO TOP
                        loc_cIdsNec  = fUniqueIds()
                        loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                       STR(loc_nNovaOpCurr, 10)
                        loc_cSQL = "INSERT INTO SigCdNec (" + ;
                                   "Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, " + ;
                                   "Grupods, Contads, CidChaves, EmpDnPs, " + ;
                                   "ChkSubn, Imprs, Lccs, TotPesos, GrvEnds, Procbals, ProcDbal, " + ;
                                   "Naceites, Ntrans, Locals, NumBalDs, NumBals, CodObs, Empds, " + ;
                                   "NConforms, Nlotes, Jobs, Pesolancs, Usulibs, ChkBaixa, Usuconfs, Retrabs, CodNConfs, Nops, Autos, LibProds, Vends, Docus) " + ;
                                   "SELECT " + ;
                                   EscaparSQL(THIS.this_cEmps) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                                   "GETDATE(), " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   "GETDATE(), GrupoDs, ContaDs, Grupods, Contads, " + ;
                                   EscaparSQL(loc_cIdsNec) + ", " + ;
                                   EscaparSQL(loc_cEmpDnPs) + ", " + ;
                                   "0, 0, 0, 0, '', 0, 0, 0, 0, ' ', 0, 0, 0, ' ', 0, 0, 0, ' ', 0, ' ', 0, ' ', 0, ' ', 0, 0, ' ', ' ', ' ' " + ;
                                   "FROM SigPdMvf WHERE cIdChaves = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                        SQLEXEC(gnConnHandle, loc_cSQL)

                        *-- INSERT INTO SigPdMvf para etiqueta
                        SELECT cursor_4c_LocalMfas
                        GO TOP
                        loc_cIds    = fUniqueIds()
                        loc_cEmpDnPs = ALLTRIM(cursor_4c_LocalMfas.Emps) + ;
                                       ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                        loc_cSQL = "INSERT INTO SigPdMvf (" + ;
                                   "Codpds, Contads, Contaos, Dataes, Dataps, Datars, Datas, " + ;
                                   "Dopes, Dopps, Emps, Etiqs, Grupods, Grupoos, " + ;
                                   "Nenvs, Nops, Numes, Numps, Opers, Ordems, Pesos, Qtds, " + ;
                                   "Unids, Usuars, Locals, Ntrans, Cretrabs, CidChaves, EmpDnPs, " + ;
                                   "EmpDopNums, ChkSubn, Ordemos, TmpMins) " + ;
                                   "SELECT Codpds, Contads, Grupods, Dataes, Dataps, GETDATE(), Datas, " + ;
                                   "Dopes, " + EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", Emps, Etiqs, " + ;
                                   "Grupods, Grupods, " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", Numes, " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", Opers, " + ;
                                   "CASE WHEN " + FormatarNumeroSQL(par_xPeso) + " = 0 THEN 1 ELSE Ordems END, " + ;
                                   "0, " + FormatarNumeroSQL(loc_nQtd) + ", " + ;
                                   "Unids, Usuars, Locals, Ntrans, Cretrabs, " + ;
                                   EscaparSQL(loc_cIds) + ", " + ;
                                   EscaparSQL(loc_cEmpDnPs) + ", " + ;
                                   "EmpDopNums, ChkSubn, Ordemos, TmpMins " + ;
                                   "FROM SigPdMvf WHERE cIdChaves = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            MsgErro("Favor Reinicializar o Processo!!! (SigPdMvf Etiq)", "Erro")
                            USE IN cursor_4c_LocalMfas
                            loc_lSucesso = .F.
                        ENDIF

                        *-- UPDATE SigOpPic: reduzir quantidade original
                        loc_cSQL = "UPDATE SigOpPic SET " + ;
                                   "Qtds = Qtds - " + FormatarNumeroSQL(loc_nQtd) + ", " + ;
                                   "Divs = 1, Imprs = 0, " + ;
                                   "Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   "QtdCpnts = (QtdCpnts / CASE WHEN Qtds = 0 THEN 1 ELSE Qtds END) * " + ;
                                   "(Qtds - " + FormatarNumeroSQL(loc_nQtd) + ") " + ;
                                   "WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                                   " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                                   " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes) + ;
                                   " AND CodCors = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ;
                                   " AND CodTams = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodTams))
                        SQLEXEC(gnConnHandle, loc_cSQL)

                        loc_nNovaOpCurr = loc_nNovaOpCurr + 1
                        loc_nCitem = loc_nCitem + 1
                        loc_llGeraOp = .T.
                    NEXT

                    *-- INSERT residual no Temporario para item com etiquetas
                    loc_cSQL = "UPDATE SigOpPic SET SeqDivs = " + FormatarNumeroSQL(loc_nCitem) + ;
                               " WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                               " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                               " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes)
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    *-- Query SigOpPic residual para inserir em Temporario
                    loc_cSQL = "SELECT Dopes, Numes, Qtds, Obss, Nops, Cpros, CodCors, CodTams, " + ;
                               "Empds, Dpros, Notas FROM SigOpPic " + ;
                               "WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                               " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                               " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpiResidual") > 0
                        SELECT cursor_4c_OpiResidual
                        IF RECCOUNT() > 0
                            GO TOP
                            SET NULL ON
                            INSERT INTO Temporario ;
                                (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, ;
                                 CodTams, Empds, Dpros, Notas, Contas) ;
                                VALUES (cursor_4c_OpiResidual.Dopes, cursor_4c_OpiResidual.Numes, ;
                                        cursor_4c_OpiResidual.Qtds, cursor_4c_OpiResidual.Obss, ;
                                        cursor_4c_OpiResidual.Nops, loc_nCitem, ;
                                        cursor_4c_OpiResidual.Cpros, cursor_4c_OpiResidual.CodCors, ;
                                        cursor_4c_OpiResidual.CodTams, cursor_4c_OpiResidual.Empds, ;
                                        cursor_4c_OpiResidual.Dpros, cursor_4c_OpiResidual.Notas, ;
                                        Temp_DivOp.Contas)
                            SET NULL OFF
                        ENDIF
                        USE IN cursor_4c_OpiResidual
                    ENDIF
                    loc_nCitem = loc_nCitem + 1
                ENDIF

                SELECT Temp_DivOp
                SKIP
            ENDDO

            *-- Rateio de pesos do xNensi para os novos cursores SigCdNei
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0
                LOCAL loc_nPRatear, loc_nQRatear, loc_nQOrigin
                loc_nPRatear = 0
                loc_nQRatear = 0
                SELECT SUM(Pesos) AS SomaPes, SUM(Qtds) AS SomaQtd FROM xNensi INTO CURSOR cursor_4c_NensiSum
                SELECT cursor_4c_NensiSum
                GO TOP
                loc_nPRatear = NVL(cursor_4c_NensiSum.SomaPes, 0)
                loc_nQRatear = NVL(cursor_4c_NensiSum.SomaQtd, 0)
                USE IN cursor_4c_NensiSum

                SELECT SUM(Qtds) AS TotalQtd FROM Temp_DivOp INTO CURSOR cursor_4c_TotQtd
                SELECT cursor_4c_TotQtd
                GO TOP
                loc_nQOrigin = NVL(cursor_4c_TotQtd.TotalQtd, 0)
                USE IN cursor_4c_TotQtd

                IF loc_nPRatear <> 0 AND USED("Temporario") AND RECCOUNT("Temporario") > 0
                    *-- Para cada Nops distinto em Temporario, inserir SigCdNei rateado
                    SELECT Nops, SUM(Qtds) AS Qtds FROM Temporario GROUP BY Nops INTO CURSOR cursor_4c_TempDiv
                    SELECT cursor_4c_TempDiv
                    GO TOP
                    DO WHILE !EOF()
                        LOCAL loc_nOpDiv, loc_nQtDiv
                        loc_nOpDiv = cursor_4c_TempDiv.Nops
                        loc_nQtDiv = cursor_4c_TempDiv.Qtds

                        *-- INSERT SigCdNei rateado: SELECT + ajustes de peso/qtd
                        SELECT xNensi
                        GO TOP
                        DO WHILE !EOF()
                            loc_cIds = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdNei (" + ;
                                       "Aqtds, Cats, Cdescs, Cgrus, Cmats, Coefs, Contafs, Cunis, " + ;
                                       "Dopps, Emps, Fators, Flagincs, Grupofins, Grupofs, Moedas, Moeds, " + ;
                                       "Nenvs, Nops, Numps, Obss, Pesos, Qtds, Servicos, Tpops, " + ;
                                       "Locals, Ntrans, CidChaves, Nlotes, PesoFixs, Coefinfs, Cretrabs, " + ;
                                       "EmpDnPs, EmpDopNums, ChkSubn, CodCors, CodNConfs, CodTams, Peso2s, Custofs, Moecusfs, Estorno, Pvens) " + ;
                                       "VALUES (" + ;
                                       FormatarNumeroSQL(xNensi.Aqtds) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cats)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cdescs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cgrus)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cmats)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Coefs) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Contafs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cunis)) + ", " + ;
                                       EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Emps)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Fatores) + ", " + ;
                                       IIF(xNensi.Flagincs, "1", "0") + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Grupofins)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Grupofs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Moedas)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Moeds)) + ", " + ;
                                       IIF(xNensi.Nops <> loc_nOpDiv, "0", TRANSFORM(xNensi.Nenvs)) + ", " + ;
                                       FormatarNumeroSQL(loc_nOpDiv) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Numps) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Obss)) + ", " + ;
                                       FormatarNumeroSQL(IIF(loc_nQOrigin = 0, 0, ;
                                           xNensi.Pesos / loc_nQOrigin * loc_nQtDiv)) + ", " + ;
                                       FormatarNumeroSQL(IIF(loc_nQOrigin = 0, 0, ;
                                           xNensi.Qtds / loc_nQOrigin * loc_nQtDiv)) + ", " + ;
                                       IIF(xNensi.Servicos, "1", "0") + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Tpops)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Locals)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Ntrans) + ", " + ;
                                       EscaparSQL(loc_cIds) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Nlotes) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Pesofixs) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Coefinfs) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cretrabs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Emps) + ALLTRIM(par_cDivisaoop) + ;
                                                  STR(xNensi.Numps, 10)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.EmpDopNums)) + ", " + ;
                                       IIF(xNensi.Chksubn, "1", "0") + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.CodCors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.CodNConfs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.CodTams)) + ", " + ;
                                       FormatarNumeroSQL(IIF(loc_nQOrigin = 0, 0, ;
                                           xNensi.Peso2s / loc_nQOrigin * loc_nQtDiv)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Custofs) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Moecusfs)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Estorno) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Pvens) + ")"
                            SQLEXEC(gnConnHandle, loc_cSQL)
                            SELECT xNensi
                            SKIP
                        ENDDO

                        SELECT cursor_4c_TempDiv
                        SKIP
                    ENDDO
                    USE IN cursor_4c_TempDiv
                ENDIF
            ENDIF

            USE IN cursor_4c_LocalMfas
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarReinicio - Logica de reinicio de OP (operacao 'R')
    * Traduz Grupo_Salva.Click para operacao 'R' em nova arquitetura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarReinicio(par_nNop, par_nNovaOp, par_cDivisaoop)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cIds, loc_cEmpDnPs

        loc_lSucesso = .F.

        TRY
            *-- Carregar LocalMfas
            loc_cSQL = "SELECT * FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                       " ORDER BY Nops DESC, cIdChaves DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMfasR") <= 0
                MsgErro("Falha ao carregar SigPdMvf (R)", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMfasR
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF
            GO TOP

            *-- Buscar configuracao SigCdOpd para a divisaoop
            loc_cSQL = "SELECT TOP 1 GruOrigs, ConOrigs, GruDests, ConDests, TpPadraos " + ;
                       "FROM SigCdOpd WHERE Dopps = " + EscaparSQL(ALLTRIM(par_cDivisaoop))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpd") > 0
                SELECT cursor_4c_SigOpd
                IF RECCOUNT() > 0
                    GO TOP
                    THIS.this_cGruOrigs = ALLTRIM(cursor_4c_SigOpd.GruOrigs)
                    THIS.this_cConOrigs = ALLTRIM(cursor_4c_SigOpd.ConOrigs)
                    THIS.this_cGruDests = ALLTRIM(cursor_4c_SigOpd.GruDests)
                    THIS.this_cConDests = ALLTRIM(cursor_4c_SigOpd.ConDests)
                ENDIF
                USE IN cursor_4c_SigOpd
            ENDIF

            *-- Atualizar SigCdNec: ChkSubn = 1 para EmpDnPs da OP original
            loc_cSQL = "UPDATE SigCdNec SET ChkSubn = 1 " + ;
                       "WHERE EmpDnPs = " + ;
                       EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(par_nNop, 10))
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Favor Reinicializar o Processo!!! (Update SigCdNec R)", "Erro")
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF

            *-- INSERT INTO SigCdNec para nova OP (Reinicio)
            loc_cIds    = fUniqueIds()
            loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(par_nNovaOp, 10)
            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, " + ;
                       "Grupods, Contads, CidChaves, EmpDnPs, " + ;
                       "ChkSubn, Imprs, Lccs, TotPesos, GrvEnds, Procbals, ProcDbal, " + ;
                       "Naceites, Ntrans, Locals, NumBalDs, NumBals, CodObs, Empds, " + ;
                       "NConforms, Nlotes, Jobs, Pesolancs, Usulibs, ChkBaixa, Usuconfs, Retrabs, CodNConfs, Nops, Autos, LibProds, Vends, Docus) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", GETDATE(), " + ;
                       EscaparSQL(THIS.this_cGruOrigs) + ", " + ;
                       EscaparSQL(THIS.this_cConOrigs) + ", " + ;
                       EscaparSQL(THIS.this_cGruDests) + ", " + ;
                       EscaparSQL(THIS.this_cConDests) + ", " + ;
                       EscaparSQL(loc_cIds) + ", " + ;
                       EscaparSQL(loc_cEmpDnPs) + ", " + ;
                       "0, 0, 0, 0, '', 0, 0, 0, 0, ' ', 0, 0, 0, ' ', 0, 0, 0, ' ', 0, ' ', 0, ' ', 0, ' ', 0, 0, ' ', ' ', ' ')"
            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                MsgErro("Favor Reinicializar o Processo!!! (SigCdNec R)", "Erro")
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF

            *-- INSERT INTO SigPdMvf para nova OP (Reinicio)
            loc_cIds    = fUniqueIds()
            loc_cEmpDnPs = ALLTRIM(cursor_4c_LocalMfasR.Emps) + ;
                           ALLTRIM(par_cDivisaoop) + STR(par_nNovaOp, 10)
            loc_cSQL = "INSERT INTO SigPdMvf (" + ;
                       "Codpds, Contads, Contaos, Dataes, Dataps, Datars, Datas, " + ;
                       "Dopes, Dopps, Emps, Etiqs, Grupods, Grupoos, " + ;
                       "Nenvs, Nops, Numes, Numps, Opers, Ordems, Pesos, Qtds, " + ;
                       "Unids, Usuars, Locals, Ntrans, Cretrabs, CidChaves, EmpDnPs, " + ;
                       "EmpDopNums, ChkSubn, Ordemos, TmpMins) " + ;
                       "SELECT Codpds, Contads, " + ;
                       EscaparSQL(THIS.this_cConOrigs) + ", " + ;
                       "Dataes, Dataps, GETDATE(), Datas, Dopes, " + ;
                       EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", Emps, Etiqs, " + ;
                       EscaparSQL(THIS.this_cGruDests) + ", " + ;
                       EscaparSQL(THIS.this_cGruOrigs) + ", " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", Numes, " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", Opers, 1, 0, 0, " + ;
                       "Unids, Usuars, Locals, Ntrans, Cretrabs, " + ;
                       EscaparSQL(loc_cIds) + ", " + ;
                       EscaparSQL(loc_cEmpDnPs) + ", " + ;
                       "EmpDopNums, ChkSubn, Ordemos, TmpMins " + ;
                       "FROM SigPdMvf WHERE cIdChaves = " + ;
                       EscaparSQL(ALLTRIM(cursor_4c_LocalMfasR.cIdChaves))
            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                MsgErro("Favor Reinicializar o Processo!!! (SigPdMvf R)", "Erro")
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF

            *-- Para cada item em Temp_DivOp: copiar SigOpPic para nova OP
            SELECT Temp_DivOp
            GO TOP
            DO WHILE !EOF()
                *-- Buscar SigOpPic original para este item
                loc_cSQL = "SELECT CidChaves, Dopes, Numes, Qtds, Dataes, Obss, " + ;
                           "Cpros, CodCors, CodTams, Empds, Dpros, Notas, Citens, Pesos, " + ;
                           "EmpDopNums, SeqDivs " + ;
                           "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                           " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                           " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpiOrigR") > 0
                    SELECT cursor_4c_OpiOrigR
                    GO TOP
                    DO WHILE !EOF()
                        loc_cIds    = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigOpPic (" + ;
                                   "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                                   "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, " + ;
                                   "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, " + ;
                                   "Citens, Pesos, Locals, Ntrans, CodBarras, QtdCpnts, QtdTubos, " + ;
                                   "IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                                   "SELECT " + ;
                                   EscaparSQL(THIS.this_cEmps) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                   FormatarNumeroSQL(INT(par_nNovaOp / 10000)) + ", " + ;
                                   FormatarNumeroSQL(par_nNovaOp) + ", " + ;
                                   "Dopes, Numes, GETDATE(), Dataes, Qtds, Obss, SeqDivs, " + ;
                                   "Cpros, Divs, CodCors, CodTams, " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   FormatarNumeroSQL(par_nNop) + ", " + ;
                                   "Empds, " + EscaparSQL(loc_cIds) + ", " + ;
                                   "EmpDopNums, " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(INT(par_nNovaOp / 10000), 10)) + ", " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(par_nNovaOp, 10)) + ", " + ;
                                   "Dpros, Notas, Citens, Pesos, Locals, Ntrans, CodBarras, " + ;
                                   "QtdCpnts, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps " + ;
                                   "FROM SigOpPic WHERE CidChaves = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_OpiOrigR.CidChaves))
                        SQLEXEC(gnConnHandle, loc_cSQL)

                        SELECT cursor_4c_OpiOrigR
                        SKIP
                    ENDDO
                    USE IN cursor_4c_OpiOrigR
                ENDIF

                SELECT Temp_DivOp
                SKIP
            ENDDO

            USE IN cursor_4c_LocalMfasR
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterQtdTubos - Calcula quantidade de tubos/componentes para um produto
    * Equivalente ao bloco fwbuscaext SigCdPro + SigCdGrp + SigPrMtz do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterQtdTubos(par_cCpros)
        LOCAL loc_nQtdTb, loc_cSQL

        loc_nQtdTb = 0

        TRY
            *-- Buscar QtdCpnts e CGrus do produto
            loc_cSQL = "SELECT TOP 1 QtdCpnts, CGrus FROM SigCdPro WHERE Cpros = " + ;
                       EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") > 0
                SELECT cursor_4c_TmpPro
                IF RECCOUNT() > 0
                    GO TOP
                    LOCAL loc_nQtdCpnts, loc_cCGrus, loc_nGeraTubs
                    loc_nQtdCpnts = NVL(cursor_4c_TmpPro.QtdCpnts, 0)
                    loc_cCGrus    = ALLTRIM(NVL(cursor_4c_TmpPro.CGrus, ""))

                    *-- Buscar GeraTubs do grupo
                    loc_nGeraTubs = 0
                    IF !EMPTY(loc_cCGrus)
                        loc_cSQL = "SELECT TOP 1 GeraTubs FROM SigCdGrp"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGru") > 0
                            SELECT cursor_4c_TmpGru
                            IF RECCOUNT() > 0
                                GO TOP
                                loc_nGeraTubs = NVL(cursor_4c_TmpGru.GeraTubs, 0)
                            ENDIF
                            USE IN cursor_4c_TmpGru
                        ENDIF
                    ENDIF

                    IF loc_nGeraTubs <> 2
                        loc_nQtdTb = loc_nQtdCpnts
                    ELSE
                        *-- GeraTubs = 2: soma qtds de SigPrMtz
                        loc_cSQL = "SELECT SUM(qtds) AS Total FROM SigPrMtz WHERE Cpros = " + ;
                                   EscaparSQL(par_cCpros)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrMtz") > 0
                            SELECT cursor_4c_SigPrMtz
                            IF RECCOUNT() > 0
                                GO TOP
                                loc_nQtdTb = NVL(cursor_4c_SigPrMtz.Total, 0)
                            ENDIF
                            USE IN cursor_4c_SigPrMtz
                        ENDIF
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN NVL(loc_nQtdTb, 0)
    ENDPROC

ENDDEFINE


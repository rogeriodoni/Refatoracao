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
FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigrecsm
Erro: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-19 10:31:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-19 10:31:12] [INFO] Config FPW: (nao fornecido)
[2026-05-19 10:31:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-19 10:31:12] [INFO] Timeout: 300 segundos
[2026-05-19 10:31:12] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_dljfex2l.prg
[2026-05-19 10:31:12] [INFO] Conteudo do wrapper:
[2026-05-19 10:31:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecsm', 'C:\4c\tasks\task069', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecsm', 'C:\4c\tasks\task069', 'REPORT'
QUIT

[2026-05-19 10:31:12] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_dljfex2l.prg
[2026-05-19 10:31:12] [INFO] VFP output esperado em: C:\4c\tasks\task069\vfp_output.txt
[2026-05-19 10:31:12] [INFO] Executando Visual FoxPro 9...
[2026-05-19 10:31:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_dljfex2l.prg
[2026-05-19 10:31:12] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_dljfex2l.prg
[2026-05-19 10:31:12] [INFO] Timeout configurado: 300 segundos
[2026-05-19 10:31:18] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-19 10:31:18] [INFO] VFP9 finalizado em 6.2255381 segundos
[2026-05-19 10:31:18] [INFO] Exit Code: 
[2026-05-19 10:31:18] [INFO] 
[2026-05-19 10:31:18] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-19 10:31:18] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_dljfex2l.prg
[2026-05-19 10:31:18] [INFO] 
[2026-05-19 10:31:18] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-19 10:31:18] [INFO] * Auto-generated wrapper for parameters
[2026-05-19 10:31:18] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-19 10:31:18] [INFO] * Parameters: 'Formsigrecsm', 'C:\4c\tasks\task069', 'REPORT'
[2026-05-19 10:31:18] [INFO] 
[2026-05-19 10:31:18] [INFO] * Anti-dialog protections for unattended execution
[2026-05-19 10:31:18] [INFO] SET SAFETY OFF
[2026-05-19 10:31:18] [INFO] SET RESOURCE OFF
[2026-05-19 10:31:18] [INFO] SET TALK OFF
[2026-05-19 10:31:18] [INFO] SET NOTIFY OFF
[2026-05-19 10:31:18] [INFO] SYS(2335, 0)
[2026-05-19 10:31:18] [INFO] 
[2026-05-19 10:31:18] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecsm', 'C:\4c\tasks\task069', 'REPORT'
[2026-05-19 10:31:18] [INFO] QUIT
[2026-05-19 10:31:18] [INFO] 
[2026-05-19 10:31:18] [INFO] === Fim do Wrapper.prg ===
[2026-05-19 10:31:18] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrecsm",
  "timestamp": "20260519103118",
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecsm.prg):
*==============================================================================
* Formsigrecsm.prg
* Formulario de Relatorio de Comissao por Condicao de Pagamento
*
* Migrado de: SIGRECSM.SCX (frmrelatorio)
* Layout   : FLAT - controles direto no form, sem PageFrame
* Herda de : FormBase
*
* Filtros  : periodo, empresa, grupo (SigCdCrg), conta/vendedor (SigCdCli),
*            moeda (SigCdMoe), opcao de relatorio (4), checkbox comissao zerada
* Relatorios: SigReCs1 (nOpt=3), SigReCs2 (nOpt=1,2,4)
*==============================================================================

DEFINE CLASS Formsigrecsm AS FormBase

    *-- Propriedades visuais
    this_cMensagemErro = ""
    Height      = 300
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = " Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                  "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento "
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    WindowType  = 1
    BackColor   = RGB(192, 192, 192)
    ShowWindow  = 1

    *-- BO de relatorio
    this_oRelatorio = .NULL.

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init()
    * Cria BO, configura cabecalho, botoes, campos e BINDEVENTs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                    MsgErro("Erro de conex" + CHR(227) + "o com banco de dados.", "Erro")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            IF loc_lSucesso
                THIS.this_oRelatorio = CREATEOBJECT("sigrecsmBO")

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()
                THIS.ConfigurarBINDEVENTs()

                THIS.InicializarValoresPadrao()
                THIS.AtualizarEstados()

                THIS.Visible = .T.

                IF TYPE("THIS.txt_4c__dt_inicial") = "O"
                    THIS.txt_4c__dt_inicial.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - REPORT form usa layout FLAT (sem PageFrame)
    * Mantido como no-op para compatibilidade com a validacao multi-fase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - REPORT form usa layout FLAT (sem Page Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT form nao possui PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - REPORT form usa ConfigurarCampos como ponto unico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 25
            .Left      = 20
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                         "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Excel"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro direto no form (layout FLAT)
    * Posicoes mapeadas pixel-perfect do SIGRECSM.SCX original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        *-- === PERIODO top=96/101 ===
        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .Top       = 101
            .Left      = 169
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH THIS.txt_4c__dt_inicial
            .Top           = 96
            .Left          = 218
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH THIS.lbl_4c_Lbl_periodo_a
            .Top       = 103
            .Left      = 301
            .AutoSize  = .T.
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_final", "TextBox")
        WITH THIS.txt_4c__dt_final
            .Top           = 96
            .Left          = 312
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- === EMPRESA top=124/129 ===
        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Top       = 129
            .Left      = 164
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__empresa", "TextBox")
        WITH THIS.txt_4c__empresa
            .Top           = 124
            .Left          = 218
            .Width         = 31
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .Alignment     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__empresa_desc", "TextBox")
        WITH THIS.txt_4c__empresa_desc
            .Top           = 124
            .Left          = 251
            .Width         = 290
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === GRUPO (SigCdCrg) top=152/157 ===
        THIS.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH THIS.lbl_4c_Lbl_grupo
            .Top       = 157
            .Left      = 176
            .AutoSize  = .T.
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
        WITH THIS.txt_4c__Cd_GrEstoque
            .Top           = 152
            .Left          = 218
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
        WITH THIS.txt_4c__Ds_GrEstoque
            .Top           = 152
            .Left          = 299
            .Width         = 150
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 20
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === CONTA / VENDEDOR (SigCdCli) top=180/185 ===
        THIS.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH THIS.lbl_4c_Lbl_estoque
            .Top       = 185
            .Left      = 176
            .AutoSize  = .T.
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_estoque", "TextBox")
        WITH THIS.txt_4c__cd_estoque
            .Top           = 180
            .Left          = 218
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_estoque", "TextBox")
        WITH THIS.txt_4c__ds_estoque
            .Top           = 180
            .Left          = 299
            .Width         = 290
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === MOEDA (SigCdMoe) top=208/213 ===
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 213
            .Left      = 173
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Cmoeda", "TextBox")
        WITH THIS.txt_4c_Cmoeda
            .Top           = 208
            .Left          = 218
            .Width         = 31
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .Alignment     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Dmoeda", "TextBox")
        WITH THIS.txt_4c_Dmoeda
            .Top           = 208
            .Left          = 251
            .Width         = 115
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === TIPO / OPCAO RELATORIO top=239/240 ===
        THIS.AddObject("lbl_4c_Lbl_tipo", "Label")
        WITH THIS.lbl_4c_Lbl_tipo
            .Top       = 239
            .Left      = 182
            .AutoSize  = .T.
            .Caption   = " Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptRel", "OptionGroup")
        WITH THIS.obj_4c_OptRel
            .Top         = 240
            .Left        = 217
            .Width       = 463
            .Height      = 17
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "Si\<nt" + CHR(233) + "tico"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 1
            .Option1.Left      = 1
            .Option1.Width     = 59
            .Option1.Height    = 15
            .Option1.AutoSize  = .T.

            .Option2.Caption   = "\<Anal" + CHR(237) + "tico"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 1
            .Option2.Left      = 80
            .Option2.Width     = 58
            .Option2.Height    = 15
            .Option2.AutoSize  = .T.

            .Option3.Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 1
            .Option3.Left      = 162
            .Option3.Width     = 134
            .Option3.Height    = 15
            .Option3.AutoSize  = .T.

            .Option4.Caption   = "Comiss" + CHR(227) + "o dividida"
            .Option4.FontName  = "Tahoma"
            .Option4.FontSize  = 8
            .Option4.BackStyle = 0
            .Option4.ForeColor = RGB(90, 90, 90)
            .Option4.Top       = 1
            .Option4.Left      = 334
            .Option4.Width     = 131
            .Option4.Height    = 17
            .Option4.AutoSize  = .T.

            .Visible = .T.
        ENDWITH

        *-- === NAO INCLUIR COMISSAO ZERADA top=258 ===
        THIS.AddObject("chk_4c_FwChkComissao", "CheckBox")
        WITH THIS.chk_4c_FwChkComissao
            .Top           = 258
            .Left          = 218
            .AutoSize      = .T.
            .Alignment     = 0
            .Caption       = "N" + CHR(227) + "o incluir comiss" + CHR(227) + "o zerada"
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - F4=lookup, ENTER/TAB=validar, DblClick=lookup
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.txt_4c__empresa,       "KeyPress", THIS, "TeclaLookupEmpresaCod")
        BINDEVENT(THIS.txt_4c__empresa_desc,  "KeyPress", THIS, "TeclaLookupEmpresaDesc")
        BINDEVENT(THIS.txt_4c__empresa,       "DblClick", THIS, "AbrirBuscaEmpresaCod")
        BINDEVENT(THIS.txt_4c__empresa_desc,  "DblClick", THIS, "AbrirBuscaEmpresaDesc")

        BINDEVENT(THIS.txt_4c__Cd_GrEstoque,  "KeyPress", THIS, "TeclaLookupGrupoCod")
        BINDEVENT(THIS.txt_4c__Ds_GrEstoque,  "KeyPress", THIS, "TeclaLookupGrupoDesc")
        BINDEVENT(THIS.txt_4c__Cd_GrEstoque,  "DblClick", THIS, "AbrirBuscaGrupoCod")
        BINDEVENT(THIS.txt_4c__Ds_GrEstoque,  "DblClick", THIS, "AbrirBuscaGrupoDesc")

        BINDEVENT(THIS.txt_4c__cd_estoque,    "KeyPress", THIS, "TeclaLookupContaCod")
        BINDEVENT(THIS.txt_4c__ds_estoque,    "KeyPress", THIS, "TeclaLookupContaDesc")
        BINDEVENT(THIS.txt_4c__cd_estoque,    "DblClick", THIS, "AbrirBuscaContaCod")
        BINDEVENT(THIS.txt_4c__ds_estoque,    "DblClick", THIS, "AbrirBuscaContaDesc")

        BINDEVENT(THIS.txt_4c_Cmoeda,         "KeyPress", THIS, "TeclaLookupMoedaCod")
        BINDEVENT(THIS.txt_4c_Dmoeda,         "KeyPress", THIS, "TeclaLookupMoedaDesc")
        BINDEVENT(THIS.txt_4c_Cmoeda,         "DblClick", THIS, "AbrirBuscaMoedaCod")
        BINDEVENT(THIS.txt_4c_Dmoeda,         "DblClick", THIS, "AbrirBuscaMoedaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Define valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        LOCAL loc_nResult, loc_cSQL

        THIS.txt_4c__dt_inicial.Value = DATE()
        THIS.txt_4c__dt_final.Value   = DATE()

        *-- Empresa padrao: go_4c_Sistema.cCodEmpresa
        IF TYPE("go_4c_Sistema") = "O" AND !EMPTY(go_4c_Sistema.cCodEmpresa)
            THIS.txt_4c__empresa.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            THIS.ValidarEmpresaCod()
        ENDIF

        *-- Moeda padrao: SigCdPam.MoedaPs
        IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT MoedaPs FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_CsmPam
                    IF !EOF() AND !EMPTY(cursor_4c_CsmPam.MoedaPs)
                        THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_CsmPam.MoedaPs)
                        IF USED("cursor_4c_CsmPam")
                            USE IN cursor_4c_CsmPam
                        ENDIF
                        THIS.ValidarMoedaCod()
                    ELSE
                        IF USED("cursor_4c_CsmPam")
                            USE IN cursor_4c_CsmPam
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ESTADO DOS CONTROLES (cascata grupo -> conta)
    *==========================================================================

    PROTECTED PROCEDURE AtualizarEstados()
        THIS.AtualizarEstadoEmpresaDesc()
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoEmpresaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__empresa.Value))
            THIS.txt_4c__empresa_desc.ReadOnly  = .F.
            THIS.txt_4c__empresa_desc.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__empresa_desc.ReadOnly  = .T.
            THIS.txt_4c__empresa_desc.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoGrupoDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
            THIS.txt_4c__Ds_GrEstoque.ReadOnly  = .F.
            THIS.txt_4c__Ds_GrEstoque.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__Ds_GrEstoque.ReadOnly  = .T.
            THIS.txt_4c__Ds_GrEstoque.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoContaCd()
        IF EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
            THIS.txt_4c__cd_estoque.ReadOnly  = .T.
            THIS.txt_4c__cd_estoque.BackColor = RGB(240, 240, 240)
        ELSE
            THIS.txt_4c__cd_estoque.ReadOnly  = .F.
            THIS.txt_4c__cd_estoque.BackColor = RGB(255, 255, 255)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoContaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)) OR ;
           !EMPTY(ALLTRIM(THIS.txt_4c__cd_estoque.Value))
            THIS.txt_4c__ds_estoque.ReadOnly  = .T.
            THIS.txt_4c__ds_estoque.BackColor = RGB(240, 240, 240)
        ELSE
            THIS.txt_4c__ds_estoque.ReadOnly  = .F.
            THIS.txt_4c__ds_estoque.BackColor = RGB(255, 255, 255)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoMoedaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c_Cmoeda.Value))
            THIS.txt_4c_Dmoeda.ReadOnly  = .F.
            THIS.txt_4c_Dmoeda.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c_Dmoeda.ReadOnly  = .T.
            THIS.txt_4c_Dmoeda.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pelo codigo (SigCdEmp.Cemps)
    *==========================================================================

    PROCEDURE TeclaLookupEmpresaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresaCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__empresa_desc.Value = ""
            THIS.AtualizarEstadoEmpresaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(Razas)
            ELSE
                THIS.txt_4c__empresa_desc.Value = ""
                THIS.AbrirBuscaEmpresaCod()
            ENDIF
        ELSE
            THIS.txt_4c__empresa_desc.Value = ""
            THIS.AbrirBuscaEmpresaCod()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pela descricao (SigCdEmp.Razas)
    *==========================================================================

    PROCEDURE TeclaLookupEmpresaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__empresa_desc.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresaDesc()
        IF THIS.txt_4c__empresa_desc.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa_desc.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa_desc.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__empresa.Value = ""
            THIS.AtualizarEstadoEmpresaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpDescVal
            IF !EOF()
                THIS.txt_4c__empresa.Value      = ALLTRIM(Cemps)
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(Razas)
            ELSE
                THIS.AbrirBuscaEmpresaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
        IF USED("cursor_4c_EmpDescVal")
            USE IN cursor_4c_EmpDescVal
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - GRUPO pelo codigo (SigCdCrg.ccargs)
    *==========================================================================

    PROCEDURE TeclaLookupGrupoCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrupoCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", "cursor_4c_BuscaGrp", "ccargs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.ccargs)
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.dcargs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.ccargs)
                        THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.dcargs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__Ds_GrEstoque.Value = ""
            THIS.txt_4c__cd_estoque.Value   = ""
            THIS.txt_4c__ds_estoque.Value   = ""
            THIS.AtualizarEstadoGrupoDesc()
            THIS.AtualizarEstadoContaCd()
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT ccargs, dcargs FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrpVal
            IF !EOF()
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(dcargs)
            ELSE
                THIS.txt_4c__Ds_GrEstoque.Value = ""
                THIS.AbrirBuscaGrupoCod()
            ENDIF
        ELSE
            THIS.txt_4c__Ds_GrEstoque.Value = ""
            THIS.AbrirBuscaGrupoCod()
        ENDIF
        IF USED("cursor_4c_GrpVal")
            USE IN cursor_4c_GrpVal
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - GRUPO pela descricao (SigCdCrg.dcargs)
    *==========================================================================

    PROCEDURE TeclaLookupGrupoDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__Ds_GrEstoque.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrupoDesc()
        IF THIS.txt_4c__Ds_GrEstoque.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", "cursor_4c_BuscaGrpD", "dcargs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.ccargs)
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.dcargs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpD")
                        THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.ccargs)
                        THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.dcargs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrpD")
            USE IN cursor_4c_BuscaGrpD
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__Cd_GrEstoque.Value = ""
            THIS.txt_4c__cd_estoque.Value   = ""
            THIS.txt_4c__ds_estoque.Value   = ""
            THIS.AtualizarEstadoGrupoDesc()
            THIS.AtualizarEstadoContaCd()
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT ccargs, dcargs FROM SigCdCrg WHERE dcargs LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrpDescVal
            IF !EOF()
                THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(ccargs)
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(dcargs)
            ELSE
                THIS.AbrirBuscaGrupoDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaGrupoDesc()
        ENDIF
        IF USED("cursor_4c_GrpDescVal")
            USE IN cursor_4c_GrpDescVal
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - CONTA/VENDEDOR pelo codigo (SigCdCli.iclis)
    *==========================================================================

    PROCEDURE TeclaLookupContaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__cd_estoque.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaCod()
        IF THIS.txt_4c__cd_estoque.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca, loc_cWhere
        loc_cValor  = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
        loc_cWhere  = IIF(EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)), ;
                          "", ;
                          "ccargs = " + EscaparSQL(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)))
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta/Vendedor", ;
            .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                        THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                        THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarContaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__ds_estoque.Value = ""
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
        IF loc_nResult > 0
            SELECT cursor_4c_CliVal
            IF !EOF()
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(rclis)
            ELSE
                THIS.txt_4c__ds_estoque.Value = ""
                THIS.AbrirBuscaContaCod()
            ENDIF
        ELSE
            THIS.txt_4c__ds_estoque.Value = ""
            THIS.AbrirBuscaContaCod()
        ENDIF
        IF USED("cursor_4c_CliVal")
            USE IN cursor_4c_CliVal
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - CONTA/VENDEDOR pela descricao (SigCdCli.rclis)
    *==========================================================================

    PROCEDURE TeclaLookupContaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__ds_estoque.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaDesc()
        IF THIS.txt_4c__ds_estoque.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca, loc_cWhere
        loc_cValor  = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
        loc_cWhere  = IIF(EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)), ;
                          "", ;
                          "ccargs = " + EscaparSQL(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)))
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaCliD", "rclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta/Vendedor", ;
            .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.iclis)
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliD")
                        THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.iclis)
                        THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCliD")
            USE IN cursor_4c_BuscaCliD
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarContaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__cd_estoque.Value = ""
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE rclis LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_CliDescVal
            IF !EOF()
                THIS.txt_4c__cd_estoque.Value = ALLTRIM(iclis)
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(rclis)
            ELSE
                THIS.AbrirBuscaContaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaContaDesc()
        ENDIF
        IF USED("cursor_4c_CliDescVal")
            USE IN cursor_4c_CliDescVal
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pelo codigo (SigCdMoe.CMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_Cmoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_Cmoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Dmoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.txt_4c_Dmoeda.Value = ""
                THIS.AbrirBuscaMoedaCod()
            ENDIF
        ELSE
            THIS.txt_4c_Dmoeda.Value = ""
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pela descricao (SigCdMoe.DMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c_Dmoeda.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaDesc()
        IF THIS.txt_4c_Dmoeda.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_Dmoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoeD")
            USE IN cursor_4c_BuscaMoeD
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_Dmoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Cmoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                THIS.txt_4c_Cmoeda.Value = ALLTRIM(CMoes)
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.AbrirBuscaMoedaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF USED("cursor_4c_MoeDescVal")
            USE IN cursor_4c_MoeDescVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        THIS.this_oRelatorio.this_dDtInicial   = THIS.txt_4c__dt_inicial.Value
        THIS.this_oRelatorio.this_dDtFinal     = THIS.txt_4c__dt_final.Value
        THIS.this_oRelatorio.this_cCemps       = ALLTRIM(THIS.txt_4c__empresa.Value)
        THIS.this_oRelatorio.this_cRazas       = ALLTRIM(THIS.txt_4c__empresa_desc.Value)
        THIS.this_oRelatorio.this_cCdGrEstoque = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
        THIS.this_oRelatorio.this_cDsGrEstoque = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
        THIS.this_oRelatorio.this_cCdEstoque   = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
        THIS.this_oRelatorio.this_cDsEstoque   = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
        THIS.this_oRelatorio.this_cCmoes       = ALLTRIM(THIS.txt_4c_Cmoeda.Value)
        THIS.this_oRelatorio.this_cDmoes       = ALLTRIM(THIS.txt_4c_Dmoeda.Value)
        THIS.this_oRelatorio.this_nOptRel      = THIS.obj_4c_OptRel.Value
        THIS.this_oRelatorio.this_lChkComissao = (THIS.chk_4c_FwChkComissao.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de gerar o relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.txt_4c__dt_inicial.Value)
            MsgAviso("Data inicial " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Comiss" + CHR(227) + "o")
            THIS.txt_4c__dt_inicial.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.txt_4c__dt_final.Value)
            MsgAviso("Data final " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Comiss" + CHR(227) + "o")
            THIS.txt_4c__dt_final.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.txt_4c__dt_inicial.Value > THIS.txt_4c__dt_final.Value
            MsgAviso("Data inicial n" + CHR(227) + "o pode ser maior que a data final.", ;
                     "Comiss" + CHR(227) + "o")
            THIS.txt_4c__dt_inicial.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.txt_4c_Cmoeda.Value))
            MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria para convers" + ;
                     CHR(227) + "o de valores.", "Comiss" + CHR(227) + "o")
            THIS.txt_4c_Cmoeda.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Impressao com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cursor tempo para planilha XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_oErro
        loc_cArquivo = ""

        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    IF USED("tempo") AND RECCOUNT("tempo") > 0
                        loc_cArquivo = ADDBS(SYS(2023)) + "Comissao_" + DTOS(DATE()) + ;
                                       "_" + STRTRAN(TIME(), ":", "") + ".xls"
                        SELECT tempo
                        COPY TO (loc_cArquivo) TYPE XLS

                        IF FILE(loc_cArquivo)
                            DECLARE INTEGER ShellExecute IN shell32.dll ;
                                INTEGER hndWin, STRING cAction, ;
                                STRING cFileName, STRING cParams, ;
                                STRING cDir, INTEGER nShowWin
                            ShellExecute(0, "open", loc_cArquivo, "", "", 1)
                        ELSE
                            MsgErro("Erro ao gerar arquivo Excel.", "Comiss" + CHR(227) + "o")
                        ENDIF
                    ELSE
                        MsgAviso("Nenhum dado para exportar.", "Comiss" + CHR(227) + "o")
                    ENDIF
                ELSE
                    MsgErro("Erro ao preparar dados: " + THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Comiss" + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrecsm.BtnExcelClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Redefine todos os filtros para os valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c__dt_inicial.Value    = DATE()
        THIS.txt_4c__dt_final.Value      = DATE()
        THIS.txt_4c__empresa.Value       = ""
        THIS.txt_4c__empresa_desc.Value  = ""
        THIS.txt_4c__Cd_GrEstoque.Value  = ""
        THIS.txt_4c__Ds_GrEstoque.Value  = ""
        THIS.txt_4c__cd_estoque.Value    = ""
        THIS.txt_4c__ds_estoque.Value    = ""
        THIS.txt_4c_Cmoeda.Value         = ""
        THIS.txt_4c_Dmoeda.Value         = ""
        THIS.obj_4c_OptRel.Value         = 1
        THIS.chk_4c_FwChkComissao.Value  = 0
        THIS.AtualizarEstados()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT: todos os filtros ficam editaveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        THIS.txt_4c__dt_inicial.ReadOnly = .F.
        THIS.txt_4c__dt_final.ReadOnly   = .F.
        THIS.txt_4c__empresa.ReadOnly    = .F.
        THIS.txt_4c_Cmoeda.ReadOnly      = .F.
        THIS.txt_4c__Cd_GrEstoque.ReadOnly = .F.
        THIS.AtualizarEstados()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT: nao ha grid de lista; retorna .T. por contrato
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT: botoes permanecem sempre no mesmo estado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Delega a FormParaRelatorio (contrato FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO de volta para os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.txt_4c__dt_inicial.Value    = THIS.this_oRelatorio.this_dDtInicial
            THIS.txt_4c__dt_final.Value      = THIS.this_oRelatorio.this_dDtFinal
            THIS.txt_4c__empresa.Value       = THIS.this_oRelatorio.this_cCemps
            THIS.txt_4c__empresa_desc.Value  = THIS.this_oRelatorio.this_cRazas
            THIS.txt_4c__Cd_GrEstoque.Value  = THIS.this_oRelatorio.this_cCdGrEstoque
            THIS.txt_4c__Ds_GrEstoque.Value  = THIS.this_oRelatorio.this_cDsGrEstoque
            THIS.txt_4c__cd_estoque.Value    = THIS.this_oRelatorio.this_cCdEstoque
            THIS.txt_4c__ds_estoque.Value    = THIS.this_oRelatorio.this_cDsEstoque
            THIS.txt_4c_Cmoeda.Value         = THIS.this_oRelatorio.this_cCmoes
            THIS.txt_4c_Dmoeda.Value         = THIS.this_oRelatorio.this_cDmoes
            THIS.obj_4c_OptRel.Value         = THIS.this_oRelatorio.this_nOptRel
            THIS.chk_4c_FwChkComissao.Value  = IIF(THIS.this_oRelatorio.this_lChkComissao, 1, 0)
            THIS.AtualizarEstados()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT: limpa filtros para nova consulta
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
        THIS.AtualizarEstados()
        THIS.Refresh()
        IF TYPE("THIS.txt_4c__dt_inicial") = "O"
            THIS.txt_4c__dt_inicial.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: executa preview com filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT: foca o primeiro filtro para reedicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AtualizarEstados()
        THIS.Refresh()
        IF TYPE("THIS.txt_4c__dt_inicial") = "O"
            THIS.txt_4c__dt_inicial.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT: descarta cursores de dados gerados
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF USED("tempo")
            USE IN tempo
        ENDIF
        IF USED("tempo2")
            USE IN tempo2
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_cMensagemErro = ""
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT: nao se aplica
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este relat" + CHR(243) + "rio n" + CHR(227) + "o possui " + ;
                 "opera" + CHR(231) + CHR(227) + "o de salvamento." + CHR(13) + ;
                 "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
                 "Comiss" + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecsmBO.prg):
*==============================================================================
* SIGRECSMBO.PRG
* Business Object - Relatorio de Comissao por Condicao de Pagamento
* Herda de RelatorioBase
*
* Formulario original: SIGRECSM.SCX (frmrelatorio)
* Tabelas: SigMvCab, SigMvPar, SigCdOpe, SigOpFp, SigCdEmp, SigCdCli, SigCdCrg
* Relatorios FRX: SigReCs1 (Condicao Pgto), SigReCs2 (Sintetico/Analitico/Dividido)
*
* Cursores FRX (nomes fixos para compatibilidade):
*   cabecalho - cabecalho do relatorio (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo)
*   tempo     - dados principais para nOpt=1,2,4
*   tempo2    - dados agrupados por condicao de pagamento para nOpt=3
*==============================================================================

DEFINE CLASS sigrecsmBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: empresa (SigCdEmp - cemps / razas)
    this_cCemps         = ""
    this_cRazas         = ""

    *-- Filtros: grupo de vendedor (get_cd_grestoque / get_Ds_GrEstoque)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: vendedor / conta (get_cd_estoque / get_ds_estoque)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: moeda (SigCdMoe - cmoes / dmoes)
    this_cCmoes         = ""
    this_cDmoes         = ""

    *-- Opcao de relatorio: 1=Sintetico, 2=Analitico, 3=Cond.Pgto, 4=Comissao Dividida
    this_nOptRel        = 1

    *-- Nao incluir comissao zerada (FwChkComissao)
    this_lChkComissao   = .F.

    *-- Cursor de dados principal (nome FRX-compativel)
    this_cCursorDados       = "tempo"
    this_cCursorCabecalho   = "cabecalho"

    *-- Caminhos dos FRX
    *-- FRX1: nOpt=3 (Condicao de Pagamento)
    *-- FRX2: nOpt=1,2,4 (Sintetico, Analitico, Comissao Dividida)
    this_cCaminhoFrx1   = ""
    this_cCaminhoFrx2   = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCaminhoFrx1 = gc_4c_CaminhoReports + "SigReCs1.frx"
            THIS.this_cCaminhoFrx2 = gc_4c_CaminhoReports + "SigReCs2.frx"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecsmBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa filtros e monta cursores para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado (SIGRECSM)
    *
    * Fluxo:
    *   1. Carrega SigCdCot em cursor_4c_CsmCot (para CarregarCambioCSM)
    *   2. Busca nome da empresa para cabecalho
    *   3. Cria cursor cabecalho com dados do titulo do relatorio
    *   4. SQLEXEC query principal (SigMvCab/Par/Ope/Fp/Emp/Cli/Crg) em cursor_4c_CsmTemp
    *   5. SELECT local de cursor_4c_CsmTemp para cursor tempo (por nOpt)
    *   6. Se this_lChkComissao: remove registros com comissao zero
    *   7. Se nOpt=3: JOIN com SigPrInf para agrupar por condicao pagto em tempo2
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cDGrupo, loc_cConta, loc_cCmoes, loc_cDmoes
        LOCAL loc_nOpt
        LOCAL loc_cDataIni, loc_cDataFim
        LOCAL loc_cEmpWhere, loc_cGrupoWhere, loc_cContaWhere
        LOCAL loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo
        LOCAL loc_cVerVendedor

        loc_lSucesso = .F.

        TRY
            *-- Le filtros do BO
            loc_cEmpresa = PADR(ALLTRIM(THIS.this_cCemps), 3)
            loc_cGrupo   = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
            loc_cDGrupo  = PADR(ALLTRIM(THIS.this_cDsGrEstoque), 20)
            loc_cConta   = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
            loc_cCmoes   = PADR(ALLTRIM(THIS.this_cCmoes), 3)
            loc_cDmoes   = PADR(ALLTRIM(THIS.this_cDmoes), 15)
            loc_nOpt     = THIS.this_nOptRel

            *-- Formata datas para SQL Server
            loc_cDataIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDataFim = "'" + STR(YEAR(THIS.this_dDtFinal), 4) + "-" + ;
                           PADL(LTRIM(STR(MONTH(THIS.this_dDtFinal))), 2, "0") + "-" + ;
                           PADL(LTRIM(STR(DAY(THIS.this_dDtFinal))), 2, "0") + " 23:59:59'"

            *-- ================================================================
            *-- STEP 1: Carrega cotacoes para conversao de moeda (CarregarCambioCSM)
            *-- ================================================================
            IF USED("cursor_4c_CsmCot")
                USE IN cursor_4c_CsmCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", ;
                "cursor_4c_CsmCot")
            IF loc_nResult > 0
                SELECT cursor_4c_CsmCot
                INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            ENDIF

            *-- ================================================================
            *-- STEP 2: Busca nome da empresa para cabecalho do relatorio
            *-- ================================================================
            loc_cNomeEmpresa = ""
            IF USED("cursor_4c_CsmEmp")
                USE IN cursor_4c_CsmEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(ALLTRIM(loc_cEmpresa)), ;
                "cursor_4c_CsmEmp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_CsmEmp")
                SELECT cursor_4c_CsmEmp
                loc_cNomeEmpresa = ALLTRIM(cursor_4c_CsmEmp.razas)
            ENDIF

            *-- ================================================================
            *-- STEP 3: Monta strings do cabecalho e cria cursor cabecalho
            *-- ================================================================
            loc_cRelTitulo = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o de Vendedor por Condi" + CHR(231) + CHR(227) + ;
                             "o de Pagamento"
            loc_cRelTitul2 = "Relat" + CHR(243) + "rio " + ;
                             IIF(loc_nOpt = 1, "Sint" + CHR(233) + "tico", ;
                             IIF(loc_nOpt = 2, "Anal" + CHR(237) + "tico", ;
                             "Tipo Cond.Pagto")) + "  -  " + ;
                             IIF(EMPTY(ALLTRIM(loc_cGrupo)), ;
                             "Todos os Grupos", ;
                             "Grupo :" + ALLTRIM(loc_cGrupo) + ;
                             " - " + ALLTRIM(loc_cDGrupo)) + "  -  " + ;
                             ALLTRIM(loc_cCmoes) + "- " + ALLTRIM(loc_cDmoes)
            loc_cPeriodo   = "Per" + CHR(237) + "odo: " + ;
                             DTOC(THIS.this_dDtInicial) + ;
                             " " + CHR(160) + " " + DTOC(THIS.this_dDtFinal)

            IF USED("cabecalho")
                USE IN cabecalho
            ENDIF
            CREATE CURSOR cabecalho ;
                (pNmEmp C(80), pRelTitulo C(80), pRelTitul2 C(80), pPeriodo C(80))
            INSERT INTO cabecalho (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo) ;
                VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo)

            *-- ================================================================
            *-- STEP 4: Query principal contra SQL Server
            *-- ================================================================
            loc_cEmpWhere   = IIF(EMPTY(ALLTRIM(loc_cEmpresa)), "", ;
                              " AND a.emps = " + EscaparSQL(ALLTRIM(loc_cEmpresa)))
            loc_cGrupoWhere = IIF(EMPTY(ALLTRIM(loc_cGrupo)) OR loc_nOpt = 4, "", ;
                              " AND (a.GrVends = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ;
                              " OR a.GrResps = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ")")
            loc_cContaWhere = IIF(EMPTY(ALLTRIM(loc_cConta)) OR loc_nOpt = 4, "", ;
                              " AND (a.Vends = " + EscaparSQL(ALLTRIM(loc_cConta)) + ;
                              " OR a.Resps = " + EscaparSQL(ALLTRIM(loc_cConta)) + ")")

            IF USED("cursor_4c_CsmTemp")
                USE IN cursor_4c_CsmTemp
            ENDIF

            loc_cSQL = "SELECT a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes, a.empdopnums," + ;
                       " b.copers, c.Trocos, c.fpcomiss," + ;
                       " c.fpags, c.infos, d.valos," + ;
                       " d.Moefpgs, d.cotfpgs, e.razas," + ;
                       " f.iClis, f.rclis, f.CCargs," + ;
                       " g.FComis, g.acomis," + ;
                       " a.Resps, h.rclis AS DResps," + ;
                       " h.Ccargs AS CcargResps, a.grvends" + ;
                       " FROM SigMvCab a" + ;
                       " INNER JOIN SigMvPar d ON d.empdopnums = a.empdopnums" + ;
                       " INNER JOIN SigCdOpe b ON d.dopes = b.dopes" + ;
                       " AND b.ccomis = 1" + ;
                       " INNER JOIN SigOpFp c ON d.fpags = c.fpags" + ;
                       " AND c.bxcomis = 1" + ;
                       " INNER JOIN SigCdEmp e ON a.emps = e.cemps" + ;
                       " LEFT JOIN SigCdCli h ON a.Resps = h.Iclis" + ;
                       " LEFT JOIN SigCdCli f ON a.Vends = f.iclis" + ;
                       " LEFT JOIN SigCdCrg g ON f.ccargs = g.ccargs" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFim + ;
                       loc_cEmpWhere + loc_cGrupoWhere + loc_cContaWhere + ;
                       " ORDER BY a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmTemp")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- ================================================================
            *-- STEP 5: Processa cursor temporario conforme opcao do relatorio
            *-- ================================================================
            IF USED("tempo")
                USE IN tempo
            ENDIF

            IF loc_nOpt = 1
                *-- Sintetico: vendedor como vends + UNION com responsavel (Resps)
                SELECT vends, datas, emps, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                UNION ;
                SELECT Resps AS vends, datas, emps, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                ORDER BY 3, 1, 2, 5 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF INLIST(loc_nOpt, 2, 3)
                *-- Analitico / Condicao Pagto: inclui dopes e numes no agrupamento
                SELECT dopes, vends, datas, emps, numes, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                UNION ;
                SELECT dopes, Resps AS vends, datas, emps, numes, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF loc_nOpt = 4
                *-- Comissao dividida: usa grade de comissoes (SigCdCmm) como base
                loc_cVerVendedor = IIF(EMPTY(ALLTRIM(loc_cGrupo)), "", ;
                                   " AND ALLTRIM(a.grvends) = '" + ;
                                   ALLTRIM(loc_cGrupo) + "'")
                loc_cVerVendedor = loc_cVerVendedor + ;
                                   IIF(EMPTY(ALLTRIM(loc_cConta)), "", ;
                                   " AND ALLTRIM(b.contas) = '" + ;
                                   ALLTRIM(loc_cConta) + "'")

                IF USED("cursor_4c_CsmCmm1")
                    USE IN cursor_4c_CsmCmm1
                ENDIF
                loc_cSQL = "SELECT a.*, b.rclis AS nvens" + ;
                           " FROM SigCdCmm a, SigCdCli b" + ;
                           " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                           " AND " + loc_cDataFim + ;
                           " AND a.contas = b.iclis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmCmm1")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigCdCmm"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=4)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_CsmCmm2")
                    USE IN cursor_4c_CsmCmm2
                ENDIF
                SELECT empdopnums, COUNT(contas) AS qtdv ;
                FROM cursor_4c_CsmCmm1 ;
                GROUP BY empdopnums ;
                INTO CURSOR cursor_4c_CsmCmm2

                IF USED("cursor_4c_CsmCdCmm")
                    USE IN cursor_4c_CsmCdCmm
                ENDIF
                SELECT a.*, b.qtdv ;
                FROM cursor_4c_CsmCmm1 a, cursor_4c_CsmCmm2 b ;
                WHERE a.empdopnums = b.empdopnums ;
                INTO CURSOR cursor_4c_CsmCdCmm

                SELECT a.dopes, b.contas AS vends, a.datas, a.emps, a.numes, ;
                       a.fpcomiss, a.fpags, a.rclis, a.razas, b.nvens, ;
                       a.CCargs, a.infos, a.FComis, ;
                       b.percs AS acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(a.CCargs) AND !ISNULL(a.FComis) AND a.FComis = "S", ;
                           b.percs / 100.0, 1.0) AS fatComis, ;
                       SUM(a.valos / b.qtdv * a.cotfpgs / ;
                           CarregarCambioCSM(loc_cCmoes, a.datas)) AS tots ;
                FROM cursor_4c_CsmTemp a, cursor_4c_CsmCdCmm b ;
                WHERE a.empdopnums = b.empdopnums &loc_cVerVendedor ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            *-- ================================================================
            *-- STEP 6: Filtro de comissao zerada (FwChkComissao)
            *-- SET DELETED ON (config.prg) ignora registros deletados no REPORT
            *-- ================================================================
            IF THIS.this_lChkComissao AND USED("tempo") AND RECCOUNT("tempo") > 0
                SELECT tempo
                DELETE FROM tempo WHERE ROUND(tots * fpcomiss * fatComis / 100.0, 2) = 0
            ENDIF

            *-- ================================================================
            *-- STEP 7: Para nOpt=3, agrupa por condicao de pagamento (SigPrInf)
            *-- ================================================================
            IF loc_nOpt = 3
                IF USED("cursor_4c_CsmInf")
                    USE IN cursor_4c_CsmInf
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigPrInf", "cursor_4c_CsmInf")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigPrInf"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=3)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("tempo2")
                    USE IN tempo2
                ENDIF
                SELECT a.emps, a.vends, MAX(a.nvens) AS nvens, ;
                       a.infos, MAX(b.descrs) AS descrs, ;
                       SUM(tots) AS tots, ;
                       MAX(a.razas) AS razas, MAX(a.CCargs) AS ccargs ;
                FROM tempo a, cursor_4c_CsmInf b ;
                WHERE a.infos = b.infos ;
                GROUP BY 1, 2, 4 ;
                ORDER BY 1, 2, 5 ;
                INTO CURSOR tempo2
            ENDIF

            SELECT tempo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.PrepararDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) TO PRINTER PROMPT NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) PREVIEW NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + ;
               "|" + ALLTRIM(THIS.this_cCemps) + "|" + ;
               STR(THIS.this_nOptRel, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores locais criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores[9], loc_i
        loc_aCursores[1] = "cursor_4c_CsmTemp"
        loc_aCursores[2] = "cursor_4c_CsmCot"
        loc_aCursores[3] = "cursor_4c_CsmEmp"
        loc_aCursores[4] = "cursor_4c_CsmCmm1"
        loc_aCursores[5] = "cursor_4c_CsmCmm2"
        loc_aCursores[6] = "cursor_4c_CsmCdCmm"
        loc_aCursores[7] = "cursor_4c_CsmInf"
        loc_aCursores[8] = "cabecalho"
        loc_aCursores[9] = "tempo"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        ENDFOR

        IF USED("tempo2")
            USE IN tempo2
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* CarregarCambioCSM - UDF standalone para calculo de cambio
* Equivalente a fCarregarCambio() do sistema legado, especifico para sigrecsmBO
* Acessivel de dentro de SELECT VFP (nao pode ser metodo de objeto)
*
* Acessa cursor_4c_CsmCot (carregado por sigrecsmBO.PrepararDados)
* Retorna cotacao da moeda na data informada (ou na data imediatamente anterior)
*==============================================================================
FUNCTION CarregarCambioCSM(par_cMoeda, par_dData)
    LOCAL loc_nCotacao, loc_cMoeda, loc_dData

    loc_nCotacao = 1

    IF VARTYPE(par_cMoeda) <> "C" OR EMPTY(par_cMoeda)
        RETURN 1
    ENDIF

    loc_cMoeda = PADR(ALLTRIM(par_cMoeda), 3)

    DO CASE
        CASE VARTYPE(par_dData) = "D"
            loc_dData = par_dData
        CASE VARTYPE(par_dData) = "T"
            loc_dData = TTOD(par_dData)
        OTHERWISE
            loc_dData = DATE()
    ENDCASE

    IF USED("cursor_4c_CsmCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(loc_dData)
        SELECT cursor_4c_CsmCot
        SET ORDER TO CMoeData

        *-- Busca exata na data
        IF SEEK(loc_cMoeda + DTOS(loc_dData))
            loc_nCotacao = cursor_4c_CsmCot.Valos
        ELSE
            *-- Nao encontrou: busca com NEAR para posicionar no mais proximo
            SET NEAR ON
            SEEK(loc_cMoeda + DTOS(loc_dData))
            SET NEAR OFF
            *-- Volta um registro para pegar a taxa mais recente anterior
            IF !BOF()
                SKIP -1
            ENDIF
            IF !BOF() AND ALLTRIM(cursor_4c_CsmCot.CMoes) = ALLTRIM(loc_cMoeda)
                loc_nCotacao = cursor_4c_CsmCot.Valos
            ENDIF
        ENDIF
    ENDIF

    RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
ENDFUNC


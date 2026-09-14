# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542; Teste 'BtnIncluirNavegacao': pgf_4c_Paginas nao encontrado

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-16 14:44:08] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 14:44:08] [INFO] Config FPW: (nao fornecido)
[2026-05-16 14:44:08] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 14:44:08] [INFO] Timeout: 300 segundos
[2026-05-16 14:44:08] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3hctdhtw.prg
[2026-05-16 14:44:08] [INFO] Conteudo do wrapper:
[2026-05-16 14:44:08] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrebal', 'C:\4c\tasks\task037', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrebal', 'C:\4c\tasks\task037', 'REPORT'
QUIT

[2026-05-16 14:44:08] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3hctdhtw.prg
[2026-05-16 14:44:08] [INFO] VFP output esperado em: C:\4c\tasks\task037\vfp_output.txt
[2026-05-16 14:44:08] [INFO] Executando Visual FoxPro 9...
[2026-05-16 14:44:08] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3hctdhtw.prg
[2026-05-16 14:44:08] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3hctdhtw.prg
[2026-05-16 14:44:08] [INFO] Timeout configurado: 300 segundos
[2026-05-16 14:44:10] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 14:44:10] [INFO] VFP9 finalizado em 1.9019576 segundos
[2026-05-16 14:44:10] [INFO] Exit Code: 
[2026-05-16 14:44:10] [INFO] 
[2026-05-16 14:44:10] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 14:44:10] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3hctdhtw.prg
[2026-05-16 14:44:10] [INFO] 
[2026-05-16 14:44:10] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 14:44:10] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 14:44:10] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 14:44:10] [INFO] * Parameters: 'Formsigrebal', 'C:\4c\tasks\task037', 'REPORT'
[2026-05-16 14:44:10] [INFO] 
[2026-05-16 14:44:10] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 14:44:10] [INFO] SET SAFETY OFF
[2026-05-16 14:44:10] [INFO] SET RESOURCE OFF
[2026-05-16 14:44:10] [INFO] SET TALK OFF
[2026-05-16 14:44:10] [INFO] SET NOTIFY OFF
[2026-05-16 14:44:10] [INFO] SYS(2335, 0)
[2026-05-16 14:44:10] [INFO] 
[2026-05-16 14:44:10] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrebal', 'C:\4c\tasks\task037', 'REPORT'
[2026-05-16 14:44:10] [INFO] QUIT
[2026-05-16 14:44:10] [INFO] 
[2026-05-16 14:44:10] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 14:44:10] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrebal",
  "timestamp": "20260516144410",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo FormParaRelatorio encontrado"
    },
    {
      "nome": "BotoesRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Visualizar=SIM Imprimir=SIM"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": false,
      "erro": "pgf_4c_Paginas nao encontrado",
      "detalhes": ""
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg):
*==============================================================================
* Formsigrebal.prg
* Formulario de Relatorio de Balanco
*
* Migrado de: SIGREBAL.SCX (frmrelatorio)
* Layout   : FLAT - controles direto no form, sem PageFrame
* Herda de : FormBase
*==============================================================================

DEFINE CLASS Formsigrebal AS FormBase

    *-- Propriedades visuais
    this_cMensagemErro = ""
    Height      = 400
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = "Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o"
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
    * Cria BO, configura cabecalho, botoes, campos de filtro e BINDEVENTs
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
                THIS.this_oRelatorio = CREATEOBJECT("sigrebalBO")

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()
                THIS.ConfigurarBINDEVENTs()

                THIS.AtualizarEstadoMoedaDesc()
                THIS.AtualizarEstadoDesEmpresa()

                THIS.Visible = .T.

                IF loc_lSucesso AND TYPE("THIS.txt_4c__dt_final") = "O"
                    THIS.txt_4c__dt_final.SetFocus()
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
    * ConfigurarPaginaLista - REPORT form usa layout FLAT (sem Page Lista)
    * Mantido por contrato com a infraestrutura de migracao multi-fase.
    * Para REPORT forms a "lista" sao os controles de filtro configurados em
    * ConfigurarCampos(). Nao ha grid, nao ha registros para listar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT form nao possui PageFrame Lista/Dados
    * Mantido por contrato com a infraestrutura de migracao multi-fase.
    * O fluxo de REPORT eh sempre: ajustar filtros -> Visualizar/Imprimir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
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
            .Caption   = "Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o"
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"
            .PicturePosition = 13
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
            .PicturePosition = 13
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        THIS.cmg_4c_Botoes.Buttons(4).Cancel = .T.
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro direto no form (layout FLAT)
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos filtros do relatorio
    * Campos: periodo (data final), moeda (cod/desc), empresa (cod/desc),
    *         opcao conta zerada (Sim/Nao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- === ATE (periodo) top=132/137 ===
        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .Top       = 137
            .Left      = 258
            .AutoSize  = .T.
            .Caption   = "At" + CHR(233) + " :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_final", "TextBox")
        WITH THIS.txt_4c__dt_final
            .Top           = 132
            .Left          = 288
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- === MOEDA top=157/161 ===
        THIS.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH THIS.lbl_4c_Lbl_moeda
            .Top       = 161
            .Left      = 243
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH THIS.txt_4c__cd_moeda
            .Top           = 157
            .Left          = 288
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH THIS.txt_4c__ds_moeda
            .Top           = 157
            .Left          = 320
            .Width         = 115
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === EMPRESA top=182/186 ===
        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Top       = 186
            .Left      = 234
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_empresa", "TextBox")
        WITH THIS.txt_4c__cd_empresa
            .Top           = 182
            .Left          = 288
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_empresa", "TextBox")
        WITH THIS.txt_4c__ds_empresa
            .Top           = 182
            .Left          = 320
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === CONTA ZERADA top=207/211 ===
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 211
            .Left      = 209
            .AutoSize  = .T.
            .Caption   = "Conta Zerada :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptGcontaz", "OptionGroup")
        WITH THIS.obj_4c_OptGcontaz
            .ButtonCount = 2
            .Top         = 207
            .Left        = 283
            .Width       = 109
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "\<Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 40
            .Option1.Height    = 17

            .Option2.Caption   = "\<N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 45
            .Option2.Width     = 41
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro (delega primeira metade a
    *                    ConfigurarPaginaDados e adiciona segunda metade)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        THIS.ConfigurarPaginaDados()

        *-- === TIPO top=232/236 ===
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 236
            .Left      = 255
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptGtprel", "OptionGroup")
        WITH THIS.obj_4c_OptGtprel
            .ButtonCount = 2
            .Top         = 232
            .Left        = 283
            .Width       = 140
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 64
            .Option1.Height    = 17

            .Option2.Caption   = "S\<int" + CHR(233) + "tico"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 70
            .Option2.Width     = 65
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

        *-- === COTACAO top=258/262 ===
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 262
            .Left      = 235
            .AutoSize  = .T.
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptCotacao", "OptionGroup")
        WITH THIS.obj_4c_OptCotacao
            .ButtonCount = 2
            .Top         = 258
            .Left        = 283
            .Width       = 210
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "\<Fechamento"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 89
            .Option1.Height    = 17

            .Option2.Caption   = "\<Movimenta" + CHR(231) + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 98
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

        *-- === CLIENTE top=283/287 ===
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 287
            .Left      = 242
            .AutoSize  = .T.
            .Caption   = "Cliente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Opt_Cli", "OptionGroup")
        WITH THIS.obj_4c_Opt_Cli
            .ButtonCount = 2
            .Top         = 283
            .Left        = 283
            .Width       = 140
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 64
            .Option1.Height    = 17

            .Option2.Caption   = "S\<int" + CHR(233) + "tico"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 70
            .Option2.Width     = 65
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

        *-- === ANALISE CONSISTENCIA top=305/309 ===
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 309
            .Left      = 190
            .AutoSize  = .T.
            .Caption   = "Anal. Consist" + CHR(234) + "ncia:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OpAnCst", "OptionGroup")
        WITH THIS.obj_4c_OpAnCst
            .ButtonCount = 2
            .Top         = 305
            .Left        = 283
            .Width       = 99
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2

            .Option1.Caption   = "\<Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 42
            .Option1.Height    = 17

            .Option2.Caption   = "\<N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 51
            .Option2.Width     = 43
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

        *-- === SALDO CONCILIADO top=324/330 ===
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 330
            .Left      = 176
            .AutoSize  = .T.
            .Caption   = "Para contas concili" + CHR(225) + "veis, utilizar saldo conciliado?"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Optconcilias", "OptionGroup")
        WITH THIS.obj_4c_Optconcilias
            .ButtonCount = 2
            .Top         = 324
            .Left        = 420
            .Width       = 99
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2

            .Option1.Caption   = "\<Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 42
            .Option1.Height    = 17

            .Option2.Caption   = "\<N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 51
            .Option2.Width     = 43
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - KeyPress (F4=lookup, ENTER/TAB=validar) + DblClick
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.txt_4c__cd_moeda,   "KeyPress", THIS, "TeclaLookupMoedaCod")
        BINDEVENT(THIS.txt_4c__ds_moeda,   "KeyPress", THIS, "TeclaLookupMoedaDesc")
        BINDEVENT(THIS.txt_4c__cd_moeda,   "DblClick", THIS, "AbrirBuscaMoedaCod")
        BINDEVENT(THIS.txt_4c__ds_moeda,   "DblClick", THIS, "AbrirBuscaMoedaDesc")

        BINDEVENT(THIS.txt_4c__cd_empresa, "KeyPress", THIS, "TeclaLookupEmpresaCod")
        BINDEVENT(THIS.txt_4c__ds_empresa, "KeyPress", THIS, "TeclaLookupEmpresaDesc")
        BINDEVENT(THIS.txt_4c__cd_empresa, "DblClick", THIS, "AbrirBuscaEmpresaCod")
        BINDEVENT(THIS.txt_4c__ds_empresa, "DblClick", THIS, "AbrirBuscaEmpresaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoMoedaDesc - ds_moeda editavel apenas quando cd_moeda vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoMoedaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__cd_moeda.Value))
            THIS.txt_4c__ds_moeda.ReadOnly  = .F.
            THIS.txt_4c__ds_moeda.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__ds_moeda.ReadOnly  = .T.
            THIS.txt_4c__ds_moeda.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDesEmpresa - ds_empresa editavel apenas quando cd_empresa vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoDesEmpresa()
        IF EMPTY(ALLTRIM(THIS.txt_4c__cd_empresa.Value))
            THIS.txt_4c__ds_empresa.ReadOnly  = .F.
            THIS.txt_4c__ds_empresa.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__ds_empresa.ReadOnly  = .T.
            THIS.txt_4c__ds_empresa.BackColor = RGB(240, 240, 240)
        ENDIF
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
        loc_cValor = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
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
        loc_cValor  = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__ds_moeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.txt_4c__ds_moeda.Value = ""
                THIS.AbrirBuscaMoedaCod()
            ENDIF
        ELSE
            THIS.txt_4c__ds_moeda.Value = ""
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
        IF THIS.txt_4c__ds_moeda.ReadOnly
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
        IF THIS.txt_4c__ds_moeda.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
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
        loc_cValor  = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__cd_moeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                THIS.txt_4c__cd_moeda.Value = ALLTRIM(CMoes)
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
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
        loc_cValor = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor  = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__ds_empresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.txt_4c__ds_empresa.Value = ""
                THIS.AbrirBuscaEmpresaCod()
            ENDIF
        ELSE
            THIS.txt_4c__ds_empresa.Value = ""
            THIS.AbrirBuscaEmpresaCod()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pela descricao (SigCdEmp.Razas)
    *==========================================================================

    PROCEDURE TeclaLookupEmpresaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__ds_empresa.ReadOnly
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
        IF THIS.txt_4c__ds_empresa.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor  = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__cd_empresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpDescVal
            IF !EOF()
                THIS.txt_4c__cd_empresa.Value = ALLTRIM(Cemps)
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.AbrirBuscaEmpresaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
        IF USED("cursor_4c_EmpDescVal")
            USE IN cursor_4c_EmpDescVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        THIS.this_oRelatorio.this_dDtFinal      = THIS.txt_4c__dt_final.Value
        THIS.this_oRelatorio.this_cCdMoeda      = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
        THIS.this_oRelatorio.this_cDsMoeda      = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
        THIS.this_oRelatorio.this_cCdEmpresa    = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
        THIS.this_oRelatorio.this_cDsEmpresa    = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
        THIS.this_oRelatorio.this_nContaz       = THIS.obj_4c_OptGcontaz.Value
        THIS.this_oRelatorio.this_nTpRel        = THIS.obj_4c_OptGtprel.Value
        THIS.this_oRelatorio.this_nOptCotacao   = THIS.obj_4c_OptCotacao.Value
        THIS.this_oRelatorio.this_nOptCli       = THIS.obj_4c_Opt_Cli.Value
        THIS.this_oRelatorio.this_nOpAnCst      = THIS.obj_4c_OpAnCst.Value
        THIS.this_oRelatorio.this_nOptConcilias = THIS.obj_4c_Optconcilias.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos antes de gerar o relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.txt_4c__dt_final.Value)
            MsgAviso("Data final " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                    "Balan" + CHR(231) + "o")
            THIS.txt_4c__dt_final.SetFocus()
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
    * BtnImprimirClick - Impressao com dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.ImprimirComPrompt()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cPlConta para planilha XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_oErro
        loc_cArquivo = ""

        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    IF USED("cPlConta") AND RECCOUNT("cPlConta") > 0
                        loc_cArquivo = ADDBS(SYS(2023)) + "Balanco_" + DTOS(DATE()) + ;
                                       "_" + STRTRAN(TIME(), ":", "") + ".xls"
                        SELECT cPlConta
                        COPY TO (loc_cArquivo) TYPE XLS

                        IF FILE(loc_cArquivo)
                            DECLARE INTEGER ShellExecute IN shell32.dll ;
                                INTEGER hndWin, STRING cAction, ;
                                STRING cFileName, STRING cParams, ;
                                STRING cDir, INTEGER nShowWin
                            ShellExecute(0, "open", loc_cArquivo, "", "", 1)
                        ELSE
                            MsgErro("Erro ao gerar arquivo Excel.", "Balan" + CHR(231) + "o")
                        ENDIF
                    ELSE
                        MsgAviso("Nenhum dado para exportar.", "Balan" + CHR(231) + "o")
                    ENDIF
                ELSE
                    MsgErro("Erro ao preparar dados.", "Balan" + CHR(231) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrebal.BtnExcelClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS CRUD (compatibilidade de API)
    *
    * Este formulario eh do tipo REPORT (frmrelatorio), portanto nao executa
    * operacoes de Inserir/Alterar/Excluir. Os metodos abaixo existem por
    * contrato com a infraestrutura de migracao multi-fase e, quando invocados,
    * orientam o usuario para a acao correta (Visualizar/Imprimir/Excel).
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT: limpa filtros e foca data final (nova consulta)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
        THIS.Refresh()
        IF TYPE("THIS.txt_4c__dt_final") = "O"
            THIS.txt_4c__dt_final.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT: foca o primeiro filtro para edicao manual
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
        THIS.Refresh()
        IF TYPE("THIS.txt_4c__dt_final") = "O"
            THIS.txt_4c__dt_final.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT: descarta o cursor de dados gerado (se houver)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF USED("cPlConta")
            USE IN cPlConta
        ENDIF
        IF USED("Consulta")
            USE IN Consulta
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_cMensagemErro = ""
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Redefine todos os filtros para os valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c__dt_final.Value      = DATE()
        THIS.txt_4c__cd_moeda.Value      = ""
        THIS.txt_4c__ds_moeda.Value      = ""
        THIS.txt_4c__cd_empresa.Value    = ""
        THIS.txt_4c__ds_empresa.Value    = ""
        THIS.obj_4c_OptGcontaz.Value     = 1
        THIS.obj_4c_OptGtprel.Value      = 1
        THIS.obj_4c_OptCotacao.Value     = 1
        THIS.obj_4c_Opt_Cli.Value        = 1
        THIS.obj_4c_OpAnCst.Value        = 2
        THIS.obj_4c_Optconcilias.Value   = 2
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita campos de filtro para edicao
    * Em REPORT: todos os campos de filtro ficam sempre editaveis.
    * ds_moeda e ds_empresa seguem regra de cd_* vazio (ver AtualizarEstado*).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        THIS.txt_4c__dt_final.ReadOnly   = .F.
        THIS.txt_4c__cd_moeda.ReadOnly   = .F.
        THIS.txt_4c__cd_empresa.ReadOnly = .F.
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
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
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere filtros do form para o BO (delega a FormParaRelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO de volta para os controles do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.txt_4c__dt_final.Value      = THIS.this_oRelatorio.this_dDtFinal
            THIS.txt_4c__cd_moeda.Value      = THIS.this_oRelatorio.this_cCdMoeda
            THIS.txt_4c__ds_moeda.Value      = THIS.this_oRelatorio.this_cDsMoeda
            THIS.txt_4c__cd_empresa.Value    = THIS.this_oRelatorio.this_cCdEmpresa
            THIS.txt_4c__ds_empresa.Value    = THIS.this_oRelatorio.this_cDsEmpresa
            THIS.obj_4c_OptGcontaz.Value     = THIS.this_oRelatorio.this_nContaz
            THIS.obj_4c_OptGtprel.Value      = THIS.this_oRelatorio.this_nTpRel
            THIS.obj_4c_OptCotacao.Value     = THIS.this_oRelatorio.this_nOptCotacao
            THIS.obj_4c_Opt_Cli.Value        = THIS.this_oRelatorio.this_nOptCli
            THIS.obj_4c_OpAnCst.Value        = THIS.this_oRelatorio.this_nOpAnCst
            THIS.obj_4c_Optconcilias.Value   = THIS.this_oRelatorio.this_nOptConcilias
            THIS.AtualizarEstadoMoedaDesc()
            THIS.AtualizarEstadoDesEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: executa preview com os filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
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
    * BtnSalvarClick - Em REPORT: nao se aplica; orientar o usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este relat" + CHR(243) + "rio n" + CHR(227) + "o possui " + ;
                 "opera" + CHR(231) + CHR(227) + "o de salvamento." + CHR(13) + ;
                 "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
                 "Balan" + CHR(231) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: fecha o formulario (equivalente a Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O" AND NOT ISNULL(THIS.this_oRelatorio)
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrebalBO.prg):
*==============================================================================
* SIGREBALBO.PRG
* Business Object para Relatorio de Balanco (SIGREBAL)
*
* Herda de: RelatorioBase
* Form associado: Formsigrebal.prg
* Relatorios FRX: SigReBal.frx (principal), SigReAcs.frx (consistencia)
*
* Filtros:
*   - Data final do balanco
*   - Codigo/descricao da moeda de referencia
*   - Codigo/descricao da empresa (vazio = todas)
*   - Opcao conta zerada (1=Sim, 2=Nao)
*   - Opcao tipo relatorio (1=Analitico, 2=Sintetico)
*   - Opcao cliente (1=Analitico, 2=Sintetico)
*   - Opcao analise consistencia (1=Sim, 2=Nao)
*   - Opcao cotacao (1=Fechamento, 2=Movimentacao)
*   - Opcao saldo conciliado (1=Sim, 2=Nao)
*==============================================================================

DEFINE CLASS sigrebalBO AS RelatorioBase

    *-- Filtros do formulario
    this_dDtFinal        = {}
    this_cCdMoeda        = ""
    this_cDsMoeda        = ""
    this_cCdEmpresa      = ""
    this_cDsEmpresa      = ""
    this_nContaz         = 1
    this_nTpRel          = 1
    this_nOptCli         = 1
    this_nOpAnCst        = 2
    this_nOptCotacao     = 1
    this_nOptConcilias   = 2

    *-- Controle interno de relatorio
    this_cArquivoFRX     = ""
    this_cArquivoAcsFRX  = ""
    this_cTitulo         = ""
    this_cCursorDados    = "cursor_4c_BalDados"
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO de relatorio de balanco
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela      = "SigMvCcr"
            THIS.this_cCampoChave  = ""

            THIS.this_cArquivoFRX    = "SigReBal"
            THIS.this_cArquivoAcsFRX = "SigReAcs"
            THIS.this_cTitulo        = "Balan" + CHR(231) + "o"

            THIS.this_dDtFinal       = DATE()
            THIS.this_cCdMoeda       = ""
            THIS.this_cDsMoeda       = ""
            THIS.this_cCdEmpresa     = ""
            THIS.this_cDsEmpresa     = ""
            THIS.this_nContaz        = 1
            THIS.this_nTpRel         = 1
            THIS.this_nOptCli        = 1
            THIS.this_nOpAnCst       = 2
            THIS.this_nOptCotacao    = 1
            THIS.this_nOptConcilias  = 2

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_BalPam")
            USE IN cursor_4c_BalPam
        ENDIF
        IF USED("cursor_4c_BalCot")
            USE IN cursor_4c_BalCot
        ENDIF
        IF USED("cursor_4c_BalMoe")
            USE IN cursor_4c_BalMoe
        ENDIF
        IF USED("cursor_4c_BalGcr")
            USE IN cursor_4c_BalGcr
        ENDIF
        IF USED("cursor_4c_BalCss")
            USE IN cursor_4c_BalCss
        ENDIF
        IF USED("cursor_4c_BalCli")
            USE IN cursor_4c_BalCli
        ENDIF
        IF USED("cursor_4c_BalMvcr")
            USE IN cursor_4c_BalMvcr
        ENDIF
        IF USED("cursor_4c_BalTmpMccr")
            USE IN cursor_4c_BalTmpMccr
        ENDIF
        IF USED("cPlConta")
            USE IN cPlConta
        ENDIF
        IF USED("Consulta")
            USE IN Consulta
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarReferencias - Carrega cursores auxiliares do SQL Server
    * Equivalente aos CursorQuery() do Init legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarReferencias()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .T.
        TRY
            *-- SigCdPam - parametros padrao de clientes
            IF USED("cursor_4c_BalPam")
                USE IN cursor_4c_BalPam
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT GrPadClis FROM SigCdPam", "cursor_4c_BalPam")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPam"
                loc_lSucesso = .F.
            ENDIF
            *-- SigCdCot - cotacoes de moedas (indexado por moeda+data)
            IF USED("cursor_4c_BalCot")
                USE IN cursor_4c_BalCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", "cursor_4c_BalCot")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCot"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            *-- SigCdMoe - moedas cadastradas
            IF USED("cursor_4c_BalMoe")
                USE IN cursor_4c_BalMoe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Cotas FROM SigCdMoe", "cursor_4c_BalMoe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdMoe"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalMoe
            INDEX ON CMoes TAG CMoes
            *-- SigCdGcr - grupos de conta corrente
            IF USED("cursor_4c_BalGcr")
                USE IN cursor_4c_BalGcr
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs, Classes FROM SigCdGcr", "cursor_4c_BalGcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdGcr"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalGcr
            INDEX ON Codigos TAG Codigos
            *-- SigCdCss - classes do sistema contabil (balanco)
            IF USED("cursor_4c_BalCss")
                USE IN cursor_4c_BalCss
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Classes, Descrs, Nivels, OpBalancos FROM SigCdCss", "cursor_4c_BalCss")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCss"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCss
            INDEX ON Classes TAG Classes
            *-- SigCdCli - clientes / contas correntes
            IF USED("cursor_4c_BalCli")
                USE IN cursor_4c_BalCli
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT IClis, Grupos, RClis, Concilias FROM SigCdCli", "cursor_4c_BalCli")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCli"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCli
            INDEX ON Grupos + IClis TAG GrCodigo
            INDEX ON IClis TAG IClis
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.CarregarReferencias")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("cursor_4c_BalCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT cursor_4c_BalCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = cursor_4c_BalCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(cursor_4c_BalCot.CMoes) = loc_cMoeda AND ;
                   TTOD(cursor_4c_BalCot.Datas) <= par_dData
                    loc_nCotacao = cursor_4c_BalCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa movimentos e monta cPlConta para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado (SIGREBAL)
    * Cria cursores cPlConta (SigReBal.frx) e Consulta (SigReAcs.frx)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_ldDtSaldo, loc_lcCdEmp, loc_lcDsEmp, loc_lcCdMoeda, loc_lcDsMoeda
        LOCAL loc_lnContaz, loc_lnOptRel, loc_lnOptCli, loc_lnOpAnCst
        LOCAL loc_lnOptCot, loc_lnOptConc
        LOCAL loc_lcEmpresa, loc_lcTitulo1s, loc_lcTitulo2s
        LOCAL loc_lnDecimals, loc_lcFixed, loc_lcEscape
        LOCAL loc_lnCot1, loc_lnCot2, loc_lnValors, loc_lnSaldos
        LOCAL loc_lnNivels, loc_lnConta1, loc_lcClasse2
        LOCAL loc_cContas, loc_cDcontas, loc_cOrds, loc_cPs, loc_cIps
        LOCAL loc_lcGrupos, loc_lcContas, loc_lcNopers
        LOCAL loc_nResult, loc_lcQuery, loc_lcDtSQL
        LOCAL ARRAY loc_laOrd(5), loc_laStrArea(5)
        LOCAL ARRAY loc_aFlds(1)

        loc_lSucesso   = .F.
        loc_lcEscape   = ""
        loc_lnDecimals = 0
        loc_lcFixed    = ""

        TRY
            IF !THIS.CarregarReferencias()
                THIS.this_cMensagemErro = "Erro ao carregar refer" + CHR(234) + "ncias"
            ELSE

            loc_ldDtSaldo  = THIS.this_dDtFinal
            loc_lcCdEmp    = ALLTRIM(THIS.this_cCdEmpresa)
            loc_lcDsEmp    = ALLTRIM(THIS.this_cDsEmpresa)
            loc_lcCdMoeda  = ALLTRIM(THIS.this_cCdMoeda)
            loc_lcDsMoeda  = ALLTRIM(THIS.this_cDsMoeda)
            loc_lnContaz   = THIS.this_nContaz
            loc_lnOptRel   = THIS.this_nTpRel
            loc_lnOptCli   = THIS.this_nOptCli
            loc_lnOpAnCst  = THIS.this_nOpAnCst
            loc_lnOptCot   = THIS.this_nOptCotacao
            loc_lnOptConc  = THIS.this_nOptConcilias

            loc_lcEmpresa  = go_4c_Sistema.cEmpresa
            loc_lcTitulo1s = "Balan" + CHR(231) + "o em " + ;
                             DTOC(loc_ldDtSaldo) + " - " + loc_lcDsMoeda
            loc_lcTitulo2s = IIF(!EMPTY(loc_lcCdEmp), ;
                             ALLTRIM(loc_lcCdEmp) + " - " + ALLTRIM(loc_lcDsEmp), ;
                             "TODAS AS EMPRESAS")

            loc_lcEscape   = SET("Escape")
            loc_lnDecimals = VAL(SET("Decimals"))
            loc_lcFixed    = SET("Fixed")
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            *-- Criar cursor de resultado (nome exato exigido por SigReBal.frx)
            IF USED("cPlConta")
                USE IN cPlConta
            ENDIF
            CREATE CURSOR cPlConta (cEmpresas C(40), cTitulo1s C(80), cTitulo2s C(80), ;
                                    cContas C(10), cDContas C(50), nSaldos N(16,2), ;
                                    cOrds C(50), cPs C(1), cIps C(1))
            INDEX ON cOrds TAG cOrds

            *-- Montar string de data limite para o WHERE SQL (fim do dia)
            loc_lcDtSQL = STR(YEAR(loc_ldDtSaldo), 4) + "-" + ;
                          RIGHT("0" + LTRIM(STR(MONTH(loc_ldDtSaldo))), 2) + "-" + ;
                          RIGHT("0" + LTRIM(STR(DAY(loc_ldDtSaldo))), 2) + " 23:59:59"

            *-- Carregar movimentos de conta corrente ate a data saldo
            IF USED("cursor_4c_BalMvcr")
                USE IN cursor_4c_BalMvcr
            ENDIF
            loc_lcQuery = "SELECT Emps, Datas, Opers, Grupos, Contas, Valors, Moedas, " + ;
                          "SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves, Hists, " + ;
                          "Hist2s, Concs, sOpers, sgrupos, scontas, scotacaos, SaldoCs, EmpCcs " + ;
                          "FROM SigMvCcr " + ;
                          "WHERE Datas <= " + EscaparSQL(loc_lcDtSQL) + " OR Datas IS NULL " + ;
                          "ORDER BY Datas, Opers, Grupos, Contas, Valors, " + ;
                          "Moedas, SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_BalMvcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigMvCcr"
                SET ESCAPE &loc_lcEscape.
                SET DECIMALS TO loc_lnDecimals
                SET FIXED &loc_lcFixed.
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalMvcr
            INDEX ON Datas TAG Datas

            *-- Criar cursor temporario de movimentos (mesma estrutura de cursor_4c_BalMvcr)
            IF USED("cursor_4c_BalTmpMccr")
                USE IN cursor_4c_BalTmpMccr
            ENDIF
            AFIELDS(loc_aFlds, "cursor_4c_BalMvcr")
            SET NULL ON
            CREATE CURSOR cursor_4c_BalTmpMccr FROM ARRAY loc_aFlds
            SET NULL OFF
            SELECT cursor_4c_BalTmpMccr
            INDEX ON Nopers TAG Nopers

            *-- Cotacao base da moeda de referencia na data do balanco
            loc_lnCot2 = THIS.CarregarCambio(loc_lcCdMoeda, loc_ldDtSaldo)

            *-- === LOOP PRINCIPAL: processar cada movimento ===
            SELECT cursor_4c_BalMvcr
            SET ORDER TO Datas
            GO TOP
            DO WHILE !EOF("cursor_4c_BalMvcr") AND ;
                     (ISNULL(cursor_4c_BalMvcr.Datas) OR ;
                      TTOD(cursor_4c_BalMvcr.Datas) <= loc_ldDtSaldo)

                *-- Filtrar por empresa se informada (checar EmpCcs primeiro, depois Emps)
                IF !EMPTY(loc_lcCdEmp)
                    IF IIF(!EMPTY(ALLTRIM(cursor_4c_BalMvcr.EmpCcs)), ;
                           ALLTRIM(cursor_4c_BalMvcr.EmpCcs) <> loc_lcCdEmp, ;
                           ALLTRIM(cursor_4c_BalMvcr.Emps) <> loc_lcCdEmp)
                        SELECT cursor_4c_BalMvcr
                        SKIP
                        LOOP
                    ENDIF
                ENDIF

                loc_lcGrupos = ALLTRIM(cursor_4c_BalMvcr.Grupos)
                loc_lcContas = ALLTRIM(cursor_4c_BalMvcr.Contas)

                *-- Calcular cotacao de conversao para a moeda de referencia
                IF (loc_lnOptCot = 1)
                    loc_lnCot1 = THIS.CarregarCambio(cursor_4c_BalMvcr.Moedas, loc_ldDtSaldo)
                ELSE
                    IF ALLTRIM(cursor_4c_BalMvcr.Moedas) <> ALLTRIM(cursor_4c_BalMvcr.SMoedas)
                        loc_lnCot1 = cursor_4c_BalMvcr.Cotacaos
                    ELSE
                        loc_lnCot1 = THIS.CarregarCambio(cursor_4c_BalMvcr.Moedas, ;
                                         TTOD(cursor_4c_BalMvcr.Datas))
                    ENDIF
                    loc_lnCot2 = THIS.CarregarCambio(loc_lcCdMoeda, ;
                                     TTOD(cursor_4c_BalMvcr.Datas))
                ENDIF

                *-- Determinar valor convertido com base em opcao de saldo conciliado
                SELECT cursor_4c_BalCli
                SET ORDER TO IClis
                SEEK loc_lcContas
                IF (loc_lnOptConc = 2) OR cursor_4c_BalCli.Concilias <> 1
                    IF ALLTRIM(cursor_4c_BalMvcr.SMoedas) = loc_lcCdMoeda AND loc_lnOptCot = 2
                        loc_lnValors = cursor_4c_BalMvcr.SValors
                    ELSE
                        loc_lnValors = (cursor_4c_BalMvcr.Valors * loc_lnCot1 / loc_lnCot2)
                    ENDIF
                ELSE
                    IF !cursor_4c_BalMvcr.Concs
                        SELECT cursor_4c_BalMvcr
                        SKIP
                        LOOP
                    ENDIF
                    IF ALLTRIM(cursor_4c_BalMvcr.SMoedas) = loc_lcCdMoeda AND loc_lnOptCot = 2
                        loc_lnValors = cursor_4c_BalMvcr.SValors
                    ELSE
                        loc_lnValors = (cursor_4c_BalMvcr.Valors * loc_lnCot1 / loc_lnCot2)
                    ENDIF
                ENDIF

                loc_lnSaldos = loc_lnValors * IIF(ALLTRIM(cursor_4c_BalMvcr.Opers) = "D", 1, -1)

                *-- Verificar se conta/grupo/classe pertencem ao balanco
                SELECT cursor_4c_BalCli
                SET ORDER TO IClis
                SEEK loc_lcContas
                IF ((loc_lnContaz = 1 OR !EMPTY(loc_lnSaldos)) AND ;
                    !EMPTY(loc_lcContas) AND FOUND() AND ;
                    !EMPTY(loc_lcGrupos))

                    SELECT cursor_4c_BalGcr
                    SET ORDER TO Codigos
                    SEEK loc_lcGrupos
                    IF FOUND() AND !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                        SELECT cursor_4c_BalCss
                        SET ORDER TO Classes
                        SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                        IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                            SELECT cursor_4c_BalCss
                            SEEK cursor_4c_BalGcr.Classes
                            IF FOUND()
                                loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                loc_lnNivels  = cursor_4c_BalCss.Nivels
                                FOR loc_lnConta1 = 1 TO loc_lnNivels
                                    loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                        VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                    loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                ENDFOR
                                loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                loc_laOrd(loc_lnNivels + 2)     = PADR(ALLTRIM(cursor_4c_BalCli.IClis), 10)
                                loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                loc_laStrArea(loc_lnNivels + 2) = "cursor_4c_BalCli"
                                loc_cOrds = ""
                                FOR loc_lnConta1 = 1 TO (loc_lnNivels + 2)
                                    loc_cContas  = loc_laOrd(loc_lnConta1)
                                    IF (loc_lnConta1 <= loc_lnNivels)
                                        SELECT (loc_laStrArea(loc_lnConta1))
                                        SET ORDER TO Classes
                                        SEEK loc_cContas
                                    ENDIF
                                    loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                    loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                        IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                    loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                        loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                    loc_cIps = STR(loc_lnConta1, 1)
                                    SELECT cursor_4c_BalPam
                                    GO TOP
                                    IF ((cursor_4c_BalCli.Grupos = cursor_4c_BalPam.GrPadClis) AND ;
                                        (loc_lnOptCli = 1 OR loc_cPs <> "5")) OR ;
                                       ((loc_lnOptRel = 1 OR loc_cPs <> "5") AND ;
                                        (cursor_4c_BalCli.Grupos <> cursor_4c_BalPam.GrPadClis))
                                        SELECT cPlConta
                                        SET ORDER TO cOrds
                                        IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                            INSERT INTO cPlConta ;
                                                (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                 cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                            SELECT cPlConta
                                            SET ORDER TO cOrds
                                            SEEK PADR(loc_cOrds, 50)
                                        ENDIF
                                        REPLACE nSaldos WITH nSaldos + loc_lnSaldos IN cPlConta
                                        IF loc_lnConta1 = loc_lnNivels + 2 AND ;
                                           loc_lnContaz = 2 AND EMPTY(cPlConta.nSaldos)
                                            DELETE IN cPlConta
                                        ENDIF
                                    ENDIF
                                ENDFOR
                                *-- Registrar no cursor de analise de consistencia
                                loc_lcNopers = ALLTRIM(cursor_4c_BalMvcr.Nopers)
                                SELECT cursor_4c_BalTmpMccr
                                SET ORDER TO Nopers
                                IF !SEEK(loc_lcNopers)
                                    INSERT INTO cursor_4c_BalTmpMccr ;
                                        (Emps, Datas, Opers, Grupos, Contas, Valors, Moedas, ;
                                         SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves, ;
                                         Hists, Hist2s, Concs, sOpers, sgrupos, scontas, ;
                                         scotacaos, SaldoCs, EmpCcs) ;
                                        VALUES (cursor_4c_BalMvcr.Emps, cursor_4c_BalMvcr.Datas, ;
                                        cursor_4c_BalMvcr.Opers, cursor_4c_BalMvcr.Grupos, ;
                                        cursor_4c_BalMvcr.Contas, cursor_4c_BalMvcr.Valors, ;
                                        cursor_4c_BalMvcr.Moedas, cursor_4c_BalMvcr.SValors, ;
                                        cursor_4c_BalMvcr.SMoedas, cursor_4c_BalMvcr.Cotacaos, ;
                                        cursor_4c_BalMvcr.Nopers, 0, cursor_4c_BalMvcr.cIdChaves, ;
                                        cursor_4c_BalMvcr.Hists, cursor_4c_BalMvcr.Hist2s, ;
                                        cursor_4c_BalMvcr.Concs, cursor_4c_BalMvcr.sOpers, ;
                                        cursor_4c_BalMvcr.sgrupos, cursor_4c_BalMvcr.scontas, ;
                                        cursor_4c_BalMvcr.scotacaos, cursor_4c_BalMvcr.SaldoCs, ;
                                        cursor_4c_BalMvcr.EmpCcs)
                                ENDIF
                                REPLACE Saldos WITH Saldos + loc_lnSaldos IN cursor_4c_BalTmpMccr
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                SELECT cursor_4c_BalMvcr
                SKIP
            ENDDO

            *-- === LOOP ZERO-BALANCE: incluir contas cadastradas com saldo zero ===
            IF (loc_lnContaz = 1)
                *-- Varrer clientes para incluir contas zeradas
                SELECT cursor_4c_BalCli
                SET ORDER TO GrCodigo
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_BalCli.IClis)) AND ;
                       !EMPTY(ALLTRIM(cursor_4c_BalCli.Grupos))
                        SELECT cursor_4c_BalGcr
                        SET ORDER TO Codigos
                        SEEK ALLTRIM(cursor_4c_BalCli.Grupos)
                        IF FOUND() AND !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                            SELECT cursor_4c_BalCss
                            SET ORDER TO Classes
                            SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                            IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                                SELECT cursor_4c_BalCss
                                SEEK cursor_4c_BalGcr.Classes
                                IF FOUND()
                                    loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                    loc_lnNivels  = cursor_4c_BalCss.Nivels
                                    FOR loc_lnConta1 = 1 TO loc_lnNivels
                                        loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                            VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                        loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                    ENDFOR
                                    loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                    loc_laOrd(loc_lnNivels + 2)     = PADR(ALLTRIM(cursor_4c_BalCli.IClis), 10)
                                    loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                    loc_laStrArea(loc_lnNivels + 2) = "cursor_4c_BalCli"
                                    loc_cOrds = ""
                                    FOR loc_lnConta1 = 1 TO (loc_lnNivels + 2)
                                        loc_cContas  = loc_laOrd(loc_lnConta1)
                                        IF (loc_lnConta1 <= loc_lnNivels)
                                            SELECT (loc_laStrArea(loc_lnConta1))
                                            SET ORDER TO Classes
                                            SEEK loc_cContas
                                        ENDIF
                                        loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                        loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                            IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                        loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                            loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                        loc_cIps = STR(loc_lnConta1, 1)
                                        SELECT cursor_4c_BalPam
                                        GO TOP
                                        IF ((cursor_4c_BalCli.Grupos = cursor_4c_BalPam.GrPadClis) AND ;
                                            (loc_lnOptCli = 1 OR loc_cPs <> "5")) OR ;
                                           ((loc_lnOptRel = 1 OR loc_cPs <> "5") AND ;
                                            (cursor_4c_BalCli.Grupos <> cursor_4c_BalPam.GrPadClis))
                                            SELECT cPlConta
                                            SET ORDER TO cOrds
                                            IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                                INSERT INTO cPlConta ;
                                                    (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                     cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                    VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                    loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                    0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                            ENDIF
                                        ENDIF
                                        SELECT cursor_4c_BalCli
                                    ENDFOR
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
                *-- Varrer grupos para incluir entradas de grupos/classes zerados
                SELECT cursor_4c_BalGcr
                SET ORDER TO Codigos
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_BalGcr.Codigos)) AND ;
                       !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                        SELECT cursor_4c_BalCss
                        SET ORDER TO Classes
                        SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                        IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                            SELECT cursor_4c_BalCss
                            SEEK cursor_4c_BalGcr.Classes
                            IF FOUND()
                                loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                loc_lnNivels  = cursor_4c_BalCss.Nivels
                                FOR loc_lnConta1 = 1 TO loc_lnNivels
                                    loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                        VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                    loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                ENDFOR
                                loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                loc_cOrds = ""
                                FOR loc_lnConta1 = 1 TO (loc_lnNivels + 1)
                                    loc_cContas  = loc_laOrd(loc_lnConta1)
                                    IF (loc_lnConta1 <= loc_lnNivels)
                                        SELECT (loc_laStrArea(loc_lnConta1))
                                        SET ORDER TO Classes
                                        SEEK loc_cContas
                                    ENDIF
                                    loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                    loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                        IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                    loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                        loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                    loc_cIps = STR(loc_lnConta1, 1)
                                    IF (loc_lnOptRel = 1 OR loc_cPs <> "5")
                                        SELECT cPlConta
                                        SET ORDER TO cOrds
                                        IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                            INSERT INTO cPlConta ;
                                                (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                 cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                        ENDIF
                                    ENDIF
                                    SELECT cursor_4c_BalGcr
                                ENDFOR
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Criar cursor Consulta (nome exato exigido por SigReAcs.frx)
            IF USED("Consulta")
                USE IN Consulta
            ENDIF
            SELECT * FROM cursor_4c_BalTmpMccr ;
                WHERE ABS(Saldos) > 1 ;
                INTO CURSOR Consulta READWRITE

            *-- Fechar cursor de movimentos (dados ja processados)
            IF USED("cursor_4c_BalMvcr")
                USE IN cursor_4c_BalMvcr
            ENDIF

            *-- Ordenar cPlConta para apresentacao correta no relatorio
            SELECT cPlConta
            SET ORDER TO cOrds ASCENDING
            GO TOP

            SET ESCAPE &loc_lcEscape.
            SET DECIMALS TO loc_lnDecimals
            SET FIXED &loc_lcFixed.

            loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.PrepararDados")
            IF !EMPTY(loc_lcEscape)
                SET ESCAPE &loc_lcEscape.
            ENDIF
            IF loc_lnDecimals > 0
                SET DECIMALS TO loc_lnDecimals
            ENDIF
            IF !EMPTY(loc_lcFixed)
                SET FIXED &loc_lcFixed.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Preview do relatorio de balanco na tela
    * Equivalente ao PROCEDURE visualizacao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) PREVIEW NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto na impressora padrao
    * Equivalente ao PROCEDURE documento do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) TO PRINTER NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de um cursor
    * Em BOs REPORT este metodo nao aplica operacao CRUD: os filtros sao
    * preenchidos via FormParaRelatorio() chamando atribuicoes diretas.
    * Mantemos a assinatura para compatibilidade com o contrato de BOs.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- Mapeamento opcional caso o cursor possua os campos de filtro
            IF TYPE(par_cAliasCursor + ".DtFinal") = "D"
                THIS.this_dDtFinal = NVL(EVALUATE(par_cAliasCursor + ".DtFinal"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".CMoes") = "C"
                THIS.this_cCdMoeda = NVL(EVALUATE(par_cAliasCursor + ".CMoes"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DMoes") = "C"
                THIS.this_cDsMoeda = NVL(EVALUATE(par_cAliasCursor + ".DMoes"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Emps") = "C"
                THIS.this_cCdEmpresa = NVL(EVALUATE(par_cAliasCursor + ".Emps"), "")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BOs REPORT nao realizam INSERT em tabelas
    * Operacao nao se aplica: o relatorio apenas LE dados via PrepararDados().
    * Retorna .F. e registra mensagem para qualquer chamada acidental.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o de inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o se aplica a relat" + CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BOs REPORT nao realizam UPDATE em tabelas
    * Operacao nao se aplica: o relatorio apenas LE dados via PrepararDados().
    * Retorna .F. e registra mensagem para qualquer chamada acidental.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o de atualiza" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o se aplica a relat" + CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - REPORT BO nao possui registro corrente unico
    * Retorna chave composta dos filtros (data+moeda+empresa) para auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emissao de relatorio em LogAuditoria
    * Chamado por Visualizar/Imprimir/ImprimirComPrompt apos emissao bem-sucedida.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "")
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigMvCcr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Imprime relatorio com dialogo de selecao de impressora
    * Equivalente ao PROCEDURE impressao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) TO PRINTER PROMPT NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.ImprimirComPrompt")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'BtnIncluirNavegacao': Unknown member OFORM. | Detalhes: Linha: 992, Proc: testebtnincluirnavegacao; Teste 'BtnEncerrarExiste': Function argument value, type, or count is invalid. | Detalhes: Linha: 1044, Proc: testebtnencerrarexiste; Teste 'LookupMetodosExistem': Function argument value, type, or count is invalid. | Detalhes: Linha: 1187, Proc: testelookupmetodosexistem

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-16 11:49:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 11:49:02] [INFO] Config FPW: (nao fornecido)
[2026-05-16 11:49:02] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 11:49:02] [INFO] Timeout: 300 segundos
[2026-05-16 11:49:02] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_050xygvl.prg
[2026-05-16 11:49:02] [INFO] Conteudo do wrapper:
[2026-05-16 11:49:02] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
QUIT

[2026-05-16 11:49:02] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_050xygvl.prg
[2026-05-16 11:49:02] [INFO] VFP output esperado em: C:\4c\tasks\task035\vfp_output.txt
[2026-05-16 11:49:02] [INFO] Executando Visual FoxPro 9...
[2026-05-16 11:49:02] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_050xygvl.prg
[2026-05-16 11:49:02] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_050xygvl.prg
[2026-05-16 11:49:02] [INFO] Timeout configurado: 300 segundos
[2026-05-16 11:49:04] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 11:49:04] [INFO] VFP9 finalizado em 1.8689717 segundos
[2026-05-16 11:49:04] [INFO] Exit Code: 
[2026-05-16 11:49:04] [INFO] 
[2026-05-16 11:49:04] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 11:49:04] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_050xygvl.prg
[2026-05-16 11:49:04] [INFO] 
[2026-05-16 11:49:04] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 11:49:04] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 11:49:04] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 11:49:04] [INFO] * Parameters: 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
[2026-05-16 11:49:04] [INFO] 
[2026-05-16 11:49:04] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 11:49:04] [INFO] SET SAFETY OFF
[2026-05-16 11:49:04] [INFO] SET RESOURCE OFF
[2026-05-16 11:49:04] [INFO] SET TALK OFF
[2026-05-16 11:49:04] [INFO] SET NOTIFY OFF
[2026-05-16 11:49:04] [INFO] SYS(2335, 0)
[2026-05-16 11:49:04] [INFO] 
[2026-05-16 11:49:04] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
[2026-05-16 11:49:04] [INFO] QUIT
[2026-05-16 11:49:04] [INFO] 
[2026-05-16 11:49:04] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 11:49:04] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-05-16 11:49:49] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 11:49:49] [INFO] Config FPW: (nao fornecido)
[2026-05-16 11:49:49] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 11:49:49] [INFO] Timeout: 300 segundos
[2026-05-16 11:49:49] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_hmlkip4w.prg
[2026-05-16 11:49:49] [INFO] Conteudo do wrapper:
[2026-05-16 11:49:49] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
QUIT

[2026-05-16 11:49:49] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_hmlkip4w.prg
[2026-05-16 11:49:49] [INFO] VFP output esperado em: C:\4c\tasks\task035\vfp_output.txt
[2026-05-16 11:49:49] [INFO] Executando Visual FoxPro 9...
[2026-05-16 11:49:49] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_hmlkip4w.prg
[2026-05-16 11:49:49] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_hmlkip4w.prg
[2026-05-16 11:49:49] [INFO] Timeout configurado: 300 segundos
[2026-05-16 11:49:51] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 11:49:51] [INFO] VFP9 finalizado em 2.6205074 segundos
[2026-05-16 11:49:51] [INFO] Exit Code: 
[2026-05-16 11:49:51] [INFO] 
[2026-05-16 11:49:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 11:49:51] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_hmlkip4w.prg
[2026-05-16 11:49:51] [INFO] 
[2026-05-16 11:49:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 11:49:51] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 11:49:51] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 11:49:51] [INFO] * Parameters: 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
[2026-05-16 11:49:51] [INFO] 
[2026-05-16 11:49:51] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 11:49:51] [INFO] SET SAFETY OFF
[2026-05-16 11:49:51] [INFO] SET RESOURCE OFF
[2026-05-16 11:49:51] [INFO] SET TALK OFF
[2026-05-16 11:49:51] [INFO] SET NOTIFY OFF
[2026-05-16 11:49:51] [INFO] SYS(2335, 0)
[2026-05-16 11:49:51] [INFO] 
[2026-05-16 11:49:51] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
[2026-05-16 11:49:51] [INFO] QUIT
[2026-05-16 11:49:51] [INFO] 
[2026-05-16 11:49:51] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 11:49:51] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-05-16 11:52:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 11:52:17] [INFO] Config FPW: (nao fornecido)
[2026-05-16 11:52:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 11:52:17] [INFO] Timeout: 300 segundos
[2026-05-16 11:52:17] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kwh01oiv.prg
[2026-05-16 11:52:17] [INFO] Conteudo do wrapper:
[2026-05-16 11:52:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
QUIT

[2026-05-16 11:52:17] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kwh01oiv.prg
[2026-05-16 11:52:17] [INFO] VFP output esperado em: C:\4c\tasks\task035\vfp_output.txt
[2026-05-16 11:52:17] [INFO] Executando Visual FoxPro 9...
[2026-05-16 11:52:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kwh01oiv.prg
[2026-05-16 11:52:17] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kwh01oiv.prg
[2026-05-16 11:52:17] [INFO] Timeout configurado: 300 segundos
[2026-05-16 11:52:20] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 11:52:20] [INFO] VFP9 finalizado em 2.6043441 segundos
[2026-05-16 11:52:20] [INFO] Exit Code: 
[2026-05-16 11:52:20] [INFO] 
[2026-05-16 11:52:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 11:52:20] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kwh01oiv.prg
[2026-05-16 11:52:20] [INFO] 
[2026-05-16 11:52:20] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 11:52:20] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 11:52:20] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 11:52:20] [INFO] * Parameters: 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
[2026-05-16 11:52:20] [INFO] 
[2026-05-16 11:52:20] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 11:52:20] [INFO] SET SAFETY OFF
[2026-05-16 11:52:20] [INFO] SET RESOURCE OFF
[2026-05-16 11:52:20] [INFO] SET TALK OFF
[2026-05-16 11:52:20] [INFO] SET NOTIFY OFF
[2026-05-16 11:52:20] [INFO] SYS(2335, 0)
[2026-05-16 11:52:20] [INFO] 
[2026-05-16 11:52:20] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreato', 'C:\4c\tasks\task035', 'REPORT'
[2026-05-16 11:52:20] [INFO] QUIT
[2026-05-16 11:52:20] [INFO] 
[2026-05-16 11:52:20] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 11:52:20] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigreato",
  "timestamp": "20260516115220",
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
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": false,
      "erro": "Unknown member OFORM.",
      "detalhes": "Linha: 992, Proc: testebtnincluirnavegacao"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 1044, Proc: testebtnencerrarexiste"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 1187, Proc: testelookupmetodosexistem"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "Objeto form ja era invalido",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 6,
    "falhou": 3,
    "percentual": 67
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreato.prg):
*==============================================================================
* FORMSIGREATO.PRG
* Relatorio de Analise de Estoque Por Tipo de Operacao
* Tipo: REPORT (herda FormBase, BO: sigreatoBO herda RelatorioBase)
* Migrado de: SIGREATO.SCX (frmrelatorio)
*
* Filtros (layout flat - controles em cnt_4c_Local na Page1):
*   - Periodo (DataIni / DataFinal)
*   - Grupo de Produto (CGrus/DGrus)  -> SigCdGrp
*   - Produto (CPros/DPros)           -> SigCdPro
*   - Linha (Linhas/Descs)            -> SigCdLin
*   - Fornecedor (IFors/nomes)        -> SIGCDCLI
*   - optImagem (1=Com Imagem, 2=Sem Imagem)
*   - optTipos  (1=Analitico, 2=Sintetico)
*   - optDiferencas (1=Ignorar, 2=Sem Diferenca, 3=Positiva, 4=Negativa)
*   - grd_4c_OperacoesE + cmd_4c_BtnGradeE (tipos de entrada)
*   - grd_4c_OperacoesS + cmd_4c_BtnGradeS (tipos de saida)
*   - grd_4c_SigCdCeg   + cmd_4c_BtnCeg   (contas de estoque)
*==============================================================================

DEFINE CLASS FormSigreato AS FormBase

    *-- Dimensoes EXATAS baseadas no original SIGREATO.SCX
    Height      = 510
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta toda a estrutura do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque Por Tipo de Opera" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreatoBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreatoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.InicializarDados()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao inicializar dados")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.LimparCampos()
                THIS.Visible   = .T.
                loc_lSucesso   = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigreato:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro cinza medio com titulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque Por Tipo de Opera" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque Por Tipo de Opera" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup btnReport: 4 botoes Visualizar/Imprimir
    *   /DocExcel/Encerrar. Left=527, Height=80 (frmrelatorio canonical).
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
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Visible         = .T.
        ENDWITH
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
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Visible         = .T.
        ENDWITH
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Doc Excel"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
            .Visible         = .T.
        ENDWITH
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
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame 1 pagina abaixo do cabecalho (Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas
        loc_oPgf.PageCount = 2
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Entry point para a unica Page do form de relatorio.
    *   Monta os filtros + grades de selecao de tipos/contas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarGrades()
        THIS.ConfigurarMensagem()
        THIS.ConfigurarBINDEVENTs()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria cnt_4c_Local e controles de filtro:
    *   Periodo, Grupo, Produto, Linha, Fornecedor + OptionGroups
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg, loc_oCnt
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Local", "Container")
        WITH loc_oPg.cnt_4c_Local
            .Top         = 0
            .Left        = 0
            .Width       = 800
            .Height      = 425
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPg.cnt_4c_Local

        *-- Periodo -------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oCnt.lbl_4c_Periodo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 68
            .Top       = 13
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DataIni", "TextBox")
        WITH loc_oCnt.txt_4c_DataIni
            .Height        = 23
            .Left          = 116
            .Top           = 10
            .Width         = 80
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oCnt.lbl_4c_Ate
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = " " + CHR(233) + " "
            .Left      = 200
            .Top       = 13
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DataFin", "TextBox")
        WITH loc_oCnt.txt_4c_DataFin
            .Height        = 23
            .Left          = 215
            .Top           = 10
            .Width         = 80
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Grupo de Produto -----------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oCnt.lbl_4c_Grupo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Left      = 75
            .Top       = 38
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Height        = 23
            .Left          = 116
            .Top           = 35
            .Width         = 31
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupo
            .Height        = 23
            .Left          = 149
            .Top           = 35
            .Width         = 181
            .MaxLength     = 20
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Produto --------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_CPros", "Label")
        WITH loc_oCnt.lbl_4c_CPros
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Left      = 66
            .Top       = 63
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CPros", "TextBox")
        WITH loc_oCnt.txt_4c_CPros
            .Height        = 23
            .Left          = 116
            .Top           = 60
            .Width         = 108
            .MaxLength     = 14
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DPros", "TextBox")
        WITH loc_oCnt.txt_4c_DPros
            .Height        = 23
            .Left          = 225
            .Top           = 60
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Linha ----------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Linha", "Label")
        WITH loc_oCnt.lbl_4c_Linha
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Linha :"
            .Left      = 79
            .Top       = 88
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Linha", "TextBox")
        WITH loc_oCnt.txt_4c_Linha
            .Height        = 23
            .Left          = 116
            .Top           = 85
            .Width         = 80
            .MaxLength     = 10
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DLin", "TextBox")
        WITH loc_oCnt.txt_4c_DLin
            .Height        = 23
            .Left          = 198
            .Top           = 85
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Fornecedor -----------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Fornecedor", "Label")
        WITH loc_oCnt.lbl_4c_Fornecedor
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Fornecedor :"
            .Left      = 49
            .Top       = 113
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fornecedor", "TextBox")
        WITH loc_oCnt.txt_4c_Fornecedor
            .Height        = 23
            .Left          = 116
            .Top           = 110
            .Width         = 80
            .MaxLength     = 10
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DFornecedor", "TextBox")
        WITH loc_oCnt.txt_4c_DFornecedor
            .Height        = 23
            .Left          = 198
            .Top           = 110
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- optImagem (Com Imagem / Sem Imagem) - padrao: Sem Imagem (2) ---
        loc_oCnt.AddObject("opt_4c_Imagem", "OptionGroup")
        WITH loc_oCnt.opt_4c_Imagem
            .Top         = 10
            .Left        = 521
            .Width       = 211
            .Height      = 22
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.opt_4c_Imagem.Buttons(1)
            .Caption   = "Com Imagem"
            .Left      = 5
            .Top       = 2
            .Width     = 80
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Imagem.Buttons(2)
            .Caption   = "Sem Imagem"
            .Left      = 104
            .Top       = 2
            .Width     = 79
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- optTipos (Analitico / Sintetico) - padrao: Analitico (1) ------
        loc_oCnt.AddObject("opt_4c_Tipos", "OptionGroup")
        WITH loc_oCnt.opt_4c_Tipos
            .Top         = 35
            .Left        = 521
            .Width       = 211
            .Height      = 22
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.opt_4c_Tipos.Buttons(1)
            .Caption   = "Anal" + CHR(237) + "tico"
            .Left      = 5
            .Top       = 2
            .Width     = 58
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Tipos.Buttons(2)
            .Caption   = "Sint" + CHR(233) + "tico"
            .Left      = 104
            .Top       = 2
            .Width     = 78
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- optDiferencas (4 opcoes) - padrao: Ignorar (1) ----------------
        loc_oCnt.AddObject("opt_4c_Diferencas", "OptionGroup")
        WITH loc_oCnt.opt_4c_Diferencas
            .Top         = 60
            .Left        = 521
            .Width       = 211
            .Height      = 72
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.opt_4c_Diferencas.Buttons(1)
            .Caption   = "Ignorar Diferen" + CHR(231) + "as"
            .Left      = 5
            .Top       = 3
            .Width     = 108
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Diferencas.Buttons(2)
            .Caption   = "Sem Diferen" + CHR(231) + "a"
            .Left      = 5
            .Top       = 19
            .Width     = 87
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Diferencas.Buttons(3)
            .Caption   = "Diferen" + CHR(231) + "a Positiva"
            .Left      = 5
            .Top       = 35
            .Width     = 104
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Diferencas.Buttons(4)
            .Caption   = "Diferen" + CHR(231) + "a Negativa"
            .Left      = 5
            .Top       = 51
            .Width     = 110
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Adiciona separadores visuais e labels de secao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        *-- Linha divisoria esquerda (Tipos de Operacoes) ------------------
        loc_oCnt.AddObject("shp_4c_Div1", "Shape")
        WITH loc_oCnt.shp_4c_Div1
            .Top         = 144
            .Left        = 42
            .Width       = 333
            .Height      = 2
            .BorderStyle = 6
            .BorderWidth = 2
            .FillStyle   = 1
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *-- Linha divisoria direita (Estoques) ----------------------------
        loc_oCnt.AddObject("shp_4c_Div2", "Shape")
        WITH loc_oCnt.shp_4c_Div2
            .Top         = 144
            .Left        = 414
            .Width       = 267
            .Height      = 2
            .BorderStyle = 6
            .BorderWidth = 2
            .FillStyle   = 1
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *-- Label "Tipos de Operacoes" ------------------------------------
        loc_oCnt.AddObject("lbl_4c_TiposOpe", "Label")
        WITH loc_oCnt.lbl_4c_TiposOpe
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = " Tipos de Opera" + CHR(231) + CHR(245) + "es "
            .Left      = 47
            .Top       = 148
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Estoques" -----------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Estoques", "Label")
        WITH loc_oCnt.lbl_4c_Estoques
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = " Estoques  "
            .Left      = 421
            .Top       = 148
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrades - Cria as 3 grades com botoes de marca/desmarca:
    *   grd_4c_OperacoesE + cmd_4c_BtnGradeE (tipos de entrada)
    *   grd_4c_OperacoesS + cmd_4c_BtnGradeS (tipos de saida)
    *   grd_4c_SigCdCeg   + cmd_4c_BtnCeg   (contas de estoque)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrades()
        LOCAL loc_oCnt, loc_oGrd
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        *-- Garantir cursores placeholder se InicializarDados foi pulado ----
        IF !USED("cursor_4c_OperacoesE")
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
        ENDIF
        IF !USED("cursor_4c_OperacoesS")
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
        ENDIF
        IF !USED("cursor_4c_SigCdCeg")
            SET NULL ON
            CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
            SET NULL OFF
        ENDIF

        *====================================================================
        * Grade de Operacoes de Entrada
        *====================================================================
        loc_oCnt.AddObject("grd_4c_OperacoesE", "Grid")
        WITH loc_oCnt.grd_4c_OperacoesE
            .ColumnCount       = 3
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .GridLines         = 3
            .HeaderHeight      = 16
            .Height            = 99
            .Left              = 46
            .Panel             = 1
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabStop           = .F.
            .Top               = 163
            .Width             = 275
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oGrd = loc_oCnt.grd_4c_OperacoesE
        loc_oGrd.ColumnCount = 3
        loc_oGrd.RecordSource = "cursor_4c_OperacoesE"

        WITH loc_oGrd.Column1
            .Width         = 15
            .Sparse        = .F.
            .Alignment     = 0
            .Enabled       = .T.
            .ReadOnly      = .F.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_Marca
            .Caption   = ""
            .Alignment = 0
            .BackStyle = 0
            .Enabled   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
        loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesE.SelImp"

        WITH loc_oGrd.Column2
            .Width         = 20
            .ControlSource = "cursor_4c_OperacoesE.Codigos"
            .ReadOnly      = .T.
            .Enabled       = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column2.Header1.Caption  = ""
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)

        WITH loc_oGrd.Column3
            .Width         = 208
            .ControlSource = "cursor_4c_OperacoesE.Descrs"
            .ReadOnly      = .T.
            .Enabled       = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Entrada"
        loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
        loc_oGrd.Column3.Header1.Alignment  = 2

        *-- Botoes Marca/Desmarca para Entradas ----------------------------
        loc_oCnt.AddObject("cmd_4c_BtnGradeE", "CommandGroup")
        WITH loc_oCnt.cmd_4c_BtnGradeE
            .AutoSize    = .T.
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 90
            .Left        = 321
            .Top         = 168
            .Width       = 50
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.cmd_4c_BtnGradeE.Buttons(1)
            .Top         = 5
            .Left        = 5
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .ToolTipText = "Selecionar todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
        ENDWITH
        WITH loc_oCnt.cmd_4c_BtnGradeE.Buttons(2)
            .Top         = 45
            .Left        = 5
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .ToolTipText = "Desmarcar todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_16.jpg"
        ENDWITH

        *====================================================================
        * Grade de Operacoes de Saida
        *====================================================================
        loc_oCnt.AddObject("grd_4c_OperacoesS", "Grid")
        WITH loc_oCnt.grd_4c_OperacoesS
            .ColumnCount       = 3
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .GridLines         = 3
            .HeaderHeight      = 16
            .Height            = 99
            .Left              = 46
            .Panel             = 1
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabStop           = .F.
            .Top               = 276
            .Width             = 275
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oGrd = loc_oCnt.grd_4c_OperacoesS
        loc_oGrd.ColumnCount = 3
        loc_oGrd.RecordSource = "cursor_4c_OperacoesS"

        WITH loc_oGrd.Column1
            .Width         = 15
            .Sparse        = .F.
            .Alignment     = 0
            .Enabled       = .T.
            .ReadOnly      = .F.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_marca2", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_marca2
            .Caption   = ""
            .Alignment = 0
            .BackStyle = 0
            .Enabled   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_marca2"
        loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesS.SelImp"

        WITH loc_oGrd.Column2
            .Width         = 20
            .ControlSource = "cursor_4c_OperacoesS.Codigos"
            .ReadOnly      = .T.
            .Enabled       = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column2.Header1.Caption  = ""
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)

        WITH loc_oGrd.Column3
            .Width         = 208
            .ControlSource = "cursor_4c_OperacoesS.Descrs"
            .ReadOnly      = .T.
            .Enabled       = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Sa" + CHR(237) + "da"
        loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
        loc_oGrd.Column3.Header1.Alignment  = 2

        *-- Botoes Marca/Desmarca para Saidas ------------------------------
        loc_oCnt.AddObject("cmd_4c_BtnGradeS", "CommandGroup")
        WITH loc_oCnt.cmd_4c_BtnGradeS
            .AutoSize    = .T.
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 90
            .Left        = 321
            .Top         = 282
            .Width       = 50
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.cmd_4c_BtnGradeS.Buttons(1)
            .Top         = 5
            .Left        = 5
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .ToolTipText = "Selecionar todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
        ENDWITH
        WITH loc_oCnt.cmd_4c_BtnGradeS.Buttons(2)
            .Top         = 45
            .Left        = 5
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .ToolTipText = "Desmarcar todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_16.jpg"
        ENDWITH

        *====================================================================
        * Grade de Contas de Estoque (SigCdCeg)
        *====================================================================
        loc_oCnt.AddObject("grd_4c_SigCdCeg", "Grid")
        WITH loc_oCnt.grd_4c_SigCdCeg
            .ColumnCount       = 3
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .GridLines         = 3
            .HeaderHeight      = 16
            .Height            = 211
            .Left              = 421
            .Panel             = 1
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabStop           = .F.
            .Top               = 163
            .Width             = 207
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oGrd = loc_oCnt.grd_4c_SigCdCeg
        loc_oGrd.ColumnCount = 3
        loc_oGrd.RecordSource = "cursor_4c_SigCdCeg"

        WITH loc_oGrd.Column1
            .Width         = 15
            .Sparse        = .F.
            .Alignment     = 0
            .Enabled       = .T.
            .ReadOnly      = .F.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_marca3", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_marca3
            .Caption   = ""
            .Alignment = 0
            .BackStyle = 0
            .Enabled   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_marca3"
        loc_oGrd.Column1.ControlSource  = "cursor_4c_SigCdCeg.lMarca"

        WITH loc_oGrd.Column2
            .Width         = 80
            .ControlSource = "cursor_4c_SigCdCeg.Grupos"
            .ReadOnly      = .T.
            .Enabled       = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column2.Header1.Caption  = "Grupo"
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)

        WITH loc_oGrd.Column3
            .Width         = 80
            .ControlSource = "cursor_4c_SigCdCeg.Contas"
            .ReadOnly      = .T.
            .Enabled       = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .FontSize      = 8
        ENDWITH
        loc_oGrd.Column3.Header1.Caption  = "Conta"
        loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)

        *-- Botoes Marca/Desmarca para SigCdCeg ----------------------------
        loc_oCnt.AddObject("cmd_4c_BtnCeg", "CommandGroup")
        WITH loc_oCnt.cmd_4c_BtnCeg
            .AutoSize    = .T.
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 90
            .Left        = 632
            .Top         = 225
            .Width       = 50
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.cmd_4c_BtnCeg.Buttons(1)
            .Top         = 5
            .Left        = 5
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .ToolTipText = "Selecionar todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
        ENDWITH
        WITH loc_oCnt.cmd_4c_BtnCeg.Buttons(2)
            .Top         = 45
            .Left        = 5
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .ToolTipText = "Desmarcar todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_16.jpg"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMensagem - Cria container "Aguarde!!!" (oculto inicialmente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMensagem()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_oCnt.AddObject("cnt_4c_Mensagem", "Container")
        WITH loc_oCnt.cnt_4c_Mensagem
            .Top         = 390
            .Left        = 130
            .Width       = 400
            .Height      = 30
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH
        loc_oCnt.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
        WITH loc_oCnt.cnt_4c_Mensagem.lbl_4c_LblMensagem
            .Top       = 5
            .Left      = 10
            .Width     = 380
            .Height    = 22
            .Caption   = "Aguarde!!!"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - Conecta eventos dos controles aos handlers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        BINDEVENT(THIS.cmg_4c_Botoes,             "Click",    THIS, "CmgBotoesClick")

        BINDEVENT(loc_oCnt.txt_4c_DataIni,        "KeyPress", THIS, "TxtDataIniKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DataFin,        "KeyPress", THIS, "TxtDataFinKeyPress")

        BINDEVENT(loc_oCnt.txt_4c_Grupo,          "KeyPress", THIS, "TxtGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Grupo,          "DblClick", THIS, "TxtGrupoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo,         "KeyPress", THIS, "TxtDGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo,         "DblClick", THIS, "TxtDGrupoDblClick")

        BINDEVENT(loc_oCnt.txt_4c_CPros,          "KeyPress", THIS, "TxtCProsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CPros,          "DblClick", THIS, "TxtCProsDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DPros,          "KeyPress", THIS, "TxtDProsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DPros,          "DblClick", THIS, "TxtDProsDblClick")

        BINDEVENT(loc_oCnt.txt_4c_Linha,          "KeyPress", THIS, "TxtLinhaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Linha,          "DblClick", THIS, "TxtLinhaDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DLin,           "KeyPress", THIS, "TxtDLinKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DLin,           "DblClick", THIS, "TxtDLinDblClick")

        BINDEVENT(loc_oCnt.txt_4c_Fornecedor,     "KeyPress", THIS, "TxtFornecedorKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Fornecedor,     "DblClick", THIS, "TxtFornecedorDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DFornecedor,    "KeyPress", THIS, "TxtDFornecedorKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DFornecedor,    "DblClick", THIS, "TxtDFornecedorDblClick")

        BINDEVENT(loc_oCnt.cmd_4c_BtnGradeE,      "Click",    THIS, "CmdGradeEClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnGradeS,      "Click",    THIS, "CmdGradeSClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnCeg,         "Click",    THIS, "CmdCegClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa/zera todos os campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        loc_oCnt.txt_4c_DataIni.Value     = DATE()
        loc_oCnt.txt_4c_DataFin.Value     = DATE()
        loc_oCnt.txt_4c_Grupo.Value       = ""
        loc_oCnt.txt_4c_DGrupo.Value      = ""
        loc_oCnt.txt_4c_CPros.Value       = ""
        loc_oCnt.txt_4c_DPros.Value       = ""
        loc_oCnt.txt_4c_Linha.Value       = ""
        loc_oCnt.txt_4c_DLin.Value        = ""
        loc_oCnt.txt_4c_Fornecedor.Value  = ""
        loc_oCnt.txt_4c_DFornecedor.Value = ""
        loc_oCnt.opt_4c_Imagem.Value      = 2
        loc_oCnt.opt_4c_Tipos.Value       = 1
        loc_oCnt.opt_4c_Diferencas.Value  = 1
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Habilita/desabilita campos de descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        loc_oCnt.txt_4c_DGrupo.ReadOnly      = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        loc_oCnt.txt_4c_DPros.ReadOnly        = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_CPros.Value))
        loc_oCnt.txt_4c_DLin.ReadOnly         = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Linha.Value))
        loc_oCnt.txt_4c_DFornecedor.ReadOnly  = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Fornecedor.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        WITH THIS.this_oRelatorio
            .this_dDtInicial    = loc_oCnt.txt_4c_DataIni.Value
            .this_dDtFinal      = loc_oCnt.txt_4c_DataFin.Value
            .this_cGrupo        = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            .this_cDGrupo       = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
            .this_cCPros        = ALLTRIM(loc_oCnt.txt_4c_CPros.Value)
            .this_cDPros        = ALLTRIM(loc_oCnt.txt_4c_DPros.Value)
            .this_cLin          = ALLTRIM(loc_oCnt.txt_4c_Linha.Value)
            .this_cDLin         = ALLTRIM(loc_oCnt.txt_4c_DLin.Value)
            .this_cFornecedor   = ALLTRIM(loc_oCnt.txt_4c_Fornecedor.Value)
            .this_cDFornecedor  = ALLTRIM(loc_oCnt.txt_4c_DFornecedor.Value)
            .this_lImagem       = (loc_oCnt.opt_4c_Imagem.Value = 1)
            .this_nTipos        = loc_oCnt.opt_4c_Tipos.Value
            .this_nDiferenca    = loc_oCnt.opt_4c_Diferencas.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.AlternarPagina(1)
        THIS.OcultarAguarde()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND VARTYPE(par_nPagina) = "N" AND ;
           par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgBotoesClick - Valida selecao de tipos e despachna para o handler certo
    *--------------------------------------------------------------------------
    PROCEDURE CmgBotoesClick()
        LOCAL loc_nBotao
        loc_nBotao = THIS.cmg_4c_Botoes.Value
        IF loc_nBotao <> 4
            IF !THIS.ValidarSelecaoGrades()
                RETURN
            ENDIF
        ENDIF
        DO CASE
        CASE loc_nBotao = 1
            THIS.BtnVisualizarClick()
        CASE loc_nBotao = 2
            THIS.BtnImprimirClick()
        CASE loc_nBotao = 3
            THIS.BtnExcelClick()
        CASE loc_nBotao = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecaoGrades - Verifica que ha pelo menos 1 E e 1 S selecionados
    *   e que nenhum tipo aparece em ambas as listas (sem intersecao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarSelecaoGrades()
        LOCAL loc_lOK, loc_oCnt
        loc_lOK  = .T.
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        IF USED("cursor_4c_OperacoesE")
            SELECT Codigos FROM cursor_4c_OperacoesE WHERE SelImp INTO CURSOR cursor_4c_TmpE READWRITE
            IF RECCOUNT("cursor_4c_TmpE") < 1
                MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Entrada Foi Selecionado!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oCnt.grd_4c_OperacoesE) = "O"
                    loc_oCnt.grd_4c_OperacoesE.Column1.SetFocus()
                ENDIF
                IF USED("cursor_4c_TmpE")
                    USE IN cursor_4c_TmpE
                ENDIF
                RETURN .F.
            ENDIF
        ENDIF

        IF USED("cursor_4c_OperacoesS")
            SELECT Codigos FROM cursor_4c_OperacoesS WHERE SelImp INTO CURSOR cursor_4c_TmpS READWRITE
            IF RECCOUNT("cursor_4c_TmpS") < 1
                MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da Foi Selecionado!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oCnt.grd_4c_OperacoesS) = "O"
                    loc_oCnt.grd_4c_OperacoesS.Column1.SetFocus()
                ENDIF
                IF USED("cursor_4c_TmpE")
                    USE IN cursor_4c_TmpE
                ENDIF
                IF USED("cursor_4c_TmpS")
                    USE IN cursor_4c_TmpS
                ENDIF
                RETURN .F.
            ENDIF
        ENDIF

        *-- Verificar intersecao E/S
        IF USED("cursor_4c_TmpE") AND USED("cursor_4c_TmpS")
            SELECT cursor_4c_TmpE.Codigos FROM cursor_4c_TmpE ;
                WHERE cursor_4c_TmpE.Codigos IN ;
                (SELECT cursor_4c_TmpS.Codigos FROM cursor_4c_TmpS) ;
                INTO CURSOR cursor_4c_TmpDup READWRITE
            IF RECCOUNT("cursor_4c_TmpDup") > 0
                MsgAviso("Foram Selecionados Tipos de Opera" + CHR(231) + CHR(245) + "es de Entrada e Sa" + CHR(237) + "da Iguais!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOK = .F.
            ENDIF
            IF USED("cursor_4c_TmpDup")
                USE IN cursor_4c_TmpDup
            ENDIF
        ENDIF

        IF USED("cursor_4c_TmpE")
            USE IN cursor_4c_TmpE
        ENDIF
        IF USED("cursor_4c_TmpS")
            USE IN cursor_4c_TmpS
        ENDIF

        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        IF !THIS.this_oRelatorio.ExportarExcel()
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt.cnt_4c_Mensagem) = "O"
            loc_oCnt.cnt_4c_Mensagem.Visible = .T.
            loc_oCnt.cnt_4c_Mensagem.Refresh()
            THIS.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE OcultarAguarde()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt.cnt_4c_Mensagem) = "O"
            loc_oCnt.cnt_4c_Mensagem.Visible = .F.
        ENDIF
    ENDPROC

    *-- Handlers FormBase CRUD (report form: redirecionam para acao proxima) --
    PROCEDURE BtnIncluirClick()
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    PROCEDURE BtnAlterarClick()
        IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local) = "O"
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    * KeyPress handlers (F4=115, F5=116, Enter=13, Tab=9)
    *==========================================================================
    PROCEDURE TxtDataIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DataFin.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE TxtDataFinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_Grupo.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaGrupo()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            LOCAL loc_cCod
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarGrupo(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DGrupo.Value   = ""
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DGrupo.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DGrupo.Value))
                THIS.AbrirBuscaGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtCProsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaProduto()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            LOCAL loc_cCod
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_CPros.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarProduto(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DPros.Value   = ""
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DPros.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDProsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DPros.Value))
                THIS.AbrirBuscaProduto()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLinha()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            LOCAL loc_cCod
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_Linha.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarLinha(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DLin.Value   = ""
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DLin.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DLin.Value))
                THIS.AbrirBuscaLinha()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtFornecedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFornecedor()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            LOCAL loc_cCod
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_Fornecedor.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarFornecedor(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DFornecedor.Value   = ""
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DFornecedor.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDFornecedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DFornecedor.Value))
                THIS.AbrirBuscaFornecedor()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * DblClick handlers (mesma acao que F4)
    *==========================================================================
    PROCEDURE TxtGrupoDblClick()
        THIS.AbrirBuscaGrupo()
    ENDPROC

    PROCEDURE TxtDGrupoDblClick()
        THIS.AbrirBuscaGrupo()
    ENDPROC

    PROCEDURE TxtCProsDblClick()
        THIS.AbrirBuscaProduto()
    ENDPROC

    PROCEDURE TxtDProsDblClick()
        THIS.AbrirBuscaProduto()
    ENDPROC

    PROCEDURE TxtLinhaDblClick()
        THIS.AbrirBuscaLinha()
    ENDPROC

    PROCEDURE TxtDLinDblClick()
        THIS.AbrirBuscaLinha()
    ENDPROC

    PROCEDURE TxtFornecedorDblClick()
        THIS.AbrirBuscaFornecedor()
    ENDPROC

    PROCEDURE TxtDFornecedorDblClick()
        THIS.AbrirBuscaFornecedor()
    ENDPROC

    *==========================================================================
    * Handlers Marca/Desmarca das grades
    *==========================================================================
    PROCEDURE CmdGradeEClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF !USED("cursor_4c_OperacoesE")
            RETURN
        ENDIF
        IF loc_oCnt.cmd_4c_BtnGradeE.Value = 1
            SELECT cursor_4c_OperacoesE
            REPLACE ALL SelImp WITH .T.
            GO TOP
        ELSE
            SELECT cursor_4c_OperacoesE
            REPLACE ALL SelImp WITH .F.
            GO TOP
        ENDIF
        loc_oCnt.grd_4c_OperacoesE.Refresh()
    ENDPROC

    PROCEDURE CmdGradeSClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF !USED("cursor_4c_OperacoesS")
            RETURN
        ENDIF
        IF loc_oCnt.cmd_4c_BtnGradeS.Value = 1
            SELECT cursor_4c_OperacoesS
            REPLACE ALL SelImp WITH .T.
            GO TOP
        ELSE
            SELECT cursor_4c_OperacoesS
            REPLACE ALL SelImp WITH .F.
            GO TOP
        ENDIF
        loc_oCnt.grd_4c_OperacoesS.Refresh()
    ENDPROC

    PROCEDURE CmdCegClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF !USED("cursor_4c_SigCdCeg")
            RETURN
        ENDIF
        IF loc_oCnt.cmd_4c_BtnCeg.Value = 1
            SELECT cursor_4c_SigCdCeg
            REPLACE ALL lMarca WITH .T.
            GO TOP
        ELSE
            SELECT cursor_4c_SigCdCeg
            REPLACE ALL lMarca WITH .F.
            GO TOP
        ENDIF
        loc_oCnt.grd_4c_SigCdCeg.Refresh()
    ENDPROC

    *==========================================================================
    * Lookups com FormBuscaAuxiliar
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - SigCdGrp (CGrus/DGrus)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oCnt, loc_cValor, loc_oForm
        loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_GrupoBusca", "CGrus", loc_cValor, ;
            "Selecionar Grupo")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_GrupoBusca")
                SELECT cursor_4c_GrupoBusca
                IF !EOF()
                    loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(CGrus)
                    loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(DGrus)
                ENDIF
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Grupo.Value  = ""
            loc_oCnt.txt_4c_DGrupo.Value = ""
        ENDIF

        IF USED("cursor_4c_GrupoBusca")
            USE IN cursor_4c_GrupoBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGrupo(par_cCodigo)
        LOCAL loc_oCnt, loc_cSQL, loc_nResult
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrupoVal
            IF !EOF()
                loc_oCnt.txt_4c_DGrupo.Value   = ALLTRIM(DGrus)
                loc_oCnt.txt_4c_DGrupo.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_GrupoVal
                THIS.AbrirBuscaGrupo()
                RETURN
            ENDIF
            USE IN cursor_4c_GrupoVal
        ELSE
            MsgAviso("Erro ao buscar grupo", "Aviso")
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaProduto - SigCdPro (CPros/DPros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaProduto()
        LOCAL loc_oCnt, loc_cValor, loc_oForm
        loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_CPros.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DPros.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_ProdBusca", "CPros", loc_cValor, ;
            "Selecionar Produto")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_ProdBusca")
                SELECT cursor_4c_ProdBusca
                IF !EOF()
                    loc_oCnt.txt_4c_CPros.Value   = ALLTRIM(CPros)
                    loc_oCnt.txt_4c_DPros.Value   = ALLTRIM(DPros)
                ENDIF
            ENDIF
        ELSE
            loc_oCnt.txt_4c_CPros.Value = ""
            loc_oCnt.txt_4c_DPros.Value = ""
        ENDIF

        IF USED("cursor_4c_ProdBusca")
            USE IN cursor_4c_ProdBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarProduto(par_cCodigo)
        LOCAL loc_oCnt, loc_cSQL, loc_nResult
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProdVal
            IF !EOF()
                loc_oCnt.txt_4c_DPros.Value   = ALLTRIM(DPros)
                loc_oCnt.txt_4c_DPros.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_ProdVal
                THIS.AbrirBuscaProduto()
                RETURN
            ENDIF
            USE IN cursor_4c_ProdVal
        ELSE
            MsgAviso("Erro ao buscar produto", "Aviso")
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaLinha - SigCdLin (Linhas/Descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaLinha()
        LOCAL loc_oCnt, loc_cValor, loc_oForm
        loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Linha.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DLin.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdLin", "cursor_4c_LinBusca", "Linhas", loc_cValor, ;
            "Selecionar Linha")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_LinBusca")
                SELECT cursor_4c_LinBusca
                IF !EOF()
                    loc_oCnt.txt_4c_Linha.Value = ALLTRIM(Linhas)
                    loc_oCnt.txt_4c_DLin.Value  = ALLTRIM(Descs)
                ENDIF
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Linha.Value = ""
            loc_oCnt.txt_4c_DLin.Value  = ""
        ENDIF

        IF USED("cursor_4c_LinBusca")
            USE IN cursor_4c_LinBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLinha(par_cCodigo)
        LOCAL loc_oCnt, loc_cSQL, loc_nResult
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinVal")
        IF loc_nResult > 0
            SELECT cursor_4c_LinVal
            IF !EOF()
                loc_oCnt.txt_4c_DLin.Value   = ALLTRIM(Descs)
                loc_oCnt.txt_4c_DLin.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_LinVal
                THIS.AbrirBuscaLinha()
                RETURN
            ENDIF
            USE IN cursor_4c_LinVal
        ELSE
            MsgAviso("Erro ao buscar linha", "Aviso")
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaFornecedor - SIGCDCLI (iclis/nomes) - substitui fAcessoContas
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaFornecedor()
        LOCAL loc_oCnt, loc_cValor, loc_oForm
        loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Fornecedor.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DFornecedor.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SIGCDCLI", "cursor_4c_FornBusca", "iclis", loc_cValor, ;
            "Selecionar Fornecedor")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("nomes", "", "Nome")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_FornBusca")
                SELECT cursor_4c_FornBusca
                IF !EOF()
                    loc_oCnt.txt_4c_Fornecedor.Value  = ALLTRIM(iclis)
                    loc_oCnt.txt_4c_DFornecedor.Value = ALLTRIM(nomes)
                ENDIF
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Fornecedor.Value  = ""
            loc_oCnt.txt_4c_DFornecedor.Value = ""
        ENDIF

        IF USED("cursor_4c_FornBusca")
            USE IN cursor_4c_FornBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFornecedor(par_cCodigo)
        LOCAL loc_oCnt, loc_cSQL, loc_nResult
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cSQL = "SELECT iclis, nomes FROM SIGCDCLI WHERE iclis = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")
        IF loc_nResult > 0
            SELECT cursor_4c_FornVal
            IF !EOF()
                loc_oCnt.txt_4c_DFornecedor.Value   = ALLTRIM(nomes)
                loc_oCnt.txt_4c_DFornecedor.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_FornVal
                THIS.AbrirBuscaFornecedor()
                RETURN
            ENDIF
            USE IN cursor_4c_FornVal
        ELSE
            MsgAviso("Erro ao buscar fornecedor", "Aviso")
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Popula campos do form a partir das propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            loc_oCnt.txt_4c_DataIni.Value      = IIF(EMPTY(.this_dDtInicial), DATE(), .this_dDtInicial)
            loc_oCnt.txt_4c_DataFin.Value      = IIF(EMPTY(.this_dDtFinal), DATE(), .this_dDtFinal)
            loc_oCnt.txt_4c_Grupo.Value        = ALLTRIM(.this_cGrupo)
            loc_oCnt.txt_4c_DGrupo.Value       = ALLTRIM(.this_cDGrupo)
            loc_oCnt.txt_4c_CPros.Value        = ALLTRIM(.this_cCPros)
            loc_oCnt.txt_4c_DPros.Value        = ALLTRIM(.this_cDPros)
            loc_oCnt.txt_4c_Linha.Value        = ALLTRIM(.this_cLin)
            loc_oCnt.txt_4c_DLin.Value         = ALLTRIM(.this_cDLin)
            loc_oCnt.txt_4c_Fornecedor.Value   = ALLTRIM(.this_cFornecedor)
            loc_oCnt.txt_4c_DFornecedor.Value  = ALLTRIM(.this_cDFornecedor)
            loc_oCnt.opt_4c_Imagem.Value       = IIF(.this_lImagem, 1, 2)
            loc_oCnt.opt_4c_Tipos.Value        = IIF(.this_nTipos >= 1 AND .this_nTipos <= 2, ;
                                                     .this_nTipos, 1)
            loc_oCnt.opt_4c_Diferencas.Value   = IIF(.this_nDiferenca >= 1 AND .this_nDiferenca <= 4, ;
                                                     .this_nDiferenca, 1)
        ENDWITH
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita todos os campos de filtro para edicao
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        loc_oCnt.txt_4c_DataIni.Enabled     = .T.
        loc_oCnt.txt_4c_DataFin.Enabled     = .T.
        loc_oCnt.txt_4c_Grupo.Enabled       = .T.
        loc_oCnt.txt_4c_DGrupo.Enabled      = .T.
        loc_oCnt.txt_4c_CPros.Enabled       = .T.
        loc_oCnt.txt_4c_DPros.Enabled       = .T.
        loc_oCnt.txt_4c_Linha.Enabled       = .T.
        loc_oCnt.txt_4c_DLin.Enabled        = .T.
        loc_oCnt.txt_4c_Fornecedor.Enabled  = .T.
        loc_oCnt.txt_4c_DFornecedor.Enabled = .T.
        loc_oCnt.opt_4c_Imagem.Enabled      = .T.
        loc_oCnt.opt_4c_Tipos.Enabled       = .T.
        loc_oCnt.opt_4c_Diferencas.Enabled  = .T.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel a form REPORT (sem modos CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reativa pagina de filtros e habilita campos
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.AlternarPagina(1)
        THIS.HabilitarCampos()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e recursos do form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreatoBO.prg):
*==============================================================================
* SIGREATOBO.PRG
* Business Object - Relatorio de Analise de Estoque Por Tipo de Operacao
*
* Herda de RelatorioBase
* Tabelas: SigMvHst (movimentos), SigCdOpe (operacoes), SigCdTom (tipos),
*          SigCdPro (produtos), SigCdGrp (grupos), SigCdCeg (contas estoque)
* Relatorios: SigReAto.frx (sem imagem) / SigReAtu.frx (com imagem)
*==============================================================================

DEFINE CLASS sigreatoBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial            = {}
    this_dDtFinal              = {}

    *-- Filtro de grupo (SigCdGrp - CGrus/DGrus, MaxLength=3)
    this_cGrupo                = ""
    this_cDGrupo               = ""

    *-- Filtro de produto (SigCdPro - CPros/DPros, MaxLength=14)
    this_cCPros                = ""
    this_cDPros                = ""

    *-- Filtro de linha (SigCdLin - Linhas/Descs, MaxLength=10)
    this_cLin                  = ""
    this_cDLin                 = ""

    *-- Filtro de fornecedor (MaxLength=10 codigo, MaxLength=40 descricao)
    this_cFornecedor           = ""
    this_cDFornecedor          = ""

    *-- Opcao de imagem: .T.=Com Imagem (optImagem.Value=1), .F.=Sem Imagem
    this_lImagem               = .F.

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico (optTipos)
    this_nTipos                = 1

    *-- Filtro de diferencas: 1=Ignorar, 2=Sem Diferenca, 3=Positiva, 4=Negativa
    this_nDiferenca            = 1

    *-- Mensagem de validacao de parametros (TrataErro do legado)
    this_cTrataErro            = ""

    *-- Cursor principal de saida do relatorio
    this_cCursorDados          = "crImpressao"

    *-- Nomes dos cursores de referencia carregados em InicializarDados
    this_cCursorOperacoesE     = "cursor_4c_OperacoesE"
    this_cCursorOperacoesS     = "cursor_4c_OperacoesS"
    this_cCursorSigCdCeg       = "cursor_4c_SigCdCeg"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao identicos ao legado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        THIS.this_nTipos     = 1
        THIS.this_nDiferenca = 1
        THIS.this_lImagem    = .F.
        THIS.this_cTrataErro = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(7), loc_nI
        loc_aCursors(1) = "cursor_4c_OperacoesE"
        loc_aCursors(2) = "cursor_4c_OperacoesS"
        loc_aCursors(3) = "cursor_4c_SigCdCeg"
        loc_aCursors(4) = "crImpressao"
        loc_aCursors(5) = "cursor_4c_Prods"
        loc_aCursors(6) = "cursor_4c_Entradas"
        loc_aCursors(7) = "cursor_4c_Saidas"
        FOR loc_nI = 1 TO 7
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursores de referencia usados pelo Form
    * Chamado no InicializarForm() do Formsigreato.
    * Cria:
    *   cursor_4c_OperacoesE : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=3 (entrada padrao)
    *   cursor_4c_OperacoesS : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=6 (saida padrao)
    *   cursor_4c_SigCdCeg   : lMarca L, Grupos C(10), Contas C(10)
    *     todos com lMarca=.F. (usuario marca quais incluir)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- 1. Tipos de operacao (SigCdTom) -> cursor_4c_OperacoesE e cursor_4c_OperacoesS
            IF USED("cursor_4c_TomTmp")
                USE IN cursor_4c_TomTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_TomTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Tipos de Opera" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OperacoesE")
                USE IN cursor_4c_OperacoesE
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
            INDEX ON Codigos TAG Codigos

            IF USED("cursor_4c_OperacoesS")
                USE IN cursor_4c_OperacoesS
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
            INDEX ON Codigos TAG Codigos

            SELECT cursor_4c_TomTmp
            GO TOP
            SCAN
                *-- Tipos=3 pre-selecionados em Entrada, Tipos=6 em Saida (padrao legado)
                INSERT INTO cursor_4c_OperacoesE (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 3, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
                INSERT INTO cursor_4c_OperacoesS (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 6, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
            ENDSCAN
            USE IN cursor_4c_TomTmp

            GO TOP IN cursor_4c_OperacoesE
            GO TOP IN cursor_4c_OperacoesS

            *-- 2. Contas de estoque (SigCdCeg) -> cursor_4c_SigCdCeg
            IF USED("cursor_4c_CegTmp")
                USE IN cursor_4c_CegTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos, Contas FROM SigCdCeg ORDER BY Grupos, Contas", ;
                "cursor_4c_CegTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Contas de Estoque (SigCdCeg)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigCdCeg")
                USE IN cursor_4c_SigCdCeg
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
            SET NULL OFF
            INDEX ON Grupos + Contas TAG GruContas

            SELECT cursor_4c_CegTmp
            GO TOP
            SCAN
                INSERT INTO cursor_4c_SigCdCeg (lMarca, Grupos, Contas) ;
                    VALUES (.F., ALLTRIM(cursor_4c_CegTmp.Grupos), ALLTRIM(cursor_4c_CegTmp.Contas))
            ENDSCAN
            USE IN cursor_4c_CegTmp

            SELECT cursor_4c_SigCdCeg
            SET ORDER TO TAG GruContas
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida entradas antes de PrepararDados
    * Preenche this_cTrataErro com identificador do erro (equivale ao
    * ValidaBotoes/loObj.TrataErro do legado).
    * Retorna .T. se OK, .F. se ha erro (mensagem em this_cTrataErro).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        THIS.this_cTrataErro = ""

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cTrataErro = "DataInicial"
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cTrataErro = "DataFinal"
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cTrataErro = "Final < Inicial"
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaTipos - Constroi string "(cod1,cod2,...)" de Codigos marcados
    * par_cCursor: nome do cursor (cursor_4c_OperacoesE ou cursor_4c_OperacoesS)
    * Retorna string IN ex: "(3,6)" ou "" se nenhum selecionado
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaTipos(par_cCursor)
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED(par_cCursor)
            RETURN ""
        ENDIF

        SELECT (par_cCursor)
        GO TOP
        SCAN
            IF SelImp
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             ALLTRIM(STR(Codigos, 2))
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaContas - Constroi string de contas marcadas em cursor_4c_SigCdCeg
    * Retorna string IN ex: "('GRP1ACC1','GRP2ACC2')" ou "" se nenhuma marcada
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaContas()
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED("cursor_4c_SigCdCeg")
            RETURN ""
        ENDIF

        SELECT cursor_4c_SigCdCeg
        GO TOP
        SCAN
            IF lMarca
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             "'" + ALLTRIM(Grupos) + ALLTRIM(Contas) + "'"
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo gerando cursor crImpressao
    *
    * Estrutura de crImpressao (por produto):
    *   Linha header (Ordem='0000000001'): dados do produto, Entradas, Saidas
    *   Linhas conta (Ordem='0000000002',...): Estos=Grupo+Conta, Estoques=saldo liq
    *   Linha total  (Estos='Total :   '): soma de Estoques, Diferencas
    *
    * Entradas = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in E-selecionados
    * Saidas   = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in S-selecionados
    * Estoques = saldo liquido por conta (SigMvHst: E+qtd, S-qtd) no periodo
    * Diferencas = Entradas - Saidas - SUM(Estoques por conta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cEmp, loc_cDtI, loc_cDtF
        LOCAL loc_cInCodE, loc_cInCodS, loc_cInContas
        LOCAL loc_nResult, loc_cSQL, loc_cWhere
        LOCAL loc_nEntradas, loc_nSaidas, loc_nTotalEst, loc_nDif
        LOCAL loc_nOrdem, loc_cCPros
        LOCAL loc_nEstCount, loc_nEstLine

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF !THIS.ValidarParametros()
                loc_lSucesso = .F.
            ENDIF

            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)

            *-- Montar listas de tipos selecionados
            loc_cInCodE = THIS.MontarListaTipos("cursor_4c_OperacoesE")
            IF EMPTY(loc_cInCodE)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Entrada Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInCodS = THIS.MontarListaTipos("cursor_4c_OperacoesS")
            IF EMPTY(loc_cInCodS)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Sa" + CHR(237) + "da Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInContas = THIS.MontarListaContas()

            *-- Recriar crImpressao
            IF USED("crImpressao")
                USE IN crImpressao
            ENDIF
            CREATE CURSOR crImpressao (CPros C(14), DPros C(40), Reffs C(15), ;
                CGrus C(3), Linhas C(10), IFors C(10), Ordem C(10), ;
                Estos C(30), Imagem M, Pvens N(14,2), Moevs C(3), ;
                Entradas N(14,3), Saidas N(14,3), Grupos C(30), ;
                Margems N(9,6), Estoques N(14,3), Diferencas N(14,3))

            *-- Limpar cursores temporarios de execucao anterior
            LOCAL loc_aTmp(4), loc_nT
            loc_aTmp(1) = "cursor_4c_Prods"
            loc_aTmp(2) = "cursor_4c_Entradas"
            loc_aTmp(3) = "cursor_4c_Saidas"
            loc_aTmp(4) = "cursor_4c_EstContas"
            FOR loc_nT = 1 TO 4
                IF USED(loc_aTmp(loc_nT))
                    USE IN (loc_aTmp(loc_nT))
                ENDIF
            ENDFOR

            *-- Query 1: Produtos com movimentos no periodo (E ou S selecionados)
            loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros, p.Reffs, p.CGrus, p.Linhas," + ;
                       " p.IFors, p.Pvens, p.Moevs, p.Margems," + ;
                       " ISNULL(g.DGrus,'') AS DGrus" + ;
                       " FROM SigCdPro p" + ;
                       " LEFT JOIN SigCdGrp g ON g.CGrus = p.CGrus" + ;
                       " WHERE p.CPros IN" + ;
                       " (SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " UNION" + ;
                       " SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ")"

            *-- Filtros adicionais de produto
            IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cLin))
                loc_cSQL = loc_cSQL + ;
                           " AND p.Linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
                loc_cSQL = loc_cSQL + ;
                           " AND p.IFors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY p.DPros, p.CPros"

            WAIT WINDOW "Selecionando produtos..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prods")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar produtos"
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: Total Entradas por produto (tipos E selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Entradas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular entradas"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Entradas")
                SELECT cursor_4c_Entradas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 3: Total Saidas por produto (tipos S selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Saidas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular sa" + CHR(237) + "das"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Saidas")
                SELECT cursor_4c_Saidas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 4: Saldo liquido por produto/conta no periodo
            loc_cSQL = "SELECT h.Cpros, h.Grupos, h.Estos," + ;
                       " SUM(IIF(h.Opers='E', h.Qtds, -h.Qtds)) AS Estoques" + ;
                       " FROM SigMvHst h" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

            IF !EMPTY(loc_cInContas)
                loc_cSQL = loc_cSQL + ;
                           " AND (RTRIM(h.Grupos) + RTRIM(h.Estos)) IN " + loc_cInContas
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY h.Cpros, h.Grupos, h.Estos" + ;
                                  " ORDER BY h.Cpros, h.Grupos, h.Estos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstContas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular saldo de estoques"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_EstContas")
                SELECT cursor_4c_EstContas
                INDEX ON Cpros TAG Cpros
                GO TOP
            ENDIF

            *-- Iterar produtos e montar crImpressao
            WAIT WINDOW "Processando relat" + CHR(243) + "rio..." NOWAIT

            SELECT cursor_4c_Prods
            GO TOP

            SCAN
                loc_cCPros = PADR(ALLTRIM(cursor_4c_Prods.CPros), 14)

                *-- Entradas deste produto
                loc_nEntradas = 0
                IF USED("cursor_4c_Entradas")
                    SELECT cursor_4c_Entradas
                    IF SEEK(loc_cCPros, "cursor_4c_Entradas", "Cpros")
                        loc_nEntradas = NVL(cursor_4c_Entradas.Total, 0)
                    ENDIF
                ENDIF

                *-- Saidas deste produto
                loc_nSaidas = 0
                IF USED("cursor_4c_Saidas")
                    SELECT cursor_4c_Saidas
                    IF SEEK(loc_cCPros, "cursor_4c_Saidas", "Cpros")
                        loc_nSaidas = NVL(cursor_4c_Saidas.Total, 0)
                    ENDIF
                ENDIF

                *-- Linhas de conta para este produto
                LOCAL loc_aEst(1,3)
                loc_nEstCount = 0
                loc_nTotalEst = 0

                IF USED("cursor_4c_EstContas")
                    SELECT cursor_4c_EstContas
                    LOCATE FOR Cpros = loc_cCPros
                    SCAN WHILE Cpros = loc_cCPros
                        loc_nEstCount = loc_nEstCount + 1
                        DIMENSION loc_aEst(loc_nEstCount, 3)
                        loc_aEst[loc_nEstCount, 1] = ALLTRIM(cursor_4c_EstContas.Grupos)
                        loc_aEst[loc_nEstCount, 2] = ALLTRIM(cursor_4c_EstContas.Estos)
                        loc_aEst[loc_nEstCount, 3] = NVL(cursor_4c_EstContas.Estoques, 0)
                        loc_nTotalEst = loc_nTotalEst + NVL(cursor_4c_EstContas.Estoques, 0)
                    ENDSCAN
                ENDIF

                *-- Diferenca = Entradas - Saidas - SomEstoques
                loc_nDif = loc_nEntradas - loc_nSaidas - loc_nTotalEst

                *-- Aplicar filtro optDiferencas
                DO CASE
                    CASE THIS.this_nDiferenca = 2
                        IF ABS(loc_nDif) > 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 3
                        IF loc_nDif <= 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 4
                        IF loc_nDif >= -0.001
                            LOOP
                        ENDIF
                ENDCASE

                *-- Linha header do produto (Ordem='0000000001')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, DPros, Reffs, CGrus, Linhas, IFors, ;
                    Ordem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems) ;
                    VALUES (loc_cCPros, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DPros), 40), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Reffs), 15), ;
                        PADR(ALLTRIM(cursor_4c_Prods.CGrus), 3), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Linhas), 10), ;
                        PADR(ALLTRIM(cursor_4c_Prods.IFors), 10), ;
                        "0000000001", ;
                        NVL(cursor_4c_Prods.Pvens, 0), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Moevs), 3), ;
                        loc_nEntradas, loc_nSaidas, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DGrus), 30), ;
                        NVL(cursor_4c_Prods.Margems, 0))

                *-- Linhas de conta (Ordem='0000000002', '0000000003', ...)
                loc_nOrdem = 2
                FOR loc_nEstLine = 1 TO loc_nEstCount
                    SELECT crImpressao
                    INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques) ;
                        VALUES (loc_cCPros, ;
                            PADL(ALLTRIM(STR(loc_nOrdem)), 10, "0"), ;
                            PADR(loc_aEst[loc_nEstLine,1] + " " + ;
                                 loc_aEst[loc_nEstLine,2], 30), ;
                            loc_aEst[loc_nEstLine,3])
                    loc_nOrdem = loc_nOrdem + 1
                ENDFOR

                *-- Linha total (Estos='Total :   ')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques, Diferencas) ;
                    VALUES (loc_cCPros, ;
                        "9999999999", ;
                        PADR("Total :   ", 30), ;
                        loc_nTotalEst, loc_nDif)

            ENDSCAN

            WAIT CLEAR

            SELECT crImpressao
            GO TOP

            loc_lSucesso = (RECCOUNT("crImpressao") > 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Nenhum dado encontrado para os filtros informados"
            ENDIF

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorExcel - Prepara cursor csExcell para exportacao
    * Analogo ao evento "documentoexcel" do legado.
    * Chama PrepararDados antes de montar o cursor de exportacao.
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorExcel()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED("csExcell")
                USE IN csExcell
            ENDIF

            IF THIS.this_nTipos = 1
                *-- Analitico: linha por produto/conta com IIF para suprimir valores nas linhas de conta
                SELECT IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CPros), ;
                           SPACE(14)) AS Codigo, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.DPros), ;
                           SPACE(40)) AS Descricao, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Reffs), ;
                           SPACE(15)) AS Referencia, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CGrus), ;
                           SPACE(3)) AS Grp, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Linhas), ;
                           SPACE(10)) AS Linha, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.IFors), ;
                           SPACE(10)) AS Fornecedor, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Margems, 0) AS Markup, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Entradas, 0) AS Entradas, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Saidas, 0) AS Saidas, ;
                       IIF(crImpressao.Ordem = "0000000001", ;
                           crImpressao.Entradas - crImpressao.Saidas, 0) AS Saldo, ;
                       ALLTRIM(crImpressao.Grupos) AS Grupos, ;
                       ALLTRIM(crImpressao.Estos) AS Contas, ;
                       crImpressao.Estoques AS Qtde, ;
                       IIF(ALLTRIM(crImpressao.Estos) = "Total :   ", crImpressao.Diferencas, ;
                           0) AS Diferencas ;
                  FROM crImpressao ;
                  INTO CURSOR csExcell READWRITE
            ELSE
                *-- Sintetico: apenas linha header por produto
                SELECT ALLTRIM(crImpressao.CPros) AS Codigo, ;
                       ALLTRIM(crImpressao.DPros) AS Descricao, ;
                       ALLTRIM(crImpressao.Reffs) AS Referencia, ;
                       ALLTRIM(crImpressao.CGrus) AS Grp, ;
                       ALLTRIM(crImpressao.Linhas) AS Linha, ;
                       ALLTRIM(crImpressao.IFors) AS Fornecedor, ;
                       crImpressao.Margems AS Markup, ;
                       crImpressao.Entradas AS Entradas, ;
                       crImpressao.Saidas AS Saidas, ;
                       crImpressao.Entradas - crImpressao.Saidas AS Saldo, ;
                       crImpressao.Estoques AS Qtde, ;
                       crImpressao.Diferencas AS Diferencas ;
                  FROM crImpressao ;
                 WHERE crImpressao.Estos = PADR("Total :   ", 30) ;
                  INTO CURSOR csExcell READWRITE
            ENDIF

            SELECT csExcell
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao montar cursor Excel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        LOCAL loc_cCursorSel1, loc_cCursorSel2

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                *-- Com imagem: monta Selecao intermediaria
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                loc_cFRX = gc_4c_CaminhoReports + "SigReAto"
                SELECT crImpressao
                GO TOP
            ENDIF

            REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                loc_cFRX = gc_4c_CaminhoReports + "SigReAto"
                SELECT crImpressao
                GO TOP
            ENDIF

            REPORT FORM (loc_cFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSelecaoComImagem - Prepara cursor Selecao para SigReAtu.frx
    * Equivale ao bloco "If (optImagem.Value=1)" dos eventos impressao/visualizacao
    * do legado. Usa crImpressao (deve estar populado por PrepararDados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSelecaoComImagem()
        LOCAL loc_oErro
        TRY
            IF USED("Selecao1")
                USE IN Selecao1
            ENDIF
            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            IF USED("Selecao")
                USE IN Selecao
            ENDIF

            SELECT CPros, DPros, Reffs, CGrus, Linhas, IFors, Ordem, Estos, ;
                   Imagem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems ;
              FROM crImpressao ;
             WHERE Ordem = "0000000001" ;
              INTO CURSOR Selecao1

            SELECT CPros, SUM(Estoques) AS Estoques ;
              FROM crImpressao ;
             WHERE ALLTRIM(Estos) = "Total :   " ;
             GROUP BY CPros ;
              INTO CURSOR Selecao2

            SELECT a.*, b.Estoques ;
              FROM Selecao1 a, Selecao2 b ;
             WHERE a.CPros = b.CPros ;
             ORDER BY a.CPros ;
              INTO CURSOR Selecao READWRITE

            SELECT Selecao
            GO TOP
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em MontarSelecaoComImagem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + "|" + ;
               ALLTRIM(THIS.this_cGrupo) + "|" + ALLTRIM(THIS.this_cCPros) + "|" + ;
               ALLTRIM(THIS.this_cLin) + "|" + ALLTRIM(THIS.this_cFornecedor) + "|" + ;
               STR(THIS.this_nTipos, 1) + "|" + STR(THIS.this_nDiferenca, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta cursor para planilha Excel (XL5)
    *   Usa PUTFILE para escolha interativa do arquivo destino.
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_cArquivo, loc_lSafetyEra
        loc_lResultado = .F.
        TRY
            IF THIS.MontarCursorExcel()
                loc_cArquivo = PUTFILE("Exportar para Excel", "AnEstTpOpe.xls", "xls")
                IF !EMPTY(loc_cArquivo)
                    IF LOWER(RIGHT(loc_cArquivo, 4)) != ".xls"
                        loc_cArquivo = loc_cArquivo + ".xls"
                    ENDIF
                    SELECT csExcell
                    loc_lSafetyEra = (SET("SAFETY") = "ON")
                    SET SAFETY OFF
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF loc_lSafetyEra
                        SET SAFETY ON
                    ENDIF
                    THIS.RegistrarAuditoria("EXCEL")
                    MsgInfo("Arquivo exportado com sucesso!", ;
                            "Informa" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao exportar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("csExcell")
            USE IN csExcell
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE


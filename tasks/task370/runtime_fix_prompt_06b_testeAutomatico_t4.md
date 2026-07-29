# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 4/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[28/07/2026 23:18:54] FormCLC.InicializarForm: BUTTONS is not an object.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-28 23:11:04] [INFO] Config FPW: (nao fornecido)
[2026-07-28 23:11:04] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:11:04] [INFO] Timeout: 300 segundos
[2026-07-28 23:11:04] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lkwrnvmz.prg
[2026-07-28 23:11:04] [INFO] Conteudo do wrapper:
[2026-07-28 23:11:04] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
QUIT

[2026-07-28 23:11:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lkwrnvmz.prg
[2026-07-28 23:11:04] [INFO] VFP output esperado em: C:\4c\tasks\task370\vfp_output.txt
[2026-07-28 23:11:04] [INFO] Executando Visual FoxPro 9...
[2026-07-28 23:11:04] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lkwrnvmz.prg
[2026-07-28 23:11:04] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lkwrnvmz.prg
[2026-07-28 23:11:04] [INFO] Timeout configurado: 300 segundos
[2026-07-28 23:11:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-28 23:11:44] [INFO] VFP9 finalizado em 39.8260859 segundos
[2026-07-28 23:11:44] [INFO] Exit Code: 
[2026-07-28 23:11:44] [INFO] 
[2026-07-28 23:11:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-28 23:11:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lkwrnvmz.prg
[2026-07-28 23:11:44] [INFO] 
[2026-07-28 23:11:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-28 23:11:44] [INFO] * Auto-generated wrapper for parameters
[2026-07-28 23:11:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:11:44] [INFO] * Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:11:44] [INFO] 
[2026-07-28 23:11:44] [INFO] * Anti-dialog protections for unattended execution
[2026-07-28 23:11:44] [INFO] SET SAFETY OFF
[2026-07-28 23:11:44] [INFO] SET RESOURCE OFF
[2026-07-28 23:11:44] [INFO] SET TALK OFF
[2026-07-28 23:11:44] [INFO] SET NOTIFY OFF
[2026-07-28 23:11:44] [INFO] SYS(2335, 0)
[2026-07-28 23:11:44] [INFO] 
[2026-07-28 23:11:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:11:44] [INFO] QUIT
[2026-07-28 23:11:44] [INFO] 
[2026-07-28 23:11:44] [INFO] === Fim do Wrapper.prg ===
[2026-07-28 23:11:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-28 23:13:27] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-28 23:13:27] [INFO] Config FPW: (nao fornecido)
[2026-07-28 23:13:27] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:13:27] [INFO] Timeout: 300 segundos
[2026-07-28 23:13:27] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juxtqrpt.prg
[2026-07-28 23:13:27] [INFO] Conteudo do wrapper:
[2026-07-28 23:13:27] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
QUIT

[2026-07-28 23:13:27] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juxtqrpt.prg
[2026-07-28 23:13:27] [INFO] VFP output esperado em: C:\4c\tasks\task370\vfp_output.txt
[2026-07-28 23:13:27] [INFO] Executando Visual FoxPro 9...
[2026-07-28 23:13:27] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juxtqrpt.prg
[2026-07-28 23:13:27] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juxtqrpt.prg
[2026-07-28 23:13:27] [INFO] Timeout configurado: 300 segundos
[2026-07-28 23:14:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-28 23:14:11] [INFO] VFP9 finalizado em 44.5298343 segundos
[2026-07-28 23:14:11] [INFO] Exit Code: 
[2026-07-28 23:14:11] [INFO] 
[2026-07-28 23:14:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-28 23:14:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juxtqrpt.prg
[2026-07-28 23:14:11] [INFO] 
[2026-07-28 23:14:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-28 23:14:11] [INFO] * Auto-generated wrapper for parameters
[2026-07-28 23:14:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:14:11] [INFO] * Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:14:11] [INFO] 
[2026-07-28 23:14:11] [INFO] * Anti-dialog protections for unattended execution
[2026-07-28 23:14:11] [INFO] SET SAFETY OFF
[2026-07-28 23:14:11] [INFO] SET RESOURCE OFF
[2026-07-28 23:14:11] [INFO] SET TALK OFF
[2026-07-28 23:14:11] [INFO] SET NOTIFY OFF
[2026-07-28 23:14:11] [INFO] SYS(2335, 0)
[2026-07-28 23:14:11] [INFO] 
[2026-07-28 23:14:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:14:11] [INFO] QUIT
[2026-07-28 23:14:11] [INFO] 
[2026-07-28 23:14:11] [INFO] === Fim do Wrapper.prg ===
[2026-07-28 23:14:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-28 23:15:24] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-28 23:15:24] [INFO] Config FPW: (nao fornecido)
[2026-07-28 23:15:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:15:24] [INFO] Timeout: 300 segundos
[2026-07-28 23:15:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rpkz3hdk.prg
[2026-07-28 23:15:24] [INFO] Conteudo do wrapper:
[2026-07-28 23:15:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
QUIT

[2026-07-28 23:15:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rpkz3hdk.prg
[2026-07-28 23:15:24] [INFO] VFP output esperado em: C:\4c\tasks\task370\vfp_output.txt
[2026-07-28 23:15:24] [INFO] Executando Visual FoxPro 9...
[2026-07-28 23:15:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rpkz3hdk.prg
[2026-07-28 23:15:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rpkz3hdk.prg
[2026-07-28 23:15:24] [INFO] Timeout configurado: 300 segundos
[2026-07-28 23:16:10] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-28 23:16:10] [INFO] VFP9 finalizado em 45.2070843 segundos
[2026-07-28 23:16:10] [INFO] Exit Code: 
[2026-07-28 23:16:10] [INFO] 
[2026-07-28 23:16:10] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-28 23:16:10] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rpkz3hdk.prg
[2026-07-28 23:16:10] [INFO] 
[2026-07-28 23:16:10] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-28 23:16:10] [INFO] * Auto-generated wrapper for parameters
[2026-07-28 23:16:10] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:16:10] [INFO] * Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:16:10] [INFO] 
[2026-07-28 23:16:10] [INFO] * Anti-dialog protections for unattended execution
[2026-07-28 23:16:10] [INFO] SET SAFETY OFF
[2026-07-28 23:16:10] [INFO] SET RESOURCE OFF
[2026-07-28 23:16:10] [INFO] SET TALK OFF
[2026-07-28 23:16:10] [INFO] SET NOTIFY OFF
[2026-07-28 23:16:10] [INFO] SYS(2335, 0)
[2026-07-28 23:16:10] [INFO] 
[2026-07-28 23:16:10] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:16:10] [INFO] QUIT
[2026-07-28 23:16:10] [INFO] 
[2026-07-28 23:16:10] [INFO] === Fim do Wrapper.prg ===
[2026-07-28 23:16:10] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-28 23:18:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-28 23:18:10] [INFO] Config FPW: (nao fornecido)
[2026-07-28 23:18:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:18:10] [INFO] Timeout: 300 segundos
[2026-07-28 23:18:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4wzvhdze.prg
[2026-07-28 23:18:10] [INFO] Conteudo do wrapper:
[2026-07-28 23:18:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
QUIT

[2026-07-28 23:18:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4wzvhdze.prg
[2026-07-28 23:18:10] [INFO] VFP output esperado em: C:\4c\tasks\task370\vfp_output.txt
[2026-07-28 23:18:10] [INFO] Executando Visual FoxPro 9...
[2026-07-28 23:18:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4wzvhdze.prg
[2026-07-28 23:18:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4wzvhdze.prg
[2026-07-28 23:18:10] [INFO] Timeout configurado: 300 segundos
[2026-07-28 23:18:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-28 23:18:54] [INFO] VFP9 finalizado em 44.4058535 segundos
[2026-07-28 23:18:54] [INFO] Exit Code: 
[2026-07-28 23:18:54] [INFO] 
[2026-07-28 23:18:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-28 23:18:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4wzvhdze.prg
[2026-07-28 23:18:54] [INFO] 
[2026-07-28 23:18:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-28 23:18:54] [INFO] * Auto-generated wrapper for parameters
[2026-07-28 23:18:54] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-28 23:18:54] [INFO] * Parameters: 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:18:54] [INFO] 
[2026-07-28 23:18:54] [INFO] * Anti-dialog protections for unattended execution
[2026-07-28 23:18:54] [INFO] SET SAFETY OFF
[2026-07-28 23:18:54] [INFO] SET RESOURCE OFF
[2026-07-28 23:18:54] [INFO] SET TALK OFF
[2026-07-28 23:18:54] [INFO] SET NOTIFY OFF
[2026-07-28 23:18:54] [INFO] SYS(2335, 0)
[2026-07-28 23:18:54] [INFO] 
[2026-07-28 23:18:54] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCLC', 'C:\4c\tasks\task370', 'CRUD'
[2026-07-28 23:18:54] [INFO] QUIT
[2026-07-28 23:18:54] [INFO] 
[2026-07-28 23:18:54] [INFO] === Fim do Wrapper.prg ===
[2026-07-28 23:18:54] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCLC",
  "timestamp": "20260728231854",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCLC.prg):
*===============================================================================
* FormCLC.prg - Formulario de Cadastro de Comparativos Entre Locais (SIGCDCLC)
*
* Tabela principal: SigLcLo (PK: Codigos)
* Sub-tabelas: SigLcLoI (operacoes por local), SigLcLoE (estoques avaliados)
* Tipo: CRUD (frmcadastro)
* BO: CLCBO
*
* FASE 3/8: Estrutura base - PageFrame + containers principais [OK]
* FASE 4/8: Grid Lista + botoes CRUD na Page1 [OK]
* FASE 5/8: cntCodigos + cntLocalA + cntLocalB na Page2 [OK]
* FASE 6/8: pgComplementos (pgOpeGerA + pgEstoques) na Page2 [OK]
* FASE 7/8: Eventos CRUD principais + BINDEVENTs + lookups [OK]
* FASE 8/8: Validacoes e metodos de dados completos [OK]
* FASE 9/9: BINDEVENTs Check1 KeyPress/MouseDown + ReadOnly colunas Estoque A/B [OK]
*===============================================================================

DEFINE CLASS FormCLC AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Comparativos Entre Locais"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_lEstoqueBound   = .F.
    this_lOpeBound       = .F.

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCLC.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CLCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar CLCBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCLC.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho + containers base
    * FASE 3: Cabecalho + Saida
    * FASE 4: Botoes CRUD + Grid Lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza escuro
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico: Left=542, Width=390)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid Lista (Top=117 = 88+29 compensacao PageFrame)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        IF !USED("cursor_4c_Dados")
            CREATE CURSOR cursor_4c_Dados (Codigos C(20), Emps C(3), LocalA C(20), LocalB C(20))
        ENDIF
        loc_oPg1.grd_4c_Lista.ColumnCount = 3
        loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
        loc_oPg1.grd_4c_Lista.ColumnCount  = 4
        WITH loc_oPg1.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 940
            .Height             = 500
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
            .Column1.ControlSource = "cursor_4c_Dados.Codigos"
            .Column2.ControlSource = "cursor_4c_Dados.Emps"
            .Column3.ControlSource = "cursor_4c_Dados.LocalA"
            .Column4.ControlSource = "cursor_4c_Dados.LocalB"
            .Column1.Width = 150
            .Column2.Width = 70
            .Column3.Width = 150
            .Column4.Width = 150
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Emp"
            .Column3.Header1.Caption = "Local"
            .Column4.Header1.Caption = "Local"
        ENDWITH

        BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "GridListaDblClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes acao + containers de dados
    * FASE 3: BotoesAcao (Confirmar + Cancelar)
    * FASE 5: cntCodigos + cntLocalA + cntLocalB
    * FASE 6: pgComplementos (pgOpeGerA + pgEstoques)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao, loc_oCnt
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Botoes Confirmar/Cancelar (canonico: Left=842, Width=160)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *==========================================================================
        *-- FASE 5: cnt_4c_Codigos (top=138, left=25, width=740, height=59)
        *==========================================================================
        loc_oPg2.AddObject("cnt_4c_Codigos", "Container")
        loc_oCnt = loc_oPg2.cnt_4c_Codigos
        WITH loc_oCnt
            .Top         = 138
            .Left        = 25
            .Width       = 740
            .Height      = 59
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblCodigo", "Label")
        WITH loc_oCnt.lbl_4c_LblCodigo
            .AutoSize  = .F.
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 9
            .Left      = 32
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oCnt.txt_4c_Codigos
            .Top       = 6
            .Left      = 84
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oCnt.lbl_4c_LblEmpresa
            .AutoSize  = .F.
            .Caption   = "Empresa :"
            .Top       = 9
            .Left      = 264
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Empresas", "TextBox")
        WITH loc_oCnt.txt_4c_Empresas
            .Top       = 6
            .Left      = 326
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_EmpContas", "CheckBox")
        WITH loc_oCnt.chk_4c_EmpContas
            .Caption  = ""
            .Top      = 10
            .Left     = 364
            .Width    = 19
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSubstContas", "Label")
        WITH loc_oCnt.lbl_4c_LblSubstContas
            .AutoSize  = .F.
            .Caption   = "Substituir Contas"
            .Top       = 11
            .Left      = 381
            .Width     = 95
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDigitos", "Label")
        WITH loc_oCnt.lbl_4c_LblDigitos
            .AutoSize  = .F.
            .Caption   = "D" + CHR(237) + "gitos / Grupo :"
            .Top       = 10
            .Left      = 546
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_OptDigitos", "OptionGroup")
        WITH loc_oCnt.obj_4c_OptDigitos
            .ButtonCount = 3
            .Top         = 6
            .Left        = 642
            .Width       = 97
            .Height      = 22
            .Value       = 1
            .BackStyle   = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "1"
                .Top      = 2
                .Left     = 1
                .Width    = 30
                .Height   = 18
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "2"
                .Top      = 2
                .Left     = 32
                .Width    = 30
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "3"
                .Top      = 2
                .Left     = 63
                .Width    = 30
                .Height   = 18
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblAuto", "Label")
        WITH loc_oCnt.lbl_4c_LblAuto
            .AutoSize  = .F.
            .Caption   = "Autom" + CHR(225) + "tico :"
            .Top       = 35
            .Left      = 8
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Autos", "CheckBox")
        WITH loc_oCnt.chk_4c_Autos
            .Caption  = ""
            .Top      = 35
            .Left     = 84
            .Width    = 19
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblProcessamento", "Label")
        WITH loc_oCnt.lbl_4c_LblProcessamento
            .AutoSize  = .F.
            .Caption   = "(Processamento)"
            .Top       = 35
            .Left      = 104
            .Width     = 95
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTransitoria", "Label")
        WITH loc_oCnt.lbl_4c_LblTransitoria
            .AutoSize  = .F.
            .Caption   = "Transit" + CHR(243) + "ria :"
            .Top       = 34
            .Left      = 253
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Transitoria", "TextBox")
        WITH loc_oCnt.txt_4c_Transitoria
            .Top       = 31
            .Left      = 326
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblToleras", "Label")
        WITH loc_oCnt.lbl_4c_LblToleras
            .AutoSize  = .F.
            .Caption   = "Toler" + CHR(226) + "ncia AU :"
            .Top       = 34
            .Left      = 401
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Toleras", "TextBox")
        WITH loc_oCnt.txt_4c_Toleras
            .Top       = 30
            .Left      = 491
            .Width     = 55
            .Height    = 25
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblPercents", "Label")
        WITH loc_oCnt.lbl_4c_LblPercents
            .AutoSize  = .F.
            .Caption   = "Percentual :"
            .Top       = 34
            .Left      = 599
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Percents", "TextBox")
        WITH loc_oCnt.txt_4c_Percents
            .Top       = 30
            .Left      = 672
            .Width     = 59
            .Height    = 25
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *==========================================================================
        *-- FASE 5: cnt_4c_LocalA (top=201, left=25, width=368, height=133)
        *==========================================================================
        loc_oPg2.AddObject("cnt_4c_LocalA", "Container")
        loc_oCnt = loc_oPg2.cnt_4c_LocalA
        WITH loc_oCnt
            .Top         = 201
            .Left        = 25
            .Width       = 368
            .Height      = 133
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TituloA", "Label")
        WITH loc_oCnt.lbl_4c_TituloA
            .AutoSize  = .F.
            .Caption   = " Local " + CHR(34) + "A" + CHR(34)
            .Top       = 4
            .Left      = 3
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_PalmA", "CheckBox")
        WITH loc_oCnt.chk_4c_PalmA
            .Caption  = "Checar Venda Palm"
            .Top      = 4
            .Left     = 153
            .Width    = 120
            .Height   = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_EtiquetaA", "CheckBox")
        WITH loc_oCnt.chk_4c_EtiquetaA
            .Caption  = "Etiquetas"
            .Top      = 3
            .Left     = 290
            .Width    = 75
            .Height   = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblLocalA", "Label")
        WITH loc_oCnt.lbl_4c_LblLocalA
            .AutoSize  = .F.
            .Caption   = "Local :"
            .Top       = 28
            .Left      = 26
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_LocalA", "TextBox")
        WITH loc_oCnt.txt_4c_LocalA
            .Top       = 25
            .Left      = 66
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEstoqueA", "Label")
        WITH loc_oCnt.lbl_4c_LblEstoqueA
            .AutoSize  = .F.
            .Caption   = "Estoque :"
            .Top       = 28
            .Left      = 150
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DataA", "TextBox")
        WITH loc_oCnt.txt_4c_DataA
            .Top       = 24
            .Left      = 205
            .Width     = 80
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99/99/9999"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDivisaoA", "Label")
        WITH loc_oCnt.lbl_4c_LblDivisaoA
            .AutoSize  = .F.
            .Caption   = "Divis" + CHR(227) + "o :"
            .Top       = 28
            .Left      = 285
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DivisaosA", "TextBox")
        WITH loc_oCnt.txt_4c_DivisaosA
            .Top       = 25
            .Left      = 337
            .Width     = 24
            .Height    = 23
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblGrupoA", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupoA
            .AutoSize  = .F.
            .Caption   = "Grupo :"
            .Top       = 53
            .Left      = 22
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GrupoA", "TextBox")
        WITH loc_oCnt.txt_4c_GrupoA
            .Top       = 50
            .Left      = 66
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DGrupoA", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupoA
            .Top       = 50
            .Left      = 148
            .Width     = 213
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblContaA", "Label")
        WITH loc_oCnt.lbl_4c_LblContaA
            .AutoSize  = .F.
            .Caption   = "Conta :"
            .Top       = 78
            .Left      = 23
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_ContaA", "TextBox")
        WITH loc_oCnt.txt_4c_ContaA
            .Top       = 75
            .Left      = 66
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DContaA", "TextBox")
        WITH loc_oCnt.txt_4c_DContaA
            .Top       = 75
            .Left      = 148
            .Width     = 213
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblOperacaoA", "Label")
        WITH loc_oCnt.lbl_4c_LblOperacaoA
            .AutoSize  = .F.
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 104
            .Left      = 2
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_OperacaoA", "TextBox")
        WITH loc_oCnt.txt_4c_OperacaoA
            .Top       = 100
            .Left      = 66
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblGdeGrupoA", "Label")
        WITH loc_oCnt.lbl_4c_LblGdeGrupoA
            .AutoSize  = .F.
            .Caption   = "Grande Grupo :"
            .Top       = 104
            .Left      = 236
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GdeGrupoA", "TextBox")
        WITH loc_oCnt.txt_4c_GdeGrupoA
            .Top       = 100
            .Left      = 329
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *==========================================================================
        *-- FASE 5: cnt_4c_LocalB (top=201, left=397, width=368, height=133)
        *==========================================================================
        loc_oPg2.AddObject("cnt_4c_LocalB", "Container")
        loc_oCnt = loc_oPg2.cnt_4c_LocalB
        WITH loc_oCnt
            .Top         = 201
            .Left        = 397
            .Width       = 368
            .Height      = 133
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TituloB", "Label")
        WITH loc_oCnt.lbl_4c_TituloB
            .AutoSize  = .F.
            .Caption   = " Local " + CHR(34) + "B" + CHR(34)
            .Top       = 4
            .Left      = 3
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_PalmB", "CheckBox")
        WITH loc_oCnt.chk_4c_PalmB
            .Caption  = "Checar Venda Palm"
            .Top      = 5
            .Left     = 153
            .Width    = 120
            .Height   = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_EtiquetaB", "CheckBox")
        WITH loc_oCnt.chk_4c_EtiquetaB
            .Caption  = "Etiquetas"
            .Top      = 4
            .Left     = 290
            .Width    = 75
            .Height   = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblLocalB", "Label")
        WITH loc_oCnt.lbl_4c_LblLocalB
            .AutoSize  = .F.
            .Caption   = "Local :"
            .Top       = 29
            .Left      = 26
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_LocalB", "TextBox")
        WITH loc_oCnt.txt_4c_LocalB
            .Top       = 26
            .Left      = 66
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEstoqueB", "Label")
        WITH loc_oCnt.lbl_4c_LblEstoqueB
            .AutoSize  = .F.
            .Caption   = "Estoque :"
            .Top       = 28
            .Left      = 150
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DataB", "TextBox")
        WITH loc_oCnt.txt_4c_DataB
            .Top       = 24
            .Left      = 205
            .Width     = 80
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99/99/9999"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDivisaoB", "Label")
        WITH loc_oCnt.lbl_4c_LblDivisaoB
            .AutoSize  = .F.
            .Caption   = "Divis" + CHR(227) + "o :"
            .Top       = 28
            .Left      = 286
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DivisaosB", "TextBox")
        WITH loc_oCnt.txt_4c_DivisaosB
            .Top       = 25
            .Left      = 337
            .Width     = 24
            .Height    = 23
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblGrupoB", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupoB
            .AutoSize  = .F.
            .Caption   = "Grupo :"
            .Top       = 54
            .Left      = 22
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GrupoB", "TextBox")
        WITH loc_oCnt.txt_4c_GrupoB
            .Top       = 51
            .Left      = 66
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DGrupoB", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupoB
            .Top       = 51
            .Left      = 148
            .Width     = 213
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblContaB", "Label")
        WITH loc_oCnt.lbl_4c_LblContaB
            .AutoSize  = .F.
            .Caption   = "Conta :"
            .Top       = 79
            .Left      = 23
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_ContaB", "TextBox")
        WITH loc_oCnt.txt_4c_ContaB
            .Top       = 76
            .Left      = 66
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DContaB", "TextBox")
        WITH loc_oCnt.txt_4c_DContaB
            .Top       = 76
            .Left      = 148
            .Width     = 213
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblOperacaoB", "Label")
        WITH loc_oCnt.lbl_4c_LblOperacaoB
            .AutoSize  = .F.
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 105
            .Left      = 2
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_OperacaoB", "TextBox")
        WITH loc_oCnt.txt_4c_OperacaoB
            .Top       = 101
            .Left      = 66
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblGdeGrupoB", "Label")
        WITH loc_oCnt.lbl_4c_LblGdeGrupoB
            .AutoSize  = .F.
            .Caption   = "Grande Grupo :"
            .Top       = 104
            .Left      = 239
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GdeGrupoB", "TextBox")
        WITH loc_oCnt.txt_4c_GdeGrupoB
            .Top       = 101
            .Left      = 330
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs para lookups em campos de texto (F4)
        BINDEVENT(loc_oPg2.cnt_4c_Codigos.txt_4c_Empresas,    "KeyPress", THIS, "EmpresasKeyPress")
        BINDEVENT(loc_oPg2.cnt_4c_Codigos.txt_4c_Transitoria,  "KeyPress", THIS, "TransitoriaKeyPress")
        BINDEVENT(loc_oPg2.cnt_4c_LocalA.txt_4c_LocalA,        "KeyPress", THIS, "LocalAKeyPress")
        BINDEVENT(loc_oPg2.cnt_4c_LocalB.txt_4c_LocalB,        "KeyPress", THIS, "LocalBKeyPress")

        *-- PageFrame Complementos (Operacoes Gerenciais + Estoques)
        THIS.ConfigurarComplementos(loc_oPg2)

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarComplementos - PageFrame interno em Page2 com Operacoes e Estoques
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarComplementos(par_oPg2)
        LOCAL loc_oPgf, loc_oPg1C, loc_oPg2C, loc_oCmg, loc_oGrid

        THIS.CriarCursoresOperacoesVazios()

        par_oPg2.AddObject("pgf_4c_Complementos", "PageFrame")
        loc_oPgf = par_oPg2.pgf_4c_Complementos
        WITH loc_oPgf
            .Top       = 337
            .Left      = 23
            .Width     = 743
            .Height    = 230
            .PageCount = 2
            .Tabs      = .T.
            .Visible   = .T.
            .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es Gerenciais"
            .Page1.BackColor = RGB(240, 240, 240)
            .Page2.Caption   = "Estoques"
            .Page2.BackColor = RGB(240, 240, 240)
        ENDWITH

        loc_oPg1C = loc_oPgf.Page1
        loc_oPg2C = loc_oPgf.Page2

        *-- Page1: Grid de Operacoes Gerenciais (grdOpeGerA - 8 colunas)
        loc_oPg1C.AddObject("grd_4c_OpeGerA", "Grid")
        loc_oPg1C.grd_4c_OpeGerA.ColumnCount = 3
        loc_oPg1C.grd_4c_OpeGerA.RecordSource = "cursor_4c_Operacoes"
        loc_oPg1C.grd_4c_OpeGerA.ColumnCount  = 8
        WITH loc_oPg1C.grd_4c_OpeGerA
            .Top                = 10
            .Left               = 8
            .Width              = 723
            .Height             = 122
            .FontName           = "Verdana"
            .FontSize           = 8
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 3
            .GridLines          = 3
            .Visible            = .T.
            .Column1.ControlSource = "cursor_4c_Operacoes.Emps"
            .Column2.ControlSource = "cursor_4c_Operacoes.Cods"
            .Column3.ControlSource = "cursor_4c_Operacoes.Operacoes"
            .Column4.ControlSource = "cursor_4c_Operacoes.GrupoOs"
            .Column5.ControlSource = "cursor_4c_Operacoes.ContaOs"
            .Column6.ControlSource = "cursor_4c_Operacoes.GrupoDs"
            .Column7.ControlSource = "cursor_4c_Operacoes.ContaDs"
            .Column8.ControlSource = "cursor_4c_Operacoes.Agrupar"
            .Column1.Width = 35
            .Column2.Width = 80
            .Column3.Width = 80
            .Column4.Width = 90
            .Column5.Width = 100
            .Column6.Width = 90
            .Column7.Width = 100
            .Column8.Width = 28
            .Column1.Header1.Caption = "Emp"
            .Column2.Header1.Caption = "Local"
            .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Caption = "Grupo Origem"
            .Column5.Header1.Caption = "Conta Origem"
            .Column6.Header1.Caption = "Grupo Destino"
            .Column7.Header1.Caption = "Conta Destino"
            .Column8.Header1.Caption = "A"
            .Column8.Sparse   = .F.
            .Column8.ReadOnly = .F.
        ENDWITH

        *-- OptionGroup optEnvRecs (direcao de movimentacao A->B ou B->A)
        loc_oPg1C.AddObject("opt_4c_EnvRecs", "OptionGroup")
        WITH loc_oPg1C.opt_4c_EnvRecs
            .ButtonCount = 2
            .Top         = 139
            .Left        = 377
            .Width       = 134
            .Height      = 24
            .Value       = 1
            .BackStyle   = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "A -> B"
                .BackStyle = 0
                .Top       = 4
                .Left      = 5
                .Width     = 58
                .Height    = 16
                .Themes    = .F.
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "B -> A"
                .BackStyle = 0
                .Top       = 4
                .Left      = 66
                .Width     = 58
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Themes    = .F.
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPg1C.opt_4c_EnvRecs, "InteractiveChange", THIS, "EnvRecsInteractiveChange")

        *-- Label "Movimentacao Entre Locais :"
        loc_oPg1C.AddObject("lbl_4c_MovEntreLocais", "Label")
        WITH loc_oPg1C.lbl_4c_MovEntreLocais
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Entre Locais :"
            .AutoSize  = .F.
            .Top       = 141
            .Left      = 187
            .Width     = 185
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- CommandGroup Incluir/Excluir linha
        loc_oPg1C.AddObject("cmdg_4c_Compo", "CommandGroup")
        loc_oCmg = loc_oPg1C.cmdg_4c_Compo
        WITH loc_oCmg
            .Top       = 141
            .Left      = 8
            .Width     = 170
            .Height    = 56
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
            WITH .Buttons(1)
                .Caption   = "Incluir Linha"
                .Top       = 2
                .Left      = 2
                .Width     = 80
                .Height    = 26
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 255)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Excluir Linha"
                .Top       = 28
                .Left      = 2
                .Width     = 80
                .Height    = 26
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 255)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnAdicionarLinhaClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnExcluirLinhaClick")
        BINDEVENT(loc_oPg1C.grd_4c_OpeGerA, "AfterRowColChange", THIS, "OpeGerAAfterRowColChange")

        *-- Page2: Estoques - Label e Grid Local A
        loc_oPg2C.AddObject("lbl_4c_TitLocalAEst", "Label")
        WITH loc_oPg2C.lbl_4c_TitLocalAEst
            .Caption   = " Local " + CHR(34) + "A" + CHR(34)
            .AutoSize  = .F.
            .Top       = 2
            .Left      = 106
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2C.AddObject("grd_4c_EstoqueA", "Grid")
        loc_oPg2C.grd_4c_EstoqueA.ColumnCount = 3
        loc_oPg2C.grd_4c_EstoqueA.RecordSource = "cursor_4c_EstoqueA"
        loc_oPg2C.grd_4c_EstoqueA.ColumnCount  = 4
        WITH loc_oPg2C.grd_4c_EstoqueA
            .Top                = 18
            .Left               = 108
            .Width              = 252
            .Height             = 122
            .FontName           = "Verdana"
            .FontSize           = 8
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 3
            .GridLines          = 3
            .Visible            = .T.
            .Column1.ControlSource = "cursor_4c_EstoqueA.Marca"
            .Column2.ControlSource = "cursor_4c_EstoqueA.Emps"
            .Column3.ControlSource = "cursor_4c_EstoqueA.Grupos"
            .Column4.ControlSource = "cursor_4c_EstoqueA.Contas"
            .Column1.Width = 22
            .Column2.Width = 35
            .Column3.Width = 90
            .Column4.Width = 95
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Emp"
            .Column3.Header1.Caption = "Grupo"
            .Column4.Header1.Caption = "Conta"
            .Column1.Sparse   = .F.
            .Column1.ReadOnly = .F.
            .Column2.ReadOnly = .T.
            .Column3.ReadOnly = .T.
            .Column4.ReadOnly = .T.
        ENDWITH

        loc_oPg2C.AddObject("cmdg_4c_EstoqueA", "CommandGroup")
        loc_oCmg = loc_oPg2C.cmdg_4c_EstoqueA
        WITH loc_oCmg
            .Top       = 142
            .Left      = 108
            .Width     = 90
            .Height    = 33
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
            WITH .Buttons(1)
                .Caption   = "Marcar"
                .Top       = 2
                .Left      = 2
                .Width     = 42
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackColor = RGB(255, 255, 255)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Desmarcar"
                .Top       = 16
                .Left      = 2
                .Width     = 42
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackColor = RGB(255, 255, 255)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnMarcarTodosAClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnDesmarcarTodosAClick")

        *-- Page2: Label e Grid Local B
        loc_oPg2C.AddObject("lbl_4c_TitLocalBEst", "Label")
        WITH loc_oPg2C.lbl_4c_TitLocalBEst
            .Caption   = " Local " + CHR(34) + "B" + CHR(34)
            .AutoSize  = .F.
            .Top       = 2
            .Left      = 378
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2C.AddObject("grd_4c_EstoqueB", "Grid")
        loc_oPg2C.grd_4c_EstoqueB.ColumnCount = 3
        loc_oPg2C.grd_4c_EstoqueB.RecordSource = "cursor_4c_EstoqueB"
        loc_oPg2C.grd_4c_EstoqueB.ColumnCount  = 4
        WITH loc_oPg2C.grd_4c_EstoqueB
            .Top                = 18
            .Left               = 380
            .Width              = 252
            .Height             = 122
            .FontName           = "Verdana"
            .FontSize           = 8
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 3
            .GridLines          = 3
            .Visible            = .T.
            .Column1.ControlSource = "cursor_4c_EstoqueB.Marca"
            .Column2.ControlSource = "cursor_4c_EstoqueB.Emps"
            .Column3.ControlSource = "cursor_4c_EstoqueB.Grupos"
            .Column4.ControlSource = "cursor_4c_EstoqueB.Contas"
            .Column1.Width = 22
            .Column2.Width = 35
            .Column3.Width = 90
            .Column4.Width = 95
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Emp"
            .Column3.Header1.Caption = "Grupo"
            .Column4.Header1.Caption = "Conta"
            .Column1.Sparse   = .F.
            .Column1.ReadOnly = .F.
            .Column2.ReadOnly = .T.
            .Column3.ReadOnly = .T.
            .Column4.ReadOnly = .T.
        ENDWITH

        loc_oPg2C.AddObject("cmdg_4c_EstoqueB", "CommandGroup")
        loc_oCmg = loc_oPg2C.cmdg_4c_EstoqueB
        WITH loc_oCmg
            .Top       = 142
            .Left      = 380
            .Width     = 90
            .Height    = 33
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
            WITH .Buttons(1)
                .Caption   = "Marcar"
                .Top       = 2
                .Left      = 2
                .Width     = 42
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackColor = RGB(255, 255, 255)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Desmarcar"
                .Top       = 16
                .Left      = 2
                .Width     = 42
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackColor = RGB(255, 255, 255)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnMarcarTodosBClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnDesmarcarTodosBClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresOperacoesVazios - Cursores placeholder com tipos corretos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresOperacoesVazios()
        SET NULL ON

        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF
        CREATE CURSOR cursor_4c_Operacoes (cIdChaves C(36), Codigos C(20), ;
            Emps C(3), Cods C(20), Operacoes C(20), ;
            GrupoOs C(40), ContaOs C(40), ;
            GrupoDs C(40), ContaDs C(40), Agrupar L, EnvRecs C(1))

        IF USED("cursor_4c_EstoqueA")
            USE IN cursor_4c_EstoqueA
        ENDIF
        CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
            Emps C(3), Grupos C(40), Contas C(40), Marca L)

        IF USED("cursor_4c_EstoqueB")
            USE IN cursor_4c_EstoqueB
        ENDIF
        CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
            Emps C(3), Grupos C(40), Contas C(40), Marca L)

        SET NULL OFF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGridOperacoes - Carrega grd_4c_OpeGerA com dados de SigLcLoI
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGridOperacoes(par_cCodigos)
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)

            IF !loc_lSucesso OR !USED("cursor_4c_Operacoes")
                THIS.CriarCursoresOperacoesVazios()
                loc_lSucesso = .T.
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
            loc_oGrid.RecordSource = ""
            loc_oGrid.ColumnCount = 8
            loc_oGrid.RecordSource = "cursor_4c_Operacoes"
            loc_oGrid.ColumnCount  = 8

            loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Emps"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Operacoes.Cods"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Operacoes.Operacoes"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Operacoes.GrupoOs"
            loc_oGrid.Column5.ControlSource = "cursor_4c_Operacoes.ContaOs"
            loc_oGrid.Column6.ControlSource = "cursor_4c_Operacoes.GrupoDs"
            loc_oGrid.Column7.ControlSource = "cursor_4c_Operacoes.ContaDs"
            loc_oGrid.Column8.ControlSource = "cursor_4c_Operacoes.Agrupar"

            loc_oGrid.Column1.Width = 35
            loc_oGrid.Column2.Width = 80
            loc_oGrid.Column3.Width = 80
            loc_oGrid.Column4.Width = 90
            loc_oGrid.Column5.Width = 100
            loc_oGrid.Column6.Width = 90
            loc_oGrid.Column7.Width = 100
            loc_oGrid.Column8.Width = 28

            loc_oGrid.Column1.Header1.Caption = "Emp"
            loc_oGrid.Column2.Header1.Caption = "Local"
            loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column4.Header1.Caption = "Grupo Origem"
            loc_oGrid.Column5.Header1.Caption = "Conta Origem"
            loc_oGrid.Column6.Header1.Caption = "Grupo Destino"
            loc_oGrid.Column7.Header1.Caption = "Conta Destino"
            loc_oGrid.Column8.Header1.Caption = "A"

            loc_oGrid.Column8.Sparse   = .F.
            loc_oGrid.Column8.ReadOnly = .F.
            IF PEMSTATUS(loc_oGrid.Column8, "Check1", 5)
                loc_oGrid.Column8.Check1.Alignment = 0
                loc_oGrid.Column8.Check1.ReadOnly  = .F.
                loc_oGrid.Column8.Check1.Visible   = .T.
                loc_oGrid.Column8.Check1.Top       = 9
                loc_oGrid.Column8.Check1.Left      = 2
                loc_oGrid.Column8.Check1.Height    = 17
                loc_oGrid.Column8.Check1.Width     = 22
                IF !THIS.this_lOpeBound
                    BINDEVENT(loc_oGrid.Column8.Check1, "KeyPress",  THIS, "OpeGerACheckKeyPress")
                    BINDEVENT(loc_oGrid.Column8.Check1, "MouseDown", THIS, "OpeGerACheckMouseDown")
                    THIS.this_lOpeBound = .T.
                ENDIF
            ENDIF

            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarGridOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGridEstoques - Carrega grd_4c_EstoqueA e grd_4c_EstoqueB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGridEstoques(par_cCodigos)
        LOCAL loc_lSucesso, loc_oGrid, loc_oBO, loc_cLocalA, loc_cLocalB
        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject
        loc_cLocalA  = ALLTRIM(loc_oBO.this_cLocalA)
        loc_cLocalB  = ALLTRIM(loc_oBO.this_cLocalB)

        TRY
            *-- Estoque A
            IF !EMPTY(loc_cLocalA)
                loc_oBO.CarregarEstoques(par_cCodigos, loc_cLocalA, "cursor_4c_EstoqueA")
            ELSE
                IF USED("cursor_4c_EstoqueA")
                    USE IN cursor_4c_EstoqueA
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
                    Emps C(3), Grupos C(40), Contas C(40), Marca L)
                SET NULL OFF
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA
            loc_oGrid.RecordSource = ""
            loc_oGrid.ColumnCount = 4
            loc_oGrid.RecordSource = "cursor_4c_EstoqueA"
            loc_oGrid.ColumnCount  = 4
            loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueA.Marca"
            loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueA.Emps"
            loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueA.Grupos"
            loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueA.Contas"
            loc_oGrid.Column1.Width = 22
            loc_oGrid.Column2.Width = 35
            loc_oGrid.Column3.Width = 90
            loc_oGrid.Column4.Width = 95
            loc_oGrid.Column1.Header1.Caption = ""
            loc_oGrid.Column2.Header1.Caption = "Emp"
            loc_oGrid.Column3.Header1.Caption = "Grupo"
            loc_oGrid.Column4.Header1.Caption = "Conta"
            loc_oGrid.Column1.Sparse   = .F.
            loc_oGrid.Column1.ReadOnly = .F.
            IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
                loc_oGrid.Column1.Check1.Alignment = 0
                loc_oGrid.Column1.Check1.ReadOnly  = .F.
                loc_oGrid.Column1.Check1.Visible   = .T.
                loc_oGrid.Column1.Check1.Top       = 9
                loc_oGrid.Column1.Check1.Left      = 2
                loc_oGrid.Column1.Check1.Height    = 17
                loc_oGrid.Column1.Check1.Width     = 22
                IF !THIS.this_lEstoqueBound
                    BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress",  THIS, "EstoqueACheckKeyPress")
                    BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "EstoqueACheckMouseDown")
                ENDIF
            ENDIF
            loc_oGrid.Refresh()

            *-- Estoque B
            IF !EMPTY(loc_cLocalB)
                loc_oBO.CarregarEstoques(par_cCodigos, loc_cLocalB, "cursor_4c_EstoqueB")
            ELSE
                IF USED("cursor_4c_EstoqueB")
                    USE IN cursor_4c_EstoqueB
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
                    Emps C(3), Grupos C(40), Contas C(40), Marca L)
                SET NULL OFF
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB
            loc_oGrid.RecordSource = ""
            loc_oGrid.ColumnCount = 4
            loc_oGrid.RecordSource = "cursor_4c_EstoqueB"
            loc_oGrid.ColumnCount  = 4
            loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueB.Marca"
            loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueB.Emps"
            loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueB.Grupos"
            loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueB.Contas"
            loc_oGrid.Column1.Width = 22
            loc_oGrid.Column2.Width = 35
            loc_oGrid.Column3.Width = 90
            loc_oGrid.Column4.Width = 95
            loc_oGrid.Column1.Header1.Caption = ""
            loc_oGrid.Column2.Header1.Caption = "Emp"
            loc_oGrid.Column3.Header1.Caption = "Grupo"
            loc_oGrid.Column4.Header1.Caption = "Conta"
            loc_oGrid.Column1.Sparse   = .F.
            loc_oGrid.Column1.ReadOnly = .F.
            IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
                loc_oGrid.Column1.Check1.Alignment = 0
                loc_oGrid.Column1.Check1.ReadOnly  = .F.
                loc_oGrid.Column1.Check1.Visible   = .T.
                loc_oGrid.Column1.Check1.Top       = 9
                loc_oGrid.Column1.Check1.Left      = 2
                loc_oGrid.Column1.Check1.Height    = 17
                loc_oGrid.Column1.Check1.Width     = 22
                IF !THIS.this_lEstoqueBound
                    BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress",  THIS, "EstoqueBCheckKeyPress")
                    BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "EstoqueBCheckMouseDown")
                    THIS.this_lEstoqueBound = .T.
                ENDIF
            ENDIF
            loc_oGrid.Refresh()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarGridEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarSubTabelas - Persiste SigLcLoI (operacoes) e SigLcLoE (estoques)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarSubTabelas(par_cCodigos)
        LOCAL loc_lSucesso, loc_oBO, loc_cIdChave, loc_cLocalA, loc_cLocalB
        LOCAL loc_nEnvRecs
        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject
        loc_cLocalA  = ALLTRIM(loc_oBO.this_cLocalA)
        loc_cLocalB  = ALLTRIM(loc_oBO.this_cLocalB)

        TRY
            *-- Excluir operacoes anteriores
            loc_oBO.ExcluirOperacoes(par_cCodigos)

            *-- Reinserir operacoes validas do cursor
            IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
                SELECT cursor_4c_Operacoes
                GO TOP

                loc_nEnvRecs = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Value

                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_Operacoes.Cods)) OR ;
                       !EMPTY(ALLTRIM(cursor_4c_Operacoes.Operacoes))

                        loc_cIdChave = TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS") + ;
                                       PADL(TRANSFORM(RECNO()), 4, "0")

                        loc_oBO.InserirOperacao(par_cCodigos, ;
                            loc_cIdChave, ;
                            ALLTRIM(cursor_4c_Operacoes.Emps), ;
                            ALLTRIM(cursor_4c_Operacoes.Cods), ;
                            ALLTRIM(cursor_4c_Operacoes.Operacoes), ;
                            ALLTRIM(cursor_4c_Operacoes.GrupoOs), ;
                            ALLTRIM(cursor_4c_Operacoes.ContaOs), ;
                            ALLTRIM(cursor_4c_Operacoes.GrupoDs), ;
                            ALLTRIM(cursor_4c_Operacoes.ContaDs), ;
                            IIF(cursor_4c_Operacoes.Agrupar, 1, 0), ;
                            IIF(loc_nEnvRecs = 1, "A", "B"))
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar estoques A e B
            IF !EMPTY(loc_cLocalA)
                loc_oBO.GravarEstoques(par_cCodigos, loc_cLocalA, "cursor_4c_EstoqueA")
            ENDIF

            IF !EMPTY(loc_cLocalB)
                loc_oBO.GravarEstoques(par_cCodigos, loc_cLocalB, "cursor_4c_EstoqueB")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em SalvarSubTabelas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAdicionarLinhaClick - Insere nova linha no cursor de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE BtnAdicionarLinhaClick()
        LOCAL loc_oGrid
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Operacoes")
            THIS.CriarCursoresOperacoesVazios()
        ENDIF

        SELECT cursor_4c_Operacoes
        INSERT INTO cursor_4c_Operacoes (cIdChaves, Codigos, Emps, Cods, Operacoes, ;
            GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs) ;
            VALUES ("", THIS.this_oBusinessObject.this_cCodigos, "", "", "", ;
                    "", "", "", "", .F., "")

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
        loc_oGrid.Refresh()
        GO BOTTOM IN cursor_4c_Operacoes
        loc_oGrid.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirLinhaClick - Remove linha corrente do cursor de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirLinhaClick()
        LOCAL loc_oGrid
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes") OR ;
           RECCOUNT("cursor_4c_Operacoes") = 0
            MsgAviso("Nenhuma linha para excluir!", "Aviso")
            RETURN
        ENDIF

        IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Confirmar")
            SELECT cursor_4c_Operacoes
            DELETE
            PACK IN cursor_4c_Operacoes
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
            loc_oGrid.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OpeGerAAfterRowColChange - Atualiza opt_4c_EnvRecs ao mudar linha do grid
    *--------------------------------------------------------------------------
    PROCEDURE OpeGerAAfterRowColChange(par_nColIndex)
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Refresh()
        CATCH TO loc_oErro
            MsgErro("Erro em OpeGerAAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EnvRecsInteractiveChange - Grava direcao de movimentacao na linha corrente do grid
    *--------------------------------------------------------------------------
    PROCEDURE EnvRecsInteractiveChange()
        LOCAL loc_nVal
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes")
            RETURN
        ENDIF
        TRY
            loc_nVal = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Value
            REPLACE EnvRecs WITH IIF(loc_nVal = 1, "A", "B") IN cursor_4c_Operacoes
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EnvRecsInteractiveChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarTodosAClick/BtnDesmarcarTodosAClick - Estoque A
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarTodosAClick()
        IF USED("cursor_4c_EstoqueA") AND RECCOUNT("cursor_4c_EstoqueA") > 0
            REPLACE ALL Marca WITH .T. IN cursor_4c_EstoqueA
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarTodosAClick()
        IF USED("cursor_4c_EstoqueA") AND RECCOUNT("cursor_4c_EstoqueA") > 0
            REPLACE ALL Marca WITH .F. IN cursor_4c_EstoqueA
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarTodosBClick/BtnDesmarcarTodosBClick - Estoque B
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarTodosBClick()
        IF USED("cursor_4c_EstoqueB") AND RECCOUNT("cursor_4c_EstoqueB") > 0
            REPLACE ALL Marca WITH .T. IN cursor_4c_EstoqueB
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarTodosBClick()
        IF USED("cursor_4c_EstoqueB") AND RECCOUNT("cursor_4c_EstoqueB") > 0
            REPLACE ALL Marca WITH .F. IN cursor_4c_EstoqueB
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OpeGerACheckKeyPress - Enter/Space na coluna Agrupar do grid OpeGerA
    *--------------------------------------------------------------------------
    PROCEDURE OpeGerACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Operacoes") AND ;
           !EOF("cursor_4c_Operacoes")
            IF par_nKeyCode = 13
                REPLACE Agrupar WITH .NOT. Agrupar IN cursor_4c_Operacoes
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OpeGerACheckMouseDown - Clique na coluna Agrupar do grid OpeGerA
    *--------------------------------------------------------------------------
    PROCEDURE OpeGerACheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EstoqueACheckKeyPress - Enter/Space na coluna Marca do Estoque A
    *--------------------------------------------------------------------------
    PROCEDURE EstoqueACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_EstoqueA") AND ;
           !EOF("cursor_4c_EstoqueA")
            IF par_nKeyCode = 13
                REPLACE Marca WITH .NOT. Marca IN cursor_4c_EstoqueA
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EstoqueACheckMouseDown - Clique na coluna Marca do Estoque A
    *--------------------------------------------------------------------------
    PROCEDURE EstoqueACheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        IF USED("cursor_4c_EstoqueA") AND !EOF("cursor_4c_EstoqueA")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EstoqueBCheckKeyPress - Enter/Space na coluna Marca do Estoque B
    *--------------------------------------------------------------------------
    PROCEDURE EstoqueBCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_EstoqueB") AND ;
           !EOF("cursor_4c_EstoqueB")
            IF par_nKeyCode = 13
                REPLACE Marca WITH .NOT. Marca IN cursor_4c_EstoqueB
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EstoqueBCheckMouseDown - Clique na coluna Marca do Estoque B
    *--------------------------------------------------------------------------
    PROCEDURE EstoqueBCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        IF USED("cursor_4c_EstoqueB") AND !EOF("cursor_4c_EstoqueB")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresasKeyPress - F4 abre lookup de Empresa (campo Empresas)
    *--------------------------------------------------------------------------
    PROCEDURE EmpresasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupEmpresa(.T.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TransitoriaKeyPress - F4 abre lookup de Empresa Transitoria
    *--------------------------------------------------------------------------
    PROCEDURE TransitoriaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupEmpresa(.F.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Lookup em SigCdEmp
    *   par_lEmpresas=.T. -> campo Empresas, .F. -> campo Transitoria
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa(par_lEmpresas)
        LOCAL loc_oBusca, loc_oCnt, loc_oTxt
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigos

        IF par_lEmpresas
            loc_oTxt = loc_oCnt.txt_4c_Empresas
        ELSE
            loc_oTxt = loc_oCnt.txt_4c_Transitoria
        ENDIF

        IF !loc_oTxt.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
            ALLTRIM(loc_oTxt.Value), "Buscar Empresa")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                SELECT cursor_4c_BuscaEmp
                loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalAKeyPress - F4 abre lookup de Local A
    *--------------------------------------------------------------------------
    PROCEDURE LocalAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupLocalA()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalBKeyPress - F4 abre lookup de Local B
    *--------------------------------------------------------------------------
    PROCEDURE LocalBKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupLocalB()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLocalA - Lookup em SigCdLoc para Local A
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLocalA()
        LOCAL loc_oBusca, loc_oTxt
        loc_oTxt = THIS.pgf_4c_Paginas.Page2.cnt_4c_LocalA.txt_4c_LocalA

        IF !loc_oTxt.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdLoc", "cursor_4c_BuscaLoc", "Cods", ;
            ALLTRIM(loc_oTxt.Value), "Buscar Local A")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Cods", "", "Local")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
                SELECT cursor_4c_BuscaLoc
                loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaLoc")
            USE IN cursor_4c_BuscaLoc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLocalB - Lookup em SigCdLoc para Local B
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLocalB()
        LOCAL loc_oBusca, loc_oTxt
        loc_oTxt = THIS.pgf_4c_Paginas.Page2.cnt_4c_LocalB.txt_4c_LocalB

        IF !loc_oTxt.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdLoc", "cursor_4c_BuscaLoc", "Cods", ;
            ALLTRIM(loc_oTxt.Value), "Buscar Local B")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Cods", "", "Local")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
                SELECT cursor_4c_BuscaLoc
                loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaLoc")
            USE IN cursor_4c_BuscaLoc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_i
        LOCAL ARRAY loc_aCursores(6)
        loc_aCursores(1) = "cursor_4c_Dados"
        loc_aCursores(2) = "cursor_4c_Carrega"
        loc_aCursores(3) = "cursor_4c_Operacoes"
        loc_aCursores(4) = "cursor_4c_Estoques"
        loc_aCursores(5) = "cursor_4c_EstoqueA"
        loc_aCursores(6) = "cursor_4c_EstoqueB"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros de SigLcLo no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 4

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.LocalA"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.LocalB"

                loc_oGrid.Column1.Width = 150
                loc_oGrid.Column2.Width = 70
                loc_oGrid.Column3.Width = 150
                loc_oGrid.Column4.Width = 150

                loc_oGrid.Column1.Header1.Caption = ""
                loc_oGrid.Column2.Header1.Caption = "Emp"
                loc_oGrid.Column3.Header1.Caption = "Local"
                loc_oGrid.Column4.Header1.Caption = "Local"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva o registro atual (handler do botao cmd_4c_Confirmar)
    * Delega para BtnSalvarClick para manter compatibilidade com validador
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        RETURN THIS.BtnSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro atual (Confirmar/Salvar)
    * Executa FormParaBO -> ValidarCampos -> Salvar -> SalvarSubTabelas
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_lValido
        loc_lResultado = .F.
        loc_lValido    = .F.

        TRY
            THIS.FormParaBO()
            loc_lValido = THIS.ValidarCampos()

            IF loc_lValido
                IF THIS.this_oBusinessObject.Salvar()
                    THIS.SalvarSubTabelas(THIS.this_oBusinessObject.this_cCodigos)
                    MsgInfo("Registro salvo com sucesso!", "Sucesso")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao salvar registro.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela a edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPg2, loc_oCodigos, loc_oLocalA, loc_oLocalB, loc_cData
        loc_oBO      = THIS.this_oBusinessObject
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_oCodigos = loc_oPg2.cnt_4c_Codigos
        loc_oLocalA  = loc_oPg2.cnt_4c_LocalA
        loc_oLocalB  = loc_oPg2.cnt_4c_LocalB

        *-- cnt_4c_Codigos
        loc_oBO.this_cCodigos   = ALLTRIM(loc_oCodigos.txt_4c_Codigos.Value)
        loc_oBO.this_cEmps      = ALLTRIM(loc_oCodigos.txt_4c_Empresas.Value)
        loc_oBO.this_lEmpContas = (loc_oCodigos.chk_4c_EmpContas.Value = 1)
        loc_oBO.this_cEmpTrans  = ALLTRIM(loc_oCodigos.txt_4c_Transitoria.Value)
        loc_oBO.this_nDigitos   = loc_oCodigos.obj_4c_OptDigitos.Value
        loc_oBO.this_lAutos     = (loc_oCodigos.chk_4c_Autos.Value = 1)
        loc_oBO.this_nToleras   = loc_oCodigos.txt_4c_Toleras.Value
        loc_oBO.this_nPercents  = loc_oCodigos.txt_4c_Percents.Value

        *-- cnt_4c_LocalA
        loc_oBO.this_cLocalA    = ALLTRIM(loc_oLocalA.txt_4c_LocalA.Value)
        loc_oBO.this_cGrupoA    = ALLTRIM(loc_oLocalA.txt_4c_GrupoA.Value)
        loc_oBO.this_cContaA    = ALLTRIM(loc_oLocalA.txt_4c_ContaA.Value)
        loc_oBO.this_cOperacaoA = ALLTRIM(loc_oLocalA.txt_4c_OperacaoA.Value)
        loc_oBO.this_cGdeGrupoA = ALLTRIM(loc_oLocalA.txt_4c_GdeGrupoA.Value)
        loc_oBO.this_lEtiquetaA = (loc_oLocalA.chk_4c_EtiquetaA.Value = 1)
        loc_oBO.this_lPalmA     = (loc_oLocalA.chk_4c_PalmA.Value = 1)
        loc_oBO.this_nDivisaoA  = loc_oLocalA.txt_4c_DivisaosA.Value
        loc_cData = STRTRAN(loc_oLocalA.txt_4c_DataA.Value, "/", "")
        IF EMPTY(ALLTRIM(loc_cData))
            loc_oBO.this_dDataA = {}
        ELSE
            loc_oBO.this_dDataA = CTOD(ALLTRIM(loc_oLocalA.txt_4c_DataA.Value))
        ENDIF

        *-- cnt_4c_LocalB
        loc_oBO.this_cLocalB    = ALLTRIM(loc_oLocalB.txt_4c_LocalB.Value)
        loc_oBO.this_cGrupoB    = ALLTRIM(loc_oLocalB.txt_4c_GrupoB.Value)
        loc_oBO.this_cContaB    = ALLTRIM(loc_oLocalB.txt_4c_ContaB.Value)
        loc_oBO.this_cOperacaoB = ALLTRIM(loc_oLocalB.txt_4c_OperacaoB.Value)
        loc_oBO.this_cGdeGrupoB = ALLTRIM(loc_oLocalB.txt_4c_GdeGrupoB.Value)
        loc_oBO.this_lEtiquetaB = (loc_oLocalB.chk_4c_EtiquetaB.Value = 1)
        loc_oBO.this_lPalmB     = (loc_oLocalB.chk_4c_PalmB.Value = 1)
        loc_oBO.this_nDivisaoB  = loc_oLocalB.txt_4c_DivisaosB.Value
        loc_cData = STRTRAN(loc_oLocalB.txt_4c_DataB.Value, "/", "")
        IF EMPTY(ALLTRIM(loc_cData))
            loc_oBO.this_dDataB = {}
        ELSE
            loc_oBO.this_dDataB = CTOD(ALLTRIM(loc_oLocalB.txt_4c_DataB.Value))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPg2, loc_oCodigos, loc_oLocalA, loc_oLocalB
        loc_oBO      = THIS.this_oBusinessObject
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_oCodigos = loc_oPg2.cnt_4c_Codigos
        loc_oLocalA  = loc_oPg2.cnt_4c_LocalA
        loc_oLocalB  = loc_oPg2.cnt_4c_LocalB

        *-- cnt_4c_Codigos
        loc_oCodigos.txt_4c_Codigos.Value     = loc_oBO.this_cCodigos
        loc_oCodigos.txt_4c_Empresas.Value    = loc_oBO.this_cEmps
        loc_oCodigos.chk_4c_EmpContas.Value   = IIF(loc_oBO.this_lEmpContas, 1, 0)
        loc_oCodigos.txt_4c_Transitoria.Value = loc_oBO.this_cEmpTrans
        loc_oCodigos.obj_4c_OptDigitos.Value  = IIF(INLIST(loc_oBO.this_nDigitos, 1, 2, 3), loc_oBO.this_nDigitos, 1)
        loc_oCodigos.chk_4c_Autos.Value       = IIF(loc_oBO.this_lAutos, 1, 0)
        loc_oCodigos.txt_4c_Toleras.Value     = loc_oBO.this_nToleras
        loc_oCodigos.txt_4c_Percents.Value    = loc_oBO.this_nPercents

        *-- cnt_4c_LocalA
        loc_oLocalA.txt_4c_LocalA.Value    = loc_oBO.this_cLocalA
        loc_oLocalA.txt_4c_GrupoA.Value    = loc_oBO.this_cGrupoA
        loc_oLocalA.txt_4c_DGrupoA.Value   = ""
        loc_oLocalA.txt_4c_ContaA.Value    = loc_oBO.this_cContaA
        loc_oLocalA.txt_4c_DContaA.Value   = ""
        loc_oLocalA.txt_4c_OperacaoA.Value = loc_oBO.this_cOperacaoA
        loc_oLocalA.txt_4c_GdeGrupoA.Value = loc_oBO.this_cGdeGrupoA
        loc_oLocalA.chk_4c_EtiquetaA.Value = IIF(loc_oBO.this_lEtiquetaA, 1, 0)
        loc_oLocalA.chk_4c_PalmA.Value     = IIF(loc_oBO.this_lPalmA, 1, 0)
        loc_oLocalA.txt_4c_DivisaosA.Value = loc_oBO.this_nDivisaoA
        loc_oLocalA.txt_4c_DataA.Value     = IIF(EMPTY(loc_oBO.this_dDataA), "", DTOC(loc_oBO.this_dDataA))

        *-- cnt_4c_LocalB
        loc_oLocalB.txt_4c_LocalB.Value    = loc_oBO.this_cLocalB
        loc_oLocalB.txt_4c_GrupoB.Value    = loc_oBO.this_cGrupoB
        loc_oLocalB.txt_4c_DGrupoB.Value   = ""
        loc_oLocalB.txt_4c_ContaB.Value    = loc_oBO.this_cContaB
        loc_oLocalB.txt_4c_DContaB.Value   = ""
        loc_oLocalB.txt_4c_OperacaoB.Value = loc_oBO.this_cOperacaoB
        loc_oLocalB.txt_4c_GdeGrupoB.Value = loc_oBO.this_cGdeGrupoB
        loc_oLocalB.chk_4c_EtiquetaB.Value = IIF(loc_oBO.this_lEtiquetaB, 1, 0)
        loc_oLocalB.chk_4c_PalmB.Value     = IIF(loc_oBO.this_lPalmB, 1, 0)
        loc_oLocalB.txt_4c_DivisaosB.Value = loc_oBO.this_nDivisaoB
        loc_oLocalB.txt_4c_DataB.Value     = IIF(EMPTY(loc_oBO.this_dDataB), "", DTOC(loc_oBO.this_dDataB))
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oObjeto, loc_nP

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_i)

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

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.BOParaForm()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.CriarCursoresOperacoesVazios()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista!", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.CarregarGridOperacoes(loc_cCodigo)
            THIS.CarregarGridEstoques(loc_cCodigo)
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado!", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista!", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.CarregarGridOperacoes(loc_cCodigo)
            THIS.CarregarGridEstoques(loc_cCodigo)
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado!", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado (com sub-tabelas SigLcLoI e SigLcLoE)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista!", "Aviso")
            RETURN
        ENDIF

        IF !MsgConfirma("Deseja excluir o comparativo '" + loc_cCodigo + "'?" + CHR(13) + ;
                        "Todas as opera" + CHR(231) + CHR(245) + "es e estoques vinculados ser" + CHR(227) + "o exclu" + CHR(237) + "dos!", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir o registro.", "Erro")
            ENDIF
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado!", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Buscar comparativo via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_oBusca = .NULL.
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigLcLo", "cursor_4c_BuscaClc", "Codigos", "", ;
                "Buscar Comparativo")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Emps",    "", "Empresa")
                loc_oBusca.mAddColuna("LocalA",  "", "Local A")
                loc_oBusca.mAddColuna("LocalB",  "", "Local B")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClc")
                    SELECT cursor_4c_BuscaClc
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaClc.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaClc")
            USE IN cursor_4c_BuscaClc
        ENDIF

        IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(cursor_4c_Dados.Codigos) == loc_cCodigo
            IF FOUND()
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridListaDblClick - DblClick no grid abre modo Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE GridListaDblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oCodigos, loc_oLocalA, loc_oLocalB
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_oCodigos = loc_oPg2.cnt_4c_Codigos
        loc_oLocalA  = loc_oPg2.cnt_4c_LocalA
        loc_oLocalB  = loc_oPg2.cnt_4c_LocalB

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF

        *-- cnt_4c_Codigos (Codigos somente habilitado em INCLUIR)
        loc_oCodigos.txt_4c_Codigos.Enabled     = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oCodigos.txt_4c_Empresas.Enabled    = par_lHabilitar
        loc_oCodigos.chk_4c_EmpContas.Enabled   = par_lHabilitar
        loc_oCodigos.txt_4c_Transitoria.Enabled = par_lHabilitar
        loc_oCodigos.obj_4c_OptDigitos.Enabled  = par_lHabilitar
        loc_oCodigos.chk_4c_Autos.Enabled       = par_lHabilitar
        loc_oCodigos.txt_4c_Toleras.Enabled     = par_lHabilitar
        loc_oCodigos.txt_4c_Percents.Enabled    = par_lHabilitar

        *-- cnt_4c_LocalA
        loc_oLocalA.txt_4c_LocalA.Enabled    = par_lHabilitar
        loc_oLocalA.txt_4c_DataA.Enabled     = par_lHabilitar
        loc_oLocalA.txt_4c_DivisaosA.Enabled = par_lHabilitar
        loc_oLocalA.txt_4c_GrupoA.Enabled    = par_lHabilitar
        loc_oLocalA.txt_4c_ContaA.Enabled    = par_lHabilitar
        loc_oLocalA.txt_4c_OperacaoA.Enabled = par_lHabilitar
        loc_oLocalA.txt_4c_GdeGrupoA.Enabled = par_lHabilitar
        loc_oLocalA.chk_4c_PalmA.Enabled     = par_lHabilitar
        loc_oLocalA.chk_4c_EtiquetaA.Enabled = par_lHabilitar

        *-- cnt_4c_LocalB
        loc_oLocalB.txt_4c_LocalB.Enabled    = par_lHabilitar
        loc_oLocalB.txt_4c_DataB.Enabled     = par_lHabilitar
        loc_oLocalB.txt_4c_DivisaosB.Enabled = par_lHabilitar
        loc_oLocalB.txt_4c_GrupoB.Enabled    = par_lHabilitar
        loc_oLocalB.txt_4c_ContaB.Enabled    = par_lHabilitar
        loc_oLocalB.txt_4c_OperacaoB.Enabled = par_lHabilitar
        loc_oLocalB.txt_4c_GdeGrupoB.Enabled = par_lHabilitar
        loc_oLocalB.chk_4c_PalmB.Enabled     = par_lHabilitar
        loc_oLocalB.chk_4c_EtiquetaB.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    * Complementado nas Fases 5-6 com todos os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_oBusinessObject.this_cCodigos   = ""
        THIS.this_oBusinessObject.this_cEmps      = ""
        THIS.this_oBusinessObject.this_lEmpContas = .F.
        THIS.this_oBusinessObject.this_cEmpTrans  = ""
        THIS.this_oBusinessObject.this_nDigitos   = 0
        THIS.this_oBusinessObject.this_lAutos     = .F.
        THIS.this_oBusinessObject.this_nToleras   = 0
        THIS.this_oBusinessObject.this_nPercents  = 0
        THIS.this_oBusinessObject.this_cLocalA    = ""
        THIS.this_oBusinessObject.this_cGrupoA    = ""
        THIS.this_oBusinessObject.this_cContaA    = ""
        THIS.this_oBusinessObject.this_cOperacaoA = ""
        THIS.this_oBusinessObject.this_cGdeGrupoA = ""
        THIS.this_oBusinessObject.this_dDataA     = {}
        THIS.this_oBusinessObject.this_lEtiquetaA = .F.
        THIS.this_oBusinessObject.this_lPalmA     = .F.
        THIS.this_oBusinessObject.this_nDivisaoA  = 0
        THIS.this_oBusinessObject.this_cLocalB    = ""
        THIS.this_oBusinessObject.this_cGrupoB    = ""
        THIS.this_oBusinessObject.this_cContaB    = ""
        THIS.this_oBusinessObject.this_cOperacaoB = ""
        THIS.this_oBusinessObject.this_cGdeGrupoB = ""
        THIS.this_oBusinessObject.this_dDataB     = {}
        THIS.this_oBusinessObject.this_lEtiquetaB = .F.
        THIS.this_oBusinessObject.this_lPalmB     = .F.
        THIS.this_oBusinessObject.this_nDivisaoB  = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_lValido, loc_oBO
        loc_lValido = .T.
        loc_oBO     = THIS.this_oBusinessObject

        IF EMPTY(ALLTRIM(loc_oBO.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            IF loc_oBO.VerificarCodigoDuplicado(loc_oBO.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        IF EMPTY(ALLTRIM(loc_oBO.this_cLocalA))
            MsgAviso("Local A " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oBO.this_cLocalB))
            MsgAviso("Local B " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CLCBO.prg):
*===============================================================================
* CLCBO.prg - Business Object para Comparativos Entre Locais
* Tabela principal: SigLcLo (PK: Codigos)
* Tabelas relacionadas: SigLcLoI (operacoes), SigLcLoE (estoques avaliados)
*===============================================================================
DEFINE CLASS CLCBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigLcLo"
    this_cCampoChave = "Codigos"

    *---------------------------------------------------------------------------
    * Propriedades - SigLcLo (campos principais)
    *---------------------------------------------------------------------------
    this_cCodigos    = ""   && Codigos  C - Chave primaria
    this_cEmps       = ""   && Emps     C(3) - Empresa
    this_lEmpContas  = .F.  && EmpContas N(1) - Substituir contas
    this_cEmpTrans   = ""   && EmpTrans  C - Empresa transitoria
    this_nDigitos    = 0    && Digitos   N - Digitos/Grupo (optiongroup)
    this_lAutos      = .F.  && Autos     N(1) - Automatico (processamento)
    this_nToleras    = 0    && Toleras   N - Tolerancia AU
    this_nPercents   = 0    && Percents  N - Percentual

    *-- Local A
    this_cLocalA     = ""   && LocalA    C - Codigo do Local A
    this_cGrupoA     = ""   && GrupoA    C - Grupo Origem (remote DB)
    this_cContaA     = ""   && ContaA    C - Conta Origem (remote DB)
    this_cOperacaoA  = ""   && OperacaoA C - Operacao Local A
    this_cGdeGrupoA  = ""   && GdeGrupoA C - Grande Grupo Local A
    this_dDataA      = {}   && DataA     D - Data Local A
    this_lEtiquetaA  = .F.  && EtiquetaA N(1) - Etiquetas Local A
    this_lPalmA      = .F.  && PalmA     N(1) - Checar Venda Palm A
    this_nDivisaoA   = 0    && DivisaoA  N - Divisao Local A

    *-- Local B
    this_cLocalB     = ""   && LocalB    C - Codigo do Local B
    this_cGrupoB     = ""   && GrupoB    C - Grupo Origem (remote DB)
    this_cContaB     = ""   && ContaB    C - Conta Origem (remote DB)
    this_cOperacaoB  = ""   && OperacaoB C - Operacao Local B
    this_cGdeGrupoB  = ""   && GdeGrupoB C - Grande Grupo Local B
    this_dDataB      = {}   && DataB     D - Data Local B
    this_lEtiquetaB  = .F.  && EtiquetaB N(1) - Etiquetas Local B
    this_lPalmB      = .F.  && PalmB     N(1) - Checar Venda Palm B
    this_nDivisaoB   = 0    && DivisaoB  N - Divisao Local B

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigLcLo"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *---------------------------------------------------------------------------
    * Buscar - SELECT de todos os registros de SigLcLo
    *---------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo ORDER BY Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro especifico pelo codigo
    *---------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            IF VARTYPE(EmpContas) = "L"
                THIS.this_lEmpContas = EmpContas
            ELSE
                IF VARTYPE(EmpContas) = "L"
                    THIS.this_lEmpContas = EmpContas
                ELSE
                    IF VARTYPE(EmpContas) = "L"
                        THIS.this_lEmpContas = EmpContas
                    ELSE
                        IF VARTYPE(EmpContas) = "L"
                            THIS.this_lEmpContas = EmpContas
                        ELSE
                            IF VARTYPE(EmpContas) = "L"
                                THIS.this_lEmpContas = EmpContas
                            ELSE
                                IF VARTYPE(EmpContas) = "L"
                                    THIS.this_lEmpContas = EmpContas
                                ELSE
                                    IF VARTYPE(EmpContas) = "L"
                                        THIS.this_lEmpContas = EmpContas
                                    ELSE
                                        IF VARTYPE(EmpContas) = "L"
                                            THIS.this_lEmpContas = EmpContas
                                        ELSE
                                            IF VARTYPE(EmpContas) = "L"
                                                THIS.this_lEmpContas = EmpContas
                                            ELSE
                                                IF VARTYPE(EmpContas) = "L"
                                                    THIS.this_lEmpContas = EmpContas
                                                ELSE
                                                    THIS.this_lEmpContas = (NVL(EmpContas, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_cEmpTrans  = TratarNulo(EmpTrans,  "C")
            THIS.this_nDigitos   = TratarNulo(Digitos,   "N")
            IF VARTYPE(Autos) = "L"
                THIS.this_lAutos = Autos
            ELSE
                IF VARTYPE(Autos) = "L"
                    THIS.this_lAutos = Autos
                ELSE
                    IF VARTYPE(Autos) = "L"
                        THIS.this_lAutos = Autos
                    ELSE
                        IF VARTYPE(Autos) = "L"
                            THIS.this_lAutos = Autos
                        ELSE
                            IF VARTYPE(Autos) = "L"
                                THIS.this_lAutos = Autos
                            ELSE
                                IF VARTYPE(Autos) = "L"
                                    THIS.this_lAutos = Autos
                                ELSE
                                    IF VARTYPE(Autos) = "L"
                                        THIS.this_lAutos = Autos
                                    ELSE
                                        IF VARTYPE(Autos) = "L"
                                            THIS.this_lAutos = Autos
                                        ELSE
                                            IF VARTYPE(Autos) = "L"
                                                THIS.this_lAutos = Autos
                                            ELSE
                                                IF VARTYPE(Autos) = "L"
                                                    THIS.this_lAutos = Autos
                                                ELSE
                                                    THIS.this_lAutos = (NVL(Autos, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nToleras   = TratarNulo(Toleras,   "N")
            THIS.this_nPercents  = TratarNulo(Percents,  "N")
            THIS.this_cLocalA    = TratarNulo(LocalA,    "C")
            THIS.this_cGrupoA    = TratarNulo(GrupoA,    "C")
            THIS.this_cContaA    = TratarNulo(ContaA,    "C")
            THIS.this_cOperacaoA = TratarNulo(OperacaoA, "C")
            THIS.this_cGdeGrupoA = TratarNulo(GdeGrupoA, "C")
            THIS.this_dDataA     = TratarNulo(DataA,     "D")
            IF VARTYPE(EtiquetaA) = "L"
                THIS.this_lEtiquetaA = EtiquetaA
            ELSE
                IF VARTYPE(EtiquetaA) = "L"
                    THIS.this_lEtiquetaA = EtiquetaA
                ELSE
                    IF VARTYPE(EtiquetaA) = "L"
                        THIS.this_lEtiquetaA = EtiquetaA
                    ELSE
                        IF VARTYPE(EtiquetaA) = "L"
                            THIS.this_lEtiquetaA = EtiquetaA
                        ELSE
                            IF VARTYPE(EtiquetaA) = "L"
                                THIS.this_lEtiquetaA = EtiquetaA
                            ELSE
                                IF VARTYPE(EtiquetaA) = "L"
                                    THIS.this_lEtiquetaA = EtiquetaA
                                ELSE
                                    IF VARTYPE(EtiquetaA) = "L"
                                        THIS.this_lEtiquetaA = EtiquetaA
                                    ELSE
                                        IF VARTYPE(EtiquetaA) = "L"
                                            THIS.this_lEtiquetaA = EtiquetaA
                                        ELSE
                                            IF VARTYPE(EtiquetaA) = "L"
                                                THIS.this_lEtiquetaA = EtiquetaA
                                            ELSE
                                                IF VARTYPE(EtiquetaA) = "L"
                                                    THIS.this_lEtiquetaA = EtiquetaA
                                                ELSE
                                                    THIS.this_lEtiquetaA = (NVL(EtiquetaA, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmA) = "L"
                THIS.this_lPalmA = PalmA
            ELSE
                IF VARTYPE(PalmA) = "L"
                    THIS.this_lPalmA = PalmA
                ELSE
                    IF VARTYPE(PalmA) = "L"
                        THIS.this_lPalmA = PalmA
                    ELSE
                        IF VARTYPE(PalmA) = "L"
                            THIS.this_lPalmA = PalmA
                        ELSE
                            IF VARTYPE(PalmA) = "L"
                                THIS.this_lPalmA = PalmA
                            ELSE
                                IF VARTYPE(PalmA) = "L"
                                    THIS.this_lPalmA = PalmA
                                ELSE
                                    IF VARTYPE(PalmA) = "L"
                                        THIS.this_lPalmA = PalmA
                                    ELSE
                                        IF VARTYPE(PalmA) = "L"
                                            THIS.this_lPalmA = PalmA
                                        ELSE
                                            IF VARTYPE(PalmA) = "L"
                                                THIS.this_lPalmA = PalmA
                                            ELSE
                                                IF VARTYPE(PalmA) = "L"
                                                    THIS.this_lPalmA = PalmA
                                                ELSE
                                                    THIS.this_lPalmA = (NVL(PalmA, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nDivisaoA  = TratarNulo(DivisaoA,  "N")
            THIS.this_cLocalB    = TratarNulo(LocalB,    "C")
            THIS.this_cGrupoB    = TratarNulo(GrupoB,    "C")
            THIS.this_cContaB    = TratarNulo(ContaB,    "C")
            THIS.this_cOperacaoB = TratarNulo(OperacaoB, "C")
            THIS.this_cGdeGrupoB = TratarNulo(GdeGrupoB, "C")
            THIS.this_dDataB     = TratarNulo(DataB,     "D")
            IF VARTYPE(EtiquetaB) = "L"
                THIS.this_lEtiquetaB = EtiquetaB
            ELSE
                IF VARTYPE(EtiquetaB) = "L"
                    THIS.this_lEtiquetaB = EtiquetaB
                ELSE
                    IF VARTYPE(EtiquetaB) = "L"
                        THIS.this_lEtiquetaB = EtiquetaB
                    ELSE
                        IF VARTYPE(EtiquetaB) = "L"
                            THIS.this_lEtiquetaB = EtiquetaB
                        ELSE
                            IF VARTYPE(EtiquetaB) = "L"
                                THIS.this_lEtiquetaB = EtiquetaB
                            ELSE
                                IF VARTYPE(EtiquetaB) = "L"
                                    THIS.this_lEtiquetaB = EtiquetaB
                                ELSE
                                    IF VARTYPE(EtiquetaB) = "L"
                                        THIS.this_lEtiquetaB = EtiquetaB
                                    ELSE
                                        IF VARTYPE(EtiquetaB) = "L"
                                            THIS.this_lEtiquetaB = EtiquetaB
                                        ELSE
                                            IF VARTYPE(EtiquetaB) = "L"
                                                THIS.this_lEtiquetaB = EtiquetaB
                                            ELSE
                                                IF VARTYPE(EtiquetaB) = "L"
                                                    THIS.this_lEtiquetaB = EtiquetaB
                                                ELSE
                                                    THIS.this_lEtiquetaB = (NVL(EtiquetaB, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmB) = "L"
                THIS.this_lPalmB = PalmB
            ELSE
                IF VARTYPE(PalmB) = "L"
                    THIS.this_lPalmB = PalmB
                ELSE
                    IF VARTYPE(PalmB) = "L"
                        THIS.this_lPalmB = PalmB
                    ELSE
                        IF VARTYPE(PalmB) = "L"
                            THIS.this_lPalmB = PalmB
                        ELSE
                            IF VARTYPE(PalmB) = "L"
                                THIS.this_lPalmB = PalmB
                            ELSE
                                IF VARTYPE(PalmB) = "L"
                                    THIS.this_lPalmB = PalmB
                                ELSE
                                    IF VARTYPE(PalmB) = "L"
                                        THIS.this_lPalmB = PalmB
                                    ELSE
                                        IF VARTYPE(PalmB) = "L"
                                            THIS.this_lPalmB = PalmB
                                        ELSE
                                            IF VARTYPE(PalmB) = "L"
                                                THIS.this_lPalmB = PalmB
                                            ELSE
                                                IF VARTYPE(PalmB) = "L"
                                                    THIS.this_lPalmB = PalmB
                                                ELSE
                                                    THIS.this_lPalmB = (NVL(PalmB, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nDivisaoB  = TratarNulo(DivisaoB,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarOperacoes - Carrega SigLcLoI para o cursor do grid de operacoes
    *---------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF

        TRY
            loc_cSQL = "SELECT cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       " FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cIdChaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Operacoes")
                    GO TOP IN cursor_4c_Operacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarEstoques - Carrega SigLcLoE (estoques avaliados) para um local
    *---------------------------------------------------------------------------
    PROCEDURE CarregarEstoques(par_cCodigos, par_cLocal, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cCursorDestino)
            USE IN (par_cCursorDestino)
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Locals, Emps, Grupos, Contas, Marca" + ;
                       " FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal) + ;
                       " ORDER BY Emps, Grupos, Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                IF USED(par_cCursorDestino)
                    GO TOP IN (par_cCursorDestino)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarCodigoDuplicado - Verifica se o codigo ja existe na tabela
    *---------------------------------------------------------------------------
    PROCEDURE VerificarCodigoDuplicado(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                GO TOP IN cursor_4c_ChkDup
                loc_lExiste = (cursor_4c_ChkDup.Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarCodigoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - INSERT INTO SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLo (" + ;
                       " Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents," + ;
                       " LocalA, GrupoA, ContaA, OperacaoA, GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB, GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cEmps)      + "," + ;
                       IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       EscaparSQL(THIS.this_cContaA)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       EscaparSQL(THIS.this_cContaB)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - UPDATE SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigLcLo SET" + ;
                       " Emps      = " + EscaparSQL(THIS.this_cEmps)      + "," + ;
                       " EmpContas = " + IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       " EmpTrans  = " + EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       " Digitos   = " + FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       " Autos     = " + IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       " Toleras   = " + FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       " Percents  = " + FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       " LocalA    = " + EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       " GrupoA    = " + EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       " ContaA    = " + EscaparSQL(THIS.this_cContaA)    + "," + ;
                       " OperacaoA = " + EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       " GdeGrupoA = " + EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       " DataA     = " + FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       " EtiquetaA = " + IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       " PalmA     = " + IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       " DivisaoA  = " + FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       " LocalB    = " + EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       " GrupoB    = " + EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       " ContaB    = " + EscaparSQL(THIS.this_cContaB)    + "," + ;
                       " OperacaoB = " + EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       " GdeGrupoB = " + EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       " DataB     = " + FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       " EtiquetaB = " + IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       " PalmB     = " + IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       " DivisaoB  = " + FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigLcLoI + SigLcLoE + SigLcLo (PROTECTED)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros filhos de SigLcLoI primeiro
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir registros filhos de SigLcLoE
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir estoques avaliados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir o registro principal
            loc_cSQL = "DELETE FROM SigLcLo WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * InserirOperacao - INSERT filho em SigLcLoI (chamado pelo Form ao gravar grid)
    *---------------------------------------------------------------------------
    PROCEDURE InserirOperacao(par_cCodigos, par_cIdChave, par_cEmps, par_cCods, ;
                              par_cOperacoes, par_cGrupoOs, par_cContaOs, ;
                              par_cGrupoDs, par_cContaDs, par_nAgrupar, par_cEnvRecs)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLoI (" + ;
                       " cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       ") VALUES (" + ;
                       EscaparSQL(par_cIdChave)   + "," + ;
                       EscaparSQL(par_cCodigos)   + "," + ;
                       EscaparSQL(par_cEmps)      + "," + ;
                       EscaparSQL(par_cCods)      + "," + ;
                       EscaparSQL(par_cOperacoes) + "," + ;
                       EscaparSQL(par_cGrupoOs)   + "," + ;
                       EscaparSQL(par_cContaOs)   + "," + ;
                       EscaparSQL(par_cGrupoDs)   + "," + ;
                       EscaparSQL(par_cContaDs)   + "," + ;
                       FormatarNumeroSQL(par_nAgrupar) + "," + ;
                       EscaparSQL(par_cEnvRecs)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InserirOperacao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExcluirOperacoes - DELETE todos os filhos de SigLcLoI para um codigo
    *---------------------------------------------------------------------------
    PROCEDURE ExcluirOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExcluirOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * GravarEstoques - DELETE + re-INSERT em SigLcLoE para um local
    *---------------------------------------------------------------------------
    PROCEDURE GravarEstoques(par_cCodigos, par_cLocal, par_cCursorOrigem)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros anteriores deste local
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Inserir registros marcados do cursor origem
            IF USED(par_cCursorOrigem) AND RECCOUNT(par_cCursorOrigem) > 0
                SELECT (par_cCursorOrigem)
                GO TOP

                SCAN
                    SELECT (par_cCursorOrigem)
                    IF Marca
                        loc_cSQL = "INSERT INTO SigLcLoE (Codigos, Locals, Emps, Grupos, Contas, Marca)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(par_cCodigos) + "," + ;
                                   EscaparSQL(par_cLocal)   + "," + ;
                                   EscaparSQL(ALLTRIM(Emps))   + "," + ;
                                   EscaparSQL(ALLTRIM(Grupos)) + "," + ;
                                   EscaparSQL(ALLTRIM(Contas)) + "," + ;
                                   "1)"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao gravar estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em GravarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


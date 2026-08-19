# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 6/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[19/08/2026 01:41:18] FormMda.InicializarForm: Erro ao inicializar FormMda: | Error with Column1 - CurrentControl : Expression evaluated to an illegal value. | Linha: 1206


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-19 01:32:56] [INFO] Config FPW: (nao fornecido)
[2026-08-19 01:32:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:32:56] [INFO] Timeout: 300 segundos
[2026-08-19 01:32:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_p2pjdtvr.prg
[2026-08-19 01:32:56] [INFO] Conteudo do wrapper:
[2026-08-19 01:32:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
QUIT

[2026-08-19 01:32:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_p2pjdtvr.prg
[2026-08-19 01:32:56] [INFO] VFP output esperado em: C:\4c\tasks\task462\vfp_output.txt
[2026-08-19 01:32:56] [INFO] Executando Visual FoxPro 9...
[2026-08-19 01:32:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_p2pjdtvr.prg
[2026-08-19 01:32:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_p2pjdtvr.prg
[2026-08-19 01:32:56] [INFO] Timeout configurado: 300 segundos
[2026-08-19 01:34:15] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-19 01:34:15] [INFO] VFP9 finalizado em 78.4554267 segundos
[2026-08-19 01:34:15] [INFO] Exit Code: 
[2026-08-19 01:34:15] [INFO] 
[2026-08-19 01:34:15] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-19 01:34:15] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_p2pjdtvr.prg
[2026-08-19 01:34:15] [INFO] 
[2026-08-19 01:34:15] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-19 01:34:15] [INFO] * Auto-generated wrapper for parameters
[2026-08-19 01:34:15] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:34:15] [INFO] * Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:34:15] [INFO] 
[2026-08-19 01:34:15] [INFO] * Anti-dialog protections for unattended execution
[2026-08-19 01:34:15] [INFO] SET SAFETY OFF
[2026-08-19 01:34:15] [INFO] SET RESOURCE OFF
[2026-08-19 01:34:15] [INFO] SET TALK OFF
[2026-08-19 01:34:15] [INFO] SET NOTIFY OFF
[2026-08-19 01:34:15] [INFO] SYS(2335, 0)
[2026-08-19 01:34:15] [INFO] 
[2026-08-19 01:34:15] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:34:15] [INFO] QUIT
[2026-08-19 01:34:15] [INFO] 
[2026-08-19 01:34:15] [INFO] === Fim do Wrapper.prg ===
[2026-08-19 01:34:15] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-19 01:35:16] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-19 01:35:16] [INFO] Config FPW: (nao fornecido)
[2026-08-19 01:35:16] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:35:16] [INFO] Timeout: 300 segundos
[2026-08-19 01:35:16] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fpfjk2al.prg
[2026-08-19 01:35:16] [INFO] Conteudo do wrapper:
[2026-08-19 01:35:16] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
QUIT

[2026-08-19 01:35:16] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fpfjk2al.prg
[2026-08-19 01:35:16] [INFO] VFP output esperado em: C:\4c\tasks\task462\vfp_output.txt
[2026-08-19 01:35:16] [INFO] Executando Visual FoxPro 9...
[2026-08-19 01:35:16] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fpfjk2al.prg
[2026-08-19 01:35:16] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fpfjk2al.prg
[2026-08-19 01:35:16] [INFO] Timeout configurado: 300 segundos
[2026-08-19 01:36:34] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-19 01:36:34] [INFO] VFP9 finalizado em 78.2858326 segundos
[2026-08-19 01:36:34] [INFO] Exit Code: 
[2026-08-19 01:36:34] [INFO] 
[2026-08-19 01:36:34] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-19 01:36:34] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fpfjk2al.prg
[2026-08-19 01:36:34] [INFO] 
[2026-08-19 01:36:34] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-19 01:36:34] [INFO] * Auto-generated wrapper for parameters
[2026-08-19 01:36:34] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:36:34] [INFO] * Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:36:34] [INFO] 
[2026-08-19 01:36:34] [INFO] * Anti-dialog protections for unattended execution
[2026-08-19 01:36:34] [INFO] SET SAFETY OFF
[2026-08-19 01:36:34] [INFO] SET RESOURCE OFF
[2026-08-19 01:36:34] [INFO] SET TALK OFF
[2026-08-19 01:36:34] [INFO] SET NOTIFY OFF
[2026-08-19 01:36:34] [INFO] SYS(2335, 0)
[2026-08-19 01:36:34] [INFO] 
[2026-08-19 01:36:34] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:36:34] [INFO] QUIT
[2026-08-19 01:36:34] [INFO] 
[2026-08-19 01:36:34] [INFO] === Fim do Wrapper.prg ===
[2026-08-19 01:36:34] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-19 01:37:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-19 01:37:36] [INFO] Config FPW: (nao fornecido)
[2026-08-19 01:37:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:37:36] [INFO] Timeout: 300 segundos
[2026-08-19 01:37:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xeetcqyw.prg
[2026-08-19 01:37:36] [INFO] Conteudo do wrapper:
[2026-08-19 01:37:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
QUIT

[2026-08-19 01:37:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xeetcqyw.prg
[2026-08-19 01:37:36] [INFO] VFP output esperado em: C:\4c\tasks\task462\vfp_output.txt
[2026-08-19 01:37:36] [INFO] Executando Visual FoxPro 9...
[2026-08-19 01:37:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xeetcqyw.prg
[2026-08-19 01:37:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xeetcqyw.prg
[2026-08-19 01:37:36] [INFO] Timeout configurado: 300 segundos
[2026-08-19 01:38:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-19 01:38:55] [INFO] VFP9 finalizado em 78.3838202 segundos
[2026-08-19 01:38:55] [INFO] Exit Code: 
[2026-08-19 01:38:55] [INFO] 
[2026-08-19 01:38:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-19 01:38:55] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xeetcqyw.prg
[2026-08-19 01:38:55] [INFO] 
[2026-08-19 01:38:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-19 01:38:55] [INFO] * Auto-generated wrapper for parameters
[2026-08-19 01:38:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:38:55] [INFO] * Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:38:55] [INFO] 
[2026-08-19 01:38:55] [INFO] * Anti-dialog protections for unattended execution
[2026-08-19 01:38:55] [INFO] SET SAFETY OFF
[2026-08-19 01:38:55] [INFO] SET RESOURCE OFF
[2026-08-19 01:38:55] [INFO] SET TALK OFF
[2026-08-19 01:38:55] [INFO] SET NOTIFY OFF
[2026-08-19 01:38:55] [INFO] SYS(2335, 0)
[2026-08-19 01:38:55] [INFO] 
[2026-08-19 01:38:55] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:38:55] [INFO] QUIT
[2026-08-19 01:38:55] [INFO] 
[2026-08-19 01:38:55] [INFO] === Fim do Wrapper.prg ===
[2026-08-19 01:38:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-19 01:39:59] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-19 01:39:59] [INFO] Config FPW: (nao fornecido)
[2026-08-19 01:39:59] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:39:59] [INFO] Timeout: 300 segundos
[2026-08-19 01:39:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4v1cvxxq.prg
[2026-08-19 01:39:59] [INFO] Conteudo do wrapper:
[2026-08-19 01:39:59] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
QUIT

[2026-08-19 01:39:59] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4v1cvxxq.prg
[2026-08-19 01:39:59] [INFO] VFP output esperado em: C:\4c\tasks\task462\vfp_output.txt
[2026-08-19 01:39:59] [INFO] Executando Visual FoxPro 9...
[2026-08-19 01:39:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4v1cvxxq.prg
[2026-08-19 01:39:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4v1cvxxq.prg
[2026-08-19 01:40:00] [INFO] Timeout configurado: 300 segundos
[2026-08-19 01:41:18] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-19 01:41:18] [INFO] VFP9 finalizado em 78.3155835 segundos
[2026-08-19 01:41:18] [INFO] Exit Code: 
[2026-08-19 01:41:18] [INFO] 
[2026-08-19 01:41:18] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-19 01:41:18] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4v1cvxxq.prg
[2026-08-19 01:41:18] [INFO] 
[2026-08-19 01:41:18] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-19 01:41:18] [INFO] * Auto-generated wrapper for parameters
[2026-08-19 01:41:18] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 01:41:18] [INFO] * Parameters: 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:41:18] [INFO] 
[2026-08-19 01:41:18] [INFO] * Anti-dialog protections for unattended execution
[2026-08-19 01:41:18] [INFO] SET SAFETY OFF
[2026-08-19 01:41:18] [INFO] SET RESOURCE OFF
[2026-08-19 01:41:18] [INFO] SET TALK OFF
[2026-08-19 01:41:18] [INFO] SET NOTIFY OFF
[2026-08-19 01:41:18] [INFO] SYS(2335, 0)
[2026-08-19 01:41:18] [INFO] 
[2026-08-19 01:41:18] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMda', 'C:\4c\tasks\task462', 'CRUD'
[2026-08-19 01:41:18] [INFO] QUIT
[2026-08-19 01:41:18] [INFO] 
[2026-08-19 01:41:18] [INFO] === Fim do Wrapper.prg ===
[2026-08-19 01:41:18] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormMda",
  "timestamp": "20260819014118",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMda.prg):
*==============================================================================
* FormMda.prg - Formulario de Cadastro de Motivos de Desconto / Acrescimo
* Migrado de: SigCdMda.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormMda AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    *-- Caption setado via CHR() em InicializarForm (CLAUDE.md: sem acentos literais em .PRG)
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
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
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
            THIS.Caption = "Cadastro de Motivos de Desconto / Acr" + CHR(233) + "scimo"
            THIS.this_oBusinessObject = CREATEOBJECT("MdaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar MdaBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormMda.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormMda:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormMda.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles dentro das Pages compensam +29 no Top
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
    * ConfigurarPaginaLista - Page1: Cabecalho + container botoes CRUD + Encerrar
    * Grid e botoes CRUD adicionados na Fase 4
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Cabecalho (cntSombra no legado)
        * Original: Top=1. Com compensacao PageFrame +29: Top=31
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container Botoes CRUD (Grupo_op no legado)
        * Original: Left=538, Top=-1. Canonico: Left=542, Top=29
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Container Saida - PADRAO CANONICO (CLAUDE.md Regra #10)
        * Left=917, Top=29 (0+29 compensacao), Width=90, Height=85
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Grid de Lista - colunas: Codigos(80), Descrs(290), Tipos(40)
        * Top = 117 (88 padrao framework + 29 compensacao PageFrame)
        * ColumnCount e RecordSource FORA de WITH (Problema 36/48)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
        loc_oPagina.grd_4c_Lista.RecordSource = ""

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista.Column1
            .Width     = 80
            .Alignment = 0
            .Header1.Caption = ""
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista.Column2
            .Width     = 290
            .Alignment = 0
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista.Column3
            .Width     = 40
            .Alignment = 2
            .Header1.Caption = ""
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: container botoes acao (Confirmar/Cancelar)
    * Campos e grids de dados adicionados nas Fases 4-6
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container BotoesAcao - Confirmar / Cancelar
        * Grupo_Salva no legado: Top=4. Com compensacao +29: Top=33
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * FASE 5: Campos escalares da Page2
        * Tops = valor_original_SCX + 29 (compensacao PageFrame.Top=-29)
        *----------------------------------------------------------------------

        *-- Linha 1: Codigo (Top=121->150) + Tipos (Top=121->150)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 153
            .Left      = 125
            .Width     = 42
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value     = ""
            .Top       = 150
            .Left      = 171
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Tipos :"
            .Top       = 153
            .Left      = 258
            .Width     = 34
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
        WITH loc_oPagina.txt_4c_Tipos
            .Value     = "D"
            .Top       = 150
            .Left      = 300
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "< D >esconto  < A >cr" + CHR(233) + "scimo"
            .Top       = 147
            .Left      = 323
            .Width     = 85
            .Height    = 30
            .AutoSize  = .F.
            .WordWrap  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 2: Descricao (Top=145->174)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 177
            .Left      = 112
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value     = ""
            .Top       = 174
            .Left      = 171
            .Width     = 290
            .Height    = 23
            .MaxLength = 50
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Linha 3: Bloquear Desconto BIN - Optiongroup12 (Top=169->198)
        loc_oPagina.AddObject("lbl_4c_Label58", "Label")
        WITH loc_oPagina.lbl_4c_Label58
            .Caption   = "Bloquear Desconto BIN :"
            .Top       = 200
            .Left      = 48
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Optiongroup12", "OptionGroup")
        WITH loc_oPagina.opt_4c_Optiongroup12
            .ButtonCount = 2
            .Top         = 198
            .Left        = 171
            .Width       = 97
            .Height      = 20
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup12.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup12.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 47
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Linha 4: Nao Gerar Bonus - Optiongroup1 (Top=191->220)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "N" + CHR(227) + "o Gerar Bonus:"
            .Top       = 222
            .Left      = 80
            .Width     = 90
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Optiongroup1", "OptionGroup")
        WITH loc_oPagina.opt_4c_Optiongroup1
            .ButtonCount = 2
            .Top         = 220
            .Left        = 171
            .Width       = 97
            .Height      = 20
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup1.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup1.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 47
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Linha 5: Bloquear Tab.Desconto - Optiongroup2 (Top=213->242)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Bloquear Tab.Desconto :"
            .Top       = 244
            .Left      = 46
            .Width     = 125
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Optiongroup2", "OptionGroup")
        WITH loc_oPagina.opt_4c_Optiongroup2
            .ButtonCount = 2
            .Top         = 242
            .Left        = 171
            .Width       = 97
            .Height      = 20
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup2.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup2.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 47
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Linha 6: Periodo (PerInis Top=235->264, PerFins Top=235->264)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 267
            .Left      = 122
            .Width     = 50
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PerInis", "TextBox")
        WITH loc_oPagina.txt_4c_PerInis
            .Value    = {}
            .Top      = 264
            .Left     = 171
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Separador "a" entre PerInis e PerFins (Top=239->268)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "a"
            .Top       = 268
            .Left      = 257
            .Width     = 8
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PerFins", "TextBox")
        WITH loc_oPagina.txt_4c_PerFins
            .Value    = {}
            .Top      = 264
            .Left     = 269
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Linha 7: Grande Grupo (Top=260->289) + SubGrupo (Top=260->289) com lookup
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Gde Grupo :"
            .Top       = 292
            .Left      = 107
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GGrus", "TextBox")
        WITH loc_oPagina.txt_4c_GGrus
            .Value     = ""
            .Top       = 289
            .Left      = 171
            .Width     = 35
            .Height    = 23
            .MaxLength = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "SubGrupo :"
            .Top       = 292
            .Left      = 226
            .Width     = 56
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SGrus", "TextBox")
        WITH loc_oPagina.txt_4c_SGrus
            .Value     = ""
            .Top       = 289
            .Left      = 294
            .Width     = 55
            .Height    = 23
            .MaxLength = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_GGrus, "KeyPress", THIS, "ValidarGGrus")
        BINDEVENT(loc_oPagina.txt_4c_SGrus, "KeyPress", THIS, "ValidarSGrus")

        *-- Linha 8: Tipo de Desconto - OptTpDescs (Top=282->311)
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "Tipo de Desconto :"
            .Top       = 315
            .Left      = 75
            .Width     = 95
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_OptTpDescs", "OptionGroup")
        WITH loc_oPagina.opt_4c_OptTpDescs
            .ButtonCount = 2
            .Top         = 311
            .Left        = 171
            .Width       = 152
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_OptTpDescs.Buttons(1)
            .Caption   = "Geral"
            .Left      = 5
            .Top       = 5
            .Width     = 43
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_OptTpDescs.Buttons(2)
            .Caption   = "por Produto"
            .Left      = 67
            .Top       = 5
            .Width     = 75
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Linha 9: Limite de Desconto (Top=307->336)
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "Limite de Desconto :"
            .Top       = 339
            .Left      = 68
            .Width     = 99
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_LimDescs", "TextBox")
        WITH loc_oPagina.txt_4c_LimDescs
            .Value     = 0
            .Top       = 336
            .Left      = 171
            .Width     = 55
            .Height    = 23
            .InputMask = "99.99"
            .MaxLength = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Linha 10: Checar Dt. Aniversario - Optiongroup3 (Top=332->361)
        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Caption   = "Checar Dt. Anivers" + CHR(225) + "rio :"
            .Top       = 363
            .Left      = 49
            .Width     = 125
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Optiongroup3", "OptionGroup")
        WITH loc_oPagina.opt_4c_Optiongroup3
            .ButtonCount = 2
            .Top         = 361
            .Left        = 171
            .Width       = 97
            .Height      = 20
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup3.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Optiongroup3.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 47
            .Top       = 1
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Operacoes" (Say8 legado: Top=124+29=153, Left=508)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es"
            .Top       = 153
            .Left      = 508
            .Width     = 100
            .Height    = 13
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Empresas" (Say7 legado: Top=359+29=388, Left=61)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Empresas"
            .Top       = 388
            .Left      = 61
            .Width     = 60
            .Height    = 13
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Composicao" (Say13 legado: Top=359+29=388, Left=431)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
            .Top       = 388
            .Left      = 431
            .Width     = 80
            .Height    = 13
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Grid Operacoes (grdOpers legado: Top=141+29=170, Left=508, W=199, H=207)
        * Col1: CheckBox/Imps (W=20), Col2: Text/Dopes (W=170)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Opers", "Grid")
        WITH loc_oPagina.grd_4c_Opers
            .Top         = 170
            .Left        = 508
            .Width       = 199
            .Height      = 207
            .ColumnCount = 2
            .FontName    = "Tahoma"
            .FontSize    = 8
            .GridLines   = 2
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .ScrollBars  = 2
            .ReadOnly    = .F.
            .Visible     = .T.
        ENDWITH

        *-- Column1: CheckBox para Imps (RecordSource/ControlSource set em CarregarRelacionados)
        WITH loc_oPagina.grd_4c_Opers.Column1
            .Width     = 20
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Sparse    = .F.
        ENDWITH
        loc_oPagina.grd_4c_Opers.Column1.Header1.Caption   = ""
        loc_oPagina.grd_4c_Opers.Column1.Header1.Alignment = 2
        loc_oPagina.grd_4c_Opers.Column1.AddObject("Check1", "CheckBox")
        WITH loc_oPagina.grd_4c_Opers.Column1.Check1
            .Caption   = ""
            .Alignment = 0
            .ReadOnly  = .F.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH
        loc_oPagina.grd_4c_Opers.Column1.CurrentControl = "Check1"

        *-- Column2: Descricao da Operacao (Dopes) - ReadOnly
        WITH loc_oPagina.grd_4c_Opers.Column2
            .Width     = 170
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        loc_oPagina.grd_4c_Opers.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"

        BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "MouseDown", THIS, "OperCheckboxMouseDown")
        BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "MouseUp",   THIS, "OperCheckboxMouseUp")
        BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "Click",     THIS, "OperCheckboxClick")
        BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "KeyPress",  THIS, "OperCheckboxKeyPress")

        *----------------------------------------------------------------------
        * Container botoes MarcaTodos/DesmarcaTodos Operacoes
        * (Commandgroup1 legado: Top=157+29=186, Left=708, W=50, H=90)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_CmdOpers", "Container")
        WITH loc_oPagina.cnt_4c_CmdOpers
            .Top         = 186
            .Left        = 708
            .Width       = 50
            .Height      = 90
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CmdOpers.AddObject("cmd_4c_MarcaOpers", "CommandButton")
        WITH loc_oPagina.cnt_4c_CmdOpers.cmd_4c_MarcaOpers
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Marcar todos"
            .Top             = 5
            .Left            = 5
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CmdOpers.AddObject("cmd_4c_DesmarcaOpers", "CommandButton")
        WITH loc_oPagina.cnt_4c_CmdOpers.cmd_4c_DesmarcaOpers
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Desmarcar todos"
            .Top             = 45
            .Left            = 5
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_CmdOpers.cmd_4c_MarcaOpers,    "Click", THIS, "MarcaTodosOpersClick")
        BINDEVENT(loc_oPagina.cnt_4c_CmdOpers.cmd_4c_DesmarcaOpers, "Click", THIS, "DesmarcaTodosOpersClick")

        *----------------------------------------------------------------------
        * Grid Empresas (grdEmps legado: Top=376+29=405, Left=59, W=276, H=207)
        * Col1: CheckBox/Imps (W=20), Col2: Text/Emps (W=30), Col3: Text/Razas (W=200)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Emps", "Grid")
        WITH loc_oPagina.grd_4c_Emps
            .Top         = 405
            .Left        = 59
            .Width       = 276
            .Height      = 207
            .ColumnCount = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .GridLines   = 2
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .ScrollBars  = 2
            .ReadOnly    = .F.
            .Visible     = .T.
        ENDWITH

        *-- Column1: CheckBox para Imps
        WITH loc_oPagina.grd_4c_Emps.Column1
            .Width     = 20
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Sparse    = .F.
        ENDWITH
        loc_oPagina.grd_4c_Emps.Column1.Header1.Caption   = ""
        loc_oPagina.grd_4c_Emps.Column1.Header1.Alignment = 2
        loc_oPagina.grd_4c_Emps.Column1.AddObject("check12", "CheckBox")
        WITH loc_oPagina.grd_4c_Emps.Column1.check12
            .Caption   = ""
            .Alignment = 0
            .ReadOnly  = .F.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH
        loc_oPagina.grd_4c_Emps.Column1.CurrentControl = "Check1"

        *-- Column2: Codigo empresa (Emps) - ReadOnly
        WITH loc_oPagina.grd_4c_Emps.Column2
            .Width     = 30
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        loc_oPagina.grd_4c_Emps.Column2.Header1.Caption = "Emp."

        *-- Column3: Razao social (Razas) - ReadOnly
        WITH loc_oPagina.grd_4c_Emps.Column3
            .Width     = 200
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        loc_oPagina.grd_4c_Emps.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

        BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "MouseDown", THIS, "EmpCheckboxMouseDown")
        BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "MouseUp",   THIS, "EmpCheckboxMouseUp")
        BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "Click",     THIS, "EmpCheckboxClick")
        BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "KeyPress",  THIS, "EmpCheckboxKeyPress")

        *----------------------------------------------------------------------
        * Container botoes MarcaTodos/DesmarcaTodos Empresas
        * (cmdEmps legado: Top=391+29=420, Left=336, W=50, H=90)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_CmdEmps", "Container")
        WITH loc_oPagina.cnt_4c_CmdEmps
            .Top         = 420
            .Left        = 336
            .Width       = 50
            .Height      = 90
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CmdEmps.AddObject("cmd_4c_MarcaEmps", "CommandButton")
        WITH loc_oPagina.cnt_4c_CmdEmps.cmd_4c_MarcaEmps
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Marcar todos"
            .Top             = 5
            .Left            = 5
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CmdEmps.AddObject("cmd_4c_DesmarcaEmps", "CommandButton")
        WITH loc_oPagina.cnt_4c_CmdEmps.cmd_4c_DesmarcaEmps
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Desmarcar todos"
            .Top             = 45
            .Left            = 5
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_CmdEmps.cmd_4c_MarcaEmps,    "Click", THIS, "MarcaTodosEmpsClick")
        BINDEVENT(loc_oPagina.cnt_4c_CmdEmps.cmd_4c_DesmarcaEmps, "Click", THIS, "DesmarcaTodosEmpsClick")

        *----------------------------------------------------------------------
        * Grid Composicoes (GrdCompo legado: Top=376+29=405, Left=431, W=276, H=207)
        * Col1: Text/Compos editavel (W=244) com lookup
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Compo", "Grid")
        WITH loc_oPagina.grd_4c_Compo
            .Top         = 405
            .Left        = 431
            .Width       = 276
            .Height      = 207
            .ColumnCount = 1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .GridLines   = 2
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .ScrollBars  = 2
            .ReadOnly    = .F.
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.grd_4c_Compo.Column1
            .Width     = 244
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"

        BINDEVENT(loc_oPagina.grd_4c_Compo.Column1.Text1, "Valid", THIS, "CompoTextValid")

        *----------------------------------------------------------------------
        * Botao Inserir Composicao (cmdInserir legado: Top=397+29=426, Left=712, 40x40)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_InserirCompo", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirCompo
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Inserir composi" + CHR(231) + CHR(227) + "o"
            .Top             = 426
            .Left            = 712
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Botao Excluir Composicao (cmdExcluir legado: Top=437+29=466, Left=712, 40x40)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_ExcluirCompo", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirCompo
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Excluir composi" + CHR(231) + CHR(227) + "o"
            .Top             = 466
            .Left            = 712
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cmd_4c_InserirCompo, "Click", THIS, "CompoInserirClick")
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirCompo, "Click", THIS, "CompoExcluirClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega grid de lista da Page1
    * Fase 4 adiciona o grid e implementa a carga completa de dados
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.Buscar("")
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        *-- RecordSource FORA de WITH (Problema 36/48)
                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource = "cursor_4c_Dados"

                        *-- ControlSource SEMPRE apos RecordSource (Problema 48)
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"

                        loc_oGrid.Column1.Width     = 80
                        loc_oGrid.Column2.Width     = 290
                        loc_oGrid.Column3.Width     = 40
                        loc_oGrid.Column1.Alignment = 0
                        loc_oGrid.Column2.Alignment = 0
                        loc_oGrid.Column3.Alignment = 2

                        *-- Headers OBRIGATORIO apos RecordSource (Problema 6/32)
                        loc_oGrid.Column1.Header1.Caption = ""
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = ""

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_oGrid.Refresh()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "FormMda.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md Regra BINDEVENT)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva registro (implementado na Fase 7)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Transferir campos do form para o BO (Problema 16 - validacao ANTES do TRY)
        THIS.FormParaBO()

        IF EMPTY(THIS.this_oBusinessObject.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo do motivo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
            ENDIF
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(THIS.this_oBusinessObject.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o do motivo " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descrs", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
            ENDIF
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(THIS.this_oBusinessObject.this_cTipos) OR ;
           !INLIST(THIS.this_oBusinessObject.this_cTipos, "D", "A")
            MsgAviso("Tipo deve ser 'D' (Desconto) ou 'A' (Acr" + CHR(233) + "scimo).", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Tipos", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus
            ENDIF
            RETURN loc_lResultado
        ENDIF

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Salvar()
                    *-- Salvar relacionados quando cursores existirem (habilitado em Fase 6+)
                    IF USED("cursor_4c_Emps") OR USED("cursor_4c_Opers") OR USED("cursor_4c_Compos")
                        THIS.this_oBusinessObject.SalvarRelacionados( ;
                            THIS.this_oBusinessObject.this_cCodigos, ;
                            "cursor_4c_Emps", ;
                            "cursor_4c_Opers", ;
                            "cursor_4c_Compos")
                    ENDIF
                    MsgInfo("Registro salvo com sucesso!")
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
                "FormMda.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ELSE
                    THIS.AjustarBotoesPorModo()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormMda.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara novo registro para inclusao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.CarregarRelacionados("")
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    * PUBLIC: BINDEVENT requer metodo publico (tambem vinculado ao DblClick do grid)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.CarregarRelacionados(loc_cCodigo)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para alteracao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.CarregarRelacionados(loc_cCodigo)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
            loc_cDescricao = ALLTRIM(cursor_4c_Dados.descrs)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do motivo:" + CHR(13) + ;
                loc_cCodigo + " - " + loc_cDescricao + "?", ;
                "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre busca para filtrar registros na lista
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_oGrid
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdFs", "cursor_4c_BuscaMda", "codigos", "", ;
                "Buscar Motivo de Desconto / Acr" + CHR(233) + "scimo")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("tipos",   "", "Tipo")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMda")
                    SELECT cursor_4c_BuscaMda
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaMda.codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
                "FormMda.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaMda")
            USE IN cursor_4c_BuscaMda
        ENDIF

        IF !EMPTY(loc_cCodigo)
            IF THIS.this_oBusinessObject.Buscar("codigos = " + EscaparSQL(loc_cCodigo))
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
                loc_oGrid.Column1.Header1.Caption = ""
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = ""
                loc_oGrid.Refresh()
            ENDIF
        ELSE
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos de Page2 para o BO
    * Controles verificados com PEMSTATUS para compatibilidade multi-fase
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
            THIS.this_oBusinessObject.this_cTipos = ALLTRIM(loc_oPagina.txt_4c_Tipos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
            THIS.this_oBusinessObject.this_nLimdescs = loc_oPagina.txt_4c_LimDescs.Value
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
            THIS.this_oBusinessObject.this_dPerinis = loc_oPagina.txt_4c_PerInis.Value
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
            THIS.this_oBusinessObject.this_dPerfins = loc_oPagina.txt_4c_PerFins.Value
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
            THIS.this_oBusinessObject.this_cGgrus = ALLTRIM(loc_oPagina.txt_4c_GGrus.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
            THIS.this_oBusinessObject.this_cSgrus = ALLTRIM(loc_oPagina.txt_4c_SGrus.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
            THIS.this_oBusinessObject.this_nChkbins = IIF(loc_oPagina.opt_4c_Optiongroup12.Value = 1, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
            THIS.this_oBusinessObject.this_nBlqbonus = IIF(loc_oPagina.opt_4c_Optiongroup1.Value = 1, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
            THIS.this_oBusinessObject.this_nBlqtabds = IIF(loc_oPagina.opt_4c_Optiongroup2.Value = 1, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
            THIS.this_oBusinessObject.this_nChkdtanivs = IIF(loc_oPagina.opt_4c_Optiongroup3.Value = 1, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
            THIS.this_oBusinessObject.this_nTpdescs = loc_oPagina.opt_4c_OptTpDescs.Value - 1
        ENDIF
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos de Page2
    * Controles verificados com PEMSTATUS para compatibilidade multi-fase
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_cCodigos
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.Value = THIS.this_oBusinessObject.this_cDescrs
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
            loc_oPagina.txt_4c_Tipos.Value = THIS.this_oBusinessObject.this_cTipos
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
            loc_oPagina.txt_4c_LimDescs.Value = THIS.this_oBusinessObject.this_nLimdescs
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
            loc_oPagina.txt_4c_PerInis.Value = THIS.this_oBusinessObject.this_dPerinis
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
            loc_oPagina.txt_4c_PerFins.Value = THIS.this_oBusinessObject.this_dPerfins
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
            loc_oPagina.txt_4c_GGrus.Value = THIS.this_oBusinessObject.this_cGgrus
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
            loc_oPagina.txt_4c_SGrus.Value = THIS.this_oBusinessObject.this_cSgrus
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
            loc_oPagina.opt_4c_Optiongroup12.Value = IIF(THIS.this_oBusinessObject.this_nChkbins = 1, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
            loc_oPagina.opt_4c_Optiongroup1.Value = IIF(THIS.this_oBusinessObject.this_nBlqbonus = 1, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
            loc_oPagina.opt_4c_Optiongroup2.Value = IIF(THIS.this_oBusinessObject.this_nBlqtabds = 1, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
            loc_oPagina.opt_4c_Optiongroup3.Value = IIF(THIS.this_oBusinessObject.this_nChkdtanivs = 1, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
            loc_oPagina.opt_4c_OptTpDescs.Value = THIS.this_oBusinessObject.this_nTpdescs + 1
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos editaveis de Page2
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEditar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = (par_lHabilitar = .T.)

        *-- Codigo: editavel apenas no INCLUIR
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.ReadOnly = !(loc_lEditar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
            loc_oPagina.txt_4c_Tipos.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
            loc_oPagina.txt_4c_LimDescs.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
            loc_oPagina.txt_4c_PerInis.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
            loc_oPagina.txt_4c_PerFins.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
            loc_oPagina.txt_4c_GGrus.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
            loc_oPagina.txt_4c_SGrus.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
            loc_oPagina.opt_4c_Optiongroup12.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
            loc_oPagina.opt_4c_Optiongroup1.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
            loc_oPagina.opt_4c_Optiongroup2.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
            loc_oPagina.opt_4c_Optiongroup3.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
            loc_oPagina.opt_4c_OptTpDescs.Enabled = loc_lEditar
        ENDIF

        *-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
            ENDIF
        ENDIF

        *-- Grids e botoes de relacionados: editaveis apenas em INCLUIR/ALTERAR
        IF PEMSTATUS(loc_oPagina, "cnt_4c_CmdOpers", 5)
            loc_oPagina.cnt_4c_CmdOpers.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "cnt_4c_CmdEmps", 5)
            loc_oPagina.cnt_4c_CmdEmps.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirCompo", 5)
            loc_oPagina.cmd_4c_InserirCompo.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirCompo", 5)
            loc_oPagina.cmd_4c_ExcluirCompo.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
            loc_oPagina.grd_4c_Compo.ReadOnly = !loc_lEditar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos de Page2 para novo registro
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
            loc_oPagina.txt_4c_Tipos.Value = "D"
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
            loc_oPagina.txt_4c_LimDescs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
            loc_oPagina.txt_4c_PerInis.Value = {}
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
            loc_oPagina.txt_4c_PerFins.Value = {}
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
            loc_oPagina.txt_4c_GGrus.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
            loc_oPagina.txt_4c_SGrus.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
            loc_oPagina.opt_4c_Optiongroup12.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
            loc_oPagina.opt_4c_Optiongroup1.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
            loc_oPagina.opt_4c_Optiongroup2.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
            loc_oPagina.opt_4c_Optiongroup3.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
            loc_oPagina.opt_4c_OptTpDescs.Value = 1
        ENDIF

        *-- Limpar cursores dos grids relacionados (recarregados em CarregarRelacionados)
        IF USED("cursor_4c_Emps")
            REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
            IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5)
                loc_oPagina.grd_4c_Emps.Refresh()
            ENDIF
        ENDIF
        IF USED("cursor_4c_Opers")
            REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
            IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5)
                loc_oPagina.grd_4c_Opers.Refresh()
            ENDIF
        ENDIF
        IF USED("cursor_4c_Compos")
            ZAP IN cursor_4c_Compos
            IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
                loc_oPagina.grd_4c_Compo.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo atual
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarTipos - Valida campo Tipo (D=Desconto, A=Acrescimo)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarTipos
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cTipo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
            RETURN
        ENDIF

        loc_cTipo = UPPER(ALLTRIM(loc_oPagina.txt_4c_Tipos.Value))

        IF EMPTY(loc_cTipo)
            RETURN
        ENDIF

        IF !INLIST(loc_cTipo, "D", "A")
            MsgAviso("Tipo deve ser 'D' (Desconto) ou 'A' (Acr" + CHR(233) + "scimo).", ;
                "Tipo Inv" + CHR(225) + "lido")
            loc_oPagina.txt_4c_Tipos.Value = ""
            loc_oPagina.txt_4c_Tipos.SetFocus
            RETURN
        ENDIF

        loc_oPagina.txt_4c_Tipos.Value = loc_cTipo
    ENDPROC

    *===========================================================================
    * ValidarGGrus - Valida codigo Grande Grupo (SigCdGpr)
    * Se nao encontrado exato, abre picker FormBuscaAuxiliar (Pattern A canonico)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarGGrus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_cCod, loc_nRows, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
            RETURN
        ENDIF

        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_GGrus.Value)

        IF EMPTY(loc_cCod)
            RETURN
        ENDIF

        TRY
            loc_nRows = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_BuscaGGrus")

            IF loc_nRows > 0 AND USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
                loc_oPagina.txt_4c_GGrus.Value = ALLTRIM(cursor_4c_BuscaGGrus.codigos)
                IF USED("cursor_4c_BuscaGGrus")
                    USE IN cursor_4c_BuscaGGrus
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaGGrus")
                    USE IN cursor_4c_BuscaGGrus
                ENDIF

                *-- Nao encontrado exato: busca parcial para picker
                loc_nRows = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descs FROM SigCdGpr WHERE codigos LIKE " + ;
                    EscaparSQL(loc_cCod + "%") + " ORDER BY codigos", ;
                    "cursor_4c_BuscaGGrus")

                IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaGGrus") OR EOF("cursor_4c_BuscaGGrus")
                    IF USED("cursor_4c_BuscaGGrus")
                        USE IN cursor_4c_BuscaGGrus
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
                        "cursor_4c_BuscaGGrus")
                ENDIF

                IF USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGGrus"
                        loc_oBusca.DefinirCursor("cursor_4c_BuscaGGrus", "codigos", "descs", ;
                            "Buscar Grande Grupo")
                        loc_oBusca.Mostrar()
                        IF loc_oBusca.this_lSelecionou
                            loc_oPagina.txt_4c_GGrus.Value = loc_oBusca.cCodigoSelecionado
                        ELSE
                            loc_oPagina.txt_4c_GGrus.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_GGrus.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaGGrus")
                    USE IN cursor_4c_BuscaGGrus
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Grande Grupo:" + CHR(13) + loException.Message, ;
                "FormMda.ValidarGGrus")
            IF USED("cursor_4c_BuscaGGrus")
                USE IN cursor_4c_BuscaGGrus
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarSGrus - Valida codigo SubGrupo (SigCdPsg)
    * Se nao encontrado exato, abre picker FormBuscaAuxiliar (Pattern A canonico)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarSGrus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_cCod, loc_nRows, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
            RETURN
        ENDIF

        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_SGrus.Value)

        IF EMPTY(loc_cCod)
            RETURN
        ENDIF

        TRY
            loc_nRows = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_BuscaSGrus")

            IF loc_nRows > 0 AND USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
                loc_oPagina.txt_4c_SGrus.Value = ALLTRIM(cursor_4c_BuscaSGrus.Codigos)
                IF USED("cursor_4c_BuscaSGrus")
                    USE IN cursor_4c_BuscaSGrus
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaSGrus")
                    USE IN cursor_4c_BuscaSGrus
                ENDIF

                *-- Nao encontrado exato: busca parcial para picker
                loc_nRows = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos LIKE " + ;
                    EscaparSQL(loc_cCod + "%") + " ORDER BY Codigos", ;
                    "cursor_4c_BuscaSGrus")

                IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaSGrus") OR EOF("cursor_4c_BuscaSGrus")
                    IF USED("cursor_4c_BuscaSGrus")
                        USE IN cursor_4c_BuscaSGrus
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
                        "cursor_4c_BuscaSGrus")
                ENDIF

                IF USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSGrus"
                        loc_oBusca.DefinirCursor("cursor_4c_BuscaSGrus", "Codigos", "Descricaos", ;
                            "Buscar SubGrupo")
                        loc_oBusca.Mostrar()
                        IF loc_oBusca.this_lSelecionou
                            loc_oPagina.txt_4c_SGrus.Value = loc_oBusca.cCodigoSelecionado
                        ELSE
                            loc_oPagina.txt_4c_SGrus.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_SGrus.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaSGrus")
                    USE IN cursor_4c_BuscaSGrus
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar SubGrupo:" + CHR(13) + loException.Message, ;
                "FormMda.ValidarSGrus")
            IF USED("cursor_4c_BuscaSGrus")
                USE IN cursor_4c_BuscaSGrus
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarRelacionados - Carrega grids de Emps, Opers e Compos via BO
    * Chamado apos BtnIncluir/Alterar/VisualizarClick com codigo do motivo
    *===========================================================================
    PROCEDURE CarregarRelacionados(par_cCodigos)
        LOCAL loc_lResultado, loc_oPagina, loc_oGrd
        loc_lResultado = .F.
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lResultado = loc_lResultado
            ENDIF

            THIS.this_oBusinessObject.CarregarEmpresas(par_cCodigos)
            THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)
            THIS.this_oBusinessObject.CarregarComposicoes(par_cCodigos)
            THIS.this_oBusinessObject.BuscarComposicoesProdutos()

            *-- Grid Operacoes
            IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5) AND USED("cursor_4c_Opers")
                loc_oGrd = loc_oPagina.grd_4c_Opers
                *-- RecordSource e ControlSource FORA de WITH (Problema 36/48)
                loc_oGrd.ColumnCount = 2
                loc_oGrd.RecordSource          = "cursor_4c_Opers"
                loc_oGrd.Column1.ControlSource = "cursor_4c_Opers.Imps"
                loc_oGrd.Column2.ControlSource = "cursor_4c_Opers.Dopes"
                *-- Headers OBRIGATORIO apos RecordSource (Problema 32)
                loc_oGrd.Column1.Header1.Caption = ""
                loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
                loc_oGrd.Refresh()
            ENDIF

            *-- Grid Empresas
            IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5) AND USED("cursor_4c_Emps")
                loc_oGrd = loc_oPagina.grd_4c_Emps
                loc_oGrd.ColumnCount = 3
                loc_oGrd.RecordSource          = "cursor_4c_Emps"
                loc_oGrd.Column1.ControlSource = "cursor_4c_Emps.Imps"
                loc_oGrd.Column2.ControlSource = "cursor_4c_Emps.Emps"
                loc_oGrd.Column3.ControlSource = "cursor_4c_Emps.Razas"
                loc_oGrd.Column1.Header1.Caption = ""
                loc_oGrd.Column2.Header1.Caption = "Emp."
                loc_oGrd.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Refresh()
            ENDIF

            *-- Grid Composicoes
            IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5) AND USED("cursor_4c_Compos")
                loc_oGrd = loc_oPagina.grd_4c_Compo
                loc_oGrd.ColumnCount = 1
                loc_oGrd.RecordSource          = "cursor_4c_Compos"
                loc_oGrd.Column1.ControlSource = "cursor_4c_Compos.Compos"
                loc_oGrd.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Refresh()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro("Erro ao carregar relacionados:" + CHR(13) + loException.Message, ;
                "FormMda.CarregarRelacionados")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * OperCheckboxMouseDown - Toggle Imps em cursor_4c_Opers via mouse
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE OperCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            NODEFAULT
            RETURN
        ENDIF
        IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
            SELECT cursor_4c_Opers
            REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
            ENDIF
        ENDIF
        NODEFAULT
    ENDPROC

    *===========================================================================
    * OperCheckboxMouseUp - Suprime comportamento padrao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE OperCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *===========================================================================
    * OperCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE OperCheckboxClick()
        NODEFAULT
    ENDPROC

    *===========================================================================
    * OperCheckboxKeyPress - Toggle Imps em cursor_4c_Opers via teclado
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE OperCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            NODEFAULT
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
                SELECT cursor_4c_Opers
                REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *===========================================================================
    * EmpCheckboxMouseDown - Toggle Imps em cursor_4c_Emps via mouse
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE EmpCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            NODEFAULT
            RETURN
        ENDIF
        IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
            SELECT cursor_4c_Emps
            REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
            ENDIF
        ENDIF
        NODEFAULT
    ENDPROC

    *===========================================================================
    * EmpCheckboxMouseUp - Suprime comportamento padrao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE EmpCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *===========================================================================
    * EmpCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE EmpCheckboxClick()
        NODEFAULT
    ENDPROC

    *===========================================================================
    * EmpCheckboxKeyPress - Toggle Imps em cursor_4c_Emps via teclado
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE EmpCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            NODEFAULT
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
                SELECT cursor_4c_Emps
                REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *===========================================================================
    * MarcaTodosOpersClick - Marca todas operacoes (Imps = .T.)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE MarcaTodosOpersClick()
        IF USED("cursor_4c_Opers")
            REPLACE ALL Imps WITH .T. IN cursor_4c_Opers
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * DesmarcaTodosOpersClick - Desmarca todas operacoes (Imps = .F.)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE DesmarcaTodosOpersClick()
        IF USED("cursor_4c_Opers")
            REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * MarcaTodosEmpsClick - Marca todas empresas (Imps = .T.)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE MarcaTodosEmpsClick()
        IF USED("cursor_4c_Emps")
            REPLACE ALL Imps WITH .T. IN cursor_4c_Emps
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * DesmarcaTodosEmpsClick - Desmarca todas empresas (Imps = .F.)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE DesmarcaTodosEmpsClick()
        IF USED("cursor_4c_Emps")
            REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * CompoInserirClick - Insere linha vazia em cursor_4c_Compos
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE CompoInserirClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !USED("cursor_4c_Compos")
            RETURN
        ENDIF

        SELECT cursor_4c_Compos
        APPEND BLANK
        REPLACE Compos WITH "" IN cursor_4c_Compos
        GO BOTTOM IN cursor_4c_Compos

        IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
            loc_oPagina.grd_4c_Compo.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * CompoExcluirClick - Exclui linha atual de cursor_4c_Compos
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE CompoExcluirClick()
        LOCAL loc_oPagina, loc_nRec
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos") OR ;
           RECCOUNT("cursor_4c_Compos") = 0
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Compos
            loc_nRec = RECNO("cursor_4c_Compos")

            *-- Rebuild writable cursor excluindo o registro atual
            IF USED("cursor_4c_CompoTemp")
                USE IN cursor_4c_CompoTemp
            ENDIF
            SELECT Compos FROM cursor_4c_Compos ;
                WHERE RECNO() != loc_nRec ;
                INTO CURSOR cursor_4c_CompoTemp READWRITE
            USE IN cursor_4c_Compos

            IF USED("cursor_4c_CompoTemp") AND RECCOUNT("cursor_4c_CompoTemp") > 0
                SELECT Compos FROM cursor_4c_CompoTemp ;
                    INTO CURSOR cursor_4c_Compos READWRITE
                USE IN cursor_4c_CompoTemp
                GO BOTTOM IN cursor_4c_Compos
            ELSE
                IF USED("cursor_4c_CompoTemp")
                    USE IN cursor_4c_CompoTemp
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Compos (Compos C(30))
                SET NULL OFF
            ENDIF

            IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
                loc_oPagina.grd_4c_Compo.ColumnCount = 1
                loc_oPagina.grd_4c_Compo.RecordSource          = "cursor_4c_Compos"
                loc_oPagina.grd_4c_Compo.Column1.ControlSource = "cursor_4c_Compos.Compos"
                loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
                loc_oPagina.grd_4c_Compo.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormMda.CompoExcluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CompoTextValid - Valida/busca composicao digitada em grd_4c_Compo
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE CompoTextValid()
        LOCAL loc_cCompo, loc_oBusca, loc_lOk
        loc_lOk = .T.

        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN loc_lOk
        ENDIF

        IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos")
            RETURN loc_lOk
        ENDIF

        loc_cCompo = ALLTRIM(cursor_4c_Compos.Compos)

        IF EMPTY(loc_cCompo)
            RETURN loc_lOk
        ENDIF

        IF !USED("cursor_4c_CsCompos") OR RECCOUNT("cursor_4c_CsCompos") = 0
            RETURN loc_lOk
        ENDIF

        TRY
            *-- Busca exata
            SELECT cursor_4c_CsCompos
            LOCATE FOR UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) = UPPER(loc_cCompo)

            IF !EOF("cursor_4c_CsCompos")
                *-- Encontrado: normaliza para forma canonica
                SELECT cursor_4c_Compos
                REPLACE Compos WITH ALLTRIM(cursor_4c_CsCompos.Compos) IN cursor_4c_Compos
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
                ENDIF
            ELSE
                *-- Nao encontrado: abre picker com filtro parcial
                SELECT cursor_4c_Compos

                IF USED("cursor_4c_BuscaCompo")
                    USE IN cursor_4c_BuscaCompo
                ENDIF

                SELECT Compos FROM cursor_4c_CsCompos ;
                    WHERE UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) LIKE "%" + UPPER(loc_cCompo) + "%" ;
                    ORDER BY cursor_4c_CsCompos.Compos ;
                    INTO CURSOR cursor_4c_BuscaCompo

                IF !USED("cursor_4c_BuscaCompo") OR EOF("cursor_4c_BuscaCompo")
                    IF USED("cursor_4c_BuscaCompo")
                        USE IN cursor_4c_BuscaCompo
                    ENDIF
                    SELECT Compos FROM cursor_4c_CsCompos ;
                        ORDER BY cursor_4c_CsCompos.Compos ;
                        INTO CURSOR cursor_4c_BuscaCompo
                ENDIF

                IF USED("cursor_4c_BuscaCompo") AND !EOF("cursor_4c_BuscaCompo")
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCompo"
                        loc_oBusca.DefinirCursor("cursor_4c_BuscaCompo", "Compos", "Compos", ;
                            "Buscar Composi" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Mostrar()
                        SELECT cursor_4c_Compos
                        IF loc_oBusca.this_lSelecionou
                            REPLACE Compos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado) IN cursor_4c_Compos
                        ELSE
                            REPLACE Compos WITH "" IN cursor_4c_Compos
                        ENDIF
                        loc_oBusca.Release()
                        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
                            THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
                        ENDIF
                    ENDIF
                ELSE
                    SELECT cursor_4c_Compos
                    REPLACE Compos WITH "" IN cursor_4c_Compos
                ENDIF

                IF USED("cursor_4c_BuscaCompo")
                    USE IN cursor_4c_BuscaCompo
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormMda.CompoTextValid")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages de PageFrames E Controls de Containers
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP
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
    * FormatarGridLista - Aplica formatacao visual padrao ao grid de lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaMda")
            USE IN cursor_4c_BuscaMda
        ENDIF

        IF USED("cursor_4c_Emps")
            USE IN cursor_4c_Emps
        ENDIF
        IF USED("cursor_4c_Opers")
            USE IN cursor_4c_Opers
        ENDIF
        IF USED("cursor_4c_Compos")
            USE IN cursor_4c_Compos
        ENDIF
        IF USED("cursor_4c_CsCompos")
            USE IN cursor_4c_CsCompos
        ENDIF
        IF USED("cursor_4c_BuscaCompo")
            USE IN cursor_4c_BuscaCompo
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\MdaBO.prg):
*==============================================================================
* MdaBO.prg - Business Object para Motivos de Desconto / Acrescimo
* Tabela principal: SigCdFs
* Tabelas relacionadas: SigCdFsi (empresas), SigCdFso (operacoes), SigCdFsc (composicoes)
*==============================================================================

DEFINE CLASS MdaBO AS BusinessBase

    *-- Propriedades da tabela SigCdFs
    this_cCodigos    = ""    && codigos char(10) PK
    this_cDescrs     = ""    && descrs char(40)
    this_cTipos      = ""    && tipos char(1) - "D"=Desconto, "A"=Acrescimo
    this_nBlqbonus   = 0     && blqbonus numeric(1,0) - nao gerar bonus (1=Sim, 0=Nao)
    this_nBlqtabds   = 0     && blqtabds numeric(1,0) - bloquear tab.desconto
    this_nChkbins    = 0     && chkbins numeric(1,0) - bloquear desconto BIN
    this_nChkdtanivs = 0     && chkdtanivs numeric(1,0) - checar data aniversario
    this_cGgrus      = ""    && ggrus char(3) - grande grupo
    this_nLimdescs   = 0     && limdescs numeric(5,2) - limite de desconto
    this_dPerfins    = {}    && perfins datetime NULL - periodo fim
    this_dPerinis    = {}    && perinis datetime NULL - periodo inicio
    this_cSgrus      = ""    && sgrus char(6) - sub-grupo
    this_nTpdescs    = 0     && tpdescs numeric(1,0) - tipo desconto (0=Geral, 1=por Produto)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFs"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Dados") = 0
                    SELECT 0 FROM cursor_4c_Dados WHERE .F. INTO CURSOR cursor_4c_Dados READWRITE
                ENDIF
                GO TOP IN cursor_4c_Dados
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar motivos de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       " chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       " perinis, sgrus, tpdescs" + ;
                       " FROM SigCdFs" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos,    "C"))
            THIS.this_cDescrs     = ALLTRIM(TratarNulo(descrs,     "C"))
            THIS.this_cTipos      = ALLTRIM(TratarNulo(tipos,      "C"))
            THIS.this_nBlqbonus   = TratarNulo(blqbonus,   "N")
            THIS.this_nBlqtabds   = TratarNulo(blqtabds,   "N")
            THIS.this_nChkbins    = TratarNulo(chkbins,    "N")
            THIS.this_nChkdtanivs = TratarNulo(chkdtanivs, "N")
            THIS.this_cGgrus      = ALLTRIM(TratarNulo(ggrus,  "C"))
            THIS.this_nLimdescs   = TratarNulo(limdescs,   "N")
            THIS.this_dPerfins    = TratarNulo(perfins,    "D")
            THIS.this_dPerinis    = TratarNulo(perinis,    "D")
            THIS.this_cSgrus      = ALLTRIM(TratarNulo(sgrus,  "C"))
            THIS.this_nTpdescs    = TratarNulo(tpdescs,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdFs" + ;
                       " (codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       "  chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       "  perinis, sgrus, tpdescs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqbonus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqtabds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkdtanivs) + ", " + ;
                       EscaparSQL(THIS.this_cGgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLimdescs) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + ", " + ;
                       EscaparSQL(THIS.this_cSgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdFs SET" + ;
                       "  descrs      = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       "  tipos       = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       "  blqbonus    = " + FormatarNumeroSQL(THIS.this_nBlqbonus) + "," + ;
                       "  blqtabds    = " + FormatarNumeroSQL(THIS.this_nBlqtabds) + "," + ;
                       "  chkbins     = " + FormatarNumeroSQL(THIS.this_nChkbins) + "," + ;
                       "  chkdtanivs  = " + FormatarNumeroSQL(THIS.this_nChkdtanivs) + "," + ;
                       "  ggrus       = " + EscaparSQL(THIS.this_cGgrus) + "," + ;
                       "  limdescs    = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
                       "  perfins     = " + IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + "," + ;
                       "  perinis     = " + IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + "," + ;
                       "  sgrus       = " + EscaparSQL(THIS.this_cSgrus) + "," + ;
                       "  tpdescs     = " + FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se motivo esta em uso em SigCdCmt/SigCdClc
            loc_cSQL = "SELECT b.Grupos, b.Codigos" + ;
                       " FROM SigCdCmt a, SigCdClc b" + ;
                       " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                       " AND a.fkChaves = b.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifUso")
            IF loc_nResult < 0
                MsgErro("Erro ao verificar uso do motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN cursor_4c_VerifUso
                IF !EOF("cursor_4c_VerifUso")
                    MsgErro("O Motivo Est" + CHR(225) + " Em Uso No Cadastro de Classifica" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + ;
                            "Grupo : " + ALLTRIM(cursor_4c_VerifUso.Grupos) + ;
                            " - C" + CHR(243) + "digo : " + ALLTRIM(cursor_4c_VerifUso.Codigos), ;
                            "Exclus" + CHR(227) + "o N" + CHR(227) + "o Permitida!!!")
                ELSE
                    *-- Excluir registros relacionados primeiro
                    loc_lSucesso = THIS.ExcluirRelacionados()
                    IF loc_lSucesso
                        loc_cSQL = "DELETE FROM SigCdFs WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
                        IF loc_nResult >= 0
                            THIS.RegistrarAuditoria("DELETE")
                        ELSE
                            MsgErro("Erro ao excluir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Delete")
                            USE IN cursor_4c_Delete
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_VerifUso")
            USE IN cursor_4c_VerifUso
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarRelacionados - Salva empresas, operacoes e composicoes do motivo
    * Par: par_cCodigos - codigo do motivo
    * Par: par_cCursorEmps - cursor com empresas selecionadas (csSigCdEmp)
    * Par: par_cCursorOpes - cursor com operacoes selecionadas (csSigCdOpe)
    * Par: par_cCursorCompo - cursor com composicoes (csSigPrCp)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarRelacionados(par_cCodigos, par_cCursorEmps, par_cCursorOpes, par_cCursorCompo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            *-- Deletar relacionamentos anteriores
            loc_lSucesso = THIS.ExcluirRelacionados()

            IF loc_lSucesso
                *-- Inserir empresas selecionadas em SigCdFsi
                IF USED(par_cCursorEmps)
                    SELECT (par_cCursorEmps)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsi (cIdChaves, Codigos, Emps)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Emps)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsEmp")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsEmp")
                                USE IN cursor_4c_InsEmp
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir operacoes selecionadas em SigCdFso
                IF loc_lSucesso AND USED(par_cCursorOpes)
                    SELECT (par_cCursorOpes)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFso (cIdChaves, Codigos, Dopes)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Dopes)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsOpe")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsOpe")
                                USE IN cursor_4c_InsOpe
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir composicoes em SigCdFsc
                IF loc_lSucesso AND USED(par_cCursorCompo)
                    SELECT (par_cCursorCompo)
                    GO TOP
                    SCAN
                        IF !EMPTY(ALLTRIM(Compos))
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsc (cIdChaves, Codigos, Compos)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Compos)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsCompo")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsCompo")
                                USE IN cursor_4c_InsCompo
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.SalvarRelacionados: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirRelacionados - Deleta SigCdFsi/SigCdFso/SigCdFsc pelo codigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExcluirRelacionados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFsi WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsi")
            IF USED("cursor_4c_DelFsi")
                USE IN cursor_4c_DelFsi
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFso WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFso")
                IF USED("cursor_4c_DelFso")
                    USE IN cursor_4c_DelFso
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFsc WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsc")
                IF USED("cursor_4c_DelFsc")
                    USE IN cursor_4c_DelFsc
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relacionamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExcluirRelacionados: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega empresas ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Emps com: Imps L, Emps C(3), Razas C(...)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, Cemps AS Emps, Razas" + ;
                       " FROM SigCdEmp" + ;
                       " WHERE NOT Ativas = 2" + ;
                       " ORDER BY Cemps"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emps")
            IF loc_nResult >= 0
                *-- Marcar empresas vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Emps FROM SigCdFsi WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsVinc") >= 0
                        SELECT cursor_4c_EmpsVinc
                        SCAN
                            UPDATE cursor_4c_Emps SET Imps = .T. WHERE Emps = ALLTRIM(cursor_4c_EmpsVinc.Emps)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_EmpsVinc")
                        USE IN cursor_4c_EmpsVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Emps
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarEmpresas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Opers com: Imps L, Dopes C(20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, a.Dopes" + ;
                       " FROM SigCdOpe a INNER JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                       " WHERE b.OpeInatvs <> 1" + ;
                       " ORDER BY a.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opers")
            IF loc_nResult >= 0
                *-- Marcar operacoes vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Dopes FROM SigCdFso WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpesVinc") >= 0
                        SELECT cursor_4c_OpesVinc
                        SCAN
                            UPDATE cursor_4c_Opers SET Imps = .T. WHERE Dopes = ALLTRIM(cursor_4c_OpesVinc.Dopes)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_OpesVinc")
                        USE IN cursor_4c_OpesVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Opers
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarOperacoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarComposicoes - Carrega composicoes vinculadas ao motivo para edicao
    * Popula cursor_4c_Compos (readwrite) com: Compos C(30)
    * Par: par_cCodigos - codigo do motivo (vazio = cursor vazio)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarComposicoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Compos")
                USE IN cursor_4c_Compos
            ENDIF

            IF EMPTY(par_cCodigos)
                *-- Cursor vazio para inclusao
                SET NULL ON
                CREATE CURSOR cursor_4c_Compos (Compos C(30))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Compos FROM SigCdFsc WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " ORDER BY Compos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Compos")
                IF loc_nResult >= 0
                    GO TOP IN cursor_4c_Compos
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarComposicoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComposicoesProdutos - Cursor de composicoes de SigCdPro para lookup
    * Popula cursor_4c_CsCompos com: Compos C(30)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComposicoesProdutos()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT Compos FROM SigCdPro ORDER BY Compos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsCompos")
            IF loc_nResult >= 0
                GO TOP IN cursor_4c_CsCompos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es de produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.BuscarComposicoesProdutos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Emps")
            USE IN cursor_4c_Emps
        ENDIF
        IF USED("cursor_4c_Opers")
            USE IN cursor_4c_Opers
        ENDIF
        IF USED("cursor_4c_Compos")
            USE IN cursor_4c_Compos
        ENDIF
        IF USED("cursor_4c_CsCompos")
            USE IN cursor_4c_CsCompos
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/08/2026 10:23:29 PM] FpbBO.CarregarBINs: Connection handle is invalid.Linha: 218Procedure: carregarbins


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-05 22:20:00] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-05 22:20:00] [INFO] Config FPW: (nao fornecido)
[2026-08-05 22:20:00] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 22:20:00] [INFO] Timeout: 300 segundos
[2026-08-05 22:20:00] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qglhq0js.prg
[2026-08-05 22:20:00] [INFO] Conteudo do wrapper:
[2026-08-05 22:20:00] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'
QUIT

[2026-08-05 22:20:00] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qglhq0js.prg
[2026-08-05 22:20:00] [INFO] VFP output esperado em: C:\4c\tasks\task423\vfp_output.txt
[2026-08-05 22:20:00] [INFO] Executando Visual FoxPro 9...
[2026-08-05 22:20:00] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qglhq0js.prg
[2026-08-05 22:20:00] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qglhq0js.prg
[2026-08-05 22:20:00] [INFO] Timeout configurado: 300 segundos
[2026-08-05 22:20:57] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-05 22:20:57] [INFO] VFP9 finalizado em 57.3591783 segundos
[2026-08-05 22:20:57] [INFO] Exit Code: 
[2026-08-05 22:20:57] [INFO] 
[2026-08-05 22:20:57] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-05 22:20:57] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qglhq0js.prg
[2026-08-05 22:20:57] [INFO] 
[2026-08-05 22:20:57] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-05 22:20:57] [INFO] * Auto-generated wrapper for parameters
[2026-08-05 22:20:57] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 22:20:57] [INFO] * Parameters: 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'
[2026-08-05 22:20:57] [INFO] 
[2026-08-05 22:20:57] [INFO] * Anti-dialog protections for unattended execution
[2026-08-05 22:20:57] [INFO] SET SAFETY OFF
[2026-08-05 22:20:57] [INFO] SET RESOURCE OFF
[2026-08-05 22:20:57] [INFO] SET TALK OFF
[2026-08-05 22:20:57] [INFO] SET NOTIFY OFF
[2026-08-05 22:20:57] [INFO] SYS(2335, 0)
[2026-08-05 22:20:57] [INFO] 
[2026-08-05 22:20:57] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'
[2026-08-05 22:20:57] [INFO] QUIT
[2026-08-05 22:20:57] [INFO] 
[2026-08-05 22:20:57] [INFO] === Fim do Wrapper.prg ===
[2026-08-05 22:20:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-05 22:22:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-05 22:22:25] [INFO] Config FPW: (nao fornecido)
[2026-08-05 22:22:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 22:22:25] [INFO] Timeout: 300 segundos
[2026-08-05 22:22:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3dxkf1vb.prg
[2026-08-05 22:22:25] [INFO] Conteudo do wrapper:
[2026-08-05 22:22:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'
QUIT

[2026-08-05 22:22:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3dxkf1vb.prg
[2026-08-05 22:22:25] [INFO] VFP output esperado em: C:\4c\tasks\task423\vfp_output.txt
[2026-08-05 22:22:25] [INFO] Executando Visual FoxPro 9...
[2026-08-05 22:22:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3dxkf1vb.prg
[2026-08-05 22:22:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3dxkf1vb.prg
[2026-08-05 22:22:25] [INFO] Timeout configurado: 300 segundos
[2026-08-05 22:23:29] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-05 22:23:29] [INFO] VFP9 finalizado em 63.2404773 segundos
[2026-08-05 22:23:29] [INFO] Exit Code: 
[2026-08-05 22:23:29] [INFO] 
[2026-08-05 22:23:29] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-05 22:23:29] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3dxkf1vb.prg
[2026-08-05 22:23:29] [INFO] 
[2026-08-05 22:23:29] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-05 22:23:29] [INFO] * Auto-generated wrapper for parameters
[2026-08-05 22:23:29] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 22:23:29] [INFO] * Parameters: 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'
[2026-08-05 22:23:29] [INFO] 
[2026-08-05 22:23:29] [INFO] * Anti-dialog protections for unattended execution
[2026-08-05 22:23:29] [INFO] SET SAFETY OFF
[2026-08-05 22:23:29] [INFO] SET RESOURCE OFF
[2026-08-05 22:23:29] [INFO] SET TALK OFF
[2026-08-05 22:23:29] [INFO] SET NOTIFY OFF
[2026-08-05 22:23:29] [INFO] SYS(2335, 0)
[2026-08-05 22:23:29] [INFO] 
[2026-08-05 22:23:29] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpb', 'C:\4c\tasks\task423', 'OPERACIONAL'
[2026-08-05 22:23:29] [INFO] QUIT
[2026-08-05 22:23:29] [INFO] 
[2026-08-05 22:23:29] [INFO] === Fim do Wrapper.prg ===
[2026-08-05 22:23:29] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFpb",
  "timestamp": "20260805222329",
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
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARDADOS is not found.",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpb.prg):
*==============================================================================
* FormFpb.prg - Cadastro de BIN (sub-form modal / popup)
* Form OPERACIONAL - abre sobre o form pai (FormFpp)
* Chamada: CREATEOBJECT("FormFpb", oParentForm, cFpags)
* Herda de: FormBase
*
* Form OPERACIONAL (sub-form modal). Botoes do SCX original: Inserir, Excluir,
* Encerrar. Edicao inline no grid. Handlers CRUD adicionais (Incluir/Alterar/
* Visualizar) mapeados para semantica deste form de edicao de grid.
*
* Historico de fases:
*   Fase 1/2: FpbBO.prg (propriedades + CRUD + CarregarBINs + SalvarBINs)
*   Fase 3:   FormFpb.prg - estrutura base (heranca, Init, InicializarForm)
*   Fase 4:   Grid grd_4c_Dados (4 colunas), botoes Inserir/Excluir/Encerrar
*             BtnInserirClick, BtnExcluirClick, BtnEncerrarClick
*   Fase 5:   Cabecalho Page2 espelhado, BeforeRowColChange, AfterRowColChange
*   Fase 6:   ConfigurarPaginaDados (botoes Confirmar/Cancelar), BtnConfirmarClick
*             BtnCancelarClick
*   Fase 7:   BtnIncluirClick (nova linha), BtnAlterarClick (foco edicao),
*             BtnVisualizarClick (alterna Page2)
*==============================================================================
DEFINE CLASS FormFpb AS FormBase

    *-- Propriedades do SCX original (RESERVED3: gravadados / parentform / peantvalue)
    GravaDados       = .F.      && .T. quando usuario alterou dados no grid
    peantvalue       = .NULL.   && valor anterior capturado em Column.When (C ou D)
    this_oParentForm = .NULL.   && referencia ao form pai para reabilitar no Destroy
    this_cFpags      = ""       && codigo da condicao de pagamento (fpags char 12)

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Controle de modo (padrao CRUD - usado por AlternarPagina em fases futuras)
    this_cModoAtual = "LISTA"   && LISTA / DADOS / INCLUIR / ALTERAR / VISUALIZAR

    *-- Guard anti-recursao no AfterRowColChange (redirect When behavior)
    this_lRedirigindo = .F.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX)
    Width        = 723
    Height       = 363
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    Caption      = "Cadastro de BIN"
    FontName     = "Verdana"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Init - Recebe ref ao pai e codigo da condicao de pagamento
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cFpags)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oParentForm = par_oParentForm
            THIS.this_cFpags      = IIF(VARTYPE(par_cFpags) = "C", ALLTRIM(par_cFpags), "")

            THIS.this_oBusinessObject = CREATEOBJECT("FpbBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FpbBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFpb.Init")
            ELSE
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .F.
                ENDIF
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual base do form
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- 1. PageFrame com Page1 (Lista) e Page2 (Dados)
            THIS.ConfigurarPageFrame()

            *-- 2. Containers vazios em cada Page
            THIS.ConfigurarContainersBase()

            *-- 3. Popula Page1: labels cabecalho, botoes, label condicao, grid
            THIS.ConfigurarPaginaLista()

            *-- 3b. Popula Page2: cabecalho + BINDEVENT BeforeRowColChange no grid
            THIS.ConfigurarPaginaDados()

            *-- 3c. Propaga Caption para cabecalhos de ambas as paginas
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- 4. Carrega dados via BO e vincula grid ao cursor
            THIS.CarregarDados()

            *-- 5. Ativa Page1 (Lista) como padrao
            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual           = "LISTA"

            *-- 6. Torna toda a arvore visivel
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Tabs ocultas (Top=-29, Tabs=.F.) - navegacao via AlternarPagina()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top         = -29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height + 29
                .PageCount   = 2
                .Tabs        = .F.
                .BorderWidth = 0

                .Page1.Caption = "Lista"
                .Page2.Caption = "Dados"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersBase - Cria containers vazios em cada Page
    * cnt_4c_Cabecalho + cnt_4c_Botoes em Page1 (fase 4 popula grid+botoes CRUD)
    * cnt_4c_BotoesAcao em Page2 (fase 6 popula Salvar/Cancelar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersBase()
        LOCAL loc_oPag1, loc_oPag2, loc_oErro
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- Page1: cabecalho escuro (topo)
            loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag1.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            *-- Page1: container de botoes (fase 4 populara com Inserir/Excluir/Sair)
            loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPag1.cnt_4c_Botoes
                .Top         = 0 + 29
                .Left        =  542
                .Width       = 229
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *-- Page2: container de botoes de acao (fase 6 populara com Salvar/Cancelar)
            loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPag2.cnt_4c_BotoesAcao
                .Top         = 4 + 29
                .Left        = 550
                .Width       = 170
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.ConfigurarContainersBase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (percorre Pages de PageFrames alem de Controls de Containers)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_nP, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Popula Page1 com labels, botoes, label da
    *   condicao de pagamento e grid de BINs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oCab, loc_oCnt, loc_oGrd, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            *-- Labels no cabecalho escuro (sombra + titulo)
            loc_oCab = loc_oPag.cnt_4c_Cabecalho
            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = 769
                .ForeColor  = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH

            *-- Botoes: Inserir / Excluir / Encerrar no container direito
            loc_oCnt = loc_oPag.cnt_4c_Botoes

            loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Inserir
                .Left            = 0
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")

            loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Excluir
                .Left            = 75
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Encerrar
                .Left            = 150
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Label exibindo a condicao de pagamento ativa
            loc_oPag.AddObject("lbl_4c_CondicaoPag", "Label")
            WITH loc_oPag.lbl_4c_CondicaoPag
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "[ " + ALLTRIM(THIS.this_cFpags) + " ]"
                .Height    = 15
                .Left      = 272
                .Top       = 116
                .Width     = 154
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Grid de BINs (RecordSource e ControlSource sao setados em CarregarDados)
            loc_oPag.AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = loc_oPag.grd_4c_Dados
            WITH loc_oGrd
                .Left                = 145
                .Top                 = 135
                .Width               = 432
                .Height              = 244
                .ColumnCount         = 4
                .FontName            = "Tahoma"
                .FontSize            = 8
                .DeleteMark          = .F.
                .RecordMark          = .F.
                .RowHeight           = 16
                .ScrollBars          = 2
                .GridLineColor       = RGB(238, 238, 238)
                .HighlightBackColor  = RGB(255, 255, 255)
                .HighlightForeColor  = RGB(15, 41, 104)
                .HighlightStyle      = 2

                WITH .Column1
                    .Width     = 58
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .Caption   = "B I N"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .Width     = 185
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column3
                    .Width     = 80
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .Caption   = "Validade De"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                        .NullDisplay = "  /  /"
                    ENDWITH
                ENDWITH

                WITH .Column4
                    .Width     = 109
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .Caption   = "Validade Ate"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (cabecalho espelhado da Page1)
    * Este form e grid-apenas: Page2 nao tem campos de dados adicionais.
    * Tambem vincula BeforeRowColChange ao grid para rastrear peantvalue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oCab, loc_oGrd, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page2

            *-- Cabecalho escuro espelhando Page1
            loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCab = loc_oPag.cnt_4c_Cabecalho

            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width
                .ForeColor = RGB(255, 255, 255)
            ENDWITH

            *-- Botoes Confirmar / Cancelar no container cnt_4c_BotoesAcao
            LOCAL loc_oCnt2
            loc_oCnt2 = loc_oPag.cnt_4c_BotoesAcao

            loc_oCnt2.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oCnt2.cmd_4c_Confirmar
                .Left            = 5
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH
            BINDEVENT(loc_oCnt2.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

            loc_oCnt2.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oCnt2.cmd_4c_Cancelar
                .Left            = 85
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH
            BINDEVENT(loc_oCnt2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- Vincula BeforeRowColChange para salvar peantvalue (Col2/3/4.Text1.When)
            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF VARTYPE(loc_oGrd) = "O"
                BINDEVENT(loc_oGrd, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            THIS.this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosBeforeRowColChange - Salva valor corrente antes da mudanca de coluna
    * Implementa comportamento When original: Column2/3/4.Text1.When salvava
    * peantvalue para comparacao posterior no Valid
    * PUBLIC: BINDEVENT requer metodo publico + LPARAMETERS obrigatorio
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_BINs") AND !EOF("cursor_4c_BINs")
                DO CASE
                    CASE par_nColIndex = 2
                        THIS.peantvalue = cursor_4c_BINs.descs
                    CASE par_nColIndex = 3
                        THIS.peantvalue = NVL(cursor_4c_BINs.datais, CTOD(""))
                    CASE par_nColIndex = 4
                        THIS.peantvalue = NVL(cursor_4c_BINs.datafs, CTOD(""))
                    OTHERWISE
                        THIS.peantvalue = .NULL.
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.GrdDadosBeforeRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega BINs via BO e vincula grid ao cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oPag, loc_oGrd, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.CarregarBINs(THIS.this_cFpags)
                loc_oPag = THIS.pgf_4c_Paginas.Page1
                loc_oGrd = loc_oPag.grd_4c_Dados

                *-- ColumnCount ANTES de RecordSource (regra VFP9)
                loc_oGrd.ColumnCount           = 4
                loc_oGrd.RecordSource          = "cursor_4c_BINs"
                loc_oGrd.Column1.ControlSource = "cursor_4c_BINs.codbins"
                loc_oGrd.Column2.ControlSource = "cursor_4c_BINs.descs"
                loc_oGrd.Column3.ControlSource = "cursor_4c_BINs.datais"
                loc_oGrd.Column4.ControlSource = "cursor_4c_BINs.datafs"

                *-- Reconfigurar headers (RecordSource os reseta)
                loc_oGrd.Column1.Header1.Caption = "B I N"
                loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Column3.Header1.Caption = "Validade De"
                loc_oGrd.Column4.Header1.Caption = "Validade Ate"

                loc_oGrd.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.CarregarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Insere nova linha vazia em cursor_4c_BINs
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_oPag, loc_oGrd, loc_oErro
        TRY
            IF USED("cursor_4c_BINs")
                SELECT cursor_4c_BINs
                INSERT INTO cursor_4c_BINs (fpags) VALUES (THIS.this_cFpags)
                THIS.GravaDados = .T.
                GOTO BOTTOM

                loc_oPag = THIS.pgf_4c_Paginas.Page1
                loc_oGrd = loc_oPag.grd_4c_Dados
                IF VARTYPE(loc_oGrd) = "O"
                    loc_oGrd.Refresh()
                    loc_oGrd.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnInserirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Marca registro corrente como excluido no cursor
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPag, loc_oGrd, loc_oErro
        TRY
            IF USED("cursor_4c_BINs")
                SELECT cursor_4c_BINs
                IF !EOF()
                    DELETE
                    SKIP
                    IF EOF()
                        SKIP -1
                    ENDIF
                    THIS.GravaDados = .T.

                    loc_oPag = THIS.pgf_4c_Paginas.Page1
                    loc_oGrd = loc_oPag.grd_4c_Dados
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Valida, salva se houver alteracoes e fecha o form
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lPodeFechar, loc_oPag, loc_oCnt, loc_oErro
        loc_lPodeFechar = .T.
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oCnt = loc_oPag.cnt_4c_Botoes

            IF VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O" AND ;
               loc_oCnt.cmd_4c_Inserir.Visible          AND ;
               THIS.GravaDados
                IF !THIS.this_oBusinessObject.SalvarBINs(THIS.this_cFpags, "cursor_4c_BINs")
                    loc_lPodeFechar = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnEncerrarClick")
            loc_lPodeFechar = .F.
        ENDTRY

        IF loc_lPodeFechar
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Sinaliza alteracao e implementa When behavior
    * When original: Column2/3/4.Text1.When retornava NOT EMPTY(CodBins)
    * Aqui: se CodBins vazio e cursor chegou em col 2/3/4, redireciona para col 1
    * PUBLIC: BINDEVENT requer metodo publico + LPARAMETERS obrigatorio
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oGrd, loc_nNovaCol, loc_oErro
        TRY
            THIS.GravaDados = .T.

            IF THIS.this_lRedirigindo
                RETURN
            ENDIF

            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF VARTYPE(loc_oGrd) = "O"
                loc_nNovaCol = loc_oGrd.ActiveColumn
                IF loc_nNovaCol >= 2 AND ;
                   USED("cursor_4c_BINs") AND !EOF("cursor_4c_BINs")
                    IF EMPTY(ALLTRIM(cursor_4c_BINs.codbins))
                        THIS.this_lRedirigindo = .T.
                        loc_oGrd.Column1.SetFocus()
                        THIS.this_lRedirigindo = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Retorna para Page1 (Lista) ap?s edicao em Page2
    * Neste form, Page2 e' apenas estrutural; edic?o ocorre direto no grid.
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Retorna para Page1 (Lista) sem salvar edicao em Page2
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Adiciona novo BIN vazio ao grid (equivalente ao
    *   cmdInserir do SCX legado). Inserir e Incluir sao sinonimos neste form.
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPag, loc_oGrd, loc_oErro
        TRY
            IF USED("cursor_4c_BINs")
                SELECT cursor_4c_BINs
                INSERT INTO cursor_4c_BINs (fpags) VALUES (THIS.this_cFpags)
                THIS.GravaDados = .T.
                GOTO BOTTOM

                loc_oPag = THIS.pgf_4c_Paginas.Page1
                loc_oGrd = loc_oPag.grd_4c_Dados
                IF VARTYPE(loc_oGrd) = "O"
                    loc_oGrd.Refresh()
                    loc_oGrd.Column1.SetFocus()
                ENDIF
                THIS.this_cModoAtual = "INCLUIR"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Coloca o registro corrente do grid em modo de edicao,
    *   posicionando o foco na primeira coluna (codbins) para digitacao.
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPag, loc_oGrd, loc_oErro
        TRY
            IF USED("cursor_4c_BINs")
                SELECT cursor_4c_BINs
                IF RECCOUNT() = 0 OR EOF()
                    MsgAviso("Nenhum BIN selecionado para altera" + CHR(231) + CHR(227) + "o.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF

                loc_oPag = THIS.pgf_4c_Paginas.Page1
                loc_oGrd = loc_oPag.grd_4c_Dados
                IF VARTYPE(loc_oGrd) = "O"
                    loc_oGrd.Refresh()
                    loc_oGrd.Column2.SetFocus()
                    THIS.GravaDados = .T.
                ENDIF
                THIS.this_cModoAtual = "ALTERAR"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega BO com o registro corrente e alterna para
    *   Page2 (Dados) em modo visualizacao (somente leitura).
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_BINs")
                SELECT cursor_4c_BINs
                IF RECCOUNT() = 0 OR EOF()
                    MsgAviso("Nenhum BIN selecionado para visualiza" + CHR(231) + CHR(227) + "o.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF

                THIS.AlternarPagina(2)
                THIS.this_cModoAtual = "VISUALIZAR"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias para CarregarDados (compatibilidade com padrao CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Mapeia linha corrente do cursor_4c_BINs para propriedades do BO
    * Todos os campos: cidchaves, codbins, descs, datais, datafs, fpags
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_BINs") AND !EOF("cursor_4c_BINs")
                SELECT cursor_4c_BINs
                THIS.this_oBusinessObject.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_oBusinessObject.this_cCodBins   = TratarNulo(codbins,   "C")
                THIS.this_oBusinessObject.this_cDescs     = TratarNulo(descs,     "C")
                THIS.this_oBusinessObject.this_dDataIs    = IIF(ISNULL(datais), {}, ;
                    IIF(VARTYPE(datais) = "T", TTOD(datais), datais))
                THIS.this_oBusinessObject.this_dDataFs    = IIF(ISNULL(datafs), {}, ;
                    IIF(VARTYPE(datafs) = "T", TTOD(datafs), datafs))
                THIS.this_oBusinessObject.this_cFpags     = TratarNulo(fpags,     "C")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza grid apos operacao individual via BO
    * Edicao ocorre inline no grid; este metodo faz Refresh para refletir
    * eventuais alteracoes aplicadas pelo BO no cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oGrd, loc_oErro
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita botoes Inserir e Excluir
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            IF VARTYPE(loc_oCnt) = "O"
                IF VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O"
                    loc_oCnt.cmd_4c_Inserir.Enabled = par_lHabilitar
                ENDIF
                IF VARTYPE(loc_oCnt.cmd_4c_Excluir) = "O"
                    loc_oCnt.cmd_4c_Excluir.Enabled = par_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera cursor de BINs e reseta flag de alteracao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oGrd, loc_oErro
        TRY
            IF USED("cursor_4c_BINs")
                SELECT cursor_4c_BINs
                ZAP
            ENDIF
            THIS.GravaDados = .F.

            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
    * LISTA/INCLUIR -> Inserir+Excluir habilitados
    * ALTERAR/VISUALIZAR -> Inserir+Excluir desabilitados (edicao inline ativa)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lHabilitar, loc_oErro
        TRY
            loc_oCnt     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_lHabilitar = INLIST(THIS.this_cModoAtual, "LISTA", "INCLUIR")

            IF VARTYPE(loc_oCnt) = "O"
                IF VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O"
                    loc_oCnt.cmd_4c_Inserir.Enabled = loc_lHabilitar
                ENDIF
                IF VARTYPE(loc_oCnt.cmd_4c_Excluir) = "O"
                    loc_oCnt.cmd_4c_Excluir.Enabled = loc_lHabilitar
                ENDIF
                IF VARTYPE(loc_oCnt.cmd_4c_Encerrar) = "O"
                    loc_oCnt.cmd_4c_Encerrar.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Re-carrega BINs do banco de dados (Refresh da lista)
    * Descarta alteracoes nao salvas apos confirmacao do usuario
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.
        TRY
            IF THIS.GravaDados
                loc_lProsseguir = MsgConfirma( ;
                    "Existem altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
                    "o salvas. Deseja descartar e recarregar?", ;
                    "Confirma" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF loc_lProsseguir
                THIS.GravaDados = .F.
                THIS.CarregarDados()
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva alteracoes imediatamente sem fechar o form
    * Equivale ao bloco de salvamento do cmdSair original sem o Release
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes

            IF VARTYPE(loc_oCnt) = "O" AND ;
               VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O" AND ;
               loc_oCnt.cmd_4c_Inserir.Visible
                IF THIS.GravaDados
                    IF THIS.this_oBusinessObject.SalvarBINs(THIS.this_cFpags, "cursor_4c_BINs")
                        THIS.GravaDados = .F.
                        MsgInfo("BINs salvos com sucesso.", "Salvo")
                    ENDIF
                ELSE
                    MsgAviso("Nenhuma altera" + CHR(231) + CHR(227) + "o para salvar.", ;
                        "Informa" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                    "o permitida neste contexto.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpb.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita form pai e libera cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        IF USED("cursor_4c_BINs")
            USE IN cursor_4c_BINs
        ENDIF
        IF USED("cursor_4c_BINsTemp")
            USE IN cursor_4c_BINsTemp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FpbBO.prg):
*==============================================================================
* FpbBO.prg - Business Object: Cadastro de BIN
* Tabela: SigOpFpb
* PK: cidchaves char(20)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS FpbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chave Primaria
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""    && cidchaves char(20) - PK tecnica (auto-gerada)

    *--------------------------------------------------------------------------
    * Propriedades - Campos da tabela SigOpFpb
    *--------------------------------------------------------------------------
    this_cCodBins    = ""    && codbins   char(6)      - codigo BIN
    this_cDescs      = ""    && descs     char(30)     - descricao
    this_dDataIs     = {}    && datais    datetime NULL - validade de
    this_dDataFs     = {}    && datafs    datetime NULL - validade ate
    this_cFpags      = ""    && fpags     char(12)     - FK condicao de pagamento

    *--------------------------------------------------------------------------
    * Propriedades de controle
    *--------------------------------------------------------------------------
    this_lGravaDados = .F.   && indica se houve alteracao nos dados do grid

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpFpb"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCodBins   = TratarNulo(codbins,   "C")
                THIS.this_cDescs     = TratarNulo(descs,     "C")
                THIS.this_dDataIs    = IIF(ISNULL(datais), {}, IIF(VARTYPE(datais) = "T", TTOD(datais), datais))
                THIS.this_dDataFs    = IIF(ISNULL(datafs), {}, IIF(VARTYPE(datafs) = "T", TTOD(datafs), datafs))
                THIS.this_cFpags     = TratarNulo(fpags,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCodBins)
            MsgAviso("C" + CHR(243) + "digo BIN " + CHR(233) + ;
                " " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cFpags)
            MsgAviso("Condi" + CHR(231) + CHR(227) + "o de pagamento " + CHR(233) + ;
                " obrigat" + CHR(243) + "ria.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo BIN no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cCidChaves = THIS.GerarChavePrimaria()

                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                           "VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                           EscaparSQL(THIS.this_cCodBins)      + ", " + ;
                           EscaparSQL(THIS.this_cDescs)        + ", " + ;
                           FormatarDataSQL(THIS.this_dDataIs)  + ", " + ;
                           FormatarDataSQL(THIS.this_dDataFs)  + ", " + ;
                           EscaparSQL(THIS.this_cFpags)        + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir BIN no banco de dados.", "FpbBO.Inserir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza BIN existente no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigOpFpb SET " + ;
                           "codbins = " + EscaparSQL(THIS.this_cCodBins)     + ", " + ;
                           "descs   = " + EscaparSQL(THIS.this_cDescs)       + ", " + ;
                           "datais  = " + FormatarDataSQL(THIS.this_dDataIs) + ", " + ;
                           "datafs  = " + FormatarDataSQL(THIS.this_dDataFs) + ", " + ;
                           "fpags   = " + EscaparSQL(THIS.this_cFpags)       + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("A")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar BIN no banco de dados.", "FpbBO.Atualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui BIN do banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpb " + ;
                       "WHERE fpags = " + EscaparSQL(THIS.this_cFpags)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir BIN do banco de dados.", "FpbBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBINs - Carrega BINs de uma condicao de pagamento em cursor local
    *--------------------------------------------------------------------------
    FUNCTION CarregarBINs(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BINs")
                USE IN cursor_4c_BINs
            ENDIF
            IF USED("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_BINs ( ;
                cidchaves C(20) NULL, ;
                codbins   C(6)  NULL, ;
                descs     C(30) NULL, ;
                datais    T     NULL, ;
                datafs    T     NULL, ;
                fpags     C(12) NULL  ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT cidchaves, codbins, descs, datais, datafs, fpags " + ;
                       "FROM SigOpFpb " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY codbins"

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BINsTemp")

            IF USED("cursor_4c_BINsTemp")
                SELECT cursor_4c_BINs
                APPEND FROM DBF("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SELECT cursor_4c_BINs
            INDEX ON codbins TAG codbins
            SET ORDER TO
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se ha codbins duplicados no cursor
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade(par_cCursorBINs)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorBINs)
                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF

                SELECT codbins, SUM(1) AS nQtd ;
                    FROM (par_cCursorBINs) ;
                    WHERE !EMPTY(codbins) ;
                    GROUP BY codbins ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupBINs READWRITE

                IF RECCOUNT("cursor_4c_DupBINs") > 0
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarBINs - Exclui BINs antigos e reinsere todos do cursor local
    *--------------------------------------------------------------------------
    FUNCTION SalvarBINs(par_cFpags, par_cCursorBINs)
        LOCAL loc_lSucesso, loc_lErroInsert, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso    = .F.
        loc_lErroInsert = .F.
        TRY
            IF THIS.ValidarDuplicidade(par_cCursorBINs)
                loc_cSQL = "DELETE FROM SigOpFpb WHERE fpags = " + EscaparSQL(par_cFpags)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    IF USED(par_cCursorBINs)
                        SELECT (par_cCursorBINs)
                        GOTO TOP
                        SCAN WHILE !loc_lErroInsert
                            IF !EMPTY(codbins)
                                loc_cChave = THIS.GerarChavePrimaria()

                                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                                           "VALUES (" + ;
                                           EscaparSQL(loc_cChave)   + ", " + ;
                                           EscaparSQL(codbins)       + ", " + ;
                                           EscaparSQL(descs)         + ", " + ;
                                           FormatarDataSQL(datais)   + ", " + ;
                                           FormatarDataSQL(datafs)   + ", " + ;
                                           EscaparSQL(par_cFpags)    + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                    MsgErro("Erro ao salvar BIN: " + ALLTRIM(codbins), ;
                                        "FpbBO.SalvarBINs")
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDSCAN
                        loc_lSucesso = !loc_lErroInsert
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir BINs anteriores da condi" + CHR(231) + CHR(227) + ;
                        "o de pagamento.", "FpbBO.SalvarBINs")
                ENDIF
            ELSE
                MsgAviso("Dados inconsistentes. C" + CHR(243) + "digo BIN em duplicidade!!!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.SalvarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChavePrimaria - Gera chave unica de 20 chars (substitui fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChavePrimaria()
        LOCAL loc_cTs, loc_cRand, loc_cChave
        loc_cTs    = TTOC(DATETIME(), 1)
        loc_cRand  = TRANSFORM(INT(RAND() * 999999), "999999")
        loc_cChave = LEFT(loc_cTs + loc_cRand, 20)
        RETURN loc_cChave
    ENDFUNC

ENDDEFINE


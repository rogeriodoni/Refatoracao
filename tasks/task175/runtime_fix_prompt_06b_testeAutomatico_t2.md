# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'Fechar': Function requires row or table buffering mode. | Detalhes: Linha: 292

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[03/07/2026 00:54:21] Erro de Conexão: Impossível conectar ao banco ALERTA.
[03/07/2026 00:54:21] Erro: Connection handle is invalid.
[03/07/2026 00:54:21] Erro: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-03 00:48:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-03 00:48:57] [INFO] Config FPW: (nao fornecido)
[2026-07-03 00:48:57] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 00:48:57] [INFO] Timeout: 300 segundos
[2026-07-03 00:48:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tpqanqmp.prg
[2026-07-03 00:48:57] [INFO] Conteudo do wrapper:
[2026-07-03 00:48:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'
QUIT

[2026-07-03 00:48:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tpqanqmp.prg
[2026-07-03 00:48:57] [INFO] VFP output esperado em: C:\4c\tasks\task175\vfp_output.txt
[2026-07-03 00:48:57] [INFO] Executando Visual FoxPro 9...
[2026-07-03 00:48:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tpqanqmp.prg
[2026-07-03 00:48:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tpqanqmp.prg
[2026-07-03 00:48:57] [INFO] Timeout configurado: 300 segundos
[2026-07-03 00:50:03] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-03 00:50:03] [INFO] VFP9 finalizado em 65.9165452 segundos
[2026-07-03 00:50:03] [INFO] Exit Code: 
[2026-07-03 00:50:03] [INFO] 
[2026-07-03 00:50:03] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-03 00:50:03] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tpqanqmp.prg
[2026-07-03 00:50:03] [INFO] 
[2026-07-03 00:50:03] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-03 00:50:03] [INFO] * Auto-generated wrapper for parameters
[2026-07-03 00:50:03] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 00:50:03] [INFO] * Parameters: 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'
[2026-07-03 00:50:03] [INFO] 
[2026-07-03 00:50:03] [INFO] * Anti-dialog protections for unattended execution
[2026-07-03 00:50:03] [INFO] SET SAFETY OFF
[2026-07-03 00:50:03] [INFO] SET RESOURCE OFF
[2026-07-03 00:50:03] [INFO] SET TALK OFF
[2026-07-03 00:50:03] [INFO] SET NOTIFY OFF
[2026-07-03 00:50:03] [INFO] SYS(2335, 0)
[2026-07-03 00:50:03] [INFO] 
[2026-07-03 00:50:03] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'
[2026-07-03 00:50:03] [INFO] QUIT
[2026-07-03 00:50:03] [INFO] 
[2026-07-03 00:50:03] [INFO] === Fim do Wrapper.prg ===
[2026-07-03 00:50:03] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-03 00:53:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-03 00:53:12] [INFO] Config FPW: (nao fornecido)
[2026-07-03 00:53:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 00:53:12] [INFO] Timeout: 300 segundos
[2026-07-03 00:53:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ubo0a55t.prg
[2026-07-03 00:53:12] [INFO] Conteudo do wrapper:
[2026-07-03 00:53:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'
QUIT

[2026-07-03 00:53:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ubo0a55t.prg
[2026-07-03 00:53:12] [INFO] VFP output esperado em: C:\4c\tasks\task175\vfp_output.txt
[2026-07-03 00:53:12] [INFO] Executando Visual FoxPro 9...
[2026-07-03 00:53:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ubo0a55t.prg
[2026-07-03 00:53:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ubo0a55t.prg
[2026-07-03 00:53:12] [INFO] Timeout configurado: 300 segundos
[2026-07-03 00:54:21] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-03 00:54:21] [INFO] VFP9 finalizado em 69.4099046 segundos
[2026-07-03 00:54:21] [INFO] Exit Code: 
[2026-07-03 00:54:21] [INFO] 
[2026-07-03 00:54:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-03 00:54:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ubo0a55t.prg
[2026-07-03 00:54:21] [INFO] 
[2026-07-03 00:54:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-03 00:54:21] [INFO] * Auto-generated wrapper for parameters
[2026-07-03 00:54:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 00:54:21] [INFO] * Parameters: 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'
[2026-07-03 00:54:21] [INFO] 
[2026-07-03 00:54:21] [INFO] * Anti-dialog protections for unattended execution
[2026-07-03 00:54:21] [INFO] SET SAFETY OFF
[2026-07-03 00:54:21] [INFO] SET RESOURCE OFF
[2026-07-03 00:54:21] [INFO] SET TALK OFF
[2026-07-03 00:54:21] [INFO] SET NOTIFY OFF
[2026-07-03 00:54:21] [INFO] SYS(2335, 0)
[2026-07-03 00:54:21] [INFO] 
[2026-07-03 00:54:21] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task175', 'OPERACIONAL'
[2026-07-03 00:54:21] [INFO] QUIT
[2026-07-03 00:54:21] [INFO] 
[2026-07-03 00:54:21] [INFO] === Fim do Wrapper.prg ===
[2026-07-03 00:54:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrEml",
  "timestamp": "20260703005421",
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
      "passou": true,
      "erro": "",
      "detalhes": "CarregarDados() executado | (sem registros - tabela pode estar vazia)"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick sem navegacao por PageFrame (OK)"
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
      "passou": false,
      "erro": "Function requires row or table buffering mode.",
      "detalhes": "Linha: 292"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg):
*==============================================================================
* FormSigPrEml.prg
* Form OPERACIONAL - Alerta de Email
* Herda de: FormBase
* Tipo: OPERACIONAL - Selecao de destinatarios e envio de alerta por email
* Original: SigPrEml.SCX (SIGPREML)
*
* Uso (chamado por outros forms):
*   loForm = CREATEOBJECT("FormSigPrEml", lcPrDopes, lcEscolha)
*   loForm = CREATEOBJECT("FormSigPrEml", lcPrDopes, lcEscolha, laOpeBaixa)
*   loForm.Show()
*
* par_cPrDopes : empresa(3)+dope(20)+numero(6)  C(29)  ex: "001FRET  000001"
* par_cEscolha : "INSERIR" | "ALTERAR" | "EXCLUIR"
* par_laOpeBaixa: ARRAY de EmpDopNums de operacoes baixadas (opcional)
*==============================================================================

DEFINE CLASS FormSigPrEml AS FormBase

    *-- Identificacao
    this_cTituloForm      = "ALERTA - Email"

    *-- Parametros recebidos em Init (capturados antes do DODEFAULT)
    this_cPrDopes         = ""    && empresa(3)+dope(20)+numero(6) C(29)
    this_cEscolha         = ""    && INSERIR | ALTERAR | EXCLUIR
    this_lTemOpeBaixa     = .F.   && .T. se recebeu array laOpeBaixa valido

    *-- Dimensoes e aparencia (identicas ao SCX SIGPREML)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    ShowTips     = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Init - Captura parametros ANTES de InicializarForm (via DODEFAULT)
    *
    * VFP9 nao suporta propriedade array em DEFINE CLASS para copia direta.
    * O array de baixas e preservado em variavel PUBLIC ga_4c_SigPrEmlOpeBaixa
    * antes de DODEFAULT (que dispara InicializarForm via FormBase.Init).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cPrDopes, par_cEscolha, par_laOpeBaixa)
        LOCAL loc_nX

        IF VARTYPE(par_cPrDopes) = "C"
            THIS.this_cPrDopes = par_cPrDopes
        ENDIF
        IF VARTYPE(par_cEscolha) = "C"
            THIS.this_cEscolha = par_cEscolha
        ENDIF

        *-- Preservar array de baixas em variavel publica acessivel em InicializarForm
        PUBLIC ga_4c_SigPrEmlOpeBaixa
        IF TYPE("par_laOpeBaixa", 1) = "A" AND ALEN(par_laOpeBaixa) > 0
            THIS.this_lTemOpeBaixa = .T.
            DIMENSION ga_4c_SigPrEmlOpeBaixa(ALEN(par_laOpeBaixa))
            FOR loc_nX = 1 TO ALEN(par_laOpeBaixa)
                ga_4c_SigPrEmlOpeBaixa(loc_nX) = par_laOpeBaixa(loc_nX)
            ENDFOR
        ELSE
            THIS.this_lTemOpeBaixa = .F.
            DIMENSION ga_4c_SigPrEmlOpeBaixa(1)
            ga_4c_SigPrEmlOpeBaixa(1) = ""
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Cria BO, inicializa conexoes e monta o layout visual do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEmlBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar Business Object SigPrEmlBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Inicializar conexao secundaria com banco ALERTA
            IF !THIS.this_oBusinessObject.InicializarConexaoAlerta()
                loc_lSucesso = .F.
            ENDIF

            *-- Configuracao form-level (aparencia, dimensoes finais)
            THIS.ConfigurarPageFrame()

            *-- Criar containers do layout: cabecalho + botao encerrar
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarEncerrar()

            *-- Criar grade de destinatarios e botoes operacionais (Fase 4)
            THIS.ConfigurarPaginaLista()

            *-- Completar elementos visuais: Shape1 + ColumnOrder + ReadOnly (Fase 5)
            THIS.ConfigurarPaginaDados()

            *-- Carregar destinatarios via BO (popula cursor_4c_Dados)
            THIS.CarregarDados()

            *-- Torna todos os controles visiveis (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar form ALERTA - Email:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configuracao de nivel form
    *
    * OBS: Este form OPERACIONAL nao usa PageFrame de negocio (nao ha lista/dados
    * como em cadastros CRUD). O metodo executa o setup form-level equivalente:
    * aplicacao do fundo padrao (new_background.jpg do framework) e ajuste de
    * dimensoes/estado da janela. Mantido nome canonico ConfigurarPageFrame
    * para compatibilidade com o pipeline de migracao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo

        *-- Fundo padrao do framework
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas do SCX original
        THIS.Width   = 1000
        THIS.Height  = 600
        THIS.Caption = "ALERTA - Email"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria cnt_4c_Sombra com labels de titulo
    * Ref SCX: SIGPREML.cntSombra - Top=0, Left=-1, Width=1004, Height=80
    *          BackColor=RGB(100,100,100) (cinza medio do framework)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = -1
            .Width       = 1004
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1

            *-- Label sombra: deslocado +1px, ForeColor preto (cria efeito 3D)
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Caption     = "ALERTA - Email"
                .Height      = 40
                .Left        = 10
                .Top         = 18
                .Width       = THIS.Width
                .ForeColor   = RGB(0, 0, 0)
            ENDWITH

            *-- Label titulo: ForeColor branco (visivel sobre cinza)
            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Caption     = "ALERTA - Email"
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .ForeColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEncerrar - Cria CommandGroup de encerramento (botao Encerrar)
    * Ref SCX: SIGPREML.Commandgroup1 - Left=918, Top=-2, Width=85, Height=85
    *          Command1(btnSair): Caption="Encerrar", Cancel=.T.
    *          Picture=cadastro_cancelar_60.jpg (icone X/cancelar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEncerrar()
        THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
        WITH THIS.cmg_4c_Encerrar
            .AutoSize      = .F.
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 85
            .Left          = 918
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 85
            .Themes        = .F.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 5
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Cancel      = .T.
                .Caption     = "Encerrar"
                .ToolTipText = "[Esc] Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Encerrar.Buttons(1), "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Fecha o formulario (handler do botao Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Necessario porque AddObject() cria controles com Visible=.F. por padrao
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override: form OPERACIONAL sem modos CRUD
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de trabalho e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- Fechar cursores de trabalho (com TABLEREVERT se cursor editavel)
        IF USED("cursor_4c_Dados")
            TABLEREVERT(.T., "cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_MvCab")
            USE IN cursor_4c_MvCab
        ENDIF
        IF USED("cursor_4c_Ale")
            USE IN cursor_4c_Ale
        ENDIF
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_OpeBaixa")
            USE IN cursor_4c_OpeBaixa
        ENDIF
        IF USED("cursor_4c_ClJob")
            USE IN cursor_4c_ClJob
        ENDIF
        IF USED("cursor_4c_CliEmail")
            USE IN cursor_4c_CliEmail
        ENDIF
        IF USED("cursor_4c_ConfigEmail")
            USE IN cursor_4c_ConfigEmail
        ENDIF
        IF USED("cursor_4c_Dados2")
            USE IN cursor_4c_Dados2
        ENDIF

        *-- Liberar variavel publica do array de baixas
        IF TYPE("ga_4c_SigPrEmlOpeBaixa") != "U"
            RELEASE ga_4c_SigPrEmlOpeBaixa
        ENDIF

        *-- BO gerencia conexao ALERTA em seu proprio Destroy
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Alias canonico para o pipeline multi-fase
    * Cria grade de destinatarios e botoes operacionais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoesOpe()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Completa elementos visuais do form OPERACIONAL
    *
    * Para forms OPERACIONAIS (sem Page2 de dados CRUD), este metodo:
    *   1. Cria Shape1 decorativo do SCX original (raia visual ao redor do area
    *      dos botoes de acao: btnEmail + Encerrar)
    *   2. Ajusta ColumnOrder do grid: Checks primeiro (ColumnOrder=1) conforme SCX
    *   3. Define ReadOnly nas colunas conforme SCX (Conta/Nome/Mensagem=.T.; Email=.F.)
    *   4. Corrige larguras e RowHeight para fidelidade ao SCX original
    *
    * Ref SCX: SIGPREML.Shape1 Top=-2, Left=819, Width=84, Height=84
    *          BackStyle=0, BorderStyle=0, BorderWidth=1, SpecialEffect=1
    * Ref SCX colunas: Column6(Checks,Order=1,W=17) Column2(Conta,Order=2,W=80)
    *                  Column3(Nome,Order=3,W=290) Column4(Email,Order=4,W=290)
    *                  Column5(Mensagem,Order=5,W=290)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Shape1: decoracao visual ao redor da area de botoes de acao
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = -2
            .Left          = 819
            .Width         = 84
            .Height        = 84
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
        ENDWITH

        *-- Ajustar ColumnOrder, ReadOnly e larguras conforme SCX original
        *-- Column5 = Checks: visual mais a esquerda (ColumnOrder=1)
        *-- Column1 = Conta: segunda visual (ColumnOrder=2)
        *-- Column2 = Nome: terceira visual (ColumnOrder=3)
        *-- Column3 = Email: quarta visual, editavel (ColumnOrder=4)
        *-- Column4 = Mensagem: quinta visual, readonly (ColumnOrder=5)
        WITH THIS.grd_4c_Dados
            WITH .Column5
                .ColumnOrder = 1
                .Width       = 17
                .ReadOnly    = .F.
            ENDWITH
            WITH .Column1
                .ColumnOrder = 2
                .Width       = 80
                .ReadOnly    = .T.
            ENDWITH
            WITH .Column2
                .ColumnOrder = 3
                .Width       = 290
                .ReadOnly    = .T.
            ENDWITH
            WITH .Column3
                .ColumnOrder = 4
                .Width       = 290
                .ReadOnly    = .F.
            ENDWITH
            WITH .Column4
                .ColumnOrder = 5
                .Width       = 290
                .ReadOnly    = .T.
            ENDWITH
            .RowHeight = 18
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form OPERACIONAL nao usa PageFrame de navegacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Cria grd_4c_Dados (grade_alerta do SCX)
    * Ref SCX: SIGPREML.grade_alerta Top=132 Left=3 Width=993 Height=435
    * 5 colunas: Conta | Nome | Email | Mensagem(EditBox) | Checks (checkbox)
    * Index tags: Contas, Rclis, Emails (criados pelo BO em CarregarAlertasEmail)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 132
            .Left               = 3
            .Width              = 993
            .Height             = 435
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .RowHeight          = 20
            .ScrollBars         = 2
            .ColumnCount        = 5
            .AllowAutoColumnFit = 2

            *-- Column1: Conta (SCX Column2 - " Conta")
            WITH .Column1
                .FontName         = "Verdana"
                .FontSize         = 8
                .Width            = 90
                .ReadOnly         = .T.
                .Header1.Caption  = "Conta"
                .Header1.BackColor = RGB(192, 192, 192)
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column2: Nome/Rclis (SCX Column3 - "Nome")
            WITH .Column2
                .FontName         = "Verdana"
                .FontSize         = 8
                .Width            = 200
                .ReadOnly         = .T.
                .Header1.Caption  = "Nome"
                .Header1.BackColor = RGB(192, 192, 192)
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column3: Email (SCX Column4 - "Email")
            WITH .Column3
                .FontName         = "Verdana"
                .FontSize         = 8
                .Width            = 230
                .ReadOnly         = .F.
                .Header1.Caption  = "Email"
                .Header1.BackColor = RGB(192, 192, 192)
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column4: Mensagem (SCX Column5 - fweditbox1 - campo memo)
            *-- REGRA: AddObject ANTES de CurrentControl; ControlSource na Column, NAO no EditBox1
            WITH .Column4
                .FontName         = "Verdana"
                .FontSize         = 8
                .Width            = 390
                .ReadOnly         = .T.
                .Header1.Caption  = "Mensagem"
                .Header1.BackColor = RGB(192, 192, 192)
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .AddObject("EditBox1", "EditBox")
                WITH .EditBox1
                    .FontName      = "Verdana"
                    .FontSize      = 8
                    .BorderStyle   = 0
                    .ReadOnly      = .T.
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .ForeColor     = RGB(0, 0, 0)
                ENDWITH
                .CurrentControl  = "EditBox1"
                .Sparse          = .F.
            ENDWITH

            *-- Column5: Checks - checkbox de selecao (SCX Column6 - header vazio)
            *-- REGRA: AddObject ANTES de CurrentControl; ControlSource na Column, NAO no Check1
            WITH .Column5
                .Width            = 40
                .Alignment        = 2
                .Header1.Caption  = ""
                .Header1.BackColor = RGB(192, 192, 192)
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption   = ""
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Value     = 0
                ENDWITH
                .CurrentControl  = "Check1"
                .Sparse          = .F.
            ENDWITH
        ENDWITH

        *-- BINDEVENT para ordenacao por click nos headers de coluna
        BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "GrdColContaClick")
        BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdColNomeClick")
        BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdColEmailClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesOpe - Cria botoes operacionais: SelTudo, Apaga, BtnEmail
    * Ref SCX: SelTudo Top=90 Left=4 W=40 H=40
    *          apaga   Top=90 Left=43 W=40 H=40
    *          btnEmail Top=3 Left=848 W=75 H=75
    * REGRA: botoes icone-only (Caption="") NAO recebem .Enabled=.F. em runtime
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesOpe()
        *-- cmd_4c_SelTudo: Selecionar todos os destinatarios
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top             = 90
            .Left            = 4
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .ToolTipText     = "Selecionar Todos"
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        *-- cmd_4c_Apaga: Desmarcar todos os destinatarios
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top             = 90
            .Left            = 43
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .ToolTipText     = "Desmarcar Todos"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")

        *-- cmd_4c_BtnEmail: Enviar email para destinatarios selecionados
        *-- Ref SCX: btnEmail class=fwbtnp Top=3 Left=848 W=75 H=75
        THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
        WITH THIS.cmd_4c_BtnEmail
            .Top             = 3
            .Left            = 848
            .Width           = 75
            .Height          = 75
            .Caption         = "Enviar Email"
            .ToolTipText     = "Enviar email para destinat" + CHR(225) + "rios selecionados"
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "CmdBtnEmailClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Chama BO para popular cursor_4c_Dados e vincula ao grid
    * BO.CarregarAlertasEmail cria cursor_4c_Dados com tags Contas/Rclis/Emails
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.this_oBusinessObject.CarregarAlertasEmail( ;
                THIS.this_cPrDopes, ;
                THIS.this_cEscolha, ;
                ga_4c_SigPrEmlOpeBaixa)

            IF loc_lResultado AND USED("cursor_4c_Dados")
                THIS.grd_4c_Dados.ColumnCount  = 5
                THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"

                *-- Reconfigurar apos RecordSource (VFP reseta headers)
                THIS.grd_4c_Dados.Column1.ControlSource    = "cursor_4c_Dados.Contas"
                THIS.grd_4c_Dados.Column1.Header1.Caption  = "Conta"
                THIS.grd_4c_Dados.Column2.ControlSource    = "cursor_4c_Dados.Rclis"
                THIS.grd_4c_Dados.Column2.Header1.Caption  = "Nome"
                THIS.grd_4c_Dados.Column3.ControlSource    = "cursor_4c_Dados.emails"
                THIS.grd_4c_Dados.Column3.Header1.Caption  = "Email"
                THIS.grd_4c_Dados.Column4.CurrentControl   = "EditBox1"
                THIS.grd_4c_Dados.Column4.ControlSource    = "cursor_4c_Dados.mensagems"
                THIS.grd_4c_Dados.Column4.Header1.Caption  = "Mensagem"
                THIS.grd_4c_Dados.Column5.AddObject("Check1", "CheckBox")
                THIS.grd_4c_Dados.Column5.Check1.Caption = ""
                THIS.grd_4c_Dados.Column5.CurrentControl   = "Check1"
                THIS.grd_4c_Dados.Column5.ControlSource    = "cursor_4c_Dados.Checks"
                THIS.grd_4c_Dados.Column5.Header1.Caption  = ""
                THIS.grd_4c_Dados.Refresh()
                THIS.GrdColNomeClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar destinat" + CHR(225) + "rios:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - Marca Checks=1 em todos os registros do cursor
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL Checks WITH 1
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - Marca Checks=0 em todos os registros do cursor
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdBtnEmailClick - Envia email para destinatarios com Checks=1
    * Replica logica de SIGPREML.btnEmail.Click (~139 linhas no SCX original)
    * Fluxo: verifica selecao -> busca config SMTP -> monta mensagem completa ->
    *        envia via SQL Server Database Mail -> registra historico em SigAlert ->
    *        envia segundo email para baixas -> fecha form
    *--------------------------------------------------------------------------
    PROCEDURE CmdBtnEmailClick()
        LOCAL loc_lResultado, loc_nSelecionados, loc_cSQL, loc_oErro, loc_oBO
        LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, loc_cTxtMensagem
        LOCAL loc_cJobDesc, loc_cClienteDesc, loc_cDescritivo, loc_cObses
        LOCAL loc_cMensagemAlerta, loc_cEscolhaDesc, loc_cPkNovo, loc_cTxtPrioridade
        LOCAL loc_cEmpMv, loc_cDopeMv, loc_cNumMv
        LOCAL loc_cReceptor2, loc_cCopia2, loc_cTxtMensagem2, loc_cAssunto2, loc_cPrio2
        LOCAL loc_cEDN2, loc_cEmp2, loc_cDope2, loc_cNum2, loc_lPrimeiro

        loc_lResultado      = .F.
        loc_nSelecionados   = 0
        loc_cReceptor       = ""
        loc_cReceptorCopia  = ""
        loc_cTxtMensagem    = ""
        loc_cTxtPrioridade  = ""
        loc_cMensagemAlerta = ""
        loc_cEscolhaDesc    = ""

        TRY
            *-- Verificar selecao
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                COUNT FOR Checks = 1 TO loc_nSelecionados
            ENDIF
            IF loc_nSelecionados = 0
                MsgAviso("Selecione ao menos um destinat" + CHR(225) + "rio antes de enviar.", ;
                         "Aviso")
            ELSE
                *-- Buscar configuracao SMTP da empresa via BO
                IF THIS.this_oBusinessObject.BuscarConfigEmailEmpresa()
                    loc_oBO = THIS.this_oBusinessObject

                    *-- Dados da movimentacao (cursor_4c_MvCab criado pelo BO)
                    loc_cJobDesc     = ""
                    loc_cClienteDesc = ""
                    loc_cDescritivo  = ""
                    loc_cObses       = ""
                    loc_cEmpMv       = SUBSTR(THIS.this_cPrDopes, 1, 3)
                    loc_cDopeMv      = ALLTRIM(SUBSTR(THIS.this_cPrDopes, 4, 20))
                    loc_cNumMv       = ALLTRIM(SUBSTR(THIS.this_cPrDopes, 24, 6))
                    IF USED("cursor_4c_MvCab")
                        SELECT cursor_4c_MvCab
                        GO TOP
                        IF !EOF()
                            loc_cJobDesc     = ALLTRIM(NVL(cursor_4c_MvCab.Jobs,       ""))
                            loc_cClienteDesc = ALLTRIM(NVL(cursor_4c_MvCab.Rclis,      ""))
                            loc_cDescritivo  = ALLTRIM(NVL(cursor_4c_MvCab.ObsCabMovs, ""))
                            loc_cObses       = ALLTRIM(NVL(cursor_4c_MvCab.Obses,      ""))
                        ENDIF
                    ENDIF

                    *-- Construir descricao da acao
                    DO CASE
                        CASE ALLTRIM(THIS.this_cEscolha) = "INSERIR"
                            loc_cEscolhaDesc = "Inclus" + CHR(227) + "o"
                        CASE ALLTRIM(THIS.this_cEscolha) = "ALTERAR"
                            loc_cEscolhaDesc = "Altera" + CHR(231) + CHR(227) + "o"
                        CASE ALLTRIM(THIS.this_cEscolha) = "EXCLUIR"
                            loc_cEscolhaDesc = "Exclus" + CHR(227) + "o"
                        OTHERWISE
                            loc_cEscolhaDesc = ALLTRIM(THIS.this_cEscolha)
                    ENDCASE

                    *-- Extrair registros selecionados para cursor temporario
                    IF USED("cursor_4c_Dados2")
                        USE IN cursor_4c_Dados2
                    ENDIF
                    SELECT * FROM cursor_4c_Dados WHERE Checks = 1 INTO CURSOR cursor_4c_Dados2

                    *-- SCAN 1: montar lista de destinatarios + capturar dados do primeiro
                    SELECT cursor_4c_Dados2
                    GO TOP
                    SCAN
                        IF RECNO() = 1
                            loc_cReceptor       = ALLTRIM(NVL(cursor_4c_Dados2.emails,    ""))
                            loc_cTxtPrioridade  = ALLTRIM(NVL(cursor_4c_Dados2.prioridade, "NORMAL"))
                            loc_cMensagemAlerta = ALLTRIM(NVL(cursor_4c_Dados2.mensagems, ""))
                        ELSE
                            IF !EMPTY(ALLTRIM(NVL(cursor_4c_Dados2.emails, "")))
                                loc_cReceptorCopia = loc_cReceptorCopia + ;
                                    IIF(!EMPTY(loc_cReceptorCopia), "; ", "") + ;
                                    ALLTRIM(cursor_4c_Dados2.emails)
                            ENDIF
                        ENDIF
                    ENDSCAN

                    *-- Assunto baseado na prioridade do primeiro destinatario (identico ao SCX)
                    loc_cAssunto = "ALERTA - " + IIF(!EMPTY(loc_cTxtPrioridade), loc_cTxtPrioridade, "NORMAL")

                    *-- Montar corpo completo do email (replica SCX SIGPREML.btnEmail.Click)
                    loc_cTxtMensagem = ""
                    IF !EMPTY(loc_cJobDesc)
                        loc_cTxtMensagem = loc_cTxtMensagem + ;
                            "JOB          : " + loc_cJobDesc + " - " + ;
                            loc_cClienteDesc + CHR(13) + CHR(10)
                    ENDIF
                    IF !EMPTY(loc_cDescritivo)
                        loc_cTxtMensagem = loc_cTxtMensagem + ;
                            "Descritivo : " + loc_cDescritivo + CHR(13) + CHR(10)
                    ENDIF
                    loc_cTxtMensagem = loc_cTxtMensagem + ;
                        "Movimenta" + CHR(231) + CHR(227) + "o : " + ;
                        loc_cEmpMv + " / " + loc_cDopeMv + " / " + loc_cNumMv + CHR(13) + CHR(10) + ;
                        "A" + CHR(231) + CHR(227) + "o         : " + loc_cEscolhaDesc + CHR(13) + CHR(10) + ;
                        "Usu" + CHR(225) + "rio      : " + gc_4c_UsuarioLogado + CHR(13) + CHR(10) + ;
                        "Data         : " + TTOC(DATETIME()) + CHR(13) + CHR(10)
                    IF !EMPTY(loc_cMensagemAlerta)
                        loc_cTxtMensagem = loc_cTxtMensagem + ;
                            "Mensagem     : " + loc_cMensagemAlerta + CHR(13) + CHR(10)
                    ENDIF
                    IF !EMPTY(loc_cObses)
                        loc_cTxtMensagem = loc_cTxtMensagem + ;
                            "Observa" + CHR(231) + CHR(227) + "o   : " + loc_cObses
                    ENDIF

                    *-- Enviar email principal via SQL Server Database Mail
                    IF !EMPTY(loc_cReceptor)
                        loc_cSQL = "EXEC msdb.dbo.sp_send_dbmail " + ;
                            "@profile_name = " + EscaparSQL("SIGE") + ", " + ;
                            "@recipients = " + EscaparSQL(loc_cReceptor) + ", " + ;
                            "@copy_recipients = " + EscaparSQL(loc_cReceptorCopia) + ", " + ;
                            "@body = " + EscaparSQL(loc_cTxtMensagem) + ", " + ;
                            "@subject = " + EscaparSQL(loc_cAssunto) + ", " + ;
                            "@from_address = " + EscaparSQL(loc_oBO.this_cAleEmails)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                            loc_lResultado = .T.
                        ELSE
                            MsgErro("Falha ao enviar email via SQL Server Database Mail. " + ;
                                    "Verifique a configura" + CHR(231) + CHR(227) + ;
                                    "o de email do servidor.", "Erro")
                        ENDIF
                    ELSE
                        MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado possui email cadastrado.", ;
                                 "Aviso")
                    ENDIF

                    IF loc_lResultado
                        *-- SCAN 2: registrar historico para cada destinatario selecionado
                        SELECT cursor_4c_Dados2
                        GO TOP
                        SCAN
                            loc_cPkNovo = fUniqueIds()
                            loc_oBO.InserirAlertaHistoricoItem(loc_cPkNovo, ;
                                loc_cTxtMensagem, ;
                                ALLTRIM(NVL(cursor_4c_Dados2.Contas, "")), ;
                                ALLTRIM(NVL(cursor_4c_Dados2.Rclis,  "")), ;
                                ALLTRIM(NVL(cursor_4c_Dados2.emails, "")), ;
                                ALLTRIM(NVL(cursor_4c_Dados2.mensagems, "")), ;
                                THIS.this_cPrDopes, ;
                                THIS.this_cEscolha, ;
                                ALLTRIM(NVL(cursor_4c_Dados2.prioridade, "NORMAL")))
                        ENDSCAN

                        *-- Processar e enviar segundo email para operacoes baixadas
                        IF USED("cursor_4c_OpeBaixa") AND RECCOUNT("cursor_4c_OpeBaixa") > 0
                            loc_cReceptor2    = ""
                            loc_cCopia2       = ""
                            loc_cTxtMensagem2 = ""
                            loc_cPrio2        = "NORMAL"
                            loc_lPrimeiro     = .T.

                            SELECT cursor_4c_OpeBaixa
                            GO TOP
                            SCAN
                                IF loc_lPrimeiro
                                    loc_cReceptor2 = ALLTRIM(NVL(cursor_4c_OpeBaixa.emails, ""))
                                    loc_cPrio2     = ALLTRIM(NVL(cursor_4c_OpeBaixa.Prioridade, "NORMAL"))
                                    loc_cEDN2      = ALLTRIM(NVL(cursor_4c_OpeBaixa.EmpDopNums, ""))
                                    loc_cEmp2      = SUBSTR(loc_cEDN2, 1, 3)
                                    loc_cDope2     = ALLTRIM(SUBSTR(loc_cEDN2, 4, 20))
                                    loc_cNum2      = ALLTRIM(SUBSTR(loc_cEDN2, 24, 6))

                                    *-- Corpo do segundo email com info da movimentacao baixada
                                    loc_cTxtMensagem2 = ""
                                    IF !EMPTY(loc_cJobDesc)
                                        loc_cTxtMensagem2 = loc_cTxtMensagem2 + ;
                                            "JOB          : " + loc_cJobDesc + " - " + ;
                                            loc_cClienteDesc + CHR(13) + CHR(10)
                                    ENDIF
                                    IF !EMPTY(loc_cDescritivo)
                                        loc_cTxtMensagem2 = loc_cTxtMensagem2 + ;
                                            "Descritivo : " + loc_cDescritivo + CHR(13) + CHR(10)
                                    ENDIF
                                    loc_cTxtMensagem2 = loc_cTxtMensagem2 + ;
                                        "Movimenta" + CHR(231) + CHR(227) + "o : " + ;
                                        loc_cEmpMv + " / " + loc_cDopeMv + " / " + loc_cNumMv + CHR(13) + CHR(10) + ;
                                        "A" + CHR(231) + CHR(227) + "o         : " + loc_cEscolhaDesc + CHR(13) + CHR(10) + ;
                                        "Movimenta" + CHR(231) + CHR(227) + "o baixada" + ;
                                        IIF(ALLTRIM(THIS.this_cEscolha) = "EXCLUIR", " cancelada", "") + ;
                                        ": " + loc_cEmp2 + " / " + loc_cDope2 + " / " + loc_cNum2 + CHR(13) + CHR(10) + ;
                                        "Usu" + CHR(225) + "rio      : " + gc_4c_UsuarioLogado + CHR(13) + CHR(10) + ;
                                        "Data         : " + TTOC(DATETIME()) + CHR(13) + CHR(10)
                                    IF !EMPTY(ALLTRIM(NVL(cursor_4c_OpeBaixa.mensagems, "")))
                                        loc_cTxtMensagem2 = loc_cTxtMensagem2 + ;
                                            "Mensagem     : " + ALLTRIM(cursor_4c_OpeBaixa.mensagems) + CHR(13) + CHR(10)
                                    ENDIF
                                    IF !EMPTY(loc_cObses)
                                        loc_cTxtMensagem2 = loc_cTxtMensagem2 + ;
                                            "Observa" + CHR(231) + CHR(227) + "o   : " + loc_cObses
                                    ENDIF
                                    loc_lPrimeiro = .F.
                                ELSE
                                    IF !EMPTY(ALLTRIM(NVL(cursor_4c_OpeBaixa.emails, "")))
                                        loc_cCopia2 = loc_cCopia2 + ;
                                            IIF(!EMPTY(loc_cCopia2), "; ", "") + ;
                                            ALLTRIM(cursor_4c_OpeBaixa.emails)
                                    ENDIF
                                ENDIF

                                *-- Registrar historico para este registro de baixa
                                IF !EMPTY(ALLTRIM(NVL(cursor_4c_OpeBaixa.emails, "")))
                                    loc_cPkNovo = fUniqueIds()
                                    loc_oBO.InserirAlertaHistoricoItem(loc_cPkNovo, ;
                                        loc_cTxtMensagem2, ;
                                        ALLTRIM(NVL(cursor_4c_OpeBaixa.Contas, "")), ;
                                        "", ;
                                        ALLTRIM(NVL(cursor_4c_OpeBaixa.emails, "")), ;
                                        ALLTRIM(NVL(cursor_4c_OpeBaixa.Mensagems, "")), ;
                                        ALLTRIM(NVL(cursor_4c_OpeBaixa.EmpDopNums, THIS.this_cPrDopes)), ;
                                        "BAIXAR", ;
                                        ALLTRIM(NVL(cursor_4c_OpeBaixa.Prioridade, "NORMAL")))
                                ENDIF
                            ENDSCAN

                            *-- Enviar segundo email para destinatarios de baixas
                            IF !EMPTY(loc_cReceptor2)
                                loc_cAssunto2 = "ALERTA - " + IIF(!EMPTY(loc_cPrio2), loc_cPrio2, "NORMAL")
                                loc_cSQL = "EXEC msdb.dbo.sp_send_dbmail " + ;
                                    "@profile_name = " + EscaparSQL("SIGE") + ", " + ;
                                    "@recipients = " + EscaparSQL(loc_cReceptor2) + ", " + ;
                                    "@copy_recipients = " + EscaparSQL(loc_cCopia2) + ", " + ;
                                    "@body = " + EscaparSQL(loc_cTxtMensagem2) + ", " + ;
                                    "@subject = " + EscaparSQL(loc_cAssunto2) + ", " + ;
                                    "@from_address = " + EscaparSQL(loc_oBO.this_cAleEmails)
                                SQLEXEC(gnConnHandle, loc_cSQL)
                            ENDIF
                        ENDIF

                        *-- Fechar cursor temporario antes de liberar form
                        IF USED("cursor_4c_Dados2")
                            USE IN cursor_4c_Dados2
                        ENDIF

                        MsgInfo("Email enviado com sucesso para " + ;
                                TRANSFORM(loc_nSelecionados) + " destinat" + CHR(225) + ;
                                "rio(s).", "Email Enviado")
                        THIS.Release()
                    ENDIF

                    IF USED("cursor_4c_Dados2")
                        USE IN cursor_4c_Dados2
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Dados2")
                USE IN cursor_4c_Dados2
            ENDIF
            MsgErro("Erro ao enviar email:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdColContaClick - Ordena grid por Conta; destaca header ativo
    * Ref SCX: SIGPREML.grade_alerta.Column2.Header1.Click
    *--------------------------------------------------------------------------
    PROCEDURE GrdColContaClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG Contas
        ENDIF
        THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdColNomeClick - Ordena grid por Nome/Rclis; destaca header ativo
    * Ref SCX: SIGPREML.grade_alerta.Column3.Header1.Click
    *--------------------------------------------------------------------------
    PROCEDURE GrdColNomeClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG Rclis
        ENDIF
        THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdColEmailClick - Ordena grid por Email; destaca header ativo
    * Ref SCX: SIGPREML.grade_alerta.Column4.Header1.Click
    *--------------------------------------------------------------------------
    PROCEDURE GrdColEmailClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG Emails
        ENDIF
        THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
    * SCX SIGPREML nao possui botao Incluir; destinatarios sao carregados
    * automaticamente por CarregarDados via BO.CarregarAlertasEmail.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form OPERACIONAL nao tem fluxo de alteracao CRUD
    * SCX SIGPREML nao possui botao Alterar; edicao de email/mensagem eh
    * inline no grid (colunas com ReadOnly=.F.).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Form OPERACIONAL nao tem fluxo de visualizacao CRUD
    * SCX SIGPREML ja apresenta todos os dados diretamente no grid
    * grade_alerta; nao ha modo de visualizacao separado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form OPERACIONAL nao tem fluxo de exclusao CRUD
    * SCX SIGPREML nao possui botao Excluir; desmarcar destinatarios eh
    * feito via cmd_4c_Apaga (CmdApagaClick) que zera todos os Checks.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista de destinatarios (atualiza grid)
    * Util para refresh manual apos alteracoes externas no cadastro de alertas
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * Wrapper canonico chamado pelo pipeline; delega a CmdEncerrarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form OPERACIONAL: sem campos de entrada para salvar
    * Semantica: confirmar selecao atual e enviar email (delega a CmdBtnEmailClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdBtnEmailClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela a operacao e fecha o formulario
    * Limpa selecoes antes de fechar para indicar cancelamento ao chamador
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias canonico para CarregarDados (compatibilidade pipeline)
    * Forms OPERACIONAIS usam CarregarDados; este alias permite chamadas
    * padronizadas pelo pipeline multi-fase (ex: BtnBuscarClick -> CarregarLista)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Form OPERACIONAL: destinatarios carregados pelo BO via SQL
    * Nao ha campos de entrada para transferir; compatibilidade com pipeline
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        *-- OPERACIONAL: dados carregados diretamente por CarregarDados/BO
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Recarrega grid com dados atuais do BO
    * Util quando chamador externo altera o BO e precisa atualizar a exibicao
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        RETURN THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Form OPERACIONAL sem campos CRUD editaveis por modo
    * Metodo presente para compatibilidade com o pipeline de migracao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- OPERACIONAL: edicao inline no grid nao depende de modo CRUD
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Desmarca todos os destinatarios (Checks=0)
    * Usado por BtnCancelarClick para sinalizar cancelamento ao chamador
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form OPERACIONAL sem botoes CRUD com modo variavel
    * Metodo presente para compatibilidade com o pipeline de migracao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- OPERACIONAL: sem botoes CRUD com aparencia por modo
        RETURN .T.
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEmlBO.prg):
*==============================================================================
* SIGPREMLBO.PRG
* Business Object para Alerta de Email (SIGPREML)
* Entidade: SigAlert
* Tipo: OPERACIONAL
*==============================================================================

DEFINE CLASS SigPrEmlBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela         = "SigAlert"
    this_cCampoChave     = "PkChaves"

    *-- Chave primaria
    this_cPkChaves       = ""

    *-- Campos principais de SigAlert
    this_cContas         = ""    && Conta do cliente C(10)
    this_cGrupos         = ""    && Grupo C(10)
    this_cEmps           = ""    && Empresa C(3)
    this_cDopes          = ""    && Operacao C(20)
    this_nNumes          = 0     && Numero N(6,0)
    this_cAcaos          = ""    && Acao C(10)
    this_cUsuars         = ""    && Usuario
    this_dDtAlerts       = {}    && Data/hora do alerta
    this_cMsg1s          = ""    && Mensagem 1 (texto)
    this_cMensagems      = ""    && Mensagem (memo)
    this_cEmails         = ""    && Email C(50)
    this_cPrioridade     = ""    && Prioridade C(15): URGENTE/IMPORTANTE/NORMAL
    this_cEmpDopNums     = ""    && Composto empresa+dope+numero C(29)
    this_nPriors         = 0     && Prioridade numerica N(1): 1=URGENTE,2=IMPORTANTE,3=NORMAL
    this_cRclis          = ""    && Nome do cliente C(30)

    *-- Parametros de contexto recebidos pelo form
    this_cPrDopes        = ""    && Parametro completo (empresa+dope+numero) C(29)
    this_cEmp            = ""    && Codigo da empresa (3 primeiros chars de PrDopes)
    this_cDope           = ""    && Codigo da operacao (chars 4-23 de PrDopes)
    this_cEscolha        = ""    && Escolha de acao: INSERIR/ALTERAR/EXCLUIR

    *-- Dados de email da empresa (lidos de SigCdEmp)
    this_cAleServs       = ""    && Servidor SMTP
    this_cAleEmails      = ""    && Email remetente
    this_cAleSenhas      = ""    && Senha do email
    this_nAlePortas      = 0     && Porta SMTP

    *-- Conexao secundaria para banco ALERTA (SigAlert)
    this_nConnAlerta     = 0

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT("SigAlert")
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF THIS.this_nConnAlerta > 0
            SQLDISCONNECT(THIS.this_nConnAlerta)
            THIS.this_nConnAlerta = 0
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarConexaoAlerta - Abre conexao com banco ALERTA
    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexaoAlerta()
        LOCAL loc_lResultado, loc_cConnStr, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cConnStr = "DRIVER={SQL Server};" + ;
                           "SERVER=192.168.15.101;" + ;
                           "DATABASE=ALERTA;" + ;
                           "UID=sa;PWD=s@4control;"
            THIS.this_nConnAlerta = SQLSTRINGCONNECT(loc_cConnStr)
            IF THIS.this_nConnAlerta > 0
                SQLSETPROP(THIS.this_nConnAlerta, "DispWarnings", .F.)
                SQLSETPROP(THIS.this_nConnAlerta, "Asynchronous", .F.)
                loc_lResultado = .T.
            ELSE
                MsgErro("Imposs" + CHR(237) + "vel conectar ao banco ALERTA.", ;
                        "Erro de Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor SigAlert
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves    = TratarNulo(PkChaves,    "C")
                THIS.this_cContas      = TratarNulo(Contas,      "C")
                THIS.this_cGrupos      = TratarNulo(Grupos,      "C")
                THIS.this_cEmps        = TratarNulo(Emps,        "C")
                THIS.this_cDopes       = TratarNulo(Dopes,       "C")
                THIS.this_nNumes       = TratarNulo(Numes,       "N")
                THIS.this_cAcaos       = TratarNulo(Acaos,       "C")
                THIS.this_cUsuars      = TratarNulo(Usuars,      "C")
                THIS.this_cMsg1s       = TratarNulo(Msg1s,       "C")
                THIS.this_cMensagems   = TratarNulo(Mensagems,   "C")
                THIS.this_cEmails      = TratarNulo(Emails,      "C")
                THIS.this_cEmpDopNums  = TratarNulo(EmpDopNums,  "C")
                THIS.this_cRclis       = TratarNulo(Rclis,       "C")
                THIS.this_nPriors      = TratarNulo(Priors,      "N")
                IF THIS.this_nPriors = 1
                    THIS.this_cPrioridade = "URGENTE"
                ELSE
                    IF THIS.this_nPriors = 2
                        THIS.this_cPrioridade = "IMPORTANTE"
                    ELSE
                        THIS.this_cPrioridade = "NORMAL"
                    ENDIF
                ENDIF
                IF TYPE(par_cAliasCursor + ".DtAlerts") != "U"
                    THIS.this_dDtAlerts = TratarNulo(DtAlerts, "D")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cContas)
            MsgAviso("Conta n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmails)
            MsgAviso("Email n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigAlert (banco ALERTA)
    * Requer this_nConnAlerta ja inicializado via InicializarConexaoAlerta()
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cPkChaves = fUniqueIds()
                THIS.this_dDtAlerts = DATETIME()
                THIS.this_cEmps     = SUBSTR(THIS.this_cEmpDopNums, 1, 3)
                THIS.this_cDopes    = ALLTRIM(SUBSTR(THIS.this_cEmpDopNums, 4, 20))
                THIS.this_nNumes    = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
                THIS.this_cUsuars   = gc_4c_UsuarioLogado

                loc_cSQL = "INSERT INTO SigAlert " + ;
                    "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, " + ;
                    "Msg2s, Msg1s, Priors, Acaos, " + ;
                    "Usuars, DtAlerts, EmpDopNums) VALUES (" + ;
                    EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                    EscaparSQL(THIS.this_cEmps) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                    EscaparSQL(THIS.this_cContas) + ", " + ;
                    EscaparSQL(THIS.this_cGrupos) + ", " + ;
                    EscaparSQL(THIS.this_cMensagems) + ", " + ;
                    EscaparSQL(THIS.this_cMsg1s) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
                    EscaparSQL(THIS.this_cAcaos) + ", " + ;
                    EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(THIS.this_cEmpDopNums) + ")"

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao registrar alerta de email no banco ALERTA.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigAlert (banco ALERTA)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cUsuars = gc_4c_UsuarioLogado

                loc_cSQL = "UPDATE SigAlert SET " + ;
                    "Contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
                    "Grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
                    "Msg2s = " + EscaparSQL(THIS.this_cMensagems) + ", " + ;
                    "Msg1s = " + EscaparSQL(THIS.this_cMsg1s) + ", " + ;
                    "Priors = " + FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
                    "Acaos = " + EscaparSQL(THIS.this_cAcaos) + ", " + ;
                    "Usuars = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums) + " " + ;
                    "WHERE PkChaves = " + EscaparSQL(THIS.this_cPkChaves)

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                    THIS.RegistrarAuditoria("ALTERAR")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar alerta de email.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigAlert (banco ALERTA)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigAlert WHERE PkChaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir alerta de email.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertasEmail - Carrega lista de destinatarios para o cursor do form
    * Popula cursor_4c_Dados (estrutura identica a crLocalTotal do legado)
    * par_cPrDopes: empresa(3)+dope(20)+numero(6) concatenados
    * par_cEscolha: INSERIR | ALTERAR | EXCLUIR
    * par_laOpeBaixa: array de EmpDopNums de operacoes baixadas (ou .F. se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAlertasEmail(par_cPrDopes, par_cEscolha, par_laOpeBaixa)
        LOCAL loc_lResultado, loc_cSQL, loc_cDopes, loc_oErro
        LOCAL loc_cDope, loc_cEDN, loc_nX, loc_cConta, loc_cRclis
        loc_lResultado = .F.
        loc_cDope      = ""
        loc_cEDN       = ""
        TRY
            THIS.this_cPrDopes = par_cPrDopes
            THIS.this_cEscolha = par_cEscolha
            THIS.this_cEmp     = SUBSTR(par_cPrDopes, 1, 3)
            loc_cDopes         = ALLTRIM(SUBSTR(par_cPrDopes, 4, 20))

            SET NULL ON
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            CREATE CURSOR cursor_4c_Dados (Checks N(1) NULL, grupos C(10) NULL, ;
                Contas C(10) NULL, Rclis C(30) NULL, emails C(50) NULL, ;
                mensagems M NULL, prioridade C(15) NULL, ;
                EmpDopNums C(29) NULL, Acaos C(10) NULL)
            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON emails TAG Emails
            SET NULL OFF

            *-- Buscar dados da movimentacao (cabecalho + cliente)
            IF USED("cursor_4c_MvCab")
                USE IN cursor_4c_MvCab
            ENDIF
            loc_cSQL = "SELECT a.EmpDopNums, a.Jobs, b.Rclis, a.ObsCabMovs, a.Obses " + ;
                       "FROM SigMvcab a INNER JOIN SigCdCli b ON a.Jobs = b.Iclis " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(par_cPrDopes)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab") >= 1
                SELECT cursor_4c_MvCab
                GO TOP

                *-- Buscar alertas configurados em SigCdAle
                IF USED("cursor_4c_Ale")
                    USE IN cursor_4c_Ale
                ENDIF
                loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
                           "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
                           "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                           "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                           "ELSE 'NORMAL' END AS prioridade, " + ;
                           "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
                           "'" + par_cPrDopes + "' AS EmpDopNums " + ;
                           "FROM SigCdAle ALE " + ;
                           "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.Iclis " + ;
                           "WHERE ALE.Dopes = " + EscaparSQL(loc_cDopes) + " AND " + ;
                           IIF(par_cEscolha = "INSERIR", "ALE.inserirs = 1 ", ;
                           IIF(par_cEscolha = "ALTERAR", "ALE.alterars = 1 ", ;
                           IIF(par_cEscolha = "EXCLUIR", "ALE.excluirs = 1 ", "1 = 1 ")))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ale") >= 1
                    *-- Filtrar por job e inserir em cursor_4c_Dados
                    SELECT cursor_4c_Ale
                    GO TOP
                    SCAN
                        IF USED("cursor_4c_ClJob")
                            USE IN cursor_4c_ClJob
                        ENDIF
                        loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = '" + ;
                                   ALLTRIM(cursor_4c_Ale.Contas) + "'"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClJob")
                        SELECT cursor_4c_ClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_MvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_Ale
                                LOOP
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Dados
                        INSERT INTO cursor_4c_Dados ;
                            (Checks, grupos, Contas, Rclis, emails, ;
                             mensagems, prioridade, EmpDopNums, Acaos) ;
                            VALUES (cursor_4c_Ale.Checks, cursor_4c_Ale.grupos, ;
                                    cursor_4c_Ale.Contas, cursor_4c_Ale.Rclis, ;
                                    cursor_4c_Ale.emails, NVL(cursor_4c_Ale.mensagems, ""), ;
                                    cursor_4c_Ale.prioridade, par_cPrDopes, par_cEscolha)
                        SELECT cursor_4c_Ale
                    ENDSCAN
                ELSE
                    MsgErro("Falha ao buscar alertas configurados.", "Erro")
                ENDIF

                *-- Buscar destinatarios de SigCdPam (grupos de alerta parametrizados)
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_cSQL = "SELECT 0 AS Checks, CLI.grupos, CLI.iclis AS Contas, " + ;
                           "CLI.rclis, CLI.emails, '' AS prioridade " + ;
                           "FROM SigCdPam PAM " + ;
                           "INNER JOIN SigCdCli CLI ON CLI.grupos = PAM.grpadats"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") >= 1
                    SELECT cursor_4c_Pam
                    GO TOP
                    SCAN
                        IF USED("cursor_4c_ClJob")
                            USE IN cursor_4c_ClJob
                        ENDIF
                        loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = '" + ;
                                   ALLTRIM(cursor_4c_Pam.Contas) + "'"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClJob")
                        SELECT cursor_4c_ClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_MvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_Pam
                                LOOP
                            ENDIF
                        ENDIF

                        loc_cConta = cursor_4c_Pam.Contas
                        loc_cRclis = cursor_4c_Pam.Rclis
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.Contas) = ALLTRIM(loc_cConta) ;
                               AND ALLTRIM(cursor_4c_Dados.Rclis)  = ALLTRIM(loc_cRclis)
                        IF EOF()
                            INSERT INTO cursor_4c_Dados ;
                                (Checks, grupos, Contas, Rclis, emails, ;
                                 EmpDopNums, Acaos, prioridade) ;
                                VALUES (cursor_4c_Pam.Checks, "", loc_cConta, ;
                                        loc_cRclis, cursor_4c_Pam.emails, ;
                                        par_cPrDopes, par_cEscolha, "NORMAL")
                        ENDIF
                        SELECT cursor_4c_Pam
                    ENDSCAN
                ELSE
                    MsgErro("Falha ao buscar destinat" + CHR(225) + "rios de grupo.", "Erro")
                ENDIF

                *-- Processar operacoes de baixa (laOpeBaixa), se array valido
                IF TYPE("par_laOpeBaixa", 1) = "A"
                    FOR loc_nX = 1 TO ALEN(par_laOpeBaixa)
                        IF !EMPTY(par_laOpeBaixa(loc_nX))
                            IF EMPTY(loc_cDope)
                                loc_cDope = "('" + ALLTRIM(SUBSTR(par_laOpeBaixa(loc_nX), 4, 20)) + "'"
                                loc_cEDN  = "('" + ALLTRIM(par_laOpeBaixa(loc_nX)) + "'"
                            ELSE
                                loc_cDope = loc_cDope + ",'" + ALLTRIM(SUBSTR(par_laOpeBaixa(loc_nX), 4, 20)) + "'"
                                loc_cEDN  = loc_cEDN  + ",'" + ALLTRIM(par_laOpeBaixa(loc_nX)) + "'"
                            ENDIF
                        ENDIF
                    NEXT
                    IF !EMPTY(loc_cDope)
                        loc_cDope = loc_cDope + ") "
                        loc_cEDN  = loc_cEDN  + ") "
                        THIS.CarregarAlertasBaixa(par_cPrDopes, par_cEscolha, loc_cDope, loc_cEDN)
                    ENDIF
                ENDIF

                SELECT cursor_4c_Dados
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Falha ao buscar dados da movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertasBaixa - Processa alertas de operacoes baixadas
    * Popula cursor_4c_OpeBaixa (usado pelo form no envio do segundo email)
    * par_cDope: lista IN de codigos de operacao ex: "('FRET','DESPA') "
    * par_cEDN:  lista IN de EmpDopNums    ex: "('001FRET  000001') "
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarAlertasBaixa(par_cPrDopes, par_cEscolha, par_cDope, par_cEDN)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_OpeBaixa")
                USE IN cursor_4c_OpeBaixa
            ENDIF

            *-- Tentar buscar na ALERTA primeiro (alertas ja enviados para baixa)
            loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, Numes, " + ;
                       "SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
                       "Msg1s AS Mensagems, 1 AS Checks " + ;
                       "FROM SigAlert WHERE EmpDopNums IN " + par_cEDN + ;
                       " AND Acaos = 'BAIXAR'"
            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, "cursor_4c_OpeBaixa") < 1
                *-- Fallback: buscar na SIGE via SigCdAle (baixas configuradas)
                loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
                           "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
                           "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                           "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                           "ELSE 'NORMAL' END AS prioridade, " + ;
                           "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
                           "SPACE(29) AS EmpDopNums, '" + par_cEscolha + "' AS Acaos " + ;
                           "FROM SigCdAle ALE " + ;
                           "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.Iclis " + ;
                           "WHERE ALE.Dopes IN " + par_cDope + " AND ALE.baixas = 1"
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeBaixa")
            ENDIF

            IF USED("cursor_4c_OpeBaixa")
                *-- Buscar emails e prioridade para cada conta
                SELECT cursor_4c_OpeBaixa
                GO TOP
                SCAN
                    IF USED("cursor_4c_CliEmail")
                        USE IN cursor_4c_CliEmail
                    ENDIF
                    loc_cSQL = "SELECT a.Emails, " + ;
                               "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
                               "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                               "ELSE 'NORMAL' END AS prioridade, b.mensagems " + ;
                               "FROM SigCdCli a INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
                               "WHERE a.Iclis = '" + ALLTRIM(cursor_4c_OpeBaixa.Contas) + ;
                               "' AND b.Dopes = '" + ALLTRIM(cursor_4c_OpeBaixa.Dopes) + "'"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliEmail")
                    IF USED("cursor_4c_CliEmail") AND !EOF("cursor_4c_CliEmail")
                        SELECT cursor_4c_OpeBaixa
                        REPLACE emails     WITH cursor_4c_CliEmail.Emails
                        REPLACE prioridade WITH cursor_4c_CliEmail.prioridade
                        REPLACE mensagems  WITH cursor_4c_CliEmail.mensagems
                    ENDIF
                    SELECT cursor_4c_OpeBaixa
                ENDSCAN
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConfigEmailEmpresa - Busca config SMTP de SigCdEmp
    * Popula this_cAleServs, this_cAleEmails, this_cAleSenhas, this_nAlePortas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfigEmailEmpresa()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ConfigEmail")
                USE IN cursor_4c_ConfigEmail
            ENDIF
            loc_cSQL = "SELECT AleServs, AleEmails, AleSenhas, AlePortas " + ;
                       "FROM SigCdEmp WHERE CEmps = '" + ALLTRIM(THIS.this_cEmp) + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigEmail") >= 1
                SELECT cursor_4c_ConfigEmail
                IF !EOF()
                    THIS.this_cAleServs  = ALLTRIM(TratarNulo(AleServs,  "C"))
                    THIS.this_cAleEmails = ALLTRIM(TratarNulo(AleEmails, "C"))
                    THIS.this_cAleSenhas = ALLTRIM(TratarNulo(AleSenhas, "C"))
                    THIS.this_nAlePortas = TratarNulo(AlePortas, "N")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o de email n" + CHR(227) + ;
                            "o encontrada para empresa '" + ALLTRIM(THIS.this_cEmp) + "'.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao buscar configura" + CHR(231) + CHR(227) + "o de email.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirAlertaHistoricoItem - Insere UM registro em SigAlert (banco ALERTA)
    * Chamado pelo form para cada destinatario selecionado no grid
    * par_cMsg1s:     texto completo da mensagem montada pelo form
    * par_cEmpDopNums: empresa(3)+dope(20)+numero(6) concatenados
    * par_cAcaos:     INSERIR | ALTERAR | EXCLUIR | BAIXAR
    * par_cPrioridade: URGENTE | IMPORTANTE | NORMAL
    *--------------------------------------------------------------------------
    PROCEDURE InserirAlertaHistoricoItem(par_cPkChaves, par_cMsg1s, par_cContas, ;
                                         par_cRclis, par_cEmails, par_cMensagems, ;
                                         par_cEmpDopNums, par_cAcaos, par_cPrioridade)
        LOCAL loc_lResultado, loc_cSQL, loc_nPriors, loc_oErro
        loc_lResultado = .F.
        TRY
            DO CASE
                CASE ALLTRIM(par_cPrioridade) = "URGENTE"
                    loc_nPriors = 1
                CASE ALLTRIM(par_cPrioridade) = "IMPORTANTE"
                    loc_nPriors = 2
                OTHERWISE
                    loc_nPriors = 3
            ENDCASE

            loc_cSQL = "INSERT INTO SigAlert " + ;
                "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, " + ;
                "Msg2s, Msg1s, Priors, Acaos, Usuars, DtAlerts, EmpDopNums) " + ;
                "VALUES (" + ;
                EscaparSQL(par_cPkChaves) + ", " + ;
                EscaparSQL(SUBSTR(par_cEmpDopNums, 1, 3)) + ", " + ;
                EscaparSQL(ALLTRIM(SUBSTR(par_cEmpDopNums, 4, 20))) + ", " + ;
                FormatarNumeroSQL(VAL(SUBSTR(par_cEmpDopNums, 24, 6))) + ", " + ;
                EscaparSQL(par_cContas) + ", " + ;
                EscaparSQL("") + ", " + ;
                EscaparSQL(par_cMensagems) + ", " + ;
                EscaparSQL(par_cMsg1s) + ", " + ;
                FormatarNumeroSQL(loc_nPriors) + ", " + ;
                EscaparSQL(par_cAcaos) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(par_cEmpDopNums) + ")"

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao registrar alerta no hist" + CHR(243) + "rico.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


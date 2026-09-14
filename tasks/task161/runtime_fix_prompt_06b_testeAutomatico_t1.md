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
[02/07/2026 04:53:49 AM] Erro de Inicialização: Property BACKSTYLE is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-02 04:53:34] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-02 04:53:34] [INFO] Config FPW: (nao fornecido)
[2026-07-02 04:53:34] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 04:53:34] [INFO] Timeout: 300 segundos
[2026-07-02 04:53:34] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k1c1rw2q.prg
[2026-07-02 04:53:34] [INFO] Conteudo do wrapper:
[2026-07-02 04:53:34] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task161', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCfn', 'C:\4c\tasks\task161', 'OPERACIONAL'
QUIT

[2026-07-02 04:53:34] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k1c1rw2q.prg
[2026-07-02 04:53:34] [INFO] VFP output esperado em: C:\4c\tasks\task161\vfp_output.txt
[2026-07-02 04:53:34] [INFO] Executando Visual FoxPro 9...
[2026-07-02 04:53:34] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k1c1rw2q.prg
[2026-07-02 04:53:34] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k1c1rw2q.prg
[2026-07-02 04:53:34] [INFO] Timeout configurado: 300 segundos
[2026-07-02 04:53:50] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-02 04:53:50] [INFO] VFP9 finalizado em 15.1989038 segundos
[2026-07-02 04:53:50] [INFO] Exit Code: 
[2026-07-02 04:53:50] [INFO] 
[2026-07-02 04:53:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-02 04:53:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k1c1rw2q.prg
[2026-07-02 04:53:50] [INFO] 
[2026-07-02 04:53:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-02 04:53:50] [INFO] * Auto-generated wrapper for parameters
[2026-07-02 04:53:50] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 04:53:50] [INFO] * Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task161', 'OPERACIONAL'
[2026-07-02 04:53:50] [INFO] 
[2026-07-02 04:53:50] [INFO] * Anti-dialog protections for unattended execution
[2026-07-02 04:53:50] [INFO] SET SAFETY OFF
[2026-07-02 04:53:50] [INFO] SET RESOURCE OFF
[2026-07-02 04:53:50] [INFO] SET TALK OFF
[2026-07-02 04:53:50] [INFO] SET NOTIFY OFF
[2026-07-02 04:53:50] [INFO] SYS(2335, 0)
[2026-07-02 04:53:50] [INFO] 
[2026-07-02 04:53:50] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCfn', 'C:\4c\tasks\task161', 'OPERACIONAL'
[2026-07-02 04:53:50] [INFO] QUIT
[2026-07-02 04:53:50] [INFO] 
[2026-07-02 04:53:50] [INFO] === Fim do Wrapper.prg ===
[2026-07-02 04:53:50] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrCfn",
  "timestamp": "20260702045349",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg):
*===============================================================================
* FormSigPrCfn.prg - C" + CHR(225) + "lculo de Juros
* Herda de: FormBase
* Tipo: OPERACIONAL (calculadora de juros - sem tabela BD)
* Chamada: CREATEOBJECT("FormSigPrCfn", pVal, pTip, pJMe, pJDi, pDtB, pDtF)
*   pVal = Valor Base (N)
*   pTip = Tipo de C" + CHR(225) + "lculo (1=Simples; 2=Composto)
*   pJMe = Juros ao M" + CHR(234) + "s (N)
*   pJDi = Juros ao Dia - relevante somente se pJMe n" + CHR(227) + "o informado (N)
*   pDtB = Data Base (D)
*   pDtF = Data Final (D) - se vazio usa DATE() quando pDtB informado
*
* Estrutura (completo):
*   - cnt_4c_Cabecalho (header cinza com titulo)
*   - pgf_4c_Paginas.Page1: Calculo (ValorBase, Juros, Datas, Dias, resultados)
*   - pgf_4c_Paginas.Page2: Vencimentos (10 campos de data - venc1 a venc10)
*   - cnt_4c_Botoes (container overlay para botao Encerrar)
*   - cnt_4c_BotoesAcao (container de botoes de acao)
*===============================================================================

DEFINE CLASS FormSigPrCfn AS FormBase

    Width       = 620
    Height      = 350
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    DataSession = 2
    BorderStyle = 2

    *-- Parametros recebidos do chamador (armazenados antes de DODEFAULT)
    this_nParValorBase   = 0
    this_nParTipoCalculo = 1
    this_nParJurosMes    = 0
    this_nParJurosDia    = 0
    this_dParDataBase    = {}
    this_dParDataFinal   = {}

    *-- Business Object de calculo
    this_oBusinessObject = .NULL.

    *-- Modo do formulario (calculadora nao muda de modo, mas mantem para compatibilidade)
    this_cModoAtual = "CALCULO"

    *===========================================================================
    * Init - Recebe parametros do chamador e aciona inicializacao via FormBase
    * Armazena os parametros ANTES de DODEFAULT() invocar InicializarForm()
    *===========================================================================
    PROCEDURE Init(par_nValorBase, par_nTipoCalculo, par_nJurosMes, par_nJurosDia, ;
                   par_dDataBase, par_dDataFinal)

        IF VARTYPE(par_nValorBase) = "N" AND par_nValorBase > 0
            THIS.this_nParValorBase = par_nValorBase
        ENDIF

        IF VARTYPE(par_nTipoCalculo) = "N" AND INLIST(par_nTipoCalculo, 1, 2)
            THIS.this_nParTipoCalculo = par_nTipoCalculo
        ELSE
            THIS.this_nParTipoCalculo = 1
        ENDIF

        IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
            THIS.this_nParJurosMes = par_nJurosMes
        ENDIF

        IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
            THIS.this_nParJurosDia = par_nJurosDia
        ENDIF

        IF VARTYPE(par_dDataBase) = "D"
            THIS.this_dParDataBase = par_dDataBase
        ENDIF

        IF VARTYPE(par_dDataFinal) = "D"
            THIS.this_dParDataFinal = par_dDataFinal
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configuracao do form (chamado por FormBase.Init)
    * Cria BO, cabecalho, PageFrame e containers principais
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            *-- Criar BO de calculo
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCfnBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Definir caption do form
                THIS.Caption = "C" + CHR(225) + "lculo de Juros"

                *-- Construir cabecalho com titulo
                THIS.ConfigurarCabecalho()

                *-- Construir PageFrame com Page1 (Calculo) e Page2 (Vencimentos)
                THIS.ConfigurarPageFrame()

                *-- Propagar titulo do form para labels do cabecalho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Container overlay do botao Encerrar (sobre o cabecalho)
                THIS.ConfigurarBotoes()

                *-- Container de botoes de acao (dentro das paginas)
                THIS.ConfigurarBotoesAcao()

                *-- Conteudo das paginas (Page1=Calculo, Page2=Vencimentos)
                *-- Dispatcher unico compativel com nomenclatura CRUD do pipeline
                THIS.ConfigurarPaginaDados()

                *-- Preencher campos com parametros recebidos do chamador
                THIS.PreencherParametrosIniciais()

                *-- Torna todos os controles adicionados visiveis
                THIS.TornarControlesVisiveis(THIS)

                *-- Ativa primeira pagina do PageFrame
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrCfnBO.", ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cabecalho cinza com titulo)
    * Equivalente ao cntSombra do form original
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption, loc_nFormWidth

        loc_cCaption   = "C" + CHR(225) + "lculo de Juros"
        loc_nFormWidth = THIS.Width

        *-- Container cabecalho escuro (cntSombra)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nFormWidth
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Label sombra (preto, deslocado 1px para efeito 3D)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Width     = loc_nFormWidth
                .Height    = 40
                .Top       = 18
                .Left      = 10
                .ForeColor = RGB(0, 0, 0)
                .Caption   = loc_cCaption
                .Visible   = .T.
            ENDWITH

            *-- Label titulo (branco - texto visivel)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Width     = loc_nFormWidth
                .Height    = 46
                .Top       = 17
                .Left      = 10
                .ForeColor = RGB(255, 255, 255)
                .Caption   = loc_cCaption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Page1 e Page2)
    * Page1 = Calculo principal (campos de entrada e resultado)
    * Page2 = Vencimentos (grid de parcelas)
    * Nesta fase (3) o PageFrame eh criado vazio - conteudo entra nas fases 4-6
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_nTopPgf, loc_nHeightPgf, loc_nWidthPgf

        *-- PageFrame ocupa area abaixo do cabecalho (Top=80) ate rodape
        loc_nTopPgf    = 80
        loc_nHeightPgf = THIS.Height - loc_nTopPgf
        loc_nWidthPgf  = THIS.Width

        *-- Container do PageFrame principal
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top        = loc_nTopPgf
            .Left       = 0
            .Width      = loc_nWidthPgf
            .Height     = loc_nHeightPgf
            .PageCount  = 2
            .Tabs       = .F.
            .BorderWidth = 0
            .BackStyle   = 0
            .Themes     = .F.
            .Visible    = .T.

            *-- Page1: Calculo principal (campos serao adicionados nas Fases 4-6)
            WITH .Page1
                .Caption = "C" + CHR(225) + "lculo"
            ENDWITH

            *-- Page2: Vencimentos (parcelas serao adicionadas nas Fases 5-6)
            WITH .Page2
                .Caption = "Vencimentos"
                .BackColor = RGB(240, 240, 240)
            ENDWITH

            .ActivePage = 1
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarBotoes - Cria container cnt_4c_Botoes overlay com botao Encerrar
    * Container transparente sobre o cabecalho no canto superior direito
    * Equivalente ao btnOK do form original
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_nFormWidth
        loc_nFormWidth = THIS.Width

        *-- Container do botao Encerrar (transparente sobre cabecalho)
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 0
            .Left        = loc_nFormWidth - 90
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
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
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *===========================================================================
    * ConfigurarBotoesAcao - Cria container cnt_4c_BotoesAcao (botoes de acao)
    * Container reservado para botoes de acao especificos (adicionados nas Fases 4-7)
    * Nesta fase o container eh criado vazio conforme especificacao Fase 3
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_nFormWidth
        loc_nFormWidth = THIS.Width

        *-- Container de botoes de acao (posicionado no rodape das paginas)
        THIS.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH THIS.cnt_4c_BotoesAcao
            .Top         = THIS.Height - 40
            .Left        = 0
            .Width       = loc_nFormWidth
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Limpar", "CommandButton")
            WITH .cmd_4c_Limpar
                .Top          = 5
                .Left         = 10
                .Width        = 90
                .Height       = 28
                .Caption      = "Limpar"
                .FontName     = "Tahoma"
                .FontBold     = .T.
                .FontSize     = 8
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(240, 240, 240)
                .MousePointer = 15
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar, "Click", THIS, "CmdLimparClick")
    ENDPROC

    *===========================================================================
    * CmdEncerrarClick - Fecha o formulario (ESC ou clique no botao Encerrar)
    *===========================================================================
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Necessario apos AddObject (que cria controles com Visible=.F. por padrao)
    * Recursa em Pages (PageFrame) e sub-containers
    *===========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Dispatcher que popula ambas as paginas do form
    * Form OPERACIONAL: delega para ConfigurarPaginaCalculo (Page1 - campos de
    * calculo) e ConfigurarPaginaVencimentos (Page2 - datas de vencimento).
    * Nomenclatura mantida por compatibilidade com o pipeline de migracao.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPaginaCalculo()
        THIS.ConfigurarPaginaVencimentos()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaCalculo - Popula Page1 com todos os campos de calculo
    * Equivale ao ConfigurarPaginaLista em forms CRUD - eh o conteudo principal
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaCalculo()
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label "Valor Base :"
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 11
            .Left      = 36
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Valor Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Valor Base
        loc_oPagina.AddObject("txt_4c_ValorBase", "TextBox")
        WITH loc_oPagina.txt_4c_ValorBase
            .Top       = 7
            .Left      = 97
            .Width     = 115
            .Height    = 23
            .Value     = 0
            .Format    = "NR"
            .InputMask = "################.##"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Juros/Mes :"
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Top       = 39
            .Left      = 37
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Juros/M" + CHR(234) + "s :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Juros/Mes
        loc_oPagina.AddObject("txt_4c_JurosMes", "TextBox")
        WITH loc_oPagina.txt_4c_JurosMes
            .Top       = 35
            .Left      = 97
            .Width     = 59
            .Height    = 23
            .Value     = 0
            .Format    = "NR"
            .InputMask = "###.#####"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
        ENDWITH

        *-- Label "%"
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Top       = 39
            .Left      = 159
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Data Base :"
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Top       = 11
            .Left      = 295
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Data Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Data Base
        loc_oPagina.AddObject("txt_4c_DataBase", "TextBox")
        WITH loc_oPagina.txt_4c_DataBase
            .Top       = 7
            .Left      = 355
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
        ENDWITH

        *-- Label "Data Final / Dias :"
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Top       = 39
            .Left      = 266
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Data Final / Dias :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Data Final
        loc_oPagina.AddObject("txt_4c_DataFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DataFinal
            .Top       = 35
            .Left      = 355
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
        ENDWITH

        *-- Label "/"
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Top       = 39
            .Left      = 441
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "/"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Dias (numero de dias entre datas)
        loc_oPagina.AddObject("txt_4c_Dias", "TextBox")
        WITH loc_oPagina.txt_4c_Dias
            .Top       = 35
            .Left      = 453
            .Width     = 38
            .Height    = 23
            .Value     = 0
            .Format    = "NR"
            .InputMask = "####"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
        ENDWITH

        *-- Label "Calculo :"
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 63
            .Left      = 310
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "C" + CHR(225) + "lculo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- OptionGroup tipo de calculo (Simples/Composto)
        loc_oPagina.AddObject("obj_4c_OptCalculo", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptCalculo
            .Top         = 60
            .Left        = 351
            .Width       = 155
            .Height      = 21
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = THIS.this_nParTipoCalculo
            .Enabled     = .F.

            WITH .Buttons(1)
                .Caption   = "Simples"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Width     = 60
                .Height    = 21
                .Top       = 0
                .Left      = 0
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Composto"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Width     = 75
                .Height    = 21
                .Top       = 0
                .Left      = 63
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Label "Juros por Dia :"
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Top       = 68
            .Left      = 23
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Juros por Dia :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Juros por Dia
        loc_oPagina.AddObject("txt_4c_JurosDia", "TextBox")
        WITH loc_oPagina.txt_4c_JurosDia
            .Top       = 64
            .Left      = 97
            .Width     = 136
            .Height    = 23
            .Value     = 0
            .Format    = "NR"
            .InputMask = "###.#########"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
        ENDWITH

        *-- Label "Dias :"
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Top       = 81
            .Left      = 324
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Dias :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- OptionGroup tipo de contagem de dias (Corridos/Nao Corridos)
        loc_oPagina.AddObject("obj_4c_OptDias", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptDias
            .Top         = 78
            .Left        = 351
            .Width       = 175
            .Height      = 21
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.

            WITH .Buttons(1)
                .Caption   = "Corridos"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Width     = 65
                .Height    = 21
                .Top       = 0
                .Left      = 0
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o Corridos"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Width     = 100
                .Height    = 21
                .Top       = 0
                .Left      = 68
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Separador visual (equivalente ao Commandgroup1 Height=1 do original)
        loc_oPagina.AddObject("lbl_4c_Separador", "Label")
        WITH loc_oPagina.lbl_4c_Separador
            .Top       = 100
            .Left      = 6
            .Width     = 586
            .Height    = 1
            .BackStyle = 1
            .BackColor = RGB(180, 180, 180)
            .Caption   = ""
        ENDWITH

        *-- Label "Juros :"
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Top       = 107
            .Left      = 60
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Juros :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Valor Juros (resultado - somente leitura)
        loc_oPagina.AddObject("txt_4c_ValorJuros", "TextBox")
        WITH loc_oPagina.txt_4c_ValorJuros
            .Top       = 103
            .Left      = 97
            .Width     = 136
            .Height    = 23
            .Value     = 0
            .Format    = "NR"
            .InputMask = "################.##"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .ReadOnly  = .T.
        ENDWITH

        *-- Label "Total :"
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Top       = 107
            .Left      = 276
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Total :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Valor Total (resultado - somente leitura)
        loc_oPagina.AddObject("txt_4c_ValorTotal", "TextBox")
        WITH loc_oPagina.txt_4c_ValorTotal
            .Top       = 103
            .Left      = 311
            .Width     = 136
            .Height    = 23
            .Value     = 0
            .Format    = "NR"
            .InputMask = "################.##"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .ReadOnly  = .T.
        ENDWITH

        *-- Label "Parcela :"
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Top       = 131
            .Left      = 265
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Parcela :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo Valor Parcela (resultado - somente leitura)
        loc_oPagina.AddObject("txt_4c_Valorpar", "TextBox")
        WITH loc_oPagina.txt_4c_Valorpar
            .Top       = 127
            .Left      = 311
            .Width     = 136
            .Height    = 23
            .Value     = 0
            .Format    = "NR"
            .InputMask = "################.##"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .ReadOnly  = .T.
        ENDWITH

        *-- Botao para navegar para Page2 (Vencimentos)
        loc_oPagina.AddObject("cmd_4c_Vencimentos", "CommandButton")
        WITH loc_oPagina.cmd_4c_Vencimentos
            .Top          = 127
            .Left         = 97
            .Width        = 136
            .Height       = 23
            .Caption      = "Vencimentos >>"
            .FontName     = "Tahoma"
            .FontBold     = .T.
            .FontSize     = 8
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(240, 240, 240)
            .Themes       = .T.
            .MousePointer = 15
        ENDWITH

        BINDEVENT(loc_oPagina.cmd_4c_Vencimentos, "Click",           THIS, "CmdVencimentosClick")
        BINDEVENT(loc_oPagina.txt_4c_ValorBase,   "KeyPress",        THIS, "TxtValorBaseKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_JurosMes,    "KeyPress",        THIS, "TxtJurosMesKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_JurosDia,    "KeyPress",        THIS, "TxtJurosDiaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DataBase,    "KeyPress",        THIS, "TxtDataBaseKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DataFinal,   "KeyPress",        THIS, "TxtDataFinalKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Dias,        "KeyPress",        THIS, "TxtDiasKeyPress")
        BINDEVENT(loc_oPagina.obj_4c_OptCalculo,  "InteractiveChange", THIS, "OptCalculoInteractiveChange")
        BINDEVENT(loc_oPagina.obj_4c_OptDias,     "InteractiveChange", THIS, "OptDiasInteractiveChange")
    ENDPROC

    *===========================================================================
    * AlternarPagina - Navega entre Page1 (Calculo) e Page2 (Vencimentos)
    * par_nPagina: 1 ou 2; se omitido, alterna entre a pagina atual
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2)
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ELSE
            THIS.pgf_4c_Paginas.ActivePage = IIF(THIS.pgf_4c_Paginas.ActivePage = 1, 2, 1)
        ENDIF
    ENDPROC

    *===========================================================================
    * CmdVencimentosClick - Navega para Page2 (Vencimentos)
    *===========================================================================
    PROCEDURE CmdVencimentosClick()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * PreencherParametrosIniciais - Preenche campos com parametros do chamador
    * Chamado apos ConfigurarPaginaCalculo() para inicializar valores recebidos
    *===========================================================================
    PROTECTED PROCEDURE PreencherParametrosIniciais()
        LOCAL loc_oPagina, loc_lHabilitar

        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_lHabilitar = .F.

        IF THIS.this_nParValorBase > 0
            loc_oPagina.txt_4c_ValorBase.Value = THIS.this_nParValorBase
            loc_lHabilitar = .T.
        ENDIF

        THIS.HabilitarCamposEntrada(loc_lHabilitar)

        IF loc_lHabilitar
            loc_oPagina.obj_4c_OptCalculo.Value = THIS.this_nParTipoCalculo

            IF THIS.this_nParJurosMes > 0
                loc_oPagina.txt_4c_JurosMes.Value = THIS.this_nParJurosMes
                IF THIS.this_nParTipoCalculo = 1
                    loc_oPagina.txt_4c_JurosDia.Value = ROUND(THIS.this_nParJurosMes / 30, 9)
                ELSE
                    loc_oPagina.txt_4c_JurosDia.Value = ROUND((((1 + THIS.this_nParJurosMes/100) ^ (1/30)) - 1) * 100, 9)
                ENDIF
            ENDIF

            IF THIS.this_nParJurosDia > 0 AND THIS.this_nParJurosMes = 0
                loc_oPagina.txt_4c_JurosDia.Value = THIS.this_nParJurosDia
                IF THIS.this_nParTipoCalculo = 1
                    loc_oPagina.txt_4c_JurosMes.Value = ROUND(THIS.this_nParJurosDia * 30, 2)
                ELSE
                    loc_oPagina.txt_4c_JurosMes.Value = ROUND((((1 + THIS.this_nParJurosDia/100) ^ 30) - 1) * 100, 2)
                ENDIF
            ENDIF

            IF VARTYPE(THIS.this_dParDataBase) = "D" AND !EMPTY(THIS.this_dParDataBase)
                loc_oPagina.txt_4c_DataBase.Value = THIS.this_dParDataBase
            ENDIF

            IF VARTYPE(THIS.this_dParDataFinal) = "D" AND !EMPTY(THIS.this_dParDataFinal)
                loc_oPagina.txt_4c_DataFinal.Value = THIS.this_dParDataFinal
                IF !EMPTY(THIS.this_dParDataBase)
                    loc_oPagina.txt_4c_Dias.Value = THIS.this_dParDataFinal - THIS.this_dParDataBase
                ENDIF
            ENDIF

            THIS.Calculos()
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCamposEntrada - Habilita ou desabilita campos vinculados
    * Chamado quando ValorBase eh preenchido (habilita) ou zerado (desabilita)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCamposEntrada(par_lHabilitar)
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        WITH loc_oPagina
            .obj_4c_OptCalculo.Enabled = par_lHabilitar
            .txt_4c_JurosMes.Enabled   = par_lHabilitar
            .txt_4c_JurosDia.Enabled   = par_lHabilitar
            .txt_4c_DataBase.Enabled   = par_lHabilitar
            .txt_4c_DataFinal.Enabled  = par_lHabilitar
            .txt_4c_Dias.Enabled       = par_lHabilitar
            .obj_4c_OptDias.Enabled    = par_lHabilitar
        ENDWITH
    ENDPROC

    *===========================================================================
    * Calculos - Motor de calculo de juros (logica completa com vencimentos)
    * Equivale ao PROCEDURE Calculos() do form SIGPRCFN original
    * Chamado sempre que qualquer campo de entrada eh alterado
    * Quando ha datas de vencimento em Page2, recalcula juros por parcela
    *===========================================================================
    PROCEDURE Calculos()
        LOCAL loc_oPg1, loc_oPg2, loc_nValorBase, loc_nJurosMes, loc_nJurosDia
        LOCAL loc_nDias, loc_nTipoCalculo, loc_nJuros, loc_nTotal
        LOCAL loc_nParc, loc_nTotDia, loc_nI, loc_cNomeCampo, loc_dVenc, loc_nDiaVenc

        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_oPg2         = THIS.pgf_4c_Paginas.Page2
        loc_nValorBase   = loc_oPg1.txt_4c_ValorBase.Value
        loc_nJurosMes    = loc_oPg1.txt_4c_JurosMes.Value
        loc_nJurosDia    = loc_oPg1.txt_4c_JurosDia.Value
        loc_nDias        = loc_oPg1.txt_4c_Dias.Value
        loc_nTipoCalculo = loc_oPg1.obj_4c_OptCalculo.Value
        loc_nJuros       = 0
        loc_nParc        = 0
        loc_nTotDia      = 0

        IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0 OR ;
           (EMPTY(loc_nJurosMes) AND EMPTY(loc_nJurosDia)) OR ;
           EMPTY(loc_nDias) OR loc_nDias = 0

            loc_oPg1.txt_4c_ValorJuros.Value = 0
            loc_oPg1.txt_4c_ValorTotal.Value = 0
            loc_oPg1.txt_4c_Valorpar.Value   = 0
            RETURN
        ENDIF

        IF loc_nTipoCalculo = 1
            *-- Juros Simples: J = PV * (i_mes/100) * (n/30)
            loc_nJuros = ROUND(loc_nValorBase * (loc_nJurosMes / 100) * (loc_nDias / 30), 2)
        ELSE
            *-- Juros Compostos: J = PV * ((1 + i_dia/100)^n - 1)
            loc_nJuros = ROUND(loc_nValorBase * (((1 + loc_nJurosDia / 100) ^ loc_nDias) - 1), 2)
        ENDIF

        *-- Loop vencimentos: recalcula por parcela quando houver datas preenchidas em Page2
        FOR loc_nI = 1 TO 10
            loc_cNomeCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
            IF PEMSTATUS(loc_oPg2, loc_cNomeCampo, 5)
                loc_dVenc = EVALUATE("loc_oPg2." + loc_cNomeCampo + ".Value")
                IF !EMPTY(loc_dVenc)
                    IF loc_nParc = 0
                        loc_nJuros = 0  && Reseta ao encontrar primeiro vencimento
                    ENDIF
                    loc_nDiaVenc = loc_dVenc - loc_oPg1.txt_4c_DataBase.Value
                    IF loc_nTipoCalculo = 1
                        loc_nJuros = loc_nJuros + ROUND(loc_nValorBase * (loc_nJurosMes / 100) * (loc_nDiaVenc / 30), 2)
                    ELSE
                        loc_nJuros = loc_nJuros + ROUND(loc_nValorBase * (((1 + loc_nJurosDia / 100) ^ loc_nDiaVenc) - 1), 2)
                    ENDIF
                    loc_nTotDia = loc_nDiaVenc
                    loc_nParc   = loc_nParc + 1
                ENDIF
            ENDIF
        ENDFOR

        IF loc_nTotDia > 0
            loc_oPg1.txt_4c_Dias.Value = loc_nTotDia
        ENDIF

        loc_nTotal = loc_nValorBase + loc_nJuros

        loc_oPg1.txt_4c_ValorJuros.Value = loc_nJuros
        loc_oPg1.txt_4c_ValorTotal.Value = loc_nTotal
        loc_oPg1.txt_4c_Valorpar.Value   = ROUND(loc_nTotal / IIF(loc_nParc != 0, loc_nParc, 1), 2)
    ENDPROC

    *===========================================================================
    * CalcularParcela - Calcula valor da parcela com base nos vencimentos de Page2
    * Se Page2 ainda nao tem vencimentos, divide por 10 (padrao 10 parcelas)
    *===========================================================================
    PROTECTED PROCEDURE CalcularParcela(par_nTotal)
        LOCAL loc_nParcelas, loc_nI, loc_cNomeCampo, loc_oPg2, loc_oField

        loc_nParcelas = 0

        IF THIS.pgf_4c_Paginas.PageCount >= 2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            FOR loc_nI = 1 TO 10
                loc_cNomeCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
                IF PEMSTATUS(loc_oPg2, loc_cNomeCampo, 5)
                    loc_oField = EVALUATE("loc_oPg2." + loc_cNomeCampo)
                    IF !EMPTY(loc_oField.Value)
                        loc_nParcelas = loc_nParcelas + 1
                    ENDIF
                ENDIF
            ENDFOR
        ENDIF

        IF loc_nParcelas = 0
            RETURN ROUND(par_nTotal / 10, 2)
        ENDIF

        RETURN ROUND(par_nTotal / loc_nParcelas, 2)
    ENDPROC

    *===========================================================================
    * TxtValorBaseKeyPress - Valid para campo Valor Base
    * Ao confirmar (ENTER/TAB), valida e habilita/desabilita demais campos
    *===========================================================================
    PROCEDURE TxtValorBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nValor, loc_lHabilitar

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_nValor     = loc_oPagina.txt_4c_ValorBase.Value
        loc_lHabilitar = .F.

        IF loc_nValor < 0
            MsgAviso("O Valor Base Precisa Ser Positivo!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPagina.txt_4c_ValorBase.SetFocus()
            RETURN
        ENDIF

        loc_lHabilitar = (loc_nValor > 0)
        THIS.HabilitarCamposEntrada(loc_lHabilitar)
        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * TxtJurosMesKeyPress - Valid para campo Juros/Mes
    * Calcula JurosDia equivalente e recalcula juros
    *===========================================================================
    PROCEDURE TxtJurosMesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nJurosMes, loc_nJurosDia, loc_nTipo

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_nJurosMes = loc_oPagina.txt_4c_JurosMes.Value
        loc_nTipo     = loc_oPagina.obj_4c_OptCalculo.Value

        IF loc_nTipo = 1
            loc_nJurosDia = ROUND(loc_nJurosMes / 30, 9)
        ELSE
            loc_nJurosDia = ROUND((((1 + loc_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
        ENDIF

        loc_oPagina.txt_4c_JurosDia.Value = loc_nJurosDia
        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * TxtJurosDiaKeyPress - Valid para campo Juros por Dia
    * Calcula JurosMes equivalente e recalcula juros
    *===========================================================================
    PROCEDURE TxtJurosDiaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nJurosDia, loc_nJurosMes, loc_nTipo

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_nJurosDia = loc_oPagina.txt_4c_JurosDia.Value
        loc_nTipo     = loc_oPagina.obj_4c_OptCalculo.Value

        IF loc_nTipo = 1
            loc_nJurosMes = ROUND(loc_nJurosDia * 30, 2)
        ELSE
            loc_nJurosMes = ROUND((((1 + loc_nJurosDia / 100) ^ 30) - 1) * 100, 2)
        ENDIF

        loc_oPagina.txt_4c_JurosMes.Value = loc_nJurosMes
        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * TxtDataBaseKeyPress - Valid para campo Data Base
    * Valida ordenacao das datas, recalcula dias e chama Calculos()
    *===========================================================================
    PROCEDURE TxtDataBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
        loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value

        IF !EMPTY(loc_dDataFinal) AND !EMPTY(loc_dDataBase)
            IF loc_dDataBase > loc_dDataFinal
                MsgAviso("A Data Base N" + CHR(227) + "o Pode Ser Maior Que a Data Final!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_DataBase.SetFocus()
                RETURN
            ENDIF
            loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
        ENDIF

        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * TxtDataFinalKeyPress - Valid para campo Data Final
    * Valida ordenacao das datas, recalcula dias (uteis ou corridos) e calcula
    *===========================================================================
    PROCEDURE TxtDataFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
        loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value

        IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
            IF loc_dDataFinal < loc_dDataBase
                MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_DataFinal.SetFocus()
                RETURN
            ENDIF
            loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
        ENDIF

        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * TxtDiasKeyPress - Valid para campo Dias
    * Em modo corridos: ajusta DataFinal ou DataBase a partir dos dias informados
    * Em modo uteis: apenas recalcula (datas definem os dias uteis)
    *===========================================================================
    PROCEDURE TxtDiasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nDias, loc_dDataBase, loc_dDataFinal, loc_nTipoDias

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_nDias      = loc_oPagina.txt_4c_Dias.Value
        loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
        loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
        loc_nTipoDias  = loc_oPagina.obj_4c_OptDias.Value

        IF loc_nTipoDias = 1
            IF !EMPTY(loc_dDataBase)
                loc_oPagina.txt_4c_DataFinal.Value = loc_dDataBase + loc_nDias
            ELSE
                IF !EMPTY(loc_dDataFinal)
                    loc_oPagina.txt_4c_DataBase.Value = loc_dDataFinal - loc_nDias
                ENDIF
            ENDIF
        ELSE
            IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
                loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
            ENDIF
        ENDIF

        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * OptCalculoInteractiveChange - Disparado ao mudar tipo de calculo
    *===========================================================================
    PROCEDURE OptCalculoInteractiveChange()
        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * OptDiasInteractiveChange - Disparado ao mudar tipo de contagem de dias
    * Recalcula dias uteis se datas estiverem preenchidas
    *===========================================================================
    PROCEDURE OptDiasInteractiveChange()
        LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal

        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
        loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value

        IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
            loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
        ENDIF

        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * CalcularDiasUteis - Calcula dias entre duas datas conforme tipo selecionado
    * optDias=1 (Corridos): retorna DataFim - DataInicio (dias corridos)
    * optDias=2 (Nao Corridos): desconta finais de semana (equivale a fChkFeriado)
    *===========================================================================
    PROTECTED PROCEDURE CalcularDiasUteis(par_dDataInicio, par_dDataFim, par_oPagina)
        LOCAL loc_nTipoDias, loc_nDias, loc_dDataAtual

        IF VARTYPE(par_oPagina) = "O"
            loc_nTipoDias = par_oPagina.obj_4c_OptDias.Value
        ELSE
            loc_nTipoDias = 1
        ENDIF

        loc_nDias = par_dDataFim - par_dDataInicio

        IF loc_nDias > 0 AND loc_nTipoDias = 2
            *-- Descontar sabados (DOW=7) e domingos (DOW=1) - equivale a fChkFeriado(d,.T.,.T.,.F.)
            loc_dDataAtual = par_dDataInicio
            DO WHILE loc_dDataAtual <= par_dDataFim
                IF DOW(loc_dDataAtual) = 1 OR DOW(loc_dDataAtual) = 7
                    loc_nDias = loc_nDias - 1
                ENDIF
                loc_dDataAtual = loc_dDataAtual + 1
            ENDDO
        ENDIF

        RETURN loc_nDias
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaVencimentos - Popula Page2 com campos de datas de vencimento
    * Layout: 5 colunas x 2 linhas (venc1,3,5,7,9 na linha 1; venc2,4,6,8,10 na linha 2)
    * 10 campos de data equivalentes a getvenc1..getvenc10 do original
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaVencimentos()
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Botao Voltar (navega de volta para Page1 - Calculo)
        loc_oPagina.AddObject("cmd_4c_Voltar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Voltar
            .Top          = 5
            .Left         = 5
            .Width        = 110
            .Height       = 23
            .Caption      = "< C" + CHR(225) + "lculo"
            .FontName     = "Tahoma"
            .FontBold     = .T.
            .FontSize     = 8
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(240, 240, 240)
            .Themes       = .T.
            .MousePointer = 15
        ENDWITH

        *-- Label "Vencimentos :"
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Top       = 75
            .Left      = 26
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Vencimentos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Coluna 1: venc1 (linha 1) + venc2 (linha 2)
        loc_oPagina.AddObject("txt_4c_Venc1", "TextBox")
        WITH loc_oPagina.txt_4c_Venc1
            .Top       = 71
            .Left      = 97
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Venc2", "TextBox")
        WITH loc_oPagina.txt_4c_Venc2
            .Top       = 98
            .Left      = 97
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Coluna 2: venc3 (linha 1) + venc4 (linha 2)
        loc_oPagina.AddObject("txt_4c_Venc3", "TextBox")
        WITH loc_oPagina.txt_4c_Venc3
            .Top       = 71
            .Left      = 184
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Venc4", "TextBox")
        WITH loc_oPagina.txt_4c_Venc4
            .Top       = 98
            .Left      = 184
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Coluna 3: venc5 (linha 1) + venc6 (linha 2)
        loc_oPagina.AddObject("txt_4c_Venc5", "TextBox")
        WITH loc_oPagina.txt_4c_Venc5
            .Top       = 71
            .Left      = 271
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Venc6", "TextBox")
        WITH loc_oPagina.txt_4c_Venc6
            .Top       = 98
            .Left      = 271
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Coluna 4: venc7 (linha 1) + venc8 (linha 2)
        loc_oPagina.AddObject("txt_4c_Venc7", "TextBox")
        WITH loc_oPagina.txt_4c_Venc7
            .Top       = 71
            .Left      = 358
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Venc8", "TextBox")
        WITH loc_oPagina.txt_4c_Venc8
            .Top       = 98
            .Left      = 358
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Coluna 5: venc9 (linha 1) + venc10 (linha 2)
        loc_oPagina.AddObject("txt_4c_Venc9", "TextBox")
        WITH loc_oPagina.txt_4c_Venc9
            .Top       = 71
            .Left      = 445
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Venc10", "TextBox")
        WITH loc_oPagina.txt_4c_Venc10
            .Top       = 98
            .Left      = 445
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        BINDEVENT(loc_oPagina.cmd_4c_Voltar,  "Click",    THIS, "CmdVoltarClick")
        BINDEVENT(loc_oPagina.txt_4c_Venc1,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc2,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc3,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc4,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc5,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc6,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc7,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc8,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc9,   "KeyPress", THIS, "TxtVencKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Venc10,  "KeyPress", THIS, "TxtVencKeyPress")
    ENDPROC

    *===========================================================================
    * CmdVoltarClick - Navega de volta para Page1 (Calculo)
    *===========================================================================
    PROCEDURE CmdVoltarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * CmdLimparClick - Limpa todos os campos e reinicia a calculadora
    *===========================================================================
    PROCEDURE CmdLimparClick()
        LOCAL loc_oPg1, loc_oPg2, loc_nI, loc_cCampo, loc_oVenc

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg1.txt_4c_ValorBase.Value  = 0
        loc_oPg1.txt_4c_JurosMes.Value   = 0
        loc_oPg1.txt_4c_JurosDia.Value   = 0
        loc_oPg1.txt_4c_DataBase.Value   = {}
        loc_oPg1.txt_4c_DataFinal.Value  = {}
        loc_oPg1.txt_4c_Dias.Value       = 0
        loc_oPg1.txt_4c_ValorJuros.Value = 0
        loc_oPg1.txt_4c_ValorTotal.Value = 0
        loc_oPg1.txt_4c_Valorpar.Value   = 0
        loc_oPg1.obj_4c_OptCalculo.Value = 1
        loc_oPg1.obj_4c_OptDias.Value    = 1

        FOR loc_nI = 1 TO 10
            loc_cCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
            IF PEMSTATUS(loc_oPg2, loc_cCampo, 5)
                loc_oVenc = EVALUATE("loc_oPg2." + loc_cCampo)
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Value = {}
                ENDIF
            ENDIF
        ENDFOR

        THIS.HabilitarCamposEntrada(.F.)
        THIS.pgf_4c_Paginas.ActivePage = 1
        loc_oPg1.txt_4c_ValorBase.SetFocus()
    ENDPROC

    *===========================================================================
    * TxtVencKeyPress - Handler compartilhado para todos os campos de vencimento
    * Valida data >= DataBase, atualiza campo Dias e recalcula juros
    * Equivale ao PROCEDURE Valid de cada getvencN no original
    *===========================================================================
    PROCEDURE TxtVencKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1, loc_oPg2, loc_oControl, loc_dVenc, loc_dDataBase

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_oControl = loc_oPg2.ActiveControl

        IF VARTYPE(loc_oControl) != "O"
            THIS.Calculos()
            RETURN
        ENDIF

        loc_dVenc     = loc_oControl.Value
        loc_dDataBase = loc_oPg1.txt_4c_DataBase.Value

        IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dVenc)
            IF loc_dVenc < loc_dDataBase
                MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_oControl.SetFocus()
                RETURN
            ENDIF
            loc_oPg1.txt_4c_Dias.Value = loc_dVenc - loc_dDataBase
        ENDIF

        THIS.Calculos()
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Nova simulacao (reset completo + habilita entrada)
    * Equivale a "Incluir" em forms CRUD: prepara formulario para nova entrada
    * Reusa CmdLimparClick para zerar campos e HabilitarCamposEntrada para liberar
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg1

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Zera todos os campos de entrada e resultado, retorna a Page1
        THIS.CmdLimparClick()

        *-- Habilita ValorBase para o usuario iniciar nova simulacao
        loc_oPg1.txt_4c_ValorBase.Enabled = .T.
        loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.

        *-- Modo INCLUIR: campos vinculados so habilitam ao informar ValorBase > 0
        THIS.HabilitarCamposEntrada(.F.)
        THIS.this_cModoAtual = "INCLUIR"

        loc_oPg1.txt_4c_ValorBase.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Habilita edicao dos campos da simulacao atual
    * Equivale a "Alterar" em forms CRUD: libera campos para modificacao
    * Reabilita entrada preservando valores digitados (nao limpa)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg1, loc_nValorBase

        loc_oPg1       = THIS.pgf_4c_Paginas.Page1
        loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value

        IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
            MsgAviso("Informe o Valor Base para iniciar uma simula" + CHR(231) + CHR(227) + "o.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg1.txt_4c_ValorBase.Enabled  = .T.
            loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
            loc_oPg1.txt_4c_ValorBase.SetFocus()
            RETURN
        ENDIF

        *-- Libera campos de entrada (ValorBase, Juros, Datas, Dias e OptionGroups)
        loc_oPg1.txt_4c_ValorBase.Enabled  = .T.
        loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
        THIS.HabilitarCamposEntrada(.T.)
        THIS.this_cModoAtual = "ALTERAR"

        *-- Recalcula com valores atuais para refletir eventuais mudancas
        THIS.Calculos()

        loc_oPg1.txt_4c_ValorBase.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Modo somente-leitura da simulacao atual
    * Equivale a "Visualizar" em forms CRUD: bloqueia edicao e mostra vencimentos
    * Alterna para Page2 (Vencimentos) apos travar Page1
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPg1, loc_nValorBase

        loc_oPg1       = THIS.pgf_4c_Paginas.Page1
        loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value

        IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " simula" + CHR(231) + CHR(227) + ;
                     "o para visualizar. Informe o Valor Base primeiro.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        *-- Trava todos os campos de entrada em modo visualizacao
        loc_oPg1.txt_4c_ValorBase.Enabled  = .F.
        loc_oPg1.txt_4c_ValorBase.ReadOnly = .T.
        THIS.HabilitarCamposEntrada(.F.)
        THIS.this_cModoAtual = "VISUALIZAR"

        *-- Recalcula para garantir consistencia dos resultados exibidos
        THIS.Calculos()

        *-- Navega para Page2 (Vencimentos) para revisao das parcelas
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Descarta a simulacao atual (limpa todos os dados)
    * Equivale a "Excluir" em forms CRUD: apaga entrada e resultados
    * Confirma com o usuario antes de zerar, evitando perda acidental
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPg1, loc_nValorBase, loc_lConfirma

        loc_oPg1       = THIS.pgf_4c_Paginas.Page1
        loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value

        IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
            *-- Nao ha simulacao a descartar; apenas garante estado inicial
            THIS.CmdLimparClick()
            THIS.this_cModoAtual = "CALCULO"
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Deseja realmente descartar a simula" + CHR(231) + CHR(227) + ;
                                    "o atual?", ;
                                    "Confirma" + CHR(231) + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        *-- Zera todos os campos (Page1 + Page2), volta para Page1 e reinicia modo
        THIS.CmdLimparClick()
        THIS.this_cModoAtual = "CALCULO"
    ENDPROC

    *===========================================================================
    * CarregarLista - N/A para calculadora (sem lista de registros em BD)
    * Existe para compatibilidade com o pipeline de migracao
    *===========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * Para calculadora: habilita Limpar somente quando ha valor base preenchido
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemCalculo

        loc_lTemCalculo = (THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.Value > 0)

        IF PEMSTATUS(THIS.cnt_4c_BotoesAcao, "cmd_4c_Limpar", 5)
            THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar.Enabled = loc_lTemCalculo
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos de entrada e resultado
    * Equivalente semantico ao LimparCampos() do pipeline CRUD
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg1, loc_oPg2, loc_nI, loc_cCampo, loc_oVenc

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg1.txt_4c_ValorBase.Value  = 0
        loc_oPg1.txt_4c_JurosMes.Value   = 0
        loc_oPg1.txt_4c_JurosDia.Value   = 0
        loc_oPg1.txt_4c_DataBase.Value   = {}
        loc_oPg1.txt_4c_DataFinal.Value  = {}
        loc_oPg1.txt_4c_Dias.Value       = 0
        loc_oPg1.txt_4c_ValorJuros.Value = 0
        loc_oPg1.txt_4c_ValorTotal.Value = 0
        loc_oPg1.txt_4c_Valorpar.Value   = 0
        loc_oPg1.obj_4c_OptCalculo.Value = 1
        loc_oPg1.obj_4c_OptDias.Value    = 1

        FOR loc_nI = 1 TO 10
            loc_cCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
            IF PEMSTATUS(loc_oPg2, loc_cCampo, 5)
                loc_oVenc = EVALUATE("loc_oPg2." + loc_cCampo)
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Value = {}
                ENDIF
            ENDIF
        ENDFOR

        THIS.HabilitarCamposEntrada(.F.)
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos editaveis
    * Generaliza HabilitarCamposEntrada() incluindo o proprio ValorBase
    * par_lHabilitar: .T. = habilita, .F. = desabilita
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_oPg1.txt_4c_ValorBase.Enabled  = par_lHabilitar
        loc_oPg1.txt_4c_ValorBase.ReadOnly = !par_lHabilitar

        THIS.HabilitarCamposEntrada(par_lHabilitar)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do form para as propriedades do BO
    * Mapeamento completo: entradas + tipo + vencimentos
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg1, loc_oPg2, loc_oBO

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oBO.this_nValorBase   = loc_oPg1.txt_4c_ValorBase.Value
        loc_oBO.this_nJurosMes    = loc_oPg1.txt_4c_JurosMes.Value
        loc_oBO.this_nJurosDia    = loc_oPg1.txt_4c_JurosDia.Value
        loc_oBO.this_dDataBase    = loc_oPg1.txt_4c_DataBase.Value
        loc_oBO.this_dDataFinal   = loc_oPg1.txt_4c_DataFinal.Value
        loc_oBO.this_nDias        = loc_oPg1.txt_4c_Dias.Value
        loc_oBO.this_nTipoCalculo = loc_oPg1.obj_4c_OptCalculo.Value
        loc_oBO.this_nTipoDias    = loc_oPg1.obj_4c_OptDias.Value
        loc_oBO.this_dVenc1       = loc_oPg2.txt_4c_Venc1.Value
        loc_oBO.this_dVenc2       = loc_oPg2.txt_4c_Venc2.Value
        loc_oBO.this_dVenc3       = loc_oPg2.txt_4c_Venc3.Value
        loc_oBO.this_dVenc4       = loc_oPg2.txt_4c_Venc4.Value
        loc_oBO.this_dVenc5       = loc_oPg2.txt_4c_Venc5.Value
        loc_oBO.this_dVenc6       = loc_oPg2.txt_4c_Venc6.Value
        loc_oBO.this_dVenc7       = loc_oPg2.txt_4c_Venc7.Value
        loc_oBO.this_dVenc8       = loc_oPg2.txt_4c_Venc8.Value
        loc_oBO.this_dVenc9       = loc_oPg2.txt_4c_Venc9.Value
        loc_oBO.this_dVenc10      = loc_oPg2.txt_4c_Venc10.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO de volta para os campos do form
    * Carrega entradas + resultados do calculo + vencimentos
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg1, loc_oPg2, loc_oBO

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oPg1.txt_4c_ValorBase.Value  = loc_oBO.this_nValorBase
        loc_oPg1.txt_4c_JurosMes.Value   = loc_oBO.this_nJurosMes
        loc_oPg1.txt_4c_JurosDia.Value   = loc_oBO.this_nJurosDia
        loc_oPg1.txt_4c_DataBase.Value   = loc_oBO.this_dDataBase
        loc_oPg1.txt_4c_DataFinal.Value  = loc_oBO.this_dDataFinal
        loc_oPg1.txt_4c_Dias.Value       = loc_oBO.this_nDias
        loc_oPg1.obj_4c_OptCalculo.Value = loc_oBO.this_nTipoCalculo
        loc_oPg1.obj_4c_OptDias.Value    = loc_oBO.this_nTipoDias
        loc_oPg1.txt_4c_ValorJuros.Value = loc_oBO.this_nValorJuros
        loc_oPg1.txt_4c_ValorTotal.Value = loc_oBO.this_nValorTotal
        loc_oPg1.txt_4c_Valorpar.Value   = loc_oBO.this_nValorParcela
        loc_oPg2.txt_4c_Venc1.Value      = loc_oBO.this_dVenc1
        loc_oPg2.txt_4c_Venc2.Value      = loc_oBO.this_dVenc2
        loc_oPg2.txt_4c_Venc3.Value      = loc_oBO.this_dVenc3
        loc_oPg2.txt_4c_Venc4.Value      = loc_oBO.this_dVenc4
        loc_oPg2.txt_4c_Venc5.Value      = loc_oBO.this_dVenc5
        loc_oPg2.txt_4c_Venc6.Value      = loc_oBO.this_dVenc6
        loc_oPg2.txt_4c_Venc7.Value      = loc_oBO.this_dVenc7
        loc_oPg2.txt_4c_Venc8.Value      = loc_oBO.this_dVenc8
        loc_oPg2.txt_4c_Venc9.Value      = loc_oBO.this_dVenc9
        loc_oPg2.txt_4c_Venc10.Value     = loc_oBO.this_dVenc10
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario (alias CRUD para CmdEncerrarClick)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - N/A para calculadora (sem lista de registros)
    * Existe para compatibilidade com o pipeline de migracao
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Executa o calculo via BO (FormParaBO -> Inserir -> BOParaForm)
    * Equivale a "Salvar" em forms CRUD: valida, processa e exibe resultado
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg1, loc_lSucesso

        loc_oPg1      = THIS.pgf_4c_Paginas.Page1
        loc_lSucesso  = .F.

        IF loc_oPg1.txt_4c_ValorBase.Value <= 0
            MsgAviso("Informe o Valor Base para calcular.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg1.txt_4c_ValorBase.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()
        loc_lSucesso = THIS.this_oBusinessObject.Inserir()

        IF loc_lSucesso
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela simulacao atual, limpa campos e volta ao inicio
    * Equivale a "Cancelar" em forms CRUD: descarta alteracoes em andamento
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual = "CALCULO"

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_ValorBase", 5)
            THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCfnBO.prg):
*===============================================================================
* SigPrCfnBO.prg - Business Object para Calculo de Juros (SIGPRCFN)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sem tabela BD - calculo puro)
*===============================================================================

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *-- Identificacao (sem tabela BD - form de calculo)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Entradas do calculo
    this_nValorBase    = 0
    this_nJurosMes     = 0
    this_nJurosDia     = 0
    this_dDataBase     = {}
    this_dDataFinal    = {}
    this_nDias         = 0
    this_nTipoCalculo  = 1  && 1=Simples, 2=Composto
    this_nTipoDias     = 1  && 1=Corridos, 2=Uteis

    *-- Resultados do calculo
    this_nValorJuros   = 0
    this_nValorTotal   = 0
    this_nValorParcela = 0

    *-- Vencimentos (ate 10 parcelas)
    this_dVenc1  = {}
    this_dVenc2  = {}
    this_dVenc3  = {}
    this_dVenc4  = {}
    this_dVenc5  = {}
    this_dVenc6  = {}
    this_dVenc7  = {}
    this_dVenc8  = {}
    this_dVenc9  = {}
    this_dVenc10 = {}

    *---------------------------------------------------------------------------
    * Init - Inicializa o BO de calculo de juros
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            this.this_cTabela     = ""
            this.this_cCampoChave = ""

            this.LimparPropriedades()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * LimparPropriedades - Reseta todas as propriedades para valores iniciais
    *---------------------------------------------------------------------------
    PROCEDURE LimparPropriedades()
        THIS.this_nValorBase    = 0
        THIS.this_nJurosMes     = 0
        THIS.this_nJurosDia     = 0
        THIS.this_dDataBase     = {}
        THIS.this_dDataFinal    = {}
        THIS.this_nDias         = 0
        THIS.this_nTipoCalculo  = 1
        THIS.this_nTipoDias     = 1
        THIS.this_nValorJuros   = 0
        THIS.this_nValorTotal   = 0
        THIS.this_nValorParcela = 0
        THIS.this_dVenc1        = {}
        THIS.this_dVenc2        = {}
        THIS.this_dVenc3        = {}
        THIS.this_dVenc4        = {}
        THIS.this_dVenc5        = {}
        THIS.this_dVenc6        = {}
        THIS.this_dVenc7        = {}
        THIS.this_dVenc8        = {}
        THIS.this_dVenc9        = {}
        THIS.this_dVenc10       = {}
    ENDPROC


    *---------------------------------------------------------------------------
    * InicializarComParametros - Recebe parametros do chamador e prepara calculo
    * Logica identica ao Init do SIGPRCFN original (pVal, pTip, pJMe, pJDi, pDtB, pDtF)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarComParametros(par_nValorBase, par_nTipoCalculo, ;
                                        par_nJurosMes, par_nJurosDia, ;
                                        par_dDataBase, par_dDataFinal)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.LimparPropriedades()

            IF VARTYPE(par_nValorBase) = "N" AND par_nValorBase > 0
                THIS.this_nValorBase = par_nValorBase
            ENDIF

            IF VARTYPE(par_nTipoCalculo) = "N" AND INLIST(par_nTipoCalculo, 1, 2)
                THIS.this_nTipoCalculo = par_nTipoCalculo
            ENDIF

            IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
                THIS.this_nJurosMes = par_nJurosMes
                THIS.ConverterJurosMesParaDia()
            ELSE
                IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
                    THIS.this_nJurosDia = par_nJurosDia
                    THIS.ConverterJurosDiaParaMes()
                ENDIF
            ENDIF

            IF VARTYPE(par_dDataBase) = "D"
                THIS.this_dDataBase = par_dDataBase
            ENDIF

            IF VARTYPE(par_dDataFinal) = "D"
                THIS.this_dDataFinal = par_dDataFinal
            ELSE
                IF !EMPTY(THIS.this_dDataBase)
                    THIS.this_dDataFinal = DATE()
                ENDIF
            ENDIF

            IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal)
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJuros - Executa calculo de juros com as propriedades atuais
    * Logica identica ao metodo Calculos() do SIGPRCFN original
    * Retorna: .T. se calculo realizado, .F. se entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJuros()
        LOCAL loc_lSucesso, loc_nJuros, loc_nParc, loc_nTotDia, loc_nI, loc_nDia
        LOCAL ARRAY loc_aVenc[10]

        loc_lSucesso = .F.
        loc_nJuros   = 0
        loc_nParc    = 0
        loc_nTotDia  = 0

        TRY
            *-- Se algum campo obrigatorio estiver vazio, zerar resultados
            IF THIS.this_nValorBase = 0 OR ;
               THIS.this_nJurosMes  = 0 OR ;
               THIS.this_nJurosDia  = 0 OR ;
               EMPTY(THIS.this_dDataBase)  OR ;
               EMPTY(THIS.this_dDataFinal) OR ;
               THIS.this_nDias = 0
                THIS.this_nValorJuros   = 0
                THIS.this_nValorTotal   = 0
                THIS.this_nValorParcela = 0
                loc_lSucesso = .F.
            ENDIF

            *-- Calculo base (sem vencimentos)
            IF THIS.this_nTipoCalculo = 1
                *-- Juros Simples: J = PV * (i_mes/100) * (dias/30)
                loc_nJuros = ROUND(THIS.this_nValorBase * ;
                                  (THIS.this_nJurosMes / 100) * ;
                                  (THIS.this_nDias / 30), 2)
            ELSE
                *-- Juros Compostos: J = PV * ((1 + i_dia/100)^dias - 1)
                loc_nJuros = ROUND(THIS.this_nValorBase * ;
                                  (((1 + THIS.this_nJurosDia / 100) ^ THIS.this_nDias) - 1), 2)
            ENDIF

            *-- Verificar vencimentos: se algum informado, recalcular por parcela
            loc_aVenc[1]  = THIS.this_dVenc1
            loc_aVenc[2]  = THIS.this_dVenc2
            loc_aVenc[3]  = THIS.this_dVenc3
            loc_aVenc[4]  = THIS.this_dVenc4
            loc_aVenc[5]  = THIS.this_dVenc5
            loc_aVenc[6]  = THIS.this_dVenc6
            loc_aVenc[7]  = THIS.this_dVenc7
            loc_aVenc[8]  = THIS.this_dVenc8
            loc_aVenc[9]  = THIS.this_dVenc9
            loc_aVenc[10] = THIS.this_dVenc10

            FOR loc_nI = 1 TO 10
                IF !EMPTY(loc_aVenc[loc_nI])
                    IF loc_nParc = 0
                        *-- Primeira parcela encontrada: zera calculo base e recalcula por vencimento
                        loc_nJuros = 0
                    ENDIF

                    loc_nDia = loc_aVenc[loc_nI] - THIS.this_dDataBase

                    IF THIS.this_nTipoCalculo = 1
                        *-- Juros Simples por vencimento
                        loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                       (THIS.this_nJurosMes / 100) * ;
                                                       (loc_nDia / 30), 2)
                    ELSE
                        *-- Juros Compostos por vencimento
                        loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                       (((1 + THIS.this_nJurosDia / 100) ^ loc_nDia) - 1), 2)
                    ENDIF

                    loc_nTotDia = loc_nDia
                    loc_nParc   = loc_nParc + 1
                ENDIF
            ENDFOR

            *-- Se vencimentos preenchidos, atualizar this_nDias com o ultimo vencimento
            IF loc_nTotDia > 0
                THIS.this_nDias = loc_nTotDia
            ENDIF

            THIS.this_nValorJuros   = loc_nJuros
            THIS.this_nValorTotal   = THIS.this_nValorBase + loc_nJuros
            THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ConverterJurosMesParaDia - Converte taxa mensal para diaria e atualiza this_nJurosDia
    * Logica identica ao Valid de getJurosMes do SIGPRCFN original
    *---------------------------------------------------------------------------
    PROCEDURE ConverterJurosMesParaDia()
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Simples: i_dia = i_mes / 30
            loc_nJurosDia = ROUND(THIS.this_nJurosMes / 30, 9)
        ELSE
            *-- Composto: i_dia = ((1 + i_mes/100)^(1/30) - 1) * 100
            loc_nJurosDia = ROUND((((1 + THIS.this_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
        ENDIF

        THIS.this_nJurosDia = loc_nJurosDia
    ENDPROC

    *---------------------------------------------------------------------------
    * ConverterJurosDiaParaMes - Converte taxa diaria para mensal e atualiza this_nJurosMes
    * Logica identica ao Valid de getJurosDia do SIGPRCFN original
    *---------------------------------------------------------------------------
    PROCEDURE ConverterJurosDiaParaMes()
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Simples: i_mes = i_dia * 30
            loc_nJurosMes = ROUND(THIS.this_nJurosDia * 30, 2)
        ELSE
            *-- Composto: i_mes = ((1 + i_dia/100)^30 - 1) * 100
            loc_nJurosMes = ROUND((((1 + THIS.this_nJurosDia / 100) ^ 30) - 1) * 100, 2)
        ENDIF

        THIS.this_nJurosMes = loc_nJurosMes
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularDias - Calcula dias entre data base e data final aplicando TipoDias
    * TipoDias 1=Corridos, 2=Uteis (desconta fins de semana e feriados)
    * Logica identica ao calculo de fChkFeriado do SIGPRCFN original
    * Atualiza this_nDias com o resultado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularDias()
        LOCAL loc_nDias, loc_dAtual

        IF EMPTY(THIS.this_dDataBase) OR EMPTY(THIS.this_dDataFinal)
            THIS.this_nDias = 0
            RETURN
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataBase
            THIS.this_nDias = 0
            RETURN
        ENDIF

        *-- Calculo base: dias corridos
        loc_nDias = THIS.this_dDataFinal - THIS.this_dDataBase

        IF THIS.this_nTipoDias = 2 AND loc_nDias > 0
            *-- Subtrair dias nao uteis (fins de semana e feriados)
            loc_dAtual = THIS.this_dDataBase
            DO WHILE loc_dAtual <= THIS.this_dDataFinal
                IF !THIS.VerificarDiaUtil(loc_dAtual)
                    loc_nDias = loc_nDias - 1
                ENDIF
                loc_dAtual = loc_dAtual + 1
            ENDDO
        ENDIF

        THIS.this_nDias = loc_nDias
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarDiaUtil - Verifica se a data e um dia util
    * par_dData - Data a verificar
    * Retorna: .T. se util, .F. se sabado ou domingo
    * Equivale a fChkFeriado(d,.T.,.T.,.F.) do legado (desconta apenas fins de semana)
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDiaUtil(par_dData)
        LOCAL loc_nDow

        loc_nDow = DOW(par_dData)
        IF loc_nDow = 1 OR loc_nDow = 7
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (N/A - form de calculo sem tabela)
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do calculo a partir de um cursor
    * Util para chamadas em batch onde parametros vem de outro cursor/tabela
    * Mapeia colunas conhecidas (se existirem) para as propriedades do BO
    * par_cAliasCursor: alias do cursor contendo os parametros
    * Retorna .T. em caso de sucesso, .F. se cursor invalido
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            *-- Mapear cada coluna somente se existir no cursor (permite cursores
            *-- parciais). Uso de TYPE() para checar existencia da coluna.
            IF TYPE(par_cAliasCursor + ".ValorBase") != "U"
                THIS.this_nValorBase = TratarNulo(EVALUATE(par_cAliasCursor + ".ValorBase"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosMes") != "U"
                THIS.this_nJurosMes = TratarNulo(EVALUATE(par_cAliasCursor + ".JurosMes"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosDia") != "U"
                THIS.this_nJurosDia = TratarNulo(EVALUATE(par_cAliasCursor + ".JurosDia"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataBase") != "U"
                THIS.this_dDataBase = TratarNulo(EVALUATE(par_cAliasCursor + ".DataBase"), "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataFinal") != "U"
                THIS.this_dDataFinal = TratarNulo(EVALUATE(par_cAliasCursor + ".DataFinal"), "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Dias") != "U"
                THIS.this_nDias = TratarNulo(EVALUATE(par_cAliasCursor + ".Dias"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoCalculo") != "U"
                THIS.this_nTipoCalculo = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoCalculo"), "N")
                IF !INLIST(THIS.this_nTipoCalculo, 1, 2)
                    THIS.this_nTipoCalculo = 1
                ENDIF
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoDias") != "U"
                THIS.this_nTipoDias = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoDias"), "N")
                IF !INLIST(THIS.this_nTipoDias, 1, 2)
                    THIS.this_nTipoDias = 1
                ENDIF
            ENDIF

            *-- Se DataBase e DataFinal preenchidas mas Dias vazio, calcular
            IF THIS.this_nDias = 0 AND !EMPTY(THIS.this_dDataBase) ;
                                  AND !EMPTY(THIS.this_dDataFinal)
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Executa calculo e retorna resultado
    * Form de calculo puro (sem tabela BD): Inserir corresponde a executar
    * o calculo de juros com os parametros atuais. Nao ha persistencia em
    * tabela propria porque este BO representa uma calculadora, nao entidade
    * de dominio. O resultado fica nas propriedades this_nValorJuros,
    * this_nValorTotal e this_nValorParcela para consulta pelo chamador.
    * Retorna .T. se calculo executado, .F. em caso de entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            *-- Valida entradas minimas
            IF THIS.this_nValorBase <= 0
                MsgAviso("Valor Base deve ser informado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_dDataBase)
                MsgAviso("Data Base deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_dDataFinal)
                MsgAviso("Data Final deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nJurosMes <= 0 AND THIS.this_nJurosDia <= 0
                MsgAviso("Taxa de juros deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Garante coerencia entre taxas mes/dia
            IF THIS.this_nJurosMes > 0 AND THIS.this_nJurosDia = 0
                THIS.ConverterJurosMesParaDia()
            ENDIF
            IF THIS.this_nJurosDia > 0 AND THIS.this_nJurosMes = 0
                THIS.ConverterJurosDiaParaMes()
            ENDIF

            *-- Recalcula dias conforme tipo (corridos/uteis)
            THIS.CalcularDias()

            *-- Executa o calculo principal
            loc_lSucesso = THIS.CalcularJuros()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Reexecuta calculo com parametros atualizados
    * Form de calculo puro: Atualizar corresponde a recalcular apos alteracao
    * de qualquer parametro (Valor Base, Taxa, Datas, Vencimentos). Delega a
    * Inserir() pois a semantica eh identica para uma calculadora.
    * Retorna .T. se calculo executado, .F. em caso de entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARLISTA is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[02/07/2026 19:42:54] Erro VincularEventos: Property KeyPress is not found. LN=841


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-02 19:42:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-02 19:42:36] [INFO] Config FPW: (nao fornecido)
[2026-07-02 19:42:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 19:42:36] [INFO] Timeout: 300 segundos
[2026-07-02 19:42:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ztoquouo.prg
[2026-07-02 19:42:36] [INFO] Conteudo do wrapper:
[2026-07-02 19:42:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprdft', 'C:\4c\tasks\task171', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprdft', 'C:\4c\tasks\task171', 'OPERACIONAL'
QUIT

[2026-07-02 19:42:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ztoquouo.prg
[2026-07-02 19:42:36] [INFO] VFP output esperado em: C:\4c\tasks\task171\vfp_output.txt
[2026-07-02 19:42:36] [INFO] Executando Visual FoxPro 9...
[2026-07-02 19:42:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ztoquouo.prg
[2026-07-02 19:42:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ztoquouo.prg
[2026-07-02 19:42:36] [INFO] Timeout configurado: 300 segundos
[2026-07-02 19:42:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-02 19:42:54] [INFO] VFP9 finalizado em 17.1098729 segundos
[2026-07-02 19:42:54] [INFO] Exit Code: 
[2026-07-02 19:42:54] [INFO] 
[2026-07-02 19:42:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-02 19:42:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ztoquouo.prg
[2026-07-02 19:42:54] [INFO] 
[2026-07-02 19:42:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-02 19:42:54] [INFO] * Auto-generated wrapper for parameters
[2026-07-02 19:42:54] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 19:42:54] [INFO] * Parameters: 'Formsigprdft', 'C:\4c\tasks\task171', 'OPERACIONAL'
[2026-07-02 19:42:54] [INFO] 
[2026-07-02 19:42:54] [INFO] * Anti-dialog protections for unattended execution
[2026-07-02 19:42:54] [INFO] SET SAFETY OFF
[2026-07-02 19:42:54] [INFO] SET RESOURCE OFF
[2026-07-02 19:42:54] [INFO] SET TALK OFF
[2026-07-02 19:42:54] [INFO] SET NOTIFY OFF
[2026-07-02 19:42:54] [INFO] SYS(2335, 0)
[2026-07-02 19:42:54] [INFO] 
[2026-07-02 19:42:54] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprdft', 'C:\4c\tasks\task171', 'OPERACIONAL'
[2026-07-02 19:42:54] [INFO] QUIT
[2026-07-02 19:42:54] [INFO] 
[2026-07-02 19:42:54] [INFO] === Fim do Wrapper.prg ===
[2026-07-02 19:42:54] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprdft",
  "timestamp": "20260702194254",
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
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 5 (KEYPRESS, OGTIPOVENDAKEYPRESS, TXTDATASKEYPRESS, TXTDIGITOSKEYPRESS, TXTTEXT1KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg):
*==============================================================================
* Formsigprdft.prg - Processamento TEF SiTef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito
* Migrado de SIGPRDFT.SCX
* Herda de FormBase
* Tipo: OPERACIONAL (dialog modal de integracao TEF/SiTef)
*
* Pilares:
*   UX   -> Layout PIXEL-PERFECT identico ao legado (500x370, sem barra de titulo)
*   BD   -> Usa SigOpFp, SigCdEmp, SigFiMpF para config (schema identico)
*   CODE -> Arquitetura em camadas (FormBase / sigprdftBO)
*
* Chamada: CREATEOBJECT("Formsigprdft", cEndSiTef, nValPago, cCupom, cCaixa,
*           cDebCred, cTipPagto, nNumParcs, nIdent, cOpers)
* Retorno: ObterResultado() apos Show() ou via Unload
*==============================================================================

DEFINE CLASS Formsigprdft AS FormBase

    *-- Dimensoes e propriedades visuais (SCX original: Width=500, Height=370)
    Height      = 370
    Width       = 500
    BorderStyle = 2
    AutoCenter  = .T.
    Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    TitleBar    = 0
    WindowType  = 1
    ShowTips    = .T.
    Themes      = .F.
    AlwaysOnTop = .T.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Propriedades de estado do form TEF
    *-- (Convertidas de PUBLIC vars do legado para propriedades encapsuladas)
    this_lKeyEsc    = .T.    && pckeyesc - habilita ESC para cancelar
    this_lTvenda    = .T.    && pctvenda - habilita selecao de tipo de venda
    this_cBandeira  = ""     && pcBandeira - bandeira do cartao (5 digitos)
    this_lsCartao   = ""     && lsCartao - primeiros 5 digitos do cartao
    this_lAbandona  = .F.    && abandona - flag de abandono da transacao
    this_lTipoVenda = .F.    && llTipoVenda - fluxo de selecao de tipo de venda detectado

    *==========================================================================
    * Init - Recebe parametros TEF, inicializa BO e chama FormBase.Init
    * Equivale ao PROCEDURE Init do legado com PARAMETERS EndSiTef, ValPago, ...
    *
    * Parametros (via CREATEOBJECT):
    *   par_cEndSiTef  - Endereco IP/DNS do servidor SiTef
    *   par_nValPago   - Valor da transacao (numerico)
    *   par_cCupom     - Numero do cupom fiscal
    *   par_cCaixa     - Identificador do caixa/terminal
    *   par_cDebCred   - Modalidade: "D"=Debito, "C"=Credito, "P"=Pre-datado
    *   par_cTipPagto  - Tipo de pagamento (codigo)
    *   par_nNumParcs  - Numero de parcelas
    *   par_nIdent     - Identificador da transacao (ltIdent no legado)
    *   par_cOpers     - Codigo da forma de pagamento (FPags em SigOpFp)
    *==========================================================================
    PROCEDURE Init(par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
                   par_cDebCred, par_cTipPagto, par_nNumParcs, par_nIdent, par_cOpers)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Instancia o BO antes de DODEFAULT() para que InicializarForm o encontre
            THIS.this_oBusinessObject = CREATEOBJECT("sigprdftBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Transfere parametros de entrada para o BO
                THIS.this_oBusinessObject.this_cEndSiTef  = ;
                    IIF(VARTYPE(par_cEndSiTef)  = "C", ALLTRIM(par_cEndSiTef),  "")
                THIS.this_oBusinessObject.this_nValPago   = ;
                    IIF(VARTYPE(par_nValPago)   = "N", par_nValPago,             0)
                THIS.this_oBusinessObject.this_cCupom     = ;
                    IIF(VARTYPE(par_cCupom)     = "C", ;
                        TRANSFORM(par_cCupom, "@L 999999"), "")
                THIS.this_oBusinessObject.this_cCaixa     = ;
                    IIF(VARTYPE(par_cCaixa)     = "C", par_cCaixa,               "")
                THIS.this_oBusinessObject.this_cDebCred   = ;
                    IIF(VARTYPE(par_cDebCred)   = "C", par_cDebCred,             "")
                THIS.this_oBusinessObject.this_cTipPagto  = ;
                    IIF(VARTYPE(par_cTipPagto)  = "C", par_cTipPagto,            "")
                THIS.this_oBusinessObject.this_nNumParcs  = ;
                    IIF(VARTYPE(par_nNumParcs)  = "N", par_nNumParcs,            0)
                THIS.this_oBusinessObject.this_nIdent     = ;
                    IIF(VARTYPE(par_nIdent)     = "N", par_nIdent,               0)
                THIS.this_oBusinessObject.this_cOpers     = ;
                    IIF(VARTYPE(par_cOpers)     = "C", par_cOpers,               "")

                *-- Estado inicial da transacao
                THIS.this_oBusinessObject.this_cParcs  = ;
                    TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
                THIS.this_oBusinessObject.this_cSaque  = "0,00"
                THIS.this_oBusinessObject.this_dData   = DATE()
                THIS.this_oBusinessObject.this_lDCD    = .F.
                THIS.this_oBusinessObject.this_cBuffer = SPACE(2000)
                THIS.this_oBusinessObject.this_nContinua = 0
                THIS.this_oBusinessObject.this_nCiclos   = 0

                *-- DODEFAULT() chama FormBase.Init() que chama InicializarForm()
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Erro ao criar sigprdftBO", "Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro Init TEF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Carrega config do banco, declara DLLs, constroi layout visual
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                *-- Modo validacao de UI: apenas constroi layout sem SQL
                THIS.ConfigurarLayout()
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados...", ;
                    "Conex" + CHR(227) + "o")
            ELSE
                *-- Carrega configuracao SigOpFp (tipo cartao, CDC, garantias, saque)
                THIS.this_oBusinessObject.CarregarConfig( ;
                    THIS.this_oBusinessObject.this_cOpers)

                *-- Carrega numero do caixa de SigFiMpF
                THIS.this_oBusinessObject.CarregarCaixa( ;
                    THIS.this_oBusinessObject.this_cCaixa)

                *-- Declara funcoes da DLL SiTef (equivale ao PROCEDURE Load legado)
                IF THIS.InicializarDLLs()
                    *-- Constroi o layout visual (form plano sem PageFrame)
                    THIS.ConfigurarLayout()

                    *-- Ajusta estado inicial dos controles conforme config carregada
                    THIS.AjustarComportamento()

                    *-- Torna todos os controles visiveis apos AddObject
                    THIS.TornarControlesVisiveis()

                    *-- Form de pagamento sempre no topo
                    THIS.AlwaysOnTop = .T.
                    THIS.ZOrder(0)

                    loc_lSucesso = .T.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarDLLs - Declara as funcoes da DLL CliSiTef32I.DLL
    * Equivale ao PROCEDURE Load do formulario legado
    * Retorna .T. se DLL disponivel, .F. se nao encontrada
    *==========================================================================
    PROTECTED FUNCTION InicializarDLLs() AS Boolean
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado

            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnModalidade, String lsValor, String lsCupom, ;
                String lsData, String lsHorario, String lsOperador, String lsRestricao

            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @lnComando, Integer @lnTipo, ;
                Integer @lnMinimo, Integer @lnMaximo, ;
                String @lsBuffer, Integer lnTamanho, Integer lnResultado

            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnConfirma, String lsCupom, String lsData, String lsHorario

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("DLL SiTef n" + CHR(227) + "o encontrada: " + ;
                loc_oErro.Message, "DLL CliSiTef32I")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConfigurarLayout - Constroi controles visuais do form plano (sem PageFrame)
    * O form legado nao tem PageFrame - e um dialog flat de 500x370
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLayout()
        LOCAL loc_oErro

        TRY
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarSaida()
            THIS.ConfigurarShape()
            THIS.ConfigurarContainer1()
            THIS.ConfigurarCamposEntrada()
            THIS.ConfigurarOptionGroup()
            THIS.VincularEventos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarLayout")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container sombra/titulo cinza no topo
    * Equivale ao cntSombra do legado (Top=0, Width=800, Height=80)
    * No novo sistema: Width = THIS.Width (500px)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCnt = THIS.cnt_4c_Cabecalho

        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarSaida - CommandGroup com botao CANCELA
    * Equivale ao SAIDA commandgroup do legado
    * Top=-2 (sobrepoe o cabecalho), Left=420 (borda direita do form 500px)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
        LOCAL loc_oCg

        THIS.AddObject("cnt_4c_Saida", "CommandGroup")
        loc_oCg = THIS.cnt_4c_Saida

        WITH loc_oCg
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Height      = 85
            .Left        = 420
            .Top         = -2
            .Width       = 85
            .TabIndex    = 8
            .BackColor   = RGB(255,255,255)
            .Themes      = .F.

            WITH .Buttons(1)
                .Top                = 5
                .Left               = 5
                .Height             = 75
                .Width              = 75
                .FontBold           = .T.
                .FontItalic         = .T.
                .FontName           = "Tahoma"
                .FontSize           = 8
                .Picture            = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .DisabledPicture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Caption            = "Cancelar"
                .Cancel             = .F.
                .ForeColor          = RGB(90,90,90)
                .BackColor          = RGB(255,255,255)
                .Themes             = .F.
                .SpecialEffect      = 0
                .PicturePosition    = 13
                .MousePointer       = 15
                .WordWrap           = .T.
                .AutoSize           = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarShape - Shape decorativo ao redor dos campos de entrada
    * Equivale ao Shape2 do legado (Top=93, Left=17, Height=202, Width=466)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape2", "Shape")

        WITH THIS.shp_4c_Shape2
            .Top           = 93
            .Left          = 17
            .Height        = 202
            .Width         = 466
            .SpecialEffect = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainer1 - Container de instrucao ao usuario
    * Equivale ao Container1 do legado (Top=298, Left=54, Width=392, Height=58)
    * Exibe mensagem como "Insira ou Passe o Cartao", "Digite a Senha", etc.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer1()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Instrucao", "Container")
        loc_oCnt = THIS.cnt_4c_Instrucao

        WITH loc_oCnt
            .Top           = 298
            .Left          = 54
            .Width         = 392
            .Height        = 58
            .SpecialEffect = 0

            .AddObject("lbl_4c_Instrucao", "Label")
            WITH .lbl_4c_Instrucao
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .Alignment  = 2
                .Caption    = "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
                .Height     = 29
                .Left       = 18
                .Top        = 14
                .Width      = 349
                .ForeColor  = RGB(90,90,90)
                .BackStyle  = 0
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * AjustarComportamento - Ajusta estado inicial apos carregar config do banco
    * Inicializa flags que controlam habilitacao de campos e cancelamento ESC
    *==========================================================================
    PROTECTED PROCEDURE AjustarComportamento()
        LOCAL loc_oBO, loc_oErro
        loc_oBO = THIS.this_oBusinessObject

        TRY
            THIS.this_lKeyEsc    = .T.
            THIS.this_lAbandona  = .F.
            THIS.this_lTipoVenda = .F.

            *-- Valor formatado no campo de exibicao (readonly)
            IF VARTYPE(THIS.txt_4c_Valor) = "O"
                THIS.txt_4c_Valor.Value = STRTRAN( ;
                    ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ",")
            ENDIF

            *-- Data inicial para parcelado/pre-datado
            IF VARTYPE(THIS.txt_4c_Datas) = "O"
                THIS.txt_4c_Datas.Value = DATE()
            ENDIF

            *-- Numero de parcelas
            IF VARTYPE(THIS.txt_4c_Text1) = "O"
                THIS.txt_4c_Text1.Value = TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")
            ENDIF

            *-- Se cartao fisico disponivel: habilita campo numero do cartao
            IF loc_oBO.this_cLCartao = "S"
                IF VARTYPE(THIS.txt_4c_Cartao) = "O"
                    THIS.txt_4c_Cartao.Enabled = .T.
                ENDIF
                IF VARTYPE(THIS.lbl_4c_Label2) = "O"
                    THIS.lbl_4c_Label2.Caption = "Validade Cart" + CHR(227) + "o :"
                ENDIF
            ENDIF

            *-- Instrucao inicial conforme tipo de entrada do cartao
            IF VARTYPE(THIS.cnt_4c_Instrucao) = "O"
                IF VARTYPE(THIS.txt_4c_Datas) = "O" AND !THIS.txt_4c_Datas.Enabled
                    IF loc_oBO.this_cLCartao = "N"
                        THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
                            "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
                    ELSE
                        THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
                            "Digite o N" + CHR(250) + "mero" + CHR(13) + "do Cart" + CHR(227) + "o"
                    ENDIF
                ELSE
                    THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
                        "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
                ENDIF
            ENDIF

            *-- OptionGroup de tipo de venda: desabilitado ate completar handshake SiTef
            IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                THIS.obj_4c_TipoVenda.Enabled = .F.
            ENDIF

            *-- BackColor do campo de digitos: cinza (aguardando GetFocus)
            IF VARTYPE(THIS.txt_4c_Digitos) = "O"
                THIS.txt_4c_Digitos.BackColor = 12632256
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro AjustarComportamento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis apos AddObject
    * AddObject cria controles com Visible=.F. por default
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_oCtrl

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
                   loc_oCtrl.ControlCount > 0
                    THIS.TornarFilhosVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarFilhosVisiveis - Recursao para sub-controles
    *==========================================================================
    PROTECTED PROCEDURE TornarFilhosVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oCtrl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
                   loc_oCtrl.ControlCount > 0
                    THIS.TornarFilhosVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * KeyPress - Intercepta ESC para cancelar a transacao
    * Equivale ao PROCEDURE KeyPress do legado (KeyPreview=.T. na classe)
    *==========================================================================
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
            NODEFAULT
            IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                THIS.cnt_4c_Saida.Buttons(1).Click()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterResultado - Retorna resultado da transacao para o chamador
    * Formato: "cSaque/nParcs/dData+cBandeira+cCartao"
    *==========================================================================
    FUNCTION ObterResultado() AS String
        LOCAL loc_cResultado

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cResultado = THIS.this_oBusinessObject.ObterResultadoFinal()
        ELSE
            loc_cResultado = "0,00/00/" + DTOC(DATE()) + "00000" + "00000"
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * Unload - Retorna resultado ao fechar o form
    * Equivale ao PROCEDURE Unload do legado que faz RETURN(lcSaque+...)
    *==========================================================================
    PROCEDURE Unload()
        RETURN THIS.ObterResultado()
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao destruir o formulario
    * Equivale ao PROCEDURE Release do legado
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy TEF")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Nao aplicavel para form plano TEF (sem PageFrame)
    * Metodo requerido pelo pipeline de migracao multi-fase
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        *-- Form TEF e plano (sem Pages) - nao ha paginas para alternar
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Nao aplicavel: form plano OPERACIONAL sem lista/grid
    * Metodo declarado apenas para atender o pipeline de migracao multi-fase (Fase 4)
    * O layout deste dialog TEF/SiTef eh construido em ConfigurarLayout() e nao
    * possui Page1/Grid CRUD (form flat 500x370 com campos de pagamento)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- No-op: form TEF nao tem lista de registros (dialog modal de transacao)
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Nao aplicavel: form plano OPERACIONAL sem Page2
    * Para forms OPERACIONAIS com layout flat (dialog TEF/SiTef), todos os campos
    * sao inicializados em ConfigurarCamposEntrada() e ConfigurarOptionGroup().
    * Metodo declarado apenas para atender o pipeline de migracao multi-fase (Fase 5)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- No-op: form TEF nao tem Page2 (Dados) - dialog flat 500x370
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarCamposEntrada - Campos de entrada de dados do cartao e pagamento
    * Equivale a GetValor, GetCartao, GetDigitos, Text1, GetDatas + Labels legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposEntrada()
        LOCAL loc_oErro
        TRY
            *-- Label5: VALOR : (SCX original: AutoSize=.T., FontBold=.T.)
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .AutoSize  = .T.
                .FontBold  = .T.
                .Caption   = "VALOR :"
                .Top       = 102
                .Left      = 175
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            *-- GetValor -> txt_4c_Valor: exibe valor formatado
            *-- SCX original: Enabled=.F. (nao ReadOnly), FontBold=.T., Alignment=3, InputMask, Value=0
            THIS.AddObject("txt_4c_Valor", "TextBox")
            WITH THIS.txt_4c_Valor
                .Top       = 99
                .Left      = 222
                .Width     = 100
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 3
                .Enabled   = .F.
                .InputMask = "99,999,999.99"
                .ForeColor = RGB(0,0,0)
                .TabIndex  = 1
                .Value     = 0
            ENDWITH

            *-- Label8: NUMERO CARTAO : (SCX original: AutoSize=.T., FontBold=.T., sem acento)
            THIS.AddObject("lbl_4c_Label8", "Label")
            WITH THIS.lbl_4c_Label8
                .AutoSize  = .T.
                .FontBold  = .T.
                .Caption   = "NUMERO CARTAO :"
                .Top       = 136
                .Left      = 116
                .Width     = 104
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            *-- GetCartao -> txt_4c_Cartao: numero mascarado do cartao (preenchido pelo SiTef)
            *-- SCX original: Enabled=.F., FontBold=.T., Alignment=3, InputMask, MaxLength=19
            THIS.AddObject("txt_4c_Cartao", "TextBox")
            WITH THIS.txt_4c_Cartao
                .Top       = 133
                .Left      = 222
                .Width     = 160
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 3
                .Enabled   = .F.
                .InputMask = "9999999999999999999"
                .MaxLength = 19
                .ForeColor = RGB(0,0,0)
                .TabIndex  = 2
                .Value     = ""
            ENDWITH

            *-- Label2: 4 ULTIMOS DIGITOS : (SCX original: FontBold=.T.)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .T.
                .Caption   = "4 ULTIMOS DIGITOS :"
                .Top       = 171
                .Left      = 101
                .Width     = 119
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            *-- GetDigitos -> txt_4c_Digitos: 4 ultimos digitos (campo principal SiTef)
            *-- SCX original: FontBold=.T., InputMask="9999", BackColor=212,208,200, ForeColor=0,0,0
            THIS.AddObject("txt_4c_Digitos", "TextBox")
            WITH THIS.txt_4c_Digitos
                .Top       = 168
                .Left      = 222
                .Width     = 40
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .InputMask = "9999"
                .BackColor = RGB(212,208,200)
                .ForeColor = RGB(0,0,0)
                .TabIndex  = 3
                .Value     = ""
            ENDWITH

            *-- Label4: TIPO DE VENDA :
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .AutoSize  = .F.
                .Caption   = "TIPO DE VENDA :"
                .Top       = 204
                .Left      = 129
                .Width     = 91
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            *-- Label6: N? PARCELAS :
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .AutoSize  = .F.
                .Caption   = "N" + CHR(186) + " PARCELAS :"
                .Top       = 238
                .Left      = 139
                .Width     = 81
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            *-- Text1 -> txt_4c_Text1: numero de parcelas (habilitado apenas em parcelado)
            THIS.AddObject("txt_4c_Text1", "TextBox")
            WITH THIS.txt_4c_Text1
                .Top       = 235
                .Left      = 222
                .Width     = 27
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 2
                .Enabled   = .F.
                .TabIndex  = 4
                .Value     = ""
            ENDWITH

            *-- Label11: 1a PARCELA/VENCTO :
            THIS.AddObject("lbl_4c_Label11", "Label")
            WITH THIS.lbl_4c_Label11
                .AutoSize  = .F.
                .Caption   = "1" + CHR(170) + " PARCELA/VENCTO :"
                .Top       = 268
                .Left      = 98
                .Width     = 122
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            *-- GetDatas -> txt_4c_Datas: data de vencimento para parcelado pre-datado
            THIS.AddObject("txt_4c_Datas", "TextBox")
            WITH THIS.txt_4c_Datas
                .Top       = 266
                .Left      = 222
                .Width     = 75
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Format    = "D"
                .Enabled   = .F.
                .TabIndex  = 5
                .Value     = {}
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarCamposEntrada")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarOptionGroup - OptionGroup tipo de venda (A Vista / Parcelado)
    * Equivale ao Optiongroup1 legado (Top=200, Left=222, W=161, H=26)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOptionGroup()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_TipoVenda", "OptionGroup")

            WITH THIS.obj_4c_TipoVenda
                .Top         = 200
                .Left        = 222
                .Width       = 161
                .Height      = 26
                .ButtonCount = 2
                .Value       = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .TabIndex    = 6

                WITH .Buttons(1)
                    .Caption   = CHR(192) + " Vista"
                    .Top       = 2
                    .Left      = 0
                    .Width     = 70
                    .Height    = 20
                    .BackStyle = 0
                    .ForeColor = RGB(90,90,90)
                ENDWITH

                WITH .Buttons(2)
                    .Caption   = "Parcelado"
                    .Top       = 2
                    .Left      = 75
                    .Width     = 80
                    .Height    = 20
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarOptionGroup")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularEventos - BINDEVENT todos os handlers de eventos dos controles
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos()
        LOCAL loc_oErro
        TRY
            BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",         THIS, "TxtDigitosGotFocus")
            BINDEVENT(THIS.txt_4c_Digitos, "KeyPress",         THIS, "TxtDigitosKeyPress")
            BINDEVENT(THIS.txt_4c_Text1,   "GotFocus",         THIS, "TxtText1GotFocus")
            BINDEVENT(THIS.txt_4c_Text1,   "KeyPress",       THIS, "TxtText1LostFocus")
            BINDEVENT(THIS.txt_4c_Text1,   "KeyPress",         THIS, "TxtText1KeyPress")
            BINDEVENT(THIS.txt_4c_Datas,   "GotFocus",         THIS, "TxtDatasGotFocus")
            BINDEVENT(THIS.txt_4c_Datas,   "KeyPress",         THIS, "TxtDatasKeyPress")
            BINDEVENT(THIS.obj_4c_TipoVenda, "InteractiveChange", THIS, "OgTipoVendaInteractiveChange")
            BINDEVENT(THIS.obj_4c_TipoVenda, "KeyPress",          THIS, "OgTipoVendaKeyPress")
            BINDEVENT(THIS.cnt_4c_Saida.Buttons(1), "Click",  THIS, "CmdCancelaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro VincularEventos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarInstrucao - Atualiza label de instrucao ao usuario
    * Equivale a ThisForm.Container1.Label1.Caption = ... no legado
    *==========================================================================
    PROCEDURE AtualizarInstrucao(par_cTexto)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Instrucao) = "O" AND ;
               VARTYPE(THIS.cnt_4c_Instrucao.lbl_4c_Instrucao) = "O"
                THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = par_cTexto
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AtualizarInstrucao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CancelarTransacao - Grava retorno de falha e fecha o form
    *==========================================================================
    PROCEDURE CancelarTransacao(par_cMensagem)
        LOCAL loc_cMsg
        loc_cMsg = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio", ;
            par_cMensagem)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RetornoFalha(loc_cMsg, ;
                THIS.this_oBusinessObject.this_nValPago)
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ExecutarLoopSiTef - Loop principal de interacao com ContinuaFuncaoSiTefInterativo
    * Roda ate cmd=22 (aguarda entrada usuario) ou cmd=30 (fim transacao)
    * par_nContinua: 1000=novo/dado enviado, 0=ack mensagem, -1=cancelar
    * Retorna .T. se parou em cmd=22 (esperando entrada), .F. se cmd=30 ou erro
    *==========================================================================
    FUNCTION ExecutarLoopSiTef(par_nContinua AS Integer) AS Boolean
        LOCAL loc_oBO, loc_lParouEmEntrada, loc_oErro
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf, loc_nRet
        LOCAL loc_nCont, loc_lFimLoop
        loc_lParouEmEntrada = .F.
        loc_lFimLoop = .F.
        loc_nCont = par_nContinua
        loc_oBO = THIS.this_oBusinessObject

        TRY
            DO WHILE !loc_lFimLoop
                loc_nCmd  = loc_oBO.this_nProximoComando
                loc_nTipo = loc_oBO.this_nTipoCampo
                loc_nMin  = loc_oBO.this_nTamanhoMinimo
                loc_nMax  = loc_oBO.this_nTamanhoMaximo
                loc_cBuf  = SPACE(2000)

                loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                    @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                    @loc_cBuf, LEN(loc_cBuf), loc_nCont)

                loc_oBO.this_nProximoComando = loc_nCmd
                loc_oBO.this_nTipoCampo      = loc_nTipo
                loc_oBO.this_nTamanhoMinimo  = loc_nMin
                loc_oBO.this_nTamanhoMaximo  = loc_nMax
                loc_oBO.this_cBuffer         = loc_cBuf

                *-- Deteccao de senha no buffer
                IF "SENHA"$UPPER(ALLTRIM(loc_cBuf))
                    THIS.AtualizarInstrucao("Digite a Senha")
                ENDIF

                *-- Coleta campos de retorno SiTef durante o loop
                IF loc_nCmd = 3
                    loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
                ENDIF
                IF loc_nTipo = 100
                    loc_oBO.this_cTipTran = loc_cBuf
                ENDIF
                IF loc_nTipo = 105
                    loc_oBO.this_cDataHora = loc_cBuf
                ENDIF
                IF loc_nTipo = 121
                    loc_oBO.this_cCupom = loc_cBuf
                ENDIF
                IF loc_nTipo = 131
                    loc_oBO.this_cCartao = LEFT(loc_cBuf, 5)
                ENDIF
                IF loc_nTipo = 132
                    loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
                ENDIF
                IF loc_nTipo = 134
                    loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
                ENDIF
                IF loc_nTipo = 135
                    loc_oBO.this_cAutoriza = loc_cBuf
                ENDIF
                IF loc_nRet <> 0
                    loc_oBO.this_cFinaliza = loc_cBuf
                ENDIF

                *-- Erro SiTef: sinaliza abandono e encerra loop
                IF loc_nRet < 0
                    THIS.ErroTef(loc_nRet)
                    loc_lFimLoop = .T.
                ELSE
                    IF loc_nRet = 0
                    loc_lFimLoop = .T.
                ELSE
                    DO CASE
                        CASE loc_nCmd = 21    && Exibir mensagem
                            THIS.AtualizarInstrucao(ALLTRIM(loc_cBuf))
                            IF !EMPTY(ALLTRIM(loc_cBuf))
                                loc_oBO.this_cMensagem = ALLTRIM(loc_cBuf)
                            ENDIF
                            loc_nCont = 0

                        CASE loc_nCmd = 22    && Aguarda entrada do usuario
                            THIS.AtualizarInstrucao(ALLTRIM(loc_cBuf))
                            loc_lFimLoop = .T.
                            loc_lParouEmEntrada = .T.
                            IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                                THIS.cnt_4c_Saida.Buttons(1).Enabled = .T.
                            ENDIF

                        CASE loc_nCmd = 23    && PIN pad
                            THIS.AtualizarInstrucao("Digite a Senha")
                            IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                                THIS.cnt_4c_Saida.Buttons(1).Enabled = .F.
                            ENDIF
                            loc_nCont = 0

                        CASE loc_nCmd = 30    && Fim da transacao
                            loc_lFimLoop = .T.
                            IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                                THIS.cnt_4c_Saida.Buttons(1).Enabled = .T.
                            ENDIF

                        OTHERWISE
                            loc_nCont = 0
                    ENDCASE
                    ENDIF
                ENDIF

                loc_oBO.this_nCiclos = loc_oBO.this_nCiclos + 1
                IF loc_oBO.this_nCiclos > 10000
                    loc_lFimLoop = .T.
                ENDIF
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro Loop SiTef")
        ENDTRY

        RETURN loc_lParouEmEntrada
    ENDFUNC

    *==========================================================================
    * ProcessarFimTransacao - Processa resultado quando cmd=30 (fim transacao)
    * Confirma no SiTef, coleta campos de retorno e grava arquivos de resposta
    *==========================================================================
    PROCEDURE ProcessarFimTransacao()
        LOCAL loc_oBO, loc_cData, loc_cHora, loc_oErro, loc_cBuf
        loc_oBO = THIS.this_oBusinessObject
        TRY
            *-- Data/hora para finalizacao
            loc_cData = STR(YEAR(DATE()), 4) + ;
                        SUBSTR(DTOC(DATE()), 4, 2) + ;
                        SUBSTR(DTOC(DATE()), 1, 2)
            loc_cHora = STRTRAN(TIME(), ":", "")

            *-- Confirma transacao no SiTef (1=confirmar)
            FinalizaTransacaoSiTefInterativo(1, loc_oBO.this_cCupom, loc_cData, loc_cHora)

            *-- Extrai campos do buffer acumulado no BO (formato SiTef: campos separados por CHR(0))
            loc_cBuf = ALLTRIM(loc_oBO.this_cBuffer)
            IF !EMPTY(loc_cBuf)
                loc_oBO.this_cTipTran  = THIS.ExtrairCampoBuf(loc_cBuf, 1)
                loc_oBO.this_cDataHora = THIS.ExtrairCampoBuf(loc_cBuf, 2)
                loc_oBO.this_cCartao   = LEFT(ALLTRIM(THIS.ExtrairCampoBuf(loc_cBuf, 3)), 5)
                loc_oBO.this_cNsu      = THIS.ExtrairCampoBuf(loc_cBuf, 4)
                loc_oBO.this_cAutoriza = THIS.ExtrairCampoBuf(loc_cBuf, 5)
                loc_oBO.this_cBandeira = LEFT(ALLTRIM(THIS.ExtrairCampoBuf(loc_cBuf, 6)), 5)
                loc_oBO.this_cFinaliza = THIS.ExtrairCampoBuf(loc_cBuf, 7)
            ENDIF

            *-- Grava arquivos de resposta C:\client\Resp\IntPos.*
            loc_oBO.MontarRetorno( ;
                loc_oBO.this_cTipTran, ;
                loc_oBO.this_cDataHora, ;
                loc_oBO.this_cCupom, ;
                loc_oBO.this_cCartao + loc_oBO.this_cBandeira, ;
                loc_oBO.this_cNsu, ;
                loc_oBO.this_cAutoriza, ;
                loc_oBO.this_cFinaliza, ;
                loc_oBO.this_nValPago, ;
                loc_oBO.this_cMRet)

            THIS.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ProcessarFimTransacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ExtrairCampoBuf - Extrai campo N do buffer de retorno SiTef (CHR(0) como delimitador)
    *==========================================================================
    PROTECTED FUNCTION ExtrairCampoBuf(par_cBuffer AS String, par_nPos AS Integer) AS String
        LOCAL loc_cBuf, loc_nI, loc_nIni, loc_nFim
        loc_cBuf = par_cBuffer
        loc_nIni = 1

        FOR loc_nI = 1 TO par_nPos - 1
            loc_nFim = AT(CHR(0), loc_cBuf, loc_nI)
            IF loc_nFim = 0
                RETURN ""
            ENDIF
            loc_nIni = loc_nFim + 1
        ENDFOR

        loc_nFim = AT(CHR(0), loc_cBuf, par_nPos)
        IF loc_nFim = 0
            RETURN ALLTRIM(SUBSTR(loc_cBuf, loc_nIni))
        ENDIF
        RETURN ALLTRIM(SUBSTR(loc_cBuf, loc_nIni, loc_nFim - loc_nIni))
    ENDFUNC

    *==========================================================================
    * TxtDigitosGotFocus - GotFocus de txt_4c_Digitos
    * Inicializa conexao SiTef e executa loop inicial ate pedir entrada
    * Equivale a GetDigitos.GotFocus do legado (231 linhas)
    *==========================================================================
    PROCEDURE TxtDigitosGotFocus()
        LOCAL loc_oBO, loc_cValPago, loc_cIdTerminal, loc_nRet, loc_oErro
        LOCAL loc_cData, loc_cHora, loc_lSucesso
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
        LOCAL loc_nCont, loc_nTipo1, loc_cBandeira, loc_nTipoVendaCount
        LOCAL loc_cDataFmt
        loc_oBO = THIS.this_oBusinessObject
        loc_lSucesso = .F.

        TRY
            *-- ID do terminal: empresa (4 dig) + caixa (6 dig)
            loc_cIdTerminal = TRANSFORM(loc_oBO.this_nEmps,    "@L 9999") + ;
                              TRANSFORM(loc_oBO.this_nCncaixas, "@L 999999")

            *-- Formata valor para SiTef (virgula como separador decimal)
            loc_cValPago = STRTRAN( ;
                ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ",")

            IF VARTYPE(THIS.txt_4c_Valor) = "O"
                THIS.txt_4c_Valor.Value = loc_cValPago
            ENDIF

            *-- Configura interface SiTef (retorna 0 = sucesso)
            loc_nRet = ConfiguraIntSiTefInterativo( ;
                loc_oBO.this_cEndSiTef, ;
                loc_cIdTerminal, ;
                loc_cIdTerminal, ;
                0)
            IF loc_nRet = 0
                loc_lSucesso = .T.
            ELSE
                THIS.CancelarTransacao("Sem comunica" + CHR(231) + CHR(227) + "o com SiTef")
            ENDIF

            IF loc_lSucesso
                *-- Data e hora no formato SiTef (AAAAMMDD e HHMMSS)
                loc_cData = STR(YEAR(DATE()), 4) + ;
                            SUBSTR(DTOC(DATE()), 4, 2) + ;
                            SUBSTR(DTOC(DATE()), 1, 2)
                loc_cHora = STRTRAN(TIME(), ":", "")

                *-- Inicia transacao SiTef (retorna 10000=sucesso, outro=erro)
                loc_nRet = IniciaFuncaoSiTefInterativo( ;
                    0, ;
                    loc_cValPago, ;
                    loc_oBO.this_cCupom, ;
                    loc_cData, ;
                    loc_cHora, ;
                    loc_oBO.this_cCaixa, ;
                    "")
                IF loc_nRet <> 10000
                    THIS.CancelarTransacao("Sem comunica" + CHR(231) + CHR(227) + "o com SiTef")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- Inicializa estado SiTef pos-Inicia
                loc_oBO.this_nProximoComando = 0
                loc_oBO.this_nTipoCampo      = 0
                loc_oBO.this_nTamanhoMinimo  = 0
                loc_oBO.this_nTamanhoMaximo  = 0
                loc_oBO.this_cBuffer         = SPACE(2000)
                loc_oBO.this_nContinua       = 0
                loc_oBO.this_nCiclos         = 0
                loc_oBO.this_lDCD            = .F.
                THIS.this_lTipoVenda         = .F.

                *-- Limpa campos de retorno acumulados
                loc_oBO.this_cTipTran  = ""
                loc_oBO.this_cDataHora = ""
                loc_oBO.this_cNsu      = ""
                loc_oBO.this_cAutoriza = ""
                loc_oBO.this_cFinaliza = ""
                loc_oBO.this_cCartao   = ""
                loc_oBO.this_cBandeira = ""
                loc_oBO.this_cMRet     = ""

                *-- OptionGroup desabilitado ate concluir handshake
                IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                    THIS.obj_4c_TipoVenda.Enabled = .F.
                ENDIF

                *-- Loop de inicializacao SiTef (apenas sem leitora fisica: lCartao="N")
                loc_nRet           = 10000
                loc_nCont          = 0
                loc_nTipo1         = 1
                loc_cBandeira      = ""
                loc_nTipoVendaCount = 0

                IF loc_oBO.this_cLCartao = "N"
                    DO WHILE loc_nRet = 10000
                        loc_nCmd  = loc_oBO.this_nProximoComando
                        loc_nTipo = loc_oBO.this_nTipoCampo
                        loc_nMin  = loc_oBO.this_nTamanhoMinimo
                        loc_nMax  = loc_oBO.this_nTamanhoMaximo
                        loc_cBuf  = SPACE(2000)

                        loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                            @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                            @loc_cBuf, LEN(loc_cBuf), loc_nCont)

                        loc_oBO.this_nProximoComando = loc_nCmd
                        loc_oBO.this_nTipoCampo      = loc_nTipo
                        loc_oBO.this_nTamanhoMinimo  = loc_nMin
                        loc_oBO.this_nTamanhoMaximo  = loc_nMax
                        loc_oBO.this_cBuffer         = loc_cBuf

                        *-- Deteccao de tipo de venda (string SiTef especifica)
                        IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO"$UPPER(loc_cBuf)
                            IF loc_nTipoVendaCount = 2
                                THIS.this_lTipoVenda = .T.
                            ELSE
                                loc_nTipoVendaCount = 2
                            ENDIF
                        ENDIF

                        *-- Cancelar: desabilitado durante PIN
                        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                            THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
                        ENDIF

                        *-- cmd=22 com buffer: mensagem de erro do SiTef
                        IF loc_nCmd = 22 AND !EMPTY(ALLTRIM(loc_cBuf))
                            MsgErro(ALLTRIM(SUBSTR(loc_cBuf, 1, 32)) + CHR(13) + ;
                                ALLTRIM(SUBSTR(loc_cBuf, 33, 32)), ;
                                "Erro na Transa" + CHR(231) + CHR(227) + "o")
                            loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                                @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                                @loc_cBuf, LEN(loc_cBuf), loc_nCont)
                            loc_oBO.this_nProximoComando = loc_nCmd
                            loc_nRet = -1
                            EXIT
                        ENDIF

                        IF UPPER(ALLTRIM(loc_cBuf)) = "DIGITE A SENHA"
                            THIS.AtualizarInstrucao("Digite a Senha")
                        ENDIF

                        IF loc_nRet = 0
                            EXIT
                        ENDIF
                        IF loc_nRet < 0
                            THIS.ErroTef(loc_nRet)
                            EXIT
                        ENDIF

                        *-- cmd=3: mensagem de retorno
                        IF loc_nCmd = 3
                            loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
                        ENDIF

                        *-- Coleta campos de retorno SiTef
                        IF loc_nTipo = 100
                            loc_oBO.this_cTipTran = loc_cBuf
                            loc_oBO.this_cBuffer  = SPACE(2000)
                            loc_nCont = 0
                            LOOP
                        ENDIF
                        IF loc_nTipo = 105
                            loc_oBO.this_cDataHora = loc_cBuf
                            loc_oBO.this_cBuffer   = SPACE(2000)
                            LOOP
                        ENDIF
                        IF loc_nTipo = 121
                            loc_oBO.this_cCupom  = loc_cBuf
                            loc_oBO.this_cBuffer = SPACE(2000)
                            LOOP
                        ENDIF
                        IF loc_nTipo = 131
                            loc_oBO.this_cCartao = LEFT(loc_cBuf, 5)
                        ENDIF
                        IF loc_nTipo = 132
                            loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
                            loc_oBO.this_cBuffer   = SPACE(2000)
                            LOOP
                        ENDIF
                        IF loc_nTipo = 134
                            loc_oBO.this_cNsu    = ALLTRIM(STR(VAL(loc_cBuf)))
                            loc_oBO.this_cBuffer = SPACE(2000)
                            LOOP
                        ENDIF
                        IF loc_nTipo = 135
                            loc_oBO.this_cAutoriza = loc_cBuf
                            loc_oBO.this_cBuffer   = SPACE(2000)
                            LOOP
                        ENDIF

                        *-- cmd=20 + TipoCampo=507: primeira parcela a vista
                        IF loc_nCmd = 20 AND loc_nTipo = 507
                            IF MsgConfirma("Primeira Parcela A Vista")
                                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=21: negociacao do tipo de pagamento (debito/credito/parcelas)
                        IF loc_nCmd = 21
                            IF loc_nTipo1 = 1
                                IF loc_oBO.this_cDebCred = "D" OR loc_oBO.this_cDebCred = "P"
                                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                                ELSE
                                    loc_oBO.this_cBuffer = "3" + REPLICATE(CHR(0), 1999)
                                ENDIF
                                loc_nCont  = 1000
                                loc_nTipo1 = 2
                                LOOP
                            ENDIF
                            IF loc_nTipo1 = 2
                                IF loc_oBO.this_nNumParcs = 1
                                    EXIT
                                ELSE
                                    IF loc_oBO.this_cTcdc = "S"
                                        IF loc_oBO.this_cDebCred <> "P"
                                            loc_oBO.this_cBuffer = "5" + REPLICATE(CHR(0), 1999)
                                        ELSE
                                            loc_oBO.this_cBuffer = "4" + REPLICATE(CHR(0), 1999)
                                        ENDIF
                                    ELSE
                                        loc_oBO.this_cBuffer = "3" + REPLICATE(CHR(0), 1999)
                                    ENDIF
                                    loc_nCont = 1000
                                    LOOP
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- TipoCampo=131 (segunda ocorrencia): bandeira completa
                        IF loc_nTipo = 131
                            loc_cBandeira = loc_cBuf
                            loc_oBO.this_cCartao = LEFT(loc_cBuf, 5)
                        ENDIF

                        *-- cmd=30 + bandeira "00004": sai sem solicitar tipo de venda
                        IF loc_nCmd = 30 AND loc_cBandeira = "00004"
                            EXIT
                        ENDIF

                        *-- cmd=30 + TipoCampo=506: envia data no formato DDMMAAAA
                        IF loc_nCmd = 30 AND loc_nTipo = 506
                            loc_cDataFmt = DTOC(THIS.txt_4c_Datas.Value)
                            loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
                                ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
                                ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
                                REPLICATE(CHR(0), 1992)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=508: envia numero de dias
                        IF loc_nCmd = 30 AND loc_nTipo = 508
                            loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nDias)) + ;
                                REPLICATE(CHR(0), 1998)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=20 + TipoCampo=509: envia mes de fechamento CDC
                        IF loc_nCmd = 20 AND loc_nTipo = 509
                            loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nMesFec - 1)) + ;
                                REPLICATE(CHR(0), 1999)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- Envia parcelas: TipoCampo 511+Tcdc, 505, -1+Tcdc+P+!DDMMAAAA
                        IF (loc_nCmd = 30 AND loc_nTipo = 511 AND loc_oBO.this_cTcdc = "S") OR ;
                           (loc_nCmd = 30 AND loc_nTipo = 505) OR ;
                           (loc_nCmd = 30 AND loc_nTipo = -1 AND loc_oBO.this_cTcdc = "S" AND ;
                            loc_oBO.this_cDebCred = "P" AND !("DDMMAAAA"$loc_cBuf))
                            loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nNumParcs)) + ;
                                REPLICATE(CHR(0), 1998)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=-1 + 'DDMMAAAA' no buffer: desabilita GetDigitos
                        IF loc_nCmd = 30 AND loc_nTipo = -1 AND "DDMMAAAA"$loc_cBuf
                            IF VARTYPE(THIS.txt_4c_Digitos) = "O"
                                THIS.txt_4c_Digitos.Enabled = .F.
                            ENDIF
                            EXIT
                        ENDIF

                        *-- Caso geral: acumula mensagem e reinicia buffer
                        IF loc_nCmd <> 21
                            loc_oBO.this_cMensagem = loc_cBuf
                            loc_oBO.this_cBuffer   = SPACE(2000)
                            loc_nCont = 0
                        ENDIF
                    ENDDO
                ENDIF

                *-- Pos-loop: visibilidade do container de instrucao
                IF VARTYPE(THIS.cnt_4c_Instrucao) = "O"
                    THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Visible = .T.
                ENDIF

                *-- Libera form em caso de erro ou abandono
                IF loc_nRet < 0 OR THIS.this_lAbandona
                    THIS.Release()
                ELSE
                    *-- NSU coletado = transacao concluida automaticamente (sem acao do usuario)
                    IF !EMPTY(loc_oBO.this_cNsu)
                        THIS.ProcessarFimTransacao()
                        THIS.Release()
                    ELSE
                        *-- Atualiza display do cartao (campo mascarado)
                        IF VARTYPE(THIS.txt_4c_Cartao) = "O"
                            THIS.txt_4c_Cartao.Value = "#### #### #### ####"
                        ENDIF
                        IF VARTYPE(THIS.txt_4c_Digitos) = "O"
                            THIS.txt_4c_Digitos.BackColor = RGB(255, 255, 255)
                        ENDIF

                        *-- Define instrucao e habilita controles conforme tipo de venda
                        IF THIS.this_lTipoVenda
                            IF VARTYPE(THIS.txt_4c_Text1) = "O" AND !THIS.txt_4c_Text1.Enabled
                                THIS.AtualizarInstrucao("Informe o Tipo" + CHR(13) + "da Venda")
                                IF VARTYPE(THIS.txt_4c_Digitos) = "O"
                                    THIS.txt_4c_Digitos.Enabled = .F.
                                ENDIF
                                IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                                    THIS.obj_4c_TipoVenda.Enabled = .T.
                                ENDIF
                                IF VARTYPE(THIS.txt_4c_Datas) = "O"
                                    THIS.txt_4c_Datas.Enabled = .T.
                                ENDIF
                            ENDIF
                        ELSE
                            THIS.AtualizarInstrucao("Digite os 4 " + CHR(218) + "ltimos" + ;
                                CHR(13) + "D" + CHR(237) + "gitos do Cart" + CHR(227) + "o")
                            IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                                THIS.obj_4c_TipoVenda.Enabled = .T.
                            ENDIF
                        ENDIF

                        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                            THIS.cnt_4c_Saida.Buttons(1).Enabled = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro TEF GotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDigitosKeyPress - Simula Valid de GetDigitos via ENTER/TAB
    * Envia os 4 digitos ao SiTef e continua o loop de transacao
    * Equivale a GetDigitos.Valid do legado (185 linhas)
    *==========================================================================
    PROCEDURE TxtDigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_cValDigitos, loc_oErro
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
        LOCAL loc_nRet, loc_nCont, loc_lParcelas, loc_nCampo

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            IF THIS.this_lAbandona
                THIS.Release()
            ELSE
                loc_cValDigitos = ALLTRIM(THIS.txt_4c_Digitos.Value)

                IF LEN(loc_cValDigitos) <> 4 AND !EMPTY(loc_cValDigitos)
                    MsgErro("Quantidade de D" + CHR(237) + "gitos Inv" + CHR(225) + "lida", ;
                        "Erro na Transa" + CHR(231) + CHR(227) + "o")
                    THIS.txt_4c_Digitos.Value = ""
                ELSE
                    IF !EMPTY(loc_cValDigitos)
                    *-- Prepara buffer com os 4 digitos + padding
                    loc_oBO.this_cBuffer = loc_cValDigitos + ;
                        REPLICATE(CHR(0), 2000 - LEN(loc_cValDigitos))
                    loc_oBO.this_nCiclos = 0
                    loc_nRet     = 10000
                    loc_nCont    = 1000
                    loc_lParcelas = .F.
                    loc_nCampo   = 1

                    DO WHILE loc_nRet = 10000
                        loc_nCmd  = loc_oBO.this_nProximoComando
                        loc_nTipo = loc_oBO.this_nTipoCampo
                        loc_nMin  = loc_oBO.this_nTamanhoMinimo
                        loc_nMax  = loc_oBO.this_nTamanhoMaximo
                        loc_cBuf  = loc_oBO.this_cBuffer

                        loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                            @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                            @loc_cBuf, LEN(loc_cBuf), loc_nCont)

                        loc_oBO.this_nProximoComando = loc_nCmd
                        loc_oBO.this_nTipoCampo      = loc_nTipo
                        loc_oBO.this_nTamanhoMinimo  = loc_nMin
                        loc_oBO.this_nTamanhoMaximo  = loc_nMax
                        loc_oBO.this_cBuffer         = loc_cBuf

                        *-- Cancelar: desabilitado durante PIN
                        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                            THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
                        ENDIF

                        *-- SENHA no buffer
                        IF "SENHA"$UPPER(ALLTRIM(loc_cBuf))
                            THIS.AtualizarInstrucao("Digite a Senha")
                        ENDIF

                        IF loc_nRet = 0
                            EXIT
                        ENDIF
                        IF loc_nRet < 0
                            THIS.ErroTef(loc_nRet)
                            THIS.Release()
                            EXIT
                        ENDIF

                        *-- cmd=22: mensagem de erro + segundo Continua
                        IF loc_nCmd = 22
                            MsgErro(ALLTRIM(SUBSTR(loc_cBuf, 1, 32)) + CHR(13) + ;
                                ALLTRIM(SUBSTR(loc_cBuf, 33, 32)), ;
                                "Erro na Transa" + CHR(231) + CHR(227) + "o")
                            loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                                @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                                @loc_cBuf, LEN(loc_cBuf), loc_nCont)
                            loc_oBO.this_nProximoComando = loc_nCmd
                            IF loc_nRet <> 10000
                                EXIT
                            ELSE
                                IF loc_lParcelas
                                    IF VARTYPE(THIS.txt_4c_Text1) = "O"
                                        THIS.txt_4c_Text1.Enabled = .T.
                                    ENDIF
                                    IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                                        THIS.obj_4c_TipoVenda.Enabled = .F.
                                    ENDIF
                                    IF VARTYPE(THIS.txt_4c_Digitos) = "O"
                                        THIS.txt_4c_Digitos.Value = ""
                                    ENDIF
                                ENDIF
                                EXIT
                            ENDIF
                        ENDIF

                        *-- cmd=23: PIN pad
                        IF loc_nCmd = 23
                            THIS.AtualizarInstrucao("Aguarde PIN pad...")
                        ENDIF

                        *-- cmd=21: tipo de parcelamento (DCD)
                        IF loc_nCmd = 21
                            IF VARTYPE(THIS.txt_4c_Datas) = "O"
                                loc_oBO.this_cBuffer = IIF(loc_oBO.this_nNumParcs = 1, ;
                                    IIF(THIS.txt_4c_Datas.Value = DATE(), "1", "2"), ;
                                    IIF(loc_oBO.this_cDebCred = "P", "3", "4")) + ;
                                    REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            IF LEFT(loc_oBO.this_cBuffer, 1) = "1"
                                EXIT
                            ENDIF
                            loc_oBO.this_lDCD = .T.
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=510: inversao de risco (Garantias)
                        IF loc_nCmd = 30 AND loc_nTipo = 510
                            IF loc_oBO.this_cGarantias = "S"
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=34 + TipoCampo=130: valor do saque
                        IF loc_nCmd = 34 AND loc_nTipo = 130
                            IF loc_oBO.this_cLSaque = "S"
                                loc_oBO.this_cSaque = "0,00"
                            ELSE
                                loc_oBO.this_cSaque = "0,00"
                            ENDIF
                            loc_oBO.this_cBuffer = loc_oBO.this_cSaque + ;
                                REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cSaque))
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=-1/506 + nao pre-datado: habilita campo data
                        IF loc_nCmd = 30 AND ;
                           (loc_nTipo = -1 OR loc_nTipo = 506) AND ;
                           loc_oBO.this_cDebCred <> "P"
                            IF VARTYPE(THIS.txt_4c_Datas) = "O"
                                THIS.txt_4c_Datas.Enabled = .T.
                            ENDIF
                            EXIT
                        ENDIF

                        *-- cmd=30 + TipoCampo=514: codigo de seguranca
                        IF loc_nCmd = 30 AND loc_nTipo = 514
                            EXIT
                        ENDIF

                        *-- cmd=30 + pre-datado (DebCred=P) OU TipoCampo=511: envia parcelas
                        IF loc_nCmd = 30 AND ;
                           (loc_oBO.this_cDebCred = "P" OR loc_nTipo = 511)
                            IF loc_nCampo = 1
                                loc_oBO.this_cBuffer = TRANSFORM(loc_oBO.this_nNumParcs, "@L 99") + ;
                                    REPLICATE(CHR(0), 1999)
                                loc_lParcelas = .T.
                                loc_nCampo = 2
                                loc_nCont = 1000
                                LOOP
                            ELSE
                                IF VARTYPE(THIS.txt_4c_Datas) = "O"
                                    THIS.txt_4c_Datas.Enabled = .T.
                                ENDIF
                                EXIT
                            ENDIF
                        ENDIF

                        *-- cmd=22 + pre-datado: cupom parcelas
                        IF loc_nCmd = 22 AND loc_oBO.this_cDebCred = "P"
                            loc_oBO.this_cCupom = loc_cBuf
                            loc_nRet = 0
                            EXIT
                        ENDIF

                        *-- Coleta campos de retorno
                        IF loc_nCmd = 3
                            loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
                        ENDIF
                        IF loc_nTipo = 100
                            loc_oBO.this_cTipTran = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 105
                            loc_oBO.this_cDataHora = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 121
                            loc_oBO.this_cCupom = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 131
                            loc_oBO.this_cCartao = LEFT(loc_cBuf, 5)
                        ENDIF
                        IF loc_nTipo = 132
                            loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
                        ENDIF
                        IF loc_nTipo = 134
                            loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
                        ENDIF
                        IF loc_nTipo = 135
                            loc_oBO.this_cAutoriza = loc_cBuf
                        ENDIF
                        IF loc_nRet <> 0
                            loc_oBO.this_cFinaliza = loc_cBuf
                        ENDIF

                        *-- Caso geral: mensagem e reset buffer
                        IF loc_nCmd <> 21 AND loc_nCmd <> 30 AND loc_nCmd <> 34
                            loc_oBO.this_cMensagem = loc_cBuf
                            loc_oBO.this_cBuffer   = SPACE(2000)
                            loc_nCont = 0
                        ENDIF

                        loc_oBO.this_nCiclos = loc_oBO.this_nCiclos + 1
                        IF loc_oBO.this_nCiclos > 10000
                            EXIT
                        ENDIF
                    ENDDO

                    *-- Pos-loop: processa resultado
                    IF loc_nRet <> 10000
                        IF loc_oBO.this_cDebCred = "P" AND loc_oBO.this_cTcdc <> "S"
                            loc_oBO.RetornoFalha("Consulta CDC Realizada", loc_oBO.this_nValPago)
                            THIS.Release()
                        ELSE
                            IF loc_nRet = 0
                                THIS.ProcessarFimTransacao()
                            ELSE
                                THIS.Release()
                            ENDIF
                        ENDIF
                    ELSE
                        *-- Transacao em andamento: define estado dos controles
                        IF loc_nCmd = 30 AND loc_nTipo = 514
                            THIS.AtualizarInstrucao("Digite C" + CHR(243) + "digo" + ;
                                CHR(13) + "de Seguran" + CHR(231) + "a")
                        ELSE
                            IF loc_oBO.this_cDebCred <> "P" AND !loc_oBO.this_lDCD
                                THIS.AtualizarInstrucao("Digite o Tipo" + CHR(13) + "Venda")
                                IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                                    THIS.obj_4c_TipoVenda.Enabled = .T.
                                ENDIF
                                IF VARTYPE(THIS.txt_4c_Datas) = "O"
                                    THIS.txt_4c_Datas.Enabled = .T.
                                ENDIF
                            ELSE
                                IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                                    THIS.obj_4c_TipoVenda.Enabled = .F.
                                ENDIF
                            ENDIF
                        ENDIF
                        IF VARTYPE(THIS.txt_4c_Digitos) = "O"
                            THIS.txt_4c_Digitos.Enabled = .F.
                        ENDIF
                        IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                            THIS.obj_4c_TipoVenda.Enabled = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro TEF Digitos KeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtText1GotFocus - GotFocus do campo de numero de parcelas
    * Equivale a Text1.GotFocus do legado
    *==========================================================================
    PROCEDURE TxtText1GotFocus()
        THIS.this_lTvenda = .F.
    ENDPROC

    *==========================================================================
    * TxtText1LostFocus - LostFocus do campo de numero de parcelas
    * Formata o valor e habilita campo de data de vencimento
    * Equivale a Text1.LostFocus do legado
    *==========================================================================
    PROCEDURE TxtText1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.txt_4c_Text1) = "O"
                THIS.txt_4c_Text1.Value = ;
                    TRANSFORM(VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Text1.Value))), "@L 99")
                THIS.txt_4c_Text1.Enabled = .F.
                IF VARTYPE(THIS.txt_4c_Datas) = "O"
                    THIS.txt_4c_Datas.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TEF Text1 LostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtText1KeyPress - Simula Valid de Text1 via ENTER/TAB (numero de parcelas)
    * Envia contagem de parcelas ao SiTef e continua loop
    * Equivale a Text1.Valid do legado (22 linhas)
    *==========================================================================
    PROCEDURE TxtText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nParcs, loc_oErro

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            IF VARTYPE(THIS.txt_4c_Text1) = "O" AND !EMPTY(THIS.txt_4c_Text1.Value)
                loc_nParcs = VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Text1.Value)))
                loc_oBO.this_nNumParcs = loc_nParcs

                *-- Envia numero de parcelas ao SiTef no Buffer
                loc_oBO.this_cBuffer   = TRANSFORM(loc_nParcs, "@L 99") + ;
                    REPLICATE(CHR(0), 1990)
                loc_oBO.this_nContinua = 1000
                loc_oBO.this_nCiclos   = 0

                THIS.ExecutarLoopSiTef(1000)

                IF loc_oBO.this_nProximoComando = 23
                    IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                        THIS.cnt_4c_Saida.Buttons(1).Enabled = .F.
                    ENDIF
                    THIS.AtualizarInstrucao("Digite a Senha")
                ELSE
                    IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                        THIS.cnt_4c_Saida.Buttons(1).Enabled = .T.
                    ENDIF
                ENDIF

                IF loc_oBO.this_nProximoComando = 30
                    THIS.ProcessarFimTransacao()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro TEF Parcelas KeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDatasGotFocus - GotFocus do campo de data de vencimento (parcelado)
    * Inicia fluxo SiTef para modalidade pre-datada ou parcelada com data
    * Equivale a GetDatas.GotFocus do legado (188 linhas)
    *==========================================================================
    PROCEDURE TxtDatasGotFocus()
        LOCAL loc_oBO, loc_oErro
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
        LOCAL loc_nRet, loc_nCont, loc_cDataFmt, loc_lPrimo
        loc_oBO = THIS.this_oBusinessObject

        TRY
            THIS.this_lTipoVenda = .F.

            *-- Zera campos de resultado acumulados no ciclo anterior
            loc_oBO.this_cTipTran  = ""
            loc_oBO.this_cDataHora = ""
            loc_oBO.this_cNsu      = ""
            loc_oBO.this_cAutoriza = ""
            loc_oBO.this_cFinaliza = ""
            loc_oBO.this_cCartao   = ""
            loc_oBO.this_cBandeira = ""
            loc_oBO.this_cMRet     = ""

            THIS.AtualizarInstrucao("Digite a Data" + CHR(13) + "de Vencimento")

            *-- Fluxo de tipo de venda: somente para debito simples (nao pre-datado, nao DCD, nao CDC)
            IF loc_oBO.this_cDebCred <> "P" AND ;
               !loc_oBO.this_lDCD AND ;
               loc_oBO.this_cTcdc <> "S"

                loc_nRet  = 10000
                loc_nCont = 1000

                IF VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND THIS.obj_4c_TipoVenda.Enabled
                    *-- OptionGroup habilitado: envia selecao do usuario
                    loc_oBO.this_cBuffer = STR(THIS.obj_4c_TipoVenda.Value, 1) + ;
                        REPLICATE(CHR(0), 1999)
                ELSE
                    *-- OptionGroup desabilitado: aguarda SiTef chegar ao cmd=30 primeiro
                    DO WHILE loc_oBO.this_nProximoComando <> 30
                        loc_nCmd  = loc_oBO.this_nProximoComando
                        loc_nTipo = loc_oBO.this_nTipoCampo
                        loc_nMin  = loc_oBO.this_nTamanhoMinimo
                        loc_nMax  = loc_oBO.this_nTamanhoMaximo
                        loc_cBuf  = SPACE(2000)

                        loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                            @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                            @loc_cBuf, LEN(loc_cBuf), loc_nCont)

                        loc_oBO.this_nProximoComando = loc_nCmd
                        loc_oBO.this_nTipoCampo      = loc_nTipo
                        loc_oBO.this_nTamanhoMinimo  = loc_nMin
                        loc_oBO.this_nTamanhoMaximo  = loc_nMax
                        loc_oBO.this_cBuffer         = loc_cBuf

                        IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR loc_nCmd = 23
                            THIS.AtualizarInstrucao("Digite a Senha")
                        ENDIF
                        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                            THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
                        ENDIF
                        IF loc_nRet < 0
                            THIS.ErroTef(loc_nRet)
                            EXIT
                        ENDIF
                    ENDDO

                    IF !THIS.this_lAbandona
                        *-- Envia numero de parcelas do Text1 (campo de parcelas)
                        IF VARTYPE(THIS.txt_4c_Text1) = "O"
                            loc_oBO.this_cBuffer = ALLTRIM(THIS.txt_4c_Text1.Value) + ;
                                REPLICATE(CHR(0), 1998)
                        ELSE
                            loc_oBO.this_cBuffer = "01" + REPLICATE(CHR(0), 1998)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Loop principal: processa tipo de venda e conclui transacao
                IF !THIS.this_lAbandona
                    loc_nRet  = 10000
                    loc_nCont = 1000
                    loc_lPrimo = .T.

                    DO WHILE loc_nRet = 10000
                        loc_nCmd  = loc_oBO.this_nProximoComando
                        loc_nTipo = loc_oBO.this_nTipoCampo
                        loc_nMin  = loc_oBO.this_nTamanhoMinimo
                        loc_nMax  = loc_oBO.this_nTamanhoMaximo
                        loc_cBuf  = loc_oBO.this_cBuffer

                        loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                            @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                            @loc_cBuf, LEN(loc_cBuf), loc_nCont)

                        loc_oBO.this_nProximoComando = loc_nCmd
                        loc_oBO.this_nTipoCampo      = loc_nTipo
                        loc_oBO.this_nTamanhoMinimo  = loc_nMin
                        loc_oBO.this_nTamanhoMaximo  = loc_nMax
                        loc_oBO.this_cBuffer         = loc_cBuf

                        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                            THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
                        ENDIF

                        IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR loc_nCmd = 23
                            THIS.AtualizarInstrucao("Digite a Senha")
                        ENDIF

                        IF loc_nRet < 0
                            THIS.ErroTef(loc_nRet)
                            THIS.Release()
                            EXIT
                        ENDIF

                        *-- cmd=22: mensagem de erro do SiTef
                        IF loc_nCmd = 22
                            IF loc_oBO.this_cDebCred <> "P" AND !EMPTY(ALLTRIM(loc_cBuf))
                                MsgErro(IIF(UPPER(ALLTRIM(loc_cBuf)) = "AGUARDE, EM PROCESSAMENTO", ;
                                    "TRANSACAO CANCELADA", ALLTRIM(loc_cBuf)), ;
                                    "Erro na Transa" + CHR(231) + CHR(227) + "o")
                                IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR ;
                                   "CANC. CLIENTE"$UPPER(ALLTRIM(loc_cBuf))
                                    loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                                        @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                                        @loc_cBuf, LEN(loc_cBuf), -1)
                                    loc_nRet = -8
                                    EXIT
                                ENDIF
                                EXIT
                            ELSE
                                IF loc_oBO.this_cDebCred = "P"
                                loc_oBO.this_cCupom = ALLTRIM(loc_cBuf)
                                loc_nRet = -1
                                EXIT
                            ELSE
                                loc_nRet = 0
                                EXIT
                                ENDIF
                            ENDIF
                        ENDIF

                        IF loc_nRet <> 10000
                            IF !EMPTY(loc_oBO.this_cMensagem)
                                loc_oBO.RetornoFalha(loc_oBO.this_cMensagem, loc_oBO.this_nValPago)
                            ELSE
                                loc_oBO.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada", ;
                                    loc_oBO.this_nValPago)
                            ENDIF
                            EXIT
                        ENDIF

                        *-- cmd=30 + optiongroup=2 (parcelado): inversao de risco ou EXIT
                        IF loc_nCmd = 30 AND VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND ;
                           THIS.obj_4c_TipoVenda.Value = 2
                            IF loc_nTipo = 510
                                IF loc_oBO.this_cGarantias = "S"
                                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                                ELSE
                                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                                ENDIF
                                loc_nCont = 1000
                                LOOP
                            ENDIF
                            EXIT
                        ENDIF

                        *-- cmd=30 + TipoCampo=506: envia data DDMMAAAA
                        IF loc_nCmd = 30 AND loc_nTipo = 506
                            IF VARTYPE(THIS.txt_4c_Datas) = "O"
                                loc_cDataFmt = DTOC(THIS.txt_4c_Datas.Value)
                                loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
                                    ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
                                    ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
                                    REPLICATE(CHR(0), 1992)
                            ELSE
                                loc_oBO.this_cBuffer = REPLICATE(CHR(0), 2000)
                            ENDIF
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=505: envia parcelas
                        IF loc_nCmd = 30 AND loc_nTipo = 505
                            loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + ;
                                REPLICATE(CHR(0), 1998)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=20 + TipoCampo=507: primeira parcela a vista
                        IF loc_nCmd = 20 AND loc_nTipo = 507
                            IF MsgConfirma("Primeira Parcela A Vista")
                                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=508: envia dias
                        IF loc_nCmd = 30 AND loc_nTipo = 508
                            loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nDias)) + ;
                                REPLICATE(CHR(0), 1998)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=20 + TipoCampo=509: envia mes de fechamento CDC
                        IF loc_nCmd = 20 AND loc_nTipo = 509
                            loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nMesFec - 1)) + ;
                                REPLICATE(CHR(0), 1999)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- "ASSUME GARANTIA": inversao de risco (apenas na primeira ocorrencia)
                        IF UPPER(ALLTRIM(loc_cBuf)) = "ASSUME GARANTIA" AND loc_lPrimo
                            IF MsgConfirma("Assume Invers" + CHR(227) + "o de Risco ?")
                                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            loc_lPrimo = .F.
                            LOOP
                        ENDIF

                        *-- cmd=34 + TipoCampo=130: valor do saque
                        IF loc_nCmd = 34 AND loc_nTipo = 130
                            loc_oBO.this_cBuffer = "0,00" + REPLICATE(CHR(0), 1996)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30: envia data como default (sem tipo especifico)
                        IF loc_nCmd = 30
                            IF VARTYPE(THIS.txt_4c_Datas) = "O"
                                loc_cDataFmt = DTOC(THIS.txt_4c_Datas.Value)
                                loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
                                    ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
                                    ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
                                    REPLICATE(CHR(0), 1992)
                            ENDIF
                        ENDIF

                        *-- Coleta campos de retorno
                        IF loc_nCmd = 3
                            loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
                        ENDIF
                        IF loc_nTipo = 100
                            loc_oBO.this_cTipTran = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 105
                            loc_oBO.this_cDataHora = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 121
                            loc_oBO.this_cCupom = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 131
                            loc_oBO.this_cCartao = LEFT(loc_cBuf, 5)
                        ENDIF
                        IF loc_nTipo = 132
                            loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
                        ENDIF
                        IF loc_nTipo = 134
                            loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
                        ENDIF
                        IF loc_nTipo = 135
                            loc_oBO.this_cAutoriza = loc_cBuf
                        ENDIF
                        IF loc_nRet <> 0
                            loc_oBO.this_cFinaliza = loc_cBuf
                        ENDIF

                        *-- Caso geral: mensagem e reset buffer
                        IF loc_nCmd <> 21 AND loc_nCmd <> 30
                            loc_oBO.this_cMensagem = loc_cBuf
                            loc_oBO.this_cBuffer   = SPACE(2000)
                            loc_nCont = 0
                        ENDIF

                        loc_oBO.this_nCiclos = loc_oBO.this_nCiclos + 1
                        IF loc_oBO.this_nCiclos > 10000
                            EXIT
                        ENDIF
                    ENDDO

                    *-- Pos-loop
                    IF loc_nRet <> 10000
                        IF loc_nRet = 0
                            THIS.ProcessarFimTransacao()
                        ENDIF
                    ENDIF
                ENDIF

                THIS.AtualizarInstrucao("Digite a Data" + CHR(13) + "de Vencimento")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro TEF Datas GotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDatasKeyPress - Simula Valid de GetDatas via ENTER/TAB
    * Valida data e envia ao SiTef para transacao pre-datada
    * Equivale a GetDatas.Valid do legado (183 linhas)
    *==========================================================================
    PROCEDURE TxtDatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_dData, loc_oErro
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
        LOCAL loc_nRet, loc_nCont, loc_cDataFmt, loc_lPrimo

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF

        IF LASTKEY() = 27
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            *-- Determina data (default: hoje + 30 dias se campo vazio)
            loc_dData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
            THIS.txt_4c_Datas.Value = loc_dData
            THIS.txt_4c_Datas.Refresh()

            *-- Para parcelado (Value=2): data futura obrigatoria
            IF VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND ;
               THIS.obj_4c_TipoVenda.Value = 2 AND ;
               !EMPTY(THIS.txt_4c_Datas.Value) AND ;
               loc_dData <= DATE()
                MsgErro("Data Inv" + CHR(225) + "lida", ;
                    "Erro na Transa" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oBO.this_dData = loc_dData

                *-- Pre-loop: aguarda SiTef chegar ao cmd=30 (safety, normalmente ja esta la)
                loc_nCont = 0
                DO WHILE loc_oBO.this_nProximoComando <> 30
                    loc_nCmd  = loc_oBO.this_nProximoComando
                    loc_nTipo = loc_oBO.this_nTipoCampo
                    loc_nMin  = loc_oBO.this_nTamanhoMinimo
                    loc_nMax  = loc_oBO.this_nTamanhoMaximo
                    loc_cBuf  = SPACE(2000)

                    loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                        @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                        @loc_cBuf, LEN(loc_cBuf), loc_nCont)

                    loc_oBO.this_nProximoComando = loc_nCmd
                    loc_oBO.this_nTipoCampo      = loc_nTipo
                    loc_oBO.this_nTamanhoMinimo  = loc_nMin
                    loc_oBO.this_nTamanhoMaximo  = loc_nMax
                    loc_oBO.this_cBuffer         = loc_cBuf

                    IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR loc_nCmd = 23
                        THIS.AtualizarInstrucao("Digite a Senha")
                    ENDIF
                    IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                        THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
                    ENDIF
                    IF loc_nRet < 0
                        THIS.ErroTef(loc_nRet)
                        EXIT
                    ENDIF
                ENDDO

                IF !THIS.this_lAbandona
                    *-- Envia data no formato DDMMAAAA (nao DTOC)
                    loc_cDataFmt = DTOC(loc_dData)
                    loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
                        ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
                        ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
                        REPLICATE(CHR(0), 1992)
                    loc_oBO.this_nCiclos = 0
                    loc_oBO.this_cAutoriza = ""
                    loc_nRet  = 10000
                    loc_nCont = 1000
                    loc_lPrimo = .T.

                    DO WHILE loc_nRet = 10000
                        loc_nCmd  = loc_oBO.this_nProximoComando
                        loc_nTipo = loc_oBO.this_nTipoCampo
                        loc_nMin  = loc_oBO.this_nTamanhoMinimo
                        loc_nMax  = loc_oBO.this_nTamanhoMaximo
                        loc_cBuf  = loc_oBO.this_cBuffer

                        loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                            @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                            @loc_cBuf, LEN(loc_cBuf), loc_nCont)

                        loc_oBO.this_nProximoComando = loc_nCmd
                        loc_oBO.this_nTipoCampo      = loc_nTipo
                        loc_oBO.this_nTamanhoMinimo  = loc_nMin
                        loc_oBO.this_nTamanhoMaximo  = loc_nMax
                        loc_oBO.this_cBuffer         = loc_cBuf

                        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                            THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
                        ENDIF

                        IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR loc_nCmd = 23
                            THIS.AtualizarInstrucao("Digite a Senha")
                        ENDIF

                        IF loc_nRet < 0
                            THIS.ErroTef(loc_nRet)
                            THIS.Release()
                            EXIT
                        ENDIF

                        *-- cmd=22: mensagem de erro
                        IF loc_nCmd = 22
                            IF loc_oBO.this_cDebCred <> "P"
                                IF !EMPTY(ALLTRIM(loc_cBuf))
                                    MsgErro(IIF(UPPER(ALLTRIM(loc_cBuf)) = "AGUARDE, EM PROCESSAMENTO", ;
                                        "TRANSACAO CANCELADA", ALLTRIM(loc_cBuf)), ;
                                        "Erro na Transa" + CHR(231) + CHR(227) + "o")
                                    IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR ;
                                       "CANC. CLIENTE"$UPPER(ALLTRIM(loc_cBuf))
                                        loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                                            @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                                            @loc_cBuf, LEN(loc_cBuf), -1)
                                        loc_nRet = -8
                                        EXIT
                                    ENDIF
                                    EXIT
                                ELSE
                                    loc_nRet = 0
                                    EXIT
                                ENDIF
                            ELSE
                                loc_oBO.this_cCupom = ALLTRIM(loc_cBuf)
                                loc_nRet = -1
                                EXIT
                            ENDIF
                        ENDIF

                        IF loc_nRet <> 10000
                            IF !EMPTY(loc_oBO.this_cMensagem)
                                loc_oBO.RetornoFalha(loc_oBO.this_cMensagem, loc_oBO.this_nValPago)
                            ELSE
                                loc_oBO.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada", ;
                                    loc_oBO.this_nValPago)
                            ENDIF
                            EXIT
                        ENDIF

                        *-- "ASSUME GARANTIA": inversao de risco (primeira ocorrencia)
                        IF UPPER(ALLTRIM(loc_cBuf)) = "ASSUME GARANTIA" AND loc_lPrimo
                            IF MsgConfirma("Assume Invers" + CHR(227) + "o de Risco ?")
                                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            loc_lPrimo = .F.
                            LOOP
                        ENDIF

                        *-- cmd=34 + TipoCampo=130: valor do saque
                        IF loc_nCmd = 34 AND loc_nTipo = 130
                            loc_oBO.this_cBuffer = "0,00" + REPLICATE(CHR(0), 1996)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=510: inversao de risco
                        IF loc_nCmd = 30 AND loc_nTipo = 510
                            IF loc_oBO.this_cGarantias = "S"
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=506: envia data DDMMAAAA
                        IF loc_nCmd = 30 AND loc_nTipo = 506
                            loc_cDataFmt = DTOC(loc_dData)
                            loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
                                ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
                                ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
                                REPLICATE(CHR(0), 1992)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=505: envia parcelas
                        IF loc_nCmd = 30 AND loc_nTipo = 505
                            loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + ;
                                REPLICATE(CHR(0), 1998)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=20 + TipoCampo=507: primeira parcela a vista
                        IF loc_nCmd = 20 AND loc_nTipo = 507
                            IF MsgConfirma("Primeira Parcela A Vista")
                                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                            ENDIF
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30 + TipoCampo=508: envia dias
                        IF loc_nCmd = 30 AND loc_nTipo = 508
                            loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nDias)) + ;
                                REPLICATE(CHR(0), 1998)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=20 + TipoCampo=509: envia mes de fechamento CDC
                        IF loc_nCmd = 20 AND loc_nTipo = 509
                            loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nMesFec - 1)) + ;
                                REPLICATE(CHR(0), 1999)
                            loc_nCont = 1000
                            LOOP
                        ENDIF

                        *-- cmd=30: envia data como default
                        IF loc_nCmd = 30
                            loc_cDataFmt = DTOC(loc_dData)
                            loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
                                ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
                                ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
                                REPLICATE(CHR(0), 1992)
                        ENDIF

                        *-- Coleta campos de retorno
                        IF loc_nCmd = 3
                            loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
                        ENDIF
                        IF loc_nTipo = 100
                            loc_oBO.this_cTipTran = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 105
                            loc_oBO.this_cDataHora = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 121
                            loc_oBO.this_cCupom = loc_cBuf
                        ENDIF
                        IF loc_nTipo = 131
                            loc_oBO.this_cCartao = LEFT(loc_cBuf, 5)
                        ENDIF
                        IF loc_nTipo = 132
                            loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
                        ENDIF
                        IF loc_nTipo = 134
                            loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
                        ENDIF
                        IF loc_nTipo = 135
                            loc_oBO.this_cAutoriza = loc_cBuf
                        ENDIF
                        IF loc_nRet <> 0
                            loc_oBO.this_cFinaliza = loc_cBuf
                        ENDIF

                        *-- Caso geral: mensagem e reset buffer
                        IF loc_nCmd <> 21 AND loc_nCmd <> 30
                            loc_oBO.this_cMensagem = loc_cBuf
                            loc_oBO.this_cBuffer   = SPACE(2000)
                            loc_nCont = 0
                        ENDIF

                        loc_oBO.this_nCiclos = loc_oBO.this_nCiclos + 1
                        IF loc_oBO.this_nCiclos > 10000
                            EXIT
                        ENDIF
                    ENDDO

                    *-- Pos-loop: processa resultado
                    IF loc_nRet <> 10000
                        IF loc_oBO.this_cDebCred = "P"
                            loc_oBO.RetornoFalha("Consulta CDC Realizada", loc_oBO.this_nValPago)
                            THIS.Release()
                        ELSE
                            IF loc_nRet = 0
                                THIS.ProcessarFimTransacao()
                            ELSE
                                IF loc_nRet >= -5
                                    THIS.ErroTef(loc_nRet)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    THIS.Release()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro TEF Datas KeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OgTipoVendaInteractiveChange - InteractiveChange do OptionGroup tipo de venda
    * Habilita txt_4c_Datas e define data inicial conforme selecao
    * Equivale a Optiongroup1.InteractiveChange do legado
    *==========================================================================
    PROCEDURE OgTipoVendaInteractiveChange()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.txt_4c_Datas) = "O"
                THIS.txt_4c_Datas.Enabled = .T.
            ENDIF
            IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
                IF THIS.obj_4c_TipoVenda.Value = 1
                    IF VARTYPE(THIS.txt_4c_Datas) = "O"
                        THIS.txt_4c_Datas.Value = DATE()
                    ENDIF
                ELSE
                    IF VARTYPE(THIS.txt_4c_Datas) = "O"
                        THIS.txt_4c_Datas.Value = CTOD("")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TEF TipoVenda InteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OgTipoVendaKeyPress - KeyPress do OptionGroup (avanca com ENTER)
    * Equivale a Optiongroup1.KeyPress do legado
    *==========================================================================
    PROCEDURE OgTipoVendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            KEYBOARD "{TAB}"
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdCancelaClick - Click do botao CANCELA (cnt_4c_Saida.Buttons(1))
    * Cancela transacao SiTef em andamento e fecha o form
    * Equivale a SAIDA.CANCELA.Click do legado
    *==========================================================================
    PROCEDURE CmdCancelaClick()
        LOCAL loc_oBO, loc_oErro
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf, loc_nRet
        loc_oBO = THIS.this_oBusinessObject

        TRY
            loc_nCmd  = loc_oBO.this_nProximoComando
            loc_nTipo = loc_oBO.this_nTipoCampo
            loc_nMin  = loc_oBO.this_nTamanhoMinimo
            loc_nMax  = loc_oBO.this_nTamanhoMaximo
            loc_cBuf  = SPACE(2000)

            *-- Envia -1 para cancelar transacao em andamento
            loc_nRet = ContinuaFuncaoSiTefInterativo( ;
                @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
                @loc_cBuf, LEN(loc_cBuf), -1)

            loc_oBO.this_nProximoComando = loc_nCmd
            loc_oBO.this_cBuffer         = loc_cBuf

            loc_oBO.RetornoFalha( ;
                "Oper. Cancelada pelo Usu" + CHR(225) + "rio(1)", ;
                loc_oBO.this_nValPago)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao cancelar TEF")
        ENDTRY

        THIS.Release()
    ENDPROC

    *==========================================================================
    * ErroTef - Trata erro SiTef: delega ao BO e sinaliza abandono
    * Equivale a PROCEDURE errotef do legado
    * NAO chama Release() - chamador decide se fecha o form
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.ErroTef(par_nRetorno)
            ENDIF
            THIS.this_lAbandona = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ErroTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Nao aplicavel a este form
    * SIGPRDFT e um dialog modal de transacao TEF/SiTef (form OPERACIONAL plano).
    * Nao possui estrutura CRUD (sem grid, sem Page1/Page2, sem registros).
    * Toda interacao ocorre via protocolo SiTef (TxtDigitosGotFocus/KeyPress,
    * TxtDatasGotFocus/KeyPress, CmdCancelaClick).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Nao aplicavel a este form
    * Ver BtnIncluirClick para explicacao.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Nao aplicavel a este form
    * Ver BtnIncluirClick para explicacao.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Nao aplicavel a este form
    * Ver BtnIncluirClick para explicacao.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Nao aplicavel a este form
    * Ver BtnIncluirClick para explicacao.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Cancela a transacao TEF e fecha o form
    * Form TEF usa botao Cancelar (cnt_4c_Saida) como mecanismo de saida.
    * BtnEncerrarClick delega ao mesmo comportamento de cancelamento.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdCancelaClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Nao aplicavel a este form
    * Ver BtnIncluirClick para explicacao.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela a transacao TEF e fecha o form
    * Equivalente a BtnEncerrarClick para compatibilidade com o pipeline.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdCancelaClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Nao aplicavel a este form
    * Form TEF nao tem campos de cadastro para transferir ao BO.
    * Os parametros da transacao sao passados via CREATEOBJECT (Init).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    *==========================================================================
    * BOParaForm - Nao aplicavel a este form
    * Form TEF nao tem campos de cadastro para carregar do BO.
    * O estado da transacao e gerenciado diretamente pelo protocolo SiTef.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Nao aplicavel a este form
    * Habilitacao dos campos e controlada pelo protocolo SiTef (GotFocus/Valid).
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *==========================================================================
    * CarregarLista - Nao aplicavel a este form
    * Form TEF nao tem grid de lista de registros.
    * Retorna .T. para compatibilidade com FormBase.
    *==========================================================================
    PROTECTED FUNCTION CarregarLista() AS Boolean
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * AjustarBotoesPorModo - Nao aplicavel a este form
    * Form TEF nao tem botoes CRUD que precisam ser ajustados por modo.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* sigprdftBO.prg - Business Object para TEF SiTef Cartao de Debito
* Herda de BusinessBase
* Formulario original: SIGPRDFT.SCX
*==============================================================================

DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Parametros de entrada (recebidos do chamador)
    this_cEndSiTef       = ""   && Endereco do servidor SiTef
    this_nValPago        = 0    && Valor a pagar
    this_cCupom          = ""   && Numero do cupom
    this_cCaixa          = ""   && Identificador do caixa
    this_cDebCred        = ""   && Debito/Credito/Pre-datado (D/C/P)
    this_cTipPagto       = ""   && Tipo de pagamento
    this_nNumParcs       = 0    && Numero de parcelas
    this_nIdent          = 0    && Identificador da transacao (ltIdent)
    this_cOpers          = ""   && Codigo da operacao/forma de pagamento (FPags)

    *-- Estado da transacao SiTef (variaveis PUBLIC no legado)
    this_cIdTerminal     = ""   && ID do terminal SiTef (lsIdTerminal)
    this_lDCD            = .F.  && Flag data credito/debito (DCD)
    this_dData           = {}   && Data da transacao (ldData)
    this_nProximoComando = 0    && Proximo comando SiTef (ProximoComando)
    this_nTipoCampo      = 0    && Tipo de campo SiTef (TipoCampo)
    this_nTamanhoMinimo  = 0    && Tamanho minimo do campo (TamanhoMinimo)
    this_nTamanhoMaximo  = 0    && Tamanho maximo do campo (TamanhoMaximo)
    this_cBuffer         = ""   && Buffer de comunicacao SiTef 2000 chars (Buffer)
    this_nContinua       = 0    && Flag/resultado de continuacao (lnContinua)
    this_nCiclos         = 0    && Contador de ciclos (lnCiclos)
    this_cParcs          = ""   && Parcelas formatadas "@L 99" (lnParcs string)

    *-- Resultados da transacao
    this_cBandeira       = ""   && Bandeira do cartao - codigo (pcBandeira)
    this_cCartao         = ""   && 5 primeiros digitos do cartao (lsCartao)
    this_cSaque          = ""   && Valor do saque formato "0,00" (lcSaque)
    this_cTipTran        = ""   && Tipo de transacao retornado pelo SiTef (lsTipTran)
    this_cDataHora       = ""   && Data e hora da transacao (lsDataHora)
    this_cNsu            = ""   && NSU da transacao (lsNsu)
    this_cAutoriza       = ""   && Codigo de autorizacao (lsAutoriza)
    this_cFinaliza       = ""   && Buffer de finalizacao (lsFinaliza)
    this_cMensagem       = ""   && Mensagem da transacao (lsMensagem)
    this_cMRet           = ""   && Mensagem de retorno adicional (lsMRet)

    *-- Estado do formulario (propriedades customizadas do form legado)
    this_lTvenda         = .T.  && Habilita selecao de tipo de venda (pctvenda)
    this_lKeyEsc         = .T.  && Habilita tecla ESC (pckeyesc)
    this_lAbandona       = .F.  && Flag de abandono da operacao (abandona)

    *-- Dados do registro SigOpFp (forma de pagamento)
    this_cFPags          = ""   && Codigo da forma de pagamento (FPags)
    this_cTcdc           = ""   && Tipo CDC - controla fluxo parcelado (Tcdc)
    this_cGarantias      = ""   && Habilita inversao de risco (Garantias S/N)
    this_cLSaque         = ""   && Permite operacao de saque (lSaque S/N)
    this_cLCartao        = ""   && Cartao numerico (lCartao S/N)
    this_nDias           = 0    && Dias para pre-datado (Dias)
    this_nMesFec         = 0    && Mes de fechamento CDC (MesFec)

    *-- Dados da empresa SigCdEmp
    this_nEmps           = 0    && Numero da empresa para compor terminal (nEmps)
    this_cEmpresa        = ""   && Codigo da empresa (cEmps)

    *-- Dados do caixa SigFiMpF
    this_nCncaixas       = 0    && Numero do caixa para compor ID terminal (Cncaixas)

    *==========================================================================
    * Init - Inicializa o BO de integracao SiTef
    *==========================================================================
    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de SigOpFp do cursor informado
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cFPags     = TratarNulo(FPags,      "C")
                THIS.this_cTcdc      = TratarNulo(Tcdc,       "C")
                THIS.this_cGarantias = TratarNulo(Garantias,  "C")
                THIS.this_cLSaque    = TratarNulo(lSaque,     "C")
                THIS.this_cLCartao   = TratarNulo(lCartao,    "C")
                THIS.this_nDias      = TratarNulo(Dias,       "N")
                THIS.this_nMesFec    = TratarNulo(MesFec,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarConfig - SQLEXEC para carregar SigOpFp e SigCdEmp
    *==========================================================================
    PROCEDURE CarregarConfig(par_cOpers)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            *-- Forma de pagamento
            loc_cSQL = "SELECT FPags, Tcdc, Garantias, lSaque, lCartao, Dias, MesFec " + ;
                       "FROM SigOpFp WHERE FPags = " + EscaparSQL(ALLTRIM(par_cOpers))
            IF USED("cursor_4c_SigOpFp")
                TABLEREVERT(.T., "cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigOpFp")
                THIS.CarregarDoCursor("cursor_4c_SigOpFp")
            ENDIF

            *-- Empresa
            loc_cSQL = "SELECT cEmps, nEmps FROM SigCdEmp " + ;
                       "WHERE cEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                TABLEREVERT(.T., "cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdEmp")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                THIS.this_nEmps    = TratarNulo(nEmps, "N")
                THIS.this_cEmpresa = TratarNulo(cEmps, "C")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(227) + "o SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCaixa - SQLEXEC para carregar numero do caixa (SigFiMpF)
    *==========================================================================
    PROCEDURE CarregarCaixa(par_cCaixa)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Cncaixas FROM SigFiMpF"
            IF USED("cursor_4c_SigFiMpF")
                TABLEREVERT(.T., "cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigFiMpF")
                SELECT cursor_4c_SigFiMpF
                THIS.this_nCncaixas = TratarNulo(Cncaixas, "N")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados do caixa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarRetorno - Monta cursor crSiTef e escreve arquivos de retorno de sucesso
    * Equivale ao PROCEDURE montaretorno do legado
    *==========================================================================
    PROCEDURE MontarRetorno(par_cTipTran, par_cDataHora, par_cCupom, par_cCartaoBandeira, ;
                             par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
        LOCAL loc_lSucesso, loc_cValPago, loc_cBandIdx, loc_nPos, loc_nLinha, loc_cCupom
        LOCAL ARRAY loc_aCartao[11]
        loc_lSucesso = .F.
        TRY
            loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

            loc_aCartao[1]  = "Outro, nao definido"
            loc_aCartao[2]  = "Visa"
            loc_aCartao[3]  = "Mastercard"
            loc_aCartao[4]  = "Diners"
            loc_aCartao[5]  = "American Express"
            loc_aCartao[6]  = "Sollo"
            loc_aCartao[7]  = "Sidecard (Redecard)"
            loc_aCartao[8]  = "Private Label (Redecard)"
            loc_aCartao[9]  = "Redeshop"
            loc_aCartao[10] = ""
            loc_aCartao[11] = "Fininvest"

            IF VAL(THIS.this_cBandeira) > 10 .OR. VAL(THIS.this_cBandeira) < 0
                loc_cBandIdx = "0"
            ELSE
                loc_cBandIdx = THIS.this_cBandeira
            ENDIF

            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cBandIdx) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_cTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_cNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_cAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
                SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + ;
                SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + ;
                ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
                SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + ;
                SUBSTR(par_cDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_cFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))

            loc_cCupom = par_cCupom
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos <> 0
                loc_nPos = AT(CHR(10), loc_cCupom)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + ;
                    " = " + IIF(loc_nPos <> 0, SUBSTR(loc_cCupom, 1, loc_nPos - 1), loc_cCupom))
                loc_cCupom = SUBSTR(loc_cCupom, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            SET SAFETY OFF
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            SET SAFETY ON

            USE IN crSiTef

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET SAFETY ON
            MsgErro(loc_oErro.Message, "Erro ao montar retorno SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RetornoFalha - Monta cursor crSiTef e escreve arquivos de retorno de falha
    * Equivale ao PROCEDURE retornofalha do legado
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_lSucesso, loc_cValPago, loc_cMensagem
        loc_lSucesso = .F.
        TRY
            loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
                "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", par_cMensagem)
            loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
                IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            SET SAFETY OFF
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            SET SAFETY ON

            USE IN crSiTef

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET SAFETY ON
            MsgErro(loc_oErro.Message, "Erro ao montar retorno de falha SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo SiTef (-1 a -5)
    * Equivale ao PROCEDURE errotef do legado
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_nRetorno) = "N" AND ;
               (par_nRetorno > -1 OR par_nRetorno < -5)
                THIS.RetornoFalha("Operacao Cancelada pelo Usuario", 0)
            ELSE
                DO CASE
                    CASE par_nRetorno = -1
                        THIS.RetornoFalha("Modulo Nao Iniciado", 0)
                    CASE par_nRetorno = -2
                        THIS.RetornoFalha("Operacao Cancelada pelo Usuario", 0)
                    CASE par_nRetorno = -3
                        THIS.RetornoFalha("Fornecida uma Modalidade Invalida", 0)
                    CASE par_nRetorno = -4
                        THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", 0)
                    CASE par_nRetorno = -5
                        THIS.RetornoFalha("Sem Comunicacao com o SiTef", 0)
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao tratar erro SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ObterResultadoFinal - Retorna string de resultado da transacao
    * Equivale ao PROCEDURE Unload do legado
    * Formato: "lcSaque/lnParcs/DTOC(ldData)+pcBandeira+lsCartao"
    *==========================================================================
    FUNCTION ObterResultadoFinal()
        LOCAL loc_cBandeira, loc_cCartao, loc_cResultado
        loc_cResultado = ""
        TRY
            loc_cBandeira = IIF(VARTYPE(THIS.this_cBandeira) <> "C" .OR. EMPTY(THIS.this_cBandeira), ;
                "00000", THIS.this_cBandeira)
            loc_cCartao   = IIF(VARTYPE(THIS.this_cCartao) <> "C" .OR. EMPTY(THIS.this_cCartao), ;
                "00000", THIS.this_cCartao)
            loc_cResultado = THIS.this_cSaque + "/" + ;
                             ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")) + "/" + ;
                             DTOC(THIS.this_dData) + ;
                             loc_cBandeira + ;
                             loc_cCartao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao obter resultado final SiTef")
            loc_cResultado = "0,00/00/" + DTOC(DATE()) + "00000" + "00000"
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * Inserir - Nao aplicavel para form TEF (sem tabela SQL Server)
    *==========================================================================
    FUNCTION Inserir()
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Atualizar - Nao aplicavel para form TEF (sem tabela SQL Server)
    *==========================================================================
    FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave da forma de pagamento
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cFPags
    ENDFUNC

ENDDEFINE


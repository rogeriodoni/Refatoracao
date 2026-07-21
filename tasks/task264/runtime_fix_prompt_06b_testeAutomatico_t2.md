# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[15/07/2026 02:37:26 AM] Erro: Erro ao inicializar Cálculo de Juros: BUTTONS is not an object. LN=701 PROC=configurarpaginalista


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-15 02:35:59] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 02:35:59] [INFO] Config FPW: (nao fornecido)
[2026-07-15 02:35:59] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 02:35:59] [INFO] Timeout: 300 segundos
[2026-07-15 02:35:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ng00ohhd.prg
[2026-07-15 02:35:59] [INFO] Conteudo do wrapper:
[2026-07-15 02:35:59] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'
QUIT

[2026-07-15 02:35:59] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ng00ohhd.prg
[2026-07-15 02:35:59] [INFO] VFP output esperado em: C:\4c\tasks\task264\vfp_output.txt
[2026-07-15 02:35:59] [INFO] Executando Visual FoxPro 9...
[2026-07-15 02:35:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ng00ohhd.prg
[2026-07-15 02:35:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ng00ohhd.prg
[2026-07-15 02:35:59] [INFO] Timeout configurado: 300 segundos
[2026-07-15 02:36:19] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 02:36:19] [INFO] VFP9 finalizado em 19.3961391 segundos
[2026-07-15 02:36:19] [INFO] Exit Code: 
[2026-07-15 02:36:19] [INFO] 
[2026-07-15 02:36:19] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 02:36:19] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ng00ohhd.prg
[2026-07-15 02:36:19] [INFO] 
[2026-07-15 02:36:19] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 02:36:19] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 02:36:19] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 02:36:19] [INFO] * Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'
[2026-07-15 02:36:19] [INFO] 
[2026-07-15 02:36:19] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 02:36:19] [INFO] SET SAFETY OFF
[2026-07-15 02:36:19] [INFO] SET RESOURCE OFF
[2026-07-15 02:36:19] [INFO] SET TALK OFF
[2026-07-15 02:36:19] [INFO] SET NOTIFY OFF
[2026-07-15 02:36:19] [INFO] SYS(2335, 0)
[2026-07-15 02:36:19] [INFO] 
[2026-07-15 02:36:19] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'
[2026-07-15 02:36:19] [INFO] QUIT
[2026-07-15 02:36:19] [INFO] 
[2026-07-15 02:36:19] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 02:36:19] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 02:37:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 02:37:03] [INFO] Config FPW: (nao fornecido)
[2026-07-15 02:37:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 02:37:03] [INFO] Timeout: 300 segundos
[2026-07-15 02:37:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mfit3qes.prg
[2026-07-15 02:37:03] [INFO] Conteudo do wrapper:
[2026-07-15 02:37:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'
QUIT

[2026-07-15 02:37:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mfit3qes.prg
[2026-07-15 02:37:03] [INFO] VFP output esperado em: C:\4c\tasks\task264\vfp_output.txt
[2026-07-15 02:37:03] [INFO] Executando Visual FoxPro 9...
[2026-07-15 02:37:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mfit3qes.prg
[2026-07-15 02:37:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mfit3qes.prg
[2026-07-15 02:37:03] [INFO] Timeout configurado: 300 segundos
[2026-07-15 02:37:26] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 02:37:26] [INFO] VFP9 finalizado em 22.6762207 segundos
[2026-07-15 02:37:26] [INFO] Exit Code: 
[2026-07-15 02:37:26] [INFO] 
[2026-07-15 02:37:26] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 02:37:26] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mfit3qes.prg
[2026-07-15 02:37:26] [INFO] 
[2026-07-15 02:37:26] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 02:37:26] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 02:37:26] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 02:37:26] [INFO] * Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'
[2026-07-15 02:37:26] [INFO] 
[2026-07-15 02:37:26] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 02:37:26] [INFO] SET SAFETY OFF
[2026-07-15 02:37:26] [INFO] SET RESOURCE OFF
[2026-07-15 02:37:26] [INFO] SET TALK OFF
[2026-07-15 02:37:26] [INFO] SET NOTIFY OFF
[2026-07-15 02:37:26] [INFO] SYS(2335, 0)
[2026-07-15 02:37:26] [INFO] 
[2026-07-15 02:37:26] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCfn', 'C:\4c\tasks\task264', 'OPERACIONAL'
[2026-07-15 02:37:26] [INFO] QUIT
[2026-07-15 02:37:26] [INFO] 
[2026-07-15 02:37:26] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 02:37:26] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrCfn",
  "timestamp": "20260715023726",
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
*******************************************************************************
* FormSigPrCfn.prg - Form Operacional: Calculo de Juros
* Herda de FormBase
* Form OPERACIONAL - dialogo calculador de juros (sem tabela BD)
* Migrado de: SigPrCfn.SCX
* Fase 7/8: Form completo - OPERACIONAL calculadora sem CRUD; todos os eventos
*            de calculo, validacao e vencimentos implementados nas fases anteriores.
*******************************************************************************

DEFINE CLASS FormSigPrCfn AS FormBase

    *-- Dimensoes do form (preserva UX original 600x300)
    Width       = 600
    Height      = 300
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    BorderStyle = 2
    DataSession = 2
    KeyPreview  = .T.
    BackColor   = RGB(212, 208, 200)
    Caption     = ""

    *-- BO
    this_oBusinessObject = .NULL.

    *-- Estado / modo corrente
    this_cModoAtual  = "CALCULO"
    this_lSelecionou = .F.

    *-- Parametros recebidos pelo Init (equivalente ao LPARAMETERS do legado)
    this_nParVal = 0
    this_nParTip = 1
    this_nParJMe = 0
    this_nParJDi = 0
    this_dParDtB = {}
    this_dParDtF = {}

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        LPARAMETERS par_nVal, par_nTip, par_nJMe, par_nJDi, par_dDtB, par_dDtF

        THIS.Caption = "C" + CHR(225) + "lculo de Juros"

        IF VARTYPE(par_nVal) = "N" AND par_nVal > 0
            THIS.this_nParVal = par_nVal
        ENDIF
        IF VARTYPE(par_nTip) = "N" AND INLIST(par_nTip, 1, 2)
            THIS.this_nParTip = par_nTip
        ENDIF
        IF VARTYPE(par_nJMe) = "N" AND par_nJMe > 0
            THIS.this_nParJMe = par_nJMe
        ENDIF
        IF VARTYPE(par_nJDi) = "N" AND par_nJDi > 0
            THIS.this_nParJDi = par_nJDi
        ENDIF
        IF VARTYPE(par_dDtB) = "D"
            THIS.this_dParDtB = par_dDtB
        ENDIF
        IF VARTYPE(par_dDtF) = "D"
            THIS.this_dParDtF = par_dDtF
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    * InicializarForm - Cria BO, PageFrame e containers principais.
    * Chamada por FormBase.Init() atraves de DODEFAULT().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCfnBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.InicializarComParametros( ;
                    THIS.this_nParVal, ;
                    THIS.this_nParTip, ;
                    THIS.this_nParJMe, ;
                    THIS.this_nParJDi, ;
                    THIS.this_dParDtB, ;
                    THIS.this_dParDtF)

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaVencimentos()
                THIS.ConfigurarPaginaDados()
                THIS.PopularCamposIniciais()
                THIS.TornarControlesVisiveis(THIS)

                THIS.pgf_4c_Paginas.Visible     = .T.
                THIS.pgf_4c_Paginas.ActivePage  = 1
                THIS.this_cModoAtual            = "CALCULO"

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar C" + CHR(225) + "lculo de Juros: " + ;
                    loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza superior com titulo (padrao cntSombra).
    * Equivale ao cntSombra do form legado (Top=0, Height=80, BackColor cinza).
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_nW
        loc_nW = THIS.Width

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "C" + CHR(225) + "lculo de Juros"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "C" + CHR(225) + "lculo de Juros"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas.
    * Page1 = "C" + CHR(225) + "lculo" (inputs + resultados - Fases 4-5)
    * Page2 = "Vencimentos" (10 datas + valor parcela - Fases 6-7)
    * Tabs ocultas: form original nao tem abas visuais; navegacao interna
    * eh feita programaticamente pelas fases futuras se necessario.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount   = 2
            .Top         = 80
            .Left        = 0
            .Width       = 600
            .Height      = 220
            .Tabs        = .F.
            .BorderWidth = 0
            .Visible     = .T.

            .Page1.Caption = "C" + CHR(225) + "lculo"
            .Page2.Caption = "Vencimentos"
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarBotoes - Container do botao Sair (equivalente ao btnOK legado).
    * Posicao original: Top=3, Left=525, Width=75, Height=75 (icone-only).
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 3
            .Left        =  542
            .Width       = 78
            .Height      = 77
            .BorderWidth = 0
            .BackStyle   = 0
            .Visible     = .T.

            .AddObject("cmd_4c_BtnOK", "CommandButton")
            WITH .cmd_4c_BtnOK
                .Top             = 1
                .Left            =  542
                .Height          = 75
                .Width           = 75
                .Caption         = "Sair"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_BtnOK, "Click", THIS, "BtnSairClick")
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnSairClick - Fecha o form (botao Sair - Cancel=.T., dispara com ESC).
    *---------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnIncluirClick - Novo Calculo: reseta a calculadora ao estado inicial.
    * Equivale ao fluxo de "novo registro" adaptado para forms OPERACIONAIS de
    * calculo (nao ha persistencia em BD). Limpa inputs, resultados e vencimentos.
    * Campos ficam bloqueados ate que ValorBase > 0 seja informado.
    *---------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPag, loc_x, loc_oVenc, loc_oErr

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_ValorBase.Value  = 0
        loc_oPag.txt_4c_JurosMes.Value   = 0
        loc_oPag.txt_4c_JurosDia.Value   = 0
        loc_oPag.txt_4c_DataBase.Value   = {}
        loc_oPag.txt_4c_DataFinal.Value  = {}
        loc_oPag.txt_4c_Dias.Value       = 0
        loc_oPag.txt_4c_ValorJuros.Value = 0
        loc_oPag.txt_4c_ValorTotal.Value = 0
        loc_oPag.txt_4c_Valorpar.Value   = 0

        loc_oPag.obj_4c_OptCalculo.Value = 1
        loc_oPag.obj_4c_OptDias.Value    = 1

        FOR loc_x = 1 TO 10
            TRY
                loc_oVenc = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Value   = {}
                    loc_oVenc.Enabled = .F.
                ENDIF
            CATCH TO loc_oErr
                IF !("does not exist" $ LOWER(loc_oErr.Message)) AND ;
                   !("not found" $ LOWER(loc_oErr.Message)) AND ;
                   !("unknown member" $ LOWER(loc_oErr.Message))
                    MsgErro("Erro ao limpar venc" + ALLTRIM(STR(loc_x)) + ": " + ;
                            loc_oErr.Message, "BtnIncluirClick")
                ENDIF
            ENDTRY
        NEXT

        loc_oPag.obj_4c_OptCalculo.Enabled = .F.
        loc_oPag.obj_4c_OptDias.Enabled    = .F.
        loc_oPag.txt_4c_JurosMes.Enabled   = .F.
        loc_oPag.txt_4c_JurosDia.Enabled   = .F.
        loc_oPag.txt_4c_DataBase.Enabled   = .F.
        loc_oPag.txt_4c_DataFinal.Enabled  = .F.
        loc_oPag.txt_4c_Dias.Enabled       = .F.

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "CALCULO"

        loc_oPag.txt_4c_ValorBase.SetFocus()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnAlterarClick - Recalcular: habilita campos e executa o motor de calculo
    * com base nos valores atualmente exibidos. Sincroniza estado do BO ao form
    * e retorna o resultado atualizado (Juros, Total e Parcela).
    *---------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPag, loc_lEnable, loc_oBO, loc_x, loc_oVenc, loc_oErr

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_oBO     = THIS.this_oBusinessObject
        loc_lEnable = (loc_oPag.txt_4c_ValorBase.Value > 0)

        loc_oBO.this_nValorBase   = loc_oPag.txt_4c_ValorBase.Value
        loc_oBO.this_nTipoCalculo = loc_oPag.obj_4c_OptCalculo.Value
        loc_oBO.this_nJurosMes    = loc_oPag.txt_4c_JurosMes.Value
        loc_oBO.this_nJurosDia    = loc_oPag.txt_4c_JurosDia.Value
        loc_oBO.this_dDataBase    = loc_oPag.txt_4c_DataBase.Value
        loc_oBO.this_dDataFinal   = loc_oPag.txt_4c_DataFinal.Value
        loc_oBO.this_nDias        = loc_oPag.txt_4c_Dias.Value
        loc_oBO.this_nTipoDias    = loc_oPag.obj_4c_OptDias.Value

        loc_oPag.obj_4c_OptCalculo.Enabled = loc_lEnable
        loc_oPag.obj_4c_OptDias.Enabled    = loc_lEnable
        loc_oPag.txt_4c_JurosMes.Enabled   = loc_lEnable
        loc_oPag.txt_4c_JurosDia.Enabled   = loc_lEnable
        loc_oPag.txt_4c_DataBase.Enabled   = loc_lEnable
        loc_oPag.txt_4c_DataFinal.Enabled  = loc_lEnable
        loc_oPag.txt_4c_Dias.Enabled       = loc_lEnable

        FOR loc_x = 1 TO 10
            TRY
                loc_oVenc = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Enabled = loc_lEnable
                ENDIF
            CATCH TO loc_oErr
                IF !("does not exist" $ LOWER(loc_oErr.Message)) AND ;
                   !("not found" $ LOWER(loc_oErr.Message)) AND ;
                   !("unknown member" $ LOWER(loc_oErr.Message))
                    MsgErro("Erro ao habilitar venc" + ALLTRIM(STR(loc_x)) + ": " + ;
                            loc_oErr.Message, "BtnAlterarClick")
                ENDIF
            ENDTRY
        NEXT

        THIS.this_cModoAtual = "CALCULO"
        THIS.Calculos()

        loc_oPag.txt_4c_ValorBase.SetFocus()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar Resultado: recalcula (garante numeros em
    * dia) e exibe resumo dos totais em MsgInfo. Substitui a ausencia de tela de
    * detalhe em forms OPERACIONAIS de calculadora.
    *---------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPag, loc_cMsg

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        THIS.Calculos()

        IF EMPTY(loc_oPag.txt_4c_ValorBase.Value)
            MsgAviso("Informe o Valor Base para visualizar o resultado.", ;
                     "Visualizar Resultado")
            loc_oPag.txt_4c_ValorBase.SetFocus()
            RETURN
        ENDIF

        loc_cMsg = "Valor Base : " + ;
                   TRANSFORM(loc_oPag.txt_4c_ValorBase.Value, "@R 999,999,999.99") + CHR(13) + ;
                   "Juros/M" + CHR(234) + "s : " + ;
                   TRANSFORM(loc_oPag.txt_4c_JurosMes.Value, "@R 9999.99") + " %" + CHR(13) + ;
                   "Juros/Dia : " + ;
                   TRANSFORM(loc_oPag.txt_4c_JurosDia.Value, "@R 9999.999999999") + " %" + CHR(13) + ;
                   "Dias : " + TRANSFORM(loc_oPag.txt_4c_Dias.Value, "@R 9999") + CHR(13) + ;
                   REPLICATE("-", 40) + CHR(13) + ;
                   "Juros : " + ;
                   TRANSFORM(loc_oPag.txt_4c_ValorJuros.Value, "@R 999,999,999.99") + CHR(13) + ;
                   "Total : " + ;
                   TRANSFORM(loc_oPag.txt_4c_ValorTotal.Value, "@R 999,999,999.99") + CHR(13) + ;
                   "Parcela : " + ;
                   TRANSFORM(loc_oPag.txt_4c_Valorpar.Value, "@R 999,999,999.99")

        MsgInfo(loc_cMsg, "Resultado do C" + CHR(225) + "lculo")
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnExcluirClick - Limpar Vencimentos: limpa os 10 campos de vencimento
    * e recalcula preservando os inputs principais (ValorBase, Juros, Datas).
    * Exige confirmacao do usuario antes de descartar as parcelas.
    *---------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPag, loc_x, loc_oVenc, loc_lTem, loc_oErr

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_lTem = .F.

        FOR loc_x = 1 TO 10
            TRY
                loc_oVenc = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oVenc) = "O" AND !EMPTY(loc_oVenc.Value)
                    loc_lTem = .T.
                    EXIT
                ENDIF
            CATCH TO loc_oErr
                IF !("does not exist" $ LOWER(loc_oErr.Message)) AND ;
                   !("not found" $ LOWER(loc_oErr.Message)) AND ;
                   !("unknown member" $ LOWER(loc_oErr.Message))
                    MsgErro("Erro ao verificar venc" + ALLTRIM(STR(loc_x)) + ": " + ;
                            loc_oErr.Message, "BtnExcluirClick")
                ENDIF
            ENDTRY
        NEXT

        IF !loc_lTem
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " vencimentos para limpar.", ;
                     "Limpar Vencimentos")
            RETURN
        ENDIF

        IF !MsgConfirma("Deseja realmente limpar todos os vencimentos?", ;
                        "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        FOR loc_x = 1 TO 10
            TRY
                loc_oVenc = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Value = {}
                ENDIF
            CATCH TO loc_oErr
                IF !("does not exist" $ LOWER(loc_oErr.Message)) AND ;
                   !("not found" $ LOWER(loc_oErr.Message)) AND ;
                   !("unknown member" $ LOWER(loc_oErr.Message))
                    MsgErro("Erro ao limpar venc" + ALLTRIM(STR(loc_x)) + ": " + ;
                            loc_oErr.Message, "BtnExcluirClick")
                ENDIF
            ENDTRY
        NEXT

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis apos AddObject
    * (que os cria com Visible=.F. por default). Recursivo para containers e
    * PageFrames.
    *---------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_nP

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
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria controles de calculo na Page1.
    * Inputs: ValorBase, JurosMes, JurosDia, DataBase, DataFinal, Dias.
    * OptionGroups: optCalculo (Simples/Composto) e optDias (Corridos/Uteis).
    * Resultados: ValorJuros, ValorTotal, Valorpar (fundo amarelo, read-only).
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Linha 1: Valor Base (esq) | Data Base (dir)
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Caption   = "Valor Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 36
            .Top       = 11
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_ValorBase", "TextBox")
        WITH loc_oPag.txt_4c_ValorBase
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "99,999,999.99"
            .Left          = 97
            .Top           = 7
            .Width         = 115
            .Height        = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Caption   = "Data Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 295
            .Top       = 11
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DataBase", "TextBox")
        WITH loc_oPag.txt_4c_DataBase
            .Value         = {}
            .Left          = 355
            .Top           = 7
            .Width         = 80
            .Height        = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Enabled       = .F.
        ENDWITH

        *-- Linha 2: Juros/Mes % (esq) | Data Final / Dias (dir)
        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Caption   = "Juros/M" + CHR(234) + "s :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 37
            .Top       = 39
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_JurosMes", "TextBox")
        WITH loc_oPag.txt_4c_JurosMes
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "9999.99"
            .Left          = 97
            .Top           = 35
            .Width         = 59
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Enabled       = .F.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 159
            .Top       = 39
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .Caption   = "Data Final / Dias :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 266
            .Top       = 39
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DataFinal", "TextBox")
        WITH loc_oPag.txt_4c_DataFinal
            .Value         = {}
            .Left          = 355
            .Top           = 35
            .Width         = 80
            .Height        = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Enabled       = .F.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag.lbl_4c_Label8
            .Caption   = "/"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 441
            .Top       = 36
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dias", "TextBox")
        WITH loc_oPag.txt_4c_Dias
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "9999"
            .Left          = 453
            .Top           = 35
            .Width         = 38
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Enabled       = .F.
        ENDWITH

        *-- Linha 3: Juros por Dia (esq) | Calculo Simples/Composto (dir)
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Caption   = "Juros por Dia :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 23
            .Top       = 68
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_JurosDia", "TextBox")
        WITH loc_oPag.txt_4c_JurosDia
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "9999.999999999"
            .Left          = 97
            .Top           = 64
            .Width         = 136
            .Height        = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Enabled       = .F.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Caption   = "C" + CHR(225) + "lculo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 310
            .Top       = 63
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_OptCalculo", "OptionGroup")
        WITH loc_oPag.obj_4c_OptCalculo
            .Left        = 351
            .Top         = 60
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 21
            .Width       = 153
            .Value       = 1
            .Enabled     = .F.

            WITH .Buttons(1)
                .Caption   = "Simples"
                .Height    = 17
                .Left      = 5
                .Top       = 2
                .Width     = 76
                .AutoSize  = .F.
                .BackStyle = 0
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Composto"
                .Height    = 17
                .Left      = 72
                .Top       = 2
                .Width     = 76
                .AutoSize  = .F.
                .BackStyle = 0
            ENDWITH
        ENDWITH

        *-- Linha 4: Tipo de dias (Corridos/Uteis)
        loc_oPag.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPag.lbl_4c_Label13
            .Caption   = "Dias :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 324
            .Top       = 81
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_OptDias", "OptionGroup")
        WITH loc_oPag.obj_4c_OptDias
            .Left        = 351
            .Top         = 78
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 21
            .Width       = 153
            .Value       = 1
            .Enabled     = .F.

            WITH .Buttons(1)
                .Caption   = "Corridos"
                .Height    = 17
                .Left      = 5
                .Top       = 2
                .Width     = 76
                .AutoSize  = .F.
                .BackStyle = 0
            ENDWITH

            WITH .Buttons(2)
                .Caption   = CHR(218) + "teis"
                .Height    = 17
                .Left      = 72
                .Top       = 2
                .Width     = 76
                .AutoSize  = .F.
                .BackStyle = 0
            ENDWITH
        ENDWITH

        *-- Separador horizontal (original: Commandgroup1 Height=1, Top=180)
        loc_oPag.AddObject("lbl_4c_Separador", "Label")
        WITH loc_oPag.lbl_4c_Separador
            .Caption   = ""
            .BackStyle = 1
            .BackColor = RGB(90, 90, 90)
            .Top       = 100
            .Left      = 6
            .Width     = 586
            .Height    = 1
        ENDWITH

        *-- Resultado: Juros
        loc_oPag.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag.lbl_4c_Label9
            .Caption   = "Juros :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 60
            .Top       = 107
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_ValorJuros", "TextBox")
        WITH loc_oPag.txt_4c_ValorJuros
            .FontBold          = .T.
            .Alignment         = 3
            .Value             = 0
            .Enabled           = .F.
            .InputMask         = "999,999,999.99"
            .Left              = 97
            .Top               = 103
            .Width             = 136
            .Height            = 20
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 253, 179)
            .DisabledBackColor = RGB(255, 253, 179)
            .DisabledForeColor = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .FontName          = "Tahoma"
            .FontSize          = 8
        ENDWITH

        *-- Resultado: Total
        loc_oPag.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPag.lbl_4c_Label10
            .Caption   = "Total :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 276
            .Top       = 107
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_ValorTotal", "TextBox")
        WITH loc_oPag.txt_4c_ValorTotal
            .FontBold          = .T.
            .Alignment         = 3
            .Value             = 0
            .Enabled           = .F.
            .InputMask         = "999,999,999.99"
            .Left              = 311
            .Top               = 103
            .Width             = 136
            .Height            = 20
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 253, 179)
            .DisabledBackColor = RGB(255, 253, 179)
            .DisabledForeColor = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .FontName          = "Tahoma"
            .FontSize          = 8
        ENDWITH

        *-- Resultado: Parcela
        loc_oPag.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPag.lbl_4c_Label12
            .Caption   = "Parcela :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 265
            .Top       = 131
            .AutoSize  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Valorpar", "TextBox")
        WITH loc_oPag.txt_4c_Valorpar
            .FontBold          = .T.
            .Alignment         = 3
            .Value             = 0
            .Enabled           = .F.
            .InputMask         = "999,999,999.99"
            .Left              = 311
            .Top               = 127
            .Width             = 136
            .Height            = 20
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 253, 179)
            .DisabledBackColor = RGB(255, 253, 179)
            .DisabledForeColor = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .FontName          = "Tahoma"
            .FontSize          = 8
        ENDWITH

        *-- BINDEVENTs (handlers PUBLIC obrigatorios para BINDEVENT)
        BINDEVENT(loc_oPag.txt_4c_ValorBase,  "KeyPress", THIS, "TxtValorBaseKeyPress")
        BINDEVENT(loc_oPag.txt_4c_JurosMes,   "KeyPress", THIS, "TxtJurosMesKeyPress")
        BINDEVENT(loc_oPag.txt_4c_JurosDia,   "KeyPress", THIS, "TxtJurosDiaKeyPress")
        BINDEVENT(loc_oPag.txt_4c_DataBase,   "KeyPress", THIS, "TxtDataBaseKeyPress")
        BINDEVENT(loc_oPag.txt_4c_DataFinal,  "KeyPress", THIS, "TxtDataFinalKeyPress")
        BINDEVENT(loc_oPag.txt_4c_Dias,       "KeyPress", THIS, "TxtDiasKeyPress")
        BINDEVENT(loc_oPag.obj_4c_OptCalculo, "InteractiveChange", THIS, "OptCalculoChange")
        BINDEVENT(loc_oPag.obj_4c_OptDias,    "InteractiveChange", THIS, "OptDiasChange")
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Vencimentos).
    * Para este form OPERACIONAL (calculadora de juros), todos os controles de
    * entrada e resultado cabem em Page1. Page2 recebe configuracao de fundo
    * consistente com o form para nao exibir fundo branco padrao caso seja
    * acessada programaticamente. Os 10 campos getvenc sao gerenciados em
    * ConfigurarPaginaVencimentos (Page1) para manter UX identica ao original
    * (todos os controles visiveis simultaneamente, sem necessidade de navegacao).
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page2
        WITH loc_oPag
            .BackStyle = 1
            .BackColor = RGB(212, 208, 200)
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Calculo) e Page2 (Vencimentos).
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *---------------------------------------------------------------------------
    * PopularCamposIniciais - Popula Page1 com os valores recebidos via Init.
    * Replicando a logica do Init original: habilita campos somente se ValorBase>0
    * e auto-calcula JurosDia/JurosMes a partir do parametro recebido.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE PopularCamposIniciais()
        LOCAL loc_oPag, loc_lEnable, loc_oBO, loc_x, loc_oVenc, loc_oErrV
        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_oBO     = THIS.this_oBusinessObject
        loc_lEnable = .F.

        *-- BO ja processou e cruzou JurosMes<->JurosDia em InicializarComParametros
        loc_oPag.txt_4c_ValorBase.Value  = loc_oBO.this_nValorBase
        loc_oPag.obj_4c_OptCalculo.Value = IIF(INLIST(loc_oBO.this_nTipoCalculo, 1, 2), ;
                                               loc_oBO.this_nTipoCalculo, 1)
        loc_oPag.txt_4c_JurosMes.Value   = loc_oBO.this_nJurosMes
        loc_oPag.txt_4c_JurosDia.Value   = loc_oBO.this_nJurosDia

        loc_oPag.txt_4c_Dias.Value      = 0
        loc_oPag.txt_4c_DataBase.Value  = loc_oBO.this_dDataBase
        loc_oPag.txt_4c_DataFinal.Value = IIF(!EMPTY(loc_oBO.this_dDataFinal), ;
                                              loc_oBO.this_dDataFinal, ;
                                              IIF(EMPTY(loc_oBO.this_dDataBase), ;
                                                  {}, DATE()))

        IF !EMPTY(loc_oPag.txt_4c_DataFinal.Value) AND ;
           !EMPTY(loc_oPag.txt_4c_DataBase.Value)
            loc_oPag.txt_4c_Dias.Value = loc_oPag.txt_4c_DataFinal.Value - ;
                                          loc_oPag.txt_4c_DataBase.Value
        ENDIF

        loc_oPag.txt_4c_ValorJuros.Value = 0
        loc_oPag.txt_4c_ValorTotal.Value  = 0

        *-- Habilitar campos apenas com ValorBase > 0 (equivale ao When original)
        loc_lEnable = (loc_oBO.this_nValorBase > 0)
        loc_oPag.obj_4c_OptCalculo.Enabled = loc_lEnable
        loc_oPag.obj_4c_OptDias.Enabled    = loc_lEnable
        loc_oPag.txt_4c_JurosMes.Enabled   = loc_lEnable
        loc_oPag.txt_4c_JurosDia.Enabled   = loc_lEnable
        loc_oPag.txt_4c_DataBase.Enabled   = loc_lEnable
        loc_oPag.txt_4c_DataFinal.Enabled  = loc_lEnable
        loc_oPag.txt_4c_Dias.Enabled       = loc_lEnable

        FOR loc_x = 1 TO 10
            TRY
                loc_oVenc = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Enabled = loc_lEnable
                ENDIF
            CATCH TO loc_oErrV
                IF !("does not exist" $ LOWER(loc_oErrV.Message)) AND ;
                   !("not found" $ LOWER(loc_oErrV.Message)) AND ;
                   !("unknown member" $ LOWER(loc_oErrV.Message))
                    MsgErro("Erro ao habilitar venc" + ALLTRIM(STR(loc_x)) + ": " + ;
                            loc_oErrV.Message, "PopularCamposIniciais")
                ENDIF
            ENDTRY
        NEXT

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * Calculos - Motor de calculo de juros.
    * Equivale ao PROCEDURE calculos do legado SIGPRCFN.
    * Suporta Simples e Composto; considera vencimentos individuais (Page1)
    * adicionados por ConfigurarPaginaVencimentos.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Calculos()
        LOCAL loc_oPag1, loc_nJuros, loc_nParc, loc_nTotDia
        LOCAL loc_x, loc_nDia, loc_cVencExpr, loc_dVenc, loc_oErrV

        loc_oPag1   = THIS.pgf_4c_Paginas.Page1
        loc_nParc   = 0
        loc_nTotDia = 0

        IF EMPTY(loc_oPag1.txt_4c_ValorBase.Value)  OR ;
           EMPTY(loc_oPag1.txt_4c_JurosMes.Value)   OR ;
           EMPTY(loc_oPag1.txt_4c_JurosDia.Value)   OR ;
           EMPTY(loc_oPag1.txt_4c_DataBase.Value)   OR ;
           EMPTY(loc_oPag1.txt_4c_DataFinal.Value)  OR ;
           EMPTY(loc_oPag1.txt_4c_Dias.Value)

            loc_oPag1.txt_4c_ValorJuros.Value = 0
            loc_oPag1.txt_4c_ValorTotal.Value  = 0
        ELSE
            IF loc_oPag1.obj_4c_OptCalculo.Value = 1
                loc_nJuros = ROUND(loc_oPag1.txt_4c_ValorBase.Value * ;
                                   (loc_oPag1.txt_4c_JurosMes.Value / 100) * ;
                                   (loc_oPag1.txt_4c_Dias.Value / 30), 2)
            ELSE
                loc_nJuros = ROUND(loc_oPag1.txt_4c_ValorBase.Value * ;
                                   (((1 + loc_oPag1.txt_4c_JurosDia.Value / 100) ^ ;
                                   loc_oPag1.txt_4c_Dias.Value) - 1), 2)
            ENDIF

            *-- Iterar vencimentos individuais (Page1, txt_4c_Venc1..10)
            FOR loc_x = 1 TO 10
                loc_cVencExpr = "THIS.pgf_4c_Paginas.Page1.txt_4c_Venc" + ;
                                ALLTRIM(STR(loc_x)) + ".Value"
                TRY
                    loc_dVenc = EVALUATE(loc_cVencExpr)
                    IF !EMPTY(loc_dVenc)
                        IF loc_nParc = 0
                            loc_nJuros = 0
                        ENDIF
                        loc_nDia = loc_dVenc - loc_oPag1.txt_4c_DataBase.Value
                        IF loc_oPag1.obj_4c_OptCalculo.Value = 1
                            loc_nJuros = loc_nJuros + ;
                                         ROUND(loc_oPag1.txt_4c_ValorBase.Value * ;
                                         (loc_oPag1.txt_4c_JurosMes.Value / 100) * ;
                                         (loc_nDia / 30), 2)
                        ELSE
                            loc_nJuros = loc_nJuros + ;
                                         ROUND(loc_oPag1.txt_4c_ValorBase.Value * ;
                                         (((1 + loc_oPag1.txt_4c_JurosDia.Value / 100) ^ ;
                                         loc_nDia) - 1), 2)
                        ENDIF
                        loc_nTotDia = loc_nDia
                        loc_nParc   = loc_nParc + 1
                    ENDIF
                CATCH TO loc_oErrV
                    *-- Erro inesperado ao ler campo de vencimento
                    IF !("unknown member" $ LOWER(loc_oErrV.Message)) AND ;
                       !("not found" $ LOWER(loc_oErrV.Message)) AND ;
                       !("does not exist" $ LOWER(loc_oErrV.Message))
                        MsgErro("Erro ao calcular venc" + ALLTRIM(STR(loc_x)) + ;
                                ": " + loc_oErrV.Message + ;
                                " LN=" + TRANSFORM(loc_oErrV.LineNo), ;
                                "C" + CHR(225) + "lculos")
                    ENDIF
                ENDTRY
            ENDFOR

            IF loc_nTotDia > 0
                loc_oPag1.txt_4c_Dias.Value = loc_nTotDia
            ENDIF

            loc_oPag1.txt_4c_ValorJuros.Value = loc_nJuros
            loc_oPag1.txt_4c_ValorTotal.Value  = loc_oPag1.txt_4c_ValorBase.Value + loc_nJuros
        ENDIF

        loc_oPag1.txt_4c_Valorpar.Value = loc_oPag1.txt_4c_ValorTotal.Value / ;
                                           IIF(loc_nParc <> 0, loc_nParc, 1)
        loc_oPag1.txt_4c_ValorJuros.Refresh()
        loc_oPag1.txt_4c_ValorTotal.Refresh()
        loc_oPag1.txt_4c_Valorpar.Refresh()
    ENDPROC

    *---------------------------------------------------------------------------
    * TxtValorBaseKeyPress - Valida ValorBase e habilita/desabilita campos.
    * Equivale ao PROCEDURE Valid de getValorBase no legado.
    *---------------------------------------------------------------------------
    PROCEDURE TxtValorBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEnable, loc_oPag, loc_x, loc_oVenc, loc_oErrV

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_lEnable = .F.

        IF loc_oPag.txt_4c_ValorBase.Value < 0
            MsgAviso("O Valor Base Precisa Ser Positivo!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_ValorBase.Value = 0
            loc_oPag.txt_4c_ValorBase.SetFocus()
        ELSE
            loc_lEnable = (loc_oPag.txt_4c_ValorBase.Value > 0)
        ENDIF

        loc_oPag.obj_4c_OptCalculo.Enabled = loc_lEnable
        loc_oPag.obj_4c_OptDias.Enabled    = loc_lEnable
        loc_oPag.txt_4c_JurosMes.Enabled   = loc_lEnable
        loc_oPag.txt_4c_JurosDia.Enabled   = loc_lEnable
        loc_oPag.txt_4c_DataBase.Enabled   = loc_lEnable
        loc_oPag.txt_4c_DataFinal.Enabled  = loc_lEnable
        loc_oPag.txt_4c_Dias.Enabled       = loc_lEnable

        FOR loc_x = 1 TO 10
            TRY
                loc_oVenc = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Enabled = loc_lEnable
                ENDIF
            CATCH TO loc_oErrV
                IF !("does not exist" $ LOWER(loc_oErrV.Message)) AND ;
                   !("not found" $ LOWER(loc_oErrV.Message)) AND ;
                   !("unknown member" $ LOWER(loc_oErrV.Message))
                    MsgErro("Erro ao habilitar venc" + ALLTRIM(STR(loc_x)) + ": " + ;
                            loc_oErrV.Message, "TxtValorBaseKeyPress")
                ENDIF
            ENDTRY
        NEXT

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * TxtJurosMesKeyPress - Ao sair de JurosMes: calcula JurosDia e recalcula.
    * Equivale ao PROCEDURE Valid de getJurosMes no legado.
    *---------------------------------------------------------------------------
    PROCEDURE TxtJurosMesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nJurosDia, loc_oPag

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_ValorBase.Value)
            RETURN
        ENDIF

        IF loc_oPag.obj_4c_OptCalculo.Value = 1
            loc_nJurosDia = ROUND(loc_oPag.txt_4c_JurosMes.Value / 30, 9)
        ELSE
            IF loc_oPag.txt_4c_JurosMes.Value > 0
                loc_nJurosDia = ROUND( ;
                    (((1 + loc_oPag.txt_4c_JurosMes.Value / 100) ^ (1/30)) - 1) * 100, 9)
            ELSE
                loc_nJurosDia = 0
            ENDIF
        ENDIF

        loc_oPag.txt_4c_JurosDia.Value = loc_nJurosDia
        loc_oPag.txt_4c_JurosDia.Refresh()

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * TxtJurosDiaKeyPress - Ao sair de JurosDia: calcula JurosMes e recalcula.
    * Equivale ao PROCEDURE Valid de getJurosDia no legado.
    *---------------------------------------------------------------------------
    PROCEDURE TxtJurosDiaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nJurosMes, loc_oPag

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_ValorBase.Value)
            RETURN
        ENDIF

        IF loc_oPag.obj_4c_OptCalculo.Value = 1
            loc_nJurosMes = ROUND(loc_oPag.txt_4c_JurosDia.Value * 30, 2)
        ELSE
            IF loc_oPag.txt_4c_JurosDia.Value > 0
                loc_nJurosMes = ROUND( ;
                    (((1 + loc_oPag.txt_4c_JurosDia.Value / 100) ^ 30) - 1) * 100, 2)
            ELSE
                loc_nJurosMes = 0
            ENDIF
        ENDIF

        loc_oPag.txt_4c_JurosMes.Value = loc_nJurosMes
        loc_oPag.txt_4c_JurosMes.Refresh()

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * TxtDataBaseKeyPress - Valida DataBase <= DataFinal, calcula Dias.
    * Equivale ao PROCEDURE Valid de getDataBase no legado.
    *---------------------------------------------------------------------------
    PROCEDURE TxtDataBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_ValorBase.Value)
            RETURN
        ENDIF

        IF !EMPTY(loc_oPag.txt_4c_DataFinal.Value) AND ;
           !EMPTY(loc_oPag.txt_4c_DataBase.Value)
            IF loc_oPag.txt_4c_DataBase.Value > loc_oPag.txt_4c_DataFinal.Value
                MsgAviso("A Data Base N" + CHR(227) + "o Pode Ser Maior " + ;
                         "Que a Data Final!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPag.txt_4c_DataBase.SetFocus()
                RETURN
            ENDIF
            loc_oPag.txt_4c_Dias.Value = loc_oPag.txt_4c_DataFinal.Value - ;
                                          loc_oPag.txt_4c_DataBase.Value
        ENDIF

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * TxtDataFinalKeyPress - Valida DataFinal >= DataBase, calcula Dias
    * (com dias uteis se optDias=2). Equivale ao Valid de getDataFinal.
    *---------------------------------------------------------------------------
    PROCEDURE TxtDataFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_nDia

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_ValorBase.Value)
            RETURN
        ENDIF

        IF !EMPTY(loc_oPag.txt_4c_DataBase.Value) AND ;
           !EMPTY(loc_oPag.txt_4c_DataFinal.Value)
            IF loc_oPag.txt_4c_DataFinal.Value < loc_oPag.txt_4c_DataBase.Value
                MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor " + ;
                         "Que a Data Base!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPag.txt_4c_DataFinal.SetFocus()
                RETURN
            ENDIF

            loc_nDia = loc_oPag.txt_4c_DataFinal.Value - ;
                       loc_oPag.txt_4c_DataBase.Value
            loc_oPag.txt_4c_Dias.Value = loc_nDia

            IF loc_nDia > 0 AND loc_oPag.obj_4c_OptDias.Value = 2
                loc_nDia = THIS.this_oBusinessObject.AjustarDiasUteis( ;
                               loc_oPag.txt_4c_DataBase.Value, ;
                               loc_oPag.txt_4c_DataFinal.Value)
                loc_oPag.txt_4c_Dias.Value = loc_nDia
            ENDIF
        ENDIF

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * TxtDiasKeyPress - Ao sair de Dias: atualiza DataFinal ou DataBase.
    * Recalcula dias uteis se optDias=2. Equivale ao Valid de getDias.
    *---------------------------------------------------------------------------
    PROCEDURE TxtDiasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_nDia

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_ValorBase.Value)
            RETURN
        ENDIF
        IF EMPTY(loc_oPag.txt_4c_DataFinal.Value) AND ;
           EMPTY(loc_oPag.txt_4c_DataBase.Value)
            RETURN
        ENDIF

        IF loc_oPag.obj_4c_OptDias.Value = 1
            IF !EMPTY(loc_oPag.txt_4c_DataBase.Value)
                loc_oPag.txt_4c_DataFinal.Value = loc_oPag.txt_4c_DataBase.Value + ;
                                                   loc_oPag.txt_4c_Dias.Value
            ELSE
                loc_oPag.txt_4c_DataBase.Value = loc_oPag.txt_4c_DataFinal.Value - ;
                                                  loc_oPag.txt_4c_Dias.Value
            ENDIF
        ENDIF

        loc_nDia = loc_oPag.txt_4c_Dias.Value
        IF loc_nDia > 0 AND loc_oPag.obj_4c_OptDias.Value = 2 AND ;
           !EMPTY(loc_oPag.txt_4c_DataBase.Value) AND ;
           !EMPTY(loc_oPag.txt_4c_DataFinal.Value)
            loc_nDia = THIS.this_oBusinessObject.AjustarDiasUteis( ;
                           loc_oPag.txt_4c_DataBase.Value, ;
                           loc_oPag.txt_4c_DataFinal.Value)
            loc_oPag.txt_4c_Dias.Value = loc_nDia
        ENDIF

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * OptCalculoChange - Ao mudar Simples/Composto: recalcula tudo.
    * Equivale ao InteractiveChange de optCalculo no legado.
    *---------------------------------------------------------------------------
    PROCEDURE OptCalculoChange()
        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * OptDiasChange - Ao mudar Corridos/Uteis: recalcula dias e totais.
    * Equivale ao InteractiveChange de optDias no legado.
    *---------------------------------------------------------------------------
    PROCEDURE OptDiasChange()
        LOCAL loc_oPag, loc_nDia

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(loc_oPag.txt_4c_DataFinal.Value) AND ;
           !EMPTY(loc_oPag.txt_4c_DataBase.Value)
            loc_nDia = loc_oPag.txt_4c_DataFinal.Value - ;
                       loc_oPag.txt_4c_DataBase.Value
            loc_oPag.txt_4c_Dias.Value = loc_nDia

            IF loc_nDia > 0 AND loc_oPag.obj_4c_OptDias.Value = 2
                loc_nDia = THIS.this_oBusinessObject.AjustarDiasUteis( ;
                               loc_oPag.txt_4c_DataBase.Value, ;
                               loc_oPag.txt_4c_DataFinal.Value)
                loc_oPag.txt_4c_Dias.Value = loc_nDia
            ENDIF
        ENDIF

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarPaginaVencimentos - Adiciona 10 campos de vencimento na Page1.
    * Linha 1 (venc1,3,5,7,9): Top=152. Linha 2 (venc2,4,6,8,10): Top=177.
    * Colunas: Left=97/184/271/358/445. Equivale a getvenc1..10 do legado.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaVencimentos()
        LOCAL loc_oPag, loc_x, loc_nLeft, loc_oCtrl, loc_oErrB
        LOCAL ARRAY laLeft(5)

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        laLeft(1) = 97
        laLeft(2) = 184
        laLeft(3) = 271
        laLeft(4) = 358
        laLeft(5) = 445

        loc_oPag.AddObject("lbl_4c_LblVenc", "Label")
        loc_oCtrl = loc_oPag.Controls(loc_oPag.ControlCount)
        WITH loc_oCtrl
            .Caption   = "Vencimentos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Left      = 26
            .Top       = 152
            .AutoSize  = .T.
        ENDWITH

        FOR loc_x = 1 TO 5
            loc_nLeft = laLeft(loc_x)

            loc_oPag.AddObject("txt_4c_Venc" + ALLTRIM(STR(2*loc_x-1)), "TextBox")
            loc_oCtrl = loc_oPag.Controls(loc_oPag.ControlCount)
            WITH loc_oCtrl
                .Value         = {}
                .Left          = loc_nLeft
                .Top           = 152
                .Width         = 82
                .Height        = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Enabled       = .F.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Venc" + ALLTRIM(STR(2*loc_x)), "TextBox")
            loc_oCtrl = loc_oPag.Controls(loc_oPag.ControlCount)
            WITH loc_oCtrl
                .Value         = {}
                .Left          = loc_nLeft
                .Top           = 177
                .Width         = 82
                .Height        = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Enabled       = .F.
            ENDWITH
        NEXT

        FOR loc_x = 1 TO 10
            TRY
                loc_oCtrl = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oCtrl) = "O"
                    BINDEVENT(loc_oCtrl, "KeyPress", THIS, "TxtVencKeyPress")
                ENDIF
            CATCH TO loc_oErrB
                MsgErro("Erro BINDEVENT venc" + ALLTRIM(STR(loc_x)) + ": " + ;
                        loc_oErrB.Message, "ConfigurarPaginaVencimentos")
            ENDTRY
        NEXT
    ENDPROC

    *---------------------------------------------------------------------------
    * TxtVencKeyPress - Handler compartilhado para os 10 campos de vencimento.
    * Valida data >= DataBase, atualiza Dias e dispara Calculos.
    * Equivale ao Valid de getvenc1..getvenc10 no legado.
    *---------------------------------------------------------------------------
    PROCEDURE TxtVencKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_oVenc, loc_dBase

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_oVenc = loc_oPag.ActiveControl
        loc_dBase = loc_oPag.txt_4c_DataBase.Value

        IF VARTYPE(loc_oVenc) = "O" AND ;
           !EMPTY(loc_dBase) AND ;
           !EMPTY(loc_oVenc.Value)
            IF loc_oVenc.Value < loc_dBase
                MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor " + ;
                         "Que a Data Base!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oVenc.SetFocus()
                RETURN
            ENDIF
            loc_oPag.txt_4c_Dias.Value = loc_oVenc.Value - loc_dBase
        ENDIF

        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * FormParaBO - Sincroniza valores dos controles do form -> BO.
    * Cobre TODOS os campos: inputs, tipo de calculo, datas e vencimentos.
    *---------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPag, loc_oBO

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oBO  = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oBO.this_nValorBase   = loc_oPag.txt_4c_ValorBase.Value
        loc_oBO.this_nTipoCalculo = loc_oPag.obj_4c_OptCalculo.Value
        loc_oBO.this_nJurosMes    = loc_oPag.txt_4c_JurosMes.Value
        loc_oBO.this_nJurosDia    = loc_oPag.txt_4c_JurosDia.Value
        loc_oBO.this_dDataBase    = loc_oPag.txt_4c_DataBase.Value
        loc_oBO.this_dDataFinal   = loc_oPag.txt_4c_DataFinal.Value
        loc_oBO.this_nDias        = loc_oPag.txt_4c_Dias.Value
        loc_oBO.this_nTipoDias    = loc_oPag.obj_4c_OptDias.Value
        loc_oBO.this_dVenc1       = loc_oPag.txt_4c_Venc1.Value
        loc_oBO.this_dVenc2       = loc_oPag.txt_4c_Venc2.Value
        loc_oBO.this_dVenc3       = loc_oPag.txt_4c_Venc3.Value
        loc_oBO.this_dVenc4       = loc_oPag.txt_4c_Venc4.Value
        loc_oBO.this_dVenc5       = loc_oPag.txt_4c_Venc5.Value
        loc_oBO.this_dVenc6       = loc_oPag.txt_4c_Venc6.Value
        loc_oBO.this_dVenc7       = loc_oPag.txt_4c_Venc7.Value
        loc_oBO.this_dVenc8       = loc_oPag.txt_4c_Venc8.Value
        loc_oBO.this_dVenc9       = loc_oPag.txt_4c_Venc9.Value
        loc_oBO.this_dVenc10      = loc_oPag.txt_4c_Venc10.Value
    ENDPROC

    *---------------------------------------------------------------------------
    * BOParaForm - Sincroniza propriedades do BO -> controles do form.
    * Cobre inputs, tipo de calculo, datas, vencimentos e resultados calculados.
    *---------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oBO

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oBO  = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oPag.txt_4c_ValorBase.Value  = loc_oBO.this_nValorBase
        loc_oPag.obj_4c_OptCalculo.Value = IIF(INLIST(loc_oBO.this_nTipoCalculo, 1, 2), ;
                                               loc_oBO.this_nTipoCalculo, 1)
        loc_oPag.txt_4c_JurosMes.Value   = loc_oBO.this_nJurosMes
        loc_oPag.txt_4c_JurosDia.Value   = loc_oBO.this_nJurosDia
        loc_oPag.txt_4c_DataBase.Value   = loc_oBO.this_dDataBase
        loc_oPag.txt_4c_DataFinal.Value  = loc_oBO.this_dDataFinal
        loc_oPag.txt_4c_Dias.Value       = loc_oBO.this_nDias
        loc_oPag.obj_4c_OptDias.Value    = IIF(INLIST(loc_oBO.this_nTipoDias, 1, 2), ;
                                               loc_oBO.this_nTipoDias, 1)
        loc_oPag.txt_4c_Venc1.Value      = loc_oBO.this_dVenc1
        loc_oPag.txt_4c_Venc2.Value      = loc_oBO.this_dVenc2
        loc_oPag.txt_4c_Venc3.Value      = loc_oBO.this_dVenc3
        loc_oPag.txt_4c_Venc4.Value      = loc_oBO.this_dVenc4
        loc_oPag.txt_4c_Venc5.Value      = loc_oBO.this_dVenc5
        loc_oPag.txt_4c_Venc6.Value      = loc_oBO.this_dVenc6
        loc_oPag.txt_4c_Venc7.Value      = loc_oBO.this_dVenc7
        loc_oPag.txt_4c_Venc8.Value      = loc_oBO.this_dVenc8
        loc_oPag.txt_4c_Venc9.Value      = loc_oBO.this_dVenc9
        loc_oPag.txt_4c_Venc10.Value     = loc_oBO.this_dVenc10
        loc_oPag.txt_4c_ValorJuros.Value = loc_oBO.this_nValorJuros
        loc_oPag.txt_4c_ValorTotal.Value  = loc_oBO.this_nValorTotal
        loc_oPag.txt_4c_Valorpar.Value   = loc_oBO.this_nValorParcela

        THIS.HabilitarCampos(loc_oBO.this_nValorBase > 0)
    ENDPROC

    *---------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de entrada conforme
    * par_lEnable. Campos habilitados apenas quando ValorBase > 0.
    *---------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lEnable)
        LOCAL loc_oPag, loc_x, loc_oVenc, loc_oErr

        IF VARTYPE(par_lEnable) != "L"
            par_lEnable = .F.
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.obj_4c_OptCalculo.Enabled = par_lEnable
        loc_oPag.obj_4c_OptDias.Enabled    = par_lEnable
        loc_oPag.txt_4c_JurosMes.Enabled   = par_lEnable
        loc_oPag.txt_4c_JurosDia.Enabled   = par_lEnable
        loc_oPag.txt_4c_DataBase.Enabled   = par_lEnable
        loc_oPag.txt_4c_DataFinal.Enabled  = par_lEnable
        loc_oPag.txt_4c_Dias.Enabled       = par_lEnable

        FOR loc_x = 1 TO 10
            TRY
                loc_oVenc = EVALUATE("loc_oPag.txt_4c_Venc" + ALLTRIM(STR(loc_x)))
                IF VARTYPE(loc_oVenc) = "O"
                    loc_oVenc.Enabled = par_lEnable
                ENDIF
            CATCH TO loc_oErr
                IF !("does not exist" $ LOWER(loc_oErr.Message)) AND ;
                   !("not found" $ LOWER(loc_oErr.Message)) AND ;
                   !("unknown member" $ LOWER(loc_oErr.Message))
                    MsgErro("Erro ao habilitar campo venc" + ALLTRIM(STR(loc_x)) + ;
                            ": " + loc_oErr.Message, "HabilitarCampos")
                ENDIF
            ENDTRY
        NEXT
    ENDPROC

    *---------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos do form para o estado inicial.
    *---------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_ValorBase.Value  = 0
        loc_oPag.txt_4c_JurosMes.Value   = 0
        loc_oPag.txt_4c_JurosDia.Value   = 0
        loc_oPag.txt_4c_DataBase.Value   = {}
        loc_oPag.txt_4c_DataFinal.Value  = {}
        loc_oPag.txt_4c_Dias.Value       = 0
        loc_oPag.txt_4c_ValorJuros.Value = 0
        loc_oPag.txt_4c_ValorTotal.Value  = 0
        loc_oPag.txt_4c_Valorpar.Value   = 0
        loc_oPag.obj_4c_OptCalculo.Value = 1
        loc_oPag.obj_4c_OptDias.Value    = 1
        loc_oPag.txt_4c_Venc1.Value      = {}
        loc_oPag.txt_4c_Venc2.Value      = {}
        loc_oPag.txt_4c_Venc3.Value      = {}
        loc_oPag.txt_4c_Venc4.Value      = {}
        loc_oPag.txt_4c_Venc5.Value      = {}
        loc_oPag.txt_4c_Venc6.Value      = {}
        loc_oPag.txt_4c_Venc7.Value      = {}
        loc_oPag.txt_4c_Venc8.Value      = {}
        loc_oPag.txt_4c_Venc9.Value      = {}
        loc_oPag.txt_4c_Venc10.Value     = {}

        THIS.HabilitarCampos(.F.)
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarLista - Form OPERACIONAL de calculadora nao tem lista/grid.
    * Reaplica estado do BO nos controles (usado pela infraestrutura FormBase).
    *---------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPag

        THIS.BOParaForm()
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPag.txt_4c_ValorBase) = "O"
            loc_oPag.txt_4c_ValorBase.SetFocus()
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * AjustarBotoesPorModo - Para calculadora sem modos CRUD: mantem o botao
    * Sair sempre habilitado.
    *---------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cnt_4c_Botoes) = "O" AND ;
           VARTYPE(THIS.cnt_4c_Botoes.cmd_4c_BtnOK) = "O"
            THIS.cnt_4c_Botoes.cmd_4c_BtnOK.Enabled = .T.
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnBuscarClick - Recalcula com os valores correntes do form.
    *---------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.FormParaBO()
        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form (alias de BtnSairClick para consistencia
    * com a infraestrutura FormBase).
    *---------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnSalvarClick - Sincroniza form -> BO e executa o calculo.
    *---------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        THIS.Calculos()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnCancelarClick - Limpa todos os campos e reinicia a calculadora.
    *---------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Deseja limpar todos os campos e reiniciar o c" + ;
                       CHR(225) + "lculo?", ;
                       "Cancelar C" + CHR(225) + "lculo")
            THIS.LimparCampos()
            THIS.this_oBusinessObject.LimparPropriedades()
            THIS.this_cModoAtual = "CALCULO"
            THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Destroy()
    *---------------------------------------------------------------------------
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCfnBO.prg):
*******************************************************************************
* SigPrCfnBO.prg - Business Object: Calculo de Juros
* Herda de BusinessBase
* Form OPERACIONAL - sem tabela BD (calculo puro)
* Migrado de: SigPrCfn.SCX
*******************************************************************************

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *-- Sem tabela BD: form de calculo puro
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Entradas do calculo
    this_nValorBase    = 0    && Valor Base (positivo)
    this_nTipoCalculo  = 1    && 1=Simples, 2=Composto
    this_nJurosMes     = 0    && Juros ao Mes (%)
    this_nJurosDia     = 0    && Juros ao Dia (%)
    this_dDataBase     = {}   && Data Base do calculo
    this_dDataFinal    = {}   && Data Final do calculo
    this_nDias         = 0    && Numero de dias entre DataBase e DataFinal
    this_nTipoDias     = 1    && 1=Corridos, 2=Uteis

    *-- Vencimentos (ate 10 parcelas)
    this_dVenc1        = {}
    this_dVenc2        = {}
    this_dVenc3        = {}
    this_dVenc4        = {}
    this_dVenc5        = {}
    this_dVenc6        = {}
    this_dVenc7        = {}
    this_dVenc8        = {}
    this_dVenc9        = {}
    this_dVenc10       = {}

    *-- Resultados do calculo
    this_nValorJuros   = 0    && Valor dos juros calculados
    this_nValorTotal   = 0    && Valor Total (Base + Juros)
    this_nValorParcela = 0    && Valor de cada parcela

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.LimparPropriedades()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE LimparPropriedades()
    *---------------------------------------------------------------------------
        THIS.this_nValorBase    = 0
        THIS.this_nTipoCalculo  = 1
        THIS.this_nJurosMes     = 0
        THIS.this_nJurosDia     = 0
        THIS.this_dDataBase     = {}
        THIS.this_dDataFinal    = {}
        THIS.this_nDias         = 0
        THIS.this_nTipoDias     = 1
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
        THIS.this_nValorJuros   = 0
        THIS.this_nValorTotal   = 0
        THIS.this_nValorParcela = 0
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *---------------------------------------------------------------------------
        IF THIS.this_nValorBase < 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * InicializarComParametros - Popula propriedades a partir dos parametros
    * recebidos pelo form (equivalente ao Init do legado com LPARAMETERS)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarComParametros(par_nValor, par_nTipo, par_nJurosMes, par_nJurosDia, par_dDataBase, par_dDataFinal)
        THIS.LimparPropriedades()

        IF VARTYPE(par_nValor) = "N" AND par_nValor > 0
            THIS.this_nValorBase = par_nValor
        ENDIF

        IF VARTYPE(par_nTipo) = "N" AND INLIST(par_nTipo, 1, 2)
            THIS.this_nTipoCalculo = par_nTipo
        ELSE
            THIS.this_nTipoCalculo = 1
        ENDIF

        IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
            THIS.this_nJurosMes = par_nJurosMes
            THIS.this_nJurosDia = THIS.CalcularJurosDia(par_nJurosMes)
        ELSE
            IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
            THIS.this_nJurosDia = par_nJurosDia
            THIS.this_nJurosMes = THIS.CalcularJurosMes(par_nJurosDia)
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
    ENDPROC

    *---------------------------------------------------------------------------
    * Calcular - Logica central de calculo de juros (equivalente a calculos()
    * do legado). Usa propriedades this_* como entrada e atualiza os resultados.
    *---------------------------------------------------------------------------
    PROCEDURE Calcular()
        LOCAL loc_nJuros, loc_nParc, loc_nTotDia, loc_x, loc_dVenc, loc_nDia
        LOCAL ARRAY loc_aVenc[10]

        loc_nJuros  = 0
        loc_nParc   = 0
        loc_nTotDia = 0

        *-- Sem dados minimos: zerar resultados
        IF EMPTY(THIS.this_nValorBase)  OR ;
           EMPTY(THIS.this_nJurosMes)   OR ;
           EMPTY(THIS.this_nJurosDia)   OR ;
           EMPTY(THIS.this_dDataBase)   OR ;
           EMPTY(THIS.this_dDataFinal)  OR ;
           EMPTY(THIS.this_nDias)
            THIS.this_nValorJuros   = 0
            THIS.this_nValorTotal   = 0
            THIS.this_nValorParcela = 0
            RETURN .T.
        ENDIF

        *-- Calculo base (sem vencimentos)
        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJuros = ROUND(THIS.this_nValorBase * ;
                               (THIS.this_nJurosMes / 100) * ;
                               (THIS.this_nDias / 30), 2)
        ELSE
            *-- Juros Compostos
            loc_nJuros = ROUND(THIS.this_nValorBase * ;
                               (((1 + THIS.this_nJurosDia / 100) ^ ;
                               THIS.this_nDias) - 1), 2)
        ENDIF

        *-- Iterar vencimentos (ate 10 parcelas)
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

        FOR loc_x = 1 TO 10
            loc_dVenc = loc_aVenc[loc_x]
            IF !EMPTY(loc_dVenc)
                IF loc_nParc = 0
                    *-- Primeira parcela encontrada: zerar calculo base
                    loc_nJuros = 0
                ENDIF
                loc_nDia = loc_dVenc - THIS.this_dDataBase
                IF THIS.this_nTipoCalculo = 1
                    *-- Juros Simples por parcela
                    loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                    (THIS.this_nJurosMes / 100) * ;
                                                    (loc_nDia / 30), 2)
                ELSE
                    *-- Juros Compostos por parcela
                    loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                    (((1 + THIS.this_nJurosDia / 100) ^ ;
                                                    loc_nDia) - 1), 2)
                ENDIF
                loc_nTotDia = loc_nDia
                loc_nParc   = loc_nParc + 1
            ENDIF
        ENDFOR

        IF loc_nTotDia > 0
            THIS.this_nDias = loc_nTotDia
        ENDIF

        THIS.this_nValorJuros   = loc_nJuros
        THIS.this_nValorTotal   = THIS.this_nValorBase + loc_nJuros
        THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJurosDia - Converte juros mensais em diarios
    * Atualiza this_nJurosDia e retorna o valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJurosDia(par_nJurosMes)
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples: dividir por 30
            loc_nJurosDia = ROUND(par_nJurosMes / 30, 9)
        ELSE
            *-- Juros Compostos: formula de equivalencia
            loc_nJurosDia = ROUND((((1 + par_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
        ENDIF

        THIS.this_nJurosDia = loc_nJurosDia
        RETURN loc_nJurosDia
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJurosMes - Converte juros diarios em mensais
    * Atualiza this_nJurosMes e retorna o valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJurosMes(par_nJurosDia)
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples: multiplicar por 30
            loc_nJurosMes = ROUND(par_nJurosDia * 30, 2)
        ELSE
            *-- Juros Compostos: formula de equivalencia
            loc_nJurosMes = ROUND((((1 + par_nJurosDia / 100) ^ 30) - 1) * 100, 2)
        ENDIF

        THIS.this_nJurosMes = loc_nJurosMes
        RETURN loc_nJurosMes
    ENDPROC

    *---------------------------------------------------------------------------
    * AjustarDiasUteis - Conta dias uteis entre duas datas (exclui fins de
    * semana e feriados cadastrados em SigCdFer). Atualiza this_nDias.
    * Equivalente ao bloco fChkFeriado do legado em getDataFinal.Valid/
    * getDias.Valid/optDias.InteractiveChange.
    *---------------------------------------------------------------------------
    PROCEDURE AjustarDiasUteis(par_dDataBase, par_dDataFinal)
        LOCAL loc_nDias, loc_dAtual

        loc_nDias  = par_dDataFinal - par_dDataBase
        loc_dAtual = par_dDataBase

        DO WHILE loc_dAtual <= par_dDataFinal
            IF THIS.VerificarFeriado(loc_dAtual)
                loc_nDias = loc_nDias - 1
            ENDIF
            loc_dAtual = loc_dAtual + 1
        ENDDO

        THIS.this_nDias = loc_nDias
        RETURN loc_nDias
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarFeriado - Retorna .T. se a data e fim de semana ou feriado
    * cadastrado em SigCdFer (equivalente a fChkFeriado do legado).
    *---------------------------------------------------------------------------
    PROCEDURE VerificarFeriado(par_dData)
        LOCAL loc_nDow, loc_lNaoUtil, loc_cSQL, loc_nRet

        *-- Verificar fim de semana (DOW: Domingo=1, Sabado=7)
        loc_nDow = DOW(par_dData)
        IF loc_nDow = 1 OR loc_nDow = 7
            RETURN .T.
        ENDIF

        *-- Verificar feriado cadastrado no banco
        loc_lNaoUtil = .F.
        loc_cSQL = "SELECT COUNT(*) AS nFeriado FROM SigCdFer " + ;
                   "WHERE CAST(datas AS DATE) = CAST(" + FormatarDataSQL(par_dData) + " AS DATE)"

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerCheck")
        IF loc_nRet > 0 AND USED("cursor_4c_FerCheck")
            SELECT cursor_4c_FerCheck
            IF NVL(nFeriado, 0) > 0
                loc_lNaoUtil = .T.
            ENDIF
            USE IN cursor_4c_FerCheck
        ENDIF

        RETURN loc_lNaoUtil
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarValorBase - Valida que o valor base e positivo
    *---------------------------------------------------------------------------
    PROCEDURE ValidarValorBase(par_nValor)
        IF par_nValor < 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarDatas - Valida que DataBase nao e maior que DataFinal
    *---------------------------------------------------------------------------
    PROCEDURE ValidarDatas(par_dDataBase, par_dDataFinal)
        IF !EMPTY(par_dDataBase) AND !EMPTY(par_dDataFinal)
            IF par_dDataBase > par_dDataFinal
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarDataVencimento - Valida que data de vencimento nao e anterior
    * a DataBase
    *---------------------------------------------------------------------------
    PROCEDURE ValidarDataVencimento(par_dVenc, par_dDataBase)
        IF !EMPTY(par_dDataBase) AND !EMPTY(par_dVenc)
            IF par_dVenc < par_dDataBase
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades de entrada do calculo a partir
    * de cursor (usado quando o form eh chamado por outra rotina que ja tem
    * os parametros num cursor VFP). Mapeamento por campos que existirem.
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o encontrado: " + TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".ValorBase") != "U"
                THIS.this_nValorBase = NVL(EVALUATE(par_cAliasCursor + ".ValorBase"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoCalculo") != "U"
                THIS.this_nTipoCalculo = NVL(EVALUATE(par_cAliasCursor + ".TipoCalculo"), 1)
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosMes") != "U"
                THIS.this_nJurosMes = NVL(EVALUATE(par_cAliasCursor + ".JurosMes"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosDia") != "U"
                THIS.this_nJurosDia = NVL(EVALUATE(par_cAliasCursor + ".JurosDia"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataBase") != "U"
                THIS.this_dDataBase = NVL(EVALUATE(par_cAliasCursor + ".DataBase"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataFinal") != "U"
                THIS.this_dDataFinal = NVL(EVALUATE(par_cAliasCursor + ".DataFinal"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".Dias") != "U"
                THIS.this_nDias = NVL(EVALUATE(par_cAliasCursor + ".Dias"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoDias") != "U"
                THIS.this_nTipoDias = NVL(EVALUATE(par_cAliasCursor + ".TipoDias"), 1)
            ENDIF

            IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal) AND THIS.this_nDias = 0
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Sobrescreve BusinessBase.Inserir()
    * Form OPERACIONAL de calculo puro (this_cTabela vazio): nao persiste
    * dados em tabela CRUD. Executa o calculo e retorna resultado.
    * Chamada via BusinessBase.Salvar() apos ValidarDados().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.Calcular()

        IF !loc_lSucesso
            THIS.this_cMensagemErro = "Falha ao executar c" + CHR(225) + "lculo de juros"
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Sobrescreve BusinessBase.Atualizar()
    * Form OPERACIONAL de calculo puro: recalcula com parametros correntes.
    * Chamada via BusinessBase.Salvar() em modo edicao apos ValidarDados().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.Calcular()

        IF !loc_lSucesso
            THIS.this_cMensagemErro = "Falha ao recalcular juros"
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * RegistrarAuditoria - Sobrescreve BusinessBase.RegistrarAuditoria()
    * Como o form nao tem tabela associada (this_cTabela vazio), registra no
    * LogAuditoria a operacao de calculo com resumo dos parametros usados.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cResumo, loc_cUsuario, loc_nRet

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cResumo = "VB=" + TRANSFORM(THIS.this_nValorBase, "@Z 999999999.99") + ;
                      "|TC=" + TRANSFORM(THIS.this_nTipoCalculo) + ;
                      "|JM=" + TRANSFORM(THIS.this_nJurosMes, "@Z 999.999999") + ;
                      "|D=" + TRANSFORM(THIS.this_nDias) + ;
                      "|VJ=" + TRANSFORM(THIS.this_nValorJuros, "@Z 999999999.99")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL("SigPrCfn") + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(LEFT(loc_cResumo, 100)) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN (loc_nRet > 0)
    ENDPROC

ENDDEFINE


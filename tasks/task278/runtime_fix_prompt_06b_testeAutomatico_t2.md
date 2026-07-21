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
[16/07/2026 00:32:02] Conexão ALERTA: Impossível conectar ao banco DB_ALERTA.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-16 00:29:51] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-16 00:29:51] [INFO] Config FPW: (nao fornecido)
[2026-07-16 00:29:51] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-16 00:29:51] [INFO] Timeout: 300 segundos
[2026-07-16 00:29:51] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_34vly34v.prg
[2026-07-16 00:29:51] [INFO] Conteudo do wrapper:
[2026-07-16 00:29:51] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'
QUIT

[2026-07-16 00:29:51] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_34vly34v.prg
[2026-07-16 00:29:51] [INFO] VFP output esperado em: C:\4c\tasks\task278\vfp_output.txt
[2026-07-16 00:29:51] [INFO] Executando Visual FoxPro 9...
[2026-07-16 00:29:51] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_34vly34v.prg
[2026-07-16 00:29:51] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_34vly34v.prg
[2026-07-16 00:29:51] [INFO] Timeout configurado: 300 segundos
[2026-07-16 00:30:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-16 00:30:11] [INFO] VFP9 finalizado em 20.2452053 segundos
[2026-07-16 00:30:11] [INFO] Exit Code: 
[2026-07-16 00:30:11] [INFO] 
[2026-07-16 00:30:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-16 00:30:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_34vly34v.prg
[2026-07-16 00:30:11] [INFO] 
[2026-07-16 00:30:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-16 00:30:11] [INFO] * Auto-generated wrapper for parameters
[2026-07-16 00:30:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-16 00:30:11] [INFO] * Parameters: 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'
[2026-07-16 00:30:11] [INFO] 
[2026-07-16 00:30:11] [INFO] * Anti-dialog protections for unattended execution
[2026-07-16 00:30:11] [INFO] SET SAFETY OFF
[2026-07-16 00:30:11] [INFO] SET RESOURCE OFF
[2026-07-16 00:30:11] [INFO] SET TALK OFF
[2026-07-16 00:30:11] [INFO] SET NOTIFY OFF
[2026-07-16 00:30:11] [INFO] SYS(2335, 0)
[2026-07-16 00:30:11] [INFO] 
[2026-07-16 00:30:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'
[2026-07-16 00:30:11] [INFO] QUIT
[2026-07-16 00:30:11] [INFO] 
[2026-07-16 00:30:11] [INFO] === Fim do Wrapper.prg ===
[2026-07-16 00:30:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-16 00:30:51] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-16 00:30:51] [INFO] Config FPW: (nao fornecido)
[2026-07-16 00:30:51] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-16 00:30:51] [INFO] Timeout: 300 segundos
[2026-07-16 00:30:51] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qk3w5pr4.prg
[2026-07-16 00:30:51] [INFO] Conteudo do wrapper:
[2026-07-16 00:30:51] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'
QUIT

[2026-07-16 00:30:51] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qk3w5pr4.prg
[2026-07-16 00:30:51] [INFO] VFP output esperado em: C:\4c\tasks\task278\vfp_output.txt
[2026-07-16 00:30:51] [INFO] Executando Visual FoxPro 9...
[2026-07-16 00:30:51] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qk3w5pr4.prg
[2026-07-16 00:30:51] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qk3w5pr4.prg
[2026-07-16 00:30:51] [INFO] Timeout configurado: 300 segundos
[2026-07-16 00:32:02] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-16 00:32:02] [INFO] VFP9 finalizado em 71.3893812 segundos
[2026-07-16 00:32:02] [INFO] Exit Code: 
[2026-07-16 00:32:02] [INFO] 
[2026-07-16 00:32:02] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-16 00:32:02] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qk3w5pr4.prg
[2026-07-16 00:32:02] [INFO] 
[2026-07-16 00:32:02] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-16 00:32:02] [INFO] * Auto-generated wrapper for parameters
[2026-07-16 00:32:02] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-16 00:32:02] [INFO] * Parameters: 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'
[2026-07-16 00:32:02] [INFO] 
[2026-07-16 00:32:02] [INFO] * Anti-dialog protections for unattended execution
[2026-07-16 00:32:02] [INFO] SET SAFETY OFF
[2026-07-16 00:32:02] [INFO] SET RESOURCE OFF
[2026-07-16 00:32:03] [INFO] SET TALK OFF
[2026-07-16 00:32:03] [INFO] SET NOTIFY OFF
[2026-07-16 00:32:03] [INFO] SYS(2335, 0)
[2026-07-16 00:32:03] [INFO] 
[2026-07-16 00:32:03] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrEml', 'C:\4c\tasks\task278', 'OPERACIONAL'
[2026-07-16 00:32:03] [INFO] QUIT
[2026-07-16 00:32:03] [INFO] 
[2026-07-16 00:32:03] [INFO] === Fim do Wrapper.prg ===
[2026-07-16 00:32:03] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrEml",
  "timestamp": "20260716003202",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg):
*==============================================================================
* FormSigPrEml.prg - ALERTA - Email
* Tipo: OPERACIONAL (flat layout, sem PageFrame)
* Migrado de: SIGPREML.SCX
* Chamado com: CREATEOBJECT("FormSigPrEml", cEmpDopNums, cEscolha, @laOpeBaixa)
*              loFrm.Show()
* Parametros Init:
*   par_cEmpDopNums : Emp(3)+Dopes(20)+Numes(6) = 29 chars
*   par_cEscolha    : "INSERIR" | "ALTERAR" | "EXCLUIR"
*   par_laOpeBaixa  : array de EmpDopNums de baixas (opcional)
*==============================================================================

DEFINE CLASS FormSigPrEml AS FormBase

    *-- Dimensoes identicas ao legado
    Width        = 1000
    Height       = 600
    Caption      = "ALERTA - Email"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cEmpDopNums     = ""
    this_cEscolha        = ""
    DIMENSION this_laOpeBaixa[1]

    *==========================================================================
    * Init - Recebe parametros e transfere para DODEFAULT/InicializarForm
    *==========================================================================
    PROCEDURE Init(par_cEmpDopNums, par_cEscolha, par_laOpeBaixa)
        LOCAL loc_x, loc_nLen

        THIS.this_cEmpDopNums = IIF(TYPE("par_cEmpDopNums") = "C", par_cEmpDopNums, "")
        THIS.this_cEscolha    = IIF(TYPE("par_cEscolha")    = "C", par_cEscolha,    "")

        *-- Converter array de baixas em propriedade de array do objeto
        IF TYPE("par_laOpeBaixa") = "A"
            loc_nLen = ALEN(par_laOpeBaixa)
            IF loc_nLen > 0
                DIMENSION THIS.this_laOpeBaixa[loc_nLen]
                FOR loc_x = 1 TO loc_nLen
                    THIS.this_laOpeBaixa[loc_x] = par_laOpeBaixa[loc_x]
                ENDFOR
            ELSE
                DIMENSION THIS.this_laOpeBaixa[1]
                THIS.this_laOpeBaixa[1] = ""
            ENDIF
        ELSE
            DIMENSION THIS.this_laOpeBaixa[1]
            THIS.this_laOpeBaixa[1] = ""
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEmlBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto SigPrEmlBO.", "Erro")
            ELSE
                IF !THIS.this_oBusinessObject.InicializarConexaoAlerta()
                    *-- Erro ja exibido em InicializarConexaoAlerta
                ELSE
                    THIS.this_oBusinessObject.CarregarDados( ;
                        THIS.this_cEmpDopNums, ;
                        THIS.this_cEscolha, ;
                        @THIS.this_laOpeBaixa)

                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarPaginaDados()
                    THIS.TornarControlesVisiveis()
                    THIS.ConfigurarBINDEVENTs()

                    *-- Propagar Caption para labels do cabecalho
                    THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                    THIS.grd_4c_Dados.Refresh()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro FormSigPrEml.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        THIS.Picture      = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ClipControls = .F.
        THIS.ScrollBars   = 0
        THIS.ShowTips     = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Bloco fixo do topo do form OPERACIONAL
    *--------------------------------------------------------------------------
    * Equivale a "Page1 (Lista)" dos forms CRUD. Neste form plano monta o
    * cabecalho escuro (cnt_4c_Sombra), o shape decorativo, o botao Enviar
    * Email flutuante (cmd_4c_BtnEmail) e o container de saida (cnt_4c_Saida
    * com cmd_4c_Encerrar) que sao persistentes na visualizacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Area de trabalho (grid + botoes de selecao)
    *--------------------------------------------------------------------------
    * Equivale a "Page2 (Dados)" dos forms CRUD. Neste form plano monta a
    * grade principal (grd_4c_Dados exibindo cursor_4c_Total) e os botoes
    * auxiliares cmd_4c_SelTudo/cmd_4c_Apaga que operam sobre o cursor de
    * destinatarios.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarGrade()
        THIS.ConfigurarSelecaoBotoes()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
    *--------------------------------------------------------------------------
    * Metodo mantido para atender contrato arquitetural do pipeline (Fase 4).
    * Forms OPERACIONAIS como SIGPREML nao possuem PageFrame Lista/Dados:
    * o layout completo eh persistente (cabecalho + grid + botoes de acao) e a
    * interacao acontece via botoes flutuantes sobre o grid. O parametro eh
    * ignorado e o metodo retorna sem efeito.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        *-- Shape decorativo (Shape1 do legado)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = -2
            .Left          = 819
            .Height        = 84
            .Width         = 84
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Botao Enviar Email (btnEmail do legado) - standalone com icone 60px
        THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
        WITH THIS.cmd_4c_BtnEmail
            .Top         = 5
            .Left        = 848
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
            .Caption     = "Enviar Email"
            .ToolTipText = "Enviar Email"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH

        *-- Container canonico Encerrar (padrao novo sistema, Left=917)
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = -2
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BorderWidth = 0
            .BackStyle   = 0
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top         = 5
                .Left        = 917
                .Height      = 75
                .Width       = 90
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Cancel      = .T.
                .Caption     = "Encerrar"
                .ToolTipText = "[Esc] Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSelecaoBotoes
    *==========================================================================
        *-- Botao Marcar Todos (SelTudo do legado)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 90
            .Left        = 4
            .Height      = 40
            .Width       = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Marcar Todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH

        *-- Botao Desmarcar Todos (apaga do legado)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 90
            .Left        = 43
            .Height      = 40
            .Width       = 40
            .FontBold    = .F.
            .FontItalic  = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Desmarcar Todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
    *==========================================================================
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                  = 132
            .Left                 = 3
            .Width                = 993
            .Height               = 435
            .RecordMark           = .F.
            .DeleteMark           = .F.
            .RowHeight            = 18
            .FontName             = "Verdana"
            .FontSize             = 8
            .ForeColor            = RGB(90, 90, 90)
            .BackColor            = RGB(255, 255, 255)
            .GridLineColor        = RGB(238, 238, 238)
            .HighlightStyle       = 2
            .HighlightBackColor   = RGB(255, 255, 255)
            .HighlightForeColor   = RGB(15, 41, 104)
            .AllowAutoColumnFit   = 2
            .GridLines            = 2
            .ColumnCount          = 5

            *-- Column1: Checkbox Checks (ColumnOrder=1 exibido a esquerda)
            *-- Ordem obrigatoria: AddObject -> CurrentControl -> Sparse -> ControlSource (Erro 1767)
            WITH .Column1
                .ColumnOrder   = 1
                .Width         = 17
                .ReadOnly      = .F.
                WITH .Header1
                    .Caption  = ""
                    .FontName = "Verdana"
                    .FontSize = 8
                ENDWITH
                .AddObject("ctlCheckbox", "CheckBox")
                WITH .ctlCheckbox
                    .Caption   = ""
                    .Alignment = 0
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Value     = 0
                ENDWITH
                .CurrentControl = "ctlCheckbox"
                .Sparse        = .F.
                .ControlSource = "cursor_4c_Total.Checks"
            ENDWITH

            *-- Column2: Conta (ColumnOrder=2)
            WITH .Column2
                .ColumnOrder   = 2
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Total.Contas"
                WITH .Header1
                    .Caption   = " Conta"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackColor = RGB(192, 192, 192)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Verdana"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column3: Nome/Rclis (ColumnOrder=3) - ordenacao padrao inicial
            WITH .Column3
                .ColumnOrder   = 3
                .Width         = 290
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Total.Rclis"
                WITH .Header1
                    .Caption   = " Nome"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackColor = RGB(64, 128, 128)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Verdana"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column4: Email (ColumnOrder=4) - editavel para correcao
            WITH .Column4
                .ColumnOrder   = 4
                .Width         = 290
                .ReadOnly      = .F.
                .ControlSource = "cursor_4c_Total.emails"
                WITH .Header1
                    .Caption   = "Email"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackColor = RGB(192, 192, 192)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .F.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Verdana"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column5: Mensagem/EditBox (ColumnOrder=5, Sparse=.F. obrigatorio)
            WITH .Column5
                .ColumnOrder   = 5
                .Width         = 290
                .ReadOnly      = .T.
                .Sparse        = .F.
                .ControlSource = "cursor_4c_Total.mensagems"
                WITH .Header1
                    .Caption   = "Mensagem"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                ENDWITH
                .AddObject("ctlEditBox", "EditBox")
                WITH .ctlEditBox
                    .BorderStyle   = 0
                    .ReadOnly      = .T.
                    .SpecialEffect = 1
                    .FontName      = "Verdana"
                    .FontSize      = 8
                ENDWITH
                .CurrentControl = "ctlEditBox"
            ENDWITH

            *-- Ativar RecordSource por ultimo para evitar auto-binding prematuro
            .RecordSource = "cursor_4c_Total"

            *-- Redefinir ControlSource apos RecordSource para evitar auto-bind por ordem de campos
            .Column1.ControlSource = "cursor_4c_Total.Checks"
            .Column2.ControlSource = "cursor_4c_Total.Contas"
            .Column3.ControlSource = "cursor_4c_Total.Rclis"
            .Column4.ControlSource = "cursor_4c_Total.emails"
            .Column5.ControlSource = "cursor_4c_Total.mensagems"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
    *==========================================================================
        *-- Botoes de acao
        BINDEVENT(THIS.cmd_4c_BtnEmail,               "Click", THIS, "BtnEmailClick")
        BINDEVENT(THIS.cmd_4c_SelTudo,                "Click", THIS, "SelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga,                  "Click", THIS, "ApagaClick")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")

        *-- Cliques nos cabecalhos para ordenacao (Conta, Nome, Email)
        BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "Col2HeaderClick")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "Col3HeaderClick")
        BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "Col4HeaderClick")

        *-- Checkbox individual para marcar/desmarcar linha
        BINDEVENT(THIS.grd_4c_Dados.Column1.ctlCheckbox, "InteractiveChange", ;
                  THIS, "GrdChkInteractiveChange")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Form plano (sem PageFrame); nao ha containers
    * que devam permanecer ocultos, entao todos os controles ficam visiveis.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.RecursarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE RecursarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.RecursarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Handlers de eventos - PUBLIC (obrigatorio para BINDEVENT)
    *==========================================================================

    PROCEDURE BtnEmailClick()
        LOCAL loc_lOk
        loc_lOk = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lOk = THIS.this_oBusinessObject.EnviarEmails()
        ENDIF

        IF loc_lOk
            THIS.Release()
        ENDIF
    ENDPROC

    PROCEDURE SelTudoClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE ApagaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE EncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE Col2HeaderClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.OrdenarPorColuna("Contas")
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE Col3HeaderClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE Col4HeaderClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.OrdenarPorColuna("Emails")
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE GrdChkInteractiveChange()
        LOCAL loc_nValue
        IF USED("cursor_4c_Total")
            loc_nValue = THIS.grd_4c_Dados.Column1.ctlCheckbox.Value
            REPLACE Checks WITH loc_nValue IN cursor_4c_Total
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * Eventos CRUD - Contrato arquitetural do pipeline (Fase 7)
    *--------------------------------------------------------------------------
    * SIGPREML eh form OPERACIONAL de envio de alertas por email; nao ha
    * botoes CRUD (Incluir/Alterar/Excluir/Visualizar) na tela original. Os
    * handlers abaixo existem para atender o contrato de validacao do
    * pipeline e delegam para as acoes operacionais reais deste form. O
    * parametro cEscolha ("INSERIR"/"ALTERAR"/"EXCLUIR") recebido no Init
    * descreve o contexto que originou o alerta, nao gera botoes locais.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Contexto INSERIR do alerta -> disparar envio de email
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_cEscolha = "INSERIR"
        THIS.BtnEmailClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Contexto ALTERAR do alerta -> disparar envio de email
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.this_cEscolha = "ALTERAR"
        THIS.BtnEmailClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Reforca visualizacao da lista de destinatarios
    * carregada pelo BO (grid de emails/Rclis/Contas) sem enviar nada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF USED("cursor_4c_Total")
            SELECT cursor_4c_Total
            GO TOP
        ENDIF
        THIS.grd_4c_Dados.SetFocus()
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Contexto EXCLUIR do alerta: no fluxo operacional
    * equivale a limpar selecao (desmarcar destinatarios) via BO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.this_cEscolha = "EXCLUIR"
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Form OPERACIONAL: sem busca interativa
    *--------------------------------------------------------------------------
    * SIGPREML carrega destinatarios no Init via parametros recebidos.
    * "Buscar" equivale a reposicionar o grid no primeiro registro.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF USED("cursor_4c_Total")
            SELECT cursor_4c_Total
            GO TOP
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Alias de EncerrarClick (contrato arquitetural pipeline)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.EncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Form OPERACIONAL: "salvar" = enviar email
    *--------------------------------------------------------------------------
    * Nao ha operacao de salvar no sentido CRUD. O equivalente operacional
    * e o envio dos emails (BtnEmailClick), que registra o alerta em SigAlert
    * e fecha o form.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnEmailClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela sem enviar email e fecha o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.EncerrarClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Form OPERACIONAL: sem campos de edicao a mapear
    *--------------------------------------------------------------------------
    * Os parametros de operacao (EmpDopNums, Escolha) foram passados no Init
    * e estao em propriedades do form e do BO. Retorna .T. sem efeito.
    *==========================================================================
    PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Form OPERACIONAL: sem campos de formulario a preencher
    *--------------------------------------------------------------------------
    * Os dados de exibicao estao no cursor_4c_Total que alimenta o grid.
    * Nao ha TextBoxes/Labels a preencher a partir das propriedades do BO.
    *==========================================================================
    PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme contexto
    *--------------------------------------------------------------------------
    * Form OPERACIONAL: habilita o botao de envio de email apenas se ha
    * ao menos um destinatario carregado no grid.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lTemDados

        loc_lTemDados = USED("cursor_4c_Total") AND RECCOUNT("cursor_4c_Total") > 0

        IF PEMSTATUS(THIS, "cmd_4c_BtnEmail", 5)
            THIS.cmd_4c_BtnEmail.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Form OPERACIONAL: desmarca todos os destinatarios
    *--------------------------------------------------------------------------
    * Equivale ao botao "Desmarcar Todos". Mantem semantica de "limpar
    * selecao atual" sem fechar o form.
    *==========================================================================
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarLista - Reposiciona e atualiza exibicao do grid de destinatarios
    *--------------------------------------------------------------------------
    * Form OPERACIONAL: o cursor_4c_Total ja esta populado pelo CarregarDados
    * do BO chamado no InicializarForm. CarregarLista reposiciona o ponteiro
    * e atualiza o grid sem re-executar SQL.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Total")
                SELECT cursor_4c_Total
                GO TOP
                THIS.grd_4c_Dados.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro FormSigPrEml.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD a ajustar
    *--------------------------------------------------------------------------
    * SIGPREML tem um unico modo de operacao: exibir destinatarios e enviar
    * email. Nao ha alternancia de modos (LISTA/DADOS/INCLUIR/ALTERAR/
    * VISUALIZAR). Metodo mantido para contrato arquitetural do pipeline.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.EncerrarConexaoAlerta()
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEmlBO.prg):
*==============================================================================
* SigPrEmlBO.prg - Business Object para ALERTA - Email
* Herda de: BusinessBase
* Tabela principal: SigAlert (banco DB_ALERTA, conexao separada)
* Form origem: SIGPREML.SCX
*==============================================================================

DEFINE CLASS SigPrEmlBO AS BusinessBase

    *-- Identificacao da tabela
    this_cTabela          = "SigAlert"
    this_cCampoChave      = "pkchaves"

    *--------------------------------------------------------------------------
    * Parametros de operacao (populados pelo form antes de CarregarDados)
    *--------------------------------------------------------------------------

    *-- prDopes completo: Emp(3) + Dopes(20) + Numes(6) = 29 chars
    this_cEmpDopNums      = ""
    *-- Empresa extraida (Substr(EmpDopNums, 1, 3))
    this_cEmp             = ""
    *-- Operacao/Dopes extraida (Substr(EmpDopNums, 4, 20))
    this_cDopes           = ""
    *-- Numero do movimento (Substr(EmpDopNums, 24, 6))
    this_cNumes           = ""
    *-- Acao disparadora: "INSERIR" | "ALTERAR" | "EXCLUIR"
    this_cEscolha         = ""

    *--------------------------------------------------------------------------
    * Conexao dedicada ao banco DB_ALERTA
    *--------------------------------------------------------------------------
    this_nConnAlerta      = 0
    this_cBancoAlerta     = "DB_ALERTA"

    *--------------------------------------------------------------------------
    * Cursores gerenciados pelo BO
    *--------------------------------------------------------------------------

    *-- cursor_4c_Total: equivalente a crLocalTotal do legado
    *-- Estrutura: Checks N(1), grupos C(10), Contas C(10), Rclis C(30),
    *--            emails C(50), mensagems M, prioridade C(15),
    *--            EmpDopNums C(29), Acaos C(10)
    this_cCursorTotal     = "cursor_4c_Total"

    *-- cursor_4c_AlertaRec: espelho de SigAlert para estrutura de referencia
    this_cCursorAlerta    = "cursor_4c_AlertaRec"

    *-- cursor_4c_OpeBaixa: registros de operacoes de baixa a notificar
    this_cCursorOpeBaixa  = "cursor_4c_OpeBaixa"

    *--------------------------------------------------------------------------
    * Estado interno de envio e configuracao SMTP
    *--------------------------------------------------------------------------
    this_lEmailEnviado    = .F.
    this_cMsgEmailRetorno = ""
    this_lTemOpeBaixa     = .F.
    this_cEmailFrom       = ""
    this_cEmailServer     = ""
    this_cEmailSenha      = ""
    this_nEmailPorta      = 0

    *--------------------------------------------------------------------------
    * Propriedades de registro em SigAlert (linha unica) - suporte a CRUD
    *--------------------------------------------------------------------------
    this_cPkChaves        = ""
    this_cGrupos          = ""
    this_cContas          = ""
    this_cEmails          = ""
    this_cMensagems       = ""
    this_cPrioridade      = ""
    this_cAcaos           = ""
    this_tDtAlerts        = {}
    this_cMsg1s           = ""
    this_cUsuars          = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando tabela e estado base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigAlert"
            THIS.this_cCampoChave = "pkchaves"

            DODEFAULT(THIS.this_cTabela)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o nome do campo chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarConexaoAlerta - Cria conexao dedicada ao banco DB_ALERTA
    * Retorna .T. se conectou com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexaoAlerta()
        LOCAL loc_lSucesso, loc_nConn, loc_cConnStr

        loc_lSucesso = .F.

        TRY
            IF THIS.this_nConnAlerta > 0
                SQLDISCONNECT(THIS.this_nConnAlerta)
                THIS.this_nConnAlerta = 0
            ENDIF

            loc_cConnStr = "DRIVER={SQL Server};" + ;
                           "SERVER=192.168.15.101;" + ;
                           "DATABASE=" + THIS.this_cBancoAlerta + ";" + ;
                           "UID=4control;PWD=f2016jstcr%@;"

            loc_nConn = SQLSTRINGCONNECT(loc_cConnStr)

            IF loc_nConn > 0
                THIS.this_nConnAlerta = loc_nConn
                loc_lSucesso = .T.
            ELSE
                MsgErro("Imposs" + CHR(237) + "vel conectar ao banco " + ;
                        THIS.this_cBancoAlerta + ".", ;
                        "Conex" + CHR(227) + "o ALERTA")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.InicializarConexaoAlerta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EncerrarConexaoAlerta - Fecha conexao com banco DB_ALERTA
    *--------------------------------------------------------------------------
    PROCEDURE EncerrarConexaoAlerta()
        IF THIS.this_nConnAlerta > 0
            SQLDISCONNECT(THIS.this_nConnAlerta)
            THIS.this_nConnAlerta = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega cursor_4c_Total com destinatarios de alerta email
    * par_cEmpDopNums: Emp(3)+Dopes(20)+Numes(6) concatenado = 29 chars
    * par_cEscolha   : "INSERIR" | "ALTERAR" | "EXCLUIR"
    * par_laOpeBaixa : array de EmpDopNums de baixas (passar SPACE(1) se N/A)
    * Retorna .T. se carregamento bem-sucedido
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_cEmpDopNums, par_cEscolha, par_laOpeBaixa)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cDopes, loc_cSQL, loc_cFiltroAcao
        LOCAL loc_cDope, loc_cEDN, loc_x, loc_lnChecks
        LOCAL loc_lcGrupos, loc_lcContas, loc_lcRclis, loc_lcEmails

        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            *-- Extrair componentes de EmpDopNums
            THIS.this_cEmpDopNums = par_cEmpDopNums
            THIS.this_cEmp        = SUBSTR(par_cEmpDopNums, 1, 3)
            THIS.this_cDopes      = SUBSTR(par_cEmpDopNums, 4, 20)
            THIS.this_cNumes      = SUBSTR(par_cEmpDopNums, 24, 6)
            THIS.this_cEscolha    = par_cEscolha

            loc_cDopes = ALLTRIM(THIS.this_cDopes)

            *-- Criar cursor principal de destinatarios (= crLocalTotal do legado)
            IF USED(THIS.this_cCursorTotal)
                USE IN (THIS.this_cCursorTotal)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorTotal) ;
                (Checks N(1) NULL, grupos C(10) NULL, Contas C(10) NULL, ;
                 Rclis C(30) NULL, emails C(50) NULL, mensagems M NULL, ;
                 prioridade C(15) NULL, EmpDopNums C(29) NULL, Acaos C(10) NULL)
            SET NULL OFF

            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON Emails TAG Emails

            *-- Obter estrutura de SigAlert (banco ALERTA)
            IF THIS.this_nConnAlerta > 0
                IF USED(THIS.this_cCursorAlerta)
                    USE IN (THIS.this_cCursorAlerta)
                ENDIF
                loc_cSQL = "SELECT * FROM SigAlert WHERE 0 = 1"
                SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, THIS.this_cCursorAlerta)
            ENDIF

            *-- Buscar cabecalho do movimento (SigMvcab + SigCdCli)
            IF USED("cursor_4c_TmpMvCab")
                USE IN cursor_4c_TmpMvCab
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Jobs, b.Rclis, " + ;
                       "a.ObsCabMovs, a.Obses " + ;
                       "FROM SigMvcab a " + ;
                       "INNER JOIN SigCdCli b ON a.Jobs = b.Iclis " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMvCab") < 1
                MsgErro("Falha na conex" + CHR(227) + "o (TmpMvCab)." + ;
                        CHR(13) + "Favor reinicializar o processo.", "Erro")
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                SELECT cursor_4c_TmpMvCab
                GO TOP

                *-- Determinar filtro de acao para SigCdAle
                DO CASE
                CASE UPPER(ALLTRIM(par_cEscolha)) = "INSERIR"
                    loc_cFiltroAcao = "ALE.inserirs = 1"
                CASE UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR"
                    loc_cFiltroAcao = "ALE.alterars = 1"
                CASE UPPER(ALLTRIM(par_cEscolha)) = "EXCLUIR"
                    loc_cFiltroAcao = "ALE.excluirs = 1"
                OTHERWISE
                    loc_cFiltroAcao = "1 = 1"
                ENDCASE

                *-- Buscar alertas configurados para a operacao (SigCdAle + SigCdCli)
                IF USED("cursor_4c_LocalALE")
                    USE IN cursor_4c_LocalALE
                ENDIF

                loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, CLI.Rclis, " + ;
                           "CLI.emails, ALE.mensagems, " + ;
                           "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                           "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                           "ELSE 'NORMAL' END AS prioridade, " + ;
                           "ALE.datas, ALE.dtalts, ALE.pkchaves, " + ;
                           "ALE.priors, ALE.dopes, " + ;
                           EscaparSQL(par_cEmpDopNums) + " AS EmpDopNums " + ;
                           "FROM SigCdAle ALE " + ;
                           "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.IClis " + ;
                           "WHERE ALE.Dopes = " + EscaparSQL(ALLTRIM(loc_cDopes)) + ;
                           " AND " + loc_cFiltroAcao

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalALE") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (crLocalALE)." + ;
                            CHR(13) + "Favor reinicializar o processo.", "Erro")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Inicializar estado de operacoes de baixa
                THIS.this_lTemOpeBaixa = .F.
                IF USED(THIS.this_cCursorOpeBaixa)
                    USE IN (THIS.this_cCursorOpeBaixa)
                ENDIF

                *-- Processar array de baixas se fornecido como array valido
                IF TYPE("par_laOpeBaixa") = "A"
                    IF ALEN(par_laOpeBaixa) > 0 AND !EMPTY(par_laOpeBaixa(1))
                        loc_cDope = ""
                        loc_cEDN  = ""

                        FOR loc_x = 1 TO ALEN(par_laOpeBaixa)
                            IF !EMPTY(par_laOpeBaixa(loc_x))
                                loc_cDope = loc_cDope + ;
                                    IIF(EMPTY(loc_cDope), "(", ",") + ;
                                    "'" + ALLTRIM(SUBSTR(par_laOpeBaixa(loc_x), 4, 20)) + "'"
                                loc_cEDN = loc_cEDN + ;
                                    IIF(EMPTY(loc_cEDN), "(", ",") + ;
                                    "'" + ALLTRIM(par_laOpeBaixa(loc_x)) + "'"
                            ENDIF
                        NEXT

                        loc_cDope = IIF(EMPTY(loc_cDope), "", loc_cDope + ")")
                        loc_cEDN  = IIF(EMPTY(loc_cEDN),  "", loc_cEDN  + ")")

                        IF !EMPTY(loc_cDope)
                            THIS.this_lTemOpeBaixa = THIS.CarregarOpeBaixa( ;
                                loc_cDope, loc_cEDN, par_laOpeBaixa)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Popular cursor_4c_Total a partir de cursor_4c_LocalALE
                SELECT cursor_4c_LocalALE
                SCAN
                    IF USED("cursor_4c_TmpClJob")
                        USE IN cursor_4c_TmpClJob
                    ENDIF

                    loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_LocalALE.Contas))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpClJob") > 0
                        SELECT cursor_4c_TmpClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_TmpMvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_LocalALE
                                LOOP
                            ENDIF
                        ENDIF
                    ENDIF

                    INSERT INTO (THIS.this_cCursorTotal) ;
                        (Checks, grupos, Contas, Rclis, emails, mensagems, ;
                         prioridade, EmpDopNums, Acaos) ;
                        VALUES ;
                        (cursor_4c_LocalALE.Checks, cursor_4c_LocalALE.grupos, ;
                         cursor_4c_LocalALE.Contas, cursor_4c_LocalALE.Rclis, ;
                         cursor_4c_LocalALE.emails, ;
                         NVL(cursor_4c_LocalALE.mensagems, ""), ;
                         cursor_4c_LocalALE.prioridade, ;
                         par_cEmpDopNums, par_cEscolha)

                    SELECT cursor_4c_LocalALE
                ENDSCAN

                *-- Buscar destinatarios de grupos parametrizados em SigCdPam
                IF USED("cursor_4c_LocalPAM")
                    USE IN cursor_4c_LocalPAM
                ENDIF

                loc_cSQL = "SELECT 0 AS Checks, CLI.grupos, CLI.iclis AS Contas, " + ;
                           "CLI.rclis, CLI.emails, '' AS prioridade " + ;
                           "FROM SigCdPam PAM " + ;
                           "INNER JOIN SigCdCli CLI ON CLI.grupos = PAM.grpadats"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPAM") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdPam)." + ;
                            CHR(13) + "Favor reinicializar o processo.", "Erro")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Adicionar destinatarios PAM ao cursor principal (sem duplicar)
                SELECT cursor_4c_LocalPAM
                SCAN
                    IF USED("cursor_4c_TmpClJob")
                        USE IN cursor_4c_TmpClJob
                    ENDIF

                    loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_LocalPAM.Contas))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpClJob") > 0
                        SELECT cursor_4c_TmpClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_TmpMvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_LocalPAM
                                LOOP
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_lnChecks = cursor_4c_LocalPAM.Checks
                    loc_lcGrupos = ""
                    loc_lcContas = ALLTRIM(cursor_4c_LocalPAM.Contas)
                    loc_lcRclis  = ALLTRIM(cursor_4c_LocalPAM.Rclis)
                    loc_lcEmails = ALLTRIM(cursor_4c_LocalPAM.emails)

                    SELECT (THIS.this_cCursorTotal)
                    LOCATE FOR ALLTRIM(Contas) = loc_lcContas AND ;
                               ALLTRIM(Rclis)  = loc_lcRclis
                    IF EOF()
                        INSERT INTO (THIS.this_cCursorTotal) ;
                            (Checks, grupos, Contas, Rclis, emails, ;
                             EmpDopNums, Acaos, prioridade) ;
                            VALUES ;
                            (loc_lnChecks, loc_lcGrupos, loc_lcContas, loc_lcRclis, ;
                             loc_lcEmails, par_cEmpDopNums, par_cEscolha, "NORMAL")
                    ENDIF

                    SELECT cursor_4c_LocalPAM
                ENDSCAN

                *-- Ordenar por nome (Rclis) -- igual ao legado (column3.header1.Click)
                SELECT (THIS.this_cCursorTotal)
                SET ORDER TO TAG Rclis
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOpeBaixa - Carrega cursor_4c_OpeBaixa para notificacoes de baixa
    * par_cDope      : clausula IN com Dopes  ex: ('DOPExx','DOPEyy')
    * par_cEDN       : clausula IN com EmpDopNums completos
    * par_laOpeBaixa : array original para substituir EmpDopNums
    * Retorna .T. se carregou registros de baixa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarOpeBaixa(par_cDope, par_cEDN, par_laOpeBaixa)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_x
        LOCAL loc_lcContasBaixa, loc_lcDopesBaixa

        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            IF THIS.this_nConnAlerta <= 0
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, " + ;
                           "Numes, SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
                           "Msg1s AS Mensagems, 1 AS Checks " + ;
                           "FROM SigAlert " + ;
                           "WHERE EmpDopNums IN " + par_cEDN + ;
                           " AND Acaos = 'BAIXAR'"

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, ;
                           THIS.this_cCursorOpeBaixa) < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (crOpeBaixa)." + ;
                            CHR(13) + "Favor reinicializar o processo.", "Erro")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                IF RECCOUNT(THIS.this_cCursorOpeBaixa) > 0
                    *-- Enriquecer emails/prioridade das baixas via SigCdCli+SigCdAle
                    SELECT cursor_4c_OpeBaixa
                    SCAN
                        loc_lcContasBaixa = ALLTRIM(cursor_4c_OpeBaixa.Contas)
                        loc_lcDopesBaixa  = ALLTRIM(cursor_4c_OpeBaixa.Dopes)

                        IF USED("cursor_4c_TmpCli")
                            USE IN cursor_4c_TmpCli
                        ENDIF

                        loc_cSQL = "SELECT a.Emails, " + ;
                                   "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
                                   "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                                   "ELSE 'NORMAL' END AS prioridade, " + ;
                                   "b.mensagems " + ;
                                   "FROM SigCdCli a " + ;
                                   "INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
                                   "WHERE a.Iclis = " + EscaparSQL(loc_lcContasBaixa) + ;
                                   " AND b.Dopes = " + EscaparSQL(loc_lcDopesBaixa)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli") > 0
                            SELECT cursor_4c_TmpCli
                            GO TOP
                            IF !EOF()
                                SELECT cursor_4c_OpeBaixa
                                REPLACE emails     WITH cursor_4c_TmpCli.emails, ;
                                        prioridade WITH cursor_4c_TmpCli.prioridade, ;
                                        mensagems  WITH cursor_4c_TmpCli.mensagems
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_OpeBaixa
                    ENDSCAN

                    loc_lSucesso = .T.
                ELSE
                    *-- Nao achou em SigAlert: buscar via SigCdAle com baixas=1
                    IF USED(THIS.this_cCursorOpeBaixa)
                        USE IN (THIS.this_cCursorOpeBaixa)
                    ENDIF

                    loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
                               "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
                               "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                               "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                               "ELSE 'NORMAL' END AS prioridade, " + ;
                               "ALE.datas, ALE.dtalts, ALE.pkchaves, " + ;
                               "ALE.priors, ALE.dopes, " + ;
                               "SPACE(29) AS EmpDopNums, " + ;
                               EscaparSQL(THIS.this_cEscolha) + " AS Acaos " + ;
                               "FROM SigCdAle ALE " + ;
                               "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.Iclis " + ;
                               "WHERE ALE.Dopes IN " + par_cDope + ;
                               " AND ALE.baixas = 1"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, ;
                               THIS.this_cCursorOpeBaixa) < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (crOpeBaixa2)." + ;
                                CHR(13) + "Favor reinicializar o processo.", "Erro")
                    ELSE
                        *-- Atualizar EmpDopNums a partir do array de baixas
                        FOR loc_x = 1 TO ALEN(par_laOpeBaixa)
                            IF !EMPTY(par_laOpeBaixa(loc_x))
                                SELECT cursor_4c_OpeBaixa
                                GO TOP
                                REPLACE ALL EmpDopNums ;
                                    WITH ALLTRIM(par_laOpeBaixa(loc_x)) ;
                                    FOR ALLTRIM(Dopes) = ;
                                        ALLTRIM(SUBSTR(par_laOpeBaixa(loc_x), 4, 20))
                            ENDIF
                        NEXT

                        loc_lSucesso = RECCOUNT(THIS.this_cCursorOpeBaixa) > 0
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.CarregarOpeBaixa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfigEmail - Busca dados SMTP de SigCdEmp para this_cEmp
    * Retorna .T. se encontrou configuracao de email
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarConfigEmail()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalEmp")
                USE IN cursor_4c_LocalEmp
            ENDIF

            loc_cSQL = "SELECT AleServs, AleEmails, AleSenhas, AlePortas " + ;
                       "FROM SigCdEmp WHERE CEmps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmp))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp") < 1
                MsgErro("Falha na conex" + CHR(227) + "o (LocalEmp)." + ;
                        CHR(13) + "Favor reinicializar o processo.", "Erro")
            ELSE
                SELECT cursor_4c_LocalEmp
                GO TOP

                IF !EOF()
                    THIS.this_cEmailFrom   = ALLTRIM(cursor_4c_LocalEmp.AleEmails)
                    THIS.this_cEmailServer = ALLTRIM(cursor_4c_LocalEmp.AleServs)
                    THIS.this_cEmailSenha  = ALLTRIM(cursor_4c_LocalEmp.AleSenhas)
                    THIS.this_nEmailPorta  = cursor_4c_LocalEmp.AlePortas
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.CarregarConfigEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ComposeCorpoEmail - Monta corpo do email a partir dos dados do movimento
    * par_cEmpDopNums : EmpDopNums do registro destinatario
    * par_cMensagem   : Mensagem customizada do alerta
    * par_cPrioridade : Prioridade do alerta
    * par_lEhBaixa    : .T. se este email e notificacao de baixa/cancelamento
    * par_cEmpDopBaixa: EmpDopNums do movimento baixado (apenas se par_lEhBaixa)
    * Retorna string com corpo formatado do email
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ComposeCorpoEmail(par_cEmpDopNums, par_cMensagem, ;
                                          par_cPrioridade, par_lEhBaixa, ;
                                          par_cEmpDopBaixa)
        LOCAL loc_cCorpo, loc_cJob, loc_cDescritivo, loc_cObses, loc_cRclisMov

        loc_cCorpo = ""

        TRY
            SELECT cursor_4c_TmpMvCab
            GO TOP

            loc_cJob        = ""
            loc_cDescritivo = ""
            loc_cObses      = ""
            loc_cRclisMov   = ""

            IF !EOF()
                loc_cJob        = ALLTRIM(cursor_4c_TmpMvCab.Jobs)
                loc_cDescritivo = ALLTRIM(cursor_4c_TmpMvCab.ObsCabMovs)
                loc_cObses      = ALLTRIM(cursor_4c_TmpMvCab.Obses)
                loc_cRclisMov   = ALLTRIM(cursor_4c_TmpMvCab.Rclis)
            ENDIF

            IF !EMPTY(loc_cJob)
                loc_cCorpo = "JOB          : " + loc_cJob + ;
                             " - " + loc_cRclisMov + CHR(13) + CHR(10)
            ENDIF

            IF !EMPTY(loc_cDescritivo)
                loc_cCorpo = loc_cCorpo + ;
                             "Descritivo : " + loc_cDescritivo + CHR(13) + CHR(10)
            ENDIF

            loc_cCorpo = loc_cCorpo + ;
                         "Movimenta" + CHR(231) + CHR(227) + "o : " + ;
                         SUBSTR(par_cEmpDopNums, 1, 3) + " / " + ;
                         SUBSTR(par_cEmpDopNums, 4, 20) + " / " + ;
                         SUBSTR(par_cEmpDopNums, 24, 6) + CHR(13) + CHR(10)

            loc_cCorpo = loc_cCorpo + ;
                         "A" + CHR(231) + CHR(227) + "o         : " + ;
                         ALLTRIM(THIS.this_cEscolha) + CHR(13) + CHR(10)

            IF par_lEhBaixa
                loc_cCorpo = loc_cCorpo + ;
                             "Movimenta" + CHR(231) + CHR(227) + "o baixada " + ;
                             IIF(UPPER(ALLTRIM(THIS.this_cEscolha)) = "EXCLUIR", ;
                                 "cancelada", "") + ": " + ;
                             SUBSTR(par_cEmpDopBaixa, 1, 3) + " / " + ;
                             SUBSTR(par_cEmpDopBaixa, 4, 20) + " / " + ;
                             SUBSTR(par_cEmpDopBaixa, 24, 6) + CHR(13) + CHR(10)
            ENDIF

            loc_cCorpo = loc_cCorpo + ;
                         "Usu" + CHR(225) + "rio      : " + ;
                         ALLTRIM(gc_4c_UsuarioLogado) + CHR(13) + CHR(10)
            loc_cCorpo = loc_cCorpo + ;
                         "Data         : " + TTOC(DATETIME()) + CHR(13) + CHR(10)

            IF !EMPTY(ALLTRIM(par_cMensagem))
                loc_cCorpo = loc_cCorpo + ;
                             "Mensagem     : " + ALLTRIM(par_cMensagem) + ;
                             CHR(13) + CHR(10)
            ENDIF

            IF !EMPTY(loc_cObses)
                loc_cCorpo = loc_cCorpo + ;
                             "Observa" + CHR(231) + CHR(227) + "o   : " + loc_cObses
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.ComposeCorpoEmail")
        ENDTRY

        RETURN loc_cCorpo
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEmailNoAlerta - Insere registro de email enviado em SigAlert
    * par_cContas    : Codigo da conta destinataria
    * par_cEmails    : Endereco de email
    * par_cMensagem  : Mensagem do alerta (campo mensagems)
    * par_cPrioridade: Prioridade do alerta
    * par_cEmpDopNums: EmpDopNums do movimento
    * par_cTextMsg   : Corpo completo do email composto
    * par_cAcao      : Acao: this_cEscolha ou "BAIXAR"
    * Retorna .T. se inseriu com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEmailNoAlerta(par_cContas, par_cEmails, ;
                                                par_cMensagem, par_cPrioridade, ;
                                                par_cEmpDopNums, par_cTextMsg, ;
                                                par_cAcao)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.this_nConnAlerta > 0
                loc_cSQL = "INSERT INTO SigAlert " + ;
                           "(pkchaves, Emps, Dopes, Numes, Grupos, Contas, " + ;
                           "usualerts, msg2s, priors, EmpDopNums, Acaos, " + ;
                           "DtAlerts, msg1s, Usuars) VALUES (" + ;
                           "CAST(NEWID() AS VARCHAR(36)), " + ;
                           EscaparSQL(LEFT(ALLTRIM(SUBSTR(par_cEmpDopNums, 1, 3)), 3)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(SUBSTR(par_cEmpDopNums, 4, 20)), 20)) + ", " + ;
                           TRANSFORM(VAL(ALLTRIM(SUBSTR(par_cEmpDopNums, 24, 6)))) + ", " + ;
                           "'', " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cContas), 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cEmails), 10)) + ", " + ;
                           EscaparSQL(ALLTRIM(par_cMensagem)) + ", " + ;
                           IIF(UPPER(ALLTRIM(par_cPrioridade))="URGENTE","1",IIF(UPPER(ALLTRIM(par_cPrioridade))="IMPORTANTE","2","0")) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cEmpDopNums), 29)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cAcao), 10)) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(par_cTextMsg) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + ")"

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) > 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao registrar email em SigAlert.", "Erro ALERTA")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.RegistrarEmailNoAlerta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmails - Envia emails para destinatarios marcados em cursor_4c_Total
    * e registra historico em SigAlert (banco ALERTA).
    * Retorna .T. se todos os emails foram enviados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmails()
        LOCAL loc_lSucesso, loc_llOk, loc_lPrimeiro
        LOCAL loc_lcReceptor, loc_lcReceptorCopia, loc_lcAssunto
        LOCAL loc_lcTxtMensagem, loc_lcArqAnexo, loc_lcTxtPrioridade
        LOCAL loc_lcEmpDopBaixa, loc_lcContasBaixa, loc_lcEmailsBaixa
        LOCAL loc_lcMensagemBaixa, loc_lcPrioridadeBaixa, loc_lcAcaoBaixa

        loc_lSucesso = .F.
        THIS.this_lEmailEnviado = .F.

        TRY
            IF !THIS.CarregarConfigEmail()
                *-- erro ja exibido em CarregarConfigEmail
            ELSE
                *-- Montar cursor com apenas os destinatarios selecionados (Checks = 1)
                IF USED("cursor_4c_Total2")
                    USE IN cursor_4c_Total2
                ENDIF

                SELECT * FROM (THIS.this_cCursorTotal) ;
                    WHERE Checks = 1 ;
                    INTO CURSOR cursor_4c_Total2 READWRITE

                SELECT cursor_4c_Total2

                IF RECCOUNT() = 0
                    MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + ;
                             CHR(13) + "Marque ao menos um e-mail para envio.", ;
                             "Alerta - Email")
                ELSE
                    *-- Iniciar transacao no banco ALERTA
                    IF THIS.this_nConnAlerta > 0
                        SQLEXEC(THIS.this_nConnAlerta, "BEGIN TRANSACTION")
                    ENDIF

                    loc_lcReceptor      = ""
                    loc_lcReceptorCopia = ""
                    loc_lcAssunto       = "ALERTA"
                    loc_lcTxtMensagem   = ""
                    loc_lcArqAnexo      = ""
                    loc_lcTxtPrioridade = "NORMAL"
                    loc_lPrimeiro       = .T.
                    loc_llOk            = .T.

                    SELECT cursor_4c_Total2
                    SCAN
                        IF loc_lPrimeiro
                            loc_lcReceptor      = ALLTRIM(cursor_4c_Total2.emails)
                            loc_lcTxtPrioridade = ALLTRIM(cursor_4c_Total2.prioridade)
                            loc_lcAssunto       = "ALERTA - " + loc_lcTxtPrioridade

                            loc_lcTxtMensagem = THIS.ComposeCorpoEmail( ;
                                cursor_4c_Total2.EmpDopNums, ;
                                NVL(cursor_4c_Total2.mensagems, ""), ;
                                cursor_4c_Total2.prioridade, ;
                                .F., "")

                            loc_lPrimeiro = .F.
                        ELSE
                            IF !EMPTY(ALLTRIM(cursor_4c_Total2.emails))
                                loc_lcReceptorCopia = loc_lcReceptorCopia + ;
                                    IIF(EMPTY(loc_lcReceptorCopia), "", ",") + ;
                                    ALLTRIM(cursor_4c_Total2.emails)
                            ENDIF
                        ENDIF

                        THIS.RegistrarEmailNoAlerta( ;
                            cursor_4c_Total2.Contas, ;
                            cursor_4c_Total2.emails, ;
                            NVL(cursor_4c_Total2.mensagems, ""), ;
                            cursor_4c_Total2.prioridade, ;
                            cursor_4c_Total2.EmpDopNums, ;
                            loc_lcTxtMensagem, ;
                            THIS.this_cEscolha)

                        SELECT cursor_4c_Total2
                    ENDSCAN

                    *-- Enviar email principal
                    WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR

                    IF !EnviaEmail(loc_lcReceptor, loc_lcTxtMensagem, ;
                                   loc_lcAssunto, loc_lcArqAnexo, ;
                                   THIS.this_cEmailFrom, loc_lcReceptorCopia, ;
                                   THIS.this_cEmailServer, THIS.this_cEmailSenha, ;
                                   THIS.this_nEmailPorta)
                        loc_llOk = .F.
                    ENDIF

                    WAIT CLEAR

                    *-- Processar emails de baixa (se existirem)
                    IF loc_llOk AND THIS.this_lTemOpeBaixa AND ;
                       USED(THIS.this_cCursorOpeBaixa) AND ;
                       RECCOUNT(THIS.this_cCursorOpeBaixa) > 0

                        loc_lcReceptor      = ""
                        loc_lcReceptorCopia = ""
                        loc_lcAssunto       = "ALERTA"
                        loc_lcTxtMensagem   = ""
                        loc_lPrimeiro       = .T.

                        SELECT cursor_4c_OpeBaixa
                        SCAN
                            loc_lcEmpDopBaixa   = cursor_4c_OpeBaixa.EmpDopNums
                            loc_lcContasBaixa   = ALLTRIM(cursor_4c_OpeBaixa.Contas)
                            loc_lcEmailsBaixa   = ALLTRIM(cursor_4c_OpeBaixa.emails)
                            loc_lcMensagemBaixa = NVL(cursor_4c_OpeBaixa.mensagems, "")
                            loc_lcPrioridadeBaixa = ALLTRIM(cursor_4c_OpeBaixa.prioridade)
                            loc_lcAcaoBaixa     = ALLTRIM(cursor_4c_OpeBaixa.Acaos)

                            IF loc_lPrimeiro
                                loc_lcReceptor      = loc_lcEmailsBaixa
                                loc_lcTxtPrioridade = loc_lcPrioridadeBaixa
                                loc_lcAssunto       = "ALERTA - " + loc_lcTxtPrioridade

                                loc_lcTxtMensagem = THIS.ComposeCorpoEmail( ;
                                    cursor_4c_TmpMvCab.EmpDopNums, ;
                                    loc_lcMensagemBaixa, ;
                                    loc_lcPrioridadeBaixa, ;
                                    .T., loc_lcEmpDopBaixa)

                                loc_lPrimeiro = .F.
                            ELSE
                                IF !EMPTY(loc_lcEmailsBaixa)
                                    loc_lcReceptorCopia = loc_lcReceptorCopia + ;
                                        IIF(EMPTY(loc_lcReceptorCopia), "", ",") + ;
                                        loc_lcEmailsBaixa
                                ENDIF
                            ENDIF

                            THIS.RegistrarEmailNoAlerta( ;
                                loc_lcContasBaixa, loc_lcEmailsBaixa, ;
                                loc_lcMensagemBaixa, loc_lcPrioridadeBaixa, ;
                                loc_lcEmpDopBaixa, loc_lcTxtMensagem, "BAIXAR")

                            SELECT cursor_4c_OpeBaixa
                        ENDSCAN

                        WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR

                        IF !EnviaEmail(loc_lcReceptor, loc_lcTxtMensagem, ;
                                       loc_lcAssunto, loc_lcArqAnexo, ;
                                       THIS.this_cEmailFrom, loc_lcReceptorCopia, ;
                                       THIS.this_cEmailServer, THIS.this_cEmailSenha, ;
                                       THIS.this_nEmailPorta)
                            loc_llOk = .F.
                        ENDIF

                        WAIT CLEAR
                    ENDIF

                    *-- Commit ou Rollback da transacao no banco ALERTA
                    IF THIS.this_nConnAlerta > 0
                        IF loc_llOk
                            SQLEXEC(THIS.this_nConnAlerta, "COMMIT")
                        ELSE
                            SQLEXEC(THIS.this_nConnAlerta, "ROLLBACK")
                            MsgErro("Erro ao enviar email." + ;
                                    CHR(13) + "Opera" + CHR(231) + CHR(227) + ;
                                    "o cancelada.", "Erro ALERTA")
                        ENDIF
                    ENDIF

                    THIS.this_lEmailEnviado = loc_llOk
                    loc_lSucesso = loc_llOk

                    IF loc_llOk
                        MsgInfo("Email enviado com sucesso!", "ALERTA")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF THIS.this_nConnAlerta > 0
                SQLEXEC(THIS.this_nConnAlerta, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.EnviarEmails")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os registros de cursor_4c_Total (Checks = 1)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorTotal)
            SELECT (THIS.this_cCursorTotal)
            GO TOP
            REPLACE ALL Checks WITH 1
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os registros de cursor_4c_Total (Checks = 0)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorTotal)
            SELECT (THIS.this_cCursorTotal)
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarPorColuna - Ordena cursor_4c_Total pelo tag solicitado
    * par_cTag: "Contas" | "Rclis" | "Emails"
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarPorColuna(par_cTag)
        IF USED(THIS.this_cCursorTotal)
            SELECT (THIS.this_cCursorTotal)
            DO CASE
            CASE UPPER(ALLTRIM(par_cTag)) = "CONTAS"
                SET ORDER TO TAG Contas
            CASE UPPER(ALLTRIM(par_cTag)) = "RCLIS"
                SET ORDER TO TAG Rclis
            CASE UPPER(ALLTRIM(par_cTag)) = "EMAILS"
                SET ORDER TO TAG Emails
            ENDCASE
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades this_* a partir de um cursor
    * espelho de SigAlert (usado para consulta pontual de registro por PK)
    * par_cAliasCursor: alias do cursor com uma linha de SigAlert
    * Retorna .T. se carregou os campos com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                THIS.this_cEmp        = TratarNulo(Emps,       "C")
                THIS.this_cDopes      = TratarNulo(Dopes,      "C")

                IF TYPE("Numes") = "N"
                    THIS.this_cNumes  = TRANSFORM(NVL(Numes, 0))
                ELSE
                    THIS.this_cNumes  = TratarNulo(Numes,      "C")
                ENDIF

                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cEmails     = TratarNulo(usualerts,  "C")
                THIS.this_cMensagems  = TratarNulo(msg2s,      "C")
                THIS.this_cPrioridade = IIF(NVL(priors,0)=1,"URGENTE",IIF(NVL(priors,0)=2,"IMPORTANTE","NORMAL"))
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                THIS.this_cAcaos      = TratarNulo(Acaos,      "C")

                IF TYPE("DtAlerts") = "T" OR TYPE("DtAlerts") = "D"
                    THIS.this_tDtAlerts = NVL(DtAlerts, {})
                ENDIF

                IF TYPE("msg1s") != "U"
                    THIS.this_cMsg1s  = TratarNulo(msg1s,      "C")
                ENDIF
                IF TYPE("Usuars") != "U"
                    THIS.this_cUsuars = TratarNulo(Usuars,     "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere uma nova linha em SigAlert (banco DB_ALERTA)
    * usando as propriedades this_* atualmente populadas no BO.
    * Se a conexao ao banco ALERTA nao estiver aberta, tenta abrir.
    * Retorna .T. se inseriu com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPk, loc_nNumes, loc_tData

        loc_lSucesso = .F.

        TRY
            IF THIS.this_nConnAlerta <= 0
                IF !THIS.InicializarConexaoAlerta()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            loc_cPk = ALLTRIM(THIS.this_cPkChaves)
            IF EMPTY(loc_cPk)
                loc_cPk = SYS(2015) + SYS(2015)
            ENDIF

            loc_nNumes = VAL(ALLTRIM(THIS.this_cNumes))
            loc_tData  = IIF(EMPTY(THIS.this_tDtAlerts), "GETDATE()", ;
                             FormatarDataSQL(THIS.this_tDtAlerts))

            loc_cSQL = "INSERT INTO SigAlert " + ;
                       "(pkchaves, Emps, Dopes, Numes, Grupos, Contas, " + ;
                       "usualerts, msg2s, priors, EmpDopNums, Acaos, " + ;
                       "DtAlerts, msg1s, Usuars) VALUES (" + ;
                       EscaparSQL(LEFT(loc_cPk, 36)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmp), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ", " + ;
                       FormatarNumeroSQL(loc_nNumes, 0) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmails), 10)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
                       IIF(UPPER(ALLTRIM(THIS.this_cPrioridade))="URGENTE","1",IIF(UPPER(ALLTRIM(THIS.this_cPrioridade))="IMPORTANTE","2","0")) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cAcaos), 10)) + ", " + ;
                       loc_tData + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMsg1s)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cUsuars, ;
                            gc_4c_UsuarioLogado)), 20)) + ")"

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) > 0
                THIS.this_cPkChaves = loc_cPk
                THIS.RegistrarAuditoria("INCLUSAO")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao inserir em SigAlert.", "Erro ALERTA")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza a linha corrente em SigAlert (banco DB_ALERTA)
    * identificada por this_cPkChaves. Retorna .T. se atualizou com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nNumes, loc_tData

        loc_lSucesso = .F.

        TRY
            IF THIS.this_nConnAlerta <= 0
                IF !THIS.InicializarConexaoAlerta()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgAviso("Chave prim" + CHR(225) + "ria n" + CHR(227) + ;
                         "o informada para atualiza" + CHR(231) + CHR(227) + "o.", ;
                         "Alerta - Email")
                loc_lSucesso = .F.
            ENDIF

            loc_nNumes = VAL(ALLTRIM(THIS.this_cNumes))
            loc_tData  = IIF(EMPTY(THIS.this_tDtAlerts), "GETDATE()", ;
                             FormatarDataSQL(THIS.this_tDtAlerts))

            loc_cSQL = "UPDATE SigAlert SET " + ;
                       "Emps = "       + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmp), 3))   + ", " + ;
                       "Dopes = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ", " + ;
                       "Numes = "      + FormatarNumeroSQL(loc_nNumes, 0) + ", " + ;
                       "Grupos = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
                       "Contas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + ", " + ;
                       "usualerts = "  + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmails), 10)) + ", " + ;
                       "msg2s = "      + EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
                       "priors = "     + IIF(UPPER(ALLTRIM(THIS.this_cPrioridade))="URGENTE","1",IIF(UPPER(ALLTRIM(THIS.this_cPrioridade))="IMPORTANTE","2","0")) + ", " + ;
                       "EmpDopNums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
                       "Acaos = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cAcaos), 10)) + ", " + ;
                       "DtAlerts = "   + loc_tData + ", " + ;
                       "msg1s = "      + EscaparSQL(ALLTRIM(THIS.this_cMsg1s)) + ", " + ;
                       "Usuars = "     + EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cUsuars, ;
                                            gc_4c_UsuarioLogado)), 20)) + " " + ;
                       "WHERE pkchaves = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ALTERACAO")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar em SigAlert.", "Erro ALERTA")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em SigPrEmlBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sobrescrita: SigAlert ja serve como historico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        *-- SigAlert ja armazena cada operacao como historico de alertas.
        *-- Auditoria complementar nao necessaria para esta tabela.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.EncerrarConexaoAlerta()

        IF USED(THIS.this_cCursorTotal)
            USE IN (THIS.this_cCursorTotal)
        ENDIF
        IF USED(THIS.this_cCursorAlerta)
            USE IN (THIS.this_cCursorAlerta)
        ENDIF
        IF USED(THIS.this_cCursorOpeBaixa)
            USE IN (THIS.this_cCursorOpeBaixa)
        ENDIF
        IF USED("cursor_4c_TmpMvCab")
            USE IN cursor_4c_TmpMvCab
        ENDIF
        IF USED("cursor_4c_LocalALE")
            USE IN cursor_4c_LocalALE
        ENDIF
        IF USED("cursor_4c_LocalPAM")
            USE IN cursor_4c_LocalPAM
        ENDIF
        IF USED("cursor_4c_Total2")
            USE IN cursor_4c_Total2
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


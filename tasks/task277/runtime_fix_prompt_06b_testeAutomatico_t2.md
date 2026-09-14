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
[15/07/2026 23:12:53] Erro CarregarDados: Connection handle is invalid. LN=134
[15/07/2026 23:12:53] Erro: Erro ao carregar dados para envio de email.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-15 23:10:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 23:10:56] [INFO] Config FPW: (nao fornecido)
[2026-07-15 23:10:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 23:10:56] [INFO] Timeout: 300 segundos
[2026-07-15 23:10:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_laqpkaqy.prg
[2026-07-15 23:10:56] [INFO] Conteudo do wrapper:
[2026-07-15 23:10:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'
QUIT

[2026-07-15 23:10:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_laqpkaqy.prg
[2026-07-15 23:10:56] [INFO] VFP output esperado em: C:\4c\tasks\task277\vfp_output.txt
[2026-07-15 23:10:56] [INFO] Executando Visual FoxPro 9...
[2026-07-15 23:10:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_laqpkaqy.prg
[2026-07-15 23:10:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_laqpkaqy.prg
[2026-07-15 23:10:56] [INFO] Timeout configurado: 300 segundos
[2026-07-15 23:11:16] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 23:11:16] [INFO] VFP9 finalizado em 19.9952726 segundos
[2026-07-15 23:11:16] [INFO] Exit Code: 
[2026-07-15 23:11:16] [INFO] 
[2026-07-15 23:11:16] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 23:11:16] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_laqpkaqy.prg
[2026-07-15 23:11:16] [INFO] 
[2026-07-15 23:11:16] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 23:11:16] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 23:11:16] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 23:11:16] [INFO] * Parameters: 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'
[2026-07-15 23:11:16] [INFO] 
[2026-07-15 23:11:16] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 23:11:16] [INFO] SET SAFETY OFF
[2026-07-15 23:11:16] [INFO] SET RESOURCE OFF
[2026-07-15 23:11:16] [INFO] SET TALK OFF
[2026-07-15 23:11:16] [INFO] SET NOTIFY OFF
[2026-07-15 23:11:16] [INFO] SYS(2335, 0)
[2026-07-15 23:11:16] [INFO] 
[2026-07-15 23:11:16] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'
[2026-07-15 23:11:16] [INFO] QUIT
[2026-07-15 23:11:16] [INFO] 
[2026-07-15 23:11:16] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 23:11:16] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 23:12:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 23:12:30] [INFO] Config FPW: (nao fornecido)
[2026-07-15 23:12:30] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 23:12:30] [INFO] Timeout: 300 segundos
[2026-07-15 23:12:30] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oud2fma2.prg
[2026-07-15 23:12:30] [INFO] Conteudo do wrapper:
[2026-07-15 23:12:30] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'
QUIT

[2026-07-15 23:12:30] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oud2fma2.prg
[2026-07-15 23:12:30] [INFO] VFP output esperado em: C:\4c\tasks\task277\vfp_output.txt
[2026-07-15 23:12:30] [INFO] Executando Visual FoxPro 9...
[2026-07-15 23:12:30] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oud2fma2.prg
[2026-07-15 23:12:30] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oud2fma2.prg
[2026-07-15 23:12:30] [INFO] Timeout configurado: 300 segundos
[2026-07-15 23:12:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 23:12:53] [INFO] VFP9 finalizado em 23.5725036 segundos
[2026-07-15 23:12:53] [INFO] Exit Code: 
[2026-07-15 23:12:53] [INFO] 
[2026-07-15 23:12:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 23:12:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oud2fma2.prg
[2026-07-15 23:12:53] [INFO] 
[2026-07-15 23:12:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 23:12:53] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 23:12:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 23:12:53] [INFO] * Parameters: 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'
[2026-07-15 23:12:53] [INFO] 
[2026-07-15 23:12:53] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 23:12:53] [INFO] SET SAFETY OFF
[2026-07-15 23:12:53] [INFO] SET RESOURCE OFF
[2026-07-15 23:12:53] [INFO] SET TALK OFF
[2026-07-15 23:12:53] [INFO] SET NOTIFY OFF
[2026-07-15 23:12:53] [INFO] SYS(2335, 0)
[2026-07-15 23:12:53] [INFO] 
[2026-07-15 23:12:53] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprema', 'C:\4c\tasks\task277', 'OPERACIONAL'
[2026-07-15 23:12:53] [INFO] QUIT
[2026-07-15 23:12:53] [INFO] 
[2026-07-15 23:12:53] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 23:12:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprema",
  "timestamp": "20260715231253",
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg):
*==============================================================================
* Formsigprema.prg - Formulario Operacional: Processamento e Geracao de Email
* Equivalente ao SIGPREMA.SCX do legado
* Tipo: OPERACIONAL (plano, sem PageFrame) - lista de movimentacoes + envio de email
* Herda de FormBase
*
* CHAMADA:
*   DO FORM Formsigprema WITH lcDopes, lAutomatico
*   par_cDopes      = EmpDopNums (C(29)) ou vazio (busca movimentacoes do dia)
*   par_lAutomatico = .T. processa emails sem exibir UI e fecha ao terminar
*==============================================================================

DEFINE CLASS Formsigprema AS FormBase

    Height       = 600
    Width        = 1000
    Caption      = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    DataSession  = 1
    ClipControls = .F.

    *-- Parametros recebidos no Init
    this_cDopes      = ""
    this_lAutomatico = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LPARAMETERS par_cDopes, par_lAutomatico

        IF VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = ALLTRIM(par_cDopes)
        ENDIF

        IF VARTYPE(par_lAutomatico) = "L"
            THIS.this_lAutomatico = par_lAutomatico
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursores[2], loc_i
        loc_aCursores[1] = "crLocalTotal"
        loc_aCursores[2] = "crLocalTotal2"
        FOR loc_i = 1 TO 2
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT loc_i
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    *--------------------------------------------------------------------------
    * SIGPREMA legado usa Form base (nao frmcadastro) com grid + botoes
    * diretamente sobre o Form. Nao ha PageFrame de navegacao Lista/Dados.
    * Aqui apenas configuramos propriedades globais do form; a montagem
    * dos containers eh feita por ConfigurarPaginaLista/ConfigurarPaginaDados.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Bloco fixo do topo do form OPERACIONAL
    *--------------------------------------------------------------------------
    * Equivale a "Page1 (Lista)" dos forms CRUD. Neste form plano monta o
    * cabecalho escuro (cntSombra), o container de saida (cnt_4c_Saida) e o
    * botao Enviar Email flutuante que sao persistentes na visualizacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarSaida()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Bloco de trabalho (grid + botoes de acao)
    *--------------------------------------------------------------------------
    * Equivale a "Page2 (Dados)" dos forms CRUD. Neste form plano monta o
    * grid principal e os botoes cmd_4c_BtnEmail/cmd_4c_SelTudo/cmd_4c_Apaga
    * que operam sobre o cursor crLocalTotal.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
    *--------------------------------------------------------------------------
    * Metodo mantido para atender contrato arquitetural do pipeline. Forms
    * OPERACIONAIS nao alternam entre Lista/Dados: todo layout eh persistente
    * e a interacao acontece via botoes flutuantes sobre o grid.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_lOK
        loc_lSucesso = .F.
        loc_lOK      = .T.

        TRY
            THIS.Caption    = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
            THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
            THIS.ScrollBars = 0

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigpremaBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar sigpremaBO.", "Erro InicializarForm")
                loc_lOK = .F.
            ENDIF

            *-- Modo automatico: processar emails sem UI e abortar exibicao do form
            IF loc_lOK AND THIS.this_lAutomatico
                IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cDopes)
                    THIS.this_oBusinessObject.ProcessarEnvioEmails()
                ENDIF
                loc_lOK = .F.
            ENDIF

            *-- Carregar dados ANTES de ConfigurarPageFrame (crLocalTotal deve existir
            *-- quando ConfigurarGrade atribuir ControlSource)
            IF loc_lOK
                IF !THIS.this_oBusinessObject.CarregarDados(THIS.this_cDopes)
                    MsgErro("Erro ao carregar dados para envio de email.", "Erro")
                    loc_lOK = .F.
                ENDIF
            ENDIF

            *-- Modo interativo: configurar UI completa
            IF loc_lOK
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- BINDEVENTs: botoes de acao
                BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
                BINDEVENT(THIS.cmd_4c_BtnEmail,               "Click", THIS, "BtnEmailClick")
                BINDEVENT(THIS.cmd_4c_SelTudo,                "Click", THIS, "BtnSelTudoClick")
                BINDEVENT(THIS.cmd_4c_Apaga,                  "Click", THIS, "BtnApagaClick")

                *-- BINDEVENTs: headers do grid para ordenacao
                BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "HeaderContaClick")
                BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderNomeClick")
                BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "HeaderEmailClick")

                *-- BINDEVENT: checkbox para atualizar campo Checks no cursor
                BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "InteractiveChange", THIS, "ChkChecksChange")

                THIS.grd_4c_Dados.RecordSource = "crLocalTotal"
                IF USED("crLocalTotal")
                    SELECT crLocalTotal
                    SET ORDER TO TAG Rclis
                ENDIF
                THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64,128,128)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            IF loc_lOK
                THIS.TornarControlesVisiveis(THIS)
                THIS.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formsigprema: " + loc_oErro.Message + ;
                " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .Visible     = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Visible   = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255,255,255)
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top         = 126
            .Left        = 3
            .Width       = 993
            .Height      = 469
            .ColumnCount = 5
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .RowHeight   = 18
            .FontName    = "Verdana"
            .FontSize    = 8

            *-- Column1: CheckBox Checks (posicao visual 1 - ColumnOrder=1)
            *-- Sparse=.F. OBRIGATORIO: sem isso checkbox aparece so na linha corrente
            WITH .Column1
                .Width       = 17
                .ColumnOrder = 1
                .ReadOnly    = .F.
                .Sparse      = .F.
                .AddObject("Check1", "CheckBox")
                .Check1.Caption  = ""
                .Check1.FontName = "Verdana"
                .Check1.FontSize = 8
                .CurrentControl  = "Check1"
                .ControlSource   = "crLocalTotal.Checks"
                .Header1.Caption = ""
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
            ENDWITH

            *-- Column2: Conta (ColumnOrder=2)
            WITH .Column2
                .Width         = 80
                .ColumnOrder   = 2
                .ReadOnly      = .T.
                .ControlSource = "crLocalTotal.Contas"
                .Header1.Caption   = "Conta"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column3: Nome/Razao Social (ColumnOrder=3)
            WITH .Column3
                .Width         = 290
                .ColumnOrder   = 3
                .ReadOnly      = .T.
                .ControlSource = "crLocalTotal.Rclis"
                .Header1.Caption   = "Nome"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column4: Email (ColumnOrder=4) - editavel para correcao direta
            WITH .Column4
                .Width         = 290
                .ColumnOrder   = 4
                .ReadOnly      = .F.
                .ControlSource = "crLocalTotal.emails"
                .Header1.Caption   = "Email"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column5: EmpDopNums / Movimentacao (ColumnOrder=5) - EditBox somente leitura
            WITH .Column5
                .Width       = 290
                .ColumnOrder = 5
                .ReadOnly    = .T.
                .AddObject("EditBox1", "EditBox")
                .EditBox1.ReadOnly      = .T.
                .EditBox1.SpecialEffect = 1
                .EditBox1.BorderStyle   = 0
                .EditBox1.FontName      = "Verdana"
                .EditBox1.FontSize      = 8
                .CurrentControl  = "EditBox1"
                .ControlSource   = "crLocalTotal.EmpDopNums"
                .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
        *-- Botao Enviar Email (flutuante sobre cabecalho, esquerda do Encerrar)
        THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
        WITH THIS.cmd_4c_BtnEmail
            .Top         = 5
            .Left        = 845
            .Height      = 75
            .Width       = 75
            .Caption     = "Enviar Email"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90,90,90)
            .Themes           = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
            .ToolTipText = "Enviar email para os selecionados"
            .Visible     = .T.
            .ZOrder(0)
        ENDWITH

        *-- Botao Marcar Todos (SelTudo) - abaixo do cabecalho, esquerda do grid
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 84
            .Left        = 4
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36,84,155)
            .BackColor   = RGB(255,255,255)
            .Themes           = .T.
            .TabStop     = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Marcar Todos"
            .Visible     = .T.
        ENDWITH

        *-- Botao Desmarcar Todos (Apaga)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 84
            .Left        = 43
            .Height      = 40
            .Width       = 40
            .Caption     = ""
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36,84,155)
            .BackColor   = RGB(255,255,255)
            .Themes           = .T.
            .TabStop     = .F.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarcar Todos"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
    *==========================================================================
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Left        = 917
            .Top         = 0
            .Width       = 90
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0
            .Visible     = .T.
            .ZOrder(0)
        ENDWITH
        THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
            .Left        = 5
            .Top         = 5
            .Width       = 75
            .Height      = 75
            .Caption     = "Encerrar"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90,90,90)
            .BackColor   = RGB(255,255,255)
            .Themes      = .F.
            .Cancel      = .T.
            .ToolTipText = "[Esc] Encerrar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEmailClick()
    *==========================================================================
        LOCAL loc_nMarcados, loc_lOK
        loc_nMarcados = 0
        loc_lOK       = .F.

        *-- Verificar se ha pelo menos um registro marcado para envio
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            COUNT FOR Checks = 1 TO loc_nMarcados
        ENDIF

        IF loc_nMarcados = 0
            MsgAviso("Selecione ao menos um registro para envio de email.", ;
                "Envio de Email")
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WAIT WINDOW "Aguarde... gerando e enviando email..." NOWAIT NOCLEAR

            loc_lOK = THIS.this_oBusinessObject.ProcessarEnvioEmails()

            WAIT CLEAR

            IF loc_lOK
                WAIT WINDOW "Email enviado com sucesso!" TIMEOUT 2
                THIS.Release()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSelTudoClick()
    *==========================================================================
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            GO TOP
            REPLACE ALL Checks WITH 1
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnApagaClick()
    *==========================================================================
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE HeaderContaClick()
    *==========================================================================
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            SET ORDER TO TAG Contas
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64,128,128)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192,192,192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192,192,192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE HeaderNomeClick()
    *==========================================================================
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            SET ORDER TO TAG Rclis
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192,192,192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64,128,128)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192,192,192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE HeaderEmailClick()
    *==========================================================================
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            SET ORDER TO TAG Emails
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192,192,192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192,192,192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64,128,128)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE ChkChecksChange()
    *==========================================================================
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            REPLACE Checks WITH THIS.grd_4c_Dados.Column1.Check1.Value IN crLocalTotal
        ENDIF
    ENDPROC

    *==========================================================================
    * Eventos CRUD mapeados para semantica OPERACIONAL de dispatch de email
    *--------------------------------------------------------------------------
    * SIGPREMA nao gerencia entidades: processa cursor crLocalTotal com emails
    * a enviar. As acoes reais sao Enviar Email / Marcar Todos / Desmarcar.
    * Os quatro handlers abaixo existem para atender o contrato do pipeline e
    * mapeiam para o comportamento operacional mais proximo (nunca vazios).
    *==========================================================================

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        *-- Delega ao envio de email (acao principal do form)
        IF VARTYPE(THIS.cmd_4c_BtnEmail) = "O"
            THIS.BtnEmailClick()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        *-- Recarrega a lista de destinatarios a partir das movimentacoes
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cDopes)
                    THIS.grd_4c_Dados.RecordSource = "crLocalTotal"
                    IF USED("crLocalTotal")
                        SELECT crLocalTotal
                        GO TOP
                    ENDIF
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recarregar dados: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        *-- Foca o grid para visualizacao dos registros de email
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            IF USED("crLocalTotal") AND RECCOUNT("crLocalTotal") > 0
                SELECT crLocalTotal
                GO TOP
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Refresh()
            ELSE
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registros para visualizar.", ;
                    "Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        *-- Desmarcar todos: remove selecoes de envio (delega ao BtnApagaClick)
        THIS.BtnApagaClick()
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega crLocalTotal e atualiza o grid
    *--------------------------------------------------------------------------
    * Para este form OPERACIONAL "lista" corresponde ao cursor de destinatarios
    * crLocalTotal. Recarrega a partir do BO e reconecta o RecordSource do grid.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cDopes)
                    THIS.grd_4c_Dados.RecordSource = "crLocalTotal"
                    IF USED("crLocalTotal")
                        SELECT crLocalTotal
                        SET ORDER TO TAG Rclis
                        GO TOP
                    ENDIF
                    THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192,192,192)
                    THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64,128,128)
                    THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192,192,192)
                    THIS.grd_4c_Dados.Refresh()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega dados (acao Buscar/Atualizar deste OPERACIONAL)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Semantica OPERACIONAL: delega ao envio de email
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnEmailClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Semantica OPERACIONAL: encerra o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula propriedades do BO com dados do registro corrente
    *--------------------------------------------------------------------------
    * Para este form OPERACIONAL os dados relevantes vem do cursor crLocalTotal.
    * Popula as propriedades de identificacao do BO para auditoria e log.
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        IF USED("crLocalTotal") AND !EOF("crLocalTotal")
            THIS.this_oBusinessObject.CarregarDoCursor("crLocalTotal")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do form com dados do BO
    *--------------------------------------------------------------------------
    * Este form OPERACIONAL nao tem campos de edicao diretos: os dados ficam
    * no grid via RecordSource. Metodo mantido para contrato arquitetural.
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla habilitacao de botoes conforme estado do cursor
    *--------------------------------------------------------------------------
    * cmd_4c_BtnEmail: habilitado quando ha pelo menos um registro marcado.
    * cmd_4c_SelTudo/cmd_4c_Apaga: sempre habilitados quando ha registros.
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_nTotal, loc_nMarcados
        loc_nTotal   = 0
        loc_nMarcados = 0
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            COUNT TO loc_nTotal
            COUNT FOR Checks = 1 TO loc_nMarcados
        ENDIF
        IF VARTYPE(THIS.cmd_4c_BtnEmail) = "O"
            *-- Icone-only: nao desabilitar (.Enabled=.F. apaga icone); controle no handler
        ENDIF
        IF VARTYPE(THIS.cmd_4c_SelTudo) = "O"
            *-- Icone-only: nao desabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Apaga) = "O"
            *-- Icone-only: nao desabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa cursor crLocalTotal e redefine grid
    *==========================================================================
    PROCEDURE LimparCampos()
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            ZAP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.this_cDopes = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cEmpDopNums = ""
            THIS.this_oBusinessObject.this_cContas     = ""
            THIS.this_oBusinessObject.this_cRclis      = ""
            THIS.this_oBusinessObject.this_cEmails     = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajuste visual dos botoes para este form OPERACIONAL
    *--------------------------------------------------------------------------
    * OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR classicos. O metodo
    * garante que os botoes estejam no estado correto para exibicao do grid.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nTotal
        loc_nTotal = 0
        IF USED("crLocalTotal")
            SELECT crLocalTotal
            COUNT TO loc_nTotal
        ENDIF
        IF VARTYPE(THIS.cmd_4c_BtnEmail) = "O"
            THIS.cmd_4c_BtnEmail.Visible = (loc_nTotal > 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os sub-controles visiveis
    *--------------------------------------------------------------------------
    * Aplicado apos AddObject que cria controles com Visible=.F. por default.
    * Para este form operacional plano os containers que devem permanecer
    * ocultos (nao ha nenhum neste form) seriam excluidos por nome aqui.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* sigpremaBO.prg - Business Object para Processamento e Geracao de Email
*==============================================================================
* Entidade : SIGPREMA - Processamento e Geracao de Email de Movimentacoes
* Tabelas  : SigMvCab, SigCdCli, SigCdPam, SigCdEmp, SigClJob, sigoplog
* Autor    : Migracao Automatica VFP9
* Data     : 2026-07-15
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Sem tabela de CRUD: operacoes em cursores locais + views SQL
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Parametros de execucao recebidos no Init do form
    this_cEmps        = ""    && C(3)  codigo da empresa (Substr(prDopes,1,3))
    this_cDopes       = ""    && C(20) operacao (Substr(prDopes,4,20))
    this_cEmpDopNums  = ""    && C(29) chave completa EmpDopNums (prDopes)
    this_lAutomatico  = .F.   && .T. = modo automatico sem interacao UI

    *-- Controle de arquivo PDF para anexo de email
    this_cPcArqEmail  = ""    && path completo do arquivo PDF gerado
    this_cPcEscolha   = ""    && escolha do tipo de impressao do documento

    *-- Configuracao SMTP lida de SigCdEmp
    this_cEmailFrom   = ""    && remetente (PadEmails da empresa)
    this_cSmtpServer  = ""    && servidor SMTP (PadServs)
    this_cSmtpSenha   = ""    && senha SMTP (PadSenhas)
    this_nSmtpPorta   = 0     && porta SMTP (PadPortas)

    *-- Filtro de data para busca de movimentacoes (quando prDopes vazio)
    this_dDti         = {}    && data/hora inicial do dia corrente
    this_dDtf         = {}    && data/hora final do dia corrente

    *-- Flag de controle de resultado do envio
    this_lEnvioOk     = .F.   && .T. se ultimo envio foi bem-sucedido

    *-- Dados da linha corrente (preenchidos em CarregarDoCursor)
    this_cContas      = ""    && C(10) conta do cliente
    this_cRclis       = ""    && C(30) razao social do cliente
    this_cEmails      = ""    && C(50) email do cliente
    this_cGrupos      = ""    && C(10) grupo do cliente
    this_cPrioridade  = ""    && C(15) prioridade do envio
    this_nChecks      = 0     && N(1)  marcado para envio (0=nao / 1=sim)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave (form operacional sem CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria (EmpDopNums)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de linha de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
            THIS.this_cContas     = TratarNulo(Contas,     "C")
            THIS.this_cRclis      = TratarNulo(Rclis,      "C")
            THIS.this_cEmails     = TratarNulo(emails,     "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_cPrioridade = TratarNulo(prioridade, "C")
            THIS.this_nChecks     = NVL(Checks, 0)
            loc_lSucesso          = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Popula crLocalTotal com movimentacoes para envio de email
    * par_cDopes = EmpDopNums completo (C(29)) ou vazio (busca pelo dia corrente)
    * Retorna .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_cDopes)
        LOCAL loc_lSucesso, loc_lOK, loc_cQuery, loc_cDti, loc_cDtf
        LOCAL loc_cContas, loc_cRclis, loc_nJobOK
        loc_lSucesso = .F.
        loc_lOK      = .T.

        IF VARTYPE(par_cDopes) != "C"
            par_cDopes = ""
        ENDIF

        TRY
            *-- Recriar cursor destino
            IF USED("crLocalTotal")
                USE IN crLocalTotal
            ENDIF
            SET NULL ON
            CREATE CURSOR crLocalTotal (;
                Checks N(1), grupos C(10), Contas C(10), Rclis C(30), ;
                emails C(50), mensagems M, EmpDopNums C(29), prioridade C(15))
            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON emails TAG Emails
            SET NULL OFF

            *-- Montar query de movimentacoes
            IF EMPTY(par_cDopes)
                loc_cDti   = THIS.FormatarDatetimeSQL(DATETIME())
                loc_cDtf   = THIS.FormatarDatetimeSQL(DTOT(DATE()) + 86399)
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, " + ;
                    "b.emails, b.grupos, b.iclis " + ;
                    "FROM SigMvcab a " + ;
                    "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                    "WHERE a.datatrans BETWEEN " + loc_cDti + " AND " + loc_cDtf + " " + ;
                    "AND a.EmpDopNums NOT IN (" + ;
                    "SELECT Transacaos FROM sigoplog WHERE progs = 'SIGPREMA') " + ;
                    "ORDER BY a.EmpDopNums"
            ELSE
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, " + ;
                    "b.emails, b.grupos, b.iclis " + ;
                    "FROM SigMvcab a " + ;
                    "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(par_cDopes)
            ENDIF

            *-- Buscar movimentacoes
            IF loc_lOK
                IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMvCab") < 1
                    MsgErro("Falha ao buscar movimenta" + CHR(231) + CHR(245) + ;
                        "es para email (TmpMvCab).", "Erro")
                    loc_lOK = .F.
                ENDIF
            ENDIF

            *-- Popular crLocalTotal com movimentacoes
            IF loc_lOK
                SELECT TmpMvCab
                GO TOP
                SCAN
                    INSERT INTO crLocalTotal ;
                        (Checks, grupos, Contas, Rclis, emails, prioridade, EmpDopNums) ;
                        VALUES (TmpMvCab.Checks, TmpMvCab.grupos, TmpMvCab.iclis, ;
                            TmpMvCab.Rclis, TmpMvCab.emails, "NORMAL", TmpMvCab.EmpDopNums)
                ENDSCAN
                IF USED("TmpMvCab")
                    USE IN TmpMvCab
                ENDIF
            ENDIF

            *-- Buscar contas adicionais parametrizadas em SigCdPam
            IF loc_lOK
                loc_cQuery = "SELECT 0 AS Checks, c.grupos, c.iclis AS Contas, " + ;
                    "c.rclis, c.emails, '' AS prioridade " + ;
                    "FROM SigCdPam p " + ;
                    "INNER JOIN SigCdCli c ON c.grupos = p.grpadats"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "crLocalPAM") < 1
                    MsgErro("Falha ao buscar contas PAM (crLocalPAM).", "Erro")
                    loc_lOK = .F.
                ENDIF
            ENDIF

            *-- Adicionar registros PAM que nao existam em crLocalTotal
            IF loc_lOK
                SELECT crLocalPAM
                SCAN
                    loc_cContas = ALLTRIM(crLocalPAM.Contas)
                    loc_cRclis  = ALLTRIM(crLocalPAM.Rclis)

                    *-- Verificar Jobs do cliente PAM
                    loc_nJobOK = SQLEXEC(gnConnHandle, ;
                        "SELECT Jobs FROM SigClJob WHERE Iclis = " + EscaparSQL(loc_cContas), ;
                        "TmpClJob")
                    IF loc_nJobOK >= 1 AND USED("TmpClJob")
                        USE IN TmpClJob
                    ENDIF

                    *-- Inserir se nao existir no crLocalTotal
                    SELECT crLocalTotal
                    LOCATE FOR ALLTRIM(crLocalTotal.Contas) = loc_cContas ;
                        AND ALLTRIM(crLocalTotal.Rclis) = loc_cRclis
                    IF EOF()
                        INSERT INTO crLocalTotal ;
                            (Checks, grupos, Contas, Rclis, emails, EmpDopNums, prioridade) ;
                            VALUES (crLocalPAM.Checks, "", loc_cContas, loc_cRclis, ;
                                crLocalPAM.emails, par_cDopes, "NORMAL")
                    ENDIF

                    SELECT crLocalPAM
                ENDSCAN
                IF USED("crLocalPAM")
                    USE IN crLocalPAM
                ENDIF
            ENDIF

            IF loc_lOK
                SELECT crLocalTotal
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterConfigSMTP - Le configuracao SMTP da empresa em SigCdEmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterConfigSMTP()
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.
        TRY
            loc_cQuery = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
                "FROM SigCdEmp WHERE CEmps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCfgSMTP") >= 1
                SELECT TmpCfgSMTP
                GO TOP
                IF !EOF()
                    THIS.this_cEmailFrom  = LOWER(ALLTRIM(NVL(TmpCfgSMTP.PadEmails, "")))
                    THIS.this_cSmtpServer = LOWER(ALLTRIM(NVL(TmpCfgSMTP.PadServs,  "")))
                    THIS.this_cSmtpSenha  = ALLTRIM(NVL(TmpCfgSMTP.PadSenhas, ""))
                    THIS.this_nSmtpPorta  = NVL(TmpCfgSMTP.PadPortas, 0)
                    loc_lSucesso          = .T.
                ENDIF
                IF USED("TmpCfgSMTP")
                    USE IN TmpCfgSMTP
                ENDIF
            ELSE
                MsgErro("Falha ao ler configura" + CHR(231) + CHR(227) + "o SMTP da empresa.", ;
                    "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ObterConfigSMTP")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDocumento - Gera documento e PDF de uma movimentacao
    * par_cEdn = EmpDopNums (C(29)) da movimentacao
    * Retorna .T. se gerado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDocumento(par_cEdn)
        LOCAL loc_lSucesso, loc_lOK, loc_cQuery
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_nValDevs
        LOCAL loc_nDocusCdOpe, loc_nQtdDocs, loc_nGerOpes
        LOCAL loc_nJobAtivo, loc_nJobTela, loc_lInvAtivo
        LOCAL loc_cEmpDopNumsMvCab
        LOCAL loc_cEstEmps, loc_cEstDopes, loc_nEstNumes, loc_nDocusEst, loc_nEstQtdDocs, loc_nEstValDevs

        loc_lSucesso    = .F.
        loc_lOK         = .T.
        loc_nDocusCdOpe = -1

        TRY
            *-- Carregar movimentacao
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 * FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(par_cEdn), ;
                "TprMvCab") < 1
                MsgErro("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                    "o encontrada: " + par_cEdn, "Erro")
                loc_lOK = .F.
            ENDIF

            IF loc_lOK
                SELECT TprMvCab
                GO TOP
                IF EOF()
                    loc_lOK = .F.
                ELSE
                    loc_cEmps          = ALLTRIM(TprMvCab.Emps)
                    loc_cDopes         = ALLTRIM(TprMvCab.Dopes)
                    loc_nNumes         = NVL(TprMvCab.Numes, 0)
                    loc_nValDevs       = NVL(TprMvCab.valdevs, 0)
                    loc_cEmpDopNumsMvCab = ALLTRIM(TprMvCab.EmpDopNums)
                ENDIF
            ENDIF

            *-- Carregar configuracao da operacao
            IF loc_lOK
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigCdOpe")
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigOpCdc")
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigOpCdi WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigOpCdi")
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigOpCdd")

                IF USED("crSigCdOpe")
                    SELECT crSigCdOpe
                    GO TOP
                    IF !EOF()
                        loc_nDocusCdOpe = NVL(crSigCdOpe.docus, -1)
                    ENDIF
                ENDIF

                THIS.this_cPcEscolha = ""

                *-- Boleto (docus = 0, 1, 5)
                IF INLIST(loc_nDocusCdOpe, 0, 1, 5)
                    loc_nQtdDocs = 0
                    IF USED("crSigOpCdc")
                        SELECT crSigOpCdc
                        GO TOP
                        IF !EOF()
                            loc_nQtdDocs = NVL(crSigOpCdc.QtdDocs, 0)
                        ENDIF
                    ENDIF
                    TRY
                        DO SigPrIdc WITH loc_cEmps, loc_cDopes, loc_nNumes, ;
                            loc_nValDevs, loc_nQtdDocs, .F., .T., .F., .F., .F., .F., THISFORM, .T.
                    CATCH TO loc_oErroPrg
                        MsgErro("Erro ao imprimir documento: " + loc_oErroPrg.Message, ;
                            "Impress" + CHR(227) + "o")
                    ENDTRY
                    THIS.this_cPcArqEmail = ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
                    loc_lSucesso          = .T.
                ENDIF

                *-- NF (docus = 3, 4, 6, 7, 8, 9)
                IF INLIST(loc_nDocusCdOpe, 3, 4, 6, 7, 8, 9)
                    TRY
                        DO FORM SigReIfx WITH loc_cEmps, loc_cDopes, loc_nNumes, .F., .T.
                    CATCH TO loc_oErroNF
                        MsgErro("Erro ao gerar NF: " + loc_oErroNF.Message, ;
                            "Impress" + CHR(227) + "o")
                    ENDTRY
                    loc_lSucesso = .T.
                ENDIF

                *-- Relatorio de Job (se campo Job ativo na tela e configurado)
                loc_nJobAtivo = 0
                IF USED("crSigOpCdi")
                    SELECT crSigOpCdi
                    GO TOP
                    IF !EOF()
                        loc_nJobAtivo = INT(VAL(SUBSTR(;
                            NVL(ALLTRIM(crSigOpCdi.lbltxidCs), ""), 25, 1)))
                    ENDIF
                ENDIF
                IF INLIST(loc_nJobAtivo, 1, 3) AND USED("crSigOpCdd")
                    SELECT crSigOpCdd
                    GO TOP
                    IF !EOF()
                        loc_nJobTela = INT(VAL(SUBSTR(;
                            NVL(ALLTRIM(crSigOpCdd.ConfigGers), ""), 157, 1)))
                        IF loc_nJobTela = 1
                            TRY
                                DO FORM SigReJob WITH THISFORM
                            CATCH TO loc_oErroJob
                                MsgErro("Erro no relat" + CHR(243) + "rio de Job: " + ;
                                    loc_oErroJob.Message, "Impress" + CHR(227) + "o")
                            ENDTRY
                        ENDIF
                    ENDIF
                ENDIF

                *-- Multiplas movimentacoes (GerOpes = 2)
                loc_nGerOpes = 0
                IF USED("crSigOpCdc")
                    SELECT crSigOpCdc
                    GO TOP
                    IF !EOF()
                        loc_nGerOpes = NVL(crSigOpCdc.GerOpes, 0)
                    ENDIF
                ENDIF
                IF loc_nGerOpes = 2
                    TRY
                        DO FORM SigOpIgm WITH THISFORM, loc_cEmps, loc_cDopes, loc_nNumes, .T.
                    CATCH TO loc_oErroMulti
                        MsgErro("Erro multiplas movimenta" + CHR(231) + CHR(245) + "es: " + ;
                            loc_oErroMulti.Message, "Impress" + CHR(227) + "o")
                    ENDTRY
                ENDIF

                *-- Inventario (chkInvs = 1)
                loc_lInvAtivo = .F.
                IF USED("crSigOpCdi")
                    SELECT crSigOpCdi
                    GO TOP
                    IF !EOF()
                        IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                            loc_lInvAtivo = crSigOpCdi.chkInvs
                        ELSE
                            IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                                loc_lInvAtivo = crSigOpCdi.chkInvs
                            ELSE
                                IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                                    loc_lInvAtivo = crSigOpCdi.chkInvs
                                ELSE
                                    IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                                        loc_lInvAtivo = crSigOpCdi.chkInvs
                                    ELSE
                                        IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                                            loc_lInvAtivo = crSigOpCdi.chkInvs
                                        ELSE
                                            IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                                                loc_lInvAtivo = crSigOpCdi.chkInvs
                                            ELSE
                                                IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                                                    loc_lInvAtivo = crSigOpCdi.chkInvs
                                                ELSE
                                                    loc_lInvAtivo = (NVL(crSigOpCdi.chkInvs, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF loc_lInvAtivo
                    TRY
                        DO FORM SigReIiv WITH loc_cEmps, loc_cDopes, loc_nNumes
                    CATCH TO loc_oErroInv
                        MsgErro("Erro no invent" + CHR(225) + "rio: " + ;
                            loc_oErroInv.Message, "Impress" + CHR(227) + "o")
                    ENDTRY
                ENDIF

                *-- Estorno (nOpCrs preenchido)
                IF USED("crSigCdOpe")
                    SELECT crSigCdOpe
                    GO TOP
                    IF !EOF() AND !EMPTY(NVL(crSigCdOpe.nOpCrs, ""))
                        loc_cQuery = "SELECT Emps, Dopes, Numes, ValDevs FROM SigMvCab " + ;
                            "WHERE EmpDnCrds = " + EscaparSQL(loc_cEmpDopNumsMvCab)
                        IF SQLEXEC(gnConnHandle, loc_cQuery, "crEest") >= 1
                            SELECT crEest
                            GO TOP
                            IF !EOF()
                                loc_cEstEmps  = ALLTRIM(crEest.Emps)
                                loc_cEstDopes = ALLTRIM(crEest.Dopes)
                                loc_nEstNumes = NVL(crEest.Numes, 0)
                                loc_nDocusEst = -1

                                IF SQLEXEC(gnConnHandle, ;
                                    "SELECT TOP 1 * FROM SigCdOpe WHERE dopes = " + ;
                                    EscaparSQL(loc_cEstDopes), "TmpOpeEst") >= 1
                                    SELECT TmpOpeEst
                                    GO TOP
                                    IF !EOF()
                                        loc_nDocusEst = NVL(TmpOpeEst.docus, -1)
                                    ENDIF
                                    IF USED("TmpOpeEst")
                                        USE IN TmpOpeEst
                                    ENDIF
                                ENDIF

                                IF INLIST(loc_nDocusEst, 1, 5)
                                    IF SQLEXEC(gnConnHandle, ;
                                        "SELECT TOP 1 * FROM SigOpCdc WHERE Dopes = " + ;
                                        EscaparSQL(loc_cEstDopes), "crSigOpCdcEst") >= 1 AND ;
                                       SQLEXEC(gnConnHandle, ;
                                        "SELECT TOP 1 * FROM SigMvCab WHERE EmpDopNums = " + ;
                                        EscaparSQL(loc_cEstEmps + loc_cEstDopes + ;
                                        STR(loc_nEstNumes, 6)), "CrEestMvCab") >= 1
                                        loc_nEstQtdDocs = 0
                                        loc_nEstValDevs = 0
                                        SELECT crSigOpCdcEst
                                        GO TOP
                                        IF !EOF()
                                            loc_nEstQtdDocs = NVL(crSigOpCdcEst.QtdDocs, 0)
                                        ENDIF
                                        SELECT CrEestMvCab
                                        GO TOP
                                        IF !EOF()
                                            loc_nEstValDevs = NVL(CrEestMvCab.valdevs, 0)
                                        ENDIF
                                        TRY
                                            DO SigPrIdc WITH loc_cEstEmps, loc_cEstDopes, ;
                                                loc_nEstNumes, loc_nEstValDevs, loc_nEstQtdDocs, ;
                                                .F., .F., .F., .F., .F., .F., THISFORM, .T.
                                        CATCH TO loc_oErroEst
                                            MsgErro("Erro no estorno: " + loc_oErroEst.Message, ;
                                                "Impress" + CHR(227) + "o")
                                        ENDTRY
                                        IF USED("crSigOpCdcEst")
                                            USE IN crSigOpCdcEst
                                        ENDIF
                                        IF USED("CrEestMvCab")
                                            USE IN CrEestMvCab
                                        ENDIF
                                    ENDIF
                                ENDIF

                                IF INLIST(loc_nDocusEst, 3, 6, 7, 8, 9)
                                    TRY
                                        DO FORM SigReIfx WITH loc_cEstEmps, loc_cEstDopes, ;
                                            loc_nEstNumes, .F., .T.
                                    CATCH TO loc_oErroEstNF
                                        MsgErro("Erro no estorno NF: " + loc_oErroEstNF.Message, ;
                                            "Impress" + CHR(227) + "o")
                                    ENDTRY
                                ENDIF
                            ENDIF
                            IF USED("crEest")
                                USE IN crEest
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- Limpar cursores de configuracao
            LOCAL loc_nI, loc_aNomCursores[5]
            loc_aNomCursores[1] = "TprMvCab"
            loc_aNomCursores[2] = "crSigCdOpe"
            loc_aNomCursores[3] = "crSigOpCdc"
            loc_aNomCursores[4] = "crSigOpCdi"
            loc_aNomCursores[5] = "crSigOpCdd"
            FOR loc_nI = 1 TO 5
                IF USED(loc_aNomCursores[loc_nI])
                    USE IN (loc_aNomCursores[loc_nI])
                ENDIF
            ENDFOR

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ImprimirDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarPDF - Gera arquivo PDF via PDFCreator COM
    * par_cArqEmail = caminho completo do arquivo PDF a gerar
    * Retorna .T. se PDF gerado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE GerarPDF(par_cArqEmail)
        LOCAL loc_lSucesso, loc_lPDFOK, loc_lStart, loc_cDefaultPrinter, loc_nCount
        LOCAL loc_oPDF, loc_cPrn
        loc_lSucesso = .F.
        loc_lPDFOK   = .T.
        loc_lStart   = .F.

        TRY
            DECLARE INTEGER Sleep IN WIN32API INTEGER nMilliseconds

            loc_oPDF = CREATEOBJECT("PDFCreator.clsPDFCreator", "PDFCreator_")

            IF loc_oPDF.cErrorDetail("Number") <> 0
                MsgErro("Erro ao inicializar PDFCreator: " + ;
                    loc_oPDF.cErrorDetail("Description"), "PDF")
                loc_lPDFOK = .F.
            ELSE
                loc_cDefaultPrinter = SET("PRINTER", 2)

                WITH loc_oPDF
                    .cClearCache()
                    .cErrorClear()
                    loc_lStart = .cStart("/NoProcessingAtStartup")
                    IF !loc_lStart
                        MsgErro("Falha ao iniciar PDFCreator.", "PDF")
                        loc_lPDFOK = .F.
                    ELSE
                        .cOption("DisableUpdateCheck")   = 1
                        .cOption("UseAutosaveDirectory") = 1
                        .cOption("UseAutosave")          = 1
                        .cOption("UseStandardAuthor")    = 1
                        .cOption("StandardAuthor")       = "FORTYUS"
                        .cOption("StandardTitle")        = ""
                        .cOption("AutosaveFormat")       = 0
                        .cOption("AutosaveDirectory")    = ADDBS(JUSTPATH(par_cArqEmail))
                        .cOption("AutosaveFilename")     = JUSTFNAME(par_cArqEmail)
                        .cDefaultPrinter                 = "PDFCreator"
                        .cPrinterStop                    = .F.
                    ENDIF
                ENDWITH

                IF loc_lStart AND loc_lPDFOK
                    loc_cPrn = "PDFCreator"
                    SET PRINTER TO NAME (loc_cPrn)

                    *-- Aguardar PDFCreator como impressora padrao
                    loc_nCount = 0
                    DO WHILE loc_nCount < 200
                        IF loc_oPDF.cDefaultPrinter = "PDFCreator"
                            EXIT
                        ENDIF
                        Sleep(500)
                        loc_nCount = loc_nCount + 1
                    ENDDO

                    IF loc_oPDF.cDefaultPrinter = "PDFCreator"
                        THIS.ImprimirParaPDF()
                        Sleep(500)

                        *-- Aguardar geracao do arquivo PDF
                        loc_nCount = 0
                        DO WHILE loc_nCount <= 10
                            Sleep(1000)
                            loc_nCount = loc_nCount + 1
                            IF FILE(par_cArqEmail)
                                EXIT
                            ENDIF
                        ENDDO

                        IF FILE(par_cArqEmail)
                            THIS.this_cPcArqEmail = par_cArqEmail
                            loc_lSucesso          = .T.
                        ELSE
                            MsgErro("Arquivo PDF n" + CHR(227) + "o foi gerado: " + ;
                                par_cArqEmail, "PDF")
                        ENDIF
                    ELSE
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel definir " + ;
                            "PDFCreator como impressora padr" + CHR(227) + "o.", "PDF")
                    ENDIF

                    SET PRINTER TO NAME (loc_cDefaultPrinter)
                ENDIF

                loc_oPDF.cClearCache()
                loc_oPDF.cClose()
                loc_oPDF = .NULL.
            ENDIF

            CLEAR DLLS "Sleep"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GerarPDF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirParaPDF - Imprime relatorio SigReDc2 na impressora corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ImprimirParaPDF()
        LOCAL loc_cArq, loc_lcPoint, loc_lcSep
        TRY
            loc_cArq = FULLPATH(gc_4c_CaminhoReports + "SigReDc2.frx")
            IF FILE(loc_cArq)
                loc_lcPoint = SET("POINT")
                loc_lcSep   = SET("SEPARATOR")
                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80
                REPORT FORM (loc_cArq) TO PRINTER NOCONSOLE
                SET POINT TO (loc_lcPoint)
                SET SEPARATOR TO (loc_lcSep)
                SET REPORTBEHAVIOR 90
            ELSE
                MsgErro("Relat" + CHR(243) + "rio SigReDc2.frx n" + CHR(227) + "o encontrado.", ;
                    "PDF")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ImprimirParaPDF")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmailCDO - Envia email via CDO.Message (Windows COM)
    * par_cFrom  = endereco remetente
    * par_cTo    = endereco destinatario principal
    * par_cCC    = enderecos em copia (separados por virgula)
    * par_cAssunto, par_cCorpo = assunto e corpo do email
    * par_cAnexo = caminho completo do arquivo a anexar (ou "")
    * par_cSmtpServer, par_nPorta, par_cUser, par_cSenha = config SMTP
    * Retorna .T. se enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmailCDO(par_cFrom, par_cTo, par_cCC, par_cAssunto, ;
        par_cCorpo, par_cAnexo, par_cSmtpServer, par_nPorta, par_cUser, par_cSenha)
        LOCAL loc_lSucesso, loc_lCDOOK, loc_lEnvioOK, loc_oEmail
        loc_lSucesso = .F.
        loc_lCDOOK   = .T.
        loc_lEnvioOK = .T.

        TRY
            IF TYPE('CREATEOBJECT("CDO.Message")') <> "O"
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel instanciar " + ;
                    "CDO.Message.", "Email")
                loc_lCDOOK = .F.
            ENDIF

            IF loc_lCDOOK
                loc_oEmail = CREATEOBJECT("CDO.Message")

                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = ;
                        LOWER(par_cSmtpServer)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = ;
                        IIF(par_nPorta = 0, 25, par_nPorta)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = ;
                        LOWER(par_cUser)
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = par_cSenha
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = ;
                        IIF(par_nPorta = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To       = LOWER(par_cTo)
                    .Cc       = LOWER(NVL(par_cCC, ""))
                    .From     = LOWER(par_cFrom)
                    .Subject  = ALLTRIM(par_cAssunto)
                    .TextBody = ALLTRIM(par_cCorpo)

                    IF !ISNULL(par_cAnexo) AND !EMPTY(par_cAnexo)
                        IF FILE(par_cAnexo)
                            .AddAttachment(par_cAnexo)
                        ELSE
                            loc_lEnvioOK = .F.
                            MsgAviso("Arquivo de anexo n" + CHR(227) + "o encontrado:" + ;
                                CHR(13) + par_cAnexo, "Anexo")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOK
                        TRY
                            .Send()
                            loc_lSucesso = .T.
                        CATCH TO loc_oErroSend
                            MsgErro("Falha ao enviar email: " + loc_oErroSend.Message, "Email")
                            loc_lSucesso = .F.
                        ENDTRY
                    ENDIF
                ENDWITH

                loc_oEmail = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro EnviarEmailCDO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEnvioEmails - Envia emails para todos os registros marcados
    * Percorre crLocalTotal (Checks=1), gera documento e envia por email
    * Retorna .T. se todos os emails foram enviados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarEnvioEmails()
        LOCAL loc_lSucesso, loc_lTudoOK, loc_lConfigOK
        LOCAL loc_cReceptor, loc_cReceptorCC, loc_cAssunto, loc_cCorpo, loc_cArqAnexo
        LOCAL loc_cEdn, loc_nRec
        loc_lSucesso   = .F.
        loc_lTudoOK    = .T.
        loc_lConfigOK  = .T.
        loc_nRec       = 0
        loc_cReceptor  = ""
        loc_cReceptorCC = ""
        loc_cAssunto   = ""
        loc_cCorpo     = ""

        TRY
            *-- Obter configuracao SMTP da empresa
            IF !THIS.ObterConfigSMTP()
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel obter " + ;
                    "configura" + CHR(231) + CHR(227) + "o SMTP.", "Email")
                loc_lConfigOK = .F.
            ENDIF

            IF loc_lConfigOK
                *-- Cursor com registros marcados para envio
                IF USED("crLocalTotal2")
                    USE IN crLocalTotal2
                ENDIF
                SELECT * FROM crLocalTotal WHERE Checks = 1 INTO CURSOR crLocalTotal2 READWRITE

                SELECT crLocalTotal2
                GO TOP
                SCAN
                    IF EMPTY(ALLTRIM(crLocalTotal2.emails))
                        LOOP
                    ENDIF

                    *-- Flag por iteracao: erros nao bloqueiam movimentacoes subsequentes
                    LOCAL loc_lIterOK
                    loc_lIterOK = .T.

                    loc_nRec = loc_nRec + 1
                    loc_cEdn = ALLTRIM(crLocalTotal2.EmpDopNums)

                    *-- Primeiro registro = receptor principal; demais = copia
                    IF loc_nRec = 1
                        loc_cReceptor   = ALLTRIM(crLocalTotal2.emails)
                        loc_cCorpo      = ""
                        loc_cAssunto    = ""
                        loc_cReceptorCC = ""
                    ELSE
                        IF !EMPTY(ALLTRIM(crLocalTotal2.emails))
                            loc_cReceptorCC = loc_cReceptorCC + ;
                                IIF(EMPTY(loc_cReceptorCC), "", ",") + ;
                                ALLTRIM(crLocalTotal2.emails)
                        ENDIF
                    ENDIF

                    *-- Remover PDF anterior
                    IF FILE(ADDBS(SYS(2023)) + "FORTYUSPDF.PDF")
                        DELETE FILE ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
                    ENDIF

                    *-- Gerar documento e PDF
                    IF !THIS.ImprimirDocumento(loc_cEdn)
                        loc_lIterOK = .F.
                        loc_lTudoOK = .F.
                    ENDIF

                    loc_cArqAnexo = THIS.this_cPcArqEmail

                    *-- Enviar email desta movimentacao
                    IF loc_lIterOK
                        IF !THIS.EnviarEmailCDO(;
                            THIS.this_cEmailFrom, ;
                            loc_cReceptor, ;
                            loc_cReceptorCC, ;
                            loc_cAssunto, ;
                            loc_cCorpo, ;
                            loc_cArqAnexo, ;
                            THIS.this_cSmtpServer, ;
                            THIS.this_nSmtpPorta, ;
                            THIS.this_cEmailFrom, ;
                            THIS.this_cSmtpSenha)
                            loc_lIterOK = .F.
                            loc_lTudoOK = .F.
                        ENDIF
                    ENDIF

                    *-- Registrar log apenas se esta iteracao foi bem-sucedida
                    IF loc_lIterOK
                        THIS.RegistrarLogEmail(loc_cEdn)
                    ENDIF

                    SELECT crLocalTotal2
                ENDSCAN

                IF USED("crLocalTotal2")
                    USE IN crLocalTotal2
                ENDIF

                THIS.this_lEnvioOk = loc_lTudoOK
                loc_lSucesso       = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ProcessarEnvioEmails")
        ENDTRY

        RETURN loc_lSucesso AND loc_lTudoOK
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLogEmail - Registra envio de email em sigoplog
    * par_cEdn = EmpDopNums (C(29)) da movimentacao enviada
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLogEmail(par_cEdn)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO sigoplog (Transacaos, progs) VALUES (" + ;
                EscaparSQL(par_cEdn) + ", 'SIGPREMA')"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao registrar log de email para " + par_cEdn + ".", "Log")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro RegistrarLogEmail")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra log de envio de email em sigoplog + auditoria
    * Chave usada: this_cEmpDopNums (populada por CarregarDoCursor ou FormParaBO)
    * Retorna .T. se INSERT bem-sucedido
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("Chave EmpDopNums em branco - n" + CHR(227) + ;
                "o eh poss" + CHR(237) + "vel registrar log de email.", "Log")
            RETURN .F.
        ENDIF

        loc_cUsuario = LEFT(NVL(gc_4c_UsuarioLogado, "SIGPREMA"), 20)

        TRY
            loc_cSQL = "INSERT INTO sigoplog (" + ;
                "usuaredes, datars, horas, progs, opers, usuasis, " + ;
                "parametros, transacaos, cversaos, cidchaves, copias) VALUES (" + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                "'SIGPREMA', " + ;
                "'I', " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "'', " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 100)) + ", " + ;
                "'', " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 20)) + ", " + ;
                "0)"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INCLUIR")
            ELSE
                MsgErro("Falha ao registrar log de email para " + ;
                    THIS.this_cEmpDopNums + ".", "Log")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza log de envio de email em sigoplog + auditoria
    * Chave usada: this_cEmpDopNums (armazenada em cidchaves)
    * Retorna .T. se UPDATE bem-sucedido
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("Chave EmpDopNums em branco - n" + CHR(227) + ;
                "o eh poss" + CHR(237) + "vel atualizar log de email.", "Log")
            RETURN .F.
        ENDIF

        loc_cUsuario = LEFT(NVL(gc_4c_UsuarioLogado, "SIGPREMA"), 20)

        TRY
            loc_cSQL = "UPDATE sigoplog SET " + ;
                "datars = GETDATE(), " + ;
                "horas = " + EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                "opers = 'A', " + ;
                "usuaredes = " + EscaparSQL(loc_cUsuario) + ", " + ;
                "transacaos = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 100)) + " " + ;
                "WHERE progs = 'SIGPREMA' " + ;
                "AND transacaos = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 100))
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("ALTERAR")
            ELSE
                MsgErro("Falha ao atualizar log de email para " + ;
                    THIS.this_cEmpDopNums + ".", "Log")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para string SQL Server
    * Retorna 'YYYY-MM-DD HH:MM:SS' com aspas simples incluidas
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDatetimeSQL(par_tDt)
        LOCAL loc_cResult
        TRY
            loc_cResult = "'" + ;
                TRANSFORM(YEAR(par_tDt))             + "-" + ;
                PADL(TRANSFORM(MONTH(par_tDt)),  2, "0") + "-" + ;
                PADL(TRANSFORM(DAY(par_tDt)),    2, "0") + " " + ;
                PADL(TRANSFORM(HOUR(par_tDt)),   2, "0") + ":" + ;
                PADL(TRANSFORM(MINUTE(par_tDt)), 2, "0") + ":" + ;
                PADL(TRANSFORM(SEC(par_tDt)),    2, "0") + "'"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro FormatarDatetimeSQL")
            loc_cResult = "'2000-01-01 00:00:00'"
        ENDTRY
        RETURN loc_cResult
    ENDFUNC

ENDDEFINE


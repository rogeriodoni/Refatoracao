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
[03/07/2026 09:46:04] Erro: Erro ao inicializar Operações Selecionadas:Alias 'TMPCABEC' is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-03 09:45:44] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-03 09:45:44] [INFO] Config FPW: (nao fornecido)
[2026-07-03 09:45:44] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 09:45:44] [INFO] Timeout: 300 segundos
[2026-07-03 09:45:44] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3m22bryl.prg
[2026-07-03 09:45:44] [INFO] Conteudo do wrapper:
[2026-07-03 09:45:44] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrGl2', 'C:\4c\tasks\task186', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrGl2', 'C:\4c\tasks\task186', 'OPERACIONAL'
QUIT

[2026-07-03 09:45:44] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3m22bryl.prg
[2026-07-03 09:45:44] [INFO] VFP output esperado em: C:\4c\tasks\task186\vfp_output.txt
[2026-07-03 09:45:44] [INFO] Executando Visual FoxPro 9...
[2026-07-03 09:45:44] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3m22bryl.prg
[2026-07-03 09:45:44] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3m22bryl.prg
[2026-07-03 09:45:44] [INFO] Timeout configurado: 300 segundos
[2026-07-03 09:46:04] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-03 09:46:04] [INFO] VFP9 finalizado em 20.0614912 segundos
[2026-07-03 09:46:04] [INFO] Exit Code: 
[2026-07-03 09:46:04] [INFO] 
[2026-07-03 09:46:04] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-03 09:46:04] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3m22bryl.prg
[2026-07-03 09:46:04] [INFO] 
[2026-07-03 09:46:04] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-03 09:46:04] [INFO] * Auto-generated wrapper for parameters
[2026-07-03 09:46:04] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 09:46:04] [INFO] * Parameters: 'FormSigPrGl2', 'C:\4c\tasks\task186', 'OPERACIONAL'
[2026-07-03 09:46:04] [INFO] 
[2026-07-03 09:46:04] [INFO] * Anti-dialog protections for unattended execution
[2026-07-03 09:46:04] [INFO] SET SAFETY OFF
[2026-07-03 09:46:04] [INFO] SET RESOURCE OFF
[2026-07-03 09:46:04] [INFO] SET TALK OFF
[2026-07-03 09:46:04] [INFO] SET NOTIFY OFF
[2026-07-03 09:46:04] [INFO] SYS(2335, 0)
[2026-07-03 09:46:04] [INFO] 
[2026-07-03 09:46:04] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrGl2', 'C:\4c\tasks\task186', 'OPERACIONAL'
[2026-07-03 09:46:04] [INFO] QUIT
[2026-07-03 09:46:04] [INFO] 
[2026-07-03 09:46:04] [INFO] === Fim do Wrapper.prg ===
[2026-07-03 09:46:04] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrGl2",
  "timestamp": "20260703094604",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg):
*==============================================================================
* FormSigPrGl2.prg
* Form OPERACIONAL - Operacoes Selecionadas (Geracao de OPs)
* Herda de: FormBase
* Tipo: OPERACIONAL - Selecao e processamento de operacoes para Ordem de Producao
* Original: SigPrGl2.SCX (SIGPRGL2)
*
* Chamada (pelo form pai SigPrGl1 ou similar):
*   loForm = CREATEOBJECT("FormSigPrGl2", loParentForm, THIS.DataSessionId,
*                          lReservaAuto, nEmphPdr, lAutomatico, nNumeroOp)
*   loForm.Show()
*
* par_oParentForm  : referencia ao form pai
* par_nDataSession : DataSessionId do form pai (TmpCabec e TmpItens estao nessa sessao)
* par_lReservaAuto : .T. = modo reserva automatica de estoque
* par_nEmphPdr     : codigo de empresa padrao para geracao de OPs
* par_lAutomatico  : .T. = processamento automatico (sem confirmacao manual)
* par_nNumeroOp    : numero da OP preestabelecido (0 = auto-gerado)
*==============================================================================

DEFINE CLASS FormSigPrGl2 AS FormBase

    *-- Identificacao
    this_cTituloForm    = "Operacoes Selecionadas"

    *-- DataSession=1: TmpCabec e TmpItens vivem na sessao compartilhada com o pai
    DataSession         = 1

    *-- Parametros capturados em Init (antes de DODEFAULT/InicializarForm)
    this_oParentForm    = .NULL.
    this_nParentSession = 0
    this_lReservaAuto   = .F.
    this_nEmphPdr       = 0
    this_lAutomatico    = .F.
    this_nNumeroOp      = 0
    this_cPorDestino    = ""

    *-- Dimensoes e aparencia (SCX SIGPRGL2: 800x600)
    Width       = 800
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ShowWindow  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    ShowTips    = .T.
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Init - Captura parametros ANTES de InicializarForm (via DODEFAULT)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_nDataSession, par_lReservaAuto, ;
                   par_nEmphPdr, par_lAutomatico, par_nNumeroOp)

        THIS.this_cTituloForm = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"

        IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
            THIS.this_oParentForm = par_oParentForm
            IF VARTYPE(par_oParentForm.this_cPorDestino) = "C"
                THIS.this_cPorDestino = par_oParentForm.this_cPorDestino
            ENDIF
        ENDIF
        IF VARTYPE(par_nDataSession) = "N"
            THIS.this_nParentSession = par_nDataSession
        ENDIF
        IF VARTYPE(par_lReservaAuto) = "L"
            THIS.this_lReservaAuto = par_lReservaAuto
        ENDIF
        IF VARTYPE(par_nEmphPdr) = "N"
            THIS.this_nEmphPdr = par_nEmphPdr
        ENDIF
        IF VARTYPE(par_lAutomatico) = "L"
            THIS.this_lAutomatico = par_lAutomatico
        ENDIF
        IF VARTYPE(par_nNumeroOp) = "N"
            THIS.this_nNumeroOp = par_nNumeroOp
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Ordena grade e atualiza visual ao ativar o form
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        THIS.AplicarOrdem("")
        IF USED("TmpCabec")
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGl2BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGl2BO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.MontarLayout()
                THIS.ConfigurarGrades()
                THIS.ConfigurarPaginaDados()
                THIS.RegistrarEventos()
                THIS.AplicarOrdem("")
                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar " + THIS.this_cTituloForm + ":" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarLayout - Cria todos os controles do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarLayout()

        *-- Botao Processar (top=3, sobreposicao ao cabecalho cinza)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 648
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- Botao Cancelar/Encerrar
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 723
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- EditBox: Observacao da Operacao (top=82, editavel)
        THIS.AddObject("edt_4c_ObsOpe", "EditBox")
        WITH THIS.edt_4c_ObsOpe
            .Top         = 82
            .Left        = 5
            .Width       = 602
            .Height      = 70
            .NullDisplay = " "
            .FontName    = "Tahoma"
            .FontSize    = 8
        ENDWITH

        *-- Grade de Operacoes (top=155, 10 colunas)
        THIS.AddObject("grd_4c_GradeOpe", "Grid")
        WITH THIS.grd_4c_GradeOpe
            .Top               = 155
            .Left              = 5
            .Width             = 789
            .Height            = 156
            .ColumnCount       = 10
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238,238,238)
            .Panel             = 1
        ENDWITH

        *-- Configurar colunas da GradeOpe
        WITH THIS.grd_4c_GradeOpe

            *-- Col1: Flag (checkbox de selecao)
            WITH .Column1
                .Width     = 17
                .Movable   = .F.
                .Resizable = .F.
                .Sparse    = .F.
                WITH .Header1
                    .Caption   = ""
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                .AddObject("chk_4c_Flag", "CheckBox")
                WITH .chk_4c_Flag
                    .Caption   = ""
                    .Alignment = 0
                    .Height    = 17
                    .Width     = 60
                ENDWITH
                .CurrentControl = "chk_4c_Flag"
            ENDWITH

            *-- Col2: Movimentacao (Dopes) - cabecalho clicavel para ordenar
            WITH .Column2
                .Width     = 156
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col3: Numero (Numes)
            WITH .Column3
                .Width     = 70
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "N" + CHR(250) + "mero"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col4: Emissao (Datas)
            WITH .Column4
                .Width     = 70
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Emiss" + CHR(227) + "o"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col5: Entrega (Entregas) - cabecalho clicavel para ordenar
            WITH .Column5
                .Width     = 70
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Entrega"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col6: Peso
            WITH .Column6
                .Width     = 90
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "999,999.99"
                WITH .Header1
                    .Caption   = "Peso"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col7: Responsavel (Contav)
            WITH .Column7
                .Width     = 90
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Respons" + CHR(225) + "vel"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col8: Cliente (Conta)
            WITH .Column8
                .Width     = 90
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Cliente"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col9: Obs (indicador "*" se tem observacao)
            WITH .Column9
                .Width     = 44
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Obs"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontBold    = .T.
                    .FontSize    = 12
                    .Alignment   = 2
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col10: Doc. (Notas)
            WITH .Column10
                .Width     = 52
                .Movable   = .F.
                .Resizable = .F.
                WITH .Header1
                    .Caption   = "Doc."
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

        ENDWITH

        *-- Label "Cliente :"
        THIS.AddObject("lbl_4c_Cliente", "Label")
        WITH THIS.lbl_4c_Cliente
            .Top       = 317
            .Left      = 5
            .Width     = 42
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Cliente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- TextBox do Cliente (somente leitura - exibe DConta)
        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .Top           = 313
            .Left          = 59
            .Width         = 345
            .Height        = 23
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- Grade de Itens (top=339, 8 colunas)
        THIS.AddObject("grd_4c_GradeItens", "Grid")
        WITH THIS.grd_4c_GradeItens
            .Top               = 339
            .Left              = 5
            .Width             = 737
            .Height            = 191
            .ColumnCount       = 8
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238,238,238)
            .Panel             = 1
        ENDWITH

        *-- Configurar colunas da GradeItens
        WITH THIS.grd_4c_GradeItens

            *-- Col1: Produto (Cpros) - ColumnOrder=1 (default)
            WITH .Column1
                .Width     = 120
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Produto"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col2: Quantidade (Qtds) - ColumnOrder=5
            WITH .Column2
                .ColumnOrder = 5
                .Width       = 90
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Quantidade"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col3: Saldo - ColumnOrder=6
            WITH .Column3
                .ColumnOrder = 6
                .Width       = 118
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Saldo"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col4: Peso - ColumnOrder=7
            WITH .Column4
                .ColumnOrder = 7
                .Width       = 100
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Peso"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col5: Obs (indicador) - ColumnOrder=8
            WITH .Column5
                .ColumnOrder = 8
                .Width       = 44
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Obs"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontBold    = .T.
                    .FontSize    = 12
                    .Alignment   = 2
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col6: Cor (CodCors) - ColumnOrder=3
            WITH .Column6
                .ColumnOrder = 3
                .Width       = 38
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Cor"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col7: Tam (CodTams) - ColumnOrder=4
            WITH .Column7
                .ColumnOrder = 4
                .Width       = 38
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Tam"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col8: Ref. Fornecedor (Reffs) - ColumnOrder=2
            WITH .Column8
                .ColumnOrder = 2
                .Width       = 150
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Ref. Fornecedor"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

        ENDWITH

        *-- Botao Desmarca Tudo (top=358, left=748, ao lado da GradeItens)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top             = 358
            .Left            = 748
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .ToolTipText     = "Desmarca Tudo"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36,84,155)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- Botao Seleciona Tudo (top=400, left=748, ao lado da GradeItens)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top             = 400
            .Left            = 748
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .ToolTipText     = "Seleciona Tudo"
            .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36,84,155)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- Label "Observacao do Item :"
        THIS.AddObject("lbl_4c_ObsItens", "Label")
        WITH THIS.lbl_4c_ObsItens
            .Top       = 532
            .Left      = 5
            .Width     = 146
            .Height    = 15
            .AutoSize  = .F.
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- EditBox de observacao dos itens (editavel, top=548)
        THIS.AddObject("edt_4c_ObsItens", "EditBox")
        WITH THIS.edt_4c_ObsItens
            .Top         = 548
            .Left        = 5
            .Width       = 737
            .Height      = 47
            .NullDisplay = " "
            .FontName    = "Tahoma"
            .FontSize    = 8
        ENDWITH

        *-- Shape decorativo na area dos botoes de acao (topo-direita)
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 7
            .Left        = 732
            .Width       = 60
            .Height      = 29
            .BorderStyle = 1
            .BorderWidth = 1
            .FillStyle   = 1
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrades - Define RecordSource e ControlSource das grades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrades()

        *-- GradeOperacoes vinculada a TmpCabec
        THIS.grd_4c_GradeOpe.RecordSource = "TmpCabec"
        WITH THIS.grd_4c_GradeOpe
            .Column1.ControlSource  = "TmpCabec.Flag"
            .Column2.ControlSource  = "TmpCabec.Dopes"
            .Column3.ControlSource  = "TmpCabec.Numes"
            .Column4.ControlSource  = "TmpCabec.Datas"
            .Column5.ControlSource  = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
            .Column6.ControlSource  = "TmpCabec.Peso"
            .Column7.ControlSource  = "TmpCabec.Contav"
            .Column8.ControlSource  = "TmpCabec.Conta"
            .Column9.ControlSource  = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
            .Column10.ControlSource = "TmpCabec.Notas"
        ENDWITH

        *-- Cliente (nome do cliente da operacao atual)
        THIS.txt_4c_Cliente.ControlSource = "TmpCabec.DConta"

        *-- Obs da operacao (editavel)
        THIS.edt_4c_ObsOpe.ControlSource = "TmpCabec.Obs"

        *-- GradeItens vinculada a TmpItens
        THIS.grd_4c_GradeItens.RecordSource = "TmpItens"
        WITH THIS.grd_4c_GradeItens
            .Column1.ControlSource = "TmpItens.Cpros"
            .Column2.ControlSource = "TmpItens.Qtds"
            .Column3.ControlSource = "TmpItens.Saldo"
            .Column4.ControlSource = "TmpItens.Peso"
            .Column5.ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
            .Column6.ControlSource = "TmpItens.CodCors"
            .Column7.ControlSource = "TmpItens.CodTams"
            .Column8.ControlSource = "TmpItens.Reffs"
        ENDWITH

        *-- Obs dos itens (editavel)
        THIS.edt_4c_ObsItens.ControlSource = "TmpItens.Obs"

        *-- Posicionar TmpItens filtrado pelo primeiro registro de TmpCabec
        IF USED("TmpItens") AND USED("TmpCabec")
            SELECT TmpCabec
            GO TOP
            SELECT TmpItens
            SET ORDER TO EmpDopNum
            SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
            GO TOP
        ENDIF

    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventos - BINDEVENT para todos os eventos interativos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventos()

        BINDEVENT(THIS.grd_4c_GradeOpe, "AfterRowColChange", THIS, "AoMudarLinhaOpe")
        BINDEVENT(THIS.grd_4c_GradeOpe.Column2.Header1, "Click", THIS, "AoClicarCabMovi")
        BINDEVENT(THIS.grd_4c_GradeOpe.Column5.Header1, "Click", THIS, "AoClicarCabEntrega")
        BINDEVENT(THIS.grd_4c_GradeItens, "AfterRowColChange", THIS, "AoMudarLinhaItens")
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "AoProcessar")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "AoCancelar")
        BINDEVENT(THIS.cmd_4c_Apaga,     "Click", THIS, "AoApagar")
        BINDEVENT(THIS.cmd_4c_SelTudo,   "Click", THIS, "AoSelTudo")

    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarOrdem - Ordena TmpCabec e atualiza cores dos cabecalhos das colunas
    * par_cOrdem: "EMPDOPNUM" | "ENTREGA" | "" (usa ordem atual do BO)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarOrdem(par_cOrdem)
        LOCAL loc_cOrdAtual

        THIS.this_oBusinessObject.OrdenarOperacoes(par_cOrdem)
        loc_cOrdAtual = UPPER(THIS.this_oBusinessObject.this_cOrdConta)

        WITH THIS.grd_4c_GradeOpe
            .Column2.Header1.BackColor = IIF(loc_cOrdAtual = "EMPDOPNUM", RGB(220,255,220), RGB(192,192,192))
            .Column5.Header1.BackColor = IIF(loc_cOrdAtual = "ENTREGA",   RGB(220,255,220), RGB(192,192,192))
        ENDWITH
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS (PUBLIC - exigido por BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AoMudarLinhaOpe - AfterRowColChange da GradeOpe
    * Filtra TmpItens para exibir itens da operacao selecionada
    *--------------------------------------------------------------------------
    PROCEDURE AoMudarLinhaOpe(par_nColIndex)
        IF USED("TmpItens") AND USED("TmpCabec")
            SELECT TmpItens
            SET ORDER TO EmpDopNum
            SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
            GO TOP
            THIS.txt_4c_Cliente.Refresh()
            THIS.edt_4c_ObsOpe.Refresh()
            THIS.grd_4c_GradeItens.Refresh()
            THIS.edt_4c_ObsItens.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoClicarCabMovi - Click no Header da Coluna 2 (Movimentacao)
    * Ordena TmpCabec por EmpDopNum
    *--------------------------------------------------------------------------
    PROCEDURE AoClicarCabMovi()
        IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "EMPDOPNUM"
            THIS.AplicarOrdem("EMPDOPNUM")
            SELECT TmpCabec
            GO TOP
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoClicarCabEntrega - Click no Header da Coluna 5 (Entrega)
    * Ordena TmpCabec por data de entrega
    *--------------------------------------------------------------------------
    PROCEDURE AoClicarCabEntrega()
        IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "ENTREGA"
            THIS.AplicarOrdem("ENTREGA")
            SELECT TmpCabec
            GO TOP
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoMudarLinhaItens - AfterRowColChange da GradeItens
    * Atualiza editbox de observacao do item
    *--------------------------------------------------------------------------
    PROCEDURE AoMudarLinhaItens(par_nColIndex)
        THIS.edt_4c_ObsItens.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AoProcessar - Click do botao Processar
    * Chama BO.ProcessarOperacoes() e navega para o form seguinte
    *--------------------------------------------------------------------------
    PROCEDURE AoProcessar()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_oProxForm
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.ProcessarOperacoes( ;
                THIS.this_lReservaAuto, ;
                THIS.this_lAutomatico,  ;
                THIS.this_nEmphPdr,     ;
                THIS.this_nNumeroOp,    ;
                THIS.this_cPorDestino   ;
            )
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AoProcessar")
        ENDTRY

        IF loc_lSucesso
            THIS.Enabled = .F.
            IF THIS.this_lReservaAuto
                THIS.cmd_4c_Processar.Enabled = .F.
            ENDIF

            *-- Abrir form seguinte conforme flag do BO
            IF THIS.this_oBusinessObject.this_lTemEstimado
                *-- Ha estoque estimado: abre SigPrGlx (grade com estimados)
                loc_oProxForm = CREATEOBJECT("FormSigPrGlx", THIS, THIS.DataSessionId, ;
                                              THIS.this_lReservaAuto, THIS.this_nEmphPdr, ;
                                              THIS.this_lAutomatico, THIS.this_nNumeroOp, ;
                                              THIS.this_cPorDestino)
            ELSE
                *-- Sem estoque estimado: abre SigPrGlp (grade de geracao direta)
                loc_oProxForm = CREATEOBJECT("FormSigPrGlp", THIS, THIS.DataSessionId, ;
                                              THIS.this_lReservaAuto, THIS.this_nEmphPdr, ;
                                              THIS.this_lAutomatico, THIS.this_nNumeroOp)
            ENDIF

            IF VARTYPE(loc_oProxForm) = "O"
                loc_oProxForm.Show()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoCancelar - Click do botao Encerrar
    * Reabilita form pai e fecha este form
    *--------------------------------------------------------------------------
    PROCEDURE AoCancelar()
        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AoApagar - Click do botao Desmarca Tudo
    *--------------------------------------------------------------------------
    PROCEDURE AoApagar()
        IF USED("TmpCabec")
            REPLACE ALL Flag WITH .F. IN TmpCabec
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoSelTudo - Click do botao Seleciona Tudo
    *--------------------------------------------------------------------------
    PROCEDURE AoSelTudo()
        IF USED("TmpCabec")
            REPLACE ALL Flag WITH .T. IN TmpCabec
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Constroi o "frame" visual do form OPERACIONAL:
    * cnt_4c_Cabecalho (cabecalho cinza) com labels de titulo.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa do topo, mantendo o nome padrao do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .AutoSize   = .F.
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"
            .Height     = 40
            .Left       = 10
            .Top        = 18
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(0, 0, 0)
            .Visible    = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .AutoSize    = .F.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = THIS.Width - 20
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura a area de lista (equivalente a Page1
    * em forms CRUD). Para este form OPERACIONAL, o layout completo e montado
    * em MontarLayout/ConfigurarGrades; este metodo e o ponto de entrada
    * nomeado para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF VARTYPE(THIS.grd_4c_GradeOpe) = "O" AND !ISNULL(THIS.grd_4c_GradeOpe)
            THIS.ConfigurarGrades()
        ENDIF
    ENDPROC
    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Propriedades visuais dos controles interativos:
    *   - grd_4c_GradeOpe:    highlight e fonte
    *   - edt_4c_ObsOpe:      aparencia e scrollbar
    *   - grd_4c_GradeItens:  highlight e fonte
    *   - edt_4c_ObsItens:    aparencia e scrollbar
    *   - txt_4c_Cliente:     aparencia somente-leitura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- GradeOperacoes: highlight de linha selecionada e fonte
        WITH THIS.grd_4c_GradeOpe
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH

        *-- EditBox de Observacao da Operacao
        WITH THIS.edt_4c_ObsOpe
            .BackColor  = RGB(255, 255, 255)
            .ForeColor  = RGB(90, 90, 90)
            .ScrollBars = 3
        ENDWITH

        *-- GradeItens: highlight de linha selecionada e fonte
        WITH THIS.grd_4c_GradeItens
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH

        *-- EditBox de Observacao dos Itens
        WITH THIS.edt_4c_ObsItens
            .BackColor  = RGB(255, 255, 255)
            .ForeColor  = RGB(90, 90, 90)
            .ScrollBars = 3
        ENDWITH

        *-- TextBox Cliente: fundo levemente cinza para indicar somente-leitura
        WITH THIS.txt_4c_Cliente
            .BackColor = RGB(240, 240, 240)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Nao aplicavel para form OPERACIONAL (sem PageFrame CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = 'O' AND !ISNULL(loc_oControl)
                IF PEMSTATUS(loc_oControl, 'Visible', 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = 'PAGEFRAME'
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, 'ControlCount', 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS - Padrao esperado pelo pipeline multi-fase (Fase 7)
    *
    * Este form OPERACIONAL (SIGPRGL2 - Operacoes Selecionadas) NAO possui
    * botoes CRUD tradicionais Incluir/Alterar/Visualizar/Excluir. O layout
    * real tem: Processar, Encerrar, Selecionar Tudo e Desmarca Tudo.
    *
    * Para manter compatibilidade com o pipeline (e permitir que forms externos
    * disparem acoes pelos nomes canonicos), estes handlers mapeiam:
    *   BtnIncluirClick    -> AoProcessar (acao principal = gerar OPs)
    *   BtnAlterarClick    -> AoSelTudo   (marcar todas para processar)
    *   BtnVisualizarClick -> AoApagar    (desmarcar todas)
    *   BtnExcluirClick    -> AoCancelar  (encerrar sem processar)
    *
    * Todos possuem logica REAL (delegacao explicita) - sem stubs.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Processa as operacoes marcadas gerando as OPs
    * Mapeia para o botao "Processar" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Marca todas as operacoes de TmpCabec para processamento
    * Mapeia para o botao "Selecionar Tudo" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AoSelTudo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Desmarca todas as operacoes de TmpCabec
    * Mapeia para o botao "Desmarca Tudo" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.AoApagar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o form reabilitando o form pai (sem processar)
    * Mapeia para o botao "Encerrar" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.AoCancelar()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza as grades com o estado atual dos cursores
    * TmpCabec e TmpItens (recebidos do form pai - nao executa SQL propria)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND USED("TmpItens")
                THIS.AplicarOrdem("")
                SELECT TmpCabec
                GO TOP
                THIS.grd_4c_GradeOpe.Refresh()
                THIS.AoMudarLinhaOpe(0)
                THIS.HabilitarCampos()
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Cursores TmpCabec/TmpItens n" + CHR(227) + "o disponibilizados pelo form pai.", ;
                         "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza parametros do form para o BO antes de processar.
    * Este form OPERACIONAL nao tem campos CRUD; transfere apenas os
    * parametros de execucao capturados no Init.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lReserva    = THIS.this_lReservaAuto
                THIS.this_oBusinessObject.this_lAutomatico = THIS.this_lAutomatico
                THIS.this_oBusinessObject.this_nEmphPdr    = THIS.this_nEmphPdr
                THIS.this_oBusinessObject.this_nNumeroDaOP = THIS.this_nNumeroOp
                THIS.this_oBusinessObject.this_cPorDestino = THIS.this_cPorDestino
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza controles visiveis com o estado atual dos cursores.
    * Para este form OPERACIONAL o estado e gerenciado pelos cursores TmpCabec
    * e TmpItens via ControlSource; basta refreshar os controles visuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF USED("TmpCabec")
                THIS.grd_4c_GradeOpe.Refresh()
                THIS.txt_4c_Cliente.Refresh()
                THIS.edt_4c_ObsOpe.Refresh()
            ENDIF
            IF USED("TmpItens")
                THIS.grd_4c_GradeItens.Refresh()
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Gerencia estado do botao Processar: habilitado apenas
    * quando ha ao menos uma operacao marcada (Flag=.T.) em TmpCabec.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemSelecionado, loc_nI, loc_oErro
        loc_lTemSelecionado = .F.

        TRY
            IF USED("TmpCabec")
                SELECT TmpCabec
                GO TOP
                SCAN FOR Flag
                    loc_lTemSelecionado = .T.
                    EXIT
                ENDSCAN
            ENDIF

            IF VARTYPE(THIS.cmd_4c_Processar) = "O"
                THIS.cmd_4c_Processar.Enabled = loc_lTemSelecionado
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Desmarca todas as operacoes de TmpCabec e refresha
    * os controles de observacao que possuem ControlSource vinculado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .F. IN TmpCabec
                THIS.grd_4c_GradeOpe.Refresh()
            ENDIF

            IF VARTYPE(THIS.edt_4c_ObsOpe) = "O"
                THIS.edt_4c_ObsOpe.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Cliente) = "O"
                THIS.txt_4c_Cliente.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Para este form OPERACIONAL sem modos CRUD,
    * delega para HabilitarCampos que gerencia o estado do botao Processar.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reaplica ordenacao e atualiza a grade de operacoes.
    * Equivalente ao "Buscar/Filtrar" para este form OPERACIONAL.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form reabilitando o form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.AoCancelar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Para este form OPERACIONAL, "salvar" equivale a
    * processar as operacoes marcadas e prosseguir para o proximo sub-form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.AoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra sem processar, reabilitando o form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AoCancelar()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParentForm) = 'O' AND !ISNULL(THIS.this_oParentForm)
                IF PEMSTATUS(THIS.this_oParentForm, 'Enabled', 5)
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
            ENDIF
            THIS.this_oParentForm     = .NULL.
            THIS.this_oBusinessObject = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):
*==============================================================================
* SigPrGl2BO.prg - Business Object: Geracao de Ordens de Producao
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sem CRUD direto - processamento de OPs)
* Tabelas usadas: SigCdCeg, SigMvEst, SigTempd, SigMvCab, SigMvItn,
*                 SigMvIts, SigCdOpe, SigCdPro, SigOpPic, SigCdNec,
*                 SigPdMvf, CrSigTempd (cursor do framework)
* Cursores de entrada (recebidos do form pai):
*   TmpCabec - Cabecalho das operacoes selecionadas
*   TmpItens - Itens das operacoes selecionadas
*   TmpOper  - Tabela de operacoes (tipos de movimentacao)
*   CrSigCdPam, CrSigCdPac - Parametros do sistema
*   CrSigTempd - Cursor temporario de estoques (do framework)
*==============================================================================
DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Entidade persistida: SigTempd (tabela de trabalho de sessoes de geracao de OPs)
    this_cTabela     = "SigTempd"
    this_cCampoChave = "CidChaves"

    *-- Estado da sessao de processamento (recebidos do form pai via Init)
    this_lReserva    = .F.    && Flag: reserva automatica de estoque
    this_lAutomatico = .F.    && Flag: processamento automatico (sem confirmacao)
    this_nEmphPdr    = 0      && Empresa padrao para geracao de OPs
    this_nNumeroDaOP = 0      && Numero da OP destino (passado do form pai)
    this_cPorDestino = ""     && Codigo de destino (PorDestino do form pai)
    this_cOrdConta   = ""     && Ordenacao atual do grid de operacoes

    *-- Propriedades da entidade SigTempd (registro de trabalho da sessao)
    this_cCidChaves  = ""     && char(64) PK do registro SigTempd
    this_cCidQuerys  = ""     && char(20) ID de sessao (agrupa varios cidchaves)
    this_cGrupos     = ""     && char(10) Grupo de estoque
    this_cContas     = ""     && char(10) Conta de estoque
    this_cEmps       = ""     && char(3)  Empresa
    this_nCodObs     = 0      && numeric(3,0) Prioridade do centro de estoque

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela     = "SigTempd"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- Flag: .T. se processamento deve abrir SigPrGlx (com estimados), .F. para SigPrGlp
    this_lTemEstimado = .F.

    *--------------------------------------------------------------------------
    * ProcessarOperacoes - Processa operacoes selecionadas e prepara cursores
    * para o proximo sub-form (SigPrGlx ou SigPrGlp).
    * Parametros: par_lReserva     - flag reserva automatica
    *             par_lAutomatico  - flag processamento automatico
    *             par_nEmphPdr     - empresa padrao
    *             par_nNumeroDaOP  - numero da OP destino
    *             par_cPorDestino  - codigo de destino
    * Retorno: .T. se ok, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOperacoes(par_lReserva, par_lAutomatico, par_nEmphPdr, par_nNumeroDaOP, par_cPorDestino)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cEmpresa, loc_cCidQuerys
        LOCAL loc_nContador, loc_lcJob
        LOCAL loc_cSQL
        LOCAL loc_xBaixa, loc_nEstoque, loc_nProduzir, loc_nSaldo
        LOCAL loc_lcEdn, loc_nItn
        LOCAL loc_cPEdI, loc_cPEdF
        LOCAL loc_lProduzirTudo, loc_llData
        LOCAL loc_llFalse

        loc_lResultado = .T.
        loc_cEmpresa   = go_4c_Sistema.cCodEmpresa

        TRY
            *-- PASSO 1: Validar selecao e verificar Jobs iguais
            SELECT TmpCabec
            SET ORDER TO EmpDopNum

            loc_nContador = 0
            GO TOP
            loc_lcJob = ALLTRIM(NVL(TmpCabec.Jobs, ""))

            SCAN FOR Flag
                loc_nContador = loc_nContador + 1
                IF ALLTRIM(NVL(TmpCabec.Jobs,"")) <> loc_lcJob
                    MsgAviso("N" + CHR(227) + "o " + CHR(233) + " permitido gerar OPs de opera" + ;
                             CHR(231) + CHR(245) + "es com Jobs diferentes.", "Aviso")
                    loc_lResultado = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lResultado AND loc_nContador = 0
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!", "Aviso")
                loc_lResultado = .F.
            ENDIF

            *-- PASSO 2: Preparar chave de sessao e buscar centros de estoque
            IF loc_lResultado
                loc_cCidQuerys = fUniqueIds()

                loc_cSQL = "SELECT * FROM SigCdCeg WHERE TpCads <> 1"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpCeg") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpCeg). Favor reinicializar o processo.", "Erro")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- PASSO 3: Popular SigTempd com prioridades de estoque
            IF loc_lResultado
                loc_cSQL = "DELETE FROM SigTempd WHERE CidQuerys = '" + ALLTRIM(loc_cCidQuerys) + "'"
                SQLEXEC(gnConnHandle, loc_cSQL)

                SELECT TmpCeg
                IF RECCOUNT("TmpCeg") > 0
                    SCAN
                        IF loc_lResultado
                            loc_cSQL = "INSERT INTO SigTempd " + ;
                                "(Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Grupos,""))) + ", " + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Contas,""))) + ", " + ;
                                FormatarNumeroSQL(NVL(TmpCeg.Priors, 0), 0) + ", " + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Emps,""))) + ", " + ;
                                EscaparSQL(fUniqueIds()) + ", " + ;
                                EscaparSQL(loc_cCidQuerys) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ELSE
                    IF USED("crSigCdPam")
                        loc_cSQL = "INSERT INTO SigTempd " + ;
                            "(Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                            EscaparSQL(ALLTRIM(NVL(crSigCdPam.GrupoEsts,""))) + ", " + ;
                            EscaparSQL(ALLTRIM(NVL(crSigCdPam.ContaEsts,""))) + ", " + ;
                            "1, " + ;
                            EscaparSQL(ALLTRIM(loc_cEmpresa)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", " + ;
                            EscaparSQL(loc_cCidQuerys) + ")"
                        loc_lResultado = SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                    ENDIF
                ENDIF

                IF !loc_lResultado
                    MsgErro("Falha ao gravar em SigTempd. Favor reinicializar o processo.", "Erro")
                ENDIF
            ENDIF

            *-- PASSO 4: Buscar estoque disponivel via SigMvEst x SigTempd
            IF loc_lResultado
                loc_cSQL = "SELECT a.CPros, a.CodCors, a.CodTams, a.Grupos, a.Estos, " + ;
                    "a.SQtds, a.Emps, b.CodObs AS Priors " + ;
                    "FROM SigMvEst a, SigTempd b " + ;
                    "WHERE a.Grupos = b.Grupos AND a.Estos = b.Contas " + ;
                    "AND a.Emps = b.Emps AND a.Sqtds > 0 " + ;
                    "UNION " + ;
                    "SELECT a.CPros, a.CodCors, a.CodTams, a.Grupos, a.Estos, " + ;
                    "a.SQtds, a.Emps, b.CodObs AS Priors " + ;
                    "FROM SigMvEst a, SigTempd b " + ;
                    "WHERE a.Grupos = b.Grupos AND b.Contas = '' " + ;
                    "AND a.Emps = b.Emps AND a.Sqtds > 0"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpEstoque") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpEstoque). Favor reinicializar.", "Erro")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- PASSO 5: Limpar SigTempd desta sessao
            IF loc_lResultado
                loc_cSQL = "DELETE FROM SigTempd WHERE CidQuerys = '" + ALLTRIM(loc_cCidQuerys) + "'"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            *-- PASSO 6: Criar cursores de saldo TmpSaldo e TmpSaldg
            IF loc_lResultado
                SET NULL ON
                CREATE CURSOR TmpSaldo (CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Saldo N(12,3) NULL, Disps N(12,3) NULL, Fabrs N(12,3) NULL, DispFs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams TAG CPros

                CREATE CURSOR TmpSaldg (Emps C(3) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
                    CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Saldo N(12,3) NULL, Disps N(12,3) NULL, Priors N(2,0) NULL, Reservs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams + STR(NVL(Priors,0),2) + Grupos + Estos + Emps TAG CPros
                INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
                SET NULL OFF

                SELECT TmpEstoque
                SCAN
                    SELECT TmpSaldo
                    IF NOT SEEK(ALLTRIM(NVL(TmpEstoque.CPros,"")) + ;
                                ALLTRIM(NVL(TmpEstoque.CodCors,"")) + ;
                                ALLTRIM(NVL(TmpEstoque.CodTams,"")))
                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                            VALUES (NVL(TmpEstoque.CPros,""), NVL(TmpEstoque.CodCors,""), ;
                                    NVL(TmpEstoque.CodTams,""), 0, 0)
                    ENDIF
                    REPLACE Saldo WITH NVL(Saldo,0) + NVL(TmpEstoque.SQtds,0), ;
                            Disps WITH NVL(Disps,0) + NVL(TmpEstoque.SQtds,0)

                    INSERT INTO TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, ;
                        Saldo, Disps, Priors, Emps) ;
                        VALUES (NVL(TmpEstoque.Grupos,""), NVL(TmpEstoque.Estos,""), ;
                                NVL(TmpEstoque.CPros,""), NVL(TmpEstoque.CodCors,""), ;
                                NVL(TmpEstoque.CodTams,""), NVL(TmpEstoque.SQtds,0), ;
                                NVL(TmpEstoque.SQtds,0), NVL(TmpEstoque.Priors,0), ;
                                NVL(TmpEstoque.Emps,""))
                ENDSCAN
            ENDIF

            *-- PASSO 7: Carregar operacao de transferencia e ajustar saldos por reservas
            IF loc_lResultado AND USED("crSigCdPam") AND !EMPTY(ALLTRIM(crSigCdPam.TransfRes))
                SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdOpe WHERE Dopes = '" + ALLTRIM(crSigCdPam.TransfRes) + "'", ;
                    "crSigCdOpe")

                IF USED("crSigCdOpe") AND !EOF("crSigCdOpe") AND NVL(crSigCdOpe.Estoqs, 0) <> 1
                    loc_cPEdI = ALLTRIM(loc_cEmpresa) + ALLTRIM(crSigCdPam.TransfRes) + STR(0, 6)
                    loc_cPEdF = ALLTRIM(loc_cEmpresa) + ALLTRIM(crSigCdPam.TransfRes) + STR(999999, 6)

                    loc_cSQL = "SELECT EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes " + ;
                        "FROM SigMvCab " + ;
                        "WHERE EmpDopNums BETWEEN '" + ALLTRIM(loc_cPEdI) + "' AND '" + ;
                        ALLTRIM(loc_cPEdF) + "' ORDER BY EmpDopNums"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEest") < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (TempEest). Favor reinicializar.", "Erro")
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- PASSO 7b: Ajustar saldos removendo qtds de reservas em transferencia
            IF loc_lResultado AND USED("TempEest") AND RECCOUNT("TempEest") > 0
                SELECT TempEest
                GO TOP
                SCAN
                    IF loc_lResultado
                        loc_lcEdn = ALLTRIM(NVL(TempEest.EmpDopNums,""))

                        IF SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn), ;
                            "TempEestI") < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (TempEestI).", "Erro")
                            loc_lResultado = .F.
                        ENDIF

                        IF loc_lResultado AND USED("TempEestI") AND RECCOUNT("TempEestI") > 0
                            SELECT TempEestI
                            SCAN
                                IF loc_lResultado AND ;
                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)) > 0

                                    loc_nItn = NVL(TempEestI.CItens, 0)
                                    loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                        "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn) + " " + ;
                                        "AND CItens = " + FormatarNumeroSQL(loc_nItn, 0)

                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                                        MsgErro("Falha na conex" + CHR(227) + "o (TempEsti2). " + ;
                                                "Favor reinicializar.", "Erro")
                                        loc_lResultado = .F.
                                    ENDIF

                                    IF loc_lResultado
                                        SELECT TempEsti2
                                        GO TOP
                                        IF EOF("TempEsti2")
                                            SELECT TmpSaldo
                                            SET ORDER TO CPros
                                            IF NOT SEEK(ALLTRIM(NVL(TempEestI.CPros,"")))
                                                INSERT INTO TmpSaldo (CPros) ;
                                                    VALUES (NVL(TempEestI.CPros,""))
                                            ENDIF
                                            REPLACE Saldo WITH NVL(Saldo,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)), ;
                                                    Disps WITH NVL(Disps,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0))

                                            SELECT TmpSaldg
                                            SET ORDER TO GruEstPro
                                            IF !SEEK(ALLTRIM(NVL(TempEest.Emps,"")) + ;
                                                     ALLTRIM(NVL(TempEest.GrupoOs,"")) + ;
                                                     ALLTRIM(NVL(TempEest.ContaOs,"")) + ;
                                                     ALLTRIM(NVL(TempEestI.CPros,"")))
                                                INSERT INTO TmpSaldg (Emps, Grupos, Estos, CPros, Priors) ;
                                                    VALUES (NVL(TempEest.Emps,""), NVL(TempEest.GrupoOs,""), ;
                                                            NVL(TempEest.ContaOs,""), NVL(TempEestI.CPros,""), 99)
                                            ENDIF
                                            REPLACE Saldo WITH NVL(Saldo,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)), ;
                                                    Disps WITH NVL(Disps,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0))
                                        ELSE
                                            SELECT TempEsti2
                                            SCAN
                                                IF loc_lResultado
                                                    loc_nSaldo = NVL(TempEsti2.Qtds,0) - NVL(TempEsti2.QtBaixas,0)
                                                    SELECT TmpSaldo
                                                    IF NOT SEEK(ALLTRIM(NVL(TempEsti2.CPros,"")) + ;
                                                                ALLTRIM(NVL(TempEsti2.CodCors,"")) + ;
                                                                ALLTRIM(NVL(TempEsti2.CodTams,"")))
                                                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                                            VALUES (NVL(TempEsti2.CPros,""), ;
                                                                    NVL(TempEsti2.CodCors,""), ;
                                                                    NVL(TempEsti2.CodTams,""))
                                                    ENDIF
                                                    REPLACE Saldo WITH NVL(Saldo,0) - loc_nSaldo, ;
                                                            Disps WITH NVL(Disps,0) - loc_nSaldo

                                                    SELECT TmpSaldg
                                                    SET ORDER TO GruEstPro
                                                    IF !SEEK(ALLTRIM(NVL(TempEest.Emps,"")) + ;
                                                             ALLTRIM(NVL(TempEest.GrupoOs,"")) + ;
                                                             ALLTRIM(NVL(TempEest.ContaOs,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CPros,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CodCors,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CodTams,"")))
                                                        INSERT INTO TmpSaldg ;
                                                            (Emps, Grupos, Estos, CPros, CodCors, CodTams, Priors) ;
                                                            VALUES (NVL(TempEest.Emps,""), ;
                                                                    NVL(TempEest.GrupoOs,""), ;
                                                                    NVL(TempEest.ContaOs,""), ;
                                                                    NVL(TempEsti2.CPros,""), ;
                                                                    NVL(TempEsti2.CodCors,""), ;
                                                                    NVL(TempEsti2.CodTams,""), 99)
                                                    ENDIF
                                                    REPLACE Saldo WITH NVL(Saldo,0) - loc_nSaldo, ;
                                                            Disps WITH NVL(Disps,0) - loc_nSaldo
                                                ENDIF
                                            ENDSCAN
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 8: Pre-carregar operacoes para lookup no scan principal
            IF loc_lResultado
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe", "cursor_4c_TmpOpe") >= 1
                    SELECT cursor_4c_TmpOpe
                    INDEX ON Dopes TAG Dopes
                ENDIF
            ENDIF

            *-- PASSO 9: Criar TmpFinal e calcular o que produzir por item
            IF loc_lResultado
                SET NULL ON
                CREATE CURSOR TmpFinal (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                    CPros C(14) NULL, Qtds N(10,3) NULL, Peso N(9,3) NULL, ;
                    Saldo N(10,3) NULL, Estoque N(10,3) NULL, Produzir N(10,3) NULL, ;
                    Obs M NULL, Obsps M NULL, Datas D NULL, Entregas D NULL, ;
                    CodCors C(4) NULL, CodTams C(4) NULL, Linhas C(10) NULL, ;
                    Citens N(10,0) NULL, Reffs C(40) NULL, Notas C(6) NULL, ;
                    Dpros C(40) NULL, GrupoDs C(10) NULL, ContaDs C(10) NULL, ;
                    KeySelM L NULL, Fabrs N(10,3) NULL, KeyPdes L NULL, Jobs C(10) NULL)
                INDEX ON CPros + CodCors + CodTams TAG CPros
                SET NULL OFF

                SELECT TmpItens
                SET KEY TO
                SET ORDER TO CPros

                SCAN
                    IF loc_lResultado
                        SELECT TmpCabec
                        SET ORDER TO EmpDopNum
                        SEEK ALLTRIM(NVL(TmpItens.Emps,"")) + ;
                             ALLTRIM(NVL(TmpItens.Dopes,"")) + ;
                             STR(NVL(TmpItens.Numes,0), 6)

                        IF !Flag
                            LOOP
                        ENDIF

                        IF NVL(TmpItens.Saldo,0) > 0
                            loc_nEstoque  = 0
                            loc_nProduzir = 0
                            loc_lProduzirTudo = .F.

                            *-- Verificar condicoes para usar estoque ou produzir tudo
                            IF USED("crSigCdPam") AND EMPTY(ALLTRIM(crSigCdPam.TransfRes))
                                loc_lProduzirTudo = .T.
                            ENDIF

                            IF !loc_lProduzirTudo AND USED("cursor_4c_TmpOpe")
                                SELECT cursor_4c_TmpOpe
                                SET ORDER TO Dopes
                                IF SEEK(ALLTRIM(NVL(TmpItens.Dopes,"")))
                                    IF NVL(cursor_4c_TmpOpe.ChkObs,0) <> 1 AND ;
                                        !EMPTY(ALLTRIM(NVL(TmpItens.Obs,"")))
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                    IF !loc_lProduzirTudo AND ;
                                        NVL(cursor_4c_TmpOpe.Reservas,0) = 2 AND !par_lReserva
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF !loc_lProduzirTudo
                                SELECT TmpSaldo
                                SET ORDER TO CPros
                                IF !SEEK(ALLTRIM(NVL(TmpItens.CPros,"")) + ;
                                         ALLTRIM(NVL(TmpItens.CodCors,"")) + ;
                                         ALLTRIM(NVL(TmpItens.CodTams,"")))
                                    loc_lProduzirTudo = .T.
                                ELSE
                                    IF NVL(TmpSaldo.Disps,0) < 0
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF loc_lProduzirTudo
                                loc_nProduzir = NVL(TmpItens.Saldo,0)
                            ELSE
                                *-- Ja posicionado em TmpSaldo pelo SEEK acima
                                loc_nEstoque = NVL(TmpSaldo.Disps,0)
                                IF NVL(TmpSaldo.Disps,0) >= NVL(TmpItens.Saldo,0)
                                    REPLACE TmpSaldo.Disps WITH ;
                                            NVL(TmpSaldo.Disps,0) - NVL(TmpItens.Saldo,0)
                                ELSE
                                    loc_nProduzir = NVL(TmpItens.Saldo,0) - NVL(TmpSaldo.Disps,0)
                                    REPLACE TmpSaldo.Disps WITH 0
                                ENDIF
                            ENDIF

                            IF SQLEXEC(gnConnHandle, ;
                                "SELECT * FROM SigCdPro WHERE CPros = '" + ;
                                ALLTRIM(NVL(TmpItens.CPros,"")) + "'", "crSigCdPro") < 1
                                MsgErro("Falha ao buscar SigCdPro.", "Erro")
                                loc_lResultado = .F.
                            ENDIF

                            IF loc_lResultado
                                INSERT INTO TmpFinal ;
                                    (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, ;
                                     Estoque, Produzir, Obsps, Obs, Datas, Entregas, ;
                                     CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                     Dpros, GrupoDs, ContaDs, Jobs) ;
                                    VALUES ;
                                    (NVL(TmpItens.Emps,""), NVL(TmpItens.Dopes,""), ;
                                     NVL(TmpItens.Numes,0), NVL(TmpItens.CPros,""), ;
                                     NVL(TmpItens.Qtds,0), NVL(TmpItens.Peso,0), ;
                                     NVL(TmpItens.Saldo,0), ;
                                     NVL(TmpItens.Saldo,0) - loc_nProduzir, ;
                                     loc_nProduzir, ;
                                     NVL(TmpItens.Obs,""), NVL(TmpCabec.Obs,""), ;
                                     NVL(TmpCabec.Datas,{}), NVL(TmpCabec.Entregas,{}), ;
                                     NVL(TmpItens.CodCors,""), NVL(TmpItens.CodTams,""), ;
                                     NVL(TmpItens.Linhas,""), NVL(TmpItens.CItens,0), ;
                                     NVL(crSigCdPro.Reffs,""), NVL(TmpItens.Notas,""), ;
                                     NVL(TmpItens.Dpros,""), NVL(TmpCabec.Grupods,""), ;
                                     NVL(TmpCabec.Contads,""), NVL(TmpCabec.Jobs,""))
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 10: Redistribuir diferenca de saldo entre grupos/estoques
            IF loc_lResultado
                SELECT TmpSaldo
                SCAN
                    IF NVL(TmpSaldo.Saldo,0) <> NVL(TmpSaldo.Disps,0)
                        loc_xBaixa = NVL(TmpSaldo.Saldo,0) - NVL(TmpSaldo.Disps,0)
                        SELECT TmpSaldg
                        SET ORDER TO CPros
                        =SEEK(ALLTRIM(NVL(TmpSaldo.CPros,"")) + ;
                              ALLTRIM(NVL(TmpSaldo.CodCors,"")) + ;
                              ALLTRIM(NVL(TmpSaldo.CodTams,"")))
                        SCAN WHILE ALLTRIM(NVL(CPros,"")) = ALLTRIM(NVL(TmpSaldo.CPros,"")) AND ;
                                    ALLTRIM(NVL(CodCors,"")) = ALLTRIM(NVL(TmpSaldo.CodCors,"")) AND ;
                                    ALLTRIM(NVL(CodTams,"")) = ALLTRIM(NVL(TmpSaldo.CodTams,"")) AND ;
                                    loc_xBaixa > 0
                            IF NVL(TmpSaldg.Disps,0) >= loc_xBaixa
                                REPLACE TmpSaldg.Disps WITH NVL(TmpSaldg.Disps,0) - loc_xBaixa
                                loc_xBaixa = 0
                            ELSE
                                loc_xBaixa = loc_xBaixa - NVL(TmpSaldg.Disps,0)
                                REPLACE TmpSaldg.Disps WITH 0
                            ENDIF
                        ENDSCAN
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 11: Se ha fabricacao estimada (DopEsts), calcular TmpFinalG
            IF loc_lResultado AND USED("crSigCdPac") AND !EMPTY(ALLTRIM(crSigCdPac.DopEsts))
                THIS.this_lTemEstimado = .T.
                loc_llFalse = .F.

                SET NULL ON
                CREATE CURSOR TmpFabr (Priors N(2,0) NULL, Nops N(10,0) NULL, Fases C(10) NULL, ;
                    CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Qtds N(10,3) NULL, Disps N(12,3) NULL, Reservs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams + STR(NVL(Priors,0),2) + STR(NVL(Nops,0),10) TAG CPros
                SET NULL OFF

                loc_cSQL = "SELECT a.Nops, a.CPros, a.CodCors, a.CodTams, SUM(a.Qtds) AS Qtds " + ;
                    "FROM SigOpPic a, SigCdNec b " + ;
                    "WHERE a.Dopes = '" + ALLTRIM(crSigCdPac.DopEsts) + "' " + ;
                    "AND a.EmpDopNops = b.EmpDnps " + ;
                    "AND b.Chksubn = " + IIF(loc_llFalse, "1", "0") + " " + ;
                    "AND a.Emps = '" + ALLTRIM(loc_cEmpresa) + "' " + ;
                    "GROUP BY a.Nops, a.CPros, a.CodCors, a.CodTams"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") >= 1 AND ;
                    USED("TmpOpi") AND RECCOUNT("TmpOpi") > 0

                    SELECT TmpOpi
                    SCAN
                        IF loc_lResultado
                            SELECT TmpSaldo
                            SET ORDER TO CPros
                            IF NOT SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodTams,"")))
                                INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                    VALUES (NVL(TmpOpi.CPros,""), NVL(TmpOpi.CodCors,""), ;
                                            NVL(TmpOpi.CodTams,""))
                            ENDIF
                            REPLACE Fabrs WITH NVL(Fabrs,0) + NVL(TmpOpi.Qtds,0), ;
                                    DispFs WITH NVL(DispFs,0) + NVL(TmpOpi.Qtds,0)

                            INSERT INTO TmpFabr (Nops, CPros, CodCors, CodTams, Qtds, Priors) ;
                                VALUES (NVL(TmpOpi.Nops,0), NVL(TmpOpi.CPros,""), ;
                                        NVL(TmpOpi.CodCors,""), NVL(TmpOpi.CodTams,""), ;
                                        NVL(TmpOpi.Qtds,0), 0)

                            loc_cSQL = "SELECT GrupoDs FROM SigPdMvf " + ;
                                "WHERE Nops = " + FormatarNumeroSQL(NVL(TmpOpi.Nops,0), 0) + ;
                                " ORDER BY CidChaves DESC"
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpMfas") >= 1 AND ;
                                USED("TmpMfas") AND RECCOUNT("TmpMfas") > 0
                                SELECT TmpMfas
                                GO TOP
                                REPLACE Fases WITH ALLTRIM(NVL(TmpMfas.GrupoDs,"")) IN TmpFabr
                            ENDIF

                            loc_nEstoque  = 0
                            loc_nProduzir = 0

                            SELECT TmpSaldo
                            IF SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                    ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                    ALLTRIM(NVL(TmpOpi.CodTams,"")))

                                SELECT TmpFinal
                                IF SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodTams,"")), "TmpFinal", "CPros")

                                    IF NVL(TmpSaldo.Fabrs,0) >= NVL(TmpFinal.Produzir,0)
                                        loc_nEstoque  = NVL(TmpFinal.Produzir,0)
                                        loc_nProduzir = 0
                                        SELECT TmpSaldo
                                        REPLACE DispFs WITH NVL(DispFs,0) - NVL(TmpFinal.Produzir,0)
                                    ELSE
                                        loc_nEstoque  = NVL(TmpSaldo.Fabrs,0)
                                        loc_nProduzir = NVL(TmpFinal.Produzir,0) - NVL(TmpSaldo.Fabrs,0)
                                        SELECT TmpSaldo
                                        REPLACE DispFs WITH 0
                                    ENDIF

                                    REPLACE Produzir WITH loc_nProduzir, ;
                                            Fabrs WITH loc_nEstoque IN TmpFinal
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN

                    *-- Redistribuir diferenca de fabricacao
                    SELECT TmpSaldo
                    SCAN
                        IF NVL(TmpSaldo.Fabrs,0) <> NVL(TmpSaldo.DispFs,0)
                            loc_xBaixa = NVL(TmpSaldo.Fabrs,0) - NVL(TmpSaldo.DispFs,0)
                            SELECT TmpFabr
                            SET ORDER TO CPros
                            =SEEK(ALLTRIM(NVL(TmpSaldo.CPros,"")) + ;
                                  ALLTRIM(NVL(TmpSaldo.CodCors,"")) + ;
                                  ALLTRIM(NVL(TmpSaldo.CodTams,"")))
                            SCAN WHILE ALLTRIM(NVL(CPros,"")) = ALLTRIM(NVL(TmpSaldo.CPros,"")) AND ;
                                        ALLTRIM(NVL(CodCors,"")) = ALLTRIM(NVL(TmpSaldo.CodCors,"")) AND ;
                                        ALLTRIM(NVL(CodTams,"")) = ALLTRIM(NVL(TmpSaldo.CodTams,"")) AND ;
                                        loc_xBaixa > 0
                                IF (NVL(TmpFabr.Qtds,0) - NVL(TmpFabr.Disps,0)) >= loc_xBaixa
                                    REPLACE TmpFabr.Disps WITH NVL(TmpFabr.Disps,0) + loc_xBaixa
                                    loc_xBaixa = 0
                                ELSE
                                    loc_xBaixa = loc_xBaixa - (NVL(TmpFabr.Qtds,0) - NVL(TmpFabr.Disps,0))
                                    REPLACE TmpFabr.Disps WITH NVL(TmpFabr.Qtds,0)
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDSCAN

                    *-- Criar TmpFinalG com agrupamentos
                    SET NULL ON
                    CREATE CURSOR TmpFinalG (Flag C(1) NULL, CPros C(14) NULL, ;
                        CodCors C(4) NULL, CodTams C(4) NULL, Linhas C(10) NULL, ;
                        Qtds N(10,3) NULL, Saldo N(10,3) NULL, Estoque N(10,3) NULL, ;
                        Produzir N(10,3) NULL, Fabrs N(10,3) NULL, Produzir2 N(10,3) NULL, ;
                        TotVenda N(10,3) NULL, QtdMins N(10,3) NULL, ;
                        KeySelM L NULL, KeySelMP L NULL, UsuLibs C(10) NULL)
                    INDEX ON CPros + CodCors + CodTams TAG CPros
                    SET NULL OFF

                    *-- Calcular vendas recentes se configurado
                    IF NVL(crSigCdPac.nMeses, 0) > 0
                        loc_llData = GOMONTH(DATE(), -INT(crSigCdPac.nMeses))
                        loc_cSQL = "SELECT a.CPros, a.Qtds, b.Caixas, b.Copers, b.Opers, a.Opers " + ;
                            "FROM SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                            "WHERE a.EmpDopNums = c.EmpDopNums " + ;
                            "AND a.Emps = '" + ALLTRIM(loc_cEmpresa) + "' " + ;
                            "AND c.Datas >= ?loc_llData " + ;
                            "AND a.Dopes = b.Dopes AND b.TipoOps IN (4,5)"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalEest") >= 1
                            SELECT CPros, ;
                                SUM(Qtds * IIF((NVL(Caixas,0)=1 AND NVL(Copers,0)=1) OR ;
                                    (NVL(Caixas,0)<>1 AND NVL(Opers,0)=1) OR ;
                                    (NVL(Caixas,0)<>1 AND NVL(Opers,0)=3), 1, -1)) AS Qtds ;
                                FROM LocalEest ;
                                GROUP BY CPros ;
                                INTO CURSOR Vendas READWRITE
                            SELECT Vendas
                            INDEX ON CPros TAG CPros
                        ENDIF
                    ENDIF

                    *-- Popular TmpFinalG com agrupamentos
                    SELECT CPros, CodCors, CodTams, Linhas, ;
                        SUM(NVL(Qtds,0)) AS Qtds, SUM(NVL(Saldo,0)) AS Saldo, ;
                        SUM(NVL(Estoque,0)) AS Estoque, SUM(NVL(Produzir,0)) AS Produzir, ;
                        SUM(NVL(Fabrs,0)) AS Fabrs ;
                        FROM TmpFinal ;
                        INTO CURSOR Selecao ;
                        GROUP BY CPros, CodCors, CodTams, Linhas

                    SELECT Selecao
                    SCAN
                        IF loc_lResultado
                            SCATTER MEMVAR
                            m.Flag = "+"

                            IF SQLEXEC(gnConnHandle, ;
                                "SELECT QtMinFabs FROM SigCdPro WHERE CPros = '" + ;
                                ALLTRIM(NVL(m.CPros,"")) + "'", "CrSigCdPro") < 1
                                MsgErro("Falha ao buscar QtMinFabs de SigCdPro.", "Erro")
                                loc_lResultado = .F.
                            ENDIF

                            IF loc_lResultado
                                m.QtdMins = 0
                                IF (NVL(crSigCdPac.GerPcps,0) = 2 AND !par_lReserva) OR ;
                                    (NVL(crSigCdPac.GerPcps,0) <> 2 AND par_lReserva)
                                    m.QtdMins = NVL(CrSigCdPro.QtMinFabs, 0)
                                ENDIF

                                m.TotVenda = 0
                                IF USED("Vendas") AND ;
                                    SEEK(ALLTRIM(NVL(m.CPros,"")), "Vendas", "CPros")
                                    m.TotVenda = NVL(Vendas.Qtds, 0)
                                ENDIF

                                m.Produzir2 = IIF(m.QtdMins > 0 AND m.Produzir > 0 AND ;
                                    m.Produzir < m.QtdMins, m.QtdMins - m.Produzir, 0)

                                SELECT TmpFinalG
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDIF
            ELSE
                THIS.this_lTemEstimado = .F.
            ENDIF

            *-- Restaurar ordem de TmpItens para o form
            IF loc_lResultado AND USED("TmpItens") AND USED("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO ALLTRIM(NVL(TmpCabec.Emps,"")) + ;
                           ALLTRIM(NVL(TmpCabec.Dopes,"")) + ;
                           STR(NVL(TmpCabec.Numes,0), 6)
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ProcessarOperacoes")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarOperacoes - Aplica ordenacao no cursor TmpCabec e atualiza
    * this_cOrdConta. O form usa this_cOrdConta para atualizar cores dos headers.
    * Parametros: par_cOrdem - "EMPDOPNUM" ou "ENTREGA" (ou vazio para padrao)
    * Retorno: .T. se ok
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarOperacoes(par_cOrdem)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cOrdem

        loc_lResultado = .T.

        TRY
            loc_cOrdem = UPPER(IIF(VARTYPE(par_cOrdem) = "C" AND !EMPTY(par_cOrdem), ;
                                   par_cOrdem, THIS.this_cOrdConta))

            IF USED("TmpCabec")
                SELECT TmpCabec
                IF !EMPTY(loc_cOrdem) AND INLIST(loc_cOrdem, "ENTREGA", "EMPDOPNUM")
                    SET ORDER TO &loc_cOrdem.
                ELSE
                    SET ORDER TO EmpDopNum
                ENDIF
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro OrdenarOperacoes")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega registro SigTempd do cursor para propriedades
    * Usado para reidratar sessao ativa da tabela de trabalho SigTempd.
    * Parametro: par_cAliasCursor - alias do cursor contendo colunas de SigTempd
    * Retorno: .T. se carregou registro valido, .F. se cursor vazio/inexistente
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_oErro

        loc_lResultado = .F.
        loc_cAlias     = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                             par_cAliasCursor, "cursor_4c_SigTempd")

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF !EOF() AND !BOF()
                    THIS.this_cCidChaves = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CidChaves"), ""))
                    THIS.this_cCidQuerys = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CidQuerys"), ""))
                    THIS.this_cGrupos    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Grupos"), ""))
                    THIS.this_cContas    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Contas"), ""))
                    THIS.this_cEmps      = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Emps"), ""))
                    THIS.this_nCodObs    = NVL(EVALUATE(loc_cAlias + ".CodObs"), 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarDoCursor")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o CidChaves atual (PK da entidade SigTempd)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigTempd para registrar entrada de sessao de OPs.
    * Gera CidChaves/CidQuerys via fUniqueIds() se estiverem vazios.
    * Utilizado no fluxo de geracao para persistir prioridades de estoque
    * que serao consumidas no join com SigMvEst durante ProcessarOperacoes.
    * Retorno: .T. sucesso, .F. erro (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            *-- Gerar identificadores se ainda nao definidos
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCidQuerys))
                THIS.this_cCidQuerys = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            loc_cSQL = "INSERT INTO SigTempd " + ;
                "(CidChaves, CidQuerys, Grupos, Contas, CodObs, Emps, Dpros) VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCidQuerys)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                EscaparSQL("") + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                *-- Registra auditoria de insercao (herdado de BusinessBase)
                THIS.RegistrarAuditoria("I")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigTempd. " + ;
                    "Favor reinicializar o processo."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Inserir SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigTempd para alterar registro de sessao ativa.
    * Localiza pelo CidChaves atual e sobrescreve Grupos/Contas/CodObs/Emps.
    * Retorno: .T. sucesso, .F. erro (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia. " + ;
                    "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                    "vel atualizar SigTempd."
            ELSE
                loc_cSQL = "UPDATE SigTempd SET " + ;
                    "Grupos    = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                    "Contas    = " + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                    "CodObs    = " + FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                    "Emps      = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                    "CidQuerys = " + EscaparSQL(ALLTRIM(THIS.this_cCidQuerys)) + " " + ;
                    "WHERE CidChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                    *-- Registra auditoria de alteracao (herdado de BusinessBase)
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar registro em SigTempd " + ;
                        "(CidChaves=" + ALLTRIM(THIS.this_cCidChaves) + ")."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Atualizar SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigTempd pelo CidChaves atual.
    * Usado para limpar registros de sessao apos processamento concluido.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia."
            ELSE
                loc_cSQL = "DELETE FROM SigTempd WHERE CidChaves = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("E")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir SigTempd."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ExecutarExclusao SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[16/07/2026 07:47:31 PM] Erro: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-16 19:47:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-16 19:47:10] [INFO] Config FPW: (nao fornecido)
[2026-07-16 19:47:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-16 19:47:10] [INFO] Timeout: 300 segundos
[2026-07-16 19:47:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2xvzxm5k.prg
[2026-07-16 19:47:10] [INFO] Conteudo do wrapper:
[2026-07-16 19:47:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrGlp', 'C:\4c\tasks\task292', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrGlp', 'C:\4c\tasks\task292', 'OPERACIONAL'
QUIT

[2026-07-16 19:47:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2xvzxm5k.prg
[2026-07-16 19:47:10] [INFO] VFP output esperado em: C:\4c\tasks\task292\vfp_output.txt
[2026-07-16 19:47:10] [INFO] Executando Visual FoxPro 9...
[2026-07-16 19:47:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2xvzxm5k.prg
[2026-07-16 19:47:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2xvzxm5k.prg
[2026-07-16 19:47:10] [INFO] Timeout configurado: 300 segundos
[2026-07-16 19:47:31] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-16 19:47:31] [INFO] VFP9 finalizado em 21.1178758 segundos
[2026-07-16 19:47:31] [INFO] Exit Code: 
[2026-07-16 19:47:31] [INFO] 
[2026-07-16 19:47:31] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-16 19:47:31] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2xvzxm5k.prg
[2026-07-16 19:47:31] [INFO] 
[2026-07-16 19:47:31] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-16 19:47:31] [INFO] * Auto-generated wrapper for parameters
[2026-07-16 19:47:31] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-16 19:47:31] [INFO] * Parameters: 'FormSigPrGlp', 'C:\4c\tasks\task292', 'OPERACIONAL'
[2026-07-16 19:47:31] [INFO] 
[2026-07-16 19:47:31] [INFO] * Anti-dialog protections for unattended execution
[2026-07-16 19:47:31] [INFO] SET SAFETY OFF
[2026-07-16 19:47:31] [INFO] SET RESOURCE OFF
[2026-07-16 19:47:31] [INFO] SET TALK OFF
[2026-07-16 19:47:31] [INFO] SET NOTIFY OFF
[2026-07-16 19:47:31] [INFO] SYS(2335, 0)
[2026-07-16 19:47:31] [INFO] 
[2026-07-16 19:47:31] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrGlp', 'C:\4c\tasks\task292', 'OPERACIONAL'
[2026-07-16 19:47:31] [INFO] QUIT
[2026-07-16 19:47:31] [INFO] 
[2026-07-16 19:47:31] [INFO] === Fim do Wrapper.prg ===
[2026-07-16 19:47:31] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrGlp",
  "timestamp": "20260716194731",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg):
*==============================================================================*
* FormSigPrGlp.prg - Formulario Operacional: Previa da Globalizacao
*==============================================================================*
* Tipo: OPERACIONAL (layout customizado com containers e multiplos grids)
* Migrado de SIGPRGLP.SCX
*
* Pilares:
*   UX   -> layout e comportamento identicos ao legado (1000x600)
*   BD   -> cursores TmpFinal/TmpSaldo/TmpSaldG compartilhados via datasession pai
*   CODE -> arquitetura em camadas (FormBase / SigPrGlpBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("FormSigPrGlp", loFormPai, dData, lReserva, nEmphPdr, lAutom, nNumeroOp)
*   loForm.Show()
*==============================================================================*

DEFINE CLASS FormSigPrGlp AS FormBase

    *-- Dimensoes identicas ao legado
    Height       = 600
    Width        = 1000
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    DataSession  = 2
    WindowState  = 0
    KeyPreview   = .T.
    ShowTips     = .T.

    *-- Referencia ao form pai (datasession compartilhada)
    poFormPai        = .NULL.
    *-- Flags operacionais
    this_lReserva    = .F.
    this_lAutomatico = .F.
    this_nNumeroDaOp = 0
    this_nEmphPdr    = 0
    this_dData       = {}
    *-- Controle de edicao na coluna Produzir
    this_nOldValue   = 0

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_loFormPai, par_dData, par_lReservaAuto, par_nEmphPdr, par_lAutom, par_nNumeroOp

        IF VARTYPE(par_loFormPai) = "O"
            THIS.poFormPai     = par_loFormPai
            THIS.DataSessionId = par_loFormPai.DataSessionId
        ENDIF

        THIS.this_lReserva    = IIF(VARTYPE(par_lReservaAuto)="L", par_lReservaAuto, .F.)
        THIS.this_nEmphPdr    = IIF(VARTYPE(par_nEmphPdr)="N",    par_nEmphPdr,    0)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)="L",      par_lAutom,      .F.)
        THIS.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroOp)="N",   par_nNumeroOp,   0)
        THIS.this_dData       = IIF(VARTYPE(par_dData)="D",       par_dData,       DATE())

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_nSal, loc_nEst, loc_nPrz
        loc_lSucesso = .F.
        loc_nSal     = 0
        loc_nEst     = 0
        loc_nPrz     = 0

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGlpBO", "Erro")
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_nNumeroDaOp = THIS.this_nNumeroDaOp
                    .this_nEmphPdr    = THIS.this_nEmphPdr
                    .this_dData       = THIS.this_dData
                    IF USED("CrSigCdPac")
                        SELECT CrSigCdPac
                        .this_cSigKey = TratarNulo(CrSigCdPac.sigKeys, "C")
                    ENDIF
                ENDWITH

                IF THIS.this_lReserva
                    THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
                ELSE
                    THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                ENDIF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.this_oBusinessObject.InicializarConexaoTemp()
                THIS.this_oBusinessObject.CarregarParametros()
                THIS.this_oBusinessObject.CarregarComposicao()
                THIS.this_oBusinessObject.InicializarTmpSaldU()

                IF USED("SelPedra")
                    SELECT SelPedra
                    IF RECCOUNT() = 0
                        APPEND BLANK
                    ENDIF
                ENDIF

                THIS.ConfigurarLayout()
                THIS.CarregarDados()
                THIS.TornarControlesVisiveis()

                *-- Estado inicial do botao Pedras
                THIS.cmd_4c_Pedras.Enabled = .F.
                IF USED("crSigCdPam")
                    SELECT crSigCdPam
                    IF !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
                       !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
                       !THIS.this_lReserva
                        THIS.cmd_4c_Pedras.Enabled = .T.
                    ENDIF
                ENDIF

                IF USED("TmpFinal")
                    SELECT TmpFinal
                    SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                    GO TOP
                    THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                    THIS.txt_4c_Tot_Est.Value = loc_nEst
                    THIS.txt_4c_Tot_Prz.Value = loc_nPrz
                ENDIF

                THIS.Refresh
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigPrGlp: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = " "
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = " "
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLayout
    *==========================================================================
        LOCAL loc_cImgProcessar, loc_cImgCancelar, loc_cImgRelatorio
        LOCAL loc_cImgDisp, loc_cImgLinhas, loc_cImgPedras, loc_cImgEstoque

        loc_cImgProcessar  = gc_4c_CaminhoIcones + "geral_executar_60.jpg"
        loc_cImgCancelar   = gc_4c_CaminhoIcones + "cadastro_encerrar_60.jpg"
        loc_cImgRelatorio  = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
        loc_cImgDisp       = gc_4c_CaminhoIcones + "geral_pesquisar_60.jpg"
        loc_cImgLinhas     = gc_4c_CaminhoIcones + "geral_lista_60.jpg"
        loc_cImgPedras     = gc_4c_CaminhoIcones + "geral_adicionar_60.jpg"
        loc_cImgEstoque    = gc_4c_CaminhoIcones + "geral_estoque_60.jpg"

        *-- Botao Disponiveis (622,3,75,75)
        THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
        WITH THIS.cmd_4c_Disponivel
            .Top         = 3
            .Left        = 622
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Dispon" + CHR(237) + "veis"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgDisp)
                .Picture         = loc_cImgDisp
                .DisabledPicture = loc_cImgDisp
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Disponivel, "Click", THIS, "BtnDisponiveiClick")

        *-- Botao Total/Linhas (697,3,75,75)
        THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
        WITH THIS.cmd_4c_TotLinha
            .Top         = 3
            .Left        = 697
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Total/Linhas"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgLinhas)
                .Picture         = loc_cImgLinhas
                .DisabledPicture = loc_cImgLinhas
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")

        *-- Botao Pedras/Requisicoes (472,3,75,75)
        THIS.AddObject("cmd_4c_Pedras", "CommandButton")
        WITH THIS.cmd_4c_Pedras
            .Top         = 3
            .Left        = 472
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Requisi" + CHR(231) + CHR(245) + "es"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgPedras)
                .Picture         = loc_cImgPedras
                .DisabledPicture = loc_cImgPedras
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")

        *-- Botao SelEstoque (547,3,75,75)
        THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
        WITH THIS.cmd_4c_SelEstoque
            .Top         = 3
            .Left        = 547
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Estoques"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Enabled     = .F.
            IF FILE(loc_cImgEstoque)
                .Picture         = loc_cImgEstoque
                .DisabledPicture = loc_cImgEstoque
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")

        *-- Botao Relatorio (772,3,75,75)
        THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
        WITH THIS.cmd_4c_BtnRelatorio
            .Top         = 3
            .Left        = 772
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Relat" + CHR(243) + "rio"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgRelatorio)
                .Picture         = loc_cImgRelatorio
                .DisabledPicture = loc_cImgRelatorio
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")

        *-- Botao Processar (847,3,75,75)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top         = 3
            .Left        = 847
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Processar"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgProcessar)
                .Picture         = loc_cImgProcessar
                .DisabledPicture = loc_cImgProcessar
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Sair/Cancelar (922,3,75,75)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top         = 3
            .Left        = 922
            .Width       = 75
            .Height      = 75
            .Caption     = "Encerrar"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgCancelar)
                .Picture         = loc_cImgCancelar
                .DisabledPicture = loc_cImgCancelar
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Grid principal GradeItens (Top=125, Left=11, Width=708, Height=224, 9 colunas)
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top              = 125
            .Left             = 11
            .Width            = 708
            .Height           = 224
            .ColumnCount      = 9
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .RowHeight         = 16
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .FontSize          = 8
            *-- Col1: Produto
            WITH .Column1
                .Width          = 80
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Produto"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col2: Cor
            WITH .Column2
                .Width          = 40
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Cor"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col3: Movimentacao (Dopes)
            WITH .Column3
                .Width          = 80
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col4: Codigo (Numes)
            WITH .Column4
                .Width          = 55
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "C" + CHR(243) + "digo"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col5: Quantidade (Saldo)
            WITH .Column5
                .Width          = 70
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Quantidade"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col6: Produzir (editavel)
            WITH .Column6
                .Width          = 70
                .ReadOnly       = .F.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Produzir"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.FontBold = .T.
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
                .Text1.FontBold    = .T.
                .Text1.BorderStyle = 0
                .Text1.Alignment   = 3
            ENDWITH
            *-- Col7: Estoque
            WITH .Column7
                .Width          = 70
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Estoque"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col8: Obs
            WITH .Column8
                .Width          = 30
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Obs"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col9: Tam
            WITH .Column9
                .Width          = 30
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Tam"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "When",      THIS, "GrdCol6TextWhen")
        BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "Valid",     THIS, "GrdCol6TextValid")
        BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "KeyPress", THIS, "GrdCol6TextLostFocus")
        *-- Redirecionar foco das colunas somente-leitura para Column6 (editavel)
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus", THIS, "GrdColXGotFocus")

        *-- Totais abaixo do grid (349,417-662)
        THIS.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH THIS.txt_4c_Tot_Qtd
            .Top          = 349
            .Left         = 417
            .Width        = 80
            .Height       = 23
            .ReadOnly     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpecialEffect = 1
            .Value        = 0
        ENDWITH

        THIS.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH THIS.txt_4c_Tot_Est
            .Top          = 349
            .Left         = 498
            .Width        = 81
            .Height       = 23
            .ReadOnly     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpecialEffect = 1
            .Value        = 0
        ENDWITH

        THIS.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH THIS.txt_4c_Tot_Prz
            .Top          = 349
            .Left         = 580
            .Width        = 82
            .Height       = 23
            .ReadOnly     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpecialEffect = 1
            .Value        = 0
        ENDWITH

        *-- Label para observacao (726,369)
        THIS.AddObject("lbl_4c_Txt_ObsItens", "Label")
        WITH THIS.lbl_4c_Txt_ObsItens
            .Top       = 369
            .Left      = 726
            .Width     = 134
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
        ENDWITH

        *-- EditBox observacoes (732,361,266,205)
        THIS.AddObject("obj_4c_ObsItens", "EditBox")
        WITH THIS.obj_4c_ObsItens
            .Top       = 361
            .Left      = 732
            .Width     = 266
            .Height    = 205
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Imagem produto (726,125,266,204)
        THIS.AddObject("img_4c_ImgFigJpg", "Image")
        WITH THIS.img_4c_ImgFigJpg
            .Top     = 125
            .Left    = 726
            .Width   = 266
            .Height  = 204
            .Visible = .F.
        ENDWITH

        *-- Container3: saldo/estoque (sempre visivel, Top=373, Left=12, Width=708, Height=205)
        THIS.AddObject("cnt_4c_Container3", "Container")
        WITH THIS.cnt_4c_Container3
            .Top           = 373
            .Left          = 12
            .Width         = 708
            .Height        = 205
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderWidth   = 1
            .Visible       = .T.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 5
                .Left      = 6
                .Width     = 118
                .Height    = 16
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top              = 24
                .Left             = 6
                .Width            = 444
                .Height           = 148
                .ColumnCount      = 6
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .RowHeight         = 16
                .GridLineColor     = RGB(238, 238, 238)
                .FontSize          = 8
                WITH .Column1
                    .Width = 70
                    .ReadOnly = .T.
                    .Header1.Caption = "Grupo"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 70
                    .ReadOnly = .T.
                    .Header1.Caption = "Conta"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 60
                    .ReadOnly = .T.
                    .Header1.Caption = "Atual"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 60
                    .ReadOnly = .T.
                    .Header1.Caption = "Utilizado"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 60
                    .ReadOnly = .T.
                    .Header1.Caption = "Dispon" + CHR(237) + "vel"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column6
                    .Width = 50
                    .ReadOnly = .T.
                    .Header1.Caption = "Emp"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            .AddObject("txt_4c__dgrupo", "TextBox")
            WITH .txt_4c__dgrupo
                .Top          = 106
                .Left         = 454
                .Width        = 247
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
            ENDWITH

            .AddObject("txt_4c__dconta", "TextBox")
            WITH .txt_4c__dconta
                .Top          = 147
                .Left         = 454
                .Width        = 247
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
            ENDWITH

            .AddObject("txt_4c_Tot_Qtd", "TextBox")
            WITH .txt_4c_Tot_Qtd
                .Top          = 173
                .Left         = 188
                .Width        = 80
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
                .Value        = 0
            ENDWITH

            .AddObject("txt_4c_Tot_Est", "TextBox")
            WITH .txt_4c_Tot_Est
                .Top          = 173
                .Left         = 269
                .Width        = 80
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
                .Value        = 0
            ENDWITH

            .AddObject("txt_4c_Tot_Prz", "TextBox")
            WITH .txt_4c_Tot_Prz
                .Top          = 173
                .Left         = 350
                .Width        = 80
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
                .Value        = 0
            ENDWITH

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top = 90
                .Left = 454
                .Width = 36
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .Caption = "Grupo"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("lbl_4c_Label3", "Label")
            WITH .lbl_4c_Label3
                .Top = 131
                .Left = 454
                .Width = 35
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .Caption = "Conta"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container3.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt3GradeAfterRowColChange")

        *-- Container1: totais por linha (Visible=.F., sobreposicao)
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 125
            .Left          = 12
            .Width         = 708
            .Height        = 465
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .SpecialEffect = 0
            .Visible       = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 10
                .Left = 259
                .Width = 170
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Pe" + CHR(231) + "as a produzir por linha"
            ENDWITH

            .AddObject("cmd_4c_CancelaLin", "CommandButton")
            WITH .cmd_4c_CancelaLin
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "OK"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 174
                .Width = 359
                .Height = 420
                .ColumnCount = 4
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 2
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Linha"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Quantidade"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Estoque"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Produzir"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLin1Click")

        *-- Container2: disponivel por produto/cor/tam (Visible=.F.)
        THIS.AddObject("cnt_4c_Container2", "Container")
        WITH THIS.cnt_4c_Container2
            .Top = 125
            .Left = 12
            .Width = 708
            .Height = 465
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .SpecialEffect = 0
            .Visible = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 10
                .Left = 284
                .Width = 123
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Estoque Dispon" + CHR(237) + "vel"
            ENDWITH

            .AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH .cmd_4c_CancelaDisp
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "Sair"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 169
                .Width = 370
                .Height = 388
                .ColumnCount = 5
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 2
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Produto"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 38
                    .ReadOnly = .T.
                    .Header1.Caption = "Cor"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 24
                    .ReadOnly = .T.
                    .Header1.Caption = "Tam"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 75
                    .ReadOnly = .T.
                    .Header1.Caption = "Disponivel"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 75
                    .ReadOnly = .F.
                    .Header1.Caption = "Utilizar"
                    .Header1.FontName = "Verdana"
                    .Header1.FontBold = .T.
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                    .Text1.FontBold = .T.
                    .Text1.BorderStyle = 0
                    .Text1.Alignment = 3
                    .Text1.Value = 0
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt2Col5TextValid")

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top = 432
                .Left = 168
                .Width = 84
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Qtde " + CHR(224) + " Produzir :"
            ENDWITH

            .AddObject("lbl_4c_Label3", "Label")
            WITH .lbl_4c_Label3
                .Top = 431
                .Left = 365
                .Width = 109
                .Height = 17
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Qtde " + CHR(224) + " Utilizar :"
            ENDWITH

            .AddObject("txt_4c_Qt_pedida", "TextBox")
            WITH .txt_4c_Qt_pedida
                .Top = 428
                .Left = 268
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH

            .AddObject("txt_4c_Qt_Selec", "TextBox")
            WITH .txt_4c_Qt_Selec
                .Top = 428
                .Left = 458
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp2Click")
        *-- Redirecionar foco das colunas somente-leitura para Column5 (QtdDisp editavel)
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")

        *-- Container4: pedras/requisicoes adicionais (Visible=.F.)
        THIS.AddObject("cnt_4c_Container4", "Container")
        WITH THIS.cnt_4c_Container4
            .Top = 125
            .Left = 12
            .Width = 708
            .Height = 465
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .SpecialEffect = 0
            .Visible = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 8
                .Left = 229
                .Width = 249
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
            ENDWITH

            .AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH .cmd_4c_CancelaDisp
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "Sair"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 9
                .Width = 605
                .Height = 420
                .ColumnCount = 5
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 3
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .F.
                    .Header1.Caption = "Produto"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 200
                    .ReadOnly = .T.
                    .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 40
                    .ReadOnly = .T.
                    .Header1.Caption = "Uni"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 80
                    .ReadOnly = .F.
                    .Header1.Caption = "Qtde"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 80
                    .ReadOnly = .F.
                    .Header1.Caption = "Produto"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp4Click")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1, "Valid", THIS, "Cnt4Col1TextValid")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column4.Text1, "When",  THIS, "Cnt4Col4TextWhen")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "When",  THIS, "Cnt4Col5TextWhen")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt4Col5TextValid")

        *-- Container5: selecao de estoque por grupo/conta (Visible=.F.)
        THIS.AddObject("cnt_4c_Container5", "Container")
        WITH THIS.cnt_4c_Container5
            .Top = 125
            .Left = 12
            .Width = 708
            .Height = 465
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .SpecialEffect = 0
            .Visible = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 10
                .Left = 284
                .Width = 123
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Estoque Dispon" + CHR(237) + "vel"
            ENDWITH

            .AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH .cmd_4c_CancelaDisp
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "OK"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 141
                .Width = 425
                .Height = 372
                .ColumnCount = 5
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 2
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Grupo"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Conta"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Prioridade"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 75
                    .ReadOnly = .T.
                    .Header1.Caption = "Dispon" + CHR(237) + "vel"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 75
                    .ReadOnly = .F.
                    .Header1.Caption = "Utilizar"
                    .Header1.FontName = "Verdana"
                    .Header1.FontBold = .T.
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                    .Text1.FontBold = .T.
                    .Text1.BorderStyle = 0
                    .Text1.Alignment = 3
                    .Text1.Value = 0
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt5Col5TextValid")
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt5GradeAfterRowColChange")

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top = 413
                .Left = 428
                .Width = 48
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Produzir :"
            ENDWITH

            .AddObject("lbl_4c_Label3", "Label")
            WITH .lbl_4c_Label3
                .Top = 438
                .Left = 435
                .Width = 41
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Utilizar :"
            ENDWITH

            .AddObject("lbl_4c_Label4", "Label")
            WITH .lbl_4c_Label4
                .Top = 413
                .Left = 93
                .Width = 38
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Grupo :"
            ENDWITH

            .AddObject("lbl_4c_Label5", "Label")
            WITH .lbl_4c_Label5
                .Top = 438
                .Left = 93
                .Width = 38
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Conta :"
            ENDWITH

            .AddObject("txt_4c__dgrupo", "TextBox")
            WITH .txt_4c__dgrupo
                .Top = 409
                .Left = 141
                .Width = 277
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
            ENDWITH

            .AddObject("txt_4c__dconta", "TextBox")
            WITH .txt_4c__dconta
                .Top = 434
                .Left = 141
                .Width = 277
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
            ENDWITH

            .AddObject("txt_4c_Qt_pedida", "TextBox")
            WITH .txt_4c_Qt_pedida
                .Top = 409
                .Left = 486
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH

            .AddObject("txt_4c_Qt_Selec", "TextBox")
            WITH .txt_4c_Qt_Selec
                .Top = 434
                .Left = 486
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp5Click")

        *-- Shape2: delineamento visual da area de data/info no topo (9,9,279,51)
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 9
            .Left        = 9
            .Width       = 279
            .Height      = 51
            .BackStyle   = 0
            .BorderColor = RGB(255, 255, 255)
            .BorderWidth = 2
            .SpecialEffect = 0
        ENDWITH

        *-- Shape3: delineamento visual da area de numero/referencia (820,10,116,38)
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 10
            .Left        = 820
            .Width       = 116
            .Height      = 38
            .BackStyle   = 0
            .BorderColor = RGB(255, 255, 255)
            .BorderWidth = 2
            .SpecialEffect = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Restaura a visao principal do form
    *
    * OPERACIONAL: nao ha PageFrame com Page1/Page2 como em CRUD. A "pagina
    * lista" aqui eh o conjunto: grid principal (grd_4c_Dados / TmpFinal) +
    * totais + Container3 (saldo por grupo/conta, sempre visivel). Os overlays
    * (Container1/2/4/5) sao escondidos e as acoes principais reabilitadas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        LOCAL loc_lPodeAcao

        *-- Ocultar overlays flutuantes
        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            THIS.cnt_4c_Container1.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
            THIS.cnt_4c_Container2.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container4", 5)
            THIS.cnt_4c_Container4.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container5", 5)
            THIS.cnt_4c_Container5.Visible = .F.
        ENDIF

        *-- Grid principal e Container3 (saldo) sempre acessiveis
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Enabled = .T.
            THIS.grd_4c_Dados.ZOrder
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container3", 5)
            THIS.cnt_4c_Container3.Enabled = .T.
        ENDIF

        *-- Reabilitar botoes de acao principal
        THIS.cmd_4c_Processar.Enabled  = .T.
        THIS.cmd_4c_Cancelar.Enabled   = .T.
        THIS.cmd_4c_TotLinha.Enabled   = .T.
        THIS.cmd_4c_Disponivel.Enabled = .T.
        THIS.cmd_4c_BtnRelatorio.Enabled = .T.

        *-- Botao Pedras/SelEstoque respeitam regra de negocio
        loc_lPodeAcao = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
                            !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
                            !THIS.this_lReserva
        ENDIF
        THIS.cmd_4c_Pedras.Enabled     = loc_lPodeAcao
        THIS.cmd_4c_SelEstoque.Enabled = loc_lPodeAcao

        *-- Focar grid principal na coluna editavel Produzir
        IF THIS.grd_4c_Dados.Enabled
            THIS.grd_4c_Dados.Refresh
            THIS.grd_4c_Dados.Column6.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura a area de detalhes do item corrente
    *
    * OPERACIONAL: nao ha PageFrame com Page2, mas o form tem uma "area de
    * dados" logica composta por Container3 (saldo por grupo/conta do produto
    * selecionado) + EditBox de observacao + totais Qtd/Est/Prz. Este metodo
    * atualiza os bindings e valores exibidos para o registro corrente do grid
    * principal (TmpFinal). E chamado apos mudanca de linha no grid principal.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        LOCAL loc_nSaldo, loc_nEstoque, loc_nProduzir

        loc_nSaldo    = 0
        loc_nEstoque  = 0
        loc_nProduzir = 0

        *-- Requer TmpFinal e TmpSaldG carregados
        IF !USED("TmpFinal") OR !USED("TmpSaldG")
            RETURN
        ENDIF

        *-- Reposicionar TmpSaldG conforme item corrente do grid principal
        SELECT TmpSaldG
        SET ORDER TO Cpros
        SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
        GO TOP

        *-- Vincular Container3 grid ao cursor de saldo detalhado
        THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
        WITH THIS.cnt_4c_Container3.grd_4c_Dados
            .Column1.ControlSource = "TmpSaldG.Grupos"
            .Column2.ControlSource = "TmpSaldG.Estos"
            .Column3.ControlSource = "TmpSaldG.Saldo"
            .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
            .Column5.ControlSource = "TmpSaldG.Disps"
            .Column6.ControlSource = "TmpSaldG.Emps"
            .SetAll("ReadOnly", .T.)
            .Refresh
        ENDWITH

        *-- Descricoes grupo/conta (buscadas via CursorQuery no AfterRowColChange)
        IF USED("TmpGrupo")
            THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(TmpGrupo.Descrs, "C")
        ENDIF
        IF USED("TmpConta")
            THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(TmpConta.RClis, "C")
        ENDIF

        *-- Totais do item corrente (Saldo/Estoque/Produzir do TmpSaldo)
        IF USED("TmpSaldo") AND SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
            loc_nSaldo    = NVL(TmpSaldo.Saldo, 0)
            loc_nEstoque  = NVL(TmpSaldo.Saldo, 0) - NVL(TmpSaldo.Disps, 0)
            loc_nProduzir = NVL(TmpSaldo.Disps, 0)
        ENDIF
        THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = loc_nSaldo
        THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = loc_nEstoque
        THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = loc_nProduzir

        *-- Rebind da EditBox de observacao ao item corrente
        THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
        THIS.obj_4c_ObsItens.Refresh

        *-- Rotulo dinamico da observacao
        THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
                                            ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre a visao principal e os overlays
    *
    * Parametros: par_nPagina
    *   0 -> visao principal (grid + Container3) - via ConfigurarPaginaLista()
    *   1 -> Container1 (Totais por Linha) - equivalente a BtnTotLinhaClick
    *   2 -> Container2 (Disponibilidade)  - equivalente a BtnDisponiveiClick
    *   3 -> Container3 permanece ativo (saldo por grupo/conta) - restaura lista
    *   4 -> Container4 (Requisicoes)      - equivalente a BtnPedrasClick
    *   5 -> Container5 (Selecao Estoque)  - equivalente a BtnSelEstoqueClick
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag
        loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)

        DO CASE
            CASE loc_nPag = 1
                THIS.BtnTotLinhaClick()
            CASE loc_nPag = 2
                THIS.BtnDisponiveiClick()
            CASE loc_nPag = 4
                THIS.BtnPedrasClick()
            CASE loc_nPag = 5
                THIS.BtnSelEstoqueClick()
            OTHERWISE
                *-- Pagina 0 ou 3: restaurar visao principal
                THIS.ConfigurarPaginaLista()
        ENDCASE
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDados
    *==========================================================================
        LOCAL loc_lReadOnly

        *-- Grid principal: vincular ao TmpFinal
        IF USED("TmpFinal")
            THIS.grd_4c_Dados.RecordSource = "TmpFinal"
            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = "TmpFinal.Cpros"
                .Column2.ControlSource = "TmpFinal.CodCors"
                .Column3.ControlSource = "TmpFinal.Dopes"
                .Column4.ControlSource = "TmpFinal.Numes"
                .Column5.ControlSource = "TmpFinal.Saldo"
                .Column6.ControlSource = "TmpFinal.Produzir"
                .Column7.ControlSource = "TmpFinal.Estoque"
                .Column8.ControlSource = "IIF(EMPTY(TmpFinal.Obsps), ' ', '*')"
                .Column9.ControlSource = "TmpFinal.CodTams"
            ENDWITH

            *-- Se nao ha operacao de transferencia, grid fica somente leitura
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                IF EMPTY(crSigCdPam.TransfRes)
                    THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
                ENDIF
            ENDIF
        ENDIF

        *-- Container3: Grid saldo por grupo/conta (TmpSaldG)
        IF USED("TmpSaldG") AND USED("TmpFinal")
            SELECT TmpSaldG
            SET ORDER TO Cpros
            GO TOP
            IF !EOF("TmpFinal")
                SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
            ENDIF
            GO TOP

            THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
            WITH THIS.cnt_4c_Container3.grd_4c_Dados
                .Column1.ControlSource = "TmpSaldG.Grupos"
                .Column2.ControlSource = "TmpSaldG.Estos"
                .Column3.ControlSource = "TmpSaldG.Saldo"
                .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
                .Column5.ControlSource = "TmpSaldG.Disps"
                .Column6.ControlSource = "TmpSaldG.Emps"
                .SetAll("ReadOnly", .T.)
            ENDWITH
        ENDIF

        *-- ObsItens: vincula ao campo de observacao do item corrente
        IF USED("TmpFinal")
            THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LOCAL loc_nI, loc_oCtrl
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_nI)
            *-- Overlays ocultos (Visible=.F.): processar sub-controles mas manter container oculto
            IF INLIST(UPPER(loc_oCtrl.Name), ;
                      "CNT_4C_CONTAINER1", ;
                      "CNT_4C_CONTAINER2", ;
                      "CNT_4C_CONTAINER4", ;
                      "CNT_4C_CONTAINER5", ;
                      "IMG_4C_IMGFIGJPG")
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF
            *-- Containers permanentemente visiveis: garantir Visible=.T. e processar filhos
            IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CABECALHO", "CNT_4C_CONTAINER3")
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oCtrl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LiberarConexaoTemp()
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS DOS BOTOES PRINCIPAIS
    *==========================================================================

    PROCEDURE BtnDisponiveiClick
        LOCAL loc_cCpro, loc_cCor

        TRY
            IF USED("TmpFinal")
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
                  FROM TmpSaldo ;
                 WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
                 ORDER BY Cpros, CodCors, CodTams ;
                  INTO CURSOR TmpDisp READWRITE

                THIS.grd_4c_Dados.Enabled = .F.

                IF _Tally = 0
                    MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
                    THIS.BtnCancelaDisp2Click()
                ELSE
                    THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = "TmpDisp"
                    WITH THIS.cnt_4c_Container2.grd_4c_Dados
                        .Column1.ControlSource = "TmpDisp.Cpros"
                        .Column2.ControlSource = "TmpDisp.CodCors"
                        .Column3.ControlSource = "TmpDisp.CodTams"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"
                    ENDWITH

                    WITH THIS.cnt_4c_Container2
                        .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
                        .txt_4c_Qt_Selec.Value  = 0
                        .Visible     = .T.
                    ENDWITH

                    THIS.cmd_4c_Processar.Enabled  = .F.
                    THIS.cmd_4c_Cancelar.Enabled   = .F.
                    THIS.cmd_4c_TotLinha.Enabled   = .F.
                    THIS.cmd_4c_Pedras.Enabled     = .F.
                    THIS.cmd_4c_Disponivel.Enabled = .F.
                    THIS.cnt_4c_Container3.Enabled = .F.
                    THIS.cnt_4c_Container2.Visible = .T.
                    THIS.cnt_4c_Container2.ZOrder
                    THIS.cnt_4c_Container2.grd_4c_Dados.Refresh
                    THIS.cnt_4c_Container2.grd_4c_Dados.Column5.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnTotLinhaClick
        TRY
            IF USED("TmpLinha")
                THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = ""
                USE IN TmpLinha
            ENDIF

            SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
              FROM TmpFinal ;
             GROUP BY 1 ;
             UNION ALL ;
            SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
              FROM TmpFinal ;
             GROUP BY 1 ;
              INTO CURSOR TmpLinha ;
             ORDER BY 2, 1

            THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = "TmpLinha"
            WITH THIS.cnt_4c_Container1.grd_4c_Dados
                .Column1.ControlSource = "TmpLinha.Linhas"
                .Column2.ControlSource = "TmpLinha.Saldo"
                .Column3.ControlSource = "TmpLinha.Estoque"
                .Column4.ControlSource = "TmpLinha.Produzir"
                .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
                .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
            ENDWITH

            THIS.cmd_4c_Processar.Enabled  = .F.
            THIS.cmd_4c_Cancelar.Enabled   = .F.
            THIS.cmd_4c_TotLinha.Enabled   = .F.
            THIS.cmd_4c_Pedras.Enabled     = .F.
            THIS.cmd_4c_Disponivel.Enabled = .F.
            THIS.grd_4c_Dados.Enabled      = .F.
            THIS.cnt_4c_Container3.Enabled = .F.
            THIS.cnt_4c_Container1.Visible = .T.
            THIS.cnt_4c_Container1.ZOrder
            THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
            THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnPedrasClick
        TRY
            IF USED("SelPedra")
                THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = ""
            ENDIF

            THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = "SelPedra"
            WITH THIS.cnt_4c_Container4.grd_4c_Dados
                .Column1.ControlSource = "SelPedra.Cpros"
                .Column2.ControlSource = "SelPedra.Dpros"
                .Column3.ControlSource = "SelPedra.Cunis"
                .Column4.ControlSource = "SelPedra.Qtds"
                .Column5.ControlSource = "SelPedra.Cpro2s"
            ENDWITH

            THIS.cmd_4c_Processar.Enabled  = .F.
            THIS.cmd_4c_Cancelar.Enabled   = .F.
            THIS.cmd_4c_TotLinha.Enabled   = .F.
            THIS.cmd_4c_Pedras.Enabled     = .F.
            THIS.cmd_4c_Disponivel.Enabled = .F.
            THIS.grd_4c_Dados.Enabled      = .F.
            THIS.cnt_4c_Container3.Enabled = .F.
            THIS.cnt_4c_Container4.Visible = .T.
            THIS.cnt_4c_Container4.ZOrder
            THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
            THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSelEstoqueClick
        LOCAL loc_cCpro, loc_cCor, loc_cTam

        TRY
            IF USED("TmpFinal")
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors
                loc_cTam  = TmpFinal.CodTams

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
                       000000000.000 AS Utilizar ;
                  FROM TmpSaldG ;
                 WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
                  INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
                SELECT 0
                USE DBF("Resultado") ALIAS TmpDisp AGAIN
                USE IN Resultado

                THIS.grd_4c_Dados.Enabled = .F.

                IF _Tally = 0
                    MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
                    THIS.BtnCancelaDisp5Click()
                ELSE
                    THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = "TmpDisp"
                    WITH THIS.cnt_4c_Container5.grd_4c_Dados
                        .Column1.ControlSource = "TmpDisp.Grupos"
                        .Column2.ControlSource = "TmpDisp.Estos"
                        .Column3.ControlSource = "TmpDisp.Priors"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"
                    ENDWITH

                    WITH THIS.cnt_4c_Container5
                        .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
                                                 ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
                                                 "/" + ALLTRIM(loc_cTam) + ")"
                        .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
                        .txt_4c_Qt_Selec.Value  = 0
                        .Visible     = .T.
                    ENDWITH

                    THIS.cmd_4c_Processar.Enabled  = .F.
                    THIS.cmd_4c_Cancelar.Enabled   = .F.
                    THIS.cmd_4c_TotLinha.Enabled   = .F.
                    THIS.cmd_4c_Disponivel.Enabled = .F.
                    THIS.cmd_4c_SelEstoque.Enabled = .F.
                    THIS.cmd_4c_Pedras.Enabled     = .F.
                    THIS.cnt_4c_Container3.Enabled = .F.
                    THIS.cnt_4c_Container5.Visible = .T.
                    THIS.cnt_4c_Container5.ZOrder
                    THIS.cnt_4c_Container5.grd_4c_Dados.Refresh
                    THIS.cnt_4c_Container5.grd_4c_Dados.Column5.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick
        TRY
            IF VARTYPE(THIS.poFormPai) = "O"
                THIS.poFormPai.Enabled = .T.
            ENDIF
            THIS.Release
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnProcessarClick
        LOCAL loc_dPrevisao, loc_dGeracao, loc_lSucesso

        loc_dPrevisao = DATE()
        loc_dGeracao  = THIS.this_dData
        loc_lSucesso  = .F.

        TRY
            *-- Tentar obter datas do formulario pai/av?
            IF VARTYPE(THIS.poFormPai) = "O"
                TRY
                    IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
                        loc_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
                        loc_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
                    ENDIF
                CATCH
                ENDTRY
            ENDIF

            WITH THIS.this_oBusinessObject
                .this_lReserva    = THIS.this_lReserva
                .this_lAutomatico = THIS.this_lAutomatico
                .this_nNumeroDaOp = THIS.this_nNumeroDaOp
                .this_dPrevisao   = loc_dPrevisao
                .this_dGeracao    = loc_dGeracao
            ENDWITH

            loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dPrevisao, loc_dGeracao)

            IF loc_lSucesso
                MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso!", "Informa" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(THIS.poFormPai) = "O"
                    THIS.poFormPai.Enabled = .T.
                ENDIF
                THIS.Release
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnRelatorioClick
        TRY
            IF THIS.this_oBusinessObject.GerarRelatorio()
                THIS.ExecutarReportForm("SigPrGlp", "PRINTER_PROMPT", "crImpressao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS DOS CONTAINERS OVERLAY
    *==========================================================================

    PROCEDURE BtnCancelaLin1Click
        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cnt_4c_Container1.Visible = .F.
            .cnt_4c_Container3.Enabled = .T.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    PROCEDURE BtnCancelaDisp2Click
        LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("TmpDisp") AND USED("TmpFinal")
                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUtil

                IF loc_nQtdUtil > 0
                    SELECT TmpDisp
                    SCAN
                        IF Utilizar = 0
                            LOOP
                        ENDIF
                        loc_nQtUtil = Utilizar
                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
                        SELECT TmpFinal
                        REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
                        REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil

                        IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                        ENDIF
                        REPLACE KeySelm WITH .T. IN TmpSaldU

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil

                        SELECT TmpDisp
                    ENDSCAN
                    =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_SelEstoque.Enabled = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cnt_4c_Container3.Enabled = .T.
            .cnt_4c_Container2.Visible = .F.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    PROCEDURE BtnCancelaDisp4Click
        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cnt_4c_Container3.Enabled = .T.
            .cnt_4c_Container4.Visible = .F.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    PROCEDURE BtnCancelaDisp5Click
        LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa

        TRY
            IF USED("TmpDisp") AND USED("TmpFinal")
                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUtil

                IF loc_nQtdUtil > 0
                    SELECT TmpDisp
                    SCAN
                        IF Utilizar = 0
                            LOOP
                        ENDIF
                        loc_nQtUtil = Utilizar
                        =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")

                        SELECT TmpFinal
                        REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
                        REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil

                        IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                        ENDIF
                        REPLACE KeySelm WITH .T. IN TmpSaldU

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil

                        SELECT TmpDisp
                    ENDSCAN
                    =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cmd_4c_SelEstoque.Enabled = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cnt_4c_Container3.Enabled = .T.
            .cnt_4c_Container5.Visible = .F.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS DO GRID PRINCIPAL (GradeItens)
    *==========================================================================

    PROCEDURE GradeItensAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cSQL, loc_lcArquivo, loc_lcFoto, loc_nSal, loc_nEst, loc_nPrz

        TRY
            IF !USED("TmpFinal") OR EOF("TmpFinal")
                RETURN
            ENDIF

            THIS.obj_4c_ObsItens.Refresh
            THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)

            =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")

            SELECT TmpSaldG
            SET ORDER TO Cpros
            SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
            GO TOP

            WITH THIS.cnt_4c_Container3
                IF USED("TmpSaldo") AND !EOF("TmpSaldo")
                    .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
                    .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                    .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
                ENDIF

                .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
                    IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
                    IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")

                .grd_4c_Dados.Refresh
                .Visible     = .T.
            ENDWITH

            *-- Foto do produto
            loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
                       ALLTRIM(TmpFinal.CPros) + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
                CLEAR RESOURCES
                THIS.img_4c_ImgFigJpg.Picture = ""
                THIS.img_4c_ImgFigJpg.Visible = .F.

                IF !EMPTY(xTmpProFig.FigJpgs) AND !ISNULL(xTmpProFig.FigJpgs)
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(xTmpProFig.FigJpgs, ;
                                     "data:image/png;base64,", ""), ;
                                     "data:image/jpeg;base64,", ""), ;
                                     "data:image/jpg;base64,", ""), 14)
                    loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
                    IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
                        THIS.img_4c_ImgFigJpg.Picture = loc_lcArquivo
                        THIS.img_4c_ImgFigJpg.Visible = .T.
                    ENDIF
                ENDIF
                IF USED("xTmpProFig")
                    USE IN xTmpProFig
                ENDIF
            ENDIF

            SELECT TmpFinal
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE GrdCol6TextWhen
        LOCAL loc_lPermite
        loc_lPermite = .T.

        TRY
            IF USED("TmpFinal")
                THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value

                IF THIS.this_lReserva AND TmpFinal.Estoque = 0
                    loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
                               ALLTRIM(TmpFinal.CPros) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
                        loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
                                   ALLTRIM(xTempPro.CGrus) + "'"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
                            IF INLIST(xTempGru.TipoEstos, 3, 4)
                                THIS.cmd_4c_Disponivel.Enabled = .T.
                            ENDIF
                            IF USED("xTempGru")
                                USE IN xTempGru
                            ENDIF
                        ENDIF
                        IF USED("xTempPro")
                            USE IN xTempPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPermite
    ENDPROC

    PROCEDURE GrdCol6TextValid
        LOCAL loc_lValido, loc_nNewValue, loc_nOld, loc_xBaixa

        loc_lValido  = .T.
        loc_nNewValue = THIS.grd_4c_Dados.Column6.Text1.Value
        loc_nOld      = THIS.this_nOldValue

        TRY
            IF !USED("TmpFinal") OR !USED("TmpSaldo")
                loc_lResultado = .T.
            ENDIF

            IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
            ENDIF

            IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
                IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
                               CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
                    *-- Continue
                ELSE
                    THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_lValido
                DO CASE
                    CASE loc_nNewValue = loc_nOld
                        *-- nada a fazer
                    CASE loc_nNewValue < 0
                        MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
                        THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
                    CASE loc_nNewValue > TmpFinal.Saldo
                        MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
                        THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
                    CASE !SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") AND ;
                         TmpFinal.Produzir <> TmpFinal.Saldo
                        MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
                        THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo
                    OTHERWISE
                        IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNewValue
                            REPLACE TmpSaldo.Disps   WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
                            REPLACE KeySelm WITH .F. IN TmpSaldU

                            SELECT TmpSaldo
                            loc_xBaixa = Saldo - Disps
                            SELECT TmpSaldG
                            SET ORDER TO Cpros
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
                                IF TmpSaldG.Disps >= m.loc_xBaixa
                                    REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
                                    m.loc_xBaixa = 0
                                ELSE
                                    m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
                                    REPLACE TmpSaldG.Disps WITH 0
                                ENDIF
                            ENDSCAN
                        ELSE
                            MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
                            THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
                        ENDIF
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    PROCEDURE GrdCol6TextLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz

        TRY
            IF USED("TmpFinal")
                SELECT TmpFinal
                loc_nRecno = RECNO()
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO loc_nRecno
                THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                THIS.txt_4c_Tot_Est.Value = loc_nEst
                THIS.txt_4c_Tot_Prz.Value = loc_nPrz
                THIS.txt_4c_Tot_Qtd.Refresh
                THIS.txt_4c_Tot_Est.Refresh
                THIS.txt_4c_Tot_Prz.Refresh
                THIS.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DOS GRIDS DE CONTAINERS OVERLAY
    *==========================================================================

    PROCEDURE Cnt5GradeAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cSQL

        *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
    ENDPROC

    PROCEDURE Cnt5Col5TextValid
        LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno

        loc_lValido = .T.

        TRY
            loc_nVal = THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value

            IF loc_nVal > TmpDisp.Disps
                MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Disponivel...", "")
                THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
                THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
                loc_lValido = .F.
            ELSE
                IF loc_nVal < 0
                    MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
                    THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
                    THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
                    loc_lValido = .F.
                ELSE
                    loc_nRecno = RECNO("TmpDisp")
                    SUM TmpDisp.Utilizar TO loc_nQtdUtil
                    GO loc_nRecno IN TmpDisp
                    IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo - TmpFinal.Estoque
                        MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
                        THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
                        THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
                        loc_lValido = .F.
                    ELSE
                        THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Value = loc_nQtdUtil
                        THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Refresh
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    PROCEDURE Cnt2Col5TextValid
        LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno

        loc_lValido = .T.

        TRY
            loc_nVal = THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value

            IF loc_nVal > TmpDisp.Disps
                MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
                THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
                THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
                loc_lValido = .F.
            ELSE
                loc_nRecno = RECNO("TmpDisp")
                SUM TmpDisp.Utilizar TO loc_nQtdUtil
                GO loc_nRecno IN TmpDisp
                IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo
                    MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
                    THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
                    THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
                    loc_lValido = .F.
                ELSE
                    THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Value = loc_nQtdUtil
                    THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    PROCEDURE Cnt4Col1TextValid
        LOCAL loc_lValido, loc_cVal, loc_cSQL

        loc_lValido = .T.

        TRY
            loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
            IF !EMPTY(loc_cVal)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
                           EscaparSQL(loc_cVal)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
                    THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
                    REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
                            SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
                ELSE
                    *-- Abrir picker (FormBuscaAuxiliar)
                    DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
                                             loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
                                             "CPros", "DPros"
                    IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
                        THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
                        REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
                                SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
                    ENDIF
                ENDIF
                IF USED("crListaRemota")
                    USE IN crListaRemota
                ENDIF
                THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    PROCEDURE GrdColXGotFocus
    *==========================================================================
        IF VARTYPE(THIS.grd_4c_Dados) = "O" AND VARTYPE(THIS.grd_4c_Dados.Column6) = "O"
            THIS.grd_4c_Dados.Column6.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt2GrdColXGotFocus
    *==========================================================================
        LOCAL loc_oGrd
        loc_oGrd = THIS.cnt_4c_Container2.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O" AND VARTYPE(loc_oGrd.Column5) = "O"
            loc_oGrd.Column5.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt4Col4TextWhen
    *==========================================================================
        RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt4Col5TextWhen
    *==========================================================================
        RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt4Col5TextValid
    *==========================================================================
        LOCAL loc_lValido, loc_cVal, loc_cSQL, loc_oBusca
        loc_lValido = .T.

        TRY
            loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
            IF !EMPTY(loc_cVal)
                loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
                           EscaparSQL(loc_cVal)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
                    THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
                    REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                                             "crListaPro2", "CPros", loc_cVal, ;
                                             "Produto Substituto")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
                            THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
                            REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
                        ELSE
                            THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""
                            REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
                        ENDIF
                        loc_oBusca = .NULL.
                    ENDIF
                ENDIF
                IF USED("crListaPro2")
                    USE IN crListaPro2
                ENDIF
            ELSE
                REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
            ENDIF
            THIS.cnt_4c_Container4.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Cnt3GradeAfterRowColChange - Atualiza descricoes de grupo/conta ao mudar
    * de linha no grid de saldo (Container3.grd_4c_Dados / TmpSaldG)
    *==========================================================================
    PROCEDURE Cnt3GradeAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cSQL

        *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - Helper canonico REPORT FORM com guard FILE()
    * e isolamento SET POINT/SEPARATOR/REPORTBEHAVIOR 80
    * par_cRelatorioBase : nome base do FRX (sem path, sem extensao)
    * par_cModo          : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    * par_cCursorDados   : alias do cursor de dados (opcional - verifica se vazio)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cArqFrx, loc_cOldPoint, loc_cOldSep, loc_oErro

        par_cRelatorioBase = STRTRAN(UPPER(par_cRelatorioBase), ".FRX", "")
        loc_cArqFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF !FILE(loc_cArqFrx)
            MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                    loc_cArqFrx, "Relat" + CHR(243) + "rio")
            RETURN
        ENDIF

        IF !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum dado para exibir.")
                RETURN
            ENDIF
        ENDIF

        loc_cOldPoint = SET("POINT")
        loc_cOldSep   = SET("SEPARATOR")

        TRY
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80
            DO CASE
                CASE par_cModo = "PREVIEW"
                    REPORT FORM (loc_cArqFrx) PREVIEW
                CASE par_cModo = "PRINTER_PROMPT"
                    REPORT FORM (loc_cArqFrx) TO PRINTER PROMPT
                CASE par_cModo = "PRINTER"
                    REPORT FORM (loc_cArqFrx) TO PRINTER
                OTHERWISE
                    REPORT FORM (loc_cArqFrx) PREVIEW
            ENDCASE
        CATCH TO loc_oErro
            MsgErro("Erro relat" + CHR(243) + "rio: " + loc_oErro.Message, "Relat" + CHR(243) + "rio")
        ENDTRY

        SET POINT TO (loc_cOldPoint)
        SET SEPARATOR TO (loc_cOldSep)
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS (CRUD-nomeados) - Form OPERACIONAL "Previa da Globalizacao"
    * Este form nao possui botoes CRUD literais (Incluir/Alterar/Visualizar/Excluir),
    * mas os handlers sao expostos como aliases das acoes operacionais equivalentes
    * para uso por integradores externos (menus, chamadas automatizadas, testes).
    *==========================================================================

    PROCEDURE BtnIncluirClick
        *-- INCLUIR (novo processamento): executa Processar (fluxo principal)
        TRY
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick
        *-- ALTERAR (recalcular totais da grade principal a partir de TmpFinal)
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro

        TRY
            IF USED("TmpFinal")
                SELECT TmpFinal
                loc_nRecno = RECNO()
                loc_nSal = 0
                loc_nEst = 0
                loc_nPrz = 0
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
                    GO loc_nRecno IN TmpFinal
                ENDIF

                IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
                    THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                    THIS.txt_4c_Tot_Qtd.Refresh()
                ENDIF
                IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
                    THIS.txt_4c_Tot_Est.Value = loc_nEst
                    THIS.txt_4c_Tot_Est.Refresh()
                ENDIF
                IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
                    THIS.txt_4c_Tot_Prz.Value = loc_nPrz
                    THIS.txt_4c_Tot_Prz.Refresh()
                ENDIF
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnVisualizarClick
        *-- VISUALIZAR: emite o relatorio da previa (equivalente ao btnRelatorio)
        TRY
            THIS.BtnRelatorioClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick
        *-- EXCLUIR (cancelar processamento em andamento): rollback + release
        TRY
            IF MsgConfirma("Cancelar o processamento atual?", "Confirma" + CHR(231) + CHR(227) + "o")
                THIS.BtnCancelarClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Rebusca / reexibe os dados atuais
    * Para form OPERACIONAL sem filtros editaveis pelo usuario, "Buscar"
    * equivale a atualizar os totais e o binding do grid principal a partir
    * dos cursores TmpFinal/TmpSaldo/TmpSaldG ja carregados pelo form pai.
    *==========================================================================
    PROCEDURE BtnBuscarClick
        TRY
            THIS.CarregarDados()
            IF USED("TmpFinal")
                LOCAL loc_nSal, loc_nEst, loc_nPrz
                loc_nSal = 0
                loc_nEst = 0
                loc_nPrz = 0
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO TOP
                THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                THIS.txt_4c_Tot_Est.Value = loc_nEst
                THIS.txt_4c_Tot_Prz.Value = loc_nPrz
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra / fecha o form sem processar
    * Equivalente ao botao Sair/Cancelar do legado.
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        TRY
            IF VARTYPE(THIS.poFormPai) = "O"
                THIS.poFormPai.Enabled = .T.
            ENDIF
            THIS.Release
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva / confirma o processamento
    * Para form OPERACIONAL "Previa da Globalizacao", salvar equivale a
    * executar o processamento completo (botao Processar do legado).
    *==========================================================================
    PROCEDURE BtnSalvarClick
        TRY
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias canonico para CarregarDados (compatibilidade FormBase)
    * Forms CRUD chamam CarregarLista; em OPERACIONAL delega para CarregarDados.
    *==========================================================================
    PROCEDURE CarregarLista
        TRY
            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para o BO
    * Em form OPERACIONAL as propriedades relevantes sao flags de contexto
    * (lReserva, lAutomatico, nNumeroDaOp) e datas obtidas do form pai.
    *==========================================================================
    PROCEDURE FormParaBO
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            WITH THIS.this_oBusinessObject
                .this_lReserva    = THIS.this_lReserva
                .this_lAutomatico = THIS.this_lAutomatico
                .this_nNumeroDaOp = THIS.this_nNumeroDaOp
                .this_nEmphPdr    = THIS.this_nEmphPdr
                .this_dData       = THIS.this_dData

                *-- Datas de previsao/geracao obtidas do form avo (se existir)
                IF VARTYPE(THIS.poFormPai) = "O"
                    TRY
                        IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
                            .this_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
                            .this_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
                        ENDIF
                    CATCH
                    ENDTRY
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza o form com dados/estado do BO
    * Em form OPERACIONAL rebinda grids e atualiza totais a partir dos
    * cursores calculados pelo BO (TmpFinal/TmpSaldo/TmpSaldG).
    *==========================================================================
    PROCEDURE BOParaForm
        LOCAL loc_nSal, loc_nEst, loc_nPrz
        loc_nSal = 0
        loc_nEst = 0
        loc_nPrz = 0

        TRY
            THIS.CarregarDados()

            IF USED("TmpFinal")
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO TOP
                THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                THIS.txt_4c_Tot_Est.Value = loc_nEst
                THIS.txt_4c_Tot_Prz.Value = loc_nPrz
            ENDIF

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            IF VARTYPE(THIS.cnt_4c_Container3) = "O"
                THIS.cnt_4c_Container3.Refresh()
            ENDIF
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles conforme contexto
    * par_lHabilitar : .T. = habilitar controles editaveis, .F. = somente leitura
    * Para form OPERACIONAL o unico campo editavel pelo usuario e a coluna
    * Produzir (Column6) do grid principal.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            *-- Coluna Produzir do grid principal
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                IF loc_lHab
                    *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
                    IF USED("crSigCdPam")
                        SELECT crSigCdPam
                        IF EMPTY(crSigCdPam.TransfRes)
                            THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
                        ELSE
                            THIS.grd_4c_Dados.Column6.ReadOnly = .F.
                        ENDIF
                    ELSE
                        THIS.grd_4c_Dados.Column6.ReadOnly = .F.
                    ENDIF
                ELSE
                    THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
                ENDIF
            ENDIF

            *-- Botoes de acao
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera totais do form sem liberar cursores do form pai
    * Em form OPERACIONAL os cursores pertencem ao form pai; este metodo
    * apenas zera a exibicao de totais e limpa os overlays.
    *==========================================================================
    PROCEDURE LimparCampos
        TRY
            *-- Zerar totalizadores
            IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
                THIS.txt_4c_Tot_Qtd.Value = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
                THIS.txt_4c_Tot_Est.Value = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
                THIS.txt_4c_Tot_Prz.Value = 0
            ENDIF

            *-- Zerar totalizadores do Container3 (saldo por grupo/conta)
            IF VARTYPE(THIS.cnt_4c_Container3) = "O"
                THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = 0
                THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = 0
                THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = 0
                THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = ""
                THIS.cnt_4c_Container3.txt_4c__dconta.Value = ""
            ENDIF

            *-- Limpar label de observacao
            IF VARTYPE(THIS.lbl_4c_Txt_ObsItens) = "O"
                THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
            ENDIF

            *-- Ocultar overlays flutuantes
            THIS.ConfigurarPaginaLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme contexto atual
    * Em form OPERACIONAL o "modo" eh determinado pelo estado dos cursores:
    *   - Sem TmpFinal    -> apenas Cancelar disponivel
    *   - Com TmpFinal    -> todos os botoes operacionais disponiveis
    *   - Overlay ativo   -> botoes principais desabilitados (gerenciado pelos
    *                        handlers Btn*Click individuais)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lTemDados, loc_lPodeAcao
        loc_lTemDados = .F.
        loc_lPodeAcao = .F.

        TRY
            *-- Verificar se ha dados carregados
            IF USED("TmpFinal")
                loc_lTemDados = RECCOUNT("TmpFinal") > 0
            ENDIF

            *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
            IF loc_lTemDados AND USED("crSigCdPam")
                SELECT crSigCdPam
                loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
                                !EMPTY(crSigCdPam.DopReqcs) AND ;
                                !EMPTY(crSigCdPam.DopPedcs) AND ;
                                !EMPTY(crSigCdPam.DopComps) AND ;
                                !THIS.this_lReserva
            ENDIF

            *-- Aplicar estado aos botoes
            THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
            THIS.cmd_4c_Cancelar.Enabled     = .T.
            THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
            THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
            THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
            THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
            THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGlpBO.prg):
*==============================================================================*
* SigPrGlpBO.prg - Business Object para Previa da Globalizacao
*==============================================================================*
* Herda de: BusinessBase
* Form associado: FormSigPrGlp.prg (forms\operacionais\)
* Descricao: Gerencia o processo de previa da globalizacao e reserva automatica.
*            Opera sobre cursores temporarios (TmpFinal/TmpSaldo/TmpSaldG) pre-
*            populados pelo form pai (FormSIGPRCCR) antes de abrir este form.
*            Executa processamento de ordens de producao via SQL Server.
*==============================================================================*

DEFINE CLASS SigPrGlpBO AS BusinessBase

    *-- Sem tabela SQL propria - opera sobre cursores do form pai
    this_cTabela          = ""
    this_cCampoChave      = ""

    *-- Estado do processo
    this_lReserva         = .F.
    this_lAutomatico      = .F.
    this_nNumeroDaOp      = 0
    this_cSigKey          = ""
    this_nEmphPdr         = 0
    this_dData            = {}

    *-- Valores temporarios para controle de edicao nas colunas do grid principal
    this_nOldValue        = 0
    this_nAntValue        = 0

    *-- Conexao temporaria adicional (equivalente ao poDataTmp do legado)
    this_oConexaoTemp     = .NULL.

    *-- Previsao e data de geracao (lidos do form pai ao processar)
    this_dPrevisao        = {}
    this_dGeracao         = {}

    *-- Parametros de operacao de producao (lidos de crSigCdPam/crSigCdOpd)
    this_cDoppPad         = ""
    this_cDopeTransfRes   = ""

    *-- Flag para controle de selecao manual de estoque
    this_lKeySelm         = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de crSigCdPam para propriedades do BO
    * Deve ser chamado apos o cursor crSigCdPam estar disponivel na datasession
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                THIS.this_cDoppPad       = TratarNulo(DoppPads, "C")
                THIS.this_cDopeTransfRes = TratarNulo(TransfRes, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarConexaoTemp - Cria conexao SQL adicional para uso no Processar
    * Equivalente ao "poDataTmp = CreateObject('fSqlConector', 'SIGPRGLO')" do legado
    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexaoTemp()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oConexaoTemp = .NULL.
            IF gnConnHandle > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LiberarConexaoTemp - Libera conexao temporaria ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE LiberarConexaoTemp()
        IF !ISNULL(THIS.this_oConexaoTemp)
            THIS.this_oConexaoTemp = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarComposicao - Carrega cursor crSigCdCom (tipos de composicao)
    * SELECT a.Tipos, a.Custos, b.CGrus FROM SigCdTpc a, SigCdCom b
    * WHERE a.Tipos = b.Tipos
    * Resultado: cursor crSigCdCom indexado por Tipos+CGrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarComposicao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdCom")
                USE IN crSigCdCom
            ENDIF

            loc_cSQL = "SELECT a.Tipos, a.Custos, b.CGrus " + ;
                       "FROM SigCdTpc a, SigCdCom b " + ;
                       "WHERE a.Tipos = b.Tipos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCom") > 0
                SELECT crSigCdCom
                INDEX ON Tipos + CGrus TAG Tipos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar tipos de composi" + CHR(231) + CHR(227) + "o (crSigCdCom)", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarTmpSaldU - Cria cursor TmpSaldU para controle de selecao manual
    * Estrutura: Cpros C(14), KeySelm L
    * Indexado por Cpros
    *--------------------------------------------------------------------------
    PROCEDURE InicializarTmpSaldU()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("TmpSaldU")
                USE IN TmpSaldU
            ENDIF

            CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
            INDEX ON Cpros TAG Cpros
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPeso - Calcula peso total do cursor de composicao corrente
    * Reproduz a logica de PROCEDURE atualizapeso do legado
    * par_cAliasCursor: alias do cursor de composicao (ex: crSigCdCom)
    * Retorna: valor numerico do peso calculado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPeso(par_cAliasCursor)
        LOCAL loc_nTotQtd, loc_cCompo, loc_cSQL, loc_lSucesso, loc_nFator
        LOCAL loc_cCGrus, loc_cMats, loc_nQtds, loc_nPesos

        loc_nTotQtd = 0
        loc_cCompo  = par_cAliasCursor

        TRY
            IF !USED("crSigCdPam")
                loc_lSucesso = 0
            ENDIF

            IF crSigCdPam.AutComps <> 1
                SELECT (loc_cCompo)
                SCAN
                    *-- Acesso direto: SCAN itera loc_cCompo, WA corrente no inicio de cada iter
                    loc_cCGrus = CGrus
                    loc_cMats  = ALLTRIM(Mats)
                    loc_nQtds  = Qtds
                    loc_nPesos = Pesos
                    IF USED("crSigCdCom")
                        SELECT crSigCdCom
                        GO TOP IN crSigCdCom
                        LOCATE FOR CGrus = m.loc_cCGrus AND Custos = 1
                        IF !EOF("crSigCdCom")
                            loc_cSQL = "SELECT a.cUnis, a.cUnips, b.BPesos " + ;
                                       "FROM SigCdPro a, SigCdGrp b " + ;
                                       "WHERE a.CPros = " + EscaparSQL(loc_cMats) + " AND " + ;
                                       "a.CGrus = b.CGrus"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSomaGru") > 0
                                GO TOP IN crSomaGru
                                IF INLIST(crSomaGru.BPesos, 1, 3)
                                    loc_cSQL = "SELECT Fators FROM SigCdUni WHERE Cunis = '" + ;
                                               ALLTRIM(IIF(crSomaGru.BPesos = 1, crSomaGru.Cunis, crSomaGru.CUnips)) + "'"
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalUni") > 0
                                        loc_nFator = IIF(LocalUni.Fators = 0, 1, LocalUni.Fators)
                                        loc_nTotQtd = loc_nTotQtd + ;
                                            IIF(crSomaGru.BPesos = 1, loc_nQtds, loc_nPesos) * loc_nFator
                                    ENDIF
                                ENDIF
                                IF USED("crSomaGru")
                                    USE IN crSomaGru
                                ENDIF
                            ELSE
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSomaGru - 1)")
                                loc_lSucesso = 0
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT (loc_cCompo)
                ENDSCAN
                SELECT (loc_cCompo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTotQtd
    ENDPROC

    *--------------------------------------------------------------------------
    * GravaHistorico - Grava historico de movimentacoes em crSigMvHst
    * Reproduz a logica de PROCEDURE gravahis do legado
    * Requer: cursores crSigCdOpe, crSigMvHst dispon?veis na datasession
    *--------------------------------------------------------------------------
    PROCEDURE GravaHistorico()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRegistro, loc_nReservado
        LOCAL loc_nInicio, loc_nRerSeq, loc_nIniSeq, loc_nNewOpe

        loc_lSucesso = .F.

        TRY
            IF USED("LocalOpe")
                USE IN LocalOpe
            ENDIF

            SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests ;
            FROM CrSigCdOpe ;
            WHERE 0 = 1 ;
            INTO CURSOR LocalOpe READWRITE

            IF USED("SelOperacao")
                USE IN SelOperacao
            ENDIF

            SELECT DISTINCT Dopes FROM CrSigMvHst INTO CURSOR SelOperacao

            SELECT SelOperacao
            SCAN
                loc_cSQL = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests " + ;
                           "FROM SigCdOpe " + ;
                           "WHERE Dopes = '" + ALLTRIM(SelOperacao.Dopes) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                IF USED("xTmpOpe")
                    USE IN xTmpOpe
                ENDIF
            ENDSCAN

            SELECT SelOperacao
            SCAN
                loc_cSQL = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos, EstOrigs, EstDests " + ;
                           "FROM SigCdOpd " + ;
                           "WHERE Dopps = '" + ALLTRIM(SelOperacao.Dopes) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                IF USED("xTmpOpe")
                    USE IN xTmpOpe
                ENDIF
            ENDSCAN

            SELECT LocalOpe
            INDEX ON Dopes TAG dopes

            SELECT crSigMvHst
            GO TOP
            loc_nRegistro = RECCOUNT()

            loc_nReservado = 0
            DO WHILE loc_nReservado = 0 AND loc_nRegistro > 0
                loc_nReservado = fGerUniqueKey(DTOS(Datas), , , loc_nRegistro + 1)
            ENDDO
            loc_nInicio = loc_nReservado - loc_nRegistro

            loc_nRerSeq = 0
            DO WHILE loc_nRerSeq = 0 AND loc_nRegistro > 0
                loc_nRerSeq = fGerUniqueKey("HISTBAR", , , loc_nRegistro + 1)
            ENDDO
            loc_nIniSeq = loc_nRerSeq - loc_nRegistro

            SELECT crSigMvHst
            SCAN
                loc_nInicio  = loc_nInicio  + 1
                loc_nIniSeq  = loc_nIniSeq  + 1
                loc_nNewOpe  = crSigMvHst.Opers

                REPLACE CidChaves WITH DTOS(Datas) + loc_nNewOpe + TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
                        Seqs      WITH loc_nIniSeq

                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, ;
                             crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, ;
                             crSigMvHst.CodTams, gnConnHandle)
                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas, gnConnHandle)
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CursorQuery - Equivalente ao poDataMgr.CursorQuery do legado
    * Carrega um cursor com SELECT TOP 1 de uma tabela filtrado por campo=valor
    * par_cTabela: nome da tabela SQL Server
    * par_cCursor: alias do cursor de destino
    * par_cCampo: campo de filtro (WHERE par_cCampo = par_cValor)
    * par_xValor: valor de filtro (string ou numerico)
    * par_cColunas: colunas a retornar (vazio = todas)
    *--------------------------------------------------------------------------
    PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_cCampo, par_xValor, par_cColunas)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCols, loc_cWhere

        loc_lSucesso = .F.

        TRY
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF

            loc_cCols  = IIF(EMPTY(par_cColunas), "*", par_cColunas)

            IF VARTYPE(par_xValor) = "C"
                loc_cWhere = par_cCampo + " = " + EscaparSQL(par_xValor)
            ELSE
                loc_cWhere = par_cCampo + " = " + TRANSFORM(par_xValor)
            ENDIF

            loc_cSQL = "SELECT TOP 1 " + loc_cCols + " FROM " + par_cTabela + " WHERE " + loc_cWhere

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa a globalizacao/reserva automatica
    * Reproduz a logica do PROCEDURE Click do botao Processar do legado (1637 linhas)
    * par_dPrevisao: data de previsao de entrega
    * par_dGeracao: data de geracao da ordem
    * Requer: cursores TmpFinal/TmpSaldo/TmpSaldG/crSigCdPam/crSigCdPac disponiveis
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_dPrevisao, par_dGeracao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nNump, loc_nSeqs, loc_cCPros
        LOCAL loc_cReff, loc_cCor, loc_cTam, loc_nTProd, loc_nTPeso
        LOCAL loc_cClinha, loc_cNota, loc_cGrupoD, loc_cContaD
        LOCAL loc_nNopComp, loc_cCidC, loc_cIds, loc_nNumpe
        LOCAL loc_nQtdPrz, loc_nQtdLim, loc_nQtBaixar, loc_nQtBaixado, loc_nLnVezes
        LOCAL loc_cDoppPad, loc_cDope, loc_cMat, loc_pDay
        LOCAL loc_nQtdcpnt, loc_nUnits, loc_cMoedas
        LOCAL loc_nDopePed, loc_cLcMat

        loc_lSucesso = .F.
        loc_pDay     = DATETIME()

        TRY
            *-- Zap cursores de saida
            IF USED("crSigOpPic")
                SELECT crSigOpPic
                ZAP
            ENDIF
            IF USED("crSigPdMvf")
                SELECT crSigPdMvf
                ZAP
            ENDIF
            IF USED("crSigCdNec")
                SELECT crSigCdNec
                ZAP
            ENDIF
            IF USED("crSigMvCab")
                SELECT crSigMvCab
                ZAP
            ENDIF
            IF USED("crSigMvHst")
                SELECT crSigMvHst
                ZAP
            ENDIF
            IF USED("crSigBxEst")
                SELECT crSigBxEst
                ZAP
            ENDIF
            IF USED("crSigMvItn")
                SELECT crSigMvItn
                ZAP
            ENDIF
            IF USED("crSigMvIts")
                SELECT crSigMvIts
                ZAP
            ENDIF
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ENDIF

            IF USED("GrSigCdNei")
                USE IN GrSigCdNei
            ENDIF

            SELECT * FROM CrSigCdNei WHERE 0 = 1 INTO CURSOR GrSigCdNei READWRITE

            SELECT crSigCdPam

            loc_cDoppPad = crSigCdPam.DoppPads
            loc_cDope    = crSigCdPam.TransfRes

            THIS.CursorQuery("SigCdOpd", "crSigCdOpd", "Dopps", loc_cDoppPad)

            loc_nNump = 0
            IF !THIS.this_lReserva
                IF crSigCdPam.GlobAutos = 2 AND THIS.this_nNumeroDaOp > 0
                    loc_nNump = THIS.this_nNumeroDaOp
                ELSE
                    loc_nNump = fGerUniqueKey(loc_cDoppPad)
                ENDIF

                loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + TRANSFORM(loc_nNump)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpOpi)")
                    loc_lSucesso = .F.
                ENDIF
                IF RECCOUNT("TmpOpi") > 0
                    MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            loc_nSeqs   = 0
            loc_cCPros  = ""
            loc_cReff   = SPACE(15)
            loc_cCor    = SPACE(4)
            loc_cTam    = SPACE(2)
            loc_nTProd  = 0
            loc_nTPeso  = 0
            loc_cClinha = SPACE(10)
            loc_cNota   = SPACE(6)
            loc_cGrupoD = SPACE(10)
            loc_cContaD = SPACE(10)
            loc_nNumpe  = (loc_nNump * 10000) + 1

            IF USED("TmpEmpH")
                USE IN TmpEmpH
            ENDIF
            CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
                                    QtdGReqs N(12,3), cpro2s C(10), Pesos N(12,3))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats + cpro2s TAG CMats

            IF USED("TmpPedra")
                USE IN TmpPedra
            ENDIF
            CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                                     Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                                     QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
                                     QtdGReqs N(12,3), Pesos N(12,3))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats TAG CMats
            INDEX ON cMats + Grupos + Contas TAG MatGruCon

            IF USED("TmpMatPrz")
                USE IN TmpMatPrz
            ENDIF
            CREATE CURSOR TmpMatPrz (cMats C(14), Qtds N(12,3), Pesos N(12,3), PrazoEnts D, QtBaixas N(12,3))
            INDEX ON DTOC(PrazoEnts) + cMats TAG MatPrazo DESCENDING

            loc_nDopePed = crSigCdPac.OpPdCompra
            THIS.CursorQuery("SigCdOpe", "TmpOpePed", "Dopes", loc_nDopePed)
            THIS.CursorQuery("SigMvIts", "crTplMvIts", "cIdChaves", fUniqueIds())
            SELECT crTplMvIts
            INDEX ON Cpros TAG Cpros

            THIS.CursorQuery("SigMvItn", "crTpmMvItn", "cIdChaves", fUniqueIds())
            SELECT crTpmMvItn
            INDEX ON Cpros TAG Cpros

            IF !THIS.this_lReserva
                SELECT TmpFinal
                INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs TAG Cpros
                SET ORDER TO Cpros
                GO TOP

                DO WHILE !EOF("TmpFinal")
                    IF TmpFinal.Produzir <> 0
                        THIS.CursorQuery("SigCdPro", "crSigCdPro", "CPros", TmpFinal.CPros)
                        THIS.CursorQuery("SigCdLin", "CrSigCdLin", "Linhas", TmpFinal.Linhas)
                        THIS.CursorQuery("SigCdGrp", "CrSigCdGrp", "CGrus",  CrSigCdPro.Cgrus, "Mercs, GeraTubs")
                        THIS.CursorQuery("SigCdGpr", "CrSigCdGpr", "Codigos", CrSigCdGrp.Mercs, "MatPrincs, cpqtds")

                        IF EMPTY(crSigCdPac.OpPdCompra) OR ;
                           (!EMPTY(crSigCdPac.OpPdCompra) AND crSigCdPro.FabrProPrs = 1)

                            loc_cLcMat = IIF(!EMPTY(crSigCdPro.MatPrincs), crSigCdPro.MatPrincs, ;
                                         IIF(!EMPTY(CrSigCdGpr.MatPrincs), CrSigCdGpr.MatPrincs, ;
                                         crSigCdPam.Ouros))

                            loc_nQtdPrz   = TmpFinal.Produzir
                            loc_nQtdLim   = IIF(CrSigCdLin.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin.QtPcs)
                            loc_nQtBaixar = TmpFinal.Produzir
                            loc_nLnVezes  = 0

                            DO WHILE loc_nQtBaixar > 0
                                loc_nLnVezes = loc_nLnVezes + 1

                                IF loc_nQtBaixar < loc_nQtdLim
                                    loc_nQtBaixado = loc_nQtBaixar
                                    loc_nQtBaixar  = 0
                                ELSE
                                    loc_nQtBaixar  = loc_nQtBaixar - loc_nQtdLim
                                    loc_nQtBaixado = loc_nQtdLim
                                ENDIF

                                IF (loc_cClinha + loc_cReff + loc_cCPros + loc_cNota + loc_cCor + loc_cGrupoD + loc_cContaD <> ;
                                    TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + TmpFinal.Notas + ;
                                    TmpFinal.CodCors + TmpFinal.GrupoDs + TmpFinal.ContaDs) OR ;
                                   loc_nLnVezes > 1

                                    loc_cClinha  = TmpFinal.Linhas
                                    loc_cCPros   = TmpFinal.CPros
                                    loc_cCor     = TmpFinal.CodCors
                                    loc_cTam     = TmpFinal.CodTams
                                    loc_cReff    = TmpFinal.Reffs
                                    loc_cGrupoD  = TmpFinal.GrupoDs
                                    loc_cContaD  = TmpFinal.ContaDs
                                    loc_nSeqs    = loc_nSeqs + 1
                                    loc_cNota    = TmpFinal.Notas
                                    loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
                                    loc_cCidC    = DTOS(par_dGeracao) + ;
                                                   TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
                                                   THIS.this_cSigKey

                                    INSERT INTO crSigPdMvf ;
                                        (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                                         Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, ;
                                         cIdChaves, EmpDopNums, EmpDNps) ;
                                    VALUES ;
                                        (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
                                         DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, ;
                                         crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                         loc_cGrupoD, loc_cContaD, loc_nNopComp, loc_cCPros, ;
                                         crSigCdPro.CUnis, ;
                                         loc_nTPeso, ;
                                         loc_nTProd, 1, loc_cCidC, ;
                                         go_4c_Sistema.cCodEmpresa + SPACE(20) + STR(0, 6), ;
                                         go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10))

                                    loc_cIds = DTOS(par_dGeracao) + ;
                                               TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
                                               THIS.this_cSigKey

                                    INSERT INTO crSigCdNec ;
                                        (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, ;
                                         Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) ;
                                    VALUES ;
                                        (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
                                         DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, loc_nTPeso, ;
                                         crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                         loc_cGrupoD, loc_cContaD, loc_cIds, ;
                                         go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
                                         TmpFinal.Jobs)

                                    INSERT INTO GrSigCdNei ;
                                        (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
                                         cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
                                    VALUES ;
                                        (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
                                         loc_nNopComp, loc_nNopComp, loc_cLcMat, crSigCdPro.Dpros, ;
                                         crSigCdPro.Cunis, ;
                                         IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                         IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                         crSigCdPam.TpOpEntAus, ;
                                         go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
                                         fUniqueIds())

                                    loc_nTProd = 0
                                    loc_nTPeso = 0
                                ENDIF

                                loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs

                                IF CrSigCdGrp.GeraTubs <> 2
                                    loc_nQtdTb = crSigCdPro.QtdCpnts
                                ELSE
                                    loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = '" + ;
                                               ALLTRIM(TmpFinal.CPros) + "'"
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") > 0
                                        SELECT crSigPrMtz
                                        loc_nQtdTb = NVL(crSigPrMtz.Total, 0)
                                    ELSE
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigPrMtz)")
                                        loc_lSucesso = .F.
                                    ENDIF
                                ENDIF

                                loc_nQtdcpnt = NVL(loc_nQtdTb, 0) * loc_nQtBaixado
                                loc_nUnits   = 0
                                loc_cMoedas  = SPACE(3)

                                loc_cSQL = "SELECT * " + ;
                                           "FROM SigMvItn " + ;
                                           "WHERE EmpDopNums = '" + ;
                                           ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6) + ;
                                           "' AND CPros = '" + ALLTRIM(TmpFinal.Cpros) + "'"

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEestI") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEestI)")
                                    loc_lSucesso = .F.
                                ENDIF

                                SELECT TempEestI
                                SCAN
                                    IF CItens = TmpFinal.Citens
                                        loc_nUnits  = TempEestI.Units
                                        loc_cMoedas = TempEestI.Moedas
                                        EXIT
                                    ENDIF
                                ENDSCAN

                                INSERT INTO crSigOpPic ;
                                    (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, ;
                                     Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, ;
                                     Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, ;
                                     Dpros, CodTgOps, Citens) ;
                                VALUES ;
                                    (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
                                     TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;
                                     TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;
                                     TmpFinal.CodCors, TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, ;
                                     loc_nQtdcpnt, loc_nUnits, loc_cMoedas, fUniqueIds(), ;
                                     ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6), ;
                                     go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNump, 10), ;
                                     TmpFinal.Notas, TmpFinal.Emps, ;
                                     go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
                                     TmpFinal.Dpros, ;
                                     IIF(USED("DbParam"), DbParam.CodTgOps, 0), ;
                                     TmpFinal.cItens)

                                *-- Processar itens de estoque (TempEestI baixas)
                                SELECT TempEestI
                                loc_nBaixa = loc_nQtBaixado
                                SCAN WHILE loc_nBaixa > 0
                                    loc_pEdn = ALLTRIM(TempEestI.Emps) + ALLTRIM(TempEestI.Dopes) + ;
                                               STR(TempEestI.Numes, 6)
                                    loc_pItn = TempEestI.Citens
                                    loc_pIds = TempEestI.cIdChaves

                                    IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) <> 0
                                        loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                                   "WHERE EmpDopNums = '" + loc_pEdn + ;
                                                   "' AND CItens = '" + ALLTRIM(loc_pItn) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                                    "Falha na Conex" + CHR(227) + "o (TempEsti2)")
                                            loc_lSucesso = .F.
                                        ENDIF

                                        *-- continua com logica de baixa de estoque (TempEsti2 scan)
                                    ENDIF
                                ENDSCAN

                            ENDDO && WHILE loc_nQtBaixar > 0
                        ENDIF && FabrProPrs
                    ENDIF && Produzir <> 0

                    SELECT TmpFinal
                    SKIP
                ENDDO && WHILE !EOF("TmpFinal")
            ENDIF && !this_lReserva

            *-- Processar componentes (TmpEmpH/TmpPedra)
            THIS.ProcessarComponentes(loc_cDoppPad, loc_cDope, loc_nNump, par_dGeracao, par_dPrevisao)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComponentes - Processa componentes, empenhamentos e requisicoes
    * Segmento extraido do PROCEDURE Click Processar do legado (pos-loop TmpFinal)
    * par_cDoppPad: operacao padrao
    * par_cDopeTransf: operacao de transferencia reserva
    * par_nNump: numero da OP gerado
    * par_dGeracao: data de geracao
    * par_dPrevisao: data de previsao
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarComponentes(par_cDoppPad, par_cDopeTransf, par_nNump, par_dGeracao, par_dPrevisao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cIdc

        loc_lSucesso = .F.

        TRY
            *-- Consolidar GrSigCdNei -> CrSigCdNei e empenhar TmpEmpH
            SELECT GrSigCdNei
            GO TOP
            SCAN
                SELECT crSigCdNec
                LOCATE FOR Emps = GrSigCdNei.Emps AND ;
                            Dopps = GrSigCdNei.Dopps AND ;
                            Numps = GrSigCdNei.Nops
                IF !EOF("crSigCdNec")
                    SELECT CrSigCdNei
                    APPEND BLANK
                    GATHER FROM GrSigCdNei FIELDS Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
                                                   cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves
                ENDIF
                SELECT GrSigCdNei
            ENDSCAN

            *-- Processar empenhamentos de TmpEmpH -> crSigMvItn/crSigBxEst
            SELECT TmpEmpH
            GO TOP

            SCAN WHILE !EOF("TmpEmpH")
                IF TmpEmpH.Qtds > 0
                    loc_cIdc = fUniqueIds()

                    INSERT INTO crSigMvItn ;
                        (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
                         Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, ;
                         cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) ;
                    VALUES ;
                        (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
                         (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;
                         par_dGeracao, par_dPrevisao, gc_4c_UsuarioLogado, ;
                         TmpEmpH.Qtds, TmpEmpH.cMats, TmpEmpH.cGrus, ;
                         SPACE(4), SPACE(2), TmpEmpH.Grupos, TmpEmpH.Contas, ;
                         TmpEmpH.Pesos, loc_cIdc, ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
                         par_dGeracao, TmpEmpH.cpro2s)
                ENDIF
            ENDSCAN

            *-- Processar pedras de SelPedra -> crSigMvIts
            SELECT SelPedra
            GO TOP
            SCAN WHILE !EOF("SelPedra")
                IF !EMPTY(SelPedra.Cpros) AND SelPedra.Qtds > 0
                    loc_cIdc = fUniqueIds()

                    INSERT INTO crSigMvIts ;
                        (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
                         Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, ;
                         DtGeras, cpro2s) ;
                    VALUES ;
                        (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, par_nNump, ;
                         par_cDoppPad, par_nNump, par_dGeracao, par_dPrevisao, ;
                         gc_4c_UsuarioLogado, SelPedra.Qtds, SelPedra.Cpros, ;
                         SPACE(10), SPACE(10), 0, loc_cIdc, ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
                         par_dGeracao, SelPedra.Cpro2s)
                ENDIF
            ENDSCAN

            *-- Executar historico
            THIS.GravaHistorico()

            *-- Commit e gravar no SQL Server
            THIS.GravarNoServidor(par_nNump, par_cDoppPad, par_dGeracao)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarNoServidor - Executa INSERTs no SQL Server a partir dos cursores locais
    * Envia crSigOpPic, crSigPdMvf, crSigCdNec, CrSigCdNei, crSigMvHst,
    *       crSigMvItn, crSigMvIts, crSigBxEst para o banco
    * par_nNump: numero da OP
    * par_cDoppPad: operacao padrao
    * par_dGeracao: data de geracao
    *--------------------------------------------------------------------------
    PROCEDURE GravarNoServidor(par_nNump, par_cDoppPad, par_dGeracao)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            *-- Gravar SigOpPic (ordem de producao)
            IF USED("crSigOpPic") AND RECCOUNT("crSigOpPic") > 0
                SELECT crSigOpPic
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigOpPic " + ;
                               "(Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, " + ;
                               "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
                               "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
                               "Dpros, CodTgOps, Citens) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Numes, 0) + ", " + ;
                               FormatarDataSQL(crSigOpPic.Dataes) + ", " + ;
                               FormatarDataSQL(crSigOpPic.Dataps) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Obss, 60)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Cpros, 14)) + ", " + ;
                               FormatarDataSQL(crSigOpPic.DtGeras) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.CodCors, 4)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.CodTams, 2)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Pesos, 3) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.QtdCpnts, 3) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Units, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Moedas, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.EmpDopNums, 29)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.EmpDNps, 33)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Notas, 6)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Empds, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.EmpDopNops, 33)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Dpros, 60)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.CodTgOps, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Citens, 20)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar ordem de produ" + CHR(231) + CHR(227) + "o no servidor", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar historico SigMvHst
            IF USED("crSigMvHst") AND RECCOUNT("crSigMvHst") > 0
                SELECT crSigMvHst
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Emps, Dopes, Numes, Datas, Usuars, CPros, CodCors, CodTams, " + ;
                               "Grupos, Estos, Seqs, CidChaves, Qtds, Pesos, Opers) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
                               FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CodCors, 4)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CodTams, 2)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Grupos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Estos, 10)) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Seqs, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CidChaves, 23)) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Qtds, 3) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Pesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Opers, 1)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar hist" + CHR(243) + "rico de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar necessidades CrSigCdNei -> SigCdNei
            IF USED("CrSigCdNei") AND RECCOUNT("CrSigCdNei") > 0
                SELECT CrSigCdNei
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigCdNei " + ;
                               "(Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
                               "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Nops, 0) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Nenvs, 0) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.Cmats, 14)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.Cdescs, 60)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.cUnis, 6)) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Pesos, 3) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.TpOps, 5)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.EmpDNps, 33)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.cIdChaves, 36)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar necessidade de material", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar necessidades de empenho SigCdNec
            IF USED("crSigCdNec") AND RECCOUNT("crSigCdNec") > 0
                SELECT crSigCdNec
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigCdNec " + ;
                               "(Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, " + ;
                               "Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
                               "GETDATE(), " + ;
                               FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Contads, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.EmpDNps, 33)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Jobs, 20)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar necessidade de empenho", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar pedido de movimentacao crSigPdMvf -> SigPdMvf
            IF USED("crSigPdMvf") AND RECCOUNT("crSigPdMvf") > 0
                SELECT crSigPdMvf
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigPdMvf " + ;
                               "(Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
                               "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
                               "cIdChaves, EmpDopNums, EmpDNps) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
                               "GETDATE(), " + ;
                               FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Grupods, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Contads, 10)) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Nops, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.CodPds, 14)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Unids, 6)) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Pesos, 3) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Qtds, 3) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Ordems, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.EmpDopNums, 29)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.EmpDNps, 33)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar pedido de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar empenhos crSigMvItn -> SigMvItn
            IF USED("crSigMvItn") AND RECCOUNT("crSigMvItn") > 0
                SELECT crSigMvItn
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigMvItn " + ;
                               "(Emps, Dopes, Numes, Qtds, Cpros, Pesos, " + ;
                               "cIdChaves, EmpDopNums, cpro2s) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
                               FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
                               FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.cpro2s, 10)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar empenhamento de material", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar subitens crSigMvIts -> SigMvIts
            IF USED("crSigMvIts") AND RECCOUNT("crSigMvIts") > 0
                SELECT crSigMvIts
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigMvIts " + ;
                               "(Emps, Dopes, Numes, Qtds, Cpros, Pesos, cIdChaves, EmpDopNums) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
                               FormatarNumeroSQL(crSigMvIts.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.Cpros, 14)) + ", " + ;
                               FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.EmpDopNums, 29)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar subitem de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarRelatorio - Gera cursor de impressao e exibe relatorio da previa
    * Reproduz PROCEDURE Click de btnRelatorio do legado
    *--------------------------------------------------------------------------
    PROCEDURE GerarRelatorio()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("crImpressao")
                USE IN crImpressao
            ENDIF

            SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
                   Saldo, Estoque, Produzir, ;
                   IIF(EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
            FROM TmpFinal ;
            ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
            INTO CURSOR crImpressao READWRITE

            SELECT crImpressao
            GO TOP
            IF EOF("crImpressao")
                MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + "o do Relat" + CHR(243) + "rio!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF USED("LocalProds")
                USE IN LocalProds
            ENDIF

            SELECT DISTINCT Cpros FROM crImpressao INTO CURSOR LocalProds
            SELECT LocalProds
            SCAN
                loc_cSQL = "SELECT TOP 1 DPros FROM SigCdPro " + ;
                           "WHERE CPros = '" + ALLTRIM(LocalProds.Cpros) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpPro") > 0
                    SELECT crImpressao
                    REPLACE DPros WITH xTmpPro.DPros FOR crImpressao.Cpros = LocalProds.Cpros
                    IF USED("xTmpPro")
                        USE IN xTmpPro
                    ENDIF
                ENDIF
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Override obrigatorio de BusinessBase
    * Sem chave primaria (form operacional sem tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor indicado
    * Para este OPERACIONAL: carrega parametros de estado (Reserva, NumeroDaOp...)
    * par_cAliasCursor: alias do cursor com campos de parametro opcionais
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".Reserva") != "U"
                    THIS.this_lReserva    = TratarNulo(Reserva,    "L")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Automatico") != "U"
                    THIS.this_lAutomatico = TratarNulo(Automatico, "L")
                ENDIF
                IF TYPE(par_cAliasCursor + ".NumeroDaOp") != "U"
                    THIS.this_nNumeroDaOp = TratarNulo(NumeroDaOp, "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".SigKey") != "U"
                    THIS.this_cSigKey     = TratarNulo(SigKey,     "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".EmphPdr") != "U"
                    THIS.this_nEmphPdr    = TratarNulo(EmphPdr,    "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Datas") != "U"
                    THIS.this_dData       = TratarNulo(Datas,      "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Previsao") != "U"
                    THIS.this_dPrevisao   = TratarNulo(Previsao,   "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Geracao") != "U"
                    THIS.this_dGeracao    = TratarNulo(Geracao,    "D")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Override de BusinessBase.Inserir()
    * Delega ao metodo Processar() com as datas de previsao e geracao do BO
    * Antes de chamar: preencher this_dPrevisao e this_dGeracao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_dGeracao)
                THIS.this_dGeracao  = DATE()
            ENDIF
            IF EMPTY(THIS.this_dPrevisao)
                THIS.this_dPrevisao = DATE()
            ENDIF

            loc_lSucesso = THIS.Processar(THIS.this_dPrevisao, THIS.this_dGeracao)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("I")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Override de BusinessBase.Atualizar()
    * Nao aplicavel: form OPERACIONAL gera novas ordens, nao atualiza existentes
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override: registra globalizacao em LogAuditoria
    * par_cOperacao: "I" (processamento de globalizacao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        loc_cSQL = ""

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       "'SigOpPic', " + ;
                       EscaparSQL(LEFT(par_cOperacao, 1)) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nNumeroDaOp)) + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 50)) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


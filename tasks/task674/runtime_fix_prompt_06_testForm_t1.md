# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-19 03:38:45] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-19 03:38:45] [INFO] Config FPW: (nao fornecido)
[2026-10-19 03:38:46] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 03:38:46] [INFO] Timeout: 300 segundos
[2026-10-19 03:38:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nzfvvvn4.prg
[2026-10-19 03:38:46] [INFO] Conteudo do wrapper:
[2026-10-19 03:38:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrSdd', 'C:\4c\tasks\task674\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSdd', 'C:\4c\tasks\task674\logs\06_testForm.log'
QUIT

[2026-10-19 03:38:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nzfvvvn4.prg
[2026-10-19 03:38:47] [INFO] VFP output esperado em: C:\4c\tasks\task674\vfp_output.txt
[2026-10-19 03:38:48] [INFO] Executando Visual FoxPro 9...
[2026-10-19 03:38:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nzfvvvn4.prg
[2026-10-19 03:38:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nzfvvvn4.prg
[2026-10-19 03:38:48] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrSdd
Inicio: 19/10/2026 03:38:50

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
OK - Objeto criado com sucesso
     Tipo: O
     Classe: Formsigprsdd

[ETAPA 3] Mostrando formulario (nao-modal)...
ERRO - Excecao ao mostrar formulario:
     Mensagem: Property WINDOWTYPE is read-only.

=== RESULTADO DO TESTE ===
Fim: 19/10/2026 03:42:26
Duracao: 216 segundos
Return Code: 2
Status: ERRO AO MOSTRAR FORM

===========================
[2026-10-19 03:42:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-19 03:42:27] [INFO] VFP9 finalizado em 219.6632752 segundos
[2026-10-19 03:42:28] [INFO] Exit Code: 
[2026-10-19 03:42:28] [INFO] 
[2026-10-19 03:42:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-19 03:42:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nzfvvvn4.prg
[2026-10-19 03:42:28] [INFO] 
[2026-10-19 03:42:29] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-19 03:42:29] [INFO] * Auto-generated wrapper for parameters
[2026-10-19 03:42:29] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 03:42:30] [INFO] * Parameters: 'FormSigPrSdd', 'C:\4c\tasks\task674\logs\06_testForm.log'
[2026-10-19 03:42:30] [INFO] 
[2026-10-19 03:42:30] [INFO] * Anti-dialog protections for unattended execution
[2026-10-19 03:42:30] [INFO] SET SAFETY OFF
[2026-10-19 03:42:31] [INFO] SET RESOURCE OFF
[2026-10-19 03:42:31] [INFO] SET TALK OFF
[2026-10-19 03:42:31] [INFO] SET NOTIFY OFF
[2026-10-19 03:42:31] [INFO] SYS(2335, 0)
[2026-10-19 03:42:32] [INFO] 
[2026-10-19 03:42:32] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSdd', 'C:\4c\tasks\task674\logs\06_testForm.log'
[2026-10-19 03:42:32] [INFO] QUIT
[2026-10-19 03:42:32] [INFO] 
[2026-10-19 03:42:32] [INFO] === Fim do Wrapper.prg ===
[2026-10-19 03:42:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSdd.prg):
*==============================================================================
* FormSigPrSdd.prg - Senha do Dia
* Origem: SIGPRSDD.SCX (task674)
* Herda de: FormBase
* Tipo: OPERACIONAL (dialogo modal unico - gera a senha de autorizacao do dia)
*       Legado: Form PLANO, sem PageFrame (Width=799, Height=288,
*       DataSession=2, BorderStyle=2 fixo, ControlBox/Closable=.F. - a unica
*       saida e o botao Encerrar ou a conclusao do fluxo de Gerar Senha).
*       NAO segue o padrao Page1=Lista/Page2=Dados do CRUD (PILAR 1 - layout
*       custom do legado e preservado).
*==============================================================================

DEFINE CLASS FormSigPrSdd AS FormBase

    Width        = 799
    Height       = 288
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    DataSession  = 1
    Caption      = "Senha do dia"

    *-- Modo recebido do chamador (legado: Lparameters _Producao)
    *-- .T. = fluxo de Producao (lookup de Operacao via SigCdOpd, Valor oculto)
    *-- .F. = fluxo fora de Producao (lookup de Operacao via SigCdOpe, Valor exigido)
    this_lProducao = .F.

    *==========================================================================
    * Init - recebe o modo Producao do chamador
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_lProducao

        THIS.this_lProducao = IIF(VARTYPE(par_lProducao) = "L", par_lProducao, .F.)

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - cria a estrutura visual base e instancia o BO
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrSddBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigPrSddBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestrador da montagem visual
    * SIGPRSDD legado e Form PLANO sem PageFrame - dialogo modal unico com
    * cabecalho + campos + botoes de acao. Mantido o papel de
    * "ConfigurarPageFrame" como ponto de entrada da montagem visual (padrao
    * FormFop), delegando para os helpers dedicados.
    *
    * Fase 4 (Grid e Botoes CRUD / Page1) nao se aplica a este legado: o SCX
    * original (layout.json) e um dialogo de CAPTURA sem PageFrame, sem Grid,
    * sem AddCursor/pColuna e sem os 5 botoes CRUD (Incluir/Visualizar/
    * Alterar/Excluir/Buscar) - os unicos botoes sao Boleto, Gerar Senha e
    * Encerrar, e os unicos controles de entrada sao os 11 TextBox de campo
    * (Solicitante/Empresa/Operacao/Documento/Cond.Pagto/Data/Valor/Motivo).
    * Inventar Grid+CRUD aqui violaria o PILAR 1 (UX identica ao legado) e a
    * regra de completude (NUNCA inventar tela que o legado nao tem).
    *
    * Fase 7 (template generico "eventos principais dos botoes CRUD" -
    * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick):
    * NAO se aplica a este form, pela mesma razao da Fase 4 - SIGPRSDD nao e
    * um frmcadastro e nao tem barra Incluir/Alterar/Visualizar/Excluir no
    * legado (ver SigPrSdd_form_codigo_fonte.txt, SECAO 1). Os "eventos
    * principais" REAIS deste dialogo sao os 3 botoes que o SCX de fato
    * declara - Fwbtng1 ("Boleto", abre FormSIGOPBOL), GeraSenha ("Gerar
    * Senha", valida os campos e grava a senha do dia) e Saida ("Encerrar",
    * fecha o dialogo) - implementados em ConfigurarBotoesAcao() com handlers
    * nomeados pelo prefixo canonico Btn*Click (mesma convencao documentada
    * em FormSIGOPBOL.prg, Fase 7: "handler renomeado para o prefixo Btn/Cmd,
    * nao para o nome do objeto legado"). Inventar os 4 nomes CRUD fabricaria
    * UX que o legado nao tem (PILAR 1) e criaria metodo sem contrapartida no
    * SCX - stub disfarcado proibido.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarLookups()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - cria os campos de entrada do dialogo (completo)
    * Legado: SIGPRSDD.SCX e um Form PLANO (sem PageFrame/Page1/Page2) -
    * Label1..Label6/Say12/lbl_empresa + Get_* sao filhos DIRETOS do form,
    * posicionados abaixo do cntSombra (Height=80). Por nao haver PageFrame,
    * NAO se aplica a compensacao +29 (regra do CLAUDE.md) - os Tops do dump
    * sao transcritos literalmente.
    *
    * Fase 5 (Parte 1): Solicitante, Empresa (codigo + descricao), Operacao,
    * Documento. Fase 6 (Parte 2, completa o metodo): Cond.Pagto (Say12 +
    * Get_fpg), Data (Label4 + Get_Data, sempre Enabled=.F. - When do legado
    * retorna .F.), Valor (Label5 + Get_Valor, Enabled so fora de Producao -
    * When do legado retorna Not ThisForm.Producao), Motivo (Label6 +
    * Get_Motivo). ControlSource NAO e usado (arquitetura em
    * camadas: o valor vai e volta via FormParaBO/BOParaForm em fase
    * posterior) - aqui so estrutura visual, tipo e mascara (Format/
    * InputMask/MaxLength transcritos do SCX - regra #49 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            *-- Solicitante : (Label1 + Get_Solic) ------------------------------
            THIS.AddObject("lbl_4c_Solicitante", "Label")
            WITH THIS.lbl_4c_Solicitante
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Solicitante : "
                .Height    = 15
                .Left      = 81
                .Top       = 86
                .Width     = 61
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Solic", "TextBox")
            WITH THIS.txt_4c_Solic
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Format        = "K!"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Height        = 23
                .Left          = 144
                .Top           = 83
                .Width         = 80
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Empresa : (lbl_empresa + Get_Cd_Empresa + Get_Ds_Empresa) -------
            THIS.AddObject("lbl_4c_Empresa", "Label")
            WITH THIS.lbl_4c_Empresa
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Empresa : "
                .Height    = 15
                .Left      = 89
                .Top       = 112
                .Width     = 53
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
            WITH THIS.txt_4c_CdEmpresa
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Format        = "K"
                .MaxLength     = 3
                .SpecialEffect = 1
                .Height        = 25
                .Left          = 144
                .Top           = 108
                .Width         = 32
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Get_Ds_Empresa: preenchida pelo lookup (fase 6) - nao tem
            *-- coluna propria em SigPrSnd, so exibicao da descricao.
            THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
            WITH THIS.txt_4c_DsEmpresa
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Format        = "K"
                .MaxLength     = 40
                .SpecialEffect = 1
                .Height        = 25
                .Left          = 178
                .Top           = 108
                .Width         = 290
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Operacao : (Label2 + Get_Operacao) ------------------------------
            THIS.AddObject("lbl_4c_Operacao", "Label")
            WITH THIS.lbl_4c_Operacao
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
                .Height    = 15
                .Left      = 83
                .Top       = 140
                .Width     = 59
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Operacao", "TextBox")
            WITH THIS.txt_4c_Operacao
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Alignment     = 0
                .Format        = "K"
                .MaxLength     = 20
                .SpecialEffect = 1
                .BorderStyle   = 1
                .Height        = 25
                .Left          = 144
                .Top           = 135
                .Width         = 150
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Documento : (Label3 + Get_Doc) ----------------------------------
            THIS.AddObject("lbl_4c_Documento", "Label")
            WITH THIS.lbl_4c_Documento
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Documento : "
                .Height    = 15
                .Left      = 76
                .Top       = 165
                .Width     = 66
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Docs e numeric(10,0) no schema - Value numerico + InputMask
            *-- (nao MaxLength) transcrito literal do dump.
            THIS.AddObject("txt_4c_Doc", "TextBox")
            WITH THIS.txt_4c_Doc
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = 0
                .Format        = "K"
                .InputMask     = "9999999999"
                .SpecialEffect = 1
                .Height        = 23
                .Left          = 144
                .Top           = 162
                .Width         = 80
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Cond. Pagto : (Say12 + Get_fpg) ---------------------------------
            *-- Say12 e classe "say" PURA (sem Width/Alignment no dump) - nao
            *-- transcrever Alignment=1 nem inventar largura que corte o texto
            *-- (regra CLAUDE.md #23); Width estimada para caber o rotulo
            *-- inteiro antes do TextBox (Left=144).
            THIS.AddObject("lbl_4c_CondPagto", "Label")
            WITH THIS.lbl_4c_CondPagto
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Cond. Pagto : "
                .Height    = 15
                .Left      = 70
                .Top       = 192
                .Width     = 70
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Fpg", "TextBox")
            WITH THIS.txt_4c_Fpg
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .MaxLength     = 12
                .SpecialEffect = 1
                .Height        = 23
                .Left          = 144
                .Top           = 187
                .Width         = 94
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .ToolTipText   = "Digite a forma de pagamento"
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Data : (Label4 + Get_Data) --------------------------------------
            *-- Legado (Get_Data.When): Return .F. - campo NUNCA e editavel
            *-- pelo usuario (e gravado com Datetime() no Init do legado, ao
            *-- criar o registro em branco) - Enabled = .F. sempre.
            THIS.AddObject("lbl_4c_Data", "Label")
            WITH THIS.lbl_4c_Data
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Data : "
                .Height    = 15
                .Left      = 107
                .Top       = 215
                .Width     = 35
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Data", "TextBox")
            WITH THIS.txt_4c_Data
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = {}
                .Format        = "K"
                .SpecialEffect = 1
                .Height        = 23
                .Left          = 144
                .Top           = 212
                .Width         = 75
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- Valor : (Label5 + Get_Valor) ------------------------------------
            *-- Legado (Get_Valor.When): Return (Not ThisForm.Producao) - campo
            *-- so e editavel fora do modo Producao.
            THIS.AddObject("lbl_4c_Valor", "Label")
            WITH THIS.lbl_4c_Valor
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Valor : "
                .Height    = 15
                .Left      = 106
                .Top       = 240
                .Width     = 36
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Valor", "TextBox")
            WITH THIS.txt_4c_Valor
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = 0
                .Format        = "K"
                .InputMask     = "999,999,999.99"
                .SpecialEffect = 1
                .Height        = 23
                .Left          = 144
                .Top           = 237
                .Width         = 100
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Enabled       = !THIS.this_lProducao
                .Visible       = .T.
            ENDWITH

            *-- Motivo : (Label6 + Get_Motivo) ----------------------------------
            THIS.AddObject("lbl_4c_Motivo", "Label")
            WITH THIS.lbl_4c_Motivo
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Motivo : "
                .Height    = 15
                .Left      = 98
                .Top       = 265
                .Width     = 44
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Motivo", "TextBox")
            WITH THIS.txt_4c_Motivo
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Format        = "K!"
                .MaxLength     = 40
                .SpecialEffect = 1
                .Height        = 23
                .Left          = 144
                .Top           = 262
                .Width         = 360
                .ForeColor     = RGB(90, 90, 90)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cria cnt_4c_Cabecalho com os labels de titulo
    * Original: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
    *           lblSombra Top=18 ForeColor=0,0,0 / lblTitulo Top=17 ForeColor=255,255,255
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = 769
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarLookups - BINDEVENT de KeyPress dos campos com lookup
    * (Get_Opera??o/Get_fpg/Get_Cd_Empresa/Get_Ds_Empresa do legado, todos
    * com CreateObject('fwBuscaExt',...)/fAcessoEmpresa no Valid). BINDEVENT
    * em "KeyPress" e seguro aqui porque cada handler TESTA a tecla (F4=115
    * abre o picker direto; Enter=13/Tab=9 valida o valor digitado) antes de
    * agir - regra CLAUDE.md #47 (handler sem teste de tecla em KeyPress e
    * que vira defeito).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLookups()
        BINDEVENT(THIS.txt_4c_Operacao,  "KeyPress", THIS, "ValidarOperacao")
        BINDEVENT(THIS.txt_4c_Fpg,       "KeyPress", THIS, "ValidarFpg")
        BINDEVENT(THIS.txt_4c_CdEmpresa, "KeyPress", THIS, "ValidarCdEmpresa")
        BINDEVENT(THIS.txt_4c_DsEmpresa, "KeyPress", THIS, "ValidarDsEmpresa")
    ENDPROC

    *==========================================================================
    * ValidarOperacao - KeyPress em txt_4c_Operacao
    * Legado (Get_Opera??o.Valid): tabela/coluna variam com THIS.this_lProducao
    * - SigCdOpd.Dopps em modo Producao, SigCdOpe.Dopes fora de Producao
    * (ambas single-column: a propria coluna e codigo e descricao - regra
    * CLAUDE.md "SigCdOpe eh single-column"). F4 abre o picker direto;
    * Enter/Tab tenta match exato e, sem achar, abre o picker com o valor
    * digitado como prefixo LIKE (NUNCA MsgAviso + apagar o digitado -
    * regra CLAUDE.md #50).
    *==========================================================================
    PROCEDURE ValidarOperacao
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_Operacao.Value)
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            IF THIS.this_lProducao
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cVal), ;
                    "cursor_4c_OperVal")
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cVal), ;
                    "cursor_4c_OperVal")
            ENDIF

            IF loc_nResult > 0 AND USED("cursor_4c_OperVal") AND !EOF("cursor_4c_OperVal")
                SELECT cursor_4c_OperVal
                IF THIS.this_lProducao
                    THIS.txt_4c_Operacao.Value = ALLTRIM(Dopps)
                ELSE
                    THIS.txt_4c_Operacao.Value = ALLTRIM(Dopes)
                ENDIF
            ELSE
                THIS.AbrirBuscaOperacao()
            ENDIF
            IF USED("cursor_4c_OperVal")
                USE IN cursor_4c_OperVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_Operacao.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaOperacao - picker de Operacao (tabela/coluna conforme Producao)
    *==========================================================================
    PROCEDURE AbrirBuscaOperacao
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_cTabela, loc_cCampo, ;
              loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.txt_4c_Operacao.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
        loc_cTabela = IIF(THIS.this_lProducao, "SigCdOpd", "SigCdOpe")
        loc_cCampo  = IIF(THIS.this_lProducao, "Dopps",    "Dopes")

        IF USED("cursor_4c_BuscaOper")
            USE IN cursor_4c_BuscaOper
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT " + loc_cCampo + " FROM " + loc_cTabela + ;
                           " ORDER BY " + loc_cCampo
            ELSE
                loc_cSQL = "SELECT " + loc_cCampo + " FROM " + loc_cTabela + ;
                           " WHERE " + loc_cCampo + " LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY " + loc_cCampo
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOper")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOper") OR RECCOUNT("cursor_4c_BuscaOper") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaOper")
                    USE IN cursor_4c_BuscaOper
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT " + loc_cCampo + " FROM " + loc_cTabela + " ORDER BY " + loc_cCampo, ;
                    "cursor_4c_BuscaOper")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOper") OR RECCOUNT("cursor_4c_BuscaOper") = 0
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOper"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna(loc_cCampo, "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOper")
                        SELECT cursor_4c_BuscaOper
                        IF THIS.this_lProducao
                            THIS.txt_4c_Operacao.Value = ALLTRIM(Dopps)
                        ELSE
                            THIS.txt_4c_Operacao.Value = ALLTRIM(Dopes)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaOper")
            USE IN cursor_4c_BuscaOper
        ENDIF
        THIS.txt_4c_Operacao.Refresh
    ENDPROC

    *==========================================================================
    * ValidarFpg - KeyPress em txt_4c_Fpg (Cond. Pagto)
    * Legado (Get_fpg.Valid): CreateObject('fwBuscaExt',...,'SigOpFp',...,
    * 'Fpags',...) com 4 colunas no picker (FPags/Descrs/MoeFPgs/FParcs).
    *==========================================================================
    PROCEDURE ValidarFpg
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaFpg()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_Fpg.Value)
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_FpgVal")
            IF loc_nResult > 0 AND USED("cursor_4c_FpgVal") AND !EOF("cursor_4c_FpgVal")
                SELECT cursor_4c_FpgVal
                THIS.txt_4c_Fpg.Value = ALLTRIM(Fpags)
            ELSE
                THIS.AbrirBuscaFpg()
            ENDIF
            IF USED("cursor_4c_FpgVal")
                USE IN cursor_4c_FpgVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_Fpg.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaFpg - picker de Forma de Pagamento (SigOpFp)
    *==========================================================================
    PROCEDURE AbrirBuscaFpg
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, ;
              loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.txt_4c_Fpg.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

        IF USED("cursor_4c_BuscaFpg")
            USE IN cursor_4c_BuscaFpg
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Fpags, Descrs, MoeFPgs, FParcs FROM SigOpFp ORDER BY Fpags"
            ELSE
                loc_cSQL = "SELECT Fpags, Descrs, MoeFPgs, FParcs FROM SigOpFp " + ;
                           "WHERE Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Fpags"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaFpg")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaFpg") OR RECCOUNT("cursor_4c_BuscaFpg") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaFpg")
                    USE IN cursor_4c_BuscaFpg
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Fpags, Descrs, MoeFPgs, FParcs FROM SigOpFp ORDER BY Fpags", ;
                    "cursor_4c_BuscaFpg")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaFpg") OR RECCOUNT("cursor_4c_BuscaFpg") = 0
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaFpg"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("FPags",   "",      "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "",      "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("MoeFPgs", "XXXXX", "Moeda")
                    loc_oBusca.mAddColuna("FParcs",  "99",    " #")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
                        SELECT cursor_4c_BuscaFpg
                        THIS.txt_4c_Fpg.Value = ALLTRIM(Fpags)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaFpg")
            USE IN cursor_4c_BuscaFpg
        ENDIF
        THIS.txt_4c_Fpg.Refresh
    ENDPROC

    *==========================================================================
    * ValidarCdEmpresa - KeyPress em txt_4c_CdEmpresa
    * Legado (Get_Cd_Empresa.Valid): Return(fAcessoEmpresa(Usuar,'C',...)) -
    * modo LOOKUP por CODIGO. fAcessoEmpresa NAO foi portada (memoria
    * feedback_facessoempresa_nao_portada.md) - substituicao canonica via
    * SigCdEmp.Cemps/Razas (igual ao padrao Formsigatcrp.ValidarEmp).
    *==========================================================================
    PROCEDURE ValidarCdEmpresa
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cVal)
            THIS.txt_4c_DsEmpresa.Value = ""
            THIS.txt_4c_DsEmpresa.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
                SELECT cursor_4c_EmpVal
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_CdEmpresa.Refresh
        THIS.txt_4c_DsEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * ValidarDsEmpresa - KeyPress em txt_4c_DsEmpresa
    * Legado (Get_Ds_Empresa.When): Return(Empty(ThisForm.Get_Cd_Empresa.Value))
    * - a descricao so e editavel enquanto o codigo estiver vazio (permite
    * localizar a empresa digitando a razao social direto). Com o codigo
    * preenchido, a edicao da descricao fica inerte (so exibicao, atualizada
    * pelo lookup de txt_4c_CdEmpresa). fAcessoEmpresa(Usuar,'D',...) - modo
    * LOOKUP por DESCRICAO, mesma substituicao canonica via SigCdEmp.Razas.
    *==========================================================================
    PROCEDURE ValidarDsEmpresa
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CdEmpresa.Value))
            RETURN
        ENDIF

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
                SELECT cursor_4c_EmpVal
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_CdEmpresa.Refresh
        THIS.txt_4c_DsEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - picker compartilhado por txt_4c_CdEmpresa/DsEmpresa
    * (SigCdEmp.Cemps/Razas) - filtra pelo codigo se preenchido, senao pela
    * descricao digitada; fallback para lista completa se o filtro nao casar.
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresa
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, ;
              loc_lProsseguir, loc_oErro

        loc_cValor = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
        ENDIF
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmp")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.txt_4c_CdEmpresa.Refresh
        THIS.txt_4c_DsEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - cria os 3 botoes de acao do dialogo (filhos
    * DIRETOS do form, igual ao legado - SIGPRSDD nao agrupa Fwbtng1/
    * GeraSenha/Saida num CommandGroup/container). Posicoes/Picture/Caption
    * transcritos literalmente do dump (Top=4 nos tres; Left=574/649/724 -
    * 75px de distancia entre cada um, confirmando Width=75 herdado da
    * classe fwbtng, que o SCX nao sobrescreve). Estilo comum (FontName
    * "Comic Sans MS", ForeColor/BackColor/Themes/SpecialEffect/
    * PicturePosition/MousePointer/WordWrap) segue o padrao canonico dos
    * botoes com Picture+Caption (framework_frmcadastro_layout.md); Themes=.F.
    * porque nenhum dos 3 e desabilitado em runtime (regra #99 so exige
    * Themes=.T. quando .Enabled alterna) - mesma escolha do botao irmao
    * "Encerrar" do FormSIGOPBOL (o dialogo que o botao Boleto abre).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro
        TRY
            *-- Boleto (Fwbtng1.Click: Do Form SigOpBol With ThisForm,15) -------
            THIS.AddObject("cmd_4c_Boleto", "CommandButton")
            WITH THIS.cmd_4c_Boleto
                .Top             = 4
                .Left            = 574
                .Width           = 75
                .Height          = 75
                .Caption         = "Boleto"
                .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes           = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")

            *-- Gerar Senha (GeraSenha.Click) ------------------------------------
            THIS.AddObject("cmd_4c_GerarSenha", "CommandButton")
            WITH THIS.cmd_4c_GerarSenha
                .Top             = 4
                .Left            = 649
                .Width           = 75
                .Height          = 75
                .Caption         = "Gerar Senha"
                .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes           = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_GerarSenha, "Click", THIS, "BtnGerarSenhaClick")

            *-- Encerrar (Saida.Click: ThisForm.Release) -------------------------
            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 4
                .Left            = 724
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes           = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBoletoClick - abre o dialogo de impressao de boleto
    * Legado (Fwbtng1.Click): Do Form SigOpBol With ThisForm,15 - o 15 e o
    * pnTpBol (tipo de boleto), obrigatorio (ver FormSIGOPBOL.prg cabecalho,
    * Fase 7: "o 15 estava sendo descartado silenciosamente"). poForm (1o
    * parametro do Do Form legado) nao e reproduzido - FormSIGOPBOL nao usa
    * o form chamador para nada alem do que CREATEOBJECT + Show() ja cobrem.
    *==========================================================================
    PROCEDURE BtnBoletoClick
        LOCAL loc_oForm, loc_oErro
        TRY
            loc_oForm = CREATEOBJECT("FormSIGOPBOL", 15)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgErro("Erro ao criar FormSIGOPBOL." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "BtnBoletoClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnBoletoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - transfere os campos de captura para o Business Object
    * (hook PROTECTED de FormBase - aqui chamado diretamente por
    * BtnGerarSenhaClick, NUNCA via THIS.Salvar(), porque o Salvar() generico
    * de FormBase exibe "Registro salvo com sucesso!" e o legado exibe uma
    * mensagem especifica com a senha gerada - regra CLAUDE.md #20 vale para
    * a FALHA ficar a cargo do BusinessBase; o SUCESSO deste dialogo tem
    * texto proprio). Cobre so os campos que sao espelho direto de um
    * controle; Senhads/Horas (calculados a partir de lookups adicionais)
    * continuam atribuidos em BtnGerarSenhaClick, depois deste metodo.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cCidChaves = fUniqueIds()
            .this_cUsuars    = gc_4c_UsuarioLogado
            .this_dDatas     = DATETIME()
            .this_nTipos     = IIF(THIS.this_lProducao, 1, 0)
            .this_cOperas    = ALLTRIM(THIS.txt_4c_Operacao.Value)
            .this_nDocs      = THIS.txt_4c_Doc.Value
            .this_nValors    = THIS.txt_4c_Valor.Value
            .this_cMotivos   = ALLTRIM(THIS.txt_4c_Motivo.Value)
            .this_cFpags     = ALLTRIM(THIS.txt_4c_Fpg.Value)
            .this_cEmps      = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            .this_cSolicits  = ALLTRIM(THIS.txt_4c_Solic.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnGerarSenhaClick - valida os campos, calcula e grava a Senha do Dia
    * Legado (GeraSenha.Click): 6 validacoes sequenciais (Solicitante/Empresa/
    * Operacao/Documento/Valor-fora-de-Producao/Motivo), cada uma com
    * Messagebox + SetFocus + Return 0 (aqui: MsgAviso + SetFocus + RETURN,
    * fora de qualquer TRY - regra CLAUDE.md #1). Depois: se
    * SigCdPac.SenhDEmps (bit) estiver ligado, soma SigCdEmp.nemps +
    * SigOpFp.nfpags + Valor*100 no numero semente (lnNum); fGerPswDiario()
    * gera a senha de 6 posicoes a partir de Docs/Datas/lnNum. Grava via
    * NovoRegistro()+FormParaBO()+Salvar() (os dois primeiros PUBLIC/PROTECTED
    * de convencao arquitetural - FormParaBO e o hook de FormBase; Salvar()
    * e PUBLIC na BusinessBase - regra #51 - e chama Inserir() internamente,
    * que fica PROTECTED no BO).
    *
    * Fase 8 (template generico de form CRUD): BtnBuscarClick/BtnSalvarClick/
    * BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
    * AjustarBotoesPorModo NAO se aplicam a este form - mesma razao ja
    * documentada em ConfigurarPageFrame para as Fases 4 e 7: SIGPRSDD e um
    * dialogo modal de captura UNICA (gera a senha e fecha, via
    * BtnGerarSenhaClick/BtnEncerrarClick acima), sem Lista/Grid para
    * Buscar/CarregarLista, sem modos INCLUIR/ALTERAR/VISUALIZAR para
    * HabilitarCampos/AjustarBotoesPorModo, e sem Confirmar/Cancelar de
    * formulario CRUD (o par real do legado e Gerar Senha/Encerrar, ja
    * implementado). BOParaForm tambem nao se aplica: o dialogo nunca carrega
    * um registro existente para edicao - e sempre um INSERT novo.
    *==========================================================================
    PROCEDURE BtnGerarSenhaClick
        LOCAL loc_cSolic, loc_cEmp, loc_cOperacao, loc_nDoc, loc_cFpg, ;
              loc_nValor, loc_cMotivo, loc_lSenhDEmps, loc_nNum, ;
              loc_nResult, loc_cSenha, loc_lSucesso, loc_oErro

        loc_cSolic    = ALLTRIM(THIS.txt_4c_Solic.Value)
        loc_cEmp      = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        loc_cOperacao = ALLTRIM(THIS.txt_4c_Operacao.Value)
        loc_nDoc      = THIS.txt_4c_Doc.Value
        loc_cFpg      = ALLTRIM(THIS.txt_4c_Fpg.Value)
        loc_nValor    = THIS.txt_4c_Valor.Value
        loc_cMotivo   = ALLTRIM(THIS.txt_4c_Motivo.Value)

        IF EMPTY(loc_cSolic)
            MsgAviso("Informe o Nome do Solicitante...", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Solic.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cEmp)
            MsgAviso("Informe a Empresa...", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_CdEmpresa.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cOperacao)
            MsgAviso("Informe a Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Operacao.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_nDoc)
            MsgAviso("Informe o N" + CHR(250) + "mero do Documento...", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Doc.SetFocus()
            RETURN
        ENDIF

        IF !THIS.this_lProducao AND EMPTY(loc_nValor)
            MsgAviso("Informe o Valor...", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Valor.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cMotivo)
            MsgAviso("Informe o Motivo...", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Motivo.SetFocus()
            RETURN
        ENDIF

        loc_lSucesso = .F.
        TRY
            *-- "Select SenhDEmps From SigCdPac" do Init legado - replicado aqui
            *-- (so e usado neste metodo e precisa de gnConnHandle vivo, que o
            *-- InicializarForm nao garante durante gb_4c_ValidandoUI)
            loc_lSenhDEmps = .F.
            IF USED("cursor_4c_Parac")
                USE IN cursor_4c_Parac
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 SenhDEmps FROM SigCdPac", "cursor_4c_Parac")
            IF loc_nResult > 0 AND USED("cursor_4c_Parac") AND !EOF("cursor_4c_Parac")
                loc_lSenhDEmps = cursor_4c_Parac.SenhDEmps
            ENDIF
            IF USED("cursor_4c_Parac")
                USE IN cursor_4c_Parac
            ENDIF

            *-- "If CrParac.SenhDEmps ... lnNum = nemps + nfpags + (Valors*100)"
            loc_nNum = 0
            IF loc_lSenhDEmps
                IF USED("cursor_4c_EmpNum")
                    USE IN cursor_4c_EmpNum
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 nemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
                    "cursor_4c_EmpNum")
                IF loc_nResult > 0 AND USED("cursor_4c_EmpNum") AND !EOF("cursor_4c_EmpNum")
                    loc_nNum = NVL(cursor_4c_EmpNum.nemps, 0)
                ENDIF
                IF USED("cursor_4c_EmpNum")
                    USE IN cursor_4c_EmpNum
                ENDIF

                IF USED("cursor_4c_FpgNum")
                    USE IN cursor_4c_FpgNum
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 nfpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cFpg), ;
                    "cursor_4c_FpgNum")
                IF loc_nResult > 0 AND USED("cursor_4c_FpgNum") AND !EOF("cursor_4c_FpgNum")
                    loc_nNum = loc_nNum + NVL(cursor_4c_FpgNum.nfpags, 0) + (loc_nValor * 100)
                ENDIF
                IF USED("cursor_4c_FpgNum")
                    USE IN cursor_4c_FpgNum
                ENDIF
            ENDIF

            *-- "lcSenha = fGerPswDiario(crSigPrSnd.Docs, crSigPrSnd.Datas, lnNum)"
            *-- fGerPswDiario e funcao global Fortyus (SIGFUNCS.PRG) FORA do
            *-- acervo - mesmo gap ja presente (sem wrapper em utils\) em
            *-- sigtosenBO.prg, sigprsenBO.prg e Formsigtosen.prg; nao
            *-- inventado aqui, so TRANSCRITO (regra CLAUDE.md #27 - valor de
            *-- CALCULO nunca se chuta, fica ausente/visivel ate um wrapper
            *-- correto ser escrito e propagado aos 4 sites de uma vez).
            loc_cSenha = fGerPswDiario(loc_nDoc, DATETIME(), loc_nNum)

            THIS.this_oBusinessObject.NovoRegistro()
            THIS.FormParaBO()
            WITH THIS.this_oBusinessObject
                .this_cSenhads = loc_cSenha
                .this_cHoras   = TIME()

                loc_lSucesso = .Salvar()
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnGerarSenhaClick")
        ENDTRY

        *-- BusinessBase.Salvar() ja exibe a falha sozinho (regra CLAUDE.md
        *-- #20) - o form so reage ao sucesso.
        IF loc_lSucesso
            MsgInfo("Favor Anotar a Senha : " + CHR(13) + CHR(13) + ;
                loc_cSenha + CHR(13) + CHR(13), "Senha do Dia")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - fecha o dialogo sem gravar
    * Legado (Saida.Click): ThisForm.Release
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis recursivamente os controles
    * criados via AddObject (que nascem com Visible=.F.)
    *==========================================================================
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSddBO.prg):
*====================================================================
* SigPrSddBO.prg
*
* Business Object para Senha do Dia
* Tabela: SigPrSnd
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrSddBO AS BusinessBase

	*-- Propriedades da entidade (SigPrSnd)
	this_cCidChaves = ""   && cidchaves char(20) - PK (gerada via fUniqueIds())
	this_cUsuars    = ""   && usuars    char(10) - Usuario que gerou a senha
	this_dDatas     = {}   && datas     datetime - Data/hora da solicitacao
	this_nTipos     = 0    && tipos     numeric(1,0) - 1=Producao / 0=Nao-Producao
	this_cOperas    = ""   && operas    char(20) - Codigo da operacao (SigCdOpe/SigCdOpd)
	this_nDocs      = 0    && docs      numeric(10,0) - Numero do documento
	this_nValors    = 0    && valors    numeric(11,2) - Valor (campo so usado fora de Producao)
	this_cMotivos   = ""   && motivos   char(40) - Motivo da solicitacao
	this_cFpags     = ""   && fpags     char(12) - Forma de pagamento (SigOpFp)
	this_cEmps      = ""   && cemps      char(3) - Codigo da empresa (SigCdEmp)
	this_cSenhads   = ""   && senhads   char(6) - Senha do dia gerada (fGerPswDiario)
	this_cHoras     = ""   && horas     char(8) - Hora da geracao da senha
	this_cSolicits  = ""   && solicits  char(10) - Codigo do solicitante

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigPrSnd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves = TratarNulo(cidchaves, "")
				THIS.this_cUsuars    = TratarNulo(usuars,    "")
				THIS.this_dDatas     = ConverterParaData(TratarNulo(datas, {}))
				THIS.this_nTipos     = TratarNulo(tipos,     0)
				THIS.this_cOperas    = TratarNulo(operas,    "")
				THIS.this_nDocs      = TratarNulo(docs,      0)
				THIS.this_nValors    = TratarNulo(valors,    0)
				THIS.this_cMotivos   = TratarNulo(motivos,   "")
				THIS.this_cFpags     = TratarNulo(fpags,     "")
				THIS.this_cEmps      = TratarNulo(emps,      "")
				THIS.this_cSenhads   = TratarNulo(senhads,   "")
				THIS.this_cHoras     = TratarNulo(horas,     "")
				THIS.this_cSolicits  = TratarNulo(solicits,  "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrSddBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere a Senha do Dia gerada na tabela SigPrSnd
	*
	* Colunas empdopnums (char(29)) e perlimite (numeric(5,2)) sao NOT NULL
	* no schema mas NAO existem no form/BO original (nenhum controle, nenhuma
	* referencia no codigo legado) - recebem o default do tipo (regra #22 do
	* CLAUDE.md: coluna NOT NULL sem property usa EscaparSQL("")/
	* FormatarNumeroSQL(0,<dec>), nunca a string vazia direto no SQL).
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigPrSnd (cidchaves, usuars, datas, tipos, operas, docs, valors, motivos, fpags, emps, senhads, horas, solicits, empdopnums, perlimite)
				VALUES (
					<<EscaparSQL(THIS.this_cCidChaves)>>,
					<<EscaparSQL(THIS.this_cUsuars)>>,
					<<FormatarDataSQL(THIS.this_dDatas)>>,
					<<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
					<<EscaparSQL(THIS.this_cOperas)>>,
					<<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
					<<EscaparSQL(THIS.this_cMotivos)>>,
					<<EscaparSQL(THIS.this_cFpags)>>,
					<<EscaparSQL(THIS.this_cEmps)>>,
					<<EscaparSQL(THIS.this_cSenhads)>>,
					<<EscaparSQL(THIS.this_cHoras)>>,
					<<EscaparSQL(THIS.this_cSolicits)>>,
					<<EscaparSQL("")>>,
					<<FormatarNumeroSQL(0, 2)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao gravar a senha do dia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrSddBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigPrSnd
	* (o legado so grava a Senha do Dia uma vez por chamada - este metodo
	* existe para completar a arquitetura em camadas, caso algum fluxo
	* futuro precise corrigir um registro ja gravado pela chave cidchaves)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigPrSnd
				SET usuars   = <<EscaparSQL(THIS.this_cUsuars)>>,
					datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
					tipos    = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
					operas   = <<EscaparSQL(THIS.this_cOperas)>>,
					docs     = <<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
					valors   = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
					motivos  = <<EscaparSQL(THIS.this_cMotivos)>>,
					fpags    = <<EscaparSQL(THIS.this_cFpags)>>,
					emps     = <<EscaparSQL(THIS.this_cEmps)>>,
					senhads  = <<EscaparSQL(THIS.this_cSenhads)>>,
					horas    = <<EscaparSQL(THIS.this_cHoras)>>,
					solicits = <<EscaparSQL(THIS.this_cSolicits)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar a senha do dia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrSddBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


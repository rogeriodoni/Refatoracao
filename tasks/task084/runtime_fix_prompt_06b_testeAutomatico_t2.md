# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-04 12:51:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 12:51:36] [INFO] Config FPW: (nao fornecido)
[2026-06-04 12:51:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 12:51:36] [INFO] Timeout: 300 segundos
[2026-06-04 12:51:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u4gn42w2.prg
[2026-06-04 12:51:36] [INFO] Conteudo do wrapper:
[2026-06-04 12:51:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'
QUIT

[2026-06-04 12:51:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u4gn42w2.prg
[2026-06-04 12:51:36] [INFO] VFP output esperado em: C:\4c\tasks\task084\vfp_output.txt
[2026-06-04 12:51:36] [INFO] Executando Visual FoxPro 9...
[2026-06-04 12:51:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u4gn42w2.prg
[2026-06-04 12:51:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u4gn42w2.prg
[2026-06-04 12:51:36] [INFO] Timeout configurado: 300 segundos
[2026-06-04 12:51:42] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-04 12:51:42] [INFO] VFP9 finalizado em 5.0879839 segundos
[2026-06-04 12:51:42] [INFO] Exit Code: 
[2026-06-04 12:51:42] [INFO] 
[2026-06-04 12:51:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 12:51:42] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u4gn42w2.prg
[2026-06-04 12:51:42] [INFO] 
[2026-06-04 12:51:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 12:51:42] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 12:51:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 12:51:42] [INFO] * Parameters: 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'
[2026-06-04 12:51:42] [INFO] 
[2026-06-04 12:51:42] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 12:51:42] [INFO] SET SAFETY OFF
[2026-06-04 12:51:42] [INFO] SET RESOURCE OFF
[2026-06-04 12:51:42] [INFO] SET TALK OFF
[2026-06-04 12:51:42] [INFO] SET NOTIFY OFF
[2026-06-04 12:51:42] [INFO] SYS(2335, 0)
[2026-06-04 12:51:42] [INFO] 
[2026-06-04 12:51:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'
[2026-06-04 12:51:42] [INFO] QUIT
[2026-06-04 12:51:42] [INFO] 
[2026-06-04 12:51:42] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 12:51:42] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-06-04 12:53:00] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 12:53:00] [INFO] Config FPW: (nao fornecido)
[2026-06-04 12:53:00] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 12:53:00] [INFO] Timeout: 300 segundos
[2026-06-04 12:53:00] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_telvcly2.prg
[2026-06-04 12:53:00] [INFO] Conteudo do wrapper:
[2026-06-04 12:53:00] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'
QUIT

[2026-06-04 12:53:00] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_telvcly2.prg
[2026-06-04 12:53:00] [INFO] VFP output esperado em: C:\4c\tasks\task084\vfp_output.txt
[2026-06-04 12:53:00] [INFO] Executando Visual FoxPro 9...
[2026-06-04 12:53:00] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_telvcly2.prg
[2026-06-04 12:53:00] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_telvcly2.prg
[2026-06-04 12:53:00] [INFO] Timeout configurado: 300 segundos
[2026-06-04 12:58:00] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 3692)...
[2026-06-04 12:58:02] [INFO] VFP9 finalizado em 302.0730601 segundos
[2026-06-04 12:58:02] [INFO] Exit Code: 4
[2026-06-04 12:58:02] [INFO] 
[2026-06-04 12:58:02] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 12:58:02] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_telvcly2.prg
[2026-06-04 12:58:02] [INFO] 
[2026-06-04 12:58:02] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 12:58:02] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 12:58:02] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 12:58:02] [INFO] * Parameters: 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'
[2026-06-04 12:58:02] [INFO] 
[2026-06-04 12:58:02] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 12:58:02] [INFO] SET SAFETY OFF
[2026-06-04 12:58:02] [INFO] SET RESOURCE OFF
[2026-06-04 12:58:02] [INFO] SET TALK OFF
[2026-06-04 12:58:02] [INFO] SET NOTIFY OFF
[2026-06-04 12:58:02] [INFO] SYS(2335, 0)
[2026-06-04 12:58:02] [INFO] 
[2026-06-04 12:58:02] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReEch', 'C:\4c\tasks\task084', 'OPERACIONAL'
[2026-06-04 12:58:02] [INFO] QUIT
[2026-06-04 12:58:02] [INFO] 
[2026-06-04 12:58:02] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 12:58:02] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReEch.prg):
*==============================================================================
* FormSigReEch.prg
* Form: Emissao de Cheque
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo modal para emissao de cheque fisico ou copia
* Chamado com parametros: emps, dopes, numes, op_escolha, ncheque (opcional)
*==============================================================================

DEFINE CLASS FormSigReEch AS FormBase

    *-- Dimensoes e comportamento EXATOS do original (SIGREECH.SCX)
    Caption      = ""
    Width        = 800
    Height       = 315
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow   = 1
    Themes       = .F.

    *-- Propriedades customizadas do form original (ClassInfo)
    emps          = ""   && empresa (char 3)
    dopes         = ""   && documento operacao PADR(20)
    numes         = 0    && numero da operacao
    op_escolha    = ""   && INSERIR ou ALTERAR
    enviaimp      = .F.  && .T.=imprimir fisico, .F.=preview video
    peantvalue    = ""   && valor anterior do verso para detectar mudanca
    ncheque_param = ""   && filtro inicial de numero de cheque (opcional)

    *-- Titulo interno (FormBase)
    this_cTituloForm = "Emissao de Cheque"

    *==========================================================================
    * Init - Recebe parametros do cheque e inicializa o form
    * par_cEmps, par_cDopes, par_nNumes: identificacao do documento
    * par_cOpEscolha: INSERIR ou ALTERAR
    * par_cNcheque: numero do cheque para filtro (opcional, "" = sem filtro)
    *==========================================================================
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cOpEscolha, par_cNcheque)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Salva parametros antes de DODEFAULT (InicializarForm precisara deles)
            THIS.emps         = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
            THIS.dopes        = PADR(IIF(VARTYPE(par_cDopes) = "C", par_cDopes, ""), 20)
            THIS.numes        = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
            THIS.op_escolha   = IIF(VARTYPE(par_cOpEscolha) = "C", par_cOpEscolha, "")
            THIS.ncheque_param = IIF(VARTYPE(par_cNcheque) = "C", par_cNcheque, "")

            *-- Cria Business Object antes de DODEFAULT
            THIS.this_oBusinessObject = CREATEOBJECT("SigReEchBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigReEchBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                *-- FormBase.Init() chama InicializarForm() internamente
                loc_lSucesso = DODEFAULT()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigReEch:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria containers base e carrega dados do cheque
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen = .T.

            *-- Titulo e imagem de fundo (exatos do original)
            THIS.this_cTituloForm = "Emiss" + CHR(227) + "o de Cheque"
            THIS.Caption          = "Emiss" + CHR(227) + "o de Cheque"
            THIS.Picture          = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Cria container do cabecalho cinza (cntSombra do original)
            THIS.ConfigurarPageFrame()

            *-- Cria container de dados do cheque (cnt_4c_Cheque)
            THIS.ConfigurarPaginaDados()

            *-- Cria botoes operacionais, OptionGroup e label de estado
            THIS.ConfigurarPaginaLista()

            *-- Carrega dados via BO (sem depender de controles visuais)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarDadosCheque()
                THIS.InicializarEstadoBotoes()
                THIS.BOParaForm()
            ENDIF

            THIS.LockScreen = .F.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro("Erro ao inicializar o formul" + CHR(225) + "rio:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria container cabecalho cinza (cntSombra)
    * Fase 3: cabecalho completo com titulos sombra e branco
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.

                *-- Label sombra (preto, deslocado 1px para efeito 3D)
                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .FontBold      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 18
                    .FontUnderline = .F.
                    .WordWrap      = .T.
                    .Alignment     = 0
                    .BackStyle     = 0
                    .Caption       = "Emiss" + CHR(227) + "o de Cheque"
                    .Height        = 40
                    .Left          = 10
                    .Top           = 25
                    .Width         = THIS.Width
                    .ForeColor     = RGB(0, 0, 0)
                    .Visible       = .T.
                ENDWITH

                *-- Label titulo (branco sobre cinza)
                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .WordWrap  = .T.
                    .Alignment = 0
                    .BackStyle = 0
                    .Caption   = "Emiss" + CHR(227) + "o de Cheque"
                    .Height    = 46
                    .Left      = 10
                    .Top       = 24
                    .Width     = THIS.Width
                    .ForeColor = RGB(255, 255, 255)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria container e campos de informacoes do cheque
    * cnt_4c_Cheque: Bco, Agencia, Conta, Numero, Valor, Vencimento (somente leitura)
    * txt_4c_Favorecido: editavel em INSERIR/ALTERAR
    * txt_4c_Copia: numero de copias (somente leitura)
    * obj_4c_Get_Verso: texto do verso (editavel em INSERIR/ALTERAR quando ImpVersos=0)
    * obj_4c_OModem: controle OLE MSComm para porta serial da impressora
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro, loc_oErrOle
        TRY
            *-- Container cheque (Cheque do original: Top=83, Left=134, W=487, H=51)
            THIS.AddObject("cnt_4c_Cheque", "Container")
            WITH THIS.cnt_4c_Cheque
                .Top           = 83
                .Left          = 134
                .Width         = 487
                .Height        = 51
                .BackStyle     = 0
                .BorderWidth   = 1
                .SpecialEffect = 2
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.

                *-- Labels de cabecalho dos campos do cheque
                .AddObject("lbl_4c_Say2", "Label")
                WITH .lbl_4c_Say2
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Bco"
                    .Left      = 12
                    .Top       = 3
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Say3", "Label")
                WITH .lbl_4c_Say3
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Ag" + CHR(234) + "ncia"
                    .Left      = 57
                    .Top       = 3
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Say5", "Label")
                WITH .lbl_4c_Say5
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Conta"
                    .Left      = 107
                    .Top       = 3
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Say4", "Label")
                WITH .lbl_4c_Say4
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "N" + CHR(250) + "mero"
                    .Left      = 196
                    .Top       = 3
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_SayValor", "Label")
                WITH .lbl_4c_SayValor
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Valor"
                    .Left      = 259
                    .Top       = 3
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_SayVenc", "Label")
                WITH .lbl_4c_SayVenc
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Vencimento"
                    .Left      = 390
                    .Top       = 3
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                *-- TextBoxes somente leitura (dados carregados via BOParaForm)
                .AddObject("txt_4c_Bco", "TextBox")
                WITH .txt_4c_Bco
                    .Left      = 12
                    .Top       = 17
                    .Width     = 36
                    .Height    = 23
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackColor = RGB(240, 240, 240)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_Age", "TextBox")
                WITH .txt_4c_Age
                    .Left      = 58
                    .Top       = 17
                    .Width     = 38
                    .Height    = 23
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackColor = RGB(240, 240, 240)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_Conta", "TextBox")
                WITH .txt_4c_Conta
                    .Left      = 106
                    .Top       = 17
                    .Width     = 80
                    .Height    = 23
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackColor = RGB(240, 240, 240)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_Num", "TextBox")
                WITH .txt_4c_Num
                    .Left      = 196
                    .Top       = 17
                    .Width     = 52
                    .Height    = 23
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackColor = RGB(240, 240, 240)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_Valor", "TextBox")
                WITH .txt_4c_Valor
                    .Left      = 258
                    .Top       = 17
                    .Width     = 121
                    .Height    = 23
                    .ReadOnly  = .T.
                    .InputMask = "999,999,999.99"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackColor = RGB(240, 240, 240)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_Vencimento", "TextBox")
                WITH .txt_4c_Vencimento
                    .Left      = 389
                    .Top       = 17
                    .Width     = 83
                    .Height    = 23
                    .ReadOnly  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackColor = RGB(240, 240, 240)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Label e campo Favorecido (editavel em INSERIR/ALTERAR)
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Favorecido"
                .Left      = 134
                .Top       = 136
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Favorecido", "TextBox")
            WITH THIS.txt_4c_Favorecido
                .Left      = 134
                .Top       = 151
                .Width     = 338
                .Height    = 23
                .MaxLength = 40
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Label e campo N Copia (somente leitura)
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(186) + " C" + CHR(243) + "pia"
                .Left      = 474
                .Top       = 136
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Copia", "TextBox")
            WITH THIS.txt_4c_Copia
                .Left      = 474
                .Top       = 151
                .Width     = 63
                .Height    = 23
                .ReadOnly  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(240, 240, 240)
                .Visible   = .T.
            ENDWITH

            *-- Label Verso e EditBox para texto do verso
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Verso"
                .Left      = 134
                .Top       = 177
                .Height    = 15
                .Width     = 29
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_Get_Verso", "EditBox")
            WITH THIS.obj_4c_Get_Verso
                .Left      = 134
                .Top       = 192
                .Width     = 404
                .Height    = 120
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- OLE MSComm para comunicacao serial com impressora de cheque
            TRY
                THIS.AddObject("obj_4c_OModem", "OLEControl", "MSCommLib.MSComm")
                WITH THIS.obj_4c_OModem
                    .Top     = 12
                    .Left    = 504
                    .Height  = 100
                    .Width   = 100
                    .Visible = .F.
                ENDWITH
            CATCH TO loc_oErrOle
                MsgErro("OLE MSComm indispon" + CHR(237) + "vel: " + ;
                        loc_oErrOle.Message, "Aviso")
            ENDTRY

            BINDEVENT(THIS.txt_4c_Favorecido, "KeyPress", THIS, "FavorecidoLostFocus")
            BINDEVENT(THIS.obj_4c_Get_Verso,  "KeyPress", THIS, "VersoLostFocus")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDadosCheque - Carrega dados do cheque, parcela e empresa via BO
    * Chamado durante InicializarForm (antes dos controles visuais existirem)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDadosCheque()
        LOCAL loc_oBO, loc_cEDN, loc_oErro
        TRY
            loc_oBO  = THIS.this_oBusinessObject
            loc_cEDN = THIS.emps + THIS.dopes + STR(THIS.numes, 6)

            *-- Carrega registro de SigCqChi
            loc_oBO.CarregarDados(THIS.emps, THIS.dopes, THIS.numes, THIS.ncheque_param)

            *-- Carrega parcela vinculada em SigMvPar
            loc_oBO.CarregarParcela(loc_cEDN)

            *-- Carrega dados da empresa em SigCdEmp
            loc_oBO.CarregarEmpresa(THIS.emps)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do container
    * Itera recursivamente em sub-containers e Pages de PageFrames
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_p, loc_oControl, loc_lExcluido
        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                loc_lExcluido = INLIST(UPPER(loc_oControl.Name), "CNT_4C_SOMBRA")
                IF PEMSTATUS(loc_oControl, "Visible", 5) AND !loc_lExcluido
                    loc_oControl.Visible = .T.
                ENDIF
                IF !loc_lExcluido
                    IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                        FOR loc_p = 1 TO loc_oControl.PageCount
                            THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                        ENDFOR
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria botoes operacionais, OptionGroup e lbl_4c_LbNimp
    * Fase 4: cmd_4c_Visualizar, cmd_4c_Imprimir, cmd_4c_Encerrar,
    *          opt_4c_Imprime, lbl_4c_LbNimp
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH THIS.cmd_4c_Visualizar
                .Top             = 2
                .Left            = 573
                .Height          = 75
                .Width           = 75
                .Caption         = "V" + CHR(237) + "deo"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH THIS.cmd_4c_Imprimir
                .Top             = 2
                .Left            = 648
                .Height          = 75
                .Width           = 75
                .Caption         = "Impressora"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 2
                .Left            = 723
                .Height          = 75
                .Width           = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("opt_4c_Imprime", "OptionGroup")
            WITH THIS.opt_4c_Imprime
                .ButtonCount   = 3
                .BackStyle     = 0
                .Value         = 1
                .Height        = 73
                .Left          = 543
                .SpecialEffect = 1
                .Top           = 192
                .Width         = 79
                .BorderColor   = RGB(36, 84, 155)
                .Visible       = .T.
                WITH .Buttons(1)
                    .BackStyle = 0
                    .Caption   = "Cheque"
                    .Value     = 1
                    .Height    = 15
                    .Left      = 7
                    .Top       = 7
                    .Width     = 55
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Verso"
                    .Value     = 2
                    .Height    = 15
                    .Left      = 7
                    .Top       = 28
                    .Width     = 45
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(3)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "C" + CHR(243) + "pia"
                    .Value     = 3
                    .Height    = 15
                    .Left      = 7
                    .Top       = 49
                    .Width     = 45
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            THIS.AddObject("lbl_4c_LbNimp", "Label")
            WITH THIS.lbl_4c_LbNimp
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "( N" + CHR(227) + "o Impresso )"
                .Height    = 15
                .Left      = 173
                .Top       = 177
                .Width     = 82
                .ForeColor = RGB(128, 64, 64)
                .Visible   = .F.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_Visualizar, "Click",             THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmd_4c_Imprimir,   "Click",             THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmd_4c_Encerrar,   "Click",             THIS, "BtnEncerrarClick")
            BINDEVENT(THIS.opt_4c_Imprime,    "InteractiveChange", THIS, "OptImprimicChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Sincroniza estado do botao Video com a opcao selecionada
    *==========================================================================
    PROCEDURE AlternarPagina()
        IF VARTYPE(THIS.cmd_4c_Visualizar) = "O" AND VARTYPE(THIS.opt_4c_Imprime) = "O"
            THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
        ENDIF
    ENDPROC

    *==========================================================================
    * InicializarEstadoBotoes - Define estado inicial dos botoes apos carregar dados
    *==========================================================================
    PROTECTED PROCEDURE InicializarEstadoBotoes()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                THIS.opt_4c_Imprime.Buttons(2).Enabled = loc_oBO.this_lEmitidos
                THIS.opt_4c_Imprime.Buttons(3).Enabled = loc_oBO.this_lEmitidos
                THIS.opt_4c_Imprime.Value = IIF(loc_oBO.this_lEmitidos, 3, 1)
                IF loc_oBO.this_lEmitidos
                    THIS.opt_4c_Imprime.Buttons(3).SetFocus
                ENDIF
                THIS.cmd_4c_Visualizar.Enabled  = loc_oBO.this_lEmitidos
                THIS.lbl_4c_LbNimp.Visible      = (loc_oBO.this_nImpVersos = 0)
                IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
                    THIS.obj_4c_Get_Verso.ReadOnly = !(INLIST(THIS.op_escolha, "INSERIR", "ALTERAR") AND loc_oBO.this_nImpVersos = 0)
                    IF THIS.obj_4c_Get_Verso.ReadOnly
                        THIS.obj_4c_Get_Verso.BackColor = RGB(240, 240, 240)
                    ENDIF
                ENDIF
                IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
                    THIS.txt_4c_Favorecido.ReadOnly = !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
                    IF THIS.txt_4c_Favorecido.ReadOnly
                        THIS.txt_4c_Favorecido.BackColor = RGB(240, 240, 240)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OptImprimicChange - Atualiza Visualizar.Enabled conforme opcao selecionada
    *==========================================================================
    PROCEDURE OptImprimicChange()
        THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe copia do cheque em preview (Video)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.enviaimp = .F.
        THIS.EmiteCopia()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Coloca form em modo INSERIR e dispara emissao do cheque
    * Equivalente ao fluxo Op_Escolha="INSERIR" do legado: marca operacao como
    * inclusao de novo cheque e executa impressao da frente conforme opcao.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            THIS.op_escolha = "INSERIR"

            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                IF loc_oBO.this_lEmitidos
                    MsgAviso("Este cheque j" + CHR(225) + " foi emitido." + CHR(13) + ;
                             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel emitir novamente.", ;
                             "Aviso")
                ELSE
                    DO CASE
                    CASE THIS.opt_4c_Imprime.Value = 1
                        THIS.EmiteCheque()
                    CASE THIS.opt_4c_Imprime.Value = 2
                        THIS.EmiteVerso()
                    OTHERWISE
                        THIS.enviaimp = .T.
                        THIS.EmiteCopia()
                    ENDCASE
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir emiss" + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Coloca form em modo ALTERAR e habilita edicao do verso
    * Equivalente ao fluxo Op_Escolha="ALTERAR" do legado: permite alterar
    * favorecido e verso. Mantem registro existente, nao cria novo.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            THIS.op_escolha = "ALTERAR"

            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                *-- Reabilita campos editaveis no modo ALTERAR
                IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
                    THIS.txt_4c_Favorecido.Enabled = .T.
                ENDIF
                IF VARTYPE(THIS.obj_4c_Get_Verso) = "O" AND loc_oBO.this_nImpVersos = 0
                    THIS.obj_4c_Get_Verso.Enabled = .T.
                    THIS.obj_4c_Get_Verso.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar cheque:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Cancela emissao do cheque (marca como nao emitido)
    * Equivalente ao bloco "If !crSigCqChi.Emitidos" do Sair.Click legado:
    * persiste status nao-emitido e libera o cheque para emissao futura.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oBO, loc_lConfirma, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                IF loc_oBO.this_lEmitidos
                    MsgAviso("Este cheque j" + CHR(225) + " foi emitido e n" + CHR(227) + "o pode ser cancelado.", ;
                             "Aviso")
                ELSE
                    loc_lConfirma = MsgConfirma("Confirma o cancelamento da emiss" + CHR(227) + "o deste cheque?")
                    IF loc_lConfirma
                        loc_oBO.this_lEmitidos = .F.
                        loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
                                                  loc_oBO.this_cFavos, ;
                                                  loc_oBO.this_nNEmissoes)
                        MsgInfo("Emiss" + CHR(227) + "o cancelada com sucesso.", "Cancelado")
                        THIS.Release()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao cancelar emiss" + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Imprime frente, verso ou copia conforme opcao selecionada
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        DO CASE
        CASE THIS.opt_4c_Imprime.Value = 1
            THIS.EmiteCheque()
        CASE THIS.opt_4c_Imprime.Value = 2
            THIS.EmiteVerso()
        CASE THIS.opt_4c_Imprime.Value = 3 OR THIS.opt_4c_Imprime.Value = 4
            THIS.enviaimp = .T.
            THIS.EmiteCopia()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra form; se nao emitido, salva status e confirma saida
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oBO, loc_lConfirmado, loc_oErro
        TRY
            loc_oBO         = THIS.this_oBusinessObject
            loc_lConfirmado = .T.
            IF VARTYPE(loc_oBO) = "O" AND !loc_oBO.this_lEmitidos
                loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
                                          loc_oBO.this_cFavos, ;
                                          loc_oBO.this_nNEmissoes)
                loc_lConfirmado = MsgConfirma("ATEN" + CHR(199) + CHR(195) + "O!!!" + CHR(13) + ;
                    "Este cheque n" + CHR(227) + "o ser" + CHR(225) + " emitido..." + CHR(13) + ;
                    "Confirmando a sua sa" + CHR(237) + "da, este cheque ficar" + CHR(225) + ;
                    " pendente at" + CHR(233) + " a sua emiss" + CHR(227) + "o." + CHR(13) + ;
                    "Confirma a Sa" + CHR(237) + "da ?")
            ENDIF
            IF loc_lConfirmado
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EmiteCheque - Emite cheque fisico na impressora via porta serial
    *==========================================================================
    PROCEDURE EmiteCheque()
        LOCAL loc_oBO, loc_nImpCheqs, loc_cValor, loc_cData, loc_cSQL, loc_oErro
        TRY
            loc_oBO       = THIS.this_oBusinessObject
            loc_nImpCheqs = 1

            IF !PEMSTATUS(THIS, "obj_4c_OModem", 5)
                MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
                        CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
            ELSE
            loc_cSQL      = "SELECT ImpCheqs FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
                SELECT cursor_4c_Param
                GO TOP
                loc_nImpCheqs = NVL(ImpCheqs, 1)
                USE IN cursor_4c_Param
            ENDIF

            MsgInfo("Posicione o cheque na impressora...", "IMPRIME CHEQUE")

            loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
                       "WHERE Tipos = 'Impressora de Cheque'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
                SELECT cursor_4c_CfCom
                GO TOP
                IF !EOF()
                    IF !THIS.obj_4c_OModem.portopen
                        THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
                        THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
                        THIS.obj_4c_OModem.Inputlen = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_CfCom
                THIS.obj_4c_OModem.PortOpen = .T.

                IF loc_nImpCheqs = 2
                    loc_cValor = ALLTRIM(TRANSFORM(loc_oBO.this_nParValos * 100, "@L 99999999999999"))
                    loc_cData  = TRANSFORM(DAY(loc_oBO.this_dParVencs),   "@L 99") + ;
                                 TRANSFORM(MONTH(loc_oBO.this_dParVencs), "@L 99") + ;
                                 RIGHT(STR(YEAR(loc_oBO.this_dParVencs), 4), 2)
                    SET CENTURY OFF
                    THIS.obj_4c_OModem.Output = CHR(27) + "B" + loc_oBO.this_cParBancos
                    THIS.obj_4c_OModem.Output = CHR(27) + "F" + loc_oBO.this_cFavos + "$"
                    THIS.obj_4c_OModem.Output = CHR(27) + "D" + loc_cData
                    THIS.obj_4c_OModem.Output = CHR(27) + "C" + ALLTRIM(loc_oBO.this_cCidEmps) + "$"
                    THIS.obj_4c_OModem.Output = CHR(27) + "V" + loc_cValor
                    SET CENTURY ON
                ELSE
                    SET POINT TO ","
                    loc_cValor = ALLTRIM(TRANSFORM(loc_oBO.this_nParValos, "99999999999.99"))
                    SET CENTURY OFF
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(64)  + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(162) + loc_oBO.this_cParBancos + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(160) + loc_oBO.this_cFavos + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(163) + loc_cValor + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(164) + DTOC(loc_oBO.this_dParVencs) + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(167) + ALLTRIM(loc_oBO.this_cCidEmps) + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(177) + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(27) + CHR(176) + CHR(13)
                    THIS.obj_4c_OModem.Output = CHR(12)
                    SET POINT TO "."
                    SET CENTURY ON
                ENDIF

                THIS.obj_4c_OModem.PortOpen = .F.

                loc_oBO.this_lEmitidos  = .T.
                loc_oBO.this_nNEmissoes = loc_oBO.this_nNEmissoes + 1
                loc_oBO.MarcarEmitido(loc_oBO.this_cCidChaves, loc_oBO.this_cFavos, loc_oBO.this_nNEmissoes)
                THIS.opt_4c_Imprime.Buttons(2).Enabled = .T.
                THIS.opt_4c_Imprime.Buttons(3).Enabled = .T.
            ELSE
                MsgErro("Configura" + CHR(231) + CHR(227) + "o da impressora de cheque n" + ;
                        CHR(227) + "o encontrada.", "Erro")
            ENDIF
            ENDIF && IF PEMSTATUS(THIS, "obj_4c_OModem", 5)

        CATCH TO loc_oErro
            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF
            IF USED("cursor_4c_CfCom")
                USE IN cursor_4c_CfCom
            ENDIF
            SET CENTURY ON
            SET POINT TO "."
            MsgErro("Erro ao emitir cheque:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EmiteVerso - Emite verso do cheque na impressora via porta serial
    *==========================================================================
    PROCEDURE EmiteVerso()
        LOCAL loc_oBO, loc_nImpCheqs, loc_cVerso, loc_nLx, loc_cSQL, loc_oErro
        TRY
            loc_oBO       = THIS.this_oBusinessObject
            loc_nImpCheqs = 1

            IF !loc_oBO.this_lEmitidos
                MsgAviso("Primeiro deve ser impressa a frente do cheque!", ;
                         "ERRO DE CONFIGURA" + CHR(199) + CHR(195) + "O!!")
            ELSE
                IF !PEMSTATUS(THIS, "obj_4c_OModem", 5)
                    MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
                            CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
                ELSE
                loc_cSQL = "SELECT ImpCheqs FROM SigCdPam"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
                    SELECT cursor_4c_Param
                    GO TOP
                    loc_nImpCheqs = NVL(ImpCheqs, 1)
                    USE IN cursor_4c_Param
                ENDIF

                MsgInfo("Posicione o cheque na impressora para impress" + CHR(227) + "o do verso...", ;
                        "IMPRIME CHEQUE")

                loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
                           "WHERE Tipos = 'Impressora de Cheque'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
                    SELECT cursor_4c_CfCom
                    GO TOP
                    IF !EOF()
                        IF !THIS.obj_4c_OModem.portopen
                            THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
                            THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
                            THIS.obj_4c_OModem.Inputlen = 1
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_CfCom
                    THIS.obj_4c_OModem.PortOpen = .T.

                    loc_cVerso = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
                                     THIS.obj_4c_Get_Verso.Value, ;
                                     loc_oBO.this_cVersos)

                    IF loc_nImpCheqs = 2
                        SET CENTURY OFF
                        SET MEMOWIDTH TO 50
                        FOR loc_nLx = 1 TO MEMLINES(loc_cVerso)
                            THIS.obj_4c_OModem.Output = SPACE(8) + MLINE(loc_cVerso, loc_nLx) + CHR(10) + CHR(13)
                        ENDFOR
                        THIS.obj_4c_OModem.Output = CHR(12)
                        SET CENTURY ON
                        SET MEMOWIDTH TO 200
                    ELSE
                        SET CENTURY OFF
                        THIS.obj_4c_OModem.Output = CHR(27) + CHR(64) + CHR(13)
                        SET MEMOWIDTH TO 50
                        FOR loc_nLx = 1 TO MEMLINES(loc_cVerso)
                            THIS.obj_4c_OModem.Output = SPACE(5) + MLINE(loc_cVerso, loc_nLx) + CHR(13) + CHR(10)
                        ENDFOR
                        THIS.obj_4c_OModem.Output = CHR(12)
                        SET CENTURY ON
                        SET MEMOWIDTH TO 200
                    ENDIF

                    THIS.obj_4c_OModem.PortOpen = .F.

                    loc_oBO.this_nImpVersos = 1
                    loc_oBO.MarcarVersoImpresso(loc_oBO.this_cCidChaves)
                    THIS.lbl_4c_LbNimp.Visible = (loc_oBO.this_nImpVersos = 0)
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o da impressora de cheque n" + ;
                            CHR(227) + "o encontrada.", "Erro")
                ENDIF
                ENDIF && IF PEMSTATUS(THIS, "obj_4c_OModem", 5)
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF
            IF USED("cursor_4c_CfCom")
                USE IN cursor_4c_CfCom
            ENDIF
            SET CENTURY ON
            SET MEMOWIDTH TO 200
            MsgErro("Erro ao emitir verso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EmiteCopia - Gera relatorio de copia do cheque (preview ou impressao fisica)
    *==========================================================================
    PROCEDURE EmiteCopia()
        LOCAL loc_oBO, loc_cSQL, loc_cGrupoRecs, loc_cContaRecs, loc_cPagDesc
        LOCAL loc_lcChv, loc_lcFornece, loc_lcCliente, loc_lcCodSeg, loc_lcPagto
        LOCAL loc_lcEDNI, loc_lnCnt, loc_cHist, loc_cHist2, loc_oErro
        TRY
            loc_oBO        = THIS.this_oBusinessObject
            loc_cGrupoRecs = ""
            loc_cContaRecs = ""

            PUBLIC _Extenso, _Mes, _ObsPg, _Largo
            _Extenso = ""
            _Mes     = " "
            _ObsPg   = " "
            _Largo   = 2
            IF TYPE("fValorExtenso") = "FN"
                _Extenso = fValorExtenso(loc_oBO.this_nParValos)
            ENDIF
            IF TYPE("fMesExtenso") = "FN"
                _Mes = fMesExtenso(loc_oBO.this_dParVencs)
            ENDIF

            loc_cSQL = "SELECT GrupoRecs, ContaRecs FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                GO TOP
                loc_cGrupoRecs = NVL(ALLTRIM(GrupoRecs), "")
                loc_cContaRecs = NVL(ALLTRIM(ContaRecs), "")
                USE IN cursor_4c_Pam
            ENDIF

            loc_cPagDesc = ""
            IF !EMPTY(ALLTRIM(loc_oBO.this_cParFPags))
                loc_cSQL = "SELECT Descrs FROM SigOpFpp " + ;
                           "WHERE FPags = " + EscaparSQL(loc_oBO.this_cParFPags) + ;
                           " AND ImpCpChqs = 2"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPag") > 0
                    SELECT cursor_4c_FPag
                    GO TOP
                    IF !EOF()
                        loc_cPagDesc = NVL(ALLTRIM(Descrs), "")
                    ENDIF
                    USE IN cursor_4c_FPag
                ENDIF
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpConta2 (Titulo C(10) NULL, Vencimento D(8) NULL, ;
                Fornecedor C(10) NULL, DescriForn C(50) NULL, Despesa C(10) NULL, ;
                DescriDesp C(50) NULL, Valor N(12,2) NULL, Moeda C(3) NULL, ;
                Hists C(40) NULL, Hist2s C(40) NULL, Imprime L(1) NULL, ;
                Emps C(3) NULL, Pagamento C(6) NULL, Fim L(1) NULL, ;
                bGrupos C(10) NULL, Numcs N(6,0) NULL, Tipos C(1) NULL, ;
                Ordem C(1) NULL, Opers C(1) NULL, Vencs D(8) NULL, ;
                nbgrupos C(30) NULL, CodSegs C(10) NULL, ;
                OrdCopChs N(3,0) NULL, ChDescrs C(30) NULL)
            SET NULL OFF

            loc_cSQL = "SELECT '1' AS Ordem, Opers, Titulos, Vencs, Contems, Grupos, " + ;
                       "Contas, Valors, Moedas, Hists, Hist2s, Emps, bgrupos, Numcs, " + ;
                       "Tipos, OrdCopChs " + ;
                       "FROM SigMvCcr " + ;
                       "WHERE EmpDopncs = " + EscaparSQL(loc_oBO.this_cEmpDopNums) + ;
                       " AND NOT Tipos = 'O' " + ;
                       "UNION ALL " + ;
                       "SELECT '2' AS Ordem, Opers, Titulos, Vencs, Contems, Grupos, " + ;
                       "Contas, (Valors + Valocurs) * -1 AS Valors, Moedas, Hists, Hist2s, " + ;
                       "Emps, bgrupos, Numcs, Tipos, OrdCopChs " + ;
                       "FROM SigMvCcr " + ;
                       "WHERE EmpDopncs = " + EscaparSQL(loc_oBO.this_cEmpDopNums) + ;
                       " AND Tipos = 'O' AND Grupos <> " + EscaparSQL(loc_cGrupoRecs) + ;
                       " ORDER BY 1, 2, 3, 4, 5, 6, 7"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mvs") < 1
                IF USED("TmpConta2")
                    USE IN TmpConta2
                ENDIF
                MsgErro("Falha ao carregar movimentos para impress" + CHR(227) + "o de c" + ;
                        CHR(243) + "pia.", "Erro")
            ELSE
                SELECT cursor_4c_Mvs
                GO TOP
                loc_lcChv = ""
                loc_lnCnt = 0

                DO WHILE !EOF("cursor_4c_Mvs")
                    SELECT cursor_4c_Mvs
                    loc_cHist  = STRTRAN(STRTRAN(cursor_4c_Mvs.Hists,  CHR(13), " "), CHR(10), " ")
                    loc_cHist2 = STRTRAN(STRTRAN(cursor_4c_Mvs.Hist2s, CHR(13), " "), CHR(10), " ")

                    IF cursor_4c_Mvs.Grupos <> loc_cGrupoRecs AND ;
                       cursor_4c_Mvs.Contas <> loc_cContaRecs

                        loc_lcFornece = ""
                        loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                                   "WHERE Iclis = " + EscaparSQL(cursor_4c_Mvs.Contems)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliF") > 0
                            SELECT cursor_4c_CliF
                            GO TOP
                            IF !EOF()
                                loc_lcFornece = NVL(ALLTRIM(Rclis), "")
                            ENDIF
                            USE IN cursor_4c_CliF
                        ENDIF

                        loc_lcCliente = ""
                        loc_lcCodSeg  = ""
                        loc_cSQL = "SELECT Rclis, CodSegs FROM SigCdCli " + ;
                                   "WHERE Iclis = " + EscaparSQL(cursor_4c_Mvs.Contas)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliC") > 0
                            SELECT cursor_4c_CliC
                            GO TOP
                            IF !EOF()
                                loc_lcCliente = NVL(ALLTRIM(Rclis), "")
                                loc_lcCodSeg  = NVL(ALLTRIM(CodSegs), "")
                            ENDIF
                            USE IN cursor_4c_CliC
                        ENDIF

                        loc_lcPagto = ""
                        loc_lcEDNI  = loc_oBO.this_cEmps + loc_oBO.this_cDopes + ;
                                      STR(loc_oBO.this_nNumes, 6)
                        loc_cSQL = "SELECT EmpDopNums FROM SigCdPgr " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_lcEDNI)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pgr") > 0
                            SELECT cursor_4c_Pgr
                            GO TOP
                            IF !EOF()
                                loc_lcPagto = STR(loc_oBO.this_nNumes, 6)
                            ENDIF
                            USE IN cursor_4c_Pgr
                        ENDIF

                        SELECT cursor_4c_Mvs

                        IF cursor_4c_Mvs.Opers = "C"
                            INSERT INTO TmpConta2 (Titulo, Vencimento, Fornecedor, DescriForn, ;
                                Despesa, DescriDesp, Valor, Moeda, Imprime, Emps, ;
                                Hists, Hist2s, Pagamento, bGrupos, Numcs, Tipos, ;
                                Ordem, Opers, Vencs, CodSegs, OrdCopChs, ChDescrs) ;
                            VALUES (cursor_4c_Mvs.Titulos, NVL(cursor_4c_Mvs.Vencs, {}), ;
                                cursor_4c_Mvs.Contems, loc_lcFornece, ;
                                cursor_4c_Mvs.Contas, loc_lcCliente, ;
                                cursor_4c_Mvs.Valors, cursor_4c_Mvs.Moedas, ;
                                IIF(loc_lcChv <> cursor_4c_Mvs.Titulos + ;
                                    DTOC(cursor_4c_Mvs.Vencs) + cursor_4c_Mvs.Contems, .T., .F.), ;
                                cursor_4c_Mvs.Emps, loc_cHist, loc_cHist2, ;
                                loc_lcPagto, cursor_4c_Mvs.bGrupos, cursor_4c_Mvs.Numcs, ;
                                cursor_4c_Mvs.Tipos, cursor_4c_Mvs.Ordem, cursor_4c_Mvs.Opers, ;
                                cursor_4c_Mvs.Vencs, loc_lcCodSeg, ;
                                NVL(cursor_4c_Mvs.OrdCopChs, 0), loc_cPagDesc)
                        ELSE
                            IF loc_lnCnt = 0 AND cursor_4c_Mvs.Tipos <> "O"
                                SELECT TmpConta2
                                GO BOTTOM
                                REPLACE Despesa    WITH cursor_4c_Mvs.Contas, ;
                                        DescriDesp WITH loc_lcCliente, ;
                                        Hists      WITH loc_cHist, ;
                                        Hist2s     WITH loc_cHist2, ;
                                        Valor      WITH cursor_4c_Mvs.Valors, ;
                                        ChDescrs   WITH loc_cPagDesc
                            ELSE
                                INSERT INTO TmpConta2 (Titulo, Vencimento, Despesa, DescriDesp, ;
                                    Valor, Moeda, Hists, Hist2s, Imprime, Emps, ;
                                    Pagamento, bGrupos, Numcs, Tipos, Ordem, Opers, ;
                                    Vencs, OrdCopChs, ChDescrs) ;
                                VALUES (cursor_4c_Mvs.Titulos, cursor_4c_Mvs.Vencs, ;
                                    cursor_4c_Mvs.Contas, loc_lcCliente, ;
                                    ABS(cursor_4c_Mvs.Valors), cursor_4c_Mvs.Moedas, ;
                                    loc_cHist, loc_cHist2, .F., cursor_4c_Mvs.Emps, ;
                                    loc_lcPagto, cursor_4c_Mvs.bGrupos, cursor_4c_Mvs.Numcs, ;
                                    cursor_4c_Mvs.Tipos, cursor_4c_Mvs.Ordem, cursor_4c_Mvs.Opers, ;
                                    cursor_4c_Mvs.Vencs, NVL(cursor_4c_Mvs.OrdCopChs, 0), loc_cPagDesc)
                            ENDIF
                            loc_lnCnt = loc_lnCnt + 1
                        ENDIF
                        loc_lcChv = cursor_4c_Mvs.Titulos + DTOC(cursor_4c_Mvs.Vencs) + ;
                                    cursor_4c_Mvs.Contems
                    ENDIF

                    SELECT cursor_4c_Mvs
                    SKIP
                ENDDO

                USE IN cursor_4c_Mvs

                SELECT TmpConta2
                GO BOTTOM
                REPLACE Fim WITH .T.
                INDEX ON STR(NVL(OrdCopChs, 0), 3) + Titulo + ;
                         DTOS(NVL(Vencimento, {})) + Ordem + Opers TAG Impressao
                GO TOP

                IF THIS.enviaimp
                    REPORT FORM (gc_4c_CaminhoReports + "SigOpCq2") TO PRINT PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigOpCq2") PREVIEW NOCONSOLE
                ENDIF

                IF USED("TmpConta2")
                    USE IN TmpConta2
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            IF USED("cursor_4c_FPag")
                USE IN cursor_4c_FPag
            ENDIF
            IF USED("cursor_4c_Mvs")
                USE IN cursor_4c_Mvs
            ENDIF
            IF USED("cursor_4c_CliF")
                USE IN cursor_4c_CliF
            ENDIF
            IF USED("cursor_4c_CliC")
                USE IN cursor_4c_CliC
            ENDIF
            IF USED("cursor_4c_Pgr")
                USE IN cursor_4c_Pgr
            ENDIF
            IF USED("TmpConta2")
                USE IN TmpConta2
            ENDIF
            MsgErro("Erro ao imprimir c" + CHR(243) + "pia:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula controles visuais com dados do BO
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                IF VARTYPE(THIS.cnt_4c_Cheque) = "O"
                    WITH THIS.cnt_4c_Cheque
                        IF VARTYPE(.txt_4c_Bco) = "O"
                            .txt_4c_Bco.Value = loc_oBO.this_cParBancos
                        ENDIF
                        IF VARTYPE(.txt_4c_Age) = "O"
                            .txt_4c_Age.Value = loc_oBO.this_cParAgencias
                        ENDIF
                        IF VARTYPE(.txt_4c_Conta) = "O"
                            .txt_4c_Conta.Value = loc_oBO.this_cParContas
                        ENDIF
                        IF VARTYPE(.txt_4c_Num) = "O"
                            .txt_4c_Num.Value = loc_oBO.this_cParNumeros
                        ENDIF
                        IF VARTYPE(.txt_4c_Valor) = "O"
                            .txt_4c_Valor.Value = loc_oBO.this_nParValos
                        ENDIF
                        IF VARTYPE(.txt_4c_Vencimento) = "O"
                            .txt_4c_Vencimento.Value = loc_oBO.this_dParVencs
                        ENDIF
                        .Visible     = .T.
                    ENDWITH
                ENDIF
                IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
                    THIS.txt_4c_Favorecido.Value = loc_oBO.this_cFavos
                ENDIF
                IF VARTYPE(THIS.txt_4c_Copia) = "O"
                    THIS.txt_4c_Copia.Value = TRANSFORM(loc_oBO.this_nNCopias)
                ENDIF
                IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
                    THIS.obj_4c_Get_Verso.Value = loc_oBO.this_cVersos
                    THIS.peantvalue = loc_oBO.this_cVersos
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VersoLostFocus - Salva verso se o conteudo foi alterado
    *==========================================================================
    PROCEDURE VersoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.obj_4c_Get_Verso) = "O"
                loc_cVersoAtual = THIS.obj_4c_Get_Verso.Value
                IF !(ALLTRIM(loc_cVersoAtual) == ALLTRIM(THIS.peantvalue))
                    loc_oBO.AtualizarVerso(loc_oBO.this_cCidChaves, loc_cVersoAtual)
                    THIS.peantvalue = loc_cVersoAtual
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FavorecidoLostFocus - Sincroniza BO com valor editado do campo favorecido
    *==========================================================================
    PROCEDURE FavorecidoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.txt_4c_Favorecido) = "O"
                loc_oBO.this_cFavos = ALLTRIM(THIS.txt_4c_Favorecido.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com dados editaveis do formulario
    * Campos editaveis: favorecido e verso (restantes sao somente leitura)
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
                    loc_oBO.this_cFavos = ALLTRIM(THIS.txt_4c_Favorecido.Value)
                ENDIF
                IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
                    loc_oBO.this_cVersos = THIS.obj_4c_Get_Verso.Value
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla editabilidade dos campos conforme modo
    * par_cModo: "INSERIR", "ALTERAR" (editavel) ou outro (somente leitura)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_lEditavel, loc_lVersoEditavel, loc_oBO, loc_oErro
        TRY
            loc_oBO       = THIS.this_oBusinessObject
            loc_lEditavel = INLIST(par_cModo, "INSERIR", "ALTERAR")

            IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
                THIS.txt_4c_Favorecido.ReadOnly  = !loc_lEditavel
                THIS.txt_4c_Favorecido.BackColor = IIF(loc_lEditavel, RGB(255,255,255), RGB(240,240,240))
            ENDIF

            IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
                loc_lVersoEditavel = loc_lEditavel AND ;
                                     VARTYPE(loc_oBO) = "O" AND ;
                                     loc_oBO.this_nImpVersos = 0
                THIS.obj_4c_Get_Verso.ReadOnly  = !loc_lVersoEditavel
                THIS.obj_4c_Get_Verso.BackColor = IIF(loc_lVersoEditavel, RGB(255,255,255), RGB(240,240,240))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta campos editaveis e estado de comparacao do verso
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
            THIS.txt_4c_Favorecido.Value = ""
        ENDIF
        IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
            THIS.obj_4c_Get_Verso.Value = ""
        ENDIF
        THIS.peantvalue = ""
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega dados do cheque do banco de dados e atualiza UI
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro
        TRY
            THIS.CarregarDadosCheque()
            THIS.BOParaForm()
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Centraliza ajuste de estado dos botoes e controles
    * Baseado em: lEmitidos, nImpVersos e op_escolha atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                IF VARTYPE(THIS.opt_4c_Imprime) = "O"
                    THIS.opt_4c_Imprime.Buttons(2).Enabled = loc_oBO.this_lEmitidos
                    THIS.opt_4c_Imprime.Buttons(3).Enabled = loc_oBO.this_lEmitidos
                ENDIF
                IF VARTYPE(THIS.cmd_4c_Visualizar) = "O"
                    THIS.cmd_4c_Visualizar.Enabled = VARTYPE(THIS.opt_4c_Imprime) = "O" AND ;
                                                     INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
                ENDIF
                IF VARTYPE(THIS.lbl_4c_LbNimp) = "O"
                    THIS.lbl_4c_LbNimp.Visible = (loc_oBO.this_nImpVersos = 0)
                ENDIF
                THIS.HabilitarCampos(THIS.op_escolha)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega dados do cheque a partir do banco
    * Util para refletir mudancas externas no registro (ex: marca de emissao
    * alterada em outra sessao) sem precisar fechar e reabrir o form.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.CarregarLista()
            THIS.InicializarEstadoBotoes()
            MsgInfo("Dados do cheque atualizados.", "Buscar")
        CATCH TO loc_oErro
            MsgErro("Erro ao recarregar dados:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Grava favorecido e verso no banco (SigCqChi)
    * Sincroniza form->BO e executa UPDATE via SalvarStatusSaida + AtualizarVerso.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                IF !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
                    MsgAviso("Cheque em modo somente leitura. " + ;
                             "Acione Alterar antes de salvar.", "Aviso")
                ELSE
                    *-- Form -> BO (favorecido e verso)
                    THIS.FormParaBO()

                    *-- Persiste favorecido + status atual
                    loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
                                              loc_oBO.this_cFavos, ;
                                              loc_oBO.this_nNEmissoes)

                    *-- Persiste verso somente se houve mudanca real
                    loc_cVersoAtual = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
                                          THIS.obj_4c_Get_Verso.Value, ;
                                          loc_oBO.this_cVersos)
                    IF !(ALLTRIM(loc_cVersoAtual) == ALLTRIM(THIS.peantvalue))
                        loc_oBO.AtualizarVerso(loc_oBO.this_cCidChaves, loc_cVersoAtual)
                        THIS.peantvalue = loc_cVersoAtual
                    ENDIF

                    MsgInfo("Altera" + CHR(231) + CHR(245) + "es salvas com sucesso.", "Salvo")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar altera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Reverte favorecido e verso para o ultimo estado gravado
    * Recarrega dados do banco sem fechar o form; exige confirmacao do usuario.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oBO, loc_lConfirma, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                loc_lConfirma = MsgConfirma("Descartar altera" + CHR(231) + CHR(245) + ;
                                            "es n" + CHR(227) + "o salvas e recarregar dados?")
                IF loc_lConfirma
                    *-- Recarrega do banco e reflete no form, mantendo o modo atual
                    THIS.CarregarDadosCheque()
                    THIS.BOParaForm()
                    THIS.AjustarBotoesPorModo()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao cancelar altera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores temporarios e chama DODEFAULT
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_ChiDados")
            USE IN cursor_4c_ChiDados
        ENDIF
        IF USED("cursor_4c_Par")
            USE IN cursor_4c_Par
        ENDIF
        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReEchBO.prg):
*------------------------------------------------------------------------------
* SigReEchBO.prg - Business Object para Emissao de Cheque
* Tabela principal: SIGCQCHI
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS SigReEchBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela      = "SigCqChi"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    *-- Propriedades de SIGCQCHI (cheque)
    *--------------------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves  char(20) - chave primaria
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave composta emps+dopes+numes
    this_cEmps        = ""    && emps       char(3)  - empresa
    this_cDopes       = ""    && dopes      char(20) - documento operacao
    this_nNumes       = 0     && numes      numeric(6,0)
    this_cBancos      = ""    && bancos     char(3)
    this_cAgencias    = ""    && agencias   char(4)
    this_cContas      = ""    && contas     char(10)
    this_cNContas     = ""    && ncontas    char(10) - numero da conta
    this_cNCheques    = ""    && ncheques   char(6)  - numero do cheque
    this_cFavos       = ""    && favos      char(40) - favorecido
    this_nValors      = 0     && valors     numeric(11,2)
    this_dVencs       = {}    && vencs      datetime - vencimento
    this_cVersos      = ""    && versos     text     - verso do cheque
    this_lEmitidos    = .F.   && emitidos   bit      - se ja foi emitido
    this_nNEmissoes   = 0     && nemissoes  numeric(2,0) - numero de emissoes
    this_nNCopias     = 0     && ncopias    numeric(6,0) - numero de copias
    this_nImpVersos   = 0     && impversos  numeric(1,0) - se verso foi impresso
    this_lCancelas    = .F.   && cancelas   bit      - se cancelado
    this_cGrupos      = ""    && grupos     char(10)
    this_dDatas       = {}    && datas      datetime
    this_cJustCanc    = ""    && justcanc   text     - justificativa cancelamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigMvPar (parcela vinculada ao cheque - cursor CrPar)
    *--------------------------------------------------------------------------
    this_cParBancos   = ""    && bancos    char(3)
    this_cParAgencias = ""    && agencias  char(4)
    this_cParContas   = ""    && contas    char(10)
    this_cParNumeros  = ""    && numeros   char(6)
    this_nParValos    = 0     && valos     numeric(11,2) - valor da parcela
    this_dParVencs    = {}    && vencs     datetime      - vencimento da parcela
    this_cParFPags    = ""    && fpags     char(12)      - forma de pagamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigCdEmp (empresa - cursor CrSigCdEmp)
    *--------------------------------------------------------------------------
    this_cCidEmps     = ""    && cidas char(30) - cidade da empresa

    *--------------------------------------------------------------------------
    *-- Parametros e estado de execucao do formulario
    *--------------------------------------------------------------------------
    this_cOpEscolha    = ""   && INSERIR, ALTERAR - modo do form ao abrir
    this_cNchequeParam = ""   && _ncheque filtro inicial (opcional)
    this_lEnviaImp     = .F.  && .T.=imprimir fisicamente, .F.=preview em video
    this_cPeAntValue   = ""   && valor anterior do campo verso (para detectar mudanca)

    *--------------------------------------------------------------------------
    PROCEDURE Init
        THIS.this_cTabela     = "SigCqChi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigCqChi para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
            THIS.this_cEmpDopNums = NVL(ALLTRIM(empdopnums), "")
            THIS.this_cEmps       = NVL(ALLTRIM(emps), "")
            THIS.this_cDopes      = NVL(ALLTRIM(dopes), "")
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_cBancos     = NVL(ALLTRIM(bancos), "")
            THIS.this_cAgencias   = NVL(ALLTRIM(agencias), "")
            THIS.this_cContas     = NVL(ALLTRIM(contas), "")
            THIS.this_cNContas    = NVL(ALLTRIM(ncontas), "")
            THIS.this_cNCheques   = NVL(ALLTRIM(ncheques), "")
            THIS.this_cFavos      = NVL(ALLTRIM(favos), "")
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = NVL(vencs, {})
            THIS.this_cVersos     = NVL(versos, "")
            IF VARTYPE(emitidos) = "L"
                THIS.this_lEmitidos = emitidos
            ELSE
                THIS.this_lEmitidos = IIF(NVL(emitidos, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_nNEmissoes  = NVL(nemissoes, 0)
            THIS.this_nNCopias    = NVL(ncopias, 0)
            THIS.this_nImpVersos  = NVL(impversos, 0)
            IF VARTYPE(cancelas) = "L"
                THIS.this_lCancelas = cancelas
            ELSE
                THIS.this_lCancelas = IIF(NVL(cancelas, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_cGrupos     = NVL(ALLTRIM(grupos), "")
            THIS.this_dDatas      = NVL(datas, {})
            THIS.this_cJustCanc   = NVL(justcanc, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega cheque de SigCqChi por emps+dopes+numes
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_cEmps, par_cDopes, par_nNumes, par_cNcheque)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEDN, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cEDN = par_cEmps + PADR(par_cDopes, 20) + STR(par_nNumes, 6)
            loc_cSQL = "SELECT agencias, bancos, cancelas, contas, datas, " + ;
                       "dopes, emitidos, emps, favos, grupos, ncheques, " + ;
                       "ncontas, ncopias, nemissoes, numes, valors, vencs, " + ;
                       "versos, cidchaves, empdopnums, justcanc, impversos " + ;
                       "FROM SigCqChi " + ;
                       "WHERE empdopnums = " + EscaparSQL(loc_cEDN)
            IF !EMPTY(ALLTRIM(par_cNcheque))
                loc_cSQL = loc_cSQL + " AND ncheques = " + EscaparSQL(par_cNcheque)
            ENDIF

            IF USED("cursor_4c_ChiDados")
                TABLEREVERT(.T., "cursor_4c_ChiDados")
                USE IN cursor_4c_ChiDados
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChiDados") > 0
                SELECT cursor_4c_ChiDados
                GO TOP
                IF !EOF()
                    THIS.CarregarDoCursor("cursor_4c_ChiDados")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParcela - Carrega parcela vinculada ao cheque (SigMvPar)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParcela(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT bancos, agencias, contas, numeros, valos, vencs, fpags " + ;
                       "FROM SigMvPar " + ;
                       "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)

            IF USED("cursor_4c_Par")
                TABLEREVERT(.T., "cursor_4c_Par")
                USE IN cursor_4c_Par
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Par") > 0
                SELECT cursor_4c_Par
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Par
                    THIS.this_cParBancos   = NVL(ALLTRIM(bancos), "")
                    THIS.this_cParAgencias = NVL(ALLTRIM(agencias), "")
                    THIS.this_cParContas   = NVL(ALLTRIM(contas), "")
                    THIS.this_cParNumeros  = NVL(ALLTRIM(numeros), "")
                    THIS.this_nParValos    = NVL(valos, 0)
                    THIS.this_dParVencs    = NVL(vencs, {})
                    THIS.this_cParFPags    = NVL(ALLTRIM(fpags), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega dados da empresa (SigCdEmp)
    *--------------------------------------------------------------------------
    FUNCTION CarregarEmpresa(par_cEmps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cemps, cidas FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(par_cEmps)

            IF USED("cursor_4c_Emp")
                TABLEREVERT(.T., "cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Emp
                    THIS.this_cCidEmps = NVL(ALLTRIM(cidas), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves  = LEFT(THIS.this_cEmps + SYS(2015) + PADR(SYS(1), 7, "0"), 20)
            THIS.this_cEmpDopNums = THIS.this_cEmps + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigCqChi " + ;
                       "(cidchaves, empdopnums, emps, dopes, numes, " + ;
                       "agencias, bancos, contas, ncontas, ncheques, " + ;
                       "favos, valors, vencs, versos, emitidos, " + ;
                       "nemissoes, ncopias, impversos, cancelas, " + ;
                       "grupos, datas, justcanc) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       EscaparSQL(THIS.this_cVersos) + ", " + ;
                       IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(THIS.this_cJustCanc) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi SET " + ;
                       "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       "numes = " + FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       "agencias = " + EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       "bancos = " + EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       "contas = " + EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       "ncontas = " + EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       "ncheques = " + EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       "favos = " + EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       "valors = " + FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       "vencs = " + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       "versos = " + EscaparSQL(THIS.this_cVersos) + ", " + ;
                       "emitidos = " + IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       "ncopias = " + FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       "impversos = " + FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       "cancelas = " + IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       "grupos = " + EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       "datas = " + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "justcanc = " + EscaparSQL(THIS.this_cJustCanc) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarEmitido - Marca cheque como emitido e incrementa emissoes
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmitido(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 1, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarVersoImpresso - Marca verso do cheque como impresso (impversos=1)
    *--------------------------------------------------------------------------
    FUNCTION MarcarVersoImpresso(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET impversos = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarVerso - Atualiza texto do verso do cheque
    *--------------------------------------------------------------------------
    FUNCTION AtualizarVerso(par_cCidChaves, par_cVerso)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET versos = " + EscaparSQL(par_cVerso) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarStatusSaida - Salva status ao sair sem emitir (emitidos=0)
    *--------------------------------------------------------------------------
    FUNCTION SalvarStatusSaida(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 0, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


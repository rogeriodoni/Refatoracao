# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 4/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-27 09:48:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-27 09:48:38] [INFO] Config FPW: (nao fornecido)
[2026-09-27 09:48:38] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 09:48:38] [INFO] Timeout: 300 segundos
[2026-09-27 09:48:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l0jxdtfi.prg
[2026-09-27 09:48:38] [INFO] Conteudo do wrapper:
[2026-09-27 09:48:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprcpd', 'C:\4c\tasks\task595\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprcpd', 'C:\4c\tasks\task595\logs\06_testForm.log'
QUIT

[2026-09-27 09:48:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l0jxdtfi.prg
[2026-09-27 09:48:38] [INFO] VFP output esperado em: C:\4c\tasks\task595\vfp_output.txt
[2026-09-27 09:48:38] [INFO] Executando Visual FoxPro 9...
[2026-09-27 09:48:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l0jxdtfi.prg
[2026-09-27 09:48:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l0jxdtfi.prg
[2026-09-27 09:48:38] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprcpd
Inicio: 27/09/2026 09:48:39

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 27/09/2026 09:52:14
Duracao: 215 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-27 09:52:14] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-27 09:52:14] [INFO] VFP9 finalizado em 216.0074684 segundos
[2026-09-27 09:52:14] [INFO] Exit Code: 
[2026-09-27 09:52:14] [INFO] 
[2026-09-27 09:52:14] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-27 09:52:14] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l0jxdtfi.prg
[2026-09-27 09:52:14] [INFO] 
[2026-09-27 09:52:14] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-27 09:52:14] [INFO] * Auto-generated wrapper for parameters
[2026-09-27 09:52:14] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 09:52:14] [INFO] * Parameters: 'Formsigprcpd', 'C:\4c\tasks\task595\logs\06_testForm.log'
[2026-09-27 09:52:14] [INFO] 
[2026-09-27 09:52:15] [INFO] * Anti-dialog protections for unattended execution
[2026-09-27 09:52:15] [INFO] SET SAFETY OFF
[2026-09-27 09:52:15] [INFO] SET RESOURCE OFF
[2026-09-27 09:52:15] [INFO] SET TALK OFF
[2026-09-27 09:52:15] [INFO] SET NOTIFY OFF
[2026-09-27 09:52:15] [INFO] SYS(2335, 0)
[2026-09-27 09:52:15] [INFO] 
[2026-09-27 09:52:15] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprcpd', 'C:\4c\tasks\task595\logs\06_testForm.log'
[2026-09-27 09:52:15] [INFO] QUIT
[2026-09-27 09:52:15] [INFO] 
[2026-09-27 09:52:15] [INFO] === Fim do Wrapper.prg ===
[2026-09-27 09:52:15] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg):
*==============================================================================
* Formsigprcpd.prg - Form OPERACIONAL: Capacidade Produtiva
* Equivale a: SIGPRCPD.SCX (tasks\task595)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - form utilitario, aberto com parametros
*   (Fase/Setor, Unidade Produtiva, Data, Codigo do Envelope/OP) que exibe a
*   capacidade produtiva (minutos/utilizados/saldo) e a grade de operacoes
*   rateadas do envelope informado.
*
* EVENTOS - DISPOSICAO DOS 14 METODOS DO SCX LEGADO
* -------------------------------------------------
* O dump (sigprcpd_form_codigo_fonte.txt, "Total de metodos/eventos com
* codigo: 14") tem Init, Load, Release, 9x When, AfterRowColChange e Click.
* Doze viraram codigo aqui; o outro eh nao-port deliberado, registrado abaixo
* para que a ausencia seja auditavel em vez de parecer esquecimento:
*
*   Legado                   Migrado
*   -----------------------  -------------------------------------------------
*   Init                     Init (mesmos 4 parametros posicionais)
*                            + InicializarForm + CarregarLista
*   Release (poDataMgr)      Destroy - ver (b)
*   9x When (Return .f.)     .ReadOnly = .T. nos 9 TextBox de display
*   Grade.AfterRowColChange  GradeAfterRowColChange (via BINDEVENT)
*   Sair.Click               BtnSairClick (via BINDEVENT)
*   Load  (=fConfigGeral())  NAO PORTADO - ver (a)
*
* (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da aplicacao
*     legado (sig.prg / SIGFUNCS.PRG) que NAO veio no acervo. O que existe em
*     projeto\app\utils\fconfiggeral.prg e' um wrapper NO-OP (RETURN .T.) cujo
*     proprio cabecalho diz: "em codigo NOSSO nunca se chama fConfigGeral -
*     este arquivo existe APENAS para binario legado", porque o p-code dos VCX
*     o invoca e nao da para editar. Chama-lo daqui seria escrever uma chamada
*     que comprovadamente nao faz nada e ainda sugerir que falta alguma
*     inicializacao global. O que fConfigGeral fazia esta distribuido e ocorre
*     ANTES deste form abrir: config.prg (SETs, paths, aliases globais),
*     main.prg (conexao, CarregarEmpresa) e o sigprcpdBO (seus cursores).
*     Mesma decisao ja registrada em FormSigMvExp.prg.
*
* (b) Release: "ThisForm.poDataMgr.Release" + "Dodefault()". poDataMgr era o
*     fSqlConector PRIVADO deste form, criado no Init legado
*     ("CreateObject('fSqlConector', ThisForm.Name)"); o Release existia so
*     para devolver essa conexao. A arquitetura nova nao tem conexao por form:
*     usa o handle GLOBAL gnConnHandle, que NAO pode ser liberado ao fechar
*     uma tela (derrubaria a aplicacao inteira). O Destroy daqui faz o
*     equivalente util - fecha os cursores desta consulta - e chama
*     DODEFAULT() para FormBase reconstruir os popups do menu.
*
* SEM BOTAO CRUD: o legado tem UM UNICO CommandButton (Sair, fwbtng,
* "Encerrar", Click = ThisForm.Release) e herda de `form` puro, NAO de
* frmcadastro - o dump nao tem Grupo_Op, nao tem pcEscolha e nao tem nenhum
* dos quatro verbos da barra CRUD do framework. Por isso este form nao tem os
* quatro handlers dessa barra: criar os quatro exigiria INVENTAR botoes que o
* legado nao tem (viola o PILAR 1) ou deixar metodos vazios (proibido pela
* regra de completude). Os eventos de botao que o legado REALMENTE tem estao
* implementados - o de saida e o da grade, na tabela acima.
*==============================================================================
DEFINE CLASS Formsigprcpd AS FormBase

    DataSession  = 2
    ShowWindow = 1
    Width        = 800
    Height       = 600
    Caption      = ""
    BorderStyle  = 2
    AutoCenter   = .T.
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    ShowWindow   = 0
    WindowType   = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos do chamador (equivalentes ao
    *-- LParameters pFase, pUnidade, pData, pCodigo do Init legado)
    this_cFasePar    = ""
    this_cUnidadePar = ""
    this_dDataPar    = {}
    this_nCodigoPar  = 0

    *--------------------------------------------------------------------------
    * Init - recebe os parametros do legado e define o Caption antes de
    * delegar a inicializacao padrao (FormBase.Init -> InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cFase, par_cUnidade, par_dData, par_nCodigo)
        THIS.Caption = "Capacidade Produtiva"

        IF VARTYPE(par_cFase) = "C"
            THIS.this_cFasePar = par_cFase
        ENDIF
        IF VARTYPE(par_cUnidade) = "C"
            THIS.this_cUnidadePar = par_cUnidade
        ENDIF
        IF VARTYPE(par_dData) = "D" OR VARTYPE(par_dData) = "T"
            THIS.this_dDataPar = par_dData
        ENDIF
        IF VARTYPE(par_nCodigo) = "N"
            THIS.this_nCodigoPar = par_nCodigo
        ENDIF

        *-- ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9 -T
        *-- (top-level window bloqueante). Producao restaura o modal aqui.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura base do
    * form. Chamado automaticamente por FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste

        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprcpdBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigprcpdBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
            ELSE
                *-- Estrutura (controles/grid/botoes) eh SEMPRE montada, com ou
                *-- sem conexao SQL - so o metodo que depende de SQL
                *-- (CarregarLista) eh pulado em modo teste/validacao. Mesmo
                *-- padrao dos forms CRUD (FORMCOR_LICOES_APRENDIDAS.md,
                *-- Problema 4): sem isto, ValidarUIFidelity e qualquer probe
                *-- headless veem o form "vazio" (nenhum controle no PEM),
                *-- mesmo o form tendo instanciado com sucesso.
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.ConfigurarPageFrame()
                THIS.TornarControlesVisiveis(THIS)

                IF loc_lModoValidacaoOuTeste
                    *-- Sem conexao SQL disponivel: estrutura montada, grade
                    *-- nao carregada, para nao travar em modal de erro.
                    loc_lSucesso = .T.
                ELSE
                    *-- Popula a grade com os parametros recebidos no Init
                    *-- (equivalente ao corpo do PROCEDURE Init do legado, que
                    *-- so mostra a tela depois de carregar os dados)
                    IF THIS.CarregarLista()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de layout base
    * SIGPRCPD original eh flat OPERACIONAL (sem PageFrame nativo): o
    * legado nao tem Page1/Page2 nem botoes CRUD (Incluir/Alterar/Excluir/
    * Buscar) - so a Grade de operacoes e o botao Sair/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainer1()
        THIS.ConfigurarContainer2()
        THIS.ConfigurarGrid()
        THIS.ConfigurarDetalheProduto()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer1 - Container1 do legado: exibe a Fase/Setor e a
    * Data recebidos como parametro (txt_4c_Fase/txt_4c__Data). Ambos os
    * TextBoxes tem PROCEDURE When retornando .F. no legado (registro 13 e
    * 15 do dump) - nunca recebem foco, sao apenas display - por isso
    * ReadOnly = .T. aqui reproduz o comportamento, nao o inventa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer1()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1
        WITH loc_oCnt
            .Top           = 104
            .Left          = 8
            .Width         = 278
            .Height        = 36
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Fase :"
            .Height    = 17
            .Left      = 2
            .Top       = 8
            .Width     = 40
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fase", "TextBox")
        WITH loc_oCnt.txt_4c_Fase
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 23
            .Left      = 44
            .Top       = 5
            .Width     = 100
            .BackColor = RGB(255, 198, 140)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Data :"
            .Height    = 17
            .Left      = 147
            .Top       = 9
            .Width     = 40
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c__Data", "TextBox")
        WITH loc_oCnt.txt_4c__Data
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 23
            .Left      = 189
            .Top       = 5
            .Width     = 72
            .BackColor = RGB(255, 198, 140)
            .Value     = {}
            .ReadOnly  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer2 - Container2 do legado: exibe a capacidade
    * agregada (Capacidade/Utilizado/Saldo, em minutos) calculada por
    * sigprcpdBO.CarregarDados(). Os tres TextBoxes tambem tem PROCEDURE
    * When retornando .F. (registros 35/37/39) - display-only, ReadOnly.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer2()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Container2", "Container")
        loc_oCnt = THIS.cnt_4c_Container2
        WITH loc_oCnt
            .Top           = 104
            .Left          = 288
            .Width         = 504
            .Height        = 36
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Capacidade:"
            .Height    = 15
            .Left      = 9
            .Top       = 10
            .Width     = 70
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cap", "TextBox")
        WITH loc_oCnt.txt_4c_Cap
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Height     = 23
            .InputMask  = "99999"
            .Left       = 81
            .Top        = 5
            .Width      = 63
            .BackColor  = RGB(255, 216, 176)
            .Value      = 0
            .ReadOnly   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Utilizado:"
            .Height    = 15
            .Left      = 194
            .Top       = 10
            .Width     = 54
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Utz", "TextBox")
        WITH loc_oCnt.txt_4c_Utz
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Height     = 23
            .InputMask  = "99999"
            .Left       = 250
            .Top        = 5
            .Width      = 63
            .BackColor  = RGB(255, 216, 176)
            .Value      = 0
            .ReadOnly   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Saldo : "
            .Height    = 15
            .Left      = 366
            .Top       = 10
            .Width     = 42
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c__Sld", "TextBox")
        WITH loc_oCnt.txt_4c__Sld
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Height     = 23
            .InputMask  = "99999"
            .Left       = 410
            .Top        = 5
            .Width      = 63
            .BackColor  = RGB(255, 216, 176)
            .Value      = 0
            .ReadOnly   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Min"
            .Height    = 15
            .Left      = 147
            .Top       = 10
            .Width     = 22
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Min"
            .Height    = 15
            .Left      = 316
            .Top       = 9
            .Width     = 22
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Min"
            .Height    = 15
            .Left      = 476
            .Top       = 9
            .Width     = 22
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Cria a Grade (grd_4c_Dados) com as 8 colunas do
    * legado. So estrutura (FontName/Movable/Resizable/ReadOnly/ColumnOrder/
    * InputMask) - SEM ControlSource ainda, porque cursor_4c_Grade so passa
    * a existir depois de sigprcpdBO.CarregarDados() (regra #41: Column.
    * ControlSource antes do cursor existir derruba o Init). ControlSource,
    * Header1.Caption e Column.Width sao configurados em CarregarLista(),
    * DEPOIS do RecordSource (regra do Problema 48 - RecordSource reseta
    * ambos).
    *
    * ColumnOrder reproduz a ordem visual do SCX legado: Column8 (Unidade
    * Prod.) primeiro, seguido de Column1..Column7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top         = 139
            .Left        = 0
            .Width       = 801
            .Height      = 310
            .ColumnCount = 8
            .FontName    = "Arial"
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .ScrollBars  = 2
            .Visible     = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .ColumnOrder       = 2
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column2
            .ColumnOrder       = 3
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column3
            .ColumnOrder       = 4
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column4
            .ColumnOrder       = 5
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .InputMask         = "9999.99"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column5
            .ColumnOrder       = 6
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column6
            .ColumnOrder       = 7
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column7
            .ColumnOrder       = 8
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column8
            .ColumnOrder       = 1
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.Alignment   = 3
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Troca de linha na grade recarrega o detalhe do produto (imagem,
        *-- descricao, quantidade, cliente, tempo total do envelope) -
        *-- equivalente ao PROCEDURE AfterRowColChange do legado
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Chama sigprcpdBO.CarregarDados() com os parametros
    * recebidos no Init (Fase/Unidade/Data/Codigo) e, com sucesso, faz o
    * bind do Grid ao cursor resultante. Equivalente ao trecho final do
    * PROCEDURE Init do legado (bind da .grade + Go Top + Refresh).
    *
    * ControlSource so eh atribuido AQUI (depois do cursor existir - regra
    * #41), e Header1.Caption/Column.Width sao reconfigurados DEPOIS do
    * RecordSource (Problema 48 - RecordSource reseta os dois).
    *
    * PUBLIC de proposito (NAO marcar PROTECTED - regra #3 do CLAUDE.md):
    * TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da classe,
    * guardado so por PEMSTATUS(oForm, "CarregarLista", 5), que devolve .T.
    * mesmo para metodo PROTECTED (testa existencia, nao escopo) - com
    * PROTECTED o teste entra no branch e a chamada estoura em runtime com
    * "Property CARREGARLISTA is not found". Nome canonico do projeto (138
    * dos 141 forms OPERACIONAL usam CarregarLista), igual ao visualizador
    * de referencia FormSigMvSbn.
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid, loc_cCursor

        loc_lSucesso = .F.

        IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFasePar, ;
                THIS.this_cUnidadePar, THIS.this_dDataPar, THIS.this_nCodigoPar)

            loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
            loc_oGrid   = THIS.grd_4c_Dados

            *-- Container1/Container2: espelha ".container1.Get_Data.Value =
            *-- ThisForm.data" / "Get_Fase.Value = ThisForm.Setor" / Get_Cap/
            *-- Get_Utz/Get_Sld do legado, lendo do BO (fonte unica - valores
            *-- ja normalizados por CarregarDados, ex. ALLTRIM em this_cFases)
            THIS.cnt_4c_Container1.txt_4c_Fase.Value  = THIS.this_oBusinessObject.this_cFases
            THIS.cnt_4c_Container1.txt_4c__Data.Value = THIS.this_oBusinessObject.this_dDatas
            THIS.cnt_4c_Container2.txt_4c_Cap.Value   = THIS.this_oBusinessObject.this_nMinutos
            THIS.cnt_4c_Container2.txt_4c_Utz.Value   = THIS.this_oBusinessObject.this_nUtilizados
            THIS.cnt_4c_Container2.txt_4c__Sld.Value  = THIS.this_oBusinessObject.this_nSaldos

            *-- RecordSource fora do WITH (regra GRID-WITH): dentro do mesmo
            *-- WITH que acessa .ColumnN, o VFP9 pode nao ter recriado as
            *-- colunas ainda e estourar "Unknown member COLUMN1".
            loc_oGrid.RecordSource = loc_cCursor

            WITH loc_oGrid
                .Column1.ControlSource = loc_cCursor + ".Nenvs"
                .Column2.ControlSource = loc_cCursor + ".Nops"
                .Column3.ControlSource = loc_cCursor + ".Ordems"
                .Column4.ControlSource = loc_cCursor + ".TempoReal"
                .Column5.ControlSource = loc_cCursor + ".Cpros"
                .Column6.ControlSource = loc_cCursor + ".Pedido"
                .Column7.ControlSource = loc_cCursor + ".Cliente"
                .Column8.ControlSource = loc_cCursor + ".UniPrdts"

                *-- Headers e larguras (RecordSource acabou de resetar os dois)
                .Column1.Header1.Caption = "Envelope"
                .Column1.Width           = 80
                .Column2.Header1.Caption = "O.P."
                .Column2.Width           = 102
                .Column3.Header1.Caption = "Seq"
                .Column3.Width           = 24
                .Column4.Header1.Caption = "Minutos"
                .Column4.Width           = 65
                .Column5.Header1.Caption = "Produto"
                .Column5.Width           = 95
                .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                .Column6.Width           = 190
                .Column7.Header1.Caption = "Cliente"
                .Column7.Width           = 165
                .Column8.Header1.Caption = "Unidade Prod."
                .Column8.Width           = 80

                *-- Operacoes com prioridade (Priors >= 999990) ficam pretas,
                *-- as demais azuis - transcricao literal do SetAll do legado
                .SetAll("DynamicForeColor", ;
                    "IIF(" + loc_cCursor + ".Priors < 999990, RGB(0,0,255), RGB(0,0,0))", ;
                    "Column")
            ENDWITH

            SELECT (loc_cCursor)
            GO TOP

            loc_oGrid.Refresh()

            *-- Equivalente a "ThisForm.Grade.SetFocus" + "AfterRowColChange()"
            *-- no fim do Init legado - carrega o detalhe da 1a linha sem
            *-- depender do usuario navegar a grade (SetFocus omitido: o
            *-- form ainda nao foi exibido neste ponto - THIS.Show() eh
            *-- chamado pelo menu.prg DEPOIS de InicializarForm retornar)
            THIS.GradeAfterRowColChange(1)

            loc_lSucesso = .T.
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Capacidade Produtiva")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Cria o unico botao do form legado (Sair/Encerrar).
    * SIGPRCPD nao tem Incluir/Alterar/Excluir/Buscar - eh form OPERACIONAL
    * de consulta, aberto ja com todos os parametros pelo chamador.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top        = 4
            .Left       = 725
            .Width      = 75
            .Height     = 75
            .Caption    = "Encerrar"
            .Cancel     = .T.
            .FontName   = "Comic Sans MS"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 8
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes     = .T.
            .Visible    = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Encerra o form (equivalente a ThisForm.Release do
    * legado). PUBLIC porque eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarDetalheProduto - Cria os controles de detalhe da linha
    * selecionada na grade (FigJpg/Shape4/Get_descr/Say1-4/Get_qtde/
    * Get_Cliente/Get_tEnv/Label1 do legado). Todos os TextBox tem
    * PROCEDURE When retornando .F. no legado (registros 9/44/45/48) -
    * display-only, ReadOnly = .T. aqui reproduz o comportamento. Valores
    * sao populados por GradeAfterRowColChange() a cada troca de linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDetalheProduto()
        *-- FigJpg/Shape4: imagem do produto, ocultos ate a 1a troca de
        *-- linha achar foto (Visible=.F. no legado, so FigJpg.Visible eh
        *-- alternado no AfterRowColChange - Shape4 permanece SEMPRE oculto
        *-- no legado, nenhum metodo do dump o torna visivel; reproduzido
        *-- fielmente aqui, sem inventar toggle para ele).
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Top     = 457
            .Left    = 459
            .Width   = 143
            .Height  = 105
            .Stretch = 1
            .Picture = ""
            .Visible = .F.
        ENDWITH

        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top     = 455
            .Left    = 456
            .Width   = 148
            .Height  = 109
            .Visible = .F.
        ENDWITH

        *-- Say2 "Descricao Produto" + Get_descr
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 455
            .Left      = 92
            .Width     = 130
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
        ENDWITH

        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Top       = 468
            .Left      = 90
            .Width     = 345
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 198)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        *-- Say1 "Quantidade" + Get_qtde
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 455
            .Left      = 11
            .Width     = 74
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Quantidade"
        ENDWITH

        THIS.AddObject("txt_4c_Qtde", "TextBox")
        WITH THIS.txt_4c_Qtde
            .Top       = 468
            .Left      = 9
            .Width     = 74
            .Height    = 23
            .InputMask = "99999.999"
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 198)
            .Value     = 0
            .ReadOnly  = .T.
        ENDWITH

        *-- Say3 "Cliente" + Get_Cliente
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 494
            .Left      = 11
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cliente"
        ENDWITH

        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .Top       = 507
            .Left      = 9
            .Width     = 425
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 221)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        *-- Say4 "Tempo Total do Envelope" + Get_tEnv
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 532
            .Left      = 11
            .Width     = 200
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tempo Total do Envelope"
        ENDWITH

        THIS.AddObject("txt_4c_TEnv", "TextBox")
        WITH THIS.txt_4c_TEnv
            .Top       = 545
            .Left      = 9
            .Width     = 74
            .Height    = 23
            .InputMask = "99999"
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 198)
            .Value     = 0
            .ReadOnly  = .T.
        ENDWITH

        *-- Label1 do form (raiz) - aviso "[ Operacao com Prioridade ]".
        *-- SCX declara AutoSize=.T. + Width/Height explicitos: esses
        *-- numeros JA SAO o auto-size calculado pelo Form Designer, entao
        *-- transcrever com AutoSize=.F. eh reproducao fiel (regra #23) -
        *-- AutoSize=.T. eh no-op em Label criado por AddObject.
        THIS.AddObject("lbl_4c_LabelPrioridade", "Label")
        WITH THIS.lbl_4c_LabelPrioridade
            .Top       = 457
            .Left      = 617
            .Width     = 160
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "[ Opera" + CHR(231) + CHR(227) + "o com Prioridade ]"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Recarrega o painel de detalhe da linha
    * selecionada na grade (imagem do produto, descricao, quantidade,
    * cliente e tempo total do envelope). Equivalente ao PROCEDURE
    * AfterRowColChange da Grade no legado (dump, linhas 1209-1244).
    *
    * PUBLIC + LPARAMETERS par_nColIndex: alvo de BINDEVENT (regra #3),
    * que exige metodo PUBLIC declarando o parametro do evento.
    *
    * A decodificacao do JPG (base64 -> arquivo em disco) eh feita aqui
    * (camada de UI) porque o BO so expoe o cursor de detalhe cru -
    * ObterDetalheProduto()/CarregarDoCursor() ja documentam essa divisao.
    * STRCONV(..., 14) roda uma UNICA vez (decode simples, nao duplo).
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_cFoto, loc_cCursorProduto, loc_cFigJpgs

        THIS.LockScreen = .T.

        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""

        IF THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorGrade)

            loc_cCursorProduto = THIS.this_oBusinessObject.this_cCursorProdutoDetalhe

            IF !EMPTY(THIS.this_oBusinessObject.this_cCpros) AND USED(loc_cCursorProduto) ;
                    AND TYPE(loc_cCursorProduto + ".FigJpgs") != "U"

                loc_cFigJpgs = EVALUATE(loc_cCursorProduto + ".FigJpgs")

                IF !ISNULL(loc_cFigJpgs) AND !EMPTY(loc_cFigJpgs)
                    loc_cArquivo = SYS(2023) + "\sigprcpd.jpg"
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)

                    IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                        THIS.img_4c_FigJpg.Picture = loc_cArquivo
                        THIS.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF

            THIS.txt_4c_Descr.Value   = THIS.this_oBusinessObject.this_cDpros
            THIS.txt_4c_Qtde.Value    = THIS.this_oBusinessObject.this_nQtds
            THIS.txt_4c_Cliente.Value = THIS.this_oBusinessObject.this_cRclis
            THIS.txt_4c_TEnv.Value    = THIS.this_oBusinessObject.this_nTempU

            THIS.txt_4c_Descr.Refresh()
            THIS.txt_4c_Qtde.Refresh()
            THIS.txt_4c_Cliente.Refresh()
            THIS.txt_4c_TEnv.Refresh()
        ENDIF

        THIS.LockScreen = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria o container cinza escuro superior com os
    * labels de titulo (cntSombra/lblSombra/lblTitulo do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
    * criados via AddObject (que nascem com Visible=.F.), percorrendo tambem
    * Pages de PageFrames e Controls de sub-containers.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- img_4c_FigJpg/shp_4c_Shape4: comecam ocultos de proposito
                *-- (Visible=.F. no legado) e so aparecem se
                *-- GradeAfterRowColChange achar foto do produto - nao forcar
                *-- Visible=.T. aqui (mesmo padrao de container flutuante)
                IF INLIST(UPPER(loc_oObjeto.Name), "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
                    LOOP
                ENDIF

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

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores desta consulta antes de liberar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_cLista, loc_nI, loc_cNome

        loc_cLista = "cursor_4c_Grade,cursor_4c_ProdutoDetalhe,cursor_4c_Pcz," + ;
            "cursor_4c_PcpCap,cursor_4c_Pcg,cursor_4c_Pco,cursor_4c_PcoAgrupado"

        FOR loc_nI = 1 TO OCCURS(",", loc_cLista) + 1
            loc_cNome = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))
            IF !EMPTY(loc_cNome) AND USED(loc_cNome)
                USE IN (loc_cNome)
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*====================================================================
* sigprcpdBO.prg
*
* Business Object para Formsigprcpd (Capacidade Produtiva)
* Form OPERACIONAL (nao-CRUD): exibe, para um Envelope/Codigo de OP
* (SigCdPcz.codigos) em uma Fase/Setor e Unidade Produtiva, a capacidade
* de producao (minutos totais/utilizados/saldo, agregados a partir de
* SigCdPcp) e a grade de operacoes vinculadas (SigCdPco join SigCdCli),
* rateando o tempo de cada operacao pela proporcao apurada em SigCdPcg.
*
* Tabela principal para efeitos de ObterChavePrimaria/auditoria: SigCdPco
* (cidchaves char(20) - PK). Nao ha INSERT/UPDATE/DELETE no legado: o
* form apenas consulta e exibe - o comportamento padrao herdado de
* BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao) ja eh o
* correto para este BO.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Parametros recebidos do form/menu chamador (equivalentes a
    *-- LPARAMETERS pFase, pUnidade, pData, pCodigo do Init legado)
    this_cFases    = ""    && fases char(10) - Setor/Fase de producao
    this_cUniprdts = ""    && uniprdts char(10) - Unidade Produtiva (opcional)
    this_dDatas    = {}    && datas - Data de referencia da capacidade
    this_nCodigos  = 0     && codigos numeric(10,0) - Codigo do Envelope/OP (SigCdPcz)

    *-- Capacidade agregada (Container2: Capacidade/Utilizado/Saldo),
    *-- somada a partir de SigCdPcp para a Fase/Data/Unidade informadas
    this_nMinutos    = 0   && minutos numeric(9,1) - Capacidade total (minutos)
    this_nUtilizados = 0   && utilizados - minutos ja utilizados
    this_nSaldos     = 0   && saldos numeric(8,1) - Saldo disponivel (minutos)

    *-- Detalhe da linha corrente da grade (AfterRowColChange): dados do
    *-- produto e do cliente da operacao selecionada
    this_cCpros = ""    && cpros char(14) - codigo do produto da operacao
    this_cDpros = ""    && dpros - descricao do produto (SigCdPro.Dpros)
    this_nQtds  = 0     && qtds numeric(9,3) - quantidade da operacao
    this_cRclis = ""    && rclis - razao social do cliente (SigCdCli.Rclis)
    this_nTempU = 0     && tempU - tempo total do envelope (minutos)

    *-- Nome do cursor final que alimenta a grade (equivalente ao
    *-- zTmpPcpOp do legado)
    this_cCursorGrade = "cursor_4c_Grade"

    *-- Nome do cursor de detalhe do produto (equivalente ao CrTmpPro do
    *-- legado), populado por ObterDetalheProduto() a cada troca de linha
    this_cCursorProdutoDetalhe = "cursor_4c_ProdutoDetalhe"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPco"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprcpdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDados - Carrega a capacidade produtiva e a grade de
    * operacoes de um Envelope/OP (SigCdPcz.codigos), para uma
    * Fase/Setor, Data e (opcionalmente) Unidade Produtiva.
    *
    * Equivalente ao PROCEDURE Init do form legado SIGPRCPD: 4 consultas
    * remotas (validacao do envelope, capacidade agregada, "peso" por
    * envelope/sequencia em SigCdPcg, detalhe das operacoes em SigCdPco
    * + SigCdCli) seguidas de um SELECT local que agrupa o tempo das
    * operacoes por Fase+Unidade+Envelope+Sequencia (restrito as
    * combinacoes que tem "peso" em SigCdPcg) e de um SELECT local final
    * que rateia o tempo total do envelope (SigCdPcg.Minutos) entre as
    * operacoes proporcionalmente ao peso de cada uma.
    *
    * Parametros:
    *   par_cFase    - fases char(10), Setor/Fase de producao (obrigatorio)
    *   par_cUnidade - uniprdts char(10), Unidade Produtiva (opcional)
    *   par_dData    - datas, data de referencia da capacidade (obrigatorio)
    *   par_nCodigo  - codigos numeric(10,0), codigo do Envelope/OP (obrigatorio)
    *
    * Popula: this_nMinutos/this_nUtilizados/this_nSaldos (Container2) e
    * o cursor this_cCursorGrade, com as colunas do legado (nenvs, nops,
    * ordems, cpros, uniprdts, priors, pedido, cliente, rclis, tempu,
    * tempoo, temporeal).
    *
    * Retorno: .T. se sucesso, .F. se falha (mensagem em this_cMensagemErro)
    *====================================================================
    FUNCTION CarregarDados(par_cFase, par_cUnidade, par_dData, par_nCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cFiltroUnid, loc_cCursorGrade

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cFase) != "C" OR EMPTY(par_cFase) OR ;
                        VARTYPE(par_dData) != "D" OR EMPTY(par_dData) OR ;
                        VARTYPE(par_nCodigo) != "N" OR NVL(par_nCodigo, 0) <= 0
                    THIS.this_cMensagemErro = "Fase, Data e C" + CHR(243) + "digo do Envelope s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
                ELSE
                    THIS.this_cFases    = ALLTRIM(par_cFase)
                    THIS.this_cUniprdts = IIF(VARTYPE(par_cUnidade) = "C", ALLTRIM(par_cUnidade), "")
                    THIS.this_dDatas    = par_dData
                    THIS.this_nCodigos  = par_nCodigo

                    THIS.FecharCursoresTemporarios()

                    loc_cCursorGrade = THIS.this_cCursorGrade
                    loc_cFiltroUnid  = IIF(EMPTY(THIS.this_cUniprdts), "", " AND UniPrdts = " + EscaparSQL(THIS.this_cUniprdts))

                    *-- 1) Valida existencia do Envelope/OP (SigCdPcz)
                    loc_cSQL = "SELECT codigos FROM SigCdPcz WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcz")

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Envelope " + TRANSFORM(THIS.this_nCodigos) + " n" + CHR(227) + "o encontrado em SigCdPcz)"
                    ELSE
                        *-- 2) Capacidade agregada (SigCdPcp): Minutos/Utilizados/Saldos
                        loc_cSQL = "SELECT Codigos, SUM(minutos) AS Minutos, SUM(minutos - Saldos) AS Utilizados, SUM(saldos) AS Saldos " + ;
                            "FROM SigCdPcp " + ;
                            "WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                            " AND Datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                            " AND Fases = " + EscaparSQL(THIS.this_cFases) + ;
                            loc_cFiltroUnid + ;
                            " GROUP BY Codigos"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpCap")

                        IF loc_nResultado < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Capacidade n" + CHR(227) + "o encontrada em SigCdPcp)"
                        ELSE
                            THIS.this_nMinutos    = NVL(cursor_4c_PcpCap.Minutos, 0)
                            THIS.this_nUtilizados = NVL(cursor_4c_PcpCap.Utilizados, 0)
                            THIS.this_nSaldos     = NVL(cursor_4c_PcpCap.Saldos, 0)

                            *-- 3) "Peso"/tempo total por envelope-sequencia (SigCdPcg)
                            loc_cSQL = "SELECT * FROM SigCdPcg " + ;
                                "WHERE datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                                " AND fases = " + EscaparSQL(THIS.this_cFases) + ;
                                " AND codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                loc_cFiltroUnid + ;
                                " ORDER BY cidchaves"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcg")

                            IF loc_nResultado < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Programa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdPcg)"
                            ELSE
                                *-- 4) Detalhe das operacoes (SigCdPco + SigCdCli), com Pedido e
                                *-- Cliente ja concatenados no SQL Server (RTRIM no lugar do STR
                                *-- posicional do legado, que aqui so serve para exibicao)
                                loc_cSQL = "SELECT a.*, " + ;
                                    "RTRIM(a.dopes) + '-' + RIGHT('     ' + CONVERT(VARCHAR(6), a.numes), 6) AS Pedido, " + ;
                                    "RTRIM(a.contas) + '-' + RTRIM(b.rclis) AS Cliente, " + ;
                                    "RTRIM(b.rclis) AS Rclis " + ;
                                    "FROM SigCdPco a INNER JOIN SigCdCli b ON a.contas = b.iclis " + ;
                                    "WHERE a.codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                    " AND a.fases = " + EscaparSQL(THIS.this_cFases) + ;
                                    IIF(EMPTY(THIS.this_cUniprdts), "", " AND a.uniprdts = " + EscaparSQL(THIS.this_cUniprdts)) + ;
                                    " ORDER BY a.uniprdts, a.seqs, a.nenvs"
                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pco")

                                IF loc_nResultado < 1
                                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o encontradas em SigCdPco)"
                                ELSE
                                    *-- 5) Agrupa localmente o total de minutos por Fase+Unidade+
                                    *-- Envelope+Sequencia, restrito as combinacoes que existem em
                                    *-- SigCdPcg (equivalente ao zTmpPcpOp3 do legado). Chave
                                    *-- POSICIONAL: Fases/UniPrdts sao char(10) nos dois cursores e
                                    *-- STR() fixa a largura dos numericos - NAO fazer ALLTRIM aqui
                                    *-- (regra: chave posicional concatenada quebra em silencio).
                                    SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, SUM(a.Minutos) AS Minutos ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                        GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs ;
                                        INTO CURSOR cursor_4c_PcoAgrupado READWRITE

                                    *-- 6) Grade final: rateia o tempo total do envelope (b.Minutos)
                                    *-- proporcionalmente ao peso de cada operacao (a.Minutos/c.Minutos).
                                    *-- TempoReal transcreve fStoM((a.minutos*60)/(c.minutos*60)*(b.minutos*60))
                                    *-- do legado (SIGFUNCS.PRG) via ConverterSegundosParaMinutos() -
                                    *-- ver comentario da funcao mais abaixo. Guard IIF(c.Minutos=0,...)
                                    *-- evita erro de divisao por zero que o legado nao previa.
                                    SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                                        ConverterSegundosParaMinutos(IIF(NVL(c.Minutos, 0) = 0, 0, (a.Minutos * 60) / (c.Minutos * 60) * (b.Minutos * 60))) AS TempoReal ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b, cursor_4c_PcoAgrupado c ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                          AND a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            c.Fases + c.UniPrdts + STR(c.Nenvs, 10) + STR(c.Seqs, 2) ;
                                        ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs ;
                                        INTO CURSOR (loc_cCursorGrade) READWRITE

                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterDetalheProduto - Busca descricao e imagem (base64) do produto
    * de uma linha da grade (SigCdPro), para exibicao ao trocar a linha
    * selecionada. Equivalente a parte de consulta do AfterRowColChange
    * do legado - decodificar o base64 e gravar o JPG em disco eh
    * responsabilidade do Form (camada de UI), nao do BO.
    *
    * Parametro: par_cCpros - cpros char(14), codigo do produto
    * Popula: cursor this_cCursorProdutoDetalhe (colunas Dpros, FigJpgs)
    * Retorno: .T. se encontrou o produto, .F. caso contrario
    *====================================================================
    FUNCTION ObterDetalheProduto(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cCpros) != "C" OR EMPTY(par_cCpros)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
                ELSE
                    IF USED(THIS.this_cCursorProdutoDetalhe)
                        USE IN (THIS.this_cCursorProdutoDetalhe)
                    ENDIF

                    loc_cSQL = "SELECT FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProdutoDetalhe)

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Produto " + ALLTRIM(par_cCpros) + " n" + CHR(227) + "o encontrado em SigCdPro."
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ObterDetalheProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega o detalhe da LINHA CORRENTE da grade
    * para as propriedades do BO. Equivalente a parte de LEITURA do
    * AfterRowColChange do form legado SIGPRCPD (dump, linhas 1231-1240):
    *     ThisForm.Get_descr.Value   = CrTmpPro.Dpros
    *     ThisForm.Get_qtde.Value    = zTmpPcpOp.Qtds
    *     ThisForm.Get_cliente.Value = zTmpPcpOp.Rclis
    *     ThisForm.Get_tEnv.Value    = zTmpPcpOp.TempU
    * O legado termina o handler com "Select zTmpPcpOp" - reproduzido aqui
    * pelo SELECT (loc_cAlias), para a area de trabalho corrente continuar
    * sendo a da grade quando o metodo retorna (o SQLEXEC do lookup de
    * produto troca a area corrente no meio do caminho).
    *
    * Metodo PUBLIC de proposito: quem chama eh o handler de
    * AfterRowColChange do Form, de FORA da classe. PROTECTED falharia em
    * runtime com "Property CARREGARDOCURSOR is not found", e o
    * PEMSTATUS(oBO, "CarregarDoCursor", 5) que costuma cercar a chamada
    * devolveria .T. sem proteger (so verifica existencia, nao escopo).
    *
    * Parametro: par_cAliasCursor - alias do cursor da grade. Omitido ou
    *            vazio, assume THIS.this_cCursorGrade.
    * Popula: this_cCpros, this_nQtds, this_cRclis, this_nTempU (da linha
    *         corrente da grade) e this_cDpros (lookup em SigCdPro).
    * Retorno: .T. se a linha foi lida - inclusive grade VAZIA, que apenas
    *          limpa o detalhe; .F. so se o cursor da grade nao existe.
    *
    * NOTA sobre retorno .T. com this_cMensagemErro preenchido: falha
    * APENAS no lookup da descricao do produto NAO invalida a leitura da
    * linha. Nesse caso this_cDpros fica vazio, a mensagem eh PRESERVADA
    * para o caller exibir se quiser, e o retorno continua .T.
    *====================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                ALLTRIM(par_cAliasCursor), THIS.this_cCursorGrade)

            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            ELSE
                SELECT (loc_cAlias)

                THIS.LimparDetalhe()

                IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
                    *-- Grade sem linha posicionada: o detalhe fica limpo. O
                    *-- legado nunca chega aqui, porque a grade so dispara
                    *-- AfterRowColChange com uma linha valida selecionada.
                    loc_lSucesso = .T.
                ELSE
                    *-- Leitura por EVALUATE com guarda de TYPE() != "U": coluna
                    *-- ausente no cursor estouraria "Variable X is not found"
                    *-- em RUNTIME, compilando limpo. TratarNulo cobre o valor
                    *-- NULL (2o argumento eh o valor PADRAO, nao codigo de tipo).
                    *-- Tipos conferidos em docs\schema.sql (SigCdPco):
                    *-- cpros char(14), qtds numeric(9,3); Rclis vem do
                    *-- RTRIM(b.rclis) e TempU do SigCdPcg.Minutos numeric(9,1).
                    IF TYPE(loc_cAlias + ".Cpros") != "U"
                        THIS.this_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Cpros"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Qtds") != "U"
                        THIS.this_nQtds = TratarNulo(EVALUATE(loc_cAlias + ".Qtds"), 0)
                    ENDIF

                    IF TYPE(loc_cAlias + ".Rclis") != "U"
                        THIS.this_cRclis = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Rclis"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".TempU") != "U"
                        THIS.this_nTempU = TratarNulo(EVALUATE(loc_cAlias + ".TempU"), 0)
                    ENDIF

                    *-- Descricao do produto (SigCdPro.Dpros), como o legado faz
                    *-- inline no AfterRowColChange. O cursor de detalhe fica
                    *-- disponivel para o Form ler FigJpgs e gerar o JPG (a
                    *-- decodificacao base64 eh responsabilidade da UI).
                    IF !EMPTY(THIS.this_cCpros)
                        IF THIS.ObterDetalheProduto(THIS.this_cCpros)
                            IF TYPE(THIS.this_cCursorProdutoDetalhe + ".Dpros") != "U"
                                THIS.this_cDpros = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorProdutoDetalhe + ".Dpros"), ""))
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Repoe a grade como area corrente (o SQLEXEC do lookup
                    *-- selecionou o cursor de detalhe) - "Select zTmpPcpOp".
                    IF USED(loc_cAlias)
                        SELECT (loc_cAlias)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * LimparDetalhe - Zera as propriedades de detalhe da linha (produto,
    * quantidade, cliente e tempo do envelope). Usado no inicio de
    * CarregarDoCursor e quando a grade nao tem linha posicionada, para o
    * painel inferior nao exibir o detalhe da linha ANTERIOR.
    *
    * PUBLIC de proposito: o Form tambem limpa o painel ao recarregar a
    * grade (chamada de FORA da classe - mesma razao de CarregarDoCursor).
    *====================================================================
    PROCEDURE LimparDetalhe()
        THIS.this_cCpros = ""
        THIS.this_cDpros = ""
        THIS.this_nQtds  = 0
        THIS.this_cRclis = ""
        THIS.this_nTempU = 0
    ENDPROC

    *====================================================================
    * FecharCursoresTemporarios - Fecha os cursores intermediarios desta
    * consulta antes de recarregar (evita "Table buffer contains
    * uncommitted changes" numa segunda chamada a CarregarDados).
    *====================================================================
    PROTECTED PROCEDURE FecharCursoresTemporarios()
        LOCAL loc_cLista, loc_nI, loc_cNome

        loc_cLista = "cursor_4c_Pcz,cursor_4c_PcpCap,cursor_4c_Pcg,cursor_4c_Pco," + ;
            "cursor_4c_PcoAgrupado," + THIS.this_cCursorGrade

        FOR loc_nI = 1 TO OCCURS(",", loc_cLista) + 1
            loc_cNome = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))
            IF !EMPTY(loc_cNome) AND USED(loc_cNome)
                USE IN (loc_cNome)
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Este BO eh somente-consulta (form legado
    * SIGPRCPD nao tem INSERT/UPDATE/DELETE - o comportamento padrao
    * herdado de BusinessBase, que recusa Inserir/Atualizar/
    * ExecutarExclusao, ja eh o correto). Metodo mantido apenas por
    * padrao arquitetural; chave conceitual eh o codigo do Envelope/OP.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

ENDDEFINE

*====================================================================
* ConverterSegundosParaMinutos - Converte um valor em SEGUNDOS para o
* formato decimal Minutos.Segundos (ex.: 755 segundos -> 12.35, ou
* seja, 12 minutos e 35 segundos), usado na coluna "Minutos" da grade
* (Column4, InputMask "9999.99").
*
* Transcricao literal de Function fStoM(pHor) em SIGFUNCS.PRG (Framework
* legado Fortyus, C:\4install\FortyusMC\Fortyus\SIGFUNCS.PRG:188-190):
*   Return Round(Int(pHor/60) + Abs(pHor-(Int(pHor/60)*60))/100, 2)
* Nome novo por exigencia do PILAR 3 - contrato numerico identico ao
* original (mesma entrada/saida para qualquer valor).
*
* Funcao GLOBAL (fora do DEFINE CLASS) para poder ser chamada por nome
* dentro da lista de colunas de um SELECT VFP local, igual ao fStoM(...)
* do legado - config.prg carrega este .prg via ADIR (*BO.prg) e a torna
* disponivel no PATH de procedures do sistema.
*====================================================================
FUNCTION ConverterSegundosParaMinutos(par_nSegundos)
    LOCAL loc_nMinutos

    IF VARTYPE(par_nSegundos) != "N"
        RETURN 0
    ENDIF

    loc_nMinutos = INT(par_nSegundos / 60)
    RETURN ROUND(loc_nMinutos + ABS(par_nSegundos - (loc_nMinutos * 60)) / 100, 2)
ENDFUNC


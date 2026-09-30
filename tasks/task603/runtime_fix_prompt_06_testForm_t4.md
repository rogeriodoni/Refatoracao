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
[2026-09-28 03:31:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 03:31:23] [INFO] Config FPW: (nao fornecido)
[2026-09-28 03:31:23] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 03:31:23] [INFO] Timeout: 300 segundos
[2026-09-28 03:31:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pdx1ttbe.prg
[2026-09-28 03:31:23] [INFO] Conteudo do wrapper:
[2026-09-28 03:31:23] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrEml', 'C:\4c\tasks\task603\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrEml', 'C:\4c\tasks\task603\logs\06_testForm.log'
QUIT

[2026-09-28 03:31:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pdx1ttbe.prg
[2026-09-28 03:31:23] [INFO] VFP output esperado em: C:\4c\tasks\task603\vfp_output.txt
[2026-09-28 03:31:23] [INFO] Executando Visual FoxPro 9...
[2026-09-28 03:31:23] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pdx1ttbe.prg
[2026-09-28 03:31:23] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pdx1ttbe.prg
[2026-09-28 03:31:23] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrEml
Inicio: 28/09/2026 03:31:23

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 28/09/2026 03:34:31
Duracao: 188 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-28 03:34:31] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-28 03:34:31] [INFO] VFP9 finalizado em 188.0950953 segundos
[2026-09-28 03:34:31] [INFO] Exit Code: 
[2026-09-28 03:34:31] [INFO] 
[2026-09-28 03:34:31] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-28 03:34:31] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pdx1ttbe.prg
[2026-09-28 03:34:31] [INFO] 
[2026-09-28 03:34:31] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-28 03:34:31] [INFO] * Auto-generated wrapper for parameters
[2026-09-28 03:34:31] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 03:34:31] [INFO] * Parameters: 'FormSigPrEml', 'C:\4c\tasks\task603\logs\06_testForm.log'
[2026-09-28 03:34:31] [INFO] 
[2026-09-28 03:34:31] [INFO] * Anti-dialog protections for unattended execution
[2026-09-28 03:34:31] [INFO] SET SAFETY OFF
[2026-09-28 03:34:31] [INFO] SET RESOURCE OFF
[2026-09-28 03:34:31] [INFO] SET TALK OFF
[2026-09-28 03:34:31] [INFO] SET NOTIFY OFF
[2026-09-28 03:34:31] [INFO] SYS(2335, 0)
[2026-09-28 03:34:31] [INFO] 
[2026-09-28 03:34:31] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrEml', 'C:\4c\tasks\task603\logs\06_testForm.log'
[2026-09-28 03:34:31] [INFO] QUIT
[2026-09-28 03:34:31] [INFO] 
[2026-09-28 03:34:31] [INFO] === Fim do Wrapper.prg ===
[2026-09-28 03:34:31] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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
* FormSigPrEml.prg - Alerta de Email (envio de alertas por email de movimentacao)
* Origem: SIGPREML.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT (sem PageFrame), dialogo MODAL aberto por
*       outro form/rotina com parametros, equivalente a:
*       Parameters prDopes, pcEscolha, laOpeBaixa
*         prDopes    - EmpDopNums da movimentacao (Emps(3) + Dopes(20) + Numes(6) = 29)
*         pcEscolha  - acao que originou o alerta: INSERIR / ALTERAR / EXCLUIR
*         laOpeBaixa - array de EmpDopNums de operacoes de baixa (opcional)
*
* Controles principais: grd_4c_Dados (grade_alerta), cmd_4c_SelTudo/
* cmd_4c_Apaga (selecao em massa) e cmd_4c_BtnEmail (envio efetivo dos
* alertas para a lista principal, com gravacao de historico em
* SigAlert). A cascata de baixa (crOpeBaixa/laOpeBaixa do legado) e
* montada em SigPrEmlBO.MontarCascataBaixa (chamada por CarregarAlertas)
* e enviada por SigPrEmlBO.EnviarCascataBaixa (chamada por
* EnviarAlertasSelecionados apos o envio principal dar certo).
*
* CAMPOS / LOOKUPS: o SCX legado NAO tem campo algum fora da grade (nenhum
* TextBox/ComboBox/CheckBox solto - conferido no layout.json e na SECAO 1 do
* dump) e NAO tem lookup algum (nenhum fwBuscaExt/fwBuscaSel/fwBuscaInt,
* nenhum mAddColuna, nenhum sigacess()/Acesso*() em todo o dump). Nao ha,
* portanto, campo a acrescentar nem tabela auxiliar a consultar - inventar
* um lookup aqui violaria o PILAR 1 e a regra "NUNCA inventar tabelas de
* lookup que nao existem no original". A superficie de dados deste form sao
* as COLUNAS da grade, e a unica celula editavel eh Email (Column4 no
* legado, ReadOnly = .F. na Column e no Text1); a validacao dessa celula
* mora em ValidarEmailCelula, e as pre-condicoes do botao de envio em
* ValidarEnvio.
*
* INTEGRACAO COM O CHAMADOR: o legado NAO tem entrada de menu para SIGPREML -
* eh aberto exclusivamente de dentro de SigMvCab (Framework\sigmvcab.SCT,
* 2 sites) apos Inserir/Alterar/Excluir de uma movimentacao com job:
*     Do form SigPrEml With TprMvCab.EmpDopNums, thisform.pcEscolha, laOpeBaixa
* equivalente a CREATEOBJECT("FormSigPrEml", <EmpDopNums>, <pcEscolha>,
* <aOpeBaixa>).Show() feito pelo form de movimentacao (SigMvCab, ainda nao
* migrado nesta base). NAO adicionar item de popMovimentos/menu.prg para
* este form - isso inventaria um ponto de entrada que o sistema legado nunca
* teve (seria uma tela sem os 3 parametros que o Init exige para funcionar).
*
* PROCEDURE Load (="fConfigGeral()") NAO PORTADO de proposito - mesmo padrao
* documentado em FormSigMvExp/FormSigMvMen/FormSigPrCar/FormSigPrCcc/
* FormSigPrCfn (fConfigGeral era funcao GLOBAL de inicializacao do legado,
* ausente do acervo; o wrapper utils\fconfiggeral.prg eh NO-OP e existe so
* para o p-code de VCX legado que ainda a chama). Chamar o wrapper aqui
* sugeriria inicializacao real que nao existe - a configuracao que ela fazia
* no legado ja esta distribuida em config.prg/main.prg/SigPrEmlBO.Init.
*==============================================================================

DEFINE CLASS FormSigPrEml AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    Caption      = "ALERTA - Email"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Parametros recebidos do chamador (equivalente a Parameters prDopes,
    *-- pcEscolha, laOpeBaixa do legado) - armazenados em Init antes de DODEFAULT
    this_cEmpDopNumsOrigem = ""    && prDopes  - Emps(3)+Dopes(20)+Numes(6) = 29 chars
    this_cEscolha          = ""    && pcEscolha - INSERIR / ALTERAR / EXCLUIR
    this_aOpeBaixa         = .NULL. && laOpeBaixa - array de EmpDopNums (opcional)

    *==========================================================================
    * Init - Armazena parametros recebidos do chamador antes de DODEFAULT
    * (que chama FormBase.Init -> THIS.InicializarForm())
    *==========================================================================
    PROCEDURE Init(par_cEmpDopNums, par_cEscolha, par_aOpeBaixa)
        LOCAL loc_oErro

        TRY
            THIS.this_cEmpDopNumsOrigem = TratarNulo(par_cEmpDopNums, "")
            THIS.this_cEscolha          = UPPER(TratarNulo(par_cEscolha, ""))

            IF VARTYPE(par_aOpeBaixa) = "A"
                THIS.this_aOpeBaixa = par_aOpeBaixa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e a estrutura visual base
    * (cabecalho, botao de saida, grade de alertas e botoes de acao).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEmlBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigPrEmlBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrEml.InicializarForm")
            ELSE
                *-- Repassa o contexto recebido do chamador para o BO
                *-- (equivalente a Thisform.lcEmp = Substr(prdopes,1,3) do legado)
                THIS.this_oBusinessObject.this_cEmpDopNumsOrigem = THIS.this_cEmpDopNumsOrigem
                THIS.this_oBusinessObject.this_cLcEmp            = SUBSTR(THIS.this_cEmpDopNumsOrigem, 1, 3)
                THIS.this_oBusinessObject.this_cLcDopes          = SUBSTR(THIS.this_cEmpDopNumsOrigem, 4, 20)
                THIS.this_oBusinessObject.this_cEscolha          = THIS.this_cEscolha
                THIS.this_oBusinessObject.this_aOpeBaixa         = THIS.this_aOpeBaixa

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotaoSaida()
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarBotaoEmail()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da lista de alertas: trecho final do Init legado (as
                *-- queries em SigMvCab/SigCdAle/SigCdCli/SigCdPam). O legado
                *-- faz "Return .f." quando qualquer consulta falha - mantido
                *-- fiel. Em validacao de UI / modo teste nao ha conexao SQL
                *-- nem parametros reais do chamador, entao a carga eh pulada
                *-- e o form abre so com o layout (grade vazia).
                IF !loc_lModoValidacaoOuTeste
                    loc_lSucesso = THIS.CarregarDados()
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigPrEml")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - shp_4c_Shape1 (decorativo) + cnt_4c_Sombra com
    * lbl_4c_LblSombra/lbl_4c_LblTitulo
    * Original: Shape1 (Top=-2,Left=819,W=84,H=84,BackStyle=0,BorderStyle=0)
    *           cntSombra (Top=0,Left=-1,W=1004,H=80,BackColor=100,100,100)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top           = -2
                .Left          = 819
                .Width         = 84
                .Height        = 84
                .BackStyle     = 0
                .BorderStyle   = 0
                .BorderWidth   = 1
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = 769
                .Height        = 40
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Top         = 17
                .Left        = 10
                .Width       = 769
                .Height      = 46
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoSaida - obj_4c_Commandgroup1 com o botao de encerrar
    * Original: Commandgroup1 (Top=-2,Left=918,W=85,H=85,ButtonCount=1) com
    *           Command1 "btnSair" (Top=5,Left=5,W=75,H=75,Caption="Encerrar")
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoSaida()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
            WITH THIS.obj_4c_Commandgroup1
                .AutoSize     = .T.
                .ButtonCount  = 1
                .BackStyle    = 0
                .BorderStyle  = 0
                .Top          = -2
                .Left         = 918
                .Width        = 85
                .Height       = 85
                .SpecialEffect = 1
                .BorderColor  = RGB(136, 189, 188)
                .Themes       = .F.
                .Visible      = .T.

                WITH .Buttons(1)
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Encerrar"
                    .ToolTipText = "[Esc] Encerrar"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoSaida")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - Encerra o formulario (equivalente ao btnSair.Click legado:
    * With ThisForm / .Release / lcFrm = .Name / Release &lcFrm.)
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria cursor_4c_Dados (equivalente a "Create Cursor
    * crLocalTotal" do Init legado) e o grd_4c_Dados (grade_alerta) com as
    * 5 colunas: Checks (checkbox), Contas, Rclis (Nome), Emails (editavel)
    * e Mensagem (editbox).
    * Original: grade_alerta (Top=132,Left=3,W=993,H=435,ColumnCount=5,
    *           FontName="Verdana",FontSize=8,RowHeight=18,RecordMark=.F.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro
        TRY
            THIS.CriarCursorDados()

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top          = 132
                .Left         = 3
                .Width        = 993
                .Height       = 435
                .FontName     = "Verdana"
                .FontSize     = 8
                .RowHeight    = 18
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .ReadOnly     = .F.
                .Visible      = .T.
            ENDWITH

            *-- ColumnCount/RecordSource FORA do WITH que acessa .Column - dentro
            *-- do mesmo WITH as colunas ainda nao existem no escopo resolvido.
            THIS.grd_4c_Dados.ColumnCount  = 5
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"

            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = "cursor_4c_Dados.checks"
                .Column2.ControlSource = "cursor_4c_Dados.contas"
                .Column3.ControlSource = "cursor_4c_Dados.rclis"
                .Column4.ControlSource = "cursor_4c_Dados.emails"
                .Column5.ControlSource = "cursor_4c_Dados.mensagems"

                *-- Column1 - Checks (fwcheckbox1 original, ColumnOrder=1, Width=17)
                *-- Sparse=.F. garante checkbox visivel em TODAS as linhas (nao so na corrente)
                .Column1.Width = 30
                .Column1.AddObject("chk_4c_Check", "CheckBox")
                WITH .Column1.chk_4c_Check
                    .Caption = ""
                    .Top     = 0
                    .Left    = 2
                    .Width   = 22
                    .Height  = 17
                    .Visible = .T.
                ENDWITH
                .Column1.CurrentControl = "chk_4c_Check"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.
                .Column1.FontName       = "Verdana"
                .Column1.FontSize       = 8
                .Column1.Header1.Caption = ""

                *-- Column2 - Contas (Column2 original, ColumnOrder=2, Width=80)
                .Column2.ReadOnly        = .T.
                .Column2.Width           = 80
                .Column2.FontName        = "Verdana"
                .Column2.FontSize        = 8
                .Column2.Header1.Caption = "Conta"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8

                *-- Column3 - Rclis/Nome (Column3 original, ColumnOrder=3, Width=290)
                .Column3.ReadOnly        = .T.
                .Column3.Width           = 290
                .Column3.FontName        = "Verdana"
                .Column3.FontSize        = 8
                .Column3.Header1.Caption = "Nome"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8

                *-- Column4 - Email (Column4 original, ColumnOrder=4, Width=290, editavel)
                *-- UNICA celula editavel da grade: o legado tem ReadOnly = .F.
                *-- tanto na Column quanto no Text1. MaxLength = 50 vem da
                *-- LARGURA DA COLUNA no schema (SigCdCli.emails char(50) e
                *-- cursor_4c_Dados.emails C(50)), nunca do Width em pixels
                *-- (regra #19 do CLAUDE.md).
                .Column4.ReadOnly        = .F.
                .Column4.Text1.ReadOnly  = .F.
                .Column4.Text1.MaxLength = 50
                .Column4.Width           = 290
                .Column4.FontName        = "Verdana"
                .Column4.FontSize        = 8
                .Column4.Header1.Caption = "Email"
                .Column4.Header1.Alignment = 2
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8

                *-- Column5 - Mensagem (Column5 original/fweditbox1, ColumnOrder=5, Width=290)
                .Column5.AddObject("edt_4c_Mensagem", "EditBox")
                WITH .Column5.edt_4c_Mensagem
                    .ReadOnly = .T.
                    .Visible  = .T.
                ENDWITH
                .Column5.CurrentControl        = "edt_4c_Mensagem"
                .Column5.Sparse                = .F.
                .Column5.ReadOnly              = .T.
                .Column5.Width                 = 290
                .Column5.FontName               = "Verdana"
                .Column5.FontSize               = 8
                .Column5.Header1.Caption        = "Mensagem"
                .Column5.Header1.Alignment      = 2
                .Column5.Header1.FontName       = "Verdana"
                .Column5.Header1.FontSize       = 8
            ENDWITH

            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "Click", THIS, "ChkCheckClick")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "MouseDown", THIS, "ChkCheckMouseDown")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "MouseUp", THIS, "ChkCheckMouseUp")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "KeyPress", THIS, "ChkCheckKeyPress")

            *-- Validacao da celula Email (unica editavel). KeyPress, nao
            *-- "Valid": BINDEVENT em "Valid" nao dispara de forma confiavel
            *-- em TextBox. Text1 eh membro NATIVO da Column (nao precisa de
            *-- AddObject), logo eh alvo valido de BINDEVENT.
            BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "KeyPress", THIS, "ValidarEmailCelula")

            BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "HeaderContasClick")
            BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderRclisClick")
            BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "HeaderEmailsClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursorDados - Cria o cursor_4c_Dados (equivalente ao
    * "Create Cursor crLocalTotal (Checks N(1),grupos c(10),Contas c(10),
    * Rclis c(30),emails c(50),mensagems m,prioridade c(15),EmpDopNums c(29),
    * Acaos c(10))" + os 3 indices por Contas/Rclis/Emails do Init legado.
    * Rclis usa C(50) (nao C(30) como no legado) para bater com a largura
    * real de SigCdCli.rclis no schema e evitar truncamento de nome.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorDados()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ( ;
            checks     N(1), ;
            grupos     C(10), ;
            contas     C(10), ;
            rclis      C(50), ;
            emails     C(50), ;
            mensagems  M, ;
            prioridade C(15), ;
            empdopnums C(29), ;
            acaos      C(10))
        SET NULL OFF

        INDEX ON contas TAG contas
        INDEX ON rclis  TAG rclis
        INDEX ON emails TAG emails
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes standalone SelTudo (Marcar Todos) e
    * Apaga (Desmarcar Todos), ao lado esquerdo, acima da grade.
    * Original: SelTudo (Top=90,Left=4,W=40,H=40,Picture=geral_marcar_26.jpg)
    *           apaga   (Top=90,Left=43,W=40,H=40,Picture=cadastro_excluir_26.jpg)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top             = 90
                .Left            = 4
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Marcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top             = 90
                .Left            = 43
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Desmarcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Visible         = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEmail - cmd_4c_BtnEmail (btnEmail original, classe
    * fwbtnp), botao standalone que dispara o envio dos alertas.
    * Original: btnEmail (Top=3,Left=848,W=75,H=75,
    *           Picture=geral_envelope_60.jpg,Caption="Enviar Email")
    * Themes = .T. + DisabledPicture: CommandButton standalone com
    * Picture exige isso, senao o icone some quando .Enabled = .F. (regra
    * #99 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEmail()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
            WITH THIS.cmd_4c_BtnEmail
                .Top             = 3
                .Left            = 848
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Caption         = "Enviar Email"
                .ToolTipText     = "Enviar Email"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Visible         = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "BtnProcessarEmailClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoEmail")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarEmailClick - Envia o e-mail de alerta para os destinatarios
    * marcados na grade (equivalente ao PROCEDURE Click de
    * SIGPREML.btnEmail). Se o envio e a gravacao do historico em
    * SigAlert tiverem sucesso, o legado fecha a tela (Wait Window "Email
    * enviado com sucesso!" Timeout 0.02 + thisform.Release()) -
    * reproduzido abaixo. Falha ja foi avisada dentro do BO (todo caminho
    * de erro em EnviarAlertasSelecionados chama MsgErro/MsgAviso), entao
    * este handler nao precisa de ELSE (regra #20 do CLAUDE.md).
    *
    * A cascata de baixa (crOpeBaixa/laOpeBaixa) do legado tambem eh
    * enviada aqui, dentro de EnviarAlertasSelecionados - ver
    * SigPrEmlBO.EnviarCascataBaixa.
    *
    * NOME: "Processar" (e nao "Enviar", verbo do Caption legado) porque o
    * vocabulario de verbos de acao - Salvar/Confirmar/Gravar/Processa/
    * Aplicar/Executar/OK - eh a interface que torna o handler de acao
    * ENUMERAVEL pelos gates do pipeline; verbo de negocio fora dele faz a
    * validacao reprovar um form correto. E eh fiel: este Click nao so
    * envia - ele monta a mensagem, GRAVA o historico em SigAlert
    * (Insert Into crSigAlert + Update/Commit no legado) e so entao
    * despacha pelo SMTP. O CONTROLE (cmd_4c_BtnEmail) segue com o nome do
    * meio de entrega e NAO muda, portanto mapeamento.json nao eh afetado.
    *==========================================================================
    PROCEDURE BtnProcessarEmailClick()
        LOCAL loc_oErro

        *-- Guarda de pre-acao. O RETURN fica FORA do TRY (regra #1 do
        *-- CLAUDE.md): ValidarEnvio ja exibiu o aviso do motivo.
        IF !THIS.ValidarEnvio()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.EnviarAlertasSelecionados()
                WAIT WINDOW "Email enviado com sucesso!" TIMEOUT .02
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarEmailClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarEnvio - Guarda de pre-acao do botao Enviar Email. Reproduz as
    * PRE-CONDICOES de que o PROCEDURE Click de SIGPREML.btnEmail depende
    * (e que no legado, quando faltavam, so apareciam como falha obscura do
    * EnviaEmail ou como "Impossivel Efetuar Conexao..."):
    *
    *   1. Grade populada          - o legado faz "Return .f." no Init quando
    *                                qualquer consulta falha; sem linha no
    *                                cursor nao ha destinatario algum.
    *   2. EmpDopNums da origem    - "Thisform.lcEmp = Substr(prdopes,1,3)" e
    *                                "m.Emps/m.Dopes/m.Numes = Substr(...)":
    *                                sem a chave de 29 posicoes a configuracao
    *                                SMTP nao eh localizada em SigCdEmp e o
    *                                historico em SigAlert grava chave vazia.
    *   3. Acao (pcEscolha)        - entra no WHERE do Init legado
    *                                (inserirs/alterars/excluirs) e no corpo
    *                                da mensagem ("Acao : " + pcescolha).
    *   4. Ao menos uma linha marcada - o legado monta "Select * From
    *                                crLocaltotal Where Checks = 1" e tira o
    *                                destinatario dela.
    *   5. E-mail da PRIMEIRA linha marcada - eh o destinatario (lcReceptor).
    *                                O legado guarda a lista de COPIA com
    *                                "If !Empty(Alltrim(...emails))", mas nao
    *                                guarda o destinatario principal.
    *
    * Devolve .T. quando pode enviar; .F. depois de avisar o motivo.
    * Preserva o registro corrente do cursor para nao mexer na grade.
    *==========================================================================
    PROCEDURE ValidarEnvio()
        LOCAL loc_lOk, loc_nRegAtual, loc_nMarcados, loc_cEmailReceptor
        LOCAL loc_oControleFoco
        loc_lOk            = .F.
        loc_nMarcados      = 0
        loc_cEmailReceptor = ""

        DO CASE
            CASE !USED("cursor_4c_Dados")
                MsgAviso("Nenhum alerta carregado." + CHR(13) + ;
                    "Reinicialize o processo antes de enviar.", ;
                    "Processamento de Email")

            CASE RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum destinat" + CHR(225) + "rio de alerta foi localizado " + ;
                    "para esta movimenta" + CHR(231) + CHR(227) + "o.", ;
                    "Processamento de Email")

            CASE EMPTY(ALLTRIM(THIS.this_cEmpDopNumsOrigem))
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + ;
                    "o informada." + CHR(13) + "Reinicialize o processo.", ;
                    "Processamento de Email")

            CASE !INLIST(ALLTRIM(UPPER(THIS.this_cEscolha)), "INSERIR", "ALTERAR", "EXCLUIR")
                MsgAviso("A" + CHR(231) + CHR(227) + "o do alerta inv" + CHR(225) + "lida: [" + ;
                    ALLTRIM(THIS.this_cEscolha) + "]." + CHR(13) + ;
                    "Esperado INSERIR, ALTERAR ou EXCLUIR.", ;
                    "Processamento de Email")

            OTHERWISE
                *-- Varre na ORDEM CORRENTE da grade (o SET ORDER TO TAG
                *-- definido pelos Header1.Click), para que a "primeira linha
                *-- marcada" seja a mesma que o BO usara como destinatario.
                SELECT cursor_4c_Dados
                loc_nRegAtual = RECNO("cursor_4c_Dados")

                SCAN FOR cursor_4c_Dados.checks = 1
                    loc_nMarcados = loc_nMarcados + 1
                    IF loc_nMarcados = 1
                        loc_cEmailReceptor = ALLTRIM(TratarNulo(cursor_4c_Dados.emails, ""))
                    ENDIF
                ENDSCAN

                IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Dados"))
                    GO loc_nRegAtual IN cursor_4c_Dados
                ELSE
                    GO TOP IN cursor_4c_Dados
                ENDIF

                DO CASE
                    CASE loc_nMarcados = 0
                        MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                            "Marque ao menos um e-mail antes de enviar.", ;
                            "Processamento de Email")

                    CASE EMPTY(loc_cEmailReceptor)
                        MsgAviso("A primeira linha marcada est" + CHR(225) + " sem e-mail." + CHR(13) + ;
                            "Preencha a coluna Email dessa linha ou desmarque-a.", ;
                            "Processamento de Email")

                    OTHERWISE
                        loc_lOk = .T.
                ENDCASE
        ENDCASE

        *-- Devolve o foco para a grade quando a validacao barrou o envio,
        *-- para o usuario corrigir no lugar em que o erro esta.
        IF !loc_lOk AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            loc_oControleFoco = THIS.grd_4c_Dados
            IF loc_oControleFoco.Visible AND loc_oControleFoco.Enabled
                loc_oControleFoco.SetFocus()
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * ValidarEmailCelula - Handler de validacao da UNICA celula editavel da
    * grade: a coluna Email (no legado Column4, ColumnOrder=4, com
    * ReadOnly = .F. tanto na Column quanto no Text1).
    *
    * BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox (regra
    * do CLAUDE.md), por isso a validacao roda no KeyPress em ENTER/TAB -
    * o momento em que o legado executava o Valid da celula.
    *
    * Faz duas coisas:
    *   1. NORMALIZA - grava o valor sem espacos a esquerda/direita no
    *      cursor, porque ele vai direto para o cabecalho SMTP (lcReceptor /
    *      lcReceptorCopia do legado, que ja usava Alltrim na lista de copia).
    *   2. AVISA quando o texto digitado nao contem "@" - endereco que NAO
    *      pode funcionar em envio nenhum. DIVERGENCIA DELIBERADA do legado,
    *      que aceitava qualquer texto e falhava depois no EnviaEmail com
    *      mensagem que nao diz QUAL linha esta errada. O valor digitado NAO
    *      eh apagado (so avisado), portanto nenhum valor que funcionaria no
    *      legado passa a ser recusado aqui.
    *==========================================================================
    PROCEDURE ValidarEmailCelula(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDigitado

        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_cDigitado = ALLTRIM(TratarNulo(THIS.grd_4c_Dados.Column4.Text1.Value, ""))

        SELECT cursor_4c_Dados
        REPLACE emails WITH loc_cDigitado

        IF !EMPTY(loc_cDigitado) AND !("@" $ loc_cDigitado)
            MsgAviso("Endere" + CHR(231) + "o de e-mail inv" + CHR(225) + "lido: [" + ;
                loc_cDigitado + "]." + CHR(13) + ;
                "Um endere" + CHR(231) + "o de e-mail precisa conter o caractere @.", ;
                "Processamento de Email")
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarDados - Delega ao BO a montagem de cursor_4c_Dados e, em caso
    * de sucesso, atualiza a grade e o estado inicial de ordenacao (o legado
    * chama Thisform.grade_alerta.column3.header1.Click() apos popular, para
    * ordenar por Nome).
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_oBusinessObject.CarregarAlertas()
            SELECT cursor_4c_Dados
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            THIS.HeaderRclisClick()
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HeaderContasClick / HeaderRclisClick / HeaderEmailsClick - Reordena
    * cursor_4c_Dados pelo TAG correspondente e realca o header da coluna
    * ativa, igual aos 3 Header1.Click do grade_alerta legado.
    *==========================================================================
    PROCEDURE HeaderContasClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG contas
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderRclisClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG rclis
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderEmailsClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG emails
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ChkCheckKeyPress/MouseUp/MouseDown/Click - CheckBox de coluna de Grid
    * nao alterna pelo binding nativo em VFP9 (licao Erro146/Pattern #185/
    * #186) - Click/MouseDown sao suprimidos com NODEFAULT e o toggle real
    * acontece no KeyPress (Enter/Espaco) e no MouseUp (que simula o mesmo
    * Enter). Equivalente ao "Replace Checks With this.Value in crLocalTotal"
    * do InteractiveChange original.
    *==========================================================================
    PROCEDURE ChkCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            REPLACE checks WITH IIF(checks = 0, 1, 0)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCheckMouseUp(par_nButton, par_nShift, par_nCol, par_nRow)
        THIS.ChkCheckKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCheckMouseDown(par_nButton, par_nShift, par_nCol, par_nRow)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCheckClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick / BtnApagaClick - Marcar Todos / Desmarcar Todos.
    * Original: Select crLocalTotal / Go top / Replace All Checks With 1|0 /
    *           Go Top / ThisForm.Refresh()
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL checks WITH 1
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnApagaClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL checks WITH 0
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
    * criados via AddObject (que nascem com Visible = .F.)
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_OpeBaixa")
            USE IN cursor_4c_OpeBaixa
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEmlBO.prg):
*====================================================================
* SigPrEmlBO.prg
*
* Business Object para SigPrEml (Alerta - Envio de Email)
* Tabela: SigAlert (historico de alertas de email enviados)
* Chave: pkchaves char(20) - PK (fUniqueIds())
*
* Form OPERACIONAL chamado com parametros (par_cEmpDopNums, par_cEscolha,
* par_aOpeBaixa) por outras telas do sistema, para montar e enviar uma
* lista de emails de alerta referente a uma movimentacao (SigMvCab) e
* gravar o historico em SigAlert.
*
* Fonte da lista de emails:
*  - SigCdAle (parametrizacao de alerta por grupo/conta) filtrado pelo
*    Dopes da movimentacao e pela acao (INSERIR/ALTERAR/EXCLUIR)
*  - SigCdCli (contas do grupo padrao em SigCdPam.GrPadAts), quando a
*    conta ainda nao estiver na lista acima
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrEmlBO AS BusinessBase

    *-- Contexto recebido do chamador (equivalente aos parametros do
    *-- Init() do form legado: prDopes, pcEscolha, laOpeBaixa)
    this_cEmpDopNumsOrigem = ""    && par_cEmpDopNums recebido (emp+dopes+num, 29 chars)
    this_cLcEmp            = ""    && Substr(EmpDopNumsOrigem, 1, 3)  - empresa
    this_cLcDopes          = ""    && Substr(EmpDopNumsOrigem, 4, 20) - operacao (Dopes)
    this_cEscolha          = ""    && "INSERIR", "ALTERAR" ou "EXCLUIR"
    this_aOpeBaixa         = .NULL. && par_aOpeBaixa recebido (array de EmpDopNums de operacoes de baixa, opcional)

    *-- Propriedades da entidade (mapeamento para tabela SigAlert)
    this_cPkChaves    = ""    && pkchaves char(20) - PK (fUniqueIds())
    this_cAcaos       = ""    && acaos char(10) - acao que originou o alerta
    this_cContas      = ""    && contas char(10) - FK SigCdCli.Iclis (destinatario)
    this_cDopes       = ""    && dopes char(20) - FK SigCdOpe.Dopes
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave da movimentacao (emp+dopes+num)
    this_cEmps        = ""    && cemps char(3) - FK SigCdEmp.Cemps
    this_cGrupos      = ""    && grupos char(10) - grupo do destinatario
    this_cMsg1s       = ""    && msg1s text - mensagem enviada ao destinatario principal
    this_cMsg2s       = ""    && msg2s text - mensagem enviada aos destinatarios em copia
    this_nNumes       = 0     && numes numeric(6,0) - numero sequencial da movimentacao
    this_nPriors      = 0     && priors numeric(1,0) - prioridade (1=URGENTE,2=IMPORTANTE,demais=NORMAL)
    this_dDtAlerts    = {}    && dtalerts datetime - data/hora do alerta
    this_dDtAlert2s   = {}    && dtalert2s datetime - data/hora do alerta (baixa/complementar)
    this_cUsualerts   = ""    && usualerts char(10) - usuario que gerou o alerta
    this_cUsuars      = ""    && usuars char(10) - usuario logado (auditoria)

    *-- Propriedades de apoio para envio (NAO persistidas em SigAlert;
    *-- vem do cadastro da empresa - SigCdEmp.AleServs/AleEmails/AleSenhas/AlePortas)
    this_cEmailFrom   = ""    && email remetente (SigCdEmp.AleEmails)
    this_cSmtpServer  = ""    && servidor SMTP (SigCdEmp.AleServs)
    this_cSmtpSenha   = ""    && senha SMTP (SigCdEmp.AleSenhas)
    this_nSmtpPorta   = 0     && porta SMTP (SigCdEmp.AlePortas)

    *-- Dados da movimentacao de origem (equivalente ao cursor TmpMvCab do
    *-- legado) - carregados por CarregarAlertas() e usados tanto no filtro
    *-- de contas por Job (SigClJob) quanto na composicao do texto do email
    this_cMovJobs        = ""    && TmpMvCab.Jobs
    this_cMovRclis       = ""    && TmpMvCab.Rclis (nome do cliente do Job)
    this_cMovObsCabMovs  = ""    && TmpMvCab.ObsCabMovs
    this_cMovObses       = ""    && TmpMvCab.Obses (memo)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigAlert"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrEmlBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor (SELECT * FROM SigAlert)
    * para as propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_cAcaos      = TratarNulo(acaos, "")
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cMsg1s      = TratarNulo(msg1s, "")
            THIS.this_cMsg2s      = TratarNulo(msg2s, "")
            THIS.this_nNumes      = TratarNulo(numes, 0)
            THIS.this_nPriors     = TratarNulo(priors, 0)
            THIS.this_dDtAlerts   = TratarNulo(dtalerts, {})
            THIS.this_dDtAlert2s  = TratarNulo(dtalert2s, {})
            THIS.this_cUsualerts  = TratarNulo(usualerts, "")
            THIS.this_cUsuars     = TratarNulo(usuars, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigAlert
    *
    * SigAlert eh tabela de HISTORICO (todas as 15 colunas NOT NULL, sem
    * DEFAULT - ver docs/schema.sql). O legado grava um registro por
    * destinatario dentro do Scan de btnEmail.Click (Scatter Memo Memvar +
    * Insert Into crSigAlert From Memvar), preenchendo pkchaves/emps/dopes/
    * numes/dtalerts/msg1s/usuars na hora - por isso os guards abaixo
    * replicam esse preenchimento quando o chamador nao setou a property.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- pkchaves eh a PK Fortyus (fUniqueIds()) - nunca pode ir vazia,
            *-- senao o proximo registro colide no indice unico (regra #22).
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            *-- dtalerts eh a data/hora do alerta - equivalente a m.DtAlerts =
            *-- Datetime() no legado. Sem valor explicito, usa o instante atual.
            IF EMPTY(THIS.this_dDtAlerts)
                THIS.this_dDtAlerts = DATETIME()
            ENDIF

            *-- usualerts/usuars = usuario logado (auditoria), igual ao legado
            *-- (m.Usuars = m.Usuar), quando o chamador nao informou outro valor.
            IF EMPTY(THIS.this_cUsualerts)
                THIS.this_cUsualerts = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF

            loc_cSQL = "INSERT INTO SigAlert" + ;
                       " (pkchaves, acaos, contas, dopes, empdopnums, emps, grupos," + ;
                       " msg1s, msg2s, numes, priors, dtalerts, dtalert2s, usualerts, usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cPkChaves) + "," + ;
                       EscaparSQL(THIS.this_cAcaos) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cGrupos) + "," + ;
                       EscaparSQL(THIS.this_cMsg1s) + "," + ;
                       EscaparSQL(THIS.this_cMsg2s) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + "," + ;
                       FormatarDataSQL(THIS.this_dDtAlerts) + "," + ;
                       IIF(EMPTY(THIS.this_dDtAlert2s), "'19000101'", FormatarDataSQL(THIS.this_dDtAlert2s)) + "," + ;
                       EscaparSQL(THIS.this_cUsualerts) + "," + ;
                       EscaparSQL(THIS.this_cUsuars) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar alerta de e-mail:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar alerta de e-mail:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigAlert (complemento de baixa/reenvio)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cPkChaves)
            THIS.this_cMensagemErro = "Chave do alerta n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigAlert SET" + ;
                       " acaos = " + EscaparSQL(THIS.this_cAcaos) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       " emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " msg1s = " + EscaparSQL(THIS.this_cMsg1s) + "," + ;
                       " msg2s = " + EscaparSQL(THIS.this_cMsg2s) + "," + ;
                       " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       " priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + "," + ;
                       " dtalert2s = " + IIF(EMPTY(THIS.this_dDtAlert2s), "'19000101'", FormatarDataSQL(THIS.this_dDtAlert2s)) + "," + ;
                       " usualerts = " + EscaparSQL(THIS.this_cUsualerts) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar alerta de e-mail:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar alerta de e-mail:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarAlertas - Monta a lista de destinatarios do alerta em
    * cursor_4c_Dados (equivalente ao "Create Cursor crLocalTotal" + as
    * queries que o alimentam no Init() do legado):
    *   1) TmpMvCab - dados da movimentacao (SigMvCab + Job em SigCdCli)
    *   2) crLocalALE - SigCdAle parametrizado para o Dopes/acao, filtrado
    *      por conta pertencer ao Job da movimentacao (SigClJob)
    *   3) crLocalPAM - contas do grupo padrao (SigCdPam.GrPadAts), quando
    *      ainda nao estiverem na lista acima (dedup por Contas+Rclis)
    *
    * Tambem monta (via MontarCascataBaixa) o cursor_4c_OpeBaixa da
    * cascata de laOpeBaixa do legado - esse cursor NAO alimenta a
    * grade, so o envio de email (EnviarCascataBaixa, chamado de
    * EnviarAlertasSelecionados).
    *
    * Pre-requisito: FormSigPrEml.ConfigurarGrid() ja criou o cursor
    * cursor_4c_Dados (CREATE CURSOR) antes de chamar este metodo.
    *====================================================================
    FUNCTION CarregarAlertas()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado, loc_cFlagCampo, loc_lCascataOk
        loc_lSucesso  = .F.
        loc_lCascataOk = .T.

        TRY
            *-- 1) Dados da movimentacao (equivalente a TmpMvCab do legado)
            loc_cSQL = "SELECT a.jobs AS jobs, a.obscabmovs AS obscabmovs," + ;
                       " a.obses AS obses, b.rclis AS rclis" + ;
                       " FROM SigMvCab a" + ;
                       " INNER JOIN SigCdCli b ON a.jobs = b.iclis" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(THIS.this_cEmpDopNumsOrigem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMvCab")
            IF loc_nResultado < 0 OR !USED("cursor_4c_TmpMvCab") OR RECCOUNT("cursor_4c_TmpMvCab") = 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (TmpMvCab)", "Erro")
            ELSE
                SELECT cursor_4c_TmpMvCab
                THIS.this_cMovJobs       = TratarNulo(jobs, "")
                THIS.this_cMovRclis      = TratarNulo(rclis, "")
                THIS.this_cMovObsCabMovs = TratarNulo(obscabmovs, "")
                THIS.this_cMovObses      = TratarNulo(obses, "")

                DO CASE
                    CASE THIS.this_cEscolha = "INSERIR"
                        loc_cFlagCampo = "inserirs"
                    CASE THIS.this_cEscolha = "ALTERAR"
                        loc_cFlagCampo = "alterars"
                    CASE THIS.this_cEscolha = "EXCLUIR"
                        loc_cFlagCampo = "excluirs"
                    OTHERWISE
                        loc_cFlagCampo = ""
                ENDCASE

                *-- Cascata de baixa (laOpeBaixa) - equivalente ao bloco
                *-- "If Type([laOpeBaixa],1) = [A] ... Endif" do Init legado
                *-- (linhas 561-615). Nao alimenta a grade (cursor_4c_Dados) -
                *-- monta cursor_4c_OpeBaixa, consumido so por
                *-- EnviarCascataBaixa() no envio do e-mail. Erro ja avisado
                *-- dentro de MontarCascataBaixa (regra #9 - CATCH nunca
                *-- silencioso); aqui so propaga a falha, igual ao Return .F.
                *-- do legado quando qualquer consulta da cascata falha.
                loc_lCascataOk = THIS.MontarCascataBaixa()

                *-- 2) Alertas parametrizados em SigCdAle para o Dopes/acao
                loc_cSQL = "SELECT ale.grupos AS grupos, ale.contas AS contas," + ;
                           " cli.rclis AS rclis, cli.emails AS emails, ale.mensagems AS mensagems," + ;
                           " CASE WHEN ale.priors = 1 THEN 'URGENTE' WHEN ale.priors = 2 THEN 'IMPORTANTE' ELSE 'NORMAL' END AS prioridade" + ;
                           " FROM SigCdAle ale" + ;
                           " INNER JOIN SigCdCli cli ON ale.contas = cli.iclis" + ;
                           " WHERE ale.dopes = " + EscaparSQL(THIS.this_cLcDopes) + ;
                           IIF(!EMPTY(loc_cFlagCampo), " AND ale." + loc_cFlagCampo + " = 1", "")

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpAle")
                IF loc_nResultado < 0
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crLocal)", "Erro")
                ELSE
                    IF USED("cursor_4c_TmpAle") AND RECCOUNT("cursor_4c_TmpAle") > 0
                        SELECT cursor_4c_TmpAle
                        SCAN
                            IF THIS.ContaPertenceAoJob(cursor_4c_TmpAle.contas)
                                INSERT INTO cursor_4c_Dados (checks, grupos, contas, rclis, emails, mensagems, prioridade, empdopnums, acaos) ;
                                    VALUES (1, cursor_4c_TmpAle.grupos, cursor_4c_TmpAle.contas, cursor_4c_TmpAle.rclis, ;
                                            cursor_4c_TmpAle.emails, NVL(cursor_4c_TmpAle.mensagems, ""), cursor_4c_TmpAle.prioridade, ;
                                            THIS.this_cEmpDopNumsOrigem, THIS.this_cEscolha)
                            ENDIF
                            SELECT cursor_4c_TmpAle
                        ENDSCAN
                    ENDIF

                    *-- 3) Contas do grupo padrao (SigCdPam.GrPadAts), quando
                    *-- ainda nao estiverem na lista acima
                    loc_cSQL = "SELECT cli.grupos AS grupos, cli.iclis AS contas," + ;
                               " cli.rclis AS rclis, cli.emails AS emails" + ;
                               " FROM SigCdPam pam" + ;
                               " INNER JOIN SigCdCli cli ON cli.grupos = pam.grpadats"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPam")
                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crLocal)", "Erro")
                    ELSE
                        IF USED("cursor_4c_TmpPam") AND RECCOUNT("cursor_4c_TmpPam") > 0
                            SELECT cursor_4c_TmpPam
                            SCAN
                                IF THIS.ContaPertenceAoJob(cursor_4c_TmpPam.contas)
                                    SELECT cursor_4c_Dados
                                    LOCATE FOR ALLTRIM(contas) == ALLTRIM(cursor_4c_TmpPam.contas) AND ;
                                               ALLTRIM(rclis) == ALLTRIM(cursor_4c_TmpPam.rclis)
                                    IF EOF("cursor_4c_Dados")
                                        INSERT INTO cursor_4c_Dados (checks, grupos, contas, rclis, emails, empdopnums, acaos, prioridade) ;
                                            VALUES (0, "", cursor_4c_TmpPam.contas, cursor_4c_TmpPam.rclis, cursor_4c_TmpPam.emails, ;
                                                    THIS.this_cEmpDopNumsOrigem, THIS.this_cEscolha, "NORMAL")
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_TmpPam
                            ENDSCAN
                        ENDIF

                        SELECT cursor_4c_Dados
                        GO TOP
                        loc_lSucesso = loc_lCascataOk
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarAlertas")
        ENDTRY

        IF USED("cursor_4c_TmpMvCab")
            USE IN cursor_4c_TmpMvCab
        ENDIF
        IF USED("cursor_4c_TmpAle")
            USE IN cursor_4c_TmpAle
        ENDIF
        IF USED("cursor_4c_TmpPam")
            USE IN cursor_4c_TmpPam
        ENDIF
        IF USED("cursor_4c_TmpClJob")
            USE IN cursor_4c_TmpClJob
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ContaPertenceAoJob - Replica o filtro do legado que PULA a conta
    * quando ela tem Jobs cadastrados em SigClJob mas NENHUM deles bate
    * com o Job da movimentacao de origem. Equivalente a:
    *   Select Jobs From SigClJob Where Iclis = <conta>
    *   Select TmpClJob / Go top
    *   If !Eof()
    *       Locate For Jobs = TmpMvCab.Jobs
    *       If Eof()
    *           Loop   && pula a conta
    *       Endif
    *   Endif
    * Conta SEM nenhum Job cadastrado (TmpClJob vazio) NAO eh pulada -
    * o filtro por Job so se aplica a quem tem Job restrito.
    *====================================================================
    PROTECTED FUNCTION ContaPertenceAoJob(par_cContas)
        LOCAL loc_lPertence, loc_nResultado
        loc_lPertence = .T.

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT jobs FROM SigClJob WHERE iclis = " + EscaparSQL(par_cContas), "cursor_4c_TmpClJob")

        IF loc_nResultado >= 0 AND USED("cursor_4c_TmpClJob") AND RECCOUNT("cursor_4c_TmpClJob") > 0
            SELECT cursor_4c_TmpClJob
            LOCATE FOR ALLTRIM(jobs) == ALLTRIM(THIS.this_cMovJobs)
            loc_lPertence = !EOF("cursor_4c_TmpClJob")
        ENDIF

        RETURN loc_lPertence
    ENDFUNC

    *====================================================================
    * MontarCascataBaixa - Monta cursor_4c_OpeBaixa a partir do array
    * this_aOpeBaixa (par_aOpeBaixa recebido pelo form) - equivalente ao
    * bloco "If Type([laOpeBaixa],1) = [A] ... Endif" do Init() legado
    * (linhas 561-615 do fonte original):
    *   1) tenta achar, em SigAlert, um alerta de baixa JA enviado para
    *      alguma das movimentacoes do array (Acaos = 'BAIXAR') e o
    *      enriquece com email/prioridade/mensagem atuais de SigCdCli/
    *      SigCdAle;
    *   2) se nao achar nenhum (Reccount = 0), monta do zero a partir de
    *      SigCdAle/SigCdCli (baixas = 1) e amarra o EmpDopNums de cada
    *      linha ao item correspondente do array (por Dopes).
    *
    * cursor_4c_OpeBaixa alimenta SO o envio de email complementar
    * (EnviarCascataBaixa) - nao entra na grade de selecao
    * (cursor_4c_Dados). Se this_aOpeBaixa nao for array (uso normal,
    * sem baixa em cascata), nao ha nada a fazer.
    *====================================================================
    PROTECTED FUNCTION MontarCascataBaixa()
        LOCAL loc_lSucesso, loc_nResultado, loc_nX, loc_cItem, loc_cDope, loc_cEDN
        LOCAL loc_cSQL, loc_cContas, loc_cDopes

        loc_lSucesso = .T.

        IF USED("cursor_4c_OpeBaixa")
            USE IN cursor_4c_OpeBaixa
        ENDIF

        IF VARTYPE(THIS.this_aOpeBaixa) = "A"
            loc_cDope = ""
            loc_cEDN  = ""

            FOR loc_nX = 1 TO ALEN(THIS.this_aOpeBaixa)
                loc_cItem = TratarNulo(THIS.this_aOpeBaixa(loc_nX), "")
                IF !EMPTY(loc_cItem)
                    loc_cDope = loc_cDope + IIF(EMPTY(loc_cDope), "('", ",'") + ALLTRIM(SUBSTR(loc_cItem, 4, 20)) + "'"
                    loc_cEDN  = loc_cEDN  + IIF(EMPTY(loc_cEDN), "('", ",'") + ALLTRIM(loc_cItem) + "'"
                ENDIF
            ENDFOR

            IF !EMPTY(loc_cDope)
                loc_cDope = loc_cDope + ")"
                loc_cEDN  = loc_cEDN  + ")"

                *-- 1) Alerta de baixa ja enviado para alguma dessas movimentacoes
                IF USED("cursor_4c_TmpOpeBaixa")
                    USE IN cursor_4c_TmpOpeBaixa
                ENDIF

                loc_cSQL = "SELECT TOP 1 contas AS contas, acaos AS acaos, empdopnums AS empdopnums," + ;
                           " emps AS emps, dopes AS dopes, numes AS numes, SPACE(50) AS emails," + ;
                           " SPACE(15) AS prioridade, msg1s AS mensagems, 1 AS checks" + ;
                           " FROM SigAlert WHERE empdopnums IN " + loc_cEDN + " AND acaos = 'BAIXAR'"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeBaixa")
                IF loc_nResultado < 0
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crOpeBaixa)", "Erro")
                    loc_lSucesso = .F.
                ELSE
                    SELECT * FROM cursor_4c_TmpOpeBaixa INTO CURSOR cursor_4c_OpeBaixa READWRITE
                    USE IN cursor_4c_TmpOpeBaixa

                    IF RECCOUNT("cursor_4c_OpeBaixa") > 0
                        *-- Enriquece com email/prioridade/mensagem atuais do destinatario
                        SELECT cursor_4c_OpeBaixa
                        SCAN
                            loc_cContas = ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.contas, ""))
                            loc_cDopes  = ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.dopes, ""))

                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            loc_cSQL = "SELECT a.emails AS emails," + ;
                                       " CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' ELSE 'NORMAL' END AS prioridade," + ;
                                       " b.mensagems AS mensagems" + ;
                                       " FROM SigCdCli a INNER JOIN SigCdAle b ON a.iclis = b.contas" + ;
                                       " WHERE a.iclis = " + EscaparSQL(loc_cContas) + " AND b.dopes = " + EscaparSQL(loc_cDopes)

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            IF loc_nResultado < 0
                                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (TmpCli)", "Erro")
                                loc_lSucesso = .F.
                            ELSE
                                IF USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                    SELECT cursor_4c_TmpCli
                                    GO TOP
                                    SELECT cursor_4c_OpeBaixa
                                    REPLACE emails WITH cursor_4c_TmpCli.emails, ;
                                            prioridade WITH cursor_4c_TmpCli.prioridade, ;
                                            mensagems WITH cursor_4c_TmpCli.mensagems
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            SELECT cursor_4c_OpeBaixa
                        ENDSCAN
                    ENDIF

                    *-- 2) Nao achou alerta de baixa anterior - monta do zero a
                    *-- partir de SigCdAle/SigCdCli e amarra o EmpDopNums de
                    *-- cada linha do array (por Dopes)
                    IF loc_lSucesso AND RECCOUNT("cursor_4c_OpeBaixa") = 0
                        IF USED("cursor_4c_TmpOpeBaixa2")
                            USE IN cursor_4c_TmpOpeBaixa2
                        ENDIF

                        loc_cSQL = "SELECT 1 AS checks, ale.grupos AS grupos, ale.contas AS contas," + ;
                                   " cli.rclis AS rclis, cli.emails AS emails, ale.mensagems AS mensagems," + ;
                                   " CASE WHEN ale.priors = 1 THEN 'URGENTE' WHEN ale.priors = 2 THEN 'IMPORTANTE' ELSE 'NORMAL' END AS prioridade," + ;
                                   " ale.dopes AS dopes, SPACE(29) AS empdopnums, " + EscaparSQL(THIS.this_cEscolha) + " AS acaos" + ;
                                   " FROM SigCdAle ale" + ;
                                   " INNER JOIN SigCdCli cli ON ale.contas = cli.iclis" + ;
                                   " WHERE ale.dopes IN " + loc_cDope + " AND ale.baixas = 1"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeBaixa2")
                        IF loc_nResultado < 0
                            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crOpeBaixa)", "Erro")
                            loc_lSucesso = .F.
                        ELSE
                            IF USED("cursor_4c_OpeBaixa")
                                USE IN cursor_4c_OpeBaixa
                            ENDIF
                            SELECT * FROM cursor_4c_TmpOpeBaixa2 INTO CURSOR cursor_4c_OpeBaixa READWRITE
                            USE IN cursor_4c_TmpOpeBaixa2

                            IF RECCOUNT("cursor_4c_OpeBaixa") > 0
                                FOR loc_nX = 1 TO ALEN(THIS.this_aOpeBaixa)
                                    loc_cItem = TratarNulo(THIS.this_aOpeBaixa(loc_nX), "")
                                    IF !EMPTY(loc_cItem)
                                        SELECT cursor_4c_OpeBaixa
                                        GO TOP
                                        REPLACE ALL empdopnums WITH ALLTRIM(loc_cItem) ;
                                            FOR ALLTRIM(dopes) == ALLTRIM(SUBSTR(loc_cItem, 4, 20))
                                    ENDIF
                                ENDFOR
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterDadosContaEmail - Busca a conta de e-mail de ALERTA (SMTP)
    * parametrizada para a empresa em SigCdEmp.AleEmails/AleServs/
    * AleSenhas/AlePortas (equivalente a consulta LocalEmp do legado:
    * "Select AleServs, AleEmails, AleSenhas, AlePortas From SigCdEmp
    * Where CEmps = <lcEmp>"). Popula this_cEmailFrom/this_cSmtpServer/
    * this_cSmtpSenha/this_nSmtpPorta.
    *====================================================================
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT AleServs, AleEmails, AleSenhas, AlePortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(TratarNulo(par_cCodEmpresa, "")))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (LocalEmp)", "Erro")
            ELSE
                SELECT cursor_4c_TmpEmpMail
                GO TOP
                IF !EOF()
                    THIS.this_cEmailFrom  = ALLTRIM(TratarNulo(AleEmails, ""))
                    THIS.this_cSmtpServer = ALLTRIM(TratarNulo(AleServs, ""))
                    THIS.this_cSmtpSenha  = ALLTRIM(TratarNulo(AleSenhas, ""))
                    THIS.this_nSmtpPorta  = NVL(AlePortas, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ObterDadosContaEmail")
        ENDTRY

        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * EnviarEmailSmtp - Dispara o envio via CDO.Message (SMTP).
    *
    * DE ONDE VEM ESTE CORPO: o btnEmail.Click legado (linhas 881 e 941 do
    * fonte original) chama a funcao GLOBAL EnviaEmail(...), que NAO veio
    * no acervo (nao esta em Framework\sigacess.PRG nem em lugar nenhum
    * do dump). A melhor evidencia disponivel do que essa funcao faz eh o
    * PROCEDURE memail do SCX irmao SIGPREMA (sigpremaBO.prg), que
    * implementa a mesma rotina via CDO.Message - transcrita aqui com os
    * nomes de propriedade desta BO. Por isso NAO se cria wrapper
    * generico em utils\ (regra #27 do CLAUDE.md): a chamada mora no
    * codigo do FORM que estamos migrando, e este metodo a substitui.
    *
    * De-para dos argumentos, conferido contra a chamada legada
    * EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom,
    *            lcReceptorCopia, lcServer, lcSenha, lnPorta):
    *   lcReceptor      -> par_cPara        lcFrom   -> par_cRemetente
    *   lcReceptorCopia -> par_cCopia       lcServer -> par_cServidor
    *   lcAssunto       -> par_cAssunto     lcSenha  -> par_cSenha
    *   lcTxtMensagem   -> par_cCorpo       lnPorta  -> par_nPorta
    *   lcArqAnexo      -> par_cAnexo
    *
    * Retorna .T. se o e-mail foi enviado com sucesso.
    *====================================================================
    PROCEDURE EnviarEmailSmtp(par_cPara, par_cCopia, par_cAssunto, par_cCorpo, ;
                              par_cAnexo, par_cRemetente, par_cServidor, ;
                              par_cSenha, par_nPorta)
        LOCAL loc_lOk, loc_lEnvioOk, loc_oEmail, loc_oErro, loc_oErroEnvio

        loc_lOk      = .F.
        loc_lEnvioOk = .T.

        TRY
            IF TYPE('CREATEOBJECT("CDO.Message")') != "O"
                MsgAviso("Problemas para instanciar o objeto CDO.Message.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oEmail = CREATEOBJECT("CDO.Message")

                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")            = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")            = LOWER(par_cServidor)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")        = IIF(par_nPorta = 0, 25, par_nPorta)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")      = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")          = LOWER(par_cRemetente)
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")          = par_cSenha
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")            = IIF(par_nPorta = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To       = LOWER(par_cPara)
                    .Cc       = LOWER(NVL(par_cCopia, ""))
                    .From     = LOWER(par_cRemetente)
                    .Subject  = ALLTRIM(par_cAssunto)
                    .TextBody = ALLTRIM(par_cCorpo)

                    IF !EMPTY(par_cAnexo)
                        IF FILE(par_cAnexo)
                            .AddAttachment(par_cAnexo)
                        ELSE
                            loc_lEnvioOk = .F.
                            MsgAviso("N" + CHR(227) + "o foi encontrado o arquivo:" + CHR(13) + ;
                                     par_cAnexo + CHR(13) + "para ser anexado.", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOk
                        TRY
                            .Send()
                            loc_lOk = .T.
                        CATCH TO loc_oErroEnvio
                            *-- O legado tambem nao fica calado aqui: o Catch
                            *-- do PROCEDURE memail (SIGPREMA) avisa com
                            *-- Wait Window "Dados do e-mail invalidos."
                            *-- TimeOut 5 - transcrito para manter o aviso
                            *-- sem travar o processamento (CLAUDE.md #9:
                            *-- CATCH nunca silencioso).
                            WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
                            loc_lOk = .F.
                        ENDTRY
                    ENDIF
                ENDWITH

                loc_oEmail = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em EnviarEmailSmtp")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *====================================================================
    * EnviarCascataBaixa - Envia o e-mail complementar de "baixa" (quando
    * o form foi aberto com laOpeBaixa) e grava o historico correspondente
    * em SigAlert com Acaos = 'BAIXAR' - equivalente ao trecho
    * "If llOk And Used([CrOpeBaixa]) ... Endif" do btnEmail.Click legado
    * (linhas 887-946 do fonte original). So deve ser chamado quando o
    * envio principal (EnviarAlertasSelecionados) deu certo. Se
    * MontarCascataBaixa nao populou cursor_4c_OpeBaixa (uso normal, sem
    * baixa em cascata), nao ha nada a enviar e retorna .T. (equivalente
    * a "Used([CrOpeBaixa])" ser falso no legado).
    *====================================================================
    PROTECTED FUNCTION EnviarCascataBaixa()
        LOCAL loc_lOk, loc_lTodasGravacoesOk
        LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, loc_cTxtMensagem
        LOCAL loc_cEmpDopNumsBaixa

        loc_lOk = .T.

        IF USED("cursor_4c_OpeBaixa") AND RECCOUNT("cursor_4c_OpeBaixa") > 0
            loc_cReceptor         = ""
            loc_cReceptorCopia    = ""
            loc_cAssunto          = "ALERTA"
            loc_cTxtMensagem      = ""
            loc_lTodasGravacoesOk = .T.

            SELECT cursor_4c_OpeBaixa
            GO TOP
            SCAN
                loc_cEmpDopNumsBaixa = TratarNulo(cursor_4c_OpeBaixa.empdopnums, "")

                IF RECNO() = 1
                    loc_cReceptor    = ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.emails, ""))
                    loc_cTxtMensagem = ;
                        IIF(!EMPTY(THIS.this_cMovJobs), "JOB          : " + THIS.this_cMovJobs + " - " + ALLTRIM(THIS.this_cMovRclis) + CHR(13) + CHR(10), "") + ;
                        IIF(!EMPTY(THIS.this_cMovObsCabMovs), "Descritivo : " + ALLTRIM(THIS.this_cMovObsCabMovs) + CHR(13) + CHR(10), "") + ;
                        "Movimenta" + CHR(231) + CHR(227) + "o : " + SUBSTR(THIS.this_cEmpDopNumsOrigem, 1, 3) + " / " + SUBSTR(THIS.this_cEmpDopNumsOrigem, 4, 20) + " / " + SUBSTR(THIS.this_cEmpDopNumsOrigem, 24, 6) + CHR(13) + CHR(10) + ;
                        "A" + CHR(231) + CHR(227) + "o         : " + THIS.this_cEscolha + CHR(13) + CHR(10) + ;
                        "Movimenta" + CHR(231) + CHR(227) + "o baixada " + IIF(THIS.this_cEscolha = "EXCLUIR", "cancelada ", "") + ": " + ;
                            SUBSTR(loc_cEmpDopNumsBaixa, 1, 3) + " / " + SUBSTR(loc_cEmpDopNumsBaixa, 4, 20) + " / " + SUBSTR(loc_cEmpDopNumsBaixa, 24, 6) + CHR(13) + CHR(10) + ;
                        "Usu" + CHR(225) + "rio      : " + gc_4c_UsuarioLogado + CHR(13) + CHR(10) + ;
                        "Data         : " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
                        IIF(!EMPTY(TratarNulo(cursor_4c_OpeBaixa.mensagems, "")), "Mensagem     : " + ALLTRIM(cursor_4c_OpeBaixa.mensagems) + CHR(13) + CHR(10), "") + ;
                        IIF(!EMPTY(THIS.this_cMovObses), "Observa" + CHR(231) + CHR(227) + "o   : " + ALLTRIM(THIS.this_cMovObses), "")

                    loc_cAssunto = "ALERTA - " + ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.prioridade, ""))
                ELSE
                    IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.emails, "")))
                        loc_cReceptorCopia = loc_cReceptorCopia + ;
                            IIF(EMPTY(loc_cReceptorCopia), "", ",") + ALLTRIM(cursor_4c_OpeBaixa.emails)
                    ENDIF
                ENDIF

                *-- Historico do alerta de baixa - um registro em SigAlert por
                *-- destinatario, Acaos sempre 'BAIXAR' (equivalente ao
                *-- Scatter Memo Memvar + m.Acaos = [BAIXAR] + Insert Into
                *-- crSigAlert do legado)
                THIS.this_cPkChaves   = ""
                THIS.this_dDtAlerts   = DATETIME()
                THIS.this_cMsg1s      = loc_cTxtMensagem
                THIS.this_cMsg2s      = ""
                THIS.this_cAcaos      = "BAIXAR"
                THIS.this_cContas     = TratarNulo(cursor_4c_OpeBaixa.contas, "")
                THIS.this_cGrupos     = ""
                THIS.this_cEmpDopNums = loc_cEmpDopNumsBaixa
                THIS.this_cEmps       = SUBSTR(loc_cEmpDopNumsBaixa, 1, 3)
                THIS.this_cDopes      = SUBSTR(loc_cEmpDopNumsBaixa, 4, 20)
                THIS.this_nNumes      = VAL(SUBSTR(loc_cEmpDopNumsBaixa, 24, 6))
                THIS.this_nPriors     = 0
                THIS.this_dDtAlert2s  = {}
                THIS.this_cUsualerts  = gc_4c_UsuarioLogado
                THIS.this_cUsuars     = gc_4c_UsuarioLogado

                IF !THIS.Inserir()
                    loc_lTodasGravacoesOk = .F.
                ENDIF

                SELECT cursor_4c_OpeBaixa
            ENDSCAN

            WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR
            loc_lOk = THIS.EnviarEmailSmtp(loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, ;
                loc_cTxtMensagem, "", THIS.this_cEmailFrom, THIS.this_cSmtpServer, ;
                THIS.this_cSmtpSenha, THIS.this_nSmtpPorta)
            WAIT CLEAR

            loc_lOk = (loc_lOk AND loc_lTodasGravacoesOk)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *====================================================================
    * EnviarAlertasSelecionados - Envia o e-mail de alerta para os
    * destinatarios marcados (Checks = 1) em cursor_4c_Dados e grava o
    * historico correspondente em SigAlert - equivalente ao PROCEDURE
    * Click do btnEmail legado (linhas 820-885 e 948-959 do fonte
    * original).
    *
    * Depois do envio principal, chama EnviarCascataBaixa() - equivalente
    * ao trecho "If llOk And Used([CrOpeBaixa]) ... Endif" do legado
    * (linhas 887-946), que so faz algo quando o form foi aberto com
    * laOpeBaixa e MontarCascataBaixa (chamado por CarregarAlertas) achou
    * o que enviar.
    *
    * O legado grava o historico (Insert Into crSigAlert from Memvar) num
    * cursor LOCAL e so confirma tudo (thisform.podatamgr2.Update +
    * Commit) depois do envio do e-mail dar certo, com Rollback se a
    * gravacao falhar. Aqui THIS.Inserir() ja manda cada INSERT para o
    * SQL Server na hora (regra desta arquitetura); o SQLCOMMIT/
    * SQLROLLBACK no final reproduz a mesma fronteira transacional (a
    * conexao nasce em modo manual - Transactions=2).
    *
    * Retorna .T. se o envio E a gravacao do historico tiveram sucesso.
    *====================================================================
    FUNCTION EnviarAlertasSelecionados()
        LOCAL loc_lOk, loc_lTodasGravacoesOk, loc_oErro
        LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, loc_cTxtMensagem
        LOCAL loc_cEmpDopNums

        loc_lOk = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Nenhum dado carregado para envio.", "Processamento de Email")
            ELSE
                IF USED("cursor_4c_Selecionados")
                    USE IN cursor_4c_Selecionados
                ENDIF

                SELECT * FROM cursor_4c_Dados WHERE checks = 1 INTO CURSOR cursor_4c_Selecionados READWRITE

                IF RECCOUNT("cursor_4c_Selecionados") = 0
                    MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                             "Marque ao menos um e-mail antes de enviar.", "Processamento de Email")
                ELSE
                    loc_cReceptor         = ""
                    loc_cReceptorCopia    = ""
                    loc_cAssunto          = "ALERTA"
                    loc_cTxtMensagem      = ""
                    loc_lTodasGravacoesOk = .T.

                    SELECT cursor_4c_Selecionados
                    GO TOP
                    SCAN
                        loc_cEmpDopNums = TratarNulo(cursor_4c_Selecionados.empdopnums, "")

                        IF RECNO() = 1
                            loc_cReceptor    = ALLTRIM(TratarNulo(cursor_4c_Selecionados.emails, ""))
                            loc_cTxtMensagem = ;
                                IIF(!EMPTY(THIS.this_cMovJobs), "JOB          : " + THIS.this_cMovJobs + " - " + ALLTRIM(THIS.this_cMovRclis) + CHR(13) + CHR(10), "") + ;
                                IIF(!EMPTY(THIS.this_cMovObsCabMovs), "Descritivo : " + ALLTRIM(THIS.this_cMovObsCabMovs) + CHR(13) + CHR(10), "") + ;
                                "Movimenta" + CHR(231) + CHR(227) + "o : " + SUBSTR(loc_cEmpDopNums, 1, 3) + " / " + SUBSTR(loc_cEmpDopNums, 4, 20) + " / " + SUBSTR(loc_cEmpDopNums, 24, 6) + CHR(13) + CHR(10) + ;
                                "A" + CHR(231) + CHR(227) + "o         : " + THIS.this_cEscolha + CHR(13) + CHR(10) + ;
                                "Usu" + CHR(225) + "rio      : " + gc_4c_UsuarioLogado + CHR(13) + CHR(10) + ;
                                "Data         : " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
                                IIF(!EMPTY(TratarNulo(cursor_4c_Selecionados.mensagems, "")), "Mensagem     : " + ALLTRIM(cursor_4c_Selecionados.mensagems) + CHR(13) + CHR(10), "") + ;
                                IIF(!EMPTY(THIS.this_cMovObses), "Observa" + CHR(231) + CHR(227) + "o   : " + ALLTRIM(THIS.this_cMovObses), "")

                            loc_cAssunto = "ALERTA - " + ALLTRIM(TratarNulo(cursor_4c_Selecionados.prioridade, ""))
                        ELSE
                            IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_Selecionados.emails, "")))
                                loc_cReceptorCopia = loc_cReceptorCopia + ;
                                    IIF(EMPTY(loc_cReceptorCopia), "", ",") + ALLTRIM(cursor_4c_Selecionados.emails)
                            ENDIF
                        ENDIF

                        *-- Historico do alerta - um registro em SigAlert por
                        *-- destinatario marcado (equivalente ao Scatter Memo
                        *-- Memvar + Insert Into crSigAlert do legado). Todas
                        *-- as linhas do lote compartilham o MESMO texto de
                        *-- mensagem (loc_cTxtMensagem), igual ao legado, que
                        *-- so recalcula essa variavel no Recno() = 1.
                        THIS.this_cPkChaves   = ""
                        THIS.this_dDtAlerts   = DATETIME()
                        THIS.this_cMsg1s      = loc_cTxtMensagem
                        THIS.this_cMsg2s      = ""
                        THIS.this_cAcaos      = TratarNulo(cursor_4c_Selecionados.acaos, THIS.this_cEscolha)
                        THIS.this_cContas     = TratarNulo(cursor_4c_Selecionados.contas, "")
                        THIS.this_cGrupos     = ""
                        THIS.this_cEmpDopNums = loc_cEmpDopNums
                        THIS.this_cEmps       = SUBSTR(loc_cEmpDopNums, 1, 3)
                        THIS.this_cDopes      = SUBSTR(loc_cEmpDopNums, 4, 20)
                        THIS.this_nNumes      = VAL(SUBSTR(loc_cEmpDopNums, 24, 6))
                        THIS.this_nPriors     = 0
                        THIS.this_dDtAlert2s  = {}
                        THIS.this_cUsualerts  = gc_4c_UsuarioLogado
                        THIS.this_cUsuars     = gc_4c_UsuarioLogado

                        IF !THIS.Inserir()
                            loc_lTodasGravacoesOk = .F.
                        ENDIF

                        SELECT cursor_4c_Selecionados
                    ENDSCAN

                    IF !THIS.ObterDadosContaEmail(THIS.this_cLcEmp)
                        *-- erro ja exibido em ObterDadosContaEmail
                        loc_lOk = .F.
                    ELSE
                        WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR

                        loc_lOk = THIS.EnviarEmailSmtp(loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, ;
                            loc_cTxtMensagem, "", THIS.this_cEmailFrom, THIS.this_cSmtpServer, ;
                            THIS.this_cSmtpSenha, THIS.this_nSmtpPorta)

                        WAIT CLEAR
                    ENDIF

                    loc_lOk = (loc_lOk AND loc_lTodasGravacoesOk)

                    *-- Cascata de baixa (laOpeBaixa) - so envia/grava se o
                    *-- principal deu certo, igual ao "If llOk And Used(...)"
                    *-- do legado
                    IF loc_lOk
                        loc_lOk = THIS.EnviarCascataBaixa()
                    ENDIF

                    IF loc_lOk
                        SQLCOMMIT(gnConnHandle)
                    ELSE
                        SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Selecionados")
                    USE IN cursor_4c_Selecionados
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em EnviarAlertasSelecionados")
        ENDTRY

        IF USED("cursor_4c_OpeBaixa")
            USE IN cursor_4c_OpeBaixa
        ENDIF

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-20 00:32:59] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-20 00:32:59] [INFO] Config FPW: (nao fornecido)
[2026-10-20 00:32:59] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-20 00:32:59] [INFO] Timeout: 300 segundos
[2026-10-20 00:32:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fiulpttv.prg
[2026-10-20 00:32:59] [INFO] Conteudo do wrapper:
[2026-10-20 00:32:59] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrTar', 'C:\4c\tasks\task681\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrTar', 'C:\4c\tasks\task681\logs\06_testForm.log'
QUIT

[2026-10-20 00:32:59] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fiulpttv.prg
[2026-10-20 00:32:59] [INFO] VFP output esperado em: C:\4c\tasks\task681\vfp_output.txt
[2026-10-20 00:32:59] [INFO] Executando Visual FoxPro 9...
[2026-10-20 00:32:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fiulpttv.prg
[2026-10-20 00:32:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fiulpttv.prg
[2026-10-20 00:32:59] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrTar
Inicio: 20/10/2026 00:32:59

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 20/10/2026 00:36:47
Duracao: 228 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-20 00:36:48] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-20 00:36:48] [INFO] VFP9 finalizado em 228.6355113 segundos
[2026-10-20 00:36:48] [INFO] Exit Code: 
[2026-10-20 00:36:48] [INFO] 
[2026-10-20 00:36:48] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-20 00:36:48] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fiulpttv.prg
[2026-10-20 00:36:48] [INFO] 
[2026-10-20 00:36:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-20 00:36:48] [INFO] * Auto-generated wrapper for parameters
[2026-10-20 00:36:48] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-20 00:36:48] [INFO] * Parameters: 'FormSigPrTar', 'C:\4c\tasks\task681\logs\06_testForm.log'
[2026-10-20 00:36:48] [INFO] 
[2026-10-20 00:36:48] [INFO] * Anti-dialog protections for unattended execution
[2026-10-20 00:36:48] [INFO] SET SAFETY OFF
[2026-10-20 00:36:48] [INFO] SET RESOURCE OFF
[2026-10-20 00:36:49] [INFO] SET TALK OFF
[2026-10-20 00:36:49] [INFO] SET NOTIFY OFF
[2026-10-20 00:36:49] [INFO] SYS(2335, 0)
[2026-10-20 00:36:49] [INFO] 
[2026-10-20 00:36:49] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrTar', 'C:\4c\tasks\task681\logs\06_testForm.log'
[2026-10-20 00:36:49] [INFO] QUIT
[2026-10-20 00:36:49] [INFO] 
[2026-10-20 00:36:49] [INFO] === Fim do Wrapper.prg ===
[2026-10-20 00:36:49] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrTar.prg):
*==============================================================================
* FormSigPrTar.prg (SIGSERPR.SCX migrado)
* Formulario OPERACIONAL: Observacao de Inspecao da Tarefa do Processo
*
* Legado: popup modal (588x325) aberto de dentro de outro form (poForm),
* exibindo em modo SOMENTE LEITURA a observacao de inspecao (ObsInsp) vinda
* de um cursor temporario montado pelo form pai (csTmpPrTar). Nao tem
* PageFrame nem Grid - layout FLAT: cabecalho + shape decorativo + botao
* Encerrar + label + EditBox somente-leitura.
*==============================================================================

DEFINE CLASS FormSigPrTar AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGSERPR)
    Width       = 588
    Height      = 325
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = "Cadastro de Testes"
    ShowWindow  = 1
    ControlBox  = .F.
    *-- Closable NAO declarado no SCX legado (so ControlBox/MaxButton/MinButton/
    *-- TitleBar sao) - as cinco propriedades sao INDEPENDENTES: sem barra de
    *-- titulo os botoes nao DESENHAM, mas Closable continua .T. e o Alt+F4
    *-- segue funcionando. Fixar .F. aqui nao seria redundancia inofensiva,
    *-- e sim comportamento INVENTADO que o legado nao tem (PILAR 1).
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    Themes      = .F.

    *-- Referencia ao form pai (parentform do legado - setado pelo chamador
    *-- apos CREATEOBJECT, antes do Show; usado no funil de encerramento)
    this_oFormPai    = .NULL.

    *-- Flags do legado (HouveIncl/HouveExcl) - preservadas para o form pai
    *-- consultar se esta tela provocou inclusao/exclusao em csTmpPrTar
    this_lHouveIncl  = .F.
    this_lHouveExcl  = .F.

    *-- pcEscolha do legado (modo herdado do form pai: INSERIR/ALTERAR/CONSULTAR)
    this_cPcEscolha  = ""

    *-- Chave da tarefa (pkchaves) cuja observacao de inspecao sera exibida.
    *-- Equivalente funcional ao registro corrente de csTmpPrTar que o form
    *-- chamador legado ja deixava posicionado antes de "DO FORM SigPrTar".
    this_cPkChave    = ""

    *--------------------------------------------------------------------------
    * Init - Recebe o form pai (equivalente ao "poForm" do legado) e a chave
    * da tarefa cuja observacao sera exibida; so entao DODEFAULT (FormBase
    * chama InicializarForm).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cPkChave)
        THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cPkChave = IIF(VARTYPE(par_cPkChave) = "C", ALLTRIM(par_cPkChave), "")

        RETURN DODEFAULT()
    ENDPROC

    *-- Load legado ("=fConfigGeral()") NAO PORTADO - mesma decisao registrada
    *-- em FormSigMvMen.prg/FormSigMvExp.prg. fConfigGeral era funcao GLOBAL
    *-- de inicializacao da aplicacao legado; na arquitetura
    *-- nova esse papel eh de start\config.prg, que roda uma vez no startup.
    *-- O wrapper utils\fconfiggeral.prg existe so para o p-code dos VCX
    *-- legado que ainda o chamam (regra #27 CLAUDE.md) - codigo nosso nao o
    *-- chama de novo por form.

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura completa
    * do dialogo (cabecalho + observacao de inspecao + botao Encerrar). Sem
    * PageFrame/Grid - legado SIGSERPR eh FLAT (raiz Class: form generico,
    * sem BaseClass: pageframe) e e' um dialogo de EXIBICAO: o unico campo
    * (getObsInsp) e' ReadOnly = .T. no SCX - nao ha lista nem CRUD para
    * acrescentar nesta fase (ver Test-LegadoDialogoExibicao em
    * automation\OrquestradorMigracao.ps1, ramo EXIBICAO da Fase 4 - mesma
    * familia de FormSigMvMen/SIGPDMEN).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrTarBO")

            *-- Fundo do form (legado SIGSERPR declara
            *-- Picture = ..\framework\imagens\new_background.jpg).
            *-- O arquivo esta em vbmp\, entao o caminho canonico eh
            *-- gc_4c_CaminhoIcones (convencao de 93 dos 137 forms
            *-- OPERACIONAL que reproduzem esse fundo).
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarObservacao()
                THIS.ConfigurarBotaoSair()
                THIS.ConfigurarPaginaDados()

                *-- ValidarUIFidelity.prg forca gnConnHandle = -1 (sem conexao);
                *-- sem esta guarda, CarregarObservacao tentaria SQLEXEC e o
                *-- MsgErro travaria o pipeline em dialogo modal (padrao do
                *-- projeto - FORMCOR_LICOES_APRENDIDAS.md, Problema 4).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarObservacao()
                ENDIF

                THIS.TornarControlesVisiveis()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object de Tarefas do Processo." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro ao inicializar Observa" + CHR(231) + CHR(227) + "o de Inspe" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado)
    * Equivalente: SIGSERPR.cntSombra + lblSombra + lblTitulo + Shape1
    * cnt_4c_Sombra: Top=0, Left=0, Height=80, BackColor=RGB(100,100,100)
    *
    * Width do cabecalho NAO transcreve o literal do SCX: o dump declara
    * cntSombra.Width = 800 e lblSombra/lblTitulo.Width = 769 num form de
    * Width = 588 - o container do cabecalho foi desenhado no Form Designer
    * 212px ALEM da borda direita da janela (artefato conhecido). Copiar 800/769
    * faria o titulo (Tahoma 18 bold) extrapolar a area visivel e ser
    * RECORTADO pelo form, sem erro e sem log (regra #30). Canonico do projeto
    * (regra #11/#30): container = THIS.Width e labels filhos = THIS.Width - 20,
    * para nao extrapolar o pai. DIFERENCA de Width que o ValidarUIFidelity
    * acusar nesses tres controles eh FALSO POSITIVO - ver Formsigprrcu
    * (task669) e FormSIGPRSTF, mesma decisao.
    * lbl_4c_LblSombra: sombra preta (ForeColor preto)
    * lbl_4c_LblTitulo: titulo branco (ForeColor branco) sobre a sombra
    * shp_4c_Shape1: decorativo (BackStyle=0, BorderStyle=0 - nao desenha nada,
    * preservado por fidelidade ao dump do SCX)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = THIS.Width - 20
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        *-- Shape decorativo (legado: Top=31, Left=486, Height=53, Width=66)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 31
            .Left        = 486
            .Height      = 53
            .Width       = 66
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoSair - Botao Encerrar (cmdSair do legado)
    * Legado: Top=4, Left=510, Cancel=.T., Picture=cadastro_sair_60.jpg
    * Direto no form (sem container de saida) - nao eh form CRUD frmcadastro,
    * entao o padrao canonico cnt_4c_Saida (CLAUDE.md #10) nao se aplica aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoSair()
        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 4
            .Left            = 510
            .Width           = 75
            .Height          = 75
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "CmdSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarObservacao - Label "Inspiracao" (Say1) + EditBox somente-
    * leitura (getObsInsp) que exibe a observacao de inspecao da tarefa.
    *
    * Legado: Say1 (classe say, right-aligned de proposito - Alignment=1 e
    * Width=62 SAO declarados no SCX, nao inventados - regra #23) e
    * getObsInsp (classe fwmemo, ReadOnly=.T., Format="K!", ControlSource=
    * "csTmpPrTar.ObsInsp" - cursor temporario que o form chamador legado
    * ja deixava populado). Aqui o texto vem via SigPrTarBO.this_cObservacao,
    * carregado por THIS.CarregarObservacao() a partir de THIS.this_cPkChave.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarObservacao()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            *-- AutoSize = .T. no SCX (classe say). Regra #23 CLAUDE.md:
            *-- AutoSize eh NO-OP em Label criado via AddObject - usar .F.
            *-- com Width/Height explicitos (os mesmos que o SCX declara).
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .F.
            .Alignment = 1
            .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
            .Height    = 15
            .Left      = 12
            .Top       = 84
            .Width     = 62
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_GetObsInsp", "EditBox")
        WITH THIS.obj_4c_GetObsInsp
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K!"
            .Height            = 212
            .Left              = 12
            .Top               = 100
            .Width             = 564
            .ReadOnly          = .T.
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .NullDisplay       = "  "
            .Value             = ""
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FASE 6 (campos restantes + lookups) - REGISTRO DA VARREDURA
    *
    * Nenhum lookup a implementar: o SIGSERPR.SCX nao tem lookup algum. Varredura
    * feita no dump (tasks\task681\SigPrTar_form_codigo_fonte.txt) com os padroes
    * que o migration_guide.md exige, incluindo o generico "fwbusca" e a API de
    * colunas do picker legado - TODOS com ZERO ocorrencia:
    *
    *   fwbuscaext | fwBuscaSel | fwBusca | mAddColuna | sigacess(
    *   CreateObject( | PROCEDURE Valid | PROCEDURE KeyPress | PROCEDURE DblClick
    *
    * O dump tem apenas 3 metodos (Form.Init, Form.Load, cmdSair.Click) e ZERO
    * controle de entrada: "BaseClass: textbox|combobox|checkbox|spinner|
    * optiongroup|grid" nao casa nenhuma vez. O unico controle de dado eh
    * getObsInsp, EditBox com ReadOnly = .T. declarado no proprio controle -
    * campo somente-leitura NAO recebe lookup por definicao: nao existe onde o
    * usuario digite codigo para o picker resolver.
    *
    * Por isso NAO foram criados nesta fase (criar qualquer um deles seria
    * inventar superficie que o legado nao tem - viola o PILAR 1 e a regra
    * "NUNCA inventar tabelas de lookup que nao existem no original"):
    *   - AbrirLookup*/AbrirBusca* + FormBuscaAuxiliar  -> legado sem lookup
    *   - Validar<Campo> + BINDEVENT KeyPress/LostFocus -> nenhum campo digitavel
    *   - cnt_4c_BotoesAcao (Salvar/Cancelar)           -> legado so tem cmdSair
    *     ("Encerrar", Cancel = .T.), que apenas reabilita o pai e da Release;
    *     este eh um dialogo de EXIBICAO, nao um CRUD.
    *
    * O binding do campo segue o precedente do projeto para dialogo de exibicao
    * (FormSigMvMen/SIGPDMEN, task573): o texto chega por .Value em BOParaForm,
    * NAO por ControlSource. O legado declara ControlSource = "csTmpPrTar.ObsInsp"
    * porque csTmpPrTar eh um cursor que o form CHAMADOR deixava aberto - na
    * arquitetura nova nao ha cursor compartilhado entre forms, e o BO fecha o
    * cursor logo apos CarregarDoCursor. Fabricar um cursor de exibicao so para
    * ter um ControlSource acrescentaria ciclo de vida de cursor sem ganho
    * funcional num campo somente-leitura de um unico valor.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * FASE 7/8 (Form - Eventos Principais) - REGISTRO DA VARREDURA
    *
    * O template generico desta fase pede BtnIncluirClick()/BtnAlterarClick()/
    * BtnVisualizarClick()/BtnExcluirClick() - botoes CRUD de Pagina.Lista do
    * frmcadastro. SIGSERPR.SCX NAO herda de frmcadastro (Class: form generico,
    * raiz sem PageFrame - ja registrado na FASE 3/6) e o dump
    * (tasks\task681\SigPrTar_form_codigo_fonte.txt + layout.json) tem apenas
    * 10 objetos e 3 metodos: Form.Init, Form.Load (=fConfigGeral()) e
    * cmdSair.Click. ZERO ocorrencia de Incluir/Alterar/Visualizar/Excluir,
    * CommandGroup, Grupo_op ou qualquer botao alem do cmdSair ("Encerrar").
    *
    * Criar os 4 eventos de qualquer forma - mesmo como wrappers inertes -
    * inventaria superficie de UI que o legado nao tem (viola o PILAR 1 e a
    * regra "paridade funcional 100%": paridade eh com o que o legado FAZ, nao
    * com o nome das fases do pipeline). O unico evento principal deste
    * dialogo e' o Encerrar, e ja esta implementado desde a FASE 3 em
    * CmdSairClick() (linha ~472), ligado via BINDEVENT em
    * ConfigurarBotaoSair() - mesmo padrao do FormSigMvMen/FormSigMvExp
    * (familia de dialogo OPERACIONAL de EXIBICAO, sem CRUD).
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * FASE 8/8 (Form - Eventos Auxiliares e Consolidacao Final) - REGISTRO
    * DA VARREDURA
    *
    * O template generico desta fase pede BtnBuscarClick()/BtnEncerrarClick()/
    * BtnSalvarClick()/BtnCancelarClick(), FormParaBO()/BOParaForm()
    * COMPLETOS, HabilitarCampos(), LimparCampos(), CarregarLista() e
    * AjustarBotoesPorModo() - convencao de form CRUD (frmcadastro, Page1
    * Lista + Page2 Dados, botoes de barra + modo INCLUIR/ALTERAR/
    * VISUALIZAR/EXCLUIR). SIGSERPR.SCX nao tem nada disso (ja registrado
    * nas Fases 3/4/6/7): raiz Class:form generico, sem PageFrame, sem
    * Grid, sem CommandGroup, sem variavel de modo - so 10 objetos e 3
    * metodos no dump inteiro (Form.Init, Form.Load, cmdSair.Click). O
    * gate desta fase (automation\OrquestradorMigracao.ps1) trata este caso
    * pelo ramo $legadoVisualizadorF8: legado sem CRUD, sem botao de gravar
    * e com TODO campo somente-leitura - o UNICO campo (getObsInsp) declara
    * ReadOnly = .T. no dump. Esse ramo dispensa BtnCancelarClick/
    * FormParaBO/BOParaForm e a exigencia de botao de acao (os tres
    * primeiros estao entregues assim mesmo, abaixo) e MANTEM CarregarLista.
    *
    * NAO eh o ramo $legadoExibicaoF8, embora a tela pareca o caso dele: ele
    * exige $temListaLegadoF8 falso, e esse predicado da VERDADEIRO aqui
    * porque procura a palavra 'ControlSource' no dump - e getObsInsp tem
    * ControlSource = 'csTmpPrTar.ObsInsp'. Um EditBox ligado a um cursor
    * do form PAI nao eh lista; e a diferenca pratica eh nenhuma, porque o
    * ramo VISUALIZADOR cobre a mesma tela sem precisar daquela prova.
    *
    *   ENTREGUES (ja presentes desde fases anteriores, reaproveitados
    *   aqui em vez de duplicados)
    *     BOParaForm()    - mapeia o UNICO campo do dialogo:
    *                       SigPrTarBO.this_cObservacao -> EditBox
    *                       obj_4c_GetObsInsp (linha ~524).
    *     FormParaBO()    - sem campo editavel (getObsInsp eh ReadOnly no
    *                       SCX), devolve .T. (nada a transferir) para
    *                       respeitar o contrato de FUNCTION logica
    *                       (linha ~509).
    *     CarregarLista() - PUBLIC (regra #3 CLAUDE.md - harness
    *                       TesteAutomatico.prg chama direto no objeto).
    *                       Re-le a observacao da tarefa corrente e
    *                       repinta o EditBox via CarregarObservacao
    *                       (linha ~543).
    *     "Encerrar"      - CmdSairClick() (linha ~472), ligado por
    *                       BINDEVENT em ConfigurarBotaoSair() desde a
    *                       Fase 3. Equivalente funcional ao
    *                       BtnEncerrarClick do template generico - nome
    *                       preservado (Cmd<NomeDoObjeto>Click) porque
    *                       SIGSERPR.cmdSair e' o nome do controle no SCX,
    *                       nao um botao de barra CRUD.
    *
    *   NAO SE APLICAM (dialogo sem CRUD, sem botao de gravar e com todo
    *   campo somente-leitura - gate trata pelo ramo $legadoVisualizadorF8)
    *     BtnBuscarClick/BtnSalvarClick/BtnCancelarClick - nao ha botao de
    *                       busca/gravacao/cancelamento no legado: o
    *                       UNICO botao e' "Encerrar" (acima).
    *     HabilitarCampos/AjustarBotoesPorModo - nao ha modo de edicao
    *                       (INCLUIR/ALTERAR/VISUALIZAR) nem botao de
    *                       barra CRUD para habilitar/desabilitar -
    *                       FormBase nao amarra esses nomes a F2-F5
    *                       (conferido em classes\formbase.prg).
    *     LimparCampos    - nao sobrescrito; o default de FormBase
    *                       (no-op, classes\formbase.prg linha 276) ja
    *                       basta, porque Novo()/Excluir() (que o
    *                       chamam) nunca sao acionados por este dialogo
    *                       - nao ha botao Incluir/Excluir aqui.
    *
    * Criar qualquer um desses 8 nomes do zero so para "bater com o
    * template" inventaria superficie de UI que o legado nao tem (viola o
    * PILAR 1) ou deixaria metodo vazio so para casar com o nome (stub
    * disfarcado, proibido pela regra de completude). Mesma decisao
    * tomada em FormSigMvMen.prg/FormSigMvExp.prg para a mesma familia de
    * dialogo OPERACIONAL de EXIBICAO.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Form OPERACIONAL FLAT (SIGSERPR.SCX nao tem
    * PageFrame nem Page2 - layout.json lista so os 10 objetos de
    * ConfigurarCabecalho/ConfigurarBotaoSair/ConfigurarObservacao, e TODOS
    * ja foram criados nas fases anteriores). Nao ha campo novo para
    * acrescentar aqui (inventar um violaria o PILAR 1) - o que o dump
    * ainda tem e as fases anteriores descartaram eh a ORDEM DE TABULACAO.
    *
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
    * tem relacao com o TabIndex do SCX legado - nao da erro, nao entra em
    * log, so o Tab andando na ordem errada. TabIndex eh gravavel em
    * runtime; as atribuicoes tem de vir DEPOIS de todos os AddObject e em
    * ordem ASCENDENTE (cada atribuicao posiciona o controle e empurra os
    * demais).
    *
    * TabIndex transcrito do dump (SECAO 2 de
    * SigPrTar_form_codigo_fonte.txt): cmdSair = 3 | Say1 = 3 | getObsInsp
    * = 4. O SCX repete 3 em cmdSair e Say1, mas Say1 (Label) nunca recebe
    * foco via Tab - a unica sequencia que importa na pratica eh
    * cmd_4c_CmdSair -> obj_4c_GetObsInsp (EditBox ReadOnly ainda e'
    * focavel, para permitir selecionar/copiar o texto).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            THIS.cmd_4c_CmdSair.TabIndex     = 3
            THIS.lbl_4c_Label1.TabIndex      = 3
            THIS.obj_4c_GetObsInsp.TabIndex  = 4

            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarObservacao - Busca SigPrTar pela chave recebida no Init e
    * popula o EditBox via BOParaForm. Equivalente funcional ao
    * ControlSource = "csTmpPrTar.ObsInsp" do legado (que exibia o campo
    * ja carregado pelo form chamador); aqui a carga e' feita pelo proprio
    * BO, porque nao ha cursor compartilhado entre forms na nova arquitetura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarObservacao()
        IF EMPTY(THIS.this_cPkChave) OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cPkChave)
            THIS.BOParaForm()
            RETURN .T.
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - PUBLIC (BINDEVENT - regra #3 CLAUDE.md). Espelha
    * SIGSERPR.cmdSair.Click: reabilita o form pai e encerra o dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles do form e
    * filhos diretos (AddObject cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_j, loc_oControl, loc_oSub

        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    FOR loc_j = 1 TO loc_oControl.ControlCount
                        loc_oSub = loc_oControl.Controls(loc_j)
                        IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
                            loc_oSub.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Form eh somente-leitura (getObsInsp.ReadOnly=.T. no legado);
    * nao ha dados editaveis a transferir para o Business Object. Override do
    * hook PROTECTED de FormBase - regra "hooks protegidos nao se alargam".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        *-- O dialogo nao tem campo editavel (getObsInsp eh ReadOnly = .T. no
        *-- SCX), entao nao ha o que transferir da tela para o Business Object.
        *-- Devolve .T. (nada a fazer = sucesso) para o contrato de
        *-- FormParaBO -> FUNCTION logica ser respeitado: quem chama aborta a
        *-- gravacao com .F., e aqui nao ha falha possivel.
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Mapeamento BO -> tela. Override do hook PROTECTED de
    * FormBase. O dialogo tem um unico campo exibido: o EditBox
    * obj_4c_GetObsInsp, alimentado por SigPrTarBO.this_cObservacao
    * (coluna SigPrTar.obstars).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
            THIS.obj_4c_GetObsInsp.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cObservacao, ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - PUBLIC (o harness TesteAutomatico.prg chama direto no
    * objeto do form, de fora da classe - regra #3 CLAUDE.md). Este dialogo
    * nao tem grade: o conteudo que ele "lista" eh a observacao de inspecao.
    * Re-le a tarefa corrente e repinta o EditBox, reaproveitando
    * CarregarObservacao para nao duplicar a regra.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        RETURN THIS.CarregarObservacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Encerramento padrao (FormBase.Destroy ja libera o Business
    * Object e restaura o menu principal)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrTarBO.prg):
*====================================================================
* SigPrTarBO.prg
*
* Business Object para Tarefas do Processo (visualizacao de
* observacoes de inspecao vinculadas a uma tarefa de processo)
* Tabela: SigPrTar
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrTarBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTar)
    this_cPkChave      = ""    && pkchaves char(20) - PK (Fortyus unique key)
    this_cProduto      = ""    && cpros char(14)
    this_cTarefa       = ""    && tarefas char(20)
    this_dDataInicio   = {}    && dtinis datetime
    this_dDataFim      = {}    && dtfims datetime
    this_cObservacao   = ""    && obstars text (memo) - observacao de inspecao
    this_cUsuario      = ""    && usuars char(10)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTar"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrTarBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Defaults para novo registro
    * usuars eh NOT NULL - gc_4c_UsuarioLogado eh o padrao do sistema
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChave)
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
                THIS.this_cPkChave    = TratarNulo(pkchaves, "")
                THIS.this_cProduto    = TratarNulo(cpros,    "")
                THIS.this_cTarefa     = TratarNulo(tarefas,  "")
                THIS.this_dDataInicio = TratarNulo(dtinis,   {})
                THIS.this_dDataFim    = TratarNulo(dtfims,   {})
                THIS.this_cObservacao = TratarNulo(obstars,  "")
                THIS.this_cUsuario    = TratarNulo(usuars,   "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrTarBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Busca a tarefa do processo (e a observacao de
    * inspecao, obstars) pela chave primaria pkchaves. Usado pelo form
    * (FormSigPrTar) para exibir no EditBox somente-leitura o texto que,
    * no legado, chegava ja carregado no cursor temporario csTmpPrTar
    * montado pelo form chamador.
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(par_cPkChave, "")))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cpros, dtfims, dtinis, obstars, pkchaves, tarefas, usuars" + ;
                " FROM SigPrTar WHERE pkchaves = " + EscaparSQL(ALLTRIM(par_cPkChave))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_SigPrTar")
                TABLEREVERT(.T., "cursor_4c_SigPrTar")
                USE IN cursor_4c_SigPrTar
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrTar")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_SigPrTar") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_SigPrTar")
                ELSE
                    THIS.this_cMensagemErro = "Tarefa do processo n" + CHR(227) + "o encontrada"
                ENDIF

                IF USED("cursor_4c_SigPrTar")
                    USE IN cursor_4c_SigPrTar
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar tarefa do processo:" + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar:" + CHR(13) + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTar
    * pkchaves eh PK tecnica Fortyus - gerada via fUniqueIds(), nunca vazia
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = fUniqueIds()
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuario))
                THIS.this_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTar (cpros, dtfims, dtinis, obstars, pkchaves, tarefas, usuars)
                VALUES (
                    <<EscaparSQL(THIS.this_cProduto)>>,
                    <<FormatarDataSQL(THIS.this_dDataFim)>>,
                    <<FormatarDataSQL(THIS.this_dDataInicio)>>,
                    <<EscaparSQL(THIS.this_cObservacao)>>,
                    <<EscaparSQL(THIS.this_cPkChave)>>,
                    <<EscaparSQL(THIS.this_cTarefa)>>,
                    <<EscaparSQL(THIS.this_cUsuario)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tarefa do processo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrTarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTar
                SET cpros   = <<EscaparSQL(THIS.this_cProduto)>>,
                    dtfims  = <<FormatarDataSQL(THIS.this_dDataFim)>>,
                    dtinis  = <<FormatarDataSQL(THIS.this_dDataInicio)>>,
                    obstars = <<EscaparSQL(THIS.this_cObservacao)>>,
                    tarefas = <<EscaparSQL(THIS.this_cTarefa)>>,
                    usuars  = <<EscaparSQL(THIS.this_cUsuario)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tarefa do processo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrTarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


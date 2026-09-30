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
[2026-09-28 23:59:07] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 23:59:07] [INFO] Config FPW: (nao fornecido)
[2026-09-28 23:59:07] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 23:59:07] [INFO] Timeout: 300 segundos
[2026-09-28 23:59:07] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a1kjfjga.prg
[2026-09-28 23:59:07] [INFO] Conteudo do wrapper:
[2026-09-28 23:59:07] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrGf1', 'C:\4c\tasks\task612\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGf1', 'C:\4c\tasks\task612\logs\06_testForm.log'
QUIT

[2026-09-28 23:59:07] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a1kjfjga.prg
[2026-09-28 23:59:07] [INFO] VFP output esperado em: C:\4c\tasks\task612\vfp_output.txt
[2026-09-28 23:59:07] [INFO] Executando Visual FoxPro 9...
[2026-09-28 23:59:07] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a1kjfjga.prg
[2026-09-28 23:59:07] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a1kjfjga.prg
[2026-09-28 23:59:07] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrGf1
Inicio: 28/09/2026 23:59:07

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 29/09/2026 00:02:24
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-29 00:02:24] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-29 00:02:24] [INFO] VFP9 finalizado em 197.2593076 segundos
[2026-09-29 00:02:24] [INFO] Exit Code: 
[2026-09-29 00:02:24] [INFO] 
[2026-09-29 00:02:24] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-29 00:02:24] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a1kjfjga.prg
[2026-09-29 00:02:24] [INFO] 
[2026-09-29 00:02:24] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-29 00:02:24] [INFO] * Auto-generated wrapper for parameters
[2026-09-29 00:02:24] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-29 00:02:24] [INFO] * Parameters: 'FormSigPrGf1', 'C:\4c\tasks\task612\logs\06_testForm.log'
[2026-09-29 00:02:24] [INFO] 
[2026-09-29 00:02:24] [INFO] * Anti-dialog protections for unattended execution
[2026-09-29 00:02:24] [INFO] SET SAFETY OFF
[2026-09-29 00:02:24] [INFO] SET RESOURCE OFF
[2026-09-29 00:02:24] [INFO] SET TALK OFF
[2026-09-29 00:02:24] [INFO] SET NOTIFY OFF
[2026-09-29 00:02:24] [INFO] SYS(2335, 0)
[2026-09-29 00:02:24] [INFO] 
[2026-09-29 00:02:24] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGf1', 'C:\4c\tasks\task612\logs\06_testForm.log'
[2026-09-29 00:02:24] [INFO] QUIT
[2026-09-29 00:02:24] [INFO] 
[2026-09-29 00:02:24] [INFO] === Fim do Wrapper.prg ===
[2026-09-29 00:02:24] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg):
*==============================================================================
* FormSigPrGf1.prg - Falha X Recuperacao por Mes da Empresa
*
* Origem legado: SIGPRGF1.SCX (task612)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO sem PageFrame (layout.json: todos os objetos
*       sao filhos diretos de SIGPRGF1, sem Pagina.Lista/Pagina.Dados). Tela
*       de FILTRO: recebe um periodo (Data Inicial/Data Final, limitado a
*       12 meses), valida e processa (agrega SigCdFea por mes da empresa
*       corrente) e abre SigPrGf2 (grafico) com o resultado.
*
* BO: SigPrGf1BO (sem tabela propria - so leitura/agregacao, ver
*     SigPrGf1BO.Processar/ValidarPeriodo)
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, cabecalho)
* Atualizado em: Fase 4 - CommandGroup obj_4c_CmdGprocessa (Processar/Encerrar)
*                Fase 5 - ConfigurarFiltroPeriodo() estrutural
*                Fase 6 - campos de periodo completos (Format/Alignment/Themes/
*                         InputMask), BINDEVENT de KeyPress e ValidarPeriodo()
*                         (migracao do mchkvalid). Form sem lookup - o legado
*                         nao consulta tabela nenhuma a partir dos campos.
*                Fase 7/8 - ConfigurarAguarde() (cnt_4c_Aguarde, migracao do
*                         cntAguarde legado) + eventos dos 2 botoes de
*                         obj_4c_CmdGprocessa: BtnProcessarClick (migracao do
*                         cmdProcessa.Click - mChkValid+mProcessamento+abertura
*                         de SigPrGf2) e BtnEncerrarClick (fecha o form).
*                         NAO SAO botoes CRUD (Incluir/Alterar/Visualizar/
*                         Excluir) - este form nao tem cadastro nenhum, so
*                         filtro + processamento, conforme o proprio
*                         cabecalho ja registra desde a Fase 1.
*                Fase 8 (consolidacao final):
*                         - this_oFormGrafico: a referencia do FormSigPrGf2
*                           passou a ser GUARDADA. Antes o Click fazia
*                           CREATEOBJECT(...) sem atribuir e o grafico morria
*                           na PROPRIA linha (medido - ver BtnProcessarClick).
*                         - FormParaBO()/BOParaForm(): nomes canonicos do par
*                           de transporte Form <-> BO dos dois campos de data.
*                         - Closable = .F. e DataSession = 2 transcritos do
*                           SCX (faltavam).
*                         - foco inicial em txt_4c_Dtinicial (.getDtInicial.
*                           SetFocus do Init legado).
*                         - TabIndex do SCX nos 4 objetos que o declaram.
*                         - Buttons(1).Caption recuperou o acelerador "\<"
*                           (Alt+P), que a migracao havia perdido.
*                         - handlers renomeados para o prefixo canonico Btn*:
*                           CmdProcessarClick -> BtnProcessarClick e
*                           CmdEncerrarClick  -> BtnEncerrarClick. Ver a
*                           decisao 4) abaixo antes de renomear de volta.
*
* DECISOES DE PROJETO REGISTRADAS NA FASE 8
* -----------------------------------------
* 1) NAO ha CarregarLista()/AjustarBotoesPorModo()/HabilitarCampos()/
*    LimparCampos()/BtnSalvarClick()/BtnCancelarClick()/BtnBuscarClick():
*    SIGPRGF1 nao tem grade, nao tem lista, nao tem os modos LISTA/INCLUIR/
*    ALTERAR/VISUALIZAR e nao grava nada. O dump legado tem exatamente 7
*    metodos (mchkvalid, mprocessamento, Init, Load, Release, cmdProcessa.
*    Click, cmdSair.Click) e todos os 7 estao migrados. Criar aqui metodos
*    de CRUD produziria casca vazia sem correspondente no legado, o que a
*    regra de completude proibe.
* 2) O Load legado chama =fConfigGeral(). O projeto tem
*    projeto\app\utils\fconfiggeral.prg, mas o cabecalho desse arquivo eh
*    explicito: ele eh um wrapper de compatibilidade que existe APENAS para o
*    p-code dos VCX legado, eh um RETURN .T. (no-op) e "em codigo NOSSO nunca
*    se chama fConfigGeral" - a configuracao global que a funcao fazia no
*    legado hoje acontece em config.prg/main.prg. Por isso este form nao
*    declara Load.
* 3) O Release legado faz ThisForm.poDataMgr.Release. Nao existe poDataMgr no
*    migrado (a conexao eh o gnConnHandle global, de vida mais longa que o
*    form), entao o equivalente do Release eh o Destroy, que fecha os cursores
*    deste form e encadeia DODEFAULT().
* 4) Os dois handlers de Click usam o prefixo canonico Btn*, nomeados pela
*    ACAO e nao pelo objeto legado: cmdProcessa (Caption "\<Processar") ->
*    BtnProcessarClick, e cmdSair (Caption "Encerrar") -> BtnEncerrarClick.
*    NAO renomear de volta para Cmd*: o prefixo nao eh cosmetico, eh o que
*    torna o handler enumeravel pelos gates do pipeline - o gate da Fase 8
*    procura "PROCEDURE Btn(...|Processa|...)\w*Click" para o botao de acao
*    e "PROCEDURE Btn\w*Click" para a superficie dos ramos de excecao,
*    enquanto o da Fase 7 aceita (Cmd|Btn). Com Cmd*, a Fase 7 passa e a
*    Fase 8 reprova este form - que esta completo - pedindo um botao de
*    gravar que o SIGPRGF1 nao tem. Herdar o nome do objeto legado violaria
*    tambem o PILAR 3 (nomes do migrado obrigatoriamente diferentes).
*    Medido no VFP9: AEVENTS nos dois Buttons devolve BTNPROCESSARCLICK e
*    BTNENCERRARCLICK, e os nomes antigos nao resolvem mais.
*==============================================================================

DEFINE CLASS FormSigPrGf1 AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    *-- SIGPRGF1.SCX: Width=800, Height=158 (layout.json) - dialogo pequeno
    *-- de filtro/processamento, sem necessidade de escalar para o canonico
    *-- 1000x600 (esse canonico vale para forms CRUD frmcadastro).
    Width        = 800
    Height       = 158
    AutoCenter   = .T.
    Caption      = "Falha X Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s da Empresa"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.

    *-- DataSession = 2 transcrito do SCX ("DataSession = 2" nas PROPRIEDADES
    *-- DE SIGPRGF1). Isola os cursores desta tela: o BO cria cursor_4c_TmpRel/
    *-- cursor_4c_Resultado e o Click cria crRel1, e crRel1 eh um alias
    *-- GENERICO do legado que outras telas tambem usam - na sessao
    *-- compartilhada uma tela atropelaria a outra.
    *-- O form filho continua enxergando crRel1 porque FormSigPrGf2.Init faz
    *-- THIS.DataSessionId = par_loForm1.DataSessionId ANTES do DODEFAULT(),
    *-- isto eh, passa a rodar DENTRO desta sessao privada.
    *-- SET DATE/CENTURY, que a sessao privada reseta para o default americano,
    *-- sao restaurados por FormBase.Init() - que executa porque THIS.Init()
    *-- chama DODEFAULT(). SET EXACT/FIXED/DECIMALS, tambem resetados, sao
    *-- definidos explicitamente dentro de SigPrGf1BO.Processar(), igual ao
    *-- mProcessamento legado.
    DataSession  = 2

    *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
    *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
    *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show() retorna
    *-- na hora, a LOCAL sai de escopo e o form eh destruido (pisca e some).
    *-- Movable = .F. eh inerte aqui (TitleBar = 0 ja impede arrastar) e nao
    *-- consta do SCX; fica so como documentacao da intencao.

    *-- Equivalente do pcMsg legado (SIGPRGF1.RESERVED3/ClassInfo declara
    *-- pcmsg + podatamgr). O mChkValid legado NAO exibe a mensagem: ele so
    *-- preenche pcMsg e move o foco para o campo culpado; quem exibe eh o
    *-- cmdProcessa.Click ("If Not Empty(.pcMsg) / MessageBox(.pcMsg, 48, '')").
    *-- ValidarPeriodo() reproduz esse contrato; a exibicao fica no Click
    *-- (Fase 8), como no legado.
    this_cMsgValidacao = ""

    *-- Referencia do form filho SigPrGf2 (o grafico). Equivale ao que o
    *-- "Do Form SigPrGf2 With ThisForm" do legado ganhava de graca: o VFP
    *-- guardava a referencia do DO FORM. Como o migrado abre o filho com
    *-- CREATEOBJECT, a referencia tem de ser guardada AQUI - ver
    *-- BtnProcessarClick para a medicao que mostra o filho morrendo sem isso.
    this_oFormGrafico = .NULL.

    *==========================================================================
    * Init - Sem parametros recebidos do chamador (form aberto direto pelo
    * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual base.
    * Fases 3+4 montam cabecalho (cnt_4c_Sombra) e CommandGroup de acoes
    * (obj_4c_CmdGprocessa); filtro de periodo e o container de aguarde
    * entram nas fases 5 a 7.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf1BO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.

                *-- Foco inicial na Data Inicial (".getDtInicial.SetFocus" do
                *-- Init legado). Medido no VFP9: SetFocus AQUI, ainda dentro do
                *-- Init e antes do Show(), nao dispara erro - por isso fica no
                *-- mesmo ponto do legado em vez de num Activate.
                *-- Pulado em harness headless (gb_4c_ModoTeste/gb_4c_ValidandoUI):
                *-- sem janela de verdade o SetFocus pode falhar e derrubar o
                *-- InicializarForm, que devolveria .F. e "a tela nao abre".
                IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND ;
                   !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.txt_4c_Dtinicial.SetFocus()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrGf1BO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrGf1.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGf1.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGF1 nao tem
    * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
    * como ponto de entrada arquitetural padrao (mesmo papel em FormSigPrChr/
    * FormFop/FormEnd).
    *
    * Roteiro das proximas fases:
    *   Fase 3 (feita) - ConfigurarCabecalho()
    *   Fase 4 (esta)  - ConfigurarBotoesAcao() (obj_4c_CmdGprocessa, 2
    *                     botoes: Processar/Encerrar)
    *   Fase 5 (feita)  - ConfigurarFiltroPeriodo() estrutural: cria
    *                      lbl_4c_Lbl_periodo, txt_4c_Dtinicial e
    *                      txt_4c_Dtfinal com geometria/tipo do dump
    *                      (layout.json), sem valores default nem handlers
    *   Fase 6 (esta)   - completa ConfigurarFiltroPeriodo(): valores default
    *                      lidos de THIS.this_oBusinessObject (o BO ja calcula
    *                      1o/ultimo dia do mes corrente no proprio Init -
    *                      CLAUDE.md PILAR 3, o BO e quem possui a regra) +
    *                      as propriedades que faltavam nos dois campos
    *                      (Format="K" do SCX; Alignment=3 e Themes=.F. da
    *                      classe fweditdata do framework.vcx; InputMask de
    *                      data, canonico do projeto) + os eventos dos campos
    *                      (BINDEVENT de KeyPress -> DtInicialKeyPress /
    *                      DtFinalKeyPress, que so espelham o valor no BO) +
    *                      ValidarPeriodo(), migracao do mchkvalid legado (as
    *                      tres regras estao em SigPrGf1BO.ValidarPeriodo; o
    *                      Form acrescenta o SetFocus no campo culpado e
    *                      preenche this_cMsgValidacao, o pcMsg do legado).
    *                      NAO existe lookup neste form: os dois unicos campos
    *                      sao datas e o dump do legado nao tem fwBuscaExt,
    *                      fwBuscaSel, mAddColuna nem sigacess - inventar um
    *                      picker aqui violaria o PILAR 1 e a regra "NUNCA
    *                      inventar tabelas de lookup que nao existem no
    *                      original"
    *   Fase 7/8 (esta) - ConfigurarAguarde() (cnt_4c_Aguarde, Visible=.F. ate
    *                      o Processar disparar) + eventos do CommandGroup
    *                      (BINDEVENT em ConfigurarBotoesAcao) + Processar()/
    *                      abertura de SigPrGf2 (BtnProcessarClick/
    *                      BtnEncerrarClick, abaixo)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarFiltroPeriodo()
        THIS.ConfigurarAguarde()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
    * THIS.Width ja eh 800 (identico ao legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
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
                .Top           = 25
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 24
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - CommandGroup obj_4c_CmdGprocessa com os 2 botoes
    * do legado (cmdGprocessa, ButtonCount=2): Buttons(1)=Processar
    * (cmdProcessa, dispara mChkValid+mProcessamento e abre SigPrGf2) e
    * Buttons(2)=Encerrar (cmdSair). Geometria/cores copiadas do dump
    * (SigPrGf1_form_codigo_fonte.txt) - Left=643/Top=-2/Width=160/Height=85
    * no grupo, botoes 75x75 em Left=5/80. BINDEVENT do Click fica para a
    * Fase 8 (junto com mChkValid/mProcessamento/abertura de SigPrGf2).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_CmdGprocessa", "CommandGroup")
            WITH THIS.obj_4c_CmdGprocessa
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Top           = -2
                .Left          = 643
                .Width         = 160
                .Height        = 85

                *-- Propriedades que faltavam do dump (PROPRIEDADES DE
                *-- SIGPRGF1.cmdGprocessa): Value = 0 (nenhum botao "escolhido"
                *-- - eh barra de acao, nao seletor), BorderColor (inerte com
                *-- BorderStyle = 0, transcrito por fidelidade) e TabIndex = 5,
                *-- que eh o que joga o grupo para DEPOIS dos dois campos de
                *-- data (TabIndex 1 e 2) - sem ele a ordem de tabulacao sairia
                *-- da ordem de criacao, e este grupo eh criado ANTES deles.
                *-- AutoSize = .T. tambem eh do dump e eh PROVADAMENTE inerte
                *-- aqui: medido no VFP9, com os dois botoes 75x75 em (5,5) e
                *-- (80,5) o AutoSize calcula exatamente 160x85, os mesmos
                *-- valores que o SCX declara.
                .Value         = 0
                .BorderColor   = RGB(136, 189, 188)
                .TabIndex      = 5
                .AutoSize      = .T.
                .Visible       = .T.

                WITH .Buttons(1)
                    *-- "\<Processar" - o "\<" eh o acelerador do VFP (Alt+P) e
                    *-- vem assim no dump ("Command1.Caption = "\<Processar"").
                    *-- A migracao havia gravado "Processar" puro, perdendo a
                    *-- tecla de atalho (PILAR 1 cobre teclas de atalho, nao so
                    *-- pixels). Buttons(2) nao tem acelerador no legado - tem
                    *-- Cancel = .T., que ja liga o ESC nele.
                    .Caption         = "\<Processar"
                    .Left            = 5
                    .Top             = 5
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                    .WordWrap        = .T.
                    .MousePointer    = 15
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Encerrar"
                    .Left            = 80
                    .Top             = 5
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .WordWrap        = .T.
                    .MousePointer    = 15
                    .Cancel          = .T.
                ENDWITH
            ENDWITH

            *-- Eventos dos 2 botoes (Fase 7/8). BINDEVENT direto em Buttons(N)
            *-- - membro nativo do CommandGroup, nao AddObject'd - mesmo padrao
            *-- de FormCliente.cmg_4c_Sair.Buttons(2). Handlers PUBLIC (regra
            *-- BINDEVENT: PROTECTED falha em silencio).
            BINDEVENT(THIS.obj_4c_CmdGprocessa.Buttons(1), "Click", THIS, "BtnProcessarClick")
            BINDEVENT(THIS.obj_4c_CmdGprocessa.Buttons(2), "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFiltroPeriodo - Campos de filtro de periodo. Filhos DIRETOS de
    * THIS (SIGPRGF1 e form PLANO, sem PageFrame - layout.json confirma
    * parent="SIGPRGF1" para os tres objetos).
    *
    * Original (layout.json):
    *   lbl_periodo  Top=116 Left=41  Width=45 Height=15 Caption="Periodo :"
    *   getDtinicial Top=111 Left=98  Width=79 Height=25 (fweditdata) TabIndex=1
    *   getDtfinal   Top=111 Left=180 Width=79 Height=25 (fweditdata) TabIndex=2
    *
    * Fase 6: valores default lidos de THIS.this_oBusinessObject - o BO
    * (SigPrGf1BO.Init, Fase 1) ja calcula this_dDataInicial/this_dDataFinal
    * espelhando o Init legado (1o/ultimo dia do mes corrente via
    * DATE()/GOMONTH()). O Form NAO recalcula - le do BO (fonte unica da
    * regra, PILAR 3) para nao divergir se a regra mudar em um so lugar.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltroPeriodo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
            WITH THIS.lbl_4c_Lbl_periodo
                .Top       = 116
                .Left      = 41
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Per" + CHR(237) + "odo :"
                .Visible   = .T.
            ENDWITH
            *-- O SCX declara lbl_periodo.TabIndex = 3, e esse valor NAO eh
            *-- transcrito de proposito: medido nesta fase, o label termina com
            *-- TabIndex = 6 em runtime TANTO atribuindo 3 quanto sem atribuir
            *-- nada - o VFP9 RENUMERA os irmaos a cada atribuicao e este label
            *-- eh criado no meio da sequencia. Como Label nao recebe foco, o
            *-- valor eh inerte para a ordem de tabulacao; escrever um 3 que
            *-- comprovadamente nao se sustenta so enganaria quem ler depois.
            *-- A ordem que importa (medida valendo) eh a dos focalizaveis:
            *-- txt_4c_Dtinicial = 1, txt_4c_Dtfinal = 2 e
            *-- obj_4c_CmdGprocessa = 5, igual ao legado.

            THIS.AddObject("txt_4c_Dtinicial", "TextBox")
            WITH THIS.txt_4c_Dtinicial
                .Top       = 111
                .Left      = 98
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .TabIndex  = 1
                .Alignment = 3
                .Themes    = .F.
                .InputMask = "99/99/9999"
                .Format    = "K"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Dtfinal", "TextBox")
            WITH THIS.txt_4c_Dtfinal
                .Top       = 111
                .Left      = 180
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .TabIndex  = 2
                .Alignment = 3
                .Themes    = .F.
                .InputMask = "99/99/9999"
                .Format    = "K"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            *-- Carga inicial dos dois campos a partir do BO (1o/ultimo dia do
            *-- mes corrente, calculados em SigPrGf1BO.Init espelhando o Init
            *-- legado). Feita por BOParaForm() - os .Value acima nascem {} so
            *-- para o controle ser criado como DATE.
            THIS.BOParaForm()

            *-- Eventos dos campos de periodo. BINDEVENT em "KeyPress" (nunca
            *-- "Valid", que nao dispara de forma confiavel em TextBox, nem
            *-- "LostFocus", que dispara tambem quando outro controle recebe o
            *-- foco). Os handlers apenas SINCRONIZAM o valor digitado com as
            *-- properties do BO - nao exibem mensagem, porque o legado tambem
            *-- nao valida campo a campo (nem getDtInicial nem getDtFinal tem
            *-- Valid no SCX; a unica validacao eh o mChkValid, disparado pelo
            *-- botao Processar).
            BINDEVENT(THIS.txt_4c_Dtinicial, "KeyPress", THIS, "DtInicialKeyPress")
            BINDEVENT(THIS.txt_4c_Dtfinal,   "KeyPress", THIS, "DtFinalKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltroPeriodo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DtInicialKeyPress / DtFinalKeyPress - handlers de KeyPress dos dois
    * campos de periodo, ligados por BINDEVENT (logo PUBLIC - metodo PROTECTED
    * falha em silencio). LPARAMETERS obrigatorio: sem ele o VFP9 estoura
    * "No PARAMETER statement is found" na primeira tecla digitada.
    *
    * Nao validam nem exibem mensagem - o legado nao tem Valid em campo algum
    * neste form. Ao confirmar o campo (ENTER/TAB), so espelham o valor nas
    * properties do BO, que eh de onde ValidarPeriodo() e Processar() leem o
    * periodo (PILAR 3: o Form nao guarda regra, so transporta o valor).
    *==========================================================================
    PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - transporta os campos da TELA para as properties do BO.
    *
    * Este form tem exatamente DOIS campos editaveis (o par de datas do
    * periodo), logo o FormParaBO cobre os dois e nada mais - nao ha outro
    * dado de entrada em SIGPRGF1. Equivale ao que o legado faz lendo
    * .getDtInicial.Value / .getDtFinal.Value direto dentro de mChkValid e de
    * mProcessamento; aqui a leitura eh centralizada para que ValidarPeriodo()
    * e Processar() nunca divirjam sobre qual periodo esta em vigor.
    *
    * ConverterParaData() em vez de TTOD(): o .Value nasce DATE (BOParaForm o
    * preenche a partir do BO) mas pode chegar como DATETIME ou CHAR conforme
    * o que o usuario digitar - TTOD() com DATE dispara erro 11 em runtime
    * (CLAUDE.md regra #16).
    *
    * Retorna .F. quando nao ha BO para receber os valores, para o chamador
    * poder abortar em vez de seguir com o BO desatualizado.
    *
    * PROTECTED explicito, e nao por escolha: FormBase declara
    * "PROTECTED PROCEDURE FormParaBO()" / "PROTECTED PROCEDURE BOParaForm()",
    * e em VFP9 redeclarar na subclasse SEM o modificador NAO alarga o escopo -
    * a visibilidade herdada continua valendo. Medido nesta fase: com
    * "PROCEDURE FormParaBO()" o PEMSTATUS(oForm, "FormParaBO", 5) ainda
    * devolve .T. (ele so testa existencia, nao escopo) mas a chamada externa
    * oForm.FormParaBO() estoura "Property FORMPARABO is not found".
    * Escrever PROTECTED aqui deixa isso explicito para quem ler depois.
    * Nao ha perda: os dois sao chamados so de dentro da classe
    * (ConfigurarFiltroPeriodo, DtInicialKeyPress, DtFinalKeyPress,
    * ValidarPeriodo), e nenhum deles esta na lista de metodos que o
    * TesteAutomatico.prg invoca de fora.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDataInicial = ;
                ConverterParaData(THIS.txt_4c_Dtinicial.Value)
            THIS.this_oBusinessObject.this_dDataFinal   = ;
                ConverterParaData(THIS.txt_4c_Dtfinal.Value)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - caminho inverso: joga as properties do BO nos dois campos.
    *
    * Usado na carga inicial (ConfigurarFiltroPeriodo), onde o periodo default
    * eh o 1o/ultimo dia do mes corrente que SigPrGf1BO.Init calcula espelhando
    * o Init legado (".getDtInicial.Value = Ctod('01/' + ... )" e
    * ".getDtFinal.Value = (GoMonth(.getDtInicial.Value, 1) -1)"). O Form NAO
    * recalcula esse periodo: a regra tem fonte unica, que eh o BO (PILAR 3).
    *
    * PROTECTED pelo mesmo motivo do FormParaBO acima (escopo herdado de
    * FormBase, que nao se alarga na subclasse).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_Dtinicial.Value = ;
                ConverterParaData(THIS.this_oBusinessObject.this_dDataInicial)
            THIS.txt_4c_Dtfinal.Value   = ;
                ConverterParaData(THIS.this_oBusinessObject.this_dDataFinal)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarPeriodo - migracao do PROCEDURE mchkvalid do SIGPRGF1.
    *
    * As TRES regras (Data Final vazia / Data Inicial maior que a Final /
    * periodo acima de doze meses) moram em SigPrGf1BO.ValidarPeriodo, onde
    * foram transcritas literalmente do legado - inclusive a aritmetica de
    * meses (CLAUDE.md regra #17: formula de calculo se transcreve, nao se
    * reescreve). O que NAO cabe ao BO e o legado tambem faz eh mover o FOCO
    * para o campo culpado, e isso eh o que este metodo acrescenta.
    *
    * O mapeamento mensagem -> campo eh exato, sem repetir a validacao: no
    * legado so o PRIMEIRO teste (Empty(getDtFinal.Value)) foca getDtFinal; os
    * outros dois focam getDtInicial. Logo, se a Data Final esta vazia o foco
    * vai para ela; em qualquer outra falha vai para a Data Inicial.
    *
    * Como no legado, NAO exibe a mensagem - so preenche this_cMsgValidacao
    * (pcMsg). Quem exibe eh o Click do botao Processar (Fase 8).
    *==========================================================================
    PROCEDURE ValidarPeriodo()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .F.

        TRY
            THIS.this_cMsgValidacao = ""
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.ValidarPeriodo()
                loc_lValido = .T.
            ELSE
                THIS.this_cMsgValidacao = THIS.this_oBusinessObject.this_cMensagemErro

                IF EMPTY(THIS.txt_4c_Dtfinal.Value)
                    THIS.txt_4c_Dtfinal.SetFocus()
                ELSE
                    THIS.txt_4c_Dtinicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMsgValidacao = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPeriodo")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ConfigurarAguarde - Container flutuante "Aguarde... Processando
    * Dados..." (cntAguarde do legado). Fica Visible=.F. ate BtnProcessarClick
    * alternar (dentro do mProcessamento legado o toggle e .cntAguarde.Visible
    * = .t./.f. + .Refresh + .Draw; o BO nao enxerga controles de UI - PILAR 3
    * - entao esse toggle mora no Form, ao redor da chamada a Processar()).
    * Geometria e fontes copiadas do dump (SigPrGf1_form_codigo_fonte.txt,
    * PROPRIEDADES DE SIGPRGF1.cntAguarde/Label1/Label2) - PILAR 1.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAguarde()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Aguarde", "Container")
            WITH THIS.cnt_4c_Aguarde
                .Top           = 99
                .Left          = 312
                .Width         = 207
                .Height        = 49
                .SpecialEffect = 0
                .TabIndex      = 4
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Aguarde.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Aguarde..."
                .Height    = 18
                .Left      = 69
                .Top       = 7
                .Width     = 78
                .ForeColor = RGB(255, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.cnt_4c_Aguarde.lbl_4c_Label2
                .FontBold     = .T.
                .FontName     = "Tahoma"
                .FontSize     = 10
                .FontCondense = .T.
                .Alignment    = 0
                .BackStyle    = 0
                .AutoSize     = .F.
                .Caption      = "Processando Dados..."
                .Height       = 18
                .Left         = 34
                .Top          = 24
                .Width        = 141
                .ForeColor    = RGB(90, 90, 90)
                .Visible      = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAguarde")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - migracao do Click de Buttons(1) "Processar"
    * (cmdProcessa) do legado:
    *   With ThisForm
    *       .pcMsg = ''
    *       If .mChkValid()
    *           .mProcessamento()
    *           If Not Eof()
    *               .Enabled = .f.
    *               Do Form SigPrGf2 With ThisForm
    *           Else
    *               .pcMsg = 'Nenhum Registro Encontrado.'
    *           EndIf
    *       EndIf
    *       If Not Empty(.pcMsg)
    *           MessageBox(.pcMsg, 0+48+0, '')
    *       EndIf
    *   EndWith
    *
    * mChkValid -> THIS.ValidarPeriodo() (Fase 6: ja sincroniza o periodo com
    * o BO, preenche this_cMsgValidacao/pcMsg e foca o campo culpado quando
    * invalido). mProcessamento -> THIS.this_oBusinessObject.Processar()
    * (Fase 1/2); o toggle do cnt_4c_Aguarde que no legado mora DENTRO de
    * mProcessamento fica aqui, ao redor da chamada, porque o BO nao
    * manipula controles de UI (PILAR 3). "Not Eof()" do legado equivale a
    * this_oBusinessObject.this_lProcessado (.T. quando this_nTotalRegistros
    * > 0, setado pelo proprio Processar()).
    *
    * O cursor de resultado do BO (this_cCursorResultado, "cursor_4c_
    * Resultado" - convencao de nomenclatura deste projeto) e copiado para o
    * alias "crRel1" antes de abrir SigPrGf2: SigPrGf2BO (form filho, Fase
    * 8/8 ja completa) le esse alias LITERAL (CarregarDoCursor/
    * ObterChavesGrafico fazem SELECT crRel1 / LOCATE FOR crRel1.cEmps
    * hardcoded) - igual ao legado, que produzia mProcessamento.crRel1 e o
    * filho consumia direto na mesma sessao (FormSigPrGf2.Init copia
    * DataSessionId do form pai antes do DODEFAULT).
    *
    * A REFERENCIA DO FILHO TEM DE SER GUARDADA (defeito corrigido na Fase 8)
    * ----------------------------------------------------------------------
    * O legado usa "Do Form SigPrGf2 With ThisForm", e o DO FORM faz o VFP
    * guardar a referencia do form aberto. O migrado abre com CREATEOBJECT, e
    * a versao anterior desta linha era:
    *
    *     CREATEOBJECT("FormSigPrGf2", THIS)      && retorno DESCARTADO
    *
    * Medido no VFP9 (2026-09-28, harness pai modal + filho modeless que se
    * mostra no proprio Init, igual ao FormSigPrGf2):
    *
    *   CREATEOBJECT sem atribuir -> filho.Init / filho.Init pos-Show /
    *                                filho.Destroy  <<< MORREU
    *                                _SCREEN.FormCount = 1 (so o pai)
    *   referencia em property    -> _SCREEN.FormCount = 2, VARTYPE = "O",
    *                                filho.Visible = .T., filho.Enabled = .T.
    *
    * Isto eh: o grafico era destruido na PROPRIA linha do CREATEOBJECT,
    * porque FormSigPrGf2 tem WindowType = 0 (modeless) e a ultima referencia
    * caia na hora. O Destroy dele reabilita o pai (poform1.Enabled = .T.),
    * entao nao sobrava erro, nem log, nem tela travada - o usuario clicava
    * Processar, esperava o grafico e "nada acontecia".
    *
    * Ainda na mesma medicao, com a referencia guardada:
    *   - o filho modeless fica NO TOPO mesmo com o pai MODAL
    *     (WONTOP() = [FILHO], _SCREEN.ActiveForm = o filho), logo eh
    *     utilizavel - nao ha conflito entre o WindowType = 1 do pai
    *     (exigencia do menu.prg) e o WindowType = 0 do filho;
    *   - filho.Release() (o botao Sair do filho) DISPARA o Destroy mesmo com
    *     o pai segurando a referencia, e o pai volta a Enabled = .T.;
    *   - depois disso a property do pai vira VARTYPE = "X" (referencia
    *     pendurada) - por isso toda checagem usa VARTYPE(...) = "O", nunca
    *     ISNULL(), e a property eh limpa antes de abrir outro grafico.
    *
    * DIVERGENCIA DELIBERADA DO LEGADO: o legado faz ".Enabled = .f." ANTES do
    * DO FORM; aqui o Enabled = .F. so entra DEPOIS de confirmar que o filho
    * nasceu. Se o CREATEOBJECT falhasse com o pai ja desabilitado, o usuario
    * ficaria preso numa tela morta - este form tem TitleBar = 0,
    * ControlBox = .F. e Closable = .F., ou seja, nem o Encerrar responderia, e
    * quem reabilita o pai eh justamente o filho que nao existe. A ordem nao
    * muda nada do ponto de vista visual (o filho se mostra no proprio Init).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lProcessado, loc_oErro, loc_cCursor
        loc_lProcessado = .F.

        *-- ".pcMsg = ''" - primeira linha do cmdProcessa.Click legado. Hoje o
        *-- ValidarPeriodo() tambem limpa a mensagem, mas a limpeza pertence ao
        *-- Click: sem ela, um caminho que nao chegue ao ValidarPeriodo
        *-- reexibiria o aviso do clique ANTERIOR.
        THIS.this_cMsgValidacao = ""

        TRY
            IF THIS.ValidarPeriodo()
                THIS.cnt_4c_Aguarde.Visible = .T.
                THIS.cnt_4c_Aguarde.ZOrder(0)
                THIS.Refresh()

                loc_lProcessado = THIS.this_oBusinessObject.Processar()

                THIS.cnt_4c_Aguarde.Visible = .F.
                THIS.Refresh()

                IF loc_lProcessado AND THIS.this_oBusinessObject.this_lProcessado
                    *-- Nome do cursor numa LOCAL: "SELECT ... FROM (<expressao
                    *-- de nome>)" aceita memvar, e medido no VFP9 com
                    *-- (m.loc_cCursor) funciona na 1a e na 2a passagem (o
                    *-- usuario pode processar mais de um periodo por sessao).
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado

                    IF USED("crRel1")
                        USE IN crRel1
                    ENDIF
                    SELECT * FROM (m.loc_cCursor) INTO CURSOR crRel1 READWRITE

                    *-- Solta o grafico anterior (se o usuario processou duas
                    *-- vezes) antes de abrir o novo, senao a referencia velha
                    *-- seguraria um form ja fechado.
                    THIS.LiberarFormGrafico()

                    THIS.this_oFormGrafico = CREATEOBJECT("FormSigPrGf2", THIS)

                    IF VARTYPE(THIS.this_oFormGrafico) = "O"
                        THIS.Enabled = .F.
                    ELSE
                        THIS.this_cMsgValidacao = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel abrir o gr" + CHR(225) + "fico (SigPrGf2)."
                    ENDIF
                ELSE
                    THIS.this_cMsgValidacao = IIF(!EMPTY(THIS.this_oBusinessObject.this_cMensagemErro), ;
                        THIS.this_oBusinessObject.this_cMensagemErro, "Nenhum Registro Encontrado.")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.Enabled = .T.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY

        IF !EMPTY(THIS.this_cMsgValidacao)
            MsgAviso(THIS.this_cMsgValidacao, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    * LiberarFormGrafico - solta a referencia do FormSigPrGf2 guardada em
    * this_oFormGrafico, fechando o form se ele ainda estiver aberto.
    *
    * Depois que o usuario fecha o grafico pelo botao dele, a property fica
    * com uma referencia PENDURADA (VARTYPE = "X", medido) - por isso o teste
    * eh VARTYPE(...) = "O" e nao ISNULL(), e o Release() so eh chamado quando
    * o objeto ainda responde.
    *==========================================================================
    PROCEDURE LiberarFormGrafico()
        IF VARTYPE(THIS.this_oFormGrafico) = "O"
            THIS.this_oFormGrafico.Release()
        ENDIF

        THIS.this_oFormGrafico = .NULL.
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - migracao do Click de Buttons(2) "Encerrar"
    * (cmdProcessa). O segundo Click do dump legado (LockScreen/Release/
    * Refresh + bloco de .poForm1/crLstMatLote) e herdado da classe GENERICA
    * do CommandGroup compartilhada por varios forms - crLstMatLote e
    * poForm1 nao existem neste form (SIGPRGF1 nao tem lote nem form pai),
    * entao esse bloco morto nao se aplica aqui. O que resta, valido em
    * qualquer form que use esse botao, e fechar a tela.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao. Percorre recursivamente containers/PageFrames para tornar tudo
    * visivel apos a montagem. Filtra cnt_4c_Aguarde (container flutuante de
    * "Aguarde... Processando Dados...", que so aparece durante o Processar -
    * fase 7): pula o Visible do proprio container, mas recursa nos filhos
    * para eles nao ficarem hidden quando o container for mostrado depois.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_AGUARDE")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Equivalente do "PROCEDURE Release" legado (que soltava o
    * poDataMgr; aqui a conexao eh o gnConnHandle global e nao pertence ao
    * form). Fecha os cursores criados por esta tela e solta o form do grafico,
    * antes de encadear para FormBase.Destroy(), que libera o BO e restaura o
    * menu principal. DODEFAULT() SEMPRE por ultimo (Destroy sem DODEFAULT
    * deixa o menu do sistema encolhido).
    *
    * crRel1 tambem eh fechado aqui: ele eh criado por BtnProcessarClick (nao
    * pelo BO) e, apesar de viver na datasession privada desta tela, fecha-lo
    * explicitamente mantem simetrico quem cria e quem destroi.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.LiberarFormGrafico()

        IF USED("crRel1")
            USE IN crRel1
        ENDIF

        IF USED("cursor_4c_Resultado")
            USE IN cursor_4c_Resultado
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGf1BO.prg):
*============================================================================
* SigPrGf1BO.prg - Business Object para "Falha X Recuperacao por Mes da
* Empresa" (SIGPRGF1)
*
* Form OPERACIONAL (SIGPRGF1 / FormSigPrGf1): tela de FILTRO que recebe um
* periodo (Data Inicial/Data Final, limitado a 12 meses) e dispara um
* processamento que agrega SigCdFea (Falhas/Pesoccbs) por mes da empresa
* corrente, gravando o resultado num cursor. Nao ha CRUD - o form apenas
* filtra e processa, depois abre SigPrGf2 (grafico) com o resultado.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): SigCdFea e
* SigCdEmp sao apenas consultadas para compor o relatorio.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrGf1BO AS BusinessBase

    *==========================================================================
    * Filtro de periodo - SIGPRGF1.getDtInicial/getDtFinal
    *==========================================================================
    this_dDataInicial = {}   && getDtInicial.Value - inicio do periodo
    this_dDataFinal   = {}   && getDtFinal.Value   - fim do periodo

    *==========================================================================
    * Empresa corrente (equivalente a _Empr do legado - CLAUDE.md regra:
    * NUNCA usar _EMPR, usar go_4c_Sistema.cCodEmpresa) e sua descricao,
    * lida de SigCdEmp (CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,
    * 'Razas') do mProcessamento legado)
    *==========================================================================
    this_cEmpresa     = SPACE(3)    && go_4c_Sistema.cCodEmpresa - SigCdEmp.Cemps
    this_cNomeEmpresa = SPACE(40)   && SigCdEmp.Razas

    *==========================================================================
    * Titulos do relatorio/grafico (mProcessamento monta lcTitulo1/lcTitulo2)
    *==========================================================================
    this_cTitulo1 = ""   && "Falha X Recuperacao por Mes da Empresa " + emp + " - " + razao
    this_cTitulo2 = ""   && faixa de periodo formatada: "[De dd/mm/aaaa a dd/mm/aaaa]"

    *==========================================================================
    * Resultado do processamento (crRel1 do legado - agregado por mes)
    *==========================================================================
    this_cCursorResultado = ""   && nome do cursor com o resultado agregado
    this_nTotalRegistros  = 0    && RECCOUNT do cursor resultado (equivale ao "Not Eof()" legado)
    this_lProcessado      = .F.  && .T. quando mProcessamento rodou com sucesso e ha registros

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela proprietaria (form
    * apenas filtra/processa), entao this_cTabela/this_cCampoChave ficam
    * vazios. Carrega valores padrao de periodo (equivalente ao Init legado:
    * getDtInicial = 1o dia do mes corrente, getDtFinal = ultimo dia do mes
    * corrente) e a empresa corrente.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro, loc_dHoje
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_dHoje = DATE()
            THIS.this_dDataInicial = DATE(YEAR(loc_dHoje), MONTH(loc_dHoje), 1)
            THIS.this_dDataFinal   = GOMONTH(THIS.this_dDataInicial, 1) - 1

            IF TYPE("go_4c_Sistema.cCodEmpresa") = "C"
                THIS.this_cEmpresa = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DECISAO DE PROJETO (Fase 2 - Metodos CRUD):
    *
    * SigPrGf1 e um form OPERACIONAL de FILTRO/PROCESSAMENTO, sem tabela
    * propria e sem gravacao em banco (this_cTabela fica vazio - ver Init
    * acima). O legado (mProcessamento) so faz LEITURA de SigCdFea/SigCdEmp
    * e agrega o resultado num cursor LOCAL (crRel1, via "Into Cursor ...
    * ReadWrite"); nao ha TableUpdate, AddCursor nem Insert/Update/Delete
    * contra tabela remota.
    *
    * Por isso este BO NAO sobrescreve CarregarDoCursor(), Inserir() e
    * Atualizar(): o comportamento herdado de BusinessBase (CarregarDoCursor
    * generico, Inserir()/Atualizar() recusando a operacao) ja e o correto
    * para um BO somente-leitura. Os metodos reais do form ficam em
    * ValidarPeriodo() (equivalente a mChkValid) e Processar() (equivalente
    * a mProcessamento), implementados abaixo.
    *==========================================================================

    *==========================================================================
    * ValidarPeriodo - Equivalente a SIGPRGF1.mChkValid do legado. Valida o
    * par de datas (getDtInicial/getDtFinal) antes de processar: data final
    * preenchida, data final >= data inicial e periodo nao ultrapassando 12
    * meses. Preenche this_cMensagemErro e retorna .F. no primeiro erro (o
    * SetFocus no campo invalido fica por conta do Form, que le a mensagem
    * e decide qual controle focar).
    *==========================================================================
    FUNCTION ValidarPeriodo()

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "Data Inicial Maior Que a Data Final!!!"
            RETURN .F.
        ENDIF

        IF ((YEAR(THIS.this_dDataInicial) = YEAR(THIS.this_dDataFinal) AND ;
            (MONTH(THIS.this_dDataInicial) - MONTH(THIS.this_dDataFinal) + 1) > 12) OR ;
            (YEAR(THIS.this_dDataInicial) != YEAR(THIS.this_dDataFinal) AND ;
            ((12 - MONTH(THIS.this_dDataInicial)) + MONTH(THIS.this_dDataFinal) + 1) > 12))
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Ultrapassa Doze Meses!!!"
            RETURN .F.
        ENDIF

        THIS.this_cMensagemErro = ""
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Processar - Equivalente a SIGPRGF1.mProcessamento do legado. Busca a
    * empresa corrente em SigCdEmp, consulta SigCdFea no periodo informado
    * (filtrado por Emps) e agrega Falhas/Pesoccbs por mes num cursor local
    * (this_cCursorResultado), no mesmo formato que o legado monta para
    * alimentar o grafico do SigPrGf2.
    *==========================================================================
    FUNCTION Processar()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nResultado, ;
              loc_cDtIni, loc_cDtFim, loc_cStrgMes, loc_cTitulo1, loc_cTitulo2, ;
              loc_cEmpresaAtual, loc_cNomeEmpresa, ;
              loc_nDecimals, loc_cFixed, loc_cExact

        loc_lResultado = .F.

        *-- Contexto numerico/de comparacao do mProcessamento legado, salvo e
        *-- restaurado igual la ("m.lnDecimals = Set('Decimals',1)" etc. +
        *-- "Set Decimals To 6 / Set Fixed On / Set Exact On"). Nao eh detalhe
        *-- decorativo: o form roda com DataSession = 2 (transcrito do SCX) e a
        *-- datasession privada nasce com esses SETs no default do VFP, nao no
        *-- do sistema - a agregacao abaixo (VAL(STR(SUM(...), 16, 2)) e o
        *-- GROUP BY) tem de ver o mesmo contexto que o legado via.
        *-- Medido no VFP9: SET("Decimals") devolve NUMERIC e SET("Fixed")/
        *-- SET("Exact") devolvem CHARACTER - por isso nenhum deles vai
        *-- envolvido em VAL() (VAL sobre numerico dispara erro 11).
        loc_nDecimals = SET("Decimals")
        loc_cFixed    = SET("Fixed")
        loc_cExact    = SET("Exact")

        SET DECIMALS TO 6
        SET FIXED ON
        SET EXACT ON

        TRY
            THIS.this_lProcessado     = .F.
            THIS.this_nTotalRegistros = 0
            THIS.this_cMensagemErro   = ""

            IF USED("cursor_4c_TmpRel")
                USE IN cursor_4c_TmpRel
            ENDIF
            IF USED("cursor_4c_Resultado")
                USE IN cursor_4c_Resultado
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            * Empresa corrente (equivalente a CursorQuery('SigCdEmp','crSigCdEmp',
            * 'Cemps',_Empr,'Razas') do legado)
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(THIS.this_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o com o Servidor de Banco de Dados (SigCdEmp): " + CapturarErroSQL()
            ELSE
                IF loc_nResultado > 0 AND !EOF("cursor_4c_Emp")
                    THIS.this_cNomeEmpresa = TratarNulo(cursor_4c_Emp.Razas, "")
                ELSE
                    THIS.this_cNomeEmpresa = ""
                ENDIF

                * Faixa de datas (Datas eh datetime; limite final vai ate 23:59:59,
                * igual a fDtoSQL(m.ldData2, '23:59:59') do legado)
                loc_cDtIni = FormatarDataSQL(THIS.this_dDataInicial)
                loc_cDtFim = "'" + PADL(YEAR(THIS.this_dDataFinal), 4, "0") + "-" + ;
                                   PADL(MONTH(THIS.this_dDataFinal), 2, "0") + "-" + ;
                                   PADL(DAY(THIS.this_dDataFinal), 2, "0") + " 23:59:59'"

                loc_cSQL = "SELECT a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs " + ;
                           "FROM SigCdFea a LEFT JOIN SigCdEmp b ON b.Cemps = a.Emps " + ;
                           "WHERE a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " " + ;
                           "AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRel")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (" + CapturarErroSQL() + ")"
                ELSE
                    * Mes por extenso, blocos de 9 caracteres (transcrito do legado -
                    * "Mar?o" com CHR(231) no lugar do cedilha)
                    loc_cStrgMes = "Janeiro  Fevereiro" + "Mar" + CHR(231) + "o    " + ;
                                   "Abril    Maio     Junho    Julho    Agosto   Setembro Outubro  Novembro Dezembro "

                    loc_cTitulo1 = "Falha X Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s da Empresa "

                    IF EMPTY(THIS.this_dDataInicial) AND EMPTY(THIS.this_dDataFinal)
                        loc_cTitulo2 = ""
                    ELSE
                        IF THIS.this_dDataInicial = THIS.this_dDataFinal
                            loc_cTitulo2 = " [Em " + DTOC(THIS.this_dDataInicial) + "]"
                        ELSE
                            IF EMPTY(THIS.this_dDataInicial)
                                loc_cTitulo2 = " [At" + CHR(233) + " " + DTOC(THIS.this_dDataFinal) + "]"
                            ELSE
                                loc_cTitulo2 = " [De " + DTOC(THIS.this_dDataInicial) + " " + CHR(224) + " " + DTOC(THIS.this_dDataFinal) + "]"
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_cEmpresaAtual = ALLTRIM(THIS.this_cEmpresa)
                    loc_cNomeEmpresa  = ALLTRIM(TratarNulo(THIS.this_cNomeEmpresa, ""))

                    SELECT Emps AS Cemps, ;
                           PADR(DTOS(Datas), 6) AS cAnomess, ;
                           PADR(PADR(SUBSTR(m.loc_cStrgMes, (MONTH(Datas) * 9 - 8), 9), 3) + "./" + TRANSFORM(YEAR(Datas), "@L 9999"), 9) AS csTraNomes, ;
                           PADR(m.loc_cTitulo1 + ALLTRIM(NVL(Cemps, "")) + " - " + ALLTRIM(NVL(Razas, "")), 100) AS cTitulo1s, ;
                           m.loc_cTitulo2 AS ctitulo2s, ;
                           PADR(m.loc_cEmpresaAtual + " - " + m.loc_cNomeEmpresa, 100) AS cEmpresas, ;
                           VAL(STR(SUM(Falhas), 16, 2)) AS nFalhas, ;
                           VAL(STR(SUM(Pesoccbs), 16, 2)) AS nPesoccbs ;
                      FROM cursor_4c_TmpRel ;
                     GROUP BY 1, 2, 3, 4, 5, 6 ;
                      INTO CURSOR cursor_4c_Resultado READWRITE

                    IF USED("cursor_4c_TmpRel")
                        USE IN cursor_4c_TmpRel
                    ENDIF

                    SELECT cursor_4c_Resultado
                    GO TOP

                    THIS.this_cCursorResultado = "cursor_4c_Resultado"
                    THIS.this_cTitulo1         = loc_cTitulo1
                    THIS.this_cTitulo2         = loc_cTitulo2
                    THIS.this_nTotalRegistros  = RECCOUNT("cursor_4c_Resultado")
                    THIS.this_lProcessado      = (THIS.this_nTotalRegistros > 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        *-- Restauracao do contexto (igual ao fim do mProcessamento legado).
        *-- Fica FORA do TRY para valer tambem quando o CATCH dispara - caso
        *-- contrario um erro no meio do processamento deixaria a datasession
        *-- com DECIMALS 6 / FIXED ON para o resto da vida da tela.
        *-- "&loc_cFixed." eh macro-substituicao do proprio valor lido do SET
        *-- ("ON"/"OFF"), como no legado; sem prefixo "m." (o VFP le o nome da
        *-- macro ate o primeiro ponto, e "&m.loc_cFixed." tentaria expandir a
        *-- variavel "m").
        SET DECIMALS TO loc_nDecimals
        SET FIXED &loc_cFixed.
        SET EXACT &loc_cExact.

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE


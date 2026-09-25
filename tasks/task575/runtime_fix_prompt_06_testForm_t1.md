# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: TIMEOUT: VFP9 travou durante teste de formulario (300s). ERRO CAPTURADO: [25/09/2026 09:44:12] Consulta da Operação: Código da operação não informado


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[25/09/2026 09:44:12] Consulta da Operação: Código da operação não informado


### LOG DA ETAPA (06_testForm):
[2026-09-25 09:41:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-25 09:41:46] [INFO] Config FPW: (nao fornecido)
[2026-09-25 09:41:46] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 09:41:46] [INFO] Timeout: 300 segundos
[2026-09-25 09:41:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ixujr20f.prg
[2026-09-25 09:41:46] [INFO] Conteudo do wrapper:
[2026-09-25 09:41:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigMvPdt', 'C:\4c\tasks\task575\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigMvPdt', 'C:\4c\tasks\task575\logs\06_testForm.log'
QUIT

[2026-09-25 09:41:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ixujr20f.prg
[2026-09-25 09:41:46] [INFO] VFP output esperado em: C:\4c\tasks\task575\vfp_output.txt
[2026-09-25 09:41:46] [INFO] Executando Visual FoxPro 9...
[2026-09-25 09:41:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ixujr20f.prg
[2026-09-25 09:41:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ixujr20f.prg
[2026-09-25 09:41:46] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigMvPdt
Inicio: 25/09/2026 09:41:47

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
OK - Objeto criado com sucesso
     Tipo: O
     Classe: Formsigmvpdt

[ETAPA 3] Mostrando formulario (nao-modal)...
[2026-09-25 09:46:46] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 20212)...
[2026-09-25 09:46:48] [INFO] VFP9 finalizado em 302.026462 segundos
[2026-09-25 09:46:48] [INFO] Exit Code: 4
[2026-09-25 09:46:48] [INFO] 
[2026-09-25 09:46:48] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-25 09:46:48] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ixujr20f.prg
[2026-09-25 09:46:48] [INFO] 
[2026-09-25 09:46:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-25 09:46:48] [INFO] * Auto-generated wrapper for parameters
[2026-09-25 09:46:48] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 09:46:48] [INFO] * Parameters: 'FormSigMvPdt', 'C:\4c\tasks\task575\logs\06_testForm.log'
[2026-09-25 09:46:48] [INFO] 
[2026-09-25 09:46:48] [INFO] * Anti-dialog protections for unattended execution
[2026-09-25 09:46:48] [INFO] SET SAFETY OFF
[2026-09-25 09:46:48] [INFO] SET RESOURCE OFF
[2026-09-25 09:46:48] [INFO] SET TALK OFF
[2026-09-25 09:46:48] [INFO] SET NOTIFY OFF
[2026-09-25 09:46:48] [INFO] SYS(2335, 0)
[2026-09-25 09:46:48] [INFO] 
[2026-09-25 09:46:48] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigMvPdt', 'C:\4c\tasks\task575\logs\06_testForm.log'
[2026-09-25 09:46:48] [INFO] QUIT
[2026-09-25 09:46:48] [INFO] 
[2026-09-25 09:46:48] [INFO] === Fim do Wrapper.prg ===
[2026-09-25 09:46:48] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvPdt.prg):
*====================================================================
* FormSigMvPdt.prg
*
* Form OPERACIONAL "Aguarde Processando Dados" - dialogo intermediario
* que consulta a operacao (SigCdOpd, via SigMvPdtBO) e despacha para o
* form de movimentacao FormSigPdMp6.
*
* PILAR 1 (UX): dialogo minimalista, identico ao legado SIGMVPDT - sem
* barra de titulo (TitleBar = 0), sem controle de janela (ControlBox
* = .F.), nao movivel (Movable = .F.), 337x147, com um unico
* CommandButton "Aguarde Processando Dados" que dispara sozinho ao
* ativar a tela (o legado faz Thisform.Processo.Click dentro do
* PROCEDURE Activate).
*
* PILAR 3 (arquitetura): o legado (SIGMVPDT) e um form FLAT do VFP -
* SEM PageFrame, SEM Container algum: o unico filho direto do form e
* o CommandButton Processo. Este form migrado segue a mesma estrutura
* flat (excecao documentada em CLAUDE.md para o Gate da Fase 3 quando
* o legado nao tem PageFrame/Container - nao inventar Page1/Page2 nem
* containers vazios que o original nao possui).
*
* Este dialogo e um DESPACHANTE (form FLAT com um unico CommandButton),
* nao um cadastro CRUD - nao tem Page1/Lista, Page2/Dados, Grid nem
* botoes de Incluir/Alterar/Excluir/Buscar, porque o legado tambem nao
* tem (ver PILAR 1/PILAR 3 acima). O unico controle (cmd_4c_Processo) e
* configurado em ConfigurarControles(); Activate() e CmdProcessoClick()
* replicam PROCEDURE Activate / SIGMVPDT.Processo.Click do legado.
*
* CAMPOS DE DADOS: o legado NAO TEM NENHUM. A arvore de objetos do
* SigMvPdt.SCX tem exatamente 3 entradas (dataenvironment + form + o
* CommandButton Processo) - zero textbox, editbox, combobox, listbox,
* checkbox, optiongroup, optionbutton ou spinner, e zero ControlSource.
* Por isso NAO existe ConfigurarPaginaDados() nem qualquer campo neste
* form: acrescentar um seria INVENTAR superficie que o original nao
* possui, violando o PILAR 1 e a regra "NUNCA inventar". Os valores com
* que a tela trabalha (pDope/pTipo/pNume/pEmp) chegam por PARAMETRO no
* Init, como no legado, e vivem nas propriedades this_* abaixo - nunca
* em controle de entrada. A ausencia aqui e deliberada e ja foi
* conferida contra o dump - nao e uma etapa por fazer.
*
* LOOKUPS: o legado NAO TEM NENHUM, e isso foi VERIFICADO contra o
* dump (SigMvPdt_form_codigo_fonte.txt), nao presumido. O arquivo nao
* contem nenhuma das tres classes de busca do Framework legado
* (fwBuscaExt / fwBuscaSel / fwBuscaInt), nenhuma chamada a mAddColuna
* (a API de colunas do picker legado), nenhum sigacess() nem nenhuma
* das funcoes Acesso* (AcessoCampos/Contab/Contas/Empresa/Grupos/
* MovInd/MovMto/Produto/Titulo), e nenhum PROCEDURE Valid/KeyPress em
* objeto algum - os unicos 5 metodos do SCX sao Release/Load/Init/
* Activate do form e Click do CommandButton. Lookup so existe para
* RESOLVER o que o usuario digita num campo; sem nenhum campo de
* entrada (ver bloco acima) nao ha onde ligar um. Por isso NAO existe
* AbrirLookup*/AbrirBusca* nem BINDEVENT de KeyPress/DblClick neste
* form: criar um obrigaria a INVENTAR uma tabela de consulta que o
* original nunca acessa, violando o PILAR 1 e a regra "NUNCA inventar
* tabelas de lookup que nao existem no original".
*
* BOTOES Salvar/Cancelar: tambem inexistentes no legado. Este dialogo
* nao edita registro nenhum - ele consulta a operacao e despacha para
* Formsigpdmp6, que e quem tem a tela de manutencao. Nao ha, portanto,
* cnt_4c_BotoesAcao: o unico botao do legado (Processo) ja esta em
* ConfigurarControles().
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
* ----------------------------------------
* Os 4 nomes que a fase lista (BtnIncluirClick / BtnAlterarClick /
* BtnVisualizarClick / BtnExcluirClick) sao convencao de form CRUD - os
* botoes da Page1/Lista do frmcadastro. Este legado NAO TEM NENHUM
* deles, e isso foi MEDIDO no dump, nao presumido
* (SigMvPdt_form_codigo_fonte.txt):
*
*   SECAO 1 (arvore de objetos): 3 entradas - dataenvironment, o form
*     SIGMVPDT (Class: form, NAO frmcadastro) e UM unico objeto com
*     BaseClass commandbutton (Processo). Zero commandgroup, zero
*     Grupo_Op, zero Page de Lista/Dados.
*   SECAO 3 (metodos): "Total de metodos/eventos com codigo: 5" -
*     Release / Load / Init / Activate do form + Click do Processo.
*     Nenhum btn|cmd|Command(Incluir|Alterar|Visualizar|Excluir),
*     nenhum <X>.Click com esses nomes e nenhum pcEscolha (a variavel
*     de MODO do frmcadastro) em ocorrencia alguma.
*
* Acrescentar os 4 metodos aqui obrigaria a INVENTAR botoes que o
* original nao possui (viola o PILAR 1) ou a deixar metodo vazio
* (proibido pela regra de completude desta propria fase). A superficie
* de botao que o legado PROVA ter e 1 (o Processo), e ela tem evento:
* CmdProcessoClick, bindado em ConfigurarControles e disparado
* automaticamente por Activate, exatamente como o legado faz com
* Thisform.Processo.Click. O gate desta fase trata este caso pelo ramo
* legadoSemCrud + nBotoesLegado = 1 em
* automation\OrquestradorMigracao.ps1 (case 7).
*
* O que esta fase acrescentou de fato ao evento do botao: a falha da
* consulta deixou de ser MUDA. BuscarOperacao() ja devolvia .F. com
* this_cMensagemErro preenchido quando a conexao esta indisponivel ou o
* SQLEXEC falha, mas CmdProcessoClick DESCARTAVA o retorno - o usuario
* veria apenas a tela de destino abrir sem os dados da operacao. Agora
* o resultado alimenta this_lErro (a property Erro do legado, que ate
* aqui era escrita so no Init e nunca mais lida nem gravada) e a
* mensagem e exibida. O DESPACHO segue acontecendo nos dois casos,
* porque o legado tambem despacha sem depender do resultado do
* CursorQuery - reportar sem abortar preserva o fluxo do legado
* (PILAR 1) e ainda respeita "falha nunca e muda" (CLAUDE.md #9/#20).
*
* Parametros de Init (equivalentes ao legado
* lParameters pDopps, pTipos, pNumps, pEmps, pConsulta):
*   par_cDope     - Dopps: codigo da operacao/documento (SigCdOpd)
*   par_cTipo     - Tipos do chamador (' ' padrao, 'C' = Contas a
*                   Pagar/Receber)
*   par_nNume     - Numero do documento (so usado quando par_cTipo = 'C')
*   par_cEmp      - Codigo da empresa (so usado quando par_cTipo = 'C')
*   par_cConsulta - Mantido apenas pela assinatura original (o legado
*                   recebe o parametro mas nunca o usa)
*
* FASE 8/8 - CONSOLIDACAO: DISPOSICAO DOS 5 METODOS DO SCX LEGADO
* -----------------------------------------------------------------
* O dump (SigMvPdt_form_codigo_fonte.txt, "Total de metodos/eventos com
* codigo: 5") tem Release, Load, Init, Activate e Processo.Click. Tres
* viraram codigo aqui; os outros DOIS sao nao-ports deliberados,
* registrados para que a ausencia seja auditavel em vez de parecer
* esquecimento (mesmo padrao de FormSigMvExp.prg, task570):
*
*   Legado                   Migrado
*   -----------------------  -------------------------------------------
*   Init                     PROCEDURE Init (mesmos 5 parametros posicionais)
*   Activate                 PROCEDURE Activate
*   Processo.Click           PROCEDURE CmdProcessoClick (via BINDEVENT)
*   Load  (=fConfigGeral())  NAO PORTADO - ver (a)
*   Release (podatamgr6)     NAO PORTADO - ver (b)
*
* (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da
*     aplicacao legado (sig.prg / SIGFUNCS.PRG) que NAO veio no acervo.
*     O wrapper em projeto\app\utils\fconfiggeral.prg e um NO-OP
*     (RETURN .T.) que existe APENAS para o p-code dos VCX legado
*     conseguir resolver o nome - o proprio cabecalho dele diz "em
*     codigo NOSSO nunca se chama fConfigGeral". Chama-lo daqui seria
*     escrever uma chamada que comprovadamente nao faz nada. O que
*     fConfigGeral fazia esta distribuido e ja ocorre ANTES deste form
*     abrir (config.prg, main.prg, cada BO) - este form nao le cursor
*     nenhum alem do que BuscarOperacao() cria e fecha sozinho.
*
* (b) Release: "ThisForm.Podatamgr6.Release" seguido de DoDefault().
*     Podatamgr6 era o fSqlConector PRIVADO deste form (ver cabecalho
*     do SigMvPdtBO.prg - decisao ja tomada de nao replicar esse
*     padrao, a nova arquitetura usa o handle GLOBAL gnConnHandle, que
*     nao pode ser liberado ao fechar uma tela). Sobra o "DoDefault()"
*     do legado, que aqui ja acontece por HERANCA - sem override,
*     FormBase.Destroy roda inteiro (libera this_oBusinessObject,
*     reconstroi o menu). Declarar "PROCEDURE Destroy / DODEFAULT() /
*     ENDPROC" so para constar seria metodo sem logica propria
*     (proibido pela regra de completude) e abriria caminho para a
*     regressao do Pattern #145 se alguem depois editasse esse
*     override e esquecesse o DODEFAULT() dentro dele.
*====================================================================

DEFINE CLASS FormSigMvPdt AS FormBase

    *-- Propriedades (equivalentes as propriedades pDope/pTipo/pNume/
    *-- pEmp/Erro do legado, recebidas via Init)
    this_cMensagemErro = ""
    this_cDope = ""
    this_cTipo = " "
    this_nNume = 0
    this_cEmp  = ""
    this_lErro = .F.

    *-- Guarda de reentrancia do despacho (equivalente ao Not WExist('SigPdMp6')
    *-- do legado): evita reabrir Formsigpdmp6 caso Activate dispare mais de
    *-- uma vez (ex.: retorno de foco apos o filho modal fechar).
    this_lDespachado = .F.

    *-- Configuracoes visuais do dialogo (identicas ao SCX legado)
    Width          = 337
    Height         = 147
    BorderStyle    = 2
    AutoCenter     = .T.
    ShowWindow = 1
    WindowType = 1
    ControlBox     = .F.
    Movable        = .F.
    TitleBar       = 0
    AlwaysOnBottom = .T.
    Themes         = .F.
    Caption        = ""

    *--------------------------------------------------------------------------
    * Init - Recebe os mesmos parametros posicionais do legado e os grava
    * nas propriedades do form ANTES de DODEFAULT() acionar FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cDope, par_cTipo, par_nNume, par_cEmp, par_cConsulta)
        THIS.this_cDope = TratarNulo(par_cDope, "")
        THIS.this_cTipo = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, " ")

        IF THIS.this_cTipo = "C"
            THIS.this_nNume = IIF(VARTYPE(par_nNume) = "N", par_nNume, 0)
            THIS.this_cEmp  = IIF(VARTYPE(par_cEmp) = "C", par_cEmp, "")
        ENDIF

        THIS.this_lErro = .F.

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init(). Instancia o
    * Business Object. Este dialogo NAO tem PageFrame nem paginas
    * Lista/Dados: o legado e um form FLAT sem nenhum container (ver
    * comentario de cabecalho acima).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigMvPdtBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarControles()
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o objeto de neg" + CHR(243) + "cio SigMvPdtBO"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Cria o unico controle do dialogo, identico ao
    * SigMvPdt.SCX legado: CommandButton "Processo" (mapeado para
    * cmd_4c_Processo), que dispara sozinho a consulta/despacho ao ativar
    * a tela (ver Activate/CmdProcessoClick). Form FLAT (sem PageFrame,
    * sem Container - ver comentario de cabecalho), entao o botao e
    * filho direto de THIS. Propriedades visuais (Top/Left/Width/Height/
    * FontName/FontSize/FontBold/Caption/ForeColor/BackColor) transcritas
    * EXATAS do dump (SigMvPdt_form_codigo_fonte.txt, SIGMVPDT.Processo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        THIS.AddObject("cmd_4c_Processo", "CommandButton")

        WITH THIS.cmd_4c_Processo
            .Top       = 34
            .Left      = 48
            .Width     = 241
            .Height    = 73
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .Caption   = "Aguarde Processando Dados"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Processo, "Click", THIS, "CmdProcessoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - O legado dispara o processamento sozinho ao ativar a
    * tela (PROCEDURE Activate / Thisform.Processo.Click), sem esperar
    * nenhuma interacao do usuario.
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        DODEFAULT()
        THIS.CmdProcessoClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdProcessoClick - Equivalente ao PROCEDURE Click do Processo
    * legado: consulta SigCdOpd (Dopps/Pccs, via BO.BuscarOperacao) e
    * despacha para Formsigpdmp6, replicando a escolha de assinatura por
    * this_cTipo (' ' padrao / 'C' = Contas a Pagar/Receber). PUBLIC
    * porque e bindado via BINDEVENT (CLAUDE.md regra #3).
    *
    * ENCERRAMENTO: no legado quem fecha ESTE dialogo e o form filho -
    * SigPdMp6.Init guarda o pai em ThisForm.pAntform = pForm e o botao
    * Sair dele faz "If Type([Thisform.pAntForm])=[O] And !IsNull(...) /
    * Thisform.pAntForm.Release / EndIf" antes do proprio ThisForm.Release.
    * O Formsigpdmp6 migrado recebe par_oFormPai na assinatura do Init mas
    * NUNCA o guarda nem o usa, entao esse Release do pai se perdeu. Sem
    * ele este dialogo fica orfao na tela depois que o filho fecha - e ele
    * nao tem como ser fechado pelo usuario (TitleBar = 0, ControlBox =
    * .F., Movable = .F., e o unico botao ja foi consumido pela guarda
    * this_lDespachado). Como Formsigpdmp6 e modal (WindowType = 1), o
    * Show() abaixo so retorna quando o filho fecha: liberar THIS logo
    * apos o retorno reproduz exatamente o efeito do pAntForm.Release do
    * legado, sem depender de alterar o form do outro modulo. Tambem
    * liberamos quando o filho NAO pode ser criado, senao o usuario fica
    * preso no dialogo depois da mensagem de erro.
    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessoClick()
        LOCAL loc_oForm, loc_oErro

        IF THIS.this_lDespachado
            RETURN
        ENDIF
        THIS.this_lDespachado = .T.

        *-- Consulta a operacao (equivalente ao CursorQuery legado). A falha
        *-- NAO aborta o despacho - o legado tambem despacha sem depender
        *-- do resultado do CursorQuery - mas tambem nao pode ficar muda
        *-- (CLAUDE.md #9/#20): alimenta this_lErro (a property Erro do legado)
        *-- e exibe a mensagem que o BO montou.
        THIS.this_lErro = !THIS.this_oBusinessObject.BuscarOperacao(THIS.this_cDope)

        IF THIS.this_lErro AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                "Consulta da Opera" + CHR(231) + CHR(227) + "o")
        ENDIF

        loc_oForm = .NULL.

        TRY
            IF THIS.this_cTipo = "C"
                loc_oForm = CREATEOBJECT("Formsigpdmp6", THIS.this_cDope, THIS, ;
                    THIS.this_nNume, THIS.this_cEmp, .T.)
            ELSE
                loc_oForm = CREATEOBJECT("Formsigpdmp6", THIS.this_cDope, THIS)
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "CmdProcessoClick")
            loc_oForm = .NULL.
        ENDTRY

        *-- Show() FORA do TRY (CLAUDE.md regra #29): com form modal o
        *-- Show() bloqueia, entao dentro do TRY qualquer erro de runtime
        *-- do filho saltaria para o CATCH e derrubaria a referencia.
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF

        *-- Equivalente ao Thisform.pAntForm.Release do Sair.Click legado
        *-- (ver comentario do metodo). Roda tanto no retorno normal do
        *-- filho modal quanto no caminho em que ele nao pode ser criado.
        THIS.Release()
    ENDPROC

    *-- Sem override de Destroy: ver item (b) da consolidacao no cabecalho
    *-- do arquivo - FormBase.Destroy ja roda por heranca.

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigMvPdtBO.prg):
*====================================================================
* SigMvPdtBO.prg
*
* Business Object para o form OPERACIONAL SigMvPdt ("Aguarde Processando
* Dados") - dialogo intermediario que consulta a operacao em SigCdOpd
* (chave Dopps) e despacha para o form de movimentacao SigPdMp6.
* Tabela de consulta: SigCdOpd (chave Dopps)
* Herda de: BusinessBase
*
* PILAR 3: o legado usa um objeto "PoDataMgr6" (fSqlConector) criado no
* Init do form para rodar CursorQuery. A nova arquitetura NAO replica
* esse padrao - o BO acessa o SQL Server diretamente via SQLEXEC, entao
* a propriedade "podatamgr6" do legado foi OMITIDA de proposito (mesma
* decisao ja adotada em sigmvitnBO).
*====================================================================

DEFINE CLASS SigMvPdtBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para parametros/consulta do form legado)
    this_cDope  = ""     && pDope  - Dopps char(20), codigo da operacao/documento (chave de filtro em SigCdOpd)
    this_cTipo  = " "    && pTipo  - Tipos do chamador (' ' = padrao, 'C' = Contas a Pagar/Receber)
    this_nNume  = 0      && pNume  - Numero do documento (preenchido apenas quando this_cTipo = "C")
    this_cEmp   = ""     && pEmp   - Codigo da empresa (preenchido apenas quando this_cTipo = "C")
    this_lPccs  = .F.    && Pccs bit NOT NULL - retornado pela consulta em SigCdOpd para a operacao corrente
    this_lErro  = .F.    && Erro  - flag de erro do processamento (equivalente a ThisForm.Erro no legado)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT("SigCdOpd")
            THIS.this_cTabela     = "SigCdOpd"
            THIS.this_cCampoChave = "Dopps"

            THIS.this_cDope = ""
            THIS.this_cTipo = " "
            THIS.this_nNume = 0
            THIS.this_cEmp  = ""
            THIS.this_lPccs = .F.
            THIS.this_lErro = .F.

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvPdtBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia as colunas retornadas pela consulta em
    * SigCdOpd (Dopps, Pccs) para as propriedades do BO. Espelha
    * exatamente as duas colunas que o legado pedia no CursorQuery
    * ('SigCdOpd','CrSigCdOpd','Dopps',Upper(pDope),[Dopps,Pccs]) -
    * o restante das 230+ colunas NOT NULL de SigCdOpd nunca era lido
    * por este dialogo. SEMPRE SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #8/CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cDope = TratarNulo(Dopps, "")

            *-- Pccs (bit) chega como Logico ou Numerico conforme o driver
            *-- (CLAUDE.md regra #13) - testar VARTYPE antes de comparar.
            IF VARTYPE(Pccs) = "L"
                THIS.this_lPccs = Pccs
            ELSE
                THIS.this_lPccs = (NVL(Pccs, 0) = 1)
            ENDIF

            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * BuscarOperacao - Equivalente funcional ao
    * ThisForm.Podatamgr6.cursorquery('SigCdOpd','CrSigCdOpd','Dopps',
    * Upper(ThisForm.pDope),[Dopps,Pccs]) do legado: consulta SigCdOpd
    * pela chave Dopps e traz apenas Dopps/Pccs, que sao os dois valores
    * usados pelo PROCEDURE Processo.Click para decidir qual variante de
    * SigPdMp6 abrir.
    *====================================================================
    FUNCTION BuscarOperacao(par_cDope)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(par_cDope, "")))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_SigMvPdt")
            USE IN cursor_4c_SigMvPdt
        ENDIF

        loc_cSQL = "SELECT Dopps, Pccs FROM SigCdOpd WHERE Dopps = " + ;
            EscaparSQL(UPPER(PADR(ALLTRIM(par_cDope), 20)))

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvPdt")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_SigMvPdt") > 0
                    THIS.CarregarDoCursor("cursor_4c_SigMvPdt")
                ELSE
                    *-- Operacao nao cadastrada em SigCdOpd: sem registro para ler
                    *-- Pccs, mantem o codigo digitado e assume Pccs = .F.
                    THIS.this_cDope = UPPER(ALLTRIM(par_cDope))
                    THIS.this_lPccs = .F.
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("cursor_4c_SigMvPdt")
            USE IN cursor_4c_SigMvPdt
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - Chave do registro atual (para auditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cDope, ""))
    ENDPROC

    *====================================================================
    * Inserir / Atualizar - retornam .F. de proposito: este BO/form so
    * grava atraves deles quando alguem chamar Salvar(), o que nunca
    * acontece neste dialogo.
    *
    * O legado (SIGMVPDT) e um dialogo intermediario "Aguarde Processando
    * Dados": consulta SigCdOpd so para ler Dopps/Pccs e despacha para
    * SigPdMp6 (DO FORM). Nao ha Salvar/Confirmar - o unico controle e o
    * botao Processo, que dispara a consulta e a navegacao. SigCdOpd e o
    * registro MESTRE de configuracao da Operacao (230+ colunas NOT NULL
    * alem de Dopps/Pccs), mantido pelo cadastro de Operacoes; implementar
    * INSERT/UPDATE aqui exigiria inventar valores para colunas que esta
    * tela nunca exibe, arriscando sobrescrever configuracao real (Pilar 2).
    * BusinessBase.Salvar() nunca eh chamado por este BO/form.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Este di" + CHR(225) + "logo n" + CHR(227) + "o grava dados"
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Este di" + CHR(225) + "logo n" + CHR(227) + "o grava dados"
        RETURN .F.
    ENDPROC

ENDDEFINE


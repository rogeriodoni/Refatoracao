# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 7/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-25 21:14:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-25 21:14:48] [INFO] Config FPW: (nao fornecido)
[2026-09-25 21:14:48] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 21:14:48] [INFO] Timeout: 300 segundos
[2026-09-25 21:14:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aozvqahg.prg
[2026-09-25 21:14:48] [INFO] Conteudo do wrapper:
[2026-09-25 21:14:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigMvVde', 'C:\4c\tasks\task581\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigMvVde', 'C:\4c\tasks\task581\logs\06_testForm.log'
QUIT

[2026-09-25 21:14:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aozvqahg.prg
[2026-09-25 21:14:48] [INFO] VFP output esperado em: C:\4c\tasks\task581\vfp_output.txt
[2026-09-25 21:14:48] [INFO] Executando Visual FoxPro 9...
[2026-09-25 21:14:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aozvqahg.prg
[2026-09-25 21:14:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aozvqahg.prg
[2026-09-25 21:14:48] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigMvVde
Inicio: 25/09/2026 21:14:49

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 25/09/2026 21:17:59
Duracao: 190 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-25 21:17:59] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-25 21:17:59] [INFO] VFP9 finalizado em 190.8996289 segundos
[2026-09-25 21:17:59] [INFO] Exit Code: 
[2026-09-25 21:17:59] [INFO] 
[2026-09-25 21:17:59] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-25 21:17:59] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aozvqahg.prg
[2026-09-25 21:17:59] [INFO] 
[2026-09-25 21:17:59] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-25 21:17:59] [INFO] * Auto-generated wrapper for parameters
[2026-09-25 21:17:59] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 21:17:59] [INFO] * Parameters: 'FormSigMvVde', 'C:\4c\tasks\task581\logs\06_testForm.log'
[2026-09-25 21:17:59] [INFO] 
[2026-09-25 21:17:59] [INFO] * Anti-dialog protections for unattended execution
[2026-09-25 21:17:59] [INFO] SET SAFETY OFF
[2026-09-25 21:17:59] [INFO] SET RESOURCE OFF
[2026-09-25 21:17:59] [INFO] SET TALK OFF
[2026-09-25 21:17:59] [INFO] SET NOTIFY OFF
[2026-09-25 21:17:59] [INFO] SYS(2335, 0)
[2026-09-25 21:17:59] [INFO] 
[2026-09-25 21:17:59] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigMvVde', 'C:\4c\tasks\task581\logs\06_testForm.log'
[2026-09-25 21:17:59] [INFO] QUIT
[2026-09-25 21:17:59] [INFO] 
[2026-09-25 21:17:59] [INFO] === Fim do Wrapper.prg ===
[2026-09-25 21:17:59] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvVde.prg):
*==============================================================================
* FormSigMvVde.prg - Formulario Operacional: Selecao de Vendedores
* Herda de: FormBase
* Origem:  SIGMVVDE.SCX
* BO:      SigMvVdeBO
*
* Dialogo modal (sem tabela propria) que resolve 11 vendedores (contas de
* SigCdCli) e devolve os codigos escolhidos ao chamador via go_4c_Vendedor
* (equivalente ao goVendedor global do legado). Layout OPERACIONAL flat -
* o legado (SIGMVVDE.SCX) nao usa PageFrame nenhum (raiz Class: form
* generico, sem BaseClass: pageframe no dump), entao este form tambem NAO
* usa Page1/Page2: todos os controles vao direto no form.
*
* Legado tinha um Commandgroup3 com ButtonCount = 0 (artefato morto do
* framework, sem nenhum botao) - intencionalmente NAO migrado.
*
* MIGRADO (Fase 3/8 - Estrutura Base):
*   - DEFINE CLASS + propriedades visuais (620x460, identico ao legado)
*   - Init() cria SigMvVdeBO e delega ao FormBase.Init via DODEFAULT()
*   - InicializarForm() monta a faixa do cabecalho
*   - ConfigurarCabecalho() (cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo,
*     mapeamento.json: SIGMVVDE.cntSombra -> cnt_4c_Sombra)
*   - TornarControlesVisiveis() recursivo (AddObject cria Visible = .F.)
*   - Destroy() libera BO e cursor de lookup
*
* FASE 4/8 (Grid + botoes CRUD da Page1): NAO APLICAVEL a este form. O dump
* do legado (SIGMVVDE.SCX, arvore em SigMvVde_form_codigo_fonte.txt) nao tem
* PageFrame (raiz Class: form, sem BaseClass: pageframe), nao tem Grid/AddCursor/
* pColuna (nenhuma lista de registros) e nenhum dos 33 campos (get_conta0..10 /
* get_grupo0..10 / get_dconta0..10) e ReadOnly - sao campos de ENTRADA editaveis
* com lookup (fwBuscaExt), resolvidos direto pelo unico botao do legado
* (btnSair, Caption "\<Confirmar"). Nao ha "lista" para paginar (Page1) nem
* para CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar): inventar PageFrame
* Lista/Dados ou uma grade aqui violaria o PILAR 1 (fidelidade ao legado) e a
* regra "NUNCA inventar" - o dialogo inteiro cabe na estrutura flat da Fase 3.
* Grid/botoes CRUD ficam de fora deste form; o Confirmar entra na Fase 8.
* O gate da Fase 4 (OrquestradorMigracao.ps1) reconhece esse caso pelo ramo
* "layout captura": legado sem lista (teste estrito) + pelo menos um campo
* EDITAVEL - terceiro formato, ao lado de DESPACHANTE (sem lista e sem campos)
* e EXIBICAO (sem lista e todos os campos ReadOnly).
*
* FASE 5/8 (Campos - Parte 1): ConfigurarCampos() adiciona as linhas A, 1, 2,
* 3, 4 e 5 (6 das 11 linhas) direto em THIS (form flat, sem PageFrame/Page2 -
* ver nota da Fase 4 acima). Cada linha replica 3 labels de coluna ("Conta"/
* "Nome"/"Grupo", Left/Top exatos do dump legado, sem Width/AutoSize porque o
* SCX tambem nao declara - regra #23, ForeColor=RGB(90,90,90) confirmado no
* dump), 1 label de indicador de linha ("A :".."5 :", Width/Height do dump) e
* 3 TextBox (Conta/DConta/Grupo, FontName="Verdana" FontSize=8 - dump nao usa
* Tahoma aqui -, MaxLength 10/40/10 do dump). Nomes: txt_4c_Conta<N>/
* txt_4c_DConta<N>/txt_4c_Grupo<N> (espelham this_cConta<N>/this_cDConta<N>/
* this_cGrupo<N> do BO), lbl_4c_Linha<N> para o indicador de linha. Grupo<N>
* fica EDITAVEL nesta fase (sem ReadOnly): o dump nao declara ReadOnly - o
* bloqueio de foco vem do When() sempre .F. no legado (comportamento.json),
* que sera replicado via BINDEVENT na Fase 7 (nao antecipar Enabled/ReadOnly
* que o SCX nao declara).
*
* FASE 6/8 (Campos restantes e lookups): ConfigurarCamposParte2() completa as
* linhas 6, 7, 8, 9 e 10 (mesmo padrao da Fase 5 - 3 labels de coluna, 1 label
* de indicador de linha, 3 TextBox), com Left/Top/MaxLength EXATOS do dump
* legado (layout.json). ConfigurarLookups() liga TODOS os 11 pares
* Conta<N>/DConta<N> (0..10) ao BO via BINDEVENT KeyPress (ENTER=13/TAB=9/
* F4=115 - regra #34/#37, "Valid" nao dispara de forma confiavel em TextBox
* via BINDEVENT). Cada par tem handler PROPRIO (Conta<N>KeyPress/
* DConta<N>KeyPress) que delega a dois workers compartilhados
* (ProcessarBuscaConta/ProcessarBuscaDConta) parametrizados pelo indice via
* EVALUATE (regra #34 - Controls("nome") nao funciona, mas
* EVALUATE("THIS.txt_4c_X" + indice) sim). Espelha o Valid legado de
* get_contaN (busca exata por IClis) e get_dcontaN (busca exata por RClis)
* via SigMvVdeBO.BuscarContaPorCodigo/BuscarContaPorDescricao; quando a busca
* exata nao acha nada (equivalente a "If Not loLista.plAchouRegistro"),
* AbrirLookupVendedor() abre o picker (FormBuscaAuxiliar, regra #36 - 1o
* arg = gnConnHandle - e #37 - guard this_lAchouRegistro antes do Show(),
* atribuicao so sob this_lSelecionou). Os 3 campos (Conta/DConta/Grupo) sao
* sempre preenchidos juntos, como no legado (This.Parent.get_conta0.Value /
* get_dconta0.Value / get_grupo0.Value no mesmo Valid).
*
* Grupo<N> permanece sem lookup proprio (o legado nunca declara Valid para
* get_grupoN - only When sempre .F., comportamento.json) - o bloqueio de
* foco desse campo fica para a Fase 7, como ja registrado na nota da Fase 5.
*
* Este form NAO tem container "cnt_4c_BotoesAcao (Salvar/Cancelar)" generico
* de CRUD: o legado (SIGMVVDE.SCX) so tem UM botao (btnSair, Caption
* "\<Confirmar") - ver nota da Fase 4. Inventar Salvar/Cancelar aqui violaria
* a regra "NUNCA inventar" - o Confirmar entra na Fase 8, como planejado.
*
* FASE 7/8 (Eventos principais): este form NAO tem CRUD (Incluir/Alterar/
* Visualizar/Excluir - ver notas da Fase 4), entao o boilerplate generico de
* Fase 7 (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick)
* NAO se aplica - inventar esses 4 metodos violaria a regra "NUNCA inventar"
* (nao existem no legado, que so tem btnSair). Os "eventos principais" REAIS
* deste form sao os que faltavam implementar, vindos da Fase 5/6:
*   - ConfigurarBloqueioFocoGrupos(): replica o When() sempre .F. dos 11
*     get_grupoN do legado (comportamento.json). Como o form nao usa
*     READ/GET (arquitetura por objeto direto), "When" so dispara via
*     BINDEVENT - padrao ja usado no projeto para TextBox standalone
*     (Formsigopdiv.prg/FormSIGPDPNS.prg/FormSigPdMp9.prg/FormSigReInv.prg:
*     BINDEVENT(txt, "When", THIS, "XxxWhen") + handler RETURN .F.).
*   - ConfigurarLinhaDivisoria(): Line1 do legado (BorderWidth=2, Top=126,
*     Left=10, Width=486) - elemento visual que faltava desde a Fase 5/6.
*   - ConfigurarBotaoConfirmar() + BtnConfirmarClick(): cria cmd_4c_Confirmar
*     (mapeamento.json: SIGMVVDE.btnSair -> cmd_4c_Confirmar, unico botao do
*     form) e liga o Click. Reproduz o Click legado: Conta0 (slot A) vazio
*     -> grava o sentinela de cancelamento (Chr(254) x10) direto em
*     go_4c_Vendedor.Vendedor00, sem passar por ConfirmarSelecao() (que so
*     grava com Conta0 preenchido - regra "so agir quando #Empty(Conta0)").
*     Conta0 preenchido -> solicita autorizacao via DO FORM SigOpSen WITH
*     "LIBLEILAO", ... TO loc_cRetorno (dialogo generico de senha do
*     framework legado, NAO migrado para a nova arquitetura). ATENCAO: o
*     sigopsen.SCX so existe na pasta do legado (C:\4install\FortyusMC\
*     Fortyus\), fora do SET PATH do config.prg - a chamada FALHA em runtime
*     e por isso roda sob TRY/CATCH com desfecho FAIL-CLOSED; ver a nota
*     completa em BtnConfirmarClick, que tambem registra que apenas
*     FormSigPdMp9/FormSigPrGlx chamam SigOpSen de fato (ambos sem guard).
*     Autorizado (retorno comeca com "*") ->
*     SigMvVdeBO.ConfirmarSelecao(.T.) copia Conta0..Conta10 para
*     go_4c_Vendedor.Vendedor00..Vendedor10. Negado -> MsgAviso (regra:
*     validacao de fluxo, nao excecao tecnica) + ConfirmarSelecao(.F.)
*     (sentinela). Em TODOS os caminhos, THIS.Release() roda exatamente
*     uma vez no fim, como o "ThisForm.Release()" unico do legado (a
*     ordem If/Else do legado so evita reexecutar a linha, nao muda o
*     resultado - todo caminho fecha o form uma vez so).
*
* FASE 8/8 (Eventos auxiliares e consolidacao final): este form NAO tem lista/
* grid nem modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR (ver notas da Fase 4), e o
* unico botao (Confirmar) ja foi implementado na Fase 7 - por isso o
* boilerplate generico de Fase 8 (BtnBuscarClick/BtnEncerrarClick/
* BtnSalvarClick/BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
* AjustarBotoesPorModo) NAO se aplica aqui: inventar esses metodos violaria a
* regra "NUNCA inventar" (nao existem correspondente no legado, que so tem
* btnSair). O que de fato faltava, e foi completado nesta fase, e a ponte de
* dados Form<->BO que a Fase 6/7 ainda nao tinham implementado:
*   - FormParaBO()/BOParaForm(): os 33 campos de tela (Conta<N>/DConta<N>/
*     Grupo<N>, slots 0..10) so existiam como TextBox - ValidarSelecao()/
*     ConfirmarSelecao() do BO leem exclusivamente as properties
*     this_cConta<N>/this_cDConta<N>/this_cGrupo<N>, que nunca eram
*     atualizadas a partir da tela. BtnConfirmarClick agora chama THIS.FormParaBO()
*     como primeira linha, antes de ValidarSelecao()/ConfirmarSelecao().
*     BOParaForm() (contrapartida) e chamado em InicializarForm, por simetria
*     arquitetural e para nao regredir se o Init ganhar uma pre-selecao no
*     futuro (o legado nao aceita parametro de entrada - comportamento.json).
*   - menu.prg: bar 141 do popMovimentos ("Selecao de Vendedores") +
*     PROCEDURE AbrirFormSigMvVde() (padrao canonico dos demais forms
*     OPERACIONAIS, ver AbrirFormSIGMVTI2 como referencia).
*   - RENOMEACAO do botao de acao: cmd_4c_BtnSair -> cmd_4c_Confirmar e
*     BtnSairClick() -> BtnConfirmarClick(). O NOME DO OBJETO no legado
*     (btnSair) eh um MISNOMER: o Caption que o usuario le eh "\<Confirmar"
*     e o corpo do Click NAO se limita a fechar a tela - ele eh a UNICA via
*     de persistencia do form (pede autorizacao via SigOpSen e grava
*     Conta0..Conta10 em goVendedor). Herdar o nome do legado aqui violaria
*     o PILAR 3 (nomes do migrado OBRIGATORIAMENTE diferentes do legado) e,
*     pior, esconderia de quem le o codigo que este handler eh o ponto de
*     gravacao - "BtnSair" sugere que so encerra. NAO reverter para
*     BtnSairClick: esse nome esta correto em FormSIGMVCTH/Formsigmvcot,
*     onde o Click legado de fato so faz ThisForm.Release(). O mapeamento
*     (tasks\task581\mapeamento.json, SIGMVVDE.btnSair) foi atualizado
*     junto - renomear o objeto sem atualizar o JSON quebra o
*     ValidarUIFidelity, que monta o caminho a partir dele.
*
* GEOMETRIA do botao (transcrita, nao inventada): o SCX declara apenas
* Top=3/Left=543/Picture/Cancel/Caption/TabIndex - Width=80, Height=100,
* FontName="Comic Sans MS", FontBold/FontItalic, FontSize=8, WordWrap,
* MousePointer=15, ForeColor=90,90,90, BackColor=255,255,255 e Themes=.F.
* vem da CLASSE fwbtng (docs\FRAMEWORK_class_codigo_fonte.txt). Left+Width
* da 623 contra Form.Width=620, ou seja o legado JA extrapola 3px e o VFP
* recorta essa faixa (regra #30) - overflow HERDADO do SCX (regra #28),
* reproduzido de proposito: mexer no Left/Width divergiria do legado
* (PILAR 1) para corrigir 3px invisiveis num botao de 80px.
*
* config.prg: nenhuma alteracao necessaria - ADIR() carrega SigMvVdeBO.prg e
* FormSigMvVde.prg automaticamente (CLAUDE.md - "config.prg - Dynamic Loading").
*==============================================================================

DEFINE CLASS FormSigMvVde AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form (identicas ao legado SIGMVVDE.SCX)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 620
    Height       = 460
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Vendedores"

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_cModoAtual = "PROCURAR"

    *==========================================================================
    * Init - Cria o Business Object e delega ao FormBase.Init
    *==========================================================================
    FUNCTION Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SigMvVdeBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SigMvVdeBO.", "Erro")
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form
    * Contrato do FormBase.Init: retornar .T. em sucesso, .F. em falha
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.ConfigurarCabecalho()

            THIS.ConfigurarCampos()
            THIS.ConfigurarCamposParte2()

            THIS.ConfigurarLookups()
            THIS.ConfigurarBloqueioFocoGrupos()

            THIS.ConfigurarLinhaDivisoria()
            THIS.ConfigurarBotaoConfirmar()

            *-- Espelha eventual pre-selecao ja carregada no BO (CarregarDoCursor)
            *-- nos 33 campos de tela. Sem call site hoje (o legado nao aceita
            *-- parametro de entrada - comportamento.json), mas mantido para
            *-- simetria com FormParaBO e para nao regredir se o Init ganhar
            *-- LPARAMETERS de pre-selecao no futuro. Inofensivo: BO nasce com
            *-- todas as properties "" e os campos ja foram inicializados "".
            THIS.BOParaForm()

            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigMvVde.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza com titulo (cntSombra do legado)
    * mapeamento.json: cntSombra -> cnt_4c_Sombra, lblSombra -> lbl_4c_LblSombra,
    * lblTitulo -> lbl_4c_LblTitulo. Identificacao por BackColor+Height (regra
    * #11), nunca pelo nome - aqui o nome do legado (cntSombra) foi preservado
    * no mapeamento porque este form nao segue o padrao frmcadastro.
    * Sem PageFrame, entao sem compensacao de +29 no Top.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
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
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Linhas A, 1, 2, 3, 4 e 5 (primeira metade das 11
    * linhas de vendedor). Cada linha: 3 labels de coluna (Conta/Nome/Grupo),
    * 1 label de indicador de linha e 3 TextBox (Conta/DConta/Grupo).
    * Posicoes/MaxLength/FontName EXATOS do dump legado (SigMvVde_form_
    * codigo_fonte.txt) - mapeamento.json preserva os nomes originais dos
    * Say*/get_* mas os controles migrados usam nomenclatura por indice
    * (lbl_4c_Linha<N>, txt_4c_Conta<N>/DConta<N>/Grupo<N>) para bater com
    * as properties this_cConta<N>/this_cDConta<N>/this_cGrupo<N> do BO.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Linha A (slot 0) - Say23/Say21/Say22/Say24, get_conta0/dconta0/grupo0
        THIS.AddObject("lbl_4c_Conta0", "Label")
        WITH THIS.lbl_4c_Conta0
            .Top       = 86
            .Left      = 30
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome0", "Label")
        WITH THIS.lbl_4c_Nome0
            .Top       = 86
            .Left      = 113
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo0", "Label")
        WITH THIS.lbl_4c_Grupo0
            .Top       = 86
            .Left      = 418
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha0", "Label")
        WITH THIS.lbl_4c_Linha0
            .Top       = 100
            .Left      = 9
            .Width     = 16
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "A :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta0", "TextBox")
        WITH THIS.txt_4c_Conta0
            .Top            = 98
            .Left           = 30
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta0", "TextBox")
        WITH THIS.txt_4c_DConta0
            .Top            = 98
            .Left           = 113
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo0", "TextBox")
        WITH THIS.txt_4c_Grupo0
            .Top            = 98
            .Left           = 418
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 1 (slot 1) - Say2/Say_dConta/Say1/Say3, Get_conta1/dconta1/grupo1
        THIS.AddObject("lbl_4c_Conta1", "Label")
        WITH THIS.lbl_4c_Conta1
            .Top       = 132
            .Left      = 30
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome1", "Label")
        WITH THIS.lbl_4c_Nome1
            .Top       = 132
            .Left      = 113
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo1", "Label")
        WITH THIS.lbl_4c_Grupo1
            .Top       = 132
            .Left      = 418
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha1", "Label")
        WITH THIS.lbl_4c_Linha1
            .Top       = 146
            .Left      = 9
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "1 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta1", "TextBox")
        WITH THIS.txt_4c_Conta1
            .Top            = 144
            .Left           = 30
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta1", "TextBox")
        WITH THIS.txt_4c_DConta1
            .Top            = 144
            .Left           = 113
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo1", "TextBox")
        WITH THIS.txt_4c_Grupo1
            .Top            = 144
            .Left           = 418
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 2 (slot 2) - Say6/Say4/Say5/Say7, get_conta2/dconta2/grupo2
        THIS.AddObject("lbl_4c_Conta2", "Label")
        WITH THIS.lbl_4c_Conta2
            .Top       = 164
            .Left      = 30
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome2", "Label")
        WITH THIS.lbl_4c_Nome2
            .Top       = 164
            .Left      = 113
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo2", "Label")
        WITH THIS.lbl_4c_Grupo2
            .Top       = 164
            .Left      = 418
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha2", "Label")
        WITH THIS.lbl_4c_Linha2
            .Top       = 178
            .Left      = 9
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "2 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta2", "TextBox")
        WITH THIS.txt_4c_Conta2
            .Top            = 176
            .Left           = 30
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta2", "TextBox")
        WITH THIS.txt_4c_DConta2
            .Top            = 176
            .Left           = 113
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo2", "TextBox")
        WITH THIS.txt_4c_Grupo2
            .Top            = 176
            .Left           = 418
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 3 (slot 3) - Say11/Say9/Say10/Say12, get_conta3/dconta3/grupo3
        THIS.AddObject("lbl_4c_Conta3", "Label")
        WITH THIS.lbl_4c_Conta3
            .Top       = 196
            .Left      = 29
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome3", "Label")
        WITH THIS.lbl_4c_Nome3
            .Top       = 196
            .Left      = 112
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo3", "Label")
        WITH THIS.lbl_4c_Grupo3
            .Top       = 196
            .Left      = 417
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha3", "Label")
        WITH THIS.lbl_4c_Linha3
            .Top       = 210
            .Left      = 8
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "3 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta3", "TextBox")
        WITH THIS.txt_4c_Conta3
            .Top            = 208
            .Left           = 29
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta3", "TextBox")
        WITH THIS.txt_4c_DConta3
            .Top            = 208
            .Left           = 112
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo3", "TextBox")
        WITH THIS.txt_4c_Grupo3
            .Top            = 208
            .Left           = 417
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 4 (slot 4) - Say15/Say13/Say14/Say16, get_conta4/dconta4/grupo4
        THIS.AddObject("lbl_4c_Conta4", "Label")
        WITH THIS.lbl_4c_Conta4
            .Top       = 228
            .Left      = 29
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome4", "Label")
        WITH THIS.lbl_4c_Nome4
            .Top       = 228
            .Left      = 112
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo4", "Label")
        WITH THIS.lbl_4c_Grupo4
            .Top       = 228
            .Left      = 417
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha4", "Label")
        WITH THIS.lbl_4c_Linha4
            .Top       = 242
            .Left      = 8
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "4 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta4", "TextBox")
        WITH THIS.txt_4c_Conta4
            .Top            = 240
            .Left           = 29
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta4", "TextBox")
        WITH THIS.txt_4c_DConta4
            .Top            = 240
            .Left           = 112
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo4", "TextBox")
        WITH THIS.txt_4c_Grupo4
            .Top            = 240
            .Left           = 417
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 5 (slot 5) - Say19/Say17/Say18/Say20, get_conta5/dconta5/grupo5
        THIS.AddObject("lbl_4c_Conta5", "Label")
        WITH THIS.lbl_4c_Conta5
            .Top       = 260
            .Left      = 29
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome5", "Label")
        WITH THIS.lbl_4c_Nome5
            .Top       = 260
            .Left      = 112
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo5", "Label")
        WITH THIS.lbl_4c_Grupo5
            .Top       = 260
            .Left      = 417
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha5", "Label")
        WITH THIS.lbl_4c_Linha5
            .Top       = 274
            .Left      = 8
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "5 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta5", "TextBox")
        WITH THIS.txt_4c_Conta5
            .Top            = 272
            .Left           = 29
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta5", "TextBox")
        WITH THIS.txt_4c_DConta5
            .Top            = 272
            .Left           = 112
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo5", "TextBox")
        WITH THIS.txt_4c_Grupo5
            .Top            = 272
            .Left           = 417
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposParte2 - Linhas 6, 7, 8, 9 e 10 (segunda metade das 11
    * linhas de vendedor). Mesmo padrao da ConfigurarCampos (Fase 5): 3 labels
    * de coluna (Conta/Nome/Grupo), 1 label de indicador de linha e 3 TextBox
    * (Conta/DConta/Grupo). Posicoes/MaxLength/FontName EXATOS do dump legado
    * (layout.json - Say25..Say43 / get_conta6..10 / get_dconta6..10 /
    * get_grupo6..10).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposParte2()
        *-- Linha 6 (slot 6) - Say26/Say8/Say25/Say27, get_conta6/dconta6/grupo6
        THIS.AddObject("lbl_4c_Conta6", "Label")
        WITH THIS.lbl_4c_Conta6
            .Top       = 292
            .Left      = 30
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome6", "Label")
        WITH THIS.lbl_4c_Nome6
            .Top       = 292
            .Left      = 113
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo6", "Label")
        WITH THIS.lbl_4c_Grupo6
            .Top       = 292
            .Left      = 418
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha6", "Label")
        WITH THIS.lbl_4c_Linha6
            .Top       = 306
            .Left      = 9
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "6 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta6", "TextBox")
        WITH THIS.txt_4c_Conta6
            .Top            = 304
            .Left           = 30
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta6", "TextBox")
        WITH THIS.txt_4c_DConta6
            .Top            = 304
            .Left           = 113
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo6", "TextBox")
        WITH THIS.txt_4c_Grupo6
            .Top            = 304
            .Left           = 418
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 7 (slot 7) - Say30/Say28/Say29/Say31, get_conta7/dconta7/grupo7
        THIS.AddObject("lbl_4c_Conta7", "Label")
        WITH THIS.lbl_4c_Conta7
            .Top       = 324
            .Left      = 30
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome7", "Label")
        WITH THIS.lbl_4c_Nome7
            .Top       = 324
            .Left      = 113
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo7", "Label")
        WITH THIS.lbl_4c_Grupo7
            .Top       = 324
            .Left      = 418
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha7", "Label")
        WITH THIS.lbl_4c_Linha7
            .Top       = 338
            .Left      = 9
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "7 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta7", "TextBox")
        WITH THIS.txt_4c_Conta7
            .Top            = 336
            .Left           = 30
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta7", "TextBox")
        WITH THIS.txt_4c_DConta7
            .Top            = 336
            .Left           = 113
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo7", "TextBox")
        WITH THIS.txt_4c_Grupo7
            .Top            = 336
            .Left           = 418
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 8 (slot 8) - Say34/Say32/Say33/Say35, get_conta8/dconta8/grupo8
        THIS.AddObject("lbl_4c_Conta8", "Label")
        WITH THIS.lbl_4c_Conta8
            .Top       = 356
            .Left      = 29
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome8", "Label")
        WITH THIS.lbl_4c_Nome8
            .Top       = 356
            .Left      = 112
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo8", "Label")
        WITH THIS.lbl_4c_Grupo8
            .Top       = 356
            .Left      = 417
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha8", "Label")
        WITH THIS.lbl_4c_Linha8
            .Top       = 370
            .Left      = 8
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "8 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta8", "TextBox")
        WITH THIS.txt_4c_Conta8
            .Top            = 368
            .Left           = 29
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta8", "TextBox")
        WITH THIS.txt_4c_DConta8
            .Top            = 368
            .Left           = 112
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo8", "TextBox")
        WITH THIS.txt_4c_Grupo8
            .Top            = 368
            .Left           = 417
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 9 (slot 9) - Say38/Say36/Say37/Say39, get_conta9/dconta9/grupo9
        THIS.AddObject("lbl_4c_Conta9", "Label")
        WITH THIS.lbl_4c_Conta9
            .Top       = 388
            .Left      = 29
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome9", "Label")
        WITH THIS.lbl_4c_Nome9
            .Top       = 388
            .Left      = 112
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo9", "Label")
        WITH THIS.lbl_4c_Grupo9
            .Top       = 388
            .Left      = 417
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha9", "Label")
        WITH THIS.lbl_4c_Linha9
            .Top       = 402
            .Left      = 8
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "9 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta9", "TextBox")
        WITH THIS.txt_4c_Conta9
            .Top            = 400
            .Left           = 29
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta9", "TextBox")
        WITH THIS.txt_4c_DConta9
            .Top            = 400
            .Left           = 112
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo9", "TextBox")
        WITH THIS.txt_4c_Grupo9
            .Top            = 400
            .Left           = 417
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Linha 10 (slot 10) - Say42/Say40/Say41/Say43, get_conta10/dconta10/grupo10
        THIS.AddObject("lbl_4c_Conta10", "Label")
        WITH THIS.lbl_4c_Conta10
            .Top       = 420
            .Left      = 29
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Nome10", "Label")
        WITH THIS.lbl_4c_Nome10
            .Top       = 420
            .Left      = 112
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo10", "Label")
        WITH THIS.lbl_4c_Grupo10
            .Top       = 420
            .Left      = 417
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Linha10", "Label")
        WITH THIS.lbl_4c_Linha10
            .Top       = 434
            .Left      = 0
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "10 :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta10", "TextBox")
        WITH THIS.txt_4c_Conta10
            .Top            = 432
            .Left           = 29
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_DConta10", "TextBox")
        WITH THIS.txt_4c_DConta10
            .Top            = 432
            .Left           = 112
            .Width          = 302
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 40
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.AddObject("txt_4c_Grupo10", "TextBox")
        WITH THIS.txt_4c_Grupo10
            .Top            = 432
            .Left           = 417
            .Width          = 80
            .Height         = 18
            .FontName       = "Verdana"
            .FontSize       = 8
            .MaxLength      = 10
            .Value          = ""
            .Margin         = 0
            .SpecialEffect  = 1
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarLookups - Liga os 11 pares Conta<N>/DConta<N> (0..10) ao BO.
    * BINDEVENT em "KeyPress" (nao "Valid" - nao dispara de forma confiavel em
    * TextBox via BINDEVENT, regra #34/#37). Cada campo tem handler PROPRIO
    * (Conta<N>KeyPress/DConta<N>KeyPress) porque BINDEVENT nao repassa o
    * objeto de origem ao handler - so os parametros nativos do evento
    * (par_nKeyCode, par_nShiftAltCtrl) - entao o indice tem que ser literal.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLookups()
        BINDEVENT(THIS.txt_4c_Conta0,  "KeyPress", THIS, "Conta0KeyPress")
        BINDEVENT(THIS.txt_4c_DConta0, "KeyPress", THIS, "DConta0KeyPress")
        BINDEVENT(THIS.txt_4c_Conta1,  "KeyPress", THIS, "Conta1KeyPress")
        BINDEVENT(THIS.txt_4c_DConta1, "KeyPress", THIS, "DConta1KeyPress")
        BINDEVENT(THIS.txt_4c_Conta2,  "KeyPress", THIS, "Conta2KeyPress")
        BINDEVENT(THIS.txt_4c_DConta2, "KeyPress", THIS, "DConta2KeyPress")
        BINDEVENT(THIS.txt_4c_Conta3,  "KeyPress", THIS, "Conta3KeyPress")
        BINDEVENT(THIS.txt_4c_DConta3, "KeyPress", THIS, "DConta3KeyPress")
        BINDEVENT(THIS.txt_4c_Conta4,  "KeyPress", THIS, "Conta4KeyPress")
        BINDEVENT(THIS.txt_4c_DConta4, "KeyPress", THIS, "DConta4KeyPress")
        BINDEVENT(THIS.txt_4c_Conta5,  "KeyPress", THIS, "Conta5KeyPress")
        BINDEVENT(THIS.txt_4c_DConta5, "KeyPress", THIS, "DConta5KeyPress")
        BINDEVENT(THIS.txt_4c_Conta6,  "KeyPress", THIS, "Conta6KeyPress")
        BINDEVENT(THIS.txt_4c_DConta6, "KeyPress", THIS, "DConta6KeyPress")
        BINDEVENT(THIS.txt_4c_Conta7,  "KeyPress", THIS, "Conta7KeyPress")
        BINDEVENT(THIS.txt_4c_DConta7, "KeyPress", THIS, "DConta7KeyPress")
        BINDEVENT(THIS.txt_4c_Conta8,  "KeyPress", THIS, "Conta8KeyPress")
        BINDEVENT(THIS.txt_4c_DConta8, "KeyPress", THIS, "DConta8KeyPress")
        BINDEVENT(THIS.txt_4c_Conta9,  "KeyPress", THIS, "Conta9KeyPress")
        BINDEVENT(THIS.txt_4c_DConta9, "KeyPress", THIS, "DConta9KeyPress")
        BINDEVENT(THIS.txt_4c_Conta10,  "KeyPress", THIS, "Conta10KeyPress")
        BINDEVENT(THIS.txt_4c_DConta10, "KeyPress", THIS, "DConta10KeyPress")
    ENDPROC

    *==========================================================================
    * ConfigurarBloqueioFocoGrupos - Grupo<N> nunca recebe foco (get_grupoN.
    * When sempre .F. no legado, 11 ocorrencias - comportamento.json). O
    * campo e preenchido automaticamente pelo lookup de Conta/DConta (Fase 6)
    * e nunca editado diretamente pelo usuario. BINDEVENT("When", ...) e o
    * padrao ja usado no projeto para reproduzir bloqueio de foco em TextBox
    * standalone (Formsigopdiv.prg/FormSIGPDPNS.prg/FormSigPdMp9.prg/
    * FormSigReInv.prg).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBloqueioFocoGrupos()
        BINDEVENT(THIS.txt_4c_Grupo0,  "When", THIS, "Grupo0When")
        BINDEVENT(THIS.txt_4c_Grupo1,  "When", THIS, "Grupo1When")
        BINDEVENT(THIS.txt_4c_Grupo2,  "When", THIS, "Grupo2When")
        BINDEVENT(THIS.txt_4c_Grupo3,  "When", THIS, "Grupo3When")
        BINDEVENT(THIS.txt_4c_Grupo4,  "When", THIS, "Grupo4When")
        BINDEVENT(THIS.txt_4c_Grupo5,  "When", THIS, "Grupo5When")
        BINDEVENT(THIS.txt_4c_Grupo6,  "When", THIS, "Grupo6When")
        BINDEVENT(THIS.txt_4c_Grupo7,  "When", THIS, "Grupo7When")
        BINDEVENT(THIS.txt_4c_Grupo8,  "When", THIS, "Grupo8When")
        BINDEVENT(THIS.txt_4c_Grupo9,  "When", THIS, "Grupo9When")
        BINDEVENT(THIS.txt_4c_Grupo10, "When", THIS, "Grupo10When")
    ENDPROC

    PROCEDURE Grupo0When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo1When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo2When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo3When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo4When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo5When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo6When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo7When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo8When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo9When()
        RETURN .F.
    ENDPROC

    PROCEDURE Grupo10When()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ConfigurarLinhaDivisoria - Line1 do legado: divisor horizontal abaixo
    * da linha "A" de campos. BorderWidth/Top/Left/Width EXATOS do dump
    * (SECAO 2 - SigMvVde_form_codigo_fonte.txt).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLinhaDivisoria()
        THIS.AddObject("lin_4c_Line1", "Line")
        WITH THIS.lin_4c_Line1
            .Top         = 126
            .Left        = 10
            .Width       = 486
            .Height      = 0
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoConfirmar - btnSair do legado (mapeamento.json:
    * SIGMVVDE.btnSair -> cmd_4c_Confirmar). Unico botao deste form - ver nota
    * da Fase 4/7 no cabecalho. Top/Left/Picture/Cancel/Caption EXATOS do
    * dump; Width/Height/FontName/FontSize/FontBold/FontItalic/ForeColor/
    * BackColor/Themes/MousePointer/WordWrap = defaults da classe fwbtng
    * (framework.vcx) porque o SCX nao os sobrescreve.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoConfirmar()
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top          = 3
            .Left         = 543
            .Width        = 80
            .Height       = 100
            .Caption      = "\<Confirmar"
            .Picture      = gc_4c_CaminhoIcones + "geral_login_60.jpg"
            .Cancel       = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes           = .T.
            .MousePointer = 15
            .WordWrap     = .T.
            .Visible      = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia os 33 campos de tela (txt_4c_Conta<N>/DConta<N>/
    * Grupo<N>, slots 0..10) para as properties correspondentes do BO
    * (this_cConta<N>/this_cDConta<N>/this_cGrupo<N>). Chamado por
    * BtnConfirmarClick ANTES de ValidarSelecao()/ConfirmarSelecao() - sem esta
    * copia, o BO nunca enxergaria o que os lookups (Fase 6) escreveram nos
    * TextBox, e ValidarSelecao()/ConfirmarSelecao() sempre veriam
    * this_cConta0 vazio (propriedade nunca atualizada).
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_nI

        FOR loc_nI = 0 TO 10
            STORE ALLTRIM(EVALUATE("THIS.txt_4c_Conta"  + TRANSFORM(loc_nI) + ".Value")) TO ("THIS.this_oBusinessObject.this_cConta"  + TRANSFORM(loc_nI))
            STORE ALLTRIM(EVALUATE("THIS.txt_4c_DConta" + TRANSFORM(loc_nI) + ".Value")) TO ("THIS.this_oBusinessObject.this_cDConta" + TRANSFORM(loc_nI))
            STORE ALLTRIM(EVALUATE("THIS.txt_4c_Grupo"  + TRANSFORM(loc_nI) + ".Value")) TO ("THIS.this_oBusinessObject.this_cGrupo"  + TRANSFORM(loc_nI))
        ENDFOR

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * BOParaForm - Contrapartida de FormParaBO: copia as properties do BO
    * (this_cConta<N>/this_cDConta<N>/this_cGrupo<N>, slots 0..10) de volta
    * para os 33 campos de tela. Usado em InicializarForm para espelhar uma
    * eventual pre-selecao ja carregada no BO (CarregarDoCursor).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_nI

        FOR loc_nI = 0 TO 10
            STORE EVALUATE("THIS.this_oBusinessObject.this_cConta"  + TRANSFORM(loc_nI)) TO ("THIS.txt_4c_Conta"  + TRANSFORM(loc_nI) + ".Value")
            STORE EVALUATE("THIS.this_oBusinessObject.this_cDConta" + TRANSFORM(loc_nI)) TO ("THIS.txt_4c_DConta" + TRANSFORM(loc_nI) + ".Value")
            STORE EVALUATE("THIS.this_oBusinessObject.this_cGrupo"  + TRANSFORM(loc_nI)) TO ("THIS.txt_4c_Grupo"  + TRANSFORM(loc_nI) + ".Value")
        ENDFOR
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - cmd_4c_Confirmar.Click. Espelha o Click legado (ver nota
    * completa no cabecalho do arquivo, secao Fase 7): Conta0 vazio grava o
    * sentinela de cancelamento direto; Conta0 preenchido pede autorizacao
    * via DO FORM SigOpSen antes de persistir a selecao via
    * SigMvVdeBO.ConfirmarSelecao().
    *
    * SigOpSen NAO EXISTE na nova arquitetura - medido no VFP9 em 2026-09-25:
    * o sigopsen.SCX so existe em C:\4install\FortyusMC\Fortyus\ (pasta do
    * legado), que NAO esta no SET PATH montado pelo config.prg (base, classes,
    * utils, forms, icones). O "DO FORM SigOpSen" dispara erro 1
    * "File 'c:\4c\projeto\app\start\sigopsen.scx' does not exist." Sem o
    * TRY/CATCH abaixo esse erro sobe como "Program Error" CRU do VFP (regra
    * #38) e, pior, ABORTA o metodo antes de qualquer ConfirmarSelecao: a
    * selecao nunca era gravada em go_4c_Vendedor e a UNICA funcao deste
    * dialogo ficava quebrada no caminho principal (Conta0 preenchido).
    *
    * Por ser um gate de AUTORIZACAO, a falha eh tratada FAIL-CLOSED: dialogo
    * indisponivel => NAO autorizado, mesmo desfecho do "Autorizacao nao
    * confirmada" do legado (sentinela Chr(254)x10 via ConfirmarSelecao(.F.)).
    * PROIBIDO substituir por MsgConfirma/skip: seria conceder liberacao de
    * leilao sem senha, em silencio. A ausencia da dependencia fica VISIVEL em
    * MsgErro (regra #27 - ausencia tem de ficar visivel), nao mascarada.
    *
    * O TRY cobre SO a chamada do dialogo (regra #29): a avaliacao do retorno e
    * a gravacao ficam FORA do bloco.
    *
    * NAO citar "mesmo padrao dos outros forms" como precedente: conferido em
    * 2026-09-25, apenas FormSigPdMp9.prg:1836 e FormSigPrGlx.prg:2717 chamam
    * DO FORM SigOpSen (ambos SEM guard - mesmo defeito latente); Formsigmvitn
    * e Formsigmvits apenas MENCIONAM SigOpSen em comentario e nunca o chamam
    * (o Formsigmvits inclusive registra "nao tem equivalente migrado").
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_cRetorno, loc_lAutorizado, loc_lDialogoAbriu, loc_cFalhaDialogo, loc_oErro

        *-- Sem esta copia, o BO nunca veria os valores digitados/selecionados
        *-- pelos lookups (Fase 6) - ValidarSelecao()/ConfirmarSelecao() leem
        *-- exclusivamente as properties this_cConta<N>/this_cDConta<N>/
        *-- this_cGrupo<N>, nunca os TextBox diretamente.
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.ValidarSelecao()
            loc_cRetorno      = ""
            loc_cFalhaDialogo = ""
            loc_lDialogoAbriu = .F.

            TRY
                DO FORM SigOpSen WITH "LIBLEILAO", "Libera Leil" + CHR(227) + "o", "" TO loc_cRetorno
                loc_lDialogoAbriu = .T.
            CATCH TO loc_oErro
                loc_cFalhaDialogo = loc_oErro.Message
            ENDTRY

            CLEAR TYPEAHEAD

            IF loc_lDialogoAbriu
                loc_lAutorizado = (LEFT(ALLTRIM(NVL(loc_cRetorno, "")), 1) = "*")

                IF !loc_lAutorizado
                    MsgAviso("Autoriza" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o confirmada!!", ;
                             "Libera Leil" + CHR(227) + "o")
                ENDIF
            ELSE
                *-- FAIL-CLOSED: sem o dialogo de senha nao se libera nada.
                loc_lAutorizado = .F.
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de " + ;
                        "autoriza" + CHR(231) + CHR(227) + "o (SigOpSen)." + CHR(13) + ;
                        "A sele" + CHR(231) + CHR(227) + "o de vendedores N" + CHR(195) + "O foi " + ;
                        "confirmada." + CHR(13) + CHR(13) + ;
                        "Detalhe: " + loc_cFalhaDialogo, ;
                        "Libera Leil" + CHR(227) + "o")
            ENDIF

            THIS.this_oBusinessObject.ConfirmarSelecao(loc_lAutorizado)
        ELSE
            *-- Conta0 vazio: o legado grava o sentinela de cancelamento
            *-- mesmo assim (Else goVendedor.Vendedor00 = Replicate(Chr(254),10)).
            *-- ConfirmarSelecao() so grava com Conta0 preenchido, entao o
            *-- sentinela vai direto em go_4c_Vendedor aqui.
            IF TYPE("go_4c_Vendedor") = "O"
                go_4c_Vendedor.Vendedor00 = REPLICATE(CHR(254), 10)
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * Handlers KeyPress dos 11 pares Conta<N>/DConta<N> - cada um delega ao
    * worker compartilhado (ProcessarBuscaConta/ProcessarBuscaDConta) passando
    * o indice literal. PUBLIC (BINDEVENT exige - regra #3) e com LPARAMETERS
    * via assinatura (regra do KeyPress handler).
    *==========================================================================
    PROCEDURE Conta0KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(0, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta0KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(0, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(1, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(1, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(2, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(2, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(3, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(3, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(4, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(4, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(5, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(5, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta6KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(6, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta6KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(6, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta7KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(7, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta7KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(7, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(8, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(8, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta9KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(9, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta9KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(9, par_nKeyCode)
    ENDPROC

    PROCEDURE Conta10KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaConta(10, par_nKeyCode)
    ENDPROC

    PROCEDURE DConta10KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarBuscaDConta(10, par_nKeyCode)
    ENDPROC

    *==========================================================================
    * ProcessarBuscaConta - Espelha o Valid legado de get_contaN: busca exata
    * por IClis (SigMvVdeBO.BuscarContaPorCodigo). Achando, preenche
    * Conta/DConta/Grupo do slot (This.Parent.get_conta0.Value/get_dconta0.
    * Value/get_grupo0.Value no legado). Nao achando (equivalente a
    * "If Not loLista.plAchouRegistro"), abre o picker via AbrirLookupVendedor.
    * Indice acessado por EVALUATE (regra #34 - Controls("nome") nao funciona).
    *==========================================================================
    PROCEDURE ProcessarBuscaConta(par_nIndice, par_nKeyCode)
        LOCAL loc_oTxtConta, loc_oTxtDConta, loc_oTxtGrupo, loc_cValor

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_oTxtConta  = EVALUATE("THIS.txt_4c_Conta"  + TRANSFORM(par_nIndice))
        loc_oTxtDConta = EVALUATE("THIS.txt_4c_DConta" + TRANSFORM(par_nIndice))
        loc_oTxtGrupo  = EVALUATE("THIS.txt_4c_Grupo"  + TRANSFORM(par_nIndice))

        loc_cValor = ALLTRIM(loc_oTxtConta.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarContaPorCodigo(loc_cValor)
            IF USED("cursor_4c_VdeBusca")
                loc_oTxtConta.Value  = ALLTRIM(NVL(cursor_4c_VdeBusca.IClis, ""))
                loc_oTxtDConta.Value = ALLTRIM(NVL(cursor_4c_VdeBusca.RClis, ""))
                loc_oTxtGrupo.Value  = ALLTRIM(NVL(cursor_4c_VdeBusca.Grupos, ""))
            ENDIF
        ELSE
            THIS.AbrirLookupVendedor(par_nIndice, "IClis", loc_cValor)
        ENDIF
    ENDPROC

    *==========================================================================
    * ProcessarBuscaDConta - Espelha o Valid legado de get_dcontaN: busca
    * exata por RClis (SigMvVdeBO.BuscarContaPorDescricao). Mesma logica de
    * ProcessarBuscaConta, buscando pela descricao em vez do codigo.
    *==========================================================================
    PROCEDURE ProcessarBuscaDConta(par_nIndice, par_nKeyCode)
        LOCAL loc_oTxtConta, loc_oTxtDConta, loc_oTxtGrupo, loc_cValor

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_oTxtConta  = EVALUATE("THIS.txt_4c_Conta"  + TRANSFORM(par_nIndice))
        loc_oTxtDConta = EVALUATE("THIS.txt_4c_DConta" + TRANSFORM(par_nIndice))
        loc_oTxtGrupo  = EVALUATE("THIS.txt_4c_Grupo"  + TRANSFORM(par_nIndice))

        loc_cValor = ALLTRIM(loc_oTxtDConta.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarContaPorDescricao(loc_cValor)
            IF USED("cursor_4c_VdeBusca")
                loc_oTxtConta.Value  = ALLTRIM(NVL(cursor_4c_VdeBusca.IClis, ""))
                loc_oTxtDConta.Value = ALLTRIM(NVL(cursor_4c_VdeBusca.RClis, ""))
                loc_oTxtGrupo.Value  = ALLTRIM(NVL(cursor_4c_VdeBusca.Grupos, ""))
            ENDIF
        ELSE
            THIS.AbrirLookupVendedor(par_nIndice, "RClis", loc_cValor)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupVendedor - Picker SigCdCli (regra #36: 1o arg = gnConnHandle;
    * regra #37: guard this_lAchouRegistro antes do Show(), atribuicao so sob
    * this_lSelecionou). par_cCampoBusca/par_cValorBusca reproduzem o campo e
    * o valor pelo qual o Valid legado tentou a busca exata primeiro (IClis
    * a partir de Conta<N>, RClis a partir de DConta<N>).
    *==========================================================================
    PROCEDURE AbrirLookupVendedor(par_nIndice, par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oBusca, loc_oTxtConta, loc_oTxtDConta, loc_oTxtGrupo

        loc_oTxtConta  = EVALUATE("THIS.txt_4c_Conta"  + TRANSFORM(par_nIndice))
        loc_oTxtDConta = EVALUATE("THIS.txt_4c_DConta" + TRANSFORM(par_nIndice))
        loc_oTxtGrupo  = EVALUATE("THIS.txt_4c_Grupo"  + TRANSFORM(par_nIndice))

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", ;
            "cursor_4c_VdeLookup", ;
            par_cCampoBusca, ;
            ALLTRIM(NVL(par_cValorBusca, "")), ;
            "Sele" + CHR(231) + CHR(227) + "o de Vendedor")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_VdeLookup")
                SELECT cursor_4c_VdeLookup
                loc_oTxtConta.Value  = ALLTRIM(NVL(cursor_4c_VdeLookup.IClis, ""))
                loc_oTxtDConta.Value = ALLTRIM(NVL(cursor_4c_VdeLookup.RClis, ""))
                loc_oTxtGrupo.Value  = ALLTRIM(NVL(cursor_4c_VdeLookup.Grupos, ""))
            ENDIF

            IF USED("cursor_4c_VdeLookup")
                USE IN cursor_4c_VdeLookup
            ENDIF

            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible = .F.
    * Percorre Controls (containers) e Pages (nao ha PageFrame neste form,
    * mas o metodo fica generico/recursivo para reuso nas proximas fases).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursor de lookup e o Business Object. DODEFAULT() no
    * fim (FormBase.Destroy reconstroi o menu principal - regra do menu-shrinks).
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_VdeBusca")
            USE IN cursor_4c_VdeBusca
        ENDIF

        IF USED("cursor_4c_VdeLookup")
            USE IN cursor_4c_VdeLookup
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigMvVdeBO.prg):
*==============================================================================
* SigMvVdeBO.prg
*
* Business Object para SigMvVde (Cadastro/Selecao de Vendedores)
* Form legado: SIGMVVDE.SCX - dialogo modal que resolve 11 vendedores
* (contas de SigCdCli) e devolve os codigos selecionados para o chamador
* via objeto global goVendedor (Vendedor00..Vendedor10).
*
* Tabela de referencia para os lookups: SigCdCli (IClis/RClis/Grupos)
*==============================================================================

DEFINE CLASS SigMvVdeBO AS BusinessBase

    *-- Vendedor 0 (linha "A :" do legado)
    this_cConta0  = ""
    this_cDConta0 = ""
    this_cGrupo0  = ""

    *-- Vendedor 1 (linha "1 :")
    this_cConta1  = ""
    this_cDConta1 = ""
    this_cGrupo1  = ""

    *-- Vendedor 2 (linha "2 :")
    this_cConta2  = ""
    this_cDConta2 = ""
    this_cGrupo2  = ""

    *-- Vendedor 3 (linha "3 :")
    this_cConta3  = ""
    this_cDConta3 = ""
    this_cGrupo3  = ""

    *-- Vendedor 4 (linha "4 :")
    this_cConta4  = ""
    this_cDConta4 = ""
    this_cGrupo4  = ""

    *-- Vendedor 5 (linha "5 :")
    this_cConta5  = ""
    this_cDConta5 = ""
    this_cGrupo5  = ""

    *-- Vendedor 6 (linha "6 :")
    this_cConta6  = ""
    this_cDConta6 = ""
    this_cGrupo6  = ""

    *-- Vendedor 7 (linha "7 :")
    this_cConta7  = ""
    this_cDConta7 = ""
    this_cGrupo7  = ""

    *-- Vendedor 8 (linha "8 :")
    this_cConta8  = ""
    this_cDConta8 = ""
    this_cGrupo8  = ""

    *-- Vendedor 9 (linha "9 :")
    this_cConta9  = ""
    this_cDConta9 = ""
    this_cGrupo9  = ""

    *-- Vendedor 10 (linha "10 :")
    this_cConta10  = ""
    this_cDConta10 = ""
    this_cGrupo10  = ""

    *-- .T. apos ConfirmarSelecao() persistir a escolha em go_4c_Vendedor
    this_lConfirmado = .F.

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- Nao ha tabela propria de cadastro: os 11 slots de vendedor sao
        *-- resolvidos por lookup em SigCdCli (IClis = codigo da conta)
        THIS.this_cTabela = "SigCdCli"
        THIS.this_cCampoChave = "IClis"

        *-- Objeto global equivalente ao goVendedor do legado (sig.PRG),
        *-- usado pelas telas chamadoras para ler os 11 vendedores
        *-- confirmados apos este form fechar. Guarda idempotente para nao
        *-- recriar (e perder valores) se o dialogo for reaberto.
        *--
        *-- ATENCAO: a classe Empty NAO tem o METODO AddProperty - usar a
        *-- FUNCAO global ADDPROPERTY(oObj, "nome", valor). Medido no VFP9 em
        *-- 2026-09-25: go_4c_Vendedor.AddProperty(...) dispara erro 1734
        *-- "Property ADDPROPERTY is not found." e PEMSTATUS(Empty,
        *-- "AddProperty", 5) devolve .F. (Empty nao tem membro nenhum - eh
        *-- justamente o proposito da classe). AddProperty EXISTE como metodo
        *-- em Form/_SCREEN, e eh de la que vem a confusao. O erro estourava
        *-- AQUI, no Init do BO, dentro do TRY do Form -> CREATEOBJECT
        *-- devolvia .F. e o FormSigMvVde NUNCA ABRIA (menu nao fazia nada).
        IF TYPE("go_4c_Vendedor") != "O"
            PUBLIC go_4c_Vendedor
            go_4c_Vendedor = CREATEOBJECT("Empty")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor00", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor01", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor02", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor03", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor04", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor05", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor06", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor07", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor08", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor09", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor10", "")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula os 11 slots (Conta/DConta/Grupo) a partir de
    * um cursor de pre-selecao com colunas Conta0..Conta10, DConta0..DConta10
    * e Grupo0..Grupo10 (usado quando o form e reaberto sobre uma selecao
    * anterior). Colunas ausentes no cursor sao ignoradas, sem erro.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_nI, loc_cCampoConta, loc_cCampoDConta, loc_cCampoGrupo

        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        FOR loc_nI = 0 TO 10
            loc_cCampoConta  = par_cAliasCursor + ".Conta"  + TRANSFORM(loc_nI)
            loc_cCampoDConta = par_cAliasCursor + ".DConta" + TRANSFORM(loc_nI)
            loc_cCampoGrupo  = par_cAliasCursor + ".Grupo"  + TRANSFORM(loc_nI)

            IF TYPE(loc_cCampoConta) != "U"
                STORE ALLTRIM(TratarNulo(EVALUATE(loc_cCampoConta), "")) TO ("THIS.this_cConta" + TRANSFORM(loc_nI))
            ENDIF

            IF TYPE(loc_cCampoDConta) != "U"
                STORE ALLTRIM(TratarNulo(EVALUATE(loc_cCampoDConta), "")) TO ("THIS.this_cDConta" + TRANSFORM(loc_nI))
            ENDIF

            IF TYPE(loc_cCampoGrupo) != "U"
                STORE ALLTRIM(TratarNulo(EVALUATE(loc_cCampoGrupo), "")) TO ("THIS.this_cGrupo" + TRANSFORM(loc_nI))
            ENDIF
        ENDFOR

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaPorCodigo - Espelha o Valid legado de get_contaN (fwBuscaExt
    * com busca exata por IClis em SigCdCli). Usado pelos handlers KeyPress
    * (Enter/Tab/F4) dos 11 campos de conta do form. Cursor de saida:
    * cursor_4c_VdeBusca (IClis/RClis/Grupos), 1 linha quando encontrado.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaPorCodigo(par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado

        loc_lResultado = .F.

        IF EMPTY(ALLTRIM(NVL(par_cConta, "")))
            THIS.this_cMensagemErro = "Informe o c" + CHR(243) + "digo da conta"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados indispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_VdeBusca")
            USE IN cursor_4c_VdeBusca
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis, Grupos " + ;
                       "FROM SigCdCli " + ;
                       "WHERE IClis = " + EscaparSQL(ALLTRIM(par_cConta))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VdeBusca")

            IF loc_nResultado > 0 AND USED("cursor_4c_VdeBusca") AND RECCOUNT("cursor_4c_VdeBusca") > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o encontrada"
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar conta: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaPorDescricao - Espelha o Valid legado de get_dcontaN
    * (fwBuscaExt com busca exata por RClis em SigCdCli). Mesmo cursor de
    * saida de BuscarContaPorCodigo.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaPorDescricao(par_cDescricao)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado

        loc_lResultado = .F.

        IF EMPTY(ALLTRIM(NVL(par_cDescricao, "")))
            THIS.this_cMensagemErro = "Informe a descri" + CHR(231) + CHR(227) + "o da conta"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados indispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_VdeBusca")
            USE IN cursor_4c_VdeBusca
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 RClis, IClis, Grupos " + ;
                       "FROM SigCdCli " + ;
                       "WHERE RClis = " + EscaparSQL(ALLTRIM(par_cDescricao))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VdeBusca")

            IF loc_nResultado > 0 AND USED("cursor_4c_VdeBusca") AND RECCOUNT("cursor_4c_VdeBusca") > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o encontrada"
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar conta: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecao - Espelha "If Not Empty(get_conta0.Value)" do legado: o
    * botao Confirmar (btnSair) so age quando o vendedor "A" (slot 0) esta
    * preenchido. Vazio, o legado NAO exibe mensagem nenhuma - so nao faz
    * nada - por isso este metodo tambem devolve .F. em silencio.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSelecao()
        RETURN !EMPTY(ALLTRIM(NVL(THIS.this_cConta0, "")))
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarSelecao - Espelha o corpo do btnSair.Click do legado (menos a
    * autorizacao em si, que fica a cargo do Form/tela de autorizacao -
    * par_lAutorizado chega .T./.F. de la):
    *   - Conta0 vazio                        -> nao faz nada, devolve .F.
    *   - Conta0 preenchido e NAO autorizado   -> grava o sentinela de
    *     cancelamento (Chr(254) x10) em Vendedor00, como no legado, e
    *     devolve .F.
    *   - Conta0 preenchido e autorizado       -> copia Conta0..Conta10 para
    *     go_4c_Vendedor.Vendedor00..Vendedor10 e devolve .T.
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarSelecao(par_lAutorizado)
        LOCAL loc_nI

        IF !THIS.ValidarSelecao()
            RETURN .F.
        ENDIF

        IF TYPE("go_4c_Vendedor") != "O"
            THIS.this_cMensagemErro = "Objeto de vendedores n" + CHR(227) + "o inicializado"
            RETURN .F.
        ENDIF

        IF !par_lAutorizado
            go_4c_Vendedor.Vendedor00 = REPLICATE(CHR(254), 10)
            THIS.this_lConfirmado = .F.
            RETURN .F.
        ENDIF

        FOR loc_nI = 0 TO 10
            STORE EVALUATE("THIS.this_cConta" + TRANSFORM(loc_nI)) TO ("go_4c_Vendedor.Vendedor" + PADL(TRANSFORM(loc_nI), 2, "0"))
        ENDFOR

        THIS.this_lConfirmado = .T.
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao existe registro proprio (dialogo de selecao,
    * sem tabela): usa a conta do vendedor "A" (slot 0) como referencia caso
    * uma auditoria futura precise identificar a operacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cConta0
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - NAO sobrescritos de proposito.
    * O legado (SIGMVVDE.SCX) nao faz nenhum SQLEXEC/INSERT/UPDATE/DELETE
    * (comportamento.json: metodosComSQL = 0, totalQueries = 0) - o form eh
    * um dialogo de selecao que devolve os 11 vendedores escolhidos via
    * ConfirmarSelecao()/go_4c_Vendedor, nunca grava em SigCdCli. O
    * comportamento padrao herdado de BusinessBase (recusar Inserir/
    * Atualizar/Excluir) ja eh o correto para esta entidade.
    *--------------------------------------------------------------------------

ENDDEFINE


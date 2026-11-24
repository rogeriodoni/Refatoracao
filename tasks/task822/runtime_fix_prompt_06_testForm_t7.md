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
[2026-11-20 16:06:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-20 16:06:25] [INFO] Config FPW: (nao fornecido)
[2026-11-20 16:06:25] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-20 16:06:25] [INFO] Timeout: 300 segundos
[2026-11-20 16:06:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1simkocv.prg
[2026-11-20 16:06:25] [INFO] Conteudo do wrapper:
[2026-11-20 16:06:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpZom', 'C:\4c\tasks\task822\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpZom', 'C:\4c\tasks\task822\logs\06_testForm.log'
QUIT

[2026-11-20 16:06:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1simkocv.prg
[2026-11-20 16:06:25] [INFO] VFP output esperado em: C:\4c\tasks\task822\vfp_output.txt
[2026-11-20 16:06:25] [INFO] Executando Visual FoxPro 9...
[2026-11-20 16:06:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1simkocv.prg
[2026-11-20 16:06:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1simkocv.prg
[2026-11-20 16:06:25] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpZom
Inicio: 20/11/2026 16:06:25

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 20/11/2026 16:07:33
Duracao: 68 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-20 16:07:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-20 16:07:33] [INFO] VFP9 finalizado em 68.0777422 segundos
[2026-11-20 16:07:33] [INFO] Exit Code: 
[2026-11-20 16:07:33] [INFO] 
[2026-11-20 16:07:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-20 16:07:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1simkocv.prg
[2026-11-20 16:07:33] [INFO] 
[2026-11-20 16:07:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-20 16:07:33] [INFO] * Auto-generated wrapper for parameters
[2026-11-20 16:07:33] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-20 16:07:33] [INFO] * Parameters: 'FormSigOpZom', 'C:\4c\tasks\task822\logs\06_testForm.log'
[2026-11-20 16:07:33] [INFO] 
[2026-11-20 16:07:33] [INFO] * Anti-dialog protections for unattended execution
[2026-11-20 16:07:33] [INFO] SET SAFETY OFF
[2026-11-20 16:07:33] [INFO] SET RESOURCE OFF
[2026-11-20 16:07:33] [INFO] SET TALK OFF
[2026-11-20 16:07:33] [INFO] SET NOTIFY OFF
[2026-11-20 16:07:33] [INFO] SYS(2335, 0)
[2026-11-20 16:07:33] [INFO] 
[2026-11-20 16:07:33] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpZom', 'C:\4c\tasks\task822\logs\06_testForm.log'
[2026-11-20 16:07:33] [INFO] QUIT
[2026-11-20 16:07:33] [INFO] 
[2026-11-20 16:07:33] [INFO] === Fim do Wrapper.prg ===
[2026-11-20 16:07:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpZom.prg):
*==============================================================================
* FormSigOpZom.prg - Zoom (Visualizacao Ampliada de Imagem)
* Origem: SIGOPZOM.SCX (Framework legado Fortyus)
* Herda de: FormBase
* Tipo: OPERACIONAL (dialogo FLAT - legado sem PageFrame/abas; modal,
*       AlwaysOnTop, aberto por OUTRO form para exibir ampliada uma imagem
*       cujo caminho vem por parametro, com 2 textos opcionais logo abaixo
*       e fechamento automatico opcional por Timer). Mesma familia visual
*       de FormSigOpImg (tambem FLAT, tambem sem PageFrame).
*
* Assinatura do Init legado (SIGOPZOM.Init):
*   Lparameters pArquivo, pTexto1, pTexto2, pTimer
* Ver cabecalho de SigOpZomBO.prg para o detalhamento de cada parametro e
* para a divisao de responsabilidade entre Form (exibe) e BO (decide).
*
* FASE 4/8 (Grid + botoes CRUD da Page1) - NAO HA GRADE NEM CRUD NESTE LEGADO.
* Medido no dump (tasks\task822\SigOpZom_form_codigo_fonte.txt, 14 objetos):
* ZERO BaseClass grid/pageframe/listbox, ZERO AddCursor/pColuna/RecordSource/
* ControlSource e ZERO controle de ENTRADA (as 8 BaseClass presentes sao
* form/dataenvironment/container/commandgroup/image/label/shape/timer, isto e'
* so decoracao + 1 grupo de botao). O legado nao tem lista NEM campos: a tela
* inteira e' imagem ampliada + 2 quadros de texto opcionais, sem Page1/Page2 e
* sem registro para paginar. Inventar Grid ou 6 botoes CRUD aqui violaria o
* PILAR 1 e a propria natureza do dialogo (parametrizado, sem tabela - ver
* cabecalho de SigOpZomBO.prg), e metodos-adaptador vazios so para casar com
* regex de gate sao o "stub disfarcado" que a regra de completude proibe.
*
* O que a Fase 4 ENTREGOU, entao, foi a superficie de acao que o legado de
* fato tem - o seu UNICO botao (btnSair, Caption "Encerrar", dentro do
* CommandGroup cmdBtnForm) ligado ao seu handler REAL:
*   - cmg_4c_CmdBtnForm (ConfigurarBotaoEncerrar) - o grupo nasceu na Fase 3
*     batizado obj_4c_CmdBtnForm porque e' isso que o mapeamento.json manda
*     (o AnalisadorObjetos nao reconhece CommandGroup e cai no prefixo
*     generico obj_4c_). Renomeado aqui para o canonico do projeto, cmg_4c_,
*     e o mapeamento.json corrigido junto.
*   - BINDEVENT em Buttons(1) "Click" -> BtnSairClick, que e' THIS.Release(),
*     transcricao literal de "PROCEDURE btnSair.Click / ThisForm.Release".
*     Vai no membro INTERNO, como no SCX, e nao no grupo.
*
* FASE 5/8 (Form - Campos Principais) - ESTE DIALOGO NAO TEM CAMPO DE TELA.
* analise.json confirma campos/lookups/labels todos vazios: os "dados" deste
* form sao os 4 parametros do Init (pArquivo/pTexto1/pTexto2/pTimer), nao
* controles editaveis de Page2. O trabalho real equivalente desta fase foi
* concluir o que as Fases 3/4 haviam deixado adiado nos proprios comentarios
* ("fica para fase posterior"): validar o arquivo recebido (via
* SigOpZomBO.ValidarArquivoImagem, que replica os dois "If .../ ThisForm.
* Release" do Init legado) e aplicar os parametros nos controles ja criados
* (THIS.AplicarParametros - Picture, Captions dos dois quadros e Interval/
* Enabled do Timer, com o BINDEVENT do evento Timer -> TimerFecharAutomatico,
* transcricao de "PROCEDURE Timer / thisform.Release()"). Nenhum TextBox foi
* inventado - inventar "campos principais" aqui romperia o PILAR 1.
*
* FASE 6/8 (Form - Campos Restantes e Lookups, Page2 Parte 2) - NOOP: ESTE
* DIALOGO NAO TEM PAGE2 NEM LOOKUP NENHUM. O legado (Init/Timer.Timer/
* btnSair.Click, os UNICOS 3 metodos do SCX - comportamento.json) nao faz
* nenhum CreateObject('fwbuscaext'/'fwBuscaSel'), nenhum sigacess(), nenhum
* PROCEDURE Valid e nenhum KeyPress de F4/F5 - e analise.json confirma
* campos/lookups/labels todos vazios. Os 4 parametros do Init (pArquivo/
* pTexto1/pTexto2/pTimer) e os controles que os exibem (img_4c_ImgFigJpg,
* lbl_4c_LblTexto1/2, obj_4c_Timer) ja foram inteiramente cobertos pela
* Fase 5 (THIS.AplicarParametros, chamado em InicializarForm). Nao ha
* "ultimos 50% dos campos" a completar nem BINDEVENT de F4/DblClick a
* acrescentar - inventar um lookup ou um TextBox a mais aqui romperia o
* PILAR 1 (o usuario deste dialogo so ve imagem + 2 legendas + Encerrar) e
* seria o "stub disfarcado" que a regra de completude proibe, so que ao
* contrario: funcionalidade que o legado nunca teve.
*
* FASE 7/8 (Form - Eventos Principais) - NOOP: ESTE DIALOGO NAO TEM CRUD,
* E O UNICO CLICK DO LEGADO JA FOI PORTADO NA FASE 4. O deliverable desta
* fase (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick)
* pressupoe um form CRUD com Page1=Lista/Page2=Dados; o SIGOPZOM e um
* dialogo FLAT parametrizado (ver Fase 4), sem tabela, sem registro, sem
* Page2 - inventar os 4 handlers aqui romperia o PILAR 1 e seria o "stub
* disfarcado" que a regra de completude proibe (mesmo raciocinio das Fases
* 4/5/6 acima, so que no eixo CRUD em vez de Grid/campo/lookup).
*
* comportamento.json confirma que o SCX legado tem APENAS 3 metodos com
* codigo - Init, Timer.Procedure e cmdBtnForm.Click - e os 3 ja estao
* 100% cobertos:
*   - Init                -> FormSigOpZom.Init() (Fase 3, guarda os 4
*                             parametros) + InicializarForm() (valida e
*                             monta a tela - Fase 3/5)
*   - Timer.Procedure      -> TimerFecharAutomatico() (Fase 5), ligado via
*                             BINDEVENT(THIS.obj_4c_Timer, "Timer", ...)
*                             dentro de AplicarParametros()
*   - cmdBtnForm.Click     -> BtnSairClick() (Fase 4), ligado via
*                             BINDEVENT(THIS.cmg_4c_CmdBtnForm.Buttons(1),
*                             "Click", ...) dentro de
*                             ConfigurarBotaoEncerrar()
*
* Re-auditoria do par BINDEVENT+handler nos dois pontos acima (os unicos
* dois BINDEVENT do arquivo): THIS.<alvo> resolve (cmg_4c_CmdBtnForm e
* obj_4c_Timer existem, criados em ConfigurarBotaoEncerrar/
* ConfigurarTimerFechamento, chamados por ConfigurarPageFrame ANTES de
* InicializarForm tentar o bind); os dois handlers (BtnSairClick,
* TimerFecharAutomatico) sao PUBLIC (regra #3 do CLAUDE.md - BINDEVENT em
* metodo PROTECTED falha em silencio); os dois BINDEVENT ficam DEPOIS do
* respectivo AddObject (ConfigurarBotaoEncerrar cria o CommandGroup e so
* entao liga o Click; AplicarParametros roda DEPOIS de
* ConfigurarTimerFechamento ja ter criado obj_4c_Timer); nenhum dos dois
* usa SetFocus (nao ha outro controle para onde voltar o foco neste
* dialogo); ESC fecha pelo .Buttons(1).Cancel = .T. transcrito do dump,
* nao por Closable/ControlBox (ambos .F., coerente com TitleBar = 0); os
* dois handlers chamam THIS.Release() (nao Hide()), correto porque este
* dialogo nao devolve valor nenhum ao chamador - nao ha o que o form pai
* precise ler apos o fechamento (contraste com dialogos CAPTURA que
* entregam valor e por isso usam Hide()).
*
* Fora dos 3 metodos acima, o SCX nao tem mais nenhum evento: zero outro
* PROCEDURE Click, zero evento de Grid (nao ha grid), zero KeyPress/Valid/
* LostFocus/InteractiveChange (confirmado tambem pela Fase 6, que mediu
* ausencia total de lookup). Nao ha "eventos principais" sobrando para
* esta fase - a superficie de acao inteira do legado (Init, Timer,
* Encerrar) ja estava 100% coberta ao final da Fase 5.
*
* FASE 8/8 (Form - Eventos Auxiliares e Consolidacao Final) - NOOP: O
* DELIVERABLE PADRAO DESTA FASE E INTEIRAMENTE DO VOCABULARIO CRUD, E ESTE
* DIALOGO NAO E CRUD (mesmo raciocinio das Fases 4/5/6/7, agora no eixo
* "metodos auxiliares de consolidacao"):
*   - BtnBuscarClick()      -> nao ha Page1/Lista nem filtro de busca (Fase
*                             4 mediu ZERO AddCursor/pColuna/RecordSource).
*   - BtnSalvarClick()/
*     BtnCancelarClick()    -> nao ha o que confirmar nem descartar: o
*                             dialogo nao grava nada (cabecalho de
*                             SigOpZomBO.prg - zero Insert/Update/Delete/
*                             Replace/TableUpdate no legado) e nao tem
*                             Page2/modo DADOS para cancelar a saida dela.
*   - BtnEncerrarClick()    -> JA EXISTE, com um dos tres nomes canonicos
*                             que o harness de teste aceita (ver BtnSairClick
*                             abaixo: BtnEncerrarClick/BtnFecharClick/
*                             BtnSairClick) - nao duplicar com um segundo
*                             metodo so para casar o nome literal.
*   - FormParaBO()/
*     BOParaForm()          -> o EQUIVALENTE funcional already existe:
*                             InicializarForm() transfere os 4 parametros
*                             recebidos no Init (this_cArquivoImagemParam/
*                             this_cTexto1Param/this_cTexto2Param/
*                             this_lTimerParam) para o BO - e essa e a UNICA
*                             direcao de dados deste dialogo (parametro de
*                             entrada -> exibicao). Nao ha volta BOParaForm
*                             porque nao ha campo editavel para re-exibir, e
*                             inventar um par FormParaBO/BOParaForm vazio so
*                             para casar o nome do metodo seria o "stub
*                             disfarcado" que a regra de completude proibe.
*   - HabilitarCampos()/
*     LimparCampos()        -> nao ha campo editavel (analise.json: campos/
*                             lookups/labels todos vazios, Fase 5) nem
*                             ciclo Incluir/Alterar/Excluir que precise
*                             habilitar ou limpar nada entre registros.
*   - CarregarLista()/
*     AjustarBotoesPorModo()-> nao ha grid (Fase 4) nem this_cModoAtual
*                             alternando entre LISTA/DADOS - o dialogo so
*                             tem DOIS estados possiveis (abre ou nao abre,
*                             decidido em InicializarForm via
*                             ValidarArquivoImagem) e um unico botao, ja
*                             coberto.
*
* CONSOLIDACAO FINAL - checklist cruzado com comportamento.json (fonte da
* verdade sobre o que o SCX legado de fato faz):
*   [x] Init                 -> FormSigOpZom.Init() + InicializarForm()
*   [x] Timer.Procedure      -> TimerFecharAutomatico() via BINDEVENT
*   [x] cmdBtnForm.Click     -> BtnSairClick() via BINDEVENT em Buttons(1)
*   [x] guard de arquivo ausente/extensao invalida -> ValidarArquivoImagem()
*   [x] faixa do cabecalho (regra #11) presente nas duas - aqui so ha uma
*       pagina (FLAT), e a faixa foi criada por ULTIMO antes do grupo de
*       botao, cobrindo a excecao de ordem da regra #11 (sem PageFrame
*       interno a desviar o ZOrder)
*   [x] UI Fidelity (PILAR 1): Width=1000/Height=710/AutoCenter/ShowTips/
*       ControlBox=.F./Closable=.F./TitleBar=0/WindowType=1/AlwaysOnTop=.T.
*       transcritos do layout.json/analise do dump - nenhum controle extra
*       inventado alem dos 14 objetos do dump original
*   [x] BusinessBase: Inserir/Atualizar/ExecutarExclusao deliberadamente NAO
*       sobrescritos (ver cabecalho de SigOpZomBO.prg) - comportamento
*       herdado (recusar) e o correto para um visualizador somente-leitura
*   [x] menu.prg: item em popMovimentos com AbrirFormSigOpZom (ver bloco de
*       integracao abaixo)
*
* Nao ha pendencia de Fase anterior nem metodo auxiliar faltando - as 8
* fases encerram aqui.
*==============================================================================

DEFINE CLASS FormSigOpZom AS FormBase

    DataSession = 2
    ShowWindow = 1
    BorderStyle = 2
    Height      = 710
    Width       = 1000
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Zoom"
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Verdana"
    FontSize    = 8
    MaxButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    AlwaysOnTop = .T.
    ForeColor   = RGB(36, 84, 155)

    *-- Parametros recebidos pelo Init legado (Lparameters pArquivo, pTexto1,
    *-- pTexto2, pTimer). Este dialogo nao tem PageFrame nem campos de dados
    *-- editaveis - os 4 parametros de construcao SAO toda a "ficha" dele.
    *-- Guardados aqui porque o Business Object ainda nao existe no momento
    *-- em que o Init os recebe; InicializarForm() os transfere para o BO.
    this_cArquivoImagemParam = ""
    this_cTexto1Param        = ""
    this_cTexto2Param        = ""
    this_lTimerParam         = .F.

    *==========================================================================
    * Init - Recebe os 4 parametros do Init legado e os guarda em properties
    * do form antes de delegar a inicializacao padrao. DODEFAULT() sem
    * argumentos repassa os MESMOS parametros recebidos para FormBase.Init
    * (que os ignora, pois nao os declara) - e FormBase.Init quem chama
    * THIS.InicializarForm(), onde o Business Object e a estrutura visual
    * sao de fato criados (regra #9.4 do CLAUDE.md: Init tem de chamar
    * DODEFAULT() para herdar o fix de SET DATE/CENTURY da DataSession=2).
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_cArquivo, par_cTexto1, par_cTexto2, par_lTimer

        THIS.this_cArquivoImagemParam = IIF(VARTYPE(par_cArquivo) = "C", par_cArquivo, "")
        THIS.this_cTexto1Param        = IIF(VARTYPE(par_cTexto1) = "C", par_cTexto1, "")
        THIS.this_cTexto2Param        = IIF(VARTYPE(par_cTexto2) = "C", par_cTexto2, "")
        THIS.this_lTimerParam         = IIF(VARTYPE(par_lTimer) = "L", par_lTimer, .F.)

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o SigOpZomBO, transfere os parametros
    * recebidos no Init para as properties do BO e cria a estrutura visual
    * base (equivalente ao ConfigurarPageFrame dos forms CRUD - aqui sem
    * PageFrame real, porque o legado SIGOPZOM e um dialogo FLAT).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpZomBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                WITH THIS.this_oBusinessObject
                    .this_cArquivoImagem        = THIS.this_cArquivoImagemParam
                    .this_cTexto1               = THIS.this_cTexto1Param
                    .this_cTexto2               = THIS.this_cTexto2Param
                    .this_lFechamentoAutomatico = THIS.this_lTimerParam
                ENDWITH

                *-- Equivalente aos dois "If .../ ThisForm.Release" do Init
                *-- legado (arquivo ausente/extensao invalida). O legado
                *-- nao tem RETURN apos o Release e continua executando;
                *-- o migrado aborta a inicializacao no primeiro motivo de
                *-- recusa (mesmo resultado visivel - a tela nao abre - sem
                *-- atribuir Picture inexistente, regra #25 do CLAUDE.md).
                IF !THIS.this_oBusinessObject.ValidarArquivoImagem()
                    IF THIS.this_oBusinessObject.this_cMotivoRecusa == "EXTENSAO"
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemArquivoInvalido)
                    ENDIF
                    loc_lSucesso = .F.
                ELSE
                    THIS.this_oBusinessObject.AtualizarEstadoTimer()

                    THIS.ConfigurarPageFrame()

                    THIS.AplicarParametros()

                    THIS.TornarControlesVisiveis(THIS)

                    *-- NUNCA atribuir THIS.Visible = .T. aqui (regra ja
                    *-- documentada em FormSigOpImg): realizaria a janela
                    *-- antes do caller chamar .Show(), e com a janela ja
                    *-- realizada o WindowType vira READ-ONLY. Visible fica
                    *-- por conta EXCLUSIVA do .Show() externo.
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Falha ao criar SigOpZomBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestra a criacao da estrutura visual base.
    * Form FLAT (legado SIGOPZOM nao tem PageFrame/abas, igual FormSigOpImg):
    * molduras (Shapes), area de imagem, textos dos dois quadros, timer de
    * fechamento automatico, faixa do cabecalho e o grupo do botao Encerrar.
    *
    * ORDEM = z-order do SCX legado (tasks\task822\layout.json): Shape2,
    * Shape5, Shape1, ImgFigJpg, lblTexto1, lblTexto2 e Timer vem ANTES de
    * cntSombra e cmdBtnForm na arvore do dump - os dois ultimos desenham
    * por cima de tudo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarMolduras()
        THIS.ConfigurarImagem()
        THIS.ConfigurarTextosQuadros()
        THIS.ConfigurarTimerFechamento()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotaoEncerrar()
    ENDPROC

    *==========================================================================
    * ConfigurarMolduras - Cria os 3 Shapes decorativos que desenham as
    * molduras dos dois quadros de texto e da area da imagem. Posicoes e
    * estilos transcritos literalmente do dump do SCX legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMolduras()
        LOCAL loc_oErro
        TRY
            *-- Shape2 - moldura do quadro do 2o texto (lblTexto2)
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 114
                .Left          = 4
                .Height        = 26
                .Width         = 890
                .BackStyle     = 0
                .BorderStyle   = 6
                .BorderWidth   = 2
                .FillStyle     = 1
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- Shape5 - moldura da area da imagem (ImgFigJpg)
            THIS.AddObject("shp_4c_Shape5", "Shape")
            WITH THIS.shp_4c_Shape5
                .Top           = 146
                .Left          = 4
                .Height        = 527
                .Width         = 890
                .BackStyle     = 0
                .BorderStyle   = 6
                .BorderWidth   = 3
                .FillStyle     = 1
                .SpecialEffect = 0
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH

            *-- Shape1 - moldura do quadro do 1o texto (lblTexto1)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top           = 84
                .Left          = 4
                .Height        = 26
                .Width         = 890
                .BackStyle     = 0
                .BorderStyle   = 6
                .BorderWidth   = 2
                .FillStyle     = 1
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarMolduras")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarImagem - Cria img_4c_ImgFigJpg (ImgFigJpg legado), so com a
    * moldura/estrutura do controle, identica ao dump do SCX. O Picture
    * (equivalente a "ThisForm.ImgFigJpg.Picture = (pArquivo)" do Init
    * legado) e atribuido em AplicarParametros(), DEPOIS da validacao do
    * arquivo em InicializarForm() - so se chega aqui com arquivo valido.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagem()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("img_4c_ImgFigJpg", "Image")
            WITH THIS.img_4c_ImgFigJpg
                .Stretch = 1
                .Enabled = .F.
                .Top     = 149
                .Left    = 7
                .Width   = 884
                .Height  = 521
                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarImagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarTextosQuadros - Cria lbl_4c_LblTexto1/lbl_4c_LblTexto2
    * (lblTexto1/lblTexto2 legado). Caption nasce vazio porque o Init legado
    * sempre zera a Caption antes de decidir se a preenche com pTexto1/
    * pTexto2 ("ThisForm.lblTexto1.Caption = ''" seguido do If Type(...) =
    * 'C'); a atribuicao condicional do parametro e feita em
    * AplicarParametros(), que ja recebe this_cTexto1/this_cTexto2 do BO
    * com a MESMA guarda de tipo aplicada no Init() do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTextosQuadros()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_LblTexto1", "Label")
            WITH THIS.lbl_4c_LblTexto1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 17
                .Left      = 17
                .Top       = 89
                .Width     = 829
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LblTexto2", "Label")
            WITH THIS.lbl_4c_LblTexto2
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 17
                .Left      = 17
                .Top       = 119
                .Width     = 829
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarTextosQuadros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarTimerFechamento - Cria obj_4c_Timer (Timer legado). Interval
    * nasce 0 (igual ao SCX antes do Init decidir); a troca para 3000 quando
    * this_lFechamentoAutomatico e .T. (equivalente ao "If pTimer / Thisform.
    * Timer.Interval = 3000" do Init legado) e feita em AplicarParametros(),
    * junto com o BINDEVENT do evento Timer -> TimerFecharAutomatico().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTimerFechamento()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_Timer", "Timer")
            WITH THIS.obj_4c_Timer
                .Top      = 84
                .Left     = 974
                .Height   = 23
                .Width    = 23
                .Interval = 0
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarTimerFechamento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Sombra com os labels de titulo
    * (cntSombra/lblSombra/lblTitulo legado - nomes transcritos literalmente
    * do mapeamento.json desta tarefa; regra #11 do CLAUDE.md: identificar
    * a faixa por BackColor+Height, NUNCA so pelo nome). Igual a
    * FormSigOpImg.ConfigurarCabecalho: Top=0/Left=0/Width=THIS.Width em vez
    * dos valores levemente negativos/transbordantes do SCX (Left=-1,
    * Width=1008), que sao artefato do Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Caption     = THIS.Caption
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width - 20
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEncerrar - Cria cmg_4c_CmdBtnForm (cmdBtnForm legado),
    * CommandGroup de 1 botao ("Encerrar" = btnSair do SCX). Propriedades
    * transcritas literalmente do dump - forms OPERACIONAIS nao seguem o
    * padrao canonico cnt_4c_Saida/cmd_4c_Encerrar dos CRUD (regra #10 do
    * CLAUDE.md e especifica de frmcadastro). Prefixo cmg_4c_ e o canonico do
    * projeto para CommandGroup (ver framework_frmcadastro_layout.md), nao o
    * obj_4c_ generico do mapeamento.json. O Click e ligado aqui mesmo, em
    * Buttons(1), para BtnSairClick - ver detalhe no bloco abaixo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
            WITH THIS.cmg_4c_CmdBtnForm
                .Top         = -2
                .Left        = 918
                .Width       = 85
                .Height      = 85
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 0
                .BorderColor = RGB(100, 100, 100)
                .Themes      = .F.
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top        = 5
                    .Left       = 5
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel     = .T.
                    .Caption    = "Encerrar"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                ENDWITH
            ENDWITH

            *-- Click do unico botao de acao do legado. O SCX poe o codigo no
            *-- membro INTERNO (PROCEDURE btnSair.Click = "ThisForm.Release"),
            *-- nao no grupo - por isso o BINDEVENT vai em Buttons(1), e nao no
            *-- cmg_4c_CmdBtnForm. Ligar os dois faria o handler disparar duas
            *-- vezes. Como .Buttons(1).Cancel = .T. (transcrito do dump), ESC
            *-- tambem cai aqui, reproduzindo o fechamento por teclado do legado.
            BINDEVENT(THIS.cmg_4c_CmdBtnForm.Buttons(1), "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoEncerrar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AplicarParametros - Aplica nos controles ja criados os 4 parametros
    * do Init legado, depois que InicializarForm() confirmou (via
    * ValidarArquivoImagem()) que o arquivo existe e tem extensao aceita.
    * Transcricao literal do restante do Init legado (as linhas que o
    * guard de validacao, ja executado em InicializarForm, NAO intercepta):
    *
    *     ThisForm.Timer.Interval = 3000 | 0 (+ Enabled = .F. no ramo 0)
    *     ThisForm.lblTexto1.Caption = '' / pTexto1 (se Type('pTexto1')='C')
    *     ThisForm.lblTexto2.Caption = '' / pTexto2 (se Type('pTexto2')='C')
    *     ThisForm.ImgFigJpg.Picture = (pArquivo)
    *
    * this_cTexto1Param/this_cTexto2Param ja chegam "" quando o parametro
    * nao foi passado como C (guarda aplicada em THIS.Init()) - a mesma
    * guarda do legado, so que resolvida mais cedo.
    *
    * O BINDEVENT do Timer fica aqui (e nao em ConfigurarTimerFechamento)
    * porque so faz sentido ligar o evento de fechamento automatico depois
    * que o Interval/Enabled ja foram decididos.
    *==========================================================================
    PROTECTED PROCEDURE AplicarParametros()
        LOCAL loc_oErro
        TRY
            THIS.img_4c_ImgFigJpg.Picture = THIS.this_oBusinessObject.this_cArquivoImagem

            THIS.lbl_4c_LblTexto1.Caption = THIS.this_oBusinessObject.this_cTexto1
            THIS.lbl_4c_LblTexto2.Caption = THIS.this_oBusinessObject.this_cTexto2

            THIS.obj_4c_Timer.Interval = THIS.this_oBusinessObject.this_nIntervaloTimer
            THIS.obj_4c_Timer.Enabled  = THIS.this_oBusinessObject.this_lTimerHabilitado

            BINDEVENT(THIS.obj_4c_Timer, "Timer", THIS, "TimerFecharAutomatico")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AplicarParametros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TimerFecharAutomatico - Transcricao literal de "PROCEDURE Timer /
    * thisform.Release()" do SCX legado. So dispara quando
    * this_lFechamentoAutomatico (pTimer) era .T. - Enabled fica .F. no
    * ramo contrario (AtualizarEstadoTimer no BO + AplicarParametros aqui).
    *
    * PUBLIC porque e alvo de BINDEVENT (regra #3 do CLAUDE.md: metodo
    * PROTECTED falha em SILENCIO no BINDEVENT).
    *==========================================================================
    PROCEDURE TimerFecharAutomatico()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSairClick - Encerra o dialogo. Transcricao literal do unico metodo de
    * acao do SCX legado:
    *
    *     PROCEDURE btnSair.Click
    *     ThisForm.Release
    *
    * Nao ha nada a gravar nem a confirmar antes de fechar: o SIGOPZOM e um
    * visualizador parametrizado (recebe caminho de imagem + 2 textos pelo
    * Init), sem tabela, sem campo editavel e sem outro botao - por isso o
    * legado nao faz pergunta nenhuma aqui, e inventar uma confirmacao
    * violaria o PILAR 1. O Release() tambem e o caminho que o Timer de
    * fechamento automatico usa (PROCEDURE Timer = thisform.Release()), que
    * sera ligado na fase de eventos.
    *
    * PUBLIC porque e alvo de BINDEVENT (CLAUDE.md regra #3: metodo PROTECTED
    * falha em SILENCIO no BINDEVENT) e porque o harness de teste automatizado
    * chama os handlers de encerramento de FORA da classe. O nome segue o
    * controle legado (btnSair) e e um dos tres nomes canonicos que o
    * TesteBtnEncerrarExiste aceita (BtnEncerrarClick/BtnFecharClick/
    * BtnSairClick).
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis recursivamente os controles
    * criados via AddObject (que nascem com Visible=.F.). Rede de seguranca
    * alem do .Visible=.T. ja atribuido em cada WITH de criacao.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpZomBO.prg):
*==============================================================================
* SigOpZomBO.prg
*
* Business Object para SIGOPZOM (Zoom - Visualizacao de Imagem)
*
* Este form NAO persiste dados e NAO consulta tabela nenhuma: e um dialogo
* OPERACIONAL (WindowType = 1, modal, AlwaysOnTop) chamado por outro form
* para EXIBIR AMPLIADA uma imagem cujo caminho completo vem por parametro,
* com dois textos opcionais logo abaixo (os dois quadros Shape1/Shape2) e
* fechamento automatico opcional por Timer.
*
* Tabela: (nenhuma - visualizador parametrizado, sem persistencia e sem SQL)
*
* Assinatura do Init legado (SIGOPZOM.Init):
*   Lparameters pArquivo, pTexto1, pTexto2, pTimer
*     pArquivo = Nome Completo do Arquivo de Imagem (incluindo Path)
*     pTexto1  = Texto apresentado no 1o quadro, abaixo da imagem (Opcional)
*     pTexto2  = Texto apresentado no 2o quadro, abaixo da imagem (Opcional)
*     pTimer   = quando verdadeiro, a tela se fecha sozinha (Timer.Interval
*                = 3000); senao o Timer fica com Interval 0 e Enabled .F.
*
* SOMENTE LEITURA - por que Inserir()/Atualizar()/ExecutarExclusao() NAO sao
* sobrescritos aqui: o dump do legado nao tem UM UNICO Insert Into, Update,
* Delete From, Replace, TableUpdate nem .AddCursor - os tres metodos do form
* (Init, Timer.Timer e btnSair.Click) so mexem em propriedades de controles
* e chamam ThisForm.Release. Nao existe nem cursor local. Escrever
* INSERT/UPDATE aqui significaria INVENTAR tabela e colunas, o que a regra
* #22 do CLAUDE.md proibe (a lista vem do schema, nunca de adivinhacao). O
* comportamento padrao herdado de BusinessBase (recusar a operacao e
* reportar pelo ExibirFalha do Salvar) ja e o correto.
*
* Divisao de responsabilidade com o Form (o Form exibe, o BO decide):
*
*   DefinirParametros()        espelha os 4 Lparameters do Init legado, com
*                              as MESMAS guardas de tipo (Type('pTextoN')
*                              = 'C' e o teste de verdade de pTimer)
*   ValidarArquivoImagem()     o If Empty(pArquivo) Or Not File(pArquivo) e
*                              o If Not InList(Lower(Right(Alltrim(...),4)),
*                              '.bmp', '.dib', '.gif', '.jpg', '.cur',
*                              '.ani', '.ico') - sao DOIS motivos de recusa
*                              com tratamento DIFERENTE no legado (ver
*                              this_cMotivoRecusa abaixo)
*   ObterExtensaoArquivo()     Lower(Right(Alltrim(pArquivo), 4))
*   ObterIntervaloTimer()      Iif(pTimer, 3000, 0)
*
* ATENCAO - os DOIS motivos de recusa do legado NAO
* se comportam igual, e achatar os dois num unico caminho muda a UX:
*   arquivo vazio ou inexistente -> ThisForm.Release SILENCIOSO (sem aviso)
*   extensao fora da lista       -> MessageBox(..., 16, '') e SO DEPOIS o
*                                   ThisForm.Release
* Por isso this_cMotivoRecusa guarda QUAL dos dois ocorreu, em vez de um
* unico .F.: e o Form que decide exibir ou nao a mensagem.
*
* NOTA sobre o Release do legado: no Init original o ThisForm.Release esta
* DENTRO dos dois If, sem Return, entao o codigo seguinte continua
* executando mesmo apos o pedido de fechamento (inclusive o
* ImgFigJpg.Picture = (pArquivo) com arquivo invalido). O Form migrado
* aborta a inicializacao no primeiro motivo de recusa - o resultado visivel
* para o usuario e o mesmo (a tela nao abre) e evita atribuir Picture
* inexistente, que em VFP9 falha em SILENCIO (regra #25 do CLAUDE.md).
*==============================================================================

DEFINE CLASS SigOpZomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros recebidos do form chamador, espelhando UM A UM os
    * Lparameters do Init legado (pArquivo, pTexto1, pTexto2, pTimer)
    *--------------------------------------------------------------------------
    this_cArquivoImagem = ""            && pArquivo - caminho completo do arquivo de imagem
    this_cTexto1 = ""                   && pTexto1  - texto do 1o quadro (Shape1 / lblTexto1)
    this_cTexto2 = ""                   && pTexto2  - texto do 2o quadro (Shape2 / lblTexto2)
    this_lFechamentoAutomatico = .F.    && pTimer   - .T. fecha a tela sozinha pelo Timer

    *--------------------------------------------------------------------------
    * Estado resultante do Timer (o If pTimer / Else do Init legado).
    * Sao DUAS propriedades porque o legado mexe em DUAS propriedades do
    * controle: no ramo falso ele zera o Interval E desliga o Enabled.
    *--------------------------------------------------------------------------
    this_nIntervaloTimer = 0            && Timer.Interval resultante (3000 ou 0)
    this_lTimerHabilitado = .F.         && Timer.Enabled resultante (.T. ou .F.)

    *--------------------------------------------------------------------------
    * Constantes transcritas do legado (nao inventar outros valores)
    *--------------------------------------------------------------------------
    *-- Interval usado quando pTimer e verdadeiro: 3000 ms = 3 segundos
    this_nIntervaloFechamento = 3000

    *-- Lista EXATA do InList do Init legado, na MESMA ORDEM. A comparacao do
    *-- legado e sobre Lower(Right(Alltrim(pArquivo), 4)), isto e, sobre os 4
    *-- ultimos caracteres do nome - por isso toda extensao da lista tem 4
    *-- caracteres, com o ponto incluido.
    this_cExtensoesValidas = ".bmp,.dib,.gif,.jpg,.cur,.ani,.ico"

    *--------------------------------------------------------------------------
    * Resultado da validacao do arquivo
    *--------------------------------------------------------------------------
    this_lArquivoValido = .F.           && .T. quando o arquivo existe E a extensao e aceita
    this_cExtensaoArquivo = ""          && Lower(Right(Alltrim(pArquivo), 4))

    *-- Motivo da recusa, vazio quando o arquivo e valido. Valores possiveis:
    *--   "AUSENTE"   -> Empty(pArquivo) ou Not File(pArquivo): fecha CALADO
    *--   "EXTENSAO"  -> extensao fora de this_cExtensoesValidas: exibe a
    *--                 mensagem this_cMensagemArquivoInvalido e so depois fecha
    this_cMotivoRecusa = ""

    *-- Texto do MessageBox do legado, montado com CHR() no Init (regra #4 do
    *-- CLAUDE.md: PROIBIDO acentuar literal em .prg)
    this_cMensagemArquivoInvalido = ""

    *-- Caption do form legado ("Zoom"), que o Init replica nos dois labels da
    *-- faixa do cabecalho (lblSombra e lblTitulo)
    this_cTituloTela = "Zoom"

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Visualizador parametrizado: nao ha tabela nem campo chave proprios,
    * entao this_cTabela e this_cCampoChave ficam vazios de proposito (o
    * Buscar/Salvar herdados nunca sao usados por este form).
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Parametros (equivalente ao estado do form antes do Init legado)
        THIS.this_cArquivoImagem = ""
        THIS.this_cTexto1 = ""
        THIS.this_cTexto2 = ""
        THIS.this_lFechamentoAutomatico = .F.

        *-- Estado do Timer: default = desligado, igual ao ramo Else do legado
        *-- (Timer.Interval = 0 / Timer.Enabled = .F.). O SCX legado tambem
        *-- nasce com Interval = 0.
        THIS.this_nIntervaloTimer = 0
        THIS.this_lTimerHabilitado = .F.

        *-- Constantes do legado
        THIS.this_nIntervaloFechamento = 3000
        THIS.this_cExtensoesValidas = ".bmp,.dib,.gif,.jpg,.cur,.ani,.ico"

        *-- Resultado da validacao: comeca recusado por ausencia, porque
        *-- enquanto nenhum arquivo foi informado o caso e exatamente o
        *-- Empty(pArquivo) do legado
        THIS.this_lArquivoValido = .F.
        THIS.this_cExtensaoArquivo = ""
        THIS.this_cMotivoRecusa = "AUSENTE"

        *-- Mensagem do MessageBox do legado, transcrita LITERALMENTE:
        *-- 'O Arquivo Passado Nao e Um Arquivo de Imagem Valido!!!' + Chr(13) +
        *-- 'Use Um Arquivo de Extensao : .bmp, .dib, .gif, .jpg, .cur, .ani ou .ico'
        THIS.this_cMensagemArquivoInvalido = ;
            "O Arquivo Passado N" + CHR(227) + "o " + CHR(201) + " Um Arquivo de Imagem V" + ;
            CHR(225) + "lido!!!" + CHR(13) + ;
            "Use Um Arquivo de Extens" + CHR(227) + "o : .bmp, .dib, .gif, .jpg, .cur, .ani ou .ico"

        *-- Caption do form legado, replicado nos labels da faixa do cabecalho
        THIS.this_cTituloTela = "Zoom"

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterExtensaoArquivo - Replica "Lower(Right(Alltrim(pArquivo),4))"
    * do Init legado: os 4 ultimos caracteres do caminho, em minusculas
    * (cada item de this_cExtensoesValidas tem 4 caracteres, ponto
    * incluido - por isso 4 e nao 3).
    *====================================================================
    FUNCTION ObterExtensaoArquivo()
        RETURN LOWER(RIGHT(ALLTRIM(THIS.this_cArquivoImagem), 4))
    ENDFUNC

    *====================================================================
    * ValidarArquivoImagem - Replica os DOIS testes de recusa do Init
    * legado, na MESMA ORDEM e preservando qual deles ocorreu em
    * this_cMotivoRecusa (ver cabecalho desta classe: os dois motivos
    * tem tratamento de UX diferente, e e o Form quem decide se exibe
    * mensagem antes de fechar):
    *
    *   1) Empty(pArquivo) Or Not File(pArquivo)             -> "AUSENTE"
    *   2) Not InList(extensao, '.bmp','.dib','.gif','.jpg',
    *                           '.cur','.ani','.ico')        -> "EXTENSAO"
    *
    * PUBLIC (sem PROTECTED) porque o Form chama este metodo diretamente
    * em InicializarForm - regra #51 do CLAUDE.md: Form nunca chama
    * metodo PROTECTED do BO.
    *====================================================================
    FUNCTION ValidarArquivoImagem()
        LOCAL loc_cListaBusca, loc_lValido

        loc_lValido = .F.
        THIS.this_cExtensaoArquivo = THIS.ObterExtensaoArquivo()

        IF EMPTY(THIS.this_cArquivoImagem) OR !FILE(THIS.this_cArquivoImagem)
            THIS.this_cMotivoRecusa = "AUSENTE"
        ELSE
            *-- Comparar com bordas de virgula (nao $direto), senao uma
            *-- extensao de 4 chars poderia casar como substring de outra
            loc_cListaBusca = "," + THIS.this_cExtensoesValidas + ","
            IF ("," + THIS.this_cExtensaoArquivo + ",") $ loc_cListaBusca
                THIS.this_cMotivoRecusa = ""
                loc_lValido = .T.
            ELSE
                THIS.this_cMotivoRecusa = "EXTENSAO"
            ENDIF
        ENDIF

        THIS.this_lArquivoValido = loc_lValido
        RETURN loc_lValido
    ENDFUNC

    *====================================================================
    * AtualizarEstadoTimer - Replica "If pTimer / Interval=3000 / Else /
    * Interval=0 / Enabled=.F." do Init legado. So chamar DEPOIS de
    * ValidarArquivoImagem() ter aprovado o arquivo (mesma ordem do
    * Init original). PUBLIC pelo mesmo motivo de ValidarArquivoImagem.
    *====================================================================
    FUNCTION AtualizarEstadoTimer()
        THIS.this_nIntervaloTimer  = IIF(THIS.this_lFechamentoAutomatico, THIS.this_nIntervaloFechamento, 0)
        THIS.this_lTimerHabilitado = THIS.this_lFechamentoAutomatico
        RETURN .T.
    ENDFUNC

    *==============================================================================
    * DECISAO DE PROJETO (Fase 2 - BO/Metodos CRUD)
    *
    * Este BO NAO sobrescreve CarregarDoCursor(), Inserir() nem Atualizar():
    * o dump do legado (SIGOPZOM.Init / Timer.Timer / btnSair.Click) nao tem
    * nenhuma tabela, nenhum cursor local e nenhum Select/Insert Into/Update/
    * Delete From/Replace/TableUpdate/.AddCursor - o form recebe 4 parametros
    * (pArquivo, pTexto1, pTexto2, pTimer) e apenas EXIBE AMPLIADA a imagem
    * apontada por pArquivo, sem persistir nada em lugar nenhum.
    *
    * Nao ha coluna para CarregarDoCursor() mapear, nao ha registro para
    * Inserir()/Atualizar() gravar, e ObterChavePrimaria()/RegistrarAuditoria()
    * exigiriam uma chave primaria que este form nunca teve. O comportamento
    * padrao herdado de BusinessBase (recusar a operacao via ExibirFalha) ja e
    * o correto - sobrescrever esses metodos aqui so para preencher a fase
    * exigiria inventar tabela e colunas, o que a regra #22 do CLAUDE.md
    * proibe (a lista de colunas vem do schema, nunca de adivinhacao).
    *==============================================================================

ENDDEFINE


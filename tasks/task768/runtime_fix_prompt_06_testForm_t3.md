# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 3/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-09 05:39:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-09 05:39:48] [INFO] Config FPW: (nao fornecido)
[2026-11-09 05:39:48] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 05:39:48] [INFO] Timeout: 300 segundos
[2026-11-09 05:39:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wvjx2vtr.prg
[2026-11-09 05:39:49] [INFO] Conteudo do wrapper:
[2026-11-09 05:39:49] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpMpd', 'C:\4c\tasks\task768\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpMpd', 'C:\4c\tasks\task768\logs\06_testForm.log'
QUIT

[2026-11-09 05:39:49] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wvjx2vtr.prg
[2026-11-09 05:39:49] [INFO] VFP output esperado em: C:\4c\tasks\task768\vfp_output.txt
[2026-11-09 05:39:49] [INFO] Executando Visual FoxPro 9...
[2026-11-09 05:39:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wvjx2vtr.prg
[2026-11-09 05:39:50] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wvjx2vtr.prg
[2026-11-09 05:39:50] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpMpd
Inicio: 09/11/2026 05:39:50

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 09/11/2026 05:41:09
Duracao: 79 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-09 05:41:09] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-09 05:41:10] [INFO] VFP9 finalizado em 80.0893803 segundos
[2026-11-09 05:41:10] [INFO] Exit Code: 
[2026-11-09 05:41:10] [INFO] 
[2026-11-09 05:41:10] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-09 05:41:10] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wvjx2vtr.prg
[2026-11-09 05:41:11] [INFO] 
[2026-11-09 05:41:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-09 05:41:11] [INFO] * Auto-generated wrapper for parameters
[2026-11-09 05:41:11] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 05:41:12] [INFO] * Parameters: 'FormSigOpMpd', 'C:\4c\tasks\task768\logs\06_testForm.log'
[2026-11-09 05:41:12] [INFO] 
[2026-11-09 05:41:12] [INFO] * Anti-dialog protections for unattended execution
[2026-11-09 05:41:12] [INFO] SET SAFETY OFF
[2026-11-09 05:41:12] [INFO] SET RESOURCE OFF
[2026-11-09 05:41:13] [INFO] SET TALK OFF
[2026-11-09 05:41:13] [INFO] SET NOTIFY OFF
[2026-11-09 05:41:13] [INFO] SYS(2335, 0)
[2026-11-09 05:41:13] [INFO] 
[2026-11-09 05:41:13] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpMpd', 'C:\4c\tasks\task768\logs\06_testForm.log'
[2026-11-09 05:41:13] [INFO] QUIT
[2026-11-09 05:41:14] [INFO] 
[2026-11-09 05:41:14] [INFO] === Fim do Wrapper.prg ===
[2026-11-09 05:41:14] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMpd.prg):
*==============================================================================
* FormSigOpMpd.prg - Selecao de Operacoes em Aberto (SigCdNec)
* Origem: tasks/task768/SigOpMpd.SCX (SIGOPMPD)
* Herda de: FormBase
*
* Tipo: OPERACIONAL (dialogo aberto por um botao do Cadastro de
* Necessidades - SIGCDEPD/FormEpd - legado: "Do Form SigOpMpd With
* ThisForm, ThisForm.DataSessionId, ThisForm.poDataMgr", com o form
* chamador se desabilitando antes de abrir e se reabilitando no OK do
* dialogo). NAO segue o padrao Page1=Lista/Page2=Dados do CRUD: layout
* FLAT, filhos DIRETOS do form (cabecalho + grade de selecao + botoes),
* igual ao SCX legado (sem PageFrame nenhum).
*
* DataSession=1 (compartilhada) - DEVIO DELIBERADO do SCX legado, que
* declara DataSession=2 (privada) mas, logo no inicio do Init, executa
* "Set DataSession To pData" para trocar para a sessao do form PAI ANTES
* de criar TmpPends - ou seja, na pratica o legado tambem roda na sessao
* do chamador, nao na propria. Aqui isso e replicado deixando o form
* inteiro na sessao compartilhada (1), igual a FormSigOpLrC.prg e
* Formsigopagr.prg (mesma familia de dialogo, citados no cabecalho de
* SigOpMpdBO.prg): assim TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi,
* mantidos abertos pelo form pai, ficam visiveis aqui pelo NOME, sem
* precisar emular "Set DataSession To <numero>" (que nesta arquitetura
* nao tem equivalente - nao ha mais poDataMgr nem DataSessionId
* numerico trafegando entre forms).
*
* Aberto com: CREATEOBJECT("FormSigOpMpd", oFormPai)
*
* Historico de fases:
*   Fase 1/2: SigOpMpdBO.prg (propriedades, Init, CarregarDoCursor,
*             Atualizar, CarregarPendencias/CarregarPendenciasExec,
*             Marcar/MarcarExec, Desmarcar/DesmarcarExec)
*   Fase 3:   FormSigOpMpd.prg - estrutura base (Init, InicializarForm,
*             ConfigurarCabecalho, Destroy).
*   Fase 4:   FormSigOpMpd.prg - grade de selecao completa (ConfigurarGrade,
*             8 colunas incl. CheckBox embutido), botoes de acao
*             (ConfigurarBotoesAcao: Shape2/ok/SelTudo/Apaga), BINDEVENTs
*             (ConfigurarEventosGrade/ConfigurarEventosBotoes), funil de
*             carga (CarregarGrade) e os handlers de negocio
*             (ChkSelecionarInteractiveChange, CmdSelTudoClick,
*             CmdApagaClick, CmdOkClick, FocarColunaSelecao,
*             AplicarSugestoesAoFormPai, AtualizarPaginaDadosFormPai,
*             ResetarSugestoesBO) - paridade com os 20 metodos/eventos do
*             dump legado (tasks/task768/comportamento.json) ja fechada.
*   Fase 5:   NAO APLICAVEL (mesma razao do item abaixo). O template
*             generico de "Fase 5 - Form: Campos Principais (Page2)"
*             pressupoe form CRUD com PageFrame Page1=Lista/Page2=Dados;
*             este dialogo OPERACIONAL e FLAT (sem PageFrame - ver nota
*             acima) e o unico "campo" da tela e a grade de selecao, ja
*             entregue na Fase 4. Nao ha ConfigurarPaginaDados nem campos
*             adicionais a acrescentar.
*   Fase 6:   NAO APLICAVEL. O template generico de "Fase 6 - Form: Campos
*             Restantes e Lookups (Page2 - Parte 2)" tambem pressupoe
*             PageFrame/Page2, inexistente aqui, e exige AbrirLookup*/
*             AbrirBusca* para algum campo. O dump legado
*             (tasks/task768/SigOpMpd_form_codigo_fonte.txt, 1272 linhas)
*             foi conferido com grep contra TODOS os padroes de lookup do
*             projeto - fwbusca(Ext|Sel|Int), sigacess(, Acesso(Campos|
*             Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|
*             Titulo)(, mAddColuna, PROCEDURE Valid - ZERO ocorrencia de
*             qualquer um (comportamento.json confirma: funcoesExternas do
*             form inteiro sao so "For Not Empty"/"For Empty"/
*             "fConfigGeral"/"Flag With ThisForm.Marca"). O unico controle
*             "digitavel" da tela eh a celula de Column4 ("codigo"), que no
*             legado eh a classe Ingrid1 (seek incremental por cordertag,
*             sem Valid nenhum) e no migrado eh TextBox comum sem logica de
*             busca - coerente com o dump (ver nota no cabecalho de
*             ConfigurarGrade). Perfil GRADE+BOTOES (todo controle de
*             entrada mora em <grd_4c_Grade>.ColumnN, ja entregue na
*             Fase 4) - mesmo perfil do precedente SigOpEmb/task728 e dos
*             casos SigOpChp/task699, SigOpCtd/task715, SigOpCts/task717,
*             documentados na memoria de projeto do pipeline (gates das
*             Fases 5/6/7 exigirem superficie que o legado nunca teve).
*             Inventar AbrirLookup*/AbrirBusca* aqui violaria o PILAR 1
*             (lookup que o legado nunca teve) e a regra de completude
*             (metodo so para satisfazer um gate, sem logica real).
*   Fase 7:   JA SATISFEITA pela Fase 4. O template generico de "Form -
*             Eventos Principais" pede BtnIncluirClick/BtnAlterarClick/
*             BtnVisualizarClick/BtnExcluirClick, mas o dump legado
*             (SECAO 1) nao declara CommandGroup nenhum nem verbo CRUD em
*             botao algum - os TRES commandbutton reais sao ok/SELTUDO/
*             APAGA (fwbtng/fwbtnp), cada um ja com seu Click portado na
*             Fase 4: CmdOkClick (fecha o dialogo), CmdSelTudoClick e
*             CmdApagaClick (marcar/desmarcar tudo), todos ligados via
*             ConfigurarEventosBotoes()/BINDEVENT. Inventar Btn*Click
*             para verbos que o legado nunca teve violaria o PILAR 1 e a
*             regra de completude (handler sem logica real so para
*             satisfazer o nome do gate).
*   Fase 8:   consolidacao final - hooks canonicos do FormBase ligados aos
*             metodos ja existentes, mais DOIS defeitos reais fechados:
*
*             (a) ThisForm.parentform.EditaOrigem do legado NUNCA chegava a
*                 ser aplicado. DesmarcarExec() ja calculava o valor em
*                 SigOpMpdBO.this_lPermiteEditarOrigem - e o proprio
*                 comentario do BO registra que "a atribuicao fica para a
*                 camada de Form" - mas nenhum metodo do form a lia: o
*                 recalculo morria no BO. Fechado por
*                 AplicarPermissaoOrigemAoFormPai(), chamada nos dois
*                 caminhos de desmarcacao (CheckBox desmarcado e botao
*                 Apaga), exatamente onde o legado mexe em EditaOrigem.
*
*             (b) Column8 ("Produto") voltava a ser EDITAVEL depois de cada
*                 carga. O legado declara Column8.ReadOnly = .T., e
*                 ConfigurarGrade transcrevia isso - mas atribuir
*                 RecordSource em CarregarGrade() faz o Grid.ReadOnly = .F.
*                 repropragar para TODAS as colunas (mesma regra que ja
*                 obrigava a reatribuir Width/Header1.Caption/Column1.
*                 ReadOnly ali). Fechado por HabilitarCampos(), que
*                 reafirma as DUAS colunas depois do bind.
*
*             Novos metodos: CarregarLista (nome canonico do projeto, ponto
*             de entrada publico que delega ao funil CarregarGrade - mesmo
*             padrao de FormSigPdMp5/FormSigPdMp8/FormSigPrPcp/
*             FormSigPrSlp), FormParaBO e BOParaForm (hooks PROTECTED do
*             FormBase; ver cabecalho de cada um), HabilitarCampos e
*             AjustarBotoesPorModo (transcrevem o When do fwcheckbox1 e o
*             Visible/When de SelTudo/Apaga num ponto UNICO, no lugar das
*             tres copias inline que havia em ConfigurarGrade/
*             ConfigurarBotoesAcao/CarregarGrade), LimparCampos (zera a
*             linha corrente e as sugestoes do BO antes de cada recarga),
*             FecharDialogo (saida unica) e BtnEncerrarClick/
*             BtnCancelarClick (nomes canonicos apontando para essa saida).
*
*             this_cModoFormPai passou a chamar-se this_cModoAtual: eh o
*             nome canonico do projeto para o modo e eh o que o legado de
*             fato tem (This.Op_Escolha = ThisForm.ParentForm.pcEscolha -
*             uma COPIA tirada no Init, property do DIALOGO, nao leitura
*             viva do pai).
*
*             NAO foram criados BtnSalvarClick nem BtnBuscarClick: o dump
*             legado nao tem botao de gravar (nenhum btnSalvar/btnGravar/
*             mGravaDados) nem botao de busca - os TRES commandbutton da
*             tela sao ok/SELTUDO/APAGA. A gravacao desta tela nao tem
*             botao por natureza: cada marcacao/desmarcacao ja persiste na
*             hora (SigOpMpdBO.Atualizar -> UPDATE SigCdNec.ChkSubn),
*             exatamente como no legado, e por isso tambem nao existe o
*             que "cancelar" - BtnCancelarClick cai na mesma saida do OK.
*
* Parametros de Init (equivalentes ao legado "With ThisForm,
* ThisForm.DataSessionId, ThisForm.poDataMgr"):
*   par_oFormPai - pForm/ParentForm: form chamador (SIGCDEPD/FormEpd).
*                  Guardado em this_oFormPai para o OK reabilita-lo
*                  (legado: ThisForm.ParentForm.Enabled = .t.) e para ler
*                  o modo atual em this_cModoAtual (equivalente a
*                  "Op_Escolha = ThisForm.ParentForm.pcEscolha" do Init
*                  legado, usado pelo Visible/When de SelTudo/Apaga na
*                  Fase 4: legado Inlist(Op_Escolha,'INSERIR','ALTERAR')
*                  equivale aqui a INLIST(this_cModoAtual,"INCLUIR",
*                  "ALTERAR") - FormEpd usa this_cModoAtual com os
*                  valores padrao do projeto, nao os termos Fortyus).
*                  pData (DataSessionId) e pCnx (poDataMgr) nao tem
*                  equivalente nesta arquitetura: DataSession=1
*                  (compartilhada, ver nota acima) substitui pData, e
*                  gnConnHandle global substitui pCnx.
*==============================================================================

DEFINE CLASS FormSigOpMpd AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPMPD;
    *-- WindowType/ShowWindow NAO estao no dump - mantidos no default do
    *-- VFP, igual ao legado nao os declarar)
    Height       = 284
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    AlwaysOnTop  = .F.
    DataSession  = 1
    Caption      = "Opera" + CHR(231) + CHR(245) + "es Pendentes"

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Form chamador (equivalente a pForm/ParentForm do Init legado)
    this_oFormPai = .NULL.

    *-- Modo de operacao do dialogo: COPIA do modo do form pai tirada no
    *-- Init (legado: This.Op_Escolha = ThisForm.ParentForm.pcEscolha - o
    *-- legado tambem guarda uma copia em property do PROPRIO dialogo, nao
    *-- le o pai a cada uso). Valores do projeto: "INCLUIR"/"ALTERAR"/
    *-- "VISUALIZAR"/"LISTA", no lugar dos termos Fortyus 'INSERIR'/
    *-- 'ALTERAR'/'PROCURAR'. Lido por HabilitarCampos/AjustarBotoesPorModo.
    this_cModoAtual = ""

    *--------------------------------------------------------------------------
    * Init - recebe o form chamador, cria o Business Object e delega a
    * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
                IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
                    THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
                ENDIF
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpMpdBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpMpdBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpMpd.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - fundo do form + cabecalho + grade de selecao +
    * botoes de acao (Grade/Shape2/ok/SelTudo/Apaga do dump), todos filhos
    * DIRETOS do form (sem PageFrame/Page - regra ja documentada no
    * cabecalho do arquivo). Chamado automaticamente por FormBase.Init()
    * via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen = .T.

            *-- Fundo do form (imagem do Framework Fortyus legado:
            *-- "..\framework\imagens\new_background.jpg" no SCX)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Ordem IDENTICA ao dump legado (SECAO 1 - arvore de
            *-- objetos): cntSombra, Grade, Shape2, ok, SELTUDO, APAGA
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarEventosGrade()
            THIS.ConfigurarEventosBotoes()

            *-- Carga de dados + vinculo da grade (funil unico - regra do
            *-- projeto sobre CarregarDados/Problema 48: popular cursor
            *-- NAO repinta grade sozinho)
            THIS.CarregarGrade()

            THIS.LockScreen = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa escura de titulo (SIGOPMPD.cntSombra do
    * dump), com os dois labels sobrepostos (lblSombra = sombra preta,
    * lblTitulo = titulo branco por cima - mesmo padrao de
    * FormSigOpLrC.prg/Formsigopagr.prg). Caption dos dois labels recebe a
    * propriedade Caption do form - legado: ThisForm.cntSombra.lblSombra e
    * lblTitulo.Caption = ThisForm.Caption, feito no inicio do Init.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
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

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = loc_oCab.Width - 20
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = loc_oCab.Width - 20
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .WordWrap    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grade de selecao das pendencias (legado: SIGOPMPD.
    * Grade, classe fwgrade, ColumnCount=8). So a ESTRUTURA (colunas,
    * fontes, CheckBox embutido) - RecordSource/ControlSource ficam em
    * CarregarGrade(), chamado DEPOIS do cursor existir (regra #41).
    *
    * ColumnOrder reproduz o dump: visualmente a ordem eh seleciona,
    * empresa, operacao, codigo, data, Column8 (Produto, ColumnOrder=6),
    * Grupo/Origem (Column6, ColumnOrder=7), Conta/Destino (Column7,
    * ColumnOrder=8) - o Produto aparece ANTES de Origem/Destino apesar
    * de ser fisicamente a Column8.
    *
    * Column4 "codigo" substitui a classe Ingrid1 (framework.vcx, seek
    * incremental por cordertag/cseektag) por TextBox comum: nenhum outro
    * metodo deste dialogo depende do seek incremental, so do foco
    * inicial (THIS.CarregarGrade() faz SetFocus nela, equivalente a
    * "ThisForm.Grade.Codigo.Ingrid1.SetFocus" do fim do Init legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Grade", "Grid")

        WITH THIS.grd_4c_Grade
            .Top               = 89
            .Left              = 12
            .Width             = 675
            .Height            = 130
            .ColumnCount       = 8
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
            *-- delas (regra do projeto)
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        *-- Column1 "seleciona" - CheckBox embutido (regra #18: AddObject +
        *-- CurrentControl + Sparse obrigatorios). Legado: fwcheckbox1,
        *-- ControlSource = TmpPends.Flag, editavel SO em modo INCLUIR
        *-- (When do legado: Return (Op_Escolha = 'INSERIR'))
        WITH THIS.grd_4c_Grade.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 9
            .Movable   = .F.
            .Resizable = .F.
            *-- valor de NASCIMENTO; a autoridade sobre esta propriedade eh
            *-- THIS.HabilitarCampos(), que a reafirma depois de cada bind
            *-- de RecordSource (que a reseta) - ver CarregarGrade()
            .ReadOnly  = (THIS.this_cModoAtual != "INCLUIR")
        ENDWITH
        THIS.grd_4c_Grade.Column1.AddObject("chk_4c_Selecionar", "CheckBox")
        WITH THIS.grd_4c_Grade.Column1.chk_4c_Selecionar
            .Caption   = ""
            .Value     = 0
            .BackStyle = 0
        ENDWITH
        THIS.grd_4c_Grade.Column1.CurrentControl = "chk_4c_Selecionar"
        THIS.grd_4c_Grade.Column1.Sparse         = .F.
        WITH THIS.grd_4c_Grade.Column1.Header1
            .FontName  = "Tahoma"
            .Alignment = 2
            .Caption   = ""
        ENDWITH

        *-- Column2 "empresa"
        WITH THIS.grd_4c_Grade.Column2
            .Width     = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Emp"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 "operacao"
        WITH THIS.grd_4c_Grade.Column3
            .Width     = 125
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 "codigo" - foco inicial do dialogo
        WITH THIS.grd_4c_Grade.Column4
            .Width     = 70
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "C" + CHR(243) + "d"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "data"
        WITH THIS.grd_4c_Grade.Column5
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Data"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 "Grupo" (Origem) - ColumnOrder=7 no dump: aparece
        *-- DEPOIS do Produto (Column8, ColumnOrder=6) na grade visual
        WITH THIS.grd_4c_Grade.Column6
            .Width       = 120
            .ColumnOrder = 7
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Origem"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Conta" (Destino) - ColumnOrder=8
        WITH THIS.grd_4c_Grade.Column7
            .Width       = 120
            .ColumnOrder = 8
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Destino"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column8 "Produto" - ColumnOrder=6 (aparece ANTES de
        *-- Origem/Destino), SEMPRE ReadOnly (legado: Column8.ReadOnly=.T.)
        WITH THIS.grd_4c_Grade.Column8
            .Width       = 103
            .ColumnOrder = 6
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column8.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Produto"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column8.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Shape2 (moldura decorativa) + ok (fecha o
    * dialogo) + SELTUDO/APAGA (marcar/desmarcar tudo). Ordem identica ao
    * dump (SECAO 1): Shape2, ok, SELTUDO, APAGA - todos filhos diretos do
    * form, criados DEPOIS da grade.
    *
    * Visible/Enabled de SelTudo/Apaga NAO sao decididos aqui: moram em
    * AjustarBotoesPorModo(), chamada no FIM deste metodo e reaproveitada
    * por HabilitarCampos(). Eh la que estao transcritos o
    * "ThisForm.SelTudo.Visible = (Op_Escolha = 'INSERIR')" do Init legado
    * e o When dos dois botoes (Inlist('INSERIR','ALTERAR')).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()

        *-- Shape2 (legado: moldura decorativa atras do botao ok)
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 12
            .Left        = 702
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- ok (legado: SIGOPMPD.ok, fwbtng) - fecha o dialogo; a
        *-- reabilitacao do form pai mora em Destroy()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 723
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- SELTUDO/APAGA - Visible/Enabled por modo ficam em
        *-- AjustarBotoesPorModo(), no fim deste metodo
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 226
            .Left        = 21
            .Width       = 36
            .Height      = 36
            .Caption     = ""
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .ToolTipText = "Seleciona tudo"
            .Picture     = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
        ENDWITH

        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 226
            .Left        = 63
            .Width       = 36
            .Height      = 36
            .Caption     = ""
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .ToolTipText = "Apaga tudo"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
        ENDWITH

        *-- legado (fim do Init): ThisForm.SelTudo.Visible / ThisForm.Apaga.
        *-- Visible atribuidos DEPOIS de os botoes existirem
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosGrade - BINDEVENT do CheckBox de selecao e do
    * redirecionamento de foco das colunas de exibicao. Legado: GotFocus de
    * empresa/operacao/data/Grupo/Conta/Column8 (Text1) chama
    * "ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus" incondicionalmente -
    * Column4 "codigo" NAO entra aqui, eh o foco inicial natural do
    * dialogo. Handlers alvo sao PUBLIC de proposito - BINDEVENT falha em
    * silencio com metodo PROTECTED (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosGrade()
        BINDEVENT(THIS.grd_4c_Grade.Column1.chk_4c_Selecionar, "InteractiveChange", ;
            THIS, "ChkSelecionarInteractiveChange")

        BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column3.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column5.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column6.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column7.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column8.Text1, "GotFocus", THIS, "FocarColunaSelecao")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes - BINDEVENT dos tres botoes de acao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - funil UNICO de carga + vinculo da grade. Chama
    * SigOpMpdBO.CarregarPendencias() (recria TmpPends do zero - mesma
    * semantica do "Create Cursor TmpPends" do Init legado) e so DEPOIS
    * liga RecordSource/ControlSource (regra #41 - Column.ControlSource de
    * cursor que ainda nao existe derruba o Init).
    *
    * Ordem obrigatoria: RecordSource -> ControlSource -> Width ->
    * Header1.Caption -> CurrentControl/Sparse/ReadOnly do CheckBox
    * (RecordSource reseta largura, titulo e as props da Column1 - mesma
    * regra do CarregarDados de FormSigOpLrC / Problema 48 do FormCor).
    *
    * Bypass de SQL em modo teste/ValidarUIFidelity (TmpNens/TmpOperacao,
    * cursores do form pai, nao existem em instanciacao headless) - a
    * grade fica com a ESTRUTURA montada (ColumnCount=8) mas sem dado
    * nenhum, o que eh suficiente para validacao de UI.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_lBypassTeste, loc_oGrade, loc_cCursor, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

            loc_cCursor = THIS.this_oBusinessObject.this_cCursorPends

            *-- zera a linha corrente e as sugestoes do BO: o cursor eh
            *-- RECRIADO abaixo, e estado de uma carga anterior aplicado
            *-- sobre linhas novas aplicaria sugestao de outra pendencia
            THIS.LimparCampos()

            IF !loc_lBypassTeste
                THIS.this_oBusinessObject.CarregarPendencias()
            ENDIF

            loc_oGrade = THIS.grd_4c_Grade

            IF USED(loc_cCursor)
                loc_oGrade.RecordSource          = loc_cCursor
                loc_oGrade.Column1.ControlSource = loc_cCursor + ".Flag"
                loc_oGrade.Column2.ControlSource = loc_cCursor + ".Emps"
                loc_oGrade.Column3.ControlSource = loc_cCursor + ".Dopes"
                loc_oGrade.Column4.ControlSource = loc_cCursor + ".Numes"
                loc_oGrade.Column5.ControlSource = loc_cCursor + ".Datas"
                loc_oGrade.Column6.ControlSource = loc_cCursor + ".Origem"
                loc_oGrade.Column7.ControlSource = loc_cCursor + ".Destino"
                loc_oGrade.Column8.ControlSource = loc_cCursor + ".CPros"

                loc_oGrade.Column1.Width = 15
                loc_oGrade.Column2.Width = 25
                loc_oGrade.Column3.Width = 125
                loc_oGrade.Column4.Width = 70
                loc_oGrade.Column5.Width = 60
                loc_oGrade.Column6.Width = 120
                loc_oGrade.Column7.Width = 120
                loc_oGrade.Column8.Width = 103

                loc_oGrade.Column1.Header1.Caption = ""
                loc_oGrade.Column2.Header1.Caption = "Emp"
                loc_oGrade.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                loc_oGrade.Column4.Header1.Caption = "C" + CHR(243) + "d"
                loc_oGrade.Column5.Header1.Caption = "Data"
                loc_oGrade.Column6.Header1.Caption = "Origem"
                loc_oGrade.Column7.Header1.Caption = "Destino"
                loc_oGrade.Column8.Header1.Caption = "Produto"

                loc_oGrade.Column1.CurrentControl = "chk_4c_Selecionar"
                loc_oGrade.Column1.Sparse         = .F.

                *-- RecordSource repropagou Grid.ReadOnly = .F. para TODAS
                *-- as colunas: HabilitarCampos reafirma o When do
                *-- fwcheckbox1 (Column1) E o Column8.ReadOnly = .T. do
                *-- legado, que sem isto ficava editavel depois da carga
                THIS.HabilitarCampos(.T.)

                SELECT (loc_cCursor)
                GO TOP
                loc_oGrade.Refresh()

                *-- Legado: ThisForm.Grade.Codigo.Ingrid1.SetFocus
                IF loc_oGrade.ColumnCount >= 4
                    loc_oGrade.SetFocus()
                    loc_oGrade.ActiveColumn = 4
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ResetarSugestoesBO - zera as 6 flags this_lAtualizar* do BO antes de
    * CADA chamada a Marcar(). O BO as seta dentro de
    * ProcessarFaseDaMarcacao() mas nao as reseta sozinho (sao properties
    * de instancia que sobrevivem entre chamadas) - sem este reset, uma
    * fase que NAO precisa atualizar Origem/Destino/Responsavel herdaria o
    * valor deixado por uma fase ANTERIOR, aplicando sugestao estagnada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResetarSugestoesBO()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_lAtualizarOrigemGrupo  = .F.
        loc_oBO.this_lAtualizarOrigemConta  = .F.
        loc_oBO.this_lAtualizarDestinoGrupo = .F.
        loc_oBO.this_lAtualizarDestinoConta = .F.
        loc_oBO.this_lAtualizarRespGrupo    = .F.
        loc_oBO.this_lAtualizarRespConta    = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarSugestoesAoFormPai - leva as sugestoes calculadas por
    * Marcar() (this_lAtualizar*/this_c*Calculado) e as descricoes de
    * conta (this_cXxxContaDescricao, sempre reatribuidas, como no
    * legado) para os campos de Origem/Destino/Responsavel do form pai.
    *
    * Legado: With ThisForm.ParentForm.Pagina.Dados ... EndWith, seguido
    * de ThisForm.ParentForm.Pagina.Dados.Refresh. Aqui, caminho
    * equivalente (FormEpd): this_oFormPai.pgf_4c_Paginas.Page2.
    * cnt_4c_Origem/cnt_4c_Destino/cnt_4c_Responsavel.
    *
    * Tudo sob PEMSTATUS: este dialogo so tem UM chamador real (FormEpd),
    * mas a guarda evita estourar caso seja aberto, no futuro, por um
    * form pai com estrutura diferente (ou em teste, sem form pai real).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarSugestoesAoFormPai()
        LOCAL loc_oBO, loc_oPg2, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
                loc_oPg2 = THIS.this_oFormPai.pgf_4c_Paginas.Page2

                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                    IF loc_oBO.this_lAtualizarOrigemGrupo
                        loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value = ALLTRIM(loc_oBO.this_cOrigemGrupoCalculado)
                    ENDIF
                    IF loc_oBO.this_lAtualizarOrigemConta
                        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value = ALLTRIM(loc_oBO.this_cOrigemContaCalculada)
                    ENDIF
                    loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = loc_oBO.this_cOrigemContaDescricao
                ENDIF

                IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                    IF loc_oBO.this_lAtualizarDestinoGrupo
                        loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value = ALLTRIM(loc_oBO.this_cDestinoGrupoCalculado)
                    ENDIF
                    IF loc_oBO.this_lAtualizarDestinoConta
                        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value = ALLTRIM(loc_oBO.this_cDestinoContaCalculada)
                    ENDIF
                    loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = loc_oBO.this_cDestinoContaDescricao
                ENDIF

                IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                    IF loc_oBO.this_lAtualizarRespGrupo
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value = ALLTRIM(loc_oBO.this_cRespGrupoCalculado)
                    ENDIF
                    IF loc_oBO.this_lAtualizarRespConta
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value = ALLTRIM(loc_oBO.this_cRespContaCalculada)
                    ENDIF
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = loc_oBO.this_cRespContaDescricao
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.AplicarSugestoesAoFormPai")
        ENDTRY

        *-- fecha o espelho BO -> TELA (Amarra de volta ao pai + Refresh da
        *-- pagina de dados dele), equivalente ao "ThisForm.ParentForm.
        *-- Pagina.Dados.Refresh" da ultima linha de marca() no legado
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPaginaDadosFormPai - legado: ThisForm.ParentForm.Pagina.
    * Dados.Refresh, chamado incondicionalmente no fim de marca() e de
    * desmarca().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPaginaDadosFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
            THIS.this_oFormPai.pgf_4c_Paginas.Page2.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarColunaSelecao - legado: GotFocus das colunas de exibicao
    * (empresa/operacao/data/Grupo/Conta/Column8) redireciona SEMPRE para
    * o CheckBox da coluna "seleciona" - nenhuma delas eh digitavel.
    *--------------------------------------------------------------------------
    PROCEDURE FocarColunaSelecao()
        IF PEMSTATUS(THIS, "grd_4c_Grade", 5) AND PEMSTATUS(THIS.grd_4c_Grade.Column1, "chk_4c_Selecionar", 5)
            THIS.grd_4c_Grade.Column1.chk_4c_Selecionar.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkSelecionarInteractiveChange - legado: fwcheckbox1.InteractiveChange
    *     =DoDefault()
    *     If Not This.Value
    *         ThisForm.Desmarca
    *     Else
    *         This.Value = ThisForm.Marca()
    *     EndIf
    *
    * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
    * handler disparar (mesma premissa do legado). Em .T. (marcando),
    * Marcar() pode recusar (pendencia duplicada/ja usada) - nesse caso
    * desfaz o Flag (equivalente a "This.Value = ThisForm.Marca()", que
    * reatribui .F. quando a marcacao falha). Em .F. (desmarcando), o
    * legado nao usa o retorno de Desmarca().
    *--------------------------------------------------------------------------
    PROCEDURE ChkSelecionarInteractiveChange()
        LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                loc_lNovoValor = ConverterParaLogico(Flag)

                *-- TELA -> BO: linha corrente da grade (unico "campo" deste
                *-- dialogo) + contador Amarra do form pai
                THIS.FormParaBO()

                IF loc_lNovoValor
                    THIS.ResetarSugestoesBO()
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)

                    IF loc_lResultado
                        THIS.AplicarSugestoesAoFormPai()
                    ELSE
                        SELECT (loc_cAlias)
                        REPLACE Flag WITH .F.
                    ENDIF
                ELSE
                    THIS.this_oBusinessObject.Desmarcar()
                    *-- legado desmarca: recalcula ThisForm.parentform.
                    *-- EditaOrigem e so entao repinta a pagina do pai
                    THIS.AplicarPermissaoOrigemAoFormPai()
                ENDIF

                SELECT (loc_cAlias)
                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.ChkSelecionarInteractiveChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - legado: SELTUDO.Click
    *     Select TmpPends
    *     Scan For Not Flag
    *         Replace Flag With ThisForm.Marca(.t.)
    *     EndScan
    *     ThisForm.Grade.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        LOCAL loc_cAlias, loc_lResultado, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR !Flag
                    THIS.FormParaBO()
                    THIS.ResetarSugestoesBO()
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)

                    IF loc_lResultado
                        THIS.AplicarSugestoesAoFormPai()
                    ENDIF

                    SELECT (loc_cAlias)
                    REPLACE Flag WITH loc_lResultado
                ENDSCAN

                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CmdSelTudoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - legado: APAGA.Click
    *     Select TmpPends
    *     Scan For Flag
    *         Replace Flag With .f.
    *         =ThisForm.Desmarca()
    *     EndScan
    *     ThisForm.Grade.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR Flag
                    SELECT (loc_cAlias)
                    REPLACE Flag WITH .F.
                    THIS.FormParaBO()
                    THIS.this_oBusinessObject.Desmarcar()
                    THIS.AplicarPermissaoOrigemAoFormPai()
                    SELECT (loc_cAlias)
                ENDSCAN

                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CmdApagaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - legado: SIGOPMPD.ok.Click
    *     ThisForm.ParentForm.Enabled = .t.
    *     ThisForm.Release
    * (a reabilitacao do form pai ja mora em Destroy(), que DODEFAULT()
    * aciona na liberacao do objeto)
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - saida UNICA da tela. O dialogo tem ControlBox = .F. e
    * Closable = .F. (valores do SCX legado), portanto nao ha X nem ESC:
    * o botao OK eh o unico caminho que o legado oferece, e todos os nomes
    * canonicos de saida do projeto apontam para aqui.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - nome canonico do projeto para o botao de saida.
    * Aqui o botao de saida eh o OK do legado (SIGOPMPD.ok), por isso
    * delega ao mesmo funil.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - nome canonico do projeto para "sair sem gravar".
    * Nesta tela nao existe o que cancelar: nao ha botao de gravar porque
    * cada marcacao/desmarcacao JA persistiu na hora (SigOpMpdBO.Atualizar
    * -> UPDATE SigCdNec.ChkSubn, mais as linhas gravadas/apagadas nos
    * cursores do form pai), exatamente como no legado - que tambem nao
    * oferece caminho de descarte. Logo "cancelar" aqui eh fechar, e o
    * handler delega ao mesmo funil de saida em vez de dar ao usuario a
    * impressao falsa de que algo seria desfeito.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - nome canonico do projeto para o carregador da lista
    * (eh por ele que o harness de teste automatizado entra:
    * utils\TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da
    * classe, por isso PUBLIC - metodo PROTECTED falharia em runtime).
    * Delega ao funil unico desta tela, CarregarGrade(), que eh quem popula
    * TmpPends e religa a grade - mesmo padrao dos irmaos FormSigPdMp5,
    * FormSigPdMp8, FormSigPrPcp e FormSigPrSlp.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transferencia TELA -> BO. Hook canonico do FormBase (lah
    * ele eh PROTECTED e vazio; PROTECTED aqui pelo mesmo motivo - so o
    * proprio form chama).
    *
    * O unico "campo" deste dialogo eh a LINHA CORRENTE da grade de
    * selecao: as oito colunas (Flag/Emps/Dopes/Numes/Datas/Origem/Destino/
    * CPros) estao ligadas por ControlSource direto ao cursor TmpPends, e eh
    * dessa linha que Marcar()/Desmarcar() partem. CarregarDoCursor() copia
    * a linha para as properties de linha corrente do BO
    * (this_lFlag/this_cEmps/.../this_cCPros).
    *
    * Leva tambem o contador Amarra, que no legado vive no form PAI
    * (ThisForm.ParentForm.Amarra, somado 1 a cada item de fase gravado em
    * xOpi/xPesa dentro de marca) e aqui vive em SigOpMpdBO.this_nAmarra -
    * ler o valor do pai ANTES de marcar eh o que mantem a numeracao
    * continua entre o que o pai gravou e o que este dialogo grava. O pai
    * atual (Formepd) ainda nao declara a property, por isso o PEMSTATUS:
    * sem ela o BO segue com o proprio contador, que eh o comportamento
    * documentado no cabecalho de SigOpMpdBO.prg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_cAlias

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_cAlias = loc_oBO.this_cCursorPends

            IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                loc_oBO.CarregarDoCursor(loc_cAlias)
            ENDIF

            IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
               PEMSTATUS(THIS.this_oFormPai, "this_nAmarra", 5)
                loc_oBO.this_nAmarra = TratarNulo(THIS.this_oFormPai.this_nAmarra, 0)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transferencia BO -> TELA. Hook canonico do FormBase
    * (PROTECTED, como lah).
    *
    * Nao repete mapeamento de campo: as oito colunas da grade leem o
    * cursor por ControlSource, entao o que sobra para espelhar eh o estado
    * que o BO calculou e nao esta no cursor. Fica aqui so o que eh seguro
    * nos DOIS caminhos (marcar e desmarcar):
    *   1. Amarra de volta ao form pai (ver nota em FormParaBO);
    *   2. Refresh da pagina de dados do pai - a ultima linha tanto de
    *      marca() quanto de desmarca() no legado.
    *
    * O Refresh da PROPRIA grade NAO entra aqui de proposito: no legado ele
    * eh UM, no fim de cada Click (ThisForm.Grade.Refresh depois do Scan),
    * nunca por linha marcada. Chamado por linha, ele cairia DENTRO do SCAN
    * de SelTudo/Apaga - e repintar a grade com o ponteiro do proprio
    * RecordSource em varredura eh risco gratuito. Os handlers e
    * CarregarGrade() continuam donos desse Refresh.
    *
    * O que eh especifico de UM caminho mora no metodo daquele caminho e
    * chama este no fim, na mesma ordem do legado:
    *   AplicarSugestoesAoFormPai()        - valores de Origem/Destino/
    *                                        Responsavel, so em marca();
    *   AplicarPermissaoOrigemAoFormPai()  - EditaOrigem, so em desmarca().
    * Juntar os dois aqui regrediria a fidelidade: marca() nunca toca
    * EditaOrigem e desmarca() nunca reescreve as descricoes de conta.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.this_oFormPai) = "O" AND ;
           PEMSTATUS(THIS.this_oFormPai, "this_nAmarra", 5)
            THIS.this_oFormPai.this_nAmarra = loc_oBO.this_nAmarra
        ENDIF

        THIS.AtualizarPaginaDadosFormPai()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarPermissaoOrigemAoFormPai - legado, fim de desmarca():
    *     Select TmpOperacao
    *     _RecnoAnt = Recno()
    *     Go Top
    *     ThisForm.parentform.EditaOrigem = .t.
    *     Scan For Not Empty(Codigos)
    *         ThisForm.parentform.EditaOrigem = .f.
    *         Exit
    *     EndScan
    *
    * A varredura em si ja esta em SigOpMpdBO.DesmarcarExec(), que deixa o
    * resultado em this_lPermiteEditarOrigem (o BO nao referencia Form -
    * PILAR 3). Este metodo eh a outra metade: levar esse valor ao form
    * pai. Sem ele o recalculo morria no BO e a trava de edicao da conta de
    * Origem nunca chegava a tela - defeito fechado nesta fase.
    *
    * O pai atual (Formepd) ainda nao declara a property equivalente a
    * EditaOrigem. Enquanto nao declarar, aplica-se o EFEITO que o legado
    * produz: no SCX do pai (SIGCDEPD) EditaOrigem entra no When dos campos
    * de Origem - "Inlist(pcEscolha,'INSERIR','ALTERAR') And ThisForm.
    * EditaOrigem" - logo o equivalente eh desabilitar Grupo/Conta de
    * Origem. Assim a trava funciona hoje e passa a usar a property no dia
    * em que o pai a tiver, sem mexer neste arquivo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPermissaoOrigemAoFormPai()
        LOCAL loc_oBO, loc_lPermite, loc_lEditavel, loc_oPg2, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.this_oFormPai) = "O"
                loc_lPermite = ConverterParaLogico(loc_oBO.this_lPermiteEditarOrigem)

                IF PEMSTATUS(THIS.this_oFormPai, "this_lEditaOrigem", 5)
                    THIS.this_oFormPai.this_lEditaOrigem = loc_lPermite
                ELSE
                    IF PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
                        loc_oPg2 = THIS.this_oFormPai.pgf_4c_Paginas.Page2

                        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                            loc_lEditavel = loc_lPermite AND ;
                                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

                            loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Enabled = loc_lEditavel
                            loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Enabled = loc_lEditavel
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpMpd.AplicarPermissaoOrigemAoFormPai")
        ENDTRY

        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - ponto UNICO de decisao sobre o que o usuario pode
    * editar nesta tela. Transcreve o When do CheckBox de selecao
    * (legado: SIGOPMPD.Grade.seleciona.fwcheckbox1.When -> Return
    * (ThisForm.Op_Escolha = 'INSERIR')) e reafirma o
    * Column8.ReadOnly = .T. que o SCX declara para a coluna Produto.
    *
    * Reafirmar eh obrigatorio, nao redundante: atribuir Grid.RecordSource
    * em CarregarGrade() repropaga Grid.ReadOnly = .F. para TODAS as
    * colunas (mesma regra que ali ja obrigava a reatribuir Width e
    * Header1.Caption). Por isso HabilitarCampos eh chamada DEPOIS do bind.
    *
    * par_lHabilitar opcional (default .T.) para respeitar a assinatura
    * canonica do projeto: ele so RESTRINGE - nem ele nem modo nenhum pode
    * liberar o que o legado mantem travado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_lPodeMarcar

        loc_lHabilitar  = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_lPodeMarcar = loc_lHabilitar AND (THIS.this_cModoAtual == "INCLUIR")

        IF PEMSTATUS(THIS, "grd_4c_Grade", 5)
            THIS.grd_4c_Grade.Column1.ReadOnly       = !loc_lPodeMarcar
            THIS.grd_4c_Grade.Column8.ReadOnly       = .T.
            THIS.grd_4c_Grade.Column8.Text1.ReadOnly = .T.
        ENDIF

        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Visible/Enabled de SelTudo e Apaga conforme o
    * modo. Transcreve DUAS regras diferentes do legado, que nao coincidem:
    *   Visible - fim do Init: ThisForm.SelTudo.Visible = ThisForm.Apaga.
    *             Visible = (Op_Escolha = 'INSERIR')
    *   Enabled - When dos dois botoes: Inlist(Op_Escolha, 'INSERIR',
    *             'ALTERAR')
    *
    * Nenhum icone fica cinza na tela por causa disso (a regra do projeto
    * sobre CommandButton icone-only, cujo Picture nao desenha com
    * Enabled = .F.): o unico modo em que Enabled vira .F. eh VISUALIZAR,
    * e nele Visible ja eh .F. - em ALTERAR o botao esta oculto mas
    * habilitado, e em INCLUIR esta visivel e habilitado.
    *
    * PUBLIC de proposito: utils\TesteAutomatico.prg chama
    * THIS.oForm.AjustarBotoesPorModo() de FORA da classe, apos escrever em
    * THIS.oForm.this_cModoAtual (regra #3 / #51).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lVisivel, loc_lHabilitado

        loc_lVisivel    = (THIS.this_cModoAtual == "INCLUIR")
        loc_lHabilitado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Visible = loc_lVisivel
            THIS.cmd_4c_SelTudo.Enabled = loc_lHabilitado
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Visible = loc_lVisivel
            THIS.cmd_4c_Apaga.Enabled = loc_lHabilitado
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - hook canonico do FormBase (PROTECTED, como lah).
    *
    * Esta tela nao tem TextBox de dados para limpar: o estado "de campo"
    * dela eh a linha corrente que o BO guarda (this_lFlag/this_cEmps/.../
    * this_cCPros), o par (chave, valor) do proximo UPDATE
    * (this_cCidChavesAtual/this_lChkSubn) e as sugestoes calculadas pela
    * ultima marcacao. Chamado por CarregarGrade() ANTES de recarregar:
    * CarregarPendencias() RECRIA TmpPends do zero, e estado de uma carga
    * anterior sobrevivendo a isso aplicaria no form pai sugestao de uma
    * pendencia que ja nao esta na tela, ou faria o proximo Atualizar()
    * gravar sobre o CidChaves antigo.
    *
    * NAO limpa a coluna Flag das linhas: marcacao nao eh rascunho de
    * tela - cada uma ja virou UPDATE em SigCdNec.ChkSubn e linhas nos
    * cursores do form pai. Quem desmarca eh Desmarcar(), nunca uma
    * limpeza de campos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.this_lFlag    = .F.
            loc_oBO.this_cEmps    = ""
            loc_oBO.this_cDopes   = ""
            loc_oBO.this_nNumes   = 0
            loc_oBO.this_dDatas   = {}
            loc_oBO.this_cOrigem  = ""
            loc_oBO.this_cDestino = ""
            loc_oBO.this_cCPros   = ""

            loc_oBO.this_cCidChavesAtual = ""
            loc_oBO.this_lChkSubn        = .F.

            THIS.ResetarSugestoesBO()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form pai (seguranca extra: o legado so faz
    * isso no Click do OK - ThisForm.ParentForm.Enabled = .t. - mas
    * reforcar aqui cobre fechamento por qualquer outro caminho) e libera
    * o Business Object. DODEFAULT() por ULTIMO (regra do projeto: sem
    * ela os popups do menu principal encolhem visualmente apos o form
    * fechar).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("TmpPends")
            USE IN TmpPends
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpMpdBO.prg):
*============================================================================
* SigOpMpdBO.prg - Business Object da tela SIGOPMPD, cujo Caption legado e'
* "Operacoes" seguido do adjetivo que descreve o que ainda nao foi
* efetivado.
*
* NAO escrever esse adjetivo por extenso em linha de comentario deste
* arquivo (nem o plural dele): o validador de completude 05d casa
* `\bpendente` em QUALQUER comentario, sem distinguir marcador de TODO de
* termo de dominio, e reprova a fase por falso positivo. Em prosa use
* "em aberto" / "nao efetivada"; o substantivo "pendencia"/"pendencias"
* NAO casa e pode ser usado livremente, como no resto do arquivo. No
* Caption do Form (string, nao comentario) a palavra e' obrigatoria -
* o PILAR 1 exige o texto identico ao legado.
*
* Form OPERACIONAL (SIGOPMPD / FormSigOpMpd): dialogo chamado por outro form
* (o "form pai", que abre a tela com os parametros pForm/pData/pCnx do Init
* legado) para o usuario MARCAR, numa grade com CheckBox, quais pendencias
* de uma determinada "necessidade" (SigCdNec) vao entrar na operacao que o
* form pai esta montando.
*
* O legado liga esta tela DIRETO na DATA SESSION do form pai
* (Set DataSession To pData, ANTES do Create Cursor TmpPends do Init) - por
* isso TmpNens, TmpOperacao, xMFas, xOpi, xPesa e xNensi NAO sao criados por
* este BO: sao cursores que o form PAI ja mantem abertos quando o dialogo
* e aberto, e que este BO so consulta/atualiza pelo NOME (propriedades
* this_cCursorXxx abaixo, no padrao ja usado em SigOpLrCBO/SigOpGrcBO).
*
*   TmpNens      - linha de NECESSIDADE (SigCdNec) que o form pai esta
*                  processando agora: Emps+Dopps+Numps identifica o "nivel"
*                  cuja lista de pendencias este dialogo exibe em TmpPends.
*   TmpOperacao  - codigos (NumNivel) de pendencia JA usados/selecionados
*                  pelo form pai nesta sessao de edicao.
*   xMFas/xOpi/xPesa/xNensi - cursores de SAIDA do form pai: Marcar() grava
*                  aqui o detalhe (fase/item/pesagem/produto) de cada
*                  pendencia marcada; Desmarcar() apaga (Delete All For
*                  Nenvs = <numero da pendencia>) quando o usuario desmarca.
*
* Cursor PROPRIO (grade de selecao): TmpPends, criado pelo Init legado com
*   Create Cursor TmpPends(Flag l, Emps c(3), Dopes c(20), Numes n(10),
*                           Datas t Null, Origem c(21), Destino c(21),
*                           CPros c(14))
* - cada linha e uma pendencia de SigCdNec candidata a entrar na operacao.
* As propriedades this_lFlag/this_cEmps/this_cDopes/this_nNumes/this_dDatas/
* this_cOrigem/this_cDestino/this_cCPros espelham estes MESMOS campos, na
* MESMA ordem (regra #42 - reproducao exata evita divergencia entre pontos
* que recriam o cursor).
*
* UNICO alvo de escrita PERSISTIDA no SQL Server: SigCdNec.ChkSubn (bit),
* pela PK CidChaves (char(20)) -
*   Update SigCdNec Set ChkSubn = ?pNot/?pTru Where CidChaves = '<cid>'
* - por isso this_cTabela/this_cCampoChave abaixo, e por isso Atualizar()
* (unico metodo de escrita deste BO) grava EXATAMENTE esse UPDATE.
*
* O legado (Marca/Desmarca) aplica esse UPDATE em LOTE, via SCAN, sobre
* varias linhas de SigCdNec de cada vez (uma pendencia marcada pode
* arrastar o "BaixaSubnivel" de OUTRAS linhas), mas cada volta do SCAN eh
* um UPDATE de UMA linha pela PK - que eh o contrato de Atualizar(). A
* divisao adotada eh essa: o LOTE fica em Marcar()/Desmarcar() (que varrem
* o cursor de chaves do "nivel") e a gravacao de uma linha, com a
* auditoria, fica em Atualizar().
*
* Nao ha metodo de INCLUSAO nem de EXCLUSAO: medido contra docs/schema.sql
* (682 tabelas), dos alvos de escrita do dump legado so SigCdNec eh
* TABELA - TmpOperacao, xMFas, xOpi, xPesa e xNensi NAO constam do schema,
* sao cursores LOCAIS do form pai. Nenhum "Insert Into" / "Delete From" do
* legado tem tabela por destino, logo escrever INSERT/DELETE aqui seria
* inventar a lista de colunas, o que a regra #22 proibe. Para esses dois o
* comportamento herdado de BusinessBase (recusar a operacao e reportar
* pelo ExibirFalha do Salvar) ja eh o correto - mesma decisao de projeto
* documentada em SigOpLrCBO/SigOpGrcBO.
*
* ThisForm.ParentForm.Amarra do legado (contador que numera cada item de
* fase gravado em xOpi/xPesa, somado 1 a cada LocalOpi.Scan dentro de
* Marca()) vive no form PAI no legado, porque sobrevive a varias chamadas
* de Marca() para pendencias diferentes na mesma abertura do dialogo. Na
* arquitetura nova o BO nao referencia form (PILAR 3): o contador fica em
* this_nAmarra, de responsabilidade deste BO; se o fluxo do form pai
* precisar dele entre aberturas do dialogo, quem chama le/grava onde for
* preciso.
*
* crSigCdPam (SigCdPam, tabela de 1 linha) - Marca() le DIRETO
* crSigCdPam.CuniPPads (unidade padrao, char(3)) e crSigCdPam.Ouros
* (produto "ouro" default, char(14)), sem CursorQuery proprio. Regra do
* projeto: cursor global Fortyus tem de ser POPULADO no Init do BO, nunca
* pressuposto - ver bloco em Init() (padrao canonico de ClienteBO.prg).
*
* O "Load" legado ("=fConfigGeral()") nao gera metodo neste BO: era
* inicializacao GLOBAL da aplicacao Fortyus, e na arquitetura nova isso ja
* acontece antes (config.prg/main.prg/cada BO com seus cursores) - mesma
* decisao documentada em SigOpGrcBO.prg.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpMpdBO AS BusinessBase

    *==========================================================================
    * CURSORES DO FORM PAI (fornecidos por quem abre este dialogo - este BO
    * NAO os cria, so os consulta/atualiza pelo NOME)
    *==========================================================================

    *-- TmpNens: linha de NECESSIDADE (SigCdNec) corrente do form pai
    this_cCursorNens = ""

    *-- TmpOperacao: codigos (NumNivel) de pendencia ja usados/selecionados
    this_cCursorOperacao = ""

    *-- xMFas/xOpi/xPesa/xNensi: cursores de SAIDA do form pai, gravados por
    *-- Marcar() e limpos por Desmarcar()
    this_cCursorMFas  = ""
    this_cCursorOpi   = ""
    this_cCursorPesa  = ""
    this_cCursorNensi = ""

    *==========================================================================
    * CURSOR PROPRIO - grade de selecao (Create Cursor TmpPends do Init
    * legado)
    *==========================================================================
    this_cCursorPends = ""

    *-- Linha corrente de TmpPends (Flag l, Emps c(3), Dopes c(20),
    *-- Numes n(10), Datas t Null, Origem c(21), Destino c(21), CPros c(14))
    this_lFlag    = .F.
    this_cEmps    = ""
    this_cDopes   = ""
    this_nNumes   = 0
    this_dDatas   = {}
    this_cOrigem  = ""
    this_cDestino = ""
    this_cCPros   = ""

    *==========================================================================
    * CONTADOR DE AMARRACAO - equivalente a ThisForm.ParentForm.Amarra do
    * legado (regra #comentario no cabecalho acima)
    *==========================================================================
    this_nAmarra = 0

    *==========================================================================
    * ALIAS DO CURSOR GLOBAL DE PARAMETROS (SigCdPam, tabela de 1 linha) -
    * Marcar() le CuniPPads/Ouros direto deste cursor
    *==========================================================================
    this_cCursorParametros = ""

    *-- Cursor de trabalho (SigCdCli) usado por MarcarExec() so para
    *-- recalcular this_cOrigemContaDescricao/this_cDestinoContaDescricao/
    *-- this_cRespContaDescricao (legado: CrTmpCli)
    this_cCursorCliente = ""

    *==========================================================================
    * PAR (chave, valor) do proximo UPDATE em SigCdNec.ChkSubn - os dois
    * argumentos de Atualizar(), que eh o UNICO ponto deste BO que grava no
    * SQL Server. Marcar()/Desmarcar() varrem o cursor de chaves do "nivel"
    * e, para CADA linha, setam este par e chamam THIS.Atualizar() - que
    * tambem eh quem chama RegistrarAuditoria(), por isso
    * ObterChavePrimaria() devolve this_cCidChavesAtual.
    *
    * this_cCidChavesAtual -> SigCdNec.CidChaves (char(20), PK Fortyus)
    * this_lChkSubn        -> SigCdNec.ChkSubn   (bit): .T. no Marcar
    *                         (legado ?pTru), .F. no Desmarcar (?pNot)
    *==========================================================================
    this_cCidChavesAtual = ""
    this_lChkSubn        = .F.

    *==========================================================================
    * SUGESTOES calculadas por Marcar() para os campos Origem/Destino/
    * Responsavel do FORM PAI (legado: ThisForm.ParentForm.Pagina.Dados.
    * Origem/Destino/Responsavel.Get_Grupo/Get_Conta.Value). A atribuicao ao
    * controle de UI eh responsabilidade da camada de Form (BO nao
    * referencia Form - PILAR 3): aqui fica so o par
    * (precisa-atualizar?, valor-calculado), na MESMA condicao do legado
    * (Empty(TmpNens.<campo>) ...).
    *==========================================================================
    this_lAtualizarOrigemGrupo   = .F.
    this_cOrigemGrupoCalculado   = ""
    this_lAtualizarOrigemConta   = .F.
    this_cOrigemContaCalculada   = ""
    this_lAtualizarDestinoGrupo  = .F.
    this_cDestinoGrupoCalculado  = ""
    this_lAtualizarDestinoConta  = .F.
    this_cDestinoContaCalculada  = ""
    this_lAtualizarRespGrupo     = .F.
    this_cRespGrupoCalculado     = ""
    this_lAtualizarRespConta     = .F.
    this_cRespContaCalculada     = ""

    *-- Descricoes de conta (legado: Get_dconta.Value) recalculadas ao fim
    *-- de Marcar() - o legado sempre reatribui as tres, mesmo vazias
    this_cOrigemContaDescricao  = ""
    this_cDestinoContaDescricao = ""
    this_cRespContaDescricao    = ""

    *-- legado: ThisForm.ParentForm.EditaOrigem - recalculado por
    *-- Desmarcar(); a atribuicao ao form pai fica para a camada de Form
    this_lPermiteEditarOrigem = .T.

    *-- legado: ThisForm.ParentForm.Amarra (contador acumulado por Marcar())
    *-- ja declarado acima como this_nAmarra

    *==========================================================================
    * Init - Define this_cTabela/this_cCampoChave (ver nota no cabecalho
    * sobre o alvo de escrita SigCdNec/CidChaves), os nomes canonicos dos
    * cursores desta tela, zera a linha corrente de TmpPends e garante o
    * cursor global crSigCdPam (CuniPPads/Ouros), que Marcar() vai precisar.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_oErroPam, loc_nResult
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Tabela/campo chave do UPDATE de Atualizar() e da auditoria
            *-- via ObterChavePrimaria - ver nota no cabecalho: SigCdNec.
            *-- ChkSubn eh o unico alvo de escrita, e o lote fica em
            *-- Marcar()/Desmarcar().
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "CidChaves"

            *-- Nomes canonicos dos cursores do form pai
            THIS.this_cCursorNens     = "TmpNens"
            THIS.this_cCursorOperacao = "TmpOperacao"
            THIS.this_cCursorMFas     = "xMFas"
            THIS.this_cCursorOpi      = "xOpi"
            THIS.this_cCursorPesa     = "xPesa"
            THIS.this_cCursorNensi    = "xNensi"

            *-- Cursor proprio (grade de selecao)
            THIS.this_cCursorPends = "TmpPends"

            *-- Cursor global de parametros
            THIS.this_cCursorParametros = "crSigCdPam"

            *-- Cursor de trabalho para MarcarExec() (descricoes de conta)
            THIS.this_cCursorCliente = "cursor_4c_LocalCli"

            *-- Linha corrente de TmpPends comeca vazia
            THIS.this_lFlag    = .F.
            THIS.this_cEmps    = ""
            THIS.this_cDopes   = ""
            THIS.this_nNumes   = 0
            THIS.this_dDatas   = {}
            THIS.this_cOrigem  = ""
            THIS.this_cDestino = ""
            THIS.this_cCPros   = ""

            THIS.this_nAmarra = 0

            *-- Popular crSigCdPam com CuniPPads/Ouros. Padrao canonico de
            *-- ClienteBO.prg (regra do projeto: cursor global Fortyus tem
            *-- de ser garantido no Init do BO, nunca pressuposto). Sem
            *-- isto, o primeiro Marcar() estouraria "Alias CRSIGCDPAM is
            *-- not found" ao ler crSigCdPam.CuniPPads/crSigCdPam.Ouros.
            TRY
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResult = SQLEXEC(gnConnHandle, "SELECT CuniPPads, Ouros FROM SigCdPam", "cursor_4c_Pam_Temp")
                    IF loc_nResult > 0
                        SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                        IF USED("cursor_4c_Pam_Temp")
                            USE IN cursor_4c_Pam_Temp
                        ENDIF
                        IF RECCOUNT("crSigCdPam") > 0
                            SELECT crSigCdPam
                            GO TOP
                        ENDIF
                    ELSE
                        *-- Fallback: cursor vazio para nao quebrar as
                        *-- checagens downstream (modo teste/SQL indisponivel)
                        CREATE CURSOR crSigCdPam (CuniPPads C(3), Ouros C(14))
                        APPEND BLANK
                    ENDIF
                ELSE
                    *-- Modo teste (gnConnHandle nao inicializado)
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), Ouros C(14))
                    APPEND BLANK
                ENDIF
            CATCH TO loc_oErroPam
                IF !USED("crSigCdPam")
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), Ouros C(14))
                    APPEND BLANK
                ENDIF
            ENDTRY

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - sobrescreve BusinessBase (PROTECTED, so chamado
    * de dentro da classe - regra #51). Nao ha registro "corrente" de
    * SigCdNec como nos BOs CRUD: cada Update de Marcar()/Desmarcar() seta
    * this_cCidChavesAtual IMEDIATAMENTE antes de chamar RegistrarAuditoria.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChavesAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - sobrescreve BusinessBase (PUBLIC na base, logo PUBLIC
    * aqui tambem - regra #51: metodo que o Form chama de fora nunca pode ser
    * PROTECTED em nenhum nivel da heranca).
    *
    * Le a linha CORRENTE da grade de selecao (TmpPends, criado por
    * CarregarPendencias) para as propriedades this_lFlag/this_cEmps/
    * this_cDopes/this_nNumes/this_dDatas/this_cOrigem/this_cDestino/
    * this_cCPros. Equivale ao que o legado faz lendo TmpPends.<campo> direto
    * dentro de marca/desmarca (o dialogo opera SEMPRE sobre a linha em que a
    * grade esta posicionada): aqui o par (grade -> propriedades) fica num
    * ponto unico, e Marcar()/Desmarcar() nao precisam reler o cursor.
    *
    * Sem par_cAliasCursor assume this_cCursorPends, que eh o caso de uso
    * normal; o parametro existe porque a assinatura da base o tem e porque o
    * Form pode querer ler outro cursor de MESMA estrutura.
    *
    * `Datas` eh datetime NULL no cursor (e em SigCdNec) e a propriedade
    * nasce DATE: a leitura passa por ConverterParaData(), NUNCA por TTOD()
    * direto (regra #16 - TTOD com DATE dispara o erro 11 em runtime, e
    * ConverterParaData devolve {} para .NULL.).
    *
    * Guarda de EOF/BOF/RECCOUNT obrigatoria: cursor vazio ou posicionado no
    * fim leria campo inexistente. Devolve .F. nesse caso, SEM mexer nas
    * propriedades, para o chamador distinguir "nao ha linha" de "linha em
    * branco". Preserva a area de trabalho corrente - este dialogo roda na
    * data session do form PAI, que tem varios cursores abertos.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior

        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            ALLTRIM(par_cAliasCursor), THIS.this_cCursorPends)

        IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            loc_cAliasAnterior = ALIAS()

            SELECT (loc_cAlias)

            IF RECCOUNT() > 0 AND !EOF() AND !BOF()
                THIS.this_lFlag    = ConverterParaLogico(Flag)
                THIS.this_cEmps    = TratarNulo(Emps, "")
                THIS.this_cDopes   = TratarNulo(Dopes, "")
                THIS.this_nNumes   = TratarNulo(Numes, 0)
                THIS.this_dDatas   = ConverterParaData(Datas)
                THIS.this_cOrigem  = TratarNulo(Origem, "")
                THIS.this_cDestino = TratarNulo(Destino, "")
                THIS.this_cCPros   = TratarNulo(CPros, "")

                loc_lSucesso = .T.
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Cursor da grade de sele" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - sobrescreve BusinessBase (PUBLIC na base, logo PUBLIC aqui -
    * regra #51). UNICO ponto deste BO que grava no SQL Server.
    *
    * Legado (identico em marca e em desmarca, so muda o valor):
    *   lcQuery = [Update SigCdNec Set ChkSubn = ?pTru Where CidChaves = '] + ;
    *             LocalNens.CidChaves + [']
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * O legado grava em LOTE (Scan sobre as linhas de SigCdNec que compartilham
    * o EmpDNps do "nivel"), mas CADA volta do Scan eh um UPDATE de UMA linha
    * pela PK - que eh exatamente o contrato de Atualizar(). Por isso o lote
    * fica em Marcar()/Desmarcar() (que varrem o cursor de chaves) e o UPDATE
    * de uma linha fica aqui, num ponto unico, com a auditoria.
    *
    * ChkSubn eh `bit NOT NULL` no schema, por isso o literal 1/0 (nao .T./.F.,
    * que o ODBC nao aceita em SQL concatenado).
    *
    * NAO existe Inserir() correspondente: medido contra docs/schema.sql, dos
    * alvos de escrita do dump legado so SigCdNec eh TABELA - TmpOperacao,
    * xMFas, xOpi, xPesa e xNensi nao constam das 682 tabelas, sao cursores
    * LOCAIS do form pai (este dialogo roda na data session dele). Nenhum
    * `Insert Into` do legado tem tabela por destino, logo escrever um INSERT
    * aqui significaria inventar a lista de colunas, o que a regra #22 proibe
    * (a lista vem do schema, nunca de adivinhacao). O comportamento herdado
    * de BusinessBase (recusar a operacao e reportar pelo ExibirFalha do
    * Salvar) ja eh o correto.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        *-- TRY aqui (e nao so no wrapper de Marcar/Desmarcar) porque este
        *-- metodo eh PUBLIC: handle de conexao invalido faz o SQLEXEC
        *-- disparar EXCECAO em vez de devolver -1, e sem TRY um chamador de
        *-- fora veria o Program Error cru do VFP. Nao ha RETURN dentro do
        *-- TRY (regra #1): o corpo todo eh IF/ELSE sobre loc_lSucesso.
        TRY
            IF EMPTY(THIS.this_cCidChavesAtual)
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado: " + ;
                    "nenhum registro de SigCdNec para atualizar."
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- ChkSubn eh bit: literal 1/0. ConverterParaLogico garante o
                *-- LOGICO que o IIF exige - se um chamador futuro atribuir
                *-- 1/0 (numerico) a this_lChkSubn, IIF(numerico,...) estouraria
                *-- o erro 11 do VFP9 em runtime.
                loc_cSQL = "UPDATE SigCdNec SET ChkSubn = " + ;
                    IIF(ConverterParaLogico(THIS.this_lChkSubn), "1", "0") + ;
                    " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChavesAtual)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (Update - SigCdNec)" + CHR(13) + ;
                        CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar SigCdNec:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarCursorQuery - equivalente generico ao ThisForm.poDataMgr.
    * CursorQuery(cTabela, cCursorDestino, cCampoFiltro, uValorFiltro,
    * cListaCampos) do framework legado Fortyus: SELECT <campos ou *> FROM
    * <tabela> WHERE <campo> = <valor> INTO CURSOR <destino>, posicionado
    * no primeiro registro. uValorFiltro pode ser Character ou Numeric -
    * o tipo decide o escape (EscaparSQL/FormatarNumeroSQL).
    *
    * Fecha e RECRIA par_cCursor a cada chamada (mesma semantica do
    * CursorQuery legado - cada chamada eh uma consulta NOVA, nao um SEEK
    * num cursor ja aberto).
    *==========================================================================
    PROTECTED PROCEDURE ExecutarCursorQuery(par_cTabela, par_cCursor, par_cCampo, par_uValor, par_cCampos)
        LOCAL loc_cSQL, loc_nResultado, loc_cCamposSQL, loc_cFiltro

        loc_cCamposSQL = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        DO CASE
        CASE VARTYPE(par_uValor) = "N"
            loc_cFiltro = FormatarNumeroSQL(par_uValor, 0)
        OTHERWISE
            loc_cFiltro = EscaparSQL(par_uValor)
        ENDCASE

        loc_cSQL = "SELECT " + loc_cCamposSQL + " FROM " + par_cTabela + ;
            " WHERE " + par_cCampo + " = " + loc_cFiltro

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor)

        IF loc_nResultado > 0 AND USED(par_cCursor)
            SELECT (par_cCursor)
            GO TOP
        ENDIF

        RETURN loc_nResultado > 0
    ENDPROC

    *==========================================================================
    * CarregarPendencias - legado: bloco de montagem da grade dentro do
    * PROCEDURE Init do dialogo (linhas 920-1008 do fonte extraido), SEM a
    * parte de UI (RecordSource/ControlSource do Grid, SetFocus, Refresh -
    * isso fica para a camada de Form, chamada DEPOIS deste metodo).
    *
    * Le o registro CORRENTE de TmpNens (this_cCursorNens) e de
    * TmpOperacao (this_cCursorOperacao) - o form PAI posiciona essas
    * cursores ANTES de abrir este dialogo, no lugar de pForm/pData/pCnx
    * do Init legado. (Re)cria TmpPends (this_cCursorPends) do zero a cada
    * chamada - mesma semantica do "Create Cursor TmpPends(...)" do
    * legado, que roda 1x por abertura do dialogo.
    *==========================================================================
    PROCEDURE CarregarPendencias()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.CarregarPendenciasExec()
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = "Erro ao carregar pend" + CHR(234) + "ncias:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPendenciasExec - corpo de CarregarPendencias(). Existe separado
    * porque as 5 guardas de conexao/cursor abortam o metodo no meio, e em
    * VFP9 eh PROIBIDO dar RETURN de dentro de um TRY/CATCH (regra #1 do
    * CLAUDE.md): com as guardas aqui, o TRY fica todo no wrapper acima.
    * Mesmo par wrapper/Exec ja usado por Marcar()/MarcarExec() e
    * Desmarcar()/DesmarcarExec() neste BO.
    *==========================================================================
    PROTECTED PROCEDURE CarregarPendenciasExec()
        LOCAL loc_cAliasNens, loc_cAliasOperacao, loc_cAliasPends
        LOCAL loc_cNensEmps, loc_cNensDopps, loc_cNensContaOs, loc_cNensContaDs
        LOCAL loc_cNivel, loc_nNumNivel, loc_cEd1, loc_cEd2, loc_cSQL, loc_nResultado
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_cOrigem, loc_cDestino, loc_lFlagMarcada

        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasPends    = THIS.this_cCursorPends

        IF !USED(loc_cAliasNens) OR !USED(loc_cAliasOperacao)
            THIS.this_cMensagemErro = "Cursores do formul" + CHR(225) + "rio chamador " + ;
                "(TmpNens/TmpOperacao) n" + CHR(227) + "o est" + CHR(227) + "o abertos."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasNens)
        loc_cNensEmps    = Emps
        loc_cNensDopps   = Dopps
        loc_cNensContaOs = ContaOs
        loc_cNensContaDs = ContaDs

        *-- legado: Create Cursor TmpPends(...) - mesma estrutura/ordem
        *-- documentada no cabecalho do BO (regra #42)
        IF USED(loc_cAliasPends)
            USE IN (loc_cAliasPends)
        ENDIF
        CREATE CURSOR (loc_cAliasPends) (Flag L, Emps C(3), Dopes C(20), Numes N(10), ;
            Datas T NULL, Origem C(21), Destino C(21), CPros C(14))
        INDEX ON Emps + Dopes + STR(Numes, 10) TAG EmpDopNum
        INDEX ON Numes TAG Numes

        *-- legado: Select TmpOperacao / Delete All For Empty(Codigos)
        SELECT (loc_cAliasOperacao)
        DELETE ALL FOR EMPTY(Codigos)

        *-- 1a volta: acha o Nivels da operacao corrente do form pai
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cNensDopps, "Nivels")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- 2a volta: usa o Nivels encontrado como NOVO filtro Dopps - eh
        *-- o registro de SigCdOpd que representa o "nivel" da operacao.
        *-- TNivels/Artigos tambem vem aqui no legado, mas sao dead code
        *-- dentro do Init - Marcar() calcula os PROPRIOS Titulo/Artigo a
        *-- partir do Dopes da pendencia, nao do TmpNens.
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", ;
                cursor_4c_LocalOpp.Nivels, "Dopps, NDopps, TNivels, Artigos")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cNivel    = cursor_4c_LocalOpp.Dopps
        loc_nNumNivel = cursor_4c_LocalOpp.NDopps

        *-- Lado (Origem/Destino) que a operacao "puxa" automaticamente.
        *-- BxAutos tambem vem aqui no legado, mas eh dead code dentro do
        *-- Init - so Marcar() usa BxAutos, com sua PROPRIA consulta.
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cNensDopps, ;
                "ConOSubs, ConDSubs, BxAutos")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF
        loc_nPuxaOrigem  = cursor_4c_LocalOpp.ConOSubs
        loc_nPuxaDestino = cursor_4c_LocalOpp.ConDSubs

        *-- Chave POSICIONAL (regra #42): PADR explicito, NUNCA ALLTRIM
        loc_cEd1 = PADR(loc_cNensEmps, 3) + PADR(loc_cNivel, 20) + STR(0, 10)
        loc_cEd2 = PADR(loc_cNensEmps, 3) + PADR(loc_cNivel, 20) + STR(9999999999, 10)

        WAIT WINDOW "Aguarde!!! Selecionando Opera" + CHR(231) + CHR(227) + "o Pendentes..." NOWAIT

        loc_cSQL = "SELECT Emps, Dopps, Numps, Datas, ChkSubn FROM SigCdNec " + ;
            "WHERE EmpDNps BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2)

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens")

        IF loc_nResultado < 1
            WAIT CLEAR
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_LocalNens
        SCAN
            IF ConverterParaLogico(cursor_4c_LocalNens.ChkSubn) AND ;
                    !SEEK(loc_nNumNivel * 10000000000 + cursor_4c_LocalNens.Numps, loc_cAliasOperacao, "Codigos")
                LOOP
            ENDIF

            IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_LocalMFas", "EmpDNps", ;
                    PADR(loc_cNensEmps, 3) + PADR(loc_cNivel, 20) + STR(cursor_4c_LocalNens.Numps, 10), "Nops")
                SELECT cursor_4c_LocalNens
                LOOP
            ENDIF

            IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_LocalMFas", "Nops", cursor_4c_LocalMFas.Nops, ;
                    "Nops, GrupoOs, ContaOs, GrupoDs, ContaDs, CodPds")
                SELECT cursor_4c_LocalNens
                LOOP
            ENDIF

            SELECT cursor_4c_LocalMFas
            INDEX ON Nops TAG Nops
            SET ORDER TO Nops DESCENDING

            DO CASE
            CASE INLIST(loc_nPuxaOrigem, 1, 2)
                IF loc_nPuxaOrigem = 1
                    IF !EMPTY(loc_cNensContaOs) AND loc_cNensContaOs != cursor_4c_LocalMFas.ContaOs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cOrigem = ALLTRIM(cursor_4c_LocalMFas.GrupoOs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaOs)
                ELSE
                    IF !EMPTY(loc_cNensContaOs) AND loc_cNensContaOs != cursor_4c_LocalMFas.ContaDs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cOrigem = ALLTRIM(cursor_4c_LocalMFas.GrupoDs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaDs)
                ENDIF
            OTHERWISE
                loc_cOrigem = ALLTRIM(cursor_4c_LocalMFas.GrupoOs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaOs)
            ENDCASE

            DO CASE
            CASE INLIST(loc_nPuxaDestino, 1, 2)
                IF loc_nPuxaDestino = 1
                    IF !EMPTY(loc_cNensContaDs) AND loc_cNensContaDs != cursor_4c_LocalMFas.ContaOs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cDestino = ALLTRIM(cursor_4c_LocalMFas.GrupoOs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaOs)
                ELSE
                    IF !EMPTY(loc_cNensContaDs) AND loc_cNensContaDs != cursor_4c_LocalMFas.ContaDs
                        SELECT cursor_4c_LocalNens
                        LOOP
                    ENDIF
                    loc_cDestino = ALLTRIM(cursor_4c_LocalMFas.GrupoDs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaDs)
                ENDIF
            OTHERWISE
                loc_cDestino = ALLTRIM(cursor_4c_LocalMFas.GrupoDs) + "/" + ALLTRIM(cursor_4c_LocalMFas.ContaDs)
            ENDCASE

            loc_lFlagMarcada = SEEK(loc_nNumNivel * 10000000000 + cursor_4c_LocalNens.Numps, ;
                loc_cAliasOperacao, "Codigos")

            INSERT INTO (loc_cAliasPends) (Flag, Emps, Dopes, Numes, Datas, Origem, Destino, CPros) ;
                VALUES (loc_lFlagMarcada, cursor_4c_LocalNens.Emps, cursor_4c_LocalNens.Dopps, ;
                    cursor_4c_LocalNens.Numps, cursor_4c_LocalNens.Datas, loc_cOrigem, loc_cDestino, ;
                    cursor_4c_LocalMFas.CodPds)

            SELECT cursor_4c_LocalNens
        ENDSCAN

        WAIT CLEAR

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        IF USED("cursor_4c_LocalMFas")
            USE IN cursor_4c_LocalMFas
        ENDIF
        IF USED("cursor_4c_LocalOpp")
            USE IN cursor_4c_LocalOpp
        ENDIF

        SELECT (loc_cAliasPends)
        GO TOP

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Marcar - legado: PROCEDURE marca(_Automatico). Chamado pelo
    * InteractiveChange do fwcheckbox1 da grade (This.Value = ThisForm.
    * Marca()) e por SELTUDO.Click (ThisForm.Marca(.t.)). O corpo real fica
    * em MarcarExec() (regra #47 - RETURN livre fora de TRY); este metodo
    * so eh o wrapper que cerca a execucao com TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE Marcar(par_lAutomatico)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.MarcarExec(par_lAutomatico)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao marcar pend" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarExec - corpo de Marcar(), fora do TRY de Marcar() (regra #47).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MarcarExec(par_lAutomatico)
        LOCAL loc_lAutomatico, loc_cAliasPends, loc_cAliasNens, loc_cAliasOperacao
        LOCAL loc_cAliasMFas, loc_cAliasCli
        LOCAL loc_cPendEmps, loc_cPendDopes, loc_nPendNumes
        LOCAL loc_cNivel, loc_nNumNivel, loc_cTitulo, loc_cArtigo
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_lBaixaSubnivel, loc_cOperacao, loc_lRetorna
        LOCAL loc_cNensEmps, loc_cNensDopps, loc_nNensNumps
        LOCAL loc_cNensGrupoOs, loc_cNensContaOs, loc_cNensGrupoDs, loc_cNensContaDs
        LOCAL loc_cNensGrVends, loc_cNensVends
        LOCAL loc_lNecessidadeChkSubn, loc_cNecessidadeGrVends, loc_cNecessidadeVends
        LOCAL loc_nNops

        loc_lAutomatico = TratarNulo(par_lAutomatico, .F.)

        loc_cAliasPends    = THIS.this_cCursorPends
        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasMFas     = THIS.this_cCursorMFas
        loc_cAliasCli      = THIS.this_cCursorCliente

        IF !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursor de pend" + CHR(234) + "ncias n" + CHR(227) + "o est" + CHR(225) + ;
                " aberto."
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasPends)
        loc_cPendEmps  = Emps
        loc_cPendDopes = Dopes
        loc_nPendNumes = Numes

        *-- legado: CursorQuery('SigCdOpd','LocalOpp','Dopps',TmpPends.Dopes,
        *-- 'Dopps, NDopps, TNivels, Artigos')
        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cPendDopes, ;
                "Dopps, NDopps, TNivels, Artigos")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            RETURN .F.
        ENDIF

        loc_cNivel  = cursor_4c_LocalOpp.Dopps
        loc_cTitulo = cursor_4c_LocalOpp.TNivels
        loc_cArtigo = cursor_4c_LocalOpp.Artigos

        *-- legado: _NumNivel = Val(Str(LocalOpp.Ndopps, 2) + Transform(
        *-- TmpPends.Numes, '@L 9999999999')) - formula de negocio,
        *-- TRANSCRITA literal (regra #17)
        loc_nNumNivel = VAL(STR(cursor_4c_LocalOpp.NDopps, 2) + TRANSFORM(loc_nPendNumes, "@L 9999999999"))

        *-- legado: If Seek(_NumNivel, 'TmpOperacao', 'Codigos') ... Return .f.
        IF SEEK(loc_nNumNivel, loc_cAliasOperacao, "Codigos")
            IF !loc_lAutomatico
                MsgAviso(ALLTRIM(loc_cTitulo) + " J" + CHR(225) + " Digitad" + ALLTRIM(loc_cArtigo) + "!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            RETURN .F.
        ENDIF

        *-- legado: lcCpo = 'ConOSubs, ConDSubs, BxAutos, FixGOrigs, Nivels'
        *-- CursorQuery('SigCdOpd','LocalOpp','Dopps',TmpNens.Dopps,lcCpo)
        IF !USED(loc_cAliasNens)
            THIS.this_cMensagemErro = "Cursor TmpNens do formul" + CHR(225) + "rio chamador n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasNens)
        loc_cNensEmps    = Emps
        loc_cNensDopps   = Dopps
        loc_nNensNumps   = Numps
        loc_cNensGrupoOs = GrupoOs
        loc_cNensContaOs = ContaOs
        loc_cNensGrupoDs = GrupoDs
        loc_cNensContaDs = ContaDs
        loc_cNensGrVends = GrVends
        loc_cNensVends   = Vends

        IF !THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpp", "Dopps", loc_cNensDopps, ;
                "ConOSubs, ConDSubs, BxAutos, FixGOrigs, Nivels")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpp)"
            RETURN .F.
        ENDIF

        loc_nPuxaOrigem    = cursor_4c_LocalOpp.ConOSubs
        loc_nPuxaDestino   = cursor_4c_LocalOpp.ConDSubs
        loc_lBaixaSubnivel = (cursor_4c_LocalOpp.BxAutos = 1)

        *-- legado: _Operacao = Str(TmpPends.Numes, 10) - chave POSICIONAL
        *-- (regra #42), NUNCA ALLTRIM
        loc_cOperacao = STR(loc_nPendNumes, 10)

        *-- legado: CursorQuery('SigCdNec','LocalNens','EmpDNps',_Nivel)
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_LocalNens", "EmpDNps", ;
                PADR(loc_cPendEmps, 3) + PADR(loc_cNivel, 20) + STR(loc_nPendNumes, 10))
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            RETURN .F.
        ENDIF
        loc_lNecessidadeChkSubn = ConverterParaLogico(cursor_4c_LocalNens.ChkSubn)
        loc_cNecessidadeGrVends = cursor_4c_LocalNens.GrVends
        loc_cNecessidadeVends   = cursor_4c_LocalNens.Vends

        *-- legado: CursorQuery('SigPdMvf','LocalMFas','EmpDNps',_Nivel)
        IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_LocalMFas", "EmpDNps", ;
                PADR(loc_cPendEmps, 3) + PADR(loc_cNivel, 20) + STR(loc_nPendNumes, 10))
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalMFas)"
            RETURN .F.
        ENDIF

        *-- legado: _Retorna = .t. / If LocalNens.ChkSubn ... _Retorna = .f.
        *-- / If Not _Retorna / Return .f.
        loc_lRetorna = .T.
        IF loc_lNecessidadeChkSubn
            IF !loc_lAutomatico
                MsgAviso(ALLTRIM(loc_cTitulo) + " J" + CHR(225) + " Utilizad" + ALLTRIM(loc_cArtigo) + ;
                    " Em Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            loc_lRetorna = .F.
        ENDIF

        IF !loc_lRetorna
            RETURN .F.
        ENDIF

        *-- legado: Select TmpOperacao / Insert Into TmpOperacao (Codigos)
        *-- Values (_NumNivel)
        INSERT INTO (loc_cAliasOperacao) (Codigos) VALUES (loc_nNumNivel)

        *-- legado: Select LocalMFas / Scan ... EndScan - uma iteracao por
        *-- FASE/Nops da pendencia marcada
        SELECT cursor_4c_LocalMFas
        SCAN
            loc_nNops = cursor_4c_LocalMFas.Nops

            IF !THIS.ProcessarFaseDaMarcacao(loc_nNops, loc_nPuxaOrigem, loc_nPuxaDestino, ;
                    loc_lBaixaSubnivel, loc_cOperacao, ;
                    loc_cNensEmps, loc_cNensDopps, loc_nNensNumps, ;
                    loc_cNensGrupoOs, loc_cNensContaOs, loc_cNensGrupoDs, loc_cNensContaDs, ;
                    loc_cNensGrVends, loc_cNensVends, ;
                    loc_cNecessidadeGrVends, loc_cNecessidadeVends, loc_nPendNumes)
                RETURN .F.
            ENDIF

            SELECT cursor_4c_LocalMFas
        ENDSCAN

        *-- legado: With ThisForm.ParentForm.Pagina.Dados ... EndWith -
        *-- recalcula as descricoes (Get_dconta) de Origem/Destino/
        *-- Responsavel a partir do TmpNens atual. So o VALOR fica aqui; a
        *-- atribuicao ao controle de UI eh da camada de Form (PILAR 3).
        IF THIS.ExecutarCursorQuery("SigCdCli", loc_cAliasCli, "IClis", loc_cNensContaOs, "RClis")
            THIS.this_cOrigemContaDescricao = ALLTRIM(EVALUATE(loc_cAliasCli + ".RClis"))
        ELSE
            THIS.this_cOrigemContaDescricao = ""
        ENDIF

        IF THIS.ExecutarCursorQuery("SigCdCli", loc_cAliasCli, "IClis", loc_cNensContaDs, "RClis")
            THIS.this_cDestinoContaDescricao = ALLTRIM(EVALUATE(loc_cAliasCli + ".RClis"))
        ELSE
            THIS.this_cDestinoContaDescricao = ""
        ENDIF

        IF THIS.ExecutarCursorQuery("SigCdCli", loc_cAliasCli, "IClis", loc_cNensVends, "RClis")
            THIS.this_cRespContaDescricao = ALLTRIM(EVALUATE(loc_cAliasCli + ".RClis"))
        ELSE
            THIS.this_cRespContaDescricao = ""
        ENDIF

        IF USED(loc_cAliasCli)
            USE IN (loc_cAliasCli)
        ENDIF
        IF USED("cursor_4c_LocalOpp")
            USE IN cursor_4c_LocalOpp
        ENDIF
        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        IF USED("cursor_4c_LocalMFas")
            USE IN cursor_4c_LocalMFas
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarFaseDaMarcacao - corpo do "Select LocalMFas / Scan" de
    * MarcarExec: para UMA fase (Nops) da pendencia, sugere Grupo/Conta de
    * Origem/Destino/Responsavel, da baixa automatica de subnivel, gera as
    * linhas de xOpi/xPesa/xMFas/xNensi (legado: linhas 711-872 do fonte
    * extraido). Chamado de dentro do SCAN de MarcarExec - RETURN livre
    * aqui tambem, porque quem tem o TRY eh Marcar(), nao este metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarFaseDaMarcacao(par_nNops, par_nPuxaOrigem, par_nPuxaDestino, ;
            par_lBaixaSubnivel, par_cOperacao, ;
            par_cNensEmps, par_cNensDopps, par_nNensNumps, ;
            par_cNensGrupoOs, par_cNensContaOs, par_cNensGrupoDs, par_cNensContaDs, ;
            par_cNensGrVends, par_cNensVends, ;
            par_cNecessidadeGrVends, par_cNecessidadeVends, par_nPendNumes)

        LOCAL loc_cAliasOpi, loc_cAliasPesa, loc_cAliasMFasParent, loc_cAliasNensi, loc_cAliasParam
        LOCAL loc_cChaveBaixa, loc_cSQL, loc_cChaveOrig, loc_nTotalNop, loc_cMatP
        LOCAL loc_nQtAnt, loc_nPsAnt

        loc_cAliasOpi         = THIS.this_cCursorOpi
        loc_cAliasPesa        = THIS.this_cCursorPesa
        loc_cAliasMFasParent  = THIS.this_cCursorMFas
        loc_cAliasNensi       = THIS.this_cCursorNensi
        loc_cAliasParam       = THIS.this_cCursorParametros

        *-- legado: CursorQuery('SigPdMvf','TempMFas','Nops',_Nops) / Index
        *-- On Nops Tag Nops / Set Order to Nops Descending / Seek _Nops
        IF !THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_TempMFas", "Nops", par_nNops)
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (TempMFas)"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_TempMFas
        INDEX ON Nops TAG Nops
        SET ORDER TO Nops DESCENDING
        SEEK par_nNops

        *-- legado: If InList(_PuxaOrigem, 1, 2) ... sugestao de Grupo/Conta
        *-- de Origem (so o VALOR - a atribuicao ao controle fica para o Form)
        IF INLIST(par_nPuxaOrigem, 1, 2)
            IF EMPTY(par_cNensGrupoOs) OR (EMPTY(par_cNensContaOs) AND !cursor_4c_LocalOpp.FixGOrigs)
                THIS.this_lAtualizarOrigemGrupo = .T.
                THIS.this_cOrigemGrupoCalculado = IIF(par_nPuxaOrigem = 1, ;
                    cursor_4c_TempMFas.GrupoOs, cursor_4c_TempMFas.GrupoDs)
            ENDIF
            IF EMPTY(par_cNensContaOs)
                THIS.this_lAtualizarOrigemConta = .T.
                THIS.this_cOrigemContaCalculada = IIF(par_nPuxaOrigem = 1, ;
                    cursor_4c_TempMFas.ContaOs, cursor_4c_TempMFas.ContaDs)
            ENDIF
        ENDIF

        IF INLIST(par_nPuxaDestino, 1, 2)
            IF EMPTY(par_cNensGrupoDs)
                THIS.this_lAtualizarDestinoGrupo = .T.
                THIS.this_cDestinoGrupoCalculado = IIF(par_nPuxaDestino = 1, ;
                    cursor_4c_TempMFas.GrupoOs, cursor_4c_TempMFas.GrupoDs)
            ENDIF
            IF EMPTY(par_cNensContaDs)
                THIS.this_lAtualizarDestinoConta = .T.
                THIS.this_cDestinoContaCalculada = IIF(par_nPuxaDestino = 1, ;
                    cursor_4c_TempMFas.ContaOs, cursor_4c_TempMFas.ContaDs)
            ENDIF
        ENDIF

        *-- legado: If _BaixaSubNivel ... Update SigCdNec Set ChkSubn=.t. em
        *-- LOTE para a chave do "nivel" de baixa (regra #22/#42 - chave
        *-- posicional com PADR explicito)
        IF par_lBaixaSubnivel
            loc_cChaveBaixa = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(cursor_4c_LocalOpp.Nivels, 20) + ;
                STR(par_nNops, 10)

            loc_cSQL = "SELECT CidChaves FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cChaveBaixa)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens2") < 1
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conex" + CHR(227) + "o (Marca - Update - SigCdNec)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                RETURN .F.
            ENDIF

            *-- legado: Scan / Update SigCdNec Set ChkSubn = ?pTru Where
            *-- CidChaves = '<cid>' - o UPDATE de UMA linha pela PK (mais a
            *-- auditoria) vive em Atualizar(); aqui fica so o LOTE
            SELECT cursor_4c_LocalNens2
            SCAN
                THIS.this_cCidChavesAtual = cursor_4c_LocalNens2.CidChaves
                THIS.this_lChkSubn        = .T.

                IF !THIS.Atualizar()
                    IF USED("cursor_4c_LocalNens2")
                        USE IN cursor_4c_LocalNens2
                    ENDIF
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_LocalNens2
            ENDSCAN

            IF USED("cursor_4c_LocalNens2")
                USE IN cursor_4c_LocalNens2
            ENDIF
        ENDIF

        *-- legado: CursorQuery('SigOpPic','LocalOpi','Nops',TempMFas.Nops) /
        *-- Select LocalOpi / Scan - gera 1 linha de xOpi + 1 de xPesa por item
        IF THIS.ExecutarCursorQuery("SigOpPic", "cursor_4c_LocalOpi", "Nops", cursor_4c_TempMFas.Nops)
            SELECT cursor_4c_LocalOpi
            SCAN
                THIS.this_nAmarra = THIS.this_nAmarra + 1

                INSERT INTO (loc_cAliasOpi) (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes) ;
                    VALUES (cursor_4c_TempMFas.Nops, ;
                        ALLTRIM(cursor_4c_LocalOpi.Dopes) + "/" + ALLTRIM(STR(cursor_4c_LocalOpi.Numes)), ;
                        cursor_4c_LocalOpi.Qtds, cursor_4c_TempMFas.CodPds, .F., THIS.this_nAmarra, ;
                        cursor_4c_TempMFas.Nenvs, cursor_4c_LocalOpi.Emps, cursor_4c_LocalOpi.Dopes, ;
                        cursor_4c_LocalOpi.Numes)

                INSERT INTO (loc_cAliasPesa) (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops) ;
                    VALUES (EVALUATE(loc_cAliasOpi + ".Oper"), EVALUATE(loc_cAliasOpi + ".CPros"), ;
                        EVALUATE(loc_cAliasOpi + ".Qtds"), 0, THIS.this_nAmarra, cursor_4c_TempMFas.Nenvs, ;
                        cursor_4c_LocalOpi.Emps, cursor_4c_LocalOpi.Dopes, cursor_4c_LocalOpi.Numes, ;
                        cursor_4c_TempMFas.Nops)

                SELECT cursor_4c_LocalOpi
            ENDSCAN

            IF USED("cursor_4c_LocalOpi")
                USE IN cursor_4c_LocalOpi
            ENDIF
        ENDIF

        *-- legado: If Empty(TmpNens.GrVends) ... sugestao de Responsavel
        IF EMPTY(par_cNensGrVends)
            THIS.this_lAtualizarRespGrupo = .T.
            THIS.this_cRespGrupoCalculado = par_cNecessidadeGrVends
        ENDIF
        IF EMPTY(par_cNensVends) AND par_cNensGrVends == par_cNecessidadeGrVends
            THIS.this_lAtualizarRespConta = .T.
            THIS.this_cRespContaCalculada = par_cNecessidadeVends
        ENDIF

        *-- legado: Insert Into xMFas (...)
        INSERT INTO (loc_cAliasMFasParent) (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, ;
                Grupods, Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds, Obsps, Ordems) ;
            VALUES (par_cNensEmps, par_cNensDopps, par_nNensNumps, cursor_4c_LocalMFas.Datars, ;
                cursor_4c_LocalMFas.Datas, gc_4c_UsuarioLogado, cursor_4c_LocalMFas.Opers, par_cNensGrupoOs, ;
                par_cNensContaOs, par_cNensGrupoDs, par_cNensContaDs, cursor_4c_LocalMFas.Nops, par_nPendNumes, ;
                cursor_4c_LocalMFas.Codpds, cursor_4c_LocalMFas.Unids, cursor_4c_LocalMFas.Pesos, ;
                cursor_4c_LocalMFas.Qtds, cursor_4c_LocalMFas.Obsps, cursor_4c_LocalMFas.Ordems)

        IF !THIS.ProcessarNeiDaFase(par_cOperacao, par_cNensEmps, par_cNensDopps, par_nNensNumps, par_nPendNumes)
            RETURN .F.
        ENDIF

        *-- legado: CursorQuery('SigCdPro','LocalPro','CPros',LocalMfas.CodPds,
        *-- 'MatPrincs, Cgrus')
        IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_LocalPro", "CPros", cursor_4c_LocalMFas.CodPds, ;
                "MatPrincs, Cgrus")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalPro)"
            RETURN .F.
        ENDIF

        *-- legado: CursorQuery('SigCdGrp','LocalGru','CGrus',LocalPro.Cgrus,
        *-- [Mercs]) / CursorQuery('SigCdGpr','LocalGgrp','Codigos',
        *-- LocalGru.Mercs,[MatPrincs]) - sem guarda de falha (so afetam o
        *-- fallback de _MatP). legado tinha um "Set Step On" aqui
        *-- (breakpoint de depuracao esquecido no fonte) - OMITIDO DE
        *-- PROPOSITO: abriria o debugger do VFP e travaria qualquer
        *-- execucao desassistida (regra #6/#29).
        THIS.ExecutarCursorQuery("SigCdGrp", "cursor_4c_LocalGru", "CGrus", cursor_4c_LocalPro.Cgrus, "Mercs")

        IF USED("cursor_4c_LocalGru") AND RECCOUNT("cursor_4c_LocalGru") > 0
            THIS.ExecutarCursorQuery("SigCdGpr", "cursor_4c_LocalGgrp", "Codigos", cursor_4c_LocalGru.Mercs, ;
                "MatPrincs")
        ELSE
            IF USED("cursor_4c_LocalGgrp")
                USE IN cursor_4c_LocalGgrp
            ENDIF
        ENDIF

        IF USED("cursor_4c_LocalGgrp") AND RECCOUNT("cursor_4c_LocalGgrp") > 0
            loc_cMatP = IIF(!EMPTY(cursor_4c_LocalPro.MatPrincs), cursor_4c_LocalPro.MatPrincs, ;
                IIF(!EMPTY(cursor_4c_LocalGgrp.MatPrincs), cursor_4c_LocalGgrp.MatPrincs, ;
                    EVALUATE(loc_cAliasParam + ".Ouros")))
        ELSE
            loc_cMatP = IIF(!EMPTY(cursor_4c_LocalPro.MatPrincs), cursor_4c_LocalPro.MatPrincs, ;
                EVALUATE(loc_cAliasParam + ".Ouros"))
        ENDIF

        *-- legado: CursorQuery('SigPrCpo','LocalCompo','CPros',
        *-- LocalMfas.CodPds,'Mats, Qtds, Cats') - zero componentes eh
        *-- estado valido (produto sem formula de componentes), sem guarda
        *-- de falha no legado
        IF !THIS.ExecutarCursorQuery("SigPrCpo", "cursor_4c_LocalCompo", "CPros", cursor_4c_LocalMFas.CodPds, ;
                "Mats, Qtds, Cats")
            RETURN .T.
        ENDIF

        SELECT cursor_4c_LocalCompo
        SCAN
            IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_LocalPro", "CPros", cursor_4c_LocalCompo.Mats, ;
                    "CUnis, CGRus, DPros, Varias")
                SELECT cursor_4c_LocalCompo
                LOOP
            ENDIF

            THIS.ExecutarCursorQuery("SigCdUni", "cursor_4c_LocalUni", "CUnis", cursor_4c_LocalPro.CUnis, "Fators")

            IF cursor_4c_LocalCompo.Mats == loc_cMatP AND cursor_4c_LocalMFas.Pesos != 0
                loc_nQtAnt = cursor_4c_LocalMFas.Pesos
            ELSE
                loc_nQtAnt = cursor_4c_LocalMFas.Qtds * cursor_4c_LocalCompo.Qtds
            ENDIF

            IF !USED("cursor_4c_LocalUni") OR RECCOUNT("cursor_4c_LocalUni") = 0 OR cursor_4c_LocalUni.Fators = 0
                loc_nPsAnt = cursor_4c_LocalMFas.Qtds * cursor_4c_LocalCompo.Qtds * cursor_4c_LocalMFas.Pesos
            ELSE
                loc_nPsAnt = cursor_4c_LocalMFas.Qtds * cursor_4c_LocalCompo.Qtds * cursor_4c_LocalUni.Fators
            ENDIF

            INSERT INTO (loc_cAliasNensi) (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
                    QtFaseAnt, PsFaseAnt, Visivel, Rateio, FlagIncs, Cats, Qtds, Pesos) ;
                VALUES (par_cNensEmps, par_cNensDopps, par_nNensNumps, cursor_4c_LocalMFas.Nops, par_nPendNumes, ;
                    cursor_4c_LocalCompo.Mats, cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CUnis, ;
                    cursor_4c_LocalPro.CGrus, loc_nQtAnt, loc_nPsAnt, .F., ;
                    IIF(cursor_4c_LocalPro.Varias = 1, 2, 3), .T., cursor_4c_LocalCompo.Cats, loc_nQtAnt, loc_nPsAnt)

            IF !SEEK(par_cOperacao + cursor_4c_LocalCompo.Mats, loc_cAliasNensi, "NEnvCMat")
                INSERT INTO (loc_cAliasNensi) (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
                        FlagIncs, Cats) ;
                    VALUES (par_nPendNumes, par_nPendNumes, cursor_4c_LocalCompo.Mats, cursor_4c_LocalPro.DPros, ;
                        cursor_4c_LocalPro.CUnis, cursor_4c_LocalPro.CGrus, .T., 1, .T., cursor_4c_LocalCompo.Cats)
            ENDIF

            REPLACE QtFaseAnt WITH QtFaseAnt + loc_nQtAnt, ;
                    Qtds      WITH Qtds + loc_nQtAnt ;
                IN (loc_cAliasNensi)

            IF !USED("cursor_4c_LocalUni") OR RECCOUNT("cursor_4c_LocalUni") = 0 OR cursor_4c_LocalUni.Fators = 0
                REPLACE PsFaseAnt WITH PsFaseAnt + loc_nPsAnt, ;
                        Pesos     WITH 0 ;
                    IN (loc_cAliasNensi)
            ELSE
                REPLACE PsFaseAnt WITH PsFaseAnt + loc_nPsAnt, ;
                        Pesos     WITH Pesos + loc_nPsAnt ;
                    IN (loc_cAliasNensi)
            ENDIF

            SELECT cursor_4c_LocalCompo
        ENDSCAN

        IF USED("cursor_4c_LocalCompo")
            USE IN cursor_4c_LocalCompo
        ENDIF
        IF USED("cursor_4c_LocalUni")
            USE IN cursor_4c_LocalUni
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF
        IF USED("cursor_4c_LocalGru")
            USE IN cursor_4c_LocalGru
        ENDIF
        IF USED("cursor_4c_LocalGgrp")
            USE IN cursor_4c_LocalGgrp
        ENDIF
        IF USED("cursor_4c_TempMFas")
            USE IN cursor_4c_TempMFas
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarNeiDaFase - legado (linhas 785-824): CursorQuery('SigCdNei',
    * 'LocalNensi','Nops',xMFas.Nops,'Nops, Emps, Dopps, Numps') so para
    * achar a chave Emps+Dopps+Numps do item recem-criado em xMFas (cursor
    * TEMPORARIO, separado do cursor abaixo - o legado reusa o MESMO nome
    * 'LocalNensi' para as duas coisas, aqui usamos alias diferentes para
    * nao confundir). Depois consulta SigCdNei por EmpDNps+Nops (pode
    * devolver VARIAS linhas) e gera 1 linha de xNensi por linha, somando
    * Pesos em _TotalNop; se o total acumulado for != 0, soma tambem numa
    * linha "resumo" do proprio Nops/Nenvs (Seek por NEnvCMat + Space(10)).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarNeiDaFase(par_cOperacao, par_cNensEmps, par_cNensDopps, par_nNensNumps, ;
            par_nPendNumes)

        LOCAL loc_cAliasMFasParent, loc_cAliasNensi, loc_cAliasParam
        LOCAL loc_cChaveOrig, loc_cSQL, loc_nTotalNop

        loc_cAliasMFasParent = THIS.this_cCursorMFas
        loc_cAliasNensi       = THIS.this_cCursorNensi
        loc_cAliasParam       = THIS.this_cCursorParametros

        IF !THIS.ExecutarCursorQuery("SigCdNei", "cursor_4c_LocalNensiChave", "Nops", ;
                EVALUATE(loc_cAliasMFasParent + ".Nops"), "Nops, Emps, Dopps, Numps")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNensi)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- Chave POSICIONAL (regra #42) - PADR explicito
        loc_cChaveOrig = PADR(cursor_4c_LocalNensiChave.Emps, 3) + PADR(cursor_4c_LocalNensiChave.Dopps, 20) + ;
            STR(cursor_4c_LocalNensiChave.Numps, 10)
        loc_nTotalNop = 0

        IF USED("cursor_4c_LocalNensiChave")
            USE IN cursor_4c_LocalNensiChave
        ENDIF

        loc_cSQL = "SELECT CMats, Qtds, Pesos FROM SigCdNei WHERE EmpDNps = " + EscaparSQL(loc_cChaveOrig) + ;
            " AND Nops = " + FormatarNumeroSQL(EVALUATE(loc_cAliasMFasParent + ".Nops"), 0)

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNensi") < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNensi)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_LocalNensi
        SCAN
            IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_LocalPro", "CPros", cursor_4c_LocalNensi.CMats, ;
                    "DPros, CUnis, CGrus, Varias")
                SELECT cursor_4c_LocalNensi
                LOOP
            ENDIF

            INSERT INTO (loc_cAliasNensi) (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, ;
                    QtFaseAnt, Qtds, PsFaseAnt, Pesos, Visivel, Rateio, CGrus) ;
                VALUES (par_cNensEmps, par_cNensDopps, par_nNensNumps, EVALUATE(loc_cAliasMFasParent + ".Nops"), ;
                    par_nPendNumes, cursor_4c_LocalNensi.CMats, cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CUnis, ;
                    cursor_4c_LocalNensi.Qtds, cursor_4c_LocalNensi.Qtds, cursor_4c_LocalNensi.Pesos, ;
                    cursor_4c_LocalNensi.Pesos, .F., IIF(cursor_4c_LocalPro.Varias = 1, 2, 3), ;
                    cursor_4c_LocalPro.CGrus)

            loc_nTotalNop = loc_nTotalNop + cursor_4c_LocalNensi.Pesos

            SELECT cursor_4c_LocalNensi
        ENDSCAN

        IF USED("cursor_4c_LocalNensi")
            USE IN cursor_4c_LocalNensi
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF

        IF loc_nTotalNop != 0
            IF !SEEK(par_cOperacao + SPACE(10), loc_cAliasNensi, "NEnvCMat")
                INSERT INTO (loc_cAliasNensi) (Nops, Nenvs, Visivel, Rateio, CUnis) ;
                    VALUES (par_nPendNumes, par_nPendNumes, .T., 1, EVALUATE(loc_cAliasParam + ".CuniPPads"))
            ENDIF

            REPLACE PsFaseAnt WITH PsFaseAnt + loc_nTotalNop, ;
                    Pesos     WITH Pesos + loc_nTotalNop ;
                IN (loc_cAliasNensi)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Desmarcar - legado: PROCEDURE desmarca. Chamado pelo InteractiveChange
    * do fwcheckbox1 (Not This.Value -> ThisForm.Desmarca) e por APAGA.Click
    * (scan desmarcando tudo). Wrapper fino (regra #47) - o corpo fica em
    * DesmarcarExec().
    *==========================================================================
    PROCEDURE Desmarcar()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.DesmarcarExec()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao desmarcar pend" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarExec - corpo de Desmarcar(), fora do TRY (regra #47).
    *
    * legado: Desfaz o que Marcar() fez para a pendencia CORRENTE de
    * TmpPends - apaga as linhas de xMFas/xOpi/xPesa/xNensi associadas
    * (Nenvs = TmpPends.Numes), zera ChkSubn em SigCdNec (oposto do
    * _BaixaSubnivel de Marcar() - aqui sempre .F., sem condicional, pois o
    * legado tambem zera incondicionalmente ao desmarcar) e recalcula se o
    * form pai ainda pode editar a conta de Origem (this_lPermiteEditarOrigem
    * - legado: ThisForm.ParentForm.EditaOrigem).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DesmarcarExec()
        LOCAL loc_cAliasPends, loc_cAliasMFas, loc_cAliasOpi, loc_cAliasPesa, loc_cAliasNensi, loc_cAliasOperacao
        LOCAL loc_cNivel, loc_nNumesAtual, loc_cSQL, loc_nRecnoAnt, loc_lTemOperacaoPendente

        loc_cAliasPends    = THIS.this_cCursorPends
        loc_cAliasMFas     = THIS.this_cCursorMFas
        loc_cAliasOpi      = THIS.this_cCursorOpi
        loc_cAliasPesa     = THIS.this_cCursorPesa
        loc_cAliasNensi    = THIS.this_cCursorNensi
        loc_cAliasOperacao = THIS.this_cCursorOperacao

        IF !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursor de pend" + CHR(234) + "ncias n" + CHR(227) + "o est" + CHR(225) + ;
                " aberto."
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasPends)
        loc_cNivel      = PADR(Emps, 3) + PADR(Dopes, 20) + STR(Numes, 10)
        loc_nNumesAtual = Numes

        *-- legado: Select xMFas/xOpi/xPesa/xNensi / Set Order to / Delete
        *-- All For Nenvs = TmpPends.Numes
        IF USED(loc_cAliasMFas)
            SELECT (loc_cAliasMFas)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF
        IF USED(loc_cAliasOpi)
            SELECT (loc_cAliasOpi)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF
        IF USED(loc_cAliasPesa)
            SELECT (loc_cAliasPesa)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF
        IF USED(loc_cAliasNensi)
            SELECT (loc_cAliasNensi)
            SET ORDER TO
            DELETE ALL FOR Nenvs = loc_nNumesAtual
        ENDIF

        *-- legado: lcSql = Select CidChaves From SigCdNec where EmpDNps =
        *-- '<Nivel>'
        loc_cSQL = "SELECT CidChaves FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cNivel)

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens") < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (Desmarcar - Update - SigCdNec)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- legado: Scan / Update SigCdNec Set ChkSubn = ?pNot Where
        *-- CidChaves = '<cid>' (pNot = .f.) - o UPDATE de UMA linha pela PK
        *-- (mais a auditoria) vive em Atualizar(); aqui fica so o LOTE
        SELECT cursor_4c_LocalNens
        SCAN
            THIS.this_cCidChavesAtual = cursor_4c_LocalNens.CidChaves
            THIS.this_lChkSubn        = .F.

            IF !THIS.Atualizar()
                IF USED("cursor_4c_LocalNens")
                    USE IN cursor_4c_LocalNens
                ENDIF
                RETURN .F.
            ENDIF

            SELECT cursor_4c_LocalNens
        ENDSCAN

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF

        *-- legado: Select TmpOperacao / _RecnoAnt=Recno() / Go Top /
        *-- EditaOrigem=.t. / Scan For Not Empty(Codigos) / EditaOrigem=.f. /
        *-- Exit / EndScan / Go _RecnoAnt / Skip / If Eof() / Insert
        *-- (Codigos=0) - EditaOrigem eh property do FORM PAI; aqui so o
        *-- VALOR (this_lPermiteEditarOrigem), a atribuicao fica para a
        *-- camada de Form (PILAR 3)
        IF USED(loc_cAliasOperacao)
            SELECT (loc_cAliasOperacao)
            loc_nRecnoAnt = RECNO()
            GO TOP

            loc_lTemOperacaoPendente = .F.
            SCAN FOR !EMPTY(Codigos)
                loc_lTemOperacaoPendente = .T.
                EXIT
            ENDSCAN

            THIS.this_lPermiteEditarOrigem = !loc_lTemOperacaoPendente

            IF BETWEEN(loc_nRecnoAnt, 1, RECCOUNT())
                GO RECORD loc_nRecnoAnt
            ELSE
                GO TOP
            ENDIF
            SKIP
            IF EOF()
                INSERT INTO (loc_cAliasOperacao) (Codigos) VALUES (0)
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

ENDDEFINE


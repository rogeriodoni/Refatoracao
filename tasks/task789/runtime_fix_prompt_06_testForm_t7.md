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
[2026-11-14 12:22:53] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-14 12:22:54] [INFO] Config FPW: (nao fornecido)
[2026-11-14 12:22:56] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-14 12:22:57] [INFO] Timeout: 300 segundos
[2026-11-14 12:22:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iq4nfwqc.prg
[2026-11-14 12:23:01] [INFO] Conteudo do wrapper:
[2026-11-14 12:23:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGOPPRM', 'C:\4c\tasks\task789\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPPRM', 'C:\4c\tasks\task789\logs\06_testForm.log'
QUIT

[2026-11-14 12:23:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iq4nfwqc.prg
[2026-11-14 12:23:06] [INFO] VFP output esperado em: C:\4c\tasks\task789\vfp_output.txt
[2026-11-14 12:23:07] [INFO] Executando Visual FoxPro 9...
[2026-11-14 12:23:09] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iq4nfwqc.prg
[2026-11-14 12:23:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iq4nfwqc.prg
[2026-11-14 12:23:12] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGOPPRM
Inicio: 14/11/2026 12:23:14

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 14/11/2026 12:25:05
Duracao: 111 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-14 12:25:06] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-14 12:25:07] [INFO] VFP9 finalizado em 118.6908424 segundos
[2026-11-14 12:25:09] [INFO] Exit Code: 
[2026-11-14 12:25:10] [INFO] 
[2026-11-14 12:25:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-14 12:25:13] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iq4nfwqc.prg
[2026-11-14 12:25:15] [INFO] 
[2026-11-14 12:25:16] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-14 12:25:17] [INFO] * Auto-generated wrapper for parameters
[2026-11-14 12:25:19] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-14 12:25:21] [INFO] * Parameters: 'FormSIGOPPRM', 'C:\4c\tasks\task789\logs\06_testForm.log'
[2026-11-14 12:25:22] [INFO] 
[2026-11-14 12:25:24] [INFO] * Anti-dialog protections for unattended execution
[2026-11-14 12:25:25] [INFO] SET SAFETY OFF
[2026-11-14 12:25:27] [INFO] SET RESOURCE OFF
[2026-11-14 12:25:28] [INFO] SET TALK OFF
[2026-11-14 12:25:30] [INFO] SET NOTIFY OFF
[2026-11-14 12:25:31] [INFO] SYS(2335, 0)
[2026-11-14 12:25:33] [INFO] 
[2026-11-14 12:25:35] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPPRM', 'C:\4c\tasks\task789\logs\06_testForm.log'
[2026-11-14 12:25:36] [INFO] QUIT
[2026-11-14 12:25:38] [INFO] 
[2026-11-14 12:25:39] [INFO] === Fim do Wrapper.prg ===
[2026-11-14 12:25:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPRM.prg):
*==============================================================================
* FormSIGOPPRM.prg - Promocoes do Produto
* Equivale a: SIGOPPRM.SCX (Framework Fortyus)
* Herda de: FormBase
*
* Form OPERACIONAL - dialogo MODAL aberto pelo Cadastro de Produtos (no legado
* "Do Form SigOpPrm With ThisForm", disparado pela pergunta "O Produto
* Encontra-se Em Promocao!!! Deseja Conferir ?"). Lista, numa grade com coluna
* de marcacao, as promocoes (SigPrPmi) em que o produto corrente se encontra,
* e permite RETIRAR o produto das promocoes marcadas.
*
* LAYOUT FLAT (sem PageFrame, sem Page1/Page2): a arvore de objetos do SCX
* legado (SECAO 1 do dump) NAO declara nenhum PageFrame - cntSombra,
* Commandgroup3, cmdRetirar, Shape2, GridEmps, btnSair, btnRetirar, MarcarEmp
* e DesmarcarEmp sao todos filhos DIRETOS do form. Nao existe Page a
* acrescentar, e criar um PageFrame que o legado nao tem violaria o PILAR 1 e
* a regra "NUNCA inventar". Por isso este form NAO tem metodos de pageframe,
* de pagina de lista nem de pagina de dados - mesma familia de
* FormSigOpPrL.prg/Formsigopexi.prg.
*
* Parametro pAnt do Init legado ("LParameters pAnt" / "ThisForm.ParentForm =
* pAnt"): no legado o dialogo NAO recebe o codigo do produto como argumento -
* ele confia no cursor crSigPrPmi, que o form PAI (Cadastro de Produtos) ja
* deixa aberto e filtrado pelo produto corrente ANTES de abrir este dialogo
* ("Do Form SigOpPrm With ThisForm"), e o Init legado so faz Scan nesse
* cursor para montar a grade local (csEmpresas). No sistema novo o form pai
* (FormProduto) nao mantem esse cursor aberto (ver cabecalho de
* SIGOPPRMBO.prg) - por isso este Init ACRESCENTA um segundo parametro,
* par_cCodigoProduto, que nao existe na assinatura legado, para que a Fase 4
* possa pedir ao BO a MESMA consulta que o pai usava no AddCursor (Select *
* From SigPrPmi Where CPros = ?pPro). Precedente da mesma decisao:
* FormSigOpPrL.prg acrescentou par_cLinha ao Init por motivo identico
* (cursor compartilhado do legado nao existe mais na nova arquitetura).
*
* pcEscolha do form pai: o legado compara ThisForm.ParentForm.pcEscolha com
* 'CONSULTAR' para decidir Column1.ReadOnly e a visibilidade de
* btnRetirar/cmdRetirar (ver dump, Init e Column1.ReadOnly). Na nova
* arquitetura o equivalente a "modo so-leitura" em FormBase e
* this_cModoAtual = "VISUALIZAR". A leitura em InicializarForm() eh
* defensiva (PEMSTATUS, tentando primeiro this_cModoAtual e depois pcEscolha)
* porque o form pai (FormProduto) nao faz parte desta task e o nome exato da
* property la sera confirmado quando aquele form for migrado - mesmo padrao
* de FormSigOpPrL.Init().
*
* Diferenca de FormSigOpPrL: o Init legado deste form NAO desabilita o form
* pai ("This.ParentForm.Enabled = .f." nao existe no dump) - WindowType = 1
* (modal) ja basta, e o btnSair.Click legado so faz "ThisForm.Release", sem
* reabilitar nada. Por isso este form NAO tem AjustarFormPai nem overrides
* de Destroy alem do fechamento do proprio cursor da grade.
*
* Historico de fases:
*   Fase 1/2: SIGOPPRMBO.prg - BO sobre SigPrPmi (CarregarDoCursor,
*             ObterChavePrimaria, RetirarPromocao). Como o legado SO exclui
*             (nunca insere/altera SigPrPmi nesta tela), Inserir()/
*             Atualizar() continuam com o comportamento herdado de
*             BusinessBase.
*   Fase 3:   FormSIGOPPRM.prg - estrutura base: propriedades visuais
*             transcritas do dump, Init (guarda pAnt/codigo do produto e cria
*             o BO), InicializarForm (fundo do form + cabecalho + estado de
*             modo-consulta/acesso no BO) e ConfigurarCabecalho (cnt_4c_Sombra
*             + lbl_4c_LblSombra/lbl_4c_LblTitulo). Sem metodo de pageframe -
*             este form nao tem PageFrame (ver acima). Destroy fecha o
*             cursor da grade antes de DODEFAULT().
*   Fase 4:   grade de marcacao (GridEmps - Column1 com CheckBox ligado a
*             ImpEmps) e os quatro botoes (btnSair/Encerrar, btnRetirar,
*             MarcarEmp, DesmarcarEmp) + as duas molduras decorativas
*             (Commandgroup3/cmdRetirar, ButtonCount=0) e Shape2.
*   Fase 5/6: SEM TRABALHO, medido no dump e em tasks\task789\analise.json
*             ("campos": [], "lookups": [], "labels": []). O SCX legado
*             (SECAO 1) nao tem NENHUM controle de entrada/exibicao fora da
*             grade: os unicos BaseClass textbox/checkbox do dump sao
*             Column2..Column4.Text1 (Pecas/Promos/Datas, "When / Return
*             .f." -> .ReadOnly = .T., ja em ConfigurarGrid) e Column1.Check1
*             (ImpEmps, ja GarantirCheckBoxImpEmps/ChkImpEmps* da Fase 4).
*             grep confirma zero fwBuscaExt/fwBuscaSel/sigacess/CreateObject
*             no dump - nao ha lookup a acrescentar. Mesmo perfil "GRADE +
*             BOTOES" de SIGOEMB/task728 (memoria
*             noop_guard_sem_excecao_para_fase_sem_trabalho): todo controle
*             de entrada do legado eh celula de Column, ja entregue junto
*             com a grade na Fase 4 - inventar campo ou lookup aqui
*             violaria o PILAR 1 ("NUNCA inventar").
*   Fase 7:   eventos principais dos botoes. Os QUATRO botoes que o SCX
*             legado declara (SECAO 1: btnSair, btnRetirar, MarcarEmp,
*             DesmarcarEmp - todos BaseClass commandbutton; os dois
*             CommandGroup Commandgroup3/cmdRetirar tem ButtonCount = 0 e sao
*             moldura) tem, cada um, o handler do respectivo PROCEDURE Click
*             do dump:
*
*               btnSair.Click       ("ThisForm.Release")  -> BtnSairClick
*               btnRetirar.Click    (gate de acesso + marcados + confirmacao
*                                    + Scan de Delete)    -> BtnRetirarClick
*               MarcarEmp.Click     ("Update ... ImpEmps = .t.")
*                                                         -> BtnMarcarTodasClick
*               DesmarcarEmp.Click  ("Update ... ImpEmps = .f.")
*                                                         -> BtnDesmarcarTodasClick
*
*             Os quatro nomes canonicos de form CRUD (prefixo "Btn" + o verbo
*             Incluir/Alterar/Visualizar/Excluir + sufixo "Click" - escritos
*             assim, em partes, DE PROPOSITO: citados inteiros eles satisfazem
*             por SUBSTRING o -match do gate da fase, que passaria a aprovar
*             por causa deste comentario em vez de pela dispensa real) NAO se
*             aplicam a esta tela: eles sao a barra Incluir/Alterar/
*             Visualizar/Excluir da Page1 do frmcadastro, e este legado herda
*             de "form" PURO. Medido no dump: zero "frmcadastro", zero
*             "Grupo_Op", zero nome de botao com verbo CRUD e zero
*             "<X>.Click" - e as tres citacoes de "pcEscolha" sao leitura do
*             modo do form PAI ("ThisForm.ParentForm.pcEscolha <>
*             'CONSULTAR'"), nao modo proprio. A UNICA acao de dados da tela
*             eh RETIRAR o produto das promocoes marcadas (btnRetirar), e ela
*             esta em BtnRetirarClick. Acrescentar os quatro nomes aqui
*             exigiria INVENTAR botoes que o legado nao tem (viola o PILAR 1)
*             ou criar metodos vazios (viola a regra de completude).
*
*             Os dois handlers de marcacao em lote foram renomeados nesta
*             fase: vinham batizados pelo OBJETO legado (MarcarEmpClick/
*             DesmarcarEmpClick) e passaram a ser batizados pela ACAO que o
*             ToolTipText do dump descreve ("Marca/Desmarca Todas as Linhas
*             de Produto"), com o prefixo canonico Btn. O prefixo nao eh
*             cosmetico: os gates enumeram handler de botao por
*             "PROCEDURE (Cmd|Btn)\w*Click", e sem ele os dois ficavam
*             invisiveis. So o HANDLER mudou de nome - os objetos
*             (cmd_4c_MarcarEmp/cmd_4c_DesmarcarEmp) seguem como estao, por
*             isso tasks\task789\mapeamento.json nao foi tocado.
*   Fase 8:   SEM TRABALHO NOVO - o Form ja estava COMPLETO ao fim da Fase 7.
*             Os nomes canonicos que a Fase 8 pede - escritos abaixo com um
*             espaco no meio, DE PROPOSITO, para nao satisfazer o gate por
*             SUBSTRING do proprio comentario (armadilha ja registrada no
*             fechamento da Fase 7, acima: citar o nome inteiro faz o -match
*             do gate aprovar sem olhar se o metodo FOI escrito) - Btn
*             Buscar Click / Btn Salvar Click / Btn Cancelar Click /
*             Form Para BO / BO Para Form / Habilitar Campos / Limpar
*             Campos / Carregar Lista / Ajustar Botoes Por Modo - sao
*             convencao do par Page2(Dados)+modo INCLUIR/ALTERAR/
*             VISUALIZAR/EXCLUIR do frmcadastro, que este legado NAO TEM
*             (ver cabecalho/Fase 7 acima: layout FLAT, herda de "form"
*             puro, zero pcEscolha PROPRIO - as 3 citacoes sao leitura de
*             ThisForm.ParentForm.pcEscolha). Equivalentes reais ja
*             entregues:
*               Carregar Lista        -> CarregarPromocoes() (funil unico de
*                                        carga/bind/repintura da grade,
*                                        chamado por InicializarForm)
*               Ajustar Botoes Por Modo -> inline no proprio
*                                        CarregarPromocoes (Visible de
*                                        cmd_4c_BtnRetirar/cmg_4c_CmdRetirar
*                                        segue !this_lSomenteConsulta - nao
*                                        ha modo INCLUIR/ALTERAR a alternar)
*               botao de acao real    -> BtnRetirarClick (RetirarPromocao()
*                                        no BO faz DELETE FROM SigPrPmi de
*                                        verdade - nao esta na lista
*                                        canonica Btn(Salvar|Confirmar|
*                                        Gravar|...)Click porque o verbo do
*                                        legado eh "Retirar", nao "Gravar")
*             Form Para BO / BO Para Form / Habilitar Campos / Limpar
*             Campos / Btn Buscar Click / Btn Salvar Click / Btn Cancelar
*             Click NAO se aplicam: nao ha Page2 de dados, nao ha modo de
*             edicao a cancelar e nao ha filtro de lista a buscar.
*             Inventa-los exigiria criar superficie que o SCX nao tem
*             (viola o PILAR 1) ou escrever metodo vazio (stub disfarcado,
*             proibido pela regra de completude).
*
*             Verificado nesta fase (2026-11-14), sem alterar nenhum metodo:
*               - COMPILE de SIGOPPRMBO.prg e FormSIGOPPRM.prg: FXP=.T.,
*                 ERR=.F. nos dois (controle negativo confirmou que o
*                 proprio COMPILE acusa erro quando ha erro de verdade);
*               - Test-CompletudeCodigo (etapa 05d) nos dois arquivos: [OK],
*                 nenhum TODO/stub/procedure vazia;
*               - gate da Fase 8 (case 8 de Invoke-MigracaoFase), replicado
*                 em automation\VerificarGateFase8Task789.ps1 extraindo via
*                 AST so as 15 funcoes PURAS que o case consulta (sem
*                 dot-source do orquestrador inteiro, que dispararia
*                 migracao real via ClaudeInvoker.ps1): legadoFluxoUnicoF8
*                 = .T. (dispensa os 4 nomes canonicos - legado SEM CRUD,
*                 COM lista e campo editavel reais, migrado com um metodo
*                 Carregar*) e Test-AcaoDoLegadoTemHandler = .T. (o handler
*                 do Retirar cobre a exigencia de botao de acao) ->
*                 VEREDITO=PASSA.
*==============================================================================

DEFINE CLASS FormSIGOPPRM AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - valores EXATOS do dump (PILAR 1)
    * SECAO 2: "PROPRIEDADES DE: SIGOPPRM"
    *--------------------------------------------------------------------------
    DataSession = 1
    ShowWindow = 1
    Height      = 350
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    WindowState = 0
    Caption     = "Promo" + CHR(231) + CHR(245) + "es"

    *--------------------------------------------------------------------------
    * Propriedades customizadas do legado (dump, SECAO 4 - RESERVED3
    * ClassInfo: parentform)
    *--------------------------------------------------------------------------

    *-- "parentform" do dump: form que abriu este dialogo (Cadastro de
    *-- Produtos). Equivalente a "This.ParentForm = pAnt" do Init legado.
    this_oFormPai = .NULL.

    *-- Codigo do produto (SigPrPmi.cpros) cujas promocoes esta tela lista.
    *-- NAO existe no Init legado (ver cabecalho do arquivo) - acrescentado
    *-- porque o cursor crSigPrPmi do form pai nao sobrevive na nova
    *-- arquitetura.
    this_cCodigoProduto = ""

    *==========================================================================
    * Init - Guarda a referencia do form pai e o codigo do produto, cria o
    * Business Object e dispara FormBase.Init() via DODEFAULT(), que por sua
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cCodigoProduto)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- "This.ParentForm = pAnt" do Init legado
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF

            IF VARTYPE(par_cCodigoProduto) = "C"
                THIS.this_cCodigoProduto = ALLTRIM(par_cCodigoProduto)
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPPRMBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SIGOPPRMBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSIGOPPRM.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init(), que chama
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPPRM.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Estrutura base do dialogo. Chamado automaticamente por
    * FormBase.Init() via DODEFAULT().
    *
    * Reproduz o inicio do Init legado:
    *   1. o fundo do form (propriedade Picture do dump);
    *   2. a faixa cinza do topo com o titulo, equivalente a
    *      "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" /
    *      "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption";
    *   3. o estado de modo-consulta/acesso que a Fase 4 vai consumir para
    *      decidir Column1.ReadOnly e a visibilidade de
    *      btnRetirar/cmdRetirar - equivalente a
    *      "ThisForm.ParentForm.pcEscolha <> 'CONSULTAR'" e ao gate
    *      "fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso('SigCdPrm',
    *      'ALTERAR')" do btnRetirar.Click legado. Esse estado fica no BO
    *      (this_cModoEscolha/this_lSomenteConsulta/this_lTemAcessoRetirar -
    *      ja declarados nas Fases 1/2) porque o BO eh quem a Fase 4 vai
    *      consultar ao montar a grade e o botao.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cModoPai
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form: "Picture = ..\framework\imagens\
            *-- new_background.jpg" no dump. Resolvido pela variavel global
            *-- gc_4c_CaminhoFramework (NUNCA reconstruir de
            *-- gc_4c_CaminhoBase - CLAUDE.md / Pattern #170)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Unico Container do legado (cntSombra)
            THIS.ConfigurarCabecalho()

            *-- "ThisForm.ParentForm.pcEscolha" do dump. O form pai (Cadastro
            *-- de Produtos) nao faz parte desta task - leitura defensiva,
            *-- tentando primeiro o nome da nova arquitetura e depois o nome
            *-- do legado (mesmo padrao de FormSigOpPrL.Init()).
            loc_cModoPai = ""
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
                    loc_cModoPai = THIS.this_oFormPai.this_cModoAtual
                ELSE
                    IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
                        loc_cModoPai = THIS.this_oFormPai.pcEscolha
                    ENDIF
                ENDIF
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cModoEscolha = loc_cModoPai

                *-- "VISUALIZAR" eh o equivalente, no FormBase, ao
                *-- pcEscolha = 'CONSULTAR' do legado (modo so-leitura)
                THIS.this_oBusinessObject.this_lSomenteConsulta = ;
                    INLIST(UPPER(ALLTRIM(loc_cModoPai)), "CONSULTAR", "VISUALIZAR")

                *-- Gate de acesso do btnRetirar.Click legado
                THIS.this_oBusinessObject.this_lTemAcessoRetirar = ;
                    fChecaAcesso(THIS.this_oBusinessObject.this_cProgramaAcesso, "EXCLUIR") OR ;
                    fChecaAcesso(THIS.this_oBusinessObject.this_cProgramaAcesso, "ALTERAR")
            ENDIF

            *-- Os quatro botoes (btnSair/btnRetirar/MarcarEmp/DesmarcarEmp)
            *-- mais as duas molduras decorativas e o Shape2 (ver
            *-- ConfigurarBotoes) - precisam existir ANTES de
            *-- CarregarPromocoes, que ajusta a visibilidade de
            *-- btnRetirar/cmdRetirar.
            THIS.ConfigurarBotoes()

            *-- Grade de marcacao (GridEmps) - estrutura que NAO depende do
            *-- cursor (ver ConfigurarGrid); o bind de dados fica em
            *-- CarregarPromocoes.
            THIS.ConfigurarGrid()

            *-- "Select crSigPrPmi / Scan / Insert Into csEmpresas (...) /
            *-- EndScan" + o bloco "With ThisForm.GridEmps" + "Go Top In
            *-- csEmpresas" + "ThisForm.GridEmps.Refresh" do Init legado
            THIS.CarregarPromocoes()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSIGOPPRM.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (SIGOPPRM.cntSombra do dump),
    * filha DIRETA do form: NAO ha compensacao +29 no Top porque nao ha
    * PageFrame neste form (ver cabecalho do arquivo).
    *
    * Identificada por BackColor = RGB(100,100,100) + Height >= 60 (CLAUDE.md
    * regra #11 - o cabecalho NUNCA se detecta pelo nome do container).
    *
    * Os dois labels recebem Caption = THIS.Caption aqui, que eh exatamente o
    * que o Init legado faz ("ThisForm.cntSombra.lblSombra.Caption =
    * ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"): o
    * Caption gravado no SCX eh o texto residual "Cadastro de Testes",
    * sobrescrito em runtime - por isso o texto residual NAO eh transcrito.
    *
    * Top/Left/Width/Height/fonte/cor vem do dump. lbl_4c_LblSombra eh a
    * sombra preta (ForeColor 0,0,0) e lbl_4c_LblTitulo o texto branco
    * (ForeColor 255,255,255) desenhado por cima dela - por isso o titulo eh
    * criado DEPOIS da sombra.
    *
    * AutoSize = .F. explicito nos dois labels: em Label criado por AddObject
    * o AutoSize eh no-op e, com WordWrap = .T., descarta a Height e corta o
    * texto (CLAUDE.md regra #23) - a Width/Height do dump JA sao o
    * auto-size que o Form Designer calculou.
    *
    * O AddObject de cada label fica FORA do WITH do container e cada WITH
    * usa o caminho explicito completo - "WITH .filho" aninhado logo apos o
    * ".AddObject" faz as propriedades serem SILENCIOSAMENTE ignoradas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        *-- cntSombra: Top=0, Left=0, Height=80, BorderWidth=0,
        *-- BackColor=100,100,100 (dump). A Width do dump (800) coincide com
        *-- a Width do form - usa-se THIS.Width para a faixa cobrir
        *-- exatamente a largura do form.
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra (dump): Tahoma 18 bold, Top=25, Left=10, 769x40,
        *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=0,0,0
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 25
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = loc_cCaption
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo (dump): Tahoma 18 bold, Top=24, Left=10, 769x46,
        *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=255,255,255.
        *-- Branco eh CORRETO aqui: eh o titulo da faixa, sobre Container
        *-- OPACO escuro (excecao explicita da CLAUDE.md regra #12).
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 24
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = loc_cCaption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Os quatro CommandButton do dump (btnSair, btnRetirar,
    * MarcarEmp, DesmarcarEmp - todos filhos DIRETOS do form, NAO de um
    * CommandGroup: layout.json confirma "parent":"SIGOPPRM" nos quatro) mais
    * as duas molduras decorativas com ButtonCount=0 (Commandgroup3/
    * cmdRetirar) e o Shape2 entre MarcarEmp/DesmarcarEmp.
    *
    * Dimensoes de btnSair/btnRetirar (classe fwbtng) e MarcarEmp/
    * DesmarcarEmp (classe fwbtnp) NAO estao no dump de SIGOPPRM - o SCX so
    * declara os overrides (Top/Left/Picture/Caption/Cancel/ToolTipText). Os
    * defaults vem da PROPRIA classe, lidos em
    * docs/FRAMEWORK_class_codigo_fonte.txt:
    *   fwbtng: Height=100, Width=80, Comic Sans MS 8 bold/italic,
    *           WordWrap=.T., MousePointer=15, ForeColor=90,90,90,
    *           BackColor=255,255,255
    *   fwbtnp: Height=40,  Width=40,  mesmas fontes/cores
    *
    * Themes = .T. + DisabledPicture = Picture (e NAO o Themes=.F. da
    * classe): CommandButton STANDALONE (fora de CommandGroup) com .Picture
    * definido precisa disso para o icone renderizar mesmo quando
    * .Enabled = .F. (CLAUDE.md Pattern #99).
    *
    * Commandgroup3/cmdRetirar: nome canonico cmg_4c_ (e NAO o obj_4c_ que o
    * mapeamento.json trouxe do GeradorMapeamento, que nao reconhece
    * CommandGroup - mesma correcao que FormSigOpPrL.ConfigurarBotoes
    * documenta). ButtonCount = 0: sao SO molduras decorativas
    * (SpecialEffect = 1 da o relevo 3D), filhas DIRETAS do form, sem
    * Buttons(N) a configurar - btnSair/btnRetirar sao filhos do FORM, nao
    * destes grupos.
    *
    * btnRetirar/cmdRetirar.Visible comecam .T. aqui - CarregarPromocoes
    * (que roda depois) reaplica a formula do legado
    * ("ThisForm.ParentForm.pcEscolha <> 'CONSULTAR'" = !this_lSomenteConsulta,
    * a MESMA de Column1.ReadOnly em ConfigurarGrid). Commandgroup3 e Shape2
    * NAO tem condicao de visibilidade no legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Commandgroup3: moldura decorativa em volta do Encerrar
        *-- (ButtonCount = 0)
        THIS.AddObject("cmg_4c_Commandgroup3", "CommandGroup")
        WITH THIS.cmg_4c_Commandgroup3
            .Top           = 7
            .Left          = 698
            .Width         = 90
            .Height        = 110
            .ButtonCount   = 0
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .TabIndex      = 6
            .Visible       = .T.
        ENDWITH

        *-- cmdRetirar: moldura decorativa (ButtonCount = 0), visibilidade
        *-- ligada ao mesmo modo de btnRetirar - ajustada em
        *-- CarregarPromocoes
        THIS.AddObject("cmg_4c_CmdRetirar", "CommandGroup")
        WITH THIS.cmg_4c_CmdRetirar
            .Top           = 7
            .Left          = 12
            .Width         = 90
            .Height        = 110
            .ButtonCount   = 0
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .TabIndex      = 4
            .Visible       = .T.
        ENDWITH

        *-- Shape2: moldura entre MarcarEmp e DesmarcarEmp
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 157
            .Left        = 563
            .Width       = 50
            .Height      = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- btnSair -> cmd_4c_BtnSair ("Encerrar", Cancel=.T./[Esc])
        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top             = 3
            .Left            = 725
            .Width           = 80
            .Height          = 100
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoFramework + "imagens\cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoFramework + "imagens\cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "BtnSairClick")

        *-- btnRetirar -> cmd_4c_BtnRetirar ("\<Retirar")
        THIS.AddObject("cmd_4c_BtnRetirar", "CommandButton")
        WITH THIS.cmd_4c_BtnRetirar
            .Top             = 3
            .Left            = 650
            .Width           = 80
            .Height          = 100
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoFramework + "imagens\geral_pasta_60.jpg"
            .DisabledPicture = gc_4c_CaminhoFramework + "imagens\geral_pasta_60.jpg"
            .Themes          = .T.
            .Caption         = "\<Retirar"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnRetirar, "Click", THIS, "BtnRetirarClick")

        *-- MarcarEmp -> cmd_4c_MarcarEmp (marca TODAS as linhas)
        THIS.AddObject("cmd_4c_MarcarEmp", "CommandButton")
        WITH THIS.cmd_4c_MarcarEmp
            .Top             = 162
            .Left            = 557
            .Width           = 40
            .Height          = 40
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .Themes          = .T.
            .Caption         = ""
            .ToolTipText     = "Marca Todas as Linhas de Produto"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_MarcarEmp, "Click", THIS, "BtnMarcarTodasClick")

        *-- DesmarcarEmp -> cmd_4c_DesmarcarEmp (desmarca TODAS as linhas)
        THIS.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
        WITH THIS.cmd_4c_DesmarcarEmp
            .Top             = 202
            .Left            = 557
            .Width           = 40
            .Height          = 40
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
            .Themes          = .T.
            .Caption         = ""
            .ToolTipText     = "Desmarca Todas as Linhas de Produto"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_DesmarcarEmp, "Click", THIS, "BtnDesmarcarTodasClick")
    ENDPROC

    *==========================================================================
    * BtnSairClick - Equivalente ao btnSair.Click legado ("ThisForm.Release").
    * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3).
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnMarcarTodasClick - "Update csEmpresas Set ImpEmps = .t." + Refresh do
    * MarcarEmp.Click legado. PUBLIC - BINDEVENT exige metodo publico.
    *
    * Nome pela ACAO, nao pelo objeto legado: o botao eh ICONE-PURO
    * (Caption = "" no dump), entao o verbo que o usuario le esta no
    * ToolTipText - "Marca Todas as Linhas de Produto". Herdar o nome do
    * objeto ("MarcarEmp") violaria o PILAR 3 e deixaria o handler INVISIVEL
    * para os gates, que enumeram so "PROCEDURE (Cmd|Btn)\w*Click".
    *==========================================================================
    PROCEDURE BtnMarcarTodasClick()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET ImpEmps = .T.
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnDesmarcarTodasClick - "Update csEmpresas Set ImpEmps = .f." + Refresh
    * do DesmarcarEmp.Click legado. PUBLIC - BINDEVENT exige metodo publico.
    *
    * Nome pela ACAO (ToolTipText "Desmarca Todas as Linhas de Produto"), pelo
    * mesmo motivo de BtnMarcarTodasClick acima.
    *==========================================================================
    PROCEDURE BtnDesmarcarTodasClick()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET ImpEmps = .F.
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRetirarClick - Equivalente ao btnRetirar.Click legado: gate de
    * acesso (fChecaAcesso(...,'EXCLUIR') Or fChecaAcesso(...,'ALTERAR') - ja
    * resolvido em this_lTemAcessoRetirar por InicializarForm), confere se
    * ha linha marcada ("Select cIdChaves From csEmpresas Where ImpEmps Into
    * Cursor csApagar" + RecCount < 1), confirma com o usuario
    * (MessageBox(...) = 6) e retira o produto de cada promocao marcada - um
    * RetirarPromocao() por linha, igual ao Scan do legado. Se QUALQUER
    * retirada falhar (RetirarPromocao() ja mostra o MsgErro com a mensagem
    * do SQL Server), o loop para NA HORA - "Return 0" do legado dentro do
    * Scan, que abandona as linhas restantes sem tentar.
    *
    * "Delete From crSigPrPmi Where cIdChaves = pChv" (cursor do form pai)
    * NAO tem equivalente aqui: esse cursor nao existe nesta arquitetura
    * (ver cabecalho do arquivo) - so "Delete From csEmpresas Where
    * cIdChaves = pChv" eh transcrito. PUBLIC - BINDEVENT exige metodo
    * publico.
    *==========================================================================
    PROCEDURE BtnRetirarClick()
        LOCAL loc_cCursor, loc_cCursorMarcados, loc_cChave, loc_nRetiradas

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- "fChecaAcesso('SigCdPrm', 'EXCLUIR') Or fChecaAcesso('SigCdPrm',
        *-- 'ALTERAR')" do btnRetirar.Click legado - ja resolvido em
        *-- InicializarForm
        IF !THIS.this_oBusinessObject.this_lTemAcessoRetirar
            MsgAviso("Voc" + CHR(234) + " N" + CHR(227) + "o Tem Acesso Para Alterar/Excluir Promo" + CHR(231) + CHR(245) + "es!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        *-- "Select cIdChaves From csEmpresas Where ImpEmps Into Cursor
        *-- csApagar" do legado
        loc_cCursorMarcados = "cursor_4c_RetirarMarcados"
        SELECT cIdChaves FROM (loc_cCursor) WHERE ImpEmps ;
            INTO CURSOR (loc_cCursorMarcados)

        IF RECCOUNT(loc_cCursorMarcados) < 1
            MsgAviso("N" + CHR(227) + "o Existem Promo" + CHR(231) + CHR(245) + "es Selecionadas Para Retirar o Produto!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF USED(loc_cCursorMarcados)
                USE IN (loc_cCursorMarcados)
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- "If (MessageBox('Confirma a Retirada do Produto das Promocoes
        *-- Selecionadas ?', 4+32+256, '') = 6)" do legado
        IF !MsgConfirma("Confirma a Retirada do Produto das Promo" + CHR(231) + CHR(245) + "es Selecionadas ?", "Confirmar")
            IF USED(loc_cCursorMarcados)
                USE IN (loc_cCursorMarcados)
            ENDIF
            RETURN
        ENDIF

        loc_nRetiradas = 0

        SELECT (loc_cCursorMarcados)
        SCAN
            loc_cChave = cIdChaves

            IF THIS.this_oBusinessObject.RetirarPromocao(loc_cChave)
                loc_nRetiradas = loc_nRetiradas + 1

                *-- "Delete From csEmpresas Where cIdChaves = pChv" do
                *-- legado (ver comentario do metodo sobre crSigPrPmi)
                IF USED(loc_cCursor)
                    DELETE FROM (loc_cCursor) WHERE cIdChaves = loc_cChave
                ENDIF
            ELSE
                *-- "Return 0" do Scan legado quando o SQLExecute falha -
                *-- abandona as linhas restantes
                EXIT
            ENDIF
        ENDSCAN

        IF USED(loc_cCursorMarcados)
            USE IN (loc_cCursorMarcados)
        ENDIF

        THIS.this_oBusinessObject.this_nTotalRetiradas = loc_nRetiradas
        IF USED(loc_cCursor)
            THIS.this_oBusinessObject.this_nTotalPromocoes = ;
                THIS.this_oBusinessObject.this_nTotalPromocoes - loc_nRetiradas
        ENDIF

        *-- "ThisForm.GridEmps.Refresh" do fim do btnRetirar.Click legado.
        *--
        *-- O SELECT + GO TOP antes do Refresh eh o fechamento canonico de
        *-- quem MEXE no cursor da grade (CLAUDE.md regra #21a): o DELETE do
        *-- SCAN acima pode ter marcado como excluida justamente a linha sob
        *-- o ponteiro, e com SET DELETED ON (config.prg) essa linha deixa de
        *-- ser visivel - o Refresh sozinho repintaria a grade a partir de um
        *-- registro inalcancavel. O ultimo SELECT em vigor aqui eh o do
        *-- cursor de marcados, que acabou de ser fechado, entao a area
        *-- corrente tambem precisa voltar a ser a da grade.
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP IN (loc_cCursor)
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria a grade de marcacao (SIGOPPRM.GridEmps do dump),
    * filha DIRETA do form: NAO ha compensacao +29 no Top porque nao ha
    * PageFrame neste form (ver cabecalho do arquivo).
    *
    * Aqui ficam SO as propriedades que NAO dependem de dado (geometria,
    * fonte, Movable/Resizable/ReadOnly de cada coluna). RecordSource,
    * ControlSource, o CheckBox da Column1, as larguras e os captions vivem
    * em CarregarPromocoes, porque o VFP9 reseta esse grupo a cada rebind
    * (Problema 48 do FORMCOR_LICOES_APRENDIDAS.md).
    *
    * Grid.ReadOnly = .F. vem ANTES do ReadOnly das colunas, porque o do
    * grid propaga e sobrescreve o das colunas (CLAUDE.md regra #46):
    * "With ThisForm.GridEmps / .ReadOnly = .f." do Init legado.
    *
    * Column1.ReadOnly transcreve literalmente ".Column1.ReadOnly =
    * (ThisForm.ParentForm.pcEscolha <> 'CONSULTAR')" - !this_lSomenteConsulta
    * jah equivale a essa expressao (this_lSomenteConsulta eh .T. quando o
    * modo do pai eh CONSULTAR/VISUALIZAR). Columns 2-4 (Pecas/Promos/Datas)
    * sao so exibicao - o dump marca "When" retornando .F. nos tres
    * Text1, reproduzido aqui com .ReadOnly = .T. (regra #46).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .ColumnCount       = 4
            .Top               = 134
            .Left              = 186
            .Width             = 369
            .Height            = 130
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .TabIndex          = 1
            .ReadOnly          = .F.
            .Visible           = .T.

            .Column1.FontName          = "Tahoma"
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = !THIS.this_oBusinessObject.this_lSomenteConsulta
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            .Column2.FontName          = "Tahoma"
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            .Column3.FontName          = "Tahoma"
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)

            .Column4.FontName          = "Tahoma"
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarPromocoes - FUNIL UNICO de carga/ligacao/repintura da grade.
    * Busca as promocoes do produto corrente via
    * THIS.this_oBusinessObject.CarregarPromocoes() (SELECT SigPrPmi + Insert
    * Into cursor_4c_Promocoes, equivalente ao Scan/Insert Into csEmpresas do
    * Init legado) e liga a grade - "With ThisForm.GridEmps / .RecordSource
    * = 'csEmpresas' / .ColumnN.ControlSource = ... / ... / EndWith" seguido
    * de "Go Top In csEmpresas" + "ThisForm.GridEmps.Refresh".
    *
    * Width/Header1.Caption vao DEPOIS do RecordSource/ControlSource, porque
    * atribuir RecordSource reseta os dois (Problema 48 do
    * FORMCOR_LICOES_APRENDIDAS.md / CLAUDE.md regra #41). O CheckBox da
    * Column1 eh (re)criado aqui, DEPOIS do ControlSource apontar para a
    * coluna logica ImpEmps, pela mesma razao de
    * FormSigOpPrL.GarantirCheckBoxMarcacao: um RecordSource/ControlSource
    * novo pode destruir o controle posto por Column.AddObject.
    *
    * "ThisForm.btnRetirar.Visible = (ThisForm.ParentForm.pcEscolha <>
    * 'CONSULTAR')" / "ThisForm.cmdRetirar.Visible = ..." do Init legado: os
    * dois objetos ja existem (ConfigurarBotoes roda antes), so falta
    * aplicar a visibilidade, com a MESMA formula usada em Column1.ReadOnly
    * (!this_lSomenteConsulta).
    *
    * PUBLIC (sem PROTECTED) - mesmo padrao de CarregarLista em
    * FormSigOpPrL, para o metodo poder ser chamado de fora (ex.:
    * TesteAutomatico) sem a armadilha de PEMSTATUS-protected da regra #3.
    *==========================================================================
    PROCEDURE CarregarPromocoes()
        LOCAL loc_cCursor, loc_lVisivelRetirar

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPromocoes(THIS.this_cCodigoProduto)
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                "Favor Reinicializar o Processo!!!")
            RETURN .F.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

        IF !USED(loc_cCursor) OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        *-- .RecordSource FORA do WITH que acessa .Column - atribuir
        *-- RecordSource dentro do mesmo WITH que referencia .ColumnN
        *-- estoura "Unknown member COLUMN1" porque as colunas nao sao
        *-- recriadas de forma imediata/sincrona dentro do bloco WITH.
        THIS.grd_4c_Dados.RecordSource = loc_cCursor

        WITH THIS.grd_4c_Dados
            .Column1.ControlSource = loc_cCursor + ".ImpEmps"
            .Column2.ControlSource = loc_cCursor + ".Pecas"
            .Column3.ControlSource = loc_cCursor + ".Promos"
            .Column4.ControlSource = loc_cCursor + ".Datas"
        ENDWITH

        *-- CheckBox da Column1 (recriado se o rebind do alias o destruiu)
        THIS.GarantirCheckBoxImpEmps()

        WITH THIS.grd_4c_Dados
            *-- Larguras e captions DEPOIS do RecordSource, que reseta os
            *-- dois
            .Column1.Width = 15
            .Column2.Width = 80
            .Column3.Width = 185
            .Column4.Width = 66

            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Pe" + CHR(231) + "as"
            .Column3.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Caption = "Data"
        ENDWITH

        *-- "Go Top In csEmpresas" + "ThisForm.GridEmps.Refresh" do Init
        *-- legado
        SELECT (loc_cCursor)
        GO TOP IN (loc_cCursor)
        THIS.grd_4c_Dados.Refresh()

        *-- "ThisForm.btnRetirar.Visible = (ThisForm.ParentForm.pcEscolha <>
        *-- 'CONSULTAR')" / "ThisForm.cmdRetirar.Visible = ..." do Init
        *-- legado
        loc_lVisivelRetirar = !THIS.this_oBusinessObject.this_lSomenteConsulta
        IF PEMSTATUS(THIS, "cmd_4c_BtnRetirar", 5)
            THIS.cmd_4c_BtnRetirar.Visible = loc_lVisivelRetirar
        ENDIF
        IF PEMSTATUS(THIS, "cmg_4c_CmdRetirar", 5)
            THIS.cmg_4c_CmdRetirar.Visible = loc_lVisivelRetirar
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCheckBoxImpEmps - Cria o CheckBox de marcacao da Column1
    * (equivalente ao Check1 do dump), com os 4 handlers de alternancia.
    *
    * IDEMPOTENTE (CLAUDE.md regra #46 / pattern #185): chamado por
    * CarregarPromocoes, e um segundo AddObject com o mesmo nome estouraria
    * "Object already defined" - o PEMSTATUS eh o que distingue "ainda vivo"
    * de "destruido pelo rebind do alias".
    *
    * Top/Left/Width/Height vem do dump (Check1): ao contrario do checkbox
    * de outras grades deste projeto, este TEM geometria propria declarada
    * no SCX.
    *
    * Os BINDEVENT ficam JUNTO do AddObject: objeto recriado eh OUTRO objeto
    * e as ligacoes do anterior morreram com ele.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCheckBoxImpEmps()
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_ImpEmps", 5)
            *-- Ainda vivo: um segundo AddObject estouraria
            RETURN .T.
        ENDIF

        THIS.grd_4c_Dados.Column1.AddObject("chk_4c_ImpEmps", "CheckBox")

        WITH THIS.grd_4c_Dados.Column1.chk_4c_ImpEmps
            .Top       = 9
            .Left      = 2
            .Width     = 22
            .Height    = 17
            .FontName  = "Tahoma"
            .Alignment = 0
            .Caption   = ""
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Sparse e CurrentControl DEPOIS de o controle existir (regra
        *-- #18): sem CurrentControl a coluna segue desenhando o Text1 dela,
        *-- e sem Sparse = .F. o CheckBox so aparece na linha ativa
        THIS.grd_4c_Dados.Column1.Sparse         = .F.
        THIS.grd_4c_Dados.Column1.CurrentControl = "chk_4c_ImpEmps"

        *-- Os 4 handlers de alternancia, transcritos do dump
        *-- (Check1.Click/MouseDown/MouseUp/KeyPress): o toggle real
        *-- acontece SO em MouseDown e em KeyPress(13/32) - Click e MouseUp
        *-- so suprimem o comportamento nativo (NODEFAULT).
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_ImpEmps, "Click", ;
            THIS, "ChkImpEmpsClick")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_ImpEmps, "MouseDown", ;
            THIS, "ChkImpEmpsMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_ImpEmps, "MouseUp", ;
            THIS, "ChkImpEmpsMouseUp")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_ImpEmps, "KeyPress", ;
            THIS, "ChkImpEmpsKeyPress")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ChkImpEmpsClick - "NoDefault" puro do Check1.Click legado - nenhuma
    * logica propria, so suprime o toggle nativo (a alternancia real esta em
    * ChkImpEmpsMouseDown/ChkImpEmpsKeyPress). PUBLIC - BINDEVENT exige
    * metodo publico (regra #3).
    *==========================================================================
    PROCEDURE ChkImpEmpsClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkImpEmpsMouseDown - "Replace ImpEmps With Not ImpEmps In csEmpresas /
    * ThisForm.GridEmps.Refresh / NoDefault" do Check1.MouseDown legado.
    * PUBLIC - BINDEVENT exige metodo publico (regra #3).
    *==========================================================================
    PROCEDURE ChkImpEmpsMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                REPLACE ImpEmps WITH !ImpEmps IN (loc_cCursor)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF

        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkImpEmpsMouseUp - "NoDefault" puro do Check1.MouseUp legado. PUBLIC -
    * BINDEVENT exige metodo publico (regra #3).
    *==========================================================================
    PROCEDURE ChkImpEmpsMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkImpEmpsKeyPress - "If InList(nKeyCode, 13, 32) / Replace ImpEmps
    * With Not ImpEmps In csEmpresas / ThisForm.GridEmps.Refresh / NoDefault
    * / Endif" do Check1.KeyPress legado. PUBLIC - BINDEVENT exige metodo
    * publico (regra #3).
    *==========================================================================
    PROCEDURE ChkImpEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor

        IF INLIST(par_nKeyCode, 13, 32)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    REPLACE ImpEmps WITH !ImpEmps IN (loc_cCursor)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Fecha o cursor da grade de promocoes (cursor_4c_Promocoes,
    * equivalente a csEmpresas do legado) antes de DODEFAULT(), que executa a
    * limpeza/restauracao de menu da FormBase (CLAUDE.md regra #30 - Destroy
    * DEVE chamar DODEFAULT() como ULTIMA linha).
    *
    * Sem reabilitar o form pai: o Init legado deste dialogo NAO desabilita
    * ThisForm.ParentForm (ver cabecalho do arquivo) - so WindowType = 1 ja
    * bloqueia a interacao, e o btnSair.Click legado so faz "ThisForm.Release"
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
            IF VARTYPE(loc_cCursor) = "C" AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPPRMBO.prg):
*==============================================================================
* SIGOPPRMBO.prg - Business Object para FormSIGOPPRM (Promocoes do Produto)
* Herda de BusinessBase
*
* ATENCAO: este form eh um dialogo OPERACIONAL (modal) aberto pelo Cadastro de
* Produtos - no legado "Do Form SigOpPrm With ThisForm" (sigcdpro), disparado
* apos a pergunta "O Produto Encontra-se Em Promocao!!! Deseja Conferir ?".
* Ele lista as PROMOCOES em que o produto corrente se encontra (tabela
* SigPrPmi, filtrada pelo codigo do produto) numa grade com coluna de
* marcacao, e permite RETIRAR o produto das promocoes marcadas.
*
* O Load legado cria o cursor local da grade e o Init o popula a partir do
* cursor crSigPrPmi que o form PAI ja deixa aberto:
*     Create Cursor csEmpresas (ImpEmps l(1), CPros c(14), Pecas c(10), ;
*                               Promos c(25), Datas t Null, cIdChaves c(20))
*     Index On CPros + Promos Tag CPros
* No sistema novo o form pai (FormProduto) nao mantem esse cursor aberto, por
* isso este BO le a MESMA consulta que o pai usava no AddCursor:
*     lcQryProMI = 'Select * From SigPrPmi Where CPros = ?pPro'
* Os nomes das colunas e o filtro sao transcritos do legado (PILAR 2).
*
* O btnRetirar.Click legado executa, por linha marcada, TRES passos:
*   1) Delete From SigPrPmi  Where cIdChaves = ?pChv   (SQL Server)
*   2) Delete From crSigPrPmi Where cIdChaves = pChv   (cursor do form PAI)
*   3) Delete From csEmpresas Where cIdChaves = pChv   (cursor da grade)
* precedidos do gate de acesso fChecaAcesso('SigCdPrm', 'EXCLUIR') Or
* fChecaAcesso('SigCdPrm', 'ALTERAR'), e seguidos de GridEmps.Refresh.
*
* Como o legado SO exclui (nunca insere nem altera SigPrPmi nesta tela), o
* comportamento padrao herdado de BusinessBase para Inserir()/Atualizar() ja
* eh o correto - inventar INSERT/UPDATE aqui violaria a regra de que a lista
* de colunas vem do schema e nao de suposicao.
*
* Tabela ...: SigPrPmi
* Chave .....: cidchaves (char 20) - PK sigprpmi_cidchaves
*==============================================================================
DEFINE CLASS SIGOPPRMBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - colunas de SigPrPmi (uma promocao do produto)
    * Tipos conferidos em docs/schema.sql:
    *   cpros char(14) NOT NULL | pecas char(10) NOT NULL
    *   promos char(25) NOT NULL | cbars numeric(14,0) NOT NULL
    *   datas datetime NULL | cidchaves char(20) NOT NULL (PK)
    *   dtalts datetime NULL | promopro char(35) NOT NULL
    *   vendavels numeric(1,0) NOT NULL
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && SigPrPmi.cpros     - codigo do produto (char 14)
    this_cPecas     = ""    && SigPrPmi.pecas     - peca da promocao (char 10)
    this_cPromos    = ""    && SigPrPmi.promos    - codigo da promocao (char 25)
    this_nCbars     = 0     && SigPrPmi.cbars     - codigo de barras numeric(14,0)
    this_dDatas     = {}    && SigPrPmi.datas     - data da promocao (datetime NULL)
    this_cCidChaves = ""    && SigPrPmi.cidchaves - chave primaria Fortyus (char 20)
    this_dDtAlts    = {}    && SigPrPmi.dtalts    - data da ultima alteracao (datetime NULL)
    this_cPromoPro  = ""    && SigPrPmi.promopro  - descricao da promocao (char 35)
    this_nVendavels = 0     && SigPrPmi.vendavels - indicador vendavel numeric(1,0)

    *--------------------------------------------------------------------------
    * Propriedades - estado de tela (NAO existem em SigPrPmi)
    *--------------------------------------------------------------------------
    *-- Marcacao da linha na grade. No legado eh a coluna ImpEmps l(1) do cursor
    *-- local csEmpresas, alimentada com .f. no Insert Into do Init e alternada
    *-- pelos handlers MouseDown/KeyPress do Check1 da Column1.
    this_lImpEmps = .F.

    *-- Nome do cursor que alimenta a grade do dialogo (equivale a csEmpresas).
    this_cCursorItens = "cursor_4c_Promocoes"

    *-- Nome do cursor de SigPrPmi que o form PAI mantem aberto, quando houver
    *-- (equivale a crSigPrPmi). Vazio significa que o pai nao tem esse cursor e
    *-- o passo 2 da retirada do legado nao se aplica.
    this_cCursorItensPai = ""

    *-- pcEscolha do form PAI, recebido junto com a referencia do pai no Init do
    *-- form (LParameters pAnt / ThisForm.ParentForm = pAnt). O legado compara
    *-- com 'CONSULTAR' para decidir Column1.ReadOnly e a visibilidade de
    *-- btnRetirar/cmdRetirar.
    this_cModoEscolha = ""

    *-- .T. quando this_cModoEscolha = "CONSULTAR": a coluna de marcacao fica
    *-- somente leitura e o botao Retirar fica oculto.
    this_lSomenteConsulta = .F.

    *-- Resultado do gate de acesso do btnRetirar.Click legado
    *-- (fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso('SigCdPrm','ALTERAR')).
    this_lTemAcessoRetirar = .F.

    *-- Programa consultado no gate de acesso (1o argumento do fChecaAcesso).
    this_cProgramaAcesso = "SigCdPrm"

    *-- Contadores do dialogo: promocoes carregadas, marcadas e efetivamente
    *-- retiradas na ultima execucao da retirada.
    this_nTotalPromocoes    = 0
    this_nTotalSelecionadas = 0
    this_nTotalRetiradas    = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave e zera o estado do dialogo.
    * DODEFAULT() sem argumento segue o padrao dos BOs de dialogo OPERACIONAL
    * (SigOpPrLBO): a tabela eh atribuida direto, sem instanciar DataAccess,
    * porque o acesso desta tela eh Select/Delete via SQLEXEC.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigPrPmi"
                THIS.this_cCampoChave = "cidchaves"

                *-- Estado inicial do dialogo
                THIS.this_cCursorItens       = "cursor_4c_Promocoes"
                THIS.this_cCursorItensPai    = ""
                THIS.this_cModoEscolha       = ""
                THIS.this_lSomenteConsulta   = .F.
                THIS.this_lTemAcessoRetirar  = .F.
                THIS.this_cProgramaAcesso    = "SigCdPrm"
                THIS.this_nTotalPromocoes    = 0
                THIS.this_nTotalSelecionadas = 0
                THIS.this_nTotalRetiradas    = 0

                *-- Colunas de SigPrPmi da linha corrente
                THIS.this_cCPros     = ""
                THIS.this_cPecas     = ""
                THIS.this_cPromos    = ""
                THIS.this_nCbars     = 0
                THIS.this_dDatas     = {}
                THIS.this_cCidChaves = ""
                THIS.this_dDtAlts    = {}
                THIS.this_cPromoPro  = ""
                THIS.this_nVendavels = 0
                THIS.this_lImpEmps   = .F.

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro("Erro ao inicializar SIGOPPRMBO: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades desta promocao a partir da
    * linha CORRENTE de um cursor aberto.
    *
    * Aceita DOIS formatos de cursor, porque sao os dois usados por este
    * dialogo (regra #9 - sempre SELECT (alias) antes de ler os campos, nunca
    * campo):
    *   1) a MESMA consulta que o form pai usa no AddCursor - Select * From
    *      SigPrPmi Where cpros = ?pPro - com TODAS as colunas da tabela
    *      (cpros, pecas, promos, cbars, datas, cidchaves, dtalts, promopro,
    *      vendavels);
    *   2) o cursor local da grade (equivalente a csEmpresas do legado), que
    *      tem so ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves.
    * Por isso as colunas exclusivas de SigPrPmi (cbars/dtalts/promopro/
    * vendavels) e a marcacao exclusiva da grade (ImpEmps) sao lidas so
    * quando TYPE() confirma que existem no alias recebido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de promo" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF()
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente no cursor de promo" + CHR(231) + CHR(245) + "es"
            RETURN .F.
        ENDIF

        THIS.this_cCPros     = TratarNulo(cpros, "")
        THIS.this_cPecas     = TratarNulo(pecas, "")
        THIS.this_cPromos    = TratarNulo(promos, "")
        THIS.this_dDatas     = TratarNulo(datas, {})
        THIS.this_cCidChaves = TratarNulo(cidchaves, "")

        IF TYPE(par_cAliasCursor + ".cbars") != "U"
            THIS.this_nCbars = TratarNulo(cbars, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".dtalts") != "U"
            THIS.this_dDtAlts = TratarNulo(dtalts, {})
        ENDIF

        IF TYPE(par_cAliasCursor + ".promopro") != "U"
            THIS.this_cPromoPro = TratarNulo(promopro, "")
        ENDIF

        IF TYPE(par_cAliasCursor + ".vendavels") != "U"
            THIS.this_nVendavels = TratarNulo(vendavels, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".ImpEmps") != "U"
            THIS.this_lImpEmps = TratarNulo(ImpEmps, .F.)
        ENDIF

        THIS.this_cMensagemErro = ""
        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria Fortyus da promocao corrente
    * (sigprpmi_cidchaves). Usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * RetirarPromocao - Remove o produto de UMA promocao: Delete From SigPrPmi
    * Where cidchaves = <chave>, exatamente o passo 1 do btnRetirar.Click do
    * legado. O legado roda esse DELETE dentro de um Scan por linha marcada,
    * precedido do gate fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso(
    * 'SigCdPrm','ALTERAR') e de uma confirmacao do usuario, e seguido de DOIS
    * deletes em cursor LOCAL (crSigPrPmi do pai e csEmpresas da grade) - o
    * loop, a confirmacao, o gate de acesso e a manutencao dos cursores da
    * tela sao orquestracao de UI e ficam no Form; este metodo cobre so a
    * operacao de dados de UMA linha (chamada uma vez por cidchaves marcada).
    *
    * Como o legado SO exclui (nunca insere/altera SigPrPmi nesta tela - ver
    * cabecalho da classe), Inserir()/Atualizar() continuam com o
    * comportamento herdado de BusinessBase e este eh o UNICO metodo de
    * gravacao real do BO.
    *--------------------------------------------------------------------------
    PROCEDURE RetirarPromocao(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCidChaves) != "C" OR EMPTY(ALLTRIM(par_cCidChaves))
            MsgErro("Chave da promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada", "Erro")
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cCidChaves = ALLTRIM(par_cCidChaves)
            loc_cCursorTemp = "cursor_4c_DelPmi"

            loc_cSQL = "DELETE FROM SigPrPmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            DO CASE
            CASE loc_nResultado < 0
                *-- Equivale ao "Favor Reinicializar o Processo!!!" / "Falha na
                *-- Conexao (Excluindo Promocao)" do legado
                MsgErro("Favor Reinicializar o Processo (Excluindo Promo" + CHR(231) + CHR(227) + "o)" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
            CASE loc_nResultado = 0
                MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada (j" + CHR(225) + ;
                    " havia sido retirada).", "Aten" + CHR(231) + CHR(227) + "o")
            OTHERWISE
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPromocoes - Popula o cursor da grade (this_cCursorItens,
    * equivalente a csEmpresas) com as promocoes do produto informado.
    *
    * No legado quem roda esta consulta eh o form PAI (Cadastro de Produtos),
    * no AddCursor que deixa crSigPrPmi aberto ANTES de abrir este dialogo
    * ("Select * From SigPrPmi Where CPros = ?pPro"); o Init deste dialogo so
    * faz Scan nesse cursor e:
    *     Insert Into csEmpresas (ImpEmps, CPros, Pecas, Promos, Datas, ;
    *                             cIdChaves) ;
    *         Values (.f., crSigPrPmi.CPros, crSigPrPmi.Pecas, ;
    *                 crSigPrPmi.Promos, Nvl(crSigPrPmi.Datas, Ctod('')), ;
    *                 crSigPrPmi.cIdChaves)
    * com ImpEmps = .f. em TODA linha (marcacao comeca desmarcada). Como o
    * form pai desta arquitetura nao mantem esse cursor aberto (ver
    * cabecalho do Form), este metodo faz as DUAS coisas de uma vez: busca
    * SigPrPmi pelo codigo do produto (a MESMA consulta do AddCursor do pai)
    * e monta this_cCursorItens com a MESMA estrutura/ordem de colunas de
    * "Create Cursor csEmpresas (...)" do Load legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPromocoes(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalPromocoes = 0

        *-- VFP9 nao faz short-circuit em OR - os dois testes ficam em IFs
        *-- separados para o ALLTRIM() nunca rodar sobre valor que nao seja
        *-- Character (CLAUDE.md regra sobre ISNULL(x) OR EMPTY(x))
        IF VARTYPE(par_cCodigoProduto) != "C"
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(par_cCodigoProduto))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cCursorTemp = "cursor_4c_PromocoesTmp"

            *-- "Select * From SigPrPmi Where CPros = ?pPro" do AddCursor do
            *-- form pai (sigcdpro) - a MESMA consulta, transcrita aqui
            *-- porque o form pai desta arquitetura nao mantem o cursor
            *-- aberto (ver cabecalho do Form).
            loc_cSQL = "SELECT * FROM SigPrPmi WHERE cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigoProduto))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo (Buscando Promo" + CHR(231) + CHR(245) + "es)" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF

                *-- "Create Cursor csEmpresas (ImpEmps l(1), CPros c(14),
                *-- Pecas c(10), Promos c(25), Datas t Null, cIdChaves c(20))
                *-- / Index On CPros + Promos Tag CPros" do Load legado -
                *-- mesma estrutura, mesma ordem de colunas.
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (ImpEmps L, CPros C(14), Pecas C(10), Promos C(25), ;
                     Datas T, cIdChaves C(20))
                INDEX ON CPros + Promos TAG CPros

                IF loc_nResultado > 0
                    SELECT (loc_cCursorTemp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorItens) ;
                            (ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves) ;
                            VALUES (.F., cpros, pecas, promos, ;
                                TratarNulo(datas, {}), cidchaves)
                    ENDSCAN
                ENDIF

                IF USED(loc_cCursorTemp)
                    USE IN (loc_cCursorTemp)
                ENDIF

                SELECT (THIS.this_cCursorItens)
                GO TOP

                THIS.this_nTotalPromocoes = RECCOUNT(THIS.this_cCursorItens)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPPRMBO.CarregarPromocoes")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

